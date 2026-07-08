CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2870: Coluna 'iclis' NAO EXISTE na tabela 'sigcdgcr' (referenciada como b.iClis)
- [SQL-SCHEMA] Linha ~2870: Coluna 'grupos' NAO EXISTE na tabela 'sigcdgcr' (referenciada como b.Grupos)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdgcr
CREATE TABLE [dbo].[SigCdGcr](
	[gerbals] [numeric](1, 0) NOT NULL,
	[cargos] [numeric](1, 0) NOT NULL,
	[cepobris] [numeric](1, 0) NOT NULL,
	[classes] [char](10) NOT NULL,
	[codigos] [char](10) NOT NULL,
	[coletors] [numeric](2, 0) NOT NULL,
	[comis] [numeric](1, 0) NOT NULL,
	[cpfobrigs] [numeric](1, 0) NOT NULL,
	[dadcoms] [numeric](1, 0) NOT NULL,
	[descrs] [char](40) NOT NULL,
	[dgcods] [char](1) NOT NULL,
	[fiscais] [numeric](1, 0) NOT NULL,
	[followups] [numeric](1, 0) NOT NULL,
	[internos] [char](20) NOT NULL,
	[limcres] [numeric](1, 0) NOT NULL,
	[pessoais] [numeric](1, 0) NOT NULL,
	[refbancs] [numeric](1, 0) NOT NULL,
	[respos] [numeric](1, 0) NOT NULL,
	[tpcads] [numeric](1, 0) NOT NULL,
	[tpcods] [numeric](1, 0) NOT NULL,
	[tpemps] [numeric](1, 0) NOT NULL,
	[mfotos] [numeric](1, 0) NOT NULL,
	[grufals] [char](10) NOT NULL,
	[contconts] [char](9) NOT NULL,
	[intconts] [numeric](1, 0) NOT NULL,
	[contabs] [numeric](1, 0) NOT NULL,
	[empresas] [numeric](1, 0) NOT NULL,
	[estoques] [numeric](1, 0) NOT NULL,
	[calcsalds] [numeric](1, 0) NOT NULL,
	[unifbals] [numeric](1, 0) NOT NULL,
	[complems] [numeric](1, 0) NOT NULL,
	[emprelevs] [numeric](1, 0) NOT NULL,
	[balfalpers] [numeric](1, 0) NOT NULL,
	[limestoqs] [numeric](1, 0) NOT NULL,
	[blqdivops] [numeric](1, 0) NOT NULL,
	[ccustos] [numeric](1, 0) NOT NULL,
	[ddfutus] [numeric](5, 0) NOT NULL,
	[ddretros] [numeric](5, 0) NOT NULL,
	[verests] [numeric](1, 0) NOT NULL,
	[blqcongvs] [numeric](1, 0) NOT NULL,
	[tipoinvs] [numeric](1, 0) NOT NULL,
	[caracteris] [numeric](1, 0) NOT NULL,
	[observas] [numeric](1, 0) NOT NULL,
	[chklimcrds] [numeric](1, 0) NOT NULL,
	[chklimests] [numeric](1, 0) NOT NULL,
	[infcads] [numeric](1, 0) NOT NULL,
	[osalfuns] [char](3) NOT NULL,
	[patrietqs] [numeric](1, 0) NOT NULL,
	[rgobrigs] [numeric](1, 0) NOT NULL,
	[calcimeds] [numeric](1, 0) NOT NULL,
	[ddsems] [numeric](1, 0) NOT NULL,
	[hordd] [numeric](4, 2) NOT NULL,
	[tpprecos] [numeric](1, 0) NOT NULL,
	[commoedas] [char](3) NOT NULL,
	[chktits] [numeric](1, 0) NOT NULL,
	[ospends] [numeric](1, 0) NOT NULL,
	[compagrus] [numeric](1, 0) NOT NULL,
	[trfpesas] [numeric](1, 0) NOT NULL,
	[difpesags] [numeric](9, 3) NOT NULL,
	[fichatecs] [numeric](1, 0) NOT NULL,
	[pqs] [char](1) NOT NULL,
	[sinals] [numeric](1, 0) NOT NULL,
	[grupolms] [char](10) NOT NULL,
	[agrupas] [char](10) NULL,
	[rodrelcc] [text] NULL,
	[padpgrecs] [numeric](1, 0) NOT NULL,
	[chkendds] [numeric](1, 0) NOT NULL,
	[chkendrs] [numeric](1, 0) NOT NULL,
	[ctrlotes] [numeric](1, 0) NOT NULL,
	[cfgcdgcr] [char](40) NOT NULL,
	[cfgfiscos] [char](50) NOT NULL,
	[cfgfiscss] [char](50) NOT NULL,
	[cfgfisics] [char](50) NOT NULL,
	[cfgfisiis] [char](50) NOT NULL,
	[cfgfisins] [char](50) NOT NULL,
	[cfgfisips] [char](50) NOT NULL,
	[cfgfisirs] [char](50) NOT NULL,
	[cfgfisiss] [char](50) NOT NULL,
	[cfgfispis] [char](50) NOT NULL,
	[titbaixado] [numeric](1, 0) NOT
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigredtv.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigredtvBO.prg):

--- BO Linhas 236 a 246 ---
236:                 loc_lSucesso = .F.
237:             ENDIF
238:             SELECT crSigCdMoe
239:             INDEX ON CMoes TAG CMoes
240: 
241:             *-- Grupos de conta corrente
242:             WAIT WINDOW "Aguarde!!! Carregando Grupos..." NOWAIT
243:             loc_cQuery = "SELECT Codigos, Classes FROM SigCdGcr"
244:             loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdGcr")
245:             IF loc_nResult < 1
246:                 THIS.this_cMensagemErro = "Falha ao carregar SigCdGcr"

--- BO Linhas 237 a 247 ---
237:             ENDIF
238:             SELECT crSigCdMoe
239:             INDEX ON CMoes TAG CMoes
240: 
241:             *-- Grupos de conta corrente
242:             WAIT WINDOW "Aguarde!!! Carregando Grupos..." NOWAIT
243:             loc_cQuery = "SELECT Codigos, Classes FROM SigCdGcr"
244:             loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdGcr")
245:             IF loc_nResult < 1
246:                 THIS.this_cMensagemErro = "Falha ao carregar SigCdGcr"
247:                 MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")

--- BO Linhas 261 a 271 ---
261:             ENDIF
262:             SELECT crSigCdMrr
263:             INDEX ON Balancos TAG Balancos
264: 
265:             *-- Itens de configuracao do mapa
266:             loc_cQuery = "SELECT Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
267:                          "Analiticos, Balancos, TpRegs, Titulos, CPartidas, SubTot100s " + ;
268:                          "FROM SigCdMri " + ;
269:                          "ORDER BY Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
270:                          "Analiticos, Balancos, TpRegs, Titulos, CPartidas"
271:             loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMri")

--- BO Linhas 264 a 274 ---
264: 
265:             *-- Itens de configuracao do mapa
266:             loc_cQuery = "SELECT Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
267:                          "Analiticos, Balancos, TpRegs, Titulos, CPartidas, SubTot100s " + ;
268:                          "FROM SigCdMri " + ;
269:                          "ORDER BY Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
270:                          "Analiticos, Balancos, TpRegs, Titulos, CPartidas"
271:             loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMri")
272:             IF loc_nResult < 1
273:                 THIS.this_cMensagemErro = "Falha ao carregar SigCdMri"
274:                 MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")

--- BO Linhas 274 a 284 ---
274:                 MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
275:                 loc_lSucesso = .F.
276:             ENDIF
277:             SELECT crSigCdMri
278:             INDEX ON Balancos + STR(Ordems, 3)            TAG Balancos
279:             INDEX ON Balancos + Grupos + STR(Ordems, 3)   TAG Grupos
280:             INDEX ON Balancos + DescGrps + STR(Ordems, 3) TAG DescGrps
281:             INDEX ON Classes + STR(Ordems, 3)             TAG Classes
282: 
283:             *-- Classes
284:             loc_cQuery = "SELECT Classes, Descrs, Nivels FROM SigCdCss"

--- BO Linhas 564 a 574 ---
564:                     ENDIF
565:                 ENDSCAN
566:                 loc_cOrcs = "(" + loc_cOrcs + ")"
567: 
568:                 *-- Carrega previsoes consolidadas por grupo/conta
569:                 loc_cQuery = "SELECT cGrupos, iClis, Sum(nValors) AS nValors " + ;
570:                              "FROM SigCdMrp " + ;
571:                              "WHERE cEmps+cMes+cAno+cTitulo+Moeda IN " + loc_cOrcs + ;
572:                              " GROUP BY cGrupos, iClis"
573:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crPrevisao")
574:                 IF loc_nResult < 1

