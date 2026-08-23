CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2198: Coluna 'dpros' NAO EXISTE na tabela 'sigprpmi' (referenciada como a.DPros)
- [SQL-SCHEMA] Linha ~2370: INSERT coluna 'dpros' NAO EXISTE na tabela 'sigprpmi'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigprpmi
CREATE TABLE [dbo].[SigPrPmi](
	[cpros] [char](14) NOT NULL,
	[pecas] [char](10) NOT NULL,
	[promos] [char](25) NOT NULL,
	[cbars] [numeric](14, 0) NOT NULL,
	[datas] [datetime] NULL,
	[cidchaves] [char](20) NOT NULL,
	[dtalts] [datetime] NULL,
	[promopro] [char](35) NOT NULL,
	[vendavels] [numeric](1, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormPrm.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\PrmBO.prg):

--- BO Linhas 355 a 365 ---
355:     *====================================================================
356:     FUNCTION BuscarItens(par_cPromos)
357:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult
358:         loc_lSucesso = .F.
359:         TRY
360:             loc_cSQL = "SELECT a.cIdChaves, a.CPros, a.DPros, a.Pecas," + ;
361:                        " a.Promos, a.CBars, a.Datas, a.DtAlts," + ;
362:                        " a.PromoPro, a.Vendavels" + ;
363:                        " FROM SigPrPmi a" + ;
364:                        " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
365:                        " ORDER BY a.CPros"

--- BO Linhas 376 a 386 ---
376:                     USE IN cursor_4c_Itens
377:                 ENDIF
378: 
379:                 SET NULL ON
380:                 CREATE CURSOR cursor_4c_Itens ;
381:                     (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
382:                      Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
383:                      PromoPro C(35), Vendavels N(1,0) NULL)
384:                 SET NULL OFF
385: 
386:                 IF RECCOUNT("cursor_4c_ItensTemp") > 0

--- BO Linhas 385 a 395 ---
385: 
386:                 IF RECCOUNT("cursor_4c_ItensTemp") > 0
387:                     SELECT cursor_4c_ItensTemp
388:                     SCAN
389:                         INSERT INTO cursor_4c_Itens ;
390:                             (cIdChaves, CPros, DPros, Pecas, Promos, CBars, ;
391:                              Datas, DtAlts, PromoPro, Vendavels) ;
392:                         VALUES ;
393:                             (cursor_4c_ItensTemp.cIdChaves, ;
394:                              cursor_4c_ItensTemp.CPros, ;
395:                              cursor_4c_ItensTemp.DPros, ;

--- BO Linhas 390 a 400 ---
390:                             (cIdChaves, CPros, DPros, Pecas, Promos, CBars, ;
391:                              Datas, DtAlts, PromoPro, Vendavels) ;
392:                         VALUES ;
393:                             (cursor_4c_ItensTemp.cIdChaves, ;
394:                              cursor_4c_ItensTemp.CPros, ;
395:                              cursor_4c_ItensTemp.DPros, ;
396:                              cursor_4c_ItensTemp.Pecas, ;
397:                              cursor_4c_ItensTemp.Promos, ;
398:                              cursor_4c_ItensTemp.CBars, ;
399:                              cursor_4c_ItensTemp.Datas, ;
400:                              cursor_4c_ItensTemp.DtAlts, ;

--- BO Linhas 528 a 538 ---
528:                 ELSE
529:                     loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
530:                 ENDIF
531: 
532:                 loc_cSQL = "INSERT INTO SigPrPmi" + ;
533:                            " (cIdChaves, CPros, DPros, Pecas, Promos, CBars," + ;
534:                            " Datas, DtAlts, PromoPro, Vendavels)" + ;
535:                            " VALUES (" + ;
536:                            EscaparSQL(loc_cIdChaves) + ", " + ;
537:                            EscaparSQL(ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
538:                            EscaparSQL(ALLTRIM(cursor_4c_Itens.DPros)) + ", " + ;

--- BO Linhas 533 a 543 ---
533:                            " (cIdChaves, CPros, DPros, Pecas, Promos, CBars," + ;
534:                            " Datas, DtAlts, PromoPro, Vendavels)" + ;
535:                            " VALUES (" + ;
536:                            EscaparSQL(loc_cIdChaves) + ", " + ;
537:                            EscaparSQL(ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
538:                            EscaparSQL(ALLTRIM(cursor_4c_Itens.DPros)) + ", " + ;
539:                            EscaparSQL(ALLTRIM(cursor_4c_Itens.Pecas)) + ", " + ;
540:                            EscaparSQL(par_cPromos) + ", " + ;
541:                            FormatarNumeroSQL(cursor_4c_Itens.CBars) + ", " + ;
542:                            FormatarDataSQL(cursor_4c_Itens.Datas) + ", " + ;
543:                            "GETDATE(), " + ;

--- BO Linhas 688 a 698 ---
688:                 ENDIF
689: 
690:                 IF EMPTY(loc_cCPros)
691:                     loc_lSucesso = .F.
692:                 ENDIF
693:                 loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
694:                            " WHERE a.cPros = " + EscaparSQL(loc_cCPros)
695:             ELSE
696:                 loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
697:                            " WHERE a.cPros = " + EscaparSQL(par_cCodigo)
698:             ENDIF

--- BO Linhas 691 a 701 ---
691:                     loc_lSucesso = .F.
692:                 ENDIF
693:                 loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
694:                            " WHERE a.cPros = " + EscaparSQL(loc_cCPros)
695:             ELSE
696:                 loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
697:                            " WHERE a.cPros = " + EscaparSQL(par_cCodigo)
698:             ENDIF
699: 
700:             *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
701:             IF USED("cursor_4c_BuscaProd")

--- BO Linhas 721 a 731 ---
721:         RETURN loc_lSucesso
722:     ENDFUNC
723: 
724:     *====================================================================
725:     * BuscarProdutoParaLookup - Busca produtos para FormBuscaAuxiliar (PUBLIC)
726:     * Popula cursor_4c_BuscaProd com cPros + dPros
727:     *====================================================================
728:     FUNCTION BuscarProdutoParaLookup(par_cFiltro)
729:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult
730:         loc_lSucesso = .F.
731:         TRY

--- BO Linhas 731 a 741 ---
731:         TRY
732:             IF USED("cursor_4c_BuscaProd")
733:                 USE IN cursor_4c_BuscaProd
734:             ENDIF
735: 
736:             loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a"
737:             IF !EMPTY(ALLTRIM(par_cFiltro))
738:                 loc_cSQL = loc_cSQL + ;
739:                            " WHERE a.cPros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
740:             ENDIF
741:             loc_cSQL = loc_cSQL + " ORDER BY a.cPros"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormPrm.prg
- BO: C:\4c\projeto\app\classes\PrmBO.prg
