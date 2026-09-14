# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'OptTipo' (parent: SIGREAIV): Top original=162 vs migrado 'obj_4c_OptTipo' Top=0 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptTipo' (parent: SIGREAIV): Left original=167 vs migrado 'obj_4c_OptTipo' Left=0 (diff=167px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReAiv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1095 linhas total):

*-- Linhas 6 a 15:
6: *
7: * Filtros:
8: *   - Empresa     : C[o]digo (txt_4c_Empresa) + Descri[c][a]o (txt_4c_Dempresa)
9: *   - 1[o] Invent[a]rio : C[o]digo num[e]rico (txt_4c_Inv1) + Descri[c][a]o (lbl_4c_Label2)
10: *   - 2[o] Invent[a]rio : C[o]digo num[e]rico (txt_4c_Inv2) + Descri[c][a]o (lbl_4c_Label5)
11: *   - Tipo        : 1=Anal[i]tico / 2=Sint[e]tico (obj_4c_OptTipo)
12: *
13: * fAcessoEmpresa (legado) -> substituido por ValidarEmpresa/AbrirBuscaEmpresa via SQL
14: * fwBuscaExt(SigCdBal)   -> substituido por FormBuscaAuxiliar
15: *==============================================================================

*-- Linhas 50 a 58:
50:         loc_lSucesso   = .F.
51:         loc_lContinuar = .T.
52:         TRY
53:             THIS.Caption = "An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios"
54: 
55:             IF TYPE("gc_4c_CaminhoIcones") = "U"
56:                 gc_4c_CaminhoIcones = ""
57:             ENDIF
58:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 80 a 89:
80:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
81: 
82:                 THIS.LimparCampos()
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85:                 loc_lSucesso = .T.
86:             ENDIF
87:         CATCH TO loc_oErro
88:             THIS.this_cMensagemErro = loc_oErro.Message
89:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 100 a 138:
100:     PROTECTED PROCEDURE ConfigurarCabecalho()
101:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
102:         WITH THIS.cnt_4c_Cabecalho
103:             .Top         = 0
104:             .Left        = 0
105:             .Width       = THIS.Width
106:             .Height      = 80
107:             .BackStyle   = 1
108:             .BackColor   = RGB(100, 100, 100)
109:             .BorderWidth = 0
110:             .Visible     = .T.
111: 
112:             .AddObject("lbl_4c_Sombra", "Label")
113:             WITH .lbl_4c_Sombra
114:                 .Top       = 22
115:                 .Left      = 22
116:                 .Width     = THIS.Width
117:                 .Height    = 30
118:                 .Caption   = "An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios"
119:                 .FontName  = "Tahoma"
120:                 .FontSize  = 14
121:                 .FontBold  = .T.
122:                 .ForeColor = RGB(0, 0, 0)
123:                 .BackStyle = 0
124:                 .Visible   = .T.
125:             ENDWITH
126: 
127:             .AddObject("lbl_4c_Titulo", "Label")
128:             WITH .lbl_4c_Titulo
129:                 .Top       = 20
130:                 .Left      = 20
131:                 .Width     = THIS.Width
132:                 .Height    = 30
133:                 .Caption   = "An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios"
134:                 .FontName  = "Tahoma"
135:                 .FontSize  = 14
136:                 .FontBold  = .T.
137:                 .ForeColor = RGB(255, 255, 255)
138:                 .BackStyle = 0

