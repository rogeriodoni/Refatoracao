# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTBI.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (924 linhas total):

*-- Linhas 40 a 137:
40:     this_nPaginaAtual = 1
41: 
42:     *==========================================================================
43:     PROCEDURE Init()
44:     *==========================================================================
45:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
46:         RETURN DODEFAULT()
47:     ENDPROC
48: 
49:     *==========================================================================
50:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
51:     *==========================================================================
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lSucesso, loc_lConexaoOk, loc_oErro
54:         loc_lSucesso   = .F.
55:         loc_lConexaoOk = .T.
56: 
57:         TRY
58:             THIS.this_oBusinessObject = CREATEOBJECT("TBIBO")
59: 
60:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                 IF gnConnHandle <= 0
62:                     loc_lConexaoOk = .F.
63:                 ENDIF
64:             ENDIF
65: 
66:             IF loc_lConexaoOk
67:                 THIS.ConfigurarPageFrame()
68:                 THIS.ConfigurarPaginaLista()
69:                 THIS.LimparCampos()
70:                 THIS.TornarControlesVisiveis()
71:                 THIS.AlternarPagina(1)
72:                 loc_lSucesso = .T.
73:             ENDIF
74: 
75:         CATCH TO loc_oErro
76:             MsgErro(loc_oErro.Message + CHR(13) + ;
77:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
78:                 "Procedure: " + loc_oErro.Procedure, ;
79:                 "Erro InicializarForm")
80:         ENDTRY
81: 
82:         IF !loc_lConexaoOk
83:             MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
84:                     "o Com o Servidor de Banco de Dados...", ;
85:                     "Conex" + CHR(227) + "o")
86:         ENDIF
87: 
88:         RETURN loc_lSucesso
89:     ENDPROC
90: 
91:     *==========================================================================
92:     * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form
93:     * Forms OPERACIONAIS deste tipo (dialogo utilitario, sem Lista/Dados) nao
94:     * usam PageFrame CRUD - o cabecalho e um container direto no form,
95:     * equivalente ao cntSombra do framework legado (ver mapeamento.json)
96:     *==========================================================================
97:     PROTECTED PROCEDURE ConfigurarPageFrame()
98:         LOCAL loc_oErro
99: 
100:         TRY
101:             THIS.AddObject("cnt_4c_Sombra", "Container")
102:             WITH THIS.cnt_4c_Sombra
103:                 .Top         = 0
104:                 .Left        = 0
105:                 .Width       = THIS.Width
106:                 .Height      = 80
107:                 .BackColor   = RGB(100, 100, 100)
108:                 .BackStyle   = 1
109:                 .BorderWidth = 0
110: 
111:                 .AddObject("lbl_4c_LblSombra", "Label")
112:                 WITH .lbl_4c_LblSombra
113:                     .Top       = 18
114:                     .Left      = 10
115:                     .Width     = THIS.Width
116:                     .Height    = 40
117:                     .FontBold  = .T.
118:                     .FontName  = "Tahoma"
119:                     .FontSize  = 12
120:                     .AutoSize  = .F.
121:                     .BackStyle = 0
122:                     .WordWrap  = .T.
123:                     .Alignment = 0
124:                     .ForeColor = RGB(0, 0, 0)
125:                     .Caption   = "Tabelas de Refer" + CHR(234) + "ncia"
126:                 ENDWITH
127: 
128:                 .AddObject("lbl_4c_LblTitulo", "Label")
129:                 WITH .lbl_4c_LblTitulo
130:                     .Top       = 17
131:                     .Left      = 10
132:                     .Width     = THIS.Width
133:                     .Height    = 46
134:                     .FontBold  = .T.
135:                     .FontName  = "Tahoma"
136:                     .FontSize  = 12
137:                     .AutoSize  = .F.

