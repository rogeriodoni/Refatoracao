CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1105: INSERT coluna 'empdnps' NAO EXISTE na tabela 'sigmvcab'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'emps' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'dopes' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'numes' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'datars' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'mascnum' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'grupoos' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'contaos' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'grupods' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'contads' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'usuars' NAO EXISTE na tabela 'siginbep'
- [SQL-SCHEMA] Linha ~1133: INSERT coluna 'dtalts' NAO EXISTE na tabela 'siginbep'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: siginbep
CREATE TABLE [dbo].[SIGINBEP](
	[cidchaves] [char](20) NOT NULL,
	[empdnps] [char](33) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
 

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


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrGstBO.prg):

--- BO Linhas 1 a 10 ---
1: *==============================================================================
2: * SigPrGstBO.prg - Business Object: Geracao de Movimentacoes de Estoque
3: *
4: * Tabela principal : SigMvCab (cabecalho de movimentacao gerado)
5: * Chave primaria   : EmpDopNums (composta: Emps + Dopes + STR(Numes,6))
6: * Herda de         : BusinessBase
7: *
8: * Este BO opera sobre cursores passados pelo formulario pai:
9: *   Entrada  : csCabec, csItens, CsEstPe, CrSigCdNec
10: *   Saida    : SigMvCab, SigMvItn, SigMvIts, SigMvPec, SigInBep (via SQLEXEC)

--- BO Linhas 26 a 36 ---
26:     this_cDopes         = ""    && Codigo da operacao (C20)
27:     this_nNumes         = 0     && Numero do pedido (N6,0)
28:     this_cMascNum       = ""    && Mascara formatada do numero
29:     this_dDatars        = {}    && Data de referencia do pedido
30:     this_cIdChaves      = ""    && ID unico (via fUniqueIds)
31:     this_cEmpDopNums    = ""    && Chave composta: Emps + Dopes + STR(Numes,6) (C29)
32:     this_cEmpDnPs       = ""    && Chave composta da NEC origem (EmpDnPs)
33:     this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
34:     this_cContaOs       = ""    && Conta de Origem (C10)
35:     this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
36:     this_cContaDs       = ""    && Conta de Destino (C10)

--- BO Linhas 27 a 37 ---
27:     this_nNumes         = 0     && Numero do pedido (N6,0)
28:     this_cMascNum       = ""    && Mascara formatada do numero
29:     this_dDatars        = {}    && Data de referencia do pedido
30:     this_cIdChaves      = ""    && ID unico (via fUniqueIds)
31:     this_cEmpDopNums    = ""    && Chave composta: Emps + Dopes + STR(Numes,6) (C29)
32:     this_cEmpDnPs       = ""    && Chave composta da NEC origem (EmpDnPs)
33:     this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
34:     this_cContaOs       = ""    && Conta de Origem (C10)
35:     this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
36:     this_cContaDs       = ""    && Conta de Destino (C10)
37:     this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento

--- BO Linhas 33 a 43 ---
33:     this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
34:     this_cContaOs       = ""    && Conta de Origem (C10)
35:     this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
36:     this_cContaDs       = ""    && Conta de Destino (C10)
37:     this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
38:     this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
39:     this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
40:     this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)
41: 
42:     *--------------------------------------------------------------------------
43:     * Campos de csItens - Item corrente do pedido

--- BO Linhas 34 a 44 ---
34:     this_cContaOs       = ""    && Conta de Origem (C10)
35:     this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
36:     this_cContaDs       = ""    && Conta de Destino (C10)
37:     this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
38:     this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
39:     this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
40:     this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)
41: 
42:     *--------------------------------------------------------------------------
43:     * Campos de csItens - Item corrente do pedido
44:     *--------------------------------------------------------------------------

--- BO Linhas 35 a 45 ---
35:     this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
36:     this_cContaDs       = ""    && Conta de Destino (C10)
37:     this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
38:     this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
39:     this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
40:     this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)
41: 
42:     *--------------------------------------------------------------------------
43:     * Campos de csItens - Item corrente do pedido
44:     *--------------------------------------------------------------------------
45:     this_nCItens        = 0     && Numero sequencial do item

--- BO Linhas 64 a 74 ---
64:         LOCAL loc_lResultado
65:         loc_lResultado = .F.
66:         TRY
67:             IF USED(par_cAliasCursor)
68:                 SELECT (par_cAliasCursor)
69:                 THIS.this_cEmps       = TratarNulo(Emps, "C")
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")

