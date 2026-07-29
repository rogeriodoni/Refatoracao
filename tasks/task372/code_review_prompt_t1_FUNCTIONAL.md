# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormCliente.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1968 linhas total):

*-- Linhas 42 a 203:
42:     this_oBusinessObject = .NULL.
43:     this_cModoAtual      = ""
44: 
45:     *-- Parametros recebidos em Init (armazenados para uso em InicializarForm)
46:     this_cCpf         = ""
47:     this_cGrupo       = ""
48:     this_nCep         = 0
49:     this_lVal         = .F.
50:     this_cCli         = ""
51:     this_cTpBloqCar   = "0"
52:     this_cMudaCpfCgc  = "0"
53: 
54:     *============================================================
55:     PROCEDURE Init
56:     *============================================================
57:         LPARAMETERS par_cCpf, par_cGrupo, par_nCep, par_lVal, par_cCli, par_cTpBloqCar, par_cMudaCpfCgc
58: 
59:         *-- Normalizar e armazenar parametros antes de DODEFAULT (que chama InicializarForm)
60:         THIS.this_cCpf        = IIF(TYPE("par_cCpf")        = "C", PADR(par_cCpf, 20),        SPACE(20))
61:         THIS.this_cGrupo      = IIF(TYPE("par_cGrupo")      = "C", PADR(par_cGrupo, 10),      SPACE(10))
62:         THIS.this_nCep        = IIF(TYPE("par_nCep")        = "N", par_nCep,                  0)
63:         THIS.this_lVal        = IIF(TYPE("par_lVal")        = "L", par_lVal,                  .F.)
64:         THIS.this_cCli        = IIF(TYPE("par_cCli")        = "C", PADR(par_cCli, 10),        SPACE(10))
65:         THIS.this_cTpBloqCar  = IIF(TYPE("par_cTpBloqCar")  = "C", par_cTpBloqCar,            "0")
66:         THIS.this_cMudaCpfCgc = IIF(TYPE("par_cMudaCpfCgc") = "C", par_cMudaCpfCgc,           "0")
67: 
68:         RETURN DODEFAULT()
69:     ENDPROC
70: 
71:     *============================================================
72:     PROTECTED PROCEDURE InicializarForm
73:     *============================================================
74:         LOCAL loc_lSucesso, loc_oErro, loc_cCpf, loc_cGrupo, loc_lRetLeDados
75:         loc_lSucesso = .F.
76: 
77:         TRY
78:             *-- Instanciar Business Object (cliBO)
79:             THIS.this_oBusinessObject = CREATEOBJECT("cliBO")
80: 
81:             *-- Fundo de tela
82:             THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
83: 
84:             *-- Normalizar CPF (remover pontuacao para verificacao)
85:             loc_cCpf = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(THIS.this_cCpf), ".", ""), "-", ""), "/", "")
86: 
87:             *-- Determinar grupo padrao se nao informado
88:             loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
89:             IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
90:                 SELECT crSigCdPam
91:                 LOCATE
92:                 IF !EOF("crSigCdPam")
93:                     loc_cGrupo = PADR(crSigCdPam.GrPadClis, 10)
94:                     THIS.this_cGrupo = loc_cGrupo
95:                 ENDIF
96:             ENDIF
97: 
98:             *-- Verificar grupo configurado
99:             IF EMPTY(ALLTRIM(THIS.this_cGrupo))
100:                 MsgAviso("Grupo Padr" + CHR(227) + "o N" + CHR(227) + "o Configurado.")
101:             ELSE
102:                 *-- Definir modo (INSERIR / ALTERAR)
103:                 THIS.mudavend = .T.
104:                 IF EMPTY(ALLTRIM(THIS.this_cCli))
105:                     THIS.pcEscolha       = "INSERIR"
106:                     THIS.this_cModoAtual = "INCLUIR"
107:                     THIS.plaltcd         = .F.
108:                 ELSE
109:                     THIS.plaltcd         = .T.
110:                     THIS.pcEscolha       = "ALTERAR"
111:                     THIS.this_cModoAtual = "ALTERAR"
112:                 ENDIF
113: 
114:                 *-- Criar componentes visuais
115:                 THIS.ConfigurarCabecalho()
116:                 THIS.ConfigurarContaCls()
117:                 THIS.ConfigurarBotoesSair()
118:                 THIS.TornarControlesVisiveis()
119: 
120:                 *-- Inicializar clsconta
121:                 THIS.cnt_4c_Conta.mIniConta()
122:                 THIS.cnt_4c_Conta.pgframeDados.Top = 0
123:                 THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.ToolTipText = "F5 - Dados Pessoais/Comerciais"
124: 
125:                 *-- Ajustar navegacao inicial do PageFrame interno (pgframeDados)
126:                 THIS.ConfigurarPaginaLista()
127:                 THIS.ConfigurarPaginaDados()
128:                 THIS.ConfigurarPaginaDados2()
129: 
130:                 *-- Carregar dados do cliente
131:                 loc_lRetLeDados = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
132:                     THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
133: 
134:                 IF loc_lRetLeDados
135:                     THIS.cnt_4c_Conta.cmdgftec.Visible = .F.
136: 
137:                     IF THIS.pcEscolha = "INSERIR" AND !EMPTY(loc_cCpf)
138:                         WITH THIS.cnt_4c_Conta.pgframeDados.pgframeDados1
139:                             .OpcaoCPFCGC.Value = IIF(LEN(loc_cCpf) <> 14, 1, 2)
140:                             .GetCPFCGC.Value   = THIS.this_cCpf
141:                         ENDWITH
142:                         THIS.cnt_4c_Conta.mAtuGetCpf()
143:                     ENDIF
144: 
145:                     THIS.cnt_4c_Conta.Visible = .T.
146:                     THIS.cnt_4c_Conta.Refresh()
147:                     loc_lSucesso = .T.
148:                 ELSE
149:                     MsgErro("Erro Na Leitura dos Dados", "Erro")
150:                 ENDIF
151:             ENDIF
152: 
153:         CATCH TO loc_oErro
154:             MsgErro(loc_oErro.Message + CHR(13) + ;
155:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
156:                 "Procedure: " + loc_oErro.Procedure, ;
157:                 "Erro em InicializarForm")
158:         ENDTRY
159:         RETURN loc_lSucesso
160:     ENDPROC
161: 
162:     *============================================================
163:     PROTECTED PROCEDURE ConfigurarCabecalho
164:     *============================================================
165:         LOCAL loc_oCnt
166:         THIS.AddObject("cnt_4c_Sombra", "Container")
167:         loc_oCnt = THIS.cnt_4c_Sombra
168:         WITH loc_oCnt
169:             .Top        = -1
170:             .Left       = -1
171:             .Width      = THIS.Width
172:             .Height     = 80
173:             .BorderWidth = 0
174:             .BackColor  = RGB(100,100,100)
175:         ENDWITH
176:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
177:         WITH loc_oCnt.lbl_4c_LblSombra
178:             .FontBold      = .T.
179:             .FontName      = "Tahoma"
180:             .FontSize      = 18
181:             .FontUnderline = .F.
182:             .WordWrap      = .T.
183:             .Alignment     = 0
184:             .BackStyle     = 0
185:             .AutoSize      = .F.
186:             .Caption       = "Cadastro de Cliente"
187:             .Height        = 40
188:             .Left          = 10
189:             .Top           = 18
190:             .Width         = 769
191:             .ForeColor     = RGB(0,0,0)
192:             .Visible       = .T.
193:         ENDWITH
194:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
195:         WITH loc_oCnt.lbl_4c_LblTitulo
196:             .FontBold   = .T.
197:             .FontName   = "Tahoma"
198:             .FontSize   = 18
199:             .WordWrap   = .T.
200:             .Alignment  = 0
201:             .BackStyle  = 0
202:             .AutoSize   = .F.
203:             .Caption    = "Cadastro de Cliente"

