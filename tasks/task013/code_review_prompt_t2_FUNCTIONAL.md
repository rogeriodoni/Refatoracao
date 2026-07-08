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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (12589 linhas total):

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

*-- Linhas 3300 a 3769:
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
3435:         LOCAL loc_i, loc_oCtrl, loc_cNome
3436:         LOCAL loc_j, loc_lPrefixoValido
3437:         LOCAL loc_aPrefixos(8)
3438:         loc_aPrefixos(1) = "cnt_"
3439:         loc_aPrefixos(2) = "txt_"
3440:         loc_aPrefixos(3) = "lbl_"
3441:         loc_aPrefixos(4) = "cmd_"
3442:         loc_aPrefixos(5) = "chk_"
3443:         loc_aPrefixos(6) = "cmb_"
3444:         loc_aPrefixos(7) = "grd_"
3445:         loc_aPrefixos(8) = "pgf_"
3446: 
3447:         IF VARTYPE(par_oContainer) # "O"
3448:             RETURN
3449:         ENDIF
3450: 
3451:         FOR loc_i = 1 TO par_oContainer.ControlCount
3452:             loc_oCtrl         = par_oContainer.Controls(loc_i)
3453:             loc_cNome         = loc_oCtrl.Name
3454:             loc_lPrefixoValido = .F.
3455: 
3456:             FOR loc_j = 1 TO 8
3457:                 IF LEFT(loc_cNome, 4) = loc_aPrefixos(loc_j)
3458:                     loc_lPrefixoValido = .T.
3459:                     EXIT
3460:                 ENDIF
3461:             ENDFOR
3462: 
3463:             IF loc_lPrefixoValido
3464:                 *-- Nao forcar Visible=.T. em containers (cnt_) que estao intencionalmente ocultos
3465:                 IF LEFT(loc_cNome, 4) = "cnt_" AND !loc_oCtrl.Visible
3466:                     *-- Container oculto por design - pular
3467:                 ELSE
3468:                     loc_oCtrl.Visible = .T.
3469:                     IF loc_oCtrl.ControlCount > 0
3470:                         THIS.TornarControlesVisiveis(loc_oCtrl)
3471:                     ENDIF
3472:                 ENDIF
3473:             ENDIF
3474:         ENDFOR
3475:     ENDPROC
3476: 
3477:     *--------------------------------------------------------------------------
3478:     * FormatarGridLista - Aplica formatacao padrao ao grid de lista
3479:     *--------------------------------------------------------------------------
3480:     PROCEDURE FormatarGridLista(par_oGrid)
3481: 
3482:         IF VARTYPE(par_oGrid) # "O"
3483:             RETURN
3484:         ENDIF
3485: 
3486:         WITH par_oGrid
3487:             .FontName           = "Verdana"
3488:             .FontSize           = 8
3489:             .GridLines          = 3
3490:             .GridLineWidth      = 1
3491:             .GridLineColor      = RGB(238, 238, 238)
3492:             .RecordMark         = .F.
3493:             .DeleteMark         = .F.
3494:             .AllowRowSizing     = .F.
3495:             .ReadOnly           = .T.
3496:             .BackColor          = RGB(255, 255, 255)
3497:             .ForeColor          = RGB(90, 90, 90)
3498:             .HighlightBackColor = RGB(255, 255, 255)
3499:             .HighlightForeColor = RGB(15, 41, 104)
3500:             .HighlightStyle     = 2
3501:             .RowHeight          = 16
3502:             .ScrollBars         = 2
3503:         ENDWITH
3504:     ENDPROC
3505: 
3506:     *--------------------------------------------------------------------------
3507:     * BtnIncluirClick - Incluir novo produto
3508:     *--------------------------------------------------------------------------
3509:     PROCEDURE BtnIncluirClick()
3510:         LOCAL loc_lResultado
3511:         loc_lResultado = .F.
3512: 
3513:         TRY
3514:             THIS.this_oBusinessObject.NovoRegistro()
3515:             THIS.LimparCampos()
3516:             THIS.this_cModoAtual = "INCLUIR"
3517:             THIS.HabilitarCampos(.T.)
3518:             THIS.AjustarBotoesPorModo()
3519:             THIS.AlternarPagina(2)
3520:             loc_lResultado = .T.
3521:         CATCH TO loc_oErro
3522:             MsgErro(loc_oErro.Message, "Erro ao incluir produto")
3523:         ENDTRY
3524: 
3525:         RETURN loc_lResultado
3526:     ENDPROC
3527: 
3528:     *--------------------------------------------------------------------------
3529:     * BtnVisualizarClick - Visualizar produto selecionado
3530:     *--------------------------------------------------------------------------
3531:     PROCEDURE BtnVisualizarClick()
3532:         LOCAL loc_cCodigo, loc_lResultado
3533:         loc_lResultado = .F.
3534: 
3535:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3536:             MsgAviso("Nenhum registro selecionado!")
3537:             RETURN .F.
3538:         ENDIF
3539: 
3540:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
3541: 
3542:         TRY
3543:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3544:                 THIS.BOParaForm()
3545:                 THIS.this_cModoAtual = "VISUALIZAR"
3546:                 THIS.HabilitarCampos(.F.)
3547:                 THIS.AjustarBotoesPorModo()
3548:                 THIS.AlternarPagina(2)
3549:                 loc_lResultado = .T.
3550:             ENDIF
3551:         CATCH TO loc_oErro
3552:             MsgErro(loc_oErro.Message, "Erro ao visualizar produto")
3553:         ENDTRY
3554: 
3555:         RETURN loc_lResultado
3556:     ENDPROC
3557: 
3558:     *--------------------------------------------------------------------------
3559:     * BtnAlterarClick - Alterar produto selecionado
3560:     *--------------------------------------------------------------------------
3561:     PROCEDURE BtnAlterarClick()
3562:         LOCAL loc_cCodigo, loc_lResultado
3563:         loc_lResultado = .F.
3564: 
3565:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3566:             MsgAviso("Nenhum registro selecionado!")
3567:             RETURN .F.
3568:         ENDIF
3569: 
3570:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
3571: 
3572:         TRY
3573:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3574:                 THIS.this_oBusinessObject.EditarRegistro()
3575:                 THIS.BOParaForm()
3576:                 THIS.this_cModoAtual = "ALTERAR"
3577:                 THIS.HabilitarCampos(.T.)
3578:                 THIS.AjustarBotoesPorModo()
3579:                 THIS.AlternarPagina(2)
3580:                 loc_lResultado = .T.
3581:             ENDIF
3582:         CATCH TO loc_oErro
3583:             MsgErro(loc_oErro.Message, "Erro ao alterar produto")
3584:         ENDTRY
3585: 
3586:         RETURN loc_lResultado
3587:     ENDPROC
3588: 
3589:     *--------------------------------------------------------------------------
3590:     * BtnExcluirClick - Excluir produto selecionado
3591:     * Legado: verifica uso em outros registros antes de excluir
3592:     *--------------------------------------------------------------------------
3593:     PROCEDURE BtnExcluirClick()
3594:         LOCAL loc_cCodigo, loc_cDescricao, loc_lResultado
3595:         loc_lResultado = .F.
3596: 
3597:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3598:             MsgAviso("Nenhum registro selecionado!")
3599:             RETURN .F.
3600:         ENDIF
3601: 
3602:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
3603:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
3604: 
3605:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto:" + CHR(13) + loc_cCodigo + " - " + loc_cDescricao + "?")
3606:             TRY
3607:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3608:                     IF THIS.this_oBusinessObject.Excluir()
3609:                         MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
3610:                         THIS.CarregarLista()
3611:                         loc_lResultado = .T.
3612:                     ENDIF
3613:                 ENDIF
3614:             CATCH TO loc_oErro
3615:                 MsgErro(loc_oErro.Message, "Erro ao excluir produto")
3616:             ENDTRY
3617:         ENDIF
3618: 
3619:         RETURN loc_lResultado
3620:     ENDPROC
3621: 
3622:     *--------------------------------------------------------------------------
3623:     * BtnBuscarClick - Abre busca auxiliar de produtos
3624:     *--------------------------------------------------------------------------
3625:     PROCEDURE BtnBuscarClick()
3626:         LOCAL loc_oBusca
3627: 
3628:         TRY
3629:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
3630: 
3631:             loc_oBusca.mAddColuna("cpros", "", "Produto")
3632:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3633:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3634: 
3635:             loc_oBusca.Show()
3636: 
3637:             IF loc_oBusca.this_lSelecionou
3638:                 IF USED("cursor_4c_Busca")
3639:                     LOCAL loc_cCodigo
3640:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
3641: 
3642:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3643:                         THIS.BOParaForm()
3644:                         THIS.this_cModoAtual = "VISUALIZAR"
3645:                         THIS.HabilitarCampos(.F.)
3646:                         THIS.AlternarPagina(2)
3647:                     ENDIF
3648:                 ENDIF
3649:             ENDIF
3650: 
3651:             IF USED("cursor_4c_Busca")
3652:                 USE IN cursor_4c_Busca
3653:             ENDIF
3654:             loc_oBusca.Release()
3655: 
3656:         CATCH TO loException
3657:             MostrarErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3658:         ENDTRY
3659:     ENDPROC
3660: 
3661:     *--------------------------------------------------------------------------
3662:     * BtnEncerrarClick - Fechar o formulario
3663:     *--------------------------------------------------------------------------
3664:     PROCEDURE BtnEncerrarClick()
3665:         THIS.Release()
3666:     ENDPROC
3667: 
3668:     *--------------------------------------------------------------------------
3669:     * BtnSalvarClick - Salvar produto
3670:     * Valida campos obrigatorios, transfere Form->BO e chama Salvar()
3671:     *--------------------------------------------------------------------------
3672:     PROCEDURE BtnSalvarClick()
3673:         LOCAL loc_lResultado, loc_oPg, loc_cCpro, loc_cDpro
3674:         loc_lResultado = .F.
3675: 
3676:         *-- Validacoes FORA do TRY (VFP9: nunca RETURN dentro de TRY/CATCH)
3677:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3678:             RETURN .F.
3679:         ENDIF
3680:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3681:         loc_cCpro = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
3682:         loc_cDpro = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
3683: 
3684:         IF EMPTY(loc_cCpro)
3685:             MsgAviso("C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio!", "Valida" + CHR(231) + CHR(227) + "o")
3686:             loc_oPg.txt_4c_Cpro.SetFocus()
3687:             RETURN .F.
3688:         ENDIF
3689: 
3690:         IF EMPTY(loc_cDpro)
3691:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o do produto obrigat" + CHR(243) + "ria!", "Valida" + CHR(231) + CHR(227) + "o")
3692:             loc_oPg.txt_4c_Dpro.SetFocus()
3693:             RETURN .F.
3694:         ENDIF
3695: 
3696:         TRY
3697:             THIS.FormParaBO()
3698: 
3699:             IF THIS.this_oBusinessObject.Salvar()
3700:                 MsgSucesso("Produto salvo com sucesso!")
3701:                 THIS.this_cModoAtual = "LISTA"
3702:                 THIS.AjustarBotoesPorModo()
3703:                 THIS.AlternarPagina(1)  && AlternarPagina(1) ja chama CarregarLista()
3704:                 loc_lResultado = .T.
3705:             ENDIF
3706:             *-- Erros de validacao: exibidos por ValidarDados() via MsgAviso (form permanece em Dados)
3707:             *-- Erros de BD: exibidos por Inserir/Atualizar via MsgErro (form permanece em Dados)
3708: 
3709:         CATCH TO loc_oErro
3710:             MsgErro("Erro ao salvar produto:" + CHR(13) + "Linha: " + ;
3711:                 TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro")
3712:         ENDTRY
3713: 
3714:         RETURN loc_lResultado
3715:     ENDPROC
3716: 
3717:     *--------------------------------------------------------------------------
3718:     * BtnCancelarClick - Cancelar operacao
3719:     *--------------------------------------------------------------------------
3720:     PROCEDURE BtnCancelarClick()
3721:         THIS.this_cModoAtual = "LISTA"
3722:         THIS.AlternarPagina(1)
3723:         THIS.CarregarLista()
3724:     ENDPROC
3725: 
3726:     *--------------------------------------------------------------------------
3727:     * FormParaBO - Transfere dados do Form para o BO (campos pgDados Fase 5)
3728:     *--------------------------------------------------------------------------
3729:     PROTECTED PROCEDURE FormParaBO()
3730:         LOCAL loc_oPg
3731:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3732: 
3733:         WITH THIS.this_oBusinessObject
3734:             .this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
3735:             .this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
3736:             .this_nSituas   = loc_oPg.obj_4c_Opc_situacao.Value
3737:             .this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
3738:             .this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)
3739:             .this_nCbars    = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)
3740:             .this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
3741:             .this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Merc.Value)
3742:             .this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_IdeCPros.Value)
3743:             .this_nEan13    = ALLTRIM(loc_oPg.txt_4c_EAN13.Value)
3744:             .this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
3745:             .this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
3746:             .this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
3747:             .this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Col.Value)
3748:             .this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
3749:             .this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Refs.Value)
3750:             *-- Fase 6: campos adicionais
3751:             .this_cCodfinp    = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
3752:             .this_cCodacbs    = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
3753:             .this_cCclass     = ALLTRIM(loc_oPg.txt_4c_Class.Value)
3754:             .this_cLocals     = ALLTRIM(loc_oPg.txt_4c_Local.Value)
3755:             .this_nPesobs     = ALLTRIM(loc_oPg.txt_4c_PesoBs.Value)
3756:             .this_nPesoms     = ALLTRIM(loc_oPg.txt_4c_Pmedio.Value)
3757:             .this_cCunis      = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
3758:             .this_cCunips     = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
3759:             .this_cCodident   = ALLTRIM(loc_oPg.txt_4c_CodIdent.Value)
3760:             .this_nTents      = ALLTRIM(loc_oPg.txt_4c_TEnts.Value)
3761:             .this_lConsigs    = (loc_oPg.chk_4c_Consig.Value = 1)
3762:             .this_lFabrproprs = (loc_oPg.chk_4c_FabrProprs.Value = 1)
3763:             .this_lEncoms     = (loc_oPg.chk_4c_Encoms.Value = 1)
3764:             .this_nTamps      = ALLTRIM(loc_oPg.txt_4c_Tamps.Value)
3765:             .this_nTamhs      = ALLTRIM(loc_oPg.txt_4c_Tamhs.Value)
3766:             .this_nTamls      = ALLTRIM(loc_oPg.txt_4c_Tamls.Value)
3767:             .this_nVolumes    = ALLTRIM(loc_oPg.txt_4c_Volumes.Value)
3768:             .this_cDsccompras = loc_oPg.edt_4c_DscCompras.Value
3769:             .this_cDpro3s     = loc_oPg.edt_4c_DPro3s.Value

*-- Linhas 3788 a 3831:
3788:     *--------------------------------------------------------------------------
3789:     * BOParaForm - Transfere dados do BO para o Form (campos pgDados Fase 5)
3790:     *--------------------------------------------------------------------------
3791:     PROTECTED PROCEDURE BOParaForm()
3792:         LOCAL loc_oPg
3793:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3794: 
3795:         WITH THIS.this_oBusinessObject
3796:             loc_oPg.txt_4c_Cpro.Value              = ALLTRIM(.this_cCpros)
3797:             loc_oPg.txt_4c_Dpro.Value              = ALLTRIM(.this_cDpros)
3798:             loc_oPg.obj_4c_Opc_situacao.Value      = IIF(.this_nSituas = 2, 2, 1)
3799:             loc_oPg.txt_4c_CProEq.Value            = ALLTRIM(.this_cCproeqs)
3800:             loc_oPg.txt_4c_DPro2s.Value            = ALLTRIM(.this_cDpro2s)
3801:             *-- cbars e ean13 sao numericos: converter para string de exibicao
3802:             loc_oPg.txt_4c_Cbar.Value              = IIF(.this_nCbars = 0, "", LTRIM(STR(.this_nCbars, 14, 0)))
3803:             loc_oPg.txt_4c_CgruP.Value             = ALLTRIM(.this_cCgrus)
3804:             loc_oPg.txt_4c_DgruP.Value             = ""
3805:             loc_oPg.txt_4c_Merc.Value              = ALLTRIM(.this_cMercs)
3806:             loc_oPg.txt_4c_IdeCPros.Value          = ALLTRIM(.this_cIdecpros)
3807:             loc_oPg.txt_4c_EAN13.Value             = IIF(.this_nEan13 = 0, "", LTRIM(STR(.this_nEan13, 13, 0)))
3808:             loc_oPg.txt_4c_CSGru.Value             = ALLTRIM(.this_cSgrus)
3809:             loc_oPg.txt_4c_DsGru.Value             = ""
3810:             loc_oPg.txt_4c_Conjunto.Value          = ALLTRIM(.this_cConjunts)
3811:             loc_oPg.txt_4c_Lin.Value               = ALLTRIM(.this_cLinhas)
3812:             loc_oPg.txt_4c_DLin.Value              = ""
3813:             loc_oPg.txt_4c_Col.Value               = ALLTRIM(.this_cColecoes)
3814:             loc_oPg.txt_4c_DCol.Value              = ""
3815:             loc_oPg.txt_4c_Ifor.Value              = ALLTRIM(.this_cIfors)
3816:             loc_oPg.txt_4c_Dfor.Value              = ""
3817:             loc_oPg.txt_4c_Refs.Value              = ALLTRIM(.this_cReffs)
3818:             *-- Fase 6: campos adicionais
3819:             loc_oPg.txt_4c_CodFinP.Value   = ALLTRIM(.this_cCodfinp)
3820:             loc_oPg.txt_4c_DFinP.Value     = ""
3821:             loc_oPg.txt_4c_CodAcb.Value    = ALLTRIM(.this_cCodacbs)
3822:             loc_oPg.txt_4c_DAcb.Value      = ""
3823:             loc_oPg.txt_4c_Class.Value     = ALLTRIM(.this_cCclass)
3824:             loc_oPg.txt_4c_DClass.Value    = ""
3825:             loc_oPg.txt_4c_Local.Value     = ALLTRIM(.this_cLocals)
3826:             loc_oPg.txt_4c_PesoBs.Value    = IIF(.this_nPesobs = 0, "", LTRIM(STR(.this_nPesobs, 10, 3)))
3827:             loc_oPg.txt_4c_Pmedio.Value    = IIF(.this_nPesoms = 0, "", LTRIM(STR(.this_nPesoms, 11, 3)))
3828:             loc_oPg.txt_4c_Estoques.Value  = ""
3829:             loc_oPg.txt_4c_QtdEsts.Value   = ""
3830:             *-- Custo/Venda/Fator (display only - readonly)
3831:             loc_oPg.txt_4c_Ctotal.Value    = IIF(.this_nCustofs = 0, "", LTRIM(STR(.this_nCustofs, 14, 5)))

*-- Linhas 3891 a 3934:
3891:     *--------------------------------------------------------------------------
3892:     * LimparCampos - Limpa todos os campos do formulario (pgDados Fase 5)
3893:     *--------------------------------------------------------------------------
3894:     PROTECTED PROCEDURE LimparCampos()
3895:         LOCAL loc_oPg
3896:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3897:             RETURN
3898:         ENDIF
3899:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3900:         IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
3901:             RETURN
3902:         ENDIF
3903: 
3904:         loc_oPg.txt_4c_Cpro.Value              = ""
3905:         loc_oPg.txt_4c_Dpro.Value              = ""
3906:         loc_oPg.obj_4c_Opc_situacao.Value      = 1
3907:         loc_oPg.txt_4c_CProEq.Value            = ""
3908:         loc_oPg.txt_4c_DPro2s.Value            = ""
3909:         loc_oPg.txt_4c_Cbar.Value              = ""
3910:         loc_oPg.txt_4c_CgruP.Value             = ""
3911:         loc_oPg.txt_4c_DgruP.Value             = ""
3912:         loc_oPg.txt_4c_Merc.Value              = ""
3913:         loc_oPg.txt_4c_IdeCPros.Value          = ""
3914:         loc_oPg.txt_4c_EAN13.Value             = ""
3915:         loc_oPg.txt_4c_CSGru.Value             = ""
3916:         loc_oPg.txt_4c_DsGru.Value             = ""
3917:         loc_oPg.txt_4c_Conjunto.Value          = ""
3918:         loc_oPg.txt_4c_Lin.Value               = ""
3919:         loc_oPg.txt_4c_DLin.Value              = ""
3920:         loc_oPg.txt_4c_Col.Value               = ""
3921:         loc_oPg.txt_4c_DCol.Value              = ""
3922:         loc_oPg.txt_4c_Ifor.Value              = ""
3923:         loc_oPg.txt_4c_Dfor.Value              = ""
3924:         loc_oPg.txt_4c_Refs.Value              = ""
3925: 
3926:         *-- Fase 6
3927:         IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
3928:             RETURN
3929:         ENDIF
3930:         loc_oPg.txt_4c_CodFinP.Value   = ""
3931:         loc_oPg.txt_4c_DFinP.Value     = ""
3932:         loc_oPg.txt_4c_CodAcb.Value    = ""
3933:         loc_oPg.txt_4c_DAcb.Value      = ""
3934:         loc_oPg.txt_4c_Class.Value     = ""

*-- Linhas 3981 a 4024:
3981:     *--------------------------------------------------------------------------
3982:     * HabilitarCampos - Habilita/desabilita campos conforme modo (Fase 5)
3983:     *--------------------------------------------------------------------------
3984:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3985:         LOCAL loc_oPg
3986:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3987:             RETURN
3988:         ENDIF
3989:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3990:         IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
3991:             RETURN
3992:         ENDIF
3993: 
3994:         *-- Codigo do produto: habilitado apenas em INCLUIR (PK nao pode mudar)
3995:         loc_oPg.txt_4c_Cpro.Enabled           = IIF(THIS.this_cModoAtual = "INCLUIR", par_lHabilitar, .F.)
3996:         loc_oPg.txt_4c_Dpro.Enabled           = par_lHabilitar
3997:         loc_oPg.obj_4c_Opc_situacao.Enabled   = par_lHabilitar
3998:         loc_oPg.txt_4c_CProEq.Enabled         = par_lHabilitar
3999:         loc_oPg.txt_4c_DPro2s.Enabled         = par_lHabilitar
4000:         loc_oPg.txt_4c_Cbar.Enabled           = par_lHabilitar
4001:         loc_oPg.txt_4c_CgruP.Enabled          = par_lHabilitar
4002:         loc_oPg.txt_4c_Merc.Enabled           = par_lHabilitar
4003:         loc_oPg.txt_4c_IdeCPros.Enabled       = par_lHabilitar
4004:         loc_oPg.txt_4c_EAN13.Enabled          = par_lHabilitar
4005:         loc_oPg.txt_4c_CSGru.Enabled          = par_lHabilitar
4006:         loc_oPg.txt_4c_Conjunto.Enabled       = par_lHabilitar
4007:         loc_oPg.txt_4c_Lin.Enabled            = par_lHabilitar
4008:         loc_oPg.txt_4c_Col.Enabled            = par_lHabilitar
4009:         loc_oPg.txt_4c_Ifor.Enabled           = par_lHabilitar
4010:         loc_oPg.txt_4c_Refs.Enabled           = par_lHabilitar
4011: 
4012:         *-- Fase 6 - campos editaveis
4013:         IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
4014:             RETURN
4015:         ENDIF
4016:         loc_oPg.txt_4c_CodFinP.Enabled    = par_lHabilitar
4017:         loc_oPg.txt_4c_CodAcb.Enabled     = par_lHabilitar
4018:         loc_oPg.txt_4c_Class.Enabled      = par_lHabilitar
4019:         loc_oPg.txt_4c_Local.Enabled      = par_lHabilitar
4020:         loc_oPg.txt_4c_PesoBs.Enabled     = par_lHabilitar
4021:         loc_oPg.txt_4c_Pmedio.Enabled     = par_lHabilitar
4022:         loc_oPg.txt_4c_Cuni.Enabled       = par_lHabilitar
4023:         loc_oPg.txt_4c_Cunip.Enabled      = par_lHabilitar
4024:         loc_oPg.txt_4c_CodIdent.Enabled   = par_lHabilitar

*-- Linhas 4051 a 4094:
4051:     * ConfigurarPgDados - Configura campos da aba Dados (primeiros 50%)
4052:     * Legado: pgDados controles T:130-T:298 (sem compensacao adicional)
4053:     *--------------------------------------------------------------------------
4054:     PROTECTED PROCEDURE ConfigurarPgDados()
4055:         LOCAL loc_oPg
4056:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4057: 
4058:         *-- Linha 1 (T:130-134): Produto / Descricao / Situacao
4059:         *-- Label2: "Produto :" (T:134 L:58 W:53 FontBold)
4060:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
4061:         WITH loc_oPg.lbl_4c_LblProduto
4062:             .Caption   = "Produto :"
4063:             .Top       = 134
4064:             .Left      = 58
4065:             .Width     = 53
4066:             .Height    = 15
4067:             .FontName  = "Tahoma"
4068:             .FontSize  = 8
4069:             .FontBold  = .T.
4070:             .BackStyle = 0
4071:             .ForeColor = RGB(90, 90, 90)
4072:             .Visible   = .T.
4073:         ENDWITH
4074: 
4075:         *-- getCpro -> txt_4c_Cpro (T:130 L:113 W:108 H:23) - PK do produto
4076:         loc_oPg.AddObject("txt_4c_Cpro", "TextBox")
4077:         WITH loc_oPg.txt_4c_Cpro
4078:             .Top           = 130
4079:             .Left          = 113
4080:             .Width         = 108
4081:             .Height        = 23
4082:             .FontName      = "Tahoma"
4083:             .FontSize      = 8
4084:             .MaxLength     = 14
4085:             .Value         = ""
4086:             .SpecialEffect = 1
4087:             .Visible       = .T.
4088:         ENDWITH
4089: 
4090:         *-- getDpro -> txt_4c_Dpro (T:130 L:222 W:290 H:23) - descricao
4091:         loc_oPg.AddObject("txt_4c_Dpro", "TextBox")
4092:         WITH loc_oPg.txt_4c_Dpro
4093:             .Top           = 130
4094:             .Left          = 222

*-- Linhas 4104 a 4147:
4104: 
4105:         *-- opc_situacao -> obj_4c_Opc_situacao (T:130 L:735 W:142 H:25)
4106:         *-- Value=1 Ativo, Value=2 Inativo (situas numeric no banco)
4107:         loc_oPg.AddObject("obj_4c_Opc_situacao", "OptionGroup")
4108:         WITH loc_oPg.obj_4c_Opc_situacao
4109:             .Top         = 130
4110:             .Left        = 735
4111:             .Width       = 142
4112:             .Height      = 25
4113:             .ButtonCount = 2
4114:             .Value       = 1
4115:             .BorderStyle = 0
4116:             .Visible     = .T.
4117:         ENDWITH
4118:         WITH loc_oPg.obj_4c_Opc_situacao
4119:             .Buttons(1).Caption   = "Ativo"
4120:             .Buttons(1).Left      = 5
4121:             .Buttons(1).Top       = 5
4122:             .Buttons(1).Height    = 15
4123:             .Buttons(1).FontName  = "Tahoma"
4124:             .Buttons(1).FontSize  = 8
4125:             .Buttons(1).ForeColor = RGB(90, 90, 90)
4126:             .Buttons(1).BackStyle = 0
4127:             .Buttons(1).AutoSize  = .T.
4128:             .Buttons(1).Themes    = .F.
4129: 
4130:             .Buttons(2).Caption   = "Inativo - Ap" + CHR(243) + "s :"
4131:             .Buttons(2).Left      = 50
4132:             .Buttons(2).Top       = 5
4133:             .Buttons(2).Height    = 15
4134:             .Buttons(2).FontName  = "Tahoma"
4135:             .Buttons(2).FontSize  = 8
4136:             .Buttons(2).ForeColor = RGB(90, 90, 90)
4137:             .Buttons(2).BackStyle = 0
4138:             .Buttons(2).AutoSize  = .T.
4139:             .Buttons(2).Themes    = .F.
4140:         ENDWITH
4141: 
4142:         *-- Linha 2 (T:133-158): Equivalente / Descritivo / Barra
4143:         *-- Say2: "Equivalente :" (T:137 L:560 W:65)
4144:         loc_oPg.AddObject("lbl_4c_LblEquivalente", "Label")
4145:         WITH loc_oPg.lbl_4c_LblEquivalente
4146:             .Caption   = "Equivalente :"
4147:             .Top       = 137