--- BO Linhas 65 a 75 ---
65:         loc_lResultado = .F.
66:         TRY
67:             IF USED(par_cAliasCursor)
68:                 SELECT (par_cAliasCursor)
69:                 THIS.this_cEmps       = TratarNulo(Emps, "C")
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")

--- BO Linhas 66 a 76 ---
66:         TRY
67:             IF USED(par_cAliasCursor)
68:                 SELECT (par_cAliasCursor)
69:                 THIS.this_cEmps       = TratarNulo(Emps, "C")
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
76:                 THIS.this_cContaDs    = TratarNulo(ContaDs, "C")

--- BO Linhas 67 a 77 ---
67:             IF USED(par_cAliasCursor)
68:                 SELECT (par_cAliasCursor)
69:                 THIS.this_cEmps       = TratarNulo(Emps, "C")
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
76:                 THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
77:                 THIS.this_cGerado     = TratarNulo(Gerado, "C")

--- BO Linhas 68 a 78 ---
68:                 SELECT (par_cAliasCursor)
69:                 THIS.this_cEmps       = TratarNulo(Emps, "C")
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
76:                 THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
77:                 THIS.this_cGerado     = TratarNulo(Gerado, "C")
78:                 THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")

--- BO Linhas 69 a 79 ---
69:                 THIS.this_cEmps       = TratarNulo(Emps, "C")
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
76:                 THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
77:                 THIS.this_cGerado     = TratarNulo(Gerado, "C")
78:                 THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
79:                 THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")

--- BO Linhas 70 a 80 ---
70:                 THIS.this_cDopes      = TratarNulo(Dopes, "C")
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
76:                 THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
77:                 THIS.this_cGerado     = TratarNulo(Gerado, "C")
78:                 THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
79:                 THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
80:                 THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")

--- BO Linhas 71 a 81 ---
71:                 THIS.this_nNumes      = TratarNulo(Numes, "N")
72:                 THIS.this_cMascNum    = TratarNulo(MascNum, "C")
73:                 THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
74:                 THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
75:                 THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
76:                 THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
77:                 THIS.this_cGerado     = TratarNulo(Gerado, "C")
78:                 THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
79:                 THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
80:                 THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
81:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")

--- BO Linhas 77 a 87 ---
77:                 THIS.this_cGerado     = TratarNulo(Gerado, "C")
78:                 THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
79:                 THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
80:                 THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
81:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
82:                 IF TYPE("EmpDnPs") != "U"
83:                     THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
84:                 ENDIF
85:                 IF TYPE("Datars") != "U"
86:                     THIS.this_dDatars = TratarNulo(Datars, "D")
87:                 ENDIF

--- BO Linhas 78 a 88 ---
78:                 THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
79:                 THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
80:                 THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
81:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
82:                 IF TYPE("EmpDnPs") != "U"
83:                     THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
84:                 ENDIF
85:                 IF TYPE("Datars") != "U"
86:                     THIS.this_dDatars = TratarNulo(Datars, "D")
87:                 ENDIF
88:                 loc_lResultado = .T.

--- BO Linhas 80 a 90 ---
80:                 THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
81:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
82:                 IF TYPE("EmpDnPs") != "U"
83:                     THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
84:                 ENDIF
85:                 IF TYPE("Datars") != "U"
86:                     THIS.this_dDatars = TratarNulo(Datars, "D")
87:                 ENDIF
88:                 loc_lResultado = .T.
89:             ENDIF
90:         CATCH TO loc_oErro

--- BO Linhas 81 a 91 ---
81:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
82:                 IF TYPE("EmpDnPs") != "U"
83:                     THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
84:                 ENDIF
85:                 IF TYPE("Datars") != "U"
86:                     THIS.this_dDatars = TratarNulo(Datars, "D")
87:                 ENDIF
88:                 loc_lResultado = .T.
89:             ENDIF
90:         CATCH TO loc_oErro
91:             MsgErro(loc_oErro.Message, "Erro")

--- BO Linhas 142 a 152 ---
142:                 IF !EMPTY(ALLTRIM(csCabec.Gerado))
143:                     loc_lResultado = .T.
144:                 ELSE
145: 
146:                     *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
147:                     loc_cEmps    = ALLTRIM(csCabec.Emps)
148:                     loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)

--- BO Linhas 143 a 153 ---
143:                     loc_lResultado = .T.
144:                 ELSE
145: 
146:                     *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
147:                     loc_cEmps    = ALLTRIM(csCabec.Emps)
148:                     loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 

