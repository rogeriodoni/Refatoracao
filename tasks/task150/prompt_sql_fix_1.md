CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2859: Coluna 'varias' NAO EXISTE na tabela 'sigcdgrp' (referenciada como g.Varias)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdgrp
CREATE TABLE [dbo].[SigCdGrp](
	[arreds] [numeric](6, 2) NOT NULL,
	[atucomps] [numeric](1, 0) NOT NULL,
	[avalests] [numeric](1, 0) NOT NULL,
	[bpesos] [numeric](1, 0) NOT NULL,
	[cestoqs] [numeric](1, 0) NOT NULL,
	[cgrus] [char](3) NOT NULL,
	[codcols] [char](1) NOT NULL,
	[concmvs] [char](10) NOT NULL,
	[datatrans] [datetime] NULL,
	[dgrus] [char](20) NOT NULL,
	[etidups] [numeric](1, 0) NOT NULL,
	[fornecs] [numeric](1, 0) NOT NULL,
	[grucmvs] [char](10) NOT NULL,
	[margems] [numeric](9, 6) NOT NULL,
	[mercs] [char](3) NOT NULL,
	[moecusts] [char](3) NOT NULL,
	[pesoms] [numeric](1, 0) NOT NULL,
	[servicos] [numeric](1, 0) NOT NULL,
	[tipoestos] [numeric](1, 0) NOT NULL,
	[cores] [numeric](1, 0) NOT NULL,
	[tams] [numeric](1, 0) NOT NULL,
	[embs] [numeric](1, 0) NOT NULL,
	[entregas] [numeric](1, 0) NOT NULL,
	[codservs] [char](4) NOT NULL,
	[pesos] [numeric](1, 0) NOT NULL,
	[idecpros] [char](2) NOT NULL,
	[codprods] [numeric](2, 0) NOT NULL,
	[semiacabs] [numeric](1, 0) NOT NULL,
	[mtprimas] [numeric](1, 0) NOT NULL,
	[pcustvens] [numeric](5, 2) NOT NULL,
	[conestps] [char](10) NOT NULL,
	[gruestps] [char](10) NOT NULL,
	[unificas] [char](3) NOT NULL,
	[invents] [numeric](1, 0) NOT NULL,
	[calcsalds] [numeric](1, 0) NOT NULL,
	[tpmovs] [numeric](1, 0) NOT NULL,
	[montagrds] [numeric](2, 0) NOT NULL,
	[repauts] [numeric](1, 0) NOT NULL,
	[caracteris] [numeric](1, 0) NOT NULL,
	[arredcs] [numeric](6, 2) NOT NULL,
	[clfiscals] [char](10) NOT NULL,
	[comiss] [numeric](5, 2) NOT NULL,
	[icms] [numeric](5, 2) NOT NULL,
	[obrigfiscs] [numeric](1, 0) NOT NULL,
	[omoecs] [numeric](1, 0) NOT NULL,
	[omoecusfs] [numeric](1, 0) NOT NULL,
	[omoedas] [numeric](1, 0) NOT NULL,
	[omoevs] [numeric](1, 0) NOT NULL,
	[origmercs] [char](1) NOT NULL,
	[sittricms] [char](3) NOT NULL,
	[tptribs] [char](4) NOT NULL,
	[diggprs] [numeric](1, 0) NOT NULL,
	[ids] [numeric](10, 0) NOT NULL,
	[impops] [numeric](1, 0) NOT NULL,
	[nagmts] [numeric](1, 0) NOT NULL,
	[pesmts] [numeric](1, 0) NOT NULL,
	[respcads] [numeric](1, 0) NOT NULL,
	[tpcalcps] [numeric](1, 0) NOT NULL,
	[ajpvens] [numeric](1, 0) NOT NULL,
	[coefs] [numeric](7, 4) NOT NULL,
	[casas] [numeric](2, 0) NOT NULL,
	[cjicms] [numeric](1, 0) NOT NULL,
	[compos] [char](30) NOT NULL,
	[cvestims] [numeric](1, 0) NOT NULL,
	[digimaxs] [numeric](2, 0) NOT NULL,
	[montadescs] [numeric](1, 0) NOT NULL,
	[ordcompos] [numeric](2, 0) NOT NULL,
	[mkpobrigs] [numeric](1, 0) NOT NULL,
	[nchkdims] [numeric](1, 0) NOT NULL,
	[nchkimps] [numeric](1, 0) NOT NULL,
	[nchkpess] [numeric](1, 0) NOT NULL,
	[nchktems] [numeric](1, 0) NOT NULL,
	[nfixfigs] [numeric](1, 0) NOT NULL,
	[mfictecs] [text] NULL,
	[ftecsubs] [numeric](1, 0) NOT NULL,
	[localobrig] [numeric](1, 0) NOT NULL,
	[ipifabs] [numeric](9, 2) NOT NULL,
	[ipiimpors] [numeric](9, 2) NOT NULL,
	[nchkcerts] [numeric](1, 0) NOT NULL,
	[custofs] [numeric](11, 3) NOT NULL,
	[dwvendas] [numeri
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPdMp9BO.prg):

--- BO Linhas 624 a 634 ---
624:             SET ORDER TO Gravar
625:             SCAN FOR NVL(Qtds,0) <> 0 OR NVL(Pesos,0) <> 0 OR ;
626:                      (USED("crSigCdOpd") AND NVL(crSigCdOpd.ReiNops, 0) = 1)
627: 
628:                 *-- Busca custo e flags do produto/grupo para este material
629:                 loc_cSQL = "SELECT g.CEstoqs, g.pvCompos, g.Varias, " + ;
630:                            "p.CGrus, p.CustoFs, p.MoeCusFs, p.pVens, p.Moevs " + ;
631:                            "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.CGrus = g.CGrus " + ;
632:                            "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(xNensiE.CMats,"")))
633:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgRateio")
634: 

--- BO Linhas 663 a 673 ---
663:                         ELSE
664:                             REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.CustoFs,  0), ;
665:                                     MoeCusFs WITH ALLTRIM(NVL(cursor_4c_PgRateio.MoeCusFs,""))
666:                         ENDIF
667:                         IF USED("crSigCdOpd") AND NVL(crSigCdOpd.PesoFixs,0) = 1 AND ;
668:                            NVL(cursor_4c_PgRateio.Varias,0) = 1
669:                             REPLACE PesoFixs WITH 1
670:                         ENDIF
671:                         IF USED("cursor_4c_PgRateio")
672:                             USE IN cursor_4c_PgRateio
673:                         ENDIF


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg
- BO: C:\4c\projeto\app\classes\SigPdMp9BO.prg
