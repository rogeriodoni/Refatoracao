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
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=172 vs migrado 'chk_4c_Fwoption1' Top=331 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=879 vs migrado 'chk_4c_Fwoption1' Left=180 (diff=699px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (12556 linhas total):

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
3448:                 IF LEFT(loc_cNome, 4) = "cnt_" AND !loc_oCtrl.Visible
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
5223:         *-- Qt. Pedido (T:221 L:626) + Garantia (T:224 L:880)
5224:         *----------------------------------------------------------------------
5225:         loc_oPg.AddObject("lbl_4c_LblQtPed", "Label")
5226:         WITH loc_oPg.lbl_4c_LblQtPed
5227:             .Caption   = "Qt. Pedido :"
5228:             .Top       = 224
5229:             .Left      = 541
5230:             .Width     = 80
5231:             .Height    = 15
5232:             .FontName  = "Tahoma"
5233:             .FontSize  = 8
5234:             .BackStyle = 0
5235:             .ForeColor = RGB(90, 90, 90)
5236:             .Visible   = .T.
5237:         ENDWITH
5238: 
5239:         loc_oPg.AddObject("txt_4c_QtPed", "TextBox")
5240:         WITH loc_oPg.txt_4c_QtPed
5241:             .Top           = 221
5242:             .Left          = 626
5243:             .Width         = 80
5244:             .Height        = 21
5245:             .FontName      = "Tahoma"
5246:             .FontSize      = 8
5247:             .MaxLength     = 10
5248:             .Value         = ""
5249:             .SpecialEffect = 1
5250:             .Visible       = .T.
5251:         ENDWITH
5252: 
5253:         loc_oPg.AddObject("lbl_4c_LblGarantia", "Label")
5254:         WITH loc_oPg.lbl_4c_LblGarantia
5255:             .Caption   = "Gar.(dias):"
5256:             .Top       = 227
5257:             .Left      = 820
5258:             .Width     = 57

*-- Linhas 5656 a 5700:
5656:             .SpecialEffect = 1
5657:             .Visible       = .T.
5658:         ENDWITH
5659:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress",  THIS, "TxtCodFinPKeyPress")
5660:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "LostFocus", THIS, "TxtCodFinPLostFocus")
5661: 
5662:         *-- Say35: "Peso Bruto :" (T:326 L:336 W:61)
5663:         loc_oPg.AddObject("lbl_4c_LblPesoBs", "Label")
5664:         WITH loc_oPg.lbl_4c_LblPesoBs
5665:             .Caption   = "Peso Bruto :"
5666:             .Top       = 326
5667:             .Left      = 336
5668:             .Width     = 61
5669:             .Height    = 15
5670:             .FontName  = "Tahoma"
5671:             .FontSize  = 8
5672:             .BackStyle = 0
5673:             .ForeColor = RGB(90, 90, 90)
5674:             .Visible   = .T.
5675:         ENDWITH
5676: 
5677:         *-- getPesoBs -> txt_4c_PesoBs (T:322 L:401 W:111 H:23) - pesobs numeric(7,3)
5678:         loc_oPg.AddObject("txt_4c_PesoBs", "TextBox")
5679:         WITH loc_oPg.txt_4c_PesoBs
5680:             .Top           = 322
5681:             .Left          = 401
5682:             .Width         = 111
5683:             .Height        = 23
5684:             .FontName      = "Tahoma"
5685:             .FontSize      = 8
5686:             .MaxLength     = 10
5687:             .Value         = ""
5688:             .SpecialEffect = 1
5689:             .Visible       = .T.
5690:         ENDWITH
5691: 
5692:         *----------------------------------------------------------------------
5693:         *-- Acabamento (T:346) - lblAcabamento: "Acabamento :" (T:350 L:7)
5694:         *----------------------------------------------------------------------
5695:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5696:         WITH loc_oPg.lbl_4c_LblAcabamento
5697:             .Caption   = "Acabamento :"
5698:             .Top       = 350
5699:             .Left      = 7
5700:             .Width     = 104

*-- Linhas 5735 a 5779:
5735:             .SpecialEffect = 1
5736:             .Visible       = .T.
5737:         ENDWITH
5738:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress",  THIS, "TxtCodAcbKeyPress")
5739:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "TxtCodAcbLostFocus")
5740: 
5741:         *-- Say34: "Peso Liquido :" (T:350 L:329 W:68)
5742:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
5743:         WITH loc_oPg.lbl_4c_LblPmedio
5744:             .Caption   = "Peso L" + CHR(237) + "quido :"
5745:             .Top       = 350
5746:             .Left      = 329
5747:             .Width     = 68
5748:             .Height    = 15
5749:             .FontName  = "Tahoma"
5750:             .FontSize  = 8
5751:             .BackStyle = 0
5752:             .ForeColor = RGB(90, 90, 90)
5753:             .Visible   = .T.
5754:         ENDWITH
5755: 
5756:         *-- getPmedio -> txt_4c_Pmedio (T:346 L:401 W:111 H:23) - pesoms numeric(8,3)
5757:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
5758:         WITH loc_oPg.txt_4c_Pmedio
5759:             .Top           = 346
5760:             .Left          = 401
5761:             .Width         = 111
5762:             .Height        = 23
5763:             .FontName      = "Tahoma"
5764:             .FontSize      = 8
5765:             .MaxLength     = 10
5766:             .Value         = ""
5767:             .SpecialEffect = 1
5768:             .Visible       = .T.
5769:         ENDWITH
5770: 
5771:         *----------------------------------------------------------------------
5772:         *-- Estoque (T:353) - Say28: "Estoque :" (T:357 L:577 W:48)
5773:         *----------------------------------------------------------------------
5774:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
5775:         WITH loc_oPg.lbl_4c_LblEstoque
5776:             .Caption   = "Estoque :"
5777:             .Top       = 357
5778:             .Left      = 577
5779:             .Width     = 48

*-- Linhas 5865 a 5941:
5865:             .SpecialEffect = 1
5866:             .Visible       = .T.
5867:         ENDWITH
5868:         BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress",  THIS, "TxtClassKeyPress")
5869:         BINDEVENT(loc_oPg.txt_4c_Class, "LostFocus", THIS, "TxtClassLostFocus")
5870: 
5871:         *-- Say5: "Local :" (T:374 L:364 W:33)
5872:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
5873:         WITH loc_oPg.lbl_4c_LblLocal
5874:             .Caption   = "Local :"
5875:             .Top       = 374
5876:             .Left      = 364
5877:             .Width     = 33
5878:             .Height    = 15
5879:             .FontName  = "Tahoma"
5880:             .FontSize  = 8
5881:             .BackStyle = 0
5882:             .ForeColor = RGB(90, 90, 90)
5883:             .Visible   = .T.
5884:         ENDWITH
5885: 
5886:         *-- Get_Local -> txt_4c_Local (T:370 L:401 W:111 H:23) - locals char(10)
5887:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
5888:         WITH loc_oPg.txt_4c_Local
5889:             .Top           = 370
5890:             .Left          = 401
5891:             .Width         = 111
5892:             .Height        = 23
5893:             .FontName      = "Tahoma"
5894:             .FontSize      = 8
5895:             .MaxLength     = 10
5896:             .Value         = ""
5897:             .SpecialEffect = 1
5898:             .Visible       = .T.
5899:         ENDWITH
5900:         BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress",  THIS, "TxtLocalKeyPress")
5901:         BINDEVENT(loc_oPg.txt_4c_Local, "LostFocus", THIS, "TxtLocalLostFocus")
5902: 
5903:         *----------------------------------------------------------------------
5904:         *-- Custo (T:375) - Say3: "Valor de Custo :" (T:379 L:546 W:79)
5905:         *----------------------------------------------------------------------
5906:         loc_oPg.AddObject("lbl_4c_LblCusto", "Label")
5907:         WITH loc_oPg.lbl_4c_LblCusto
5908:             .Caption   = "Valor de Custo :"
5909:             .Top       = 379
5910:             .Left      = 546
5911:             .Width     = 79
5912:             .Height    = 15
5913:             .FontName  = "Tahoma"
5914:             .FontSize  = 8
5915:             .BackStyle = 0
5916:             .ForeColor = RGB(90, 90, 90)
5917:             .Visible   = .T.
5918:         ENDWITH
5919: 
5920:         *-- getCtotal -> txt_4c_Ctotal (T:375 L:626 W:127 H:21) - custofs (display)
5921:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
5922:         WITH loc_oPg.txt_4c_Ctotal
5923:             .Top           = 375
5924:             .Left          = 626
5925:             .Width         = 127
5926:             .Height        = 21
5927:             .FontName      = "Tahoma"
5928:             .FontSize      = 8
5929:             .ReadOnly      = .T.
5930:             .MaxLength     = 14
5931:             .Value         = ""
5932:             .SpecialEffect = 1
5933:             .ForeColor     = RGB(36, 84, 155)
5934:             .BackColor     = RGB(224, 235, 235)
5935:             .Visible       = .T.
5936:         ENDWITH
5937: 
5938:         *-- getMctotal -> txt_4c_Mctotal (T:375 L:754 W:31 H:21) - moecusfs (display)
5939:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
5940:         WITH loc_oPg.txt_4c_Mctotal
5941:             .Top           = 375

*-- Linhas 6032 a 6123:
6032:             .SpecialEffect = 1
6033:             .Visible       = .T.
6034:         ENDWITH
6035:         BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress",  THIS, "TxtCuniKeyPress")
6036:         BINDEVENT(loc_oPg.txt_4c_Cuni, "LostFocus", THIS, "TxtCuniLostFocus")
6037: 
6038:         *-- Get_Duni -> txt_4c_DUni (T:394 L:145 W:150 H:23) - desc unid1 (readonly)
6039:         loc_oPg.AddObject("txt_4c_DUni", "TextBox")
6040:         WITH loc_oPg.txt_4c_DUni
6041:             .Top           = 394
6042:             .Left          = 145
6043:             .Width         = 150
6044:             .Height        = 23
6045:             .FontName      = "Tahoma"
6046:             .FontSize      = 8
6047:             .ReadOnly      = .T.
6048:             .Value         = ""
6049:             .SpecialEffect = 1
6050:             .Visible       = .T.
6051:         ENDWITH
6052: 
6053:         *-- Say18: "(2) :" (T:398 L:301 W:23)
6054:         loc_oPg.AddObject("lbl_4c_LblUnid2", "Label")
6055:         WITH loc_oPg.lbl_4c_LblUnid2
6056:             .Caption   = "(2) :"
6057:             .Top       = 398
6058:             .Left      = 301
6059:             .Width     = 23
6060:             .Height    = 15
6061:             .FontName  = "Tahoma"
6062:             .FontSize  = 8
6063:             .BackStyle = 0
6064:             .ForeColor = RGB(90, 90, 90)
6065:             .Visible   = .T.
6066:         ENDWITH
6067: 
6068:         *-- Get_cunip -> txt_4c_Cunip (T:394 L:330 W:31 H:23) - cunips char(3)
6069:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
6070:         WITH loc_oPg.txt_4c_Cunip
6071:             .Top           = 394
6072:             .Left          = 330
6073:             .Width         = 31
6074:             .Height        = 23
6075:             .FontName      = "Tahoma"
6076:             .FontSize      = 8
6077:             .MaxLength     = 3
6078:             .Value         = ""
6079:             .SpecialEffect = 1
6080:             .Visible       = .T.
6081:         ENDWITH
6082:         BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress",  THIS, "TxtCunipKeyPress")
6083:         BINDEVENT(loc_oPg.txt_4c_Cunip, "LostFocus", THIS, "TxtCunipLostFocus")
6084: 
6085:         *-- get_dunip -> txt_4c_DUnip (T:394 L:362 W:150 H:23) - desc unid2 (readonly)
6086:         loc_oPg.AddObject("txt_4c_DUnip", "TextBox")
6087:         WITH loc_oPg.txt_4c_DUnip
6088:             .Top           = 394
6089:             .Left          = 362
6090:             .Width         = 150
6091:             .Height        = 23
6092:             .FontName      = "Tahoma"
6093:             .FontSize      = 8
6094:             .ReadOnly      = .T.
6095:             .Value         = ""
6096:             .SpecialEffect = 1
6097:             .Visible       = .T.
6098:         ENDWITH
6099: 
6100:         *----------------------------------------------------------------------
6101:         *-- Preco Venda + Auditoria linha 1 (T:397)
6102:         *-- Say4: "Valor de Venda :" (T:400 L:505 W:120)
6103:         *----------------------------------------------------------------------
6104:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
6105:         WITH loc_oPg.lbl_4c_LblPvenda
6106:             .Caption   = "Valor de Venda :"
6107:             .Top       = 400
6108:             .Left      = 505
6109:             .Width     = 120
6110:             .Height    = 15
6111:             .FontName  = "Tahoma"
6112:             .FontSize  = 8
6113:             .BackStyle = 0
6114:             .ForeColor = RGB(90, 90, 90)
6115:             .Visible   = .T.
6116:         ENDWITH
6117: 
6118:         *-- getPvenda -> txt_4c_Pvenda (T:397 L:626 W:127 H:21) - pvens (display)
6119:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
6120:         WITH loc_oPg.txt_4c_Pvenda
6121:             .Top           = 397
6122:             .Left          = 626
6123:             .Width         = 127

*-- Linhas 6651 a 6694:
6651:     *--------------------------------------------------------------------------
6652:     * PreencherDescricoesPgDadosP2 - Busca descricoes de unidades (readonly)
6653:     *--------------------------------------------------------------------------
6654:     PROCEDURE PreencherDescricoesPgDadosP2()
6655:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
6656:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6657: 
6658:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6659:             RETURN
6660:         ENDIF
6661:         IF VARTYPE(loc_oPg.txt_4c_Cuni) # "O"
6662:             RETURN
6663:         ENDIF
6664: 
6665:         TRY
6666:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6667:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6668:             IF !EMPTY(loc_cCod)
6669:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6670:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6671:                     "cursor_4c_TmpUni")
6672:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6673:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6674:                 ENDIF
6675:                 IF USED("cursor_4c_TmpUni")
6676:                     USE IN cursor_4c_TmpUni
6677:                 ENDIF
6678:             ENDIF
6679: 
6680:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6681:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6682:             IF !EMPTY(loc_cCod)
6683:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6684:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6685:                     "cursor_4c_TmpUnip")
6686:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6687:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6688:                 ENDIF
6689:                 IF USED("cursor_4c_TmpUnip")
6690:                     USE IN cursor_4c_TmpUnip
6691:                 ENDIF
6692:             ENDIF
6693: 
6694:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)