--- BO Linhas 144 a 154 ---
144:                 ELSE
145: 
146:                     *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
147:                     loc_cEmps    = ALLTRIM(csCabec.Emps)
148:                     loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 
154:                     *-- Capturar EmpDnPs de CrSigCdNec

--- BO Linhas 145 a 155 ---
145: 
146:                     *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
147:                     loc_cEmps    = ALLTRIM(csCabec.Emps)
148:                     loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 
154:                     *-- Capturar EmpDnPs de CrSigCdNec
155:                     loc_cEmpDnPsNec = ""

--- BO Linhas 146 a 156 ---
146:                     *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
147:                     loc_cEmps    = ALLTRIM(csCabec.Emps)
148:                     loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 
154:                     *-- Capturar EmpDnPs de CrSigCdNec
155:                     loc_cEmpDnPsNec = ""
156:                     IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")

--- BO Linhas 147 a 157 ---
147:                     loc_cEmps    = ALLTRIM(csCabec.Emps)
148:                     loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 
154:                     *-- Capturar EmpDnPs de CrSigCdNec
155:                     loc_cEmpDnPsNec = ""
156:                     IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
157:                         loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)

--- BO Linhas 149 a 159 ---
149:                     loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
150:                     loc_cContaOs = ALLTRIM(csCabec.ContaOs)
151:                     loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 
154:                     *-- Capturar EmpDnPs de CrSigCdNec
155:                     loc_cEmpDnPsNec = ""
156:                     IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
157:                         loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)
158:                     ENDIF
159: 

--- BO Linhas 152 a 162 ---
152:                     loc_cContaDs = ALLTRIM(csCabec.ContaDs)
153: 
154:                     *-- Capturar EmpDnPs de CrSigCdNec
155:                     loc_cEmpDnPsNec = ""
156:                     IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
157:                         loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)
158:                     ENDIF
159: 
160:                     *-- Carregar SigCdEmb para divisao de embalagem
161:                     loc_cSQL = "SELECT Cods, Multis FROM SigCdEmb"
162:                     IF USED("crSigCdEmb")

--- BO Linhas 188 a 198 ---
188:                         SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
189:                         loc_lTransacaoAberta = .T.
190: 
191:                         *-- INSERT INTO SigMvCab
192:                         loc_cSQL = "INSERT INTO SigMvCab " + ;
193:                                    "(emps, dopes, numes, datars, mascnum, " + ;
194:                                    " grupoos, contaos, grupods, contads, " + ;
195:                                    " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
196:                                    "VALUES (" + ;
197:                                    EscaparSQL(loc_cEmps) + ", " + ;
198:                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;

--- BO Linhas 189 a 199 ---
189:                         loc_lTransacaoAberta = .T.
190: 
191:                         *-- INSERT INTO SigMvCab
192:                         loc_cSQL = "INSERT INTO SigMvCab " + ;
193:                                    "(emps, dopes, numes, datars, mascnum, " + ;
194:                                    " grupoos, contaos, grupods, contads, " + ;
195:                                    " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
196:                                    "VALUES (" + ;
197:                                    EscaparSQL(loc_cEmps) + ", " + ;
198:                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
199:                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;

--- BO Linhas 190 a 200 ---
190: 
191:                         *-- INSERT INTO SigMvCab
192:                         loc_cSQL = "INSERT INTO SigMvCab " + ;
193:                                    "(emps, dopes, numes, datars, mascnum, " + ;
194:                                    " grupoos, contaos, grupods, contads, " + ;
195:                                    " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
196:                                    "VALUES (" + ;
197:                                    EscaparSQL(loc_cEmps) + ", " + ;
198:                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
199:                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
200:                                    FormatarDataSQL(DATE()) + ", " + ;

--- BO Linhas 216 a 226 ---
216:                     ENDIF
217: 
218:                     IF loc_lOks
219:                         *-- INSERT INTO SigInBep (rastreio - mesmo conteudo que SigMvCab)
220:                         loc_cSQL = "INSERT INTO SigInBep " + ;
221:                                    "(emps, dopes, numes, datars, mascnum, " + ;
222:                                    " grupoos, contaos, grupods, contads, " + ;
223:                                    " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
224:                                    "VALUES (" + ;
225:                                    EscaparSQL(loc_cEmps) + ", " + ;
226:                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;

