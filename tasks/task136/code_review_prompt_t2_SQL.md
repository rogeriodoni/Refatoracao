# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'XNENS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, EMPS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = "xNensiS.Cdescs"
	Select xNensiS
			Select crSigCdSvc
				Case Seek(xNensiS.Cats + xNensiS.GrupoFs + xNensiS.ContaFs )
				Case Seek(xNensiS.Cats + xNensiS.GrupoFs + Space(10))
				Case Seek(xNensiS.Cats + Space(20))
				Select xNensis
	Select xNensiS
=Seek(pForm._Dopp, 'crSigCdOpd', 'Dopps')
Select Sum(1) as Qtd, Grupos, Contas ;
  From CsContas ;
Select CsTotal
	Select CsContas
	Select xNensiS
Select xNensis
	.Column1.ControlSource   = 'xnensis.Nenvs' 				&& Envelope
	.Column2.ControlSource   = 'xnensis.cats'				&& Categoria
	.Column3.ControlSource   = 'xnensis.Fators'				&& Valor do Servico
	.Column4.ControlSource   = 'xnensis.qtds'				&& Qtde
	.Column5.ControlSource   = 'xnensis.Contafs'			&& Conta
	.Column6.ControlSource   = 'xnensis.Grupofs'			&& Grupo
	.Column7.ControlSource   = 'xnensis.cRetrabs'			&& retrabalho
	.Column8.ControlSource   = 'xnensis.Coefs'  			&& Valor do Servico de REtrabalho
	.Column9.ControlSource   = 'xnensis.Coefinfs'  			&& Valor do Servico Informado
	If Not Empty(This.Value) And Not Seek(This.Value, 'TmpGccr', 'BalCodigo')
Select xNensiS
	Select * From CsContas Where Nenvs = _Nenv Into Cursor Selecao ReadWrite
	Select Selecao
	If Not Seek(This.Value) 
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
Select xNensis
	lcSql = [Select * From SigPrCrt Where Emps = ']+_Empr+[' Or Emps = ' ' ]
	If Thisform.Podatamgr.Sqlexecute(lcSql,'CsSelecao') < 1
	Select CsSelecao
	If Not Seek(This.Value)
	Select crSigCdSvc
		Case Seek(This.Value + xNensiS.GrupoFs + xNensiS.ContaFs )
		Case Seek(This.Value + xNensiS.GrupoFs + Space(10))
		Case Seek(This.Value + Space(20))
		Select * From CrSigCdSvc Where ;
		Select Selecao
		Select xNensiS
Select xNensiS
Select xNensiR

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM11.prg) - TRECHOS RELEVANTES PARA PASS SQL (1587 linhas total):

*-- Linhas 87 a 105:
87:         ColumnCount = 9, ;
88:         FontBold = .T., HeaderHeight = 15, ;
89:         GridLineColor = RGB(238,238,238), ;
90:         RecordMark = .F., DeleteMark = .F., ;
91:         Visible = .F.
92: 
93:     *-- TextBox descricao do servico (display da categoria selecionada)
94:     ADD OBJECT txt_4c_DescCat AS TextBox WITH ;
95:         FontName = "Tahoma", FontSize = 8, ;
96:         Height = 23, Left = 128, Top = 569, Width = 744, ;
97:         ReadOnly = .T., Visible = .F.
98: 
99:     *-- Label descricao do servico
100:     ADD OBJECT lbl_4c_Label3 AS Label WITH ;
101:         AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
102:         BackStyle = 0, ;
103:         Height = 15, Left = 128, Top = 548, Width = 108, ;
104:         ForeColor = RGB(90,90,90), Visible = .F.
105: 

*-- Linhas 163 a 181:
163:             *-- Pre-calcula coeficientes de servico (equivalente ao Gravacat inicial)
164:             IF USED("xNensiS")
165:                 SET CONFIRM ON
166:                 SELECT xNensiS
167:                 GO TOP
168:                 THIS.this_oBusinessObject.GravarItens(.F.)
169:             ENDIF
170: 
171:             *-- Configura aparencia base do form (OPERACIONAL sem PageFrame CRUD)
172:             THIS.ConfigurarPageFrame()
173: 
174:             THIS.ConfigurarCabecalho()
175:             THIS.ConfigurarOperacao()
176:             THIS.ConfigurarOptMov()
177:             THIS.ConfigurarDescricaoServico()
178:             THIS.ConfigurarSaida()
179:             THIS.ConfigurarPaginaLista()
180:             THIS.ConfigurarBotoes()
181:             THIS.TornarControlesVisiveis(THIS)

*-- Linhas 197 a 244:
197:     * ConfigurarDataEnvironment - Garante existencia dos cursores compartilhados
198:     * Forms OPERACIONAIS compartilham datasession com o pai. Se um cursor
199:     * esperado nao foi aberto pelo pai, cria placeholder vazio para evitar
200:     * "Alias not found" nos ControlSource estaticos.
201:     *==========================================================================
202:     PROTECTED PROCEDURE ConfigurarDataEnvironment()
203:         LOCAL loc_oErro
204: 
205:         TRY
206:             *-- tmpnens: cursor com emps/dopps/numps usado pelo container Operacao
207:             IF NOT USED("tmpnens")
208:                 CREATE CURSOR tmpnens ( ;
209:                     emps  C(2), ;
210:                     dopps C(30), ;
211:                     numps N(10,0))
212:                 APPEND BLANK
213:                 REPLACE tmpnens.emps  WITH go_4c_Sistema.cCodEmpresa, ;
214:                         tmpnens.dopps WITH "", ;
215:                         tmpnens.numps WITH 0
216:             ENDIF
217: 
218:             *-- crSigCdOpd: cadastro de operacoes (usado em SEEK por _Dopp)
219:             IF NOT USED("crSigCdOpd")
220:                 CREATE CURSOR crSigCdOpd ( ;
221:                     Dopps C(30), ;
222:                     Codops C(10), ;
223:                     Emps   C(2))
224:                 INDEX ON Dopps TAG Dopps
225:             ENDIF
226: 
227:             *-- xNensiS: cursor principal de itens de servico
228:             IF NOT USED("xNensiS")
229:                 CREATE CURSOR xNensiS ( ;
230:                     Nenvs    N(10,0), ;
231:                     Cats     C(10), ;
232:                     Fators   N(14,2), ;
233:                     Qtds     N(14,2), ;
234:                     Contafs  C(10), ;
235:                     Grupofs  C(10), ;
236:                     cRetrabs C(10), ;
237:                     Coefs    N(14,2), ;
238:                     Coefinfs N(14,2), ;
239:                     Retrabs  L, ;
240:                     OsRets   L, ;
241:                     cDescs   C(60))
242:             ENDIF
243:         CATCH TO loc_oErro
244:             MsgErro(loc_oErro.Message, "Erro em ConfigurarDataEnvironment")