*-- Linhas 6757 a 7270:
6757: 
6758:     *==========================================================================
6759:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 6)
6760:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
6761:     *==========================================================================
6762: 
6763:     *--------------------------------------------------------------------------
6764:     * TxtCuni - F4 abre lookup de unidades; LostFocus valida codigo
6765:     *--------------------------------------------------------------------------
6766:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6767:         IF par_nKeyCode = 115 && F4
6768:             THIS.AbrirLookupUnidade1()
6769:         ENDIF
6770:     ENDPROC
6771: 
6772:     PROCEDURE TxtCuniLostFocus()
6773:         LOCAL loc_oPg, loc_cCuni, loc_nRet
6774:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6775:         loc_cCuni = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6776: 
6777:         IF EMPTY(loc_cCuni)
6778:             loc_oPg.txt_4c_DUni.Value = ""
6779:             RETURN
6780:         ENDIF
6781:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6782:             RETURN
6783:         ENDIF
6784: 
6785:         TRY
6786:             loc_nRet = SQLEXEC(gnConnHandle, ;
6787:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6788:                 "cursor_4c_TmpCuni")
6789:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6790:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6791:             ELSE
6792:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6793:                 loc_oPg.txt_4c_Cuni.Value = ""
6794:                 loc_oPg.txt_4c_DUni.Value = ""
6795:             ENDIF
6796:             IF USED("cursor_4c_TmpCuni")
6797:                 USE IN cursor_4c_TmpCuni
6798:             ENDIF
6799:         CATCH TO loc_oErro
6800:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6801:         ENDTRY
6802:     ENDPROC
6803: 
6804:     PROCEDURE AbrirLookupUnidade1()
6805:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6806:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6807:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6808: 
6809:         TRY
6810:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6811:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", loc_cAtual, ;
6812:                 "Buscar Unidade")
6813:             IF VARTYPE(loc_oBusca) = "O"
6814:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6815:                     IF USED("cursor_4c_BuscaUni")
6816:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6817:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6818:                     ENDIF
6819:                 ELSE
6820:                     IF !loc_oBusca.this_lAchouRegistro
6821:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6822:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6823:                     loc_oBusca.Show()
6824:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6825:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6826:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6827:                     ENDIF
6828:                     ENDIF
6829:                 ENDIF
6830:                 loc_oBusca.Release()
6831:             ENDIF
6832:             IF USED("cursor_4c_BuscaUni")
6833:                 USE IN cursor_4c_BuscaUni
6834:             ENDIF
6835:         CATCH TO loc_oErro
6836:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6837:         ENDTRY
6838:     ENDPROC
6839: 
6840:     *--------------------------------------------------------------------------
6841:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6842:     *--------------------------------------------------------------------------
6843:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6844:         IF par_nKeyCode = 115 && F4
6845:             THIS.AbrirLookupUnidade2()
6846:         ENDIF
6847:     ENDPROC
6848: 
6849:     PROCEDURE TxtCunipLostFocus()
6850:         LOCAL loc_oPg, loc_cCunip, loc_nRet
6851:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6852:         loc_cCunip = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6853: 
6854:         IF EMPTY(loc_cCunip)
6855:             loc_oPg.txt_4c_DUnip.Value = ""
6856:             RETURN
6857:         ENDIF
6858:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6859:             RETURN
6860:         ENDIF
6861: 
6862:         TRY
6863:             loc_nRet = SQLEXEC(gnConnHandle, ;
6864:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6865:                 "cursor_4c_TmpCunip")
6866:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6867:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6868:             ELSE
6869:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6870:                 loc_oPg.txt_4c_Cunip.Value = ""
6871:                 loc_oPg.txt_4c_DUnip.Value = ""
6872:             ENDIF
6873:             IF USED("cursor_4c_TmpCunip")
6874:                 USE IN cursor_4c_TmpCunip
6875:             ENDIF
6876:         CATCH TO loc_oErro
6877:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6878:         ENDTRY
6879:     ENDPROC
6880: 
6881:     PROCEDURE AbrirLookupUnidade2()
6882:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6883:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6884:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6885: 
6886:         TRY
6887:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6888:                 "SigCdUni", "cursor_4c_BuscaUnip", "cunis", loc_cAtual, ;
6889:                 "Buscar Unidade 2")
6890:             IF VARTYPE(loc_oBusca) = "O"
6891:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6892:                     IF USED("cursor_4c_BuscaUnip")
6893:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6894:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6895:                     ENDIF
6896:                 ELSE
6897:                     IF !loc_oBusca.this_lAchouRegistro
6898:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6899:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6900:                     loc_oBusca.Show()
6901:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6902:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6903:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6904:                     ENDIF
6905:                     ENDIF
6906:                 ENDIF
6907:                 loc_oBusca.Release()
6908:             ENDIF
6909:             IF USED("cursor_4c_BuscaUnip")
6910:                 USE IN cursor_4c_BuscaUnip
6911:             ENDIF
6912:         CATCH TO loc_oErro
6913:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6914:         ENDTRY
6915:     ENDPROC
6916: 
6917:     *--------------------------------------------------------------------------
6918:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6919:     *--------------------------------------------------------------------------
6920:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6921:         IF par_nKeyCode = 115 && F4
6922:             THIS.AbrirLookupModelo()
6923:         ENDIF
6924:     ENDPROC
6925: 
6926:     PROCEDURE TxtCodFinPLostFocus()
6927:         LOCAL loc_oPg, loc_cCod, loc_nRet
6928:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6929:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6930: 
6931:         IF EMPTY(loc_cCod)
6932:             loc_oPg.txt_4c_DFinP.Value = ""
6933:             RETURN
6934:         ENDIF
6935:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6936:             RETURN
6937:         ENDIF
6938: 
6939:         TRY
6940:             loc_nRet = SQLEXEC(gnConnHandle, ;
6941:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6942:                 "cursor_4c_TmpFinP")
6943:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6944:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6945:             ELSE
6946:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6947:                 loc_oPg.txt_4c_CodFinP.Value = ""
6948:                 loc_oPg.txt_4c_DFinP.Value   = ""
6949:             ENDIF
6950:             IF USED("cursor_4c_TmpFinP")
6951:                 USE IN cursor_4c_TmpFinP
6952:             ENDIF
6953:         CATCH TO loc_oErro
6954:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6955:         ENDTRY
6956:     ENDPROC
6957: 
6958:     PROCEDURE AbrirLookupModelo()
6959:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6960:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6961:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6962: 
6963:         TRY
6964:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6965:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", loc_cAtual, ;
6966:                 "Buscar Modelo")
6967:             IF VARTYPE(loc_oBusca) = "O"
6968:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6969:                     IF USED("cursor_4c_BuscaFinP")
6970:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6971:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6972:                     ENDIF
6973:                 ELSE
6974:                     IF !loc_oBusca.this_lAchouRegistro
6975:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6976:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6977:                     loc_oBusca.Show()
6978:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6979:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6980:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6981:                     ENDIF
6982:                     ENDIF
6983:                 ENDIF
6984:                 loc_oBusca.Release()
6985:             ENDIF
6986:             IF USED("cursor_4c_BuscaFinP")
6987:                 USE IN cursor_4c_BuscaFinP
6988:             ENDIF
6989:         CATCH TO loc_oErro
6990:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
6991:         ENDTRY
6992:     ENDPROC
6993: 
6994:     *--------------------------------------------------------------------------
6995:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
6996:     *--------------------------------------------------------------------------
6997:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6998:         IF par_nKeyCode = 115 && F4
6999:             THIS.AbrirLookupAcabamento()
7000:         ENDIF
7001:     ENDPROC
7002: 
7003:     PROCEDURE TxtCodAcbLostFocus()
7004:         LOCAL loc_oPg, loc_cCod, loc_nRet
7005:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7006:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7007: 
7008:         IF EMPTY(loc_cCod)
7009:             loc_oPg.txt_4c_DAcb.Value = ""
7010:             RETURN
7011:         ENDIF
7012:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7013:             RETURN
7014:         ENDIF
7015: 
7016:         TRY
7017:             loc_nRet = SQLEXEC(gnConnHandle, ;
7018:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7019:                 "cursor_4c_TmpAcb")
7020:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7021:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7022:             ELSE
7023:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7024:                 loc_oPg.txt_4c_CodAcb.Value = ""
7025:                 loc_oPg.txt_4c_DAcb.Value   = ""
7026:             ENDIF
7027:             IF USED("cursor_4c_TmpAcb")
7028:                 USE IN cursor_4c_TmpAcb
7029:             ENDIF
7030:         CATCH TO loc_oErro
7031:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7032:         ENDTRY
7033:     ENDPROC
7034: 
7035:     PROCEDURE AbrirLookupAcabamento()
7036:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7037:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7038:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7039: 
7040:         TRY
7041:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7042:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cAtual, ;
7043:                 "Buscar Acabamento")
7044:             IF VARTYPE(loc_oBusca) = "O"
7045:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7046:                     IF USED("cursor_4c_BuscaAcb")
7047:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7048:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7049:                     ENDIF
7050:                 ELSE
7051:                     IF !loc_oBusca.this_lAchouRegistro
7052:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7053:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7054:                     loc_oBusca.Show()
7055:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7056:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7057:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7058:                     ENDIF
7059:                     ENDIF
7060:                 ENDIF
7061:                 loc_oBusca.Release()
7062:             ENDIF
7063:             IF USED("cursor_4c_BuscaAcb")
7064:                 USE IN cursor_4c_BuscaAcb
7065:             ENDIF
7066:         CATCH TO loc_oErro
7067:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7068:         ENDTRY
7069:     ENDPROC
7070: 
7071:     *--------------------------------------------------------------------------
7072:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7073:     * SigCdCls: filtrado por cgrus do grupo de produto corrente
7074:     *--------------------------------------------------------------------------
7075:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7076:         IF par_nKeyCode = 115 && F4
7077:             THIS.AbrirLookupClassificacao()
7078:         ENDIF
7079:     ENDPROC
7080: 
7081:     PROCEDURE TxtClassLostFocus()
7082:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
7083:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7084:         loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7085:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7086: 
7087:         IF EMPTY(loc_cCod)
7088:             loc_oPg.txt_4c_DClass.Value = ""
7089:             RETURN
7090:         ENDIF
7091:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7092:             RETURN
7093:         ENDIF
7094: 
7095:         TRY
7096:             loc_nRet = SQLEXEC(gnConnHandle, ;
7097:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7098:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7099:                 "cursor_4c_TmpClass")
7100:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7101:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7102:             ELSE
7103:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7104:                 loc_oPg.txt_4c_Class.Value  = ""
7105:                 loc_oPg.txt_4c_DClass.Value = ""
7106:             ENDIF
7107:             IF USED("cursor_4c_TmpClass")
7108:                 USE IN cursor_4c_TmpClass
7109:             ENDIF
7110:         CATCH TO loc_oErro
7111:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7112:         ENDTRY
7113:     ENDPROC
7114: 
7115:     PROCEDURE AbrirLookupClassificacao()
7116:         LOCAL loc_oBusca, loc_oPg, loc_cAtual, loc_cCgru
7117:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7118:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7119:         loc_cCgru  = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7120: 
7121:         TRY
7122:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7123:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7124:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7125:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7126:             IF VARTYPE(loc_oBusca) = "O"
7127:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7128:                     IF USED("cursor_4c_BuscaClass")
7129:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7130:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7131:                     ENDIF
7132:                 ELSE
7133:                     IF !loc_oBusca.this_lAchouRegistro
7134:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7135:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7136:                     loc_oBusca.Show()
7137:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7138:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7139:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7140:                     ENDIF
7141:                     ENDIF
7142:                 ENDIF
7143:                 loc_oBusca.Release()
7144:             ENDIF
7145:             IF USED("cursor_4c_BuscaClass")
7146:                 USE IN cursor_4c_BuscaClass
7147:             ENDIF
7148:         CATCH TO loc_oErro
7149:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7150:         ENDTRY
7151:     ENDPROC
7152: 
7153:     *--------------------------------------------------------------------------
7154:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7155:     *--------------------------------------------------------------------------
7156:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7157:         IF par_nKeyCode = 115 && F4
7158:             THIS.AbrirLookupLocal()
7159:         ENDIF
7160:     ENDPROC
7161: 
7162:     PROCEDURE TxtLocalLostFocus()
7163:         LOCAL loc_oPg, loc_cCod, loc_nRet
7164:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7165:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7166: 
7167:         IF EMPTY(loc_cCod)
7168:             RETURN
7169:         ENDIF
7170:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7171:             RETURN
7172:         ENDIF
7173: 
7174:         TRY
7175:             loc_nRet = SQLEXEC(gnConnHandle, ;
7176:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7177:                 "cursor_4c_TmpLocal")
7178:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7179:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7180:                 loc_oPg.txt_4c_Local.Value = ""
7181:             ENDIF
7182:             IF USED("cursor_4c_TmpLocal")
7183:                 USE IN cursor_4c_TmpLocal
7184:             ENDIF
7185:         CATCH TO loc_oErro
7186:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7187:         ENDTRY
7188:     ENDPROC
7189: 
7190:     PROCEDURE AbrirLookupLocal()
7191:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7192:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7193:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7194: 
7195:         TRY
7196:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7197:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cAtual, ;
7198:                 "Buscar Local")
7199:             IF VARTYPE(loc_oBusca) = "O"
7200:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7201:                     IF USED("cursor_4c_BuscaLocal")
7202:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7203:                     ENDIF
7204:                 ELSE
7205:                     IF !loc_oBusca.this_lAchouRegistro
7206:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7207:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7208:                     loc_oBusca.Show()
7209:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7210:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7211:                     ENDIF
7212:                     ENDIF
7213:                 ENDIF
7214:                 loc_oBusca.Release()
7215:             ENDIF
7216:             IF USED("cursor_4c_BuscaLocal")
7217:                 USE IN cursor_4c_BuscaLocal
7218:             ENDIF
7219:         CATCH TO loc_oErro
7220:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7221:         ENDTRY
7222:     ENDPROC
7223: 
7224:     *==========================================================================
7225:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7226:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7227:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7228:     * Controles: GrdCons(9 cols), Getqtcpnt, Say7, chkFund, Say1, grDTEMP(2 cols)
7229:     *==========================================================================
7230:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
7231:         LOCAL loc_oPg, loc_oGrd
7232: 
7233:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7234: 
7235:         *----------------------------------------------------------------------
7236:         *-- Cursor placeholder para GrdCons (SigPrCpo + SigCdPrf + SigCdCat)
7237:         *-- Campos: mats(comp), qtds(qtde), unicompos(uni), Grupos(fase code),
7238:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7239:         *----------------------------------------------------------------------
7240:         IF !USED("cursor_4c_GrdCons")
7241:             SET NULL ON
7242:             CREATE CURSOR cursor_4c_GrdCons (;
7243:                 mats      C(14), ;
7244:                 qtds      N(12,4), ;
7245:                 unicompos C(5), ;
7246:                 Grupos    C(3), ;
7247:                 Descrs    C(65), ;
7248:                 Ordems    N(5,0), ;
7249:                 consumo   N(12,4), ;
7250:                 Cods      C(5), ;
7251:                 dcats     C(65), ;
7252:                 Dopes     C(5))
7253:             SET NULL OFF
7254:         ENDIF
7255: 
7256:         *----------------------------------------------------------------------
7257:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7258:         *----------------------------------------------------------------------
7259:         IF !USED("cursor_4c_GrDTEMP")
7260:             SET NULL ON
7261:             CREATE CURSOR cursor_4c_GrDTEMP (;
7262:                 agrup C(30), ;
7263:                 tempo N(12,4))
7264:             SET NULL OFF
7265:         ENDIF
7266: 
7267:         *----------------------------------------------------------------------
7268:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7269:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7270:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao

*-- Linhas 7367 a 7414:
7367:             .Column9.ReadOnly        = .F.
7368:         ENDWITH
7369: 
7370:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7371:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7372:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7373:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7374:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7375: 
7376:         *----------------------------------------------------------------------
7377:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7378:         *----------------------------------------------------------------------
7379:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7380:         WITH loc_oPg.lbl_4c_Label7
7381:             .Caption   = "Qtde Componentes : "
7382:             .Top       = 523
7383:             .Left      = 25
7384:             .Width     = 105
7385:             .Height    = 15
7386:             .FontName  = "Tahoma"
7387:             .FontSize  = 8
7388:             .BackStyle = 0
7389:             .ForeColor = RGB(90, 90, 90)
7390:             .Visible   = .T.
7391:         ENDWITH
7392: 
7393:         *----------------------------------------------------------------------
7394:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)
7395:         *-- Legado When: Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
7396:         *-- Habilitado somente em modo edicao (via HabilitarCampos/DesabilitarCampos)
7397:         *----------------------------------------------------------------------
7398:         loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
7399:         WITH loc_oPg.txt_4c_Qtcpnt
7400:             .Top           = 519
7401:             .Left          = 131
7402:             .Width         = 31
7403:             .Height        = 23
7404:             .FontName      = "Tahoma"
7405:             .FontSize      = 8
7406:             .Value         = 0
7407:             .SpecialEffect = 1
7408:             .ForeColor     = RGB(36, 84, 155)
7409:             .Enabled       = .F.
7410:             .Visible       = .T.
7411:         ENDWITH
7412: 
7413:         *----------------------------------------------------------------------
7414:         *-- CheckBox chkFund (T:544 L:10 W:182 H:15)

*-- Linhas 7505 a 7767:
7505: 
7506:     *==========================================================================
7507:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7508:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7509:     *==========================================================================
7510: 
7511:     *--------------------------------------------------------------------------
7512:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7513:     *--------------------------------------------------------------------------
7514:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7515:         TRY
7516:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7517:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7518:             ENDIF
7519:         CATCH TO loc_oErro
7520:             *-- silencioso: refresh de navegacao nao deve bloquear
7521:         ENDTRY
7522:     ENDPROC
7523: 
7524:     *--------------------------------------------------------------------------
7525:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7526:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7527:     *--------------------------------------------------------------------------
7528:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7529:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7530:         IF par_nKeyCode = 115  && F4
7531:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7532:                 RETURN
7533:             ENDIF
7534:             TRY
7535:                 loc_cAtual = ""
7536:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7537:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7538:                 ENDIF
7539:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7540:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7541:                     "Buscar Fase")
7542:                 IF VARTYPE(loc_oBusca) = "O"
7543:                     IF !loc_oBusca.this_lAchouRegistro
7544:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7545:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7546:                         loc_oBusca.Show()
7547:                     ENDIF
7548:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7549:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7550:                             SELECT cursor_4c_GrdCons
7551:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7552:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7553:                         ENDIF
7554:                     ENDIF
7555:                     loc_oBusca.Release()
7556:                 ENDIF
7557:                 IF USED("cursor_4c_BuscaPrf")
7558:                     USE IN cursor_4c_BuscaPrf
7559:                 ENDIF
7560:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7561:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7562:                 ENDIF
7563:             CATCH TO loc_oErro
7564:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7565:             ENDTRY
7566:         ENDIF
7567:     ENDPROC
7568: 
7569:     *--------------------------------------------------------------------------
7570:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7571:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7572:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7573:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7574:     *--------------------------------------------------------------------------
7575:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7576:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7577:         IF par_nKeyCode = 115  && F4
7578:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7579:                 RETURN
7580:             ENDIF
7581:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7582:             loc_cGrupos = ""
7583:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7584:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7585:             ENDIF
7586:             IF !EMPTY(loc_cGrupos)
7587:                 RETURN
7588:             ENDIF
7589:             TRY
7590:                 loc_cAtual = ""
7591:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7592:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7593:                 ENDIF
7594:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7595:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7596:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7597:                 IF VARTYPE(loc_oBusca) = "O"
7598:                     IF !loc_oBusca.this_lAchouRegistro
7599:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7600:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7601:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7602:                         loc_oBusca.Show()
7603:                     ENDIF
7604:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7605:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7606:                             SELECT cursor_4c_GrdCons
7607:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7608:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7609:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7610:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7611:                             ENDIF
7612:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7613:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7614:                             ENDIF
7615:                         ENDIF
7616:                     ENDIF
7617:                     loc_oBusca.Release()
7618:                 ENDIF
7619:                 IF USED("cursor_4c_BuscaPrf2")
7620:                     USE IN cursor_4c_BuscaPrf2
7621:                 ENDIF
7622:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7623:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7624:                 ENDIF
7625:             CATCH TO loc_oErro
7626:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7627:             ENDTRY
7628:         ENDIF
7629:     ENDPROC
7630: 
7631:     *--------------------------------------------------------------------------
7632:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7633:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7634:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7635:     *--------------------------------------------------------------------------
7636:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7637:         LOCAL loc_oBusca, loc_cAtual
7638:         IF par_nKeyCode = 115  && F4
7639:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7640:                 RETURN
7641:             ENDIF
7642:             TRY
7643:                 loc_cAtual = ""
7644:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7645:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7646:                 ENDIF
7647:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7648:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7649:                     "Buscar Categoria")
7650:                 IF VARTYPE(loc_oBusca) = "O"
7651:                     IF !loc_oBusca.this_lAchouRegistro
7652:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7653:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7654:                         loc_oBusca.Show()
7655:                     ENDIF
7656:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7657:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7658:                             SELECT cursor_4c_GrdCons
7659:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7660:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7661:                         ENDIF
7662:                     ENDIF
7663:                     loc_oBusca.Release()
7664:                 ENDIF
7665:                 IF USED("cursor_4c_BuscaCat")
7666:                     USE IN cursor_4c_BuscaCat
7667:                 ENDIF
7668:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7669:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7670:                 ENDIF
7671:             CATCH TO loc_oErro
7672:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7673:             ENDTRY
7674:         ENDIF
7675:     ENDPROC
7676: 
7677:     *==========================================================================
7678:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7679:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7680:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7681:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7682:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7683:     *==========================================================================
7684:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7685:         LOCAL loc_oPg, loc_oGrd
7686: 
7687:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7688: 
7689:         *----------------------------------------------------------------------
7690:         *-- Cursors cursor_4c_Compo e cursor_4c_Grupo sao compartilhados
7691:         *-- com pgComposicao (criados em ConfigurarPgpgComposicao).
7692:         *-- Nao recriar - usar os ja existentes.
7693:         *----------------------------------------------------------------------
7694: 
7695:         *----------------------------------------------------------------------
7696:         *-- Tipo: lbl_4c_Label1 + cbo_4c_CmbTipos
7697:         *-- Say1: "Tipo :" T:159 L:112 W:29
7698:         *-- cmbTipos: T:154 L:143 W:187 H:23
7699:         *----------------------------------------------------------------------
7700:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
7701:         WITH loc_oPg.lbl_4c_Label1
7702:             .Caption   = "Tipo :"
7703:             .Top       = 159
7704:             .Left      = 112
7705:             .Width     = 29
7706:             .Height    = 15
7707:             .FontName  = "Tahoma"
7708:             .FontSize  = 8
7709:             .BackStyle = 0
7710:             .ForeColor = RGB(90, 90, 90)
7711:             .Visible   = .T.
7712:         ENDWITH
7713: 
7714:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
7715:         WITH loc_oPg.cbo_4c_CmbTipos
7716:             .Top           = 154
7717:             .Left          = 143
7718:             .Width         = 187
7719:             .Height        = 23
7720:             .FontName      = "Tahoma"
7721:             .FontSize      = 8
7722:             .RowSourceType = 0
7723:             .Value         = ""
7724:             .SpecialEffect = 1
7725:             .Visible       = .T.
7726:         ENDWITH
7727:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
7728: 
7729:         *----------------------------------------------------------------------
7730:         *-- Grid grdCompo (12 colunas) - Composicao de custo
7731:         *-- T:178 L:34 W:813 H:230 - usa cursor_4c_Compo (compartilhado)
7732:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7733:         *--          Observacao, Etiq, Consumo, Qtd, Un
7734:         *----------------------------------------------------------------------
7735:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7736:         WITH loc_oPg.grd_4c_CustoCompo
7737:             .Top               = 178
7738:             .Left              = 34
7739:             .Width             = 813
7740:             .Height            = 230
7741:             .ColumnCount       = 12
7742:             .FontName          = "Verdana"
7743:             .FontSize          = 8
7744:             .GridLines         = 3
7745:             .GridLineWidth     = 1
7746:             .GridLineColor     = RGB(238, 238, 238)
7747:             .RecordMark        = .F.
7748:             .DeleteMark        = .F.
7749:             .AllowRowSizing    = .F.
7750:             .ReadOnly          = .F.
7751:             .BackColor         = RGB(255, 255, 255)
7752:             .ForeColor         = RGB(90, 90, 90)
7753:             .HighlightBackColor = RGB(220, 230, 242)
7754:             .HighlightForeColor = RGB(15, 41, 104)
7755:             .HighlightStyle    = 2
7756:             .RowHeight         = 16
7757:             .ScrollBars        = 2
7758:             .Visible           = .T.
7759:         ENDWITH
7760: 
7761:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7762:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7763: 
7764:         *-- Configurar colunas APOS RecordSource
7765:         WITH loc_oPg.grd_4c_CustoCompo
7766:             *-- Col1: Item/Material (C14) W:80
7767:             .Column1.Header1.Caption   = "Item"

*-- Linhas 7834 a 7931:
7834:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7835:             .Column12.ReadOnly         = .T.
7836:         ENDWITH
7837:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7838: 
7839:         *----------------------------------------------------------------------
7840:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7841:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7842:         *----------------------------------------------------------------------
7843:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7844:         WITH loc_oPg.cnt_4c_BotoesCusto
7845:             .Top         = 240
7846:             .Left        = 851
7847:             .Width       = 50
7848:             .Height      = 90
7849:             .BackStyle = 1
7850:             .BackColor = RGB(53, 53, 53)
7851:             .BorderWidth = 0
7852:             .Visible     = .T.
7853:         ENDWITH
7854: 
7855:         *-- Botao 1: Inserir componente de custo
7856:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7857:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto
7858:             .Caption       = "+"
7859:             .Top           = 0
7860:             .Left          = 0
7861:             .Width         = 50
7862:             .Height        = 45
7863:             .FontName      = "Tahoma"
7864:             .FontSize      = 10
7865:             .FontBold      = .T.
7866:             .Themes        = .F.
7867:             .SpecialEffect = 0
7868:             .BackColor     = RGB(255, 255, 255)
7869:             .ForeColor     = RGB(0, 128, 0)
7870:             .Visible       = .T.
7871:         ENDWITH
7872:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto, "Click", THIS, "CmdInserirCustoClick")
7873: 
7874:         *-- Botao 2: Excluir componente de custo
7875:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_ExcluirCusto", "CommandButton")
7876:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto
7877:             .Caption       = "-"
7878:             .Top           = 45
7879:             .Left          = 0
7880:             .Width         = 50
7881:             .Height        = 45
7882:             .FontName      = "Tahoma"
7883:             .FontSize      = 10
7884:             .FontBold      = .T.
7885:             .Themes        = .F.
7886:             .SpecialEffect = 0
7887:             .BackColor     = RGB(255, 255, 255)
7888:             .ForeColor     = RGB(192, 0, 0)
7889:             .Visible       = .T.
7890:         ENDWITH
7891:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto, "Click", THIS, "CmdExcluirCustoClick")
7892: 
7893:         *----------------------------------------------------------------------
7894:         *-- Linha Descricao / Grupo (abaixo do grid e botoes)
7895:         *-- Say16: "Descricao :" T:415 L:52 W:55
7896:         *-- Get_Desc: T:412 L:116 W:304 H:21 - readonly (When=.F.)
7897:         *-- Say2: "Grupo :" T:415 L:479 W:38
7898:         *-- getDGruCompos: T:412 L:522 W:304 H:21 - readonly (When=.F.)
7899:         *----------------------------------------------------------------------
7900:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
7901:         WITH loc_oPg.lbl_4c_Label16
7902:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
7903:             .Top       = 415
7904:             .Left      = 52
7905:             .Width     = 55
7906:             .Height    = 15
7907:             .FontName  = "Tahoma"
7908:             .FontSize  = 8
7909:             .BackStyle = 0
7910:             .ForeColor = RGB(90, 90, 90)
7911:             .Visible   = .T.
7912:         ENDWITH
7913: 
7914:         loc_oPg.AddObject("txt_4c_CustoDesc", "TextBox")
7915:         WITH loc_oPg.txt_4c_CustoDesc
7916:             .Top           = 412
7917:             .Left          = 116
7918:             .Width         = 304
7919:             .Height        = 21
7920:             .FontName      = "Tahoma"
7921:             .FontSize      = 8
7922:             .MaxLength     = 65
7923:             .Value         = ""
7924:             .SpecialEffect = 1
7925:             .Enabled       = .F.
7926:             .Visible       = .T.
7927:         ENDWITH
7928: 
7929:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
7930:         WITH loc_oPg.lbl_4c_Label2
7931:             .Caption   = "Grupo :"

