# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA1

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
  ControlSource = "crSigCnFbl.nlnlocals"
  ControlSource = "crSigCnFbl.ncllocals"
  ControlSource = "crSigCnFbl.nlndtvencs"
  ControlSource = ""
  ControlSource = "crSigCnFbl.ncldtvencs"
  ControlSource = "crSigCnFbl.nlndtdocs"
  ControlSource = "crSigCnFbl.ncldtdocs"
  ControlSource = "crSigCnFbl.nlnnrdocs"
  ControlSource = "crSigCnFbl.nclnrdocs"
  ControlSource = "crSigCnFbl.nlnvldocs"
  ControlSource = "crSigCnFbl.nclvldocs"
  ControlSource = "crSigCnFbl.nlntxtcds"
  ControlSource = "crSigCnFbl.ncltxtcds"
  ControlSource = "crSigCnFbl.nlnrazclis"
  ControlSource = "crSigCnFbl.nclrazclis"
  ControlSource = "crSigCnFbl.nlncgcclis"
  ControlSource = "crSigCnFbl.nclcgcclis"
  ControlSource = "crSigCnFbl.nlnendcobs"
  ControlSource = "crSigCnFbl.nclendcobs"
  ControlSource = "crSigCnFbl.nlnbaicobs"
  ControlSource = "crSigCnFbl.nclbaicobs"
  ControlSource = "crSigCnFbl.nlncidcobs"
  ControlSource = "crSigCnFbl.nclcidcobs"
  ControlSource = "crSigCnFbl.nlnestcobs"
  ControlSource = "crSigCnFbl.nclestcobs"
  ControlSource = "crSigCnFbl.nlncepcobs"
  ControlSource = "crSigCnFbl.nclcepcobs"
  ControlSource = "crSigCnFbl.ntxtcols"
  ControlSource = "crSigCnFbl.ntxtlins"
  ControlSource = "crSigCnFbl.cnomeimps"
  ControlSource = "crSigCnFbl.cfontepdrs"
  ControlSource = "crSigCnFbl.ntamfontes"
