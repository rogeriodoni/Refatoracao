*==============================================================================
* sigopdenBO.prg
*
* Business Object para o formulario OPERACIONAL Formsigopden
* Origem legado: SIGOPDEN.SCX (Dados de Entrega)
*
* FINALIDADE
*   Visualizador dos dados de entrega de um movimento (Empresa + Operacao +
*   Numero). Monta o cabecalho (dados da empresa emitente, do fornecedor, do
*   local de entrega, do comprador, do parceiro, condicoes comerciais e termos)
*   e a relacao de itens, paginada para o documento.
*
* TABELAS DE ORIGEM (somente LEITURA - o legado nao grava nada nesta tela)
*   SigMvCab  - cabecalho do movimento (chave EmpDopNums)
*   SigMvItn  - itens do movimento
*   SigMvIts  - subitens / embalagens do movimento
*   SigMvNfi  - dados fiscais (ICMS e frete)
*   SigMvPar  - parcelas / formas de pagamento
*   SigCdOpe  - cadastro da operacao (Opers, NDopes, Docus)
*   SigOpCdc  - configuracao do documento da operacao (titulos e flags Dck*)
*   SigCdEmp  - empresa emitente (RazSocs, Cgcs, Ies, Tel1s, Tel2s)
*   SigCdCli  - contas (fornecedor, entrega, comprador, parceiro)
*   SigCdPro  - produtos (referencia do fornecedor)
*   SigCdPam  - parametros do sistema (Logos)
*
* NOTA DE PROJETO
*   Esta tela eh exclusivamente de CONSULTA/IMPRESSAO. O comportamento padrao
*   herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao ja eh o
*   correto, por isso essas rotinas nao sao redefinidas aqui.
*
* NOTA SOBRE ACENTOS
*   Conforme regra do projeto, nenhum caractere acentuado literal eh usado
*   neste arquivo. Textos exibidos ao usuario usam CHR().
*
* NOTA SOBRE ENDERECO DE ENTREGA (SigMvCab.LocalEnts)
*   O legado (funcao global fEndEntrega) resolve o endereco de entrega
*   alternativo em SigCdCee (codigos numeric(10,0), iclis, descrs, endes,
*   nums, compls, bairs, cidas, estas, ddds, tel1s, tel2s, contatos),
*   filtrando por IClis = ContaEs AND Codigos = LocalEnts. Essa tabela
*   ja esta portada (ver EndBO.prg), mas sem metodo de busca por chave -
*   a consulta eh feita aqui mesmo (THIS.ResolverEnderecoEntrega), para
*   nao duplicar a definicao da tabela/colunas em dois lugares.
*
* FASE 1/8 - Propriedades, Init e carga/processamento (CarregarDadosEntrega)
* FASE 2/8 - Chave primaria posicional (MontarChaveEmpDopNums /
*            ObterChavePrimaria), CarregarPorCodigo e a leitura dos cursores
*            para as propriedades (CarregarDoCursor ->
*            CarregarCabecalhoDoCursor / CarregarItemDoCursor)
*==============================================================================

