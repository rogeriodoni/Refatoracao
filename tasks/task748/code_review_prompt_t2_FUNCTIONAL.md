# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Produtos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Produtos.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpImg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2225 linhas total):

*-- Linhas 31 a 386:
31:     *-- usado para "despintar" os demais headers ao reordenar a grade
32:     this_nCorPadrao = 0
33: 
34:     *-- Guardas de reentrancia dos lookups de filtro (FormBuscaAuxiliar eh
35:     *-- MODAL e tira o foco do TextBox, o que redispara o proprio LostFocus
36:     *-- - regra #37/#47)
37:     this_lEmLookupGrupo   = .F.
38:     this_lEmLookupProduto = .F.
39:     this_lEmLookupLinha   = .F.
40: 
41:     *-- Guarda de "valor nao mudou" dos 6 handlers de LostFocus de lookup:
42:     *-- no legado o Valid so dispara quando o campo MUDA, mas LostFocus
43:     *-- dispara SEMPRE - sem isto, sair do campo sem digitar nada reabre a
44:     *-- consulta/picker de novo a cada Tab
45:     this_cUltimoValidarGrupoFiltroLostFocusValidado       = ""
46:     this_cUltimoValidarDescGrupoFiltroLostFocusValidado   = ""
47:     this_cUltimoValidarProdutoFiltroLostFocusValidado     = ""
48:     this_cUltimoValidarDescProdutoFiltroLostFocusValidado = ""
49:     this_cUltimoValidarLinhaFiltroLostFocusValidado       = ""
50:     this_cUltimoValidarDescLinhaFiltroLostFocusValidado   = ""
51: 
52:     *-- Estado para habilitar obj_4c_CmdgFigura.Buttons(3) (Zoom) - so fica
53:     *-- habilitado em modo RESULTADO (par_lModoFiltro = .F.) E com o produto
54:     *-- corrente tendo imagem (btnZoom.When legado: Not Empty(FigJpgs))
55:     this_lModoFiltroAtual   = .T.
56:     this_lProdutoTemImagem  = .F.
57: 
58:     *==========================================================================
59:     * Init - Inicializacao do formulario
60:     *==========================================================================
61:     PROCEDURE Init()
62:         THIS.Caption = "Captura de Imagens"
63:         RETURN DODEFAULT()
64:     ENDPROC
65: 
66:     *==========================================================================
67:     * InicializarForm - Instancia o SigOpImgBO e cria a estrutura visual base
68:     *==========================================================================
69:     PROTECTED PROCEDURE InicializarForm()
70:         LOCAL loc_lSucesso, loc_oErro
71:         loc_lSucesso = .F.
72: 
73:         TRY
74:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
75:             SET DATE TO BRITISH
76:             SET CENTURY ON
77: 
78:             *-- Equivalente ao Load legado (Create Cursor csProdutos) -
79:             *-- precisa existir ANTES do BO e da grade
80:             THIS.ConfigurarCursorProdutos()
81: 
82:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpImgBO")
83:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
84:                 *-- Defaults do Init legado (getDtIni.Value=Date()-1,
85:                 *-- getDtFin.Value=Date(), optImagem.Value=1 "Sem Imagem")
86:                 THIS.this_oBusinessObject.this_dDataIni    = DATE() - 1
87:                 THIS.this_oBusinessObject.this_dDataFin    = DATE()
88:                 THIS.this_oBusinessObject.this_nTipoImagem = 1
89: 
90:                 THIS.ConfigurarPageFrame()
91: 
92:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
94: 
95:                 *-- Equivalente a "ThisForm.AcertaForm(.t.)" no fim do Init legado
96:                 THIS.AjustarControlesPorModo(.T.)
97: 
98:                 THIS.TornarControlesVisiveis(THIS)
99:                 THIS.Visible = .T.
100:                 loc_lSucesso = .T.
101:             ELSE
102:                 MsgErro("Falha ao criar SigOpImgBO.", "Erro em InicializarForm")
103:             ENDIF
104:         CATCH TO loc_oErro
105:             MsgErro(loc_oErro.Message + CHR(13) + ;
106:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
107:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
108:         ENDTRY
109: 
110:         RETURN loc_lSucesso
111:     ENDPROC
112: 
113:     *==========================================================================
114:     * ConfigurarPageFrame - Orquestra a criacao da estrutura visual base.
115:     * Form FLAT (legado SIGOPIMG nao tem PageFrame/abas): cabecalho, moldura
116:     * + area de imagem, container dos botoes de periodo/encerramento,
117:     * container do grupo cmdgFigura e a grade de produtos.
118:     *
119:     * ORDEM = z-order do SCX legado: Shape3 eh o PRIMEIRO objeto da arvore
120:     * (antes de cntSombra) e ImgFigJpg desenha por cima dele; o container
121:     * transparente cnt_4c_BotoesAcao encosta 4px no Shape (Left 220..224
122:     * contra 23..224) e por isso vem DEPOIS da moldura. Criar o Shape por
123:     * ultimo o deixaria por cima do container, cobrindo esses 4px (regra #30).
124:     *==========================================================================
125:     PROTECTED PROCEDURE ConfigurarPageFrame()
126:         THIS.ConfigurarCabecalho()
127:         THIS.ConfigurarImagem()
128:         THIS.ConfigurarContainerBotoes()
129:         THIS.ConfigurarContainerBotoesAcao()
130:         THIS.ConfigurarFiltros()
131:         THIS.ConfigurarFiltrosLinhaImagem()
132:         THIS.ConfigurarGrid()
133:         THIS.ConfigurarBusca()
134:     ENDPROC
135: 
136:     *==========================================================================
137:     * ConfigurarCursorProdutos - Cria cursor_4c_Produtos (csProdutos legado),
138:     * cursor local que alimenta a grade. Estrutura e indices identicos ao
139:     * Create Cursor + 6 Index On do PROCEDURE Load legado.
140:     *==========================================================================
141:     PROTECTED PROCEDURE ConfigurarCursorProdutos()
142:         LOCAL loc_cNullAnt
143: 
144:         IF USED("cursor_4c_Produtos")
145:             USE IN cursor_4c_Produtos
146:         ENDIF
147: 
148:         *-- SQL Server devolve NULL em ifors/reffs/cgrus/linhas (FKs
149:         *-- opcionais); sem SET NULL ON, esses campos C() nascem NOT NULL
150:         *-- e o APPEND FROM DBF (em CarregarLista) estoura "Field XXX does
151:         *-- not accept null values"
152:         loc_cNullAnt = SET("NULL")
153:         SET NULL ON
154: 
155:         CREATE CURSOR cursor_4c_Produtos ( ;
156:             dtfilms D NULL, ;
157:             dtincs  D NULL, ;
158:             datas   D NULL, ;
159:             cpros   C(14), ;
160:             dpros   C(40), ;
161:             ifors   C(10), ;
162:             reffs   C(40), ;
163:             cgrus   C(3), ;
164:             linhas  C(10), ;
165:             figjpgs M NULL)
166: 
167:         INDEX ON cpros          TAG cpros
168:         INDEX ON dpros + cpros  TAG dpros
169:         INDEX ON ifors + cpros  TAG ifors
170:         INDEX ON reffs + cpros  TAG reffs
171:         INDEX ON cgrus + cpros  TAG cgrus
172:         INDEX ON linhas + cpros TAG linhas
173: 
174:         IF loc_cNullAnt = "OFF"
175:             SET NULL OFF
176:         ENDIF
177:     ENDPROC
178: 
179:     *==========================================================================
180:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
181:     * Original: cntSombra Top=0, Left=0, Width=1100, Height=80,
182:     *           BackColor=RGB(100,100,100) (framework.vcx cntSombra)
183:     *==========================================================================
184:     PROTECTED PROCEDURE ConfigurarCabecalho()
185:         LOCAL loc_oErro
186:         TRY
187:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
188:             WITH THIS.cnt_4c_Cabecalho
189:                 .Top         = 0
190:                 .Left        = 0
191:                 .Width       = THIS.Width
192:                 .Height      = 80
193:                 .BackStyle   = 1
194:                 .BackColor   = RGB(100, 100, 100)
195:                 .BorderWidth = 0
196:                 .Visible     = .T.
197:             ENDWITH
198: 
199:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
200:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
201:                 .FontBold      = .T.
202:                 .FontName      = "Tahoma"
203:                 .FontSize      = 18
204:                 .FontUnderline = .F.
205:                 .WordWrap      = .T.
206:                 .Alignment     = 0
207:                 .BackStyle     = 0
208:                 .AutoSize      = .F.
209:                 .Caption       = THIS.Caption
210:                 .Height        = 40
211:                 .Left          = 10
212:                 .Top           = 18
213:                 .Width         = THIS.Width - 20
214:                 .ForeColor     = RGB(0, 0, 0)
215:                 .Visible       = .T.
216:             ENDWITH
217: 
218:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
219:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
220:                 .FontBold      = .T.
221:                 .FontName      = "Tahoma"
222:                 .FontSize      = 18
223:                 .WordWrap      = .T.
224:                 .Alignment     = 0
225:                 .BackStyle     = 0
226:                 .AutoSize      = .F.
227:                 .Caption       = THIS.Caption
228:                 .Height        = 46
229:                 .Left          = 10
230:                 .Top           = 17
231:                 .Width         = THIS.Width - 20
232:                 .ForeColor     = RGB(255, 255, 255)
233:                 .ToolTipText   = "T" + CHR(237) + "tulo"
234:                 .Visible       = .T.
235:             ENDWITH
236:         CATCH TO loc_oErro
237:             MsgErro(loc_oErro.Message + CHR(13) + ;
238:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
239:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
240:         ENDTRY
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * ConfigurarContainerBotoes - Container flutuante sobre a faixa do
245:     * cabecalho (BackStyle=0) com cmd_4c_Processar (cmdSelecionar legado) e
246:     * cmg_4c_Limpar (cmdBtnForm legado - "Limpar Sel." / "Encerrar").
247:     * Original: cmdSelecionar Top=3, Left=775, W=75, H=75 +
248:     *           cmdBtnForm     Top=-2, Left=845, W=160, H=85
249:     *==========================================================================
250:     PROTECTED PROCEDURE ConfigurarContainerBotoes()
251:         LOCAL loc_oErro
252:         TRY
253:             THIS.AddObject("cnt_4c_Botoes", "Container")
254:             WITH THIS.cnt_4c_Botoes
255:                 .Top         = 0
256:                 .Left        = 770
257:                 .Width       = 235
258:                 .Height      = 85
259:                 .BackStyle   = 0
260:                 .BorderWidth = 0
261:                 .Visible     = .T.
262:             ENDWITH
263: 
264:             *-- cmd_4c_Processar (cmdSelecionar legado) - Left relativo = 775-770
265:             THIS.cnt_4c_Botoes.AddObject("cmd_4c_Processar", "CommandButton")
266:             WITH THIS.cnt_4c_Botoes.cmd_4c_Processar
267:                 .Top             = 3
268:                 .Left            = 5
269:                 .Width           = 75
270:                 .Height          = 75
271:                 .FontBold        = .T.
272:                 .FontItalic      = .T.
273:                 .FontName        = "Comic Sans MS"
274:                 .FontSize        = 8
275:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
276:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
277:                 .Caption         = "Processar"
278:                 .ForeColor       = RGB(90, 90, 90)
279:                 .BackColor       = RGB(255, 255, 255)
280:                 .Themes          = .T.
281:                 .Visible         = .T.
282:             ENDWITH
283:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
284: 
285:             *-- cmg_4c_Limpar (cmdBtnForm legado) - Left relativo = 845-770
286:             THIS.cnt_4c_Botoes.AddObject("cmg_4c_Limpar", "CommandGroup")
287:             WITH THIS.cnt_4c_Botoes.cmg_4c_Limpar
288:                 .Top         = -2
289:                 .Left        = 75
290:                 .Width       = 160
291:                 .Height      = 85
292:                 .ButtonCount = 2
293:                 .BackStyle   = 0
294:                 .BorderStyle = 0
295:                 .Value       = 0
296:                 .Visible     = .T.
297: 
298:                 WITH .Buttons(1)
299:                     .Top        = 5
300:                     .Left       = 5
301:                     .Width      = 75
302:                     .Height     = 75
303:                     .FontBold   = .T.
304:                     .FontItalic = .T.
305:                     .FontName   = "Comic Sans MS"
306:                     .FontSize   = 8
307:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
308:                     .Caption    = "\<Limpar Sel."
309:                     .ForeColor  = RGB(90, 90, 90)
310:                     .BackColor  = RGB(255, 255, 255)
311:                     .Themes     = .F.
312:                 ENDWITH
313: 
314:                 WITH .Buttons(2)
315:                     .Top        = 5
316:                     .Left       = 80
317:                     .Width      = 75
318:                     .Height     = 75
319:                     .FontBold   = .T.
320:                     .FontItalic = .T.
321:                     .FontName   = "Comic Sans MS"
322:                     .FontSize   = 8
323:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
324:                     .Cancel     = .T.
325:                     .Caption    = "Encerrar"
326:                     .ForeColor  = RGB(90, 90, 90)
327:                     .BackColor  = RGB(255, 255, 255)
328:                     .Themes     = .F.
329:                 ENDWITH
330:             ENDWITH
331:             BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_Limpar, "Click", THIS, "CmgLimparClick")
332:         CATCH TO loc_oErro
333:             MsgErro(loc_oErro.Message + CHR(13) + ;
334:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
335:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoes")
336:         ENDTRY
337:     ENDPROC
338: 
339:     *==========================================================================
340:     * ConfigurarContainerBotoesAcao - Container que hospeda o grupo
341:     * cmdgFigura do legado (Imagem / Branco / Zoom), ao lado da moldura da
342:     * imagem do produto. Os tres botoes operam o campo FigJpgs do produto
343:     * corrente e sao montados junto com os handlers de imagem.
344:     * Original: cmdgFigura Top=492, Left=224, W=235, H=85
345:     *==========================================================================
346:     PROTECTED PROCEDURE ConfigurarContainerBotoesAcao()
347:         LOCAL loc_oErro
348:         TRY
349:             THIS.AddObject("cnt_4c_BotoesAcao", "Container")
350:             WITH THIS.cnt_4c_BotoesAcao
351:                 .Top         = 485
352:                 .Left        = 220
353:                 .Width       = 245
354:                 .Height      = 90
355:                 .BackStyle   = 0
356:                 .BorderWidth = 0
357:                 .Visible     = .T.
358:             ENDWITH
359: 
360:             *-- obj_4c_CmdgFigura (cmdgFigura legado) - Imagem / Branco / Zoom
361:             *-- Left relativo = 224-220. Picture/Caption/ordem transcritos do
362:             *-- dump do SCX (tasks\task748\SigOpImg_form_codigo_fonte.txt:778-823).
363:             THIS.cnt_4c_BotoesAcao.AddObject("obj_4c_CmdgFigura", "CommandGroup")
364:             WITH THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura
365:                 .Top         = 7
366:                 .Left        = 4
367:                 .Width       = 235
368:                 .Height      = 85
369:                 .ButtonCount = 3
370:                 .BackStyle   = 0
371:                 .BorderStyle = 0
372:                 .Value       = 0
373:                 .Visible     = .T.
374: 
375:                 WITH .Buttons(1)
376:                     .Top        = 5
377:                     .Left       = 5
378:                     .Width      = 75
379:                     .Height     = 75
380:                     .FontBold   = .T.
381:                     .FontItalic = .T.
382:                     .FontName   = "Comic Sans MS"
383:                     .FontSize   = 8
384:                     .Picture    = gc_4c_CaminhoIcones + "geral_selo_60.jpg"
385:                     .Caption    = "Imagem"
386:                     .ForeColor  = RGB(90, 90, 90)

*-- Linhas 424 a 490:
424:                     .Enabled    = .F.
425:                 ENDWITH
426:             ENDWITH
427:             BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
428:         CATCH TO loc_oErro
429:             MsgErro(loc_oErro.Message + CHR(13) + ;
430:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
431:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesAcao")
432:         ENDTRY
433:     ENDPROC
434: 
435:     *==========================================================================
436:     * ConfigurarFiltros - Campos principais do filtro de selecao (PARTE 1):
437:     * Periodo de Inclusao (getDtIni/getDtFin), Grupo (getGrupo/getDGrupo) e
438:     * Produto (getCProsF/getDProsF), com os respectivos lookups. Linha
439:     * (getLin/getDLin) e Situacao de Imagem (optImagem) ficam em
440:     * ConfigurarFiltrosLinhaImagem() (PARTE 2).
441:     *
442:     * Posicoes/Captions transcritas literalmente do dump do SCX legado
443:     * (tasks\task748\layout.json) - direto em THIS, sem container, porque
444:     * o legado tambem os cria direto na SIGOPIMG (form FLAT, sem Pagina).
445:     *
446:     * Valores iniciais vem das properties do BO (ja definidas no
447:     * InicializarForm antes deste metodo rodar); a volta (TextBox -> BO) eh
448:     * feita por FormParaBO(), chamado no inicio de BtnProcessarClick.
449:     *==========================================================================
450:     PROTECTED PROCEDURE ConfigurarFiltros()
451:         LOCAL loc_oErro
452:         TRY
453:             THIS.AddObject("lbl_4c_Periodo", "Label")
454:             WITH THIS.lbl_4c_Periodo
455:                 .Top       = 94
456:                 .Left      = 189
457:                 .Width     = 140
458:                 .Height    = 15
459:                 .Alignment = 0
460:                 .BackStyle = 0
461:                 .AutoSize  = .F.
462:                 .FontName  = "Tahoma"
463:                 .FontSize  = 8
464:                 .ForeColor = RGB(90, 90, 90)
465:                 .Caption   = "Per" + CHR(237) + "odo de Inclus" + CHR(227) + "o :"
466:                 .Visible   = .T.
467:             ENDWITH
468: 
469:             THIS.AddObject("txt_4c_DataIni", "TextBox")
470:             WITH THIS.txt_4c_DataIni
471:                 .Top      = 90
472:                 .Left     = 294
473:                 .Width    = 90
474:                 .Height   = 23
475:                 .FontName = "Tahoma"
476:                 .FontSize = 8
477:                 .Value    = NVL(THIS.this_oBusinessObject.this_dDataIni, {})
478:                 .Visible  = .T.
479:             ENDWITH
480: 
481:             THIS.AddObject("lbl_4c_PeriodoA", "Label")
482:             WITH THIS.lbl_4c_PeriodoA
483:                 .Top       = 94
484:                 .Left      = 380
485:                 .Width     = 15
486:                 .Height    = 15
487:                 .Alignment = 0
488:                 .BackStyle = 0
489:                 .AutoSize  = .F.
490:                 .FontName  = "Tahoma"

*-- Linhas 597 a 709:
597:             *-- Lookups (equivalentes ao Valid legado de getGrupo/getDGrupo e
598:             *-- getCProsF/getDProsF) - vao em LostFocus, nunca em KeyPress sem
599:             *-- testar a tecla (regra #47)
600:             BINDEVENT(THIS.txt_4c_Grupo,       "LostFocus", THIS, "ValidarGrupoFiltroLostFocus")
601:             BINDEVENT(THIS.txt_4c_DescGrupo,   "LostFocus", THIS, "ValidarDescGrupoFiltroLostFocus")
602:             BINDEVENT(THIS.txt_4c_Produto,     "LostFocus", THIS, "ValidarProdutoFiltroLostFocus")
603:             BINDEVENT(THIS.txt_4c_DescProduto, "LostFocus", THIS, "ValidarDescProdutoFiltroLostFocus")
604:         CATCH TO loc_oErro
605:             MsgErro(loc_oErro.Message + CHR(13) + ;
606:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
607:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
608:         ENDTRY
609:     ENDPROC
610: 
611:     *==========================================================================
612:     * ConfigurarFiltrosLinhaImagem - Ultimos campos do filtro de selecao
613:     * (PARTE 2): Linha (getLin/getDLin) e Situacao de Imagem (optImagem).
614:     * Posicoes/Captions transcritas literalmente do dump do SCX legado.
615:     *==========================================================================
616:     PROTECTED PROCEDURE ConfigurarFiltrosLinhaImagem()
617:         LOCAL loc_oErro
618:         TRY
619:             THIS.AddObject("lbl_4c_Linha", "Label")
620:             WITH THIS.lbl_4c_Linha
621:                 .Top       = 168
622:                 .Left      = 258
623:                 .Width     = 34
624:                 .Height    = 15
625:                 .Alignment = 0
626:                 .BackStyle = 0
627:                 .AutoSize  = .F.
628:                 .FontName  = "Tahoma"
629:                 .FontSize  = 8
630:                 .ForeColor = RGB(90, 90, 90)
631:                 .Caption   = "Linha :"
632:                 .Visible   = .T.
633:             ENDWITH
634: 
635:             *-- linhas char(10) - SigCdLin
636:             THIS.AddObject("txt_4c_Linha", "TextBox")
637:             WITH THIS.txt_4c_Linha
638:                 .Top       = 165
639:                 .Left      = 294
640:                 .Width     = 108
641:                 .Height    = 23
642:                 .FontName  = "Tahoma"
643:                 .FontSize  = 8
644:                 .MaxLength = 10
645:                 .Value     = NVL(THIS.this_oBusinessObject.this_cLinhaFiltro, "")
646:                 .Visible   = .T.
647:             ENDWITH
648: 
649:             *-- descs char(40) - SigCdLin
650:             THIS.AddObject("txt_4c_DescLinha", "TextBox")
651:             WITH THIS.txt_4c_DescLinha
652:                 .Top       = 165
653:                 .Left      = 404
654:                 .Width     = 332
655:                 .Height    = 23
656:                 .FontName  = "Tahoma"
657:                 .FontSize  = 8
658:                 .MaxLength = 40
659:                 .Value     = NVL(THIS.this_oBusinessObject.this_cDescLinhaFiltro, "")
660:                 .Visible   = .T.
661:             ENDWITH
662: 
663:             BINDEVENT(THIS.txt_4c_Linha,     "LostFocus", THIS, "ValidarLinhaFiltroLostFocus")
664:             BINDEVENT(THIS.txt_4c_DescLinha, "LostFocus", THIS, "ValidarDescLinhaFiltroLostFocus")
665: 
666:             *-- optImagem (OptionGroup) - Situacao da Imagem: 1=Sem Imagem,
667:             *-- 2=Com Imagem, 3=Geral. ControlSource numerico = indice do
668:             *-- botao (regra #188 - NUNCA 0/1 booleano)
669:             THIS.AddObject("opt_4c_TipoImagem", "OptionGroup")
670:             WITH THIS.opt_4c_TipoImagem
671:                 .Top         = 88
672:                 .Left        = 478
673:                 .Width       = 260
674:                 .Height      = 26
675:                 .ButtonCount = 3
676:                 .BackStyle   = 0
677:                 .BorderStyle = 0
678:                 .Value       = NVL(THIS.this_oBusinessObject.this_nTipoImagem, 1)
679:                 .Visible     = .T.
680: 
681:                 WITH .Buttons(1)
682:                     .Top       = 5
683:                     .Left      = 3
684:                     .Width     = 100
685:                     .Height    = 16
686:                     .Style     = 0
687:                     .BackStyle = 0
688:                     .FontName  = "Tahoma"
689:                     .FontSize  = 8
690:                     .ForeColor = RGB(90, 90, 90)
691:                     .Caption   = "Sem Imagem"
692:                 ENDWITH
693: 
694:                 WITH .Buttons(2)
695:                     .Top       = 5
696:                     .Left      = 102
697:                     .Width     = 99
698:                     .Height    = 16
699:                     .Style     = 0
700:                     .BackStyle = 0
701:                     .FontName  = "Tahoma"
702:                     .FontSize  = 8
703:                     .ForeColor = RGB(90, 90, 90)
704:                     .Caption   = "Com Imagem"
705:                 ENDWITH
706: 
707:                 WITH .Buttons(3)
708:                     .Top       = 5
709:                     .Left      = 202

*-- Linhas 720 a 1135:
720:         CATCH TO loc_oErro
721:             MsgErro(loc_oErro.Message + CHR(13) + ;
722:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
723:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltrosLinhaImagem")
724:         ENDTRY
725:     ENDPROC
726: 
727:     *==========================================================================
728:     * FormParaBO - Transfere TODOS os campos da tela para as properties do
729:     * SigOpImgBO, equivalente ao que o legado faz implicitamente via
730:     * ControlSource direto em cada fwget/optImagem (e, no caso do produto
731:     * corrente, via "pPro = csProdutos.CPros" no inicio de cada handler).
732:     *
733:     * Dois blocos, porque esta tela tem duas "fichas" distintas:
734:     *   1) FILTRO - Periodo (getDtIni/getDtFin), Grupo (getGrupo/getDGrupo),
735:     *      Produto (getCProsF/getDProsF), Linha (getLin/getDLin) e Situacao
736:     *      de Imagem (optImagem). Alimenta SigOpImgBO.Processar().
737:     *   2) PRODUTO CORRENTE - linha selecionada na grade (cursor_4c_Produtos,
738:     *      csProdutos do legado). Alimenta SigOpImgBO.Atualizar(), que grava
739:     *      FigJpgs em SigCdPro.
740:     *
741:     * O bloco 2 so transfere quando ha linha corrente; sem isso, o produto
742:     * guardado por uma captura anterior seria apagado e o Atualizar seguinte
743:     * cairia no guard de ValidarDados.
744:     *
745:     * Devolve .T./.F. para que o chamador possa ABORTAR a acao (regra do
746:     * FormParaBO que falha no meio - nunca seguir gravando ficha parcial).
747:     *
748:     * PUBLIC (sem PROTECTED): o harness de teste e os handlers de imagem
749:     * chamam o metodo de fora da classe.
750:     *==========================================================================
751:     PROCEDURE FormParaBO()
752:         LOCAL loc_lSucesso, loc_oErro
753: 
754:         loc_lSucesso = .F.
755: 
756:         TRY
757:             WITH THIS.this_oBusinessObject
758:                 *-- 1) Filtros da selecao
759:                 .this_dDataIni           = THIS.txt_4c_DataIni.Value
760:                 .this_dDataFin           = THIS.txt_4c_DataFim.Value
761:                 .this_cGrupoFiltro       = ALLTRIM(THIS.txt_4c_Grupo.Value)
762:                 .this_cDescGrupoFiltro   = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
763:                 .this_cProdutoFiltro     = ALLTRIM(THIS.txt_4c_Produto.Value)
764:                 .this_cDescProdutoFiltro = ALLTRIM(THIS.txt_4c_DescProduto.Value)
765:                 .this_cLinhaFiltro       = ALLTRIM(THIS.txt_4c_Linha.Value)
766:                 .this_cDescLinhaFiltro   = ALLTRIM(THIS.txt_4c_DescLinha.Value)
767:                 .this_nTipoImagem        = THIS.opt_4c_TipoImagem.Value
768:             ENDWITH
769: 
770:             *-- 2) Produto corrente (linha da grade) - CarregarDoCursor ja le
771:             *-- as 10 colunas do cursor nas properties equivalentes
772:             IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos") ;
773:                     AND RECCOUNT("cursor_4c_Produtos") > 0
774:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")
775:             ENDIF
776: 
777:             loc_lSucesso = .T.
778:         CATCH TO loc_oErro
779:             MsgErro(loc_oErro.Message + CHR(13) + ;
780:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
781:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
782:         ENDTRY
783: 
784:         RETURN loc_lSucesso
785:     ENDPROC
786: 
787:     *==========================================================================
788:     * BOParaForm - Caminho inverso de FormParaBO: devolve as properties do
789:     * SigOpImgBO para os controles da tela.
790:     *
791:     * Usado quando o estado do filtro eh definido FORA da tela: os defaults
792:     * do Init legado (getDtIni.Value = Date()-1, getDtFin.Value = Date(),
793:     * optImagem.Value = 1) sao gravados no BO pelo InicializarForm e so
794:     * chegam aos TextBox por aqui; e o "Limpar Sel." (BtnCancelarClick)
795:     * reexibe os filtros que geraram a ultima selecao.
796:     *
797:     * A imagem do produto corrente eh exibida por CarregarImagemProduto (que
798:     * decodifica FigJpgs e pinta img_4c_Imagem), chamado no fim deste metodo
799:     * para que tela e BO fiquem coerentes num unico passo.
800:     *
801:     * PUBLIC pelo mesmo motivo de FormParaBO.
802:     *==========================================================================
803:     PROCEDURE BOParaForm()
804:         LOCAL loc_lSucesso, loc_oErro, loc_nTipoImagem
805: 
806:         loc_lSucesso = .F.
807: 
808:         TRY
809:             WITH THIS.this_oBusinessObject
810:                 THIS.txt_4c_DataIni.Value      = ConverterParaData(.this_dDataIni)
811:                 THIS.txt_4c_DataFim.Value      = ConverterParaData(.this_dDataFin)
812:                 THIS.txt_4c_Grupo.Value        = ALLTRIM(NVL(.this_cGrupoFiltro, ""))
813:                 THIS.txt_4c_DescGrupo.Value    = ALLTRIM(NVL(.this_cDescGrupoFiltro, ""))
814:                 THIS.txt_4c_Produto.Value      = ALLTRIM(NVL(.this_cProdutoFiltro, ""))
815:                 THIS.txt_4c_DescProduto.Value  = ALLTRIM(NVL(.this_cDescProdutoFiltro, ""))
816:                 THIS.txt_4c_Linha.Value        = ALLTRIM(NVL(.this_cLinhaFiltro, ""))
817:                 THIS.txt_4c_DescLinha.Value    = ALLTRIM(NVL(.this_cDescLinhaFiltro, ""))
818: 
819:                 loc_nTipoImagem = NVL(.this_nTipoImagem, 1)
820:             ENDWITH
821: 
822:             *-- optImagem eh OptionGroup de 3 botoes com ControlSource
823:             *-- NUMERICO = indice 1-based (regra #188): 0 nunca eh valido
824:             THIS.opt_4c_TipoImagem.Value = IIF(BETWEEN(loc_nTipoImagem, 1, 3), loc_nTipoImagem, 1)
825: 
826:             *-- Imagem do produto corrente (equivalente ao CarregaImagem legado)
827:             THIS.CarregarImagemProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodProduto, "")))
828: 
829:             loc_lSucesso = .T.
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message + CHR(13) + ;
832:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
833:                     "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
834:         ENDTRY
835: 
836:         RETURN loc_lSucesso
837:     ENDPROC
838: 
839:     *==========================================================================
840:     * ValidarGrupoFiltroLostFocus / ValidarDescGrupoFiltroLostFocus -
841:     * Lookups do Grupo (equivalentes ao Valid legado de getGrupo/getDGrupo).
842:     * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
843:     *==========================================================================
844:     PROCEDURE ValidarGrupoFiltroLostFocus()
845:         LOCAL loc_cValor
846: 
847:         loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)
848:         IF loc_cValor == THIS.this_cUltimoValidarGrupoFiltroLostFocusValidado
849:             RETURN
850:         ENDIF
851: 
852:         THIS.AbrirLookupGrupoFiltro("cgrus")
853: 
854:         THIS.this_cUltimoValidarGrupoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_Grupo.Value)
855:     ENDPROC
856: 
857:     PROCEDURE ValidarDescGrupoFiltroLostFocus()
858:         LOCAL loc_cValor
859: 
860:         loc_cValor = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
861:         IF loc_cValor == THIS.this_cUltimoValidarDescGrupoFiltroLostFocusValidado
862:             RETURN
863:         ENDIF
864: 
865:         THIS.AbrirLookupGrupoFiltro("dgrus")
866: 
867:         THIS.this_cUltimoValidarDescGrupoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * AbrirLookupGrupoFiltro - Funil unico dos dois Valid legados de
872:     * getGrupo/getDGrupo. Busca em SigCdGrp; o Init do FormBuscaAuxiliar ja
873:     * tenta o match exato (regra #37) - so mostra o picker quando precisa.
874:     *==========================================================================
875:     PROTECTED PROCEDURE AbrirLookupGrupoFiltro(par_cCampoBusca)
876:         LOCAL loc_oBusca, loc_cValor, loc_oErro
877: 
878:         IF THIS.this_lEmLookupGrupo
879:             RETURN
880:         ENDIF
881:         THIS.this_lEmLookupGrupo = .T.
882: 
883:         TRY
884:             loc_cValor = IIF(par_cCampoBusca = "cgrus", ;
885:                 ALLTRIM(THIS.txt_4c_Grupo.Value), ALLTRIM(THIS.txt_4c_DescGrupo.Value))
886: 
887:             IF !EMPTY(loc_cValor)
888:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
889:                     "SigCdGrp", "cursor_4c_BuscaGrupo", par_cCampoBusca, loc_cValor, ;
890:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo")
891: 
892:                 IF VARTYPE(loc_oBusca) = "O"
893:                     IF !loc_oBusca.this_lAchouRegistro
894:                         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
895:                         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
896:                         loc_oBusca.Show()
897:                     ENDIF
898: 
899:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
900:                         SELECT cursor_4c_BuscaGrupo
901:                         THIS.txt_4c_Grupo.Value     = ALLTRIM(cgrus)
902:                         THIS.txt_4c_DescGrupo.Value = ALLTRIM(dgrus)
903:                     ENDIF
904: 
905:                     loc_oBusca.Release()
906:                 ENDIF
907: 
908:                 IF USED("cursor_4c_BuscaGrupo")
909:                     USE IN cursor_4c_BuscaGrupo
910:                 ENDIF
911:             ELSE
912:                 THIS.txt_4c_Grupo.Value     = ""
913:                 THIS.txt_4c_DescGrupo.Value = ""
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message + CHR(13) + ;
917:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
918:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupoFiltro")
919:         ENDTRY
920: 
921:         THIS.this_lEmLookupGrupo = .F.
922:     ENDPROC
923: 
924:     *==========================================================================
925:     * ValidarProdutoFiltroLostFocus / ValidarDescProdutoFiltroLostFocus -
926:     * Lookups do Produto (equivalentes ao Valid legado de getCProsF/getDProsF).
927:     *==========================================================================
928:     PROCEDURE ValidarProdutoFiltroLostFocus()
929:         LOCAL loc_cValor
930: 
931:         loc_cValor = ALLTRIM(THIS.txt_4c_Produto.Value)
932:         IF loc_cValor == THIS.this_cUltimoValidarProdutoFiltroLostFocusValidado
933:             RETURN
934:         ENDIF
935: 
936:         THIS.AbrirLookupProdutoFiltro("cpros")
937: 
938:         THIS.this_cUltimoValidarProdutoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_Produto.Value)
939:     ENDPROC
940: 
941:     PROCEDURE ValidarDescProdutoFiltroLostFocus()
942:         LOCAL loc_cValor
943: 
944:         loc_cValor = ALLTRIM(THIS.txt_4c_DescProduto.Value)
945:         IF loc_cValor == THIS.this_cUltimoValidarDescProdutoFiltroLostFocusValidado
946:             RETURN
947:         ENDIF
948: 
949:         THIS.AbrirLookupProdutoFiltro("dpros")
950: 
951:         THIS.this_cUltimoValidarDescProdutoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_DescProduto.Value)
952:     ENDPROC
953: 
954:     *==========================================================================
955:     * AbrirLookupProdutoFiltro - Funil unico dos dois Valid legados de
956:     * getCProsF/getDProsF. Busca em SigCdPro.
957:     *==========================================================================
958:     PROTECTED PROCEDURE AbrirLookupProdutoFiltro(par_cCampoBusca)
959:         LOCAL loc_oBusca, loc_cValor, loc_oErro
960: 
961:         IF THIS.this_lEmLookupProduto
962:             RETURN
963:         ENDIF
964:         THIS.this_lEmLookupProduto = .T.
965: 
966:         TRY
967:             loc_cValor = IIF(par_cCampoBusca = "cpros", ;
968:                 ALLTRIM(THIS.txt_4c_Produto.Value), ALLTRIM(THIS.txt_4c_DescProduto.Value))
969: 
970:             IF !EMPTY(loc_cValor)
971:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
972:                     "SigCdPro", "cursor_4c_BuscaProdutoFiltro", par_cCampoBusca, loc_cValor, ;
973:                     "Sele" + CHR(231) + CHR(227) + "o de Produto")
974: 
975:                 IF VARTYPE(loc_oBusca) = "O"
976:                     IF !loc_oBusca.this_lAchouRegistro
977:                         loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
978:                         loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
979:                         loc_oBusca.Show()
980:                     ENDIF
981: 
982:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoFiltro")
983:                         SELECT cursor_4c_BuscaProdutoFiltro
984:                         THIS.txt_4c_Produto.Value     = ALLTRIM(cpros)
985:                         THIS.txt_4c_DescProduto.Value = ALLTRIM(dpros)
986:                     ENDIF
987: 
988:                     loc_oBusca.Release()
989:                 ENDIF
990: 
991:                 IF USED("cursor_4c_BuscaProdutoFiltro")
992:                     USE IN cursor_4c_BuscaProdutoFiltro
993:                 ENDIF
994:             ELSE
995:                 THIS.txt_4c_Produto.Value     = ""
996:                 THIS.txt_4c_DescProduto.Value = ""
997:             ENDIF
998:         CATCH TO loc_oErro
999:             MsgErro(loc_oErro.Message + CHR(13) + ;
1000:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1001:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupProdutoFiltro")
1002:         ENDTRY
1003: 
1004:         THIS.this_lEmLookupProduto = .F.
1005:     ENDPROC
1006: 
1007:     *==========================================================================
1008:     * ValidarLinhaFiltroLostFocus / ValidarDescLinhaFiltroLostFocus -
1009:     * Lookups da Linha (equivalentes ao Valid legado de getLin/getDLin).
1010:     *==========================================================================
1011:     PROCEDURE ValidarLinhaFiltroLostFocus()
1012:         LOCAL loc_cValor
1013: 
1014:         loc_cValor = ALLTRIM(THIS.txt_4c_Linha.Value)
1015:         IF loc_cValor == THIS.this_cUltimoValidarLinhaFiltroLostFocusValidado
1016:             RETURN
1017:         ENDIF
1018: 
1019:         THIS.AbrirLookupLinhaFiltro("linhas")
1020: 
1021:         THIS.this_cUltimoValidarLinhaFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_Linha.Value)
1022:     ENDPROC
1023: 
1024:     PROCEDURE ValidarDescLinhaFiltroLostFocus()
1025:         LOCAL loc_cValor
1026: 
1027:         loc_cValor = ALLTRIM(THIS.txt_4c_DescLinha.Value)
1028:         IF loc_cValor == THIS.this_cUltimoValidarDescLinhaFiltroLostFocusValidado
1029:             RETURN
1030:         ENDIF
1031: 
1032:         THIS.AbrirLookupLinhaFiltro("descs")
1033: 
1034:         THIS.this_cUltimoValidarDescLinhaFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_DescLinha.Value)
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * AbrirLookupLinhaFiltro - Funil unico dos dois Valid legados de
1039:     * getLin/getDLin. Busca em SigCdLin.
1040:     *==========================================================================
1041:     PROTECTED PROCEDURE AbrirLookupLinhaFiltro(par_cCampoBusca)
1042:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1043: 
1044:         IF THIS.this_lEmLookupLinha
1045:             RETURN
1046:         ENDIF
1047:         THIS.this_lEmLookupLinha = .T.
1048: 
1049:         TRY
1050:             loc_cValor = IIF(par_cCampoBusca = "linhas", ;
1051:                 ALLTRIM(THIS.txt_4c_Linha.Value), ALLTRIM(THIS.txt_4c_DescLinha.Value))
1052: 
1053:             IF !EMPTY(loc_cValor)
1054:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1055:                     "SigCdLin", "cursor_4c_BuscaLinha", par_cCampoBusca, loc_cValor, ;
1056:                     "Sele" + CHR(231) + CHR(227) + "o de Linha")
1057: 
1058:                 IF VARTYPE(loc_oBusca) = "O"
1059:                     IF !loc_oBusca.this_lAchouRegistro
1060:                         loc_oBusca.mAddColuna("linhas", "", "C" + CHR(243) + "digo")
1061:                         loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1062:                         loc_oBusca.Show()
1063:                     ENDIF
1064: 
1065:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLinha")
1066:                         SELECT cursor_4c_BuscaLinha
1067:                         THIS.txt_4c_Linha.Value     = ALLTRIM(linhas)
1068:                         THIS.txt_4c_DescLinha.Value = ALLTRIM(descs)
1069:                     ENDIF
1070: 
1071:                     loc_oBusca.Release()
1072:                 ENDIF
1073: 
1074:                 IF USED("cursor_4c_BuscaLinha")
1075:                     USE IN cursor_4c_BuscaLinha
1076:                 ENDIF
1077:             ELSE
1078:                 THIS.txt_4c_Linha.Value     = ""
1079:                 THIS.txt_4c_DescLinha.Value = ""
1080:             ENDIF
1081:         CATCH TO loc_oErro
1082:             MsgErro(loc_oErro.Message + CHR(13) + ;
1083:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1084:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupLinhaFiltro")
1085:         ENDTRY
1086: 
1087:         THIS.this_lEmLookupLinha = .F.
1088:     ENDPROC
1089: 
1090:     *==========================================================================
1091:     * ConfigurarGrid - Cria grd_4c_Produtos (grdProdutos legado), ligado ao
1092:     * cursor_4c_Produtos. Colunas/larguras/legendas identicas ao Init legado
1093:     * (RecordSource/ControlSource antes de Width/Header1.Caption - regra #41).
1094:     *==========================================================================
1095:     PROTECTED PROCEDURE ConfigurarGrid()
1096:         LOCAL loc_oErro
1097:         TRY
1098:             THIS.AddObject("grd_4c_Produtos", "Grid")
1099:             WITH THIS.grd_4c_Produtos
1100:                 .Top               = 192
1101:                 .Left              = 13
1102:                 .Width             = 974
1103:                 .Height            = 243
1104:                 .FontName          = "Tahoma"
1105:                 .FontSize          = 8
1106:                 .ColumnCount       = 6
1107:                 .ScrollBars        = 2
1108:                 .DeleteMark        = .F.
1109:                 .RecordMark        = .F.
1110:                 .ReadOnly          = .F.
1111:                 .AllowHeaderSizing = .F.
1112:                 .AllowRowSizing    = .F.
1113:                 .HeaderHeight      = 16
1114:                 .RowHeight         = 16
1115:                 .GridLineColor     = RGB(238, 238, 238)
1116:                 .RecordSource      = "cursor_4c_Produtos"
1117: 
1118:                 .Column1.ControlSource = "cursor_4c_Produtos.cpros"
1119:                 .Column2.ControlSource = "cursor_4c_Produtos.dpros"
1120:                 .Column3.ControlSource = "cursor_4c_Produtos.ifors"
1121:                 .Column4.ControlSource = "cursor_4c_Produtos.reffs"
1122:                 .Column5.ControlSource = "cursor_4c_Produtos.cgrus"
1123:                 .Column6.ControlSource = "cursor_4c_Produtos.linhas"
1124: 
1125:                 .Column1.Width = 129
1126:                 .Column2.Width = 366
1127:                 .Column3.Width = 112
1128:                 .Column4.Width = 191
1129:                 .Column5.Width = 50
1130:                 .Column6.Width = 100
1131: 
1132:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1133:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1134:                 .Column3.Header1.Caption = "Fornecedor"
1135:                 .Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"

*-- Linhas 1231 a 1346:
1231:                     "Column")
1232: 
1233:                 .Visible = .T.
1234:             ENDWITH
1235: 
1236:             THIS.this_nCorPadrao = THIS.grd_4c_Produtos.Column1.Header1.BackColor
1237: 
1238:             BINDEVENT(THIS.grd_4c_Produtos.Column1.Header1, "Click", THIS, "HeaderCodigoClick")
1239:             BINDEVENT(THIS.grd_4c_Produtos.Column2.Header1, "Click", THIS, "HeaderDescricaoClick")
1240:             BINDEVENT(THIS.grd_4c_Produtos.Column3.Header1, "Click", THIS, "HeaderFornecedorClick")
1241:             BINDEVENT(THIS.grd_4c_Produtos.Column4.Header1, "Click", THIS, "HeaderReferenciaClick")
1242:             BINDEVENT(THIS.grd_4c_Produtos.Column5.Header1, "Click", THIS, "HeaderGrupoClick")
1243:             BINDEVENT(THIS.grd_4c_Produtos.Column6.Header1, "Click", THIS, "HeaderLinhaClick")
1244:             BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1245: 
1246:             *-- Ordem e realce iniciais: equivalente ao "Set Order To CPros In
1247:             *-- csProdutos" + Column1.Header1 verde que o AcertaForm legado
1248:             *-- aplica no fim do Init. O SetFocus fica a cargo do
1249:             *-- OrdenarPorColuna, que o pula enquanto o form nao esta visivel
1250:             *-- (aqui os AddObject acabaram de rodar e THIS.Visible ainda eh .F.).
1251:             THIS.OrdenarPorColuna("cpros", 1)
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message + CHR(13) + ;
1254:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1255:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
1256:         ENDTRY
1257:     ENDPROC
1258: 
1259:     *==========================================================================
1260:     * ConfigurarImagem - Cria a moldura (Shape3 legado) e o controle de
1261:     * imagem (ImgFigJpg legado) que exibe a foto do produto corrente,
1262:     * atualizada pelo GradeAfterRowColChange.
1263:     *==========================================================================
1264:     PROTECTED PROCEDURE ConfigurarImagem()
1265:         LOCAL loc_oErro
1266:         TRY
1267:             THIS.AddObject("shp_4c_Imagem", "Shape")
1268:             WITH THIS.shp_4c_Imagem
1269:                 .Top           = 477
1270:                 .Left          = 23
1271:                 .Width         = 201
1272:                 .Height        = 118
1273:                 .BackStyle     = 0
1274:                 .FillStyle     = 1
1275:                 .SpecialEffect = 1
1276:                 .BorderColor   = RGB(90, 90, 90)
1277:                 .Visible       = .T.
1278:             ENDWITH
1279: 
1280:             THIS.AddObject("img_4c_Imagem", "Image")
1281:             WITH THIS.img_4c_Imagem
1282:                 .Top     = 478
1283:                 .Left    = 24
1284:                 .Width   = 199
1285:                 .Height  = 116
1286:                 .Stretch = 1
1287:                 .Enabled = .F.
1288:                 .Picture = ""
1289:                 *-- O ImgFigJpg legado nao declara Visible (default .T.) e sem
1290:                 *-- Picture nao desenha nada; quem alterna eh o CarregaImagem.
1291:                 .Visible = .T.
1292:             ENDWITH
1293:         CATCH TO loc_oErro
1294:             MsgErro(loc_oErro.Message + CHR(13) + ;
1295:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1296:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImagem")
1297:         ENDTRY
1298:     ENDPROC
1299: 
1300:     *==========================================================================
1301:     * ConfigurarBusca - Mini barra "Procurar" (Say3/getCPros/getDPros/
1302:     * getIFors/getReffs) abaixo da grade: digitar e Tab/sair do campo
1303:     * localiza o produto mais proximo na grade e limpa a caixa - equivalente
1304:     * ao LostFocus dos 4 fwget legados.
1305:     *==========================================================================
1306:     PROTECTED PROCEDURE ConfigurarBusca()
1307:         LOCAL loc_oErro
1308:         TRY
1309:             THIS.AddObject("lbl_4c_Procurar", "Label")
1310:             WITH THIS.lbl_4c_Procurar
1311:                 .Top       = 433
1312:                 .Left      = 24
1313:                 .Width     = 60
1314:                 .Height    = 15
1315:                 .Alignment = 0
1316:                 .BackStyle = 0
1317:                 .AutoSize  = .F.
1318:                 .FontName  = "Tahoma"
1319:                 .FontSize  = 8
1320:                 .FontBold  = .T.
1321:                 .ForeColor = RGB(90, 90, 90)
1322:                 .Caption   = "Procurar"
1323:                 .Visible   = .T.
1324:             ENDWITH
1325: 
1326:             *-- cpros char(14) - busca por Codigo
1327:             THIS.AddObject("txt_4c_BuscaCodigo", "TextBox")
1328:             WITH THIS.txt_4c_BuscaCodigo
1329:                 .Top       = 450
1330:                 .Left      = 23
1331:                 .Width     = 108
1332:                 .Height    = 23
1333:                 .FontName  = "Tahoma"
1334:                 .FontSize  = 8
1335:                 .MaxLength = 14
1336:                 .Value     = ""
1337:                 .Visible   = .T.
1338:             ENDWITH
1339: 
1340:             *-- dpros char(65) - busca por Descricao
1341:             THIS.AddObject("txt_4c_BuscaDescricao", "TextBox")
1342:             WITH THIS.txt_4c_BuscaDescricao
1343:                 .Top       = 450
1344:                 .Left      = 134
1345:                 .Width     = 348
1346:                 .Height    = 23

*-- Linhas 1379 a 1905:
1379:                 .Visible   = .T.
1380:             ENDWITH
1381: 
1382:             BINDEVENT(THIS.txt_4c_BuscaCodigo,      "LostFocus", THIS, "BuscaCodigoLostFocus")
1383:             BINDEVENT(THIS.txt_4c_BuscaDescricao,   "LostFocus", THIS, "BuscaDescricaoLostFocus")
1384:             BINDEVENT(THIS.txt_4c_BuscaFornecedor,  "LostFocus", THIS, "BuscaFornecedorLostFocus")
1385:             BINDEVENT(THIS.txt_4c_BuscaReferencia,  "LostFocus", THIS, "BuscaReferenciaLostFocus")
1386:         CATCH TO loc_oErro
1387:             MsgErro(loc_oErro.Message + CHR(13) + ;
1388:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1389:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBusca")
1390:         ENDTRY
1391:     ENDPROC
1392: 
1393:     *==========================================================================
1394:     * BuscaCodigoLostFocus / BuscaDescricaoLostFocus / BuscaFornecedorLostFocus
1395:     * / BuscaReferenciaLostFocus - equivalentes aos 4 LostFocus legados de
1396:     * getCPros/getDPros/getIFors/getReffs: localiza o produto mais proximo
1397:     * do valor digitado e limpa a caixa.
1398:     *==========================================================================
1399:     PROCEDURE BuscaCodigoLostFocus()
1400:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaCodigo, "cpros", 1)
1401:     ENDPROC
1402: 
1403:     PROCEDURE BuscaDescricaoLostFocus()
1404:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaDescricao, "dpros", 2)
1405:     ENDPROC
1406: 
1407:     PROCEDURE BuscaFornecedorLostFocus()
1408:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaFornecedor, "ifors", 3)
1409:     ENDPROC
1410: 
1411:     PROCEDURE BuscaReferenciaLostFocus()
1412:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaReferencia, "reffs", 4)
1413:     ENDPROC
1414: 
1415:     *==========================================================================
1416:     * LocalizarProdutoPorBusca - Funil unico dos 4 LostFocus legados
1417:     * (getCPros/getDPros/getIFors/getReffs): "Set Order To <campo>" +
1418:     * "Set Near On" + "Locate For <campo> = Alltrim(valor)" + "Set Near Off",
1419:     * equivalente byte a byte ao legado.
1420:     *
1421:     * O legado conta com SET EXACT OFF (prefixo) para a busca por aproximacao
1422:     * funcionar com valor PARCIAL; o config.prg deste projeto liga SET EXACT
1423:     * ON globalmente (regra das chaves compostas), entao o EXACT eh alternado
1424:     * localmente so em volta do LOCATE e restaurado imediatamente depois.
1425:     *==========================================================================
1426:     PROTECTED PROCEDURE LocalizarProdutoPorBusca(par_oTxt, par_cCampo, par_nColuna)
1427:         LOCAL loc_cValor, loc_cExactAnt
1428: 
1429:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1430: 
1431:         IF EMPTY(loc_cValor) OR !USED("cursor_4c_Produtos")
1432:             RETURN
1433:         ENDIF
1434: 
1435:         loc_cExactAnt = SET("EXACT")
1436:         SET EXACT OFF
1437: 
1438:         SELECT cursor_4c_Produtos
1439:         SET ORDER TO TAG (par_cCampo) IN cursor_4c_Produtos
1440:         SET NEAR ON
1441:         DO CASE
1442:             CASE par_cCampo = "cpros"
1443:                 LOCATE FOR cpros = loc_cValor
1444:             CASE par_cCampo = "dpros"
1445:                 LOCATE FOR dpros = loc_cValor
1446:             CASE par_cCampo = "ifors"
1447:                 LOCATE FOR ifors = loc_cValor
1448:             CASE par_cCampo = "reffs"
1449:                 LOCATE FOR reffs = loc_cValor
1450:         ENDCASE
1451:         SET NEAR OFF
1452: 
1453:         IF loc_cExactAnt = "ON"
1454:             SET EXACT ON
1455:         ENDIF
1456: 
1457:         par_oTxt.Value = ""
1458: 
1459:         THIS.RealcarColunaOrdenada(par_nColuna)
1460:         IF THIS.Visible
1461:             THIS.grd_4c_Produtos.Columns(par_nColuna).SetFocus()
1462:         ENDIF
1463:         THIS.grd_4c_Produtos.Refresh()
1464: 
1465:         IF !EOF("cursor_4c_Produtos")
1466:             THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
1467:         ENDIF
1468:     ENDPROC
1469: 
1470:     *==========================================================================
1471:     * HeaderCodigoClick / HeaderDescricaoClick / HeaderFornecedorClick /
1472:     * HeaderReferenciaClick / HeaderGrupoClick / HeaderLinhaClick - Reordena
1473:     * cursor_4c_Produtos pelo TAG correspondente e realca o header da
1474:     * coluna ativa, equivalente aos 6 Header1.Click do grdProdutos legado.
1475:     *==========================================================================
1476:     PROCEDURE HeaderCodigoClick()
1477:         THIS.OrdenarPorColuna("cpros", 1)
1478:     ENDPROC
1479: 
1480:     PROCEDURE HeaderDescricaoClick()
1481:         THIS.OrdenarPorColuna("dpros", 2)
1482:     ENDPROC
1483: 
1484:     PROCEDURE HeaderFornecedorClick()
1485:         THIS.OrdenarPorColuna("ifors", 3)
1486:     ENDPROC
1487: 
1488:     PROCEDURE HeaderReferenciaClick()
1489:         THIS.OrdenarPorColuna("reffs", 4)
1490:     ENDPROC
1491: 
1492:     PROCEDURE HeaderGrupoClick()
1493:         THIS.OrdenarPorColuna("cgrus", 5)
1494:     ENDPROC
1495: 
1496:     PROCEDURE HeaderLinhaClick()
1497:         THIS.OrdenarPorColuna("linhas", 6)
1498:     ENDPROC
1499: 
1500:     *==========================================================================
1501:     * OrdenarPorColuna - Funil unico dos 6 Header1.Click legados, na MESMA
1502:     * ordem do legado: guarda o Recno, troca o TAG, repinta os headers, foca
1503:     * a coluna, Refresh, volta o Recno e Refresh de novo.
1504:     *
1505:     * O SetFocus eh condicionado a THIS.Visible porque este mesmo funil eh
1506:     * chamado pelo ConfigurarGrid (equivalente ao AcertaForm do Init legado),
1507:     * quando os controles acabaram de nascer via AddObject e o form ainda
1508:     * esta invisivel - SetFocus em controle de form invisivel estoura.
1509:     *==========================================================================
1510:     PROTECTED PROCEDURE OrdenarPorColuna(par_cTag, par_nColuna)
1511:         LOCAL loc_nRecAtual
1512: 
1513:         IF !USED("cursor_4c_Produtos")
1514:             RETURN
1515:         ENDIF
1516: 
1517:         *-- "lnRec = Recno('csProdutos')" + "Set Order To <tag> In csProdutos"
1518:         *--
1519:         *-- O ponteiro NAO pode ser reposicionado por SEEK: cinco dos seis TAGs
1520:         *-- sao COMPOSTOS (dpros+cpros, ifors+cpros, reffs+cpros, cgrus+cpros,
1521:         *-- linhas+cpros) e o config.prg liga SET EXACT ON, entao SEEK de chave
1522:         *-- parcial devolveria .F. SEMPRE e deixaria a grade em EOF - sem erro
1523:         *-- e sem log. RECNO eh independente da ordem, e eh o que o legado usa.
1524:         loc_nRecAtual = RECNO("cursor_4c_Produtos")
1525: 
1526:         SET ORDER TO TAG (par_cTag) IN cursor_4c_Produtos
1527: 
1528:         THIS.RealcarColunaOrdenada(par_nColuna)
1529: 
1530:         *-- SetFocus condicionado a THIS.Visible: este funil tambem eh chamado
1531:         *-- pelo ConfigurarGrid (equivalente ao AcertaForm do Init legado),
1532:         *-- quando os controles acabaram de nascer via AddObject e o form ainda
1533:         *-- esta invisivel - SetFocus em controle de form invisivel estoura.
1534:         IF THIS.Visible
1535:             THIS.grd_4c_Produtos.Columns(par_nColuna).SetFocus()
1536:         ENDIF
1537: 
1538:         THIS.grd_4c_Produtos.Refresh()
1539: 
1540:         *-- "Go lnRec In csProdutos" + Refresh: o GO vem DEPOIS do primeiro
1541:         *-- Refresh porque o Grid re-sincroniza o ponteiro do cursor com a
1542:         *-- linha corrente dele ao repintar - invertendo a ordem, o registro
1543:         *-- que estava selecionado antes da troca de ordem seria perdido.
1544:         IF RECCOUNT("cursor_4c_Produtos") > 0 AND ;
1545:                 BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_Produtos"))
1546:             GO loc_nRecAtual IN cursor_4c_Produtos
1547:         ENDIF
1548: 
1549:         THIS.grd_4c_Produtos.Refresh()
1550:     ENDPROC
1551: 
1552:     *==========================================================================
1553:     * RealcarColunaOrdenada - Pinta o Header1 da coluna ativa com o verde do
1554:     * legado (RGB(220,255,220)) e devolve os demais ao CorPadrao original.
1555:     *
1556:     * Repoe as SEIS colunas. O AcertaForm legado repoe so Column1..Column4
1557:     * (ficou para tras quando as colunas 5 e 6 foram acrescentadas), o que
1558:     * deixa DOIS headers verdes quando o usuario ordena por Grupo/Linha e
1559:     * em seguida reprocessa; os seis Header1.Click legados ja repoem todas.
1560:     *==========================================================================
1561:     PROTECTED PROCEDURE RealcarColunaOrdenada(par_nColuna)
1562:         LOCAL loc_nI
1563: 
1564:         FOR loc_nI = 1 TO 6
1565:             IF loc_nI = par_nColuna
1566:                 THIS.grd_4c_Produtos.Columns(loc_nI).Header1.BackColor = RGB(220, 255, 220)
1567:             ELSE
1568:                 THIS.grd_4c_Produtos.Columns(loc_nI).Header1.BackColor = THIS.this_nCorPadrao
1569:             ENDIF
1570:         ENDFOR
1571:     ENDPROC
1572: 
1573:     *==========================================================================
1574:     * GradeAfterRowColChange - Recarrega a imagem do produto da linha
1575:     * corrente. Equivalente a "ThisForm.CarregaImagem(csProdutos.CPros)" do
1576:     * AfterRowColChange legado - sem filtro de coluna (regra #46: carregar
1577:     * detalhe da linha corrente eh uso correto de AfterRowColChange).
1578:     *==========================================================================
1579:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1580:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
1581:             THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
1582:         ENDIF
1583:     ENDPROC
1584: 
1585:     *==========================================================================
1586:     * CarregarImagemProduto - Decodifica FigJpgs (base64) do produto cujo
1587:     * cpros == par_cCodProduto, grava num arquivo temporario, exibe em
1588:     * img_4c_Imagem e apaga o temporario - equivalente ao PROCEDURE
1589:     * CarregaImagem legado.
1590:     *==========================================================================
1591:     PROTECTED PROCEDURE CarregarImagemProduto(par_cCodProduto)
1592:         LOCAL loc_cArquivo, loc_cFoto, loc_lTemImagem
1593: 
1594:         loc_cArquivo  = SYS(2023) + "\SigCpImg.jpg"
1595:         loc_lTemImagem = .F.
1596: 
1597:         THIS.img_4c_Imagem.Visible = .F.
1598:         THIS.img_4c_Imagem.Picture = ""
1599: 
1600:         IF !EMPTY(ALLTRIM(NVL(par_cCodProduto, ""))) AND USED("cursor_4c_Produtos") ;
1601:                 AND !EOF("cursor_4c_Produtos") AND cursor_4c_Produtos.cpros == par_cCodProduto
1602:             IF !EMPTY(cursor_4c_Produtos.figjpgs) AND !ISNULL(cursor_4c_Produtos.figjpgs)
1603:                 loc_lTemImagem = .T.
1604:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Produtos.figjpgs, ;
1605:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1606:                     "data:image/jpg;base64,", ""), 14)
1607:                 IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
1608:                     THIS.img_4c_Imagem.Picture = loc_cArquivo
1609:                     THIS.img_4c_Imagem.Visible = .T.
1610:                 ENDIF
1611:             ENDIF
1612:         ENDIF
1613: 
1614:         IF FILE(loc_cArquivo)
1615:             DELETE FILE (loc_cArquivo)
1616:         ENDIF
1617: 
1618:         *-- btnZoom.When legado (Not Empty(FigJpgs)) - guardado para combinar
1619:         *-- com o modo corrente (filtro/resultado) em AtualizarEstadoBotaoZoom
1620:         THIS.this_lProdutoTemImagem = loc_lTemImagem
1621:         THIS.AtualizarEstadoBotaoZoom()
1622:     ENDPROC
1623: 
1624:     *==========================================================================
1625:     * AtualizarEstadoBotaoZoom - obj_4c_CmdgFigura.Buttons(3) (Zoom) so fica
1626:     * habilitado em modo RESULTADO (apos Processar) E com o produto corrente
1627:     * tendo imagem - combina o toggle do AcertaForm legado (Not llEna) com o
1628:     * btnZoom.When (Not Empty(FigJpgs)).
1629:     *==========================================================================
1630:     PROTECTED PROCEDURE AtualizarEstadoBotaoZoom()
1631:         IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "obj_4c_CmdgFigura", 5)
1632:             THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(3).Enabled = ;
1633:                 !THIS.this_lModoFiltroAtual AND THIS.this_lProdutoTemImagem
1634:         ENDIF
1635:     ENDPROC
1636: 
1637:     *==========================================================================
1638:     * BtnProcessarClick - Valida o periodo (equivalente ao cmdSelecionar.
1639:     * Click legado) e delega a busca para CarregarLista().
1640:     *
1641:     * FormParaBO() vem ANTES das validacoes e o seu retorno aborta a acao:
1642:     * sem os filtros transferidos, o Processar consultaria com o estado
1643:     * anterior do BO e traria o resultado errado em silencio.
1644:     *==========================================================================
1645:     PROCEDURE BtnProcessarClick()
1646:         LOCAL loc_dDataIni, loc_dDataFin
1647: 
1648:         IF !THIS.FormParaBO()
1649:             RETURN
1650:         ENDIF
1651: 
1652:         loc_dDataIni = THIS.this_oBusinessObject.this_dDataIni
1653:         loc_dDataFin = THIS.this_oBusinessObject.this_dDataFin
1654: 
1655:         IF EMPTY(loc_dDataIni)
1656:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1657:             RETURN
1658:         ENDIF
1659: 
1660:         IF EMPTY(loc_dDataFin)
1661:             MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1662:             RETURN
1663:         ENDIF
1664: 
1665:         IF loc_dDataFin < loc_dDataIni
1666:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1667:             RETURN
1668:         ENDIF
1669: 
1670:         THIS.CarregarDados()
1671:     ENDPROC
1672: 
1673:     *==========================================================================
1674:     * CarregarLista - Metodo de carga da grade (PROCEDURE Processamento do
1675:     * legado). Chama SigOpImgBO.Processar(), que faz o SQLEXEC num cursor
1676:     * TEMPORARIO, e repopula cursor_4c_Produtos via ZAP + APPEND FROM DBF -
1677:     * nunca SQLEXEC direto sobre o alias ligado ao Grid, que zeraria o
1678:     * ColumnCount e deixaria a grade como um retangulo branco.
1679:     *
1680:     * O legado fecha com AcertaForm(.f.) (ordem CPros + realce da Column1) +
1681:     * CarregaImagem + Refresh + foco na Column1 ou no btnLimpar quando nada
1682:     * foi selecionado; so a parte de Enabled dos filtros do AcertaForm nao
1683:     * cabe aqui, por depender dos controles de filtro.
1684:     *
1685:     * PUBLIC (sem PROTECTED): o TesteAutomatico.prg chama este metodo de FORA
1686:     * da classe, por macro (THIS.oForm.&loc_cMetodo.()), e o PEMSTATUS(...,5)
1687:     * que ele usa devolve .T. tambem para metodo PROTECTED - o harness entraria
1688:     * no ramo e a chamada real estouraria "Property CARREGARLISTA is not found".
1689:     *==========================================================================
1690:     PROCEDURE CarregarLista()
1691:         LOCAL loc_lSucesso, loc_oErro, loc_nRegistros
1692: 
1693:         TRY
1694:             loc_lSucesso = THIS.this_oBusinessObject.Processar("cursor_4c_ProdutosTemp")
1695: 
1696:             IF loc_lSucesso
1697:                 THIS.EsvaziarCursorProdutos()
1698: 
1699:                 IF USED("cursor_4c_ProdutosTemp")
1700:                     IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
1701:                         SELECT cursor_4c_Produtos
1702:                         APPEND FROM DBF("cursor_4c_ProdutosTemp")
1703:                     ENDIF
1704:                     USE IN cursor_4c_ProdutosTemp
1705:                 ENDIF
1706: 
1707:                 *-- GO TOP + Refresh: cursor populado nao repinta a grade sozinho
1708:                 SELECT cursor_4c_Produtos
1709:                 GO TOP
1710:                 loc_nRegistros = RECCOUNT("cursor_4c_Produtos")
1711: 
1712:                 THIS.AjustarControlesPorModo(.F.)
1713:                 THIS.OrdenarPorColuna("cpros", 1)
1714: 
1715:                 IF loc_nRegistros < 1
1716:                     MsgAviso("Nenhum Produto Foi Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1717:                     THIS.CarregarImagemProduto("")
1718:                     THIS.cnt_4c_Botoes.cmg_4c_Limpar.Buttons(1).SetFocus()
1719:                 ELSE
1720:                     THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
1721:                 ENDIF
1722:             ELSE
1723:                 *-- Mensagem do legado para falha de consulta (Processamento - 1)
1724:                 MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
1725:                         THIS.this_oBusinessObject.ObterMensagemErro(), ;
1726:                         "Falha na Conex" + CHR(227) + "o (Processamento - 1)")
1727:             ENDIF
1728:         CATCH TO loc_oErro
1729:             MsgErro(loc_oErro.Message + CHR(13) + ;
1730:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1731:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
1732:         ENDTRY
1733:     ENDPROC
1734: 
1735:     *==========================================================================
1736:     * CarregarDados - Nome usado pelos handlers desta tela desde a migracao
1737:     * da logica de selecao. Mantido como porta de entrada unica para
1738:     * CarregarLista (que eh o nome canonico do projeto para o metodo que
1739:     * popula a grade), para que exista UMA implementacao so.
1740:     *==========================================================================
1741:     PROCEDURE CarregarDados()
1742:         RETURN THIS.CarregarLista()
1743:     ENDPROC
1744: 
1745:     *==========================================================================
1746:     * CmgLimparClick - Despacha os 2 botoes de cmg_4c_Limpar (cmdBtnForm
1747:     * legado): Button1 "Limpar Sel." e Button2 "Encerrar" - equivalente ao
1748:     * "If This.Value = 1 / ... / Else ThisForm.Release" do Click legado.
1749:     *==========================================================================
1750:     PROCEDURE CmgLimparClick()
1751:         IF THIS.cnt_4c_Botoes.cmg_4c_Limpar.Value = 1
1752:             THIS.BtnCancelarClick()
1753:         ELSE
1754:             THIS.BtnEncerrarClick()
1755:         ENDIF
1756:     ENDPROC
1757: 
1758:     *==========================================================================
1759:     * BtnCancelarClick - "Limpar Sel." (cmdBtnForm.btnLimpar legado, ramo
1760:     * "If This.Value = 1"): CANCELA a selecao corrente e devolve a tela ao
1761:     * modo FILTRO, para o usuario montar outra consulta.
1762:     *
1763:     * Esta eh a unica acao cancelavel do SIGOPIMG - nao ha Page2 de Dados
1764:     * nem Salvar/Cancelar de ficha: a gravacao da imagem eh imediata (botao
1765:     * "Imagem"/"Branco"), e o que se cancela aqui eh o RESULTADO da selecao.
1766:     *
1767:     * Ordem identica ao legado: Zap In csProdutos -> CarregaImagem('') ->
1768:     * AcertaForm(.t.) (que reordena por CPros, realca a Column1, devolve o
1769:     * foco ao periodo e reabilita os filtros).
1770:     *
1771:     * PUBLIC: chamado pelo CmgLimparClick e pelo TesteAutomatico.prg.
1772:     *==========================================================================
1773:     PROCEDURE BtnCancelarClick()
1774:         THIS.LimparCampos()
1775:         THIS.OrdenarPorColuna("cpros", 1)
1776:         THIS.AjustarControlesPorModo(.T.)
1777: 
1778:         *-- Reexibe no form o filtro que gerou a selecao recem-descartada,
1779:         *-- mantendo tela e BO coerentes para a proxima consulta
1780:         THIS.BOParaForm()
1781:     ENDPROC
1782: 
1783:     *==========================================================================
1784:     * BtnEncerrarClick - "Encerrar" (cmdBtnForm.Buttons(2) legado, ramo
1785:     * "Else ThisForm.Release"). Os cursores sao fechados no Destroy.
1786:     *==========================================================================
1787:     PROCEDURE BtnEncerrarClick()
1788:         THIS.Release()
1789:     ENDPROC
1790: 
1791:     *==========================================================================
1792:     * LimparCampos - Descarta a selecao corrente: esvazia cursor_4c_Produtos
1793:     * (Zap In csProdutos legado), apaga a imagem exibida (CarregaImagem('')) e
1794:     * limpa as 4 caixas de "Procurar" (getCPros/getDPros/getIFors/getReffs),
1795:     * que so fazem sentido com a grade preenchida.
1796:     *
1797:     * Os campos de FILTRO NAO sao limpos aqui - o legado tambem nao os limpa
1798:     * no btnLimpar, e zera-los obrigaria o usuario a redigitar o periodo a
1799:     * cada nova consulta.
1800:     *==========================================================================
1801:     PROCEDURE LimparCampos()
1802:         THIS.EsvaziarCursorProdutos()
1803: 
1804:         THIS.txt_4c_BuscaCodigo.Value     = ""
1805:         THIS.txt_4c_BuscaDescricao.Value  = ""
1806:         THIS.txt_4c_BuscaFornecedor.Value = ""
1807:         THIS.txt_4c_BuscaReferencia.Value = ""
1808: 
1809:         THIS.this_oBusinessObject.this_cCodProduto   = ""
1810:         THIS.this_oBusinessObject.this_cImagemBase64 = ""
1811: 
1812:         THIS.CarregarImagemProduto("")
1813:         THIS.grd_4c_Produtos.Refresh()
1814:     ENDPROC
1815: 
1816:     *==========================================================================
1817:     * CmdgFiguraClick - Despacha os 3 botoes de obj_4c_CmdgFigura (cmdgFigura
1818:     * legado: Imagem/cmdFigura, Branco/cmdBranco, Zoom/btnZoom) para os
1819:     * metodos equivalentes. Sem produto selecionado na grade, nenhum dos 3
1820:     * tem o que fazer - mesma mensagem usada em CarregarLista para grade
1821:     * vazia.
1822:     *==========================================================================
1823:     PROCEDURE CmdgFiguraClick()
1824:         LOCAL loc_cProduto, loc_nBotao
1825: 
1826:         loc_nBotao = THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Value
1827: 
1828:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1829:             MsgAviso("Nenhum Produto Foi Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1830:             RETURN
1831:         ENDIF
1832: 
1833:         loc_cProduto = cursor_4c_Produtos.cpros
1834: 
1835:         DO CASE
1836:             CASE loc_nBotao = 1
1837:                 THIS.CapturarImagemProduto(loc_cProduto)
1838:             CASE loc_nBotao = 2
1839:                 THIS.AplicarImagemBrancoProduto(loc_cProduto)
1840:             CASE loc_nBotao = 3
1841:                 THIS.AbrirZoomImagemProduto(loc_cProduto)
1842:         ENDCASE
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * CapturarImagemProduto - cmdFigura.Valid legado: abre o seletor de
1847:     * arquivo (GetPict), confirma a transferencia, grava a imagem em
1848:     * SigCdPro.FigJpgs (via SigOpImgBO.Atualizar) e limpa a previsualizacao
1849:     * em cache em SigPrPrt - so esta acao faz essa limpeza no legado
1850:     * (cmdBranco.Valid nao faz).
1851:     *
1852:     * FigJpgs guarda a imagem em BASE64 (nao em binario cru) - e o que
1853:     * CarregarImagemProduto/demais BOs do sistema decodificam com
1854:     * STRCONV(...,14) (ver docs - "double decode" STRCONV). O legado grava
1855:     * com FileToStr() puro (sem encode) porque historicamente a captura
1856:     * vinha de outro caminho; aqui o encode com STRCONV(...,13) eh
1857:     * obrigatorio para nao gravar binario cru onde o resto do sistema
1858:     * espera base64 (gravar cru corromperia a exibicao em TODOS os pontos
1859:     * que leem FigJpgs, nao so nesta tela).
1860:     *
1861:     * fTamanhoImagem (SIGFUNCS.PRG) nao esta no acervo (regra #13/#27) -
1862:     * mantido so o guard de arquivo existente/nao vazio; o limite real de
1863:     * tamanho/dimensao do legado nao e reproduzido.
1864:     *==========================================================================
1865:     PROTECTED PROCEDURE CapturarImagemProduto(par_cCodProduto)
1866:         LOCAL loc_cArquivo, loc_cImagem, loc_oErro
1867: 
1868:         loc_cArquivo = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar"))
1869: 
1870:         IF EMPTY(loc_cArquivo)
1871:             RETURN
1872:         ENDIF
1873: 
1874:         IF !FILE(loc_cArquivo)
1875:             MsgErro("Arquivo " + UPPER(loc_cArquivo) + " n" + CHR(227) + "o encontrado.", "Imagem")
1876:             RETURN
1877:         ENDIF
1878: 
1879:         IF !MsgConfirma("Confirma a Transfer" + CHR(234) + "ncia da Imagem ?")
1880:             THIS.grd_4c_Produtos.Column1.SetFocus()
1881:             RETURN
1882:         ENDIF
1883: 
1884:         *-- FormParaBO leva a linha corrente INTEIRA para o BO (nao so o
1885:         *-- codigo): Atualizar/RegistrarAuditoria/ObterChavePrimaria precisam
1886:         *-- do produto completo, nao de uma ficha pela metade. Fica FORA do
1887:         *-- TRY porque o seu RETURN de guarda nao pode morar dentro dele
1888:         *-- (regra #1) - e porque falhar aqui eh nao ter o que gravar.
1889:         IF !THIS.FormParaBO()
1890:             THIS.grd_4c_Produtos.Column1.SetFocus()
1891:             RETURN
1892:         ENDIF
1893: 
1894:         WAIT WINDOW "Aguarde!!! Transferindo a Imagem..." NOWAIT
1895: 
1896:         TRY
1897:             loc_cImagem = STRCONV(FILETOSTR(loc_cArquivo), 13)
1898: 
1899:             THIS.this_oBusinessObject.this_cCodProduto   = par_cCodProduto
1900:             THIS.this_oBusinessObject.this_cImagemBase64 = loc_cImagem
1901: 
1902:             THIS.this_oBusinessObject.LimparPreviewImpressao(par_cCodProduto)
1903: 
1904:             IF THIS.this_oBusinessObject.Atualizar()
1905:                 THIS.AtualizarLinhaGradeComImagem(par_cCodProduto, loc_cImagem)

*-- Linhas 1920 a 2225:
1920:             WAIT CLEAR
1921:             MsgErro(loc_oErro.Message + CHR(13) + ;
1922:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1923:                     "Procedure: " + loc_oErro.Procedure, "Erro em CapturarImagemProduto")
1924:         ENDTRY
1925: 
1926:         THIS.grd_4c_Produtos.Column1.SetFocus()
1927:     ENDPROC
1928: 
1929:     *==========================================================================
1930:     * AplicarImagemBrancoProduto - cmdBranco.Valid legado: aplica a imagem
1931:     * "em branco" padrao (BrJpg.JPG do legado, migrada para vbmp\brjpg.jpg -
1932:     * gc_4c_CaminhoIcones) no produto corrente. Mesma gravacao de
1933:     * CapturarImagemProduto, sem o delete de SigPrPrt (o legado nao faz
1934:     * essa limpeza para esta opcao).
1935:     *==========================================================================
1936:     PROTECTED PROCEDURE AplicarImagemBrancoProduto(par_cCodProduto)
1937:         LOCAL loc_cArquivo, loc_cImagem, loc_oErro
1938: 
1939:         loc_cArquivo = gc_4c_CaminhoIcones + "brjpg.jpg"
1940: 
1941:         IF !FILE(loc_cArquivo)
1942:             MsgErro("O Arquivo " + UPPER(loc_cArquivo) + " N" + CHR(227) + "o Foi Encontrado!!!", ;
1943:                      "Figura em Branco N" + CHR(227) + "o Encontrada...")
1944:             RETURN
1945:         ENDIF
1946: 
1947:         *-- Mesma transferencia de ficha de CapturarImagemProduto, FORA do
1948:         *-- TRY pelo mesmo motivo (RETURN de guarda - regra #1)
1949:         IF !THIS.FormParaBO()
1950:             THIS.grd_4c_Produtos.Column1.SetFocus()
1951:             RETURN
1952:         ENDIF
1953: 
1954:         WAIT WINDOW "Aguarde!!! Transferindo a Imagem..." NOWAIT
1955: 
1956:         TRY
1957:             loc_cImagem = STRCONV(FILETOSTR(loc_cArquivo), 13)
1958: 
1959:             THIS.this_oBusinessObject.this_cCodProduto   = par_cCodProduto
1960:             THIS.this_oBusinessObject.this_cImagemBase64 = loc_cImagem
1961: 
1962:             IF THIS.this_oBusinessObject.Atualizar()
1963:                 THIS.AtualizarLinhaGradeComImagem(par_cCodProduto, loc_cImagem)
1964:                 WAIT CLEAR
1965:                 THIS.CarregarImagemProduto(par_cCodProduto)
1966:             ELSE
1967:                 WAIT CLEAR
1968:             ENDIF
1969:         CATCH TO loc_oErro
1970:             WAIT CLEAR
1971:             MsgErro(loc_oErro.Message + CHR(13) + ;
1972:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1973:                     "Procedure: " + loc_oErro.Procedure, "Erro em AplicarImagemBrancoProduto")
1974:         ENDTRY
1975: 
1976:         THIS.grd_4c_Produtos.Column1.SetFocus()
1977:     ENDPROC
1978: 
1979:     *==========================================================================
1980:     * AtualizarLinhaGradeComImagem - Espelha no cursor_4c_Produtos (grade)
1981:     * a imagem/datas que acabaram de ser gravadas em SigCdPro, para o
1982:     * DynamicForeColor (vermelho = sem imagem) e o proximo CarregarImagemProduto
1983:     * refletirem a gravacao sem precisar reconsultar o banco.
1984:     *==========================================================================
1985:     PROTECTED PROCEDURE AtualizarLinhaGradeComImagem(par_cCodProduto, par_cImagemBase64)
1986:         IF USED("cursor_4c_Produtos")
1987:             SELECT cursor_4c_Produtos
1988:             IF SEEK(par_cCodProduto, "cursor_4c_Produtos", "cpros")
1989:                 REPLACE figjpgs WITH par_cImagemBase64, ;
1990:                         dtfilms WITH DATETIME(), ;
1991:                         datas   WITH DATETIME() ;
1992:                         IN cursor_4c_Produtos
1993:             ENDIF
1994:             THIS.grd_4c_Produtos.Refresh()
1995:         ENDIF
1996:     ENDPROC
1997: 
1998:     *==========================================================================
1999:     * AbrirZoomImagemProduto - btnZoom.Click legado: decodifica a imagem do
2000:     * produto corrente para um JPG temporario e abre o Zoom (Do Form
2001:     * SigOpZom legado). SigOpZom.SCX ainda esta em ProximasMigracoes - mesmo
2002:     * padrao de fallback (FILE + CREATEOBJECT guardado + MsgAviso) usado em
2003:     * FormSigMvSbn/FormSigOpCpo/FormSigOpDoc/FormSigPrGlx.
2004:     *==========================================================================
2005:     PROTECTED PROCEDURE AbrirZoomImagemProduto(par_cCodProduto)
2006:         LOCAL loc_cArquivo, loc_cFoto, loc_cLinha2, loc_cLinha3, loc_oForm, loc_oErro
2007: 
2008:         IF !USED("cursor_4c_Produtos") OR !SEEK(par_cCodProduto, "cursor_4c_Produtos", "cpros")
2009:             RETURN
2010:         ENDIF
2011: 
2012:         IF EMPTY(cursor_4c_Produtos.figjpgs) OR ISNULL(cursor_4c_Produtos.figjpgs)
2013:             RETURN
2014:         ENDIF
2015: 
2016:         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2017:         loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Produtos.figjpgs, ;
2018:             "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
2019:             "data:image/jpg;base64,", ""), 14)
2020:         STRTOFILE(loc_cFoto, loc_cArquivo)
2021: 
2022:         IF !FILE(loc_cArquivo)
2023:             RETURN
2024:         ENDIF
2025: 
2026:         loc_cLinha2 = "Produto : " + ALLTRIM(cursor_4c_Produtos.cpros) + " - " + ALLTRIM(cursor_4c_Produtos.dpros)
2027:         loc_cLinha3 = "Fornecedor : " + ALLTRIM(cursor_4c_Produtos.ifors) + " - Refer" + CHR(234) + "ncia : " + ALLTRIM(cursor_4c_Produtos.reffs)
2028: 
2029:         TRY
2030:             loc_oForm = CREATEOBJECT("FormSigOpZom", loc_cArquivo, loc_cLinha2, loc_cLinha3)
2031:         CATCH TO loc_oErro
2032:             loc_oForm = .NULL.
2033:         ENDTRY
2034: 
2035:         IF VARTYPE(loc_oForm) = "O"
2036:             loc_oForm.Show()
2037:         ELSE
2038:             MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
2039:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
2040:                 "Aviso")
2041:         ENDIF
2042: 
2043:         IF FILE(loc_cArquivo)
2044:             DELETE FILE (loc_cArquivo)
2045:         ENDIF
2046: 
2047:         THIS.grd_4c_Produtos.SetFocus()
2048:     ENDPROC
2049: 
2050:     *==========================================================================
2051:     * AjustarControlesPorModo - Equivalente ao bloco de Enabled do PROCEDURE
2052:     * AcertaForm legado (LParameters llEna): par_lModoFiltro = .T. habilita
2053:     * os campos de FILTRO (periodo/grupo/produto/linha/situacao de imagem +
2054:     * Processar) e desabilita busca/grade/"Limpar Sel." - o inverso quando
2055:     * .F. (modo RESULTADO, apos Processar).
2056:     *
2057:     * cmdgFigura.cmdFigura/cmdBranco/btnZoom (obj_4c_CmdgFigura.Buttons(1/2/3))
2058:     * seguem o MESMO "Not llEna" do legado - habilitados so em RESULTADO.
2059:     * Buttons(3) (Zoom) ainda combina com a presenca de imagem na linha
2060:     * corrente, via AtualizarEstadoBotaoZoom (equivalente ao btnZoom.When).
2061:     *==========================================================================
2062:     PROTECTED PROCEDURE AjustarControlesPorModo(par_lModoFiltro)
2063:         THIS.this_lModoFiltroAtual = par_lModoFiltro
2064: 
2065:         *-- LockScreen em volta do bloco inteiro, como no AcertaForm legado:
2066:         *-- sao ~20 trocas de Enabled e a tela "pisca" sem isso
2067:         THIS.LockScreen = .T.
2068: 
2069:         THIS.HabilitarCampos(par_lModoFiltro)
2070:         THIS.AjustarBotoesPorModo()
2071: 
2072:         THIS.LockScreen = .F.
2073: 
2074:         IF THIS.Visible
2075:             IF par_lModoFiltro
2076:                 THIS.txt_4c_DataIni.SetFocus()
2077:             ELSE
2078:                 THIS.grd_4c_Produtos.Column1.SetFocus()
2079:             ENDIF
2080:         ENDIF
2081:     ENDPROC
2082: 
2083:     *==========================================================================
2084:     * HabilitarCampos - Metade de CAMPOS do AcertaForm legado (LParameters
2085:     * llEna). par_lHabilitar = .T. (modo FILTRO) habilita periodo/grupo/
2086:     * produto/linha/situacao de imagem; .F. (modo RESULTADO) habilita a
2087:     * grade e as caixas de "Procurar".
2088:     *
2089:     * Transcricao literal do legado, inclusive nas ASSIMETRIAS: das 4 caixas
2090:     * de Procurar, o AcertaForm so toca getCPros e getReffs - getDPros e
2091:     * getIFors ficam sempre habilitadas. Uniformizar aqui mudaria o
2092:     * comportamento da tela (PILAR 1).
2093:     *
2094:     * par_lHabilitar eh OPCIONAL: sem argumento assume o modo corrente
2095:     * (this_lModoFiltroAtual), para poder ser chamado de fora sem conhecer
2096:     * o estado interno.
2097:     *==========================================================================
2098:     PROCEDURE HabilitarCampos(par_lHabilitar)
2099:         LOCAL loc_lHabilitar
2100: 
2101:         loc_lHabilitar = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", ;
2102:             par_lHabilitar, THIS.this_lModoFiltroAtual)
2103: 
2104:         WITH THIS
2105:             .txt_4c_DataIni.Enabled     = loc_lHabilitar
2106:             .txt_4c_DataFim.Enabled     = loc_lHabilitar
2107:             .txt_4c_Grupo.Enabled       = loc_lHabilitar
2108:             .txt_4c_DescGrupo.Enabled   = loc_lHabilitar
2109:             .txt_4c_Produto.Enabled     = loc_lHabilitar
2110:             .txt_4c_DescProduto.Enabled = loc_lHabilitar
2111:             .txt_4c_Linha.Enabled       = loc_lHabilitar
2112:             .txt_4c_DescLinha.Enabled   = loc_lHabilitar
2113: 
2114:             .opt_4c_TipoImagem.Buttons(1).Enabled = loc_lHabilitar
2115:             .opt_4c_TipoImagem.Buttons(2).Enabled = loc_lHabilitar
2116:             .opt_4c_TipoImagem.Buttons(3).Enabled = loc_lHabilitar
2117: 
2118:             *-- "Not llEna" do legado: so valem no modo RESULTADO
2119:             .txt_4c_BuscaCodigo.Enabled     = !loc_lHabilitar
2120:             .txt_4c_BuscaReferencia.Enabled = !loc_lHabilitar
2121:             .grd_4c_Produtos.Enabled        = !loc_lHabilitar
2122:         ENDWITH
2123:     ENDPROC
2124: 
2125:     *==========================================================================
2126:     * AjustarBotoesPorModo - Metade de BOTOES do AcertaForm legado, lida do
2127:     * modo corrente (this_lModoFiltroAtual):
2128:     *   modo FILTRO    -> so "Processar" (cmdSelecionar) habilitado
2129:     *   modo RESULTADO -> "Limpar Sel." (btnLimpar) + Imagem/Branco/Zoom
2130:     *                     (cmdgFigura.cmdFigura/cmdBranco/btnZoom)
2131:     *
2132:     * "Encerrar" (cmg_4c_Limpar.Buttons(2)) fica SEMPRE habilitado: o legado
2133:     * nao o inclui no AcertaForm, e desabilita-lo tiraria a unica saida da
2134:     * tela no modo filtro (o form tem ControlBox = .F.).
2135:     *
2136:     * Buttons(3) (Zoom) ainda depende de o produto corrente ter imagem -
2137:     * essa parte fica em AtualizarEstadoBotaoZoom (btnZoom.When legado),
2138:     * chamado no fim.
2139:     *
2140:     * PUBLIC: o TesteAutomatico.prg chama este metodo de FORA da classe
2141:     * (regra #3 - PEMSTATUS nao distingue PROTECTED).
2142:     *==========================================================================
2143:     PROCEDURE AjustarBotoesPorModo()
2144:         LOCAL loc_lModoFiltro
2145: 
2146:         loc_lModoFiltro = THIS.this_lModoFiltroAtual
2147: 
2148:         WITH THIS
2149:             .cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lModoFiltro
2150: 
2151:             .cnt_4c_Botoes.cmg_4c_Limpar.Buttons(1).Enabled = !loc_lModoFiltro
2152:             .cnt_4c_Botoes.cmg_4c_Limpar.Buttons(2).Enabled = .T.
2153: 
2154:             IF PEMSTATUS(.cnt_4c_BotoesAcao, "obj_4c_CmdgFigura", 5)
2155:                 .cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(1).Enabled = !loc_lModoFiltro
2156:                 .cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(2).Enabled = !loc_lModoFiltro
2157:             ENDIF
2158:         ENDWITH
2159: 
2160:         THIS.AtualizarEstadoBotaoZoom()
2161:     ENDPROC
2162: 
2163:     *==========================================================================
2164:     * EsvaziarCursorProdutos - "Zap In csProdutos" do legado.
2165:     *
2166:     * O ZAP tem de ser cercado por SET SAFETY OFF: SET SAFETY eh escopado por
2167:     * DATA SESSION e este form eh DataSession = 2, logo o SET SAFETY OFF do
2168:     * main.prg NAO alcanca a sessao privada - com SAFETY ON o ZAP abre o
2169:     * dialogo modal "Zap ... Are you sure?" e CONGELA a tela.
2170:     *
2171:     * ZAP (e nao USE IN + CREATE CURSOR) porque fechar e recriar o alias
2172:     * derrubaria Grid.RecordSource e as Column.ControlSource ligadas no
2173:     * ConfigurarGrid, deixando a grade vazia com o cursor cheio.
2174:     *==========================================================================
2175:     PROTECTED PROCEDURE EsvaziarCursorProdutos()
2176:         LOCAL loc_cSafety
2177: 
2178:         IF USED("cursor_4c_Produtos")
2179:             loc_cSafety = SET("SAFETY")
2180:             SET SAFETY OFF
2181: 
2182:             SELECT cursor_4c_Produtos
2183:             ZAP
2184: 
2185:             IF loc_cSafety = "ON"
2186:                 SET SAFETY ON
2187:             ENDIF
2188:         ENDIF
2189:     ENDPROC
2190: 
2191:     *==========================================================================
2192:     * TornarControlesVisiveis - Torna visiveis recursivamente os controles
2193:     * criados via AddObject (que nascem com Visible=.F.)
2194:     *==========================================================================
2195:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2196:         LOCAL loc_nI, loc_oControl
2197: 
2198:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2199:             loc_oControl = par_oContainer.Controls(loc_nI)
2200:             IF VARTYPE(loc_oControl) = "O"
2201:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2202:                     loc_oControl.Visible = .T.
2203:                 ENDIF
2204: 
2205:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2206:                     THIS.TornarControlesVisiveis(loc_oControl)
2207:                 ENDIF
2208:             ENDIF
2209:         ENDFOR
2210:     ENDPROC
2211: 
2212:     *==========================================================================
2213:     * Destroy - Libera cursores e recursos
2214:     *==========================================================================
2215:     PROCEDURE Destroy()
2216:         IF USED("cursor_4c_Produtos")
2217:             USE IN cursor_4c_Produtos
2218:         ENDIF
2219:         IF USED("cursor_4c_ProdutosTemp")
2220:             USE IN cursor_4c_ProdutosTemp
2221:         ENDIF
2222:         DODEFAULT()
2223:     ENDPROC
2224: 
2225: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpImgBO.prg):
*====================================================================
* SigOpImgBO.prg
*
* Business Object para Captura de Imagens de Produtos
* Tabela principal: SigCdPro
* Herda de: BusinessBase
*
* Origem: SigOpImg.SCX (Framework legado Fortyus)
* Form OPERACIONAL - selecao de produtos por filtro (periodo de
* inclusao, grupo, produto, linha, situacao de imagem) + captura/
* visualizacao/exclusao da imagem (FigJpgs) do produto selecionado.
*====================================================================

DEFINE CLASS SigOpImgBO AS BusinessBase

    *-- Propriedades de FILTRO (tela de selecao - optImagem/getDtIni/
    *-- getDtFin/getGrupo/getDGrupo/getCProsF/getDProsF/getLin/getDLin)
    this_dDataIni           = {}    && getDtIni.Value  - periodo de inclusao (data inicial)
    this_dDataFin           = {}    && getDtFin.Value  - periodo de inclusao (data final)
    this_nTipoImagem        = 0     && optImagem.Value - 1=Sem Imagem, 2=Com Imagem, 3=Geral
    this_cGrupoFiltro       = ""    && getGrupo.Value    - cgrus char(3) do filtro
    this_cDescGrupoFiltro   = ""    && getDGrupo.Value   - descricao do grupo filtro (SigCdGrp.dgrus)
    this_cProdutoFiltro     = ""    && getCProsF.Value   - cpros char(14) do filtro
    this_cDescProdutoFiltro = ""    && getDProsF.Value   - descricao do produto filtro (dpros)
    this_cLinhaFiltro       = ""    && getLin.Value      - linhas char(10) do filtro
    this_cDescLinhaFiltro   = ""    && getDLin.Value     - descricao da linha filtro (SigCdLin.descs)

    *-- Propriedades do PRODUTO CORRENTE (linha selecionada na grade,
    *-- originadas de SigCdPro/cursor de listagem csProdutos)
    this_cCodProduto     = ""    && cpros char(14) - PK
    this_cDescProduto    = ""    && dpros char(65) (65 no banco, 40 no cursor legado de listagem)
    this_cCodFornecedor  = ""    && ifors char(10)
    this_cReferencia     = ""    && reffs char(40)
    this_cCodGrupo       = ""    && cgrus char(3)
    this_cCodLinha       = ""    && linhas char(10)
    this_cImagemBase64   = ""    && figjpgs text (memo) - imagem em base64/binario
    this_dDataFilme      = {}    && dtfilms datetime - data/hora da ultima transferencia de imagem
    this_dDataInclusao   = {}    && dtincs  datetime - data de inclusao do produto
    this_dData           = {}    && datas   datetime - data da ultima alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "cpros"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpImgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do PRODUTO CORRENTE a
    * partir de um cursor posicionado em SigCdPro (SELECT * ou lista de
    * colunas equivalente ao csProdutos do legado: DtFilms, DtIncs,
    * Datas, CPros, DPros, IFors, Reffs, CGrus, Linhas, FigJpgs)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodProduto    = ALLTRIM(TratarNulo(cpros, ""))
        THIS.this_cDescProduto   = ALLTRIM(TratarNulo(dpros, ""))
        THIS.this_cCodFornecedor = ALLTRIM(TratarNulo(ifors, ""))
        THIS.this_cReferencia    = ALLTRIM(TratarNulo(reffs, ""))
        THIS.this_cCodGrupo      = ALLTRIM(TratarNulo(cgrus, ""))
        THIS.this_cCodLinha      = ALLTRIM(TratarNulo(linhas, ""))
        THIS.this_cImagemBase64  = TratarNulo(figjpgs, "")
        THIS.this_dDataFilme     = ConverterParaData(TratarNulo(dtfilms, {}))
        THIS.this_dDataInclusao  = ConverterParaData(TratarNulo(dtincs, {}))
        THIS.this_dData          = ConverterParaData(TratarNulo(datas, {}))

        RETURN .T.
    ENDPROC

    *====================================================================
    * ValidarDados - Valida o produto corrente antes de atualizar a
    * imagem (coluna FigJpgs de SigCdPro)
    *====================================================================
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodProduto))
            THIS.this_cMensagemErro = "Nenhum produto selecionado para atualizar a imagem."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do produto corrente (cpros)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodProduto, ""))
    ENDPROC

    *====================================================================
    * Atualizar - Grava a imagem (FigJpgs) do produto corrente em
    * SigCdPro, atualizando tambem DtFilms (data da transferencia) e
    * Datas (data da ultima alteracao). Reproduz o Update/Commit feito
    * pelo legado apos CmdgFigura.Valid (capturar imagem) e apos a
    * opcao de imagem em branco - as duas acoes sao a MESMA gravacao,
    * apenas com this_cImagemBase64 vazio ou preenchido.
    *
    * Este formulario (SigOpImg) so atualiza a imagem de produtos JA
    * cadastrados em SigCdPro - o cadastro completo do produto (Inserir)
    * e feito pelo ProdutoBO/FormProduto, e nao ha exclusao de registro
    * aqui. Por isso Inserir()/ExecutarExclusao() permanecem herdados de
    * BusinessBase (nunca chamados por este formulario).
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "figjpgs = " + EscaparSQL(THIS.this_cImagemBase64) + ", " + ;
                "dtfilms = GETDATE(), " + ;
                "datas = GETDATE() " + ;
                "WHERE cpros = " + EscaparSQL(THIS.this_cCodProduto)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_dDataFilme = DATE()
                THIS.this_dData      = DATE()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a imagem do produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpImgBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparPreviewImpressao - "Delete From SigPrPrt Where Cpros = ..."
    * do cmdFigura.Valid legado: apaga a previsualizacao de impressao em
    * cache do produto antes de gravar a nova imagem (so a opcao "Imagem"
    * faz essa limpeza no legado; "Branco" nao chama este metodo).
    *====================================================================
    PROCEDURE LimparPreviewImpressao(par_cCodProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodProduto) != "C" OR EMPTY(ALLTRIM(par_cCodProduto))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)
        CATCH TO loc_oErro
            *-- Limpeza de cache de previsualizacao - falha aqui nao pode
            *-- bloquear a gravacao da imagem (que eh a acao principal),
            *-- mas o erro precisa ficar visivel (regra #9 - CATCH nunca
            *-- silencioso).
            MsgErro(loc_oErro.Message, "SigOpImgBO.LimparPreviewImpressao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processar - Busca em SigCdPro os produtos que atendem aos filtros
    * correntes (this_dDataIni/this_dDataFin/this_nTipoImagem/
    * this_cGrupoFiltro/this_cProdutoFiltro/this_cLinhaFiltro) e devolve
    * o resultado em par_cCursorDestino via SQLEXEC (cursor TEMPORARIO -
    * quem repopula o cursor ligado ao Grid eh o Form, via ZAP + APPEND
    * FROM DBF, nunca SQLEXEC direto no alias do Grid).
    *
    * Equivalente ao PROCEDURE Processamento do legado (SigOpImg.SCX):
    * mesmo WHERE (DtIncs Between, FigJpgs Is [Not] Null, CPros/CGrus/
    * Linhas quando informados) e mesmo Order By CPros.
    *====================================================================
    PROCEDURE Processar(par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDtIni, loc_cDtFin, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            THIS.this_cMensagemErro = "Cursor de destino n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Limite superior do periodo com hora 23:59:59, igual ao
            *-- "pDtF = fDtoSQL(ThisForm.getDtFin.Value, '23:59:59')" legado
            loc_cDtIni = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFin = "'" + PADL(YEAR(THIS.this_dDataFin), 4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDataFin), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDataFin), 2, "0") + " 23:59:59'"

            loc_cSQL = "SELECT dtfilms, dtincs, datas, cpros, dpros, ifors, reffs, cgrus, linhas, figjpgs " + ;
                "FROM SigCdPro " + ;
                "WHERE dtincs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin

            DO CASE
                CASE THIS.this_nTipoImagem = 1
                    loc_cSQL = loc_cSQL + " AND figjpgs IS NULL"
                CASE THIS.this_nTipoImagem = 2
                    loc_cSQL = loc_cSQL + " AND figjpgs IS NOT NULL"
            ENDCASE

            IF !EMPTY(ALLTRIM(NVL(THIS.this_cProdutoFiltro, "")))
                loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cProdutoFiltro))
            ENDIF
            IF !EMPTY(ALLTRIM(NVL(THIS.this_cGrupoFiltro, "")))
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupoFiltro))
            ENDIF
            IF !EMPTY(ALLTRIM(NVL(THIS.this_cLinhaFiltro, "")))
                loc_cSQL = loc_cSQL + " AND linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLinhaFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cpros"

            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel buscar os produtos." + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

