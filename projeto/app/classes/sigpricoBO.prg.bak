*==============================================================================
* sigpricoBO.prg
*
* Business Object para Formsigprico
* Formulario de mapa visual/diagrama operacional
* Sem tabela propria - apenas imagens de navegacao
*==============================================================================

DEFINE CLASS sigpricoBO AS BusinessBase

	*-- Sem propriedades de dados: formulario apenas visual (27 imagens)
	*-- Metodos CRUD implementados como no-op para conformidade com BusinessBase

	*============================================================================
	* Init - Inicializa Business Object
	*============================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela    = ""
		THIS.this_cCampoChave = ""
		RETURN .T.
	ENDPROC

	*============================================================================
	* ObterChavePrimaria - Retorna chave primaria (vazia: sem tabela)
	*============================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ""
	ENDFUNC

	*============================================================================
	* CarregarDoCursor - No-op: form nao tem cursor de dados (apenas imagens)
	*============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nao ha dados para carregar de cursor
		RETURN .T.
	ENDPROC

	*============================================================================
	* Inserir - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao INSERT realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Atualizar - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao UPDATE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* ExecutarExclusao - No-op: form nao persiste dados
	*============================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao DELETE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Buscar - No-op: form nao possui lista de registros
	*============================================================================
	FUNCTION Buscar(par_cFiltro)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma consulta SELECT realizada
		RETURN .T.
	ENDFUNC

	*============================================================================
	* RegistrarAuditoria - No-op: sem operacoes que exijam auditoria
	*============================================================================
	PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nenhuma operacao de dados a auditar
		RETURN
	ENDPROC

ENDDEFINE
