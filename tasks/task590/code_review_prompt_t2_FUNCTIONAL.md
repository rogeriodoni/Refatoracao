# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_JUSTIFICATIVA, CNT_4C_PROCURAR, CNT_4C_IMPCHMAT. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroDataInicial()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroDataFinal()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroGrupo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3818 linhas total):

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

*-- Linhas 220 a 369:
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
237:         LOCAL loc_cNull
238: 
239:         IF USED("cursor_4c_Cheques")
240:             USE IN cursor_4c_Cheques
241:         ENDIF
242: 
243:         *-- SET NULL ON antes do CREATE CURSOR: SQL Server pode devolver NULL
244:         *-- em colunas aqui declaradas sem a clausula NULL (favos/contas/etc).
245:         *-- Sem isso, o APPEND FROM DBF() de MontaGrade estoura "Field XXX
246:         *-- does not accept null values" no primeiro registro NULL.
247:         loc_cNull = SET("Null")
248:         SET NULL ON
249: 
250:         CREATE CURSOR cursor_4c_Cheques ;
251:             (emps C(3), dopes C(20), numes N(6,0), datas T NULL, bancos C(3), ;
252:              agencias C(4), ncontas C(10), ncheques C(6), contas C(10), ;
253:              valors N(11,2), favos C(40), ncopias N(6,0), nemissoes N(2,0), ;
254:              cidchaves C(20), nemitidos N(1,0), ncancelas N(1,0), ;
255:              nmarca1s N(1,0), justcanc M)
256: 
257:         IF loc_cNull == "OFF"
258:             SET NULL OFF
259:         ENDIF
260: 
261:         *-- Indices criados JUNTO com o cursor (vazio), nao apenas apos a
262:         *-- primeira carga: ExibirCheques faz "SET ORDER TO NCopias/Contas" e,
263:         *-- com o cursor existindo SEM TAG nenhuma, isso estoura "Table has no
264:         *-- index order set." - acontece quando o usuario abre a tela e usa
265:         *-- Procurar/Chq. Matric. ANTES de Processar (no legado o cursor nem
266:         *-- existia nesse momento e o guard IF USED() pulava tudo). INDEX ON
267:         *-- cursor vazio eh valido, e o ZAP da recarga PRESERVA as tags, entao
268:         *-- a chamada seguinte em MontaGrade vira no-op (guard TAGCOUNT = 0).
269:         THIS.CriarIndicesCheques()
270:     ENDPROC
271: 
272:     *==========================================================================
273:     * CriarIndicesCheques - Os 12 indices que o legado cria sobre CsSigCqChi
274:     * logo apos montar o cursor (PROCEDURE montachq), transcritos 1:1 e com os
275:     * MESMOS nomes de TAG - as tags sao usadas por nome em SET ORDER TO /
276:     * SEEK(..., "<tag>") no reposicionamento e na tela de Procurar, entao
277:     * renomear qualquer uma delas quebra a busca (nunca usar uma tag unica
278:     * "ordem").
279:     *
280:     * Medido no VFP9: ZAP PRESERVA as TAGs do indice (TAGCOUNT antes e depois
281:     * = 2), por isso os indices sao criados uma unica vez - nas recargas
282:     * seguintes o APPEND apenas atualiza as tags existentes.
283:     *==========================================================================
284:     PROTECTED PROCEDURE CriarIndicesCheques()
285:         LOCAL loc_cCursor
286: 
287:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
288: 
289:         IF !USED(loc_cCursor)
290:             RETURN
291:         ENDIF
292: 
293:         SELECT (loc_cCursor)
294: 
295:         IF TAGCOUNT() = 0
296:             INDEX ON ncopias                TAG NCopias
297:             INDEX ON nemitidos              TAG NEmitidos
298:             INDEX ON ncancelas              TAG NCancelas
299:             INDEX ON nmarca1s               TAG NMarca1s
300:             INDEX ON ncheques               TAG NCheques
301:             INDEX ON datas                  TAG Datas
302:             INDEX ON ncontas + ncheques     TAG Conta
303:             INDEX ON contas + STR(ncopias)  TAG Contas
304:             INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques        TAG Emissao
305:             INDEX ON STR(valors, 12, 2) + bancos + agencias + ncontas + ncheques TAG Valor
306:             INDEX ON bancos + agencias + ncontas + ncheques                      TAG Cheque
307:             INDEX ON agencias + ncontas + ncheques                               TAG Agencia
308:         ENDIF
309:     ENDPROC
310: 
311:     *==========================================================================
312:     * MontaGrade - Carga da grade de cheques. Transcricao do "PROCEDURE
313:     * montachq" legado: guarda a chave do cheque corrente, consulta o periodo
314:     * no banco (SQL no BO), repovoa o cursor, recria os indices, posiciona e
315:     * entrega para ExibirCheques().
316:     *
317:     * Diferenca DELIBERADA em relacao ao legado: o legado faz
318:     * "GrdCCheques.RecordSource = '' + Use In CsSigCqChi" e recria o cursor com
319:     * SELECT ... INTO CURSOR ... ReadWrite, religando em seguida TODOS os
320:     * ControlSource. Aqui o cursor eh PRESERVADO e recarregado com ZAP +
321:     * APPEND FROM DBF(): reatribuir RecordSource resetaria Column.Width,
322:     * Header1.Caption, Sparse e CurrentControl (o CheckBox da coluna Imprime
323:     * deixaria de aparecer). O cursor criado por CREATE CURSOR ja eh
324:     * READWRITE, que eh o que a coluna editavel do CheckBox exige.
325:     *
326:     * ZAP exige SAFETY OFF: config.prg NAO desliga SAFETY (so SET EXACT ON) e
327:     * com SAFETY ON o ZAP abre dialogo modal de confirmacao que CONGELA a tela.
328:     *==========================================================================
329:     PROCEDURE MontaGrade(par_lPosiciona)
330:         LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor, loc_cTmp, loc_cBusca
331:         LOCAL loc_cSafety, loc_oErro
332:         loc_lSucesso   = .F.
333:         loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
334:         loc_cBusca     = ""
335: 
336:         TRY
337:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
338:             loc_cTmp    = "cursor_4c_ChequesTmp"
339: 
340:             THIS.LockScreen = .T.
341: 
342:             *-- lcBusca = Bancos + Agencias + ncontas + Ncheques: chave
343:             *-- POSICIONAL de largura fixa (char 3+4+10+6 = 23 = a chave da tag
344:             *-- Cheque). NUNCA aplicar ALLTRIM nas partes - o padding FAZ PARTE
345:             *-- da chave e encurta-la faz o SEEK devolver "nao achou" em
346:             *-- silencio (CLAUDE.md regra #42). Medido: SEEK com a chave crua
347:             *-- de 23 chars casa na tag Cheque.
348:             IF loc_lPosiciona AND USED(loc_cCursor) AND !EOF(loc_cCursor)
349:                 SELECT (loc_cCursor)
350:                 loc_cBusca = bancos + agencias + ncontas + ncheques
351:             ENDIF
352: 
353:             WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT
354: 
355:             IF !USED(loc_cCursor)
356:                 THIS.CriarCursorCheques()
357:             ENDIF
358: 
359:             IF THIS.this_oBusinessObject.CarregarCheques(loc_cTmp)
360:                 loc_cSafety = SET("Safety")
361:                 SET SAFETY OFF
362: 
363:                 SELECT (loc_cCursor)
364:                 ZAP
365:                 APPEND FROM DBF(loc_cTmp)
366: 
367:                 IF loc_cSafety == "ON"
368:                     SET SAFETY ON
369:                 ENDIF

*-- Linhas 415 a 483:
415:         CATCH TO loc_oErro
416:             MsgErro(loc_oErro.Message + CHR(13) + ;
417:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
418:                 "Procedure: " + loc_oErro.Procedure, "Erro em MontaGrade")
419:         ENDTRY
420: 
421:         WAIT CLEAR
422:         THIS.LockScreen = .F.
423: 
424:         *-- Legado: If llPosiciona -> mExibeCheques(.F.) Else mExibeCheques(.T.)
425:         IF loc_lSucesso
426:             THIS.ExibirCheques(!loc_lPosiciona)
427:             THIS.this_oBusinessObject.this_lPrimeiraExibicao = .F.
428:         ENDIF
429: 
430:         RETURN loc_lSucesso
431:     ENDPROC
432: 
433:     *==========================================================================
434:     * ExibirCheques - Transcricao do "PROCEDURE mexibecheques" legado: desmarca
435:     * a coluna Imprime, escolhe a ordem da grade conforme a Conta estar
436:     * filtrada, opcionalmente salta para o fim da lista, e sincroniza
437:     * Favorecido / botao Procurar / foco na coluna Conta.
438:     *
439:     * Medido no VFP9: "Seek Chr(255) ... Order NCopias" (chave CHARACTER contra
440:     * indice NUMERICO) NAO dispara erro - deixa o cursor em EOF, que eh
441:     * exatamente o efeito pretendido pelo legado (ir para o fim da lista).
442:     *==========================================================================
443:     PROCEDURE ExibirCheques(par_lSeek)
444:         LOCAL loc_lSeek, loc_cCursor, loc_cConta, loc_cFavorecido, loc_oErro
445: 
446:         *-- Legado: llSeek = Iif(Type('llSeek') = 'L', llSeek, .F.)
447:         loc_lSeek = IIF(VARTYPE(par_lSeek) = "L", par_lSeek, .F.)
448: 
449:         TRY
450:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
451: 
452:             IF USED(loc_cCursor)
453:                 THIS.LockScreen = .T.
454: 
455:                 *-- Legado: UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
456:                 UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
457: 
458:                 loc_cConta = ALLTRIM(THIS.ObterFiltroConta())
459: 
460:                 SELECT (loc_cCursor)
461: 
462:                 IF EMPTY(loc_cConta)
463:                     SET ORDER TO NCopias
464:                     IF loc_lSeek
465:                         SEEK CHR(255) IN (loc_cCursor) ORDER NCopias ASCENDING
466:                     ENDIF
467:                 ELSE
468:                     *-- Legado: Set Order To contas + Set Key To <conta>. O
469:                     *-- SET KEY eh OMITIDO de proposito: a consulta do BO ja
470:                     *-- restringe o resultado a essa unica conta (WHERE
471:                     *-- a.contas = <conta>), entao ele nao filtra nada a mais -
472:                     *-- e a tag Contas eh COMPOSTA (contas + Str(ncopias)),
473:                     *-- de modo que um SET KEY com a chave parcial sob o
474:                     *-- SET EXACT ON global (config.prg) poderia nao casar e
475:                     *-- deixar a grade vazia sem erro nenhum.
476:                     SET ORDER TO Contas
477:                     IF loc_lSeek
478:                         SEEK loc_cConta + CHR(255) IN (loc_cCursor) ORDER Contas ASCENDING
479:                     ENDIF
480:                 ENDIF
481: 
482:                 *-- Legado: ThisForm.CmdGOk.CmdProcurar.Enabled = .t. + Refresh
483:                 IF THIS.obj_4c_CmdGok.ButtonCount >= 4

*-- Linhas 512 a 603:
512:             THIS.LockScreen = .F.
513:             MsgErro(loc_oErro.Message + CHR(13) + ;
514:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
515:                 "Procedure: " + loc_oErro.Procedure, "Erro em ExibirCheques")
516:         ENDTRY
517:     ENDPROC
518: 
519:     *==========================================================================
520:     * ObterFiltroConta / ObterFiltroGrupo - Valor corrente dos filtros de
521:     * Conta e Grupo. Os TextBox correspondentes (getCdContas / getCdGrupos do
522:     * legado) sao criados na fase de filtros; enquanto nao existirem, o valor
523:     * vem das properties do BO (this_cCodConta / this_cCodGrupo), que sao a
524:     * fonte unica desse estado. Quando os campos existirem, o TextBox passa a
525:     * mandar - igual ao legado, que le sempre ThisForm.getCdContas.Value.
526:     *==========================================================================
527:     PROTECTED FUNCTION ObterFiltroConta()
528:         LOCAL loc_cConta
529: 
530:         loc_cConta = THIS.this_oBusinessObject.this_cCodConta
531: 
532:         IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
533:             loc_cConta = THIS.txt_4c_CdContas.Value
534:         ENDIF
535: 
536:         RETURN IIF(VARTYPE(loc_cConta) = "C", loc_cConta, "")
537:     ENDFUNC
538: 
539:     PROTECTED FUNCTION ObterFiltroGrupo()
540:         LOCAL loc_cGrupo
541: 
542:         loc_cGrupo = THIS.this_oBusinessObject.this_cCodGrupo
543: 
544:         IF PEMSTATUS(THIS, "txt_4c_CdGrupos", 5)
545:             loc_cGrupo = THIS.txt_4c_CdGrupos.Value
546:         ENDIF
547: 
548:         RETURN IIF(VARTYPE(loc_cGrupo) = "C", loc_cGrupo, "")
549:     ENDFUNC
550: 
551:     *==========================================================================
552:     * ConfigurarGrid - Grade de cheques (grd_4c_Dados = grdCcheques do
553:     * legado). Layout FLAT (sem PageFrame) - Top/Left identicos ao SCX
554:     * original (layout.json), SEM compensacao de +29 (essa compensacao so
555:     * vale para forms com PageFrame.Top=-29, o que nao existe neste form).
556:     *
557:     * ColumnOrder replica o SCX: clnImprime (Column10) desenha PRIMEIRO
558:     * (ColumnOrder=1) e clnDatas (Column1) desenha POR ULTIMO (ColumnOrder=10)
559:     * - os demais seguem a ordem de criacao (2..9). clnSituacaos (Column8) eh
560:     * CALCULADA (nao existe coluna no cursor) - ControlSource eh a mesma
561:     * expressao IIF aninhada do legado.
562:     *==========================================================================
563:     PROTECTED PROCEDURE ConfigurarGrid()
564:         LOCAL loc_oGrid, loc_oErro
565: 
566:         TRY
567:             THIS.CriarCursorCheques()
568: 
569:             THIS.AddObject("grd_4c_Dados", "Grid")
570:             loc_oGrid = THIS.grd_4c_Dados
571: 
572:             WITH loc_oGrid
573:                 .Top               = 233
574:                 .Left              = 24
575:                 .Width             = 710
576:                 .Height            = 291
577:                 .FontName          = "Tahoma"
578:                 .FontSize          = 8
579:                 .AllowHeaderSizing = .F.
580:                 .AllowRowSizing    = .F.
581:                 .DeleteMark        = .F.
582:                 .RecordMark        = .F.
583:                 .ScrollBars        = 2
584:                 .GridLineColor     = RGB(238, 238, 238)
585:                 .ReadOnly          = .F.
586:                 .ColumnCount       = 10
587:                 .RecordSource      = "cursor_4c_Cheques"
588:                 .Visible           = .T.
589:             ENDWITH
590: 
591:             *-- Column1: clnDatas (desenha por ultimo - ColumnOrder=10)
592:             WITH loc_oGrid.Column1
593:                 .FontName          = "Tahoma"
594:                 .Width             = 79
595:                 .Movable           = .F.
596:                 .Resizable         = .F.
597:                 .ReadOnly          = .T.
598:                 .ColumnOrder       = 10
599:                 .ControlSource     = "cursor_4c_Cheques.datas"
600:                 .Header1.Caption   = "Data"
601:                 .Header1.Alignment = 2
602:                 .Header1.ForeColor = RGB(90, 90, 90)
603:             ENDWITH

*-- Linhas 632 a 675:
632:             *-- Legado: clnNcopias.Header1.Click - reordena para NCopias ao
633:             *-- clicar no cabecalho, so quando nao ha filtro de Conta e a
634:             *-- ordem corrente ainda nao eh NCopias.
635:             BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "Column3Header1Click")
636: 
637:             *-- Column4: clnBancos
638:             WITH loc_oGrid.Column4
639:                 .FontName          = "Tahoma"
640:                 .Width             = 30
641:                 .Movable           = .F.
642:                 .Resizable         = .F.
643:                 .ReadOnly          = .T.
644:                 .ControlSource     = "cursor_4c_Cheques.bancos"
645:                 .Header1.Caption   = "Bco"
646:                 .Header1.Alignment = 2
647:                 .Header1.ForeColor = RGB(90, 90, 90)
648:             ENDWITH
649: 
650:             *-- Column5: clnAgencias
651:             WITH loc_oGrid.Column5
652:                 .FontName          = "Tahoma"
653:                 .Width             = 37
654:                 .Movable           = .F.
655:                 .Resizable         = .F.
656:                 .ReadOnly          = .T.
657:                 .ControlSource     = "cursor_4c_Cheques.agencias"
658:                 .Header1.Caption   = "Ag."
659:                 .Header1.Alignment = 2
660:                 .Header1.ForeColor = RGB(90, 90, 90)
661:             ENDWITH
662: 
663:             *-- Column6: clnNcontas
664:             WITH loc_oGrid.Column6
665:                 .FontName          = "Tahoma"
666:                 .Width             = 79
667:                 .Movable           = .F.
668:                 .Resizable         = .F.
669:                 .ReadOnly          = .T.
670:                 .ControlSource     = "cursor_4c_Cheques.ncontas"
671:                 .Header1.Caption   = "C.Corrente"
672:                 .Header1.Alignment = 2
673:                 .Header1.ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675: 

