# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C__REFERENCIA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1374 linhas total):

*-- Linhas 24 a 344:
24:     DataSession = 2
25: 
26:     *-- Propriedades de controle (equivalentes as do legado)
27:     this_cCodigoAnterior = ""      && ThisForm.AntCPro - valor anterior da coluna Codigo (Column1.When/Valid)
28:     this_cRetorno        = " "     && ThisForm.Retorno - "Ok" (confirmado) ou " " (cancelado)
29:     this_cCursorGrade    = "cursor_4c_Produtos"    && equivalente ao CrProduto do legado
30:     this_lFocoAplicado   = .F.     && foco inicial na grade ja aplicado (ver Activate)
31: 
32:     *-- Guarda de reentrancia do lookup de produto (regra #37/#47): o
33:     *-- FormBuscaAuxiliar eh MODAL, tira o foco da celula e redispara o
34:     *-- Valid/LostFocus que o chamou; as tres portas de entrada (Valid da
35:     *-- celula, F4 e duplo clique) desaguam no MESMO funil, entao sem esta
36:     *-- flag o usuario leva dois pickers empilhados.
37:     this_lEmLookupProduto = .F.
38: 
39:     *-- Guarda de reentrancia da confirmacao (botao Ok). O laco de espera do
40:     *-- legado (altera.Click) eh um "DO While ... Enddo" SEM DOEVENTS, que em
41:     *-- VFP9 bloqueia todo o processamento de eventos - o usuario nao
42:     *-- consegue clicar nem digitar enquanto a contagem roda. A versao
43:     *-- migrada CHAMA DOEVENTS de proposito (para o container de "Aguarde"
44:     *-- repintar os 13 blocos da animacao), e isso reabre a porta que o
45:     *-- legado mantinha fechada: sem esta flag, um segundo clique no Ok
46:     *-- entra de novo em BtnOkClick e inicia uma animacao ANINHADA.
47:     this_lEmConfirmacao = .F.
48: 
49:     *-- Espelho da lista de codigos montada pelo BO (this_cListaProdutos),
50:     *-- cacheado no Destroy ANTES de o BO ser liberado. Existe porque o
51:     *-- evento Unload dispara DEPOIS do Destroy e ja nao alcanca o BO
52:     *-- (mesma armadilha documentada no Formsigprdft, migrado do
53:     *-- SIGPRDFT.Unload) e porque o chamador que abre esta tela por
54:     *-- CREATEOBJECT + Show() nao tem acesso ao valor devolvido pelo Unload.
55:     this_cListaProdutosSelecionados = ""
56: 
57:     *====================================================================
58:     * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
59:     *====================================================================
60:     PROCEDURE Init()
61:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
62:         RETURN DODEFAULT()
63:     ENDPROC
64: 
65:     *====================================================================
66:     * InicializarForm - Cria Business Object, o cursor da grade, o
67:     * container principal (label + grade) e os botoes Ok/Cancelar.
68:     * Eventos de clique/validacao ficam para a fase de comportamento.
69:     *====================================================================
70:     PROTECTED PROCEDURE InicializarForm()
71:         LOCAL loc_lResultado
72:         loc_lResultado = .F.
73: 
74:         *-- Guarda de conexao do Init legado (ramo Else do
75:         *-- "If (.poDataMgr.pnIdconn > 0)"): sem banco a tela NAO abre.
76:         *-- Fica ANTES de tudo e com o RETURN aqui fora de qualquer
77:         *-- TRY/CATCH (regra #1).
78:         IF !THIS.ValidarParametros()
79:             RETURN .F.
80:         ENDIF
81: 
82:         THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Produtos"
83: 
84:         THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTRFBO")
85: 
86:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
87:             RETURN .F.
88:         ENDIF
89: 
90:         *-- Equivalente ao SQLEXEC de LocalParac no Init do legado (parametro
91:         *-- de tempo de espera usado na animacao de confirmacao do botao Ok)
92:         IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
93:             THIS.this_oBusinessObject.CarregarParametroTempoEspera()
94:         ENDIF
95: 
96:         *-- Equivalente ao "Create Cursor CrProduto" do Load legado - tem
97:         *-- de existir ANTES do Grid ser ligado a ele (regra do ControlSource
98:         *-- de cursor ainda inexistente derrubando o Init)
99:         THIS.CriarCursorProdutos()
100: 
101:         THIS.ConfigurarContainerReferencia()
102: 
103:         *-- Vincula a grade ao cursor e a repinta - equivalente ao bloco
104:         *-- "With Thisform.Cnt_Referencia.Grade / .RecordSource /
105:         *-- .ControlSource / .Refresh / EndWith" do Init legado. Fica em
106:         *-- metodo proprio para poder ser rechamado em TODO caminho que
107:         *-- recria ou repopula o cursor da grade.
108:         THIS.CarregarLista()
109: 
110:         *-- sigprtrf.oModem (OLE 100x100, Secao 1 do dump) nao tem nenhum
111:         *-- metodo/evento no dump (Secao 3) nem referencia em Secao 4 alem
112:         *-- do proprio form - objeto decorativo sem comportamento algum,
113:         *-- por isso omitido aqui; nenhuma funcionalidade do dialogo
114:         *-- depende dele (Ok/Cancelar e a grade nao o referenciam).
115:         THIS.ConfigurarBotoesPrincipais()
116: 
117:         THIS.ConfigurarContainerMensagem()
118: 
119:         THIS.TornarControlesVisiveis(THIS)
120: 
121:         loc_lResultado = .T.
122:         RETURN loc_lResultado
123:     ENDPROC
124: 
125:     *====================================================================
126:     * ValidarParametros - Transcricao da guarda de conexao do Init legado,
127:     * que RECUSA abrir a tela quando o banco nao esta utilizavel:
128:     *
129:     *   .poDataMgr = CreateObject('fSqlConector')
130:     *   If (.poDataMgr.pnIdconn > 0)
131:     *       ... monta a tela ...
132:     *   Else
133:     *       =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
134:     *                    de Dados...', 0+48, 'CreateObject')
135:     *       Return .f.
136:     *   EndIf
137:     *
138:     * Na nova arquitetura nao existe fSqlConector por tela: a conexao eh o
139:     * handle global gnConnHandle. O "pnIdconn > 0" do legado colapsa nas
140:     * duas checagens abaixo - handle ausente/nao-numerico e handle <= 0 -
141:     * preservando a mensagem e o titulo "CreateObject" do legado.
142:     *
143:     * O BYPASS de modo de teste eh obrigatorio: o harness de
144:     * 06b_testeAutomatico define gnConnHandle = 0 DE PROPOSITO (sentinela,
145:     * porque SQLSTRINGCONNECT bloqueia 300s no timeout TCP quando o
146:     * servidor esta inacessivel) e espera que os forms pulem as queries por
147:     * gb_4c_ModoTeste/gb_4c_ValidandoUI, nunca por checagem de handle. Sem
148:     * o bypass, esta guarda devolveria .F. -> InicializarForm devolve .F.
149:     * -> CREATEOBJECT devolve logico e o teste "Instanciacao" reprova
150:     * SEMPRE, sem nenhum erro de SQL no log.
151:     *
152:     * PUBLIC (sem PROTECTED): alem de ser chamado por THIS. no
153:     * InicializarForm, eh alcancavel pelo harness, que chama metodos do
154:     * form de FORA da classe (regra #3).
155:     *====================================================================
156:     PROCEDURE ValidarParametros()
157:         LOCAL loc_lValido
158:         loc_lValido = .T.
159: 
160:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
161:             RETURN .T.
162:         ENDIF
163: 
164:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
165:             RETURN .T.
166:         ENDIF
167: 
168:         DO CASE
169:             CASE TYPE("gnConnHandle") != "N"
170:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
171:                         "o com Servidor de Banco de Dados...", "CreateObject")
172:                 loc_lValido = .F.
173: 
174:             CASE gnConnHandle <= 0
175:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
176:                         "o com Servidor de Banco de Dados...", "CreateObject")
177:                 loc_lValido = .F.
178:         ENDCASE
179: 
180:         RETURN loc_lValido
181:     ENDPROC
182: 
183:     *====================================================================
184:     * CriarCursorProdutos - Cria o cursor local que alimenta a grade de
185:     * selecao de produtos (equivalente ao "Create Cursor CrProduto" do
186:     * Load legado) e inicia com uma linha vazia, pronta para digitacao
187:     * (equivalente ao "Select CrProduto / Append Blank" do Init legado).
188:     *====================================================================
189:     PROTECTED PROCEDURE CriarCursorProdutos()
190:         IF USED("cursor_4c_Produtos")
191:             USE IN cursor_4c_Produtos
192:         ENDIF
193: 
194:         CREATE CURSOR cursor_4c_Produtos (Cpros C(14), Dpros C(40))
195: 
196:         SELECT (THIS.this_cCursorGrade)
197:         APPEND BLANK
198:     ENDPROC
199: 
200:     *====================================================================
201:     * ConfigurarContainerReferencia - Cria o container principal (ja
202:     * existente desde a Fase 3) e adiciona seus filhos visuais: label de
203:     * identificacao e grade de produtos (Fase 4).
204:     *====================================================================
205:     PROTECTED PROCEDURE ConfigurarContainerReferencia()
206:         THIS.AddObject("cnt_4c__Referencia", "Container")
207:         WITH THIS.cnt_4c__Referencia
208:             .Top         = 1
209:             .Left        = 2
210:             .Width       = 433
211:             .Height      = 392
212:             .BackStyle   = 1
213:             .BackColor   = RGB(255, 255, 255)
214:             .BorderColor = RGB(128, 128, 128)
215:             .TabStop     = .F.
216:             .Visible     = .T.
217:         ENDWITH
218: 
219:         THIS.ConfigurarLabelIdentificacao()
220:         THIS.ConfigurarGradeProdutos()
221:     ENDPROC
222: 
223:     *====================================================================
224:     * ConfigurarLabelIdentificacao - Label "Informe os Produtos"
225:     * (sigprtrf.Cnt_Referencia.lblident no legado).
226:     *====================================================================
227:     PROTECTED PROCEDURE ConfigurarLabelIdentificacao()
228:         WITH THIS.cnt_4c__Referencia
229:             .AddObject("lbl_4c_Lblident", "Label")
230:             WITH .lbl_4c_Lblident
231:                 .Top       = 57
232:                 .Left      = 8
233:                 .Width     = 146
234:                 .Height    = 20
235:                 .AutoSize  = .F.
236:                 .Alignment = 2
237:                 .BackStyle = 0
238:                 .FontBold  = .T.
239:                 .FontSize  = 11
240:                 .ForeColor = RGB(0, 0, 255)
241:                 .Caption   = "Informe os Produtos"
242:             ENDWITH
243:         ENDWITH
244:     ENDPROC
245: 
246:     *====================================================================
247:     * ConfigurarGradeProdutos - Cria a grade de produtos (grd_4c_Dados),
248:     * 2 colunas (Codigo/Descricao). Equivalente a
249:     * sigprtrf.Cnt_Referencia.Grade (fwgrade) do legado.
250:     *
251:     * Aqui ficam SO as propriedades do GRID. O vinculo ao cursor mora em
252:     * CarregarLista() e o formato das COLUNAS em AplicarFormatoColunas(),
253:     * chamado de la - ver a explicacao nos dois metodos.
254:     *
255:     * Valid/When/LostFocus de Column1.Text1 (lookup de produto) e os
256:     * eventos dos botoes ficam para a fase de comportamento (Fase 7/8).
257:     *====================================================================
258:     PROTECTED PROCEDURE ConfigurarGradeProdutos()
259:         WITH THIS.cnt_4c__Referencia
260:             .AddObject("grd_4c_Dados", "Grid")
261:             WITH .grd_4c_Dados
262:                 .Top        = 78
263:                 .Left       = 3
264:                 .Width      = 429
265:                 .Height     = 309
266:                 .FontName   = "Arial"
267:                 .FontSize   = 8
268:                 .ScrollBars = 2
269:                 .RowHeight  = 17
270: 
271:                 *-- ColumnCount ANTES de qualquer referencia a .ColumnN:
272:                 *-- a Grid criada por AddObject nasce sem colunas
273:                 .ColumnCount = 2
274:             ENDWITH
275:         ENDWITH
276: 
277:         *-- Duplo clique na grade abre o picker de produto (mesmo funil do
278:         *-- F4 e do Valid da celula). O VFP entrega o DblClick ao controle
279:         *-- que estiver SOB o ponteiro: dentro da celula quem recebe eh o
280:         *-- TextBox da Column1 (tratado em TextBoxProdutoTrf_4c.DblClick);
281:         *-- fora dela - area vazia da grade, abaixo da ultima linha -
282:         *-- quem recebe eh o proprio Grid, e eh esse caminho que o
283:         *-- BINDEVENT cobre. As duas rotas chamam AbrirBuscaProdutoGrade,
284:         *-- que eh guardado por this_lEmLookupProduto, entao nao ha risco
285:         *-- de abrir dois pickers. Handler PUBLIC (regra #3).
286:         BINDEVENT(THIS.cnt_4c__Referencia.grd_4c_Dados, "DblClick", THIS, "GradeProdutosDblClick")
287:     ENDPROC
288: 
289:     *====================================================================
290:     * AplicarFormatoColunas - Formato das 2 colunas da grade de produtos
291:     * (fontes, mascaras, cabecalhos, larguras e a trava da coluna da
292:     * Descricao). Metodo PROPRIO porque tem de ser REAPLICADO depois de
293:     * cada vinculo: medido no VFP9 (2026-10-20), quando o alias da grade
294:     * eh derrubado o Grid cai para ColumnCount = 0 e, ao repor o
295:     * ColumnCount, os objetos Column nascem de novo com o DEFAULT -
296:     * Format "K!" volta a "", InputMask "!!!!!!!!!!" volta a "",
297:     * Courier New volta a Arial, Movable/Resizable voltam a .T.,
298:     * Header1.Alignment volta a 6 e Column2.ReadOnly volta a .F.
299:     * (isto eh, a coluna da Descricao volta a aceitar digitacao).
300:     *
301:     * Reatribuir RecordSource com o alias ABERTO nao reseta nada (tambem
302:     * medido), mas reaplicar eh idempotente e cobre os dois casos.
303:     *====================================================================
304:     PROTECTED PROCEDURE AplicarFormatoColunas()
305:         LOCAL loc_oGrade
306: 
307:         loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
308: 
309:         WITH loc_oGrade
310:             *-- Grid.ReadOnly propaga para as colunas, por isso vem ANTES
311:             *-- do ReadOnly de coluna, la embaixo
312:             .ReadOnly = .F.
313: 
314:             .Column1.Width     = 108
315:             .Column1.FontName  = "Courier New"
316:             .Column1.FontSize  = 8
317:             .Column1.Movable   = .F.
318:             .Column1.Resizable = .F.
319:             .Column1.Format    = "K!"
320:             .Column1.ReadOnly  = .F.
321:             .Column1.Header1.FontName  = "Arial"
322:             .Column1.Header1.FontSize  = 8
323:             .Column1.Header1.Alignment = 2
324:             .Column1.Header1.Caption   = "C" + CHR(243) + "d. Produto"
325:             *-- Lookup de produto (legado: Grade.Column1.Text1.Valid, fwBuscaExt
326:             *-- contra SigCdPro) + avanco automatico de linha (legado:
327:             *-- Grade.Column1.Text1.LostFocus) + snapshot do valor anterior
328:             *-- (legado: Grade.Column1.Text1.When). Column.AddObject sozinho
329:             *-- NAO exibe o controle - precisa de CurrentControl + Sparse
330:             *-- (regra #18); a validacao mora no Valid do TextBox da coluna
331:             *-- (regra #46), NUNCA em AfterRowColChange. Guarda defensiva
332:             *-- porque este metodo eh REAPLICADO sempre que o ColumnCount eh
333:             *-- reposto (ver cabecalho do metodo) - sem ela, o 2o AddObject
334:             *-- estoura "Object txt_4c_CelCodigo is already defined".
335:             IF !PEMSTATUS(.Column1, "txt_4c_CelCodigo", 5)
336:                 .Column1.AddObject("txt_4c_CelCodigo", "TextBoxProdutoTrf_4c")
337:             ENDIF
338:             .Column1.CurrentControl = "txt_4c_CelCodigo"
339:             .Column1.Sparse         = .F.
340: 
341:             .Column2.Width     = 290
342:             .Column2.FontName  = "Courier New"
343:             .Column2.FontSize  = 8
344:             .Column2.Movable   = .F.

*-- Linhas 371 a 414:
371:     * chamado de fora da classe (THISFORM) pelo TextBox da coluna
372:     * (TextBoxProdutoTrf_4c.When, em classes\TextBoxGridLookup.prg).
373:     *====================================================================
374:     PROCEDURE GuardarCodigoAnteriorProduto(par_oTxt)
375:         IF VARTYPE(par_oTxt) = "O"
376:             THIS.this_cCodigoAnterior = par_oTxt.Value
377:         ENDIF
378:     ENDPROC
379: 
380:     *====================================================================
381:     * ValidarCodigoProdutoGridExec - Valid da celula "Codigo" (Column1) da
382:     * grade de produtos. par_oTxt eh o TextBox da coluna (regra #46):
383:     * dentro do Valid, o valor digitado esta em par_oTxt.Value e AINDA NAO
384:     * chegou ao cursor.
385:     *
386:     * Equivalente ao legado (Grade.Column1.Text1.Valid):
387:     *   If This.Value = ThisForm.AntCPro / Return / EndIf
388:     *   If Not Empty(This.Value)
389:     *       fwBuscaExt(poDataMgr.pnIdConn,'SigCdPro','CrProds','cpros',
390:     *                   This.Value,'Produtos',1000)
391:     *       Se nao achou exato, mAddColuna + Show() (picker)
392:     *       Se Used('CrProds'): This.Value = Cpros,
393:     *           Replace CrProduto.Dpros With CrProds.dpros,
394:     *           Column2.Text1.Value = Dpros
395:     *   EndIf
396:     *====================================================================
397:     FUNCTION ValidarCodigoProdutoGridExec(par_oTxt)
398: 
399:         IF VARTYPE(par_oTxt) != "O"
400:             RETURN .T.
401:         ENDIF
402: 
403:         *-- "If This.Value = ThisForm.AntCPro / Return" - nao mudou, nao
404:         *-- reabre o lookup
405:         IF par_oTxt.Value = THIS.this_cCodigoAnterior
406:             RETURN .T.
407:         ENDIF
408: 
409:         *-- "If Not Empty(This.Value)" - campo vazio NAO abre lookup pelo
410:         *-- Valid (o legado so consulta com valor digitado). O F4 e o duplo
411:         *-- clique, ao contrario, abrem com o campo vazio de proposito -
412:         *-- por isso esta guarda mora AQUI e nao dentro do funil.
413:         IF EMPTY(ALLTRIM(par_oTxt.Value))
414:             RETURN .T.

*-- Linhas 435 a 885:
435:     *
436:     * PUBLIC: chamado de fora da classe (THISFORM) pelo TextBox da coluna.
437:     *====================================================================
438:     PROCEDURE AbrirBuscaProdutoGrade(par_oTxt)
439:         IF THIS.this_lEmLookupProduto
440:             RETURN
441:         ENDIF
442: 
443:         THIS.this_lEmLookupProduto = .T.
444:         THIS.AbrirBuscaProdutoGradeExec(par_oTxt)
445:         THIS.this_lEmLookupProduto = .F.
446:     ENDPROC
447: 
448:     *====================================================================
449:     * AbrirBuscaProdutoGradeExec - corpo do lookup de produto. Transcricao
450:     * do legado (Grade.Column1.Text1.Valid):
451:     *
452:     *   m.loLista = CreateObject('fwBuscaExt', poDataMgr.pnIdConn,
453:     *                 'SigCdPro','CrProds','cpros',This.Value,'Produtos',1000)
454:     *   If !(m.loLista.plAchouRegistro)
455:     *       m.loLista.mAddColuna('cpros','','Codigo')
456:     *       m.loLista.mAddColuna('dpros','','Descricao')
457:     *       m.loLista.Show()
458:     *   EndIf
459:     *   If Used('CrProds')
460:     *       This.Value = Evaluate('CrProds.Cpros')
461:     *       Replace CrProduto.Dpros With CrProds.dpros in CrProduto
462:     *       This.Parent.Parent.Column2.Text1.Value = Evaluate('CrProds.Dpros')
463:     *   EndIf
464:     *====================================================================
465:     PROTECTED PROCEDURE AbrirBuscaProdutoGradeExec(par_oTxt)
466:         LOCAL loc_cCodigo, loc_oBusca, loc_oErro
467: 
468:         IF VARTYPE(par_oTxt) != "O"
469:             RETURN
470:         ENDIF
471: 
472:         IF !USED(THIS.this_cCursorGrade)
473:             RETURN
474:         ENDIF
475: 
476:         loc_cCodigo = ALLTRIM(par_oTxt.Value)
477: 
478:         TRY
479:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
480:                 "SigCdPro", "cursor_4c_BuscaProdutoTrf", "cpros", loc_cCodigo, ;
481:                 "Produtos")
482: 
483:             IF VARTYPE(loc_oBusca) = "O"
484:                 *-- Init ja tentou o match exato (regra #37) - so abre o
485:                 *-- picker se nao achou, sem MsgAviso nem clear do digitado
486:                 *-- (regra #50)
487:                 IF !loc_oBusca.this_lAchouRegistro
488:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
489:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
490:                     loc_oBusca.Show()
491:                 ENDIF
492: 
493:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoTrf") AND RECCOUNT("cursor_4c_BuscaProdutoTrf") > 0
494:                     SELECT cursor_4c_BuscaProdutoTrf
495: 
496:                     *-- Produto escolhido entra no BO e sai dele para a linha
497:                     *-- da grade por BOParaForm(), que concentra as TRES
498:                     *-- atribuicoes do legado (cursor.Dpros, This.Value da
499:                     *-- celula do Codigo e Column2.Text1.Value). Fonte unica:
500:                     *-- este caminho e o do Valid gravam pelo MESMO metodo.
501:                     THIS.this_oBusinessObject.this_cCodigoProduto    = ALLTRIM(NVL(cpros, ""))
502:                     THIS.this_oBusinessObject.this_cDescricaoProduto = ALLTRIM(NVL(dpros, ""))
503: 
504:                     THIS.BOParaForm()
505:                 ENDIF
506: 
507:                 loc_oBusca.Release()
508:             ENDIF
509:         CATCH TO loc_oErro
510:             MsgErro(loc_oErro.Message, "FormSIGPRTRF.AbrirBuscaProdutoGradeExec")
511:         ENDTRY
512: 
513:         IF USED("cursor_4c_BuscaProdutoTrf")
514:             USE IN cursor_4c_BuscaProdutoTrf
515:         ENDIF
516:     ENDPROC
517: 
518:     *====================================================================
519:     * GradeProdutosDblClick - duplo clique na grade (ligado por BINDEVENT
520:     * em ConfigurarGradeProdutos). Cobre o clique FORA da area da celula -
521:     * dentro dela o DblClick eh consumido pelo TextBox da Column1
522:     * (TextBoxProdutoTrf_4c.DblClick), que chama o mesmo funil.
523:     *
524:     * PUBLIC: BINDEVENT nao enxerga metodo PROTECTED (regra #3).
525:     *====================================================================
526:     PROCEDURE GradeProdutosDblClick()
527:         LOCAL loc_oGrade, loc_oCelula
528: 
529:         loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
530: 
531:         *-- O lookup eh da coluna do Codigo; nas outras colunas o duplo
532:         *-- clique nao faz nada (a Descricao eh somente-leitura no legado)
533:         IF loc_oGrade.ActiveColumn != 1
534:             RETURN
535:         ENDIF
536: 
537:         loc_oCelula = THIS.ObterCelulaCodigo()
538: 
539:         IF VARTYPE(loc_oCelula) != "O"
540:             RETURN
541:         ENDIF
542: 
543:         THIS.AbrirBuscaProdutoGrade(loc_oCelula)
544:     ENDPROC
545: 
546:     *====================================================================
547:     * AvancarLinhaProdutoGridExec - equivalente ao legado
548:     * (Grade.Column1.Text1.LostFocus): ao SAIR da celula do Codigo com
549:     * ENTER, garante uma linha vazia abaixo para continuar digitando e
550:     * avanca a grade para ela (ou foca o botao Ok, se a linha corrente
551:     * ainda estiver vazia).
552:     *
553:     *   If Lastkey() = 13
554:     *       If Empty(cpros)
555:     *           ThisForm.Altera.SetFocus
556:     *       Else
557:     *           _lnRecno = Recno()
558:     *           Locate For Empty(Cpros)
559:     *           If Eof()
560:     *               Append Blank
561:     *           EndIf
562:     *           Locate For Recno() = _lnRecno
563:     *           Keyboard '{DNARROW}'
564:     *       EndIf
565:     *   EndIf
566:     *====================================================================
567:     PROCEDURE AvancarLinhaProdutoGridExec()
568:         LOCAL loc_nRecnoAtual
569: 
570:         IF LASTKEY() != 13
571:             RETURN
572:         ENDIF
573: 
574:         IF !USED(THIS.this_cCursorGrade)
575:             RETURN
576:         ENDIF
577: 
578:         SELECT (THIS.this_cCursorGrade)
579: 
580:         IF EMPTY(cpros)
581:             THIS.cmd_4c_Altera.SetFocus()
582:         ELSE
583:             loc_nRecnoAtual = RECNO()
584: 
585:             LOCATE FOR EMPTY(cpros)
586:             IF EOF()
587:                 APPEND BLANK
588:             ENDIF
589: 
590:             LOCATE FOR RECNO() = loc_nRecnoAtual
591:             KEYBOARD "{DNARROW}"
592:         ENDIF
593:     ENDPROC
594: 
595:     *====================================================================
596:     * ConfigurarBotoesPrincipais - Shape decorativo (sigprtrf.Shape1, por
597:     * baixo dos dois botoes) + botoes Ok (altera) e Cancelar (sair) do
598:     * dialogo. Click (validacao + animacao de confirmacao / encerramento)
599:     * fica para a fase de comportamento (Fase 7/8).
600:     *====================================================================
601:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
602:         THIS.AddObject("shp_4c_Shape1", "Shape")
603:         WITH THIS.shp_4c_Shape1
604:             .Top           = 396
605:             .Left          = 311
606:             .Width         = 121
607:             .Height        = 52
608:             .SpecialEffect = 0
609:         ENDWITH
610: 
611:         THIS.AddObject("cmd_4c_Altera", "CommandButton")
612:         WITH THIS.cmd_4c_Altera
613:             .Top             = 399
614:             .Left            = 314
615:             .Width           = 58
616:             .Height          = 47
617:             .FontName        = "Arial"
618:             .FontSize        = 7
619:             .FontBold        = .T.
620:             .ForeColor       = RGB(0, 128, 0)
621:             .Caption         = "\<Ok"
622:             .Cancel          = .F.
623:             .Picture         = gc_4c_CaminhoIcones + "a_save1.bmp"
624:             .Themes          = .T.
625:             .DisabledPicture = gc_4c_CaminhoIcones + "a_save1.bmp"
626:         ENDWITH
627: 
628:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
629:         WITH THIS.cmd_4c_Sair
630:             .Top             = 399
631:             .Left            = 372
632:             .Width           = 75
633:             .Height          = 75
634:             .FontName        = "Arial"
635:             .FontSize        = 7
636:             .FontBold        = .T.
637:             .ForeColor       = RGB(0, 0, 0)
638:             .Caption         = "Encerrar"
639:             .Cancel          = .T.
640:             .Picture         = gc_4c_CaminhoIcones + "cancelar.bmp"
641:             .Themes          = .T.
642:             .DisabledPicture = gc_4c_CaminhoIcones + "cancelar.bmp"
643:         ENDWITH
644: 
645:         *-- Handlers PUBLIC (regra #3 - BINDEVENT nao alcanca PROTECTED)
646:         BINDEVENT(THIS.cmd_4c_Altera, "Click", THIS, "BtnOkClick")
647:         BINDEVENT(THIS.cmd_4c_Sair,   "Click", THIS, "BtnCancelarClick")
648:     ENDPROC
649: 
650:     *====================================================================
651:     * ConfigurarContainerMensagem - Container flutuante de "Aguarde"
652:     * (animacao de confirmacao do botao Ok, legado Cnt_Mensagem).
653:     * Comeca OCULTO - so aparece durante a contagem de tempo do botao
654:     * Ok (ver BtnOkClick, Fase 7/8). O CONTAINER fica fora do filtro
655:     * recursivo de TornarControlesVisiveis (permanece oculto), por isso os
656:     * filhos dele precisam ser criados aqui JA com .Visible = .T. (o
657:     * default de AddObject eh .F.) - equivalente ao Visible = .T. que o
658:     * dump declara em Mensagem1 e em cada Botao.
659:     *====================================================================
660:     PROTECTED PROCEDURE ConfigurarContainerMensagem()
661:         THIS.AddObject("cnt_4c__Mensagem", "Container")
662:         WITH THIS.cnt_4c__Mensagem
663:             .Top           = 395
664:             .Left          = 3
665:             .Width         = 302
666:             .Height        = 55
667:             .SpecialEffect = 0
668:             .Visible       = .F.
669:         ENDWITH
670: 
671:         THIS.ConfigurarMensagemAguarde()
672:         THIS.ConfigurarBarraAnimacao()
673:     ENDPROC
674: 
675:     *====================================================================
676:     * ConfigurarMensagemAguarde - Label "Aguarde. Verificando Dados!!!"
677:     * (sigprtrf.Cnt_Mensagem.Mensagem1 no legado).
678:     *====================================================================
679:     PROTECTED PROCEDURE ConfigurarMensagemAguarde()
680:         WITH THIS.cnt_4c__Mensagem
681:             .AddObject("lbl_4c_Mensagem1", "Label")
682:             WITH .lbl_4c_Mensagem1
683:                 .Top       = 2
684:                 .Left      = 16
685:                 .Width     = 277
686:                 .Height    = 25
687:                 .AutoSize  = .F.
688:                 .FontBold  = .T.
689:                 .FontSize  = 14
690:                 .ForeColor = RGB(255, 0, 0)
691:                 .Visible   = .T.
692:                 .Caption   = "Aguarde. Verificando Dados!!!"
693:             ENDWITH
694:         ENDWITH
695:     ENDPROC
696: 
697:     *====================================================================
698:     * ConfigurarBarraAnimacao - Os 13 blocos coloridos do "termometro" de
699:     * espera (sigprtrf.Cnt_Mensagem.Botao1 / botao2..botao13 no legado).
700:     * BtnOkClick (Fase 7/8) alterna BackColor/Visible deles durante a
701:     * contagem de THIS.this_oBusinessObject.this_nTempoEspera, igual ao
702:     * "lcMacro = 'ThisForm.Cnt_Mensagem.botao'+Alltrim(Str(lnBot,2))" do
703:     * Click legado. Decorativos - nunca recebem foco nem clique (legado:
704:     * PROCEDURE When / Return .f. em todos os 13 -> aqui .TabStop = .F.).
705:     * Nomes txt_4c_Botao1..txt_4c_Botao13 para o handler de Fase 7/8
706:     * conseguir alcanca-los por STORE/EVALUATE com o mesmo indice do
707:     * legado (regra do projeto: nunca usar Controls("nome") nem macro
708:     * para atribuir propriedade).
709:     *====================================================================
710:     PROTECTED PROCEDURE ConfigurarBarraAnimacao()
711:         LOCAL loc_nI, loc_nLeft, loc_cNome
712: 
713:         FOR loc_nI = 1 TO 13
714:             loc_cNome = "txt_4c_Botao" + TRANSFORM(loc_nI)
715:             loc_nLeft = 55 + ((loc_nI - 1) * 16)
716: 
717:             THIS.cnt_4c__Mensagem.AddObject(loc_cNome, "TextBox")
718: 
719:             STORE 34             TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Top")
720:             STORE loc_nLeft      TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Left")
721:             STORE 13             TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Width")
722:             STORE 11             TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Height")
723:             STORE 0              TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".BorderStyle")
724:             STORE RGB(255, 0, 0) TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".BackColor")
725:             STORE .F.            TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".TabStop")
726:             STORE .T.            TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Visible")
727:         ENDFOR
728:     ENDPROC
729: 
730:     *====================================================================
731:     * BtnOkClick - Click do botao Ok (legado: sigprtrf.altera.Click).
732:     * Confere se ao menos um produto foi informado na grade (mesma conta
733:     * do legado: "Count to x for Not Empty(Cpros) / If x=0"), exibe a
734:     * animacao de confirmacao e fecha o dialogo com this_cRetorno = "Ok".
735:     *
736:     *   Select CrProduto
737:     *   Count to x for Not Empty(Cpros)
738:     *   If x=0
739:     *       MessageBox('Nenhum Produto Informado!!!',0+16,'')
740:     *       Return .f.
741:     *   Endif
742:     *   ... animacao ...
743:     *   ThisForm.Retorno = 'Ok'
744:     *   ThisForm.Release
745:     *
746:     * PUBLIC: ligado por BINDEVENT em ConfigurarBotoesPrincipais.
747:     *====================================================================
748:     PROCEDURE BtnOkClick()
749:         LOCAL loc_nQtde
750: 
751:         *-- Reentrancia: a animacao chama DOEVENTS, entao um segundo clique
752:         *-- no Ok chegaria aqui e iniciaria uma contagem ANINHADA
753:         IF THIS.this_lEmConfirmacao
754:             RETURN
755:         ENDIF
756: 
757:         IF !USED(THIS.this_cCursorGrade)
758:             RETURN
759:         ENDIF
760: 
761:         *-- Linha corrente para o BO antes de contar: enquanto o foco esta
762:         *-- na celula, o ultimo codigo digitado ainda nao chegou ao cursor
763:         THIS.FormParaBO()
764: 
765:         loc_nQtde = THIS.this_oBusinessObject.MontarListaProdutos(THIS.this_cCursorGrade)
766: 
767:         IF loc_nQtde = 0
768:             MsgAviso("Nenhum Produto Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
769:             RETURN
770:         ENDIF
771: 
772:         THIS.this_lEmConfirmacao = .T.
773: 
774:         *-- Grade e botoes desligados durante a contagem, reproduzindo o
775:         *-- laco bloqueante do legado (ver HabilitarCampos)
776:         THIS.HabilitarCampos(.F.)
777: 
778:         THIS.ExibirAnimacaoConfirmacao()
779: 
780:         THIS.HabilitarCampos(.T.)
781:         THIS.this_lEmConfirmacao = .F.
782: 
783:         THIS.this_cRetorno = "Ok"
784: 
785:         *-- Hide(), e NAO Release(): ver a nota de FecharDialogo()
786:         THIS.FecharDialogo()
787:     ENDPROC
788: 
789:     *====================================================================
790:     * FecharDialogo - Encerra o dialogo devolvendo o controle ao chamador,
791:     * mas PRESERVANDO o objeto para que ele possa ler o resultado.
792:     *
793:     * O legado faz "Thisform.release" e entrega o resultado pelo RETURN do
794:     * Unload, que so chega a quem abre a tela com "DO FORM ... TO <var>".
795:     * O sistema novo abre por CREATEOBJECT + Show(), e ai esse retorno eh
796:     * inalcancavel - o resultado tem de vir de property/metodo do form.
797:     *
798:     * Medido no VFP9 (2026-10-20) com o chamador segurando a referencia:
799:     *
800:     *   THIS.Release()  -> loForm passa a VARTYPE "X" e qualquer leitura
801:     *                      estoura "LOC_OFORM is not an object"
802:     *   THIS.Hide()     -> loForm segue "O", ObterRetorno() e
803:     *                      ObterListaProdutos() continuam legiveis, e o
804:     *                      Release do CHAMADOR encerra o objeto
805:     *
806:     * Ou seja: com Release() o dialogo nao teria como devolver a relacao de
807:     * produtos que eh a razao de ele existir. Hide() em form modal tambem
808:     * devolve o Show(), entao para o usuario a tela fecha igual (PILAR 1
809:     * preservado); muda so o tempo de vida do objeto, que eh decisao de
810:     * arquitetura (PILAR 3). Eh o mesmo desenho que o FormBuscaAuxiliar do
811:     * projeto ja adota - "Usa Hide() em vez de Release() para permitir
812:     * leitura de propriedades / Caller deve chamar Release() apos ler
813:     * valores" - e por isso os chamadores do projeto ja esperam liberar o
814:     * dialogo eles mesmos.
815:     *====================================================================
816:     PROCEDURE FecharDialogo()
817:         THIS.Hide()
818:     ENDPROC
819: 
820:     *====================================================================
821:     * ExibirAnimacaoConfirmacao - Reproduz a animacao de "Aguarde" do
822:     * legado (sigprtrf.altera.Click) durante
823:     * THIS.this_oBusinessObject.this_nTempoEspera segundos (ClockEcfs),
824:     * alternando BackColor/Visible dos 13 blocos de
825:     * cnt_4c__Mensagem.txt_4c_Botao1..13:
826:     *
827:     *   ThisForm.Cnt_Mensagem.Visible = .t.
828:     *   ldDataI = Datetime()
829:     *   _w = LocalParac.ClockEcfs / 3
830:     *   _x = 13
831:     *   DO While Datetime() - ldDataI < LocalParac.ClockEcfs
832:     *       _Tempo = Datetime() - ldDataI
833:     *       _x = Iif(_x >= 13, 1, _x + 1)
834:     *       <terco 1: vermelho (255) / terco 2: amarelo (65535) /
835:     *        terco 3: verde (4227072)>
836:     *       <botao1..13 .Visible = (botao <= _x)>
837:     *   Enddo
838:     *
839:     * As cores 65535/4227072/255 do legado sao RGB(255,255,0) [amarelo],
840:     * RGB(0,128,64) [verde] e RGB(255,0,0) [vermelho] - decompostas pela
841:     * formula VFP cor = R + G*256 + B*65536. Acesso aos 13 TextBox por
842:     * INDICE via STORE (regra do projeto: Controls() e indexado por
843:     * numero, nome de controle so com STORE/EVALUATE - nunca direto).
844:     *====================================================================
845:     PROTECTED PROCEDURE ExibirAnimacaoConfirmacao()
846:         LOCAL loc_dHoraInicio, loc_nTerco, loc_nQtdeVisivel, loc_nTempo, ;
847:               loc_nBotao, loc_cCaminho, loc_oErro
848: 
849:         IF THIS.this_oBusinessObject.this_nTempoEspera <= 0
850:             RETURN
851:         ENDIF
852: 
853:         *-- TRY/CATCH em volta do laco: sem ele, um erro no meio da
854:         *-- contagem sairia por cima de BtnOkClick (que tambem nao tem
855:         *-- TRY) e deixaria a tela TRAVADA - o painel de "Aguarde" visivel,
856:         *-- a grade e os dois botoes desligados por HabilitarCampos(.F.) e
857:         *-- this_lEmConfirmacao preso em .T., que bloqueia Ok e Cancelar.
858:         *-- Nao haveria como fechar o dialogo. O CATCH repoe o painel e
859:         *-- REPORTA (CATCH nunca silencioso - regra #9); quem religa grade
860:         *-- e botoes eh o BtnOkClick, que retoma o fluxo normal depois
861:         *-- desta chamada justamente porque o erro nao escapa daqui.
862:         THIS.cnt_4c__Mensagem.Visible = .T.
863: 
864:         loc_dHoraInicio  = DATETIME()
865:         loc_nTerco       = THIS.this_oBusinessObject.this_nTempoEspera / 3
866:         loc_nQtdeVisivel = 13
867: 
868:         TRY
869:             DO WHILE DATETIME() - loc_dHoraInicio < THIS.this_oBusinessObject.this_nTempoEspera
870:                 loc_nTempo = DATETIME() - loc_dHoraInicio
871: 
872:                 IF loc_nQtdeVisivel >= 13
873:                     loc_nQtdeVisivel = 1
874:                 ELSE
875:                     loc_nQtdeVisivel = loc_nQtdeVisivel + 1
876:                 ENDIF
877: 
878:                 FOR loc_nBotao = 1 TO 13
879:                     loc_cCaminho = "THIS.cnt_4c__Mensagem.txt_4c_Botao" + TRANSFORM(loc_nBotao)
880: 
881:                     IF loc_nTempo > loc_nTerco
882:                         IF loc_nTempo < loc_nTerco * 2
883:                             STORE RGB(255, 255, 0) TO (loc_cCaminho + ".BackColor")
884:                         ELSE
885:                             STORE RGB(0, 128, 64) TO (loc_cCaminho + ".BackColor")

*-- Linhas 898 a 1035:
898:             MsgErro("Erro durante a confirma" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
899:                     loc_oErro.Message + CHR(13) + ;
900:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
901:                     "Procedure: " + loc_oErro.Procedure, "Erro")
902:         ENDTRY
903: 
904:         THIS.cnt_4c__Mensagem.Visible = .F.
905:     ENDPROC
906: 
907:     *====================================================================
908:     * BtnCancelarClick - Click do botao Cancelar (legado:
909:     * sigprtrf.sair.Click):
910:     *   ThisForm.Retorno = ' '
911:     *   Thisform.release
912:     *
913:     * PUBLIC: ligado por BINDEVENT em ConfigurarBotoesPrincipais.
914:     *====================================================================
915:     PROCEDURE BtnCancelarClick()
916:         *-- Durante a contagem do Ok a tela esta "verificando dados" e os
917:         *-- dois botoes estao desligados; o Cancelar tem .Cancel = .T.
918:         *-- (atalho ESC), por isso a guarda tambem aqui
919:         IF THIS.this_lEmConfirmacao
920:             RETURN
921:         ENDIF
922: 
923:         THIS.this_cRetorno = " "
924: 
925:         *-- Hide(), e NAO Release(): ver a nota de FecharDialogo()
926:         THIS.FecharDialogo()
927:     ENDPROC
928: 
929:     *====================================================================
930:     * FormParaBO - Leva a LINHA CORRENTE da grade para o BO.
931:     *
932:     * Este dialogo nao tem campos soltos: a unica superficie de dados eh a
933:     * grade, e as duas colunas dela (Cpros/Dpros) sao exatamente as duas
934:     * propriedades do BO (this_cCodigoProduto/this_cDescricaoProduto). O
935:     * equivalente do legado eh o par de ControlSource que o Init declara
936:     * ('CrProduto.Cpros' / 'CrProduto.Dpros') - com ControlSource o VFP
937:     * transfere sozinho, e sem ele a transferencia tem de ser escrita.
938:     *
939:     * O valor digitado na celula do Codigo so chega ao CURSOR depois do
940:     * Valid (regra #46), entao a celula ativa tem precedencia sobre o
941:     * cursor enquanto o usuario ainda esta dentro dela - do contrario o
942:     * BO receberia o valor ANTERIOR da linha.
943:     *
944:     * A lista final de codigos (this_cListaProdutos) continua sendo
945:     * montada pelo BO varrendo o cursor INTEIRO em MontarListaProdutos(),
946:     * porque ela nao eh dado de uma linha e sim o resultado do dialogo.
947:     *====================================================================
948:     PROCEDURE FormParaBO()
949:         LOCAL loc_oCelula
950: 
951:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
952:             RETURN .F.
953:         ENDIF
954: 
955:         IF !USED(THIS.this_cCursorGrade)
956:             RETURN .F.
957:         ENDIF
958: 
959:         SELECT (THIS.this_cCursorGrade)
960: 
961:         IF EOF() OR BOF()
962:             RETURN .F.
963:         ENDIF
964: 
965:         THIS.this_oBusinessObject.this_cCodigoProduto    = ALLTRIM(NVL(Cpros, ""))
966:         THIS.this_oBusinessObject.this_cDescricaoProduto = ALLTRIM(NVL(Dpros, ""))
967: 
968:         *-- Celula ativa do Codigo tem precedencia: dentro do Valid o
969:         *-- digitado esta nela e ainda nao foi gravado no cursor
970:         loc_oCelula = THIS.ObterCelulaCodigo()
971: 
972:         IF VARTYPE(loc_oCelula) = "O" AND !EMPTY(ALLTRIM(loc_oCelula.Value))
973:             THIS.this_oBusinessObject.this_cCodigoProduto = ALLTRIM(loc_oCelula.Value)
974:         ENDIF
975: 
976:         RETURN .T.
977:     ENDPROC
978: 
979:     *====================================================================
980:     * BOParaForm - Leva o produto resolvido pelo BO para a LINHA CORRENTE
981:     * da grade (cursor + as duas celulas) e repinta.
982:     *
983:     * Transcricao do bloco que o legado executa no Valid da celula depois
984:     * de o lookup achar o produto:
985:     *
986:     *   This.Value = Evaluate('CrProds.Cpros')
987:     *   Replace CrProduto.Dpros With CrProds.dpros in CrProduto
988:     *   This.Parent.Parent.Column2.Text1.Value = Evaluate('CrProds.Dpros')
989:     *
990:     * Aqui a origem eh o BO (ja carregado pelo picker ou por
991:     * ValidarProduto), e nao o cursor CrProds do fwBuscaExt - por isso as
992:     * tres atribuicoes moram neste metodo unico, chamado por TODO caminho
993:     * que resolve um produto.
994:     *====================================================================
995:     PROCEDURE BOParaForm()
996:         LOCAL loc_oGrade, loc_oCelula
997: 
998:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
999:             RETURN .F.
1000:         ENDIF
1001: 
1002:         IF !USED(THIS.this_cCursorGrade)
1003:             RETURN .F.
1004:         ENDIF
1005: 
1006:         SELECT (THIS.this_cCursorGrade)
1007: 
1008:         IF EOF() OR BOF()
1009:             RETURN .F.
1010:         ENDIF
1011: 
1012:         REPLACE Cpros WITH THIS.this_oBusinessObject.this_cCodigoProduto, ;
1013:                 Dpros WITH THIS.this_oBusinessObject.this_cDescricaoProduto ;
1014:                 IN (THIS.this_cCursorGrade)
1015: 
1016:         loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
1017: 
1018:         *-- "This.Value = ..." do legado: o codigo escolhido tem de voltar
1019:         *-- para a CELULA tambem, senao o texto digitado sobrescreve o
1020:         *-- cursor quando o foco sair dela (regra #46)
1021:         loc_oCelula = THIS.ObterCelulaCodigo()
1022: 
1023:         IF VARTYPE(loc_oCelula) = "O"
1024:             loc_oCelula.Value = THIS.this_oBusinessObject.this_cCodigoProduto
1025:         ENDIF
1026: 
1027:         *-- "This.Parent.Parent.Column2.Text1.Value = ..." do legado
1028:         loc_oGrade.Column2.Text1.Value = THIS.this_oBusinessObject.this_cDescricaoProduto
1029: 
1030:         loc_oGrade.Refresh()
1031: 
1032:         RETURN .T.
1033:     ENDPROC
1034: 
1035:     *====================================================================

*-- Linhas 1042 a 1318:
1042:     * se a coluna ainda estiver com o Text1 default, e sao TRES os
1043:     * chamadores (FormParaBO, BOParaForm e GradeProdutosDblClick).
1044:     *====================================================================
1045:     PROCEDURE ObterCelulaCodigo()
1046:         LOCAL loc_oGrade
1047: 
1048:         loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
1049: 
1050:         IF VARTYPE(loc_oGrade) != "O"
1051:             RETURN .NULL.
1052:         ENDIF
1053: 
1054:         IF loc_oGrade.ColumnCount < 1
1055:             RETURN .NULL.
1056:         ENDIF
1057: 
1058:         IF !PEMSTATUS(loc_oGrade.Column1, "txt_4c_CelCodigo", 5)
1059:             RETURN .NULL.
1060:         ENDIF
1061: 
1062:         RETURN loc_oGrade.Column1.txt_4c_CelCodigo
1063:     ENDPROC
1064: 
1065:     *====================================================================
1066:     * HabilitarCampos - Liga/desliga a grade e os dois botoes do dialogo.
1067:     *
1068:     * Existe para fechar a porta que a migracao abriu: o laco de espera do
1069:     * legado (altera.Click) eh um "DO While ... Enddo" SEM DOEVENTS e, em
1070:     * VFP9, isso bloqueia o processamento de eventos - durante a contagem o
1071:     * usuario nao consegue clicar nem digitar. ExibirAnimacaoConfirmacao
1072:     * CHAMA DOEVENTS de proposito, para o container de "Aguarde" repintar
1073:     * os 13 blocos, e com isso a tela volta a aceitar entrada enquanto
1074:     * "verifica os dados". Desligar a grade e os botoes durante a animacao
1075:     * reproduz o efeito do laco bloqueante do legado.
1076:     *
1077:     * PUBLIC: chamado por THIS. em BtnOkClick e alcancavel pelo harness de
1078:     * teste automatizado, que chama metodos do form de fora da classe
1079:     * (regra #3).
1080:     *====================================================================
1081:     PROCEDURE HabilitarCampos(par_lHabilitar)
1082:         LOCAL loc_lHabilitar
1083: 
1084:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1085: 
1086:         THIS.cnt_4c__Referencia.grd_4c_Dados.Enabled = loc_lHabilitar
1087: 
1088:         *-- Os dois botoes sao icone-only quando desabilitados? Nao: ambos
1089:         *-- tem Caption ("Ok"/"Cancelar") e .DisabledPicture igual a
1090:         *-- .Picture, entao o icone continua desenhado com Enabled = .F.
1091:         *-- (regra do CommandButton standalone com Picture)
1092:         THIS.cmd_4c_Altera.Enabled = loc_lHabilitar
1093:         THIS.cmd_4c_Sair.Enabled   = loc_lHabilitar
1094: 
1095:         RETURN .T.
1096:     ENDPROC
1097: 
1098:     *====================================================================
1099:     * LimparCampos - Devolve a grade ao estado inicial do dialogo: uma
1100:     * unica linha em branco, pronta para digitacao.
1101:     *
1102:     * Equivale ao par que o legado executa ao abrir a tela - o
1103:     * "Create Cursor CrProduto (Cpros c(14), dpros c(40))" do Load mais o
1104:     * "Select CrProduto / Append Blank" do Init - e eh o override do hook
1105:     * de mesmo nome do FormBase, que o chama em Novo()/Excluir()/
1106:     * Cancelar(). Zera tambem o snapshot do codigo anterior, senao o
1107:     * Valid da primeira celula compararia o valor novo com o da sessao
1108:     * descartada e nao abriria o lookup.
1109:     *
1110:     * ZAP (e nao USE IN + CREATE CURSOR) de proposito: ele preserva a
1111:     * estrutura do cursor e, com ela, o RecordSource do Grid e os
1112:     * ControlSource das duas colunas. Derrubar o alias deixaria a grade
1113:     * permanentemente vazia com o cursor cheio.
1114:     *
1115:     * SET SAFETY eh escopado por DATA SESSION, e este form eh
1116:     * DataSession = 2: o "SET SAFETY OFF" do main.prg NAO alcanca a sessao
1117:     * privada, onde SAFETY vale ON. Sem o par salvar/restaurar abaixo o ZAP
1118:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1119:     * esperando um clique que ninguem ve.
1120:     *====================================================================
1121:     PROCEDURE LimparCampos()
1122:         LOCAL loc_cSafety
1123: 
1124:         IF !USED(THIS.this_cCursorGrade)
1125:             THIS.CriarCursorProdutos()
1126:         ELSE
1127:             loc_cSafety = SET("SAFETY")
1128:             SET SAFETY OFF
1129: 
1130:             SELECT (THIS.this_cCursorGrade)
1131:             ZAP
1132:             APPEND BLANK
1133: 
1134:             IF loc_cSafety = "ON"
1135:                 SET SAFETY ON
1136:             ENDIF
1137:         ENDIF
1138: 
1139:         THIS.this_cCodigoAnterior = ""
1140: 
1141:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1142:             THIS.this_oBusinessObject.this_cCodigoProduto    = ""
1143:             THIS.this_oBusinessObject.this_cDescricaoProduto = ""
1144:             THIS.this_oBusinessObject.this_cListaProdutos    = ""
1145:         ENDIF
1146: 
1147:         *-- Metodo UNICO de vinculo/repintura: popular ou recriar o cursor
1148:         *-- NAO repinta a grade por si so (regra #21)
1149:         THIS.CarregarLista()
1150: 
1151:         RETURN .T.
1152:     ENDPROC
1153: 
1154:     *====================================================================
1155:     * TornarControlesVisiveis - Torna visiveis os controles do container
1156:     * informado, recursivamente, EXCETO cnt_4c__Mensagem (container
1157:     * flutuante - permanece oculto at? o botao Ok iniciar a animacao).
1158:     *====================================================================
1159:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1160:         LOCAL loc_nI, loc_oControl
1161: 
1162:         IF VARTYPE(par_oContainer) != "O"
1163:             RETURN
1164:         ENDIF
1165: 
1166:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1167:             loc_oControl = par_oContainer.Controls(loc_nI)
1168: 
1169:             *-- FILTRO: container flutuante permanece oculto (toggled
1170:             *-- pelo botao Ok durante a animacao de confirmacao)
1171:             IF UPPER(loc_oControl.Name) = "CNT_4C__MENSAGEM"
1172:                 LOOP
1173:             ENDIF
1174: 
1175:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1176:                 loc_oControl.Visible = .T.
1177:             ENDIF
1178: 
1179:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1180:                 THIS.TornarControlesVisiveis(loc_oControl)
1181:             ENDIF
1182:         ENDFOR
1183:     ENDPROC
1184: 
1185:     *====================================================================
1186:     * Destroy - Encerramento do dialogo. Migrado de SIGPRTRF.Release
1187:     * ("ThisForm.poDataMgr.Release / dodefault()"), que eh onde o legado
1188:     * solta o gerenciador de dados da tela.
1189:     *
1190:     * A lista de codigos eh CACHEADA no form ANTES de o BO ser liberado: o
1191:     * evento Unload dispara DEPOIS do Destroy e ja nao alcancaria
1192:     * this_oBusinessObject.this_cListaProdutos.
1193:     *====================================================================
1194:     PROCEDURE Destroy()
1195:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1196:             THIS.this_cListaProdutosSelecionados = ;
1197:                 THIS.this_oBusinessObject.this_cListaProdutos
1198: 
1199:             *-- Equivalente ao "ThisForm.poDataMgr.Release" do legado
1200:             THIS.this_oBusinessObject = .NULL.
1201:         ENDIF
1202: 
1203:         IF !EMPTY(THIS.this_cCursorGrade) AND USED(THIS.this_cCursorGrade)
1204:             USE IN (THIS.this_cCursorGrade)
1205:         ENDIF
1206: 
1207:         IF USED("cursor_4c_BuscaProdutoTrf")
1208:             USE IN cursor_4c_BuscaProdutoTrf
1209:         ENDIF
1210: 
1211:         DODEFAULT()
1212:     ENDPROC
1213: 
1214:     *====================================================================
1215:     * Unload - Migrado de SIGPRTRF.Unload ("Return ThisForm.Retorno").
1216:     *
1217:     * Em VFP9 o valor devolvido pelo Unload eh o que chega ao chamador que
1218:     * abre a tela com "DO FORM <form> TO <var>" - eh assim que o legado
1219:     * entrega "Ok" (confirmado) ou " " (cancelado).
1220:     *
1221:     * O chamador que usa o padrao do sistema novo (CREATEOBJECT + Show())
1222:     * nao alcanca esse retorno; para ele existem ObterRetorno() e
1223:     * ObterListaProdutos(), que leem properties do form - e properties
1224:     * sobrevivem ao fechamento, porque o chamador ainda tem a referencia.
1225:     * Os dois modos de abertura ficam atendidos.
1226:     *====================================================================
1227:     PROCEDURE Unload()
1228:         RETURN THIS.this_cRetorno
1229:     ENDPROC
1230: 
1231:     *====================================================================
1232:     * ObterRetorno - "Ok" quando o usuario confirmou a relacao, " " quando
1233:     * cancelou (mesmos dois valores do ThisForm.Retorno legado). Espelho
1234:     * do Unload para o chamador que abre a tela por CREATEOBJECT + Show().
1235:     *====================================================================
1236:     PROCEDURE ObterRetorno()
1237:         RETURN THIS.this_cRetorno
1238:     ENDPROC
1239: 
1240:     *====================================================================
1241:     * ObterListaProdutos - Codigos dos produtos informados na grade,
1242:     * separados por virgula, na ordem em que o usuario os digitou. Eh o
1243:     * RESULTADO util do dialogo: o legado devolvia so "Ok"/" " e deixava o
1244:     * cursor CrProduto aberto para o form chamador varrer, o que nao se
1245:     * aplica aqui porque o cursor vive na datasession PRIVADA desta tela
1246:     * (DataSession = 2) e eh fechado no Destroy.
1247:     *
1248:     * Le o valor cacheado no Destroy quando o form ja fechou e, com a tela
1249:     * ainda aberta, consulta o BO direto.
1250:     *====================================================================
1251:     PROCEDURE ObterListaProdutos()
1252:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1253:             RETURN THIS.this_oBusinessObject.this_cListaProdutos
1254:         ENDIF
1255: 
1256:         RETURN THIS.this_cListaProdutosSelecionados
1257:     ENDPROC
1258: 
1259:     *====================================================================
1260:     * CarregarLista - Vincula a grade de produtos ao cursor e a repinta.
1261:     *
1262:     * Transcricao do bloco do Init legado:
1263:     *     With Thisform.Cnt_Referencia.Grade
1264:     *         .RecordSource          = 'CrProduto'
1265:     *         .Column1.ControlSource = 'CrProduto.Cpros'
1266:     *         .Column2.ControlSource = 'CrProduto.Dpros'
1267:     *         .Refresh
1268:     *     EndWith
1269:     *     Select CrProduto
1270:     *     Append Blank
1271:     *
1272:     * Metodo UNICO de vinculo/repintura: tem de ser chamado em todo
1273:     * caminho que recria ou repopula cursor_4c_Produtos, porque popular o
1274:     * cursor NAO repinta a grade por si so - ela fica visualmente vazia
1275:     * com o cursor cheio. PUBLIC de proposito: o harness de teste
1276:     * automatizado chama THIS.oForm.CarregarLista() de fora da classe.
1277:     *====================================================================
1278:     PROCEDURE CarregarLista()
1279:         LOCAL loc_oGrade, loc_lSucesso, loc_oErro
1280:         loc_lSucesso = .F.
1281: 
1282:         TRY
1283:             *-- O cursor tem de existir ANTES do ControlSource: atribuir
1284:             *-- ControlSource de alias inexistente derruba o Init.
1285:             IF !USED(THIS.this_cCursorGrade)
1286:                 THIS.CriarCursorProdutos()
1287:             ENDIF
1288: 
1289:             *-- Linha em branco para digitar, como o "Append Blank" do Init
1290:             *-- legado: sem ela a grade abre sem nenhuma celula editavel.
1291:             IF RECCOUNT(THIS.this_cCursorGrade) = 0
1292:                 SELECT (THIS.this_cCursorGrade)
1293:                 APPEND BLANK
1294:             ENDIF
1295: 
1296:             loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
1297: 
1298:             WITH loc_oGrade
1299:                 *-- O ColumnCount cai a 0 quando o alias da grade eh
1300:                 *-- derrubado (medido no VFP9): sem repor, .ColumnN nao
1301:                 *-- existe e o vinculo logo abaixo estoura.
1302:                 IF .ColumnCount != 2
1303:                     .ColumnCount = 2
1304:                 ENDIF
1305: 
1306:                 .RecordSource          = THIS.this_cCursorGrade
1307:                 .Column1.ControlSource = THIS.this_cCursorGrade + ".Cpros"
1308:                 .Column2.ControlSource = THIS.this_cCursorGrade + ".Dpros"
1309:             ENDWITH
1310: 
1311:             *-- Formato das colunas DEPOIS do vinculo: se o ColumnCount
1312:             *-- teve de ser reposto, os objetos Column nasceram de novo
1313:             *-- com o default do VFP9 e perderam Format, InputMask,
1314:             *-- fontes, Movable/Resizable, largura, Caption do cabecalho e
1315:             *-- o ReadOnly da coluna da Descricao
1316:             THIS.AplicarFormatoColunas()
1317: 
1318:             *-- "Go Top" + Refresh do legado: sem isso a grade fica

*-- Linhas 1326 a 1374:
1326:             MsgErro("Erro ao carregar a grade de produtos:" + CHR(13) + ;
1327:                     loc_oErro.Message + CHR(13) + ;
1328:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1329:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1330:         ENDTRY
1331: 
1332:         RETURN loc_lSucesso
1333:     ENDPROC
1334: 
1335:     *====================================================================
1336:     * Activate - Posiciona o cursor de digitacao na primeira celula da
1337:     * grade na PRIMEIRA ativacao do dialogo, equivalente ao
1338:     * "ThisForm.Cnt_Referencia.Grade.column1.SetFocus" do Init legado.
1339:     * O SetFocus mora aqui, e nao no Init, porque durante o Init o form
1340:     * ainda nao esta visivel e dar foco a controle invisivel dispara erro.
1341:     *====================================================================
1342:     PROCEDURE Activate()
1343:         IF !THIS.this_lFocoAplicado
1344:             THIS.this_lFocoAplicado = .T.
1345:             THIS.FocarPrimeiraCelula()
1346:         ENDIF
1347: 
1348:         DODEFAULT()
1349:     ENDPROC
1350: 
1351:     *====================================================================
1352:     * FocarPrimeiraCelula - Da foco a coluna do Codigo do Produto, que eh
1353:     * por onde o usuario comeca a preencher a relacao de produtos.
1354:     *====================================================================
1355:     PROCEDURE FocarPrimeiraCelula()
1356:         LOCAL loc_oGrade, loc_oErro
1357: 
1358:         loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
1359: 
1360:         IF VARTYPE(loc_oGrade) != "O" OR !loc_oGrade.Visible OR !loc_oGrade.Enabled
1361:             RETURN
1362:         ENDIF
1363: 
1364:         TRY
1365:             loc_oGrade.SetFocus()
1366:             loc_oGrade.Column1.SetFocus()
1367:         CATCH TO loc_oErro
1368:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel posicionar o cursor na " + ;
1369:                      "grade de produtos:" + CHR(13) + loc_oErro.Message, ;
1370:                      "Aten" + CHR(231) + CHR(227) + "o")
1371:         ENDTRY
1372:     ENDPROC
1373: 
1374: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRTRFBO.prg):
*====================================================================
* SIGPRTRFBO.prg
*
* Business Object para Relacao de Produtos (Transferencia)
* Tabelas: SigCdPro (validacao/lookup de produto), SigCdPac (parametro ClockEcfs)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRTRFBO AS BusinessBase

    *-- Propriedades da entidade (produto sendo incluido na relacao)
    this_cCodigoProduto    = ""    && SigCdPro.cpros char(14) - PK
    this_cDescricaoProduto = ""    && SigCdPro.dpros char(40)

    *-- Propriedade de parametro de sistema (usada no aguarde de confirmacao)
    this_nTempoEspera = 0          && SigCdPac.ClockEcfs numeric

    *-- Propriedade de resultado (lista de codigos de produto separados por virgula)
    this_cListaProdutos = ""

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
        CATCH TO loException
            MostrarErro(loException, "SIGPRTRFBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * SIGPRTRF eh um dialogo de selecao (sem INSERT/UPDATE/DELETE no
    * legado): o Click do botao "Ok" so conta/monta a lista de produtos
    * informados na grade (THIS.MontarListaProdutos) e fecha o form com
    * ThisForm.Retorno = 'Ok'. Inserir()/Atualizar()/ExecutarExclusao()
    * NAO sao sobrescritos aqui - o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto, porque este BO
    * nao grava em tabela nenhuma; quem persiste a transferencia eh o
    * processo que consome THIS.this_cListaProdutos apos o form fechar.
    *====================================================================

    *====================================================================
    * ValidarProduto - Valida codigo de produto contra SigCdPro
    *
    * Equivalente ao legado (Grade.Column1.Text1.Valid):
    *   CreateObject('fwBuscaExt', poDataMgr.pnIdConn, 'SigCdPro',
    *                 'CrProds', 'cpros', This.Value, 'Produtos', 1000)
    *
    * Parametros: par_cCodigo - codigo digitado (coluna SigCdPro.cpros)
    * Retorno: .T. se encontrou o produto (preenche this_cCodigoProduto/
    *          this_cDescricaoProduto), .F. caso contrario
    *====================================================================
    FUNCTION ValidarProduto(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF

            loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaProduto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaProduto") > 0
                SELECT cursor_4c_ValidaProduto
                GO TOP
                THIS.this_cCodigoProduto    = ALLTRIM(TratarNulo(cpros, ""))
                THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(dpros, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cCodigoProduto    = ""
                THIS.this_cDescricaoProduto = ""
                THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRTRFBO.ValidarProduto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarParametroTempoEspera - Le SigCdPac.ClockEcfs
    *
    * Equivalente ao legado (PROCEDURE Init do form):
    *   lcSql = [Select ClockEcfs From SigCdPac]
    *   ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac')
    *
    * Tempo de espera (segundos), em numeric(4,0), usado na animacao de
    * confirmacao do botao "Ok".
    * Retorno: .T. se encontrou o parametro (preenche this_nTempoEspera)
    *====================================================================
    FUNCTION CarregarParametroTempoEspera()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_nTempoEspera = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ParamTempo")
                USE IN cursor_4c_ParamTempo
            ENDIF

            loc_cSQL = "SELECT clockecfs FROM SigCdPac"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamTempo")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ParamTempo") > 0
                SELECT cursor_4c_ParamTempo
                GO TOP
                THIS.this_nTempoEspera = NVL(clockecfs, 0)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ParamTempo")
                USE IN cursor_4c_ParamTempo
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRTRFBO.CarregarParametroTempoEspera")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * MontarListaProdutos - Conta os produtos informados na grade e monta
    * a lista final separada por virgula (this_cListaProdutos)
    *
    * Equivalente ao legado (PROCEDURE Click do botao "Ok"):
    *   Select CrProduto
    *   Count to x for Not Empty(Cpros)
    *   If x=0
    *       MessageBox('Nenhum Produto Informado!!!',0+16,'')
    *       Return .f.
    *   Endif
    *
    * Parametros: par_cCursorProdutos - alias do cursor da grade (coluna
    *             cpros, igual ao CrProduto do legado)
    * Retorno: numero de produtos validos encontrados (0 = nenhum)
    *====================================================================
    FUNCTION MontarListaProdutos(par_cCursorProdutos)
        LOCAL loc_nQtde, loc_cLista, loc_cAliasAnterior, loc_nRecnoAnterior

        loc_nQtde  = 0
        loc_cLista = ""
        THIS.this_cListaProdutos = ""

        IF VARTYPE(par_cCursorProdutos) != "C" OR !USED(par_cCursorProdutos)
            RETURN 0
        ENDIF

        loc_cAliasAnterior = ALIAS()

        SELECT (par_cCursorProdutos)

        *-- COUNT e SCAN varrem o cursor INTEIRO e deixam o ponteiro em EOF.
        *-- Guardar a LINHA CORRENTE (nao basta guardar o ALIAS): o chamador
        *-- eh a grade, e devolve-la posicionada em EOF faz a transferencia
        *-- da linha corrente (FormParaBO/BOParaForm do form) deixar de achar
        *-- registro - nada eh gravado, sem erro e sem aviso.
        loc_nRecnoAnterior = RECNO(par_cCursorProdutos)

        COUNT TO loc_nQtde FOR !EMPTY(cpros)

        IF loc_nQtde > 0
            SCAN FOR !EMPTY(cpros)
                IF !EMPTY(loc_cLista)
                    loc_cLista = loc_cLista + ","
                ENDIF
                loc_cLista = loc_cLista + ALLTRIM(cpros)
            ENDSCAN
        ENDIF

        THIS.this_cListaProdutos = loc_cLista

        *-- Repoe a linha corrente. GO so eh valido dentro do intervalo de
        *-- registros: RECNO() devolve RECCOUNT()+1 quando o ponteiro ja
        *-- estava em EOF ao entrar no metodo.
        IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(par_cCursorProdutos))
            GO loc_nRecnoAnterior IN (par_cCursorProdutos)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_nQtde
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega this_cCodigoProduto/this_cDescricaoProduto
    * a partir do registro corrente do cursor informado (usado apos o
    * lookup de produto preencher cpros/dpros na linha da grade)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cCodigoProduto = ALLTRIM(TratarNulo(cpros, ""))
        ENDIF

        IF TYPE("dpros") != "U"
            THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(dpros, ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave do produto corrente (usada so se algum
    * dia este BO vier a registrar auditoria de uma linha especifica)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoProduto
    ENDPROC

ENDDEFINE

