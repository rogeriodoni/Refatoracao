# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ExisteCodigoNaTabela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2181 linhas total):

*-- Linhas 4 a 61:
4: * SEM PageFrame/Page1/Page2; processo em lote que reajusta o preco de um
5: * conjunto de produtos e nao segue o padrao Lista/Dados do CRUD)
6: *
7: * Fase 3/8 - Estrutura Base: DEFINE CLASS, Init/InicializarForm e o cabecalho
8: * (equivalente ao cntSombra do legado).
9: *
10: * Fase 4/8 - Grid e Botoes: grd_4c_Produtos (SIGPRAPR.Grd_Produto - grade de
11: * conferencia, 5 colunas, marca/desmarca no Header1.Click) + cmg_4c_Botoes
12: * (SIGPRAPR.sair - Processar/Encerrar/Atualizar). A consulta/calculo de
13: * Processar e a gravacao de Atualizar ja estao implementadas em
14: * SigPrAprBO.BuscarProdutos()/Atualizar() - os handlers do form so acionam o
15: * BO e refletem o resultado na tela (regra: nenhum botao visivel fica sem
16: * funcionalidade real).
17: *
18: * Fase 5/8 - Campos Parte 1 (ConfigurarCampos): Grupo de Produto (de/ate),
19: * Grupo de Venda (Colecao) e TODOS os campos que o Opt_Tipo.
20: * InteractiveChange legado alterna via Visible (transcrito em
21: * OptTipoInteractiveChange) - Variacao/%/Incluir Custos (Tipo=1), Moeda/
22: * MarkUp1/MarkUp2/Fator de Custo/Moeda do Fator e o grupo Moeda Custo Compo./
23: * Moeda Custo Total/Feitio/Moeda Preco Ideal/Moeda Preco Atual (Tipo=2).
24: * SincronizarFiltros copia esses campos para o BO antes de BuscarProdutos()
25: * (BtnProcessarClick).
26: *
27: * Fase 6/8 - Campos Parte 2 (ConfigurarCampos) + Lookups: os campos que o
28: * Opt_Tipo NAO alterna - Promocao (Get_Promo), Limpar Promocoes Anteriores
29: * (chkLimpar), Ignorar Componentes (chkIgnorar) e Fornecedor (Get_Conta/
30: * Get_DConta). Fornecedor substitui o fAcessoContas('C'/'D',...) legado pelo
31: * padrao canonico do projeto (FormBase.AbrirLookupCanonico com filtro
32: * Grupos=GrPadFors, ao inves do auto-load por LIKE que fAcessoContas fazia -
33: * regra feedback_facessocontas_lookup_ux.md). Promocao usa o mesmo padrao
34: * contra SigPrPmc (tabela single-column, igual a SigCdOpe). SincronizarFiltros
35: * passou a copiar tambem estes campos.
36: *
37: * Fase 7/8 - Eventos Principais: este form OPERACIONAL nao tem CRUD
38: * (Incluir/Alterar/Visualizar/Excluir) - os "eventos principais" de verdade
39: * sao os que restaram em aberto das fases anteriores:
40: *   1) Lookup F4/Enter/Tab dos 10 campos de codigo que a Fase 5 criou so como
41: *      TextBox simples (Get_Cd_Grupo/Get_ate_Grupo -> SigCdGrp, Get_Col ->
42: *      SigCdCol, Get_CFtios -> SigPrFti, e os 6 campos de moeda -> SigCdMoe),
43: *      usando o mesmo padrao KeyPress + AbrirLookupCanonico ja usado em
44: *      Fornecedor/Promocao (Fase 6).
45: *   2) Get_Variacao.LostFocus -> foco no botao Processar (navegacao trivial,
46: *      mas eh evento real do legado).
47: *   3) O modo "Produtos" (chkAuditado + Shp_foto/FigJpg), explicitamente
48: *      adiado nas Fases 5/6: inclusao manual de um produto na grade, fora do
49: *      filtro Grupo/Colecao/Fornecedor - controles criados agora em
50: *      ConfigurarModoProdutos(), com o toggle (ChkAuditadoClick), o lookup
51: *      de produto na propria celula da grade (Grd_Produto.Column2) e o
52: *      calculo de preco ao confirmar o codigo digitado (Column2LostFocus).
53: *   4) Grd_Produto.AfterRowColChange (GridAfterRowColChange) - carrega a
54: *      foto do produto da linha corrente (SigCdPro.FigJpgs, base64) em
55: *      img_4c_FigJpg. Decodificar com STRCONV(...,14) UMA UNICA VEZ - um
56: *      segundo STRCONV sobre o binario ja decodificado corrompe o JPEG
57: *      (feedback_strconv_double_decode_imagem.md).
58: *
59: * Fase 8/8 - Consolidacao final: este form OPERACIONAL nao tem CRUD (sem
60: * PageFrame/Page1/Page2), entao o checklist generico de Fase 8
61: * (BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/

*-- Linhas 67 a 398:
67: * HabilitarCampos). Integracao conferida: menu.prg (popMovimentos bar 22 ->
68: * AbrirFormSigPrApr, padrao canonico Show() fora do TRY) e config.prg (ADIR
69: * carrega SigPrAprBO.prg/FormSigPrApr.prg automaticamente - sem SET
70: * PROCEDURE manual). Nenhum .fxp de SigPrApr* presente na arvore.
71: *
72: * Herda de: FormBase
73: *==============================================================================
74: 
75: DEFINE CLASS FormSigPrApr AS FormBase
76: 
77:     Width       = 1000
78:     Height      = 600
79:     Caption     = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
80:     DataSession = 2
81:     ShowWindow = 1
82:     WindowType = 1
83:     BorderStyle = 2
84:     DoCreate    = .T.
85:     ShowTips    = .T.
86:     AutoCenter  = .T.
87:     ControlBox  = .F.
88:     Closable    = .F.
89:     MaxButton   = .F.
90:     MinButton   = .F.
91:     TitleBar    = 0
92:     WindowState = 0
93:     Themes      = .F.
94:     FontName    = "Verdana"
95:     FontSize    = 8
96: 
97:     *-- Propriedades customizadas do form legado (SIGPRAPR.antvalue / .libvalatu)
98:     this_cAntValue  = ""
99:     this_lLibValAtu = .F.
100: 
101:     *==========================================================================
102:     * Init - DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
103:     *==========================================================================
104:     PROCEDURE Init()
105:         RETURN DODEFAULT()
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * InicializarForm - Cria o Business Object e monta a estrutura base do
110:     * form (fundo + cabecalho). Grade, filtros, botoes de processamento e
111:     * demais campos sao adicionados nas fases seguintes da migracao.
112:     *==========================================================================
113:     PROTECTED PROCEDURE InicializarForm()
114:         LOCAL loc_lSucesso, loc_oErro
115:         loc_lSucesso = .F.
116: 
117:         TRY
118:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")
119: 
120:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
121:                 MsgErro("Erro ao criar SigPrAprBO." + CHR(13) + ;
122:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
123:                     "Erro em FormSigPrApr.InicializarForm")
124:             ELSE
125:                 IF FILE(gc_4c_CaminhoFramework + "Imagens\new_background.jpg")
126:                     THIS.Picture = gc_4c_CaminhoFramework + "Imagens\new_background.jpg"
127:                 ENDIF
128: 
129:                 THIS.this_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu
130: 
131:                 THIS.ConfigurarPageFrame()
132: 
133:                 THIS.TornarControlesVisiveis(THIS)
134: 
135:                 *-- TornarControlesVisiveis torna TODOS os controles visiveis
136:                 *-- (regra do AddObject) - reaplicar o toggle do Opt_Tipo por
137:                 *-- cima para esconder de novo os campos que nao pertencem ao
138:                 *-- modo Variacao (Tipo=1, selecao inicial do OptionGroup)
139:                 THIS.OptTipoInteractiveChange()
140: 
141:                 loc_lSucesso = .T.
142:             ENDIF
143: 
144:         CATCH TO loc_oErro
145:             MsgErro(loc_oErro.Message + CHR(13) + ;
146:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
147:                 "Procedure: " + loc_oErro.Procedure, ;
148:                 "Erro em FormSigPrApr.InicializarForm")
149:         ENDTRY
150: 
151:         RETURN loc_lSucesso
152:     ENDPROC
153: 
154:     *==========================================================================
155:     * ConfigurarPageFrame - Ponto de entrada da montagem visual do form.
156:     * SIGPRAPR (SCX legado, Width=1000 Height=600) e dialog PLANO sem
157:     * PageFrame - PILAR 1 (UX pixel-perfect) manda manter o layout flat
158:     * identico ao legado ao inves de introduzir abas artificialmente. Este
159:     * metodo organiza as regioes visuais delegando para helpers dedicados,
160:     * preservando o papel de "ConfigurarPageFrame" como ponto de entrada da
161:     * montagem visual (mesmo padrao de FormFis/FormFAPF).
162:     *
163:     * A faixa do cabecalho (ConfigurarCabecalho) tem de ser o PRIMEIRO
164:     * AddObject da tela - os botoes de acao (cnt_4c_Sombra ocupa Top=0..80,
165:     * cmg_4c_Botoes flutua em Top=-2..83) ficam DENTRO da area da faixa e so
166:     * aparecem se criados DEPOIS dela.
167:     *==========================================================================
168:     PROTECTED PROCEDURE ConfigurarPageFrame()
169:         THIS.ConfigurarCabecalho()
170:         THIS.ConfigurarCampos()
171:         THIS.ConfigurarGrid()
172:         THIS.ConfigurarBotoes()
173:         THIS.ConfigurarModoProdutos()
174:     ENDPROC
175: 
176:     *==========================================================================
177:     * ConfigurarCabecalho - Faixa cinza do topo com o titulo do form
178:     * (SIGPRAPR.cntSombra + lblSombra/lblTitulo no legado)
179:     *==========================================================================
180:     PROTECTED PROCEDURE ConfigurarCabecalho()
181:         THIS.AddObject("cnt_4c_Sombra", "Container")
182:         WITH THIS.cnt_4c_Sombra
183:             .Top         = 0
184:             .Left        = 0
185:             .Width       = THIS.Width
186:             .Height      = 80
187:             .BorderWidth = 0
188:             .BackStyle   = 1
189:             .BackColor   = RGB(100, 100, 100)
190:             .Visible     = .T.
191:         ENDWITH
192: 
193:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
194:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
195:             .Top       = 15
196:             .Left      = 10
197:             .Width     = THIS.Width
198:             .Height    = 40
199:             .AutoSize  = .F.
200:             .WordWrap  = .T.
201:             .Alignment = 0
202:             .BackStyle = 0
203:             .FontName  = "Tahoma"
204:             .FontSize  = 16
205:             .FontBold  = .T.
206:             .ForeColor = RGB(0, 0, 0)
207:             .Caption   = THIS.Caption
208:         ENDWITH
209: 
210:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
211:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
212:             .Top       = 18
213:             .Left      = 10
214:             .Width     = THIS.Width
215:             .Height    = 46
216:             .AutoSize  = .F.
217:             .WordWrap  = .T.
218:             .Alignment = 0
219:             .BackStyle = 0
220:             .FontName  = "Tahoma"
221:             .FontSize  = 16
222:             .FontBold  = .T.
223:             .ForeColor = RGB(255, 255, 255)
224:             .Caption   = THIS.Caption
225:         ENDWITH
226:     ENDPROC
227: 
228:     *==========================================================================
229:     * ConfigurarCampos - Campos de filtro/reajuste (SIGPRAPR - PARTE 1/2 desta
230:     * migracao). Cobre: Grupo de Produto (de/ate), Grupo de Venda (Colecao),
231:     * tipo de reajuste (Opt_Tipo) e TODOS os campos que o Opt_Tipo.
232:     * InteractiveChange do legado alterna via Visible (Variacao/%, Moeda,
233:     * MarkUp1/MarkUp2, Fator de Custo+Moeda do Fator, Incluir Custos, e o
234:     * grupo Moeda Custo Compo./Moeda Custo Total/Feitio/Moeda Preco Ideal/
235:     * Moeda Preco Atual). Ficam para a Parte 2: Fornecedor (Get_Conta/
236:     * Get_DConta), Promocao, Limpar Promocoes Anteriores, Ignorar Componentes
237:     * e o modo "Produtos" (chkAuditado + Shp_foto/FigJpg) - nenhum desses eh
238:     * tocado pelo Opt_Tipo.
239:     *
240:     * Todos os controles vao direto em THIS (form flat, sem PageFrame/Page -
241:     * mesmo padrao de cnt_4c_Sombra/grd_4c_Produtos/cmg_4c_Botoes).
242:     *==========================================================================
243:     PROTECTED PROCEDURE ConfigurarCampos()
244:         *-- Say10 "Reajuste por :" (label acima do OptionGroup)
245:         THIS.AddObject("lbl_4c_ReajustePor", "Label")
246:         WITH THIS.lbl_4c_ReajustePor
247:             .Top       = 139
248:             .Left      = 92
249:             .Width     = 71
250:             .Height    = 15
251:             .AutoSize  = .F.
252:             .Alignment = 0
253:             .BackStyle = 0
254:             .FontName  = "Tahoma"
255:             .FontSize  = 8
256:             .ForeColor = RGB(90, 90, 90)
257:             .Caption   = "Reajuste por :"
258:         ENDWITH
259: 
260:         *-- lbl_grupo "Grupo de Produto :" + Get_Cd_Grupo (de) + Say5 "ate" +
261:         *-- Get_ate_Grupo (faixa de grupo, mesmo par usado no WHERE de
262:         *-- BuscarProdutos - this_cCdGrupo/this_cAteGrupo)
263:         THIS.AddObject("lbl_4c_Grupo", "Label")
264:         WITH THIS.lbl_4c_Grupo
265:             .Top       = 113
266:             .Left      = 69
267:             .Width     = 94
268:             .Height    = 15
269:             .AutoSize  = .F.
270:             .Alignment = 0
271:             .BackStyle = 0
272:             .FontName  = "Tahoma"
273:             .FontSize  = 8
274:             .ForeColor = RGB(90, 90, 90)
275:             .Caption   = "Grupo de Produto :"
276:         ENDWITH
277: 
278:         THIS.AddObject("txt_4c_CdGrupo", "TextBox")
279:         WITH THIS.txt_4c_CdGrupo
280:             .Top       = 109
281:             .Left      = 165
282:             .Width     = 31
283:             .Height    = 23
284:             .FontName  = "Tahoma"
285:             .FontSize  = 8
286:             .ForeColor = RGB(0, 0, 0)
287:             .Format    = "K!"
288:             .MaxLength = 3
289:             .Value     = ""
290:         ENDWITH
291:         BINDEVENT(THIS.txt_4c_CdGrupo, "KeyPress", THIS, "TxtCdGrupoKeyPress")
292: 
293:         THIS.AddObject("lbl_4c_AteGrupo", "Label")
294:         WITH THIS.lbl_4c_AteGrupo
295:             .Top       = 113
296:             .Left      = 203
297:             .Width     = 18
298:             .Height    = 15
299:             .AutoSize  = .F.
300:             .Alignment = 0
301:             .BackStyle = 0
302:             .FontName  = "Tahoma"
303:             .FontSize  = 8
304:             .ForeColor = RGB(90, 90, 90)
305:             .Caption   = "at" + CHR(233)
306:         ENDWITH
307: 
308:         THIS.AddObject("txt_4c_AteGrupo", "TextBox")
309:         WITH THIS.txt_4c_AteGrupo
310:             .Top       = 109
311:             .Left      = 228
312:             .Width     = 31
313:             .Height    = 23
314:             .FontName  = "Tahoma"
315:             .FontSize  = 8
316:             .ForeColor = RGB(0, 0, 0)
317:             .Format    = "K!"
318:             .MaxLength = 3
319:             .Value     = ""
320:         ENDWITH
321:         BINDEVENT(THIS.txt_4c_AteGrupo, "KeyPress", THIS, "TxtAteGrupoKeyPress")
322: 
323:         *-- Say2 "Grupo de Venda :" + Get_Col (this_cColecao)
324:         THIS.AddObject("lbl_4c_GrupoVenda", "Label")
325:         WITH THIS.lbl_4c_GrupoVenda
326:             .Top       = 113
327:             .Left      = 399
328:             .Width     = 86
329:             .Height    = 15
330:             .AutoSize  = .F.
331:             .Alignment = 0
332:             .BackStyle = 0
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .ForeColor = RGB(90, 90, 90)
336:             .Caption   = "Grupo de Venda :"
337:         ENDWITH
338: 
339:         THIS.AddObject("txt_4c_Colecao", "TextBox")
340:         WITH THIS.txt_4c_Colecao
341:             .Top       = 109
342:             .Left      = 487
343:             .Width     = 94
344:             .Height    = 23
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .ForeColor = RGB(0, 0, 0)
348:             .Format    = "K"
349:             .MaxLength = 10
350:             .Value     = ""
351:         ENDWITH
352:         BINDEVENT(THIS.txt_4c_Colecao, "KeyPress", THIS, "TxtColecaoKeyPress")
353: 
354:         *-- Opt_Tipo (fwoption -> OptionGroup): 1=Variacao, 2=MarkUp, 3=Cambio
355:         *-- (this_nTipo). InteractiveChange (transcrito em
356:         *-- OptTipoInteractiveChange) alterna a visibilidade de todos os
357:         *-- campos abaixo conforme o botao selecionado.
358:         THIS.AddObject("opt_4c_Tipo", "OptionGroup")
359:         WITH THIS.opt_4c_Tipo
360:             .Top           = 134
361:             .Left          = 159
362:             .Width         = 208
363:             .Height        = 24
364:             .ButtonCount   = 3
365:             .BackStyle     = 0
366:             .BorderStyle   = 0
367:             .SpecialEffect = 0
368:             .Value         = 1
369: 
370:             WITH .Buttons(1)
371:                 .Top       = 5
372:                 .Left      = 5
373:                 .Width     = 59
374:                 .Height    = 15
375:                 .AutoSize  = .T.
376:                 .BackStyle = 0
377:                 .FontName  = "Comic Sans MS"
378:                 .FontSize  = 8
379:                 .ForeColor = RGB(90, 90, 90)
380:                 .Caption   = "Varia" + CHR(231) + CHR(227) + "o"
381:             ENDWITH
382: 
383:             WITH .Buttons(2)
384:                 .Top       = 5
385:                 .Left      = 74
386:                 .Height    = 15
387:                 .AutoSize  = .T.
388:                 .BackStyle = 0
389:                 .FontName  = "Comic Sans MS"
390:                 .FontSize  = 8
391:                 .ForeColor = RGB(90, 90, 90)
392:                 .Caption   = "MarkUp"
393:             ENDWITH
394: 
395:             WITH .Buttons(3)
396:                 .Top       = 5
397:                 .Left      = 139
398:                 .Width     = 53

