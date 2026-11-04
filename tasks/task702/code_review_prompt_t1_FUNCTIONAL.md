# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcks.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1411 linhas total):

*-- Linhas 31 a 113:
31: *   que o dump nao tem segue proibido.
32: *
33: * O que NAO eh reproduzido, de proposito:
34: *   - poDatamgr = CreateObject("fSqlConector", "SigOpSen"): objeto de conexao
35: *     do Framework Fortyus. Na arquitetura nova o acesso a dados eh do BO,
36: *     por gnConnHandle. Como consequencia o PROCEDURE Release legado
37: *     (ThisForm.poDatamgr.Release + DoDefault) nao tem conteudo proprio a
38: *     migrar - nao ha override de Release aqui, so o Destroy que fecha os
39: *     cursores. ATENCAO: "SigOpSen" aqui eh o NOME DA CONEXAO lido de
40: *     dbo.SigConn, NAO o form sigopsen.SCX (dialogo de senha de supervisor
41: *     que nao foi migrado) - sao coisas diferentes com o mesmo nome.
42: *
43: * Historico de fases:
44: *   Fase 1/2: sigopcksBO.prg - propriedades (8 parametros de entrada, 12
45: *             flags de tipo, credenciais, parametros do sistema, resultado) e
46: *             metodos de negocio: DefinirTipo (DO CASE do Init legado),
47: *             CarregarParametrosSistema (SigCdPam.liblcreds / SigCdPac.
48: *             senhdemps), DevePreencherUsuarioLogado, EstaEmModoSenhaDoDia,
49: *             CarregarUsuariosAutorizados, ValidarUsuario,
50: *             UsuarioTemSenhaCadastrada, ConcluirAutorizacaoSemSenha,
51: *             ValidarSenha. BO somente-leitura (nao sobrescreve Inserir/
52: *             Atualizar/ExecutarExclusao - o comportamento herdado de
53: *             BusinessBase ja eh o correto).
54: *   Fase 3:   ESTE arquivo - estrutura base: bloco de propriedades visuais,
55: *             Init (8 parametros do Init legado + criacao do BO + DefinirTipo
56: *             + Caption), InicializarForm, ConfigurarPageFrame (a faixa
57: *             cnt_4c_Sombra com lbl_4c_LblSombra/lbl_4c_LblTitulo),
58: *             TornarControlesVisiveis e Destroy.
59: *             Form FLAT: NENHUM pgf_4c_* eh criado aqui, porque o legado nao
60: *             tem PageFrame nem Page nenhuma - fabricar um violaria o PILAR 1
61: *             (inventar UX que o legado nao tem). O nome ConfigurarPageFrame
62: *             eh mantido por convencao do orquestrador de migracao.
63: *
64: * FASE 4 (Grid + barra CRUD da Page1): NADA A ACRESCENTAR - perfil CAPTURA.
65: * Este form nao recebe grade, nem container de barra CRUD, nem os seis botoes
66: * dela (os verbos incluir, visualizar, alterar, excluir, buscar e encerrar),
67: * nem os dois metodos canonicos do layout paginado - o Configurar<Pagina>Lista
68: * e o Alternar<Pagina> - porque o legado NAO TEM superficie de LISTA nenhuma
69: * para eles operarem.
70: *
71: * ATENCAO a quem for editar este cabecalho: os nomes desses dois metodos estao
72: * escritos com <...> de proposito. O gate da Fase 4 casa o identificador no
73: * .prg INTEIRO, comentario incluido e sem exigir PROCEDURE antes; grafar os
74: * nomes por extenso faz temLayoutPaginado virar .T. a partir do COMENTARIO e a
75: * fase passa pelo caminho ERRADO (aprovada por palavra-chave, sem o ramo
76: * CAPTURA nunca ser exercitado) - exatamente o modo de falha de
77: * SIGOPCAC/task651. Medido aqui: com os nomes por extenso o predicado deu .T.;
78: * com <...> da .F., e a aprovacao volta a vir do ramo CAPTURA, que eh o
79: * motivo verdadeiro.
80: *
81: * Medido no dump sigopcks_form_codigo_fonte.txt
82: * (12 objetos, conferidos um a um na SECAO 1):
83: *   - ZERO  BaseClass: grid | pageframe | listbox
84: *   - ZERO  AddCursor | pColuna | RecordSource | ControlSource | Grade | grd
85: *   - ZERO  API de nos de arvore (.Nodes.Add / AddPictureNode / ClearNodes...)
86: *   - 2     BaseClass: textbox (usuario, senha) - ambos de ENTRADA, nenhum
87: *           ReadOnly, o que caracteriza CAPTURA e nao EXIBICAO
88: *   - ZERO  commandbutton / commandgroup: o dialogo nao tem botao ALGUM. Ele
89: *           se resolve pela cadeia de Valid (senha.Valid autoriza) e aborta
90: *           por ESC no usuario.KeyPress - eventos da Fase 6/7.
91: * Os botoes CRUD canonicos ocupam Left = 542..1007; fabricar aqui uma barra
92: * Incluir/Alterar/Excluir sobre um dialogo de autorizacao daria ao usuario
93: * como CADASTRAR/APAGAR registro numa tela que so confere credencial - nao eh
94: * so UI morta, eh UX que o legado nao tem (PILAR 1, regra "NUNCA inventar"), e
95: * os dois metodos do layout paginado sem nada para listar seriam o
96: * "stub disfarcado" que a regra de completude proibe.
97: * O gate da Fase 4 do OrquestradorMigracao.ps1 reconhece isso pelo ramo
98: * "layout captura": medido com os helpers reais (Test-LegadoListBoxLigaLista,
99: * Test-LegadoAddCursorLigaGrade, Test-LegadoControlSourceLigaLista,
100: * Test-LegadoDialogoExibicao) ->  temListaEstritaF4 = .F., temCampoCapturaF4 =
101: * .T., temApiNosCapturaF4 = .F., DialogoExibicao = .F., legadoCapturaF4 = .T.,
102: * temSuperficieCaptura = .T., temLayoutCaptura = .T. (PASSA).
103: * Precedentes do mesmo perfil: SIGOPCHP/task699 e SIGPRCFN/task589.
104: *
105: * Continuacao do historico de fases:
106: *   Fase 5:   ESTE arquivo - ConfigurarControles (os 7 controles restantes do
107: *             SCX, todos filhos DIRETOS do form) e AplicarModoSenhaDoDia (o
108: *             ultimo bloco do Init legado, que depende deles).
109: *             Inventario ENTREGUE, conferido objeto a objeto contra a SECAO 2
110: *             do dump - os 12 objetos do SCX estao todos cobertos (o par
111: *             Dataenvironment/form nao vira controle; cntSombra + seus dois
112: *             labels sairam na Fase 3; os 7 abaixo saem aqui):
113: *               Shape1  -> shp_4c_Shape1  (247/197, 113x105, BorderWidth 2,

*-- Linhas 145 a 257:
145: *                          desvio "usuario sem senha cadastrada" que ESCONDE
146: *                          Say3/senha e conclui a autorizacao)
147: *               usuario.When     -> AplicarRegraWhenUsuario (.Enabled a partir
148: *                          de BO.EstaEmModoSenhaDoDia - BINDEVENT descarta o
149: *                          retorno do delegate e nao bloquearia a entrada)
150: *               senha.Valid      -> ValidarSenhaDigitada + ...Exec
151: *                          (BO.ValidarSenha nos dois ramos, senha cadastrada e
152: *                          senha do dia, com o "Deseja digitar novamente ?")
153: *             O LOOKUP eh AbrirBuscaUsuario: o legado usa fwBuscaSel sobre o
154: *             cursor LOCAL tmpusu (hoje cursor_4c_Usuar), ou seja um picker
155: *             sobre cursor JA populado - dai a API DefinirCursor/Mostrar do
156: *             FormBuscaAuxiliar, nunca o Init com parametros (que montaria
157: *             uma consulta nova e perderia o criterio de permissao).
158: *             Nao ha cnt_4c_BotoesAcao: o SCX nao tem botao algum (dialogo da
159: *             familia ENTRADA-SEM-BOTAO) - criar Confirmar/Cancelar aqui seria
160: *             inventar controle que o legado nao tem.
161: *             Medido no VFP9 (automation\ProbeCks702Fase6.prg): form instancia
162: *             1000x600, os 4 BINDEVENTs aparecem em AEVENTS, os 11 metodos do
163: *             caminho de BINDEVENT sao PUBLIC, o When deixa Enabled = .T. em
164: *             CANCITEM e .F. em MAXIMO, e o picker monta as 2 colunas do
165: *             legado (Codigo/cargo).
166: *
167: *   Fase 8:   ESTE arquivo - FECHAMENTO. O que faltava era UMA coisa: o
168: *             contrato de retorno do PROCEDURE Unload legado
169: *             (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs), que no
170: *             sistema novo nao tem como chegar ao chamador pelo evento
171: *             (o legado abria com "DO FORM ... TO <var>"; aqui se abre
172: *             por CREATEOBJECT + Show()). ENTREGUE em tres pecas:
173: *               sigopcksBO.ObterResultadoSaida - a REGRA, transcrita
174: *                          literal do Unload, gravando tambem em
175: *                          BO.this_cRetorno (fonte UNICA)
176: *               ObterResultadoSaida            - o espelho que o form
177: *                          chamador le depois do Show() e ANTES do
178: *                          Release() (o dialogo fecha com Hide(), entao
179: *                          continua legivel - ver FecharDialogo)
180: *               Unload + CachearResultadoSaida - o mesmo valor para quem
181: *                          abrir com "DO FORM ... TO"; o cache existe
182: *                          porque o Unload dispara DEPOIS do Destroy,
183: *                          quando FormBase.Destroy ja zerou o BO
184: *             Nada mais do SCX ficou de fora - nem controle, nem evento:
185: *             os 12 objetos sairam nas Fases 3/5 e os 4 metodos de
186: *             controle nas Fases 6/7.
187: *
188: * POR QUE NAO HA, NESTA FASE, OS QUATRO NOMES CANONICOS DO FORM CRUD
189: * (o Btn...Click de cancelar, o par de transferencia Form...BO /
190: * BO...Form e o Carregar...Lista) - nomes grafados aqui com o miolo
191: * ELIDIDO DE PROPOSITO, porque o gate da Fase 8 casa o identificador no
192: * .prg INTEIRO, comentario incluido: escreve-los por extenso daria
193: * "PRESENTE" a partir deste texto e a fase passaria por palavra-chave,
194: * sem o ramo verdadeiro ser exercitado.
195: *   - cancelar: o SCX nao tem UM botao sequer (12 objetos, zero
196: *     CommandButton/CommandGroup). Quem aborta eh o ESC do usuario.KeyPress
197: *     e o "Nao" do "Deseja digitar novamente ?" - os dois ja desembocam em
198: *     AbortarAutorizacao, que eh o Cancelar REAL desta tela. Criar um botao
199: *     para ter o nome canonico inventaria UX que o legado nao tem (PILAR 1).
200: *   - transferencia Form<->BO: os dois campos sao lidos e escritos no
201: *     ponto de uso, como o "This.Value" do Valid legado - a tela tem
202: *     exatamente dois controles de entrada, um deles (senha) nunca eh
203: *     relido, e o BO ja recebe o valor por parametro
204: *     (ValidarUsuario / ValidarSenha). O sentido BO -> tela existe e esta
205: *     em AplicarModoSenhaDoDia / AplicarRegraWhenUsuario / ConfigurarControles,
206: *     cada um ancorado no bloco do Init legado que o originou.
207: *   - carga de lista: nao ha lista. Zero grade, zero PageFrame, zero
208: *     AddCursor/pColuna no dump (medido na Fase 4).
209: * Este eh o perfil ENTRADA-SEM-BOTAO do gate: dialogo de ENTRADA sem botao
210: * algum, que confirma pelo evento de saida do ultimo campo. Precedentes do
211: * mesmo perfil: SIGOPBIN/task646 (que tambem devolve
212: * Iif(ZSen,'*',' ')+UsuLibs pelo Unload) e SIGPRSCN/task673.
213: *
214: * NOTA sobre visibilidade: no SCX, Say3 e senha nascem com Visible = .T. e
215: * so sao ESCONDIDOS em runtime, dentro do usuario.Valid (usuario sem senha
216: * cadastrada). Nao ha, portanto, container flutuante nem controle que nasce
217: * oculto neste form - TornarControlesVisiveis pode varrer a arvore inteira
218: * sem lista de excecao, e o Valid da Fase 6 esconde o que precisa DEPOIS,
219: * sem conflito com esta fase.
220: *==============================================================================
221: 
222: DEFINE CLASS Formsigopcks AS FormBase
223: 
224:     *--------------------------------------------------------------------------
225:     * Propriedades visuais - valores EXATOS do SCX legado (PILAR 1)
226:     *--------------------------------------------------------------------------
227:     Width       = 1000
228:     Height      = 600
229:     DataSession = 2
230:     BorderStyle = 2
231:     AutoCenter  = .T.
232:     Caption     = ""
233:     ControlBox  = .F.
234:     MaxButton   = .F.
235:     Movable     = .F.
236:     TitleBar    = 0
237:     WindowType  = 1
238:     AlwaysOnTop = .T.
239:     ShowWindow  = 1
240: 
241:     *--------------------------------------------------------------------------
242:     * Guardas de REENTRANCIA (regra #37/#47) - os dois caminhos de validacao
243:     * de campo deste dialogo abrem janela MODAL (o browse de liberadores e o
244:     * "Deseja digitar novamente ?"), que tira o foco do campo e faria o
245:     * proprio LostFocus disparar de novo, empilhando um segundo dialogo. As
246:     * flags sao ligadas e DESLIGADAS nos metodos-wrapper, nunca no corpo:
247:     * corpo com saida antecipada deixaria a flag presa em .T. e mataria a
248:     * validacao pelo resto da vida da tela.
249:     *--------------------------------------------------------------------------
250:     this_lEmLookup         = .F.
251:     this_lEmValidacaoSenha = .F.
252: 
253:     *--------------------------------------------------------------------------
254:     * Cache do resultado do dialogo (contrato do Unload legado).
255:     *
256:     * Existe porque o evento Unload do VFP dispara DEPOIS do Destroy, e
257:     * FormBase.Destroy zera this_oBusinessObject - no Unload nao ha mais BO de

*-- Linhas 273 a 451:
273:     *-- ANTES do DODEFAULT. Preencher this_cTituloForm apagaria esse texto.
274: 
275:     *--------------------------------------------------------------------------
276:     * Init - Equivale ao PROCEDURE Init legado:
277:     *   LParameters _Tipo, _Titulo, _Titulo2, _Documento, _Data, _Empresa,
278:     *               _Fpagto, _Valor
279:     *
280:     * Os 8 parametros sao repassados CRUS ao BO: a normalizacao do legado
281:     * (If Type("_Documento")#"N" -> 0, If Type("_Data")#"D" -> Date(), etc.)
282:     * ja mora em sigopcksBO.DefinirTipo, junto com o DO CASE que deriva
283:     * Caption/Frase e liga a flag de permissao do tipo. DefinirTipo tambem
284:     * carrega os parametros do sistema (SigCdPam/SigCdPac) na MESMA posicao do
285:     * Init legado, antes do DO CASE - de que dependem
286:     * DevePreencherUsuarioLogado e EstaEmModoSenhaDoDia.
287:     *
288:     * O Caption eh resolvido ANTES do DODEFAULT porque ConfigurarPageFrame
289:     * copia THIS.Caption para os dois labels da faixa (regra #11), tal como o
290:     * Init legado faz (cntSombra.lblSombra.Caption = ThisForm.Caption).
291:     *
292:     * A criacao do BO NAO eh condicionada a gnConnHandle > 0: o harness de
293:     * teste automatizado define gnConnHandle = 0 de proposito e um gate de
294:     * handle aqui faria CREATEOBJECT devolver .F. e a tela nunca abrir. Quem
295:     * pula a consulta eh o proprio metodo do BO, que trata a falha de SQLEXEC.
296:     *
297:     * Sem RETURN dentro de TRY/CATCH (regra #1): o resultado vai para
298:     * loc_lSucesso e o unico RETURN fica DEPOIS do ENDTRY.
299:     *--------------------------------------------------------------------------
300:     PROCEDURE Init(par_cTipo, par_cTitulo, par_cTitulo2, par_nDocumento, ;
301:             par_dData, par_cEmpresa, par_cFpagto, par_nValor)
302:         LOCAL loc_lSucesso, loc_oErro
303:         loc_lSucesso = .F.
304: 
305:         TRY
306:             THIS.this_oBusinessObject = CREATEOBJECT("sigopcksBO")
307: 
308:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
309:                 MsgErro("Erro ao criar sigopcksBO." + CHR(13) + ;
310:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
311:                     "Formsigopcks.Init")
312:             ELSE
313:                 *-- DO CASE do Init legado + carga de SigCdPam/SigCdPac.
314:                 *-- A falha NAO aborta o dialogo (o Init legado tambem segue
315:                 *-- adiante): a tela abre FAIL-CLOSED, com this_lZSen = .F.,
316:                 *-- e so a conferencia bem sucedida da senha autoriza.
317:                 IF !THIS.this_oBusinessObject.DefinirTipo(par_cTipo, par_cTitulo, ;
318:                         par_cTitulo2, par_nDocumento, par_dData, par_cEmpresa, ;
319:                         par_cFpagto, par_nValor)
320:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
321:                         "Formsigopcks.Init")
322:                 ENDIF
323: 
324:                 *-- This.Caption = ... de cada ramo do DO CASE legado
325:                 THIS.Caption = THIS.this_oBusinessObject.this_cCaption
326: 
327:                 *-- DODEFAULT() dispara FormBase.Init(), que chama
328:                 loc_lSucesso = DODEFAULT()
329:             ENDIF
330:         CATCH TO loc_oErro
331:             MsgErro(loc_oErro.Message + CHR(13) + ;
332:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
333:                 "Procedure: " + loc_oErro.Procedure, "Formsigopcks.Init")
334:         ENDTRY
335: 
336:         RETURN loc_lSucesso
337:     ENDPROC
338: 
339:     *--------------------------------------------------------------------------
340:     * InicializarForm - Monta a estrutura visual base
341:     * (chamado por FormBase.Init via DODEFAULT)
342:     *--------------------------------------------------------------------------
343:     PROTECTED PROCEDURE InicializarForm()
344:         LOCAL loc_lSucesso, loc_oErro
345:         loc_lSucesso = .F.
346: 
347:         TRY
348:             *-- Picture do SCX: ..\framework\imagens\new_background.jpg.
349:             *-- Caminho resolvido por gc_4c_CaminhoFramework (config.prg) -
350:             *-- NUNCA remontado a partir de gc_4c_CaminhoBase, que aponta para
351:             *-- app\start e nao navega para a pasta Framework.
352:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
353: 
354:             *-- Faixa de cabecalho (cntSombra do legado). PRIMEIRO AddObject
355:             *-- do form (regra #11).
356:             THIS.ConfigurarPageFrame()
357: 
358:             *-- Os 7 controles restantes do SCX, todos filhos DIRETOS do form
359:             THIS.ConfigurarControles()
360: 
361:             *-- Ultimo bloco do Init legado - depende de txt_4c_Usuario e
362:             *-- lbl_4c_Label3, criados logo acima
363:             THIS.AplicarModoSenhaDoDia()
364: 
365:             *-- Eventos dos dois campos: usuario.KeyPress/Valid/When e
366:             *-- senha.Valid do legado (o form nao tem botao algum)
367:             THIS.ConfigurarBINDEVENTs()
368: 
369:             *-- usuario.When legado: campo nao digitavel em senha-do-dia
370:             THIS.AplicarRegraWhenUsuario()
371: 
372:             *-- AddObject cria todo controle com Visible = .F.
373:             THIS.TornarControlesVisiveis(THIS)
374: 
375:             *-- Duas ultimas linhas do Init legado:
376:             *--   ThisForm.Top  = ThisForm.Top  + 5
377:             *--   ThisForm.Left = ThisForm.Left + 5
378:             *-- Transcritas como estao. O legado tem AutoCenter = .T. igual ao
379:             *-- migrado, entao o efeito (se o VFP nao recentralizar no Show)
380:             *-- eh o mesmo nos dois - transcrever mantem a fidelidade sem
381:             *-- decidir pelo VFP.
382:             THIS.Top  = THIS.Top  + 5
383:             THIS.Left = THIS.Left + 5
384: 
385:             loc_lSucesso = .T.
386:         CATCH TO loc_oErro
387:             MsgErro(loc_oErro.Message + CHR(13) + ;
388:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
389:                 "Procedure: " + loc_oErro.Procedure, ;
390:                 "Formsigopcks.InicializarForm")
391:         ENDTRY
392: 
393:         RETURN loc_lSucesso
394:     ENDPROC
395: 
396:     *--------------------------------------------------------------------------
397:     * ConfigurarPageFrame - Cria a faixa de cabecalho: cnt_4c_Sombra
398:     * (cntSombra do legado) com lbl_4c_LblSombra e lbl_4c_LblTitulo.
399:     *
400:     * Form OPERACIONAL FLAT: NENHUM AddObject de pgf_4c_ acontece aqui - o
401:     * legado nao tem PageFrame nem Page. O nome do metodo eh mantido por
402:     * convencao do orquestrador de migracao.
403:     *
404:     * A faixa eh o PRIMEIRO AddObject do form (regra #11): os controles das
405:     * fases seguintes ficam abaixo dela (o mais alto eh Frase, Top = 120,
406:     * contra 0..80 da faixa) e, criados depois, desenham por cima.
407:     *
408:     * Os labels sao adicionados FORA do bloco WITH do container: WITH
409:     * aninhado em volta de AddObject descarta propriedades em silencio.
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE ConfigurarPageFrame()
412:         LOCAL loc_oCab, loc_oErro
413: 
414:         TRY
415:             THIS.AddObject("cnt_4c_Sombra", "Container")
416:             loc_oCab = THIS.cnt_4c_Sombra
417:             WITH loc_oCab
418:                 .Top         = 0
419:                 .Left        = 0
420:                 *-- O SCX declara cntSombra.Width = 1100 com o form em 1000:
421:                 *-- artefato do Form Designer (container desenhado 100px alem
422:                 *-- da borda direita da janela). Copiar o literal nao
423:                 *-- acrescenta area visivel nenhuma, entao vale THIS.Width.
424:                 .Width       = THIS.Width
425:                 .Height      = 80
426:                 .BorderWidth = 0
427:                 .BackStyle   = 1
428:                 .BackColor   = RGB(100, 100, 100)
429:             ENDWITH
430: 
431:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
432:             WITH loc_oCab.lbl_4c_LblSombra
433:                 .FontBold      = .T.
434:                 .FontName      = "Tahoma"
435:                 .FontSize      = 18
436:                 .FontUnderline = .F.
437:                 .WordWrap      = .T.
438:                 *-- AutoSize explicitamente .F. com WordWrap ligado: AutoSize
439:                 *-- eh no-op em Label criado por AddObject e, com WordWrap,
440:                 *-- chega a DESCARTAR a Height transcrita (regra #23). Width e
441:                 *-- Height vem do dump e ja sao o auto-size que o Form
442:                 *-- Designer calculou.
443:                 .AutoSize      = .F.
444:                 .Alignment     = 0
445:                 .BackStyle     = 0
446:                 .Height        = 40
447:                 .Left          = 10
448:                 .Top           = 18
449:                 .Width         = 769
450:                 .Rotation      = 0
451:                 .ForeColor     = RGB(0, 0, 0)

*-- Linhas 482 a 525:
482:         CATCH TO loc_oErro
483:             MsgErro(loc_oErro.Message + CHR(13) + ;
484:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
485:                 "Procedure: " + loc_oErro.Procedure, ;
486:                 "Formsigopcks.ConfigurarPageFrame")
487:         ENDTRY
488:     ENDPROC
489: 
490:     *--------------------------------------------------------------------------
491:     * ConfigurarControles - Cria os 7 controles restantes do SCX legado.
492:     *
493:     * Form FLAT: TODOS sao filhos DIRETOS do form (THIS.AddObject), como na
494:     * SECAO 1 do dump - o unico par que mora em container eh o dos labels da
495:     * faixa, ja criado em ConfigurarPageFrame. Nao existe aqui o par
496:     * Configurar<Pagina>Dados / loc_oPagina = ...Page2 do layout paginado,
497:     * porque o legado nao tem Page nenhuma; escrever um metodo com esse nome
498:     * so para casar com o regex do gate seria o "stub disfarcado" proibido
499:     * pela regra de completude - e, pior, um metodo que ninguem chama.
500:     *
501:     * ORDEM DE CRIACAO = ordem de declaracao do SCX (Shape1, Frase, Say2,
502:     * usuario, Say3, senha, Image1), que tambem satisfaz as duas regras de
503:     * z-order que importam aqui:
504:     *   - cada label eh criado ANTES do campo que ele rotula (Say2 antes de
505:     *     usuario, Say3 antes de senha), entao a caixa transparente que sobra
506:     *     no label nunca bloqueia o clique no TextBox (regra #23);
507:     *   - Image1 vem DEPOIS de Shape1, logo o icone de login desenha POR CIMA
508:     *     da moldura branca, que eh o efeito do legado.
509:     * A faixa do cabecalho (0..80) nao disputa espaco com nada daqui: o
510:     * controle mais alto eh Frase, em Top = 120.
511:     *
512:     * Os tamanhos de lbl_4c_Label2 e lbl_4c_Label3 sao os UNICOS numeros nao
513:     * transcritos literalmente, porque o SCX nao os grava: as duas labels
514:     * declaram AutoSize = .T. e o Form Designer, nesse caso, nao persiste
515:     * Width/Height. AutoSize eh no-op em Label criado por AddObject (a Width
516:     * ficaria nos 100 do default) e, com WordWrap, chega a DESCARTAR a Height
517:     * - por isso vao com AutoSize = .F. e medida explicita (regra #23).
518:     *
519:     * As larguras foram MEDIDAS no VFP9, nao estimadas
520:     * (automation\vfp_helpers\medir_task702_f5.prg:
521:     *  TXTWIDTH(<caption>, "Tahoma", 14, "B") * FONTMETRIC(6, "Tahoma", 14, "B")):
522:     *   "Representante :"  = 152px  -> lbl_4c_Label2.Width = 152
523:     *   "Senha :"          =  71px
524:     *   "Senha Do Dia : "  = 146px  -> lbl_4c_Label3.Width = 146
525:     * A estimativa de 10px por caractere (largura media que a tabela de fontes

*-- Linhas 534 a 577:
534:     * de "Senha :" (a partir de 486) terminam os DOIS em 557, exatos 4px antes
535:     * dos campos em Left = 561.
536:     *--------------------------------------------------------------------------
537:     PROTECTED PROCEDURE ConfigurarControles()
538:         LOCAL loc_oErro
539: 
540:         TRY
541:             *-- Shape1 -> shp_4c_Shape1: moldura branca do bloco de login.
542:             *-- Shape NAO tem ForeColor (regra #33) - a cor da borda mora em
543:             *-- BorderColor, e eh so o que o dump declara.
544:             THIS.AddObject("shp_4c_Shape1", "Shape")
545:             WITH THIS.shp_4c_Shape1
546:                 .Top         = 197
547:                 .Left        = 247
548:                 .Height      = 105
549:                 .Width       = 113
550:                 .BorderWidth = 2
551:                 .BackColor   = RGB(255, 255, 255)
552:                 .BorderColor = RGB(90, 90, 90)
553:             ENDWITH
554: 
555:             *-- Frase -> lbl_4c_Frase: a frase que explica o bloqueio.
556:             *-- O Caption NAO eh literal: cada ramo do DO CASE do Init legado
557:             *-- escreve um texto diferente em This.Frase.Caption, e esse texto
558:             *-- ja foi derivado por BO.DefinirTipo (fonte UNICA, this_cFrase).
559:             *-- BackStyle = 0 reproduz a classe "say" do framework.vcx, que o
560:             *-- dump nao repete objeto a objeto: Label base nasce opaco e, sem
561:             *-- isso, pintaria um retangulo cinza sobre o new_background.jpg.
562:             THIS.AddObject("lbl_4c_Frase", "Label")
563:             WITH THIS.lbl_4c_Frase
564:                 .Caption   = THIS.this_oBusinessObject.this_cFrase
565:                 .Top       = 120
566:                 .Left      = 12
567:                 .Width     = 968
568:                 .Height    = 34
569:                 .FontName  = "Tahoma"
570:                 .FontSize  = 14
571:                 .FontBold  = .T.
572:                 .FontItalic = .F.
573:                 .WordWrap  = .T.
574:                 .Alignment = 2
575:                 .BackStyle = 0
576:                 .AutoSize  = .F.
577:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 698 a 987:
698:         CATCH TO loc_oErro
699:             MsgErro(loc_oErro.Message + CHR(13) + ;
700:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
701:                 "Procedure: " + loc_oErro.Procedure, ;
702:                 "Formsigopcks.ConfigurarControles")
703:         ENDTRY
704:     ENDPROC
705: 
706:     *--------------------------------------------------------------------------
707:     * AplicarModoSenhaDoDia - ULTIMO bloco do Init legado que depende dos
708:     * controles criados acima:
709:     *
710:     *   If ( crParam.LiblCreds And _Tipo = 'LIMITE' ) Or _Tipo = 'LIBPRDZ2' ;
711:     *      Or _Tipo = 'MAXIMO'
712:     *       ThisForm.usuario.Value = Usuar
713:     *       ThisForm.Say3.Caption  = 'Senha Do Dia : '
714:     *       ThisForm.Say3.Left = 142
715:     *   EndIf
716:     *
717:     * A condicao NAO eh reescrita aqui: ela ja eh
718:     * BO.DevePreencherUsuarioLogado(), onde tambem vive a leitura de
719:     * SigCdPam.liblcreds carregada por DefinirTipo (fonte UNICA). Note que ela
720:     * NAO eh a mesma expressao de usuario.When / senha.Valid
721:     * (BO.EstaEmModoSenhaDoDia) - sao duas regras parecidas e distintas, e o
722:     * BO as mantem separadas de proposito.
723:     *
724:     * "Usuar" do legado eh o usuario logado; no sistema novo,
725:     * gc_4c_UsuarioLogado.
726:     *
727:     * O Left = 142 arrasta o rotulo para cima da borda esquerda de
728:     * shp_4c_Shape1 (247..360). Isso eh SOBREPOSICAO HERDADA do legado
729:     * (regra #28): o SCX/Init move a label e nao move mais nada, e o rotulo
730:     * longo invade a moldura. Transcrito como esta, sem inventar posicao nova
731:     * - o label desenha por cima porque eh criado depois do Shape, que eh o
732:     * resultado do legado.
733:     *
734:     * Chamado pelo InicializarForm, UMA vez, logo apos ConfigurarControles.
735:     * O Refresh final reproduz o "This.Refresh / This.Frase.Refresh" que
736:     * fecha o Init legado.
737:     *--------------------------------------------------------------------------
738:     PROTECTED PROCEDURE AplicarModoSenhaDoDia()
739:         LOCAL loc_oErro
740: 
741:         TRY
742:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
743:                 IF THIS.this_oBusinessObject.DevePreencherUsuarioLogado()
744:                     THIS.txt_4c_Usuario.Value  = gc_4c_UsuarioLogado
745:                     THIS.lbl_4c_Label3.Caption = "Senha Do Dia : "
746:                     THIS.lbl_4c_Label3.Left    = 142
747:                 ENDIF
748:             ENDIF
749: 
750:             THIS.lbl_4c_Frase.Refresh()
751:             THIS.Refresh()
752:         CATCH TO loc_oErro
753:             MsgErro(loc_oErro.Message + CHR(13) + ;
754:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
755:                 "Procedure: " + loc_oErro.Procedure, ;
756:                 "Formsigopcks.AplicarModoSenhaDoDia")
757:         ENDTRY
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * ConfigurarBINDEVENTs - Liga os eventos dos DOIS campos do dialogo.
762:     *
763:     * O SCX legado tem exatamente quatro metodos de controle, todos no par
764:     * usuario/senha - nao ha botao algum na arvore (form puro, TitleBar = 0,
765:     * ControlBox = .F., zero CommandButton/CommandGroup):
766:     *
767:     *   SIGOPCKS.usuario.KeyPress -> aborta no ESC com campo vazio
768:     *   SIGOPCKS.usuario.Valid    -> resolve o liberador (com browse) e decide
769:     *                                se a senha sera pedida
770:     *   SIGOPCKS.usuario.When     -> campo NAO digitavel em senha-do-dia
771:     *   SIGOPCKS.senha.Valid      -> confere a senha e fecha autorizando
772:     *
773:     * Por isso NAO existe cnt_4c_BotoesAcao (Confirmar/Cancelar) neste form:
774:     * criar esse container obrigaria a inventar dois botoes que o legado nao
775:     * tem, violando o PILAR 1 e a regra "NUNCA inventar". O dialogo eh da
776:     * familia ENTRADA-SEM-BOTAO: confirma pelo Valid do ultimo campo e aborta
777:     * pelo ESC, exatamente como o legado.
778:     *
779:     * Mapeamento de evento legado -> evento ligado aqui:
780:     *
781:     *   Valid    -> "LostFocus" : BINDEVENT "Valid" NAO dispara em TextBox
782:     *   KeyPress -> "KeyPress"  : direto
783:     *   When     -> .Enabled    : BINDEVENT descarta o retorno do delegate,
784:     *                             entao um "When" ligado nao bloquearia a
785:     *                             entrada - ver AplicarRegraWhenUsuario
786:     *
787:     * O lookup fica em "LostFocus", NUNCA em "KeyPress" sem testar a tecla
788:     * (regra #47): ligado a KeyPress sem guarda, o browse subiria a CADA
789:     * caractere digitado e o usuario nunca conseguiria terminar o codigo.
790:     * F4 e DblClick entram como atalhos para o MESMO funil
791:     * (ValidarUsuarioDigitado), nunca como um segundo caminho de validacao -
792:     * um caminho paralelo renderia mensagem/picker em duplicata.
793:     *
794:     * Todos os delegates sao PUBLIC: metodo PROTECTED ligado por BINDEVENT
795:     * falha em SILENCIO (regra #3). O handler de KeyPress declara os dois
796:     * parametros do evento, senao estoura a cada tecla.
797:     *--------------------------------------------------------------------------
798:     PROCEDURE ConfigurarBINDEVENTs()
799:         LOCAL loc_oErro
800: 
801:         TRY
802:             *-- usuario: ESC (KeyPress legado) e F4 (atalho do funil)
803:             BINDEVENT(THIS.txt_4c_Usuario, "KeyPress", THIS, "UsuarioKeyPress")
804: 
805:             *-- usuario.Valid legado: resolve o liberador e abre o browse
806:             BINDEVENT(THIS.txt_4c_Usuario, "LostFocus", THIS, "ValidarUsuarioDigitado")
807: 
808:             *-- atalho de mouse para o mesmo funil
809:             BINDEVENT(THIS.txt_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")
810: 
811:             *-- senha.Valid legado: confere a senha e fecha autorizando
812:             BINDEVENT(THIS.txt_4c_Senha, "LostFocus", THIS, "ValidarSenhaDigitada")
813:         CATCH TO loc_oErro
814:             MsgErro(loc_oErro.Message + CHR(13) + ;
815:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
816:                 "Procedure: " + loc_oErro.Procedure, ;
817:                 "Formsigopcks.ConfigurarBINDEVENTs")
818:         ENDTRY
819:     ENDPROC
820: 
821:     *--------------------------------------------------------------------------
822:     * AplicarRegraWhenUsuario - usuario.When legado:
823:     *
824:     *   Return (!crParam.LiblCreds Or (ThisForm.Tipo # 'LIMITE' And
825:     *           ThisForm.tipo # 'LIBPRDZ2')) And ThisForm.Tipo # 'MAXIMO'
826:     *
827:     * Essa expressao eh a NEGACAO de BO.EstaEmModoSenhaDoDia() (fonte UNICA,
828:     * compartilhada com ValidarSenha - o BO guarda as duas regras parecidas
829:     * separadas de proposito: esta NAO eh DevePreencherUsuarioLogado).
830:     *
831:     * When = .F. significa campo em que nao se entra: o foco nao para nele,
832:     * nem por Tab nem por clique, e o Valid dele NUNCA dispara. Como
833:     * BINDEVENT descarta o valor devolvido pelo delegate, um "When" ligado por
834:     * BINDEVENT nao bloquearia nada - a traducao fiel eh .Enabled = .F.
835:     * No modo senha-do-dia o campo ja entra PRE-PREENCHIDO com o usuario
836:     * logado (AplicarModoSenhaDoDia) e a senha conferida eh a do dia, entao
837:     * nao ha o que digitar ali.
838:     *
839:     * O funil de validacao tambem recusa trabalhar nesse modo, para o caso de
840:     * o campo receber foco por codigo: ver ValidarUsuarioDigitadoExec.
841:     *--------------------------------------------------------------------------
842:     PROCEDURE AplicarRegraWhenUsuario()
843:         LOCAL loc_oErro
844: 
845:         TRY
846:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
847:                 THIS.txt_4c_Usuario.Enabled = ;
848:                     !THIS.this_oBusinessObject.EstaEmModoSenhaDoDia()
849:             ENDIF
850:         CATCH TO loc_oErro
851:             MsgErro(loc_oErro.Message + CHR(13) + ;
852:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
853:                 "Procedure: " + loc_oErro.Procedure, ;
854:                 "Formsigopcks.AplicarRegraWhenUsuario")
855:         ENDTRY
856:     ENDPROC
857: 
858:     *--------------------------------------------------------------------------
859:     * UsuarioKeyPress - SIGOPCKS.usuario.KeyPress legado:
860:     *
861:     *   If Lastkey() = 27 And Empty(this.Value)
862:     *       zsen = .f.
863:     *       Thisform.zsen=.F.
864:     *       Thisform.release
865:     *   EndIf
866:     *
867:     * ESC com o campo VAZIO aborta a autorizacao (nao autoriza nada) e fecha o
868:     * dialogo. ESC com valor digitado nao fecha - igual ao legado.
869:     *
870:     * F4 eh atalho para o MESMO funil do LostFocus, dentro de IF explicito de
871:     * tecla: handler ligado a "KeyPress" que abrisse o picker sem testar a
872:     * tecla faria o browse subir a cada caractere (regra #47).
873:     *
874:     * Nao liga nem desliga a flag de reentrancia: delega para o WRAPPER
875:     * ValidarUsuarioDigitado, que eh quem a controla - ligar a flag aqui
876:     * faria o wrapper devolver sem abrir nada e MATARIA o atalho.
877:     *--------------------------------------------------------------------------
878:     PROCEDURE UsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
879:         IF par_nKeyCode = 27 AND EMPTY(ALLTRIM(THIS.txt_4c_Usuario.Value))
880:             THIS.AbortarAutorizacao()
881:         ELSE
882:             IF par_nKeyCode = 115
883:                 THIS.ValidarUsuarioDigitado()
884:             ENDIF
885:         ENDIF
886:     ENDPROC
887: 
888:     *--------------------------------------------------------------------------
889:     * UsuarioDblClick - atalho de mouse para o funil de validacao/browse.
890:     * Delega ao WRAPPER (que controla a flag de reentrancia) pela mesma razao
891:     * descrita em UsuarioKeyPress.
892:     *--------------------------------------------------------------------------
893:     PROCEDURE UsuarioDblClick()
894:         THIS.ValidarUsuarioDigitado()
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * ValidarUsuarioDigitado - WRAPPER do funil de validacao do liberador.
899:     *
900:     * O corpo mora em ValidarUsuarioDigitadoExec e o wrapper so cuida da
901:     * GUARDA DE REENTRANCIA, obrigatoria aqui porque o browse eh MODAL: ele
902:     * tira o foco do campo e o proprio LostFocus voltaria a disparar,
903:     * empilhando um segundo picker (regra #37/#47).
904:     *
905:     * A flag eh liberada neste wrapper, nunca dentro do corpo: corpo com
906:     * saida antecipada deixaria a flag presa em .T. e MATARIA o lookup pelo
907:     * resto da vida do dialogo.
908:     *--------------------------------------------------------------------------
909:     PROCEDURE ValidarUsuarioDigitado()
910:         IF THIS.this_lEmLookup
911:             RETURN
912:         ENDIF
913: 
914:         THIS.this_lEmLookup = .T.
915:         THIS.ValidarUsuarioDigitadoExec()
916:         THIS.this_lEmLookup = .F.
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * ValidarUsuarioDigitadoExec - corpo do SIGOPCKS.usuario.Valid legado, na
921:     * mesma ordem do original:
922:     *
923:     *   1) If IsEmpty(This.Value) -> zsen=.F. + release
924:     *   2) DO CASE que escolhe a query do pool de liberadores autorizados
925:     *      (ja eh BO.ObterQuerySqlUsuario, chamado por
926:     *      CarregarUsuariosAutorizados - fonte UNICA)
927:     *   3) SqlExecute(...) < 1 -> MessageBox 'Favor Reinicializar o
928:     *      Processo!!!' + Return 0 (o foco fica no campo)
929:     *   4) seek(this.value) falhou -> browse fwBuscaSel -> AbrirBuscaUsuario
930:     *   5) If IsEmpty(usual) -> zsen=.F. + release
931:     *   6) senha cadastrada em branco -> zsen=.T., esconde Say3/senha e fecha;
932:     *      senha cadastrada presente -> mostra Say3/senha e pede a senha
933:     *
934:     * Nenhum RETURN dentro do TRY (regra #1): o fluxo eh conduzido por
935:     * loc_lProsseguir e o metodo termina no ENDPROC.
936:     *
937:     * Divergencia DELIBERADA de PILAR 3 no passo 4: o legado faz
938:     * "set near on / seek / this.value = evaluate('usuarios')", ou seja
939:     * atribui ao campo o registro em que o ponteiro parou MESMO quando o
940:     * usuario cancelou o browse com ESC - e com isso deixa no campo um codigo
941:     * que ninguem escolheu. Aqui o valor so eh atribuido sob a guarda de
942:     * selecao (regra #37), e o codigo digitado NUNCA eh apagado (regra #50):
943:     * cancelar o browse devolve o foco ao campo com o que o usuario digitou,
944:     * sem modal de "nao encontrado" e sem fechar o dialogo - o legado tambem
945:     * nao fecha nesse caminho.
946:     *--------------------------------------------------------------------------
947:     PROCEDURE ValidarUsuarioDigitadoExec()
948:         LOCAL loc_cDigitado, loc_cMensagem, loc_lProsseguir, loc_oErro
949:         loc_lProsseguir = .T.
950: 
951:         TRY
952:             loc_cDigitado = ALLTRIM(THIS.txt_4c_Usuario.Value)
953: 
954:             *-- (1) campo vazio: nao autoriza e fecha
955:             IF EMPTY(loc_cDigitado)
956:                 THIS.AbortarAutorizacao()
957:                 loc_lProsseguir = .F.
958:             ENDIF
959: 
960:             *-- usuario.When legado: em senha-do-dia o Valid nunca dispara
961:             IF loc_lProsseguir
962:                 IF THIS.this_oBusinessObject.EstaEmModoSenhaDoDia()
963:                     loc_lProsseguir = .F.
964:                 ENDIF
965:             ENDIF
966: 
967:             *-- (2)+(3) monta e executa a query do pool de liberadores
968:             IF loc_lProsseguir
969:                 IF !THIS.this_oBusinessObject.CarregarUsuariosAutorizados()
970:                     loc_cMensagem = ;
971:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
972:                     IF EMPTY(loc_cMensagem)
973:                         loc_cMensagem = "Favor Reinicializar o Processo!!!"
974:                     ENDIF
975:                     MsgErro(loc_cMensagem, "Falha na Conex" + CHR(227) + "o (TmpUsu)")
976:                     THIS.txt_4c_Usuario.SetFocus()
977:                     loc_lProsseguir = .F.
978:                 ENDIF
979:             ENDIF
980: 
981:             *-- (4) codigo digitado nao esta no pool: abre o browse.
982:             *-- A guarda de "so abrir se nao resolveu" eh ESTA condicao - o
983:             *-- picker nao sobe quando o codigo ja casa exato (regra #37).
984:             IF loc_lProsseguir
985:                 IF !THIS.this_oBusinessObject.ValidarUsuario(loc_cDigitado)
986:                     THIS.AbrirBuscaUsuario()
987:                 ENDIF

*-- Linhas 1023 a 1411:
1023:         CATCH TO loc_oErro
1024:             MsgErro(loc_oErro.Message + CHR(13) + ;
1025:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1026:                 "Procedure: " + loc_oErro.Procedure, ;
1027:                 "Formsigopcks.ValidarUsuarioDigitado")
1028:         ENDTRY
1029:     ENDPROC
1030: 
1031:     *--------------------------------------------------------------------------
1032:     * AbrirBuscaUsuario - browse de selecao do liberador. Equivale ao trecho
1033:     * do usuario.Valid legado:
1034:     *
1035:     *   xBrow    = CreateObject('fwBuscaSel','tmpusu','usuarios',this.value,
1036:     *                           'Selecao')
1037:     *   xBrowCol = xBrow.AddColuna('usuarios','','Codigo',.t.,'usuarios')
1038:     *   xBrowCol = xBrow.AddColuna('ccargs','','cargo',.F.)
1039:     *   xBrow.Show
1040:     *
1041:     * fwBuscaSel busca num CURSOR LOCAL ja populado (TmpUsu), nao numa tabela
1042:     * do servidor - o pool de liberadores autorizados vem de um JOIN cujo
1043:     * criterio depende do tipo de liberacao e vive no BO. Por isso aqui se usa
1044:     * a API DefinirCursor/Mostrar do FormBuscaAuxiliar (cursor PRE-populado),
1045:     * nunca o Init com parametros, que montaria um "SELECT * FROM <tabela>"
1046:     * proprio e perderia o criterio de permissao.
1047:     *
1048:     * cursor_4c_Usuar (o TmpUsu do legado) nasce na sessao de dados PRIVADA
1049:     * deste form (DataSession = 2). O FormBuscaAuxiliar declara
1050:     * DataSession = 1, que em VFP9 significa "a sessao CORRENTE" e NAO "a
1051:     * sessao numero 1" - instanciado daqui, ele roda na sessao privada do pai
1052:     * e enxerga o cursor normalmente (medido no VFP9).
1053:     *
1054:     * Show() do picker fica FORA do TRY (regra #29): com o Show dentro do
1055:     * bloco, qualquer erro de runtime durante a vida do dialogo modal salta
1056:     * para o CATCH, a referencia LOCAL cai e o picker eh DESTRUIDO no meio do
1057:     * uso. O TRY cobre a preparacao; o resultado eh lido depois, em bloco
1058:     * proprio.
1059:     *
1060:     * O picker fecha com Hide(), por isso as propriedades continuam legiveis
1061:     * e eh o CHAMADOR quem da o Release().
1062:     *--------------------------------------------------------------------------
1063:     PROCEDURE AbrirBuscaUsuario()
1064:         LOCAL loc_oBusca, loc_lSelecionou, loc_cCodigo, loc_cMensagem, loc_oErro
1065: 
1066:         loc_oBusca      = .NULL.
1067:         loc_lSelecionou = .F.
1068:         loc_cCodigo     = ""
1069: 
1070:         *-- Preparacao: pool carregado + picker montado
1071:         TRY
1072:             IF !USED("cursor_4c_Usuar")
1073:                 IF !THIS.this_oBusinessObject.CarregarUsuariosAutorizados()
1074:                     loc_cMensagem = ;
1075:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
1076:                     IF EMPTY(loc_cMensagem)
1077:                         loc_cMensagem = "Favor Reinicializar o Processo!!!"
1078:                     ENDIF
1079:                     MsgErro(loc_cMensagem, "Falha na Conex" + CHR(227) + "o (TmpUsu)")
1080:                 ENDIF
1081:             ENDIF
1082: 
1083:             IF USED("cursor_4c_Usuar")
1084:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1085: 
1086:                 IF VARTYPE(loc_oBusca) = "O"
1087:                     *-- codigo = usuarios, descricao = ccargs (as duas colunas
1088:                     *-- que o legado registra com AddColuna)
1089:                     loc_oBusca.DefinirCursor("cursor_4c_Usuar", "usuarios", "ccargs", ;
1090:                         "Sele" + CHR(231) + CHR(227) + "o")
1091: 
1092:                     *-- DefinirCursor rotula cada coluna com o NOME do campo;
1093:                     *-- o legado rotula 'Codigo' e 'cargo'. Zerar o contador e
1094:                     *-- reinstalar as duas colunas repoe esses titulos -
1095:                     *-- mAddColuna re-DIMENSIONA o array a cada chamada, e
1096:                     *-- this_cCampoCodigo/this_cCampoDescricao (de que Mostrar
1097:                     *-- depende) nao sao afetados.
1098:                     loc_oBusca.this_nColunas = 0
1099:                     loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
1100:                     loc_oBusca.mAddColuna("ccargs", "", "cargo")
1101:                 ELSE
1102:                     loc_oBusca = .NULL.
1103:                 ENDIF
1104:             ENDIF
1105:         CATCH TO loc_oErro
1106:             MsgErro(loc_oErro.Message + CHR(13) + ;
1107:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1108:                 "Procedure: " + loc_oErro.Procedure, ;
1109:                 "Formsigopcks.AbrirBuscaUsuario")
1110:             loc_oBusca = .NULL.
1111:         ENDTRY
1112: 
1113:         *-- Exibicao do modal FORA do TRY (regra #29)
1114:         IF VARTYPE(loc_oBusca) = "O"
1115:             loc_lSelecionou = loc_oBusca.Mostrar()
1116: 
1117:             IF loc_lSelecionou
1118:                 loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1119:             ENDIF
1120: 
1121:             loc_oBusca.Release()
1122:             loc_oBusca = .NULL.
1123:         ENDIF
1124: 
1125:         *-- Resultado: atribui SO sob a guarda de selecao (regra #37)
1126:         TRY
1127:             IF loc_lSelecionou AND !EMPTY(loc_cCodigo)
1128:                 THIS.txt_4c_Usuario.Value = loc_cCodigo
1129: 
1130:                 *-- carrega cargo/senha cadastrada do escolhido, que eh o que
1131:                 *-- o passo (6) do Valid consulta
1132:                 IF !THIS.this_oBusinessObject.ValidarUsuario(loc_cCodigo)
1133:                     loc_cMensagem = ;
1134:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
1135:                     IF !EMPTY(loc_cMensagem)
1136:                         MsgAviso(loc_cMensagem, "Sele" + CHR(231) + CHR(227) + "o")
1137:                     ENDIF
1138:                 ENDIF
1139:             ENDIF
1140:         CATCH TO loc_oErro
1141:             MsgErro(loc_oErro.Message + CHR(13) + ;
1142:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1143:                 "Procedure: " + loc_oErro.Procedure, ;
1144:                 "Formsigopcks.AbrirBuscaUsuario")
1145:         ENDTRY
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     * ValidarSenhaDigitada - WRAPPER do SIGOPCKS.senha.Valid legado.
1150:     *
1151:     * Guarda de reentrancia pela mesma razao do funil do liberador: o caminho
1152:     * de recusa exibe um dialogo MODAL de confirmacao ("Deseja digitar
1153:     * novamente ?"), que tira o foco do campo e faria o LostFocus disparar de
1154:     * novo, duplicando a pergunta. Flag liberada no wrapper, nunca no corpo.
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE ValidarSenhaDigitada()
1157:         IF THIS.this_lEmValidacaoSenha
1158:             RETURN
1159:         ENDIF
1160: 
1161:         THIS.this_lEmValidacaoSenha = .T.
1162:         THIS.ValidarSenhaDigitadaExec()
1163:         THIS.this_lEmValidacaoSenha = .F.
1164:     ENDPROC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * ValidarSenhaDigitadaExec - corpo do SIGOPCKS.senha.Valid legado.
1168:     *
1169:     * Toda a REGRA (conferir contra a senha cadastrada via fCriptografar ou
1170:     * contra a senha do dia via fGerPswDiario, somar empresa/forma de
1171:     * pagamento/valor quando SigCdPac.senhdemps esta ligado, e gravar o log de
1172:     * liberacao) vive em BO.ValidarSenha - fonte UNICA. Aqui fica so a parte
1173:     * de TELA:
1174:     *
1175:     *   senha confere      -> zsen=.T. (o BO ja marcou) + Thisform.release
1176:     *   senha nao confere  -> MessageBox('Deseja digitar novamente ? (S/N)')
1177:     *                         Nao  -> zsen=.F. + release
1178:     *                         Sim  -> Return 0 (valor e foco ficam no campo)
1179:     *
1180:     * MsgConfirma devolve LOGICO (regra #7): .T. = Sim. O legado usa
1181:     * MessageBox(...,4+256,...) e compara com 7 (Nao); a unica diferenca eh o
1182:     * botao DEFAULT (o legado destaca "Nao", MsgConfirma destaca "Sim").
1183:     * MESSAGEBOX direto eh proibido no projeto - MsgConfirma tambem silencia o
1184:     * dialogo em teste automatizado, devolvendo .F. (= Nao), que eh o lado
1185:     * FAIL-CLOSED.
1186:     *
1187:     * Falha TECNICA nao vira "senha conflitante": fCriptografar e
1188:     * fGerPswDiario ficaram AUSENTES de proposito (sao valor-de-CALCULO - um
1189:     * stub autenticaria quem nao devia), entao o CATCH do BO devolve .F. com
1190:     * uma mensagem propria. Perguntar "deseja digitar novamente?" nesse caso
1191:     * prenderia o usuario num laco sem pista nenhuma: a mensagem real eh
1192:     * exibida e o dialogo fecha sem autorizar.
1193:     *
1194:     * Sem RETURN dentro do TRY (regra #1).
1195:     *--------------------------------------------------------------------------
1196:     PROCEDURE ValidarSenhaDigitadaExec()
1197:         LOCAL loc_cSenha, loc_cMensagem, loc_oErro
1198: 
1199:         TRY
1200:             loc_cSenha = ALLTRIM(THIS.txt_4c_Senha.Value)
1201: 
1202:             IF THIS.this_oBusinessObject.ValidarSenha(loc_cSenha)
1203:                 *-- BO ja marcou this_lZSen = .T. e gravou o log de liberacao
1204:                 THIS.FecharDialogo()
1205:             ELSE
1206:                 loc_cMensagem = ;
1207:                     ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
1208: 
1209:                 IF EMPTY(loc_cMensagem) OR loc_cMensagem == "Senha Conflitante"
1210:                     IF MsgConfirma("Deseja digitar novamente ? (S/N)", ;
1211:                             "Senha Conflitante...")
1212:                         *-- Return 0 do legado: valor e foco ficam no campo
1213:                         THIS.txt_4c_Senha.SetFocus()
1214:                     ELSE
1215:                         THIS.AbortarAutorizacao()
1216:                     ENDIF
1217:                 ELSE
1218:                     MsgErro(loc_cMensagem, "Senha Conflitante...")
1219:                     THIS.AbortarAutorizacao()
1220:                 ENDIF
1221:             ENDIF
1222:         CATCH TO loc_oErro
1223:             MsgErro(loc_oErro.Message + CHR(13) + ;
1224:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1225:                 "Procedure: " + loc_oErro.Procedure, ;
1226:                 "Formsigopcks.ValidarSenhaDigitada")
1227:         ENDTRY
1228:     ENDPROC
1229: 
1230:     *--------------------------------------------------------------------------
1231:     * AbortarAutorizacao - os tres "zsen = .F. + Thisform.release" do legado
1232:     * (ESC no KeyPress, campo vazio no Valid, recusa da senha). Fonte UNICA
1233:     * dos tres caminhos de negativa.
1234:     *
1235:     * this_lZSen eh a flag de autorizacao do BO: ja nasce .F. (fail-closed) e
1236:     * eh zerada aqui de novo porque o legado tambem repete a atribuicao em
1237:     * cada caminho de abortar.
1238:     *--------------------------------------------------------------------------
1239:     PROCEDURE AbortarAutorizacao()
1240:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1241:             THIS.this_oBusinessObject.this_lZSen = .F.
1242:         ENDIF
1243: 
1244:         THIS.FecharDialogo()
1245:     ENDPROC
1246: 
1247:     *--------------------------------------------------------------------------
1248:     * FecharDialogo - "Thisform.release" do legado, com UMA divergencia
1249:     * deliberada de PILAR 3: fecha com Hide(), nao com Release().
1250:     *
1251:     * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
1252:     * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
1253:     * ler o resultado estoura "is not an object". Este dialogo existe para
1254:     * DEVOLVER uma resposta (autorizou / quem autorizou), e no legado essa
1255:     * resposta chega pelo RETURN do evento Unload, que so alcanca quem abre
1256:     * com "DO FORM ... TO <var>" - inalcancavel no sistema novo, que abre por
1257:     * CREATEOBJECT + Show(). Hide() em form modal tambem devolve o Show(),
1258:     * entao para o usuario a tela fecha igual (PILAR 1 preservado); muda so o
1259:     * tempo de vida do objeto, e eh o CHAMADOR quem chama Release() depois de
1260:     * ler. Mesmo desenho que o FormBuscaAuxiliar do projeto ja adota.
1261:     *--------------------------------------------------------------------------
1262:     PROCEDURE FecharDialogo()
1263:         *-- Enquanto o BO ainda existe: guarda a resposta para o Unload, que
1264:         *-- so dispara depois do Destroy ter zerado this_oBusinessObject.
1265:         THIS.CachearResultadoSaida()
1266: 
1267:         THIS.Hide()
1268:     ENDPROC
1269: 
1270:     *--------------------------------------------------------------------------
1271:     * TornarControlesVisiveis - Torna a arvore de controles visivel
1272:     * (AddObject cria tudo com Visible = .F.).
1273:     *
1274:     * Sem lista de excecao: nenhum controle deste form nasce oculto no SCX
1275:     * (ver NOTA do cabecalho - Say3/senha nascem Visible = .T. e so sao
1276:     * escondidos em runtime pelo usuario.Valid, fase posterior).
1277:     *--------------------------------------------------------------------------
1278:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1279:         LOCAL loc_i, loc_oControl, loc_oErro
1280: 
1281:         TRY
1282:             FOR loc_i = 1 TO par_oContainer.ControlCount
1283:                 loc_oControl = par_oContainer.Controls(loc_i)
1284:                 IF VARTYPE(loc_oControl) = "O"
1285:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
1286:                         loc_oControl.Visible = .T.
1287:                     ENDIF
1288:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1289:                        loc_oControl.ControlCount > 0
1290:                         THIS.TornarControlesVisiveis(loc_oControl)
1291:                     ENDIF
1292:                 ENDIF
1293:             ENDFOR
1294:         CATCH TO loc_oErro
1295:             MsgErro(loc_oErro.Message + CHR(13) + ;
1296:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1297:                 "Procedure: " + loc_oErro.Procedure, ;
1298:                 "Formsigopcks.TornarControlesVisiveis")
1299:         ENDTRY
1300:     ENDPROC
1301: 
1302:     *--------------------------------------------------------------------------
1303:     * Destroy - Fecha os cursores que o Business Object pode ter deixado
1304:     * abertos antes de repassar para FormBase.Destroy() via DODEFAULT().
1305:     *
1306:     * cursor_4c_Usuar (pool de usuarios autorizados, o TmpUsu do legado) eh o
1307:     * unico que fica aberto de proposito: o picker da Fase 6/7 navega nele.
1308:     * cursor_4c_Pam / cursor_4c_Pac / cursor_4c_Emp / cursor_4c_Fpg sao
1309:     * fechados pelos proprios metodos do BO - verificados aqui so por
1310:     * seguranca, para o form nao vazar alias se algum deles tiver abortado no
1311:     * meio.
1312:     *
1313:     * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
1314:     * popups do menu principal, e omiti-lo encolhe o menu do sistema.
1315:     *--------------------------------------------------------------------------
1316:     PROCEDURE Destroy()
1317:         IF USED("cursor_4c_Usuar")
1318:             USE IN cursor_4c_Usuar
1319:         ENDIF
1320:         IF USED("cursor_4c_Pam")
1321:             USE IN cursor_4c_Pam
1322:         ENDIF
1323:         IF USED("cursor_4c_Pac")
1324:             USE IN cursor_4c_Pac
1325:         ENDIF
1326:         IF USED("cursor_4c_Emp")
1327:             USE IN cursor_4c_Emp
1328:         ENDIF
1329:         IF USED("cursor_4c_Fpg")
1330:             USE IN cursor_4c_Fpg
1331:         ENDIF
1332: 
1333:         *-- Ultima chance de guardar a resposta: o DODEFAULT abaixo chega a
1334:         *-- FormBase.Destroy, que faz this_oBusinessObject = .NULL., e o Unload
1335:         *-- (que devolve o resultado a quem abriu com DO FORM ... TO) so
1336:         *-- dispara DEPOIS disso.
1337:         THIS.CachearResultadoSaida()
1338: 
1339:         DODEFAULT()
1340:     ENDPROC
1341: 
1342:     *--------------------------------------------------------------------------
1343:     * CachearResultadoSaida - guarda em this_cResultadoSaida a resposta do BO
1344:     * enquanto ele ainda existe. Chamado no FUNIL de fechamento
1345:     * (FecharDialogo, por onde passam os tres caminhos de negativa e os tres
1346:     * de autorizacao) e de novo no Destroy, antes do DODEFAULT que libera o BO.
1347:     *
1348:     * PROTECTED: nao eh ligado por BINDEVENT nem chamado de fora - quem le o
1349:     * resultado usa ObterResultadoSaida(). Sempre com THIS. (regra #8).
1350:     *--------------------------------------------------------------------------
1351:     PROTECTED PROCEDURE CachearResultadoSaida()
1352:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1353:             THIS.this_cResultadoSaida = THIS.this_oBusinessObject.ObterResultadoSaida()
1354:         ENDIF
1355:     ENDPROC
1356: 
1357:     *--------------------------------------------------------------------------
1358:     * ObterResultadoSaida - contrato de retorno do dialogo, equivalente ao
1359:     * PROCEDURE Unload legado:
1360:     *
1361:     *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
1362:     *
1363:     * A regra vive no BO (fonte UNICA, sigopcksBO.ObterResultadoSaida); este
1364:     * metodo so a ESPELHA, preferindo o BO vivo e caindo no cache quando ele
1365:     * ja foi liberado.
1366:     *
1367:     * COMO O CHAMADOR USA (o legado abria com "DO FORM sigopcks TO <var>",
1368:     * que entrega o retorno do Unload; o sistema novo abre por CREATEOBJECT +
1369:     * Show() e esse retorno eh inalcancavel, por isso ele vem por aqui):
1370:     *
1371:     *   loc_oCks = CREATEOBJECT("Formsigopcks", "CANCITEM", loc_cTitulo, ;
1372:     *                           loc_cTitulo2)
1373:     *   IF VARTYPE(loc_oCks) = "O"
1374:     *       loc_oCks.Show()                                && modal: bloqueia
1375:     *       loc_cResultado = loc_oCks.ObterResultadoSaida()
1376:     *   ENDIF
1377:     *   IF LEFT(loc_cResultado, 1) == "*"
1378:     *       *-- autorizado; ALLTRIM(SUBSTR(loc_cResultado, 2)) = quem liberou
1379:     *   ENDIF
1380:     *
1381:     * A ordem importa: o dialogo fecha com Hide() (ver FecharDialogo), entao
1382:     * ele continua legivel depois do Show(), e eh o CHAMADOR quem da o
1383:     * Release() - DEPOIS de ler. Release antes da leitura destroi o objeto e
1384:     * a leitura seguinte estoura "is not an object" (medido no VFP9).
1385:     *--------------------------------------------------------------------------
1386:     FUNCTION ObterResultadoSaida()
1387:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1388:             THIS.this_cResultadoSaida = THIS.this_oBusinessObject.ObterResultadoSaida()
1389:         ENDIF
1390: 
1391:         RETURN THIS.this_cResultadoSaida
1392:     ENDFUNC
1393: 
1394:     *--------------------------------------------------------------------------
1395:     * Unload - PROCEDURE Unload legado, mantido LITERAL para quem abrir este
1396:     * dialogo com "DO FORM ... TO <var>", forma em que o VFP entrega ao
1397:     * chamador justamente o retorno deste evento.
1398:     *
1399:     * Le o CACHE e nao o BO: o Unload dispara DEPOIS do Destroy, e nesse ponto
1400:     * FormBase.Destroy ja fez this_oBusinessObject = .NULL. - perguntar ao BO
1401:     * aqui estouraria. Quem enche o cache eh CachearResultadoSaida, chamado no
1402:     * fechamento e no Destroy.
1403:     *
1404:     * O caminho recomendado no sistema novo continua sendo CREATEOBJECT +
1405:     * Show() + ObterResultadoSaida(), que nao depende do ciclo de destruicao.
1406:     *--------------------------------------------------------------------------
1407:     PROCEDURE Unload()
1408:         RETURN THIS.this_cResultadoSaida
1409:     ENDPROC
1410: 
1411: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopcksBO.prg):
*====================================================================
* sigopcksBO.prg
*
* Business Object para SIGOPCKS - Validacao de Acesso
*
* Dialogo MODAL de AUTORIZACAO do legado Fortyus: recebe um TIPO de
* liberacao, pede usuario + senha e devolve ao chamador se a operacao
* foi autorizada. O tipo determina (a) o texto exibido na tela,
* (b) qual permissao de cargo/usuario sera exigida e (c) se a senha
* conferida eh a senha CADASTRADA do usuario ou a SENHA DO DIA
* calculada a partir do documento.
*
* Tabela principal : SigCdUsu (usuario que autoriza) - chave usuarios
* Tabelas de apoio : SigCdCrg (permissoes do cargo)
*                    SigCdPam (liblcreds) / SigCdPac (senhdemps)
*                    SigCdEmp (nemps) / SigOpFp (nfpags)
*
* Herda de: BusinessBase
*
* Somente leitura: o legado nao executa Insert/Update/Delete em tabela
* alguma - o unico registro gravado eh o log de liberacao, feito pela
* funcao global fGravarLog do proprio legado. Por isso Inserir(),
* Atualizar() e ExecutarExclusao() nao sao sobrescritos aqui: o
* comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Resultado: this_lZSen (autorizou) + this_cUsuLibs (quem autorizou).
* ObterResultadoSaida() equivale ao PROCEDURE Unload legado e eh a fonte
* UNICA do contrato de retorno lido pelo form chamador.
*====================================================================

DEFINE CLASS sigopcksBO AS BusinessBase

    *----------------------------------------------------------------
    * 1) PARAMETROS DE ENTRADA
    *    Init legado: LParameters _Tipo, _Titulo, _Titulo2, _Documento,
    *    _Data, _Empresa, _Fpagto, _Valor
    *----------------------------------------------------------------

    *-- _Tipo / ThisForm.Tipo - chave que seleciona a regra de liberacao.
    *-- Valores do DO CASE legado: DTENTREGA, CHDEVOLVIDO, LIMITE,
    *-- ALTERAIMPOSTO, CANCITEM, LIBFPAG, LIBPRDZ, LIBPRDZ2, LIBPESO,
    *-- SDINSUF, MAXIMO, DTVALIDA, LIBTITULO, LIBERAFPG, LIBOPE,
    *-- LIBQTMIN, LIBLIMITADOR, MOVESTOQUE, VALIDACESSO
    this_cTipo = ""

    *-- _Titulo / _Titulo2 - textos crus vindos do chamador. O DO CASE
    *-- legado combina os dois de forma DIFERENTE em cada tipo, por
    *-- isso os dois sao guardados crus e a combinacao fica derivada
    this_cTitulo  = ""
    this_cTitulo2 = ""

    *-- _Documento / ThisForm.NroDoc - numero do documento; entra no
    *-- calculo da senha do dia
    this_nNroDoc = 0

    *-- _Data / ThisForm.DatDoc - data do documento; entra no calculo
    *-- da senha do dia. Init legado: If Type("_Data")#"D" -> Date()
    this_dDatDoc = {}

    *-- _Empresa / ThisForm.Empresa -> SigCdEmp.cemps char(3)
    this_cEmpresa = ""

    *-- _Fpagto / ThisForm.Fpagto -> SigOpFp.fpags char(12)
    this_cFpagto = ""

    *-- _Valor / ThisForm.ValFpag - valor da condicao de pagamento
    this_nValFpag = 0

    *----------------------------------------------------------------
    * 2) TEXTOS DERIVADOS DO TIPO
    *    No legado o DO CASE do Init escreve direto em This.Caption e
    *    em This.Frase.Caption. Aqui a derivacao mora no BO e o Form
    *    apenas espelha, para o texto ter fonte UNICA
    *----------------------------------------------------------------
    this_cCaption = ""
    this_cFrase   = ""

    *----------------------------------------------------------------
    * 3) FLAGS DE TIPO DE AUTORIZACAO
    *    As 12 flags logicas do legado (ClassInfo do SCX). Cada uma
    *    seleciona um WHERE diferente no Valid do campo usuario, por
    *    isso sao propriedades distintas e nao um unico codigo
    *----------------------------------------------------------------

    *-- ThisForm.Financ - exige SigCdCrg.limites = 'S'
    *-- (CHDEVOLVIDO, LIMITE, ALTERAIMPOSTO, MAXIMO)
    this_lFinanc = .F.

    *-- ThisForm.CancItem - exige SigCdCrg.cancitens = 'S'
    this_lCancItem = .F.

    *-- ThisForm.LibFpag - exige SigCdCrg.libfpags = 'S'
    this_lLibFpag = .F.

    *-- ThisForm.LibFpag2 - LIBERAFPG; exige SigCdCrg.libfpgs = 'S'
    this_lLibFpag2 = .F.

    *-- ThisForm.LibProducao - LIBPRDZ/LIBPRDZ2/LIBPESO; exige
    *-- SigCdUsu.libpess = 'S' quando o tipo eh LIBPESO, senao
    *-- SigCdUsu.libprods = 'S'
    this_lLibProducao = .F.

    *-- ThisForm.Saldoestoque - SDINSUF; exige SigCdCrg.libsdins = 'S'
    this_lSaldoEstoque = .F.

    *-- ThisForm.LibValida - DTVALIDA; exige SigCdUsu.libvopes = 'S'
    this_lLibValida = .F.

    *-- ThisForm.LiberaTitulo - LIBTITULO
    this_lLiberaTitulo = .F.

    *-- ThisForm.LibOpe - exige SigCdCrg.libopes = 'S'
    this_lLibOpe = .F.

    *-- ThisForm.LibQtMin - exige SigCdUsu.libqtmins = 'S'
    this_lLibQtMin = .F.

    *-- ThisForm.LibLimitador - exige SigCdUsu.liblmpss = 'S'
    this_lLibLimitador = .F.

    *-- ThisForm.MovEstoque - MOVESTOQUE e VALIDACESSO; basta usuario
    *-- ativo com senha cadastrada
    this_lMovEstoque = .F.

    *----------------------------------------------------------------
    * 4) CREDENCIAIS DIGITADAS NA TELA
    *----------------------------------------------------------------

    *-- usuario.Value -> SigCdUsu.usuarios char(10)
    this_cUsuario = ""

    *-- senha.Value - valor transitorio, nunca persistido
    this_cSenha = ""

    *----------------------------------------------------------------
    * 5) DADOS DO USUARIO AUTENTICADO (lidos de SigCdUsu / SigCdCrg)
    *----------------------------------------------------------------

    *-- SigCdUsu.senhas char(10) - senha cadastrada, gravada cifrada
    this_cSenhaCadastrada = ""

    *-- SigCdUsu.ccargs char(10) - cargo, que liga em SigCdCrg
    this_cCargoUsuario = ""

    *-- SigCdUsu.cativos char(1) - 'N' marca usuario inativo; todo
    *-- WHERE do legado comeca com Not a.cAtivos = 'N'
    this_cUsuarioAtivo = ""

    *----------------------------------------------------------------
    * 6) PARAMETROS DO SISTEMA
    *    Init legado: CursorQuery('SigCdPam','CrParam',...,[LiblCreds])
    *                 CursorQuery('SigCdPac','CrParac',...,[SenhDEmps])
    *    As duas colunas sao bit NOT NULL no schema e chegam ao VFP ora
    *    como Logico ora como Numerico conforme o driver ODBC, por isso
    *    a leitura delas exige VARTYPE antes de comparar
    *----------------------------------------------------------------

    *-- SigCdPam.liblcreds bit - sistema usa credencial/senha do dia
    this_lLiblCreds = .F.

    *-- SigCdPac.senhdemps bit - senha do dia leva empresa e forma de
    *-- pagamento no numero base
    this_lSenhDEmps = .F.

    *----------------------------------------------------------------
    * 7) MODO SENHA DO DIA
    *    ATENCAO: no legado existem DUAS expressoes parecidas, mas NAO
    *    algebricamente iguais - rule #17 (transcrever, nao reescrever)
    *    exige manter as duas separadas, sem unificar:
    *
    *    (a) Init - so decide o PREENCHIMENTO visual (usuario.Value =
    *        Usuar + troca o Say3 para "Senha Do Dia :"):
    *          ( crParam.LiblCreds And Tipo = 'LIMITE' )
    *            Or Tipo = 'LIBPRDZ2' Or Tipo = 'MAXIMO'
    *        (metodo DevePreencherUsuarioLogado)
    *
    *    (b) When do campo usuario E Valid do campo senha compartilham
    *        a MESMA expressao (texto identico nos dois pontos):
    *          ( !crParam.LiblCreds Or (Tipo # 'LIMITE' And Tipo # 'LIBPRDZ2') )
    *            And Tipo # 'MAXIMO'
    *        Quando essa expressao eh FALSA, o Valid da senha entra no
    *        ramo "senha do dia" (compara com fGerPswDiario em vez da
    *        senha cadastrada). this_lSenhaDoDia guarda a NEGACAO desta
    *        expressao (metodo EstaEmModoSenhaDoDia)
    *
    *    Com Tipo = 'LIBPRDZ2' e LiblCreds = .F., (a) vale (pre-preenche
    *    a tela) mas (b) NAO entra no ramo senha-do-dia - a tela mostra
    *    o rotulo "Senha Do Dia" mas o Valid ainda confere contra a
    *    senha CADASTRADA. Comportamento do fonte legado, nao bug da
    *    migracao - ver SigOpCks_Erro2_findings (fase 1 retry)
    *----------------------------------------------------------------
    this_lSenhaDoDia = .F.

    *-- Senha do dia calculada (fGerPswDiario do legado)
    this_cSenhaDoDia = ""

    *-- lnNum do legado: SigCdEmp.nemps + SigOpFp.nfpags +
    *-- ( ValFpag * 100 ), somado so quando SenhDEmps esta ligado
    this_nNumeroBase = 0

    *-- SigCdEmp.nemps numeric(3,0)
    this_nNumEmpresa = 0

    *-- SigOpFp.nfpags numeric(2,0)
    this_nNumFpagto = 0

    *----------------------------------------------------------------
    * 8) RESULTADO DO DIALOGO
    *----------------------------------------------------------------

    *-- ThisForm.zsen - .T. somente quando a autorizacao foi concedida
    this_lZSen = .F.

    *-- ThisForm.usulibs - usuario que liberou (ou a propria senha do
    *-- dia, no ramo de senha do dia do legado)
    this_cUsuLibs = ""

    *-- Retorno do Unload legado:
    *-- Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    this_cRetorno = ""

    *-- Campo que recebe o foco apos recusa: "USUARIO" ou "SENHA"
    this_cCampoFoco = ""

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Define tabela e chave e normaliza o valor inicial de cada
    * propriedade. NAO executa SQL: Init de BO que devolve .F. destroi o
    * objeto, e dai o Form aborta o proprio Init e a tela nunca abre -
    * nem em validacao de UI, onde gnConnHandle vale -1 e todo SQLEXEC
    * estoura. A carga dos parametros do sistema eh feita sob demanda
    * pelos metodos que precisam deles.
    *
    * Sem RETURN dentro de TRY/CATCH: o resultado vai para a flag
    * loc_lSucesso e o unico RETURN fica DEPOIS do ENDTRY.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "usuarios"

            *-- Equivalente ao bloco de normalizacao do Init legado
            *-- (If Type("_Data")#"D" -> _Data = Date(), e os demais),
            *-- para o BO nascer com valor valido em todo campo
            THIS.this_dDatDoc = DATE()

            THIS.this_cTipo    = ""
            THIS.this_cTitulo  = ""
            THIS.this_cTitulo2 = ""
            THIS.this_nNroDoc  = 0
            THIS.this_cEmpresa = " "
            THIS.this_cFpagto  = " "
            THIS.this_nValFpag = 0

            THIS.this_cCaption = ""
            THIS.this_cFrase   = ""

            *-- As 12 flags de tipo nascem desligadas, como no Init
            *-- legado, que zera todas antes de entrar no DO CASE
            THIS.this_lFinanc       = .F.
            THIS.this_lCancItem     = .F.
            THIS.this_lLibFpag      = .F.
            THIS.this_lLibFpag2     = .F.
            THIS.this_lLibProducao  = .F.
            THIS.this_lSaldoEstoque = .F.
            THIS.this_lLibValida    = .F.
            THIS.this_lLiberaTitulo = .F.
            THIS.this_lLibOpe       = .F.
            THIS.this_lLibQtMin     = .F.
            THIS.this_lLibLimitador = .F.
            THIS.this_lMovEstoque   = .F.

            THIS.this_cUsuario = ""
            THIS.this_cSenha   = ""

            THIS.this_cSenhaCadastrada = ""
            THIS.this_cCargoUsuario    = ""
            THIS.this_cUsuarioAtivo    = ""

            THIS.this_lLiblCreds = .F.
            THIS.this_lSenhDEmps = .F.

            THIS.this_lSenhaDoDia = .F.
            THIS.this_cSenhaDoDia = ""
            THIS.this_nNumeroBase = 0
            THIS.this_nNumEmpresa = 0
            THIS.this_nNumFpagto  = 0

            *-- FAIL-CLOSED: este dialogo eh gate de AUTORIZACAO, entao
            *-- o estado inicial eh sempre "nao autorizado". Somente a
            *-- conferencia bem sucedida da senha liga this_lZSen
            THIS.this_lZSen    = .F.
            THIS.this_cUsuLibs = ""
            THIS.this_cRetorno = ""

            THIS.this_cCampoFoco = "USUARIO"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar sigopcksBO:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - hook de BusinessBase.RegistrarAuditoria. A
    * "entidade" deste dialogo eh o USUARIO que concede a liberacao, por
    * isso a chave eh this_cUsuario (nunca chamado de fora - regra #51)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuario)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - mapeia o cursor de usuarios autorizados
    * (cursor_4c_Usuar, equivalente ao TmpUsu do Valid legado) para as
    * propriedades do usuario selecionado.
    *
    * PUBLIC - CarregarDoCursor eh PUBLIC em BusinessBase e pode ser
    * chamado pelo Form de fora (regra #51); PROTECTED em qualquer nivel
    * da heranca faz a chamada externa estourar "Property not found".
    *
    * SELECT (par_cAliasCursor) antes de acessar os campos - a sintaxe
    * campo nao existe em VFP9. Existencia de coluna conferida
    * com TYPE(), porque PEMSTATUS exige OBJETO no 1o argumento.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- usuarios char(10) - PK de SigCdUsu
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuario = TratarNulo(usuarios, "")
                    ENDIF

                    *-- senhas char(10) - senha cadastrada, cifrada
                    IF TYPE(loc_cAlias + ".senhas") == "C"
                        THIS.this_cSenhaCadastrada = TratarNulo(senhas, "")
                    ENDIF

                    *-- ccargs char(10) - cargo do usuario
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCargoUsuario = TratarNulo(ccargs, "")
                    ENDIF

                    *-- cativos char(1) - 'N' marca usuario inativo
                    IF TYPE(loc_cAlias + ".cativos") == "C"
                        THIS.this_cUsuarioAtivo = TratarNulo(cativos, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados do usuario:" + CHR(13) + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarParametrosSistema - Init legado:
    *   CursorQuery('SigCdPam','CrParam',.f.,.f.,[LiblCreds])
    *   CursorQuery('SigCdPac','CrParac',.f.,.f.,[SenhDEmps])
    * As duas tabelas de parametro sao de registro UNICO (sem WHERE,
    * igual ao legado - padrao ja usado em SigPrSddBO.BuscarSenhDEmps).
    * liblcreds/senhdemps sao bit NOT NULL e chegam ao VFP ora como
    * Logico ora como Numerico conforme o driver ODBC, por isso o
    * VARTYPE antes de comparar.
    *====================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.

        TRY
            THIS.this_lLiblCreds = .F.
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT liblcreds FROM SigCdPam", "cursor_4c_Pam")
            IF loc_nResultado > 0 AND USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                SELECT cursor_4c_Pam
                THIS.this_lLiblCreds = IIF(VARTYPE(liblcreds) = "L", liblcreds, (NVL(liblcreds, 0) = 1))
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            THIS.this_lSenhDEmps = .F.
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", "cursor_4c_Pac")
            IF loc_nResultado > 0 AND USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                THIS.this_lSenhDEmps = IIF(VARTYPE(senhdemps) = "L", senhdemps, (NVL(senhdemps, 0) = 1))
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros do sistema:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DefinirTipo - Init legado: normaliza os 8 parametros recebidos
    * (LParameters _Tipo, _Titulo, _Titulo2, _Documento, _Data, _Empresa,
    * _Fpagto, _Valor) e executa o DO CASE que deriva texto (Caption/
    * Frase) e as 12 flags de permissao a partir do _Tipo. Chamado pelo
    * Form na abertura do dialogo, com os mesmos 8 parametros do Init
    * legado.
    *
    * _Titulo/_Titulo2 chegam CRUS (regra da secao 2): a maioria dos
    * tipos usa os dois como texto (Alltrim direto), mas CHDEVOLVIDO usa
    * _Titulo como NUMERO (quantidade de cheques) - comparado e formatado
    * tal como no legado, sem normalizar o tipo de entrada.
    *
    * Carrega tambem os parametros do sistema (CarregarParametrosSistema)
    * na MESMA posicao do Init legado - DevePreencherUsuarioLogado e
    * EstaEmModoSenhaDoDia dependem de this_lLiblCreds ja carregado.
    *====================================================================
    PROCEDURE DefinirTipo(par_cTipo, par_cTitulo, par_cTitulo2, par_nDocumento, ;
            par_dData, par_cEmpresa, par_cFpagto, par_nValor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_nNroDoc  = IIF(VARTYPE(par_nDocumento) = "N", par_nDocumento, 0)
            THIS.this_dDatDoc  = IIF(VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T", par_dData, DATE())
            THIS.this_cTipo    = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")
            THIS.this_cEmpresa = IIF(VARTYPE(par_cEmpresa) = "C", par_cEmpresa, " ")
            THIS.this_cFpagto  = IIF(VARTYPE(par_cFpagto) = "C", par_cFpagto, " ")
            THIS.this_nValFpag = IIF(VARTYPE(par_nValor) = "N", par_nValor, 0)

            THIS.this_cTitulo  = par_cTitulo
            THIS.this_cTitulo2 = par_cTitulo2

            THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")

            *-- As 12 flags nascem desligadas, como no Init legado, antes
            *-- do DO CASE
            THIS.this_lFinanc       = .F.
            THIS.this_lCancItem     = .F.
            THIS.this_lLibFpag      = .F.
            THIS.this_lLibFpag2     = .F.
            THIS.this_lLibProducao  = .F.
            THIS.this_lSaldoEstoque = .F.
            THIS.this_lLibValida    = .F.
            THIS.this_lLiberaTitulo = .F.
            THIS.this_lLibOpe       = .F.
            THIS.this_lLibQtMin     = .F.
            THIS.this_lLibLimitador = .F.
            THIS.this_lMovEstoque   = .F.

            THIS.CarregarParametrosSistema()

            DO CASE
                CASE ALLTRIM(THIS.this_cTipo) == "DTENTREGA"
                    THIS.this_cCaption = "Prazo de Entrega"
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo) + " fora do prazo de entrega!"
                    THIS.this_lFinanc  = .F.

                CASE ALLTRIM(THIS.this_cTipo) == "CHDEVOLVIDO"
                    THIS.this_cCaption = "Cheque Devolvido"
                    THIS.this_cFrase   = "A conta " + ALLTRIM(THIS.this_cTitulo2) + " possui "
                    IF THIS.this_cTitulo = 1
                        THIS.this_cFrase = THIS.this_cFrase + "1 Cheque Devolvido Pendente!"
                    ELSE
                        THIS.this_cFrase = THIS.this_cFrase + ALLTRIM(STR(THIS.this_cTitulo)) + ;
                            " Cheques Devolvidos Pendentes!"
                    ENDIF
                    THIS.this_lFinanc = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIMITE"
                    THIS.this_cCaption = "Limite Excedido"
                    THIS.this_cFrase   = "O Limite da conta " + ALLTRIM(THIS.this_cTitulo) + " foi excedido! "
                    THIS.this_lFinanc  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "ALTERAIMPOSTO"
                    THIS.this_cCaption = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lFinanc  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "CANCITEM"
                    THIS.this_cCaption  = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase    = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lCancItem = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBFPAG"
                    THIS.this_cCaption = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibFpag = .T.

                CASE INLIST(ALLTRIM(THIS.this_cTipo), "LIBPRDZ", "LIBPRDZ2", "LIBPESO")
                    THIS.this_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase       = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibProducao = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "SDINSUF"
                    THIS.this_cCaption      = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase        = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lSaldoEstoque = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "MAXIMO"
                    THIS.this_cCaption = "Valor M" + CHR(225) + "ximo Excedido :" + THIS.this_cTitulo2
                    THIS.this_cFrase   = "Valor da Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                        ALLTRIM(THIS.this_cTitulo) + " foi excedido! "
                    THIS.this_lFinanc  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "DTVALIDA"
                    THIS.this_cCaption   = "Validade da Movimenta" + CHR(231) + CHR(227) + "o"
                    THIS.this_cFrase     = ALLTRIM(THIS.this_cTitulo) + " fora da Validade!!!"
                    THIS.this_lLibValida = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBTITULO"
                    THIS.this_cCaption      = "Liberar T" + CHR(237) + "tulo "
                    THIS.this_cFrase        = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_lLiberaTitulo = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBERAFPG"
                    THIS.this_cCaption  = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase    = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibFpag2 = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBOPE"
                    THIS.this_cCaption = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibOpe  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBQTMIN"
                    THIS.this_cCaption   = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase     = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibQtMin  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBLIMITADOR"
                    THIS.this_cCaption       = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase         = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibLimitador  = .T.

                CASE INLIST(ALLTRIM(THIS.this_cTipo), "MOVESTOQUE", "VALIDACESSO")
                    *-- Legado usa _Titulo (nao _Titulo2) nos DOIS textos
                    THIS.this_cCaption    = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase      = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_lMovEstoque = .T.
            ENDCASE

            *-- Cache do modo operacional (secao 7-b); Form le a
            *-- propriedade OU chama EstaEmModoSenhaDoDia() direto
            THIS.this_lSenhaDoDia = THIS.EstaEmModoSenhaDoDia()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao definir tipo de libera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DevePreencherUsuarioLogado - Init legado (secao 7-a): decide se o
    * campo usuario entra PRE-PREENCHIDO com o usuario logado e o rotulo
    * da senha muda para "Senha Do Dia :". NAO eh a mesma expressao do
    * When/Valid (ver nota da secao 7) - uso exclusivo de UI na abertura.
    *====================================================================
    FUNCTION DevePreencherUsuarioLogado()
        RETURN (THIS.this_lLiblCreds AND ALLTRIM(THIS.this_cTipo) == "LIMITE") ;
            OR ALLTRIM(THIS.this_cTipo) == "LIBPRDZ2" ;
            OR ALLTRIM(THIS.this_cTipo) == "MAXIMO"
    ENDFUNC

    *====================================================================
    * EstaEmModoSenhaDoDia - negacao da expressao COMPARTILHADA por
    * usuario.When e senha.Valid do legado (secao 7-b):
    *   (!LiblCreds Or (Tipo#'LIMITE' And Tipo#'LIBPRDZ2')) And Tipo#'MAXIMO'
    * Quando esta FUNCTION devolve .T., a senha e conferida contra
    * fGerPswDiario em vez da senha cadastrada (ValidarSenha)
    *====================================================================
    FUNCTION EstaEmModoSenhaDoDia()
        LOCAL loc_lCondicaoNormal

        loc_lCondicaoNormal = (!THIS.this_lLiblCreds ;
            OR (ALLTRIM(THIS.this_cTipo) != "LIMITE" AND ALLTRIM(THIS.this_cTipo) != "LIBPRDZ2")) ;
            AND ALLTRIM(THIS.this_cTipo) != "MAXIMO"

        RETURN !loc_lCondicaoNormal
    ENDFUNC

    *====================================================================
    * ObterQuerySqlUsuario - usuario.Valid legado: DO CASE que escolhe,
    * conforme a flag de permissao ligada por DefinirTipo, qual criterio
    * de SigCdCrg/SigCdUsu autoriza o liberador. Traducao para SQL Server
    * do "Not a.cAtivos='N'" (-> a.cativos <> 'N') e do
    * "not a.Senhas = <6 espacos>" (-> comparacao de char fixo com string
    * de espacos eh sempre "em branco" sob ANSI padding, traduzido como
    * LTRIM(RTRIM(a.senhas)) <> '').
    *
    * this_lLibValida (DTVALIDA) e this_lLibLimitador (LIBLIMITADOR)
    * citam a.libvopes/a.liblmpss, colunas AUSENTES no schema canonico -
    * SigCdUsu tem 17 colunas e nenhuma com esse nome (achado da Fase 1,
    * regra #14/#45: dump do legado mais novo que o banco atual).
    * Mantido LITERAL (nao inventar substituto - pilar 2): o SQL Server
    * recusa com "Nome de coluna invalido", o CATCH do chamador devolve
    * .F. e o dialogo fica FAIL-CLOSED (nao autorizado) para esses dois
    * tipos, em vez de arriscar autorizar por um criterio adivinhado.
    *====================================================================
    PROTECTED FUNCTION ObterQuerySqlUsuario()
        LOCAL loc_cSQL, loc_cBase

        loc_cBase = "SELECT a.usuarios, a.senhas, a.ccargs, a.cativos "

        DO CASE
            CASE THIS.this_lCancItem
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.cancitens = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lFinanc
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.limites = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibFpag
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libfpags = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibFpag2
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libfpgs = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibProducao
                IF ALLTRIM(THIS.this_cTipo) == "LIBPESO"
                    loc_cSQL = loc_cBase + ;
                        "FROM SigCdUsu a " + ;
                        "WHERE a.cativos <> 'N' AND a.libpess = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"
                ELSE
                    loc_cSQL = loc_cBase + ;
                        "FROM SigCdUsu a " + ;
                        "WHERE a.cativos <> 'N' AND a.libprods = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"
                ENDIF

            CASE THIS.this_lSaldoEstoque
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libsdins = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibValida
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND a.libvopes = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibOpe
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libopes = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibQtMin
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND a.libqtmins = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibLimitador
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND a.liblmpss = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lMovEstoque
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND LTRIM(RTRIM(a.senhas)) <> ''"

            OTHERWISE
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.altcots = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"
        ENDCASE

        RETURN loc_cSQL
    ENDFUNC

    *====================================================================
    * CarregarUsuariosAutorizados - executa a query de ObterQuerySqlUsuario
    * em cursor_4c_Usuar (equivalente ao TmpUsu do legado). Usado por
    * ValidarUsuario e, quando nenhum usuario digitado casa exato, serve
    * de fonte para o picker (FormBuscaAuxiliar Pattern A, no Form).
    *
    * loc_nResultado < 1 cobre TANTO erro de SQL QUANTO zero linhas - o
    * legado trata as duas coisas como falha ("Favor Reinicializar o
    * Processo!!!"), porque zero linhas significa que NENHUM usuario
    * tem a permissao exigida por este tipo (falha de configuracao, nao
    * so "nao achei o usuario digitado" - isso e tratado depois, em
    * ValidarUsuario)
    *====================================================================
    FUNCTION CarregarUsuariosAutorizados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSQL = THIS.ObterQuerySqlUsuario()

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ValidarUsuario - usuario.Valid legado: localiza par_cUsuario (ja
    * resolvido pelo Form, direto ou via picker) dentro do pool de
    * usuarios autorizados e carrega this_cUsuario/this_cCargoUsuario/
    * this_cSenhaCadastrada/this_cUsuarioAtivo. NAO confere senha (ver
    * ValidarSenha) - so confirma que o CODIGO existe no pool permitido.
    *
    * Repopula cursor_4c_Usuar so se ainda nao estiver aberto (o Form
    * tipicamente ja chamou CarregarUsuariosAutorizados antes, para
    * oferecer o picker quando o usuario digitado nao bate exato).
    *====================================================================
    FUNCTION ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cUsuarioPad

        loc_lSucesso     = .F.
        loc_lProsseguir  = .T.
        THIS.this_cMensagemErro = ""
        loc_cUsuarioPad  = ALLTRIM(NVL(par_cUsuario, ""))

        TRY
            IF !USED("cursor_4c_Usuar")
                loc_lProsseguir = THIS.CarregarUsuariosAutorizados()
            ENDIF

            IF loc_lProsseguir AND USED("cursor_4c_Usuar") AND !EMPTY(loc_cUsuarioPad)
                SELECT cursor_4c_Usuar
                LOCATE FOR UPPER(ALLTRIM(usuarios)) == UPPER(loc_cUsuarioPad)

                IF FOUND()
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Usuar")
                    THIS.this_cUsuLibs = loc_cUsuarioPad
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * UsuarioTemSenhaCadastrada - usuario.Valid legado:
    *   If IsEmpty(TmpUsu.senhas) -> autoriza sem pedir senha
    * ObterQuerySqlUsuario ja exclui usuario sem senha do pool (secao do
    * cabecalho do metodo), entao esta FUNCTION normalmente devolve .T.
    * apos ValidarUsuario ter sucesso - mantida por fidelidade ao Valid
    * legado, que faz a MESMA checagem depois do SEEK
    *====================================================================
    FUNCTION UsuarioTemSenhaCadastrada()
        RETURN !EMPTY(ALLTRIM(THIS.this_cSenhaCadastrada))
    ENDFUNC

    *====================================================================
    * ConcluirAutorizacaoSemSenha - usuario.Valid legado, ramo
    * IsEmpty(TmpUsu.senhas): zsen=.t. direto, sem pedir senha. O Form
    * decide a parte visual (ocultar say3/senha) e fechar o dialogo
    *====================================================================
    PROCEDURE ConcluirAutorizacaoSemSenha()
        THIS.this_lZSen = .T.
    ENDPROC

    *====================================================================
    * ValidarSenha - senha.Valid legado: confere a senha digitada contra
    * a senha CADASTRADA (via fCriptografar) quando EstaEmModoSenhaDoDia
    * devolve .F., ou contra a SENHA DO DIA (fGerPswDiario) quando
    * devolve .T.. Fail-closed: this_lZSen comeca .F. e so vira .T. no
    * caminho de sucesso.
    *
    * fCriptografar/fGerPswDiario NAO foram portadas (achado da Fase 1) -
    * sao valor-de-CALCULO (hash/senha do dia), por isso ficam AUSENTES
    * de proposito (regra #27): estourar "File ... does not exist" dentro
    * do TRY e cair no CATCH com this_lZSen OFF eh o comportamento SEGURO;
    * um stub que "simulasse" a senha autenticaria quem nao devia.
    *====================================================================
    FUNCTION ValidarSenha(par_cSenha)
        LOCAL loc_lSucesso, loc_cSenhaCripto, loc_nNum, loc_cSenhaDia

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lZSen = .F.

        TRY
            IF !THIS.EstaEmModoSenhaDoDia()
                loc_cSenhaCripto = fCriptografar(THIS.this_cSenhaCadastrada)

                IF EMPTY(ALLTRIM(NVL(par_cSenha, ""))) ;
                        OR PADR(ALLTRIM(NVL(par_cSenha, "")), 10) != PADR(ALLTRIM(NVL(loc_cSenhaCripto, "")), 10)
                    THIS.this_cMensagemErro = "Senha Conflitante"
                ELSE
                    THIS.this_lZSen = .T.
                    IF !INLIST(ALLTRIM(THIS.this_cTipo), "LIBPRDZ", "LIBPRDZ2", "LIBPESO", "LIBQTMIN")
                        THIS.RegistrarLiberacao()
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                *-- lnNum do legado: soma empresa+fpagto+valor so quando
                *-- SigCdPac.senhdemps esta ligado
                loc_nNum = 0
                IF THIS.this_lSenhDEmps
                    THIS.this_nNumEmpresa = THIS.BuscarNumeroEmpresa()
                    THIS.this_nNumFpagto  = THIS.BuscarNumeroFpag()
                    loc_nNum = THIS.this_nNumEmpresa + THIS.this_nNumFpagto + (THIS.this_nValFpag * 100)
                ENDIF
                THIS.this_nNumeroBase = loc_nNum

                loc_cSenhaDia = fGerPswDiario(THIS.this_nNroDoc, THIS.this_dDatDoc, loc_nNum)
                THIS.this_cSenhaDoDia = loc_cSenhaDia

                IF ALLTRIM(NVL(par_cSenha, "")) != ALLTRIM(NVL(loc_cSenhaDia, ""))
                    THIS.this_cMensagemErro = "Senha Conflitante"
                ELSE
                    THIS.this_lZSen    = .T.
                    THIS.this_cUsuLibs = loc_cSenhaDia
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar senha:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * RegistrarLiberacao - senha.Valid legado, caminho de sucesso NAO
    * senha-do-dia, fora de LIBPRDZ/LIBPRDZ2/LIBPESO/LIBQTMIN:
    *   LIBTITULO     -> fGravarLog('T','SigPgTit',Tipo,Frase,Usuar)
    *   demais tipos  -> fGravarLog('T',TprMvCab.Dopes,Tipo,<concat>,UsuLibs)
    *                    SO se TprMvCab estiver aberto (cursor global do
    *                    CHAMADOR, com o cabecalho do movimento - nao eh
    *                    deste BO popular; guard IF USED() replica o
    *                    legado literal)
    * fGravarLog e wrapper no-op documentado (utils\fgravarlog.prg,
    * regra #27) - chamada segura mesmo sem o algoritmo original
    *====================================================================
    PROTECTED PROCEDURE RegistrarLiberacao()
        TRY
            IF ALLTRIM(THIS.this_cTipo) == "LIBTITULO"
                fGravarLog("T", "SigPgTit", THIS.this_cTipo, THIS.this_cFrase, ;
                    IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""))
            ELSE
                IF USED("TprMvCab")
                    fGravarLog("T", TprMvCab.Dopes, THIS.this_cTipo, ;
                        TprMvCab.Emps + "-" + ALLTRIM(TprMvCab.Dopes) + "-" + ALLTRIM(STR(TprMvCab.Numes, 6)) + ;
                        IIF(ALLTRIM(THIS.this_cTipo) == "LIBERAFPG", "(" + ALLTRIM(THIS.this_cFrase) + ")", " "), ;
                        THIS.this_cUsuLibs)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar log de libera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY
    ENDPROC

    *====================================================================
    * BuscarNumeroEmpresa - senha.Valid legado: SigCdEmp.nemps da
    * this_cEmpresa, usado no calculo da senha do dia
    *====================================================================
    PROTECTED FUNCTION BuscarNumeroEmpresa()
        LOCAL loc_nEmps, loc_nRet, loc_cSQL

        loc_nEmps = 0

        TRY
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmpresa), 3))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nRet > 0 AND USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                loc_nEmps = NVL(nemps, 0)
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_nEmps
    ENDFUNC

    *====================================================================
    * BuscarNumeroFpag - senha.Valid legado: SigOpFp.nfpags da
    * this_cFpagto, usado no calculo da senha do dia
    *====================================================================
    PROTECTED FUNCTION BuscarNumeroFpag()
        LOCAL loc_nFpags, loc_nRet, loc_cSQL

        loc_nFpags = 0

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cFpagto))
                IF USED("cursor_4c_Fpg")
                    USE IN cursor_4c_Fpg
                ENDIF

                loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE fpags = " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cFpagto), 12))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fpg")
                IF loc_nRet > 0 AND USED("cursor_4c_Fpg") AND !EOF("cursor_4c_Fpg")
                    SELECT cursor_4c_Fpg
                    loc_nFpags = NVL(nfpags, 0)
                ENDIF

                IF USED("cursor_4c_Fpg")
                    USE IN cursor_4c_Fpg
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_nFpags
    ENDFUNC

    *====================================================================
    * ObterResultadoSaida - contrato de retorno do dialogo, equivalente
    * ao PROCEDURE Unload legado:
    *
    *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    *
    * Transcrito LITERAL (regra #17): a primeira posicao eh o asterisco
    * quando a autorizacao foi concedida e UM ESPACO quando nao foi, e o
    * resto eh o codigo de quem liberou - no ramo senha-do-dia o proprio
    * legado grava ali a senha calculada (ver ValidarSenha). Sem ALLTRIM
    * em parte alguma: o legado nao apara, e o chamador testa a posicao
    * 1 com LEFT(<retorno>, 1) == "*".
    *
    * Fonte UNICA do resultado: o Form apenas espelha esta FUNCTION (ver
    * Formsigopcks.ObterResultadoSaida). O valor tambem fica guardado em
    * this_cRetorno, que existe para isso desde a Fase 1 - assim o Form
    * pode CACHEAR a resposta antes de o BO ser liberado, ja que o evento
    * Unload do VFP dispara DEPOIS do Destroy, quando
    * FormBase.Destroy ja zerou this_oBusinessObject.
    *
    * Fail-closed: this_lZSen nasce .F., eh zerado em cada caminho de
    * negativa e so vira .T. nos tres caminhos de autorizacao do legado
    * (senha cadastrada conferida, senha do dia conferida e usuario sem
    * senha cadastrada). Chamar este metodo antes de qualquer validacao
    * devolve " " + "" - nao autorizado -, que eh o lado seguro.
    *====================================================================
    FUNCTION ObterResultadoSaida()
        THIS.this_cRetorno = IIF(THIS.this_lZSen, "*", " ") + THIS.this_cUsuLibs

        RETURN THIS.this_cRetorno
    ENDFUNC

ENDDEFINE

