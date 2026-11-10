# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Grade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Grade.RecordSource).
- [GRID-WITH] Bloco WITH par_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: par_oGrade.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMpn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2130 linhas total):

*-- Linhas 22 a 118:
22: * pai, ficam visiveis aqui pelo NOME, sem precisar emular "Set
23: * DataSession To <numero>" (sem equivalente nesta arquitetura).
24: *
25: * Aberto com: CREATEOBJECT("FormSigOpMpn", oFormPai)
26: *
27: * Parametros de Init (equivalentes ao legado "LParameters pForm, DatSes,
28: * Operacao"):
29: *   par_oFormPai - pForm: form chamador. Guardado em this_oFormPai; o
30: *                  legado tambem copia This.pEmps/This.pcEscolha dele no
31: *                  Init (aqui: this_oBusinessObject.this_cEmpresa e
32: *                  this_cModoAtual) e o reabilita no fechamento
33: *                  (ThisForm.ParentForm.Enabled = .t., replicado em
34: *                  Destroy() - mesmo padrao de FormSigOpMpd.prg).
35: *   par_nDataSession - DatSes (DataSessionId do pai): sem equivalente
36: *                  nesta arquitetura (DataSession=1 compartilhada
37: *                  substitui, ver nota acima). Recebido so por fidelidade
38: *                  de assinatura - nunca lido.
39: *   par_cOperacao - Operacao: recebido pelo LParameters legado mas NUNCA
40: *                  referenciado no corpo do Init (confirmado por grep no
41: *                  dump inteiro - unico ponto onde o nome aparece e a
42: *                  propria declaracao do parametro). Parametro morto no
43: *                  legado - recebido aqui so por fidelidade de assinatura.
44: *
45: * Historico de fases:
46: *   Fase 1/2: SigOpMpnBO.prg (propriedades, Init, ObterChavePrimaria,
47: *             CarregarDoCursor, Atualizar).
48: *   Fase 3:   FormSigOpMpn.prg - estrutura base (Init, InicializarForm,
49: *             ConfigurarCabecalho, Destroy).
50: *   Fase 4:   grd_4c_Grade (TmpPends, selecao), grd_4c_Itens/grd_4c_Total
51: *             (xPNensi/xPNensiT, detalhe) e os botoes de acao (cmd_4c_Ok/
52: *             cmd_4c_SelTudo/cmd_4c_Apaga/cmd_4c_Totaliza), MAIS a carga e
53: *             o vinculo das tres grades (CarregarGrade/CarregarLista +
54: *             SigOpMpnBO.CarregarPendencias, que cria os tres cursores e
55: *             popula TmpPends/xPNensi/xPNensiT). A montagem visual
56: *             (Configurar*) e o bind (Carregar*) ficam SEPARADOS por causa
57: *             da regra #41 - Column.ControlSource de cursor que ainda nao
58: *             existe derruba o Init -, mas rodam na MESMA ordem do Init
59: *             legado: monta, cria cursor, liga.
60: *
61: *   Fase 5:   lbl_4c_Label1 + txt_4c_OpSubNivel (Nivels do nivel para o
62: *             qual a movimentacao de subnivel esta indo - legado:
63: *             "ThisForm.OpSubNivel.Value = crSigCdOpd.Nivels", calculado
64: *             em CarregarGrade() a partir de TmpNens.Dopps/crSigCdOpd -
65: *             cursor do form pai e cursor global, ambos visiveis aqui
66: *             pelo nome por causa da DataSession=1 compartilhada).
67: *   Fase 6:   lbl_4c__Procura/txt_4c_Procura (busca incremental por Numps
68: *             na grade de selecao - legado: Say_Procura/Get_Procura.Valid/
69: *             LostFocus, transcritos em ValidarProcuraNumero/
70: *             TxtProcuraKeyPress/TxtProcuraLostFocus porque BINDEVENT
71: *             "Valid" nao funciona em TextBox, regra do projeto - KeyPress
72: *             com ENTER/TAB simula o Valid) e obj_4c_Mm_obs (EditBox
73: *             read-only, legado: ControlSource = TmpPends.Obss, ligado em
74: *             CarregarGrade() pelo mesmo motivo de regra #41 das grades -
75: *             TmpPends ainda nao existe no momento do AddObject).
76: *   Fase 7:   GarantirCheckBoxSelecionar() + ChkSelecionarInteractiveChange
77: *             (toggle da coluna de selecao - legado: fwcheckbox1.
78: *             InteractiveChange -> ThisForm.Marca()/Desmarca), CmdSelTudoClick/
79: *             CmdApagaClick (Marca/Desmarca em lote - legado: SelTudo.Click/
80: *             apaga.Click), CmdTotalizaClick (alterna grd_4c_Itens com
81: *             grd_4c_Total via this_nContador - legado: Totaliza.Click) e
82: *             GradeAfterRowColChange (reaplica o "Set Key To" das duas
83: *             grades de detalhe quando o usuario troca de pendencia -
84: *             regra #46: sem filtro de coluna, porque recarrega o DETALHE
85: *             da linha corrente). ConfigurarEventosGrade liga tambem o
86: *             GotFocus das colunas de exibicao (Usuario/data/Grupo/Conta/
87: *             Peso) a FocarColunaSelecao, que redireciona sempre para o
88: *             CheckBox (legado: "ThisForm.Grade.Seleciona.fwcheckbox1.
89: *             SetFocus" incondicional - mesmo padrao de FormSigOpMpd.prg).
90: *   Fase 8:   CmdOkClick (o "ok" legado - grava via SigOpMpnBO.
91: *             ConfirmarMovimentacoes, que povoa xMFas/xOpi/xNensi do form
92: *             pai e atualiza SigCdNec.ChkSubn, e so fecha o dialogo em
93: *             caso de sucesso), FecharDialogo/BtnEncerrarClick/
94: *             BtnCancelarClick (os tres nomes canonicos do projeto
95: *             convergindo no MESMO funil - o legado nao oferece saida sem
96: *             gravar: ControlBox=.F., Closable=.F., sem ESC) e Destroy
97: *             (reabilita o form pai, libera o BO, fecha os cursores
98: *             PROPRIOS desta tela - TmpPends/xPNensi/xPNensiT - e chama
99: *             DODEFAULT() por ultimo, regra do projeto sobre os popups do
100: *             menu principal).
101: *==============================================================================
102: 
103: DEFINE CLASS FormSigOpMpn AS FormBase
104: 
105:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPMPN;
106:     *-- WindowState nao tem equivalente direto de uso no projeto e fica
107:     *-- no default do VFP, igual aos demais dialogos desta familia)
108:     Height       = 600
109:     Width        = 1000
110:     AutoCenter   = .T.
111:     BorderStyle  = 2
112:     ShowWindow   = 1
113:     WindowType   = 1
114:     ControlBox   = .F.
115:     Closable     = .F.
116:     MaxButton    = .F.
117:     MinButton    = .F.
118:     Movable      = .F.

*-- Linhas 148 a 306:
148:     * Init - recebe o form chamador (e os dois parametros legados sem
149:     * equivalente nesta arquitetura - ver nota no cabecalho), copia
150:     * Empresa/Modo do pai, cria o Business Object e delega a
151:     * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT()).
152:     *--------------------------------------------------------------------------
153:     PROCEDURE Init(par_oFormPai, par_nDataSession, par_cOperacao)
154:         LOCAL loc_lSucesso, loc_oErro
155:         loc_lSucesso = .F.
156: 
157:         TRY
158:             IF VARTYPE(par_oFormPai) = "O"
159:                 THIS.this_oFormPai = par_oFormPai
160:                 IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
161:                     THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
162:                 ENDIF
163:             ENDIF
164: 
165:             THIS.this_nContador = 0
166: 
167:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpMpnBO")
168:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
169:                 MsgErro("Erro ao criar Business Object SigOpMpnBO." + CHR(13) + ;
170:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
171:                     "FormSigOpMpn.Init")
172:             ELSE
173:                 *-- Legado: ThisForm.pEmps = ThisForm.ParentForm.pEmps -
174:                 *-- copia simples da empresa do form pai, guardada no BO
175:                 *-- (this_cEmpresa ja existe la - ver cabecalho de
176:                 *-- SigOpMpnBO.prg)
177:                 IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "this_cEmpresa", 5)
178:                     THIS.this_oBusinessObject.this_cEmpresa = par_oFormPai.this_cEmpresa
179:                 ENDIF
180: 
181:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
182:                 loc_lSucesso = DODEFAULT()
183:             ENDIF
184:         CATCH TO loc_oErro
185:             MsgErro(loc_oErro.Message + CHR(13) + ;
186:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
187:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.Init")
188:         ENDTRY
189: 
190:         RETURN loc_lSucesso
191:     ENDPROC
192: 
193:     *--------------------------------------------------------------------------
194:     * InicializarForm - fundo do form + cabecalho (SIGOPMPN.cntSombra do
195:     * dump). Grade de selecao, grades de itens/total e botoes de acao sao
196:     * das fases seguintes (regra #41 - Column.ControlSource de cursor que
197:     * ainda nao existe derruba o Init; esses cursores so nascem quando o
198:     * metodo de carga da Fase 4 roda). Chamado automaticamente por
199:     * FormBase.Init() via DODEFAULT().
200:     *--------------------------------------------------------------------------
201:     PROTECTED PROCEDURE InicializarForm()
202:         LOCAL loc_lSucesso, loc_oErro
203:         loc_lSucesso = .F.
204: 
205:         TRY
206:             THIS.LockScreen = .T.
207: 
208:             *-- Fundo do form (imagem do Framework Fortyus legado:
209:             *-- "..\framework\imagens\new_background.jpg" no SCX)
210:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
211: 
212:             *-- Ordem identica ao dump legado (SECAO 1 - arvore de
213:             *-- objetos): cntSombra e o primeiro objeto da arvore
214:             THIS.ConfigurarCabecalho()
215: 
216:             *-- Grade de selecao (TmpPends) + grades de detalhe (xPNensi/
217:             *-- xPNensiT) + botoes de acao (ok/SelTudo/Apaga/Totaliza) -
218:             *-- so a ESTRUTURA visual, SEM RecordSource/ControlSource
219:             *-- (regra #41: Column.ControlSource de cursor que ainda nao
220:             *-- existe derruba o Init e a tela nao abre). Mesma divisao de
221:             *-- FormSigOpMpd.prg.
222:             THIS.ConfigurarGrade()
223:             THIS.ConfigurarGradesDetalhe()
224:             THIS.ConfigurarBotoesAcao()
225:             THIS.ConfigurarEventosBotoes()
226:             THIS.ConfigurarEventosGrade()
227: 
228:             *-- Label1 + OpSubNivel (SIGOPMPN.Label1/OpSubNivel do dump) -
229:             *-- so ESTRUTURA visual aqui; o valor de txt_4c_OpSubNivel eh
230:             *-- preenchido em CarregarGrade() (depende de TmpNens, que e'
231:             *-- do form pai - mesma razao de ConfigurarGrade/CarregarGrade
232:             *-- estarem separados, regra #41)
233:             THIS.ConfigurarCamposComplementares()
234: 
235:             *-- E so DEPOIS a carga, que cria os tres cursores e liga as
236:             *-- grades (legado: tudo isso acontece dentro do MESMO Init,
237:             *-- nesta ordem - montagem, Create Cursor, bind). CarregarGrade
238:             *-- ja chama AjustarBotoesPorModo no fim, porque a visibilidade
239:             *-- de SelTudo/Apaga/Totaliza depende do SepPedras do nivel,
240:             *-- que so eh conhecido depois de consultar crSigCdOpd.
241:             THIS.CarregarGrade()
242: 
243:             THIS.LockScreen = .F.
244: 
245:             loc_lSucesso = .T.
246:         CATCH TO loc_oErro
247:             MsgErro(loc_oErro.Message + CHR(13) + ;
248:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
249:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.InicializarForm")
250:         ENDTRY
251: 
252:         RETURN loc_lSucesso
253:     ENDPROC
254: 
255:     *--------------------------------------------------------------------------
256:     * ConfigurarCabecalho - faixa escura de titulo (SIGOPMPN.cntSombra do
257:     * dump), com os dois labels sobrepostos (lblSombra = sombra preta,
258:     * lblTitulo = titulo branco por cima - mesmo padrao de
259:     * FormSigOpMpd.prg/FormSigOpLrC.prg/Formsigopagr.prg). Caption dos
260:     * dois labels recebe a propriedade Caption do form - legado:
261:     * ThisForm.cntSombra.lblSombra e lblTitulo.Caption = ThisForm.Caption,
262:     * feito no inicio do Init. Largura em THIS.Width (nao o literal 1100
263:     * do dump, maior que o Form.Width=1000 do proprio SCX) - regra do
264:     * projeto sobre container de cabecalho (CLAUDE.md regra #11/#30).
265:     *--------------------------------------------------------------------------
266:     PROTECTED PROCEDURE ConfigurarCabecalho()
267:         LOCAL loc_oCab
268: 
269:         THIS.AddObject("cnt_4c_Sombra", "Container")
270:         loc_oCab = THIS.cnt_4c_Sombra
271:         WITH loc_oCab
272:             .Top         = 0
273:             .Left        = 0
274:             .Width       = THIS.Width
275:             .Height      = 80
276:             .BackColor   = RGB(100, 100, 100)
277:             .BackStyle   = 1
278:             .BorderWidth = 0
279:             .Visible     = .T.
280:         ENDWITH
281: 
282:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
283:         WITH loc_oCab.lbl_4c_LblSombra
284:             .AutoSize      = .F.
285:             .Top           = 18
286:             .Left          = 10
287:             .Width         = loc_oCab.Width - 20
288:             .Height        = 40
289:             .FontName      = "Tahoma"
290:             .FontSize      = 18
291:             .FontBold      = .T.
292:             .FontUnderline = .F.
293:             .Alignment     = 0
294:             .BackStyle     = 0
295:             .WordWrap      = .T.
296:             .ForeColor     = RGB(0, 0, 0)
297:             .Caption       = THIS.Caption
298:             .Visible       = .T.
299:         ENDWITH
300: 
301:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
302:         WITH loc_oCab.lbl_4c_LblTitulo
303:             .AutoSize    = .F.
304:             .Top         = 17
305:             .Left        = 10
306:             .Width       = loc_oCab.Width - 20

*-- Linhas 333 a 547:
333:     * em FormSigOpMpd.prg, mesma familia de tela) - aqui so o
334:     * .ReadOnly de nascimento, espelhando o When do legado (fwcheckbox1.
335:     * When: Return (pcEscolha = 'INSERIR')).
336:     *--------------------------------------------------------------------------
337:     PROTECTED PROCEDURE ConfigurarGrade()
338:         THIS.AddObject("grd_4c_Grade", "Grid")
339: 
340:         WITH THIS.grd_4c_Grade
341:             .Top               = 118
342:             .Left              = 12
343:             .Width             = 668
344:             .Height            = 260
345:             .ColumnCount       = 7
346:             .FontName          = "Courier New"
347:             .AllowHeaderSizing = .F.
348:             .DeleteMark        = .F.
349:             .RecordMark        = .F.
350:             .RowHeight         = 17
351:             .ScrollBars        = 2
352:             *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
353:             *-- delas (regra do projeto)
354:             .ReadOnly          = .F.
355:             .Visible           = .T.
356:         ENDWITH
357: 
358:         *-- Column1 "seleciona" - ColumnOrder=1 (default)
359:         WITH THIS.grd_4c_Grade.Column1
360:             .Width     = 15
361:             .FontName  = "Courier New"
362:             .FontSize  = 9
363:             .Movable   = .F.
364:             .Resizable = .F.
365:             *-- valor de NASCIMENTO (legado: fwcheckbox1.When). A caixa
366:             *-- embutida (regra #18) so nasce quando TmpPends existir.
367:             .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
368:         ENDWITH
369:         WITH THIS.grd_4c_Grade.Column1.Header1
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:             .Alignment = 2
373:             .Caption   = ""
374:         ENDWITH
375: 
376:         *-- Column2 "Usuario" - ColumnOrder=7 (ultima coluna visivel)
377:         WITH THIS.grd_4c_Grade.Column2
378:             .Width       = 100
379:             .ColumnOrder = 7
380:             .FontName    = "Arial"
381:             .FontSize    = 8
382:             .Movable     = .F.
383:             .Resizable   = .F.
384:             .ReadOnly    = .F.
385:         ENDWITH
386:         WITH THIS.grd_4c_Grade.Column2.Header1
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .Alignment = 2
390:             .Caption   = "Usu" + CHR(225) + "rio"
391:             .ForeColor = RGB(0, 0, 0)
392:         ENDWITH
393:         WITH THIS.grd_4c_Grade.Column2.Text1
394:             .FontName    = "Arial"
395:             .FontSize    = 8
396:             .BorderStyle = 0
397:             .Margin      = 0
398:             .ReadOnly    = .F.
399:             .ForeColor   = RGB(0, 0, 0)
400:             .BackColor   = RGB(255, 255, 255)
401:         ENDWITH
402: 
403:         *-- Column3 "codigo" - ColumnOrder=2 (foco inicial do dialogo).
404:         *-- Legado: CurrentControl = "Ingrid1" (busca incremental por
405:         *-- Numps, classe propria de framework.vcx, sem porte nesta
406:         *-- arquitetura) - mantido como Text1 padrao da Column.
407:         WITH THIS.grd_4c_Grade.Column3
408:             .Width       = 80
409:             .ColumnOrder = 2
410:             .FontName    = "Arial"
411:             .FontSize    = 8
412:             .Movable     = .F.
413:             .Resizable   = .F.
414:             .ReadOnly    = .F.
415:         ENDWITH
416:         WITH THIS.grd_4c_Grade.Column3.Header1
417:             .FontName  = "Tahoma"
418:             .FontSize  = 8
419:             .Alignment = 2
420:             .Caption   = "C" + CHR(243) + "digo"
421:             .ForeColor = RGB(0, 0, 0)
422:         ENDWITH
423:         WITH THIS.grd_4c_Grade.Column3.Text1
424:             .FontName    = "Arial"
425:             .FontSize    = 8
426:             .BorderStyle = 0
427:             .Margin      = 0
428:             .ReadOnly    = .F.
429:             .ForeColor   = RGB(0, 0, 0)
430:             .BackColor   = RGB(255, 255, 255)
431:         ENDWITH
432: 
433:         *-- Column4 "data" - ColumnOrder=3
434:         WITH THIS.grd_4c_Grade.Column4
435:             .Width       = 75
436:             .ColumnOrder = 3
437:             .FontName    = "Arial"
438:             .FontSize    = 8
439:             .Movable     = .F.
440:             .Resizable   = .F.
441:             .ReadOnly    = .F.
442:         ENDWITH
443:         WITH THIS.grd_4c_Grade.Column4.Header1
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .Alignment = 2
447:             .Caption   = "Data"
448:             .ForeColor = RGB(0, 0, 0)
449:         ENDWITH
450:         WITH THIS.grd_4c_Grade.Column4.Text1
451:             .FontName    = "Arial"
452:             .FontSize    = 8
453:             .Alignment   = 3
454:             .BorderStyle = 0
455:             .Margin      = 0
456:             .ReadOnly    = .F.
457:             .ForeColor   = RGB(0, 0, 0)
458:             .BackColor   = RGB(255, 255, 255)
459:         ENDWITH
460: 
461:         *-- Column5 "Grupo" (Grupo de Origem) - ColumnOrder=4
462:         WITH THIS.grd_4c_Grade.Column5
463:             .Width       = 130
464:             .ColumnOrder = 4
465:             .FontName    = "Arial"
466:             .FontSize    = 8
467:             .Movable     = .F.
468:             .Resizable   = .F.
469:             .ReadOnly    = .F.
470:         ENDWITH
471:         WITH THIS.grd_4c_Grade.Column5.Header1
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .Alignment = 2
475:             .Caption   = "Grupo de Origem"
476:             .ForeColor = RGB(0, 0, 0)
477:         ENDWITH
478:         WITH THIS.grd_4c_Grade.Column5.Text1
479:             .FontName    = "Arial"
480:             .FontSize    = 8
481:             .BorderStyle = 0
482:             .Margin      = 0
483:             .ReadOnly    = .F.
484:             .ForeColor   = RGB(0, 0, 0)
485:             .BackColor   = RGB(255, 255, 255)
486:         ENDWITH
487: 
488:         *-- Column6 "Conta" (Conta de Origem) - ColumnOrder=5
489:         WITH THIS.grd_4c_Grade.Column6
490:             .Width       = 130
491:             .ColumnOrder = 5
492:             .FontName    = "Arial"
493:             .FontSize    = 8
494:             .Movable     = .F.
495:             .Resizable   = .F.
496:             .ReadOnly    = .F.
497:         ENDWITH
498:         WITH THIS.grd_4c_Grade.Column6.Header1
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .Alignment = 2
502:             .Caption   = "Conta de Origem"
503:             .ForeColor = RGB(0, 0, 0)
504:         ENDWITH
505:         WITH THIS.grd_4c_Grade.Column6.Text1
506:             .FontName    = "Arial"
507:             .FontSize    = 8
508:             .BorderStyle = 0
509:             .Margin      = 0
510:             .ReadOnly    = .F.
511:             .ForeColor   = RGB(0, 0, 0)
512:             .BackColor   = RGB(255, 255, 255)
513:         ENDWITH
514: 
515:         *-- Column7 "Peso" (Total de Peso) - ColumnOrder=6, SEMPRE
516:         *-- ReadOnly (legado: Column.Peso.ReadOnly = .T.)
517:         WITH THIS.grd_4c_Grade.Column7
518:             .Width       = 100
519:             .ColumnOrder = 6
520:             .FontName    = "Arial"
521:             .FontSize    = 8
522:             .Movable     = .F.
523:             .Resizable   = .F.
524:             .ReadOnly    = .T.
525:         ENDWITH
526:         WITH THIS.grd_4c_Grade.Column7.Header1
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .Alignment = 2
530:             .Caption   = "Total de Peso"
531:         ENDWITH
532:         WITH THIS.grd_4c_Grade.Column7.Text1
533:             .FontName    = "Arial"
534:             .FontSize    = 8
535:             .BorderStyle = 0
536:             .Margin      = 0
537:             .ReadOnly    = .T.
538:             .ForeColor   = RGB(0, 0, 0)
539:             .BackColor   = RGB(255, 255, 255)
540:         ENDWITH
541:     ENDPROC
542: 
543:     *--------------------------------------------------------------------------
544:     * ConfigurarGradesDetalhe - grd_4c_Itens (SIGOPMPN.Gradeitem) e
545:     * grd_4c_Total (SIGOPMPN.GradeTotal), ambas com 9 colunas IDENTICAS
546:     * (mesmas ControlSource no legado: Nops/CMats/CGrus/CUnis/TpOps/Qtds/
547:     * Pesos/Cats/NEnvs - mesma ordem). So a ESTRUTURA visual aqui -

*-- Linhas 553 a 596:
553:     * duas (fase de handlers - THIS.ok.Click do legado so chama Visible
554:     * em cascata, fica para CmdTotalizaClick em fase posterior).
555:     *--------------------------------------------------------------------------
556:     PROTECTED PROCEDURE ConfigurarGradesDetalhe()
557:         *-- grd_4c_Itens (Gradeitem) ----------------------------------------
558:         THIS.AddObject("grd_4c_Itens", "Grid")
559: 
560:         WITH THIS.grd_4c_Itens
561:             .Top               = 383
562:             .Left              = 12
563:             .Width             = 668
564:             .Height            = 206
565:             .ColumnCount       = 9
566:             .FontSize          = 8
567:             .HeaderHeight      = 16
568:             .RowHeight         = 16
569:             .AllowHeaderSizing = .F.
570:             .DeleteMark        = .F.
571:             .RecordMark        = .F.
572:             .ReadOnly          = .F.
573:             .Visible           = .T.
574:         ENDWITH
575: 
576:         WITH THIS.grd_4c_Itens.Column1
577:             .Width     = 80
578:             .FontName  = "Courier New"
579:             .FontSize  = 8
580:             .Movable   = .F.
581:             .Resizable = .F.
582:             .ReadOnly  = .T.
583:             .Format    = "L"
584:             .InputMask = "9999999999"
585:         ENDWITH
586:         WITH THIS.grd_4c_Itens.Column1.Header1
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .Alignment = 2
590:             .Caption   = "Ordem Produ" + CHR(231) + CHR(227) + "o"
591:         ENDWITH
592:         WITH THIS.grd_4c_Itens.Column1.Text1
593:             .FontName    = "Courier New"
594:             .FontSize    = 8
595:             .BorderStyle = 0
596:             .Format      = "L"

*-- Linhas 1016 a 1059:
1016:     * classe de framework.vcx; mesmos valores de FormSigOpMpd.prg,
1017:     * mesma familia de tela).
1018:     *--------------------------------------------------------------------------
1019:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1020: 
1021:         THIS.AddObject("shp_4c_Shape1", "Shape")
1022:         WITH THIS.shp_4c_Shape1
1023:             .Top         = 7
1024:             .Left        = 818
1025:             .Width       = 171
1026:             .Height      = 110
1027:             .BackStyle   = 0
1028:             .BorderStyle = 0
1029:             .BorderColor = RGB(136, 189, 188)
1030:             .Visible     = .T.
1031:         ENDWITH
1032: 
1033:         *-- SelTudo (legado: fwbtnp) - marca todas as linhas de TmpPends
1034:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1035:         WITH THIS.cmd_4c_SelTudo
1036:             .Top          = 145
1037:             .Left         = 690
1038:             .Width        = 36
1039:             .Height       = 36
1040:             .Caption      = ""
1041:             .FontName     = "Verdana"
1042:             .FontSize     = 8
1043:             .ForeColor    = RGB(36, 84, 155)
1044:             .BackColor    = RGB(255, 255, 255)
1045:             .Themes       = .T.
1046:             .MousePointer = 15
1047:             .ToolTipText  = "Seleciona Tudo"
1048:             .Picture      = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
1049:         ENDWITH
1050: 
1051:         *-- apaga (legado: fwbtnp) - desmarca todas as linhas de TmpPends
1052:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1053:         WITH THIS.cmd_4c_Apaga
1054:             .Top          = 145
1055:             .Left         = 731
1056:             .Width        = 36
1057:             .Height       = 36
1058:             .Caption      = ""
1059:             .FontName     = "Verdana"

*-- Linhas 1124 a 1637:
1124:     ENDPROC
1125: 
1126:     *--------------------------------------------------------------------------
1127:     * ConfigurarEventosBotoes - BINDEVENT dos quatro botoes de acao
1128:     * (ok/SelTudo/apaga/Totaliza). Handlers alvo sao PUBLIC de proposito -
1129:     * BINDEVENT falha em silencio com metodo PROTECTED (regra #3).
1130:     *--------------------------------------------------------------------------
1131:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
1132:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
1133:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
1134:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
1135:         BINDEVENT(THIS.cmd_4c_Totaliza, "Click", THIS, "CmdTotalizaClick")
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * ConfigurarEventosGrade - BINDEVENT do AfterRowColChange da grade de
1140:     * selecao e do redirecionamento de foco das colunas de EXIBICAO
1141:     * (Usuario/data/Grupo/Conta/Peso) para o CheckBox embutido na Column1 -
1142:     * legado: GotFocus de cada uma chama "ThisForm.Grade.Seleciona.
1143:     * fwcheckbox1.SetFocus" incondicionalmente. Column3 "codigo" NAO entra
1144:     * aqui: eh o foco inicial natural do dialogo (Ingrid1/busca incremental
1145:     * no legado), igual ao padrao de FormSigOpMpd.prg.
1146:     *--------------------------------------------------------------------------
1147:     PROTECTED PROCEDURE ConfigurarEventosGrade()
1148:         BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1149: 
1150:         BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1151:         BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1152:         BINDEVENT(THIS.grd_4c_Grade.Column5.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1153:         BINDEVENT(THIS.grd_4c_Grade.Column6.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1154:         BINDEVENT(THIS.grd_4c_Grade.Column7.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1155:     ENDPROC
1156: 
1157:     *--------------------------------------------------------------------------
1158:     * AjustarBotoesPorModo - Visible de SelTudo/Apaga/Totaliza (regra
1159:     * #40: quem desabilita no funil, reabilita no funil - chamado de
1160:     * novo pela fase que recarrega a grade, ja que RecordSource reseta
1161:     * estado da Column mas nao destes botoes).
1162:     *
1163:     * Legado (fim do Init):
1164:     *   ThisForm.SelTudo.Visible   = (pcEscolha = 'INSERIR')
1165:     *   ThisForm.Apaga.Visible     = (pcEscolha = 'INSERIR')
1166:     *   ThisForm.Totaliza.Visible  = (pcEscolha = 'INSERIR' And
1167:     *                                 CrSigCdOpd.SepPedras = 4)
1168:     *
1169:     * CrSigCdOpd so fica POSICIONADO no "nivel" certo depois que o
1170:     * metodo de carga da necessidade corrente roda (Seek(TmpPends.Dopps,
1171:     * 'crSigCdOpd', 'Dopps') - mesmo Dopps que THIS.this_oBusinessObject.
1172:     * this_cDopps guarda, da linha corrente de TmpPends via
1173:     * CarregarDoCursor). Antes disso (TmpPends ainda vazio - esta fase),
1174:     * this_cDopps esta vazio e Totaliza fica oculto - correto, nao eh
1175:     * stub: o calculo e' real e so avalia .T. quando ha dado para
1176:     * avaliar.
1177:     *--------------------------------------------------------------------------
1178:     *-- PUBLIC (regra #3): o harness de teste chama AjustarBotoesPorModo()
1179:     *-- direto de fora da classe, e PEMSTATUS(oForm, <metodo>, 5) devolve .T.
1180:     *-- mesmo para metodo PROTECTED (so testa existencia, nao escopo) - o
1181:     *-- teste entraria no branch e a chamada falharia em runtime.
1182:     PROCEDURE AjustarBotoesPorModo()
1183:         LOCAL loc_lModoIncluir, loc_lSeparaPedras, loc_cAliasAnterior
1184: 
1185:         loc_lModoIncluir  = (THIS.this_cModoAtual == "INCLUIR")
1186:         loc_lSeparaPedras = .F.
1187: 
1188:         *-- SepPedras vem do registro do NIVEL em SigCdOpd. Depois da carga
1189:         *-- quem tem o valor autoritativo eh o BO (SigOpMpnBO.CarregarNivel
1190:         *-- grava this_nSepPedras na SEGUNDA consulta, que eh justamente a
1191:         *-- do nivel) - ler a property evita depender do ponteiro de um
1192:         *-- cursor global estar parado no registro certo.
1193:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1194:                 PEMSTATUS(THIS.this_oBusinessObject, "this_nSepPedras", 5)
1195:             loc_lSeparaPedras = (THIS.this_oBusinessObject.this_nSepPedras = 4)
1196:         ENDIF
1197: 
1198:         *-- Fallback para antes da carga (property ainda em 0): le o cursor
1199:         *-- global, como o legado faz
1200:         IF !loc_lSeparaPedras AND USED("crSigCdOpd") AND ;
1201:                 VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1202:                 !EMPTY(THIS.this_oBusinessObject.this_cDopps)
1203:             loc_cAliasAnterior = ALIAS()
1204: 
1205:             IF SEEK(THIS.this_oBusinessObject.this_cDopps, "crSigCdOpd", "Dopps")
1206:                 loc_lSeparaPedras = (crSigCdOpd.SepPedras = 4)
1207:             ENDIF
1208: 
1209:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1210:                 SELECT (loc_cAliasAnterior)
1211:             ENDIF
1212:         ENDIF
1213: 
1214:         IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
1215:             THIS.cmd_4c_SelTudo.Visible = loc_lModoIncluir
1216:         ENDIF
1217:         IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
1218:             THIS.cmd_4c_Apaga.Visible = loc_lModoIncluir
1219:         ENDIF
1220:         IF PEMSTATUS(THIS, "cmd_4c_Totaliza", 5)
1221:             THIS.cmd_4c_Totaliza.Visible = (loc_lModoIncluir AND loc_lSeparaPedras)
1222:         ENDIF
1223:     ENDPROC
1224: 
1225:     *--------------------------------------------------------------------------
1226:     * ConfigurarCamposComplementares - Label1 + OpSubNivel (dump: filhos
1227:     * DIRETOS do form, Top=89..93, Left=12..324 - a esquerda da grade de
1228:     * selecao). txt_4c_OpSubNivel exibe o "Nivels" do nivel de DESTINO da
1229:     * movimentacao de subnivel; o legado bloqueia o foco com "PROCEDURE
1230:     * When / Return .f." (nunca editavel por teclado) - aqui reproduzido
1231:     * com .ReadOnly = .T., que preserva a aparencia normal do TextBox (o
1232:     * legado nao usa DisabledBackColor nem Enabled = .F. para este campo).
1233:     *
1234:     * So a ESTRUTURA visual: o Value de txt_4c_OpSubNivel e' calculado em
1235:     * CarregarGrade() porque depende de TmpNens (cursor do form PAI,
1236:     * visivel aqui por nome - DataSession=1 compartilhada) e crSigCdOpd
1237:     * (cursor global), nenhum dos dois garantido no momento do Init.
1238:     *
1239:     * lbl_4c__Procura/txt_4c_Procura (SIGOPMPN.Say_Procura/Get_Procura do
1240:     * dump) sao a busca incremental por Numps na grade de selecao - so a
1241:     * ESTRUTURA aqui; o Valid/LostFocus legado vira ValidarProcuraNumero/
1242:     * TxtProcuraKeyPress/TxtProcuraLostFocus (ver nota la). Os BINDEVENT
1243:     * ficam AQUI (e nao em CarregarGrade) porque os handlers nao dependem
1244:     * de TmpPends existir - so o CORPO deles consulta o cursor, com guarda
1245:     * USED() (mesmo padrao do resto do form).
1246:     *
1247:     * obj_4c_Mm_obs (SIGOPMPN.mm_obs do dump) e' o EditBox de observacao -
1248:     * SEMPRE ReadOnly = .T. no legado (simples exibicao, nunca editavel).
1249:     * So a ESTRUTURA aqui: o ControlSource ("TmpPends.Obss") fica em
1250:     * CarregarGrade() pela MESMA razao das colunas das grades (regra #41 -
1251:     * TmpPends ainda nao existe neste ponto do Init).
1252:     *--------------------------------------------------------------------------
1253:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
1254:         THIS.AddObject("lbl_4c_Label1", "Label")
1255:         WITH THIS.lbl_4c_Label1
1256:             .AutoSize  = .F.
1257:             .Top       = 93
1258:             .Left      = 12
1259:             .Width     = 136
1260:             .Height    = 15
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .BackStyle = 0
1264:             .ForeColor = RGB(90, 90, 90)
1265:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Subn" + CHR(237) + "vel :"
1266:             .Visible   = .T.
1267:         ENDWITH
1268: 
1269:         THIS.AddObject("txt_4c_OpSubNivel", "TextBox")
1270:         WITH THIS.txt_4c_OpSubNivel
1271:             .Top       = 89
1272:             .Left      = 150
1273:             .Width     = 174
1274:             .Height    = 23
1275:             .FontName  = "Tahoma"
1276:             .FontSize  = 8
1277:             .Alignment = 3
1278:             .Format    = "K"
1279:             .Value     = ""
1280:             *-- legado: Procedure When / Return .f. - nunca recebe foco
1281:             .ReadOnly  = .T.
1282:             .Visible   = .T.
1283:         ENDWITH
1284: 
1285:         *-- lbl_4c__Procura (Say_Procura) - AutoSize do dump eh NO-OP em
1286:         *-- Label criado por AddObject (regra #23): Width explicita =
1287:         *-- Width do dump, Alignment = 0 (classe say, sem Alignment
1288:         *-- declarado no dump)
1289:         THIS.AddObject("lbl_4c__Procura", "Label")
1290:         WITH THIS.lbl_4c__Procura
1291:             .AutoSize  = .F.
1292:             .Top       = 93
1293:             .Left      = 524
1294:             .Width     = 96
1295:             .Height    = 15
1296:             .FontName  = "Tahoma"
1297:             .FontSize  = 8
1298:             .BackStyle = 0
1299:             .Alignment = 0
1300:             .ForeColor = RGB(90, 90, 90)
1301:             .Caption   = "Busca de  C" + CHR(243) + "digos :"
1302:             .Visible   = .T.
1303:         ENDWITH
1304: 
1305:         *-- txt_4c_Procura (Get_Procura) - numerico (Value=0 no dump),
1306:         *-- MaxLength=6 transcrito literal; sem InputMask no dump (o
1307:         *-- Value numerico ja restringe a digitos/sinal)
1308:         THIS.AddObject("txt_4c_Procura", "TextBox")
1309:         WITH THIS.txt_4c_Procura
1310:             .Top         = 89
1311:             .Left        = 622
1312:             .Width       = 58
1313:             .Height      = 23
1314:             .FontName    = "Tahoma"
1315:             .FontSize    = 8
1316:             .Alignment   = 3
1317:             .Format      = "K"
1318:             .MaxLength   = 6
1319:             .Value       = 0
1320:             .ToolTipText = "Busca de C" + CHR(243) + "digos"
1321:             .Visible     = .T.
1322:         ENDWITH
1323: 
1324:         *-- KeyPress/LostFocus substituem Valid/LostFocus (BINDEVENT
1325:         *-- "Valid" nao funciona em TextBox - regra do projeto)
1326:         BINDEVENT(THIS.txt_4c_Procura, "KeyPress", THIS, "TxtProcuraKeyPress")
1327:         BINDEVENT(THIS.txt_4c_Procura, "LostFocus", THIS, "TxtProcuraLostFocus")
1328: 
1329:         *-- obj_4c_Mm_obs (mm_obs) - ReadOnly = .T. de nascimento (igual ao
1330:         *-- dump); ControlSource fica para CarregarGrade() (regra #41)
1331:         THIS.AddObject("obj_4c_Mm_obs", "EditBox")
1332:         WITH THIS.obj_4c_Mm_obs
1333:             .Top               = 192
1334:             .Left              = 690
1335:             .Width             = 301
1336:             .Height            = 184
1337:             .FontName          = "Tahoma"
1338:             .FontSize          = 8
1339:             .ReadOnly          = .T.
1340:             .DisabledBackColor = RGB(255, 255, 220)
1341:             .Visible           = .T.
1342:         ENDWITH
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * ValidarProcuraNumero - equivalente ao Valid legado de Get_Procura:
1347:     *
1348:     *   If Not Empty(This.Value)
1349:     *       Select TmpPends / Set Order To Numps / Set Near On
1350:     *       Seek This.Value / Set Near Off
1351:     *       ThisForm.Refresh
1352:     *       If (This.Value = TmpPends.Numps)
1353:     *           This.Value = 0
1354:     *       Else
1355:     *           Return 0
1356:     *       EndIf
1357:     *   EndIf
1358:     *
1359:     * "Return 0" do Valid legado mantem o foco no campo (SET NEAR so achou
1360:     * um vizinho, nao o Numps exato digitado) - aqui devolve .F. para o
1361:     * KeyPress decidir com NODEFAULT (ver TxtProcuraKeyPress). THIS.Refresh()
1362:     * repinta a grade de selecao (posicionada pelo SEEK) e obj_4c_Mm_obs
1363:     * (ControlSource = TmpPends.Obss, muda com o registro corrente).
1364:     *
1365:     * PROTECTED: so chamado de dentro da classe (regra #51 - nao eh metodo
1366:     * que precise ser alcancado de fora, diferente dos handlers de evento).
1367:     *--------------------------------------------------------------------------
1368:     PROTECTED PROCEDURE ValidarProcuraNumero()
1369:         LOCAL loc_lPodeSair, loc_cAliasPends, loc_cAliasAnterior, loc_nValor
1370: 
1371:         loc_lPodeSair   = .T.
1372:         loc_cAliasPends = ""
1373: 
1374:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1375:             loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
1376:         ENDIF
1377: 
1378:         IF !EMPTY(THIS.txt_4c_Procura.Value) AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
1379:             loc_nValor         = THIS.txt_4c_Procura.Value
1380:             loc_cAliasAnterior = ALIAS()
1381: 
1382:             SELECT (loc_cAliasPends)
1383:             SET ORDER TO Numps
1384:             SET NEAR ON
1385:             SEEK loc_nValor
1386:             SET NEAR OFF
1387: 
1388:             THIS.Refresh()
1389: 
1390:             IF loc_nValor = EVALUATE(loc_cAliasPends + ".Numps")
1391:                 THIS.txt_4c_Procura.Value = 0
1392:             ELSE
1393:                 loc_lPodeSair = .F.
1394:             ENDIF
1395: 
1396:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1397:                 SELECT (loc_cAliasAnterior)
1398:             ENDIF
1399:         ENDIF
1400: 
1401:         RETURN loc_lPodeSair
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * TxtProcuraKeyPress - PUBLIC (regra #3: alvo de BINDEVENT). Testa
1406:     * ENTER(13)/TAB(9) para simular o Valid legado (BINDEVENT "Valid" nao
1407:     * funciona em TextBox).
1408:     *
1409:     * TAB: quando ValidarProcuraNumero() devolve .F. (entrada invalida), o
1410:     * NODEFAULT suprime a navegacao padrao do Tab - o campo continua com o
1411:     * foco, igual ao "Return 0" do Valid legado.
1412:     *
1413:     * ENTER: diferente do Tab, Enter NAO move o foco por padrao no VFP9 -
1414:     * sem este bloco extra o legado jamais chegaria a perder o foco so por
1415:     * Enter, e TxtProcuraLostFocus (equivalente ao LostFocus legado) nunca
1416:     * dispararia. Forcar o foco para a coluna de selecao aqui reproduz o
1417:     * MESMO destino do LostFocus legado, so que pela via do Enter.
1418:     *--------------------------------------------------------------------------
1419:     PROCEDURE TxtProcuraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1420:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1421:             IF !THIS.ValidarProcuraNumero()
1422:                 NODEFAULT
1423:             ELSE
1424:                 IF par_nKeyCode = 13
1425:                     NODEFAULT
1426:                     THIS.FocarColunaSelecao()
1427:                 ENDIF
1428:             ENDIF
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *--------------------------------------------------------------------------
1433:     * TxtProcuraLostFocus - PUBLIC (regra #3: alvo de BINDEVENT). Equivalente
1434:     * ao LostFocus legado de Get_Procura:
1435:     *
1436:     *   If (TmpPends.Numps = This.Value) Or (This.Value = 0)
1437:     *       ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus
1438:     *   EndIf
1439:     *
1440:     * Dispara sempre que o campo perde o foco DE VERDADE (Tab, clique, ou o
1441:     * SetFocus programatico que o proprio TxtProcuraKeyPress dispara no
1442:     * caso do Enter) - complementa o Enter (que o KeyPress ja resolve
1443:     * direto) cobrindo Tab/clique, que o legado tambem atende.
1444:     *--------------------------------------------------------------------------
1445:     PROCEDURE TxtProcuraLostFocus()
1446:         LOCAL loc_cAliasPends, loc_lPodeFocar
1447: 
1448:         loc_cAliasPends = ""
1449:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1450:             loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
1451:         ENDIF
1452: 
1453:         loc_lPodeFocar = (THIS.txt_4c_Procura.Value = 0)
1454: 
1455:         IF !loc_lPodeFocar AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
1456:             loc_lPodeFocar = (EVALUATE(loc_cAliasPends + ".Numps") = THIS.txt_4c_Procura.Value)
1457:         ENDIF
1458: 
1459:         IF loc_lPodeFocar
1460:             THIS.FocarColunaSelecao()
1461:         ENDIF
1462:     ENDPROC
1463: 
1464:     *--------------------------------------------------------------------------
1465:     * FocarColunaSelecao - PUBLIC (mesmo nome/padrao de FormSigOpMpd.prg,
1466:     * mesma familia de tela - reutilizavel pelos GotFocus das colunas de
1467:     * exibicao da grade, fase posterior). Redireciona o foco para o
1468:     * CheckBox embutido na coluna de selecao, quando ele ja existe (so
1469:     * nasce em GarantirCheckBoxSelecionar, chamado por CarregarGrade -
1470:     * regra #18).
1471:     *--------------------------------------------------------------------------
1472:     PROCEDURE FocarColunaSelecao()
1473:         IF PEMSTATUS(THIS, "grd_4c_Grade", 5) AND ;
1474:                 PEMSTATUS(THIS.grd_4c_Grade.Column1, "chk_4c_Selecionar", 5)
1475:             THIS.grd_4c_Grade.Column1.chk_4c_Selecionar.SetFocus()
1476:         ENDIF
1477:     ENDPROC
1478: 
1479:     *--------------------------------------------------------------------------
1480:     * GarantirCheckBoxSelecionar - embute o CheckBox na coluna de selecao da
1481:     * grade (legado: SIGOPMPN.Grade.seleciona.fwcheckbox1, ControlSource =
1482:     * TmpPends.Flag).
1483:     *
1484:     * Vive separado de ConfigurarGrade porque so pode rodar DEPOIS de
1485:     * Column1.ControlSource apontar para TmpPends.Flag, que eh Logico - e
1486:     * TmpPends nasce na carga, nao na montagem da tela (regra #41). Alem
1487:     * disso RecordSource RECRIA os objetos Column, entao a caixa tem de ser
1488:     * reinstalada a CADA rebind: por isso o PEMSTATUS, que torna o metodo
1489:     * idempotente.
1490:     *
1491:     * Os tres comandos sao inseparaveis (regra #18): AddObject so CRIA o
1492:     * objeto - sem CurrentControl a coluna continua desenhando o Text1 dela,
1493:     * e sem Sparse = .F. o CheckBox aparece apenas na linha ativa.
1494:     *
1495:     * O TOGGLE (Click/MouseDown/MouseUp/KeyPress com NODEFAULT, que eh como
1496:     * o legado alterna o valor - ele SUPRIME o toggle nativo e faz o Replace
1497:     * por codigo, ver SIGOPMPN.Grade.seleciona.fwcheckbox1.InteractiveChange
1498:     * -> ThisForm.Marca/Desmarca) eh da fase de EVENTOS. Aqui NAO se chama
1499:     * BINDEVENT: apontar para um handler que ainda nao existe estoura no
1500:     * proprio bind.
1501:     *--------------------------------------------------------------------------
1502:     PROTECTED PROCEDURE GarantirCheckBoxSelecionar()
1503:         LOCAL loc_oColuna
1504:         loc_oColuna = THIS.grd_4c_Grade.Column1
1505: 
1506:         IF !PEMSTATUS(loc_oColuna, "chk_4c_Selecionar", 5)
1507:             loc_oColuna.AddObject("chk_4c_Selecionar", "CheckBox")
1508: 
1509:             WITH loc_oColuna.chk_4c_Selecionar
1510:                 .Caption   = ""
1511:                 .BackStyle = 0
1512:                 .Visible   = .T.
1513:             ENDWITH
1514: 
1515:             *-- legado: fwcheckbox1.InteractiveChange (=DoDefault() + If Not
1516:             *-- This.Value / ThisForm.Desmarca / Else / This.Value =
1517:             *-- ThisForm.Marca() / EndIf) - BINDEVENT dentro do MESMO IF: o
1518:             *-- objeto so eh recriado quando RecordSource derruba a Column,
1519:             *-- e um bind duplicado sobre o MESMO objeto empilharia o
1520:             *-- handler
1521:             BINDEVENT(loc_oColuna.chk_4c_Selecionar, "InteractiveChange", ;
1522:                 THIS, "ChkSelecionarInteractiveChange")
1523:         ENDIF
1524: 
1525:         loc_oColuna.CurrentControl = "chk_4c_Selecionar"
1526:         loc_oColuna.Sparse         = .F.
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * CarregarGrade - funil UNICO de carga e vinculo das TRES grades.
1531:     * Transcricao do trecho final do Init legado: depois de montar TmpPends/
1532:     * xPNensi/xPNensiT, ele faz o "With Thisform.Grade / .RecordSource = ...
1533:     * / .<coluna>.ControlSource = ..." para Grade, Gradeitem e GradeTotal.
1534:     *
1535:     * PUBLIC (regra #3/#51): o harness de teste chama CarregarLista/
1536:     * CarregarGrade de FORA da classe, e PEMSTATUS(...,5) devolve .T. para
1537:     * metodo PROTECTED, entao o teste entraria no branch e a chamada
1538:     * falharia em runtime.
1539:     *
1540:     * SigOpMpnBO.CarregarPendencias() recria os tres cursores do zero (mesma
1541:     * semantica do "Create Cursor" do Init legado) e so DEPOIS as grades sao
1542:     * ligadas - regra #41: Column.ControlSource de cursor que ainda nao
1543:     * existe derruba o Init e a tela nao abre.
1544:     *
1545:     * Ordem obrigatoria por grade: RecordSource -> ControlSource -> (Column1:
1546:     * AddObject do CheckBox) -> Width -> Header1.Caption -> ReadOnly. Mexer
1547:     * em RecordSource RECALCULA as larguras para o default 90 e reseta
1548:     * Header1.Caption, Sparse, CurrentControl e o ReadOnly das colunas (que
1549:     * volta a herdar o do Grid) - por isso tudo isso eh reaplicado AQUI, e
1550:     * nao so em ConfigurarGrade/ConfigurarGradesDetalhe (Problema 48 do
1551:     * FormCor; o ReadOnly da coluna sempre DEPOIS do ReadOnly do Grid).
1552:     *
1553:     * Bypass de SQL em modo teste/ValidarUIFidelity: TmpNens/TmpOperacao sao
1554:     * cursores do form PAI e nao existem em instanciacao headless - as
1555:     * grades ficam com a estrutura montada e sem dado, o que basta para a
1556:     * validacao de UI.
1557:     *--------------------------------------------------------------------------
1558:     PROCEDURE CarregarGrade()
1559:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
1560:         LOCAL loc_cPends, loc_cPNensi, loc_cPNensiT, loc_cChaveDetalhe
1561:         LOCAL loc_cNivelDestino, loc_cAliasNivelAnt
1562: 
1563:         loc_lSucesso = .F.
1564: 
1565:         TRY
1566:             loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1567:                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1568: 
1569:             *-- Legado (Init, antes do "Create Cursor TmpPends"):
1570:             *-- "=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _DoppsNivel =
1571:             *-- crSigCdOpd.Nivels / ThisForm.OpSubNivel.Value = _DoppsNivel"
1572:             *-- - descricao do NIVEL de destino, lida do cursor global
1573:             *-- crSigCdOpd pela chave do nivel corrente do form pai
1574:             *-- (TmpNens.Dopps). TmpNens nao existe em modo teste/
1575:             *-- ValidarUIFidelity headless (cursor do form pai) - o guard
1576:             *-- USED() deixa o campo vazio nesse caso, igual ao resto da
1577:             *-- tela.
1578:             IF PEMSTATUS(THIS, "txt_4c_OpSubNivel", 5)
1579:                 loc_cNivelDestino = ""
1580:                 IF USED("TmpNens") AND USED("crSigCdOpd")
1581:                     loc_cAliasNivelAnt = ALIAS()
1582:                     IF SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
1583:                         loc_cNivelDestino = crSigCdOpd.Nivels
1584:                     ENDIF
1585:                     IF !EMPTY(loc_cAliasNivelAnt) AND USED(loc_cAliasNivelAnt)
1586:                         SELECT (loc_cAliasNivelAnt)
1587:                     ENDIF
1588:                 ENDIF
1589:                 THIS.txt_4c_OpSubNivel.Value = loc_cNivelDestino
1590:             ENDIF
1591: 
1592:             loc_cPends   = THIS.this_oBusinessObject.this_cCursorPends
1593:             loc_cPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
1594:             loc_cPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT
1595: 
1596:             IF !loc_lBypassTeste
1597:                 THIS.this_oBusinessObject.CarregarPendencias()
1598:             ENDIF
1599: 
1600:             *-- Grade de selecao (legado: With Thisform.Grade) -------------
1601:             IF USED(loc_cPends)
1602:                 WITH THIS.grd_4c_Grade
1603:                     .RecordSource = loc_cPends
1604: 
1605:                     *-- Mapeamento coluna -> campo transcrito do legado, que
1606:                     *-- liga as colunas pelo NOME (.Seleciona/.Usuario/
1607:                     *-- .Codigo/.Data/.Grupo/.Conta/.Peso); aqui pelo numero
1608:                     *-- da Column correspondente (ver ConfigurarGrade)
1609:                     .Column1.ControlSource = loc_cPends + ".Flag"
1610:                     .Column2.ControlSource = loc_cPends + ".Usuars"
1611:                     .Column3.ControlSource = loc_cPends + ".Numps"
1612:                     .Column4.ControlSource = loc_cPends + ".Datas"
1613:                     .Column5.ControlSource = loc_cPends + ".Grupo"
1614:                     .Column6.ControlSource = loc_cPends + ".Conta"
1615:                     .Column7.ControlSource = loc_cPends + ".TPesos"
1616:                 ENDWITH
1617: 
1618:                 *-- SO AGORA Column1 aponta para Flag (Logico): eh seguro
1619:                 *-- embutir o CheckBox (regra #18)
1620:                 THIS.GarantirCheckBoxSelecionar()
1621: 
1622:                 WITH THIS.grd_4c_Grade
1623:                     .Column1.Width = 15
1624:                     .Column2.Width = 100
1625:                     .Column3.Width = 80
1626:                     .Column4.Width = 75
1627:                     .Column5.Width = 130
1628:                     .Column6.Width = 130
1629:                     .Column7.Width = 100
1630: 
1631:                     .Column1.Header1.Caption = ""
1632:                     .Column2.Header1.Caption = "Usu" + CHR(225) + "rio"
1633:                     .Column3.Header1.Caption = "C" + CHR(243) + "digo"
1634:                     .Column4.Header1.Caption = "Data"
1635:                     .Column5.Header1.Caption = "Grupo de Origem"
1636:                     .Column6.Header1.Caption = "Conta de Origem"
1637:                     .Column7.Header1.Caption = "Total de Peso"

*-- Linhas 1659 a 1679:
1659:                 *-- metodo: posicionar depois deixaria a grade destacando a
1660:                 *-- ultima pendencia com as grades de baixo mostrando os
1661:                 *-- itens da PRIMEIRA.
1662:                 SELECT (loc_cPends)
1663:                 GO BOTTOM
1664:                 THIS.grd_4c_Grade.Refresh()
1665:             ENDIF
1666: 
1667:             *-- Chave mestre-detalhe: as duas grades de baixo mostram so os
1668:             *-- itens da pendencia CORRENTE. Legado: "Set Key To
1669:             *-- TmpPends.Emps + TmpPends.Dopps + STr(TmpPends.Numps, 10)",
1670:             *-- avaliado com TmpPends na linha em que o Go Bottom o deixou.
1671:             *-- Chave POSICIONAL char(33) - PADR explicito em cada parte,
1672:             *-- NUNCA ALLTRIM (regra #42). Com TmpPends vazio/ausente a
1673:             *-- chave fica vazia e as grades de detalhe nao filtram nada,
1674:             *-- que eh o estado correto de tela sem pendencia selecionada.
1675:             loc_cChaveDetalhe = ""
1676:             IF USED(loc_cPends) AND !EOF(loc_cPends)
1677:                 loc_cChaveDetalhe = PADR(EVALUATE(loc_cPends + ".Emps"), 3) + ;
1678:                     PADR(EVALUATE(loc_cPends + ".Dopps"), 20) + ;
1679:                     STR(EVALUATE(loc_cPends + ".Numps"), 10)

*-- Linhas 1742 a 2130:
1742:             *-- segue na ULTIMA linha, onde o Go Bottom acima o deixou -
1743:             *-- sem reposicionar de novo, para nao desalinhar da chave
1744:             *-- mestre-detalhe que as grades de baixo ja estao usando.
1745:             IF USED(loc_cPends)
1746:                 SELECT (loc_cPends)
1747:                 THIS.grd_4c_Grade.Refresh()
1748:             ENDIF
1749: 
1750:             *-- Visibilidade de SelTudo/Apaga/Totaliza depende de
1751:             *-- SepPedras, que so eh conhecido depois da carga
1752:             THIS.AjustarBotoesPorModo()
1753: 
1754:             loc_lSucesso = .T.
1755:         CATCH TO loc_oErro
1756:             MsgErro(loc_oErro.Message + CHR(13) + ;
1757:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1758:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CarregarGrade")
1759:         ENDTRY
1760: 
1761:         RETURN loc_lSucesso
1762:     ENDPROC
1763: 
1764:     *--------------------------------------------------------------------------
1765:     * VincularGradeDetalhe - liga UMA das duas grades de detalhe ao seu
1766:     * cursor. As duas tem as MESMAS 9 colunas, nas MESMAS ControlSource do
1767:     * legado (Nops/CMats/CGrus/CUnis/TpOps/Qtds/Pesos/Cats/NEnvs, nessa
1768:     * ordem), por isso o bind eh um metodo unico - so largura e titulo
1769:     * diferem, e ficam no chamador.
1770:     *
1771:     * SET ORDER TO EmpDopNum + SET KEY TO reproduzem o filtro mestre-detalhe
1772:     * do legado ("Select xPnensiT / Set Order to EmpDopNum / Go Top / Set
1773:     * Key To <chave de TmpPends>"). Em xPNensi o legado conta com o indice
1774:     * EmpDopNum estar ativo por ser o ULTIMO criado - aqui a ordem eh
1775:     * explicita, que eh o mesmo efeito sem depender dessa ordem.
1776:     *
1777:     * Todas as 9 colunas voltam a ReadOnly = .T. DEPOIS do RecordSource: as
1778:     * duas grades sao de exibicao (no legado cada Text1 delas tem
1779:     * "When: Return .f.") e o RecordSource faz a coluna herdar de novo o
1780:     * ReadOnly = .F. do Grid.
1781:     *--------------------------------------------------------------------------
1782:     PROTECTED PROCEDURE VincularGradeDetalhe(par_oGrade, par_cCursor, par_cChave)
1783:         LOCAL loc_nI
1784: 
1785:         SELECT (par_cCursor)
1786:         SET ORDER TO EmpDopNum
1787:         GO TOP
1788:         IF EMPTY(par_cChave)
1789:             SET KEY TO
1790:         ELSE
1791:             SET KEY TO par_cChave
1792:         ENDIF
1793: 
1794:         WITH par_oGrade
1795:             .RecordSource = par_cCursor
1796: 
1797:             .Column1.ControlSource = par_cCursor + ".Nops"
1798:             .Column2.ControlSource = par_cCursor + ".CMats"
1799:             .Column3.ControlSource = par_cCursor + ".CGrus"
1800:             .Column4.ControlSource = par_cCursor + ".CUnis"
1801:             .Column5.ControlSource = par_cCursor + ".TpOps"
1802:             .Column6.ControlSource = par_cCursor + ".Qtds"
1803:             .Column7.ControlSource = par_cCursor + ".Pesos"
1804:             .Column8.ControlSource = par_cCursor + ".Cats"
1805:             .Column9.ControlSource = par_cCursor + ".NEnvs"
1806:         ENDWITH
1807: 
1808:         *-- Column.ReadOnly SEMPRE depois do Grid.ReadOnly (o do Grid
1809:         *-- propaga e sobrescreve) - regra #18/#46
1810:         FOR loc_nI = 1 TO par_oGrade.ColumnCount
1811:             par_oGrade.Columns(loc_nI).ReadOnly = .T.
1812:         ENDFOR
1813: 
1814:         SELECT (par_cCursor)
1815:         GO TOP
1816:         par_oGrade.Refresh()
1817:     ENDPROC
1818: 
1819:     *--------------------------------------------------------------------------
1820:     * CarregarLista - nome canonico de carga do projeto; funil unico para
1821:     * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness chama de fora -
1822:     * regra #3).
1823:     *--------------------------------------------------------------------------
1824:     PROCEDURE CarregarLista()
1825:         RETURN THIS.CarregarGrade()
1826:     ENDPROC
1827: 
1828:     *--------------------------------------------------------------------------
1829:     * ChkSelecionarInteractiveChange - legado: SIGOPMPN.Grade.seleciona.
1830:     * fwcheckbox1.InteractiveChange:
1831:     *     =DoDefault()
1832:     *     If Not This.Value
1833:     *         ThisForm.Desmarca
1834:     *     Else
1835:     *         This.Value = ThisForm.Marca()
1836:     *     EndIf
1837:     *
1838:     * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
1839:     * handler disparar. THIS.this_oBusinessObject.CarregarDoCursor() le a
1840:     * linha CORRENTE (this_cEmps/this_cDopps/this_nNumps/this_dDatas), que
1841:     * Marcar()/Desmarcar() usam. Em .T. (marcando), Marcar() pode recusar
1842:     * (duplicidade/numeracao-automatica/data) - nesse caso desfaz o Flag,
1843:     * equivalente a "This.Value = ThisForm.Marca()" quando o retorno eh
1844:     * .F. Quando Marcar() sinaliza this_lFecharAposMarcar (legado:
1845:     * "This.ok.click" dentro do proprio marca, ramo _NumeroAnt), o RETURN
1846:     * fica FORA do TRY (regra #1) e so entao fecha via CmdOkClick.
1847:     *
1848:     * PUBLIC (regra #3: alvo de BINDEVENT).
1849:     *--------------------------------------------------------------------------
1850:     PROCEDURE ChkSelecionarInteractiveChange()
1851:         LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_lFechar, loc_oErro
1852: 
1853:         loc_lFechar = .F.
1854: 
1855:         TRY
1856:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1857: 
1858:             IF USED(loc_cAlias)
1859:                 SELECT (loc_cAlias)
1860:                 loc_lNovoValor = ConverterParaLogico(Flag)
1861: 
1862:                 THIS.this_oBusinessObject.CarregarDoCursor()
1863: 
1864:                 IF loc_lNovoValor
1865:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)
1866: 
1867:                     IF !loc_lResultado
1868:                         SELECT (loc_cAlias)
1869:                         REPLACE Flag WITH .F.
1870:                     ELSE
1871:                         loc_lFechar = THIS.this_oBusinessObject.this_lFecharAposMarcar
1872:                     ENDIF
1873:                 ELSE
1874:                     THIS.this_oBusinessObject.Desmarcar()
1875:                 ENDIF
1876: 
1877:                 IF !loc_lFechar
1878:                     SELECT (loc_cAlias)
1879:                     THIS.grd_4c_Grade.Refresh()
1880:                 ENDIF
1881:             ENDIF
1882:         CATCH TO loc_oErro
1883:             MsgErro(loc_oErro.Message + CHR(13) + ;
1884:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1885:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.ChkSelecionarInteractiveChange")
1886:         ENDTRY
1887: 
1888:         IF loc_lFechar
1889:             THIS.CmdOkClick()
1890:         ENDIF
1891:     ENDPROC
1892: 
1893:     *--------------------------------------------------------------------------
1894:     * CmdSelTudoClick - legado: SIGOPMPN.SelTudo.Click
1895:     *     Select TmpPends
1896:     *     Scan For Not Flag
1897:     *         Replace Flag With ThisForm.Marca(.t.)
1898:     *     EndScan
1899:     *     ThisForm.Grade.Refresh
1900:     *
1901:     * Interrompe o Scan (EXIT) e fecha o dialogo (CmdOkClick) assim que
1902:     * Marcar() sinalizar this_lFecharAposMarcar - mesma semantica do
1903:     * legado, onde "This.ok.click" dentro de marca() libera (Release) o
1904:     * form NO MEIO do Scan.
1905:     *--------------------------------------------------------------------------
1906:     PROCEDURE CmdSelTudoClick()
1907:         LOCAL loc_cAlias, loc_lResultado, loc_lFecharApos, loc_oErro
1908: 
1909:         loc_lFecharApos = .F.
1910: 
1911:         TRY
1912:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1913: 
1914:             IF USED(loc_cAlias)
1915:                 SELECT (loc_cAlias)
1916:                 SCAN FOR !Flag
1917:                     THIS.this_oBusinessObject.CarregarDoCursor()
1918:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)
1919: 
1920:                     SELECT (loc_cAlias)
1921:                     REPLACE Flag WITH loc_lResultado
1922: 
1923:                     IF loc_lResultado AND THIS.this_oBusinessObject.this_lFecharAposMarcar
1924:                         loc_lFecharApos = .T.
1925:                         EXIT
1926:                     ENDIF
1927: 
1928:                     SELECT (loc_cAlias)
1929:                 ENDSCAN
1930: 
1931:                 IF !loc_lFecharApos
1932:                     THIS.grd_4c_Grade.Refresh()
1933:                 ENDIF
1934:             ENDIF
1935:         CATCH TO loc_oErro
1936:             MsgErro(loc_oErro.Message + CHR(13) + ;
1937:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1938:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdSelTudoClick")
1939:         ENDTRY
1940: 
1941:         IF loc_lFecharApos
1942:             THIS.CmdOkClick()
1943:         ENDIF
1944:     ENDPROC
1945: 
1946:     *--------------------------------------------------------------------------
1947:     * CmdApagaClick - legado: SIGOPMPN.apaga.Click
1948:     *     Select TmpPends
1949:     *     Scan For Flag
1950:     *         Replace Flag With ThisForm.DesMarca()
1951:     *     EndScan
1952:     *     ThisForm.Grade.Refresh
1953:     *
1954:     * DESVIO DOCUMENTADO: "DesMarca()" no legado so tem "Return 0" no
1955:     * caminho de ERRO (falha de SqlExecute); sem RETURN explicito no
1956:     * caminho normal, VFP devolve .T. implicito - logo "Replace Flag With
1957:     * ThisForm.DesMarca()" tende a GRAVAR Flag = .T. de volta (reversao
1958:     * acidental do proprio "apagar"), e no caminho de erro tentaria gravar
1959:     * o NUMERO 0 num campo Logico (type mismatch). Mesmo padrao ja adotado
1960:     * em FormSigOpMpd.CmdApagaClick (mesma familia de tela): zera Flag
1961:     * ANTES de chamar Desmarcar(), sem depender do retorno.
1962:     *--------------------------------------------------------------------------
1963:     PROCEDURE CmdApagaClick()
1964:         LOCAL loc_cAlias, loc_oErro
1965: 
1966:         TRY
1967:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1968: 
1969:             IF USED(loc_cAlias)
1970:                 SELECT (loc_cAlias)
1971:                 SCAN FOR Flag
1972:                     SELECT (loc_cAlias)
1973:                     REPLACE Flag WITH .F.
1974:                     THIS.this_oBusinessObject.CarregarDoCursor()
1975:                     THIS.this_oBusinessObject.Desmarcar()
1976:                     SELECT (loc_cAlias)
1977:                 ENDSCAN
1978: 
1979:                 THIS.grd_4c_Grade.Refresh()
1980:             ENDIF
1981:         CATCH TO loc_oErro
1982:             MsgErro(loc_oErro.Message + CHR(13) + ;
1983:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1984:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdApagaClick")
1985:         ENDTRY
1986:     ENDPROC
1987: 
1988:     *--------------------------------------------------------------------------
1989:     * CmdTotalizaClick - legado: SIGOPMPN.Totaliza.Click. Alterna grd_4c_
1990:     * Itens (Gradeitem) com grd_4c_Total (GradeTotal) via this_nContador
1991:     * (legado: ThisForm.contador/ContaDor).
1992:     *--------------------------------------------------------------------------
1993:     PROCEDURE CmdTotalizaClick()
1994:         IF THIS.this_nContador = 0
1995:             THIS.grd_4c_Itens.Visible = .F.
1996:             THIS.grd_4c_Total.Visible = .T.
1997:             THIS.grd_4c_Total.Refresh()
1998:             THIS.this_nContador       = 1
1999:             THIS.cmd_4c_Totaliza.Caption = "Itens"
2000:         ELSE
2001:             THIS.grd_4c_Itens.Visible = .T.
2002:             THIS.grd_4c_Total.Visible = .F.
2003:             THIS.grd_4c_Itens.Refresh()
2004:             THIS.this_nContador       = 0
2005:             THIS.cmd_4c_Totaliza.Caption = "Totaliza"
2006:         ENDIF
2007:     ENDPROC
2008: 
2009:     *--------------------------------------------------------------------------
2010:     * GradeAfterRowColChange - legado: SIGOPMPN.Grade.AfterRowColChange.
2011:     * Reaplica o "Set Key To" das duas grades de detalhe (itens/total) com
2012:     * a chave da linha NOVA de TmpPends (regra #46: SEM filtro de coluna -
2013:     * este handler recarrega o DETALHE da linha corrente, nao valida
2014:     * celula).
2015:     *
2016:     * PUBLIC (regra #3: alvo de BINDEVENT).
2017:     *--------------------------------------------------------------------------
2018:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
2019:         LOCAL loc_cAliasPends, loc_cAliasPNensi, loc_cAliasPNensiT, loc_cChave
2020: 
2021:         loc_cAliasPends   = THIS.this_oBusinessObject.this_cCursorPends
2022:         loc_cAliasPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
2023:         loc_cAliasPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT
2024: 
2025:         IF !USED(loc_cAliasPends) OR EOF(loc_cAliasPends)
2026:             RETURN
2027:         ENDIF
2028: 
2029:         *-- Chave POSICIONAL char(33) (regra #42): Emps/Dopps sao colunas
2030:         *-- CHAR fixas de TmpPends, lidas direto (sem ALLTRIM)
2031:         loc_cChave = EVALUATE(loc_cAliasPends + ".Emps") + EVALUATE(loc_cAliasPends + ".Dopps") + ;
2032:             STR(EVALUATE(loc_cAliasPends + ".Numps"), 10)
2033: 
2034:         IF USED(loc_cAliasPNensiT)
2035:             SELECT (loc_cAliasPNensiT)
2036:             SET KEY TO loc_cChave
2037:             GO TOP
2038:         ENDIF
2039: 
2040:         IF USED(loc_cAliasPNensi)
2041:             SELECT (loc_cAliasPNensi)
2042:             SET KEY TO loc_cChave
2043:             GO TOP
2044:         ENDIF
2045: 
2046:         THIS.grd_4c_Itens.Refresh()
2047:         THIS.obj_4c_Mm_obs.Refresh()
2048:     ENDPROC
2049: 
2050:     *--------------------------------------------------------------------------
2051:     * CmdOkClick - legado: SIGOPMPN.ok.Click. Grava (SigOpMpnBO.
2052:     * ConfirmarMovimentacoes - xMFas/xOpi/xNensi/SigCdNec) e so fecha o
2053:     * dialogo se a gravacao for bem-sucedida: no legado, qualquer "Return
2054:     * 0" dentro do Click aborta ANTES das duas ultimas linhas
2055:     * (ParentForm.Enabled = .t. / ThisForm.Release), ou seja, erro mantem
2056:     * a tela aberta (o MsgErro ja foi mostrado dentro do BO).
2057:     *--------------------------------------------------------------------------
2058:     PROCEDURE CmdOkClick()
2059:         IF THIS.this_oBusinessObject.ConfirmarMovimentacoes()
2060:             THIS.FecharDialogo()
2061:         ENDIF
2062:     ENDPROC
2063: 
2064:     *--------------------------------------------------------------------------
2065:     * FecharDialogo - saida UNICA da tela. O dialogo tem ControlBox = .F.
2066:     * e Closable = .F. (valores do SCX legado), portanto nao ha X nem ESC:
2067:     * o botao OK (apos gravar) eh o unico caminho que o legado oferece, e
2068:     * todos os nomes canonicos de saida do projeto apontam para aqui.
2069:     *--------------------------------------------------------------------------
2070:     PROCEDURE FecharDialogo()
2071:         THIS.Release()
2072:     ENDPROC
2073: 
2074:     *--------------------------------------------------------------------------
2075:     * BtnEncerrarClick - nome canonico do projeto para o botao de saida.
2076:     * Aqui o botao de saida eh o OK do legado (SIGOPMPN.ok), por isso
2077:     * delega ao mesmo funil (que grava antes de fechar).
2078:     *--------------------------------------------------------------------------
2079:     PROCEDURE BtnEncerrarClick()
2080:         THIS.CmdOkClick()
2081:     ENDPROC
2082: 
2083:     *--------------------------------------------------------------------------
2084:     * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
2085:     * O legado nao oferece esse caminho (ControlBox = .F., sem ESC) - o
2086:     * UNICO jeito de sair eh o OK, que ja grava. Delega ao mesmo funil em
2087:     * vez de dar ao usuario a impressao falsa de que ha algo a descartar.
2088:     *--------------------------------------------------------------------------
2089:     PROCEDURE BtnCancelarClick()
2090:         THIS.CmdOkClick()
2091:     ENDPROC
2092: 
2093:     *--------------------------------------------------------------------------
2094:     * Destroy - reabilita o form pai (legado: ThisForm.ParentForm.Enabled
2095:     * nao aparece explicito no dump de SIGOPMPN, mas reforcar aqui segue o
2096:     * mesmo padrao de seguranca de FormSigOpMpd.prg - cobre fechamento por
2097:     * qualquer caminho) e libera o Business Object. Fecha tambem TmpPends
2098:     * (cursor proprio desta tela, criado nas fases seguintes - guard
2099:     * USED() o torna seguro mesmo antes de existir). DODEFAULT() por
2100:     * ULTIMO (regra do projeto: sem ela os popups do menu principal
2101:     * encolhem visualmente apos o form fechar).
2102:     *--------------------------------------------------------------------------
2103:     PROCEDURE Destroy()
2104:         IF VARTYPE(THIS.this_oFormPai) = "O"
2105:             THIS.this_oFormPai.Enabled = .T.
2106:         ENDIF
2107: 
2108:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2109:             THIS.this_oBusinessObject = .NULL.
2110:         ENDIF
2111: 
2112:         *-- Cursores PROPRIOS desta tela (criados por
2113:         *-- SigOpMpnBO.CriarCursoresGrades). Os cursores do form PAI
2114:         *-- (TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi) NAO sao fechados
2115:         *-- aqui: pertencem a ele e continuam em uso depois que o dialogo
2116:         *-- fecha.
2117:         IF USED("TmpPends")
2118:             USE IN TmpPends
2119:         ENDIF
2120:         IF USED("xPNensi")
2121:             USE IN xPNensi
2122:         ENDIF
2123:         IF USED("xPNensiT")
2124:             USE IN xPNensiT
2125:         ENDIF
2126: 
2127:         DODEFAULT()
2128:     ENDPROC
2129: 
2130: ENDDEFINE