*-- Linhas 746 a 890:
746:                 "IIF(cursor_4c_Cheques.ncancelas = 1, RGB(255,0,0), " + ;
747:                 "IIF(cursor_4c_Cheques.nemitidos = 0, RGB(0,0,255), RGB(0,0,0)))", "Column")
748: 
749:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "KeyPress",  THIS, "ChkImprimeKeyPress")
750:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseUp",   THIS, "ChkImprimeMouseUp")
751:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseDown", THIS, "ChkImprimeMouseDown")
752:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "Click",     THIS, "ChkImprimeClick")
753: 
754:             *-- Legado: Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange
755:             *-- da grdCcheques tem TODOS o mesmo corpo (favorecido + Enabled
756:             *-- dos botoes de documento + painel de justificativa em modo
757:             *-- leitura quando o cheque corrente esta cancelado) - transcrito
758:             *-- uma unica vez em AtualizarPainelChequeCorrente() e ligado aqui
759:             *-- aos dois eventos NATIVOS do Grid (Scrolled/AfterRowColChange).
760:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
761:             BINDEVENT(loc_oGrid, "Scrolled",          THIS, "GrdDadosScrolled")
762:         CATCH TO loc_oErro
763:             MsgErro(loc_oErro.Message + CHR(13) + ;
764:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
765:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
766:         ENDTRY
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * ChkImprimeKeyPress/MouseUp/MouseDown/Click - Toggle do checkbox
771:     * "Imprime" (Column10.chk_4c_Check1 = clnImprime.Check1 do legado).
772:     * MouseDown/Click apenas suprimem o toggle nativo do CheckBox (NODEFAULT);
773:     * MouseUp e KeyPress(Enter/Espaco) fazem a alternancia de verdade via
774:     * UPDATE no cursor, replicando 1:1 o KeyPress original do legado.
775:     * PUBLIC (sem PROTECTED) - BINDEVENT so dispara metodos PUBLIC.
776:     *==========================================================================
777:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
778:         LOCAL loc_cCursor, loc_nRecno, loc_cChave
779: 
780:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
781: 
782:         IF INLIST(par_nKeyCode, 13, 32) AND USED(loc_cCursor)
783:             loc_nRecno = RECNO(loc_cCursor)
784:             SELECT (loc_cCursor)
785:             loc_cChave = bancos + agencias + ncontas + ncheques
786: 
787:             UPDATE (loc_cCursor) SET nmarca1s = IIF(nmarca1s = 1, 0, 1) ;
788:                 WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
789:                   AND nemitidos = 0 AND ncancelas = 0
790: 
791:             THIS.grd_4c_Dados.Refresh()
792: 
793:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
794:                 SELECT (loc_cCursor)
795:                 GOTO loc_nRecno
796:             ENDIF
797: 
798:             NODEFAULT
799:         ENDIF
800:     ENDPROC
801: 
802:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
803:         THIS.ChkImprimeKeyPress(32, 0)
804:         NODEFAULT
805:     ENDPROC
806: 
807:     PROCEDURE ChkImprimeMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
808:         NODEFAULT
809:     ENDPROC
810: 
811:     PROCEDURE ChkImprimeClick()
812:         NODEFAULT
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * Column3Header1Click - Header1.Click de clnNcopias (Column3). PUBLIC -
817:     * BINDEVENT so dispara metodos PUBLIC.
818:     *==========================================================================
819:     PROCEDURE Column3Header1Click()
820:         LOCAL loc_cCursor
821: 
822:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
823: 
824:         IF EMPTY(THIS.ObterFiltroConta()) AND USED(loc_cCursor) AND ;
825:                 UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
826:             THIS.ExibirCheques(.F.)
827:         ENDIF
828:     ENDPROC
829: 
830:     *==========================================================================
831:     * GrdDadosAfterRowColChange / GrdDadosScrolled - Navegacao na grade de
832:     * cheques (grd_4c_Dados). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
833:     *==========================================================================
834:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
835:         THIS.AtualizarPainelChequeCorrente()
836:     ENDPROC
837: 
838:     PROCEDURE GrdDadosScrolled(par_nDirection)
839:         THIS.AtualizarPainelChequeCorrente()
840:     ENDPROC
841: 
842:     *==========================================================================
843:     * AtualizarPainelChequeCorrente - Transcricao unica do corpo repetido em
844:     * Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange do grdCcheques
845:     * legado: espelha o Favorecido do cheque corrente, habilita/desabilita os
846:     * botoes de documento conforme o cheque estar cancelado, e mostra o
847:     * painel de justificativa em modo SOMENTE LEITURA quando o cheque
848:     * corrente ja esta cancelado (cmdGconf oculto - nao ha o que confirmar).
849:     *==========================================================================
850:     PROTECTED PROCEDURE AtualizarPainelChequeCorrente()
851:         LOCAL loc_cCursor, loc_lCancelas
852: 
853:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
854: 
855:         IF !USED(loc_cCursor)
856:             RETURN
857:         ENDIF
858: 
859:         loc_lCancelas = (EVALUATE(loc_cCursor + ".ncancelas") <> 0)
860: 
861:         IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
862:             THIS.txt_4c_TxtFavorecido.Value = EVALUATE(loc_cCursor + ".favos")
863:             THIS.txt_4c_TxtFavorecido.Refresh()
864:         ENDIF
865: 
866:         *-- Legado: Buttons 1/6/3/5/9 = cmdDocumento/cmdExcluiDoc/cmdImprimir/
867:         *-- cmdRecibo/btnExcluirChq (mesma numeracao de CmdGokClick).
868:         IF THIS.obj_4c_CmdGok.ButtonCount >= 9
869:             THIS.obj_4c_CmdGok.Buttons(1).Enabled = !loc_lCancelas
870:             THIS.obj_4c_CmdGok.Buttons(6).Enabled = (!loc_lCancelas AND THIS.this_oBusinessObject.this_lExcluirDocumento)
871:             THIS.obj_4c_CmdGok.Buttons(3).Enabled = !loc_lCancelas
872:             THIS.obj_4c_CmdGok.Buttons(5).Enabled = !loc_lCancelas
873:             THIS.obj_4c_CmdGok.Buttons(9).Enabled = (loc_lCancelas AND THIS.this_oBusinessObject.this_lExcluirCheque)
874:             THIS.obj_4c_CmdGok.Refresh()
875:         ENDIF
876: 
877:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
878:             WITH THIS.cnt_4c_justificativa
879:                 .Visible = loc_lCancelas
880: 
881:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
882:                     .obj_4c_Get_justificativa.ReadOnly = loc_lCancelas
883:                     IF loc_lCancelas
884:                         .obj_4c_Get_justificativa.Width = 346
885:                         .obj_4c_Get_justificativa.Refresh()
886:                     ENDIF
887:                 ENDIF
888: 
889:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
890:                     .obj_4c_CmdGconf.Enabled = .F.

*-- Linhas 901 a 944:
901:     * Layout FLAT - Top/Left identicos ao SCX original, sem compensacao de
902:     * PageFrame.
903:     *==========================================================================
904:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
905:         LOCAL loc_oErro
906: 
907:         TRY
908:             THIS.AddObject("obj_4c_CmdGok", "CommandGroup")
909:             WITH THIS.obj_4c_CmdGok
910:                 .Top           = -3
911:                 .Left          = 11
912:                 .Width         = 789
913:                 .Height        = 160
914:                 .ButtonCount   = 9
915:                 .BackStyle     = 0
916:                 .BorderStyle   = 0
917:                 .SpecialEffect = 1
918:                 .BorderColor   = RGB(136, 189, 188)
919:                 .Themes        = .F.
920:                 .Value         = 1
921:                 .Visible       = .T.
922:             ENDWITH
923: 
924:             *-- Botao 1: cmdDocumento
925:             WITH THIS.obj_4c_CmdGok.Buttons(1)
926:                 .Top             = 121
927:                 .Left            = 473
928:                 .Width           = 120
929:                 .Height          = 37
930:                 .FontBold        = .T.
931:                 .FontItalic      = .T.
932:                 .FontName        = "Comic Sans MS"
933:                 .FontSize        = 8
934:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
935:                 .Caption         = "\<Documento"
936:                 .PicturePosition = 1
937:                 .ForeColor       = RGB(90, 90, 90)
938:                 .BackColor       = RGB(255, 255, 255)
939:                 .Themes          = .F.
940:             ENDWITH
941: 
942:             *-- Botao 2: cmdSair (Encerrar)
943:             WITH THIS.obj_4c_CmdGok.Buttons(2)
944:                 .Top         = 6

*-- Linhas 1088 a 1218:
1088:                 .Themes          = .F.
1089:             ENDWITH
1090: 
1091:             BINDEVENT(THIS.obj_4c_CmdGok, "Click", THIS, "CmdGokClick")
1092: 
1093:             *-- Botao standalone: cmdTudo1 (Marca tudo)
1094:             THIS.AddObject("cmd_4c_CmdTudo1", "CommandButton")
1095:             WITH THIS.cmd_4c_CmdTudo1
1096:                 .Top         = 334
1097:                 .Left        = 742
1098:                 .Width       = 40
1099:                 .Height      = 40
1100:                 .FontName    = "Verdana"
1101:                 .FontSize    = 8
1102:                 .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1103:                 .Caption     = ""
1104:                 .ToolTipText = "Marca tudo"
1105:                 .ForeColor   = RGB(36, 84, 155)
1106:                 .BackColor   = RGB(255, 255, 255)
1107:                 .Themes           = .T.
1108:                 .TabStop     = .F.
1109:                 .Visible     = .T.
1110:             ENDWITH
1111:             BINDEVENT(THIS.cmd_4c_CmdTudo1, "Click", THIS, "BtnMarcarTudoClick")
1112: 
1113:             *-- Botao standalone: cmdApaga1 (Desmarca tudo)
1114:             THIS.AddObject("cmd_4c_CmdApaga1", "CommandButton")
1115:             WITH THIS.cmd_4c_CmdApaga1
1116:                 .Top         = 375
1117:                 .Left        = 742
1118:                 .Width       = 40
1119:                 .Height      = 40
1120:                 .FontName    = "Verdana"
1121:                 .FontSize    = 8
1122:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1123:                 .Caption     = ""
1124:                 .ToolTipText = "Desmarca tudo"
1125:                 .ForeColor   = RGB(36, 84, 155)
1126:                 .BackColor   = RGB(255, 255, 255)
1127:                 .Themes           = .T.
1128:                 .TabStop     = .F.
1129:                 .Visible     = .T.
1130:             ENDWITH
1131:             BINDEVENT(THIS.cmd_4c_CmdApaga1, "Click", THIS, "BtnDesmarcarTudoClick")
1132: 
1133:             *-- Botao standalone: Command2 "Processar" - dispara a carga da
1134:             *-- grade (MontaChq do legado). Propriedades EXATAS do SCX
1135:             *-- (Top=191, Left=598, Height=24, Width=88, Comic Sans MS 8
1136:             *-- bold+italic, ForeColor 90,90,90, BackColor 255,255,255,
1137:             *-- Themes=.F., TabIndex=7). O legado NAO declara Picture para
1138:             *-- este botao - nenhum icone eh inventado aqui.
1139:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
1140:             WITH THIS.cmd_4c_Processar
1141:                 .Top        = 191
1142:                 .Left       = 598
1143:                 .Width      = 88
1144:                 .Height     = 24
1145:                 .FontName   = "Comic Sans MS"
1146:                 .FontSize   = 8
1147:                 .FontBold   = .T.
1148:                 .FontItalic = .T.
1149:                 .Caption    = "Processar"
1150:                 .TabIndex   = 7
1151:                 .ForeColor  = RGB(90, 90, 90)
1152:                 .BackColor  = RGB(255, 255, 255)
1153:                 .Themes     = .F.
1154:                 .Visible    = .T.
1155:             ENDWITH
1156:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1157:         CATCH TO loc_oErro
1158:             MsgErro(loc_oErro.Message + CHR(13) + ;
1159:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1160:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
1161:         ENDTRY
1162:     ENDPROC
1163: 
1164:     *==========================================================================
1165:     * ConfigurarFiltros - Primeira metade dos campos de filtro (Fase 5/8):
1166:     * grupo Grupo (Label3/GetCdGrupos/GetDsGrupos) e grupo Periodo
1167:     * (Label2/Dt_inicial/Say2/Dt_final). Posicoes EXATAS do SCX original
1168:     * (layout.json) - form OPERACIONAL sem PageFrame, sem compensacao de +29.
1169:     *
1170:     * Handlers de Valid/lookup (fAcessoContab do Grupo, swap de datas do
1171:     * Periodo, e os campos de Conta/Favorecido restantes) sao implementados
1172:     * na fase seguinte, junto com o grupo Conta - mesmo padrao ja usado em
1173:     * FormSIGMVCMV.ConfigurarCamposPeriodoMoeda.
1174:     *
1175:     * TabIndex 1-4 reservados para este grupo; 5-6 ficam para Conta (proxima
1176:     * fase); 7 ja esta ocupado por cmd_4c_Processar (Fase 4).
1177:     *==========================================================================
1178:     PROTECTED PROCEDURE ConfigurarFiltros()
1179:         LOCAL loc_oErro
1180: 
1181:         TRY
1182:             *-- Label3 "Grupo :"
1183:             THIS.AddObject("lbl_4c_Label3", "Label")
1184:             WITH THIS.lbl_4c_Label3
1185:                 .Top       = 167
1186:                 .Left      = 34
1187:                 .Width     = 38
1188:                 .Height    = 15
1189:                 .FontName  = "Tahoma"
1190:                 .FontSize  = 8
1191:                 .Alignment = 0
1192:                 .BackStyle = 0
1193:                 .ForeColor = RGB(90, 90, 90)
1194:                 .Caption   = "Grupo :"
1195:                 .Visible   = .T.
1196:             ENDWITH
1197: 
1198:             *-- GetCdGrupos (codigo do grupo de contas - SigCdGcr.codigos char(10))
1199:             THIS.AddObject("txt_4c_CdGrupos", "TextBox")
1200:             WITH THIS.txt_4c_CdGrupos
1201:                 .Top           = 163
1202:                 .Left          = 75
1203:                 .Width         = 100
1204:                 .Height        = 25
1205:                 .FontName      = "Tahoma"
1206:                 .FontSize      = 8
1207:                 .MaxLength     = 10
1208:                 .SpecialEffect = 1
1209:                 .BorderColor   = RGB(36, 84, 155)
1210:                 .Value         = ""
1211:                 .TabIndex      = 1
1212:                 .Visible       = .T.
1213:             ENDWITH
1214: 
1215:             *-- GetDsGrupos (descricao do grupo - SigCdGcr.descrs char(40))
1216:             THIS.AddObject("txt_4c_DsGrupos", "TextBox")
1217:             WITH THIS.txt_4c_DsGrupos
1218:                 .Top           = 163

*-- Linhas 1378 a 1466:
1378:                 .Visible       = .T.
1379:             ENDWITH
1380: 
1381:             *-- BINDEVENT de snapshot (equivalente ao When legado: guarda o
1382:             *-- valor corrente em this_cAnt*/this_dAnt* ANTES da edicao) +
1383:             *-- BINDEVENT de KeyPress (equivalente ao Valid - BINDEVENT em
1384:             *-- "Valid" nao funciona de forma confiavel em TextBox, ver
1385:             *-- CLAUDE.md/memoria "feedback_keypress_lparameters_guard").
1386:             BINDEVENT(THIS.txt_4c_CdGrupos,   "GotFocus", THIS, "TxtCdGruposGotFocus")
1387:             BINDEVENT(THIS.txt_4c_DsGrupos,   "GotFocus", THIS, "TxtDsGruposGotFocus")
1388:             BINDEVENT(THIS.txt_4c_CdContas,   "GotFocus", THIS, "TxtCdContasGotFocus")
1389:             BINDEVENT(THIS.txt_4c_DsContas,   "GotFocus", THIS, "TxtDsContasGotFocus")
1390:             BINDEVENT(THIS.txt_4c_Dt_inicial, "GotFocus", THIS, "TxtDtInicialGotFocus")
1391:             BINDEVENT(THIS.txt_4c_Dt_final,   "GotFocus", THIS, "TxtDtFinalGotFocus")
1392: 
1393:             BINDEVENT(THIS.txt_4c_CdGrupos,   "KeyPress", THIS, "ValidarCdGruposKeyPress")
1394:             BINDEVENT(THIS.txt_4c_DsGrupos,   "KeyPress", THIS, "ValidarDsGruposKeyPress")
1395:             BINDEVENT(THIS.txt_4c_CdContas,   "KeyPress", THIS, "ValidarCdContasKeyPress")
1396:             BINDEVENT(THIS.txt_4c_DsContas,   "KeyPress", THIS, "ValidarDsContasKeyPress")
1397:             BINDEVENT(THIS.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDtInicialKeyPress")
1398:             BINDEVENT(THIS.txt_4c_Dt_final,   "KeyPress", THIS, "ValidarDtFinalKeyPress")
1399:         CATCH TO loc_oErro
1400:             MsgErro(loc_oErro.Message + CHR(13) + ;
1401:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1402:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
1403:         ENDTRY
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * ConfigurarContainersFlutuantes - Orquestra os 3 paineis Visible=.F. do
1408:     * legado, alternados por botao (cntjustificativa/cntProcurar/impchmat -
1409:     * mapeamento.json: cnt_4c_justificativa/cnt_4c_Procurar/cnt_4c_Impchmat).
1410:     * Precisam ficar na lista de skip de TornarControlesVisiveis (ja
1411:     * presente desde a Fase 3) - senao nasceriam visiveis.
1412:     *==========================================================================
1413:     PROTECTED PROCEDURE ConfigurarContainersFlutuantes()
1414:         THIS.ConfigurarJustificativa()
1415:         THIS.ConfigurarProcurar()
1416:         THIS.ConfigurarImpressaoManual()
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * ConfigurarJustificativa - Painel de justificativa do cancelamento de
1421:     * documento (cnt_4c_justificativa = cntjustificativa do legado, Registro
1422:     * 47/48 do SCX). Aberto por BtnExcluiDocClick (editavel) ou por
1423:     * AtualizarPainelChequeCorrente (somente leitura, ao navegar para um
1424:     * cheque ja cancelado).
1425:     *==========================================================================
1426:     PROTECTED PROCEDURE ConfigurarJustificativa()
1427:         LOCAL loc_oErro
1428: 
1429:         TRY
1430:             THIS.AddObject("cnt_4c_justificativa", "Container")
1431:             WITH THIS.cnt_4c_justificativa
1432:                 .Top           = 532
1433:                 .Left          = 395
1434:                 .Width         = 350
1435:                 .Height        = 69
1436:                 .BorderWidth   = 0
1437:                 .SpecialEffect = 0
1438:                 .BackColor     = RGB(255, 255, 255)
1439:                 .Visible       = .F.
1440:             ENDWITH
1441: 
1442:             THIS.cnt_4c_justificativa.AddObject("lbl_4c_Label5", "Label")
1443:             WITH THIS.cnt_4c_justificativa.lbl_4c_Label5
1444:                 .AutoSize  = .T.
1445:                 .FontName  = "Tahoma"
1446:                 .FontSize  = 8
1447:                 .BackStyle = 0
1448:                 .Caption   = "Justificativa do cancelamento"
1449:                 .Left      = 6
1450:                 .Top       = 5
1451:                 .ForeColor = RGB(90, 90, 90)
1452:                 .Visible   = .T.
1453:             ENDWITH
1454: 
1455:             THIS.cnt_4c_justificativa.AddObject("obj_4c_Get_justificativa", "EditBox")
1456:             WITH THIS.cnt_4c_justificativa.obj_4c_Get_justificativa
1457:                 .Top       = 21
1458:                 .Left      = 3
1459:                 .Width     = 238
1460:                 .Height    = 44
1461:                 .FontName  = "Tahoma"
1462:                 .FontSize  = 8
1463:                 .ForeColor = RGB(0, 0, 0)
1464:                 .ReadOnly  = .F.
1465:                 .Visible   = .T.
1466:             ENDWITH

*-- Linhas 1509 a 1566:
1509:                 .Themes      = .F.
1510:             ENDWITH
1511: 
1512:             BINDEVENT(THIS.cnt_4c_justificativa.obj_4c_CmdGconf, "Click", THIS, "CmdGconfClick")
1513:         CATCH TO loc_oErro
1514:             MsgErro(loc_oErro.Message + CHR(13) + ;
1515:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1516:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarJustificativa")
1517:         ENDTRY
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * ConfigurarProcurar - Painel de busca de cheque por Banco/Agencia/
1522:     * Conta/Cheque/Emissao/Valor ou leitor de codigo de barras
1523:     * (cnt_4c_Procurar = cntProcurar do legado, Registro 59+). Aberto por
1524:     * BtnProcurarClick (botao Procurar do CommandGroup principal).
1525:     *==========================================================================
1526:     PROTECTED PROCEDURE ConfigurarProcurar()
1527:         LOCAL loc_oErro
1528: 
1529:         TRY
1530:             THIS.AddObject("cnt_4c_Procurar", "Container")
1531:             WITH THIS.cnt_4c_Procurar
1532:                 .Top           = 284
1533:                 .Left          = 240
1534:                 .Width         = 314
1535:                 .Height        = 218
1536:                 .SpecialEffect = 0
1537:                 .Enabled       = .F.
1538:                 .Visible       = .F.
1539:                 .BackColor     = RGB(255, 255, 255)
1540:             ENDWITH
1541: 
1542:             THIS.cnt_4c_Procurar.AddObject("lbl_4c_Label1", "Label")
1543:             WITH THIS.cnt_4c_Procurar.lbl_4c_Label1
1544:                 .AutoSize  = .T.
1545:                 .FontBold  = .T.
1546:                 .FontName  = "Tahoma"
1547:                 .FontSize  = 9
1548:                 .BackStyle = 0
1549:                 .Caption   = "Procurar"
1550:                 .Left      = 12
1551:                 .Top       = 8
1552:                 .ForeColor = RGB(90, 90, 90)
1553:                 .Visible   = .T.
1554:             ENDWITH
1555: 
1556:             THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblBanco", "Label")
1557:             WITH THIS.cnt_4c_Procurar.lbl_4c_LblBanco
1558:                 .FontName  = "Tahoma"
1559:                 .FontSize  = 8
1560:                 .Alignment = 0
1561:                 .BackStyle = 0
1562:                 .Caption   = "Banco :"
1563:                 .Left      = 36
1564:                 .Top       = 139
1565:                 .Width     = 38
1566:                 .Height    = 15

*-- Linhas 1786 a 1844:
1786:                 .Themes          = .F.
1787:             ENDWITH
1788: 
1789:             BINDEVENT(THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar, "Click", THIS, "CmdgprocurarClick")
1790:             BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Banco, "KeyPress", THIS, "TxtProcurarBancoKeyPress")
1791:         CATCH TO loc_oErro
1792:             MsgErro(loc_oErro.Message + CHR(13) + ;
1793:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1794:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarProcurar")
1795:         ENDTRY
1796:     ENDPROC
1797: 
1798:     *==========================================================================
1799:     * ConfigurarImpressaoManual - Painel de impressao matricial manual por
1800:     * Banco + faixa de cheques (cnt_4c_Impchmat = impchmat do legado,
1801:     * Registro 50+). Aberto por BtnChMatClick quando nao ha cheque marcado
1802:     * na grade.
1803:     *==========================================================================
1804:     PROTECTED PROCEDURE ConfigurarImpressaoManual()
1805:         LOCAL loc_oErro
1806: 
1807:         TRY
1808:             THIS.AddObject("cnt_4c_Impchmat", "Container")
1809:             WITH THIS.cnt_4c_Impchmat
1810:                 .Top           = 284
1811:                 .Left          = 240
1812:                 .Width         = 314
1813:                 .Height        = 218
1814:                 .SpecialEffect = 0
1815:                 .Enabled       = .F.
1816:                 .Visible       = .F.
1817:                 .BackColor     = RGB(255, 255, 255)
1818:             ENDWITH
1819: 
1820:             THIS.cnt_4c_Impchmat.AddObject("lbl_4c_Label1", "Label")
1821:             WITH THIS.cnt_4c_Impchmat.lbl_4c_Label1
1822:                 .AutoSize  = .T.
1823:                 .FontBold  = .T.
1824:                 .FontName  = "Tahoma"
1825:                 .BackStyle = 0
1826:                 .Caption   = "Impress" + CHR(227) + "o"
1827:                 .Left      = 12
1828:                 .Top       = 8
1829:                 .ForeColor = RGB(90, 90, 90)
1830:                 .Visible   = .T.
1831:             ENDWITH
1832: 
1833:             THIS.cnt_4c_Impchmat.AddObject("lbl_4c_LblBanco", "Label")
1834:             WITH THIS.cnt_4c_Impchmat.lbl_4c_LblBanco
1835:                 .FontName  = "Tahoma"
1836:                 .FontSize  = 8
1837:                 .Alignment = 0
1838:                 .BackStyle = 0
1839:                 .Caption   = "Banco :"
1840:                 .Left      = 66
1841:                 .Top       = 157
1842:                 .Width     = 38
1843:                 .Height    = 15
1844:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1971 a 2139:
1971:                 .Themes          = .F.
1972:             ENDWITH
1973: 
1974:             BINDEVENT(THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar, "Click", THIS, "CmdGprocurarImpChmatClick")
1975:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini, "KeyPress", THIS, "TxtChiniKeyPress")
1976:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin, "KeyPress", THIS, "TxtChfinKeyPress")
1977:         CATCH TO loc_oErro
1978:             MsgErro(loc_oErro.Message + CHR(13) + ;
1979:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1980:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImpressaoManual")
1981:         ENDTRY
1982:     ENDPROC
1983: 
1984:     *==========================================================================
1985:     * TxtCdGruposGotFocus / TxtDsGruposGotFocus / TxtCdContasGotFocus /
1986:     * TxtDsContasGotFocus / TxtDtInicialGotFocus / TxtDtFinalGotFocus -
1987:     * Equivalente ao evento When do legado: guarda o valor corrente do campo
1988:     * ANTES da edicao (AntCdGrupo/AntDsGrupo/AntCdConta/AntDsConta/AntDtIni/
1989:     * AntDtFin), para o KeyPress-Valid comparar depois e decidir se limpa a
1990:     * grade. PUBLIC - BINDEVENT so dispara metodos PUBLIC.
1991:     *==========================================================================
1992:     PROCEDURE TxtCdGruposGotFocus()
1993:         THIS.this_oBusinessObject.this_cAntCodGrupo = THIS.txt_4c_CdGrupos.Value
1994:     ENDPROC
1995: 
1996:     PROCEDURE TxtDsGruposGotFocus()
1997:         THIS.this_oBusinessObject.this_cAntDescGrupo = THIS.txt_4c_DsGrupos.Value
1998:     ENDPROC
1999: 
2000:     PROCEDURE TxtCdContasGotFocus()
2001:         THIS.this_oBusinessObject.this_cAntCodConta = THIS.txt_4c_CdContas.Value
2002:     ENDPROC
2003: 
2004:     PROCEDURE TxtDsContasGotFocus()
2005:         THIS.this_oBusinessObject.this_cAntDescConta = THIS.txt_4c_DsContas.Value
2006:     ENDPROC
2007: 
2008:     PROCEDURE TxtDtInicialGotFocus()
2009:         THIS.this_oBusinessObject.this_dAntDataInicial = THIS.txt_4c_Dt_inicial.Value
2010:     ENDPROC
2011: 
2012:     PROCEDURE TxtDtFinalGotFocus()
2013:         THIS.this_oBusinessObject.this_dAntDataFinal = THIS.txt_4c_Dt_final.Value
2014:     ENDPROC
2015: 
2016:     *==========================================================================
2017:     * LimparChequesSeFiltroMudou - Equivalente ao "If Used('CsSigCqChi') / Zap
2018:     * In CsSigCqChi / ThisForm.GrdCCheques.Refresh" repetido em TODOS os Valid
2019:     * de filtro do legado: some com a grade quando o usuario altera Grupo/
2020:     * Conta/Periodo, para nao exibir resultado desatualizado ate clicar
2021:     * Processar. ZAP exige SAFETY OFF (config.prg so seta SET EXACT ON - a
2022:     * mesma ressalva de MontaGrade acima).
2023:     *==========================================================================
2024:     PROTECTED PROCEDURE LimparChequesSeFiltroMudou()
2025:         LOCAL loc_cCursor, loc_cSafety
2026: 
2027:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2028: 
2029:         IF USED(loc_cCursor)
2030:             loc_cSafety = SET("Safety")
2031:             SET SAFETY OFF
2032: 
2033:             SELECT (loc_cCursor)
2034:             ZAP
2035: 
2036:             IF loc_cSafety == "ON"
2037:                 SET SAFETY ON
2038:             ENDIF
2039: 
2040:             THIS.grd_4c_Dados.Refresh()
2041:         ENDIF
2042:     ENDPROC
2043: 
2044:     *==========================================================================
2045:     * ValidarCdGruposKeyPress / ValidarDsGruposKeyPress - Equivalente ao Valid
2046:     * de GetCdGrupos/GetDsGrupos do legado (fAcessoContab): F4 abre o picker
2047:     * (AbrirBuscaGrupo), Enter/Tab tenta o match EXATO contra SigCdGcr
2048:     * (Codigos/Descrs) e, sem match, abre o picker com o prefixo digitado. O
2049:     * campo Descricao replica o guard do When original (Return(Empty(
2050:     * GetCdGrupos.Value))) - so participa da busca quando o Codigo esta vazio.
2051:     *==========================================================================
2052:     PROCEDURE ValidarCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2053:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lMudou
2054: 
2055:         IF par_nKeyCode = 115  && F4
2056:             THIS.AbrirBuscaGrupo()
2057:             NODEFAULT
2058:             RETURN
2059:         ENDIF
2060: 
2061:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2062:             RETURN
2063:         ENDIF
2064: 
2065:         loc_cValor = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2066:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntCodGrupo)
2067: 
2068:         IF EMPTY(loc_cValor)
2069:             THIS.txt_4c_DsGrupos.Value = ""
2070:         ELSE
2071:             IF USED("cursor_4c_BuscaGrupo")
2072:                 USE IN cursor_4c_BuscaGrupo
2073:             ENDIF
2074: 
2075:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cValor)
2076:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2077: 
2078:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2079:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2080:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2081: 
2082:                 IF USED("cursor_4c_BuscaGrupo")
2083:                     USE IN cursor_4c_BuscaGrupo
2084:                 ENDIF
2085:             ELSE
2086:                 IF USED("cursor_4c_BuscaGrupo")
2087:                     USE IN cursor_4c_BuscaGrupo
2088:                 ENDIF
2089:                 THIS.AbrirBuscaGrupo()
2090:                 RETURN
2091:             ENDIF
2092:         ENDIF
2093: 
2094:         IF loc_lMudou
2095:             THIS.LimparChequesSeFiltroMudou()
2096:         ENDIF
2097:     ENDPROC
2098: 
2099:     PROCEDURE ValidarDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2100:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lMudou
2101: 
2102:         IF par_nKeyCode = 115  && F4
2103:             THIS.AbrirBuscaGrupo()
2104:             NODEFAULT
2105:             RETURN
2106:         ENDIF
2107: 
2108:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2109:             RETURN
2110:         ENDIF
2111: 
2112:         *-- Legado: GetDsGrupos.When = Return(Empty(GetCdGrupos.Value)) - o
2113:         *-- campo Descricao so participa da busca quando o Codigo esta vazio.
2114:         IF !EMPTY(THIS.txt_4c_CdGrupos.Value)
2115:             RETURN
2116:         ENDIF
2117: 
2118:         loc_cValor = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2119:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntDescGrupo)
2120: 
2121:         IF EMPTY(loc_cValor)
2122:             THIS.txt_4c_CdGrupos.Value = ""
2123:         ELSE
2124:             IF USED("cursor_4c_BuscaGrupo")
2125:                 USE IN cursor_4c_BuscaGrupo
2126:             ENDIF
2127: 
2128:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cValor)
2129:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2130: 
2131:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2132:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2133:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2134: 
2135:                 IF USED("cursor_4c_BuscaGrupo")
2136:                     USE IN cursor_4c_BuscaGrupo
2137:                 ENDIF
2138:             ELSE
2139:                 IF USED("cursor_4c_BuscaGrupo")

