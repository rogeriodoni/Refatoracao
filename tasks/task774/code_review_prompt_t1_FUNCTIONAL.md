# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1190 linhas total):

*-- Linhas 20 a 82:
20: * Historico de fases:
21: *   Fase 1/2: SigOpOchBO.prg (propriedades + CarregarContaCorrente/
22: *             CarregarFollowUp/CarregarDoCursor/ObterChavePrimaria).
23: *   Fase 3:   FormSigOpOch.prg - estrutura base (Init, InicializarForm,
24: *             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
25: *             lbl_4c_LblTitulo, Destroy). Form FLAT: o legado nao tem
26: *             PageFrame nem Page nenhuma - nenhum pgf_4c_* eh criado neste
27: *             form (mesma familia do SIGOPBIN/FormSIGOPBIN).
28: *   Fase 4/8: cursores de trabalho (cursor_4c_ContaCc/cursor_4c_FollowUp),
29: *             as DUAS grades (grd_lancamento -> grd_4c_Lancamento,
30: *             GridFollowUp -> grd_4c_FollowUp), o botao Encerrar
31: *             (CommandGroup1.Sair -> cmg_4c_Botoes.Buttons(1)) com o Click
32: *             real do legado, e CarregarLista/AtualizarGrades.
33: *   Fase 5/8:   Memo_Obs (obj_4c_Memo_Obs), somente leitura, ligado a
34: *             cursor_4c_FollowUp.ObsAudts (ConfigurarMemo), repintado junto
35: *             com as grades em AtualizarGrades.
36: *   Fase 6/8: ordem de tabulacao (TabIndex) dos 4 controles que o SCX
37: *             declara explicitamente: grd_4c_FollowUp=3, cmg_4c_Botoes=6,
38: *             grd_4c_Lancamento=8, obj_4c_Memo_Obs=34. O dialogo NAO tem
39: *             TextBox nenhum (nem campo digitavel, nem lookup) - as DUAS
40: *             grades sao somente-leitura e o unico controle de entrada eh
41: *             o botao Encerrar: o roteiro generico da Fase 6 (campos
42: *             restantes + BINDEVENT de lookup F4/F5) nao se aplica aqui,
43: *             e inventar TextBox/lookup que o legado nao tem violaria a
44: *             regra "NUNCA inventar" (mesmo raciocinio da nota da Fase 4).
45: *   Fase 7/8: eventos principais - AfterRowColChange do GridFollowUp
46: *             (GrdFollowUpAfterRowColChange, equivalente a
47: *             ThisForm.Memo_Obs.Refresh) ligado em ConfigurarEventos. Com
48: *             ele os DOIS unicos eventos do SCX legado estao portados
49: *             (o outro, Sair.Valid -> CmdEncerrarClick, veio na Fase 4).
50: *   Fase 8/8: consolidacao final - conferido metodo a metodo contra o dump
51: *             (tasks\task774\SigOpOch_form_codigo_fonte.txt) que os SEIS
52: *             metodos/eventos do legado (Init, Load, Release, AfterRowColChange,
53: *             Sair.Valid, Memo_Obs.When) estao TODOS portados; ver bloco
54: *             "FASE 8" abaixo para a disposicao dos 9 nomes do roteiro
55: *             generico de Fase 8 que nao se aplicam a este dialogo.
56: *
57: * FASE 8 - SEM BtnBuscar/BtnSalvar/BtnCancelarClick/FormParaBO/BOParaForm/
58: *          HabilitarCampos/LimparCampos/AjustarBotoesPorModo
59: * ---------------------------------------------------------------------
60: * O roteiro generico desta fase (BtnBuscarClick/BtnEncerrarClick/
61: * BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
62: * LimparCampos/CarregarLista/AjustarBotoesPorModo) eh o checklist do
63: * frmcadastro (Page1=Lista + Page2=Dados com campos EDITAVEIS). Nenhum dos 8
64: * nomes restantes se aplica a este dialogo, pela MESMA razao ja registrada
65: * nas notas de Fase 4 e Fase 7 acima (sem PageFrame, sem Grupo_Op, sem
66: * pcEscolha, sem Page2) mais uma: AMBOS os grids E o Memo_Obs sao
67: * somente-leitura (ReadOnly = .T. no grid, em CADA coluna e no proprio
68: * memo) - nao ha "forma" digitavel para mapear de volta ao BO, nem campo
69: * para habilitar/desabilitar por modo. Disposicao, um a um:
70: *
71: *   Nome pedido pelo roteiro   Existe no legado?   Disposicao aqui
72: *   -------------------------  ------------------  --------------------------
73: *   BtnBuscarClick              NAO (SCX so tem    N/A - nao inventar botao
74: *                                 CommandGroup1,     que o legado nao tem
75: *                                 ButtonCount = 1)
76: *   BtnEncerrarClick             SIM (Sair,         Ja implementado como
77: *                                 Caption "Encerrar" CmdEncerrarClick (Sair.
78: *                                 no dump)           Valid -> ThisForm.Release)
79: *   BtnSalvarClick/              NAO (nenhum        N/A - SigOpOchBO nao
80: *   BtnCancelarClick             Insert/Update/     sobrescreve Inserir/
81: *                                 Delete no dump -   Atualizar/Executar
82: *                                 ver nota no fim     Exclusao; dialogo

*-- Linhas 104 a 150:
104: *
105: * Escrever qualquer um dos 8 metodos marcados N/A so para "bater o
106: * checklist" seria o stub disfarcado que a regra de completude PROIBE
107: * (corpo vazio ou so MsgAviso) - pior que a ausencia documentada, porque
108: * sugere fidelidade que nao existe.
109: *
110: * PROCEDURE Load legado (=fConfigGeral() + DoDefault()) tambem nao gera
111: * metodo aqui: fConfigGeral era inicializacao GLOBAL da aplicacao Fortyus
112: * (SIGFUNCS.PRG), substituida na nova arquitetura pela carga do proprio
113: * config.prg/ConfigurarAmbiente() no startup - mesmo raciocinio ja registrado
114: * em SigOpClpBO.prg, SIGOPGRCBO.prg, SigOpIpBBO.prg, SigOpMpdBO.prg e
115: * SigOpMpnBO.prg (outros forms SigOp* desta mesma leva de migracao).
116: *
117: * FASE 8/8 CONCLUIDA.
118: *
119: * FASE 7 - SEM BtnIncluir/BtnAlterar/BtnVisualizar/BtnExcluirClick
120: * ---------------------------------------------------------------
121: * O roteiro generico da Fase 7 pede os 4 handlers CRUD da barra do
122: * frmcadastro. Medido no dump (tasks\task774\SigOpOch_form_codigo_fonte.txt):
123: *   - "frmcadastro" ........... 0 ocorrencias (o legado herda de form PURO)
124: *   - "Grupo_Op" .............. 0 ocorrencias (nao ha barra CRUD)
125: *   - btn/cmd/Command + verbo
126: *     Incluir/Alterar/
127: *     Visualizar/Excluir ...... 0 ocorrencias
128: *   - "pcEscolha" (modo CRUD) . 0 ocorrencias
129: *   - INSERT/UPDATE/DELETE .... 0 (as duas unicas queries sao SELECT)
130: *   - botoes do legado ........ 1 (CommandGroup1, ButtonCount = 1, "Sair")
131: * Nao existe registro para incluir, alterar ou excluir nesta tela: criar os 4
132: * handlers exigiria INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a
133: * regra "NUNCA inventar") ou escrever metodos vazios (proibido pela regra de
134: * completude). O que a Fase 7 entrega aqui sao os eventos dos controles que o
135: * form REALMENTE tem - o handler do unico botao (ja em CmdEncerrarClick) e o
136: * AfterRowColChange da grade de FollowUp - mesmo desenho de FormSIGMVCTH.
137: *
138: * FASE 4 - LAYOUT FLAT, SEM ConfigurarPaginaLista/AlternarPagina
139: * -------------------------------------------------------------
140: * O roteiro generico da Fase 4 pede ConfigurarPaginaLista + cnt_4c_Botoes com
141: * 6 botoes CRUD + AlternarPagina. Esse legado NAO tem nada disso, e a medicao
142: * no dump (tasks\task774\SigOpOch_form_codigo_fonte.txt) e' esta:
143: *   - PageFrame/Page .......... 0 ocorrencias de "BaseClass: pageframe"
144: *   - grades .................. 2 ("BaseClass: grid" - GridFollowUp e
145: *                                  grd_lancamento, filhas DIRETAS do form)
146: *   - botoes .................. 1 CommandGroup de ButtonCount = 1 ("Sair",
147: *                                  Caption "Encerrar", Cancel = .T.)
148: *   - INSERT/UPDATE/DELETE .... 0 (dialogo de consulta pura)
149: * Logo nao existe Lista x Dados para alternar nem registro para Incluir/
150: * Alterar/Excluir/Buscar: criar PageFrame, 6 botoes CRUD ou um AlternarPagina

