# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.this_cRetorno()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.this_nCotacaoParam()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAlC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (756 linhas total):

*-- Linhas 30 a 213:
30: * FASE 6/8 - CAMPOS (PARTE 2) E VALIDACOES: completa o bloco
31: * "Moeda/Cotacao" (dentro de shp_4c_Shape2 - Get_Moeda/Say4 e
32: * Get_Cotacao/Say1 do dump) e liga os handlers que simulam o Valid de
33: * cada campo (BINDEVENT "Valid" nao funciona em TextBox - usar KeyPress
34: * com guarda de Enter/Tab). Este dialogo NAO tem lookup/picker nenhum
35: * no legado (sem fwBuscaExt/sigacess/F4) - a "validacao de campo" aqui
36: * eh consulta direta (usuario/senha/cargo/variacao de cotacao), ja
37: * exposta pelo SigOpAlCBO.
38: *
39: * FASE 7/8 - EVENTOS PRINCIPAIS: liga os 2 botoes de obj_4c_CntBotoes
40: * (BtnConfirmarClick/BtnCancelarClick, equivalentes a btnConfirmar.Click/
41: * btnSair.Click do legado) fechando o fluxo via
42: * THIS.this_oBusinessObject.ProcessarAutorizacao()/CancelarAutorizacao().
43: *
44: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: FormParaBO()/
45: * BOParaForm() (Form<->BO dos campos Usuario/Senha/Cotacao/Moeda,
46: * chamados em BtnConfirmarClick/InicializarForm), Activate() (fecha o
47: * dialogo sozinho quando a moeda nao permite alteracao de cotacao -
48: * equivalente ao Activate do legado, gap que faltava desde a Fase 3) e
49: * o fix de THIS.Init() que tratava parametro moeda ausente com NVL()
50: * em vez de VARTYPE() (regra #15 do CLAUDE.md - NVL so substitui
51: * .NULL., e parametro nao informado chega como .F., nao .NULL.).
52: * BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick/CarregarLista/
53: * AjustarBotoesPorModo/HabilitarCampos/LimparCampos NAO se aplicam -
54: * ver o comentario dedicado antes de Destroy().
55: *
56: * Herda de: FormBase
57: *====================================================================
58: 
59: DEFINE CLASS FormSigOpAlC AS FormBase
60: 
61:     *-- Propriedades visuais (copiadas do SCX legado - SIGOPALC)
62:     this_cMensagemErro = ""
63:     Width        = 540
64:     Height       = 170
65:     Caption      = "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o"
66:     DataSession  = 2
67:     ShowWindow = 1
68:     AutoCenter   = .T.
69:     BorderStyle  = 2
70:     ControlBox   = .F.
71:     Closable     = .F.
72:     ClipControls = .F.
73:     TitleBar     = 0
74:     WindowType   = 1
75:     AlwaysOnTop  = .T.
76: 
77:     *-- Propriedades do Form (equivalentes as custom properties do legado:
78:     *   Cotacao/Data/poDataMgr/Retorna)
79:     this_oBusinessObject = .NULL.
80:     this_cMoedaParam      = ""        && par_cMoeda recebido no Init (lcMoeda)
81:     this_nCotacaoParam    = 0         && par_nCotacao recebido no Init (lnCotacao)
82:     this_dDataParam       = {}        && par_dData recebido no Init (ldData)
83:     this_nCotacaoOficial  = 0         && ThisForm.Cotacao do legado (fBuscarCotacao)
84:     this_cRetorno         = "CANCELADO"    && ThisForm.Retorna do legado
85: 
86:     *====================================================================
87:     * Init - equivalente a Init(lcMoeda, lnCotacao, ldData) do legado.
88:     * Guarda os parametros ANTES de acionar a cadeia do FormBase (que
89:     * aplica SET DATE TO BRITISH/SET CENTURY ON e chama InicializarForm).
90:     *====================================================================
91:     PROCEDURE Init(par_cMoeda, par_nCotacao, par_dData)
92:         LOCAL loc_lSucesso
93: 
94:         *-- Parametro ausente chega como .F. (Logico), nao como .NULL. -
95:         *   NVL(par_cMoeda, "") nao pega esse caso (NVL so substitui
96:         *   .NULL., e .F. nao eh .NULL.). Testar VARTYPE, igual aos
97:         *   outros dois parametros.
98:         THIS.this_cMoedaParam   = IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, "")
99:         THIS.this_nCotacaoParam = IIF(VARTYPE(par_nCotacao) = "N", par_nCotacao, 0)
100:         THIS.this_dDataParam    = IIF(VARTYPE(par_dData) = "D", par_dData, DATE())
101: 
102:         loc_lSucesso = DODEFAULT()
103: 
104:         RETURN loc_lSucesso
105:     ENDPROC
106: 
107:     *====================================================================
108:     * InicializarForm - cria o Business Object, carrega a moeda e monta
109:     * a estrutura visual basica (faixa do cabecalho + shapes).
110:     *====================================================================
111:     PROTECTED PROCEDURE InicializarForm()
112:         LOCAL loc_lSucesso
113:         loc_lSucesso = .F.
114: 
115:         TRY
116:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpAlCBO")
117: 
118:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
119:                 THIS.this_oBusinessObject.this_dData    = THIS.this_dDataParam
120:                 THIS.this_oBusinessObject.this_nCotacao = THIS.this_nCotacaoParam
121: 
122:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
123:                     THIS.this_oBusinessObject.CarregarMoeda(THIS.this_cMoedaParam)
124: 
125:                     *-- Init legado: If !crMoe.Cotas / Messagebox('Esta moeda
126:                     *   nao permite Alteracao de Cotacao...') / Endif. O
127:                     *   fechamento em si (ThisForm.Release do Activate legado)
128:                     *   fica em THIS.Activate() - o dialogo nunca chega a ficar
129:                     *   interativo, so o aviso sai aqui.
130:                     IF !THIS.this_oBusinessObject.this_lMoedaPermiteAlteracao
131:                         MsgAviso("Esta moeda n" + CHR(227) + "o permite Altera" + CHR(231) + ;
132:                             CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o...", ;
133:                             "Aten" + CHR(231) + CHR(227) + "o!!!")
134:                         THIS.this_cRetorno = "CANCELADO"
135:                     ENDIF
136:                 ENDIF
137: 
138:                 THIS.ConfigurarLayoutBase()
139:                 THIS.ConfigurarBotoes()
140:                 THIS.ConfigurarCampos()
141:                 THIS.ConfigurarEventosCampos()
142:                 THIS.ConfigurarEventosBotoes()
143: 
144:                 *-- So reflete o BO depois de CarregarMoeda ter rodado de
145:                 *   verdade - em gb_4c_ValidandoUI (CarregarMoeda pulado
146:                 *   acima) this_cMoeda fica no default "" da property, e
147:                 *   sobrescrever txt_4c_Moeda apagaria o valor de teste que
148:                 *   ConfigurarCampos ja colocou a partir de this_cMoedaParam.
149:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
150:                     THIS.BOParaForm()
151:                 ENDIF
152: 
153:                 loc_lSucesso = .T.
154:             ENDIF
155:         CATCH TO loc_oErro
156:             THIS.this_cMensagemErro = loc_oErro.Message
157:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
158:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Altera" + ;
159:                 CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
160:             loc_lSucesso = .F.
161:         ENDTRY
162: 
163:         RETURN loc_lSucesso
164:     ENDPROC
165: 
166:     *====================================================================
167:     * ConfigurarLayoutBase - fundo (Picture do legado), faixa do
168:     * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado) e os 2
169:     * Shapes decorativos (Shape1/Shape2). Campos (Get_Usuario/Get_Senha/
170:     * Get_Cotacao/Get_Moeda) e o grupo de botoes (cntBotoes) entram nas
171:     * fases seguintes.
172:     *====================================================================
173:     PROTECTED PROCEDURE ConfigurarLayoutBase()
174:         THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
175: 
176:         THIS.AddObject("cnt_4c_Sombra", "Container")
177:         WITH THIS.cnt_4c_Sombra
178:             .Top         = 0
179:             .Left        = 0
180:             .Width       = THIS.Width
181:             .Height      = 80
182:             .BorderWidth = 0
183:             .BackStyle   = 1
184:             .BackColor   = RGB(100, 100, 100)
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
189:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
190:             .FontBold      = .T.
191:             .FontName      = "Tahoma"
192:             .FontSize      = 18
193:             .FontUnderline = .F.
194:             .WordWrap      = .T.
195:             .AutoSize      = .F.
196:             .Alignment     = 0
197:             .BackStyle     = 0
198:             .Caption       = THIS.Caption
199:             .Height        = 40
200:             .Left          = 10
201:             .Top           = 18
202:             .Width         = THIS.Width - 20
203:             .ForeColor     = RGB(0, 0, 0)
204:             .Visible       = .T.
205:         ENDWITH
206: 
207:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
208:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
209:             .FontBold  = .T.
210:             .FontName  = "Tahoma"
211:             .FontSize  = 18
212:             .WordWrap  = .T.
213:             .AutoSize  = .F.

