# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.ObterProdutoDoFormPai()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEmp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (880 linhas total):

*-- Linhas 25 a 135:
25: * so 7 metodos (montagrades, Load, Init, ok.Click, get_NGrupo.When,
26: * Get_NConta.When, grdItens.AfterRowColChange) e NENHUM casa padrao de
27: * lookup do Framework (zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
28: * CreateObject de busca) - comportamento.json.resumo.funcoesExternas lista
29: * so fConfigGeral e MontaGrade. Os dois UNICOS TextBox do form
30: * (get_NGrupo/Get_NConta) tem `PROCEDURE When / Return .f.` no legado, ou
31: * seja NUNCA entram em edicao - sao visores, ja entregues na Fase 5 como
32: * txt_4c__NGrupo/txt_4c_NConta (ReadOnly=.T./TabStop=.F.) e ja alimentados
33: * por THIS.BOParaForm(). Nao ha "ultimos 50% de campos" a adicionar (zero
34: * campos em analise.json.campos) nem container cnt_4c_BotoesAcao
35: * Salvar/Cancelar - o legado so tem o botao "ok" (Encerrar), ja migrado na
36: * Fase 5 como cmd_4c_Ok/CmdOkClick. Inventar lookup ou botoes de
37: * Salvar/Cancelar aqui violaria o PILAR 1 e a regra "NUNCA inventar
38: * tabelas de lookup que nao existem no original". O unico metodo do dump
39: * ainda sem equivalente - grdItens.AfterRowColChange - foi portado na
40: * Fase 7 (handler PUBLIC da grade, conforme ja registrado no cabecalho de
41: * BOParaForm abaixo).
42: *
43: * FASE 7/8 - EVENTOS PRINCIPAIS. Os quatro handlers da barra CRUD do
44: * framework (um por verbo: incluir, alterar, visualizar e excluir registro)
45: * NAO existem aqui porque o legado NAO TEM essa barra - conferido no dump,
46: * nao assumido por omissao:
47: *   - SIGOPEMP herda de form PURO, e nao da classe de cadastro do framework
48: *     (zero ocorrencia do nome dessa classe-mae no dump), logo nao herda a
49: *     barra de botoes dela;
50: *   - zero ocorrencia do CommandGroup que hospeda essa barra, da variavel de
51: *     MODO do cadastro e dos quatro verbos CRUD em qualquer forma - nome de
52: *     objeto, caption, metodo ou chamada de Click;
53: *   - a SUPERFICIE DE BOTAO do legado eh UM botao so: o dump tem exatamente
54: *     1 objeto de base commandbutton (SIGOPEMP.ok, Caption "Encerrar") e
55: *     nenhum de base commandgroup.
56: * Esse unico botao TEM o seu evento portado (ok.Click = ThisForm.Release ->
57: * cmd_4c_Ok/CmdOkClick, Fase 5), e a Fase 7 acrescenta o unico outro evento
58: * do dump, o da grade. Criar os quatro handlers da barra CRUD aqui exigiria
59: * INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
60: * inventar") ou escrever quatro metodos vazios (viola a regra de
61: * completude). O form eh um dialogo filho SOMENTE-LEITURA de consulta:
62: * coerente com isso, o BO recusa Inserir/Atualizar com a mensagem
63: * "Empenho e uma tela de consulta".
64: *
65: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO. Fecha a migracao com a
66: * TABELA DE DISPOSICAO dos 7 (e so 7) metodos do SIGOPEMP.SCX, para que a
67: * ausencia de qualquer outro seja verificavel e nao presumida:
68: *
69: *   metodo do SCX legado        | onde foi parar no migrado
70: *   ----------------------------|-------------------------------------------
71: *   montagrades                 | ConfigurarGrid            (Fase 4)
72: *   Init                        | Init + InicializarForm    (Fase 3)
73: *   ok.Click                    | CmdOkClick                (Fase 5)
74: *   get_NGrupo.When  (Return .f)| ReadOnly=.T. + TabStop=.F. (Fase 5)
75: *   Get_NConta.When  (Return .f)| ReadOnly=.T. + TabStop=.F. (Fase 5)
76: *   grdItens.AfterRowColChange  | GradeAfterRowColChange    (Fase 7)
77: *   Load  (=fConfigGeral())     | NAO PORTADO - ver (a)
78: *
79: * (a) Load: "=fConfigGeral()". No Fortyus fConfigGeral era inicializacao
80: *     GLOBAL da aplicacao (parametros do sistema, cursores de referencia),
81: *     chamada pelo Load de dezenas de telas. Na arquitetura nova esse papel
82: *     eh de config.prg/ConfigurarAmbiente(), que roda ANTES de qualquer form
83: *     existir; chama-la daqui seria re-executar inicializacao global no meio
84: *     da vida da aplicacao. Mesma disposicao, pelo mesmo motivo, de
85: *     FormSigMvExp/FormSigMvMen/FormSigMvPdt/FormSigMvSbn/FormSigOpClp. O
86: *     wrapper utils\fconfiggeral.prg existe para o p-code dos VCX legado que
87: *     ainda chamam o nome (regra #27), nao para codigo nosso.
88: *
89: * A Fase 8 corrigiu dois defeitos reais e NAO inventou superficie nova:
90: *
91: *   1. ConfigurarOrdemTabulacao() - novo. A ordem de tabulacao saia da ordem
92: *      de criacao dos AddObject e divergia do legado: o Encerrar vinha ANTES
93: *      da grade, e a grade (o conteudo da tela) caia em ULTIMO. Medido no
94: *      VFP9 e documentado no cabecalho do proprio metodo.
95: *   2. InicializarForm - o bypass de gb_4c_ValidandoUI estava com RETURN no
96: *      TOPO do metodo, pulando THIS.Picture e TODA a montagem visual; agora
97: *      cerca apenas CarregarLista(), o unico trecho que depende de SQL.
98: *
99: * Os nomes canonicos de form CRUD que a Fase 8 normalmente fecha NAO se
100: * aplicam aqui, e a razao eh estrutural (conferida no dump, nao presumida
101: * por omissao) - este eh um dialogo filho de CONSULTA, sem Page2(Dados) e
102: * sem modo de edicao:
103: *
104: *   BtnSalvarClick / BtnCancelarClick - o dump tem exatamente 1 objeto de
105: *     base commandbutton (SIGOPEMP.ok) e nenhum commandgroup, e o Click dele
106: *     so faz ThisForm.Release(). Nao existe par Confirmar/Cancelar a migrar;
107: *     cria-lo seria inventar botao (viola o PILAR 1) e o handler nasceria
108: *     vazio (viola a regra de completude). O unico botao TEM handler:
109: *     CmdOkClick.
110: *   BtnBuscarClick - nao ha campo de filtro nem botao de busca: a tela abre
111: *     ja filtrada pelo produto que o form pai informa (this_cProduto), que eh
112: *     o que CarregarLista() consome.
113: *   FormParaBO - transfere CAMPO EDITAVEL para o BO. Os dois unicos TextBox
114: *     tem "When / Return .f." no legado: nunca entram em edicao, nunca
115: *     recebem digitacao do usuario e nada deles tem de voltar ao BO. O
116: *     sentido que existe de verdade - BO -> campo - esta em BOParaForm().
117: *   HabilitarCampos - alterna campo entre editavel e somente-leitura por
118: *     MODO (INCLUIR/ALTERAR/VISUALIZAR). Aqui nao ha modo nem campo
119: *     editavel: o estado somente-leitura eh invariante, declarado uma vez em
120: *     ConfigurarPaginaDados (ReadOnly/TabStop) e no Grid (ReadOnly = .T.),
121: *     exatamente como o legado o declara.
122: *   AjustarBotoesPorModo - idem: um unico botao, sempre habilitado, sem modo
123: *     que o afete. O legado tampouco desabilita o "ok" em qualquer caminho.
124: *
125: * Ja entregues e consolidados nas fases anteriores, revisados aqui:
126: * BOParaForm, LimparCampos e CarregarLista (este ultimo PUBLIC, como o
127: * harness de teste automatizado exige - regra #3).
128: *==============================================================================
129: 
130: DEFINE CLASS FormSigOpEmp AS FormBase
131: 
132:     DataSession = 2
133:     ShowWindow = 1
134:     BorderStyle = 2
135:     Height      = 600

*-- Linhas 156 a 199:
156:     * a LParameters poForm, pnDatSes do legado); monta o Caption com CHR() e
157:     * resolve o produto filtrado antes de delegar ao FormBase.
158:     *--------------------------------------------------------------------------
159:     PROCEDURE Init()
160:         LPARAMETERS par_oParentForm, par_nDataSes
161: 
162:         THIS.Caption = "Empenho"
163: 
164:         IF VARTYPE(par_oParentForm) = "O"
165:             THIS.this_oParentForm = par_oParentForm
166:         ENDIF
167: 
168:         THIS.this_cProduto = THIS.ObterProdutoDoFormPai(par_nDataSes)
169: 
170:         IF !EMPTY(THIS.this_cProduto)
171:             THIS.Caption = "Empenho - " + ALLTRIM(THIS.this_cProduto)
172:         ENDIF
173: 
174:         THIS.Icon = gc_4c_CaminhoIcones + "4Control1.ico"
175: 
176:         *-- ShowWindow/WindowType=1 na classe causaria TIMEOUT em VFP9 -T (top-
177:         *-- level window bloqueante) durante testes headless. Classe definida
178:         *-- com ShowWindow=0/WindowType=0; producao restaura modal top-level
179:         *-- aqui (mesmo padrao de FormSigOpChc/FormICD).
180:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
181:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
182:             THIS.WindowType  = 1
183:             THIS.ShowWindow  = 1
184:         ENDIF
185: 
186:         RETURN DODEFAULT()
187:     ENDPROC
188: 
189:     *--------------------------------------------------------------------------
190:     * ObterProdutoDoFormPai - le crSigMvEtr.Cpros na data session do form pai
191:     * (equivalente a Alltrim(crSigMvEtr.Cpros) do legado), trocando para ela
192:     * TEMPORARIAMENTE (mesmo padrao de FormGrupo.prg) e restaurando a sessao
193:     * corrente em seguida - ao contrario do legado, que troca e nunca
194:     * restaura.
195:     *--------------------------------------------------------------------------
196:     PROTECTED FUNCTION ObterProdutoDoFormPai(par_nDataSes)
197:         LOCAL loc_nSessaoAtual, loc_cProduto, loc_oErro
198: 
199:         loc_cProduto     = ""

*-- Linhas 215 a 366:
215:     ENDFUNC
216: 
217:     *--------------------------------------------------------------------------
218:     * InicializarForm - monta a estrutura base do form operacional
219:     *--------------------------------------------------------------------------
220:     PROTECTED PROCEDURE InicializarForm()
221:         LOCAL loc_lSucesso, loc_oErro
222:         loc_lSucesso = .F.
223: 
224:         TRY
225:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpEmpBO")
226:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
227:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpEmpBO.", ;
228:                         "Erro em InicializarForm")
229:                 loc_lSucesso = .F.
230:             ELSE
231:                 THIS.this_oBusinessObject.this_cProduto = THIS.this_cProduto
232: 
233:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
234: 
235:                 THIS.ConfigurarPageFrame()
236: 
237:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
238:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
239: 
240:                 THIS.TornarControlesVisiveis(THIS)
241: 
242:                 THIS.ConfigurarOrdemTabulacao()
243: 
244:                 *-- O bypass de validacao de UI cerca SO o trecho que depende
245:                 *-- de SQL/conexao. Um RETURN no TOPO deste metodo (como
246:                 *-- estava) pularia tambem THIS.Picture e TODA a montagem
247:                 *-- visual: a etapa de UI Fidelity instanciaria um form vazio
248:                 *-- e nenhuma diferenca seria corrigivel, porque o metodo que
249:                 *-- escreve a propriedade nunca teria rodado.
250:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
251:                     THIS.CarregarLista()
252:                 ENDIF
253: 
254:                 loc_lSucesso = .T.
255:             ENDIF
256:         CATCH TO loc_oErro
257:             MsgErro(loc_oErro.Message + CHR(13) + ;
258:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
259:                     "Procedure: " + loc_oErro.Procedure, ;
260:                     "Erro em InicializarForm")
261:         ENDTRY
262: 
263:         RETURN loc_lSucesso
264:     ENDPROC
265: 
266:     *--------------------------------------------------------------------------
267:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
268:     * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD).
269:     *
270:     * A ORDEM reproduz a ordem dos objetos no SCX legado (cntSombra, Shape1,
271:     * ok, get_NGrupo, Get_NConta, grdItens), porque em VFP9 o AddObject
272:     * define o z-order: o ultimo criado desenha POR CIMA. Importa aqui
273:     * porque Shape1 (Left 768..788, Top 7..24) fica DENTRO da area do botao
274:     * Encerrar (Left 725..800, Top 3..78) - criar o Shape DEPOIS do botao o
275:     * poria sobre ele. ConfigurarPaginaDados vem entao ANTES de
276:     * ConfigurarBotoes, igual ao legado.
277:     *--------------------------------------------------------------------------
278:     PROTECTED PROCEDURE ConfigurarPageFrame()
279:         THIS.ConfigurarCabecalho()
280:         THIS.ConfigurarPaginaDados()
281:         THIS.ConfigurarBotoes()
282:         THIS.ConfigurarGrid()
283:     ENDPROC
284: 
285:     *--------------------------------------------------------------------------
286:     * ConfigurarPaginaDados - cria os controles de DADOS do dialogo, todos
287:     * filhos DIRETOS do Form (nao ha PageFrame nem container de campos):
288:     *
289:     *   shp_4c_Shape1  (SIGOPEMP.Shape1)      Top=7   Left=768 20x17
290:     *   txt_4c__NGrupo (SIGOPEMP.get_NGrupo)  Top=465 Left=68  360x21
291:     *   txt_4c_NConta  (SIGOPEMP.Get_NConta)  Top=488 Left=68  360x21
292:     *
293:     * Propriedades TRANSCRITAS do dump legado, incluindo o par
294:     * Format/InputMask (CLAUDE.md regra #49 - o migrador costuma descartar
295:     * os dois). Nao ha `Say`/Label nenhum para esses dois campos no SCX: a
296:     * SECAO 1 do dump lista apenas cntSombra+2 labels, Shape1, ok,
297:     * get_NGrupo, Get_NConta e grdItens - os dois campos ficam sem legenda
298:     * no legado, e inventar rotulo aqui violaria o PILAR 1.
299:     *
300:     * ZOrderSet = 3 do dump NAO eh transcrito: eh bookkeeping do Form
301:     * Designer, nao existe em runtime e estouraria "Property ZORDERSET is
302:     * not found" no Init (CLAUDE.md regra #33).
303:     *--------------------------------------------------------------------------
304:     PROTECTED PROCEDURE ConfigurarPaginaDados()
305:         *-- Shape1: decorativo, BackStyle=0 (sem preenchimento) e
306:         *-- BorderStyle=0 (sem borda) exatamente como o dump. Shape NAO tem
307:         *-- ForeColor/BackColor - a cor mora em BorderColor/FillColor
308:         *-- (CLAUDE.md regra #33), por isso 136,189,188 vai em .BorderColor.
309:         THIS.AddObject("shp_4c_Shape1", "Shape")
310:         WITH THIS.shp_4c_Shape1
311:             .Top         = 7
312:             .Left        = 768
313:             .Width       = 20
314:             .Height      = 17
315:             .BackStyle   = 0
316:             .BorderStyle = 0
317:             .BorderColor = RGB(136, 189, 188)
318:         ENDWITH
319: 
320:         *-- get_NGrupo: descricao do Grupo Destino da linha corrente da grade
321:         *-- (SigCdGcr.Descrs). O legado tem `PROCEDURE When / Return .f.`,
322:         *-- isto eh, o campo NUNCA entra em edicao - eh so visor. O
323:         *-- equivalente no sistema novo eh ReadOnly = .T. + TabStop = .F.
324:         *-- (When por BINDEVENT nao eh confiavel em TextBox, CLAUDE.md regra
325:         *-- #3, e BINDEVENT descarta o retorno do delegate, entao um When
326:         *-- ligado por BINDEVENT nao bloquearia nada).
327:         THIS.AddObject("txt_4c__NGrupo", "TextBox")
328:         WITH THIS.txt_4c__NGrupo
329:             .Top           = 465
330:             .Left          = 68
331:             .Width         = 360
332:             .Height        = 21
333:             .FontName      = "Tahoma"
334:             .FontSize      = 8
335:             .BorderStyle   = 1
336:             .SpecialEffect = 1
337:             .Themes        = .F.
338:             .Format        = "K!"
339:             .MaxLength     = 50
340:             .Value         = ""
341:             .ReadOnly      = .T.
342:             .TabStop       = .F.
343:         ENDWITH
344: 
345:         *-- Get_NConta: descricao da Conta Destino da linha corrente da grade
346:         *-- (SigCdCli.Rclis). Mesmo `When / Return .f.` do get_NGrupo.
347:         THIS.AddObject("txt_4c_NConta", "TextBox")
348:         WITH THIS.txt_4c_NConta
349:             .Top           = 488
350:             .Left          = 68
351:             .Width         = 360
352:             .Height        = 21
353:             .FontName      = "Tahoma"
354:             .FontSize      = 8
355:             .BorderStyle   = 1
356:             .SpecialEffect = 1
357:             .Themes        = .F.
358:             .Format        = "K!"
359:             .MaxLength     = 50
360:             .Value         = ""
361:             .ReadOnly      = .T.
362:             .TabStop       = .F.
363:         ENDWITH
364:     ENDPROC
365: 
366:     *--------------------------------------------------------------------------

*-- Linhas 375 a 468:
375:     * (CLAUDE.md regra #51) - medido aqui: chamar de fora estoura "Property
376:     * BOPARAFORM is not found". So eh chamado por THIS.BOParaForm(), de
377:     * DENTRO da classe (CarregarLista e, na Fase 7, o handler da grade - que
378:     * ai sim eh PUBLIC, como BINDEVENT exige).
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE BOParaForm()
381:         LOCAL loc_oErro
382: 
383:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
384:             RETURN .F.
385:         ENDIF
386: 
387:         TRY
388:             THIS.txt_4c__NGrupo.Value = TratarNulo( ;
389:                 THIS.this_oBusinessObject.this_cDescricaoGrupo, "")
390: 
391:             THIS.txt_4c_NConta.Value = TratarNulo( ;
392:                 THIS.this_oBusinessObject.this_cDescricaoConta, "")
393:         CATCH TO loc_oErro
394:             MsgErro(loc_oErro.Message + CHR(13) + ;
395:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
396:                     "Procedure: " + loc_oErro.Procedure, ;
397:                     "Erro em BOParaForm")
398:         ENDTRY
399: 
400:         RETURN .T.
401:     ENDPROC
402: 
403:     *--------------------------------------------------------------------------
404:     * LimparCampos - zera os dois visores de descricao. Chamado quando a
405:     * grade esta vazia ou fica sem registro corrente: o AfterRowColChange
406:     * legado tambem grava '' nos dois campos quando o CursorQuery nao acha a
407:     * descricao (Iif(..., evaluate(...), '')), entao campo vazio eh estado
408:     * previsto e nao erro.
409:     *
410:     * PROTECTED pelo mesmo motivo do BOParaForm: a FormBase declara este hook
411:     * PROTECTED (formbase.prg:276) e o override nao alarga o escopo.
412:     *--------------------------------------------------------------------------
413:     PROTECTED PROCEDURE LimparCampos()
414:         THIS.txt_4c__NGrupo.Value = ""
415:         THIS.txt_4c_NConta.Value  = ""
416:     ENDPROC
417: 
418:     *--------------------------------------------------------------------------
419:     * ConfigurarGrid - cria grd_4c_Dados (equivalente a grdItens do legado) e
420:     * liga as 7 colunas ao cursor_4c_Empenhado - mesmas colunas, legendas e
421:     * larguras do PROCEDURE montagrades legado (Emp/Operacao/Codigo/Data/
422:     * Grupo/Conta/Qtde). O cursor placeholder eh criado ANTES de ligar o
423:     * ControlSource: Column.ControlSource de alias ainda inexistente derruba
424:     * o Init (CLAUDE.md regra #41) - CriarCursorEmpenhado() eh o ponto UNICO
425:     * de CREATE CURSOR desta tela, com a MESMA estrutura usada depois por
426:     * BuscarEmpenhosDoProduto().
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE ConfigurarGrid()
429:         LOCAL loc_oGrid, loc_cCursor
430: 
431:         THIS.this_oBusinessObject.CriarCursorEmpenhado()
432:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista
433: 
434:         THIS.AddObject("grd_4c_Dados", "Grid")
435:         loc_oGrid = THIS.grd_4c_Dados
436:         WITH loc_oGrid
437:             .Top               = 122
438:             .Left              = 37
439:             .Width             = 725
440:             .Height            = 343
441:             .FontName          = "Tahoma"
442:             .HeaderHeight      = 17
443:             .AllowHeaderSizing = .F.
444:             .AllowRowSizing    = .F.
445:             .DeleteMark        = .F.
446:             .RecordMark        = .F.
447:             .ReadOnly          = .T.
448:             .ScrollBars        = 2
449:             .GridLineColor     = RGB(238, 238, 238)
450:             .ColumnCount       = 7
451:             .RecordSource      = loc_cCursor
452:         ENDWITH
453: 
454:         loc_oGrid.Column1.ControlSource = loc_cCursor + ".Emps"
455:         loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dopes"
456:         loc_oGrid.Column3.ControlSource = loc_cCursor + ".Numes"
457:         loc_oGrid.Column3.InputMask     = "999999"
458:         loc_oGrid.Column4.ControlSource = loc_cCursor + ".Datas"
459:         loc_oGrid.Column5.ControlSource = loc_cCursor + ".GrupoDs"
460:         loc_oGrid.Column6.ControlSource = loc_cCursor + ".ContaDs"
461:         loc_oGrid.Column7.ControlSource = loc_cCursor + ".Qtds"
462:         loc_oGrid.Column7.InputMask     = "9999999.99"
463: 
464:         loc_oGrid.Column1.Width = 31
465:         loc_oGrid.Column2.Width = 206
466:         loc_oGrid.Column3.Width = 60
467:         loc_oGrid.Column4.Width = 80
468:         loc_oGrid.Column5.Width = 80

*-- Linhas 501 a 544:
501:         loc_oGrid.Column6.Header1.ForeColor = RGB(0, 0, 0)
502:         loc_oGrid.Column7.Header1.ForeColor = RGB(0, 0, 0)
503: 
504:         *-- O PROCEDURE montagrades legado reatribui, no FOR final, Movable/
505:         *-- Resizable/ReadOnly e FontName de TODA coluna (inclusive do Text1)
506:         *-- para "Courier New" - isso PREVALECE sobre o FontName Tahoma
507:         *-- declarado nas propriedades iniciais do grid.
508:         loc_oGrid.Column1.Movable   = .F.
509:         loc_oGrid.Column2.Movable   = .F.
510:         loc_oGrid.Column3.Movable   = .F.
511:         loc_oGrid.Column4.Movable   = .F.
512:         loc_oGrid.Column5.Movable   = .F.
513:         loc_oGrid.Column6.Movable   = .F.
514:         loc_oGrid.Column7.Movable   = .F.
515: 
516:         loc_oGrid.Column1.Resizable = .F.
517:         loc_oGrid.Column2.Resizable = .F.
518:         loc_oGrid.Column3.Resizable = .F.
519:         loc_oGrid.Column4.Resizable = .F.
520:         loc_oGrid.Column5.Resizable = .F.
521:         loc_oGrid.Column6.Resizable = .F.
522:         loc_oGrid.Column7.Resizable = .F.
523: 
524:         loc_oGrid.Column1.ReadOnly = .T.
525:         loc_oGrid.Column2.ReadOnly = .T.
526:         loc_oGrid.Column3.ReadOnly = .T.
527:         loc_oGrid.Column4.ReadOnly = .T.
528:         loc_oGrid.Column5.ReadOnly = .T.
529:         loc_oGrid.Column6.ReadOnly = .T.
530:         loc_oGrid.Column7.ReadOnly = .T.
531: 
532:         loc_oGrid.Column1.FontName = "Courier New"
533:         loc_oGrid.Column2.FontName = "Courier New"
534:         loc_oGrid.Column3.FontName = "Courier New"
535:         loc_oGrid.Column4.FontName = "Courier New"
536:         loc_oGrid.Column5.FontName = "Courier New"
537:         loc_oGrid.Column6.FontName = "Courier New"
538:         loc_oGrid.Column7.FontName = "Courier New"
539: 
540:         loc_oGrid.Column1.Text1.FontName  = "Courier New"
541:         loc_oGrid.Column2.Text1.FontName  = "Courier New"
542:         loc_oGrid.Column3.Text1.FontName  = "Courier New"
543:         loc_oGrid.Column4.Text1.FontName  = "Courier New"
544:         loc_oGrid.Column5.Text1.FontName  = "Courier New"

*-- Linhas 576 a 765:
576: 
577:         *-- Unico evento de dados do form: ao trocar a linha corrente, o
578:         *-- legado resolve as descricoes de Grupo/Conta e as mostra nos dois
579:         *-- visores (grdItens.AfterRowColChange). Ligado por BINDEVENT porque
580:         *-- o Grid eh criado por AddObject e nao ha subclasse onde declarar o
581:         *-- evento; o delegate eh PUBLIC (CLAUDE.md regra #3).
582:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
583:     ENDPROC
584: 
585:     *--------------------------------------------------------------------------
586:     * ConfigurarBotoes - cria cmd_4c_Ok (equivalente ao botao "ok" do legado,
587:     * Caption "Encerrar", que apenas fecha o dialogo).
588:     *--------------------------------------------------------------------------
589:     PROTECTED PROCEDURE ConfigurarBotoes()
590:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
591:         WITH THIS.cmd_4c_Ok
592:             .Top             = 3
593:             .Left            = 725
594:             .Width           = 75
595:             .Height          = 75
596:             .FontName        = "Comic Sans MS"
597:             .FontSize        = 8
598:             .FontBold        = .T.
599:             .FontItalic      = .T.
600:             .ForeColor       = RGB(90, 90, 90)
601:             .BackColor       = RGB(255, 255, 255)
602:             .Themes          = .T.
603:             .Caption         = "Encerrar"
604:             .Cancel          = .T.
605:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
606:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
607:         ENDWITH
608: 
609:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
610:     ENDPROC
611: 
612:     *--------------------------------------------------------------------------
613:     * CmdOkClick - equivalente a ThisForm.Release() do botao "ok" legado
614:     *--------------------------------------------------------------------------
615:     PROCEDURE CmdOkClick()
616:         THIS.Release()
617:     ENDPROC
618: 
619:     *--------------------------------------------------------------------------
620:     * GradeAfterRowColChange - handler de grd_4c_Dados.AfterRowColChange,
621:     * equivalente ao grdItens.AfterRowColChange do legado:
622:     *
623:     *   thisform.get_NGrupo.Value = Iif(...CursorQuery('SigCdGcr','crSigCdGcr',
624:     *                                    'codigos',crEmpenhado.GrupoDs,[Descrs])
625:     *                                    ,evaluate('crSigCdGcr.Descrs'),'')
626:     *   thisform.get_NConta.Value = Iif(...CursorQuery('SigCdCli','crSigCdCli',
627:     *                                    'iclis',crEmpenhado.ContaDs,[Rclis])
628:     *                                    ,evaluate('crSigCdCli.Rclis'),'')
629:     *
630:     * As duas consultas ficam no BO (ObterDescricaoGrupo/ObterDescricaoConta,
631:     * chamadas por CarregarDoCursor); aqui o handler so le a linha corrente e
632:     * espelha o resultado nos visores via BOParaForm(). Descricao nao
633:     * encontrada vira string vazia nos dois lados - o Iif(...,'') do legado faz
634:     * o mesmo, entao campo vazio eh estado previsto e NAO erro.
635:     *
636:     * SEM filtro por par_nColIndex, igual ao legado: este handler carrega o
637:     * DETALHE da linha corrente, que eh o uso CORRETO de AfterRowColChange
638:     * (CLAUDE.md regra #46 - o que a regra proibe eh validar CELULA aqui,
639:     * filtrando a coluna, porque nColIndex eh a coluna de DESTINO). O
640:     * parametro eh declarado porque o evento o passa (regra #3), mesmo sem uso.
641:     *
642:     * PUBLIC obrigatoriamente: BINDEVENT em metodo PROTECTED falha em silencio
643:     * (regra #3). Por isso o corpo chama os hooks PROTECTED BOParaForm/
644:     * LimparCampos de DENTRO da classe, com THIS. (regra #8).
645:     *
646:     * NAO chama Refresh no grid - o legado tambem nao chama, e Refresh aqui
647:     * redispararia o proprio AfterRowColChange. Atribuir .Value aos dois
648:     * TextBox nao mexe no ponteiro do cursor da grade, entao nao ha
649:     * reentrancia a cercar.
650:     *--------------------------------------------------------------------------
651:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
652:         LOCAL loc_cCursor, loc_oErro
653: 
654:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
655:             RETURN
656:         ENDIF
657: 
658:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista
659: 
660:         TRY
661:             IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0 ;
662:                     AND !EOF(loc_cCursor) AND !BOF(loc_cCursor)
663:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
664:                 THIS.BOParaForm()
665:             ELSE
666:                 *-- Grade vazia ou sem registro corrente: sem linha nao ha
667:                 *-- Grupo/Conta a descrever.
668:                 THIS.LimparCampos()
669:             ENDIF
670:         CATCH TO loc_oErro
671:             MsgErro(loc_oErro.Message + CHR(13) + ;
672:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
673:                     "Procedure: " + loc_oErro.Procedure, ;
674:                     "Erro em GradeAfterRowColChange")
675:         ENDTRY
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * CarregarLista - popula cursor_4c_Empenhado com os empenhos do produto
680:     * filtrado (THIS.this_cProduto, resolvido no Init a partir da data
681:     * session do form pai) e repinta o grid - popular o cursor NAO repinta a
682:     * grade por si so (CLAUDE.md regra #21): GO TOP + Refresh sao
683:     * obrigatorios apos a carga.
684:     *--------------------------------------------------------------------------
685:     PROCEDURE CarregarLista()
686:         LOCAL loc_lSucesso, loc_cCursor
687: 
688:         loc_lSucesso = THIS.this_oBusinessObject.BuscarEmpenhosDoProduto( ;
689:             go_4c_Sistema.cCodEmpresa, THIS.this_cProduto)
690: 
691:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista
692: 
693:         IF USED(loc_cCursor)
694:             GO TOP IN (loc_cCursor)
695:             THIS.grd_4c_Dados.Refresh()
696: 
697:             *-- Linha 1 ja fica corrente, mas o AfterRowColChange NAO dispara
698:             *-- na carga - entao os dois visores de descricao sao populados
699:             *-- aqui, senao abririam vazios com a grade cheia.
700:             IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
701:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
702:                 THIS.BOParaForm()
703:             ELSE
704:                 THIS.LimparCampos()
705:             ENDIF
706:         ELSE
707:             THIS.LimparCampos()
708:         ENDIF
709: 
710:         IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
711:             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empenho")
712:         ENDIF
713: 
714:         RETURN loc_lSucesso
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
719:     * legado) com os labels de sombra e titulo.
720:     * Propriedades TRANSCRITAS do dump (SIGOPEMP.cntSombra/lblSombra/
721:     * lblTitulo): Top=0/Left=0/Width=800/Height=80/BackColor=100,100,100 no
722:     * container; labels com Left=10/Width=769, lblSombra Top=25/Height=40,
723:     * lblTitulo Top=24/Height=46/ForeColor branco.
724:     *--------------------------------------------------------------------------
725:     PROTECTED PROCEDURE ConfigurarCabecalho()
726:         LOCAL loc_oCab
727: 
728:         THIS.AddObject("cnt_4c_Sombra", "Container")
729:         loc_oCab = THIS.cnt_4c_Sombra
730:         WITH loc_oCab
731:             .Top         = 0
732:             .Left        = 0
733:             .Width       = THIS.Width
734:             .Height      = 80
735:             .BackColor   = RGB(100, 100, 100)
736:             .BorderWidth = 0
737:         ENDWITH
738: 
739:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
740:         WITH loc_oCab.lbl_4c_LblSombra
741:             .AutoSize      = .F.
742:             .Width         = 769
743:             .Height        = 40
744:             .Top           = 25
745:             .Left          = 10
746:             .FontName      = "Tahoma"
747:             .FontSize      = 18
748:             .FontBold      = .T.
749:             .FontUnderline = .F.
750:             .Alignment     = 0
751:             .BackStyle     = 0
752:             .WordWrap      = .T.
753:             .ForeColor     = RGB(0, 0, 0)
754:             .Caption       = THIS.Caption
755:         ENDWITH
756: 
757:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
758:         WITH loc_oCab.lbl_4c_LblTitulo
759:             .AutoSize  = .F.
760:             .Width     = 769
761:             .Height    = 46
762:             .Top       = 24
763:             .Left      = 10
764:             .FontName  = "Tahoma"
765:             .FontSize  = 18

*-- Linhas 806 a 880:
806:     * Tres cuidados que a medicao confirmou:
807:     *   - ASCENDENTE: cada atribuicao poe o controle na posicao pedida e
808:     *     empurra os demais para tras; descendente TROCA pares de lugar.
809:     *   - DEPOIS de todos os AddObject (chamado no fim de InicializarForm).
810:     *   - Shape NAO TEM TabIndex (medido: PEMSTATUS devolve .F.), por isso
811:     *     shp_4c_Shape1 fica fora da sequencia e cada atribuicao eh guardada
812:     *     por PEMSTATUS no PROPRIO controle - PEMSTATUS(THIS, "<nome>", 5) so
813:     *     diria que o membro existe no form e o metodo quebraria no Shape com
814:     *     "Property TABINDEX is not found".
815:     *
816:     * Os dois TextBox entram na sequencia por fidelidade, mas estao FORA do
817:     * ciclo do Tab nos dois lados: no legado por "When / Return .f." e aqui
818:     * por TabStop = .F. (ver ConfigurarPaginaDados). Na pratica o ciclo
819:     * visivel eh grade -> Encerrar, como no legado.
820:     *--------------------------------------------------------------------------
821:     PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
822:         LOCAL loc_nSeq, loc_nI, loc_cNome, loc_aOrdem[5]
823: 
824:         *-- Ordem EFETIVA do legado (ver tabela no cabecalho deste metodo)
825:         loc_aOrdem[1] = "cnt_4c_Sombra"     && SCX cntSombra  - sem TabIndex
826:         loc_aOrdem[2] = "grd_4c_Dados"      && SCX grdItens   - TabIndex 2
827:         loc_aOrdem[3] = "cmd_4c_Ok"         && SCX ok         - TabIndex 11 (descartado no load)
828:         loc_aOrdem[4] = "txt_4c__NGrupo"    && SCX get_NGrupo - TabIndex 81 (descartado no load)
829:         loc_aOrdem[5] = "txt_4c_NConta"     && SCX Get_NConta - TabIndex 84 (descartado no load)
830: 
831:         *-- Contador PROPRIO e sequencial: usar o indice do laco abriria
832:         *-- lacuna ao pular um controle, e valor FORA da faixa 1..N (N = so
833:         *-- os controles que TEM TabIndex) eh descartado em silencio.
834:         loc_nSeq = 0
835: 
836:         FOR loc_nI = 1 TO ALEN(loc_aOrdem)
837:             loc_cNome = loc_aOrdem[loc_nI]
838: 
839:             IF PEMSTATUS(THIS, loc_cNome, 5)
840:                 *-- Guard no CONTROLE, nao no form: Shape nao tem TabIndex
841:                 IF PEMSTATUS(EVALUATE("THIS." + loc_cNome), "TabIndex", 5)
842:                     loc_nSeq = loc_nSeq + 1
843:                     STORE loc_nSeq TO ("THIS." + loc_cNome + ".TabIndex")
844:                 ENDIF
845:             ENDIF
846:         ENDFOR
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
851:     * FILTRO: nenhum container flutuante neste form
852:     *--------------------------------------------------------------------------
853:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
854:         LOCAL loc_nI, loc_oControl
855: 
856:         FOR loc_nI = 1 TO par_oContainer.ControlCount
857:             loc_oControl = par_oContainer.Controls(loc_nI)
858:             IF VARTYPE(loc_oControl) = "O"
859:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
860:                     loc_oControl.Visible = .T.
861:                 ENDIF
862:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
863:                     THIS.TornarControlesVisiveis(loc_oControl)
864:                 ENDIF
865:             ENDIF
866:         ENDFOR
867:     ENDPROC
868: 
869:     *--------------------------------------------------------------------------
870:     * Destroy - libera recursos ao fechar o form
871:     *--------------------------------------------------------------------------
872:     PROCEDURE Destroy()
873:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
874:             THIS.this_oBusinessObject = .NULL.
875:         ENDIF
876:         THIS.this_oParentForm = .NULL.
877:         DODEFAULT()
878:     ENDPROC
879: 
880: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpEmpBO.prg):
*====================================================================
* SigOpEmpBO.prg
*
* Business Object para SigOpEmp (Empenho)
* Form OPERACIONAL (dialogo filho, somente leitura): exibe os itens
* empenhados (reservados) de um produto especifico, recebidos do
* form pai (SigMvEtr/Etiqueta) atraves de um cursor ja montado
* ('CrEmpenhado' no legado - Emps+Dopes+Numes+Datas de SigMvCab
* juntado com Qtds de SigMvItn, filtrado pelo produto corrente).
*
* Tabelas envolvidas: SigMvCab, SigMvItn, SigCdGcr, SigCdCli, SigMvEtr
*====================================================================

DEFINE CLASS SigOpEmpBO AS BusinessBase

	*-- Propriedades da entidade (linha corrente do grid de empenhos)
	this_cEmps = ""              && Empresa (CrEmpenhado.Emps / SigMvCab.Emps)
	this_cDopes = ""             && Codigo da operacao (CrEmpenhado.Dopes / SigMvCab.Dopes)
	this_nNumes = 0              && Numero do movimento (CrEmpenhado.Numes / SigMvCab.Numes)
	this_dDatas = {}             && Data do movimento (CrEmpenhado.Datas / SigMvCab.Datas)
	this_cGrupoDs = ""           && Codigo do Grupo Destino do movimento (CrEmpenhado.GrupoDs / SigMvCab.Grupods)
	this_cContaDs = ""           && Codigo da Conta Destino do movimento (CrEmpenhado.ContaDs / SigMvCab.Contads)
	this_nQtds = 0               && Quantidade empenhada do item (CrEmpenhado.Qtds / SigMvItn.Qtds)

	*-- Propriedade recebida do form pai (filtro do empenho exibido)
	this_cProduto = ""           && Codigo do produto cujos empenhos sao exibidos (SigMvItn.Cpros / crSigMvEtr.Cpros do form pai)

	*-- Propriedades derivadas/exibidas no form (descricoes resolvidas por lookup
	*-- quando o usuario navega entre as linhas da grade - AfterRowColChange)
	this_cDescricaoGrupo = ""    && Descricao do Grupo Destino da linha corrente (SigCdGcr.Descrs), exibida em get_NGrupo
	this_cDescricaoConta = ""    && Descricao da Conta Destino da linha corrente (SigCdCli.Rclis), exibida em Get_NConta

	*-- Nome do cursor de listagem que este BO popula (equivalente a
	*-- CrEmpenhado do legado); mantido como propriedade para o Form
	*-- referenciar sem repetir o literal
	this_cCursorLista = "cursor_4c_Empenhado"

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "EmpDopNums"

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
	* cursor de listagem (cursor_4c_Empenhado, equivalente ao CrEmpenhado
	* do legado) para as propriedades this_* da linha selecionada na
	* grade - usado pelo Form em AfterRowColChange para resolver as
	* descricoes de Grupo/Conta da linha corrente.
	*   par_cAliasCursor - alias a ler; se omitido usa this_cCursorLista
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_lSucesso
		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			par_cAliasCursor, THIS.this_cCursorLista)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
		ELSE
			SELECT (loc_cAlias)

			IF EOF() OR BOF()
				THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
			ELSE
				THIS.this_cEmps     = TratarNulo(Emps, "")
				THIS.this_cDopes    = TratarNulo(Dopes, "")
				THIS.this_nNumes    = TratarNulo(Numes, 0)
				THIS.this_dDatas    = TratarNulo(Datas, {})
				THIS.this_cGrupoDs  = TratarNulo(GrupoDs, "")
				THIS.this_cContaDs  = TratarNulo(ContaDs, "")
				THIS.this_nQtds     = TratarNulo(Qtds, 0)

				*-- Resolve as descricoes da linha corrente, igual ao
				*-- Grade.AfterRowColChange do legado
				THIS.this_cDescricaoGrupo = THIS.ObterDescricaoGrupo(THIS.this_cGrupoDs)
				THIS.this_cDescricaoConta = THIS.ObterDescricaoConta(THIS.this_cContaDs)

				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave logica da linha de empenho corrente,
	* equivalente ao EmpDopNums usado no legado (Emps + Dopes + Numes
	* com 6 digitos). PROTECTED: de fora do BO nunca eh chamado
	* (CLAUDE.md regra #51).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* MontarChaveEmpDopNums - Monta a chave Emps+Dopes+Str(Numes,6) usada
	* pelo legado para localizar os itens (SigMvItn) de um movimento
	* (SigMvCab). Publico porque o Form tambem precisa montar essa
	* chave a partir da linha corrente do grid.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		*-- A chave eh POSICIONAL e tem 29 caracteres FIXOS: Emps char(3) +
		*-- Dopes char(20) + Str(Numes,6) = 29, exatamente a largura de
		*-- SigMvCab.EmpDopNums/SigMvItn.EmpDopNums (char(29) no
		*-- docs\schema.sql). ALLTRIM nas partes QUEBRA a busca em
		*-- SILENCIO (CLAUDE.md regra #42) - por isso PADR explicito, sem
		*-- confiar no padding que o cursor por acaso traz.
		RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
		       PADR(TratarNulo(par_cDopes, ""), 20) + ;
		       STR(TratarNulo(par_nNumes, 0), 6)
	ENDFUNC

	*====================================================================
	* Inserir / Atualizar - SigOpEmp eh EXCLUSIVAMENTE uma tela de
	* CONSULTA (dialogo filho que mostra os itens empenhados/reservados
	* de um produto). O codigo fonte legado inteiro
	* (SigOpEmp_form_codigo_fonte.txt) foi conferido e NAO contem
	* nenhum comando de gravacao (Insert/Update/Delete/TableUpdate) - o
	* unico botao ("ok"/Encerrar) apenas chama ThisForm.Release(). Nao
	* existe chave nem tabela propria para gravar aqui, e inventar um
	* INSERT/UPDATE violaria o PILAR 2. Os dois metodos ficam
	* sobrescritos apenas para deixar a mensagem explicita -
	* RegistrarAuditoria() nunca eh chamado porque nenhuma gravacao
	* ocorre.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		THIS.this_cMensagemErro = "Empenho " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	PROTECTED PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "Empenho " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* CriarCursorEmpenhado - cria (ou recria) o cursor placeholder da
	* grade (cursor_4c_Empenhado), com a MESMA estrutura/ordem de colunas
	* usada por BuscarEmpenhosDoProduto() - o ponto UNICO de CREATE
	* CURSOR desta tela, para o Grid.ControlSource de ConfigurarPaginaLista
	* nunca referenciar alias ainda inexistente (CLAUDE.md regra #41).
	*   par_lForcarRecriar - .T. derruba e recria o alias mesmo existindo
	*====================================================================
	PROCEDURE CriarCursorEmpenhado(par_lForcarRecriar)
		LOCAL loc_cAlias, loc_lRecriar

		loc_cAlias = ALLTRIM(THIS.this_cCursorLista)
		loc_lRecriar = !USED(loc_cAlias)

		IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
			loc_lRecriar = .T.
		ENDIF

		IF loc_lRecriar
			IF USED(loc_cAlias)
				USE IN (loc_cAlias)
			ENDIF

			*-- Larguras conforme docs\schema.sql (SigMvCab/SigMvItn):
			*-- qtds numeric(9,3) -> N(10,3) (o ponto decimal entra na largura)
			CREATE CURSOR (loc_cAlias) ( ;
				Emps     C(3),    ;
				Dopes    C(20),   ;
				Numes    N(6, 0), ;
				Datas    T,       ;
				GrupoDs  C(10),   ;
				ContaDs  C(10),   ;
				Qtds     N(10, 3) )
		ENDIF

		RETURN USED(loc_cAlias)
	ENDPROC

	*====================================================================
	* BuscarEmpenhosDoProduto - Popula this_cCursorLista (cursor_4c_
	* Empenhado) com os movimentos que tem quantidade empenhada/
	* reservada (SigMvItn.Qtds) do produto informado, juntando o
	* cabecalho do movimento (SigMvCab) com o item (SigMvItn) pela
	* chave EmpDopNums - equivalente ao cursor 'CrEmpenhado' que o form
	* pai (SigMvEtr/Etiqueta) monta e deixa aberto antes de abrir este
	* dialogo (RecordSource = 'CrEmpenhado' no Init legado).
	*   par_cEmps    - empresa (filtra o cabecalho do movimento)
	*   par_cProduto - codigo do produto (SigMvItn.Cpros) cujos
	*                  empenhos devem ser exibidos
	*====================================================================
	FUNCTION BuscarEmpenhosDoProduto(par_cEmps, par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_lSucesso, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso  = .F.
		loc_cAliasTmp = "cursor_4c_EmpenhadoTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cProduto, "")))
			THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o informado"
			RETURN .F.
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
					   "a.Grupods AS GrupoDs, a.Contads AS ContaDs, b.Qtds " + ;
					   "FROM SigMvCab a " + ;
					   "JOIN SigMvItn b ON a.EmpDopNums = b.EmpDopNums " + ;
					   "WHERE b.Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))

			IF VARTYPE(par_cEmps) = "C" AND !EMPTY(ALLTRIM(par_cEmps))
				loc_cSQL = loc_cSQL + " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmps))
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.Datas"

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Erro ao buscar os empenhos do produto:" + ;
					CHR(13) + CapturarErroSQL()
			ELSE
				*-- NAO forcar recriacao do cursor aqui: o Grid da tela ja
				*-- esta com RecordSource/ControlSource ligados a este alias
				*-- (ConfigurarGrid roda ANTES da 1a chamada a este metodo).
				*-- Fechar/recriar o alias (USE IN + CREATE CURSOR) com o
				*-- Grid ja bindado zera o ColumnCount (mesmo efeito do
				*-- SQLEXEC direto sobre alias de grid - CLAUDE.md regra
				*-- correlata). CriarCursorEmpenhado() SEM forcar so cria se
				*-- ainda nao existir; existindo, ZAP + APPEND preserva a
				*-- estrutura e o binding do Grid.
				IF !THIS.CriarCursorEmpenhado(.F.)
					THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
						"vel preparar a lista de empenhos."
				ELSE
					SELECT (THIS.this_cCursorLista)
					ZAP
					IF loc_nResultado > 0
						APPEND FROM DBF(loc_cAliasTmp)
					ENDIF

					GO TOP IN (THIS.this_cCursorLista)
					loc_lSucesso = .T.
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterDescricaoGrupo - Descricao do Grupo Destino do movimento
	* (SigCdGcr.Descrs), equivalente ao
	* CursorQuery('SigCdGcr','crSigCdGcr','codigos',GrupoDs,[Descrs])
	* do legado (Grade.AfterRowColChange).
	*====================================================================
	FUNCTION ObterDescricaoGrupo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_cDescricao, loc_oErro

		loc_cDescricao = ""
		loc_cAliasTmp  = "cursor_4c_GrupoDsTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cCodigo, ""))) ;
				OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN ""
		ENDIF

		TRY
			loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + ;
				EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado > 0
				SELECT (loc_cAliasTmp)
				IF !EOF()
					loc_cDescricao = TratarNulo(descrs, "")
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDFUNC

	*====================================================================
	* ObterDescricaoConta - Descricao da Conta Destino do movimento
	* (SigCdCli.Rclis), equivalente ao
	* CursorQuery('SigCdCli','crSigCdCli','iclis',ContaDs,[Rclis])
	* do legado (Grade.AfterRowColChange).
	*====================================================================
	FUNCTION ObterDescricaoConta(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_cDescricao, loc_oErro

		loc_cDescricao = ""
		loc_cAliasTmp  = "cursor_4c_ContaDsTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cCodigo, ""))) ;
				OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN ""
		ENDIF

		TRY
			loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + ;
				EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado > 0
				SELECT (loc_cAliasTmp)
				IF !EOF()
					loc_cDescricao = TratarNulo(rclis, "")
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDFUNC

ENDDEFINE