--- BO Linhas 567 a 577 ---
567: 
568:                 *-- Carrega previsoes consolidadas por grupo/conta
569:                 loc_cQuery = "SELECT cGrupos, iClis, Sum(nValors) AS nValors " + ;
570:                              "FROM SigCdMrp " + ;
571:                              "WHERE cEmps+cMes+cAno+cTitulo+Moeda IN " + loc_cOrcs + ;
572:                              " GROUP BY cGrupos, iClis"
573:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crPrevisao")
574:                 IF loc_nResult < 1
575:                     THIS.this_cMensagemErro = "Falha ao carregar previs" + CHR(227) + "o (crPrevisao)"
576:                     MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
577:                     loc_lSucesso = .F.

--- BO Linhas 576 a 586 ---
576:                     MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
577:                     loc_lSucesso = .F.
578:                 ENDIF
579:                 SELECT crPrevisao
580:                 INDEX ON cGrupos TAG PrevGrp
581:                 INDEX ON iClis   TAG PrevCta
582:             ENDIF
583: 
584:             IF USED("crAux")
585:                 USE IN crAux
586:             ENDIF

--- BO Linhas 615 a 625 ---
615: 
616:             *-- ======================== SQL PRINCIPAL ========================
617:             *-- Busca movimentos de conta corrente com joins aos mapas/configs
618:             WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es de Conta Corrente..." NOWAIT
619: 
620:             loc_cQuery = "SELECT DISTINCT a.Grupos, a.Contas, " + ;
621:                 IIF(loc_nTpDat = 1, "a.DtEmis ", ;
622:                 IIF(loc_nTpDat = 2, "a.Datas ", ;
623:                 IIF(loc_nTpDat = 3, "a.Vencs ", ;
624:                 IIF(loc_nTpDat = 4, ;
625:                     "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end ", ;

--- BO Linhas 632 a 642 ---
632:                 "case when Not e.Acertos Is Null then e.Acertos " + ;
633:                 "else round((g.Acertos*((a.Valors/g.valos)*100)/100),2) end As Acertos, " + ;
634:                 "case when e.Cotacaos Is Null then g.Cotacaos else e.Cotacaos end As CotAcertos, " + ;
635:                 "c.TpDatas, a.EmpCcs " + ;
636:                 "FROM SigMvCcr a " + ;
637:                 "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
638:                 "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
639:                 "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
640:                 "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
641:                 "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
642:                 "LEFT JOIN SigCdPit g ON a.vOpers = (g.EmpOs + convert(varchar(9),g.nOpers)) " + ;

--- BO Linhas 633 a 643 ---
633:                 "else round((g.Acertos*((a.Valors/g.valos)*100)/100),2) end As Acertos, " + ;
634:                 "case when e.Cotacaos Is Null then g.Cotacaos else e.Cotacaos end As CotAcertos, " + ;
635:                 "c.TpDatas, a.EmpCcs " + ;
636:                 "FROM SigMvCcr a " + ;
637:                 "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
638:                 "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
639:                 "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
640:                 "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
641:                 "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
642:                 "LEFT JOIN SigCdPit g ON a.vOpers = (g.EmpOs + convert(varchar(9),g.nOpers)) " + ;
643:                 "LEFT JOIN SigCdPgr h ON g.Empdopnums = h.Empdopnums " + ;

--- BO Linhas 656 a 666 ---
656:                 IIF(EMPTY(loc_cEpr), "", ;
657:                     "AND (Case When a.EmpCcs <> '' And a.EmpCcs IN " + loc_cEpr + " Then 1 Else " + ;
658:                     "Case When a.EmpCcs = '' And a.Emps IN " + loc_cEpr + " Then 1 Else 0 End End) = 1 ") + ;
659:                 IIF(loc_nSnt = 3, "", ;
660:                     IIF(loc_nSnt = 1, "AND Not a.NFs = '          ' ", "AND a.NFs = '          ' ")) + ;
661:                 "ORDER BY a.Grupos, a.Contas, 3, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
662:                 "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.cIdChaves"
663: 
664:             loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpBal1")
665:             IF loc_nResult < 1
666:                 THIS.this_cMensagemErro = "Falha ao selecionar movimentos (TmpBal1)"

--- BO Linhas 668 a 678 ---
668:                 loc_lSucesso = .F.
669:             ENDIF
670:             WAIT CLEAR
671: 
672:             *-- Seleciona registros distintos de TmpBal1 ? cBal2
673:             SELECT DISTINCT Grupos, Contas, NVL(Datas, CTOT(SPACE(08))) AS Datas, ;
674:                 Valors, Svalors, Moedas, Smoedas, Cotacaos, Scotacaos, Opers, ;
675:                 IIF(!EMPTY(EmpCcs), EmpCcs, Emps) AS Emps, ;
676:                 Scontas, ContEms, cIdChaves, TpDatas ;
677:               FROM TmpBal1 ;
678:               INTO CURSOR cBal2 READWRITE

--- BO Linhas 685 a 695 ---
685:             ENDIF
686: 
687:             *-- =================== PROCESSA cBal2 ===================
688:             *-- Monta cursor anal?tico (Ps='5') com contas individuais
689:             SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
690:                 a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
691:                 VAL(STR(a.Valors * IIF(a.Opers == "D", 1, -1), 16, 2)) * d.Fators / 100 AS Valors, ;
692:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
693:                 "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
694:                 d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, a.Scontas, a.ContEms, ;
695:                 d.cpartidas, a.cIdChaves, 0000000000000.00 AS Previsao, ;

--- BO Linhas 694 a 704 ---
694:                 d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, a.Scontas, a.ContEms, ;
695:                 d.cpartidas, a.cIdChaves, 0000000000000.00 AS Previsao, ;
696:                 0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
697:                 SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms ;
698:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
699:              WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
700:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
701:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
702:              ORDER BY 1, 2, 4, 6 ;
703:               INTO CURSOR cBalCP READWRITE
704: 

--- BO Linhas 696 a 706 ---
696:                 0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
697:                 SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms ;
698:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
699:              WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
700:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
701:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
702:              ORDER BY 1, 2, 4, 6 ;
703:               INTO CURSOR cBalCP READWRITE
704: 
705:             *-- Conversao de moeda em cBal2
706:             loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, THIS.this_dDtFinal)

--- BO Linhas 757 a 767 ---
757:                     SELECT cBalCP
758:                     GATHER MEMVAR FIELDS Valors, Moedas
759:                 ENDIF
760:             ENDSCAN
761: 
762:             *-- Cursor de grupos (Ps='3') - resumo por classe
763:             SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
764:                 d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
765:                 SPACE(50) AS Ds_contas, ;
766:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
767:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;

--- BO Linhas 759 a 769 ---
759:                 ENDIF
760:             ENDSCAN
761: 
762:             *-- Cursor de grupos (Ps='3') - resumo por classe
763:             SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
764:                 d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
765:                 SPACE(50) AS Ds_contas, ;
766:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
767:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
768:                 "3" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
769:                 d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;

--- BO Linhas 771 a 781 ---
771:                 0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
772:                 SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
773:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
774:              WHERE d.Balancos == loc_cDmr AND d.TpRegs == 3 AND ;
775:                    LEFT(b.Classes, LEN(ALLTRIM(d.Classes))) = ALLTRIM(d.Classes) AND ;
776:                    b.Codigos == a.Grupos AND e.Classes == d.Classes ;
777:              GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
778:              ORDER BY 1, 2, 4, 6 ;
779:               INTO CURSOR cBal4
780: 
781:             *-- Cursor de contas (Ps='5') - contas individuais por grupo

--- BO Linhas 778 a 788 ---
778:              ORDER BY 1, 2, 4, 6 ;
779:               INTO CURSOR cBal4
780: 
781:             *-- Cursor de contas (Ps='5') - contas individuais por grupo
782:             SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
783:                 a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
784:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
785:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
786:                 "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
787:                 d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
788:                 d.cpartidas, 0000000000000.00 AS Previsao, ;

--- BO Linhas 787 a 797 ---
787:                 d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
788:                 d.cpartidas, 0000000000000.00 AS Previsao, ;
789:                 0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
790:                 SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
791:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
792:              WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
793:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
794:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
795:              GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
796:              ORDER BY 1, 2, 4, 6 ;
797:               INTO CURSOR cBal3

--- BO Linhas 789 a 799 ---
789:                 0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
790:                 SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
791:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
792:              WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
793:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
794:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
795:              GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
796:              ORDER BY 1, 2, 4, 6 ;
797:               INTO CURSOR cBal3
798: 
799:             *-- Cursor de contrapartidas (Ps='7') - detalhe por conta/scontas

--- BO Linhas 796 a 806 ---
796:              ORDER BY 1, 2, 4, 6 ;
797:               INTO CURSOR cBal3
798: 
799:             *-- Cursor de contrapartidas (Ps='7') - detalhe por conta/scontas
800:             SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
801:                 a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, a.Scontas, ;
802:                 SPACE(50) AS Ds_contas, ;
803:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
804:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
805:                 "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
806:                 d.Titulos, a.Emps ;

--- BO Linhas 803 a 813 ---
803:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
804:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
805:                 "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
806:                 d.Titulos, a.Emps ;
807:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
808:              WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
809:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
810:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
811:              GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
812:              ORDER BY 1, 2, 4, 6, 7 ;
813:               INTO CURSOR ContPart

--- BO Linhas 805 a 815 ---
805:                 "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
806:                 d.Titulos, a.Emps ;
807:               FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
808:              WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
809:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
810:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
811:              GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
812:              ORDER BY 1, 2, 4, 6, 7 ;
813:               INTO CURSOR ContPart
814: 
815:             *-- Une cBal3 + cBal4 no cursor principal do relatorio

--- BO Linhas 825 a 835 ---
825:             SELECT dbRelatorio
826:             GO TOP
827:             SCAN
828:                 loc_cConta = IIF(dbRelatorio.Ps = "7", dbRelatorio.sContas, dbRelatorio.Contas)
829:                 loc_nResult = SQLEXEC(gnConnHandle, ;
830:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
831:                     "TmpCli")
832:                 IF loc_nResult < 1
833:                     THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o de conta (TmpCli)"
834:                     MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
835:                     loc_lSucesso = .F.

--- BO Linhas 850 a 860 ---
850:             ENDIF
851: 
852:             *-- Indexa dbRelatorio para processamento posterior
853:             SELECT dbRelatorio
854:             INDEX ON Ordems                                              TAG Ordems
855:             INDEX ON Grupos                                              TAG Grupos
856:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
857:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
858:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
859:             INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno
860: 

--- BO Linhas 852 a 862 ---
852:             *-- Indexa dbRelatorio para processamento posterior
853:             SELECT dbRelatorio
854:             INDEX ON Ordems                                              TAG Ordems
855:             INDEX ON Grupos                                              TAG Grupos
856:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
857:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
858:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
859:             INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno
860: 
861:             *-- Insere grupos/classes sem transacoes (de crSigCdMri)
862:             SELECT crSigCdMri

--- BO Linhas 853 a 863 ---
853:             SELECT dbRelatorio
854:             INDEX ON Ordems                                              TAG Ordems
855:             INDEX ON Grupos                                              TAG Grupos
856:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
857:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
858:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
859:             INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno
860: 
861:             *-- Insere grupos/classes sem transacoes (de crSigCdMri)
862:             SELECT crSigCdMri
863:             SET ORDER TO "" IN crSigCdMri

--- BO Linhas 854 a 864 ---
854:             INDEX ON Ordems                                              TAG Ordems
855:             INDEX ON Grupos                                              TAG Grupos
856:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
857:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
858:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
859:             INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno
860: 
861:             *-- Insere grupos/classes sem transacoes (de crSigCdMri)
862:             SELECT crSigCdMri
863:             SET ORDER TO "" IN crSigCdMri
864:             SCAN

--- BO Linhas 856 a 866 ---
856:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
857:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
858:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
859:             INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno
860: 
861:             *-- Insere grupos/classes sem transacoes (de crSigCdMri)
862:             SELECT crSigCdMri
863:             SET ORDER TO "" IN crSigCdMri
864:             SCAN
865:                 IF crSigCdMri.Balancos = loc_cDmr AND ;
866:                    (!SEEK(crSigCdMri.Grupos, "dbRelatorio", "Grupos") OR crSigCdMri.TpRegs = 2)

--- BO Linhas 861 a 871 ---
861:             *-- Insere grupos/classes sem transacoes (de crSigCdMri)
862:             SELECT crSigCdMri
863:             SET ORDER TO "" IN crSigCdMri
864:             SCAN
865:                 IF crSigCdMri.Balancos = loc_cDmr AND ;
866:                    (!SEEK(crSigCdMri.Grupos, "dbRelatorio", "Grupos") OR crSigCdMri.TpRegs = 2)
867:                     SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
868:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
869:                     INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
870:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
871:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;

--- BO Linhas 862 a 872 ---
862:             SELECT crSigCdMri
863:             SET ORDER TO "" IN crSigCdMri
864:             SCAN
865:                 IF crSigCdMri.Balancos = loc_cDmr AND ;
866:                    (!SEEK(crSigCdMri.Grupos, "dbRelatorio", "Grupos") OR crSigCdMri.TpRegs = 2)
867:                     SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
868:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
869:                     INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
870:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
871:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;
872:                         VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;

--- BO Linhas 864 a 874 ---
864:             SCAN
865:                 IF crSigCdMri.Balancos = loc_cDmr AND ;
866:                    (!SEEK(crSigCdMri.Grupos, "dbRelatorio", "Grupos") OR crSigCdMri.TpRegs = 2)
867:                     SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
868:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
869:                     INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
870:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
871:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;
872:                         VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
873:                             crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
874:                             0, loc_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;

--- BO Linhas 868 a 878 ---
868:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
869:                     INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
870:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
871:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;
872:                         VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
873:                             crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
874:                             0, loc_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
875:                             IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
876:                             SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
877:                 ENDIF
878:             ENDSCAN

--- BO Linhas 879 a 889 ---
879: 
880:             SELECT crSigCdMri
881:             SET ORDER TO "" IN crSigCdMri
882:             GO TOP
883: 
884:             *-- Monta totais de grupos (Ps='4') para grupos analiticos
885:             SELECT dbRelatorio
886:             SET ORDER TO "" IN dbRelatorio
887:             GO TOP IN dbRelatorio
888:             DO WHILE !EOF("dbRelatorio")
889:                 IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1

--- BO Linhas 885 a 895 ---
885:             SELECT dbRelatorio
886:             SET ORDER TO "" IN dbRelatorio
887:             GO TOP IN dbRelatorio
888:             DO WHILE !EOF("dbRelatorio")
889:                 IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1
890:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
891:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
892:                     m.lnRec1    = RECNO("dbRelatorio")
893:                     m.Contas    = dbRelatorio.Grupos
894:                     m.Ds_contas = dbRelatorio.Ds_grupos
895:                     m.Valor     = 0

--- BO Linhas 888 a 898 ---
888:             DO WHILE !EOF("dbRelatorio")
889:                 IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1
890:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
891:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
892:                     m.lnRec1    = RECNO("dbRelatorio")
893:                     m.Contas    = dbRelatorio.Grupos
894:                     m.Ds_contas = dbRelatorio.Ds_grupos
895:                     m.Valor     = 0
896:                     m.lnValor   = dbRelatorio.Valor
897:                     m.Ps        = "4"
898:                     m.Fators    = dbRelatorio.Fators

--- BO Linhas 896 a 906 ---
896:                     m.lnValor   = dbRelatorio.Valor
897:                     m.Ps        = "4"
898:                     m.Fators    = dbRelatorio.Fators
899:                     m.DescClasse = dbRelatorio.DescClasse
900:                     m.Titulos   = dbRelatorio.Titulos
901:                     IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
902:                              "dbRelatorio", "Classes")
903:                         INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
904:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
905:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
906:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;

--- BO Linhas 898 a 908 ---
898:                     m.Fators    = dbRelatorio.Fators
899:                     m.DescClasse = dbRelatorio.DescClasse
900:                     m.Titulos   = dbRelatorio.Titulos
901:                     IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
902:                              "dbRelatorio", "Classes")
903:                         INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
904:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
905:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
906:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
907:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
908:                                 loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;

--- BO Linhas 901 a 911 ---
901:                     IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
902:                              "dbRelatorio", "Classes")
903:                         INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
904:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
905:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
906:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
907:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
908:                                 loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
909:                                 m.Ps, m.cOrdBals, m.Fators, m.DescClasse)
910:                     ENDIF
911:                     m.Valor = (dbRelatorio.Valor + m.lnValor)