*-- Linhas 212 a 288:
212:     ENDPROC
213: 
214:     *============================================================
215:     PROTECTED PROCEDURE ConfigurarContaCls
216:     *============================================================
217:         LOCAL loc_oErro, loc_cVcx1, loc_cVcx2, loc_cVcx3
218:         loc_cVcx1 = gc_4c_CaminhoBase + "Framework\framework.vcx"
219:         loc_cVcx2 = gc_4c_CaminhoBase + "Framework\classobj.vcx"
220:         loc_cVcx3 = gc_4c_CaminhoBase + "Framework\classresp.vcx"
221: 
222:         TRY
223:             IF FILE(loc_cVcx1)
224:                 SET CLASSLIB TO (loc_cVcx1) ADDITIVE
225:             ENDIF
226:             IF FILE(loc_cVcx2)
227:                 SET CLASSLIB TO (loc_cVcx2) ADDITIVE
228:             ENDIF
229:             IF FILE(loc_cVcx3)
230:                 SET CLASSLIB TO (loc_cVcx3) ADDITIVE
231:             ENDIF
232:         CATCH TO loc_oErro
233:             MsgErro("Erro ao carregar biblioteca de classes: " + loc_oErro.Message, "Erro")
234:         ENDTRY
235: 
236:         THIS.AddObject("cnt_4c_Conta", "clsconta")
237:         WITH THIS.cnt_4c_Conta
238:             .Top    = 132
239:             .Left   = 12
240:             .Width  = 768
241:             .Height = 450
242:             .Visible     = .T.
243:         ENDWITH
244:         *-- cnt_4c_Conta permanece oculto ate mLeDados retornar .T. em InicializarForm
245:     ENDPROC
246: 
247:     *============================================================
248:     PROTECTED PROCEDURE ConfigurarBotoesSair
249:     *============================================================
250:         LOCAL loc_oCmg
251:         THIS.AddObject("cmg_4c_Sair", "CommandGroup")
252:         loc_oCmg = THIS.cmg_4c_Sair
253:         WITH loc_oCmg
254:             .ButtonCount   = 2
255:             .BackStyle     = 0
256:             .BorderStyle   = 0
257:             .Value         = 1
258:             .Height        = 85
259:             .Left          = 688
260:             .SpecialEffect = 1
261:             .Top           = -2
262:             .Width         = 161
263:         ENDWITH
264:         WITH loc_oCmg.Buttons(1)
265:             .Top        = 5
266:             .Left       = 5
267:             .Height     = 75
268:             .Width      = 75
269:             .FontBold   = .T.
270:             .FontItalic = .T.
271:             .FontName   = "Comic Sans MS"
272:             .FontSize   = 8
273:             .WordWrap   = .T.
274:             .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
275:             .Caption    = "\<Ok"
276:             .ForeColor  = RGB(90,90,90)
277:             .BackColor  = RGB(255,255,255)
278:             .Themes     = .F.
279:             .Visible    = .T.
280:         ENDWITH
281:         WITH loc_oCmg.Buttons(2)
282:             .Top        = 5
283:             .Left       = 81
284:             .Height     = 75
285:             .Width      = 75
286:             .FontBold   = .T.
287:             .FontItalic = .T.
288:             .FontName   = "Comic Sans MS"

