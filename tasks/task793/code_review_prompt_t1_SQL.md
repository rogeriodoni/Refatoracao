# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DDESC, CITENS, CPROS, TIPOOPS, DOPES, COLECOES, EMPS, DIA, MES, CARESUBNS, CODIGOS, DTTERMS, VARPADS, ICLIS, USUARIOS, CCARGS, GRUPOS, DATAS, LCMSG, CGRUS, I, CODCORS, FPAGS, CTIPOS, IMPBOLS, VALPENDS, DESC2S, CODSERVS, CONTAPAR, VINSS, VTOTISS, LNVTIT, LNCONT, _NUMC, LNVTX, LNCTSV, LNVTXOCOR, AGCOBS, CONTAS, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DDESC, CITENS, CPROS, TIPOOPS, DOPES, COLECOES, EMPS, DIA, MES, CARESUBNS, CODIGOS, DTTERMS, VARPADS, ICLIS, USUARIOS, CCARGS, GRUPOS, DATAS, LCMSG, CGRUS, I, CODCORS, FPAGS, CTIPOS, IMPBOLS, VALPENDS, DESC2S, CODSERVS, CONTAPAR, VINSS, VTOTISS, LNVTIT, LNCONT, _NUMC, LNVTX, LNCTSV, LNVTXOCOR, AGCOBS, CONTAS, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DDESC, CITENS, CPROS, TIPOOPS, DOPES, COLECOES, EMPS, DIA, MES, CARESUBNS, CODIGOS, DTTERMS, VARPADS, ICLIS, USUARIOS, CCARGS, GRUPOS, DATAS, LCMSG, CGRUS, I, CODCORS, FPAGS, CTIPOS, IMPBOLS, VALPENDS, DESC2S, CODSERVS, CONTAPAR, VINSS, VTOTISS, LNVTIT, LNCONT, _NUMC, LNVTX, LNCTSV, LNVTXOCOR, AGCOBS, CONTAS, OPERS

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
lnOldSel = Select()
Select crSigCdPaC
lcQuery = [SELECT B.DATAS,B.EMPS,CONVERT(CHAR(2),B.DIA) AS DIA,CONVERT(CHAR(2),B.MES) AS MES,A.COLECOES,B.VENDA,A.DESCONTO ] + ;
	[FROM ( ] + ;
	[SELECT A.EMPDOPNUMS,B.COLECOES,SUM(VDES) AS 'DESCONTO' FROM SIGMVITD A ] + ;
	[LEFT OUTER JOIN SIGCDPRO B ON A.CPROS=B.CPROS ] + ;
	[INNER JOIN ( ] + ;
	[SELECT A.EMPS,A.DATAS,REPLICATE('0',2-LEN(DAY(A.DATAS))) +CONVERT(VARCHAR(2),DAY(A.DATAS)) AS DIA, ] + ;
	[A.EMPDOPNUMS,D.COLECOES,SUM(C.TOTAS) AS 'VENDA' FROM SIGMVCAB A ] + ;
	[INNER JOIN SIGCDOPE B ON A.DOPES=B.DOPES ] + ;
	[INNER JOIN SIGMVITN C ON A.EMPDOPNUMS=C.EMPDOPNUMS ] + ;
	[LEFT OUTER JOIN SIGCDPRO D ON C.CPROS=D.CPROS ] + ;
	[LEFT OUTER JOIN SIGMVITD E ON C.EMPDOPNUMS=E.EMPDOPNUMS AND C.CITENS=E.CITENS AND E.CPROS=D.CPROS ] + ;
	[AND LTRIM(RTRIM(B.EMPS))+LTRIM(RTRIM(B.DIA))+LTRIM(RTRIM(B.MES)) NOT IN(SELECT LTRIM(RTRIM(EMPS))+LTRIM(RTRIM(DIA))+LTRIM(RTRIM(MES)) FROM SIGOPRBT) ] + ;
If Thisform.poDataMgr.SqlExecute(lcQuery,[crSigMvRbt]) < 1
Select crSigMvCab
Select crSigMvItn
Select crSigMvIts
Select crSigMvPar
Select crSigMvCcr
Select CrSigOpCoc
Select crSigChe
Select crSigChLcq
Select crSigCqChm
Select crSigOpRbt
Select crSigMvRbt
Select DataS, Emps, Dia, Mes, Sum(Desconto) As Desconto From crSigMvRbt Group By DataS, Emps, Dia, Mes Into Cursor csMovRbt Readwrite
Select csMovRbt
	lcQuery = [Select CidChaves From SigOpRbt Where Emps = ']+lcEmps+[' And Dia = ']+lcDia+[' and Mes = ']+lcMes+[' ]
	=Thisform.poDataMgr.SqlExecute(lcQuery,'crTmpRbt')
	Select crTmpRbt
		Select csMovRbt
	Select crSigOpRbt
	Insert into crSigOpRbt(Emps, dia, mes, datas, cidchaves) ;
	Select csMovRbt
	Insert Into crSigMvCab ( Emps, Dopes, Numes, Usuars, Datars, DataS, Transps, Mascnum, Tabds, LPrecos, CidChaves, EmpDopNums, Dgopes, vcompensas, TpFats ) ;
		Select CrTmpObs
			Select crSigMvCab
	lcQuery = [Select a.* From SigOpTdz a, SigOpTdo b Where b.Dopes = ']+crSigCdOpe.Dopes+[' And a.Codigos = b.Tabds ]
	=Thisform.poDataMgr.SqlExecute(lcQuery,'crSigOpTdz')
	Select * From crSigOpTdz Where (IsEmpty(DtTerms) Or DtTerms >= crSigMvCab.DataS) Into Cursor csSigOpTdz
	Select csSigOpTdz
		lcQuery = [Select a.*,b.Padraos From SigOpTdz a, SigOpTde b Where a.Codigos = b.CodtabDs And b.Emps = ']+crSigMvCab.Emps+[' ]
		=Thisform.poDataMgr.SqlExecute(lcQuery,'crSigOpTdz')
		Select * From crSigOpTdz Where (IsEmpty(DtTerms) Or DtTerms >= crSigMvCab.DataS) Into Cursor csSigOpTdz
		Select csSigOpTdz
			=Thisform.poDataMgr.SqlExecute([Select *, 0 as Padraos From SigOpTdz ],'crSigOpTdz')
			Select * From crSigOpTdz Where ( IsEmpty(DtTerms) Or DtTerms >= crSigMvCab.DataS ) Into Cursor csSigOpTdz
	Select csSigOpTdz
	If (crSigCdOpe.TabDescs = 4) And ( IsEmpty( crSigMvCab.Tabds ) Or Not Seek(crSigMvCab.Tabds,'csSigOpTdz','Codigos') )
		Select csSigOpTdz
				Select crSigMvCab
			If (Thisform.poDataMgr.SqlExecute([Select Iclis, Rclis, Cpfs, Senhas From SigCdCli Where Iclis = ']+crSigMvCab.Vends+['], 'CrTmpCli') < 1)
		Thisform.poDataMgr.SqlExecute([Select Deptos From SigCdUsu Where Usuarios = ']+Usuar+['],'LocalUsu')
		lcSql = [Select Iclis From SigCdCli Where CCargs = ']+crSigOpCdd.CargV2s+[' And ]+;
		If Thisform.poDataMgr.SqlExecute(lcSql,'CsGerente') < 1
		Thisform.poDataMgr.SqlExecute([Select Iclis, Rclis From SigCdCli Where Grupos = ']+lcGrupoCad+[' And Codigos <> 'GENÉRICO'],'LocalEestV')
		Select LocalEestV
			Insert Into TprMvCabV (Emps,Dopes,Numes,Grupos,Contas,Rclis,CodSegs) Values ;
	Select crSigMvRbt
	Select  DataS, Emps, Dia, Mes, Colecoes, Desconto As Valor From crSigMvRbt ;
	Select csItnRbt
		lcQuery = [Select Dpros, Cunis, Cunips, Moevs, Cpros, CodCors, Conjunts, CGrus From SigCdPro Where Cpros = '] + lcProd + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdPro') < 1)
		Select crSigCdPro
			lcQuery = [Select TipoEstos From SigCdGrp Where CGrus = '] + crSigCdPro.CGrus + [' ]
			If (Thisform.poDataMgr.SqlExecute(lcQuery,'crTmpGru') < 1)
				Insert Into crSigMvItn (cPros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Unit2s,RatFrts,ValRats,Totas,;
		Select csItnRbt
				If (Thisform.poDataMgr.SqlExecute([Select Cods, DiasEnts From SigCdCor], [LocalCor]) < 1)
				Select Max(b.DiasEnts) As Dias ;
					From crSigMvIts a, LocalCor b ;
				Select LocalDias
				Select crSigMvIts
					lcQuery = [Select b.DiasPrz From SigCdPro a, SigCdprz b where a.cpros = ']+crSigMvIts.cPros+['] +;
					If (Thisform.poDataMgr.SqlExecute(lcQuery, [crPrz]) < 1)
					Select crPrz
	Select crSigMvPar
	lcQuery = [Select * from SigOpFp Where FPags = ']+lcPagto+[']
	If Thisform.poDataMgr.SqlExecute (lcQuery,[LocalFPag]) < 1
	Select LocalFPag
			Insert Into crSigMvPar (Emps, Dopes, Numes, EmpDopNums, DataS, CidChaves, CotFPgs, FPags, MoeFpgs, NOpers, Valos, Vencs, Parcs, Pagos, DtAlts, Nsu, Autoriza) ;
		lnErro1 = Iif(.Update('crSigMvCab'), 1, -1)
		lnErro1 = Iif(.Update('crSigMvItn'), 1, -1)
		lnErro1 = Iif(.Update('crSigMvIts'), 1, -1)
		lnErro1 = Iif(.Update('crSigMvPar'), 1, -1)
		lnErro1 = Iif(.Update('crSigMvCCr'), 1, -1)
		lnErro1 = Iif(.Update('crSigMvHst'), 1, -1)
		lnErro1 = Iif(.Update('CrSigOpCoc'), 1, -1)
		lnErro1 = Iif(.Update('crSigChe'), 1, -1)
		lnErro1 = Iif(.Update('crSigChLcq'), 1, -1)
		lnErro1 = Iif(.Update('crSigCqChm'), 1, -1)
		lnErro1 = Iif(.Update('crSigOpRbt'), 1, -1)
Select(lnOldSel)
Select crSigCdPaC
			Insert Into crSigTtCcd (EmpdopNums, EmpDopNcs, CidChaves, ObsD ) Values ;
	Select crSigMvCab
				lcSql = [Select * From SigCdSrv Where ctipos = ]+Iif(crSigCdOpe.Opers=1,['E'],['S'])+[ And CodServs = ']+crSigMvNfi.CodServs+[']
				ThisForm.poDataMgr.Sqlexecute(lcSql,'cServEest')
	Insert Into &_ArqMccr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
	Select ( _ArqMccr )
		Select crSigMvCcr
		Insert Into crSigMvCcr From memvar
	Insert Into &_ArqMccr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
	Select ( _ArqMccr )
	Select crSigMvPar
		Select crSigCdCmm
				Insert Into &_ArqMccr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
				Select ( _ArqMccr )
			lcSql = [Select * From SigCdSrv Where ctipos = ]+Iif(crSigCdOpe.Opers=1,['E'],['S'])+[ And CodServs = ']+crSigMvNfi.CodServs+[']
			ThisForm.poDataMgr.Sqlexecute(lcSql,'cServEest')
				lcSql = [Select * From ScoOcr Where Codigos = ']+_lcOcorSv+[']
				ThisForm.poDataMgr.Sqlexecute(lcSql,'CrScoOcr')
				Select CrScoOcr
				Insert Into crSigOpCoc (Emps,Dopcs,Dataos,Notitulos,Moedas,Cotacaos, EmpDopNcs,CidChaves,Nopers,Valors,Opers,;
					Insert Into &_ArqMccr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
					Select ( _ArqMccr )
						Insert Into &_ArqMccr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
						Select ( _ArqMccr )
	Select crSigMvCab
	Insert Into crSigMvCcr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
	Select crSigMvPar
	lcSql = [Select * From SIGOPOCO Where Grupos = ']+crSigOpFp.GrupoTs+[' And Contas = ']+crSigOpFp.ContaTs+[' ]+;
	ThisForm.poDataMgr.Sqlexecute(lcSql,'CrSIGOPOCO')
	Select CrSIGOPOCO
	Insert Into crSigOpCoc (Emps,Dopcs,Dataos,Notitulos,Moedas,Cotacaos, EmpDopNcs,CidChaves,Nopers,Valors,Opers,;
		Insert Into &_ArqMccr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
		Select ( _ArqMccr )
Select (lcArqMccr)
Insert Into (lcArqMccr) ( VOpers, NOpers, NLancs, VLancs, Opers, Grupos,;
lcSql = [Select * From SigCdGcr ]
ThisForm.poDataMgr.Sqlexecute(lcsql,'crSigCdGcr')
Select crSigCdGcr
lcSql = [Select * From SigCdPac ]
ThisForm.poDataMgr.Sqlexecute(lcsql,'crSigCdPac')
lcSql = [Select * From SigCdPam ]
ThisForm.poDataMgr.Sqlexecute(lcsql,'crSigCdPam')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoprbt.prg) - TRECHOS RELEVANTES PARA PASS SQL (985 linhas total):

*-- Linhas 71 a 89:
71: *     controle de ENTRADA (textbox / editbox / combobox /
72: *     listbox / checkbox / optiongroup / optionbutton /
73: *     spinner) ............................................ 0 ocorrencias
74: *     pColuna / RecordSource / ControlSource .............. 0 ocorrencias
75: *     .AddCursor(...) .................................... 15 ocorrencias
76: *         todas com 3 argumentos (tabela, chave, cursor): registram o cursor
77: *         no data manager e NAO ligam grade nenhuma - o argumento que no
78: *         padrao Fortyus aponta o objeto da grade (o 5o) nao aparece em
79: *         nenhuma delas
80: *     BaseClass: commandgroup ............................. 1 (ButtonCount = 2)
81: *
82: * A arvore inteira do dump sao 6 objetos: Dataenvironment, a Form, cntSombra,
83: * os 2 labels da faixa e cntBotoes. Inventar grade ou tela de cadastro aqui
84: * violaria o PILAR 1 e a regra "NUNCA inventar"; escrever metodo de pagina ou
85: * de alternancia sem conteudo, so para casar com o roteiro, seria o stub que a
86: * regra de completude proibe. O que este legado TEM eh o grupo de 2 botoes - e
87: * eh ele que esta fase entrega:
88: *
89: *   - ConfigurarBotoes() - cmg_4c_Acoes (CommandGroup) com os 2 botoes do

*-- Linhas 124 a 142:
124: *
125: *     BaseClass: textbox / editbox / combobox / listbox / checkbox /
126: *     optiongroup / optionbutton / spinner ................. 0 ocorrencias
127: *     ControlSource .......................................... 0 ocorrencias
128: *     PROCEDURE Valid / PROCEDURE When ....................... 0 ocorrencias
129: *     fwbusca* / mAddColuna / sigacess( ...................... 0 ocorrencias
130: *
131: * As 15 chamadas .AddCursor do Init legado NAO sao superficie de lista: todas
132: * tem 3 argumentos (tabela, campo-chave, cursor), forma que apenas REGISTRA o
133: * cursor no data manager. Quem liga GRADE eh o 5o argumento (regra #35), e
134: * medido no dump ele nao aparece em nenhuma das 15 - .AddCursor com 4+ virgulas
135: * da 0 ocorrencias, coerente com os 0 grid/pageframe do censo de BaseClass. Os
136: * cursores existem para o motor de integracao (GeraMovimentacao e companhia),
137: * que le e grava por SQL, sem controle de tela no caminho.
138: *
139: * Os unicos PROCEDURE do dump sao geramovimentacao, processamento,
140: * lancacontacorrente, fazcontra, montahists, Init, Load, Release,
141: * btnSair.Click e btnConfirmar.Click - nenhum deles le ou grava um controle
142: * de tela. Acrescentar TextBox/campo ou lookup aqui seria inventar estrutura

*-- Linhas 207 a 248:
207: * pagina Lista, HabilitarCampos/LimparCampos/AjustarBotoesPorModo dependem dos
208: * modos INCLUIR/ALTERAR/VISUALIZAR, e os tres Btn* sao botoes da barra CRUD.
209: * Medido no dump (contagem repetida nas Fases 4, 5 e 6): ZERO grid, ZERO
210: * pageframe, ZERO controle de entrada, ZERO ControlSource, ZERO pcEscolha e
211: * ZERO objeto cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir. Escreve-los aqui
212: * exigiria INVENTAR campos, grade, modos e botoes que o legado nao tem (viola
213: * o PILAR 1 e a regra "NUNCA inventar") ou criar nove metodos vazios (proibido
214: * pela regra de completude). O gate da fase reconhece este perfil - ver a nota
215: * sobre o ramo DESPACHANTE abaixo.
216: *
217: * O QUE ESTA FASE ENTREGA DE FATO
218: *   - sigoprbtBO: o motor de integracao completo (GerarMovimentacao e os 25
219: *     metodos de apoio), incluindo a gravacao ATOMICA em SigMvCab/SigMvItn/
220: *     SigMvPar/SigMvCcr/SigOpCoc/SigOpRbt com SQLCOMMIT/SQLROLLBACK unico
221: *   - MontarResumoLote() - o resumo que acompanha o "Integracao Realizada."
222: *     (o lote nao tem grade nenhuma; sem resumo o usuario nao distingue
223: *     "integrou 3 dias" de "todos os dias ja estavam integrados")
224: *   - Destroy() - libera os cursores do lote ANTES do DODEFAULT(), que eh quem
225: *     solta a referencia do BO
226: *
227: * fChkFeriado - RESOLVIDO SEM WRAPPER GLOBAL
228: * A Fase 7 anotou que o calculo de prazo de entrega em dias uteis dependia da
229: * funcao global fChkFeriado, ausente de projeto\app\utils\. O padrao do projeto
230: * para esse calculo NAO eh um wrapper global: eh o par CarregarFeriados() +
231: * VerificarFeriado() dentro do proprio BO, como em SigPrCfnBO, CCJBO e HORBO.
232: * Eh assim que esta no sigoprbtBO - cache de SigCdFer lido uma vez por lote,
233: * em vez de um SELECT por dia dentro do laco.
234: *
235: * GATE DA FASE 8 - RAMO DESPACHANTE
236: * O gate reconhece este form como DESPACHANTE (legado sem lista, sem campos e
237: * sem CRUD) e dispensa os quatro nomes canonicos, validando em troca a
238: * superficie que o legado de fato tem: o CommandGroup e o handler do Click.
239: * Para chegar a esse ramo o predicado de lista do gate precisou ser estreitado
240: * com Test-LegadoAddCursorLigaGrade - o teste largo conta o TOKEN "AddCursor"
241: * por simples presenca e as 15 chamadas de 3 argumentos deste Init faziam o
242: * form parecer "ter lista" (regra #35: quem liga grade eh o 5o argumento, que
243: * nao aparece em nenhuma delas). Ver OrquestradorMigracao.ps1, case 8.
244: *==============================================================================
245: 
246: DEFINE CLASS Formsigoprbt AS FormBase
247: 
248:     *--------------------------------------------------------------------------

*-- Linhas 703 a 721:
703:     *         Endif
704:     *     Endif
705:     *     Set Step On                                    && NAO transcrito
706:     *     Select crSigCdPaC
707:     *     If IsEmpty(crSigCdPaC.DopRBT)
708:     *         If Not Thisform.Automatico
709:     *             MessageBox([Movimentacao de Rebate nao Informada.],0+48,[Aviso])
710:     *             Return .F.
711:     *         EndIf
712:     *     EndIf
713:     *     =fGravarLog('T', Thisform.Name,[REBATE],[Inicio da Gravacao],Usuar)
714:     *     If Not ThisForm.GeraMovimentacao()
715:     *         Return .F.
716:     *     EndIf
717:     *     If Not Thisform.Automatico
718:     *         MessageBox([Integracao Realizada.],0+64,[Atencao])
719:     *     EndIf
720:     *     =fGravarLog('T', Thisform.Name,[REBATE],[Atualizacao dos Dados da Integracao],Usuar)
721:     *     Return .T.

*-- Linhas 732 a 750:
732:     * 2) "Set Step On" nao entra - eh breakpoint de depuracao esquecido no
733:     *    fonte legado (ver o cabecalho deste arquivo).
734:     *
735:     * 3) O "Select crSigCdPaC" do legado existe porque la a leitura era
736:     *    crSigCdPaC.DopRBT (campo de cursor). Aqui o valor ja esta na property
737:     *    this_cDopRebate, carregada por sigoprbtBO.CarregarParametros a partir
738:     *    da MESMA coluna - nao ha area de trabalho a selecionar.
739:     *
740:     * RETORNO: .T. somente quando o lote FECHOU gravando. Nenhum caminho de
741:     * falha devolve .T. nem exibe "Integracao Realizada." (regras #20 e #21).
742:     *
743:     * O RETURN fica FORA do TRY/CATCH, num ponto unico, com a flag loc_lSucesso
744:     * fazendo o papel dos "Return .F." antecipados do legado (regra #1). Os
745:     * guards de confirmacao e de DopRBT sao avaliados ANTES do TRY, onde o
746:     * RETURN antecipado eh legitimo.
747:     *==========================================================================
748:     PROCEDURE Processamento()
749:         LOCAL loc_lSucesso, loc_lAuto, loc_cDopRebate, loc_oBO, loc_oErro
750: 