--- BO Linhas 921 a 931 ---
921:             GO TOP
922:             DO WHILE !EOF("dbRelatorio")
923:                 IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1 AND ;
924:                    dbRelatorio.Cpartidas = 1 AND EMPTY(dbRelatorio.Scontas)
925:                     THIS.this_lContraPartida = .T.
926:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
927:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
928:                     m.lnRec1 = RECNO("dbRelatorio")
929:                     SELECT ContPart
930:                     SCAN FOR Grupos + Contas = m.Grupos + m.Contas
931:                         m.sContas    = ContPart.sContas

--- BO Linhas 925 a 935 ---
925:                     THIS.this_lContraPartida = .T.
926:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
927:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
928:                     m.lnRec1 = RECNO("dbRelatorio")
929:                     SELECT ContPart
930:                     SCAN FOR Grupos + Contas = m.Grupos + m.Contas
931:                         m.sContas    = ContPart.sContas
932:                         m.Ds_contas  = ContPart.Ds_Contas
933:                         m.Valor      = ContPart.Valor
934:                         m.lnValor    = ContPart.Valor
935:                         m.Ps         = "5"

--- BO Linhas 934 a 944 ---
934:                         m.lnValor    = ContPart.Valor
935:                         m.Ps         = "5"
936:                         m.Fators     = ContPart.Fators
937:                         m.DescClasse = ContPart.DescClasse
938:                         m.Titulos    = ContPart.Titulos
939:                         INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
940:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
941:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
942:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
943:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
944:                                 loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;