*-- Linhas 151 a 176:
151:     PROTECTED PROCEDURE ConfigurarBotoes()
152:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
153:         WITH THIS.cmg_4c_Botoes
154:             .Top           = 0
155:             .Left          = 529
156:             .Width         = 273
157:             .Height        = 80
158:             .ButtonCount   = 4
159:             .BackStyle     = 0
160:             .BorderStyle   = 0
161:             .BorderColor   = RGB(136, 189, 188)
162:             .SpecialEffect = 1
163:             .Themes        = .F.
164:             .Visible       = .T.
165: 
166:             WITH .Buttons(1)
167:                 .Top             = 5
168:                 .Left            = 5
169:                 .Width           = 65
170:                 .Height          = 70
171:                 .Caption         = "Visualizar"
172:                 .FontBold        = .T.
173:                 .FontItalic      = .T.
174:                 .BackColor       = RGB(255, 255, 255)
175:                 .ForeColor       = RGB(90, 90, 90)
176:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 183 a 195:
183:             ENDWITH
184: 
185:             WITH .Buttons(2)
186:                 .Top             = 5
187:                 .Left            = 71
188:                 .Width           = 65
189:                 .Height          = 70
190:                 .Caption         = "Imprimir"
191:                 .FontName        = "Tahoma"
192:                 .FontBold        = .T.
193:                 .FontItalic      = .T.
194:                 .FontSize        = 8
195:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 204 a 216:
204:             ENDWITH
205: 
206:             WITH .Buttons(3)
207:                 .Top             = 5
208:                 .Left            = 137
209:                 .Width           = 65
210:                 .Height          = 70
211:                 .Caption         = "Excel"
212:                 .FontName        = "Tahoma"
213:                 .FontBold        = .T.
214:                 .FontItalic      = .T.
215:                 .FontSize        = 8
216:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 225 a 237:
225:             ENDWITH
226: 
227:             WITH .Buttons(4)
228:                 .Top             = 5
229:                 .Left            = 203
230:                 .Width           = 65
231:                 .Height          = 70
232:                 .Caption         = "Encerrar"
233:                 .Cancel          = .T.
234:                 .FontName        = "Tahoma"
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .FontSize        = 8

*-- Linhas 261 a 275:
261: 
262:         loc_oPgf.PageCount = 1
263: 
264:         loc_oPgf.Top    = 85
265:         loc_oPgf.Left   = -1
266:         loc_oPgf.Width  = THIS.Width + 2
267:         loc_oPgf.Height = THIS.Height - 85
268:         loc_oPgf.Tabs   = .F.
269: 
270:         loc_oPgf.Page1.Caption   = "Filtros"
271:         loc_oPgf.Page1.FontName  = "Tahoma"
272:         loc_oPgf.Page1.FontSize  = 8
273:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
274:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
275:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 285 a 322:
285:     * Os filtros s[a]o separados em dois m[e]todos para manter o contrato
286:     * esperado pelo pipeline (ConfigurarPaginaLista + ConfigurarPaginaDados).
287:     *
288:     * Posi[c][o]es relativas ao PageFrame.Top=85:
289:     *   Get_Empresa (Top=87)  -> Page1.Top = 87-85 = 2
290:     *   Say3        (Top=90)  -> Page1.Top = 90-85 = 5
291:     *   Get_Inv1    (Top=112) -> Page1.Top = 112-85 = 27
292:     *   Say1        (Top=115) -> Page1.Top = 115-85 = 30
293:     *   Say2        (Top=115) -> Page1.Top = 30 (label descri[c][a]o Inv1)
294:     *--------------------------------------------------------------------------
295:     PROTECTED PROCEDURE ConfigurarPaginaLista()
296:         LOCAL loc_oPg
297:         loc_oPg = THIS.pgf_4c_Paginas.Page1
298: 
299:         *-- Label "Empresa :" (Say3: Left=110)
300:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
301:         WITH loc_oPg.lbl_4c_Label3
302:             .Top       = 5
303:             .Left      = 110
304:             .AutoSize  = .T.
305:             .Caption   = "Empresa :"
306:             .FontName  = "Tahoma"
307:             .FontSize  = 8
308:             .ForeColor = RGB(90, 90, 90)
309:             .BackStyle = 0
310:             .Visible   = .T.
311:         ENDWITH
312: 
313:         *-- C[o]digo da empresa (Get_Empresa: Top=87, Left=167, Width=33)
314:         loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
315:         WITH loc_oPg.txt_4c_Empresa
316:             .Top         = 2
317:             .Left        = 167
318:             .Width       = 33
319:             .Height      = 23
320:             .MaxLength   = 2
321:             .Value       = ""
322:             .FontName    = "Tahoma"

*-- Linhas 331 a 340:
331:         *   When original: Return(Empty(Get_Empresa.Value)) -> ReadOnly quando empresa vazia
332:         loc_oPg.AddObject("txt_4c_Dempresa", "TextBox")
333:         WITH loc_oPg.txt_4c_Dempresa
334:             .Top         = 2
335:             .Left        = 201
336:             .Width       = 205
337:             .Height      = 23
338:             .MaxLength   = 30
339:             .Value       = ""
340:             .FontName    = "Tahoma"

