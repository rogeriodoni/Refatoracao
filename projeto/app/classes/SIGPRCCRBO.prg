*==============================================================================
* SIGPRCCRBO.PRG
* Business Object do Relatorio "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os Alterados"
* Herda de RelatorioBase
*
* Este relatorio NAO possui campos de filtro na tela original (SIGPRCCR.scx
* nao declara nenhum TextBox/ComboBox/OptionGroup - layout.json confirma
* temGrid=false e campos=[] ). A selecao dos produtos e feita ANTES de abrir
* este formulario: outra tela do sistema legado marca os registros no cursor
* CrProdutos (campo lMarca = 1), e este relatorio apenas le esse cursor ja
* populado, monta o cabecalho e imprime.
*==============================================================================

DEFINE CLASS SIGPRCCRBO AS RelatorioBase

    *-- Nome do cursor de origem, populado por outra tela ANTES deste form abrir
    this_cCursorOrigem     = "CrProdutos"

    *-- Cursor de cabecalho (empresa/titulo/subtitulo) consumido pelo FRX
    this_cCursorCabecalho  = "CsCabecalho"

    *-- Cursor de dados (produtos marcados) consumido pelo FRX
    this_cCursorDados      = "CsRelatorio"

    *-- Nome-base do FRX legado (sem path, sem extensao)
    this_cArquivoRelatorio = "SigPrCcr"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        RETURN .T.
    ENDPROC

ENDDEFINE
