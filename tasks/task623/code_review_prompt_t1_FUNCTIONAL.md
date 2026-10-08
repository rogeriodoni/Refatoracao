# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRIBL): Top original=151 vs migrado 'lbl_4c_Label31' Top=251 (diff=100px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1323 linhas total):

*-- Linhas 42 a 329:
42:     *==========================================================================
43:     * Init - recebe chave do movimento e controle do form chamador
44:     *==========================================================================
45:     PROCEDURE Init()
46:         LPARAMETERS par_cChave1, par_oControleChamador
47: 
48:         LOCAL loc_oErro
49:         TRY
50:             THIS.this_cChave1 = IIF(TYPE("par_cChave1") = "C", par_cChave1, "")
51:             IF VARTYPE(par_oControleChamador) = "O"
52:                 THIS.this_oControleChamador = par_oControleChamador
53:             ENDIF
54:         CATCH TO loc_oErro
55:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
56:         ENDTRY
57: 
58:         RETURN DODEFAULT()
59:     ENDPROC
60: 
61:     *==========================================================================
62:     * InicializarForm - cria o Business Object, a faixa de cabecalho (unico
63:     * container do legado) e os campos/CommandGroup do form (ConfigurarPagina-
64:     * Lista). Form OPERACIONAL flat: sem PageFrame e sem grid, tudo direto em
65:     * THIS.
66:     *==========================================================================
67:     PROTECTED PROCEDURE InicializarForm()
68:         LOCAL loc_lSucesso, loc_oErro
69:         loc_lSucesso = .F.
70:         TRY
71:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
72: 
73:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIBLBO")
74:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
75:                 THIS.ConfigurarCabecalho()
76:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
77:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
78: 
79:                 THIS.ConfigurarPaginaLista()
80: 
81:                 *-- Ordem de tabulacao transcrita do TabIndex do SCX. Tem de
82:                 *-- rodar DEPOIS de todos os AddObject de ConfigurarPaginaLista
83:                 *-- /ConfigurarPageFrame, senao a atribuicao cai em controle que
84:                 *-- ainda nao existe.
85:                 THIS.ConfigurarPaginaDados()
86: 
87:                 *-- Cursor auxiliar de movimentos a imprimir (regra: mesma
88:                 *-- estrutura/ordem de campos em TODO CREATE CURSOR TprMvCab)
89:                 IF !USED("TprMvCab")
90:                     CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
91:                 ENDIF
92: 
93:                 THIS.AtualizaBoleto("")
94: 
95:                 THIS.TornarControlesVisiveis(THIS)
96:                 THIS.Visible = .T.
97:                 loc_lSucesso = .T.
98:             ELSE
99:                 MsgErro("Falha ao criar SIGPRIBLBO.", "Erro em InicializarForm")
100:             ENDIF
101:         CATCH TO loc_oErro
102:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
103:         ENDTRY
104:         RETURN loc_lSucesso
105:     ENDPROC
106: 
107:     *==========================================================================
108:     * ConfigurarCabecalho - cnt_4c_Cabecalho equivalente ao cntSombra original
109:     * Original: Top=0, Left=0, Width=1020, Height=80, BackColor=100,100,100
110:     *==========================================================================
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:         LOCAL loc_oErro
113:         TRY
114:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
115:             WITH THIS.cnt_4c_Cabecalho
116:                 .Top         = 0
117:                 .Left        = 0
118:                 .Width       = THIS.Width
119:                 .Height      = 80
120:                 .BackStyle   = 1
121:                 .BackColor   = RGB(100, 100, 100)
122:                 .BorderWidth = 0
123:                 .Visible     = .T.
124:             ENDWITH
125: 
126:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
127:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
128:                 .FontBold      = .T.
129:                 .FontName      = "Tahoma"
130:                 .FontSize      = 18
131:                 .FontUnderline = .F.
132:                 .WordWrap      = .T.
133:                 .Alignment     = 0
134:                 .BackStyle     = 0
135:                 .AutoSize      = .F.
136:                 .Caption       = THIS.Caption
137:                 .Height        = 40
138:                 .Left          = 10
139:                 .Top           = 18
140:                 .Width         = THIS.Width - 20
141:                 .ForeColor     = RGB(0, 0, 0)
142:                 .Visible       = .T.
143:             ENDWITH
144: 
145:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
146:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
147:                 .FontBold      = .T.
148:                 .FontName      = "Tahoma"
149:                 .FontSize      = 18
150:                 .WordWrap      = .T.
151:                 .Alignment     = 0
152:                 .BackStyle     = 0
153:                 .AutoSize      = .F.
154:                 .Caption       = THIS.Caption
155:                 .Height        = 46
156:                 .Left          = 10
157:                 .Top           = 17
158:                 .Width         = THIS.Width - 20
159:                 .ForeColor     = RGB(255, 255, 255)
160:                 .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
161:                 .Visible       = .T.
162:             ENDWITH
163:         CATCH TO loc_oErro
164:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
165:         ENDTRY
166:     ENDPROC
167: 
168:     *==========================================================================
169:     * TornarControlesVisiveis - torna visiveis os controles do container,
170:     * recursivo (Pages de PageFrame e Controls de Container)
171:     *==========================================================================
172:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
173:         LOCAL loc_nI, loc_nP, loc_oObjeto
174:         FOR loc_nI = 1 TO par_oContainer.ControlCount
175:             loc_oObjeto = par_oContainer.Controls(loc_nI)
176:             IF VARTYPE(loc_oObjeto) = "O"
177:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
178:                     loc_oObjeto.Visible = .T.
179:                 ENDIF
180:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
181:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
182:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
183:                     ENDFOR
184:                 ENDIF
185:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
186:                     THIS.TornarControlesVisiveis(loc_oObjeto)
187:                 ENDIF
188:             ENDIF
189:         ENDFOR
190:     ENDPROC
191: 
192:     *==========================================================================
193:     * ConfigurarPaginaLista - Ponto de entrada canonico do funil multi-fase.
194:     * Form OPERACIONAL flat (sem PageFrame/Page1/Page2 no legado): delega para
195:     * ConfigurarPageFrame(), que cria os campos e o CommandGroup diretamente em
196:     * THIS. Guard por PEMSTATUS evita duplicar objetos em caso de reentrada.
197:     *==========================================================================
198:     PROTECTED PROCEDURE ConfigurarPaginaLista()
199:         IF !PEMSTATUS(THIS, "txt_4c_FPags", 5)
200:             THIS.ConfigurarPageFrame()
201:         ENDIF
202:     ENDPROC
203: 
204:     *==========================================================================
205:     * ConfigurarPaginaDados - Form OPERACIONAL FLAT: o legado SIGPRIBL.SCX nao
206:     * tem PageFrame nem Page2 (11 objetos ao todo, todos filhos DIRETOS do
207:     * form), entao os campos de dados - txt_4c_FPags / txt_4c_Locals /
208:     * obj_4c_GetTxtCds e seus labels - sao criados em ConfigurarPageFrame().
209:     *
210:     * O que sobra para este metodo eh a ORDEM DE TABULACAO: o SCX declara
211:     * TabIndex nos 8 controles e o migrador descartou. Com AddObject o VFP9
212:     * numera o TabIndex pela ORDEM DE CRIACAO, que nao tem relacao com a ordem
213:     * do legado - nao da erro, nao entra em log e nao aparece em screenshot,
214:     * so o Tab andando na ordem errada.
215:     *
216:     * TabIndex eh gravavel em runtime, e as atribuicoes tem de ser feitas em
217:     * ordem ASCENDENTE e DEPOIS de todos os AddObject: cada atribuicao poe o
218:     * controle na posicao pedida e empurra os demais para tras.
219:     *
220:     * TabIndex transcrito do dump (SECAO 2 de SIGPRIBL_form_codigo_fonte.txt):
221:     *   Label2 = 1 | getFPags = 2 | Label3 = 3 | getLocals = 4
222:     *   Label31 = 5 | getTxtCds = 6 | lblAviso = 7 | cmdGImprimir = 8
223:     * Sem empate entre os focalizaveis - o SCX deste form nao repete TabIndex.
224:     *==========================================================================
225:     PROCEDURE ConfigurarPaginaDados()
226:         LOCAL loc_oErro
227:         TRY
228:             THIS.lbl_4c_Label2.TabIndex       = 1
229:             THIS.txt_4c_FPags.TabIndex        = 2
230:             THIS.lbl_4c_Label3.TabIndex       = 3
231:             THIS.txt_4c_Locals.TabIndex       = 4
232:             THIS.lbl_4c_Label31.TabIndex      = 5
233:             THIS.obj_4c_GetTxtCds.TabIndex    = 6
234:             THIS.lbl_4c_LblAviso.TabIndex     = 7
235:             THIS.obj_4c_CmdGImprimir.TabIndex = 8
236: 
237:             THIS.Refresh()
238:         CATCH TO loc_oErro
239:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
240:         ENDTRY
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * AlternarPagina - Ponto de entrada canonico do funil multi-fase.
245:     * Form OPERACIONAL flat: nao ha paginas para alternar - recarrega a
246:     * configuracao do boleto atualmente selecionado.
247:     *==========================================================================
248:     PROCEDURE AlternarPagina(par_nPagina)
249:         THIS.AtualizaBoleto(THIS.this_cFPagsSel)
250:         THIS.Refresh()
251:     ENDPROC
252: 
253:     *==========================================================================
254:     * ConfigurarPageFrame - Cria campos (Label2/getFPags/Label3/getLocals/
255:     * Label31/getTxtCds/lblAviso) e o CommandGroup cmdGImprimir (Imprimir +
256:     * Encerrar), direto em THIS (form flat, sem PageFrame no legado).
257:     *==========================================================================
258:     PROTECTED PROCEDURE ConfigurarPageFrame()
259:         LOCAL loc_oErro
260:         TRY
261:             THIS.AddObject("lbl_4c_Label2", "Label")
262:             WITH THIS.lbl_4c_Label2
263:                 .AutoSize  = .F.
264:                 .BorderStyle = 0
265:                 .FontName  = "Tahoma"
266:                 .FontSize  = 8
267:                 .BackStyle = 0
268:                 .Caption   = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
269:                 .Height    = 15
270:                 .Left      = 82
271:                 .Top       = 93
272:                 .Width     = 124
273:                 .ForeColor = RGB(90, 90, 90)
274:                 .Visible   = .T.
275:             ENDWITH
276: 
277:             THIS.AddObject("txt_4c_FPags", "TextBox")
278:             WITH THIS.txt_4c_FPags
279:                 .FontName  = "Tahoma"
280:                 .Left      = 84
281:                 .MaxLength = 12
282:                 .Top       = 110
283:                 .Width     = 94
284:                 .ForeColor = RGB(0, 0, 0)
285:                 .Value     = ""
286:                 .Visible   = .T.
287:             ENDWITH
288:             BINDEVENT(THIS.txt_4c_FPags, "KeyPress", THIS, "TxtFPagsKeyPress")
289:             BINDEVENT(THIS.txt_4c_FPags, "DblClick", THIS, "TxtFPagsDblClick")
290: 
291:             THIS.AddObject("lbl_4c_Label3", "Label")
292:             WITH THIS.lbl_4c_Label3
293:                 .AutoSize  = .F.
294:                 .BorderStyle = 0
295:                 .FontName  = "Tahoma"
296:                 .FontSize  = 8
297:                 .BackStyle = 0
298:                 .Caption   = " Local de Pagamento "
299:                 .Height    = 15
300:                 .Left      = 82
301:                 .Top       = 151
302:                 .Width     = 104
303:                 .ForeColor = RGB(90, 90, 90)
304:                 .Visible   = .T.
305:             ENDWITH
306: 
307:             THIS.AddObject("txt_4c_Locals", "TextBox")
308:             WITH THIS.txt_4c_Locals
309:                 .FontName  = "Tahoma"
310:                 .Format    = "K"
311:                 .Left      = 84
312:                 .MaxLength = 100
313:                 .Top       = 168
314:                 .Width     = 798
315:                 .Height    = 69
316:                 .ForeColor = RGB(0, 0, 0)
317:                 .Value     = ""
318:                 .Enabled   = .F.
319:                 .Visible   = .T.
320:             ENDWITH
321: 
322:             THIS.AddObject("lbl_4c_Label31", "Label")
323:             WITH THIS.lbl_4c_Label31
324:                 .AutoSize  = .F.
325:                 .BorderStyle = 0
326:                 .FontName  = "Tahoma"
327:                 .FontSize  = 8
328:                 .BackStyle = 0
329:                 .Caption   = " Texto de Responsabilidade do Cedente "

