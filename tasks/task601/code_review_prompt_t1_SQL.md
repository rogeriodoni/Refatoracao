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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1384 linhas total):

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

*-- Linhas 283 a 383:
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
303:             CREATE CURSOR cursor_4c_Produtos (CPros C(14), Portugues C(254), ;
304:                 Traduzido C(254), DscCompras M, ObsCompras M)
305:         ENDIF
306: 
307:         THIS.AddObject("grd_4c_Dados", "Grid")
308:         loc_oGrid = THIS.grd_4c_Dados
309:         WITH loc_oGrid
310:             .Top               = 164
311:             .Left              = 15
312:             .Width             = 769
313:             .Height            = 343
314:             .ColumnCount       = 3
315:             .FontSize          = 8
316:             .AllowHeaderSizing = .F.
317:             .AllowRowSizing    = .F.
318:             .DeleteMark        = .F.
319:             .RecordMark        = .F.
320:             .HeaderHeight      = 17
321:             .RowHeight         = 17
322:             .ScrollBars        = 2
323:             .RecordSource      = "cursor_4c_Produtos"
324:             .ReadOnly          = .T.
325:         ENDWITH
326: 
327:         WITH loc_oGrid.Column1
328:             .Width         = 108
329:             .FontSize      = 8
330:             .ControlSource = "cursor_4c_Produtos.CPros"
331:         ENDWITH
332:         WITH loc_oGrid.Column1.Header1
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .Alignment = 2
336:             .Caption   = "C" + CHR(243) + "digo"
337:         ENDWITH
338:         WITH loc_oGrid.Column1.Text1
339:             .FontSize    = 8
340:             .BorderStyle = 0
341:             .Margin      = 0
342:             .ForeColor   = RGB(0, 0, 0)
343:             .BackColor   = RGB(255, 255, 255)
344:         ENDWITH
345: 
346:         WITH loc_oGrid.Column2
347:             .Width         = 290
348:             .FontSize      = 8
349:             .ControlSource = "cursor_4c_Produtos.Portugues"
350:         ENDWITH
351:         WITH loc_oGrid.Column2.Header1
352:             .FontName  = "Tahoma"
353:             .FontSize  = 8
354:             .Alignment = 2
355:             .Caption   = "Portugu" + CHR(234) + "s"
356:         ENDWITH
357:         WITH loc_oGrid.Column2.Text1
358:             .FontSize    = 8
359:             .BorderStyle = 0
360:             .Margin      = 0
361:             .ForeColor   = RGB(0, 0, 0)
362:             .BackColor   = RGB(255, 255, 255)
363:         ENDWITH
364: 
365:         WITH loc_oGrid.Column3
366:             .Width         = 339
367:             .FontSize      = 8
368:             .ControlSource = "cursor_4c_Produtos.Traduzido"
369:         ENDWITH
370:         WITH loc_oGrid.Column3.Header1
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .Alignment = 2
374:             .Caption   = "Traduzido"
375:         ENDWITH
376:         WITH loc_oGrid.Column3.Text1
377:             .FontSize    = 8
378:             .BorderStyle = 0
379:             .Margin      = 0
380:             .ForeColor   = RGB(0, 0, 0)
381:             .BackColor   = RGB(255, 255, 255)
382:         ENDWITH
383:     ENDPROC

*-- Linhas 432 a 450:
432:         ENDWITH
433:         *-- Handler nomeado pela ACAO, nao pelo objeto legado: o Click do
434:         *-- btnAtualizar chama ThisForm.Gravacao, cujo corpo eh o
435:         *-- Update SigCdPro + Delete SigPrPrt + Commit. Ou seja, "Atualizar"
436:         *-- eh o botao de GRAVAR desta tela. O objeto e a Caption continuam
437:         *-- "Atualizar" (PILAR 1 - o usuario ve o mesmo botao de antes); so o
438:         *-- nome interno do metodo descreve o que ele faz (PILAR 3).
439:         BINDEVENT(THIS.cmd_4c_BtnAtualizar, "Click", THIS, "BtnGravarClick")
440: 
441:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
442:         WITH THIS.cmd_4c_BtnSair
443:             .Top        = 3
444:             .Left       = 725
445:             .Width      = 75
446:             .Height     = 75
447:             .Caption    = "Encerrar"
448:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
449:             .Cancel     = .T.
450:             .FontName   = "Comic Sans MS"

