# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormVca.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1032 linhas total):

*-- Linhas 7 a 159:
7: *
8: * FASE 8/8 (consolidacao final): o legado (SIGALTDT) tem 17 metodos/eventos
9: * com codigo (comportamento.json) e cada um deles esta coberto abaixo -
10: * MontaGrade->CarregarLista, Init->InicializarForm+VcaBO.Buscar, KeyPress ESC,
11: * cmdok.Click->BtnSalvarClick, cmdsair.Click->BtnEncerrarClick,
12: * btnMarca.Click->BtnIncluirClick/CmdIncluirClick,
13: * btnExcluir.Click->BtnExcluirClick/CmdExcluirClick, os 5 Header1.Click de
14: * ordenacao, e os 2 Valid de lookup das colunas editaveis (Iclis/Resp).
15: * O SIGALTDT nao possui Page Lista/Dados, nem botao Buscar/Cancelar, nem
16: * modos Incluir/Alterar/Excluir/Visualizar separados (a grade e sempre
17: * editavel in-line) - por isso este form fica de fora de FormParaBO/
18: * BOParaForm, HabilitarCampos/LimparCampos, AjustarBotoesPorModo e
19: * BtnBuscarClick/BtnCancelarClick: nenhum desses tem correspondente no
20: * legado, e inventa-los violaria a regra de nao adicionar funcionalidade que
21: * nao existe no original. BtnAlterarClick/BtnVisualizarClick foram mantidos
22: * como aliases de foco na grade (nao ha modo separado no legado).
23: *==============================================================================
24: 
25: DEFINE CLASS FormVca AS FormBase
26: 
27:     Height      = 400
28:     Width       = 800
29:     AutoCenter  = .T.
30:     BorderStyle = 2
31:     ShowWindow = 1
32:     ControlBox  = .F.
33:     Closable    = .F.
34:     FontName    = "Verdana"
35:     FontSize    = 8
36:     MaxButton   = .F.
37:     TitleBar    = 0
38:     WindowType  = 0
39:     KeyPreview  = .T.
40: 
41:     *-- Business Object
42:     this_oBusinessObject = .NULL.
43: 
44:     *--------------------------------------------------------------------------
45:     * Init - define Caption com CHR() antes de delegar ao FormBase
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init()
48:         THIS.Caption = "Cadastro de Testes"
49: 
50:         *-- WindowType=1 (modal) causaria TIMEOUT no harness de validacao de UI
51:         *-- (top-level window bloqueante). Classe definida com WindowType=0;
52:         *-- producao eleva para modal aqui, fora dos modos de teste/validacao.
53:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
54:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
55:             THIS.WindowType = 1
56:         ENDIF
57: 
58:         RETURN DODEFAULT()
59:     ENDPROC
60: 
61:     *--------------------------------------------------------------------------
62:     * InicializarForm - cria o Business Object e monta a estrutura base
63:     * Chamado automaticamente por FormBase.Init() via DODEFAULT()
64:     *--------------------------------------------------------------------------
65:     PROTECTED PROCEDURE InicializarForm()
66:         LOCAL loc_lSucesso, loc_oErro
67:         loc_lSucesso = .F.
68: 
69:         TRY
70:             THIS.this_oBusinessObject = CREATEOBJECT("VcaBO")
71: 
72:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
73:                 MsgErro("Erro ao criar Business Object VcaBO." + CHR(13) + ;
74:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
75:                         "Erro")
76:             ELSE
77:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
78: 
79:                 THIS.ConfigurarPageFrame()
80: 
81:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
83: 
84:                 THIS.TornarControlesVisiveis(THIS)
85: 
86:                 *-- SQL so roda fora do modo de validacao de UI (sem conexao)
87:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
88:                     THIS.CarregarLista()
89:                 ENDIF
90: 
91:                 loc_lSucesso = .T.
92:             ENDIF
93:         CATCH TO loc_oErro
94:             MsgErro(loc_oErro.Message + CHR(13) + ;
95:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
96:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
97:         ENDTRY
98: 
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *--------------------------------------------------------------------------
103:     * ConfigurarPageFrame - orquestrador de layout base
104:     * SIGALTDT original eh flat OPERACIONAL (sem PageFrame nativo): cabecalho +
105:     * grade de vinculos + grupo de botoes Salvar/Encerrar sobre o proprio form.
106:     * Fase 4 adiciona a grade (grd_4c_Dados), o CommandGroup de acao
107:     * (cmg_4c_Botoes: Salvar/Encerrar) e os botoes de linha (Incluir/Excluir).
108:     *--------------------------------------------------------------------------
109:     PROTECTED PROCEDURE ConfigurarPageFrame()
110:         THIS.ConfigurarCabecalho()
111:         THIS.ConfigurarGrid()
112:         THIS.ConfigurarBotoes()
113:     ENDPROC
114: 
115:     *--------------------------------------------------------------------------
116:     * ConfigurarCabecalho - cria container escuro superior com labels de titulo
117:     * Equivale ao cntSombra/lblSombra/lblTitulo do legado (SIGALTDT.cntSombra)
118:     *--------------------------------------------------------------------------
119:     PROTECTED PROCEDURE ConfigurarCabecalho()
120:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH THIS.cnt_4c_Cabecalho
122:             .Top         = 0
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BackStyle   = 1
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
133:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
134:             .Top           = 18
135:             .Left          = 10
136:             .Width         = 769
137:             .Height        = 40
138:             .AutoSize      = .F.
139:             .BackStyle     = 0
140:             .WordWrap      = .T.
141:             .Alignment     = 0
142:             .FontName      = "Tahoma"
143:             .FontSize      = 18
144:             .FontBold      = .T.
145:             .FontUnderline = .F.
146:             .ForeColor     = RGB(0, 0, 0)
147:             .Caption       = THIS.Caption
148:         ENDWITH
149: 
150:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Top         = 17
153:             .Left        = 10
154:             .Width       = 769
155:             .Height      = 46
156:             .AutoSize    = .F.
157:             .BackStyle   = 0
158:             .WordWrap    = .T.
159:             .Alignment   = 0

*-- Linhas 172 a 215:
172:     * somente leitura (preenchidas por lookup - Fase seguinte). RecordSource
173:     * fica vazio aqui; CarregarLista() faz o bind real (Problema 48 CLAUDE.md).
174:     *--------------------------------------------------------------------------
175:     PROTECTED PROCEDURE ConfigurarGrid()
176:         LOCAL loc_oGrid
177: 
178:         THIS.AddObject("grd_4c_Dados", "Grid")
179:         loc_oGrid = THIS.grd_4c_Dados
180:         WITH loc_oGrid
181:             .Top           = 95
182:             .Left          = 86
183:             .Width         = 585
184:             .Height        = 290
185:             .ColumnCount   = 5
186:             .FontName      = "Arial"
187:             .FontSize      = 8
188:             .DeleteMark    = .F.
189:             .RecordMark    = .F.
190:             .HeaderHeight  = 17
191:             .RowHeight     = 17
192:             .ScrollBars    = 2
193:             .GridLineColor = RGB(238, 238, 238)
194:             .ReadOnly      = .F.
195:         ENDWITH
196: 
197:         WITH loc_oGrid.Column1
198:             .Width     = 70
199:             .Movable   = .F.
200:             .Resizable = .F.
201:             .ReadOnly  = .F.
202:         ENDWITH
203:         WITH loc_oGrid.Column1.Header1
204:             .FontName  = "Arial"
205:             .FontSize  = 8
206:             .Alignment = 2
207:             .Caption   = "Conta"
208:         ENDWITH
209:         WITH loc_oGrid.Column1.Text1
210:             .FontName    = "Arial"
211:             .FontSize    = 8
212:             .BorderStyle = 0
213:             .Margin      = 0
214:             .MaxLength   = 10
215:             .ForeColor   = RGB(0, 0, 0)

*-- Linhas 295 a 358:
295:             .BackColor   = RGB(255, 255, 255)
296:         ENDWITH
297: 
298:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "OrdenarPorConta")
299:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "OrdenarPorDescricao")
300:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "OrdenarPorUsuario")
301:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "OrdenarPorNome")
302:         BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "OrdenarPorDepartamento")
303: 
304:         *-- Lookup das colunas editaveis (Iclis/Resp) - equivalente ao
305:         *-- Grade.Column1.Text1.Valid (fAcessoContas) e Grade.Column3.Text1.Valid
306:         *-- (fwBuscaExt sobre SigCdUsu) do legado. "Valid" nao dispara de forma
307:         *-- confiavel em controle de Grid - usar KeyPress (regra do projeto).
308:         BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "ColContaKeyPress")
309:         BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "ColUsuarioKeyPress")
310:     ENDPROC
311: 
312:     *--------------------------------------------------------------------------
313:     * ConfigurarBotoes - cria os botoes de acao do form
314:     * Grupo_Botao (legado) -> cmg_4c_Botoes: Buttons(1)=Salvar, Buttons(2)=Encerrar
315:     * btnMarca (legado)    -> cmd_4c_Incluir (adiciona linha em branco na grade)
316:     * btnExcluir (legado)  -> cmd_4c_Excluir (exclui linha corrente da grade)
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarBotoes()
319:         LOCAL loc_oCmg
320: 
321:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
322:         loc_oCmg = THIS.cmg_4c_Botoes
323:         WITH loc_oCmg
324:             .Top          = -2
325:             .Left         = 645
326:             .Width        = 160
327:             .Height       = 85
328:             .ButtonCount  = 2
329:             .BackStyle    = 0
330:             .BorderStyle  = 0
331:         ENDWITH
332: 
333:         WITH loc_oCmg.Buttons(1)
334:             .Top         = 5
335:             .Left        = 5
336:             .Width       = 75
337:             .Height      = 75
338:             .Caption     = "\<Salvar"
339:             .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
340:             .FontName    = "Comic Sans MS"
341:             .FontBold    = .T.
342:             .FontItalic  = .T.
343:             .FontSize    = 8
344:             .WordWrap    = .T.
345:             .ForeColor   = RGB(90, 90, 90)
346:             .BackColor   = RGB(255, 255, 255)
347:             .Themes      = .F.
348:         ENDWITH
349: 
350:         WITH loc_oCmg.Buttons(2)
351:             .Top         = 5
352:             .Left        = 80
353:             .Width       = 75
354:             .Height      = 75
355:             .Caption     = "Encerrar"
356:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
357:             .FontName    = "Comic Sans MS"
358:             .FontBold    = .T.