*-- Linhas 8044 a 8219:
8044:     *--------------------------------------------------------------------------
8045:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8046:     *--------------------------------------------------------------------------
8047:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8048:         LOCAL loc_oPg, loc_nRet
8049:         TRY
8050:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8051:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8052:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8053:                 *-- Buscar descricao do grupo
8054:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8055:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8056:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8057:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8058:                         "cursor_4c_TmpGrpCusto")
8059:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8060:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8061:                     ELSE
8062:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8063:                     ENDIF
8064:                     IF USED("cursor_4c_TmpGrpCusto")
8065:                         USE IN cursor_4c_TmpGrpCusto
8066:                     ENDIF
8067:                 ELSE
8068:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8069:                 ENDIF
8070:             ENDIF
8071:         CATCH TO loc_oErro
8072:             *-- silencioso: refresh de display nao deve bloquear navegacao
8073:         ENDTRY
8074:     ENDPROC
8075: 
8076:     *--------------------------------------------------------------------------
8077:     * CboTiposCustoInteractiveChange - Filtra composicao pelo tipo selecionado
8078:     *--------------------------------------------------------------------------
8079:     PROCEDURE CboTiposCustoInteractiveChange()
8080:         LOCAL loc_oPg
8081:         TRY
8082:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8083:             IF USED("cursor_4c_Compo")
8084:                 GO TOP IN cursor_4c_Compo
8085:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8086:             ENDIF
8087:         CATCH TO loc_oErro
8088:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8089:         ENDTRY
8090:     ENDPROC
8091: 
8092:     *--------------------------------------------------------------------------
8093:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8094:     *--------------------------------------------------------------------------
8095:     PROCEDURE CmdInserirCustoClick()
8096:         LOCAL loc_oPg, loc_cTipo
8097:         TRY
8098:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8099:                 RETURN
8100:             ENDIF
8101:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8102:             loc_cTipo = ""
8103:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8104:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8105:             ENDIF
8106:             IF USED("cursor_4c_Compo")
8107:                 SELECT cursor_4c_Compo
8108:                 GO TOP IN cursor_4c_Compo
8109:                 LOCATE FOR EMPTY(mats)
8110:                 IF EOF("cursor_4c_Compo")
8111:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8112:                 ENDIF
8113:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8114:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8115:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8116:                 ENDIF
8117:             ENDIF
8118:         CATCH TO loc_oErro
8119:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8120:         ENDTRY
8121:     ENDPROC
8122: 
8123:     *--------------------------------------------------------------------------
8124:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8125:     *--------------------------------------------------------------------------
8126:     PROCEDURE CmdExcluirCustoClick()
8127:         LOCAL loc_oPg
8128:         TRY
8129:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8130:                 RETURN
8131:             ENDIF
8132:             IF USED("cursor_4c_Compo")
8133:                 SELECT cursor_4c_Compo
8134:                 IF !EOF("cursor_4c_Compo")
8135:                     DELETE
8136:                     IF !EOF("cursor_4c_Compo")
8137:                         SKIP
8138:                         SKIP -1
8139:                     ENDIF
8140:                     GO BOTTOM IN cursor_4c_Compo
8141:                 ENDIF
8142:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8143:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8144:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8145:             ENDIF
8146:         CATCH TO loc_oErro
8147:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8148:         ENDTRY
8149:     ENDPROC
8150: 
8151:     *--------------------------------------------------------------------------
8152:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8153:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8154:     *--------------------------------------------------------------------------
8155:     PROCEDURE AjustarBotoesPorModo()
8156:         LOCAL loc_oPg2, loc_lEditando
8157:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8158: 
8159:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8160:             RETURN
8161:         ENDIF
8162: 
8163:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8164: 
8165:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
8166:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar) = "O"
8167:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEditando
8168:             ENDIF
8169:         ENDIF
8170:     ENDPROC
8171: 
8172:     *==========================================================================
8173:     * FASE 12 - Aba Fases de Producao (PgDadosFaseP - Page4 do pgf_4c_Dados)
8174:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
8175:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8176:     * Controles: 2 grids (GradFase 5col + grdMatrizes 3col), 8 textboxes,
8177:     *            2 checkboxes, 1 editbox, labels, shapes, images, 8 commandbuttons
8178:     *==========================================================================
8179:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
8180:         LOCAL loc_oPg, loc_oGrd
8181:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8182: 
8183:         *----------------------------------------------------------------------
8184:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8185:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8186:         *----------------------------------------------------------------------
8187:         IF !USED("cursor_4c_GradFase")
8188:             SET NULL ON
8189:             CREATE CURSOR cursor_4c_GradFase (;
8190:                 Ordems   N(5,0), ;
8191:                 Grupos   C(10), ;
8192:                 Descrs   C(65), ;
8193:                 UniPrdts C(10), ;
8194:                 MatPrdts C(15), ;
8195:                 Obs      M, ;
8196:                 FigProcs M)
8197:             SET NULL OFF
8198:         ENDIF
8199: 
8200:         *----------------------------------------------------------------------
8201:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8202:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8203:         *----------------------------------------------------------------------
8204:         IF !USED("cursor_4c_SigPrMtz")
8205:             SET NULL ON
8206:             CREATE CURSOR cursor_4c_SigPrMtz (;
8207:                 CMats C(14), ;
8208:                 DLocs C(40), ;
8209:                 Qtds  N(3,0))
8210:             SET NULL OFF
8211:         ENDIF
8212: 
8213:         *----------------------------------------------------------------------
8214:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8215:         *----------------------------------------------------------------------
8216:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8217:         WITH loc_oPg.shp_4c_ShpFig
8218:             .Top         = 152
8219:             .Left        = 231

*-- Linhas 8240 a 8283:
8240:             .Stretch = 2
8241:             .Visible = .F.
8242:         ENDWITH
8243:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
8244: 
8245:         *----------------------------------------------------------------------
8246:         *-- Grid GradFase (T:152 L:527 W:420 H:312) - 5 colunas fases de producao
8247:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8248:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8249:         *----------------------------------------------------------------------
8250:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8251:         loc_oGrd = loc_oPg.grd_4c_GradFase
8252: 
8253:         WITH loc_oGrd
8254:             .Top                = 152
8255:             .Left               = 527
8256:             .Width              = 420
8257:             .Height             = 312
8258:             .FontName           = "Tahoma"
8259:             .FontSize           = 8
8260:             .ColumnCount        = 5
8261:             .GridLines          = 3
8262:             .GridLineWidth      = 1
8263:             .GridLineColor      = RGB(238, 238, 238)
8264:             .RecordMark         = .F.
8265:             .DeleteMark         = .F.
8266:             .AllowRowSizing     = .F.
8267:             .ReadOnly           = .F.
8268:             .BackColor          = RGB(255, 255, 255)
8269:             .ForeColor          = RGB(90, 90, 90)
8270:             .HighlightBackColor = RGB(220, 230, 242)
8271:             .HighlightForeColor = RGB(15, 41, 104)
8272:             .HighlightStyle     = 2
8273:             .RowHeight          = 16
8274:             .ScrollBars         = 2
8275:             .Themes             = .F.
8276:             .Visible            = .T.
8277:         ENDWITH
8278: 
8279:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8280:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8281: 
8282:         *-- Configurar colunas APOS RecordSource
8283:         WITH loc_oPg.grd_4c_GradFase

*-- Linhas 8317 a 8494:
8317:             .Column5.ReadOnly        = .F.
8318:         ENDWITH
8319: 
8320:         *-- BINDEVENT: GradFase
8321:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8322:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8323:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8324:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8325:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8326:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8327: 
8328:         *----------------------------------------------------------------------
8329:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8330:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8331:         *----------------------------------------------------------------------
8332:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8333:         WITH loc_oPg.cmd_4c_IncluirFase
8334:             .Caption       = "+"
8335:             .Top           = 152
8336:             .Left          = 950
8337:             .Width         = 38
8338:             .Height        = 38
8339:             .FontName      = "Tahoma"
8340:             .FontSize      = 10
8341:             .FontBold      = .T.
8342:             .Themes        = .F.
8343:             .SpecialEffect = 0
8344:             .BackColor     = RGB(255, 255, 255)
8345:             .ForeColor     = RGB(0, 128, 0)
8346:             .Visible       = .T.
8347:         ENDWITH
8348:         BINDEVENT(loc_oPg.cmd_4c_IncluirFase, "Click", THIS, "CmdIncluirFaseClick")
8349: 
8350:         *----------------------------------------------------------------------
8351:         *-- Botao Excluir Fase (excluir: T:192 L:950 W:38 H:38)
8352:         *-- Legado: excluir.Click - exclui linha corrente e resequencia
8353:         *----------------------------------------------------------------------
8354:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
8355:         WITH loc_oPg.cmd_4c_ExcluirFase
8356:             .Caption       = "-"
8357:             .Top           = 192
8358:             .Left          = 950
8359:             .Width         = 38
8360:             .Height        = 38
8361:             .FontName      = "Tahoma"
8362:             .FontSize      = 10
8363:             .FontBold      = .T.
8364:             .Themes        = .F.
8365:             .SpecialEffect = 0
8366:             .BackColor     = RGB(255, 255, 255)
8367:             .ForeColor     = RGB(192, 0, 0)
8368:             .Visible       = .T.
8369:         ENDWITH
8370:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "CmdExcluirFaseClick")
8371: 
8372:         *----------------------------------------------------------------------
8373:         *-- Botao Alternativa (Alternativa: T:232 L:950 W:38 H:38)
8374:         *-- Legado: Alternativa.Click - copia linha corrente como alternativa
8375:         *----------------------------------------------------------------------
8376:         loc_oPg.AddObject("cmd_4c_AlternativaFase", "CommandButton")
8377:         WITH loc_oPg.cmd_4c_AlternativaFase
8378:             .Caption       = "A"
8379:             .Top           = 232
8380:             .Left          = 950
8381:             .Width         = 38
8382:             .Height        = 38
8383:             .FontName      = "Tahoma"
8384:             .FontSize      = 9
8385:             .Themes        = .F.
8386:             .SpecialEffect = 0
8387:             .BackColor     = RGB(255, 255, 255)
8388:             .ForeColor     = RGB(90, 90, 90)
8389:             .Visible       = .T.
8390:         ENDWITH
8391:         BINDEVENT(loc_oPg.cmd_4c_AlternativaFase, "Click", THIS, "CmdAlternativaFaseClick")
8392: 
8393:         *----------------------------------------------------------------------
8394:         *-- Botao Ficha Tecnica (CmdFicha: T:152 L:482 W:38 H:38)
8395:         *-- Legado: CmdFicha.Click - gera ficha tecnica com REPORT FORM
8396:         *----------------------------------------------------------------------
8397:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
8398:         WITH loc_oPg.cmd_4c_CmdFicha
8399:             .Caption       = "F"
8400:             .Top           = 152
8401:             .Left          = 482
8402:             .Width         = 38
8403:             .Height        = 38
8404:             .FontName      = "Tahoma"
8405:             .FontSize      = 9
8406:             .Themes        = .F.
8407:             .SpecialEffect = 0
8408:             .BackColor     = RGB(255, 255, 255)
8409:             .ForeColor     = RGB(90, 90, 90)
8410:             .Visible       = .T.
8411:         ENDWITH
8412:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
8413: 
8414:         *----------------------------------------------------------------------
8415:         *-- Botao Selecionar Imagem (cmdgFigura: T:192 L:482 W:40 H:40)
8416:         *-- Legado: cmdgFigura.Click - abre seletor GetPict JPG/BMP
8417:         *----------------------------------------------------------------------
8418:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
8419:         WITH loc_oPg.cmd_4c_CmdgFigura
8420:             .Caption       = "I"
8421:             .Top           = 192
8422:             .Left          = 482
8423:             .Width         = 40
8424:             .Height        = 40
8425:             .FontName      = "Tahoma"
8426:             .FontSize      = 9
8427:             .Themes        = .F.
8428:             .SpecialEffect = 0
8429:             .BackColor     = RGB(255, 255, 255)
8430:             .ForeColor     = RGB(90, 90, 90)
8431:             .Visible       = .T.
8432:         ENDWITH
8433:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
8434: 
8435:         *----------------------------------------------------------------------
8436:         *-- Botao Capturar Webcam (cmdgFigCam: T:232 L:482 W:40 H:40)
8437:         *-- Legado: cmdgFigCam.Click - captura imagem via SigImage form
8438:         *----------------------------------------------------------------------
8439:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
8440:         WITH loc_oPg.cmd_4c_CmdgFigCam
8441:             .Caption       = "C"
8442:             .Top           = 232
8443:             .Left          = 482
8444:             .Width         = 40
8445:             .Height        = 40
8446:             .FontName      = "Tahoma"
8447:             .FontSize      = 9
8448:             .Themes        = .F.
8449:             .SpecialEffect = 0
8450:             .BackColor     = RGB(255, 255, 255)
8451:             .ForeColor     = RGB(90, 90, 90)
8452:             .Visible       = .T.
8453:         ENDWITH
8454:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
8455: 
8456:         *----------------------------------------------------------------------
8457:         *-- Label Say1: "Descricao :" (T:474 L:527 W:67 H:17)
8458:         *----------------------------------------------------------------------
8459:         loc_oPg.AddObject("lbl_4c_Label1FP", "Label")
8460:         WITH loc_oPg.lbl_4c_Label1FP
8461:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
8462:             .Top       = 474
8463:             .Left      = 527
8464:             .Width     = 67
8465:             .Height    = 17
8466:             .FontName  = "Tahoma"
8467:             .FontSize  = 8
8468:             .BackStyle = 0
8469:             .ForeColor = RGB(90, 90, 90)
8470:             .Visible   = .T.
8471:         ENDWITH
8472: 
8473:         *----------------------------------------------------------------------
8474:         *-- TextBox Get_Desc (T:471 L:595 W:395 H:23) - descricao da fase
8475:         *-- Readonly - preenchido pelo GradFaseAfterRowColChange (campo Descrs)
8476:         *----------------------------------------------------------------------
8477:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8478:         WITH loc_oPg.txt_4c_Desc
8479:             .Top           = 471
8480:             .Left          = 595
8481:             .Width         = 395
8482:             .Height        = 23
8483:             .Value         = ""
8484:             .FontName      = "Tahoma"
8485:             .FontSize      = 8
8486:             .ReadOnly      = .T.
8487:             .SpecialEffect = 1
8488:             .ForeColor     = RGB(36, 84, 155)
8489:             .BackColor     = RGB(240, 240, 240)
8490:             .Visible       = .T.
8491:         ENDWITH
8492: 
8493:         *----------------------------------------------------------------------
8494:         *-- EditBox Get_Obs (T:497 L:527 W:463 H:122) - observacoes da fase

*-- Linhas 8612 a 8655:
8612:             .Enabled       = .F.
8613:             .Visible       = .T.
8614:         ENDWITH
8615:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "TxtConquilhaLostFocus")
8616: 
8617:         *-- Label Say9: "Peso Brilhante :" (T:231 L:58 W:77 H:15)
8618:         loc_oPg.AddObject("lbl_4c_Label9FP", "Label")
8619:         WITH loc_oPg.lbl_4c_Label9FP
8620:             .Caption   = "Peso Brilhante :"
8621:             .Top       = 451
8622:             .Left      = 884
8623:             .Width     = 77
8624:             .Height    = 15
8625:             .FontName  = "Tahoma"
8626:             .FontSize  = 8
8627:             .BackStyle = 0
8628:             .ForeColor = RGB(90, 90, 90)
8629:             .Visible   = .T.
8630:         ENDWITH
8631: 
8632:         *-- TextBox getPesoBris (T:227 L:137 W:80 H:23)
8633:         *-- Legado: pesobris de SigCdPro
8634:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
8635:         WITH loc_oPg.txt_4c_PesoBris
8636:             .Top           = 227
8637:             .Left          = 137
8638:             .Width         = 80
8639:             .Height        = 23
8640:             .Value         = 0
8641:             .FontName      = "Tahoma"
8642:             .FontSize      = 8
8643:             .SpecialEffect = 1
8644:             .ForeColor     = RGB(36, 84, 155)
8645:             .Enabled       = .F.
8646:             .Visible       = .T.
8647:         ENDWITH
8648: 
8649:         *-- Label Say10: "Peso Metal :" (T:256 L:74 W:61 H:15)
8650:         loc_oPg.AddObject("lbl_4c_Label10FP", "Label")
8651:         WITH loc_oPg.lbl_4c_Label10FP
8652:             .Caption   = "Peso Metal :"
8653:             .Top       = 451
8654:             .Left      = 967
8655:             .Width     = 61

*-- Linhas 8741 a 8784:
8741:             .Enabled       = .F.
8742:             .Visible       = .T.
8743:         ENDWITH
8744:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "TxtCorLostFocus")
8745: 
8746:         *-- CheckBox opc_CravCera: "Cravacao em Cera" (T:306 L:180 W:120 H:15)
8747:         *-- Legado: cravcers de SigCdPro (numeric 1,0 com semantica booleana)
8748:         loc_oPg.AddObject("chk_4c_Opc_CravCera", "CheckBox")
8749:         WITH loc_oPg.chk_4c_Opc_CravCera
8750:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
8751:             .Top       = 306
8752:             .Left      = 180
8753:             .Width     = 120
8754:             .Height    = 15
8755:             .Value     = 0
8756:             .FontName  = "Tahoma"
8757:             .FontSize  = 8
8758:             .BackStyle = 0
8759:             .Themes    = .F.
8760:             .Enabled   = .F.
8761:             .Visible   = .T.
8762:         ENDWITH
8763: 
8764:         *-- Label Say2: "Tamanho Padrao :" (T:331 L:45 W:90 H:15)
8765:         loc_oPg.AddObject("lbl_4c_Label2FP", "Label")
8766:         WITH loc_oPg.lbl_4c_Label2FP
8767:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
8768:             .Top       = 331
8769:             .Left      = 45
8770:             .Width     = 90
8771:             .Height    = 15
8772:             .FontName  = "Tahoma"
8773:             .FontSize  = 8
8774:             .BackStyle = 0
8775:             .ForeColor = RGB(90, 90, 90)
8776:             .Visible   = .T.
8777:         ENDWITH
8778: 
8779:         *-- TextBox getTam: tamanho padrao (T:327 L:137 W:38 H:23)
8780:         *-- Legado: codtams de SigCdPro - LostFocus lookup SigCdTam
8781:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
8782:         WITH loc_oPg.txt_4c_Tam
8783:             .Top           = 327
8784:             .Left          = 137

*-- Linhas 8792 a 8835:
8792:             .Enabled       = .F.
8793:             .Visible       = .T.
8794:         ENDWITH
8795:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "TxtTamLostFocus")
8796: 
8797:         *-- CheckBox fwoption1: "Peso Variavel" (T:331 L:180 W:90 H:15)
8798:         *-- Legado: prodvars de SigCdPro (numeric 1,0 com semantica booleana)
8799:         loc_oPg.AddObject("chk_4c_Fwoption1", "CheckBox")
8800:         WITH loc_oPg.chk_4c_Fwoption1
8801:             .Caption   = "Peso Vari" + CHR(225) + "vel"
8802:             .Top       = 331
8803:             .Left      = 180
8804:             .Width     = 90
8805:             .Height    = 15
8806:             .Value     = 0
8807:             .FontName  = "Tahoma"
8808:             .FontSize  = 8
8809:             .BackStyle = 0
8810:             .Themes    = .F.
8811:             .Enabled   = .F.
8812:             .Visible   = .T.
8813:         ENDWITH
8814: 
8815:         *-- Label lblAcabamento: "Acabamento :" (T:356 L:16 W:119 H:15)
8816:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
8817:         WITH loc_oPg.lbl_4c_LblAcabamento
8818:             .Caption   = "Acabamento :"
8819:             .Top       = 356
8820:             .Left      = 16
8821:             .Width     = 119
8822:             .Height    = 15
8823:             .FontName  = "Tahoma"
8824:             .FontSize  = 8
8825:             .BackStyle = 0
8826:             .ForeColor = RGB(90, 90, 90)
8827:             .Visible   = .T.
8828:         ENDWITH
8829: 
8830:         *-- TextBox get_codacb: codigo acabamento (T:352 L:137 W:38 H:23)
8831:         *-- Legado: codacbs de SigCdPro - LostFocus lookup SigCdAca
8832:         loc_oPg.AddObject("txt_4c__codacb", "TextBox")
8833:         WITH loc_oPg.txt_4c__codacb
8834:             .Top           = 352
8835:             .Left          = 137

*-- Linhas 8843 a 8886:
8843:             .Enabled       = .F.
8844:             .Visible       = .T.
8845:         ENDWITH
8846:         BINDEVENT(loc_oPg.txt_4c__codacb, "LostFocus", THIS, "TxtCodacbLostFocus")
8847: 
8848:         *-- TextBox get_Dacb: descricao acabamento (T:352 L:177 W:207 H:23)
8849:         *-- Legado: When=.F. (readonly sempre) - preenchido pelo lookup de get_codacb
8850:         loc_oPg.AddObject("txt_4c__Dacb", "TextBox")
8851:         WITH loc_oPg.txt_4c__Dacb
8852:             .Top           = 352
8853:             .Left          = 177
8854:             .Width         = 207
8855:             .Height        = 23
8856:             .Value         = ""
8857:             .FontName      = "Tahoma"
8858:             .FontSize      = 8
8859:             .ReadOnly      = .T.
8860:             .SpecialEffect = 1
8861:             .ForeColor     = RGB(36, 84, 155)
8862:             .BackColor     = RGB(240, 240, 240)
8863:             .Enabled       = .F.
8864:             .Visible       = .T.
8865:         ENDWITH
8866: 
8867:         *----------------------------------------------------------------------
8868:         *-- Secao inferior esquerda: grdMatrizes + botoes + imagem borracha
8869:         *----------------------------------------------------------------------
8870: 
8871:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8872:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8873:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8874:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8875: 
8876:         WITH loc_oGrd
8877:             .Top                = 380
8878:             .Left               = 7
8879:             .Width              = 246
8880:             .Height             = 240
8881:             .FontName           = "Tahoma"
8882:             .FontSize           = 8
8883:             .ColumnCount        = 3
8884:             .GridLines          = 3
8885:             .GridLineWidth      = 1
8886:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 8926 a 9053:
8926:             .Column3.ReadOnly        = .F.
8927:         ENDWITH
8928: 
8929:         *-- BINDEVENT: grdMatrizes
8930:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8931:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8932: 
8933:         *----------------------------------------------------------------------
8934:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8935:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8936:         *----------------------------------------------------------------------
8937:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8938:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8939:             .Caption       = "+"
8940:             .Top           = 380
8941:             .Left          = 258
8942:             .Width         = 38
8943:             .Height        = 38
8944:             .FontName      = "Tahoma"
8945:             .FontSize      = 10
8946:             .FontBold      = .T.
8947:             .Themes        = .F.
8948:             .SpecialEffect = 0
8949:             .BackColor     = RGB(255, 255, 255)
8950:             .ForeColor     = RGB(0, 128, 0)
8951:             .Visible       = .T.
8952:         ENDWITH
8953:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
8954: 
8955:         *----------------------------------------------------------------------
8956:         *-- Botao Excluir Matriz (btnExcluiMtz: T:420 L:258 W:38 H:38)
8957:         *-- Legado: btnExcluiMtz.Click - exclui linha de crSigPrMtz
8958:         *----------------------------------------------------------------------
8959:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
8960:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
8961:             .Caption       = "-"
8962:             .Top           = 420
8963:             .Left          = 258
8964:             .Width         = 38
8965:             .Height        = 38
8966:             .FontName      = "Tahoma"
8967:             .FontSize      = 10
8968:             .FontBold      = .T.
8969:             .Themes        = .F.
8970:             .SpecialEffect = 0
8971:             .BackColor     = RGB(255, 255, 255)
8972:             .ForeColor     = RGB(192, 0, 0)
8973:             .Visible       = .T.
8974:         ENDWITH
8975:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
8976: 
8977:         *----------------------------------------------------------------------
8978:         *-- Shape: shpBorracha (T:464 L:258 W:236 H:156) - borda imagem borracha
8979:         *----------------------------------------------------------------------
8980:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
8981:         WITH loc_oPg.shp_4c_ShpBorracha
8982:             .Top         = 464
8983:             .Left        = 258
8984:             .Width       = 236
8985:             .Height      = 156
8986:             .BackStyle   = 1
8987:             .BackColor   = RGB(255, 255, 255)
8988:             .BorderColor = RGB(192, 192, 192)
8989:             .BorderWidth = 1
8990:             .Visible     = .T.
8991:         ENDWITH
8992: 
8993:         *----------------------------------------------------------------------
8994:         *-- Image: ImgBorracha (T:465 L:260 W:232 H:154) - imagem borracha da matriz
8995:         *-- Legado: GrdMatrizes.AfterRowColChange carrega SigCdPro da matriz corrente
8996:         *----------------------------------------------------------------------
8997:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
8998:         WITH loc_oPg.img_4c_ImgBorracha
8999:             .Top     = 465
9000:             .Left    = 260
9001:             .Width   = 232
9002:             .Height  = 154
9003:             .Picture = ""
9004:             .Stretch = 2
9005:             .Visible = .F.
9006:         ENDWITH
9007:     ENDPROC
9008: 
9009:     *--------------------------------------------------------------------------
9010:     * PreencherCamposFaseP - Popula controles da aba FaseP a partir do BO
9011:     * Chamado por BOParaForm apos carregar dados de SigCdPro
9012:     *--------------------------------------------------------------------------
9013:     PROTECTED PROCEDURE PreencherCamposFaseP()
9014:         LOCAL loc_oPg
9015:         TRY
9016:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9017:                 RETURN
9018:             ENDIF
9019:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9020:             IF VARTYPE(loc_oPg) # "O"
9021:                 RETURN
9022:             ENDIF
9023:             WITH THIS.this_oBusinessObject
9024:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9025:                     loc_oPg.txt_4c_Qmin.Value = IIF(.this_nQmins = 0, 0, .this_nQmins)
9026:                 ENDIF
9027:                 IF VARTYPE(loc_oPg.txt_4c_CodGarras) = "O"
9028:                     loc_oPg.txt_4c_CodGarras.Value = ALLTRIM(.this_cCodgarras)
9029:                 ENDIF
9030:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9031:                     loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(.this_cConquilhas)
9032:                 ENDIF
9033:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9034:                     loc_oPg.txt_4c_PesoBris.Value = .this_nPesobris
9035:                 ENDIF
9036:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9037:                     loc_oPg.txt_4c_PesoMetal.Value = .this_nPesometal
9038:                 ENDIF
9039:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9040:                     loc_oPg.txt_4c_PesoPdrs.Value = .this_nPesopdrs
9041:                 ENDIF
9042:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9043:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(.this_cCodcors)
9044:                 ENDIF
9045:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9046:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(.this_cCodtams)
9047:                 ENDIF
9048:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9049:                     loc_oPg.txt_4c__codacb.Value = ALLTRIM(.this_cCodacbs)
9050:                 ENDIF
9051:                 IF VARTYPE(loc_oPg.txt_4c__Dacb) = "O"
9052:                     loc_oPg.txt_4c__Dacb.Value = ""
9053:                 ENDIF

*-- Linhas 9067 a 9110:
9067:     * LerCamposFaseP - Le controles da aba FaseP e transfere para o BO
9068:     * Chamado por FormParaBO antes de salvar
9069:     *--------------------------------------------------------------------------
9070:     PROTECTED PROCEDURE LerCamposFaseP()
9071:         LOCAL loc_oPg
9072:         TRY
9073:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9074:                 RETURN
9075:             ENDIF
9076:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9077:             IF VARTYPE(loc_oPg) # "O"
9078:                 RETURN
9079:             ENDIF
9080:             WITH THIS.this_oBusinessObject
9081:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9082:                     .this_nQmins = loc_oPg.txt_4c_Qmin.Value
9083:                 ENDIF
9084:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9085:                     .this_cConquilhas = ALLTRIM(loc_oPg.txt_4c_Conquilha.Value)
9086:                 ENDIF
9087:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9088:                     .this_nPesobris = loc_oPg.txt_4c_PesoBris.Value
9089:                 ENDIF
9090:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9091:                     .this_nPesometal = loc_oPg.txt_4c_PesoMetal.Value
9092:                 ENDIF
9093:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9094:                     .this_nPesopdrs = loc_oPg.txt_4c_PesoPdrs.Value
9095:                 ENDIF
9096:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9097:                     .this_cCodcors = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9098:                 ENDIF
9099:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9100:                     .this_cCodtams = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9101:                 ENDIF
9102:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9103:                     .this_cCodacbs = ALLTRIM(loc_oPg.txt_4c__codacb.Value)
9104:                 ENDIF
9105:                 IF VARTYPE(loc_oPg.chk_4c_Opc_CravCera) = "O"
9106:                     .this_lCravcers = (loc_oPg.chk_4c_Opc_CravCera.Value = 1)
9107:                 ENDIF
9108:                 IF VARTYPE(loc_oPg.chk_4c_Fwoption1) = "O"
9109:                     .this_nProdvars = IIF(loc_oPg.chk_4c_Fwoption1.Value = 1, 1, 0)
9110:                 ENDIF

*-- Linhas 9116 a 9161:
9116: 
9117:     *--------------------------------------------------------------------------
9118:     * GradFaseAfterRowColChange - Atualiza imagem e descricao ao navegar GradFase
9119:     * Legado: GradFase.AfterRowColChange (Procedure) - carrega FigProcs, Get_Desc, Get_Obs
9120:     *--------------------------------------------------------------------------
9121:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9122:         LOCAL loc_oPg, loc_lcArquivo
9123:         TRY
9124:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9125:                 RETURN
9126:             ENDIF
9127:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9128:             IF VARTYPE(loc_oPg) # "O"
9129:                 RETURN
9130:             ENDIF
9131: 
9132:             *-- Atualizar descricao da fase (campo Descrs do cursor)
9133:             IF VARTYPE(loc_oPg.txt_4c_Desc) = "O"
9134:                 loc_oPg.txt_4c_Desc.Value = ""
9135:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9136:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9137:                 ENDIF
9138:             ENDIF
9139: 
9140:             *-- Atualizar observacoes da fase (campo Obs de crSigCdPrf se disponivel)
9141:             IF VARTYPE(loc_oPg.obj_4c_Get_Obs) = "O"
9142:                 loc_oPg.obj_4c_Get_Obs.Value = ""
9143:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9144:                     IF TYPE("cursor_4c_GradFase.Obs") # "U"
9145:                         loc_oPg.obj_4c_Get_Obs.Value = NVL(cursor_4c_GradFase.Obs, "")
9146:                     ENDIF
9147:                 ENDIF
9148:             ENDIF
9149: 
9150:             *-- Atualizar imagem da fase (campo FigProcs de crSigCdPrf se disponivel)
9151:             IF VARTYPE(loc_oPg.img_4c_ImgFigJpg) = "O"
9152:                 CLEAR RESOURCES
9153:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
9154:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
9155:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9156:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9157:                         IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9158:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9159:                             IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9160:                                 loc_oPg.img_4c_ImgFigJpg.Picture  = loc_lcArquivo
9161:                                 loc_oPg.img_4c_ImgFigJpg.Visible  = .T.

*-- Linhas 9175 a 9423:
9175:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9176:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9177:     *--------------------------------------------------------------------------
9178:     PROCEDURE GradFaseCol1GotFocus()
9179:         TRY
9180:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9181:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9182:             ENDIF
9183:         CATCH TO loc_oErro
9184:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9185:         ENDTRY
9186:     ENDPROC
9187: 
9188:     *--------------------------------------------------------------------------
9189:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9190:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9191:     *--------------------------------------------------------------------------
9192:     PROCEDURE GradFaseCol1LostFocus()
9193:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9194:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9195:             RETURN
9196:         ENDIF
9197:         loc_lResultado = .T.
9198:         TRY
9199:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9200:                 loc_lResultado = .F.
9201:             ENDIF
9202:             IF loc_lResultado
9203:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9204:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9205:                     loc_lResultado = .F.
9206:                 ENDIF
9207:             ENDIF
9208:             IF loc_lResultado
9209:                 *-- Calcular Ordem2 para resequenciamento
9210:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9211:                 SELECT cursor_4c_GradFase
9212:                 SCAN
9213:                     IF RECNO() # loc_nPonteiro
9214:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9215:                     ENDIF
9216:                 ENDSCAN
9217:                 GO loc_nPonteiro IN cursor_4c_GradFase
9218:                 SELECT cursor_4c_GradFase
9219:                 *-- Reordenar por Ordems para refletir nova sequencia
9220:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9221:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9222:                 ENDIF
9223:             ENDIF
9224:         CATCH TO loc_oErro
9225:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9226:         ENDTRY
9227:     ENDPROC
9228: 
9229:     *--------------------------------------------------------------------------
9230:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9231:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9232:     *         Apos selecao: preenche Grupos e Descrs no cursor
9233:     *--------------------------------------------------------------------------
9234:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9235:         LOCAL loc_oBusca, loc_cAtual
9236:         IF par_nKeyCode = 115  && F4
9237:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9238:                 RETURN
9239:             ENDIF
9240:             TRY
9241:                 loc_cAtual = ""
9242:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9243:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9244:                 ENDIF
9245:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9246:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9247:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9248:                 IF VARTYPE(loc_oBusca) = "O"
9249:                     IF !loc_oBusca.this_lAchouRegistro
9250:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9251:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9252:                         loc_oBusca.Show()
9253:                     ENDIF
9254:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9255:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9256:                             SELECT cursor_4c_GradFase
9257:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9258:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9259:                         ENDIF
9260:                     ENDIF
9261:                     loc_oBusca.Release()
9262:                 ENDIF
9263:                 IF USED("cursor_4c_BuscaGcr")
9264:                     USE IN cursor_4c_BuscaGcr
9265:                 ENDIF
9266:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9267:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9268:                 ENDIF
9269:             CATCH TO loc_oErro
9270:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9271:             ENDTRY
9272:         ENDIF
9273:     ENDPROC
9274: 
9275:     *--------------------------------------------------------------------------
9276:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9277:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9278:     *         Apos selecao: preenche UniPrdts no cursor
9279:     *--------------------------------------------------------------------------
9280:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9281:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9282:         IF par_nKeyCode = 115  && F4
9283:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9284:                 RETURN
9285:             ENDIF
9286:             TRY
9287:                 loc_cAtual  = ""
9288:                 loc_cGrupos = ""
9289:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9290:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9291:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9292:                 ENDIF
9293:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9294:                 IF !EMPTY(loc_cGrupos)
9295:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9296:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9297:                 ELSE
9298:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9299:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9300:                 ENDIF
9301:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9302:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9303:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9304:                         "Buscar Uni. Produtiva")
9305:                     IF VARTYPE(loc_oBusca) = "O"
9306:                         IF !loc_oBusca.this_lAchouRegistro
9307:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9308:                             loc_oBusca.Show()
9309:                         ENDIF
9310:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9311:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9312:                                 SELECT cursor_4c_GradFase
9313:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9314:                             ENDIF
9315:                         ENDIF
9316:                         loc_oBusca.Release()
9317:                     ENDIF
9318:                     IF USED("cursor_4c_BuscaUpd2")
9319:                         USE IN cursor_4c_BuscaUpd2
9320:                     ENDIF
9321:                 ENDIF
9322:                 IF USED("cursor_4c_BuscaUpd")
9323:                     USE IN cursor_4c_BuscaUpd
9324:                 ENDIF
9325:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9326:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9327:                 ENDIF
9328:             CATCH TO loc_oErro
9329:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9330:             ENDTRY
9331:         ENDIF
9332:     ENDPROC
9333: 
9334:     *--------------------------------------------------------------------------
9335:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9336:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9337:     *         Apos selecao: preenche MatPrdts no cursor
9338:     *--------------------------------------------------------------------------
9339:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9340:         LOCAL loc_oBusca, loc_cAtual
9341:         IF par_nKeyCode = 115  && F4
9342:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9343:                 RETURN
9344:             ENDIF
9345:             TRY
9346:                 loc_cAtual = ""
9347:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9348:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9349:                 ENDIF
9350:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9351:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9352:                     "Buscar Tipo de Material")
9353:                 IF VARTYPE(loc_oBusca) = "O"
9354:                     IF !loc_oBusca.this_lAchouRegistro
9355:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9356:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9357:                         loc_oBusca.Show()
9358:                     ENDIF
9359:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9360:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9361:                             SELECT cursor_4c_GradFase
9362:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9363:                         ENDIF
9364:                     ENDIF
9365:                     loc_oBusca.Release()
9366:                 ENDIF
9367:                 IF USED("cursor_4c_BuscaOpt")
9368:                     USE IN cursor_4c_BuscaOpt
9369:                 ENDIF
9370:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9371:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9372:                 ENDIF
9373:             CATCH TO loc_oErro
9374:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9375:             ENDTRY
9376:         ENDIF
9377:     ENDPROC
9378: 
9379:     *--------------------------------------------------------------------------
9380:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9381:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9382:     *--------------------------------------------------------------------------
9383:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9384:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9385:         TRY
9386:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9387:                 RETURN
9388:             ENDIF
9389:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9390:             IF VARTYPE(loc_oPg) # "O"
9391:                 RETURN
9392:             ENDIF
9393: 
9394:             *-- Limpar imagem anterior
9395:             CLEAR RESOURCES
9396:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9397:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9398: 
9399:             *-- Carregar imagem da borracha do produto-matriz corrente
9400:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9401:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9402:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9403:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9404:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9405:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9406:                         GO TOP IN cursor_4c_LocalImgPro
9407:                         IF !EOF("cursor_4c_LocalImgPro")
9408:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9409:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9410:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9411:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9412:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9413:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9414:                                     ENDIF
9415:                                 ENDIF
9416:                             ENDIF
9417:                         ENDIF
9418:                         USE IN cursor_4c_LocalImgPro
9419:                     ENDIF
9420:                 ENDIF
9421:             ENDIF
9422: 
9423:             loc_oPg.grd_4c_Matrizes.Refresh()