*-- Linhas 148 a 331:
148:         CATCH TO loc_oErro
149:             MsgErro(loc_oErro.Message + CHR(13) + ;
150:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
151:                 "Procedure: " + loc_oErro.Procedure, ;
152:                 "Erro ConfigurarPageFrame")
153:         ENDTRY
154:     ENDPROC
155: 
156:     *==========================================================================
157:     * ConfigurarPaginaLista - Constroi a UNICA pagina util do formulario
158:     * (painel de parametros de impressao) e fixa a ordem de tabulacao.
159:     *
160:     * NOTA DE ARQUITETURA (por que nao ha Grid nem botoes CRUD aqui):
161:     * SIGCDTBI e um dialogo utilitario de IMPRESSAO (284 x 197), nao um
162:     * cadastro. O SCX original tem exatamente 10 objetos (cntSombra +
163:     * 2 labels de titulo, shp_relatorio, lbl_moeda, get_moeda_desc,
164:     * get_moeda, lbl_copias, get_copias e o commandgroup cmd_grupo com
165:     * cmd_ok / cmd_cancela) - NAO existe Grid, NAO existe lista de
166:     * registros e NAO existem os botoes Incluir/Alterar/Excluir/Buscar.
167:     * Acrescentar um grid ou uma barra CRUD aqui violaria o PILAR 1
168:     * (UX identica ao legado) e nao teria origem no formulario original.
169:     * Este metodo concentra, portanto, a montagem da unica pagina existente.
170:     *
171:     * ORDEM DE TABULACAO: o SCX original declara os TabIndex
172:     *       get_moeda = 2  ->  get_moeda_desc = 3  ->  get_copias = 5
173:     *       ->  cmd_grupo = 28
174:     * (lbl_moeda = 4 e lbl_copias = 6 sao Labels e nao recebem foco).
175:     * Ou seja, o foco inicial cai no CODIGO da moeda; a DESCRICAO vem em
176:     * seguida e so aceita digitacao enquanto o codigo estiver vazio - ver o
177:     * When de get_moeda_desc, reproduzido em AlternarPagina. Como o
178:     * AddObject desta migracao nao garante essa sequencia, o TabIndex e
179:     * fixado explicitamente, preservando a ordem RELATIVA do original.
180:     *==========================================================================
181:     PROTECTED PROCEDURE ConfigurarPaginaLista()
182:         LOCAL loc_oErro
183: 
184:         TRY
185:             *-- 1. Moldura + campos de entrada (moeda, descricao, copias)
186:             THIS.ConfigurarPaginaDados()
187: 
188:             *-- 2. CommandGroup com Confirma / Encerrar (cmd_grupo)
189:             THIS.ConfigurarBotoes()
190: 
191:             *-- 3. Ordem de tabulacao IDENTICA a do SCX original
192:             THIS.txt_4c__moeda.TabIndex      = 1
193:             THIS.txt_4c__moeda_desc.TabIndex = 2
194:             THIS.txt_4c__copias.TabIndex     = 3
195:             THIS.obj_4c_Cmd_grupo.TabIndex   = 4
196: 
197:         CATCH TO loc_oErro
198:             MsgErro(loc_oErro.Message + CHR(13) + ;
199:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
200:                 "Procedure: " + loc_oErro.Procedure, ;
201:                 "Erro ConfigurarPaginaLista")
202:         ENDTRY
203:     ENDPROC
204: 
205:     *==========================================================================
206:     * AlternarPagina - Aplica as regras de estado dos controles do painel.
207:     *
208:     * Como o formulario tem uma unica pagina fisica, "pagina" aqui e o
209:     * ESTADO do dialogo, exatamente como no legado:
210:     *   1 = ENTRADA    - usuario informa moeda / copias (estado normal)
211:     *   2 = IMPRESSAO  - cmd_ok.Click em execucao (monta os cursores,
212:     *                    envia para a impressora); enquanto isso os campos
213:     *                    ficam bloqueados para nao serem alterados no meio
214:     *                    da geracao.
215:     *
216:     * Alem do bloqueio por estado, este metodo reproduz o When de
217:     * get_moeda_desc do original:
218:     *       Return Empty(ThisForm.get_moeda.Value)
219:     * ou seja, a descricao so aceita digitacao enquanto o CODIGO da moeda
220:     * estiver vazio. Usa-se ReadOnly (e nao Enabled) para nao alterar a
221:     * aparencia do controle - o When do legado tambem nao o deixa cinza.
222:     * Por isso AlternarPagina(1) e re-executado sempre que o par
223:     * codigo/descricao muda (ValidarMoeda / ValidarMoedaDesc).
224:     *==========================================================================
225:     PROCEDURE AlternarPagina(par_nPagina)
226:         LOCAL loc_nPagina
227: 
228:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2), ;
229:                           par_nPagina, 1)
230: 
231:         THIS.this_nPaginaAtual = loc_nPagina
232: 
233:         *-- Sincroniza o estado dos campos com a pagina/modo atual
234:         THIS.AjustarBotoesPorModo()
235: 
236:         *-- O foco inicial e dado pelo TabIndex fixado em ConfigurarPaginaLista
237:         *-- (codigo da moeda = 1). Nenhum SetFocus e emitido aqui: como este metodo e
238:         *-- reexecutado dentro dos KeyPress de validacao, um SetFocus prenderia
239:         *-- o cursor no campo recem-validado e impediria o Tab para Copias.
240:     ENDPROC
241: 
242:     *==========================================================================
243:     * AjustarBotoesPorModo - Sincroniza o estado (habilitado/bloqueado) dos
244:     * campos de entrada com THIS.this_nPaginaAtual.
245:     *
246:     * Este dialogo NAO tem botoes CRUD (apenas Confirma/Encerrar, que ficam
247:     * SEMPRE habilitados - o CommandGroup nao e afetado pelo estado da
248:     * pagina) - o nome do metodo e mantido pelo padrao arquitetural do
249:     * FormBase (contrato chamado por AlternarPagina), mas aqui ele apenas
250:     * delega para HabilitarCampos().
251:     *==========================================================================
252:     PROTECTED PROCEDURE AjustarBotoesPorModo()
253:         THIS.HabilitarCampos(THIS.this_nPaginaAtual = 1)
254:     ENDPROC
255: 
256:     *==========================================================================
257:     * HabilitarCampos - Aplica o bloqueio/desbloqueio dos campos de entrada
258:     * (codigo da moeda, descricao da moeda, copias) conforme par_lHabilitar.
259:     *
260:     * Reproduz, alem do bloqueio geral, o When original de get_moeda_desc:
261:     *       Return Empty(ThisForm.get_moeda.Value)
262:     * ou seja, mesmo com par_lHabilitar = .T., a descricao so aceita
263:     * digitacao enquanto o CODIGO da moeda estiver vazio.
264:     *==========================================================================
265:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
266:         LOCAL loc_lHabilitar, loc_lCodigoVazio
267: 
268:         loc_lHabilitar   = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
269:         loc_lCodigoVazio = EMPTY(ALLTRIM(THIS.txt_4c__moeda.Value))
270: 
271:         *-- Codigo da moeda e quantidade de copias: editaveis apenas quando habilitado
272:         THIS.txt_4c__moeda.ReadOnly  = !loc_lHabilitar
273:         THIS.txt_4c__copias.ReadOnly = !loc_lHabilitar
274: 
275:         *-- Descricao da moeda: When original = Empty(get_moeda.Value)
276:         THIS.txt_4c__moeda_desc.ReadOnly = !(loc_lHabilitar AND loc_lCodigoVazio)
277:     ENDPROC
278: 
279:     *==========================================================================
280:     * ConfigurarPaginaDados - Cria os campos de ENTRADA DE DADOS do dialogo
281:     * (moeda de referencia + descricao + quantidade de copias) dentro da
282:     * moldura shp_relatorio, diretamente sobre o form.
283:     *
284:     * NOTA DE ARQUITETURA: forms OPERACIONAIS deste tipo nao tem PageFrame
285:     * e portanto nao seguem o padrao Page1=Lista/Page2=Dados do CRUD - nao
286:     * existe uma "Page2" fisica a configurar. Este metodo concentra o que,
287:     * num form CRUD, seria a pagina de Dados: TODOS os campos editaveis do
288:     * formulario. Layout e posicoes EXATOS do original (ver layout.json /
289:     * SIGCDTBI_form_codigo_fonte.txt).
290:     *==========================================================================
291:     PROTECTED PROCEDURE ConfigurarPaginaDados()
292:         LOCAL loc_oErro
293: 
294:         TRY
295:             *-- Moldura ao redor dos campos (shp_relatorio no original)
296:             THIS.AddObject("shp_4c_Shp_relatorio", "Shape")
297:             WITH THIS.shp_4c_Shp_relatorio
298:                 .Top          = 85
299:                 .Left         = 32
300:                 .Width        = 219
301:                 .Height       = 63
302:                 .BackStyle    = 0
303:                 .BorderStyle  = 6
304:                 .FillStyle    = 1
305:                 .SpecialEffect = 0
306:                 .ColorScheme  = 1
307:                 .BackColor    = RGB(192, 192, 192)
308:                 .Visible      = .T.
309:             ENDWITH
310: 
311:             *-- Label "Moeda  :"
312:             THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
313:             WITH THIS.lbl_4c_Lbl_moeda
314:                 .Top      = 99
315:                 .Left     = 39
316:                 .AutoSize = .T.
317:                 .BackStyle = 0
318:                 .FontName = "Verdana"
319:                 .FontSize = 8
320:                 .Caption  = "Moeda  :"
321:                 .Visible  = .T.
322:             ENDWITH
323: 
324:             *-- TextBox do codigo da moeda de referencia (get_moeda)
325:             THIS.AddObject("txt_4c__moeda", "TextBox")
326:             WITH THIS.txt_4c__moeda
327:                 .Top           = 94
328:                 .Left          = 91
329:                 .Width         = 31
330:                 .Height        = 23
331:                 .FontName      = "Courier New"