*-- Linhas 407 a 484:
407:                 .WordWrap        = .T.
408:             ENDWITH
409:         ENDWITH
410:         BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
411: 
412:         *-- lbl_Variacao "Variacao de Preco :" + Get_Variacao (%) + Say1 "%"
413:         *-- (visivel so com Tipo=1)
414:         THIS.AddObject("lbl_4c_Variacao", "Label")
415:         WITH THIS.lbl_4c_Variacao
416:             .Top       = 139
417:             .Left      = 390
418:             .Width     = 95
419:             .Height    = 15
420:             .AutoSize  = .F.
421:             .Alignment = 0
422:             .BackStyle = 0
423:             .FontName  = "Tahoma"
424:             .FontSize  = 8
425:             .ForeColor = RGB(90, 90, 90)
426:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
427:         ENDWITH
428: 
429:         THIS.AddObject("txt_4c_Variacao", "TextBox")
430:         WITH THIS.txt_4c_Variacao
431:             .Top       = 135
432:             .Left      = 487
433:             .Width     = 94
434:             .Height    = 23
435:             .Alignment = 3
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .ForeColor = RGB(0, 0, 0)
439:             .InputMask = "99,999.99"
440:             .MaxLength = 9
441:             .Value     = 0
442:         ENDWITH
443:         *-- Legado: PROCEDURE LostFocus -> ThisForm.Sair.Processa.SetFocus
444:         BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "TxtVariacaoLostFocus")
445: 
446:         THIS.AddObject("lbl_4c_Percentual", "Label")
447:         WITH THIS.lbl_4c_Percentual
448:             .Top       = 139
449:             .Left      = 585
450:             .Width     = 13
451:             .Height    = 15
452:             .AutoSize  = .F.
453:             .Alignment = 0
454:             .BackStyle = 0
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .ForeColor = RGB(90, 90, 90)
458:             .Caption   = "%"
459:         ENDWITH
460: 
461:         *-- lbl_Moeda "Moeda :" + Get_Moeda (visivel so com Tipo=2 - moeda
462:         *-- base do MarkUp, this_cMoeda). Ocupa o MESMO Top/Left do
463:         *-- Get_Variacao no legado (137,487) - so um dos dois esta visivel
464:         *-- por vez, conforme Opt_Tipo.
465:         THIS.AddObject("lbl_4c_Moeda", "Label")
466:         WITH THIS.lbl_4c_Moeda
467:             .Top       = 139
468:             .Left      = 444
469:             .Width     = 41
470:             .Height    = 15
471:             .AutoSize  = .F.
472:             .Alignment = 0
473:             .BackStyle = 0
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .ForeColor = RGB(90, 90, 90)
477:             .Caption   = "Moeda :"
478:         ENDWITH
479: 
480:         THIS.AddObject("txt_4c_Moeda", "TextBox")
481:         WITH THIS.txt_4c_Moeda
482:             .Top       = 135
483:             .Left      = 487
484:             .Width     = 31

