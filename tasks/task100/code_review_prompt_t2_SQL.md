# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGAMENTOS, FPAGS, VENDS, OPERACAO, DOPES, RELFECHAS, VENDEDOR, CHKPAGOS, CODIGOS, CHKSUBN, EMPDOPNUMS, CALCFECS, USUARIOS, DATAS, CONTADS, LCANCELAS, PARCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGAMENTOS, FPAGS, VENDS, OPERACAO, DOPES, RELFECHAS, VENDEDOR, CHKPAGOS, CODIGOS, CHKSUBN, EMPDOPNUMS, CALCFECS, USUARIOS, DATAS, CONTADS, LCANCELAS, PARCS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Insert Into crImpressao (Detalhe) Values ([======= ANALITICO POR PAGAMENTOS =======])
Select Distinct FPags ;
  From crDetalhe ;
Select TmpFPags
	Select Iif(RelFechas=4, Padr([VALE], 12), FPags) as FPags, RPags, RChqs, ;
	  From crDetalhe ;
	Select TmpOpePags
			Insert Into crImpressao (Detalhe) Values (Padr(TmpOpePags.FPags, 10) + [ ] + Padr(TmpOpePags.Vends, 9) + ;
			Insert Into crImpressao (Detalhe) Values ([                    ] + TmpOpePags.Notas + [/] + ;
			Insert Into crImpressao (Detalhe) Values ([         ] + ;
			Insert Into crImpressao (Detalhe) Values ([        ] + TmpOpePags.RPags)
				Insert Into crImpressao (Detalhe) Values ([         ] + TmpOpePags.RChqs)
	Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
	Insert Into crImpressao (Detalhe) Values ([=              SUBTOTAL : ] + lcVal)
	Insert Into crImpressao (Detalhe) Values ([])
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([=           TOTAL GERAL : ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([])
Insert Into crImpressao (Detalhe) Values ([========================================])
Insert Into crImpressao (Detalhe) Values (Padc(lcDEp, 40))
Insert Into crImpressao (Detalhe) Values ([   Caixas de: ] + Dtoc(ldDtI) + [ à ] + Dtoc(ldDtF))
Insert Into crImpressao (Detalhe) Values ([   Usuario  : ] + Iif(Empty(lcUsu), [GERAL], lcUsu))
Insert Into crImpressao (Detalhe) Values ([   Fechamento em ] + Dtoc(Date()) + [ às ] + Substr(Ttoc(Datetime()), 12, 5) + [h])
Insert Into crImpressao (Detalhe) Values ([========================================])
Insert Into crImpressao (Detalhe) Values ([])
		Select Vends, Dopes, Sum(Iif(RelFechas=4, 0.00, ValPagos)) as Valos ;
		  From crDetalhe ;
		Select Space(10) as Vends, Dopes, Sum(Iif(RelFechas=4, 0.00, ValPagos)) as Valos ;
		  From crDetalhe ;
	Select Vends, Dopes, Sum(Iif(RelFechas=4, 0.00, ValPagos)) as Valos ;
	  From crDetalhe ;
Insert Into crImpressao (Detalhe) Values ([======== DETALHADO POR OPERACAO ========])
Select TmpOperacoes
	Insert Into crImpressao (Detalhe) Values ([= ] + TmpOperacoes.Dopes + [:   ] + lcVal)
			Select Distinct Vends, Dopes, Numes ;
			  From crDetalhe ;
			Select Distinct Dopes, Numes ;
			  From crDetalhe ;
		Select Distinct Dopes, Numes ;
		  From crDetalhe ;
	Select TmpOpeIndivs
		Select IClis, RClis, Notas, Vends, NVends, Parcs, FPags, ValPagos, Vencs, Bancos, Agencias, Contas, Numeros, RelFechas ;	
		  From crDetalhe ;
		Select TmpOpePags
				Insert Into crImpressao (Detalhe) Values ([> ] + Padl(Alltrim(TmpOpeIndivs.Numes), 6, [0]) + ;
				Insert Into crImpressao (Detalhe) Values ([        ] + ;
				Insert Into crImpressao (Detalhe) Values ([         ] + ;
		Select TmpOpePags
			Insert Into crImpressao (Detalhe) Values ([  ] + lcCli + [ ] + TmpOpePags.Notas)
			Select TmpOpePags
				Insert Into crImpressao (Detalhe) Values ([  ] + lcVdd)
	Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([=           TOTAL GERAL : ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([])
Select Dopes, Sum(ValPagos) as Valos ;
  From crDetalhe ;
Insert Into crImpressao (Detalhe) Values ([==== RESUMO: OPERACOES X PAGAMENTOS ====])
Insert Into crImpressao (Detalhe) Values ([])
Select TmpOperacoes
	Insert Into crImpressao (Detalhe) Values ([= ] + TmpOperacoes.Dopes)
	Select DetFecCxs, RelFechas, FPags, Sum(ValPagos) as Valos ;
	  From crDetalhe ;
	Select TmpFPags
		Insert Into crImpressao (Detalhe) Values ([  ] + TmpFPags.FPags + [ : ] + lcVal)
			Select Notas, FPags, Sum(ValPagos) as ValPagos, Vencs, Bancos, Agencias, Contas, Numeros, Outros ;	
			  From crDetalhe ;
			Select TmpOpeChqs
					Insert Into crImpressao (Detalhe) Values ([  ] + TmpOpeChqs.Notas + [ ] + TmpOpeChqs.Outros + ;
					Insert Into crImpressao (Detalhe) Values ([  ] + TmpOpeChqs.Notas + [ ] + Dtoc(TmpOpeChqs.Vencs) + ;
	Insert Into crImpressao (Detalhe) Values ([                 --------------])
	Insert Into crImpressao (Detalhe) Values ([      SUBTOTAL : ] + lcVal)
	Insert Into crImpressao (Detalhe) Values ([])
Insert Into crImpressao (Detalhe) Values ([                 --------------])
Insert Into crImpressao (Detalhe) Values ([  TOTAL GERAL  : ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([])
Select Iif(RelFechas=4, Padr([VALE], 12), FPags) as FPags, RelFechas, Sum(ValPagos) as Valos ;
  From crDetalhe ;
Insert Into crImpressao (Detalhe) Values ([==== RESUMO POR FORMAS DE PAGAMENTO ====])
Insert Into crImpressao (Detalhe) Values ([])
Select TmpFPags
	Insert Into crImpressao (Detalhe) Values ([= ] + TmpFPags.FPags + [ : ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([                 --------------])
Insert Into crImpressao (Detalhe) Values ([= TOTAL GERAL  : ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Select Iif(RelFechas=4, Padr([VALE], 12), FPags) as FPags, RelFechas, Sum(ValPagos) as Valos ;
  From crDetalhe ;
Insert Into crImpressao (Detalhe) Values ([])
Select TmpFPags
	Insert Into crImpressao (Detalhe) Values ([= ] + TmpFPags.FPags + [ : ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([                 --------------])
Insert Into crImpressao (Detalhe) Values ([= TOTAL ESPECIE: ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([])
Select Vends, Sum(ValPagos) as Valos ;
  From crDetalhe ;
Insert Into crImpressao (Detalhe) Values ([========= RESUMO POR VENDEDOR ==========])
Select TmpOperacoes
	Insert Into crImpressao (Detalhe) Values ([= ] + TmpOperacoes.Vends + [            : ] + lcVal)
	Select Dopes, Sum(ValPagos) as Valos ;
	  From crDetalhe ;
	Select TmpDopes
		Insert Into crImpressao (Detalhe) Values ([   ] + TmpDopes.Dopes + [ : ] + lcVal)
	Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([= TOTAL GERAL:            ] + lcVal)
Insert Into crImpressao (Detalhe) Values ([----------------------------------------])
Insert Into crImpressao (Detalhe) Values ([])
lcQuery = [Select o.RelFechas, o.CalcFecs, e.EmpDopNums, e.Datas, e.ContaDs, c.RClis, e.Notas, e.Usuars, ] + ;
		  	[From SigCdOpe o, SigMvCab e, SigCdCli c ] + ;
				   [Select a1.EmpDopNums From SigMvPec a1 ] + ;
			   		 	  [Select (o1.NDopes * 1000000 ) + e1.Numes as Codigos ] + ;
			   			    [From SigCdOpe o1, SigMvCab e1 ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crDados]) < 1)
Delete From crDados Where RelFechas = 1 And ChkSubn = .t. && Apagando as VENDA NF PZ canceladas
Update crDados Set Vends = ContaDs Where Empty(Vends)
Select crDados
	lcQuery = [Select a.EmpDopNums, a.Parcs, a.FPags, b.Formas, b.Infos, a.Bancos, a.Agencias, ]+ ;
			    [From SigMvPar a, SigOpFp b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPags1]) < 1)
	Select crPags1
		Select * ;
		  From crPags1 ;
		lcQuery = [Select b.EmpDopNums, b.Parcs, b.FPags, c.Formas, c.Infos, b.Bancos, b.Agencias, b.Contas, b.Numeros, ]+ ;
			        [From SigMvPec a, SigMvPar b, SigOpFp c ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPags]) < 1)
	Select crPags
		Delete In crDados
			Insert Into crPagamentos From Memvar
Select Left(a.EmpDopNums, 3) as Emps, Substr(a.EmpDopNums, 4, 20) as Dopes, Right(a.EmpDopNums, 6) as Numes, ;
  From crDados a Right Join crPagamentos b ;
Select crDetalhe
		lcQuery = [Select e.Numes + (o.NDopes * 1000000) as Codigos, p.EmpDopNums ] + ;
					[From SigMvCab e, SigCdOpe o, SigMvPec p ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crVista1]) < 1)
		Select crVista1
			lcQuery = [Select r.Parcs, r.FPags, r.Valos, r.Vencs, r.Contas, r.Numeros ] + ;
						[From SigMvPar r ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crVista]) < 1)
			Select crVista
						lcQuery = [Select NComps ] + ;
								    [From SigCdUsu ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crNVends]) < 1)
						Select crNVends
	lcQuery = [Select NComps ] + ;
			    [From SigCdUsu ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crNVends]) < 1)
	Select crNVends
Select crImpressao
lcQuery = [Select a.* From SigCdUsu a ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpUsu') < 1)
Select TmpUsu
	select tmpusu
	If Not seek(this.Value)
	select tmpusu

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefec.prg) - TRECHOS RELEVANTES PARA PASS SQL (1244 linhas total):

*-- Linhas 746 a 764:
746:                 loc_cArquivo = SYS(2023) + "\FechamentoCaixa.xls"
747: 
748:                 IF USED("crImpressao")
749:                     SELECT crImpressao
750:                     COPY TO (loc_cArquivo) TYPE XLS
751: 
752:                     IF FILE(loc_cArquivo)
753:                         MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo, ;
754:                             "Excel Exportado")
755:                     ELSE
756:                         MsgErro("Falha ao criar arquivo Excel.", "Erro")
757:                     ENDIF
758:                 ELSE
759:                     MsgAviso("Nenhum dado para exportar.", "Excel")
760:                 ENDIF
761:             ELSE
762:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Exportar")
763:             ENDIF
764:         ENDIF

*-- Linhas 930 a 953:
930:             RETURN
931:         ENDIF
932: 
933:         loc_cSQL = "SELECT Usuarios FROM SigCdUsu WHERE Usuarios = " + ;
934:                    EscaparSQL(loc_cValor)
935:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsrVal")
936: 
937:         IF loc_nResult > 0
938:             SELECT cursor_4c_UsrVal
939:             GO TOP IN cursor_4c_UsrVal
940:             IF !EOF("cursor_4c_UsrVal")
941:                 loc_oPg1.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_UsrVal.Usuarios)
942:                 USE IN cursor_4c_UsrVal
943:                 RETURN
944:             ENDIF
945:             USE IN cursor_4c_UsrVal
946:         ENDIF
947: 
948:         THIS.AbrirBuscaUsuars()
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     * AbrirBuscaUsuars - Abre FormBuscaAuxiliar para selecionar usuario
953:     *--------------------------------------------------------------------------

*-- Linhas 991 a 1014:
991:             RETURN
992:         ENDIF
993: 
994:         loc_cSQL = "SELECT FPags, Descrs FROM SigOpFp WHERE FPags = " + ;
995:                    EscaparSQL(loc_cValor)
996:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPgVal")
997: 
998:         IF loc_nResult > 0
999:             SELECT cursor_4c_FPgVal
1000:             GO TOP IN cursor_4c_FPgVal
1001:             IF !EOF("cursor_4c_FPgVal")
1002:                 loc_oPg1.txt_4c_FPags.Value = ALLTRIM(cursor_4c_FPgVal.FPags)
1003:                 USE IN cursor_4c_FPgVal
1004:                 RETURN
1005:             ENDIF
1006:             USE IN cursor_4c_FPgVal
1007:         ENDIF
1008: 
1009:         THIS.AbrirBuscaFPags()
1010:     ENDPROC
1011: 
1012:     *--------------------------------------------------------------------------
1013:     * AbrirBuscaFPags - Abre FormBuscaAuxiliar para selecionar forma de pagamento
1014:     *--------------------------------------------------------------------------

*-- Linhas 1053 a 1077:
1053:             RETURN
1054:         ENDIF
1055: 
1056:         loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu " + ;
1057:                    "WHERE Usuarios = " + EscaparSQL(loc_cValor) + ;
1058:                    " AND NOT cAtivos = 'N'"
1059:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VndVal")
1060: 
1061:         IF loc_nResult > 0
1062:             SELECT cursor_4c_VndVal
1063:             GO TOP IN cursor_4c_VndVal
1064:             IF !EOF("cursor_4c_VndVal")
1065:                 loc_oPg1.txt_4c_Vends.Value = ALLTRIM(cursor_4c_VndVal.Usuarios)
1066:                 USE IN cursor_4c_VndVal
1067:                 RETURN
1068:             ENDIF
1069:             USE IN cursor_4c_VndVal
1070:         ENDIF
1071: 
1072:         THIS.AbrirBuscaVends()
1073:     ENDPROC
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * AbrirBuscaVends - Abre FormBuscaAuxiliar para selecionar vendedor
1077:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigrefecBO.prg):
*==============================================================================
* SIGREFECBO.PRG
* Business Object para Relatorio de Fechamento de Caixa
* Herda de RelatorioBase
*
* Formulario original: SIGREFEC (sigrefec.SCX)
* Caption: "Fechamento de Caixa"
*==============================================================================

DEFINE CLASS sigrefecBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmps       = ""    && Codigo da empresa (3)
    this_cDEmps      = ""    && Razao social da empresa (40)

    *-- Filtro: Periodo
    this_dDtIni      = {}    && Data inicial
    this_dDtFim      = {}    && Data final

    *-- Filtro: Usuario / Vendedor / Forma de Pagamento
    this_cUsuars     = ""    && Codigo do usuario (10)
    this_cVends      = ""    && Codigo do vendedor (10)
    this_cFPags      = ""    && Condicao de pagamento / forma (10)

    *-- Opcoes de impressao (checkboxes)
    this_lDetOpe     = .F.   && Detalhado Por Operacao
    this_lVends      = .F.   && Imprime Vendedor
    this_lOpePag     = .T.   && Operacoes X Pagamentos
    this_lResFpg     = .T.   && Resumo Por Formas de Pagamento
    this_lAnaPag     = .F.   && Analitico Por Pagamentos
    this_lVendRes    = .F.   && Resumo Por Vendedor

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtIni = DATE()
            THIS.this_dDtFim = DATE()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrefecBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Wrapper com TRY/CATCH para PrepararDadosInterno
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDadosInterno()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosInterno - Logica completa de preparacao (retorno direto OK)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosInterno()
        LOCAL loc_cSQL, loc_nResult, loc_cEdn, loc_cFPags
        LOCAL loc_cVista1EmpDopNums, loc_lnPri
        PRIVATE pDtI, pDtF

        pDtI    = THIS.this_dDtIni
        pDtF    = THIS.this_dDtFim + 1  && limite superior exclusivo (inicio do proximo dia)
        loc_cFPags = ALLTRIM(THIS.this_cFPags)

        *-- Query principal: todas as operacoes de fechamento de caixa do periodo
        loc_cSQL = "SELECT o.RelFechas, o.CalcFecs, e.EmpDopNums, e.Datas, " + ;
                   "e.ContaDs, c.RClis, e.Notas, e.Usuars, e.Valos, e.Vends, " + ;
                   "o.COpers, (o.NDopes * 1000000) + e.Numes AS Codigos, e.ChkSubn " + ;
                   "FROM SigCdOpe o, SigMvCab e, SigCdCli c " + ;
                   "WHERE (o.RelFechas = 1 OR o.RelFechas = 4 " + ;
                   "OR (o.RelFechas = 3 AND e.chkPagos = 1)) " + ;
                   "AND o.CalcFecs = 2 AND o.Dopes = e.Dopes " + ;
                   "AND e.Datas >= ?pDtI AND e.Datas < ?pDtF " + ;
                   "AND e.ContaDs = c.IClis AND e.lcancelas = 0"

        loc_cSQL = loc_cSQL + ;
                   " AND NOT e.EmpDopNums IN (" + ;
                   "SELECT a1.EmpDopNums FROM SigMvPec a1 " + ;
                   "WHERE a1.Codigos IN (" + ;
                   "SELECT (o1.NDopes * 1000000) + e1.Numes AS Codigos " + ;
                   "FROM SigCdOpe o1, SigMvCab e1 " + ;
                   "WHERE o1.RelFechas = 3 AND o1.CalcFecs = 2 " + ;
                   "AND o1.Dopes = e1.Dopes " + ;
                   "AND e1.Datas >= ?pDtI AND e1.Datas < ?pDtF))" + ;
                   " ORDER BY e.EmpDopNums"

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crDados)"
            MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
            RETURN .F.
        ENDIF

        *-- Remove vendas NF parceladas canceladas
        DELETE FROM crDados WHERE RelFechas = 1 AND ChkSubn = .T.

        *-- Substitui vendedor vazio pelo codigo do cliente
        UPDATE crDados SET Vends = ContaDs WHERE EMPTY(Vends)

        *-- Filtra por usuario se especificado
        IF !EMPTY(ALLTRIM(THIS.this_cUsuars))
            DELETE FROM crDados WHERE Usuars != PADR(ALLTRIM(THIS.this_cUsuars), 10)
        ENDIF

        *-- Cria cursor de pagamentos consolidados
        CREATE CURSOR crPagamentos ;
            (EmpDopNums C(29), Parcs N(3), FPags C(12), Bancos C(3), ;
             Agencias C(4), Contas C(10), Numeros C(6), Valos N(12,2), ;
             MoeFpgs C(3), Vencs D(8), Outros C(20), DetFecCxs N(1))

        *-- Para cada operacao, busca formas de pagamento
        SELECT crDados
        SCAN
            loc_cEdn = crDados.EmpDopNums

            *-- Tenta buscar pagamentos diretos em SigMvPar
            loc_cSQL = "SELECT a.EmpDopNums, a.Parcs, a.FPags, b.Formas, b.Infos, " + ;
                       "a.Bancos, a.Agencias, a.Contas, a.Numeros, " + ;
                       "CASE WHEN b.trocos=1 THEN -a.valos ELSE a.valos END AS valos, " + ;
                       "a.MoeFpgs, a.Vencs, a.Outros, b.DetFecCxs " + ;
                       "FROM SigMvPar a, SigOpFp b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND a.FPags = b.FPags ORDER BY a.Parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags1)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crPags1
            GO TOP IN crPags1
            IF !EOF("crPags1")
                *-- Filtra por forma de pagamento especificada (se houver)
                SELECT * FROM crPags1 ;
                    WHERE IIF(EMPTY(loc_cFPags), .T., FPags = PADR(loc_cFPags, 12)) ;
                    INTO CURSOR crPags READWRITE
            ELSE
                *-- Operacao vinculada: busca via SigMvPec
                loc_cSQL = "SELECT b.EmpDopNums, b.Parcs, b.FPags, c.Formas, c.Infos, " + ;
                           "b.Bancos, b.Agencias, b.Contas, b.Numeros, " + ;
                           "CASE WHEN c.trocos=1 THEN -b.valos ELSE b.valos END AS valos, " + ;
                           "b.MoeFpgs, b.Vencs, b.Outros, c.DetFecCxs " + ;
                           "FROM SigMvPec a, SigMvPar b, SigOpFp c " + ;
                           "WHERE a.Codigos = " + LTRIM(STR(crDados.Codigos, 10)) + ;
                           " AND a.EmpDopNums = b.EmpDopNums AND b.FPags = c.FPags"

                IF !EMPTY(loc_cFPags)
                    loc_cSQL = loc_cSQL + " AND b.FPags = " + EscaparSQL(PADR(loc_cFPags, 12))
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY b.Parcs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF
            ENDIF

            SELECT crPags
            GO TOP IN crPags
            IF EOF("crPags") AND !EMPTY(loc_cFPags)
                DELETE IN crDados
            ELSE
                SCAN
                    SCATTER MEMVAR MEMO
                    m.EmpDopNums = loc_cEdn
                    m.FPags = IIF(m.Infos = "B" AND !EMPTY(m.Formas), m.Formas, m.FPags)
                    INSERT INTO crPagamentos FROM MEMVAR
                ENDSCAN
            ENDIF
        ENDSCAN

        *-- Monta crDetalhe: JOIN entre crDados e crPagamentos
        SELECT LEFT(a.EmpDopNums, 3) AS Emps, ;
               SUBSTR(a.EmpDopNums, 4, 20) AS Dopes, ;
               RIGHT(a.EmpDopNums, 6) AS Numes, ;
               a.Datas, a.ContaDs AS IClis, a.RClis, a.Notas, ;
               a.Valos * IIF(a.COpers = 2, -1, 1) AS Valos, ;
               a.Vends, SPACE(30) AS NVends, a.Codigos, a.Usuars, ;
               b.Parcs, b.FPags, b.Bancos, b.Agencias, b.Contas, ;
               b.Numeros, b.Valos * IIF(a.COpers = 2, -1, 1) AS ValPagos, ;
               b.MoeFpgs, b.Vencs, b.DetFecCxs, b.Outros, ;
               a.RelFechas, a.CalcFecs, ;
               SPACE(32) AS RPags, SPACE(32) AS RChqs ;
            FROM crDados a RIGHT JOIN crPagamentos b ;
            ON a.EmpDopNums = b.EmpDopNums ;
            ORDER BY a.Datas, a.EmpDopNums, b.Parcs ;
            INTO CURSOR crDetalhe READWRITE

        *-- Preenche NVends e campos de vista (RPags/RChqs) em crDetalhe
        SELECT crDetalhe
        SCAN
            IF crDetalhe.RelFechas = 3 AND crDetalhe.CalcFecs = 2
                *-- Reconstroi EmpDopNums a partir dos campos fixos (sem ALLTRIM - fixed-width)
                loc_cEdn = crDetalhe.Emps + crDetalhe.Dopes + crDetalhe.Numes

                loc_cSQL = "SELECT p.EmpDopNums " + ;
                           "FROM SigMvPec p " + ;
                           "WHERE p.Codigos = " + LTRIM(STR(crDetalhe.Codigos, 10)) + ;
                           " ORDER BY p.EmpDopNums"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista1)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF

                SELECT crVista1
                GO TOP IN crVista1
                IF !EOF("crVista1")
                    loc_cVista1EmpDopNums = crVista1.EmpDopNums

                    loc_cSQL = "SELECT r.Parcs, r.FPags, r.Valos, r.Vencs, " + ;
                               "r.Contas, r.Numeros " + ;
                               "FROM SigMvPar r " + ;
                               "WHERE r.EmpDopNums = " + EscaparSQL(loc_cVista1EmpDopNums) + ;
                               " AND r.Parcs = " + LTRIM(STR(crDetalhe.Parcs, 2)) + ;
                               " ORDER BY r.Parcs"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista)"
                        MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                        RETURN .F.
                    ENDIF

                    loc_lnPri = 1
                    SELECT crVista
                    SCAN
                        IF !ISNULL(crVista.FPags)
                            IF loc_lnPri > 1
                                loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                                           "WHERE Usuarios = " + EscaparSQL(crDetalhe.Vends)

                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
                                IF loc_nResult < 1
                                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                                    RETURN .F.
                                ENDIF

                                SELECT crNVends
                                GO TOP IN crNVends
                                IF !EOF("crNVends")
                                    REPLACE NVends WITH crNVends.NComps IN crDetalhe
                                ENDIF

                                SKIP IN crDetalhe
                            ENDIF

                            REPLACE RPags WITH LTRIM(STR(loc_lnPri, 2)) + " " + crVista.FPags + ;
                                    " " + SPACE(6) + ;
                                    TRANSFORM(crVista.Valos, "999,999.99") IN crDetalhe

                            IF !EMPTY(crVista.Numeros)
                                REPLACE RChqs WITH crVista.Contas + " / " + crVista.Numeros + ;
                                        "  " + DTOC(crVista.Vencs) IN crDetalhe
                            ENDIF

                            loc_lnPri = loc_lnPri + 1
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Preenche nome do vendedor para todas as linhas
            loc_cSQL = "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                       EscaparSQL(crDetalhe.Vends)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crNVends
            GO TOP IN crNVends
            IF !EOF("crNVends")
                REPLACE NVends WITH crNVends.NComps IN crDetalhe
            ENDIF
        ENDSCAN

        *-- Monta impressao linha a linha em crImpressao
        CREATE CURSOR crImpressao (Detalhe C(40))

        SET POINT TO ","
        SET SEPARATOR TO "."

        THIS.Cabecalho()

        IF THIS.this_lDetOpe
            THIS.Detalhado()
        ENDIF

        IF THIS.this_lVendRes
            THIS.ResVends()
        ENDIF

        IF THIS.this_lResFpg
            THIS.ResumoPagto()
        ENDIF

        IF THIS.this_lOpePag
            THIS.PagtoXFpags()
        ENDIF

        IF THIS.this_lAnaPag
            THIS.AnaFPags()
        ENDIF

        SET POINT TO "."
        SET SEPARATOR TO ","

        SELECT crImpressao
        GO TOP IN crImpressao

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cabecalho - Insere cabecalho do relatorio em crImpressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Cabecalho()
        LOCAL loc_cDEmps, loc_dDtIni, loc_dDtFim, loc_cUsuars

        loc_cDEmps  = ALLTRIM(THIS.this_cDEmps)
        loc_dDtIni  = THIS.this_dDtIni
        loc_dDtFim  = THIS.this_dDtFim
        loc_cUsuars = ALLTRIM(THIS.this_cUsuars)

        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES (PADC(loc_cDEmps, 40))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Caixas de: " + DTOC(loc_dDtIni) + ;
            " " + CHR(224) + " " + DTOC(loc_dDtFim))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Usuario  : " + ;
            IIF(EMPTY(loc_cUsuars), "GERAL", loc_cUsuars))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Fechamento em " + DTOC(DATE()) + ;
            " " + CHR(224) + "s " + SUBSTR(TTOC(DATETIME()), 12, 5) + "h")
        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Detalhado - Secao detalhada por operacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Detalhado()
        LOCAL loc_cVen, loc_cVal, loc_lnTot, loc_cCli, loc_cVdd

        loc_cVen   = ALLTRIM(THIS.this_cVends)
        loc_lnTot  = 0

        IF EMPTY(loc_cVen)
            IF THIS.this_lVends
                SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Vends, Dopes ;
                    ORDER BY Dopes, Vends ;
                    INTO CURSOR TmpOperacoes
            ELSE
                SELECT SPACE(10) AS Vends, Dopes, ;
                       SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Dopes ;
                    ORDER BY Dopes ;
                    INTO CURSOR TmpOperacoes
            ENDIF
        ELSE
            SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = loc_cVen ;
                GROUP BY Vends, Dopes ;
                ORDER BY Dopes, Vends ;
                INTO CURSOR TmpOperacoes
        ENDIF

        INSERT INTO crImpressao (Detalhe) VALUES ("======== DETALHADO POR OPERACAO ========")

        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes + ":   " + loc_cVal)

            IF EMPTY(loc_cVen)
                IF THIS.this_lVends
                    SELECT DISTINCT Vends, Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND Vends = TmpOperacoes.Vends ;
                        ORDER BY Dopes, Vends, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ELSE
                    SELECT DISTINCT Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes ;
                        ORDER BY Dopes, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ENDIF
            ELSE
                SELECT DISTINCT Dopes, Numes ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOperacoes.Dopes AND Vends = loc_cVen ;
                    ORDER BY Dopes, Numes ;
                    INTO CURSOR TmpOpeIndivs
            ENDIF

            SELECT TmpOpeIndivs
            SCAN
                SELECT IClis, RClis, Notas, Vends, NVends, Parcs, FPags, ValPagos, ;
                       Vencs, Bancos, Agencias, Contas, Numeros, RelFechas ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOpeIndivs.Dopes AND Numes = TmpOpeIndivs.Numes ;
                    ORDER BY Parcs ;
                    INTO CURSOR TmpOpePags

                SELECT TmpOpePags
                SCAN
                    loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999,999.99")

                    IF TmpOpePags.Parcs = 1
                        INSERT INTO crImpressao (Detalhe) VALUES ("> " + ;
                            PADL(ALLTRIM(TmpOpeIndivs.Numes), 6, "0") + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ELSE
                        INSERT INTO crImpressao (Detalhe) VALUES ("        " + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ENDIF

                    IF !EMPTY(TmpOpePags.Numeros)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                            TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                            "  " + DTOC(TmpOpePags.Vencs))
                    ENDIF
                ENDSCAN

                SELECT TmpOpePags
                GO TOP IN TmpOpePags
                IF !EOF("TmpOpePags")
                    loc_cCli = PADR(ALLTRIM(TmpOpePags.IClis) + " - " + ;
                                    ALLTRIM(TmpOpePags.RClis), 31)
                    INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cCli + " " + TmpOpePags.Notas)
                ENDIF

                IF THIS.this_lVends
                    SELECT TmpOpePags
                    GO TOP IN TmpOpePags
                    IF !EOF("TmpOpePags")
                        IF EMPTY(TmpOpePags.Vends)
                            loc_cVdd = ALLTRIM(TmpOpePags.IClis) + " - " + ALLTRIM(TmpOpePags.RClis)
                        ELSE
                            loc_cVdd = ALLTRIM(TmpOpePags.Vends) + " - " + ALLTRIM(TmpOpePags.NVends)
                        ENDIF
                        INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cVdd)
                    ENDIF
                ENDIF
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * PagtoXFpags - Secao Operacoes X Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PagtoXFpags()
        LOCAL loc_cVal, loc_lnTot, loc_lnGer

        SELECT Dopes, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Dopes ;
            ORDER BY Dopes ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO: OPERACOES X PAGAMENTOS ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnGer = 0
        SELECT TmpOperacoes
        SCAN
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes)

            SELECT DetFecCxs, RelFechas, FPags, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Dopes = TmpOperacoes.Dopes ;
                GROUP BY DetFecCxs, RelFechas, FPags ;
                ORDER BY FPags ;
                INTO CURSOR TmpFPags

            loc_lnTot = 0
            SELECT TmpFPags
            SCAN
                loc_lnGer = loc_lnGer + IIF(RelFechas=4, 0, TmpFPags.Valos)
                loc_lnTot = loc_lnTot + IIF(RelFechas=4, 0, TmpFPags.Valos)

                loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpFPags.FPags + " : " + loc_cVal)

                IF TmpFPags.DetFecCxs = 1 AND TmpFPags.RelFechas = 3
                    SELECT Notas, FPags, SUM(ValPagos) AS ValPagos, ;
                           Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND FPags = TmpFPags.FPags ;
                        GROUP BY Notas, FPags, Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        ORDER BY Notas ;
                        INTO CURSOR TmpOpeChqs

                    SELECT TmpOpeChqs
                    SCAN
                        IF !EMPTY(TmpOpeChqs.Outros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + TmpOpeChqs.Outros + " " + loc_cVal)
                        ENDIF

                        IF !EMPTY(TmpOpeChqs.Numeros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "99,999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + DTOC(TmpOpeChqs.Vencs) + " " + ;
                                TmpOpeChqs.Numeros + " " + loc_cVal)
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("      SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnGer, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("  TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResumoPagto - Secao Resumo Por Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResumoPagto()
        LOCAL loc_cVal, loc_lnTot

        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO POR FORMAS DE PAGAMENTO ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")

        *-- Subtotal especifico VALE + DINHEIRO + TROCO
        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            WHERE RelFechas = 4 OR INLIST(FPags, "DINHEIRO    ", "TROCO       ") ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL ESPECIE: " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResVends - Secao Resumo Por Vendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResVends()
        LOCAL loc_cVal, loc_lnTot

        SELECT Vends, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Vends ;
            ORDER BY Vends ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("========= RESUMO POR VENDEDOR ==========")

        loc_lnTot = 0
        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Vends + ;
                "            : " + loc_cVal)

            SELECT Dopes, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = TmpOperacoes.Vends ;
                GROUP BY Dopes ;
                ORDER BY Dopes ;
                INTO CURSOR TmpDopes

            SELECT TmpDopes
            SCAN
                loc_cVal = TRANSFORM(TmpDopes.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("   " + TmpDopes.Dopes + " : " + loc_cVal)
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL:            " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * AnaFPags - Secao Analitico Por Pagamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AnaFPags()
        LOCAL loc_cVal, loc_lnTot, loc_lnSub

        INSERT INTO crImpressao (Detalhe) VALUES ("======= ANALITICO POR PAGAMENTOS =======")

        SELECT DISTINCT FPags ;
            FROM crDetalhe ;
            ORDER BY FPags ;
            INTO CURSOR TmpFPags

        loc_lnTot = 0

        SELECT TmpFPags
        SCAN
            SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
                   RPags, RChqs, RelFechas, Vends, Notas, Parcs, ;
                   ValPagos, Contas, Numeros, Vencs ;
                FROM crDetalhe ;
                WHERE FPags = TmpFPags.FPags ;
                ORDER BY FPags, Vends, Notas, Parcs ;
                INTO CURSOR TmpOpePags

            loc_lnSub = 0

            SELECT TmpOpePags
            SCAN
                loc_lnTot = loc_lnTot + TmpOpePags.ValPagos
                loc_lnSub = loc_lnSub + TmpOpePags.ValPagos

                loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999.99")

                IF TmpOpePags.Parcs = 1
                    INSERT INTO crImpressao (Detalhe) VALUES (PADR(TmpOpePags.FPags, 10) + " " + ;
                        PADR(TmpOpePags.Vends, 9) + TmpOpePags.Notas + ;
                        "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ELSE
                    INSERT INTO crImpressao (Detalhe) VALUES ("                    " + ;
                        TmpOpePags.Notas + "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ENDIF

                IF !EMPTY(TmpOpePags.Numeros)
                    INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                        TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                        "  " + DTOC(TmpOpePags.Vencs))
                ENDIF

                IF !EMPTY(TmpOpePags.RPags)
                    INSERT INTO crImpressao (Detalhe) VALUES ("        " + TmpOpePags.RPags)

                    IF !EMPTY(TmpOpePags.RChqs)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + TmpOpePags.RChqs)
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnSub, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("=              SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigReFec") TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigReFec") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE

