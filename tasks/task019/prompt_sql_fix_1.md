CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2657: Tabela 'Temporario' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~2672: INSERT coluna 'fatores' NAO EXISTE na tabela 'sigcdnei'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdnei
CREATE TABLE [dbo].[SigCdNei](
	[aqtds] [numeric](9, 3) NOT NULL,
	[cats] [char](6) NOT NULL,
	[cdescs] [char](40) NOT NULL,
	[cgrus] [char](3) NOT NULL,
	[cmats] [char](14) NOT NULL,
	[coefs] [numeric](7, 4) NOT NULL,
	[contafs] [char](10) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[datatrans] [datetime] NULL,
	[dopps] [char](20) NOT NULL,
	[emps] [char](3) NOT NULL,
	[fators] [numeric](7, 4) NOT NULL,
	[flagincs] [bit] NOT NULL,
	[grupofins] [char](10) NOT NULL,
	[grupofs] [char](10) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[moeds] [char](3) NOT NULL,
	[nenvs] [numeric](10, 0) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[numps] [numeric](10, 0) NOT NULL,
	[obss] [char](40) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[servicos] [bit] NOT NULL,
	[tpops] [char](15) NOT NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[nlotes] [numeric](10, 0) NOT NULL,
	[pesofixs] [numeric](1, 0) NOT NULL,
	[coefinfs] [numeric](7, 4) NOT NULL,
	[cretrabs] [char](6) NOT NULL,
	[empdnps] [char](33) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codnconfs] [char](10) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[peso2s] [numeric](9, 3) NOT NULL,
	[custofs] [numeric](11, 3) NOT NULL,
	[moecusfs] [char](3) NOT NULL,
	[estorno] [numeric](1, 0) NOT NULL,
	[pvens] [numeric](11, 3) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigopdivBO.prg):

--- BO Linhas 1119 a 1129 ---
1119:                         GO TOP
1120:                         DO WHILE !EOF()
1121:                             loc_cIds = fUniqueIds()
1122:                             loc_cSQL = "INSERT INTO SigCdNei (" + ;
1123:                                        "Aqtds, Cats, Cdescs, Cgrus, Cmats, Coefs, Contafs, Cunis, " + ;
1124:                                        "Dopps, Emps, Fatores, Flagincs, Grupofins, Grupofs, Moedas, Moeds, " + ;
1125:                                        "Nenvs, Nops, Numps, Obss, Pesos, Qtds, Servicos, Tpops, " + ;
1126:                                        "Locals, Ntrans, CidChaves, Nlotes, PesoFixs, Coefinfs, Cretrabs, " + ;
1127:                                        "EmpDnPs, EmpDopNums, ChkSubn, CodCors, CodNConfs, CodTams, Peso2s, Custofs, Moecusfs, Estorno, Pvens) " + ;
1128:                                        "VALUES (" + ;
1129:                                        FormatarNumeroSQL(xNensi.Aqtds) + ", " + ;

--- BO Linhas 1134 a 1144 ---
1134:                                        FormatarNumeroSQL(xNensi.Coefs) + ", " + ;
1135:                                        EscaparSQL(ALLTRIM(xNensi.Contafs)) + ", " + ;
1136:                                        EscaparSQL(ALLTRIM(xNensi.Cunis)) + ", " + ;
1137:                                        EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
1138:                                        EscaparSQL(ALLTRIM(xNensi.Emps)) + ", " + ;
1139:                                        FormatarNumeroSQL(xNensi.Fatores) + ", " + ;
1140:                                        IIF(xNensi.Flagincs, "1", "0") + ", " + ;
1141:                                        EscaparSQL(ALLTRIM(xNensi.Grupofins)) + ", " + ;
1142:                                        EscaparSQL(ALLTRIM(xNensi.Grupofs)) + ", " + ;
1143:                                        EscaparSQL(ALLTRIM(xNensi.Moedas)) + ", " + ;
1144:                                        EscaparSQL(ALLTRIM(xNensi.Moeds)) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg
- BO: C:\4c\projeto\app\classes\sigopdivBO.prg
