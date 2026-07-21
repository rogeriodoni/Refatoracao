# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGPRIBL): Top original=251 vs migrado 'lbl_4c_Label31' Top=151 (diff=100px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1273 linhas total):

*-- Linhas 33 a 121:
33:     *--------------------------------------------------------------------------
34:     * Init - Recebe chave do movimento pai e referencia ao form chamador
35:     *--------------------------------------------------------------------------
36:     PROCEDURE Init
37:         LPARAMETERS par_cChave1, par_cNform1
38: 
39:         IF VARTYPE(par_cChave1) = "C"
40:             THIS.this_cChave1 = par_cChave1
41:         ENDIF
42:         THIS.this_xNform1 = par_cNform1
43: 
44:         *-- Cursor auxiliar de movimentos a imprimir (compartilhado com SigPrIbl.prg)
45:         IF !USED("TprMvCab")
46:             CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
47:         ENDIF
48: 
49:         RETURN DODEFAULT()
50:     ENDPROC
51: 
52:     *--------------------------------------------------------------------------
53:     * InicializarForm - Configura o formulario operacional completo
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso, loc_oErro
57:         loc_lSucesso = .F.
58:         TRY
59:             THIS.Caption = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
60: 
61:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
62:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
63:             ENDIF
64: 
65:             THIS.ConfigurarCabecalho()
66:             THIS.ConfigurarPageFrame()
67:             THIS.TornarControlesVisiveis()
68:             THIS.AtualizaBoleto("")
69: 
70:             loc_lSucesso = .T.
71:         CATCH TO loc_oErro
72:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
73:                     " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
74:         ENDTRY
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *--------------------------------------------------------------------------
79:     * ConfigurarCabecalho - Cria container cinza superior com titulo
80:     *--------------------------------------------------------------------------
81:     PROTECTED PROCEDURE ConfigurarCabecalho()
82:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
83:         WITH THIS.cnt_4c_Cabecalho
84:             .Top        = 0
85:             .Left       = 0
86:             .Width      = 1020
87:             .Height     = 80
88:             .BorderWidth = 0
89:             .BackStyle  = 1
90:             .BackColor  = RGB(100, 100, 100)
91: 
92:             .AddObject("lbl_4c_LblSombra", "Label")
93:             WITH .lbl_4c_LblSombra
94:                 .AutoSize      = .F.
95:                 .Top           = 18
96:                 .Left          = 10
97:                 .Width         = THIS.Width
98:                 .Height        = 40
99:                 .FontBold      = .T.
100:                 .FontName      = "Tahoma"
101:                 .FontSize      = 18
102:                 .FontUnderline = .F.
103:                 .WordWrap      = .T.
104:                 .Alignment     = 0
105:                 .BackStyle     = 0
106:                 .ForeColor     = RGB(0, 0, 0)
107:                 .Caption       = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
108:             ENDWITH
109: 
110:             .AddObject("lbl_4c_LblTitulo", "Label")
111:             WITH .lbl_4c_LblTitulo
112:                 .AutoSize      = .F.
113:                 .Top           = 17
114:                 .Left          = 10
115:                 .Width         = THIS.Width
116:                 .Height        = 46
117:                 .FontBold      = .T.
118:                 .FontName      = "Tahoma"
119:                 .FontSize      = 18
120:                 .FontUnderline = .F.
121:                 .WordWrap      = .T.

*-- Linhas 133 a 238:
133:     * Delega para ConfigurarPageFrame (montagem flat) apenas se controles ainda
134:     * nao foram criados, evitando duplicacao em caso de reentrada.
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE ConfigurarPaginaLista()
137:         IF !PEMSTATUS(THIS, "txt_4c_FPags", 5)
138:             THIS.ConfigurarPageFrame()
139:         ENDIF
140:     ENDPROC
141: 
142:     *--------------------------------------------------------------------------
143:     * ConfigurarPaginaDados - Ponto de entrada canonico do pipeline (Fase 5)
144:     * Form OPERACIONAL: nao possui Page2 separada com campos de edicao.
145:     * Todos os controles (txt_4c_FPags, txt_4c_Locals, obj_4c_GetTxtCds,
146:     * lbl_4c_*, obj_4c_CmdGImprimir) ja foram criados em ConfigurarPageFrame().
147:     * Este metodo existe apenas por compatibilidade com o pipeline multi-fase.
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarPaginaDados()
150:         THIS.Refresh()
151:     ENDPROC
152: 
153:     *--------------------------------------------------------------------------
154:     * AlternarPagina - Ponto de entrada canonico do pipeline
155:     * Form OPERACIONAL: nao ha alternancia de paginas; recarrega configuracao
156:     * do boleto e faz refresh dos controles com base no FPags atual.
157:     *--------------------------------------------------------------------------
158:     PROCEDURE AlternarPagina(par_nPagina)
159:         THIS.AtualizaBoleto(THIS.this_cFPagsSel)
160:         THIS.Refresh()
161:     ENDPROC
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarPageFrame - Configura layout do form (OPERACIONAL flat, sem PageFrame real)
165:     * Nome mantido por compatibilidade com pipeline; em forms OPERACIONAIS
166:     * este metodo cria labels, TextBoxes, EditBox e CommandGroup diretamente
167:     * no form (sem Page1/Page2). Equivalente a ConfigurarInterface em CRUD.
168:     *--------------------------------------------------------------------------
169:     PROTECTED PROCEDURE ConfigurarPageFrame()
170:         LOCAL loc_oErro
171:         TRY
172:             *-- lbl_4c_Label2: Condicao de Pagamento
173:             THIS.AddObject("lbl_4c_Label2", "Label")
174:             WITH THIS.lbl_4c_Label2
175:                 .AutoSize   = .T.
176:                 .FontName   = "Tahoma"
177:                 .FontSize   = 8
178:                 .BackStyle  = 0
179:                 .Caption    = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
180:                 .Height     = 15
181:                 .Left       = 82
182:                 .Top        = 93
183:                 .Width      = 124
184:                 .ForeColor  = RGB(90, 90, 90)
185:             ENDWITH
186: 
187:             *-- txt_4c_FPags: TextBox de selecao da condicao de pagamento (lookup SigCnFBl)
188:             THIS.AddObject("txt_4c_FPags", "TextBox")
189:             WITH THIS.txt_4c_FPags
190:                 .FontName   = "Tahoma"
191:                 .Left       = 84
192:                 .MaxLength  = 12
193:                 .Top        = 110
194:                 .Width      = 94
195:                 .ForeColor  = RGB(0, 0, 0)
196:                 .Value      = ""
197:             ENDWITH
198:             BINDEVENT(THIS.txt_4c_FPags, "KeyPress", THIS, "TxtFPagsKeyPress")
199: 
200:             *-- lbl_4c_Label3: Local de Pagamento
201:             THIS.AddObject("lbl_4c_Label3", "Label")
202:             WITH THIS.lbl_4c_Label3
203:                 .AutoSize   = .T.
204:                 .FontName   = "Tahoma"
205:                 .FontSize   = 8
206:                 .BackStyle  = 0
207:                 .Caption    = " Local de Pagamento "
208:                 .Height     = 15
209:                 .Left       = 82
210:                 .Top        = 151
211:                 .Width      = 104
212:                 .ForeColor  = RGB(90, 90, 90)
213:             ENDWITH
214: 
215:             *-- txt_4c_Locals: TextBox de local de pagamento (editavel, multi-linha via Height)
216:             THIS.AddObject("txt_4c_Locals", "TextBox")
217:             WITH THIS.txt_4c_Locals
218:                 .FontName   = "Tahoma"
219:                 .Left       = 84
220:                 .MaxLength  = 100
221:                 .Top        = 168
222:                 .Width      = 798
223:                 .Height     = 69
224:                 .ForeColor  = RGB(0, 0, 0)
225:                 .Value      = ""
226:                 .Enabled    = .F.
227:             ENDWITH
228: 
229:             *-- lbl_4c_Label31: Texto de Responsabilidade do Cedente
230:             THIS.AddObject("lbl_4c_Label31", "Label")
231:             WITH THIS.lbl_4c_Label31
232:                 .AutoSize   = .T.
233:                 .FontName   = "Tahoma"
234:                 .FontSize   = 8
235:                 .BackStyle  = 0
236:                 .Caption    = " Texto de Responsabilidade do Cedente "
237:                 .Height     = 15
238:                 .Left       = 82