*-- Linhas 478 a 496:
478:     *
479:     * Say3/Say1/Say2 sao classe "say" pura no dump (nao declaram Width nem
480:     * Alignment) - AutoSize = .T. + Alignment = 0, sem inventar caixa (regra
481:     * #23). Format = "K" do legado equivale a SelectOnEntry = .T. em VFP9
482:     * (substitui o texto ao entrar no campo, nao restringe o que pode ser
483:     * digitado - por isso NAO e o Format = "M" da regra #24).
484:     *
485:     * FASE 6/8: acrescenta lbl_4c_Grupo/txt_4c_CGrus (Say2/getCGrus) e liga
486:     * os 3 lookups via BINDEVENT (ver ValidarCProsI/ValidarCProsF/
487:     * ValidarCGrus mais abaixo).
488:     *--------------------------------------------------------------------------
489:     PROTECTED PROCEDURE ConfigurarCampos()
490:         THIS.AddObject("lbl_4c_ProdutosDe", "Label")
491:         WITH THIS.lbl_4c_ProdutosDe
492:             .AutoSize  = .T.
493:             .Alignment = 0
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .FontBold  = .T.

*-- Linhas 509 a 527:
509:             .Top           = 135
510:             .Width         = 108
511:             .MaxLength     = 14
512:             .SelectOnEntry = .T.
513:             .Value         = ""
514:         ENDWITH
515: 
516:         THIS.AddObject("lbl_4c_Ate", "Label")
517:         WITH THIS.lbl_4c_Ate
518:             .AutoSize  = .T.
519:             .Alignment = 0
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .FontBold  = .T.
523:             .BackStyle = 0
524:             .ForeColor = RGB(90, 90, 90)
525:             .Left      = 345
526:             .Top       = 138
527:             .Caption   = "at" + CHR(233)

*-- Linhas 535 a 553:
535:             .Top           = 135
536:             .Width         = 108
537:             .MaxLength     = 14
538:             .SelectOnEntry = .T.
539:             .Value         = ""
540:         ENDWITH
541: 
542:         THIS.AddObject("lbl_4c_Grupo", "Label")
543:         WITH THIS.lbl_4c_Grupo
544:             .AutoSize  = .T.
545:             .Alignment = 0
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .FontBold  = .T.
549:             .BackStyle = 0
550:             .ForeColor = RGB(90, 90, 90)
551:             .Left      = 505
552:             .Top       = 138
553:             .Caption   = "Grupo de Produto :"

*-- Linhas 561 a 579:
561:             .Top           = 135
562:             .Width         = 31
563:             .MaxLength     = 3
564:             .SelectOnEntry = .T.
565:             .Value         = ""
566:         ENDWITH
567: 
568:         *-- Lookups (fwbuscaext no legado) - Enter(13)/Tab(9)/F4(115) e
569:         *-- duplo-clique disparam o mesmo picker que o Valid do legado abria
570:         *-- ao sair do campo.
571:         BINDEVENT(THIS.txt_4c_CProsI, "KeyPress", THIS, "CProsIKeyPress")
572:         BINDEVENT(THIS.txt_4c_CProsI, "DblClick", THIS, "CProsIDblClick")
573: 
574:         BINDEVENT(THIS.txt_4c_CProsF, "KeyPress", THIS, "CProsFKeyPress")
575:         BINDEVENT(THIS.txt_4c_CProsF, "DblClick", THIS, "CProsFDblClick")
576: 
577:         BINDEVENT(THIS.txt_4c_CGrus, "KeyPress", THIS, "CGrusKeyPress")
578:         BINDEVENT(THIS.txt_4c_CGrus, "DblClick", THIS, "CGrusDblClick")
579: 

*-- Linhas 737 a 785:
737: 
738:         TRY
739:             IF USED("cursor_4c_BuscaPro")
740:                 USE IN SELECT("cursor_4c_BuscaPro")
741:             ENDIF
742: 
743:             *-- 1) match EXATO (o que o Init do fwbuscaext legado fazia antes
744:             *--    de decidir se abria o picker)
745:             loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro " + ;
746:                        "WHERE cpros = " + EscaparSQL(loc_cValor)
747:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
748: 
749:             IF loc_nRes > 0 AND USED("cursor_4c_BuscaPro") AND RECCOUNT("cursor_4c_BuscaPro") = 1
750:                 SELECT cursor_4c_BuscaPro
751:                 GO TOP
752:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaPro.cpros)
753:                 loc_lOk = .T.
754:             ELSE
755:                 *-- 2) busca por PREFIXO em codigo OU descricao
756:                 IF USED("cursor_4c_BuscaPro")
757:                     USE IN SELECT("cursor_4c_BuscaPro")
758:                 ENDIF
759:                 loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro " + ;
760:                            "WHERE (cpros LIKE " + EscaparSQL(loc_cValor + "%") + ;
761:                            " OR dpros LIKE " + EscaparSQL(loc_cValor + "%") + ") " + ;
762:                            "ORDER BY cpros"
763:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
764: 
765:                 *-- 3) fallback SHOW-ALL: prefixo sem match abre a lista toda,
766:                 *--    em vez de um picker vazio
767:                 IF loc_nRes > 0 AND USED("cursor_4c_BuscaPro") AND RECCOUNT("cursor_4c_BuscaPro") = 0
768:                     USE IN SELECT("cursor_4c_BuscaPro")
769:                     loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro ORDER BY cpros"
770:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
771:                 ENDIF
772: 
773:                 IF loc_nRes < 0
774:                     MsgErro("Erro ao consultar produtos." + CHR(13) + CapturarErroSQL(), ;
775:                             "Erro SQL")
776:                 ELSE
777:                     IF !USED("cursor_4c_BuscaPro") OR RECCOUNT("cursor_4c_BuscaPro") = 0
778:                         MsgAviso("Nenhum produto cadastrado.", loc_cTitulo)
779:                     ELSE
780:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
781:                         IF VARTYPE(loc_oBusca) = "O"
782:                             loc_oBusca.this_cCursorDestino  = "cursor_4c_BuscaPro"
783:                             loc_oBusca.this_cCampoCodigo    = "cpros"
784:                             loc_oBusca.this_cCampoDescricao = "dpros"
785:                             loc_oBusca.this_cTitulo         = loc_cTitulo