*-- Linhas 4170 a 4214:
4170:             .ForeColor     = RGB(36, 84, 155)
4171:             .Visible       = .T.
4172:         ENDWITH
4173:         BINDEVENT(loc_oPg.txt_4c_CProEq, "KeyPress",  THIS, "TxtCProEqKeyPress")
4174:         BINDEVENT(loc_oPg.txt_4c_CProEq, "LostFocus", THIS, "TxtCProEqLostFocus")
4175: 
4176:         *-- Say10: "Descritivo :" (T:158 L:55 W:56)
4177:         loc_oPg.AddObject("lbl_4c_LblDPro2", "Label")
4178:         WITH loc_oPg.lbl_4c_LblDPro2
4179:             .Caption   = "Descritivo :"
4180:             .Top       = 158
4181:             .Left      = 55
4182:             .Width     = 56
4183:             .Height    = 15
4184:             .FontName  = "Tahoma"
4185:             .FontSize  = 8
4186:             .BackStyle = 0
4187:             .ForeColor = RGB(90, 90, 90)
4188:             .Visible   = .T.
4189:         ENDWITH
4190: 
4191:         *-- getDPro2s -> txt_4c_DPro2s (T:154 L:113 W:399 H:23) - 2a descricao
4192:         loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
4193:         WITH loc_oPg.txt_4c_DPro2s
4194:             .Top           = 154
4195:             .Left          = 113
4196:             .Width         = 399
4197:             .Height        = 23
4198:             .FontName      = "Tahoma"
4199:             .FontSize      = 8
4200:             .MaxLength     = 45
4201:             .Value         = ""
4202:             .SpecialEffect = 1
4203:             .Visible       = .T.
4204:         ENDWITH
4205: 
4206:         *-- Say15: "Barra :" (T:157 L:590 W:35)
4207:         loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
4208:         WITH loc_oPg.lbl_4c_LblBarra
4209:             .Caption   = "Barra :"
4210:             .Top       = 157
4211:             .Left      = 590
4212:             .Width     = 35
4213:             .Height    = 15
4214:             .FontName  = "Tahoma"

*-- Linhas 4265 a 4309:
4265:             .SpecialEffect = 1
4266:             .Visible       = .T.
4267:         ENDWITH
4268:         BINDEVENT(loc_oPg.txt_4c_CgruP, "KeyPress",  THIS, "TxtCgruPKeyPress")
4269:         BINDEVENT(loc_oPg.txt_4c_CgruP, "LostFocus", THIS, "TxtCgruPLostFocus")
4270: 
4271:         *-- getDgru -> txt_4c_DgruP (T:178 L:145 W:171 H:23) - desc grupo (readonly)
4272:         loc_oPg.AddObject("txt_4c_DgruP", "TextBox")
4273:         WITH loc_oPg.txt_4c_DgruP
4274:             .Top           = 178
4275:             .Left          = 145
4276:             .Width         = 171
4277:             .Height        = 23
4278:             .FontName      = "Tahoma"
4279:             .FontSize      = 8
4280:             .ReadOnly      = .T.
4281:             .Value         = ""
4282:             .SpecialEffect = 1
4283:             .Visible       = .T.
4284:         ENDWITH
4285: 
4286:         *-- getMerc -> txt_4c_Merc (T:178 L:318 W:31 H:23) - mercadoria
4287:         loc_oPg.AddObject("txt_4c_Merc", "TextBox")
4288:         WITH loc_oPg.txt_4c_Merc
4289:             .Top           = 178
4290:             .Left          = 318
4291:             .Width         = 31
4292:             .Height        = 23
4293:             .FontName      = "Tahoma"
4294:             .FontSize      = 8
4295:             .MaxLength     = 3
4296:             .Value         = ""
4297:             .SpecialEffect = 1
4298:             .BackColor     = RGB(231, 242, 254)
4299:             .Visible       = .T.
4300:         ENDWITH
4301: 
4302:         *-- Say23: "Identificador :" (T:182 L:408 W:70)
4303:         loc_oPg.AddObject("lbl_4c_LblIdeCPros", "Label")
4304:         WITH loc_oPg.lbl_4c_LblIdeCPros
4305:             .Caption   = "Identificador :"
4306:             .Top       = 182
4307:             .Left      = 408
4308:             .Width     = 70
4309:             .Height    = 15

*-- Linhas 4391 a 4607:
4391:             .SpecialEffect = 1
4392:             .Visible       = .T.
4393:         ENDWITH
4394:         BINDEVENT(loc_oPg.txt_4c_CSGru, "KeyPress",  THIS, "TxtCSGruKeyPress")
4395:         BINDEVENT(loc_oPg.txt_4c_CSGru, "LostFocus", THIS, "TxtCSGruLostFocus")
4396: 
4397:         *-- GetDsGru -> txt_4c_DsGru (T:202 L:166 W:150 H:23) - desc subgrupo (readonly)
4398:         loc_oPg.AddObject("txt_4c_DsGru", "TextBox")
4399:         WITH loc_oPg.txt_4c_DsGru
4400:             .Top           = 202
4401:             .Left          = 166
4402:             .Width         = 150
4403:             .Height        = 23
4404:             .FontName      = "Tahoma"
4405:             .FontSize      = 8
4406:             .ReadOnly      = .T.
4407:             .Value         = ""
4408:             .SpecialEffect = 1
4409:             .Visible       = .T.
4410:         ENDWITH
4411: 
4412:         *-- Say37: "Conjunto :" (T:206 L:408 W:53)
4413:         loc_oPg.AddObject("lbl_4c_LblConjunto", "Label")
4414:         WITH loc_oPg.lbl_4c_LblConjunto
4415:             .Caption   = "Conjunto :"
4416:             .Top       = 206
4417:             .Left      = 408
4418:             .Width     = 53
4419:             .Height    = 15
4420:             .FontName  = "Tahoma"
4421:             .FontSize  = 8
4422:             .BackStyle = 0
4423:             .ForeColor = RGB(90, 90, 90)
4424:             .Visible   = .T.
4425:         ENDWITH
4426: 
4427:         *-- getConjunto -> txt_4c_Conjunto (T:202 L:460 W:52 H:23)
4428:         loc_oPg.AddObject("txt_4c_Conjunto", "TextBox")
4429:         WITH loc_oPg.txt_4c_Conjunto
4430:             .Top           = 202
4431:             .Left          = 460
4432:             .Width         = 52
4433:             .Height        = 23
4434:             .FontName      = "Tahoma"
4435:             .FontSize      = 8
4436:             .Value         = ""
4437:             .SpecialEffect = 1
4438:             .Visible       = .T.
4439:         ENDWITH
4440:         BINDEVENT(loc_oPg.txt_4c_Conjunto, "KeyPress",  THIS, "TxtConjuntoKeyPress")
4441: 
4442:         *-- Linha 5 (T:226-230): Linha
4443:         *-- Say16: "Linha :" (T:230 L:77 W:34)
4444:         loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
4445:         WITH loc_oPg.lbl_4c_LblLinha
4446:             .Caption   = "Linha :"
4447:             .Top       = 230
4448:             .Left      = 77
4449:             .Width     = 34
4450:             .Height    = 15
4451:             .FontName  = "Tahoma"
4452:             .FontSize  = 8
4453:             .BackStyle = 0
4454:             .ForeColor = RGB(90, 90, 90)
4455:             .Visible   = .T.
4456:         ENDWITH
4457: 
4458:         *-- GetLin -> txt_4c_Lin (T:226 L:113 W:80 H:23) - codigo de linha
4459:         loc_oPg.AddObject("txt_4c_Lin", "TextBox")
4460:         WITH loc_oPg.txt_4c_Lin
4461:             .Top           = 226
4462:             .Left          = 113
4463:             .Width         = 80
4464:             .Height        = 23
4465:             .FontName      = "Tahoma"
4466:             .FontSize      = 8
4467:             .Value         = ""
4468:             .SpecialEffect = 1
4469:             .Visible       = .T.
4470:         ENDWITH
4471:         BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress",  THIS, "TxtLinKeyPress")
4472:         BINDEVENT(loc_oPg.txt_4c_Lin, "LostFocus", THIS, "TxtLinLostFocus")
4473: 
4474:         *-- GetDLin -> txt_4c_DLin (T:226 L:194 W:318 H:23) - desc linha (readonly)
4475:         loc_oPg.AddObject("txt_4c_DLin", "TextBox")
4476:         WITH loc_oPg.txt_4c_DLin
4477:             .Top           = 226
4478:             .Left          = 194
4479:             .Width         = 318
4480:             .Height        = 23
4481:             .FontName      = "Tahoma"
4482:             .FontSize      = 8
4483:             .ReadOnly      = .T.
4484:             .Value         = ""
4485:             .SpecialEffect = 1
4486:             .Visible       = .T.
4487:         ENDWITH
4488: 
4489:         *-- Linha 6 (T:250-253): Grupo de Venda (Colecoes)
4490:         *-- Say17: "Grupo de Venda :" (T:253 L:25 W:86)
4491:         loc_oPg.AddObject("lbl_4c_LblGVenda", "Label")
4492:         WITH loc_oPg.lbl_4c_LblGVenda
4493:             .Caption   = "Grupo de Venda :"
4494:             .Top       = 253
4495:             .Left      = 25
4496:             .Width     = 86
4497:             .Height    = 15
4498:             .FontName  = "Tahoma"
4499:             .FontSize  = 8
4500:             .BackStyle = 0
4501:             .ForeColor = RGB(90, 90, 90)
4502:             .Visible   = .T.
4503:         ENDWITH
4504: 
4505:         *-- GetCol -> txt_4c_Col (T:250 L:113 W:80 H:23) - colecoes (grupo venda)
4506:         loc_oPg.AddObject("txt_4c_Col", "TextBox")
4507:         WITH loc_oPg.txt_4c_Col
4508:             .Top           = 250
4509:             .Left          = 113
4510:             .Width         = 80
4511:             .Height        = 23
4512:             .FontName      = "Tahoma"
4513:             .FontSize      = 8
4514:             .Value         = ""
4515:             .SpecialEffect = 1
4516:             .Visible       = .T.
4517:         ENDWITH
4518:         BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress",  THIS, "TxtColKeyPress")
4519:         BINDEVENT(loc_oPg.txt_4c_Col, "LostFocus", THIS, "TxtColLostFocus")
4520: 
4521:         *-- GetDCol -> txt_4c_DCol (T:250 L:194 W:318 H:23) - desc grupo venda (readonly)
4522:         loc_oPg.AddObject("txt_4c_DCol", "TextBox")
4523:         WITH loc_oPg.txt_4c_DCol
4524:             .Top           = 250
4525:             .Left          = 194
4526:             .Width         = 318
4527:             .Height        = 23
4528:             .FontName      = "Tahoma"
4529:             .FontSize      = 8
4530:             .ReadOnly      = .T.
4531:             .Value         = ""
4532:             .SpecialEffect = 1
4533:             .Visible       = .T.
4534:         ENDWITH
4535: 
4536:         *-- Linha 7 (T:274-278): Fornecedor
4537:         *-- Say11: "Fornecedor :" (T:278 L:47 W:64)
4538:         loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
4539:         WITH loc_oPg.lbl_4c_LblFornecedor
4540:             .Caption   = "Fornecedor :"
4541:             .Top       = 278
4542:             .Left      = 47
4543:             .Width     = 64
4544:             .Height    = 15
4545:             .FontName  = "Tahoma"
4546:             .FontSize  = 8
4547:             .BackStyle = 0
4548:             .ForeColor = RGB(90, 90, 90)
4549:             .Visible   = .T.
4550:         ENDWITH
4551: 
4552:         *-- getIfor -> txt_4c_Ifor (T:274 L:113 W:80 H:23) - codigo fornecedor
4553:         loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
4554:         WITH loc_oPg.txt_4c_Ifor
4555:             .Top           = 274
4556:             .Left          = 113
4557:             .Width         = 80
4558:             .Height        = 23
4559:             .FontName      = "Tahoma"
4560:             .FontSize      = 8
4561:             .MaxLength     = 10
4562:             .Value         = ""
4563:             .SpecialEffect = 1
4564:             .Visible       = .T.
4565:         ENDWITH
4566:         BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress",  THIS, "TxtIforKeyPress")
4567:         BINDEVENT(loc_oPg.txt_4c_Ifor, "LostFocus", THIS, "TxtIforLostFocus")
4568: 
4569:         *-- getDfor -> txt_4c_Dfor (T:274 L:194 W:318 H:23) - desc fornecedor (readonly)
4570:         loc_oPg.AddObject("txt_4c_Dfor", "TextBox")
4571:         WITH loc_oPg.txt_4c_Dfor
4572:             .Top           = 274
4573:             .Left          = 194
4574:             .Width         = 318
4575:             .Height        = 23
4576:             .FontName      = "Tahoma"
4577:             .FontSize      = 8
4578:             .ReadOnly      = .T.
4579:             .Value         = ""
4580:             .SpecialEffect = 1
4581:             .Visible       = .T.
4582:         ENDWITH
4583: 
4584:         *-- Linha 8 (T:298-301): Ref. Fornecedor
4585:         *-- Say12: "Ref. Fornecedor :" (T:301 L:23 W:88)
4586:         loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
4587:         WITH loc_oPg.lbl_4c_LblRefs
4588:             .Caption   = "Ref. Fornecedor :"
4589:             .Top       = 301
4590:             .Left      = 23
4591:             .Width     = 88
4592:             .Height    = 15
4593:             .FontName  = "Tahoma"
4594:             .FontSize  = 8
4595:             .BackStyle = 0
4596:             .ForeColor = RGB(90, 90, 90)
4597:             .Visible   = .T.
4598:         ENDWITH
4599: 
4600:         *-- getRefs -> txt_4c_Refs (T:298 L:113 W:152 H:23) - referencia fornecedor
4601:         loc_oPg.AddObject("txt_4c_Refs", "TextBox")
4602:         WITH loc_oPg.txt_4c_Refs
4603:             .Top           = 298
4604:             .Left          = 113
4605:             .Width         = 152
4606:             .Height        = 23
4607:             .FontName      = "Tahoma"

*-- Linhas 4620 a 4663:
4620:     * PreencherDescricoesPgDados - Busca descricoes dos campos lookup (readonly)
4621:     * Chamado por BOParaForm apos preencher codigos
4622:     *--------------------------------------------------------------------------
4623:     PROCEDURE PreencherDescricoesPgDados()
4624:         LOCAL loc_oPg, loc_cCod, loc_nRet
4625:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4626: 
4627:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4628:             RETURN
4629:         ENDIF
4630: 
4631:         TRY
4632:             *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
4633:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4634:             IF !EMPTY(loc_cCod)
4635:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4636:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
4637:                     "cursor_4c_TmpDgru")
4638:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
4639:                     loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
4640:                 ENDIF
4641:                 IF USED("cursor_4c_TmpDgru")
4642:                     USE IN cursor_4c_TmpDgru
4643:                 ENDIF
4644:             ENDIF
4645: 
4646:             *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
4647:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4648:             IF !EMPTY(loc_cCod)
4649:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4650:                     "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
4651:                     " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
4652:                     "cursor_4c_TmpSGru")
4653:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4654:                     loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4655:                 ENDIF
4656:                 IF USED("cursor_4c_TmpSGru")
4657:                     USE IN cursor_4c_TmpSGru
4658:                 ENDIF
4659:             ENDIF
4660: 
4661:             *-- Descricao da Linha (linhas -> SigCdLin.descs)
4662:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4663:             IF !EMPTY(loc_cCod)

*-- Linhas 4707 a 5275:
4707: 
4708:     *==========================================================================
4709:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 5)
4710:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
4711:     *==========================================================================
4712: 
4713:     *--------------------------------------------------------------------------
4714:     * TxtCgruP - F4 abre lookup de grupos; LostFocus valida codigo
4715:     *--------------------------------------------------------------------------
4716:     PROCEDURE TxtCgruPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4717:         IF par_nKeyCode = 115 && F4
4718:             THIS.AbrirLookupGrupoP2()
4719:         ENDIF
4720:     ENDPROC
4721: 
4722:     PROCEDURE TxtCgruPLostFocus()
4723:         LOCAL loc_oPg, loc_cCgru, loc_nRet
4724:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4725:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4726: 
4727:         IF EMPTY(loc_cCgru)
4728:             loc_oPg.txt_4c_DgruP.Value = ""
4729:             RETURN
4730:         ENDIF
4731:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4732:             RETURN
4733:         ENDIF
4734: 
4735:         TRY
4736:             loc_nRet = SQLEXEC(gnConnHandle, ;
4737:                 "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
4738:                 "cursor_4c_TmpGruP")
4739:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
4740:                 loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
4741:                 *-- Limpar subgrupo ao trocar grupo
4742:                 loc_oPg.txt_4c_CSGru.Value = ""
4743:                 loc_oPg.txt_4c_DsGru.Value = ""
4744:             ELSE
4745:                 MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
4746:                 loc_oPg.txt_4c_CgruP.Value = ""
4747:                 loc_oPg.txt_4c_DgruP.Value = ""
4748:             ENDIF
4749:             IF USED("cursor_4c_TmpGruP")
4750:                 USE IN cursor_4c_TmpGruP
4751:             ENDIF
4752:         CATCH TO loc_oErro
4753:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4754:         ENDTRY
4755:     ENDPROC
4756: 
4757:     PROCEDURE AbrirLookupGrupoP2()
4758:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4759:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4760:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4761: 
4762:         TRY
4763:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4764:                 "SigCdGrp", "cursor_4c_BuscaGruP", "cgrus", loc_cAtual, ;
4765:                 "Buscar Grupo de Produto")
4766:             IF VARTYPE(loc_oBusca) = "O"
4767:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4768:                     IF USED("cursor_4c_BuscaGruP")
4769:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4770:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4771:                         loc_oPg.txt_4c_CSGru.Value = ""
4772:                         loc_oPg.txt_4c_DsGru.Value = ""
4773:                     ENDIF
4774:                 ELSE
4775:                     IF !loc_oBusca.this_lAchouRegistro
4776:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
4777:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4778:                     loc_oBusca.Show()
4779:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
4780:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4781:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4782:                         loc_oPg.txt_4c_CSGru.Value = ""
4783:                         loc_oPg.txt_4c_DsGru.Value = ""
4784:                     ENDIF
4785:                     ENDIF
4786:                 ENDIF
4787:                 loc_oBusca.Release()
4788:             ENDIF
4789:             IF USED("cursor_4c_BuscaGruP")
4790:                 USE IN cursor_4c_BuscaGruP
4791:             ENDIF
4792:         CATCH TO loc_oErro
4793:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
4794:         ENDTRY
4795:     ENDPROC
4796: 
4797:     *--------------------------------------------------------------------------
4798:     * TxtCSGru - F4 abre lookup de subgrupos filtrados por cgrus; LostFocus valida
4799:     *--------------------------------------------------------------------------
4800:     PROCEDURE TxtCSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4801:         IF par_nKeyCode = 115 && F4
4802:             THIS.AbrirLookupSubGrupo()
4803:         ENDIF
4804:     ENDPROC
4805: 
4806:     PROCEDURE TxtCSGruLostFocus()
4807:         LOCAL loc_oPg, loc_cSGru, loc_cCgru, loc_nRet
4808:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4809:         loc_cSGru = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4810:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4811: 
4812:         IF EMPTY(loc_cSGru)
4813:             loc_oPg.txt_4c_DsGru.Value = ""
4814:             RETURN
4815:         ENDIF
4816:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4817:             RETURN
4818:         ENDIF
4819: 
4820:         TRY
4821:             loc_nRet = SQLEXEC(gnConnHandle, ;
4822:                 "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
4823:                 IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
4824:                 "cursor_4c_TmpSGru")
4825:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4826:                 loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4827:             ELSE
4828:                 MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
4829:                 loc_oPg.txt_4c_CSGru.Value = ""
4830:                 loc_oPg.txt_4c_DsGru.Value = ""
4831:             ENDIF
4832:             IF USED("cursor_4c_TmpSGru")
4833:                 USE IN cursor_4c_TmpSGru
4834:             ENDIF
4835:         CATCH TO loc_oErro
4836:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
4837:         ENDTRY
4838:     ENDPROC
4839: 
4840:     PROCEDURE AbrirLookupSubGrupo()
4841:         LOCAL loc_oBusca, loc_oPg, loc_cCgru, loc_cAtual
4842:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4843:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4844:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4845: 
4846:         TRY
4847:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4848:                 "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
4849:                 "Buscar Subgrupo", .F., .T., ;
4850:                 IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
4851:             IF VARTYPE(loc_oBusca) = "O"
4852:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4853:                     IF USED("cursor_4c_BuscaSGru")
4854:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4855:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4856:                     ENDIF
4857:                 ELSE
4858:                     IF !loc_oBusca.this_lAchouRegistro
4859:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4860:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4861:                     loc_oBusca.Show()
4862:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4863:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4864:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4865:                     ENDIF
4866:                     ENDIF
4867:                 ENDIF
4868:                 loc_oBusca.Release()
4869:             ENDIF
4870:             IF USED("cursor_4c_BuscaSGru")
4871:                 USE IN cursor_4c_BuscaSGru
4872:             ENDIF
4873:         CATCH TO loc_oErro
4874:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
4875:         ENDTRY
4876:     ENDPROC
4877: 
4878:     *--------------------------------------------------------------------------
4879:     * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
4880:     *--------------------------------------------------------------------------
4881:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4882:         IF par_nKeyCode = 115 && F4
4883:             THIS.AbrirLookupLinha()
4884:         ENDIF
4885:     ENDPROC
4886: 
4887:     PROCEDURE TxtLinLostFocus()
4888:         LOCAL loc_oPg, loc_cLin, loc_nRet
4889:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4890:         loc_cLin = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4891: 
4892:         IF EMPTY(loc_cLin)
4893:             loc_oPg.txt_4c_DLin.Value = ""
4894:             RETURN
4895:         ENDIF
4896:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4897:             RETURN
4898:         ENDIF
4899: 
4900:         TRY
4901:             loc_nRet = SQLEXEC(gnConnHandle, ;
4902:                 "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
4903:                 "cursor_4c_TmpLin")
4904:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4905:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4906:             ELSE
4907:                 MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
4908:                 loc_oPg.txt_4c_Lin.Value  = ""
4909:                 loc_oPg.txt_4c_DLin.Value = ""
4910:             ENDIF
4911:             IF USED("cursor_4c_TmpLin")
4912:                 USE IN cursor_4c_TmpLin
4913:             ENDIF
4914:         CATCH TO loc_oErro
4915:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
4916:         ENDTRY
4917:     ENDPROC
4918: 
4919:     PROCEDURE AbrirLookupLinha()
4920:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4921:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4922:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4923: 
4924:         TRY
4925:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4926:                 "SigCdLin", "cursor_4c_BuscaLin", "linhas", loc_cAtual, ;
4927:                 "Buscar Linha")
4928:             IF VARTYPE(loc_oBusca) = "O"
4929:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4930:                     IF USED("cursor_4c_BuscaLin")
4931:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4932:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4933:                     ENDIF
4934:                 ELSE
4935:                     IF !loc_oBusca.this_lAchouRegistro
4936:                     loc_oBusca.mAddColuna("linhas", "", "Linha")
4937:                     loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4938:                     loc_oBusca.Show()
4939:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
4940:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4941:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4942:                     ENDIF
4943:                     ENDIF
4944:                 ENDIF
4945:                 loc_oBusca.Release()
4946:             ENDIF
4947:             IF USED("cursor_4c_BuscaLin")
4948:                 USE IN cursor_4c_BuscaLin
4949:             ENDIF
4950:         CATCH TO loc_oErro
4951:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
4952:         ENDTRY
4953:     ENDPROC
4954: 
4955:     *--------------------------------------------------------------------------
4956:     * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
4957:     *--------------------------------------------------------------------------
4958:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4959:         IF par_nKeyCode = 115 && F4
4960:             THIS.AbrirLookupGVenda()
4961:         ENDIF
4962:     ENDPROC
4963: 
4964:     PROCEDURE TxtColLostFocus()
4965:         LOCAL loc_oPg, loc_cCol, loc_nRet
4966:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4967:         loc_cCol = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4968: 
4969:         IF EMPTY(loc_cCol)
4970:             loc_oPg.txt_4c_DCol.Value = ""
4971:             RETURN
4972:         ENDIF
4973:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4974:             RETURN
4975:         ENDIF
4976: 
4977:         TRY
4978:             loc_nRet = SQLEXEC(gnConnHandle, ;
4979:                 "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
4980:                 "cursor_4c_TmpCol")
4981:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4982:                 loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4983:             ELSE
4984:                 MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
4985:                 loc_oPg.txt_4c_Col.Value  = ""
4986:                 loc_oPg.txt_4c_DCol.Value = ""
4987:             ENDIF
4988:             IF USED("cursor_4c_TmpCol")
4989:                 USE IN cursor_4c_TmpCol
4990:             ENDIF
4991:         CATCH TO loc_oErro
4992:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
4993:         ENDTRY
4994:     ENDPROC
4995: 
4996:     PROCEDURE AbrirLookupGVenda()
4997:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4998:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4999:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Col.Value)
5000: 
5001:         TRY
5002:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5003:                 "SIGCDCOL", "cursor_4c_BuscaCol", "colecoes", loc_cAtual, ;
5004:                 "Buscar Grupo de Venda")
5005:             IF VARTYPE(loc_oBusca) = "O"
5006:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5007:                     IF USED("cursor_4c_BuscaCol")
5008:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
5009:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
5010:                     ENDIF
5011:                 ELSE
5012:                     IF !loc_oBusca.this_lAchouRegistro
5013:                     loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
5014:                     loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
5015:                     loc_oBusca.Show()
5016:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5017:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
5018:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
5019:                     ENDIF
5020:                     ENDIF
5021:                 ENDIF
5022:                 loc_oBusca.Release()
5023:             ENDIF
5024:             IF USED("cursor_4c_BuscaCol")
5025:                 USE IN cursor_4c_BuscaCol
5026:             ENDIF
5027:         CATCH TO loc_oErro
5028:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
5029:         ENDTRY
5030:     ENDPROC
5031: 
5032:     *--------------------------------------------------------------------------
5033:     * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
5034:     *--------------------------------------------------------------------------
5035:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5036:         IF par_nKeyCode = 115 && F4
5037:             THIS.AbrirLookupFornecedor()
5038:         ENDIF
5039:     ENDPROC
5040: 
5041:     PROCEDURE TxtIforLostFocus()
5042:         LOCAL loc_oPg, loc_cIfor, loc_nRet
5043:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5044:         loc_cIfor = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
5045: 
5046:         IF EMPTY(loc_cIfor)
5047:             loc_oPg.txt_4c_Dfor.Value = ""
5048:             RETURN
5049:         ENDIF
5050:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5051:             RETURN
5052:         ENDIF
5053: 
5054:         TRY
5055:             loc_nRet = SQLEXEC(gnConnHandle, ;
5056:                 "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
5057:                 "cursor_4c_TmpIfor")
5058:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
5059:                 loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
5060:             ELSE
5061:                 MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
5062:                 loc_oPg.txt_4c_Ifor.Value = ""
5063:                 loc_oPg.txt_4c_Dfor.Value = ""
5064:             ENDIF
5065:             IF USED("cursor_4c_TmpIfor")
5066:                 USE IN cursor_4c_TmpIfor
5067:             ENDIF
5068:         CATCH TO loc_oErro
5069:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5070:         ENDTRY
5071:     ENDPROC
5072: 
5073:     PROCEDURE AbrirLookupFornecedor()
5074:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
5075:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5076:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
5077: 
5078:         TRY
5079:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5080:                 "SigCdCli", "cursor_4c_BuscaIfor", "iclis", loc_cAtual, ;
5081:                 "Buscar Fornecedor")
5082:             IF VARTYPE(loc_oBusca) = "O"
5083:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5084:                     IF USED("cursor_4c_BuscaIfor")
5085:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5086:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5087:                     ENDIF
5088:                 ELSE
5089:                     IF !loc_oBusca.this_lAchouRegistro
5090:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5091:                     loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
5092:                     loc_oBusca.Show()
5093:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5094:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5095:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5096:                     ENDIF
5097:                     ENDIF
5098:                 ENDIF
5099:                 loc_oBusca.Release()
5100:             ENDIF
5101:             IF USED("cursor_4c_BuscaIfor")
5102:                 USE IN cursor_4c_BuscaIfor
5103:             ENDIF
5104:         CATCH TO loc_oErro
5105:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
5106:         ENDTRY
5107:     ENDPROC
5108: 
5109:     *--------------------------------------------------------------------------
5110:     * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
5111:     *--------------------------------------------------------------------------
5112:     PROCEDURE TxtCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5113:         IF par_nKeyCode = 115 && F4
5114:             THIS.AbrirLookupProdEq()
5115:         ENDIF
5116:     ENDPROC
5117: 
5118:     PROCEDURE TxtCProEqLostFocus()
5119:         LOCAL loc_oPg, loc_cCpro, loc_nRet
5120:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5121:         loc_cCpro = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
5122: 
5123:         IF EMPTY(loc_cCpro)
5124:             RETURN
5125:         ENDIF
5126:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5127:             RETURN
5128:         ENDIF
5129: 
5130:         TRY
5131:             loc_nRet = SQLEXEC(gnConnHandle, ;
5132:                 "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
5133:                 "cursor_4c_TmpProEq")
5134:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
5135:                 MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
5136:                 loc_oPg.txt_4c_CProEq.Value = ""
5137:             ENDIF
5138:             IF USED("cursor_4c_TmpProEq")
5139:                 USE IN cursor_4c_TmpProEq
5140:             ENDIF
5141:         CATCH TO loc_oErro
5142:             MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
5143:         ENDTRY
5144:     ENDPROC
5145: 
5146:     PROCEDURE AbrirLookupProdEq()
5147:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
5148:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5149:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
5150: 
5151:         TRY
5152:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5153:                 "SigCdPro", "cursor_4c_BuscaProEq", "cpros", loc_cAtual, ;
5154:                 "Buscar Produto Equivalente")
5155:             IF VARTYPE(loc_oBusca) = "O"
5156:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5157:                     IF USED("cursor_4c_BuscaProEq")
5158:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5159:                     ENDIF
5160:                 ELSE
5161:                     IF !loc_oBusca.this_lAchouRegistro
5162:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
5163:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
5164:                     loc_oBusca.Show()
5165:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
5166:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5167:                     ENDIF
5168:                     ENDIF
5169:                 ENDIF
5170:                 loc_oBusca.Release()
5171:             ENDIF
5172:             IF USED("cursor_4c_BuscaProEq")
5173:                 USE IN cursor_4c_BuscaProEq
5174:             ENDIF
5175:         CATCH TO loc_oErro
5176:             MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
5177:         ENDTRY
5178:     ENDPROC
5179: 
5180:     *--------------------------------------------------------------------------
5181:     * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
5182:     *--------------------------------------------------------------------------
5183:     PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5184:         IF par_nKeyCode = 115 && F4
5185:             THIS.AbrirLookupConjunto()
5186:         ENDIF
5187:     ENDPROC
5188: 
5189:     PROCEDURE AbrirLookupConjunto()
5190:         LOCAL loc_oBusca, loc_oPg, loc_nRet
5191:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5192: 
5193:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5194:             RETURN
5195:         ENDIF
5196: 
5197:         TRY
5198:             *-- Busca conjuntos distintos ja cadastrados em SigCdPro
5199:             loc_nRet = SQLEXEC(gnConnHandle, ;
5200:                 "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
5201:                 "cursor_4c_BuscaCnj")
5202: 
5203:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
5204:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5205:                 IF VARTYPE(loc_oBusca) = "O"
5206:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5207:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5208:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5209:                     loc_oBusca.Show()
5210:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5211:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5212:                     ENDIF
5213:                     loc_oBusca.Release()
5214:                 ENDIF
5215:             ENDIF
5216: 
5217:             IF USED("cursor_4c_BuscaCnj")
5218:                 USE IN cursor_4c_BuscaCnj
5219:             ENDIF
5220:         CATCH TO loc_oErro
5221:             MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
5222:         ENDTRY
5223:     ENDPROC
5224: 
5225:     *==========================================================================
5226:     * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
5227:     *==========================================================================
5228: 
5229:     *--------------------------------------------------------------------------
5230:     * ConfigurarPgDadosP2 - Configura campos restantes da aba Dados
5231:     * Cobre: Qt.Pedido, Garantia, Dimensoes fisicas, Ultima Compra,
5232:     *        Modelo, Acabamento, Classif., Local, Custos, Unidades,
5233:     *        Auditoria, CodIdent, Checkboxes, Memos, Dimensoes embalagem
5234:     *--------------------------------------------------------------------------
5235:     PROTECTED PROCEDURE ConfigurarPgDadosP2()
5236:         LOCAL loc_oPg
5237:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5238: 
5239:         *----------------------------------------------------------------------
5240:         *-- Qt. Pedido (T:221 L:626) + Garantia (T:224 L:880)
5241:         *----------------------------------------------------------------------
5242:         loc_oPg.AddObject("lbl_4c_LblQtPed", "Label")
5243:         WITH loc_oPg.lbl_4c_LblQtPed
5244:             .Caption   = "Qt. Pedido :"
5245:             .Top       = 224
5246:             .Left      = 541
5247:             .Width     = 80
5248:             .Height    = 15
5249:             .FontName  = "Tahoma"
5250:             .FontSize  = 8
5251:             .BackStyle = 0
5252:             .ForeColor = RGB(90, 90, 90)
5253:             .Visible   = .T.
5254:         ENDWITH
5255: 
5256:         loc_oPg.AddObject("txt_4c_QtPed", "TextBox")
5257:         WITH loc_oPg.txt_4c_QtPed
5258:             .Top           = 221
5259:             .Left          = 626
5260:             .Width         = 80
5261:             .Height        = 21
5262:             .FontName      = "Tahoma"
5263:             .FontSize      = 8
5264:             .MaxLength     = 10
5265:             .Value         = ""
5266:             .SpecialEffect = 1
5267:             .Visible       = .T.
5268:         ENDWITH
5269: 
5270:         loc_oPg.AddObject("lbl_4c_LblGarantia", "Label")
5271:         WITH loc_oPg.lbl_4c_LblGarantia
5272:             .Caption   = "Gar.(dias):"
5273:             .Top       = 227
5274:             .Left      = 820
5275:             .Width     = 57