--- BO Linhas 937 a 947 ---
937:                         m.DescClasse = ContPart.DescClasse
938:                         m.Titulos    = ContPart.Titulos
939:                         INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
940:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
941:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
942:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
943:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
944:                                 loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
945:                                 m.Ps, m.cOrdBals, m.Fators, m.DescClasse, m.sContas, m.Valor)
946:                     ENDSCAN
947:                     SELECT dbRelatorio

--- BO Linhas 955 a 965 ---
955:             =SEEK("", "dbRelatorio", "Classes")
956: 
957:             SELECT dbRelatorio
958:             SCAN
959:                 SELECT crSigCdMri
960:                 IF !EMPTY(dbRelatorio.Grupos)
961:                     IF dbRelatorio.Grupos <> "SubTotal"
962:                         SET ORDER TO Grupos
963:                         SEEK loc_cDmr + dbRelatorio.Grupos
964:                     ELSE
965:                         SET ORDER TO DescGrps

--- BO Linhas 956 a 966 ---
956: 
957:             SELECT dbRelatorio
958:             SCAN
959:                 SELECT crSigCdMri
960:                 IF !EMPTY(dbRelatorio.Grupos)
961:                     IF dbRelatorio.Grupos <> "SubTotal"
962:                         SET ORDER TO Grupos
963:                         SEEK loc_cDmr + dbRelatorio.Grupos
964:                     ELSE
965:                         SET ORDER TO DescGrps
966:                         SEEK loc_cDmr + dbRelatorio.Ds_Grupos

--- BO Linhas 957 a 967 ---
957:             SELECT dbRelatorio
958:             SCAN
959:                 SELECT crSigCdMri
960:                 IF !EMPTY(dbRelatorio.Grupos)
961:                     IF dbRelatorio.Grupos <> "SubTotal"
962:                         SET ORDER TO Grupos
963:                         SEEK loc_cDmr + dbRelatorio.Grupos
964:                     ELSE
965:                         SET ORDER TO DescGrps
966:                         SEEK loc_cDmr + dbRelatorio.Ds_Grupos
967:                     ENDIF

--- BO Linhas 958 a 968 ---
958:             SCAN
959:                 SELECT crSigCdMri
960:                 IF !EMPTY(dbRelatorio.Grupos)
961:                     IF dbRelatorio.Grupos <> "SubTotal"
962:                         SET ORDER TO Grupos
963:                         SEEK loc_cDmr + dbRelatorio.Grupos
964:                     ELSE
965:                         SET ORDER TO DescGrps
966:                         SEEK loc_cDmr + dbRelatorio.Ds_Grupos
967:                     ENDIF
968:                 ELSE

--- BO Linhas 1009 a 1019 ---
1009:                             REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
1010:                             loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
1011:                         ENDIF
1012:                     ENDIF
1013:                     IF (dbRelatorio.Ps = "4" OR (dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2)) AND ;
1014:                        !EMPTY(dbRelatorio.Grupos)
1015:                         IF SEEK(dbRelatorio.Grupos, "crPrevisao", "PrevGrp")
1016:                             loc_lnVlrPrev = crPrevisao.nValors * (loc_lnCot1 / loc_lnCot2)
1017:                             REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
1018:                             loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
1019:                         ENDIF

--- BO Linhas 1010 a 1020 ---
1010:                             loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
1011:                         ENDIF
1012:                     ENDIF
1013:                     IF (dbRelatorio.Ps = "4" OR (dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2)) AND ;
1014:                        !EMPTY(dbRelatorio.Grupos)
1015:                         IF SEEK(dbRelatorio.Grupos, "crPrevisao", "PrevGrp")
1016:                             loc_lnVlrPrev = crPrevisao.nValors * (loc_lnCot1 / loc_lnCot2)
1017:                             REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
1018:                             loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
1019:                         ENDIF
1020:                     ENDIF

--- BO Linhas 1023 a 1033 ---
1023:                 SELECT dbRelatorio
1024:                 SET ORDER TO dRecno
1025:                 GO TOP
1026: 
1027:                 *-- Inserir contas sem realizado
1028:                 SELECT iClis, nValors FROM crPrevisao ;
1029:                     WHERE iClis NOT IN (SELECT Contas FROM dbRelatorio) ;
1030:                     INTO CURSOR crAdicionar READWRITE
1031:                 SELECT crAdicionar
1032:                 GO TOP
1033:                 SCAN

--- BO Linhas 1024 a 1034 ---
1024:                 SET ORDER TO dRecno
1025:                 GO TOP
1026: 
1027:                 *-- Inserir contas sem realizado
1028:                 SELECT iClis, nValors FROM crPrevisao ;
1029:                     WHERE iClis NOT IN (SELECT Contas FROM dbRelatorio) ;
1030:                     INTO CURSOR crAdicionar READWRITE
1031:                 SELECT crAdicionar
1032:                 GO TOP
1033:                 SCAN
1034:                     loc_nResult = SQLEXEC(gnConnHandle, ;

--- BO Linhas 1030 a 1040 ---
1030:                     INTO CURSOR crAdicionar READWRITE
1031:                 SELECT crAdicionar
1032:                 GO TOP
1033:                 SCAN
1034:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1035:                         "SELECT Grupos, rClis FROM SigCdCli WHERE iClis = " + EscaparSQL(crAdicionar.iClis), ;
1036:                         "crGrupoCta")
1037:                     IF loc_nResult > 0
1038:                         SELECT cGrupos FROM dbRelatorio WHERE Grupos = crGrupoCta.Grupos ;
1039:                             INTO CURSOR crAux READWRITE
1040:                         SELECT crAux

--- BO Linhas 1033 a 1043 ---
1033:                 SCAN
1034:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1035:                         "SELECT Grupos, rClis FROM SigCdCli WHERE iClis = " + EscaparSQL(crAdicionar.iClis), ;
1036:                         "crGrupoCta")
1037:                     IF loc_nResult > 0
1038:                         SELECT cGrupos FROM dbRelatorio WHERE Grupos = crGrupoCta.Grupos ;
1039:                             INTO CURSOR crAux READWRITE
1040:                         SELECT crAux
1041:                         IF !EOF("crAux")
1042:                             SELECT dbRelatorio
1043:                             GO TOP

--- BO Linhas 1039 a 1049 ---
1039:                             INTO CURSOR crAux READWRITE
1040:                         SELECT crAux
1041:                         IF !EOF("crAux")
1042:                             SELECT dbRelatorio
1043:                             GO TOP
1044:                             LOCATE FOR Grupos = crGrupoCta.Grupos
1045:                             IF !EOF()
1046:                                 SCATTER MEMVAR MEMO
1047:                                 m.Contas    = crAdicionar.iClis
1048:                                 m.Ds_Contas = crGrupoCta.rClis
1049:                                 m.Valor     = 0

--- BO Linhas 1042 a 1052 ---
1042:                             SELECT dbRelatorio
1043:                             GO TOP
1044:                             LOCATE FOR Grupos = crGrupoCta.Grupos
1045:                             IF !EOF()
1046:                                 SCATTER MEMVAR MEMO
1047:                                 m.Contas    = crAdicionar.iClis
1048:                                 m.Ds_Contas = crGrupoCta.rClis
1049:                                 m.Valor     = 0
1050:                                 m.Ps        = "5"
1051:                                 m.dRecno    = m.dRecno + 1
1052:                                 m.Previsao  = crAdicionar.nValors

--- BO Linhas 1065 a 1075 ---
1065:                 ENDSCAN
1066:                 IF USED("crAdicionar")
1067:                     USE IN crAdicionar
1068:                 ENDIF
1069: 
1070:                 *-- Totais dos grupos apos insercao
1071:                 SELECT Ordems, Grupos, Ds_Grupos FROM dbRelatorio WHERE Ps = "6" ;
1072:                     INTO CURSOR crAux READWRITE
1073:                 SELECT crAux
1074:                 SCAN
1075:                     SELECT NVL(SUM(Previsao), 0) AS TotPrev FROM dbRelatorio ;