*-- Linhas 290 a 317:
290: 
291:         TRY
292:             IF USED("CsContas")
293:                 SELECT SUM(1) AS Qtd, Grupos, Contas ;
294:                     FROM CsContas ;
295:                     GROUP BY Grupos, Contas ;
296:                     INTO CURSOR CsTotal
297: 
298:                 SELECT CsTotal
299:                 IF RECCOUNT() = 1
300:                     SELECT CsContas
301:                     GO TOP
302:                     SELECT xNensiS
303:                     REPLACE ALL GrupoFs WITH CsContas.Grupos, ;
304:                                 ContaFs WITH CsContas.Contas
305:                 ENDIF
306: 
307:                 IF USED("CsTotal")
308:                     USE IN CsTotal
309:                 ENDIF
310:             ENDIF
311:         CATCH TO loc_oErro
312:             MsgErro(loc_oErro.Message, "Erro em InicializarGrupoContas")
313:         ENDTRY
314:     ENDPROC
315: 
316:     *==========================================================================
317:     * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra

*-- Linhas 377 a 425:
377:             *-- Empresa (tmpnens.emps)
378:             .ADDOBJECT("txt_4c_Empresa", "TextBox")
379:             WITH .txt_4c_Empresa
380:                 .ControlSource     = "tmpnens.emps"
381:                 .Height            = 23
382:                 .Left              = 103
383:                 .Top               = 10
384:                 .Width             = 36
385:                 .ReadOnly          = .T.
386:                 .FontName          = "Tahoma"
387:                 .FontSize          = 8
388:                 .DisabledBackColor = RGB(255,255,255)
389:                 .Visible           = .T.
390:             ENDWITH
391: 
392:             *-- Operacao descricao (tmpnens.dopps)
393:             .ADDOBJECT("txt_4c_Operacao", "TextBox")
394:             WITH .txt_4c_Operacao
395:                 .ControlSource     = "tmpnens.dopps"
396:                 .Height            = 23
397:                 .Left              = 141
398:                 .Top               = 10
399:                 .Width             = 156
400:                 .ReadOnly          = .T.
401:                 .FontName          = "Tahoma"
402:                 .FontSize          = 8
403:                 .DisabledBackColor = RGB(255,255,255)
404:                 .Visible           = .T.
405:             ENDWITH
406: 
407:             *-- Numero da operacao (tmpnens.numps)
408:             .ADDOBJECT("txt_4c_NumCodigo", "TextBox")
409:             WITH .txt_4c_NumCodigo
410:                 .ControlSource     = "tmpnens.numps"
411:                 .Format            = "L"
412:                 .InputMask         = "9999999999"
413:                 .Left              = 299
414:                 .Top               = 10
415:                 .Width             = 81
416:                 .ReadOnly          = .T.
417:                 .FontName          = "Tahoma"
418:                 .FontSize          = 8
419:                 .DisabledBackColor = RGB(255,255,255)
420:                 .Visible           = .T.
421:             ENDWITH
422:         ENDWITH
423:     ENDPROC
424: 
425:     *==========================================================================

*-- Linhas 465 a 483:
465:         ENDWITH
466: 
467:         WITH THIS.txt_4c_DescCat
468:             .ControlSource = "xNensiS.cDescs"
469:         ENDWITH
470:     ENDPROC
471: 
472:     *==========================================================================
473:     * ConfigurarSaida - Adiciona cmd_4c_Ok no cnt_4c_Saida
474:     *==========================================================================
475:     PROTECTED PROCEDURE ConfigurarSaida()
476:         WITH THIS.cnt_4c_Saida
477:             .ADDOBJECT("cmd_4c_Ok", "CommandButton")
478:             WITH .cmd_4c_Ok
479:                 .Left            = 5
480:                 .Top             = 5
481:                 .Width           = 75
482:                 .Height          = 75
483:                 .Caption         = "OK"

*-- Linhas 576 a 594:
576: 
577:                 *-- Coluna 1: O.S. (Nenvs) - leitura, Courier New, Width=98
578:                 WITH .Column1
579:                     .ControlSource = "xNensiS.Nenvs"
580:                     .ReadOnly      = .T.
581:                     .Width         = 98
582:                     .Alignment     = 2
583:                     .Movable       = .F.
584:                     .Resizable     = .F.
585:                     .FontName      = "Courier New"
586:                     .FontBold      = .T.
587:                     .Format        = "L"
588:                     .InputMask     = "9999999999"
589:                     WITH .Header1
590:                         .Caption   = "O.S."
591:                         .Alignment = 2
592:                         .FontName  = "Tahoma"
593:                         .FontSize  = 8
594:                     ENDWITH