--- BO Linhas 217 a 227 ---
217: 
218:                     IF loc_lOks
219:                         *-- INSERT INTO SigInBep (rastreio - mesmo conteudo que SigMvCab)
220:                         loc_cSQL = "INSERT INTO SigInBep " + ;
221:                                    "(emps, dopes, numes, datars, mascnum, " + ;
222:                                    " grupoos, contaos, grupods, contads, " + ;
223:                                    " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
224:                                    "VALUES (" + ;
225:                                    EscaparSQL(loc_cEmps) + ", " + ;
226:                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
227:                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;

--- BO Linhas 218 a 228 ---
218:                     IF loc_lOks
219:                         *-- INSERT INTO SigInBep (rastreio - mesmo conteudo que SigMvCab)
220:                         loc_cSQL = "INSERT INTO SigInBep " + ;
221:                                    "(emps, dopes, numes, datars, mascnum, " + ;
222:                                    " grupoos, contaos, grupods, contads, " + ;
223:                                    " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
224:                                    "VALUES (" + ;
225:                                    EscaparSQL(loc_cEmps) + ", " + ;
226:                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
227:                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
228:                                    FormatarDataSQL(DATE()) + ", " + ;

--- BO Linhas 306 a 316 ---
306:                                     ENDIF
307:                                 ENDIF
308: 
309:                                 *-- INSERT INTO SigMvItn
310:                                 loc_cSQLItem = "INSERT INTO SigMvItn " + ;
311:                                     "(emps, dopes, numes, citens, cpros, dpros, " + ;
312:                                     " moedas, units, qtds, totas, empdopnums, cidchaves, dtalts) " + ;
313:                                     "VALUES (" + ;
314:                                     EscaparSQL(loc_cEmps) + ", " + ;
315:                                     EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
316:                                     FormatarNumeroSQL(loc_nNum, 0) + ", " + ;

--- BO Linhas 307 a 317 ---
307:                                 ENDIF
308: 
309:                                 *-- INSERT INTO SigMvItn
310:                                 loc_cSQLItem = "INSERT INTO SigMvItn " + ;
311:                                     "(emps, dopes, numes, citens, cpros, dpros, " + ;
312:                                     " moedas, units, qtds, totas, empdopnums, cidchaves, dtalts) " + ;
313:                                     "VALUES (" + ;
314:                                     EscaparSQL(loc_cEmps) + ", " + ;
315:                                     EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
316:                                     FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
317:                                     FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;

--- BO Linhas 343 a 353 ---
343:                                         ENDIF
344: 
345:                                         IF loc_nMultis > 0 AND !EMPTY(loc_cCodEmbs)
346:                                             loc_nQtdEmb = loc_nQtds / loc_nMultis
347:                                             loc_cSQLItem = "INSERT INTO SigMvIts " + ;
348:                                                 "(emps, dopes, numes, cpros, citens, qtds, " + ;
349:                                                 " codembs, qtdembs, empdopnums, cidchaves, dtalts) " + ;
350:                                                 "VALUES (" + ;
351:                                                 EscaparSQL(loc_cEmps) + ", " + ;
352:                                                 EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
353:                                                 FormatarNumeroSQL(loc_nNum, 0) + ", " + ;

--- BO Linhas 344 a 354 ---
344: 
345:                                         IF loc_nMultis > 0 AND !EMPTY(loc_cCodEmbs)
346:                                             loc_nQtdEmb = loc_nQtds / loc_nMultis
347:                                             loc_cSQLItem = "INSERT INTO SigMvIts " + ;
348:                                                 "(emps, dopes, numes, cpros, citens, qtds, " + ;
349:                                                 " codembs, qtdembs, empdopnums, cidchaves, dtalts) " + ;
350:                                                 "VALUES (" + ;
351:                                                 EscaparSQL(loc_cEmps) + ", " + ;
352:                                                 EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
353:                                                 FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
354:                                                 EscaparSQL(loc_cCPros) + ", " + ;

--- BO Linhas 416 a 426 ---
416:                                 loc_cPstatus     = LEFT(ALLTRIM(CsEstPe.Pstatus), 1)
417:                                 loc_cEmpDopNumsPec = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + ;
418:                                                      STR(loc_nNum, 6)
419: 
420:                                 loc_cSQLPec = "INSERT INTO SigMvPec " + ;
421:                                     "(emps, dopes, numes, codigos, datatrans, ntrans, " + ;
422:                                     " locals, valobxs, cidchaves, empdopnums, empsubns, " + ;
423:                                     " datas, chksubn, dtagends, chkpagos, nparcs, " + ;
424:                                     " valps, valvars, vencps, pstatus) " + ;
425:                                     "VALUES (" + ;
426:                                     EscaparSQL(loc_cEmps) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg
- BO: C:\4c\projeto\app\classes\SigPrGstBO.prg