*-- Linhas 347 a 372:
347:         ENDWITH
348: 
349:         *-- Label "1[o] Invent[a]rio :" (Say1: Left=87)
350:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
351:         WITH loc_oPg.lbl_4c_Label1
352:             .Top       = 30
353:             .Left      = 87
354:             .AutoSize  = .T.
355:             .Caption   = "1" + CHR(186) + " Invent" + CHR(225) + "rio :"
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .ForeColor = RGB(90, 90, 90)
359:             .BackStyle = 0
360:             .Visible   = .T.
361:         ENDWITH
362: 
363:         *-- C[o]digo do 1[o] Invent[a]rio (Get_Inv1: Top=112, Left=167, Width=87)
364:         loc_oPg.AddObject("txt_4c_Inv1", "TextBox")
365:         WITH loc_oPg.txt_4c_Inv1
366:             .Top         = 27
367:             .Left        = 167
368:             .Width       = 87
369:             .Height      = 23
370:             .Value       = 0
371:             .Format      = ""
372:             .InputMask   = "999999999"

*-- Linhas 381 a 395:
381: 
382:         *-- Descri[c][a]o do 1[o] Invent[a]rio (Say2: Top=115, Left=260)
383:         *   Preenchida ap[o]s sele[c][a]o: Grupos + " - " + Contas
384:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
385:         WITH loc_oPg.lbl_4c_Label2
386:             .Top       = 30
387:             .Left      = 260
388:             .Width     = 200
389:             .Height    = 17
390:             .Caption   = ""
391:             .FontName  = "Tahoma"
392:             .FontSize  = 8
393:             .ForeColor = RGB(90, 90, 90)
394:             .BackStyle = 0
395:             .Visible   = .T.

*-- Linhas 407 a 444:
407:     *--------------------------------------------------------------------------
408:     * ConfigurarPaginaDados - Bloco 2[o] Invent[a]rio + Tipo na Page1
409:     *
410:     * Posi[c][o]es relativas ao PageFrame.Top=85:
411:     *   Get_Inv2 (Top=137) -> Page1.Top = 137-85 = 52
412:     *   Say4     (Top=140) -> Page1.Top = 140-85 = 55
413:     *   Say5     (Top=140) -> Page1.Top = 55 (label descri[c][a]o Inv2)
414:     *   OptTipo  (Top=162) -> Page1.Top = 162-85 = 77
415:     *   Say6     (Top=166) -> Page1.Top = 166-85 = 81
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarPaginaDados()
418:         LOCAL loc_oPg
419:         loc_oPg = THIS.pgf_4c_Paginas.Page1
420: 
421:         *-- Label "2[o] Invent[a]rio :" (Say4: Left=87)
422:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
423:         WITH loc_oPg.lbl_4c_Label4
424:             .Top       = 55
425:             .Left      = 87
426:             .AutoSize  = .T.
427:             .Caption   = "2" + CHR(186) + " Invent" + CHR(225) + "rio :"
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)
431:             .BackStyle = 0
432:             .Visible   = .T.
433:         ENDWITH
434: 
435:         *-- C[o]digo do 2[o] Invent[a]rio (Get_Inv2: Top=137, Left=167, Width=87)
436:         loc_oPg.AddObject("txt_4c_Inv2", "TextBox")
437:         WITH loc_oPg.txt_4c_Inv2
438:             .Top         = 52
439:             .Left        = 167
440:             .Width       = 87
441:             .Height      = 23
442:             .Value       = 0
443:             .Format      = "R"
444:             .InputMask   = "9999999999"