*-- Linhas 604 a 645:
604: 
605:                 *-- Coluna 2: Cat. (Cats) - editavel, Width=52
606:                 WITH .Column2
607:                     .ControlSource = "xNensiS.Cats"
608:                     .ReadOnly      = !loc_lEdit
609:                     .Width         = 52
610:                     .Movable       = .F.
611:                     .Resizable     = .F.
612:                     .FontBold      = .T.
613:                     WITH .Header1
614:                         .Caption   = "Cat."
615:                         .Alignment = 2
616:                         .FontName  = "Tahoma"
617:                         .FontSize  = 8
618:                     ENDWITH
619:                     WITH .Text1
620:                         .BorderStyle = 0
621:                         .BackColor   = RGB(255,255,255)
622:                         .ForeColor   = RGB(0,0,0)
623:                         .FontBold    = .T.
624:                         .Margin      = 0
625:                     ENDWITH
626:                 ENDWITH
627: 
628:                 *-- Coluna 3: Valor (Fators) - leitura, Width=110
629:                 WITH .Column3
630:                     .ControlSource = "xNensiS.Fators"
631:                     .ReadOnly      = .T.
632:                     .Width         = 110
633:                     .Alignment     = 1
634:                     .Movable       = .F.
635:                     .Resizable     = .F.
636:                     .FontBold      = .T.
637:                     WITH .Header1
638:                         .Caption   = "Valor"
639:                         .Alignment = 2
640:                         .FontName  = "Tahoma"
641:                         .FontSize  = 8
642:                     ENDWITH
643:                     WITH .Text1
644:                         .BorderStyle = 0
645:                         .BackColor   = RGB(255,255,255)

*-- Linhas 651 a 669:
651: 
652:                 *-- Coluna 4: Quantidade (Qtds) - leitura, Width=110
653:                 WITH .Column4
654:                     .ControlSource = "xNensiS.Qtds"
655:                     .ReadOnly      = .T.
656:                     .Width         = 110
657:                     .Alignment     = 1
658:                     .Movable       = .F.
659:                     .Resizable     = .F.
660:                     .FontBold      = .T.
661:                     WITH .Header1
662:                         .Caption   = "Quantidade"
663:                         .Alignment = 2
664:                         .FontName  = "Tahoma"
665:                         .FontSize  = 8
666:                     ENDWITH
667:                     WITH .Text1
668:                         .BorderStyle = 0
669:                         .BackColor   = RGB(255,255,255)

*-- Linhas 675 a 785:
675: 
676:                 *-- Coluna 5: Conta (Contafs) - editavel, Width=110
677:                 WITH .Column5
678:                     .ControlSource = "xNensiS.Contafs"
679:                     .ReadOnly      = !loc_lEdit
680:                     .Width         = 110
681:                     .Movable       = .F.
682:                     .Resizable     = .F.
683:                     .FontBold      = .T.
684:                     WITH .Header1
685:                         .Caption   = "Conta"
686:                         .Alignment = 2
687:                         .FontName  = "Tahoma"
688:                         .FontSize  = 8
689:                     ENDWITH
690:                     WITH .Text1
691:                         .BorderStyle = 0
692:                         .BackColor   = RGB(255,255,255)
693:                         .ForeColor   = RGB(0,0,0)
694:                         .FontBold    = .T.
695:                         .Margin      = 0
696:                     ENDWITH
697:                 ENDWITH
698: 
699:                 *-- Coluna 6: Grupo (Grupofs) - editavel se opt=2, Width=110
700:                 WITH .Column6
701:                     .ControlSource = "xNensiS.Grupofs"
702:                     .ReadOnly      = !loc_lEdit OR THIS.opt_4c_OptMov.Value <> 2
703:                     .Width         = 110
704:                     .Movable       = .F.
705:                     .Resizable     = .F.
706:                     .FontBold      = .T.
707:                     WITH .Header1
708:                         .Caption   = "Grupo"
709:                         .Alignment = 2
710:                         .FontName  = "Tahoma"
711:                         .FontSize  = 8
712:                     ENDWITH
713:                     WITH .Text1
714:                         .BorderStyle = 0
715:                         .BackColor   = RGB(255,255,255)
716:                         .ForeColor   = RGB(0,0,0)
717:                         .FontBold    = .T.
718:                         .Margin      = 0
719:                     ENDWITH
720:                 ENDWITH
721: 
722:                 *-- Coluna 7: Retrab. (cRetrabs) - editavel, Width=50
723:                 WITH .Column7
724:                     .ControlSource = "xNensiS.cRetrabs"
725:                     .ReadOnly      = !loc_lEdit
726:                     .Width         = 50
727:                     .Movable       = .F.
728:                     .Resizable     = .F.
729:                     .FontBold      = .T.
730:                     WITH .Header1
731:                         .Caption   = "Retrab."
732:                         .Alignment = 2
733:                         .FontName  = "Tahoma"
734:                         .FontSize  = 8
735:                     ENDWITH
736:                     WITH .Text1
737:                         .BorderStyle = 0
738:                         .BackColor   = RGB(255,255,255)
739:                         .ForeColor   = RGB(0,0,0)
740:                         .FontBold    = .T.
741:                         .Margin      = 0
742:                     ENDWITH
743:                 ENDWITH
744: 
745:                 *-- Coluna 8: Valor Retrab. (Coefs) - leitura, Width=110
746:                 WITH .Column8
747:                     .ControlSource = "xNensiS.Coefs"
748:                     .ReadOnly      = .T.
749:                     .Width         = 110
750:                     .Alignment     = 1
751:                     .Movable       = .F.
752:                     .FontBold      = .T.
753:                     WITH .Header1
754:                         .Caption   = "Valor Retrab."
755:                         .Alignment = 2
756:                         .FontName  = "Tahoma"
757:                         .FontSize  = 8
758:                     ENDWITH
759:                     WITH .Text1
760:                         .BorderStyle = 0
761:                         .BackColor   = RGB(255,255,255)
762:                         .ForeColor   = RGB(0,0,0)
763:                         .FontBold    = .T.
764:                         .Margin      = 0
765:                     ENDWITH
766:                 ENDWITH
767: 
768:                 *-- Coluna 9: Valor Indicado (Coefinfs) - leitura, Width=110
769:                 WITH .Column9
770:                     .ControlSource = "xNensiS.Coefinfs"
771:                     .ReadOnly      = .T.
772:                     .Width         = 110
773:                     .Alignment     = 1
774:                     .Movable       = .F.
775:                     .Resizable     = .F.
776:                     .FontBold      = .T.
777:                     WITH .Header1
778:                         .Caption   = "Valor Indicado"
779:                         .Alignment = 2
780:                         .FontName  = "Tahoma"
781:                         .FontSize  = 8
782:                     ENDWITH
783:                     WITH .Text1
784:                         .BorderStyle = 0
785:                         .BackColor   = RGB(255,255,255)