*-- Linhas 9431 a 10134:
9431:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9432:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9433:     *--------------------------------------------------------------------------
9434:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9435:         LOCAL loc_oBusca, loc_cAtual
9436:         IF par_nKeyCode = 115  && F4
9437:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9438:                 RETURN
9439:             ENDIF
9440:             TRY
9441:                 loc_cAtual = ""
9442:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9443:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9444:                 ENDIF
9445:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9446:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9447:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9448:                     "Buscar Matriz")
9449:                 IF VARTYPE(loc_oBusca) = "O"
9450:                     IF !loc_oBusca.this_lAchouRegistro
9451:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9452:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9453:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9454:                         loc_oBusca.Show()
9455:                     ENDIF
9456:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9457:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9458:                             SELECT cursor_4c_SigPrMtz
9459:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9460:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9461:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9462:                             ENDIF
9463:                         ENDIF
9464:                     ENDIF
9465:                     loc_oBusca.Release()
9466:                 ENDIF
9467:                 IF USED("cursor_4c_BuscaMatriz")
9468:                     USE IN cursor_4c_BuscaMatriz
9469:                 ENDIF
9470:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9471:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9472:                 ENDIF
9473:             CATCH TO loc_oErro
9474:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9475:             ENDTRY
9476:         ENDIF
9477:     ENDPROC
9478: 
9479:     *--------------------------------------------------------------------------
9480:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9481:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9482:     *--------------------------------------------------------------------------
9483:     PROCEDURE CmdIncluirFaseClick()
9484:         LOCAL loc_oPg, loc_nOrdem
9485:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9486:             RETURN
9487:         ENDIF
9488:         TRY
9489:             IF !USED("cursor_4c_GradFase")
9490:                 RETURN
9491:             ENDIF
9492:             *-- Calcular proximo numero de ordem
9493:             loc_nOrdem = 0
9494:             IF !EOF("cursor_4c_GradFase")
9495:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9496:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9497:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9498:                 ENDIF
9499:                 IF USED("cursor_4c_TmpOrd")
9500:                     USE IN cursor_4c_TmpOrd
9501:                 ENDIF
9502:             ENDIF
9503:             loc_nOrdem = loc_nOrdem + 1
9504:             *-- Inserir nova linha
9505:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9506:                 VALUES (loc_nOrdem, "", "", "", "")
9507:             *-- Posicionar no novo registro e focar grid
9508:             GO BOTTOM IN cursor_4c_GradFase
9509:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9510:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9511:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9512:                     loc_oPg.grd_4c_GradFase.Refresh()
9513:                     loc_oPg.grd_4c_GradFase.SetFocus()
9514:                 ENDIF
9515:             ENDIF
9516:         CATCH TO loc_oErro
9517:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9518:         ENDTRY
9519:     ENDPROC
9520: 
9521:     *--------------------------------------------------------------------------
9522:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9523:     * Legado: excluir.Click - DELETE e resequencia Ordems
9524:     *--------------------------------------------------------------------------
9525:     PROCEDURE CmdExcluirFaseClick()
9526:         LOCAL loc_oPg, loc_lResultado
9527:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9528:             RETURN
9529:         ENDIF
9530:         loc_lResultado = .T.
9531:         TRY
9532:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9533:                 loc_lResultado = .F.
9534:             ENDIF
9535:             IF loc_lResultado
9536:                 IF !MsgConfirma("Excluir fase selecionada?")
9537:                     loc_lResultado = .F.
9538:                 ENDIF
9539:             ENDIF
9540:             IF loc_lResultado
9541:                 SELECT cursor_4c_GradFase
9542:                 DELETE
9543:                 IF !EOF("cursor_4c_GradFase")
9544:                     SKIP
9545:                 ENDIF
9546:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9547:                     GO BOTTOM IN cursor_4c_GradFase
9548:                 ENDIF
9549:                 *-- Resequenciar Ordems
9550:                 LOCAL loc_nSeq
9551:                 loc_nSeq = 1
9552:                 GO TOP IN cursor_4c_GradFase
9553:                 SCAN FOR !DELETED()
9554:                     REPLACE Ordems WITH loc_nSeq
9555:                     loc_nSeq = loc_nSeq + 1
9556:                 ENDSCAN
9557:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9558:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9559:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9560:                         loc_oPg.grd_4c_GradFase.Refresh()
9561:                     ENDIF
9562:                 ENDIF
9563:             ENDIF
9564:         CATCH TO loc_oErro
9565:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9566:         ENDTRY
9567:     ENDPROC
9568: 
9569:     *--------------------------------------------------------------------------
9570:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9571:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9572:     *--------------------------------------------------------------------------
9573:     PROCEDURE CmdAlternativaFaseClick()
9574:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9575:         LOCAL loc_nOrdem
9576:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9577:             RETURN
9578:         ENDIF
9579:         loc_lResultado = .T.
9580:         TRY
9581:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9582:                 loc_lResultado = .F.
9583:             ENDIF
9584:             IF loc_lResultado
9585:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_GradFase.Grupos, "")))
9586:                     MsgAviso("Selecione uma fase para criar alternativa.")
9587:                     loc_lResultado = .F.
9588:                 ENDIF
9589:             ENDIF
9590:             IF loc_lResultado
9591:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9592:                 loc_cDescrs = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9593:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9594:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9595:                 *-- Calcular proxima ordem
9596:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9597:                 loc_nOrdem = 1
9598:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9599:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9600:                 ENDIF
9601:                 IF USED("cursor_4c_TmpAlt")
9602:                     USE IN cursor_4c_TmpAlt
9603:                 ENDIF
9604:                 *-- Inserir copia como alternativa
9605:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9606:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9607:                 GO BOTTOM IN cursor_4c_GradFase
9608:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9609:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9610:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9611:                         loc_oPg.grd_4c_GradFase.Refresh()
9612:                     ENDIF
9613:                 ENDIF
9614:             ENDIF
9615:         CATCH TO loc_oErro
9616:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9617:         ENDTRY
9618:     ENDPROC
9619: 
9620:     *--------------------------------------------------------------------------
9621:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9622:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9623:     *--------------------------------------------------------------------------
9624:     PROCEDURE CmdFichaClick()
9625:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9626:         loc_lResultado = .T.
9627:         TRY
9628:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9629:                 loc_lResultado = .F.
9630:             ENDIF
9631:             IF loc_lResultado
9632:                 IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
9633:                     MsgAviso("Produto n" + CHR(227) + "o selecionado.")
9634:                     loc_lResultado = .F.
9635:                 ENDIF
9636:             ENDIF
9637:             IF loc_lResultado
9638:                 *-- Nome da empresa ja disponivel em go_4c_Sistema.cEmpresa
9639:                 loc_cNmEmp = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
9640:                 *-- Preparar cursor de cabecalho para o relatorio
9641:                 IF USED("CsCabecalho")
9642:                     USE IN CsCabecalho
9643:                 ENDIF
9644:                 CREATE CURSOR CsCabecalho (;
9645:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9646:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9647:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9648:                     _nPeso N(9,2))
9649:                 WITH THIS.this_oBusinessObject
9650:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9651:                         VALUES (loc_cNmEmp, ;
9652:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9653:                                 ALLTRIM(.this_cCpros), ;
9654:                                 ALLTRIM(.this_cDpros), ;
9655:                                 ALLTRIM(.this_cCgrus), ;
9656:                                 .this_nPesobs)
9657:                 ENDWITH
9658:                 *-- Verificar e executar relatorio
9659:                 LOCAL loc_cRepPath
9660:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9661:                 IF FILE(loc_cRepPath)
9662:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9663:                 ELSE
9664:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9665:                 ENDIF
9666:                 IF USED("CsCabecalho")
9667:                     USE IN CsCabecalho
9668:                 ENDIF
9669:             ENDIF
9670:         CATCH TO loc_oErro
9671:             MsgErro(loc_oErro.Message, "Erro ao gerar ficha t" + CHR(233) + "cnica")
9672:         ENDTRY
9673:     ENDPROC
9674: 
9675:     *--------------------------------------------------------------------------
9676:     * CmdgFiguraClick - Seleciona imagem JPG/BMP para a fase corrente
9677:     * Legado: cmdgFigura.Click - GETPICT e armazena em crSigCdPrf.FigProcs
9678:     *--------------------------------------------------------------------------
9679:     PROCEDURE CmdgFiguraClick()
9680:         LOCAL loc_lResultado, loc_cFigura, loc_cArquivo
9681:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9682:             RETURN
9683:         ENDIF
9684:         loc_lResultado = .T.
9685:         TRY
9686:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9687:                 loc_lResultado = .F.
9688:             ENDIF
9689:             IF loc_lResultado
9690:                 *-- Abrir seletor de arquivo de imagem
9691:                 loc_cFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
9692:                     "Nome do Arquivo:", "Selecionar"))
9693:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9694:                     *-- Armazenar imagem binaria no campo memo FigProcs
9695:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9696:                         SELECT cursor_4c_GradFase
9697:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9698:                     ENDIF
9699:                     *-- Atualizar exibicao da imagem
9700:                     THIS.GradFaseAfterRowColChange(0)
9701:                 ENDIF
9702:             ENDIF
9703:         CATCH TO loc_oErro
9704:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9705:         ENDTRY
9706:     ENDPROC
9707: 
9708:     *--------------------------------------------------------------------------
9709:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9710:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9711:     *--------------------------------------------------------------------------
9712:     PROCEDURE CmdgFigCamClick()
9713:         LOCAL loc_lResultado, loc_cFigura
9714:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9715:             RETURN
9716:         ENDIF
9717:         loc_lResultado = .T.
9718:         TRY
9719:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9720:                 loc_lResultado = .F.
9721:             ENDIF
9722:             IF loc_lResultado
9723:                 loc_cFigura = ""
9724:                 *-- Acionar captura de webcam via form legado SigImage
9725:                 IF FILE(gc_4c_CaminhoBase + "SigImage.scx")
9726:                     DO FORM (gc_4c_CaminhoBase + "SigImage") TO loc_cFigura
9727:                 ELSE
9728:                     MsgAviso("Captura de imagem (SigImage) n" + CHR(227) + "o dispon" + CHR(237) + "vel.")
9729:                     loc_lResultado = .F.
9730:                 ENDIF
9731:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9732:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9733:                         SELECT cursor_4c_GradFase
9734:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9735:                     ENDIF
9736:                     THIS.GradFaseAfterRowColChange(0)
9737:                 ENDIF
9738:             ENDIF
9739:         CATCH TO loc_oErro
9740:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9741:         ENDTRY
9742:     ENDPROC
9743: 
9744:     *--------------------------------------------------------------------------
9745:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9746:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9747:     *--------------------------------------------------------------------------
9748:     PROCEDURE ImgFigJpgClick()
9749:         LOCAL loc_lcArquivo
9750:         TRY
9751:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9752:                 IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9753:                     IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9754:                         loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_zoom.jpg"
9755:                         IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9756:                             IF FILE(loc_lcArquivo)
9757:                                 DO FORM SigOpZom WITH loc_lcArquivo, .F.
9758:                             ENDIF
9759:                         ENDIF
9760:                     ENDIF
9761:                 ENDIF
9762:             ENDIF
9763:         CATCH TO loc_oErro
9764:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
9765:         ENDTRY
9766:     ENDPROC
9767: 
9768:     *--------------------------------------------------------------------------
9769:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9770:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9771:     *--------------------------------------------------------------------------
9772:     PROCEDURE BtnInsereMtxClick()
9773:         LOCAL loc_oPg, loc_lResultado
9774:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9775:             RETURN
9776:         ENDIF
9777:         loc_lResultado = .T.
9778:         TRY
9779:             IF !USED("cursor_4c_SigPrMtz")
9780:                 loc_lResultado = .F.
9781:             ENDIF
9782:             IF loc_lResultado
9783:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9784:                 GO TOP IN cursor_4c_SigPrMtz
9785:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9786:                 IF !EOF("cursor_4c_SigPrMtz")
9787:                     *-- Ja existe linha vazia - apenas focar
9788:                     loc_lResultado = .F.
9789:                 ENDIF
9790:             ENDIF
9791:             IF loc_lResultado
9792:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9793:                 GO BOTTOM IN cursor_4c_SigPrMtz
9794:             ENDIF
9795:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9796:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9797:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9798:                     loc_oPg.grd_4c_Matrizes.Refresh()
9799:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9800:                 ENDIF
9801:             ENDIF
9802:         CATCH TO loc_oErro
9803:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9804:         ENDTRY
9805:     ENDPROC
9806: 
9807:     *--------------------------------------------------------------------------
9808:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9809:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9810:     *--------------------------------------------------------------------------
9811:     PROCEDURE BtnExcluiMtzClick()
9812:         LOCAL loc_oPg, loc_lResultado
9813:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9814:             RETURN
9815:         ENDIF
9816:         loc_lResultado = .T.
9817:         TRY
9818:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9819:                 loc_lResultado = .F.
9820:             ENDIF
9821:             IF loc_lResultado
9822:                 SELECT cursor_4c_SigPrMtz
9823:                 DELETE
9824:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9825:                 GO TOP IN cursor_4c_SigPrMtz
9826:                 LOCATE FOR !DELETED()
9827:                 IF EOF("cursor_4c_SigPrMtz")
9828:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9829:                 ENDIF
9830:             ENDIF
9831:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9832:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9833:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9834:                     loc_oPg.grd_4c_Matrizes.Refresh()
9835:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9836:                 ENDIF
9837:             ENDIF
9838:         CATCH TO loc_oErro
9839:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9840:         ENDTRY
9841:     ENDPROC
9842: 
9843:     *--------------------------------------------------------------------------
9844:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9845:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9846:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9847:     *--------------------------------------------------------------------------
9848:     PROCEDURE TxtCodacbLostFocus()
9849:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9850:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9851:             RETURN
9852:         ENDIF
9853:         loc_lResultado = .T.
9854:         TRY
9855:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9856:                 loc_lResultado = .F.
9857:             ENDIF
9858:             IF loc_lResultado
9859:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9860:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c__codacb.Value, ""))
9861:                 IF EMPTY(loc_cCod)
9862:                     loc_oPg.txt_4c__Dacb.Value = ""
9863:                     THIS.this_oBusinessObject.this_cCodacbs = ""
9864:                     loc_lResultado = .F.
9865:                 ENDIF
9866:             ENDIF
9867:             IF loc_lResultado
9868:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9869:                     "SigCdAca", "cursor_4c_BuscaAca", "Cods", loc_cCod, ;
9870:                     "Buscar Acabamento")
9871:                 IF VARTYPE(loc_oBusca) = "O"
9872:                     IF !loc_oBusca.this_lAchouRegistro
9873:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9874:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9875:                         loc_oBusca.Show()
9876:                     ENDIF
9877:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9878:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9879:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9880:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9881:                     ELSE
9882:                         loc_oPg.txt_4c__codacb.Value = ""
9883:                         loc_oPg.txt_4c__Dacb.Value   = ""
9884:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9885:                     ENDIF
9886:                     loc_oBusca.Release()
9887:                 ENDIF
9888:                 IF USED("cursor_4c_BuscaAca")
9889:                     USE IN cursor_4c_BuscaAca
9890:                 ENDIF
9891:             ENDIF
9892:         CATCH TO loc_oErro
9893:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9894:         ENDTRY
9895:     ENDPROC
9896: 
9897:     *--------------------------------------------------------------------------
9898:     * TxtTamLostFocus - Valida e busca tamanho (SigCdTam) ao sair do campo
9899:     * Legado: getTam.Valid = fwBuscaExt on SigCdTam by Cods
9900:     *--------------------------------------------------------------------------
9901:     PROCEDURE TxtTamLostFocus()
9902:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9903:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9904:             RETURN
9905:         ENDIF
9906:         *-- Guard: evita reabrir lookup se valor nao mudou
9907:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9908:             LOCAL loc_cGuardaTam
9909:             loc_cGuardaTam = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Tam.Value, ""))
9910:             IF loc_cGuardaTam = THIS.this_cUltimoTxtTamLostFocusValidado
9911:                 RETURN
9912:             ENDIF
9913:             THIS.this_cUltimoTxtTamLostFocusValidado = loc_cGuardaTam
9914:         ENDIF
9915:         loc_lResultado = .T.
9916:         TRY
9917:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9918:                 loc_lResultado = .F.
9919:             ENDIF
9920:             IF loc_lResultado
9921:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9922:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Tam.Value, ""))
9923:                 IF EMPTY(loc_cCod)
9924:                     THIS.this_oBusinessObject.this_cCodtams = ""
9925:                     loc_lResultado = .F.
9926:                 ENDIF
9927:             ENDIF
9928:             IF loc_lResultado
9929:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9930:                     "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cCod, ;
9931:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9932:                 IF VARTYPE(loc_oBusca) = "O"
9933:                     IF !loc_oBusca.this_lAchouRegistro
9934:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9935:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9936:                         loc_oBusca.Show()
9937:                     ENDIF
9938:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9939:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9940:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9941:                     ELSE
9942:                         loc_oPg.txt_4c_Tam.Value = ""
9943:                         THIS.this_oBusinessObject.this_cCodtams = ""
9944:                     ENDIF
9945:                     loc_oBusca.Release()
9946:                 ENDIF
9947:                 IF USED("cursor_4c_BuscaTam")
9948:                     USE IN cursor_4c_BuscaTam
9949:                 ENDIF
9950:             ENDIF
9951:         CATCH TO loc_oErro
9952:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9953:         ENDTRY
9954:     ENDPROC
9955: 
9956:     *--------------------------------------------------------------------------
9957:     * TxtCorLostFocus - Valida e busca cor padrao (SigCdCor) ao sair do campo
9958:     * Legado: getCor.Valid = fwBuscaExt on SigCdCor by Cods
9959:     *--------------------------------------------------------------------------
9960:     PROCEDURE TxtCorLostFocus()
9961:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9962:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9963:             RETURN
9964:         ENDIF
9965:         *-- Guard: evita reabrir lookup se valor nao mudou
9966:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9967:             LOCAL loc_cGuardaCor
9968:             loc_cGuardaCor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Cor.Value, ""))
9969:             IF loc_cGuardaCor = THIS.this_cUltimoTxtCorLostFocusValidado
9970:                 RETURN
9971:             ENDIF
9972:             THIS.this_cUltimoTxtCorLostFocusValidado = loc_cGuardaCor
9973:         ENDIF
9974:         loc_lResultado = .T.
9975:         TRY
9976:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9977:                 loc_lResultado = .F.
9978:             ENDIF
9979:             IF loc_lResultado
9980:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9981:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Cor.Value, ""))
9982:                 IF EMPTY(loc_cCod)
9983:                     THIS.this_oBusinessObject.this_cCodcors = ""
9984:                     loc_lResultado = .F.
9985:                 ENDIF
9986:             ENDIF
9987:             IF loc_lResultado
9988:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9989:                     "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cCod, ;
9990:                     "Buscar Cor Padr" + CHR(227) + "o")
9991:                 IF VARTYPE(loc_oBusca) = "O"
9992:                     IF !loc_oBusca.this_lAchouRegistro
9993:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
9994:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9995:                         loc_oBusca.Show()
9996:                     ENDIF
9997:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
9998:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
9999:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
10000:                     ELSE
10001:                         loc_oPg.txt_4c_Cor.Value = ""
10002:                         THIS.this_oBusinessObject.this_cCodcors = ""
10003:                     ENDIF
10004:                     loc_oBusca.Release()
10005:                 ENDIF
10006:                 IF USED("cursor_4c_BuscaCor")
10007:                     USE IN cursor_4c_BuscaCor
10008:                 ENDIF
10009:             ENDIF
10010:         CATCH TO loc_oErro
10011:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
10012:         ENDTRY
10013:     ENDPROC
10014: 
10015:     *--------------------------------------------------------------------------
10016:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10017:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10018:     *--------------------------------------------------------------------------
10019:     PROCEDURE TxtConquilhaLostFocus()
10020:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10021:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10022:             RETURN
10023:         ENDIF
10024:         *-- Guard: evita reabrir lookup se valor nao mudou
10025:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
10026:             LOCAL loc_cGuardaCnq
10027:             loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
10028:             IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
10029:                 RETURN
10030:             ENDIF
10031:             THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
10032:         ENDIF
10033:         loc_lResultado = .T.
10034:         TRY
10035:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10036:                 loc_lResultado = .F.
10037:             ENDIF
10038:             IF loc_lResultado
10039:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10040:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Conquilha.Value, ""))
10041:                 IF EMPTY(loc_cCod)
10042:                     THIS.this_oBusinessObject.this_cConquilhas = ""
10043:                     loc_lResultado = .F.
10044:                 ENDIF
10045:             ENDIF
10046:             IF loc_lResultado
10047:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10048:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10049:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10050:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10051:                     SELECT cursor_4c_ListaCnq
10052:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10053:                     IF !EOF("cursor_4c_ListaCnq")
10054:                         *-- Encontrado direto
10055:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10056:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10057:                     ELSE
10058:                         *-- Nao encontrado - abrir lookup
10059:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10060:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10061:                             "Buscar Conquilha")
10062:                         IF VARTYPE(loc_oBusca) = "O"
10063:                             IF !loc_oBusca.this_lAchouRegistro
10064:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10065:                                 loc_oBusca.Show()
10066:                             ENDIF
10067:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10068:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10069:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10070:                             ELSE
10071:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10072:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10073:                             ENDIF
10074:                             loc_oBusca.Release()
10075:                         ENDIF
10076:                         IF USED("cursor_4c_BuscaCnq")
10077:                             USE IN cursor_4c_BuscaCnq
10078:                         ENDIF
10079:                     ENDIF
10080:                     USE IN cursor_4c_ListaCnq
10081:                 ENDIF
10082:             ENDIF
10083:         CATCH TO loc_oErro
10084:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")
10085:         ENDTRY
10086:     ENDPROC
10087: 
10088:     *==========================================================================
10089:     * FASE 13 - Aba Dados Fiscais (pgDadosFiscais - Page3 do pgf_4c_Dados)
10090:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
10091:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10092:     * Controles: 16 textboxes, 11 labels, 1 editbox, 1 combobox, 1 grid(3col), 1 button
10093:     *==========================================================================
10094:     PROTECTED PROCEDURE ConfigurarPgPgDadosFiscais()
10095:         LOCAL loc_oPg, loc_oGrd
10096:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10097: 
10098:         *----------------------------------------------------------------------
10099:         *-- Cursor placeholder cursor_4c_Cmv (SigCdCmv - Valor Grama)
10100:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10101:         *----------------------------------------------------------------------
10102:         IF !USED("cursor_4c_Cmv")
10103:             SET NULL ON
10104:             CREATE CURSOR cursor_4c_Cmv (;
10105:                 Datas   D, ;
10106:                 ValCuss N(12,3), ;
10107:                 Moedas  C(3))
10108:             SET NULL OFF
10109:         ENDIF
10110: 
10111:         *----------------------------------------------------------------------
10112:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10113:         *----------------------------------------------------------------------
10114:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10115:         WITH loc_oPg.lbl_4c_LblGruCus
10116:             .Caption   = "Grupo C.C. :"
10117:             .Top       = 165
10118:             .Left      = 138
10119:             .Width     = 63
10120:             .Height    = 15
10121:             .FontName  = "Tahoma"
10122:             .FontSize  = 8
10123:             .BackStyle = 0
10124:             .ForeColor = RGB(90, 90, 90)
10125:             .Visible   = .T.
10126:         ENDWITH
10127: 
10128:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")
10129:         WITH loc_oPg.lbl_4c_LblContaCus
10130:             .Caption   = "Conta C.C. :"
10131:             .Top       = 189
10132:             .Left      = 138
10133:             .Width     = 63
10134:             .Height    = 15