*-- Linhas 453 a 514:
453: 
454:         *-- Descri[c][a]o do 2[o] Invent[a]rio (Say5: Top=140, Left=259)
455:         *   Preenchida ap[o]s sele[c][a]o: Grupos + " - " + Contas
456:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
457:         WITH loc_oPg.lbl_4c_Label5
458:             .Top       = 55
459:             .Left      = 259
460:             .Width     = 200
461:             .Height    = 17
462:             .Caption   = ""
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .ForeColor = RGB(90, 90, 90)
466:             .BackStyle = 0
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         *-- Label "Tipo :" (Say6: Left=131)
471:         loc_oPg.AddObject("lbl_4c_Label6", "Label")
472:         WITH loc_oPg.lbl_4c_Label6
473:             .Top       = 81
474:             .Left      = 131
475:             .AutoSize  = .T.
476:             .Caption   = "Tipo :"
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .ForeColor = RGB(90, 90, 90)
480:             .BackStyle = 0
481:             .Visible   = .T.
482:         ENDWITH
483: 
484:         *-- OptionGroup Tipo (OptTipo: Top=162, Left=167, Width=158, Height=24, ButtonCount=2)
485:         loc_oPg.AddObject("obj_4c_OptTipo", "OptionGroup")
486:         WITH loc_oPg.obj_4c_OptTipo
487:             .Top           = 77
488:             .Left          = 167
489:             .Width         = 158
490:             .Height        = 24
491:             .ButtonCount   = 2
492:             .BackStyle     = 0
493:             .BorderStyle   = 0
494:             .Visible       = .T.
495:             WITH .Buttons(1)
496:                 .Top       = 0
497:                 .Left      = 0
498:                 .Width     = 79
499:                 .Height    = 21
500:                 .Caption   = "Anal" + CHR(237) + "tico"
501:                 .Value     = 1
502:                 .Visible   = .T.
503:             ENDWITH
504:             WITH .Buttons(2)
505:                 .Top       = 0
506:                 .Left      = 80
507:                 .Width     = 79
508:                 .Height    = 21
509:                 .Caption   = "Sint" + CHR(233) + "tico"
510:                 .FontName  = "Tahoma"
511:                 .FontSize  = 8
512:                 .Visible   = .T.
513:             ENDWITH
514:         ENDWITH

*-- Linhas 530 a 540:
530:             loc_oPg.txt_4c_Empresa.Value   = ""
531:             loc_oPg.txt_4c_Dempresa.Value  = ""
532:             loc_oPg.txt_4c_Inv1.Value      = 0
533:             loc_oPg.lbl_4c_Label2.Caption  = ""
534:             loc_oPg.txt_4c_Inv2.Value      = 0
535:             loc_oPg.lbl_4c_Label5.Caption  = ""
536:             loc_oPg.obj_4c_OptTipo.Value   = 1
537:             THIS.AtualizarEstadoCampos()
538:         CATCH TO loc_oErro
539:             MsgErro(loc_oErro.Message, "Erro")
540:         ENDTRY

*-- Linhas 619 a 640:
619:         ENDIF
620:         IF par_nKeyCode = 27
621:             THIS.pgf_4c_Paginas.Page1.txt_4c_Inv1.Value    = 0
622:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Label2.Caption = ""
623:         ENDIF
624:     ENDPROC
625: 
626:     PROCEDURE TeclaInv2(par_nKeyCode, par_nShiftAltCtrl)
627:         IF par_nKeyCode = 115
628:             THIS.AbrirBuscaInv2()
629:         ENDIF
630:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
631:             THIS.ValidarInv2()
632:         ENDIF
633:         IF par_nKeyCode = 27
634:             THIS.pgf_4c_Paginas.Page1.txt_4c_Inv2.Value    = 0
635:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Label5.Caption = ""
636:         ENDIF
637:     ENDPROC
638: 
639:     *==========================================================================
640:     * VALIDA[C][A]O (ENTER/TAB em campo de c[o]digo)

*-- Linhas 679 a 698:
679:         loc_oPg     = THIS.pgf_4c_Paginas.Page1
680:         loc_nCodigo = loc_oPg.txt_4c_Inv1.Value
681:         IF loc_nCodigo = 0
682:             loc_oPg.lbl_4c_Label2.Caption = ""
683:             RETURN
684:         ENDIF
685:         loc_cSQL = "SELECT Codigos, Grupos, Contas FROM SigCdBal " + ;
686:                    "WHERE Emps = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Empresa.Value)) + ;
687:                    " AND Codigos = " + ALLTRIM(STR(loc_nCodigo))
688:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Inv1Val")
689:         IF loc_nResult > 0
690:             SELECT cursor_4c_Inv1Val
691:             IF !EOF()
692:                 loc_oPg.txt_4c_Inv1.Value    = Codigos
693:                 loc_oPg.lbl_4c_Label2.Caption = ALLTRIM(Grupos) + " - " + ALLTRIM(Contas)
694:             ELSE
695:                 THIS.AbrirBuscaInv1()
696:             ENDIF
697:             USE IN cursor_4c_Inv1Val
698:         ELSE