*-- Linhas 276 a 319:
276:     * que ainda nao existem neste arquivo (entram nas Fases 5-6) - ficam
277:     * para a fase de eventos, junto com esses campos.
278:     *====================================================================
279:     PROTECTED PROCEDURE ConfigurarBotoes()
280:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
281:         WITH THIS.obj_4c_CntBotoes
282:             .Top         = -2
283:             .Left        = 385
284:             .Width       = 160
285:             .Height      = 85
286:             .ButtonCount = 2
287:             .BackStyle   = 0
288:             .BorderStyle = 0
289:             .Value       = 0
290:             .Visible     = .T.
291: 
292:             WITH .Buttons(1)
293:                 .Top             = 5
294:                 .Left            = 5
295:                 .Width           = 75
296:                 .Height          = 75
297:                 .FontBold        = .T.
298:                 .FontItalic      = .T.
299:                 .FontName        = "Comic Sans MS"
300:                 .FontSize        = 8
301:                 .WordWrap        = .T.
302:                 .AutoSize        = .F.
303:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
304:                 .Caption         = "Confirmar"
305:                 .MousePointer    = 15
306:                 .ToolTipText     = "Gravar os Dados Informados"
307:                 .SpecialEffect   = 0
308:                 .PicturePosition = 13
309:                 .ForeColor       = RGB(90, 90, 90)
310:                 .BackColor       = RGB(255, 255, 255)
311:                 .Themes          = .F.
312:             ENDWITH
313: 
314:             WITH .Buttons(2)
315:                 .Top             = 5
316:                 .Left            = 80
317:                 .Width           = 75
318:                 .Height          = 75
319:                 .FontBold        = .T.