*-- Linhas 490 a 533:
490:             .MaxLength = 3
491:             .Value     = ""
492:         ENDWITH
493:         BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")
494: 
495:         *-- lbl_MarkUp "MarkUp :" + Get_MarkUp1 + Say4 "para" + Get_MarkUp2
496:         *-- (faixa de markup, visivel so com Tipo=2 - this_nMarkUp1/
497:         *-- this_nMarkUp2, usados no WHERE e no calculo de CalcPreco)
498:         THIS.AddObject("lbl_4c_MarkUp", "Label")
499:         WITH THIS.lbl_4c_MarkUp
500:             .Top       = 165
501:             .Left      = 440
502:             .Width     = 45
503:             .Height    = 15
504:             .AutoSize  = .F.
505:             .Alignment = 0
506:             .BackStyle = 0
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .ForeColor = RGB(90, 90, 90)
510:             .Caption   = "MarkUp :"
511:         ENDWITH
512: 
513:         THIS.AddObject("txt_4c_MarkUp1", "TextBox")
514:         WITH THIS.txt_4c_MarkUp1
515:             .Top       = 161
516:             .Left      = 487
517:             .Width     = 52
518:             .Height    = 23
519:             .Alignment = 3
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .ForeColor = RGB(0, 0, 0)
523:             .InputMask = "999.99"
524:             .MaxLength = 6
525:             .Value     = 0
526:         ENDWITH
527: 
528:         THIS.AddObject("lbl_4c_Para", "Label")
529:         WITH THIS.lbl_4c_Para
530:             .Top       = 165
531:             .Left      = 547
532:             .Width     = 24
533:             .Height    = 15

*-- Linhas 600 a 851:
600:             .MaxLength = 3
601:             .Value     = ""
602:         ENDWITH
603:         BINDEVENT(THIS.txt_4c_MoeCusto, "KeyPress", THIS, "TxtMoeCustoKeyPress")
604: 
605:         *-- chkIncCusts "Incluir Custos" (this_lIncCusts - visivel so com
606:         *-- Tipo=1, reajusta tambem PCuss/CustoFs proporcionalmente)
607:         THIS.AddObject("chk_4c_IncCusts", "CheckBox")
608:         WITH THIS.chk_4c_IncCusts
609:             .Top       = 139
610:             .Left      = 609
611:             .Width     = 83
612:             .Height    = 15
613:             .AutoSize  = .T.
614:             .BackStyle = 0
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .ForeColor = RGB(90, 90, 90)
618:             .Caption   = "Incluir Custos"
619:             .Value     = 0
620:         ENDWITH
621: 
622:         *-- Moeda Custo Compo. (Get_Moecs -> this_cMoeCs), visivel so com Tipo=2
623:         THIS.AddObject("lbl_4c_MoedaCusCompo", "Label")
624:         WITH THIS.lbl_4c_MoedaCusCompo
625:             .Top       = 244
626:             .Left      = 51
627:             .Width     = 112
628:             .Height    = 15
629:             .AutoSize  = .F.
630:             .Alignment = 0
631:             .BackStyle = 0
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8
634:             .ForeColor = RGB(90, 90, 90)
635:             .Caption   = "Moeda Custo Compo. :"
636:         ENDWITH
637: 
638:         THIS.AddObject("txt_4c_MoeCs", "TextBox")
639:         WITH THIS.txt_4c_MoeCs
640:             .Top       = 240
641:             .Left      = 165
642:             .Width     = 31
643:             .Height    = 23
644:             .FontName  = "Tahoma"
645:             .FontSize  = 8
646:             .ForeColor = RGB(0, 0, 0)
647:             .Format    = "K!"
648:             .MaxLength = 3
649:             .Value     = ""
650:         ENDWITH
651:         BINDEVENT(THIS.txt_4c_MoeCs, "KeyPress", THIS, "TxtMoeCsKeyPress")
652: 
653:         *-- Moeda Custo Total (Get_MoeCusFs -> this_cMoeCusFs), Tipo=2
654:         THIS.AddObject("lbl_4c_MoedaCusTotal", "Label")
655:         WITH THIS.lbl_4c_MoedaCusTotal
656:             .Top       = 270
657:             .Left      = 64
658:             .Width     = 99
659:             .Height    = 15
660:             .AutoSize  = .F.
661:             .Alignment = 0
662:             .BackStyle = 0
663:             .FontName  = "Tahoma"
664:             .FontSize  = 8
665:             .ForeColor = RGB(90, 90, 90)
666:             .Caption   = "Moeda Custo Total :"
667:         ENDWITH
668: 
669:         THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
670:         WITH THIS.txt_4c_MoeCusFs
671:             .Top       = 266
672:             .Left      = 165
673:             .Width     = 31
674:             .Height    = 23
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .ForeColor = RGB(0, 0, 0)
678:             .Format    = "K!"
679:             .MaxLength = 3
680:             .Value     = ""
681:         ENDWITH
682:         BINDEVENT(THIS.txt_4c_MoeCusFs, "KeyPress", THIS, "TxtMoeCusFsKeyPress")
683: 
684:         *-- Feitio (Get_CFtios -> this_cCFtios), Tipo=2
685:         THIS.AddObject("lbl_4c_Feitio", "Label")
686:         WITH THIS.lbl_4c_Feitio
687:             .Top       = 244
688:             .Left      = 531
689:             .Width     = 35
690:             .Height    = 15
691:             .AutoSize  = .F.
692:             .Alignment = 0
693:             .BackStyle = 0
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8
696:             .ForeColor = RGB(90, 90, 90)
697:             .Caption   = "Feitio :"
698:         ENDWITH
699: 
700:         THIS.AddObject("txt_4c_CFtios", "TextBox")
701:         WITH THIS.txt_4c_CFtios
702:             .Top       = 240
703:             .Left      = 568
704:             .Width     = 31
705:             .Height    = 23
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .ForeColor = RGB(0, 0, 0)
709:             .Format    = "K!"
710:             .MaxLength = 3
711:             .Value     = ""
712:         ENDWITH
713:         BINDEVENT(THIS.txt_4c_CFtios, "KeyPress", THIS, "TxtCFtiosKeyPress")
714: 
715:         *-- Moeda Preco Ideal (Get_Moedas -> this_cMoedas), Tipo=2
716:         THIS.AddObject("lbl_4c_MoedaPrecoIdeal", "Label")
717:         WITH THIS.lbl_4c_MoedaPrecoIdeal
718:             .Top       = 244
719:             .Left      = 320
720:             .Width     = 98
721:             .Height    = 15
722:             .AutoSize  = .F.
723:             .Alignment = 0
724:             .BackStyle = 0
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .ForeColor = RGB(90, 90, 90)
728:             .Caption   = "Moeda Pre" + CHR(231) + "o Ideal :"
729:         ENDWITH
730: 
731:         THIS.AddObject("txt_4c_Moedas", "TextBox")
732:         WITH THIS.txt_4c_Moedas
733:             .Top       = 240
734:             .Left      = 420
735:             .Width     = 31
736:             .Height    = 23
737:             .FontName  = "Tahoma"
738:             .FontSize  = 8
739:             .ForeColor = RGB(0, 0, 0)
740:             .Format    = "K!"
741:             .MaxLength = 3
742:             .Value     = ""
743:         ENDWITH
744:         BINDEVENT(THIS.txt_4c_Moedas, "KeyPress", THIS, "TxtMoedasKeyPress")
745: 
746:         *-- Moeda Preco Atual (Get_MoeVs -> this_cMoeVs), Tipo=2
747:         THIS.AddObject("lbl_4c_MoedaPrecoAtual", "Label")
748:         WITH THIS.lbl_4c_MoedaPrecoAtual
749:             .Top       = 270
750:             .Left      = 319
751:             .Width     = 99
752:             .Height    = 15
753:             .AutoSize  = .F.
754:             .Alignment = 0
755:             .BackStyle = 0
756:             .FontName  = "Tahoma"
757:             .FontSize  = 8
758:             .ForeColor = RGB(90, 90, 90)
759:             .Caption   = "Moeda Pre" + CHR(231) + "o Atual :"
760:         ENDWITH
761: 
762:         THIS.AddObject("txt_4c_MoeVs", "TextBox")
763:         WITH THIS.txt_4c_MoeVs
764:             .Top       = 266
765:             .Left      = 420
766:             .Width     = 31
767:             .Height    = 23
768:             .FontName  = "Tahoma"
769:             .FontSize  = 8
770:             .ForeColor = RGB(0, 0, 0)
771:             .Format    = "K!"
772:             .MaxLength = 3
773:             .Value     = ""
774:         ENDWITH
775:         BINDEVENT(THIS.txt_4c_MoeVs, "KeyPress", THIS, "TxtMoeVsKeyPress")
776: 
777:         *----------------------------------------------------------------------
778:         * PARTE 2 (Fase 6/8) - campos que o Opt_Tipo NAO alterna: sempre
779:         * visiveis, sem depender do tipo de reajuste escolhido.
780:         *----------------------------------------------------------------------
781: 
782:         *-- Say6 "Promocao :" + Get_Promo (this_cPromo, SigPrPmc.Promos -
783:         *-- lookup single-column, igual a SigCdOpe/Dopes)
784:         THIS.AddObject("lbl_4c_Promocao", "Label")
785:         WITH THIS.lbl_4c_Promocao
786:             .Top       = 191
787:             .Left      = 107
788:             .Width     = 56
789:             .Height    = 15
790:             .AutoSize  = .F.
791:             .Alignment = 0
792:             .BackStyle = 0
793:             .FontName  = "Tahoma"
794:             .FontSize  = 8
795:             .ForeColor = RGB(90, 90, 90)
796:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
797:         ENDWITH
798: 
799:         THIS.AddObject("txt_4c_Promo", "TextBox")
800:         WITH THIS.txt_4c_Promo
801:             .Top       = 187
802:             .Left      = 165
803:             .Width     = 185
804:             .Height    = 23
805:             .FontName  = "Tahoma"
806:             .FontSize  = 8
807:             .ForeColor = RGB(0, 0, 0)
808:             .MaxLength = 25
809:             .Value     = ""
810:         ENDWITH
811:         BINDEVENT(THIS.txt_4c_Promo, "KeyPress", THIS, "TxtPromoKeyPress")
812: 
813:         *-- chkLimpar "Limpar Promocoes Anteriores" (this_lLimparPromos)
814:         THIS.AddObject("chk_4c_Limpar", "CheckBox")
815:         WITH THIS.chk_4c_Limpar
816:             .Top       = 191
817:             .Left      = 362
818:             .Width     = 157
819:             .Height    = 15
820:             .AutoSize  = .T.
821:             .BackStyle = 0
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .ForeColor = RGB(90, 90, 90)
825:             .Caption   = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
826:             .Value     = 0
827:         ENDWITH
828: 
829:         *-- chkIgnorar "Ignorar Componentes" (this_lIgnorar - nao filtra
830:         *-- produto-componente na consulta de BuscarProdutos)
831:         THIS.AddObject("chk_4c_Ignorar", "CheckBox")
832:         WITH THIS.chk_4c_Ignorar
833:             .Top       = 112
834:             .Left      = 609
835:             .Width     = 123
836:             .Height    = 15
837:             .AutoSize  = .T.
838:             .BackStyle = 0
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .ForeColor = RGB(90, 90, 90)
842:             .Caption   = "Ignorar Componentes"
843:             .Value     = 0
844:         ENDWITH
845: 
846:         *-- Say7 "Fornecedor :" + Get_Conta (codigo) + Get_DConta (descricao) -
847:         *-- lookup restrito ao grupo padrao de acesso a Contas
848:         *-- (this_oBusinessObject.this_cGrPadFors, carregado no Init do BO a
849:         *-- partir de SigCdPam.GrPadFors - equivalente a "Grupo =
850:         *-- CrSigCdPam.GrPadFors" do legado). Substitui fAcessoContas() (regra
851:         *-- feedback_facessocontas_lookup_ux.md - NAO usar auto-load por LIKE).

