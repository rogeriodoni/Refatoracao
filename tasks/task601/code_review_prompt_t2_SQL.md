# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IDIOMA, OBSCOMPRAS, DPROS

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
  DeleteMark = .F.
  Column1.ControlSource = "crProdutos.CPros"
  Column2.ControlSource = "crProdutos.Portugues"
  Column3.ControlSource = "crProdutos.Traduzido"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
Select crProdutos
	oProg.Update(.t.)
	lcQuery = [Update SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Update SigCdPro)])
	lcQuery = [Delete From SigPrPrt Where CPros = '] + lcPro + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Delete SigPrPrt)], 10000)
lcQuery = [Select CPros ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPrdTraduz]) < 1)
Select crPrdTraduz
	oProg.Update(.t.)
		lcQuery = [Select a.CPros, a.CGrus, a.CodCors, b.DGrus, b.Mercs, b.MontaGrDs, c.Descs ] + ;
				    [From SigCdPro a ] + ;
				    [Left Join SigCdGrp b On b.CGrus = a.CGrus ] + ;
				    [Left Join SigCdCor c On c.Cods = a.CodCors ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			Select crSigCdDic
			Insert Into crProdutos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
Select crProdutos
		lcQuery = [Select Expressao, Traducao ] + ;
					[From SigCdDic ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1386 linhas total):

*-- Linhas 63 a 82:
63: * REALMENTE faz, sem inventar botao nenhum (PILAR 1) e sem metodo vazio:
64: *
65: *   BtnGravarClick      handler do botao "Atualizar" (legado btnAtualizar,
66: *                       Click = ThisForm.Gravacao -> Update SigCdPro +
67: *                       Delete SigPrPrt + Commit). Nomeado pela ACAO, nao pelo
68: *                       rotulo: o objeto e a Caption continuam "Atualizar".
69: *   BtnCancelarClick    handler do botao "Encerrar" (legado btnSair, que
70: *                       declara Cancel = .T. - eh o botao de cancelar do form,
71: *                       ESC e clique no mesmo caminho).
72: *   BtnSelecionarClick  o "Buscar" desta tela (Fase 7), agora passando os
73: *                       filtros pelo par FormParaBO / BOParaForm.
74: *   FormParaBO          os tres filtros da tela -> BO (PROTECTED: o hook eh
75: *   BOParaForm          PROTECTED em FormBase e VFP9 nao alarga escopo).
76: *                       BOParaForm exibe o espelhamento da faixa feito por
77: *                       SigPrDscBO.NormalizarFiltros() e reaplica os When.
78: *   CarregarLista       Go Top no cursor + Grid.Refresh(), agora tambem no fim
79: *                       de Processamento() e de BtnGravarClick - popular o
80: *                       cursor nao repinta a grade sozinho (CLAUDE.md #21).
81: *   AjustarBotoesPorModo  funil UNICO do Enabled do botao Atualizar, nos
82: *                       quatro pontos em que o legado o liga/desliga (ver o

*-- Linhas 101 a 119:
101: * da grade (que o legado deixa ReadOnly). SigPrDscBO ganhou TemFiltro() e
102: * NormalizarFiltros() (criterio da guarda de filtro vazio e espelhamento da
103: * faixa, transcritos do Click do btnSelecionar) e a chamada a fGravarLog()
104: * (wrapper no-op, utils\fgravarlog.prg) no ramo em que o Delete SigPrPrt
105: * falha, reproduzindo a linha "=fGravarLog([T], Upper(ThisForm.Name), Usuar,
106: * [Falha na Conexao (Traducao)])" do PROCEDURE gravacao original que faltava.
107: *==============================================================================
108: 
109: DEFINE CLASS FormSigPrDsc AS FormBase
110: 
111:     Width        = 800
112:     Height       = 600
113:     AutoCenter   = .T.
114:     TitleBar     = 0
115:     ShowWindow   = 1
116:     WindowType   = 1
117:     ControlBox   = .F.
118:     Closable     = .F.
119:     MaxButton    = .F.

*-- Linhas 174 a 195:
174:                         USE IN cursor_4c_Dicionario
175:                     ENDIF
176: 
177:                     loc_cSQL = "SELECT expressao, traducao FROM SigCdDic " + ;
178:                                "WHERE idioma = " + EscaparSQL(PADR("INGLES", 10)) + " " + ;
179:                                "ORDER BY LEN(expressao) DESC, expressao"
180:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario")
181: 
182:                     IF loc_nResultado < 0
183:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
184:                             "Falha na Conex" + CHR(227) + "o (crSigCdDic)")
185:                         loc_lSucesso = .F.
186:                     ENDIF
187:                 ENDIF
188: 
189:                 IF loc_lSucesso
190:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
191: 
192:                     THIS.ConfigurarPageFrame()
193: 
194:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
195:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

*-- Linhas 283 a 385:
283: 
284:     *--------------------------------------------------------------------------
285:     * ConfigurarGrid - cria o cursor local de produtos traduzidos (equivalente
286:     * ao "Create Cursor crProdutos" do PROCEDURE Load do legado, que roda antes
287:     * do Init) e a grade que o exibe (Grade do legado: RecordSource="crProdutos",
288:     * ColumnCount=3, colunas Codigo/Portugues/Traduzido - Grade.Text1.ControlSource
289:     * "csContas.CprosAnt"/"csContas.CprosNov" do dump SAO artefato de outra
290:     * grade copiada no SCX - csContas nao existe neste form nem tem relacao com
291:     * crProdutos, por isso NAO sao transcritos aqui).
292:     *
293:     * O cursor comeca vazio - quem o povoa eh o botao Selecionar (equivalente
294:     * ao PROCEDURE processamento do legado), acrescentado numa fase seguinte
295:     * do pipeline junto com os campos de filtro getCProsI/getCProsF/getCGrus.
296:     * A grade fica SEMPRE ReadOnly, como o legado (.Grade.ReadOnly = .t. no
297:     * Init - nunca alterado depois em lugar nenhum do codigo original).
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE ConfigurarGrid()
300:         LOCAL loc_oGrid
301: 
302:         IF !USED("cursor_4c_Produtos")
303:             SET NULL ON
304:             CREATE CURSOR cursor_4c_Produtos (CPros C(14), Portugues C(254), ;
305:                 Traduzido C(254), DscCompras M, ObsCompras M)
306:             SET NULL OFF
307:         ENDIF
308: 
309:         THIS.AddObject("grd_4c_Dados", "Grid")
310:         loc_oGrid = THIS.grd_4c_Dados
311:         WITH loc_oGrid
312:             .Top               = 164
313:             .Left              = 15
314:             .Width             = 769
315:             .Height            = 343
316:             .ColumnCount       = 3
317:             .FontSize          = 8
318:             .AllowHeaderSizing = .F.
319:             .AllowRowSizing    = .F.
320:             .DeleteMark        = .F.
321:             .RecordMark        = .F.
322:             .HeaderHeight      = 17
323:             .RowHeight         = 17
324:             .ScrollBars        = 2
325:             .RecordSource      = "cursor_4c_Produtos"
326:             .ReadOnly          = .T.
327:         ENDWITH
328: 
329:         WITH loc_oGrid.Column1
330:             .Width         = 108
331:             .FontSize      = 8
332:             .ControlSource = "cursor_4c_Produtos.CPros"
333:         ENDWITH
334:         WITH loc_oGrid.Column1.Header1
335:             .FontName  = "Tahoma"
336:             .FontSize  = 8
337:             .Alignment = 2
338:             .Caption   = "C" + CHR(243) + "digo"
339:         ENDWITH
340:         WITH loc_oGrid.Column1.Text1
341:             .FontSize    = 8
342:             .BorderStyle = 0
343:             .Margin      = 0
344:             .ForeColor   = RGB(0, 0, 0)
345:             .BackColor   = RGB(255, 255, 255)
346:         ENDWITH
347: 
348:         WITH loc_oGrid.Column2
349:             .Width         = 290
350:             .FontSize      = 8
351:             .ControlSource = "cursor_4c_Produtos.Portugues"
352:         ENDWITH
353:         WITH loc_oGrid.Column2.Header1
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .Alignment = 2
357:             .Caption   = "Portugu" + CHR(234) + "s"
358:         ENDWITH
359:         WITH loc_oGrid.Column2.Text1
360:             .FontSize    = 8
361:             .BorderStyle = 0
362:             .Margin      = 0
363:             .ForeColor   = RGB(0, 0, 0)
364:             .BackColor   = RGB(255, 255, 255)
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column3
368:             .Width         = 339
369:             .FontSize      = 8
370:             .ControlSource = "cursor_4c_Produtos.Traduzido"
371:         ENDWITH
372:         WITH loc_oGrid.Column3.Header1
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .Alignment = 2
376:             .Caption   = "Traduzido"
377:         ENDWITH
378:         WITH loc_oGrid.Column3.Text1
379:             .FontSize    = 8
380:             .BorderStyle = 0
381:             .Margin      = 0
382:             .ForeColor   = RGB(0, 0, 0)
383:             .BackColor   = RGB(255, 255, 255)
384:         ENDWITH
385:     ENDPROC

*-- Linhas 434 a 452:
434:         ENDWITH
435:         *-- Handler nomeado pela ACAO, nao pelo objeto legado: o Click do
436:         *-- btnAtualizar chama ThisForm.Gravacao, cujo corpo eh o
437:         *-- Update SigCdPro + Delete SigPrPrt + Commit. Ou seja, "Atualizar"
438:         *-- eh o botao de GRAVAR desta tela. O objeto e a Caption continuam
439:         *-- "Atualizar" (PILAR 1 - o usuario ve o mesmo botao de antes); so o
440:         *-- nome interno do metodo descreve o que ele faz (PILAR 3).
441:         BINDEVENT(THIS.cmd_4c_BtnAtualizar, "Click", THIS, "BtnGravarClick")
442: 
443:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
444:         WITH THIS.cmd_4c_BtnSair
445:             .Top        = 3
446:             .Left       = 725
447:             .Width      = 75
448:             .Height     = 75
449:             .Caption    = "Encerrar"
450:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
451:             .Cancel     = .T.
452:             .FontName   = "Comic Sans MS"

*-- Linhas 480 a 498:
480:     *
481:     * Say3/Say1/Say2 sao classe "say" pura no dump (nao declaram Width nem
482:     * Alignment) - AutoSize = .T. + Alignment = 0, sem inventar caixa (regra
483:     * #23). Format = "K" do legado equivale a SelectOnEntry = .T. em VFP9
484:     * (substitui o texto ao entrar no campo, nao restringe o que pode ser
485:     * digitado - por isso NAO e o Format = "M" da regra #24).
486:     *
487:     * FASE 6/8: acrescenta lbl_4c_Grupo/txt_4c_CGrus (Say2/getCGrus) e liga
488:     * os 3 lookups via BINDEVENT (ver ValidarCProsI/ValidarCProsF/
489:     * ValidarCGrus mais abaixo).
490:     *--------------------------------------------------------------------------
491:     PROTECTED PROCEDURE ConfigurarCampos()
492:         THIS.AddObject("lbl_4c_ProdutosDe", "Label")
493:         WITH THIS.lbl_4c_ProdutosDe
494:             .AutoSize  = .T.
495:             .Alignment = 0
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .FontBold  = .T.

*-- Linhas 511 a 529:
511:             .Top           = 135
512:             .Width         = 108
513:             .MaxLength     = 14
514:             .SelectOnEntry = .T.
515:             .Value         = ""
516:         ENDWITH
517: 
518:         THIS.AddObject("lbl_4c_Ate", "Label")
519:         WITH THIS.lbl_4c_Ate
520:             .AutoSize  = .T.
521:             .Alignment = 0
522:             .FontName  = "Tahoma"
523:             .FontSize  = 8
524:             .FontBold  = .T.
525:             .BackStyle = 0
526:             .ForeColor = RGB(90, 90, 90)
527:             .Left      = 345
528:             .Top       = 138
529:             .Caption   = "at" + CHR(233)

*-- Linhas 537 a 555:
537:             .Top           = 135
538:             .Width         = 108
539:             .MaxLength     = 14
540:             .SelectOnEntry = .T.
541:             .Value         = ""
542:         ENDWITH
543: 
544:         THIS.AddObject("lbl_4c_Grupo", "Label")
545:         WITH THIS.lbl_4c_Grupo
546:             .AutoSize  = .T.
547:             .Alignment = 0
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .FontBold  = .T.
551:             .BackStyle = 0
552:             .ForeColor = RGB(90, 90, 90)
553:             .Left      = 505
554:             .Top       = 138
555:             .Caption   = "Grupo de Produto :"

*-- Linhas 563 a 581:
563:             .Top           = 135
564:             .Width         = 31
565:             .MaxLength     = 3
566:             .SelectOnEntry = .T.
567:             .Value         = ""
568:         ENDWITH
569: 
570:         *-- Lookups (fwbuscaext no legado) - Enter(13)/Tab(9)/F4(115) e
571:         *-- duplo-clique disparam o mesmo picker que o Valid do legado abria
572:         *-- ao sair do campo.
573:         BINDEVENT(THIS.txt_4c_CProsI, "KeyPress", THIS, "CProsIKeyPress")
574:         BINDEVENT(THIS.txt_4c_CProsI, "DblClick", THIS, "CProsIDblClick")
575: 
576:         BINDEVENT(THIS.txt_4c_CProsF, "KeyPress", THIS, "CProsFKeyPress")
577:         BINDEVENT(THIS.txt_4c_CProsF, "DblClick", THIS, "CProsFDblClick")
578: 
579:         BINDEVENT(THIS.txt_4c_CGrus, "KeyPress", THIS, "CGrusKeyPress")
580:         BINDEVENT(THIS.txt_4c_CGrus, "DblClick", THIS, "CGrusDblClick")
581: 

*-- Linhas 739 a 787:
739: 
740:         TRY
741:             IF USED("cursor_4c_BuscaPro")
742:                 USE IN SELECT("cursor_4c_BuscaPro")
743:             ENDIF
744: 
745:             *-- 1) match EXATO (o que o Init do fwbuscaext legado fazia antes
746:             *--    de decidir se abria o picker)
747:             loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro " + ;
748:                        "WHERE cpros = " + EscaparSQL(loc_cValor)
749:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
750: 
751:             IF loc_nRes > 0 AND USED("cursor_4c_BuscaPro") AND RECCOUNT("cursor_4c_BuscaPro") = 1
752:                 SELECT cursor_4c_BuscaPro
753:                 GO TOP
754:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaPro.cpros)
755:                 loc_lOk = .T.
756:             ELSE
757:                 *-- 2) busca por PREFIXO em codigo OU descricao
758:                 IF USED("cursor_4c_BuscaPro")
759:                     USE IN SELECT("cursor_4c_BuscaPro")
760:                 ENDIF
761:                 loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro " + ;
762:                            "WHERE (cpros LIKE " + EscaparSQL(loc_cValor + "%") + ;
763:                            " OR dpros LIKE " + EscaparSQL(loc_cValor + "%") + ") " + ;
764:                            "ORDER BY cpros"
765:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
766: 
767:                 *-- 3) fallback SHOW-ALL: prefixo sem match abre a lista toda,
768:                 *--    em vez de um picker vazio
769:                 IF loc_nRes > 0 AND USED("cursor_4c_BuscaPro") AND RECCOUNT("cursor_4c_BuscaPro") = 0
770:                     USE IN SELECT("cursor_4c_BuscaPro")
771:                     loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro ORDER BY cpros"
772:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
773:                 ENDIF
774: 
775:                 IF loc_nRes < 0
776:                     MsgErro("Erro ao consultar produtos." + CHR(13) + CapturarErroSQL(), ;
777:                             "Erro SQL")
778:                 ELSE
779:                     IF !USED("cursor_4c_BuscaPro") OR RECCOUNT("cursor_4c_BuscaPro") = 0
780:                         MsgAviso("Nenhum produto cadastrado.", loc_cTitulo)
781:                     ELSE
782:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
783:                         IF VARTYPE(loc_oBusca) = "O"
784:                             loc_oBusca.this_cCursorDestino  = "cursor_4c_BuscaPro"
785:                             loc_oBusca.this_cCampoCodigo    = "cpros"
786:                             loc_oBusca.this_cCampoDescricao = "dpros"
787:                             loc_oBusca.this_cTitulo         = loc_cTitulo

