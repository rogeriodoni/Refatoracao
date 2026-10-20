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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCbx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (676 linhas total):

*-- Linhas 53 a 202:
53: * (FormBase, Pattern A - regra #36/#37), ligado em "KeyPress" testando
54: * par_nKeyCode (115=F4 abre direto; 13/9=Enter/Tab tentam match exato
55: * primeiro) e em "DblClick" - equivalente ao Valid do legado
56: * (CreateObject('fwBuscaExt', ...)), regra #47 (handler que TESTA a
57: * tecla antes de abrir o picker e o uso legitimo de KeyPress).
58: *
59: * Fase 5/8 (campos - parte 1): cnt_4c_Container1 (legado Container1,
60: * Top=84/Left=0/W=254/H=47, filho DIRETO do form - este dialogo e FLAT,
61: * sem PageFrame, logo sem a compensacao +29 da regra #11/#31) com a
62: * primeira metade dos campos: lbl_4c_Label1+txt_4c_Text1 (Emp) e
63: * lbl_4c_Label2+txt_4c_Text2 (Operacao) - os dois campos com lookup
64: * (fwBuscaExt contra SigCdEmp/SigCdOpe no Valid do legado). Nomes
65: * EXATOS do mapeamento.json (SIGOPCBX.Container1.Label1/2/3 ->
66: * lbl_4c_Label1/2/3, Text1/2/3 -> txt_4c_Text1/2/3). lbl_4c_Label3 e
67: * txt_4c_Text3 (Numero) ficam para a Fase 6; os handlers de lookup
68: * (LostFocus, regra #47) ficam para a Fase 7, junto com Commandgroup1.
69: *
70: * Fase 4/8 (layout captura): o SCX legado (SIGOPCBX) nao tem Grid nem
71: * PageFrame - layout.json/analise.json confirmam grid.temGrid = .F. e o
72: * unico ControlSource do dump e' o do CommandGroup "SAIDA" (vestigio de
73: * classe, nao lista). Este dialogo apenas COLETA valores (Emp/Operacao/
74: * Numero) e devolve ao chamador - nao ha o que listar, logo nao ha Grid
75: * nem botoes CRUD (Incluir/Alterar/Excluir/Buscar) para acrescentar
76: * nesta fase, sem violar o PILAR 1 (nunca inventar UI que o legado nao
77: * tem). Container1 (campos) e Commandgroup1 (botoes Baixa/Cancela)
78: * continuam agendados para as fases seguintes (5/6 = campos, 7 = eventos
79: * dos botoes).
80: *
81: * Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init(),
82: * InicializarForm() e a faixa do cabecalho (cnt_4c_Sombra). O container
83: * de campos (Container1 -> cnt_4c_Container1) e o grupo de botoes
84: * (Commandgroup1 -> obj_4c_Commandgroup1) sao montados nas proximas
85: * fases.
86: *====================================================================
87: 
88: DEFINE CLASS FormSigOpCbx AS FormBase
89: 
90:     *-- Propriedades visuais (legado SIGOPCBX)
91:     Height       = 135
92:     Width        = 527
93:     Caption      = "Baixa de Cadastros"
94:     AutoCenter   = .T.
95:     BorderStyle  = 2
96:     ShowWindow = 1
97:     ControlBox   = .F.
98:     TitleBar     = 0
99:     MaxButton    = .F.
100:     MinButton    = .F.
101:     WindowType   = 1
102:     ClipControls = .T.
103: 
104:     *-- Parametros recebidos na abertura (legado: Lparameters pcForm,
105:     *-- pcCodigo - pcForm so era usado para ParentForm.Tits/poDataMgr;
106:     *-- o titulo chega direto como parametro, sem guardar o form pai)
107:     this_nCodigoPendente = 0   && SigSyCrs.Cods - legado "pcCodigo"
108:     this_cTituloPai      = ""  && legado "ThisForm.ParentForm.Tits"
109: 
110:     *-- Resultado da operacao, lido pelo chamador apos o Show() modal
111:     *-- retornar (legado "Bxado": "B" = confirmou a baixa / "C" = cancelou)
112:     this_cResultado = ""
113: 
114:     *--------------------------------------------------------------------------
115:     * INIT - Recebe os parametros do form pai (legado: Lparameters
116:     * pcForm, pcCodigo) e encaminha para FormBase.Init()/InicializarForm().
117:     *--------------------------------------------------------------------------
118:     PROCEDURE Init(par_nCodigo, par_cTitulo)
119:         THIS.this_nCodigoPendente = IIF(VARTYPE(par_nCodigo) = "N", par_nCodigo, 0)
120:         THIS.this_cTituloPai      = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")
121: 
122:         RETURN DODEFAULT()
123:     ENDPROC
124: 
125:     *--------------------------------------------------------------------------
126:     * InicializarForm - Instancia o Business Object (repassando o codigo do
127:     * registro ainda em aberto recebido no Init) e monta a faixa do cabecalho. Container1
128:     * (campos Emp/Operacao/Numero) e Commandgroup1 (Baixa/Cancela) sao
129:     * montados nas proximas fases.
130:     *--------------------------------------------------------------------------
131:     PROTECTED PROCEDURE InicializarForm()
132:         LOCAL loc_lSucesso
133: 
134:         loc_lSucesso = .F.
135: 
136:         THIS.this_oBusinessObject = CREATEOBJECT("SigOpCbxBO", THIS.this_nCodigoPendente)
137: 
138:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
139:             THIS.this_oBusinessObject.this_cTitulo = THIS.this_cTituloPai
140: 
141:             IF TYPE("gc_4c_UsuarioLogado") = "C"
142:                 THIS.this_oBusinessObject.this_cUsuario = gc_4c_UsuarioLogado
143:             ENDIF
144: 
145:             THIS.ConfigurarCabecalho()
146:             THIS.ConfigurarContainerCampos()
147:             THIS.ConfigurarGrupoBotoes()
148: 
149:             loc_lSucesso = .T.
150:         ENDIF
151: 
152:         RETURN loc_lSucesso
153:     ENDPROC
154: 
155:     *--------------------------------------------------------------------------
156:     * ConfigurarCabecalho - Faixa cinza do topo (legado: cntSombra), com os
157:     * dois labels de titulo sombra/frente (CLAUDE.md regra #11/#23). Largura
158:     * dinamica (THIS.Width) - o legado tem cntSombra.Width=800/labels.Width=769
159:     * herdados do template generico de frmcadastro, incompativeis com este
160:     * dialogo pequeno de 527px.
161:     *--------------------------------------------------------------------------
162:     PROTECTED PROCEDURE ConfigurarCabecalho()
163:         THIS.AddObject("cnt_4c_Sombra", "Container")
164: 
165:         WITH THIS.cnt_4c_Sombra
166:             .Top         = 0
167:             .Left        = 0
168:             .Width       = THIS.Width
169:             .Height      = 80
170:             .BackColor   = RGB(100, 100, 100)
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
176:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
177:             .Top       = 18
178:             .Left      = 10
179:             .Width     = THIS.Width - 20
180:             .Height    = 40
181:             .FontName  = "Tahoma"
182:             .FontSize  = 18
183:             .FontBold  = .T.
184:             .Alignment = 0
185:             .BackStyle = 0
186:             .WordWrap  = .T.
187:             .ForeColor = RGB(0, 0, 0)
188:             .Caption   = THIS.Caption
189:             .Visible   = .T.
190:         ENDWITH
191: 
192:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
193:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
194:             .Top       = 17
195:             .Left      = 10
196:             .Width     = THIS.Width - 20
197:             .Height    = 46
198:             .FontName  = "Tahoma"
199:             .FontSize  = 18
200:             .FontBold  = .T.
201:             .Alignment = 0
202:             .BackStyle = 0

*-- Linhas 227 a 270:
227:     * tres campos, checagem de EmpDopNums) fica para a Fase 7, junto com os
228:     * botoes Baixa/Cancela.
229:     *--------------------------------------------------------------------------
230:     PROTECTED PROCEDURE ConfigurarContainerCampos()
231:         THIS.AddObject("cnt_4c_Container1", "Container")
232: 
233:         WITH THIS.cnt_4c_Container1
234:             .Top           = 84
235:             .Left          = 0
236:             .Width         = 254
237:             .Height        = 47
238:             .SpecialEffect = 0
239:             .Visible       = .T.
240:         ENDWITH
241: 
242:         *----------------------------------------------------------------------
243:         * Label "Emp" (legado Label1)
244:         *----------------------------------------------------------------------
245:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
246:         WITH THIS.cnt_4c_Container1.lbl_4c_Label1
247:             .Top       = 4
248:             .Left      = 7
249:             .Width     = 26
250:             .Height    = 15
251:             .FontName  = "Tahoma"
252:             .FontSize  = 8
253:             .FontBold  = .T.
254:             .Alignment = 0
255:             .BackStyle = 0
256:             .ForeColor = RGB(90, 90, 90)
257:             .Caption   = "Emp"
258:             .Visible   = .T.
259:         ENDWITH
260: 
261:         *----------------------------------------------------------------------
262:         * TextBox Emp (legado Text1) - this_cEmps, lookup SigCdEmp
263:         *----------------------------------------------------------------------
264:         THIS.cnt_4c_Container1.AddObject("txt_4c_Text1", "TextBox")
265:         WITH THIS.cnt_4c_Container1.txt_4c_Text1
266:             .Top       = 18
267:             .Left      = 4
268:             .Width     = 33
269:             .Height    = 23
270:             .MaxLength = 3

*-- Linhas 343 a 676:
343: 
344:         *----------------------------------------------------------------------
345:         * Lookups de Empresa (Text1) e Operacao (Text2) - legado: Valid de
346:         * cada TextBox com CreateObject('fwBuscaExt', ...). F4(115) abre o
347:         * picker direto; Enter(13)/Tab(9) tentam o match exato primeiro
348:         * (equivalente ao "If Not xBrox.plAchouRegistro" do legado) e so
349:         * abrem o picker se nao encontrarem.
350:         *----------------------------------------------------------------------
351:         BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text1, "KeyPress", THIS, "EmpresaKeyPress")
352:         BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text1, "DblClick", THIS, "EmpresaDblClick")
353:         BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text2, "KeyPress", THIS, "OperacaoKeyPress")
354:         BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text2, "DblClick", THIS, "OperacaoDblClick")
355:     ENDPROC
356: 
357:     *--------------------------------------------------------------------------
358:     * FormParaBO - transfere os TRES campos digitaveis (Emp/Operacao/Numero)
359:     * para o Business Object. Extraido do que antes ficava inline no
360:     * handler do botao de acao - mesmo conteudo, agora no hook canonico
361:     * (FormBase.FormParaBO(), PROTECTED, chamado so pelo FormBase.Salvar()
362:     * generico - este dialogo NAO usa Salvar()/Cancelar() da base, chama
363:     * this_oBusinessObject.Inserir() direto, mas o hook continua com
364:     * conteudo REAL - nao eh stub - e evita duplicar a transferencia caso
365:     * outro ponto do form precise dela no futuro).
366:     *
367:     * PROTECTED obrigatoriamente: FormBase declara FormParaBO() PROTECTED e
368:     * o VFP9 nao permite ALARGAR o escopo de um metodo herdado.
369:     *--------------------------------------------------------------------------
370:     PROTECTED PROCEDURE FormParaBO()
371:         THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value)
372:         THIS.this_oBusinessObject.this_cDopes = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value)
373:         THIS.this_oBusinessObject.this_cNumes = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text3.Value)
374:     ENDPROC
375: 
376:     *--------------------------------------------------------------------------
377:     * NOTA DE COMPLETUDE (Fase 8/8): este dialogo NAO tem BOParaForm() nem
378:     * CarregarLista() proprios, e a ausencia e estrutural, nao omissao:
379:     *
380:     *   BOParaForm - no legado (Commandgroup1.Command1.Click) NAO HA nenhum
381:     *   bloco que leve valor do BO/cursor de volta para Text1/Text2/Text3 -
382:     *   o fluxo e so de ENTRADA (Form -> BO). O unico "retorno de valor"
383:     *   da tela e o do picker de lookup (Evaluate('csSigCdEmp.cEmps')/
384:     *   Evaluate('csSigCdOpe.Dopes') no Valid legado), que ja esta
385:     *   implementado em AbrirLookupEmpresa/AbrirLookupOperacao via
386:     *   AbrirLookupCanonico (FormBase) - escrever um BOParaForm() vazio so
387:     *   para o nome aparecer no arquivo seria stub disfarcado (regra de
388:     *   completude), e BusinessBase.BOParaForm() ja herda um PROTECTED
389:     *   PROCEDURE no-op que cobre o caso de ninguem chamar.
390:     *
391:     *   CarregarLista - o SCX legado (SIGOPCBX) nao tem Grid nem PageFrame
392:     *   (layout.json/analise.json: grid.temGrid = .F.); nao ha cursor de
393:     *   listagem nenhum para popular. Inventar uma grade aqui violaria o
394:     *   PILAR 1 (nunca inventar UI que o legado nao tem).
395:     *--------------------------------------------------------------------------
396: 
397:     *--------------------------------------------------------------------------
398:     * EmpresaKeyPress / EmpresaDblClick - lookup de txt_4c_Text1 (legado:
399:     * Container1.Text1.Valid -> CreateObject('fwBuscaExt', ..., 'SigCdEmp',
400:     * ..., 'cEmps', ...)). PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3).
401:     *--------------------------------------------------------------------------
402:     PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
403:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
404:             THIS.AbrirLookupEmpresa()
405:         ELSE
406:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
407:                 THIS.ValidarLookupEmpresa()
408:             ENDIF
409:         ENDIF
410:     ENDPROC
411: 
412:     PROCEDURE EmpresaDblClick()
413:         THIS.AbrirLookupEmpresa()
414:     ENDPROC
415: 
416:     *--------------------------------------------------------------------------
417:     * AbrirLookupEmpresa - abre o picker canonico (FormBuscaAuxiliar via
418:     * AbrirLookupCanonico, herdado de FormBase - Pattern A) SEM checagem
419:     * previa. Usado por F4 e DblClick ("F4 sempre abre lookup direto").
420:     *--------------------------------------------------------------------------
421:     PROTECTED PROCEDURE AbrirLookupEmpresa()
422:         THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
423:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
424:             ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value), ;
425:             THIS.cnt_4c_Container1.txt_4c_Text1, .NULL.)
426:     ENDPROC
427: 
428:     *--------------------------------------------------------------------------
429:     * ValidarLookupEmpresa - usado por Enter/Tab: tenta achar o codigo
430:     * digitado por igualdade exata primeiro (equivalente ao
431:     * "plAchouRegistro" do fwBuscaExt legado); so abre o picker se nao
432:     * encontrar. Campo vazio nao valida (legado: If !IsEmpty(This.Value)).
433:     *--------------------------------------------------------------------------
434:     PROTECTED PROCEDURE ValidarLookupEmpresa()
435:         LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL
436: 
437:         loc_cValor  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value)
438:         loc_cCursor = "cursor_4c_ChkEmps"
439: 
440:         IF EMPTY(loc_cValor)
441:             RETURN
442:         ENDIF
443: 
444:         IF USED(loc_cCursor)
445:             USE IN SELECT(loc_cCursor)
446:         ENDIF
447: 
448:         loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
449:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
450: 
451:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
452:             USE IN SELECT(loc_cCursor)
453:             RETURN
454:         ENDIF
455: 
456:         IF USED(loc_cCursor)
457:             USE IN SELECT(loc_cCursor)
458:         ENDIF
459: 
460:         THIS.AbrirLookupEmpresa()
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * OperacaoKeyPress / OperacaoDblClick - lookup de txt_4c_Text2 (legado:
465:     * Container1.Text2.Valid -> CreateObject('fwBuscaExt', ..., 'SigCdOpe',
466:     * ..., 'Dopes', ...)). PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3).
467:     *--------------------------------------------------------------------------
468:     PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
469:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
470:             THIS.AbrirLookupOperacao()
471:         ELSE
472:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
473:                 THIS.ValidarLookupOperacao()
474:             ENDIF
475:         ENDIF
476:     ENDPROC
477: 
478:     PROCEDURE OperacaoDblClick()
479:         THIS.AbrirLookupOperacao()
480:     ENDPROC
481: 
482:     *--------------------------------------------------------------------------
483:     * AbrirLookupOperacao - SigCdOpe.Dopes eh a PK E a descricao ao mesmo
484:     * tempo (tabela SINGLE-COLUMN - memoria feedback_sigcdope_single_column:
485:     * NUNCA usar Descrs/descs nela). A mesma coluna alimenta codigo e
486:     * descricao no picker (igual ao mAddColuna('Dopes', '', 'Operacao')
487:     * unico do legado).
488:     *--------------------------------------------------------------------------
489:     PROTECTED PROCEDURE AbrirLookupOperacao()
490:         THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
491:             "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
492:             ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value), ;
493:             THIS.cnt_4c_Container1.txt_4c_Text2, .NULL.)
494:     ENDPROC
495: 
496:     *--------------------------------------------------------------------------
497:     * ValidarLookupOperacao - mesmo padrao de ValidarLookupEmpresa, contra
498:     * SigCdOpe.Dopes.
499:     *--------------------------------------------------------------------------
500:     PROTECTED PROCEDURE ValidarLookupOperacao()
501:         LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL
502: 
503:         loc_cValor  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value)
504:         loc_cCursor = "cursor_4c_ChkDopes"
505: 
506:         IF EMPTY(loc_cValor)
507:             RETURN
508:         ENDIF
509: 
510:         IF USED(loc_cCursor)
511:             USE IN SELECT(loc_cCursor)
512:         ENDIF
513: 
514:         loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
515:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
516: 
517:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
518:             USE IN SELECT(loc_cCursor)
519:             RETURN
520:         ENDIF
521: 
522:         IF USED(loc_cCursor)
523:             USE IN SELECT(loc_cCursor)
524:         ENDIF
525: 
526:         THIS.AbrirLookupOperacao()
527:     ENDPROC
528: 
529:     *--------------------------------------------------------------------------
530:     * ConfigurarGrupoBotoes - monta obj_4c_Commandgroup1 (legado
531:     * "Commandgroup1"), com os dois botoes de acao do dialogo:
532:     *   - Buttons(1) "Baixa"   (legado Command1) -> THIS.BtnConfirmarClick()
533:     *   - Buttons(2) "Cancela" (legado Command2) -> THIS.BtnCancelarClick()
534:     *
535:     * Geometria/propriedades EXATAS do dump (SigOpCbx_form_codigo_fonte.txt):
536:     * grupo Top=-3/Left=370/W=160/H=85/BackStyle=0/BorderStyle=0; botoes
537:     * W=75/H=75, FontName="Comic Sans MS", ForeColor=RGB(90,90,90),
538:     * BackColor=RGB(255,255,255), Themes=.F. (canonico de botao DENTRO de
539:     * CommandGroup - regra #99/CLAUDE.md). Picture de cada botao copiado
540:     * LITERALMENTE do dump (regra #25 - nunca inventar nome de icone):
541:     * Command1 = "cadastro_salvar_60.jpg", Command2 = "cadastro_sair_26.jpg".
542:     * Este eh um dialogo FLAT sem PageFrame (sem compensacao +29 - regra
543:     * #11/#31).
544:     *--------------------------------------------------------------------------
545:     PROTECTED PROCEDURE ConfigurarGrupoBotoes()
546:         THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
547: 
548:         WITH THIS.obj_4c_Commandgroup1
549:             .Top         = -3
550:             .Left        = 370
551:             .Width       = 160
552:             .Height      = 85
553:             .ButtonCount = 2
554:             .BackStyle   = 0
555:             .BorderStyle = 0
556:             .Visible     = .T.
557: 
558:             WITH .Buttons(1)
559:                 .Top        = 5
560:                 .Left       = 5
561:                 .Width      = 75
562:                 .Height     = 75
563:                 .FontName   = "Comic Sans MS"
564:                 .FontSize   = 8
565:                 .FontBold   = .T.
566:                 .FontItalic = .T.
567:                 .Caption    = "Baixa"
568:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
569:                 .ForeColor  = RGB(90, 90, 90)
570:                 .BackColor  = RGB(255, 255, 255)
571:                 .Themes     = .F.
572:             ENDWITH
573: 
574:             WITH .Buttons(2)
575:                 .Top        = 5
576:                 .Left       = 80
577:                 .Width      = 75
578:                 .Height     = 75
579:                 .FontName   = "Comic Sans MS"
580:                 .FontSize   = 8
581:                 .FontBold   = .T.
582:                 .FontItalic = .T.
583:                 .Caption    = "Cancela"
584:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_26.jpg"
585:                 .ForeColor  = RGB(90, 90, 90)
586:                 .BackColor  = RGB(255, 255, 255)
587:                 .Themes     = .F.
588:             ENDWITH
589:         ENDWITH
590: 
591:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnConfirmarClick")
592:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnCancelarClick")
593:     ENDPROC
594: 
595:     *--------------------------------------------------------------------------
596:     * BtnConfirmarClick - legado Commandgroup1.Command1.Click (objeto
597:     * "Command1", Caption "Baixa" - nomeado pela ACAO/convencao canonica do
598:     * projeto, nao pelo Caption literal do legado - mesmo padrao do botao
599:     * "Confirma"/Caption "Baixa" de FormSigOpBcb). Valida os tres campos
600:     * (Numero so digitos e obrigatorio, Emp obrigatorio, Operacao
601:     * obrigatoria - TRANSCRITO literalmente do legado, regra #17: a ordem e
602:     * as mensagens de cada guard sao regra de negocio, nao estetica) e, se
603:     * tudo ok, repassa os valores ao BO (THIS.FormParaBO()) e confirma a
604:     * baixa via this_oBusinessObject.Inserir() - que ja faz a validacao da
605:     * chave EmpDopNums contra SigMvCab e a gravacao/commit (SigSyCrs +
606:     * chksubn).
607:     *
608:     * PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3). Guards com RETURN
609:     * bare ficam FORA de qualquer TRY/CATCH (regra CLAUDE.md #1) - nao ha
610:     * TRY neste metodo, a validacao e so leitura de TextBox.
611:     *--------------------------------------------------------------------------
612:     PROCEDURE BtnConfirmarClick()
613:         LOCAL loc_lNumerico, loc_nI, loc_cNumero
614: 
615:         loc_cNumero = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text3.Value)
616: 
617:         IF !EMPTY(loc_cNumero)
618:             loc_lNumerico = .T.
619:             FOR loc_nI = 1 TO LEN(loc_cNumero)
620:                 IF !ISDIGIT(SUBSTR(loc_cNumero, loc_nI, 1))
621:                     loc_lNumerico = .F.
622:                 ENDIF
623:             ENDFOR
624: 
625:             IF !loc_lNumerico
626:                 MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
627:                     "o Digitado N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lido!!!", ;
628:                     "Aten" + CHR(231) + CHR(227) + "o")
629:                 THIS.cnt_4c_Container1.txt_4c_Text3.SetFocus()
630:                 RETURN
631:             ENDIF
632:         ENDIF
633: 
634:         IF EMPTY(loc_cNumero)
635:             MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
636:                 "o Digitado N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lido!!!", ;
637:                 "Aten" + CHR(231) + CHR(227) + "o")
638:             THIS.cnt_4c_Container1.txt_4c_Text3.SetFocus()
639:             RETURN
640:         ENDIF
641: 
642:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value))
643:             MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio Preencher a Empresa !!!", ;
644:                 "Aten" + CHR(231) + CHR(227) + "o")
645:             THIS.cnt_4c_Container1.txt_4c_Text1.SetFocus()
646:             RETURN
647:         ENDIF
648: 
649:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value))
650:             MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio Preencher a Opera" + CHR(231) + CHR(227) + "o !!!", ;
651:                 "Aten" + CHR(231) + CHR(227) + "o")
652:             THIS.cnt_4c_Container1.txt_4c_Text2.SetFocus()
653:             RETURN
654:         ENDIF
655: 
656:         THIS.FormParaBO()
657: 
658:         IF THIS.this_oBusinessObject.Inserir()
659:             THIS.this_cResultado = "B"
660:             THIS.Release()
661:         ENDIF
662:     ENDPROC
663: 
664:     *--------------------------------------------------------------------------
665:     * BtnCancelarClick - legado Commandgroup1.Command2.Click (objeto
666:     * "Command2", Caption "Cancela" - "Bxado = 'C'" + "Release Windows").
667:     * Nomeado pelo canonico do projeto (BtnCancelarClick), nao pelo Caption
668:     * literal "Cancela" do legado. PUBLIC: exigido por BINDEVENT (regra
669:     * CLAUDE.md #3).
670:     *--------------------------------------------------------------------------
671:     PROCEDURE BtnCancelarClick()
672:         THIS.this_cResultado = "C"
673:         THIS.Release()
674:     ENDPROC
675: 
676: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCbxBO.prg):
*====================================================================
* SigOpCbxBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPCBX" (Baixa de
* Cadastros/respostas ainda em aberto). O legado abre este form como filho
* MODAL de outro form (Lparameters pcForm, pcCodigo), captura Empresa/
* Operacao/Numero, valida a combinacao contra SigMvCab.EmpDopNums e,
* ao clicar "Baixa", grava uma linha de resposta por campo (Emps,
* Dopes, Numes, Baixa) num cursor local do form PAI (crGrvCadRs),
* comita essas respostas e marca SigSyCrs.ChkSubn = .T. para o
* registro ainda nao respondido (SigSyCrs.Cods = pcCodigo).
*
* Nao ha tela de listagem nem edicao de UM registro de SigSyCrs aqui -
* a "entidade" deste dialogo e o conjunto de respostas vinculado ao
* codigo (this_nCodigo) recebido do form pai. A chave primaria mais
* proxima, por completude de contrato com BusinessBase, e cidchaves
* (PK de SigSyCrs) - cada resposta grava a SUA PROPRIA cidchaves nova
* (fUniqueIds()), nunca reaproveitada entre Emps/Dopes/Numes/Baixa.
*
* Referencias legado -> BO:
*   Lparameters pcForm        -> fica no FORM (referencia a objeto UI,
*                                 ThisForm.ParentForm/poDataMgr/Tits)
*   Lparameters pcCodigo      -> this_nCodigo       (SigSyCrs.Cods)
*   Container1.Text1.Value    -> this_cEmps         (SigCdEmp.cEmps)
*   Container1.Text2.Value    -> this_cDopes        (SigCdOpe.Dopes)
*   Container1.Text3.Value    -> this_cNumes        (digitos, PADL 6 na chave)
*   lcEdn (chave posicional)  -> this_cEmpDopNums   (= SigMvCab.EmpDopNums)
*   ThisForm.ParentForm.Tits  -> this_cTitulo       (SigSyCrs.Tits)
*   Usuar (PUBLIC global)     -> this_cUsuario      (resposta do campo "Baixa")
*   Bxado ('B'/'C')           -> this_lBaixaConfirmada
*   crGrvCadRs (cursor local) -> this_cCursorRespostas ("cursor_4c_GrvCadRs")
*
* Herda de: BusinessBase
*
* Fase 2/8 - CarregarDoCursor(), validacao da chave EmpDopNums contra
* SigMvCab, gravacao (Inserir/Atualizar), ObterChavePrimaria() e
* RegistrarAuditoria() (chamada por Inserir/Atualizar).
*====================================================================