*-- Linhas 318 a 372:
318:                 ENDWITH
319:             ENDWITH
320: 
321:             BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(1), "Click", THIS, "CmdImprimirClick")
322:             BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(2), "Click", THIS, "CmdSaidaClick")
323:         CATCH TO loc_oErro
324:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
325:                     " PROC=" + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
326:         ENDTRY
327:     ENDPROC
328: 
329:     *--------------------------------------------------------------------------
330:     * AtualizaBoleto - Recarrega config de SigCnFBl e habilita/desabilita controles
331:     *--------------------------------------------------------------------------
332:     PROCEDURE AtualizaBoleto(par_cCond)
333:         LOCAL loc_cFPags, loc_cSQL, loc_nRet, loc_oErro, loc_lAchou
334:         loc_lAchou = .F.
335:         TRY
336:             loc_cFPags = PADR(NVL(par_cCond, ""), 12)
337:             THIS.this_cFPagsSel = ALLTRIM(loc_cFPags)
338: 
339:             IF USED("cursor_4c_Config")
340:                 TABLEREVERT(.T., "cursor_4c_Config")
341:                 USE IN cursor_4c_Config
342:             ENDIF
343:             IF USED("cursor_4c_ConfigTemp")
344:                 USE IN cursor_4c_ConfigTemp
345:             ENDIF
346: 
347:             SET NULL ON
348:             CREATE CURSOR cursor_4c_Config ( ;
349:                 FPags      C(12)  NULL, ;
350:                 cLocals    C(100) NULL, ;
351:                 cTxtCds    M      NULL, ;
352:                 cNomeImps  C(50)  NULL, ;
353:                 cFontePdrs C(20)  NULL, ;
354:                 nTamFontes N(3,0) NULL, ;
355:                 cTamFolha  C(30)  NULL, ;
356:                 cIdChaves  C(15)  NULL, ;
357:                 nLnLocals  N(6,2) NULL, ;
358:                 nClLocals  N(6,2) NULL, ;
359:                 nLnDtVencs N(6,2) NULL, ;
360:                 nClDtVencs N(6,2) NULL, ;
361:                 nLnDtDocs  N(6,2) NULL, ;
362:                 nClDtDocs  N(6,2) NULL, ;
363:                 nLnNrDocs  N(6,2) NULL, ;
364:                 nClNrDocs  N(6,2) NULL, ;
365:                 nLnVlDocs  N(6,2) NULL, ;
366:                 nClVlDocs  N(6,2) NULL, ;
367:                 nLnRazClis N(6,2) NULL, ;
368:                 nClRazClis N(6,2) NULL, ;
369:                 nLnCgcClis N(6,2) NULL, ;
370:                 nClCgcClis N(6,2) NULL, ;
371:                 nLnEndCobs N(6,2) NULL, ;
372:                 nClEndCobs N(6,2) NULL, ;

*-- Linhas 455 a 634:
455:     *--------------------------------------------------------------------------
456:     * TxtFPagsKeyPress - Handler do campo Condicao de Pagamento
457:     *--------------------------------------------------------------------------
458:     PROCEDURE TxtFPagsKeyPress
459:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
460: 
461:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
462:             RETURN
463:         ENDIF
464: 
465:         LOCAL loc_cVal, loc_cSQL, loc_nRet, loc_lProcessar, loc_oErro
466:         loc_lProcessar = .T.
467:         TRY
468:             loc_cVal = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
469: 
470:             IF EMPTY(loc_cVal)
471:                 THIS.AtualizaBoleto("")
472:                 loc_lProcessar = .F.
473:             ENDIF
474: 
475:             IF loc_lProcessar
476:                 *-- Busca exata primeiro
477:                 loc_cSQL = "SELECT TOP 1 FPags FROM SigCnFBl WHERE FPags = " + ;
478:                            EscaparSQL(PADR(loc_cVal, 12))
479:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPagsExato")
480: 
481:                 IF loc_nRet > 0 AND USED("cursor_4c_FPagsExato") AND RECCOUNT("cursor_4c_FPagsExato") > 0
482:                     SELECT cursor_4c_FPagsExato
483:                     THIS.txt_4c_FPags.Value = ALLTRIM(NVL(FPags, ""))
484:                     IF USED("cursor_4c_FPagsExato")
485:                         USE IN cursor_4c_FPagsExato
486:                     ENDIF
487:                     THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
488:                 ELSE
489:                     IF USED("cursor_4c_FPagsExato")
490:                         USE IN cursor_4c_FPagsExato
491:                     ENDIF
492:                     *-- Nao encontrado exato: abre lookup
493:                     THIS.AbrirLookupFPags()
494:                 ENDIF
495:             ENDIF
496:         CATCH TO loc_oErro
497:             MsgErro(loc_oErro.Message, "Erro ao validar Condi" + CHR(231) + CHR(227) + "o de Pagamento")
498:         ENDTRY
499:     ENDPROC
500: 
501:     *--------------------------------------------------------------------------
502:     * AbrirLookupFPags - Abre FormBuscaAuxiliar para SigCnFBl
503:     *--------------------------------------------------------------------------
504:     PROCEDURE AbrirLookupFPags()
505:         LOCAL loc_cVal, loc_oLookup, loc_oErro
506:         TRY
507:             loc_cVal = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
508: 
509:             IF USED("cursor_4c_BuscaFPags")
510:                 USE IN cursor_4c_BuscaFPags
511:             ENDIF
512: 
513:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
514:                 "SigCnFBl", ;
515:                 "cursor_4c_BuscaFPags", ;
516:                 "FPags", ;
517:                 loc_cVal, ;
518:                 "Sele" + CHR(231) + CHR(227) + "o")
519: 
520:             IF VARTYPE(loc_oLookup) = "O"
521:                 loc_oLookup.mAddColuna("FPags",   "XXXXXXXXXXXX", "Condi" + CHR(231) + CHR(227) + "o")
522:                 loc_oLookup.mAddColuna("cLocals", "",             "Local de Pagamento")
523:                 loc_oLookup.Show()
524: 
525:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
526:                     SELECT cursor_4c_BuscaFPags
527:                     THIS.txt_4c_FPags.Value = ALLTRIM(NVL(FPags, ""))
528:                     THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
529:                 ENDIF
530:                 loc_oLookup.Release()
531:             ENDIF
532: 
533:             IF USED("cursor_4c_BuscaFPags")
534:                 USE IN cursor_4c_BuscaFPags
535:             ENDIF
536:         CATCH TO loc_oErro
537:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de Condi" + CHR(231) + CHR(227) + "o")
538:         ENDTRY
539:     ENDPROC
540: 
541:     *--------------------------------------------------------------------------
542:     * CmdImprimirClick - Confirma e imprime boletos bancarios
543:     *--------------------------------------------------------------------------
544:     PROCEDURE CmdImprimirClick()
545:         LOCAL loc_lConfirmado, loc_lTemImpressora, loc_lSucesso
546:         LOCAL loc_cChave1, loc_nParcel, loc_nConta, loc_lTaOk
547:         LOCAL loc_cSQL, loc_nRet, loc_cFonteP, loc_cFonteG
548:         LOCAL loc_nTamFolha, loc_oErro, loc_laPrinters(1)
549: 
550:         IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s) Banc" + CHR(225) + "rio(s)?")
551:             THIS.txt_4c_Locals.SetFocus()
552:             RETURN
553:         ENDIF
554: 
555:         THIS.LockScreen = .T.
556:         TRY
557:             *-- Salva cLocals e cTxtCds editados de volta em SigCnFBl
558:             IF !USED("cursor_4c_Config") OR RECCOUNT("cursor_4c_Config") = 0
559:                 MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
560:                          CHR(225) + "lida antes de imprimir.", "Aviso")
561:                 THIS.LockScreen = .F.
562:                 RETURN
563:             ENDIF
564: 
565:             SELECT cursor_4c_Config
566:             REPLACE cLocals WITH THIS.txt_4c_Locals.Value
567:             REPLACE cTxtCds WITH THIS.obj_4c_GetTxtCds.Value
568: 
569:             loc_cSQL = "UPDATE SigCnFBl SET" + ;
570:                        " cLocals = " + EscaparSQL(THIS.txt_4c_Locals.Value) + "," + ;
571:                        " cTxtCds = " + EscaparSQL(THIS.obj_4c_GetTxtCds.Value) + ;
572:                        " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPagsSel, 12))
573:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
574:             IF loc_nRet <= 0
575:                 MsgAviso("Falha ao salvar. Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
576:                 THIS.LockScreen = .F.
577:                 RETURN
578:             ENDIF
579: 
580:             *-- Verifica se ha impressora de boleto configurada
581:             loc_lTemImpressora = .F.
582:             IF APRINTERS(loc_laPrinters) > 0
583:                 LOCAL loc_i
584:                 SELECT cursor_4c_Config
585:                 FOR loc_i = 1 TO ALEN(loc_laPrinters, 1)
586:                     IF UPPER(ALLTRIM(loc_laPrinters[loc_i, 1])) == UPPER(ALLTRIM(cursor_4c_Config.cNomeImps))
587:                         loc_lTemImpressora = .T.
588:                         EXIT
589:                     ENDIF
590:                 ENDFOR
591:             ENDIF
592: 
593:             IF !loc_lTemImpressora
594:                 MsgAviso("Nenhuma Impressora de Boleto Configurada ou Instalada.", "Aviso")
595:                 THIS.LockScreen = .F.
596:                 RETURN
597:             ENDIF
598: 
599:             *-- Carrega movimentos a imprimir
600:             IF !EMPTY(THIS.this_cChave1)
601:                 SELECT TprMvCab
602:                 ZAP
603:                 INSERT INTO TprMvCab (Emps, Dopes, Numes) VALUES ;
604:                     (SUBSTR(THIS.this_cChave1, 1, 3), ;
605:                      SUBSTR(THIS.this_cChave1, 4, 20), ;
606:                      INT(VAL(SUBSTR(THIS.this_cChave1, 24, 6))))
607:             ENDIF
608: 
609:             *-- Cria cursor de dados do boleto (uma linha por parcela impressa)
610:             IF USED("Crdados")
611:                 USE IN Crdados
612:             ENDIF
613:             SET NULL ON
614:             CREATE CURSOR Crdados ( ;
615:                 clocal  C(100), ;
616:                 vencs   C(12), ;
617:                 datdoc  D, ;
618:                 numdoc  C(8), ;
619:                 valor   N(14,2), ;
620:                 razaos  C(50), ;
621:                 cpfs    C(20), ;
622:                 endcobs C(80), ;
623:                 baicobs C(20), ;
624:                 cidcobs C(20), ;
625:                 estcobs C(2), ;
626:                 cepcobs C(9), ;
627:                 texto   M ;
628:             )
629:             SET NULL OFF
630: 
631:             *-- Monta fontes de impressao a partir da configuracao
632:             SELECT cursor_4c_Config
633:             IF EMPTY(ALLTRIM(NVL(cursor_4c_Config.cFontePdrs, "")))
634:                 loc_cFonteP = ""

*-- Linhas 664 a 737:
664:                            EscaparSQL(loc_cChave1)
665:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
666:                 IF loc_nRet <= 0 OR !USED("cursor_4c_MvCab") OR RECCOUNT("cursor_4c_MvCab") = 0
667:                     MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
668:                              "o Encontrou Movimenta" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
669:                     IF USED("cursor_4c_MvCab")
670:                         USE IN cursor_4c_MvCab
671:                     ENDIF
672:                     LOOP
673:                 ENDIF
674: 
675:                 *-- Busca parcelas do movimento
676:                 loc_cSQL = "SELECT Emps, Dopes, Numes, Parcs, Fpags, Vencs, Datas, Valos" + ;
677:                            " FROM SigMvPar WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
678:                            EscaparSQL(loc_cChave1) + " ORDER BY Parcs"
679:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPar")
680:                 IF loc_nRet <= 0 OR !USED("cursor_4c_MvPar") OR RECCOUNT("cursor_4c_MvPar") = 0
681:                     MsgAviso("Nenhuma Forma de Pagamento Encontrada Nessa Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
682:                     IF USED("cursor_4c_MvPar")
683:                         USE IN cursor_4c_MvPar
684:                     ENDIF
685:                     IF USED("cursor_4c_MvCab")
686:                         USE IN cursor_4c_MvCab
687:                     ENDIF
688:                     LOOP
689:                 ENDIF
690: 
691:                 *-- Busca nota fiscal do movimento
692:                 loc_cSQL = "SELECT TOP 1 NFis, Emps, Dopes, Numes" + ;
693:                            " FROM SigMvNfi WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
694:                            EscaparSQL(loc_cChave1)
695:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvNfi")
696:                 IF loc_nRet <= 0 OR !USED("cursor_4c_MvNfi") OR RECCOUNT("cursor_4c_MvNfi") = 0
697:                     MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
698:                              "o possui Nota Fiscal Cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
699:                     IF USED("cursor_4c_MvNfi")
700:                         USE IN cursor_4c_MvNfi
701:                     ENDIF
702:                     IF USED("cursor_4c_MvPar")
703:                         USE IN cursor_4c_MvPar
704:                     ENDIF
705:                     IF USED("cursor_4c_MvCab")
706:                         USE IN cursor_4c_MvCab
707:                     ENDIF
708:                     LOOP
709:                 ENDIF
710: 
711:                 *-- Busca dados do cliente (conta de origem ou destino conforme tipo NF)
712:                 SELECT cursor_4c_MvCab
713:                 LOCAL loc_cContaCli
714:                 loc_cContaCli = IIF(NVL(cursor_4c_MvCab.Nfiscals, 0) = 1, ;
715:                                     cursor_4c_MvCab.Contaos, cursor_4c_MvCab.Contads)
716:                 loc_cSQL = "SELECT TOP 1 Iclis, Razaos, Cpfs," + ;
717:                            " Endes, EndCobs, Bairs, BaiCobs, Cidas, CidCobs," + ;
718:                            " Estas, EstCobs, Ceps, CepCobs" + ;
719:                            " FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaCli)
720:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
721:                 IF loc_nRet <= 0 OR !USED("cursor_4c_Cli") OR RECCOUNT("cursor_4c_Cli") = 0
722:                     IF USED("cursor_4c_Cli")
723:                         USE IN cursor_4c_Cli
724:                     ENDIF
725:                     IF USED("cursor_4c_MvNfi")
726:                         USE IN cursor_4c_MvNfi
727:                     ENDIF
728:                     IF USED("cursor_4c_MvPar")
729:                         USE IN cursor_4c_MvPar
730:                     ENDIF
731:                     IF USED("cursor_4c_MvCab")
732:                         USE IN cursor_4c_MvCab
733:                     ENDIF
734:                     LOOP
735:                 ENDIF
736: 
737:                 *-- Itera parcelas e insere dados para impressao

*-- Linhas 876 a 1273:
876:     *--------------------------------------------------------------------------
877:     * CmdSaidaClick - Confirma saida e fecha o formulario
878:     *--------------------------------------------------------------------------
879:     PROCEDURE CmdSaidaClick()
880:         LOCAL loc_lPodeFechar, loc_oErro
881:         TRY
882:             IF !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
883:                 loc_lPodeFechar = .T.
884:             ELSE
885:                 loc_lPodeFechar = MsgConfirma("Deseja Abandonar as Impress" + CHR(245) + "es do Boleto?")
886:             ENDIF
887: 
888:             IF loc_lPodeFechar
889:                 IF VARTYPE(THIS.this_xNform1) = "O" AND !ISNULL(THIS.this_xNform1)
890:                     THIS.this_xNform1.Enabled = .T.
891:                 ENDIF
892:                 THIS.Release()
893:             ENDIF
894:         CATCH TO loc_oErro
895:             MsgErro(loc_oErro.Message, "Erro ao sair")
896:         ENDTRY
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * GrDetalhe - Insere linha de dados no cursor TmpImprime para impressao matricial
901:     *--------------------------------------------------------------------------
902:     PROCEDURE GrDetalhe(par_nLinha, par_nColuna, par_cDetalhe, par_cEstilo, par_nLineSize, par_nHeight)
903:         LOCAL loc_nLinha, loc_nColuna, loc_cDetalhe, loc_cEstilo, loc_oErro
904:         TRY
905:             loc_nLinha   = IIF(VARTYPE(par_nLinha)   = "N", par_nLinha,   0)
906:             loc_nColuna  = IIF(VARTYPE(par_nColuna)  = "N", par_nColuna,  0)
907:             loc_cDetalhe = IIF(VARTYPE(par_cDetalhe) = "C", par_cDetalhe, "")
908:             loc_cEstilo  = IIF(VARTYPE(par_cEstilo)  = "C", par_cEstilo,  "X")
909:             IF EMPTY(loc_cEstilo)
910:                 loc_cEstilo = "X"
911:             ENDIF
912: 
913:             IF !(loc_cEstilo == "*") AND (loc_nColuna != 0 OR loc_nLinha != 0)
914:                 IF USED("TmpImprime")
915:                     INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
916:                         VALUES (loc_nLinha, loc_nColuna, loc_cDetalhe, ;
917:                                 ALLTRIM(loc_cEstilo), par_nLineSize, par_nHeight)
918:                 ENDIF
919:             ENDIF
920:         CATCH TO loc_oErro
921:             MsgErro(loc_oErro.Message, "Erro em GrDetalhe")
922:         ENDTRY
923:     ENDPROC
924: 
925:     *--------------------------------------------------------------------------
926:     * BtnIncluirClick - Ponto de entrada canonico do pipeline
927:     * Form OPERACIONAL de impressao de boleto: a acao "Incluir/Confirmar" eh a
928:     * propria impressao dos boletos bancarios. Delega para CmdImprimirClick, que
929:     * confirma, salva a config editada em SigCnFBl e envia os movimentos para
930:     * impressora matricial via SigPrIbl.
931:     *--------------------------------------------------------------------------
932:     PROCEDURE BtnIncluirClick()
933:         LOCAL loc_oErro
934:         TRY
935:             IF !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
936:                 MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
937:                          CHR(225) + "lida antes de imprimir.", "Aviso")
938:                 IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
939:                     THIS.txt_4c_FPags.SetFocus()
940:                 ENDIF
941:                 RETURN
942:             ENDIF
943:             THIS.CmdImprimirClick()
944:         CATCH TO loc_oErro
945:             MsgErro(loc_oErro.Message, "Erro em Incluir")
946:         ENDTRY
947:     ENDPROC
948: 
949:     *--------------------------------------------------------------------------
950:     * BtnAlterarClick - Ponto de entrada canonico do pipeline
951:     * Form OPERACIONAL: "Alterar" corresponde a recarregar a config do boleto
952:     * atualmente selecionado (SigCnFBl) e permitir edicao de Local de Pagamento
953:     * e Texto do Cedente. Se nenhum FPags esta selecionado, avisa o usuario.
954:     *--------------------------------------------------------------------------
955:     PROCEDURE BtnAlterarClick()
956:         LOCAL loc_oErro
957:         TRY
958:             IF EMPTY(THIS.this_cFPagsSel)
959:                 MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de alterar.", "Aviso")
960:                 IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
961:                     THIS.txt_4c_FPags.SetFocus()
962:                 ENDIF
963:                 RETURN
964:             ENDIF
965:             THIS.AtualizaBoleto(THIS.this_cFPagsSel)
966:             IF PEMSTATUS(THIS, "txt_4c_Locals", 5) AND THIS.txt_4c_Locals.Enabled
967:                 THIS.txt_4c_Locals.SetFocus()
968:             ENDIF
969:         CATCH TO loc_oErro
970:             MsgErro(loc_oErro.Message, "Erro em Alterar")
971:         ENDTRY
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * BtnVisualizarClick - Ponto de entrada canonico do pipeline
976:     * Form OPERACIONAL: "Visualizar" abre o picker (FormBuscaAuxiliar) de
977:     * condicoes de pagamento cadastradas em SigCnFBl, permitindo o usuario
978:     * escolher qual boleto configurar.
979:     *--------------------------------------------------------------------------
980:     PROCEDURE BtnVisualizarClick()
981:         LOCAL loc_oErro
982:         TRY
983:             THIS.AbrirLookupFPags()
984:         CATCH TO loc_oErro
985:             MsgErro(loc_oErro.Message, "Erro em Visualizar")
986:         ENDTRY
987:     ENDPROC
988: 
989:     *--------------------------------------------------------------------------
990:     * BtnExcluirClick - Ponto de entrada canonico do pipeline
991:     * Form OPERACIONAL: "Excluir" limpa a selecao corrente (equivalente a
992:     * cancelar a configuracao ativa), desabilitando os campos e o botao
993:     * Imprimir. Nao afeta dados persistidos em SigCnFBl.
994:     *--------------------------------------------------------------------------
995:     PROCEDURE BtnExcluirClick()
996:         LOCAL loc_oErro
997:         TRY
998:             IF EMPTY(THIS.this_cFPagsSel)
999:                 RETURN
1000:             ENDIF
1001:             IF !MsgConfirma("Deseja limpar a Condi" + CHR(231) + CHR(227) + "o de Pagamento selecionada?")
1002:                 RETURN
1003:             ENDIF
1004:             IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
1005:                 THIS.txt_4c_FPags.Value = ""
1006:             ENDIF
1007:             IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
1008:                 THIS.txt_4c_Locals.Value = ""
1009:             ENDIF
1010:             IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
1011:                 THIS.obj_4c_GetTxtCds.Value = ""
1012:             ENDIF
1013:             THIS.AtualizaBoleto("")
1014:             IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
1015:                 THIS.txt_4c_FPags.SetFocus()
1016:             ENDIF
1017:         CATCH TO loc_oErro
1018:             MsgErro(loc_oErro.Message, "Erro em Excluir")
1019:         ENDTRY
1020:     ENDPROC
1021: 
1022:     *--------------------------------------------------------------------------
1023:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
1024:     *--------------------------------------------------------------------------
1025:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1026:         LOCAL loc_i, loc_oControl, loc_oRef
1027:         IF VARTYPE(par_oContainer) = "O"
1028:             loc_oRef = par_oContainer
1029:         ELSE
1030:             loc_oRef = THIS
1031:         ENDIF
1032:         FOR loc_i = 1 TO loc_oRef.ControlCount
1033:             loc_oControl = loc_oRef.Controls(loc_i)
1034:             IF VARTYPE(loc_oControl) = "O"
1035:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
1036:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1037:                         THIS.TornarControlesVisiveis(loc_oControl)
1038:                     ENDIF
1039:                     LOOP
1040:                 ENDIF
1041:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1042:                     loc_oControl.Visible = .T.
1043:                 ENDIF
1044:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1045:                     THIS.TornarControlesVisiveis(loc_oControl)
1046:                 ENDIF
1047:             ENDIF
1048:         ENDFOR
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * BtnBuscarClick - Abre lookup de condicoes de pagamento (SigCnFBl)
1053:     *--------------------------------------------------------------------------
1054:     PROCEDURE BtnBuscarClick()
1055:         LOCAL loc_oErro
1056:         TRY
1057:             THIS.AbrirLookupFPags()
1058:         CATCH TO loc_oErro
1059:             MsgErro(loc_oErro.Message, "Erro em Buscar")
1060:         ENDTRY
1061:     ENDPROC
1062: 
1063:     *--------------------------------------------------------------------------
1064:     * BtnEncerrarClick - Fecha o formulario (confirma se impressao habilitada)
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE BtnEncerrarClick()
1067:         LOCAL loc_oErro
1068:         TRY
1069:             THIS.CmdSaidaClick()
1070:         CATCH TO loc_oErro
1071:             MsgErro(loc_oErro.Message, "Erro ao encerrar")
1072:         ENDTRY
1073:     ENDPROC
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * BtnSalvarClick - Salva alteracoes de Local e Texto Cedente em SigCnFBl
1077:     *--------------------------------------------------------------------------
1078:     PROCEDURE BtnSalvarClick()
1079:         LOCAL loc_cSQL, loc_nRet, loc_oErro
1080:         TRY
1081:             IF !USED("cursor_4c_Config") OR RECCOUNT("cursor_4c_Config") = 0
1082:                 MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de salvar.", "Aviso")
1083:                 IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
1084:                     THIS.txt_4c_FPags.SetFocus()
1085:                 ENDIF
1086:                 RETURN
1087:             ENDIF
1088: 
1089:             loc_cSQL = "UPDATE SigCnFBl SET" + ;
1090:                        " cLocals = " + EscaparSQL(THIS.txt_4c_Locals.Value) + "," + ;
1091:                        " cTxtCds = " + EscaparSQL(THIS.obj_4c_GetTxtCds.Value) + ;
1092:                        " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPagsSel, 12))
1093:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
1094:             IF loc_nRet > 0
1095:                 MsgInfo("Dados salvos com sucesso.", "Salvo")
1096:             ELSE
1097:                 MsgAviso("Falha ao salvar. Verifique a conex" + CHR(227) + "o.", "Aviso")
1098:             ENDIF
1099:         CATCH TO loc_oErro
1100:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ao Salvar")
1101:         ENDTRY
1102:     ENDPROC
1103: 
1104:     *--------------------------------------------------------------------------
1105:     * BtnCancelarClick - Cancela edicao corrente, restaura valores do banco
1106:     *--------------------------------------------------------------------------
1107:     PROCEDURE BtnCancelarClick()
1108:         LOCAL loc_oErro
1109:         TRY
1110:             IF EMPTY(THIS.this_cFPagsSel)
1111:                 THIS.LimparCampos()
1112:             ELSE
1113:                 THIS.AtualizaBoleto(THIS.this_cFPagsSel)
1114:             ENDIF
1115:         CATCH TO loc_oErro
1116:             MsgErro(loc_oErro.Message, "Erro ao Cancelar")
1117:         ENDTRY
1118:     ENDPROC
1119: 
1120:     *--------------------------------------------------------------------------
1121:     * CarregarLista - Recarrega configuracao do boleto bancario atual
1122:     *--------------------------------------------------------------------------
1123:     PROCEDURE CarregarLista()
1124:         LOCAL loc_lSucesso, loc_oErro
1125:         loc_lSucesso = .F.
1126:         TRY
1127:             THIS.AtualizaBoleto(THIS.this_cFPagsSel)
1128:             loc_lSucesso = .T.
1129:         CATCH TO loc_oErro
1130:             MsgErro(loc_oErro.Message, "Erro ao Carregar")
1131:         ENDTRY
1132:         RETURN loc_lSucesso
1133:     ENDPROC
1134: 
1135:     *--------------------------------------------------------------------------
1136:     * FormParaBO - Extrai valores do formulario para propriedades internas
1137:     * (Form OPERACIONAL: nao usa BO CRUD; armazena em variaveis de estado)
1138:     *--------------------------------------------------------------------------
1139:     PROTECTED PROCEDURE FormParaBO()
1140:         LOCAL loc_oErro
1141:         TRY
1142:             THIS.this_cFPagsSel = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
1143:         CATCH TO loc_oErro
1144:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1145:         ENDTRY
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     * BOParaForm - Popula campos do formulario a partir do cursor de config
1150:     *--------------------------------------------------------------------------
1151:     PROTECTED PROCEDURE BOParaForm()
1152:         LOCAL loc_oErro
1153:         TRY
1154:             IF USED("cursor_4c_Config") AND RECCOUNT("cursor_4c_Config") > 0
1155:                 SELECT cursor_4c_Config
1156:                 GO TOP
1157:                 IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
1158:                     THIS.txt_4c_FPags.Value = ALLTRIM(NVL(cursor_4c_Config.FPags, ""))
1159:                 ENDIF
1160:                 IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
1161:                     THIS.txt_4c_Locals.Value = NVL(cursor_4c_Config.cLocals, "")
1162:                 ENDIF
1163:                 IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
1164:                     THIS.obj_4c_GetTxtCds.Value = NVL(cursor_4c_Config.cTxtCds, "")
1165:                 ENDIF
1166:             ENDIF
1167:         CATCH TO loc_oErro
1168:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1169:         ENDTRY
1170:     ENDPROC
1171: 
1172:     *--------------------------------------------------------------------------
1173:     * HabilitarCampos - Habilita ou desabilita campos conforme estado atual
1174:     *--------------------------------------------------------------------------
1175:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1176:         LOCAL loc_lHabilitar, loc_oErro
1177:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1178:         TRY
1179:             IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
1180:                 THIS.txt_4c_Locals.Enabled = loc_lHabilitar
1181:             ENDIF
1182:             IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
1183:                 THIS.obj_4c_GetTxtCds.Enabled = loc_lHabilitar
1184:             ENDIF
1185:             IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
1186:                 THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = loc_lHabilitar
1187:                 IF !loc_lHabilitar
1188:                     THIS.obj_4c_CmdGImprimir.Value = 2
1189:                 ENDIF
1190:                 THIS.obj_4c_CmdGImprimir.Refresh()
1191:             ENDIF
1192:         CATCH TO loc_oErro
1193:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
1194:         ENDTRY
1195:     ENDPROC
1196: 
1197:     *--------------------------------------------------------------------------
1198:     * LimparCampos - Limpa todos os campos do formulario
1199:     *--------------------------------------------------------------------------
1200:     PROTECTED PROCEDURE LimparCampos()
1201:         LOCAL loc_oErro
1202:         TRY
1203:             THIS.this_cFPagsSel = ""
1204:             IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
1205:                 THIS.txt_4c_FPags.Value = ""
1206:             ENDIF
1207:             IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
1208:                 THIS.txt_4c_Locals.Value   = ""
1209:                 THIS.txt_4c_Locals.Enabled = .F.
1210:             ENDIF
1211:             IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
1212:                 THIS.obj_4c_GetTxtCds.Value   = ""
1213:                 THIS.obj_4c_GetTxtCds.Enabled = .F.
1214:             ENDIF
1215:             IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
1216:                 THIS.lbl_4c_LblAviso.Visible = .T.
1217:             ENDIF
1218:             IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
1219:                 THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
1220:                 THIS.obj_4c_CmdGImprimir.Value = 2
1221:                 THIS.obj_4c_CmdGImprimir.Refresh()
1222:             ENDIF
1223:         CATCH TO loc_oErro
1224:             MsgErro(loc_oErro.Message, "Erro em LimparCampos")
1225:         ENDTRY
1226:     ENDPROC
1227: 
1228:     *--------------------------------------------------------------------------
1229:     * AjustarBotoesPorModo - Ajusta estado do botao Imprimir conforme config
1230:     * Form OPERACIONAL: o "modo" eh determinado por loc_lAchou em AtualizaBoleto
1231:     *--------------------------------------------------------------------------
1232:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1233:         LOCAL loc_lTemConfig, loc_oErro
1234:         TRY
1235:             loc_lTemConfig = USED("cursor_4c_Config") AND RECCOUNT("cursor_4c_Config") > 0
1236:             THIS.HabilitarCampos(loc_lTemConfig)
1237:             IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
1238:                 THIS.lbl_4c_LblAviso.Visible = !loc_lTemConfig
1239:             ENDIF
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
1242:         ENDTRY
1243:     ENDPROC
1244: 
1245:     *--------------------------------------------------------------------------
1246:     * Destroy - Libera recursos ao fechar o formulario
1247:     *--------------------------------------------------------------------------
1248:     PROCEDURE Destroy()
1249:         IF VARTYPE(THIS.this_xNform1) = "O" AND !ISNULL(THIS.this_xNform1)
1250:             THIS.this_xNform1.Enabled = .T.
1251:         ENDIF
1252: 
1253:         IF USED("cursor_4c_Config")
1254:             TABLEREVERT(.T., "cursor_4c_Config")
1255:             USE IN cursor_4c_Config
1256:         ENDIF
1257:         IF USED("cursor_4c_ConfigTemp")
1258:             USE IN cursor_4c_ConfigTemp
1259:         ENDIF
1260:         IF USED("cursor_4c_BuscaFPags")
1261:             USE IN cursor_4c_BuscaFPags
1262:         ENDIF
1263:         IF USED("Crdados")
1264:             USE IN Crdados
1265:         ENDIF
1266:         IF USED("TmpImprime")
1267:             USE IN TmpImprime
1268:         ENDIF
1269: 
1270:         DODEFAULT()
1271:     ENDPROC
1272: 
1273: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIBLBO.prg):
*------------------------------------------------------------------------------
* SIGPRIBLBO.prg - Business Object para Impressao de Boleto Bancario
* Herda de: BusinessBase
* Tabela principal: SigCnFBl (configuracao de boleto)
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Identificacao da tabela e chave
    this_cTabela      = "SigCnFBl"
    this_cCampoChave  = "FPags"

    *-- Chave do movimento recebida do form pai (pcchave1)
    this_cChave1      = ""

    *-- Campos da configuracao de boleto (SigCnFBl)
    this_cFPags       = ""
    this_cIdChaves    = ""
    this_cLocals      = ""
    this_cTxtCds      = ""
    this_cNomeImps    = ""
    this_cFontePdrs   = ""
    this_nTamFontes   = 0
    this_cTamFolha    = ""

    *-- Posicoes de impressao: Local de Pagamento
    this_nLnLocals    = 0
    this_nClLocals    = 0

    *-- Posicoes de impressao: Data de Vencimento
    this_nLnDtVencs   = 0
    this_nClDtVencs   = 0

    *-- Posicoes de impressao: Data do Documento
    this_nLnDtDocs    = 0
    this_nClDtDocs    = 0

    *-- Posicoes de impressao: Numero do Documento
    this_nLnNrDocs    = 0
    this_nClNrDocs    = 0

    *-- Posicoes de impressao: Valor do Documento
    this_nLnVlDocs    = 0
    this_nClVlDocs    = 0

    *-- Posicoes de impressao: Razao Social do Cliente
    this_nLnRazClis   = 0
    this_nClRazClis   = 0

    *-- Posicoes de impressao: CPF/CNPJ do Cliente
    this_nLnCgcClis   = 0
    this_nClCgcClis   = 0

    *-- Posicoes de impressao: Endereco de Cobranca
    this_nLnEndCobs   = 0
    this_nClEndCobs   = 0

    *-- Posicoes de impressao: Bairro de Cobranca
    this_nLnBaiCobs   = 0
    this_nClBaiCobs   = 0

    *-- Posicoes de impressao: Cidade de Cobranca
    this_nLnCidCobs   = 0
    this_nClCidCobs   = 0

    *-- Posicoes de impressao: Estado de Cobranca
    this_nLnEstCobs   = 0
    this_nClEstCobs   = 0

    *-- Posicoes de impressao: CEP de Cobranca
    this_nLnCepCobs   = 0
    this_nClCepCobs   = 0

    *-- Posicoes de impressao: Texto do Cedente
    this_nLnTxtCds    = 0
    this_nClTxtCds    = 0

    *-- Fatores de escala para impressao matricial
    this_nNffatorln   = 0
    this_nNffatorcl   = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCnFBl"
        THIS.this_cCampoChave = "FPags"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPags)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarConfiguracao - Carrega configuracao de boleto para FPags informado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfiguracao(par_cFPags)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Config")
                USE IN cursor_4c_Config
            ENDIF
            loc_cSQL = "SELECT FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       " FROM SigCnFBl" + ;
                       " WHERE FPags = " + EscaparSQL(PADR(par_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Config")
            IF loc_nRet > 0
                IF RECCOUNT("cursor_4c_Config") > 0
                    SELECT cursor_4c_Config
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Config")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves,  "C")
                THIS.this_cLocals    = TratarNulo(cLocals,    "C")
                THIS.this_cTxtCds    = TratarNulo(cTxtCds,    "C")
                THIS.this_cNomeImps  = TratarNulo(cNomeImps,  "C")
                THIS.this_cFontePdrs = TratarNulo(cFontePdrs, "C")
                THIS.this_nTamFontes = TratarNulo(nTamFontes, "N")
                THIS.this_cTamFolha  = TratarNulo(cTamFolha,  "C")
                THIS.this_nLnLocals  = TratarNulo(nLnLocals,  "N")
                THIS.this_nClLocals  = TratarNulo(nClLocals,  "N")
                THIS.this_nLnDtVencs = TratarNulo(nLnDtVencs, "N")
                THIS.this_nClDtVencs = TratarNulo(nClDtVencs, "N")
                THIS.this_nLnDtDocs  = TratarNulo(nLnDtDocs,  "N")
                THIS.this_nClDtDocs  = TratarNulo(nClDtDocs,  "N")
                THIS.this_nLnNrDocs  = TratarNulo(nLnNrDocs,  "N")
                THIS.this_nClNrDocs  = TratarNulo(nClNrDocs,  "N")
                THIS.this_nLnVlDocs  = TratarNulo(nLnVlDocs,  "N")
                THIS.this_nClVlDocs  = TratarNulo(nClVlDocs,  "N")
                THIS.this_nLnRazClis = TratarNulo(nLnRazClis, "N")
                THIS.this_nClRazClis = TratarNulo(nClRazClis, "N")
                THIS.this_nLnCgcClis = TratarNulo(nLnCgcClis, "N")
                THIS.this_nClCgcClis = TratarNulo(nClCgcClis, "N")
                THIS.this_nLnEndCobs = TratarNulo(nLnEndCobs, "N")
                THIS.this_nClEndCobs = TratarNulo(nClEndCobs, "N")
                THIS.this_nLnBaiCobs = TratarNulo(nLnBaiCobs, "N")
                THIS.this_nClBaiCobs = TratarNulo(nClBaiCobs, "N")
                THIS.this_nLnCidCobs = TratarNulo(nLnCidCobs, "N")
                THIS.this_nClCidCobs = TratarNulo(nClCidCobs, "N")
                THIS.this_nLnEstCobs = TratarNulo(nLnEstCobs, "N")
                THIS.this_nClEstCobs = TratarNulo(nClEstCobs, "N")
                THIS.this_nLnCepCobs = TratarNulo(nLnCepCobs, "N")
                THIS.this_nClCepCobs = TratarNulo(nClCepCobs, "N")
                THIS.this_nLnTxtCds  = TratarNulo(nLnTxtCds,  "N")
                THIS.this_nClTxtCds  = TratarNulo(nClTxtCds,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cFPags))
            THIS.this_cMensagemErro = "Condi" + CHR(231) + CHR(227) + "o de Pagamento obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova configuracao de boleto em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                RETURN
            ENDIF
            loc_cSQL = "INSERT INTO SigCnFBl (" + ;
                       " FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       ") VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12)) + ", " + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cTxtCds) + ", " + ;
                       EscaparSQL(THIS.this_cNomeImps) + ", " + ;
                       EscaparSQL(THIS.this_cFontePdrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTamFolha) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + ;
                       ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Salva campos editaveis (cLocals, cTxtCds) em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " cLocals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " cTxtCds = " + EscaparSQL(THIS.this_cTxtCds) + ;
                       " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui configuracao de boleto de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "DELETE FROM SigCnFBl WHERE FPags = " + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

