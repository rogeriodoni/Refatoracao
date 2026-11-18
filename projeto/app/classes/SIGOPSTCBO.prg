*==============================================================================
* SIGOPSTCBO.prg - Business Object para "Status da transmissao do Arquivo Cat"
*
* Origem legado : SIGOPSTC.SCX  (tasks\task807)
* Tipo de form  : OPERACIONAL (dialogo FILHO, modal, chamado por outro form
*                 pai que ja transmitiu um arquivo e guarda o nome dele em
*                 ThisForm.pcSelFile)
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo SOMENTE LEITURA que mostra a situacao de transmissao de um arquivo
* "Cat" (SPED/fiscal) ja identificado pelo form pai. O legado recebe poForm
* (o form pai) no Init, le ThisForm.poForm.pcSelFile (o nome do arquivo
* selecionado na tela pai) e faz UMA UNICA consulta:
*
*   Select a.*, b.*, b.tDtEnvs As Envios From SigFiSit a
*     Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs
*     Where a.cArqMovs = '<pcSelFile>'
*
* SigFiSit (alias a) eh a situacao "cabecalho" do arquivo (uma linha por
* arquivo transmitido - cArqMovs/cEmps/cNumLotes/cImpFabs/...). SigFiSii
* (alias b) eh o HISTORICO de tentativas de envio desse arquivo (uma linha
* por tentativa - cUsuarios/tDtEnvs/cRetornos). O INNER JOIN produz UMA
* LINHA POR TENTATIVA DE ENVIO, e o cursor resultante (crTmpLgSit no legado)
* alimenta tres blocos da tela ao mesmo tempo:
*   - Text1..Text4: le os campos de SigFiSit (cArqMovs/cNumLotes/cEmps/
*     cImpFabs) da PRIMEIRA linha do cursor (sao os mesmos em todas as
*     linhas, porque pertencem ao cabecalho replicado pelo JOIN).
*   - Grid1: RecordSource = cursor inteiro, Column1 = Envios (b.tDtEnvs,
*     uma data por tentativa), Column2 = cUsuarios (SigFiSit.cUsuarios -
*     nome de coluna duplicado entre a e b; o legado deixa o VFP resolver a
*     colisao, que preserva o nome original para a 1a ocorrencia - ou seja,
*     a coluna da grade mostra SEMPRE o usuario de SigFiSit, repetido em
*     toda linha, e NAO o usuario de cada tentativa de SigFiSii. Isso eh
*     reproduzido literalmente, regra "formula do legado se transcreve, nao
*     se corrige" - ver CLAUDE.md regra #17/comentario de pipeline).
*   - Edit1: ControlSource = cRetornos (SigFiSii.cRetornos, memo) da linha
*     CORRENTE do grid - por isso AfterRowColChange refaz Edit1.Value ao
*     navegar entre as tentativas de envio.
*
* Botao unico: "Encerrar" (Commandgroup1.Command1) so fecha o dialogo
* (ThisForm.Release) - nao ha Incluir/Alterar/Excluir.
*
* PERSISTENCIA
* -------------
* Nenhuma. Eh um visualizador puro - o comportamento herdado de
* BusinessBase para Inserir()/Atualizar()/ExecutarExclusao() (recusar a
* operacao) ja eh o correto; NAO sobrescrever esses metodos so para
* preencher.
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos controles
* ------------------------------------------------------------------------
*   SigFiSit.carqmovs  char(12) NOT NULL   SigFiSit.cidchaves char(20) NOT NULL (PK)
*   SigFiSit.cemps     char(3)  NOT NULL   SigFiSit.cimpfabs  char(20) NOT NULL
*   SigFiSit.cnumlotes char(10) NOT NULL   SigFiSit.cretsites char(20) NOT NULL
*   SigFiSit.cstatenvs char(1)  NOT NULL   SigFiSit.cstatvals char(1)  NOT NULL
*   SigFiSit.cusuarios char(20) NOT NULL   SigFiSit.tdtenvs   datetime NULL
*   SigFiSit.tdtmovs   datetime NULL
*   SigFiSii.carqmovs  char(12) NOT NULL   SigFiSii.cidchaves char(20) NOT NULL (PK)
*   SigFiSii.cretornos text     NULL       SigFiSii.cusuarios char(10) NOT NULL
*   SigFiSii.tdtenvs   datetime NULL
*==============================================================================

DEFINE CLASS SIGOPSTCBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - cabecalho da situacao de transmissao (SigFiSit), exibido
    * em Text1..Text4 do dialogo. Uma linha por arquivo transmitido.
    *--------------------------------------------------------------------------
    this_cCArqMovs           = ""   && carqmovs  char(12) NOT NULL - nome do arquivo (filtro recebido do form pai, Text1)
    this_cCIdChaves          = ""   && cidchaves char(20) NOT NULL - PK Fortyus de SigFiSit
    this_cCEmps              = ""   && cemps     char(3)  NOT NULL - codigo da empresa (Text3)
    this_cCNumLotes          = ""   && cnumlotes char(10) NOT NULL - numero do lote (Text2)
    this_cCImpFabs           = ""   && cimpfabs  char(20) NOT NULL - identificador da impressora fiscal (Text4)
    this_cCRetSites          = ""   && cretsites char(20) NOT NULL - retorno do site da SEFAZ (nao exibido na tela, mas parte de a.*)
    this_cCStatEnvs          = ""   && cstatenvs char(1)  NOT NULL - status do envio (nao exibido na tela, mas parte de a.*)
    this_cCStatVals          = ""   && cstatvals char(1)  NOT NULL - status da validacao (nao exibido na tela, mas parte de a.*)
    this_cCUsuarios          = ""   && cusuarios char(20) NOT NULL - usuario de SigFiSit; eh este valor (e nao o de cada tentativa de SigFiSii) que aparece em Grid1.Column2, por colisao de nome no legado
    this_dTDtEnvs            = {}   && tdtenvs   datetime NULL - data/hora do ultimo envio do cabecalho (nao exibido na tela, mas parte de a.*)
    this_dTDtMovs            = {}   && tdtmovs   datetime NULL - data/hora do movimento (nao exibido na tela, mas parte de a.*)

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.poForm / ThisForm.poForm.pcSelFile / ThisForm.poForm.
    * DataSessionId - o arquivo a consultar vem do form que chamou este
    * dialogo, nao de uma escolha feita aqui.
    *--------------------------------------------------------------------------
    this_nDataSessionPai     = 0    && DataSessionId do form pai (poForm.DataSessionId do legado)

    *--------------------------------------------------------------------------
    * ALIAS DE CURSOR (nome do legado entre parenteses - PILAR 3 manda
    * renomear). Uma unica consulta alimenta a grade (Grid1) E a caixa de
    * retorno (Edit1) - nao ha cursor separado para cada bloco.
    *--------------------------------------------------------------------------
    this_cCursorEnvios       = "cursor_4c_Envios"  && crTmpLgSit - uma linha por tentativa de envio (SigFiSii), com Envios/cUsuarios/cRetornos

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de referencia (SigFiSit.cidchaves) usada so
    * para auditoria/identificacao - este BO nunca grava (visualizador
    * puro), entao Inserir/Atualizar/ExecutarExclusao permanecem com o
    * comportamento herdado de BusinessBase (recusar a operacao).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigFiSit"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nDataSessionPai = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria.
    * Nunca chamado (este BO nunca grava), mas a base exige o override.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o CABECALHO (campos de SigFiSit, replicados
    * em toda linha pelo JOIN) a partir da PRIMEIRA linha do cursor
    * posicionado por CarregarSituacao (cursor_4c_Envios). Equivalente ao
    * legado lendo crTmpLgSit.cArqMovs/cNumLotes/cEmps/cImpFabs em
    * Text1..Text4 - sempre da linha corrente, mas como as colunas de
    * SigFiSit sao identicas em todas as linhas (regra do JOIN), ler a
    * PRIMEIRA basta.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                THIS.this_cCArqMovs  = TratarNulo(carqmovs,  "")
                THIS.this_cCIdChaves = TratarNulo(cidchaves, "")
                THIS.this_cCEmps     = TratarNulo(cemps,     "")
                THIS.this_cCNumLotes = TratarNulo(cnumlotes, "")
                THIS.this_cCImpFabs  = TratarNulo(cimpfabs,  "")
                THIS.this_cCRetSites = TratarNulo(cretsites, "")
                THIS.this_cCStatEnvs = TratarNulo(cstatenvs, "")
                THIS.this_cCStatVals = TratarNulo(cstatvals, "")
                THIS.this_cCUsuarios = TratarNulo(cusuarios, "")
                THIS.this_dTDtEnvs   = TratarNulo(tdtenvs,   {})
                THIS.this_dTDtMovs   = TratarNulo(tdtmovs,   {})

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSituacao - Executa a UNICA consulta do dialogo (equivalente ao
    * legado SIGOPSTC.Init) e popula cursor_4c_Envios: uma linha por
    * tentativa de envio (SigFiSii) do arquivo par_cArqMovs, com o
    * cabecalho de SigFiSit replicado em cada linha pelo INNER JOIN.
    *
    *   Select a.*, b.*, b.tDtEnvs As Envios From SigFiSit a
    *     Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs
    *     Where a.cArqMovs = '<par_cArqMovs>'
    *
    * As colunas sao listadas explicitamente (nao a.*, b.*) porque carqmovs/
    * cidchaves/cusuarios/tdtenvs existem nas DUAS tabelas: listar os dois
    * lados duplicaria o nome no cursor VFP. Mantem-se so o lado de SigFiSit
    * (alias a) para essas quatro - EXATAMENTE o que o legado produz quando
    * o VFP resolve a colisao de nomes (regra de pipeline citada no
    * cabecalho deste arquivo): Grid1.Column2 (cUsuarios) mostra sempre o
    * usuario do CABECALHO (SigFiSit), nunca o de cada tentativa
    * (SigFiSii.cUsuarios) - formula do legado, transcrita e nao corrigida.
    *
    * cRetornos (memo de SigFiSii, exibido em Edit1 da linha corrente) e
    * Envios (b.tDtEnvs apelidado, exibido em Grid1.Column1) sao as duas
    * colunas que SO existem no cursor por virem de SigFiSii.
    *
    * Depois de popular o cursor, chama CarregarDoCursor para preencher o
    * cabecalho (Text1..Text4) a partir da primeira linha.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION CarregarSituacao(par_cArqMovs)
        LOCAL loc_cArqMovs, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cArqMovs = IIF(VARTYPE(par_cArqMovs) = "C", par_cArqMovs, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg)
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.carqmovs, a.cidchaves, a.cemps, a.cnumlotes," + ;
                       " a.cimpfabs, a.cretsites, a.cstatenvs, a.cstatvals," + ;
                       " a.cusuarios, a.tdtenvs, a.tdtmovs, b.cretornos," + ;
                       " b.tdtenvs AS envios" + ;
                       " FROM SigFiSit a" + ;
                       " INNER JOIN SigFiSii b ON a.carqmovs = b.carqmovs" + ;
                       " WHERE a.carqmovs = " + EscaparSQL(loc_cArqMovs)

            IF USED("cursor_4c_Envios")
                USE IN cursor_4c_Envios
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Envios")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
                THIS.CarregarDoCursor("cursor_4c_Envios")
            ELSE
                MsgErro("Erro ao buscar a situa" + CHR(231) + CHR(227) + "o de transmiss" + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGOPSTCBO.CarregarSituacao:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