--- BO Linhas 1066 a 1076 ---
1066:                 IF USED("crAdicionar")
1067:                     USE IN crAdicionar
1068:                 ENDIF
1069: 
1070:                 *-- Totais dos grupos apos insercao
1071:                 SELECT Ordems, Grupos, Ds_Grupos FROM dbRelatorio WHERE Ps = "6" ;
1072:                     INTO CURSOR crAux READWRITE
1073:                 SELECT crAux
1074:                 SCAN
1075:                     SELECT NVL(SUM(Previsao), 0) AS TotPrev FROM dbRelatorio ;
1076:                         WHERE Ordems < crAux.Ordems AND Ps <> "6" ;

--- BO Linhas 1076 a 1086 ---
1076:                         WHERE Ordems < crAux.Ordems AND Ps <> "6" ;
1077:                         INTO CURSOR crTot READWRITE
1078:                     SELECT crTot
1079:                     IF crTot.TotPrev <> 0
1080:                         UPDATE dbRelatorio SET Previsao = crTot.TotPrev ;
1081:                             WHERE Ps = "6" AND Grupos = crAux.Grupos AND ;
1082:                             Ds_Grupos = crAux.Ds_Grupos
1083:                     ENDIF
1084:                     IF USED("crTot")
1085:                         USE IN crTot
1086:                     ENDIF

--- BO Linhas 1100 a 1110 ---
1100:                 SELECT dbRelatorio
1101:                 GO TOP
1102:                 SCAN
1103:                     IF dbRelatorio.Ps = "6"
1104:                         SELECT crSigCdMri
1105:                         SET ORDER TO Grupos
1106:                         SEEK loc_cDmr + dbRelatorio.Grupos + STR(dbRelatorio.Ordems, 3)
1107:                         IF PEMSTATUS(crSigCdMri, "SubTot100s", 5) AND crSigCdMri.SubTot100s = 1
1108:                             loc_lnTotOrcado = dbRelatorio.Previsao
1109:                             loc_lnTotReal   = dbRelatorio.Valor
1110:                             loc_lnRecTroca  = RECNO("dbRelatorio")

--- BO Linhas 1101 a 1111 ---
1101:                 GO TOP
1102:                 SCAN
1103:                     IF dbRelatorio.Ps = "6"
1104:                         SELECT crSigCdMri
1105:                         SET ORDER TO Grupos
1106:                         SEEK loc_cDmr + dbRelatorio.Grupos + STR(dbRelatorio.Ordems, 3)
1107:                         IF PEMSTATUS(crSigCdMri, "SubTot100s", 5) AND crSigCdMri.SubTot100s = 1
1108:                             loc_lnTotOrcado = dbRelatorio.Previsao
1109:                             loc_lnTotReal   = dbRelatorio.Valor
1110:                             loc_lnRecTroca  = RECNO("dbRelatorio")
1111:                             REPLACE PercPrev WITH 100, PercGrp WITH 100 IN dbRelatorio

--- BO Linhas 1129 a 1139 ---
1129:                         GO loc_lnRecTroca IN dbRelatorio
1130:                     ENDIF
1131: 
1132:                     IF dbRelatorio.Ps = "3"
1133:                         loc_cQuery = "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
1134:                             "INNER JOIN SigCdCli b ON b.iClis = a.iClis " + ;
1135:                             "INNER JOIN SigCdGcr c ON c.Codigos = b.Grupos " + ;
1136:                             "WHERE c.Classes = " + EscaparSQL(dbRelatorio.Classes) + ;
1137:                             " AND a.cEmps+a.cMes+a.cAno+a.cTitulo+a.Moeda IN " + loc_cOrcs + ;
1138:                             " UNION ALL " + ;
1139:                             "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;

--- BO Linhas 1130 a 1140 ---
1130:                     ENDIF
1131: 
1132:                     IF dbRelatorio.Ps = "3"
1133:                         loc_cQuery = "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
1134:                             "INNER JOIN SigCdCli b ON b.iClis = a.iClis " + ;
1135:                             "INNER JOIN SigCdGcr c ON c.Codigos = b.Grupos " + ;
1136:                             "WHERE c.Classes = " + EscaparSQL(dbRelatorio.Classes) + ;
1137:                             " AND a.cEmps+a.cMes+a.cAno+a.cTitulo+a.Moeda IN " + loc_cOrcs + ;
1138:                             " UNION ALL " + ;
1139:                             "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
1140:                             "INNER JOIN SigCdGcr b ON b.Codigos = a.cGrupos " + ;

--- BO Linhas 1156 a 1166 ---
1156: 
1157:                     IF dbRelatorio.Ps = "4"
1158:                         SELECT NVL(SUM(a.Previsao), 0) AS TotPrev FROM dbRelatorio a ;
1159:                             WHERE a.Ordems = dbRelatorio.Ordems AND ;
1160:                                   a.Classes = dbRelatorio.Classes AND ;
1161:                                   a.Grupos = dbRelatorio.Grupos AND ;
1162:                                   a.Ps = "5" ;
1163:                             INTO CURSOR crTotPrev READWRITE
1164:                         SELECT crTotPrev
1165:                         IF crTotPrev.TotPrev <> 0
1166:                             REPLACE Previsao WITH Previsao + crTotPrev.TotPrev IN dbRelatorio