*-- Linhas 876 a 951:
876:             .MaxLength = 10
877:             .Value     = ""
878:         ENDWITH
879:         BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "TxtContaKeyPress")
880: 
881:         THIS.AddObject("txt_4c_DConta", "TextBox")
882:         WITH THIS.txt_4c_DConta
883:             .Top        = 213
884:             .Left       = 248
885:             .Width      = 290
886:             .Height     = 23
887:             .FontName   = "Tahoma"
888:             .FontSize   = 8
889:             .ForeColor  = RGB(0, 0, 0)
890:             .MaxLength  = 50
891:             .Value      = ""
892:         ENDWITH
893:         BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")
894:     ENDPROC
895: 
896:     *==========================================================================
897:     * OptTipoInteractiveChange - Transcreve o PROCEDURE InteractiveChange do
898:     * Opt_Tipo legado: alterna a visibilidade dos campos conforme o tipo de
899:     * reajuste escolhido (1=Variacao, 2=MarkUp, 3=Cambio - Cambio nao usa
900:     * nenhum dos campos abaixo, so Grupo/Colecao/Fornecedor/Promo, que ficam
901:     * sempre visiveis). PUBLIC de proposito: acionado via BINDEVENT
902:     * (InteractiveChange) e tambem chamado direto por InicializarForm/
903:     * TesteAutomatico para repor o estado inicial (Tipo=1).
904:     *
905:     * PEMSTATUS em cada controle: a Parte 2 desta migracao ainda vai
906:     * acrescentar Fornecedor/Promocao/flags/chkAuditado, que este metodo NAO
907:     * referencia (o Opt_Tipo legado nao alterna esses campos) - os guards
908:     * aqui protegem apenas contra a ordem de chamada dentro do Init, nao
909:     * substituem os campos que faltam.
910:     *==========================================================================
911:     PROCEDURE OptTipoInteractiveChange()
912:         LOCAL loc_nTipo, loc_lVisivelVariacao, loc_lVisivelMarkUp
913: 
914:         IF !PEMSTATUS(THIS, "opt_4c_Tipo", 5)
915:             RETURN
916:         ENDIF
917:         loc_nTipo = THIS.opt_4c_Tipo.Value
918: 
919:         loc_lVisivelVariacao = (loc_nTipo = 1)
920:         loc_lVisivelMarkUp   = (loc_nTipo = 2)
921: 
922:         IF PEMSTATUS(THIS, "lbl_4c_Variacao", 5)
923:             THIS.lbl_4c_Variacao.Visible = loc_lVisivelVariacao
924:         ENDIF
925:         IF PEMSTATUS(THIS, "txt_4c_Variacao", 5)
926:             THIS.txt_4c_Variacao.Visible = loc_lVisivelVariacao
927:         ENDIF
928:         IF PEMSTATUS(THIS, "lbl_4c_Percentual", 5)
929:             THIS.lbl_4c_Percentual.Visible = loc_lVisivelVariacao
930:         ENDIF
931:         IF PEMSTATUS(THIS, "chk_4c_IncCusts", 5)
932:             THIS.chk_4c_IncCusts.Visible = loc_lVisivelVariacao
933:         ENDIF
934: 
935:         IF PEMSTATUS(THIS, "lbl_4c_Moeda", 5)
936:             THIS.lbl_4c_Moeda.Visible = loc_lVisivelMarkUp
937:         ENDIF
938:         IF PEMSTATUS(THIS, "txt_4c_Moeda", 5)
939:             THIS.txt_4c_Moeda.Visible = loc_lVisivelMarkUp
940:         ENDIF
941:         IF PEMSTATUS(THIS, "lbl_4c_MarkUp", 5)
942:             THIS.lbl_4c_MarkUp.Visible = loc_lVisivelMarkUp
943:         ENDIF
944:         IF PEMSTATUS(THIS, "txt_4c_MarkUp1", 5)
945:             THIS.txt_4c_MarkUp1.Visible = loc_lVisivelMarkUp
946:         ENDIF
947:         IF PEMSTATUS(THIS, "lbl_4c_Para", 5)
948:             THIS.lbl_4c_Para.Visible = loc_lVisivelMarkUp
949:         ENDIF
950:         IF PEMSTATUS(THIS, "txt_4c_MarkUp2", 5)
951:             THIS.txt_4c_MarkUp2.Visible = loc_lVisivelMarkUp

*-- Linhas 999 a 1256:
999:     * (ThisForm.Sair.Processa.SetFocus) - so navegacao de foco, sem SQL, entao
1000:     * nao esbarra na regra de nao usar LostFocus para carregar dados.
1001:     *==========================================================================
1002:     PROCEDURE TxtVariacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1003:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1004:             THIS.cmg_4c_Botoes.Buttons(1).SetFocus()
1005:         ENDIF
1006:     ENDPROC
1007: 
1008:     *==========================================================================
1009:     * ExisteCodigoNaTabela - Helper generico usado pelos KeyPress de lookup
1010:     * (Enter/Tab): confere existencia EXATA de par_cValor em par_cCampoCod de
1011:     * par_cTabela, sem abrir o picker.
1012:     *==========================================================================
1013:     PROTECTED FUNCTION ExisteCodigoNaTabela(par_cTabela, par_cCampoCod, par_cValor)
1014:         LOCAL loc_cCursor, loc_lAchou, loc_oErro
1015:         loc_cCursor = "cursor_4c_LkpExiste"
1016:         loc_lAchou  = .F.
1017: 
1018:         TRY
1019:             IF USED(loc_cCursor)
1020:                 USE IN (loc_cCursor)
1021:             ENDIF
1022:             IF SQLEXEC(gnConnHandle, "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
1023:                     " WHERE " + par_cCampoCod + " = " + EscaparSQL(par_cValor), loc_cCursor) > 0 AND ;
1024:                USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1025:                 loc_lAchou = .T.
1026:             ENDIF
1027:             IF USED(loc_cCursor)
1028:                 USE IN (loc_cCursor)
1029:             ENDIF
1030:         CATCH TO loc_oErro
1031:             MsgErro(loc_oErro.Message, "FormSigPrApr.ExisteCodigoNaTabela")
1032:         ENDTRY
1033: 
1034:         RETURN loc_lAchou
1035:     ENDFUNC
1036: 
1037:     *==========================================================================
1038:     * ValidarECompletarMoeda - Helper compartilhado pelos 6 campos de moeda
1039:     * (Get_Moeda/Get_Moecs/Get_MoeCusFs/Get_Moedas/Get_MoeVs/get_moeCusto),
1040:     * todos fwbuscaext contra SigCdMoe/CMoes/DMoes no legado.
1041:     *==========================================================================
1042:     PROTECTED PROCEDURE ValidarECompletarMoeda(par_oTxt)
1043:         LOCAL loc_cValor
1044:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1045: 
1046:         IF EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdMoe", "CMoes", loc_cValor)
1047:             RETURN
1048:         ENDIF
1049: 
1050:         THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", loc_cValor, par_oTxt, .NULL.)
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * TxtCdGrupoKeyPress - Equivalente ao Valid do Get_Cd_Grupo legado
1055:     * (fwbuscaext contra SigCdGrp). Preserva o auto-preenchimento de
1056:     * Get_ate_Grupo quando ele ainda esta vazio (legado: "If Empty(This.
1057:     * Parent.Get_ate_Grupo.Value) / This.Parent.Get_ate_Grupo.Value = this.
1058:     * Value").
1059:     *==========================================================================
1060:     PROCEDURE TxtCdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1061:         LOCAL loc_cValor
1062: 
1063:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1064:             RETURN
1065:         ENDIF
1066: 
1067:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, ""))
1068:         IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdGrp", "CGrus", loc_cValor))
1069:             IF !EMPTY(loc_cValor) AND EMPTY(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
1070:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1071:             ENDIF
1072:             RETURN
1073:         ENDIF
1074: 
1075:         THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", "Grupos de Produto", loc_cValor, THIS.txt_4c_CdGrupo, .NULL.)
1076:         IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
1077:             THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1078:         ENDIF
1079:     ENDPROC
1080: 
1081:     *==========================================================================
1082:     * TxtAteGrupoKeyPress - Equivalente ao Get_ate_Grupo legado (mesma tabela
1083:     * de Get_Cd_Grupo, sem o auto-preenchimento).
1084:     *==========================================================================
1085:     PROCEDURE TxtAteGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1086:         LOCAL loc_cValor
1087: 
1088:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1089:             RETURN
1090:         ENDIF
1091: 
1092:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
1093:         IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdGrp", "CGrus", loc_cValor))
1094:             RETURN
1095:         ENDIF
1096: 
1097:         THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", "Grupos de Produto", loc_cValor, THIS.txt_4c_AteGrupo, .NULL.)
1098:     ENDPROC
1099: 
1100:     *==========================================================================
1101:     * TxtColecaoKeyPress - Equivalente ao Get_Col legado (fwbuscaext contra
1102:     * SigCdCol/Colecoes/Descs).
1103:     *==========================================================================
1104:     PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1105:         LOCAL loc_cValor
1106: 
1107:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1108:             RETURN
1109:         ENDIF
1110: 
1111:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Colecao.Value, ""))
1112:         IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdCol", "Colecoes", loc_cValor))
1113:             RETURN
1114:         ENDIF
1115: 
1116:         THIS.AbrirLookupCanonico("SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(245) + "es", loc_cValor, THIS.txt_4c_Colecao, .NULL.)
1117:     ENDPROC
1118: 
1119:     *==========================================================================
1120:     * TxtCFtiosKeyPress - Equivalente ao Get_CFtios legado (fwbuscaext contra
1121:     * SigPrFti/Cods/Descs).
1122:     *==========================================================================
1123:     PROCEDURE TxtCFtiosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1124:         LOCAL loc_cValor
1125: 
1126:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1127:             RETURN
1128:         ENDIF
1129: 
1130:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, ""))
1131:         IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigPrFti", "Cods", loc_cValor))
1132:             RETURN
1133:         ENDIF
1134: 
1135:         THIS.AbrirLookupCanonico("SigPrFti", "Cods", "Descs", "Feitio", loc_cValor, THIS.txt_4c_CFtios, .NULL.)
1136:     ENDPROC
1137: 
1138:     *==========================================================================
1139:     * TxtMoedaKeyPress / TxtMoeCustoKeyPress / TxtMoeCsKeyPress /
1140:     * TxtMoeCusFsKeyPress / TxtMoedasKeyPress / TxtMoeVsKeyPress - os 6 campos
1141:     * de moeda (Get_Moeda/get_moeCusto/Get_Moecs/Get_MoeCusFs/Get_Moedas/
1142:     * Get_MoeVs), todos delegando para ValidarECompletarMoeda.
1143:     *==========================================================================
1144:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1145:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1146:             RETURN
1147:         ENDIF
1148:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1149:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_Moeda.Value, "")), THIS.txt_4c_Moeda, .NULL.)
1150:             RETURN
1151:         ENDIF
1152:         THIS.ValidarECompletarMoeda(THIS.txt_4c_Moeda)
1153:     ENDPROC
1154: 
1155:     PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1156:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1157:             RETURN
1158:         ENDIF
1159:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1160:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, "")), THIS.txt_4c_MoeCusto, .NULL.)
1161:             RETURN
1162:         ENDIF
1163:         THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeCusto)
1164:     ENDPROC
1165: 
1166:     PROCEDURE TxtMoeCsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1167:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1168:             RETURN
1169:         ENDIF
1170:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1171:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeCs.Value, "")), THIS.txt_4c_MoeCs, .NULL.)
1172:             RETURN
1173:         ENDIF
1174:         THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeCs)
1175:     ENDPROC
1176: 
1177:     PROCEDURE TxtMoeCusFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1178:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1179:             RETURN
1180:         ENDIF
1181:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1182:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, "")), THIS.txt_4c_MoeCusFs, .NULL.)
1183:             RETURN
1184:         ENDIF
1185:         THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeCusFs)
1186:     ENDPROC
1187: 
1188:     PROCEDURE TxtMoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1189:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1190:             RETURN
1191:         ENDIF
1192:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1193:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_Moedas.Value, "")), THIS.txt_4c_Moedas, .NULL.)
1194:             RETURN
1195:         ENDIF
1196:         THIS.ValidarECompletarMoeda(THIS.txt_4c_Moedas)
1197:     ENDPROC
1198: 
1199:     PROCEDURE TxtMoeVsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1200:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1201:             RETURN
1202:         ENDIF
1203:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1204:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value, "")), THIS.txt_4c_MoeVs, .NULL.)
1205:             RETURN
1206:         ENDIF
1207:         THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeVs)
1208:     ENDPROC
1209: 
1210:     *==========================================================================
1211:     * TxtContaKeyPress - Equivalente ao Valid do Get_Conta legado
1212:     * (fAcessoContas(Usuar,Grupo,'C',...)). F4 sempre abre o lookup filtrado
1213:     * pelo Grupo padrao de acesso a Contas (GrPadFors); Enter/Tab valida
1214:     * existencia exata em SigCdCli e, se nao achar, abre o mesmo lookup.
1215:     *==========================================================================
1216:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1217:         LOCAL loc_cValor, loc_lAchou, loc_oErro
1218: 
1219:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1220:             RETURN
1221:         ENDIF
1222: 
1223:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1224:             THIS.AbrirLookupConta()
1225:             RETURN
1226:         ENDIF
1227: 
1228:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Conta.Value, ""))
1229:         IF EMPTY(loc_cValor)
1230:             THIS.txt_4c_DConta.Value = ""
1231:             RETURN
1232:         ENDIF
1233: 
1234:         loc_lAchou = .F.
1235:         TRY
1236:             IF USED("cursor_4c_LkpConta")
1237:                 USE IN cursor_4c_LkpConta
1238:             ENDIF
1239:             IF SQLEXEC(gnConnHandle, ;
1240:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cValor) + ;
1241:                     " AND Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)), ;
1242:                     "cursor_4c_LkpConta") > 0 AND ;
1243:                USED("cursor_4c_LkpConta") AND RECCOUNT("cursor_4c_LkpConta") > 0
1244:                 THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_LkpConta.IClis)
1245:                 THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_LkpConta.RClis)
1246:                 loc_lAchou = .T.
1247:             ENDIF
1248:             IF USED("cursor_4c_LkpConta")
1249:                 USE IN cursor_4c_LkpConta
1250:             ENDIF
1251:         CATCH TO loc_oErro
1252:             MsgErro(loc_oErro.Message, "FormSigPrApr.TxtContaKeyPress")
1253:         ENDTRY
1254: 
1255:         IF !loc_lAchou
1256:             THIS.AbrirLookupConta()

