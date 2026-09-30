# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_JUSTIFICATIVA, CNT_4C_PROCURAR, CNT_4C_IMPCHMAT. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroDataInicial()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroDataFinal()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroGrupo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cheques' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGPRCHR.cntjustificativa): Top original=5 vs migrado 'lbl_4c_Label5' Top=534 (diff=529px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCHR.impchmat): Top original=8 vs migrado 'lbl_4c_Label1' Top=194 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCHR.cntProcurar): Top original=8 vs migrado 'lbl_4c_Label1' Top=194 (diff=186px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3805 linhas total):

*-- Linhas 40 a 208:
40:     * Init - Sem parametros recebidos do chamador (form aberto direto pelo
41:     * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
42:     *==========================================================================
43:     PROCEDURE Init()
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 
47:     *==========================================================================
48:     * InicializarForm - Instancia o BO e monta a estrutura visual base.
49:     * Fase 3 monta apenas o cabecalho (cnt_4c_Sombra); grid, CommandGroup de
50:     * acoes, filtros e containers flutuantes entram nas Fases 4 a 7.
51:     *==========================================================================
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lSucesso, loc_oErro
54:         loc_lSucesso = .F.
55: 
56:         TRY
57:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrChrBO")
58: 
59:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
60:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
61: 
62:                 THIS.ConfigurarPageFrame()
63: 
64:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
65:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
66: 
67:                 *-- Semeia os filtros a partir do BO (Init do BO ja carrega
68:                 *-- this_dDataInicial/this_dDataFinal com DATE(), como o
69:                 *-- "ThisForm.Dt_Inicial.Value = Date()" do Init legado), com o
70:                 *-- BO como fonte unica do estado dos filtros.
71:                 THIS.BOParaForm()
72: 
73:                 THIS.TornarControlesVisiveis(THIS)
74:                 THIS.Visible = .T.
75: 
76:                 loc_lSucesso = .T.
77:             ELSE
78:                 MsgErro("Erro ao criar SigPrChrBO. VARTYPE retornou: " + ;
79:                     VARTYPE(THIS.this_oBusinessObject), "FormSigPrChr.InicializarForm")
80:             ENDIF
81:         CATCH TO loc_oErro
82:             MsgErro(loc_oErro.Message + CHR(13) + ;
83:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
84:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrChr.InicializarForm")
85:         ENDTRY
86: 
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *==========================================================================
91:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRCHR nao tem
92:     * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
93:     * como ponto de entrada arquitetural padrao (mesmo papel em FormFop/FormEnd).
94:     * Fases: Fase 3 - so o cabecalho.
95:     *   Fase 4 - ConfigurarGrid() (grd_4c_Dados) + ConfigurarBotoesAcao()
96:     *             (cmdGok + Marca/Desmarca tudo + Processar) + MontaGrade()
97:     *   Fase 5 - ConfigurarMolduras() (Shape1/Shape2) + ConfigurarFiltros()
98:     *             com a PRIMEIRA metade dos campos (Grupo + Periodo)
99:     *   Fase 6 - ConfigurarFiltros() acrescenta a SEGUNDA metade (Conta +
100:     *             Favorecido), os handlers GotFocus (equivalente ao When) e
101:     *             KeyPress (equivalente ao Valid) de TODOS os filtros, e os
102:     *             pickers AbrirBuscaGrupo()/AbrirBuscaConta() (substituem
103:     *             fAcessoContab/fAcessoContas do legado - Pattern A)
104:     *   Fase 7 - ConfigurarContainersFlutuantes() (justificativa/procurar/leitor
105:     *             de codigo de barras/impressao manual matricial)
106:     *
107:     * Todos os 6 campos de filtro (Grupo/Conta/Periodo) ja existem como
108:     * TextBox e ja tem validacao/lookup completos. MontaGrade()/
109:     * ExibirCheques() continuam lendo pelos getters ObterFiltro* (guard
110:     * PEMSTATUS mantido por simetria - os campos sempre existem a partir
111:     * desta fase, mas o fallback para a property do BO fica inofensivo).
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarPageFrame()
114:         THIS.ConfigurarCabecalho()
115:         THIS.ConfigurarMolduras()
116:         THIS.ConfigurarGrid()
117:         THIS.ConfigurarBotoesAcao()
118:         THIS.ConfigurarFiltros()
119:         THIS.ConfigurarContainersFlutuantes()
120:     ENDPROC
121: 
122:     *==========================================================================
123:     * ConfigurarMolduras - Shape1 (moldura da grade) e Shape2 (moldura da
124:     * faixa de filtros Grupo/Periodo/Conta), copiados do layout.json sem
125:     * BorderColor/FillColor declarados no dump - por isso FillStyle=1
126:     * (transparente), para nao cobrir os controles desenhados por cima.
127:     *==========================================================================
128:     PROTECTED PROCEDURE ConfigurarMolduras()
129:         LOCAL loc_oErro
130: 
131:         TRY
132:             THIS.AddObject("shp_4c_Shape2", "Shape")
133:             WITH THIS.shp_4c_Shape2
134:                 .Top         = 156
135:                 .Left        = 18
136:                 .Width       = 774
137:                 .Height      = 66
138:                 .BorderColor = RGB(0, 0, 0)
139:                 .BorderStyle = 1
140:                 .FillStyle   = 1
141:                 .Visible     = .T.
142:             ENDWITH
143: 
144:             THIS.AddObject("shp_4c_Shape1", "Shape")
145:             WITH THIS.shp_4c_Shape1
146:                 .Top         = 227
147:                 .Left        = 18
148:                 .Width       = 774
149:                 .Height      = 301
150:                 .BorderColor = RGB(0, 0, 0)
151:                 .BorderStyle = 1
152:                 .FillStyle   = 1
153:                 .Visible     = .T.
154:             ENDWITH
155:         CATCH TO loc_oErro
156:             MsgErro(loc_oErro.Message + CHR(13) + ;
157:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
158:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarMolduras")
159:         ENDTRY
160:     ENDPROC
161: 
162:     *==========================================================================
163:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
164:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
165:     * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
166:     * THIS.Width ja eh 800 (identico ao legado).
167:     *==========================================================================
168:     PROTECTED PROCEDURE ConfigurarCabecalho()
169:         LOCAL loc_oCnt, loc_oErro
170: 
171:         TRY
172:             THIS.AddObject("cnt_4c_Sombra", "Container")
173:             loc_oCnt = THIS.cnt_4c_Sombra
174:             WITH loc_oCnt
175:                 .Top         = 0
176:                 .Left        = 0
177:                 .Width       = THIS.Width
178:                 .Height      = 80
179:                 .BorderWidth = 0
180:                 .BackColor   = RGB(100, 100, 100)
181:                 .Visible     = .T.
182:             ENDWITH
183: 
184:             loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
185:             WITH loc_oCnt.lbl_4c_Sombra
186:                 .FontBold      = .T.
187:                 .FontName      = "Tahoma"
188:                 .FontSize      = 18
189:                 .FontUnderline = .F.
190:                 .WordWrap      = .T.
191:                 .Alignment     = 0
192:                 .BackStyle     = 0
193:                 .AutoSize      = .F.
194:                 .Caption       = THIS.Caption
195:                 .Height        = 40
196:                 .Left          = 10
197:                 .Top           = 25
198:                 .Width         = 769
199:                 .ForeColor     = RGB(0, 0, 0)
200:                 .Visible       = .T.
201:             ENDWITH
202: 
203:             loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
204:             WITH loc_oCnt.lbl_4c_Titulo
205:                 .FontBold   = .T.
206:                 .FontName   = "Tahoma"
207:                 .FontSize   = 18
208:                 .WordWrap   = .T.

*-- Linhas 220 a 356:
220:         CATCH TO loc_oErro
221:             MsgErro(loc_oErro.Message + CHR(13) + ;
222:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
223:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
224:         ENDTRY
225:     ENDPROC
226: 
227:     *==========================================================================
228:     * CriarCursorCheques - Cursor de trabalho da grade de cheques
229:     * (cursor_4c_Cheques = CsSigCqChi do legado). Estrutura EXATA da que sera
230:     * populada por SQLEXEC nas fases seguintes (filtros de Grupo/Conta/
231:     * Periodo, ver mExibeCheques/MontaChq do legado) - criado aqui vazio para
232:     * o Grid poder ligar Column.ControlSource ja nesta fase, sem estourar
233:     * "Alias nao encontrado" (regra: Column.ControlSource antes do cursor
234:     * existir derruba o Init).
235:     *==========================================================================
236:     PROTECTED PROCEDURE CriarCursorCheques()
237:         IF USED("cursor_4c_Cheques")
238:             USE IN cursor_4c_Cheques
239:         ENDIF
240: 
241:         CREATE CURSOR cursor_4c_Cheques ;
242:             (emps C(3), dopes C(20), numes N(6,0), datas T NULL, bancos C(3), ;
243:              agencias C(4), ncontas C(10), ncheques C(6), contas C(10), ;
244:              valors N(11,2), favos C(40), ncopias N(6,0), nemissoes N(2,0), ;
245:              cidchaves C(20), nemitidos N(1,0), ncancelas N(1,0), ;
246:              nmarca1s N(1,0), justcanc M)
247: 
248:         *-- Indices criados JUNTO com o cursor (vazio), nao apenas apos a
249:         *-- primeira carga: ExibirCheques faz "SET ORDER TO NCopias/Contas" e,
250:         *-- com o cursor existindo SEM TAG nenhuma, isso estoura "Table has no
251:         *-- index order set." - acontece quando o usuario abre a tela e usa
252:         *-- Procurar/Chq. Matric. ANTES de Processar (no legado o cursor nem
253:         *-- existia nesse momento e o guard IF USED() pulava tudo). INDEX ON
254:         *-- cursor vazio eh valido, e o ZAP da recarga PRESERVA as tags, entao
255:         *-- a chamada seguinte em MontaGrade vira no-op (guard TAGCOUNT = 0).
256:         THIS.CriarIndicesCheques()
257:     ENDPROC
258: 
259:     *==========================================================================
260:     * CriarIndicesCheques - Os 12 indices que o legado cria sobre CsSigCqChi
261:     * logo apos montar o cursor (PROCEDURE montachq), transcritos 1:1 e com os
262:     * MESMOS nomes de TAG - as tags sao usadas por nome em SET ORDER TO /
263:     * SEEK(..., "<tag>") no reposicionamento e na tela de Procurar, entao
264:     * renomear qualquer uma delas quebra a busca (nunca usar uma tag unica
265:     * "ordem").
266:     *
267:     * Medido no VFP9: ZAP PRESERVA as TAGs do indice (TAGCOUNT antes e depois
268:     * = 2), por isso os indices sao criados uma unica vez - nas recargas
269:     * seguintes o APPEND apenas atualiza as tags existentes.
270:     *==========================================================================
271:     PROTECTED PROCEDURE CriarIndicesCheques()
272:         LOCAL loc_cCursor
273: 
274:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
275: 
276:         IF !USED(loc_cCursor)
277:             RETURN
278:         ENDIF
279: 
280:         SELECT (loc_cCursor)
281: 
282:         IF TAGCOUNT() = 0
283:             INDEX ON ncopias                TAG NCopias
284:             INDEX ON nemitidos              TAG NEmitidos
285:             INDEX ON ncancelas              TAG NCancelas
286:             INDEX ON nmarca1s               TAG NMarca1s
287:             INDEX ON ncheques               TAG NCheques
288:             INDEX ON datas                  TAG Datas
289:             INDEX ON ncontas + ncheques     TAG Conta
290:             INDEX ON contas + STR(ncopias)  TAG Contas
291:             INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques        TAG Emissao
292:             INDEX ON STR(valors, 12, 2) + bancos + agencias + ncontas + ncheques TAG Valor
293:             INDEX ON bancos + agencias + ncontas + ncheques                      TAG Cheque
294:             INDEX ON agencias + ncontas + ncheques                               TAG Agencia
295:         ENDIF
296:     ENDPROC
297: 
298:     *==========================================================================
299:     * MontaGrade - Carga da grade de cheques. Transcricao do "PROCEDURE
300:     * montachq" legado: guarda a chave do cheque corrente, consulta o periodo
301:     * no banco (SQL no BO), repovoa o cursor, recria os indices, posiciona e
302:     * entrega para ExibirCheques().
303:     *
304:     * Diferenca DELIBERADA em relacao ao legado: o legado faz
305:     * "GrdCCheques.RecordSource = '' + Use In CsSigCqChi" e recria o cursor com
306:     * SELECT ... INTO CURSOR ... ReadWrite, religando em seguida TODOS os
307:     * ControlSource. Aqui o cursor eh PRESERVADO e recarregado com ZAP +
308:     * APPEND FROM DBF(): reatribuir RecordSource resetaria Column.Width,
309:     * Header1.Caption, Sparse e CurrentControl (o CheckBox da coluna Imprime
310:     * deixaria de aparecer). O cursor criado por CREATE CURSOR ja eh
311:     * READWRITE, que eh o que a coluna editavel do CheckBox exige.
312:     *
313:     * ZAP exige SAFETY OFF: config.prg NAO desliga SAFETY (so SET EXACT ON) e
314:     * com SAFETY ON o ZAP abre dialogo modal de confirmacao que CONGELA a tela.
315:     *==========================================================================
316:     PROCEDURE MontaGrade(par_lPosiciona)
317:         LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor, loc_cTmp, loc_cBusca
318:         LOCAL loc_cSafety, loc_oErro
319:         loc_lSucesso   = .F.
320:         loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
321:         loc_cBusca     = ""
322: 
323:         TRY
324:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
325:             loc_cTmp    = "cursor_4c_ChequesTmp"
326: 
327:             THIS.LockScreen = .T.
328: 
329:             *-- lcBusca = Bancos + Agencias + ncontas + Ncheques: chave
330:             *-- POSICIONAL de largura fixa (char 3+4+10+6 = 23 = a chave da tag
331:             *-- Cheque). NUNCA aplicar ALLTRIM nas partes - o padding FAZ PARTE
332:             *-- da chave e encurta-la faz o SEEK devolver "nao achou" em
333:             *-- silencio (CLAUDE.md regra #42). Medido: SEEK com a chave crua
334:             *-- de 23 chars casa na tag Cheque.
335:             IF loc_lPosiciona AND USED(loc_cCursor) AND !EOF(loc_cCursor)
336:                 SELECT (loc_cCursor)
337:                 loc_cBusca = bancos + agencias + ncontas + ncheques
338:             ENDIF
339: 
340:             WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT
341: 
342:             IF !USED(loc_cCursor)
343:                 THIS.CriarCursorCheques()
344:             ENDIF
345: 
346:             IF THIS.this_oBusinessObject.CarregarCheques(loc_cTmp)
347:                 loc_cSafety = SET("Safety")
348:                 SET SAFETY OFF
349: 
350:                 SELECT (loc_cCursor)
351:                 ZAP
352:                 APPEND FROM DBF(loc_cTmp)
353: 
354:                 IF loc_cSafety == "ON"
355:                     SET SAFETY ON
356:                 ENDIF

*-- Linhas 402 a 470:
402:         CATCH TO loc_oErro
403:             MsgErro(loc_oErro.Message + CHR(13) + ;
404:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
405:                 "Procedure: " + loc_oErro.Procedure, "Erro em MontaGrade")
406:         ENDTRY
407: 
408:         WAIT CLEAR
409:         THIS.LockScreen = .F.
410: 
411:         *-- Legado: If llPosiciona -> mExibeCheques(.F.) Else mExibeCheques(.T.)
412:         IF loc_lSucesso
413:             THIS.ExibirCheques(!loc_lPosiciona)
414:             THIS.this_oBusinessObject.this_lPrimeiraExibicao = .F.
415:         ENDIF
416: 
417:         RETURN loc_lSucesso
418:     ENDPROC
419: 
420:     *==========================================================================
421:     * ExibirCheques - Transcricao do "PROCEDURE mexibecheques" legado: desmarca
422:     * a coluna Imprime, escolhe a ordem da grade conforme a Conta estar
423:     * filtrada, opcionalmente salta para o fim da lista, e sincroniza
424:     * Favorecido / botao Procurar / foco na coluna Conta.
425:     *
426:     * Medido no VFP9: "Seek Chr(255) ... Order NCopias" (chave CHARACTER contra
427:     * indice NUMERICO) NAO dispara erro - deixa o cursor em EOF, que eh
428:     * exatamente o efeito pretendido pelo legado (ir para o fim da lista).
429:     *==========================================================================
430:     PROCEDURE ExibirCheques(par_lSeek)
431:         LOCAL loc_lSeek, loc_cCursor, loc_cConta, loc_cFavorecido, loc_oErro
432: 
433:         *-- Legado: llSeek = Iif(Type('llSeek') = 'L', llSeek, .F.)
434:         loc_lSeek = IIF(VARTYPE(par_lSeek) = "L", par_lSeek, .F.)
435: 
436:         TRY
437:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
438: 
439:             IF USED(loc_cCursor)
440:                 THIS.LockScreen = .T.
441: 
442:                 *-- Legado: UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
443:                 UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
444: 
445:                 loc_cConta = ALLTRIM(THIS.ObterFiltroConta())
446: 
447:                 SELECT (loc_cCursor)
448: 
449:                 IF EMPTY(loc_cConta)
450:                     SET ORDER TO NCopias
451:                     IF loc_lSeek
452:                         SEEK CHR(255) IN (loc_cCursor) ORDER NCopias ASCENDING
453:                     ENDIF
454:                 ELSE
455:                     *-- Legado: Set Order To contas + Set Key To <conta>. O
456:                     *-- SET KEY eh OMITIDO de proposito: a consulta do BO ja
457:                     *-- restringe o resultado a essa unica conta (WHERE
458:                     *-- a.contas = <conta>), entao ele nao filtra nada a mais -
459:                     *-- e a tag Contas eh COMPOSTA (contas + Str(ncopias)),
460:                     *-- de modo que um SET KEY com a chave parcial sob o
461:                     *-- SET EXACT ON global (config.prg) poderia nao casar e
462:                     *-- deixar a grade vazia sem erro nenhum.
463:                     SET ORDER TO Contas
464:                     IF loc_lSeek
465:                         SEEK loc_cConta + CHR(255) IN (loc_cCursor) ORDER Contas ASCENDING
466:                     ENDIF
467:                 ENDIF
468: 
469:                 *-- Legado: ThisForm.CmdGOk.CmdProcurar.Enabled = .t. + Refresh
470:                 IF THIS.obj_4c_CmdGok.ButtonCount >= 4

*-- Linhas 499 a 714:
499:             THIS.LockScreen = .F.
500:             MsgErro(loc_oErro.Message + CHR(13) + ;
501:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
502:                 "Procedure: " + loc_oErro.Procedure, "Erro em ExibirCheques")
503:         ENDTRY
504:     ENDPROC
505: 
506:     *==========================================================================
507:     * ObterFiltroConta / ObterFiltroGrupo - Valor corrente dos filtros de
508:     * Conta e Grupo. Os TextBox correspondentes (getCdContas / getCdGrupos do
509:     * legado) sao criados na fase de filtros; enquanto nao existirem, o valor
510:     * vem das properties do BO (this_cCodConta / this_cCodGrupo), que sao a
511:     * fonte unica desse estado. Quando os campos existirem, o TextBox passa a
512:     * mandar - igual ao legado, que le sempre ThisForm.getCdContas.Value.
513:     *==========================================================================
514:     PROTECTED FUNCTION ObterFiltroConta()
515:         LOCAL loc_cConta
516: 
517:         loc_cConta = THIS.this_oBusinessObject.this_cCodConta
518: 
519:         IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
520:             loc_cConta = THIS.txt_4c_CdContas.Value
521:         ENDIF
522: 
523:         RETURN IIF(VARTYPE(loc_cConta) = "C", loc_cConta, "")
524:     ENDFUNC
525: 
526:     PROTECTED FUNCTION ObterFiltroGrupo()
527:         LOCAL loc_cGrupo
528: 
529:         loc_cGrupo = THIS.this_oBusinessObject.this_cCodGrupo
530: 
531:         IF PEMSTATUS(THIS, "txt_4c_CdGrupos", 5)
532:             loc_cGrupo = THIS.txt_4c_CdGrupos.Value
533:         ENDIF
534: 
535:         RETURN IIF(VARTYPE(loc_cGrupo) = "C", loc_cGrupo, "")
536:     ENDFUNC
537: 
538:     *==========================================================================
539:     * ConfigurarGrid - Grade de cheques (grd_4c_Dados = grdCcheques do
540:     * legado). Layout FLAT (sem PageFrame) - Top/Left identicos ao SCX
541:     * original (layout.json), SEM compensacao de +29 (essa compensacao so
542:     * vale para forms com PageFrame.Top=-29, o que nao existe neste form).
543:     *
544:     * ColumnOrder replica o SCX: clnImprime (Column10) desenha PRIMEIRO
545:     * (ColumnOrder=1) e clnDatas (Column1) desenha POR ULTIMO (ColumnOrder=10)
546:     * - os demais seguem a ordem de criacao (2..9). clnSituacaos (Column8) eh
547:     * CALCULADA (nao existe coluna no cursor) - ControlSource eh a mesma
548:     * expressao IIF aninhada do legado.
549:     *==========================================================================
550:     PROTECTED PROCEDURE ConfigurarGrid()
551:         LOCAL loc_oGrid, loc_oErro
552: 
553:         TRY
554:             THIS.CriarCursorCheques()
555: 
556:             THIS.AddObject("grd_4c_Dados", "Grid")
557:             loc_oGrid = THIS.grd_4c_Dados
558: 
559:             WITH loc_oGrid
560:                 .Top               = 233
561:                 .Left              = 24
562:                 .Width             = 710
563:                 .Height            = 291
564:                 .FontName          = "Tahoma"
565:                 .FontSize          = 8
566:                 .AllowHeaderSizing = .F.
567:                 .AllowRowSizing    = .F.
568:                 .DeleteMark        = .F.
569:                 .RecordMark        = .F.
570:                 .ScrollBars        = 2
571:                 .GridLineColor     = RGB(238, 238, 238)
572:                 .ReadOnly          = .F.
573:                 .ColumnCount       = 10
574:                 .RecordSource      = "cursor_4c_Cheques"
575:                 .Visible           = .T.
576:             ENDWITH
577: 
578:             *-- Column1: clnDatas (desenha por ultimo - ColumnOrder=10)
579:             WITH loc_oGrid.Column1
580:                 .FontName          = "Tahoma"
581:                 .Width             = 79
582:                 .Movable           = .F.
583:                 .Resizable         = .F.
584:                 .ReadOnly          = .T.
585:                 .ColumnOrder       = 10
586:                 .ControlSource     = "cursor_4c_Cheques.datas"
587:                 .Header1.Caption   = "Data"
588:                 .Header1.Alignment = 2
589:                 .Header1.ForeColor = RGB(90, 90, 90)
590:             ENDWITH
591: 
592:             *-- Column2: clnContas
593:             WITH loc_oGrid.Column2
594:                 .FontName          = "Tahoma"
595:                 .Width             = 79
596:                 .Movable           = .F.
597:                 .Resizable         = .F.
598:                 .ReadOnly          = .T.
599:                 .ControlSource     = "cursor_4c_Cheques.contas"
600:                 .Header1.Caption   = "Conta"
601:                 .Header1.Alignment = 2
602:                 .Header1.ForeColor = RGB(90, 90, 90)
603:             ENDWITH
604: 
605:             *-- Column3: clnNcopias
606:             WITH loc_oGrid.Column3
607:                 .FontName          = "Tahoma"
608:                 .Width             = 51
609:                 .Movable           = .F.
610:                 .Resizable         = .F.
611:                 .ReadOnly          = .T.
612:                 .InputMask         = "999999"
613:                 .ControlSource     = "cursor_4c_Cheques.ncopias"
614:                 .Header1.Caption   = "C" + CHR(243) + "pia"
615:                 .Header1.Alignment = 2
616:                 .Header1.ForeColor = RGB(90, 90, 90)
617:             ENDWITH
618: 
619:             *-- Legado: clnNcopias.Header1.Click - reordena para NCopias ao
620:             *-- clicar no cabecalho, so quando nao ha filtro de Conta e a
621:             *-- ordem corrente ainda nao eh NCopias.
622:             BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "Column3Header1Click")
623: 
624:             *-- Column4: clnBancos
625:             WITH loc_oGrid.Column4
626:                 .FontName          = "Tahoma"
627:                 .Width             = 30
628:                 .Movable           = .F.
629:                 .Resizable         = .F.
630:                 .ReadOnly          = .T.
631:                 .ControlSource     = "cursor_4c_Cheques.bancos"
632:                 .Header1.Caption   = "Bco"
633:                 .Header1.Alignment = 2
634:                 .Header1.ForeColor = RGB(90, 90, 90)
635:             ENDWITH
636: 
637:             *-- Column5: clnAgencias
638:             WITH loc_oGrid.Column5
639:                 .FontName          = "Tahoma"
640:                 .Width             = 37
641:                 .Movable           = .F.
642:                 .Resizable         = .F.
643:                 .ReadOnly          = .T.
644:                 .ControlSource     = "cursor_4c_Cheques.agencias"
645:                 .Header1.Caption   = "Ag."
646:                 .Header1.Alignment = 2
647:                 .Header1.ForeColor = RGB(90, 90, 90)
648:             ENDWITH
649: 
650:             *-- Column6: clnNcontas
651:             WITH loc_oGrid.Column6
652:                 .FontName          = "Tahoma"
653:                 .Width             = 79
654:                 .Movable           = .F.
655:                 .Resizable         = .F.
656:                 .ReadOnly          = .T.
657:                 .ControlSource     = "cursor_4c_Cheques.ncontas"
658:                 .Header1.Caption   = "C.Corrente"
659:                 .Header1.Alignment = 2
660:                 .Header1.ForeColor = RGB(90, 90, 90)
661:             ENDWITH
662: 
663:             *-- Column7: clnNcheques
664:             WITH loc_oGrid.Column7
665:                 .FontName          = "Tahoma"
666:                 .Width             = 51
667:                 .Movable           = .F.
668:                 .Resizable         = .F.
669:                 .ReadOnly          = .T.
670:                 .ControlSource     = "cursor_4c_Cheques.ncheques"
671:                 .Header1.Caption   = "Cheque"
672:                 .Header1.Alignment = 2
673:                 .Header1.ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675: 
676:             *-- Column8: clnSituacaos (CALCULADA - identica ao legado)
677:             WITH loc_oGrid.Column8
678:                 .FontName          = "Tahoma"
679:                 .Width             = 79
680:                 .Movable           = .F.
681:                 .Resizable         = .F.
682:                 .ReadOnly          = .T.
683:                 .ControlSource     = "IIF(cursor_4c_Cheques.ncancelas = 1, 'Cancelado', " + ;
684:                                       "IIF(cursor_4c_Cheques.nemissoes > 1, 'Reemitido', " + ;
685:                                       "IIF(cursor_4c_Cheques.nemitidos = 1, 'Emitido', 'N" + CHR(227) + "o Emitido')))"
686:                 .Header1.Caption   = "Situa" + CHR(231) + CHR(227) + "o"
687:                 .Header1.Alignment = 2
688:                 .Header1.ForeColor = RGB(90, 90, 90)
689:             ENDWITH
690: 
691:             *-- Column9: clnValors
692:             WITH loc_oGrid.Column9
693:                 .FontName          = "Tahoma"
694:                 .Width             = 110
695:                 .Movable           = .F.
696:                 .Resizable         = .F.
697:                 .ReadOnly          = .T.
698:                 .InputMask         = "999,999,999.99"
699:                 .ControlSource     = "cursor_4c_Cheques.valors"
700:                 .Header1.Caption   = "Valor"
701:                 .Header1.Alignment = 2
702:                 .Header1.ForeColor = RGB(90, 90, 90)
703:             ENDWITH
704: 
705:             *-- Column10: clnImprime (checkbox - desenha PRIMEIRO, ColumnOrder=1)
706:             WITH loc_oGrid.Column10
707:                 .FontName    = "Tahoma"
708:                 .Width       = 55
709:                 .Movable     = .F.
710:                 .Resizable   = .F.
711:                 .ColumnOrder = 1
712:             ENDWITH
713: 
714:             loc_oGrid.Column10.AddObject("chk_4c_Check1", "CheckBox")

*-- Linhas 721 a 877:
721: 
722:             WITH loc_oGrid.Column10
723:                 .CurrentControl    = "chk_4c_Check1"
724:                 .Sparse            = .F.
725:                 .ReadOnly          = .F.
726:                 .ControlSource     = "cursor_4c_Cheques.nmarca1s"
727:                 .Header1.Caption   = "Imprime"
728:                 .Header1.Alignment = 2
729:                 .Header1.ForeColor = RGB(90, 90, 90)
730:             ENDWITH
731: 
732:             loc_oGrid.SetAll("DynamicForeColor", ;
733:                 "IIF(cursor_4c_Cheques.ncancelas = 1, RGB(255,0,0), " + ;
734:                 "IIF(cursor_4c_Cheques.nemitidos = 0, RGB(0,0,255), RGB(0,0,0)))", "Column")
735: 
736:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "KeyPress",  THIS, "ChkImprimeKeyPress")
737:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseUp",   THIS, "ChkImprimeMouseUp")
738:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseDown", THIS, "ChkImprimeMouseDown")
739:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "Click",     THIS, "ChkImprimeClick")
740: 
741:             *-- Legado: Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange
742:             *-- da grdCcheques tem TODOS o mesmo corpo (favorecido + Enabled
743:             *-- dos botoes de documento + painel de justificativa em modo
744:             *-- leitura quando o cheque corrente esta cancelado) - transcrito
745:             *-- uma unica vez em AtualizarPainelChequeCorrente() e ligado aqui
746:             *-- aos dois eventos NATIVOS do Grid (Scrolled/AfterRowColChange).
747:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
748:             BINDEVENT(loc_oGrid, "Scrolled",          THIS, "GrdDadosScrolled")
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message + CHR(13) + ;
751:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
752:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
753:         ENDTRY
754:     ENDPROC
755: 
756:     *==========================================================================
757:     * ChkImprimeKeyPress/MouseUp/MouseDown/Click - Toggle do checkbox
758:     * "Imprime" (Column10.chk_4c_Check1 = clnImprime.Check1 do legado).
759:     * MouseDown/Click apenas suprimem o toggle nativo do CheckBox (NODEFAULT);
760:     * MouseUp e KeyPress(Enter/Espaco) fazem a alternancia de verdade via
761:     * UPDATE no cursor, replicando 1:1 o KeyPress original do legado.
762:     * PUBLIC (sem PROTECTED) - BINDEVENT so dispara metodos PUBLIC.
763:     *==========================================================================
764:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
765:         LOCAL loc_cCursor, loc_nRecno, loc_cChave
766: 
767:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
768: 
769:         IF INLIST(par_nKeyCode, 13, 32) AND USED(loc_cCursor)
770:             loc_nRecno = RECNO(loc_cCursor)
771:             SELECT (loc_cCursor)
772:             loc_cChave = bancos + agencias + ncontas + ncheques
773: 
774:             UPDATE (loc_cCursor) SET nmarca1s = IIF(nmarca1s = 1, 0, 1) ;
775:                 WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
776:                   AND nemitidos = 0 AND ncancelas = 0
777: 
778:             THIS.grd_4c_Dados.Refresh()
779: 
780:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
781:                 SELECT (loc_cCursor)
782:                 GOTO loc_nRecno
783:             ENDIF
784: 
785:             NODEFAULT
786:         ENDIF
787:     ENDPROC
788: 
789:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
790:         THIS.ChkImprimeKeyPress(32, 0)
791:         NODEFAULT
792:     ENDPROC
793: 
794:     PROCEDURE ChkImprimeMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
795:         NODEFAULT
796:     ENDPROC
797: 
798:     PROCEDURE ChkImprimeClick()
799:         NODEFAULT
800:     ENDPROC
801: 
802:     *==========================================================================
803:     * Column3Header1Click - Header1.Click de clnNcopias (Column3). PUBLIC -
804:     * BINDEVENT so dispara metodos PUBLIC.
805:     *==========================================================================
806:     PROCEDURE Column3Header1Click()
807:         LOCAL loc_cCursor
808: 
809:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
810: 
811:         IF EMPTY(THIS.ObterFiltroConta()) AND USED(loc_cCursor) AND ;
812:                 UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
813:             THIS.ExibirCheques(.F.)
814:         ENDIF
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * GrdDadosAfterRowColChange / GrdDadosScrolled - Navegacao na grade de
819:     * cheques (grd_4c_Dados). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
820:     *==========================================================================
821:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
822:         THIS.AtualizarPainelChequeCorrente()
823:     ENDPROC
824: 
825:     PROCEDURE GrdDadosScrolled(par_nDirection)
826:         THIS.AtualizarPainelChequeCorrente()
827:     ENDPROC
828: 
829:     *==========================================================================
830:     * AtualizarPainelChequeCorrente - Transcricao unica do corpo repetido em
831:     * Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange do grdCcheques
832:     * legado: espelha o Favorecido do cheque corrente, habilita/desabilita os
833:     * botoes de documento conforme o cheque estar cancelado, e mostra o
834:     * painel de justificativa em modo SOMENTE LEITURA quando o cheque
835:     * corrente ja esta cancelado (cmdGconf oculto - nao ha o que confirmar).
836:     *==========================================================================
837:     PROTECTED PROCEDURE AtualizarPainelChequeCorrente()
838:         LOCAL loc_cCursor, loc_lCancelas
839: 
840:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
841: 
842:         IF !USED(loc_cCursor)
843:             RETURN
844:         ENDIF
845: 
846:         loc_lCancelas = (EVALUATE(loc_cCursor + ".ncancelas") <> 0)
847: 
848:         IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
849:             THIS.txt_4c_TxtFavorecido.Value = EVALUATE(loc_cCursor + ".favos")
850:             THIS.txt_4c_TxtFavorecido.Refresh()
851:         ENDIF
852: 
853:         *-- Legado: Buttons 1/6/3/5/9 = cmdDocumento/cmdExcluiDoc/cmdImprimir/
854:         *-- cmdRecibo/btnExcluirChq (mesma numeracao de CmdGokClick).
855:         IF THIS.obj_4c_CmdGok.ButtonCount >= 9
856:             THIS.obj_4c_CmdGok.Buttons(1).Enabled = !loc_lCancelas
857:             THIS.obj_4c_CmdGok.Buttons(6).Enabled = (!loc_lCancelas AND THIS.this_oBusinessObject.this_lExcluirDocumento)
858:             THIS.obj_4c_CmdGok.Buttons(3).Enabled = !loc_lCancelas
859:             THIS.obj_4c_CmdGok.Buttons(5).Enabled = !loc_lCancelas
860:             THIS.obj_4c_CmdGok.Buttons(9).Enabled = (loc_lCancelas AND THIS.this_oBusinessObject.this_lExcluirCheque)
861:             THIS.obj_4c_CmdGok.Refresh()
862:         ENDIF
863: 
864:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
865:             WITH THIS.cnt_4c_justificativa
866:                 .Visible = loc_lCancelas
867: 
868:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
869:                     .obj_4c_Get_justificativa.ReadOnly = loc_lCancelas
870:                     IF loc_lCancelas
871:                         .obj_4c_Get_justificativa.Width = 346
872:                         .obj_4c_Get_justificativa.Refresh()
873:                     ENDIF
874:                 ENDIF
875: 
876:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
877:                     .obj_4c_CmdGconf.Enabled = .F.

*-- Linhas 888 a 931:
888:     * Layout FLAT - Top/Left identicos ao SCX original, sem compensacao de
889:     * PageFrame.
890:     *==========================================================================
891:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
892:         LOCAL loc_oErro
893: 
894:         TRY
895:             THIS.AddObject("obj_4c_CmdGok", "CommandGroup")
896:             WITH THIS.obj_4c_CmdGok
897:                 .Top           = -3
898:                 .Left          = 11
899:                 .Width         = 789
900:                 .Height        = 160
901:                 .ButtonCount   = 9
902:                 .BackStyle     = 0
903:                 .BorderStyle   = 0
904:                 .SpecialEffect = 1
905:                 .BorderColor   = RGB(136, 189, 188)
906:                 .Themes        = .F.
907:                 .Value         = 1
908:                 .Visible       = .T.
909:             ENDWITH
910: 
911:             *-- Botao 1: cmdDocumento
912:             WITH THIS.obj_4c_CmdGok.Buttons(1)
913:                 .Top             = 121
914:                 .Left            = 473
915:                 .Width           = 120
916:                 .Height          = 37
917:                 .FontBold        = .T.
918:                 .FontItalic      = .T.
919:                 .FontName        = "Comic Sans MS"
920:                 .FontSize        = 8
921:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
922:                 .Caption         = "\<Documento"
923:                 .PicturePosition = 1
924:                 .ForeColor       = RGB(90, 90, 90)
925:                 .BackColor       = RGB(255, 255, 255)
926:                 .Themes          = .F.
927:             ENDWITH
928: 
929:             *-- Botao 2: cmdSair (Encerrar)
930:             WITH THIS.obj_4c_CmdGok.Buttons(2)
931:                 .Top         = 6

*-- Linhas 1075 a 1205:
1075:                 .Themes          = .F.
1076:             ENDWITH
1077: 
1078:             BINDEVENT(THIS.obj_4c_CmdGok, "Click", THIS, "CmdGokClick")
1079: 
1080:             *-- Botao standalone: cmdTudo1 (Marca tudo)
1081:             THIS.AddObject("cmd_4c_CmdTudo1", "CommandButton")
1082:             WITH THIS.cmd_4c_CmdTudo1
1083:                 .Top         = 334
1084:                 .Left        = 742
1085:                 .Width       = 40
1086:                 .Height      = 40
1087:                 .FontName    = "Verdana"
1088:                 .FontSize    = 8
1089:                 .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1090:                 .Caption     = ""
1091:                 .ToolTipText = "Marca tudo"
1092:                 .ForeColor   = RGB(36, 84, 155)
1093:                 .BackColor   = RGB(255, 255, 255)
1094:                 .Themes           = .T.
1095:                 .TabStop     = .F.
1096:                 .Visible     = .T.
1097:             ENDWITH
1098:             BINDEVENT(THIS.cmd_4c_CmdTudo1, "Click", THIS, "BtnMarcarTudoClick")
1099: 
1100:             *-- Botao standalone: cmdApaga1 (Desmarca tudo)
1101:             THIS.AddObject("cmd_4c_CmdApaga1", "CommandButton")
1102:             WITH THIS.cmd_4c_CmdApaga1
1103:                 .Top         = 375
1104:                 .Left        = 742
1105:                 .Width       = 40
1106:                 .Height      = 40
1107:                 .FontName    = "Verdana"
1108:                 .FontSize    = 8
1109:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1110:                 .Caption     = ""
1111:                 .ToolTipText = "Desmarca tudo"
1112:                 .ForeColor   = RGB(36, 84, 155)
1113:                 .BackColor   = RGB(255, 255, 255)
1114:                 .Themes           = .T.
1115:                 .TabStop     = .F.
1116:                 .Visible     = .T.
1117:             ENDWITH
1118:             BINDEVENT(THIS.cmd_4c_CmdApaga1, "Click", THIS, "BtnDesmarcarTudoClick")
1119: 
1120:             *-- Botao standalone: Command2 "Processar" - dispara a carga da
1121:             *-- grade (MontaChq do legado). Propriedades EXATAS do SCX
1122:             *-- (Top=191, Left=598, Height=24, Width=88, Comic Sans MS 8
1123:             *-- bold+italic, ForeColor 90,90,90, BackColor 255,255,255,
1124:             *-- Themes=.F., TabIndex=7). O legado NAO declara Picture para
1125:             *-- este botao - nenhum icone eh inventado aqui.
1126:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
1127:             WITH THIS.cmd_4c_Processar
1128:                 .Top        = 191
1129:                 .Left       = 598
1130:                 .Width      = 88
1131:                 .Height     = 24
1132:                 .FontName   = "Comic Sans MS"
1133:                 .FontSize   = 8
1134:                 .FontBold   = .T.
1135:                 .FontItalic = .T.
1136:                 .Caption    = "Processar"
1137:                 .TabIndex   = 7
1138:                 .ForeColor  = RGB(90, 90, 90)
1139:                 .BackColor  = RGB(255, 255, 255)
1140:                 .Themes     = .F.
1141:                 .Visible    = .T.
1142:             ENDWITH
1143:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1144:         CATCH TO loc_oErro
1145:             MsgErro(loc_oErro.Message + CHR(13) + ;
1146:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1147:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
1148:         ENDTRY
1149:     ENDPROC
1150: 
1151:     *==========================================================================
1152:     * ConfigurarFiltros - Primeira metade dos campos de filtro (Fase 5/8):
1153:     * grupo Grupo (Label3/GetCdGrupos/GetDsGrupos) e grupo Periodo
1154:     * (Label2/Dt_inicial/Say2/Dt_final). Posicoes EXATAS do SCX original
1155:     * (layout.json) - form OPERACIONAL sem PageFrame, sem compensacao de +29.
1156:     *
1157:     * Handlers de Valid/lookup (fAcessoContab do Grupo, swap de datas do
1158:     * Periodo, e os campos de Conta/Favorecido restantes) sao implementados
1159:     * na fase seguinte, junto com o grupo Conta - mesmo padrao ja usado em
1160:     * FormSIGMVCMV.ConfigurarCamposPeriodoMoeda.
1161:     *
1162:     * TabIndex 1-4 reservados para este grupo; 5-6 ficam para Conta (proxima
1163:     * fase); 7 ja esta ocupado por cmd_4c_Processar (Fase 4).
1164:     *==========================================================================
1165:     PROTECTED PROCEDURE ConfigurarFiltros()
1166:         LOCAL loc_oErro
1167: 
1168:         TRY
1169:             *-- Label3 "Grupo :"
1170:             THIS.AddObject("lbl_4c_Label3", "Label")
1171:             WITH THIS.lbl_4c_Label3
1172:                 .Top       = 167
1173:                 .Left      = 34
1174:                 .Width     = 38
1175:                 .Height    = 15
1176:                 .FontName  = "Tahoma"
1177:                 .FontSize  = 8
1178:                 .Alignment = 0
1179:                 .BackStyle = 0
1180:                 .ForeColor = RGB(90, 90, 90)
1181:                 .Caption   = "Grupo :"
1182:                 .Visible   = .T.
1183:             ENDWITH
1184: 
1185:             *-- GetCdGrupos (codigo do grupo de contas - SigCdGcr.codigos char(10))
1186:             THIS.AddObject("txt_4c_CdGrupos", "TextBox")
1187:             WITH THIS.txt_4c_CdGrupos
1188:                 .Top           = 163
1189:                 .Left          = 75
1190:                 .Width         = 100
1191:                 .Height        = 25
1192:                 .FontName      = "Tahoma"
1193:                 .FontSize      = 8
1194:                 .MaxLength     = 10
1195:                 .SpecialEffect = 1
1196:                 .BorderColor   = RGB(36, 84, 155)
1197:                 .Value         = ""
1198:                 .TabIndex      = 1
1199:                 .Visible       = .T.
1200:             ENDWITH
1201: 
1202:             *-- GetDsGrupos (descricao do grupo - SigCdGcr.descrs char(40))
1203:             THIS.AddObject("txt_4c_DsGrupos", "TextBox")
1204:             WITH THIS.txt_4c_DsGrupos
1205:                 .Top           = 163

*-- Linhas 1365 a 1453:
1365:                 .Visible       = .T.
1366:             ENDWITH
1367: 
1368:             *-- BINDEVENT de snapshot (equivalente ao When legado: guarda o
1369:             *-- valor corrente em this_cAnt*/this_dAnt* ANTES da edicao) +
1370:             *-- BINDEVENT de KeyPress (equivalente ao Valid - BINDEVENT em
1371:             *-- "Valid" nao funciona de forma confiavel em TextBox, ver
1372:             *-- CLAUDE.md/memoria "feedback_keypress_lparameters_guard").
1373:             BINDEVENT(THIS.txt_4c_CdGrupos,   "GotFocus", THIS, "TxtCdGruposGotFocus")
1374:             BINDEVENT(THIS.txt_4c_DsGrupos,   "GotFocus", THIS, "TxtDsGruposGotFocus")
1375:             BINDEVENT(THIS.txt_4c_CdContas,   "GotFocus", THIS, "TxtCdContasGotFocus")
1376:             BINDEVENT(THIS.txt_4c_DsContas,   "GotFocus", THIS, "TxtDsContasGotFocus")
1377:             BINDEVENT(THIS.txt_4c_Dt_inicial, "GotFocus", THIS, "TxtDtInicialGotFocus")
1378:             BINDEVENT(THIS.txt_4c_Dt_final,   "GotFocus", THIS, "TxtDtFinalGotFocus")
1379: 
1380:             BINDEVENT(THIS.txt_4c_CdGrupos,   "KeyPress", THIS, "ValidarCdGruposKeyPress")
1381:             BINDEVENT(THIS.txt_4c_DsGrupos,   "KeyPress", THIS, "ValidarDsGruposKeyPress")
1382:             BINDEVENT(THIS.txt_4c_CdContas,   "KeyPress", THIS, "ValidarCdContasKeyPress")
1383:             BINDEVENT(THIS.txt_4c_DsContas,   "KeyPress", THIS, "ValidarDsContasKeyPress")
1384:             BINDEVENT(THIS.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDtInicialKeyPress")
1385:             BINDEVENT(THIS.txt_4c_Dt_final,   "KeyPress", THIS, "ValidarDtFinalKeyPress")
1386:         CATCH TO loc_oErro
1387:             MsgErro(loc_oErro.Message + CHR(13) + ;
1388:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1389:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
1390:         ENDTRY
1391:     ENDPROC
1392: 
1393:     *==========================================================================
1394:     * ConfigurarContainersFlutuantes - Orquestra os 3 paineis Visible=.F. do
1395:     * legado, alternados por botao (cntjustificativa/cntProcurar/impchmat -
1396:     * mapeamento.json: cnt_4c_justificativa/cnt_4c_Procurar/cnt_4c_Impchmat).
1397:     * Precisam ficar na lista de skip de TornarControlesVisiveis (ja
1398:     * presente desde a Fase 3) - senao nasceriam visiveis.
1399:     *==========================================================================
1400:     PROTECTED PROCEDURE ConfigurarContainersFlutuantes()
1401:         THIS.ConfigurarJustificativa()
1402:         THIS.ConfigurarProcurar()
1403:         THIS.ConfigurarImpressaoManual()
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * ConfigurarJustificativa - Painel de justificativa do cancelamento de
1408:     * documento (cnt_4c_justificativa = cntjustificativa do legado, Registro
1409:     * 47/48 do SCX). Aberto por BtnExcluiDocClick (editavel) ou por
1410:     * AtualizarPainelChequeCorrente (somente leitura, ao navegar para um
1411:     * cheque ja cancelado).
1412:     *==========================================================================
1413:     PROTECTED PROCEDURE ConfigurarJustificativa()
1414:         LOCAL loc_oErro
1415: 
1416:         TRY
1417:             THIS.AddObject("cnt_4c_justificativa", "Container")
1418:             WITH THIS.cnt_4c_justificativa
1419:                 .Top           = 532
1420:                 .Left          = 395
1421:                 .Width         = 350
1422:                 .Height        = 69
1423:                 .BorderWidth   = 0
1424:                 .SpecialEffect = 0
1425:                 .BackColor     = RGB(255, 255, 255)
1426:                 .Visible       = .F.
1427:             ENDWITH
1428: 
1429:             THIS.cnt_4c_justificativa.AddObject("lbl_4c_Label5", "Label")
1430:             WITH THIS.cnt_4c_justificativa.lbl_4c_Label5
1431:                 .AutoSize  = .T.
1432:                 .FontName  = "Tahoma"
1433:                 .FontSize  = 8
1434:                 .BackStyle = 0
1435:                 .Caption   = "Justificativa do cancelamento"
1436:                 .Left      = 6
1437:                 .Top       = 5
1438:                 .ForeColor = RGB(90, 90, 90)
1439:                 .Visible   = .T.
1440:             ENDWITH
1441: 
1442:             THIS.cnt_4c_justificativa.AddObject("obj_4c_Get_justificativa", "EditBox")
1443:             WITH THIS.cnt_4c_justificativa.obj_4c_Get_justificativa
1444:                 .Top       = 21
1445:                 .Left      = 3
1446:                 .Width     = 238
1447:                 .Height    = 44
1448:                 .FontName  = "Tahoma"
1449:                 .FontSize  = 8
1450:                 .ForeColor = RGB(0, 0, 0)
1451:                 .ReadOnly  = .F.
1452:                 .Visible   = .T.
1453:             ENDWITH

*-- Linhas 1496 a 1553:
1496:                 .Themes      = .F.
1497:             ENDWITH
1498: 
1499:             BINDEVENT(THIS.cnt_4c_justificativa.obj_4c_CmdGconf, "Click", THIS, "CmdGconfClick")
1500:         CATCH TO loc_oErro
1501:             MsgErro(loc_oErro.Message + CHR(13) + ;
1502:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1503:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarJustificativa")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     *==========================================================================
1508:     * ConfigurarProcurar - Painel de busca de cheque por Banco/Agencia/
1509:     * Conta/Cheque/Emissao/Valor ou leitor de codigo de barras
1510:     * (cnt_4c_Procurar = cntProcurar do legado, Registro 59+). Aberto por
1511:     * BtnProcurarClick (botao Procurar do CommandGroup principal).
1512:     *==========================================================================
1513:     PROTECTED PROCEDURE ConfigurarProcurar()
1514:         LOCAL loc_oErro
1515: 
1516:         TRY
1517:             THIS.AddObject("cnt_4c_Procurar", "Container")
1518:             WITH THIS.cnt_4c_Procurar
1519:                 .Top           = 284
1520:                 .Left          = 240
1521:                 .Width         = 314
1522:                 .Height        = 218
1523:                 .SpecialEffect = 0
1524:                 .Enabled       = .F.
1525:                 .Visible       = .F.
1526:                 .BackColor     = RGB(255, 255, 255)
1527:             ENDWITH
1528: 
1529:             THIS.cnt_4c_Procurar.AddObject("lbl_4c_Label1", "Label")
1530:             WITH THIS.cnt_4c_Procurar.lbl_4c_Label1
1531:                 .AutoSize  = .T.
1532:                 .FontBold  = .T.
1533:                 .FontName  = "Tahoma"
1534:                 .FontSize  = 9
1535:                 .BackStyle = 0
1536:                 .Caption   = "Procurar"
1537:                 .Left      = 12
1538:                 .Top       = 8
1539:                 .ForeColor = RGB(90, 90, 90)
1540:                 .Visible   = .T.
1541:             ENDWITH
1542: 
1543:             THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblBanco", "Label")
1544:             WITH THIS.cnt_4c_Procurar.lbl_4c_LblBanco
1545:                 .FontName  = "Tahoma"
1546:                 .FontSize  = 8
1547:                 .Alignment = 0
1548:                 .BackStyle = 0
1549:                 .Caption   = "Banco :"
1550:                 .Left      = 36
1551:                 .Top       = 139
1552:                 .Width     = 38
1553:                 .Height    = 15

*-- Linhas 1773 a 1831:
1773:                 .Themes          = .F.
1774:             ENDWITH
1775: 
1776:             BINDEVENT(THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar, "Click", THIS, "CmdgprocurarClick")
1777:             BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Banco, "KeyPress", THIS, "TxtProcurarBancoKeyPress")
1778:         CATCH TO loc_oErro
1779:             MsgErro(loc_oErro.Message + CHR(13) + ;
1780:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1781:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarProcurar")
1782:         ENDTRY
1783:     ENDPROC
1784: 
1785:     *==========================================================================
1786:     * ConfigurarImpressaoManual - Painel de impressao matricial manual por
1787:     * Banco + faixa de cheques (cnt_4c_Impchmat = impchmat do legado,
1788:     * Registro 50+). Aberto por BtnChMatClick quando nao ha cheque marcado
1789:     * na grade.
1790:     *==========================================================================
1791:     PROTECTED PROCEDURE ConfigurarImpressaoManual()
1792:         LOCAL loc_oErro
1793: 
1794:         TRY
1795:             THIS.AddObject("cnt_4c_Impchmat", "Container")
1796:             WITH THIS.cnt_4c_Impchmat
1797:                 .Top           = 284
1798:                 .Left          = 240
1799:                 .Width         = 314
1800:                 .Height        = 218
1801:                 .SpecialEffect = 0
1802:                 .Enabled       = .F.
1803:                 .Visible       = .F.
1804:                 .BackColor     = RGB(255, 255, 255)
1805:             ENDWITH
1806: 
1807:             THIS.cnt_4c_Impchmat.AddObject("lbl_4c_Label1", "Label")
1808:             WITH THIS.cnt_4c_Impchmat.lbl_4c_Label1
1809:                 .AutoSize  = .T.
1810:                 .FontBold  = .T.
1811:                 .FontName  = "Tahoma"
1812:                 .BackStyle = 0
1813:                 .Caption   = "Impress" + CHR(227) + "o"
1814:                 .Left      = 12
1815:                 .Top       = 8
1816:                 .ForeColor = RGB(90, 90, 90)
1817:                 .Visible   = .T.
1818:             ENDWITH
1819: 
1820:             THIS.cnt_4c_Impchmat.AddObject("lbl_4c_LblBanco", "Label")
1821:             WITH THIS.cnt_4c_Impchmat.lbl_4c_LblBanco
1822:                 .FontName  = "Tahoma"
1823:                 .FontSize  = 8
1824:                 .Alignment = 0
1825:                 .BackStyle = 0
1826:                 .Caption   = "Banco :"
1827:                 .Left      = 66
1828:                 .Top       = 157
1829:                 .Width     = 38
1830:                 .Height    = 15
1831:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1958 a 2126:
1958:                 .Themes          = .F.
1959:             ENDWITH
1960: 
1961:             BINDEVENT(THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar, "Click", THIS, "CmdGprocurarImpChmatClick")
1962:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini, "KeyPress", THIS, "TxtChiniKeyPress")
1963:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin, "KeyPress", THIS, "TxtChfinKeyPress")
1964:         CATCH TO loc_oErro
1965:             MsgErro(loc_oErro.Message + CHR(13) + ;
1966:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1967:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImpressaoManual")
1968:         ENDTRY
1969:     ENDPROC
1970: 
1971:     *==========================================================================
1972:     * TxtCdGruposGotFocus / TxtDsGruposGotFocus / TxtCdContasGotFocus /
1973:     * TxtDsContasGotFocus / TxtDtInicialGotFocus / TxtDtFinalGotFocus -
1974:     * Equivalente ao evento When do legado: guarda o valor corrente do campo
1975:     * ANTES da edicao (AntCdGrupo/AntDsGrupo/AntCdConta/AntDsConta/AntDtIni/
1976:     * AntDtFin), para o KeyPress-Valid comparar depois e decidir se limpa a
1977:     * grade. PUBLIC - BINDEVENT so dispara metodos PUBLIC.
1978:     *==========================================================================
1979:     PROCEDURE TxtCdGruposGotFocus()
1980:         THIS.this_oBusinessObject.this_cAntCodGrupo = THIS.txt_4c_CdGrupos.Value
1981:     ENDPROC
1982: 
1983:     PROCEDURE TxtDsGruposGotFocus()
1984:         THIS.this_oBusinessObject.this_cAntDescGrupo = THIS.txt_4c_DsGrupos.Value
1985:     ENDPROC
1986: 
1987:     PROCEDURE TxtCdContasGotFocus()
1988:         THIS.this_oBusinessObject.this_cAntCodConta = THIS.txt_4c_CdContas.Value
1989:     ENDPROC
1990: 
1991:     PROCEDURE TxtDsContasGotFocus()
1992:         THIS.this_oBusinessObject.this_cAntDescConta = THIS.txt_4c_DsContas.Value
1993:     ENDPROC
1994: 
1995:     PROCEDURE TxtDtInicialGotFocus()
1996:         THIS.this_oBusinessObject.this_dAntDataInicial = THIS.txt_4c_Dt_inicial.Value
1997:     ENDPROC
1998: 
1999:     PROCEDURE TxtDtFinalGotFocus()
2000:         THIS.this_oBusinessObject.this_dAntDataFinal = THIS.txt_4c_Dt_final.Value
2001:     ENDPROC
2002: 
2003:     *==========================================================================
2004:     * LimparChequesSeFiltroMudou - Equivalente ao "If Used('CsSigCqChi') / Zap
2005:     * In CsSigCqChi / ThisForm.GrdCCheques.Refresh" repetido em TODOS os Valid
2006:     * de filtro do legado: some com a grade quando o usuario altera Grupo/
2007:     * Conta/Periodo, para nao exibir resultado desatualizado ate clicar
2008:     * Processar. ZAP exige SAFETY OFF (config.prg so seta SET EXACT ON - a
2009:     * mesma ressalva de MontaGrade acima).
2010:     *==========================================================================
2011:     PROTECTED PROCEDURE LimparChequesSeFiltroMudou()
2012:         LOCAL loc_cCursor, loc_cSafety
2013: 
2014:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2015: 
2016:         IF USED(loc_cCursor)
2017:             loc_cSafety = SET("Safety")
2018:             SET SAFETY OFF
2019: 
2020:             SELECT (loc_cCursor)
2021:             ZAP
2022: 
2023:             IF loc_cSafety == "ON"
2024:                 SET SAFETY ON
2025:             ENDIF
2026: 
2027:             THIS.grd_4c_Dados.Refresh()
2028:         ENDIF
2029:     ENDPROC
2030: 
2031:     *==========================================================================
2032:     * ValidarCdGruposKeyPress / ValidarDsGruposKeyPress - Equivalente ao Valid
2033:     * de GetCdGrupos/GetDsGrupos do legado (fAcessoContab): F4 abre o picker
2034:     * (AbrirBuscaGrupo), Enter/Tab tenta o match EXATO contra SigCdGcr
2035:     * (Codigos/Descrs) e, sem match, abre o picker com o prefixo digitado. O
2036:     * campo Descricao replica o guard do When original (Return(Empty(
2037:     * GetCdGrupos.Value))) - so participa da busca quando o Codigo esta vazio.
2038:     *==========================================================================
2039:     PROCEDURE ValidarCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2040:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lMudou
2041: 
2042:         IF par_nKeyCode = 115  && F4
2043:             THIS.AbrirBuscaGrupo()
2044:             NODEFAULT
2045:             RETURN
2046:         ENDIF
2047: 
2048:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2049:             RETURN
2050:         ENDIF
2051: 
2052:         loc_cValor = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2053:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntCodGrupo)
2054: 
2055:         IF EMPTY(loc_cValor)
2056:             THIS.txt_4c_DsGrupos.Value = ""
2057:         ELSE
2058:             IF USED("cursor_4c_BuscaGrupo")
2059:                 USE IN cursor_4c_BuscaGrupo
2060:             ENDIF
2061: 
2062:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cValor)
2063:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2064: 
2065:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2066:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2067:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2068: 
2069:                 IF USED("cursor_4c_BuscaGrupo")
2070:                     USE IN cursor_4c_BuscaGrupo
2071:                 ENDIF
2072:             ELSE
2073:                 IF USED("cursor_4c_BuscaGrupo")
2074:                     USE IN cursor_4c_BuscaGrupo
2075:                 ENDIF
2076:                 THIS.AbrirBuscaGrupo()
2077:                 RETURN
2078:             ENDIF
2079:         ENDIF
2080: 
2081:         IF loc_lMudou
2082:             THIS.LimparChequesSeFiltroMudou()
2083:         ENDIF
2084:     ENDPROC
2085: 
2086:     PROCEDURE ValidarDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2087:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lMudou
2088: 
2089:         IF par_nKeyCode = 115  && F4
2090:             THIS.AbrirBuscaGrupo()
2091:             NODEFAULT
2092:             RETURN
2093:         ENDIF
2094: 
2095:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2096:             RETURN
2097:         ENDIF
2098: 
2099:         *-- Legado: GetDsGrupos.When = Return(Empty(GetCdGrupos.Value)) - o
2100:         *-- campo Descricao so participa da busca quando o Codigo esta vazio.
2101:         IF !EMPTY(THIS.txt_4c_CdGrupos.Value)
2102:             RETURN
2103:         ENDIF
2104: 
2105:         loc_cValor = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2106:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntDescGrupo)
2107: 
2108:         IF EMPTY(loc_cValor)
2109:             THIS.txt_4c_CdGrupos.Value = ""
2110:         ELSE
2111:             IF USED("cursor_4c_BuscaGrupo")
2112:                 USE IN cursor_4c_BuscaGrupo
2113:             ENDIF
2114: 
2115:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cValor)
2116:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2117: 
2118:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2119:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2120:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2121: 
2122:                 IF USED("cursor_4c_BuscaGrupo")
2123:                     USE IN cursor_4c_BuscaGrupo
2124:                 ENDIF
2125:             ELSE
2126:                 IF USED("cursor_4c_BuscaGrupo")

*-- Linhas 2144 a 2236:
2144:     * memoria feedback_facessocontas_lookup_ux.md); aqui o filtro eh o
2145:     * prefixo ja digitado, igual ao padrao Pattern A do projeto.
2146:     *==========================================================================
2147:     PROTECTED PROCEDURE AbrirBuscaGrupo()
2148:         LOCAL loc_oBusca, loc_cSQL, loc_cFiltro, loc_nResultado
2149: 
2150:         loc_cFiltro = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2151:         IF EMPTY(loc_cFiltro)
2152:             loc_cFiltro = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2153:         ENDIF
2154: 
2155:         IF USED("cursor_4c_BuscaGrupo")
2156:             USE IN cursor_4c_BuscaGrupo
2157:         ENDIF
2158: 
2159:         IF !EMPTY(loc_cFiltro)
2160:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE " + ;
2161:                 "codigos LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2162:                 " OR descrs LIKE " + EscaparSQL(loc_cFiltro + "%") + " ORDER BY codigos"
2163:         ELSE
2164:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
2165:         ENDIF
2166: 
2167:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2168: 
2169:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2170:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2171:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "codigos", "descrs", ;
2172:                 "Grupo de Contas")
2173: 
2174:             IF loc_oBusca.Mostrar()
2175:                 THIS.txt_4c_CdGrupos.Value = loc_oBusca.cCodigoSelecionado
2176:                 THIS.txt_4c_DsGrupos.Value = loc_oBusca.cDescricaoSelecionada
2177:                 THIS.LimparChequesSeFiltroMudou()
2178:             ENDIF
2179: 
2180:             loc_oBusca.Release()
2181:         ENDIF
2182: 
2183:         IF USED("cursor_4c_BuscaGrupo")
2184:             USE IN cursor_4c_BuscaGrupo
2185:         ENDIF
2186:     ENDPROC
2187: 
2188:     *==========================================================================
2189:     * ValidarCdContasKeyPress / ValidarDsContasKeyPress - Equivalente ao Valid
2190:     * de getCdContas/getDsContas do legado (fAcessoContas): F4 abre o picker
2191:     * (AbrirBuscaConta), Enter/Tab tenta o match EXATO contra SigCdCli
2192:     * (Iclis/Rclis) filtrado pelo Grupo corrente, e sem match abre o picker
2193:     * com o prefixo digitado. getDsContas replica o guard do When original
2194:     * (Return(Empty(GetCdContas.Value))).
2195:     *==========================================================================
2196:     PROCEDURE ValidarCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2197:         LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_lMudou
2198: 
2199:         IF par_nKeyCode = 115  && F4
2200:             THIS.AbrirBuscaConta()
2201:             NODEFAULT
2202:             RETURN
2203:         ENDIF
2204: 
2205:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2206:             RETURN
2207:         ENDIF
2208: 
2209:         loc_cValor = ALLTRIM(THIS.txt_4c_CdContas.Value)
2210:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntCodConta)
2211: 
2212:         IF EMPTY(loc_cValor)
2213:             THIS.txt_4c_DsContas.Value = ""
2214:         ELSE
2215:             loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2216: 
2217:             IF USED("cursor_4c_BuscaConta")
2218:                 USE IN cursor_4c_BuscaConta
2219:             ENDIF
2220: 
2221:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
2222:             IF !EMPTY(loc_cGrupo)
2223:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2224:             ENDIF
2225: 
2226:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2227: 
2228:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2229:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2230:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2231: 
2232:                 IF USED("cursor_4c_BuscaConta")
2233:                     USE IN cursor_4c_BuscaConta
2234:                 ENDIF
2235:             ELSE
2236:                 IF USED("cursor_4c_BuscaConta")