--- BO Linhas 1173 a 1183 ---
1173:                     IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2
1174:                         SELECT NVL(SUM(a.Previsao), 0) AS TotPrev, ;
1175:                                SUM(a.Valor) AS TotReal FROM dbRelatorio a ;
1176:                             WHERE a.Ordems = dbRelatorio.Ordems AND ;
1177:                                   a.Classes = dbRelatorio.Classes AND ;
1178:                                   a.Grupos = dbRelatorio.Grupos AND ;
1179:                                   a.Ps = "5" ;
1180:                             INTO CURSOR crTotPrev READWRITE
1181:                         REPLACE PercGrp  WITH IIF(loc_lnTotReal <> 0, ;
1182:                                     ROUND((ABS(crTotPrev.TotReal)/ABS(loc_lnTotReal))*100,2),0), ;
1183:                                 PercPrev WITH IIF(loc_lnTotOrcado <> 0, ;

--- BO Linhas 1246 a 1256 ---
1246:                     USE IN crTmp
1247:                 ENDIF
1248: 
1249:                 SELECT dbRelatorio
1250:                 INDEX ON Ordems                                              TAG Ordems
1251:                 INDEX ON Grupos                                              TAG Grupos
1252:                 INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1253:                 INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1254:                 INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1255:                 INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1256:                 SET ORDER TO dRecno

--- BO Linhas 1248 a 1258 ---
1248: 
1249:                 SELECT dbRelatorio
1250:                 INDEX ON Ordems                                              TAG Ordems
1251:                 INDEX ON Grupos                                              TAG Grupos
1252:                 INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1253:                 INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1254:                 INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1255:                 INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1256:                 SET ORDER TO dRecno
1257: 
1258:                 SELECT dbCompara

--- BO Linhas 1249 a 1259 ---
1249:                 SELECT dbRelatorio
1250:                 INDEX ON Ordems                                              TAG Ordems
1251:                 INDEX ON Grupos                                              TAG Grupos
1252:                 INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1253:                 INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1254:                 INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1255:                 INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1256:                 SET ORDER TO dRecno
1257: 
1258:                 SELECT dbCompara
1259:                 INDEX ON Classes + Grupos + ds_Grupos + Contas TAG skGroup

--- BO Linhas 1250 a 1260 ---
1250:                 INDEX ON Ordems                                              TAG Ordems
1251:                 INDEX ON Grupos                                              TAG Grupos
1252:                 INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1253:                 INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1254:                 INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1255:                 INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1256:                 SET ORDER TO dRecno
1257: 
1258:                 SELECT dbCompara
1259:                 INDEX ON Classes + Grupos + ds_Grupos + Contas TAG skGroup
1260: 

--- BO Linhas 1254 a 1264 ---
1254:                 INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1255:                 INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1256:                 SET ORDER TO dRecno
1257: 
1258:                 SELECT dbCompara
1259:                 INDEX ON Classes + Grupos + ds_Grupos + Contas TAG skGroup
1260: 
1261:                 SELECT dbRelatorio
1262:                 GO TOP IN dbRelatorio
1263:                 SCAN
1264:                     IF SEEK(dbRelatorio.Classes+dbRelatorio.Grupos+ ;

--- BO Linhas 1259 a 1269 ---
1259:                 INDEX ON Classes + Grupos + ds_Grupos + Contas TAG skGroup
1260: 
1261:                 SELECT dbRelatorio
1262:                 GO TOP IN dbRelatorio
1263:                 SCAN
1264:                     IF SEEK(dbRelatorio.Classes+dbRelatorio.Grupos+ ;
1265:                             dbRelatorio.ds_Grupos+dbRelatorio.Contas, ;
1266:                             "dbCompara", "skGroup") AND dbCompara.Valor <> 0
1267:                         REPLACE VlrComp WITH dbCompara.Valor IN dbRelatorio
1268:                         REPLACE VarComp WITH ROUND(((Valor/VlrComp)-1)*100, 2) IN dbRelatorio
1269:                     ELSE

--- BO Linhas 1280 a 1290 ---
1280:                     ENDIF
1281:                 ENDSCAN
1282: 
1283:                 *-- Adiciona registros do comparativo que nao existem no atual
1284:                 SELECT * FROM dbCompara ;
1285:                     WHERE Classes+Grupos+ds_Grupos+Contas NOT IN ;
1286:                     (SELECT Classes+Grupos+ds_Grupos+Contas FROM dbRelatorio) ;
1287:                     INTO CURSOR crAdiciona READWRITE
1288:                 SELECT crAdiciona
1289:                 SCAN
1290:                     SCATTER MEMVAR MEMO

--- BO Linhas 1281 a 1291 ---
1281:                 ENDSCAN
1282: 
1283:                 *-- Adiciona registros do comparativo que nao existem no atual
1284:                 SELECT * FROM dbCompara ;
1285:                     WHERE Classes+Grupos+ds_Grupos+Contas NOT IN ;
1286:                     (SELECT Classes+Grupos+ds_Grupos+Contas FROM dbRelatorio) ;
1287:                     INTO CURSOR crAdiciona READWRITE
1288:                 SELECT crAdiciona
1289:                 SCAN
1290:                     SCATTER MEMVAR MEMO
1291:                     m.VlrComp = m.Valor

--- BO Linhas 1301 a 1311 ---
1301:                 SELECT dbRelatorio
1302:                 =SEEK("", "dbRelatorio", "Classes")
1303:                 SELECT dbRelatorio
1304:                 SCAN
1305:                     SELECT crSigCdMri
1306:                     IF !EMPTY(dbRelatorio.Grupos)
1307:                         IF dbRelatorio.Grupos <> "SubTotal"
1308:                             SET ORDER TO Grupos
1309:                             SEEK loc_cDmr + dbRelatorio.Grupos
1310:                         ELSE
1311:                             SET ORDER TO DescGrps

--- BO Linhas 1302 a 1312 ---
1302:                 =SEEK("", "dbRelatorio", "Classes")
1303:                 SELECT dbRelatorio
1304:                 SCAN
1305:                     SELECT crSigCdMri
1306:                     IF !EMPTY(dbRelatorio.Grupos)
1307:                         IF dbRelatorio.Grupos <> "SubTotal"
1308:                             SET ORDER TO Grupos
1309:                             SEEK loc_cDmr + dbRelatorio.Grupos
1310:                         ELSE
1311:                             SET ORDER TO DescGrps
1312:                             SEEK loc_cDmr + dbRelatorio.Ds_Grupos

--- BO Linhas 1303 a 1313 ---
1303:                 SELECT dbRelatorio
1304:                 SCAN
1305:                     SELECT crSigCdMri
1306:                     IF !EMPTY(dbRelatorio.Grupos)
1307:                         IF dbRelatorio.Grupos <> "SubTotal"
1308:                             SET ORDER TO Grupos
1309:                             SEEK loc_cDmr + dbRelatorio.Grupos
1310:                         ELSE
1311:                             SET ORDER TO DescGrps
1312:                             SEEK loc_cDmr + dbRelatorio.Ds_Grupos
1313:                         ENDIF

--- BO Linhas 1304 a 1314 ---
1304:                 SCAN
1305:                     SELECT crSigCdMri
1306:                     IF !EMPTY(dbRelatorio.Grupos)
1307:                         IF dbRelatorio.Grupos <> "SubTotal"
1308:                             SET ORDER TO Grupos
1309:                             SEEK loc_cDmr + dbRelatorio.Grupos
1310:                         ELSE
1311:                             SET ORDER TO DescGrps
1312:                             SEEK loc_cDmr + dbRelatorio.Ds_Grupos
1313:                         ENDIF
1314:                     ELSE

--- BO Linhas 1351 a 1361 ---
1351:                 SELECT * FROM dbRelatorio WHERE 0 = 1 INTO CURSOR TmpRelat1 READWRITE
1352:                 SELECT dbRelatorio
1353:                 SCAN
1354:                     SCATTER MEMVAR MEMO
1355:                     SELECT cBalCP
1356:                     SCAN FOR (cBalCP.Grupos = dbRelatorio.Grupos) AND ;
1357:                               (cBalCP.Contas = dbRelatorio.Contas)
1358:                         m.Valor   = cBalCP.Valors
1359:                         m.Scontas = cBalCP.SContas
1360:                         m.ContEms = cBalCP.ContEms
1361:                         INSERT INTO TmpRelat1 FROM MEMVAR

--- BO Linhas 1366 a 1376 ---
1366:                 SCAN
1367:                     SCATTER MEMVAR MEMO
1368:                     INSERT INTO dbRelatorio FROM MEMVAR
1369:                     IF !EMPTY(dbRelatorio.SContas)
1370:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1371:                             "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1372:                             EscaparSQL(dbRelatorio.SContas), "TmpCli")
1373:                         IF loc_nResult > 0
1374:                             SELECT TmpCli
1375:                             GO TOP
1376:                             IF !EOF()

--- BO Linhas 1378 a 1388 ---
1378:                             ENDIF
1379:                         ENDIF
1380:                     ENDIF
1381:                     IF !EMPTY(dbRelatorio.ContEms)
1382:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1383:                             "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1384:                             EscaparSQL(dbRelatorio.ContEms), "TmpCli")
1385:                         IF loc_nResult > 0
1386:                             SELECT TmpCli
1387:                             GO TOP
1388:                             IF !EOF()

--- BO Linhas 1406 a 1416 ---
1406:             *-- Busca descricao de SContas
1407:             SELECT dbRelatorio
1408:             SCAN
1409:                 IF !EMPTY(dbRelatorio.SContas)
1410:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1411:                         "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1412:                         EscaparSQL(dbRelatorio.SContas), "TmpCli")
1413:                     IF loc_nResult < 1
1414:                         THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o de scontas"
1415:                         MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
1416:                         loc_lSucesso = .F.

--- BO Linhas 1466 a 1476 ---
1466:             loc_nTpDat = THIS.this_nTipoDatas
1467:             pDcI = THIS.this_dCompInicial
1468:             pDcF = THIS.this_dCompFinal
1469: 
1470:             *-- SQL para movimentos do periodo comparativo
1471:             loc_cQuery = "SELECT a.Grupos, a.Contas, " + ;
1472:                 IIF(loc_nTpDat = 1, "a.DtEmis ", ;
1473:                 IIF(loc_nTpDat = 2, "a.Datas ", ;
1474:                 IIF(loc_nTpDat = 3, "a.Vencs ", ;
1475:                 IIF(loc_nTpDat = 4, ;
1476:                     "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end ", ;

--- BO Linhas 1480 a 1490 ---
1480:                     "End End End ")))) + ;
1481:                 "AS Datas, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
1482:                 "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.ContEms, a.cIdChaves, " + ;
1483:                 "e.Acertos, e.Cotacaos AS CotAcertos, c.TpDatas, a.EmpCcs " + ;
1484:                 "FROM SigMvCcr a " + ;
1485:                 "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
1486:                 "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1487:                 "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
1488:                 "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
1489:                 "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
1490:                 "WHERE c.Balancos = " + EscaparSQL(par_cDem) + " AND " + ;

--- BO Linhas 1481 a 1491 ---
1481:                 "AS Datas, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
1482:                 "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.ContEms, a.cIdChaves, " + ;
1483:                 "e.Acertos, e.Cotacaos AS CotAcertos, c.TpDatas, a.EmpCcs " + ;
1484:                 "FROM SigMvCcr a " + ;
1485:                 "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
1486:                 "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1487:                 "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
1488:                 "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
1489:                 "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
1490:                 "WHERE c.Balancos = " + EscaparSQL(par_cDem) + " AND " + ;
1491:                 IIF(loc_nTpDat = 1, "a.DtEmis BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;

--- BO Linhas 1502 a 1512 ---
1502:                 IIF(EMPTY(par_cEpr), "", ;
1503:                     "AND (Case When a.EmpCcs <> '' And a.EmpCcs IN " + par_cEpr + " Then 1 Else " + ;
1504:                     "Case When a.EmpCcs = '' And a.Emps IN " + par_cEpr + " Then 1 Else 0 End End) = 1 ") + ;
1505:                 IIF(THIS.this_nSnt = 3, "", ;
1506:                     IIF(THIS.this_nSnt = 1, "AND Not a.NFs = '          ' ", "AND a.NFs = '          ' ")) + ;
1507:                 "ORDER BY a.Grupos, a.Contas, 3, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
1508:                 "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.cIdChaves"
1509: 
1510:             loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpBalC")
1511:             IF loc_nResult < 1
1512:                 THIS.this_cMensagemErro = "Falha ao selecionar comparativo (TmpBalC)"

--- BO Linhas 1514 a 1524 ---
1514:                 loc_lSucesso = .F.
1515:             ENDIF
1516:             WAIT CLEAR
1517: 
1518:             *-- Distincts de TmpBalC ? cBalC
1519:             SELECT DISTINCT Grupos, Contas, NVL(Datas, CTOT(SPACE(08))) AS Datas, ;
1520:                 Valors, Svalors, Moedas, Smoedas, Cotacaos, Scotacaos, Opers, ;
1521:                 IIF(!EMPTY(EmpCcs), EmpCcs, Emps) AS Emps, ;
1522:                 Scontas, ContEms, cIdChaves, TpDatas ;
1523:               FROM TmpBalC ;
1524:               INTO CURSOR cBalC READWRITE

--- BO Linhas 1573 a 1583 ---
1573:                 GATHER MEMVAR FIELDS Valors, Moedas
1574:             ENDSCAN
1575: 
1576:             loc_cGroup = IIF(par_lPep, "19, 2", "2")
1577: 
1578:             *-- Cursor de grupos (Ps='3') do comparativo
1579:             SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
1580:                 d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
1581:                 SPACE(50) AS Ds_contas, ;
1582:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
1583:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;

--- BO Linhas 1575 a 1585 ---
1575: 
1576:             loc_cGroup = IIF(par_lPep, "19, 2", "2")
1577: 
1578:             *-- Cursor de grupos (Ps='3') do comparativo
1579:             SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
1580:                 d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
1581:                 SPACE(50) AS Ds_contas, ;
1582:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
1583:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
1584:                 "3" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
1585:                 d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;

--- BO Linhas 1586 a 1596 ---
1586:                 d.cpartidas, 0000000000000.00 AS Previsao, ;
1587:                 0000.00 AS PercPrev, 0000.00 AS PercGrp ;
1588:               FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
1589:              WHERE d.Balancos == par_cDem AND d.TpRegs == 3 AND ;
1590:                    LEFT(b.Classes, LEN(ALLTRIM(d.Classes))) = ALLTRIM(d.Classes) AND ;
1591:                    b.Codigos == a.Grupos AND e.Classes == d.Classes ;
1592:              GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
1593:              ORDER BY 1, 2, 4, 6 ;
1594:               INTO CURSOR cBal4C
1595: 
1596:             *-- Cursor de contas (Ps='5') do comparativo

--- BO Linhas 1593 a 1603 ---
1593:              ORDER BY 1, 2, 4, 6 ;
1594:               INTO CURSOR cBal4C
1595: 
1596:             *-- Cursor de contas (Ps='5') do comparativo
1597:             SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
1598:                 a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
1599:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
1600:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
1601:                 "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
1602:                 d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
1603:                 d.cpartidas, 0000000000000.00 AS Previsao, ;

--- BO Linhas 1601 a 1611 ---
1601:                 "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
1602:                 d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
1603:                 d.cpartidas, 0000000000000.00 AS Previsao, ;
1604:                 0000.00 AS PercPrev, 0000.00 AS PercGrp ;
1605:               FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
1606:              WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
1607:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
1608:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
1609:              GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
1610:              ORDER BY 1, 2, 4, 6 ;
1611:               INTO CURSOR cBal3C

--- BO Linhas 1603 a 1613 ---
1603:                 d.cpartidas, 0000000000000.00 AS Previsao, ;
1604:                 0000.00 AS PercPrev, 0000.00 AS PercGrp ;
1605:               FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
1606:              WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
1607:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
1608:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
1609:              GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
1610:              ORDER BY 1, 2, 4, 6 ;
1611:               INTO CURSOR cBal3C
1612: 
1613:             *-- Cursor de contrapartida do comparativo

--- BO Linhas 1610 a 1620 ---
1610:              ORDER BY 1, 2, 4, 6 ;
1611:               INTO CURSOR cBal3C
1612: 
1613:             *-- Cursor de contrapartida do comparativo
1614:             SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
1615:                 a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, a.Scontas, ;
1616:                 SPACE(50) AS Ds_contas, ;
1617:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
1618:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
1619:                 "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
1620:                 d.Titulos, a.Emps ;

--- BO Linhas 1617 a 1627 ---
1617:                 VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
1618:                 a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
1619:                 "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
1620:                 d.Titulos, a.Emps ;
1621:               FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
1622:              WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
1623:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
1624:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
1625:              GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
1626:              ORDER BY 1, 2, 4, 6, 7 ;
1627:               INTO CURSOR ContPartC

--- BO Linhas 1619 a 1629 ---
1619:                 "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
1620:                 d.Titulos, a.Emps ;
1621:               FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
1622:              WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
1623:                    !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
1624:                    b.Codigos == a.Grupos AND e.Classes == b.Classes ;
1625:              GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
1626:              ORDER BY 1, 2, 4, 6, 7 ;
1627:               INTO CURSOR ContPartC
1628: 
1629:             *-- Une cBal3C + cBal4C ? dbCompara

--- BO Linhas 1641 a 1651 ---
1641:             *-- Busca descricao de contas em SigCdCli
1642:             WAIT WINDOW "Aguarde!!! Analisando Registros do Comparativo..." NOWAIT
1643:             SELECT dbCompara
1644:             GO TOP
1645:             SCAN
1646:                 loc_cQuery = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1647:                              EscaparSQL(IIF(dbCompara.Ps = "7", dbCompara.sContas, dbCompara.Contas))
1648:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpCli")
1649:                 IF loc_nResult < 1
1650:                     THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o (TmpCli) no comparativo"
1651:                     MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararComparativo")

--- BO Linhas 1661 a 1671 ---
1661:             WAIT CLEAR
1662: 
1663:             *-- Indexa dbCompara
1664:             SELECT dbCompara
1665:             INDEX ON Ordems                                              TAG Ordems
1666:             INDEX ON Grupos                                              TAG Grupos
1667:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1668:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1669:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1670:             INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1671: 

--- BO Linhas 1663 a 1673 ---
1663:             *-- Indexa dbCompara
1664:             SELECT dbCompara
1665:             INDEX ON Ordems                                              TAG Ordems
1666:             INDEX ON Grupos                                              TAG Grupos
1667:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1668:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1669:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1670:             INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1671: 
1672:             *-- Insere grupos/classes sem transacoes
1673:             loc_lcClaAnt = SPACE(10)

--- BO Linhas 1664 a 1674 ---
1664:             SELECT dbCompara
1665:             INDEX ON Ordems                                              TAG Ordems
1666:             INDEX ON Grupos                                              TAG Grupos
1667:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1668:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1669:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1670:             INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1671: 
1672:             *-- Insere grupos/classes sem transacoes
1673:             loc_lcClaAnt = SPACE(10)
1674:             SELECT crSigCdMri

--- BO Linhas 1665 a 1675 ---
1665:             INDEX ON Ordems                                              TAG Ordems
1666:             INDEX ON Grupos                                              TAG Grupos
1667:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1668:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1669:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1670:             INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1671: 
1672:             *-- Insere grupos/classes sem transacoes
1673:             loc_lcClaAnt = SPACE(10)
1674:             SELECT crSigCdMri
1675:             SET ORDER TO "" IN crSigCdMri

--- BO Linhas 1667 a 1677 ---
1667:             INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
1668:             INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
1669:             INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
1670:             INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
1671: 
1672:             *-- Insere grupos/classes sem transacoes
1673:             loc_lcClaAnt = SPACE(10)
1674:             SELECT crSigCdMri
1675:             SET ORDER TO "" IN crSigCdMri
1676:             SCAN
1677:                 IF crSigCdMri.Balancos = par_cDem AND ;

--- BO Linhas 1673 a 1683 ---
1673:             loc_lcClaAnt = SPACE(10)
1674:             SELECT crSigCdMri
1675:             SET ORDER TO "" IN crSigCdMri
1676:             SCAN
1677:                 IF crSigCdMri.Balancos = par_cDem AND ;
1678:                    (!SEEK(crSigCdMri.Grupos, "dbCompara", "Grupos") OR crSigCdMri.TpRegs = 2)
1679:                     SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
1680:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
1681:                     INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1682:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
1683:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;

--- BO Linhas 1674 a 1684 ---
1674:             SELECT crSigCdMri
1675:             SET ORDER TO "" IN crSigCdMri
1676:             SCAN
1677:                 IF crSigCdMri.Balancos = par_cDem AND ;
1678:                    (!SEEK(crSigCdMri.Grupos, "dbCompara", "Grupos") OR crSigCdMri.TpRegs = 2)
1679:                     SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
1680:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
1681:                     INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1682:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
1683:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;
1684:                         VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;

--- BO Linhas 1676 a 1686 ---
1676:             SCAN
1677:                 IF crSigCdMri.Balancos = par_cDem AND ;
1678:                    (!SEEK(crSigCdMri.Grupos, "dbCompara", "Grupos") OR crSigCdMri.TpRegs = 2)
1679:                     SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
1680:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
1681:                     INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1682:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
1683:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;
1684:                         VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
1685:                             crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
1686:                             0, par_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;

--- BO Linhas 1680 a 1690 ---
1680:                     SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
1681:                     INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1682:                         Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
1683:                         Ps, cOrdBals, Fators, DescClasse, Titulos) ;
1684:                         VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
1685:                             crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
1686:                             0, par_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
1687:                             IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
1688:                             SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
1689:                 ENDIF
1690:                 SEEK crSigCdMri.Grupos + IIF(crSigCdMri.TpRegs = 1, "", CHR(255)) ORDER TAG Codigos IN crSigCdGcr

--- BO Linhas 1685 a 1695 ---
1685:                             crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
1686:                             0, par_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
1687:                             IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
1688:                             SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
1689:                 ENDIF
1690:                 SEEK crSigCdMri.Grupos + IIF(crSigCdMri.TpRegs = 1, "", CHR(255)) ORDER TAG Codigos IN crSigCdGcr
1691:                 loc_lcClaAnt = crSigCdGcr.Classes
1692:             ENDSCAN
1693: 
1694:             SELECT crSigCdMri
1695:             SET ORDER TO "" IN crSigCdMri

--- BO Linhas 1693 a 1703 ---
1693: 
1694:             SELECT crSigCdMri
1695:             SET ORDER TO "" IN crSigCdMri
1696:             GO TOP
1697: 
1698:             *-- Monta totais de grupos (Ps='4') no dbCompara
1699:             SELECT dbCompara
1700:             SET ORDER TO "" IN dbCompara
1701:             GO TOP IN dbCompara
1702:             m.Valor = 0
1703:             DO WHILE !EOF("dbCompara")

--- BO Linhas 1700 a 1710 ---
1700:             SET ORDER TO "" IN dbCompara
1701:             GO TOP IN dbCompara
1702:             m.Valor = 0
1703:             DO WHILE !EOF("dbCompara")
1704:                 IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1
1705:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1706:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
1707:                     loc_lnRec1   = RECNO("dbCompara")
1708:                     m.Contas     = dbCompara.Grupos
1709:                     m.Ds_contas  = dbCompara.Ds_grupos
1710:                     m.Valor      = 0

--- BO Linhas 1703 a 1713 ---
1703:             DO WHILE !EOF("dbCompara")
1704:                 IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1
1705:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1706:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
1707:                     loc_lnRec1   = RECNO("dbCompara")
1708:                     m.Contas     = dbCompara.Grupos
1709:                     m.Ds_contas  = dbCompara.Ds_grupos
1710:                     m.Valor      = 0
1711:                     m.lnValor    = dbCompara.Valor
1712:                     m.Ps         = "4"
1713:                     m.Fators     = dbCompara.Fators

--- BO Linhas 1711 a 1721 ---
1711:                     m.lnValor    = dbCompara.Valor
1712:                     m.Ps         = "4"
1713:                     m.Fators     = dbCompara.Fators
1714:                     m.DescClasse = dbCompara.DescClasse
1715:                     m.Titulos    = dbCompara.Titulos
1716:                     IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
1717:                              "dbCompara", "Classes")
1718:                         INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1719:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
1720:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
1721:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;

--- BO Linhas 1713 a 1723 ---
1713:                     m.Fators     = dbCompara.Fators
1714:                     m.DescClasse = dbCompara.DescClasse
1715:                     m.Titulos    = dbCompara.Titulos
1716:                     IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
1717:                              "dbCompara", "Classes")
1718:                         INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1719:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
1720:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
1721:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
1722:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
1723:                                 par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;