*-- Linhas 1264 a 1410:
1264:     * (Empty(ThisForm.Get_Conta.Value))" - com codigo preenchido, o campo de
1265:     * descricao eh so espelho e nao dispara consulta propria).
1266:     *==========================================================================
1267:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1268:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1269:             RETURN
1270:         ENDIF
1271: 
1272:         IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")))
1273:             RETURN
1274:         ENDIF
1275: 
1276:         THIS.AbrirLookupContaPorDescricao()
1277:     ENDPROC
1278: 
1279:     *==========================================================================
1280:     * AbrirLookupConta - Lookup de Fornecedor por codigo (SigCdCli.IClis/
1281:     * RClis), restrito ao Grupo padrao de acesso a Contas (this_cGrPadFors).
1282:     *==========================================================================
1283:     PROTECTED PROCEDURE AbrirLookupConta()
1284:         THIS.AbrirLookupCanonico("SigCdCli", "IClis", "RClis", ;
1285:             "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
1286:             ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")), ;
1287:             THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1288:             "Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)))
1289:     ENDPROC
1290: 
1291:     *==========================================================================
1292:     * AbrirLookupContaPorDescricao - Mesmo lookup de Fornecedor, mas com o
1293:     * prefixo digitado em Get_DConta (busca por Razao Social - modo 'D' do
1294:     * fAcessoContas legado).
1295:     *==========================================================================
1296:     PROTECTED PROCEDURE AbrirLookupContaPorDescricao()
1297:         THIS.AbrirLookupCanonico("SigCdCli", "IClis", "RClis", ;
1298:             "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
1299:             ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")), ;
1300:             THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1301:             "Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)))
1302:     ENDPROC
1303: 
1304:     *==========================================================================
1305:     * TxtPromoKeyPress - Equivalente ao Valid do Get_Promo legado
1306:     * (fwbuscaext contra SigPrPmc). F4 sempre abre o lookup; Enter/Tab valida
1307:     * existencia exata e, se nao achar, abre o mesmo lookup. SigPrPmc.Promos
1308:     * eh PK e descricao ao mesmo tempo (tabela single-column, igual a
1309:     * SigCdOpe.Dopes - regra: nunca inventar segunda coluna de descricao).
1310:     *==========================================================================
1311:     PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1312:         LOCAL loc_cValor, loc_lAchou, loc_oErro
1313: 
1314:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1315:             RETURN
1316:         ENDIF
1317: 
1318:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1319:             THIS.AbrirLookupPromo()
1320:             RETURN
1321:         ENDIF
1322: 
1323:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Promo.Value, ""))
1324:         IF EMPTY(loc_cValor)
1325:             RETURN
1326:         ENDIF
1327: 
1328:         loc_lAchou = .F.
1329:         TRY
1330:             IF USED("cursor_4c_LkpPromo")
1331:                 USE IN cursor_4c_LkpPromo
1332:             ENDIF
1333:             IF SQLEXEC(gnConnHandle, ;
1334:                     "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cValor), ;
1335:                     "cursor_4c_LkpPromo") > 0 AND ;
1336:                USED("cursor_4c_LkpPromo") AND RECCOUNT("cursor_4c_LkpPromo") > 0
1337:                 THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_LkpPromo.Promos)
1338:                 loc_lAchou = .T.
1339:             ENDIF
1340:             IF USED("cursor_4c_LkpPromo")
1341:                 USE IN cursor_4c_LkpPromo
1342:             ENDIF
1343:         CATCH TO loc_oErro
1344:             MsgErro(loc_oErro.Message, "FormSigPrApr.TxtPromoKeyPress")
1345:         ENDTRY
1346: 
1347:         IF !loc_lAchou
1348:             THIS.AbrirLookupPromo()
1349:         ENDIF
1350:     ENDPROC
1351: 
1352:     *==========================================================================
1353:     * AbrirLookupPromo - Lookup de Promocao (SigPrPmc.Promos - coluna unica)
1354:     *==========================================================================
1355:     PROTECTED PROCEDURE AbrirLookupPromo()
1356:         THIS.AbrirLookupCanonico("SigPrPmc", "Promos", "Promos", ;
1357:             "Promo" + CHR(231) + CHR(227) + "o", ;
1358:             ALLTRIM(NVL(THIS.txt_4c_Promo.Value, "")), ;
1359:             THIS.txt_4c_Promo, .NULL.)
1360:     ENDPROC
1361: 
1362:     *==========================================================================
1363:     * SincronizarFiltros - Copia os campos de filtro/reajuste (Parte 1 desta
1364:     * migracao) para as propriedades this_ do BO, exatamente como o legado le
1365:     * ThisForm.Get_Xxx.Value dentro do proprio Processa.Click. Chamado por
1366:     * BtnProcessarClick ANTES de BuscarProdutos(). A Parte 2 (Fornecedor/
1367:     * Promocao/flags/chkAuditado) sera acrescentada aqui quando esses campos
1368:     * forem criados.
1369:     *==========================================================================
1370:     PROTECTED PROCEDURE SincronizarFiltros()
1371:         LOCAL loc_oBO
1372: 
1373:         loc_oBO = THIS.this_oBusinessObject
1374:         IF VARTYPE(loc_oBO) != "O"
1375:             RETURN
1376:         ENDIF
1377: 
1378:         IF PEMSTATUS(THIS, "txt_4c_CdGrupo", 5)
1379:             loc_oBO.this_cCdGrupo = PADR(ALLTRIM(THIS.txt_4c_CdGrupo.Value), 3)
1380:         ENDIF
1381:         IF PEMSTATUS(THIS, "txt_4c_AteGrupo", 5)
1382:             loc_oBO.this_cAteGrupo = PADR(ALLTRIM(THIS.txt_4c_AteGrupo.Value), 3)
1383:         ENDIF
1384:         IF PEMSTATUS(THIS, "txt_4c_Colecao", 5)
1385:             loc_oBO.this_cColecao = PADR(ALLTRIM(THIS.txt_4c_Colecao.Value), 10)
1386:         ENDIF
1387:         IF PEMSTATUS(THIS, "opt_4c_Tipo", 5)
1388:             loc_oBO.this_nTipo = THIS.opt_4c_Tipo.Value
1389:         ENDIF
1390:         IF PEMSTATUS(THIS, "txt_4c_Variacao", 5)
1391:             loc_oBO.this_nVariacao = THIS.txt_4c_Variacao.Value
1392:         ENDIF
1393:         IF PEMSTATUS(THIS, "txt_4c_Moeda", 5)
1394:             loc_oBO.this_cMoeda = PADR(ALLTRIM(THIS.txt_4c_Moeda.Value), 3)
1395:         ENDIF
1396:         IF PEMSTATUS(THIS, "txt_4c_MarkUp1", 5)
1397:             loc_oBO.this_nMarkUp1 = THIS.txt_4c_MarkUp1.Value
1398:         ENDIF
1399:         IF PEMSTATUS(THIS, "txt_4c_MarkUp2", 5)
1400:             loc_oBO.this_nMarkUp2 = THIS.txt_4c_MarkUp2.Value
1401:         ENDIF
1402:         IF PEMSTATUS(THIS, "txt_4c_Fator", 5)
1403:             loc_oBO.this_nFator = THIS.txt_4c_Fator.Value
1404:         ENDIF
1405:         IF PEMSTATUS(THIS, "txt_4c_MoeCusto", 5)
1406:             loc_oBO.this_cMoeCusto = PADR(ALLTRIM(THIS.txt_4c_MoeCusto.Value), 3)
1407:         ENDIF
1408:         IF PEMSTATUS(THIS, "chk_4c_IncCusts", 5)
1409:             loc_oBO.this_lIncCusts = (THIS.chk_4c_IncCusts.Value = 1)
1410:         ENDIF

