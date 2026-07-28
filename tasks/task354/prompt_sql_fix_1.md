CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3690: INSERT coluna 'conssubn' NAO EXISTE na tabela 'sigcdcrg'
- [SQL-SCHEMA] Linha ~3690: INSERT coluna 'libvalmmax' NAO EXISTE na tabela 'sigcdcrg'
- [SQL-SCHEMA] Linha ~3765: UPDATE coluna 'conssubn' NAO EXISTE na tabela 'sigcdcrg'
- [SQL-SCHEMA] Linha ~3765: UPDATE coluna 'libvalmmax' NAO EXISTE na tabela 'sigcdcrg'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdcrg
CREATE TABLE [dbo].[SIGCDCRG](
	[acrepors] [numeric](9, 2) NOT NULL,
	[altcots] [char](1) NOT NULL,
	[ccargs] [char](10) NOT NULL,
	[comis] [numeric](5, 2) NOT NULL,
	[datatrans] [datetime] NULL,
	[dcargs] [char](20) NOT NULL,
	[descpors] [numeric](9, 2) NOT NULL,
	[limacres] [numeric](11, 2) NOT NULL,
	[limdescs] [numeric](11, 2) NOT NULL,
	[nivels] [char](1) NOT NULL,
	[varcots] [numeric](5, 2) NOT NULL,
	[limites] [char](1) NOT NULL,
	[acomis] [numeric](5, 2) NOT NULL,
	[fcomis] [char](1) NOT NULL,
	[cancitens] [char](1) NOT NULL,
	[vllibpgs] [numeric](11, 2) NOT NULL,
	[libfpags] [char](1) NOT NULL,
	[libsdins] [char](1) NOT NULL,
	[vllibcots] [numeric](11, 2) NOT NULL,
	[vllibopes] [numeric](11, 2) NOT NULL,
	[libfpgs] [char](1) NOT NULL,
	[libopes] [char](1) NOT NULL,
	[grcomis] [char](10) NOT NULL,
	[tpcomis] [numeric](1, 0) NOT NULL,
	[libleilaos] [numeric](1, 0) NOT NULL,
	[libdupends] [numeric](1, 0) NOT NULL,
	[libduptits] [numeric](1, 0) NOT NULL,
	[libprzes] [numeric](1, 0) NOT NULL,
	[libsldtqe] [numeric](1, 0) NOT NULL,
	[libaltcli] [char](1) NOT NULL,
	[libexprd] [char](1) NOT NULL,
	[custoprod] [numeric](1, 0) NOT NULL,
	[libvmovdup] [char](1) NOT NULL,
	[varmovdup] [numeric](5, 2) NOT NULL,
	[libopers] [char](1) NOT NULL,
	[libvarpeso] [char](1) NOT NULL,
	[libmultvends] [numeric](1, 0) NOT NULL,
	[altvlpro] [numeric](1, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormCargo.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\CargoBO.prg):

--- BO Linhas 48 a 58 ---
48: 	this_cLibvarpeso  = ""   && libvarpeso char(1)    - liberar variacao peso (S/N)
49: 	this_nLibmultvends = 0   && libmultvends numeric(1,0) - libera multi-vendas (OptionGroup)
50: 	this_nAltvlpro    = 0    && altvlpro numeric(1,0) - altera valor producao (OptionGroup)
51: 
52: 	*-- Colunas adicionais presentes no banco (nao no schema dump inicial)
53: 	this_cConsSubn    = ""   && ConsSubn char(1)      - libera consulta todos subniveis (S/N)
54: 	this_nLibValmmax  = 0    && libValMMax numeric(1,0) - libera valor max malote (OptionGroup)
55: 
56: 	*====================================================================
57: 	* Init - Inicializa Business Object
58: 	*====================================================================

--- BO Linhas 49 a 59 ---
49: 	this_nLibmultvends = 0   && libmultvends numeric(1,0) - libera multi-vendas (OptionGroup)
50: 	this_nAltvlpro    = 0    && altvlpro numeric(1,0) - altera valor producao (OptionGroup)
51: 
52: 	*-- Colunas adicionais presentes no banco (nao no schema dump inicial)
53: 	this_cConsSubn    = ""   && ConsSubn char(1)      - libera consulta todos subniveis (S/N)
54: 	this_nLibValmmax  = 0    && libValMMax numeric(1,0) - libera valor max malote (OptionGroup)
55: 
56: 	*====================================================================
57: 	* Init - Inicializa Business Object
58: 	*====================================================================
59: 	PROCEDURE Init()

--- BO Linhas 390 a 400 ---
390: 			           " limites, acomis, fcomis, cancitens, vllibpgs," + ;
391: 			           " libfpags, libsdins, vllibcots, vllibopes, libfpgs," + ;
392: 			           " libopes, grcomis, tpcomis, libleilaos, libdupends," + ;
393: 			           " libduptits, libprzes, libsldtqe, libaltcli, libexprd," + ;
394: 			           " custoprod, libvmovdup, varmovdup, libopers, libvarpeso," + ;
395: 			           " libmultvends, altvlpro, ConsSubn, libValMMax)" + ;
396: 			           " VALUES (" + ;
397: 			           EscaparSQL(THIS.this_cCcargs) + "," + ;
398: 			           EscaparSQL(THIS.this_cDcargs) + "," + ;
399: 			           FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
400: 			           EscaparSQL(THIS.this_cAltcots) + "," + ;

--- BO Linhas 494 a 504 ---
494: 			           " varmovdup = " + FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
495: 			           " libopers = " + EscaparSQL(THIS.this_cLibopers) + "," + ;
496: 			           " libvarpeso = " + EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
497: 			           " libmultvends = " + FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
498: 			           " altvlpro = " + FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
499: 			           " ConsSubn = " + EscaparSQL(THIS.this_cConsSubn) + "," + ;
500: 			           " libValMMax = " + FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
501: 			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
502: 
503: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
504: 			IF loc_nResultado >= 0

--- BO Linhas 495 a 505 ---
495: 			           " libopers = " + EscaparSQL(THIS.this_cLibopers) + "," + ;
496: 			           " libvarpeso = " + EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
497: 			           " libmultvends = " + FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
498: 			           " altvlpro = " + FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
499: 			           " ConsSubn = " + EscaparSQL(THIS.this_cConsSubn) + "," + ;
500: 			           " libValMMax = " + FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
501: 			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
502: 
503: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
504: 			IF loc_nResultado >= 0
505: 				THIS.RegistrarAuditoria("UPDATE")


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormCargo.prg
- BO: C:\4c\projeto\app\classes\CargoBO.prg