*-- Linhas 5673 a 5717:
5673:             .SpecialEffect = 1
5674:             .Visible       = .T.
5675:         ENDWITH
5676:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress",  THIS, "TxtCodFinPKeyPress")
5677:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "LostFocus", THIS, "TxtCodFinPLostFocus")
5678: 
5679:         *-- Say35: "Peso Bruto :" (T:326 L:336 W:61)
5680:         loc_oPg.AddObject("lbl_4c_LblPesoBs", "Label")
5681:         WITH loc_oPg.lbl_4c_LblPesoBs
5682:             .Caption   = "Peso Bruto :"
5683:             .Top       = 326
5684:             .Left      = 336
5685:             .Width     = 61
5686:             .Height    = 15
5687:             .FontName  = "Tahoma"
5688:             .FontSize  = 8
5689:             .BackStyle = 0
5690:             .ForeColor = RGB(90, 90, 90)
5691:             .Visible   = .T.
5692:         ENDWITH
5693: 
5694:         *-- getPesoBs -> txt_4c_PesoBs (T:322 L:401 W:111 H:23) - pesobs numeric(7,3)
5695:         loc_oPg.AddObject("txt_4c_PesoBs", "TextBox")
5696:         WITH loc_oPg.txt_4c_PesoBs
5697:             .Top           = 322
5698:             .Left          = 401
5699:             .Width         = 111
5700:             .Height        = 23
5701:             .FontName      = "Tahoma"
5702:             .FontSize      = 8
5703:             .MaxLength     = 10
5704:             .Value         = ""
5705:             .SpecialEffect = 1
5706:             .Visible       = .T.
5707:         ENDWITH
5708: 
5709:         *----------------------------------------------------------------------
5710:         *-- Acabamento (T:346) - lblAcabamento: "Acabamento :" (T:350 L:7)
5711:         *----------------------------------------------------------------------
5712:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5713:         WITH loc_oPg.lbl_4c_LblAcabamento
5714:             .Caption   = "Acabamento :"
5715:             .Top       = 350
5716:             .Left      = 7
5717:             .Width     = 104

*-- Linhas 5752 a 5796:
5752:             .SpecialEffect = 1
5753:             .Visible       = .T.
5754:         ENDWITH
5755:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress",  THIS, "TxtCodAcbKeyPress")
5756:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "TxtCodAcbLostFocus")
5757: 
5758:         *-- Say34: "Peso Liquido :" (T:350 L:329 W:68)
5759:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
5760:         WITH loc_oPg.lbl_4c_LblPmedio
5761:             .Caption   = "Peso L" + CHR(237) + "quido :"
5762:             .Top       = 350
5763:             .Left      = 329
5764:             .Width     = 68
5765:             .Height    = 15
5766:             .FontName  = "Tahoma"
5767:             .FontSize  = 8
5768:             .BackStyle = 0
5769:             .ForeColor = RGB(90, 90, 90)
5770:             .Visible   = .T.
5771:         ENDWITH
5772: 
5773:         *-- getPmedio -> txt_4c_Pmedio (T:346 L:401 W:111 H:23) - pesoms numeric(8,3)
5774:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
5775:         WITH loc_oPg.txt_4c_Pmedio
5776:             .Top           = 346
5777:             .Left          = 401
5778:             .Width         = 111
5779:             .Height        = 23
5780:             .FontName      = "Tahoma"
5781:             .FontSize      = 8
5782:             .MaxLength     = 10
5783:             .Value         = ""
5784:             .SpecialEffect = 1
5785:             .Visible       = .T.
5786:         ENDWITH
5787: 
5788:         *----------------------------------------------------------------------
5789:         *-- Estoque (T:353) - Say28: "Estoque :" (T:357 L:577 W:48)
5790:         *----------------------------------------------------------------------
5791:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
5792:         WITH loc_oPg.lbl_4c_LblEstoque
5793:             .Caption   = "Estoque :"
5794:             .Top       = 357
5795:             .Left      = 577
5796:             .Width     = 48

*-- Linhas 5882 a 5958:
5882:             .SpecialEffect = 1
5883:             .Visible       = .T.
5884:         ENDWITH
5885:         BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress",  THIS, "TxtClassKeyPress")
5886:         BINDEVENT(loc_oPg.txt_4c_Class, "LostFocus", THIS, "TxtClassLostFocus")
5887: 
5888:         *-- Say5: "Local :" (T:374 L:364 W:33)
5889:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
5890:         WITH loc_oPg.lbl_4c_LblLocal
5891:             .Caption   = "Local :"
5892:             .Top       = 374
5893:             .Left      = 364
5894:             .Width     = 33
5895:             .Height    = 15
5896:             .FontName  = "Tahoma"
5897:             .FontSize  = 8
5898:             .BackStyle = 0
5899:             .ForeColor = RGB(90, 90, 90)
5900:             .Visible   = .T.
5901:         ENDWITH
5902: 
5903:         *-- Get_Local -> txt_4c_Local (T:370 L:401 W:111 H:23) - locals char(10)
5904:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
5905:         WITH loc_oPg.txt_4c_Local
5906:             .Top           = 370
5907:             .Left          = 401
5908:             .Width         = 111
5909:             .Height        = 23
5910:             .FontName      = "Tahoma"
5911:             .FontSize      = 8
5912:             .MaxLength     = 10
5913:             .Value         = ""
5914:             .SpecialEffect = 1
5915:             .Visible       = .T.
5916:         ENDWITH
5917:         BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress",  THIS, "TxtLocalKeyPress")
5918:         BINDEVENT(loc_oPg.txt_4c_Local, "LostFocus", THIS, "TxtLocalLostFocus")
5919: 
5920:         *----------------------------------------------------------------------
5921:         *-- Custo (T:375) - Say3: "Valor de Custo :" (T:379 L:546 W:79)
5922:         *----------------------------------------------------------------------
5923:         loc_oPg.AddObject("lbl_4c_LblCusto", "Label")
5924:         WITH loc_oPg.lbl_4c_LblCusto
5925:             .Caption   = "Valor de Custo :"
5926:             .Top       = 379
5927:             .Left      = 546
5928:             .Width     = 79
5929:             .Height    = 15
5930:             .FontName  = "Tahoma"
5931:             .FontSize  = 8
5932:             .BackStyle = 0
5933:             .ForeColor = RGB(90, 90, 90)
5934:             .Visible   = .T.
5935:         ENDWITH
5936: 
5937:         *-- getCtotal -> txt_4c_Ctotal (T:375 L:626 W:127 H:21) - custofs (display)
5938:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
5939:         WITH loc_oPg.txt_4c_Ctotal
5940:             .Top           = 375
5941:             .Left          = 626
5942:             .Width         = 127
5943:             .Height        = 21
5944:             .FontName      = "Tahoma"
5945:             .FontSize      = 8
5946:             .ReadOnly      = .T.
5947:             .MaxLength     = 14
5948:             .Value         = ""
5949:             .SpecialEffect = 1
5950:             .ForeColor     = RGB(36, 84, 155)
5951:             .BackColor     = RGB(224, 235, 235)
5952:             .Visible       = .T.
5953:         ENDWITH
5954: 
5955:         *-- getMctotal -> txt_4c_Mctotal (T:375 L:754 W:31 H:21) - moecusfs (display)
5956:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
5957:         WITH loc_oPg.txt_4c_Mctotal
5958:             .Top           = 375

*-- Linhas 6049 a 6140:
6049:             .SpecialEffect = 1
6050:             .Visible       = .T.
6051:         ENDWITH
6052:         BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress",  THIS, "TxtCuniKeyPress")
6053:         BINDEVENT(loc_oPg.txt_4c_Cuni, "LostFocus", THIS, "TxtCuniLostFocus")
6054: 
6055:         *-- Get_Duni -> txt_4c_DUni (T:394 L:145 W:150 H:23) - desc unid1 (readonly)
6056:         loc_oPg.AddObject("txt_4c_DUni", "TextBox")
6057:         WITH loc_oPg.txt_4c_DUni
6058:             .Top           = 394
6059:             .Left          = 145
6060:             .Width         = 150
6061:             .Height        = 23
6062:             .FontName      = "Tahoma"
6063:             .FontSize      = 8
6064:             .ReadOnly      = .T.
6065:             .Value         = ""
6066:             .SpecialEffect = 1
6067:             .Visible       = .T.
6068:         ENDWITH
6069: 
6070:         *-- Say18: "(2) :" (T:398 L:301 W:23)
6071:         loc_oPg.AddObject("lbl_4c_LblUnid2", "Label")
6072:         WITH loc_oPg.lbl_4c_LblUnid2
6073:             .Caption   = "(2) :"
6074:             .Top       = 398
6075:             .Left      = 301
6076:             .Width     = 23
6077:             .Height    = 15
6078:             .FontName  = "Tahoma"
6079:             .FontSize  = 8
6080:             .BackStyle = 0
6081:             .ForeColor = RGB(90, 90, 90)
6082:             .Visible   = .T.
6083:         ENDWITH
6084: 
6085:         *-- Get_cunip -> txt_4c_Cunip (T:394 L:330 W:31 H:23) - cunips char(3)
6086:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
6087:         WITH loc_oPg.txt_4c_Cunip
6088:             .Top           = 394
6089:             .Left          = 330
6090:             .Width         = 31
6091:             .Height        = 23
6092:             .FontName      = "Tahoma"
6093:             .FontSize      = 8
6094:             .MaxLength     = 3
6095:             .Value         = ""
6096:             .SpecialEffect = 1
6097:             .Visible       = .T.
6098:         ENDWITH
6099:         BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress",  THIS, "TxtCunipKeyPress")
6100:         BINDEVENT(loc_oPg.txt_4c_Cunip, "LostFocus", THIS, "TxtCunipLostFocus")
6101: 
6102:         *-- get_dunip -> txt_4c_DUnip (T:394 L:362 W:150 H:23) - desc unid2 (readonly)
6103:         loc_oPg.AddObject("txt_4c_DUnip", "TextBox")
6104:         WITH loc_oPg.txt_4c_DUnip
6105:             .Top           = 394
6106:             .Left          = 362
6107:             .Width         = 150
6108:             .Height        = 23
6109:             .FontName      = "Tahoma"
6110:             .FontSize      = 8
6111:             .ReadOnly      = .T.
6112:             .Value         = ""
6113:             .SpecialEffect = 1
6114:             .Visible       = .T.
6115:         ENDWITH
6116: 
6117:         *----------------------------------------------------------------------
6118:         *-- Preco Venda + Auditoria linha 1 (T:397)
6119:         *-- Say4: "Valor de Venda :" (T:400 L:505 W:120)
6120:         *----------------------------------------------------------------------
6121:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
6122:         WITH loc_oPg.lbl_4c_LblPvenda
6123:             .Caption   = "Valor de Venda :"
6124:             .Top       = 400
6125:             .Left      = 505
6126:             .Width     = 120
6127:             .Height    = 15
6128:             .FontName  = "Tahoma"
6129:             .FontSize  = 8
6130:             .BackStyle = 0
6131:             .ForeColor = RGB(90, 90, 90)
6132:             .Visible   = .T.
6133:         ENDWITH
6134: 
6135:         *-- getPvenda -> txt_4c_Pvenda (T:397 L:626 W:127 H:21) - pvens (display)
6136:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
6137:         WITH loc_oPg.txt_4c_Pvenda
6138:             .Top           = 397
6139:             .Left          = 626
6140:             .Width         = 127

*-- Linhas 6668 a 6711:
6668:     *--------------------------------------------------------------------------
6669:     * PreencherDescricoesPgDadosP2 - Busca descricoes de unidades (readonly)
6670:     *--------------------------------------------------------------------------
6671:     PROCEDURE PreencherDescricoesPgDadosP2()
6672:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
6673:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6674: 
6675:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6676:             RETURN
6677:         ENDIF
6678:         IF VARTYPE(loc_oPg.txt_4c_Cuni) # "O"
6679:             RETURN
6680:         ENDIF
6681: 
6682:         TRY
6683:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6684:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6685:             IF !EMPTY(loc_cCod)
6686:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6687:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6688:                     "cursor_4c_TmpUni")
6689:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6690:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6691:                 ENDIF
6692:                 IF USED("cursor_4c_TmpUni")
6693:                     USE IN cursor_4c_TmpUni
6694:                 ENDIF
6695:             ENDIF
6696: 
6697:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6698:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6699:             IF !EMPTY(loc_cCod)
6700:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6701:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6702:                     "cursor_4c_TmpUnip")
6703:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6704:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6705:                 ENDIF
6706:                 IF USED("cursor_4c_TmpUnip")
6707:                     USE IN cursor_4c_TmpUnip
6708:                 ENDIF
6709:             ENDIF
6710: 
6711:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)

*-- Linhas 6774 a 7287:
6774: 
6775:     *==========================================================================
6776:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 6)
6777:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
6778:     *==========================================================================
6779: 
6780:     *--------------------------------------------------------------------------
6781:     * TxtCuni - F4 abre lookup de unidades; LostFocus valida codigo
6782:     *--------------------------------------------------------------------------
6783:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6784:         IF par_nKeyCode = 115 && F4
6785:             THIS.AbrirLookupUnidade1()
6786:         ENDIF
6787:     ENDPROC
6788: 
6789:     PROCEDURE TxtCuniLostFocus()
6790:         LOCAL loc_oPg, loc_cCuni, loc_nRet
6791:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6792:         loc_cCuni = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6793: 
6794:         IF EMPTY(loc_cCuni)
6795:             loc_oPg.txt_4c_DUni.Value = ""
6796:             RETURN
6797:         ENDIF
6798:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6799:             RETURN
6800:         ENDIF
6801: 
6802:         TRY
6803:             loc_nRet = SQLEXEC(gnConnHandle, ;
6804:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6805:                 "cursor_4c_TmpCuni")
6806:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6807:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6808:             ELSE
6809:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6810:                 loc_oPg.txt_4c_Cuni.Value = ""
6811:                 loc_oPg.txt_4c_DUni.Value = ""
6812:             ENDIF
6813:             IF USED("cursor_4c_TmpCuni")
6814:                 USE IN cursor_4c_TmpCuni
6815:             ENDIF
6816:         CATCH TO loc_oErro
6817:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6818:         ENDTRY
6819:     ENDPROC
6820: 
6821:     PROCEDURE AbrirLookupUnidade1()
6822:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6823:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6824:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6825: 
6826:         TRY
6827:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6828:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", loc_cAtual, ;
6829:                 "Buscar Unidade")
6830:             IF VARTYPE(loc_oBusca) = "O"
6831:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6832:                     IF USED("cursor_4c_BuscaUni")
6833:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6834:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6835:                     ENDIF
6836:                 ELSE
6837:                     IF !loc_oBusca.this_lAchouRegistro
6838:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6839:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6840:                     loc_oBusca.Show()
6841:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6842:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6843:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6844:                     ENDIF
6845:                     ENDIF
6846:                 ENDIF
6847:                 loc_oBusca.Release()
6848:             ENDIF
6849:             IF USED("cursor_4c_BuscaUni")
6850:                 USE IN cursor_4c_BuscaUni
6851:             ENDIF
6852:         CATCH TO loc_oErro
6853:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6854:         ENDTRY
6855:     ENDPROC
6856: 
6857:     *--------------------------------------------------------------------------
6858:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6859:     *--------------------------------------------------------------------------
6860:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6861:         IF par_nKeyCode = 115 && F4
6862:             THIS.AbrirLookupUnidade2()
6863:         ENDIF
6864:     ENDPROC
6865: 
6866:     PROCEDURE TxtCunipLostFocus()
6867:         LOCAL loc_oPg, loc_cCunip, loc_nRet
6868:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6869:         loc_cCunip = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6870: 
6871:         IF EMPTY(loc_cCunip)
6872:             loc_oPg.txt_4c_DUnip.Value = ""
6873:             RETURN
6874:         ENDIF
6875:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6876:             RETURN
6877:         ENDIF
6878: 
6879:         TRY
6880:             loc_nRet = SQLEXEC(gnConnHandle, ;
6881:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6882:                 "cursor_4c_TmpCunip")
6883:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6884:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6885:             ELSE
6886:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6887:                 loc_oPg.txt_4c_Cunip.Value = ""
6888:                 loc_oPg.txt_4c_DUnip.Value = ""
6889:             ENDIF
6890:             IF USED("cursor_4c_TmpCunip")
6891:                 USE IN cursor_4c_TmpCunip
6892:             ENDIF
6893:         CATCH TO loc_oErro
6894:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6895:         ENDTRY
6896:     ENDPROC
6897: 
6898:     PROCEDURE AbrirLookupUnidade2()
6899:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6900:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6901:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6902: 
6903:         TRY
6904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6905:                 "SigCdUni", "cursor_4c_BuscaUnip", "cunis", loc_cAtual, ;
6906:                 "Buscar Unidade 2")
6907:             IF VARTYPE(loc_oBusca) = "O"
6908:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6909:                     IF USED("cursor_4c_BuscaUnip")
6910:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6911:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6912:                     ENDIF
6913:                 ELSE
6914:                     IF !loc_oBusca.this_lAchouRegistro
6915:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6916:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6917:                     loc_oBusca.Show()
6918:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6919:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6920:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6921:                     ENDIF
6922:                     ENDIF
6923:                 ENDIF
6924:                 loc_oBusca.Release()
6925:             ENDIF
6926:             IF USED("cursor_4c_BuscaUnip")
6927:                 USE IN cursor_4c_BuscaUnip
6928:             ENDIF
6929:         CATCH TO loc_oErro
6930:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6931:         ENDTRY
6932:     ENDPROC
6933: 
6934:     *--------------------------------------------------------------------------
6935:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6936:     *--------------------------------------------------------------------------
6937:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6938:         IF par_nKeyCode = 115 && F4
6939:             THIS.AbrirLookupModelo()
6940:         ENDIF
6941:     ENDPROC
6942: 
6943:     PROCEDURE TxtCodFinPLostFocus()
6944:         LOCAL loc_oPg, loc_cCod, loc_nRet
6945:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6946:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6947: 
6948:         IF EMPTY(loc_cCod)
6949:             loc_oPg.txt_4c_DFinP.Value = ""
6950:             RETURN
6951:         ENDIF
6952:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6953:             RETURN
6954:         ENDIF
6955: 
6956:         TRY
6957:             loc_nRet = SQLEXEC(gnConnHandle, ;
6958:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6959:                 "cursor_4c_TmpFinP")
6960:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6961:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6962:             ELSE
6963:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6964:                 loc_oPg.txt_4c_CodFinP.Value = ""
6965:                 loc_oPg.txt_4c_DFinP.Value   = ""
6966:             ENDIF
6967:             IF USED("cursor_4c_TmpFinP")
6968:                 USE IN cursor_4c_TmpFinP
6969:             ENDIF
6970:         CATCH TO loc_oErro
6971:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6972:         ENDTRY
6973:     ENDPROC
6974: 
6975:     PROCEDURE AbrirLookupModelo()
6976:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6977:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6978:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6979: 
6980:         TRY
6981:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6982:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", loc_cAtual, ;
6983:                 "Buscar Modelo")
6984:             IF VARTYPE(loc_oBusca) = "O"
6985:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6986:                     IF USED("cursor_4c_BuscaFinP")
6987:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6988:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6989:                     ENDIF
6990:                 ELSE
6991:                     IF !loc_oBusca.this_lAchouRegistro
6992:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6993:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6994:                     loc_oBusca.Show()
6995:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6996:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6997:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6998:                     ENDIF
6999:                     ENDIF
7000:                 ENDIF
7001:                 loc_oBusca.Release()
7002:             ENDIF
7003:             IF USED("cursor_4c_BuscaFinP")
7004:                 USE IN cursor_4c_BuscaFinP
7005:             ENDIF
7006:         CATCH TO loc_oErro
7007:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
7008:         ENDTRY
7009:     ENDPROC
7010: 
7011:     *--------------------------------------------------------------------------
7012:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
7013:     *--------------------------------------------------------------------------
7014:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7015:         IF par_nKeyCode = 115 && F4
7016:             THIS.AbrirLookupAcabamento()
7017:         ENDIF
7018:     ENDPROC
7019: 
7020:     PROCEDURE TxtCodAcbLostFocus()
7021:         LOCAL loc_oPg, loc_cCod, loc_nRet
7022:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7023:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7024: 
7025:         IF EMPTY(loc_cCod)
7026:             loc_oPg.txt_4c_DAcb.Value = ""
7027:             RETURN
7028:         ENDIF
7029:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7030:             RETURN
7031:         ENDIF
7032: 
7033:         TRY
7034:             loc_nRet = SQLEXEC(gnConnHandle, ;
7035:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7036:                 "cursor_4c_TmpAcb")
7037:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7038:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7039:             ELSE
7040:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7041:                 loc_oPg.txt_4c_CodAcb.Value = ""
7042:                 loc_oPg.txt_4c_DAcb.Value   = ""
7043:             ENDIF
7044:             IF USED("cursor_4c_TmpAcb")
7045:                 USE IN cursor_4c_TmpAcb
7046:             ENDIF
7047:         CATCH TO loc_oErro
7048:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7049:         ENDTRY
7050:     ENDPROC
7051: 
7052:     PROCEDURE AbrirLookupAcabamento()
7053:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7054:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7055:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7056: 
7057:         TRY
7058:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7059:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cAtual, ;
7060:                 "Buscar Acabamento")
7061:             IF VARTYPE(loc_oBusca) = "O"
7062:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7063:                     IF USED("cursor_4c_BuscaAcb")
7064:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7065:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7066:                     ENDIF
7067:                 ELSE
7068:                     IF !loc_oBusca.this_lAchouRegistro
7069:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7070:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7071:                     loc_oBusca.Show()
7072:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7073:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7074:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7075:                     ENDIF
7076:                     ENDIF
7077:                 ENDIF
7078:                 loc_oBusca.Release()
7079:             ENDIF
7080:             IF USED("cursor_4c_BuscaAcb")
7081:                 USE IN cursor_4c_BuscaAcb
7082:             ENDIF
7083:         CATCH TO loc_oErro
7084:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7085:         ENDTRY
7086:     ENDPROC
7087: 
7088:     *--------------------------------------------------------------------------
7089:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7090:     * SigCdCls: filtrado por cgrus do grupo de produto corrente
7091:     *--------------------------------------------------------------------------
7092:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7093:         IF par_nKeyCode = 115 && F4
7094:             THIS.AbrirLookupClassificacao()
7095:         ENDIF
7096:     ENDPROC
7097: 
7098:     PROCEDURE TxtClassLostFocus()
7099:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
7100:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7101:         loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7102:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7103: 
7104:         IF EMPTY(loc_cCod)
7105:             loc_oPg.txt_4c_DClass.Value = ""
7106:             RETURN
7107:         ENDIF
7108:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7109:             RETURN
7110:         ENDIF
7111: 
7112:         TRY
7113:             loc_nRet = SQLEXEC(gnConnHandle, ;
7114:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7115:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7116:                 "cursor_4c_TmpClass")
7117:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7118:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7119:             ELSE
7120:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7121:                 loc_oPg.txt_4c_Class.Value  = ""
7122:                 loc_oPg.txt_4c_DClass.Value = ""
7123:             ENDIF
7124:             IF USED("cursor_4c_TmpClass")
7125:                 USE IN cursor_4c_TmpClass
7126:             ENDIF
7127:         CATCH TO loc_oErro
7128:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7129:         ENDTRY
7130:     ENDPROC
7131: 
7132:     PROCEDURE AbrirLookupClassificacao()
7133:         LOCAL loc_oBusca, loc_oPg, loc_cAtual, loc_cCgru
7134:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7135:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7136:         loc_cCgru  = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7137: 
7138:         TRY
7139:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7140:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7141:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7142:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7143:             IF VARTYPE(loc_oBusca) = "O"
7144:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7145:                     IF USED("cursor_4c_BuscaClass")
7146:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7147:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7148:                     ENDIF
7149:                 ELSE
7150:                     IF !loc_oBusca.this_lAchouRegistro
7151:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7152:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7153:                     loc_oBusca.Show()
7154:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7155:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7156:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7157:                     ENDIF
7158:                     ENDIF
7159:                 ENDIF
7160:                 loc_oBusca.Release()
7161:             ENDIF
7162:             IF USED("cursor_4c_BuscaClass")
7163:                 USE IN cursor_4c_BuscaClass
7164:             ENDIF
7165:         CATCH TO loc_oErro
7166:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7167:         ENDTRY
7168:     ENDPROC
7169: 
7170:     *--------------------------------------------------------------------------
7171:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7172:     *--------------------------------------------------------------------------
7173:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7174:         IF par_nKeyCode = 115 && F4
7175:             THIS.AbrirLookupLocal()
7176:         ENDIF
7177:     ENDPROC
7178: 
7179:     PROCEDURE TxtLocalLostFocus()
7180:         LOCAL loc_oPg, loc_cCod, loc_nRet
7181:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7182:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7183: 
7184:         IF EMPTY(loc_cCod)
7185:             RETURN
7186:         ENDIF
7187:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7188:             RETURN
7189:         ENDIF
7190: 
7191:         TRY
7192:             loc_nRet = SQLEXEC(gnConnHandle, ;
7193:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7194:                 "cursor_4c_TmpLocal")
7195:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7196:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7197:                 loc_oPg.txt_4c_Local.Value = ""
7198:             ENDIF
7199:             IF USED("cursor_4c_TmpLocal")
7200:                 USE IN cursor_4c_TmpLocal
7201:             ENDIF
7202:         CATCH TO loc_oErro
7203:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7204:         ENDTRY
7205:     ENDPROC
7206: 
7207:     PROCEDURE AbrirLookupLocal()
7208:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7209:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7210:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7211: 
7212:         TRY
7213:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7214:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cAtual, ;
7215:                 "Buscar Local")
7216:             IF VARTYPE(loc_oBusca) = "O"
7217:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7218:                     IF USED("cursor_4c_BuscaLocal")
7219:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7220:                     ENDIF
7221:                 ELSE
7222:                     IF !loc_oBusca.this_lAchouRegistro
7223:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7224:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7225:                     loc_oBusca.Show()
7226:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7227:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7228:                     ENDIF
7229:                     ENDIF
7230:                 ENDIF
7231:                 loc_oBusca.Release()
7232:             ENDIF
7233:             IF USED("cursor_4c_BuscaLocal")
7234:                 USE IN cursor_4c_BuscaLocal
7235:             ENDIF
7236:         CATCH TO loc_oErro
7237:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7238:         ENDTRY
7239:     ENDPROC
7240: 
7241:     *==========================================================================
7242:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7243:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7244:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7245:     * Controles: GrdCons(9 cols), Getqtcpnt, Say7, chkFund, Say1, grDTEMP(2 cols)
7246:     *==========================================================================
7247:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
7248:         LOCAL loc_oPg, loc_oGrd
7249: 
7250:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7251: 
7252:         *----------------------------------------------------------------------
7253:         *-- Cursor placeholder para GrdCons (SigPrCpo + SigCdPrf + SigCdCat)
7254:         *-- Campos: mats(comp), qtds(qtde), unicompos(uni), Grupos(fase code),
7255:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7256:         *----------------------------------------------------------------------
7257:         IF !USED("cursor_4c_GrdCons")
7258:             SET NULL ON
7259:             CREATE CURSOR cursor_4c_GrdCons (;
7260:                 mats      C(14), ;
7261:                 qtds      N(12,4), ;
7262:                 unicompos C(5), ;
7263:                 Grupos    C(3), ;
7264:                 Descrs    C(65), ;
7265:                 Ordems    N(5,0), ;
7266:                 consumo   N(12,4), ;
7267:                 Cods      C(5), ;
7268:                 dcats     C(65), ;
7269:                 Dopes     C(5))
7270:             SET NULL OFF
7271:         ENDIF
7272: 
7273:         *----------------------------------------------------------------------
7274:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7275:         *----------------------------------------------------------------------
7276:         IF !USED("cursor_4c_GrDTEMP")
7277:             SET NULL ON
7278:             CREATE CURSOR cursor_4c_GrDTEMP (;
7279:                 agrup C(30), ;
7280:                 tempo N(12,4))
7281:             SET NULL OFF
7282:         ENDIF
7283: 
7284:         *----------------------------------------------------------------------
7285:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7286:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7287:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao

*-- Linhas 7384 a 7431:
7384:             .Column9.ReadOnly        = .F.
7385:         ENDWITH
7386: 
7387:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7388:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7389:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7390:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7391:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7392: 
7393:         *----------------------------------------------------------------------
7394:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7395:         *----------------------------------------------------------------------
7396:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7397:         WITH loc_oPg.lbl_4c_Label7
7398:             .Caption   = "Qtde Componentes : "
7399:             .Top       = 523
7400:             .Left      = 25
7401:             .Width     = 105
7402:             .Height    = 15
7403:             .FontName  = "Tahoma"
7404:             .FontSize  = 8
7405:             .BackStyle = 0
7406:             .ForeColor = RGB(90, 90, 90)
7407:             .Visible   = .T.
7408:         ENDWITH
7409: 
7410:         *----------------------------------------------------------------------
7411:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)
7412:         *-- Legado When: Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
7413:         *-- Habilitado somente em modo edicao (via HabilitarCampos/DesabilitarCampos)
7414:         *----------------------------------------------------------------------
7415:         loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
7416:         WITH loc_oPg.txt_4c_Qtcpnt
7417:             .Top           = 519
7418:             .Left          = 131
7419:             .Width         = 31
7420:             .Height        = 23
7421:             .FontName      = "Tahoma"
7422:             .FontSize      = 8
7423:             .Value         = 0
7424:             .SpecialEffect = 1
7425:             .ForeColor     = RGB(36, 84, 155)
7426:             .Enabled       = .F.
7427:             .Visible       = .T.
7428:         ENDWITH
7429: 
7430:         *----------------------------------------------------------------------
7431:         *-- CheckBox chkFund (T:544 L:10 W:182 H:15)

*-- Linhas 7522 a 7784:
7522: 
7523:     *==========================================================================
7524:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7525:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7526:     *==========================================================================
7527: 
7528:     *--------------------------------------------------------------------------
7529:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7530:     *--------------------------------------------------------------------------
7531:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7532:         TRY
7533:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7534:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7535:             ENDIF
7536:         CATCH TO loc_oErro
7537:             *-- silencioso: refresh de navegacao nao deve bloquear
7538:         ENDTRY
7539:     ENDPROC
7540: 
7541:     *--------------------------------------------------------------------------
7542:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7543:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7544:     *--------------------------------------------------------------------------
7545:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7546:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7547:         IF par_nKeyCode = 115  && F4
7548:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7549:                 RETURN
7550:             ENDIF
7551:             TRY
7552:                 loc_cAtual = ""
7553:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7554:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7555:                 ENDIF
7556:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7557:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7558:                     "Buscar Fase")
7559:                 IF VARTYPE(loc_oBusca) = "O"
7560:                     IF !loc_oBusca.this_lAchouRegistro
7561:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7562:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7563:                         loc_oBusca.Show()
7564:                     ENDIF
7565:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7566:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7567:                             SELECT cursor_4c_GrdCons
7568:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7569:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7570:                         ENDIF
7571:                     ENDIF
7572:                     loc_oBusca.Release()
7573:                 ENDIF
7574:                 IF USED("cursor_4c_BuscaPrf")
7575:                     USE IN cursor_4c_BuscaPrf
7576:                 ENDIF
7577:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7578:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7579:                 ENDIF
7580:             CATCH TO loc_oErro
7581:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7582:             ENDTRY
7583:         ENDIF
7584:     ENDPROC
7585: 
7586:     *--------------------------------------------------------------------------
7587:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7588:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7589:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7590:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7591:     *--------------------------------------------------------------------------
7592:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7593:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7594:         IF par_nKeyCode = 115  && F4
7595:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7596:                 RETURN
7597:             ENDIF
7598:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7599:             loc_cGrupos = ""
7600:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7601:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7602:             ENDIF
7603:             IF !EMPTY(loc_cGrupos)
7604:                 RETURN
7605:             ENDIF
7606:             TRY
7607:                 loc_cAtual = ""
7608:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7609:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7610:                 ENDIF
7611:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7612:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7613:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7614:                 IF VARTYPE(loc_oBusca) = "O"
7615:                     IF !loc_oBusca.this_lAchouRegistro
7616:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7617:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7618:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7619:                         loc_oBusca.Show()
7620:                     ENDIF
7621:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7622:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7623:                             SELECT cursor_4c_GrdCons
7624:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7625:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7626:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7627:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7628:                             ENDIF
7629:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7630:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7631:                             ENDIF
7632:                         ENDIF
7633:                     ENDIF
7634:                     loc_oBusca.Release()
7635:                 ENDIF
7636:                 IF USED("cursor_4c_BuscaPrf2")
7637:                     USE IN cursor_4c_BuscaPrf2
7638:                 ENDIF
7639:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7640:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7641:                 ENDIF
7642:             CATCH TO loc_oErro
7643:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7644:             ENDTRY
7645:         ENDIF
7646:     ENDPROC
7647: 
7648:     *--------------------------------------------------------------------------
7649:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7650:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7651:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7652:     *--------------------------------------------------------------------------
7653:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7654:         LOCAL loc_oBusca, loc_cAtual
7655:         IF par_nKeyCode = 115  && F4
7656:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7657:                 RETURN
7658:             ENDIF
7659:             TRY
7660:                 loc_cAtual = ""
7661:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7662:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7663:                 ENDIF
7664:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7665:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7666:                     "Buscar Categoria")
7667:                 IF VARTYPE(loc_oBusca) = "O"
7668:                     IF !loc_oBusca.this_lAchouRegistro
7669:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7670:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7671:                         loc_oBusca.Show()
7672:                     ENDIF
7673:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7674:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7675:                             SELECT cursor_4c_GrdCons
7676:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7677:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7678:                         ENDIF
7679:                     ENDIF
7680:                     loc_oBusca.Release()
7681:                 ENDIF
7682:                 IF USED("cursor_4c_BuscaCat")
7683:                     USE IN cursor_4c_BuscaCat
7684:                 ENDIF
7685:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7686:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7687:                 ENDIF
7688:             CATCH TO loc_oErro
7689:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7690:             ENDTRY
7691:         ENDIF
7692:     ENDPROC
7693: 
7694:     *==========================================================================
7695:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7696:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7697:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7698:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7699:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7700:     *==========================================================================
7701:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7702:         LOCAL loc_oPg, loc_oGrd
7703: 
7704:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7705: 
7706:         *----------------------------------------------------------------------
7707:         *-- Cursors cursor_4c_Compo e cursor_4c_Grupo sao compartilhados
7708:         *-- com pgComposicao (criados em ConfigurarPgpgComposicao).
7709:         *-- Nao recriar - usar os ja existentes.
7710:         *----------------------------------------------------------------------
7711: 
7712:         *----------------------------------------------------------------------
7713:         *-- Tipo: lbl_4c_Label1 + cbo_4c_CmbTipos
7714:         *-- Say1: "Tipo :" T:159 L:112 W:29
7715:         *-- cmbTipos: T:154 L:143 W:187 H:23
7716:         *----------------------------------------------------------------------
7717:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
7718:         WITH loc_oPg.lbl_4c_Label1
7719:             .Caption   = "Tipo :"
7720:             .Top       = 159
7721:             .Left      = 112
7722:             .Width     = 29
7723:             .Height    = 15
7724:             .FontName  = "Tahoma"
7725:             .FontSize  = 8
7726:             .BackStyle = 0
7727:             .ForeColor = RGB(90, 90, 90)
7728:             .Visible   = .T.
7729:         ENDWITH
7730: 
7731:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
7732:         WITH loc_oPg.cbo_4c_CmbTipos
7733:             .Top           = 154
7734:             .Left          = 143
7735:             .Width         = 187
7736:             .Height        = 23
7737:             .FontName      = "Tahoma"
7738:             .FontSize      = 8
7739:             .RowSourceType = 0
7740:             .Value         = ""
7741:             .SpecialEffect = 1
7742:             .Visible       = .T.
7743:         ENDWITH
7744:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
7745: 
7746:         *----------------------------------------------------------------------
7747:         *-- Grid grdCompo (12 colunas) - Composicao de custo
7748:         *-- T:178 L:34 W:813 H:230 - usa cursor_4c_Compo (compartilhado)
7749:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7750:         *--          Observacao, Etiq, Consumo, Qtd, Un
7751:         *----------------------------------------------------------------------
7752:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7753:         WITH loc_oPg.grd_4c_CustoCompo
7754:             .Top               = 178
7755:             .Left              = 34
7756:             .Width             = 813
7757:             .Height            = 230
7758:             .ColumnCount       = 12
7759:             .FontName          = "Verdana"
7760:             .FontSize          = 8
7761:             .GridLines         = 3
7762:             .GridLineWidth     = 1
7763:             .GridLineColor     = RGB(238, 238, 238)
7764:             .RecordMark        = .F.
7765:             .DeleteMark        = .F.
7766:             .AllowRowSizing    = .F.
7767:             .ReadOnly          = .F.
7768:             .BackColor         = RGB(255, 255, 255)
7769:             .ForeColor         = RGB(90, 90, 90)
7770:             .HighlightBackColor = RGB(220, 230, 242)
7771:             .HighlightForeColor = RGB(15, 41, 104)
7772:             .HighlightStyle    = 2
7773:             .RowHeight         = 16
7774:             .ScrollBars        = 2
7775:             .Visible           = .T.
7776:         ENDWITH
7777: 
7778:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7779:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7780: 
7781:         *-- Configurar colunas APOS RecordSource
7782:         WITH loc_oPg.grd_4c_CustoCompo
7783:             *-- Col1: Item/Material (C14) W:80
7784:             .Column1.Header1.Caption   = "Item"

*-- Linhas 7851 a 7948:
7851:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7852:             .Column12.ReadOnly         = .T.
7853:         ENDWITH
7854:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7855: 
7856:         *----------------------------------------------------------------------
7857:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7858:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7859:         *----------------------------------------------------------------------
7860:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7861:         WITH loc_oPg.cnt_4c_BotoesCusto
7862:             .Top         = 240
7863:             .Left        = 851
7864:             .Width       = 50
7865:             .Height      = 90
7866:             .BackStyle = 1
7867:             .BackColor = RGB(53, 53, 53)
7868:             .BorderWidth = 0
7869:             .Visible     = .T.
7870:         ENDWITH
7871: 
7872:         *-- Botao 1: Inserir componente de custo
7873:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7874:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto
7875:             .Caption       = "+"
7876:             .Top           = 0
7877:             .Left          = 0
7878:             .Width         = 50
7879:             .Height        = 45
7880:             .FontName      = "Tahoma"
7881:             .FontSize      = 10
7882:             .FontBold      = .T.
7883:             .Themes        = .F.
7884:             .SpecialEffect = 0
7885:             .BackColor     = RGB(255, 255, 255)
7886:             .ForeColor     = RGB(0, 128, 0)
7887:             .Visible       = .T.
7888:         ENDWITH
7889:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto, "Click", THIS, "CmdInserirCustoClick")
7890: 
7891:         *-- Botao 2: Excluir componente de custo
7892:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_ExcluirCusto", "CommandButton")
7893:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto
7894:             .Caption       = "-"
7895:             .Top           = 45
7896:             .Left          = 0
7897:             .Width         = 50
7898:             .Height        = 45
7899:             .FontName      = "Tahoma"
7900:             .FontSize      = 10
7901:             .FontBold      = .T.
7902:             .Themes        = .F.
7903:             .SpecialEffect = 0
7904:             .BackColor     = RGB(255, 255, 255)
7905:             .ForeColor     = RGB(192, 0, 0)
7906:             .Visible       = .T.
7907:         ENDWITH
7908:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto, "Click", THIS, "CmdExcluirCustoClick")
7909: 
7910:         *----------------------------------------------------------------------
7911:         *-- Linha Descricao / Grupo (abaixo do grid e botoes)
7912:         *-- Say16: "Descricao :" T:415 L:52 W:55
7913:         *-- Get_Desc: T:412 L:116 W:304 H:21 - readonly (When=.F.)
7914:         *-- Say2: "Grupo :" T:415 L:479 W:38
7915:         *-- getDGruCompos: T:412 L:522 W:304 H:21 - readonly (When=.F.)
7916:         *----------------------------------------------------------------------
7917:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
7918:         WITH loc_oPg.lbl_4c_Label16
7919:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
7920:             .Top       = 415
7921:             .Left      = 52
7922:             .Width     = 55
7923:             .Height    = 15
7924:             .FontName  = "Tahoma"
7925:             .FontSize  = 8
7926:             .BackStyle = 0
7927:             .ForeColor = RGB(90, 90, 90)
7928:             .Visible   = .T.
7929:         ENDWITH
7930: 
7931:         loc_oPg.AddObject("txt_4c_CustoDesc", "TextBox")
7932:         WITH loc_oPg.txt_4c_CustoDesc
7933:             .Top           = 412
7934:             .Left          = 116
7935:             .Width         = 304
7936:             .Height        = 21
7937:             .FontName      = "Tahoma"
7938:             .FontSize      = 8
7939:             .MaxLength     = 65
7940:             .Value         = ""
7941:             .SpecialEffect = 1
7942:             .Enabled       = .F.
7943:             .Visible       = .T.
7944:         ENDWITH
7945: 
7946:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
7947:         WITH loc_oPg.lbl_4c_Label2
7948:             .Caption   = "Grupo :"

*-- Linhas 8061 a 8236:
8061:     *--------------------------------------------------------------------------
8062:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8063:     *--------------------------------------------------------------------------
8064:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8065:         LOCAL loc_oPg, loc_nRet
8066:         TRY
8067:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8068:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8069:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8070:                 *-- Buscar descricao do grupo
8071:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8072:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8073:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8074:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8075:                         "cursor_4c_TmpGrpCusto")
8076:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8077:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8078:                     ELSE
8079:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8080:                     ENDIF
8081:                     IF USED("cursor_4c_TmpGrpCusto")
8082:                         USE IN cursor_4c_TmpGrpCusto
8083:                     ENDIF
8084:                 ELSE
8085:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8086:                 ENDIF
8087:             ENDIF
8088:         CATCH TO loc_oErro
8089:             *-- silencioso: refresh de display nao deve bloquear navegacao
8090:         ENDTRY
8091:     ENDPROC
8092: 
8093:     *--------------------------------------------------------------------------
8094:     * CboTiposCustoInteractiveChange - Filtra composicao pelo tipo selecionado
8095:     *--------------------------------------------------------------------------
8096:     PROCEDURE CboTiposCustoInteractiveChange()
8097:         LOCAL loc_oPg
8098:         TRY
8099:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8100:             IF USED("cursor_4c_Compo")
8101:                 GO TOP IN cursor_4c_Compo
8102:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8103:             ENDIF
8104:         CATCH TO loc_oErro
8105:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8106:         ENDTRY
8107:     ENDPROC
8108: 
8109:     *--------------------------------------------------------------------------
8110:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8111:     *--------------------------------------------------------------------------
8112:     PROCEDURE CmdInserirCustoClick()
8113:         LOCAL loc_oPg, loc_cTipo
8114:         TRY
8115:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8116:                 RETURN
8117:             ENDIF
8118:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8119:             loc_cTipo = ""
8120:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8121:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8122:             ENDIF
8123:             IF USED("cursor_4c_Compo")
8124:                 SELECT cursor_4c_Compo
8125:                 GO TOP IN cursor_4c_Compo
8126:                 LOCATE FOR EMPTY(mats)
8127:                 IF EOF("cursor_4c_Compo")
8128:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8129:                 ENDIF
8130:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8131:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8132:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8133:                 ENDIF
8134:             ENDIF
8135:         CATCH TO loc_oErro
8136:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8137:         ENDTRY
8138:     ENDPROC
8139: 
8140:     *--------------------------------------------------------------------------
8141:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8142:     *--------------------------------------------------------------------------
8143:     PROCEDURE CmdExcluirCustoClick()
8144:         LOCAL loc_oPg
8145:         TRY
8146:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8147:                 RETURN
8148:             ENDIF
8149:             IF USED("cursor_4c_Compo")
8150:                 SELECT cursor_4c_Compo
8151:                 IF !EOF("cursor_4c_Compo")
8152:                     DELETE
8153:                     IF !EOF("cursor_4c_Compo")
8154:                         SKIP
8155:                         SKIP -1
8156:                     ENDIF
8157:                     GO BOTTOM IN cursor_4c_Compo
8158:                 ENDIF
8159:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8160:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8161:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8162:             ENDIF
8163:         CATCH TO loc_oErro
8164:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8165:         ENDTRY
8166:     ENDPROC
8167: 
8168:     *--------------------------------------------------------------------------
8169:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8170:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8171:     *--------------------------------------------------------------------------
8172:     PROCEDURE AjustarBotoesPorModo()
8173:         LOCAL loc_oPg2, loc_lEditando
8174:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8175: 
8176:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8177:             RETURN
8178:         ENDIF
8179: 
8180:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8181: 
8182:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
8183:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar) = "O"
8184:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEditando
8185:             ENDIF
8186:         ENDIF
8187:     ENDPROC
8188: 
8189:     *==========================================================================
8190:     * FASE 12 - Aba Fases de Producao (PgDadosFaseP - Page4 do pgf_4c_Dados)
8191:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
8192:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8193:     * Controles: 2 grids (GradFase 5col + grdMatrizes 3col), 8 textboxes,
8194:     *            2 checkboxes, 1 editbox, labels, shapes, images, 8 commandbuttons
8195:     *==========================================================================
8196:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
8197:         LOCAL loc_oPg, loc_oGrd
8198:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8199: 
8200:         *----------------------------------------------------------------------
8201:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8202:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8203:         *----------------------------------------------------------------------
8204:         IF !USED("cursor_4c_GradFase")
8205:             SET NULL ON
8206:             CREATE CURSOR cursor_4c_GradFase (;
8207:                 Ordems   N(5,0), ;
8208:                 Grupos   C(10), ;
8209:                 Descrs   C(65), ;
8210:                 UniPrdts C(10), ;
8211:                 MatPrdts C(15), ;
8212:                 Obs      M, ;
8213:                 FigProcs M)
8214:             SET NULL OFF
8215:         ENDIF
8216: 
8217:         *----------------------------------------------------------------------
8218:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8219:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8220:         *----------------------------------------------------------------------
8221:         IF !USED("cursor_4c_SigPrMtz")
8222:             SET NULL ON
8223:             CREATE CURSOR cursor_4c_SigPrMtz (;
8224:                 CMats C(14), ;
8225:                 DLocs C(40), ;
8226:                 Qtds  N(3,0))
8227:             SET NULL OFF
8228:         ENDIF
8229: 
8230:         *----------------------------------------------------------------------
8231:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8232:         *----------------------------------------------------------------------
8233:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8234:         WITH loc_oPg.shp_4c_ShpFig
8235:             .Top         = 152
8236:             .Left        = 231

*-- Linhas 8257 a 8300:
8257:             .Stretch = 2
8258:             .Visible = .F.
8259:         ENDWITH
8260:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
8261: 
8262:         *----------------------------------------------------------------------
8263:         *-- Grid GradFase (T:152 L:527 W:420 H:312) - 5 colunas fases de producao
8264:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8265:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8266:         *----------------------------------------------------------------------
8267:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8268:         loc_oGrd = loc_oPg.grd_4c_GradFase
8269: 
8270:         WITH loc_oGrd
8271:             .Top                = 152
8272:             .Left               = 527
8273:             .Width              = 420
8274:             .Height             = 312
8275:             .FontName           = "Tahoma"
8276:             .FontSize           = 8
8277:             .ColumnCount        = 5
8278:             .GridLines          = 3
8279:             .GridLineWidth      = 1
8280:             .GridLineColor      = RGB(238, 238, 238)
8281:             .RecordMark         = .F.
8282:             .DeleteMark         = .F.
8283:             .AllowRowSizing     = .F.
8284:             .ReadOnly           = .F.
8285:             .BackColor          = RGB(255, 255, 255)
8286:             .ForeColor          = RGB(90, 90, 90)
8287:             .HighlightBackColor = RGB(220, 230, 242)
8288:             .HighlightForeColor = RGB(15, 41, 104)
8289:             .HighlightStyle     = 2
8290:             .RowHeight          = 16
8291:             .ScrollBars         = 2
8292:             .Themes             = .F.
8293:             .Visible            = .T.
8294:         ENDWITH
8295: 
8296:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8297:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8298: 
8299:         *-- Configurar colunas APOS RecordSource
8300:         WITH loc_oPg.grd_4c_GradFase

*-- Linhas 8334 a 8511:
8334:             .Column5.ReadOnly        = .F.
8335:         ENDWITH
8336: 
8337:         *-- BINDEVENT: GradFase
8338:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8339:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8340:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8341:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8342:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8343:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8344: 
8345:         *----------------------------------------------------------------------
8346:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8347:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8348:         *----------------------------------------------------------------------
8349:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8350:         WITH loc_oPg.cmd_4c_IncluirFase
8351:             .Caption       = "+"
8352:             .Top           = 152
8353:             .Left          = 950
8354:             .Width         = 38
8355:             .Height        = 38
8356:             .FontName      = "Tahoma"
8357:             .FontSize      = 10
8358:             .FontBold      = .T.
8359:             .Themes        = .F.
8360:             .SpecialEffect = 0
8361:             .BackColor     = RGB(255, 255, 255)
8362:             .ForeColor     = RGB(0, 128, 0)
8363:             .Visible       = .T.
8364:         ENDWITH
8365:         BINDEVENT(loc_oPg.cmd_4c_IncluirFase, "Click", THIS, "CmdIncluirFaseClick")
8366: 
8367:         *----------------------------------------------------------------------
8368:         *-- Botao Excluir Fase (excluir: T:192 L:950 W:38 H:38)
8369:         *-- Legado: excluir.Click - exclui linha corrente e resequencia
8370:         *----------------------------------------------------------------------
8371:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
8372:         WITH loc_oPg.cmd_4c_ExcluirFase
8373:             .Caption       = "-"
8374:             .Top           = 192
8375:             .Left          = 950
8376:             .Width         = 38
8377:             .Height        = 38
8378:             .FontName      = "Tahoma"
8379:             .FontSize      = 10
8380:             .FontBold      = .T.
8381:             .Themes        = .F.
8382:             .SpecialEffect = 0
8383:             .BackColor     = RGB(255, 255, 255)
8384:             .ForeColor     = RGB(192, 0, 0)
8385:             .Visible       = .T.
8386:         ENDWITH
8387:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "CmdExcluirFaseClick")
8388: 
8389:         *----------------------------------------------------------------------
8390:         *-- Botao Alternativa (Alternativa: T:232 L:950 W:38 H:38)
8391:         *-- Legado: Alternativa.Click - copia linha corrente como alternativa
8392:         *----------------------------------------------------------------------
8393:         loc_oPg.AddObject("cmd_4c_AlternativaFase", "CommandButton")
8394:         WITH loc_oPg.cmd_4c_AlternativaFase
8395:             .Caption       = "A"
8396:             .Top           = 232
8397:             .Left          = 950
8398:             .Width         = 38
8399:             .Height        = 38
8400:             .FontName      = "Tahoma"
8401:             .FontSize      = 9
8402:             .Themes        = .F.
8403:             .SpecialEffect = 0
8404:             .BackColor     = RGB(255, 255, 255)
8405:             .ForeColor     = RGB(90, 90, 90)
8406:             .Visible       = .T.
8407:         ENDWITH
8408:         BINDEVENT(loc_oPg.cmd_4c_AlternativaFase, "Click", THIS, "CmdAlternativaFaseClick")
8409: 
8410:         *----------------------------------------------------------------------
8411:         *-- Botao Ficha Tecnica (CmdFicha: T:152 L:482 W:38 H:38)
8412:         *-- Legado: CmdFicha.Click - gera ficha tecnica com REPORT FORM
8413:         *----------------------------------------------------------------------
8414:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
8415:         WITH loc_oPg.cmd_4c_CmdFicha
8416:             .Caption       = "F"
8417:             .Top           = 152
8418:             .Left          = 482
8419:             .Width         = 38
8420:             .Height        = 38
8421:             .FontName      = "Tahoma"
8422:             .FontSize      = 9
8423:             .Themes        = .F.
8424:             .SpecialEffect = 0
8425:             .BackColor     = RGB(255, 255, 255)
8426:             .ForeColor     = RGB(90, 90, 90)
8427:             .Visible       = .T.
8428:         ENDWITH
8429:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
8430: 
8431:         *----------------------------------------------------------------------
8432:         *-- Botao Selecionar Imagem (cmdgFigura: T:192 L:482 W:40 H:40)
8433:         *-- Legado: cmdgFigura.Click - abre seletor GetPict JPG/BMP
8434:         *----------------------------------------------------------------------
8435:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
8436:         WITH loc_oPg.cmd_4c_CmdgFigura
8437:             .Caption       = "I"
8438:             .Top           = 192
8439:             .Left          = 482
8440:             .Width         = 40
8441:             .Height        = 40
8442:             .FontName      = "Tahoma"
8443:             .FontSize      = 9
8444:             .Themes        = .F.
8445:             .SpecialEffect = 0
8446:             .BackColor     = RGB(255, 255, 255)
8447:             .ForeColor     = RGB(90, 90, 90)
8448:             .Visible       = .T.
8449:         ENDWITH
8450:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
8451: 
8452:         *----------------------------------------------------------------------
8453:         *-- Botao Capturar Webcam (cmdgFigCam: T:232 L:482 W:40 H:40)
8454:         *-- Legado: cmdgFigCam.Click - captura imagem via SigImage form
8455:         *----------------------------------------------------------------------
8456:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
8457:         WITH loc_oPg.cmd_4c_CmdgFigCam
8458:             .Caption       = "C"
8459:             .Top           = 232
8460:             .Left          = 482
8461:             .Width         = 40
8462:             .Height        = 40
8463:             .FontName      = "Tahoma"
8464:             .FontSize      = 9
8465:             .Themes        = .F.
8466:             .SpecialEffect = 0
8467:             .BackColor     = RGB(255, 255, 255)
8468:             .ForeColor     = RGB(90, 90, 90)
8469:             .Visible       = .T.
8470:         ENDWITH
8471:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
8472: 
8473:         *----------------------------------------------------------------------
8474:         *-- Label Say1: "Descricao :" (T:474 L:527 W:67 H:17)
8475:         *----------------------------------------------------------------------
8476:         loc_oPg.AddObject("lbl_4c_Label1FP", "Label")
8477:         WITH loc_oPg.lbl_4c_Label1FP
8478:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
8479:             .Top       = 474
8480:             .Left      = 527
8481:             .Width     = 67
8482:             .Height    = 17
8483:             .FontName  = "Tahoma"
8484:             .FontSize  = 8
8485:             .BackStyle = 0
8486:             .ForeColor = RGB(90, 90, 90)
8487:             .Visible   = .T.
8488:         ENDWITH
8489: 
8490:         *----------------------------------------------------------------------
8491:         *-- TextBox Get_Desc (T:471 L:595 W:395 H:23) - descricao da fase
8492:         *-- Readonly - preenchido pelo GradFaseAfterRowColChange (campo Descrs)
8493:         *----------------------------------------------------------------------
8494:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8495:         WITH loc_oPg.txt_4c_Desc
8496:             .Top           = 471
8497:             .Left          = 595
8498:             .Width         = 395
8499:             .Height        = 23
8500:             .Value         = ""
8501:             .FontName      = "Tahoma"
8502:             .FontSize      = 8
8503:             .ReadOnly      = .T.
8504:             .SpecialEffect = 1
8505:             .ForeColor     = RGB(36, 84, 155)
8506:             .BackColor     = RGB(240, 240, 240)
8507:             .Visible       = .T.
8508:         ENDWITH
8509: 
8510:         *----------------------------------------------------------------------
8511:         *-- EditBox Get_Obs (T:497 L:527 W:463 H:122) - observacoes da fase

