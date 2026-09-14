CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impdebitos' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impcreditos' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impressoes' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impdebits' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impcredits' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impmerc' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impdesps' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impfrets' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'impnfs' NAO EXISTE na tabela 'sigcdprc'
- [SQL-SCHEMA] Linha ~3775: INSERT coluna 'implicss' NAO EXISTE na tabela 'sigcdprc'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdprc
CREATE TABLE [dbo].[SigCdPrc](
	[matprincs] [char](14) NOT NULL,
	[dataalts] [datetime] NULL,
	[horaalts] [char](8) NOT NULL,
	[usuaalts] [char](10) NOT NULL,
	[dtcomps] [datetime] NULL,
	[cbars] [numeric](14, 0) NOT NULL,
	[cgrus] [char](3) NOT NULL,
	[clfiscals] [char](10) NOT NULL,
	[colecoes] [char](10) NOT NULL,
	[comis] [numeric](5, 2) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[custofs] [numeric](11, 2) NOT NULL,
	[cvens] [char](10) NOT NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[descfis] [text] NULL,
	[dpros] [char](65) NOT NULL,
	[dtfilms] [datetime] NULL,
	[fcustos] [numeric](7, 3) NOT NULL,
	[figjpgs] [text] NULL,
	[figuras] [image] NULL,
	[flagctabs] [bit] NOT NULL,
	[fvendas] [numeric](7, 3) NOT NULL,
	[icms] [numeric](5, 2) NOT NULL,
	[ifors] [char](10) NOT NULL,
	[linhas] [char](10) NOT NULL,
	[locals] [char](6) NOT NULL,
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
	[pcuss] [numeric](11, 2) NOT NULL,
	[pesoms] [numeric](8, 3) NOT NULL,
	[pvens] [numeric](11, 2) NOT NULL,
	[pvideals] [numeric](11, 2) NOT NULL,
	[qmins] [numeric](9, 3) NOT NULL,
	[reffs] [char](40) NOT NULL,
	[sittricms] [char](2) NOT NULL,
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
	[codcpds] [char](4) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codtams] [char](2) NOT NULL,
	[compos] [char](30) NOT NULL,
	[montadescs] [numeric](1, 0) NOT NULL,
	[digimaxs] [numeric](2, 0) NOT NULL,
	[ordcompos] [numeric](2, 0) NOT NULL,
	[ean13] [numeric](13, 0) NOT NULL,
	[cproeqs] [char](14) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[chkfunds] [bit] NOT NULL,
	[casas] [numeric](2, 0) NOT NULL,
	[impetiqs] [bit] NOT NULL,
	[qtdcpnts] [numeric](3, 0) NOT NULL,
	[cbms] [numeric](9, 6) NOT NULL,
	[dpro2s] [char](45) NOT NULL,
	[dsccompras] [text] NULL,
	[encoms] [numeric](1, 0) NOT NULL,
	[obscompras] [text] NULL,
	[caracts] [char](10) NOT NULL,
	[codacbs] [char](3) NOT NULL,
	[cravcers] [numeric](1, 0) NOT NULL,
	[cunifors] [char](3) NOT NULL,
	[cunips] [char](3) NOT NULL,
	[custocvs] [numeric](11, 3) NOT NULL,
	[ipis] [char](1) NOT NULL,
	[ltmins] [numeric](9, 3) NOT NULL,
	[markcvs] [numeric](9, 6) NOT NULL,
	[mercs] [char](3) NOT NULL,
	[pesobs] [numeric](7, 3) NOT NUL
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrAprBO.prg):

--- BO Linhas 1044 a 1054 ---
1044: 
1045:                 *-- INSERT historico em SigCdPrc (snapshot antes do reajuste)
1046:                 loc_cSQL = "INSERT INTO SigCdPrc " + ;
1047:                            "(cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1048:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1049:                            " pftios, pftiocs, encargos, impdebitos, impcreditos, impressoes, " + ;
1050:                            " impdebits, impcredits, impmerc, impdesps, impfrets, impnfs, implicss, " + ;
1051:                            " DataAlts, HoraAlts, UsuaAlts, cIdChaves, Origem) " + ;
1052:                            "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1053:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1054:                            " pftios, pftiocs, encargos, " + ;

