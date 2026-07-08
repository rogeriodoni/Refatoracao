CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~7618: Coluna 'ords' NAO EXISTE na tabela 'sigsubcp' (referenciada como s.Ords)
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "cpros' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "cbars' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "altura' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "pesoms' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "codacbs' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "pvens' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "qmins' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "chkgarvit' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "situas' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "codident' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "qtminfabs' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna '" + ;                 "dtincs' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12862: INSERT coluna 'usuaalts" + ;                 "' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'lins' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'cols' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'alturas' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'larguras' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'diametros' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'espessuras' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'compriments' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'pesopmedios' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'tams' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'corpros' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'codfinps' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'classs' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'mfvendas' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'ltminsvs' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'conjuntos' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'qtpeds' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'diasgars' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'garvits' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'opcvars' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'instalas' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'obs1s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'obs2s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'obs3s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'fwget3s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'fwget4s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'fwget5s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'fwget6s' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'codidents' NAO EXISTE na tabela 'sigcdpro'
- [SQL-SCHEMA] Linha ~12960: UPDATE coluna 'dataalts' NAO EXISTE na tabela 'sigcdpro'


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

-- Tabela: sigsubcp
CREATE TABLE [dbo].[sigsubcp](
	[cats] [char](6) NOT NULL,
	[cgrus] [char](3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[compos] [char](10) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[cunips] [char](3) NOT NULL,
	[datatrans] [datetime] NULL,
	[dcompos] [char](40) NOT NULL,
	[dscgrp] [char](20) NOT NULL,
	[dtmovs] [datetime] NULL,
	[etiqs] [char](1) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[markcvs] [numeric](9, 6) NOT NULL,
	[mats] [char](14) NOT NULL,
	[matsubs] [char](14) NOT NULL,
	[moeds] [char](3) NOT NULL,
	[obscompos] [char](10) NOT NULL,
	[ordcompos] [numeric](2, 0) NOT NULL,
	[ordems] [numeric](2, 0) NOT NULL,
	[ordts] [numeric](2, 0) NOT NULL,
	[pcompos] [numeric](11, 3) NOT NULL,
	[pesos] [numeric](8, 3) NOT NULL,
	[qtdcvs] [numeric](11, 3) NOT NULL,
	[qtds] [numeric](8, 3) NOT NULL,
	[qtscons] [numeric](8, 3) NOT NULL,
	[tipos] [char](20) NOT NULL,
	[totas] [numeric](11, 3) NOT NULL,
	[tpalts] [numeric](1, 0) NOT NULL,
	[unicompos] [char](3) NOT NULL,
	[vlrcvs] [numeric](11, 2) NOT NULL,
	[vlrpvs] [numeric](11, 2) NOT NULL,
	[matriz] [char](14) NOT NULL,
	[codtams] [char](4) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormProduto.prg):

--- Linhas 7599 a 7639 ---
7599:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
7600:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7601:                        " ORDER BY c.ordts"
7602:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTemp")
7603:             IF loc_nRet > 0
7604:                 SELECT cursor_4c_Compo
7605:                 ZAP
7606:                 APPEND FROM DBF("cursor_4c_CompoTemp")
7607:                 IF USED("cursor_4c_CompoTemp")
7608:                     USE IN cursor_4c_CompoTemp
7609:                 ENDIF
7610:                 SELECT cursor_4c_Compo
7611:                 GO TOP
7612:             ENDIF
7613: 
7614:             *-- Carregar subcomposicao (SigPrScp)
7615:             IF USED("cursor_4c_SubCpTemp")
7616:                 USE IN cursor_4c_SubCpTemp
7617:             ENDIF
7618:             loc_cSQL = "SELECT s.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
7619:                        "       s.UniCompos AS Unisp, s.PCompos AS Vals, s.Qtds, s.Totas AS Totals, s.Moeds AS Moedas, " + ;
7620:                        "       ISNULL(s.ObsCompos,'') AS Obss, ISNULL(s.Etiqs,'') AS Es, " + ;
7621:                        "       s.QtsCons AS Conss, s.Pesos AS Qtdss, ISNULL(s.CUniPs,'') AS Unis, " + ;
7622:                        "       s.OrdTs AS Ords, CAST(ISNULL(s.TpAlts,0) AS varchar(14)) AS Bloqueio, " + ;
7623:                        "       ISNULL(s.CodTams,'') AS Tams " + ;
7624:                        "FROM SigSubCp s " + ;
7625:                        "LEFT JOIN SigCdPro p ON p.CPros = s.Mats " + ;
7626:                        "WHERE s.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7627:                        " ORDER BY s.Ords"
7628:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCpTemp")
7629:             IF loc_nRet > 0
7630:                 SELECT cursor_4c_SubCp
7631:                 ZAP
7632:                 APPEND FROM DBF("cursor_4c_SubCpTemp")
7633:                 IF USED("cursor_4c_SubCpTemp")
7634:                     USE IN cursor_4c_SubCpTemp
7635:                 ENDIF
7636:                 SELECT cursor_4c_SubCp
7637:                 GO TOP
7638:             ENDIF
7639: 



## Trechos relevantes do BO (C:\4c\projeto\app\classes\ProdutoBO.prg):

--- BO Linhas 23 a 33 ---
23:     this_cEAN13       = ""    && EAN13    - EAN-13 (se campo separado)
24:     this_cCProEqs     = ""    && CProEqs  - produto equivalente
25:     this_cIdeCPros    = ""    && IdeCPros - identificador
26:     this_cMercs       = ""    && Mercs    - mercadoria
27:     *-- Linha / Colecao
28:     this_cLins        = ""    && Lins     - codigo da linha
29:     this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
30:     *-- Unidades
31:     this_cCUnis       = ""    && CUnis    - unidade 1
32:     this_cCUnips      = ""    && CUnips   - unidade 2
33:     *-- Dimensoes

--- BO Linhas 24 a 34 ---
24:     this_cCProEqs     = ""    && CProEqs  - produto equivalente
25:     this_cIdeCPros    = ""    && IdeCPros - identificador
26:     this_cMercs       = ""    && Mercs    - mercadoria
27:     *-- Linha / Colecao
28:     this_cLins        = ""    && Lins     - codigo da linha
29:     this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
30:     *-- Unidades
31:     this_cCUnis       = ""    && CUnis    - unidade 1
32:     this_cCUnips      = ""    && CUnips   - unidade 2
33:     *-- Dimensoes
34:     this_nAlturas     = 0     && Alturas

--- BO Linhas 29 a 39 ---
29:     this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
30:     *-- Unidades
31:     this_cCUnis       = ""    && CUnis    - unidade 1
32:     this_cCUnips      = ""    && CUnips   - unidade 2
33:     *-- Dimensoes
34:     this_nAlturas     = 0     && Alturas
35:     this_nLarguras    = 0     && Larguras
36:     this_nDiametros   = 0     && Diametros
37:     this_nEspessuras  = 0     && Espessuras
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base

--- BO Linhas 30 a 40 ---
30:     *-- Unidades
31:     this_cCUnis       = ""    && CUnis    - unidade 1
32:     this_cCUnips      = ""    && CUnips   - unidade 2
33:     *-- Dimensoes
34:     this_nAlturas     = 0     && Alturas
35:     this_nLarguras    = 0     && Larguras
36:     this_nDiametros   = 0     && Diametros
37:     this_nEspessuras  = 0     && Espessuras
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto

--- BO Linhas 31 a 41 ---
31:     this_cCUnis       = ""    && CUnis    - unidade 1
32:     this_cCUnips      = ""    && CUnips   - unidade 2
33:     *-- Dimensoes
34:     this_nAlturas     = 0     && Alturas
35:     this_nLarguras    = 0     && Larguras
36:     this_nDiametros   = 0     && Diametros
37:     this_nEspessuras  = 0     && Espessuras
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio

--- BO Linhas 32 a 42 ---
32:     this_cCUnips      = ""    && CUnips   - unidade 2
33:     *-- Dimensoes
34:     this_nAlturas     = 0     && Alturas
35:     this_nLarguras    = 0     && Larguras
36:     this_nDiametros   = 0     && Diametros
37:     this_nEspessuras  = 0     && Espessuras
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio
42:     *-- Classificacoes

--- BO Linhas 33 a 43 ---
33:     *-- Dimensoes
34:     this_nAlturas     = 0     && Alturas
35:     this_nLarguras    = 0     && Larguras
36:     this_nDiametros   = 0     && Diametros
37:     this_nEspessuras  = 0     && Espessuras
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio
42:     *-- Classificacoes
43:     this_cTams        = ""    && Tams     - tamanho

--- BO Linhas 36 a 46 ---
36:     this_nDiametros   = 0     && Diametros
37:     this_nEspessuras  = 0     && Espessuras
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio
42:     *-- Classificacoes
43:     this_cTams        = ""    && Tams     - tamanho
44:     this_cCorPros     = ""    && CorPros  - cor
45:     this_cCodFinPs    = ""    && CodFinPs - finalidade
46:     this_cCodAcbs     = ""    && CodAcbs  - acabamento

--- BO Linhas 38 a 48 ---
38:     this_nCompriments = 0     && Compriments
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio
42:     *-- Classificacoes
43:     this_cTams        = ""    && Tams     - tamanho
44:     this_cCorPros     = ""    && CorPros  - cor
45:     this_cCodFinPs    = ""    && CodFinPs - finalidade
46:     this_cCodAcbs     = ""    && CodAcbs  - acabamento
47:     this_cLocals      = ""    && Locals   - local
48:     this_cClasss      = ""    && Classs   - classificacao

--- BO Linhas 39 a 49 ---
39:     this_nPesoMs      = 0     && PesoMs      - peso base
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio
42:     *-- Classificacoes
43:     this_cTams        = ""    && Tams     - tamanho
44:     this_cCorPros     = ""    && CorPros  - cor
45:     this_cCodFinPs    = ""    && CodFinPs - finalidade
46:     this_cCodAcbs     = ""    && CodAcbs  - acabamento
47:     this_cLocals      = ""    && Locals   - local
48:     this_cClasss      = ""    && Classs   - classificacao
49:     *-- Precos e moedas

--- BO Linhas 40 a 50 ---
40:     this_nPesoBs      = 0     && PesoBs      - peso bruto
41:     this_nPesoPmedios = 0     && PesoPmedios - peso medio
42:     *-- Classificacoes
43:     this_cTams        = ""    && Tams     - tamanho
44:     this_cCorPros     = ""    && CorPros  - cor
45:     this_cCodFinPs    = ""    && CodFinPs - finalidade
46:     this_cCodAcbs     = ""    && CodAcbs  - acabamento
47:     this_cLocals      = ""    && Locals   - local
48:     this_cClasss      = ""    && Classs   - classificacao
49:     *-- Precos e moedas
50:     this_nPvens       = 0     && Pvens    - preco de venda

--- BO Linhas 43 a 53 ---
43:     this_cTams        = ""    && Tams     - tamanho
44:     this_cCorPros     = ""    && CorPros  - cor
45:     this_cCodFinPs    = ""    && CodFinPs - finalidade
46:     this_cCodAcbs     = ""    && CodAcbs  - acabamento
47:     this_cLocals      = ""    && Locals   - local
48:     this_cClasss      = ""    && Classs   - classificacao
49:     *-- Precos e moedas
50:     this_nPvens       = 0     && Pvens    - preco de venda
51:     this_cMoevs       = ""    && Moevs    - moeda venda
52:     this_nFvendas     = 0     && Fvendas  - fator venda
53:     this_cMfvendas    = ""    && Mfvendas - moeda fator venda

--- BO Linhas 48 a 58 ---
48:     this_cClasss      = ""    && Classs   - classificacao
49:     *-- Precos e moedas
50:     this_nPvens       = 0     && Pvens    - preco de venda
51:     this_cMoevs       = ""    && Moevs    - moeda venda
52:     this_nFvendas     = 0     && Fvendas  - fator venda
53:     this_cMfvendas    = ""    && Mfvendas - moeda fator venda
54:     this_nCustofs     = 0     && Custofs  - custo
55:     this_cMoecs       = ""    && Moecs    - moeda custo
56:     this_nMargems     = 0     && Margems  - margem
57:     this_nPcuss       = 0     && Pcuss    - preco custo unitario
58:     this_cMoePcs      = ""    && MoePcs   - moeda preco custo

--- BO Linhas 59 a 69 ---
59:     this_nFcustos     = 0     && Fcustos  - fator custo
60:     this_nPFTioCs     = 0     && PFTioCs  - feitio custo
61:     this_nPFTios      = 0     && PFTios   - feitio venda
62:     *-- Quantidades e lotes
63:     this_nQmins       = 0     && Qmins    - quantidade minima
64:     this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
65:     this_nConjuntos   = 0     && Conjuntos - conjunto
66:     this_nQtPeds      = 0     && QtPeds   - quantidade pedido
67:     *-- Flags booleanos (armazenados como INT 0/1)
68:     this_nGarVits     = 0     && GarVits     - garantia vitrine
69:     this_nConsigs     = 0     && Consigs     - consignado

--- BO Linhas 60 a 70 ---
60:     this_nPFTioCs     = 0     && PFTioCs  - feitio custo
61:     this_nPFTios      = 0     && PFTios   - feitio venda
62:     *-- Quantidades e lotes
63:     this_nQmins       = 0     && Qmins    - quantidade minima
64:     this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
65:     this_nConjuntos   = 0     && Conjuntos - conjunto
66:     this_nQtPeds      = 0     && QtPeds   - quantidade pedido
67:     *-- Flags booleanos (armazenados como INT 0/1)
68:     this_nGarVits     = 0     && GarVits     - garantia vitrine
69:     this_nConsigs     = 0     && Consigs     - consignado
70:     this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria

--- BO Linhas 61 a 71 ---
61:     this_nPFTios      = 0     && PFTios   - feitio venda
62:     *-- Quantidades e lotes
63:     this_nQmins       = 0     && Qmins    - quantidade minima
64:     this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
65:     this_nConjuntos   = 0     && Conjuntos - conjunto
66:     this_nQtPeds      = 0     && QtPeds   - quantidade pedido
67:     *-- Flags booleanos (armazenados como INT 0/1)
68:     this_nGarVits     = 0     && GarVits     - garantia vitrine
69:     this_nConsigs     = 0     && Consigs     - consignado
70:     this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
71:     this_nEncoms      = 0     && Encoms      - encomenda

--- BO Linhas 63 a 73 ---
63:     this_nQmins       = 0     && Qmins    - quantidade minima
64:     this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
65:     this_nConjuntos   = 0     && Conjuntos - conjunto
66:     this_nQtPeds      = 0     && QtPeds   - quantidade pedido
67:     *-- Flags booleanos (armazenados como INT 0/1)
68:     this_nGarVits     = 0     && GarVits     - garantia vitrine
69:     this_nConsigs     = 0     && Consigs     - consignado
70:     this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
71:     this_nEncoms      = 0     && Encoms      - encomenda
72:     this_nProdWebs    = 0     && ProdWebs    - produto web
73:     this_nOpcVars     = 0     && OpcVars     - opcao variacao

--- BO Linhas 68 a 78 ---
68:     this_nGarVits     = 0     && GarVits     - garantia vitrine
69:     this_nConsigs     = 0     && Consigs     - consignado
70:     this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
71:     this_nEncoms      = 0     && Encoms      - encomenda
72:     this_nProdWebs    = 0     && ProdWebs    - produto web
73:     this_nOpcVars     = 0     && OpcVars     - opcao variacao
74:     this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
75:     *-- Status e situacao
76:     this_nSituas      = 0     && Situas  - situacao
77:     this_dDtSituas    = {}    && DtSituas - data situacao
78:     *-- Observacoes

--- BO Linhas 69 a 79 ---
69:     this_nConsigs     = 0     && Consigs     - consignado
70:     this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
71:     this_nEncoms      = 0     && Encoms      - encomenda
72:     this_nProdWebs    = 0     && ProdWebs    - produto web
73:     this_nOpcVars     = 0     && OpcVars     - opcao variacao
74:     this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
75:     *-- Status e situacao
76:     this_nSituas      = 0     && Situas  - situacao
77:     this_dDtSituas    = {}    && DtSituas - data situacao
78:     *-- Observacoes
79:     this_cObs1s       = ""    && Obs1s

--- BO Linhas 74 a 84 ---
74:     this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
75:     *-- Status e situacao
76:     this_nSituas      = 0     && Situas  - situacao
77:     this_dDtSituas    = {}    && DtSituas - data situacao
78:     *-- Observacoes
79:     this_cObs1s       = ""    && Obs1s
80:     this_cObs2s       = ""    && Obs2s
81:     this_cObs3s       = ""    && Obs3s
82:     this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados

--- BO Linhas 75 a 85 ---
75:     *-- Status e situacao
76:     this_nSituas      = 0     && Situas  - situacao
77:     this_dDtSituas    = {}    && DtSituas - data situacao
78:     *-- Observacoes
79:     this_cObs1s       = ""    && Obs1s
80:     this_cObs2s       = ""    && Obs2s
81:     this_cObs3s       = ""    && Obs3s
82:     this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s

--- BO Linhas 76 a 86 ---
76:     this_nSituas      = 0     && Situas  - situacao
77:     this_dDtSituas    = {}    && DtSituas - data situacao
78:     *-- Observacoes
79:     this_cObs1s       = ""    && Obs1s
80:     this_cObs2s       = ""    && Obs2s
81:     this_cObs3s       = ""    && Obs3s
82:     this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s
86:     this_cFwget4s     = ""    && Fwget4s

--- BO Linhas 80 a 90 ---
80:     this_cObs2s       = ""    && Obs2s
81:     this_cObs3s       = ""    && Obs3s
82:     this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s
86:     this_cFwget4s     = ""    && Fwget4s
87:     this_cFwget5s     = ""    && Fwget5s
88:     this_cFwget6s     = ""    && Fwget6s
89:     this_cCodIdents   = ""    && CodIdents
90:     this_cTEnts       = ""    && TEnts  - tipo entrada

--- BO Linhas 81 a 91 ---
81:     this_cObs3s       = ""    && Obs3s
82:     this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s
86:     this_cFwget4s     = ""    && Fwget4s
87:     this_cFwget5s     = ""    && Fwget5s
88:     this_cFwget6s     = ""    && Fwget6s
89:     this_cCodIdents   = ""    && CodIdents
90:     this_cTEnts       = ""    && TEnts  - tipo entrada
91:     this_nDiasGars    = 0     && DiasGars - dias de garantia

--- BO Linhas 82 a 92 ---
82:     this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s
86:     this_cFwget4s     = ""    && Fwget4s
87:     this_cFwget5s     = ""    && Fwget5s
88:     this_cFwget6s     = ""    && Fwget6s
89:     this_cCodIdents   = ""    && CodIdents
90:     this_cTEnts       = ""    && TEnts  - tipo entrada
91:     this_nDiasGars    = 0     && DiasGars - dias de garantia
92:     *-- Campos FaseP (Fase P - dados de processo)

--- BO Linhas 83 a 93 ---
83:     this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s
86:     this_cFwget4s     = ""    && Fwget4s
87:     this_cFwget5s     = ""    && Fwget5s
88:     this_cFwget6s     = ""    && Fwget6s
89:     this_cCodIdents   = ""    && CodIdents
90:     this_cTEnts       = ""    && TEnts  - tipo entrada
91:     this_nDiasGars    = 0     && DiasGars - dias de garantia
92:     *-- Campos FaseP (Fase P - dados de processo)
93:     this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao

--- BO Linhas 84 a 94 ---
84:     *-- Campos customizados
85:     this_cFwget3s     = ""    && Fwget3s
86:     this_cFwget4s     = ""    && Fwget4s
87:     this_cFwget5s     = ""    && Fwget5s
88:     this_cFwget6s     = ""    && Fwget6s
89:     this_cCodIdents   = ""    && CodIdents
90:     this_cTEnts       = ""    && TEnts  - tipo entrada
91:     this_nDiasGars    = 0     && DiasGars - dias de garantia
92:     *-- Campos FaseP (Fase P - dados de processo)
93:     this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
94:     this_cCodGarras   = ""    && CodGarras  - codigo de garras

--- BO Linhas 86 a 96 ---
86:     this_cFwget4s     = ""    && Fwget4s
87:     this_cFwget5s     = ""    && Fwget5s
88:     this_cFwget6s     = ""    && Fwget6s
89:     this_cCodIdents   = ""    && CodIdents
90:     this_cTEnts       = ""    && TEnts  - tipo entrada
91:     this_nDiasGars    = 0     && DiasGars - dias de garantia
92:     *-- Campos FaseP (Fase P - dados de processo)
93:     this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
94:     this_cCodGarras   = ""    && CodGarras  - codigo de garras
95:     this_cConquilhas  = ""    && Conquilhas - conquilha padrao
96:     this_nPesoBris    = 0     && PesoBris   - peso brilhante

--- BO Linhas 100 a 110 ---
100:     this_nVarias      = 0     && Varias     - peso variavel (0/1)
101:     *-- Estoque e auditoria (somente leitura)
102:     this_nEstoques    = 0     && Estoques
103:     this_nQtdEsts     = 0     && QtdEsts
104:     this_dDtIncs      = {}    && DtIncs  - data de inclusao
105:     this_dDataAlts    = {}    && DataAlts - data alteracao
106:     this_cHoraAlts    = ""    && HoraAlts - hora alteracao
107:     this_cUsuaIncs    = ""    && UsuaIncs - usuario inclusao
108:     this_cUsuaAlts    = ""    && UsuaAlts - usuario alteracao
109:     this_dDtucps      = {}    && Dtucps  - data ult. compra
110:     this_nVucps       = 0     && Vucps   - valor ult. compra

--- BO Linhas 249 a 259 ---
249:         TRY
250:             IF USED("cursor_4c_BuscarBO")
251:                 USE IN cursor_4c_BuscarBO
252:             ENDIF
253:             loc_cSQL = "SELECT CPros, DPros, CGrus, SGrus, Reffs, " + ;
254:                        "UsuaAlts, CAST(ISNULL(Situas,0) AS INT) AS Instalas " + ;
255:                        "FROM SigCdPro"
256:             IF !EMPTY(par_cFiltro)
257:                 loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
258:             ENDIF
259:             loc_cSQL = loc_cSQL + " ORDER BY CPros"

--- BO Linhas 379 a 389 ---
379:                 "Colecoes    = " + EscaparSQL(THIS.this_cColecoes) + "," + ;
380:                 "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
381:                 "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
382:                 "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
383:                 "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
384:                 "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
385:                 "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
386:                 "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;

--- BO Linhas 380 a 390 ---
380:                 "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
381:                 "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
382:                 "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
383:                 "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
384:                 "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
385:                 "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
386:                 "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;

--- BO Linhas 383 a 393 ---
383:                 "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
384:                 "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
385:                 "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
386:                 "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;

--- BO Linhas 384 a 394 ---
384:                 "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
385:                 "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
386:                 "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;

--- BO Linhas 385 a 395 ---
385:                 "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
386:                 "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;

--- BO Linhas 386 a 396 ---
386:                 "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;

--- BO Linhas 387 a 397 ---
387:                 "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
388:                 "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
389:                 "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
397:                 "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;

--- BO Linhas 390 a 400 ---
390:                 "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
397:                 "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
398:                 "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
399:                 "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
400:                 "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;

--- BO Linhas 391 a 401 ---
391:                 "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
397:                 "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
398:                 "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
399:                 "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
400:                 "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
401:                 "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;

--- BO Linhas 392 a 402 ---
392:                 "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
397:                 "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
398:                 "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
399:                 "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
400:                 "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
401:                 "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
402:                 "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;

--- BO Linhas 393 a 403 ---
393:                 "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
394:                 "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
395:                 "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
397:                 "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
398:                 "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
399:                 "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
400:                 "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
401:                 "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
402:                 "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
403:                 "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;

--- BO Linhas 396 a 406 ---
396:                 "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
397:                 "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
398:                 "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
399:                 "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
400:                 "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
401:                 "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
402:                 "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
403:                 "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
404:                 "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
405:                 "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
406:                 "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;

--- BO Linhas 400 a 410 ---
400:                 "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
401:                 "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
402:                 "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
403:                 "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
404:                 "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
405:                 "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
406:                 "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
407:                 "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
408:                 "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
409:                 "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
410:                 "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;

--- BO Linhas 405 a 415 ---
405:                 "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
406:                 "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
407:                 "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
408:                 "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
409:                 "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
410:                 "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
411:                 "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
412:                 "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
413:                 "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
414:                 "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;

--- BO Linhas 406 a 416 ---
406:                 "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
407:                 "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
408:                 "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
409:                 "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
410:                 "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
411:                 "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
412:                 "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
413:                 "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
414:                 "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
416:                 "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;

--- BO Linhas 407 a 417 ---
407:                 "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
408:                 "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
409:                 "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
410:                 "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
411:                 "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
412:                 "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
413:                 "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
414:                 "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
416:                 "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
417:                 "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;

--- BO Linhas 408 a 418 ---
408:                 "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
409:                 "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
410:                 "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
411:                 "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
412:                 "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
413:                 "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
414:                 "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
416:                 "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
417:                 "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
418:                 "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;

--- BO Linhas 409 a 419 ---
409:                 "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
410:                 "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
411:                 "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
412:                 "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
413:                 "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
414:                 "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
416:                 "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
417:                 "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
418:                 "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
419:                 "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;

--- BO Linhas 414 a 424 ---
414:                 "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
416:                 "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
417:                 "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
418:                 "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
419:                 "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
420:                 "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
421:                 "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
422:                 "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
423:                 "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;

--- BO Linhas 415 a 425 ---
415:                 "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
416:                 "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
417:                 "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
418:                 "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
419:                 "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
420:                 "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
421:                 "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
422:                 "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
423:                 "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;

--- BO Linhas 418 a 428 ---
418:                 "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
419:                 "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
420:                 "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
421:                 "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
422:                 "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
423:                 "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;

--- BO Linhas 419 a 429 ---
419:                 "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
420:                 "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
421:                 "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
422:                 "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
423:                 "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;

--- BO Linhas 420 a 430 ---
420:                 "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
421:                 "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
422:                 "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
423:                 "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
430:                 "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;

--- BO Linhas 423 a 433 ---
423:                 "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
430:                 "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
431:                 "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
432:                 "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
433:                 "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;

--- BO Linhas 424 a 434 ---
424:                 "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
430:                 "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
431:                 "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
432:                 "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
433:                 "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
434:                 "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;

--- BO Linhas 425 a 435 ---
425:                 "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
430:                 "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
431:                 "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
432:                 "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
433:                 "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
434:                 "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
435:                 "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;

--- BO Linhas 426 a 436 ---
426:                 "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
430:                 "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
431:                 "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
432:                 "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
433:                 "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
434:                 "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
435:                 "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
436:                 "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;

--- BO Linhas 427 a 437 ---
427:                 "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
428:                 "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
429:                 "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
430:                 "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
431:                 "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
432:                 "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
433:                 "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
434:                 "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
435:                 "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
436:                 "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;
437:                 "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;

--- BO Linhas 437 a 447 ---
437:                 "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
438:                 "PesoMetal   = " + FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
439:                 "PesoPdrs    = " + FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
440:                 "CravCers    = " + FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
441:                 "Varias      = " + FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
442:                 "DataAlts    = GETDATE()," + ;
443:                 "UsuaAlts    = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
444:                 " WHERE CPros = " + EscaparSQL(PADR(THIS.this_cCpros, 14))
445:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
446:             IF loc_nResultado >= 0
447:                 THIS.RegistrarAuditoria("UPDATE")


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormProduto.prg
- BO: C:\4c\projeto\app\classes\ProdutoBO.prg