DEFINE CLASS SigOpCbxBO AS BusinessBase

    *-- Parametro recebido na abertura do dialogo (legado: Lparameters
    *-- pcForm, pcCodigo - pcForm e referencia de objeto e fica no Form)
    this_nCodigo            = 0    && Codigo do registro pendente - legado "pcCodigo" - SigSyCrs.Cods numeric(6,0)

    *-- Campos digitados pelo usuario (Container1.Text1/Text2/Text3)
    this_cEmps              = ""   && Empresa - lookup SigCdEmp.cEmps (char 3)
    this_cDopes             = ""   && Operacao - lookup SigCdOpe.Dopes (char 20)
    this_cNumes             = ""   && Numero do movimento (so digitos) - PADL(ALLTRIM(...),6) na chave posicional

    *-- Chave posicional de validacao (legado "lcEdn") - regra CLAUDE.md
    *-- #42: PADR/PADL explicito em cada parte, NUNCA ALLTRIM isolado -
    *-- o padding faz parte da chave e eh o que casa com a coluna
    *-- EmpDopNums char(29) de SigMvCab (emps char(3) + dopes char(20) +
    *-- Str(numes,6) = 29)
    this_cEmpDopNums        = ""   && PADR(Emps,3) + PADR(Dopes,20) + PADL(ALLTRIM(Numes),6)

    *-- Dados do registro ainda em aberto, fornecidos pelo form pai (legado
    *-- "ThisForm.ParentForm.Tits"/"Usuar") - necessarios para montar as
    *-- linhas de resposta gravadas em SigSyCrs
    this_cTitulo            = ""   && Legado "ThisForm.ParentForm.Tits" - SigSyCrs.Tits (char 20)
    this_cUsuario           = ""   && Legado "Usuar" (PUBLIC global) - resposta do campo "Baixa"

    *-- Resultado da operacao (legado "Bxado": 'B' = baixou / 'C' = cancelou)
    this_lBaixaConfirmada   = .F.

    *-- Cursor de trabalho local (equivalente ao "crGrvCadRs" do legado:
    *-- buffer das respostas Emps/Dopes/Numes/Baixa antes do UpDate)
    this_cCursorRespostas   = "cursor_4c_GrvCadRs"

    *-- Espelho escalar de UMA linha de SigSyCrs (usado por CarregarDoCursor()/
    *-- Atualizar() quando o BO precisa ler ou corrigir uma resposta JA gravada
    *-- pela sua propria cidchaves - o fluxo principal de gravacao desta tela
    *-- (Inserir(), que cria QUATRO linhas por confirmacao) nao usa estes campos)
    this_cCidChaves         = ""   && SigSyCrs.cidchaves (char 20) - PK da linha carregada
    this_cCampos            = ""   && SigSyCrs.campos (char 10) - nome do campo respondido
    this_cPergs             = ""   && SigSyCrs.pergs (text) - rotulo da pergunta
    this_cResps             = ""   && SigSyCrs.resps (text) - resposta gravada
    this_lChkApro           = .F.  && SigSyCrs.chkapro (bit)
    this_lChkSubn           = .F.  && SigSyCrs.chksubn (bit) - .T. = grupo respondido/submetido

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Parametro equivalente ao Lparameters pcCodigo do Init do form legado -
    * pcForm (referencia de objeto UI: ParentForm/poDataMgr/Tits) permanece
    * no Form, fora da responsabilidade do Business Object.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nCodigo)
        DODEFAULT("SigSyCrs")

        THIS.this_cCampoChave = "cidchaves"

        IF VARTYPE(par_nCodigo) = "N"
            THIS.this_nCodigo = par_nCodigo
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigSyCrs para as properties
    * escalares do BO (this_cCidChaves/this_cCampos/this_cPergs/this_cResps/
    * this_lChkApro/this_lChkSubn + this_nCodigo/this_cTitulo ja existentes).
    *
    * Carrega UMA linha de resposta (uma unica cidchaves) - util para inspecao/
    * correcao de uma resposta ja gravada via Atualizar(). O fluxo principal de
    * gravacao (confirmar a Baixa) cria QUATRO linhas novas em Inserir() e nao
    * depende deste metodo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_nCodigo    = TratarNulo(cods, 0)
        THIS.this_cTitulo    = TratarNulo(tits, "")
        THIS.this_cCampos    = TratarNulo(campos, "")
        THIS.this_cResps     = TratarNulo(resps, "")
        THIS.this_cPergs     = TratarNulo(pergs, "")
        THIS.this_lChkApro   = ConverterParaLogico(chkapro)
        THIS.this_lChkSubn   = ConverterParaLogico(chksubn)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Usada por RegistrarAuditoria(). Nao ha uma UNICA
    * cidchaves representando "o registro" desta tela (Inserir() grava quatro
    * linhas, uma por campo respondido) - a chave que identifica a OPERACAO de
    * principio a fim eh o codigo do registro ainda em aberto (this_nCodigo/SigSyCrs.cods).
    * Quando uma linha especifica foi carregada via CarregarDoCursor() (fluxo
    * de Atualizar()), a cidchaves dela e mais precisa e prevalece.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        IF !EMPTY(ALLTRIM(THIS.this_cCidChaves))
            RETURN THIS.this_cCidChaves
        ENDIF

        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Confirma a "Baixa" (legado: Commandgroup1.Command1.Click).
    *
    * 1) Monta a chave posicional EmpDopNums (CLAUDE.md #42: PADR/PADL
    *    EXPLICITO em cada parte - o padding FAZ PARTE da chave e eh o que
    *    casa com SigMvCab.empdopnums char(29) = emps char(3) + dopes char(20)
    *    + numes Str(.,6)).
    * 2) Valida a chave contra SigMvCab (legado: CursorQuery('SigMvCab',
    *    'LocalEest','EmpDopNums', lcEdn,'EmpDopNums') + If Eof('LocalEest')).
    * 3) Grava, num UNICO lote T-SQL com controle de transacao proprio (BEGIN/
    *    COMMIT via SQLEXEC separados NAO protegem - a conexao nasce com
    *    Transactions=2 e @@TRANCOUNT ja vale 1), uma linha em SigSyCrs por
    *    campo respondido (Emps/Dopes/Numes/Baixa - legado: 4x "Insert Into
    *    crGrvCadRs" + "poDatamgr.UpDate('crGrvCadRs')") e a seguir marca TODO
    *    o grupo do codigo ainda em aberto como respondido (legado: "UpDate SigSyCrs
    *    Set ChkSubn = ?llOk Where Cods = ?lnCod").
    *
    * Nota de fidelidade ao legado: a insercao da linha "Baixa" (Resps=Usuario)
    * eh condicionada ao MESMO teste de "Numero nao vazio" da linha "Numes" -
    * o legado reusa a variavel lcVal/Text3.Value nos dois blocos, sem
    * condicao propria para a linha da Baixa. Transcrito literalmente
    * (CLAUDE.md #17/#21b: a condicao que cerca a gravacao e regra, nao
    * detalhe).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cCidEmps, loc_cCidDopes, loc_cCidNumes, loc_cCidBaixa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + ;
                                    PADR(THIS.this_cDopes, 20) + ;
                                    PADL(ALLTRIM(THIS.this_cNumes), 6)

            IF USED("cursor_4c_SigOpCbxMvCab")
                USE IN cursor_4c_SigOpCbxMvCab
            ENDIF

            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvCab WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCbxMvCab")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar a opera" + CHR(231) + CHR(227) + ;
                    "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                THIS.this_lErroExibido = .T.
            ELSE
                IF !USED("cursor_4c_SigOpCbxMvCab") OR EOF("cursor_4c_SigOpCbxMvCab")
                    THIS.this_cMensagemErro = "A opera" + CHR(231) + CHR(227) + "o com o n" + ;
                        CHR(250) + "mero digitado n" + CHR(227) + "o foi encontrada na empresa!"
                    MsgAviso(THIS.this_cMensagemErro, "Baixa de Cadastros")
                    THIS.this_lErroExibido = .T.
                ELSE
                    *-- Regra #22: cidchaves (PK Fortyus) NUNCA reaproveitada entre
                    *-- linhas - uma nova por campo respondido
                    loc_cCidEmps  = EscaparSQL(fUniqueIds())
                    loc_cCidDopes = EscaparSQL(fUniqueIds())
                    loc_cCidNumes = EscaparSQL(fUniqueIds())
                    loc_cCidBaixa = EscaparSQL(fUniqueIds())

                    loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + ;
                        "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + ;
                        "IF @nivel = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Cop4c;" + CHR(13) + ;
                        "BEGIN TRY" + CHR(13)

                    IF !EMPTY(ALLTRIM(THIS.this_cEmps))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Emps") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidEmps + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                            EscaparSQL("Empresa") + ", 1, 0);" + CHR(13)
                    ENDIF

                    IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Dopes") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidDopes + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                            EscaparSQL("Opera" + CHR(231) + CHR(227) + "o") + ", 1, 0);" + CHR(13)
                    ENDIF

                    IF !EMPTY(ALLTRIM(THIS.this_cNumes))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Numes") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidNumes + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ", " + ;
                            EscaparSQL("C" + CHR(243) + "digo") + ", 1, 0);" + CHR(13)

                        *-- Legado: a linha "Baixa" reusa o MESMO teste de
                        *-- Text3/Numes (sem condicao propria) - Resps = Usuar
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Baixa") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidBaixa + ", " + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + ;
                            EscaparSQL("Baixa") + ", 1, 0);" + CHR(13)
                    ENDIF

                    loc_cSQL = loc_cSQL + ;
                        "UPDATE SigSyCrs SET chksubn = 1 WHERE cods = " + ;
                        FormatarNumeroSQL(THIS.this_nCodigo, 0) + ";" + CHR(13) + ;
                        "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + ;
                        "END TRY" + CHR(13) + ;
                        "BEGIN CATCH" + CHR(13) + ;
                        "    IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + ;
                        "    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cop4c; END;" + CHR(13) + ;
                        "    THROW;" + CHR(13) + ;
                        "END CATCH"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao gravar a baixa: " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.this_lBaixaConfirmada = .T.
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar a baixa: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_SigOpCbxMvCab")
            USE IN cursor_4c_SigOpCbxMvCab
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige UMA linha de resposta ja gravada em SigSyCrs,
    * identificada por this_cCidChaves (carregada previamente via
    * CarregarDoCursor()). Nao faz parte do fluxo principal desta tela
    * (Confirmar Baixa sempre grava linhas NOVAS via Inserir()), mas completa
    * o contrato CRUD de BusinessBase para a mesma tabela/chave.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Registro de resposta n" + CHR(227) + ;
                    "o identificado para altera" + CHR(231) + CHR(227) + "o."
                MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                THIS.this_lErroExibido = .T.
            ELSE
                loc_cSQL = "UPDATE SigSyCrs SET" + ;
                    " tits    = " + EscaparSQL(THIS.this_cTitulo)        + ", " + ;
                    " campos  = " + EscaparSQL(THIS.this_cCampos)        + ", " + ;
                    " cods    = " + FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                    " resps   = " + EscaparSQL(THIS.this_cResps)         + ", " + ;
                    " pergs   = " + EscaparSQL(THIS.this_cPergs)         + ", " + ;
                    " chkapro = " + IIF(THIS.this_lChkApro, "1", "0")    + ", " + ;
                    " chksubn = " + IIF(THIS.this_lChkSubn, "1", "0")    + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar a resposta: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar a resposta: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