*-- Linhas 795 a 832:
795:                             loc_oBusca.Show()
796: 
797:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
798:                                 SELECT cursor_4c_BuscaPro
799:                                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaPro.cpros)
800:                                 loc_lOk = .T.
801:                             ENDIF
802: 
803:                             loc_oBusca.Release()
804:                         ENDIF
805:                     ENDIF
806:                 ENDIF
807:             ENDIF
808: 
809:             IF USED("cursor_4c_BuscaPro")
810:                 USE IN SELECT("cursor_4c_BuscaPro")
811:             ENDIF
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message + CHR(13) + ;
814:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
815:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupProduto")
816:             IF USED("cursor_4c_BuscaPro")
817:                 USE IN SELECT("cursor_4c_BuscaPro")
818:             ENDIF
819:         ENDTRY
820: 
821:         *-- fora do ENDTRY para liberar a guarda tambem quando o CATCH dispara
822:         THIS.this_lEmLookup = .F.
823: 
824:         RETURN loc_lOk
825:     ENDPROC
826: 
827:     *--------------------------------------------------------------------------
828:     * AbrirLookupGrupo - picker de grupo de produto, equivalente ao
829:     *   CreateObject([fwbuscaext], ..., [SigCdGrp], [crListaRemota], [CGrus],
830:     *                This.Value, [Selecao], 1000)
831:     * do PROCEDURE Valid de getCGrus, com as DUAS colunas que o legado
832:     * declara (mAddColuna CGrus/DGrus).