*-- Linhas 299 a 523:
299:         THIS.cmg_4c_Sair.Visible = .T.
300: 
301:         *-- Bind eventos dos botoes (metodos PUBLIC por padrao VFP9)
302:         BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnOkClick")
303:         BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelarClick")
304:     ENDPROC
305: 
306:     *============================================================
307:     PROTECTED PROCEDURE TornarControlesVisiveis
308:     *============================================================
309:         LOCAL loc_i, loc_oCtrl
310:         FOR loc_i = 1 TO THIS.ControlCount
311:             loc_oCtrl = THIS.Controls(loc_i)
312:             *-- cnt_4c_Conta permanece oculto ate mLeDados ter sucesso
313:             IF UPPER(loc_oCtrl.Name) = "CNT_4C_CONTA"
314:                 LOOP
315:             ENDIF
316:             loc_oCtrl.Visible = .T.
317:         ENDFOR
318:     ENDPROC
319: 
320:     *============================================================
321:     * Botao Ok / Gravar
322:     *============================================================
323:     PROCEDURE BtnOkClick
324:         LOCAL loc_nRetorno, loc_cCpfCgc
325: 
326:         loc_nRetorno = THIS.cnt_4c_Conta.mValidaObj()
327: 
328:         IF loc_nRetorno >= 0
329:             IF loc_nRetorno > 0
330:                 IF THIS.cnt_4c_Conta.mGravaDados() > 0
331:                     loc_cCpfCgc = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
332:                         THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value, ;
333:                         ".", ""), "-", ""), "/", ""))
334: 
335:                     IF EMPTY(loc_cCpfCgc)
336:                         THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value
337:                     ELSE
338:                         THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value
339:                     ENDIF
340:                     THIS.Release()
341:                 ELSE
342:                     MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados, " + ;
343:                         "Favor Clicar no Bot" + CHR(227) + "o [OK] Novamente.", "Erro")
344:                 ENDIF
345:             ENDIF
346:         ENDIF
347:     ENDPROC
348: 
349:     *============================================================
350:     * Botao Cancelar
351:     *============================================================
352:     PROCEDURE BtnCancelarClick
353:         LOCAL loc_nCodigo, loc_nIdConta, loc_oErro
354: 
355:         *-- Liberar sequencial automatico se estava inserindo
356:         IF THIS.pcEscolha = "INSERIR"
357:             TRY
358:                 IF USED("crSigCdCli")
359:                     SELECT crSigCdCli
360:                     loc_nCodigo  = crSigCdCli.NClis
361:                     loc_nIdConta = crSigCdCli.IdConta
362:                 ELSE
363:                     loc_nCodigo  = 0
364:                     loc_nIdConta = 0
365:                 ENDIF
366: 
367:                 IF USED("crSigCdGcr")
368:                     SELECT crSigCdGcr
369:                     IF crSigCdGcr.TpCods = 1
370:                         IF crSigCdGcr.TpEmps = 1
371:                             = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos) + go_4c_Sistema.cCodEmpresa)
372:                         ELSE
373:                             = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos))
374:                         ENDIF
375:                     ENDIF
376:                 ENDIF
377:             CATCH TO loc_oErro
378:                 *-- fCanUniqueKey pode nao estar portada; nao bloquear o cancelamento
379:             ENDTRY
380:         ENDIF
381: 
382:         THIS.RetCodCliente = " "
383:         THIS.Release()
384:     ENDPROC
385: 
386:     *============================================================
387:     * ConfigurarPaginaLista - configura o estado inicial da pagina
388:     * principal (pgframeDados1) do PageFrame interno de clsconta.
389:     *
390:     * Forms OPERACIONAIS deste tipo (wrapper de clsconta) NAO usam
391:     * o padrao CRUD Page1=Lista/Page2=Dados. A "pagina de listagem"
392:     * corresponde a pgframeDados1 (Cadastro principal) do clsconta,
393:     * que exibe os campos primarios do cliente. O paginado interno
394:     * eh alternado via cmdgPessoal (F5) ou via THIS.AlternarPagina().
395:     *============================================================
396:     PROTECTED PROCEDURE ConfigurarPaginaLista
397:         LOCAL loc_oPgf
398: 
399:         IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
400:             RETURN
401:         ENDIF
402: 
403:         IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
404:             RETURN
405:         ENDIF
406: 
407:         loc_oPgf = THIS.cnt_4c_Conta.pgframeDados
408: 
409:         loc_oPgf.Top        = 0
410:         loc_oPgf.ActivePage = 1
411:         loc_oPgf.Visible    = .T.
412: 
413:         *-- Realcar botao da pagina ativa (cmdgCadastro se existir)
414:         IF PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) AND ;
415:            PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
416:             THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.SetFocus()
417:         ENDIF
418:     ENDPROC
419: 
420:     *============================================================
421:     * AlternarPagina - alterna entre as paginas do pgframeDados
422:     * interno de clsconta (1 = Cadastro, 2 = Dados Pessoais/Comerciais).
423:     *
424:     * Chamada por KeyPress (F5) ou por logica interna do form.
425:     * par_nPagina: se informada e valida (1..PageCount), navega
426:     * diretamente; caso contrario, alterna entre 1 e 2.
427:     *============================================================
428:     PROCEDURE AlternarPagina
429:         LPARAMETERS par_nPagina
430:         LOCAL loc_oPgf, loc_nDestino
431: 
432:         IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
433:             RETURN
434:         ENDIF
435: 
436:         IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
437:             RETURN
438:         ENDIF
439: 
440:         loc_oPgf = THIS.cnt_4c_Conta.pgframeDados
441: 
442:         IF TYPE("par_nPagina") = "N" AND par_nPagina >= 1 AND par_nPagina <= loc_oPgf.PageCount
443:             loc_nDestino = par_nPagina
444:         ELSE
445:             loc_nDestino = IIF(loc_oPgf.ActivePage = 1, 2, 1)
446:         ENDIF
447: 
448:         loc_oPgf.ActivePage = loc_nDestino
449: 
450:         *-- Delegar ao botao de comando correspondente do clsconta
451:         *-- para preservar comportamento original (highlight, refresh, etc.)
452:         DO CASE
453:         CASE loc_nDestino = 2 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgPessoal", 5) ;
454:              AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgPessoal, "cmdPessoal", 5)
455:             THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.Click()
456:         CASE loc_nDestino = 1 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) ;
457:              AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
458:             THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.Click()
459:         ENDCASE
460:     ENDPROC
461: 
462:     *============================================================
463:     PROCEDURE KeyPress
464:     *============================================================
465:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
466:         IF par_nKeyCode = -4  && F5 = Aba Dados Pessoais/Comerciais
467:             NODEFAULT
468:             THIS.AlternarPagina(2)
469:         ENDIF
470:     ENDPROC
471: 
472:     *============================================================
473:     PROCEDURE Unload
474:     *============================================================
475:         RETURN THIS.RetCodCliente
476:     ENDPROC
477: 
478:     *============================================================
479:     * ConfigurarPaginaDados - Aplica overrides visuais do SCX
480:     * legado nos controles internos de cnt_4c_Conta.pgframeDados1
481:     * (primeira metade: Shapes + primeiros Labels e TextBoxes).
482:     *============================================================
483:     PROTECTED PROCEDURE ConfigurarPaginaDados
484:         LOCAL loc_oPgf, loc_oPg1, loc_oErro, loc_cNomeEndCtrl, loc_oEndCtrl, loc_cNomeRazCtrl, loc_oRazCtrl
485: 
486:         IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
487:             RETURN
488:         ENDIF
489:         IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
490:             RETURN
491:         ENDIF
492: 
493:         loc_oPgf = THIS.cnt_4c_Conta.pgframeDados
494: 
495:         TRY
496:             IF PEMSTATUS(loc_oPgf, "ErasePage", 5)
497:                 loc_oPgf.ErasePage = .T.
498:             ENDIF
499: 
500:             IF !PEMSTATUS(loc_oPgf, "pgframeDados1", 5)
501:                 RETURN
502:             ENDIF
503:             loc_oPg1 = loc_oPgf.pgframeDados1
504: 
505:             *-- Propriedades da pagina
506:             IF PEMSTATUS(loc_oPg1, "FontName", 5)
507:                 loc_oPg1.FontName = "Tahoma"
508:             ENDIF
509:             IF PEMSTATUS(loc_oPg1, "BackColor", 5)
510:                 loc_oPg1.BackColor = RGB(255,255,255)
511:             ENDIF
512:             IF PEMSTATUS(loc_oPg1, "ForeColor", 5)
513:                 loc_oPg1.ForeColor = RGB(90,90,90)
514:             ENDIF
515: 
516:             *-- Shape1 (borda secao principal)
517:             IF PEMSTATUS(loc_oPg1, "Shape1", 5)
518:                 WITH loc_oPg1.Shape1
519:                     .Top           = 2
520:                     .Left          = 6
521:                     .Height        = 195
522:                     .Width         = 751
523:                     .SpecialEffect = 1