*-- Linhas 942 a 1003:
942:             IF NOT USED("xNensiS") OR EOF("xNensiS")
943:                 RETURN
944:             ENDIF
945:             SELECT xNensiS
946:             loc_cValor = ALLTRIM(NVL(xNensiS.Cats,    ""))
947:             loc_cGrupo = ALLTRIM(NVL(xNensiS.Grupofs, ""))
948:             loc_cConta = ALLTRIM(NVL(xNensiS.Contafs, ""))
949: 
950:             IF EMPTY(loc_cValor)
951:                 RETURN
952:             ENDIF
953: 
954:             loc_lEncontrado = .F.
955: 
956:             IF USED("crSigCdSvc")
957:                 LOCAL loc_nWa
958:                 loc_nWa = SELECT()
959:                 SELECT crSigCdSvc
960:                 SET ORDER TO CaGruCo
961:                 DO CASE
962:                 CASE SEEK(xNensiS.Cats + xNensiS.Grupofs + xNensiS.Contafs)
963:                     loc_lEncontrado = .T.
964:                 CASE SEEK(xNensiS.Cats + xNensiS.Grupofs + SPACE(10))
965:                     loc_lEncontrado = .T.
966:                 CASE SEEK(xNensiS.Cats + SPACE(20))
967:                     loc_lEncontrado = .T.
968:                 ENDCASE
969:                 SELECT (loc_nWa)
970:             ENDIF
971: 
972:             IF !loc_lEncontrado AND USED("crSigCdSvc")
973:                 SELECT * FROM crSigCdSvc ;
974:                     WHERE (RTRIM(Grupos)+RTRIM(Contas) = RTRIM(loc_cGrupo)+RTRIM(loc_cConta)) ;
975:                     OR  (RTRIM(Grupos) = RTRIM(loc_cGrupo) AND LTRIM(RTRIM(Contas)) = "") ;
976:                     OR  (LTRIM(RTRIM(Grupos)) = "") ;
977:                     INTO CURSOR cursor_4c_BuscaCat READWRITE
978: 
979:                 IF USED("cursor_4c_BuscaCat") AND RECCOUNT("cursor_4c_BuscaCat") > 0
980:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
981:                     IF VARTYPE(loc_oBusca) = "O"
982:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCat"
983:                         loc_oBusca.this_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Categoria"
984:                         loc_oBusca.mAddColuna("CCats",  "", "C" + CHR(243) + "digo")
985:                         loc_oBusca.mAddColuna("CDescs", "", "Descri" + CHR(231) + CHR(227) + "o")
986:                         loc_oBusca.Show()
987:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
988:                             SELECT xNensiS
989:                             REPLACE xNensiS.Cats WITH ALLTRIM(cursor_4c_BuscaCat.CCats)
990:                         ENDIF
991:                         loc_oBusca.Release()
992:                     ENDIF
993:                 ENDIF
994:                 IF USED("cursor_4c_BuscaCat")
995:                     USE IN cursor_4c_BuscaCat
996:                 ENDIF
997:             ENDIF
998: 
999:             THIS.this_oBusinessObject.GravarItens(.F.)
1000:             THIS.txt_4c_DescCat.Refresh()
1001:         CATCH TO loc_oErro
1002:             MsgErro(loc_oErro.Message, "Erro em ValidarCategoria")
1003:         ENDTRY