*-- Linhas 2246 a 2289:
2246:         ENDIF
2247:     ENDPROC
2248: 
2249:     PROCEDURE ValidarDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2250:         LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_lMudou
2251: 
2252:         IF par_nKeyCode = 115  && F4
2253:             THIS.AbrirBuscaConta()
2254:             NODEFAULT
2255:             RETURN
2256:         ENDIF
2257: 
2258:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2259:             RETURN
2260:         ENDIF
2261: 
2262:         *-- Legado: getDsContas.When = Return(Empty(GetCdContas.Value))
2263:         IF !EMPTY(THIS.txt_4c_CdContas.Value)
2264:             RETURN
2265:         ENDIF
2266: 
2267:         loc_cValor = ALLTRIM(THIS.txt_4c_DsContas.Value)
2268:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntDescConta)
2269: 
2270:         IF EMPTY(loc_cValor)
2271:             THIS.txt_4c_CdContas.Value = ""
2272:         ELSE
2273:             loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2274: 
2275:             IF USED("cursor_4c_BuscaConta")
2276:                 USE IN cursor_4c_BuscaConta
2277:             ENDIF
2278: 
2279:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE RTRIM(rclis) = " + EscaparSQL(loc_cValor)
2280:             IF !EMPTY(loc_cGrupo)
2281:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2282:             ENDIF
2283: 
2284:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2285: 
2286:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2287:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2288:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2289: 