*-- Linhas 1036 a 1079:
1036:                 ENDWITH
1037:             ENDIF
1038: 
1039:             *-- OpcaoCPFCGC (OptionGroup tipo documento - posicao)
1040:             IF PEMSTATUS(loc_oPg1, "OpcaoCPFCGC", 5)
1041:                 WITH loc_oPg1.OpcaoCPFCGC
1042:                     .Left = 14
1043:                     .Top  = 33
1044:                 ENDWITH
1045:             ENDIF
1046: 
1047:             *-- GetCEP (TextBox CEP)
1048:             IF PEMSTATUS(loc_oPg1, "GetCEP", 5)
1049:                 WITH loc_oPg1.GetCEP
1050:                     .Left = 102
1051:                     .Top  = 200
1052:                 ENDWITH
1053:             ENDIF
1054: 
1055:             *-- GetPais (TextBox pais)
1056:             IF PEMSTATUS(loc_oPg1, "GetPais", 5)
1057:                 WITH loc_oPg1.GetPais
1058:                     .Left = 230
1059:                     .Top  = 200
1060:                 ENDWITH
1061:             ENDIF
1062: 
1063:             *-- GetEndere?o (TextBox endereco - nome com cedilha CHR(231))
1064:             loc_cNomeEndCtrl = "GetEndere" + CHR(231) + "o"
1065:             IF PEMSTATUS(loc_oPg1, loc_cNomeEndCtrl, 5)
1066:                 loc_oEndCtrl = EVALUATE("loc_oPg1." + loc_cNomeEndCtrl)
1067:                 WITH loc_oEndCtrl
1068:                     .Left = 102
1069:                     .Top  = 223
1070:                 ENDWITH
1071:                 loc_oEndCtrl = .NULL.
1072:             ENDIF
1073: 
1074:             *-- Get_num (TextBox numero do endereco)
1075:             IF PEMSTATUS(loc_oPg1, "Get_num", 5)
1076:                 WITH loc_oPg1.Get_num
1077:                     .Left = 561
1078:                     .Top  = 223
1079:                 ENDWITH