*-- Linhas 414 a 470:
414:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
415:                 ENDWITH
416:             ENDWITH
417:             BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(1), "Click", THIS, "CmdImprimirClick")
418:             BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(2), "Click", THIS, "CmdSaidaClick")
419:         CATCH TO loc_oErro
420:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
421:         ENDTRY
422:     ENDPROC
423: 
424:     *==========================================================================
425:     * AtualizaBoleto - Recarrega a configuracao de SigCnFBl pela condicao de
426:     * pagamento informada e habilita/desabilita os campos e o botao Imprimir
427:     * conforme exista ou nao configuracao cadastrada (AtualizaBoleto do
428:     * legado). Retorna .T. se encontrou configuracao para par_cCond.
429:     *==========================================================================
430:     PROCEDURE AtualizaBoleto(par_cCond)
431:         LOCAL loc_cFPags, loc_lAchou, loc_oErro
432:         loc_lAchou = .F.
433:         TRY
434:             loc_cFPags = PADR(NVL(par_cCond, ""), 12)
435:             THIS.this_cFPagsSel = ALLTRIM(loc_cFPags)
436: 
437:             IF !EMPTY(THIS.this_cFPagsSel)
438:                 loc_lAchou = THIS.this_oBusinessObject.CarregarPorFPags(loc_cFPags)
439:             ENDIF
440: 
441:             IF loc_lAchou
442:                 THIS.this_oBusinessObject.EditarRegistro()
443: 
444:                 THIS.txt_4c_Locals.Enabled = .T.
445:                 THIS.txt_4c_Locals.Value   = NVL(THIS.this_oBusinessObject.this_cLocals, "")
446:                 THIS.txt_4c_Locals.Refresh()
447: 
448:                 THIS.obj_4c_GetTxtCds.Enabled = .T.
449:                 THIS.obj_4c_GetTxtCds.Value   = NVL(THIS.this_oBusinessObject.this_cTxtCds, "")
450:                 THIS.obj_4c_GetTxtCds.Refresh()
451: 
452:                 THIS.lbl_4c_LblAviso.Visible = .F.
453: 
454:                 THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .T.
455:                 THIS.obj_4c_CmdGImprimir.Refresh()
456:             ELSE
457:                 THIS.txt_4c_Locals.Value   = ""
458:                 THIS.txt_4c_Locals.Enabled = .F.
459:                 THIS.txt_4c_Locals.Refresh()
460: 
461:                 THIS.obj_4c_GetTxtCds.Value   = ""
462:                 THIS.obj_4c_GetTxtCds.Enabled = .F.
463:                 THIS.obj_4c_GetTxtCds.Refresh()
464: 
465:                 THIS.lbl_4c_LblAviso.Visible = .T.
466: 
467:                 THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
468:                 THIS.obj_4c_CmdGImprimir.Value = 2
469:                 THIS.obj_4c_CmdGImprimir.Refresh()
470:             ENDIF

