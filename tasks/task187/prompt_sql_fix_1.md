CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2855: INSERT coluna 'datas' NAO EXISTE na tabela 'sigoppic'
- [SQL-SCHEMA] Linha ~2855: INSERT coluna 'datap' NAO EXISTE na tabela 'sigoppic'
- [SQL-SCHEMA] Linha ~2855: INSERT coluna 'datages' NAO EXISTE na tabela 'sigoppic'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigoppic
CREATE TABLE [dbo].[SigOpPic](
	[dataes] [datetime] NULL,
	[dataps] [datetime] NULL,
	[dopes] [char](20) NOT NULL,
	[dopps] [char](20) NOT NULL,
	[emps] [char](3) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numps] [numeric](10, 0) NOT NULL,
	[obss] [text] NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[datatrans] [datetime] NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[empds] [char](3) NOT NULL,
	[dtgeras] [datetime] NULL,
	[seqdivs] [numeric](3, 0) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[divs] [bit] NOT NULL,
	[imprs] [bit] NOT NULL,
	[usuars] [char](10) NOT NULL,
	[nopmaes] [numeric](10, 0) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[codbarras] [numeric](8, 0) NOT NULL,
	[qtdcpnts] [numeric](6, 0) NOT NULL,
	[qtdtubos] [numeric](9, 3) NOT NULL,
	[iimprs] [bit] NOT NULL,
	[moedas] [char](3) NOT NULL,
	[units] [numeric](15, 6) NOT NULL,
	[dtfunds] [datetime] NULL,
	[nfunds] [numeric](6, 0) NOT NULL,
	[dpros] [char](65) NOT NULL,
	[empdnps] [char](33) NOT NULL,
	[empdopnops] [char](33) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[notas] [char](6) NOT NULL,
	[codtgops] [char](10) NOT NULL,
	[citens] [numeric](10, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrGloBO.prg):

--- BO Linhas 109 a 119 ---
109:         IF TYPE(par_cAliasCursor + ".Dopes") = "C"
110:             THIS.this_cOperacao  = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Dopes")), "")
111:             THIS.this_nOperacaoi = 0
112:             THIS.this_nOperacaof = 0
113:         ENDIF
114:         IF TYPE(par_cAliasCursor + ".Datas") = "D"
115:             THIS.this_dGeracao = NVL(EVALUATE(par_cAliasCursor + ".Datas"), DATE())
116:         ENDIF
117:         IF TYPE(par_cAliasCursor + ".Entregas") = "D"
118:             THIS.this_dPrevisao = NVL(EVALUATE(par_cAliasCursor + ".Entregas"), DATE())
119:         ENDIF

--- BO Linhas 110 a 120 ---
110:             THIS.this_cOperacao  = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Dopes")), "")
111:             THIS.this_nOperacaoi = 0
112:             THIS.this_nOperacaof = 0
113:         ENDIF
114:         IF TYPE(par_cAliasCursor + ".Datas") = "D"
115:             THIS.this_dGeracao = NVL(EVALUATE(par_cAliasCursor + ".Datas"), DATE())
116:         ENDIF
117:         IF TYPE(par_cAliasCursor + ".Entregas") = "D"
118:             THIS.this_dPrevisao = NVL(EVALUATE(par_cAliasCursor + ".Entregas"), DATE())
119:         ENDIF
120:         IF TYPE(par_cAliasCursor + ".Grupo") = "C"

--- BO Linhas 347 a 357 ---
347:             CREATE CURSOR DBParam (CodTgOps C(10) NULL, OpZers N(1,0) NULL, EntPes N(1,0) NULL)
348:             SET NULL OFF
349: 
350:             SET NULL ON
351:             CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6,0), ;
352:                                      Grupo C(10), Conta C(10), Datas D NULL, ;
353:                                      Entregas D NULL, Grupov C(10), Contav C(10), ;
354:                                      Obs M NULL, Peso N(12,2), ;
355:                                      GrupoDs C(10), ContaDs C(10), DConta C(40), ;
356:                                      Notas C(6), Jobs C(10))
357:             SET NULL OFF

--- BO Linhas 428 a 438 ---
428:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpd") < 1
429:                 MsgErro("Falha ao carregar opera" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o (SigCdOpd).", "Erro")
430:                 loc_lSucesso = .F.
431:             ENDIF
432: 
433:             *-- Formatar datas para SQL
434:             loc_cDateiSQL  = IIF(EMPTY(THIS.this_dDataei), "NULL", FormatarDataSQL(THIS.this_dDataei))
435:             loc_cDatefSQL  = IIF(EMPTY(THIS.this_dDataef), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDataef, "23:59:59"))
436:             loc_cDatepiSQL = IIF(EMPTY(THIS.this_dDatapi), "NULL", FormatarDataSQL(THIS.this_dDatapi))
437:             loc_cDatepfSQL = IIF(EMPTY(THIS.this_dDatapf), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDatapf, "23:59:59"))
438: 