*-- Linhas 1288 a 1341:
1288:         CATCH TO loc_oErro
1289:             MsgErro(loc_oErro.Message + CHR(13) + ;
1290:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1291:                 "Procedure: " + loc_oErro.Procedure, ;
1292:                 "Erro em ConfigurarPaginaDados")
1293:         ENDTRY
1294:     ENDPROC
1295: 
1296:     *============================================================
1297:     * checaibge - Validacao de codigo IBGE de municipio/UF.
1298:     * Metodo PUBLIC chamado internamente pelo clsconta via
1299:     * ThisForm.checaibge(pMun, pUFs, obCidade, obUF).
1300:     *============================================================
1301:     PROCEDURE checaibge
1302:         LPARAMETERS par_cMun, par_cUFs, par_oObC, par_oObU
1303:         LOCAL loc_nRtC, loc_nRtU, loc_cQuery, loc_oErro
1304: 
1305:         loc_nRtC = 9999999
1306:         loc_nRtU = 99
1307: 
1308:         TRY
1309:             *-- Buscar codigo IBGE do municipio
1310:             loc_cQuery = "SELECT a.Codigos " + ;
1311:                         "FROM SigCdMun a, SigCdUfs b " + ;
1312:                         "WHERE RTRIM(a.Descs) = '" + ;
1313:                             PADR(UPPER(ALLTRIM(par_cMun)), 40) + "'" + ;
1314:                         " AND a.UFIBGEs = b.UFIBGEs" + ;
1315:                         " AND b.Estados = '" + PADR(par_cUFs, 2) + "'"
1316: 
1317:             IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalMunic") > 0
1318:                 IF USED("cursor_4c_LocalMunic")
1319:                     SELECT cursor_4c_LocalMunic
1320:                     GO TOP IN cursor_4c_LocalMunic
1321:                     IF !EOF("cursor_4c_LocalMunic")
1322:                         loc_nRtC = INT(VAL(ALLTRIM(TRANSFORM(cursor_4c_LocalMunic.Codigos))))
1323:                     ENDIF
1324:                 ENDIF
1325:             ENDIF
1326: 
1327:             IF USED("cursor_4c_LocalMunic")
1328:                 USE IN cursor_4c_LocalMunic
1329:             ENDIF
1330: 
1331:             par_oObC.Value    = loc_nRtC
1332:             par_oObC.Refresh()
1333:             par_oObC.ForeColor = IIF(loc_nRtC = 9999999, RGB(255,0,0), RGB(0,0,0))
1334: 
1335:             *-- Buscar codigo IBGE da UF
1336:             loc_cQuery = "SELECT UFIBGEs FROM SigCdUfs " + ;
1337:                         "WHERE Estados = '" + PADR(par_cUFs, 2) + "'"
1338: 
1339:             IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalUF") > 0
1340:                 IF USED("cursor_4c_LocalUF")
1341:                     SELECT cursor_4c_LocalUF