*-- Linhas 797 a 834:
797:                             loc_oBusca.Show()
798: 
799:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
800:                                 SELECT cursor_4c_BuscaPro
801:                                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaPro.cpros)
802:                                 loc_lOk = .T.
803:                             ENDIF
804: 
805:                             loc_oBusca.Release()
806:                         ENDIF
807:                     ENDIF
808:                 ENDIF
809:             ENDIF
810: 
811:             IF USED("cursor_4c_BuscaPro")
812:                 USE IN SELECT("cursor_4c_BuscaPro")
813:             ENDIF
814:         CATCH TO loc_oErro
815:             MsgErro(loc_oErro.Message + CHR(13) + ;
816:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
817:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupProduto")
818:             IF USED("cursor_4c_BuscaPro")
819:                 USE IN SELECT("cursor_4c_BuscaPro")
820:             ENDIF
821:         ENDTRY
822: 
823:         *-- fora do ENDTRY para liberar a guarda tambem quando o CATCH dispara
824:         THIS.this_lEmLookup = .F.
825: 
826:         RETURN loc_lOk
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * AbrirLookupGrupo - picker de grupo de produto, equivalente ao
831:     *   CreateObject([fwbuscaext], ..., [SigCdGrp], [crListaRemota], [CGrus],
832:     *                This.Value, [Selecao], 1000)
833:     * do PROCEDURE Valid de getCGrus, com as DUAS colunas que o legado
834:     * declara (mAddColuna CGrus/DGrus).

*-- Linhas 850 a 896:
850: 
851:         TRY
852:             IF USED("cursor_4c_BuscaGru")
853:                 USE IN SELECT("cursor_4c_BuscaGru")
854:             ENDIF
855: 
856:             *-- 1) match EXATO
857:             loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp " + ;
858:                        "WHERE cgrus = " + EscaparSQL(loc_cValor)
859:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
860: 
861:             IF loc_nRes > 0 AND USED("cursor_4c_BuscaGru") AND RECCOUNT("cursor_4c_BuscaGru") = 1
862:                 SELECT cursor_4c_BuscaGru
863:                 GO TOP
864:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
865:                 loc_lOk = .T.
866:             ELSE
867:                 *-- 2) busca por PREFIXO em codigo OU descricao
868:                 IF USED("cursor_4c_BuscaGru")
869:                     USE IN SELECT("cursor_4c_BuscaGru")
870:                 ENDIF
871:                 loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp " + ;
872:                            "WHERE (cgrus LIKE " + EscaparSQL(loc_cValor + "%") + ;
873:                            " OR dgrus LIKE " + EscaparSQL(loc_cValor + "%") + ") " + ;
874:                            "ORDER BY cgrus"
875:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
876: 
877:                 *-- 3) fallback SHOW-ALL
878:                 IF loc_nRes > 0 AND USED("cursor_4c_BuscaGru") AND RECCOUNT("cursor_4c_BuscaGru") = 0
879:                     USE IN SELECT("cursor_4c_BuscaGru")
880:                     loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus"
881:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
882:                 ENDIF
883: 
884:                 IF loc_nRes < 0
885:                     MsgErro("Erro ao consultar grupos de produto." + CHR(13) + ;
886:                             CapturarErroSQL(), "Erro SQL")
887:                 ELSE
888:                     IF !USED("cursor_4c_BuscaGru") OR RECCOUNT("cursor_4c_BuscaGru") = 0
889:                         MsgAviso("Nenhum grupo de produto cadastrado.", loc_cTitulo)
890:                     ELSE
891:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
892:                         IF VARTYPE(loc_oBusca) = "O"
893:                             loc_oBusca.this_cCursorDestino  = "cursor_4c_BuscaGru"
894:                             loc_oBusca.this_cCampoCodigo    = "cgrus"
895:                             loc_oBusca.this_cCampoDescricao = "dgrus"
896:                             loc_oBusca.this_cTitulo         = loc_cTitulo