--- BO Linhas 439 a 449 ---
439:             *-- Condicao de periodo de emissao
440:             IF EMPTY(THIS.this_dDataef)
441:                 loc_Conde = ""
442:             ELSE
443:                 IF EMPTY(THIS.this_dDataei)
444:                 loc_Conde = "Datas <= " + loc_cDatefSQL + " AND "
445:             ELSE
446:                 loc_Conde = "Datas BETWEEN " + loc_cDateiSQL + " AND " + loc_cDatefSQL + " AND "
447:                 ENDIF
448:             ENDIF
449: 

--- BO Linhas 441 a 451 ---
441:                 loc_Conde = ""
442:             ELSE
443:                 IF EMPTY(THIS.this_dDataei)
444:                 loc_Conde = "Datas <= " + loc_cDatefSQL + " AND "
445:             ELSE
446:                 loc_Conde = "Datas BETWEEN " + loc_cDateiSQL + " AND " + loc_cDatefSQL + " AND "
447:                 ENDIF
448:             ENDIF
449: 
450:             *-- Condicao de periodo de previsao de entrega
451:             IF EMPTY(THIS.this_dDatapi)

--- BO Linhas 494 a 504 ---
494:                 IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) <> ALLTRIM(loc_lcTpGOp)
495:                     LOOP
496:                 ENDIF
497: 
498:                 *-- Montar SQL para buscar movimentos desta operacao
499:                 loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, " + ;
500:                            "ContaOs, GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
501:                            "FROM SigMvCab " + ;
502:                            "WHERE " + loc_Conde + loc_Condp + ;
503:                            "Emps = " + EscaparSQL(ALLTRIM(loc_lcEmp)) + " AND " + ;
504:                            "Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

--- BO Linhas 746 a 756 ---
746:                         loc_cDConta = IIF(EOF(), "", ALLTRIM(LocalCli.RClis))
747:                         USE IN LocalCli
748: 
749:                         INSERT INTO TmpCabec ;
750:                             (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, ;
751:                              Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, ;
752:                              Notas, Jobs) ;
753:                             VALUES (.T., TempEest.Emps, TempEest.Dopes, TempEest.Numes, ;
754:                                     loc_GrupoG, loc_ContaG, ;
755:                                     ALLTRIM(TempEest.GrVends), ALLTRIM(TempEest.Vends), ;
756:                                     TempEest.Datas, TempEest.PrazoEnts, ;

--- BO Linhas 751 a 761 ---
751:                              Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, ;
752:                              Notas, Jobs) ;
753:                             VALUES (.T., TempEest.Emps, TempEest.Dopes, TempEest.Numes, ;
754:                                     loc_GrupoG, loc_ContaG, ;
755:                                     ALLTRIM(TempEest.GrVends), ALLTRIM(TempEest.Vends), ;
756:                                     TempEest.Datas, TempEest.PrazoEnts, ;
757:                                     loc_TPeso, TempEest.Obses, ;
758:                                     loc_GrupoD, loc_ContaD, loc_cDConta, ;
759:                                     ALLTRIM(TempEest.Notas), ALLTRIM(TempEest.Jobs))
760:                     ENDIF
761:                 ENDSCAN

--- BO Linhas 862 a 872 ---
862:             loc_cIdChave    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")
863: 
864:             *-- Montar INSERT em SigOpPic (colunas NOT NULL preenchidas)
865:             loc_cSQL = "INSERT INTO SigOpPic " + ;
866:                        "(cIdChaves, Emps, Dopes, Dopps, Nops, Numes, Numps, " + ;
867:                        " Datas, Datap, Datages, Cpros, Empds, Locals, Ntrans, " + ;
868:                        " Seqdivs, CodCors, CodTams, Divs, Imprs, Usuars, Nopmaes, " + ;
869:                        " Pesos, CodBarras, QtdCpnts, QtdTubos, iImprs, Moedas, Units, " + ;
870:                        " Nfunds, Dpros, Empdnps, EmpDopNops, EmpDopNums, Notas, " + ;
871:                        " CodTgOps, Citens, Qtds) VALUES ("
872:             loc_cSQL = loc_cSQL + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg
- BO: C:\4c\projeto\app\classes\SigPrGloBO.prg