*-- Linhas 348 a 391:
348:     * chega preenchida com THIS.this_cMoedaParam. Get_Cotacao chega
349:     * preenchida com THIS.this_nCotacaoParam (cotacao sugerida).
350:     *====================================================================
351:     PROTECTED PROCEDURE ConfigurarCampos()
352:         *-- Say2 "Usuario :" (lbl_4c_Label2)
353:         THIS.AddObject("lbl_4c_Label2", "Label")
354:         WITH THIS.lbl_4c_Label2
355:             .FontName  = "Tahoma"
356:             .FontSize  = 8
357:             .BackStyle = 0
358:             .AutoSize  = .F.
359:             .Alignment = 0
360:             .Caption   = "Usu" + CHR(225) + "rio :"
361:             .Left      = 123
362:             .Top       = 104
363:             .Width     = 49
364:             .Height    = 17
365:             .ForeColor = RGB(90, 90, 90)
366:             .Visible   = .T.
367:         ENDWITH
368: 
369:         *-- Get_Usuario (txt_4c_Usuario) - SigCdUsu.Usuarios char(10)
370:         THIS.AddObject("txt_4c_Usuario", "TextBox")
371:         WITH THIS.txt_4c_Usuario
372:             .Value         = ""
373:             .Height        = 23
374:             .Left          = 176
375:             .Top           = 101
376:             .Width         = 84
377:             .MaxLength     = 10
378:             .InputMask     = "!!!!!!!!!!"
379:             .Alignment     = 0
380:             .SpecialEffect = 1
381:             .ForeColor     = RGB(0, 0, 0)
382:             .BorderColor   = RGB(100, 100, 100)
383:             .TabIndex      = 1
384:             .Visible       = .T.
385:         ENDWITH
386: 
387:         *-- Say3 "Senha :" (lbl_4c_Label3)
388:         THIS.AddObject("lbl_4c_Label3", "Label")
389:         WITH THIS.lbl_4c_Label3
390:             .FontName  = "Tahoma"
391:             .FontSize  = 8