*-- Linhas 1455 a 1500:
1455:     * (DPros, sempre somente leitura no legado - When -> .F.) / Preco
1456:     * Anterior (ValAnt, sempre somente leitura) / Preco Atual (ValAtu,
1457:     * editavel SO com a permissao fChecaAcesso('SIGPRAPR','VMANUAL') -
1458:     * this_lLibValAtu, ja copiada do BO em InicializarForm).
1459:     *==========================================================================
1460:     PROTECTED PROCEDURE ConfigurarGrid()
1461:         LOCAL loc_oGrid, loc_cCursor
1462: 
1463:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1464: 
1465:         THIS.AddObject("grd_4c_Produtos", "Grid")
1466:         loc_oGrid = THIS.grd_4c_Produtos
1467:         loc_oGrid.ColumnCount  = 5
1468:         loc_oGrid.RecordSource = loc_cCursor
1469:         WITH loc_oGrid
1470:             .Top          = 307
1471:             .Left         = 31
1472:             .Width        = 725
1473:             .Height       = 247
1474:             .FontName     = "Verdana"
1475:             .FontSize     = 8
1476:             .HeaderHeight = 20
1477:             .RowHeight    = 16
1478:             .ScrollBars   = 2
1479:             .DeleteMark   = .F.
1480:             .RecordMark   = .F.
1481: 
1482:             *-- Column1: Marca (lMarca) - CheckBox (regra #18: Column.AddObject
1483:             *-- exige CurrentControl, senao a coluna continua desenhando o Text1)
1484:             .Column1.ControlSource = loc_cCursor + ".lMarca"
1485:             .Column1.Width         = 20
1486:             .Column1.Alignment     = 3
1487:             .Column1.Movable       = .F.
1488:             .Column1.Resizable     = .F.
1489:             .Column1.Sparse        = .F.
1490:             .Column1.ReadOnly      = .F.
1491:         ENDWITH
1492: 
1493:         loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1494:         WITH loc_oGrid.Column1.Check1
1495:             .Caption  = ""
1496:             .AutoSize = .T.
1497:             .Visible  = .T.
1498:         ENDWITH
1499:         loc_oGrid.Column1.CurrentControl   = "Check1"
1500:         loc_oGrid.Column1.Header1.Caption   = ""

