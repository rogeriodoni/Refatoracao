# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PrepararCursoresRelatorio()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarReportForm()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1482 linhas total):

*-- Linhas 26 a 125:
26: *   cntBotoes (Top=-7 Left=558 Width=252 Height=96, Visible=.F. no Init) ->
27: *     btnReport (CommandGroup, 3 botoes: Imprimir/Sair/Visualizar - aparece
28: *     SOMENTE apos o processamento, equivalente ao toggle de Visible no
29: *     Init/Procedure do legado)
30: *   btnReport (CommandGroup direto no form, Top=90 Left=316, 2 botoes:
31: *     Processar/Encerrar - visivel desde o Init, eh o disparo do
32: *     processamento)
33: *
34: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, InicializarForm,
35: *            cabecalho). Containers de botoes criados VAZIOS (posicao/
36: *            visibilidade do dump), sem os CommandGroup internos.
37: *
38: * Fase 4 (esta) - ConfigurarBotoesReport() monta o CommandGroup
39: *            obj_4c_CmdGReport dentro de cnt_4c_Botoes (3 botoes:
40: *            Imprimir/Encerrar/Visualizar, posicoes RELATIVAS ao container -
41: *            no legado o CommandGroup ja era filho direto de cntBotoes,
42: *            entao os Left/Top do dump sao usados sem ajuste) e
43: *            ConfigurarBotoesAcao() monta obj_4c_CmdGProcessar dentro de
44: *            cnt_4c_BotoesAcao (2 botoes: Processar/Encerrar). ATENCAO: no
45: *            legado esse 2o CommandGroup era filho DIRETO de SIGPRICT
46: *            (Top=90 Left=316); a Fase 3 criou cnt_4c_BotoesAcao EXATAMENTE
47: *            nesse retangulo (Top=90 Left=316 Width=160 Height=85), logo o
48: *            CommandGroup dentro dele usa Top=0/Left=0 (preenche o
49: *            container) - os Left/Top de cada botao MEMBRO (Command1/
50: *            Command2) continuam os do dump, pois sao relativos ao proprio
51: *            grupo e nao ao form. So estrutura visual, sem BINDEVENT ainda.
52: *
53: * Roteiro das proximas fases (documentado aqui para nao divergir depois):
54: *   Fase 5 (esta, PARTE 1/2) - ConfigurarFiltroPeriodo() com a linha "Data
55: *            Inicial": lbl_4c_Label2 ("Inicial : ") + txt_4c_DataI
56: *            (Get_DataI) + lbl_4c_Label4 (duplicata " Periodo " oculta no
57: *            proprio SCX, mantida Visible=.F.)
58: *   Fase 6 (PARTE 2/2) - mesmo metodo, linha "Data Final": lbl_4c_Label3
59: *            ("Final : ") + txt_4c_DataF (Get_DataF) + lbl_4c_Label1
60: *            (" Periodo " visivel) + FormParaBO/BOParaForm do par de datas +
61: *            BINDEVENT de KeyPress dos dois TextBox (padrao
62: *            FormSigPrGf1.ConfigurarFiltroPeriodo) + ValidarPeriodo(), a
63: *            regra dos tres guards que o Click do btnReport legado aplica
64: *            SOBRE esses dois campos (eles sao os unicos digitaveis do SCX
65: *            e nao tem Valid proprio, entao a validacao deles eh entrega
66: *            DESTA fase - ver comentario do metodo)
67: *   Fase 7/8 (esta) - eventos dos dois CommandGroup:
68: *            obj_4c_CmdGProcessar: BtnProcessarClick (ValidarPeriodo() +
69: *              confirma + this_oBusinessObject.Processar() + AposProcessar(),
70: *              que mostra o grupo obj_4c_CmdGReport quando ha inconsistencia
71: *              ou grava o arquivo direto quando nao ha) / BtnEncerrarClick
72: *              (fecha o form).
73: *            obj_4c_CmdGReport: BtnImprimirClick/BtnVisualizarClick (monta os
74: *              cursores de nome literal "SemConta"/"Cabecalho" que o
75: *              SigPrIct.frx exige - PrepararCursoresRelatorio() - executa o
76: *              REPORT FORM via ExecutarReportForm() e grava o arquivo em
77: *              seguida) / BtnEncerrarReportClick (grava o arquivo e fecha,
78: *              reproduzindo o Click do botao MAIS o Click do grupo do
79: *              legado - ver comentario do metodo).
80: *            GravarArquivoContabil() reproduz a parte de UI do PROCEDURE
81: *              gravar legado (a parte de negocio mora no BO,
82: *              GravarArquivosContabeis - Fase 2).
83: *
84: *   Fase 8 (esta) - eventos AUXILIARES e consolidacao. O que faltava era UM
85: *            passo de UI do PROCEDURE processamento legado, perdido na
86: *            migracao: o dialogo das DIFERENCAS e o despacho para a tela
87: *            SigReDif. O BO ja calculava this_lPossuiDiferenca/
88: *            this_nTotalDiferencas (VerificarDiferencas) e ja expunha
89: *            ObterCursorDiferencas()/ObterCursorMovimento() - e NENHUM ponto
90: *            do Form consumia os quatro, superficie de BO morta sendo o
91: *            proprio sintoma. Entregas:
92: *              ExibirDiferencas()           - "If Reccount() > 0 And
93: *                Messagebox('Visualizar as diferencas na Tela?',4+32,
94: *                'Visualizar') = 6 / Do Form SigReDif With
95: *                Thisform.DataSessionId", chamado no INICIO de
96: *                AposProcessar() porque no legado ele vem ANTES do ramo
97: *                SemConta. Monta os alias de contrato que
98: *                SigReDifBO.PrepararDados exige por nome LITERAL (movaux e
99: *                dif2) e abre FormSigReDif(THIS.DataSessionId) com o Show()
100: *                FORA do TRY (regra #29, form modal).
101: *              LiberarCursoresDiferencas()  - fecha movaux/dif2/crGrid; usado
102: *                antes de montar, depois do Show() e em Destroy().
103: *
104: * NAO possui CarregarLista()/AjustarBotoesPorModo()/HabilitarCampos()/
105: * LimparCampos()/BtnSalvarClick()/BtnCancelarClick()/BtnBuscarClick(): o
106: * dump legado nao tem lista, nao tem grade, nao tem os modos LISTA/INCLUIR/
107: * ALTERAR/VISUALIZAR e nao grava registro em tabela nenhuma (mesma decisao
108: * de projeto registrada em FormSigPrGf1 - criar esses metodos aqui produziria
109: * casca vazia sem correspondente no legado, que a regra de completude
110: * proibe).
111: *==============================================================================
112: 
113: DEFINE CLASS FormSigPrIct AS FormBase
114: 
115:     *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
116:     *-- SIGPRICT.SCX: Width=800, Height=192 (SECAO 2) - dialogo de
117:     *-- filtro/processamento, sem necessidade de escalar para o canonico
118:     *-- 1000x600 (esse canonico vale para forms CRUD frmcadastro).
119:     Width        = 800
120:     Height       = 192
121:     AutoCenter   = .T.
122:     Caption      = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
123:     ShowWindow   = 1
124:     WindowType   = 1
125:     ControlBox   = .F.

*-- Linhas 145 a 274:
145: 
146:     *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
147:     *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
148:     *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show()
149:     *-- retorna na hora, a LOCAL sai de escopo e o form eh destruido (pisca e
150:     *-- some) - mesmo raciocinio de FormSigPrGf1.
151: 
152:     *==========================================================================
153:     * Init - Sem parametros recebidos do chamador (form aberto direto pelo
154:     * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
155:     *==========================================================================
156:     PROCEDURE Init()
157:         RETURN DODEFAULT()
158:     ENDPROC
159: 
160:     *==========================================================================
161:     * InicializarForm - Instancia o BO e monta a estrutura visual (cabecalho
162:     * + os dois containers de botoes, cada um com seu CommandGroup interno -
163:     * ConfigurarBotoesReport/ConfigurarBotoesAcao, Fase 4).
164:     *==========================================================================
165:     PROTECTED PROCEDURE InicializarForm()
166:         LOCAL loc_lSucesso, loc_oErro
167:         loc_lSucesso = .F.
168: 
169:         TRY
170:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrIctBO")
171: 
172:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
173:                 THIS.Picture = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"
174: 
175:                 THIS.ConfigurarPageFrame()
176: 
177:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
178:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
179: 
180:                 THIS.TornarControlesVisiveis(THIS)
181:                 THIS.Visible = .T.
182: 
183:                 loc_lSucesso = .T.
184:             ELSE
185:                 MsgErro("Erro ao criar SigPrIctBO. VARTYPE retornou: " + ;
186:                     VARTYPE(THIS.this_oBusinessObject), "FormSigPrIct.InicializarForm")
187:             ENDIF
188:         CATCH TO loc_oErro
189:             MsgErro(loc_oErro.Message + CHR(13) + ;
190:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
191:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrIct.InicializarForm")
192:         ENDTRY
193: 
194:         RETURN loc_lSucesso
195:     ENDPROC
196: 
197:     *==========================================================================
198:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRICT nao tem
199:     * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
200:     * como ponto de entrada arquitetural padrao (mesmo papel em
201:     * FormSigPrGf1/FormFop/FormEnd).
202:     *==========================================================================
203:     PROTECTED PROCEDURE ConfigurarPageFrame()
204:         THIS.ConfigurarCabecalho()
205:         THIS.ConfigurarContainerBotoesReport()
206:         THIS.ConfigurarContainerBotoesAcao()
207:         THIS.ConfigurarFiltroPeriodo()
208: 
209:         *-- Reposicionamento do Init legado - so passa a importar a partir
210:         *-- desta fase, que implementa o show/hide de cnt_4c_Botoes (Fase 7/8):
211:         *--     .cntBotoes.Top  = ThisForm.btnReport.Top  + 60
212:         *--     .cntBotoes.Left = ThisForm.btnReport.Left - 69
213:         *-- "ThisForm.btnReport" (o CommandGroup Processar/Encerrar) eh
214:         *-- THIS.cnt_4c_BotoesAcao aqui (o container ocupa o MESMO retangulo
215:         *-- do CommandGroup legado - ver ConfigurarContainerBotoesAcao).
216:         *-- cnt_4c_Botoes continua Visible = .F.; isto so prepara a posicao de
217:         *-- repouso para quando AposProcessar() o mostrar.
218:         THIS.cnt_4c_Botoes.Top  = THIS.cnt_4c_BotoesAcao.Top  + 60
219:         THIS.cnt_4c_Botoes.Left = THIS.cnt_4c_BotoesAcao.Left - 69
220:     ENDPROC
221: 
222:     *==========================================================================
223:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
224:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
225:     * BackColor=RGB(100,100,100) (SECAO 2) - copiado sem escala, pois
226:     * THIS.Width ja eh 800 (identico ao legado).
227:     *
228:     * lblSombra/lblTitulo no dump trazem Caption="Cadastro de Testes" (texto
229:     * generico de template, nao atualizado pelo legado para este form
230:     * especifico) - por isso, igual a FormSigPrGf1, o Caption real eh
231:     * atribuido em runtime a partir de THIS.Caption (InicializarForm), nunca
232:     * o literal do dump.
233:     *==========================================================================
234:     PROTECTED PROCEDURE ConfigurarCabecalho()
235:         LOCAL loc_oCnt, loc_oErro
236: 
237:         TRY
238:             THIS.AddObject("cnt_4c_Sombra", "Container")
239:             loc_oCnt = THIS.cnt_4c_Sombra
240:             WITH loc_oCnt
241:                 .Top         = 0
242:                 .Left        = 0
243:                 .Width       = THIS.Width
244:                 .Height      = 80
245:                 .BorderWidth = 0
246:                 .BackColor   = RGB(100, 100, 100)
247:                 .Visible     = .T.
248:             ENDWITH
249: 
250:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
251:             WITH loc_oCnt.lbl_4c_LblSombra
252:                 .FontBold      = .T.
253:                 .FontName      = "Tahoma"
254:                 .FontSize      = 18
255:                 .FontUnderline = .F.
256:                 .WordWrap      = .T.
257:                 .Alignment     = 0
258:                 .BackStyle     = 0
259:                 .AutoSize      = .F.
260:                 .Caption       = THIS.Caption
261:                 .Height        = 40
262:                 .Left          = 10
263:                 .Top           = 0
264:                 .Width         = 769
265:                 .ForeColor     = RGB(0, 0, 0)
266:                 .Visible       = .T.
267:             ENDWITH
268: 
269:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
270:             WITH loc_oCnt.lbl_4c_LblTitulo
271:                 .FontBold   = .T.
272:                 .FontName   = "Tahoma"
273:                 .FontSize   = 18
274:                 .WordWrap   = .T.

*-- Linhas 286 a 377:
286:         CATCH TO loc_oErro
287:             MsgErro(loc_oErro.Message + CHR(13) + ;
288:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
289:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
290:         ENDTRY
291:     ENDPROC
292: 
293:     *==========================================================================
294:     * ConfigurarContainerBotoesReport - Container equivalente ao cntBotoes
295:     * legado (Top=-7, Left=558, Width=252, Height=96, BackStyle=0,
296:     * BorderWidth=0, Visible=.F. - SECAO 2). No legado ele hospeda o
297:     * CommandGroup btnReport (3 botoes: Imprimir/Sair/Visualizar), que so
298:     * aparece DEPOIS do processamento (Procedure Gravar faz
299:     * ThisForm.cntBotoes.Visible = .t. - essa troca de Visible fica para a
300:     * Fase 7/8, junto com BtnProcessarClick). Aqui (Fase 4) o container
301:     * continua Visible=.F. e ganha o CommandGroup obj_4c_CmdGReport, ja
302:     * configurado por dentro.
303:     *==========================================================================
304:     PROTECTED PROCEDURE ConfigurarContainerBotoesReport()
305:         LOCAL loc_oErro
306: 
307:         TRY
308:             THIS.AddObject("cnt_4c_Botoes", "Container")
309:             WITH THIS.cnt_4c_Botoes
310:                 .Top         = -7
311:                 .Left        =  542
312:                 .Width       = 252
313:                 .Height      = 96
314:                 .BackStyle   = 0
315:                 .BorderWidth = 0
316:                 .Visible     = .F.
317:             ENDWITH
318: 
319:             THIS.ConfigurarBotoesReport()
320:         CATCH TO loc_oErro
321:             MsgErro(loc_oErro.Message + CHR(13) + ;
322:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
323:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesReport")
324:         ENDTRY
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * ConfigurarBotoesReport - CommandGroup obj_4c_CmdGReport, filho de
329:     * cnt_4c_Botoes. Transcrito de SIGPRICT.cntBotoes.btnReport (SECAO 2):
330:     * ButtonCount=3, AutoSize=.T., BackStyle=0, BorderStyle=0,
331:     * SpecialEffect=1, BorderColor=RGB(136,189,188), Height=85, Left=12,
332:     * Top=5, Width=235. Left/Top sao RELATIVOS a cnt_4c_Botoes (no legado o
333:     * CommandGroup ja era filho direto do container) - nao ha offset a
334:     * aplicar. Icones de vbmp\ via gc_4c_CaminhoIcones (regra #25 - nomes
335:     * EXATOS do dump, nunca inventados).
336:     *==========================================================================
337:     PROTECTED PROCEDURE ConfigurarBotoesReport()
338:         WITH THIS.cnt_4c_Botoes
339:             .AddObject("obj_4c_CmdGReport", "CommandGroup")
340:             .Visible     = .T.
341:         ENDWITH
342: 
343:         WITH THIS.cnt_4c_Botoes.obj_4c_CmdGReport
344:             .ButtonCount   = 3
345:             .AutoSize      = .T.
346:             .BackStyle     = 0
347:             .BorderStyle   = 0
348:             .SpecialEffect = 1
349:             .BorderColor   = RGB(136, 189, 188)
350:             .Top           = 5
351:             .Left          = 12
352:             .Width         = 235
353:             .Height        = 85
354:             .Value         = 1
355: 
356:             WITH .Buttons(1)
357:                 .Top            = 5
358:                 .Left           = 80
359:                 .Width          = 75
360:                 .Height         = 75
361:                 .FontName       = "Tahoma"
362:                 .FontSize       = 8
363:                 .FontBold       = .T.
364:                 .FontItalic     = .T.
365:                 .WordWrap       = .T.
366:                 .PicturePosition = 13
367:                 .Picture        = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
368:                 .Caption        = "\<Impressora"
369:                 .ForeColor      = RGB(90, 90, 90)
370:                 .BackColor      = RGB(255, 255, 255)
371:                 .Themes         = .F.
372:             ENDWITH
373: 
374:             WITH .Buttons(2)
375:                 .Top        = 5
376:                 .Left       = 155
377:                 .Width      = 75

*-- Linhas 411 a 502:
411:         *-- Eventos (Fase 7/8) - um handler por botao, igual ao dump legado
412:         *-- (Command1/btnImprimir, Command2/btnSair, Command3/btnVisualizar
413:         *-- tem Click PROPRIO, diferente um do outro).
414:         BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(1), "Click", THIS, "BtnImprimirClick")
415:         BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(2), "Click", THIS, "BtnEncerrarReportClick")
416:         BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(3), "Click", THIS, "BtnVisualizarClick")
417:     ENDPROC
418: 
419:     *==========================================================================
420:     * ConfigurarContainerBotoesAcao - No legado, o segundo CommandGroup
421:     * btnReport (2 botoes: Processar/Encerrar, Top=90 Left=316 Width=160
422:     * Height=85 - SECAO 2) eh filho DIRETO de SIGPRICT, sem container
423:     * proprio. Aqui ele ganha um container fino (cnt_4c_BotoesAcao) na MESMA
424:     * posicao/tamanho do CommandGroup legado, para manter o padrao do
425:     * projeto de "um container por grupo de botoes".
426:     *==========================================================================
427:     PROTECTED PROCEDURE ConfigurarContainerBotoesAcao()
428:         LOCAL loc_oErro
429: 
430:         TRY
431:             THIS.AddObject("cnt_4c_BotoesAcao", "Container")
432:             WITH THIS.cnt_4c_BotoesAcao
433:                 .Top         = 90
434:                 .Left        = 316
435:                 .Width       = 160
436:                 .Height      = 85
437:                 .BackStyle   = 0
438:                 .BorderWidth = 0
439:                 .Visible     = .T.
440:             ENDWITH
441: 
442:             THIS.ConfigurarBotoesAcao()
443:         CATCH TO loc_oErro
444:             MsgErro(loc_oErro.Message + CHR(13) + ;
445:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
446:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesAcao")
447:         ENDTRY
448:     ENDPROC
449: 
450:     *==========================================================================
451:     * ConfigurarBotoesAcao - CommandGroup obj_4c_CmdGProcessar, filho de
452:     * cnt_4c_BotoesAcao. Transcrito de SIGPRICT.btnReport (SECAO 2):
453:     * ButtonCount=2, AutoSize=.T., BackStyle=0, BorderStyle=0,
454:     * SpecialEffect=1, BorderColor=RGB(136,189,188), Width=160, Height=85.
455:     * No legado esse CommandGroup era filho DIRETO do form (Top=90
456:     * Left=316); como cnt_4c_BotoesAcao foi criado EXATAMENTE nesse
457:     * retangulo (ConfigurarContainerBotoesAcao), o grupo aqui usa Top=0/
458:     * Left=0 para preencher o container - os Left/Top de Buttons(1)/
459:     * Buttons(2) sao relativos ao GRUPO (nao ao form) e continuam os do
460:     * dump, sem ajuste.
461:     *==========================================================================
462:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
463:         WITH THIS.cnt_4c_BotoesAcao
464:             .AddObject("obj_4c_CmdGProcessar", "CommandGroup")
465:             .Visible     = .T.
466:         ENDWITH
467: 
468:         WITH THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar
469:             .ButtonCount   = 2
470:             .AutoSize      = .T.
471:             .BackStyle     = 0
472:             .BorderStyle   = 0
473:             .SpecialEffect = 1
474:             .BorderColor   = RGB(136, 189, 188)
475:             .Top           = 0
476:             .Left          = 0
477:             .Width         = 160
478:             .Height        = 85
479:             .Value         = 1
480: 
481:             WITH .Buttons(1)
482:                 .Top        = 5
483:                 .Left       = 5
484:                 .Width      = 75
485:                 .Height     = 75
486:                 .FontName   = "Tahoma"
487:                 .FontSize   = 8
488:                 .FontBold   = .T.
489:                 .FontItalic = .T.
490:                 .WordWrap   = .T.
491:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
492:                 .Caption    = "\<Processar"
493:                 .ForeColor  = RGB(90, 90, 90)
494:                 .BackColor  = RGB(255, 255, 255)
495:                 .Themes     = .F.
496:             ENDWITH
497: 
498:             WITH .Buttons(2)
499:                 .Top        = 5
500:                 .Left       = 80
501:                 .Width      = 75
502:                 .Height     = 75

*-- Linhas 515 a 611:
515:         ENDWITH
516: 
517:         *-- Eventos (Fase 7/8)
518:         BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Buttons(1), "Click", THIS, "BtnProcessarClick")
519:         BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Buttons(2), "Click", THIS, "BtnEncerrarClick")
520:     ENDPROC
521: 
522:     *==========================================================================
523:     * ConfigurarFiltroPeriodo - Campos de filtro de periodo (Fase 5/8 - PARTE
524:     * 1/2). Filhos DIRETOS de THIS (SIGPRICT e form PLANO, sem PageFrame -
525:     * layout.json confirma parent="SIGPRICT" para os quatro objetos desta
526:     * linha e da linha irma).
527:     *
528:     * PARTE 1 (esta fase) - linha "Data Inicial" (Top original 105/108),
529:     * dump SECAO 2:
530:     *   Label2    Top=108 Left=186 Width=39 Caption="Inicial : " -> lbl_4c_Label2
531:     *   Get_DataI Top=105 Left=227 TabIndex=1 (fweditdata)       -> txt_4c_DataI
532:     *   Label4    Top=108 Left=132 Width=51 Caption=" Per" + CHR(237) + "odo "
533:     *             Visible=.F. NO PROPRIO SCX (duplicata oculta do Label1 da
534:     *             linha "Data Final") -> lbl_4c_Label4, MANTIDO OCULTO por
535:     *             fidelidade (regra do projeto: nao reativar o que o legado ja
536:     *             desativou). TornarControlesVisiveis tem excecao explicita
537:     *             para este nome (ver abaixo), senao o laco forcaria
538:     *             Visible=.T. e o duplicado apareceria sobre a linha errada.
539:     *
540:     * PARTE 2 (Fase 6, esta) - linha "Data Final" (Label3/Get_DataF) +
541:     * Label1 (" Periodo " visivel, irmao do Label4 oculto desta parte) +
542:     * FormParaBO/BOParaForm do par de datas + BINDEVENT de KeyPress dos dois
543:     * TextBox - igual ao padrao de FormSigPrGf1.ConfigurarFiltroPeriodo
544:     * (operacoes/FormSigPrGf1.prg), citado nesta mesma funcao.
545:     *
546:     * Label3 "Final : " (Top=141 Left=191 Width=34) e Label1 " Periodo "
547:     * (Top=141 Left=132 Width=51, Visible=.T. no dump - irmao visivel do
548:     * Label4 oculto da linha "Data Inicial") sao transcritos da SECAO 2.
549:     * txt_4c_DataF usa o MESMO Width/Height/Alignment/InputMask/Format de
550:     * txt_4c_DataI (fweditdata, mesma analogia de FormSigPrGf1 - nao vem no
551:     * dump porque a classe eh do framework.vcx, nao extraido).
552:     *
553:     * BO (SigPrIctBO) ja expoe this_dDataI/this_dDataF (Init os preenche com
554:     * DATE()/DATE() - CLAUDE.md regra #16: ConverterParaData() em vez de
555:     * TTOD(), porque o .Value do TextBox pode chegar como DATE/DATETIME/CHAR
556:     * conforme o caminho). FormParaBO/BOParaForm sao a UNICA via de leitura/
557:     * escrita dessas properties - ValidarPeriodo() (abaixo, desta fase) e
558:     * Processar() (Fase 7/8) leem exclusivamente do BO, nunca do TextBox
559:     * direto (PILAR 3: fonte unica da regra); quem espelha a tela no BO
560:     * antes de validar eh o proprio ValidarPeriodo().
561:     *
562:     * Width/Height de txt_4c_DataI (79x25), Alignment=3, InputMask="99/99/9999"
563:     * e Format="K" nao vem do dump (fweditdata herda do framework.vcx, que nao
564:     * foi extraido) - transcritos por analogia de FormSigPrGf1, que usa a
565:     * MESMA classe fweditdata para o mesmo papel (par de datas de filtro de
566:     * periodo em form OPERACIONAL flat). .Value = {} (DATE) e nao {^1900-01-01}
567:     * -  TextBox nasce vazio, igual ao Get_DataI legado antes do Init popular
568:     * (regra ConverterParaData/TTOD-so-aceita-DATETIME sera aplicada na Fase 6,
569:     * quando FormParaBO/BOParaForm lerem/gravarem a property do BO).
570:     *==========================================================================
571:     PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
572:         LOCAL loc_oErro
573: 
574:         TRY
575:             THIS.AddObject("lbl_4c_Label2", "Label")
576:             WITH THIS.lbl_4c_Label2
577:                 .Top       = 108
578:                 .Left      = 186
579:                 .Width     = 39
580:                 .Height    = 15
581:                 .FontName  = "Tahoma"
582:                 .FontSize  = 8
583:                 .BackStyle = 0
584:                 .Alignment = 0
585:                 .AutoSize  = .F.
586:                 .ForeColor = RGB(90, 90, 90)
587:                 .Caption   = "Inicial : "
588:                 .Visible   = .T.
589:             ENDWITH
590: 
591:             THIS.AddObject("txt_4c_DataI", "TextBox")
592:             WITH THIS.txt_4c_DataI
593:                 .Top       = 105
594:                 .Left      = 227
595:                 .Width     = 79
596:                 .Height    = 25
597:                 .FontName  = "Tahoma"
598:                 .FontSize  = 8
599:                 .TabIndex  = 1
600:                 .Alignment = 3
601:                 .Themes    = .F.
602:                 .InputMask = "99/99/9999"
603:                 .Format    = "K"
604:                 .Value     = {}
605:                 .Visible   = .T.
606:             ENDWITH
607: 
608:             *-- Label4: duplicata de " Periodo " oculta no proprio SCX legado
609:             *-- (Visible=.F. - SECAO 2). Criado aqui so para paridade de
610:             *-- objetos (PILAR 2/3 nao exige objeto a mais, mas a regra do
611:             *-- projeto de nao reativar o que o legado desativou vale tambem

*-- Linhas 689 a 1040:
689:             *-- controle nascer tipado DATE antes do BOParaForm preencher.
690:             THIS.BOParaForm()
691: 
692:             *-- Eventos dos campos de periodo. BINDEVENT em "KeyPress" (nunca
693:             *-- "Valid", que nao dispara de forma confiavel em TextBox, nem
694:             *-- "LostFocus", que dispara tambem quando outro controle recebe o
695:             *-- foco). Os handlers apenas SINCRONIZAM o valor digitado com as
696:             *-- properties do BO - o legado tambem nao valida campo a campo
697:             *-- (nem Get_DataI nem Get_DataF tem Valid no SCX; os tres guards
698:             *-- do periodo rodam de uma vez em THIS.ValidarPeriodo(), que a
699:             *-- Fase 7/8 chama do Click do botao Processar, igual ao legado).
700:             BINDEVENT(THIS.txt_4c_DataI, "KeyPress", THIS, "DataIKeyPress")
701:             BINDEVENT(THIS.txt_4c_DataF, "KeyPress", THIS, "DataFKeyPress")
702:         CATCH TO loc_oErro
703:             MsgErro(loc_oErro.Message + CHR(13) + ;
704:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
705:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
706:         ENDTRY
707:     ENDPROC
708: 
709:     *==========================================================================
710:     * DataIKeyPress / DataFKeyPress - handlers de KeyPress dos dois campos de
711:     * periodo, ligados por BINDEVENT (logo PUBLIC - metodo PROTECTED falha em
712:     * silencio, CLAUDE.md regra #3). LPARAMETERS obrigatorio: sem ele o VFP9
713:     * estoura "No PARAMETER statement is found" na primeira tecla digitada.
714:     *
715:     * Nao validam nem exibem mensagem - o legado nao tem Valid em Get_DataI
716:     * nem Get_DataF, e antecipar a mensagem aqui divergiria do PILAR 1 (ao
717:     * sair da Data Inicial com a Final ainda vazia o usuario receberia "Data
718:     * Final Invalida!!!" que o legado nunca exibe nesse momento). Ao
719:     * confirmar o campo (ENTER/TAB) so espelham o valor nas properties do
720:     * BO, que eh de onde ValidarPeriodo() e Processar() leem o periodo.
721:     *==========================================================================
722:     PROCEDURE DataIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
723:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
724:             THIS.FormParaBO()
725:         ENDIF
726:     ENDPROC
727: 
728:     PROCEDURE DataFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
729:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
730:             THIS.FormParaBO()
731:         ENDIF
732:     ENDPROC
733: 
734:     *==========================================================================
735:     * FormParaBO - transporta o par de datas da TELA para this_dDataI/
736:     * this_dDataF no BO. Este form tem exatamente DOIS campos editaveis (o
737:     * periodo de processamento), logo o FormParaBO cobre os dois e nada mais.
738:     *
739:     * ConverterParaData() em vez de TTOD(): o .Value nasce DATE (BOParaForm o
740:     * preenche a partir do BO) mas pode chegar como DATETIME ou CHAR conforme
741:     * o que o usuario digitar - TTOD() com DATE dispara erro 11 em runtime
742:     * (CLAUDE.md regra #16).
743:     *
744:     * PROTECTED explicito: FormBase declara "PROTECTED PROCEDURE FormParaBO()"
745:     * / "PROTECTED PROCEDURE BOParaForm()", e em VFP9 redeclarar na subclasse
746:     * SEM o modificador NAO alarga o escopo herdado (mesma armadilha da regra
747:     * do metodo PROTECTED/BINDEVENT). Nao ha perda: os dois sao chamados so
748:     * de dentro da classe (ConfigurarFiltroPeriodo, DataIKeyPress,
749:     * DataFKeyPress), e nenhum deles esta na lista de metodos que o
750:     * TesteAutomatico.prg invoca de fora.
751:     *==========================================================================
752:     PROTECTED PROCEDURE FormParaBO()
753:         LOCAL loc_lSucesso
754:         loc_lSucesso = .F.
755: 
756:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
757:             THIS.this_oBusinessObject.this_dDataI = ;
758:                 ConverterParaData(THIS.txt_4c_DataI.Value)
759:             THIS.this_oBusinessObject.this_dDataF = ;
760:                 ConverterParaData(THIS.txt_4c_DataF.Value)
761:             loc_lSucesso = .T.
762:         ENDIF
763: 
764:         RETURN loc_lSucesso
765:     ENDPROC
766: 
767:     *==========================================================================
768:     * BOParaForm - caminho inverso: joga this_dDataI/this_dDataF do BO nos
769:     * dois campos. Usado na carga inicial (ConfigurarFiltroPeriodo), onde o
770:     * periodo default eh a data de hoje nos dois campos (SigPrIctBO.Init
771:     * espelhando "Get_Datai.Value = Date() / Get_Dataf.Value = Date()" do
772:     * Init legado). O Form NAO recalcula - le do BO (PILAR 3: fonte unica).
773:     *
774:     * PROTECTED pelo mesmo motivo do FormParaBO acima.
775:     *==========================================================================
776:     PROTECTED PROCEDURE BOParaForm()
777:         LOCAL loc_lSucesso
778:         loc_lSucesso = .F.
779: 
780:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
781:             THIS.txt_4c_DataI.Value = ;
782:                 ConverterParaData(THIS.this_oBusinessObject.this_dDataI)
783:             THIS.txt_4c_DataF.Value = ;
784:                 ConverterParaData(THIS.this_oBusinessObject.this_dDataF)
785:             loc_lSucesso = .T.
786:         ENDIF
787: 
788:         RETURN loc_lSucesso
789:     ENDPROC
790: 
791:     *==========================================================================
792:     * ValidarPeriodo - TRANSCRICAO dos tres guards que o legado escreveu no
793:     * Click do btnReport (SigPrIct_form_codigo_fonte.txt: SIGPRICT.btnReport
794:     * PROCEDURE Click, e o Click identico de SIGPRICT.cntBotoes.btnReport):
795:     *
796:     *     If Empty(ThisForm.Get_DataI.value)
797:     *         Messagebox('Data Inicial Invalida!!!',0+48,'')
798:     *         ThisForm.Get_DataI.SetFocus
799:     *         Return 0
800:     *     Endif
801:     *     If Empty(ThisForm.Get_DataF.value)
802:     *         Messagebox('Data Final Invalida!!!',0+48,'')
803:     *         ThisForm.Get_DataF.SetFocus
804:     *         Return 0
805:     *     Endif
806:     *     If ThisForm.Get_DataF.value < ThisForm.Get_DataI.value
807:     *         Messagebox('A Data Final Nao Pode Ser Menor Que a Inicial!!!', 0+48, '')
808:     *         ThisForm.Get_DataF.SetFocus
809:     *         Return 0
810:     *     Endif
811:     *
812:     * Esta eh a regra dos DOIS campos digitaveis que esta fase entrega:
813:     * Get_DataI/Get_DataF sao os UNICOS controles de entrada do SCX (SECAO 2
814:     * lista 2 textbox, 6 label e 2 commandgroup) e o dump NAO tem Valid, When
815:     * nem LostFocus em nenhum dos dois - toda a validacao do periodo mora no
816:     * Click do botao. Por isso o metodo nasce JUNTO com os campos, e nao na
817:     * fase dos botoes: a Fase 7/8 apenas CHAMA
818:     * (BtnProcessarClick -> IF !THIS.ValidarPeriodo() / RETURN), sem
819:     * reescrever a regra.
820:     *
821:     * A regra em si vive no BO (SigPrIctBO.ValidarPeriodo, Fase 2), que ja
822:     * carrega os tres testes na MESMA ordem e as tres mensagens EXATAS do
823:     * legado em this_cMensagemErro - fonte unica (PILAR 3). O Form faz as
824:     * tres coisas que o BO nao pode fazer: espelhar a tela nas properties,
825:     * exibir a mensagem e devolver o foco ao campo recusado.
826:     *
827:     * FormParaBO() ANTES de validar: no legado os tres guards leem
828:     * "ThisForm.Get_DataI.value" / "Get_DataF.value", isto eh, o TEXTBOX eh a
829:     * fonte do valor - nunca a property guardada de um estado anterior (regra
830:     * do textbox visivel como fonte unica). Sem este espelho, limpar o campo
831:     * na tela e acionar Processar validaria o periodo ANTIGO, que o usuario
832:     * acabou de apagar.
833:     *
834:     * MsgAviso (nao MsgErro): os tres casos sao validacao de UI, e o legado
835:     * usa Messagebox(..., 0+48, ...) - icone de aviso. Chamado SEM titulo, o
836:     * MsgAviso usa "Atencao", equivalente ao titulo vazio do legado.
837:     *
838:     * SetFocus espelhando o legado: o 1o guard devolve o foco a Data Inicial;
839:     * o 2o e o 3o devolvem a Data Final. Como o BO testa a Data Inicial
840:     * primeiro, "Data Inicial vazia" eh o UNICO caso em que txt_4c_DataI
841:     * esta vazio - dai o IF EMPTY() reproduzir exatamente os tres destinos.
842:     *
843:     * PUBLIC (sem PROTECTED): sera chamado de FORA da classe pelos handlers
844:     * de botao da Fase 7/8 e pelo harness de teste; metodo PROTECTED falha em
845:     * silencio nesse uso (CLAUDE.md regra #3), e PEMSTATUS nao protege porque
846:     * so verifica existencia, nao escopo.
847:     *
848:     * RETURN unico, DEPOIS do ENDTRY (CLAUDE.md regra #1 - RETURN dentro de
849:     * TRY/CATCH eh proibido, inclusive o bare).
850:     *==========================================================================
851:     PROCEDURE ValidarPeriodo()
852:         LOCAL loc_lValido, loc_oErro
853:         loc_lValido = .F.
854: 
855:         TRY
856:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
857:                 *-- Tela -> BO: o TextBox eh a fonte do valor, igual ao legado
858:                 THIS.FormParaBO()
859: 
860:                 IF THIS.this_oBusinessObject.ValidarPeriodo()
861:                     loc_lValido = .T.
862:                 ELSE
863:                     *-- Mensagem EXATA do legado, montada pelo BO
864:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)
865: 
866:                     IF EMPTY(THIS.txt_4c_DataI.Value)
867:                         THIS.txt_4c_DataI.SetFocus()
868:                     ELSE
869:                         THIS.txt_4c_DataF.SetFocus()
870:                     ENDIF
871:                 ENDIF
872:             ELSE
873:                 MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
874:                     "o dispon" + CHR(237) + "vel para validar o per" + ;
875:                     CHR(237) + "odo.", "Integra" + CHR(231) + CHR(227) + ;
876:                     "o Cont" + CHR(225) + "bil")
877:             ENDIF
878:         CATCH TO loc_oErro
879:             MsgErro(loc_oErro.Message + CHR(13) + ;
880:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
881:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPeriodo")
882:         ENDTRY
883: 
884:         RETURN loc_lValido
885:     ENDPROC
886: 
887:     *==========================================================================
888:     * BtnProcessarClick - evento do botao "Processar" (obj_4c_CmdGProcessar,
889:     * Buttons(1)). Legado (SIGPRICT.btnReport.Click, ramo This.Value <> 2 -
890:     * os tres guards de periodo ja saem via ValidarPeriodo(), Fase 5/6):
891:     *
892:     *     If Messagebox('Confirma o Processamento ?', 4+32+256, '') = 6
893:     *         ThisForm.Processamento
894:     *     Else
895:     *         Return 0
896:     *     EndIf
897:     *
898:     * this_oBusinessObject.Processar() ja encapsula TODO o Processamento
899:     * legado (Fases 1/2); aqui so resta confirmar e despachar o resultado
900:     * para AposProcessar(), que reproduz o fecho do metodo legado (mostrar o
901:     * grupo de relatorio OU gravar direto, conforme haja inconsistencia).
902:     *==========================================================================
903:     PROCEDURE BtnProcessarClick()
904:         LOCAL loc_oErro
905: 
906:         IF THIS.this_lProcessando
907:             RETURN
908:         ENDIF
909: 
910:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
911:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
912:                 CHR(237) + "vel.", "Erro em FormSigPrIct.BtnProcessarClick")
913:             RETURN
914:         ENDIF
915: 
916:         IF !THIS.ValidarPeriodo()
917:             RETURN
918:         ENDIF
919: 
920:         IF !MsgConfirma("Confirma o Processamento ?")
921:             RETURN
922:         ENDIF
923: 
924:         TRY
925:             THIS.this_lProcessando = .T.
926:             THIS.MousePointer      = 11
927:             THIS.Refresh()
928: 
929:             IF THIS.this_oBusinessObject.Processar()
930:                 THIS.AposProcessar()
931:             ENDIF
932: 
933:             THIS.MousePointer      = 0
934:             THIS.this_lProcessando = .F.
935:         CATCH TO loc_oErro
936:             THIS.MousePointer      = 0
937:             THIS.this_lProcessando = .F.
938:             MsgErro(loc_oErro.Message + CHR(13) + ;
939:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
940:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
941:         ENDTRY
942:     ENDPROC
943: 
944:     *==========================================================================
945:     * AposProcessar - fecho do PROCEDURE processamento legado:
946:     *
947:     *     Select SemConta / Set Order to Conta / Go Top
948:     *     If Not Eof()
949:     *         ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top - 2
950:     *         ThisForm.btnReport.Enabled = .F.
951:     *         ThisForm.Get_Datai.Enabled = .F.
952:     *         ThisForm.Get_Dataf.Enabled = .F.
953:     *         ThisForm.cntBotoes.Visible = .T.
954:     *     Else
955:     *         Select MovAux / Go Top
956:     *         If !Eof()
957:     *             Messagebox('Nenhuma Inconsistencia Foi Encontrada!!!', 32, 'ATENCAO')
958:     *         Else
959:     *             Messagebox('Nao Existe Movimentacao no Periodo!!!', 32, 'ATENCAO')
960:     *         Endif
961:     *         ThisForm.Gravar
962:     *     Endif
963:     *
964:     * "ThisForm.btnReport" (o grupo Processar/Encerrar) eh
965:     * THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar; "ThisForm.cntBotoes" eh
966:     * THIS.cnt_4c_Botoes. this_lPossuiInconsistencia/this_lPossuiMovimento
967:     * sao a FONTE UNICA (BO, Fase 2) - o Form so le, nunca recalcula.
968:     *==========================================================================
969:     PROTECTED PROCEDURE AposProcessar()
970:         *-- Dialogo das DIFERENCAS primeiro, na ordem EXATA do legado: no
971:         *-- PROCEDURE processamento ele vem ANTES do ramo SemConta.
972:         THIS.ExibirDiferencas()
973: 
974:         IF THIS.this_oBusinessObject.this_lPossuiInconsistencia
975:             THIS.cnt_4c_Botoes.Top                              = THIS.cnt_4c_BotoesAcao.Top - 2
976:             THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Enabled = .F.
977:             THIS.txt_4c_DataI.Enabled                           = .F.
978:             THIS.txt_4c_DataF.Enabled                           = .F.
979:             THIS.cnt_4c_Botoes.Visible                          = .T.
980:         ELSE
981:             IF THIS.this_oBusinessObject.this_lPossuiMovimento
982:                 MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada!!!", ;
983:                     "ATEN" + CHR(199) + CHR(195) + "O")
984:             ELSE
985:                 MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + ;
986:                     "o no Per" + CHR(237) + "odo!!!", "ATEN" + CHR(199) + CHR(195) + "O")
987:             ENDIF
988: 
989:             THIS.GravarArquivoContabil()
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * ExibirDiferencas - passo de UI que o PROCEDURE processamento legado
995:     * executa ANTES do ramo SemConta e que a migracao havia perdido. O BO ja
996:     * calculava this_lPossuiDiferenca/this_nTotalDiferencas em
997:     * VerificarDiferencas() e ja expunha ObterCursorDiferencas()/
998:     * ObterCursorMovimento(), mas NENHUM ponto do Form consumia os quatro -
999:     * superficie de BO morta eh exatamente o sintoma. Legado
1000:     * (SigPrIct_form_codigo_fonte.txt, fim do PROCEDURE processamento):
1001:     *
1002:     *     Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As Cred ;
1003:     *         From MovAux Group By Transacaos Into Cursor Dif1
1004:     *     Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
1005:     *     Select * From MovAux Where Transacaos In ( Select Transacaos From dif2 ) ;
1006:     *         Into Cursor diferenca
1007:     *     If Reccount() > 0 And Messagebox("Visualizar as diferencas na Tela?",4+32,"Visualizar") = 6
1008:     *         Do Form SigReDif With Thisform.DataSessionId
1009:     *     Endif
1010:     *
1011:     * O "Reccount() > 0" do legado mede o cursor "diferenca" (alias corrente
1012:     * logo depois do Into Cursor), que aqui eh this_lPossuiDiferenca - FONTE
1013:     * UNICA no BO (PILAR 3), o Form nunca recalcula.
1014:     *
1015:     * MsgConfirma devolve LOGICAL (regra #7 - NUNCA comparar com 6) e exibe
1016:     * Sim/Nao com icone de pergunta, equivalente ao 4+32 do legado; o titulo
1017:     * "Visualizar" eh o do legado. Em modo de teste MsgConfirma devolve .F.,
1018:     * entao o harness headless nunca chega a abrir a tela filha (Show() de
1019:     * form modal travaria a execucao).
1020:     *
1021:     * ALIAS DE CONTRATO (movaux/dif2): SigReDifBO.PrepararDados le os alias de
1022:     * nome LITERAL "movaux" e "dif2" na data session do chamador
1023:     * (IF !USED("movaux") OR !USED("dif2") -> recusa com MsgErro) e monta o
1024:     * crGrid com "Select *, 99999999.99 As Deb1s, 99999999.99 As Cred1s From
1025:     * movaux Where Transacaos In (Select Transacaos From dif2)". Os nomes
1026:     * pertencem AO CONSUMIDOR, nao a arquitetura nova, logo NAO levam prefixo
1027:     * cursor_4c_ - mesma razao de SemConta/Cabecalho em
1028:     * PrepararCursoresRelatorio(). Montados aqui a partir dos cursores do BO:
1029:     *   movaux = cursor_4c_MovAux           (ObterCursorMovimento)
1030:     *   dif2   = Transacaos DISTINTAS de cursor_4c_Diferenca
1031:     *            (ObterCursorDiferencas). Equivalente EXATO ao dif2 legado,
1032:     *            porque "diferenca" E' MovAux filtrado por esse mesmo dif2 -
1033:     *            toda Transacaos de dif2 tem pelo menos uma linha em MovAux
1034:     *            (dif2 nasce de um Group By sobre MovAux). Reconstruir eh
1035:     *            necessario porque VerificarDiferencas() FECHA cursor_4c_Dif2
1036:     *            ao terminar.
1037:     * O "Select *" do crGrid exige que movaux NAO tenha Deb1s/Cred1s -
1038:     * cursor_4c_MovAux nao tem (PrepararCursoresProcesso, Fase 2).
1039:     *
1040:     * DataSessionId: este form tem DataSession = 2 (sessao privada) e

*-- Linhas 1054 a 1313:
1054:     * RETURN unico e SEMPRE fora do TRY/CATCH (regra #1) - os RETURN de
1055:     * guarda ficam ANTES do TRY.
1056:     *==========================================================================
1057:     PROCEDURE ExibirDiferencas()
1058:         LOCAL loc_oForm, loc_oErro, loc_cCursorMov, loc_cCursorDif, loc_lPronto
1059: 
1060:         loc_lPronto = .F.
1061:         loc_oForm   = .NULL.
1062: 
1063:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1064:             RETURN .F.
1065:         ENDIF
1066: 
1067:         *-- "Reccount() > 0" do legado, medido pelo BO
1068:         IF !THIS.this_oBusinessObject.this_lPossuiDiferenca
1069:             RETURN .F.
1070:         ENDIF
1071: 
1072:         IF !MsgConfirma("Visualizar as diferen" + CHR(231) + "as na Tela?", "Visualizar")
1073:             RETURN .F.
1074:         ENDIF
1075: 
1076:         TRY
1077:             loc_cCursorMov = THIS.this_oBusinessObject.ObterCursorMovimento()
1078:             loc_cCursorDif = THIS.this_oBusinessObject.ObterCursorDiferencas()
1079: 
1080:             IF USED(loc_cCursorMov) AND USED(loc_cCursorDif)
1081:                 *-- Antes de montar: nao herdar alias de um processamento anterior
1082:                 THIS.LiberarCursoresDiferencas()
1083: 
1084:                 SELECT * FROM (loc_cCursorMov) INTO CURSOR movaux READWRITE
1085:                 SELECT DISTINCT Transacaos FROM (loc_cCursorDif) INTO CURSOR dif2 READWRITE
1086: 
1087:                 loc_lPronto = USED("movaux") AND USED("dif2")
1088:             ELSE
1089:                 MsgAviso("Cursores de diferen" + CHR(231) + "a n" + CHR(227) + ;
1090:                     "o dispon" + CHR(237) + "veis - reprocesse o per" + ;
1091:                     CHR(237) + "odo.", "Visualizar")
1092:             ENDIF
1093: 
1094:             IF loc_lPronto
1095:                 loc_oForm = CREATEOBJECT("FormSigReDif", THIS.DataSessionId)
1096:             ENDIF
1097:         CATCH TO loc_oErro
1098:             loc_lPronto = .F.
1099:             loc_oForm   = .NULL.
1100:             MsgErro(loc_oErro.Message + CHR(13) + ;
1101:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1102:                 "Procedure: " + loc_oErro.Procedure, "Erro em ExibirDiferencas")
1103:         ENDTRY
1104: 
1105:         *-- Show() FORA do TRY (regra #29) - FormSigReDif eh modal
1106:         IF VARTYPE(loc_oForm) = "O"
1107:             loc_oForm.Show()
1108:         ENDIF
1109: 
1110:         THIS.LiberarCursoresDiferencas()
1111: 
1112:         RETURN loc_lPronto
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * LiberarCursoresDiferencas - fecha os alias de CONTRATO da tela de
1117:     * diferencas: movaux/dif2 (montados por ExibirDiferencas) e crGrid, que
1118:     * SigReDifBO.PrepararDados cria DENTRO desta data session (ele faz
1119:     * "SET DATASESSION TO (this_nDataSessionId)" antes do SELECT, entao o
1120:     * cursor fica aqui, nao na sessao da tela filha). Chamado em tres pontos:
1121:     * antes de montar, depois do Show() e em Destroy().
1122:     *==========================================================================
1123:     PROTECTED PROCEDURE LiberarCursoresDiferencas()
1124:         IF USED("movaux")
1125:             USE IN movaux
1126:         ENDIF
1127:         IF USED("dif2")
1128:             USE IN dif2
1129:         ENDIF
1130:         IF USED("crGrid")
1131:             USE IN crGrid
1132:         ENDIF
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * GravarArquivoContabil - traducao do PROCEDURE gravar legado. A parte de
1137:     * UI (reabilitar Processar/Encerrar e as datas, esconder o grupo de
1138:     * relatorio) fica aqui; a parte de NEGOCIO (geracao do arquivo texto
1139:     * CTPV*, formato SDF, um grupo por EmpCont) mora no BO
1140:     * (GravarArquivosContabeis, Fase 2):
1141:     *
1142:     *     ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top + 60
1143:     *     ThisForm.btnReport.Enabled = .t.
1144:     *     ThisForm.Get_DataI.Enabled = .t.
1145:     *     ThisForm.Get_DataF.Enabled = .t.
1146:     *     ThisForm.cntBotoes.Visible = .f.
1147:     *     If Messagebox('Confirma a Geracao do Arquivo?', 4+32+256, '') = 6
1148:     *         [Copy To ... Type SDF - GravarArquivosContabeis()]
1149:     *     EndIf
1150:     *
1151:     * Chamado nos TRES pontos do legado: fim do Processamento sem
1152:     * inconsistencia (AposProcessar), BtnImprimirClick e
1153:     * BtnEncerrarReportClick (os dois do grupo obj_4c_CmdGReport).
1154:     *
1155:     * BusinessBase ja reporta falha de gravacao sozinho (regra #20 -
1156:     * GravarArquivosContabeis chama MsgErro em todo caminho que devolve .F.),
1157:     * entao esta PROCEDURE nao precisa de ELSE.
1158:     *==========================================================================
1159:     PROCEDURE GravarArquivoContabil()
1160:         THIS.cnt_4c_Botoes.Top                              = THIS.cnt_4c_BotoesAcao.Top + 60
1161:         THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Enabled = .T.
1162:         THIS.txt_4c_DataI.Enabled                           = .T.
1163:         THIS.txt_4c_DataF.Enabled                           = .T.
1164:         THIS.cnt_4c_Botoes.Visible                          = .F.
1165: 
1166:         IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
1167:             THIS.this_oBusinessObject.GravarArquivosContabeis()
1168:         ENDIF
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * BtnEncerrarClick - evento do botao "Encerrar" do grupo Processar
1173:     * (obj_4c_CmdGProcessar, Buttons(2)). Legado: SIGPRICT.Sair.Click
1174:     * ("ThisForm.Release") E o ramo Else do Click do GRUPO (This.Value = 2,
1175:     * tambem "ThisForm.Release") - os dois fazem a MESMA coisa, entao uma
1176:     * unica chamada aqui reproduz ambos.
1177:     *==========================================================================
1178:     PROCEDURE BtnEncerrarClick()
1179:         THIS.Release()
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * BtnImprimirClick - evento do botao "Impressora" (obj_4c_CmdGReport,
1184:     * Buttons(1) = btnImprimir do dump). Legado:
1185:     *
1186:     *     Report Form SIGPRICT to PRINTER Prompt NoConsole
1187:     *     ThisForm.Gravar
1188:     *==========================================================================
1189:     PROCEDURE BtnImprimirClick()
1190:         LOCAL loc_oErro
1191: 
1192:         TRY
1193:             IF THIS.PrepararCursoresRelatorio()
1194:                 THIS.ExecutarReportForm("SigPrIct", "PRINTER_PROMPT", "SemConta")
1195:             ENDIF
1196: 
1197:             THIS.GravarArquivoContabil()
1198:         CATCH TO loc_oErro
1199:             MsgErro(loc_oErro.Message + CHR(13) + ;
1200:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1201:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnImprimirClick")
1202:         ENDTRY
1203:     ENDPROC
1204: 
1205:     *==========================================================================
1206:     * BtnVisualizarClick - evento do botao "Video" (obj_4c_CmdGReport,
1207:     * Buttons(3) = btnVisualizar do dump). Legado:
1208:     *
1209:     *     Report Form SIGPRICT Preview
1210:     *     ThisForm.Gravar
1211:     *==========================================================================
1212:     PROCEDURE BtnVisualizarClick()
1213:         LOCAL loc_oErro
1214: 
1215:         TRY
1216:             IF THIS.PrepararCursoresRelatorio()
1217:                 THIS.ExecutarReportForm("SigPrIct", "PREVIEW", "SemConta")
1218:             ENDIF
1219: 
1220:             THIS.GravarArquivoContabil()
1221:         CATCH TO loc_oErro
1222:             MsgErro(loc_oErro.Message + CHR(13) + ;
1223:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1224:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
1225:         ENDTRY
1226:     ENDPROC
1227: 
1228:     *==========================================================================
1229:     * BtnEncerrarReportClick - evento do botao "Encerrar" do grupo de
1230:     * relatorio (obj_4c_CmdGReport, Buttons(2) = btnSair do dump). Legado:
1231:     *
1232:     *     SIGPRICT.cntBotoes.btnReport.btnSair.Click -> "ThisForm.Gravar"
1233:     *     SIGPRICT.cntBotoes.btnReport.Click (This.Value = 2, grupo) ->
1234:     *         "ThisForm.Release" (bolha depois do Click do botao, pois o
1235:     *         dump nao tem NODEFAULT em btnSair.Click)
1236:     *
1237:     * Em VFP9 o Click do MEMBRO roda primeiro e, sem NODEFAULT, borbulha para
1238:     * o Click do GRUPO - por isso aqui tambem: grava o arquivo (com a chance
1239:     * do usuario confirmar ou nao) e so entao fecha o form.
1240:     *==========================================================================
1241:     PROCEDURE BtnEncerrarReportClick()
1242:         THIS.GravarArquivoContabil()
1243:         THIS.Release()
1244:     ENDPROC
1245: 
1246:     *==========================================================================
1247:     * PrepararCursoresRelatorio - monta os dois alias de NOME LITERAL que o
1248:     * SigPrIct.frx consome por contrato (mesmo padrao de MontarCursoresImpressao/
1249:     * MontarCabecalhoImpressao de outros forms REPORT desta base - os nomes
1250:     * NAO levam prefixo cursor_4c_ porque pertencem ao FRX, nao a arquitetura
1251:     * nova; renomear quebraria as expressoes gravadas no relatorio):
1252:     *
1253:     *   SemConta  - detalhe do relatorio (Contas/DataS/Hists/Valors/Ocors),
1254:     *               espelho de cursor_4c_SemConta
1255:     *               (this_oBusinessObject.ObterCursorInconsistencias()).
1256:     *   Cabecalho - titulo/periodo do cabecalho impresso, equivalente a:
1257:     *       Thisform.poDataMgr.CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
1258:     *       Create Cursor Cabecalho (Empresa c(80), Titulo c(80), SubTit c(80), Periodo c(80))
1259:     *       Insert Into Cabecalho (Empresa, Titulo, Periodo) Values ;
1260:     *           (_Empr + ' - ' + crSigCdEmp.Razas, ;
1261:     *            'Relatorio de Inconsistencias de Integracao Contabil', ;
1262:     *            'Periodo: ' + Dtoc(IniPer) + ' a ' + Dtoc(FinPer))
1263:     *   "_Empr" (legado) = go_4c_Sistema.cCodEmpresa (CLAUDE.md - _EMPR nunca
1264:     *   usado direto). this_dDataI/this_dDataF (BO) sao a FONTE UNICA do
1265:     *   periodo - o mesmo que ValidarPeriodo()/Processar() ja usaram.
1266:     *==========================================================================
1267:     PROTECTED FUNCTION PrepararCursoresRelatorio()
1268:         LOCAL loc_cCursorOrigem, loc_cSQL, loc_nResultado, loc_cRazao
1269: 
1270:         loc_cCursorOrigem = THIS.this_oBusinessObject.ObterCursorInconsistencias()
1271: 
1272:         IF !USED(loc_cCursorOrigem) OR RECCOUNT(loc_cCursorOrigem) = 0
1273:             MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
1274:                 "vel para o relat" + CHR(243) + "rio.")
1275:             RETURN .F.
1276:         ENDIF
1277: 
1278:         IF USED("SemConta")
1279:             USE IN SemConta
1280:         ENDIF
1281:         *-- ORDER BY Contas, DataS reproduz o "Select SemConta / Set Order to Conta" que
1282:         *-- o legado executa ANTES do If Not Eof() (o TAG Conta eh
1283:         *-- "Contas + Dtos(DataS)"): o SigPrIct.frx imprime na ordem do indice, e
1284:         *-- um SELECT sem ORDER BY entregaria a ordem de INSERCAO.
1285:         SELECT * FROM (loc_cCursorOrigem) ORDER BY Contas, DataS ;
1286:             INTO CURSOR SemConta READWRITE
1287: 
1288:         loc_cRazao = ""
1289:         IF USED("cursor_4c_EmpRelatorio")
1290:             USE IN cursor_4c_EmpRelatorio
1291:         ENDIF
1292:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1293:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRelatorio")
1294:         IF loc_nResultado >= 1 AND USED("cursor_4c_EmpRelatorio") AND !EOF("cursor_4c_EmpRelatorio")
1295:             loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpRelatorio.Razas, ""))
1296:         ENDIF
1297:         IF USED("cursor_4c_EmpRelatorio")
1298:             USE IN cursor_4c_EmpRelatorio
1299:         ENDIF
1300: 
1301:         IF USED("Cabecalho")
1302:             USE IN Cabecalho
1303:         ENDIF
1304:         CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
1305:         INSERT INTO Cabecalho (Empresa, Titulo, Periodo) VALUES ;
1306:             (ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cRazao, ;
1307:              "Relat" + CHR(243) + "rio de Inconsist" + CHR(234) + "ncias de Integra" + ;
1308:                 CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
1309:              "Per" + CHR(237) + "odo: " + DTOC(THIS.this_oBusinessObject.this_dDataI) + ;
1310:                 " " + CHR(224) + " " + DTOC(THIS.this_oBusinessObject.this_dDataF))
1311: 
1312:         RETURN .T.
1313:     ENDFUNC

*-- Linhas 1337 a 1472:
1337: 
1338:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
1339:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1340:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
1341:                     "Aten" + CHR(231) + CHR(227) + "o")
1342:                 RETURN .F.
1343:             ENDIF
1344:             SELECT (par_cCursorDados)
1345:             GO TOP
1346:         ENDIF
1347: 
1348:         loc_cPointOrig    = SET("POINT")
1349:         loc_cSepOrig      = SET("SEPARATOR")
1350:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1351:         SET POINT TO "."
1352:         SET SEPARATOR TO ","
1353:         SET REPORTBEHAVIOR 80
1354: 
1355:         DO CASE
1356:             CASE par_cModo == "PREVIEW"
1357:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1358:             CASE par_cModo == "PRINTER_PROMPT"
1359:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
1360:             CASE par_cModo == "PRINTER"
1361:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
1362:         ENDCASE
1363: 
1364:         SET POINT TO (loc_cPointOrig)
1365:         SET SEPARATOR TO (loc_cSepOrig)
1366:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
1367: 
1368:         TRY
1369:             SET SYSMENU TO DEFAULT
1370:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
1371:                 popRelatorios, popFerramentas, popAjuda
1372:             CriarMenuPrincipal()
1373:         CATCH
1374:             *-- CriarMenuPrincipal fora de escopo (teste automatizado) - silencioso
1375:         ENDTRY
1376: 
1377:         RETURN .T.
1378:     ENDFUNC
1379: 
1380:     *==========================================================================
1381:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1382:     * padrao. Percorre recursivamente containers/PageFrames para tornar tudo
1383:     * visivel apos a montagem. Filtra cnt_4c_Botoes (equivalente ao cntBotoes
1384:     * legado, que so fica visivel DEPOIS do processamento - Fase 7/8): pula o
1385:     * Visible do proprio container, mas recursa nos filhos para eles nao
1386:     * ficarem hidden quando o container for mostrado depois. Filtra tambem
1387:     * lbl_4c_Label4 (duplicata de " Periodo " oculta no proprio SCX - ver
1388:     * ConfigurarFiltroPeriodo): sem esta excecao, o laco forcaria
1389:     * Visible=.T. e o duplicado apareceria sobre a linha "Data Inicial".
1390:     *==========================================================================
1391:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1392:         LOCAL loc_nI, loc_oObjeto, loc_nP
1393: 
1394:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1395:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1396: 
1397:             IF VARTYPE(loc_oObjeto) = "O"
1398:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_BOTOES")
1399:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1400:                     LOOP
1401:                 ENDIF
1402: 
1403:                 IF UPPER(loc_oObjeto.Name) = "LBL_4C_LABEL4"
1404:                     LOOP
1405:                 ENDIF
1406: 
1407:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1408:                     loc_oObjeto.Visible = .T.
1409:                 ENDIF
1410: 
1411:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1412:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1413:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1414:                     ENDFOR
1415:                 ENDIF
1416: 
1417:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1418:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1419:                 ENDIF
1420:             ENDIF
1421:         ENDFOR
1422:     ENDPROC
1423: 
1424:     *==========================================================================
1425:     * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
1426:     * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
1427:     * form). Fecha os cursores de processamento desta tela, se ainda abertos,
1428:     * antes de encadear para FormBase.Destroy(), que libera o BO e restaura o
1429:     * menu principal. DODEFAULT() SEMPRE por ultimo (Destroy sem DODEFAULT
1430:     * deixa o menu do sistema encolhido - CLAUDE.md regra correlata).
1431:     *==========================================================================
1432:     PROCEDURE Destroy()
1433:         *-- Cursores do BO (inclui Dif1/Dif2/Diferenca, que o processamento
1434:         *-- so cria quando VerificarDiferencas() encontra transacao
1435:         *-- desbalanceada - FinalizarProcesso() cobre a lista inteira).
1436:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1437:             THIS.this_oBusinessObject.FinalizarProcesso()
1438:         ENDIF
1439: 
1440:         IF USED("cursor_4c_MovAux")
1441:             USE IN cursor_4c_MovAux
1442:         ENDIF
1443:         IF USED("cursor_4c_SemConta")
1444:             USE IN cursor_4c_SemConta
1445:         ENDIF
1446:         IF USED("cursor_4c_Grupos")
1447:             USE IN cursor_4c_Grupos
1448:         ENDIF
1449:         IF USED("cursor_4c_TodosGrupos")
1450:             USE IN cursor_4c_TodosGrupos
1451:         ENDIF
1452:         IF USED("cursor_4c_Empresas")
1453:             USE IN cursor_4c_Empresas
1454:         ENDIF
1455:         IF USED("cursor_4c_LoteProc")
1456:             USE IN cursor_4c_LoteProc
1457:         ENDIF
1458:         IF USED("cursor_4c_MvCcr")
1459:             USE IN cursor_4c_MvCcr
1460:         ENDIF
1461: 
1462:         *-- Cursores de nome literal montados por PrepararCursoresRelatorio()
1463:         *-- (Fase 7/8) para o SigPrIct.frx - nao levam prefixo cursor_4c_.
1464:         IF USED("SemConta")
1465:             USE IN SemConta
1466:         ENDIF
1467:         IF USED("Cabecalho")
1468:             USE IN Cabecalho
1469:         ENDIF
1470:         IF USED("cursor_4c_EmpRelatorio")
1471:             USE IN cursor_4c_EmpRelatorio
1472:         ENDIF