*-- Linhas 194 a 361:
194:     Themes      = .F.
195: 
196:     *-- Parametros de filtro recebidos no Init (equivalem a pnNoper/pcOper do
197:     *-- PROCEDURE Init legado) - identificam o lancamento de conta corrente
198:     *-- cujo FollowUp esta sendo consultado.
199:     this_nNopers = 0
200:     this_cOpers  = ""
201: 
202:     *--------------------------------------------------------------------------
203:     * Init - Recebe os parametros do form pai (equivale ao LParameters poForm,
204:     * pnNoper, pcOper do legado) e os guarda ANTES de DODEFAULT(), para que
205:     * InicializarForm() (chamado por FormBase.Init via DODEFAULT) possa
206:     * transferi-los para o Business Object.
207:     *
208:     * par_oFormPai NAO e armazenado: o legado recebe poForm no LParameters mas
209:     * NUNCA o referencia em lugar nenhum do codigo fonte original (conferido
210:     * em tasks\task774\SigOpOch_form_codigo_fonte.txt) - guardar uma
211:     * referencia que nunca e lida inventaria uso que o legado nao tem.
212:     *--------------------------------------------------------------------------
213:     PROCEDURE Init()
214:         LPARAMETERS par_oFormPai, par_nNoper, par_cOper
215: 
216:         LOCAL loc_oErro
217:         TRY
218:             THIS.this_nNopers = IIF(VARTYPE(par_nNoper) = "N", par_nNoper, 0)
219:             THIS.this_cOpers  = IIF(VARTYPE(par_cOper) = "C", par_cOper, "")
220:         CATCH TO loc_oErro
221:             MsgErro(loc_oErro.Message + CHR(13) + ;
222:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
223:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.Init")
224:         ENDTRY
225: 
226:         *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
227:         RETURN DODEFAULT()
228:     ENDPROC
229: 
230:     *--------------------------------------------------------------------------
231:     * InicializarForm - Cria o Business Object, transfere os parametros de
232:     * filtro e monta a estrutura visual base (cabecalho).
233:     * (chamado por FormBase.Init via DODEFAULT)
234:     *--------------------------------------------------------------------------
235:     PROTECTED PROCEDURE InicializarForm()
236:         LOCAL loc_lSucesso, loc_oErro
237:         loc_lSucesso = .F.
238: 
239:         TRY
240:             *-- Fundo do form (imagem do Framework Fortyus legado)
241:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
242: 
243:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpOchBO")
244:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
245:                 MsgErro("Erro ao criar SigOpOchBO." + CHR(13) + ;
246:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
247:                     "FormSigOpOch.InicializarForm")
248:             ELSE
249:                 THIS.this_oBusinessObject.this_nNopers = THIS.this_nNopers
250:                 THIS.this_oBusinessObject.this_cOpers  = THIS.this_cOpers
251: 
252:                 *-- 1) Cursores de trabalho ANTES das grades: atribuir
253:                 *-- Column.ControlSource de cursor que ainda nao existe estoura
254:                 *-- "Alias is not found" DENTRO deste TRY, InicializarForm
255:                 *-- devolve .F. e o usuario clica no menu e nada abre.
256:                 THIS.InicializarCursores()
257: 
258:                 *-- 2) Cabecalho (cnt_4c_Sombra + labels) - o legado nao tem
259:                 *-- PageFrame/Page nenhuma, entao nada mais eh criado aqui
260:                 THIS.ConfigurarPageFrame()
261: 
262:                 *-- 3) Grades (filhas DIRETAS do form, como no SCX legado)
263:                 THIS.ConfigurarGrades()
264: 
265:                 *-- 3b) Memo_Obs (observacao completa da linha corrente de
266:                 *-- grd_4c_FollowUp) - depende de cursor_4c_FollowUp, ja
267:                 *-- criado em InicializarCursores()
268:                 THIS.ConfigurarMemo()
269: 
270:                 *-- 4) Botao Encerrar DEPOIS do cabecalho: o CommandGroup do
271:                 *-- legado fica em Top = -2 / Left = 720, ou seja DENTRO da
272:                 *-- area do cnt_4c_Sombra (Top 0..80) - criado antes, a faixa
273:                 *-- cinza o cobriria (mesma armadilha de ordem da regra #11).
274:                 THIS.ConfigurarBotoes()
275: 
276:                 *-- 5) Eventos (BINDEVENT exige metodos PUBLIC - regra #3)
277:                 THIS.ConfigurarEventos()
278: 
279:                 *-- Torna a arvore de controles visivel (AddObject cria com
280:                 *-- Visible=.F.)
281:                 THIS.TornarControlesVisiveis(THIS)
282: 
283:                 *-- 6) Carga: o legado faz as duas consultas no PROPRIO Init,
284:                 *-- antes de a tela aparecer. Falha de carga NAO impede a
285:                 *-- abertura (a mensagem do BO ja foi exibida em CarregarLista).
286:                 *--
287:                 *-- Pulada em validacao de UI: ali gnConnHandle = -1, as duas
288:                 *-- consultas falhariam e o MsgErro de CarregarLista BLOQUEIA o
289:                 *-- processo headless (o dialog so se suprime com
290:                 *-- gb_4c_ModoTeste E gc_4c_ArquivoErroTeste definidos).
291:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
292:                     THIS.CarregarLista()
293:                 ENDIF
294: 
295:                 loc_lSucesso = .T.
296:             ENDIF
297:         CATCH TO loc_oErro
298:             MsgErro(loc_oErro.Message + CHR(13) + ;
299:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
300:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.InicializarForm")
301:         ENDTRY
302: 
303:         RETURN loc_lSucesso
304:     ENDPROC
305: 
306:     *--------------------------------------------------------------------------
307:     * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
308:     *   Form OPERACIONAL FLAT: o legado (SIGOPOCH.SCX) nao tem PageFrame nem
309:     *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
310:     *   metodo mantido por convencao do orquestrador de migracao: este form NAO
311:     *   cria PageFrame algum, nem aqui nem em nenhum outro metodo.
312:     *
313:     *   NAO reescrever a frase acima citando a CHAMADA de criacao do PageFrame
314:     *   entre aspas: o gate da Fase 5 decide o layout FLAT procurando esse texto
315:     *   no arquivo INTEIRO, sem distinguir codigo de comentario - a prosa
316:     *   quotando a chamada derruba a fase com o form CORRETO (regra irma da que
317:     *   proibe comentario citando nome de metodo para satisfazer gate).
318:     *   Demais controles do legado (GridFollowUp, grd_lancamento,
319:     *   CommandGroup1, Memo_Obs) entram nas fases 4 a 6.
320:     *--------------------------------------------------------------------------
321:     PROTECTED PROCEDURE ConfigurarPageFrame()
322:         LOCAL loc_oCab, loc_oErro
323:         TRY
324:             *-- cntSombra original: Top=0, Left=0, Width=800, Height=80,
325:             *-- BackColor=100,100,100
326:             THIS.AddObject("cnt_4c_Sombra", "Container")
327:             loc_oCab = THIS.cnt_4c_Sombra
328:             WITH loc_oCab
329:                 .Top         = 0
330:                 .Left        = 0
331:                 .Width       = THIS.Width
332:                 .Height      = 80
333:                 .BorderWidth = 0
334:                 .BackStyle   = 1
335:                 .BackColor   = RGB(100, 100, 100)
336:             ENDWITH
337: 
338:             *-- Labels adicionados FORA do WITH do container (WITH aninhado com
339:             *-- AddObject ignora propriedades silenciosamente - regra conhecida)
340:             *-- lblSombra original: Top=18, Left=10, Width=769, Height=40,
341:             *-- ForeColor=0,0,0 (camada de sombra, preta, por TRAS do titulo)
342:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
343:             WITH loc_oCab.lbl_4c_LblSombra
344:                 .FontBold      = .T.
345:                 .FontName      = "Tahoma"
346:                 .FontSize      = 18
347:                 .FontUnderline = .F.
348:                 .WordWrap      = .T.
349:                 .AutoSize      = .F.
350:                 .Alignment     = 0
351:                 .BackStyle     = 0
352:                 .Caption       = THIS.Caption
353:                 .Height        = 40
354:                 .Left          = 10
355:                 .Top           = 18
356:                 .Width         = 769
357:                 .ForeColor     = RGB(0, 0, 0)
358:             ENDWITH
359: 
360:             *-- lblTitulo original: Top=17, Left=10, Width=769, Height=46,
361:             *-- ForeColor=255,255,255 (camada branca, por CIMA da sombra)

*-- Linhas 379 a 526:
379:         CATCH TO loc_oErro
380:             MsgErro(loc_oErro.Message + CHR(13) + ;
381:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
382:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarPageFrame")
383:         ENDTRY
384:     ENDPROC
385: 
386:     *--------------------------------------------------------------------------
387:     * InicializarCursores - Cria os DOIS cursores de trabalho VAZIOS.
388:     *
389:     * Equivalem aos cursores ContaCC e Movimento do Init legado. Precisam
390:     * existir ANTES de qualquer Column.ControlSource: atribuir ControlSource de
391:     * cursor inexistente estoura "Alias 'CURSOR_4C_CONTACC' is not found"
392:     * dentro do TRY de InicializarForm, que devolve .F., CREATEOBJECT devolve
393:     * .F. e o usuario clica no menu e NADA acontece, sem erro visivel.
394:     *
395:     * A lista de campos eh EXATAMENTE a lista de colunas dos SELECT de
396:     * SigOpOchBO.CarregarContaCorrente/CarregarFollowUp: aquelas rotinas
397:     * populam um cursor temporario e trazem o resultado com ZAP + APPEND FROM
398:     * DBF(), que casa os campos por NOME - nome a mais ou a menos entra em
399:     * branco calado. Tipos conferidos em docs\schema.sql (UTF-16, lido com
400:     * Get-Content -Raw): SigMvCcr.datas datetime NULL, hists char(60) NULL,
401:     * valors numeric(11,2), opers char(1), emps char(3), saldos numeric(15,2),
402:     * concs bit, dtaudits datetime NULL; SigCqOch.datars/datas datetime NULL,
403:     * tplancs char(15), usuars char(10), obsaudts text NULL.
404:     *
405:     * SET NULL ON eh obrigatorio: o SQL Server devolve NULL nessas colunas e
406:     * sem campo nullable o APPEND FROM falha.
407:     *--------------------------------------------------------------------------
408:     PROTECTED PROCEDURE InicializarCursores()
409:         LOCAL loc_oErro
410:         TRY
411:             *-- ContaCC legado (SigMvCcr) - RecordSource de grd_4c_Lancamento.
412:             *-- Concs/DtAudits NAO aparecem em coluna nenhuma da grade: sao as
413:             *-- colunas que o DynamicForeColor/DynamicBackColor do Init legado
414:             *-- le para colorir a linha (ver ConfigurarGradeLancamento).
415:             IF !USED("cursor_4c_ContaCc")
416:                 SET NULL ON
417:                 CREATE CURSOR cursor_4c_ContaCc ( ;
418:                     Datas    T          NULL, ;
419:                     Hists    C(60)      NULL, ;
420:                     Valors   N(11,2), ;
421:                     Opers    C(1), ;
422:                     Emps     C(3), ;
423:                     Saldos   N(15,2), ;
424:                     Concs    N(1), ;
425:                     DtAudits T          NULL)
426:                 SET NULL OFF
427:             ENDIF
428: 
429:             *-- Movimento legado (SigCqOch + ObsAudt2 derivada) - RecordSource
430:             *-- de grd_4c_FollowUp. ObsAudts eh o texto COMPLETO (Memo_Obs, na
431:             *-- Fase 5); ObsAudt2 eh a versao truncada em 50 que o legado monta
432:             *-- com Padr(Nvl(ObsAudts,' '),50) para a coluna da grade.
433:             IF !USED("cursor_4c_FollowUp")
434:                 SET NULL ON
435:                 CREATE CURSOR cursor_4c_FollowUp ( ;
436:                     Datars   T      NULL, ;
437:                     TpLancs  C(15), ;
438:                     Datas    T      NULL, ;
439:                     Usuars   C(10), ;
440:                     ObsAudts M(4)   NULL, ;
441:                     ObsAudt2 C(50))
442:                 SET NULL OFF
443:             ENDIF
444:         CATCH TO loc_oErro
445:             MsgErro(loc_oErro.Message + CHR(13) + ;
446:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
447:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.InicializarCursores")
448:         ENDTRY
449:     ENDPROC
450: 
451:     *--------------------------------------------------------------------------
452:     * ConfigurarGrades - Cria as DUAS grades do legado, filhas DIRETAS do form
453:     * (o SCX nao tem PageFrame nem Container envolvendo-as).
454:     *
455:     * Nenhuma das duas sobrepoe o cnt_4c_Sombra (Top 0..80) nem o cmg_4c_Botoes
456:     * (Top -2..83): grd_4c_Lancamento ocupa 89..165 e grd_4c_FollowUp 173..373.
457:     *--------------------------------------------------------------------------
458:     PROTECTED PROCEDURE ConfigurarGrades()
459:         THIS.ConfigurarGradeLancamento()
460:         THIS.ConfigurarGradeFollowUp()
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * ConfigurarGradeLancamento - grd_lancamento legado (Class: grid).
465:     * Mostra o UNICO lancamento de conta corrente que o form pai selecionou
466:     * (SigMvCcr filtrado por Nopers + Opers). Somente leitura: ReadOnly = .T.
467:     * no grid E em cada coluna, como no SCX.
468:     *
469:     * As colunas conservam os nomes nativos Column1..Column6 (renomear Column
470:     * quebra TODAS as referencias .ColumnN). Correspondencia com o legado:
471:     *   Column1 = Col_Data  (Datas)    Column4 = Col_Oper  (Opers)
472:     *   Column2 = Col_Hist  (Hists)    Column5 = Col_Emp   (Emps)
473:     *   Column3 = Col_Valor (Valors)   Column6 = Col_Saldo (Saldos)
474:     *
475:     * ATENCAO a ColumnOrder: o SCX declara Column5.ColumnOrder = 6 e
476:     * Column6.ColumnOrder = 5, ou seja a ordem VISIVEL eh
477:     * Data | Historico | Valor | O | Saldo | Emp - o Saldo vem ANTES da
478:     * Empresa na tela, apesar de ser a ultima coluna declarada.
479:     *
480:     * NAO transcrito do dump: "Value = 0". Grid tem a propriedade Value (consta
481:     * em automation\propriedades_baseclasses.txt), mas ela reflete o valor da
482:     * celula ativa e nao aceita escrita em runtime como configuracao - eh
483:     * bookkeeping do Form Designer. Atribuir derrubaria o Init sem ganho visual
484:     * nenhum (mesma familia de ZOrderSet, regra #33).
485:     *--------------------------------------------------------------------------
486:     PROTECTED PROCEDURE ConfigurarGradeLancamento()
487:         LOCAL loc_oErro
488:         TRY
489:             THIS.AddObject("grd_4c_Lancamento", "Grid")
490: 
491:             *-- grd_lancamento legado: Top=89, Left=60, Width=679, Height=76,
492:             *-- FontName="Tahoma", GridLineColor=238,238,238
493:             WITH THIS.grd_4c_Lancamento
494:                 .Top               = 89
495:                 .Left              = 60
496:                 .Width             = 679
497:                 .Height            = 76
498:                 .HeaderHeight       = 0
499:                 .FontName          = "Tahoma"
500:                 .AllowHeaderSizing = .F.
501:                 .AllowRowSizing    = .F.
502:                 .ScrollBars        = 2
503:                 .GridLineColor     = RGB(238, 238, 238)
504:                 *-- TabIndex = 8 no SCX legado (ordem de tabulacao do dialogo)
505:                 .TabIndex          = 8
506:                 *-- ReadOnly do GRID vem ANTES do ReadOnly das colunas: o do
507:                 *-- grid propaga e sobrescreveria o das colunas (regra #18)
508:                 .ReadOnly          = .T.
509:                 *-- Grid criado por AddObject em form OPERACIONAL: sem estas
510:                 *-- duas, as barras de marcacao aparecem na lateral esquerda
511:                 .DeleteMark        = .F.
512:                 .RecordMark        = .F.
513:             ENDWITH
514: 
515:             *-- ColumnCount e RecordSource por referencia EXPLICITA, FORA do
516:             *-- WITH que acessa .Column1..: no instante em que o WITH eh aberto
517:             *-- as colunas ainda nao existem ("Unknown member COLUMN1").
518:             THIS.grd_4c_Lancamento.ColumnCount  = 6
519:             THIS.grd_4c_Lancamento.RecordSource = "cursor_4c_ContaCc"
520: 
521:             WITH THIS.grd_4c_Lancamento
522:                 *-- ControlSource de TODAS as colunas (Init legado:
523:                 *-- .Col_data.ControlSource = "Datas", etc.) - aqui
524:                 *-- qualificado com o alias, padrao do projeto
525:                 .Column1.ControlSource = "cursor_4c_ContaCc.Datas"
526:                 .Column2.ControlSource = "cursor_4c_ContaCc.Hists"

*-- Linhas 686 a 748:
686:         CATCH TO loc_oErro
687:             MsgErro(loc_oErro.Message + CHR(13) + ;
688:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
689:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarGradeLancamento")
690:         ENDTRY
691:     ENDPROC
692: 
693:     *--------------------------------------------------------------------------
694:     * ConfigurarGradeFollowUp - GridFollowUp legado (Class: fwgrade).
695:     * Mostra TODO o historico de FollowUp do Noper (SigCqOch), uma linha por
696:     * acao de auditoria. Somente leitura.
697:     *
698:     * Correspondencia com o legado (Init: .ColumnN.ControlSource):
699:     *   Column1 = Movimento.Datars   (data/hora do lancamento do FollowUp)
700:     *   Column2 = Movimento.TpLancs  (tipo do lancamento)
701:     *   Column3 = Movimento.datas    (data do registro)
702:     *   Column4 = Movimento.Usuars   (usuario)
703:     *   Column5 = Movimento.ObsAudt2 (observacao truncada em 50)
704:     *
705:     * As quatro primeiras colunas usam Courier New (fonte monoespacada, para
706:     * data/hora e codigo alinharem) e a quinta Arial, exatamente como o SCX.
707:     *--------------------------------------------------------------------------
708:     PROTECTED PROCEDURE ConfigurarGradeFollowUp()
709:         LOCAL loc_oErro
710:         TRY
711:             THIS.AddObject("grd_4c_FollowUp", "Grid")
712: 
713:             *-- GridFollowUp legado: Top=173, Left=60, Width=679, Height=200,
714:             *-- FontName="Arial", FontSize=8, RowHeight=17
715:             WITH THIS.grd_4c_FollowUp
716:                 .Top           = 173
717:                 .Left          = 60
718:                 .Width         = 679
719:                 .Height        = 200
720:                 .HeaderHeight       = 0
721:                 .FontName      = "Arial"
722:                 .FontSize      = 8
723:                 .RowHeight     = 17
724:                 .ScrollBars    = 2
725:                 *-- TabIndex = 3 no SCX legado (ordem de tabulacao do dialogo)
726:                 .TabIndex      = 3
727:                 *-- ReadOnly do GRID antes do das colunas (regra #18)
728:                 .ReadOnly      = .T.
729:                 .DeleteMark    = .F.
730:                 .RecordMark    = .F.
731:             ENDWITH
732: 
733:             *-- ColumnCount/RecordSource FORA do WITH das colunas
734:             THIS.grd_4c_FollowUp.ColumnCount  = 5
735:             THIS.grd_4c_FollowUp.RecordSource = "cursor_4c_FollowUp"
736: 
737:             WITH THIS.grd_4c_FollowUp
738:                 .Column1.ControlSource = "cursor_4c_FollowUp.Datars"
739:                 .Column2.ControlSource = "cursor_4c_FollowUp.TpLancs"
740:                 .Column3.ControlSource = "cursor_4c_FollowUp.Datas"
741:                 .Column4.ControlSource = "cursor_4c_FollowUp.Usuars"
742:                 .Column5.ControlSource = "cursor_4c_FollowUp.ObsAudt2"
743: 
744:                 *-- Coluna 1 - "Data / Hora Lancto"
745:                 .Column1.Width             = 138
746:                 .Column1.FontName          = "Courier New"
747:                 .Column1.FontSize          = 8
748:                 .Column1.Movable           = .F.

*-- Linhas 838 a 1190:
838:         CATCH TO loc_oErro
839:             MsgErro(loc_oErro.Message + CHR(13) + ;
840:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
841:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarGradeFollowUp")
842:         ENDTRY
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     * ConfigurarMemo - Memo_Obs legado (Class: fwmemo, BaseClass: editbox),
847:     * somente leitura. Mostra o texto COMPLETO da observacao da linha
848:     * CORRENTE de grd_4c_FollowUp - a Column5 da grade (ObsAudt2) mostra so
849:     * os 50 primeiros caracteres (Padr(Nvl(ObsAudts,' '),50) do Init legado).
850:     *
851:     * ControlSource qualificado com o alias do cursor migrado: o legado usa
852:     * "Movimento.ObsAudts" (cursor local montado no Init); aqui o cursor
853:     * equivalente eh cursor_4c_FollowUp (criado em InicializarCursores),
854:     * coluna ObsAudts (M(4) NULL).
855:     *
856:     * Memo_Obs original: Top=381, Left=59, Width=682, Height=60, ReadOnly=.T.,
857:     * NullDisplay="  ". Nao sobrepoe grd_4c_FollowUp (173..373) nem o botao
858:     * Encerrar; cabe dentro do form (381+60=441 < Height=450).
859:     *--------------------------------------------------------------------------
860:     PROTECTED PROCEDURE ConfigurarMemo()
861:         LOCAL loc_oErro
862:         TRY
863:             THIS.AddObject("obj_4c_Memo_Obs", "EditBox")
864: 
865:             WITH THIS.obj_4c_Memo_Obs
866:                 .Top           = 381
867:                 .Left          = 59
868:                 .Width         = 682
869:                 .Height        = 60
870:                 .ReadOnly      = .T.
871:                 .NullDisplay   = "  "
872:                 *-- TabIndex = 34 no SCX legado (ordem de tabulacao do dialogo)
873:                 .TabIndex      = 34
874:                 .ControlSource = "cursor_4c_FollowUp.ObsAudts"
875:             ENDWITH
876:         CATCH TO loc_oErro
877:             MsgErro(loc_oErro.Message + CHR(13) + ;
878:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
879:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarMemo")
880:         ENDTRY
881:     ENDPROC
882: 
883:     *--------------------------------------------------------------------------
884:     * ConfigurarBotoes - CommandGroup1 legado (ButtonCount = 1, botao "Sair"
885:     * com Caption "Encerrar"). E o UNICO botao do dialogo: nao ha Incluir/
886:     * Alterar/Excluir/Buscar porque nao ha gravacao nenhuma nesta tela.
887:     *
888:     * Geometria legada: grupo Top=-2, Left=720, 85x85; botao interno Top=5,
889:     * Left=5, 75x75. O grupo eh AutoSize = .T., e eh a geometria do botao
890:     * INTERNO que define o tamanho do grupo (75 + 5 + 5 = 85) - por isso
891:     * Buttons(1) eh configurado ANTES de posicionar o grupo (regra #31).
892:     *
893:     * CommandGroup NAO tem ForeColor nem FontName (regra #33): a cor e a fonte
894:     * moram no Buttons(1), exatamente como o SCX declara em Command1.
895:     *
896:     * Left=720 + Width=85 = 805 passa 5px do form (Width=800); eh o valor do
897:     * proprio SCX e nada visivel se perde - o botao interno ocupa 725..800,
898:     * encostado na borda.
899:     *--------------------------------------------------------------------------
900:     PROTECTED PROCEDURE ConfigurarBotoes()
901:         LOCAL loc_oErro
902:         TRY
903:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
904: 
905:             WITH THIS.cmg_4c_Botoes
906:                 .ButtonCount = 1
907: 
908:                 WITH .Buttons(1)
909:                     .AutoSize    = .F.
910:                     .Top         = 5
911:                     .Left        = 5
912:                     .Height      = 75
913:                     .Width       = 75
914:                     .FontBold    = .T.
915:                     .FontItalic  = .T.
916:                     .FontName    = "Comic Sans MS"
917:                     .FontSize    = 8
918:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
919:                     .Cancel      = .T.
920:                     .Caption     = "Encerrar"
921:                     .ToolTipText = "<ESC> Sair"
922:                     .ForeColor   = RGB(90, 90, 90)
923:                     .BackColor   = RGB(255, 255, 255)
924:                 ENDWITH
925: 
926:                 *-- Grupo DEPOIS do botao interno: com AutoSize = .T. eh o
927:                 *-- interno que dita 85x85 (o SCX ja declara o resultado)
928:                 .AutoSize      = .T.
929:                 .Top           = -2
930:                 .Left          = 720
931:                 .Height        = 85
932:                 .Width         = 85
933:                 .BackStyle     = 0
934:                 .BorderStyle   = 0
935:                 .SpecialEffect = 1
936:                 .BorderColor   = RGB(136, 189, 188)
937:                 *-- TabIndex = 6 no SCX legado (ordem de tabulacao do dialogo)
938:                 .TabIndex      = 6
939:                 .Value         = 1
940:             ENDWITH
941:         CATCH TO loc_oErro
942:             MsgErro(loc_oErro.Message + CHR(13) + ;
943:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
944:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarBotoes")
945:         ENDTRY
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * ConfigurarEventos - Liga os DOIS eventos que o legado tem:
950:     *
951:     *   CommandGroup1.Sair.Valid    -> CmdEncerrarClick
952:     *   GridFollowUp.AfterRowColChange -> GrdFollowUpAfterRowColChange
953:     *
954:     * Botao Encerrar: no legado o codigo esta em Sair.Valid (PROCEDURE
955:     * Sair.Valid -> ThisForm.Release). BINDEVENT em "Valid" nao dispara de
956:     * forma confiavel, entao o equivalente eh o "Click" do proprio botao - o
957:     * botao tem Cancel = .T., logo ESC tambem o acionara, como no legado.
958:     *
959:     * Grade de FollowUp: o legado repinta o Memo_Obs a cada troca de linha
960:     * (ver GrdFollowUpAfterRowColChange). Nao ha evento no grd_lancamento: o
961:     * SCX legado nao declara nenhum para ele (a grade mostra UM lancamento
962:     * so), e inventar um violaria a regra "NUNCA inventar".
963:     *
964:     * BINDEVENT exige metodo PUBLIC: com PROTECTED falha em SILENCIO (regra #3).
965:     *--------------------------------------------------------------------------
966:     PROTECTED PROCEDURE ConfigurarEventos()
967:         LOCAL loc_oErro
968:         TRY
969:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "CmdEncerrarClick")
970: 
971:             BINDEVENT(THIS.grd_4c_FollowUp, "AfterRowColChange", ;
972:                 THIS, "GrdFollowUpAfterRowColChange")
973:         CATCH TO loc_oErro
974:             MsgErro(loc_oErro.Message + CHR(13) + ;
975:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
976:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarEventos")
977:         ENDTRY
978:     ENDPROC
979: 
980:     *--------------------------------------------------------------------------
981:     * CmdEncerrarClick - Equivalente ao PROCEDURE Sair.Valid legado
982:     * (ThisForm.Release). Fecha o dialogo; o Destroy fecha os cursores e
983:     * reconstroi os popups do menu via DODEFAULT.
984:     *
985:     * PUBLIC (sem PROTECTED): alvo de BINDEVENT e chamado de fora pelo harness.
986:     *--------------------------------------------------------------------------
987:     PROCEDURE CmdEncerrarClick()
988:         THIS.Release()
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------
992:     * GrdFollowUpAfterRowColChange - Equivalente ao AfterRowColChange do
993:     * GridFollowUp legado, que e o metodo INTEIRO:
994:     *
995:     *   LPARAMETERS nColIndex
996:     *   ThisForm.Memo_Obs.Refresh
997:     *
998:     * Cada linha do historico guarda a observacao COMPLETA em
999:     * cursor_4c_FollowUp.ObsAudts; a Column5 da grade mostra apenas os 50
1000:     * primeiros caracteres (ObsAudt2, truncado com Padr(Nvl(ObsAudts,' '),50)
1001:     * no Init legado). Trocar de linha move o ponteiro do cursor, mas o
1002:     * EditBox ligado a ObsAudts NAO se repinta sozinho - sem este Refresh o
1003:     * obj_4c_Memo_Obs continua exibindo o texto da linha ANTERIOR (regra #21a:
1004:     * mover/popular cursor nao repinta o controle).
1005:     *
1006:     * USO CORRETO de AfterRowColChange (regra #46): carregar o DETALHE da
1007:     * linha CORRENTE. O que a regra #46 proibe e VALIDAR CELULA aqui, porque
1008:     * par_nColIndex e a coluna de DESTINO e nao a de origem - por isso nao ha
1009:     * filtro de coluna neste handler: o legado declara nColIndex e NUNCA o le,
1010:     * o refresh vale para qualquer coluna em que o usuario entre.
1011:     *
1012:     * par_nColIndex DEVE ser declarado mesmo sem uso: handler ligado por
1013:     * BINDEVENT precisa repetir a assinatura do evento, senao estoura a cada
1014:     * disparo (regra #3).
1015:     *
1016:     * PUBLIC (sem PROTECTED): alvo de BINDEVENT - com PROTECTED falharia em
1017:     * SILENCIO (regra #3).
1018:     *--------------------------------------------------------------------------
1019:     PROCEDURE GrdFollowUpAfterRowColChange(par_nColIndex)
1020:         LOCAL loc_oErro
1021:         TRY
1022:             IF PEMSTATUS(THIS, "obj_4c_Memo_Obs", 5)
1023:                 THIS.obj_4c_Memo_Obs.Refresh()
1024:             ENDIF
1025:         CATCH TO loc_oErro
1026:             MsgErro(loc_oErro.Message + CHR(13) + ;
1027:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1028:                 "Procedure: " + loc_oErro.Procedure, ;
1029:                 "FormSigOpOch.GrdFollowUpAfterRowColChange")
1030:         ENDTRY
1031:     ENDPROC
1032: 
1033:     *--------------------------------------------------------------------------
1034:     * CarregarLista - Executa as DUAS consultas que o Init legado faz antes de
1035:     * a tela aparecer e repinta as grades:
1036:     *   Select * From SigMvCcr Where Nopers = <n> And Opers = '<o>'  -> ContaCC
1037:     *   Select * From SigCqOch Where Nopers = <n> Order by Datars,Datas -> Movi
1038:     *
1039:     * As duas consultas rodam SEMPRE, inclusive quando a primeira nao acha
1040:     * nada: o legado tambem nao condiciona uma a outra, e o historico de
1041:     * FollowUp depende so do Noper.
1042:     *
1043:     * Falha de consulta NAO impede a tela de abrir (igual ao legado, que nao
1044:     * testa o retorno do SqlExecute) - a mensagem tecnica do BO eh exibida e o
1045:     * usuario ve as grades vazias. MsgErro ja se suprime em modo de teste.
1046:     *
1047:     * PUBLIC (sem PROTECTED): o harness de teste automatizado chama
1048:     * oForm.CarregarLista() de FORA da classe (regra #3).
1049:     *--------------------------------------------------------------------------
1050:     PROCEDURE CarregarLista()
1051:         LOCAL loc_lSucesso, loc_oErro
1052:         loc_lSucesso = .F.
1053: 
1054:         TRY
1055:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1056:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
1057:                     "FormSigOpOch.CarregarLista")
1058:             ELSE
1059:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarContaCorrente()
1060: 
1061:                 IF !THIS.this_oBusinessObject.CarregarFollowUp()
1062:                     loc_lSucesso = .F.
1063:                 ENDIF
1064: 
1065:                 *-- Repinta as DUAS grades em TODO caminho de carga: popular o
1066:                 *-- cursor NAO repinta a grade sozinho (regra #21a) - sem isto
1067:                 *-- a tela fica visualmente vazia com os cursores cheios.
1068:                 THIS.AtualizarGrades()
1069: 
1070:                 IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro) ;
1071:                    AND !THIS.this_oBusinessObject.this_lErroExibido
1072:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1073:                         "Consulta de FollowUp")
1074:                 ENDIF
1075:             ENDIF
1076:         CATCH TO loc_oErro
1077:             MsgErro(loc_oErro.Message + CHR(13) + ;
1078:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1079:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.CarregarLista")
1080:         ENDTRY
1081: 
1082:         RETURN loc_lSucesso
1083:     ENDPROC
1084: 
1085:     *--------------------------------------------------------------------------
1086:     * AtualizarGrades - Posiciona os dois cursores no topo e repinta as duas
1087:     * grades. Equivale ao "Select ContaCc / Go Top" + ".Refresh" do Init
1088:     * legado.
1089:     *
1090:     * Metodo UNICO, chamado por TODO caminho que popula os cursores: encher o
1091:     * cursor nao faz a grade exibir as linhas, e o sintoma ("a tela nao traz
1092:     * dados") manda o diagnostico para SQL/permissao (regra #21a).
1093:     *
1094:     * NAO chamar deste metodo o AfterRowColChange da grade: o GO TOP daqui
1095:     * devolveria o cursor a PRIMEIRA linha a cada troca de linha, travando a
1096:     * navegacao do usuario no topo. O GrdFollowUpAfterRowColChange repinta so
1097:     * o obj_4c_Memo_Obs, sem mexer no ponteiro.
1098:     *
1099:     * PUBLIC: o harness de teste automatizado chama de FORA da classe.
1100:     *--------------------------------------------------------------------------
1101:     PROCEDURE AtualizarGrades()
1102:         LOCAL loc_oErro
1103:         TRY
1104:             IF USED("cursor_4c_ContaCc")
1105:                 GO TOP IN cursor_4c_ContaCc
1106:             ENDIF
1107:             IF USED("cursor_4c_FollowUp")
1108:                 GO TOP IN cursor_4c_FollowUp
1109:             ENDIF
1110: 
1111:             IF PEMSTATUS(THIS, "grd_4c_Lancamento", 5)
1112:                 THIS.grd_4c_Lancamento.Refresh()
1113:             ENDIF
1114:             IF PEMSTATUS(THIS, "grd_4c_FollowUp", 5)
1115:                 THIS.grd_4c_FollowUp.Refresh()
1116:             ENDIF
1117:             *-- Memo_Obs acompanha a linha corrente de cursor_4c_FollowUp -
1118:             *-- repintar junto, senao o 1o registro so aparece depois que o
1119:             *-- usuario mexe na grade (regra #21a)
1120:             IF PEMSTATUS(THIS, "obj_4c_Memo_Obs", 5)
1121:                 THIS.obj_4c_Memo_Obs.Refresh()
1122:             ENDIF
1123:         CATCH TO loc_oErro
1124:             MsgErro(loc_oErro.Message + CHR(13) + ;
1125:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1126:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.AtualizarGrades")
1127:         ENDTRY
1128:     ENDPROC
1129: 
1130:     *--------------------------------------------------------------------------
1131:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1132:     * (AddObject cria controles com Visible=.F. por padrao)
1133:     *--------------------------------------------------------------------------
1134:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1135:         LOCAL loc_i, loc_oControl, loc_oErro
1136:         TRY
1137:             FOR loc_i = 1 TO par_oContainer.ControlCount
1138:                 loc_oControl = par_oContainer.Controls(loc_i)
1139:                 IF VARTYPE(loc_oControl) = "O"
1140:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
1141:                         loc_oControl.Visible = .T.
1142:                     ENDIF
1143:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1144:                        loc_oControl.ControlCount > 0
1145:                         THIS.TornarControlesVisiveis(loc_oControl)
1146:                     ENDIF
1147:                 ENDIF
1148:             ENDFOR
1149:         CATCH TO loc_oErro
1150:             MsgErro(loc_oErro.Message + CHR(13) + ;
1151:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1152:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.TornarControlesVisiveis")
1153:         ENDTRY
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * Destroy - Equivalente ao PROCEDURE Release legado (ThisForm.poDataMgr.
1158:     * Release + DoDefault()). Fecha os cursores de trabalho criados pelo form
1159:     * (cursor_4c_ContaCc/cursor_4c_FollowUp, introduzidos na Fase 4 junto com
1160:     * os grids) antes de liberar o Business Object.
1161:     *
1162:     * DataSession=2 (privada): os cursores ja seriam destruidos junto com a
1163:     * sessao ao fechar o form, mas o USE IN explicito mantem o padrao do
1164:     * projeto e evita qualquer referencia solta durante o proprio Destroy.
1165:     *
1166:     * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
1167:     * os popups do menu principal depois de um form modal fechar.
1168:     *--------------------------------------------------------------------------
1169:     PROCEDURE Destroy()
1170:         LOCAL loc_oErro
1171: 
1172:         TRY
1173:             IF USED("cursor_4c_ContaCc")
1174:                 USE IN cursor_4c_ContaCc
1175:             ENDIF
1176:             IF USED("cursor_4c_FollowUp")
1177:                 USE IN cursor_4c_FollowUp
1178:             ENDIF
1179:         CATCH TO loc_oErro
1180:             MsgErro(loc_oErro.Message + CHR(13) + ;
1181:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1182:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.Destroy")
1183:         ENDTRY
1184: 
1185:         THIS.this_oBusinessObject = .NULL.
1186: 
1187:         DODEFAULT()
1188:     ENDPROC
1189: 
1190: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOchBO.prg):
*==============================================================================
* SigOpOchBO.prg - Business Object para SigOpOch (Consulta de FollowUp)
*
* Legado  : SIGOPOCH.SCX (task774) - dialogo MODAL "Consulta de FollowUp"
* Tabelas : SigMvCcr (leitura - lancamento de conta corrente sendo consultado)
*           SigCqOch (leitura - historico de FollowUp/auditoria do lancamento)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCH.Init recebe tres parametros (poForm, pnNoper, pcOper) do form que o
* abre (DO Form SigOpOch With <form pai>, <Nopers>, <Opers>) e executa, na
* sessao PRIVADA do proprio dialogo (DataSession = 2):
*   1) Select * From SigMvCcr Where Nopers = <pnNoper> And Opers = <pcOper>
*      Into cursor ContaCC - o lancamento de conta corrente que o usuario
*      selecionou no form pai (grd_lancamento espelha ContaCC: Datas, Hists,
*      Valors, Opers, Emps, Saldos - somente leitura, sem nenhuma gravacao);
*   2) Select * From SigCqOch Where Nopers = <pnNoper> Order by Datars,Datas
*      Into cursor Movi - TODO o historico de FollowUp daquele Noper (pode
*      ter varias linhas, uma por acao de auditoria/observacao registrada);
*   3) Select *, Padr(Nvl(ObsAudts,' '),50) as ObsAudt2 From Movi Into Cursor
*      Movimento - GridFollowUp espelha Movimento: Datars, TpLancs, Datas,
*      Usuars, ObsAudt2 (observacao truncada para a coluna da grade); o Memo
*      inferior (Memo_Obs) espelha Movimento.ObsAudts (texto completo, sem
*      truncar) da linha corrente da grade.
* O dialogo e PURAMENTE DE CONSULTA: nenhum metodo do SCX faz INSERT/UPDATE/
* DELETE. O unico botao (Sair) apenas libera o form (ThisForm.Release).
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* Os parametros pnNoper/pcOper chegam aqui como propriedades explicitas
* (this_nNopers/this_cOpers), preenchidas pelo Form a partir dos parametros
* recebidos no Init (equivalente funcional ao LParameters do legado). As
* duas consultas (Fase 2) vao para cursores SEPARADOS e nao destrutivos
* (cursor_4c_ContaCc / cursor_4c_FollowUp), e a 3a consulta do legado
* (Movimento = Movi + ObsAudt2 calculado) sera reproduzida como parte da
* mesma query de FollowUp (coluna ObsAudt2 calculada no proprio SELECT),
* evitando um 3o cursor so para acrescentar uma coluna derivada.
*
* As propriedades abaixo espelham os campos efetivamente referenciados no
* codigo fonte original (ControlSource das colunas dos dois grids + os dois
* parametros de filtro). NAO ha campo editavel nem gravacao: as propriedades
* this_cTabela/this_cCampoChave herdadas de BusinessBase ficam apontando
* para SigCqOch (a tabela do "FollowUp" que da nome ao dialogo), mas sem uso
* de Inserir/Atualizar/ExecutarExclusao nesta BO (consulta pura).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOchBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE FILTRO (pnNoper/pcOper do legado Init) - identificam o
    * lancamento de conta corrente cujo FollowUp esta sendo consultado
    *==========================================================================
    this_nNopers = 0    && numeric(7,0) - par_nNoper (filtro SigMvCcr.Nopers e SigCqOch.Nopers)
    this_cOpers  = ""   && char(1)      - par_cOper (filtro SigMvCcr.Opers - D/C)

    *==========================================================================
    * SigMvCcr (ContaCC) - lancamento de conta corrente exibido em
    * grd_lancamento (somente leitura, sem gravacao nesta tela)
    *==========================================================================
    this_dDatas  = {}   && datetime SigMvCcr.datas  - data do lancamento (Col_Data)
    this_cHists  = ""   && char(60) SigMvCcr.hists  - historico/descricao (Col_Hist)
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - valor do lancamento (Col_Valor)
    this_cEmps   = ""   && char(3)  SigMvCcr.emps   - empresa (Col_Emp)
    this_nSaldos = 0    && numeric(15,2) SigMvCcr.saldos - saldo apos o lancamento (Col_Saldo)

    *==========================================================================
    * SigCqOch (Movi/Movimento) - historico de FollowUp exibido em
    * GridFollowUp (multiplas linhas por Noper) + Memo_Obs (linha corrente)
    *==========================================================================
    this_dDatars   = {}   && datetime SigCqOch.datars  - data/hora do lancamento do FollowUp (Column1)
    this_cTpLancs  = ""   && char(15) SigCqOch.tplancs - tipo do lancamento de FollowUp (Column2)
    this_dDataLog  = {}   && datetime SigCqOch.datas   - data do registro de FollowUp (Column3)
    this_cUsuars   = ""   && char(10) SigCqOch.usuars  - usuario que registrou o FollowUp (Column4)
    this_cObsAudts = ""   && text SigCqOch.obsaudts    - observacao completa (Memo_Obs / Column5 truncada em ObsAudt2)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigCqOch" (a tabela de FollowUp que da nome ao
    * dialogo - "Consulta de FollowUp"); this_cCampoChave fica com o nome
    * convencional da PK de SigCqOch so para a nomenclatura herdada de
    * BusinessBase ter um valor coerente com o schema - esta BO NAO grava
    * nada (nenhum Inserir/Atualizar/ExecutarExclusao sera sobrescrito).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqOch")

            THIS.this_cTabela     = "SigCqOch"
            THIS.this_cCampoChave = "cidchaves"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarContaCorrente - busca o lancamento de conta corrente filtrado
    * por this_nNopers/this_cOpers. Equivale ao 1o Select do Init legado:
    *   Select * From SigMvCcr Where Nopers = <pnNoper> And Opers = <pcOper>
    *
    * SQLEXEC roda sobre um cursor TEMPORARIO (cursor_4c_ContaCcTmp) e o
    * resultado eh copiado para cursor_4c_ContaCc via ZAP + APPEND FROM
    * DBF() - SQLEXEC direto sobre o alias ligado ao grd_4c_Lancamento
    * zeraria o ColumnCount do grid (cursor_4c_ContaCc eh criado pelo Form
    * com os campos Datas T, Hists C(60), Valors N(11,2), Opers C(1),
    * Emps C(3), Saldos N(15,2), Concs N(1), DtAudits T - mesma lista de
    * colunas do SELECT abaixo; APPEND FROM DBF casa os campos por NOME, logo
    * nome a mais ou a menos entra em branco calado).
    *
    * Ao final, espelha a linha encontrada nas propriedades this_* via
    * CarregarDoCursor(), para o Form poder exibir Data/Historico/Valor/
    * Empresa/Saldo tambem fora do grid, se precisar.
    *==========================================================================
    PROCEDURE CarregarContaCorrente()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Concs e DtAudits NAO aparecem em coluna nenhuma da grade:
                *-- sao as duas colunas que o DynamicForeColor/DynamicBackColor
                *-- do Init legado le para colorir a linha (azul = conciliado,
                *-- verde claro = auditado). O legado faz Select * e por isso
                *-- as tinha de graca; aqui a lista eh explicita, entao elas
                *-- precisam constar ou as cores do legado se perdem em
                *-- silencio. CAST do bit para numeric(1,0) para o VFP receber
                *-- SEMPRE Numerico: bit chega ora Logico, ora Numerico
                *-- conforme o driver, e a expressao do grid compara com 1.
                loc_cSQL = "SELECT Datas, Hists, Valors, Opers, Emps, Saldos, " + ;
                           "CAST(concs AS numeric(1,0)) AS Concs, " + ;
                           "dtaudits AS DtAudits " + ;
                           "FROM SigMvCcr " + ;
                           "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ;
                           " AND Opers = " + EscaparSQL(THIS.this_cOpers)

                IF USED("cursor_4c_ContaCcTmp")
                    USE IN cursor_4c_ContaCcTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaCcTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_ContaCc")
                        SELECT cursor_4c_ContaCc
                        ZAP
                        APPEND FROM DBF("cursor_4c_ContaCcTmp")
                        IF RECCOUNT("cursor_4c_ContaCc") > 0
                            GO TOP IN cursor_4c_ContaCc
                            THIS.CarregarDoCursor("cursor_4c_ContaCc")
                        ENDIF
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar o lan" + CHR(231) + "amento de conta corrente." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_ContaCcTmp")
                    USE IN cursor_4c_ContaCcTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.CarregarContaCorrente")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFollowUp - busca TODO o historico de FollowUp (SigCqOch) do
    * lancamento filtrado por this_nNopers. Equivale as 2a e 3a consultas do
    * Init legado combinadas numa unica query (a 3a so acrescenta a coluna
    * derivada ObsAudt2, que o SQL Server ja calcula no proprio SELECT):
    *   Select * From SigCqOch Where Nopers = <pnNoper> Order by Datars,Datas
    *   Select *, Padr(Nvl(ObsAudts,' '),50) as ObsAudt2 From Movi
    *
    * Mesmo padrao de cursor temporario + ZAP/APPEND FROM DBF() de
    * CarregarContaCorrente, preservando o RecordSource do GridFollowUp
    * (cursor_4c_FollowUp, criado pelo Form com Datars T, TpLancs C(15),
    * Datas T, Usuars C(10), ObsAudts M, ObsAudt2 C(50)).
    *==========================================================================
    PROCEDURE CarregarFollowUp()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Datars, TpLancs, Datas, Usuars, " + ;
                           "CAST(obsaudts AS VARCHAR(MAX)) AS ObsAudts, " + ;
                           "LEFT(ISNULL(CAST(obsaudts AS VARCHAR(MAX)), ''), 50) AS ObsAudt2 " + ;
                           "FROM SigCqOch " + ;
                           "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ;
                           " ORDER BY Datars, Datas"

                IF USED("cursor_4c_FollowUpTmp")
                    USE IN cursor_4c_FollowUpTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FollowUpTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_FollowUp")
                        SELECT cursor_4c_FollowUp
                        ZAP
                        APPEND FROM DBF("cursor_4c_FollowUpTmp")
                        GO TOP IN cursor_4c_FollowUp
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar o hist" + CHR(243) + "rico de FollowUp." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_FollowUpTmp")
                    USE IN cursor_4c_FollowUpTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.CarregarFollowUp")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE do cursor informado para as
    * propriedades this_*. Usado (a) uma vez, logo depois de popular
    * cursor_4c_ContaCc em CarregarContaCorrente, e (b) a cada troca de linha
    * do GridFollowUp (equivalente ao AfterRowColChange do legado, que so
    * fazia ThisForm.Memo_Obs.Refresh - aqui quem alimenta o Memo_Obs eh
    * this_cObsAudts, lido da linha corrente de cursor_4c_FollowUp).
    *
    * Detecta qual dos dois cursores foi passado pelas colunas presentes
    * (TYPE() - PEMSTATUS exige OBJETO, nao serve para alias de cursor) e
    * mapeia so o bloco correspondente.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                IF TYPE(par_cAliasCursor + ".Hists") != "U"
                    *-- Linha de cursor_4c_ContaCc (SigMvCcr)
                    THIS.this_dDatas  = ConverterParaData(Datas)
                    THIS.this_cHists  = TratarNulo(Hists, "")
                    THIS.this_nValors = TratarNulo(Valors, 0)
                    THIS.this_cEmps   = TratarNulo(Emps, "")
                    THIS.this_nSaldos = TratarNulo(Saldos, 0)
                ENDIF

                IF TYPE(par_cAliasCursor + ".TpLancs") != "U"
                    *-- Linha de cursor_4c_FollowUp (SigCqOch)
                    THIS.this_dDatars   = ConverterParaData(Datars)
                    THIS.this_cTpLancs  = TratarNulo(TpLancs, "")
                    THIS.this_dDataLog  = ConverterParaData(Datas)
                    THIS.this_cUsuars   = TratarNulo(Usuars, "")
                    THIS.this_cObsAudts = TratarNulo(ObsAudts, "")
                ENDIF
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - nao ha PK de registro unico editavel nesta tela
    * (dialogo de consulta, sem Inserir/Atualizar/Excluir). A "chave" do
    * dialogo eh o proprio par Nopers+Opers usado para filtrar as consultas.
    * Sobrescrito apenas para o contrato de BusinessBase; este BO nunca
    * chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNopers, 7)) + THIS.this_cOpers
    ENDPROC

    *==========================================================================
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O dialogo SIGOPOCH e PURAMENTE DE CONSULTA (o unico botao, Sair, apenas
    * libera o form com ThisForm.Release - nao ha INSERT/UPDATE/DELETE em
    * lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults herdados de BusinessBase permanecem validos,
    * pois Salvar()/Excluir() jamais sao chamados por este BO/Form.
    *==========================================================================

ENDDEFINE

