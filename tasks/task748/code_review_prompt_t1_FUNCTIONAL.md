# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrupoFiltroLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrupoFiltroLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDescGrupoFiltroLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDescGrupoFiltroLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarProdutoFiltroLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarProdutoFiltroLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDescProdutoFiltroLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDescProdutoFiltroLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarLinhaFiltroLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarLinhaFiltroLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDescLinhaFiltroLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDescLinhaFiltroLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpImg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2147 linhas total):

*-- Linhas 31 a 362:
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
41:     *-- Estado para habilitar obj_4c_CmdgFigura.Buttons(3) (Zoom) - so fica
42:     *-- habilitado em modo RESULTADO (par_lModoFiltro = .F.) E com o produto
43:     *-- corrente tendo imagem (btnZoom.When legado: Not Empty(FigJpgs))
44:     this_lModoFiltroAtual   = .T.
45:     this_lProdutoTemImagem  = .F.
46: 
47:     *==========================================================================
48:     * Init - Inicializacao do formulario
49:     *==========================================================================
50:     PROCEDURE Init()
51:         THIS.Caption = "Captura de Imagens"
52:         RETURN DODEFAULT()
53:     ENDPROC
54: 
55:     *==========================================================================
56:     * InicializarForm - Instancia o SigOpImgBO e cria a estrutura visual base
57:     *==========================================================================
58:     PROTECTED PROCEDURE InicializarForm()
59:         LOCAL loc_lSucesso, loc_oErro
60:         loc_lSucesso = .F.
61: 
62:         TRY
63:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
64:             SET DATE TO BRITISH
65:             SET CENTURY ON
66: 
67:             *-- Equivalente ao Load legado (Create Cursor csProdutos) -
68:             *-- precisa existir ANTES do BO e da grade
69:             THIS.ConfigurarCursorProdutos()
70: 
71:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpImgBO")
72:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
73:                 *-- Defaults do Init legado (getDtIni.Value=Date()-1,
74:                 *-- getDtFin.Value=Date(), optImagem.Value=1 "Sem Imagem")
75:                 THIS.this_oBusinessObject.this_dDataIni    = DATE() - 1
76:                 THIS.this_oBusinessObject.this_dDataFin    = DATE()
77:                 THIS.this_oBusinessObject.this_nTipoImagem = 1
78: 
79:                 THIS.ConfigurarPageFrame()
80: 
81:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
83: 
84:                 *-- Equivalente a "ThisForm.AcertaForm(.t.)" no fim do Init legado
85:                 THIS.AjustarControlesPorModo(.T.)
86: 
87:                 THIS.TornarControlesVisiveis(THIS)
88:                 THIS.Visible = .T.
89:                 loc_lSucesso = .T.
90:             ELSE
91:                 MsgErro("Falha ao criar SigOpImgBO.", "Erro em InicializarForm")
92:             ENDIF
93:         CATCH TO loc_oErro
94:             MsgErro(loc_oErro.Message + CHR(13) + ;
95:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
96:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
97:         ENDTRY
98: 
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *==========================================================================
103:     * ConfigurarPageFrame - Orquestra a criacao da estrutura visual base.
104:     * Form FLAT (legado SIGOPIMG nao tem PageFrame/abas): cabecalho, moldura
105:     * + area de imagem, container dos botoes de periodo/encerramento,
106:     * container do grupo cmdgFigura e a grade de produtos.
107:     *
108:     * ORDEM = z-order do SCX legado: Shape3 eh o PRIMEIRO objeto da arvore
109:     * (antes de cntSombra) e ImgFigJpg desenha por cima dele; o container
110:     * transparente cnt_4c_BotoesAcao encosta 4px no Shape (Left 220..224
111:     * contra 23..224) e por isso vem DEPOIS da moldura. Criar o Shape por
112:     * ultimo o deixaria por cima do container, cobrindo esses 4px (regra #30).
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarPageFrame()
115:         THIS.ConfigurarCabecalho()
116:         THIS.ConfigurarImagem()
117:         THIS.ConfigurarContainerBotoes()
118:         THIS.ConfigurarContainerBotoesAcao()
119:         THIS.ConfigurarFiltros()
120:         THIS.ConfigurarFiltrosLinhaImagem()
121:         THIS.ConfigurarGrid()
122:         THIS.ConfigurarBusca()
123:     ENDPROC
124: 
125:     *==========================================================================
126:     * ConfigurarCursorProdutos - Cria cursor_4c_Produtos (csProdutos legado),
127:     * cursor local que alimenta a grade. Estrutura e indices identicos ao
128:     * Create Cursor + 6 Index On do PROCEDURE Load legado.
129:     *==========================================================================
130:     PROTECTED PROCEDURE ConfigurarCursorProdutos()
131:         IF USED("cursor_4c_Produtos")
132:             USE IN cursor_4c_Produtos
133:         ENDIF
134: 
135:         CREATE CURSOR cursor_4c_Produtos ( ;
136:             dtfilms D NULL, ;
137:             dtincs  D NULL, ;
138:             datas   D NULL, ;
139:             cpros   C(14), ;
140:             dpros   C(40), ;
141:             ifors   C(10), ;
142:             reffs   C(40), ;
143:             cgrus   C(3), ;
144:             linhas  C(10), ;
145:             figjpgs M NULL)
146: 
147:         INDEX ON cpros          TAG cpros
148:         INDEX ON dpros + cpros  TAG dpros
149:         INDEX ON ifors + cpros  TAG ifors
150:         INDEX ON reffs + cpros  TAG reffs
151:         INDEX ON cgrus + cpros  TAG cgrus
152:         INDEX ON linhas + cpros TAG linhas
153:     ENDPROC
154: 
155:     *==========================================================================
156:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
157:     * Original: cntSombra Top=0, Left=0, Width=1100, Height=80,
158:     *           BackColor=RGB(100,100,100) (framework.vcx cntSombra)
159:     *==========================================================================
160:     PROTECTED PROCEDURE ConfigurarCabecalho()
161:         LOCAL loc_oErro
162:         TRY
163:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
164:             WITH THIS.cnt_4c_Cabecalho
165:                 .Top         = 0
166:                 .Left        = 0
167:                 .Width       = THIS.Width
168:                 .Height      = 80
169:                 .BackStyle   = 1
170:                 .BackColor   = RGB(100, 100, 100)
171:                 .BorderWidth = 0
172:                 .Visible     = .T.
173:             ENDWITH
174: 
175:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
176:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
177:                 .FontBold      = .T.
178:                 .FontName      = "Tahoma"
179:                 .FontSize      = 18
180:                 .FontUnderline = .F.
181:                 .WordWrap      = .T.
182:                 .Alignment     = 0
183:                 .BackStyle     = 0
184:                 .AutoSize      = .F.
185:                 .Caption       = THIS.Caption
186:                 .Height        = 40
187:                 .Left          = 10
188:                 .Top           = 18
189:                 .Width         = THIS.Width - 20
190:                 .ForeColor     = RGB(0, 0, 0)
191:                 .Visible       = .T.
192:             ENDWITH
193: 
194:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
195:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
196:                 .FontBold      = .T.
197:                 .FontName      = "Tahoma"
198:                 .FontSize      = 18
199:                 .WordWrap      = .T.
200:                 .Alignment     = 0
201:                 .BackStyle     = 0
202:                 .AutoSize      = .F.
203:                 .Caption       = THIS.Caption
204:                 .Height        = 46
205:                 .Left          = 10
206:                 .Top           = 17
207:                 .Width         = THIS.Width - 20
208:                 .ForeColor     = RGB(255, 255, 255)
209:                 .ToolTipText   = "T" + CHR(237) + "tulo"
210:                 .Visible       = .T.
211:             ENDWITH
212:         CATCH TO loc_oErro
213:             MsgErro(loc_oErro.Message + CHR(13) + ;
214:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
215:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
216:         ENDTRY
217:     ENDPROC
218: 
219:     *==========================================================================
220:     * ConfigurarContainerBotoes - Container flutuante sobre a faixa do
221:     * cabecalho (BackStyle=0) com cmd_4c_Processar (cmdSelecionar legado) e
222:     * cmg_4c_Limpar (cmdBtnForm legado - "Limpar Sel." / "Encerrar").
223:     * Original: cmdSelecionar Top=3, Left=775, W=75, H=75 +
224:     *           cmdBtnForm     Top=-2, Left=845, W=160, H=85
225:     *==========================================================================
226:     PROTECTED PROCEDURE ConfigurarContainerBotoes()
227:         LOCAL loc_oErro
228:         TRY
229:             THIS.AddObject("cnt_4c_Botoes", "Container")
230:             WITH THIS.cnt_4c_Botoes
231:                 .Top         = 0
232:                 .Left        = 770
233:                 .Width       = 235
234:                 .Height      = 85
235:                 .BackStyle   = 0
236:                 .BorderWidth = 0
237:                 .Visible     = .T.
238:             ENDWITH
239: 
240:             *-- cmd_4c_Processar (cmdSelecionar legado) - Left relativo = 775-770
241:             THIS.cnt_4c_Botoes.AddObject("cmd_4c_Processar", "CommandButton")
242:             WITH THIS.cnt_4c_Botoes.cmd_4c_Processar
243:                 .Top             = 3
244:                 .Left            = 5
245:                 .Width           = 75
246:                 .Height          = 75
247:                 .FontBold        = .T.
248:                 .FontItalic      = .T.
249:                 .FontName        = "Comic Sans MS"
250:                 .FontSize        = 8
251:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
252:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
253:                 .Caption         = "Processar"
254:                 .ForeColor       = RGB(90, 90, 90)
255:                 .BackColor       = RGB(255, 255, 255)
256:                 .Themes          = .T.
257:                 .Visible         = .T.
258:             ENDWITH
259:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
260: 
261:             *-- cmg_4c_Limpar (cmdBtnForm legado) - Left relativo = 845-770
262:             THIS.cnt_4c_Botoes.AddObject("cmg_4c_Limpar", "CommandGroup")
263:             WITH THIS.cnt_4c_Botoes.cmg_4c_Limpar
264:                 .Top         = -2
265:                 .Left        = 75
266:                 .Width       = 160
267:                 .Height      = 85
268:                 .ButtonCount = 2
269:                 .BackStyle   = 0
270:                 .BorderStyle = 0
271:                 .Value       = 0
272:                 .Visible     = .T.
273: 
274:                 WITH .Buttons(1)
275:                     .Top        = 5
276:                     .Left       = 5
277:                     .Width      = 75
278:                     .Height     = 75
279:                     .FontBold   = .T.
280:                     .FontItalic = .T.
281:                     .FontName   = "Comic Sans MS"
282:                     .FontSize   = 8
283:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
284:                     .Caption    = "\<Limpar Sel."
285:                     .ForeColor  = RGB(90, 90, 90)
286:                     .BackColor  = RGB(255, 255, 255)
287:                     .Themes     = .F.
288:                 ENDWITH
289: 
290:                 WITH .Buttons(2)
291:                     .Top        = 5
292:                     .Left       = 80
293:                     .Width      = 75
294:                     .Height     = 75
295:                     .FontBold   = .T.
296:                     .FontItalic = .T.
297:                     .FontName   = "Comic Sans MS"
298:                     .FontSize   = 8
299:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
300:                     .Cancel     = .T.
301:                     .Caption    = "Encerrar"
302:                     .ForeColor  = RGB(90, 90, 90)
303:                     .BackColor  = RGB(255, 255, 255)
304:                     .Themes     = .F.
305:                 ENDWITH
306:             ENDWITH
307:             BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_Limpar, "Click", THIS, "CmgLimparClick")
308:         CATCH TO loc_oErro
309:             MsgErro(loc_oErro.Message + CHR(13) + ;
310:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
311:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoes")
312:         ENDTRY
313:     ENDPROC
314: 
315:     *==========================================================================
316:     * ConfigurarContainerBotoesAcao - Container que hospeda o grupo
317:     * cmdgFigura do legado (Imagem / Branco / Zoom), ao lado da moldura da
318:     * imagem do produto. Os tres botoes operam o campo FigJpgs do produto
319:     * corrente e sao montados junto com os handlers de imagem.
320:     * Original: cmdgFigura Top=492, Left=224, W=235, H=85
321:     *==========================================================================
322:     PROTECTED PROCEDURE ConfigurarContainerBotoesAcao()
323:         LOCAL loc_oErro
324:         TRY
325:             THIS.AddObject("cnt_4c_BotoesAcao", "Container")
326:             WITH THIS.cnt_4c_BotoesAcao
327:                 .Top         = 485
328:                 .Left        = 220
329:                 .Width       = 245
330:                 .Height      = 90
331:                 .BackStyle   = 0
332:                 .BorderWidth = 0
333:                 .Visible     = .T.
334:             ENDWITH
335: 
336:             *-- obj_4c_CmdgFigura (cmdgFigura legado) - Imagem / Branco / Zoom
337:             *-- Left relativo = 224-220. Picture/Caption/ordem transcritos do
338:             *-- dump do SCX (tasks\task748\SigOpImg_form_codigo_fonte.txt:778-823).
339:             THIS.cnt_4c_BotoesAcao.AddObject("obj_4c_CmdgFigura", "CommandGroup")
340:             WITH THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura
341:                 .Top         = 7
342:                 .Left        = 4
343:                 .Width       = 235
344:                 .Height      = 85
345:                 .ButtonCount = 3
346:                 .BackStyle   = 0
347:                 .BorderStyle = 0
348:                 .Value       = 0
349:                 .Visible     = .T.
350: 
351:                 WITH .Buttons(1)
352:                     .Top        = 5
353:                     .Left       = 5
354:                     .Width      = 75
355:                     .Height     = 75
356:                     .FontBold   = .T.
357:                     .FontItalic = .T.
358:                     .FontName   = "Comic Sans MS"
359:                     .FontSize   = 8
360:                     .Picture    = gc_4c_CaminhoIcones + "geral_selo_60.jpg"
361:                     .Caption    = "Imagem"
362:                     .ForeColor  = RGB(90, 90, 90)

*-- Linhas 400 a 466:
400:                     .Enabled    = .F.
401:                 ENDWITH
402:             ENDWITH
403:             BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
404:         CATCH TO loc_oErro
405:             MsgErro(loc_oErro.Message + CHR(13) + ;
406:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
407:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesAcao")
408:         ENDTRY
409:     ENDPROC
410: 
411:     *==========================================================================
412:     * ConfigurarFiltros - Campos principais do filtro de selecao (PARTE 1):
413:     * Periodo de Inclusao (getDtIni/getDtFin), Grupo (getGrupo/getDGrupo) e
414:     * Produto (getCProsF/getDProsF), com os respectivos lookups. Linha
415:     * (getLin/getDLin) e Situacao de Imagem (optImagem) ficam em
416:     * ConfigurarFiltrosLinhaImagem() (PARTE 2).
417:     *
418:     * Posicoes/Captions transcritas literalmente do dump do SCX legado
419:     * (tasks\task748\layout.json) - direto em THIS, sem container, porque
420:     * o legado tambem os cria direto na SIGOPIMG (form FLAT, sem Pagina).
421:     *
422:     * Valores iniciais vem das properties do BO (ja definidas no
423:     * InicializarForm antes deste metodo rodar); a volta (TextBox -> BO) eh
424:     * feita por FormParaBO(), chamado no inicio de BtnProcessarClick.
425:     *==========================================================================
426:     PROTECTED PROCEDURE ConfigurarFiltros()
427:         LOCAL loc_oErro
428:         TRY
429:             THIS.AddObject("lbl_4c_Periodo", "Label")
430:             WITH THIS.lbl_4c_Periodo
431:                 .Top       = 94
432:                 .Left      = 189
433:                 .Width     = 140
434:                 .Height    = 15
435:                 .Alignment = 0
436:                 .BackStyle = 0
437:                 .AutoSize  = .F.
438:                 .FontName  = "Tahoma"
439:                 .FontSize  = 8
440:                 .ForeColor = RGB(90, 90, 90)
441:                 .Caption   = "Per" + CHR(237) + "odo de Inclus" + CHR(227) + "o :"
442:                 .Visible   = .T.
443:             ENDWITH
444: 
445:             THIS.AddObject("txt_4c_DataIni", "TextBox")
446:             WITH THIS.txt_4c_DataIni
447:                 .Top      = 90
448:                 .Left     = 294
449:                 .Width    = 90
450:                 .Height   = 23
451:                 .FontName = "Tahoma"
452:                 .FontSize = 8
453:                 .Value    = NVL(THIS.this_oBusinessObject.this_dDataIni, {})
454:                 .Visible  = .T.
455:             ENDWITH
456: 
457:             THIS.AddObject("lbl_4c_PeriodoA", "Label")
458:             WITH THIS.lbl_4c_PeriodoA
459:                 .Top       = 94
460:                 .Left      = 380
461:                 .Width     = 15
462:                 .Height    = 15
463:                 .Alignment = 0
464:                 .BackStyle = 0
465:                 .AutoSize  = .F.
466:                 .FontName  = "Tahoma"

*-- Linhas 573 a 685:
573:             *-- Lookups (equivalentes ao Valid legado de getGrupo/getDGrupo e
574:             *-- getCProsF/getDProsF) - vao em LostFocus, nunca em KeyPress sem
575:             *-- testar a tecla (regra #47)
576:             BINDEVENT(THIS.txt_4c_Grupo,       "LostFocus", THIS, "ValidarGrupoFiltroLostFocus")
577:             BINDEVENT(THIS.txt_4c_DescGrupo,   "LostFocus", THIS, "ValidarDescGrupoFiltroLostFocus")
578:             BINDEVENT(THIS.txt_4c_Produto,     "LostFocus", THIS, "ValidarProdutoFiltroLostFocus")
579:             BINDEVENT(THIS.txt_4c_DescProduto, "LostFocus", THIS, "ValidarDescProdutoFiltroLostFocus")
580:         CATCH TO loc_oErro
581:             MsgErro(loc_oErro.Message + CHR(13) + ;
582:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
583:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
584:         ENDTRY
585:     ENDPROC
586: 
587:     *==========================================================================
588:     * ConfigurarFiltrosLinhaImagem - Ultimos campos do filtro de selecao
589:     * (PARTE 2): Linha (getLin/getDLin) e Situacao de Imagem (optImagem).
590:     * Posicoes/Captions transcritas literalmente do dump do SCX legado.
591:     *==========================================================================
592:     PROTECTED PROCEDURE ConfigurarFiltrosLinhaImagem()
593:         LOCAL loc_oErro
594:         TRY
595:             THIS.AddObject("lbl_4c_Linha", "Label")
596:             WITH THIS.lbl_4c_Linha
597:                 .Top       = 168
598:                 .Left      = 258
599:                 .Width     = 34
600:                 .Height    = 15
601:                 .Alignment = 0
602:                 .BackStyle = 0
603:                 .AutoSize  = .F.
604:                 .FontName  = "Tahoma"
605:                 .FontSize  = 8
606:                 .ForeColor = RGB(90, 90, 90)
607:                 .Caption   = "Linha :"
608:                 .Visible   = .T.
609:             ENDWITH
610: 
611:             *-- linhas char(10) - SigCdLin
612:             THIS.AddObject("txt_4c_Linha", "TextBox")
613:             WITH THIS.txt_4c_Linha
614:                 .Top       = 165
615:                 .Left      = 294
616:                 .Width     = 108
617:                 .Height    = 23
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 8
620:                 .MaxLength = 10
621:                 .Value     = NVL(THIS.this_oBusinessObject.this_cLinhaFiltro, "")
622:                 .Visible   = .T.
623:             ENDWITH
624: 
625:             *-- descs char(40) - SigCdLin
626:             THIS.AddObject("txt_4c_DescLinha", "TextBox")
627:             WITH THIS.txt_4c_DescLinha
628:                 .Top       = 165
629:                 .Left      = 404
630:                 .Width     = 332
631:                 .Height    = 23
632:                 .FontName  = "Tahoma"
633:                 .FontSize  = 8
634:                 .MaxLength = 40
635:                 .Value     = NVL(THIS.this_oBusinessObject.this_cDescLinhaFiltro, "")
636:                 .Visible   = .T.
637:             ENDWITH
638: 
639:             BINDEVENT(THIS.txt_4c_Linha,     "LostFocus", THIS, "ValidarLinhaFiltroLostFocus")
640:             BINDEVENT(THIS.txt_4c_DescLinha, "LostFocus", THIS, "ValidarDescLinhaFiltroLostFocus")
641: 
642:             *-- optImagem (OptionGroup) - Situacao da Imagem: 1=Sem Imagem,
643:             *-- 2=Com Imagem, 3=Geral. ControlSource numerico = indice do
644:             *-- botao (regra #188 - NUNCA 0/1 booleano)
645:             THIS.AddObject("opt_4c_TipoImagem", "OptionGroup")
646:             WITH THIS.opt_4c_TipoImagem
647:                 .Top         = 88
648:                 .Left        = 478
649:                 .Width       = 260
650:                 .Height      = 26
651:                 .ButtonCount = 3
652:                 .BackStyle   = 0
653:                 .BorderStyle = 0
654:                 .Value       = NVL(THIS.this_oBusinessObject.this_nTipoImagem, 1)
655:                 .Visible     = .T.
656: 
657:                 WITH .Buttons(1)
658:                     .Top       = 5
659:                     .Left      = 3
660:                     .Width     = 100
661:                     .Height    = 16
662:                     .Style     = 0
663:                     .BackStyle = 0
664:                     .FontName  = "Tahoma"
665:                     .FontSize  = 8
666:                     .ForeColor = RGB(90, 90, 90)
667:                     .Caption   = "Sem Imagem"
668:                 ENDWITH
669: 
670:                 WITH .Buttons(2)
671:                     .Top       = 5
672:                     .Left      = 102
673:                     .Width     = 99
674:                     .Height    = 16
675:                     .Style     = 0
676:                     .BackStyle = 0
677:                     .FontName  = "Tahoma"
678:                     .FontSize  = 8
679:                     .ForeColor = RGB(90, 90, 90)
680:                     .Caption   = "Com Imagem"
681:                 ENDWITH
682: 
683:                 WITH .Buttons(3)
684:                     .Top       = 5
685:                     .Left      = 202

*-- Linhas 696 a 1060:
696:         CATCH TO loc_oErro
697:             MsgErro(loc_oErro.Message + CHR(13) + ;
698:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
699:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltrosLinhaImagem")
700:         ENDTRY
701:     ENDPROC
702: 
703:     *==========================================================================
704:     * FormParaBO - Transfere TODOS os campos da tela para as properties do
705:     * SigOpImgBO, equivalente ao que o legado faz implicitamente via
706:     * ControlSource direto em cada fwget/optImagem (e, no caso do produto
707:     * corrente, via "pPro = csProdutos.CPros" no inicio de cada handler).
708:     *
709:     * Dois blocos, porque esta tela tem duas "fichas" distintas:
710:     *   1) FILTRO - Periodo (getDtIni/getDtFin), Grupo (getGrupo/getDGrupo),
711:     *      Produto (getCProsF/getDProsF), Linha (getLin/getDLin) e Situacao
712:     *      de Imagem (optImagem). Alimenta SigOpImgBO.Processar().
713:     *   2) PRODUTO CORRENTE - linha selecionada na grade (cursor_4c_Produtos,
714:     *      csProdutos do legado). Alimenta SigOpImgBO.Atualizar(), que grava
715:     *      FigJpgs em SigCdPro.
716:     *
717:     * O bloco 2 so transfere quando ha linha corrente; sem isso, o produto
718:     * guardado por uma captura anterior seria apagado e o Atualizar seguinte
719:     * cairia no guard de ValidarDados.
720:     *
721:     * Devolve .T./.F. para que o chamador possa ABORTAR a acao (regra do
722:     * FormParaBO que falha no meio - nunca seguir gravando ficha parcial).
723:     *
724:     * PUBLIC (sem PROTECTED): o harness de teste e os handlers de imagem
725:     * chamam o metodo de fora da classe.
726:     *==========================================================================
727:     PROCEDURE FormParaBO()
728:         LOCAL loc_lSucesso, loc_oErro
729: 
730:         loc_lSucesso = .F.
731: 
732:         TRY
733:             WITH THIS.this_oBusinessObject
734:                 *-- 1) Filtros da selecao
735:                 .this_dDataIni           = THIS.txt_4c_DataIni.Value
736:                 .this_dDataFin           = THIS.txt_4c_DataFim.Value
737:                 .this_cGrupoFiltro       = ALLTRIM(THIS.txt_4c_Grupo.Value)
738:                 .this_cDescGrupoFiltro   = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
739:                 .this_cProdutoFiltro     = ALLTRIM(THIS.txt_4c_Produto.Value)
740:                 .this_cDescProdutoFiltro = ALLTRIM(THIS.txt_4c_DescProduto.Value)
741:                 .this_cLinhaFiltro       = ALLTRIM(THIS.txt_4c_Linha.Value)
742:                 .this_cDescLinhaFiltro   = ALLTRIM(THIS.txt_4c_DescLinha.Value)
743:                 .this_nTipoImagem        = THIS.opt_4c_TipoImagem.Value
744:             ENDWITH
745: 
746:             *-- 2) Produto corrente (linha da grade) - CarregarDoCursor ja le
747:             *-- as 10 colunas do cursor nas properties equivalentes
748:             IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos") ;
749:                     AND RECCOUNT("cursor_4c_Produtos") > 0
750:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")
751:             ENDIF
752: 
753:             loc_lSucesso = .T.
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message + CHR(13) + ;
756:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
757:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
758:         ENDTRY
759: 
760:         RETURN loc_lSucesso
761:     ENDPROC
762: 
763:     *==========================================================================
764:     * BOParaForm - Caminho inverso de FormParaBO: devolve as properties do
765:     * SigOpImgBO para os controles da tela.
766:     *
767:     * Usado quando o estado do filtro eh definido FORA da tela: os defaults
768:     * do Init legado (getDtIni.Value = Date()-1, getDtFin.Value = Date(),
769:     * optImagem.Value = 1) sao gravados no BO pelo InicializarForm e so
770:     * chegam aos TextBox por aqui; e o "Limpar Sel." (BtnCancelarClick)
771:     * reexibe os filtros que geraram a ultima selecao.
772:     *
773:     * A imagem do produto corrente eh exibida por CarregarImagemProduto (que
774:     * decodifica FigJpgs e pinta img_4c_Imagem), chamado no fim deste metodo
775:     * para que tela e BO fiquem coerentes num unico passo.
776:     *
777:     * PUBLIC pelo mesmo motivo de FormParaBO.
778:     *==========================================================================
779:     PROCEDURE BOParaForm()
780:         LOCAL loc_lSucesso, loc_oErro, loc_nTipoImagem
781: 
782:         loc_lSucesso = .F.
783: 
784:         TRY
785:             WITH THIS.this_oBusinessObject
786:                 THIS.txt_4c_DataIni.Value      = ConverterParaData(.this_dDataIni)
787:                 THIS.txt_4c_DataFim.Value      = ConverterParaData(.this_dDataFin)
788:                 THIS.txt_4c_Grupo.Value        = ALLTRIM(NVL(.this_cGrupoFiltro, ""))
789:                 THIS.txt_4c_DescGrupo.Value    = ALLTRIM(NVL(.this_cDescGrupoFiltro, ""))
790:                 THIS.txt_4c_Produto.Value      = ALLTRIM(NVL(.this_cProdutoFiltro, ""))
791:                 THIS.txt_4c_DescProduto.Value  = ALLTRIM(NVL(.this_cDescProdutoFiltro, ""))
792:                 THIS.txt_4c_Linha.Value        = ALLTRIM(NVL(.this_cLinhaFiltro, ""))
793:                 THIS.txt_4c_DescLinha.Value    = ALLTRIM(NVL(.this_cDescLinhaFiltro, ""))
794: 
795:                 loc_nTipoImagem = NVL(.this_nTipoImagem, 1)
796:             ENDWITH
797: 
798:             *-- optImagem eh OptionGroup de 3 botoes com ControlSource
799:             *-- NUMERICO = indice 1-based (regra #188): 0 nunca eh valido
800:             THIS.opt_4c_TipoImagem.Value = IIF(BETWEEN(loc_nTipoImagem, 1, 3), loc_nTipoImagem, 1)
801: 
802:             *-- Imagem do produto corrente (equivalente ao CarregaImagem legado)
803:             THIS.CarregarImagemProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodProduto, "")))
804: 
805:             loc_lSucesso = .T.
806:         CATCH TO loc_oErro
807:             MsgErro(loc_oErro.Message + CHR(13) + ;
808:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
809:                     "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
810:         ENDTRY
811: 
812:         RETURN loc_lSucesso
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * ValidarGrupoFiltroLostFocus / ValidarDescGrupoFiltroLostFocus -
817:     * Lookups do Grupo (equivalentes ao Valid legado de getGrupo/getDGrupo).
818:     * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
819:     *==========================================================================
820:     PROCEDURE ValidarGrupoFiltroLostFocus()
821:         THIS.AbrirLookupGrupoFiltro("cgrus")
822:     ENDPROC
823: 
824:     PROCEDURE ValidarDescGrupoFiltroLostFocus()
825:         THIS.AbrirLookupGrupoFiltro("dgrus")
826:     ENDPROC
827: 
828:     *==========================================================================
829:     * AbrirLookupGrupoFiltro - Funil unico dos dois Valid legados de
830:     * getGrupo/getDGrupo. Busca em SigCdGrp; o Init do FormBuscaAuxiliar ja
831:     * tenta o match exato (regra #37) - so mostra o picker quando precisa.
832:     *==========================================================================
833:     PROTECTED PROCEDURE AbrirLookupGrupoFiltro(par_cCampoBusca)
834:         LOCAL loc_oBusca, loc_cValor, loc_oErro
835: 
836:         IF THIS.this_lEmLookupGrupo
837:             RETURN
838:         ENDIF
839:         THIS.this_lEmLookupGrupo = .T.
840: 
841:         TRY
842:             loc_cValor = IIF(par_cCampoBusca = "cgrus", ;
843:                 ALLTRIM(THIS.txt_4c_Grupo.Value), ALLTRIM(THIS.txt_4c_DescGrupo.Value))
844: 
845:             IF !EMPTY(loc_cValor)
846:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
847:                     "SigCdGrp", "cursor_4c_BuscaGrupo", par_cCampoBusca, loc_cValor, ;
848:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo")
849: 
850:                 IF VARTYPE(loc_oBusca) = "O"
851:                     IF !loc_oBusca.this_lAchouRegistro
852:                         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
853:                         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
854:                         loc_oBusca.Show()
855:                     ENDIF
856: 
857:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
858:                         SELECT cursor_4c_BuscaGrupo
859:                         THIS.txt_4c_Grupo.Value     = ALLTRIM(cgrus)
860:                         THIS.txt_4c_DescGrupo.Value = ALLTRIM(dgrus)
861:                     ENDIF
862: 
863:                     loc_oBusca.Release()
864:                 ENDIF
865: 
866:                 IF USED("cursor_4c_BuscaGrupo")
867:                     USE IN cursor_4c_BuscaGrupo
868:                 ENDIF
869:             ELSE
870:                 THIS.txt_4c_Grupo.Value     = ""
871:                 THIS.txt_4c_DescGrupo.Value = ""
872:             ENDIF
873:         CATCH TO loc_oErro
874:             MsgErro(loc_oErro.Message + CHR(13) + ;
875:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
876:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupoFiltro")
877:         ENDTRY
878: 
879:         THIS.this_lEmLookupGrupo = .F.
880:     ENDPROC
881: 
882:     *==========================================================================
883:     * ValidarProdutoFiltroLostFocus / ValidarDescProdutoFiltroLostFocus -
884:     * Lookups do Produto (equivalentes ao Valid legado de getCProsF/getDProsF).
885:     *==========================================================================
886:     PROCEDURE ValidarProdutoFiltroLostFocus()
887:         THIS.AbrirLookupProdutoFiltro("cpros")
888:     ENDPROC
889: 
890:     PROCEDURE ValidarDescProdutoFiltroLostFocus()
891:         THIS.AbrirLookupProdutoFiltro("dpros")
892:     ENDPROC
893: 
894:     *==========================================================================
895:     * AbrirLookupProdutoFiltro - Funil unico dos dois Valid legados de
896:     * getCProsF/getDProsF. Busca em SigCdPro.
897:     *==========================================================================
898:     PROTECTED PROCEDURE AbrirLookupProdutoFiltro(par_cCampoBusca)
899:         LOCAL loc_oBusca, loc_cValor, loc_oErro
900: 
901:         IF THIS.this_lEmLookupProduto
902:             RETURN
903:         ENDIF
904:         THIS.this_lEmLookupProduto = .T.
905: 
906:         TRY
907:             loc_cValor = IIF(par_cCampoBusca = "cpros", ;
908:                 ALLTRIM(THIS.txt_4c_Produto.Value), ALLTRIM(THIS.txt_4c_DescProduto.Value))
909: 
910:             IF !EMPTY(loc_cValor)
911:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
912:                     "SigCdPro", "cursor_4c_BuscaProdutoFiltro", par_cCampoBusca, loc_cValor, ;
913:                     "Sele" + CHR(231) + CHR(227) + "o de Produto")
914: 
915:                 IF VARTYPE(loc_oBusca) = "O"
916:                     IF !loc_oBusca.this_lAchouRegistro
917:                         loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
918:                         loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
919:                         loc_oBusca.Show()
920:                     ENDIF
921: 
922:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoFiltro")
923:                         SELECT cursor_4c_BuscaProdutoFiltro
924:                         THIS.txt_4c_Produto.Value     = ALLTRIM(cpros)
925:                         THIS.txt_4c_DescProduto.Value = ALLTRIM(dpros)
926:                     ENDIF
927: 
928:                     loc_oBusca.Release()
929:                 ENDIF
930: 
931:                 IF USED("cursor_4c_BuscaProdutoFiltro")
932:                     USE IN cursor_4c_BuscaProdutoFiltro
933:                 ENDIF
934:             ELSE
935:                 THIS.txt_4c_Produto.Value     = ""
936:                 THIS.txt_4c_DescProduto.Value = ""
937:             ENDIF
938:         CATCH TO loc_oErro
939:             MsgErro(loc_oErro.Message + CHR(13) + ;
940:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
941:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupProdutoFiltro")
942:         ENDTRY
943: 
944:         THIS.this_lEmLookupProduto = .F.
945:     ENDPROC
946: 
947:     *==========================================================================
948:     * ValidarLinhaFiltroLostFocus / ValidarDescLinhaFiltroLostFocus -
949:     * Lookups da Linha (equivalentes ao Valid legado de getLin/getDLin).
950:     *==========================================================================
951:     PROCEDURE ValidarLinhaFiltroLostFocus()
952:         THIS.AbrirLookupLinhaFiltro("linhas")
953:     ENDPROC
954: 
955:     PROCEDURE ValidarDescLinhaFiltroLostFocus()
956:         THIS.AbrirLookupLinhaFiltro("descs")
957:     ENDPROC
958: 
959:     *==========================================================================
960:     * AbrirLookupLinhaFiltro - Funil unico dos dois Valid legados de
961:     * getLin/getDLin. Busca em SigCdLin.
962:     *==========================================================================
963:     PROTECTED PROCEDURE AbrirLookupLinhaFiltro(par_cCampoBusca)
964:         LOCAL loc_oBusca, loc_cValor, loc_oErro
965: 
966:         IF THIS.this_lEmLookupLinha
967:             RETURN
968:         ENDIF
969:         THIS.this_lEmLookupLinha = .T.
970: 
971:         TRY
972:             loc_cValor = IIF(par_cCampoBusca = "linhas", ;
973:                 ALLTRIM(THIS.txt_4c_Linha.Value), ALLTRIM(THIS.txt_4c_DescLinha.Value))
974: 
975:             IF !EMPTY(loc_cValor)
976:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
977:                     "SigCdLin", "cursor_4c_BuscaLinha", par_cCampoBusca, loc_cValor, ;
978:                     "Sele" + CHR(231) + CHR(227) + "o de Linha")
979: 
980:                 IF VARTYPE(loc_oBusca) = "O"
981:                     IF !loc_oBusca.this_lAchouRegistro
982:                         loc_oBusca.mAddColuna("linhas", "", "C" + CHR(243) + "digo")
983:                         loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
984:                         loc_oBusca.Show()
985:                     ENDIF
986: 
987:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLinha")
988:                         SELECT cursor_4c_BuscaLinha
989:                         THIS.txt_4c_Linha.Value     = ALLTRIM(linhas)
990:                         THIS.txt_4c_DescLinha.Value = ALLTRIM(descs)
991:                     ENDIF
992: 
993:                     loc_oBusca.Release()
994:                 ENDIF
995: 
996:                 IF USED("cursor_4c_BuscaLinha")
997:                     USE IN cursor_4c_BuscaLinha
998:                 ENDIF
999:             ELSE
1000:                 THIS.txt_4c_Linha.Value     = ""
1001:                 THIS.txt_4c_DescLinha.Value = ""
1002:             ENDIF
1003:         CATCH TO loc_oErro
1004:             MsgErro(loc_oErro.Message + CHR(13) + ;
1005:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1006:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupLinhaFiltro")
1007:         ENDTRY
1008: 
1009:         THIS.this_lEmLookupLinha = .F.
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     * ConfigurarGrid - Cria grd_4c_Produtos (grdProdutos legado), ligado ao
1014:     * cursor_4c_Produtos. Colunas/larguras/legendas identicas ao Init legado
1015:     * (RecordSource/ControlSource antes de Width/Header1.Caption - regra #41).
1016:     *==========================================================================
1017:     PROTECTED PROCEDURE ConfigurarGrid()
1018:         LOCAL loc_oErro
1019:         TRY
1020:             THIS.AddObject("grd_4c_Produtos", "Grid")
1021:             WITH THIS.grd_4c_Produtos
1022:                 .Top               = 192
1023:                 .Left              = 13
1024:                 .Width             = 974
1025:                 .Height            = 243
1026:                 .FontName          = "Tahoma"
1027:                 .FontSize          = 8
1028:                 .ColumnCount       = 6
1029:                 .ScrollBars        = 2
1030:                 .DeleteMark        = .F.
1031:                 .RecordMark        = .F.
1032:                 .ReadOnly          = .F.
1033:                 .AllowHeaderSizing = .F.
1034:                 .AllowRowSizing    = .F.
1035:                 .HeaderHeight      = 16
1036:                 .RowHeight         = 16
1037:                 .GridLineColor     = RGB(238, 238, 238)
1038:                 .RecordSource      = "cursor_4c_Produtos"
1039: 
1040:                 .Column1.ControlSource = "cursor_4c_Produtos.cpros"
1041:                 .Column2.ControlSource = "cursor_4c_Produtos.dpros"
1042:                 .Column3.ControlSource = "cursor_4c_Produtos.ifors"
1043:                 .Column4.ControlSource = "cursor_4c_Produtos.reffs"
1044:                 .Column5.ControlSource = "cursor_4c_Produtos.cgrus"
1045:                 .Column6.ControlSource = "cursor_4c_Produtos.linhas"
1046: 
1047:                 .Column1.Width = 129
1048:                 .Column2.Width = 366
1049:                 .Column3.Width = 112
1050:                 .Column4.Width = 191
1051:                 .Column5.Width = 50
1052:                 .Column6.Width = 100
1053: 
1054:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1055:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1056:                 .Column3.Header1.Caption = "Fornecedor"
1057:                 .Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
1058:                 .Column5.Header1.Caption = "Grupo"
1059:                 .Column6.Header1.Caption = "Linha"
1060: 

*-- Linhas 1147 a 1268:
1147:                 .Column6.Movable   = .F.
1148:                 .Column6.Resizable = .F.
1149:                 .Column6.ReadOnly  = .T.
1150: 
1151:                 .SetAll("DynamicForeColor", ;
1152:                     "IIF(EMPTY(cursor_4c_Produtos.figjpgs) OR ISNULL(cursor_4c_Produtos.figjpgs), RGB(255,0,0), RGB(0,0,0))", ;
1153:                     "Column")
1154: 
1155:                 .Visible = .T.
1156:             ENDWITH
1157: 
1158:             THIS.this_nCorPadrao = THIS.grd_4c_Produtos.Column1.Header1.BackColor
1159: 
1160:             BINDEVENT(THIS.grd_4c_Produtos.Column1.Header1, "Click", THIS, "HeaderCodigoClick")
1161:             BINDEVENT(THIS.grd_4c_Produtos.Column2.Header1, "Click", THIS, "HeaderDescricaoClick")
1162:             BINDEVENT(THIS.grd_4c_Produtos.Column3.Header1, "Click", THIS, "HeaderFornecedorClick")
1163:             BINDEVENT(THIS.grd_4c_Produtos.Column4.Header1, "Click", THIS, "HeaderReferenciaClick")
1164:             BINDEVENT(THIS.grd_4c_Produtos.Column5.Header1, "Click", THIS, "HeaderGrupoClick")
1165:             BINDEVENT(THIS.grd_4c_Produtos.Column6.Header1, "Click", THIS, "HeaderLinhaClick")
1166:             BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1167: 
1168:             *-- Ordem e realce iniciais: equivalente ao "Set Order To CPros In
1169:             *-- csProdutos" + Column1.Header1 verde que o AcertaForm legado
1170:             *-- aplica no fim do Init. O SetFocus fica a cargo do
1171:             *-- OrdenarPorColuna, que o pula enquanto o form nao esta visivel
1172:             *-- (aqui os AddObject acabaram de rodar e THIS.Visible ainda eh .F.).
1173:             THIS.OrdenarPorColuna("cpros", 1)
1174:         CATCH TO loc_oErro
1175:             MsgErro(loc_oErro.Message + CHR(13) + ;
1176:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1177:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
1178:         ENDTRY
1179:     ENDPROC
1180: 
1181:     *==========================================================================
1182:     * ConfigurarImagem - Cria a moldura (Shape3 legado) e o controle de
1183:     * imagem (ImgFigJpg legado) que exibe a foto do produto corrente,
1184:     * atualizada pelo GradeAfterRowColChange.
1185:     *==========================================================================
1186:     PROTECTED PROCEDURE ConfigurarImagem()
1187:         LOCAL loc_oErro
1188:         TRY
1189:             THIS.AddObject("shp_4c_Imagem", "Shape")
1190:             WITH THIS.shp_4c_Imagem
1191:                 .Top           = 477
1192:                 .Left          = 23
1193:                 .Width         = 201
1194:                 .Height        = 118
1195:                 .BackStyle     = 0
1196:                 .FillStyle     = 1
1197:                 .SpecialEffect = 1
1198:                 .BorderColor   = RGB(90, 90, 90)
1199:                 .Visible       = .T.
1200:             ENDWITH
1201: 
1202:             THIS.AddObject("img_4c_Imagem", "Image")
1203:             WITH THIS.img_4c_Imagem
1204:                 .Top     = 478
1205:                 .Left    = 24
1206:                 .Width   = 199
1207:                 .Height  = 116
1208:                 .Stretch = 1
1209:                 .Enabled = .F.
1210:                 .Picture = ""
1211:                 *-- O ImgFigJpg legado nao declara Visible (default .T.) e sem
1212:                 *-- Picture nao desenha nada; quem alterna eh o CarregaImagem.
1213:                 .Visible = .T.
1214:             ENDWITH
1215:         CATCH TO loc_oErro
1216:             MsgErro(loc_oErro.Message + CHR(13) + ;
1217:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1218:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImagem")
1219:         ENDTRY
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * ConfigurarBusca - Mini barra "Procurar" (Say3/getCPros/getDPros/
1224:     * getIFors/getReffs) abaixo da grade: digitar e Tab/sair do campo
1225:     * localiza o produto mais proximo na grade e limpa a caixa - equivalente
1226:     * ao LostFocus dos 4 fwget legados.
1227:     *==========================================================================
1228:     PROTECTED PROCEDURE ConfigurarBusca()
1229:         LOCAL loc_oErro
1230:         TRY
1231:             THIS.AddObject("lbl_4c_Procurar", "Label")
1232:             WITH THIS.lbl_4c_Procurar
1233:                 .Top       = 433
1234:                 .Left      = 24
1235:                 .Width     = 60
1236:                 .Height    = 15
1237:                 .Alignment = 0
1238:                 .BackStyle = 0
1239:                 .AutoSize  = .F.
1240:                 .FontName  = "Tahoma"
1241:                 .FontSize  = 8
1242:                 .FontBold  = .T.
1243:                 .ForeColor = RGB(90, 90, 90)
1244:                 .Caption   = "Procurar"
1245:                 .Visible   = .T.
1246:             ENDWITH
1247: 
1248:             *-- cpros char(14) - busca por Codigo
1249:             THIS.AddObject("txt_4c_BuscaCodigo", "TextBox")
1250:             WITH THIS.txt_4c_BuscaCodigo
1251:                 .Top       = 450
1252:                 .Left      = 23
1253:                 .Width     = 108
1254:                 .Height    = 23
1255:                 .FontName  = "Tahoma"
1256:                 .FontSize  = 8
1257:                 .MaxLength = 14
1258:                 .Value     = ""
1259:                 .Visible   = .T.
1260:             ENDWITH
1261: 
1262:             *-- dpros char(65) - busca por Descricao
1263:             THIS.AddObject("txt_4c_BuscaDescricao", "TextBox")
1264:             WITH THIS.txt_4c_BuscaDescricao
1265:                 .Top       = 450
1266:                 .Left      = 134
1267:                 .Width     = 348
1268:                 .Height    = 23

*-- Linhas 1301 a 1827:
1301:                 .Visible   = .T.
1302:             ENDWITH
1303: 
1304:             BINDEVENT(THIS.txt_4c_BuscaCodigo,      "LostFocus", THIS, "BuscaCodigoLostFocus")
1305:             BINDEVENT(THIS.txt_4c_BuscaDescricao,   "LostFocus", THIS, "BuscaDescricaoLostFocus")
1306:             BINDEVENT(THIS.txt_4c_BuscaFornecedor,  "LostFocus", THIS, "BuscaFornecedorLostFocus")
1307:             BINDEVENT(THIS.txt_4c_BuscaReferencia,  "LostFocus", THIS, "BuscaReferenciaLostFocus")
1308:         CATCH TO loc_oErro
1309:             MsgErro(loc_oErro.Message + CHR(13) + ;
1310:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1311:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBusca")
1312:         ENDTRY
1313:     ENDPROC
1314: 
1315:     *==========================================================================
1316:     * BuscaCodigoLostFocus / BuscaDescricaoLostFocus / BuscaFornecedorLostFocus
1317:     * / BuscaReferenciaLostFocus - equivalentes aos 4 LostFocus legados de
1318:     * getCPros/getDPros/getIFors/getReffs: localiza o produto mais proximo
1319:     * do valor digitado e limpa a caixa.
1320:     *==========================================================================
1321:     PROCEDURE BuscaCodigoLostFocus()
1322:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaCodigo, "cpros", 1)
1323:     ENDPROC
1324: 
1325:     PROCEDURE BuscaDescricaoLostFocus()
1326:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaDescricao, "dpros", 2)
1327:     ENDPROC
1328: 
1329:     PROCEDURE BuscaFornecedorLostFocus()
1330:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaFornecedor, "ifors", 3)
1331:     ENDPROC
1332: 
1333:     PROCEDURE BuscaReferenciaLostFocus()
1334:         THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaReferencia, "reffs", 4)
1335:     ENDPROC
1336: 
1337:     *==========================================================================
1338:     * LocalizarProdutoPorBusca - Funil unico dos 4 LostFocus legados
1339:     * (getCPros/getDPros/getIFors/getReffs): "Set Order To <campo>" +
1340:     * "Set Near On" + "Locate For <campo> = Alltrim(valor)" + "Set Near Off",
1341:     * equivalente byte a byte ao legado.
1342:     *
1343:     * O legado conta com SET EXACT OFF (prefixo) para a busca por aproximacao
1344:     * funcionar com valor PARCIAL; o config.prg deste projeto liga SET EXACT
1345:     * ON globalmente (regra das chaves compostas), entao o EXACT eh alternado
1346:     * localmente so em volta do LOCATE e restaurado imediatamente depois.
1347:     *==========================================================================
1348:     PROTECTED PROCEDURE LocalizarProdutoPorBusca(par_oTxt, par_cCampo, par_nColuna)
1349:         LOCAL loc_cValor, loc_cExactAnt
1350: 
1351:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1352: 
1353:         IF EMPTY(loc_cValor) OR !USED("cursor_4c_Produtos")
1354:             RETURN
1355:         ENDIF
1356: 
1357:         loc_cExactAnt = SET("EXACT")
1358:         SET EXACT OFF
1359: 
1360:         SELECT cursor_4c_Produtos
1361:         SET ORDER TO TAG (par_cCampo) IN cursor_4c_Produtos
1362:         SET NEAR ON
1363:         DO CASE
1364:             CASE par_cCampo = "cpros"
1365:                 LOCATE FOR cpros = loc_cValor
1366:             CASE par_cCampo = "dpros"
1367:                 LOCATE FOR dpros = loc_cValor
1368:             CASE par_cCampo = "ifors"
1369:                 LOCATE FOR ifors = loc_cValor
1370:             CASE par_cCampo = "reffs"
1371:                 LOCATE FOR reffs = loc_cValor
1372:         ENDCASE
1373:         SET NEAR OFF
1374: 
1375:         IF loc_cExactAnt = "ON"
1376:             SET EXACT ON
1377:         ENDIF
1378: 
1379:         par_oTxt.Value = ""
1380: 
1381:         THIS.RealcarColunaOrdenada(par_nColuna)
1382:         IF THIS.Visible
1383:             THIS.grd_4c_Produtos.Columns(par_nColuna).SetFocus()
1384:         ENDIF
1385:         THIS.grd_4c_Produtos.Refresh()
1386: 
1387:         IF !EOF("cursor_4c_Produtos")
1388:             THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
1389:         ENDIF
1390:     ENDPROC
1391: 
1392:     *==========================================================================
1393:     * HeaderCodigoClick / HeaderDescricaoClick / HeaderFornecedorClick /
1394:     * HeaderReferenciaClick / HeaderGrupoClick / HeaderLinhaClick - Reordena
1395:     * cursor_4c_Produtos pelo TAG correspondente e realca o header da
1396:     * coluna ativa, equivalente aos 6 Header1.Click do grdProdutos legado.
1397:     *==========================================================================
1398:     PROCEDURE HeaderCodigoClick()
1399:         THIS.OrdenarPorColuna("cpros", 1)
1400:     ENDPROC
1401: 
1402:     PROCEDURE HeaderDescricaoClick()
1403:         THIS.OrdenarPorColuna("dpros", 2)
1404:     ENDPROC
1405: 
1406:     PROCEDURE HeaderFornecedorClick()
1407:         THIS.OrdenarPorColuna("ifors", 3)
1408:     ENDPROC
1409: 
1410:     PROCEDURE HeaderReferenciaClick()
1411:         THIS.OrdenarPorColuna("reffs", 4)
1412:     ENDPROC
1413: 
1414:     PROCEDURE HeaderGrupoClick()
1415:         THIS.OrdenarPorColuna("cgrus", 5)
1416:     ENDPROC
1417: 
1418:     PROCEDURE HeaderLinhaClick()
1419:         THIS.OrdenarPorColuna("linhas", 6)
1420:     ENDPROC
1421: 
1422:     *==========================================================================
1423:     * OrdenarPorColuna - Funil unico dos 6 Header1.Click legados, na MESMA
1424:     * ordem do legado: guarda o Recno, troca o TAG, repinta os headers, foca
1425:     * a coluna, Refresh, volta o Recno e Refresh de novo.
1426:     *
1427:     * O SetFocus eh condicionado a THIS.Visible porque este mesmo funil eh
1428:     * chamado pelo ConfigurarGrid (equivalente ao AcertaForm do Init legado),
1429:     * quando os controles acabaram de nascer via AddObject e o form ainda
1430:     * esta invisivel - SetFocus em controle de form invisivel estoura.
1431:     *==========================================================================
1432:     PROTECTED PROCEDURE OrdenarPorColuna(par_cTag, par_nColuna)
1433:         LOCAL loc_nRecAtual
1434: 
1435:         IF !USED("cursor_4c_Produtos")
1436:             RETURN
1437:         ENDIF
1438: 
1439:         *-- "lnRec = Recno('csProdutos')" + "Set Order To <tag> In csProdutos"
1440:         *--
1441:         *-- O ponteiro NAO pode ser reposicionado por SEEK: cinco dos seis TAGs
1442:         *-- sao COMPOSTOS (dpros+cpros, ifors+cpros, reffs+cpros, cgrus+cpros,
1443:         *-- linhas+cpros) e o config.prg liga SET EXACT ON, entao SEEK de chave
1444:         *-- parcial devolveria .F. SEMPRE e deixaria a grade em EOF - sem erro
1445:         *-- e sem log. RECNO eh independente da ordem, e eh o que o legado usa.
1446:         loc_nRecAtual = RECNO("cursor_4c_Produtos")
1447: 
1448:         SET ORDER TO TAG (par_cTag) IN cursor_4c_Produtos
1449: 
1450:         THIS.RealcarColunaOrdenada(par_nColuna)
1451: 
1452:         *-- SetFocus condicionado a THIS.Visible: este funil tambem eh chamado
1453:         *-- pelo ConfigurarGrid (equivalente ao AcertaForm do Init legado),
1454:         *-- quando os controles acabaram de nascer via AddObject e o form ainda
1455:         *-- esta invisivel - SetFocus em controle de form invisivel estoura.
1456:         IF THIS.Visible
1457:             THIS.grd_4c_Produtos.Columns(par_nColuna).SetFocus()
1458:         ENDIF
1459: 
1460:         THIS.grd_4c_Produtos.Refresh()
1461: 
1462:         *-- "Go lnRec In csProdutos" + Refresh: o GO vem DEPOIS do primeiro
1463:         *-- Refresh porque o Grid re-sincroniza o ponteiro do cursor com a
1464:         *-- linha corrente dele ao repintar - invertendo a ordem, o registro
1465:         *-- que estava selecionado antes da troca de ordem seria perdido.
1466:         IF RECCOUNT("cursor_4c_Produtos") > 0 AND ;
1467:                 BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_Produtos"))
1468:             GO loc_nRecAtual IN cursor_4c_Produtos
1469:         ENDIF
1470: 
1471:         THIS.grd_4c_Produtos.Refresh()
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     * RealcarColunaOrdenada - Pinta o Header1 da coluna ativa com o verde do
1476:     * legado (RGB(220,255,220)) e devolve os demais ao CorPadrao original.
1477:     *
1478:     * Repoe as SEIS colunas. O AcertaForm legado repoe so Column1..Column4
1479:     * (ficou para tras quando as colunas 5 e 6 foram acrescentadas), o que
1480:     * deixa DOIS headers verdes quando o usuario ordena por Grupo/Linha e
1481:     * em seguida reprocessa; os seis Header1.Click legados ja repoem todas.
1482:     *==========================================================================
1483:     PROTECTED PROCEDURE RealcarColunaOrdenada(par_nColuna)
1484:         LOCAL loc_nI
1485: 
1486:         FOR loc_nI = 1 TO 6
1487:             IF loc_nI = par_nColuna
1488:                 THIS.grd_4c_Produtos.Columns(loc_nI).Header1.BackColor = RGB(220, 255, 220)
1489:             ELSE
1490:                 THIS.grd_4c_Produtos.Columns(loc_nI).Header1.BackColor = THIS.this_nCorPadrao
1491:             ENDIF
1492:         ENDFOR
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * GradeAfterRowColChange - Recarrega a imagem do produto da linha
1497:     * corrente. Equivalente a "ThisForm.CarregaImagem(csProdutos.CPros)" do
1498:     * AfterRowColChange legado - sem filtro de coluna (regra #46: carregar
1499:     * detalhe da linha corrente eh uso correto de AfterRowColChange).
1500:     *==========================================================================
1501:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1502:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
1503:             THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
1504:         ENDIF
1505:     ENDPROC
1506: 
1507:     *==========================================================================
1508:     * CarregarImagemProduto - Decodifica FigJpgs (base64) do produto cujo
1509:     * cpros == par_cCodProduto, grava num arquivo temporario, exibe em
1510:     * img_4c_Imagem e apaga o temporario - equivalente ao PROCEDURE
1511:     * CarregaImagem legado.
1512:     *==========================================================================
1513:     PROTECTED PROCEDURE CarregarImagemProduto(par_cCodProduto)
1514:         LOCAL loc_cArquivo, loc_cFoto, loc_lTemImagem
1515: 
1516:         loc_cArquivo  = SYS(2023) + "\SigCpImg.jpg"
1517:         loc_lTemImagem = .F.
1518: 
1519:         THIS.img_4c_Imagem.Visible = .F.
1520:         THIS.img_4c_Imagem.Picture = ""
1521: 
1522:         IF !EMPTY(ALLTRIM(NVL(par_cCodProduto, ""))) AND USED("cursor_4c_Produtos") ;
1523:                 AND !EOF("cursor_4c_Produtos") AND cursor_4c_Produtos.cpros == par_cCodProduto
1524:             IF !EMPTY(cursor_4c_Produtos.figjpgs) AND !ISNULL(cursor_4c_Produtos.figjpgs)
1525:                 loc_lTemImagem = .T.
1526:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Produtos.figjpgs, ;
1527:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1528:                     "data:image/jpg;base64,", ""), 14)
1529:                 IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
1530:                     THIS.img_4c_Imagem.Picture = loc_cArquivo
1531:                     THIS.img_4c_Imagem.Visible = .T.
1532:                 ENDIF
1533:             ENDIF
1534:         ENDIF
1535: 
1536:         IF FILE(loc_cArquivo)
1537:             DELETE FILE (loc_cArquivo)
1538:         ENDIF
1539: 
1540:         *-- btnZoom.When legado (Not Empty(FigJpgs)) - guardado para combinar
1541:         *-- com o modo corrente (filtro/resultado) em AtualizarEstadoBotaoZoom
1542:         THIS.this_lProdutoTemImagem = loc_lTemImagem
1543:         THIS.AtualizarEstadoBotaoZoom()
1544:     ENDPROC
1545: 
1546:     *==========================================================================
1547:     * AtualizarEstadoBotaoZoom - obj_4c_CmdgFigura.Buttons(3) (Zoom) so fica
1548:     * habilitado em modo RESULTADO (apos Processar) E com o produto corrente
1549:     * tendo imagem - combina o toggle do AcertaForm legado (Not llEna) com o
1550:     * btnZoom.When (Not Empty(FigJpgs)).
1551:     *==========================================================================
1552:     PROTECTED PROCEDURE AtualizarEstadoBotaoZoom()
1553:         IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "obj_4c_CmdgFigura", 5)
1554:             THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(3).Enabled = ;
1555:                 !THIS.this_lModoFiltroAtual AND THIS.this_lProdutoTemImagem
1556:         ENDIF
1557:     ENDPROC
1558: 
1559:     *==========================================================================
1560:     * BtnProcessarClick - Valida o periodo (equivalente ao cmdSelecionar.
1561:     * Click legado) e delega a busca para CarregarLista().
1562:     *
1563:     * FormParaBO() vem ANTES das validacoes e o seu retorno aborta a acao:
1564:     * sem os filtros transferidos, o Processar consultaria com o estado
1565:     * anterior do BO e traria o resultado errado em silencio.
1566:     *==========================================================================
1567:     PROCEDURE BtnProcessarClick()
1568:         LOCAL loc_dDataIni, loc_dDataFin
1569: 
1570:         IF !THIS.FormParaBO()
1571:             RETURN
1572:         ENDIF
1573: 
1574:         loc_dDataIni = THIS.this_oBusinessObject.this_dDataIni
1575:         loc_dDataFin = THIS.this_oBusinessObject.this_dDataFin
1576: 
1577:         IF EMPTY(loc_dDataIni)
1578:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1579:             RETURN
1580:         ENDIF
1581: 
1582:         IF EMPTY(loc_dDataFin)
1583:             MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1584:             RETURN
1585:         ENDIF
1586: 
1587:         IF loc_dDataFin < loc_dDataIni
1588:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1589:             RETURN
1590:         ENDIF
1591: 
1592:         THIS.CarregarDados()
1593:     ENDPROC
1594: 
1595:     *==========================================================================
1596:     * CarregarLista - Metodo de carga da grade (PROCEDURE Processamento do
1597:     * legado). Chama SigOpImgBO.Processar(), que faz o SQLEXEC num cursor
1598:     * TEMPORARIO, e repopula cursor_4c_Produtos via ZAP + APPEND FROM DBF -
1599:     * nunca SQLEXEC direto sobre o alias ligado ao Grid, que zeraria o
1600:     * ColumnCount e deixaria a grade como um retangulo branco.
1601:     *
1602:     * O legado fecha com AcertaForm(.f.) (ordem CPros + realce da Column1) +
1603:     * CarregaImagem + Refresh + foco na Column1 ou no btnLimpar quando nada
1604:     * foi selecionado; so a parte de Enabled dos filtros do AcertaForm nao
1605:     * cabe aqui, por depender dos controles de filtro.
1606:     *
1607:     * PUBLIC (sem PROTECTED): o TesteAutomatico.prg chama este metodo de FORA
1608:     * da classe, por macro (THIS.oForm.&loc_cMetodo.()), e o PEMSTATUS(...,5)
1609:     * que ele usa devolve .T. tambem para metodo PROTECTED - o harness entraria
1610:     * no ramo e a chamada real estouraria "Property CARREGARLISTA is not found".
1611:     *==========================================================================
1612:     PROCEDURE CarregarLista()
1613:         LOCAL loc_lSucesso, loc_oErro, loc_nRegistros
1614: 
1615:         TRY
1616:             loc_lSucesso = THIS.this_oBusinessObject.Processar("cursor_4c_ProdutosTemp")
1617: 
1618:             IF loc_lSucesso
1619:                 THIS.EsvaziarCursorProdutos()
1620: 
1621:                 IF USED("cursor_4c_ProdutosTemp")
1622:                     IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
1623:                         SELECT cursor_4c_Produtos
1624:                         APPEND FROM DBF("cursor_4c_ProdutosTemp")
1625:                     ENDIF
1626:                     USE IN cursor_4c_ProdutosTemp
1627:                 ENDIF
1628: 
1629:                 *-- GO TOP + Refresh: cursor populado nao repinta a grade sozinho
1630:                 SELECT cursor_4c_Produtos
1631:                 GO TOP
1632:                 loc_nRegistros = RECCOUNT("cursor_4c_Produtos")
1633: 
1634:                 THIS.AjustarControlesPorModo(.F.)
1635:                 THIS.OrdenarPorColuna("cpros", 1)
1636: 
1637:                 IF loc_nRegistros < 1
1638:                     MsgAviso("Nenhum Produto Foi Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1639:                     THIS.CarregarImagemProduto("")
1640:                     THIS.cnt_4c_Botoes.cmg_4c_Limpar.Buttons(1).SetFocus()
1641:                 ELSE
1642:                     THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
1643:                 ENDIF
1644:             ELSE
1645:                 *-- Mensagem do legado para falha de consulta (Processamento - 1)
1646:                 MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
1647:                         THIS.this_oBusinessObject.ObterMensagemErro(), ;
1648:                         "Falha na Conex" + CHR(227) + "o (Processamento - 1)")
1649:             ENDIF
1650:         CATCH TO loc_oErro
1651:             MsgErro(loc_oErro.Message + CHR(13) + ;
1652:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1653:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
1654:         ENDTRY
1655:     ENDPROC
1656: 
1657:     *==========================================================================
1658:     * CarregarDados - Nome usado pelos handlers desta tela desde a migracao
1659:     * da logica de selecao. Mantido como porta de entrada unica para
1660:     * CarregarLista (que eh o nome canonico do projeto para o metodo que
1661:     * popula a grade), para que exista UMA implementacao so.
1662:     *==========================================================================
1663:     PROCEDURE CarregarDados()
1664:         RETURN THIS.CarregarLista()
1665:     ENDPROC
1666: 
1667:     *==========================================================================
1668:     * CmgLimparClick - Despacha os 2 botoes de cmg_4c_Limpar (cmdBtnForm
1669:     * legado): Button1 "Limpar Sel." e Button2 "Encerrar" - equivalente ao
1670:     * "If This.Value = 1 / ... / Else ThisForm.Release" do Click legado.
1671:     *==========================================================================
1672:     PROCEDURE CmgLimparClick()
1673:         IF THIS.cnt_4c_Botoes.cmg_4c_Limpar.Value = 1
1674:             THIS.BtnCancelarClick()
1675:         ELSE
1676:             THIS.BtnEncerrarClick()
1677:         ENDIF
1678:     ENDPROC
1679: 
1680:     *==========================================================================
1681:     * BtnCancelarClick - "Limpar Sel." (cmdBtnForm.btnLimpar legado, ramo
1682:     * "If This.Value = 1"): CANCELA a selecao corrente e devolve a tela ao
1683:     * modo FILTRO, para o usuario montar outra consulta.
1684:     *
1685:     * Esta eh a unica acao cancelavel do SIGOPIMG - nao ha Page2 de Dados
1686:     * nem Salvar/Cancelar de ficha: a gravacao da imagem eh imediata (botao
1687:     * "Imagem"/"Branco"), e o que se cancela aqui eh o RESULTADO da selecao.
1688:     *
1689:     * Ordem identica ao legado: Zap In csProdutos -> CarregaImagem('') ->
1690:     * AcertaForm(.t.) (que reordena por CPros, realca a Column1, devolve o
1691:     * foco ao periodo e reabilita os filtros).
1692:     *
1693:     * PUBLIC: chamado pelo CmgLimparClick e pelo TesteAutomatico.prg.
1694:     *==========================================================================
1695:     PROCEDURE BtnCancelarClick()
1696:         THIS.LimparCampos()
1697:         THIS.OrdenarPorColuna("cpros", 1)
1698:         THIS.AjustarControlesPorModo(.T.)
1699: 
1700:         *-- Reexibe no form o filtro que gerou a selecao recem-descartada,
1701:         *-- mantendo tela e BO coerentes para a proxima consulta
1702:         THIS.BOParaForm()
1703:     ENDPROC
1704: 
1705:     *==========================================================================
1706:     * BtnEncerrarClick - "Encerrar" (cmdBtnForm.Buttons(2) legado, ramo
1707:     * "Else ThisForm.Release"). Os cursores sao fechados no Destroy.
1708:     *==========================================================================
1709:     PROCEDURE BtnEncerrarClick()
1710:         THIS.Release()
1711:     ENDPROC
1712: 
1713:     *==========================================================================
1714:     * LimparCampos - Descarta a selecao corrente: esvazia cursor_4c_Produtos
1715:     * (Zap In csProdutos legado), apaga a imagem exibida (CarregaImagem('')) e
1716:     * limpa as 4 caixas de "Procurar" (getCPros/getDPros/getIFors/getReffs),
1717:     * que so fazem sentido com a grade preenchida.
1718:     *
1719:     * Os campos de FILTRO NAO sao limpos aqui - o legado tambem nao os limpa
1720:     * no btnLimpar, e zera-los obrigaria o usuario a redigitar o periodo a
1721:     * cada nova consulta.
1722:     *==========================================================================
1723:     PROCEDURE LimparCampos()
1724:         THIS.EsvaziarCursorProdutos()
1725: 
1726:         THIS.txt_4c_BuscaCodigo.Value     = ""
1727:         THIS.txt_4c_BuscaDescricao.Value  = ""
1728:         THIS.txt_4c_BuscaFornecedor.Value = ""
1729:         THIS.txt_4c_BuscaReferencia.Value = ""
1730: 
1731:         THIS.this_oBusinessObject.this_cCodProduto   = ""
1732:         THIS.this_oBusinessObject.this_cImagemBase64 = ""
1733: 
1734:         THIS.CarregarImagemProduto("")
1735:         THIS.grd_4c_Produtos.Refresh()
1736:     ENDPROC
1737: 
1738:     *==========================================================================
1739:     * CmdgFiguraClick - Despacha os 3 botoes de obj_4c_CmdgFigura (cmdgFigura
1740:     * legado: Imagem/cmdFigura, Branco/cmdBranco, Zoom/btnZoom) para os
1741:     * metodos equivalentes. Sem produto selecionado na grade, nenhum dos 3
1742:     * tem o que fazer - mesma mensagem usada em CarregarLista para grade
1743:     * vazia.
1744:     *==========================================================================
1745:     PROCEDURE CmdgFiguraClick()
1746:         LOCAL loc_cProduto, loc_nBotao
1747: 
1748:         loc_nBotao = THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Value
1749: 
1750:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1751:             MsgAviso("Nenhum Produto Foi Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1752:             RETURN
1753:         ENDIF
1754: 
1755:         loc_cProduto = cursor_4c_Produtos.cpros
1756: 
1757:         DO CASE
1758:             CASE loc_nBotao = 1
1759:                 THIS.CapturarImagemProduto(loc_cProduto)
1760:             CASE loc_nBotao = 2
1761:                 THIS.AplicarImagemBrancoProduto(loc_cProduto)
1762:             CASE loc_nBotao = 3
1763:                 THIS.AbrirZoomImagemProduto(loc_cProduto)
1764:         ENDCASE
1765:     ENDPROC
1766: 
1767:     *==========================================================================
1768:     * CapturarImagemProduto - cmdFigura.Valid legado: abre o seletor de
1769:     * arquivo (GetPict), confirma a transferencia, grava a imagem em
1770:     * SigCdPro.FigJpgs (via SigOpImgBO.Atualizar) e limpa a previsualizacao
1771:     * em cache em SigPrPrt - so esta acao faz essa limpeza no legado
1772:     * (cmdBranco.Valid nao faz).
1773:     *
1774:     * FigJpgs guarda a imagem em BASE64 (nao em binario cru) - e o que
1775:     * CarregarImagemProduto/demais BOs do sistema decodificam com
1776:     * STRCONV(...,14) (ver docs - "double decode" STRCONV). O legado grava
1777:     * com FileToStr() puro (sem encode) porque historicamente a captura
1778:     * vinha de outro caminho; aqui o encode com STRCONV(...,13) eh
1779:     * obrigatorio para nao gravar binario cru onde o resto do sistema
1780:     * espera base64 (gravar cru corromperia a exibicao em TODOS os pontos
1781:     * que leem FigJpgs, nao so nesta tela).
1782:     *
1783:     * fTamanhoImagem (SIGFUNCS.PRG) nao esta no acervo (regra #13/#27) -
1784:     * mantido so o guard de arquivo existente/nao vazio; o limite real de
1785:     * tamanho/dimensao do legado nao e reproduzido.
1786:     *==========================================================================
1787:     PROTECTED PROCEDURE CapturarImagemProduto(par_cCodProduto)
1788:         LOCAL loc_cArquivo, loc_cImagem, loc_oErro
1789: 
1790:         loc_cArquivo = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar"))
1791: 
1792:         IF EMPTY(loc_cArquivo)
1793:             RETURN
1794:         ENDIF
1795: 
1796:         IF !FILE(loc_cArquivo)
1797:             MsgErro("Arquivo " + UPPER(loc_cArquivo) + " n" + CHR(227) + "o encontrado.", "Imagem")
1798:             RETURN
1799:         ENDIF
1800: 
1801:         IF !MsgConfirma("Confirma a Transfer" + CHR(234) + "ncia da Imagem ?")
1802:             THIS.grd_4c_Produtos.Column1.SetFocus()
1803:             RETURN
1804:         ENDIF
1805: 
1806:         *-- FormParaBO leva a linha corrente INTEIRA para o BO (nao so o
1807:         *-- codigo): Atualizar/RegistrarAuditoria/ObterChavePrimaria precisam
1808:         *-- do produto completo, nao de uma ficha pela metade. Fica FORA do
1809:         *-- TRY porque o seu RETURN de guarda nao pode morar dentro dele
1810:         *-- (regra #1) - e porque falhar aqui eh nao ter o que gravar.
1811:         IF !THIS.FormParaBO()
1812:             THIS.grd_4c_Produtos.Column1.SetFocus()
1813:             RETURN
1814:         ENDIF
1815: 
1816:         WAIT WINDOW "Aguarde!!! Transferindo a Imagem..." NOWAIT
1817: 
1818:         TRY
1819:             loc_cImagem = STRCONV(FILETOSTR(loc_cArquivo), 13)
1820: 
1821:             THIS.this_oBusinessObject.this_cCodProduto   = par_cCodProduto
1822:             THIS.this_oBusinessObject.this_cImagemBase64 = loc_cImagem
1823: 
1824:             THIS.this_oBusinessObject.LimparPreviewImpressao(par_cCodProduto)
1825: 
1826:             IF THIS.this_oBusinessObject.Atualizar()
1827:                 THIS.AtualizarLinhaGradeComImagem(par_cCodProduto, loc_cImagem)

*-- Linhas 1842 a 2147:
1842:             WAIT CLEAR
1843:             MsgErro(loc_oErro.Message + CHR(13) + ;
1844:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1845:                     "Procedure: " + loc_oErro.Procedure, "Erro em CapturarImagemProduto")
1846:         ENDTRY
1847: 
1848:         THIS.grd_4c_Produtos.Column1.SetFocus()
1849:     ENDPROC
1850: 
1851:     *==========================================================================
1852:     * AplicarImagemBrancoProduto - cmdBranco.Valid legado: aplica a imagem
1853:     * "em branco" padrao (BrJpg.JPG do legado, migrada para vbmp\brjpg.jpg -
1854:     * gc_4c_CaminhoIcones) no produto corrente. Mesma gravacao de
1855:     * CapturarImagemProduto, sem o delete de SigPrPrt (o legado nao faz
1856:     * essa limpeza para esta opcao).
1857:     *==========================================================================
1858:     PROTECTED PROCEDURE AplicarImagemBrancoProduto(par_cCodProduto)
1859:         LOCAL loc_cArquivo, loc_cImagem, loc_oErro
1860: 
1861:         loc_cArquivo = gc_4c_CaminhoIcones + "brjpg.jpg"
1862: 
1863:         IF !FILE(loc_cArquivo)
1864:             MsgErro("O Arquivo " + UPPER(loc_cArquivo) + " N" + CHR(227) + "o Foi Encontrado!!!", ;
1865:                      "Figura em Branco N" + CHR(227) + "o Encontrada...")
1866:             RETURN
1867:         ENDIF
1868: 
1869:         *-- Mesma transferencia de ficha de CapturarImagemProduto, FORA do
1870:         *-- TRY pelo mesmo motivo (RETURN de guarda - regra #1)
1871:         IF !THIS.FormParaBO()
1872:             THIS.grd_4c_Produtos.Column1.SetFocus()
1873:             RETURN
1874:         ENDIF
1875: 
1876:         WAIT WINDOW "Aguarde!!! Transferindo a Imagem..." NOWAIT
1877: 
1878:         TRY
1879:             loc_cImagem = STRCONV(FILETOSTR(loc_cArquivo), 13)
1880: 
1881:             THIS.this_oBusinessObject.this_cCodProduto   = par_cCodProduto
1882:             THIS.this_oBusinessObject.this_cImagemBase64 = loc_cImagem
1883: 
1884:             IF THIS.this_oBusinessObject.Atualizar()
1885:                 THIS.AtualizarLinhaGradeComImagem(par_cCodProduto, loc_cImagem)
1886:                 WAIT CLEAR
1887:                 THIS.CarregarImagemProduto(par_cCodProduto)
1888:             ELSE
1889:                 WAIT CLEAR
1890:             ENDIF
1891:         CATCH TO loc_oErro
1892:             WAIT CLEAR
1893:             MsgErro(loc_oErro.Message + CHR(13) + ;
1894:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1895:                     "Procedure: " + loc_oErro.Procedure, "Erro em AplicarImagemBrancoProduto")
1896:         ENDTRY
1897: 
1898:         THIS.grd_4c_Produtos.Column1.SetFocus()
1899:     ENDPROC
1900: 
1901:     *==========================================================================
1902:     * AtualizarLinhaGradeComImagem - Espelha no cursor_4c_Produtos (grade)
1903:     * a imagem/datas que acabaram de ser gravadas em SigCdPro, para o
1904:     * DynamicForeColor (vermelho = sem imagem) e o proximo CarregarImagemProduto
1905:     * refletirem a gravacao sem precisar reconsultar o banco.
1906:     *==========================================================================
1907:     PROTECTED PROCEDURE AtualizarLinhaGradeComImagem(par_cCodProduto, par_cImagemBase64)
1908:         IF USED("cursor_4c_Produtos")
1909:             SELECT cursor_4c_Produtos
1910:             IF SEEK(par_cCodProduto, "cursor_4c_Produtos", "cpros")
1911:                 REPLACE figjpgs WITH par_cImagemBase64, ;
1912:                         dtfilms WITH DATETIME(), ;
1913:                         datas   WITH DATETIME() ;
1914:                         IN cursor_4c_Produtos
1915:             ENDIF
1916:             THIS.grd_4c_Produtos.Refresh()
1917:         ENDIF
1918:     ENDPROC
1919: 
1920:     *==========================================================================
1921:     * AbrirZoomImagemProduto - btnZoom.Click legado: decodifica a imagem do
1922:     * produto corrente para um JPG temporario e abre o Zoom (Do Form
1923:     * SigOpZom legado). SigOpZom.SCX ainda esta em ProximasMigracoes - mesmo
1924:     * padrao de fallback (FILE + CREATEOBJECT guardado + MsgAviso) usado em
1925:     * FormSigMvSbn/FormSigOpCpo/FormSigOpDoc/FormSigPrGlx.
1926:     *==========================================================================
1927:     PROTECTED PROCEDURE AbrirZoomImagemProduto(par_cCodProduto)
1928:         LOCAL loc_cArquivo, loc_cFoto, loc_cLinha2, loc_cLinha3, loc_oForm, loc_oErro
1929: 
1930:         IF !USED("cursor_4c_Produtos") OR !SEEK(par_cCodProduto, "cursor_4c_Produtos", "cpros")
1931:             RETURN
1932:         ENDIF
1933: 
1934:         IF EMPTY(cursor_4c_Produtos.figjpgs) OR ISNULL(cursor_4c_Produtos.figjpgs)
1935:             RETURN
1936:         ENDIF
1937: 
1938:         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
1939:         loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Produtos.figjpgs, ;
1940:             "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1941:             "data:image/jpg;base64,", ""), 14)
1942:         STRTOFILE(loc_cFoto, loc_cArquivo)
1943: 
1944:         IF !FILE(loc_cArquivo)
1945:             RETURN
1946:         ENDIF
1947: 
1948:         loc_cLinha2 = "Produto : " + ALLTRIM(cursor_4c_Produtos.cpros) + " - " + ALLTRIM(cursor_4c_Produtos.dpros)
1949:         loc_cLinha3 = "Fornecedor : " + ALLTRIM(cursor_4c_Produtos.ifors) + " - Refer" + CHR(234) + "ncia : " + ALLTRIM(cursor_4c_Produtos.reffs)
1950: 
1951:         TRY
1952:             loc_oForm = CREATEOBJECT("FormSigOpZom", loc_cArquivo, loc_cLinha2, loc_cLinha3)
1953:         CATCH TO loc_oErro
1954:             loc_oForm = .NULL.
1955:         ENDTRY
1956: 
1957:         IF VARTYPE(loc_oForm) = "O"
1958:             loc_oForm.Show()
1959:         ELSE
1960:             MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
1961:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
1962:                 "Aviso")
1963:         ENDIF
1964: 
1965:         IF FILE(loc_cArquivo)
1966:             DELETE FILE (loc_cArquivo)
1967:         ENDIF
1968: 
1969:         THIS.grd_4c_Produtos.SetFocus()
1970:     ENDPROC
1971: 
1972:     *==========================================================================
1973:     * AjustarControlesPorModo - Equivalente ao bloco de Enabled do PROCEDURE
1974:     * AcertaForm legado (LParameters llEna): par_lModoFiltro = .T. habilita
1975:     * os campos de FILTRO (periodo/grupo/produto/linha/situacao de imagem +
1976:     * Processar) e desabilita busca/grade/"Limpar Sel." - o inverso quando
1977:     * .F. (modo RESULTADO, apos Processar).
1978:     *
1979:     * cmdgFigura.cmdFigura/cmdBranco/btnZoom (obj_4c_CmdgFigura.Buttons(1/2/3))
1980:     * seguem o MESMO "Not llEna" do legado - habilitados so em RESULTADO.
1981:     * Buttons(3) (Zoom) ainda combina com a presenca de imagem na linha
1982:     * corrente, via AtualizarEstadoBotaoZoom (equivalente ao btnZoom.When).
1983:     *==========================================================================
1984:     PROTECTED PROCEDURE AjustarControlesPorModo(par_lModoFiltro)
1985:         THIS.this_lModoFiltroAtual = par_lModoFiltro
1986: 
1987:         *-- LockScreen em volta do bloco inteiro, como no AcertaForm legado:
1988:         *-- sao ~20 trocas de Enabled e a tela "pisca" sem isso
1989:         THIS.LockScreen = .T.
1990: 
1991:         THIS.HabilitarCampos(par_lModoFiltro)
1992:         THIS.AjustarBotoesPorModo()
1993: 
1994:         THIS.LockScreen = .F.
1995: 
1996:         IF THIS.Visible
1997:             IF par_lModoFiltro
1998:                 THIS.txt_4c_DataIni.SetFocus()
1999:             ELSE
2000:                 THIS.grd_4c_Produtos.Column1.SetFocus()
2001:             ENDIF
2002:         ENDIF
2003:     ENDPROC
2004: 
2005:     *==========================================================================
2006:     * HabilitarCampos - Metade de CAMPOS do AcertaForm legado (LParameters
2007:     * llEna). par_lHabilitar = .T. (modo FILTRO) habilita periodo/grupo/
2008:     * produto/linha/situacao de imagem; .F. (modo RESULTADO) habilita a
2009:     * grade e as caixas de "Procurar".
2010:     *
2011:     * Transcricao literal do legado, inclusive nas ASSIMETRIAS: das 4 caixas
2012:     * de Procurar, o AcertaForm so toca getCPros e getReffs - getDPros e
2013:     * getIFors ficam sempre habilitadas. Uniformizar aqui mudaria o
2014:     * comportamento da tela (PILAR 1).
2015:     *
2016:     * par_lHabilitar eh OPCIONAL: sem argumento assume o modo corrente
2017:     * (this_lModoFiltroAtual), para poder ser chamado de fora sem conhecer
2018:     * o estado interno.
2019:     *==========================================================================
2020:     PROCEDURE HabilitarCampos(par_lHabilitar)
2021:         LOCAL loc_lHabilitar
2022: 
2023:         loc_lHabilitar = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", ;
2024:             par_lHabilitar, THIS.this_lModoFiltroAtual)
2025: 
2026:         WITH THIS
2027:             .txt_4c_DataIni.Enabled     = loc_lHabilitar
2028:             .txt_4c_DataFim.Enabled     = loc_lHabilitar
2029:             .txt_4c_Grupo.Enabled       = loc_lHabilitar
2030:             .txt_4c_DescGrupo.Enabled   = loc_lHabilitar
2031:             .txt_4c_Produto.Enabled     = loc_lHabilitar
2032:             .txt_4c_DescProduto.Enabled = loc_lHabilitar
2033:             .txt_4c_Linha.Enabled       = loc_lHabilitar
2034:             .txt_4c_DescLinha.Enabled   = loc_lHabilitar
2035: 
2036:             .opt_4c_TipoImagem.Buttons(1).Enabled = loc_lHabilitar
2037:             .opt_4c_TipoImagem.Buttons(2).Enabled = loc_lHabilitar
2038:             .opt_4c_TipoImagem.Buttons(3).Enabled = loc_lHabilitar
2039: 
2040:             *-- "Not llEna" do legado: so valem no modo RESULTADO
2041:             .txt_4c_BuscaCodigo.Enabled     = !loc_lHabilitar
2042:             .txt_4c_BuscaReferencia.Enabled = !loc_lHabilitar
2043:             .grd_4c_Produtos.Enabled        = !loc_lHabilitar
2044:         ENDWITH
2045:     ENDPROC
2046: 
2047:     *==========================================================================
2048:     * AjustarBotoesPorModo - Metade de BOTOES do AcertaForm legado, lida do
2049:     * modo corrente (this_lModoFiltroAtual):
2050:     *   modo FILTRO    -> so "Processar" (cmdSelecionar) habilitado
2051:     *   modo RESULTADO -> "Limpar Sel." (btnLimpar) + Imagem/Branco/Zoom
2052:     *                     (cmdgFigura.cmdFigura/cmdBranco/btnZoom)
2053:     *
2054:     * "Encerrar" (cmg_4c_Limpar.Buttons(2)) fica SEMPRE habilitado: o legado
2055:     * nao o inclui no AcertaForm, e desabilita-lo tiraria a unica saida da
2056:     * tela no modo filtro (o form tem ControlBox = .F.).
2057:     *
2058:     * Buttons(3) (Zoom) ainda depende de o produto corrente ter imagem -
2059:     * essa parte fica em AtualizarEstadoBotaoZoom (btnZoom.When legado),
2060:     * chamado no fim.
2061:     *
2062:     * PUBLIC: o TesteAutomatico.prg chama este metodo de FORA da classe
2063:     * (regra #3 - PEMSTATUS nao distingue PROTECTED).
2064:     *==========================================================================
2065:     PROCEDURE AjustarBotoesPorModo()
2066:         LOCAL loc_lModoFiltro
2067: 
2068:         loc_lModoFiltro = THIS.this_lModoFiltroAtual
2069: 
2070:         WITH THIS
2071:             .cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lModoFiltro
2072: 
2073:             .cnt_4c_Botoes.cmg_4c_Limpar.Buttons(1).Enabled = !loc_lModoFiltro
2074:             .cnt_4c_Botoes.cmg_4c_Limpar.Buttons(2).Enabled = .T.
2075: 
2076:             IF PEMSTATUS(.cnt_4c_BotoesAcao, "obj_4c_CmdgFigura", 5)
2077:                 .cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(1).Enabled = !loc_lModoFiltro
2078:                 .cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(2).Enabled = !loc_lModoFiltro
2079:             ENDIF
2080:         ENDWITH
2081: 
2082:         THIS.AtualizarEstadoBotaoZoom()
2083:     ENDPROC
2084: 
2085:     *==========================================================================
2086:     * EsvaziarCursorProdutos - "Zap In csProdutos" do legado.
2087:     *
2088:     * O ZAP tem de ser cercado por SET SAFETY OFF: SET SAFETY eh escopado por
2089:     * DATA SESSION e este form eh DataSession = 2, logo o SET SAFETY OFF do
2090:     * main.prg NAO alcanca a sessao privada - com SAFETY ON o ZAP abre o
2091:     * dialogo modal "Zap ... Are you sure?" e CONGELA a tela.
2092:     *
2093:     * ZAP (e nao USE IN + CREATE CURSOR) porque fechar e recriar o alias
2094:     * derrubaria Grid.RecordSource e as Column.ControlSource ligadas no
2095:     * ConfigurarGrid, deixando a grade vazia com o cursor cheio.
2096:     *==========================================================================
2097:     PROTECTED PROCEDURE EsvaziarCursorProdutos()
2098:         LOCAL loc_cSafety
2099: 
2100:         IF USED("cursor_4c_Produtos")
2101:             loc_cSafety = SET("SAFETY")
2102:             SET SAFETY OFF
2103: 
2104:             SELECT cursor_4c_Produtos
2105:             ZAP
2106: 
2107:             IF loc_cSafety = "ON"
2108:                 SET SAFETY ON
2109:             ENDIF
2110:         ENDIF
2111:     ENDPROC
2112: 
2113:     *==========================================================================
2114:     * TornarControlesVisiveis - Torna visiveis recursivamente os controles
2115:     * criados via AddObject (que nascem com Visible=.F.)
2116:     *==========================================================================
2117:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2118:         LOCAL loc_nI, loc_oControl
2119: 
2120:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2121:             loc_oControl = par_oContainer.Controls(loc_nI)
2122:             IF VARTYPE(loc_oControl) = "O"
2123:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2124:                     loc_oControl.Visible = .T.
2125:                 ENDIF
2126: 
2127:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2128:                     THIS.TornarControlesVisiveis(loc_oControl)
2129:                 ENDIF
2130:             ENDIF
2131:         ENDFOR
2132:     ENDPROC
2133: 
2134:     *==========================================================================
2135:     * Destroy - Libera cursores e recursos
2136:     *==========================================================================
2137:     PROCEDURE Destroy()
2138:         IF USED("cursor_4c_Produtos")
2139:             USE IN cursor_4c_Produtos
2140:         ENDIF
2141:         IF USED("cursor_4c_ProdutosTemp")
2142:             USE IN cursor_4c_ProdutosTemp
2143:         ENDIF
2144:         DODEFAULT()
2145:     ENDPROC
2146: 
2147: ENDDEFINE


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