*-- Linhas 8629 a 8672:
8629:             .Enabled       = .F.
8630:             .Visible       = .T.
8631:         ENDWITH
8632:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "TxtConquilhaLostFocus")
8633: 
8634:         *-- Label Say9: "Peso Brilhante :" (T:231 L:58 W:77 H:15)
8635:         loc_oPg.AddObject("lbl_4c_Label9FP", "Label")
8636:         WITH loc_oPg.lbl_4c_Label9FP
8637:             .Caption   = "Peso Brilhante :"
8638:             .Top       = 451
8639:             .Left      = 884
8640:             .Width     = 77
8641:             .Height    = 15
8642:             .FontName  = "Tahoma"
8643:             .FontSize  = 8
8644:             .BackStyle = 0
8645:             .ForeColor = RGB(90, 90, 90)
8646:             .Visible   = .T.
8647:         ENDWITH
8648: 
8649:         *-- TextBox getPesoBris (T:227 L:137 W:80 H:23)
8650:         *-- Legado: pesobris de SigCdPro
8651:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
8652:         WITH loc_oPg.txt_4c_PesoBris
8653:             .Top           = 227
8654:             .Left          = 137
8655:             .Width         = 80
8656:             .Height        = 23
8657:             .Value         = 0
8658:             .FontName      = "Tahoma"
8659:             .FontSize      = 8
8660:             .SpecialEffect = 1
8661:             .ForeColor     = RGB(36, 84, 155)
8662:             .Enabled       = .F.
8663:             .Visible       = .T.
8664:         ENDWITH
8665: 
8666:         *-- Label Say10: "Peso Metal :" (T:256 L:74 W:61 H:15)
8667:         loc_oPg.AddObject("lbl_4c_Label10FP", "Label")
8668:         WITH loc_oPg.lbl_4c_Label10FP
8669:             .Caption   = "Peso Metal :"
8670:             .Top       = 451
8671:             .Left      = 967
8672:             .Width     = 61

*-- Linhas 8758 a 8801:
8758:             .Enabled       = .F.
8759:             .Visible       = .T.
8760:         ENDWITH
8761:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "TxtCorLostFocus")
8762: 
8763:         *-- CheckBox opc_CravCera: "Cravacao em Cera" (T:306 L:180 W:120 H:15)
8764:         *-- Legado: cravcers de SigCdPro (numeric 1,0 com semantica booleana)
8765:         loc_oPg.AddObject("chk_4c_Opc_CravCera", "CheckBox")
8766:         WITH loc_oPg.chk_4c_Opc_CravCera
8767:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
8768:             .Top       = 306
8769:             .Left      = 180
8770:             .Width     = 120
8771:             .Height    = 15
8772:             .Value     = 0
8773:             .FontName  = "Tahoma"
8774:             .FontSize  = 8
8775:             .BackStyle = 0
8776:             .Themes    = .F.
8777:             .Enabled   = .F.
8778:             .Visible   = .T.
8779:         ENDWITH
8780: 
8781:         *-- Label Say2: "Tamanho Padrao :" (T:331 L:45 W:90 H:15)
8782:         loc_oPg.AddObject("lbl_4c_Label2FP", "Label")
8783:         WITH loc_oPg.lbl_4c_Label2FP
8784:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
8785:             .Top       = 331
8786:             .Left      = 45
8787:             .Width     = 90
8788:             .Height    = 15
8789:             .FontName  = "Tahoma"
8790:             .FontSize  = 8
8791:             .BackStyle = 0
8792:             .ForeColor = RGB(90, 90, 90)
8793:             .Visible   = .T.
8794:         ENDWITH
8795: 
8796:         *-- TextBox getTam: tamanho padrao (T:327 L:137 W:38 H:23)
8797:         *-- Legado: codtams de SigCdPro - LostFocus lookup SigCdTam
8798:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
8799:         WITH loc_oPg.txt_4c_Tam
8800:             .Top           = 327
8801:             .Left          = 137

*-- Linhas 8809 a 8852:
8809:             .Enabled       = .F.
8810:             .Visible       = .T.
8811:         ENDWITH
8812:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "TxtTamLostFocus")
8813: 
8814:         *-- CheckBox fwoption1: "Peso Variavel" (T:331 L:180 W:90 H:15)
8815:         *-- Legado: prodvars de SigCdPro (numeric 1,0 com semantica booleana)
8816:         loc_oPg.AddObject("chk_4c_Fwoption1", "CheckBox")
8817:         WITH loc_oPg.chk_4c_Fwoption1
8818:             .Caption   = "Peso Vari" + CHR(225) + "vel"
8819:             .Top       = 172
8820:             .Left      = 879
8821:             .Width     = 90
8822:             .Height    = 15
8823:             .Value     = 0
8824:             .FontName  = "Tahoma"
8825:             .FontSize  = 8
8826:             .BackStyle = 0
8827:             .Themes    = .F.
8828:             .Enabled   = .F.
8829:             .Visible   = .T.
8830:         ENDWITH
8831: 
8832:         *-- Label lblAcabamento: "Acabamento :" (T:356 L:16 W:119 H:15)
8833:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
8834:         WITH loc_oPg.lbl_4c_LblAcabamento
8835:             .Caption   = "Acabamento :"
8836:             .Top       = 356
8837:             .Left      = 16
8838:             .Width     = 119
8839:             .Height    = 15
8840:             .FontName  = "Tahoma"
8841:             .FontSize  = 8
8842:             .BackStyle = 0
8843:             .ForeColor = RGB(90, 90, 90)
8844:             .Visible   = .T.
8845:         ENDWITH
8846: 
8847:         *-- TextBox get_codacb: codigo acabamento (T:352 L:137 W:38 H:23)
8848:         *-- Legado: codacbs de SigCdPro - LostFocus lookup SigCdAca
8849:         loc_oPg.AddObject("txt_4c__codacb", "TextBox")
8850:         WITH loc_oPg.txt_4c__codacb
8851:             .Top           = 352
8852:             .Left          = 137

*-- Linhas 8860 a 8903:
8860:             .Enabled       = .F.
8861:             .Visible       = .T.
8862:         ENDWITH
8863:         BINDEVENT(loc_oPg.txt_4c__codacb, "LostFocus", THIS, "TxtCodacbLostFocus")
8864: 
8865:         *-- TextBox get_Dacb: descricao acabamento (T:352 L:177 W:207 H:23)
8866:         *-- Legado: When=.F. (readonly sempre) - preenchido pelo lookup de get_codacb
8867:         loc_oPg.AddObject("txt_4c__Dacb", "TextBox")
8868:         WITH loc_oPg.txt_4c__Dacb
8869:             .Top           = 352
8870:             .Left          = 177
8871:             .Width         = 207
8872:             .Height        = 23
8873:             .Value         = ""
8874:             .FontName      = "Tahoma"
8875:             .FontSize      = 8
8876:             .ReadOnly      = .T.
8877:             .SpecialEffect = 1
8878:             .ForeColor     = RGB(36, 84, 155)
8879:             .BackColor     = RGB(240, 240, 240)
8880:             .Enabled       = .F.
8881:             .Visible       = .T.
8882:         ENDWITH
8883: 
8884:         *----------------------------------------------------------------------
8885:         *-- Secao inferior esquerda: grdMatrizes + botoes + imagem borracha
8886:         *----------------------------------------------------------------------
8887: 
8888:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8889:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8890:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8891:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8892: 
8893:         WITH loc_oGrd
8894:             .Top                = 380
8895:             .Left               = 7
8896:             .Width              = 246
8897:             .Height             = 240
8898:             .FontName           = "Tahoma"
8899:             .FontSize           = 8
8900:             .ColumnCount        = 3
8901:             .GridLines          = 3
8902:             .GridLineWidth      = 1
8903:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 8943 a 9070:
8943:             .Column3.ReadOnly        = .F.
8944:         ENDWITH
8945: 
8946:         *-- BINDEVENT: grdMatrizes
8947:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8948:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8949: 
8950:         *----------------------------------------------------------------------
8951:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8952:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8953:         *----------------------------------------------------------------------
8954:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8955:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8956:             .Caption       = "+"
8957:             .Top           = 380
8958:             .Left          = 258
8959:             .Width         = 38
8960:             .Height        = 38
8961:             .FontName      = "Tahoma"
8962:             .FontSize      = 10
8963:             .FontBold      = .T.
8964:             .Themes        = .F.
8965:             .SpecialEffect = 0
8966:             .BackColor     = RGB(255, 255, 255)
8967:             .ForeColor     = RGB(0, 128, 0)
8968:             .Visible       = .T.
8969:         ENDWITH
8970:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
8971: 
8972:         *----------------------------------------------------------------------
8973:         *-- Botao Excluir Matriz (btnExcluiMtz: T:420 L:258 W:38 H:38)
8974:         *-- Legado: btnExcluiMtz.Click - exclui linha de crSigPrMtz
8975:         *----------------------------------------------------------------------
8976:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
8977:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
8978:             .Caption       = "-"
8979:             .Top           = 420
8980:             .Left          = 258
8981:             .Width         = 38
8982:             .Height        = 38
8983:             .FontName      = "Tahoma"
8984:             .FontSize      = 10
8985:             .FontBold      = .T.
8986:             .Themes        = .F.
8987:             .SpecialEffect = 0
8988:             .BackColor     = RGB(255, 255, 255)
8989:             .ForeColor     = RGB(192, 0, 0)
8990:             .Visible       = .T.
8991:         ENDWITH
8992:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
8993: 
8994:         *----------------------------------------------------------------------
8995:         *-- Shape: shpBorracha (T:464 L:258 W:236 H:156) - borda imagem borracha
8996:         *----------------------------------------------------------------------
8997:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
8998:         WITH loc_oPg.shp_4c_ShpBorracha
8999:             .Top         = 464
9000:             .Left        = 258
9001:             .Width       = 236
9002:             .Height      = 156
9003:             .BackStyle   = 1
9004:             .BackColor   = RGB(255, 255, 255)
9005:             .BorderColor = RGB(192, 192, 192)
9006:             .BorderWidth = 1
9007:             .Visible     = .T.
9008:         ENDWITH
9009: 
9010:         *----------------------------------------------------------------------
9011:         *-- Image: ImgBorracha (T:465 L:260 W:232 H:154) - imagem borracha da matriz
9012:         *-- Legado: GrdMatrizes.AfterRowColChange carrega SigCdPro da matriz corrente
9013:         *----------------------------------------------------------------------
9014:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
9015:         WITH loc_oPg.img_4c_ImgBorracha
9016:             .Top     = 465
9017:             .Left    = 260
9018:             .Width   = 232
9019:             .Height  = 154
9020:             .Picture = ""
9021:             .Stretch = 2
9022:             .Visible = .F.
9023:         ENDWITH
9024:     ENDPROC
9025: 
9026:     *--------------------------------------------------------------------------
9027:     * PreencherCamposFaseP - Popula controles da aba FaseP a partir do BO
9028:     * Chamado por BOParaForm apos carregar dados de SigCdPro
9029:     *--------------------------------------------------------------------------
9030:     PROTECTED PROCEDURE PreencherCamposFaseP()
9031:         LOCAL loc_oPg
9032:         TRY
9033:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9034:                 RETURN
9035:             ENDIF
9036:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9037:             IF VARTYPE(loc_oPg) # "O"
9038:                 RETURN
9039:             ENDIF
9040:             WITH THIS.this_oBusinessObject
9041:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9042:                     loc_oPg.txt_4c_Qmin.Value = IIF(.this_nQmins = 0, 0, .this_nQmins)
9043:                 ENDIF
9044:                 IF VARTYPE(loc_oPg.txt_4c_CodGarras) = "O"
9045:                     loc_oPg.txt_4c_CodGarras.Value = ALLTRIM(.this_cCodgarras)
9046:                 ENDIF
9047:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9048:                     loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(.this_cConquilhas)
9049:                 ENDIF
9050:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9051:                     loc_oPg.txt_4c_PesoBris.Value = .this_nPesobris
9052:                 ENDIF
9053:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9054:                     loc_oPg.txt_4c_PesoMetal.Value = .this_nPesometal
9055:                 ENDIF
9056:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9057:                     loc_oPg.txt_4c_PesoPdrs.Value = .this_nPesopdrs
9058:                 ENDIF
9059:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9060:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(.this_cCodcors)
9061:                 ENDIF
9062:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9063:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(.this_cCodtams)
9064:                 ENDIF
9065:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9066:                     loc_oPg.txt_4c__codacb.Value = ALLTRIM(.this_cCodacbs)
9067:                 ENDIF
9068:                 IF VARTYPE(loc_oPg.txt_4c__Dacb) = "O"
9069:                     loc_oPg.txt_4c__Dacb.Value = ""
9070:                 ENDIF

*-- Linhas 9084 a 9127:
9084:     * LerCamposFaseP - Le controles da aba FaseP e transfere para o BO
9085:     * Chamado por FormParaBO antes de salvar
9086:     *--------------------------------------------------------------------------
9087:     PROTECTED PROCEDURE LerCamposFaseP()
9088:         LOCAL loc_oPg
9089:         TRY
9090:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9091:                 RETURN
9092:             ENDIF
9093:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9094:             IF VARTYPE(loc_oPg) # "O"
9095:                 RETURN
9096:             ENDIF
9097:             WITH THIS.this_oBusinessObject
9098:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9099:                     .this_nQmins = loc_oPg.txt_4c_Qmin.Value
9100:                 ENDIF
9101:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9102:                     .this_cConquilhas = ALLTRIM(loc_oPg.txt_4c_Conquilha.Value)
9103:                 ENDIF
9104:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9105:                     .this_nPesobris = loc_oPg.txt_4c_PesoBris.Value
9106:                 ENDIF
9107:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9108:                     .this_nPesometal = loc_oPg.txt_4c_PesoMetal.Value
9109:                 ENDIF
9110:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9111:                     .this_nPesopdrs = loc_oPg.txt_4c_PesoPdrs.Value
9112:                 ENDIF
9113:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9114:                     .this_cCodcors = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9115:                 ENDIF
9116:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9117:                     .this_cCodtams = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9118:                 ENDIF
9119:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9120:                     .this_cCodacbs = ALLTRIM(loc_oPg.txt_4c__codacb.Value)
9121:                 ENDIF
9122:                 IF VARTYPE(loc_oPg.chk_4c_Opc_CravCera) = "O"
9123:                     .this_lCravcers = (loc_oPg.chk_4c_Opc_CravCera.Value = 1)
9124:                 ENDIF
9125:                 IF VARTYPE(loc_oPg.chk_4c_Fwoption1) = "O"
9126:                     .this_nProdvars = IIF(loc_oPg.chk_4c_Fwoption1.Value = 1, 1, 0)
9127:                 ENDIF

*-- Linhas 9133 a 9178:
9133: 
9134:     *--------------------------------------------------------------------------
9135:     * GradFaseAfterRowColChange - Atualiza imagem e descricao ao navegar GradFase
9136:     * Legado: GradFase.AfterRowColChange (Procedure) - carrega FigProcs, Get_Desc, Get_Obs
9137:     *--------------------------------------------------------------------------
9138:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9139:         LOCAL loc_oPg, loc_lcArquivo
9140:         TRY
9141:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9142:                 RETURN
9143:             ENDIF
9144:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9145:             IF VARTYPE(loc_oPg) # "O"
9146:                 RETURN
9147:             ENDIF
9148: 
9149:             *-- Atualizar descricao da fase (campo Descrs do cursor)
9150:             IF VARTYPE(loc_oPg.txt_4c_Desc) = "O"
9151:                 loc_oPg.txt_4c_Desc.Value = ""
9152:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9153:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9154:                 ENDIF
9155:             ENDIF
9156: 
9157:             *-- Atualizar observacoes da fase (campo Obs de crSigCdPrf se disponivel)
9158:             IF VARTYPE(loc_oPg.obj_4c_Get_Obs) = "O"
9159:                 loc_oPg.obj_4c_Get_Obs.Value = ""
9160:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9161:                     IF TYPE("cursor_4c_GradFase.Obs") # "U"
9162:                         loc_oPg.obj_4c_Get_Obs.Value = NVL(cursor_4c_GradFase.Obs, "")
9163:                     ENDIF
9164:                 ENDIF
9165:             ENDIF
9166: 
9167:             *-- Atualizar imagem da fase (campo FigProcs de crSigCdPrf se disponivel)
9168:             IF VARTYPE(loc_oPg.img_4c_ImgFigJpg) = "O"
9169:                 CLEAR RESOURCES
9170:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
9171:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
9172:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9173:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9174:                         IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9175:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9176:                             IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9177:                                 loc_oPg.img_4c_ImgFigJpg.Picture  = loc_lcArquivo
9178:                                 loc_oPg.img_4c_ImgFigJpg.Visible  = .T.

*-- Linhas 9192 a 9440:
9192:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9193:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9194:     *--------------------------------------------------------------------------
9195:     PROCEDURE GradFaseCol1GotFocus()
9196:         TRY
9197:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9198:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9199:             ENDIF
9200:         CATCH TO loc_oErro
9201:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9202:         ENDTRY
9203:     ENDPROC
9204: 
9205:     *--------------------------------------------------------------------------
9206:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9207:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9208:     *--------------------------------------------------------------------------
9209:     PROCEDURE GradFaseCol1LostFocus()
9210:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9211:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9212:             RETURN
9213:         ENDIF
9214:         loc_lResultado = .T.
9215:         TRY
9216:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9217:                 loc_lResultado = .F.
9218:             ENDIF
9219:             IF loc_lResultado
9220:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9221:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9222:                     loc_lResultado = .F.
9223:                 ENDIF
9224:             ENDIF
9225:             IF loc_lResultado
9226:                 *-- Calcular Ordem2 para resequenciamento
9227:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9228:                 SELECT cursor_4c_GradFase
9229:                 SCAN
9230:                     IF RECNO() # loc_nPonteiro
9231:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9232:                     ENDIF
9233:                 ENDSCAN
9234:                 GO loc_nPonteiro IN cursor_4c_GradFase
9235:                 SELECT cursor_4c_GradFase
9236:                 *-- Reordenar por Ordems para refletir nova sequencia
9237:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9238:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9239:                 ENDIF
9240:             ENDIF
9241:         CATCH TO loc_oErro
9242:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9243:         ENDTRY
9244:     ENDPROC
9245: 
9246:     *--------------------------------------------------------------------------
9247:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9248:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9249:     *         Apos selecao: preenche Grupos e Descrs no cursor
9250:     *--------------------------------------------------------------------------
9251:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9252:         LOCAL loc_oBusca, loc_cAtual
9253:         IF par_nKeyCode = 115  && F4
9254:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9255:                 RETURN
9256:             ENDIF
9257:             TRY
9258:                 loc_cAtual = ""
9259:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9260:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9261:                 ENDIF
9262:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9263:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9264:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9265:                 IF VARTYPE(loc_oBusca) = "O"
9266:                     IF !loc_oBusca.this_lAchouRegistro
9267:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9268:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9269:                         loc_oBusca.Show()
9270:                     ENDIF
9271:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9272:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9273:                             SELECT cursor_4c_GradFase
9274:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9275:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9276:                         ENDIF
9277:                     ENDIF
9278:                     loc_oBusca.Release()
9279:                 ENDIF
9280:                 IF USED("cursor_4c_BuscaGcr")
9281:                     USE IN cursor_4c_BuscaGcr
9282:                 ENDIF
9283:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9284:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9285:                 ENDIF
9286:             CATCH TO loc_oErro
9287:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9288:             ENDTRY
9289:         ENDIF
9290:     ENDPROC
9291: 
9292:     *--------------------------------------------------------------------------
9293:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9294:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9295:     *         Apos selecao: preenche UniPrdts no cursor
9296:     *--------------------------------------------------------------------------
9297:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9298:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9299:         IF par_nKeyCode = 115  && F4
9300:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9301:                 RETURN
9302:             ENDIF
9303:             TRY
9304:                 loc_cAtual  = ""
9305:                 loc_cGrupos = ""
9306:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9307:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9308:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9309:                 ENDIF
9310:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9311:                 IF !EMPTY(loc_cGrupos)
9312:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9313:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9314:                 ELSE
9315:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9316:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9317:                 ENDIF
9318:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9319:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9320:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9321:                         "Buscar Uni. Produtiva")
9322:                     IF VARTYPE(loc_oBusca) = "O"
9323:                         IF !loc_oBusca.this_lAchouRegistro
9324:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9325:                             loc_oBusca.Show()
9326:                         ENDIF
9327:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9328:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9329:                                 SELECT cursor_4c_GradFase
9330:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9331:                             ENDIF
9332:                         ENDIF
9333:                         loc_oBusca.Release()
9334:                     ENDIF
9335:                     IF USED("cursor_4c_BuscaUpd2")
9336:                         USE IN cursor_4c_BuscaUpd2
9337:                     ENDIF
9338:                 ENDIF
9339:                 IF USED("cursor_4c_BuscaUpd")
9340:                     USE IN cursor_4c_BuscaUpd
9341:                 ENDIF
9342:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9343:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9344:                 ENDIF
9345:             CATCH TO loc_oErro
9346:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9347:             ENDTRY
9348:         ENDIF
9349:     ENDPROC
9350: 
9351:     *--------------------------------------------------------------------------
9352:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9353:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9354:     *         Apos selecao: preenche MatPrdts no cursor
9355:     *--------------------------------------------------------------------------
9356:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9357:         LOCAL loc_oBusca, loc_cAtual
9358:         IF par_nKeyCode = 115  && F4
9359:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9360:                 RETURN
9361:             ENDIF
9362:             TRY
9363:                 loc_cAtual = ""
9364:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9365:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9366:                 ENDIF
9367:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9368:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9369:                     "Buscar Tipo de Material")
9370:                 IF VARTYPE(loc_oBusca) = "O"
9371:                     IF !loc_oBusca.this_lAchouRegistro
9372:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9373:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9374:                         loc_oBusca.Show()
9375:                     ENDIF
9376:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9377:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9378:                             SELECT cursor_4c_GradFase
9379:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9380:                         ENDIF
9381:                     ENDIF
9382:                     loc_oBusca.Release()
9383:                 ENDIF
9384:                 IF USED("cursor_4c_BuscaOpt")
9385:                     USE IN cursor_4c_BuscaOpt
9386:                 ENDIF
9387:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9388:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9389:                 ENDIF
9390:             CATCH TO loc_oErro
9391:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9392:             ENDTRY
9393:         ENDIF
9394:     ENDPROC
9395: 
9396:     *--------------------------------------------------------------------------
9397:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9398:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9399:     *--------------------------------------------------------------------------
9400:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9401:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9402:         TRY
9403:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9404:                 RETURN
9405:             ENDIF
9406:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9407:             IF VARTYPE(loc_oPg) # "O"
9408:                 RETURN
9409:             ENDIF
9410: 
9411:             *-- Limpar imagem anterior
9412:             CLEAR RESOURCES
9413:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9414:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9415: 
9416:             *-- Carregar imagem da borracha do produto-matriz corrente
9417:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9418:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9419:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9420:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9421:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9422:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9423:                         GO TOP IN cursor_4c_LocalImgPro
9424:                         IF !EOF("cursor_4c_LocalImgPro")
9425:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9426:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9427:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9428:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9429:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9430:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9431:                                     ENDIF
9432:                                 ENDIF
9433:                             ENDIF
9434:                         ENDIF
9435:                         USE IN cursor_4c_LocalImgPro
9436:                     ENDIF
9437:                 ENDIF
9438:             ENDIF
9439: 
9440:             loc_oPg.grd_4c_Matrizes.Refresh()