*-- Linhas 480 a 736:
480:     * legado). Enter/Tab/F4: busca exata por fpags; achando, recarrega o
481:     * boleto; nao achando, abre o picker (fwBuscaExt do legado).
482:     *
483:     * BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox, por isso
484:     * o Valid do legado vive aqui (Enter/Tab = sair do campo) mais o F4, e no
485:     * TxtFPagsDblClick. O When do legado eh so um NoDefault, que nao nega foco
486:     * nem altera comportamento - nada a transcrever.
487:     *
488:     * ORDEM invertida em relacao ao legado, DE PROPOSITO: o legado chama o
489:     * picker primeiro (cujo Init resolve o match exato) e so depois
490:     * AtualizaBoleto; aqui AtualizaBoleto roda primeiro e o picker so abre se
491:     * ela nao achou. O resultado visto pelo usuario eh o mesmo - codigo valido
492:     * carrega sem abrir dialogo nenhum (regra #37: Show() SO se nao resolveu),
493:     * prefixo invalido abre o picker filtrado por LIKE - e evita uma segunda
494:     * consulta. Nao "consertar" reordenando.
495:     *==========================================================================
496:     PROCEDURE TxtFPagsKeyPress
497:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
498: 
499:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
500:             RETURN
501:         ENDIF
502: 
503:         LOCAL loc_cVal, loc_lAchou, loc_lProcessar, loc_oErro
504:         loc_lProcessar = .T.
505:         loc_lAchou     = .T.
506: 
507:         IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_FPags.Value, "")))
508:             THIS.AtualizaBoleto("")
509:             loc_lProcessar = .F.
510:         ENDIF
511: 
512:         IF loc_lProcessar
513:             TRY
514:                 loc_cVal  = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
515:                 loc_lAchou = THIS.AtualizaBoleto(loc_cVal)
516:                 IF loc_lAchou
517:                     THIS.txt_4c_FPags.Value = THIS.this_cFPagsSel
518:                 ENDIF
519:             CATCH TO loc_oErro
520:                 MsgErro(loc_oErro.Message, "Erro ao validar Condi" + CHR(231) + CHR(227) + "o de Pagamento")
521:                 loc_lAchou = .T.
522:             ENDTRY
523: 
524:             IF !loc_lAchou
525:                 THIS.AbrirLookupFPags()
526:             ENDIF
527:         ENDIF
528:     ENDPROC
529: 
530:     *==========================================================================
531:     * TxtFPagsDblClick - getFPags do legado. Duplo clique abre o mesmo picker
532:     * do F4/Enter/Tab (padrao canonico de lookup do projeto).
533:     *==========================================================================
534:     PROCEDURE TxtFPagsDblClick()
535:         IF THIS.txt_4c_FPags.Enabled
536:             THIS.AbrirLookupFPags()
537:         ENDIF
538:     ENDPROC
539: 
540:     *==========================================================================
541:     * AbrirLookupFPags - Picker de condicoes de pagamento (SigCnFBl).
542:     *
543:     * Legado (getFPags.Valid):
544:     *   loLista = CreateObject('fwBuscaExt', ...pnIdConn, 'SigCnFBl',
545:     *                          'crListaRemota', 'FPags', This.Value, 'Selecao', .t.)
546:     *   If Not loLista.plAchouRegistro
547:     *       loLista.mAddColuna('FPags', '', 'Condicao')
548:     *       loLista.Show()
549:     *   EndIf
550:     *   This.Value = Iif(Lastkey()=27, '', crListaRemota.FPags)
551:     *   Use In crListaRemota
552:     *   ThisForm.AtualizaBoleto(This.Value)
553:     *
554:     * Contrato FormBuscaAuxiliar (regras #36/#37 do CLAUDE.md):
555:     *   - 1o argumento eh o HANDLE da conexao (gnConnHandle), NUNCA a tabela
556:     *   - Show() SO quando this_lAchouRegistro = .F. (o Init ja resolve o match
557:     *     exato de 1 registro, exatamente como o plAchouRegistro do fwBuscaExt)
558:     *   - leitura do cursor SO sob a guarda this_lSelecionou, e ANTES do
559:     *     Release() do picker
560:     *
561:     * O 7o argumento .t. que o legado passa ao fwBuscaExt NAO foi transcrito:
562:     * em FormBuscaAuxiliar essa posicao eh par_lBuscaExata, parametro de outra
563:     * semantica (hoje inerte, mas se vier a valer "so match exato" o picker
564:     * abriria vazio para prefixo digitado - o defeito do Erro114). Falso
565:     * cognato: mesma posicao, contrato diferente.
566:     *
567:     * UMA unica coluna, transcrita do dump: o legado NAO exibe clocals no
568:     * picker (char(100) nao cabe na janela de 374px) - nao acrescentar coluna
569:     * que ele nao tem (PILAR 1).
570:     *
571:     * Cancelar (ESC / Cancela / X) LIMPA o campo e zera a configuracao exibida,
572:     * transcrevendo o Iif(Lastkey()=27, '', ...) do legado. Isto NAO eh a
573:     * atribuicao-fora-da-guarda que a regra #37 proibe: ali zerar eh efeito
574:     * colateral acidental, aqui eh o comportamento DELIBERADO do legado - a
575:     * condicao de pagamento invalida nao pode ficar no campo com a tela
576:     * mostrando os dados da anterior.
577:     *==========================================================================
578:     PROCEDURE AbrirLookupFPags()
579:         LOCAL loc_cVal, loc_oLookup, loc_lSelecionou, loc_cEscolhido, loc_oErro
580: 
581:         *-- Guarda de reentrancia ANTES do TRY (regra #1: nenhum RETURN dentro
582:         *-- de TRY/CATCH)
583:         IF THIS.this_lLookupAberto
584:             RETURN
585:         ENDIF
586:         THIS.this_lLookupAberto = .T.
587: 
588:         loc_lSelecionou = .F.
589:         loc_cEscolhido  = ""
590: 
591:         TRY
592:             loc_cVal = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
593: 
594:             IF USED("cursor_4c_BuscaFPags")
595:                 USE IN cursor_4c_BuscaFPags
596:             ENDIF
597: 
598:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
599:                 "SigCnFBl", "cursor_4c_BuscaFPags", "fpags", loc_cVal, ;
600:                 "Sele" + CHR(231) + CHR(227) + "o")
601: 
602:             IF VARTYPE(loc_oLookup) = "O"
603:                 IF !loc_oLookup.this_lAchouRegistro
604:                     loc_oLookup.mAddColuna("fpags", "", "Condi" + CHR(231) + CHR(227) + "o")
605:                     loc_oLookup.Show()
606:                 ENDIF
607: 
608:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
609:                     SELECT cursor_4c_BuscaFPags
610:                     IF !EOF("cursor_4c_BuscaFPags")
611:                         loc_cEscolhido  = ALLTRIM(NVL(cursor_4c_BuscaFPags.fpags, ""))
612:                         loc_lSelecionou = .T.
613:                     ENDIF
614:                 ENDIF
615: 
616:                 loc_oLookup.Release()
617:             ENDIF
618: 
619:             IF USED("cursor_4c_BuscaFPags")
620:                 USE IN cursor_4c_BuscaFPags
621:             ENDIF
622: 
623:             *-- Legado: valor vem do cursor quando escolheu, VAZIO no cancelamento
624:             THIS.txt_4c_FPags.Value = IIF(loc_lSelecionou, loc_cEscolhido, "")
625:             THIS.txt_4c_FPags.Refresh()
626: 
627:             *-- Legado: AtualizaBoleto roda em AMBOS os caminhos (recarrega a
628:             *-- configuracao escolhida, ou apaga os campos quando cancelou)
629:             THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
630:         CATCH TO loc_oErro
631:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
632:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
633:                 "Erro ao abrir busca de Condi" + CHR(231) + CHR(227) + "o")
634:         ENDTRY
635: 
636:         *-- Libera a guarda tambem quando o CATCH disparou
637:         THIS.this_lLookupAberto = .F.
638:     ENDPROC
639:     *==========================================================================
640:     * CmdImprimirClick - cmdImprimir.Click do legado: confirma, grava Local de
641:     * Pagamento/Texto do Cedente editados, confere impressora, e para cada
642:     * movimento em TprMvCab monta o boleto (SigMvCab/SigMvPar/SigCdOpe/
643:     * SigOpCdc/SigMvNfi/SigCdCli/SigOpFp) e chama a rotina de impressao
644:     * matricial SigPrIbl.
645:     *==========================================================================
646:     PROCEDURE CmdImprimirClick()
647:         LOCAL loc_lProsseguir, loc_lTemImpressora, loc_i, loc_cChave1, loc_nParcel, loc_lTaOk
648:         LOCAL loc_cSQL, loc_nRet, loc_cFonteP, loc_cFonteG, loc_nTamFolha
649:         LOCAL loc_cContaCli, loc_xVenc, loc_cNumDoc, loc_nNfiscals, loc_lBoletoHabilitado
650:         LOCAL loc_cEndCob, loc_cBaiCob, loc_cCidCob, loc_cEstCob, loc_cCepCob, loc_oErro
651:         LOCAL ARRAY loc_aPrinters[1]
652: 
653:         IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s) Banc" + CHR(225) + "rio(s)?")
654:             *-- Legado: ThisForm.getLocals.SetFocus. SetFocus em controle com
655:             *-- Enabled = .F. estoura em VFP9; no legado isso nunca acontecia
656:             *-- porque cmdImprimir fica desabilitado junto com getLocals quando
657:             *-- nao ha configuracao de boleto, tornando este caminho inalcancavel.
658:             IF THIS.txt_4c_Locals.Enabled
659:                 THIS.txt_4c_Locals.SetFocus()
660:             ENDIF
661:             RETURN
662:         ENDIF
663: 
664:         IF EMPTY(THIS.this_cFPagsSel) OR !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
665:             MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
666:                 CHR(225) + "lida antes de imprimir.", "Aviso")
667:             RETURN
668:         ENDIF
669: 
670:         loc_lProsseguir = .T.
671:         THIS.LockScreen = .T.
672:         TRY
673:             *-- Grava Local de Pagamento/Texto do Cedente editados de volta em SigCnFBl
674:             THIS.this_oBusinessObject.this_cLocals = THIS.txt_4c_Locals.Value
675:             THIS.this_oBusinessObject.this_cTxtCds = THIS.obj_4c_GetTxtCds.Value
676: 
677:             IF !THIS.this_oBusinessObject.Salvar()
678:                 IF !THIS.this_oBusinessObject.this_lErroExibido
679:                     MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
680:                 ENDIF
681:                 loc_lProsseguir = .F.
682:             ENDIF
683: 
684:             IF loc_lProsseguir
685:                 loc_lTemImpressora = .F.
686:                 IF APRINTERS(loc_aPrinters) > 0
687:                     FOR loc_i = 1 TO ALEN(loc_aPrinters, 1)
688:                         IF UPPER(ALLTRIM(loc_aPrinters[loc_i, 1])) == ;
689:                            UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNomeImps))
690:                             loc_lTemImpressora = .T.
691:                             EXIT
692:                         ENDIF
693:                     ENDFOR
694:                 ENDIF
695:                 IF !loc_lTemImpressora
696:                     MsgAviso("Nenhuma Impressora de Boleto Configurada ou Instalada.", ;
697:                         "Aten" + CHR(231) + CHR(227) + "o")
698:                     loc_lProsseguir = .F.
699:                 ENDIF
700:             ENDIF
701: 
702:             IF loc_lProsseguir
703:                 *-- Carrega movimento recebido na abertura do form (se houver)
704:                 IF !EMPTY(THIS.this_cChave1)
705:                     IF !USED("TprMvCab")
706:                         CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
707:                     ENDIF
708:                     SELECT TprMvCab
709:                     ZAP
710:                     INSERT INTO TprMvCab (Emps, Dopes, Numes) VALUES ;
711:                         (SUBSTR(THIS.this_cChave1, 1, 3), ;
712:                          SUBSTR(THIS.this_cChave1, 4, 20), ;
713:                          INT(VAL(SUBSTR(THIS.this_cChave1, 24, 6))))
714:                 ENDIF
715: 
716:                 IF USED("Crdados")
717:                     USE IN Crdados
718:                 ENDIF
719:                 SET NULL ON
720:                 CREATE CURSOR Crdados ( ;
721:                     clocal  C(100), ;
722:                     vencs   C(12), ;
723:                     datdoc  D, ;
724:                     numdoc  C(8), ;
725:                     valor   N(14,2), ;
726:                     razaos  C(50), ;
727:                     cpfs    C(20), ;
728:                     endcobs C(80), ;
729:                     baicobs C(20), ;
730:                     cidcobs C(20), ;
731:                     estcobs C(2), ;
732:                     cepcobs C(9), ;
733:                     texto   M ;
734:                 )
735:                 SET NULL OFF
736: 