--- BO Linhas 1716 a 1726 ---
1716:                     IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
1717:                              "dbCompara", "Classes")
1718:                         INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1719:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
1720:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
1721:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
1722:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
1723:                                 par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
1724:                                 m.Ps, m.cOrdBals, m.Fators, m.DescClasse)
1725:                     ENDIF
1726:                     m.Valor = (dbCompara.Valor + m.lnValor)

--- BO Linhas 1735 a 1745 ---
1735:             SET ORDER TO Ordems IN dbCompara
1736:             GO TOP
1737:             DO WHILE !EOF("dbCompara")
1738:                 IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1 AND ;
1739:                    dbCompara.Cpartidas = 1 AND EMPTY(dbCompara.Scontas)
1740:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1741:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
1742:                     loc_lnRec1 = RECNO("dbCompara")
1743:                     SELECT ContPartC
1744:                     SCAN FOR Grupos + Contas = m.Grupos + m.Contas
1745:                         m.sContas    = ContPartC.sContas

--- BO Linhas 1739 a 1749 ---
1739:                    dbCompara.Cpartidas = 1 AND EMPTY(dbCompara.Scontas)
1740:                     SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1741:                         Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
1742:                     loc_lnRec1 = RECNO("dbCompara")
1743:                     SELECT ContPartC
1744:                     SCAN FOR Grupos + Contas = m.Grupos + m.Contas
1745:                         m.sContas    = ContPartC.sContas
1746:                         m.Ds_contas  = ContPartC.Ds_Contas
1747:                         m.Valor      = ContPartC.Valor
1748:                         m.lnValor    = ContPartC.Valor
1749:                         m.Ps         = "5"

