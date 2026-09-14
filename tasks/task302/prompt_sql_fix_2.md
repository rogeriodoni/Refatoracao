CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1679: UPDATE coluna 'loc_cprodoff' NAO EXISTE na tabela 'sigcdpro'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdpro
CREATE TABLE [dbo].[SigCdPro](
	[matprincs] [char](14) NOT NULL,
	[dtcomps] [datetime] NULL,
	[cbars] [numeric](14, 0) NOT NULL,
	[cgrus] [char](3) NOT NULL,
	[clfiscals] [char](10) NOT NULL,
	[colecoes] [char](10) NOT NULL,
	[comis] [numeric](5, 2) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[custofs] [numeric](11, 3) NOT NULL,
	[cvens] [char](10) NOT NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[descfis] [text] NULL,
	[dpros] [char](65) NOT NULL,
	[dtfilms] [datetime] NULL,
	[fcustos] [numeric](11, 5) NOT NULL,
	[figjpgs] [text] NULL,
	[flagctabs] [bit] NOT NULL,
	[fvendas] [numeric](7, 3) NOT NULL,
	[icms] [numeric](5, 2) NOT NULL,
	[ifors] [char](10) NOT NULL,
	[linhas] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[margems] [numeric](9, 6) NOT NULL,
	[moecs] [char](3) NOT NULL,
	[moecusfs] [char](3) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[moepcs] [char](3) NOT NULL,
	[moepvs] [char](3) NOT NULL,
	[moevs] [char](3) NOT NULL,
	[notas] [char](6) NOT NULL,
	[obspeds] [char](30) NOT NULL,
	[obspes] [char](30) NOT NULL,
	[origmercs] [char](1) NOT NULL,
	[pcuss] [numeric](11, 5) NOT NULL,
	[pesoms] [numeric](8, 3) NOT NULL,
	[pvens] [numeric](11, 5) NOT NULL,
	[pvideals] [numeric](11, 5) NOT NULL,
	[qmins] [numeric](9, 3) NOT NULL,
	[reffs] [char](40) NOT NULL,
	[sittricms] [char](3) NOT NULL,
	[tcomps] [bit] NOT NULL,
	[tipos] [char](1) NOT NULL,
	[transps] [bit] NOT NULL,
	[valors] [numeric](11, 2) NOT NULL,
	[varias] [numeric](1, 0) NOT NULL,
	[situas] [numeric](1, 0) NOT NULL,
	[dtincs] [datetime] NULL,
	[sgrus] [char](6) NOT NULL,
	[metals] [char](2) NOT NULL,
	[teors] [char](2) NOT NULL,
	[cftios] [char](2) NOT NULL,
	[codservs] [char](4) NOT NULL,
	[mftios] [char](3) NOT NULL,
	[pftios] [numeric](11, 3) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[compos] [char](30) NOT NULL,
	[montadescs] [numeric](1, 0) NOT NULL,
	[digimaxs] [numeric](2, 0) NOT NULL,
	[ordcompos] [numeric](2, 0) NOT NULL,
	[ean13] [numeric](13, 0) NOT NULL,
	[cproeqs] [char](14) NOT NULL,
	[qtdcpnts] [numeric](3, 0) NOT NULL,
	[impetiqs] [bit] NOT NULL,
	[chkfunds] [bit] NOT NULL,
	[casas] [numeric](2, 0) NOT NULL,
	[mercs] [char](3) NOT NULL,
	[pesobs] [numeric](7, 3) NOT NULL,
	[tamhs] [numeric](5, 2) NOT NULL,
	[tamls] [numeric](5, 2) NOT NULL,
	[tamps] [numeric](5, 2) NOT NULL,
	[tptribs] [char](4) NOT NULL,
	[volumes] [numeric](3, 0) NOT NULL,
	[ipis] [char](1) NOT NULL,
	[dpro2s] [char](45) NOT NULL,
	[dsccompras] [text] NULL,
	[encoms] [numeric](1, 0) NOT NULL,
	[figtecs] [text] NULL,
	[obscompras] [text] NULL,
	[codacbs] [char](3) NOT NULL,
	[cravcers] [numeric](1, 0) NOT NULL,
	[cunips] [char](3) NOT NULL,
	[obsetqs] [char](10) NOT NULL,
	[ultcomps] [datetime] NULL,
	[vultcomps] [numeric](11, 2) NOT NULL,
	[multcomps] [char](3) NOT NULL,
	[markupa] [numeric](11, 3) NOT NULL,
	[tinsts] [numeric](
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigprilaBO.prg):

--- BO Linhas 597 a 607 ---
597:     * ProcessarPrecificacao - Atualiza precos de SigCdPro a partir de TmpPlanilha (atuapreco)
598:     *--------------------------------------------------------------------------
599:     FUNCTION ProcessarPrecificacao(par_nTipo, par_cArquivo)
600:         LOCAL loc_lResultado, loc_oErro, loc_loBarra, loc_cNomArq
601:         LOCAL loc_cQuery, loc_cSQL, loc_cCpros, loc_cMoevs
602:         LOCAL loc_nValAnt, loc_nPVens, loc_nPreDe, loc_nPVensEsp, loc_cProdOff
603:         loc_lResultado = .F.
604:         TRY
605:             loc_cNomArq = JUSTFNAME(par_cArquivo)
606: 
607:             SELECT TmpPlanilha

--- BO Linhas 637 a 647 ---
637:                 loc_cMoevs  = crSigCdPro.Moevs
638:                 loc_nValAnt = NVL(crSigCdPro.PVens, 0)
639: 
640:                 loc_nPreDe  = IIF(VARTYPE(TmpPlanilha.PrecoVen) = "N", TmpPlanilha.PrecoVen, VAL(TmpPlanilha.PrecoVen))
641:                 loc_nPVensEsp = IIF(VARTYPE(TmpPlanilha.PrecoEsp) = "N", TmpPlanilha.PrecoEsp, VAL(TmpPlanilha.PrecoEsp))
642:                 loc_cProdOff  = ALLTRIM(NVL(TmpPlanilha.ProdOff, ""))
643: 
644:                 IF loc_nPVensEsp = 0
645:                     loc_nPVens = loc_nPreDe
646:                     loc_nPreDe = 0
647:                 ELSE

--- BO Linhas 698 a 708 ---
698: 
699:                 *-- Atualiza SigCdPro
700:                 loc_cSQL = "UPDATE SigCdPro SET" + ;
701:                     " pVens = " + FormatarNumeroSQL(loc_nPVens, 5) + ;
702:                     ", PrecoDe = " + FormatarNumeroSQL(loc_nPreDe, 5) + ;
703:                     IIF(!EMPTY(loc_cProdOff), ", Prodoff = " + IIF(loc_cProdOff = "S", "1", "0"), "") + ;
704:                     " WHERE CPros = " + EscaparSQL(loc_cCpros)
705:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
706:                     MsgErro("Falha na Conex" + CHR(227) + "o (UPDATE SigCdPro)", "Erro")
707:                     SELECT TmpPlanilha
708:                     LOOP


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigprila.prg
- BO: C:\4c\projeto\app\classes\sigprilaBO.prg