*-- Linhas 2157 a 2249:
2157:     * memoria feedback_facessocontas_lookup_ux.md); aqui o filtro eh o
2158:     * prefixo ja digitado, igual ao padrao Pattern A do projeto.
2159:     *==========================================================================
2160:     PROTECTED PROCEDURE AbrirBuscaGrupo()
2161:         LOCAL loc_oBusca, loc_cSQL, loc_cFiltro, loc_nResultado
2162: 
2163:         loc_cFiltro = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2164:         IF EMPTY(loc_cFiltro)
2165:             loc_cFiltro = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2166:         ENDIF
2167: 
2168:         IF USED("cursor_4c_BuscaGrupo")
2169:             USE IN cursor_4c_BuscaGrupo
2170:         ENDIF
2171: 
2172:         IF !EMPTY(loc_cFiltro)
2173:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE " + ;
2174:                 "codigos LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2175:                 " OR descrs LIKE " + EscaparSQL(loc_cFiltro + "%") + " ORDER BY codigos"
2176:         ELSE
2177:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
2178:         ENDIF
2179: 
2180:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2181: 
2182:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2183:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2184:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "codigos", "descrs", ;
2185:                 "Grupo de Contas")
2186: 
2187:             IF loc_oBusca.Mostrar()
2188:                 THIS.txt_4c_CdGrupos.Value = loc_oBusca.cCodigoSelecionado
2189:                 THIS.txt_4c_DsGrupos.Value = loc_oBusca.cDescricaoSelecionada
2190:                 THIS.LimparChequesSeFiltroMudou()
2191:             ENDIF
2192: 
2193:             loc_oBusca.Release()
2194:         ENDIF
2195: 
2196:         IF USED("cursor_4c_BuscaGrupo")
2197:             USE IN cursor_4c_BuscaGrupo
2198:         ENDIF
2199:     ENDPROC
2200: 
2201:     *==========================================================================
2202:     * ValidarCdContasKeyPress / ValidarDsContasKeyPress - Equivalente ao Valid
2203:     * de getCdContas/getDsContas do legado (fAcessoContas): F4 abre o picker
2204:     * (AbrirBuscaConta), Enter/Tab tenta o match EXATO contra SigCdCli
2205:     * (Iclis/Rclis) filtrado pelo Grupo corrente, e sem match abre o picker
2206:     * com o prefixo digitado. getDsContas replica o guard do When original
2207:     * (Return(Empty(GetCdContas.Value))).
2208:     *==========================================================================
2209:     PROCEDURE ValidarCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2210:         LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_lMudou
2211: 
2212:         IF par_nKeyCode = 115  && F4
2213:             THIS.AbrirBuscaConta()
2214:             NODEFAULT
2215:             RETURN
2216:         ENDIF
2217: 
2218:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2219:             RETURN
2220:         ENDIF
2221: 
2222:         loc_cValor = ALLTRIM(THIS.txt_4c_CdContas.Value)
2223:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntCodConta)
2224: 
2225:         IF EMPTY(loc_cValor)
2226:             THIS.txt_4c_DsContas.Value = ""
2227:         ELSE
2228:             loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2229: 
2230:             IF USED("cursor_4c_BuscaConta")
2231:                 USE IN cursor_4c_BuscaConta
2232:             ENDIF
2233: 
2234:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
2235:             IF !EMPTY(loc_cGrupo)
2236:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2237:             ENDIF
2238: 
2239:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2240: 
2241:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2242:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2243:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2244: 
2245:                 IF USED("cursor_4c_BuscaConta")
2246:                     USE IN cursor_4c_BuscaConta
2247:                 ENDIF
2248:             ELSE
2249:                 IF USED("cursor_4c_BuscaConta")