--- BO Linhas 1748 a 1758 ---
1748:                         m.lnValor    = ContPartC.Valor
1749:                         m.Ps         = "5"
1750:                         m.Fators     = ContPartC.Fators
1751:                         m.DescClasse = ContPartC.DescClasse
1752:                         m.Titulos    = ContPartC.Titulos
1753:                         INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1754:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
1755:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
1756:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
1757:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
1758:                                 par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;

--- BO Linhas 1751 a 1761 ---
1751:                         m.DescClasse = ContPartC.DescClasse
1752:                         m.Titulos    = ContPartC.Titulos
1753:                         INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
1754:                             Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
1755:                             Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
1756:                             VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
1757:                                 m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
1758:                                 par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
1759:                                 m.Ps, m.cOrdBals, m.Fators, m.DescClasse, m.sContas, m.Valor)
1760:                     ENDSCAN
1761:                     SELECT dbCompara

--- BO Linhas 1768 a 1778 ---
1768:             SELECT dbCompara
1769:             =SEEK("", "dbCompara", "Classes")
1770:             SELECT dbCompara
1771:             SCAN
1772:                 SELECT crSigCdMri
1773:                 IF !EMPTY(dbCompara.Grupos)
1774:                     IF dbCompara.Grupos <> "SubTotal"
1775:                         SET ORDER TO Grupos
1776:                         SEEK par_cDem + dbCompara.Grupos
1777:                     ELSE
1778:                         SET ORDER TO DescGrps

--- BO Linhas 1769 a 1779 ---
1769:             =SEEK("", "dbCompara", "Classes")
1770:             SELECT dbCompara
1771:             SCAN
1772:                 SELECT crSigCdMri
1773:                 IF !EMPTY(dbCompara.Grupos)
1774:                     IF dbCompara.Grupos <> "SubTotal"
1775:                         SET ORDER TO Grupos
1776:                         SEEK par_cDem + dbCompara.Grupos
1777:                     ELSE
1778:                         SET ORDER TO DescGrps
1779:                         SEEK par_cDem + dbCompara.Ds_Grupos

--- BO Linhas 1770 a 1780 ---
1770:             SELECT dbCompara
1771:             SCAN
1772:                 SELECT crSigCdMri
1773:                 IF !EMPTY(dbCompara.Grupos)
1774:                     IF dbCompara.Grupos <> "SubTotal"
1775:                         SET ORDER TO Grupos
1776:                         SEEK par_cDem + dbCompara.Grupos
1777:                     ELSE
1778:                         SET ORDER TO DescGrps
1779:                         SEEK par_cDem + dbCompara.Ds_Grupos
1780:                     ENDIF

--- BO Linhas 1771 a 1781 ---
1771:             SCAN
1772:                 SELECT crSigCdMri
1773:                 IF !EMPTY(dbCompara.Grupos)
1774:                     IF dbCompara.Grupos <> "SubTotal"
1775:                         SET ORDER TO Grupos
1776:                         SEEK par_cDem + dbCompara.Grupos
1777:                     ELSE
1778:                         SET ORDER TO DescGrps
1779:                         SEEK par_cDem + dbCompara.Ds_Grupos
1780:                     ENDIF
1781:                 ELSE


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigredtv.prg
- BO: C:\4c\projeto\app\classes\sigredtvBO.prg