*-- Linhas 1016 a 1068:
1016:             IF NOT USED("xNensiS") OR EOF("xNensiS")
1017:                 RETURN
1018:             ENDIF
1019:             SELECT xNensiS
1020:             loc_cValor = ALLTRIM(NVL(xNensiS.Contafs, ""))
1021:             loc_nNenvs = NVL(xNensiS.Nenvs, 0)
1022: 
1023:             IF EMPTY(loc_cValor)
1024:                 RETURN
1025:             ENDIF
1026: 
1027:             IF THIS.opt_4c_OptMov.Value = 1 AND USED("CsContas")
1028:                 SELECT * FROM CsContas ;
1029:                     WHERE Nenvs = loc_nNenvs ;
1030:                     INTO CURSOR cursor_4c_BuscaConta READWRITE
1031: 
1032:                 IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1033:                     SELECT cursor_4c_BuscaConta
1034:                     INDEX ON Contas TAG Contas
1035: 
1036:                     loc_lEncontrado = SEEK(loc_cValor, "cursor_4c_BuscaConta", "Contas")
1037:                     IF !loc_lEncontrado
1038:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1039:                         IF VARTYPE(loc_oBusca) = "O"
1040:                             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1041:                             loc_oBusca.this_cTitulo = "Cadastro de Contas"
1042:                             loc_oBusca.mAddColuna("Contas", "", "Conta")
1043:                             loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1044:                             loc_oBusca.Show()
1045:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1046:                                 SELECT xNensiS
1047:                                 REPLACE xNensiS.Contafs WITH ALLTRIM(cursor_4c_BuscaConta.Contas), ;
1048:                                         xNensiS.Grupofs WITH ALLTRIM(cursor_4c_BuscaConta.Grupos)
1049:                             ENDIF
1050:                             loc_oBusca.Release()
1051:                         ENDIF
1052:                     ELSE
1053:                         SELECT xNensiS
1054:                         REPLACE xNensiS.Contafs WITH ALLTRIM(cursor_4c_BuscaConta.Contas), ;
1055:                                 xNensiS.Grupofs WITH ALLTRIM(cursor_4c_BuscaConta.Grupos)
1056:                     ENDIF
1057:                 ENDIF
1058:                 IF USED("cursor_4c_BuscaConta")
1059:                     USE IN cursor_4c_BuscaConta
1060:                 ENDIF
1061: 
1062:                 THIS.this_oBusinessObject.GravarItens(.F.)
1063:                 THIS.txt_4c_DescCat.Refresh()
1064:             ELSE
1065:                 IF THIS.opt_4c_OptMov.Value = 2 AND USED("TmpCli")
1066:                 *-- opt=2: lookup em TmpCli (cursor de clientes/contas do form pai)
1067:                 loc_lEncontrado = SEEK(loc_cValor, "TmpCli", "BalCodigo")
1068:                 IF !loc_lEncontrado

*-- Linhas 1075 a 1100:
1075:                         loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1076:                         loc_oBusca.Show()
1077:                         IF loc_oBusca.this_lSelecionou AND USED("TmpCli")
1078:                             SELECT xNensiS
1079:                             REPLACE xNensiS.Contafs WITH ALLTRIM(TmpCli.IClis), ;
1080:                                     xNensiS.Grupofs WITH ALLTRIM(TmpCli.Grupos)
1081:                         ENDIF
1082:                         loc_oBusca.Release()
1083:                     ENDIF
1084:                 ELSE
1085:                     SELECT xNensiS
1086:                     REPLACE xNensiS.Contafs WITH ALLTRIM(TmpCli.IClis), ;
1087:                             xNensiS.Grupofs WITH ALLTRIM(TmpCli.Grupos)
1088:                 ENDIF
1089: 
1090:                 THIS.this_oBusinessObject.GravarItens(.F.)
1091:                 THIS.txt_4c_DescCat.Refresh()
1092:                 ENDIF
1093:             ENDIF
1094:         CATCH TO loc_oErro
1095:             MsgErro(loc_oErro.Message, "Erro em ValidarConta")
1096:         ENDTRY
1097:     ENDPROC
1098: 
1099:     *==========================================================================
1100:     * ValidarGrupo - Valida campo Grupo (Col6) ao sair da celula

*-- Linhas 1113 a 1218:
1113:                 RETURN
1114:             ENDIF
1115: 
1116:             SELECT xNensiS
1117:             loc_cValor = ALLTRIM(NVL(xNensiS.Grupofs, ""))
1118:             IF EMPTY(loc_cValor)
1119:                 RETURN
1120:             ENDIF
1121: 
1122:             loc_lEncontrado = .F.
1123:             IF USED("TmpGccr")
1124:                 loc_lEncontrado = SEEK(loc_cValor, "TmpGccr", "BalCodigo")
1125:             ENDIF
1126: 
1127:             IF !loc_lEncontrado AND USED("TmpGccr")
1128:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1129:                 IF VARTYPE(loc_oBusca) = "O"
1130:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
1131:                     loc_oBusca.this_cTitulo = "Cadastro de Grupos"
1132:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1133:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1134:                     loc_oBusca.Show()
1135:                     IF loc_oBusca.this_lSelecionou AND USED("TmpGccr")
1136:                         SELECT xNensiS
1137:                         REPLACE xNensiS.Grupofs WITH ALLTRIM(TmpGccr.Codigos)
1138:                     ENDIF
1139:                     loc_oBusca.Release()
1140:                 ENDIF
1141:             ELSE
1142:                 IF loc_lEncontrado AND USED("TmpGccr")
1143:                 SELECT xNensiS
1144:                 REPLACE xNensiS.Grupofs WITH ALLTRIM(TmpGccr.Codigos)
1145:                 ENDIF
1146:             ENDIF
1147: 
1148:             THIS.this_oBusinessObject.GravarItens(.F.)
1149:             THIS.txt_4c_DescCat.Refresh()
1150:         CATCH TO loc_oErro
1151:             MsgErro(loc_oErro.Message, "Erro em ValidarGrupo")
1152:         ENDTRY
1153:     ENDPROC
1154: 
1155:     *==========================================================================
1156:     * ValidarRetrabalho - Valida campo Retrab. (Col7) ao sair da celula
1157:     * Lookup em SigPrCrt via SQLEXEC
1158:     *==========================================================================
1159:     PROCEDURE ValidarRetrabalho()
1160:         LOCAL loc_cValor, loc_lEncontrado, loc_cSQL, loc_nResult
1161:         LOCAL loc_oBusca, loc_oErro
1162: 
1163:         TRY
1164:             IF NOT USED("xNensiS") OR EOF("xNensiS")
1165:                 RETURN
1166:             ENDIF
1167:             SELECT xNensiS
1168:             loc_cValor = ALLTRIM(NVL(xNensiS.cRetrabs, ""))
1169:             IF EMPTY(loc_cValor)
1170:                 RETURN
1171:             ENDIF
1172: 
1173:             loc_cSQL = "SELECT Cods, Descrs FROM SigPrCrt " + ;
1174:                        "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1175:                        "  OR LTRIM(RTRIM(Emps)) = ''"
1176: 
1177:             IF USED("cursor_4c_BuscaRetrab")
1178:                 USE IN cursor_4c_BuscaRetrab
1179:             ENDIF
1180:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaRetrab")
1181: 
1182:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaRetrab") > 0
1183:                 SELECT cursor_4c_BuscaRetrab
1184:                 INDEX ON Cods TAG Cods
1185:                 loc_lEncontrado = SEEK(loc_cValor, "cursor_4c_BuscaRetrab", "Cods")
1186:                 IF !loc_lEncontrado
1187:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1188:                     IF VARTYPE(loc_oBusca) = "O"
1189:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaRetrab"
1190:                         loc_oBusca.this_cTitulo = "Retrabalhos"
1191:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
1192:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1193:                         loc_oBusca.Show()
1194:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRetrab")
1195:                             SELECT xNensiS
1196:                             REPLACE xNensiS.cRetrabs WITH ALLTRIM(cursor_4c_BuscaRetrab.Cods)
1197:                         ENDIF
1198:                         loc_oBusca.Release()
1199:                     ENDIF
1200:                 ENDIF
1201:             ELSE
1202:                 MsgAviso("Retrabalho n" + CHR(227) + "o encontrado.", "Aviso")
1203:                 SELECT xNensiS
1204:                 REPLACE xNensiS.cRetrabs WITH ""
1205:             ENDIF
1206: 
1207:             IF USED("cursor_4c_BuscaRetrab")
1208:                 USE IN cursor_4c_BuscaRetrab
1209:             ENDIF
1210: 
1211:             THIS.this_oBusinessObject.GravarItens(.F.)
1212:             THIS.txt_4c_DescCat.Refresh()
1213:         CATCH TO loc_oErro
1214:             MsgErro(loc_oErro.Message, "Erro em ValidarRetrabalho")
1215:         ENDTRY
1216:     ENDPROC
1217: 
1218:     *==========================================================================