*-- Linhas 10427 a 10696:
10427:             .Enabled       = .F.
10428:             .Visible       = .T.
10429:         ENDWITH
10430:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "LostFocus", THIS, "TxtGruccusFiscLostFocus")
10431: 
10432:         *-- get_dgruccus: Descricao Grupo CC (T:161 L:288 W:318 H:23) readonly
10433:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
10434:         WITH loc_oPg.txt_4c_Dgruccus
10435:             .Top           = 161
10436:             .Left          = 288
10437:             .Width         = 318
10438:             .Height        = 23
10439:             .Value         = ""
10440:             .FontName      = "Tahoma"
10441:             .FontSize      = 8
10442:             .SpecialEffect = 1
10443:             .ForeColor     = RGB(36, 84, 155)
10444:             .ReadOnly      = .T.
10445:             .Enabled       = .F.
10446:             .Visible       = .T.
10447:         ENDWITH
10448: 
10449:         *-- get_contaccus: Conta de Custo (T:186 L:206 W:80 H:23)
10450:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
10451:         WITH loc_oPg.txt_4c_Contaccus
10452:             .Top           = 186
10453:             .Left          = 206
10454:             .Width         = 80
10455:             .Height        = 23
10456:             .Value         = ""
10457:             .FontName      = "Tahoma"
10458:             .FontSize      = 8
10459:             .SpecialEffect = 1
10460:             .ForeColor     = RGB(36, 84, 155)
10461:             .Enabled       = .F.
10462:             .Visible       = .T.
10463:         ENDWITH
10464:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "LostFocus", THIS, "TxtContaccusFiscLostFocus")
10465: 
10466:         *-- get_dcontaccus: Descricao Conta CC (T:186 L:288 W:318 H:23) readonly
10467:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
10468:         WITH loc_oPg.txt_4c_Dcontaccus
10469:             .Top           = 186
10470:             .Left          = 288
10471:             .Width         = 318
10472:             .Height        = 23
10473:             .Value         = ""
10474:             .FontName      = "Tahoma"
10475:             .FontSize      = 8
10476:             .SpecialEffect = 1
10477:             .ForeColor     = RGB(36, 84, 155)
10478:             .ReadOnly      = .T.
10479:             .Enabled       = .F.
10480:             .Visible       = .T.
10481:         ENDWITH
10482: 
10483:         *----------------------------------------------------------------------
10484:         *-- TextBoxes da area Fiscal Principal
10485:         *----------------------------------------------------------------------
10486:         *-- getClfiscal: Classificacao Fiscal (T:211 L:206 W:94 H:23)
10487:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
10488:         WITH loc_oPg.txt_4c_Clfiscal
10489:             .Top           = 211
10490:             .Left          = 206
10491:             .Width         = 94
10492:             .Height        = 23
10493:             .Value         = ""
10494:             .FontName      = "Tahoma"
10495:             .FontSize      = 8
10496:             .SpecialEffect = 1
10497:             .ForeColor     = RGB(36, 84, 155)
10498:             .Enabled       = .F.
10499:             .Visible       = .T.
10500:         ENDWITH
10501:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "LostFocus", THIS, "TxtClfiscalFiscLostFocus")
10502: 
10503:         *-- getDclfiscal: Descricao Classif. Fiscal (T:211 L:303 W:303 H:23) readonly
10504:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
10505:         WITH loc_oPg.txt_4c_Dclfiscal
10506:             .Top           = 211
10507:             .Left          = 303
10508:             .Width         = 303
10509:             .Height        = 23
10510:             .Value         = ""
10511:             .FontName      = "Tahoma"
10512:             .FontSize      = 8
10513:             .SpecialEffect = 1
10514:             .ForeColor     = RGB(36, 84, 155)
10515:             .ReadOnly      = .T.
10516:             .Enabled       = .F.
10517:             .Visible       = .T.
10518:         ENDWITH
10519:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "TxtDclfiscalFiscLostFocus")
10520: 
10521:         *-- getOrigmerc: Origem Mercadoria (T:236 L:206 W:17 H:23)
10522:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
10523:         WITH loc_oPg.txt_4c_Origmerc
10524:             .Top           = 236
10525:             .Left          = 206
10526:             .Width         = 17
10527:             .Height        = 23
10528:             .Value         = ""
10529:             .FontName      = "Tahoma"
10530:             .FontSize      = 8
10531:             .SpecialEffect = 1
10532:             .ForeColor     = RGB(36, 84, 155)
10533:             .Enabled       = .F.
10534:             .Visible       = .T.
10535:         ENDWITH
10536:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "LostFocus", THIS, "TxtOrigmercFiscLostFocus")
10537: 
10538:         *-- getDorigmerc: Descricao Origem (T:236 L:226 W:380 H:23)
10539:         *-- Visivel apenas quando Origmerc vazio (readonly com busca reversa)
10540:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
10541:         WITH loc_oPg.txt_4c_Dorigmerc
10542:             .Top           = 236
10543:             .Left          = 226
10544:             .Width         = 380
10545:             .Height        = 23
10546:             .Value         = ""
10547:             .FontName      = "Tahoma"
10548:             .FontSize      = 8
10549:             .SpecialEffect = 1
10550:             .ForeColor     = RGB(36, 84, 155)
10551:             .ReadOnly      = .T.
10552:             .Enabled       = .F.
10553:             .Visible       = .T.
10554:         ENDWITH
10555: 
10556:         *-- getSittricm: Situacao Tributaria ICMS (T:261 L:206 W:31 H:23)
10557:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
10558:         WITH loc_oPg.txt_4c_Sittricm
10559:             .Top           = 261
10560:             .Left          = 206
10561:             .Width         = 31
10562:             .Height        = 23
10563:             .Value         = ""
10564:             .FontName      = "Tahoma"
10565:             .FontSize      = 8
10566:             .SpecialEffect = 1
10567:             .ForeColor     = RGB(36, 84, 155)
10568:             .Enabled       = .F.
10569:             .Visible       = .T.
10570:         ENDWITH
10571:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "LostFocus", THIS, "TxtSittricmFiscLostFocus")
10572: 
10573:         *-- getDsittricm: Descricao Sit. Trib. ICMS (T:261 L:240 W:366 H:23) readonly
10574:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
10575:         WITH loc_oPg.txt_4c_Dsittricm
10576:             .Top           = 261
10577:             .Left          = 240
10578:             .Width         = 366
10579:             .Height        = 23
10580:             .Value         = ""
10581:             .FontName      = "Tahoma"
10582:             .FontSize      = 8
10583:             .SpecialEffect = 1
10584:             .ForeColor     = RGB(36, 84, 155)
10585:             .ReadOnly      = .T.
10586:             .Enabled       = .F.
10587:             .Visible       = .T.
10588:         ENDWITH
10589: 
10590:         *-- Get_CodServs: Cod. Servicos ICMS (T:286 L:206 W:38 H:23)
10591:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
10592:         WITH loc_oPg.txt_4c_CodServs
10593:             .Top           = 286
10594:             .Left          = 206
10595:             .Width         = 38
10596:             .Height        = 23
10597:             .Value         = ""
10598:             .FontName      = "Tahoma"
10599:             .FontSize      = 8
10600:             .SpecialEffect = 1
10601:             .ForeColor     = RGB(36, 84, 155)
10602:             .Enabled       = .F.
10603:             .Visible       = .T.
10604:         ENDWITH
10605:         BINDEVENT(loc_oPg.txt_4c_CodServs, "LostFocus", THIS, "TxtCodServsFiscLostFocus")
10606: 
10607:         *-- getIcms: Aliquota ICMS (T:286 L:342 W:45 H:23)
10608:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
10609:         WITH loc_oPg.txt_4c_Icms
10610:             .Top           = 286
10611:             .Left          = 342
10612:             .Width         = 45
10613:             .Height        = 23
10614:             .Value         = 0
10615:             .FontName      = "Tahoma"
10616:             .FontSize      = 8
10617:             .SpecialEffect = 1
10618:             .ForeColor     = RGB(36, 84, 155)
10619:             .Enabled       = .F.
10620:             .Visible       = .T.
10621:         ENDWITH
10622: 
10623:         *-- Get_TpTrib: Tipo Tributacao (T:286 L:513 W:38 H:23)
10624:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
10625:         WITH loc_oPg.txt_4c_TpTrib
10626:             .Top           = 286
10627:             .Left          = 513
10628:             .Width         = 38
10629:             .Height        = 23
10630:             .Value         = ""
10631:             .FontName      = "Tahoma"
10632:             .FontSize      = 8
10633:             .SpecialEffect = 1
10634:             .ForeColor     = RGB(36, 84, 155)
10635:             .Enabled       = .F.
10636:             .Visible       = .T.
10637:         ENDWITH
10638:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "LostFocus", THIS, "TxtTpTribFiscLostFocus")
10639: 
10640:         *-- getiat: IAT - Arredondamento/Truncamento (T:286 L:589 W:17 H:23) MaxLength=1
10641:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
10642:         WITH loc_oPg.txt_4c_Iat
10643:             .Top           = 286
10644:             .Left          = 589
10645:             .Width         = 17
10646:             .Height        = 23
10647:             .Value         = ""
10648:             .FontName      = "Tahoma"
10649:             .FontSize      = 8
10650:             .SpecialEffect = 1
10651:             .ForeColor     = RGB(36, 84, 155)
10652:             .MaxLength     = 1
10653:             .Enabled       = .F.
10654:             .Visible       = .T.
10655:         ENDWITH
10656:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "TxtIatFiscLostFocus")
10657: 
10658:         *----------------------------------------------------------------------
10659:         *-- ComboBox cmbIpi: Tipo IPI (T:311 L:206 W:108 H:25)
10660:         *-- Items: '' | Tributado | Isento | Outros
10661:         *----------------------------------------------------------------------
10662:         loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
10663:         WITH loc_oPg.cmb_4c_Ipi
10664:             .Top           = 311
10665:             .Left          = 206
10666:             .Width         = 108
10667:             .Height        = 25
10668:             .FontName      = "Tahoma"
10669:             .FontSize      = 8
10670:             .SpecialEffect = 1
10671:             .Style         = 2
10672:             .Enabled       = .F.
10673:             .Visible       = .T.
10674:         ENDWITH
10675:         loc_oPg.cmb_4c_Ipi.Clear()
10676:         loc_oPg.cmb_4c_Ipi.AddItem(PADR("", 10))
10677:         loc_oPg.cmb_4c_Ipi.AddItem("Tributado")
10678:         loc_oPg.cmb_4c_Ipi.AddItem("Isento   ")
10679:         loc_oPg.cmb_4c_Ipi.AddItem("Outros   ")
10680: 
10681:         *-- Get_AliqIPI: Aliquota IPI (T:311 L:425 W:45 H:25)
10682:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
10683:         WITH loc_oPg.txt_4c_AliqIPI
10684:             .Top           = 311
10685:             .Left          = 425
10686:             .Width         = 45
10687:             .Height        = 25
10688:             .Value         = 0
10689:             .FontName      = "Tahoma"
10690:             .FontSize      = 8
10691:             .SpecialEffect = 1
10692:             .ForeColor     = RGB(36, 84, 155)
10693:             .Enabled       = .F.
10694:             .Visible       = .T.
10695:         ENDWITH
10696: 

*-- Linhas 10728 a 10771:
10728:             .Enabled         = .F.
10729:             .Visible         = .T.
10730:         ENDWITH
10731:         BINDEVENT(loc_oPg.cmd_4c_DescFis, "Click", THIS, "CmdDescFisClick")
10732: 
10733:         *----------------------------------------------------------------------
10734:         *-- EditBox mgetdescfi: Descricao Fiscal (T:338 L:206 W:509 H:89)
10735:         *----------------------------------------------------------------------
10736:         loc_oPg.AddObject("obj_4c_Descfis", "EditBox")
10737:         WITH loc_oPg.obj_4c_Descfis
10738:             .Top           = 338
10739:             .Left          = 206
10740:             .Width         = 509
10741:             .Height        = 89
10742:             .Value         = ""
10743:             .FontName      = "Tahoma"
10744:             .FontSize      = 8
10745:             .SpecialEffect = 1
10746:             .ForeColor     = RGB(36, 84, 155)
10747:             .Enabled       = .F.
10748:             .Visible       = .T.
10749:         ENDWITH
10750: 
10751:         *----------------------------------------------------------------------
10752:         *-- TextBoxes area ECF / Metal / Teor / Valor
10753:         *----------------------------------------------------------------------
10754:         *-- getDescEcfs: Descricao ECF (T:429 L:206 W:213 H:23)
10755:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
10756:         WITH loc_oPg.txt_4c_DescEcfs
10757:             .Top           = 429
10758:             .Left          = 206
10759:             .Width         = 213
10760:             .Height        = 23
10761:             .Value         = ""
10762:             .FontName      = "Tahoma"
10763:             .FontSize      = 8
10764:             .SpecialEffect = 1
10765:             .ForeColor     = RGB(36, 84, 155)
10766:             .MaxLength     = 29
10767:             .Enabled       = .F.
10768:             .Visible       = .T.
10769:         ENDWITH
10770: 
10771:         *-- Get_metal: Metal (T:429 L:537 W:24 H:23)

*-- Linhas 10783 a 10826:
10783:             .Enabled       = .F.
10784:             .Visible       = .T.
10785:         ENDWITH
10786:         BINDEVENT(loc_oPg.txt_4c_Metal, "LostFocus", THIS, "TxtMetalFiscLostFocus")
10787: 
10788:         *-- Get_DesMetal: Descricao Metal (T:429 L:564 W:150 H:23) readonly
10789:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
10790:         WITH loc_oPg.txt_4c_DesMetal
10791:             .Top           = 429
10792:             .Left          = 564
10793:             .Width         = 150
10794:             .Height        = 23
10795:             .Value         = ""
10796:             .FontName      = "Tahoma"
10797:             .FontSize      = 8
10798:             .SpecialEffect = 1
10799:             .ForeColor     = RGB(36, 84, 155)
10800:             .ReadOnly      = .T.
10801:             .Enabled       = .F.
10802:             .Visible       = .T.
10803:         ENDWITH
10804: 
10805:         *-- getValor: Valor Estimado (T:454 L:206 W:108 H:23) numeric
10806:         loc_oPg.AddObject("txt_4c_ValorEstim", "TextBox")
10807:         WITH loc_oPg.txt_4c_ValorEstim
10808:             .Top           = 454
10809:             .Left          = 206
10810:             .Width         = 108
10811:             .Height        = 23
10812:             .Value         = 0
10813:             .FontName      = "Tahoma"
10814:             .FontSize      = 8
10815:             .SpecialEffect = 1
10816:             .ForeColor     = RGB(36, 84, 155)
10817:             .Enabled       = .F.
10818:             .Visible       = .T.
10819:         ENDWITH
10820: 
10821:         *-- GetMvalor: Moeda do Valor (T:454 L:317 W:31 H:23) - lookup SigCdMoe
10822:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
10823:         WITH loc_oPg.txt_4c_Mvalor
10824:             .Top           = 454
10825:             .Left          = 317
10826:             .Width         = 31

*-- Linhas 10833 a 10893:
10833:             .Enabled       = .F.
10834:             .Visible       = .T.
10835:         ENDWITH
10836:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "LostFocus", THIS, "TxtMvalorFiscLostFocus")
10837: 
10838:         *-- Get_teor: Teor (T:454 L:537 W:24 H:23)
10839:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
10840:         WITH loc_oPg.txt_4c_Teor
10841:             .Top           = 454
10842:             .Left          = 537
10843:             .Width         = 24
10844:             .Height        = 23
10845:             .Value         = ""
10846:             .FontName      = "Tahoma"
10847:             .FontSize      = 8
10848:             .SpecialEffect = 1
10849:             .ForeColor     = RGB(36, 84, 155)
10850:             .Enabled       = .F.
10851:             .Visible       = .T.
10852:         ENDWITH
10853:         BINDEVENT(loc_oPg.txt_4c_Teor, "LostFocus", THIS, "TxtTeorFiscLostFocus")
10854: 
10855:         *-- Get_DesTeor: Descricao Teor (T:454 L:564 W:150 H:23) readonly
10856:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
10857:         WITH loc_oPg.txt_4c_DesTeor
10858:             .Top           = 454
10859:             .Left          = 564
10860:             .Width         = 150
10861:             .Height        = 23
10862:             .Value         = ""
10863:             .FontName      = "Tahoma"
10864:             .FontSize      = 8
10865:             .SpecialEffect = 1
10866:             .ForeColor     = RGB(36, 84, 155)
10867:             .ReadOnly      = .T.
10868:             .Enabled       = .F.
10869:             .Visible       = .T.
10870:         ENDWITH
10871: 
10872:         *-- getIPPTCST: IPPT/CST (T:479 L:206 W:108 H:23) readonly (When=.f.)
10873:         loc_oPg.AddObject("txt_4c_IpptCST", "TextBox")
10874:         WITH loc_oPg.txt_4c_IpptCST
10875:             .Top           = 479
10876:             .Left          = 206
10877:             .Width         = 108
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
10889:         *----------------------------------------------------------------------
10890:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10891:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10892:         *----------------------------------------------------------------------
10893:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")

*-- Linhas 10940 a 10983:
10940:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10941:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10942:     *--------------------------------------------------------------------------
10943:     PROTECTED PROCEDURE PreencherCamposFiscais()
10944:         LOCAL loc_oPg, loc_cIpiVal
10945:         TRY
10946:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10947:                 RETURN
10948:             ENDIF
10949:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10950:             IF VARTYPE(loc_oPg) # "O"
10951:                 RETURN
10952:             ENDIF
10953:             WITH THIS.this_oBusinessObject
10954:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
10955:                     loc_oPg.txt_4c_Gruccus.Value = ALLTRIM(.this_cGruccus)
10956:                 ENDIF
10957:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
10958:                     loc_oPg.txt_4c_Contaccus.Value = ALLTRIM(.this_cContaccus)
10959:                 ENDIF
10960:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
10961:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(.this_cClfiscals)
10962:                 ENDIF
10963:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
10964:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(.this_cOrigmercs)
10965:                 ENDIF
10966:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
10967:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(.this_cSittricms)
10968:                 ENDIF
10969:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
10970:                     loc_oPg.txt_4c_CodServs.Value = ALLTRIM(.this_cCodservs)
10971:                 ENDIF
10972:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
10973:                     loc_oPg.txt_4c_Icms.Value = .this_nIcms
10974:                 ENDIF
10975:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
10976:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(.this_cTptribs)
10977:                 ENDIF
10978:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
10979:                     loc_oPg.txt_4c_Iat.Value = ALLTRIM(.this_cIats)
10980:                 ENDIF
10981:                 *-- cmbIpi: converte this_cIpis (T/I/O/'') para texto do combo
10982:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
10983:                     DO CASE

*-- Linhas 11026 a 11069:
11026:     * LerCamposFiscais - Le controles de pgDadosFiscais e transfere para o BO
11027:     * Chamado por FormParaBO antes de salvar
11028:     *--------------------------------------------------------------------------
11029:     PROTECTED PROCEDURE LerCamposFiscais()
11030:         LOCAL loc_oPg, loc_cIpiTxt
11031:         TRY
11032:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11033:                 RETURN
11034:             ENDIF
11035:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11036:             IF VARTYPE(loc_oPg) # "O"
11037:                 RETURN
11038:             ENDIF
11039:             WITH THIS.this_oBusinessObject
11040:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11041:                     .this_cGruccus = ALLTRIM(loc_oPg.txt_4c_Gruccus.Value)
11042:                 ENDIF
11043:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11044:                     .this_cContaccus = ALLTRIM(loc_oPg.txt_4c_Contaccus.Value)
11045:                 ENDIF
11046:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11047:                     .this_cClfiscals = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
11048:                 ENDIF
11049:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
11050:                     .this_cOrigmercs = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
11051:                 ENDIF
11052:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
11053:                     .this_cSittricms = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
11054:                 ENDIF
11055:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11056:                     .this_cCodservs = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
11057:                 ENDIF
11058:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
11059:                     .this_nIcms = loc_oPg.txt_4c_Icms.Value
11060:                 ENDIF
11061:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
11062:                     .this_cTptribs = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
11063:                 ENDIF
11064:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11065:                     .this_cIats = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
11066:                 ENDIF
11067:                 *-- cmbIpi: converte texto para char(1)
11068:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
11069:                     loc_cIpiTxt = UPPER(LEFT(ALLTRIM(loc_oPg.cmb_4c_Ipi.Value), 1))