*-- Linhas 709 a 728:
709:         loc_oPg     = THIS.pgf_4c_Paginas.Page1
710:         loc_nCodigo = loc_oPg.txt_4c_Inv2.Value
711:         IF loc_nCodigo = 0
712:             loc_oPg.lbl_4c_Label5.Caption = ""
713:             RETURN
714:         ENDIF
715:         loc_cSQL = "SELECT Codigos, Grupos, Contas FROM SigCdBal " + ;
716:                    "WHERE Emps = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Empresa.Value)) + ;
717:                    " AND Codigos = " + ALLTRIM(STR(loc_nCodigo))
718:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Inv2Val")
719:         IF loc_nResult > 0
720:             SELECT cursor_4c_Inv2Val
721:             IF !EOF()
722:                 loc_oPg.txt_4c_Inv2.Value    = Codigos
723:                 loc_oPg.lbl_4c_Label5.Caption = ALLTRIM(Grupos) + " - " + ALLTRIM(Contas)
724:             ELSE
725:                 THIS.AbrirBuscaInv2()
726:             ENDIF
727:             USE IN cursor_4c_Inv2Val
728:         ELSE

*-- Linhas 776 a 784:
776:     * AbrirBuscaInv1 - Lookup do 1[o] Invent[a]rio (SigCdBal.Codigos)
777:     *   Replica Get_Inv1.Valid do original: fwBuscaExt por Codigos filtrado por Emps
778:     *   Colunas exibidas: Codigos(9999999999), Grupos, Contas
779:     *   Descri[c][a]o ap[o]s sele[c][a]o: lbl_4c_Label2.Caption = Grupos + " - " + Contas
780:     *--------------------------------------------------------------------------
781:     PROCEDURE AbrirBuscaInv1()
782:         LOCAL loc_nValor, loc_oBusca, loc_oPg, loc_cWhere, loc_cCodStr
783:         loc_oPg     = THIS.pgf_4c_Paginas.Page1
784:         loc_nValor  = loc_oPg.txt_4c_Inv1.Value

*-- Linhas 791 a 813:
791:         IF VARTYPE(loc_oBusca) = "O"
792:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
793:                 loc_oPg.txt_4c_Inv1.Value    = cursor_4c_BuscaBal1.Codigos
794:                 loc_oPg.lbl_4c_Label2.Caption = ALLTRIM(cursor_4c_BuscaBal1.Grupos) + ;
795:                                                 " - " + ALLTRIM(cursor_4c_BuscaBal1.Contas)
796:             ELSE
797:                 IF !loc_oBusca.this_lAchouRegistro
798:                     loc_oBusca.mAddColuna("Codigos", "9999999999", "C" + CHR(243) + "digo")
799:                     loc_oBusca.mAddColuna("Grupos", "", "Grupo")
800:                     loc_oBusca.mAddColuna("Contas", "", "Conta")
801:                     loc_oBusca.Show()
802:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBal1")
803:                         loc_oPg.txt_4c_Inv1.Value    = cursor_4c_BuscaBal1.Codigos
804:                         loc_oPg.lbl_4c_Label2.Caption = ALLTRIM(cursor_4c_BuscaBal1.Grupos) + ;
805:                                                         " - " + ALLTRIM(cursor_4c_BuscaBal1.Contas)
806:                     ELSE
807:                         loc_oPg.txt_4c_Inv1.Value    = 0
808:                         loc_oPg.lbl_4c_Label2.Caption = ""
809:                     ENDIF
810:                 ENDIF
811:             ENDIF
812:             loc_oBusca.Release()
813:         ENDIF

*-- Linhas 820 a 828:
820:     * AbrirBuscaInv2 - Lookup do 2[o] Invent[a]rio (SigCdBal.Codigos)
821:     *   Replica Get_Inv2.Valid do original: fwBuscaExt por Codigos filtrado por Emps
822:     *   Colunas exibidas: Codigos(9999999999), Grupos, Contas
823:     *   Descri[c][a]o ap[o]s sele[c][a]o: lbl_4c_Label5.Caption = Grupos + " - " + Contas
824:     *--------------------------------------------------------------------------
825:     PROCEDURE AbrirBuscaInv2()
826:         LOCAL loc_nValor, loc_oBusca, loc_oPg, loc_cWhere, loc_cCodStr
827:         loc_oPg     = THIS.pgf_4c_Paginas.Page1
828:         loc_nValor  = loc_oPg.txt_4c_Inv2.Value