*-- Linhas 396 a 616:
396:             ENDWITH
397: 
398:             *-- Lookup de moeda: dispara em ENTER(13)/TAB(9)/F4(115)
399:             BINDEVENT(THIS.txt_4c__moeda, "KeyPress", THIS, "ValidarMoeda")
400:             BINDEVENT(THIS.txt_4c__moeda_desc, "KeyPress", THIS, "ValidarMoedaDesc")
401: 
402:         CATCH TO loc_oErro
403:             MsgErro(loc_oErro.Message + CHR(13) + ;
404:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
405:                 "Procedure: " + loc_oErro.Procedure, ;
406:                 "Erro ConfigurarPaginaDados")
407:         ENDTRY
408:     ENDPROC
409: 
410:     *==========================================================================
411:     * FormParaBO - Transfere os campos do dialogo (moeda, descricao, copias)
412:     * para o Business Object. Chamado antes de gerar/pre-visualizar a tabela
413:     * de referencia (BtnConfirmarClick/BtnVisualizarClick).
414:     *==========================================================================
415:     PROTECTED PROCEDURE FormParaBO()
416:         THIS.this_oBusinessObject.this_cMoeda          = ALLTRIM(THIS.txt_4c__moeda.Value)
417:         THIS.this_oBusinessObject.this_cMoedaDescricao = ALLTRIM(THIS.txt_4c__moeda_desc.Value)
418:         THIS.this_oBusinessObject.this_nCopias         = THIS.txt_4c__copias.Value
419:     ENDPROC
420: 
421:     *==========================================================================
422:     * BOParaForm - Transfere os campos do Business Object para o dialogo
423:     * (sentido inverso de FormParaBO). Usado por LimparCampos() para refletir
424:     * o estado inicial/limpo do BO nos controles do form.
425:     *==========================================================================
426:     PROTECTED PROCEDURE BOParaForm()
427:         THIS.txt_4c__moeda.Value      = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMoeda, ""))
428:         THIS.txt_4c__moeda_desc.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMoedaDescricao, ""))
429:         THIS.txt_4c__copias.Value     = IIF(NVL(THIS.this_oBusinessObject.this_nCopias, 0) > 0, ;
430:                                              THIS.this_oBusinessObject.this_nCopias, 1)
431:     ENDPROC
432: 
433:     *==========================================================================
434:     * LimparCampos - Restaura o BO e os campos do dialogo ao estado inicial
435:     * (moeda/descricao vazias, 1 copia), espelhando o Init original
436:     * (.get_moeda.Value = '' / .get_moeda_desc.Value = '' / .get_copias.Value = 1).
437:     *==========================================================================
438:     PROTECTED PROCEDURE LimparCampos()
439:         THIS.this_oBusinessObject.this_cMoeda          = ""
440:         THIS.this_oBusinessObject.this_cMoedaDescricao = ""
441:         THIS.this_oBusinessObject.this_nCopias         = 1
442: 
443:         THIS.BOParaForm()
444:     ENDPROC
445: 
446:     *==========================================================================
447:     * CarregarLista - Este dialogo NAO tem Grid/lista de registros (ver nota
448:     * de arquitetura em ConfigurarPaginaLista) - metodo mantido apenas para
449:     * cumprir o contrato de nomenclatura do FormBase; nunca e chamado
450:     * internamente. Nao ha nada a carregar.
451:     *==========================================================================
452:     PROCEDURE CarregarLista()
453:         RETURN .T.
454:     ENDPROC
455: 
456:     *==========================================================================
457:     * ValidarMoeda - KeyPress do txt_4c__moeda (get_moeda). Valida o codigo
458:     * digitado contra SigCdMoe; se nao achar, abre o lookup (AbrirBuscaMoeda)
459:     * - espelha o Valid original de get_moeda (fwBuscaExt por CMoes).
460:     *==========================================================================
461:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
462:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
463: 
464:         IF !INLIST(par_nKeyCode, 13, 9, 115)
465:             RETURN
466:         ENDIF
467: 
468:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__moeda.Value))
469: 
470:         IF EMPTY(loc_cValor)
471:             THIS.txt_4c__moeda.Value      = ""
472:             THIS.txt_4c__moeda_desc.Value = ""
473:             RETURN
474:         ENDIF
475: 
476:         IF USED("cursor_4c_TbiLkpMoeda")
477:             USE IN cursor_4c_TbiLkpMoeda
478:         ENDIF
479: 
480:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
481:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiLkpMoeda")
482: 
483:         IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda") AND ;
484:            RECCOUNT("cursor_4c_TbiLkpMoeda") > 0
485:             THIS.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_TbiLkpMoeda.cmoes)
486:             THIS.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_TbiLkpMoeda.dmoes)
487:             USE IN cursor_4c_TbiLkpMoeda
488:         ELSE
489:             IF USED("cursor_4c_TbiLkpMoeda")
490:                 USE IN cursor_4c_TbiLkpMoeda
491:             ENDIF
492:             THIS.AbrirBuscaMoeda(loc_cValor)
493:         ENDIF
494: 
495:         *-- Reaplica a regra do When original (descricao editavel so com codigo vazio)
496:         THIS.AlternarPagina(1)
497: 
498:         THIS.txt_4c__moeda.Refresh()
499:         THIS.txt_4c__moeda_desc.Refresh()
500:     ENDPROC
501: 
502:     *==========================================================================
503:     * ValidarMoedaDesc - KeyPress do txt_4c__moeda_desc (get_moeda_desc).
504:     * Valida a descricao digitada contra SigCdMoe; se nao achar, abre o
505:     * lookup - espelha o Valid original de get_moeda_desc (fwBuscaExt por
506:     * DMoes).
507:     *==========================================================================
508:     PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
509:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
510: 
511:         IF !INLIST(par_nKeyCode, 13, 9, 115)
512:             RETURN
513:         ENDIF
514: 
515:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__moeda_desc.Value))
516: 
517:         IF EMPTY(loc_cValor)
518:             THIS.txt_4c__moeda.Value      = ""
519:             THIS.txt_4c__moeda_desc.Value = ""
520:             RETURN
521:         ENDIF
522: 
523:         IF USED("cursor_4c_TbiLkpMoeda")
524:             USE IN cursor_4c_TbiLkpMoeda
525:         ENDIF
526: 
527:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
528:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiLkpMoeda")
529: 
530:         IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda")
531:             SELECT cursor_4c_TbiLkpMoeda
532:             LOCATE FOR ALLTRIM(UPPER(dmoes)) == loc_cValor
533:         ENDIF
534: 
535:         IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda") AND ;
536:            FOUND("cursor_4c_TbiLkpMoeda")
537:             THIS.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_TbiLkpMoeda.cmoes)
538:             THIS.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_TbiLkpMoeda.dmoes)
539:             USE IN cursor_4c_TbiLkpMoeda
540:         ELSE
541:             IF USED("cursor_4c_TbiLkpMoeda")
542:                 USE IN cursor_4c_TbiLkpMoeda
543:             ENDIF
544:             THIS.AbrirBuscaMoeda(loc_cValor)
545:         ENDIF
546: 
547:         *-- Reaplica a regra do When original (descricao editavel so com codigo vazio)
548:         THIS.AlternarPagina(1)
549: 
550:         THIS.txt_4c__moeda.Refresh()
551:         THIS.txt_4c__moeda_desc.Refresh()
552:     ENDPROC
553: 
554:     *==========================================================================
555:     * AbrirBuscaMoeda - Abre o picker canonico (FormBuscaAuxiliar Pattern A)
556:     * filtrado pelo valor digitado (codigo OU descricao), preenchendo
557:     * txt_4c__moeda/txt_4c__moeda_desc com a selecao do usuario.
558:     *==========================================================================
559:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValorDigitado)
560:         LOCAL loc_lSelecionou
561: 
562:         loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
563:             "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValorDigitado, ;
564:             THIS.txt_4c__moeda, THIS.txt_4c__moeda_desc)
565: 
566:         IF !loc_lSelecionou
567:             THIS.txt_4c__moeda.Value      = ""
568:             THIS.txt_4c__moeda_desc.Value = ""
569:         ENDIF
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * ConfigurarBotoes - Cria o CommandGroup com os 2 botoes do dialogo
574:     * (Confirma / Encerrar), espelhando cmd_grupo do original.
575:     *==========================================================================
576:     PROTECTED PROCEDURE ConfigurarBotoes()
577:         LOCAL loc_oErro
578: 
579:         TRY
580:             THIS.AddObject("obj_4c_Cmd_grupo", "CommandGroup")
581:             WITH THIS.obj_4c_Cmd_grupo
582:                 .Top          = -2
583:                 .Left         = 123
584:                 .Width        = 172
585:                 .Height       = 110
586:                 .ButtonCount  = 2
587:                 .BackStyle    = 0
588:                 .BorderStyle  = 0
589:                 .SpecialEffect = 1
590:                 .BorderColor  = RGB(100, 100, 100)
591:                 .Themes       = .F.
592:                 .Value        = 1
593: 
594:                 WITH .Buttons(1)
595:                     .Top        = 5
596:                     .Left       = 11
597:                     .Width      = 75
598:                     .Height     = 75
599:                     .FontBold   = .T.
600:                     .FontItalic = .T.
601:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
602:                     .Caption    = "Confirma"
603:                     .ForeColor  = RGB(90, 90, 90)
604:                     .BackColor  = RGB(255, 255, 255)
605:                     .Themes     = .F.
606:                 ENDWITH
607: 
608:                 WITH .Buttons(2)
609:                     .Top          = 5
610:                     .Left         = 86
611:                     .Width        = 75
612:                     .Height       = 75
613:                     .Cancel       = .T.
614:                     .FontBold     = .T.
615:                     .FontItalic   = .T.
616:                     .FontName     = "Tahoma"