*-- Linhas 9448 a 10151:
9448:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9449:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9450:     *--------------------------------------------------------------------------
9451:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9452:         LOCAL loc_oBusca, loc_cAtual
9453:         IF par_nKeyCode = 115  && F4
9454:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9455:                 RETURN
9456:             ENDIF
9457:             TRY
9458:                 loc_cAtual = ""
9459:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9460:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9461:                 ENDIF
9462:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9463:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9464:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9465:                     "Buscar Matriz")
9466:                 IF VARTYPE(loc_oBusca) = "O"
9467:                     IF !loc_oBusca.this_lAchouRegistro
9468:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9469:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9470:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9471:                         loc_oBusca.Show()
9472:                     ENDIF
9473:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9474:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9475:                             SELECT cursor_4c_SigPrMtz
9476:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9477:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9478:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9479:                             ENDIF
9480:                         ENDIF
9481:                     ENDIF
9482:                     loc_oBusca.Release()
9483:                 ENDIF
9484:                 IF USED("cursor_4c_BuscaMatriz")
9485:                     USE IN cursor_4c_BuscaMatriz
9486:                 ENDIF
9487:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9488:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9489:                 ENDIF
9490:             CATCH TO loc_oErro
9491:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9492:             ENDTRY
9493:         ENDIF
9494:     ENDPROC
9495: 
9496:     *--------------------------------------------------------------------------
9497:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9498:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9499:     *--------------------------------------------------------------------------
9500:     PROCEDURE CmdIncluirFaseClick()
9501:         LOCAL loc_oPg, loc_nOrdem
9502:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9503:             RETURN
9504:         ENDIF
9505:         TRY
9506:             IF !USED("cursor_4c_GradFase")
9507:                 RETURN
9508:             ENDIF
9509:             *-- Calcular proximo numero de ordem
9510:             loc_nOrdem = 0
9511:             IF !EOF("cursor_4c_GradFase")
9512:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9513:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9514:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9515:                 ENDIF
9516:                 IF USED("cursor_4c_TmpOrd")
9517:                     USE IN cursor_4c_TmpOrd
9518:                 ENDIF
9519:             ENDIF
9520:             loc_nOrdem = loc_nOrdem + 1
9521:             *-- Inserir nova linha
9522:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9523:                 VALUES (loc_nOrdem, "", "", "", "")
9524:             *-- Posicionar no novo registro e focar grid
9525:             GO BOTTOM IN cursor_4c_GradFase
9526:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9527:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9528:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9529:                     loc_oPg.grd_4c_GradFase.Refresh()
9530:                     loc_oPg.grd_4c_GradFase.SetFocus()
9531:                 ENDIF
9532:             ENDIF
9533:         CATCH TO loc_oErro
9534:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9535:         ENDTRY
9536:     ENDPROC
9537: 
9538:     *--------------------------------------------------------------------------
9539:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9540:     * Legado: excluir.Click - DELETE e resequencia Ordems
9541:     *--------------------------------------------------------------------------
9542:     PROCEDURE CmdExcluirFaseClick()
9543:         LOCAL loc_oPg, loc_lResultado
9544:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9545:             RETURN
9546:         ENDIF
9547:         loc_lResultado = .T.
9548:         TRY
9549:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9550:                 loc_lResultado = .F.
9551:             ENDIF
9552:             IF loc_lResultado
9553:                 IF !MsgConfirma("Excluir fase selecionada?")
9554:                     loc_lResultado = .F.
9555:                 ENDIF
9556:             ENDIF
9557:             IF loc_lResultado
9558:                 SELECT cursor_4c_GradFase
9559:                 DELETE
9560:                 IF !EOF("cursor_4c_GradFase")
9561:                     SKIP
9562:                 ENDIF
9563:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9564:                     GO BOTTOM IN cursor_4c_GradFase
9565:                 ENDIF
9566:                 *-- Resequenciar Ordems
9567:                 LOCAL loc_nSeq
9568:                 loc_nSeq = 1
9569:                 GO TOP IN cursor_4c_GradFase
9570:                 SCAN FOR !DELETED()
9571:                     REPLACE Ordems WITH loc_nSeq
9572:                     loc_nSeq = loc_nSeq + 1
9573:                 ENDSCAN
9574:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9575:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9576:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9577:                         loc_oPg.grd_4c_GradFase.Refresh()
9578:                     ENDIF
9579:                 ENDIF
9580:             ENDIF
9581:         CATCH TO loc_oErro
9582:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9583:         ENDTRY
9584:     ENDPROC
9585: 
9586:     *--------------------------------------------------------------------------
9587:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9588:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9589:     *--------------------------------------------------------------------------
9590:     PROCEDURE CmdAlternativaFaseClick()
9591:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9592:         LOCAL loc_nOrdem
9593:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9594:             RETURN
9595:         ENDIF
9596:         loc_lResultado = .T.
9597:         TRY
9598:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9599:                 loc_lResultado = .F.
9600:             ENDIF
9601:             IF loc_lResultado
9602:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_GradFase.Grupos, "")))
9603:                     MsgAviso("Selecione uma fase para criar alternativa.")
9604:                     loc_lResultado = .F.
9605:                 ENDIF
9606:             ENDIF
9607:             IF loc_lResultado
9608:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9609:                 loc_cDescrs = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9610:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9611:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9612:                 *-- Calcular proxima ordem
9613:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9614:                 loc_nOrdem = 1
9615:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9616:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9617:                 ENDIF
9618:                 IF USED("cursor_4c_TmpAlt")
9619:                     USE IN cursor_4c_TmpAlt
9620:                 ENDIF
9621:                 *-- Inserir copia como alternativa
9622:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9623:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9624:                 GO BOTTOM IN cursor_4c_GradFase
9625:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9626:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9627:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9628:                         loc_oPg.grd_4c_GradFase.Refresh()
9629:                     ENDIF
9630:                 ENDIF
9631:             ENDIF
9632:         CATCH TO loc_oErro
9633:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9634:         ENDTRY
9635:     ENDPROC
9636: 
9637:     *--------------------------------------------------------------------------
9638:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9639:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9640:     *--------------------------------------------------------------------------
9641:     PROCEDURE CmdFichaClick()
9642:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9643:         loc_lResultado = .T.
9644:         TRY
9645:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9646:                 loc_lResultado = .F.
9647:             ENDIF
9648:             IF loc_lResultado
9649:                 IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
9650:                     MsgAviso("Produto n" + CHR(227) + "o selecionado.")
9651:                     loc_lResultado = .F.
9652:                 ENDIF
9653:             ENDIF
9654:             IF loc_lResultado
9655:                 *-- Nome da empresa ja disponivel em go_4c_Sistema.cEmpresa
9656:                 loc_cNmEmp = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
9657:                 *-- Preparar cursor de cabecalho para o relatorio
9658:                 IF USED("CsCabecalho")
9659:                     USE IN CsCabecalho
9660:                 ENDIF
9661:                 CREATE CURSOR CsCabecalho (;
9662:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9663:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9664:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9665:                     _nPeso N(9,2))
9666:                 WITH THIS.this_oBusinessObject
9667:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9668:                         VALUES (loc_cNmEmp, ;
9669:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9670:                                 ALLTRIM(.this_cCpros), ;
9671:                                 ALLTRIM(.this_cDpros), ;
9672:                                 ALLTRIM(.this_cCgrus), ;
9673:                                 .this_nPesobs)
9674:                 ENDWITH
9675:                 *-- Verificar e executar relatorio
9676:                 LOCAL loc_cRepPath
9677:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9678:                 IF FILE(loc_cRepPath)
9679:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9680:                 ELSE
9681:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9682:                 ENDIF
9683:                 IF USED("CsCabecalho")
9684:                     USE IN CsCabecalho
9685:                 ENDIF
9686:             ENDIF
9687:         CATCH TO loc_oErro
9688:             MsgErro(loc_oErro.Message, "Erro ao gerar ficha t" + CHR(233) + "cnica")
9689:         ENDTRY
9690:     ENDPROC
9691: 
9692:     *--------------------------------------------------------------------------
9693:     * CmdgFiguraClick - Seleciona imagem JPG/BMP para a fase corrente
9694:     * Legado: cmdgFigura.Click - GETPICT e armazena em crSigCdPrf.FigProcs
9695:     *--------------------------------------------------------------------------
9696:     PROCEDURE CmdgFiguraClick()
9697:         LOCAL loc_lResultado, loc_cFigura, loc_cArquivo
9698:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9699:             RETURN
9700:         ENDIF
9701:         loc_lResultado = .T.
9702:         TRY
9703:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9704:                 loc_lResultado = .F.
9705:             ENDIF
9706:             IF loc_lResultado
9707:                 *-- Abrir seletor de arquivo de imagem
9708:                 loc_cFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
9709:                     "Nome do Arquivo:", "Selecionar"))
9710:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9711:                     *-- Armazenar imagem binaria no campo memo FigProcs
9712:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9713:                         SELECT cursor_4c_GradFase
9714:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9715:                     ENDIF
9716:                     *-- Atualizar exibicao da imagem
9717:                     THIS.GradFaseAfterRowColChange(0)
9718:                 ENDIF
9719:             ENDIF
9720:         CATCH TO loc_oErro
9721:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9722:         ENDTRY
9723:     ENDPROC
9724: 
9725:     *--------------------------------------------------------------------------
9726:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9727:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9728:     *--------------------------------------------------------------------------
9729:     PROCEDURE CmdgFigCamClick()
9730:         LOCAL loc_lResultado, loc_cFigura
9731:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9732:             RETURN
9733:         ENDIF
9734:         loc_lResultado = .T.
9735:         TRY
9736:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9737:                 loc_lResultado = .F.
9738:             ENDIF
9739:             IF loc_lResultado
9740:                 loc_cFigura = ""
9741:                 *-- Acionar captura de webcam via form legado SigImage
9742:                 IF FILE(gc_4c_CaminhoBase + "SigImage.scx")
9743:                     DO FORM (gc_4c_CaminhoBase + "SigImage") TO loc_cFigura
9744:                 ELSE
9745:                     MsgAviso("Captura de imagem (SigImage) n" + CHR(227) + "o dispon" + CHR(237) + "vel.")
9746:                     loc_lResultado = .F.
9747:                 ENDIF
9748:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9749:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9750:                         SELECT cursor_4c_GradFase
9751:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9752:                     ENDIF
9753:                     THIS.GradFaseAfterRowColChange(0)
9754:                 ENDIF
9755:             ENDIF
9756:         CATCH TO loc_oErro
9757:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9758:         ENDTRY
9759:     ENDPROC
9760: 
9761:     *--------------------------------------------------------------------------
9762:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9763:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9764:     *--------------------------------------------------------------------------
9765:     PROCEDURE ImgFigJpgClick()
9766:         LOCAL loc_lcArquivo
9767:         TRY
9768:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9769:                 IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9770:                     IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9771:                         loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_zoom.jpg"
9772:                         IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9773:                             IF FILE(loc_lcArquivo)
9774:                                 DO FORM SigOpZom WITH loc_lcArquivo, .F.
9775:                             ENDIF
9776:                         ENDIF
9777:                     ENDIF
9778:                 ENDIF
9779:             ENDIF
9780:         CATCH TO loc_oErro
9781:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
9782:         ENDTRY
9783:     ENDPROC
9784: 
9785:     *--------------------------------------------------------------------------
9786:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9787:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9788:     *--------------------------------------------------------------------------
9789:     PROCEDURE BtnInsereMtxClick()
9790:         LOCAL loc_oPg, loc_lResultado
9791:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9792:             RETURN
9793:         ENDIF
9794:         loc_lResultado = .T.
9795:         TRY
9796:             IF !USED("cursor_4c_SigPrMtz")
9797:                 loc_lResultado = .F.
9798:             ENDIF
9799:             IF loc_lResultado
9800:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9801:                 GO TOP IN cursor_4c_SigPrMtz
9802:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9803:                 IF !EOF("cursor_4c_SigPrMtz")
9804:                     *-- Ja existe linha vazia - apenas focar
9805:                     loc_lResultado = .F.
9806:                 ENDIF
9807:             ENDIF
9808:             IF loc_lResultado
9809:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9810:                 GO BOTTOM IN cursor_4c_SigPrMtz
9811:             ENDIF
9812:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9813:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9814:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9815:                     loc_oPg.grd_4c_Matrizes.Refresh()
9816:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9817:                 ENDIF
9818:             ENDIF
9819:         CATCH TO loc_oErro
9820:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9821:         ENDTRY
9822:     ENDPROC
9823: 
9824:     *--------------------------------------------------------------------------
9825:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9826:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9827:     *--------------------------------------------------------------------------
9828:     PROCEDURE BtnExcluiMtzClick()
9829:         LOCAL loc_oPg, loc_lResultado
9830:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9831:             RETURN
9832:         ENDIF
9833:         loc_lResultado = .T.
9834:         TRY
9835:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9836:                 loc_lResultado = .F.
9837:             ENDIF
9838:             IF loc_lResultado
9839:                 SELECT cursor_4c_SigPrMtz
9840:                 DELETE
9841:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9842:                 GO TOP IN cursor_4c_SigPrMtz
9843:                 LOCATE FOR !DELETED()
9844:                 IF EOF("cursor_4c_SigPrMtz")
9845:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9846:                 ENDIF
9847:             ENDIF
9848:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9849:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9850:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9851:                     loc_oPg.grd_4c_Matrizes.Refresh()
9852:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9853:                 ENDIF
9854:             ENDIF
9855:         CATCH TO loc_oErro
9856:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9857:         ENDTRY
9858:     ENDPROC
9859: 
9860:     *--------------------------------------------------------------------------
9861:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9862:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9863:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9864:     *--------------------------------------------------------------------------
9865:     PROCEDURE TxtCodacbLostFocus()
9866:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9867:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9868:             RETURN
9869:         ENDIF
9870:         loc_lResultado = .T.
9871:         TRY
9872:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9873:                 loc_lResultado = .F.
9874:             ENDIF
9875:             IF loc_lResultado
9876:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9877:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c__codacb.Value, ""))
9878:                 IF EMPTY(loc_cCod)
9879:                     loc_oPg.txt_4c__Dacb.Value = ""
9880:                     THIS.this_oBusinessObject.this_cCodacbs = ""
9881:                     loc_lResultado = .F.
9882:                 ENDIF
9883:             ENDIF
9884:             IF loc_lResultado
9885:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9886:                     "SigCdAca", "cursor_4c_BuscaAca", "Cods", loc_cCod, ;
9887:                     "Buscar Acabamento")
9888:                 IF VARTYPE(loc_oBusca) = "O"
9889:                     IF !loc_oBusca.this_lAchouRegistro
9890:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9891:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9892:                         loc_oBusca.Show()
9893:                     ENDIF
9894:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9895:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9896:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9897:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9898:                     ELSE
9899:                         loc_oPg.txt_4c__codacb.Value = ""
9900:                         loc_oPg.txt_4c__Dacb.Value   = ""
9901:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9902:                     ENDIF
9903:                     loc_oBusca.Release()
9904:                 ENDIF
9905:                 IF USED("cursor_4c_BuscaAca")
9906:                     USE IN cursor_4c_BuscaAca
9907:                 ENDIF
9908:             ENDIF
9909:         CATCH TO loc_oErro
9910:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9911:         ENDTRY
9912:     ENDPROC
9913: 
9914:     *--------------------------------------------------------------------------
9915:     * TxtTamLostFocus - Valida e busca tamanho (SigCdTam) ao sair do campo
9916:     * Legado: getTam.Valid = fwBuscaExt on SigCdTam by Cods
9917:     *--------------------------------------------------------------------------
9918:     PROCEDURE TxtTamLostFocus()
9919:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9920:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9921:             RETURN
9922:         ENDIF
9923:         *-- Guard: evita reabrir lookup se valor nao mudou
9924:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9925:             LOCAL loc_cGuardaTam
9926:             loc_cGuardaTam = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Tam.Value, ""))
9927:             IF loc_cGuardaTam = THIS.this_cUltimoTxtTamLostFocusValidado
9928:                 RETURN
9929:             ENDIF
9930:             THIS.this_cUltimoTxtTamLostFocusValidado = loc_cGuardaTam
9931:         ENDIF
9932:         loc_lResultado = .T.
9933:         TRY
9934:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9935:                 loc_lResultado = .F.
9936:             ENDIF
9937:             IF loc_lResultado
9938:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9939:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Tam.Value, ""))
9940:                 IF EMPTY(loc_cCod)
9941:                     THIS.this_oBusinessObject.this_cCodtams = ""
9942:                     loc_lResultado = .F.
9943:                 ENDIF
9944:             ENDIF
9945:             IF loc_lResultado
9946:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9947:                     "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cCod, ;
9948:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9949:                 IF VARTYPE(loc_oBusca) = "O"
9950:                     IF !loc_oBusca.this_lAchouRegistro
9951:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9952:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9953:                         loc_oBusca.Show()
9954:                     ENDIF
9955:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9956:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9957:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9958:                     ELSE
9959:                         loc_oPg.txt_4c_Tam.Value = ""
9960:                         THIS.this_oBusinessObject.this_cCodtams = ""
9961:                     ENDIF
9962:                     loc_oBusca.Release()
9963:                 ENDIF
9964:                 IF USED("cursor_4c_BuscaTam")
9965:                     USE IN cursor_4c_BuscaTam
9966:                 ENDIF
9967:             ENDIF
9968:         CATCH TO loc_oErro
9969:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9970:         ENDTRY
9971:     ENDPROC
9972: 
9973:     *--------------------------------------------------------------------------
9974:     * TxtCorLostFocus - Valida e busca cor padrao (SigCdCor) ao sair do campo
9975:     * Legado: getCor.Valid = fwBuscaExt on SigCdCor by Cods
9976:     *--------------------------------------------------------------------------
9977:     PROCEDURE TxtCorLostFocus()
9978:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9979:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9980:             RETURN
9981:         ENDIF
9982:         *-- Guard: evita reabrir lookup se valor nao mudou
9983:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9984:             LOCAL loc_cGuardaCor
9985:             loc_cGuardaCor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Cor.Value, ""))
9986:             IF loc_cGuardaCor = THIS.this_cUltimoTxtCorLostFocusValidado
9987:                 RETURN
9988:             ENDIF
9989:             THIS.this_cUltimoTxtCorLostFocusValidado = loc_cGuardaCor
9990:         ENDIF
9991:         loc_lResultado = .T.
9992:         TRY
9993:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9994:                 loc_lResultado = .F.
9995:             ENDIF
9996:             IF loc_lResultado
9997:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9998:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Cor.Value, ""))
9999:                 IF EMPTY(loc_cCod)
10000:                     THIS.this_oBusinessObject.this_cCodcors = ""
10001:                     loc_lResultado = .F.
10002:                 ENDIF
10003:             ENDIF
10004:             IF loc_lResultado
10005:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10006:                     "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cCod, ;
10007:                     "Buscar Cor Padr" + CHR(227) + "o")
10008:                 IF VARTYPE(loc_oBusca) = "O"
10009:                     IF !loc_oBusca.this_lAchouRegistro
10010:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
10011:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10012:                         loc_oBusca.Show()
10013:                     ENDIF
10014:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
10015:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
10016:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
10017:                     ELSE
10018:                         loc_oPg.txt_4c_Cor.Value = ""
10019:                         THIS.this_oBusinessObject.this_cCodcors = ""
10020:                     ENDIF
10021:                     loc_oBusca.Release()
10022:                 ENDIF
10023:                 IF USED("cursor_4c_BuscaCor")
10024:                     USE IN cursor_4c_BuscaCor
10025:                 ENDIF
10026:             ENDIF
10027:         CATCH TO loc_oErro
10028:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
10029:         ENDTRY
10030:     ENDPROC
10031: 
10032:     *--------------------------------------------------------------------------
10033:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10034:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10035:     *--------------------------------------------------------------------------
10036:     PROCEDURE TxtConquilhaLostFocus()
10037:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10038:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10039:             RETURN
10040:         ENDIF
10041:         *-- Guard: evita reabrir lookup se valor nao mudou
10042:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
10043:             LOCAL loc_cGuardaCnq
10044:             loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
10045:             IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
10046:                 RETURN
10047:             ENDIF
10048:             THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
10049:         ENDIF
10050:         loc_lResultado = .T.
10051:         TRY
10052:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10053:                 loc_lResultado = .F.
10054:             ENDIF
10055:             IF loc_lResultado
10056:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10057:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Conquilha.Value, ""))
10058:                 IF EMPTY(loc_cCod)
10059:                     THIS.this_oBusinessObject.this_cConquilhas = ""
10060:                     loc_lResultado = .F.
10061:                 ENDIF
10062:             ENDIF
10063:             IF loc_lResultado
10064:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10065:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10066:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10067:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10068:                     SELECT cursor_4c_ListaCnq
10069:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10070:                     IF !EOF("cursor_4c_ListaCnq")
10071:                         *-- Encontrado direto
10072:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10073:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10074:                     ELSE
10075:                         *-- Nao encontrado - abrir lookup
10076:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10077:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10078:                             "Buscar Conquilha")
10079:                         IF VARTYPE(loc_oBusca) = "O"
10080:                             IF !loc_oBusca.this_lAchouRegistro
10081:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10082:                                 loc_oBusca.Show()
10083:                             ENDIF
10084:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10085:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10086:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10087:                             ELSE
10088:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10089:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10090:                             ENDIF
10091:                             loc_oBusca.Release()
10092:                         ENDIF
10093:                         IF USED("cursor_4c_BuscaCnq")
10094:                             USE IN cursor_4c_BuscaCnq
10095:                         ENDIF
10096:                     ENDIF
10097:                     USE IN cursor_4c_ListaCnq
10098:                 ENDIF
10099:             ENDIF
10100:         CATCH TO loc_oErro
10101:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")
10102:         ENDTRY
10103:     ENDPROC
10104: 
10105:     *==========================================================================
10106:     * FASE 13 - Aba Dados Fiscais (pgDadosFiscais - Page3 do pgf_4c_Dados)
10107:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
10108:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10109:     * Controles: 16 textboxes, 11 labels, 1 editbox, 1 combobox, 1 grid(3col), 1 button
10110:     *==========================================================================
10111:     PROTECTED PROCEDURE ConfigurarPgPgDadosFiscais()
10112:         LOCAL loc_oPg, loc_oGrd
10113:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10114: 
10115:         *----------------------------------------------------------------------
10116:         *-- Cursor placeholder cursor_4c_Cmv (SigCdCmv - Valor Grama)
10117:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10118:         *----------------------------------------------------------------------
10119:         IF !USED("cursor_4c_Cmv")
10120:             SET NULL ON
10121:             CREATE CURSOR cursor_4c_Cmv (;
10122:                 Datas   D, ;
10123:                 ValCuss N(12,3), ;
10124:                 Moedas  C(3))
10125:             SET NULL OFF
10126:         ENDIF
10127: 
10128:         *----------------------------------------------------------------------
10129:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10130:         *----------------------------------------------------------------------
10131:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10132:         WITH loc_oPg.lbl_4c_LblGruCus
10133:             .Caption   = "Grupo C.C. :"
10134:             .Top       = 165
10135:             .Left      = 138
10136:             .Width     = 63
10137:             .Height    = 15
10138:             .FontName  = "Tahoma"
10139:             .FontSize  = 8
10140:             .BackStyle = 0
10141:             .ForeColor = RGB(90, 90, 90)
10142:             .Visible   = .T.
10143:         ENDWITH
10144: 
10145:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")
10146:         WITH loc_oPg.lbl_4c_LblContaCus
10147:             .Caption   = "Conta C.C. :"
10148:             .Top       = 189
10149:             .Left      = 138
10150:             .Width     = 63
10151:             .Height    = 15

*-- Linhas 10444 a 10713:
10444:             .Enabled       = .F.
10445:             .Visible       = .T.
10446:         ENDWITH
10447:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "LostFocus", THIS, "TxtGruccusFiscLostFocus")
10448: 
10449:         *-- get_dgruccus: Descricao Grupo CC (T:161 L:288 W:318 H:23) readonly
10450:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
10451:         WITH loc_oPg.txt_4c_Dgruccus
10452:             .Top           = 161
10453:             .Left          = 288
10454:             .Width         = 318
10455:             .Height        = 23
10456:             .Value         = ""
10457:             .FontName      = "Tahoma"
10458:             .FontSize      = 8
10459:             .SpecialEffect = 1
10460:             .ForeColor     = RGB(36, 84, 155)
10461:             .ReadOnly      = .T.
10462:             .Enabled       = .F.
10463:             .Visible       = .T.
10464:         ENDWITH
10465: 
10466:         *-- get_contaccus: Conta de Custo (T:186 L:206 W:80 H:23)
10467:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
10468:         WITH loc_oPg.txt_4c_Contaccus
10469:             .Top           = 186
10470:             .Left          = 206
10471:             .Width         = 80
10472:             .Height        = 23
10473:             .Value         = ""
10474:             .FontName      = "Tahoma"
10475:             .FontSize      = 8
10476:             .SpecialEffect = 1
10477:             .ForeColor     = RGB(36, 84, 155)
10478:             .Enabled       = .F.
10479:             .Visible       = .T.
10480:         ENDWITH
10481:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "LostFocus", THIS, "TxtContaccusFiscLostFocus")
10482: 
10483:         *-- get_dcontaccus: Descricao Conta CC (T:186 L:288 W:318 H:23) readonly
10484:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
10485:         WITH loc_oPg.txt_4c_Dcontaccus
10486:             .Top           = 186
10487:             .Left          = 288
10488:             .Width         = 318
10489:             .Height        = 23
10490:             .Value         = ""
10491:             .FontName      = "Tahoma"
10492:             .FontSize      = 8
10493:             .SpecialEffect = 1
10494:             .ForeColor     = RGB(36, 84, 155)
10495:             .ReadOnly      = .T.
10496:             .Enabled       = .F.
10497:             .Visible       = .T.
10498:         ENDWITH
10499: 
10500:         *----------------------------------------------------------------------
10501:         *-- TextBoxes da area Fiscal Principal
10502:         *----------------------------------------------------------------------
10503:         *-- getClfiscal: Classificacao Fiscal (T:211 L:206 W:94 H:23)
10504:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
10505:         WITH loc_oPg.txt_4c_Clfiscal
10506:             .Top           = 211
10507:             .Left          = 206
10508:             .Width         = 94
10509:             .Height        = 23
10510:             .Value         = ""
10511:             .FontName      = "Tahoma"
10512:             .FontSize      = 8
10513:             .SpecialEffect = 1
10514:             .ForeColor     = RGB(36, 84, 155)
10515:             .Enabled       = .F.
10516:             .Visible       = .T.
10517:         ENDWITH
10518:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "LostFocus", THIS, "TxtClfiscalFiscLostFocus")
10519: 
10520:         *-- getDclfiscal: Descricao Classif. Fiscal (T:211 L:303 W:303 H:23) readonly
10521:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
10522:         WITH loc_oPg.txt_4c_Dclfiscal
10523:             .Top           = 211
10524:             .Left          = 303
10525:             .Width         = 303
10526:             .Height        = 23
10527:             .Value         = ""
10528:             .FontName      = "Tahoma"
10529:             .FontSize      = 8
10530:             .SpecialEffect = 1
10531:             .ForeColor     = RGB(36, 84, 155)
10532:             .ReadOnly      = .T.
10533:             .Enabled       = .F.
10534:             .Visible       = .T.
10535:         ENDWITH
10536:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "TxtDclfiscalFiscLostFocus")
10537: 
10538:         *-- getOrigmerc: Origem Mercadoria (T:236 L:206 W:17 H:23)
10539:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
10540:         WITH loc_oPg.txt_4c_Origmerc
10541:             .Top           = 236
10542:             .Left          = 206
10543:             .Width         = 17
10544:             .Height        = 23
10545:             .Value         = ""
10546:             .FontName      = "Tahoma"
10547:             .FontSize      = 8
10548:             .SpecialEffect = 1
10549:             .ForeColor     = RGB(36, 84, 155)
10550:             .Enabled       = .F.
10551:             .Visible       = .T.
10552:         ENDWITH
10553:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "LostFocus", THIS, "TxtOrigmercFiscLostFocus")
10554: 
10555:         *-- getDorigmerc: Descricao Origem (T:236 L:226 W:380 H:23)
10556:         *-- Visivel apenas quando Origmerc vazio (readonly com busca reversa)
10557:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
10558:         WITH loc_oPg.txt_4c_Dorigmerc
10559:             .Top           = 236
10560:             .Left          = 226
10561:             .Width         = 380
10562:             .Height        = 23
10563:             .Value         = ""
10564:             .FontName      = "Tahoma"
10565:             .FontSize      = 8
10566:             .SpecialEffect = 1
10567:             .ForeColor     = RGB(36, 84, 155)
10568:             .ReadOnly      = .T.
10569:             .Enabled       = .F.
10570:             .Visible       = .T.
10571:         ENDWITH
10572: 
10573:         *-- getSittricm: Situacao Tributaria ICMS (T:261 L:206 W:31 H:23)
10574:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
10575:         WITH loc_oPg.txt_4c_Sittricm
10576:             .Top           = 261
10577:             .Left          = 206
10578:             .Width         = 31
10579:             .Height        = 23
10580:             .Value         = ""
10581:             .FontName      = "Tahoma"
10582:             .FontSize      = 8
10583:             .SpecialEffect = 1
10584:             .ForeColor     = RGB(36, 84, 155)
10585:             .Enabled       = .F.
10586:             .Visible       = .T.
10587:         ENDWITH
10588:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "LostFocus", THIS, "TxtSittricmFiscLostFocus")
10589: 
10590:         *-- getDsittricm: Descricao Sit. Trib. ICMS (T:261 L:240 W:366 H:23) readonly
10591:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
10592:         WITH loc_oPg.txt_4c_Dsittricm
10593:             .Top           = 261
10594:             .Left          = 240
10595:             .Width         = 366
10596:             .Height        = 23
10597:             .Value         = ""
10598:             .FontName      = "Tahoma"
10599:             .FontSize      = 8
10600:             .SpecialEffect = 1
10601:             .ForeColor     = RGB(36, 84, 155)
10602:             .ReadOnly      = .T.
10603:             .Enabled       = .F.
10604:             .Visible       = .T.
10605:         ENDWITH
10606: 
10607:         *-- Get_CodServs: Cod. Servicos ICMS (T:286 L:206 W:38 H:23)
10608:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
10609:         WITH loc_oPg.txt_4c_CodServs
10610:             .Top           = 286
10611:             .Left          = 206
10612:             .Width         = 38
10613:             .Height        = 23
10614:             .Value         = ""
10615:             .FontName      = "Tahoma"
10616:             .FontSize      = 8
10617:             .SpecialEffect = 1
10618:             .ForeColor     = RGB(36, 84, 155)
10619:             .Enabled       = .F.
10620:             .Visible       = .T.
10621:         ENDWITH
10622:         BINDEVENT(loc_oPg.txt_4c_CodServs, "LostFocus", THIS, "TxtCodServsFiscLostFocus")
10623: 
10624:         *-- getIcms: Aliquota ICMS (T:286 L:342 W:45 H:23)
10625:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
10626:         WITH loc_oPg.txt_4c_Icms
10627:             .Top           = 286
10628:             .Left          = 342
10629:             .Width         = 45
10630:             .Height        = 23
10631:             .Value         = 0
10632:             .FontName      = "Tahoma"
10633:             .FontSize      = 8
10634:             .SpecialEffect = 1
10635:             .ForeColor     = RGB(36, 84, 155)
10636:             .Enabled       = .F.
10637:             .Visible       = .T.
10638:         ENDWITH
10639: 
10640:         *-- Get_TpTrib: Tipo Tributacao (T:286 L:513 W:38 H:23)
10641:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
10642:         WITH loc_oPg.txt_4c_TpTrib
10643:             .Top           = 286
10644:             .Left          = 513
10645:             .Width         = 38
10646:             .Height        = 23
10647:             .Value         = ""
10648:             .FontName      = "Tahoma"
10649:             .FontSize      = 8
10650:             .SpecialEffect = 1
10651:             .ForeColor     = RGB(36, 84, 155)
10652:             .Enabled       = .F.
10653:             .Visible       = .T.
10654:         ENDWITH
10655:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "LostFocus", THIS, "TxtTpTribFiscLostFocus")
10656: 
10657:         *-- getiat: IAT - Arredondamento/Truncamento (T:286 L:589 W:17 H:23) MaxLength=1
10658:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
10659:         WITH loc_oPg.txt_4c_Iat
10660:             .Top           = 286
10661:             .Left          = 589
10662:             .Width         = 17
10663:             .Height        = 23
10664:             .Value         = ""
10665:             .FontName      = "Tahoma"
10666:             .FontSize      = 8
10667:             .SpecialEffect = 1
10668:             .ForeColor     = RGB(36, 84, 155)
10669:             .MaxLength     = 1
10670:             .Enabled       = .F.
10671:             .Visible       = .T.
10672:         ENDWITH
10673:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "TxtIatFiscLostFocus")
10674: 
10675:         *----------------------------------------------------------------------
10676:         *-- ComboBox cmbIpi: Tipo IPI (T:311 L:206 W:108 H:25)
10677:         *-- Items: '' | Tributado | Isento | Outros
10678:         *----------------------------------------------------------------------
10679:         loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
10680:         WITH loc_oPg.cmb_4c_Ipi
10681:             .Top           = 311
10682:             .Left          = 206
10683:             .Width         = 108
10684:             .Height        = 25
10685:             .FontName      = "Tahoma"
10686:             .FontSize      = 8
10687:             .SpecialEffect = 1
10688:             .Style         = 2
10689:             .Enabled       = .F.
10690:             .Visible       = .T.
10691:         ENDWITH
10692:         loc_oPg.cmb_4c_Ipi.Clear()
10693:         loc_oPg.cmb_4c_Ipi.AddItem(PADR("", 10))
10694:         loc_oPg.cmb_4c_Ipi.AddItem("Tributado")
10695:         loc_oPg.cmb_4c_Ipi.AddItem("Isento   ")
10696:         loc_oPg.cmb_4c_Ipi.AddItem("Outros   ")
10697: 
10698:         *-- Get_AliqIPI: Aliquota IPI (T:311 L:425 W:45 H:25)
10699:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
10700:         WITH loc_oPg.txt_4c_AliqIPI
10701:             .Top           = 311
10702:             .Left          = 425
10703:             .Width         = 45
10704:             .Height        = 25
10705:             .Value         = 0
10706:             .FontName      = "Tahoma"
10707:             .FontSize      = 8
10708:             .SpecialEffect = 1
10709:             .ForeColor     = RGB(36, 84, 155)
10710:             .Enabled       = .F.
10711:             .Visible       = .T.
10712:         ENDWITH
10713: 