*-- Linhas 1343 a 1361:
1343:     *==========================================================================
1344:     * CarregarLista - Religa grid ao cursor xNensiS e reaplica formatacao
1345:     * Chamado apos o form pai atualizar dados em xNensiS sem recriar o form.
1346:     * O ColumnCount e preservado para nao perder headers e ControlSources.
1347:     *==========================================================================
1348:     PROCEDURE CarregarLista()
1349:         LOCAL loc_oErro
1350: 
1351:         TRY
1352:             WITH THIS.grd_4c_Grade
1353:                 .RecordSource = "xNensiS"
1354:                 .Refresh()
1355:             ENDWITH
1356:             THIS.txt_4c_DescCat.Refresh()
1357:             THIS.AjustarIndicadores()
1358:         CATCH TO loc_oErro
1359:             MsgErro(loc_oErro.Message, "Erro em CarregarLista")
1360:         ENDTRY
1361:     ENDPROC

*-- Linhas 1392 a 1429:
1392: 
1393:             *-- Contexto do cabecalho (tmpnens) se existir
1394:             IF USED("tmpnens") AND !EOF("tmpnens")
1395:                 SELECT tmpnens
1396:                 THIS.this_oBusinessObject.this_nNumps = NVL(tmpnens.numps, 0)
1397:                 THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(tmpnens.emps,  ""))
1398:                 THIS.this_oBusinessObject.this_cDopps = ALLTRIM(NVL(tmpnens.dopps, ""))
1399:             ENDIF
1400: 
1401:             *-- Mapeia linha corrente do grid (xNensiS)
1402:             IF USED("xNensiS") AND !EOF("xNensiS")
1403:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor("xNensiS")
1404:             ENDIF
1405:         CATCH TO loc_oErro
1406:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1407:         ENDTRY
1408: 
1409:         RETURN loc_lSucesso
1410:     ENDPROC
1411: 
1412:     *==========================================================================
1413:     * BOParaForm - Reflete estado do BO no form (modo, opcao, refresh do grid)
1414:     * Como o grid esta bindado a xNensiS via ControlSource, basta refrescar
1415:     * os controles vinculados. Tambem ajusta ReadOnly conforme modo do BO.
1416:     *==========================================================================
1417:     PROCEDURE BOParaForm()
1418:         LOCAL loc_oErro
1419: 
1420:         TRY
1421:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1422:                 RETURN
1423:             ENDIF
1424: 
1425:             *-- Sincroniza modo a partir do BO (caso BO tenha mudado)
1426:             IF !EMPTY(THIS.this_oBusinessObject.this_cPcEscolha)
1427:                 THIS.this_cPcEscolha = THIS.this_oBusinessObject.this_cPcEscolha
1428:             ENDIF
1429: 

*-- Linhas 1477 a 1495:
1477: 
1478:             *-- Reposiciona cursor no topo (nao destroi dados - cursor compartilhado)
1479:             IF USED("xNensiS")
1480:                 SELECT xNensiS
1481:                 LOCATE
1482:                 IF !EOF()
1483:                     GO TOP
1484:                 ENDIF
1485:             ENDIF
1486: 
1487:             *-- Esconde indicadores e refresca descricao
1488:             THIS.txt_4c_Botao1.Visible = .F.
1489:             THIS.txt_4c_Botao2.Visible = .F.
1490:             THIS.txt_4c_DescCat.Refresh()
1491:             THIS.grd_4c_Grade.Refresh()
1492:         CATCH TO loc_oErro
1493:             MsgErro(loc_oErro.Message, "Erro em LimparCampos")
1494:         ENDTRY
1495:     ENDPROC