*-- Linhas 1544 a 1623:
1544:         ENDWITH
1545: 
1546:         *-- Legado: Column1.Header1.Click (toggle marcar/desmarcar todos)
1547:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "GridHeaderMarcaClick")
1548:         *-- Legado: Column1.Check1.When -> Return(!Empty(CrProdutos.CPros)) -
1549:         *-- impede marcar a linha em branco que o modo "Produtos" mantem no
1550:         *-- fim da grade enquanto o codigo ainda nao foi digitado
1551:         BINDEVENT(loc_oGrid.Column1.Check1, "When", THIS, "Column1CheckWhen")
1552:         *-- Legado: Column5.Text1.Valid (marca Manual=1 quando o usuario altera
1553:         *-- o Preco Atual manualmente na grade, e insere a proxima linha em
1554:         *-- branco do modo "Produtos" quando aplicavel)
1555:         BINDEVENT(loc_oGrid.Column5.Text1,   "Valid", THIS, "ColValAtuValid")
1556:         *-- Legado: Column2.Text1.When (guarda o valor ANTES do foco, para
1557:         *-- LostFocus saber se o codigo mudou) / Valid (lookup fwbuscaext
1558:         *-- contra SigCdPro) / LostFocus (calcula o preco do produto digitado
1559:         *-- manualmente - modo "Produtos")
1560:         BINDEVENT(loc_oGrid.Column2.Text1, "GotFocus",  THIS, "Column2GotFocus")
1561:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid",     THIS, "Column2Valid")
1562:         BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "Column2LostFocus")
1563:         *-- Legado: Grd_Produto.AfterRowColChange - carrega a foto do produto
1564:         *-- da linha corrente (regra #3: precisa declarar par_nColIndex)
1565:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")
1566:     ENDPROC
1567: 
1568:     *==========================================================================
1569:     * ConfigurarBotoes - Cria o grupo Processar/Encerrar/Atualizar (SIGPRAPR.
1570:     * sair do legado). Top=-2/Left=770 posiciona o grupo flutuando SOBRE a
1571:     * faixa do cabecalho (cnt_4c_Sombra, Top=0..80, ja criado ANTES deste
1572:     * metodo por ConfigurarPageFrame - regra da faixa ser o PRIMEIRO
1573:     * AddObject da tela).
1574:     *
1575:     * Numeracao dos botoes IDENTICA ao legado (Command1=Processa/Buttons(1),
1576:     * Command2=Cancela/Buttons(2), Command3=Atualiza/Buttons(3)) - a ordem
1577:     * VISUAL (Left) difere da ordem de CRIACAO, exatamente como no SCX.
1578:     * Atualizar comeca desabilitado (legado: Init faz
1579:     * ThisForm.Sair.Atualiza.Enabled = .F.) - so liga apos Processar bem
1580:     * sucedido (BtnProcessarClick) e desliga de novo ao fim de todo clique em
1581:     * Atualizar, haja ou nao confirmado a gravacao (BtnAtualizarClick).
1582:     *==========================================================================
1583:     PROTECTED PROCEDURE ConfigurarBotoes()
1584:         LOCAL loc_oGrp
1585: 
1586:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
1587:         loc_oGrp = THIS.cmg_4c_Botoes
1588:         WITH loc_oGrp
1589:             .Top           = -2
1590:             .Left          = 770
1591:             .Width         = 235
1592:             .Height        = 85
1593:             .ButtonCount   = 3
1594:             .BackStyle     = 0
1595:             .BorderStyle   = 0
1596:             .SpecialEffect = 1
1597:             .Themes        = .F.
1598: 
1599:             WITH .Buttons(1)
1600:                 .Top        = 5
1601:                 .Left       = 5
1602:                 .Width      = 75
1603:                 .Height     = 75
1604:                 .FontName   = "Comic Sans MS"
1605:                 .FontSize   = 8
1606:                 .FontBold   = .T.
1607:                 .FontItalic = .T.
1608:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1609:                 .Caption    = "\<Processar"
1610:                 .ForeColor  = RGB(90, 90, 90)
1611:                 .BackColor  = RGB(255, 255, 255)
1612:                 .Themes     = .F.
1613:             ENDWITH
1614: 
1615:             WITH .Buttons(2)
1616:                 .Top        = 5
1617:                 .Left       = 155
1618:                 .Width      = 75
1619:                 .Height     = 75
1620:                 .FontName   = "Comic Sans MS"
1621:                 .FontSize   = 8
1622:                 .FontBold   = .T.
1623:                 .FontItalic = .T.

*-- Linhas 1648 a 1931:
1648:             ENDWITH
1649:         ENDWITH
1650: 
1651:         BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnProcessarClick")
1652:         BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
1653:         BINDEVENT(loc_oGrp.Buttons(3), "Click", THIS, "BtnAtualizarClick")
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * CarregarLista - Reexibe a grade de conferencia apos popular/esvaziar o
1658:     * cursor de trabalho (regra: popular cursor NAO repinta a grade sozinho -
1659:     * legado: Select CrProdutos / Go Top / ThisForm.Grd_Produto.Refresh).
1660:     * PUBLIC de proposito: TesteAutomatico.prg chama metodos de carga direto
1661:     * no oForm, e metodo PROTECTED falha em runtime mesmo passando no PEMSTATUS.
1662:     *==========================================================================
1663:     PROCEDURE CarregarLista()
1664:         LOCAL loc_oBO, loc_cCursor
1665: 
1666:         loc_oBO = THIS.this_oBusinessObject
1667:         IF VARTYPE(loc_oBO) = "O"
1668:             loc_cCursor = loc_oBO.this_cCursorItens
1669:             IF USED(loc_cCursor)
1670:                 SELECT (loc_cCursor)
1671:                 GO TOP
1672:             ENDIF
1673:         ENDIF
1674: 
1675:         IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1676:             THIS.grd_4c_Produtos.Refresh()
1677:         ENDIF
1678:     ENDPROC
1679: 
1680:     *==========================================================================
1681:     * GridHeaderMarcaClick - Transcreve o PROCEDURE Click do Column1.Header1
1682:     * legado (marca/desmarca todos os produtos da grade de uma vez).
1683:     *==========================================================================
1684:     PROCEDURE GridHeaderMarcaClick()
1685:         LOCAL loc_oBO, loc_cCursor
1686: 
1687:         IF !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1688:             RETURN
1689:         ENDIF
1690:         loc_oBO = THIS.this_oBusinessObject
1691:         IF VARTYPE(loc_oBO) != "O"
1692:             RETURN
1693:         ENDIF
1694: 
1695:         loc_cCursor = loc_oBO.this_cCursorItens
1696:         IF !USED(loc_cCursor)
1697:             RETURN
1698:         ENDIF
1699: 
1700:         IF THIS.grd_4c_Produtos.Column1.Header1.Tag = "0"
1701:             UPDATE (loc_cCursor) SET lMarca = 1
1702:             THIS.grd_4c_Produtos.Column1.Header1.Tag = "1"
1703:         ELSE
1704:             UPDATE (loc_cCursor) SET lMarca = 0
1705:             THIS.grd_4c_Produtos.Column1.Header1.Tag = "0"
1706:         ENDIF
1707: 
1708:         THIS.grd_4c_Produtos.Refresh()
1709:     ENDPROC
1710: 
1711:     *==========================================================================
1712:     * ColValAtuValid - Transcreve o PROCEDURE Valid do Column5.Text1 legado:
1713:     * marca Manual=1 no cursor quando o usuario altera manualmente o Preco
1714:     * Atual (a insercao de linha em branco no fim, que o legado faz junto
1715:     * disso para o modo de digitacao manual de produto, fica para quando o
1716:     * modo "Produtos"/chkAuditado for wireado, em fase posterior).
1717:     *==========================================================================
1718:     PROCEDURE ColValAtuValid()
1719:         LOCAL loc_oBO, loc_cCursor, loc_nValorNovo, loc_nValorAtual, loc_lAlterado
1720: 
1721:         loc_oBO = THIS.this_oBusinessObject
1722:         IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1723:             RETURN .T.
1724:         ENDIF
1725: 
1726:         loc_cCursor   = loc_oBO.this_cCursorItens
1727:         loc_lAlterado = .F.
1728:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1729:             loc_nValorNovo = THIS.grd_4c_Produtos.Column5.Text1.Value
1730:             SELECT (loc_cCursor)
1731:             loc_nValorAtual = ValAtu
1732:             loc_lAlterado   = (loc_nValorAtual <> loc_nValorNovo)
1733:             IF loc_oBO.this_lLibValAtu AND loc_lAlterado
1734:                 REPLACE Manual WITH 1 IN (loc_cCursor)
1735:             ENDIF
1736: 
1737:             *-- Legado (modo "Produtos"): "If This.Value <> ThisForm.AntValue Or
1738:             *-- Lastkey() = 13" - ao confirmar o Preco Atual de uma linha recem
1739:             *-- preenchida manualmente, insere OUTRA linha em branco no fim e
1740:             *-- desce o cursor para ela (o guard !Empty(CPros) evita duplicar a
1741:             *-- linha em branco quando o usuario so passa pela coluna sem
1742:             *-- preencher produto nenhum)
1743:             IF loc_oBO.this_lAuditado AND (loc_lAlterado OR LASTKEY() = 13)
1744:                 SELECT (loc_cCursor)
1745:                 IF !EMPTY(ALLTRIM(NVL(CPros, "")))
1746:                     INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
1747:                 ENDIF
1748:                 THIS.grd_4c_Produtos.Refresh()
1749:                 KEYBOARD "{DNARROW}"
1750:             ENDIF
1751:         ENDIF
1752: 
1753:         RETURN .T.
1754:     ENDPROC
1755: 
1756:     *==========================================================================
1757:     * Column1CheckWhen - Equivalente ao When do Column1.Check1 legado: impede
1758:     * marcar (Space no Check1) a linha em branco que o modo "Produtos" deixa
1759:     * no fim da grade enquanto o Produto ainda nao foi digitado.
1760:     *==========================================================================
1761:     PROCEDURE Column1CheckWhen()
1762:         LOCAL loc_oBO, loc_cCursor
1763: 
1764:         loc_oBO = THIS.this_oBusinessObject
1765:         IF VARTYPE(loc_oBO) != "O"
1766:             RETURN .T.
1767:         ENDIF
1768: 
1769:         loc_cCursor = loc_oBO.this_cCursorItens
1770:         IF !USED(loc_cCursor)
1771:             RETURN .T.
1772:         ENDIF
1773: 
1774:         RETURN !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".CPros"), "")))
1775:     ENDPROC
1776: 
1777:     *==========================================================================
1778:     * Column2GotFocus - Equivalente ao When do Column2.Text1 legado ("ThisForm.
1779:     * Antvalue = This.Value"): guarda o valor ANTES da edicao em
1780:     * this_cAntValue, para Column2LostFocus saber se o codigo mudou (mesmo
1781:     * papel de ThisForm.AntValue no legado, sem precisar de BINDEVENT em
1782:     * "When" para este controle - a captura acontece ao GANHAR foco, e a
1783:     * comparacao acontece ao PERDER foco).
1784:     *==========================================================================
1785:     PROCEDURE Column2GotFocus()
1786:         IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1787:             THIS.this_cAntValue = ALLTRIM(NVL(THIS.grd_4c_Produtos.Column2.Text1.Value, ""))
1788:         ENDIF
1789:     ENDPROC
1790: 
1791:     *==========================================================================
1792:     * Column2Valid - Equivalente ao Valid do Column2.Text1 legado: lookup
1793:     * fwbuscaext contra SigCdPro/CPros/DPros (modo "Produtos" - digitacao
1794:     * manual do codigo do produto na propria celula da grade).
1795:     *==========================================================================
1796:     PROCEDURE Column2Valid()
1797:         LOCAL loc_oGrid, loc_cValor, loc_lAchou, loc_oErro
1798: 
1799:         IF !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1800:             RETURN .T.
1801:         ENDIF
1802:         loc_oGrid  = THIS.grd_4c_Produtos
1803:         loc_cValor = ALLTRIM(NVL(loc_oGrid.Column2.Text1.Value, ""))
1804: 
1805:         IF !EMPTY(loc_cValor)
1806:             loc_lAchou = .F.
1807:             TRY
1808:                 IF USED("cursor_4c_LkpProdutoManual")
1809:                     USE IN cursor_4c_LkpProdutoManual
1810:                 ENDIF
1811:                 IF SQLEXEC(gnConnHandle, "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cValor), ;
1812:                         "cursor_4c_LkpProdutoManual") > 0 AND ;
1813:                    USED("cursor_4c_LkpProdutoManual") AND RECCOUNT("cursor_4c_LkpProdutoManual") > 0
1814:                     loc_lAchou = .T.
1815:                 ENDIF
1816:                 IF USED("cursor_4c_LkpProdutoManual")
1817:                     USE IN cursor_4c_LkpProdutoManual
1818:                 ENDIF
1819:             CATCH TO loc_oErro
1820:                 MsgErro(loc_oErro.Message, "FormSigPrApr.Column2Valid")
1821:             ENDTRY
1822: 
1823:             IF !loc_lAchou
1824:                 THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", "Produtos", loc_cValor, loc_oGrid.Column2.Text1, .NULL.)
1825:             ENDIF
1826:         ENDIF
1827: 
1828:         loc_oGrid.Refresh()
1829:         RETURN .T.
1830:     ENDPROC
1831: 
1832:     *==========================================================================
1833:     * Column2LostFocus - Equivalente ao LostFocus do Column2.Text1 legado:
1834:     * confirmado o codigo do produto (modo "Produtos"), pede ao BO
1835:     * (ProcessarProdutoManual) para calcular o novo preco conforme
1836:     * this_nTipo/this_nVariacao/this_nMarkUp2 (mesmo criterio de
1837:     * BuscarProdutos, aqui para um UNICO produto digitado manualmente) e
1838:     * gravar a linha; este metodo so cuida da parte de UI (refresh, avanco
1839:     * para a proxima linha em branco, habilitar Atualizar).
1840:     *==========================================================================
1841:     PROCEDURE Column2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1842:         LOCAL loc_oBO, loc_oGrid, loc_cCursor, loc_cValor
1843: 
1844:         loc_oBO = THIS.this_oBusinessObject
1845:         IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1846:             RETURN
1847:         ENDIF
1848:         loc_oGrid   = THIS.grd_4c_Produtos
1849:         loc_cCursor = loc_oBO.this_cCursorItens
1850:         loc_cValor  = ALLTRIM(NVL(loc_oGrid.Column2.Text1.Value, ""))
1851: 
1852:         IF EMPTY(loc_cValor) OR loc_cValor == ALLTRIM(NVL(THIS.this_cAntValue, ""))
1853:             RETURN
1854:         ENDIF
1855: 
1856:         THIS.SincronizarFiltros()
1857: 
1858:         IF loc_oBO.ProcessarProdutoManual(loc_cValor)
1859:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1860:                 THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1861:             ENDIF
1862: 
1863:             *-- Legado: sem permissao de editar o Preco Atual (Column5
1864:             *-- ficaria travada), insere OUTRA linha em branco e desce
1865:             *-- direto para ela; COM permissao, deixa o tab natural levar
1866:             *-- para Column5 (o insert/desce fica por conta do
1867:             *-- ColValAtuValid nesse caso, ao confirmar o preco)
1868:             IF !loc_oBO.this_lLibValAtu AND USED(loc_cCursor)
1869:                 SELECT (loc_cCursor)
1870:                 IF !EMPTY(ALLTRIM(NVL(CPros, "")))
1871:                     INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
1872:                 ENDIF
1873:                 loc_oGrid.Refresh()
1874:                 KEYBOARD "{DNARROW}"
1875:             ELSE
1876:                 loc_oGrid.Refresh()
1877:             ENDIF
1878:         ELSE
1879:             MsgAviso("Produto n" + CHR(227) + "o encontrado" + CHR(33) + CHR(33) + CHR(33) + CHR(13) + ;
1880:                 "Reinicie o processo.", "Aten" + CHR(231) + CHR(227) + "o")
1881:         ENDIF
1882:     ENDPROC
1883: 
1884:     *==========================================================================
1885:     * GridAfterRowColChange - Equivalente ao AfterRowColChange do Grd_Produto
1886:     * legado: carrega a foto do produto (SigCdPro.FigJpgs, base64) da linha
1887:     * corrente em img_4c_FigJpg. STRCONV(...,14) UMA UNICA VEZ - decodifica
1888:     * base64 -> binario JPEG; um segundo STRCONV sobre o binario ja
1889:     * decodificado corrompe a imagem (feedback_strconv_double_decode_imagem).
1890:     *==========================================================================
1891:     PROCEDURE GridAfterRowColChange(par_nColIndex)
1892:         LOCAL loc_oBO, loc_cCursor, loc_cCpros, loc_cArqFig, loc_oErro
1893: 
1894:         IF !PEMSTATUS(THIS, "img_4c_FigJpg", 5) OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1895:             RETURN
1896:         ENDIF
1897:         loc_oBO = THIS.this_oBusinessObject
1898:         IF VARTYPE(loc_oBO) != "O"
1899:             RETURN
1900:         ENDIF
1901: 
1902:         loc_cCursor = loc_oBO.this_cCursorItens
1903:         THIS.img_4c_FigJpg.Visible = .F.
1904:         THIS.img_4c_FigJpg.Picture = ""
1905: 
1906:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
1907:             RETURN
1908:         ENDIF
1909: 
1910:         loc_cCpros = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".CPros"), ""))
1911:         IF EMPTY(loc_cCpros)
1912:             RETURN
1913:         ENDIF
1914: 
1915:         TRY
1916:             IF USED("cursor_4c_FotoProduto")
1917:                 USE IN cursor_4c_FotoProduto
1918:             ENDIF
1919:             SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros), "cursor_4c_FotoProduto")
1920: 
1921:             IF USED("cursor_4c_FotoProduto") AND !EOF("cursor_4c_FotoProduto") AND ;
1922:                !ISNULL(cursor_4c_FotoProduto.FigJpgs) AND !EMPTY(cursor_4c_FotoProduto.FigJpgs)
1923:                 loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1924:                 STRTOFILE(STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoProduto.FigJpgs, ;
1925:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), "data:image/jpg;base64,", ""), 14), ;
1926:                     loc_cArqFig)
1927:                 THIS.img_4c_FigJpg.Picture = loc_cArqFig
1928:                 THIS.img_4c_FigJpg.Visible = .T.
1929:             ENDIF
1930: 
1931:             IF USED("cursor_4c_FotoProduto")