*-- Linhas 2259 a 2302:
2259:         ENDIF
2260:     ENDPROC
2261: 
2262:     PROCEDURE ValidarDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2263:         LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_lMudou
2264: 
2265:         IF par_nKeyCode = 115  && F4
2266:             THIS.AbrirBuscaConta()
2267:             NODEFAULT
2268:             RETURN
2269:         ENDIF
2270: 
2271:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2272:             RETURN
2273:         ENDIF
2274: 
2275:         *-- Legado: getDsContas.When = Return(Empty(GetCdContas.Value))
2276:         IF !EMPTY(THIS.txt_4c_CdContas.Value)
2277:             RETURN
2278:         ENDIF
2279: 
2280:         loc_cValor = ALLTRIM(THIS.txt_4c_DsContas.Value)
2281:         loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntDescConta)
2282: 
2283:         IF EMPTY(loc_cValor)
2284:             THIS.txt_4c_CdContas.Value = ""
2285:         ELSE
2286:             loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2287: 
2288:             IF USED("cursor_4c_BuscaConta")
2289:                 USE IN cursor_4c_BuscaConta
2290:             ENDIF
2291: 
2292:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE RTRIM(rclis) = " + EscaparSQL(loc_cValor)
2293:             IF !EMPTY(loc_cGrupo)
2294:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2295:             ENDIF
2296: 
2297:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2298: 
2299:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2300:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2301:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2302: 