*-- Linhas 848 a 894:
848: 
849:         TRY
850:             IF USED("cursor_4c_BuscaGru")
851:                 USE IN SELECT("cursor_4c_BuscaGru")
852:             ENDIF
853: 
854:             *-- 1) match EXATO
855:             loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp " + ;
856:                        "WHERE cgrus = " + EscaparSQL(loc_cValor)
857:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
858: 
859:             IF loc_nRes > 0 AND USED("cursor_4c_BuscaGru") AND RECCOUNT("cursor_4c_BuscaGru") = 1
860:                 SELECT cursor_4c_BuscaGru
861:                 GO TOP
862:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
863:                 loc_lOk = .T.
864:             ELSE
865:                 *-- 2) busca por PREFIXO em codigo OU descricao
866:                 IF USED("cursor_4c_BuscaGru")
867:                     USE IN SELECT("cursor_4c_BuscaGru")
868:                 ENDIF
869:                 loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp " + ;
870:                            "WHERE (cgrus LIKE " + EscaparSQL(loc_cValor + "%") + ;
871:                            " OR dgrus LIKE " + EscaparSQL(loc_cValor + "%") + ") " + ;
872:                            "ORDER BY cgrus"
873:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
874: 
875:                 *-- 3) fallback SHOW-ALL
876:                 IF loc_nRes > 0 AND USED("cursor_4c_BuscaGru") AND RECCOUNT("cursor_4c_BuscaGru") = 0
877:                     USE IN SELECT("cursor_4c_BuscaGru")
878:                     loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus"
879:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
880:                 ENDIF
881: 
882:                 IF loc_nRes < 0
883:                     MsgErro("Erro ao consultar grupos de produto." + CHR(13) + ;
884:                             CapturarErroSQL(), "Erro SQL")
885:                 ELSE
886:                     IF !USED("cursor_4c_BuscaGru") OR RECCOUNT("cursor_4c_BuscaGru") = 0
887:                         MsgAviso("Nenhum grupo de produto cadastrado.", loc_cTitulo)
888:                     ELSE
889:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
890:                         IF VARTYPE(loc_oBusca) = "O"
891:                             loc_oBusca.this_cCursorDestino  = "cursor_4c_BuscaGru"
892:                             loc_oBusca.this_cCampoCodigo    = "cgrus"
893:                             loc_oBusca.this_cCampoDescricao = "dgrus"
894:                             loc_oBusca.this_cTitulo         = loc_cTitulo