*-- Linhas 835 a 857:
835:         IF VARTYPE(loc_oBusca) = "O"
836:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
837:                 loc_oPg.txt_4c_Inv2.Value    = cursor_4c_BuscaBal2.Codigos
838:                 loc_oPg.lbl_4c_Label5.Caption = ALLTRIM(cursor_4c_BuscaBal2.Grupos) + ;
839:                                                 " - " + ALLTRIM(cursor_4c_BuscaBal2.Contas)
840:             ELSE
841:                 IF !loc_oBusca.this_lAchouRegistro
842:                     loc_oBusca.mAddColuna("Codigos", "9999999999", "C" + CHR(243) + "digo")
843:                     loc_oBusca.mAddColuna("Grupos", "", "Grupo")
844:                     loc_oBusca.mAddColuna("Contas", "", "Conta")
845:                     loc_oBusca.Show()
846:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBal2")
847:                         loc_oPg.txt_4c_Inv2.Value    = cursor_4c_BuscaBal2.Codigos
848:                         loc_oPg.lbl_4c_Label5.Caption = ALLTRIM(cursor_4c_BuscaBal2.Grupos) + ;
849:                                                         " - " + ALLTRIM(cursor_4c_BuscaBal2.Contas)
850:                     ELSE
851:                         loc_oPg.txt_4c_Inv2.Value    = 0
852:                         loc_oPg.lbl_4c_Label5.Caption = ""
853:                     ENDIF
854:                 ENDIF
855:             ENDIF
856:             loc_oBusca.Release()
857:         ENDIF


### BO (C:\4c\projeto\app\classes\SigReAivBO.prg):
*==============================================================================
* SIGREAAIVBO.PRG
* Business Object para Relatorio de Analise Entre Inventarios
*
* Herda de RelatorioBase
* Formulario original: SIGREAIV.SCX (frmrelatorio)
* Tabelas: SigIvTrh (movimentacao inventario), SigCdBal (cadastro balanco),
*          SigCdPro (descricao do produto)
* Filtros: Empresa, 1o Inventario, 2o Inventario, Tipo (Analitico/Sintetico)
*==============================================================================

