*====================================================================
* sigprenvBO.prg
*
* Business Object para sigprenv (Impressao de Etiquetas de Envelopes)
* Form OPERACIONAL - nao segue padrao CRUD Page1=Lista/Page2=Dados
* Tabela principal de controle: SigSySeq (sequencia de numeracao)
*====================================================================

DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Etiqueta / Quantidade (Etq_Ini / Etq_Qtd)
    this_nEtqIni = 0
    this_nEtqQtd = 0

    *-- Tipo de etiqueta (Opt_Tipo, dinamico a partir de SigCdTpe)
    this_nTipoEtiqueta = 0
    this_cDescTipoEtiqueta = ""

    *-- Impressora selecionada (Opt_Impressora, dinamico a partir de SigCdMp)
    this_cNomeImpressora = ""
    this_nTipoImpressora = 0
    this_nAjusteVertical = 0
    this_nAjusteHorizontal = 0
    this_nAjusteDensidade = 0
    this_nAjusteVelocidade = 0

    *-- Parametros do sistema (SigCdPam)
    this_nMaxTpEtis = 0
    this_nTpEtiPads = 0
    this_nMaxImpEti = 0
    this_nImpEtisPad = 0
    this_nAjVertsPad = 0
    this_nAjHorzsPad = 0
    this_cTpCBars = ""

    *-- Parametros adicionais (SigCdPac)
    this_nAjDensPad = 0
    this_nAjVelosPad = 0

    *-- Sequencia de numeracao (SigSySeq)
    this_cChaveSequencia = "ETIQENVELOPE"
    this_nSequenciaAtual = 0

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigSySeq"
        THIS.this_cCampoChave = "valor"

        RETURN .T.
    ENDPROC

ENDDEFINE