*-- Linhas 2324 a 2471:
2324:     * lookup UX (memoria feedback_facessocontas_lookup_ux.md: auto-carrega o
2325:     * primeiro registro do LIKE sem selecao do usuario).
2326:     *==========================================================================
2327:     PROTECTED PROCEDURE AbrirBuscaConta()
2328:         LOCAL loc_oBusca, loc_cSQL, loc_cFiltro, loc_cGrupo, loc_nResultado
2329: 
2330:         loc_cFiltro = ALLTRIM(THIS.txt_4c_CdContas.Value)
2331:         IF EMPTY(loc_cFiltro)
2332:             loc_cFiltro = ALLTRIM(THIS.txt_4c_DsContas.Value)
2333:         ENDIF
2334: 
2335:         loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2336: 
2337:         IF USED("cursor_4c_BuscaConta")
2338:             USE IN cursor_4c_BuscaConta
2339:         ENDIF
2340: 
2341:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE 1 = 1 "
2342: 
2343:         IF !EMPTY(loc_cGrupo)
2344:             loc_cSQL = loc_cSQL + "AND grupos = " + EscaparSQL(loc_cGrupo) + " "
2345:         ENDIF
2346: 
2347:         IF !EMPTY(loc_cFiltro)
2348:             loc_cSQL = loc_cSQL + "AND (iclis LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2349:                 " OR RTRIM(rclis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ") "
2350:         ENDIF
2351: 
2352:         loc_cSQL = loc_cSQL + "ORDER BY iclis"
2353: 
2354:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2355: 
2356:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2357:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2358:             loc_oBusca.DefinirCursor("cursor_4c_BuscaConta", "iclis", "rclis", "Contas")
2359: 
2360:             IF loc_oBusca.Mostrar()
2361:                 THIS.txt_4c_CdContas.Value = loc_oBusca.cCodigoSelecionado
2362:                 THIS.txt_4c_DsContas.Value = loc_oBusca.cDescricaoSelecionada
2363:                 THIS.LimparChequesSeFiltroMudou()
2364:             ENDIF
2365: 
2366:             loc_oBusca.Release()
2367:         ENDIF
2368: 
2369:         IF USED("cursor_4c_BuscaConta")
2370:             USE IN cursor_4c_BuscaConta
2371:         ENDIF
2372:     ENDPROC
2373: 
2374:     *==========================================================================
2375:     * ValidarDtInicialKeyPress / ValidarDtFinalKeyPress - Equivalente ao Valid
2376:     * de Dt_inicial/Dt_final do legado: mantem Data Inicial <= Data Final
2377:     * empurrando a outra ponta do periodo (mesma logica do SCX original), e
2378:     * limpa a grade quando o valor mudou desde que o campo recebeu foco.
2379:     *==========================================================================
2380:     PROCEDURE ValidarDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2381:         LOCAL loc_lMudou
2382: 
2383:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2384:             RETURN
2385:         ENDIF
2386: 
2387:         *-- Legado: If This.Value > Dt_Final.Value -> Dt_Final.Value = This.Value
2388:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2389:             THIS.txt_4c_Dt_final.Value = THIS.txt_4c_Dt_inicial.Value
2390:         ENDIF
2391: 
2392:         loc_lMudou = THIS.txt_4c_Dt_inicial.Value != THIS.this_oBusinessObject.this_dAntDataInicial
2393: 
2394:         IF loc_lMudou
2395:             THIS.LimparChequesSeFiltroMudou()
2396:         ENDIF
2397:     ENDPROC
2398: 
2399:     PROCEDURE ValidarDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2400:         LOCAL loc_lMudou
2401: 
2402:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2403:             RETURN
2404:         ENDIF
2405: 
2406:         *-- Legado: If This.Value < Dt_Inicial.Value -> Dt_Inicial.Value = This.Value
2407:         IF THIS.txt_4c_Dt_final.Value < THIS.txt_4c_Dt_inicial.Value
2408:             THIS.txt_4c_Dt_inicial.Value = THIS.txt_4c_Dt_final.Value
2409:         ENDIF
2410: 
2411:         loc_lMudou = THIS.txt_4c_Dt_final.Value != THIS.this_oBusinessObject.this_dAntDataFinal
2412: 
2413:         IF loc_lMudou
2414:             THIS.LimparChequesSeFiltroMudou()
2415:         ENDIF
2416:     ENDPROC
2417: 
2418:     *==========================================================================
2419:     * BtnProcessarClick - Command2.Click ("Processar") do legado: valida o
2420:     * periodo, sincroniza os filtros para o BO e recarrega a grade.
2421:     *
2422:     * O guard "so recarrega se algum filtro mudou OU eh a primeira exibicao"
2423:     * eh transcrito como esta: as condicoes que CERCAM a validacao fazem parte
2424:     * da regra (CLAUDE.md #21b). Os valores Ant* sao atualizados pelos eventos
2425:     * When dos proprios campos de filtro (fase de filtros), NAO aqui - no
2426:     * legado quem grava AntDtIni/AntCdConta eh o When de cada TextBox.
2427:     *
2428:     * As tres validacoes de Grupo/Conta obrigatorios que existem no legado
2429:     * estao COMENTADAS no legado (*!*) - portanto aposentadas, e NAO migradas.
2430:     *==========================================================================
2431:     PROCEDURE BtnProcessarClick()
2432:         LOCAL loc_dIni, loc_dFim, loc_cGrupo, loc_cConta, loc_lRecarregar
2433:         LOCAL loc_oBO
2434: 
2435:         loc_oBO = THIS.this_oBusinessObject
2436: 
2437:         loc_dIni   = THIS.ObterFiltroDataInicial()
2438:         loc_dFim   = THIS.ObterFiltroDataFinal()
2439:         loc_cGrupo = THIS.ObterFiltroGrupo()
2440:         loc_cConta = THIS.ObterFiltroConta()
2441: 
2442:         *-- Legado: If Dt_Inicial.Value > Dt_Final.Value -> erro + SetFocus
2443:         IF loc_dIni > loc_dFim
2444:             MsgErro("Data Final menor que Data Inicial !!!", ;
2445:                 "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
2446: 
2447:             IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
2448:                 THIS.txt_4c_Dt_inicial.SetFocus()
2449:             ENDIF
2450: 
2451:             RETURN
2452:         ENDIF
2453: 
2454:         *-- Legado: AntDtIni # Dt_Inicial Or AntDtFin # Dt_Final Or
2455:         *--         AntCdGrupo # getCdGrupos Or AntCdConta # getCdContas Or Inicial
2456:         loc_lRecarregar = ;
2457:             loc_oBO.this_dAntDataInicial != loc_dIni   OR ;
2458:             loc_oBO.this_dAntDataFinal   != loc_dFim   OR ;
2459:             ALLTRIM(loc_oBO.this_cAntCodGrupo) != ALLTRIM(loc_cGrupo) OR ;
2460:             ALLTRIM(loc_oBO.this_cAntCodConta) != ALLTRIM(loc_cConta) OR ;
2461:             loc_oBO.this_lPrimeiraExibicao
2462: 
2463:         IF loc_lRecarregar
2464:             *-- CarregarLista eh o FUNIL da carga: sincroniza os filtros da
2465:             *-- tela para o BO (FormParaBO - fonte unica da consulta), garante
2466:             *-- o cursor da grade e chama MontaGrade, que ja reporta a falha
2467:             *-- (mensagem unica - CLAUDE.md regra #20).
2468:             IF !THIS.CarregarLista(.F.)
2469:                 RETURN
2470:             ENDIF
2471:         ELSE

*-- Linhas 2518 a 2841:
2518:     *==========================================================================
2519:     * CmdGokClick - Dispatcher do CommandGroup de acoes (obj_4c_CmdGok),
2520:     * replicando o padrao 1-metodo-por-botao do cmdGok legado via
2521:     * DO CASE(THIS.Value). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
2522:     *==========================================================================
2523:     PROCEDURE CmdGokClick()
2524:         DO CASE
2525:             CASE THIS.obj_4c_CmdGok.Value = 1
2526:                 THIS.BtnDocumentoClick()
2527:             CASE THIS.obj_4c_CmdGok.Value = 2
2528:                 THIS.BtnSairClick()
2529:             CASE THIS.obj_4c_CmdGok.Value = 3
2530:                 THIS.BtnImprimirClick()
2531:             CASE THIS.obj_4c_CmdGok.Value = 4
2532:                 THIS.BtnProcurarClick()
2533:             CASE THIS.obj_4c_CmdGok.Value = 5
2534:                 THIS.BtnReciboClick()
2535:             CASE THIS.obj_4c_CmdGok.Value = 6
2536:                 THIS.BtnExcluiDocClick()
2537:             CASE THIS.obj_4c_CmdGok.Value = 7
2538:                 THIS.BtnImpChqClick()
2539:             CASE THIS.obj_4c_CmdGok.Value = 8
2540:                 THIS.BtnChMatClick()
2541:             CASE THIS.obj_4c_CmdGok.Value = 9
2542:                 THIS.BtnExcluirChqClick()
2543:         ENDCASE
2544:     ENDPROC
2545: 
2546:     *==========================================================================
2547:     * BtnSairClick - Encerrar (cmdSair.Click do legado). Fecha os cursores
2548:     * auxiliares de contas e libera o form.
2549:     *==========================================================================
2550:     PROCEDURE BtnSairClick()
2551:         IF USED(THIS.this_oBusinessObject.this_cCursorContas)
2552:             USE IN (THIS.this_oBusinessObject.this_cCursorContas)
2553:         ENDIF
2554: 
2555:         THIS.Release()
2556:     ENDPROC
2557: 
2558:     *==========================================================================
2559:     * BtnExcluirChqClick - Excluir Chq. (btnExcluirChq.Click do legado). So
2560:     * confirma e delega ao BusinessObject.Excluir() - AntesDeExcluir() ja
2561:     * replica o guard do legado (ncancelas=1 AND ExcluirCheque) e a falha eh
2562:     * reportada sozinha pelo BusinessBase (CLAUDE.md regra #20).
2563:     *
2564:     * CarregarDoCursor() (SigPrChrBO) le as colunas RAW de SigCqChi
2565:     * (cancelas/emitidos/grupos/vencs/versos/empdopnums/impversos) - nomes
2566:     * que NAO existem em cursor_4c_Cheques (a grade tem so nemitidos/
2567:     * ncancelas convertidos via CASE WHEN, sem grupos/vencs/versos/
2568:     * empdopnums/impversos). Passar o cursor da grade direto estouraria
2569:     * "Variable 'CANCELAS' is not found." Por isso o cheque corrente eh
2570:     * relido com SELECT * FROM SigCqChi (mesmas colunas que CarregarDoCursor
2571:     * espera), pela PK cidchaves.
2572:     *==========================================================================
2573:     PROCEDURE BtnExcluirChqClick()
2574:         LOCAL loc_cCursor, loc_cCidchaves, loc_cSQL, loc_nResultado, loc_cMensagem
2575: 
2576:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2577: 
2578:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2579:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2580:             RETURN
2581:         ENDIF
2582: 
2583:         loc_cCidchaves = EVALUATE(loc_cCursor + ".cidchaves")
2584: 
2585:         IF USED("cursor_4c_ChequeAtual")
2586:             USE IN cursor_4c_ChequeAtual
2587:         ENDIF
2588: 
2589:         loc_cSQL = "SELECT * FROM SigCqChi WHERE cidchaves = " + EscaparSQL(loc_cCidchaves)
2590:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequeAtual")
2591: 
2592:         IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_ChequeAtual") = 0
2593:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o cheque para exclus" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
2594:             IF USED("cursor_4c_ChequeAtual")
2595:                 USE IN cursor_4c_ChequeAtual
2596:             ENDIF
2597:             RETURN
2598:         ENDIF
2599: 
2600:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ChequeAtual")
2601: 
2602:         IF USED("cursor_4c_ChequeAtual")
2603:             USE IN cursor_4c_ChequeAtual
2604:         ENDIF
2605: 
2606:         loc_cMensagem = "Deseja realmente excluir o cheque :" + CHR(13) + ;
2607:             ALLTRIM(THIS.this_oBusinessObject.this_cBancos)   + " / " + ;
2608:             ALLTRIM(THIS.this_oBusinessObject.this_cAgencias) + " / " + ;
2609:             ALLTRIM(THIS.this_oBusinessObject.this_cNcontas)  + " / " + ;
2610:             ALLTRIM(THIS.this_oBusinessObject.this_cNcheques) + " ?"
2611: 
2612:         IF MsgConfirma(loc_cMensagem, "Exclus" + CHR(227) + "o de cheque cancelado")
2613:             IF THIS.this_oBusinessObject.Excluir()
2614:                 SELECT (loc_cCursor)
2615:                 DELETE
2616:                 THIS.grd_4c_Dados.Refresh()
2617:             ENDIF
2618:         ENDIF
2619:     ENDPROC
2620: 
2621:     *==========================================================================
2622:     * BtnMarcarTudoClick / BtnDesmarcarTudoClick - cmdTudo1.Click /
2623:     * cmdApaga1.Click do legado (marca/desmarca em massa a coluna Imprime).
2624:     *==========================================================================
2625:     PROCEDURE BtnMarcarTudoClick()
2626:         LOCAL loc_cCursor, loc_nRecno
2627: 
2628:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2629: 
2630:         IF USED(loc_cCursor)
2631:             loc_nRecno = RECNO(loc_cCursor)
2632:             UPDATE (loc_cCursor) SET nmarca1s = 1 WHERE nmarca1s = 0 AND nemitidos = 0 AND ncancelas = 0
2633: 
2634:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2635:                 SELECT (loc_cCursor)
2636:                 GOTO loc_nRecno
2637:             ENDIF
2638: 
2639:             THIS.grd_4c_Dados.Refresh()
2640:         ENDIF
2641:     ENDPROC
2642: 
2643:     PROCEDURE BtnDesmarcarTudoClick()
2644:         LOCAL loc_cCursor, loc_nRecno
2645: 
2646:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2647: 
2648:         IF USED(loc_cCursor)
2649:             loc_nRecno = RECNO(loc_cCursor)
2650:             UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
2651: 
2652:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2653:                 SELECT (loc_cCursor)
2654:                 GOTO loc_nRecno
2655:             ENDIF
2656: 
2657:             THIS.grd_4c_Dados.Refresh()
2658:         ENDIF
2659:     ENDPROC
2660: 
2661:     *==========================================================================
2662:     * BtnImprimirClick - Imprimir (cmdImprimir.Click do legado): abre
2663:     * FormSigReEch (Emissao de Cheque, ja migrado) no modo CONSULTAR para o
2664:     * cheque selecionado na grade - mesmos parametros do "Do Form SigReEch
2665:     * With emps,dopes,numes,'CONSULTAR',ncheques" original.
2666:     *==========================================================================
2667:     PROCEDURE BtnImprimirClick()
2668:         LOCAL loc_cCursor, loc_oForm, loc_oErro
2669: 
2670:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2671: 
2672:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2673:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2674:             RETURN
2675:         ENDIF
2676: 
2677:         loc_oForm = .NULL.
2678:         SELECT (loc_cCursor)
2679: 
2680:         TRY
2681:             loc_oForm = CREATEOBJECT("FormSigReEch", emps, dopes, numes, "CONSULTAR", ncheques)
2682:         CATCH TO loc_oErro
2683:             MsgErro(loc_oErro.Message, "Erro ao abrir emiss" + CHR(227) + "o de cheque")
2684:             loc_oForm = .NULL.
2685:         ENDTRY
2686: 
2687:         IF VARTYPE(loc_oForm) = "O"
2688:             loc_oForm.Show()
2689:         ENDIF
2690:     ENDPROC
2691: 
2692:     *==========================================================================
2693:     * BtnDocumentoClick - Documento (cmdDocumento.Click do legado): confere
2694:     * se existe lancamento de pagamento para o EmpDopNums do cheque
2695:     * selecionado (mesmo guard do "CursorQuery('SigCdPgr',,'empdopnums',...)"
2696:     * original) e, se existir, abre o cadastro correspondente (Formpgr, ja
2697:     * migrado - SIGCDPGR.SCX). Sem lancamento, nao faz nada (mesmo
2698:     * comportamento do Else do legado).
2699:     *==========================================================================
2700:     PROCEDURE BtnDocumentoClick()
2701:         LOCAL loc_cCursor, loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro
2702: 
2703:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2704: 
2705:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2706:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2707:             RETURN
2708:         ENDIF
2709: 
2710:         SELECT (loc_cCursor)
2711:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
2712: 
2713:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
2714:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
2715: 
2716:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
2717:             loc_oForm = .NULL.
2718:             TRY
2719:                 loc_oForm = CREATEOBJECT("Formpgr")
2720:             CATCH TO loc_oErro
2721:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
2722:                 loc_oForm = .NULL.
2723:             ENDTRY
2724: 
2725:             IF VARTYPE(loc_oForm) = "O"
2726:                 loc_oForm.Show()
2727:             ENDIF
2728:         ENDIF
2729: 
2730:         IF USED("cursor_4c_VerificaPgr")
2731:             USE IN cursor_4c_VerificaPgr
2732:         ENDIF
2733:     ENDPROC
2734: 
2735:     *==========================================================================
2736:     * BtnProcurarClick - Procurar (cmdProcurar.Click do legado): ABRE o
2737:     * painel de busca de cheque por Banco/Agencia/Conta/Cheque/Emissao/Valor
2738:     * ou leitor de codigo de barras (cnt_4c_Procurar) - NAO eh toggle: o
2739:     * legado ("ThisForm.plInicio = .T. / ThisForm.CntProcurar.Init") sempre
2740:     * abre, e o fechamento vem so pelos botoes Procurar/Cancelar do painel
2741:     * (FecharPainelProcurar). Desabilita os demais controles da tela
2742:     * enquanto o painel esta aberto, como o legado faz.
2743:     *==========================================================================
2744:     PROCEDURE BtnProcurarClick()
2745:         IF !PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
2746:             RETURN
2747:         ENDIF
2748: 
2749:         THIS.LockScreen = .T.
2750: 
2751:         *-- Legado (cntProcurar.Init): desliga Conta/Descricao da conta/grade/
2752:         *-- Favorecido/CmdGOk e mostra o painel. O conjunto exato vive em
2753:         *-- AjustarBotoesPorModo/HabilitarCampos, que tambem eh o funil de
2754:         *-- VOLTA (FecharPainelProcurar) - CLAUDE.md regra #40.
2755:         THIS.AjustarBotoesPorModo("PROCURAR")
2756: 
2757:         IF PEMSTATUS(THIS.cnt_4c_Procurar, "txt_4c_Banco", 5)
2758:             THIS.cnt_4c_Procurar.txt_4c_Banco.SetFocus()
2759:         ENDIF
2760: 
2761:         THIS.Refresh()
2762: 
2763:         THIS.LockScreen = .F.
2764:     ENDPROC
2765: 
2766:     *==========================================================================
2767:     * FecharPainelProcurar - Reabilita os controles desabilitados por
2768:     * BtnProcurarClick, oculta o painel e recarrega a exibicao (mExibeCheques
2769:     * (.F.) do legado - mesmo corpo nos dois botoes cmdprocurar/cmdCancelar
2770:     * de cntProcurar.cmdgprocurar, so a busca em si difere).
2771:     *==========================================================================
2772:     PROTECTED PROCEDURE FecharPainelProcurar()
2773:         *-- FUNIL de volta: reabilita o que "PROCURAR" desligou e oculta o
2774:         *-- painel (CLAUDE.md regra #40).
2775:         THIS.AjustarBotoesPorModo("LISTA")
2776: 
2777:         THIS.ExibirCheques(.F.)
2778:     ENDPROC
2779: 
2780:     *==========================================================================
2781:     * CmdgprocurarClick - Dispatcher do CommandGroup obj_4c_Cmdgprocurar
2782:     * (cntProcurar.cmdgprocurar do legado: Botao1=Procurar, Botao2=Cancelar).
2783:     * PUBLIC - BINDEVENT so dispara metodos PUBLIC.
2784:     *==========================================================================
2785:     PROCEDURE CmdgprocurarClick()
2786:         DO CASE
2787:             CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 1
2788:                 THIS.ProcurarChequeNoPainel()
2789:             CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2
2790:                 THIS.BtnCancelarClick("PROCURAR")
2791:         ENDCASE
2792:     ENDPROC
2793: 
2794:     *==========================================================================
2795:     * ProcurarChequeNoPainel - cmdprocurar.Click do legado: posiciona o
2796:     * cursor de cheques pelo primeiro campo preenchido (Emissao > Valor >
2797:     * Banco > Agencia > Conta > Cheque - mesma ordem/DO CASE do legado),
2798:     * usando SET NEAR ON (posiciona no registro mais proximo, mesmo sem
2799:     * achar exato) e fecha o painel.
2800:     *==========================================================================
2801:     PROCEDURE ProcurarChequeNoPainel()
2802:         LOCAL loc_cCursor, loc_cBanco, loc_cAgencia, loc_cConta, loc_cCheque
2803:         LOCAL loc_dEmissao, loc_nValor
2804: 
2805:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2806: 
2807:         IF !USED(loc_cCursor)
2808:             THIS.FecharPainelProcurar()
2809:             RETURN
2810:         ENDIF
2811: 
2812:         WITH THIS.cnt_4c_Procurar
2813:             loc_cBanco = PADR(ALLTRIM(.txt_4c_Banco.Value), 3)
2814:             .txt_4c_Banco.Value = loc_cBanco
2815:             loc_cAgencia = .txt_4c_Agencia.Value
2816:             loc_cConta   = .txt_4c_Conta.Value
2817:             loc_cCheque  = .txt_4c_Cheque.Value
2818:             loc_dEmissao = ConverterParaData(.txt_4c_Emissao.Value)
2819:             loc_nValor   = .txt_4c_Valor.Value
2820:             .Visible     = .T.
2821:         ENDWITH
2822: 
2823:         SELECT (loc_cCursor)
2824:         SET NEAR ON
2825: 
2826:         DO CASE
2827:             CASE !EMPTY(loc_dEmissao)
2828:                 SET ORDER TO Emissao
2829:                 SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2830:             CASE loc_nValor != 0
2831:                 SET ORDER TO Valor
2832:                 SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2833:             CASE !EMPTY(loc_cBanco)
2834:                 SET ORDER TO Cheque
2835:                 SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2836:             CASE !EMPTY(loc_cAgencia)
2837:                 SET ORDER TO Agencia
2838:                 SEEK loc_cAgencia + loc_cConta + loc_cCheque
2839:             CASE !EMPTY(loc_cConta)
2840:                 SET ORDER TO Conta
2841:                 SEEK loc_cConta + loc_cCheque

*-- Linhas 2854 a 3505:
2854:     * (cntProcurar.getBanco.KeyPress do legado): tecla 60 inicia a captura,
2855:     * 58 finaliza e decodifica a string lida em Banco/Agencia/Conta/Cheque.
2856:     * this_lLeitorChequeAtivo/this_cChequeLido (SigPrChrBO) sao os mesmos
2857:     * plLeCheque/pcChqLido do legado. PUBLIC - BINDEVENT so dispara metodos
2858:     * PUBLIC.
2859:     *==========================================================================
2860:     PROCEDURE TxtProcurarBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2861:         IF par_nKeyCode = 60
2862:             IF !THIS.this_oBusinessObject.this_lLeitorChequeAtivo
2863:                 THIS.this_oBusinessObject.this_cChequeLido = ""
2864:             ENDIF
2865:             THIS.this_oBusinessObject.this_lLeitorChequeAtivo = .T.
2866:         ENDIF
2867: 
2868:         IF THIS.this_oBusinessObject.this_lLeitorChequeAtivo
2869:             THIS.this_oBusinessObject.this_cChequeLido = ;
2870:                 THIS.this_oBusinessObject.this_cChequeLido + CHR(par_nKeyCode)
2871:             NODEFAULT
2872:         ENDIF
2873: 
2874:         IF par_nKeyCode = 58
2875:             THIS.ValidarLeitorChequeProcurar()
2876:             THIS.this_oBusinessObject.this_lLeitorChequeAtivo = .F.
2877:         ENDIF
2878:     ENDPROC
2879: 
2880:     *==========================================================================
2881:     * ValidarLeitorChequeProcurar - getBanco.Valid do legado (ramo do
2882:     * leitor): com >= 33 chars lidos, decodifica Banco/Agencia/Conta/Cheque
2883:     * pelas mesmas posicoes SUBSTR do legado e ja aciona a busca
2884:     * (This.Parent.CmdGProcurar.CmdProcurar.Click).
2885:     *==========================================================================
2886:     PROTECTED PROCEDURE ValidarLeitorChequeProcurar()
2887:         LOCAL loc_cLeitor
2888: 
2889:         loc_cLeitor = THIS.this_oBusinessObject.this_cChequeLido
2890: 
2891:         IF LEN(loc_cLeitor) >= 33
2892:             WITH THIS.cnt_4c_Procurar
2893:                 .txt_4c_Banco.Value   = SUBSTR(loc_cLeitor, 2, 3)
2894:                 .txt_4c_Agencia.Value = SUBSTR(loc_cLeitor, 5, 4)
2895:                 .txt_4c_Conta.Value   = SUBSTR(loc_cLeitor, 23, 10)
2896:                 .txt_4c_Cheque.Value  = SUBSTR(loc_cLeitor, 14, 6)
2897:                 .Visible     = .T.
2898:             ENDWITH
2899: 
2900:             THIS.Refresh()
2901:             THIS.ProcurarChequeNoPainel()
2902:         ENDIF
2903:     ENDPROC
2904: 
2905:     *==========================================================================
2906:     * BtnExcluiDocClick - Exclui Docto. (cmdExcluiDoc.Click do legado): abre
2907:     * o painel de justificativa do cancelamento (cnt_4c_justificativa,
2908:     * mapeamento.json). O painel eh criado na fase de containers flutuantes
2909:     * (Fase 6/7) - ate la, o guard PEMSTATUS abaixo mantem o botao
2910:     * inofensivo.
2911:     *==========================================================================
2912:     PROCEDURE BtnExcluiDocClick()
2913:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
2914:             *-- Modo JUSTIFICATIVA: mostra o painel (o legado nao desabilita
2915:             *-- nada da tela de fundo neste painel) e registra o modo corrente,
2916:             *-- que eh o que BtnCancelarClick/AjustarBotoesPorModo consultam
2917:             *-- quando chamados sem parametro.
2918:             THIS.AjustarBotoesPorModo("JUSTIFICATIVA")
2919: 
2920:             WITH THIS.cnt_4c_justificativa
2921:                 .Visible = .T.
2922: 
2923:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
2924:                     .obj_4c_Get_justificativa.Value    = ""
2925:                     .obj_4c_Get_justificativa.Width    = 238
2926:                     .obj_4c_Get_justificativa.ReadOnly = .F.
2927:                     .obj_4c_Get_justificativa.SetFocus()
2928:                 ENDIF
2929: 
2930:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
2931:                     .obj_4c_CmdGconf.Enabled = .T.
2932:                     .obj_4c_CmdGconf.Visible = .T.
2933:                 ENDIF
2934:             ENDWITH
2935:         ENDIF
2936:     ENDPROC
2937: 
2938:     *==========================================================================
2939:     * CmdGconfClick - Dispatcher do CommandGroup obj_4c_CmdGconf
2940:     * (cntjustificativa.cmdGconf do legado: Botao1=cmConfirmar,
2941:     * Botao2=cmdCancelar). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
2942:     *==========================================================================
2943:     PROCEDURE CmdGconfClick()
2944:         DO CASE
2945:             CASE THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 1
2946:                 THIS.ConfirmarCancelamentoDocumento()
2947:             CASE THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 2
2948:                 THIS.BtnCancelarClick("JUSTIFICATIVA")
2949:         ENDCASE
2950:     ENDPROC
2951: 
2952:     *==========================================================================
2953:     * CancelarJustificativa - cmdCancelar.Click do cmdGconf legado: fecha o
2954:     * painel sem gravar nada ("This.Parent.Enabled=.F. + This.Parent.Parent.
2955:     * Visible=.F.").
2956:     *==========================================================================
2957:     PROTECTED PROCEDURE CancelarJustificativa()
2958:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
2959:             IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
2960:                 THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Enabled = .F.
2961:             ENDIF
2962:             THIS.cnt_4c_justificativa.Visible = .F.
2963:         ENDIF
2964: 
2965:         *-- Volta ao modo de consulta. NAO passa por AjustarBotoesPorModo
2966:         *-- ("LISTA") de proposito: aquele ramo reafirma o painel pelo cheque
2967:         *-- corrente (AtualizarPainelChequeCorrente) e faria a justificativa
2968:         *-- reaparecer em somente leitura no mesmo instante, enquanto o
2969:         *-- cmdCancelar legado apenas oculta o painel e deixa assim ate a
2970:         *-- proxima troca de linha na grade. Nenhum controle foi desabilitado
2971:         *-- neste modo, entao nao ha o que reabilitar.
2972:         THIS.this_cModoAtual = "LISTA"
2973:     ENDPROC
2974: 
2975:     *==========================================================================
2976:     * ConfirmarCancelamentoDocumento - cmConfirmar.Click do legado: exige
2977:     * justificativa preenchida, confere se ha lancamento de pagamento para o
2978:     * EmpDopNums do cheque corrente (mesmo guard "CursorQuery('SigCdPgr',,
2979:     * 'empdopnums',...)" original) e abre o cadastro correspondente
2980:     * (Formpgr, ja migrado - SIGCDPGR.SCX) para o usuario dar seguimento ao
2981:     * cancelamento do documento.
2982:     *
2983:     * O legado passa a justificativa e um flag de cancelamento como
2984:     * parametros extras do "Do Form SigCdPgr With ...,.T.,ThisForm,
2985:     * Alltrim(get_justificativa.Value)", delegando a persistencia da
2986:     * justificativa/cancelamento (SigCqChi.cancelas/justcanc) para dentro do
2987:     * proprio modulo SigCdPgr. O Formpgr migrado (tarefa/task separada, sem
2988:     * parametros de Init) nao expoe esse modo parametrizado - mesma
2989:     * simplificacao ja adotada em BtnDocumentoClick (abre o cadastro padrao
2990:     * quando ha lancamento, sem repassar os parametros de cancelamento).
2991:     *==========================================================================
2992:     PROCEDURE ConfirmarCancelamentoDocumento()
2993:         LOCAL loc_cCursor, loc_cJustificativa, loc_cEmpDopNums, loc_cSQL
2994:         LOCAL loc_nResultado, loc_oForm, loc_oErro
2995: 
2996:         IF !PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
2997:             RETURN
2998:         ENDIF
2999: 
3000:         loc_cJustificativa = ALLTRIM(THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value)
3001: 
3002:         IF EMPTY(loc_cJustificativa)
3003:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
3004:             THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.SetFocus()
3005:             RETURN
3006:         ENDIF
3007: 
3008:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3009: 
3010:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
3011:             THIS.ExibirCheques(.T.)
3012:             RETURN
3013:         ENDIF
3014: 
3015:         SELECT (loc_cCursor)
3016:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
3017: 
3018:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
3019:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
3020: 
3021:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
3022:             loc_oForm = .NULL.
3023:             TRY
3024:                 loc_oForm = CREATEOBJECT("Formpgr")
3025:             CATCH TO loc_oErro
3026:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
3027:                 loc_oForm = .NULL.
3028:             ENDTRY
3029: 
3030:             IF VARTYPE(loc_oForm) = "O"
3031:                 loc_oForm.Show()
3032:             ENDIF
3033:         ENDIF
3034: 
3035:         IF USED("cursor_4c_VerificaPgr")
3036:             USE IN cursor_4c_VerificaPgr
3037:         ENDIF
3038: 
3039:         THIS.CancelarJustificativa()
3040:     ENDPROC
3041: 
3042:     *==========================================================================
3043:     * BtnReciboClick - Recibo (cmdRecibo.Click do legado): abre o form de
3044:     * emissao de recibo (SigRerec) para o cheque selecionado. FormSigRerec
3045:     * ainda nao foi migrado (SCX de outra task) - o TRY/CATCH reporta o
3046:     * problema real caso a classe nao exista, em vez de fingir sucesso.
3047:     *==========================================================================
3048:     PROCEDURE BtnReciboClick()
3049:         LOCAL loc_cCursor, loc_oForm, loc_oErro
3050: 
3051:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3052: 
3053:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
3054:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
3055:             RETURN
3056:         ENDIF
3057: 
3058:         loc_oForm = .NULL.
3059:         TRY
3060:             loc_oForm = CREATEOBJECT("FormSigRerec", THIS, "RECIBO")
3061:         CATCH TO loc_oErro
3062:             MsgErro("M" + CHR(243) + "dulo de recibo ainda n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + loc_oErro.Message, "Recibo")
3063:             loc_oForm = .NULL.
3064:         ENDTRY
3065: 
3066:         IF VARTYPE(loc_oForm) = "O"
3067:             loc_oForm.Show()
3068:         ENDIF
3069:     ENDPROC
3070: 
3071:     *==========================================================================
3072:     * BtnImpChqClick - Cheque (cmdImpchq.Click do legado): impressao do
3073:     * cheque em formulario continuo. O posicionamento fisico na folha do
3074:     * cheque (rotina de ~180 linhas do legado, com fValorExtenso() e
3075:     * fwBuscaInt() para escolher impressora - nenhuma das duas portada) fica
3076:     * para uma fase dedicada de impressao de cheques. Aqui: guard identico
3077:     * ao legado ("Nenhum Cheque Selecionado") e, apos o usuario confirmar
3078:     * que a impressao fisica foi feita, marca os cheques selecionados como
3079:     * emitidos (efeito de dados do botao, via BO).
3080:     *==========================================================================
3081:     PROCEDURE BtnImpChqClick()
3082:         LOCAL loc_cCursor, loc_nQtdMarcados
3083: 
3084:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3085: 
3086:         IF !USED(loc_cCursor)
3087:             RETURN
3088:         ENDIF
3089: 
3090:         SELECT (loc_cCursor)
3091:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3092: 
3093:         IF loc_nQtdMarcados = 0
3094:             MsgAviso("Nenhum Cheque Selecionado !!!", "Aten" + CHR(231) + CHR(227) + "o")
3095:             RETURN
3096:         ENDIF
3097: 
3098:         IF MsgConfirma("Confirma que " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s) selecionado(s) " + ;
3099:                 "j" + CHR(225) + " foram impressos na impressora de cheques?", "Impress" + CHR(227) + "o de Cheque")
3100:             IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
3101:                 THIS.grd_4c_Dados.Refresh()
3102:             ENDIF
3103:         ENDIF
3104:     ENDPROC
3105: 
3106:     *==========================================================================
3107:     * BtnChMatClick - Chq. Matric. (cmdchmat.Click do legado): impressao
3108:     * matricial via SigIpChq.prg (utilitario legado nao portado, faz o
3109:     * alinhamento interativo na impressora). Guard identico ao legado (todos
3110:     * os cheques marcados tem de ser do mesmo banco) e, apos confirmacao,
3111:     * marca como emitidos (mesmo criterio de BtnImpChqClick).
3112:     *==========================================================================
3113:     PROCEDURE BtnChMatClick()
3114:         LOCAL loc_cCursor, loc_nQtdMarcados, loc_cPrimeiroBanco, loc_lMesmoBanco
3115: 
3116:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3117: 
3118:         IF !USED(loc_cCursor)
3119:             RETURN
3120:         ENDIF
3121: 
3122:         SELECT (loc_cCursor)
3123:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3124: 
3125:         *-- Legado: sem cheque marcado (TmpChi vazio), o botao abre o painel
3126:         *-- de impressao manual (banco + faixa de cheques digitados), em vez
3127:         *-- de operar sobre a selecao da grade.
3128:         IF loc_nQtdMarcados = 0
3129:             THIS.AbrirImpressaoManualCheque()
3130:             RETURN
3131:         ENDIF
3132: 
3133:         loc_lMesmoBanco    = .T.
3134:         loc_cPrimeiroBanco = ""
3135: 
3136:         SELECT (loc_cCursor)
3137:         SCAN FOR nmarca1s = 1
3138:             IF EMPTY(loc_cPrimeiroBanco)
3139:                 loc_cPrimeiroBanco = bancos
3140:             ELSE
3141:                 IF bancos != loc_cPrimeiroBanco
3142:                     loc_lMesmoBanco = .F.
3143:                     EXIT
3144:                 ENDIF
3145:             ENDIF
3146:         ENDSCAN
3147: 
3148:         IF !loc_lMesmoBanco
3149:             MsgAviso("Todos os cheques selecionados devem ser do mesmo banco", "Aten" + CHR(231) + CHR(227) + "o")
3150:             RETURN
3151:         ENDIF
3152: 
3153:         IF MsgConfirma("Verifique se a impressora matricial est" + CHR(225) + " pronta." + CHR(13) + ;
3154:                 "Confirma a impress" + CHR(227) + "o de " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s)?", ;
3155:                 "Impress" + CHR(227) + "o Matricial")
3156:             IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
3157:                 THIS.grd_4c_Dados.Refresh()
3158:             ENDIF
3159:         ENDIF
3160:     ENDPROC
3161: 
3162:     *==========================================================================
3163:     * AbrirImpressaoManualCheque - impchmat.Init do legado (guardado por
3164:     * ThisForm.ChMatIni no original; aqui chamado direto pelo ramo "sem
3165:     * cheque marcado" de BtnChMatClick): limpa os campos, desabilita o
3166:     * CommandGroup principal e mostra o painel de impressao manual por
3167:     * Banco + faixa de cheques.
3168:     *==========================================================================
3169:     PROTECTED PROCEDURE AbrirImpressaoManualCheque()
3170:         IF !PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
3171:             RETURN
3172:         ENDIF
3173: 
3174:         THIS.LockScreen = .T.
3175: 
3176:         WITH THIS.cnt_4c_Impchmat
3177:             IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Banco", 5)
3178:                 .txt_4c_Banco.Value = ""
3179:             ENDIF
3180:             IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Chini", 5)
3181:                 .txt_4c_Chini.Value = ""
3182:             ENDIF
3183:             IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Chfin", 5)
3184:                 .txt_4c_Chfin.Value = ""
3185:             ENDIF
3186:             .Visible     = .T.
3187:         ENDWITH
3188: 
3189:         *-- Legado (impchmat.Init): desliga SO o CmdGOk e mostra o painel -
3190:         *-- Grupo/Conta/periodo/grade continuam acessiveis. O conjunto vive em
3191:         *-- AjustarBotoesPorModo, que tambem eh o funil de VOLTA
3192:         *-- (FecharImpressaoManualCheque) - CLAUDE.md regra #40.
3193:         THIS.AjustarBotoesPorModo("IMPCHMAT")
3194: 
3195:         IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Banco", 5)
3196:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
3197:         ENDIF
3198: 
3199:         THIS.Refresh()
3200: 
3201:         THIS.LockScreen = .F.
3202:     ENDPROC
3203: 
3204:     *==========================================================================
3205:     * FecharImpressaoManualCheque - cmdCancelar.Click de impchmat.cmdGprocurar
3206:     * do legado: reabilita o CommandGroup principal, oculta o painel e
3207:     * recarrega a exibicao (mExibeCheques(.F.)).
3208:     *==========================================================================
3209:     PROTECTED PROCEDURE FecharImpressaoManualCheque()
3210:         *-- FUNIL de volta: reabilita o CmdGOk que "IMPCHMAT" desligou e oculta
3211:         *-- o painel (CLAUDE.md regra #40).
3212:         THIS.AjustarBotoesPorModo("LISTA")
3213: 
3214:         THIS.ExibirCheques(.F.)
3215:     ENDPROC
3216: 
3217:     *==========================================================================
3218:     * CmdGprocurarImpChmatClick - Dispatcher do CommandGroup
3219:     * obj_4c_CmdGprocurar (impchmat.cmdGprocurar do legado: Botao1=cmdimpri,
3220:     * Botao2=cmdCancelar). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
3221:     *==========================================================================
3222:     PROCEDURE CmdGprocurarImpChmatClick()
3223:         DO CASE
3224:             CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 1
3225:                 THIS.ImprimirChequeManualClick()
3226:             CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2
3227:                 THIS.BtnCancelarClick("IMPCHMAT")
3228:         ENDCASE
3229:     ENDPROC
3230: 
3231:     *==========================================================================
3232:     * ImprimirChequeManualClick - cmdimpri.Click do impchmat.cmdGprocurar
3233:     * legado: valida Banco/faixa, filtra o cursor JA CARREGADO da grade
3234:     * (mesma fonte que o legado usa - "Select ... From CsSigCqChi Where
3235:     * bancos = ... And ncheques Between ... And ncancelas = 0", NAO uma nova
3236:     * consulta ao SQL Server) e, confirmando, marca como emitidos.
3237:     *
3238:     * A rotina de posicionamento fisico na folha do cheque (SigIpChq.prg,
3239:     * ~180 linhas com fValorExtenso/fwBuscaInt, nenhuma delas portada) fica
3240:     * para uma fase dedicada de impressao de cheques - mesma ressalva ja
3241:     * documentada em BtnImpChqClick/BtnChMatClick.
3242:     *==========================================================================
3243:     PROCEDURE ImprimirChequeManualClick()
3244:         LOCAL loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin, loc_nQtd, loc_lTemEmitido
3245: 
3246:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3247: 
3248:         WITH THIS.cnt_4c_Impchmat
3249:             loc_cBanco = .txt_4c_Banco.Value
3250:             loc_cChIni = .txt_4c_Chini.Value
3251:             loc_cChFin = .txt_4c_Chfin.Value
3252:             .Visible     = .T.
3253:         ENDWITH
3254: 
3255:         IF EMPTY(loc_cBanco)
3256:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
3257:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
3258:             RETURN
3259:         ENDIF
3260: 
3261:         IF EMPTY(loc_cChIni)
3262:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
3263:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
3264:             RETURN
3265:         ENDIF
3266: 
3267:         IF EMPTY(loc_cChFin)
3268:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
3269:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
3270:             RETURN
3271:         ENDIF
3272: 
3273:         IF loc_cChFin < loc_cChIni
3274:             MsgAviso("N" + CHR(250) + "mero do cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
3275:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
3276:             RETURN
3277:         ENDIF
3278: 
3279:         IF !USED(loc_cCursor)
3280:             RETURN
3281:         ENDIF
3282: 
3283:         SELECT (loc_cCursor)
3284:         COUNT TO loc_nQtd FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0
3285: 
3286:         IF loc_nQtd = 0
3287:             RETURN
3288:         ENDIF
3289: 
3290:         SELECT (loc_cCursor)
3291:         LOCATE FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0 AND nemitidos = 1
3292:         loc_lTemEmitido = FOUND()
3293: 
3294:         IF loc_lTemEmitido
3295:             IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. Confirma impress" + CHR(227) + "o ?", "Aten" + CHR(231) + CHR(227) + "o")
3296:                 RETURN
3297:             ENDIF
3298:         ENDIF
3299: 
3300:         MsgAviso("Verifique se a impressora est" + CHR(225) + " pronta p/ impress" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
3301: 
3302:         IF THIS.this_oBusinessObject.MarcarChequesComoEmitidosPorFaixa(loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin)
3303:             THIS.grd_4c_Dados.Refresh()
3304:             THIS.FecharImpressaoManualCheque()
3305:         ENDIF
3306:     ENDPROC
3307: 
3308:     *==========================================================================
3309:     * TxtChiniKeyPress / TxtChfinKeyPress - Valid de getChini/getChfin do
3310:     * impchmat legado: preenche com zeros a esquerda ate 6 digitos
3311:     * (PadL(Alltrim(Value),6,'0')). PUBLIC - BINDEVENT so dispara metodos
3312:     * PUBLIC.
3313:     *==========================================================================
3314:     PROCEDURE TxtChiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3315:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3316:             RETURN
3317:         ENDIF
3318:         THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
3319:     ENDPROC
3320: 
3321:     PROCEDURE TxtChfinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3322:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3323:             RETURN
3324:         ENDIF
3325:         THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
3326:     ENDPROC
3327: 
3328:     *==========================================================================
3329:     * ---------------------------------------------------------------------
3330:     * FASE 8 - Eventos auxiliares e consolidacao final
3331:     * ---------------------------------------------------------------------
3332:     * Este form eh OPERACIONAL FLAT (consulta/cancelamento de cheques): o
3333:     * SIGPRCHR legado NAO tem Page1=Lista/Page2=Dados, NAO tem os 5 botoes
3334:     * CRUD (Incluir/Alterar/Visualizar/Excluir/Buscar) e NAO tem botao de
3335:     * gravar - o dump nao declara btnSalvar/btnGravar/mGravaDados em lugar
3336:     * nenhum. Por isso NAO existem aqui BtnSalvarClick/BtnBuscarClick nem
3337:     * BtnEncerrarClick: inventar esses botoes violaria o PILAR 1 e a regra
3338:     * "NUNCA inventar", e criar metodos vazios com esses nomes seria o stub
3339:     * disfarcado proibido pela regra de completude. Os equivalentes reais,
3340:     * com os nomes dos objetos do legado, ja existem:
3341:     *
3342:     *   legado               migrado                      papel
3343:     *   -------------------  ---------------------------  -------------------
3344:     *   Command2             BtnProcessarClick()          acao principal
3345:     *   cmdGok.cmdSair       BtnSairClick()               Encerrar (Cancel)
3346:     *   cmdGok.cmdProcurar   BtnProcurarClick()           localizar cheque
3347:     *   cmdGconf.Botao2      BtnCancelarClick("JUSTIFICATIVA")
3348:     *   cmdgprocurar.Botao2  BtnCancelarClick("PROCURAR")
3349:     *   cmdGprocurar.Botao2  BtnCancelarClick("IMPCHMAT")
3350:     *
3351:     * Os hooks herdados de FormBase (FormParaBO/BOParaForm/LimparCampos)
3352:     * continuam PROTECTED - subclasse NAO alarga escopo de metodo herdado.
3353:     * CarregarLista/HabilitarCampos/AjustarBotoesPorModo/BtnCancelarClick
3354:     * ficam PUBLIC: o harness de teste automatizado os chama de FORA da
3355:     * classe (PEMSTATUS devolve .T. mesmo para PROTECTED e a chamada real
3356:     * falharia em runtime com "Property X is not found").
3357:     *==========================================================================
3358: 
3359:     *==========================================================================
3360:     * CarregarLista - FUNIL unico de carga da grade de cheques. Sincroniza os
3361:     * filtros da tela para o BO (FormParaBO - fonte unica da consulta),
3362:     * garante que o cursor da grade exista e delega para MontaGrade(), que eh
3363:     * a transcricao do "PROCEDURE montachq" legado (consulta o periodo,
3364:     * repovoa o cursor com ZAP + APPEND, recria os indices e entrega para
3365:     * ExibirCheques()).
3366:     *
3367:     * A mensagem de falha NAO eh repetida aqui: MontaGrade ja exibe a dela
3368:     * ("Favor Reinicializar o Processo!!!" do legado) - CLAUDE.md regra #20.
3369:     *
3370:     * PUBLIC - chamado por BtnProcessarClick e pelo harness de teste.
3371:     *==========================================================================
3372:     PROCEDURE CarregarLista(par_lPosiciona)
3373:         LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor
3374:         loc_lSucesso   = .F.
3375:         loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
3376: 
3377:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3378:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
3379:                 "o inicializado.", "FormSigPrChr.CarregarLista")
3380:         ELSE
3381:             *-- Filtros da tela -> BO ANTES da consulta: CarregarCheques le
3382:             *-- this_dDataInicial/this_dDataFinal/this_cCodGrupo/this_cCodConta.
3383:             THIS.FormParaBO()
3384: 
3385:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3386: 
3387:             IF !USED(loc_cCursor)
3388:                 THIS.CriarCursorCheques()
3389:             ENDIF
3390: 
3391:             loc_lSucesso = THIS.MontaGrade(loc_lPosiciona)
3392:         ENDIF
3393: 
3394:         RETURN loc_lSucesso
3395:     ENDPROC
3396: 
3397:     *==========================================================================
3398:     * FormParaBO - Tela -> Business Object. Hook PROTECTED de FormBase (usado
3399:     * por CarregarLista e por FormBase.Salvar).
3400:     *
3401:     * Filtros lidos pelos getters Obter* (fonte unica, com o guard PEMSTATUS e
3402:     * a normalizacao de DATE/DATETIME via ConverterParaData - CLAUDE.md regra
3403:     * #16). Os campos de descricao (GetDsGrupos/getDsContas), o Favorecido
3404:     * (TxtFavorecido, somente leitura) e a justificativa de cancelamento
3405:     * (cntjustificativa.get_justificativa) sao copiados direto.
3406:     *
3407:     * As properties Ant* (AntDtIni/AntDtFin/AntCdGrupo/AntCdConta do legado)
3408:     * NAO sao tocadas aqui de proposito: elas guardam o valor de ENTRADA no
3409:     * campo (When legado = handlers GotFocus) e sao o que BtnProcessarClick
3410:     * compara para decidir se a grade precisa ser recarregada. Sobrescreve-las
3411:     * aqui faria a comparacao nunca acusar mudanca e a grade nunca recarregar.
3412:     *==========================================================================
3413:     PROTECTED PROCEDURE FormParaBO()
3414:         LOCAL loc_oBO, loc_lSucesso
3415:         loc_lSucesso = .F.
3416: 
3417:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3418:             loc_oBO = THIS.this_oBusinessObject
3419: 
3420:             loc_oBO.this_dDataInicial = THIS.ObterFiltroDataInicial()
3421:             loc_oBO.this_dDataFinal   = THIS.ObterFiltroDataFinal()
3422:             loc_oBO.this_cCodGrupo    = THIS.ObterFiltroGrupo()
3423:             loc_oBO.this_cCodConta    = THIS.ObterFiltroConta()
3424: 
3425:             IF PEMSTATUS(THIS, "txt_4c_DsGrupos", 5)
3426:                 loc_oBO.this_cDescGrupo = THIS.txt_4c_DsGrupos.Value
3427:             ENDIF
3428: 
3429:             IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
3430:                 loc_oBO.this_cDescConta = THIS.txt_4c_DsContas.Value
3431:             ENDIF
3432: 
3433:             IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
3434:                 loc_oBO.this_cFavorecido = THIS.txt_4c_TxtFavorecido.Value
3435:             ENDIF
3436: 
3437:             IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
3438:                 IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
3439:                     loc_oBO.this_cJustCanc = ;
3440:                         THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value
3441:                 ENDIF
3442:             ENDIF
3443: 
3444:             loc_lSucesso = .T.
3445:         ENDIF
3446: 
3447:         RETURN loc_lSucesso
3448:     ENDPROC
3449: 
3450:     *==========================================================================
3451:     * BOParaForm - Business Object -> Tela. Hook PROTECTED de FormBase (usado
3452:     * por InicializarForm para semear o periodo e por FormBase.Cancelar).
3453:     *
3454:     * O legado faz esse mesmo trabalho no Init ("ThisForm.Dt_Inicial.Value =
3455:     * Date()", "ThisForm.Dt_Final.Value = Date()", getCdGrupos/getDsGrupos/
3456:     * getCdContas/getDsContas = Space(...)): aqui os valores vem das
3457:     * properties do BO (this_dDataInicial/this_dDataFinal recebem DATE() no
3458:     * SigPrChrBO.Init), mantendo o BO como fonte unica do estado dos filtros.
3459:     *
3460:     * O Favorecido eh espelho do cheque corrente e NAO eh escrito aqui: quem
3461:     * o atualiza a cada linha da grade eh AtualizarPainelChequeCorrente()
3462:     * (transcricao do AfterRowColChange/Scrolled legado). Escreve-lo tambem
3463:     * aqui criaria duas fontes para o mesmo campo.
3464:     *==========================================================================
3465:     PROTECTED PROCEDURE BOParaForm()
3466:         LOCAL loc_oBO, loc_lSucesso
3467:         loc_lSucesso = .F.
3468: 
3469:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3470:             loc_oBO = THIS.this_oBusinessObject
3471: 
3472:             IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
3473:                 THIS.txt_4c_Dt_inicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
3474:             ENDIF
3475: 
3476:             IF PEMSTATUS(THIS, "txt_4c_Dt_final", 5)
3477:                 THIS.txt_4c_Dt_final.Value = ConverterParaData(loc_oBO.this_dDataFinal)
3478:             ENDIF
3479: 
3480:             IF PEMSTATUS(THIS, "txt_4c_CdGrupos", 5)
3481:                 THIS.txt_4c_CdGrupos.Value = loc_oBO.this_cCodGrupo
3482:             ENDIF
3483: 
3484:             IF PEMSTATUS(THIS, "txt_4c_DsGrupos", 5)
3485:                 THIS.txt_4c_DsGrupos.Value = loc_oBO.this_cDescGrupo
3486:             ENDIF
3487: 
3488:             IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
3489:                 THIS.txt_4c_CdContas.Value = loc_oBO.this_cCodConta
3490:             ENDIF
3491: 
3492:             IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
3493:                 THIS.txt_4c_DsContas.Value = loc_oBO.this_cDescConta
3494:             ENDIF
3495: 
3496:             loc_lSucesso = .T.
3497:         ENDIF
3498: 
3499:         RETURN loc_lSucesso
3500:     ENDPROC
3501: 
3502:     *==========================================================================
3503:     * LimparCampos - Hook PROTECTED de FormBase (chamado por FormBase.Novo() e
3504:     * por FormBase.Excluir() apos exclusao bem-sucedida). Devolve a tela ao
3505:     * estado do Init legado: Grupo e Conta vazios, periodo = hoje, painel de

*-- Linhas 3511 a 3554:
3511:     * LimparChequesSeFiltroMudou(), que ja desliga SAFETY (com SAFETY ON o ZAP
3512:     * abre dialogo modal e CONGELA a tela).
3513:     *==========================================================================
3514:     PROTECTED PROCEDURE LimparCampos()
3515:         LOCAL loc_oBO
3516: 
3517:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3518:             loc_oBO = THIS.this_oBusinessObject
3519: 
3520:             loc_oBO.this_cCodGrupo    = ""
3521:             loc_oBO.this_cDescGrupo   = ""
3522:             loc_oBO.this_cCodConta    = ""
3523:             loc_oBO.this_cDescConta   = ""
3524:             loc_oBO.this_dDataInicial = DATE()
3525:             loc_oBO.this_dDataFinal   = DATE()
3526:             loc_oBO.this_cFavorecido  = ""
3527:             loc_oBO.this_cJustCanc    = ""
3528: 
3529:             *-- Proxima carga volta a ser "primeira exibicao" (Inicial do
3530:             *-- legado): MontaGrade deve ir para o Top do cursor em vez de
3531:             *-- reposicionar no ultimo cheque selecionado.
3532:             loc_oBO.this_lPrimeiraExibicao = .T.
3533: 
3534:             THIS.BOParaForm()
3535:         ENDIF
3536: 
3537:         IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
3538:             THIS.txt_4c_TxtFavorecido.Value = ""
3539:         ENDIF
3540: 
3541:         IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
3542:             IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
3543:                 THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value = ""
3544:             ENDIF
3545:         ENDIF
3546: 
3547:         IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
3548:             WITH THIS.cnt_4c_Procurar
3549:                 .txt_4c_Banco.Value   = ""
3550:                 .txt_4c_Agencia.Value = ""
3551:                 .txt_4c_Conta.Value   = ""
3552:                 .txt_4c_Cheque.Value  = ""
3553:                 .txt_4c_Emissao.Value = {}
3554:                 .txt_4c_Valor.Value   = 0

*-- Linhas 3582 a 3625:
3582:     *
3583:     * PUBLIC - usado por AjustarBotoesPorModo e pelo harness de teste.
3584:     *==========================================================================
3585:     PROCEDURE HabilitarCampos(par_lHabilitar)
3586:         LOCAL loc_lHabilitar
3587: 
3588:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
3589: 
3590:         IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
3591:             THIS.txt_4c_CdContas.Enabled = loc_lHabilitar
3592:         ENDIF
3593: 
3594:         IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
3595:             THIS.txt_4c_DsContas.Enabled = loc_lHabilitar
3596:         ENDIF
3597: 
3598:         IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
3599:             THIS.txt_4c_TxtFavorecido.Enabled = loc_lHabilitar
3600:         ENDIF
3601: 
3602:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3603:             THIS.grd_4c_Dados.Enabled = loc_lHabilitar
3604:         ENDIF
3605: 
3606:         IF PEMSTATUS(THIS, "obj_4c_CmdGok", 5)
3607:             THIS.obj_4c_CmdGok.Enabled = loc_lHabilitar
3608:         ENDIF
3609:     ENDPROC
3610: 
3611:     *==========================================================================
3612:     * AjustarBotoesPorModo - FUNIL de ida E de volta do estado dos controles
3613:     * conforme o painel flutuante aberto. Quem DESABILITA tem de REABILITAR no
3614:     * mesmo funil, senao a tela volta da busca com os botoes cinza e fica
3615:     * inutilizavel ate ser reaberta (CLAUDE.md regra #40).
3616:     *
3617:     * Modos deste form (nao ha INCLUIR/ALTERAR/VISUALIZAR - o legado nao tem
3618:     * CRUD nenhum):
3619:     *   "LISTA"         consulta livre - nenhum painel aberto
3620:     *   "PROCURAR"      cntProcurar.Init: desliga Conta/Favorecido/grade/CmdGok
3621:     *   "IMPCHMAT"      impchmat.Init: desliga SO o CmdGok - o legado nao toca
3622:     *                   nos demais controles neste painel, por isso este ramo
3623:     *                   NAO chama HabilitarCampos
3624:     *   "JUSTIFICATIVA" cntjustificativa visivel; o legado tambem nao
3625:     *                   desabilita nada da tela de fundo neste painel

*-- Linhas 3632 a 3675:
3632:     *
3633:     * PUBLIC - usado pelos abre/fecha dos paineis e pelo harness de teste.
3634:     *==========================================================================
3635:     PROCEDURE AjustarBotoesPorModo(par_cModo)
3636:         LOCAL loc_cModo
3637: 
3638:         loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C" AND ;
3639:             !EMPTY(par_cModo), par_cModo, THIS.this_cModoAtual)))
3640: 
3641:         IF !INLIST(loc_cModo, "LISTA", "PROCURAR", "IMPCHMAT", "JUSTIFICATIVA")
3642:             loc_cModo = "LISTA"
3643:         ENDIF
3644: 
3645:         THIS.this_cModoAtual = loc_cModo
3646: 
3647:         DO CASE
3648:             CASE loc_cModo == "PROCURAR"
3649:                 THIS.HabilitarCampos(.F.)
3650: 
3651:                 IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
3652:                     THIS.cnt_4c_Procurar.Enabled = .T.
3653:                     THIS.cnt_4c_Procurar.Visible = .T.
3654:                 ENDIF
3655: 
3656:             CASE loc_cModo == "IMPCHMAT"
3657:                 IF PEMSTATUS(THIS, "obj_4c_CmdGok", 5)
3658:                     THIS.obj_4c_CmdGok.Enabled = .F.
3659:                 ENDIF
3660: 
3661:                 IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
3662:                     THIS.cnt_4c_Impchmat.Enabled = .T.
3663:                     THIS.cnt_4c_Impchmat.Visible = .T.
3664:                 ENDIF
3665: 
3666:             CASE loc_cModo == "JUSTIFICATIVA"
3667:                 IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
3668:                     THIS.cnt_4c_justificativa.Visible = .T.
3669:                 ENDIF
3670: 
3671:             OTHERWISE
3672:                 *-- "LISTA": volta da busca/impressao - reabilita tudo o que os
3673:                 *-- modos acima desligaram e fecha os paineis flutuantes.
3674:                 THIS.HabilitarCampos(.T.)
3675: 

*-- Linhas 3710 a 3818:
3710:     *
3711:     * PUBLIC - dispatchers e harness de teste chamam de fora da classe.
3712:     *==========================================================================
3713:     PROCEDURE BtnCancelarClick(par_cPainel)
3714:         LOCAL loc_cPainel, loc_lFechou
3715:         loc_lFechou = .F.
3716: 
3717:         loc_cPainel = UPPER(ALLTRIM(IIF(VARTYPE(par_cPainel) = "C", par_cPainel, "")))
3718: 
3719:         IF EMPTY(loc_cPainel)
3720:             DO CASE
3721:                 CASE PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3722:                     loc_cPainel = "PROCURAR"
3723:                 CASE PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3724:                     loc_cPainel = "IMPCHMAT"
3725:                 CASE PEMSTATUS(THIS, "cnt_4c_justificativa", 5) AND THIS.cnt_4c_justificativa.Visible
3726:                     loc_cPainel = "JUSTIFICATIVA"
3727:             ENDCASE
3728:         ENDIF
3729: 
3730:         DO CASE
3731:             CASE loc_cPainel == "PROCURAR"
3732:                 THIS.FecharPainelProcurar()
3733:                 loc_lFechou = .T.
3734:             CASE loc_cPainel == "IMPCHMAT"
3735:                 THIS.FecharImpressaoManualCheque()
3736:                 loc_lFechou = .T.
3737:             CASE loc_cPainel == "JUSTIFICATIVA"
3738:                 THIS.CancelarJustificativa()
3739:                 loc_lFechou = .T.
3740:         ENDCASE
3741: 
3742:         RETURN loc_lFechou
3743:     ENDPROC
3744: 
3745:     *==========================================================================
3746:     * TornarControlesVisiveis - Torna visiveis os controles criados via
3747:     * AddObject (nascem Visible=.F.). Percorre containers e PageFrames
3748:     * recursivamente.
3749:     *
3750:     * Containers FLUTUANTES do legado (cntjustificativa/impchmat/cntProcurar -
3751:     * Visible=.F. no SCX, alternados por botao) DEVEM permanecer ocultos: o
3752:     * nome entra no INLIST abaixo e o metodo faz LOOP sem tocar o .Visible do
3753:     * proprio container - mas ainda RECURSA nos filhos dele antes do LOOP,
3754:     * senao os filhos ficam Visible=.F. para sempre e o container aparece
3755:     * vazio quando outro metodo setar .Visible = .T. nele (ver CLAUDE.md
3756:     * regra de forms operacionais / licao "tcv_skip_recursao"). Estes
3757:     * containers ainda nao existem na Fase 3 - a lista fica pronta para
3758:     * quando as Fases 6/7 os criarem.
3759:     *==========================================================================
3760:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3761:         LOCAL loc_nI, loc_oControl
3762: 
3763:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3764:             loc_oControl = par_oContainer.Controls(loc_nI)
3765: 
3766:             IF VARTYPE(loc_oControl) = "O"
3767:                 IF INLIST(UPPER(loc_oControl.Name), ;
3768:                           "CNT_4C_JUSTIFICATIVA", ;
3769:                           "CNT_4C_IMPCHMAT", ;
3770:                           "CNT_4C_PROCURAR")
3771:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
3772:                         THIS.TornarControlesVisiveis(loc_oControl)
3773:                     ENDIF
3774:                     LOOP
3775:                 ENDIF
3776: 
3777:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
3778:                     loc_oControl.Visible = .T.
3779:                 ENDIF
3780: 
3781:                 *-- PageFrame: percorrer Pages tambem (nenhum neste form, mas
3782:                 *-- mantido pelo padrao canonico do projeto)
3783:                 IF PEMSTATUS(loc_oControl, "PageCount", 5)
3784:                     LOCAL loc_nP
3785:                     FOR loc_nP = 1 TO loc_oControl.PageCount
3786:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
3787:                     ENDFOR
3788:                 ENDIF
3789: 
3790:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
3791:                     THIS.TornarControlesVisiveis(loc_oControl)
3792:                 ENDIF
3793:             ENDIF
3794:         ENDFOR
3795:     ENDPROC
3796: 
3797:     *==========================================================================
3798:     * Destroy - Libera cursores de trabalho do BO (nomes definidos em
3799:     * SigPrChrBO.this_cCursorCheques/Contas/Impressoras). Ainda vazios na
3800:     * Fase 3 (populados a partir da Fase 4), os IF USED() sao defensivos e
3801:     * idempotentes. DODEFAULT() por ULTIMO restaura o menu principal
3802:     * (FormBase.Destroy).
3803:     *==========================================================================
3804:     PROCEDURE Destroy()
3805:         IF USED("cursor_4c_Cheques")
3806:             USE IN cursor_4c_Cheques
3807:         ENDIF
3808:         IF USED("cursor_4c_Contas")
3809:             USE IN cursor_4c_Contas
3810:         ENDIF
3811:         IF USED("cursor_4c_Impressoras")
3812:             USE IN cursor_4c_Impressoras
3813:         ENDIF
3814: 
3815:         DODEFAULT()
3816:     ENDPROC
3817: 
3818: ENDDEFINE


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