DEFINE CLASS SigReAivBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa           = ""   && Codigo da empresa (Get_Empresa)
    this_cDempresa          = ""   && Descricao da empresa (Get_Dempresa)
    this_nInv1              = 0    && Codigo do 1o inventario (Get_Inv1)
    this_nInv2              = 0    && Codigo do 2o inventario (Get_Inv2)
    this_nTipo              = 1    && Tipo: 1=Analitico, 2=Sintetico (OptTipo)

    *-- Descricoes dos inventarios exibidas apos selecao (Say2/Say5)
    this_cDescInv1          = ""   && "Grupo - Conta" do 1o inventario
    this_cDescInv2          = ""   && "Grupo - Conta" do 2o inventario

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_DbImp"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do FRX e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "SigReAiv.frx"
                THIS.this_cTituloRel = "An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "Informe a empresa"
            RETURN .F.
        ENDIF
        IF THIS.this_nInv1 = 0
            THIS.this_cMensagemErro = "Informe o 1" + CHR(186) + ;
                                      " Invent" + CHR(225) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nInv2 = 0
            THIS.this_cMensagemErro = "Informe o 2" + CHR(186) + ;
                                      " Invent" + CHR(225) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nInv1 = THIS.this_nInv2
            THIS.this_cMensagemErro = "Invent" + CHR(225) + "rio 2 deve ser diferente do 1" + CHR(186)
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa SQL e monta cursor de dados do relatorio
    * Logica: busca movimentacoes dos 2 inventarios, agrupa por produto/local,
    * calcula sobras (cnInvs1 > cnInvs2) e faltas (cnInvs2 > cnInvs1),
    * remove registros sem diferenca.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL lacPros, laLocal, loc_nInv1, loc_nInv2

        loc_lSucesso = .F.

        TRY
            loc_nInv1 = THIS.this_nInv1
            loc_nInv2 = THIS.this_nInv2

            loc_cSQL = "SELECT a.*, b.dPros " + ;
                       "FROM SigIvTrh a " + ;
                       "LEFT JOIN SigCdPro b ON a.cPros = b.cPros " + ;
                       "WHERE Emps = " + EscaparSQL(THIS.this_cEmpresa) + ;
                       " AND NOT a.cPros = Space(14)" + ;
                       " AND (codigos = " + ALLTRIM(STR(loc_nInv1)) + ;
                       " OR codigos = " + ALLTRIM(STR(loc_nInv2)) + ;
                       ") ORDER BY a.cPros, a.localis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigIvTr")

            IF loc_nResult >= 0
                *-- Limpa cursores de execucao anterior
                IF USED(THIS.this_cCursorCabecalho)
                    USE IN (THIS.this_cCursorCabecalho)
                ENDIF
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                *-- Cursor cabecalho: guarda codigos dos dois inventarios (usado pelo FRX)
                SET NULL ON
                CREATE CURSOR cursor_4c_Cabecalho (cnInvs1 N(10), cnInvs2 N(10))
                SET NULL OFF
                INSERT INTO cursor_4c_Cabecalho VALUES (loc_nInv1, loc_nInv2)

                *-- Cursor resultado: uma linha por produto/localizacao com qtds de cada inventario
                SET NULL ON
                CREATE CURSOR cursor_4c_DbImp ;
                    (cPros C(14), dPros C(40), cLocals C(10), ;
                     cnInvs1 N(6), cnInvs2 N(6), Sobras N(6), Faltas N(6), Tipos N(1))
                SET NULL OFF

                *-- Processa registros agrupando por produto (e localizacao no modo analitico)
                SELECT cursor_4c_SigIvTr
                lacPros = ''
                laLocal = ''

                SCAN
                    SCATTER MEMVAR
                    SELECT cursor_4c_DbImp
                    IF cursor_4c_SigIvTr.codigos = loc_nInv1
                        m.cnInvs1 = cursor_4c_SigIvTr.Qtds
                        m.cnInvs2 = 0
                    ELSE
                        m.cnInvs1 = 0
                        m.cnInvs2 = cursor_4c_SigIvTr.Qtds
                    ENDIF
                    IF lacPros <> cursor_4c_SigIvTr.cPros OR ;
                       IIF(THIS.this_nTipo = 1, laLocal <> cursor_4c_SigIvTr.localis, .F.)
                        IF ISNULL(m.dPros)
                            m.dPros = ''
                        ENDIF
                        APPEND BLANK
                        GATHER MEMVAR
                        REPLACE cLocals WITH cursor_4c_SigIvTr.localis
                        REPLACE Tipos WITH THIS.this_nTipo
                        lacPros = cursor_4c_SigIvTr.cPros
                        laLocal = cursor_4c_SigIvTr.localis
                    ELSE
                        IF cursor_4c_SigIvTr.codigos = loc_nInv1
                            REPLACE cnInvs1 WITH cnInvs1 + m.cnInvs1
                        ELSE
                            REPLACE cnInvs2 WITH cnInvs2 + m.cnInvs2
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigIvTr
                ENDSCAN

                *-- Calcula sobras/faltas e elimina registros sem diferenca
                SELECT cursor_4c_DbImp
                REPLACE ALL Sobras WITH cnInvs1 - cnInvs2 FOR cnInvs1 - cnInvs2 > 0
                REPLACE ALL Faltas WITH cnInvs2 - cnInvs1 FOR cnInvs2 - cnInvs1 > 0
                DELETE ALL FOR Sobras = 0 AND Faltas = 0
                GO TOP

                IF USED("cursor_4c_SigIvTr")
                    USE IN cursor_4c_SigIvTr
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados do invent" + CHR(225) + "rio"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                IF THIS.PrepararDados()
                    IF FILE(THIS.this_cFRXPath)
                        REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                                  CHR(227) + "o encontrado"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                IF THIS.PrepararDados()
                    IF FILE(THIS.this_cFRXPath)
                        REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                                  CHR(227) + "o encontrado"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identifica a execucao do relatorio para auditoria
    * Retorna string com filtros aplicados (empresa + invs)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpresa) + "|" + ;
               ALLTRIM(STR(THIS.this_nInv1)) + "|" + ;
               ALLTRIM(STR(THIS.this_nInv2))
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emissao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            loc_cSQL = "INSERT INTO LogAuditoria (Usuario, Operacao, Tabela, ChavePrimaria, DataHora) " + ;
                       "VALUES (" + EscaparSQL(loc_cUsuario) + ", " + ;
                                    EscaparSQL(par_cOperacao) + ", " + ;
                                    EscaparSQL("SigReAiv") + ", " + ;
                                    EscaparSQL(loc_cChave) + ", GETDATE())"
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao persiste)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * Em relatorios, a carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_DbImp")
            USE IN cursor_4c_DbImp
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigIvTr")
            USE IN cursor_4c_SigIvTr
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