*-- Linhas 768 a 873:
768:                                " FROM SigMvCab WHERE empdopnums = " + EscaparSQL(loc_cChave1)
769:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
770:                     IF loc_nRet <= 0 OR !USED("cursor_4c_MvCab") OR RECCOUNT("cursor_4c_MvCab") = 0
771:                         MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
772:                             "o Encontrou Movimenta" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
773:                         IF USED("cursor_4c_MvCab")
774:                             USE IN cursor_4c_MvCab
775:                         ENDIF
776:                         LOOP
777:                     ENDIF
778: 
779:                     loc_cSQL = "SELECT emps, dopes, numes, parcs, fpags, vencs, datas, valos" + ;
780:                                " FROM SigMvPar WHERE empdopnums = " + EscaparSQL(loc_cChave1) + ;
781:                                " ORDER BY parcs"
782:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPar")
783:                     IF loc_nRet <= 0 OR !USED("cursor_4c_MvPar") OR RECCOUNT("cursor_4c_MvPar") = 0
784:                         MsgAviso("Nenhuma Forma de Pagamento Encontrada Nessa Opera" + CHR(231) + CHR(227) + "o.", ;
785:                             "Aten" + CHR(231) + CHR(227) + "o")
786:                         IF USED("cursor_4c_MvPar")
787:                             USE IN cursor_4c_MvPar
788:                         ENDIF
789:                         IF USED("cursor_4c_MvCab")
790:                             USE IN cursor_4c_MvCab
791:                         ENDIF
792:                         LOOP
793:                     ENDIF
794: 
795:                     *-- Operacao habilitada para impressao de boleto (SigCdOpe+SigOpCdc)
796:                     loc_lBoletoHabilitado = .F.
797:                     loc_nNfiscals = 0
798:                     loc_cSQL = "SELECT TOP 1 dopes, nfiscals FROM SigCdOpe WHERE dopes = " + ;
799:                                EscaparSQL(cursor_4c_MvPar.Dopes)
800:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
801:                     IF loc_nRet > 0 AND USED("cursor_4c_Ope") AND RECCOUNT("cursor_4c_Ope") > 0
802:                         loc_nNfiscals = NVL(cursor_4c_Ope.Nfiscals, 0)
803:                         loc_cSQL = "SELECT TOP 1 dopes, impbols FROM SigOpCdc WHERE dopes = " + ;
804:                                    EscaparSQL(cursor_4c_MvPar.Dopes)
805:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdc")
806:                         IF loc_nRet > 0 AND USED("cursor_4c_OpCdc") AND RECCOUNT("cursor_4c_OpCdc") > 0 ;
807:                            AND NVL(cursor_4c_OpCdc.ImpBols, 0) = 1
808:                             loc_lBoletoHabilitado = .T.
809:                         ENDIF
810:                     ENDIF
811:                     IF USED("cursor_4c_OpCdc")
812:                         USE IN cursor_4c_OpCdc
813:                     ENDIF
814:                     IF USED("cursor_4c_Ope")
815:                         USE IN cursor_4c_Ope
816:                     ENDIF
817: 
818:                     IF !loc_lBoletoHabilitado
819:                         MsgAviso("Opera" + CHR(231) + CHR(227) + "o sem Impress" + CHR(227) + ;
820:                             "o de Boleto Banc" + CHR(225) + "rio Habilitado.", "Aten" + CHR(231) + CHR(227) + "o")
821:                         IF USED("cursor_4c_MvPar")
822:                             USE IN cursor_4c_MvPar
823:                         ENDIF
824:                         IF USED("cursor_4c_MvCab")
825:                             USE IN cursor_4c_MvCab
826:                         ENDIF
827:                         LOOP
828:                     ENDIF
829: 
830:                     loc_cSQL = "SELECT TOP 1 NFis FROM SigMvNfi WHERE empdopnums = " + EscaparSQL(loc_cChave1)
831:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvNfi")
832:                     IF loc_nRet <= 0 OR !USED("cursor_4c_MvNfi") OR RECCOUNT("cursor_4c_MvNfi") = 0
833:                         MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
834:                             "o possui Nota Fiscal Cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
835:                         IF USED("cursor_4c_MvNfi")
836:                             USE IN cursor_4c_MvNfi
837:                         ENDIF
838:                         IF USED("cursor_4c_MvPar")
839:                             USE IN cursor_4c_MvPar
840:                         ENDIF
841:                         IF USED("cursor_4c_MvCab")
842:                             USE IN cursor_4c_MvCab
843:                         ENDIF
844:                         LOOP
845:                     ENDIF
846: 
847:                     *-- Cursor/indice do template de posicoes de impressao
848:                     IF USED("TmpImprime")
849:                         USE IN TmpImprime
850:                     ENDIF
851:                     CREATE CURSOR TmpImprime ( ;
852:                         Linha    N(6,2), ;
853:                         Coluna   N(6,2), ;
854:                         Conteudo C(100), ;
855:                         Style    C(3), ;
856:                         fontname C(64), ;
857:                         fontsize I, ;
858:                         linesize N(6,2), ;
859:                         nheight  N(6,2) ;
860:                     )
861:                     INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem
862: 
863:                     SELECT cursor_4c_MvCab
864:                     loc_cContaCli = IIF(loc_nNfiscals = 1, cursor_4c_MvCab.Contaos, cursor_4c_MvCab.Contads)
865: 
866:                     loc_cSQL = "SELECT TOP 1 Iclis, Razaos, Cpfs, Endes, EndCobs, Bairs, BaiCobs," + ;
867:                                " Cidas, CidCobs, Estas, EstCobs, Ceps, CepCobs" + ;
868:                                " FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaCli)
869:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
870: 
871:                     SELECT Crdados
872:                     ZAP
873: 