*-- Linhas 1357 a 1410:
1357:         CATCH TO loc_oErro
1358:             MsgErro(loc_oErro.Message + CHR(13) + ;
1359:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1360:                 "Procedure: " + loc_oErro.Procedure, ;
1361:                 "Erro em checaibge")
1362:         ENDTRY
1363:     ENDPROC
1364: 
1365:     *============================================================
1366:     * ConfigurarPaginaDados2 - Aplica overrides visuais do SCX
1367:     * legado nos controles internos de cnt_4c_Conta.pgframeDados2
1368:     * (aba de Dados Pessoais/Comerciais do cliente).
1369:     *============================================================
1370:     PROTECTED PROCEDURE ConfigurarPaginaDados2
1371:         LOCAL loc_oPgf, loc_oPg2, loc_oErro
1372: 
1373:         IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
1374:             RETURN
1375:         ENDIF
1376:         IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
1377:             RETURN
1378:         ENDIF
1379: 
1380:         loc_oPgf = THIS.cnt_4c_Conta.pgframeDados
1381: 
1382:         IF !PEMSTATUS(loc_oPgf, "pgframeDados2", 5)
1383:             RETURN
1384:         ENDIF
1385:         loc_oPg2 = loc_oPgf.pgframeDados2
1386: 
1387:         TRY
1388:             IF PEMSTATUS(loc_oPg2, "FontName", 5)
1389:                 loc_oPg2.FontName = "Tahoma"
1390:             ENDIF
1391:             IF PEMSTATUS(loc_oPg2, "ForeColor", 5)
1392:                 loc_oPg2.ForeColor = RGB(90,90,90)
1393:             ENDIF
1394: 
1395:             *-- Say4 (label)
1396:             IF PEMSTATUS(loc_oPg2, "Say4", 5)
1397:                 WITH loc_oPg2.Say4
1398:                     .FontName  = "Tahoma"
1399:                     .Left      = 72
1400:                     .ForeColor = RGB(90,90,90)
1401:                 ENDWITH
1402:             ENDIF
1403: 
1404:             *-- Say5 (label)
1405:             IF PEMSTATUS(loc_oPg2, "Say5", 5)
1406:                 WITH loc_oPg2.Say5
1407:                     .FontName  = "Tahoma"
1408:                     .Left      = 76
1409:                     .ForeColor = RGB(90,90,90)
1410:                 ENDWITH