lcQryCfgBl = [Select * From SigCnFBl]
		Select crSigCnFBl
	Select crSigCnFBl
	Select crSigCnFBL
	If Not ThisForm.poDataMgr.Update('crSigCnFBL')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCnFBL)')
	lcQuery = [Select * ] + ;
			    [From SigCqMat]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigCqMat') < 1)
	Select csSigCqMat
		lcQuery = [Update SigCqMat Set ctamanho=']+m.lcTamFolha+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCbl.prg) - TRECHOS RELEVANTES PARA PASS SQL (2052 linhas total):

*-- Linhas 69 a 87:
69: 
70:                 *-- Guard gb_4c_ValidandoUI/gb_4c_ModoTeste (padrao FormSigOpAlC):
71:                 *-- em validacao de UI ou teste headless nao ha gnConnHandle real,
72:                 *-- e SQLEXEC com handle invalido dispara EXCECAO (nao apenas
73:                 *-- devolve erro) - pular a carga preserva a instanciacao do form
74:                 *-- para o harness inspecionar os controles. Sem conexao, o
75:                 *-- BOParaForm sozinho ja espelha os defaults das properties do
76:                 *-- BO (equivalente ao registro em branco do Append Blank legado).
77:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
78:                         (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
79:                     THIS.CarregarLista()
80:                 ELSE
81:                     THIS.BOParaForm()
82:                 ENDIF
83: 
84:                 THIS.TornarControlesVisiveis(THIS)
85:                 loc_lSucesso = .T.
86:             ELSE
87:                 MsgErro("Erro ao criar SigOpCblBO. VARTYPE retornou: " + ;

*-- Linhas 1392 a 1410:
1392:     *
1393:     *   .AddCursor('SigCnFBl', 'cIdChaves', 'crSigCnFBl', '', '', lcQryCfgBl)
1394:     *   .poDataMgr.ReQuery('crSigCnFBl')
1395:     *   Select crSigCnFBl / Go Top
1396:     *   If Eof() / Append Blank / EndIf
1397:     *   ... ThisForm.Text40.value = <descricao de ctamfolha> ...
1398:     *   ThisForm.Refresh
1399:     *   ThisForm.Text1.SetFocus
1400:     *
1401:     * SigOpCblBO.CarregarRegistroUnico() cobre o AddCursor/ReQuery/Go Top e o
1402:     * "Append Blank" (tabela vazia -> NovoRegistro(), com os defaults das
1403:     * properties, que eh o equivalente do registro em branco do cursor legado);
1404:     * THIS.BOParaForm() cobre o espelhamento dos campos, inclusive o Text40
1405:     * (ExtrairDescricaoTamanhoFolha). PUBLIC de proposito: o harness
1406:     * TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da classe,
1407:     * e PROTECTED falharia em runtime (regra CLAUDE.md #3).
1408:     *--------------------------------------------------------------------------
1409:     PROCEDURE CarregarLista()
1410:         LOCAL loc_lSucesso, loc_oErro

*-- Linhas 1570 a 1588:
1570: 
1571:     *--------------------------------------------------------------------------
1572:     * MontarTamanhoFolhaComFonte - equivalente a logica do cmdOk.Click legado
1573:     * que remonta "m.ctamfolha" antes do Gather/Update:
1574:     *
1575:     *   If Not Empty(crSigCnFBl.ctamfolha)
1576:     *       If At('/',crSigCnFBl.ctamfolha) = 0
1577:     *           lcTamFolha = Fonte+'/'+SubStr(ctamfolha,1,10)+'/'+SubStr(ctamfolha,11)
1578:     *       Else
1579:     *           ... reaproveita Codigo/Descricao ja presentes, troca so a Fonte
1580:     *       EndIf
1581:     *   Else
1582:     *       lcTamFolha = Fonte+'/'
1583:     *   EndIf
1584:     *
1585:     * par_cTamFolhaAtual chega no formato CRU do GetPaperSize() (10 chars de
1586:     * codigo + descricao, sem "/") na 1a configuracao, ou ja remontado
1587:     * ("Fonte/Codigo/Descricao") nas confirmacoes seguintes.
1588:     *--------------------------------------------------------------------------

*-- Linhas 1712 a 1730:
1712:     *       m.lnPos2     = At(",",m.lcFonte,2)
1713:     *       m.nTamFontes = Val(SubStr(m.lcFonte,(m.lnPos1+1),(m.lnPos2-1)))
1714:     *       m.cFontePdrs = Left(m.lcFonte,(m.lnPos1-1))
1715:     *       Select crSigCnFBl
1716:     *       Gather Memvar Fields cFontePdrs,nTamFontes
1717:     *       This.Refresh / ThisForm.Text31.Refresh
1718:     *   EndIf
1719:     *   ThisForm.LockScreen = .f.
1720:     *
1721:     * O "Gather Memvar Fields cFontePdrs,nTamFontes" do legado grava os dois
1722:     * campos no registro corrente; aqui o equivalente eh escrever nos dois
1723:     * controles (Text30/Text31), que o FormParaBO leva ao BO na gravacao.
1724:     *
1725:     * DOIS detalhes medidos no VFP9 em 2026-10-17, ambos defeito no codigo que
1726:     * vinha das fases anteriores:
1727:     *   1. AFONT() devolve LOGICO (.T./.F.), NAO contagem - "IF <logico> > 0"
1728:     *      estoura erro 107 "Operator/operand type mismatch" em RUNTIME. A
1729:     *      contagem vem de ALEN(array, 1), exatamente como o legado faz.
1730:     *   2. AFONT exige destino LOCAL ARRAY (erro 232 com LOCAL simples).

*-- Linhas 1875 a 1894:
1875:     *   ThisForm.LockScreen = .t.
1876:     *   If MessageBox("Confirma a Configuracao do Boleto?",32+4,...)==6
1877:     *       ... remonta m.ctamfolha (Fonte+Codigo+Descricao)
1878:     *       ... Gather dDatas,cHoras,cUsuarios,ctamfolha / Update / Commit
1879:     *       ... Update SigCqMat Set ctamanho=<ctamfolha> (quando ha registro)
1880:     *       ThisForm.Release
1881:     *   Else
1882:     *       ThisForm.Text1.SetFocus
1883:     *   EndIf
1884:     *   ThisForm.LockScreen = .f.
1885:     *
1886:     * THIS.FormParaBO() ja transfere TODOS os campos do boleto
1887:     * (Text1..Text31); this_cTamfolha eh remontado aqui com
1888:     * MontarTamanhoFolhaComFonte (regra CLAUDE.md #17 - formula do legado
1889:     * transcrita literalmente, nunca reescrita) antes de Salvar().
1890:     *
1891:     * Cada falha do legado faz "Return 0" SEM Release - a tela fica aberta com
1892:     * os dados na mao do usuario. Reproduzido aqui: Release() so acontece
1893:     * quando Salvar() E SincronizarTamanhoFolhaSigCqMat() tiverem sucesso.
1894:     *


### BO (C:\4c\projeto\app\classes\SigOpCblBO.prg):
*====================================================================
* SIGOPCBLBO.prg
*
* Business Object para Configuracao de Boletos Bancarios
* Tabela: SigCnFBl (registro unico de configuracao de impressao)
* Herda de: BusinessBase
* Form legado: SIGOPCBL.SCX
*====================================================================

DEFINE CLASS SigOpCblBO AS BusinessBase

	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica)

	*-- Identificacao / auditoria do registro
	this_cEmps       = ""   && cemps char(3) - empresa
	this_dDatas      = {}   && ddatas datetime - data da configuracao
	this_cHoras      = ""   && choras char(8) - hora da configuracao
	this_cUsuarios   = ""   && cusuarios char(20) - usuario que configurou
	this_cFpags      = ""   && fpags char(12) - forma de pagamento

	*-- Texto de responsabilidade do cedente e local de pagamento
	this_cTxtcds     = ""   && ctxtcds text - texto de responsabilidade do cedente
	this_cLocals     = ""   && clocals char(100) - texto do local de pagamento
	this_nNtxtlins   = 0    && ntxtlins numeric(3,0) - numero de linhas do texto do cedente
	this_nNtxtcols   = 0    && ntxtcols numeric(3,0) - numero de colunas do texto do cedente

	*-- Posicao de impressao (linha/coluna) - Local de Pagamento
	this_nNlnlocals  = 0    && nlnlocals numeric(5,2) - linha de impressao do local de pagamento
	this_nNcllocals  = 0    && ncllocals numeric(5,2) - coluna de impressao do local de pagamento

	*-- Posicao de impressao (linha/coluna) - Vencimento
	this_nNlndtvencs = 0    && nlndtvencs numeric(5,2) - linha de impressao do vencimento
	this_nNcldtvencs = 0    && ncldtvencs numeric(5,2) - coluna de impressao do vencimento

	*-- Posicao de impressao (linha/coluna) - Data do Documento
	this_nNlndtdocs  = 0    && nlndtdocs numeric(5,2) - linha de impressao da data do documento
	this_nNcldtdocs  = 0    && ncldtdocs numeric(5,2) - coluna de impressao da data do documento

	*-- Posicao de impressao (linha/coluna) - Numero do Documento
	this_nNlnnrdocs  = 0    && nlnnrdocs numeric(5,2) - linha de impressao do numero do documento
	this_nNclnrdocs  = 0    && nclnrdocs numeric(5,2) - coluna de impressao do numero do documento

	*-- Posicao de impressao (linha/coluna) - Valor do Documento
	this_nNlnvldocs  = 0    && nlnvldocs numeric(5,2) - linha de impressao do valor do documento
	this_nNclvldocs  = 0    && nclvldocs numeric(5,2) - coluna de impressao do valor do documento

	*-- Posicao de impressao (linha/coluna) - Texto do Cedente
	this_nNlntxtcds  = 0    && nlntxtcds numeric(5,2) - linha de impressao do texto do cedente
	this_nNcltxtcds  = 0    && ncltxtcds numeric(5,2) - coluna de impressao do texto do cedente

	*-- Posicao de impressao (linha/coluna) - Sacado: Razao Social
	this_nNlnrazclis = 0    && nlnrazclis numeric(5,2) - linha de impressao da razao social
	this_nNclrazclis = 0    && nclrazclis numeric(5,2) - coluna de impressao da razao social

	*-- Posicao de impressao (linha/coluna) - Sacado: C.G.C./C.P.F.
	this_nNlncgcclis = 0    && nlncgcclis numeric(5,2) - linha de impressao do CGC/CPF
	this_nNclcgcclis = 0    && nclcgcclis numeric(5,2) - coluna de impressao do CGC/CPF

	*-- Posicao de impressao (linha/coluna) - Sacado: Endereco
	this_nNlnendcobs = 0    && nlnendcobs numeric(5,2) - linha de impressao do endereco
	this_nNclendcobs = 0    && nclendcobs numeric(5,2) - coluna de impressao do endereco

	*-- Posicao de impressao (linha/coluna) - Sacado: Bairro
	this_nNlnbaicobs = 0    && nlnbaicobs numeric(5,2) - linha de impressao do bairro
	this_nNclbaicobs = 0    && nclbaicobs numeric(5,2) - coluna de impressao do bairro

	*-- Posicao de impressao (linha/coluna) - Sacado: Cidade
	this_nNlncidcobs = 0    && nlncidcobs numeric(5,2) - linha de impressao da cidade
	this_nNclcidcobs = 0    && nclcidcobs numeric(5,2) - coluna de impressao da cidade

	*-- Posicao de impressao (linha/coluna) - Sacado: U.F.
	this_nNlnestcobs = 0    && nlnestcobs numeric(5,2) - linha de impressao da UF
	this_nNclestcobs = 0    && nclestcobs numeric(5,2) - coluna de impressao da UF

	*-- Posicao de impressao (linha/coluna) - Sacado: C.E.P.
	this_nNlncepcobs = 0    && nlncepcobs numeric(5,2) - linha de impressao do CEP
	this_nNclcepcobs = 0    && nclcepcobs numeric(5,2) - coluna de impressao do CEP

	*-- Impressora / Fonte padrao
	this_cNomeimps   = ""   && cnomeimps char(128) - nome da impressora padrao
	this_cFontepdrs  = ""   && cfontepdrs char(128) - fonte padrao de impressao
	this_nTamfontes  = 0    && ntamfontes numeric(3,0) - tamanho da fonte padrao

	*-- Tamanho da folha (driver/codigo/descricao concatenados)
	this_cTamfolha   = ""   && ctamfolha char(50) - tamanho de folha configurado na impressora

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCnFBl"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves eh a PK real de SigCnFBl (constraint
	* sigcnfbl_cidchaves em docs\schema.sql), usada pelo RegistrarAuditoria
	* herdado da BusinessBase.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
	ENDPROC

	*====================================================================
	* CarregarRegistroUnico - Replica o Init legado: "Select * From SigCnFBl"
	* + "Go Top" + "If Eof() / Append Blank / EndIf". SigCnFBl eh tabela de
	* configuracao UNICA (um boleto por empresa) - se ja existe o registro,
	* carrega e entra em modo EDICAO; se a tabela estiver vazia (1a execucao
	* no ambiente), entra em modo INCLUSAO com os defaults da classe (equivalente
	* ao Append Blank do legado, que cria a linha em branco no cursor).
	*====================================================================
	PROCEDURE CarregarRegistroUnico()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT * FROM SigCnFBl"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Dados") > 0
					SELECT cursor_4c_Dados
					GO TOP
					THIS.CarregarDoCursor("cursor_4c_Dados")
					THIS.EditarRegistro()
				ELSE
					THIS.NovoRegistro()
				ENDIF
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao carregar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia as 40 colunas de SigCnFBl (par_cAliasCursor)
	* para as properties do BO.
	*
	* Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
	* [[feedback_tratarnulo_2o_arg_eh_valor_padrao]]: o 2o argumento de
	* TratarNulo() eh o VALOR PADRAO do tipo da coluna, nunca um codigo de
	* tipo - "" para char, 0 para numeric, {} para date/datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
				THIS.this_cEmps       = TratarNulo(cemps, "")
				THIS.this_dDatas      = TratarNulo(ddatas, {})
				THIS.this_cHoras      = TratarNulo(choras, "")
				THIS.this_cUsuarios   = TratarNulo(cusuarios, "")
				THIS.this_cFpags      = TratarNulo(fpags, "")

				THIS.this_cTxtcds     = TratarNulo(ctxtcds, "")
				THIS.this_cLocals     = TratarNulo(clocals, "")
				THIS.this_nNtxtlins   = TratarNulo(ntxtlins, 0)
				THIS.this_nNtxtcols   = TratarNulo(ntxtcols, 0)

				THIS.this_nNlnlocals  = TratarNulo(nlnlocals, 0)
				THIS.this_nNcllocals  = TratarNulo(ncllocals, 0)

				THIS.this_nNlndtvencs = TratarNulo(nlndtvencs, 0)
				THIS.this_nNcldtvencs = TratarNulo(ncldtvencs, 0)

				THIS.this_nNlndtdocs  = TratarNulo(nlndtdocs, 0)
				THIS.this_nNcldtdocs  = TratarNulo(ncldtdocs, 0)

				THIS.this_nNlnnrdocs  = TratarNulo(nlnnrdocs, 0)
				THIS.this_nNclnrdocs  = TratarNulo(nclnrdocs, 0)

				THIS.this_nNlnvldocs  = TratarNulo(nlnvldocs, 0)
				THIS.this_nNclvldocs  = TratarNulo(nclvldocs, 0)

				THIS.this_nNlntxtcds  = TratarNulo(nlntxtcds, 0)
				THIS.this_nNcltxtcds  = TratarNulo(ncltxtcds, 0)

				THIS.this_nNlnrazclis = TratarNulo(nlnrazclis, 0)
				THIS.this_nNclrazclis = TratarNulo(nclrazclis, 0)

				THIS.this_nNlncgcclis = TratarNulo(nlncgcclis, 0)
				THIS.this_nNclcgcclis = TratarNulo(nclcgcclis, 0)

				THIS.this_nNlnendcobs = TratarNulo(nlnendcobs, 0)
				THIS.this_nNclendcobs = TratarNulo(nclendcobs, 0)

				THIS.this_nNlnbaicobs = TratarNulo(nlnbaicobs, 0)
				THIS.this_nNclbaicobs = TratarNulo(nclbaicobs, 0)

				THIS.this_nNlncidcobs = TratarNulo(nlncidcobs, 0)
				THIS.this_nNclcidcobs = TratarNulo(nclcidcobs, 0)

				THIS.this_nNlnestcobs = TratarNulo(nlnestcobs, 0)
				THIS.this_nNclestcobs = TratarNulo(nclestcobs, 0)

				THIS.this_nNlncepcobs = TratarNulo(nlncepcobs, 0)
				THIS.this_nNclcepcobs = TratarNulo(nclcepcobs, 0)

				THIS.this_cNomeimps   = TratarNulo(cnomeimps, "")
				THIS.this_cFontepdrs  = TratarNulo(cfontepdrs, "")
				THIS.this_nTamfontes  = TratarNulo(ntamfontes, 0)

				THIS.this_cTamfolha   = TratarNulo(ctamfolha, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - grava a configuracao de boletos quando ainda nao existe
	* nenhum registro em SigCnFBl (tabela de configuracao unica - Init do
	* legado faz Append Blank so quando a tabela esta vazia).
	*
	* Regra CLAUDE.md #22 - cidchaves (PK Fortyus) nunca vai em branco,
	* senao um segundo registro colidiria no indice unico; gerar com
	* fUniqueIds() quando a property ainda nao tem valor.
	*
	* Os campos de auditoria (Datas/Horas/Usuarios) sao preenchidos aqui
	* na gravacao, igual ao legado (cmdOk.Click: m.dDatas = Date(),
	* m.cHoras = Time(), m.cUsuarios = m.Usuar).
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .F.

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			THIS.this_dDatas = DATE()
			THIS.this_cHoras = TIME()
			IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuarios, ""))) AND TYPE("gc_4c_UsuarioLogado") = "C"
				THIS.this_cUsuarios = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCnFBl (" + ;
				"cidchaves, cemps, ddatas, choras, cusuarios, fpags, " + ;
				"ctxtcds, clocals, ntxtlins, ntxtcols, " + ;
				"nlnlocals, ncllocals, nlndtvencs, ncldtvencs, " + ;
				"nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs, " + ;
				"nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, " + ;
				"nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis, " + ;
				"nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs, " + ;
				"nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs, " + ;
				"nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs, " + ;
				"ntamfontes, ctamfolha) VALUES (" + ;
				EscaparSQL(THIS.this_cCidchaves) + ", " + EscaparSQL(THIS.this_cEmps) + ", " + ;
				FormatarDataSQL(THIS.this_dDatas) + ", " + EscaparSQL(THIS.this_cHoras) + ", " + ;
				EscaparSQL(THIS.this_cUsuarios) + ", " + EscaparSQL(THIS.this_cFpags) + ", "

			loc_cSQL = loc_cSQL + ;
				EscaparSQL(THIS.this_cTxtcds) + ", " + EscaparSQL(THIS.this_cLocals) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNtxtlins, 0) + ", " + FormatarNumeroSQL(THIS.this_nNtxtcols, 0) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnlocals, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcllocals, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlndtvencs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcldtvencs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlndtdocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcldtdocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnnrdocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclnrdocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnvldocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclvldocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlntxtcds, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcltxtcds, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlnrazclis, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclrazclis, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlncgcclis, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcgcclis, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnendcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclendcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnbaicobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclbaicobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlncidcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcidcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnestcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclestcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlncepcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcepcobs, 2) + ", " + ;
				EscaparSQL(THIS.this_cNomeimps) + ", " + EscaparSQL(THIS.this_cFontepdrs) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nTamfontes, 0) + ", " + EscaparSQL(THIS.this_cTamfolha) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao gravar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
				THIS.this_lErroExibido = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
			THIS.this_lErroExibido = .T.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - grava alteracoes na configuracao de boletos ja existente
	* (caminho normal: SigCnFBl tem sempre um unico registro, confirmado
	* pelo Init legado que aparece apos o primeiro Confirmar).
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .F.

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.

		TRY
			THIS.this_dDatas = DATE()
			THIS.this_cHoras = TIME()
			IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuarios, ""))) AND TYPE("gc_4c_UsuarioLogado") = "C"
				THIS.this_cUsuarios = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)
			ENDIF

			loc_cSQL = "UPDATE SigCnFBl SET " + ;
				"cemps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
				"ddatas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
				"choras = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
				"cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + ", " + ;
				"fpags = " + EscaparSQL(THIS.this_cFpags) + ", "

			loc_cSQL = loc_cSQL + ;
				"ctxtcds = " + EscaparSQL(THIS.this_cTxtcds) + ", " + ;
				"clocals = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
				"ntxtlins = " + FormatarNumeroSQL(THIS.this_nNtxtlins, 0) + ", " + ;
				"ntxtcols = " + FormatarNumeroSQL(THIS.this_nNtxtcols, 0) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnlocals, 2) + ", " + ;
				"ncllocals = " + FormatarNumeroSQL(THIS.this_nNcllocals, 2) + ", " + ;
				"nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlndtvencs, 2) + ", " + ;
				"ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNcldtvencs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlndtdocs, 2) + ", " + ;
				"ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNcldtdocs, 2) + ", " + ;
				"nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnnrdocs, 2) + ", " + ;
				"nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclnrdocs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnvldocs, 2) + ", " + ;
				"nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclvldocs, 2) + ", " + ;
				"nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlntxtcds, 2) + ", " + ;
				"ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNcltxtcds, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnrazclis, 2) + ", " + ;
				"nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclrazclis, 2) + ", " + ;
				"nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlncgcclis, 2) + ", " + ;
				"nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclcgcclis, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnendcobs, 2) + ", " + ;
				"nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclendcobs, 2) + ", " + ;
				"nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnbaicobs, 2) + ", " + ;
				"nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclbaicobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlncidcobs, 2) + ", " + ;
				"nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclcidcobs, 2) + ", " + ;
				"nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnestcobs, 2) + ", " + ;
				"nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclestcobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlncepcobs, 2) + ", " + ;
				"nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclcepcobs, 2) + ", " + ;
				"cnomeimps = " + EscaparSQL(THIS.this_cNomeimps) + ", " + ;
				"cfontepdrs = " + EscaparSQL(THIS.this_cFontepdrs) + ", "

			loc_cSQL = loc_cSQL + ;
				"ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamfontes, 0) + ", " + ;
				"ctamfolha = " + EscaparSQL(THIS.this_cTamfolha) + ;
				" WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao atualizar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
				THIS.this_lErroExibido = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
			THIS.this_lErroExibido = .T.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SincronizarTamanhoFolhaSigCqMat - replica o update de SigCqMat feito
	* dentro do cmdOk.Click legado, APOS o Update de crSigCnFBL:
	*
	*   lcQuery = [Select * ] + [From SigCqMat]
	*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigCqMat') < 1)
	*       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
	*       Return 0
	*   EndIf
	*   If (Not Eof('csSigCqMat') And Not IsEmpty(m.lcTamFolha))
	*       lcQuery = [Update SigCqMat Set ctamanho=']+m.lcTamFolha+[']
	*       ... SqlExecute ...
	*   EndIf
	*
	* SigCqMat eh tabela de OUTRO modulo (controle de qualidade) - nao faz
	* parte do schema de SigCnFBl, mas o legado sincroniza o tamanho de
	* folha configurado aqui com o registro de la, quando ele existe.
	*====================================================================
	PROCEDURE SincronizarTamanhoFolhaSigCqMat(par_cTamFolha)
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .T.

		TRY
			IF USED("cursor_4c_SigCqMat")
				USE IN cursor_4c_SigCqMat
			ENDIF

			loc_cSQL = "SELECT * FROM SigCqMat"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCqMat")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_SigCqMat") > 0 AND !EMPTY(par_cTamFolha)
					loc_cSQL = "UPDATE SigCqMat SET ctamanho = " + EscaparSQL(par_cTamFolha)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

					IF loc_nResultado < 0
						MostrarErro("Favor Reinicializar o Processo!!!", ;
							"Falha na Conex" + CHR(227) + "o (SigCqMat)")
						loc_lSucesso = .F.
					ENDIF
				ENDIF
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!", ;
					"Falha na Conex" + CHR(227) + "o (SigCqMat)")
				loc_lSucesso = .F.
			ENDIF

			IF USED("cursor_4c_SigCqMat")
				USE IN cursor_4c_SigCqMat
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