*-- Linhas 364 a 1032:
364:             .Themes      = .F.
365:         ENDWITH
366: 
367:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnSalvarClick")
368:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnEncerrarClick")
369: 
370:         THIS.AddObject("cmd_4c_Incluir", "CommandButton")
371:         WITH THIS.cmd_4c_Incluir
372:             .Top         = 211
373:             .Left = 5
374:             .Width       = 40
375:             .Height      = 40
376:             .Caption     = ""
377:             .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
378:             .ToolTipText = "Incluir"
379:             .FontName    = "Arial"
380:             .FontSize    = 7
381:             .ForeColor   = RGB(255, 0, 0)
382:             .BackColor   = RGB(255, 255, 255)
383:             .Themes           = .T.
384:         ENDWITH
385:         BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "CmdIncluirClick")
386: 
387:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
388:         WITH THIS.cmd_4c_Excluir
389:             .Top         = 252
390:             .Left = 230
391:             .Width       = 40
392:             .Height      = 40
393:             .Caption     = ""
394:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
395:             .ToolTipText = "Excluir"
396:             .FontName    = "Arial"
397:             .FontSize    = 7
398:             .ForeColor   = RGB(255, 0, 0)
399:             .BackColor   = RGB(255, 255, 255)
400:             .Themes           = .T.
401:         ENDWITH
402:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
403:     ENDPROC
404: 
405:     *--------------------------------------------------------------------------
406:     * CarregarLista - popula cursor_4c_Dados via BO e vincula a grade
407:     * Equivale ao MontaGrade() do legado, chamado apos o Init popular o cursor
408:     *--------------------------------------------------------------------------
409:     PROCEDURE CarregarLista()
410:         LOCAL loc_oGrid
411: 
412:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
413:             RETURN
414:         ENDIF
415: 
416:         IF !THIS.this_oBusinessObject.Buscar()
417:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os v" + CHR(237) + "nculos Cliente x Vendedor.", "Aviso")
418:             RETURN
419:         ENDIF
420: 
421:         loc_oGrid = THIS.grd_4c_Dados
422:         loc_oGrid.RecordSource = ""
423:         loc_oGrid.RecordSource = "cursor_4c_Dados"
424:         WITH loc_oGrid
425:             .Column1.ControlSource = "cursor_4c_Dados.Iclis"
426:             .Column2.ControlSource = "cursor_4c_Dados.Rclis"
427:             .Column3.ControlSource = "cursor_4c_Dados.Resp"
428:             .Column4.ControlSource = "cursor_4c_Dados.Usuario"
429:             .Column5.ControlSource = "cursor_4c_Dados.Deptos"
430: 
431:             .Column1.Header1.Caption = "Conta"
432:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
433:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
434:             .Column4.Header1.Caption = "Nome"
435:             .Column5.Header1.Caption = "Departamento"
436: 
437:             .Column1.Width = 70
438:             .Column2.Width = 170
439:             .Column3.Width = 70
440:             .Column4.Width = 170
441:             .Column5.Width = 70
442: 
443:             .Column1.ReadOnly = .F.
444:             .Column2.ReadOnly = .T.
445:             .Column3.ReadOnly = .F.
446:             .Column4.ReadOnly = .T.
447:             .Column5.ReadOnly = .T.
448:         ENDWITH
449: 
450:         SELECT cursor_4c_Dados
451:         GO TOP
452:         loc_oGrid.Refresh()
453:     ENDPROC
454: 
455:     *--------------------------------------------------------------------------
456:     * OrdenarGrid - troca SET ORDER da cursor_4c_Dados e realca o header ativo
457:     * (equivalente aos 5 PROCEDURE Click dos Header1 das colunas no legado)
458:     *--------------------------------------------------------------------------
459:     PROCEDURE OrdenarGrid(par_cTag)
460:         LOCAL loc_oGrid
461: 
462:         IF !USED("cursor_4c_Dados")
463:             RETURN
464:         ENDIF
465:         IF UPPER(ALLTRIM(ORDER("cursor_4c_Dados"))) == UPPER(par_cTag)
466:             RETURN
467:         ENDIF
468: 
469:         SELECT cursor_4c_Dados
470:         SET ORDER TO TAG (par_cTag)
471: 
472:         loc_oGrid = THIS.grd_4c_Dados
473:         WITH loc_oGrid
474:             .Column1.Header1.BackColor = IIF(UPPER(par_cTag) == "ICLIS",   RGB(251, 253, 176), RGB(192, 192, 192))
475:             .Column2.Header1.BackColor = IIF(UPPER(par_cTag) == "RCLIS",   RGB(251, 253, 176), RGB(192, 192, 192))
476:             .Column3.Header1.BackColor = IIF(UPPER(par_cTag) == "RESP",    RGB(251, 253, 176), RGB(192, 192, 192))
477:             .Column4.Header1.BackColor = IIF(UPPER(par_cTag) == "USUARIO", RGB(251, 253, 176), RGB(192, 192, 192))
478:             .Column5.Header1.BackColor = IIF(UPPER(par_cTag) == "DEPTOS",  RGB(251, 253, 176), RGB(192, 192, 192))
479:             .Refresh()
480:         ENDWITH
481:     ENDPROC
482: 
483:     PROCEDURE OrdenarPorConta()
484:         THIS.OrdenarGrid("Iclis")
485:     ENDPROC
486: 
487:     PROCEDURE OrdenarPorDescricao()
488:         THIS.OrdenarGrid("Rclis")
489:     ENDPROC
490: 
491:     PROCEDURE OrdenarPorUsuario()
492:         THIS.OrdenarGrid("Resp")
493:     ENDPROC
494: 
495:     PROCEDURE OrdenarPorNome()
496:         THIS.OrdenarGrid("Usuario")
497:     ENDPROC
498: 
499:     PROCEDURE OrdenarPorDepartamento()
500:         THIS.OrdenarGrid("Deptos")
501:     ENDPROC
502: 
503:     *--------------------------------------------------------------------------
504:     * ColContaKeyPress - Handler de KeyPress da Column1.Text1 (Iclis - conta
505:     * do cliente). Espelha Grade.Column1.Text1.Valid do legado (fAcessoContas):
506:     *   - F4 (115): abre a busca (FormBuscaAuxiliar) direto
507:     *   - ENTER (13) / TAB (9): valida o valor digitado; se encontrar na
508:     *     SigCdCli preenche a Rclis, senao abre a busca (sem MsgAviso
509:     *     redundante - Pattern #114). fAcessoContas() NAO eh usada aqui -
510:     *     licao "fAcessoContas() PROIBIDO como handler de lookup UX".
511:     *--------------------------------------------------------------------------
512:     PROCEDURE ColContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
513:         LOCAL loc_oErro
514:         TRY
515:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
516:                 THIS.AbrirLookupConta()
517:                 NODEFAULT
518:             ELSE
519:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
520:                     THIS.ValidarContaGrid()
521:                 ENDIF
522:             ENDIF
523:         CATCH TO loc_oErro
524:             MsgErro(loc_oErro.Message + CHR(13) + ;
525:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
526:                 "Procedure: " + loc_oErro.Procedure, "FormVca.ColContaKeyPress")
527:         ENDTRY
528:     ENDPROC
529: 
530:     *--------------------------------------------------------------------------
531:     * ValidarContaGrid - Valida o codigo de conta digitado na linha corrente
532:     * do grid contra SigCdCli. Encontrado -> preenche Rclis. Nao encontrado ->
533:     * abre a busca direto.
534:     *--------------------------------------------------------------------------
535:     PROTECTED PROCEDURE ValidarContaGrid()
536:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro
537: 
538:         TRY
539:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
540:                 loc_cValor = ALLTRIM(cursor_4c_Dados.Iclis)
541: 
542:                 IF EMPTY(loc_cValor)
543:                     SELECT cursor_4c_Dados
544:                     REPLACE Rclis WITH ""
545:                 ELSE
546:                     IF USED("cursor_4c_ValConta")
547:                         USE IN cursor_4c_ValConta
548:                     ENDIF
549: 
550:                     loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
551:                                " WHERE RTRIM(Iclis) = " + EscaparSQL(loc_cValor)
552: 
553:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")
554: 
555:                     IF loc_nResultado > 0 AND USED("cursor_4c_ValConta") AND ;
556:                        RECCOUNT("cursor_4c_ValConta") > 0
557:                         SELECT cursor_4c_Dados
558:                         REPLACE Rclis WITH ALLTRIM(cursor_4c_ValConta.Rclis)
559: 
560:                         IF USED("cursor_4c_ValConta")
561:                             USE IN cursor_4c_ValConta
562:                         ENDIF
563: 
564:                         THIS.grd_4c_Dados.Refresh()
565:                     ELSE
566:                         IF USED("cursor_4c_ValConta")
567:                             USE IN cursor_4c_ValConta
568:                         ENDIF
569:                         THIS.AbrirLookupConta()
570:                     ENDIF
571:                 ENDIF
572:             ENDIF
573:         CATCH TO loc_oErro
574:             MsgErro(loc_oErro.Message + CHR(13) + ;
575:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
576:                 "Procedure: " + loc_oErro.Procedure, "FormVca.ValidarContaGrid")
577:         ENDTRY
578:     ENDPROC
579: 
580:     *--------------------------------------------------------------------------
581:     * AbrirLookupConta - Abre FormBuscaAuxiliar sobre SigCdCli (Iclis/Rclis).
582:     * Espelha CreateObject('fwbuscaext', ..., 'SigCdCli', ..., 'Iclis',
583:     * This.Value, 'Selecao', .t.) do legado. Pattern A manual: SQL no caller
584:     * com LIKE 'valor%' + fallback SHOW-ALL + FormBuscaAuxiliar sem
585:     * parametros + DefinirCursor + Mostrar().
586:     *--------------------------------------------------------------------------
587:     PROTECTED PROCEDURE AbrirLookupConta()
588:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro
589: 
590:         TRY
591:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
592:                 loc_cValor = ALLTRIM(cursor_4c_Dados.Iclis)
593: 
594:                 IF USED("cursor_4c_LkpConta")
595:                     USE IN cursor_4c_LkpConta
596:                 ENDIF
597: 
598:                 IF !EMPTY(loc_cValor)
599:                     loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs FROM SigCdCli" + ;
600:                                " WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
601:                                " ORDER BY Iclis"
602:                 ELSE
603:                     loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs FROM SigCdCli" + ;
604:                                " ORDER BY Iclis"
605:                 ENDIF
606: 
607:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpConta")
608: 
609:                 *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo
610:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpConta") AND ;
611:                    RECCOUNT("cursor_4c_LkpConta") = 0 AND !EMPTY(loc_cValor)
612:                     USE IN cursor_4c_LkpConta
613:                     loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs FROM SigCdCli" + ;
614:                                " ORDER BY Iclis"
615:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpConta")
616:                 ENDIF
617: 
618:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpConta") AND ;
619:                    RECCOUNT("cursor_4c_LkpConta") > 0
620: 
621:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
622:                     IF VARTYPE(loc_oBusca) = "O"
623:                         loc_oBusca.DefinirCursor("cursor_4c_LkpConta", "Cods", "Descs", ;
624:                             "Contas (Clientes)")
625: 
626:                         IF loc_oBusca.Mostrar()
627:                             SELECT cursor_4c_Dados
628:                             REPLACE Iclis WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 10), ;
629:                                     Rclis WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
630: 
631:                             THIS.grd_4c_Dados.Refresh()
632:                         ENDIF
633:                     ENDIF
634:                 ELSE
635:                     MsgAviso("Nenhuma conta encontrada" + ;
636:                         IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
637:                         "Contas (Clientes)")
638:                 ENDIF
639: 
640:                 IF USED("cursor_4c_LkpConta")
641:                     USE IN cursor_4c_LkpConta
642:                 ENDIF
643:             ENDIF
644:         CATCH TO loc_oErro
645:             MsgErro(loc_oErro.Message + CHR(13) + ;
646:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
647:                 "Procedure: " + loc_oErro.Procedure, "FormVca.AbrirLookupConta")
648:         ENDTRY
649:     ENDPROC
650: 
651:     *--------------------------------------------------------------------------
652:     * ColUsuarioKeyPress - Handler de KeyPress da Column3.Text1 (Resp -
653:     * usuario/vendedor responsavel). Espelha Grade.Column3.Text1.Valid do
654:     * legado (fwBuscaExt sobre SigCdUsu):
655:     *   - F4 (115): abre a busca (FormBuscaAuxiliar) direto
656:     *   - ENTER (13) / TAB (9): valida o valor digitado; se encontrar na
657:     *     SigCdUsu preenche Usuario (Ncomps) e Deptos, senao abre a busca.
658:     *--------------------------------------------------------------------------
659:     PROCEDURE ColUsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
660:         LOCAL loc_oErro
661:         TRY
662:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
663:                 THIS.AbrirLookupUsuario()
664:                 NODEFAULT
665:             ELSE
666:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
667:                     THIS.ValidarUsuarioGrid()
668:                 ENDIF
669:             ENDIF
670:         CATCH TO loc_oErro
671:             MsgErro(loc_oErro.Message + CHR(13) + ;
672:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
673:                 "Procedure: " + loc_oErro.Procedure, "FormVca.ColUsuarioKeyPress")
674:         ENDTRY
675:     ENDPROC
676: 
677:     *--------------------------------------------------------------------------
678:     * ValidarUsuarioGrid - Valida o codigo de usuario digitado na linha
679:     * corrente do grid contra SigCdUsu. Encontrado -> preenche Usuario
680:     * (Ncomps) e Deptos. Nao encontrado -> abre a busca direto.
681:     *--------------------------------------------------------------------------
682:     PROTECTED PROCEDURE ValidarUsuarioGrid()
683:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro
684: 
685:         TRY
686:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
687:                 loc_cValor = ALLTRIM(cursor_4c_Dados.Resp)
688: 
689:                 IF EMPTY(loc_cValor)
690:                     SELECT cursor_4c_Dados
691:                     REPLACE Usuario WITH "", Deptos WITH ""
692:                 ELSE
693:                     IF USED("cursor_4c_ValUsu")
694:                         USE IN cursor_4c_ValUsu
695:                     ENDIF
696: 
697:                     *-- Filtro NOT cAtivos = 'N' transcrito do legado: o
698:                     *-- fwBuscaExt da Column3 nasce com [Not cAtivos='N'],
699:                     *-- entao usuario inativo NAO casa nem na busca exata
700:                     loc_cSQL = "SELECT Usuarios, Ncomps, Deptos FROM SigCdUsu" + ;
701:                                " WHERE RTRIM(Usuarios) = " + EscaparSQL(loc_cValor) + ;
702:                                " AND NOT cAtivos = 'N'"
703: 
704:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")
705: 
706:                     IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
707:                        RECCOUNT("cursor_4c_ValUsu") > 0
708:                         SELECT cursor_4c_Dados
709:                         REPLACE Usuario WITH ALLTRIM(cursor_4c_ValUsu.Ncomps), ;
710:                                 Deptos  WITH ALLTRIM(cursor_4c_ValUsu.Deptos)
711: 
712:                         IF USED("cursor_4c_ValUsu")
713:                             USE IN cursor_4c_ValUsu
714:                         ENDIF
715: 
716:                         THIS.grd_4c_Dados.Refresh()
717:                     ELSE
718:                         IF USED("cursor_4c_ValUsu")
719:                             USE IN cursor_4c_ValUsu
720:                         ENDIF
721:                         THIS.AbrirLookupUsuario()
722:                     ENDIF
723:                 ENDIF
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro(loc_oErro.Message + CHR(13) + ;
727:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
728:                 "Procedure: " + loc_oErro.Procedure, "FormVca.ValidarUsuarioGrid")
729:         ENDTRY
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     * AbrirLookupUsuario - Abre FormBuscaAuxiliar sobre SigCdUsu
734:     * (Usuarios/Ncomps). Espelha CreateObject('fwbuscaext', ..., 'SigCdUsu',
735:     * 'crSigCdUsu', 'Usuarios', This.Value, 'Selecao', .t.) do legado. Apos a
736:     * selecao, delega a ValidarUsuarioGrid() para tambem preencher o Deptos
737:     * (FormBuscaAuxiliar so devolve 1 par codigo/descricao).
738:     *--------------------------------------------------------------------------
739:     PROTECTED PROCEDURE AbrirLookupUsuario()
740:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro
741: 
742:         TRY
743:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
744:                 loc_cValor = ALLTRIM(cursor_4c_Dados.Resp)
745: 
746:                 IF USED("cursor_4c_LkpUsu")
747:                     USE IN cursor_4c_LkpUsu
748:                 ENDIF
749: 
750:                 *-- NOT cAtivos = 'N' transcrito do legado (fwBuscaExt com
751:                 *-- [Not cAtivos='N']): usuario inativo nao entra na lista
752:                 IF !EMPTY(loc_cValor)
753:                     loc_cSQL = "SELECT Usuarios AS Cods, Ncomps AS Descs FROM SigCdUsu" + ;
754:                                " WHERE Usuarios LIKE " + EscaparSQL(loc_cValor + "%") + ;
755:                                " AND NOT cAtivos = 'N'" + ;
756:                                " ORDER BY Usuarios"
757:                 ELSE
758:                     loc_cSQL = "SELECT Usuarios AS Cods, Ncomps AS Descs FROM SigCdUsu" + ;
759:                                " WHERE NOT cAtivos = 'N'" + ;
760:                                " ORDER BY Usuarios"
761:                 ENDIF
762: 
763:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpUsu")
764: 
765:                 *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo (ativos)
766:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpUsu") AND ;
767:                    RECCOUNT("cursor_4c_LkpUsu") = 0 AND !EMPTY(loc_cValor)
768:                     USE IN cursor_4c_LkpUsu
769:                     loc_cSQL = "SELECT Usuarios AS Cods, Ncomps AS Descs FROM SigCdUsu" + ;
770:                                " WHERE NOT cAtivos = 'N'" + ;
771:                                " ORDER BY Usuarios"
772:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpUsu")
773:                 ENDIF
774: 
775:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpUsu") AND ;
776:                    RECCOUNT("cursor_4c_LkpUsu") > 0
777: 
778:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
779:                     IF VARTYPE(loc_oBusca) = "O"
780:                         loc_oBusca.DefinirCursor("cursor_4c_LkpUsu", "Cods", "Descs", ;
781:                             "Usu" + CHR(225) + "rios (Respons" + CHR(225) + "veis)")
782: 
783:                         IF loc_oBusca.Mostrar()
784:                             SELECT cursor_4c_Dados
785:                             REPLACE Resp WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 20)
786: 
787:                             *-- Deptos nao vem do picker (so 1 par cod/desc) -
788:                             *-- reusa a validacao exata para preencher Usuario+Deptos
789:                             THIS.ValidarUsuarioGrid()
790:                         ENDIF
791:                     ENDIF
792:                 ELSE
793:                     MsgAviso("Nenhum usu" + CHR(225) + "rio encontrado" + ;
794:                         IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
795:                         "Usu" + CHR(225) + "rios")
796:                 ENDIF
797: 
798:                 IF USED("cursor_4c_LkpUsu")
799:                     USE IN cursor_4c_LkpUsu
800:                 ENDIF
801:             ENDIF
802:         CATCH TO loc_oErro
803:             MsgErro(loc_oErro.Message + CHR(13) + ;
804:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
805:                 "Procedure: " + loc_oErro.Procedure, "FormVca.AbrirLookupUsuario")
806:         ENDTRY
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * CmdIncluirClick - localiza linha em branco existente ou adiciona uma nova
811:     * (equivalente ao PROCEDURE Click do btnMarca no legado)
812:     *--------------------------------------------------------------------------
813:     PROCEDURE CmdIncluirClick()
814:         IF !USED("cursor_4c_Dados")
815:             RETURN
816:         ENDIF
817: 
818:         SELECT cursor_4c_Dados
819:         GO TOP
820:         LOCATE FOR EMPTY(Iclis) AND EMPTY(Resp)
821:         IF EOF("cursor_4c_Dados")
822:             APPEND BLANK
823:         ENDIF
824: 
825:         THIS.grd_4c_Dados.Refresh()
826:         THIS.grd_4c_Dados.SetFocus()
827:         THIS.grd_4c_Dados.Column1.SetFocus()
828:     ENDPROC
829: 
830:     *--------------------------------------------------------------------------
831:     * CmdExcluirClick - exclui a linha corrente da grade
832:     * (equivalente ao PROCEDURE Click do btnExcluir no legado)
833:     *--------------------------------------------------------------------------
834:     PROCEDURE CmdExcluirClick()
835:         IF !USED("cursor_4c_Dados")
836:             RETURN
837:         ENDIF
838: 
839:         SELECT cursor_4c_Dados
840:         IF !EOF()
841:             DELETE
842:         ENDIF
843:         IF !EOF()
844:             SKIP
845:             SKIP -1
846:         ENDIF
847:         GO BOTTOM
848: 
849:         THIS.grd_4c_Dados.Refresh()
850:         THIS.grd_4c_Dados.SetFocus()
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------
854:     * BtnIncluirClick - alias canonico do evento principal de inclusao
855:     * (delega para CmdIncluirClick, ligado ao cmd_4c_Incluir/btnMarca legado)
856:     *--------------------------------------------------------------------------
857:     PROCEDURE BtnIncluirClick()
858:         THIS.CmdIncluirClick()
859:     ENDPROC
860: 
861:     *--------------------------------------------------------------------------
862:     * BtnExcluirClick - alias canonico do evento principal de exclusao
863:     * (delega para CmdExcluirClick, ligado ao cmd_4c_Excluir/btnExcluir legado)
864:     *--------------------------------------------------------------------------
865:     PROCEDURE BtnExcluirClick()
866:         THIS.CmdExcluirClick()
867:     ENDPROC
868: 
869:     *--------------------------------------------------------------------------
870:     * BtnAlterarClick - SIGALTDT (legado) nao tem modo ALTERAR separado: a
871:     * grade eh sempre editavel diretamente nas colunas Conta/Usuario (sem
872:     * Page Dados, sem HabilitarCampos por modo). "Alterar" aqui foca a linha
873:     * corrente da grade para o usuario editar in-line.
874:     *--------------------------------------------------------------------------
875:     PROCEDURE BtnAlterarClick()
876:         LOCAL loc_oGrid
877: 
878:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
879:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registros para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
880:             RETURN
881:         ENDIF
882: 
883:         loc_oGrid = THIS.grd_4c_Dados
884:         loc_oGrid.SetFocus()
885:         loc_oGrid.Column1.SetFocus()
886:     ENDPROC
887: 
888:     *--------------------------------------------------------------------------
889:     * BtnVisualizarClick - SIGALTDT (legado) nao tem modo VISUALIZAR separado
890:     * (sem Page Dados, sem readonly toggle). Traz a grade para foco e a
891:     * atualiza, exibindo o estado corrente do cursor.
892:     *--------------------------------------------------------------------------
893:     PROCEDURE BtnVisualizarClick()
894:         LOCAL loc_oGrid
895: 
896:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
897:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registros para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
898:             RETURN
899:         ENDIF
900: 
901:         loc_oGrid = THIS.grd_4c_Dados
902:         loc_oGrid.Refresh()
903:         loc_oGrid.SetFocus()
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * BtnSalvarClick - valida duplicidade, confirma e grava toda a lista
908:     * (equivalente ao PROCEDURE cmdok.Click do Grupo_Botao no legado)
909:     *
910:     * DESVIO DELIBERADO DO LEGADO (nao "corrigir" buscando fidelidade cega):
911:     * o legado testa Reccount([CrSigCdVca])=0. Havendo linhas existentes porem
912:     * cada uma em branco, esse teste PASSA: o legado apaga as brancas do cursor,
913:     * executa [Delete From SigCdVca] (zera a tabela inteira), reinsere NADA e
914:     * ainda exibe [Gravacao Realizada.] - perda silenciosa de toda a lista de
915:     * vinculos. Aqui o guard exige ao menos uma linha com Iclis E Resp
916:     * preenchidos, conforme a licao Erro148 (nunca reportar sucesso quando
917:     * nao houve o que gravar). Esvaziar a lista de proposito segue bloqueado
918:     * nos DOIS (no legado o proprio Reccount=0 ja barrava esse caminho).
919:     *--------------------------------------------------------------------------
920:     PROCEDURE BtnSalvarClick()
921:         LOCAL loc_cContas, loc_oErro, loc_lProsseguir
922: 
923:         IF !USED("cursor_4c_Dados")
924:             RETURN
925:         ENDIF
926: 
927:         loc_lProsseguir = .T.
928: 
929:         TRY
930:             SELECT cursor_4c_Dados
931:             LOCATE FOR !EMPTY(Iclis) AND !EMPTY(Resp)
932:             IF EOF("cursor_4c_Dados")
933:                 MsgAviso("Nenhum Registro para Atualiza" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
934:                 loc_lProsseguir = .F.
935:             ENDIF
936: 
937:             IF loc_lProsseguir
938:                 SELECT Iclis, Rclis, COUNT(*) AS TT ;
939:                     FROM cursor_4c_Dados ;
940:                     WHERE !EMPTY(Iclis) ;
941:                     GROUP BY Iclis, Rclis ;
942:                     HAVING COUNT(*) > 1 ;
943:                     INTO CURSOR cursor_4c_Duplicados READWRITE
944: 
945:                 IF RECCOUNT("cursor_4c_Duplicados") > 0
946:                     SELECT cursor_4c_Duplicados
947:                     GO TOP
948:                     loc_cContas = ""
949:                     SCAN
950:                         loc_cContas = loc_cContas + IIF(EMPTY(loc_cContas), "", CHR(13)) + ;
951:                                       ALLTRIM(Iclis) + " - " + ALLTRIM(Rclis)
952:                     ENDSCAN
953:                     USE IN cursor_4c_Duplicados
954: 
955:                     MsgAviso("Existem Contas Duplicadas, Favor Verificar." + CHR(13) + ;
956:                              "Contas: " + CHR(13) + loc_cContas, "Aten" + CHR(231) + CHR(227) + "o")
957:                     loc_lProsseguir = .F.
958:                 ELSE
959:                     IF USED("cursor_4c_Duplicados")
960:                         USE IN cursor_4c_Duplicados
961:                     ENDIF
962:                 ENDIF
963:             ENDIF
964: 
965:             IF loc_lProsseguir
966:                 IF !MsgConfirma("Deseja Gravar as Informa" + CHR(231) + CHR(245) + "es?", "Aten" + CHR(231) + CHR(227) + "o")
967:                     loc_lProsseguir = .F.
968:                 ENDIF
969:             ENDIF
970: 
971:             IF loc_lProsseguir
972:                 IF THIS.this_oBusinessObject.SalvarLista("cursor_4c_Dados")
973:                     MsgInfo("Grava" + CHR(231) + CHR(227) + "o Realizada.", "Aten" + CHR(231) + CHR(227) + "o")
974:                     THIS.Release()
975:                 ENDIF
976:             ENDIF
977:         CATCH TO loc_oErro
978:             MsgErro(loc_oErro.Message + CHR(13) + ;
979:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
980:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
981:         ENDTRY
982:     ENDPROC
983: 
984:     *--------------------------------------------------------------------------
985:     * BtnEncerrarClick - fecha o form sem gravar
986:     * (equivalente ao PROCEDURE cmdsair.Click do Grupo_Botao no legado)
987:     *--------------------------------------------------------------------------
988:     PROCEDURE BtnEncerrarClick()
989:         THIS.Release()
990:     ENDPROC
991: 
992:     *--------------------------------------------------------------------------
993:     * KeyPress - ESC fecha o form (equivalente ao PROCEDURE KeyPress do legado)
994:     *--------------------------------------------------------------------------
995:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
996:         IF par_nKeyCode = 27
997:             THIS.BtnEncerrarClick()
998:             NODEFAULT
999:         ENDIF
1000:     ENDPROC
1001: 
1002:     *--------------------------------------------------------------------------
1003:     * TornarControlesVisiveis - torna cada controle visivel recursivamente
1004:     * FILTRO: nenhum container flutuante neste form
1005:     *--------------------------------------------------------------------------
1006:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1007:         LOCAL loc_i, loc_oControl
1008: 
1009:         FOR loc_i = 1 TO par_oContainer.ControlCount
1010:             loc_oControl = par_oContainer.Controls(loc_i)
1011:             IF VARTYPE(loc_oControl) = "O"
1012:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1013:                     loc_oControl.Visible = .T.
1014:                 ENDIF
1015:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1016:                     THIS.TornarControlesVisiveis(loc_oControl)
1017:                 ENDIF
1018:             ENDIF
1019:         ENDFOR
1020:     ENDPROC
1021: 
1022:     *--------------------------------------------------------------------------
1023:     * Destroy - libera o Business Object ao fechar o form
1024:     *--------------------------------------------------------------------------
1025:     PROCEDURE Destroy()
1026:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1027:             THIS.this_oBusinessObject = .NULL.
1028:         ENDIF
1029:         DODEFAULT()
1030:     ENDPROC
1031: 
1032: ENDDEFINE


### BO (C:\4c\projeto\app\classes\VcaBO.prg):
*==============================================================================
* VcaBO.prg - Business Object para Vinculo Cliente x Vendedor (SIGALTDT)
* Tabela Principal: SigCdVca (PK: pkchaves)
* Tabelas Relacionadas:
*   - SigCdCli (dados do cliente - rclis)
*   - SigCdUsu (dados do usuario/vendedor responsavel - ncomps, deptos)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS VcaBO AS BusinessBase

    *-- Propriedades: SigCdVca
    this_cIclis    = ""   && iclis char(10) NOT NULL - codigo do cliente (SigCdCli.Iclis)
    this_cResp     = ""   && resp char(20) NOT NULL - codigo do usuario responsavel (SigCdUsu.Usuarios)
    this_cPkChaves = ""   && pkchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Propriedades de exibicao (JOIN - nao persistidas em SigCdVca)
    this_cRclis    = ""   && SigCdCli.rclis char(50) - razao/nome do cliente
    this_cUsuario  = ""   && SigCdUsu.ncomps char(30) - nome do usuario responsavel (alias "usuario" na query legado)
    this_cDeptos   = ""   && SigCdUsu.deptos char(10) - departamento do usuario responsavel

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdVca"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * Cursor pode vir da query com JOIN (rclis/usuario/deptos presentes) ou de
    * um SELECT simples em SigCdVca (so iclis/resp/pkchaves) - por isso as
    * colunas de exibicao sao lidas com TYPE() antes de acessar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cIclis    = TratarNulo(iclis, "C")
            THIS.this_cResp     = TratarNulo(resp, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")

            IF TYPE(par_cAliasCursor + ".rclis") != "U"
                THIS.this_cRclis = TratarNulo(rclis, "C")
            ELSE
                THIS.this_cRclis = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".usuario") != "U"
                THIS.this_cUsuario = TratarNulo(usuario, "C")
            ELSE
                THIS.this_cUsuario = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".deptos") != "U"
                THIS.this_cDeptos = TratarNulo(deptos, "C")
            ELSE
                THIS.this_cDeptos = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCdVca (iclis, resp, pkchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + "," + ;
                       EscaparSQL(THIS.this_cPkChaves) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdVca SET" + ;
                       " iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       " resp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados (READWRITE) com o JOIN do legado
    * (lcQryVca do SIGALTDT.Init): SigCdVca + SigCdCli (rclis) + SigCdUsu
    * (deptos/ncomps). A grade tem colunas editaveis (Iclis/Resp), por isso o
    * cursor precisa ser READWRITE - SQLEXEC() sozinho gera cursor read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Iclis C(10), Resp C(20), PkChaves C(20), ;
                                                    Rclis C(50), Deptos C(10), Usuario C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.iclis AS Iclis, a.resp AS Resp, a.pkchaves AS PkChaves," + ;
                           " c.rclis AS Rclis, b.deptos AS Deptos, b.ncomps AS Usuario" + ;
                           " FROM SigCdVca a" + ;
                           " INNER JOIN SigCdUsu b ON a.resp = b.usuarios" + ;
                           " INNER JOIN SigCdCli c ON a.iclis = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SET NULL ON
                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                    SET NULL OFF
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    SELECT cursor_4c_Dados
                    INDEX ON Iclis   TAG Iclis   ADDITIVE
                    INDEX ON Resp    TAG Resp    ADDITIVE
                    INDEX ON Rclis   TAG Rclis   ADDITIVE
                    INDEX ON Deptos  TAG Deptos  ADDITIVE
                    INDEX ON Usuario TAG Usuario ADDITIVE
                    SET ORDER TO TAG Iclis
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar v" + CHR(237) + "nculos Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLista - Substitui TODO o conteudo de SigCdVca pelas linhas validas
    * do cursor da grade (mesma semantica do legado cmdok.Click: apaga tudo e
    * reinsere com pkchaves novo). Linhas com Iclis ou Resp vazios (linha em
    * branco ainda nao preenchida) sao descartadas, equivalente ao
    * "Delete From CrSigCdVca Where Empty(IClis) or Empty(Resp)" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLista(par_cCursorAlias)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan, loc_nResultado

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.

        TRY
            IF !USED(par_cCursorAlias)
                THIS.this_cMensagemErro = "Cursor de v" + CHR(237) + "nculos n" + CHR(227) + "o inicializado."
                MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, "DELETE FROM SigCdVca")
                IF loc_nResultado < 0
                    loc_lErroScan = .T.
                    THIS.this_cMensagemErro = "Falha ao limpar v" + CHR(237) + "nculos anteriores:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
                ELSE
                    SELECT (par_cCursorAlias)
                    GO TOP
                    SCAN FOR !EMPTY(Iclis) AND !EMPTY(Resp)
                        THIS.this_cIclis = Iclis
                        THIS.this_cResp  = Resp
                        IF NOT THIS.Inserir()
                            loc_lErroScan = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    loc_lSucesso = .T.
                ENDIF
                SQLSETPROP(gnConnHandle, "Transactions", 1)
                loc_lTransacaoAberta = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

