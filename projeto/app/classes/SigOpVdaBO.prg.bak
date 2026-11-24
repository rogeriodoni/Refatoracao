*------------------------------------------------------------------------------
* SigOpVdaBO - Business Object de Geracao de Arquivos de Vendas
* Baseado no formulario legado SIGOPVDA (SigOpVda.SCX)
* Tabela principal: SigPcOoL (controle de operacoes ja processadas)
*------------------------------------------------------------------------------
DEFINE CLASS SigOpVdaBO AS BusinessBase

    *-- Filtros de selecao (Pagina de criterios do form)
    this_cEmps = ""
    this_cDescEmps = ""
    this_dDataIni = {}
    this_dDataFin = {}
    this_nProcessados = 1
    this_cArquivo = ""
    this_cAdquirente = ""

    *-- Campos do registro de controle (SigPcOoL) gravado por operacao processada
    this_cTipos = ""
    this_cEmpsReg = ""      && emps da LINHA processada (empresa do movimento) - NAO confundir com this_cEmps (filtro digitado na tela)
    this_cDopes = ""
    this_nNumes = 0
    this_dDatas = {}
    this_cUsuars = ""
    this_cProdutos = ""
    this_cProcessos = ""
    this_cIdChaves = ""
    this_cEmpDopNums = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BusinessObject
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela = "SigPcOoL"
        THIS.this_cCampoChave = "cIdChaves"

        DODEFAULT()

        *-- Filtros nascem com os defaults do Init legado (ver
        *-- AplicarFiltrosPadrao). O form os leva para a tela no
        *-- BOParaForm() chamado pelo InicializarForm.
        THIS.AplicarFiltrosPadrao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltrosPadrao - valores iniciais dos filtros de selecao,
    * transcritos do bloco de defaults do Init do SCX legado (dentro do
    * "If (.poDataMgr.pnIdconn > 0)"):
    *
    *   .getDtIni.Value   = Date()
    *   .getDtFin.Value   = Date()
    *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
    *   optProcessados.Value = 1   (1-Nao Processadas / 2-Ja Processadas)
    *
    * Sem isto a tela abre com as duas datas e o caminho do arquivo em
    * BRANCO e o botao Selecionar recusa de imediato ("A Data Inicial Nao
    * Pode Ficar em Branco!!!" / "O Arquivo a Ser Gerado Precisa Ser
    * Informado!!!") - divergencia silenciosa do legado, que ja abre a tela
    * pronta para o dia corrente.
    *
    * Empresa, descricao da empresa e adquirente ficam VAZIOS de proposito:
    * o legado nao os preenche, e vazio significa "todas as empresas" /
    * "todos os adquirentes" nas duas consultas (o IIF(EMPTY(...)) de
    * Selecionar simplesmente omite a clausula do WHERE).
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFiltrosPadrao()
        THIS.this_cEmps         = ""
        THIS.this_cDescEmps     = ""
        THIS.this_dDataIni      = DATE()
        THIS.this_dDataFin      = DATE()
        THIS.this_nProcessados  = 1
        THIS.this_cArquivo      = "C:\CONCILIADOR.CSV"
        THIS.this_cAdquirente   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa as propriedades do registro de controle
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cTipos = ""
        THIS.this_cEmpsReg = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_dDatas = {}
        THIS.this_cUsuars = ""
        THIS.this_cProdutos = ""
        THIS.this_cProcessos = ""
        THIS.this_cIdChaves = ""
        THIS.this_cEmpDopNums = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves char(20), PK de SigPcOoL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cIdChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do registro de controle a
    * partir da linha corrente de um alias no formato de SigPcOoL/crSigPcOoL
    * (tipos, emps, dopes, numes, datas, usuars, produtos, processos,
    * cidchaves, empdopnums).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF EOF(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cTipos      = TratarNulo(tipos, "")
        THIS.this_cEmpsReg    = TratarNulo(emps, "")
        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
        THIS.this_cUsuars     = TratarNulo(usuars, "")
        THIS.this_cProdutos   = TratarNulo(produtos, "")
        THIS.this_cProcessos  = TratarNulo(processos, "")
        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava um registro de controle em SigPcOoL (uma linha por
    * operacao de venda processada/exportada), reproduzindo o
    * "Insert Into crSigPcOoL (...)" do metodo Processamento() do legado.
    *
    * cidchaves (PK char(20)) e gerado com fUniqueIds() quando ainda nao foi
    * atribuido - NUNCA string vazia, senao a linha seguinte do lote colide
    * no indice unico sigpcool_cidchaves (regra #22 do CLAUDE.md).
    *
    * empds/dopeds/numeds/edndests/nopers sao NOT NULL sem DEFAULT no schema
    * mas o legado nunca os preenche (o Insert Into do SCX lista so 10 das 15
    * colunas) - no fluxo legado eles chegam em branco/zero porque o cursor
    * crSigPcOoL nasce de AddCursor (estrutura completa da tabela, valores
    * default do tipo). Aqui o INSERT via SQLEXEC precisa declarar esses
    * mesmos defaults explicitamente, senao o SQL Server recusa a linha
    * inteira por tentar gravar NULL numa coluna que nao aceita.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPcOoL" + ;
                       " (tipos, emps, dopes, numes, empds, dopeds, numeds, datas," + ;
                       "  usuars, produtos, cidchaves, edndests, empdopnums, processos, nopers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(0, 0) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cUsuars) + "," + ;
                       EscaparSQL(THIS.this_cProdutos) + "," + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       EscaparSQL(THIS.this_cProcessos) + "," + ;
                       FormatarNumeroSQL(0, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar controle de opera" + CHR(231) + CHR(227) + ;
                    "o processada:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gravar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige um registro de controle ja gravado em SigPcOoL,
    * identificado pela PK cidchaves. O legado (SIGOPVDA) nunca faz UPDATE
    * nesta tabela - cada linha e gravada uma unica vez no Processamento() e
    * nunca mais tocada - mas o metodo e implementado para completar o
    * contrato de BusinessBase.Salvar() (THIS.this_lNovoRegistro = .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cMensagemErro = "Registro sem chave para altera" + CHR(231) + CHR(227) + "o"
            ELSE
                loc_cSQL = "UPDATE SigPcOoL SET" + ;
                           " tipos = "      + EscaparSQL(THIS.this_cTipos) + "," + ;
                           " emps = "       + EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                           " dopes = "      + EscaparSQL(THIS.this_cDopes) + "," + ;
                           " numes = "      + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                           " usuars = "     + EscaparSQL(THIS.this_cUsuars) + "," + ;
                           " produtos = "   + EscaparSQL(THIS.this_cProdutos) + "," + ;
                           " processos = "  + EscaparSQL(THIS.this_cProcessos) + "," + ;
                           " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + ;
                        "o processada:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