*-- Linhas 979 a 1323:
979:         CATCH TO loc_oErro
980:             loc_lProsseguir = .F.
981:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
982:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
983:         ENDTRY
984: 
985:         THIS.LockScreen = .F.
986:         IF loc_lProsseguir
987:             IF VARTYPE(THIS.this_oControleChamador) = "O"
988:                 THIS.this_oControleChamador.Enabled = .T.
989:             ENDIF
990:             THIS.Release()
991:         ENDIF
992:     ENDPROC
993: 
994:     *==========================================================================
995:     * CmdSaidaClick - cmdSaida.Click do legado: confirma abandono se a
996:     * impressao ainda estiver habilitada, reabilita o controle do form
997:     * chamador e encerra.
998:     *==========================================================================
999:     PROCEDURE CmdSaidaClick()
1000:         LOCAL loc_lPodeFechar, loc_oErro
1001:         loc_lPodeFechar = .F.
1002:         TRY
1003:             IF !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
1004:                 loc_lPodeFechar = .T.
1005:             ELSE
1006:                 loc_lPodeFechar = MsgConfirma("Deseja Abandonar as Impress" + CHR(245) + "es do Boleto?")
1007:             ENDIF
1008:         CATCH TO loc_oErro
1009:             MsgErro(loc_oErro.Message, "Erro ao sair")
1010:         ENDTRY
1011: 
1012:         IF loc_lPodeFechar
1013:             IF VARTYPE(THIS.this_oControleChamador) = "O"
1014:                 THIS.this_oControleChamador.Enabled = .T.
1015:             ENDIF
1016:             THIS.Release()
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * GrDetalhe - grdetalhe do legado: insere uma linha de posicao/conteudo no
1022:     * cursor TmpImprime, usado pela rotina de impressao matricial.
1023:     *==========================================================================
1024:     PROCEDURE GrDetalhe(par_nLinha, par_nColuna, par_cDetalhe, par_cEstilo, par_nLineSize, par_nHeight)
1025:         LOCAL loc_nLinha, loc_nColuna, loc_cDetalhe, loc_cEstilo, loc_oErro
1026:         TRY
1027:             loc_nLinha   = IIF(VARTYPE(par_nLinha)   = "N", par_nLinha,   0)
1028:             loc_nColuna  = IIF(VARTYPE(par_nColuna)  = "N", par_nColuna,  0)
1029:             loc_cDetalhe = IIF(VARTYPE(par_cDetalhe) = "C", par_cDetalhe, "")
1030:             loc_cEstilo  = IIF(VARTYPE(par_cEstilo)  = "C", par_cEstilo,  "X")
1031:             IF EMPTY(loc_cEstilo)
1032:                 loc_cEstilo = "X"
1033:             ENDIF
1034: 
1035:             IF !(loc_cEstilo == "*") AND (loc_nColuna != 0 OR loc_nLinha != 0)
1036:                 IF USED("TmpImprime")
1037:                     INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
1038:                         VALUES (loc_nLinha, loc_nColuna, loc_cDetalhe, ALLTRIM(loc_cEstilo), par_nLineSize, par_nHeight)
1039:                 ENDIF
1040:             ENDIF
1041:         CATCH TO loc_oErro
1042:             MsgErro(loc_oErro.Message, "Erro em GrDetalhe")
1043:         ENDTRY
1044:     ENDPROC
1045: 
1046:     *==========================================================================
1047:     * CarregarLista - Ponto de entrada canonico do funil multi-fase. Form
1048:     * OPERACIONAL flat: recarrega a configuracao do boleto atualmente
1049:     * selecionado.
1050:     *==========================================================================
1051:     PROCEDURE CarregarLista()
1052:         LOCAL loc_lSucesso, loc_oErro
1053:         loc_lSucesso = .F.
1054:         TRY
1055:             THIS.AtualizaBoleto(THIS.this_cFPagsSel)
1056:             loc_lSucesso = .T.
1057:         CATCH TO loc_oErro
1058:             MsgErro(loc_oErro.Message, "Erro ao Carregar")
1059:         ENDTRY
1060:         RETURN loc_lSucesso
1061:     ENDPROC
1062: 
1063:     *==========================================================================
1064:     * FormParaBO - Form OPERACIONAL flat: captura o fpags digitado.
1065:     *==========================================================================
1066:     PROTECTED PROCEDURE FormParaBO()
1067:         LOCAL loc_oErro
1068:         TRY
1069:             THIS.this_cFPagsSel = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
1070:         CATCH TO loc_oErro
1071:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1072:         ENDTRY
1073:     ENDPROC
1074: 
1075:     *==========================================================================
1076:     * BOParaForm - Popula os campos a partir do this_oBusinessObject carregado.
1077:     *==========================================================================
1078:     PROTECTED PROCEDURE BOParaForm()
1079:         LOCAL loc_oErro
1080:         TRY
1081:             THIS.txt_4c_FPags.Value     = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cFPags, ""))
1082:             THIS.txt_4c_Locals.Value    = NVL(THIS.this_oBusinessObject.this_cLocals, "")
1083:             THIS.obj_4c_GetTxtCds.Value = NVL(THIS.this_oBusinessObject.this_cTxtCds, "")
1084:         CATCH TO loc_oErro
1085:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1086:         ENDTRY
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     * HabilitarCampos - Habilita/desabilita os campos editaveis e o botao
1091:     * Imprimir conforme exista configuracao de boleto carregada.
1092:     *==========================================================================
1093:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1094:         LOCAL loc_lHabilitar, loc_oErro
1095:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1096:         TRY
1097:             THIS.txt_4c_Locals.Enabled    = loc_lHabilitar
1098:             THIS.obj_4c_GetTxtCds.Enabled = loc_lHabilitar
1099:             THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = loc_lHabilitar
1100:             IF !loc_lHabilitar
1101:                 THIS.obj_4c_CmdGImprimir.Value = 2
1102:             ENDIF
1103:             THIS.obj_4c_CmdGImprimir.Refresh()
1104:         CATCH TO loc_oErro
1105:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
1106:         ENDTRY
1107:     ENDPROC
1108: 
1109:     *==========================================================================
1110:     * LimparCampos - Limpa a selecao corrente (equivalente a nao ter nenhuma
1111:     * configuracao de boleto carregada).
1112:     *==========================================================================
1113:     PROTECTED PROCEDURE LimparCampos()
1114:         LOCAL loc_oErro
1115:         TRY
1116:             THIS.this_cFPagsSel        = ""
1117:             THIS.txt_4c_FPags.Value    = ""
1118:             THIS.txt_4c_Locals.Value   = ""
1119:             THIS.txt_4c_Locals.Enabled = .F.
1120:             THIS.obj_4c_GetTxtCds.Value   = ""
1121:             THIS.obj_4c_GetTxtCds.Enabled = .F.
1122:             THIS.lbl_4c_LblAviso.Visible  = .T.
1123:             THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
1124:             THIS.obj_4c_CmdGImprimir.Value = 2
1125:             THIS.obj_4c_CmdGImprimir.Refresh()
1126:         CATCH TO loc_oErro
1127:             MsgErro(loc_oErro.Message, "Erro em LimparCampos")
1128:         ENDTRY
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * AjustarBotoesPorModo - Form OPERACIONAL flat: o "modo" eh determinado por
1133:     * existir ou nao configuracao de boleto carregada para o fpags atual.
1134:     *==========================================================================
1135:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1136:         LOCAL loc_lTemConfig, loc_oErro
1137:         TRY
1138:             loc_lTemConfig = !EMPTY(THIS.this_cFPagsSel) AND THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
1139:             THIS.lbl_4c_LblAviso.Visible = !loc_lTemConfig
1140:         CATCH TO loc_oErro
1141:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
1142:         ENDTRY
1143:     ENDPROC
1144: 
1145:     *==========================================================================
1146:     * BtnIncluirClick - Ponto de entrada canonico do funil multi-fase. Form
1147:     * OPERACIONAL de impressao de boleto: a acao "Incluir/Confirmar" eh a
1148:     * propria impressao - delega para CmdImprimirClick.
1149:     *==========================================================================
1150:     PROCEDURE BtnIncluirClick()
1151:         LOCAL loc_oErro
1152: 
1153:         IF EMPTY(THIS.this_cFPagsSel) OR !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
1154:             MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
1155:                 CHR(225) + "lida antes de imprimir.", "Aviso")
1156:             THIS.txt_4c_FPags.SetFocus()
1157:             RETURN
1158:         ENDIF
1159: 
1160:         TRY
1161:             THIS.CmdImprimirClick()
1162:         CATCH TO loc_oErro
1163:             MsgErro(loc_oErro.Message, "Erro em Incluir")
1164:         ENDTRY
1165:     ENDPROC
1166: 
1167:     *==========================================================================
1168:     * BtnAlterarClick - Ponto de entrada canonico do funil multi-fase. Form
1169:     * OPERACIONAL: "Alterar" recarrega a configuracao do boleto selecionado e
1170:     * foca o campo de Local de Pagamento para edicao.
1171:     *==========================================================================
1172:     PROCEDURE BtnAlterarClick()
1173:         LOCAL loc_oErro
1174: 
1175:         IF EMPTY(THIS.this_cFPagsSel)
1176:             MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de alterar.", "Aviso")
1177:             THIS.txt_4c_FPags.SetFocus()
1178:             RETURN
1179:         ENDIF
1180: 
1181:         TRY
1182:             THIS.AtualizaBoleto(THIS.this_cFPagsSel)
1183:             IF THIS.txt_4c_Locals.Enabled
1184:                 THIS.txt_4c_Locals.SetFocus()
1185:             ENDIF
1186:         CATCH TO loc_oErro
1187:             MsgErro(loc_oErro.Message, "Erro em Alterar")
1188:         ENDTRY
1189:     ENDPROC
1190: 
1191:     *==========================================================================
1192:     * BtnVisualizarClick - Ponto de entrada canonico do funil multi-fase.
1193:     * "Visualizar" abre o picker de condicoes de pagamento cadastradas.
1194:     *==========================================================================
1195:     PROCEDURE BtnVisualizarClick()
1196:         LOCAL loc_oErro
1197:         TRY
1198:             THIS.AbrirLookupFPags()
1199:         CATCH TO loc_oErro
1200:             MsgErro(loc_oErro.Message, "Erro em Visualizar")
1201:         ENDTRY
1202:     ENDPROC
1203: 
1204:     *==========================================================================
1205:     * BtnExcluirClick - Ponto de entrada canonico do funil multi-fase.
1206:     * "Excluir" limpa a selecao corrente (nao afeta dados persistidos).
1207:     *==========================================================================
1208:     PROCEDURE BtnExcluirClick()
1209:         LOCAL loc_oErro
1210: 
1211:         IF EMPTY(THIS.this_cFPagsSel)
1212:             RETURN
1213:         ENDIF
1214:         IF !MsgConfirma("Deseja limpar a Condi" + CHR(231) + CHR(227) + "o de Pagamento selecionada?")
1215:             RETURN
1216:         ENDIF
1217: 
1218:         TRY
1219:             THIS.LimparCampos()
1220:         CATCH TO loc_oErro
1221:             MsgErro(loc_oErro.Message, "Erro em Excluir")
1222:         ENDTRY
1223: 
1224:         THIS.txt_4c_FPags.SetFocus()
1225:     ENDPROC
1226: 
1227:     *==========================================================================
1228:     * BtnBuscarClick - Ponto de entrada canonico do funil multi-fase. Abre o
1229:     * picker de condicoes de pagamento.
1230:     *==========================================================================
1231:     PROCEDURE BtnBuscarClick()
1232:         LOCAL loc_oErro
1233:         TRY
1234:             THIS.AbrirLookupFPags()
1235:         CATCH TO loc_oErro
1236:             MsgErro(loc_oErro.Message, "Erro em Buscar")
1237:         ENDTRY
1238:     ENDPROC
1239: 
1240:     *==========================================================================
1241:     * BtnEncerrarClick - Ponto de entrada canonico do funil multi-fase.
1242:     *==========================================================================
1243:     PROCEDURE BtnEncerrarClick()
1244:         LOCAL loc_oErro
1245:         TRY
1246:             THIS.CmdSaidaClick()
1247:         CATCH TO loc_oErro
1248:             MsgErro(loc_oErro.Message, "Erro ao encerrar")
1249:         ENDTRY
1250:     ENDPROC
1251: 
1252:     *==========================================================================
1253:     * BtnSalvarClick - Salva Local de Pagamento/Texto do Cedente editados sem
1254:     * disparar a impressao (uso do funil multi-fase/testes).
1255:     *==========================================================================
1256:     PROCEDURE BtnSalvarClick()
1257:         LOCAL loc_oErro
1258: 
1259:         IF EMPTY(THIS.this_cFPagsSel)
1260:             MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de salvar.", "Aviso")
1261:             THIS.txt_4c_FPags.SetFocus()
1262:             RETURN
1263:         ENDIF
1264: 
1265:         TRY
1266:             THIS.this_oBusinessObject.this_cLocals = THIS.txt_4c_Locals.Value
1267:             THIS.this_oBusinessObject.this_cTxtCds = THIS.obj_4c_GetTxtCds.Value
1268: 
1269:             IF THIS.this_oBusinessObject.Salvar()
1270:                 MsgInfo("Dados salvos com sucesso.", "Salvo")
1271:             ELSE
1272:                 IF !THIS.this_oBusinessObject.this_lErroExibido
1273:                     MsgErro("Falha ao salvar. Verifique a conex" + CHR(227) + "o.", "Erro")
1274:                 ENDIF
1275:             ENDIF
1276:         CATCH TO loc_oErro
1277:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao Salvar")
1278:         ENDTRY
1279:     ENDPROC
1280: 
1281:     *==========================================================================
1282:     * BtnCancelarClick - Ponto de entrada canonico do funil multi-fase.
1283:     * Restaura os valores gravados (descarta edicao em andamento).
1284:     *==========================================================================
1285:     PROCEDURE BtnCancelarClick()
1286:         LOCAL loc_oErro
1287:         TRY
1288:             IF EMPTY(THIS.this_cFPagsSel)
1289:                 THIS.LimparCampos()
1290:             ELSE
1291:                 THIS.AtualizaBoleto(THIS.this_cFPagsSel)
1292:             ENDIF
1293:         CATCH TO loc_oErro
1294:             MsgErro(loc_oErro.Message, "Erro ao Cancelar")
1295:         ENDTRY
1296:     ENDPROC
1297: 
1298:     *==========================================================================
1299:     * Destroy - reabilita o controle do form chamador (pcNform1 do legado) e
1300:     * libera os cursores auxiliares de impressao
1301:     *==========================================================================
1302:     PROCEDURE Destroy()
1303:         LOCAL loc_oErro
1304:         TRY
1305:             IF VARTYPE(THIS.this_oControleChamador) = "O"
1306:                 THIS.this_oControleChamador.Enabled = .T.
1307:             ENDIF
1308:             IF USED("cursor_4c_BuscaFPags")
1309:                 USE IN cursor_4c_BuscaFPags
1310:             ENDIF
1311:             IF USED("Crdados")
1312:                 USE IN Crdados
1313:             ENDIF
1314:             IF USED("TmpImprime")
1315:                 USE IN TmpImprime
1316:             ENDIF
1317:         CATCH TO loc_oErro
1318:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Destroy")
1319:         ENDTRY
1320:         DODEFAULT()
1321:     ENDPROC
1322: 
1323: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIBLBO.prg):
*====================================================================
* SIGPRIBLBO.prg
*
* Business Object para Impressao de Boleto Bancario (form OPERACIONAL)
* Tabela: SigCnFBl (Configuracao de Impressao de Boleto Bancario)
* Chave: cidchaves char(20) - PK
* Busca: fpags char(12) - Condicao de Pagamento (campo digitado na tela)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCnFBl)
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cFPags     = ""    && fpags char(12) - condicao de pagamento (chave de busca)
    this_cEmps      = ""    && cemps char(3)
    this_dDatas     = {}    && ddatas datetime
    this_cHoras     = ""    && choras char(8)
    this_cUsuarios  = ""    && cusuarios char(20)
    this_cTxtCds    = ""    && ctxtcds text - texto de responsabilidade do cedente
    this_cLocals    = ""    && clocals char(100) - local de pagamento
    this_nLnLocals  = 0     && nlnlocals numeric(5,2)
    this_nClLocals  = 0     && ncllocals numeric(5,2)
    this_nLnDtVencs = 0     && nlndtvencs numeric(5,2)
    this_nClDtVencs = 0     && ncldtvencs numeric(5,2)
    this_nLnDtDocs  = 0     && nlndtdocs numeric(5,2)
    this_nClDtDocs  = 0     && ncldtdocs numeric(5,2)
    this_nLnNrDocs  = 0     && nlnnrdocs numeric(5,2)
    this_nClNrDocs  = 0     && nclnrdocs numeric(5,2)
    this_nLnVlDocs  = 0     && nlnvldocs numeric(5,2)
    this_nClVlDocs  = 0     && nclvldocs numeric(5,2)
    this_nLnTxtCds  = 0     && nlntxtcds numeric(5,2)
    this_nClTxtCds  = 0     && ncltxtcds numeric(5,2)
    this_nTxtLins   = 0     && ntxtlins numeric(3,0)
    this_nTxtCols   = 0     && ntxtcols numeric(3,0)
    this_nLnRazClis = 0     && nlnrazclis numeric(5,2)
    this_nClRazClis = 0     && nclrazclis numeric(5,2)
    this_nLnEndCobs = 0     && nlnendcobs numeric(5,2)
    this_nClEndCobs = 0     && nclendcobs numeric(5,2)
    this_nLnCgcClis = 0     && nlncgcclis numeric(5,2)
    this_nClCgcClis = 0     && nclcgcclis numeric(5,2)
    this_nLnBaiCobs = 0     && nlnbaicobs numeric(5,2)
    this_nClBaiCobs = 0     && nclbaicobs numeric(5,2)
    this_nLnCidCobs = 0     && nlncidcobs numeric(5,2)
    this_nClCidCobs = 0     && nclcidcobs numeric(5,2)
    this_nLnEstCobs = 0     && nlnestcobs numeric(5,2)
    this_nClEstCobs = 0     && nclestcobs numeric(5,2)
    this_nLnCepCobs = 0     && nlncepcobs numeric(5,2)
    this_nClCepCobs = 0     && nclcepcobs numeric(5,2)
    this_cNomeImps  = ""    && cnomeimps char(128) - nome da impressora
    this_cFontePdrs = ""    && cfontepdrs char(128) - fonte padrao
    this_nTamFontes = 0     && ntamfontes numeric(3,0)
    this_cTamFolha  = ""    && ctamfolha char(50)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCnFBl"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRIBLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves eh a PK fisica (char(20)) de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas do cursor para as propriedades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves,  "")
            THIS.this_cFPags     = TratarNulo(fpags,      "")
            THIS.this_cEmps      = TratarNulo(cemps,      "")
            THIS.this_dDatas     = TratarNulo(ddatas,     {})
            THIS.this_cHoras     = TratarNulo(choras,     "")
            THIS.this_cUsuarios  = TratarNulo(cusuarios,  "")
            THIS.this_cTxtCds    = TratarNulo(ctxtcds,    "")
            THIS.this_cLocals    = TratarNulo(clocals,    "")
            THIS.this_nLnLocals  = TratarNulo(nlnlocals,  0)
            THIS.this_nClLocals  = TratarNulo(ncllocals,  0)
            THIS.this_nLnDtVencs = TratarNulo(nlndtvencs, 0)
            THIS.this_nClDtVencs = TratarNulo(ncldtvencs, 0)
            THIS.this_nLnDtDocs  = TratarNulo(nlndtdocs,  0)
            THIS.this_nClDtDocs  = TratarNulo(ncldtdocs,  0)
            THIS.this_nLnNrDocs  = TratarNulo(nlnnrdocs,  0)
            THIS.this_nClNrDocs  = TratarNulo(nclnrdocs,  0)
            THIS.this_nLnVlDocs  = TratarNulo(nlnvldocs,  0)
            THIS.this_nClVlDocs  = TratarNulo(nclvldocs,  0)
            THIS.this_nLnTxtCds  = TratarNulo(nlntxtcds,  0)
            THIS.this_nClTxtCds  = TratarNulo(ncltxtcds,  0)
            THIS.this_nTxtLins   = TratarNulo(ntxtlins,   0)
            THIS.this_nTxtCols   = TratarNulo(ntxtcols,   0)
            THIS.this_nLnRazClis = TratarNulo(nlnrazclis, 0)
            THIS.this_nClRazClis = TratarNulo(nclrazclis, 0)
            THIS.this_nLnEndCobs = TratarNulo(nlnendcobs, 0)
            THIS.this_nClEndCobs = TratarNulo(nclendcobs, 0)
            THIS.this_nLnCgcClis = TratarNulo(nlncgcclis, 0)
            THIS.this_nClCgcClis = TratarNulo(nclcgcclis, 0)
            THIS.this_nLnBaiCobs = TratarNulo(nlnbaicobs, 0)
            THIS.this_nClBaiCobs = TratarNulo(nclbaicobs, 0)
            THIS.this_nLnCidCobs = TratarNulo(nlncidcobs, 0)
            THIS.this_nClCidCobs = TratarNulo(nclcidcobs, 0)
            THIS.this_nLnEstCobs = TratarNulo(nlnestcobs, 0)
            THIS.this_nClEstCobs = TratarNulo(nclestcobs, 0)
            THIS.this_nLnCepCobs = TratarNulo(nlncepcobs, 0)
            THIS.this_nClCepCobs = TratarNulo(nclcepcobs, 0)
            THIS.this_cNomeImps  = TratarNulo(cnomeimps,  "")
            THIS.this_cFontePdrs = TratarNulo(cfontepdrs, "")
            THIS.this_nTamFontes = TratarNulo(ntamfontes, 0)
            THIS.this_cTamFolha  = TratarNulo(ctamfolha,  "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorFPags - Carrega configuracao de boleto pela condicao de
    * pagamento (fpags eh o campo de busca digitado na tela; cidchaves eh a
    * PK fisica Fortyus, gerada so no Inserir)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorFPags(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha" + ;
                       " FROM SigCnFBl WHERE fpags = " + EscaparSQL(par_cFPags)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo na tabela SigCnFBl
    * cidchaves eh a PK fisica Fortyus - gerada aqui, nunca vazia (regra #22)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = PADR(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCnFBl" + ;
                       " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo na tabela SigCnFBl (cidchaves eh a chave,
    * nunca alterada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " fpags = "      + EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       " cemps = "      + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       " ddatas = "     + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " choras = "     + EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       " cusuarios = "  + EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       " ctxtcds = "    + EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       " clocals = "    + EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       " nlnlocals = "  + FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       " ncllocals = "  + FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       " nlndtdocs = "  + FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       " ncldtdocs = "  + FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       " nlnnrdocs = "  + FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       " nclnrdocs = "  + FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       " nlnvldocs = "  + FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       " nclvldocs = "  + FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       " nlntxtcds = "  + FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       " ncltxtcds = "  + FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       " ntxtlins = "   + FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       " ntxtcols = "   + FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       " nclrazclis = " + FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       " nclendcobs = " + FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       " nclestcobs = " + FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       " cnomeimps = "  + EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       " cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       " ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       " ctamfolha = "  + EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