DEFINE CLASS sigopdenBO AS BusinessBase

	*==========================================================================
	* PARAMETROS DE ENTRADA (chave do movimento)
	* Legado: ThisForm.pcEmps / pcDopes / pcNumes recebidos no Init(pEmp,pDop,pNum)
	*==========================================================================
	this_cEmps              = ""    && SigMvCab.Emps      char(3)      - Empresa
	this_cDopes             = ""    && SigMvCab.Dopes     char(20)     - Operacao
	this_nNumes             = 0     && SigMvCab.Numes     numeric(6,0) - Numero do movimento
	this_cEmpDopNums        = ""    && SigMvCab.EmpDopNums char(29)    - Chave posicional montada

	*==========================================================================
	* CURSORES DE SAIDA
	* Os NOMES dos cursores e das colunas sao contrato do relatorio (FRX) e do
	* grid: crCabecalho/crDados no legado viram cursor_4c_* nesta arquitetura.
	*==========================================================================
	this_cCursorCabecalho   = "cursor_4c_Cabecalho"   && 1 linha  - dados do documento
	this_cCursorDados       = "cursor_4c_Dados"       && N linhas - itens paginados

	*==========================================================================
	* CONTROLE DE PROCESSAMENTO / IMPRESSAO
	* Legado: ThisForm.TpImpressao / Contaemail / ImgLogotipo / ImgTecnicas / ImgBranco
	*==========================================================================
	this_nTpImpressao       = 0     && 0 = nenhuma impressao selecionada
	this_cContaEmail        = ""    && e-mails das contas de origem e destino (SigCdCli.Emails)
	this_cImgLogotipo       = ""    && arquivo .jpg temporario do logotipo (SigCdPam.Logos)
	this_cImgTecnicas       = ""    && arquivo .jpg temporario da imagem tecnica (SigOpCdc.ImgTecs)
	this_cImgBranco         = ""    && arquivo .jpg em branco usado como fallback
	this_nMaxProdutos       = 0     && itens por pagina: 7/14 (Docus=3) ou 3 (Docus=4)
	this_nTotalPaginas      = 0     && total de paginas geradas em cursor_4c_Dados

	*==========================================================================
	* SigCdOpe - cadastro da operacao
	*==========================================================================
	this_nOpers             = 0     && Opers  numeric(1,0) - 1=Entrada; 2=Saida; 3=Ambas
	this_nNDopes            = 0     && NDopes numeric(4,0) - numero da operacao
	this_nDocus             = 0     && Docus  numeric(2,0) - 3=Doc.Fixo; 4=Fixo c/Imagem

	*==========================================================================
	* SigOpCdc - configuracao do documento (flags Dck* e titulos Doc*)
	* Flags Dck*: 1=Sim; 2=Nao (exceto DckIcmIpi: 1=Nenhum;2=ICMS;3=IPI;4=Ambos)
	*==========================================================================
	this_cDocOrig           = ""    && DocOrig    char(12) - label de fornecedor em ENTRADA
	this_cDocDest           = ""    && DocDest    char(12) - label de fornecedor em SAIDA
	this_cDocVendCfg        = ""    && DocVend    char(12) - label do responsavel/comprador
	this_cDocDesco          = ""    && DocDesco   char(12) - label de desconto
	this_cDocAcres          = ""    && DocAcres   char(12) - label de acrescimo
	this_nDckBarra          = 0     && DckBarra   numeric(1,0) - imprime codigo de barras
	this_nDckTermos         = 0     && DckTermos  numeric(1,0) - imprime termos
	this_nViaTermos         = 0     && ViaTermos  numeric(2,0) - numero de vias do termo
	this_cTxtPrzEnts        = ""    && TxtPrzEnts text     - texto do prazo de entrega
	this_nChkPrzEnts        = 0     && ChkPrzEnts numeric(1,0) - imprime o texto do prazo
	this_cImgTecs           = ""    && ImgTecs    text     - imagem tecnica do documento

	*==========================================================================
	* SigMvCab - contas e valores do movimento usados no processamento
	*==========================================================================
	this_cContaOs           = ""    && ContaOs    char(10) - conta de origem (fornecedor)
	this_cContaDs           = ""    && ContaDs    char(10) - conta de destino
	this_cContaEs           = ""    && ContaEs    char(10) - conta de entrega
	this_nLocalEnts         = 0     && LocalEnts  numeric(10,0) - codigo do endereco alternativo (SigCdCee.Codigos)
	this_nValVars           = 0     && ValVars    numeric(16,2) - positivo=encargo; negativo=desconto

	*==========================================================================
	* CABECALHO DO DOCUMENTO - EMPRESA EMITENTE
	* Cursor crCabecalho: Dopes/Numes/Datas/RazSocs/Cgcs/Ies/Telefone
	* OBS: a coluna Dopes do cursor legado recebe SigOpCdc.DocTit (titulo do
	*      documento), nao o codigo da operacao - por isso a property se chama
	*      this_cDocTit, fiel a coluna de origem no banco.
	*==========================================================================
	this_cDocTit            = ""    && SigOpCdc.DocTit   char(20)     - titulo do documento
	this_dDatas             = {}    && SigMvCab.Datas    datetime     - data do movimento
	this_cRazSocs           = ""    && SigCdEmp.RazSocs  char(50)     - razao social da empresa
	this_cCgcs              = ""    && SigCdEmp.Cgcs     char(20)     - CNPJ da empresa
	this_cIes               = ""    && SigCdEmp.Ies      char(15)     - inscricao estadual
	this_cTelefone          = ""    && Tel1s [/ Tel2s] concatenados   - telefone da empresa
	this_cObses             = ""    && SigMvCab.Obses    text         - observacao do rodape
	this_cBarras            = ""    && codigo de barras 2de5 do cabecalho (14 chars)
	this_lImpCabBar         = .F.   && imprime o codigo de barras do cabecalho (DckBarra = 1)
	this_nPagina            = 0     && pagina corrente do cabecalho
	this_nTotPag            = 0     && total de paginas impressas no documento

	*==========================================================================
	* CABECALHO - TITULOS CALCULADOS DOS LABELS
	* Montados no processamento a partir dos Doc* de SigOpCdc, com os defaults
	* do legado quando a configuracao vem em branco.
	*==========================================================================
	this_cTitFornec         = ""    && "Fornecedor" ou DocOrig/DocDest
	this_cDocPrzE           = ""    && "Data de Entrega" ou DocPrzE
	this_cDocReffs          = ""    && "Ref. Fornecedor" ou DocReffs
	this_cTitVend           = ""    && "Comprador" ou DocVend
	this_cDocPag            = ""    && "Comerciais" ou DocPag
	this_cDocEntregs        = ""    && "de Entrega" ou DocEntregs
	this_cDocFretes         = ""    && label de frete (SigOpCdc.DocFretes)
	this_cTipoVars          = ""    && "Encargos Financeiros" ou "Desconto Concedido"

	*==========================================================================
	* CABECALHO - FLAGS DE IMPRESSAO COPIADAS PARA O CURSOR
	*==========================================================================
	this_nDckPrzE           = 0     && imprime prazo de entrega
	this_nDckReffs          = 0     && imprime referencia do fornecedor
	this_nDckVend           = 0     && imprime responsavel/comprador
	this_nDckTVend          = 0     && imprime dados de contato do responsavel
	this_nDckFretes         = 0     && imprime frete
	this_nDckIcmIpi         = 0     && 1=Nenhum; 2=ICMS; 3=IPI; 4=Ambos
	this_nDckEntregs        = 0     && imprime dados de entrega
	this_nDckObsI           = 0     && imprime observacao dos itens

	*==========================================================================
	* CABECALHO - COMPRADOR (SigMvCab.GrVends/Vends + SigCdCli)
	*==========================================================================
	this_cGrVends           = ""    && SigMvCab.GrVends  char(10) - grupo do comprador
	this_cVends             = ""    && SigMvCab.Vends    char(10) - conta do comprador
	this_cDVends            = ""    && SigCdCli.Razaos ou RClis   - nome do comprador
	this_cDddVends          = ""    && SigCdCli.Ddds     char(4)
	this_cTel1sVends        = ""    && SigCdCli.Tel1s    char(20)
	this_cTel2sVends        = ""    && SigCdCli.Tel2s    char(20)
	this_ceMailVends        = ""    && SigCdCli.eMails   char(50)
	this_cBarVends          = ""    && codigo de barras 2de5 do comprador (14 chars)

	*==========================================================================
	* CABECALHO - PARCEIRO / RESPONSAVEL (SigMvCab.GrResps/Resps + SigCdCli)
	*==========================================================================
	this_cGrResps           = ""    && SigMvCab.GrResps  char(10) - grupo do parceiro
	this_cResps             = ""    && SigMvCab.Resps    char(10) - conta do parceiro
	this_cDResps            = ""    && SigCdCli.Razaos ou RClis   - nome do parceiro

	*==========================================================================
	* CABECALHO - FORNECEDOR (SigCdCli da conta de origem ou destino)
	* Exibido nos campos get01..get06 da tela.
	*==========================================================================
	this_cForIClis          = ""    && SigCdCli.IClis     char(10)
	this_cForRClis          = ""    && SigCdCli.Razaos ou RClis
	this_cForEndes          = ""    && SigCdCli.Endes     char(60)
	this_cForNums           = ""    && SigCdCli.Nums      char(10)
	this_cForCompls         = ""    && SigCdCli.Compls    char(15)
	this_cForCeps           = ""    && SigCdCli.Ceps      char(9)
	this_cForCidas          = ""    && SigCdCli.Cidas     char(30)
	this_cForBairs          = ""    && SigCdCli.Bairs     char(40)
	this_cForEstas          = ""    && SigCdCli.Estas     char(2)
	this_cForContato        = ""    && SigCdCli.Contato   char(20)
	this_cForDdds           = ""    && SigCdCli.Ddds      char(4)
	this_cForTel1s          = ""    && SigCdCli.Tel1s     char(20)
	this_cForTel2s          = ""    && SigCdCli.Tel2s     char(20)
	this_cForFaxs           = ""    && SigCdCli.Faxs      char(20)
	this_cForeMails         = ""    && SigCdCli.eMails    char(50)
	this_cForCgcs           = ""    && SigCdCli.Cpfs      char(20) - CPF ou CNPJ
	this_cForIes            = ""    && SigCdCli.Rgs       char(15) - RG ou IE
	this_cForIMuns          = ""    && SigCdCli.InscMuns  char(20) - inscricao municipal
	this_nForTpClis         = 0     && SigCdCli.TpClis numeric(1,0) - 1=Pessoa Fisica

	*==========================================================================
	* CABECALHO - LOCAL DE ENTREGA (SigCdCli da conta de entrega / fEndEntrega)
	* Exibido nos campos get07..get12 da tela.
	*==========================================================================
	this_cEntIClis          = ""    && conta de entrega
	this_cEntRClis          = ""    && SigCdCli.Razaos ou RClis
	this_cEntEndes          = ""    && endereco montado (logradouro, numero - complemento)
	this_cEntNums           = ""    && numero do endereco de entrega
	this_cEntCompls         = ""    && complemento do endereco de entrega
	this_cEntCeps           = ""    && CEP de entrega
	this_cEntCidas          = ""    && cidade de entrega
	this_cEntBairs          = ""    && bairro de entrega
	this_cEntEstas          = ""    && UF de entrega
	this_cEntContato        = ""    && contato no local de entrega
	this_cEntDdds           = ""    && DDD do local de entrega
	this_cEntTel1s          = ""    && telefone 1 do local de entrega
	this_cEntTel2s          = ""    && telefone 2 do local de entrega
	this_cEntFaxs           = ""    && fax do local de entrega
	this_cEnteMails         = ""    && e-mail do local de entrega
	this_cEntCgcs           = ""    && CPF ou CNPJ do local de entrega
	this_cEntIes            = ""    && RG ou IE do local de entrega
	this_nEntTpClis         = 0     && TpClis numeric(1,0) - 1=Pessoa Fisica

	*==========================================================================
	* CABECALHO - CONDICOES COMERCIAIS, FRETE E IMPOSTOS
	*==========================================================================
	this_cCondPagto         = ""    && parcelas concatenadas de SigMvPar (Total x FPags - Moeda$ Valor)
	this_cRespFretes        = ""    && valor do frete formatado ou responsabilidade (CIF/FOB)
	this_cFretes            = ""    && descricao do frete do documento
	this_nVlFretes          = 0     && SigMvNfi.VlFretes numeric(16,2)
	this_nIcms              = 0     && SigMvNfi.ValIcms  numeric(16,2)
	this_nVariacao          = 0     && ABS(SigMvCab.ValVars) - encargo ou desconto
	this_dPrazoEnts         = {}    && SigMvCab.PrazoEnts datetime - data de entrega
	this_cObsEntrega        = ""    && texto do prazo de entrega com o "#" substituido pela data

	*==========================================================================
	* CABECALHO - TERMOS E IMAGENS DO DOCUMENTO (SigOpCdc)
	*==========================================================================
	this_cTitTermos         = ""    && TitTermos  text - titulo do termo
	this_cTxtTermos         = ""    && TxtTermos  text - conteudo do termo
	this_cTitTermgs         = ""    && TitTermgs  text - titulo do termo de garantia
	this_cTxtTermgs         = ""    && TxtTermgs  text - conteudo do termo de garantia
	this_cTxtTermBs         = ""    && TxtTermBs  text - termo complementar de garantia

	*==========================================================================
	* ITENS DO DOCUMENTO - linha corrente de cursor_4c_Dados
	* Cursor crDados legado: Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds,
	* Units, Totas, Aliqs, ValIpis, Obs
	*==========================================================================
	this_nItPagina          = 0     && pagina do item no documento
	this_nItCItens          = 0     && SigMvItn.CItens   numeric(4,0) - sequencia do item
	this_cItCPros           = ""    && SigMvItn.CPros    char(14)     - codigo do produto
	this_cItReffs           = ""    && SigCdPro.Reffs    char(40)     - referencia do fornecedor
	this_cItDPros           = ""    && SigMvItn.DPros    char(40)     - descricao do produto
	this_cItCUnis           = ""    && unidade (SigMvItn.CUnis ou SigMvIts.CodEmbs)
	this_nItQtds            = 0     && quantidade  numeric(9,3)
	this_nItUnits           = 0     && valor unitario numeric(15,6)
	this_nItTotas           = 0     && valor total  numeric(11,2)
	this_nItAliqs           = 0     && aliquota de IPI numeric(4,2)
	this_nItValIpis         = 0     && valor do IPI numeric(11,2)
	this_cItObs             = ""    && observacao do item char(40)

	*==========================================================================
	* Init - Inicializa o Business Object
	* A tabela principal eh SigMvCab e a chave eh a composta EmpDopNums,
	* montada por PADR(Emps,3) + PADR(Dopes,20) + STR(Numes,6) = char(29).
	*==========================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = "SigMvCab"
		THIS.this_cCampoChave = "EmpDopNums"

		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - chave posicional do movimento (regra #42: PADR
	* explicito nas partes char, nunca ALLTRIM - o padding faz parte da chave).
	*==========================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		LOCAL loc_cChave

		loc_cChave = THIS.this_cEmpDopNums

		*-- Quando a chave ainda nao foi montada (BO recem-instanciado), remonta
		*-- a partir das partes - pelo MESMO montador de CarregarDadosEntrega,
		*-- para as duas nunca divergirem no padding.
		IF EMPTY(loc_cChave)
			loc_cChave = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)
		ENDIF

		RETURN loc_cChave
	ENDFUNC

	*==========================================================================
	* CarregarDadosEntrega - ponto de entrada do BO (chamado pelo Form.Init)
	* Equivalente ao par Init()/Processamento()/SelecionaDados() do legado:
	* resolve a chave do movimento, carrega os cursores de origem e monta
	* cursor_4c_Cabecalho (1 linha) + cursor_4c_Dados (N linhas paginadas).
	*
	* Parametros: par_cEmps (Empresa), par_cDopes (Operacao), par_nNumes (Numero)
	* Retorno: .T. se montou os dois cursores; .F. com this_cMensagemErro setado
	*==========================================================================
	FUNCTION CarregarDadosEntrega(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_lSucesso, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_cEmps) != "C" OR EMPTY(par_cEmps) OR ;
		   VARTYPE(par_cDopes) != "C" OR EMPTY(par_cDopes) OR ;
		   VARTYPE(par_nNumes) != "N"
			THIS.this_cMensagemErro = "Par" + CHR(226) + "metros inv" + CHR(225) + "lidos para carregar os dados de entrega."
		ELSE
			THIS.this_cEmps       = PADR(par_cEmps, 3)
			THIS.this_cDopes      = PADR(par_cDopes, 20)
			THIS.this_nNumes      = par_nNumes
			THIS.this_cEmpDopNums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)

			TRY
				IF THIS.SelecionarDadosOrigem()
					IF THIS.ProcessarCabecalhoEDados()
						loc_lSucesso = .T.
					ENDIF
				ENDIF
			CATCH TO loc_oErro
				THIS.this_cMensagemErro = "Erro ao carregar dados de entrega: " + loc_oErro.Message + ;
					CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
					CHR(13) + "Procedure: " + loc_oErro.Procedure
				loc_lSucesso = .F.
			ENDTRY
		ENDIF

		THIS.LiberarCursoresAuxiliares()

		RETURN loc_lSucesso
	ENDFUNC

	*==========================================================================
	* SelecionarDadosOrigem - equivalente ao legado SelecionaDados(). Carrega
	* os cursores de origem do movimento. Qualquer tabela "mestre" ausente
	* (operacao/configuracao/parametros/empresa/movimento) aborta o processo -
	* igual ao legado, que fazia "Return .f." em cada "If Eof(...)".
	*==========================================================================
	PROTECTED FUNCTION SelecionarDadosOrigem()
		LOCAL loc_cEdn, loc_nResultado

		loc_cEdn = THIS.this_cEmpDopNums

		*-- SigCdOpe: tipo e numero interno da operacao
		IF USED("LocalOpe")
			USE IN LocalOpe
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Opers, NDopes, Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes), ;
			"LocalOpe")
		IF loc_nResultado < 1 OR !USED("LocalOpe") OR EOF("LocalOpe")
			THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada (SigCdOpe)."
			RETURN .F.
		ENDIF
		THIS.this_nOpers  = LocalOpe.Opers
		THIS.this_nNDopes = LocalOpe.NDopes
		THIS.this_nDocus  = LocalOpe.Docus

		*-- SigOpCdc: configuracao do documento (titulos e flags Dck*)
		IF USED("LocalDcOpe")
			USE IN LocalDcOpe
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT DocTit, DocOrig, DocDest, DckReffs, DocReffs, DckPrzE, DocPrzE, TxtPrzEnts, " + ;
			"ChkPrzEnts, DckVend, DocVend, DocPag, DckTVend, DckBarra, DckFretes, DocFretes, " + ;
			"DckIcmIpi, DocDesco, DocAcres, DckEntregs, DocEntregs, DckObsI, ImgTecs, DckTermos, " + ;
			"TitTermos, TxtTermos, ViaTermos, TitTermgs, TxtTermgs, TxtTermBs " + ;
			"FROM SigOpCdc WHERE Dopes = " + EscaparSQL(THIS.this_cDopes), ;
			"LocalDcOpe")
		IF loc_nResultado < 1 OR !USED("LocalDcOpe") OR EOF("LocalDcOpe")
			THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o do documento n" + CHR(227) + "o encontrada (SigOpCdc)."
			RETURN .F.
		ENDIF
		THIS.this_cDocOrig    = NVL(LocalDcOpe.DocOrig, "")
		THIS.this_cDocDest    = NVL(LocalDcOpe.DocDest, "")
		THIS.this_cDocVendCfg = NVL(LocalDcOpe.DocVend, "")
		THIS.this_cDocDesco   = NVL(LocalDcOpe.DocDesco, "")
		THIS.this_cDocAcres   = NVL(LocalDcOpe.DocAcres, "")
		THIS.this_nDckBarra   = LocalDcOpe.DckBarra
		THIS.this_nDckTermos  = LocalDcOpe.DckTermos
		THIS.this_nViaTermos  = LocalDcOpe.ViaTermos
		THIS.this_cTxtPrzEnts = NVL(LocalDcOpe.TxtPrzEnts, "")
		THIS.this_nChkPrzEnts = LocalDcOpe.ChkPrzEnts
		THIS.this_cImgTecs    = NVL(LocalDcOpe.ImgTecs, "")

		*-- SigCdPam: parametros do sistema (logotipo padrao)
		IF USED("LocalParam")
			USE IN LocalParam
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 Logos FROM SigCdPam", "LocalParam")
		IF loc_nResultado < 1 OR !USED("LocalParam") OR EOF("LocalParam")
			THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados (SigCdPam)."
			RETURN .F.
		ENDIF

		*-- SigCdEmp: empresa emitente
		IF USED("LocalEmp")
			USE IN LocalEmp
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT RazSocs, Cgcs, Ies, Tel1s, Tel2s FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps), ;
			"LocalEmp")
		IF loc_nResultado < 1 OR !USED("LocalEmp") OR EOF("LocalEmp")
			THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada (SigCdEmp)."
			RETURN .F.
		ENDIF

		*-- SigMvCab: cabecalho do movimento
		IF USED("LocalEest")
			USE IN LocalEest
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Emps, Dopes, Numes, Datas, GrVends, Vends, GrResps, Resps, ContaOs, ContaDs, " + ;
			"ContaEs, PrazoEnts, Obses, ValVars, LocalEnts FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
			"LocalEest")
		IF loc_nResultado < 1 OR !USED("LocalEest") OR EOF("LocalEest")
			THIS.this_cMensagemErro = "Movimento n" + CHR(227) + "o encontrado (SigMvCab)."
			RETURN .F.
		ENDIF
		THIS.this_cContaOs   = NVL(LocalEest.ContaOs, "")
		THIS.this_cContaDs   = NVL(LocalEest.ContaDs, "")
		THIS.this_cContaEs   = NVL(LocalEest.ContaEs, "")
		THIS.this_nLocalEnts = NVL(LocalEest.LocalEnts, 0)
		THIS.this_nValVars   = NVL(LocalEest.ValVars, 0)

		*-- SigMvItn + SigCdPro: itens do movimento (sem subitens/embalagem)
		IF USED("LocalEestI")
			USE IN LocalEestI
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT a.CItens, a.CPros, b.Reffs, a.DPros, a.CUnis, a.Qtds, a.Units, a.Totas, " + ;
			"a.Aliqs, a.ValIpis, a.Obs FROM SigMvItn a, SigCdPro b " + ;
			"WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND a.CPros = b.CPros " + ;
			"ORDER BY a.CItens", ;
			"LocalEestI")
		IF loc_nResultado < 1 OR !USED("LocalEestI")
			THIS.this_cMensagemErro = "Falha ao ler " + CHR(237) + "tens do movimento (SigMvItn)."
			RETURN .F.
		ENDIF

		*-- SigMvItn + SigMvIts + SigCdPro: subitens/embalagens (podem nao existir)
		IF USED("crLclMvSub")
			USE IN crLclMvSub
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT a.CItens, a.CPros, c.Reffs, a.DPros, b.CodEmbs AS CUnis, b.Qtds, " + ;
			"a.Units, b.QtdEmbs, a.Aliqs, a.ValIpis, a.Qtds AS QtdsA, a.Obs " + ;
			"FROM SigMvItn a, SigMvIts b, SigCdPro c " + ;
			"WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND a.EmpDopNums = b.EmpDopNums " + ;
			"AND a.CItens = b.CItens AND b.CPros = c.CPros " + ;
			"ORDER BY a.CItens", ;
			"crLclMvSub")
		IF loc_nResultado < 0 OR !USED("crLclMvSub")
			THIS.this_cMensagemErro = "Falha ao ler subitens/embalagens do movimento (SigMvIts)."
			RETURN .F.
		ENDIF

		IF USED("LocalEstI2")
			USE IN LocalEstI2
		ENDIF
		IF RECCOUNT("crLclMvSub") > 0
			SELECT CItens, CPros, Reffs, DPros, CUnis, Qtds, ;
				Units * IIF(QtdEmbs > 0, QtdEmbs, 1) AS Units, ;
				(Qtds * Units) * IIF(QtdEmbs > 0, QtdEmbs, 1) AS Totas, Aliqs, ;
				(ValIpis / QtdsA) * (Qtds * IIF(QtdEmbs > 0, QtdEmbs, 1)) AS ValIpis, Obs ;
				FROM crLclMvSub ;
				ORDER BY CItens ;
				INTO CURSOR LocalEstI2 READWRITE
			SELECT LocalEstI2
			INDEX ON STR(CItens, 6) TAG CItens
		ELSE
			CREATE CURSOR LocalEstI2 (CItens N(10), CPros C(14), Reffs C(40), DPros C(40), ;
				CUnis C(3), Qtds N(9,3), Units N(15,6), Totas N(11,2), Aliqs N(4,2), ValIpis N(11,2), Obs C(40))
			INDEX ON STR(CItens, 6) TAG CItens
		ENDIF
		IF USED("crLclMvSub")
			USE IN crLclMvSub
		ENDIF

		*-- SigMvNfi: dados fiscais (ICMS e frete)
		IF USED("LocalNFis")
			USE IN LocalNFis
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT ValIcms, Fretes, VlFretes FROM SigMvNfi WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
			"LocalNFis")
		IF loc_nResultado < 1 OR !USED("LocalNFis")
			THIS.this_cMensagemErro = "Dados fiscais n" + CHR(227) + "o encontrados (SigMvNfi)."
			RETURN .F.
		ENDIF

		*-- SigMvPar: parcelas, agrupadas por forma de pagamento/moeda/valor
		IF USED("LocalPar1")
			USE IN LocalPar1
		ENDIF
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT FPags, MoeFpgs, Valos FROM SigMvPar WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
			"LocalPar1")
		IF loc_nResultado < 0 OR !USED("LocalPar1")
			THIS.this_cMensagemErro = "Parcelas n" + CHR(227) + "o encontradas (SigMvPar)."
			RETURN .F.
		ENDIF

		IF USED("LocalPar")
			USE IN LocalPar
		ENDIF
		SELECT SUM(1) AS Total, FPags, MoeFpgs, Valos ;
			FROM LocalPar1 ;
			GROUP BY FPags, MoeFpgs, Valos ;
			INTO CURSOR LocalPar READWRITE

		RETURN .T.
	ENDFUNC

	*==========================================================================
	* ProcessarCabecalhoEDados - equivalente ao legado Processamento(). Monta
	* cursor_4c_Cabecalho (1 linha) e cursor_4c_Dados (N linhas, paginadas
	* conforme this_nMaxProdutos) a partir dos cursores de origem.
	*==========================================================================
	PROTECTED FUNCTION ProcessarCabecalhoEDados()
		LOCAL loc_cEmail, loc_nResultado, loc_cFor, loc_cEnt, loc_cRef, loc_cVen, ;
			loc_cPag, loc_cDad, loc_lBar, loc_cBar, loc_cTel, loc_cBVd, loc_cPagto, ;
			loc_cVar, loc_cFrt, loc_nIcm, loc_dPrazo, loc_cObsEnt, loc_cEnd, ;
			loc_nPagina, loc_nItem, loc_nSeq, loc_lMudou, loc_nFill

		*-- Numero maximo de produtos por pagina (Docus: 3=Fixo; 4=Fixo c/Imagem)
		IF THIS.this_nDocus = 3
			THIS.this_nMaxProdutos = IIF(THIS.this_nChkPrzEnts = 1, 7, 14)
		ELSE
			THIS.this_nMaxProdutos = 3
		ENDIF

		*-- E-mails das contas de origem/destino (para envio do documento)
		loc_cEmail = ""
		IF !EMPTY(THIS.this_cContaOs)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT Emails FROM SigCdCli WHERE IClis = " + EscaparSQL(THIS.this_cContaOs), "LocalCliE")
			IF loc_nResultado >= 1 AND USED("LocalCliE") AND !EOF("LocalCliE") AND !EMPTY(LocalCliE.Emails)
				loc_cEmail = ALLTRIM(LocalCliE.Emails) + ";"
			ENDIF
		ENDIF
		IF !EMPTY(THIS.this_cContaDs)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT Emails FROM SigCdCli WHERE IClis = " + EscaparSQL(THIS.this_cContaDs), "LocalCliE")
			IF loc_nResultado >= 1 AND USED("LocalCliE") AND !EOF("LocalCliE") AND !EMPTY(LocalCliE.Emails)
				loc_cEmail = loc_cEmail + ALLTRIM(LocalCliE.Emails)
			ENDIF
		ENDIF
		IF USED("LocalCliE")
			USE IN LocalCliE
		ENDIF
		THIS.this_cContaEmail = loc_cEmail

		*-- Titulos dos labels (default do legado quando a configuracao vem vazia)
		loc_cFor = "Fornecedor"
		IF INLIST(THIS.this_nOpers, 1, 3) AND !EMPTY(THIS.this_cDocOrig)
			loc_cFor = THIS.this_cDocOrig
		ENDIF
		IF INLIST(THIS.this_nOpers, 2, 3) AND !EMPTY(THIS.this_cDocDest)
			loc_cFor = THIS.this_cDocDest
		ENDIF
		THIS.this_cTitFornec = loc_cFor

		loc_cEnt = "Data de Entrega"
		IF !EMPTY(LocalDcOpe.DocPrzE)
			loc_cEnt = ALLTRIM(LocalDcOpe.DocPrzE)
		ENDIF
		THIS.this_cDocPrzE = loc_cEnt

		loc_cRef = "Ref. Fornecedor"
		IF !EMPTY(LocalDcOpe.DocReffs)
			loc_cRef = ALLTRIM(LocalDcOpe.DocReffs)
		ENDIF
		THIS.this_cDocReffs = loc_cRef

		loc_cVen = "Comprador"
		IF !EMPTY(THIS.this_cDocVendCfg)
			loc_cVen = THIS.this_cDocVendCfg
		ENDIF
		THIS.this_cTitVend = loc_cVen

		loc_cPag = "Comerciais"
		IF !EMPTY(LocalDcOpe.DocPag)
			loc_cPag = ALLTRIM(LocalDcOpe.DocPag)
		ENDIF
		THIS.this_cDocPag = loc_cPag

		loc_cDad = "de Entrega"
		IF !EMPTY(LocalDcOpe.DocEntregs)
			loc_cDad = ALLTRIM(LocalDcOpe.DocEntregs)
		ENDIF
		THIS.this_cDocEntregs = loc_cDad

		THIS.this_cDocFretes  = NVL(LocalDcOpe.DocFretes, "")

		*-- Codigo de barras do cabecalho e telefone da empresa
		loc_lBar = (THIS.this_nDckBarra = 1)
		THIS.this_lImpCabBar = loc_lBar
		loc_cBar = fAltBar2de5(PADL(STR(THIS.this_nNDopes, 4), 4, "0") + PADL(STR(THIS.this_nNumes, 6), 6, "0"))
		THIS.this_cBarras = loc_cBar
		loc_cTel = ALLTRIM(LocalEmp.Tel1s) + IIF(EMPTY(ALLTRIM(LocalEmp.Tel2s)), "", "/" + ALLTRIM(LocalEmp.Tel2s))

		THIS.this_cDocTit   = NVL(LocalDcOpe.DocTit, "")
		THIS.this_dDatas    = NVL(LocalEest.Datas, {})
		THIS.this_cRazSocs  = NVL(LocalEmp.RazSocs, "")
		THIS.this_cCgcs     = NVL(LocalEmp.Cgcs, "")
		THIS.this_cIes      = NVL(LocalEmp.Ies, "")
		THIS.this_cTelefone = loc_cTel
		THIS.this_cObses    = NVL(LocalEest.Obses, "")

		*-- Flags de impressao copiadas do cabecalho para o cursor
		THIS.this_nDckPrzE    = LocalDcOpe.DckPrzE
		THIS.this_nDckReffs   = LocalDcOpe.DckReffs
		THIS.this_nDckVend    = LocalDcOpe.DckVend
		THIS.this_nDckTVend   = LocalDcOpe.DckTVend
		THIS.this_nDckFretes  = LocalDcOpe.DckFretes
		THIS.this_nDckIcmIpi  = LocalDcOpe.DckIcmIpi
		THIS.this_nDckEntregs = LocalDcOpe.DckEntregs
		THIS.this_nDckObsI    = LocalDcOpe.DckObsI

		*-- Monta o cabecalho (cursor_4c_Cabecalho - 1 linha)
		IF USED(THIS.this_cCursorCabecalho)
			USE IN (THIS.this_cCursorCabecalho)
		ENDIF
		CREATE CURSOR (THIS.this_cCursorCabecalho) ;
			(Dopes C(20), Numes N(6), Datas D(8), RazSocs C(50), Cgcs C(20), RespFretes C(16), ;
			 Obses M(4), Ies C(15), GrVends C(10), Vends C(10), DVends C(50), DddVends C(4), ;
			 Tel1sVends C(20), Tel2sVends C(20), eMailVends C(50), GrResps C(10), Resps C(10), ;
			 DResps C(40), ForIClis C(10), ForRClis C(50), ForEndes C(60), ForNums C(10), ;
			 ForCompls C(15), ForCeps C(9), ForCidas C(30), ForBairs C(40), ForEstas C(2), ;
			 ForContato C(20), ForDdds C(4), ForTel1s C(20), ForTel2s C(20), ForFaxs C(20), ;
			 ForeMails C(50), ForCgcs C(20), ForIes C(15), ForIMuns C(20), ForTpClis N(1), ;
			 EntIClis C(10), EntRClis C(50), EntEndes C(80), EntNums C(10), EntCompls C(15), ;
			 EntCeps C(9), EntCidas C(30), EntBairs C(40), EntEstas C(2), EntContato C(20), ;
			 EntDdds C(4), EntTel1s C(20), EntTel2s C(20), EntFaxs C(20), EnteMails C(50), ;
			 EntCgcs C(20), EntIes C(15), EntTpClis N(1), PrazoEnts D(8), Icms N(16,2), ;
			 TipoVars C(20), Variacao N(16,2), CondPagto M(4), TotPag N(4), Fretes C(12), ;
			 TitFornec C(15), DckPrzE N(1), DocPrzE C(15), DckReffs N(1), DocReffs C(15), ;
			 DckVend N(1), TitVend C(15), DckTVend N(1), Barras C(14), ImpCabBar L(1), ;
			 Imagem C(64), ImgTec C(64), DckFretes N(1), DocFretes C(12), DckIcmIpi N(1), ;
			 DocPag C(12), DckEntregs N(1), DocEntregs C(12), DckObsI N(1), Telefone C(41), ;
			 VlFretes N(16,2), BarVends C(14), TitTermos M(4), TxtTermos M(4), TitTermgs M(4), ;
			 TxtTermgs M(4), TxtTermBs M(4), Pagina N(4), ObsEntrega C(254))

		INSERT INTO (THIS.this_cCursorCabecalho) ;
			(Dopes, Numes, Datas, RazSocs, Cgcs, Ies, Obses, TitFornec, DckPrzE, DocPrzE, DckReffs, ;
			 DocReffs, DckVend, TitVend, DckTVend, Barras, ImpCabBar, DckFretes, DocFretes, DckIcmIpi, ;
			 DocPag, DckEntregs, DocEntregs, DckObsI, Telefone, TitTermos, TxtTermos, TitTermgs, ;
			 TxtTermgs, TxtTermBs) ;
			VALUES (THIS.this_cDocTit, THIS.this_nNumes, THIS.this_dDatas, THIS.this_cRazSocs, ;
				THIS.this_cCgcs, THIS.this_cIes, THIS.this_cObses, loc_cFor, THIS.this_nDckPrzE, loc_cEnt, ;
				THIS.this_nDckReffs, loc_cRef, THIS.this_nDckVend, loc_cVen, THIS.this_nDckTVend, loc_cBar, loc_lBar, ;
				THIS.this_nDckFretes, THIS.this_cDocFretes, THIS.this_nDckIcmIpi, loc_cPag, ;
				THIS.this_nDckEntregs, loc_cDad, THIS.this_nDckObsI, loc_cTel, NVL(LocalDcOpe.TitTermos, ""), ;
				NVL(LocalDcOpe.TxtTermos, ""), NVL(LocalDcOpe.TitTermgs, ""), NVL(LocalDcOpe.TxtTermgs, ""), ;
				NVL(LocalDcOpe.TxtTermBs, ""))

		*-- Dados do comprador (Vends)
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Razaos, RClis, Ddds, Tel1s, Tel2s, eMails FROM SigCdCli WHERE IClis = " + ;
			EscaparSQL(LocalEest.Vends), "LocalCli")
		loc_cBVd = ALLTRIM(STRTRAN(LocalEest.Vends, "/", "")) + "0"
		loc_cBVd = fAltBar2de5(loc_cBVd)
		THIS.this_cBarVends = loc_cBVd
		IF loc_nResultado >= 1 AND USED("LocalCli") AND !EOF("LocalCli")
			THIS.this_cGrVends    = PROPER(LocalEest.GrVends)
			THIS.this_cVends      = LocalEest.Vends
			THIS.this_cDVends     = IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos)
			THIS.this_cDddVends   = LocalCli.Ddds
			THIS.this_cTel1sVends = LocalCli.Tel1s
			THIS.this_cTel2sVends = LocalCli.Tel2s
			THIS.this_ceMailVends = LocalCli.eMails

			REPLACE GrVends    WITH THIS.this_cGrVends, ;
				Vends      WITH THIS.this_cVends, ;
				DVends     WITH THIS.this_cDVends, ;
				DddVends   WITH THIS.this_cDddVends, ;
				Tel1sVends WITH THIS.this_cTel1sVends, ;
				Tel2sVends WITH THIS.this_cTel2sVends, ;
				eMailVends WITH THIS.this_ceMailVends, ;
				BarVends   WITH loc_cBVd ;
				IN (THIS.this_cCursorCabecalho)
		ENDIF

		*-- Dados do parceiro/responsavel (Resps)
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Razaos, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(LocalEest.Resps), "LocalCli")
		IF loc_nResultado >= 1 AND USED("LocalCli") AND !EOF("LocalCli")
			THIS.this_cGrResps = PROPER(LocalEest.GrResps)
			THIS.this_cResps   = LocalEest.Resps
			THIS.this_cDResps  = IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos)

			REPLACE GrResps WITH THIS.this_cGrResps, ;
				Resps   WITH THIS.this_cResps, ;
				DResps  WITH THIS.this_cDResps ;
				IN (THIS.this_cCursorCabecalho)
		ENDIF

		*-- Dados do fornecedor
		loc_cFor = THIS.this_cContaOs
		IF INLIST(THIS.this_nOpers, 1, 3) AND !EMPTY(THIS.this_cDocOrig)
			loc_cFor = THIS.this_cContaOs
		ENDIF
		IF INLIST(THIS.this_nOpers, 2, 3) AND !EMPTY(THIS.this_cDocDest)
			loc_cFor = THIS.this_cContaDs
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Razaos, RClis, Endes, Nums, Compls, Ceps, Cidas, Bairs, Estas, Contato, " + ;
			"Ddds, Tel1s, Tel2s, Faxs, eMails, Cpfs, Rgs, InscMuns, TpClis " + ;
			"FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cFor), "LocalCli")
		IF loc_nResultado >= 1 AND USED("LocalCli") AND !EOF("LocalCli")
			REPLACE ForIClis   WITH loc_cFor, ;
				ForRClis   WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos), ;
				ForEndes   WITH LocalCli.Endes, ;
				ForNums    WITH LocalCli.Nums, ;
				ForCompls  WITH LocalCli.Compls, ;
				ForCeps    WITH LocalCli.Ceps, ;
				ForCidas   WITH LocalCli.Cidas, ;
				ForBairs   WITH LocalCli.Bairs, ;
				ForEstas   WITH LocalCli.Estas, ;
				ForContato WITH LocalCli.Contato, ;
				ForDdds    WITH LocalCli.Ddds, ;
				ForTel1s   WITH LocalCli.Tel1s, ;
				ForTel2s   WITH LocalCli.Tel2s, ;
				ForFaxs    WITH LocalCli.Faxs, ;
				ForeMails  WITH LocalCli.eMails, ;
				ForCgcs    WITH LocalCli.Cpfs, ;
				ForIes     WITH LocalCli.Rgs, ;
				ForIMuns   WITH LocalCli.InscMuns, ;
				ForTpClis  WITH LocalCli.TpClis ;
				IN (THIS.this_cCursorCabecalho)
		ENDIF

		*-- Dados de entrega (ContaEs) - com fallback para o fornecedor
		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Razaos, RClis, eMails, Faxs, Cpfs, Rgs, TpClis " + ;
			"FROM SigCdCli WHERE IClis = " + EscaparSQL(THIS.this_cContaEs), "LocalCli")
		IF loc_nResultado >= 1 AND USED("LocalCli") AND !EOF("LocalCli")
			REPLACE EntIClis  WITH THIS.this_cContaEs, ;
				EntRClis  WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos), ;
				EntFaxs   WITH LocalCli.Faxs, ;
				EnteMails WITH LocalCli.eMails, ;
				EntCgcs   WITH LocalCli.Cpfs, ;
				EntIes    WITH LocalCli.Rgs, ;
				EntTpClis WITH LocalCli.TpClis ;
				IN (THIS.this_cCursorCabecalho)

			*-- Endereco alternativo de entrega (SigCdCee), quando configurado
			IF THIS.ResolverEnderecoEntrega(THIS.this_cContaEs, THIS.this_nLocalEnts)
				loc_cEnd = ALLTRIM(LocalCee.Endes) + ;
					IIF(EMPTY(LocalCee.Nums), "", ", " + ALLTRIM(LocalCee.Nums)) + ;
					IIF(EMPTY(LocalCee.Compls), "", " - " + ALLTRIM(LocalCee.Compls))

				REPLACE EntEndes   WITH loc_cEnd, ;
					EntCeps    WITH LocalCee.Ceps, ;
					EntBairs   WITH LocalCee.Bairs, ;
					EntCidas   WITH LocalCee.Cidas, ;
					EntEstas   WITH LocalCee.Estas, ;
					EntDdds    WITH LocalCee.Ddds, ;
					EntTel1s   WITH LocalCee.Tel1s, ;
					EntTel2s   WITH LocalCee.Tel2s, ;
					EntContato WITH LocalCee.Contatos ;
					IN (THIS.this_cCursorCabecalho)
			ENDIF
		ELSE
			*-- Conta de entrega nao cadastrada: usa o endereco do fornecedor
			loc_cEnd = ALLTRIM(LocalCli.Endes) + ;
				IIF(EMPTY(LocalCli.Nums), "", ", " + ALLTRIM(LocalCli.Nums)) + ;
				IIF(EMPTY(LocalCli.Compls), "", " - " + ALLTRIM(LocalCli.Compls))

			REPLACE EntIClis   WITH loc_cFor, ;
				EntRClis   WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos), ;
				EntFaxs    WITH LocalCli.Faxs, ;
				EnteMails  WITH LocalCli.eMails, ;
				EntCgcs    WITH LocalCli.Cpfs, ;
				EntIes     WITH LocalCli.Rgs, ;
				EntTpClis  WITH LocalCli.TpClis, ;
				EntEndes   WITH loc_cEnd, ;
				EntCeps    WITH LocalCli.Ceps, ;
				EntBairs   WITH LocalCli.Bairs, ;
				EntCidas   WITH LocalCli.Cidas, ;
				EntEstas   WITH LocalCli.Estas, ;
				EntDdds    WITH LocalCli.Ddds, ;
				EntTel1s   WITH LocalCli.Tel1s, ;
				EntTel2s   WITH LocalCli.Tel2s, ;
				EntContato WITH LocalCli.Contato ;
				IN (THIS.this_cCursorCabecalho)
		ENDIF

		*-- Espelha nas properties this_cFor*/this_cEnt* o que acabou de ser
		*   gravado no cursor (fornecedor e entrega), para o Form poder ler
		*   tanto do cursor quanto do BO.
		SELECT (THIS.this_cCursorCabecalho)
		THIS.this_cForIClis   = ForIClis
		THIS.this_cForRClis   = ForRClis
		THIS.this_cForEndes   = ForEndes
		THIS.this_cForNums    = ForNums
		THIS.this_cForCompls  = ForCompls
		THIS.this_cForCeps    = ForCeps
		THIS.this_cForCidas   = ForCidas
		THIS.this_cForBairs   = ForBairs
		THIS.this_cForEstas   = ForEstas
		THIS.this_cForContato = ForContato
		THIS.this_cForDdds    = ForDdds
		THIS.this_cForTel1s   = ForTel1s
		THIS.this_cForTel2s   = ForTel2s
		THIS.this_cForFaxs    = ForFaxs
		THIS.this_cForeMails  = ForeMails
		THIS.this_cForCgcs    = ForCgcs
		THIS.this_cForIes     = ForIes
		THIS.this_cForIMuns   = ForIMuns
		THIS.this_nForTpClis  = ForTpClis
		THIS.this_cEntIClis   = EntIClis
		THIS.this_cEntRClis   = EntRClis
		THIS.this_cEntEndes   = EntEndes
		THIS.this_cEntNums    = EntNums
		THIS.this_cEntCompls  = EntCompls
		THIS.this_cEntCeps    = EntCeps
		THIS.this_cEntCidas   = EntCidas
		THIS.this_cEntBairs   = EntBairs
		THIS.this_cEntEstas   = EntEstas
		THIS.this_cEntContato = EntContato
		THIS.this_cEntDdds    = EntDdds
		THIS.this_cEntTel1s   = EntTel1s
		THIS.this_cEntTel2s   = EntTel2s
		THIS.this_cEntFaxs    = EntFaxs
		THIS.this_cEnteMails  = EnteMails
		THIS.this_cEntCgcs    = EntCgcs
		THIS.this_cEntIes     = EntIes
		THIS.this_nEntTpClis  = EntTpClis

		*-- Condicoes comerciais (parcelas agrupadas)
		loc_cPagto = ""
		SELECT LocalPar
		SCAN
			IF LocalPar.Total > 1
				loc_cPagto = loc_cPagto + IIF(EMPTY(loc_cPagto), "", "; ") + ;
					ALLTRIM(STR(LocalPar.Total, 10)) + "x " + ALLTRIM(LocalPar.FPags) + " - " + ;
					ALLTRIM(LocalPar.MoeFpgs) + "$ " + ALLTRIM(STR(LocalPar.Valos, 16, 2))
			ELSE
				loc_cPagto = loc_cPagto + IIF(EMPTY(loc_cPagto), "", "; ") + ;
					ALLTRIM(LocalPar.FPags) + " - " + ALLTRIM(LocalPar.MoeFpgs) + "$ " + ;
					ALLTRIM(STR(LocalPar.Valos, 16, 2))
			ENDIF
		ENDSCAN
		THIS.this_cCondPagto = loc_cPagto

		*-- Titulo do label de variacao (encargo x desconto)
		IF THIS.this_nValVars > 0
			loc_cVar = "Encargos Financeiros"
			IF !EMPTY(THIS.this_cDocAcres)
				loc_cVar = THIS.this_cDocAcres
			ENDIF
		ELSE
			loc_cVar = "Desconto Concedido"
			IF !EMPTY(THIS.this_cDocDesco)
				loc_cVar = THIS.this_cDocDesco
			ENDIF
		ENDIF
		THIS.this_cTipoVars = loc_cVar

		*-- Frete e ICMS
		loc_cFrt  = ""
		loc_nIcm  = 0
		IF USED("LocalNFis")
			loc_nIcm = LocalNFis.ValIcms
			IF EMPTY(LocalNFis.VlFretes)
				loc_cFrt = IIF(LocalNFis.Fretes != 1, "Destinat" + CHR(225) + "rio/FOB", "Emitente/CIF")
			ELSE
				loc_cFrt = TRANSFORM(LocalNFis.VlFretes, "9,999,999,999.99")
				THIS.this_nVlFretes = LocalNFis.VlFretes
				REPLACE VlFretes WITH LocalNFis.VlFretes IN (THIS.this_cCursorCabecalho)
			ENDIF
		ENDIF
		THIS.this_cRespFretes = loc_cFrt
		THIS.this_nIcms       = loc_nIcm

		*-- Prazo e observacao de entrega
		loc_dPrazo = ConverterParaData(NVL(LocalEest.PrazoEnts, {}))
		THIS.this_dPrazoEnts = loc_dPrazo

		loc_cObsEnt = ""
		IF THIS.this_nChkPrzEnts = 1 AND !EMPTY(THIS.this_cTxtPrzEnts)
			loc_cObsEnt = STRTRAN(THIS.this_cTxtPrzEnts, "#", DTOC(loc_dPrazo))
		ENDIF
		THIS.this_cObsEntrega = loc_cObsEnt
		THIS.this_nVariacao   = ABS(THIS.this_nValVars)

		REPLACE PrazoEnts  WITH loc_dPrazo, ;
			Variacao   WITH THIS.this_nVariacao, ;
			TipoVars   WITH loc_cVar, ;
			Icms       WITH loc_nIcm, ;
			RespFretes WITH loc_cFrt, ;
			CondPagto  WITH loc_cPagto, ;
			ObsEntrega WITH loc_cObsEnt ;
			IN (THIS.this_cCursorCabecalho)

		*-- Monta a relacao de itens (cursor_4c_Dados - N linhas paginadas)
		IF USED(THIS.this_cCursorDados)
			USE IN (THIS.this_cCursorDados)
		ENDIF
		CREATE CURSOR (THIS.this_cCursorDados) ;
			(Pagina N(4), CItens N(4), CPros C(14), Reffs C(40), DPros C(40), CUnis C(3), ;
			 Qtds N(9,3), Units N(15,6), Totas N(11,2), Aliqs N(4,2), ValIpis N(11,2), Obs C(40))

		loc_nPagina = 1
		loc_nItem   = 0
		loc_nSeq    = 0
		loc_lMudou  = .F.

		SELECT LocalEestI
		SCAN
			loc_lMudou = .F.

			IF SEEK(STR(LocalEestI.CItens, 6), "LocalEstI2", "CItens")
				SELECT LocalEstI2
				SCAN WHILE CItens = LocalEestI.CItens
					loc_nItem = loc_nItem + 1
					loc_nSeq  = loc_nSeq + 1

					INSERT INTO (THIS.this_cCursorDados) ;
						(Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, Units, Totas, Aliqs, ValIpis, Obs) ;
						VALUES (loc_nPagina, loc_nSeq, LocalEstI2.CPros, LocalEstI2.Reffs, LocalEstI2.DPros, ;
							LocalEstI2.CUnis, LocalEstI2.Qtds, LocalEstI2.Units, LocalEstI2.Totas, ;
							LocalEstI2.Aliqs, LocalEstI2.ValIpis, NVL(LocalEstI2.Obs, ""))

					IF loc_nItem >= THIS.this_nMaxProdutos
						loc_nItem  = 0
						loc_nPagina = loc_nPagina + 1
						loc_lMudou = .T.
					ENDIF
				ENDSCAN
				SELECT LocalEestI
			ELSE
				loc_nItem = loc_nItem + 1
				loc_nSeq  = loc_nSeq + 1

				INSERT INTO (THIS.this_cCursorDados) ;
					(Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, Units, Totas, Aliqs, ValIpis, Obs) ;
					VALUES (loc_nPagina, loc_nSeq, LocalEestI.CPros, LocalEestI.Reffs, LocalEestI.DPros, ;
						LocalEestI.CUnis, LocalEestI.Qtds, LocalEestI.Units, LocalEestI.Totas, ;
						LocalEestI.Aliqs, LocalEestI.ValIpis, NVL(LocalEestI.Obs, ""))

				IF loc_nItem >= THIS.this_nMaxProdutos
					loc_nItem  = 0
					loc_nPagina = loc_nPagina + 1
					loc_lMudou = .T.
				ENDIF
			ENDIF
		ENDSCAN

		*-- Completa a ultima pagina com linhas em branco (alinhar a folha)
		IF loc_lMudou
			loc_nPagina = loc_nPagina - 1
		ENDIF
		IF loc_nItem < THIS.this_nMaxProdutos AND !loc_lMudou
			FOR loc_nFill = loc_nItem TO (THIS.this_nMaxProdutos - 1)
				INSERT INTO (THIS.this_cCursorDados) (Pagina) VALUES (loc_nPagina)
			ENDFOR
		ENDIF

		THIS.this_nTotalPaginas = loc_nPagina
		THIS.this_nTotPag       = loc_nPagina
		THIS.this_nPagina       = 1

		*-- Arquivos temporarios de imagem (logotipo / imagem tecnica / branco)
		THIS.this_cImgLogotipo = SYS(2023) + "\" + SYS(2015) + ".jpg"
		THIS.this_cImgTecnicas = SYS(2023) + "\" + SYS(2015) + ".jpg"
		THIS.this_cImgBranco   = fCriarIcone("brjpg.jpg", SYS(2023))

		IF EMPTY(THIS.this_cImgBranco) OR !FILE(THIS.this_cImgBranco)
			MsgAviso("N" + CHR(227) + "o foi encontrado um .jpg em branco para o logotipo " + ;
				"(Procurar por: " + ALLTRIM(THIS.this_cImgBranco) + ")." + CHR(13) + ;
				"O documento ser" + CHR(225) + " exibido sem logotipo.", "Aviso")
		ELSE
			IF USED("csBranco")
				USE IN csBranco
			ENDIF
			CREATE CURSOR csBranco (Branco M(4))
			APPEND BLANK
			APPEND MEMO Branco FROM (THIS.this_cImgBranco) OVERWRITE

			CLEAR RESOURCES
			IF !EMPTY(LocalParam.Logos)
				COPY MEMO LocalParam.Logos TO (THIS.this_cImgLogotipo)
			ELSE
				COPY MEMO csBranco.Branco TO (THIS.this_cImgLogotipo)
			ENDIF

			CLEAR RESOURCES
			IF !EMPTY(THIS.this_cImgTecs)
				COPY MEMO LocalDcOpe.ImgTecs TO (THIS.this_cImgTecnicas)
			ELSE
				COPY MEMO csBranco.Branco TO (THIS.this_cImgTecnicas)
			ENDIF

			USE IN csBranco
		ENDIF

		REPLACE TotPag WITH THIS.this_nTotalPaginas, ;
			Imagem WITH THIS.this_cImgLogotipo, ;
			ImgTec WITH THIS.this_cImgTecnicas ;
			IN (THIS.this_cCursorCabecalho)

		SELECT (THIS.this_cCursorCabecalho)
		GO TOP
		SELECT (THIS.this_cCursorDados)
		GO TOP

		RETURN .T.
	ENDFUNC

	*==========================================================================
	* ResolverEnderecoEntrega - busca o endereco alternativo de entrega em
	* SigCdCee (ver nota de projeto no topo do arquivo). Abre LocalCee com
	* o resultado; quem chama confere USED("LocalCee")/EOF antes de ler.
	*==========================================================================
	PROTECTED FUNCTION ResolverEnderecoEntrega(par_cIClis, par_nCodigo)
		LOCAL loc_nResultado

		IF USED("LocalCee")
			USE IN LocalCee
		ENDIF

		IF EMPTY(par_cIClis) OR VARTYPE(par_nCodigo) != "N" OR par_nCodigo <= 0
			RETURN .F.
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, ;
			"SELECT Ceps, Paises, Endes, Nums, Compls, Bairs, Cidas, Estas, Ddds, Tel1s, Tel2s, Contatos " + ;
			"FROM SigCdCee WHERE IClis = " + EscaparSQL(par_cIClis) + ;
			" AND Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + " AND Atuals = 1", ;
			"LocalCee")

		RETURN (loc_nResultado >= 1 AND USED("LocalCee") AND !EOF("LocalCee"))
	ENDFUNC

	*==========================================================================
	* LiberarCursoresAuxiliares - fecha os cursores de trabalho usados em
	* SelecionarDadosOrigem/ProcessarCabecalhoEDados. Nao fecha
	* cursor_4c_Cabecalho/cursor_4c_Dados (saida consumida pelo Form).
	*==========================================================================
	PROTECTED PROCEDURE LiberarCursoresAuxiliares()
		LOCAL loc_cLista, loc_nI, loc_cCursor

		loc_cLista = ",LocalOpe,LocalDcOpe,LocalParam,LocalEmp,LocalEest,LocalEestI," + ;
			"crLclMvSub,LocalEstI2,LocalNFis,LocalPar1,LocalPar,LocalCli,LocalCliE,LocalCee,csBranco,"

		FOR loc_nI = 1 TO OCCURS(",", loc_cLista) - 1
			loc_cCursor = ALLTRIM(STREXTRACT(loc_cLista, ",", ",", loc_nI))
			IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
		ENDFOR
	ENDPROC

	*==========================================================================
	* FASE 2/8 - METODOS DE LEITURA DOS CURSORES PARA AS PROPRIEDADES DO BO
	*
	* Esta tela eh um VISUALIZADOR. No dump do legado (SIGOPDEN) nao existe
	* TABLEUPDATE nem .AddCursor, e todo "Insert Into" tem por destino os
	* cursores LOCAIS crCabecalho/crDados - o acesso remoto eh 100% Select.
	* Por isso Inserir()/Atualizar()/ExecutarExclusao() seguem com o
	* comportamento padrao herdado de BusinessBase, que ja eh o correto (recusa
	* a operacao e reporta pelo ExibirFalha do Salvar), e RegistrarAuditoria()
	* nao tem onde ser chamado: nao ha gravacao a auditar nesta tela. Escrever
	* um INSERT/UPDATE aqui significaria INVENTAR a lista de colunas, o que a
	* regra #22 do CLAUDE.md proibe (a lista vem do schema) e o que violaria o
	* PILAR 2.
	*==========================================================================

	*==========================================================================
	* MontarChaveEmpDopNums - monta a chave POSICIONAL do movimento.
	*
	* Regra #42: a chave eh posicional e o padding FAZ PARTE dela. Em SigMvCab
	* a coluna Emps eh char(3) e Dopes eh char(20), logo 3 + 20 + 6 = 29, que eh
	* exatamente a largura de EmpDopNums char(29). PADR explicito em cada parte:
	* ALLTRIM nas partes interiores encurta a chave, o SELECT roda SEM ERRO e
	* devolve ZERO linhas, em silencio.
	*==========================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cEmps, loc_cDopes, loc_nNumes

		loc_cEmps  = IIF(VARTYPE(par_cEmps)  = "C", par_cEmps,  "")
		loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
		loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
	ENDFUNC

	*==========================================================================
	* CarregarPorCodigo - carrega o movimento a partir da chave EmpDopNums
	* char(29) JA MONTADA (valor lido de uma coluna de cursor/grade). Quebra a
	* chave nas partes posicionais (3 + 20 + 6) e delega a CarregarDadosEntrega.
	*==========================================================================
	FUNCTION CarregarPorCodigo(par_cChave)
		LOCAL loc_lSucesso, loc_cChave

		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		IF VARTYPE(par_cChave) != "C" OR EMPTY(ALLTRIM(par_cChave))
			THIS.this_cMensagemErro = "Chave do movimento n" + CHR(227) + "o informada."
		ELSE
			loc_cChave   = PADR(par_cChave, 29)
			loc_lSucesso = THIS.CarregarDadosEntrega( ;
				SUBSTR(loc_cChave, 1, 3), ;
				SUBSTR(loc_cChave, 4, 20), ;
				VAL(SUBSTR(loc_cChave, 24, 6)))
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*==========================================================================
	* CarregarDoCursor - le a linha CORRENTE de um dos cursores de saida para as
	* propriedades do BO. PUBLIC porque eh assim na BusinessBase e porque o Form
	* chama de fora (regra #51).
	*
	* O BO publica DOIS cursores com estruturas diferentes (cursor_4c_Cabecalho
	* com 1 linha e cursor_4c_Dados com N itens), por isso o alias recebido eh
	* identificado pela ESTRUTURA antes de ser lido: ler o cursor errado
	* mapearia campo por campo sem erro nenhum. Sem parametro, assume o
	* cabecalho. A identificacao usa TYPE(alias + ".campo") - PEMSTATUS exige
	* OBJETO no 1o argumento e estoura o erro 11 recebendo nome de alias.
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_lSucesso

		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			ALLTRIM(par_cAliasCursor), THIS.this_cCursorCabecalho)

		DO CASE
			CASE !USED(loc_cAlias)
				THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			CASE TYPE(loc_cAlias + ".RazSocs") != "U"
				loc_lSucesso = THIS.CarregarCabecalhoDoCursor(loc_cAlias)
			CASE TYPE(loc_cAlias + ".CItens") != "U"
				loc_lSucesso = THIS.CarregarItemDoCursor(loc_cAlias)
			OTHERWISE
				THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
					"o corresponde ao cabe" + CHR(231) + "alho nem aos itens do documento."
		ENDCASE

		IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
			MsgErro(THIS.this_cMensagemErro, "Dados de Entrega")
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarCabecalhoDoCursor - mapeia TODAS as colunas de
	* cursor_4c_Cabecalho para as propriedades this_* correspondentes.
	*
	* O alias eh SELECIONADO antes de ler os campos (nunca "campo",
	* que eh sintaxe invalida em VFP9) e a work area anterior eh RESTAURADA no
	* fim, para nao roubar o alias corrente de quem chamou.
	*
	* ATENCAO ao 2o argumento de TratarNulo: ele eh o VALOR PADRAO, nao uma
	* letra de tipo - "" para char, 0 para numerico, .F. para logico.
	* A coluna Dopes do cursor recebe SigOpCdc.DocTit (titulo do documento), e
	* nao o codigo da operacao - por isso vai para this_cDocTit.
	*==========================================================================
	FUNCTION CarregarCabecalhoDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAliasAnterior, loc_oErro

		loc_lSucesso       = .F.
		loc_cAliasAnterior = ALIAS()

		TRY
			SELECT (par_cAliasCursor)

			IF !EOF() AND !BOF()
				*-- Documento / empresa emitente
				THIS.this_cDocTit       = TratarNulo(Dopes, "")
				THIS.this_nNumes        = TratarNulo(Numes, 0)
				THIS.this_dDatas        = ConverterParaData(Datas)
				THIS.this_cRazSocs      = TratarNulo(RazSocs, "")
				THIS.this_cCgcs         = TratarNulo(Cgcs, "")
				THIS.this_cIes          = TratarNulo(Ies, "")
				THIS.this_cTelefone     = TratarNulo(Telefone, "")
				THIS.this_cObses        = TratarNulo(Obses, "")
				THIS.this_cBarras       = TratarNulo(Barras, "")
				THIS.this_lImpCabBar    = TratarNulo(ImpCabBar, .F.)
				THIS.this_nPagina       = TratarNulo(Pagina, 0)
				THIS.this_nTotPag       = TratarNulo(TotPag, 0)
				THIS.this_nTotalPaginas = TratarNulo(TotPag, 0)
				THIS.this_cImgLogotipo  = TratarNulo(Imagem, "")
				THIS.this_cImgTecnicas  = TratarNulo(ImgTec, "")

				*-- Titulos calculados dos labels
				THIS.this_cTitFornec    = TratarNulo(TitFornec, "")
				THIS.this_cDocPrzE      = TratarNulo(DocPrzE, "")
				THIS.this_cDocReffs     = TratarNulo(DocReffs, "")
				THIS.this_cTitVend      = TratarNulo(TitVend, "")
				THIS.this_cDocPag       = TratarNulo(DocPag, "")
				THIS.this_cDocEntregs   = TratarNulo(DocEntregs, "")
				THIS.this_cDocFretes    = TratarNulo(DocFretes, "")
				THIS.this_cTipoVars     = TratarNulo(TipoVars, "")

				*-- Flags de impressao (numeric(1,0): 1=Sim; 2=Nao)
				THIS.this_nDckPrzE      = TratarNulo(DckPrzE, 0)
				THIS.this_nDckReffs     = TratarNulo(DckReffs, 0)
				THIS.this_nDckVend      = TratarNulo(DckVend, 0)
				THIS.this_nDckTVend     = TratarNulo(DckTVend, 0)
				THIS.this_nDckFretes    = TratarNulo(DckFretes, 0)
				THIS.this_nDckIcmIpi    = TratarNulo(DckIcmIpi, 0)
				THIS.this_nDckEntregs   = TratarNulo(DckEntregs, 0)
				THIS.this_nDckObsI      = TratarNulo(DckObsI, 0)

				*-- Comprador (Vends)
				THIS.this_cGrVends      = TratarNulo(GrVends, "")
				THIS.this_cVends        = TratarNulo(Vends, "")
				THIS.this_cDVends       = TratarNulo(DVends, "")
				THIS.this_cDddVends     = TratarNulo(DddVends, "")
				THIS.this_cTel1sVends   = TratarNulo(Tel1sVends, "")
				THIS.this_cTel2sVends   = TratarNulo(Tel2sVends, "")
				THIS.this_ceMailVends   = TratarNulo(eMailVends, "")
				THIS.this_cBarVends     = TratarNulo(BarVends, "")

				*-- Parceiro / responsavel (Resps)
				THIS.this_cGrResps      = TratarNulo(GrResps, "")
				THIS.this_cResps        = TratarNulo(Resps, "")
				THIS.this_cDResps       = TratarNulo(DResps, "")

				*-- Fornecedor (campos get01..get06 da tela)
				THIS.this_cForIClis     = TratarNulo(ForIClis, "")
				THIS.this_cForRClis     = TratarNulo(ForRClis, "")
				THIS.this_cForEndes     = TratarNulo(ForEndes, "")
				THIS.this_cForNums      = TratarNulo(ForNums, "")
				THIS.this_cForCompls    = TratarNulo(ForCompls, "")
				THIS.this_cForCeps      = TratarNulo(ForCeps, "")
				THIS.this_cForCidas     = TratarNulo(ForCidas, "")
				THIS.this_cForBairs     = TratarNulo(ForBairs, "")
				THIS.this_cForEstas     = TratarNulo(ForEstas, "")
				THIS.this_cForContato   = TratarNulo(ForContato, "")
				THIS.this_cForDdds      = TratarNulo(ForDdds, "")
				THIS.this_cForTel1s     = TratarNulo(ForTel1s, "")
				THIS.this_cForTel2s     = TratarNulo(ForTel2s, "")
				THIS.this_cForFaxs      = TratarNulo(ForFaxs, "")
				THIS.this_cForeMails    = TratarNulo(ForeMails, "")
				THIS.this_cForCgcs      = TratarNulo(ForCgcs, "")
				THIS.this_cForIes       = TratarNulo(ForIes, "")
				THIS.this_cForIMuns     = TratarNulo(ForIMuns, "")
				THIS.this_nForTpClis    = TratarNulo(ForTpClis, 0)

				*-- Local de entrega (campos get07..get12 da tela)
				THIS.this_cEntIClis     = TratarNulo(EntIClis, "")
				THIS.this_cEntRClis     = TratarNulo(EntRClis, "")
				THIS.this_cEntEndes     = TratarNulo(EntEndes, "")
				THIS.this_cEntNums      = TratarNulo(EntNums, "")
				THIS.this_cEntCompls    = TratarNulo(EntCompls, "")
				THIS.this_cEntCeps      = TratarNulo(EntCeps, "")
				THIS.this_cEntCidas     = TratarNulo(EntCidas, "")
				THIS.this_cEntBairs     = TratarNulo(EntBairs, "")
				THIS.this_cEntEstas     = TratarNulo(EntEstas, "")
				THIS.this_cEntContato   = TratarNulo(EntContato, "")
				THIS.this_cEntDdds      = TratarNulo(EntDdds, "")
				THIS.this_cEntTel1s     = TratarNulo(EntTel1s, "")
				THIS.this_cEntTel2s     = TratarNulo(EntTel2s, "")
				THIS.this_cEntFaxs      = TratarNulo(EntFaxs, "")
				THIS.this_cEnteMails    = TratarNulo(EnteMails, "")
				THIS.this_cEntCgcs      = TratarNulo(EntCgcs, "")
				THIS.this_cEntIes       = TratarNulo(EntIes, "")
				THIS.this_nEntTpClis    = TratarNulo(EntTpClis, 0)

				*-- Condicoes comerciais, frete, impostos e prazo de entrega
				THIS.this_cCondPagto    = TratarNulo(CondPagto, "")
				THIS.this_cRespFretes   = TratarNulo(RespFretes, "")
				THIS.this_cFretes       = TratarNulo(Fretes, "")
				THIS.this_nVlFretes     = TratarNulo(VlFretes, 0)
				THIS.this_nIcms         = TratarNulo(Icms, 0)
				THIS.this_nVariacao     = TratarNulo(Variacao, 0)
				THIS.this_dPrazoEnts    = ConverterParaData(PrazoEnts)
				THIS.this_cObsEntrega   = TratarNulo(ObsEntrega, "")

				*-- Termos do documento
				THIS.this_cTitTermos    = TratarNulo(TitTermos, "")
				THIS.this_cTxtTermos    = TratarNulo(TxtTermos, "")
				THIS.this_cTitTermgs    = TratarNulo(TitTermgs, "")
				THIS.this_cTxtTermgs    = TratarNulo(TxtTermgs, "")
				THIS.this_cTxtTermBs    = TratarNulo(TxtTermBs, "")

				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "O cabe" + CHR(231) + "alho do documento est" + ;
					CHR(225) + " vazio."
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao ler o cabe" + CHR(231) + "alho do documento: " + ;
				loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
				CHR(13) + "Procedure: " + loc_oErro.Procedure
			loc_lSucesso = .F.
		ENDTRY

		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
			SELECT (loc_cAliasAnterior)
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*==========================================================================
	* CarregarItemDoCursor - mapeia as 12 colunas da linha CORRENTE de
	* cursor_4c_Dados para as propriedades this_nIt* / this_cIt*.
	*
	* O cursor tem linhas de PREENCHIMENTO (so a coluna Pagina, para alinhar a
	* folha do documento): nelas CPros vem vazio e as propriedades ficam
	* zeradas - eh o comportamento do legado, que tambem grava
	* "Insert Into crDados (Pagina) Values (lnPgn)". A work area anterior eh
	* restaurada no fim.
	*==========================================================================
	FUNCTION CarregarItemDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAliasAnterior, loc_oErro

		loc_lSucesso       = .F.
		loc_cAliasAnterior = ALIAS()

		TRY
			SELECT (par_cAliasCursor)

			IF !EOF() AND !BOF()
				THIS.this_nItPagina  = TratarNulo(Pagina, 0)
				THIS.this_nItCItens  = TratarNulo(CItens, 0)
				THIS.this_cItCPros   = TratarNulo(CPros, "")
				THIS.this_cItReffs   = TratarNulo(Reffs, "")
				THIS.this_cItDPros   = TratarNulo(DPros, "")
				THIS.this_cItCUnis   = TratarNulo(CUnis, "")
				THIS.this_nItQtds    = TratarNulo(Qtds, 0)
				THIS.this_nItUnits   = TratarNulo(Units, 0)
				THIS.this_nItTotas   = TratarNulo(Totas, 0)
				THIS.this_nItAliqs   = TratarNulo(Aliqs, 0)
				THIS.this_nItValIpis = TratarNulo(ValIpis, 0)
				THIS.this_cItObs     = TratarNulo(Obs, "")

				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
					" item posicionado na rela" + CHR(231) + CHR(227) + "o do documento."
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao ler o item do documento: " + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
				CHR(13) + "Procedure: " + loc_oErro.Procedure
			loc_lSucesso = .F.
		ENDTRY

		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
			SELECT (loc_cAliasAnterior)
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

ENDDEFINE
