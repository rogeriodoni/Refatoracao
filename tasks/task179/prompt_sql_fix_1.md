CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1537: Coluna 'dpros' NAO EXISTE na tabela 'sigcdpam' (referenciada como p.DPros)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdpam
CREATE TABLE [dbo].[SigCdPam](
	[vendnts] [char](10) NOT NULL,
	[difpesags] [numeric](4, 2) NOT NULL,
	[grpsedexs] [char](3) NOT NULL,
	[ajhorzs] [numeric](3, 0) NOT NULL,
	[ajverts] [numeric](2, 0) NOT NULL,
	[altpesas] [numeric](1, 0) NOT NULL,
	[autcomps] [numeric](1, 0) NOT NULL,
	[baixas] [numeric](1, 0) NOT NULL,
	[bloqcheqs] [bit] NOT NULL,
	[canccreds] [numeric](11, 2) NOT NULL,
	[codprods] [numeric](2, 0) NOT NULL,
	[coletors] [numeric](1, 0) NOT NULL,
	[comcargos] [numeric](1, 0) NOT NULL,
	[comcontas] [char](10) NOT NULL,
	[comgrupos] [char](10) NOT NULL,
	[comlancas] [numeric](1, 0) NOT NULL,
	[commetods] [numeric](1, 0) NOT NULL,
	[commoedas] [char](3) NOT NULL,
	[conacertos] [char](10) NOT NULL,
	[conconfs] [char](10) NOT NULL,
	[conjconvs] [numeric](1, 0) NOT NULL,
	[conreservs] [char](10) NOT NULL,
	[contaests] [char](10) NOT NULL,
	[contajuros] [char](10) NOT NULL,
	[contapags] [char](10) NOT NULL,
	[contarecs] [char](10) NOT NULL,
	[contas] [char](10) NOT NULL,
	[cunippads] [char](3) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[datalts] [datetime] NULL,
	[diaprors] [numeric](3, 0) NOT NULL,
	[digprods] [char](1) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dopppads] [char](20) NOT NULL,
	[drivets] [char](30) NOT NULL,
	[gesind] [numeric](1, 0) NOT NULL,
	[grpadclis] [char](10) NOT NULL,
	[grpadfors] [char](10) NOT NULL,
	[grpadmsts] [char](10) NOT NULL,
	[grpadvens] [char](10) NOT NULL,
	[gruacertos] [char](10) NOT NULL,
	[gruconfs] [char](10) NOT NULL,
	[grupoests] [char](10) NOT NULL,
	[grupojuros] [char](10) NOT NULL,
	[grupopags] [char](10) NOT NULL,
	[gruporecs] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[grureservs] [char](10) NOT NULL,
	[habcors] [numeric](1, 0) NOT NULL,
	[habembs] [numeric](1, 0) NOT NULL,
	[habtams] [numeric](1, 0) NOT NULL,
	[habtifs] [numeric](1, 0) NOT NULL,
	[habtras] [numeric](1, 0) NOT NULL,
	[impetis] [numeric](1, 0) NOT NULL,
	[matpetqs] [numeric](1, 0) NOT NULL,
	[tplechqs] [char](1) NOT NULL,
	[moedacheqs] [char](3) NOT NULL,
	[moedaps] [char](3) NOT NULL,
	[moedetqs] [char](3) NOT NULL,
	[moepadvens] [char](3) NOT NULL,
	[mudahists] [numeric](1, 0) NOT NULL,
	[opconfors] [char](20) NOT NULL,
	[opconrclis] [char](20) NOT NULL,
	[opconrfors] [char](20) NOT NULL,
	[opconsers] [char](20) NOT NULL,
	[opconsljs] [char](20) NOT NULL,
	[opdevols] [char](20) NOT NULL,
	[opvendas] [char](20) NOT NULL,
	[pesoetqs] [numeric](1, 0) NOT NULL,
	[prevprods] [numeric](4, 0) NOT NULL,
	[prodfis] [numeric](1, 0) NOT NULL,
	[prvendas] [char](1) NOT NULL,
	[reffetqs] [numeric](1, 0) NOT NULL,
	[rescartao] [numeric](1, 0) NOT NULL,
	[rescheque] [numeric](1, 0) NOT NULL,
	[resconta] [numeric](1, 0) NOT NULL,
	[resforma] [numeric](1, 0) NOT NULL,
	[reslanca] [numeric](1, 0) NOT NULL,
	[reslanfor] [numeric](1, 0) NOT NULL,
	[resvende] [numeric](1, 0) NOT NULL,
	[tipoestos] [numeric](1, 0) NOT NULL,
	[tipoetqs] [numeric](1, 0) NOT NU
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg):

--- Linhas 1518 a 1558 ---
1518:     * CarregarItensGrid - Carrega itens do movimento em grd_4c_Itens
1519:     * JOIN SigMvPec + SigCdPam para descricao do produto (DPros)
1520:     *==========================================================================
1521:     PROTECTED PROCEDURE CarregarItensGrid()
1522:         LOCAL loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1523:         loc_cEmpDopNums = ""
1524:         loc_lSucesso    = .F.
1525: 
1526:         TRY
1527:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1528:                 loc_lSucesso = .T.
1529:             ELSE
1530:                 loc_cEmpDopNums = THIS.this_oBusinessObject.this_cEmpDopNums
1531: 
1532:                 IF !EMPTY(loc_cEmpDopNums)
1533:                     IF USED("cursor_4c_ItensPamTemp")
1534:                         USE IN cursor_4c_ItensPamTemp
1535:                     ENDIF
1536: 
1537:                     loc_cSQL = "SELECT a.Codigos AS CPros," + ;
1538:                                " ISNULL(a.Cidchaves, 0) AS Produzido," + ;
1539:                                " ISNULL(a.Ntrans, 0) AS Ntrans," + ;
1540:                                " (ISNULL(a.Ntrans, 0) - ISNULL(a.Valobxs, 0)) AS Saldo," + ;
1541:                                " ISNULL(a.Valobxs, 0) AS Valobxs," + ;
1542:                                " CASE WHEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))>0" + ;
1543:                                " THEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))" + ;
1544:                                " ELSE 0 END AS Produzir," + ;
1545:                                " ISNULL(a.Nparcs, 0) AS Nparcs," + ;
1546:                                " CAST(0 AS DECIMAL(8,2)) AS Pesos," + ;
1547:                                " CASE WHEN ISNULL(a.Ntrans,0)>0" + ;
1548:                                " THEN CAST((ISNULL(a.Valobxs,0)*100.0/a.Ntrans) AS DECIMAL(8,2))" + ;
1549:                                " ELSE CAST(0 AS DECIMAL(8,2)) END AS PctEnt," + ;
1550:                                " ISNULL(a.Locals,'') AS Locals," + ;
1551:                                " ISNULL(p.DPros,'') AS DPros" + ;
1552:                                " FROM SigMvPec a" + ;
1553:                                " LEFT JOIN SigCdPam p ON p.MascNums = a.Codigos" + ;
1554:                                " WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
1555:                                " ORDER BY a.Codigos"
1556: 
1557:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPamTemp")
1558: 



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigpres2BO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg
- BO: C:\4c\projeto\app\classes\sigpres2BO.prg