*-- Linhas 626 a 924:
626:                 .Visible = .T.
627:             ENDWITH
628: 
629:             BINDEVENT(THIS.obj_4c_Cmd_grupo.Buttons(1), "Click", THIS, "BtnConfirmarClick")
630:             BINDEVENT(THIS.obj_4c_Cmd_grupo.Buttons(2), "Click", THIS, "BtnEncerrarClick")
631: 
632:         CATCH TO loc_oErro
633:             MsgErro(loc_oErro.Message + CHR(13) + ;
634:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
635:                 "Procedure: " + loc_oErro.Procedure, ;
636:                 "Erro ConfigurarBotoes")
637:         ENDTRY
638:     ENDPROC
639: 
640:     *==========================================================================
641:     * BtnConfirmarClick - Valida moeda/copias, monta e imprime a tabela de
642:     * cambio (THIS.this_oBusinessObject.GerarTabelaReferencia), espelhando
643:     * cmd_ok.Click do original (sem a selecao de impressora de etiqueta
644:     * legada - imprime na impressora padrao do Windows).
645:     *==========================================================================
646:     PROCEDURE BtnConfirmarClick()
647:         LOCAL loc_cMoeda, loc_nCopias, loc_lSucesso, loc_nCopiaAtual, loc_oErro
648: 
649:         loc_cMoeda  = ALLTRIM(THIS.txt_4c__moeda.Value)
650:         loc_nCopias = THIS.txt_4c__copias.Value
651:         loc_lSucesso = .F.
652: 
653:         IF EMPTY(loc_cMoeda)
654:             MsgAviso("Moeda inv" + CHR(225) + "lida !", "Aten" + CHR(231) + CHR(227) + "o")
655:             THIS.txt_4c__moeda.SetFocus()
656:             RETURN
657:         ENDIF
658: 
659:         IF loc_nCopias < 1
660:             MsgAviso("Quantidade de c" + CHR(243) + "pias inv" + CHR(225) + "lida !", ;
661:                 "Aten" + CHR(231) + CHR(227) + "o")
662:             THIS.txt_4c__copias.SetFocus()
663:             RETURN
664:         ENDIF
665: 
666:         IF !MsgConfirma("Confirma impress" + CHR(227) + "o das tabelas de " + ;
667:                 "refer" + CHR(234) + "ncia ?", "Confirma" + CHR(231) + CHR(227) + "o")
668:             RETURN
669:         ENDIF
670: 
671:         THIS.FormParaBO()
672: 
673:         *-- Bloqueia os parametros enquanto os cursores sao montados e o
674:         *-- conteudo e enviado para a impressora
675:         THIS.AlternarPagina(2)
676: 
677:         TRY
678:             IF THIS.this_oBusinessObject.GerarTabelaReferencia(loc_cMoeda)
679:                 SET PRINTER TO DEFAULT
680:                 SET DEVICE TO PRINTER
681:                 FOR loc_nCopiaAtual = 1 TO loc_nCopias
682:                     ?? THIS.this_oBusinessObject.this_cConteudoRelatorio
683:                     ?? CHR(12)
684:                 ENDFOR
685:                 SET DEVICE TO SCREEN
686:                 SET PRINTER TO DEFAULT
687:                 loc_lSucesso = .T.
688:             ELSE
689:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
690:                     "Tabelas de Refer" + CHR(234) + "ncia")
691:             ENDIF
692:         CATCH TO loc_oErro
693:             SET DEVICE TO SCREEN
694:             SET PRINTER TO DEFAULT
695:             MsgErro(loc_oErro.Message + CHR(13) + ;
696:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
697:                 "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
698:         ENDTRY
699: 
700:         IF loc_lSucesso
701:             *-- Como no cmd_ok.Click original, o dialogo se encerra apos imprimir
702:             THIS.Release()
703:         ELSE
704:             *-- Falhou: devolve o painel ao estado de entrada para nova tentativa
705:             THIS.AlternarPagina(1)
706:         ENDIF
707:     ENDPROC
708: 
709:     *==========================================================================
710:     * BtnEncerrarClick - Fecha o dialogo sem imprimir (cmd_cancela.Click).
711:     *==========================================================================
712:     PROCEDURE BtnEncerrarClick()
713:         THIS.Release()
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * BtnSalvarClick / BtnCancelarClick - Aliases pelo contrato de nomenclatura
718:     * do FormBase. Neste dialogo, "Salvar" e "Cancelar" SAO, respectivamente,
719:     * o Confirma (cmd_ok - gera e imprime a tabela) e o Encerrar (cmd_cancela)
720:     * ja implementados acima - por isso apenas delegam, sem duplicar logica.
721:     *==========================================================================
722:     PROCEDURE BtnSalvarClick()
723:         THIS.BtnConfirmarClick()
724:     ENDPROC
725: 
726:     PROCEDURE BtnCancelarClick()
727:         THIS.BtnEncerrarClick()
728:     ENDPROC
729: 
730:     *==========================================================================
731:     * EVENTOS PRINCIPAIS (contrato de eventos do FormBase)
732:     *
733:     * NOTA DE ARQUITETURA - por que Incluir/Alterar/Excluir sao BLOQUEIOS e
734:     * nao operacoes de gravacao:
735:     *
736:     * SIGCDTBI ("Relatorio de Tabelas de Referencia") e um dialogo utilitario
737:     * de IMPRESSAO (284 x 197). O SCX original tem 10 objetos e UM UNICO
738:     * CommandGroup (cmd_grupo) com apenas cmd_ok (Confirma) e cmd_cancela
739:     * (Encerrar) - nao ha Grid, nao ha lista de registros e nao existem os
740:     * botoes Incluir/Alterar/Excluir/Buscar. Em nenhum ponto do codigo fonte
741:     * legado (Load, Init, os dois Valid, cmd_ok.Click, cmd_cancela.Click) ha
742:     * INSERT, UPDATE ou DELETE: o formulario apenas LE e VALIDA um codigo de
743:     * moeda ja existente em SigCdMoe para montar a tabela de cambio impressa.
744:     * A manutencao de SigCdMoe pertence exclusivamente ao Cadastro de Moedas
745:     * (FormMoe / MoeBO).
746:     *
747:     * Portanto NAO se acrescenta aqui nenhum botao CRUD: isso inventaria
748:     * funcionalidade inexistente no legado e violaria o PILAR 1 (UX identica
749:     * ao original). Os handlers abaixo existem para cumprir o contrato de
750:     * eventos do FormBase e para GARANTIR, com mensagem clara e estado
751:     * consistente, que uma chamada externa (menu, tecla de atalho herdada ou
752:     * codigo futuro) nao tente gravar por este formulario. Sao o espelho, na
753:     * camada de UI, dos overrides TBIBO.Inserir() / TBIBO.Atualizar(), que ja
754:     * bloqueiam a gravacao na camada de negocio retornando .F. com
755:     * this_cMensagemErro preenchido.
756:     *==========================================================================
757: 
758:     *==========================================================================
759:     * BtnIncluirClick - Bloqueia inclusao de moeda por este formulario.
760:     * Espelha o override TBIBO.Inserir() (que retorna .F.).
761:     *==========================================================================
762:     PROCEDURE BtnIncluirClick()
763:         THIS.this_cModoAtual = "LISTA"
764: 
765:         MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o cadastra moedas." + ;
766:             CHR(13) + "Utilize o Cadastro de Moedas para incluir novos registros.", ;
767:             "Tabelas de Refer" + CHR(234) + "ncia")
768: 
769:         *-- Devolve o dialogo ao estado de entrada e o foco ao codigo da moeda
770:         THIS.AlternarPagina(1)
771:         THIS.txt_4c__moeda.SetFocus()
772:     ENDPROC
773: 
774:     *==========================================================================
775:     * BtnAlterarClick - Bloqueia alteracao de moeda por este formulario.
776:     * Espelha o override TBIBO.Atualizar() (que retorna .F.).
777:     *==========================================================================
778:     PROCEDURE BtnAlterarClick()
779:         THIS.this_cModoAtual = "LISTA"
780: 
781:         MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o cadastra moedas." + ;
782:             CHR(13) + "Utilize o Cadastro de Moedas para alterar registros existentes.", ;
783:             "Tabelas de Refer" + CHR(234) + "ncia")
784: 
785:         THIS.AlternarPagina(1)
786:         THIS.txt_4c__moeda.SetFocus()
787:     ENDPROC
788: 
789:     *==========================================================================
790:     * BtnExcluirClick - Bloqueia exclusao de moeda por este formulario.
791:     * O legado nunca apaga SigCdMoe a partir de SIGCDTBI; excluir a moeda
792:     * usada como referencia aqui quebraria as cotacoes (SigCdCot) e as
793:     * tabelas de desconto (SigOpTdz) de todo o sistema.
794:     *==========================================================================
795:     PROCEDURE BtnExcluirClick()
796:         THIS.this_cModoAtual = "LISTA"
797: 
798:         MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o exclui moedas." + ;
799:             CHR(13) + "Utilize o Cadastro de Moedas para excluir registros.", ;
800:             "Tabelas de Refer" + CHR(234) + "ncia")
801: 
802:         THIS.AlternarPagina(1)
803:         THIS.txt_4c__moeda.SetFocus()
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * BtnBuscarClick - Bloqueia busca/consulta de moeda por este formulario.
808:     * O SCX original nao tem Grid nem lista de registros (ver nota de
809:     * arquitetura em ConfigurarPaginaLista) - a consulta de moedas
810:     * cadastradas pertence ao Cadastro de Moedas.
811:     *==========================================================================
812:     PROCEDURE BtnBuscarClick()
813:         THIS.this_cModoAtual = "LISTA"
814: 
815:         MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o consulta moedas." + ;
816:             CHR(13) + "Utilize o Cadastro de Moedas para consultar registros existentes.", ;
817:             "Tabelas de Refer" + CHR(234) + "ncia")
818: 
819:         THIS.AlternarPagina(1)
820:         THIS.txt_4c__moeda.SetFocus()
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * BtnVisualizarClick - Pre-visualiza, na tela, EXATAMENTE o conteudo que
825:     * BtnConfirmarClick enviaria para a impressora.
826:     *
827:     * Reaproveita integralmente a regra de negocio ja migrada do cmd_ok.Click
828:     * original (TBIBO.GerarTabelaReferencia): mesmas validacoes de moeda,
829:     * mesmas cotacoes (SigCdCot), mesmas tabelas de desconto (SigOpTdz com
830:     * rel_descs = 1) e mesmo layout de 40 colunas. A UNICA diferenca em
831:     * relacao a Confirma e o destino - tela em vez de impressora - e por isso
832:     * NAO ha aqui confirmacao de impressao, laco de copias, SET DEVICE TO
833:     * PRINTER nem THIS.Release(): o dialogo permanece aberto para o usuario
834:     * corrigir a moeda e imprimir em seguida.
835:     *
836:     * Nenhum botao novo e criado no formulario (o SCX legado tem apenas
837:     * Confirma / Encerrar) - este handler serve o contrato de eventos do
838:     * FormBase e chamadas externas.
839:     *==========================================================================
840:     PROCEDURE BtnVisualizarClick()
841:         LOCAL loc_cMoeda, loc_cConteudo, loc_oErro
842: 
843:         loc_cMoeda = ALLTRIM(THIS.txt_4c__moeda.Value)
844: 
845:         IF EMPTY(loc_cMoeda)
846:             MsgAviso("Moeda inv" + CHR(225) + "lida !", "Aten" + CHR(231) + CHR(227) + "o")
847:             THIS.txt_4c__moeda.SetFocus()
848:             RETURN
849:         ENDIF
850: 
851:         THIS.this_cModoAtual = "VISUALIZAR"
852:         THIS.FormParaBO()
853: 
854:         *-- Bloqueia os parametros enquanto os cursores sao montados
855:         THIS.AlternarPagina(2)
856: 
857:         TRY
858:             IF THIS.this_oBusinessObject.GerarTabelaReferencia(loc_cMoeda)
859:                 loc_cConteudo = THIS.this_oBusinessObject.this_cConteudoRelatorio
860:                 MsgInfo(loc_cConteudo, "Tabelas de Refer" + CHR(234) + "ncia - " + ;
861:                     "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o")
862:             ELSE
863:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
864:                     "Tabelas de Refer" + CHR(234) + "ncia")
865:             ENDIF
866:         CATCH TO loc_oErro
867:             MsgErro(loc_oErro.Message + CHR(13) + ;
868:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
869:                 "Procedure: " + loc_oErro.Procedure, ;
870:                 "Erro ao Pr" + CHR(233) + "-visualizar")
871:         ENDTRY
872: 
873:         THIS.this_cModoAtual = "LISTA"
874:         THIS.AlternarPagina(1)
875:         THIS.txt_4c__moeda.SetFocus()
876:     ENDPROC
877: 
878:     *==========================================================================
879:     * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
880:     * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame
881:     *==========================================================================
882:     PROTECTED PROCEDURE TornarControlesVisiveis()
883:         LOCAL loc_oErro
884: 
885:         TRY
886:             THIS.TornarVisivelRecursivo(THIS)
887: 
888:         CATCH TO loc_oErro
889:             MsgErro(loc_oErro.Message + CHR(13) + ;
890:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
891:                 "Procedure: " + loc_oErro.Procedure, ;
892:                 "Erro TornarControlesVisiveis")
893:         ENDTRY
894:     ENDPROC
895: 
896:     *==========================================================================
897:     * TornarVisivelRecursivo - Percorre container recursivamente tornando visiveis
898:     *==========================================================================
899:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
900:         LOCAL loc_i, loc_oCtrl
901:         FOR loc_i = 1 TO par_oContainer.ControlCount
902:             loc_oCtrl = par_oContainer.Controls(loc_i)
903:             IF VARTYPE(loc_oCtrl) = "O"
904:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
905:                     loc_oCtrl.Visible = .T.
906:                 ENDIF
907:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
908:                    loc_oCtrl.ControlCount > 0
909:                     THIS.TornarVisivelRecursivo(loc_oCtrl)
910:                 ENDIF
911:             ENDIF
912:         ENDFOR
913:     ENDPROC
914: 
915:     *==========================================================================
916:     PROCEDURE Destroy()
917:     *==========================================================================
918:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
919:             THIS.this_oBusinessObject = .NULL.
920:         ENDIF
921:         DODEFAULT()
922:     ENDPROC
923: 
924: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TBIBO.prg):
*==============================================================================
* TBIBO.PRG
* Business Object - Tabelas de Referencia (Impressao de Tabela de Cambio)
* Baseado no formulario legado SIGCDTBI (Relatorio de Tabelas de Referencia)
* Camada: BusinessBase (regras de negocio) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS TBIBO AS BusinessBase

    *-- Propriedades principais (espelham os campos do formulario original)
    this_cMoeda            = ""    && Codigo da moeda de referencia (SigCdMoe.Cmoes)
    this_cMoedaDescricao   = ""    && Descricao da moeda de referencia (SigCdMoe.Dmoes)
    this_nCopias           = 1     && Quantidade de copias da impressao
    this_cConteudoRelatorio = ""   && Texto pronto para impressao (montado por GerarTabelaReferencia)
    this_cMensagemErro     = ""    && Mensagem de erro/aviso preenchida por GerarTabelaReferencia/Inserir/Atualizar

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdMoe")

        THIS.this_cCampoChave = "Cmoes"

        THIS.this_cMoeda = ""
        THIS.this_cMoedaDescricao = ""
        THIS.this_nCopias = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o codigo/descricao da moeda de referencia
    * a partir de um cursor resultante de SELECT em SigCdMoe (cmoes, dmoes),
    * espelhando o retorno do fwBuscaExt('SigCdMoe', ...) do formulario
    * original (Valid de get_moeda / get_moeda_desc).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoeda          = TratarNulo(cmoes, "C")
            THIS.this_cMoedaDescricao = TratarNulo(dmoes, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo da moeda de referencia atualmente carregada
    * (usado por RegistrarAuditoria e por eventuais chamadas de Salvar/Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cMoeda)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCotacao - Cotacao mais recente (<= par_dData) da moeda informada,
    * espelhando fBuscarCambio(ctod(''), par_dData, space(03), par_cMoeda) do
    * codigo original (cmd_ok.Click). Retorna 0 se nao houver cotacao lancada
    * para a moeda na tabela SigCdCot.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResultado
        loc_nCotacao = 0

        IF EMPTY(ALLTRIM(NVL(par_cMoeda, "")))
            RETURN loc_nCotacao
        ENDIF

        IF USED("cursor_4c_TbiCotacao")
            USE IN cursor_4c_TbiCotacao
        ENDIF

        loc_cSQL = "SELECT valos, datas FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                   " ORDER BY datas DESC, horas DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiCotacao")

        IF loc_nResultado > 0 AND USED("cursor_4c_TbiCotacao") AND ;
           RECCOUNT("cursor_4c_TbiCotacao") > 0
            SELECT cursor_4c_TbiCotacao
            LOCATE FOR datas <= par_dData
            IF FOUND("cursor_4c_TbiCotacao")
                loc_nCotacao = NVL(cursor_4c_TbiCotacao.valos, 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_TbiCotacao")
            USE IN cursor_4c_TbiCotacao
        ENDIF

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarTabelaReferencia - Monta o conteudo texto (THIS.this_cConteudoRelatorio)
    * da tabela de cambio das Tabelas de Referencia (SigOpTdz com Rel_Descs = 1),
    * convertidas para a moeda informada em par_cMoedaRef, espelhando a logica
    * de cmd_ok.Click do formulario original (sem a selecao de impressora de
    * etiqueta legada, que nao se aplica a arquitetura nova).
    *
    * Retorna .T. com THIS.this_cConteudoRelatorio preenchido em caso de
    * sucesso, ou .F. com THIS.this_cMensagemErro preenchido caso nao haja
    * tabelas de desconto marcadas (Rel_Descs = 1) ou ocorra falha de SQL.
    *--------------------------------------------------------------------------
    FUNCTION GerarTabelaReferencia(par_cMoedaRef)
        LOCAL loc_lSucesso, loc_cMoedaRef, loc_nCotRef, loc_cSQL, loc_nResultado
        LOCAL loc_cMoeda, loc_nCotacao, loc_lMultiplica, loc_nValorConvertido
        LOCAL loc_cConteudo, loc_cLinha, loc_lExisteImpressao, loc_oErro

        loc_lSucesso            = .F.
        loc_lExisteImpressao    = .F.
        loc_cMoedaRef           = ALLTRIM(NVL(par_cMoedaRef, ""))
        THIS.this_cMensagemErro     = ""
        THIS.this_cConteudoRelatorio = ""

        TRY
            IF USED("cursor_4c_TbiMoedas")
                USE IN cursor_4c_TbiMoedas
            ENDIF
            IF USED("cursor_4c_TbiTabelas")
                USE IN cursor_4c_TbiTabelas
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, fmults, tabrefs FROM SigCdMoe ORDER BY cmoes"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiMoedasTmp")

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao consultar Moedas (SigCdMoe)."
            ELSE
                SELECT * FROM cursor_4c_TbiMoedasTmp INTO CURSOR cursor_4c_TbiMoedas READWRITE
                IF USED("cursor_4c_TbiMoedasTmp")
                    USE IN cursor_4c_TbiMoedasTmp
                ENDIF

                loc_cSQL = "SELECT codigos, descos, descrs FROM SigOpTdz " + ;
                           "WHERE rel_descs = 1 ORDER BY codigos"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiTabelasTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar Tabelas de " + ;
                        "Refer" + CHR(234) + "ncia (SigOpTdz)."
                ELSE
                    SELECT * FROM cursor_4c_TbiTabelasTmp INTO CURSOR cursor_4c_TbiTabelas READWRITE
                    IF USED("cursor_4c_TbiTabelasTmp")
                        USE IN cursor_4c_TbiTabelasTmp
                    ENDIF

                    IF RECCOUNT("cursor_4c_TbiTabelas") = 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                            " tabelas de desconto selecionadas para impress" + ;
                            CHR(227) + "o !"
                    ELSE
                        loc_nCotRef = THIS.ObterCotacao(loc_cMoedaRef, DATE())

                        loc_cConteudo = REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                            "Tabelas de refer" + CHR(234) + "ncia em " + DTOC(DATE()) + CHR(13) + CHR(10) + ;
                            REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                            "Moeda de refer" + CHR(234) + "ncia: " + loc_cMoedaRef + ;
                            " (" + ALLTRIM(TRANSFORM(loc_nCotRef, "999999999.99")) + ")" + ;
                            CHR(13) + CHR(10) + CHR(13) + CHR(10)

                        SELECT cursor_4c_TbiMoedas
                        SCAN FOR ALLTRIM(cursor_4c_TbiMoedas.cmoes) <> loc_cMoedaRef ;
                                AND cursor_4c_TbiMoedas.tabrefs
                            loc_cMoeda      = ALLTRIM(cursor_4c_TbiMoedas.cmoes)
                            loc_lMultiplica = (ALLTRIM(cursor_4c_TbiMoedas.fmults) == "S")
                            loc_nCotacao    = THIS.ObterCotacao(loc_cMoeda, DATE())

                            loc_cConteudo = loc_cConteudo + "Moeda: " + loc_cMoeda + CHR(13) + CHR(10) + ;
                                PADR("Tabela", 12) + PADR("Desconto %", 14) + "Valor Convertido" + CHR(13) + CHR(10) + ;
                                REPLICATE("-", 45) + CHR(13) + CHR(10)

                            SELECT cursor_4c_TbiTabelas
                            SCAN
                                loc_lExisteImpressao = .T.
                                loc_nValorConvertido = IIF(loc_lMultiplica, ;
                                    ROUND(loc_nCotRef * loc_nCotacao * (1 - (cursor_4c_TbiTabelas.descos / 100)), 2), ;
                                    ROUND(loc_nCotacao * (1 - (cursor_4c_TbiTabelas.descos / 100)), 2))

                                loc_cLinha = PADR(ALLTRIM(cursor_4c_TbiTabelas.codigos), 12) + ;
                                    PADR(ALLTRIM(TRANSFORM(cursor_4c_TbiTabelas.descos, "999.99")), 14) + ;
                                    ALLTRIM(TRANSFORM(loc_nValorConvertido, "999999999.99"))

                                loc_cConteudo = loc_cConteudo + loc_cLinha + CHR(13) + CHR(10)
                            ENDSCAN

                            loc_cConteudo = loc_cConteudo + CHR(13) + CHR(10)

                            SELECT cursor_4c_TbiMoedas
                        ENDSCAN

                        IF !loc_lExisteImpressao
                            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                                " tabelas de desconto selecionadas para impress" + ;
                                CHR(227) + "o !"
                        ELSE
                            THIS.this_cConteudoRelatorio = loc_cConteudo
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_TbiMoedas")
            USE IN cursor_4c_TbiMoedas
        ENDIF
        IF USED("cursor_4c_TbiTabelas")
            USE IN cursor_4c_TbiTabelas
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar - TBIBO NAO grava registros de moeda.
    *
    * O formulario original SIGCDTBI ("Relatorio de Tabelas de Referencia")
    * eh um utilitario de IMPRESSAO: ele apenas LE e VALIDA um codigo de
    * moeda ja existente em SigCdMoe (via fwBuscaExt, metodos Valid de
    * get_moeda/get_moeda_desc) para montar a tabela de cambio impressa no
    * cmd_ok.Click. Em nenhum ponto do codigo fonte original ha um INSERT
    * ou UPDATE em SigCdMoe - o cadastro/manutencao da moeda pertence
    * exclusivamente ao MoeBO/FormMoe (Cadastro de Moedas).
    *
    * Estes overrides existem para cumprir o contrato de BusinessBase e
    * bloquear, com mensagem clara, qualquer tentativa de gravacao por
    * este BO - evitando duplicar (e divergir de) a regra de negocio de
    * SigCdMoe que ja vive em MoeBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Este formul" + CHR(225) + "rio " + ;
            "n" + CHR(227) + "o cadastra moedas." + CHR(13) + ;
            "Utilize o Cadastro de Moedas para incluir novos registros."
        RETURN .F.
    ENDFUNC

    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Este formul" + CHR(225) + "rio " + ;
            "n" + CHR(227) + "o cadastra moedas." + CHR(13) + ;
            "Utilize o Cadastro de Moedas para alterar registros existentes."
        RETURN .F.
    ENDFUNC

ENDDEFINE

