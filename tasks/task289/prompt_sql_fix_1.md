CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2421: INSERT coluna 'entregas' NAO EXISTE na tabela 'sigmvcab'
- [SQL-SCHEMA] Linha ~2421: INSERT coluna 'contav' NAO EXISTE na tabela 'sigmvcab'
- [SQL-SCHEMA] Linha ~2475: UPDATE coluna 'entregas' NAO EXISTE na tabela 'sigmvcab'
- [SQL-SCHEMA] Linha ~2475: UPDATE coluna 'contav' NAO EXISTE na tabela 'sigmvcab'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmvcab
CREATE TABLE [dbo].[SigMvCab](
	[npedclis] [numeric](11, 0) NOT NULL,
	[acres] [numeric](8, 4) NOT NULL,
	[antecs] [char](6) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[codpeds] [numeric](8, 0) NOT NULL,
	[contads] [char](10) NOT NULL,
	[contaos] [char](10) NOT NULL,
	[datars] [datetime] NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[desc2s] [numeric](5, 2) NOT NULL,
	[descs] [numeric](8, 4) NOT NULL,
	[devols] [numeric](8, 0) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[empds] [char](3) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grresps] [char](10) NOT NULL,
	[grupods] [char](10) NOT NULL,
	[grupoos] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[grvends] [char](10) NOT NULL,
	[iclis] [char](10) NOT NULL,
	[ifors] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[lotechqs] [numeric](8, 0) NOT NULL,
	[lprecos] [char](30) NOT NULL,
	[mascnum] [char](10) NOT NULL,
	[ncarnecs] [char](11) NOT NULL,
	[nemps] [char](40) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[notas] [char](6) NOT NULL,
	[nrcons] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[obses] [text] NULL,
	[opers] [char](1) NOT NULL,
	[prazoents] [datetime] NULL,
	[resps] [char](10) NOT NULL,
	[tabds] [char](10) NOT NULL,
	[tpfats] [char](3) NOT NULL,
	[transps] [bit] NOT NULL,
	[usuals] [char](10) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[usulibs] [char](10) NOT NULL,
	[valacres] [numeric](11, 2) NOT NULL,
	[valdes2s] [numeric](11, 2) NOT NULL,
	[valdescs] [numeric](11, 2) NOT NULL,
	[valdevs] [numeric](11, 2) NOT NULL,
	[valencs] [numeric](11, 2) NOT NULL,
	[valinis] [numeric](11, 2) NOT NULL,
	[valos] [numeric](11, 2) NOT NULL,
	[valservs] [numeric](11, 2) NOT NULL,
	[valvars] [numeric](11, 2) NOT NULL,
	[vars] [numeric](9, 4) NOT NULL,
	[vends] [char](10) NOT NULL,
	[cotusus] [char](10) NOT NULL,
	[dtemis] [datetime] NULL,
	[espes] [char](10) NOT NULL,
	[pbrus] [numeric](10, 3) NULL,
	[pliqs] [numeric](10, 3) NULL,
	[qtdes] [numeric](6, 0) NOT NULL,
	[lcancelas] [bit] NOT NULL,
	[cofs] [bit] NOT NULL,
	[livros] [bit] NOT NULL,
	[dttransms] [datetime] NULL,
	[chkbxparcs] [bit] NOT NULL,
	[ecfs] [char](7) NOT NULL,
	[codobs] [numeric](3, 0) NOT NULL,
	[dgopes] [char](20) NOT NULL,
	[dtfechas] [datetime] NULL,
	[trfisicos] [numeric](2, 0) NOT NULL,
	[utilizados] [numeric](1, 0) NOT NULL,
	[valndevs] [numeric](11, 2) NOT NULL,
	[valobxs] [numeric](11, 2) NOT NULL,
	[noforms] [char](10) NOT NULL,
	[auditors] [char](10) NOT NULL,
	[dtaudits] [datetime] NULL,
	[cidchaves] [char](20) NOT NULL,
	[dtalts] [datetime] NULL,
	[empdopnums] [char](29) NOT NULL,
	[dtbaixas] [datetime] NULL,
	[dtrecs] [datetime] NULL,
	[empgopnums] [char](29) NOT NULL,
	[contaes] [char](10) NOT NULL,
	[dtagends] [datetime] NULL,
	[localents] [numeric](10, 0) NOT NULL,
	[localizas] [char](6) NOT NULL,
	[chkpagos] [bit] NOT NULL,
	[
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):

--- BO Linhas 554 a 564 ---
554:             SET NULL ON
555:             CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6,0), CPros C(14), ;
556:                                     Qtds N(10,3), Peso N(9,3), Saldo N(10,3), ;
557:                                     Estoque N(10,3), Produzir N(10,3), ;
558:                                     Obs M NULL, Obsps M NULL, ;
559:                                     Datas D NULL, Entregas D NULL, ;
560:                                     CodCors C(4), CodTams C(4), Linhas C(10), ;
561:                                     Citens N(10,0), Reffs C(40), Notas C(6), ;
562:                                     Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
563:                                     KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
564:             INDEX ON CPros + CodCors + CodTams TAG CPros