*-- Linhas 1545 a 1563:
1545: 
1546:         TRY
1547:             IF USED("xNensiS")
1548:                 SELECT xNensiS
1549:                 GO TOP
1550:                 *-- Revalida coeficientes (equivalente ao Gravacat inicial)
1551:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1552:                     THIS.this_oBusinessObject.GravarItens(.F.)
1553:                 ENDIF
1554:             ENDIF
1555:             THIS.CarregarLista()
1556:         CATCH TO loc_oErro
1557:             MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
1558:         ENDTRY
1559:     ENDPROC
1560: 
1561:     *==========================================================================
1562:     * BtnEncerrarClick - Fecha o sub-form devolvendo controle ao form pai
1563:     * Equivalente a ThisForm.ParentForm.Enabled = .t. + ThisForm.Release


### BO (C:\4c\projeto\app\classes\SigPdM11BO.prg):
*==============================================================================
* SigPdM11BO.prg - Business Object para Pagamento de Servicos (SIGPDM11)
* Gerencia validacao e atualizacao de itens de servico em pagamento
*
* Form de origem: SigPdM11.SCX (sub-form aberto pelo form pai com parametros)
* Cursor principal: xNensiS (itens do pagamento, gerenciado pela datasession pai)
*==============================================================================
DEFINE CLASS SigPdM11BO AS BusinessBase

    *-- Configuracao da entidade de dados
    this_cTabela      = "xNensiS"
    this_cCampoChave  = "Nenvs"

    *--------------------------------------------------------------------------
    * Campos do cursor xNensiS (itens de servico do pagamento)
    *--------------------------------------------------------------------------
    this_nNenvs       = 0     && Numero do envelope / O.S. (Nenvs)
    this_cCats        = ""    && Codigo da categoria (cats)
    this_nFators      = 0     && Valor do servico (Fators)
    this_nQtds        = 0     && Quantidade (qtds)
    this_cContafs     = ""    && Conta (Contafs)
    this_cGrupofs     = ""    && Grupo (Grupofs)
    this_cCretrabs    = ""    && Codigo do retrabalho (cRetrabs)
    this_nCoefs       = 0     && Valor do servico de retrabalho (Coefs)
    this_nCoefinfs    = 0     && Valor do servico informado (Coefinfs)
    this_lRetrabs     = .F.   && Flag de retrabalho (Retrabs)
    this_lOsRets      = .F.   && Flag de O.S. de retorno (OsRets)
    this_cCdescs      = ""    && Descricao do servico (cDescs)
    this_cGrupofins   = ""    && Grupo financeiro (GrupoFins)
    this_cMoedas      = ""    && Codigo da moeda (Moedas)

    *--------------------------------------------------------------------------
    * Contexto da operacao - cabecalho vindo de tmpnens (leitura apenas)
    *--------------------------------------------------------------------------
    this_nNumps       = 0     && Numero da operacao (tmpnens.numps)
    this_cEmps        = ""    && Empresa (tmpnens.emps)
    this_cDopps       = ""    && Descricao da operacao (tmpnens.dopps)

    *--------------------------------------------------------------------------
    * Estado de execucao
    *--------------------------------------------------------------------------
    this_cPcEscolha   = ""    && Modo atual: INSERIR / ALTERAR (herdado do form pai)
    this_nOptMov      = 1     && Opcao contas: 1=Movimentacao, 2=Cadastro

    *--------------------------------------------------------------------------
    * Dados do servico validado (populados apos busca em crSigCdSvc)
    *--------------------------------------------------------------------------
    this_nCoefSvc     = 0     && Coeficiente do servico (crSigCdSvc.Coefs)
    this_nCoefRetr    = 0     && Coeficiente de retrabalho (crSigCdSvc.CoefRetrs)
    this_cMoedSvc     = ""    && Moeda do servico (crSigCdSvc.CMoeds)
    this_cGruFinSvc   = ""    && Grupo financeiro do servico (crSigCdSvc.GruFins)

    *--------------------------------------------------------------------------
    * Descricao da categoria (populada apos CursorQuery em SigCdCat)
    *--------------------------------------------------------------------------
    this_cDescsCat    = ""

    *--------------------------------------------------------------------------
    * Ultimo valor conhecido do campo Categoria para controle de alteracao
    *--------------------------------------------------------------------------
    this_cAntValueCats = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object de Pagamento de Servicos
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "xNensiS"
        this_cCampoChave = "Nenvs"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor xNensiS para propriedades BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lRet, loc_oErro
        loc_lRet = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nNenvs     = NVL(Nenvs, 0)
                this_cCats      = ALLTRIM(NVL(Cats, ""))
                this_nFators    = NVL(Fators, 0)
                this_nQtds      = NVL(Qtds, 0)
                this_cContafs   = ALLTRIM(NVL(Contafs, ""))
                this_cGrupofs   = ALLTRIM(NVL(Grupofs, ""))
                this_cCretrabs  = ALLTRIM(NVL(cRetrabs, ""))
                this_nCoefs     = NVL(Coefs, 0)
                this_nCoefinfs  = NVL(Coefinfs, 0)
                IF VARTYPE(Retrabs) = "L"
                    this_lRetrabs = NVL(Retrabs, .F.)
                ELSE
                    this_lRetrabs = IIF(NVL(Retrabs, 0) = 1, .T., .F.)
                ENDIF
                IF VARTYPE(OsRets) = "L"
                    this_lOsRets = NVL(OsRets, .F.)
                ELSE
                    this_lOsRets = IIF(NVL(OsRets, 0) = 1, .T., .F.)
                ENDIF
                this_cCdescs    = ALLTRIM(NVL(cDescs, ""))
                this_cGrupofins = ALLTRIM(NVL(GrupoFins, ""))
                this_cMoedas    = ALLTRIM(NVL(Moedas, ""))
                loc_lRet = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarItens - Valida e atualiza dados de servico nos itens do pagamento
    * Equivalente ao Gravacat() do legado
    * par_lChkCoef: .T. = verificar coeficiente (retorna .F. se nao encontrado)
    *               .F. = sempre retornar .T.
    *--------------------------------------------------------------------------
    PROCEDURE GravarItens(par_lChkCoef)
        LOCAL loc_lRet, loc_nRecno, loc_nFatorRetr, loc_lSucesso, loc_oErro

        loc_lRet     = .T.
        loc_lSucesso = .T.

        TRY
            IF INLIST(this_cPcEscolha, "INSERIR", "ALTERAR")
                SELECT xNensiS
                loc_nRecno = RECNO()

                SCAN
                    IF !EMPTY(ALLTRIM(xNensiS.Cats))
                        *-- Validar servico e carregar dados de preco
                        IF THIS.ValidarServico(xNensiS.Cats, xNensiS.GrupoFs, xNensiS.ContaFs)
                            *-- Buscar descricao da categoria via SQL
                            THIS.BuscarDescricaoCategoria(ALLTRIM(xNensiS.Cats))

                            *-- Atualizar valores no cursor com dados do servico
                            SELECT xNensiS
                            REPLACE Fators    WITH this_nCoefSvc, ;
                                    Coefs     WITH this_nCoefRetr, ;
                                    Moedas    WITH this_cMoedSvc, ;
                                    GrupoFins WITH this_cGruFinSvc, ;
                                    cDescs    WITH this_cDescsCat

                            *-- Se tem retrabalho, recalcular Coefs = servico * fator_retrabalho
                            IF !EMPTY(ALLTRIM(xNensiS.cRetrabs))
                                loc_nFatorRetr = THIS.BuscarFatorRetrabalho(ALLTRIM(xNensiS.cRetrabs))
                                IF loc_nFatorRetr > 0
                                    REPLACE Coefs WITH this_nCoefSvc * loc_nFatorRetr IN xNensiS
                                ENDIF
                            ENDIF
                        ELSE
                            loc_lRet = .F.
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT xNensiS
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        IF par_lChkCoef
            RETURN loc_lRet AND loc_lSucesso
        ELSE
            RETURN .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarServico - Valida servico em SigCdSvc e carrega dados de preco
    * Retorna .T. se servico encontrado, .F. se nao encontrado
    * Prioridade: exato (cats+grupo+conta) > grupo+sem conta > so categoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarServico(par_cCats, par_cGrupoFs, par_cContaFs)
        LOCAL loc_lEncontrado, loc_nWa, loc_oErro

        loc_lEncontrado = .F.
        this_nCoefSvc   = 0
        this_nCoefRetr  = 0
        this_cMoedSvc   = ""
        this_cGruFinSvc = ""

        TRY
            IF USED("crSigCdSvc")
                loc_nWa = SELECT()
                SELECT crSigCdSvc
                SET ORDER TO CaGruCo
                DO CASE
                CASE SEEK(par_cCats + par_cGrupoFs + par_cContaFs)
                    loc_lEncontrado = .T.
                CASE SEEK(par_cCats + par_cGrupoFs + SPACE(10))
                    loc_lEncontrado = .T.
                CASE SEEK(par_cCats + SPACE(20))
                    loc_lEncontrado = .T.
                ENDCASE
                IF loc_lEncontrado
                    this_nCoefSvc   = NVL(crSigCdSvc.Coefs, 0)
                    this_nCoefRetr  = NVL(crSigCdSvc.CoefRetrs, 0)
                    this_cMoedSvc   = ALLTRIM(NVL(crSigCdSvc.CMoeds, ""))
                    this_cGruFinSvc = ALLTRIM(NVL(crSigCdSvc.GruFins, ""))
                ENDIF
                SELECT (loc_nWa)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarServico")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoCategoria - Busca descricao da categoria em SigCdCat
    * Popula this_cDescsCat com Desc2s
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarDescricaoCategoria(par_cCodCat)
        LOCAL loc_cSQL, loc_nResult, loc_oErro

        this_cDescsCat = ""

        TRY
            loc_cSQL = "SELECT Desc2s FROM SigCdCat WHERE Cods = " + EscaparSQL(par_cCodCat)

            IF USED("cursor_4c_Cat")
                USE IN cursor_4c_Cat
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cat")

            IF loc_nResult > 0 AND !EOF("cursor_4c_Cat")
                SELECT cursor_4c_Cat
                this_cDescsCat = ALLTRIM(NVL(Desc2s, ""))
            ENDIF

            IF USED("cursor_4c_Cat")
                USE IN cursor_4c_Cat
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BuscarDescricaoCategoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFatorRetrabalho - Busca fator de multiplicacao em SigPrCrt
    * Retorna Fators do retrabalho para calcular Coefs = servico * fator
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarFatorRetrabalho(par_cCodRetrab)
        LOCAL loc_cSQL, loc_nResult, loc_nFator, loc_oErro

        loc_nFator = 0

        TRY
            loc_cSQL = "SELECT Fators FROM SigPrCrt " + ;
                       "WHERE Cods = " + EscaparSQL(par_cCodRetrab) + ;
                       "  AND (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       "  OR LTRIM(RTRIM(Emps)) = '')"

            IF USED("cursor_4c_Retr")
                USE IN cursor_4c_Retr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retr")

            IF loc_nResult > 0 AND !EOF("cursor_4c_Retr")
                SELECT cursor_4c_Retr
                loc_nFator = NVL(Fators, 0)
            ENDIF

            IF USED("cursor_4c_Retr")
                USE IN cursor_4c_Retr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BuscarFatorRetrabalho")
        ENDTRY

        RETURN loc_nFator
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual de xNensiS
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        IF USED("xNensiS") AND !EOF("xNensiS")
            SELECT xNensiS
            RETURN TRANSFORM(xNensiS.Nenvs)
        ENDIF
        RETURN ""
    ENDFUNC

ENDDEFINE