--- BO Linhas 1045 a 1055 ---
1045:                 *-- INSERT historico em SigCdPrc (snapshot antes do reajuste)
1046:                 loc_cSQL = "INSERT INTO SigCdPrc " + ;
1047:                            "(cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1048:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1049:                            " pftios, pftiocs, encargos, impdebitos, impcreditos, impressoes, " + ;
1050:                            " impdebits, impcredits, impmerc, impdesps, impfrets, impnfs, implicss, " + ;
1051:                            " DataAlts, HoraAlts, UsuaAlts, cIdChaves, Origem) " + ;
1052:                            "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1053:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1054:                            " pftios, pftiocs, encargos, " + ;
1055:                            " ISNULL(impdebitos,0), ISNULL(impcreditos,0), ISNULL(impessoes,0), " + ;

--- BO Linhas 1050 a 1060 ---
1050:                            " impdebits, impcredits, impmerc, impdesps, impfrets, impnfs, implicss, " + ;
1051:                            " DataAlts, HoraAlts, UsuaAlts, cIdChaves, Origem) " + ;
1052:                            "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1053:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1054:                            " pftios, pftiocs, encargos, " + ;
1055:                            " ISNULL(impdebitos,0), ISNULL(impcreditos,0), ISNULL(impessoes,0), " + ;
1056:                            " ISNULL(impdebits,0), ISNULL(impcredits,0), ISNULL(impmerc,0), " + ;
1057:                            " ISNULL(impdesps,0), ISNULL(impfrets,0), ISNULL(impnfs,0), ISNULL(implicss,0), " + ;
1058:                            TTOC(loc_dAgora) + " AS DataAlts, " + ;
1059:                            EscaparSQL(loc_cHora) + " AS HoraAlts, " + ;
1060:                            EscaparSQL(gc_4c_UsuarioLogado) + " AS UsuaAlts, " + ;

--- BO Linhas 1051 a 1061 ---
1051:                            " DataAlts, HoraAlts, UsuaAlts, cIdChaves, Origem) " + ;
1052:                            "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1053:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1054:                            " pftios, pftiocs, encargos, " + ;
1055:                            " ISNULL(impdebitos,0), ISNULL(impcreditos,0), ISNULL(impessoes,0), " + ;
1056:                            " ISNULL(impdebits,0), ISNULL(impcredits,0), ISNULL(impmerc,0), " + ;
1057:                            " ISNULL(impdesps,0), ISNULL(impfrets,0), ISNULL(impnfs,0), ISNULL(implicss,0), " + ;
1058:                            TTOC(loc_dAgora) + " AS DataAlts, " + ;
1059:                            EscaparSQL(loc_cHora) + " AS HoraAlts, " + ;
1060:                            EscaparSQL(gc_4c_UsuarioLogado) + " AS UsuaAlts, " + ;
1061:                            EscaparSQL(loc_cIdChave) + " AS cIdChaves, " + ;

--- BO Linhas 1052 a 1062 ---
1052:                            "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
1053:                            " margems, moevs, moecs, moepcs, moecusfs, moedas, mftios, cftiocs, " + ;
1054:                            " pftios, pftiocs, encargos, " + ;
1055:                            " ISNULL(impdebitos,0), ISNULL(impcreditos,0), ISNULL(impessoes,0), " + ;
1056:                            " ISNULL(impdebits,0), ISNULL(impcredits,0), ISNULL(impmerc,0), " + ;
1057:                            " ISNULL(impdesps,0), ISNULL(impfrets,0), ISNULL(impnfs,0), ISNULL(implicss,0), " + ;
1058:                            TTOC(loc_dAgora) + " AS DataAlts, " + ;
1059:                            EscaparSQL(loc_cHora) + " AS HoraAlts, " + ;
1060:                            EscaparSQL(gc_4c_UsuarioLogado) + " AS UsuaAlts, " + ;
1061:                            EscaparSQL(loc_cIdChave) + " AS cIdChaves, " + ;
1062:                            EscaparSQL(loc_cOrigem) + " AS Origem " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg
- BO: C:\4c\projeto\app\classes\SigPrAprBO.prg