*-- Linhas 2311 a 2458:
2311:     * lookup UX (memoria feedback_facessocontas_lookup_ux.md: auto-carrega o
2312:     * primeiro registro do LIKE sem selecao do usuario).
2313:     *==========================================================================
2314:     PROTECTED PROCEDURE AbrirBuscaConta()
2315:         LOCAL loc_oBusca, loc_cSQL, loc_cFiltro, loc_cGrupo, loc_nResultado
2316: 
2317:         loc_cFiltro = ALLTRIM(THIS.txt_4c_CdContas.Value)
2318:         IF EMPTY(loc_cFiltro)
2319:             loc_cFiltro = ALLTRIM(THIS.txt_4c_DsContas.Value)
2320:         ENDIF
2321: 
2322:         loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2323: 
2324:         IF USED("cursor_4c_BuscaConta")
2325:             USE IN cursor_4c_BuscaConta
2326:         ENDIF
2327: 
2328:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE 1 = 1 "
2329: 
2330:         IF !EMPTY(loc_cGrupo)
2331:             loc_cSQL = loc_cSQL + "AND grupos = " + EscaparSQL(loc_cGrupo) + " "
2332:         ENDIF
2333: 
2334:         IF !EMPTY(loc_cFiltro)
2335:             loc_cSQL = loc_cSQL + "AND (iclis LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2336:                 " OR RTRIM(rclis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ") "
2337:         ENDIF
2338: 
2339:         loc_cSQL = loc_cSQL + "ORDER BY iclis"
2340: 
2341:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2342: 
2343:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2344:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2345:             loc_oBusca.DefinirCursor("cursor_4c_BuscaConta", "iclis", "rclis", "Contas")
2346: 
2347:             IF loc_oBusca.Mostrar()
2348:                 THIS.txt_4c_CdContas.Value = loc_oBusca.cCodigoSelecionado
2349:                 THIS.txt_4c_DsContas.Value = loc_oBusca.cDescricaoSelecionada
2350:                 THIS.LimparChequesSeFiltroMudou()
2351:             ENDIF
2352: 
2353:             loc_oBusca.Release()
2354:         ENDIF
2355: 
2356:         IF USED("cursor_4c_BuscaConta")
2357:             USE IN cursor_4c_BuscaConta
2358:         ENDIF
2359:     ENDPROC
2360: 
2361:     *==========================================================================
2362:     * ValidarDtInicialKeyPress / ValidarDtFinalKeyPress - Equivalente ao Valid
2363:     * de Dt_inicial/Dt_final do legado: mantem Data Inicial <= Data Final
2364:     * empurrando a outra ponta do periodo (mesma logica do SCX original), e
2365:     * limpa a grade quando o valor mudou desde que o campo recebeu foco.
2366:     *==========================================================================
2367:     PROCEDURE ValidarDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2368:         LOCAL loc_lMudou
2369: 
2370:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2371:             RETURN
2372:         ENDIF
2373: 
2374:         *-- Legado: If This.Value > Dt_Final.Value -> Dt_Final.Value = This.Value
2375:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2376:             THIS.txt_4c_Dt_final.Value = THIS.txt_4c_Dt_inicial.Value
2377:         ENDIF
2378: 
2379:         loc_lMudou = THIS.txt_4c_Dt_inicial.Value != THIS.this_oBusinessObject.this_dAntDataInicial
2380: 
2381:         IF loc_lMudou
2382:             THIS.LimparChequesSeFiltroMudou()
2383:         ENDIF
2384:     ENDPROC
2385: 
2386:     PROCEDURE ValidarDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2387:         LOCAL loc_lMudou
2388: 
2389:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2390:             RETURN
2391:         ENDIF
2392: 
2393:         *-- Legado: If This.Value < Dt_Inicial.Value -> Dt_Inicial.Value = This.Value
2394:         IF THIS.txt_4c_Dt_final.Value < THIS.txt_4c_Dt_inicial.Value
2395:             THIS.txt_4c_Dt_inicial.Value = THIS.txt_4c_Dt_final.Value
2396:         ENDIF
2397: 
2398:         loc_lMudou = THIS.txt_4c_Dt_final.Value != THIS.this_oBusinessObject.this_dAntDataFinal
2399: 
2400:         IF loc_lMudou
2401:             THIS.LimparChequesSeFiltroMudou()
2402:         ENDIF
2403:     ENDPROC
2404: 
2405:     *==========================================================================
2406:     * BtnProcessarClick - Command2.Click ("Processar") do legado: valida o
2407:     * periodo, sincroniza os filtros para o BO e recarrega a grade.
2408:     *
2409:     * O guard "so recarrega se algum filtro mudou OU eh a primeira exibicao"
2410:     * eh transcrito como esta: as condicoes que CERCAM a validacao fazem parte
2411:     * da regra (CLAUDE.md #21b). Os valores Ant* sao atualizados pelos eventos
2412:     * When dos proprios campos de filtro (fase de filtros), NAO aqui - no
2413:     * legado quem grava AntDtIni/AntCdConta eh o When de cada TextBox.
2414:     *
2415:     * As tres validacoes de Grupo/Conta obrigatorios que existem no legado
2416:     * estao COMENTADAS no legado (*!*) - portanto aposentadas, e NAO migradas.
2417:     *==========================================================================
2418:     PROCEDURE BtnProcessarClick()
2419:         LOCAL loc_dIni, loc_dFim, loc_cGrupo, loc_cConta, loc_lRecarregar
2420:         LOCAL loc_oBO
2421: 
2422:         loc_oBO = THIS.this_oBusinessObject
2423: 
2424:         loc_dIni   = THIS.ObterFiltroDataInicial()
2425:         loc_dFim   = THIS.ObterFiltroDataFinal()
2426:         loc_cGrupo = THIS.ObterFiltroGrupo()
2427:         loc_cConta = THIS.ObterFiltroConta()
2428: 
2429:         *-- Legado: If Dt_Inicial.Value > Dt_Final.Value -> erro + SetFocus
2430:         IF loc_dIni > loc_dFim
2431:             MsgErro("Data Final menor que Data Inicial !!!", ;
2432:                 "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
2433: 
2434:             IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
2435:                 THIS.txt_4c_Dt_inicial.SetFocus()
2436:             ENDIF
2437: 
2438:             RETURN
2439:         ENDIF
2440: 
2441:         *-- Legado: AntDtIni # Dt_Inicial Or AntDtFin # Dt_Final Or
2442:         *--         AntCdGrupo # getCdGrupos Or AntCdConta # getCdContas Or Inicial
2443:         loc_lRecarregar = ;
2444:             loc_oBO.this_dAntDataInicial != loc_dIni   OR ;
2445:             loc_oBO.this_dAntDataFinal   != loc_dFim   OR ;
2446:             ALLTRIM(loc_oBO.this_cAntCodGrupo) != ALLTRIM(loc_cGrupo) OR ;
2447:             ALLTRIM(loc_oBO.this_cAntCodConta) != ALLTRIM(loc_cConta) OR ;
2448:             loc_oBO.this_lPrimeiraExibicao
2449: 
2450:         IF loc_lRecarregar
2451:             *-- CarregarLista eh o FUNIL da carga: sincroniza os filtros da
2452:             *-- tela para o BO (FormParaBO - fonte unica da consulta), garante
2453:             *-- o cursor da grade e chama MontaGrade, que ja reporta a falha
2454:             *-- (mensagem unica - CLAUDE.md regra #20).
2455:             IF !THIS.CarregarLista(.F.)
2456:                 RETURN
2457:             ENDIF
2458:         ELSE

*-- Linhas 2505 a 2828:
2505:     *==========================================================================
2506:     * CmdGokClick - Dispatcher do CommandGroup de acoes (obj_4c_CmdGok),
2507:     * replicando o padrao 1-metodo-por-botao do cmdGok legado via
2508:     * DO CASE(THIS.Value). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
2509:     *==========================================================================
2510:     PROCEDURE CmdGokClick()
2511:         DO CASE
2512:             CASE THIS.obj_4c_CmdGok.Value = 1
2513:                 THIS.BtnDocumentoClick()
2514:             CASE THIS.obj_4c_CmdGok.Value = 2
2515:                 THIS.BtnSairClick()
2516:             CASE THIS.obj_4c_CmdGok.Value = 3
2517:                 THIS.BtnImprimirClick()
2518:             CASE THIS.obj_4c_CmdGok.Value = 4
2519:                 THIS.BtnProcurarClick()
2520:             CASE THIS.obj_4c_CmdGok.Value = 5
2521:                 THIS.BtnReciboClick()
2522:             CASE THIS.obj_4c_CmdGok.Value = 6
2523:                 THIS.BtnExcluiDocClick()
2524:             CASE THIS.obj_4c_CmdGok.Value = 7
2525:                 THIS.BtnImpChqClick()
2526:             CASE THIS.obj_4c_CmdGok.Value = 8
2527:                 THIS.BtnChMatClick()
2528:             CASE THIS.obj_4c_CmdGok.Value = 9
2529:                 THIS.BtnExcluirChqClick()
2530:         ENDCASE
2531:     ENDPROC
2532: 
2533:     *==========================================================================
2534:     * BtnSairClick - Encerrar (cmdSair.Click do legado). Fecha os cursores
2535:     * auxiliares de contas e libera o form.
2536:     *==========================================================================
2537:     PROCEDURE BtnSairClick()
2538:         IF USED(THIS.this_oBusinessObject.this_cCursorContas)
2539:             USE IN (THIS.this_oBusinessObject.this_cCursorContas)
2540:         ENDIF
2541: 
2542:         THIS.Release()
2543:     ENDPROC
2544: 
2545:     *==========================================================================
2546:     * BtnExcluirChqClick - Excluir Chq. (btnExcluirChq.Click do legado). So
2547:     * confirma e delega ao BusinessObject.Excluir() - AntesDeExcluir() ja
2548:     * replica o guard do legado (ncancelas=1 AND ExcluirCheque) e a falha eh
2549:     * reportada sozinha pelo BusinessBase (CLAUDE.md regra #20).
2550:     *
2551:     * CarregarDoCursor() (SigPrChrBO) le as colunas RAW de SigCqChi
2552:     * (cancelas/emitidos/grupos/vencs/versos/empdopnums/impversos) - nomes
2553:     * que NAO existem em cursor_4c_Cheques (a grade tem so nemitidos/
2554:     * ncancelas convertidos via CASE WHEN, sem grupos/vencs/versos/
2555:     * empdopnums/impversos). Passar o cursor da grade direto estouraria
2556:     * "Variable 'CANCELAS' is not found." Por isso o cheque corrente eh
2557:     * relido com SELECT * FROM SigCqChi (mesmas colunas que CarregarDoCursor
2558:     * espera), pela PK cidchaves.
2559:     *==========================================================================
2560:     PROCEDURE BtnExcluirChqClick()
2561:         LOCAL loc_cCursor, loc_cCidchaves, loc_cSQL, loc_nResultado, loc_cMensagem
2562: 
2563:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2564: 
2565:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2566:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2567:             RETURN
2568:         ENDIF
2569: 
2570:         loc_cCidchaves = EVALUATE(loc_cCursor + ".cidchaves")
2571: 
2572:         IF USED("cursor_4c_ChequeAtual")
2573:             USE IN cursor_4c_ChequeAtual
2574:         ENDIF
2575: 
2576:         loc_cSQL = "SELECT * FROM SigCqChi WHERE cidchaves = " + EscaparSQL(loc_cCidchaves)
2577:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequeAtual")
2578: 
2579:         IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_ChequeAtual") = 0
2580:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o cheque para exclus" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
2581:             IF USED("cursor_4c_ChequeAtual")
2582:                 USE IN cursor_4c_ChequeAtual
2583:             ENDIF
2584:             RETURN
2585:         ENDIF
2586: 
2587:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ChequeAtual")
2588: 
2589:         IF USED("cursor_4c_ChequeAtual")
2590:             USE IN cursor_4c_ChequeAtual
2591:         ENDIF
2592: 
2593:         loc_cMensagem = "Deseja realmente excluir o cheque :" + CHR(13) + ;
2594:             ALLTRIM(THIS.this_oBusinessObject.this_cBancos)   + " / " + ;
2595:             ALLTRIM(THIS.this_oBusinessObject.this_cAgencias) + " / " + ;
2596:             ALLTRIM(THIS.this_oBusinessObject.this_cNcontas)  + " / " + ;
2597:             ALLTRIM(THIS.this_oBusinessObject.this_cNcheques) + " ?"
2598: 
2599:         IF MsgConfirma(loc_cMensagem, "Exclus" + CHR(227) + "o de cheque cancelado")
2600:             IF THIS.this_oBusinessObject.Excluir()
2601:                 SELECT (loc_cCursor)
2602:                 DELETE
2603:                 THIS.grd_4c_Dados.Refresh()
2604:             ENDIF
2605:         ENDIF
2606:     ENDPROC
2607: 
2608:     *==========================================================================
2609:     * BtnMarcarTudoClick / BtnDesmarcarTudoClick - cmdTudo1.Click /
2610:     * cmdApaga1.Click do legado (marca/desmarca em massa a coluna Imprime).
2611:     *==========================================================================
2612:     PROCEDURE BtnMarcarTudoClick()
2613:         LOCAL loc_cCursor, loc_nRecno
2614: 
2615:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2616: 
2617:         IF USED(loc_cCursor)
2618:             loc_nRecno = RECNO(loc_cCursor)
2619:             UPDATE (loc_cCursor) SET nmarca1s = 1 WHERE nmarca1s = 0 AND nemitidos = 0 AND ncancelas = 0
2620: 
2621:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2622:                 SELECT (loc_cCursor)
2623:                 GOTO loc_nRecno
2624:             ENDIF
2625: 
2626:             THIS.grd_4c_Dados.Refresh()
2627:         ENDIF
2628:     ENDPROC
2629: 
2630:     PROCEDURE BtnDesmarcarTudoClick()
2631:         LOCAL loc_cCursor, loc_nRecno
2632: 
2633:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2634: 
2635:         IF USED(loc_cCursor)
2636:             loc_nRecno = RECNO(loc_cCursor)
2637:             UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
2638: 
2639:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2640:                 SELECT (loc_cCursor)
2641:                 GOTO loc_nRecno
2642:             ENDIF
2643: 
2644:             THIS.grd_4c_Dados.Refresh()
2645:         ENDIF
2646:     ENDPROC
2647: 
2648:     *==========================================================================
2649:     * BtnImprimirClick - Imprimir (cmdImprimir.Click do legado): abre
2650:     * FormSigReEch (Emissao de Cheque, ja migrado) no modo CONSULTAR para o
2651:     * cheque selecionado na grade - mesmos parametros do "Do Form SigReEch
2652:     * With emps,dopes,numes,'CONSULTAR',ncheques" original.
2653:     *==========================================================================
2654:     PROCEDURE BtnImprimirClick()
2655:         LOCAL loc_cCursor, loc_oForm, loc_oErro
2656: 
2657:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2658: 
2659:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2660:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2661:             RETURN
2662:         ENDIF
2663: 
2664:         loc_oForm = .NULL.
2665:         SELECT (loc_cCursor)
2666: 
2667:         TRY
2668:             loc_oForm = CREATEOBJECT("FormSigReEch", emps, dopes, numes, "CONSULTAR", ncheques)
2669:         CATCH TO loc_oErro
2670:             MsgErro(loc_oErro.Message, "Erro ao abrir emiss" + CHR(227) + "o de cheque")
2671:             loc_oForm = .NULL.
2672:         ENDTRY
2673: 
2674:         IF VARTYPE(loc_oForm) = "O"
2675:             loc_oForm.Show()
2676:         ENDIF
2677:     ENDPROC
2678: 
2679:     *==========================================================================
2680:     * BtnDocumentoClick - Documento (cmdDocumento.Click do legado): confere
2681:     * se existe lancamento de pagamento para o EmpDopNums do cheque
2682:     * selecionado (mesmo guard do "CursorQuery('SigCdPgr',,'empdopnums',...)"
2683:     * original) e, se existir, abre o cadastro correspondente (Formpgr, ja
2684:     * migrado - SIGCDPGR.SCX). Sem lancamento, nao faz nada (mesmo
2685:     * comportamento do Else do legado).
2686:     *==========================================================================
2687:     PROCEDURE BtnDocumentoClick()
2688:         LOCAL loc_cCursor, loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro
2689: 
2690:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2691: 
2692:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2693:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2694:             RETURN
2695:         ENDIF
2696: 
2697:         SELECT (loc_cCursor)
2698:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
2699: 
2700:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
2701:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
2702: 
2703:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
2704:             loc_oForm = .NULL.
2705:             TRY
2706:                 loc_oForm = CREATEOBJECT("Formpgr")
2707:             CATCH TO loc_oErro
2708:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
2709:                 loc_oForm = .NULL.
2710:             ENDTRY
2711: 
2712:             IF VARTYPE(loc_oForm) = "O"
2713:                 loc_oForm.Show()
2714:             ENDIF
2715:         ENDIF
2716: 
2717:         IF USED("cursor_4c_VerificaPgr")
2718:             USE IN cursor_4c_VerificaPgr
2719:         ENDIF
2720:     ENDPROC
2721: 
2722:     *==========================================================================
2723:     * BtnProcurarClick - Procurar (cmdProcurar.Click do legado): ABRE o
2724:     * painel de busca de cheque por Banco/Agencia/Conta/Cheque/Emissao/Valor
2725:     * ou leitor de codigo de barras (cnt_4c_Procurar) - NAO eh toggle: o
2726:     * legado ("ThisForm.plInicio = .T. / ThisForm.CntProcurar.Init") sempre
2727:     * abre, e o fechamento vem so pelos botoes Procurar/Cancelar do painel
2728:     * (FecharPainelProcurar). Desabilita os demais controles da tela
2729:     * enquanto o painel esta aberto, como o legado faz.
2730:     *==========================================================================
2731:     PROCEDURE BtnProcurarClick()
2732:         IF !PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
2733:             RETURN
2734:         ENDIF
2735: 
2736:         THIS.LockScreen = .T.
2737: 
2738:         *-- Legado (cntProcurar.Init): desliga Conta/Descricao da conta/grade/
2739:         *-- Favorecido/CmdGOk e mostra o painel. O conjunto exato vive em
2740:         *-- AjustarBotoesPorModo/HabilitarCampos, que tambem eh o funil de
2741:         *-- VOLTA (FecharPainelProcurar) - CLAUDE.md regra #40.
2742:         THIS.AjustarBotoesPorModo("PROCURAR")
2743: 
2744:         IF PEMSTATUS(THIS.cnt_4c_Procurar, "txt_4c_Banco", 5)
2745:             THIS.cnt_4c_Procurar.txt_4c_Banco.SetFocus()
2746:         ENDIF
2747: 
2748:         THIS.Refresh()
2749: 
2750:         THIS.LockScreen = .F.
2751:     ENDPROC
2752: 
2753:     *==========================================================================
2754:     * FecharPainelProcurar - Reabilita os controles desabilitados por
2755:     * BtnProcurarClick, oculta o painel e recarrega a exibicao (mExibeCheques
2756:     * (.F.) do legado - mesmo corpo nos dois botoes cmdprocurar/cmdCancelar
2757:     * de cntProcurar.cmdgprocurar, so a busca em si difere).
2758:     *==========================================================================
2759:     PROTECTED PROCEDURE FecharPainelProcurar()
2760:         *-- FUNIL de volta: reabilita o que "PROCURAR" desligou e oculta o
2761:         *-- painel (CLAUDE.md regra #40).
2762:         THIS.AjustarBotoesPorModo("LISTA")
2763: 
2764:         THIS.ExibirCheques(.F.)
2765:     ENDPROC
2766: 
2767:     *==========================================================================
2768:     * CmdgprocurarClick - Dispatcher do CommandGroup obj_4c_Cmdgprocurar
2769:     * (cntProcurar.cmdgprocurar do legado: Botao1=Procurar, Botao2=Cancelar).
2770:     * PUBLIC - BINDEVENT so dispara metodos PUBLIC.
2771:     *==========================================================================
2772:     PROCEDURE CmdgprocurarClick()
2773:         DO CASE
2774:             CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 1
2775:                 THIS.ProcurarChequeNoPainel()
2776:             CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2
2777:                 THIS.BtnCancelarClick("PROCURAR")
2778:         ENDCASE
2779:     ENDPROC
2780: 
2781:     *==========================================================================
2782:     * ProcurarChequeNoPainel - cmdprocurar.Click do legado: posiciona o
2783:     * cursor de cheques pelo primeiro campo preenchido (Emissao > Valor >
2784:     * Banco > Agencia > Conta > Cheque - mesma ordem/DO CASE do legado),
2785:     * usando SET NEAR ON (posiciona no registro mais proximo, mesmo sem
2786:     * achar exato) e fecha o painel.
2787:     *==========================================================================
2788:     PROCEDURE ProcurarChequeNoPainel()
2789:         LOCAL loc_cCursor, loc_cBanco, loc_cAgencia, loc_cConta, loc_cCheque
2790:         LOCAL loc_dEmissao, loc_nValor
2791: 
2792:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2793: 
2794:         IF !USED(loc_cCursor)
2795:             THIS.FecharPainelProcurar()
2796:             RETURN
2797:         ENDIF
2798: 
2799:         WITH THIS.cnt_4c_Procurar
2800:             loc_cBanco = PADR(ALLTRIM(.txt_4c_Banco.Value), 3)
2801:             .txt_4c_Banco.Value = loc_cBanco
2802:             loc_cAgencia = .txt_4c_Agencia.Value
2803:             loc_cConta   = .txt_4c_Conta.Value
2804:             loc_cCheque  = .txt_4c_Cheque.Value
2805:             loc_dEmissao = ConverterParaData(.txt_4c_Emissao.Value)
2806:             loc_nValor   = .txt_4c_Valor.Value
2807:             .Visible     = .T.
2808:         ENDWITH
2809: 
2810:         SELECT (loc_cCursor)
2811:         SET NEAR ON
2812: 
2813:         DO CASE
2814:             CASE !EMPTY(loc_dEmissao)
2815:                 SET ORDER TO Emissao
2816:                 SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2817:             CASE loc_nValor != 0
2818:                 SET ORDER TO Valor
2819:                 SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2820:             CASE !EMPTY(loc_cBanco)
2821:                 SET ORDER TO Cheque
2822:                 SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2823:             CASE !EMPTY(loc_cAgencia)
2824:                 SET ORDER TO Agencia
2825:                 SEEK loc_cAgencia + loc_cConta + loc_cCheque
2826:             CASE !EMPTY(loc_cConta)
2827:                 SET ORDER TO Conta
2828:                 SEEK loc_cConta + loc_cCheque

*-- Linhas 2841 a 3492:
2841:     * (cntProcurar.getBanco.KeyPress do legado): tecla 60 inicia a captura,
2842:     * 58 finaliza e decodifica a string lida em Banco/Agencia/Conta/Cheque.
2843:     * this_lLeitorChequeAtivo/this_cChequeLido (SigPrChrBO) sao os mesmos
2844:     * plLeCheque/pcChqLido do legado. PUBLIC - BINDEVENT so dispara metodos
2845:     * PUBLIC.
2846:     *==========================================================================
2847:     PROCEDURE TxtProcurarBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2848:         IF par_nKeyCode = 60
2849:             IF !THIS.this_oBusinessObject.this_lLeitorChequeAtivo
2850:                 THIS.this_oBusinessObject.this_cChequeLido = ""
2851:             ENDIF
2852:             THIS.this_oBusinessObject.this_lLeitorChequeAtivo = .T.
2853:         ENDIF
2854: 
2855:         IF THIS.this_oBusinessObject.this_lLeitorChequeAtivo
2856:             THIS.this_oBusinessObject.this_cChequeLido = ;
2857:                 THIS.this_oBusinessObject.this_cChequeLido + CHR(par_nKeyCode)
2858:             NODEFAULT
2859:         ENDIF
2860: 
2861:         IF par_nKeyCode = 58
2862:             THIS.ValidarLeitorChequeProcurar()
2863:             THIS.this_oBusinessObject.this_lLeitorChequeAtivo = .F.
2864:         ENDIF
2865:     ENDPROC
2866: 
2867:     *==========================================================================
2868:     * ValidarLeitorChequeProcurar - getBanco.Valid do legado (ramo do
2869:     * leitor): com >= 33 chars lidos, decodifica Banco/Agencia/Conta/Cheque
2870:     * pelas mesmas posicoes SUBSTR do legado e ja aciona a busca
2871:     * (This.Parent.CmdGProcurar.CmdProcurar.Click).
2872:     *==========================================================================
2873:     PROTECTED PROCEDURE ValidarLeitorChequeProcurar()
2874:         LOCAL loc_cLeitor
2875: 
2876:         loc_cLeitor = THIS.this_oBusinessObject.this_cChequeLido
2877: 
2878:         IF LEN(loc_cLeitor) >= 33
2879:             WITH THIS.cnt_4c_Procurar
2880:                 .txt_4c_Banco.Value   = SUBSTR(loc_cLeitor, 2, 3)
2881:                 .txt_4c_Agencia.Value = SUBSTR(loc_cLeitor, 5, 4)
2882:                 .txt_4c_Conta.Value   = SUBSTR(loc_cLeitor, 23, 10)
2883:                 .txt_4c_Cheque.Value  = SUBSTR(loc_cLeitor, 14, 6)
2884:                 .Visible     = .T.
2885:             ENDWITH
2886: 
2887:             THIS.Refresh()
2888:             THIS.ProcurarChequeNoPainel()
2889:         ENDIF
2890:     ENDPROC
2891: 
2892:     *==========================================================================
2893:     * BtnExcluiDocClick - Exclui Docto. (cmdExcluiDoc.Click do legado): abre
2894:     * o painel de justificativa do cancelamento (cnt_4c_justificativa,
2895:     * mapeamento.json). O painel eh criado na fase de containers flutuantes
2896:     * (Fase 6/7) - ate la, o guard PEMSTATUS abaixo mantem o botao
2897:     * inofensivo.
2898:     *==========================================================================
2899:     PROCEDURE BtnExcluiDocClick()
2900:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
2901:             *-- Modo JUSTIFICATIVA: mostra o painel (o legado nao desabilita
2902:             *-- nada da tela de fundo neste painel) e registra o modo corrente,
2903:             *-- que eh o que BtnCancelarClick/AjustarBotoesPorModo consultam
2904:             *-- quando chamados sem parametro.
2905:             THIS.AjustarBotoesPorModo("JUSTIFICATIVA")
2906: 
2907:             WITH THIS.cnt_4c_justificativa
2908:                 .Visible = .T.
2909: 
2910:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
2911:                     .obj_4c_Get_justificativa.Value    = ""
2912:                     .obj_4c_Get_justificativa.Width    = 238
2913:                     .obj_4c_Get_justificativa.ReadOnly = .F.
2914:                     .obj_4c_Get_justificativa.SetFocus()
2915:                 ENDIF
2916: 
2917:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
2918:                     .obj_4c_CmdGconf.Enabled = .T.
2919:                     .obj_4c_CmdGconf.Visible = .T.
2920:                 ENDIF
2921:             ENDWITH
2922:         ENDIF
2923:     ENDPROC
2924: 
2925:     *==========================================================================
2926:     * CmdGconfClick - Dispatcher do CommandGroup obj_4c_CmdGconf
2927:     * (cntjustificativa.cmdGconf do legado: Botao1=cmConfirmar,
2928:     * Botao2=cmdCancelar). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
2929:     *==========================================================================
2930:     PROCEDURE CmdGconfClick()
2931:         DO CASE
2932:             CASE THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 1
2933:                 THIS.ConfirmarCancelamentoDocumento()
2934:             CASE THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 2
2935:                 THIS.BtnCancelarClick("JUSTIFICATIVA")
2936:         ENDCASE
2937:     ENDPROC
2938: 
2939:     *==========================================================================
2940:     * CancelarJustificativa - cmdCancelar.Click do cmdGconf legado: fecha o
2941:     * painel sem gravar nada ("This.Parent.Enabled=.F. + This.Parent.Parent.
2942:     * Visible=.F.").
2943:     *==========================================================================
2944:     PROTECTED PROCEDURE CancelarJustificativa()
2945:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
2946:             IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
2947:                 THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Enabled = .F.
2948:             ENDIF
2949:             THIS.cnt_4c_justificativa.Visible = .F.
2950:         ENDIF
2951: 
2952:         *-- Volta ao modo de consulta. NAO passa por AjustarBotoesPorModo
2953:         *-- ("LISTA") de proposito: aquele ramo reafirma o painel pelo cheque
2954:         *-- corrente (AtualizarPainelChequeCorrente) e faria a justificativa
2955:         *-- reaparecer em somente leitura no mesmo instante, enquanto o
2956:         *-- cmdCancelar legado apenas oculta o painel e deixa assim ate a
2957:         *-- proxima troca de linha na grade. Nenhum controle foi desabilitado
2958:         *-- neste modo, entao nao ha o que reabilitar.
2959:         THIS.this_cModoAtual = "LISTA"
2960:     ENDPROC
2961: 
2962:     *==========================================================================
2963:     * ConfirmarCancelamentoDocumento - cmConfirmar.Click do legado: exige
2964:     * justificativa preenchida, confere se ha lancamento de pagamento para o
2965:     * EmpDopNums do cheque corrente (mesmo guard "CursorQuery('SigCdPgr',,
2966:     * 'empdopnums',...)" original) e abre o cadastro correspondente
2967:     * (Formpgr, ja migrado - SIGCDPGR.SCX) para o usuario dar seguimento ao
2968:     * cancelamento do documento.
2969:     *
2970:     * O legado passa a justificativa e um flag de cancelamento como
2971:     * parametros extras do "Do Form SigCdPgr With ...,.T.,ThisForm,
2972:     * Alltrim(get_justificativa.Value)", delegando a persistencia da
2973:     * justificativa/cancelamento (SigCqChi.cancelas/justcanc) para dentro do
2974:     * proprio modulo SigCdPgr. O Formpgr migrado (tarefa/task separada, sem
2975:     * parametros de Init) nao expoe esse modo parametrizado - mesma
2976:     * simplificacao ja adotada em BtnDocumentoClick (abre o cadastro padrao
2977:     * quando ha lancamento, sem repassar os parametros de cancelamento).
2978:     *==========================================================================
2979:     PROCEDURE ConfirmarCancelamentoDocumento()
2980:         LOCAL loc_cCursor, loc_cJustificativa, loc_cEmpDopNums, loc_cSQL
2981:         LOCAL loc_nResultado, loc_oForm, loc_oErro
2982: 
2983:         IF !PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
2984:             RETURN
2985:         ENDIF
2986: 
2987:         loc_cJustificativa = ALLTRIM(THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value)
2988: 
2989:         IF EMPTY(loc_cJustificativa)
2990:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
2991:             THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.SetFocus()
2992:             RETURN
2993:         ENDIF
2994: 
2995:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2996: 
2997:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2998:             THIS.ExibirCheques(.T.)
2999:             RETURN
3000:         ENDIF
3001: 
3002:         SELECT (loc_cCursor)
3003:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
3004: 
3005:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
3006:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
3007: 
3008:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
3009:             loc_oForm = .NULL.
3010:             TRY
3011:                 loc_oForm = CREATEOBJECT("Formpgr")
3012:             CATCH TO loc_oErro
3013:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
3014:                 loc_oForm = .NULL.
3015:             ENDTRY
3016: 
3017:             IF VARTYPE(loc_oForm) = "O"
3018:                 loc_oForm.Show()
3019:             ENDIF
3020:         ENDIF
3021: 
3022:         IF USED("cursor_4c_VerificaPgr")
3023:             USE IN cursor_4c_VerificaPgr
3024:         ENDIF
3025: 
3026:         THIS.CancelarJustificativa()
3027:     ENDPROC
3028: 
3029:     *==========================================================================
3030:     * BtnReciboClick - Recibo (cmdRecibo.Click do legado): abre o form de
3031:     * emissao de recibo (SigRerec) para o cheque selecionado. FormSigRerec
3032:     * ainda nao foi migrado (SCX de outra task) - o TRY/CATCH reporta o
3033:     * problema real caso a classe nao exista, em vez de fingir sucesso.
3034:     *==========================================================================
3035:     PROCEDURE BtnReciboClick()
3036:         LOCAL loc_cCursor, loc_oForm, loc_oErro
3037: 
3038:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3039: 
3040:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
3041:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
3042:             RETURN
3043:         ENDIF
3044: 
3045:         loc_oForm = .NULL.
3046:         TRY
3047:             loc_oForm = CREATEOBJECT("FormSigRerec", THIS, "RECIBO")
3048:         CATCH TO loc_oErro
3049:             MsgErro("M" + CHR(243) + "dulo de recibo ainda n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + loc_oErro.Message, "Recibo")
3050:             loc_oForm = .NULL.
3051:         ENDTRY
3052: 
3053:         IF VARTYPE(loc_oForm) = "O"
3054:             loc_oForm.Show()
3055:         ENDIF
3056:     ENDPROC
3057: 
3058:     *==========================================================================
3059:     * BtnImpChqClick - Cheque (cmdImpchq.Click do legado): impressao do
3060:     * cheque em formulario continuo. O posicionamento fisico na folha do
3061:     * cheque (rotina de ~180 linhas do legado, com fValorExtenso() e
3062:     * fwBuscaInt() para escolher impressora - nenhuma das duas portada) fica
3063:     * para uma fase dedicada de impressao de cheques. Aqui: guard identico
3064:     * ao legado ("Nenhum Cheque Selecionado") e, apos o usuario confirmar
3065:     * que a impressao fisica foi feita, marca os cheques selecionados como
3066:     * emitidos (efeito de dados do botao, via BO).
3067:     *==========================================================================
3068:     PROCEDURE BtnImpChqClick()
3069:         LOCAL loc_cCursor, loc_nQtdMarcados
3070: 
3071:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3072: 
3073:         IF !USED(loc_cCursor)
3074:             RETURN
3075:         ENDIF
3076: 
3077:         SELECT (loc_cCursor)
3078:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3079: 
3080:         IF loc_nQtdMarcados = 0
3081:             MsgAviso("Nenhum Cheque Selecionado !!!", "Aten" + CHR(231) + CHR(227) + "o")
3082:             RETURN
3083:         ENDIF
3084: 
3085:         IF MsgConfirma("Confirma que " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s) selecionado(s) " + ;
3086:                 "j" + CHR(225) + " foram impressos na impressora de cheques?", "Impress" + CHR(227) + "o de Cheque")
3087:             IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
3088:                 THIS.grd_4c_Dados.Refresh()
3089:             ENDIF
3090:         ENDIF
3091:     ENDPROC
3092: 
3093:     *==========================================================================
3094:     * BtnChMatClick - Chq. Matric. (cmdchmat.Click do legado): impressao
3095:     * matricial via SigIpChq.prg (utilitario legado nao portado, faz o
3096:     * alinhamento interativo na impressora). Guard identico ao legado (todos
3097:     * os cheques marcados tem de ser do mesmo banco) e, apos confirmacao,
3098:     * marca como emitidos (mesmo criterio de BtnImpChqClick).
3099:     *==========================================================================
3100:     PROCEDURE BtnChMatClick()
3101:         LOCAL loc_cCursor, loc_nQtdMarcados, loc_cPrimeiroBanco, loc_lMesmoBanco
3102: 
3103:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3104: 
3105:         IF !USED(loc_cCursor)
3106:             RETURN
3107:         ENDIF
3108: 
3109:         SELECT (loc_cCursor)
3110:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3111: 
3112:         *-- Legado: sem cheque marcado (TmpChi vazio), o botao abre o painel
3113:         *-- de impressao manual (banco + faixa de cheques digitados), em vez
3114:         *-- de operar sobre a selecao da grade.
3115:         IF loc_nQtdMarcados = 0
3116:             THIS.AbrirImpressaoManualCheque()
3117:             RETURN
3118:         ENDIF
3119: 
3120:         loc_lMesmoBanco    = .T.
3121:         loc_cPrimeiroBanco = ""
3122: 
3123:         SELECT (loc_cCursor)
3124:         SCAN FOR nmarca1s = 1
3125:             IF EMPTY(loc_cPrimeiroBanco)
3126:                 loc_cPrimeiroBanco = bancos
3127:             ELSE
3128:                 IF bancos != loc_cPrimeiroBanco
3129:                     loc_lMesmoBanco = .F.
3130:                     EXIT
3131:                 ENDIF
3132:             ENDIF
3133:         ENDSCAN
3134: 
3135:         IF !loc_lMesmoBanco
3136:             MsgAviso("Todos os cheques selecionados devem ser do mesmo banco", "Aten" + CHR(231) + CHR(227) + "o")
3137:             RETURN
3138:         ENDIF
3139: 
3140:         IF MsgConfirma("Verifique se a impressora matricial est" + CHR(225) + " pronta." + CHR(13) + ;
3141:                 "Confirma a impress" + CHR(227) + "o de " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s)?", ;
3142:                 "Impress" + CHR(227) + "o Matricial")
3143:             IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
3144:                 THIS.grd_4c_Dados.Refresh()
3145:             ENDIF
3146:         ENDIF
3147:     ENDPROC
3148: 
3149:     *==========================================================================
3150:     * AbrirImpressaoManualCheque - impchmat.Init do legado (guardado por
3151:     * ThisForm.ChMatIni no original; aqui chamado direto pelo ramo "sem
3152:     * cheque marcado" de BtnChMatClick): limpa os campos, desabilita o
3153:     * CommandGroup principal e mostra o painel de impressao manual por
3154:     * Banco + faixa de cheques.
3155:     *==========================================================================
3156:     PROTECTED PROCEDURE AbrirImpressaoManualCheque()
3157:         IF !PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
3158:             RETURN
3159:         ENDIF
3160: 
3161:         THIS.LockScreen = .T.
3162: 
3163:         WITH THIS.cnt_4c_Impchmat
3164:             IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Banco", 5)
3165:                 .txt_4c_Banco.Value = ""
3166:             ENDIF
3167:             IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Chini", 5)
3168:                 .txt_4c_Chini.Value = ""
3169:             ENDIF
3170:             IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Chfin", 5)
3171:                 .txt_4c_Chfin.Value = ""
3172:             ENDIF
3173:             .Visible     = .T.
3174:         ENDWITH
3175: 
3176:         *-- Legado (impchmat.Init): desliga SO o CmdGOk e mostra o painel -
3177:         *-- Grupo/Conta/periodo/grade continuam acessiveis. O conjunto vive em
3178:         *-- AjustarBotoesPorModo, que tambem eh o funil de VOLTA
3179:         *-- (FecharImpressaoManualCheque) - CLAUDE.md regra #40.
3180:         THIS.AjustarBotoesPorModo("IMPCHMAT")
3181: 
3182:         IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Banco", 5)
3183:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
3184:         ENDIF
3185: 
3186:         THIS.Refresh()
3187: 
3188:         THIS.LockScreen = .F.
3189:     ENDPROC
3190: 
3191:     *==========================================================================
3192:     * FecharImpressaoManualCheque - cmdCancelar.Click de impchmat.cmdGprocurar
3193:     * do legado: reabilita o CommandGroup principal, oculta o painel e
3194:     * recarrega a exibicao (mExibeCheques(.F.)).
3195:     *==========================================================================
3196:     PROTECTED PROCEDURE FecharImpressaoManualCheque()
3197:         *-- FUNIL de volta: reabilita o CmdGOk que "IMPCHMAT" desligou e oculta
3198:         *-- o painel (CLAUDE.md regra #40).
3199:         THIS.AjustarBotoesPorModo("LISTA")
3200: 
3201:         THIS.ExibirCheques(.F.)
3202:     ENDPROC
3203: 
3204:     *==========================================================================
3205:     * CmdGprocurarImpChmatClick - Dispatcher do CommandGroup
3206:     * obj_4c_CmdGprocurar (impchmat.cmdGprocurar do legado: Botao1=cmdimpri,
3207:     * Botao2=cmdCancelar). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
3208:     *==========================================================================
3209:     PROCEDURE CmdGprocurarImpChmatClick()
3210:         DO CASE
3211:             CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 1
3212:                 THIS.ImprimirChequeManualClick()
3213:             CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2
3214:                 THIS.BtnCancelarClick("IMPCHMAT")
3215:         ENDCASE
3216:     ENDPROC
3217: 
3218:     *==========================================================================
3219:     * ImprimirChequeManualClick - cmdimpri.Click do impchmat.cmdGprocurar
3220:     * legado: valida Banco/faixa, filtra o cursor JA CARREGADO da grade
3221:     * (mesma fonte que o legado usa - "Select ... From CsSigCqChi Where
3222:     * bancos = ... And ncheques Between ... And ncancelas = 0", NAO uma nova
3223:     * consulta ao SQL Server) e, confirmando, marca como emitidos.
3224:     *
3225:     * A rotina de posicionamento fisico na folha do cheque (SigIpChq.prg,
3226:     * ~180 linhas com fValorExtenso/fwBuscaInt, nenhuma delas portada) fica
3227:     * para uma fase dedicada de impressao de cheques - mesma ressalva ja
3228:     * documentada em BtnImpChqClick/BtnChMatClick.
3229:     *==========================================================================
3230:     PROCEDURE ImprimirChequeManualClick()
3231:         LOCAL loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin, loc_nQtd, loc_lTemEmitido
3232: 
3233:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3234: 
3235:         WITH THIS.cnt_4c_Impchmat
3236:             loc_cBanco = .txt_4c_Banco.Value
3237:             loc_cChIni = .txt_4c_Chini.Value
3238:             loc_cChFin = .txt_4c_Chfin.Value
3239:             .Visible     = .T.
3240:         ENDWITH
3241: 
3242:         IF EMPTY(loc_cBanco)
3243:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
3244:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
3245:             RETURN
3246:         ENDIF
3247: 
3248:         IF EMPTY(loc_cChIni)
3249:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
3250:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
3251:             RETURN
3252:         ENDIF
3253: 
3254:         IF EMPTY(loc_cChFin)
3255:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
3256:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
3257:             RETURN
3258:         ENDIF
3259: 
3260:         IF loc_cChFin < loc_cChIni
3261:             MsgAviso("N" + CHR(250) + "mero do cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
3262:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
3263:             RETURN
3264:         ENDIF
3265: 
3266:         IF !USED(loc_cCursor)
3267:             RETURN
3268:         ENDIF
3269: 
3270:         SELECT (loc_cCursor)
3271:         COUNT TO loc_nQtd FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0
3272: 
3273:         IF loc_nQtd = 0
3274:             RETURN
3275:         ENDIF
3276: 
3277:         SELECT (loc_cCursor)
3278:         LOCATE FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0 AND nemitidos = 1
3279:         loc_lTemEmitido = FOUND()
3280: 
3281:         IF loc_lTemEmitido
3282:             IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. Confirma impress" + CHR(227) + "o ?", "Aten" + CHR(231) + CHR(227) + "o")
3283:                 RETURN
3284:             ENDIF
3285:         ENDIF
3286: 
3287:         MsgAviso("Verifique se a impressora est" + CHR(225) + " pronta p/ impress" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
3288: 
3289:         IF THIS.this_oBusinessObject.MarcarChequesComoEmitidosPorFaixa(loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin)
3290:             THIS.grd_4c_Dados.Refresh()
3291:             THIS.FecharImpressaoManualCheque()
3292:         ENDIF
3293:     ENDPROC
3294: 
3295:     *==========================================================================
3296:     * TxtChiniKeyPress / TxtChfinKeyPress - Valid de getChini/getChfin do
3297:     * impchmat legado: preenche com zeros a esquerda ate 6 digitos
3298:     * (PadL(Alltrim(Value),6,'0')). PUBLIC - BINDEVENT so dispara metodos
3299:     * PUBLIC.
3300:     *==========================================================================
3301:     PROCEDURE TxtChiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3302:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3303:             RETURN
3304:         ENDIF
3305:         THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
3306:     ENDPROC
3307: 
3308:     PROCEDURE TxtChfinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3309:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3310:             RETURN
3311:         ENDIF
3312:         THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
3313:     ENDPROC
3314: 
3315:     *==========================================================================
3316:     * ---------------------------------------------------------------------
3317:     * FASE 8 - Eventos auxiliares e consolidacao final
3318:     * ---------------------------------------------------------------------
3319:     * Este form eh OPERACIONAL FLAT (consulta/cancelamento de cheques): o
3320:     * SIGPRCHR legado NAO tem Page1=Lista/Page2=Dados, NAO tem os 5 botoes
3321:     * CRUD (Incluir/Alterar/Visualizar/Excluir/Buscar) e NAO tem botao de
3322:     * gravar - o dump nao declara btnSalvar/btnGravar/mGravaDados em lugar
3323:     * nenhum. Por isso NAO existem aqui BtnSalvarClick/BtnBuscarClick nem
3324:     * BtnEncerrarClick: inventar esses botoes violaria o PILAR 1 e a regra
3325:     * "NUNCA inventar", e criar metodos vazios com esses nomes seria o stub
3326:     * disfarcado proibido pela regra de completude. Os equivalentes reais,
3327:     * com os nomes dos objetos do legado, ja existem:
3328:     *
3329:     *   legado               migrado                      papel
3330:     *   -------------------  ---------------------------  -------------------
3331:     *   Command2             BtnProcessarClick()          acao principal
3332:     *   cmdGok.cmdSair       BtnSairClick()               Encerrar (Cancel)
3333:     *   cmdGok.cmdProcurar   BtnProcurarClick()           localizar cheque
3334:     *   cmdGconf.Botao2      BtnCancelarClick("JUSTIFICATIVA")
3335:     *   cmdgprocurar.Botao2  BtnCancelarClick("PROCURAR")
3336:     *   cmdGprocurar.Botao2  BtnCancelarClick("IMPCHMAT")
3337:     *
3338:     * Os hooks herdados de FormBase (FormParaBO/BOParaForm/LimparCampos)
3339:     * continuam PROTECTED - subclasse NAO alarga escopo de metodo herdado.
3340:     * CarregarLista/HabilitarCampos/AjustarBotoesPorModo/BtnCancelarClick
3341:     * ficam PUBLIC: o harness de teste automatizado os chama de FORA da
3342:     * classe (PEMSTATUS devolve .T. mesmo para PROTECTED e a chamada real
3343:     * falharia em runtime com "Property X is not found").
3344:     *==========================================================================
3345: 
3346:     *==========================================================================
3347:     * CarregarLista - FUNIL unico de carga da grade de cheques. Sincroniza os
3348:     * filtros da tela para o BO (FormParaBO - fonte unica da consulta),
3349:     * garante que o cursor da grade exista e delega para MontaGrade(), que eh
3350:     * a transcricao do "PROCEDURE montachq" legado (consulta o periodo,
3351:     * repovoa o cursor com ZAP + APPEND, recria os indices e entrega para
3352:     * ExibirCheques()).
3353:     *
3354:     * A mensagem de falha NAO eh repetida aqui: MontaGrade ja exibe a dela
3355:     * ("Favor Reinicializar o Processo!!!" do legado) - CLAUDE.md regra #20.
3356:     *
3357:     * PUBLIC - chamado por BtnProcessarClick e pelo harness de teste.
3358:     *==========================================================================
3359:     PROCEDURE CarregarLista(par_lPosiciona)
3360:         LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor
3361:         loc_lSucesso   = .F.
3362:         loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
3363: 
3364:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3365:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
3366:                 "o inicializado.", "FormSigPrChr.CarregarLista")
3367:         ELSE
3368:             *-- Filtros da tela -> BO ANTES da consulta: CarregarCheques le
3369:             *-- this_dDataInicial/this_dDataFinal/this_cCodGrupo/this_cCodConta.
3370:             THIS.FormParaBO()
3371: 
3372:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3373: 
3374:             IF !USED(loc_cCursor)
3375:                 THIS.CriarCursorCheques()
3376:             ENDIF
3377: 
3378:             loc_lSucesso = THIS.MontaGrade(loc_lPosiciona)
3379:         ENDIF
3380: 
3381:         RETURN loc_lSucesso
3382:     ENDPROC
3383: 
3384:     *==========================================================================
3385:     * FormParaBO - Tela -> Business Object. Hook PROTECTED de FormBase (usado
3386:     * por CarregarLista e por FormBase.Salvar).
3387:     *
3388:     * Filtros lidos pelos getters Obter* (fonte unica, com o guard PEMSTATUS e
3389:     * a normalizacao de DATE/DATETIME via ConverterParaData - CLAUDE.md regra
3390:     * #16). Os campos de descricao (GetDsGrupos/getDsContas), o Favorecido
3391:     * (TxtFavorecido, somente leitura) e a justificativa de cancelamento
3392:     * (cntjustificativa.get_justificativa) sao copiados direto.
3393:     *
3394:     * As properties Ant* (AntDtIni/AntDtFin/AntCdGrupo/AntCdConta do legado)
3395:     * NAO sao tocadas aqui de proposito: elas guardam o valor de ENTRADA no
3396:     * campo (When legado = handlers GotFocus) e sao o que BtnProcessarClick
3397:     * compara para decidir se a grade precisa ser recarregada. Sobrescreve-las
3398:     * aqui faria a comparacao nunca acusar mudanca e a grade nunca recarregar.
3399:     *==========================================================================
3400:     PROTECTED PROCEDURE FormParaBO()
3401:         LOCAL loc_oBO, loc_lSucesso
3402:         loc_lSucesso = .F.
3403: 
3404:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3405:             loc_oBO = THIS.this_oBusinessObject
3406: 
3407:             loc_oBO.this_dDataInicial = THIS.ObterFiltroDataInicial()
3408:             loc_oBO.this_dDataFinal   = THIS.ObterFiltroDataFinal()
3409:             loc_oBO.this_cCodGrupo    = THIS.ObterFiltroGrupo()
3410:             loc_oBO.this_cCodConta    = THIS.ObterFiltroConta()
3411: 
3412:             IF PEMSTATUS(THIS, "txt_4c_DsGrupos", 5)
3413:                 loc_oBO.this_cDescGrupo = THIS.txt_4c_DsGrupos.Value
3414:             ENDIF
3415: 
3416:             IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
3417:                 loc_oBO.this_cDescConta = THIS.txt_4c_DsContas.Value
3418:             ENDIF
3419: 
3420:             IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
3421:                 loc_oBO.this_cFavorecido = THIS.txt_4c_TxtFavorecido.Value
3422:             ENDIF
3423: 
3424:             IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
3425:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
3426:                     loc_oBO.this_cJustCanc = ;
3427:                         THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value
3428:                 ENDIF
3429:             ENDIF
3430: 
3431:             loc_lSucesso = .T.
3432:         ENDIF
3433: 
3434:         RETURN loc_lSucesso
3435:     ENDPROC
3436: 
3437:     *==========================================================================
3438:     * BOParaForm - Business Object -> Tela. Hook PROTECTED de FormBase (usado
3439:     * por InicializarForm para semear o periodo e por FormBase.Cancelar).
3440:     *
3441:     * O legado faz esse mesmo trabalho no Init ("ThisForm.Dt_Inicial.Value =
3442:     * Date()", "ThisForm.Dt_Final.Value = Date()", getCdGrupos/getDsGrupos/
3443:     * getCdContas/getDsContas = Space(...)): aqui os valores vem das
3444:     * properties do BO (this_dDataInicial/this_dDataFinal recebem DATE() no
3445:     * SigPrChrBO.Init), mantendo o BO como fonte unica do estado dos filtros.
3446:     *
3447:     * O Favorecido eh espelho do cheque corrente e NAO eh escrito aqui: quem
3448:     * o atualiza a cada linha da grade eh AtualizarPainelChequeCorrente()
3449:     * (transcricao do AfterRowColChange/Scrolled legado). Escreve-lo tambem
3450:     * aqui criaria duas fontes para o mesmo campo.
3451:     *==========================================================================
3452:     PROTECTED PROCEDURE BOParaForm()
3453:         LOCAL loc_oBO, loc_lSucesso
3454:         loc_lSucesso = .F.
3455: 
3456:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3457:             loc_oBO = THIS.this_oBusinessObject
3458: 
3459:             IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
3460:                 THIS.txt_4c_Dt_inicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
3461:             ENDIF
3462: 
3463:             IF PEMSTATUS(THIS, "txt_4c_Dt_final", 5)
3464:                 THIS.txt_4c_Dt_final.Value = ConverterParaData(loc_oBO.this_dDataFinal)
3465:             ENDIF
3466: 
3467:             IF PEMSTATUS(THIS, "txt_4c_CdGrupos", 5)
3468:                 THIS.txt_4c_CdGrupos.Value = loc_oBO.this_cCodGrupo
3469:             ENDIF
3470: 
3471:             IF PEMSTATUS(THIS, "txt_4c_DsGrupos", 5)
3472:                 THIS.txt_4c_DsGrupos.Value = loc_oBO.this_cDescGrupo
3473:             ENDIF
3474: 
3475:             IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
3476:                 THIS.txt_4c_CdContas.Value = loc_oBO.this_cCodConta
3477:             ENDIF
3478: 
3479:             IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
3480:                 THIS.txt_4c_DsContas.Value = loc_oBO.this_cDescConta
3481:             ENDIF
3482: 
3483:             loc_lSucesso = .T.
3484:         ENDIF
3485: 
3486:         RETURN loc_lSucesso
3487:     ENDPROC
3488: 
3489:     *==========================================================================
3490:     * LimparCampos - Hook PROTECTED de FormBase (chamado por FormBase.Novo() e
3491:     * por FormBase.Excluir() apos exclusao bem-sucedida). Devolve a tela ao
3492:     * estado do Init legado: Grupo e Conta vazios, periodo = hoje, painel de

*-- Linhas 3498 a 3541:
3498:     * LimparChequesSeFiltroMudou(), que ja desliga SAFETY (com SAFETY ON o ZAP
3499:     * abre dialogo modal e CONGELA a tela).
3500:     *==========================================================================
3501:     PROTECTED PROCEDURE LimparCampos()
3502:         LOCAL loc_oBO
3503: 
3504:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3505:             loc_oBO = THIS.this_oBusinessObject
3506: 
3507:             loc_oBO.this_cCodGrupo    = ""
3508:             loc_oBO.this_cDescGrupo   = ""
3509:             loc_oBO.this_cCodConta    = ""
3510:             loc_oBO.this_cDescConta   = ""
3511:             loc_oBO.this_dDataInicial = DATE()
3512:             loc_oBO.this_dDataFinal   = DATE()
3513:             loc_oBO.this_cFavorecido  = ""
3514:             loc_oBO.this_cJustCanc    = ""
3515: 
3516:             *-- Proxima carga volta a ser "primeira exibicao" (Inicial do
3517:             *-- legado): MontaGrade deve ir para o Top do cursor em vez de
3518:             *-- reposicionar no ultimo cheque selecionado.
3519:             loc_oBO.this_lPrimeiraExibicao = .T.
3520: 
3521:             THIS.BOParaForm()
3522:         ENDIF
3523: 
3524:         IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
3525:             THIS.txt_4c_TxtFavorecido.Value = ""
3526:         ENDIF
3527: 
3528:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
3529:             IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
3530:                 THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value = ""
3531:             ENDIF
3532:         ENDIF
3533: 
3534:         IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
3535:             WITH THIS.cnt_4c_Procurar
3536:                 .txt_4c_Banco.Value   = ""
3537:                 .txt_4c_Agencia.Value = ""
3538:                 .txt_4c_Conta.Value   = ""
3539:                 .txt_4c_Cheque.Value  = ""
3540:                 .txt_4c_Emissao.Value = {}
3541:                 .txt_4c_Valor.Value   = 0

*-- Linhas 3569 a 3612:
3569:     *
3570:     * PUBLIC - usado por AjustarBotoesPorModo e pelo harness de teste.
3571:     *==========================================================================
3572:     PROCEDURE HabilitarCampos(par_lHabilitar)
3573:         LOCAL loc_lHabilitar
3574: 
3575:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
3576: 
3577:         IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
3578:             THIS.txt_4c_CdContas.Enabled = loc_lHabilitar
3579:         ENDIF
3580: 
3581:         IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
3582:             THIS.txt_4c_DsContas.Enabled = loc_lHabilitar
3583:         ENDIF
3584: 
3585:         IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
3586:             THIS.txt_4c_TxtFavorecido.Enabled = loc_lHabilitar
3587:         ENDIF
3588: 
3589:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3590:             THIS.grd_4c_Dados.Enabled = loc_lHabilitar
3591:         ENDIF
3592: 
3593:         IF PEMSTATUS(THIS, "obj_4c_CmdGok", 5)
3594:             THIS.obj_4c_CmdGok.Enabled = loc_lHabilitar
3595:         ENDIF
3596:     ENDPROC
3597: 
3598:     *==========================================================================
3599:     * AjustarBotoesPorModo - FUNIL de ida E de volta do estado dos controles
3600:     * conforme o painel flutuante aberto. Quem DESABILITA tem de REABILITAR no
3601:     * mesmo funil, senao a tela volta da busca com os botoes cinza e fica
3602:     * inutilizavel ate ser reaberta (CLAUDE.md regra #40).
3603:     *
3604:     * Modos deste form (nao ha INCLUIR/ALTERAR/VISUALIZAR - o legado nao tem
3605:     * CRUD nenhum):
3606:     *   "LISTA"         consulta livre - nenhum painel aberto
3607:     *   "PROCURAR"      cntProcurar.Init: desliga Conta/Favorecido/grade/CmdGok
3608:     *   "IMPCHMAT"      impchmat.Init: desliga SO o CmdGok - o legado nao toca
3609:     *                   nos demais controles neste painel, por isso este ramo
3610:     *                   NAO chama HabilitarCampos
3611:     *   "JUSTIFICATIVA" cntjustificativa visivel; o legado tambem nao
3612:     *                   desabilita nada da tela de fundo neste painel

*-- Linhas 3619 a 3662:
3619:     *
3620:     * PUBLIC - usado pelos abre/fecha dos paineis e pelo harness de teste.
3621:     *==========================================================================
3622:     PROCEDURE AjustarBotoesPorModo(par_cModo)
3623:         LOCAL loc_cModo
3624: 
3625:         loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C" AND ;
3626:             !EMPTY(par_cModo), par_cModo, THIS.this_cModoAtual)))
3627: 
3628:         IF !INLIST(loc_cModo, "LISTA", "PROCURAR", "IMPCHMAT", "JUSTIFICATIVA")
3629:             loc_cModo = "LISTA"
3630:         ENDIF
3631: 
3632:         THIS.this_cModoAtual = loc_cModo
3633: 
3634:         DO CASE
3635:             CASE loc_cModo == "PROCURAR"
3636:                 THIS.HabilitarCampos(.F.)
3637: 
3638:                 IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
3639:                     THIS.cnt_4c_Procurar.Enabled = .T.
3640:                     THIS.cnt_4c_Procurar.Visible = .T.
3641:                 ENDIF
3642: 
3643:             CASE loc_cModo == "IMPCHMAT"
3644:                 IF PEMSTATUS(THIS, "obj_4c_CmdGok", 5)
3645:                     THIS.obj_4c_CmdGok.Enabled = .F.
3646:                 ENDIF
3647: 
3648:                 IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
3649:                     THIS.cnt_4c_Impchmat.Enabled = .T.
3650:                     THIS.cnt_4c_Impchmat.Visible = .T.
3651:                 ENDIF
3652: 
3653:             CASE loc_cModo == "JUSTIFICATIVA"
3654:                 IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
3655:                     THIS.cnt_4c_justificativa.Visible = .T.
3656:                 ENDIF
3657: 
3658:             OTHERWISE
3659:                 *-- "LISTA": volta da busca/impressao - reabilita tudo o que os
3660:                 *-- modos acima desligaram e fecha os paineis flutuantes.
3661:                 THIS.HabilitarCampos(.T.)
3662: 

*-- Linhas 3697 a 3805:
3697:     *
3698:     * PUBLIC - dispatchers e harness de teste chamam de fora da classe.
3699:     *==========================================================================
3700:     PROCEDURE BtnCancelarClick(par_cPainel)
3701:         LOCAL loc_cPainel, loc_lFechou
3702:         loc_lFechou = .F.
3703: 
3704:         loc_cPainel = UPPER(ALLTRIM(IIF(VARTYPE(par_cPainel) = "C", par_cPainel, "")))
3705: 
3706:         IF EMPTY(loc_cPainel)
3707:             DO CASE
3708:                 CASE PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3709:                     loc_cPainel = "PROCURAR"
3710:                 CASE PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3711:                     loc_cPainel = "IMPCHMAT"
3712:                 CASE PEMSTATUS(THIS, "cnt_4c_justificativa", 5) AND THIS.cnt_4c_justificativa.Visible
3713:                     loc_cPainel = "JUSTIFICATIVA"
3714:             ENDCASE
3715:         ENDIF
3716: 
3717:         DO CASE
3718:             CASE loc_cPainel == "PROCURAR"
3719:                 THIS.FecharPainelProcurar()
3720:                 loc_lFechou = .T.
3721:             CASE loc_cPainel == "IMPCHMAT"
3722:                 THIS.FecharImpressaoManualCheque()
3723:                 loc_lFechou = .T.
3724:             CASE loc_cPainel == "JUSTIFICATIVA"
3725:                 THIS.CancelarJustificativa()
3726:                 loc_lFechou = .T.
3727:         ENDCASE
3728: 
3729:         RETURN loc_lFechou
3730:     ENDPROC
3731: 
3732:     *==========================================================================
3733:     * TornarControlesVisiveis - Torna visiveis os controles criados via
3734:     * AddObject (nascem Visible=.F.). Percorre containers e PageFrames
3735:     * recursivamente.
3736:     *
3737:     * Containers FLUTUANTES do legado (cntjustificativa/impchmat/cntProcurar -
3738:     * Visible=.F. no SCX, alternados por botao) DEVEM permanecer ocultos: o
3739:     * nome entra no INLIST abaixo e o metodo faz LOOP sem tocar o .Visible do
3740:     * proprio container - mas ainda RECURSA nos filhos dele antes do LOOP,
3741:     * senao os filhos ficam Visible=.F. para sempre e o container aparece
3742:     * vazio quando outro metodo setar .Visible = .T. nele (ver CLAUDE.md
3743:     * regra de forms operacionais / licao "tcv_skip_recursao"). Estes
3744:     * containers ainda nao existem na Fase 3 - a lista fica pronta para
3745:     * quando as Fases 6/7 os criarem.
3746:     *==========================================================================
3747:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3748:         LOCAL loc_nI, loc_oControl
3749: 
3750:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3751:             loc_oControl = par_oContainer.Controls(loc_nI)
3752: 
3753:             IF VARTYPE(loc_oControl) = "O"
3754:                 IF INLIST(UPPER(loc_oControl.Name), ;
3755:                           "CNT_4C_JUSTIFICATIVA", ;
3756:                           "CNT_4C_IMPCHMAT", ;
3757:                           "CNT_4C_PROCURAR")
3758:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
3759:                         THIS.TornarControlesVisiveis(loc_oControl)
3760:                     ENDIF
3761:                     LOOP
3762:                 ENDIF
3763: 
3764:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
3765:                     loc_oControl.Visible = .T.
3766:                 ENDIF
3767: 
3768:                 *-- PageFrame: percorrer Pages tambem (nenhum neste form, mas
3769:                 *-- mantido pelo padrao canonico do projeto)
3770:                 IF PEMSTATUS(loc_oControl, "PageCount", 5)
3771:                     LOCAL loc_nP
3772:                     FOR loc_nP = 1 TO loc_oControl.PageCount
3773:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
3774:                     ENDFOR
3775:                 ENDIF
3776: 
3777:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
3778:                     THIS.TornarControlesVisiveis(loc_oControl)
3779:                 ENDIF
3780:             ENDIF
3781:         ENDFOR
3782:     ENDPROC
3783: 
3784:     *==========================================================================
3785:     * Destroy - Libera cursores de trabalho do BO (nomes definidos em
3786:     * SigPrChrBO.this_cCursorCheques/Contas/Impressoras). Ainda vazios na
3787:     * Fase 3 (populados a partir da Fase 4), os IF USED() sao defensivos e
3788:     * idempotentes. DODEFAULT() por ULTIMO restaura o menu principal
3789:     * (FormBase.Destroy).
3790:     *==========================================================================
3791:     PROCEDURE Destroy()
3792:         IF USED("cursor_4c_Cheques")
3793:             USE IN cursor_4c_Cheques
3794:         ENDIF
3795:         IF USED("cursor_4c_Contas")
3796:             USE IN cursor_4c_Contas
3797:         ENDIF
3798:         IF USED("cursor_4c_Impressoras")
3799:             USE IN cursor_4c_Impressoras
3800:         ENDIF
3801: 
3802:         DODEFAULT()
3803:     ENDPROC
3804: 
3805: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrChrBO.prg):
*============================================================================
* SigPrChrBO.prg - Business Object para Consulta/Cancelamento de Cheques
*
* Origem legado: SIGPRCHR.SCX
* Form OPERACIONAL (nao segue padrao CRUD Page1=Lista/Page2=Dados): tela de
* consulta de cheques emitidos por conta/periodo, com filtro por Grupo e
* Conta, impressao de cheque/documento/recibo, cancelamento de documento e
* exclusao fisica de cheque cancelado (Delete From SigCqChi Where cidchaves
* = ...). Tabela principal manipulada: SigCqChi (comportamento.json).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrChrBO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - espelha Dt_Inicial/Dt_Final do legado. AntData* eh
    * o valor anterior do filtro (AntDtIni/AntDtFin), usado para saber se a
    * lista de cheques precisa ser recarregada quando o campo muda de valor.
    *==========================================================================
    this_dDataInicial    = {}    && Data inicial do periodo de busca (Dt_Inicial)
    this_dDataFinal      = {}    && Data final do periodo de busca (Dt_Final)
    this_dAntDataInicial = {}    && Valor anterior de this_dDataInicial (AntDtIni)
    this_dAntDataFinal   = {}    && Valor anterior de this_dDataFinal (AntDtFin)

    *==========================================================================
    * Filtro de Grupo de Contas - espelha GetCdGrupos/GetDsGrupos. Ant* guarda
    * o valor anterior para decidir se o cursor de cheques precisa ser
    * recarregado (Zap In CsSigCqChi quando o valor muda).
    *==========================================================================
    this_cCodGrupo     = ""      && Codigo do grupo de contas (GetCdGrupos)
    this_cDescGrupo    = ""      && Descricao do grupo de contas (GetDsGrupos)
    this_cAntCodGrupo  = ""      && Valor anterior de this_cCodGrupo (AntCdGrupo)
    this_cAntDescGrupo = ""      && Valor anterior de this_cDescGrupo (AntDsGrupo)

    *==========================================================================
    * Filtro de Conta - espelha getCdContas/getDsContas. Ant* guarda o valor
    * anterior para a mesma finalidade do bloco de Grupo.
    *==========================================================================
    this_cCodConta     = ""      && Codigo da conta (getCdContas)
    this_cDescConta    = ""      && Descricao/razao social da conta (getDsContas)
    this_cAntCodConta  = ""      && Valor anterior de this_cCodConta (AntCdConta)
    this_cAntDescConta = ""      && Valor anterior de this_cDescConta (AntDsConta)

    *==========================================================================
    * Favorecido do cheque selecionado na grade (TxtFavorecido, somente
    * leitura - espelha CsSigCqChi.favos do registro corrente).
    *==========================================================================
    this_cFavorecido = ""

    *==========================================================================
    * Flags de acesso do usuario logado (fChecaAcesso('SIGPRCHR', <operacao>)
    * no Init legado) - controlam Enabled dos botoes Excluir Documento e
    * Excluir Cheque.
    *==========================================================================
    this_lExcluirDocumento = .F.  && Acesso para excluir documento (ExcluirDocumento)
    this_lExcluirCheque    = .F.  && Acesso para excluir cheque cancelado (ExcluirCheque)

    *==========================================================================
    * Controle de fluxo da primeira exibicao da lista de cheques - MontaChq
    * recebe par_lPosiciona e, quando .F. (Inicial = .T. no legado), vai
    * direto para o Top do cursor em vez de reposicionar no ultimo cheque
    * selecionado.
    *==========================================================================
    this_lPrimeiraExibicao = .T.  && Inicial

    *==========================================================================
    * Leitor de codigo de barras do cheque (getBanco.KeyPress no legado):
    * this_lLeitorChequeAtivo indica se o usuario esta no meio de uma leitura
    * (tecla 60 inicia, tecla 58 finaliza) e this_cChequeLido acumula os
    * caracteres lidos (pcChqLido).
    *==========================================================================
    this_lLeitorChequeAtivo = .F. && plLeCheque
    this_cChequeLido        = ""  && pcChqLido

    *==========================================================================
    * Nomes dos cursores de trabalho, compartilhados entre os metodos do BO
    * e o Form (grids ligados via RecordSource/ControlSource).
    *==========================================================================
    this_cCursorCheques     = "cursor_4c_Cheques"      && CsSigCqChi (cheques do periodo/conta filtrados)
    this_cCursorContas      = "cursor_4c_Contas"        && CrContas (contas com emissao de cheque habilitada)
    this_cCursorImpressoras = "cursor_4c_Impressoras"   && CrSigCdmp (impressoras cadastradas)

    *==========================================================================
    * Cheque corrente - espelha 1:1 as colunas de SigCqChi (docs/schema.sql)
    * do registro selecionado na grade. Populado por CarregarDoCursor() e
    * usado por ObterChavePrimaria()/ExecutarExclusao() no cancelamento
    * fisico do cheque (Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado).
    *==========================================================================
    this_cCidchaves   = ""      && PK Fortyus (cidchaves)
    this_cAgencias    = ""      && agencias char(4)
    this_cBancos      = ""      && bancos char(3)
    this_lCancelas    = .F.     && cancelas bit -> cheque CANCELADO (ncancelas no legado)
    this_cContas      = ""      && contas char(10)
    this_dDatas       = {}      && datas datetime NULL - emissao do cheque
    this_cDopes       = ""      && dopes char(20) - documento de origem
    this_lEmitidos    = .F.     && emitidos bit (nemitidos no legado)
    this_cEmps        = ""      && emps char(3)
    this_cGrupos      = ""      && grupos char(10) - grupo de contas do cheque
    this_cNcheques    = ""      && ncheques char(6) - numero do cheque
    this_cNcontas     = ""      && ncontas char(10) - conta corrente
    this_nNcopias     = 0       && ncopias numeric(6,0)
    this_nNemissoes   = 0       && nemissoes numeric(2,0)
    this_nNumes       = 0       && numes numeric(6,0) - numero do documento (Dopes/Numes)
    this_nValors      = 0       && valors numeric(11,2)
    this_dVencs       = {}      && vencs datetime NULL - vencimento
    this_cVersos      = ""      && versos text - texto do verso do cheque
    this_cEmpDopNums  = ""      && empdopnums char(29) - chave posicional Emps+Dopes+Str(Numes,6)
    this_cJustCanc    = ""      && justcanc text - justificativa do cancelamento (get_justificativa)
    this_nImpVersos   = 0       && impversos numeric(1,0)

    *==========================================================================
    * Init - Business Object sem tabela unica de persistencia CRUD; a tabela
    * fisica manipulada (Delete no cancelamento de cheque) eh SigCqChi, e a
    * chave primaria eh cidchaves (cidchaves char - PK Fortyus, ver INSERT
    * do legado / regra #22 do CLAUDE.md).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqChi")
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            THIS.this_dAntDataInicial = {}
            THIS.this_dAntDataFinal   = {}
            THIS.this_cAntCodGrupo    = ""
            THIS.this_cAntDescGrupo   = ""
            THIS.this_cAntCodConta    = ""
            THIS.this_cAntDescConta   = ""

            THIS.this_lExcluirDocumento = fChecaAcesso("SIGPRCHR", "EXCLUIR")
            THIS.this_lExcluirCheque    = fChecaAcesso("SIGPRCHR", "EXCLUIRCHQ")
            THIS.this_lPrimeiraExibicao = .T.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCqChi (par_cAliasCursor
    * eh um cursor de UM cheque, populado por SQLEXEC com os nomes reais do
    * banco - docs/schema.sql) para as properties this_* do cheque corrente.
    * Usado pelo Form ao selecionar uma linha da grade, antes de acionar
    * Excluir() (cancelamento fisico do cheque ja cancelado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
            THIS.this_cAgencias   = TratarNulo(agencias, "")
            THIS.this_cBancos     = TratarNulo(bancos, "")
            THIS.this_lCancelas   = ConverterParaLogico(cancelas)
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_dDatas      = ConverterParaData(datas)
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_lEmitidos   = ConverterParaLogico(emitidos)
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cFavorecido = TratarNulo(favos, "")
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cNcheques   = TratarNulo(ncheques, "")
            THIS.this_cNcontas    = TratarNulo(ncontas, "")
            THIS.this_nNcopias    = NVL(ncopias, 0)
            THIS.this_nNemissoes  = NVL(nemissoes, 0)
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cVersos     = TratarNulo(versos, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cJustCanc   = TratarNulo(justcanc, "")
            THIS.this_nImpVersos  = NVL(impversos, 0)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCheques - Consulta os cheques do periodo/grupo/conta filtrados e
    * devolve o resultado em par_cCursorDestino (cursor TEMPORARIO - quem
    * transfere para o cursor da grade eh o Form, via ZAP + APPEND FROM DBF,
    * para nao destruir o binding do Grid).
    *
    * Transcricao 1:1 do SELECT do "PROCEDURE montachq" legado (duas variantes
    * conforme a Conta estar preenchida ou nao):
    *
    *   Sem conta : ...Where a.datas Between ?lcDtInicial And ?lcDtFinal And
    *                    [a.Grupos = '<grupo>' And]
    *                    a.Contas in (Select Distinct ContaDs From SigOpFp
    *                                  Where EmiChqs = 1)
    *   Com conta : ...Where datas Between ... And [Grupos = ... And]
    *                    Contas = '<conta>'
    *
    * O filtro de Grupo eh OPCIONAL no legado (Iif(Empty(lcCdGrupo), [], ...)) -
    * a ausencia dele NAO eh esquecimento de migracao.
    *
    * Os "Iif(Emitidos,1,0) as NEmitidos" / "Iif(Cancelas,1,0) as NCancelas"
    * que o legado faz no SELECT VFP sao resolvidos aqui no SQL Server (CASE
    * WHEN), porque emitidos/cancelas sao colunas "bit" (docs/schema.sql) e
    * chegam ao VFP ora como Logico ora como Numerico conforme o driver
    * (CLAUDE.md regra #13) - converter no servidor elimina a ambiguidade e
    * entrega numeric(1,0), que eh o tipo das colunas nemitidos/ncancelas do
    * cursor da grade.
    *
    * A ordenacao final eh a do SELECT VFP do legado (Order By Bancos,
    * Agencias, NContas, NCheques), que sobrepoe o Order By da query remota.
    *==========================================================================
    PROCEDURE CarregarCheques(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cCursor, loc_cSQL, loc_nResultado
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim, loc_cGrupo, loc_cConta
        LOCAL loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = IIF(VARTYPE(par_cCursorDestino) = "C" AND ;
                !EMPTY(par_cCursorDestino), par_cCursorDestino, "cursor_4c_ChequesTmp")

            *-- ConverterParaData: o filtro pode chegar como DATE (TextBox com
            *-- .Value = {}) ou como DATETIME (coluna do banco) - CLAUDE.md #16.
            loc_dIni = ConverterParaData(THIS.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_dDataFinal)

            IF EMPTY(loc_dIni) OR EMPTY(loc_dFim)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + ;
                    "o informado para a consulta de cheques."
            ELSE
                *-- fDtoSQL(Dt_Inicial.Value) / fDtoSQL(Dt_Final.Value,'23:59:59')
                loc_tIni = DTOT(loc_dIni)
                loc_tFim = DATETIME(YEAR(loc_dFim), MONTH(loc_dFim), DAY(loc_dFim), 23, 59, 59)

                loc_cGrupo = ALLTRIM(THIS.this_cCodGrupo)
                loc_cConta = ALLTRIM(THIS.this_cCodConta)

                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                           "a.agencias, a.ncontas, a.ncheques, a.contas, a.valors, " + ;
                           "a.favos, a.ncopias, a.nemissoes, a.cidchaves, a.justcanc, " + ;
                           "CASE WHEN a.emitidos = 1 THEN 1 ELSE 0 END AS nemitidos, " + ;
                           "CASE WHEN a.cancelas = 1 THEN 1 ELSE 0 END AS ncancelas, " + ;
                           "0 AS nmarca1s " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                               " AND " + FormatarDataSQL(loc_tFim) + " "

                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + "AND a.grupos = " + EscaparSQL(loc_cGrupo) + " "
                ENDIF

                IF EMPTY(loc_cConta)
                    loc_cSQL = loc_cSQL + ;
                        "AND a.contas IN (SELECT DISTINCT ContaDs FROM SigOpFp " + ;
                        "WHERE EmiChqs = 1) "
                ELSE
                    loc_cSQL = loc_cSQL + "AND a.contas = " + EscaparSQL(loc_cConta) + " "
                ENDIF

                loc_cSQL = loc_cSQL + ;
                    "ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                *-- Legado: If (SqlExecute(...) < 1) -> falha de conexao
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao selecionar os cheques do " + ;
                        "per" + CHR(237) + "odo." + CHR(13) + CapturarErroSQL()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - PK Fortyus de SigCqChi eh cidchaves (char, ver
    * regra #22 do CLAUDE.md). Usado por RegistrarAuditoria() (BusinessBase)
    * no INSERT INTO LogAuditoria apos ExecutarExclusao().
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar() - o legado (SIGPRCHR.SCX) NAO grava nem altera
    * registros em SigCqChi: os cheques sao emitidos por outro modulo do
    * sistema (emissao de cheques). Esta tela apenas consulta cheques por
    * Grupo/Conta/Periodo (comportamento.json: Select .../CsSigCqChi, sem
    * nenhum Insert/Update em SigCqChi) e cancela fisicamente um documento
    * ja cancelado (Delete From SigCqChi Where cidchaves = ... no
    * cmdGok.Click legado, replicado em ExecutarExclusao() abaixo). O
    * comportamento padrao herdado de BusinessBase (recusar Inserir/
    * Atualizar) ja eh o correto para esta entidade neste form.
    *==========================================================================

    *==========================================================================
    * AntesDeExcluir - Replica o guard do legado antes do MessageBox de
    * confirmacao e do Delete: "If CsSigCqChi.ncancelas = 1 And
    * ThisForm.ExcluirCheque" (cmdGok.Click). So permite excluir um cheque
    * JA CANCELADO e quando o usuario tem o acesso ExcluirCheque
    * (fChecaAcesso('SIGPRCHR','EXCLUIRCHQ') calculado no Init).
    *==========================================================================
    PROTECTED PROCEDURE AntesDeExcluir()
        IF !THIS.this_lCancelas
            THIS.this_cMensagemErro = "Somente cheques CANCELADOS podem ser exclu" + CHR(237) + "dos."
            RETURN .F.
        ENDIF

        IF !THIS.this_lExcluirCheque
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o possui acesso para excluir cheque cancelado."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado (exclusao fisica do cheque cancelado). Conexao
    * nasce em modo transacional manual (Transactions=2) - commit/rollback
    * explicitos.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cMensagemErro = "Cheque sem chave prim" + CHR(225) + "ria (cidchaves) para exclus" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("EXCLUSAO")
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o cheque cancelado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidos - Marca como emitidos (SQL Server + cursor de
    * trabalho) todos os cheques com nmarca1s = 1 no cursor informado.
    * Replica o "Update SigCqChi Set emitidos = 1 Where cidchaves = ..." dos
    * fluxos de impressao do legado (cmdImpchq/cmdchmat), um UPDATE por
    * cheque (cada cheque tem cidchaves proprio). Conexao em modo
    * transacional manual (Transactions=2) - commit/rollback explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidos(par_cCursor)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR nmarca1s = 1
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = " + EscaparSQL(cidchaves)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1, nmarca1s WITH 0
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidosPorFaixa - Variante de MarcarChequesComoEmitidos
    * para o painel de impressao manual (cnt_4c_Impchmat/impchmat do legado):
    * marca como emitidos TODOS os cheques do cursor de trabalho que casam
    * com Banco + faixa de numero de cheque (nao pelo cidchaves de cada
    * linha marcada). Replica "Update SigCqChi Set emitidos = 1 Where bancos
    * = ... And ncheques = ..." do cmdimpri.Click legado, um UPDATE por
    * cheque da faixa. Conexao em modo transacional manual - commit/rollback
    * explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidosPorFaixa(par_cCursor, par_cBanco, par_cChequeIni, par_cChequeFin)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR bancos = par_cBanco AND BETWEEN(ncheques, par_cChequeIni, par_cChequeFin) AND ncancelas = 0
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE bancos = " + EscaparSQL(bancos) + ;
                        " AND ncheques = " + EscaparSQL(ncheques)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta o cheque corrente (chamado por BusinessBase.Excluir
    * apos ExecutarExclusao() ter sucesso, e por NovoRegistro/CancelarEdicao).
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves  = ""
        THIS.this_cAgencias   = ""
        THIS.this_cBancos     = ""
        THIS.this_lCancelas   = .F.
        THIS.this_cContas     = ""
        THIS.this_dDatas      = {}
        THIS.this_cDopes      = ""
        THIS.this_lEmitidos   = .F.
        THIS.this_cEmps       = ""
        THIS.this_cFavorecido = ""
        THIS.this_cGrupos     = ""
        THIS.this_cNcheques   = ""
        THIS.this_cNcontas    = ""
        THIS.this_nNcopias    = 0
        THIS.this_nNemissoes  = 0
        THIS.this_nNumes      = 0
        THIS.this_nValors     = 0
        THIS.this_dVencs      = {}
        THIS.this_cVersos     = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cJustCanc   = ""
        THIS.this_nImpVersos  = 0
    ENDPROC

ENDDEFINE