--- BO Linhas 605 a 615 ---
605:                     ENDIF
606:                     SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE CPros = " + ;
607:                             EscaparSQL(TmpItens.CPros), "crSigCdPro")
608: 
609:                     INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
610:                                           Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
611:                                           CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
612:                                           Dpros, GrupoDs, ContaDs, Jobs) ;
613:                                VALUES   (TmpItens.Emps, TmpItens.Dopes, TmpItens.Numes, ;
614:                                           TmpItens.CPros, TmpItens.Qtds, TmpItens.Peso, ;
615:                                           TmpItens.Saldo, TmpItens.Saldo - loc_nProduzir, ;

--- BO Linhas 614 a 624 ---
614:                                           TmpItens.CPros, TmpItens.Qtds, TmpItens.Peso, ;
615:                                           TmpItens.Saldo, TmpItens.Saldo - loc_nProduzir, ;
616:                                           loc_nProduzir, NVL(TmpItens.Obs, ""), ;
617:                                           NVL(TmpCabec.Obs, ""), ;
618:                                           NVL(TmpCabec.Datas, CTOD("")), ;
619:                                           NVL(TmpCabec.Entregas, CTOD("")), ;
620:                                           TmpItens.CodCors, TmpItens.CodTams, ;
621:                                           TmpItens.Linhas, TmpItens.CItens, ;
622:                                           crSigCdPro.Reffs, TmpItens.Notas, ;
623:                                           TmpItens.Dpros, TmpCabec.GrupoDs, ;
624:                                           TmpCabec.ContaDs, TmpCabec.Jobs)

--- BO Linhas 872 a 882 ---
872:                 THIS.this_lFlag     = NVL(Flag,     .F.)
873:                 THIS.this_cEmps     = ALLTRIM(NVL(Emps,     ""))
874:                 THIS.this_cDopes    = ALLTRIM(NVL(Dopes,    ""))
875:                 THIS.this_nNumes    = NVL(Numes,    0)
876:                 THIS.this_dDatas    = NVL(Datas,    {})
877:                 THIS.this_dEntregas = NVL(Entregas, {})
878:                 THIS.this_nPeso     = NVL(Peso,     0)
879:                 THIS.this_cContav   = ALLTRIM(NVL(Contav,   ""))
880:                 THIS.this_cConta    = ALLTRIM(NVL(Conta,    ""))
881:                 THIS.this_cDConta   = ALLTRIM(NVL(DConta,   ""))
882:                 THIS.this_cObs      = NVL(Obs,      "")

--- BO Linhas 874 a 884 ---
874:                 THIS.this_cDopes    = ALLTRIM(NVL(Dopes,    ""))
875:                 THIS.this_nNumes    = NVL(Numes,    0)
876:                 THIS.this_dDatas    = NVL(Datas,    {})
877:                 THIS.this_dEntregas = NVL(Entregas, {})
878:                 THIS.this_nPeso     = NVL(Peso,     0)
879:                 THIS.this_cContav   = ALLTRIM(NVL(Contav,   ""))
880:                 THIS.this_cConta    = ALLTRIM(NVL(Conta,    ""))
881:                 THIS.this_cDConta   = ALLTRIM(NVL(DConta,   ""))
882:                 THIS.this_cObs      = NVL(Obs,      "")
883:                 THIS.this_cNotas    = ALLTRIM(NVL(Notas,    ""))
884:                 THIS.this_cJobs     = ALLTRIM(NVL(Jobs,     ""))

--- BO Linhas 918 a 928 ---
918:             loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
919:                          STR(THIS.this_nNumes, 6)
920: 
921:             loc_cSQL = "INSERT INTO SigMvCab (" + ;
922:                        "Emps, Dopes, Numes, EmpDopNums, " + ;
923:                        "Datas, Entregas, PbRus, " + ;
924:                        "Contav, IClis, NEmps, " + ;
925:                        "Notas, Jobs, GrupoDs, ContaDs, Obses" + ;
926:                        ") VALUES (" + ;
927:                        EscaparSQL(THIS.this_cEmps) + ", " + ;
928:                        EscaparSQL(THIS.this_cDopes) + ", " + ;

--- BO Linhas 919 a 929 ---
919:                          STR(THIS.this_nNumes, 6)
920: 
921:             loc_cSQL = "INSERT INTO SigMvCab (" + ;
922:                        "Emps, Dopes, Numes, EmpDopNums, " + ;
923:                        "Datas, Entregas, PbRus, " + ;
924:                        "Contav, IClis, NEmps, " + ;
925:                        "Notas, Jobs, GrupoDs, ContaDs, Obses" + ;
926:                        ") VALUES (" + ;
927:                        EscaparSQL(THIS.this_cEmps) + ", " + ;
928:                        EscaparSQL(THIS.this_cDopes) + ", " + ;
929:                        FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;

--- BO Linhas 972 a 982 ---
972:             loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
973:                          STR(THIS.this_nNumes, 6)
974: 
975:             loc_cSQL = "UPDATE SigMvCab SET " + ;
976:                        "Datas = "    + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
977:                        "Entregas = " + FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
978:                        "PbRus = "    + FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
979:                        "Contav = "   + EscaparSQL(THIS.this_cContav) + ", " + ;
980:                        "IClis = "    + EscaparSQL(THIS.this_cConta) + ", " + ;
981:                        "NEmps = "    + EscaparSQL(THIS.this_cDConta) + ", " + ;
982:                        "Notas = "    + EscaparSQL(THIS.this_cNotas) + ", " + ;

--- BO Linhas 974 a 984 ---
974: 
975:             loc_cSQL = "UPDATE SigMvCab SET " + ;
976:                        "Datas = "    + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
977:                        "Entregas = " + FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
978:                        "PbRus = "    + FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
979:                        "Contav = "   + EscaparSQL(THIS.this_cContav) + ", " + ;
980:                        "IClis = "    + EscaparSQL(THIS.this_cConta) + ", " + ;
981:                        "NEmps = "    + EscaparSQL(THIS.this_cDConta) + ", " + ;
982:                        "Notas = "    + EscaparSQL(THIS.this_cNotas) + ", " + ;
983:                        "Jobs = "     + EscaparSQL(THIS.this_cJobs) + ", " + ;
984:                        "GrupoDs = "  + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg
- BO: C:\4c\projeto\app\classes\SigPrGl2BO.prg