*-- Linhas 904 a 941:
904:                             loc_oBusca.Show()
905: 
906:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
907:                                 SELECT cursor_4c_BuscaGru
908:                                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
909:                                 loc_lOk = .T.
910:                             ENDIF
911: 
912:                             loc_oBusca.Release()
913:                         ENDIF
914:                     ENDIF
915:                 ENDIF
916:             ENDIF
917: 
918:             IF USED("cursor_4c_BuscaGru")
919:                 USE IN SELECT("cursor_4c_BuscaGru")
920:             ENDIF
921:         CATCH TO loc_oErro
922:             MsgErro(loc_oErro.Message + CHR(13) + ;
923:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
924:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
925:             IF USED("cursor_4c_BuscaGru")
926:                 USE IN SELECT("cursor_4c_BuscaGru")
927:             ENDIF
928:         ENDTRY
929: 
930:         THIS.this_lEmLookup = .F.
931: 
932:         RETURN loc_lOk
933:     ENDPROC
934: 
935:     *--------------------------------------------------------------------------
936:     * AtualizarExclusividadeFiltros - reproduz os PROCEDURE When do legado:
937:     *   getCProsI.When -> Return Empty(ThisForm.getCGrus.Value)
938:     *   getCProsF.When -> Return Empty(ThisForm.getCGrus.Value)
939:     *   getCGrus.When  -> Return Empty(ThisForm.getCProsI.Value) And
940:     *                            Empty(ThisForm.getCProsF.Value)
941:     *

*-- Linhas 971 a 989:
971:     *--------------------------------------------------------------------------
972:     PROCEDURE CarregarLista()
973:         IF USED("cursor_4c_Produtos")
974:             SELECT cursor_4c_Produtos
975:             GO TOP
976:         ENDIF
977: 
978:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
979:             THIS.grd_4c_Dados.Refresh()
980:         ENDIF
981:     ENDPROC
982: 
983:     *--------------------------------------------------------------------------
984:     * BtnSelecionarClick - equivalente ao PROCEDURE Click do btnSelecionar
985:     * legado. Desabilita o botao de gravar, valida que ao menos um filtro foi
986:     * informado, completa a faixa de produto quando so uma ponta foi digitada
987:     * (o legado espelha o inicio no fim e vice-versa) e dispara
988:     * THIS.Processamento().
989:     *

*-- Linhas 1019 a 1243:
1019:     * Processamento - equivalente ao PROCEDURE processamento do legado. Monta
1020:     * a lista de produtos candidatos (por faixa CPros OU por CGrus - nunca os
1021:     * dois, mesma exclusividade de AtualizarExclusividadeFiltros), e para cada
1022:     * um consulta Grupo (SigCdGrp) e Cor (SigCdCor) via LEFT JOIN a partir de
1023:     * SigCdPro.
1024:     *
1025:     * DESVIO NENHUM - TRANSCRICAO LITERAL (regra #17): no metodo original a
1026:     * variavel lcDes eh inicializada com [] logo no comeco do laco e NUNCA
1027:     * reatribuida antes do "If Not Empty(lcDes)" - lcIni/lnGrD (calculados a
1028:     * partir do LEFT JOIN) nao alimentam lcDes em lugar nenhum do codigo
1029:     * fonte extraido (SigPrDsc_form_codigo_fonte.txt, metodo completo, sem
1030:     * truncamento). Ou seja, o bloco de traducao e o "Insert Into crProdutos"
1031:     * sao CODIGO MORTO no proprio legado - o processamento sempre roda (monta
1032:     * cursor_4c_PrdTraduz, consulta Grupo/Cor de cada produto) mas nunca insere
1033:     * linha em cursor_4c_Produtos, e por isso cmd_4c_BtnAtualizar nunca fica
1034:     * habilitado por este caminho. Mantido identico ao legado (PILAR 1) -
1035:     * "reescrever" essa lacuna inventaria regra de negocio que nao existe em
1036:     * lugar nenhum do sistema original.
1037:     *--------------------------------------------------------------------------
1038:     PROTECTED PROCEDURE Processamento()
1039:         LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cSQL, loc_nResultado, loc_oProg
1040:         LOCAL loc_cPro, loc_cDes, loc_cIni, loc_nGrD, loc_cIng, loc_oErro
1041: 
1042:         IF USED("cursor_4c_Produtos")
1043:             SELECT cursor_4c_Produtos
1044:             ZAP
1045:         ENDIF
1046: 
1047:         *-- Filtros vem do BO (postos la por FormParaBO e ja espelhados por
1048:         *-- NormalizarFiltros), nao relidos da tela. O PADR eh aplicado SO
1049:         *-- aqui, na montagem do SQL, exatamente como o legado
1050:         *-- (lcPrI = Padr(getCProsI.Value, 14) / lcGru = Padr(getCGrus.Value, 3));
1051:         *-- as properties do BO ficam sem padding para que BOParaForm nao
1052:         *-- devolva espacos a direita para dentro dos TextBox.
1053:         loc_cPrI = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsI), 14)
1054:         loc_cPrF = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsF), 14)
1055:         loc_cGru = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCGrus), 3)
1056: 
1057:         IF !EMPTY(loc_cGru)
1058:             loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cgrus = " + EscaparSQL(loc_cGru) + ;
1059:                        " ORDER BY cpros"
1060:         ELSE
1061:             loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros BETWEEN " + EscaparSQL(loc_cPrI) + ;
1062:                        " AND " + EscaparSQL(loc_cPrF) + " ORDER BY cpros"
1063:         ENDIF
1064: 
1065:         IF USED("cursor_4c_PrdTraduz")
1066:             USE IN SELECT("cursor_4c_PrdTraduz")
1067:         ENDIF
1068: 
1069:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrdTraduz")
1070:         IF loc_nResultado < 0
1071:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1072:                 "Falha na Conex" + CHR(227) + "o (crPrdTraduz)")
1073:             RETURN
1074:         ENDIF
1075: 
1076:         IF !USED("cursor_4c_PrdTraduz") OR RECCOUNT("cursor_4c_PrdTraduz") = 0
1077:             RETURN
1078:         ENDIF
1079: 
1080:         TRY
1081:             loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
1082:                 RECCOUNT("cursor_4c_PrdTraduz"))
1083:             loc_oProg.Show()
1084: 
1085:             SELECT cursor_4c_PrdTraduz
1086:             GO TOP
1087:             SCAN
1088:                 loc_cPro = ALLTRIM(cursor_4c_PrdTraduz.cpros)
1089: 
1090:                 loc_oProg.Update("Produto : " + loc_cPro, .T.)
1091: 
1092:                 IF !EMPTY(loc_cPro)
1093:                     loc_cDes = ""
1094: 
1095:                     IF USED("cursor_4c_LocalPro")
1096:                         USE IN SELECT("cursor_4c_LocalPro")
1097:                     ENDIF
1098: 
1099:                     loc_cSQL = "SELECT a.cpros, a.cgrus, a.codcors, b.dgrus, b.mercs, b.montagrds, c.descs " + ;
1100:                                "FROM SigCdPro a " + ;
1101:                                "LEFT JOIN SigCdGrp b ON b.cgrus = a.cgrus " + ;
1102:                                "LEFT JOIN SigCdCor c ON c.cods = a.codcors " + ;
1103:                                "WHERE a.cpros = " + EscaparSQL(loc_cPro)
1104: 
1105:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
1106:                     IF loc_nResultado < 0
1107:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1108:                             "Falha na Conex" + CHR(227) + "o (LocalPro)")
1109:                         EXIT
1110:                     ENDIF
1111: 
1112:                     IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
1113:                         SELECT cursor_4c_LocalPro
1114:                         GO TOP
1115:                         loc_cIni = ALLTRIM(ALLTRIM(TratarNulo(dgrus, "")) + " " + ALLTRIM(TratarNulo(descs, "")))
1116:                         loc_nGrD = TratarNulo(montagrds, 0)
1117:                     ENDIF
1118: 
1119:                     *-- legado: lcDes permanece vazio ate aqui (ver comentario
1120:                     *-- do cabecalho do metodo) - bloco transcrito tal como
1121:                     *-- esta no fonte original, mesmo nunca executando.
1122:                     IF !EMPTY(loc_cDes)
1123:                         loc_cIng = loc_cDes
1124: 
1125:                         IF USED("cursor_4c_Dicionario")
1126:                             SELECT cursor_4c_Dicionario
1127:                             GO TOP
1128:                             SCAN
1129:                                 loc_cIng = STRTRAN(loc_cIng, ALLTRIM(cursor_4c_Dicionario.expressao), ;
1130:                                     ALLTRIM(cursor_4c_Dicionario.traducao))
1131:                             ENDSCAN
1132:                         ENDIF
1133: 
1134:                         loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
1135:                         loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")
1136: 
1137:                         INSERT INTO cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
1138:                             VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
1139: 
1140:                         THIS.grd_4c_Dados.Refresh()
1141:                     ENDIF
1142:                 ENDIF
1143:             ENDSCAN
1144: 
1145:             loc_oProg.Complete(.T.)
1146:             loc_oProg.Release()
1147: 
1148:             IF USED("cursor_4c_LocalPro")
1149:                 USE IN SELECT("cursor_4c_LocalPro")
1150:             ENDIF
1151:             IF USED("cursor_4c_PrdTraduz")
1152:                 USE IN SELECT("cursor_4c_PrdTraduz")
1153:             ENDIF
1154: 
1155:             *-- legado: Select crProdutos / Go Top / If Not Eof() ->
1156:             *-- btnAtualizar.Enabled = .t. Mesmo criterio, pelo funil: a
1157:             *-- selecao terminou, entao o que decide eh haver linha na lista.
1158:             THIS.this_lListaPronta = .T.
1159:             THIS.CarregarLista()
1160:             THIS.AjustarBotoesPorModo()
1161:         CATCH TO loc_oErro
1162:             MsgErro(loc_oErro.Message + CHR(13) + ;
1163:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1164:                 "Procedure: " + loc_oErro.Procedure, "Erro em Processamento")
1165:             IF USED("cursor_4c_LocalPro")
1166:                 USE IN SELECT("cursor_4c_LocalPro")
1167:             ENDIF
1168:             IF USED("cursor_4c_PrdTraduz")
1169:                 USE IN SELECT("cursor_4c_PrdTraduz")
1170:             ENDIF
1171:         ENDTRY
1172:     ENDPROC
1173: 
1174:     *--------------------------------------------------------------------------
1175:     * BtnGravarClick - handler do botao "Atualizar" (legado btnAtualizar, cujo
1176:     * Click eh "ThisForm.Gravacao"). Nomeado pela ACAO que executa - gravar -,
1177:     * nao pelo rotulo do botao: o objeto e a Caption continuam "Atualizar"
1178:     * (PILAR 1), o nome do metodo descreve o efeito (PILAR 3).
1179:     *
1180:     * Grava as descricoes traduzidas de volta em SigCdPro e
1181:     * remove cada produto da fila SigPrPrt (equivalente ao PROCEDURE gravacao
1182:     * do legado). Percorre cursor_4c_Produtos linha a linha, delegando a
1183:     * gravacao de cada uma ao Business Object (EditarRegistro+CarregarDoCursor+
1184:     * Salvar) - a UPDATE/DELETE/COMMIT/ROLLBACK real esta em
1185:     * SigPrDscBO.Atualizar(). Interrompe no primeiro erro, como o legado
1186:     * (Scan While llOks).
1187:     *--------------------------------------------------------------------------
1188:     PROCEDURE BtnGravarClick()
1189:         LOCAL loc_lOk, loc_oProg, loc_cPro, loc_nTotal, loc_oErro
1190: 
1191:         IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1192:             RETURN
1193:         ENDIF
1194: 
1195:         loc_lOk = .T.
1196:         loc_nTotal = RECCOUNT("cursor_4c_Produtos")
1197: 
1198:         TRY
1199:             loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
1200:             loc_oProg.Show()
1201: 
1202:             SELECT cursor_4c_Produtos
1203:             GO TOP
1204:             SCAN WHILE loc_lOk
1205:                 loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)
1206: 
1207:                 loc_oProg.Update("Produto : " + loc_cPro, .T.)
1208: 
1209:                 THIS.this_oBusinessObject.EditarRegistro()
1210:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")
1211: 
1212:                 IF !THIS.this_oBusinessObject.Salvar()
1213:                     loc_lOk = .F.
1214:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1215:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o produto " + ;
1216:                             loc_cPro + ".", "Erro")
1217:                     ENDIF
1218:                 ENDIF
1219:             ENDSCAN
1220: 
1221:             loc_oProg.Complete(.T.)
1222:             loc_oProg.Release()
1223: 
1224:             IF loc_lOk
1225:                 MsgInfo("Foram Gravados " + ALLTRIM(STR(loc_nTotal, 10)) + " Produtos!!!", ;
1226:                     "Processamento Conclu" + CHR(237) + "do!!!")
1227: 
1228:                 *-- Gravou: os produtos sairam da fila SigPrPrt (Delete no BO),
1229:                 *-- logo nao ha mais nada a gravar nesta lista. A GRADE CONTINUA
1230:                 *-- exibindo as linhas gravadas - o legado tambem nao limpa
1231:                 *-- crProdutos aqui, so desliga o botao, e essa confirmacao
1232:                 *-- visual faz parte da UX (PILAR 1).
1233:                 THIS.this_lListaPronta = .F.
1234:             ENDIF
1235: 
1236:             THIS.CarregarLista()
1237:             THIS.AjustarBotoesPorModo()
1238:         CATCH TO loc_oErro
1239:             MsgErro(loc_oErro.Message + CHR(13) + ;
1240:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1241:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnGravarClick")
1242:         ENDTRY
1243:     ENDPROC

*-- Linhas 1275 a 1293:
1275:     *      selecao anterior, entao contar linhas devolveria .T. e inverteria
1276:     *      o comportamento do legado)
1277:     *   fim de Processamento()     pronta, conta as linhas   -> .T. se houver
1278:     *     (legado: Select crProdutos / Go Top / If Not Eof())
1279:     *   apos gravar com sucesso    deixa de estar pronta     -> .F.
1280:     *     (legado: nada a regravar; a grade CONTINUA com as linhas gravadas)
1281:     *
1282:     * Concentrar isso aqui eh o que impede o defeito da CLAUDE.md #40 - estado
1283:     * desligado num caminho e nunca religado no caminho de volta.
1284:     *
1285:     * Nao ha modo INCLUIR/ALTERAR/VISUALIZAR nesta tela (o legado SIGPRDSC.SCX
1286:     * nao tem CRUD nem Page1/Page2): o parametro de modo do template CRUD nao
1287:     * existe aqui, e this_cModoAtual nao eh consultado. O nome canonico eh
1288:     * mantido porque eh o que o harness TesteAutomatico.prg procura.
1289:     *--------------------------------------------------------------------------
1290:     PROCEDURE AjustarBotoesPorModo()
1291:         LOCAL loc_lTemLinha
1292: 
1293:         loc_lTemLinha = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*====================================================================
* SigPrDscBO.prg
*
* Business Object para SigPrDsc (Montagem de Descricao de Produtos)
* Tabela principal atualizada: SigCdPro (DscCompras, ObsCompras, DPros)
* Tabelas auxiliares: SigCdGrp, SigCdCor, SigCdDic, SigPrPrt
*
* Form OPERACIONAL: processa produtos sem traducao (fila em SigPrPrt),
* monta a descricao concatenando Grupo + Cor, traduz via dicionario
* (SigCdDic) e grava DscCompras/ObsCompras/DPros de volta em SigCdPro.
*====================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

	*-- Tabela principal e chave (para auditoria/BusinessBase)
	this_cTabela = "SigCdPro"
	this_cCampoChave = "CPros"

	*-- Filtro de faixa de produtos (telas getCProsI / getCProsF)
	this_cCProsI = ""
	this_cCProsF = ""

	*-- Filtro de grupo de produtos (tela getCGrus)
	this_cCGrus = ""

	*-- Produto corrente sendo processado/gravado (crProdutos.CPros)
	this_cCPros = ""

	*-- Descricao em portugues montada (Grupo + Cor) - crProdutos.Portugues
	this_cPortugues = ""

	*-- Descricao traduzida (ingles) - crProdutos.Traduzido
	this_cTraduzido = ""

	*-- Campos gravados de volta em SigCdPro.DscCompras / ObsCompras
	this_cDscCompras = ""
	this_cObsCompras = ""

	*-- Descricao final formatada gravada em SigCdPro.DPros
	this_cDPros = ""

	*-- Total de produtos processados/gravados (para mensagens de resumo)
	this_nTotalProcessados = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "CPros"

		THIS.this_cCProsI = ""
		THIS.this_cCProsF = ""
		THIS.this_cCGrus = ""
		THIS.this_cCPros = ""
		THIS.this_cPortugues = ""
		THIS.this_cTraduzido = ""
		THIS.this_cDscCompras = ""
		THIS.this_cObsCompras = ""
		THIS.this_cDPros = ""
		THIS.this_nTotalProcessados = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega as propriedades do produto corrente a
	* partir de uma linha do cursor crProdutos (estrutura do legado:
	* CPros c(14), Portugues c(254), Traduzido c(254), DscCompras m,
	* ObsCompras m). THIS.this_cDPros e recalculado aqui pela MESMA
	* formula do PROCEDURE gravacao legado (Padr(Alltrim(Portugues),40)),
	* pois DPros nao existe como coluna no cursor - e sempre derivado.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCPros      = ALLTRIM(TratarNulo(CPros, ""))
			THIS.this_cPortugues  = TratarNulo(Portugues, "")
			THIS.this_cTraduzido  = TratarNulo(Traduzido, "")
			THIS.this_cDscCompras = TratarNulo(DscCompras, "")
			THIS.this_cObsCompras = TratarNulo(ObsCompras, "")
			THIS.this_cDPros      = PADR(ALLTRIM(THIS.this_cPortugues), 40)

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* TemFiltro - .T. quando ao menos um dos tres filtros da tela foi
	* informado. Eh o criterio da primeira guarda do PROCEDURE Click do
	* btnSelecionar legado:
	*
	*   If Empty(getCProsI.Value) And Empty(getCProsF.Value) And
	*      Empty(getCGrus.Value) ... Return .f.
	*
	* So o CRITERIO vem para ca - a mensagem e o SetFocus continuam no
	* Form, que eh onde moram (sao UI).
	*====================================================================
	FUNCTION TemFiltro()
		RETURN !EMPTY(ALLTRIM(THIS.this_cCProsI)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCProsF)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCGrus))
	ENDFUNC

	*====================================================================
	* NormalizarFiltros - completa a faixa de produto quando o usuario
	* digitou apenas uma das pontas. TRANSCRICAO LITERAL do PROCEDURE
	* Click do btnSelecionar legado (regra #17 - criterio do legado nao
	* se reescreve):
	*
	*   If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
	*       getCProsF.Value = getCProsI.Value
	*   If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
	*       getCProsI.Value = getCProsF.Value
	*
	* NAO mexe no grupo: a exclusividade faixa-x-grupo eh feita pelos
	* PROCEDURE Valid dos campos (Form.ValidarCProsI/ValidarCProsF/
	* ValidarCGrus), NAO pelo botao Selecionar - o legado tambem nao a
	* aplica aqui, e aplicar limparia filtro que o usuario informou.
	*
	* Guarda os valores SEM padding de proposito: quem monta o SQL aplica
	* o Padr(...,14) / Padr(...,3) do legado. Padded aqui, o BOParaForm
	* devolveria espacos a direita para dentro dos TextBox da tela.
	*====================================================================
	PROCEDURE NormalizarFiltros()
		THIS.this_cCProsI = ALLTRIM(THIS.this_cCProsI)
		THIS.this_cCProsF = ALLTRIM(THIS.this_cCProsF)
		THIS.this_cCGrus  = ALLTRIM(THIS.this_cCGrus)

		*-- legado: If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
		IF !EMPTY(THIS.this_cCProsI) AND EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsF = THIS.this_cCProsI
		ENDIF

		*-- legado: If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
		IF EMPTY(THIS.this_cCProsI) AND !EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsI = THIS.this_cCProsF
		ENDIF
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave primaria do produto em processamento
	* (usada por RegistrarAuditoria).
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCPros)
	ENDFUNC

	*====================================================================
	* Inserir - Este form OPERACIONAL nunca cria produto novo em SigCdPro
	* (o cadastro de produtos e feito em outra tela; aqui so se traduz e
	* regrava a descricao de um produto JA existente, apontado pela fila
	* SigPrPrt). "Gravar" e sempre um UPDATE - o proprio PROCEDURE
	* gravacao do legado roda o mesmo par Update/Delete em qualquer
	* contexto -, entao Inserir delega para Atualizar.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		RETURN THIS.Atualizar()
	ENDPROC

	*====================================================================
	* Atualizar - Grava a descricao (portugues/traduzido) de volta em
	* SigCdPro e remove o produto da fila SigPrPrt. Espelha
	* literalmente o PROCEDURE gravacao do legado:
	*
	*   Update SigCdPro Set DscCompras = ..., ObsCompras = ..., DPros = ...
	*                   Where CPros = ...
	*   Delete From SigPrPrt Where CPros = ...
	*
	* tratando as duas instrucoes como uma unidade: se o Delete falhar
	* apos o Update ter sido aplicado, o legado reverte tudo (RollBack).
	* Conexao nasce em modo transacional manual (Transactions=2, memoria
	* feedback_conexao_sql_transactions_2_sem_commit) - commit/rollback
	* explicitos, no mesmo padrao de SigPrChrBO.ExecutarExclusao.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		IF EMPTY(ALLTRIM(THIS.this_cCPros))
			THIS.this_cMensagemErro = "Produto sem c" + CHR(243) + "digo (CPros) para grava" + CHR(231) + CHR(227) + "o."
			RETURN .F.
		ENDIF

		THIS.this_cDPros = PADR(ALLTRIM(THIS.this_cPortugues), 40)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET DscCompras = <<EscaparSQL(THIS.this_cDscCompras)>>,
					ObsCompras = <<EscaparSQL(THIS.this_cObsCompras)>>,
					DPros = <<EscaparSQL(THIS.this_cDPros)>>
				WHERE CPros = <<EscaparSQL(THIS.this_cCPros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(THIS.this_cCPros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					SQLCOMMIT(gnConnHandle)
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
					loc_lSucesso = .T.
				ELSE
					SQLROLLBACK(gnConnHandle)
					*-- legado: =fGravarLog([T], Upper(ThisForm.Name), Usuar,
					*-- [Falha na Conexao (Traducao)]) - wrapper no-op
					*-- (utils\fgravarlog.prg, Erro163_Aba1); retorno descartado
					*-- igual ao original, so para reproduzir a chamada.
					=fGravarLog("T", "SIGPRDSC", gc_4c_UsuarioLogado, ;
						"Falha na Conex" + CHR(227) + "o (Traducao)")
					*-- this_cMensagemErro fica preenchida; quem EXIBE eh
					*-- BusinessBase.Salvar()->ExibirFalha() - MsgErro aqui
					*-- duplicaria a mensagem (regra: falha nunca eh muda, mas
					*-- tambem nunca eh mostrada duas vezes)
					THIS.this_cMensagemErro = "Falha ao remover o produto " + ALLTRIM(THIS.this_cCPros) + ;
						" da fila de tradu" + CHR(231) + CHR(227) + "o (SigPrPrt):" + CHR(13) + CapturarErroSQL()
				ENDIF
			ELSE
				SQLROLLBACK(gnConnHandle)
				THIS.this_cMensagemErro = "Falha ao gravar a descri" + CHR(231) + CHR(227) + "o do produto " + ;
					ALLTRIM(THIS.this_cCPros) + " em SigCdPro:" + CHR(13) + CapturarErroSQL()
			ENDIF

		CATCH TO loc_oErro
			SQLROLLBACK(gnConnHandle)
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