*-- Linhas 1942 a 2040:
1942:     * grade para inclusao manual de um item (fora do filtro Grupo/Colecao/
1943:     * Fornecedor) e a moldura/imagem que exibe a foto do produto corrente.
1944:     *==========================================================================
1945:     PROTECTED PROCEDURE ConfigurarModoProdutos()
1946:         THIS.AddObject("shp_4c_Foto", "Shape")
1947:         WITH THIS.shp_4c_Foto
1948:             .Top           = 414
1949:             .Left          = 763
1950:             .Width         = 205
1951:             .Height        = 140
1952:             .BackStyle     = 0
1953:             .BorderStyle   = 1
1954:             .FillStyle     = 1
1955:             .SpecialEffect = 1
1956:             .BorderColor   = RGB(90, 90, 90)
1957:         ENDWITH
1958: 
1959:         THIS.AddObject("img_4c_FigJpg", "Image")
1960:         WITH THIS.img_4c_FigJpg
1961:             .Top     = 415
1962:             .Left    = 764
1963:             .Width   = 203
1964:             .Height  = 138
1965:             .Stretch = 1
1966:             .Visible = .F.
1967:         ENDWITH
1968: 
1969:         THIS.AddObject("chk_4c_Auditado", "CheckBox")
1970:         WITH THIS.chk_4c_Auditado
1971:             .Top        = 307
1972:             .Left       = 763
1973:             .Width      = 75
1974:             .Height     = 75
1975:             .Style      = 1
1976:             .Alignment  = 0
1977:             .FontName   = "Comic Sans MS"
1978:             .FontSize   = 8
1979:             .FontBold   = .T.
1980:             .FontItalic = .T.
1981:             .Picture    = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
1982:             .Caption    = "Pro\<dutos"
1983:             .ForeColor  = RGB(90, 90, 90)
1984:             .BackColor  = RGB(255, 255, 255)
1985:             .Themes     = .F.
1986:             .Value      = 0
1987:         ENDWITH
1988:         BINDEVENT(THIS.chk_4c_Auditado, "Click", THIS, "ChkAuditadoClick")
1989:     ENDPROC
1990: 
1991:     *==========================================================================
1992:     * ChkAuditadoClick - Transcreve o PROCEDURE Click do chkAuditado legado:
1993:     * alterna a grade entre o modo normal (produtos filtrados por Processar)
1994:     * e o modo "Produtos" (inclusao manual de UM item, digitado direto na
1995:     * grade). Ligar o modo desabilita os filtros e a Column1/libera a
1996:     * Column2; desligar devolve o estado normal e remove a linha em branco
1997:     * corrente (legado: "Delete From CrProdutos" sem escopo = so o registro
1998:     * ATUAL, que SET DELETED ON global esconde sem precisar de PACK).
1999:     *==========================================================================
2000:     PROCEDURE ChkAuditadoClick()
2001:         LOCAL loc_oBO, loc_cCursor, loc_oGrid
2002: 
2003:         loc_oBO = THIS.this_oBusinessObject
2004:         IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
2005:             RETURN
2006:         ENDIF
2007:         loc_cCursor = loc_oBO.this_cCursorItens
2008:         loc_oGrid   = THIS.grd_4c_Produtos
2009: 
2010:         loc_oBO.this_lAuditado = (THIS.chk_4c_Auditado.Value = 1)
2011: 
2012:         IF loc_oBO.this_lAuditado
2013:             IF USED(loc_cCursor)
2014:                 INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
2015:                 SELECT (loc_cCursor)
2016:                 SET ORDER TO
2017:                 GO TOP
2018:             ENDIF
2019:             THIS.txt_4c_CdGrupo.Enabled  = .F.
2020:             THIS.txt_4c_AteGrupo.Enabled = .F.
2021:             THIS.txt_4c_Colecao.Enabled  = .F.
2022:             THIS.txt_4c_Moeda.Enabled    = .F.
2023:             THIS.txt_4c_MarkUp1.Enabled  = .F.
2024:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2025:                 THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
2026:             ENDIF
2027:             loc_oGrid.Column1.Check1.ReadOnly = .T.
2028:             loc_oGrid.Column2.Text1.ReadOnly  = .F.
2029:             loc_oGrid.Refresh()
2030:             loc_oGrid.Column2.Text1.SetFocus()
2031:         ELSE
2032:             IF USED(loc_cCursor)
2033:                 SELECT (loc_cCursor)
2034:                 DELETE
2035:                 SET ORDER TO CPros
2036:                 GO TOP
2037:             ENDIF
2038:             THIS.txt_4c_CdGrupo.Enabled  = .T.
2039:             THIS.txt_4c_AteGrupo.Enabled = .T.
2040:             THIS.txt_4c_Colecao.Enabled  = .T.

*-- Linhas 2051 a 2181:
2051:     ENDPROC
2052: 
2053:     *==========================================================================
2054:     * BtnProcessarClick - Transcreve o PROCEDURE Processa.Click do legado: a
2055:     * consulta/calculo ja esta implementada em
2056:     * SigPrAprBO.BuscarProdutos() - este metodo aciona o BO e reflete o
2057:     * resultado na tela (recarrega a grade, habilita Atualizar).
2058:     *
2059:     * this_cMensagemErro preenchido COM retorno .T. eh falha de VALIDACAO
2060:     * (MsgAviso, igual ao MessageBox de icone 48 do legado); retorno .F. eh
2061:     * falha TECNICA (MsgErro).
2062:     *==========================================================================
2063:     PROCEDURE BtnProcessarClick()
2064:         LOCAL loc_oBO, loc_lSucesso
2065: 
2066:         loc_oBO = THIS.this_oBusinessObject
2067:         IF VARTYPE(loc_oBO) != "O"
2068:             RETURN
2069:         ENDIF
2070: 
2071:         THIS.SincronizarFiltros()
2072:         loc_lSucesso = loc_oBO.BuscarProdutos()
2073: 
2074:         IF loc_lSucesso
2075:             IF !EMPTY(loc_oBO.this_cMensagemErro)
2076:                 MsgAviso(loc_oBO.this_cMensagemErro, "Campo Obrigat" + CHR(243) + "rio")
2077:             ELSE
2078:                 THIS.CarregarLista()
2079:                 IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2080:                     THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
2081:                 ENDIF
2082:                 IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
2083:                     THIS.grd_4c_Produtos.SetFocus()
2084:                 ENDIF
2085:             ENDIF
2086:         ELSE
2087:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel buscar os produtos." + CHR(13) + ;
2088:                 loc_oBO.this_cMensagemErro, "Erro em BtnProcessarClick")
2089:         ENDIF
2090:     ENDPROC
2091: 
2092:     *==========================================================================
2093:     * BtnAtualizarClick - Transcreve o PROCEDURE Atualiza.Click do legado. A
2094:     * parte de GRAVACAO (snapshot SigCdPrc + recalculo + UPDATE SigCdPro +
2095:     * historico SigPrCp2 + limpeza SigPrPrt/SigPrPmi + vinculo de promocao,
2096:     * tudo numa unica transacao) ja esta implementada em
2097:     * SigPrAprBO.Atualizar() desde a Fase 1/2 - este metodo so precisa
2098:     * acionar o contrato BusinessBase (EditarRegistro()+Salvar()) apos as
2099:     * mesmas duas confirmacoes do legado.
2100:     *
2101:     * BO.Salvar()/Atualizar() ja exibem a falha sozinhos (BusinessBase.
2102:     * ExibirFalha) em caso de erro - nenhum ELSE necessario aqui (regra #20).
2103:     *
2104:     * Legado: "This.Enabled = .F." roda INCONDICIONALMENTE ao final do Click
2105:     * (haja ou nao confirmado a atualizacao) - Atualizar so volta a ligar no
2106:     * proximo Processar bem sucedido.
2107:     *==========================================================================
2108:     PROCEDURE BtnAtualizarClick()
2109:         LOCAL loc_oBO, loc_cCursor, loc_lImprimirEtiquetas
2110: 
2111:         loc_oBO = THIS.this_oBusinessObject
2112:         IF VARTYPE(loc_oBO) = "O"
2113: 
2114:             IF MsgConfirma("Atualiza " + CHR(63) + CHR(63) + CHR(63), ;
2115:                     "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
2116: 
2117:                 loc_cCursor = loc_oBO.this_cCursorItens
2118:                 IF USED(loc_cCursor)
2119:                     SELECT (loc_cCursor)
2120:                     LOCATE FOR lMarca = 1
2121:                 ENDIF
2122: 
2123:                 IF !USED(loc_cCursor) OR !FOUND()
2124:                     MsgAviso("Nenhum Produto Selecionado" + CHR(33) + CHR(33) + CHR(33), ;
2125:                         "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2126:                     IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
2127:                         THIS.grd_4c_Produtos.SetFocus()
2128:                     ENDIF
2129:                 ELSE
2130:                     loc_lImprimirEtiquetas = MsgConfirma( ;
2131:                         "Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
2132:                     loc_oBO.this_lImprimirEtiquetas = loc_lImprimirEtiquetas
2133: 
2134:                     loc_oBO.EditarRegistro()
2135:                     IF loc_oBO.Salvar()
2136:                         MsgInfo("Processamento Finalizado com Sucesso" + CHR(33) + CHR(33) + CHR(33), "")
2137:                     ENDIF
2138:                 ENDIF
2139:             ENDIF
2140: 
2141:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2142:                 THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
2143:             ENDIF
2144:         ENDIF
2145:     ENDPROC
2146: 
2147:     *==========================================================================
2148:     * BtnEncerrarClick - Transcreve o PROCEDURE Cancela.Click do legado
2149:     * (ThisForm.Release).
2150:     *==========================================================================
2151:     PROCEDURE BtnEncerrarClick()
2152:         THIS.Release()
2153:     ENDPROC
2154: 
2155:     *==========================================================================
2156:     * TornarControlesVisiveis - Torna todos os controles visiveis
2157:     * recursivamente (AddObject cria com Visible=.F. por padrao). FILTRO:
2158:     * img_4c_FigJpg (SIGPRAPR.FigJpg) eh a UNICA excecao - legado declara
2159:     * Visible=.F. no SCX e so aparece quando GridAfterRowColChange encontra
2160:     * foto para o produto da linha corrente.
2161:     *==========================================================================
2162:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2163:         LOCAL loc_nI, loc_oControl
2164: 
2165:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2166:             loc_oControl = par_oContainer.Controls(loc_nI)
2167:             IF VARTYPE(loc_oControl) = "O"
2168:                 IF UPPER(loc_oControl.Name) == "IMG_4C_FIGJPG"
2169:                     LOOP
2170:                 ENDIF
2171:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2172:                     loc_oControl.Visible = .T.
2173:                 ENDIF
2174:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2175:                     THIS.TornarControlesVisiveis(loc_oControl)
2176:                 ENDIF
2177:             ENDIF
2178:         ENDFOR
2179:     ENDPROC
2180: 
2181: ENDDEFINE