*-- Linhas 10745 a 10788:
10745:             .Enabled         = .F.
10746:             .Visible         = .T.
10747:         ENDWITH
10748:         BINDEVENT(loc_oPg.cmd_4c_DescFis, "Click", THIS, "CmdDescFisClick")
10749: 
10750:         *----------------------------------------------------------------------
10751:         *-- EditBox mgetdescfi: Descricao Fiscal (T:338 L:206 W:509 H:89)
10752:         *----------------------------------------------------------------------
10753:         loc_oPg.AddObject("obj_4c_Descfis", "EditBox")
10754:         WITH loc_oPg.obj_4c_Descfis
10755:             .Top           = 338
10756:             .Left          = 206
10757:             .Width         = 509
10758:             .Height        = 89
10759:             .Value         = ""
10760:             .FontName      = "Tahoma"
10761:             .FontSize      = 8
10762:             .SpecialEffect = 1
10763:             .ForeColor     = RGB(36, 84, 155)
10764:             .Enabled       = .F.
10765:             .Visible       = .T.
10766:         ENDWITH
10767: 
10768:         *----------------------------------------------------------------------
10769:         *-- TextBoxes area ECF / Metal / Teor / Valor
10770:         *----------------------------------------------------------------------
10771:         *-- getDescEcfs: Descricao ECF (T:429 L:206 W:213 H:23)
10772:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
10773:         WITH loc_oPg.txt_4c_DescEcfs
10774:             .Top           = 429
10775:             .Left          = 206
10776:             .Width         = 213
10777:             .Height        = 23
10778:             .Value         = ""
10779:             .FontName      = "Tahoma"
10780:             .FontSize      = 8
10781:             .SpecialEffect = 1
10782:             .ForeColor     = RGB(36, 84, 155)
10783:             .MaxLength     = 29
10784:             .Enabled       = .F.
10785:             .Visible       = .T.
10786:         ENDWITH
10787: 
10788:         *-- Get_metal: Metal (T:429 L:537 W:24 H:23)

*-- Linhas 10800 a 10843:
10800:             .Enabled       = .F.
10801:             .Visible       = .T.
10802:         ENDWITH
10803:         BINDEVENT(loc_oPg.txt_4c_Metal, "LostFocus", THIS, "TxtMetalFiscLostFocus")
10804: 
10805:         *-- Get_DesMetal: Descricao Metal (T:429 L:564 W:150 H:23) readonly
10806:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
10807:         WITH loc_oPg.txt_4c_DesMetal
10808:             .Top           = 429
10809:             .Left          = 564
10810:             .Width         = 150
10811:             .Height        = 23
10812:             .Value         = ""
10813:             .FontName      = "Tahoma"
10814:             .FontSize      = 8
10815:             .SpecialEffect = 1
10816:             .ForeColor     = RGB(36, 84, 155)
10817:             .ReadOnly      = .T.
10818:             .Enabled       = .F.
10819:             .Visible       = .T.
10820:         ENDWITH
10821: 
10822:         *-- getValor: Valor Estimado (T:454 L:206 W:108 H:23) numeric
10823:         loc_oPg.AddObject("txt_4c_ValorEstim", "TextBox")
10824:         WITH loc_oPg.txt_4c_ValorEstim
10825:             .Top           = 454
10826:             .Left          = 206
10827:             .Width         = 108
10828:             .Height        = 23
10829:             .Value         = 0
10830:             .FontName      = "Tahoma"
10831:             .FontSize      = 8
10832:             .SpecialEffect = 1
10833:             .ForeColor     = RGB(36, 84, 155)
10834:             .Enabled       = .F.
10835:             .Visible       = .T.
10836:         ENDWITH
10837: 
10838:         *-- GetMvalor: Moeda do Valor (T:454 L:317 W:31 H:23) - lookup SigCdMoe
10839:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
10840:         WITH loc_oPg.txt_4c_Mvalor
10841:             .Top           = 454
10842:             .Left          = 317
10843:             .Width         = 31

*-- Linhas 10850 a 10910:
10850:             .Enabled       = .F.
10851:             .Visible       = .T.
10852:         ENDWITH
10853:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "LostFocus", THIS, "TxtMvalorFiscLostFocus")
10854: 
10855:         *-- Get_teor: Teor (T:454 L:537 W:24 H:23)
10856:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
10857:         WITH loc_oPg.txt_4c_Teor
10858:             .Top           = 454
10859:             .Left          = 537
10860:             .Width         = 24
10861:             .Height        = 23
10862:             .Value         = ""
10863:             .FontName      = "Tahoma"
10864:             .FontSize      = 8
10865:             .SpecialEffect = 1
10866:             .ForeColor     = RGB(36, 84, 155)
10867:             .Enabled       = .F.
10868:             .Visible       = .T.
10869:         ENDWITH
10870:         BINDEVENT(loc_oPg.txt_4c_Teor, "LostFocus", THIS, "TxtTeorFiscLostFocus")
10871: 
10872:         *-- Get_DesTeor: Descricao Teor (T:454 L:564 W:150 H:23) readonly
10873:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
10874:         WITH loc_oPg.txt_4c_DesTeor
10875:             .Top           = 454
10876:             .Left          = 564
10877:             .Width         = 150
10878:             .Height        = 23
10879:             .Value         = ""
10880:             .FontName      = "Tahoma"
10881:             .FontSize      = 8
10882:             .SpecialEffect = 1
10883:             .ForeColor     = RGB(36, 84, 155)
10884:             .ReadOnly      = .T.
10885:             .Enabled       = .F.
10886:             .Visible       = .T.
10887:         ENDWITH
10888: 
10889:         *-- getIPPTCST: IPPT/CST (T:479 L:206 W:108 H:23) readonly (When=.f.)
10890:         loc_oPg.AddObject("txt_4c_IpptCST", "TextBox")
10891:         WITH loc_oPg.txt_4c_IpptCST
10892:             .Top           = 479
10893:             .Left          = 206
10894:             .Width         = 108
10895:             .Height        = 23
10896:             .Value         = ""
10897:             .FontName      = "Tahoma"
10898:             .FontSize      = 8
10899:             .SpecialEffect = 1
10900:             .ForeColor     = RGB(36, 84, 155)
10901:             .ReadOnly      = .T.
10902:             .Enabled       = .F.
10903:             .Visible       = .T.
10904:         ENDWITH
10905: 
10906:         *----------------------------------------------------------------------
10907:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10908:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10909:         *----------------------------------------------------------------------
10910:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")

*-- Linhas 10963 a 11006:
10963:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10964:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10965:     *--------------------------------------------------------------------------
10966:     PROTECTED PROCEDURE PreencherCamposFiscais()
10967:         LOCAL loc_oPg, loc_cIpiVal
10968:         TRY
10969:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10970:                 RETURN
10971:             ENDIF
10972:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10973:             IF VARTYPE(loc_oPg) # "O"
10974:                 RETURN
10975:             ENDIF
10976:             WITH THIS.this_oBusinessObject
10977:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
10978:                     loc_oPg.txt_4c_Gruccus.Value = ALLTRIM(.this_cGruccus)
10979:                 ENDIF
10980:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
10981:                     loc_oPg.txt_4c_Contaccus.Value = ALLTRIM(.this_cContaccus)
10982:                 ENDIF
10983:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
10984:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(.this_cClfiscals)
10985:                 ENDIF
10986:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
10987:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(.this_cOrigmercs)
10988:                 ENDIF
10989:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
10990:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(.this_cSittricms)
10991:                 ENDIF
10992:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
10993:                     loc_oPg.txt_4c_CodServs.Value = ALLTRIM(.this_cCodservs)
10994:                 ENDIF
10995:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
10996:                     loc_oPg.txt_4c_Icms.Value = .this_nIcms
10997:                 ENDIF
10998:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
10999:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(.this_cTptribs)
11000:                 ENDIF
11001:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11002:                     loc_oPg.txt_4c_Iat.Value = ALLTRIM(.this_cIats)
11003:                 ENDIF
11004:                 *-- cmbIpi: converte this_cIpis (T/I/O/'') para texto do combo
11005:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
11006:                     DO CASE

*-- Linhas 11049 a 11092:
11049:     * LerCamposFiscais - Le controles de pgDadosFiscais e transfere para o BO
11050:     * Chamado por FormParaBO antes de salvar
11051:     *--------------------------------------------------------------------------
11052:     PROTECTED PROCEDURE LerCamposFiscais()
11053:         LOCAL loc_oPg, loc_cIpiTxt
11054:         TRY
11055:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11056:                 RETURN
11057:             ENDIF
11058:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11059:             IF VARTYPE(loc_oPg) # "O"
11060:                 RETURN
11061:             ENDIF
11062:             WITH THIS.this_oBusinessObject
11063:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11064:                     .this_cGruccus = ALLTRIM(loc_oPg.txt_4c_Gruccus.Value)
11065:                 ENDIF
11066:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11067:                     .this_cContaccus = ALLTRIM(loc_oPg.txt_4c_Contaccus.Value)
11068:                 ENDIF
11069:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11070:                     .this_cClfiscals = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
11071:                 ENDIF
11072:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
11073:                     .this_cOrigmercs = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
11074:                 ENDIF
11075:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
11076:                     .this_cSittricms = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
11077:                 ENDIF
11078:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11079:                     .this_cCodservs = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
11080:                 ENDIF
11081:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
11082:                     .this_nIcms = loc_oPg.txt_4c_Icms.Value
11083:                 ENDIF
11084:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
11085:                     .this_cTptribs = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
11086:                 ENDIF
11087:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11088:                     .this_cIats = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
11089:                 ENDIF
11090:                 *-- cmbIpi: converte texto para char(1)
11091:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
11092:                     loc_cIpiTxt = UPPER(LEFT(ALLTRIM(loc_oPg.cmb_4c_Ipi.Value), 1))