*-- Linhas 902 a 939:
902:                             loc_oBusca.Show()
903: 
904:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
905:                                 SELECT cursor_4c_BuscaGru
906:                                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
907:                                 loc_lOk = .T.
908:                             ENDIF
909: 
910:                             loc_oBusca.Release()
911:                         ENDIF
912:                     ENDIF
913:                 ENDIF
914:             ENDIF
915: 
916:             IF USED("cursor_4c_BuscaGru")
917:                 USE IN SELECT("cursor_4c_BuscaGru")
918:             ENDIF
919:         CATCH TO loc_oErro
920:             MsgErro(loc_oErro.Message + CHR(13) + ;
921:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
922:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
923:             IF USED("cursor_4c_BuscaGru")
924:                 USE IN SELECT("cursor_4c_BuscaGru")
925:             ENDIF
926:         ENDTRY
927: 
928:         THIS.this_lEmLookup = .F.
929: 
930:         RETURN loc_lOk
931:     ENDPROC
932: 
933:     *--------------------------------------------------------------------------
934:     * AtualizarExclusividadeFiltros - reproduz os PROCEDURE When do legado:
935:     *   getCProsI.When -> Return Empty(ThisForm.getCGrus.Value)
936:     *   getCProsF.When -> Return Empty(ThisForm.getCGrus.Value)
937:     *   getCGrus.When  -> Return Empty(ThisForm.getCProsI.Value) And
938:     *                            Empty(ThisForm.getCProsF.Value)
939:     *

*-- Linhas 969 a 987:
969:     *--------------------------------------------------------------------------
970:     PROCEDURE CarregarLista()
971:         IF USED("cursor_4c_Produtos")
972:             SELECT cursor_4c_Produtos
973:             GO TOP
974:         ENDIF
975: 
976:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
977:             THIS.grd_4c_Dados.Refresh()
978:         ENDIF
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * BtnSelecionarClick - equivalente ao PROCEDURE Click do btnSelecionar
983:     * legado. Desabilita o botao de gravar, valida que ao menos um filtro foi
984:     * informado, completa a faixa de produto quando so uma ponta foi digitada
985:     * (o legado espelha o inicio no fim e vice-versa) e dispara
986:     * THIS.Processamento().
987:     *

*-- Linhas 1017 a 1241:
1017:     * Processamento - equivalente ao PROCEDURE processamento do legado. Monta
1018:     * a lista de produtos candidatos (por faixa CPros OU por CGrus - nunca os
1019:     * dois, mesma exclusividade de AtualizarExclusividadeFiltros), e para cada
1020:     * um consulta Grupo (SigCdGrp) e Cor (SigCdCor) via LEFT JOIN a partir de
1021:     * SigCdPro.
1022:     *
1023:     * DESVIO NENHUM - TRANSCRICAO LITERAL (regra #17): no metodo original a
1024:     * variavel lcDes eh inicializada com [] logo no comeco do laco e NUNCA
1025:     * reatribuida antes do "If Not Empty(lcDes)" - lcIni/lnGrD (calculados a
1026:     * partir do LEFT JOIN) nao alimentam lcDes em lugar nenhum do codigo
1027:     * fonte extraido (SigPrDsc_form_codigo_fonte.txt, metodo completo, sem
1028:     * truncamento). Ou seja, o bloco de traducao e o "Insert Into crProdutos"
1029:     * sao CODIGO MORTO no proprio legado - o processamento sempre roda (monta
1030:     * cursor_4c_PrdTraduz, consulta Grupo/Cor de cada produto) mas nunca insere
1031:     * linha em cursor_4c_Produtos, e por isso cmd_4c_BtnAtualizar nunca fica
1032:     * habilitado por este caminho. Mantido identico ao legado (PILAR 1) -
1033:     * "reescrever" essa lacuna inventaria regra de negocio que nao existe em
1034:     * lugar nenhum do sistema original.
1035:     *--------------------------------------------------------------------------
1036:     PROTECTED PROCEDURE Processamento()
1037:         LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cSQL, loc_nResultado, loc_oProg
1038:         LOCAL loc_cPro, loc_cDes, loc_cIni, loc_nGrD, loc_cIng, loc_oErro
1039: 
1040:         IF USED("cursor_4c_Produtos")
1041:             SELECT cursor_4c_Produtos
1042:             ZAP
1043:         ENDIF
1044: 
1045:         *-- Filtros vem do BO (postos la por FormParaBO e ja espelhados por
1046:         *-- NormalizarFiltros), nao relidos da tela. O PADR eh aplicado SO
1047:         *-- aqui, na montagem do SQL, exatamente como o legado
1048:         *-- (lcPrI = Padr(getCProsI.Value, 14) / lcGru = Padr(getCGrus.Value, 3));
1049:         *-- as properties do BO ficam sem padding para que BOParaForm nao
1050:         *-- devolva espacos a direita para dentro dos TextBox.
1051:         loc_cPrI = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsI), 14)
1052:         loc_cPrF = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsF), 14)
1053:         loc_cGru = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCGrus), 3)
1054: 
1055:         IF !EMPTY(loc_cGru)
1056:             loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cgrus = " + EscaparSQL(loc_cGru) + ;
1057:                        " ORDER BY cpros"
1058:         ELSE
1059:             loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros BETWEEN " + EscaparSQL(loc_cPrI) + ;
1060:                        " AND " + EscaparSQL(loc_cPrF) + " ORDER BY cpros"
1061:         ENDIF
1062: 
1063:         IF USED("cursor_4c_PrdTraduz")
1064:             USE IN SELECT("cursor_4c_PrdTraduz")
1065:         ENDIF
1066: 
1067:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrdTraduz")
1068:         IF loc_nResultado < 0
1069:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1070:                 "Falha na Conex" + CHR(227) + "o (crPrdTraduz)")
1071:             RETURN
1072:         ENDIF
1073: 
1074:         IF !USED("cursor_4c_PrdTraduz") OR RECCOUNT("cursor_4c_PrdTraduz") = 0
1075:             RETURN
1076:         ENDIF
1077: 
1078:         TRY
1079:             loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
1080:                 RECCOUNT("cursor_4c_PrdTraduz"))
1081:             loc_oProg.Show()
1082: 
1083:             SELECT cursor_4c_PrdTraduz
1084:             GO TOP
1085:             SCAN
1086:                 loc_cPro = ALLTRIM(cursor_4c_PrdTraduz.cpros)
1087: 
1088:                 loc_oProg.Update("Produto : " + loc_cPro, .T.)
1089: 
1090:                 IF !EMPTY(loc_cPro)
1091:                     loc_cDes = ""
1092: 
1093:                     IF USED("cursor_4c_LocalPro")
1094:                         USE IN SELECT("cursor_4c_LocalPro")
1095:                     ENDIF
1096: 
1097:                     loc_cSQL = "SELECT a.cpros, a.cgrus, a.codcors, b.dgrus, b.mercs, b.montagrds, c.descs " + ;
1098:                                "FROM SigCdPro a " + ;
1099:                                "LEFT JOIN SigCdGrp b ON b.cgrus = a.cgrus " + ;
1100:                                "LEFT JOIN SigCdCor c ON c.cods = a.codcors " + ;
1101:                                "WHERE a.cpros = " + EscaparSQL(loc_cPro)
1102: 
1103:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
1104:                     IF loc_nResultado < 0
1105:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1106:                             "Falha na Conex" + CHR(227) + "o (LocalPro)")
1107:                         EXIT
1108:                     ENDIF
1109: 
1110:                     IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
1111:                         SELECT cursor_4c_LocalPro
1112:                         GO TOP
1113:                         loc_cIni = ALLTRIM(ALLTRIM(TratarNulo(dgrus, "")) + " " + ALLTRIM(TratarNulo(descs, "")))
1114:                         loc_nGrD = TratarNulo(montagrds, 0)
1115:                     ENDIF
1116: 
1117:                     *-- legado: lcDes permanece vazio ate aqui (ver comentario
1118:                     *-- do cabecalho do metodo) - bloco transcrito tal como
1119:                     *-- esta no fonte original, mesmo nunca executando.
1120:                     IF !EMPTY(loc_cDes)
1121:                         loc_cIng = loc_cDes
1122: 
1123:                         IF USED("cursor_4c_Dicionario")
1124:                             SELECT cursor_4c_Dicionario
1125:                             GO TOP
1126:                             SCAN
1127:                                 loc_cIng = STRTRAN(loc_cIng, ALLTRIM(cursor_4c_Dicionario.expressao), ;
1128:                                     ALLTRIM(cursor_4c_Dicionario.traducao))
1129:                             ENDSCAN
1130:                         ENDIF
1131: 
1132:                         loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
1133:                         loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")
1134: 
1135:                         INSERT INTO cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
1136:                             VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
1137: 
1138:                         THIS.grd_4c_Dados.Refresh()
1139:                     ENDIF
1140:                 ENDIF
1141:             ENDSCAN
1142: 
1143:             loc_oProg.Complete(.T.)
1144:             loc_oProg.Release()
1145: 
1146:             IF USED("cursor_4c_LocalPro")
1147:                 USE IN SELECT("cursor_4c_LocalPro")
1148:             ENDIF
1149:             IF USED("cursor_4c_PrdTraduz")
1150:                 USE IN SELECT("cursor_4c_PrdTraduz")
1151:             ENDIF
1152: 
1153:             *-- legado: Select crProdutos / Go Top / If Not Eof() ->
1154:             *-- btnAtualizar.Enabled = .t. Mesmo criterio, pelo funil: a
1155:             *-- selecao terminou, entao o que decide eh haver linha na lista.
1156:             THIS.this_lListaPronta = .T.
1157:             THIS.CarregarLista()
1158:             THIS.AjustarBotoesPorModo()
1159:         CATCH TO loc_oErro
1160:             MsgErro(loc_oErro.Message + CHR(13) + ;
1161:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1162:                 "Procedure: " + loc_oErro.Procedure, "Erro em Processamento")
1163:             IF USED("cursor_4c_LocalPro")
1164:                 USE IN SELECT("cursor_4c_LocalPro")
1165:             ENDIF
1166:             IF USED("cursor_4c_PrdTraduz")
1167:                 USE IN SELECT("cursor_4c_PrdTraduz")
1168:             ENDIF
1169:         ENDTRY
1170:     ENDPROC
1171: 
1172:     *--------------------------------------------------------------------------
1173:     * BtnGravarClick - handler do botao "Atualizar" (legado btnAtualizar, cujo
1174:     * Click eh "ThisForm.Gravacao"). Nomeado pela ACAO que executa - gravar -,
1175:     * nao pelo rotulo do botao: o objeto e a Caption continuam "Atualizar"
1176:     * (PILAR 1), o nome do metodo descreve o efeito (PILAR 3).
1177:     *
1178:     * Grava as descricoes traduzidas de volta em SigCdPro e
1179:     * remove cada produto da fila SigPrPrt (equivalente ao PROCEDURE gravacao
1180:     * do legado). Percorre cursor_4c_Produtos linha a linha, delegando a
1181:     * gravacao de cada uma ao Business Object (EditarRegistro+CarregarDoCursor+
1182:     * Salvar) - a UPDATE/DELETE/COMMIT/ROLLBACK real esta em
1183:     * SigPrDscBO.Atualizar(). Interrompe no primeiro erro, como o legado
1184:     * (Scan While llOks).
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE BtnGravarClick()
1187:         LOCAL loc_lOk, loc_oProg, loc_cPro, loc_nTotal, loc_oErro
1188: 
1189:         IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1190:             RETURN
1191:         ENDIF
1192: 
1193:         loc_lOk = .T.
1194:         loc_nTotal = RECCOUNT("cursor_4c_Produtos")
1195: 
1196:         TRY
1197:             loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
1198:             loc_oProg.Show()
1199: 
1200:             SELECT cursor_4c_Produtos
1201:             GO TOP
1202:             SCAN WHILE loc_lOk
1203:                 loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)
1204: 
1205:                 loc_oProg.Update("Produto : " + loc_cPro, .T.)
1206: 
1207:                 THIS.this_oBusinessObject.EditarRegistro()
1208:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")
1209: 
1210:                 IF !THIS.this_oBusinessObject.Salvar()
1211:                     loc_lOk = .F.
1212:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1213:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o produto " + ;
1214:                             loc_cPro + ".", "Erro")
1215:                     ENDIF
1216:                 ENDIF
1217:             ENDSCAN
1218: 
1219:             loc_oProg.Complete(.T.)
1220:             loc_oProg.Release()
1221: 
1222:             IF loc_lOk
1223:                 MsgInfo("Foram Gravados " + ALLTRIM(STR(loc_nTotal, 10)) + " Produtos!!!", ;
1224:                     "Processamento Conclu" + CHR(237) + "do!!!")
1225: 
1226:                 *-- Gravou: os produtos sairam da fila SigPrPrt (Delete no BO),
1227:                 *-- logo nao ha mais nada a gravar nesta lista. A GRADE CONTINUA
1228:                 *-- exibindo as linhas gravadas - o legado tambem nao limpa
1229:                 *-- crProdutos aqui, so desliga o botao, e essa confirmacao
1230:                 *-- visual faz parte da UX (PILAR 1).
1231:                 THIS.this_lListaPronta = .F.
1232:             ENDIF
1233: 
1234:             THIS.CarregarLista()
1235:             THIS.AjustarBotoesPorModo()
1236:         CATCH TO loc_oErro
1237:             MsgErro(loc_oErro.Message + CHR(13) + ;
1238:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1239:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnGravarClick")
1240:         ENDTRY
1241:     ENDPROC

*-- Linhas 1273 a 1291:
1273:     *      selecao anterior, entao contar linhas devolveria .T. e inverteria
1274:     *      o comportamento do legado)
1275:     *   fim de Processamento()     pronta, conta as linhas   -> .T. se houver
1276:     *     (legado: Select crProdutos / Go Top / If Not Eof())
1277:     *   apos gravar com sucesso    deixa de estar pronta     -> .F.
1278:     *     (legado: nada a regravar; a grade CONTINUA com as linhas gravadas)
1279:     *
1280:     * Concentrar isso aqui eh o que impede o defeito da CLAUDE.md #40 - estado
1281:     * desligado num caminho e nunca religado no caminho de volta.
1282:     *
1283:     * Nao ha modo INCLUIR/ALTERAR/VISUALIZAR nesta tela (o legado SIGPRDSC.SCX
1284:     * nao tem CRUD nem Page1/Page2): o parametro de modo do template CRUD nao
1285:     * existe aqui, e this_cModoAtual nao eh consultado. O nome canonico eh
1286:     * mantido porque eh o que o harness TesteAutomatico.prg procura.
1287:     *--------------------------------------------------------------------------
1288:     PROCEDURE AjustarBotoesPorModo()
1289:         LOCAL loc_lTemLinha
1290: 
1291:         loc_lTemLinha = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0


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

