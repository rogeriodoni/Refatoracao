# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 652: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS GRID (1480 linhas total):

*-- Linhas 16 a 34:
16: *
17: * FASE 6 (campos restantes e lookups):
18: *  - LOOKUP: nenhum. O dump original (SigPrMlu_form_codigo_fonte.txt) nao tem
19: *    fwBuscaExt/fwBuscaSel/fwBuscaInt, mAddColuna, sigacess() nem Acesso*() -
20: *    o unico CreateObject do form eh o fSqlConector (gerenciador de dados, ja
21: *    coberto pelo BO). Inventar lookup aqui violaria o PILAR 1 e a regra
22: *    "NUNCA inventar tabelas de lookup que nao existem no original".
23: *  - CAMPOS: o unico campo DIGITAVEL do legado eh cntNova.getNova ("Nome da
24: *    Unificacao") -> cnt_4c_Nova.txt_4c_Nova, criado em
25: *    ConfigurarContainerNova() com Format = "K" e MaxLength = 20 transcritos
26: *    do SCX (regra #49). Os 5 Text1 das Column2..Column6 sao celulas da grade
27: *    e sao somente-leitura no legado (PROCEDURE When / Return(.f.)),
28: *    reproduzidas como Column.ReadOnly = .T. em ConfigurarGridDados().
29: *  - REGRA DO CAMPO: o getNova nao tem Valid/When/LostFocus - a regra que o
30: *    governa mora DENTRO do cmdProcessar.Click do legado (tres guards:
31: *    nenhuma mala marcada, uma so mala marcada, nome em branco). Ela eh de
32: *    QUEM ela governa, nao de quem a chama: entregue nesta fase como o funil
33: *    unico PUBLIC ValidarProcessamento(), que BtnProcessarClick apenas chama.
34: *

*-- Linhas 215 a 249:
215:     * ConfigurarGridDados - Grade "grdselecoes" do legado: lista as malas
216:     * diretas cadastradas (SigMlItn), com checkbox de selecao na Column1
217:     * (SelImp) para escolher quais malas serao unificadas pelo cmd_4c_Processar.
218:     * ControlSource/RecordSource ficam para CarregarLista() - cursor_4c_Dados
219:     * ainda nao existe aqui (regra #41 do CLAUDE.md).
220:     * Original: grdselecoes Top=159 Left=49 Width=660 Height=324
221:     *==========================================================================
222:     PROTECTED PROCEDURE ConfigurarGridDados()
223:     *==========================================================================
224:         LOCAL loc_oGrid
225: 
226:         THIS.AddObject("grd_4c_Dados", "Grid")
227:         loc_oGrid = THIS.grd_4c_Dados
228: 
229:         WITH loc_oGrid
230:             .Top               = 159
231:             .Left              = 49
232:             .Width             = 660
233:             .Height            = 324
234:             .ColumnCount       = 6
235:             .FontName          = "Tahoma"
236:             .FontSize          = 8
237:             .HeaderHeight      = 16
238:             .RowHeight         = 16
239:             .AllowHeaderSizing = .F.
240:             .AllowRowSizing    = .F.
241:             .DeleteMark        = .F.
242:             .RecordMark        = .F.
243:             .ReadOnly          = .F.
244:             .ScrollBars        = 2
245:             .GridLineColor     = RGB(238, 238, 238)
246:             .Visible           = .T.
247:         ENDWITH
248: 
249:         *-- Column1: checkbox de marcacao (SelImp). Pattern #185/#186

*-- Linhas 268 a 403:
268:             .chk_4c_Check1.ReadOnly  = .F.
269:             .chk_4c_Check1.Visible   = .T.
270:             .CurrentControl    = "chk_4c_Check1"
271:             .Header1.Caption   = ""
272:             .Header1.FontName  = "Tahoma"
273:             .Header1.FontSize  = 8
274:             .Header1.Alignment = 2
275:             .Header1.ForeColor = RGB(36, 84, 155)
276:         ENDWITH
277:         THIS.BindToggleSelecao(THIS.grd_4c_Dados.Column1.chk_4c_Check1)
278: 
279:         *-- Column2: Codigos
280:         WITH loc_oGrid.Column2
281:             .Width     = 80
282:             .ReadOnly  = .T.
283:             .Movable   = .F.
284:             .Resizable = .F.
285:             .FontName  = "Courier New"
286:             .Header1.Caption   = "C" + CHR(243) + "digo"
287:             .Header1.FontName  = "Tahoma"
288:             .Header1.FontSize  = 8
289:             .Header1.Alignment = 2
290:             .Header1.ForeColor = RGB(36, 84, 155)
291:         ENDWITH
292:         IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
293:             WITH loc_oGrid.Column2.Text1
294:                 .FontName = "Courier New"
295:                 .FontSize = 8
296:                 .Margin   = 0
297:             ENDWITH
298:         ENDIF
299: 
300:         *-- Column3: Descs
301:         WITH loc_oGrid.Column3
302:             .Width     = 260
303:             .ReadOnly  = .T.
304:             .Movable   = .F.
305:             .Resizable = .F.
306:             .FontName  = "Courier New"
307:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
308:             .Header1.FontName  = "Tahoma"
309:             .Header1.FontSize  = 8
310:             .Header1.Alignment = 2
311:             .Header1.ForeColor = RGB(36, 84, 155)
312:         ENDWITH
313:         IF PEMSTATUS(loc_oGrid.Column3, "Text1", 5)
314:             WITH loc_oGrid.Column3.Text1
315:                 .FontName = "Courier New"
316:                 .FontSize = 8
317:             ENDWITH
318:         ENDIF
319: 
320:         *-- Column4: UsuIns
321:         WITH loc_oGrid.Column4
322:             .Width     = 120
323:             .ReadOnly  = .T.
324:             .Movable   = .F.
325:             .Resizable = .F.
326:             .FontName  = "Courier New"
327:             .Header1.Caption   = "Usu" + CHR(225) + "rio"
328:             .Header1.FontName  = "Tahoma"
329:             .Header1.FontSize  = 8
330:             .Header1.Alignment = 2
331:             .Header1.ForeColor = RGB(36, 84, 155)
332:         ENDWITH
333:         IF PEMSTATUS(loc_oGrid.Column4, "Text1", 5)
334:             WITH loc_oGrid.Column4.Text1
335:                 .FontName = "Courier New"
336:                 .FontSize = 8
337:                 .Margin   = 0
338:             ENDWITH
339:         ENDIF
340: 
341:         *-- Column5: DatIns
342:         WITH loc_oGrid.Column5
343:             .Width     = 80
344:             .ReadOnly  = .T.
345:             .Movable   = .F.
346:             .Resizable = .F.
347:             .FontName  = "Courier New"
348:             .Header1.Caption   = "Dt.Entrada"
349:             .Header1.FontName  = "Tahoma"
350:             .Header1.FontSize  = 8
351:             .Header1.Alignment = 2
352:             .Header1.ForeColor = RGB(36, 84, 155)
353:         ENDWITH
354:         IF PEMSTATUS(loc_oGrid.Column5, "Text1", 5)
355:             WITH loc_oGrid.Column5.Text1
356:                 .FontName = "Courier New"
357:                 .FontSize = 8
358:                 .Margin   = 0
359:             ENDWITH
360:         ENDIF
361: 
362:         *-- Column6: NRegis
363:         WITH loc_oGrid.Column6
364:             .Width     = 80
365:             .ReadOnly  = .T.
366:             .Movable   = .F.
367:             .Resizable = .F.
368:             .FontName  = "Courier New"
369:             .Header1.Caption   = "N.Registros"
370:             .Header1.FontName  = "Tahoma"
371:             .Header1.FontSize  = 8
372:             .Header1.Alignment = 2
373:             .Header1.ForeColor = RGB(36, 84, 155)
374:         ENDWITH
375:         IF PEMSTATUS(loc_oGrid.Column6, "Text1", 5)
376:             WITH loc_oGrid.Column6.Text1
377:                 .FontName = "Courier New"
378:                 .FontSize = 8
379:                 .Margin   = 0
380:             ENDWITH
381:         ENDIF
382: 
383:         *-- Ordenacao por clique no cabecalho (legado: Column2..5.Header1.Click
384:         *-- chama AcertaGrades(N) - Column1/Column6 nao tem Click no dump)
385:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GradeHeaderCodigosClick")
386:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GradeHeaderDescsClick")
387:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GradeHeaderUsuInsClick")
388:         BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "GradeHeaderDatInsClick")
389:     ENDPROC
390: 
391:     *==========================================================================
392:     * ConfigurarBotoesAcao - Botoes de acao da tela (equivalentes aos 3
393:     * CommandGroups do legado - cmdProcessar/Commandgroup2/cmdBtnGrade, cada
394:     * um com ButtonCount 1 ou 2); migrados para CommandButton standalone,
395:     * preservando a geometria ABSOLUTA (grupo.Left/Top + botao.Left/Top do
396:     * dump) e Caption/Picture/cor de cada botao interno.
397:     *==========================================================================
398:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
399:     *==========================================================================
400:         *-- cmdProcessar (Command1/btnProcessar): grupo Left=637 Top=-2,
401:         *-- botao Left=5 Top=5 -> absoluto 642,3. Themes=.T.+DisabledPicture
402:         *-- SAO EXCECAO ao legado (Themes=.F.): este botao e desabilitado em
403:         *-- runtime (This.Enabled=.f. durante o processamento) e sem Themes=.T.

*-- Linhas 553 a 571:
553: 
554:     *==========================================================================
555:     * InicializarForm - Cria o BO e a estrutura visual completa: cabecalho,
556:     * grade de selecao (grd_4c_Dados), botoes de acao (Processar/Sair/
557:     * Marcar/Desmarcar) e o campo "Nome da Unificacao".
558:     *==========================================================================
559:     PROTECTED PROCEDURE InicializarForm()
560:     *==========================================================================
561:         LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
562:         loc_lSucesso = .F.
563:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
564:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
565: 
566:         TRY
567:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
568: 
569:             *-- DataSession=2 nasce no default do VFP (regra #9.4) - SET DELETED
570:             *-- nao herda o SET do config.prg
571:             SET DELETED ON

*-- Linhas 624 a 685:
624:         loc_cSQL = "SELECT 0 AS SelImp, codigos AS Codigos, descs AS Descs, " + ;
625:             "usuins AS UsuIns, datins AS DatIns, nregis AS NRegis FROM SigMlItn"
626: 
627:         SET NULL ON
628:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
629:         SET NULL OFF
630: 
631:         IF loc_nResultado >= 0
632:             IF USED("cursor_4c_Dados")
633:                 USE IN cursor_4c_Dados
634:             ENDIF
635: 
636:             SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
637:             USE IN cursor_4c_DadosTmp
638: 
639:             SELECT cursor_4c_Dados
640:             INDEX ON Codigos TAG Codigos
641:             INDEX ON Descs   TAG Descs
642:             INDEX ON UsuIns  TAG UsuIns
643:             INDEX ON DatIns  TAG DatIns
644: 
645:             THIS.grd_4c_Dados.RecordSource = ""
646:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.SelImp"
647:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.Codigos"
648:             THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.Descs"
649:             THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.UsuIns"
650:             THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.DatIns"
651:             THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.NRegis"
652:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
653: 
654:             *-- RecordSource reseta Width/Header/CurrentControl - reconfigurar
655:             *-- IMEDIATAMENTE depois (CLAUDE.md "Problema 48")
656:             THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_Check1"
657:             THIS.grd_4c_Dados.Column1.Sparse         = .F.
658:             THIS.grd_4c_Dados.Column1.ReadOnly        = .F.
659:             THIS.grd_4c_Dados.Column1.Width           = 15
660:             THIS.grd_4c_Dados.Column1.Header1.Caption = ""
661:             THIS.grd_4c_Dados.Column2.Width           = 80
662:             THIS.grd_4c_Dados.Column2.Header1.Caption = "C" + CHR(243) + "digo"
663:             THIS.grd_4c_Dados.Column3.Width           = 260
664:             THIS.grd_4c_Dados.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
665:             THIS.grd_4c_Dados.Column4.Width           = 120
666:             THIS.grd_4c_Dados.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
667:             THIS.grd_4c_Dados.Column5.Width           = 80
668:             THIS.grd_4c_Dados.Column5.Header1.Caption = "Dt.Entrada"
669:             THIS.grd_4c_Dados.Column6.Width           = 80
670:             THIS.grd_4c_Dados.Column6.Header1.Caption = "N.Registros"
671: 
672:             THIS.OrdenarGrade(THIS.this_nGridOrder)
673: 
674:             loc_lSucesso = .T.
675:         ELSE
676:             MostrarErro("Erro ao carregar malas diretas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
677:         ENDIF
678: 
679:         RETURN loc_lSucesso
680:     ENDPROC
681: 
682:     *==========================================================================
683:     * OrdenarGrade - Reordena cursor_4c_Dados pela coluna informada
684:     * (equivalente a AcertaGrades(pColuna) do legado) e realca o cabecalho
685:     * da coluna ativa com RGB(220,255,220), como no legado.

*-- Linhas 709 a 738:
709:             GO TOP
710:         ENDIF
711: 
712:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
713:             FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
714:                 loc_cCaminho = "THIS.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI, 2)) + ".Header1.BackColor"
715:                 STORE IIF(THIS.this_nGridOrder = loc_nI, RGB(220, 255, 220), THIS.BackColor) TO (loc_cCaminho)
716:             ENDFOR
717:             THIS.grd_4c_Dados.Refresh()
718:         ENDIF
719:     ENDPROC
720: 
721:     *==========================================================================
722:     * GradeHeader*Click - Disparados pelo clique nos cabecalhos das colunas
723:     * 2 a 5 (equivalente a Column2..5.Header1.Click chamando AcertaGrades(N)
724:     * no legado - Column1/Column6 nao tem Click no dump)
725:     *==========================================================================
726:     PROCEDURE GradeHeaderCodigosClick()
727:     *==========================================================================
728:         THIS.OrdenarGrade(2)
729:     ENDPROC
730: 
731:     PROCEDURE GradeHeaderDescsClick()
732:     *==========================================================================
733:         THIS.OrdenarGrade(3)
734:     ENDPROC
735: 
736:     PROCEDURE GradeHeaderUsuInsClick()
737:     *==========================================================================
738:         THIS.OrdenarGrade(4)

*-- Linhas 766 a 784:
766:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
767:             SELECT cursor_4c_Dados
768:             REPLACE SelImp WITH IIF(NVL(SelImp, 0) = 1, 0, 1)
769:             THIS.grd_4c_Dados.Refresh()
770:         ENDIF
771:     ENDPROC
772: 
773:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
774:     *==========================================================================
775:         IF INLIST(par_nKeyCode, 13, 32)
776:             THIS.ChkSelecaoToggle()
777:             NODEFAULT
778:         ENDIF
779:     ENDPROC
780: 
781:     *-- MouseDown apenas SUPRIME o toggle nativo (legado: "NoDefault" e nada
782:     *-- mais). Quem alterna eh o MouseUp - o legado chama "This.KeyPress(13,0)"
783:     *-- de dentro dele. Invertidos, o valor alterna antes de o clique terminar
784:     *-- e um arraste sobre a celula alterna sem o usuario soltar o botao.

*-- Linhas 852 a 870:
852:                     GO TOP
853:                 ENDIF
854: 
855:                 THIS.grd_4c_Dados.Refresh()
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
859:                 "Procedure: " + loc_oErro.Procedure, "Erro em MarcarTodasAs")
860:         ENDTRY
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * CmdSelTudoClick - 1o botao do cmdBtnGrade ("btnMarcar", ToolTip
865:     * "Seleciona Tudo"): marca todas as malas da grade. This.Value = 1.
866:     *==========================================================================
867:     PROCEDURE CmdSelTudoClick()
868:     *==========================================================================
869:         THIS.MarcarTodasAs(1)
870:     ENDPROC

*-- Linhas 934 a 960:
934:                 CASE loc_nSelecionadas < 1
935:                     MsgAviso("Nenhuma Mala Direta Com Registros Foi Selecionada Para Unifica" + ;
936:                         CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
937:                     THIS.grd_4c_Dados.SetFocus()
938:                     loc_lValido = .F.
939: 
940:                 CASE loc_nSelecionadas = 1
941:                     MsgAviso("Apenas Uma Mala Direta Com Registros Foi Selecionada Para Ser Unificada!!!" + CHR(13) + ;
942:                         "N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
943:                         "vel Unificar Apenas Uma Mala Direta, Selecione Ao Menos Duas!!!", ;
944:                         "Aten" + CHR(231) + CHR(227) + "o")
945:                     THIS.grd_4c_Dados.SetFocus()
946:                     loc_lValido = .F.
947: 
948:                 CASE EMPTY(ALLTRIM(THIS.cnt_4c_Nova.txt_4c_Nova.Value))
949:                     MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o Invalido!!! Este " + CHR(233) + ;
950:                         " o Nome Que" + CHR(13) + "Vai Ser Utilizado Na Unifica" + CHR(231) + CHR(227) + ;
951:                         "o Que Ser" + CHR(225) + " Gerada!!!", "Aten" + CHR(231) + CHR(227) + "o")
952:                     THIS.cnt_4c_Nova.txt_4c_Nova.SetFocus()
953:                     loc_lValido = .F.
954:             ENDCASE
955: 
956:             *-- Espelho tela -> BO (so com os guards aprovados), delegado ao
957:             *-- funil unico FormParaBO. Fica DEPOIS da validacao para que
958:             *-- nenhum caminho grave o nome ANTIGO quando o usuario limpa o
959:             *-- campo entre duas unificacoes, e a falha dele REPROVA: sem o
960:             *-- espelho, ProcessarUnificacao leria property vazia.

*-- Linhas 987 a 1010:
987:         LOCAL loc_oErro
988: 
989:         TRY
990:             THIS.grd_4c_Dados.Refresh()
991:             IF USED("cursor_4c_Dados")
992:                 SELECT cursor_4c_Dados
993:                 GO TOP
994:             ENDIF
995:             THIS.grd_4c_Dados.Refresh()
996: 
997:             THIS.this_cModoAtual = "PROCESSANDO"
998:             THIS.AjustarBotoesPorModo()
999: 
1000:             IF THIS.ValidarProcessamento()
1001:                 IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?", ;
1002:                     "Confirma" + CHR(231) + CHR(227) + "o")
1003:                     THIS.ProcessarUnificacao()
1004:                 ENDIF
1005:             ENDIF
1006:         CATCH TO loc_oErro
1007:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1008:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
1009:         ENDTRY
1010: 

*-- Linhas 1069 a 1097:
1069:                 USE IN cursor_4c_Unificada
1070:             ENDIF
1071: 
1072:             SET NULL ON
1073:             CREATE CURSOR cursor_4c_Unificada (ChaveUnica C(200), Cidchaves C(20), ;
1074:                 IClis C(10) NULL, Codigos C(10) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
1075:                 Compls C(25) NULL, Estas C(2) NULL, Faxs C(20) NULL, Grupos C(10) NULL, ;
1076:                 Mes C(2) NULL, Nums C(10) NULL, Rclis C(50) NULL, Tel1S C(20) NULL, ;
1077:                 Tel2S C(20) NULL, Cidas C(30) NULL, Endes C(60) NULL, Nascs T NULL, ;
1078:                 Profiss C(20) NULL, Sexos C(1) NULL, Ultcomps T NULL, Aptos N(6, 0) NULL, ;
1079:                 Opdest N(1, 0) NULL, Desti C(50) NULL, Opini N(1, 0) NULL, Dtncons T NULL, ;
1080:                 Conjuges C(60) NULL, Dtcasas T NULL, Situas C(3) NULL, Dataincs T NULL, ;
1081:                 Opani N(1, 0) NULL, Quebras C(40) NULL, Cpfs C(20) NULL)
1082:             SET NULL OFF
1083:             INDEX ON ChaveUnica TAG ChaveUnica
1084: 
1085:             *-- Malas marcadas (equivalente a "Select Codigos From crSigMlItn
1086:             *-- Where SelImp = 1")
1087:             IF USED("cursor_4c_MalasSel")
1088:                 USE IN cursor_4c_MalasSel
1089:             ENDIF
1090:             SELECT Codigos FROM cursor_4c_Dados WHERE SelImp = 1 ;
1091:                 INTO CURSOR cursor_4c_MalasSel
1092: 
1093:             SELECT cursor_4c_MalasSel
1094:             SCAN
1095:                 IF loc_lErroInsercao
1096:                     EXIT
1097:                 ENDIF

*-- Linhas 1108 a 1128:
1108:                     USE IN cursor_4c_MlCabTmp
1109:                 ENDIF
1110: 
1111:                 SET NULL ON
1112:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MlCabTmp")
1113:                 SET NULL OFF
1114: 
1115:                 IF loc_nResultado >= 0
1116:                     loc_nTotalOrigem = loc_nTotalOrigem + RECCOUNT("cursor_4c_MlCabTmp")
1117: 
1118:                     SELECT cursor_4c_MlCabTmp
1119:                     SCAN
1120:                         SCATTER MEMVAR MEMO
1121:                         loc_cChaveUnica = PADR(UPPER(STRTRAN(NVL(m.desti, "") + NVL(m.ceps, "") + ;
1122:                             NVL(m.endes, "") + NVL(m.nums, "") + NVL(m.compls, ""), " ", "")), 200)
1123: 
1124:                         IF !SEEK(loc_cChaveUnica, "cursor_4c_Unificada", "ChaveUnica")
1125:                             m.ChaveUnica = loc_cChaveUnica
1126:                             m.Cidchaves  = LEFT(fUniqueIds(), 20)
1127:                             m.Codigos    = PADR(loc_cCodigoNovo, 10)
1128:                             INSERT INTO cursor_4c_Unificada FROM MEMVAR

*-- Linhas 1231 a 1249:
1231:                     *-- Requery(crSigMlItn) do legado.
1232:                     THIS.LimparCampos()
1233:                     THIS.CarregarLista()
1234:                     THIS.grd_4c_Dados.SetFocus()
1235: 
1236:                     loc_lSucesso = .T.
1237:                 ELSE
1238:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1239:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar a unifica" + ;
1240:                             CHR(231) + CHR(227) + "o.", "Erro")
1241:                     ENDIF
1242:                 ENDIF
1243:             ENDIF
1244: 
1245:         CATCH TO loc_oErro
1246:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1247:                 "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarUnificacao")
1248:         ENDTRY
1249: 