*-- Linhas 11129 a 11853:
11129:     *--------------------------------------------------------------------------
11130:     * TxtClfiscalFiscLostFocus - Lookup SigCdClf por Codigos
11131:     *--------------------------------------------------------------------------
11132:     PROCEDURE TxtClfiscalFiscLostFocus()
11133:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11134:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11135:             RETURN
11136:         ENDIF
11137:         *-- Guard: evita reabrir lookup se valor nao mudou
11138:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11139:             LOCAL loc_cGuardaClf
11140:             loc_cGuardaClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Clfiscal.Value, ""))
11141:             IF loc_cGuardaClf = THIS.this_cUltimoTxtClfiscalLostFocusValidado
11142:                 RETURN
11143:             ENDIF
11144:             THIS.this_cUltimoTxtClfiscalLostFocusValidado = loc_cGuardaClf
11145:         ENDIF
11146:         loc_lResultado = .T.
11147:         TRY
11148:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11149:                 loc_lResultado = .F.
11150:             ENDIF
11151:             IF loc_lResultado
11152:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11153:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11154:                 IF EMPTY(loc_cCod)
11155:                     THIS.this_oBusinessObject.this_cClfiscals = ""
11156:                     IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11157:                         loc_oPg.txt_4c_Dclfiscal.Value = ""
11158:                     ENDIF
11159:                     loc_lResultado = .F.
11160:                 ENDIF
11161:             ENDIF
11162:             IF loc_lResultado
11163:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11164:                     "SigCdClf", "cursor_4c_BuscaClf", "Codigos", loc_cCod, ;
11165:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11166:                 IF VARTYPE(loc_oBusca) = "O"
11167:                     IF !loc_oBusca.this_lAchouRegistro
11168:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11169:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11170:                         loc_oBusca.Show()
11171:                     ENDIF
11172:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11173:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11174:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11175:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11176:                         ENDIF
11177:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11178:                     ELSE
11179:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11180:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11181:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11182:                         ENDIF
11183:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11184:                     ENDIF
11185:                     loc_oBusca.Release()
11186:                 ENDIF
11187:                 IF USED("cursor_4c_BuscaClf")
11188:                     USE IN cursor_4c_BuscaClf
11189:                 ENDIF
11190:             ENDIF
11191:         CATCH TO loc_oErro
11192:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11193:         ENDTRY
11194:     ENDPROC
11195: 
11196:     *--------------------------------------------------------------------------
11197:     * TxtDclfiscalFiscLostFocus - Busca reversa SigCdClf por Descricaos
11198:     * Ativado quando getClfiscal esta vazio
11199:     *--------------------------------------------------------------------------
11200:     PROCEDURE TxtDclfiscalFiscLostFocus()
11201:         LOCAL loc_oPg, loc_oBusca, loc_cDesc, loc_lResultado
11202:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11203:             RETURN
11204:         ENDIF
11205:         *-- Guard: evita reabrir lookup se valor nao mudou
11206:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11207:             LOCAL loc_cGuardaDClf
11208:             loc_cGuardaDClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Dclfiscal.Value, ""))
11209:             IF loc_cGuardaDClf = THIS.this_cUltimoTxtDclfiscalLostFocusValidado
11210:                 RETURN
11211:             ENDIF
11212:             THIS.this_cUltimoTxtDclfiscalLostFocusValidado = loc_cGuardaDClf
11213:         ENDIF
11214:         loc_lResultado = .T.
11215:         TRY
11216:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11217:                 loc_lResultado = .F.
11218:             ENDIF
11219:             IF loc_lResultado
11220:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11221:                 *-- Apenas ativo quando codigo vazio
11222:                 IF NOT EMPTY(ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, "")))
11223:                     loc_lResultado = .F.
11224:                 ENDIF
11225:             ENDIF
11226:             IF loc_lResultado
11227:                 loc_cDesc = ALLTRIM(NVL(loc_oPg.txt_4c_Dclfiscal.Value, ""))
11228:                 IF EMPTY(loc_cDesc)
11229:                     loc_lResultado = .F.
11230:                 ENDIF
11231:             ENDIF
11232:             IF loc_lResultado
11233:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11234:                     "SigCdClf", "cursor_4c_BuscaClfR", "Descricaos", loc_cDesc, ;
11235:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11236:                 IF VARTYPE(loc_oBusca) = "O"
11237:                     IF !loc_oBusca.this_lAchouRegistro
11238:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11239:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11240:                         loc_oBusca.Show()
11241:                     ENDIF
11242:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11243:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11244:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11245:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11246:                     ENDIF
11247:                     loc_oBusca.Release()
11248:                 ENDIF
11249:                 IF USED("cursor_4c_BuscaClfR")
11250:                     USE IN cursor_4c_BuscaClfR
11251:                 ENDIF
11252:             ENDIF
11253:         CATCH TO loc_oErro
11254:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11255:         ENDTRY
11256:     ENDPROC
11257: 
11258:     *--------------------------------------------------------------------------
11259:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)
11260:     *--------------------------------------------------------------------------
11261:     PROCEDURE TxtOrigmercFiscLostFocus()
11262:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11263:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11264:             RETURN
11265:         ENDIF
11266:         *-- Guard: evita reabrir lookup se valor nao mudou
11267:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11268:             LOCAL loc_cGuardaOrg
11269:             loc_cGuardaOrg = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Origmerc.Value, ""))
11270:             IF loc_cGuardaOrg = THIS.this_cUltimoTxtOrigmercLostFocusValidado
11271:                 RETURN
11272:             ENDIF
11273:             THIS.this_cUltimoTxtOrigmercLostFocusValidado = loc_cGuardaOrg
11274:         ENDIF
11275:         loc_lResultado = .T.
11276:         TRY
11277:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11278:                 loc_lResultado = .F.
11279:             ENDIF
11280:             IF loc_lResultado
11281:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11282:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Origmerc.Value, ""))
11283:                 IF EMPTY(loc_cCod)
11284:                     THIS.this_oBusinessObject.this_cOrigmercs = ""
11285:                     IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11286:                         loc_oPg.txt_4c_Dorigmerc.Value = ""
11287:                     ENDIF
11288:                     loc_lResultado = .F.
11289:                 ENDIF
11290:             ENDIF
11291:             IF loc_lResultado
11292:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11293:                     "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", loc_cCod, ;
11294:                     "Buscar Origem da Mercadoria")
11295:                 IF VARTYPE(loc_oBusca) = "O"
11296:                     IF !loc_oBusca.this_lAchouRegistro
11297:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11298:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11299:                         loc_oBusca.Show()
11300:                     ENDIF
11301:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11302:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11303:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11304:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11305:                         ENDIF
11306:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11307:                     ELSE
11308:                         loc_oPg.txt_4c_Origmerc.Value = ""
11309:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11310:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11311:                         ENDIF
11312:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11313:                     ENDIF
11314:                     loc_oBusca.Release()
11315:                 ENDIF
11316:                 IF USED("cursor_4c_BuscaOrg")
11317:                     USE IN cursor_4c_BuscaOrg
11318:                 ENDIF
11319:             ENDIF
11320:         CATCH TO loc_oErro
11321:             MsgErro(loc_oErro.Message, "Erro ao buscar origem da mercadoria")
11322:         ENDTRY
11323:     ENDPROC
11324: 
11325:     *--------------------------------------------------------------------------
11326:     * TxtSittricmFiscLostFocus - Lookup SigCdIcm por Codigos (sit. trib. ICMS)
11327:     *--------------------------------------------------------------------------
11328:     PROCEDURE TxtSittricmFiscLostFocus()
11329:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11330:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11331:             RETURN
11332:         ENDIF
11333:         *-- Guard: evita reabrir lookup se valor nao mudou
11334:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11335:             LOCAL loc_cGuardaIcm
11336:             loc_cGuardaIcm = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Sittricm.Value, ""))
11337:             IF loc_cGuardaIcm = THIS.this_cUltimoTxtSittricmLostFocusValidado
11338:                 RETURN
11339:             ENDIF
11340:             THIS.this_cUltimoTxtSittricmLostFocusValidado = loc_cGuardaIcm
11341:         ENDIF
11342:         loc_lResultado = .T.
11343:         TRY
11344:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11345:                 loc_lResultado = .F.
11346:             ENDIF
11347:             IF loc_lResultado
11348:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11349:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Sittricm.Value, ""))
11350:                 IF EMPTY(loc_cCod)
11351:                     THIS.this_oBusinessObject.this_cSittricms = ""
11352:                     IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11353:                         loc_oPg.txt_4c_Dsittricm.Value = ""
11354:                     ENDIF
11355:                     loc_lResultado = .F.
11356:                 ENDIF
11357:             ENDIF
11358:             IF loc_lResultado
11359:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11360:                     "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", loc_cCod, ;
11361:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11362:                 IF VARTYPE(loc_oBusca) = "O"
11363:                     IF !loc_oBusca.this_lAchouRegistro
11364:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11365:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11366:                         loc_oBusca.Show()
11367:                     ENDIF
11368:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11369:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11370:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11371:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11372:                         ENDIF
11373:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11374:                     ELSE
11375:                         loc_oPg.txt_4c_Sittricm.Value = ""
11376:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11377:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11378:                         ENDIF
11379:                         THIS.this_oBusinessObject.this_cSittricms = ""
11380:                     ENDIF
11381:                     loc_oBusca.Release()
11382:                 ENDIF
11383:                 IF USED("cursor_4c_BuscaIcm")
11384:                     USE IN cursor_4c_BuscaIcm
11385:                 ENDIF
11386:             ENDIF
11387:         CATCH TO loc_oErro
11388:             MsgErro(loc_oErro.Message, "Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
11389:         ENDTRY
11390:     ENDPROC
11391: 
11392:     *--------------------------------------------------------------------------
11393:     * TxtCodServsFiscLostFocus - Armazena codigo de servicos no BO
11394:     *--------------------------------------------------------------------------
11395:     PROCEDURE TxtCodServsFiscLostFocus()
11396:         LOCAL loc_oPg
11397:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11398:             RETURN
11399:         ENDIF
11400:         TRY
11401:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11402:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11403:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11404:                     THIS.this_oBusinessObject.this_cCodservs = ALLTRIM(NVL(loc_oPg.txt_4c_CodServs.Value, ""))
11405:                 ENDIF
11406:             ENDIF
11407:         CATCH TO loc_oErro
11408:             MsgErro(loc_oErro.Message, "Erro ao atualizar c" + CHR(243) + "digo de servi" + CHR(231) + "os")
11409:         ENDTRY
11410:     ENDPROC
11411: 
11412:     *--------------------------------------------------------------------------
11413:     * TxtTpTribFiscLostFocus - Lookup SigPrTri por Tipos (tipo tributacao)
11414:     *--------------------------------------------------------------------------
11415:     PROCEDURE TxtTpTribFiscLostFocus()
11416:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11417:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11418:             RETURN
11419:         ENDIF
11420:         *-- Guard: evita reabrir lookup se valor nao mudou
11421:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11422:             LOCAL loc_cGuardaTri
11423:             loc_cGuardaTri = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_TpTrib.Value, ""))
11424:             IF loc_cGuardaTri = THIS.this_cUltimoTxtTpTribLostFocusValidado
11425:                 RETURN
11426:             ENDIF
11427:             THIS.this_cUltimoTxtTpTribLostFocusValidado = loc_cGuardaTri
11428:         ENDIF
11429:         loc_lResultado = .T.
11430:         TRY
11431:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11432:                 loc_lResultado = .F.
11433:             ENDIF
11434:             IF loc_lResultado
11435:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11436:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_TpTrib.Value, ""))
11437:                 IF EMPTY(loc_cCod)
11438:                     THIS.this_oBusinessObject.this_cTptribs = ""
11439:                     loc_lResultado = .F.
11440:                 ENDIF
11441:             ENDIF
11442:             IF loc_lResultado
11443:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11444:                     "SigPrTri", "cursor_4c_BuscaTri", "Tipos", loc_cCod, ;
11445:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11446:                 IF VARTYPE(loc_oBusca) = "O"
11447:                     IF !loc_oBusca.this_lAchouRegistro
11448:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11449:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11450:                         loc_oBusca.Show()
11451:                     ENDIF
11452:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11453:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11454:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11455:                     ELSE
11456:                         loc_oPg.txt_4c_TpTrib.Value = ""
11457:                         THIS.this_oBusinessObject.this_cTptribs = ""
11458:                     ENDIF
11459:                     loc_oBusca.Release()
11460:                 ENDIF
11461:                 IF USED("cursor_4c_BuscaTri")
11462:                     USE IN cursor_4c_BuscaTri
11463:                 ENDIF
11464:             ENDIF
11465:         CATCH TO loc_oErro
11466:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11467:         ENDTRY
11468:     ENDPROC
11469: 
11470:     *--------------------------------------------------------------------------
11471:     * TxtIatFiscLostFocus - Valida IAT: apenas 'A', 'T' ou vazio
11472:     *--------------------------------------------------------------------------
11473:     PROCEDURE TxtIatFiscLostFocus()
11474:         LOCAL loc_oPg, loc_cVal
11475:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11476:             RETURN
11477:         ENDIF
11478:         TRY
11479:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11480:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11481:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11482:                     loc_cVal = UPPER(ALLTRIM(NVL(loc_oPg.txt_4c_Iat.Value, "")))
11483:                     IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
11484:                         MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11485:                             "Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
11486:                         loc_oPg.txt_4c_Iat.Value = ""
11487:                         THIS.this_oBusinessObject.this_cIats = ""
11488:                     ELSE
11489:                         THIS.this_oBusinessObject.this_cIats = loc_cVal
11490:                     ENDIF
11491:                 ENDIF
11492:             ENDIF
11493:         CATCH TO loc_oErro
11494:             MsgErro(loc_oErro.Message, "Erro ao validar IAT")
11495:         ENDTRY
11496:     ENDPROC
11497: 
11498:     *--------------------------------------------------------------------------
11499:     * TxtMvalorFiscLostFocus - Lookup SigCdMoe por CMoes (moeda do valor)
11500:     *--------------------------------------------------------------------------
11501:     PROCEDURE TxtMvalorFiscLostFocus()
11502:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11503:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11504:             RETURN
11505:         ENDIF
11506:         *-- Guard: evita reabrir lookup se valor nao mudou
11507:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11508:             LOCAL loc_cGuardaMoe
11509:             loc_cGuardaMoe = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Mvalor.Value, ""))
11510:             IF loc_cGuardaMoe = THIS.this_cUltimoTxtMvalorLostFocusValidado
11511:                 RETURN
11512:             ENDIF
11513:             THIS.this_cUltimoTxtMvalorLostFocusValidado = loc_cGuardaMoe
11514:         ENDIF
11515:         loc_lResultado = .T.
11516:         TRY
11517:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11518:                 loc_lResultado = .F.
11519:             ENDIF
11520:             IF loc_lResultado
11521:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11522:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Mvalor.Value, ""))
11523:                 IF EMPTY(loc_cCod)
11524:                     THIS.this_oBusinessObject.this_cMoedas = ""
11525:                     loc_lResultado = .F.
11526:                 ENDIF
11527:             ENDIF
11528:             IF loc_lResultado
11529:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11530:                     "SigCdMoe", "cursor_4c_BuscaMoeFisc", "cmoes", loc_cCod, ;
11531:                     "Buscar Moeda")
11532:                 IF VARTYPE(loc_oBusca) = "O"
11533:                     IF !loc_oBusca.this_lAchouRegistro
11534:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11535:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11536:                         loc_oBusca.Show()
11537:                     ENDIF
11538:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11539:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11540:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11541:                     ELSE
11542:                         loc_oPg.txt_4c_Mvalor.Value = ""
11543:                         THIS.this_oBusinessObject.this_cMoedas = ""
11544:                     ENDIF
11545:                     loc_oBusca.Release()
11546:                 ENDIF
11547:                 IF USED("cursor_4c_BuscaMoeFisc")
11548:                     USE IN cursor_4c_BuscaMoeFisc
11549:                 ENDIF
11550:             ENDIF
11551:         CATCH TO loc_oErro
11552:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11553:         ENDTRY
11554:     ENDPROC
11555: 
11556:     *--------------------------------------------------------------------------
11557:     * TxtMetalFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos='M'
11558:     *--------------------------------------------------------------------------
11559:     PROCEDURE TxtMetalFiscLostFocus()
11560:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11561:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11562:             RETURN
11563:         ENDIF
11564:         *-- Guard: evita reabrir lookup se valor nao mudou
11565:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11566:             LOCAL loc_cGuardaMtl
11567:             loc_cGuardaMtl = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Metal.Value, ""))
11568:             IF loc_cGuardaMtl = THIS.this_cUltimoTxtMetalLostFocusValidado
11569:                 RETURN
11570:             ENDIF
11571:             THIS.this_cUltimoTxtMetalLostFocusValidado = loc_cGuardaMtl
11572:         ENDIF
11573:         loc_lResultado = .T.
11574:         TRY
11575:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11576:                 loc_lResultado = .F.
11577:             ENDIF
11578:             IF loc_lResultado
11579:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11580:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Metal.Value, ""))
11581:                 IF EMPTY(loc_cCod)
11582:                     THIS.this_oBusinessObject.this_cMetals = ""
11583:                     IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11584:                         loc_oPg.txt_4c_DesMetal.Value = ""
11585:                     ENDIF
11586:                     loc_lResultado = .F.
11587:                 ENDIF
11588:             ENDIF
11589:             IF loc_lResultado
11590:                 *-- Carregar lista de metais (Tipos='M') para lookup
11591:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11592:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11593:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11594:                     *-- Verificar se codigo existe diretamente
11595:                     SELECT cursor_4c_BuscaMtlM
11596:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11597:                     IF !EOF("cursor_4c_BuscaMtlM")
11598:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11599:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11600:                         ENDIF
11601:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11602:                     ELSE
11603:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11604:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11605:                             "Buscar Metal")
11606:                         IF VARTYPE(loc_oBusca) = "O"
11607:                             IF !loc_oBusca.this_lAchouRegistro
11608:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11609:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11610:                                 loc_oBusca.Show()
11611:                             ENDIF
11612:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11613:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11614:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11615:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11616:                                 ENDIF
11617:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11618:                             ELSE
11619:                                 loc_oPg.txt_4c_Metal.Value = ""
11620:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11621:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11622:                                 ENDIF
11623:                                 THIS.this_oBusinessObject.this_cMetals = ""
11624:                             ENDIF
11625:                             loc_oBusca.Release()
11626:                         ENDIF
11627:                         IF USED("cursor_4c_BuscaMtlSel")
11628:                             USE IN cursor_4c_BuscaMtlSel
11629:                         ENDIF
11630:                     ENDIF
11631:                     USE IN cursor_4c_BuscaMtlM
11632:                 ENDIF
11633:             ENDIF
11634:         CATCH TO loc_oErro
11635:             MsgErro(loc_oErro.Message, "Erro ao buscar metal")
11636:         ENDTRY
11637:     ENDPROC
11638: 
11639:     *--------------------------------------------------------------------------
11640:     * TxtTeorFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos<>'M'
11641:     *--------------------------------------------------------------------------
11642:     PROCEDURE TxtTeorFiscLostFocus()
11643:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11644:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11645:             RETURN
11646:         ENDIF
11647:         *-- Guard: evita reabrir lookup se valor nao mudou
11648:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11649:             LOCAL loc_cGuardaTeor
11650:             loc_cGuardaTeor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Teor.Value, ""))
11651:             IF loc_cGuardaTeor = THIS.this_cUltimoTxtTeorLostFocusValidado
11652:                 RETURN
11653:             ENDIF
11654:             THIS.this_cUltimoTxtTeorLostFocusValidado = loc_cGuardaTeor
11655:         ENDIF
11656:         loc_lResultado = .T.
11657:         TRY
11658:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11659:                 loc_lResultado = .F.
11660:             ENDIF
11661:             IF loc_lResultado
11662:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11663:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Teor.Value, ""))
11664:                 IF EMPTY(loc_cCod)
11665:                     THIS.this_oBusinessObject.this_cTeors = ""
11666:                     IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11667:                         loc_oPg.txt_4c_DesTeor.Value = ""
11668:                     ENDIF
11669:                     loc_lResultado = .F.
11670:                 ENDIF
11671:             ENDIF
11672:             IF loc_lResultado
11673:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11674:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11675:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11676:                     SELECT cursor_4c_BuscaMtlT
11677:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11678:                     IF !EOF("cursor_4c_BuscaMtlT")
11679:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11680:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11681:                         ENDIF
11682:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11683:                     ELSE
11684:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11685:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11686:                             "Buscar Teor")
11687:                         IF VARTYPE(loc_oBusca) = "O"
11688:                             IF !loc_oBusca.this_lAchouRegistro
11689:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11690:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11691:                                 loc_oBusca.Show()
11692:                             ENDIF
11693:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11694:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11695:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11696:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11697:                                 ENDIF
11698:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11699:                             ELSE
11700:                                 loc_oPg.txt_4c_Teor.Value = ""
11701:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11702:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11703:                                 ENDIF
11704:                                 THIS.this_oBusinessObject.this_cTeors = ""
11705:                             ENDIF
11706:                             loc_oBusca.Release()
11707:                         ENDIF
11708:                         IF USED("cursor_4c_BuscaTeorSel")
11709:                             USE IN cursor_4c_BuscaTeorSel
11710:                         ENDIF
11711:                     ENDIF
11712:                     USE IN cursor_4c_BuscaMtlT
11713:                 ENDIF
11714:             ENDIF
11715:         CATCH TO loc_oErro
11716:             MsgErro(loc_oErro.Message, "Erro ao buscar teor")
11717:         ENDTRY
11718:     ENDPROC
11719: 
11720:     *--------------------------------------------------------------------------
11721:     * TxtGruccusFiscLostFocus - Armazena grupo de custo no BO
11722:     *--------------------------------------------------------------------------
11723:     PROCEDURE TxtGruccusFiscLostFocus()
11724:         LOCAL loc_oPg
11725:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11726:             RETURN
11727:         ENDIF
11728:         TRY
11729:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11730:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11731:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11732:                     THIS.this_oBusinessObject.this_cGruccus = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
11733:                 ENDIF
11734:             ENDIF
11735:         CATCH TO loc_oErro
11736:             MsgErro(loc_oErro.Message, "Erro ao atualizar grupo de custo")
11737:         ENDTRY
11738:     ENDPROC
11739: 
11740:     *--------------------------------------------------------------------------
11741:     * TxtContaccusFiscLostFocus - Armazena conta de custo no BO
11742:     *--------------------------------------------------------------------------
11743:     PROCEDURE TxtContaccusFiscLostFocus()
11744:         LOCAL loc_oPg
11745:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11746:             RETURN
11747:         ENDIF
11748:         TRY
11749:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11750:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11751:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11752:                     THIS.this_oBusinessObject.this_cContaccus = ALLTRIM(NVL(loc_oPg.txt_4c_Contaccus.Value, ""))
11753:                 ENDIF
11754:             ENDIF
11755:         CATCH TO loc_oErro
11756:             MsgErro(loc_oErro.Message, "Erro ao atualizar conta de custo")
11757:         ENDTRY
11758:     ENDPROC
11759: 
11760:     *--------------------------------------------------------------------------
11761:     * CmdDescFisClick - Gerar Descricao Fiscal automatica
11762:     * Legado: fGerDescFis(0, crSigCdPro.CPros, ThisForm.poDataMgr)
11763:     *--------------------------------------------------------------------------
11764:     PROCEDURE CmdDescFisClick()
11765:         LOCAL loc_oPg, loc_cCpro
11766:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11767:             RETURN
11768:         ENDIF
11769:         TRY
11770:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11771:                 RETURN
11772:             ENDIF
11773:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11774:             loc_cCpro = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11775:             IF EMPTY(loc_cCpro)
11776:                 MsgAviso("Informe o c" + CHR(243) + "digo do produto antes de gerar a descri" + ;
11777:                     CHR(231) + CHR(227) + "o fiscal.", "Aten" + CHR(231) + CHR(227) + "o")
11778:                 RETURN
11779:             ENDIF
11780:             *-- Gerar descricao fiscal a partir dos campos fiscais
11781:             *-- Legado usa fGerDescFis() - funcao de framework nao disponivel
11782:             *-- Implementacao simplificada: combina classificacao + origem + ICMS
11783:             LOCAL loc_cDescFis
11784:             loc_cDescFis = ""
11785:             IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11786:                 loc_cDescFis = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11787:             ENDIF
11788:             IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O" AND !EMPTY(loc_oPg.txt_4c_Dclfiscal.Value)
11789:                 IF !EMPTY(loc_cDescFis)
11790:                     loc_cDescFis = loc_cDescFis + " - "
11791:                 ENDIF
11792:                 loc_cDescFis = loc_cDescFis + ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
11793:             ENDIF
11794:             IF !EMPTY(loc_cDescFis)
11795:                 IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
11796:                     loc_oPg.obj_4c_Descfis.Value = loc_cDescFis
11797:                     THIS.this_oBusinessObject.this_cDescfis = loc_cDescFis
11798:                 ENDIF
11799:             ELSE
11800:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
11801:             ENDIF
11802:         CATCH TO loc_oErro
11803:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11804:         ENDTRY
11805:     ENDPROC
11806: 
11807:     *==========================================================================
11808:     * FASE 14 - Aba Designer (pgDesigner - Page7 do pgf_4c_Dados)
11809:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
11810:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11811:     * Controles: 2 grids (4col + 1col), 1 editbox, 1 label, 3 buttons, 1 image, 1 shape
11812:     *==========================================================================
11813:     PROTECTED PROCEDURE ConfigurarPgPgDesigner()
11814:         LOCAL loc_oPg, loc_oGrd
11815:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11816: 
11817:         *----------------------------------------------------------------------
11818:         *-- Cursor placeholder cursor_4c_SigPrTar (SigPrTar - Tarefas Designer)
11819:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11820:         *----------------------------------------------------------------------
11821:         IF !USED("cursor_4c_SigPrTar")
11822:             SET NULL ON
11823:             CREATE CURSOR cursor_4c_SigPrTar (;
11824:                 DtInis  D NULL, ;
11825:                 DtFims  D NULL, ;
11826:                 Usuars  C(10), ;
11827:                 Tarefas C(10), ;
11828:                 ObsTars M)
11829:             SET NULL OFF
11830:         ENDIF
11831: 
11832:         *----------------------------------------------------------------------
11833:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11834:         *-- Campos: Arquivos
11835:         *----------------------------------------------------------------------
11836:         IF !USED("cursor_4c_SigPrArq")
11837:             SET NULL ON
11838:             CREATE CURSOR cursor_4c_SigPrArq (;
11839:                 Arquivos C(200))
11840:             SET NULL OFF
11841:         ENDIF
11842: 
11843:         *----------------------------------------------------------------------
11844:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11845:         *----------------------------------------------------------------------
11846:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11847:         WITH loc_oPg.shp_4c_ArqFundo
11848:             .Top         = 415
11849:             .Left        = 584
11850:             .Width       = 407
11851:             .Height      = 202
11852:             .BackColor   = RGB(230, 230, 230)
11853:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11941 a 12589:
11941:                 .ReadOnly          = .F.
11942:             ENDWITH
11943:         ENDWITH
11944:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11945: 
11946:         *----------------------------------------------------------------------
11947:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11948:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11949:         *----------------------------------------------------------------------
11950:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11951:         WITH loc_oPg.obj_4c_ObsTarefas
11952:             .Top              = 160
11953:             .Left             = 584
11954:             .Width            = 407
11955:             .Height           = 238
11956:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11957:             .FontName         = "Tahoma"
11958:             .FontSize         = 8
11959:             .SpecialEffect    = 1
11960:             .ForeColor        = RGB(36, 84, 155)
11961:             .Enabled          = .T.
11962:             .Visible          = .T.
11963:         ENDWITH
11964: 
11965:         *----------------------------------------------------------------------
11966:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11967:         *----------------------------------------------------------------------
11968:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11969:         WITH loc_oPg.cmd_4c_IniTarefa
11970:             .Top             = 168
11971:             .Left            = 509
11972:             .Width           = 42
11973:             .Height          = 42
11974:             .Caption         = ""
11975:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11976:             .FontName        = "Tahoma"
11977:             .FontSize        = 8
11978:             .Themes          = .F.
11979:             .ToolTipText     = "Iniciar Nova Tarefa"
11980:             .Enabled         = .F.
11981:             .Visible         = .T.
11982:         ENDWITH
11983:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
11984: 
11985:         *----------------------------------------------------------------------
11986:         *-- btnFimTarefa: Encerrar Tarefa (T:203 L:509 W:42 H:42)
11987:         *----------------------------------------------------------------------
11988:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
11989:         WITH loc_oPg.cmd_4c_FimTarefa
11990:             .Top             = 203
11991:             .Left            = 509
11992:             .Width           = 42
11993:             .Height          = 42
11994:             .Caption         = ""
11995:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.bmp"
11996:             .FontName        = "Tahoma"
11997:             .FontSize        = 8
11998:             .Themes          = .F.
11999:             .ToolTipText     = "Encerrar Tarefa"
12000:             .Enabled         = .F.
12001:             .Visible         = .T.
12002:         ENDWITH
12003:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
12004: 
12005:         *----------------------------------------------------------------------
12006:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
12007:         *----------------------------------------------------------------------
12008:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
12009:         WITH loc_oPg.grd_4c_Arquivos
12010:             .Top         = 415
12011:             .Left        = 10
12012:             .Width       = 495
12013:             .Height      = 202
12014:             .ColumnCount = 1
12015:             .FontName    = "Tahoma"
12016:             .FontSize    = 8
12017:             .DeleteMark  = .F.
12018:             .ScrollBars  = 2
12019:             .ReadOnly    = .T.
12020:             .Themes      = .F.
12021:             .Visible     = .T.
12022:             .RecordMark   = .F.
12023:         ENDWITH
12024:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
12025:         WITH loc_oPg.grd_4c_Arquivos
12026:             WITH .Column1
12027:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12028:                 .Header1.Caption   = "Arquivos Para Designer"
12029:                 .Header1.FontName  = "Tahoma"
12030:                 .Header1.FontSize  = 8
12031:                 .Header1.Alignment = 2
12032:                 .Width             = 464
12033:                 .Movable           = .F.
12034:                 .Resizable         = .F.
12035:                 .ReadOnly          = .T.
12036:             ENDWITH
12037:         ENDWITH
12038:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12039: 
12040:         *----------------------------------------------------------------------
12041:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12042:         *----------------------------------------------------------------------
12043:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
12044:         WITH loc_oPg.cmd_4c_InsArqs
12045:             .Top             = 416
12046:             .Left            = 509
12047:             .Width           = 42
12048:             .Height          = 42
12049:             .Caption         = ""
12050:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
12051:             .FontName        = "Tahoma"
12052:             .FontSize        = 8
12053:             .Themes          = .F.
12054:             .ToolTipText     = "Inserir Arquivo"
12055:             .Enabled         = .F.
12056:             .Visible         = .T.
12057:         ENDWITH
12058:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
12059: 
12060:         *----------------------------------------------------------------------
12061:         *-- btnOpnArqs: Abrir Arquivo (T:500 L:509 W:42 H:42)
12062:         *----------------------------------------------------------------------
12063:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
12064:         WITH loc_oPg.cmd_4c_OpnArqs
12065:             .Top             = 500
12066:             .Left            = 509
12067:             .Width           = 42
12068:             .Height          = 42
12069:             .Caption         = ""
12070:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.bmp"
12071:             .FontName        = "Tahoma"
12072:             .FontSize        = 8
12073:             .Themes          = .F.
12074:             .ToolTipText     = "Abrir Arquivo"
12075:             .Enabled         = .T.
12076:             .Visible         = .T.
12077:         ENDWITH
12078:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
12079: 
12080:         *----------------------------------------------------------------------
12081:         *-- btnExcArqs: Excluir Arquivo (T:458 L:509 W:42 H:42)
12082:         *----------------------------------------------------------------------
12083:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
12084:         WITH loc_oPg.cmd_4c_ExcArqs
12085:             .Top             = 458
12086:             .Left            = 509
12087:             .Width           = 42
12088:             .Height          = 42
12089:             .Caption         = ""
12090:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.bmp"
12091:             .FontName        = "Tahoma"
12092:             .FontSize        = 8
12093:             .Themes          = .F.
12094:             .ToolTipText     = "Excluir Arquivo"
12095:             .Enabled         = .F.
12096:             .Visible         = .T.
12097:         ENDWITH
12098:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
12099: 
12100:         *----------------------------------------------------------------------
12101:         *-- imgArqJpg: Imagem do arquivo (T:417 L:586 W:403 H:198)
12102:         *----------------------------------------------------------------------
12103:         loc_oPg.AddObject("img_4c_ArqJpg", "Image")
12104:         WITH loc_oPg.img_4c_ArqJpg
12105:             .Top         = 417
12106:             .Left        = 586
12107:             .Width       = 403
12108:             .Height      = 198
12109:             .Stretch     = 1
12110:             .Visible     = .F.
12111:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
12112:         ENDWITH
12113:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
12114: 
12115:         *----------------------------------------------------------------------
12116:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
12117:         *----------------------------------------------------------------------
12118:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12119:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12120:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12121: 
12122:         *----------------------------------------------------------------------
12123:         *-- Binding When para EditBox Obs da Tarefa
12124:         *----------------------------------------------------------------------
12125:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12126: 
12127:         *----------------------------------------------------------------------
12128:         *-- Bindings When para botoes de tarefa
12129:         *----------------------------------------------------------------------
12130:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12131:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12132: 
12133:         *----------------------------------------------------------------------
12134:         *-- Binding When para Column1 do grdArquivos
12135:         *----------------------------------------------------------------------
12136:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12137: 
12138:         *----------------------------------------------------------------------
12139:         *-- Bindings When para botoes de arquivo
12140:         *----------------------------------------------------------------------
12141:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12142:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12143:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12144:     ENDPROC
12145: 
12146:     *--------------------------------------------------------------------------
12147:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12148:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12149:     *--------------------------------------------------------------------------
12150:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12151:         LOCAL loc_oPg
12152:         TRY
12153:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12154:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12155:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12156:                     *-- Sincronizar editbox com observacao da tarefa selecionada
12157:                     IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12158:                         loc_oPg.obj_4c_ObsTarefas.Value = NVL(cursor_4c_SigPrTar.ObsTars, "")
12159:                     ELSE
12160:                         loc_oPg.obj_4c_ObsTarefas.Value = ""
12161:                     ENDIF
12162:                     loc_oPg.obj_4c_ObsTarefas.Refresh()
12163:                 ENDIF
12164:             ENDIF
12165:         CATCH TO loc_oErro
12166:             MsgErro(loc_oErro.Message, "Erro ao atualizar observa" + CHR(231) + CHR(227) + "o da tarefa")
12167:         ENDTRY
12168:     ENDPROC
12169: 
12170:     *--------------------------------------------------------------------------
12171:     * GrdArquivosAfterRowColChange - Mostra imagem do arquivo selecionado
12172:     * Legado: grdArquivos.Procedure (AfterRowColChange) ? mostra imagem JPG/BMP
12173:     *--------------------------------------------------------------------------
12174:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
12175:         LOCAL loc_oPg, loc_cArq, loc_cExt
12176:         TRY
12177:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12178:                 RETURN
12179:             ENDIF
12180:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12181:             IF VARTYPE(loc_oPg.img_4c_ArqJpg) # "O"
12182:                 RETURN
12183:             ENDIF
12184:             CLEAR RESOURCES
12185:             loc_oPg.img_4c_ArqJpg.Picture = ""
12186:             loc_oPg.img_4c_ArqJpg.Visible = .F.
12187:             IF USED("cursor_4c_SigPrArq") AND !EOF("cursor_4c_SigPrArq")
12188:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12189:                 IF !EMPTY(loc_cArq) AND AT(".", loc_cArq) > 0
12190:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12191:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12192:                         loc_oPg.img_4c_ArqJpg.Picture  = loc_cArq
12193:                         loc_oPg.img_4c_ArqJpg.Visible  = .T.
12194:                     ENDIF
12195:                 ENDIF
12196:             ENDIF
12197:         CATCH TO loc_oErro
12198:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem do arquivo")
12199:         ENDTRY
12200:     ENDPROC
12201: 
12202:     *--------------------------------------------------------------------------
12203:     * BtnIniTarefaClick - Inicia nova tarefa para o usuario logado
12204:     * Legado: btnIniTarefa.Click - verifica tarefa nao encerrada, insere novo registro
12205:     *--------------------------------------------------------------------------
12206:     PROCEDURE BtnIniTarefaClick()
12207:         LOCAL loc_lResultado
12208:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12209:             RETURN
12210:         ENDIF
12211:         loc_lResultado = .T.
12212:         TRY
12213:             IF !USED("cursor_4c_SigPrTar")
12214:                 loc_lResultado = .F.
12215:             ENDIF
12216:             IF loc_lResultado
12217:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12218:                 SELECT cursor_4c_SigPrTar
12219:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12220:                     AND EMPTY(NVL(DtFims, {}))
12221:                 IF !EOF("cursor_4c_SigPrTar")
12222:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12223:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12224:                     loc_lResultado = .F.
12225:                 ENDIF
12226:             ENDIF
12227:             IF loc_lResultado
12228:                 *-- Verificar se existe tarefa sem codigo informado
12229:                 SELECT cursor_4c_SigPrTar
12230:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12231:                     AND EMPTY(Tarefas)
12232:                 IF !EOF("cursor_4c_SigPrTar")
12233:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12234:                     loc_lResultado = .F.
12235:                 ENDIF
12236:             ENDIF
12237:             IF loc_lResultado
12238:                 *-- Inserir nova tarefa com data/hora de inicio
12239:                 SELECT cursor_4c_SigPrTar
12240:                 APPEND BLANK
12241:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12242:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12243:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12244:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12245:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12246:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12247:                 ENDIF
12248:             ENDIF
12249:         CATCH TO loc_oErro
12250:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12251:         ENDTRY
12252:     ENDPROC
12253: 
12254:     *--------------------------------------------------------------------------
12255:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12256:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12257:     *--------------------------------------------------------------------------
12258:     PROCEDURE BtnFimTarefaClick()
12259:         LOCAL loc_lResultado
12260:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12261:             RETURN
12262:         ENDIF
12263:         loc_lResultado = .T.
12264:         TRY
12265:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12266:                 loc_lResultado = .F.
12267:             ENDIF
12268:             IF loc_lResultado
12269:                 IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) # ALLTRIM(gc_4c_UsuarioLogado)
12270:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12271:                     loc_lResultado = .F.
12272:                 ENDIF
12273:             ENDIF
12274:             IF loc_lResultado
12275:                 IF !EMPTY(cursor_4c_SigPrTar.DtFims)
12276:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", "Aten" + CHR(231) + CHR(227) + "o")
12277:                     loc_lResultado = .F.
12278:                 ENDIF
12279:             ENDIF
12280:             IF loc_lResultado
12281:                 SELECT cursor_4c_SigPrTar
12282:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12283:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12284:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12285:                 ENDIF
12286:             ENDIF
12287:         CATCH TO loc_oErro
12288:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12289:         ENDTRY
12290:     ENDPROC
12291: 
12292:     *--------------------------------------------------------------------------
12293:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12294:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12295:     *--------------------------------------------------------------------------
12296:     PROCEDURE BtnInsArqsClick()
12297:         LOCAL loc_cArq, loc_lResultado
12298:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12299:             RETURN
12300:         ENDIF
12301:         loc_lResultado = .T.
12302:         TRY
12303:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12304:             IF EMPTY(loc_cArq)
12305:                 loc_lResultado = .F.
12306:             ENDIF
12307:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12308:                 SELECT cursor_4c_SigPrArq
12309:                 APPEND BLANK
12310:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12311:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12312:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12313:                 ENDIF
12314:             ENDIF
12315:         CATCH TO loc_oErro
12316:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12317:         ENDTRY
12318:     ENDPROC
12319: 
12320:     *--------------------------------------------------------------------------
12321:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12322:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12323:     *--------------------------------------------------------------------------
12324:     PROCEDURE BtnOpnArqsClick()
12325:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12326:         loc_lResultado = .T.
12327:         TRY
12328:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12329:                 loc_lResultado = .F.
12330:             ENDIF
12331:             IF loc_lResultado
12332:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12333:                 IF EMPTY(loc_cArq)
12334:                     loc_lResultado = .F.
12335:                 ENDIF
12336:             ENDIF
12337:             IF loc_lResultado
12338:                 IF !FILE(loc_cArq)
12339:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, "Aten" + CHR(231) + CHR(227) + "o")
12340:                     loc_lResultado = .F.
12341:                 ENDIF
12342:             ENDIF
12343:             IF loc_lResultado
12344:                 loc_oApp = CREATEOBJECT("Shell.Application")
12345:                 IF VARTYPE(loc_oApp) = "O"
12346:                     loc_oApp.Open(loc_cArq)
12347:                 ENDIF
12348:             ENDIF
12349:         CATCH TO loc_oErro
12350:             MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
12351:         ENDTRY
12352:     ENDPROC
12353: 
12354:     *--------------------------------------------------------------------------
12355:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12356:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12357:     *--------------------------------------------------------------------------
12358:     PROCEDURE BtnExcArqsClick()
12359:         LOCAL loc_lResultado
12360:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12361:             RETURN
12362:         ENDIF
12363:         loc_lResultado = .T.
12364:         TRY
12365:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12366:                 loc_lResultado = .F.
12367:             ENDIF
12368:             IF loc_lResultado
12369:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12370:                     loc_lResultado = .F.
12371:                 ENDIF
12372:             ENDIF
12373:             IF loc_lResultado
12374:                 SELECT cursor_4c_SigPrArq
12375:                 DELETE
12376:                 IF !EOF("cursor_4c_SigPrArq")
12377:                     SKIP
12378:                     SKIP -1
12379:                 ENDIF
12380:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12381:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12382:                 ENDIF
12383:                 *-- Limpar imagem ao excluir arquivo
12384:                 LOCAL loc_oPg
12385:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12386:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12387:                     CLEAR RESOURCES
12388:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12389:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12390:                 ENDIF
12391:             ENDIF
12392:         CATCH TO loc_oErro
12393:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12394:         ENDTRY
12395:     ENDPROC
12396: 
12397:     *--------------------------------------------------------------------------
12398:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12399:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12400:     *--------------------------------------------------------------------------
12401:     PROCEDURE ImgArqJpgClick()
12402:         LOCAL loc_cArq, loc_cExt, loc_lResultado
12403:         loc_lResultado = .T.
12404:         TRY
12405:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12406:                 loc_lResultado = .F.
12407:             ENDIF
12408:             IF loc_lResultado
12409:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12410:                 IF EMPTY(loc_cArq) OR !FILE(loc_cArq)
12411:                     loc_lResultado = .F.
12412:                 ENDIF
12413:             ENDIF
12414:             IF loc_lResultado
12415:                 IF AT(".", loc_cArq) > 0
12416:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12417:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12418:                         *-- Tentar abrir zoom form se disponivel
12419:                         IF PEMSTATUS("FormSigOpZom", "NAME", 5) OR FILE(gc_4c_CaminhoForms + "SigOpZom.prg")
12420:                             DO FORM (gc_4c_CaminhoForms + "SigOpZom") WITH loc_cArq, "Arquivo : " + loc_cArq
12421:                         ELSE
12422:                             *-- Fallback: abrir com aplicativo padrao do SO
12423:                             LOCAL loc_oApp
12424:                             loc_oApp = CREATEOBJECT("Shell.Application")
12425:                             IF VARTYPE(loc_oApp) = "O"
12426:                                 loc_oApp.Open(loc_cArq)
12427:                             ENDIF
12428:                         ENDIF
12429:                     ENDIF
12430:                 ENDIF
12431:             ENDIF
12432:         CATCH TO loc_oErro
12433:             MsgErro(loc_oErro.Message, "Erro ao abrir imagem em zoom")
12434:         ENDTRY
12435:     ENDPROC
12436: 
12437:     *--------------------------------------------------------------------------
12438:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12439:     * Legado: grdDesigner.Column4.Text1.When
12440:     *--------------------------------------------------------------------------
12441:     PROCEDURE GrdDesignerCol4When()
12442:         LOCAL loc_lResult
12443:         loc_lResult = .F.
12444:         TRY
12445:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12446:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12447:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12448:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12449:                         loc_lResult = .T.
12450:                     ENDIF
12451:                 ENDIF
12452:             ENDIF
12453:         CATCH TO loc_oErro
12454:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12455:         ENDTRY
12456:         RETURN loc_lResult
12457:     ENDPROC
12458: 
12459:     *--------------------------------------------------------------------------
12460:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12461:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12462:     *--------------------------------------------------------------------------
12463:     PROCEDURE GrdDesignerCol4Valid()
12464:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12465:         loc_lResult = .T.
12466:         TRY
12467:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12468:                 loc_lResultado = .T.
12469:             ENDIF
12470:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12471:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12472:             IF !EMPTY(loc_cCodigo)
12473:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12474:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12475:                     "Buscar Tarefa")
12476:                 IF VARTYPE(loc_oBusca) = "O"
12477:                     IF !loc_oBusca.this_lAchouRegistro
12478:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12479:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12480:                         loc_oBusca.Show()
12481:                     ENDIF
12482:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12483:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12484:                     ELSE
12485:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12486:                     ENDIF
12487:                     loc_oBusca.Release()
12488:                 ENDIF
12489:                 IF USED("cursor_4c_BuscaTar")
12490:                     USE IN cursor_4c_BuscaTar
12491:                 ENDIF
12492:             ENDIF
12493:         CATCH TO loc_oErro
12494:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12495:         ENDTRY
12496:         RETURN loc_lResult
12497:     ENDPROC
12498: 
12499:     *--------------------------------------------------------------------------
12500:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12501:     * Legado: grdDesigner.Column4.Text1.LostFocus
12502:     *--------------------------------------------------------------------------
12503:     PROCEDURE GrdDesignerCol4LostFocus()
12504:         LOCAL loc_oPg
12505:         TRY
12506:             IF LASTKEY() = 13
12507:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12508:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12509:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12510:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12511:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12512:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12513:                             ENDIF
12514:                         ENDIF
12515:                     ENDIF
12516:                 ENDIF
12517:             ENDIF
12518:         CATCH TO loc_oErro
12519:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12520:         ENDTRY
12521:     ENDPROC
12522: 
12523:     *--------------------------------------------------------------------------
12524:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12525:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12526:     *--------------------------------------------------------------------------
12527:     PROCEDURE ObsTarefasWhen()
12528:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12529:     ENDPROC
12530: 
12531:     *--------------------------------------------------------------------------
12532:     * BtnIniTarefaWhen - Habilita botao Iniciar Tarefa somente em INCLUIR/ALTERAR
12533:     * Legado: btnIniTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12534:     *--------------------------------------------------------------------------
12535:     PROCEDURE BtnIniTarefaWhen()
12536:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12537:     ENDPROC
12538: 
12539:     *--------------------------------------------------------------------------
12540:     * BtnFimTarefaWhen - Habilita botao Encerrar Tarefa somente em INCLUIR/ALTERAR
12541:     * Legado: btnFimTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12542:     *--------------------------------------------------------------------------
12543:     PROCEDURE BtnFimTarefaWhen()
12544:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12545:     ENDPROC
12546: 
12547:     *--------------------------------------------------------------------------
12548:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12549:     * Legado: grdArquivos.Column1.Text1.When
12550:     *--------------------------------------------------------------------------
12551:     PROCEDURE GrdArquivosCol1When()
12552:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12553:     ENDPROC
12554: 
12555:     *--------------------------------------------------------------------------
12556:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12557:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12558:     *--------------------------------------------------------------------------
12559:     PROCEDURE BtnInsArqsWhen()
12560:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12561:     ENDPROC
12562: 
12563:     *--------------------------------------------------------------------------
12564:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12565:     * Legado: btnOpnArqs.When - Return .t.
12566:     *--------------------------------------------------------------------------
12567:     PROCEDURE BtnOpnArqsWhen()
12568:         RETURN .T.
12569:     ENDPROC
12570: 
12571:     *--------------------------------------------------------------------------
12572:     * BtnExcArqsWhen - Habilita botao Excluir Arquivo somente em INCLUIR/ALTERAR
12573:     * Legado: btnExcArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12574:     *--------------------------------------------------------------------------
12575:     PROCEDURE BtnExcArqsWhen()
12576:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12577:     ENDPROC
12578: 
12579:     *--------------------------------------------------------------------------
12580:     * Destroy - Liberar recursos
12581:     *--------------------------------------------------------------------------
12582:     PROCEDURE Destroy()
12583:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
12584:             THIS.this_oBusinessObject = .NULL.
12585:         ENDIF
12586:         DODEFAULT()
12587:     ENDPROC
12588: 
12589: ENDDEFINE