*-- Linhas 1633 a 1968:
1633:         CATCH TO loc_oErro
1634:             MsgErro(loc_oErro.Message + CHR(13) + ;
1635:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1636:                 "Procedure: " + loc_oErro.Procedure, ;
1637:                 "Erro em ConfigurarPaginaDados2")
1638:         ENDTRY
1639:     ENDPROC
1640: 
1641:     *============================================================
1642:     * BtnIncluirClick - Limpar clsconta para inclusao de novo cliente
1643:     *============================================================
1644:     PROCEDURE BtnIncluirClick
1645:         LOCAL loc_lRet, loc_oErro
1646:         TRY
1647:             THIS.pcEscolha       = "INSERIR"
1648:             THIS.this_cModoAtual = "INCLUIR"
1649:             THIS.plaltcd         = .F.
1650:             THIS.this_cCli       = SPACE(10)
1651:             THIS.RetCodCliente   = " "
1652:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1653:                 loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, SPACE(10), "1", ;
1654:                     THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
1655:                 IF loc_lRet
1656:                     THIS.cnt_4c_Conta.Visible = .T.
1657:                     THIS.cnt_4c_Conta.Refresh()
1658:                     IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1659:                         THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
1660:                     ENDIF
1661:                 ELSE
1662:                     MsgErro("Erro ao inicializar formul" + CHR(225) + "rio para inclus" + CHR(227) + "o.", "Erro")
1663:                 ENDIF
1664:             ENDIF
1665:         CATCH TO loc_oErro
1666:             MsgErro(loc_oErro.Message + CHR(13) + ;
1667:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1668:                 "Procedure: " + loc_oErro.Procedure, ;
1669:                 "Erro em BtnIncluirClick")
1670:         ENDTRY
1671:     ENDPROC
1672: 
1673:     *============================================================
1674:     * BtnAlterarClick - Recarregar cliente em modo de alteracao
1675:     *============================================================
1676:     PROCEDURE BtnAlterarClick
1677:         LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
1678:         TRY
1679:             *-- Obter codigo do cliente atual do controle interno do clsconta
1680:             loc_cCodigoCli = ""
1681:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1682:                 IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
1683:                    PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
1684:                    PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
1685:                     loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
1686:                 ENDIF
1687:             ENDIF
1688:             IF EMPTY(loc_cCodigoCli)
1689:                 loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
1690:             ENDIF
1691: 
1692:             IF EMPTY(loc_cCodigoCli)
1693:                 MsgAviso("Nenhum cliente selecionado para altera" + CHR(231) + CHR(227) + "o.")
1694:                 RETURN
1695:             ENDIF
1696: 
1697:             THIS.pcEscolha       = "ALTERAR"
1698:             THIS.this_cModoAtual = "ALTERAR"
1699:             THIS.plaltcd         = .T.
1700:             THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
1701: 
1702:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1703:                 loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
1704:                     THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
1705:                 IF loc_lRet
1706:                     THIS.cnt_4c_Conta.Visible = .T.
1707:                     THIS.cnt_4c_Conta.Refresh()
1708:                     IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1709:                         THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
1710:                     ENDIF
1711:                 ELSE
1712:                     MsgErro("Erro ao carregar dados para altera" + CHR(231) + CHR(227) + "o.", "Erro")
1713:                 ENDIF
1714:             ENDIF
1715:         CATCH TO loc_oErro
1716:             MsgErro(loc_oErro.Message + CHR(13) + ;
1717:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1718:                 "Procedure: " + loc_oErro.Procedure, ;
1719:                 "Erro em BtnAlterarClick")
1720:         ENDTRY
1721:     ENDPROC
1722: 
1723:     *============================================================
1724:     * BtnVisualizarClick - Modo somente leitura (desabilita gravacao)
1725:     *============================================================
1726:     PROCEDURE BtnVisualizarClick
1727:         LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
1728:         TRY
1729:             loc_cCodigoCli = ""
1730:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1731:                 IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
1732:                    PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
1733:                    PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
1734:                     loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
1735:                 ENDIF
1736:             ENDIF
1737:             IF EMPTY(loc_cCodigoCli)
1738:                 loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
1739:             ENDIF
1740: 
1741:             IF EMPTY(loc_cCodigoCli)
1742:                 MsgAviso("Nenhum cliente selecionado para visualiza" + CHR(231) + CHR(227) + "o.")
1743:                 RETURN
1744:             ENDIF
1745: 
1746:             THIS.this_cModoAtual = "VISUALIZAR"
1747:             THIS.pcEscolha       = "VISUALIZAR"
1748: 
1749:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1750:                 loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, PADR(loc_cCodigoCli, 10), "1", ;
1751:                     THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
1752:                 IF loc_lRet
1753:                     THIS.cnt_4c_Conta.Visible = .T.
1754:                     THIS.cnt_4c_Conta.Refresh()
1755:                 ENDIF
1756:             ENDIF
1757: 
1758:             *-- Desabilitar botao OK em modo de visualizacao (impede gravacao acidental)
1759:             IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1760:                 THIS.cmg_4c_Sair.Buttons(1).Enabled = .F.
1761:             ENDIF
1762:         CATCH TO loc_oErro
1763:             MsgErro(loc_oErro.Message + CHR(13) + ;
1764:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1765:                 "Procedure: " + loc_oErro.Procedure, ;
1766:                 "Erro em BtnVisualizarClick")
1767:         ENDTRY
1768:     ENDPROC
1769: 
1770:     *============================================================
1771:     * BtnExcluirClick - Confirmar e excluir cliente atual
1772:     *============================================================
1773:     PROCEDURE BtnExcluirClick
1774:         LOCAL loc_cCodigoCli, loc_lConfirma, loc_lSucesso, loc_cSQL, loc_oErro
1775:         TRY
1776:             loc_cCodigoCli = ""
1777:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1778:                 IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
1779:                    PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
1780:                    PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
1781:                     loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
1782:                 ENDIF
1783:             ENDIF
1784:             IF EMPTY(loc_cCodigoCli)
1785:                 loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
1786:             ENDIF
1787: 
1788:             IF EMPTY(loc_cCodigoCli)
1789:                 MsgAviso("Nenhum cliente selecionado para exclus" + CHR(227) + "o.")
1790:                 RETURN
1791:             ENDIF
1792: 
1793:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do cliente " + ;
1794:                 loc_cCodigoCli + "?" + CHR(13) + ;
1795:                 "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
1796:                 "Exclus" + CHR(227) + "o de Cliente")
1797: 
1798:             IF !loc_lConfirma
1799:                 RETURN
1800:             ENDIF
1801: 
1802:             *-- Executar exclusao via BO
1803:             THIS.this_oBusinessObject.this_cIclis = loc_cCodigoCli
1804:             loc_lSucesso = THIS.this_oBusinessObject.Excluir()
1805: 
1806:             IF loc_lSucesso
1807:                 THIS.RetCodCliente = " "
1808:                 THIS.Release()
1809:             ELSE
1810:                 MsgErro("Erro ao excluir o cliente." + CHR(13) + ;
1811:                     THIS.this_oBusinessObject.this_cMensagemErro, ;
1812:                     "Erro na Exclus" + CHR(227) + "o")
1813:             ENDIF
1814:         CATCH TO loc_oErro
1815:             MsgErro(loc_oErro.Message + CHR(13) + ;
1816:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1817:                 "Procedure: " + loc_oErro.Procedure, ;
1818:                 "Erro em BtnExcluirClick")
1819:         ENDTRY
1820:     ENDPROC
1821: 
1822:     *============================================================
1823:     * CarregarLista - Recarregar dados do cliente atual via clsconta.mLeDados
1824:     * (este form nao possui grade de listagem - "lista" = estado atual do cliente)
1825:     *============================================================
1826:     PROCEDURE CarregarLista
1827:         LOCAL loc_lRet, loc_oErro
1828:         TRY
1829:             IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
1830:                 loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
1831:                     THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
1832:                 IF loc_lRet
1833:                     THIS.cnt_4c_Conta.Visible = .T.
1834:                     THIS.cnt_4c_Conta.Refresh()
1835:                 ELSE
1836:                     MsgErro("Erro ao recarregar dados do cliente.", "Erro")
1837:                 ENDIF
1838:             ENDIF
1839:         CATCH TO loc_oErro
1840:             MsgErro(loc_oErro.Message + CHR(13) + ;
1841:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1842:                 "Procedure: " + loc_oErro.Procedure, ;
1843:                 "Erro em CarregarLista")
1844:         ENDTRY
1845:     ENDPROC
1846: 
1847:     *============================================================
1848:     * AjustarBotoesPorModo - Habilitar/desabilitar botoes conforme modo
1849:     *============================================================
1850:     PROCEDURE AjustarBotoesPorModo
1851:         LOCAL loc_lHabilitaOk
1852:         loc_lHabilitaOk = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
1853:         IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1854:             THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHabilitaOk
1855:         ENDIF
1856:     ENDPROC
1857: 
1858:     *============================================================
1859:     * HabilitarCampos - Habilitar ou desabilitar campos conforme modo
1860:     * O clsconta gerencia seus campos internamente; aqui so se controla
1861:     * o botao de confirmacao.
1862:     *============================================================
1863:     PROCEDURE HabilitarCampos
1864:         LPARAMETERS par_lHabilitar
1865:         IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1866:             THIS.cmg_4c_Sair.Buttons(1).Enabled = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
1867:         ENDIF
1868:     ENDPROC
1869: 
1870:     *============================================================
1871:     * LimparCampos - Limpar e reinicializar para novo cliente
1872:     *============================================================
1873:     PROCEDURE LimparCampos
1874:         THIS.this_cCli       = SPACE(10)
1875:         THIS.RetCodCliente   = " "
1876:         THIS.pcEscolha       = "INSERIR"
1877:         THIS.this_cModoAtual = "INCLUIR"
1878:         THIS.plaltcd         = .F.
1879:         THIS.CarregarLista()
1880:     ENDPROC
1881: 
1882:     *============================================================
1883:     * FormParaBO - Transferencia form -> BO
1884:     * O clsconta (mGravaDados) gerencia transferencia internamente.
1885:     *============================================================
1886:     PROCEDURE FormParaBO
1887:         RETURN .T.
1888:     ENDPROC
1889: 
1890:     *============================================================
1891:     * BOParaForm - Transferencia BO -> form
1892:     * O clsconta (mLeDados) gerencia transferencia internamente.
1893:     *============================================================
1894:     PROCEDURE BOParaForm
1895:         RETURN .T.
1896:     ENDPROC
1897: 
1898:     *============================================================
1899:     * BtnSalvarClick - Alias de BtnOkClick (validar e gravar)
1900:     *============================================================
1901:     PROCEDURE BtnSalvarClick
1902:         THIS.BtnOkClick()
1903:     ENDPROC
1904: 
1905:     *============================================================
1906:     * BtnEncerrarClick - Fechar sem gravar (alias de BtnCancelarClick)
1907:     *============================================================
1908:     PROCEDURE BtnEncerrarClick
1909:         THIS.BtnCancelarClick()
1910:     ENDPROC
1911: 
1912:     *============================================================
1913:     * BtnBuscarClick - Abrir busca de cliente para carregar em edicao
1914:     *============================================================
1915:     PROCEDURE BtnBuscarClick
1916:         LOCAL loc_oBusca, loc_cCodigoCli, loc_lSelecionou, loc_oErro
1917:         TRY
1918:             loc_cCodigoCli = ""
1919:             loc_lSelecionou = .F.
1920: 
1921:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1922:                 "SigCdCli", "cursor_4c_BuscaCli", "IClis", "", ;
1923:                 "Sele" + CHR(231) + CHR(227) + "o de Cliente", .T., .T., "")
1924: 
1925:             IF VARTYPE(loc_oBusca) = "O"
1926:                 loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1927:                 loc_oBusca.mAddColuna("RClis", "",           "Nome")
1928:                 loc_oBusca.Show()
1929: 
1930:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1931:                     SELECT cursor_4c_BuscaCli
1932:                     GO TOP IN cursor_4c_BuscaCli
1933:                     IF !EOF("cursor_4c_BuscaCli")
1934:                         loc_cCodigoCli = ALLTRIM(cursor_4c_BuscaCli.IClis)
1935:                     ENDIF
1936:                     USE IN cursor_4c_BuscaCli
1937:                     loc_lSelecionou = !EMPTY(loc_cCodigoCli)
1938:                 ENDIF
1939:                 loc_oBusca = .NULL.
1940:             ENDIF
1941: 
1942:             IF loc_lSelecionou
1943:                 THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
1944:                 THIS.pcEscolha       = "ALTERAR"
1945:                 THIS.this_cModoAtual = "ALTERAR"
1946:                 THIS.plaltcd         = .T.
1947:                 THIS.CarregarLista()
1948:                 THIS.AjustarBotoesPorModo()
1949:             ENDIF
1950: 
1951:         CATCH TO loc_oErro
1952:             MsgErro(loc_oErro.Message + CHR(13) + ;
1953:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1954:                 "Procedure: " + loc_oErro.Procedure, ;
1955:                 "Erro em BtnBuscarClick")
1956:         ENDTRY
1957:     ENDPROC
1958: 
1959:     *============================================================
1960:     PROCEDURE Destroy
1961:     *============================================================
1962:         IF !ISNULL(THIS.this_oBusinessObject)
1963:             THIS.this_oBusinessObject = .NULL.
1964:         ENDIF
1965:         DODEFAULT()
1966:     ENDPROC
1967: 
1968: ENDDEFINE