*-- Linhas 11106 a 11830:
11106:     *--------------------------------------------------------------------------
11107:     * TxtClfiscalFiscLostFocus - Lookup SigCdClf por Codigos
11108:     *--------------------------------------------------------------------------
11109:     PROCEDURE TxtClfiscalFiscLostFocus()
11110:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11111:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11112:             RETURN
11113:         ENDIF
11114:         *-- Guard: evita reabrir lookup se valor nao mudou
11115:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11116:             LOCAL loc_cGuardaClf
11117:             loc_cGuardaClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Clfiscal.Value, ""))
11118:             IF loc_cGuardaClf = THIS.this_cUltimoTxtClfiscalLostFocusValidado
11119:                 RETURN
11120:             ENDIF
11121:             THIS.this_cUltimoTxtClfiscalLostFocusValidado = loc_cGuardaClf
11122:         ENDIF
11123:         loc_lResultado = .T.
11124:         TRY
11125:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11126:                 loc_lResultado = .F.
11127:             ENDIF
11128:             IF loc_lResultado
11129:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11130:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11131:                 IF EMPTY(loc_cCod)
11132:                     THIS.this_oBusinessObject.this_cClfiscals = ""
11133:                     IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11134:                         loc_oPg.txt_4c_Dclfiscal.Value = ""
11135:                     ENDIF
11136:                     loc_lResultado = .F.
11137:                 ENDIF
11138:             ENDIF
11139:             IF loc_lResultado
11140:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11141:                     "SigCdClf", "cursor_4c_BuscaClf", "Codigos", loc_cCod, ;
11142:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11143:                 IF VARTYPE(loc_oBusca) = "O"
11144:                     IF !loc_oBusca.this_lAchouRegistro
11145:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11146:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11147:                         loc_oBusca.Show()
11148:                     ENDIF
11149:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11150:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11151:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11152:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11153:                         ENDIF
11154:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11155:                     ELSE
11156:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11157:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11158:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11159:                         ENDIF
11160:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11161:                     ENDIF
11162:                     loc_oBusca.Release()
11163:                 ENDIF
11164:                 IF USED("cursor_4c_BuscaClf")
11165:                     USE IN cursor_4c_BuscaClf
11166:                 ENDIF
11167:             ENDIF
11168:         CATCH TO loc_oErro
11169:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11170:         ENDTRY
11171:     ENDPROC
11172: 
11173:     *--------------------------------------------------------------------------
11174:     * TxtDclfiscalFiscLostFocus - Busca reversa SigCdClf por Descricaos
11175:     * Ativado quando getClfiscal esta vazio
11176:     *--------------------------------------------------------------------------
11177:     PROCEDURE TxtDclfiscalFiscLostFocus()
11178:         LOCAL loc_oPg, loc_oBusca, loc_cDesc, loc_lResultado
11179:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11180:             RETURN
11181:         ENDIF
11182:         *-- Guard: evita reabrir lookup se valor nao mudou
11183:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11184:             LOCAL loc_cGuardaDClf
11185:             loc_cGuardaDClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Dclfiscal.Value, ""))
11186:             IF loc_cGuardaDClf = THIS.this_cUltimoTxtDclfiscalLostFocusValidado
11187:                 RETURN
11188:             ENDIF
11189:             THIS.this_cUltimoTxtDclfiscalLostFocusValidado = loc_cGuardaDClf
11190:         ENDIF
11191:         loc_lResultado = .T.
11192:         TRY
11193:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11194:                 loc_lResultado = .F.
11195:             ENDIF
11196:             IF loc_lResultado
11197:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11198:                 *-- Apenas ativo quando codigo vazio
11199:                 IF NOT EMPTY(ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, "")))
11200:                     loc_lResultado = .F.
11201:                 ENDIF
11202:             ENDIF
11203:             IF loc_lResultado
11204:                 loc_cDesc = ALLTRIM(NVL(loc_oPg.txt_4c_Dclfiscal.Value, ""))
11205:                 IF EMPTY(loc_cDesc)
11206:                     loc_lResultado = .F.
11207:                 ENDIF
11208:             ENDIF
11209:             IF loc_lResultado
11210:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11211:                     "SigCdClf", "cursor_4c_BuscaClfR", "Descricaos", loc_cDesc, ;
11212:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11213:                 IF VARTYPE(loc_oBusca) = "O"
11214:                     IF !loc_oBusca.this_lAchouRegistro
11215:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11216:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11217:                         loc_oBusca.Show()
11218:                     ENDIF
11219:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11220:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11221:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11222:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11223:                     ENDIF
11224:                     loc_oBusca.Release()
11225:                 ENDIF
11226:                 IF USED("cursor_4c_BuscaClfR")
11227:                     USE IN cursor_4c_BuscaClfR
11228:                 ENDIF
11229:             ENDIF
11230:         CATCH TO loc_oErro
11231:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11232:         ENDTRY
11233:     ENDPROC
11234: 
11235:     *--------------------------------------------------------------------------
11236:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)
11237:     *--------------------------------------------------------------------------
11238:     PROCEDURE TxtOrigmercFiscLostFocus()
11239:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11240:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11241:             RETURN
11242:         ENDIF
11243:         *-- Guard: evita reabrir lookup se valor nao mudou
11244:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11245:             LOCAL loc_cGuardaOrg
11246:             loc_cGuardaOrg = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Origmerc.Value, ""))
11247:             IF loc_cGuardaOrg = THIS.this_cUltimoTxtOrigmercLostFocusValidado
11248:                 RETURN
11249:             ENDIF
11250:             THIS.this_cUltimoTxtOrigmercLostFocusValidado = loc_cGuardaOrg
11251:         ENDIF
11252:         loc_lResultado = .T.
11253:         TRY
11254:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11255:                 loc_lResultado = .F.
11256:             ENDIF
11257:             IF loc_lResultado
11258:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11259:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Origmerc.Value, ""))
11260:                 IF EMPTY(loc_cCod)
11261:                     THIS.this_oBusinessObject.this_cOrigmercs = ""
11262:                     IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11263:                         loc_oPg.txt_4c_Dorigmerc.Value = ""
11264:                     ENDIF
11265:                     loc_lResultado = .F.
11266:                 ENDIF
11267:             ENDIF
11268:             IF loc_lResultado
11269:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11270:                     "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", loc_cCod, ;
11271:                     "Buscar Origem da Mercadoria")
11272:                 IF VARTYPE(loc_oBusca) = "O"
11273:                     IF !loc_oBusca.this_lAchouRegistro
11274:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11275:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11276:                         loc_oBusca.Show()
11277:                     ENDIF
11278:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11279:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11280:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11281:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11282:                         ENDIF
11283:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11284:                     ELSE
11285:                         loc_oPg.txt_4c_Origmerc.Value = ""
11286:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11287:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11288:                         ENDIF
11289:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11290:                     ENDIF
11291:                     loc_oBusca.Release()
11292:                 ENDIF
11293:                 IF USED("cursor_4c_BuscaOrg")
11294:                     USE IN cursor_4c_BuscaOrg
11295:                 ENDIF
11296:             ENDIF
11297:         CATCH TO loc_oErro
11298:             MsgErro(loc_oErro.Message, "Erro ao buscar origem da mercadoria")
11299:         ENDTRY
11300:     ENDPROC
11301: 
11302:     *--------------------------------------------------------------------------
11303:     * TxtSittricmFiscLostFocus - Lookup SigCdIcm por Codigos (sit. trib. ICMS)
11304:     *--------------------------------------------------------------------------
11305:     PROCEDURE TxtSittricmFiscLostFocus()
11306:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11307:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11308:             RETURN
11309:         ENDIF
11310:         *-- Guard: evita reabrir lookup se valor nao mudou
11311:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11312:             LOCAL loc_cGuardaIcm
11313:             loc_cGuardaIcm = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Sittricm.Value, ""))
11314:             IF loc_cGuardaIcm = THIS.this_cUltimoTxtSittricmLostFocusValidado
11315:                 RETURN
11316:             ENDIF
11317:             THIS.this_cUltimoTxtSittricmLostFocusValidado = loc_cGuardaIcm
11318:         ENDIF
11319:         loc_lResultado = .T.
11320:         TRY
11321:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11322:                 loc_lResultado = .F.
11323:             ENDIF
11324:             IF loc_lResultado
11325:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11326:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Sittricm.Value, ""))
11327:                 IF EMPTY(loc_cCod)
11328:                     THIS.this_oBusinessObject.this_cSittricms = ""
11329:                     IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11330:                         loc_oPg.txt_4c_Dsittricm.Value = ""
11331:                     ENDIF
11332:                     loc_lResultado = .F.
11333:                 ENDIF
11334:             ENDIF
11335:             IF loc_lResultado
11336:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11337:                     "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", loc_cCod, ;
11338:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11339:                 IF VARTYPE(loc_oBusca) = "O"
11340:                     IF !loc_oBusca.this_lAchouRegistro
11341:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11342:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11343:                         loc_oBusca.Show()
11344:                     ENDIF
11345:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11346:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11347:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11348:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11349:                         ENDIF
11350:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11351:                     ELSE
11352:                         loc_oPg.txt_4c_Sittricm.Value = ""
11353:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11354:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11355:                         ENDIF
11356:                         THIS.this_oBusinessObject.this_cSittricms = ""
11357:                     ENDIF
11358:                     loc_oBusca.Release()
11359:                 ENDIF
11360:                 IF USED("cursor_4c_BuscaIcm")
11361:                     USE IN cursor_4c_BuscaIcm
11362:                 ENDIF
11363:             ENDIF
11364:         CATCH TO loc_oErro
11365:             MsgErro(loc_oErro.Message, "Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
11366:         ENDTRY
11367:     ENDPROC
11368: 
11369:     *--------------------------------------------------------------------------
11370:     * TxtCodServsFiscLostFocus - Armazena codigo de servicos no BO
11371:     *--------------------------------------------------------------------------
11372:     PROCEDURE TxtCodServsFiscLostFocus()
11373:         LOCAL loc_oPg
11374:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11375:             RETURN
11376:         ENDIF
11377:         TRY
11378:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11379:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11380:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11381:                     THIS.this_oBusinessObject.this_cCodservs = ALLTRIM(NVL(loc_oPg.txt_4c_CodServs.Value, ""))
11382:                 ENDIF
11383:             ENDIF
11384:         CATCH TO loc_oErro
11385:             MsgErro(loc_oErro.Message, "Erro ao atualizar c" + CHR(243) + "digo de servi" + CHR(231) + "os")
11386:         ENDTRY
11387:     ENDPROC
11388: 
11389:     *--------------------------------------------------------------------------
11390:     * TxtTpTribFiscLostFocus - Lookup SigPrTri por Tipos (tipo tributacao)
11391:     *--------------------------------------------------------------------------
11392:     PROCEDURE TxtTpTribFiscLostFocus()
11393:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11394:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11395:             RETURN
11396:         ENDIF
11397:         *-- Guard: evita reabrir lookup se valor nao mudou
11398:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11399:             LOCAL loc_cGuardaTri
11400:             loc_cGuardaTri = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_TpTrib.Value, ""))
11401:             IF loc_cGuardaTri = THIS.this_cUltimoTxtTpTribLostFocusValidado
11402:                 RETURN
11403:             ENDIF
11404:             THIS.this_cUltimoTxtTpTribLostFocusValidado = loc_cGuardaTri
11405:         ENDIF
11406:         loc_lResultado = .T.
11407:         TRY
11408:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11409:                 loc_lResultado = .F.
11410:             ENDIF
11411:             IF loc_lResultado
11412:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11413:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_TpTrib.Value, ""))
11414:                 IF EMPTY(loc_cCod)
11415:                     THIS.this_oBusinessObject.this_cTptribs = ""
11416:                     loc_lResultado = .F.
11417:                 ENDIF
11418:             ENDIF
11419:             IF loc_lResultado
11420:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11421:                     "SigPrTri", "cursor_4c_BuscaTri", "Tipos", loc_cCod, ;
11422:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11423:                 IF VARTYPE(loc_oBusca) = "O"
11424:                     IF !loc_oBusca.this_lAchouRegistro
11425:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11426:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11427:                         loc_oBusca.Show()
11428:                     ENDIF
11429:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11430:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11431:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11432:                     ELSE
11433:                         loc_oPg.txt_4c_TpTrib.Value = ""
11434:                         THIS.this_oBusinessObject.this_cTptribs = ""
11435:                     ENDIF
11436:                     loc_oBusca.Release()
11437:                 ENDIF
11438:                 IF USED("cursor_4c_BuscaTri")
11439:                     USE IN cursor_4c_BuscaTri
11440:                 ENDIF
11441:             ENDIF
11442:         CATCH TO loc_oErro
11443:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11444:         ENDTRY
11445:     ENDPROC
11446: 
11447:     *--------------------------------------------------------------------------
11448:     * TxtIatFiscLostFocus - Valida IAT: apenas 'A', 'T' ou vazio
11449:     *--------------------------------------------------------------------------
11450:     PROCEDURE TxtIatFiscLostFocus()
11451:         LOCAL loc_oPg, loc_cVal
11452:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11453:             RETURN
11454:         ENDIF
11455:         TRY
11456:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11457:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11458:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11459:                     loc_cVal = UPPER(ALLTRIM(NVL(loc_oPg.txt_4c_Iat.Value, "")))
11460:                     IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
11461:                         MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11462:                             "Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
11463:                         loc_oPg.txt_4c_Iat.Value = ""
11464:                         THIS.this_oBusinessObject.this_cIats = ""
11465:                     ELSE
11466:                         THIS.this_oBusinessObject.this_cIats = loc_cVal
11467:                     ENDIF
11468:                 ENDIF
11469:             ENDIF
11470:         CATCH TO loc_oErro
11471:             MsgErro(loc_oErro.Message, "Erro ao validar IAT")
11472:         ENDTRY
11473:     ENDPROC
11474: 
11475:     *--------------------------------------------------------------------------
11476:     * TxtMvalorFiscLostFocus - Lookup SigCdMoe por CMoes (moeda do valor)
11477:     *--------------------------------------------------------------------------
11478:     PROCEDURE TxtMvalorFiscLostFocus()
11479:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11480:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11481:             RETURN
11482:         ENDIF
11483:         *-- Guard: evita reabrir lookup se valor nao mudou
11484:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11485:             LOCAL loc_cGuardaMoe
11486:             loc_cGuardaMoe = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Mvalor.Value, ""))
11487:             IF loc_cGuardaMoe = THIS.this_cUltimoTxtMvalorLostFocusValidado
11488:                 RETURN
11489:             ENDIF
11490:             THIS.this_cUltimoTxtMvalorLostFocusValidado = loc_cGuardaMoe
11491:         ENDIF
11492:         loc_lResultado = .T.
11493:         TRY
11494:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11495:                 loc_lResultado = .F.
11496:             ENDIF
11497:             IF loc_lResultado
11498:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11499:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Mvalor.Value, ""))
11500:                 IF EMPTY(loc_cCod)
11501:                     THIS.this_oBusinessObject.this_cMoedas = ""
11502:                     loc_lResultado = .F.
11503:                 ENDIF
11504:             ENDIF
11505:             IF loc_lResultado
11506:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11507:                     "SigCdMoe", "cursor_4c_BuscaMoeFisc", "cmoes", loc_cCod, ;
11508:                     "Buscar Moeda")
11509:                 IF VARTYPE(loc_oBusca) = "O"
11510:                     IF !loc_oBusca.this_lAchouRegistro
11511:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11512:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11513:                         loc_oBusca.Show()
11514:                     ENDIF
11515:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11516:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11517:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11518:                     ELSE
11519:                         loc_oPg.txt_4c_Mvalor.Value = ""
11520:                         THIS.this_oBusinessObject.this_cMoedas = ""
11521:                     ENDIF
11522:                     loc_oBusca.Release()
11523:                 ENDIF
11524:                 IF USED("cursor_4c_BuscaMoeFisc")
11525:                     USE IN cursor_4c_BuscaMoeFisc
11526:                 ENDIF
11527:             ENDIF
11528:         CATCH TO loc_oErro
11529:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11530:         ENDTRY
11531:     ENDPROC
11532: 
11533:     *--------------------------------------------------------------------------
11534:     * TxtMetalFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos='M'
11535:     *--------------------------------------------------------------------------
11536:     PROCEDURE TxtMetalFiscLostFocus()
11537:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11538:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11539:             RETURN
11540:         ENDIF
11541:         *-- Guard: evita reabrir lookup se valor nao mudou
11542:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11543:             LOCAL loc_cGuardaMtl
11544:             loc_cGuardaMtl = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Metal.Value, ""))
11545:             IF loc_cGuardaMtl = THIS.this_cUltimoTxtMetalLostFocusValidado
11546:                 RETURN
11547:             ENDIF
11548:             THIS.this_cUltimoTxtMetalLostFocusValidado = loc_cGuardaMtl
11549:         ENDIF
11550:         loc_lResultado = .T.
11551:         TRY
11552:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11553:                 loc_lResultado = .F.
11554:             ENDIF
11555:             IF loc_lResultado
11556:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11557:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Metal.Value, ""))
11558:                 IF EMPTY(loc_cCod)
11559:                     THIS.this_oBusinessObject.this_cMetals = ""
11560:                     IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11561:                         loc_oPg.txt_4c_DesMetal.Value = ""
11562:                     ENDIF
11563:                     loc_lResultado = .F.
11564:                 ENDIF
11565:             ENDIF
11566:             IF loc_lResultado
11567:                 *-- Carregar lista de metais (Tipos='M') para lookup
11568:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11569:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11570:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11571:                     *-- Verificar se codigo existe diretamente
11572:                     SELECT cursor_4c_BuscaMtlM
11573:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11574:                     IF !EOF("cursor_4c_BuscaMtlM")
11575:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11576:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11577:                         ENDIF
11578:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11579:                     ELSE
11580:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11581:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11582:                             "Buscar Metal")
11583:                         IF VARTYPE(loc_oBusca) = "O"
11584:                             IF !loc_oBusca.this_lAchouRegistro
11585:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11586:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11587:                                 loc_oBusca.Show()
11588:                             ENDIF
11589:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11590:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11591:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11592:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11593:                                 ENDIF
11594:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11595:                             ELSE
11596:                                 loc_oPg.txt_4c_Metal.Value = ""
11597:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11598:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11599:                                 ENDIF
11600:                                 THIS.this_oBusinessObject.this_cMetals = ""
11601:                             ENDIF
11602:                             loc_oBusca.Release()
11603:                         ENDIF
11604:                         IF USED("cursor_4c_BuscaMtlSel")
11605:                             USE IN cursor_4c_BuscaMtlSel
11606:                         ENDIF
11607:                     ENDIF
11608:                     USE IN cursor_4c_BuscaMtlM
11609:                 ENDIF
11610:             ENDIF
11611:         CATCH TO loc_oErro
11612:             MsgErro(loc_oErro.Message, "Erro ao buscar metal")
11613:         ENDTRY
11614:     ENDPROC
11615: 
11616:     *--------------------------------------------------------------------------
11617:     * TxtTeorFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos<>'M'
11618:     *--------------------------------------------------------------------------
11619:     PROCEDURE TxtTeorFiscLostFocus()
11620:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11621:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11622:             RETURN
11623:         ENDIF
11624:         *-- Guard: evita reabrir lookup se valor nao mudou
11625:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11626:             LOCAL loc_cGuardaTeor
11627:             loc_cGuardaTeor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Teor.Value, ""))
11628:             IF loc_cGuardaTeor = THIS.this_cUltimoTxtTeorLostFocusValidado
11629:                 RETURN
11630:             ENDIF
11631:             THIS.this_cUltimoTxtTeorLostFocusValidado = loc_cGuardaTeor
11632:         ENDIF
11633:         loc_lResultado = .T.
11634:         TRY
11635:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11636:                 loc_lResultado = .F.
11637:             ENDIF
11638:             IF loc_lResultado
11639:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11640:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Teor.Value, ""))
11641:                 IF EMPTY(loc_cCod)
11642:                     THIS.this_oBusinessObject.this_cTeors = ""
11643:                     IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11644:                         loc_oPg.txt_4c_DesTeor.Value = ""
11645:                     ENDIF
11646:                     loc_lResultado = .F.
11647:                 ENDIF
11648:             ENDIF
11649:             IF loc_lResultado
11650:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11651:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11652:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11653:                     SELECT cursor_4c_BuscaMtlT
11654:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11655:                     IF !EOF("cursor_4c_BuscaMtlT")
11656:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11657:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11658:                         ENDIF
11659:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11660:                     ELSE
11661:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11662:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11663:                             "Buscar Teor")
11664:                         IF VARTYPE(loc_oBusca) = "O"
11665:                             IF !loc_oBusca.this_lAchouRegistro
11666:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11667:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11668:                                 loc_oBusca.Show()
11669:                             ENDIF
11670:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11671:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11672:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11673:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11674:                                 ENDIF
11675:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11676:                             ELSE
11677:                                 loc_oPg.txt_4c_Teor.Value = ""
11678:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11679:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11680:                                 ENDIF
11681:                                 THIS.this_oBusinessObject.this_cTeors = ""
11682:                             ENDIF
11683:                             loc_oBusca.Release()
11684:                         ENDIF
11685:                         IF USED("cursor_4c_BuscaTeorSel")
11686:                             USE IN cursor_4c_BuscaTeorSel
11687:                         ENDIF
11688:                     ENDIF
11689:                     USE IN cursor_4c_BuscaMtlT
11690:                 ENDIF
11691:             ENDIF
11692:         CATCH TO loc_oErro
11693:             MsgErro(loc_oErro.Message, "Erro ao buscar teor")
11694:         ENDTRY
11695:     ENDPROC
11696: 
11697:     *--------------------------------------------------------------------------
11698:     * TxtGruccusFiscLostFocus - Armazena grupo de custo no BO
11699:     *--------------------------------------------------------------------------
11700:     PROCEDURE TxtGruccusFiscLostFocus()
11701:         LOCAL loc_oPg
11702:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11703:             RETURN
11704:         ENDIF
11705:         TRY
11706:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11707:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11708:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11709:                     THIS.this_oBusinessObject.this_cGruccus = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
11710:                 ENDIF
11711:             ENDIF
11712:         CATCH TO loc_oErro
11713:             MsgErro(loc_oErro.Message, "Erro ao atualizar grupo de custo")
11714:         ENDTRY
11715:     ENDPROC
11716: 
11717:     *--------------------------------------------------------------------------
11718:     * TxtContaccusFiscLostFocus - Armazena conta de custo no BO
11719:     *--------------------------------------------------------------------------
11720:     PROCEDURE TxtContaccusFiscLostFocus()
11721:         LOCAL loc_oPg
11722:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11723:             RETURN
11724:         ENDIF
11725:         TRY
11726:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11727:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11728:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11729:                     THIS.this_oBusinessObject.this_cContaccus = ALLTRIM(NVL(loc_oPg.txt_4c_Contaccus.Value, ""))
11730:                 ENDIF
11731:             ENDIF
11732:         CATCH TO loc_oErro
11733:             MsgErro(loc_oErro.Message, "Erro ao atualizar conta de custo")
11734:         ENDTRY
11735:     ENDPROC
11736: 
11737:     *--------------------------------------------------------------------------
11738:     * CmdDescFisClick - Gerar Descricao Fiscal automatica
11739:     * Legado: fGerDescFis(0, crSigCdPro.CPros, ThisForm.poDataMgr)
11740:     *--------------------------------------------------------------------------
11741:     PROCEDURE CmdDescFisClick()
11742:         LOCAL loc_oPg, loc_cCpro
11743:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11744:             RETURN
11745:         ENDIF
11746:         TRY
11747:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11748:                 RETURN
11749:             ENDIF
11750:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11751:             loc_cCpro = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11752:             IF EMPTY(loc_cCpro)
11753:                 MsgAviso("Informe o c" + CHR(243) + "digo do produto antes de gerar a descri" + ;
11754:                     CHR(231) + CHR(227) + "o fiscal.", "Aten" + CHR(231) + CHR(227) + "o")
11755:                 RETURN
11756:             ENDIF
11757:             *-- Gerar descricao fiscal a partir dos campos fiscais
11758:             *-- Legado usa fGerDescFis() - funcao de framework nao disponivel
11759:             *-- Implementacao simplificada: combina classificacao + origem + ICMS
11760:             LOCAL loc_cDescFis
11761:             loc_cDescFis = ""
11762:             IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11763:                 loc_cDescFis = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11764:             ENDIF
11765:             IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O" AND !EMPTY(loc_oPg.txt_4c_Dclfiscal.Value)
11766:                 IF !EMPTY(loc_cDescFis)
11767:                     loc_cDescFis = loc_cDescFis + " - "
11768:                 ENDIF
11769:                 loc_cDescFis = loc_cDescFis + ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
11770:             ENDIF
11771:             IF !EMPTY(loc_cDescFis)
11772:                 IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
11773:                     loc_oPg.obj_4c_Descfis.Value = loc_cDescFis
11774:                     THIS.this_oBusinessObject.this_cDescfis = loc_cDescFis
11775:                 ENDIF
11776:             ELSE
11777:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
11778:             ENDIF
11779:         CATCH TO loc_oErro
11780:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11781:         ENDTRY
11782:     ENDPROC
11783: 
11784:     *==========================================================================
11785:     * FASE 14 - Aba Designer (pgDesigner - Page7 do pgf_4c_Dados)
11786:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
11787:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11788:     * Controles: 2 grids (4col + 1col), 1 editbox, 1 label, 3 buttons, 1 image, 1 shape
11789:     *==========================================================================
11790:     PROTECTED PROCEDURE ConfigurarPgPgDesigner()
11791:         LOCAL loc_oPg, loc_oGrd
11792:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11793: 
11794:         *----------------------------------------------------------------------
11795:         *-- Cursor placeholder cursor_4c_SigPrTar (SigPrTar - Tarefas Designer)
11796:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11797:         *----------------------------------------------------------------------
11798:         IF !USED("cursor_4c_SigPrTar")
11799:             SET NULL ON
11800:             CREATE CURSOR cursor_4c_SigPrTar (;
11801:                 DtInis  D NULL, ;
11802:                 DtFims  D NULL, ;
11803:                 Usuars  C(10), ;
11804:                 Tarefas C(10), ;
11805:                 ObsTars M)
11806:             SET NULL OFF
11807:         ENDIF
11808: 
11809:         *----------------------------------------------------------------------
11810:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11811:         *-- Campos: Arquivos
11812:         *----------------------------------------------------------------------
11813:         IF !USED("cursor_4c_SigPrArq")
11814:             SET NULL ON
11815:             CREATE CURSOR cursor_4c_SigPrArq (;
11816:                 Arquivos C(200))
11817:             SET NULL OFF
11818:         ENDIF
11819: 
11820:         *----------------------------------------------------------------------
11821:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11822:         *----------------------------------------------------------------------
11823:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11824:         WITH loc_oPg.shp_4c_ArqFundo
11825:             .Top         = 415
11826:             .Left        = 584
11827:             .Width       = 407
11828:             .Height      = 202
11829:             .BackColor   = RGB(230, 230, 230)
11830:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11910 a 12556:
11910:             .Column4.Resizable         = .F.
11911:             .Column4.ReadOnly          = .F.
11912:         ENDWITH
11913:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11914: 
11915:         *----------------------------------------------------------------------
11916:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11917:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11918:         *----------------------------------------------------------------------
11919:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11920:         WITH loc_oPg.obj_4c_ObsTarefas
11921:             .Top              = 160
11922:             .Left             = 584
11923:             .Width            = 407
11924:             .Height           = 238
11925:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11926:             .FontName         = "Tahoma"
11927:             .FontSize         = 8
11928:             .SpecialEffect    = 1
11929:             .ForeColor        = RGB(36, 84, 155)
11930:             .Enabled          = .T.
11931:             .Visible          = .T.
11932:         ENDWITH
11933: 
11934:         *----------------------------------------------------------------------
11935:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11936:         *----------------------------------------------------------------------
11937:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11938:         WITH loc_oPg.cmd_4c_IniTarefa
11939:             .Top             = 168
11940:             .Left            = 509
11941:             .Width           = 42
11942:             .Height          = 42
11943:             .Caption         = ""
11944:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11945:             .FontName        = "Tahoma"
11946:             .FontSize        = 8
11947:             .Themes          = .F.
11948:             .ToolTipText     = "Iniciar Nova Tarefa"
11949:             .Enabled         = .F.
11950:             .Visible         = .T.
11951:         ENDWITH
11952:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
11953: 
11954:         *----------------------------------------------------------------------
11955:         *-- btnFimTarefa: Encerrar Tarefa (T:203 L:509 W:42 H:42)
11956:         *----------------------------------------------------------------------
11957:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
11958:         WITH loc_oPg.cmd_4c_FimTarefa
11959:             .Top             = 203
11960:             .Left            = 509
11961:             .Width           = 42
11962:             .Height          = 42
11963:             .Caption         = ""
11964:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.bmp"
11965:             .FontName        = "Tahoma"
11966:             .FontSize        = 8
11967:             .Themes          = .F.
11968:             .ToolTipText     = "Encerrar Tarefa"
11969:             .Enabled         = .F.
11970:             .Visible         = .T.
11971:         ENDWITH
11972:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
11973: 
11974:         *----------------------------------------------------------------------
11975:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
11976:         *----------------------------------------------------------------------
11977:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
11978:         WITH loc_oPg.grd_4c_Arquivos
11979:             .Top         = 415
11980:             .Left        = 10
11981:             .Width       = 495
11982:             .Height      = 202
11983:             .ColumnCount = 1
11984:             .FontName    = "Tahoma"
11985:             .FontSize    = 8
11986:             .DeleteMark  = .F.
11987:             .ScrollBars  = 2
11988:             .ReadOnly    = .T.
11989:             .Themes      = .F.
11990:             .Visible     = .T.
11991:             .RecordMark   = .F.
11992:         ENDWITH
11993:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
11994:         WITH loc_oPg.grd_4c_Arquivos
11995:             .Column1.ControlSource     = "cursor_4c_SigPrArq.Arquivos"
11996:             .Column1.Header1.Caption   = "Arquivos Para Designer"
11997:             .Column1.Header1.FontName  = "Tahoma"
11998:             .Column1.Header1.FontSize  = 8
11999:             .Column1.Header1.Alignment = 2
12000:             .Column1.Width             = 464
12001:             .Column1.Movable           = .F.
12002:             .Column1.Resizable         = .F.
12003:             .Column1.ReadOnly          = .T.
12004:         ENDWITH
12005:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12006: 
12007:         *----------------------------------------------------------------------
12008:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12009:         *----------------------------------------------------------------------
12010:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
12011:         WITH loc_oPg.cmd_4c_InsArqs
12012:             .Top             = 416
12013:             .Left            = 509
12014:             .Width           = 42
12015:             .Height          = 42
12016:             .Caption         = ""
12017:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
12018:             .FontName        = "Tahoma"
12019:             .FontSize        = 8
12020:             .Themes          = .F.
12021:             .ToolTipText     = "Inserir Arquivo"
12022:             .Enabled         = .F.
12023:             .Visible         = .T.
12024:         ENDWITH
12025:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
12026: 
12027:         *----------------------------------------------------------------------
12028:         *-- btnOpnArqs: Abrir Arquivo (T:500 L:509 W:42 H:42)
12029:         *----------------------------------------------------------------------
12030:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
12031:         WITH loc_oPg.cmd_4c_OpnArqs
12032:             .Top             = 500
12033:             .Left            = 509
12034:             .Width           = 42
12035:             .Height          = 42
12036:             .Caption         = ""
12037:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.bmp"
12038:             .FontName        = "Tahoma"
12039:             .FontSize        = 8
12040:             .Themes          = .F.
12041:             .ToolTipText     = "Abrir Arquivo"
12042:             .Enabled         = .T.
12043:             .Visible         = .T.
12044:         ENDWITH
12045:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
12046: 
12047:         *----------------------------------------------------------------------
12048:         *-- btnExcArqs: Excluir Arquivo (T:458 L:509 W:42 H:42)
12049:         *----------------------------------------------------------------------
12050:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
12051:         WITH loc_oPg.cmd_4c_ExcArqs
12052:             .Top             = 458
12053:             .Left            = 509
12054:             .Width           = 42
12055:             .Height          = 42
12056:             .Caption         = ""
12057:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.bmp"
12058:             .FontName        = "Tahoma"
12059:             .FontSize        = 8
12060:             .Themes          = .F.
12061:             .ToolTipText     = "Excluir Arquivo"
12062:             .Enabled         = .F.
12063:             .Visible         = .T.
12064:         ENDWITH
12065:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
12066: 
12067:         *----------------------------------------------------------------------
12068:         *-- imgArqJpg: Imagem do arquivo (T:417 L:586 W:403 H:198)
12069:         *----------------------------------------------------------------------
12070:         loc_oPg.AddObject("img_4c_ArqJpg", "Image")
12071:         WITH loc_oPg.img_4c_ArqJpg
12072:             .Top         = 417
12073:             .Left        = 586
12074:             .Width       = 403
12075:             .Height      = 198
12076:             .Stretch     = 1
12077:             .Visible     = .F.
12078:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
12079:         ENDWITH
12080:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
12081: 
12082:         *----------------------------------------------------------------------
12083:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
12084:         *----------------------------------------------------------------------
12085:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12086:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12087:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12088: 
12089:         *----------------------------------------------------------------------
12090:         *-- Binding When para EditBox Obs da Tarefa
12091:         *----------------------------------------------------------------------
12092:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12093: 
12094:         *----------------------------------------------------------------------
12095:         *-- Bindings When para botoes de tarefa
12096:         *----------------------------------------------------------------------
12097:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12098:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12099: 
12100:         *----------------------------------------------------------------------
12101:         *-- Binding When para Column1 do grdArquivos
12102:         *----------------------------------------------------------------------
12103:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12104: 
12105:         *----------------------------------------------------------------------
12106:         *-- Bindings When para botoes de arquivo
12107:         *----------------------------------------------------------------------
12108:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12109:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12110:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12111:     ENDPROC
12112: 
12113:     *--------------------------------------------------------------------------
12114:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12115:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12116:     *--------------------------------------------------------------------------
12117:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12118:         LOCAL loc_oPg
12119:         TRY
12120:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12121:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12122:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12123:                     *-- Sincronizar editbox com observacao da tarefa selecionada
12124:                     IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12125:                         loc_oPg.obj_4c_ObsTarefas.Value = NVL(cursor_4c_SigPrTar.ObsTars, "")
12126:                     ELSE
12127:                         loc_oPg.obj_4c_ObsTarefas.Value = ""
12128:                     ENDIF
12129:                     loc_oPg.obj_4c_ObsTarefas.Refresh()
12130:                 ENDIF
12131:             ENDIF
12132:         CATCH TO loc_oErro
12133:             MsgErro(loc_oErro.Message, "Erro ao atualizar observa" + CHR(231) + CHR(227) + "o da tarefa")
12134:         ENDTRY
12135:     ENDPROC
12136: 
12137:     *--------------------------------------------------------------------------
12138:     * GrdArquivosAfterRowColChange - Mostra imagem do arquivo selecionado
12139:     * Legado: grdArquivos.Procedure (AfterRowColChange) ? mostra imagem JPG/BMP
12140:     *--------------------------------------------------------------------------
12141:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
12142:         LOCAL loc_oPg, loc_cArq, loc_cExt
12143:         TRY
12144:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12145:                 RETURN
12146:             ENDIF
12147:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12148:             IF VARTYPE(loc_oPg.img_4c_ArqJpg) # "O"
12149:                 RETURN
12150:             ENDIF
12151:             CLEAR RESOURCES
12152:             loc_oPg.img_4c_ArqJpg.Picture = ""
12153:             loc_oPg.img_4c_ArqJpg.Visible = .F.
12154:             IF USED("cursor_4c_SigPrArq") AND !EOF("cursor_4c_SigPrArq")
12155:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12156:                 IF !EMPTY(loc_cArq) AND AT(".", loc_cArq) > 0
12157:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12158:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12159:                         loc_oPg.img_4c_ArqJpg.Picture  = loc_cArq
12160:                         loc_oPg.img_4c_ArqJpg.Visible  = .T.
12161:                     ENDIF
12162:                 ENDIF
12163:             ENDIF
12164:         CATCH TO loc_oErro
12165:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem do arquivo")
12166:         ENDTRY
12167:     ENDPROC
12168: 
12169:     *--------------------------------------------------------------------------
12170:     * BtnIniTarefaClick - Inicia nova tarefa para o usuario logado
12171:     * Legado: btnIniTarefa.Click - verifica tarefa nao encerrada, insere novo registro
12172:     *--------------------------------------------------------------------------
12173:     PROCEDURE BtnIniTarefaClick()
12174:         LOCAL loc_lResultado
12175:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12176:             RETURN
12177:         ENDIF
12178:         loc_lResultado = .T.
12179:         TRY
12180:             IF !USED("cursor_4c_SigPrTar")
12181:                 loc_lResultado = .F.
12182:             ENDIF
12183:             IF loc_lResultado
12184:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12185:                 SELECT cursor_4c_SigPrTar
12186:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12187:                     AND EMPTY(NVL(DtFims, {}))
12188:                 IF !EOF("cursor_4c_SigPrTar")
12189:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12190:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12191:                     loc_lResultado = .F.
12192:                 ENDIF
12193:             ENDIF
12194:             IF loc_lResultado
12195:                 *-- Verificar se existe tarefa sem codigo informado
12196:                 SELECT cursor_4c_SigPrTar
12197:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12198:                     AND EMPTY(Tarefas)
12199:                 IF !EOF("cursor_4c_SigPrTar")
12200:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12201:                     loc_lResultado = .F.
12202:                 ENDIF
12203:             ENDIF
12204:             IF loc_lResultado
12205:                 *-- Inserir nova tarefa com data/hora de inicio
12206:                 SELECT cursor_4c_SigPrTar
12207:                 APPEND BLANK
12208:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12209:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12210:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12211:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12212:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12213:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12214:                 ENDIF
12215:             ENDIF
12216:         CATCH TO loc_oErro
12217:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12218:         ENDTRY
12219:     ENDPROC
12220: 
12221:     *--------------------------------------------------------------------------
12222:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12223:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12224:     *--------------------------------------------------------------------------
12225:     PROCEDURE BtnFimTarefaClick()
12226:         LOCAL loc_lResultado
12227:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12228:             RETURN
12229:         ENDIF
12230:         loc_lResultado = .T.
12231:         TRY
12232:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12233:                 loc_lResultado = .F.
12234:             ENDIF
12235:             IF loc_lResultado
12236:                 IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) # ALLTRIM(gc_4c_UsuarioLogado)
12237:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12238:                     loc_lResultado = .F.
12239:                 ENDIF
12240:             ENDIF
12241:             IF loc_lResultado
12242:                 IF !EMPTY(cursor_4c_SigPrTar.DtFims)
12243:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", "Aten" + CHR(231) + CHR(227) + "o")
12244:                     loc_lResultado = .F.
12245:                 ENDIF
12246:             ENDIF
12247:             IF loc_lResultado
12248:                 SELECT cursor_4c_SigPrTar
12249:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12250:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12251:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12252:                 ENDIF
12253:             ENDIF
12254:         CATCH TO loc_oErro
12255:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12256:         ENDTRY
12257:     ENDPROC
12258: 
12259:     *--------------------------------------------------------------------------
12260:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12261:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12262:     *--------------------------------------------------------------------------
12263:     PROCEDURE BtnInsArqsClick()
12264:         LOCAL loc_cArq, loc_lResultado
12265:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12266:             RETURN
12267:         ENDIF
12268:         loc_lResultado = .T.
12269:         TRY
12270:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12271:             IF EMPTY(loc_cArq)
12272:                 loc_lResultado = .F.
12273:             ENDIF
12274:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12275:                 SELECT cursor_4c_SigPrArq
12276:                 APPEND BLANK
12277:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12278:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12279:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12280:                 ENDIF
12281:             ENDIF
12282:         CATCH TO loc_oErro
12283:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12284:         ENDTRY
12285:     ENDPROC
12286: 
12287:     *--------------------------------------------------------------------------
12288:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12289:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12290:     *--------------------------------------------------------------------------
12291:     PROCEDURE BtnOpnArqsClick()
12292:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12293:         loc_lResultado = .T.
12294:         TRY
12295:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12296:                 loc_lResultado = .F.
12297:             ENDIF
12298:             IF loc_lResultado
12299:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12300:                 IF EMPTY(loc_cArq)
12301:                     loc_lResultado = .F.
12302:                 ENDIF
12303:             ENDIF
12304:             IF loc_lResultado
12305:                 IF !FILE(loc_cArq)
12306:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, "Aten" + CHR(231) + CHR(227) + "o")
12307:                     loc_lResultado = .F.
12308:                 ENDIF
12309:             ENDIF
12310:             IF loc_lResultado
12311:                 loc_oApp = CREATEOBJECT("Shell.Application")
12312:                 IF VARTYPE(loc_oApp) = "O"
12313:                     loc_oApp.Open(loc_cArq)
12314:                 ENDIF
12315:             ENDIF
12316:         CATCH TO loc_oErro
12317:             MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
12318:         ENDTRY
12319:     ENDPROC
12320: 
12321:     *--------------------------------------------------------------------------
12322:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12323:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12324:     *--------------------------------------------------------------------------
12325:     PROCEDURE BtnExcArqsClick()
12326:         LOCAL loc_lResultado
12327:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12328:             RETURN
12329:         ENDIF
12330:         loc_lResultado = .T.
12331:         TRY
12332:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12333:                 loc_lResultado = .F.
12334:             ENDIF
12335:             IF loc_lResultado
12336:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12337:                     loc_lResultado = .F.
12338:                 ENDIF
12339:             ENDIF
12340:             IF loc_lResultado
12341:                 SELECT cursor_4c_SigPrArq
12342:                 DELETE
12343:                 IF !EOF("cursor_4c_SigPrArq")
12344:                     SKIP
12345:                     SKIP -1
12346:                 ENDIF
12347:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12348:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12349:                 ENDIF
12350:                 *-- Limpar imagem ao excluir arquivo
12351:                 LOCAL loc_oPg
12352:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12353:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12354:                     CLEAR RESOURCES
12355:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12356:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12357:                 ENDIF
12358:             ENDIF
12359:         CATCH TO loc_oErro
12360:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12361:         ENDTRY
12362:     ENDPROC
12363: 
12364:     *--------------------------------------------------------------------------
12365:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12366:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12367:     *--------------------------------------------------------------------------
12368:     PROCEDURE ImgArqJpgClick()
12369:         LOCAL loc_cArq, loc_cExt, loc_lResultado
12370:         loc_lResultado = .T.
12371:         TRY
12372:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12373:                 loc_lResultado = .F.
12374:             ENDIF
12375:             IF loc_lResultado
12376:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12377:                 IF EMPTY(loc_cArq) OR !FILE(loc_cArq)
12378:                     loc_lResultado = .F.
12379:                 ENDIF
12380:             ENDIF
12381:             IF loc_lResultado
12382:                 IF AT(".", loc_cArq) > 0
12383:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12384:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12385:                         *-- Tentar abrir zoom form se disponivel
12386:                         IF PEMSTATUS("FormSigOpZom", "NAME", 5) OR FILE(gc_4c_CaminhoForms + "SigOpZom.prg")
12387:                             DO FORM (gc_4c_CaminhoForms + "SigOpZom") WITH loc_cArq, "Arquivo : " + loc_cArq
12388:                         ELSE
12389:                             *-- Fallback: abrir com aplicativo padrao do SO
12390:                             LOCAL loc_oApp
12391:                             loc_oApp = CREATEOBJECT("Shell.Application")
12392:                             IF VARTYPE(loc_oApp) = "O"
12393:                                 loc_oApp.Open(loc_cArq)
12394:                             ENDIF
12395:                         ENDIF
12396:                     ENDIF
12397:                 ENDIF
12398:             ENDIF
12399:         CATCH TO loc_oErro
12400:             MsgErro(loc_oErro.Message, "Erro ao abrir imagem em zoom")
12401:         ENDTRY
12402:     ENDPROC
12403: 
12404:     *--------------------------------------------------------------------------
12405:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12406:     * Legado: grdDesigner.Column4.Text1.When
12407:     *--------------------------------------------------------------------------
12408:     PROCEDURE GrdDesignerCol4When()
12409:         LOCAL loc_lResult
12410:         loc_lResult = .F.
12411:         TRY
12412:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12413:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12414:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12415:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12416:                         loc_lResult = .T.
12417:                     ENDIF
12418:                 ENDIF
12419:             ENDIF
12420:         CATCH TO loc_oErro
12421:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12422:         ENDTRY
12423:         RETURN loc_lResult
12424:     ENDPROC
12425: 
12426:     *--------------------------------------------------------------------------
12427:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12428:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12429:     *--------------------------------------------------------------------------
12430:     PROCEDURE GrdDesignerCol4Valid()
12431:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12432:         loc_lResult = .T.
12433:         TRY
12434:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12435:                 loc_lResultado = .T.
12436:             ENDIF
12437:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12438:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12439:             IF !EMPTY(loc_cCodigo)
12440:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12441:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12442:                     "Buscar Tarefa")
12443:                 IF VARTYPE(loc_oBusca) = "O"
12444:                     IF !loc_oBusca.this_lAchouRegistro
12445:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12446:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12447:                         loc_oBusca.Show()
12448:                     ENDIF
12449:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12450:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12451:                     ELSE
12452:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12453:                     ENDIF
12454:                     loc_oBusca.Release()
12455:                 ENDIF
12456:                 IF USED("cursor_4c_BuscaTar")
12457:                     USE IN cursor_4c_BuscaTar
12458:                 ENDIF
12459:             ENDIF
12460:         CATCH TO loc_oErro
12461:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12462:         ENDTRY
12463:         RETURN loc_lResult
12464:     ENDPROC
12465: 
12466:     *--------------------------------------------------------------------------
12467:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12468:     * Legado: grdDesigner.Column4.Text1.LostFocus
12469:     *--------------------------------------------------------------------------
12470:     PROCEDURE GrdDesignerCol4LostFocus()
12471:         LOCAL loc_oPg
12472:         TRY
12473:             IF LASTKEY() = 13
12474:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12475:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12476:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12477:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12478:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12479:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12480:                             ENDIF
12481:                         ENDIF
12482:                     ENDIF
12483:                 ENDIF
12484:             ENDIF
12485:         CATCH TO loc_oErro
12486:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12487:         ENDTRY
12488:     ENDPROC
12489: 
12490:     *--------------------------------------------------------------------------
12491:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12492:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12493:     *--------------------------------------------------------------------------
12494:     PROCEDURE ObsTarefasWhen()
12495:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12496:     ENDPROC
12497: 
12498:     *--------------------------------------------------------------------------
12499:     * BtnIniTarefaWhen - Habilita botao Iniciar Tarefa somente em INCLUIR/ALTERAR
12500:     * Legado: btnIniTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12501:     *--------------------------------------------------------------------------
12502:     PROCEDURE BtnIniTarefaWhen()
12503:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12504:     ENDPROC
12505: 
12506:     *--------------------------------------------------------------------------
12507:     * BtnFimTarefaWhen - Habilita botao Encerrar Tarefa somente em INCLUIR/ALTERAR
12508:     * Legado: btnFimTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12509:     *--------------------------------------------------------------------------
12510:     PROCEDURE BtnFimTarefaWhen()
12511:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12512:     ENDPROC
12513: 
12514:     *--------------------------------------------------------------------------
12515:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12516:     * Legado: grdArquivos.Column1.Text1.When
12517:     *--------------------------------------------------------------------------
12518:     PROCEDURE GrdArquivosCol1When()
12519:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12520:     ENDPROC
12521: 
12522:     *--------------------------------------------------------------------------
12523:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12524:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12525:     *--------------------------------------------------------------------------
12526:     PROCEDURE BtnInsArqsWhen()
12527:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12528:     ENDPROC
12529: 
12530:     *--------------------------------------------------------------------------
12531:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12532:     * Legado: btnOpnArqs.When - Return .t.
12533:     *--------------------------------------------------------------------------
12534:     PROCEDURE BtnOpnArqsWhen()
12535:         RETURN .T.
12536:     ENDPROC
12537: 
12538:     *--------------------------------------------------------------------------
12539:     * BtnExcArqsWhen - Habilita botao Excluir Arquivo somente em INCLUIR/ALTERAR
12540:     * Legado: btnExcArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12541:     *--------------------------------------------------------------------------
12542:     PROCEDURE BtnExcArqsWhen()
12543:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12544:     ENDPROC
12545: 
12546:     *--------------------------------------------------------------------------
12547:     * Destroy - Liberar recursos
12548:     *--------------------------------------------------------------------------
12549:     PROCEDURE Destroy()
12550:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
12551:             THIS.this_oBusinessObject = .NULL.
12552:         ENDIF
12553:         DODEFAULT()
12554:     ENDPROC
12555: 
12556: ENDDEFINE