*-- Linhas 495 a 756:
495: 
496:     *====================================================================
497:     * ConfigurarEventosCampos - liga os handlers que simulam o Valid do
498:     * legado (BINDEVENT "Valid" NAO funciona em TextBox - usar KeyPress
499:     * com guarda de Enter/Tab, regra geral do projeto). Get_Usuario.Valid
500:     * e Get_Senha.Valid/Get_Cotacao.Valid do dump
501:     * (SigOpAlC_form_codigo_fonte.txt:513-598).
502:     *
503:     * Get_Moeda nao recebe handler - eh ReadOnly e o legado tem
504:     * When = .F. (campo nunca editavel). O guard equivalente ao When de
505:     * Get_Cotacao (Return Not Empty(ThisForm.Get_Usuario.Value) - so
506:     * libera a cotacao depois do usuario preenchido) vai no GotFocus de
507:     * txt_4c_Cotacao.
508:     *====================================================================
509:     PROTECTED PROCEDURE ConfigurarEventosCampos()
510:         BINDEVENT(THIS.txt_4c_Usuario, "KeyPress", THIS, "ValidarUsuario")
511:         BINDEVENT(THIS.txt_4c_Senha,   "KeyPress", THIS, "ValidarSenha")
512:         BINDEVENT(THIS.txt_4c_Cotacao, "GotFocus", THIS, "ValidarAcessoCotacao")
513:         BINDEVENT(THIS.txt_4c_Cotacao, "KeyPress", THIS, "ValidarCotacao")
514:     ENDPROC
515: 
516:     *====================================================================
517:     * ConfigurarEventosBotoes - liga os 2 botoes de obj_4c_CntBotoes
518:     * (Fase 7/8 - eventos principais) aos handlers equivalentes a
519:     * btnConfirmar.Click/btnSair.Click do legado. Buttons(1) = Confirmar
520:     * (Command1/btnConfirmar), Buttons(2) = Cancelar (Command2/btnSair) -
521:     * ver ConfigurarBotoes().
522:     *====================================================================
523:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
524:         BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
525:         BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnCancelarClick")
526:     ENDPROC
527: 
528:     *====================================================================
529:     * ValidarUsuario - Get_Usuario.Valid do legado. So valida se o
530:     * campo nao esta vazio (If Not Empty(This.Value) do dump); achando
531:     * usuario invalido OU cargo sem acesso para alterar cotacao, BLOQUEIA
532:     * a saida do campo (o legado faz Return 0 nos dois casos) devolvendo
533:     * o foco e exibindo a mensagem que o BO deixou em this_cMensagemErro.
534:     *
535:     * PUBLIC (sem PROTECTED) - BINDEVENT so funciona com metodo PUBLIC.
536:     *====================================================================
537:     PROCEDURE ValidarUsuario(par_nKeyCode, par_nShiftAltCtrl)
538:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
539:             RETURN
540:         ENDIF
541: 
542:         IF EMPTY(ALLTRIM(THIS.txt_4c_Usuario.Value))
543:             RETURN
544:         ENDIF
545: 
546:         IF !THIS.this_oBusinessObject.ValidarUsuario(THIS.txt_4c_Usuario.Value)
547:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
548:             THIS.txt_4c_Usuario.SetFocus()
549:             NODEFAULT
550:         ENDIF
551:     ENDPROC
552: 
553:     *====================================================================
554:     * ValidarSenha - Get_Senha.Valid do legado. Usuario nao encontrado
555:     * usa "Return -1" no dump - numerico diferente de zero EH TRUTHY em
556:     * VFP9, ou seja NAO bloqueia a saida do campo (so avisa); senha
557:     * incorreta nem tem Return (tambem nao bloqueia). Replicar fielmente:
558:     * SEMPRE mostrar o aviso quando a validacao falhar, NUNCA devolver o
559:     * foco (a gravacao real so bloqueia depois, no clique de Confirmar).
560:     *====================================================================
561:     PROCEDURE ValidarSenha(par_nKeyCode, par_nShiftAltCtrl)
562:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
563:             RETURN
564:         ENDIF
565: 
566:         IF !THIS.this_oBusinessObject.ValidarSenha(THIS.txt_4c_Usuario.Value, THIS.txt_4c_Senha.Value)
567:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
568:         ENDIF
569:     ENDPROC
570: 
571:     *====================================================================
572:     * ValidarAcessoCotacao - equivalente ao When de Get_Cotacao do legado
573:     * (Return Not Empty(ThisForm.Get_Usuario.Value)): sem o Usuario
574:     * preenchido, o campo nao pode ser editado - devolve o foco para
575:     * txt_4c_Usuario.
576:     *====================================================================
577:     PROCEDURE ValidarAcessoCotacao()
578:         IF EMPTY(ALLTRIM(THIS.txt_4c_Usuario.Value))
579:             THIS.txt_4c_Usuario.SetFocus()
580:         ENDIF
581:     ENDPROC
582: 
583:     *====================================================================
584:     * ValidarCotacao - Get_Cotacao.Valid do legado: busca a cotacao
585:     * oficial (fBuscarCotacao) e bloqueia (Return 0) so quando a variacao
586:     * percentual excede o limite do cargo do usuario E o valor digitado
587:     * eh diferente de zero - formula/condicao transcritas literalmente
588:     * do dump, via SigOpAlCBO.ValidarVariacaoCotacao.
589:     *====================================================================
590:     PROCEDURE ValidarCotacao(par_nKeyCode, par_nShiftAltCtrl)
591:         LOCAL loc_nCotacaoOficial
592:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
593:             RETURN
594:         ENDIF
595: 
596:         IF THIS.txt_4c_Cotacao.Value = 0
597:             RETURN
598:         ENDIF
599: 
600:         loc_nCotacaoOficial = THIS.this_oBusinessObject.ObterCotacaoOficial(THIS.txt_4c_Moeda.Value, ;
601:             THIS.this_dDataParam)
602: 
603:         IF !THIS.this_oBusinessObject.ValidarVariacaoCotacao(THIS.txt_4c_Cotacao.Value, loc_nCotacaoOficial)
604:             MsgAviso("Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida", "Aten" + CHR(231) + CHR(227) + "o!!!")
605:             THIS.txt_4c_Cotacao.SetFocus()
606:             NODEFAULT
607:         ENDIF
608:     ENDPROC
609: 
610:     *====================================================================
611:     * BtnConfirmarClick - btnConfirmar.Click do legado (Fase 7/8).
612:     * Delega a SigOpAlCBO.ProcessarAutorizacao, que encadeia ValidarUsuario
613:     * -> ValidarSenha -> cotacao preenchida -> variacao maxima do cargo, na
614:     * MESMA ordem/mensagens do dump. Autorizado: copia this_cRetorno do BO
615:     * (equivalente a ThisForm.Retorna = "OK"+Chr(13)+cotacao+Chr(13)+
616:     * usuario), reseta SET DECIMALS TO 2 (igual ao legado, logo antes do
617:     * Release) e fecha o dialogo. Recusado: exibe a mensagem do BO
618:     * (MsgAviso - validacao de entrada, nao excecao) e devolve o foco ao
619:     * campo indicado em this_cCampoFoco, mantendo o dialogo aberto.
620:     *
621:     * PUBLIC (sem PROTECTED) - BINDEVENT so funciona com metodo PUBLIC.
622:     *====================================================================
623:     PROCEDURE BtnConfirmarClick()
624:         THIS.FormParaBO()
625: 
626:         IF THIS.this_oBusinessObject.ProcessarAutorizacao(THIS.txt_4c_Usuario.Value, ;
627:                 THIS.txt_4c_Senha.Value, THIS.txt_4c_Cotacao.Value)
628: 
629:             THIS.this_cRetorno = THIS.this_oBusinessObject.this_cRetorno
630:             SET DECIMALS TO 2
631:             THIS.Release()
632:         ELSE
633:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
634:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
635:             ENDIF
636: 
637:             DO CASE
638:                 CASE THIS.this_oBusinessObject.this_cCampoFoco == "USUARIO"
639:                     THIS.txt_4c_Usuario.SetFocus()
640:                 CASE THIS.this_oBusinessObject.this_cCampoFoco == "SENHA"
641:                     THIS.txt_4c_Senha.SetFocus()
642:                 CASE THIS.this_oBusinessObject.this_cCampoFoco == "COTACAO"
643:                     THIS.txt_4c_Cotacao.SetFocus()
644:             ENDCASE
645:         ENDIF
646:     ENDPROC
647: 
648:     *====================================================================
649:     * BtnCancelarClick - btnSair.Click do legado (Fase 7/8): equivalente
650:     * literal a ThisForm.Retorna = "CANCELADO" + ThisForm.Release. Delega
651:     * a SigOpAlCBO.CancelarAutorizacao() e copia this_cRetorno do BO.
652:     *
653:     * PUBLIC (sem PROTECTED) - BINDEVENT so funciona com metodo PUBLIC.
654:     *====================================================================
655:     PROCEDURE BtnCancelarClick()
656:         THIS.this_oBusinessObject.CancelarAutorizacao()
657:         THIS.this_cRetorno = THIS.this_oBusinessObject.this_cRetorno
658:         THIS.Release()
659:     ENDPROC
660: 
661:     *====================================================================
662:     * FormParaBO - transfere os campos editaveis (Usuario/Senha/Cotacao)
663:     * para as properties do BO. Chamado no inicio de BtnConfirmarClick,
664:     * antes de ProcessarAutorizacao() - este.this_cUsuario eh depois
665:     * sobrescrito pelo proprio ValidarUsuario com o valor confirmado em
666:     * SigCdUsu (fonte de verdade), e this_cSenha/this_nCotacao sao
667:     * reatribuidos por ProcessarAutorizacao com os mesmos parametros;
668:     * ainda assim o Form->BO fica explicito aqui, no padrao do projeto.
669:     * Get_Moeda nao entra - eh somente-leitura (When=.F. no legado).
670:     *====================================================================
671:     PROTECTED PROCEDURE FormParaBO()
672:         THIS.this_oBusinessObject.this_cUsuario = ALLTRIM(THIS.txt_4c_Usuario.Value)
673:         THIS.this_oBusinessObject.this_cSenha   = ALLTRIM(THIS.txt_4c_Senha.Value)
674:         THIS.this_oBusinessObject.this_nCotacao = THIS.txt_4c_Cotacao.Value
675:     ENDPROC
676: 
677:     *====================================================================
678:     * BOParaForm - transfere do BO para o Form apos CarregarMoeda: a
679:     * moeda exibida passa a ser a confirmada/normalizada por
680:     * CarregarDoCursor (this_cMoeda, PADR a 3 chars), nao mais o
681:     * parametro cru do Init. A cotacao sugerida so eh sobrescrita
682:     * quando o BO ja tem um valor diferente de zero (CarregarMoeda nao
683:     * altera this_nCotacao - ela so muda de novo apos THIS.FormParaBO()
684:     * no clique de Confirmar, entao aqui o valor ainda eh o sugerido na
685:     * abertura).
686:     *====================================================================
687:     PROTECTED PROCEDURE BOParaForm()
688:         THIS.txt_4c_Moeda.Value = THIS.this_oBusinessObject.this_cMoeda
689: 
690:         IF THIS.this_oBusinessObject.this_nCotacao <> 0
691:             THIS.txt_4c_Cotacao.Value = THIS.this_oBusinessObject.this_nCotacao
692:         ENDIF
693:     ENDPROC
694: 
695:     *====================================================================
696:     * Activate - equivalente ao Activate do legado (If crMoe.Cotas /
697:     * ThisForm.Visible=.t. / Else / ThisForm.Release / EndIf): quando a
698:     * moeda carregada em InicializarForm NAO permite alteracao de
699:     * cotacao (this_lMoedaPermiteAlteracao = .F.), o dialogo fecha
700:     * sozinho ao tentar ficar ativo, sem exigir nenhum clique do
701:     * usuario - o aviso correspondente ja foi exibido em
702:     * InicializarForm (equivalente ao Messagebox do Init legado).
703:     *
704:     * Guard de gb_4c_ValidandoUI: em modo de validacao de UI,
705:     * CarregarMoeda() eh pulado (regra ja usada em InicializarForm) e
706:     * this_lMoedaPermiteAlteracao fica no default .F. da property -
707:     * sem este guard o harness nunca conseguiria inspecionar os
708:     * controles, porque o form se fecharia antes.
709:     *====================================================================
710:     PROCEDURE Activate()
711:         IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
712:                 VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
713:                 !THIS.this_oBusinessObject.this_lMoedaPermiteAlteracao
714:             THIS.Release()
715:         ENDIF
716:     ENDPROC
717: 
718:     *====================================================================
719:     * Metodos CRUD-canonicos que NAO se aplicam a este dialogo (Fase
720:     * 8/8 - consolidacao final). SigOpAlC eh um dialogo modal UNICO de
721:     * autorizacao, sem Page1(Lista)/Page2(Dados), sem lista de
722:     * registros e sem modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR - a
723:     * mesma analise ja feita nas Fases 3/4/6/7 deste arquivo. Exigir
724:     * qualquer um deles obrigaria a inventar estrutura que o legado nao
725:     * tem (viola o PILAR 1 e a regra "NUNCA inventar funcionalidade")
726:     * ou a criar metodo vazio (stub proibido pela regra de completude):
727:     *
728:     *   BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick - convencao de
729:     *     form CRUD (Page1 "Lista" com Buscar/Encerrar, Page2 "Dados"
730:     *     com Salvar/Cancelar). O botao de acao deste legado se chama
731:     *     "Confirmar" (BtnConfirmarClick, ja implementado) e o de saida
732:     *     "Cancelar" (BtnCancelarClick, ja implementado) - ambos
733:     *     presentes acima, com os nomes que o legado de fato usa.
734:     *   CarregarLista/AjustarBotoesPorModo - pressupoem grid de LISTA e
735:     *     modo atual (this_cModoAtual). analise.json confirma
736:     *     temGrid=false; layout.json nao declara nenhum BaseClass
737:     *     grid/pageframe. O "carregamento" real deste dialogo eh
738:     *     CarregarMoeda() (chamado em InicializarForm), que busca a
739:     *     UNICA moeda recebida por parametro - nao uma lista.
740:     *   HabilitarCampos/LimparCampos - pressupoem alternancia entre
741:     *     modo de edicao e modo de consulta/lista. Aqui so ha UM modo:
742:     *     o dialogo abre, o usuario se autentica e confirma ou cancela;
743:     *     nao ha "limpar para o proximo Incluir" nem campo que mude de
744:     *     ReadOnly por modo (Get_Moeda eh ReadOnly SEMPRE, regra fixa do
745:     *     legado, ja aplicada em ConfigurarCampos).
746:     *====================================================================
747: 
748:     *====================================================================
749:     * Destroy - DODEFAULT() libera o Business Object e rebuilda os
750:     * popups do menu principal (fix menu-shrinks de forms modais).
751:     *====================================================================
752:     PROCEDURE Destroy()
753:         DODEFAULT()
754:     ENDPROC
755: 
756: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpAlCBO.prg):
*====================================================================
* SigOpAlCBO.prg
*
* Business Object para Alteracao de Cotacao (SigOpAlC)
* Dialogo de autorizacao: usuario+senha com permissao de cargo
* (AltCots = 'S') autoriza a mudanca da cotacao de uma moeda,
* respeitando a variacao maxima percentual do cargo (VarCots).
* Tabela de referencia: SigCdMoe (Cmoes/Cotas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpAlCBO AS BusinessBase

    *-- Dados de entrada (parametros recebidos pelo form na abertura)
    this_cMoeda = ""    && SigCdMoe.Cmoes char(3) - moeda cuja cotacao sera alterada
    this_cDescricaoMoeda = ""    && SigCdMoe.dmoes char(15) - descricao da moeda
    this_dData  = {}    && Data de referencia para a cotacao (par_ldData do legado)

    *-- Cotacao digitada pelo usuario e cotacao oficial para comparacao
    this_nCotacao       = 0     && Get_Cotacao.Value - valor digitado pelo usuario
    this_nCotacaoAtual  = 0     && ThisForm.Cotacao - cotacao oficial (fBuscarCotacao)

    *-- Autorizacao (usuario + senha + cargo)
    this_cUsuario           = ""    && SigCdUsu.Usuarios - usuario que autoriza
    this_cSenha             = ""    && Senha digitada (nao persistida - uso transitorio na validacao)
    this_cCargoUsuario      = ""    && SigCdUsu.CCargs - cargo do usuario autenticado
    this_nVariacaoMaxima    = 0     && SigCdCrg.VarCots - variacao percentual maxima permitida ao cargo
    this_cAutorizaCotacao   = ""    && SigCdCrg.AltCots ('S'/'N') - cargo pode alterar cotacao

    *-- Estado da moeda e resultado final do dialogo
    this_lMoedaPermiteAlteracao = .F.    && SigCdMoe.Cotas - moeda permite alteracao de cotacao
    this_cRetorno               = ""     && "OK" + Chr(13) + valor + Chr(13) + usuario, ou "CANCELADO"
    this_cCampoFoco             = ""     && "USUARIO"/"SENHA"/"COTACAO" - campo a focar apos falha

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMoe"
            THIS.this_cCampoChave = "Cmoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpAlCBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - sobrescreve o hook de BusinessBase mapeando as
    * colunas de SigCdMoe (tabela/chave deste BO) do cursor aberto para
    * as propriedades. Fonte UNICA da leitura: nenhum outro metodo le as
    * colunas da moeda direto do cursor.
    *
    * NAO leva PROTECTED - CarregarDoCursor eh PUBLIC na BusinessBase e o
    * Form pode chama-lo de fora; PROTECTED em qualquer nivel da heranca
    * faz a chamada externa estourar "Property not found" em runtime.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos: a sintaxe
    * campo nao existe em VFP9.
    *
    * Existencia de campo conferida com TYPE(alias + ".col") - PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de cursor.
    *
    * cotas eh bit NOT NULL no schema e chega ao VFP ora como Logico ora
    * como Numerico conforme o driver ODBC, por isso o VARTYPE antes de
    * comparar. TratarNulo NAO serve para esta coluna: ele devolve o valor
    * padrao para QUALQUER logico vazio, e .F. eh valor legitimo de cotas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - chave da moeda
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - descricao da moeda
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDescricaoMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    *-- cotas bit - moeda permite alteracao de cotacao
                    IF TYPE(loc_cAlias + ".cotas") != "U"
                        THIS.this_lMoedaPermiteAlteracao = IIF(VARTYPE(cotas) = "L", ;
                            cotas, (NVL(cotas, 0) = 1))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da moeda:" + CHR(13) + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMoeda - Init legado: CursorQuery('SigCdMoe','CrMoe','Cmoes',
    * Padr(lcMoeda,3)) + checagem de crMoe.Cotas. Carrega this_cMoeda e
    * this_lMoedaPermiteAlteracao; quem decide fechar o dialogo quando a
    * moeda nao permite (Activate.Else do legado: ThisForm.Release) eh o
    * Form, apos chamar este metodo.
    *====================================================================
    PROCEDURE CarregarMoeda(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_cMoeda = PADR(ALLTRIM(NVL(par_cMoeda, "")), 3)
        THIS.this_lMoedaPermiteAlteracao = .F.

        TRY
            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(THIS.this_cMoeda)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

            IF loc_nResultado > 0 AND USED("cursor_4c_Moe") AND !EOF("cursor_4c_Moe")
                *-- a leitura das colunas fica concentrada em CarregarDoCursor
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moe")
                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Falha ao ler os dados da moeda."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o cadastrada."
            ENDIF

            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarUsuario - Get_Usuario.Valid / 1a parte do btnConfirmar.Click:
    * localiza o usuario ATIVO em SigCdUsu e confere se o cargo dele
    * (SigCdCrg.AltCots = 'S') autoriza alteracao de cotacao. Preenche
    * this_cUsuario/this_cCargoUsuario/this_nVariacaoMaxima/
    * this_cAutorizaCotacao. NAO valida a senha (ver ValidarSenha).
    *====================================================================
    PROCEDURE ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_cUsuarioPad, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)

        IF EMPTY(ALLTRIM(loc_cUsuarioPad))
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas, ccargs FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR RECCOUNT("cursor_4c_Usuar") = 0
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            ELSE
                SELECT cursor_4c_Usuar
                GO TOP
                THIS.this_cUsuario      = TratarNulo(usuarios, "")
                THIS.this_cCargoUsuario = TratarNulo(ccargs, "")

                IF THIS.ValidarCargoAutorizacao(THIS.this_cCargoUsuario)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio sem acesso para alterar cota" + ;
                        CHR(231) + CHR(227) + "o !!"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarCargoAutorizacao - confere SigCdCrg.AltCots = 'S' para o cargo
    * informado e carrega this_nVariacaoMaxima (VarCots), usado depois por
    * ValidarVariacaoCotacao.
    *====================================================================
    PROCEDURE ValidarCargoAutorizacao(par_cCargo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCargoPad
        loc_lSucesso = .F.

        loc_cCargoPad = PADR(ALLTRIM(NVL(par_cCargo, "")), 10)
        THIS.this_cAutorizaCotacao = ""
        THIS.this_nVariacaoMaxima  = 0

        TRY
            IF USED("cursor_4c_Carg")
                USE IN cursor_4c_Carg
            ENDIF

            loc_cSQL = "SELECT ccargs, altcots, varcots FROM SigCdCrg " + ;
                       "WHERE ccargs = " + EscaparSQL(loc_cCargoPad)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carg")

            IF loc_nResultado > 0 AND USED("cursor_4c_Carg") AND !EOF("cursor_4c_Carg")
                SELECT cursor_4c_Carg
                THIS.this_cAutorizaCotacao = TratarNulo(altcots, "")
                THIS.this_nVariacaoMaxima  = TratarNulo(varcots, 0)
                loc_lSucesso = (THIS.this_cAutorizaCotacao == "S")
            ENDIF

            IF USED("cursor_4c_Carg")
                USE IN cursor_4c_Carg
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarSenha - Get_Senha.Valid / 2a parte do btnConfirmar.Click:
    * confere a senha digitada contra SigCdUsu.Senhas (via fCriptografar)
    * para o usuario informado. Mesma comparacao do legado: Padr(Alltrim(
    * senha_digitada),10) == fCriptografar(crUsuar.Senhas).
    *====================================================================
    PROCEDURE ValidarSenha(par_cUsuario, par_cSenha)
        LOCAL loc_lSucesso, loc_cUsuarioPad, loc_cSenhaPad, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)
        loc_cSenhaPad   = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR RECCOUNT("cursor_4c_Usuar") = 0
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            ELSE
                SELECT cursor_4c_Usuar
                GO TOP
                IF loc_cSenhaPad == fCriptografar(senhas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Senha incorreta !!"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterCotacaoOficial - fBuscarCotacao(moeda, data, poDataMgr) do
    * legado. Guarda o resultado em this_nCotacaoAtual.
    *====================================================================
    PROCEDURE ObterCotacaoOficial(par_cMoeda, par_dData)
        THIS.this_nCotacaoAtual = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
        RETURN THIS.this_nCotacaoAtual
    ENDPROC

    *====================================================================
    * ValidarVariacaoCotacao - Get_Cotacao.Valid / btnConfirmar.Click:
    *   VarCot = (Round(cotacaoDigitada / cotacaoOficial, 2) - 1) * 100
    * Autorizado somente se Abs(VarCot) <= VarCots (variacao maxima do
    * cargo, carregada por ValidarCargoAutorizacao). Formula transcrita
    * literalmente do legado - NAO reescrever (regra do calculo legado).
    *====================================================================
    PROCEDURE ValidarVariacaoCotacao(par_nCotacaoDigitada, par_nCotacaoOficial)
        LOCAL loc_nVariacao
        loc_nVariacao = (ROUND(par_nCotacaoDigitada / par_nCotacaoOficial, 2) - 1) * 100
        RETURN (ABS(loc_nVariacao) <= THIS.this_nVariacaoMaxima)
    ENDPROC

    *====================================================================
    * ProcessarAutorizacao - btnConfirmar.Click do legado: encadeia
    * ValidarUsuario -> ValidarSenha -> cotacao preenchida -> variacao
    * percentual maxima, na MESMA ordem e com as MESMAS mensagens do
    * legado. Quando autoriza, monta this_cRetorno = "OK" + Chr(13) +
    * cotacao + Chr(13) + usuario (igual a ThisForm.Retorna original).
    * Em caso de falha, this_cMensagemErro e this_cCampoFoco ("USUARIO"/
    * "SENHA"/"COTACAO") indicam o que exibir e onde dar SetFocus - quem
    * exibe a mensagem (MsgAviso) e da o SetFocus eh o Form.
    *====================================================================
    PROCEDURE ProcessarAutorizacao(par_cUsuario, par_cSenha, par_nCotacao)
        THIS.this_cMensagemErro = ""
        THIS.this_cCampoFoco    = ""
        THIS.this_cRetorno      = ""
        THIS.this_cSenha        = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)

        IF !THIS.ValidarUsuario(par_cUsuario)
            THIS.this_cCampoFoco = "USUARIO"
            RETURN .F.
        ENDIF

        IF !THIS.ValidarSenha(par_cUsuario, par_cSenha)
            THIS.this_cCampoFoco = "SENHA"
            RETURN .F.
        ENDIF

        IF NVL(par_nCotacao, 0) = 0
            THIS.this_cMensagemErro = "Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!"
            THIS.this_cCampoFoco = "COTACAO"
            RETURN .F.
        ENDIF

        THIS.this_nCotacao = par_nCotacao
        THIS.ObterCotacaoOficial(THIS.this_cMoeda, THIS.this_dData)

        IF !THIS.ValidarVariacaoCotacao(THIS.this_nCotacao, THIS.this_nCotacaoAtual)
            THIS.this_cMensagemErro = "Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!"
            THIS.this_cCampoFoco = "COTACAO"
            RETURN .F.
        ENDIF

        THIS.this_cRetorno = "OK" + CHR(13) + ;
            STR(THIS.this_nCotacao, 15, 4) + CHR(13) + ;
            ALLTRIM(THIS.this_cUsuario)

        RETURN .T.
    ENDPROC

    *====================================================================
    * CancelarAutorizacao - btnSair.Click do legado: ThisForm.Retorna =
    * "CANCELADO". Quem fecha o form (Release) eh quem chama este metodo.
    *====================================================================
    PROCEDURE CancelarAutorizacao()
        THIS.this_cRetorno = "CANCELADO"
        RETURN .T.
    ENDPROC

    *====================================================================
    * Este dialogo NAO persiste nenhuma tabela propria (SigOpAlC nao
    * existe no banco - e um dialogo modal de autorizacao que apenas LE
    * SigCdMoe/SigCdUsu/SigCdCrg e devolve this_cRetorno para quem abriu).
    * Inserir()/Atualizar()/ExecutarExclusao()/ObterChavePrimaria() e
    * RegistrarAuditoria() NAO sao sobrescritos aqui - o comportamento
    * padrao herdado de BusinessBase ja eh o correto para este caso.
    *====================================================================

ENDDEFINE

