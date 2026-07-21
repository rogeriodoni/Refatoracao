CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~844: INSERT coluna 'cnnsupars' NAO EXISTE na tabela 'sigmvpar'
- [SQL-SCHEMA] Linha ~1504: INSERT coluna 'cnnsupars' NAO EXISTE na tabela 'sigmvpar'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmvpar
CREATE TABLE [dbo].[SigMvPar](
	[agencias] [char](4) NOT NULL,
	[bancos] [char](3) NOT NULL,
	[cartaos] [char](20) NOT NULL,
	[contas] [char](10) NOT NULL,
	[cotfpgs] [numeric](11, 4) NOT NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[dcarts] [char](12) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dpags] [datetime] NULL,
	[dtdeps] [datetime] NULL,
	[ec_numes] [numeric](6, 0) NOT NULL,
	[emps] [char](3) NOT NULL,
	[fpags] [char](12) NOT NULL,
	[grclis] [char](10) NOT NULL,
	[iclis] [char](10) NOT NULL,
	[impcars] [char](1) NOT NULL,
	[inschs] [bit] NOT NULL,
	[locals] [char](10) NOT NULL,
	[moefpgs] [char](3) NOT NULL,
	[ncarnes] [char](11) NOT NULL,
	[ncarts] [numeric](10, 0) NOT NULL,
	[ncopias] [numeric](6, 0) NOT NULL,
	[nocreditos] [char](10) NOT NULL,
	[nopers] [numeric](7, 0) NOT NULL,
	[nrecs] [numeric](11, 0) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numchqs] [char](8) NOT NULL,
	[numeros] [char](6) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[outros] [char](20) NOT NULL,
	[valos] [numeric](11, 2) NOT NULL,
	[vencs] [datetime] NULL,
	[vpags] [numeric](11, 2) NOT NULL,
	[cotusus] [char](30) NOT NULL,
	[obs] [text] NULL,
	[parcs] [numeric](2, 0) NOT NULL,
	[cnidtefs] [char](10) NOT NULL,
	[cnnsuparcs] [char](12) NOT NULL,
	[numlotechs] [numeric](8, 0) NOT NULL,
	[nidcheps] [numeric](10, 0) NOT NULL,
	[empos] [char](3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[valocurs] [numeric](11, 2) NOT NULL,
	[trocos] [numeric](1, 0) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[pagos] [char](1) NOT NULL,
	[dtalts] [datetime] NULL,
	[cpfs] [char](20) NOT NULL,
	[digagencs] [char](1) NOT NULL,
	[digchqs] [char](1) NOT NULL,
	[digcontas] [char](1) NOT NULL,
	[pracas] [char](3) NOT NULL,
	[tparcs] [numeric](2, 0) NOT NULL,
	[valdescs] [numeric](11, 2) NOT NULL,
	[codbcrts] [char](5) NOT NULL,
	[lcancelas] [bit] NOT NULL,
	[vcofins] [numeric](14, 2) NOT NULL,
	[vcsll] [numeric](14, 2) NOT NULL,
	[virf] [numeric](14, 2) NOT NULL,
	[vlrtrbfs] [numeric](14, 2) NOT NULL,
	[vpis] [numeric](14, 2) NOT NULL,
	[adquirente] [char](8) NOT NULL,
	[autoriza] [char](6) NOT NULL,
	[nsu] [char](50) NOT NULL,
	[chaveexterna] [char](33) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPRMEI.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRMEIBO.prg):

--- BO Linhas 144 a 154 ---
144:                 "nopers, cotfpgs, parcs, tparcs, pagos, moefpgs, valos, vpags, " + ;
145:                 "cidchaves, agencias, bancos, cartaos, contas, dcarts, " + ;
146:                 "ec_numes, grclis, iclis, impcars, inschs, locals, " + ;
147:                 "ncarnes, ncarts, ncopias, nocreditos, nrecs, ntrans, " + ;
148:                 "numchqs, numeros, numolds, outros, cotusus, " + ;
149:                 "cnidtefs, cnnsupars, numlotechs, nidcheps, empos, " + ;
150:                 "valocurs, trocos, cpfs, digagencs, digchqs, digcontas, " + ;
151:                 "pracas, valdescs, codbcrts, lcancelas, " + ;
152:                 "vcofins, vcsll, virf, vlrtrbfs, vpis, " + ;
153:                 "adquirente, autoriza, nsu, chaveexterna" + ;
154:                 ") VALUES (" + ;

--- BO Linhas 805 a 815 ---
805:                                 "valos, vpags, cidchaves, " + ;
806:                                 "agencias, bancos, cartaos, contas, dcarts, " + ;
807:                                 "ec_numes, grclis, iclis, impcars, inschs, locals, " + ;
808:                                 "ncarnes, ncarts, ncopias, nocreditos, nrecs, ntrans, " + ;
809:                                 "numchqs, numeros, numolds, outros, cotusus, " + ;
810:                                 "cnidtefs, cnnsupars, numlotechs, nidcheps, empos, " + ;
811:                                 "valocurs, trocos, cpfs, digagencs, digchqs, digcontas, " + ;
812:                                 "pracas, valdescs, codbcrts, lcancelas, " + ;
813:                                 "vcofins, vcsll, virf, vlrtrbfs, vpis, " + ;
814:                                 "adquirente, autoriza, nsu, chaveexterna" + ;
815:                                 ") VALUES (" + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPRMEI.prg
- BO: C:\4c\projeto\app\classes\SIGPRMEIBO.prg
