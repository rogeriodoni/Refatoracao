*==============================================================================
* SIGOPCPEBO.prg - Business Object para Porta de Comunicacao (SIGOPCPE)
*
* Form OPERACIONAL de configuracao de hardware serial/paralelo.
* Tabela principal: SigSyCom (chave primaria: cidchaves char(20))
*
* Legado: SIGOPCPE.SCX - o Init() carrega TODA a tabela num cursor
* (crSigSyCom, query [Select * From SigSyCom]), indexa por Tipos
* (tag PesqTipo) e GARANTE a existencia dos 6 registros fixos de tipo de
* dispositivo, inserindo os que faltarem com Tipos + CidChaves = fUniqueIds()
* e repondo Settings = '9600,n,8,1' quando chega vazio. O usuario escolhe o
* dispositivo no Cmb_Tipo (que NAO tem ControlSource - ele apenas reposiciona
* o cursor via SEEK) e edita os campos da linha corrente; o botao Ok grava com
* poDataMgr.Update('crSigSyCom') + Commit() + fGrvSettings('CrSigSyCom').
*
* Mapeamento ControlSource legado -> propriedade (todas as 17 colunas de
* SigSyCom sao NOT NULL - ver docs/schema.sql):
*   Spinner1     -> crSigSyCom.portas    -> this_nPortas     numeric(1,0)
*   Cmb_Hand     -> crSigSyCom.hands     -> this_cHands      char(20)
*   Get_Set      -> crSigSyCom.settings  -> this_cSettings   char(20)
*   chk_dtr      -> crSigSyCom.dtrs      -> this_lDtrs       bit
*   chk_rts      -> crSigSyCom.rtss      -> this_lRtss       bit
*   Get_inbuf    -> crSigSyCom.inbufs    -> this_nInbufs     numeric(8,0)
*   Get_outbuf   -> crSigSyCom.outbufs   -> this_nOutbufs    numeric(8,0)
*   Get_inmode   -> crSigSyCom.inmodes   -> this_nInmodes    numeric(1,0)
*   Get_inlen    -> crSigSyCom.inlens    -> this_nInlens     numeric(8,0)
*   Get_TpLeChq  -> crSigSyCom.TpLeChqs  -> this_cTplechqs   char(1)
*   Opt_leitor   -> crSigSyCom.tpBarras  -> this_nTpbarras   numeric(1,0)
*   Chk_Bompara  -> crSigSyCom.bompara   -> this_nBompara    numeric(1,0)
*   chk_nominal  -> crSigSyCom.nominal   -> this_nNominal    numeric(1,0)
*   chk_cruzado  -> crSigSyCom.cruzado   -> this_nCruzado    numeric(1,0)
*   Cmb_Tipo     -> (sem ControlSource)  -> this_cTipos      char(20)
*   (sem controle na tela)               -> this_cCidchaves  char(20) - PK
*   (sem controle na tela)               -> this_cNomeimp    char(40)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SIGOPCPEBO AS BusinessBase

    *==========================================================================
    * Identificacao do registro / chave
    *==========================================================================
    *-- Tipos: char(20) - nome do dispositivo. No legado eh a chave de
    *-- pesquisa (Index On Tipos Tag PesqTipo) e o valor escolhido no
    *-- Cmb_Tipo; as comparacoes por SEEK usam PADR(...,20), porque o padding
    *-- faz parte da chave posicional do indice (CLAUDE.md regra #42).
    this_cTipos      = ""   && char(20) NOT NULL - tipo de dispositivo

    *-- CidChaves: char(20) - PRIMARY KEY (constraint sigsycom_cidchaves).
    *-- Gerada pelo fUniqueIds() do Fortyus no Insert Into do Init legado -
    *-- NUNCA vazia, senao o segundo registro colide no indice unico
    *-- (CLAUDE.md regra #22).
    this_cCidchaves  = ""   && char(20) NOT NULL - chave primaria

    *==========================================================================
    * Configuracao da porta serial (bloco esquerdo da tela, sempre visivel)
    *==========================================================================
    *-- Portas: numeric(1,0) - numero da porta de comunicacao. O Spinner1 do
    *-- legado limita 1..10 (SpinnerLowValue 1 / SpinnerHighValue 10,
    *-- KeyboardLowValue 1 / KeyboardHighValue 10) com Value inicial 1.
    this_nPortas     = 0    && numeric(1,0) NOT NULL - No. da porta COM

    *-- Hands: char(20) - HandShaking. O Cmb_Hand (RowSourceType 1) recebe no
    *-- Init legado os itens '0-None', '1-Xon Xoff', '2-RTS' e ' '; com
    *-- ControlSource char, o valor gravado eh o TEXTO do item escolhido.
    this_cHands      = ""   && char(20) NOT NULL - HandShaking

    *-- Settings: char(20) - configuracao da porta no formato
    *-- 'baud,paridade,databits,stopbits'. O Init legado repoe o default
    *-- '9600,n,8,1' em todo registro que chega vazio (this_cSettingsPadrao).
    this_cSettings   = ""   && char(20) NOT NULL - Settings da porta

    *-- Dtrs / Rtss: colunas bit do SQL Server, que chegam ao VFP como LOGICO
    *-- (.T./.F.) - por isso this_l*, e nao this_n* (bit -> LOGICAL;
    *-- numeric(1,0) -> NUMERIC). Ligadas a chk_dtr / chk_rts.
    this_lDtrs       = .F.  && bit NOT NULL - DTRenable
    this_lRtss       = .F.  && bit NOT NULL - RTSenable

    *-- Buffers e modo de leitura (Get_inbuf / Get_outbuf / Get_inmode /
    *-- Get_inlen). O dominio de InModes esta documentado na propria tela
    *-- pelo Say11: "( 0 - Text , 1- Binary )".
    this_nInbufs     = 0    && numeric(8,0) NOT NULL - InBufferMode
    this_nOutbufs    = 0    && numeric(8,0) NOT NULL - OutBufferMode
    this_nInmodes    = 0    && numeric(1,0) NOT NULL - InModes (0=Text, 1=Binary)
    this_nInlens     = 0    && numeric(8,0) NOT NULL - InLen

    *==========================================================================
    * Bloco de cheque (Say12/Say14/Say15/Say16 + controles) - o legado so
    * exibe estes controles quando Tipos = 'Leitora Cheques' OU
    * 'Impressora de Cheque' (Init e Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpLeChqs: char(1) - leitora de cheques. O Get_TpLeChq eh ComboBox com
    *-- Style = 2 (dropdown list) e RowSource
    *-- "T-Teclado ,S-Serial,P,M-Manual,C-Cheque Pre,K-Pertochek,H-Check-Pronto,U-USB";
    *-- com ControlSource char, o valor gravado eh a INICIAL da opcao
    *-- escolhida (T/S/P/M/C/K/H/U).
    this_cTplechqs   = ""   && char(1) NOT NULL - tipo de leitora de cheque

    *-- BomPara / Nominal / Cruzado: numeric(1,0) ligadas a CheckBox
    *-- (Chk_Bompara / chk_nominal / chk_cruzado). CheckBox sobre coluna
    *-- numerica grava 0 ou 1 - nao eh o indice 1-based de OptionGroup/
    *-- ComboBox -, por isso propriedade NUMERICA com dominio {0,1} e
    *-- conversao explicita nos dois sentidos no Form.
    this_nBompara    = 0    && numeric(1,0) NOT NULL - imprime "Bom Para"
    this_nNominal    = 0    && numeric(1,0) NOT NULL - imprime nominal
    this_nCruzado    = 0    && numeric(1,0) NOT NULL - imprime cruzado

    *==========================================================================
    * Bloco de leitor de codigo de barra (Say13 + Opt_leitor) - o legado
    * exibe quando Tipos = 'Leitora Codigo Barra' OU 'Leitora Cheques' (Init)
    * e tambem 'Impressora de Cheque' (Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpBarras: numeric(1,0) ligada ao Opt_leitor, OptionGroup de 3 botoes
    *-- (Option1 "Serial", Option2 "Teclado", Option3 "Paralelo") com
    *-- ControlSource direto: o valor gravado eh a ORDEM do botao marcado
    *-- (1=Serial, 2=Teclado, 3=Paralelo), 1-based e SEM +1/-1
    *-- (CLAUDE.md regra #45). O SCX declara Value = 2, logo o default de
    *-- tela eh "Teclado".
    this_nTpbarras   = 0    && numeric(1,0) NOT NULL - 1=Serial 2=Teclado 3=Paralelo

    *==========================================================================
    * Coluna NOT NULL sem controle na tela
    *==========================================================================
    *-- NomeImp: char(40) - nome da impressora associada ao dispositivo. Nao
    *-- tem controle no SCX e nao eh citada em metodo nenhum do legado:
    *-- existia apenas no registro em branco do cursor (AddCursor sem lista
    *-- de colunas = Select * + TableUpdate) e por isso continuava sendo
    *-- gravada em branco. Declarada aqui porque eh NOT NULL e o INSERT da
    *-- Fase 2 tem de cobri-la (CLAUDE.md regra #22).
    this_cNomeimp    = ""   && char(40) NOT NULL - nome da impressora

    *==========================================================================
    * Estado / apoio ao fluxo do form
    *==========================================================================
    *-- Alias do cursor que recebe TODA a tabela (equivalente ao crSigSyCom
    *-- do legado). O form percorre/posiciona este cursor conforme o Cmb_Tipo.
    this_cCursorDados     = "cursor_4c_Dados"

    *-- Lista dos 6 tipos de dispositivo que o Init legado GARANTE existirem
    *-- na tabela, na mesma ordem em que sao inseridos e em que o Cmb_Tipo os
    *-- apresenta (AddItem). Preenchida no Init() porque "Balanca" leva
    *-- cedilha e literal acentuado em .PRG eh proibido (CLAUDE.md regra #4).
    this_cTiposPadrao     = ""
    this_nTotalTipos      = 6

    *-- Settings default aplicado pelo Init legado a todo registro cujo
    *-- Settings chega vazio. Fica em propriedade propria, e nao na lista
    *-- acima, porque o proprio valor contem virgulas.
    this_cSettingsPadrao  = "9600,n,8,1"

    *-- Tipo selecionado no Cmb_Tipo. Guardado separado de this_cTipos para o
    *-- form saber qual linha reposicionar sem depender do estado do cursor.
    this_cTipoSelecionado = ""

    *-- Quantidade de registros carregados no cursor de dados.
    this_nQtdeRegistros   = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal e a chave primaria REAL de SigSyCom
    * (cidchaves - constraint sigsycom_cidchaves, ver docs/schema.sql), monta
    * a lista dos 6 tipos de dispositivo usando CHR() no lugar dos acentos e
    * zera o estado de edicao herdado de BusinessBase.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigSyCom")

            THIS.this_cTabela     = "SigSyCom"
            THIS.this_cCampoChave = "cidchaves"

            *-- Os 6 tipos fixos, na ordem dos Insert Into / AddItem do legado.
            *-- "Balanca" = "Balan" + CHR(231) + "a"  (CHR(231) = c-cedilha)
            THIS.this_cTiposPadrao = "Balan" + CHR(231) + "a" + ;
                                     ",Cupom Fiscal" + ;
                                     ",Leitora Cheques" + ;
                                     ",Leitora Codigo Barra" + ;
                                     ",Impressora de Cheque" + ;
                                     ",Gaveta Serial"
            THIS.this_nTotalTipos = 6

            *-- Estado inicial: consulta, nenhum registro posicionado.
            THIS.this_cTipoSelecionado = ""
            THIS.this_nQtdeRegistros   = 0
            THIS.this_lEmEdicao        = .F.
            THIS.this_lNovoRegistro    = .F.
            THIS.this_lDadosAlterados  = .F.
            THIS.this_cMensagemErro    = ""
            THIS.this_lErroExibido     = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SIGOPCPEBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterTipoPorIndice - Devolve o nome do tipo de dispositivo na posicao
    * informada (1..this_nTotalTipos), na mesma ordem do Cmb_Tipo legado.
    * Indice fora da faixa devolve string vazia.
    *
    * Sem PROTECTED de proposito: o Form chama de fora para popular o
    * Cmb_Tipo e para resolver a linha a posicionar no cursor (CLAUDE.md
    * regra #51 - metodo que o form chama nunca pode ser PROTECTED).
    *==========================================================================
    FUNCTION ObterTipoPorIndice(par_nIndice)
        LOCAL loc_cRetorno, loc_nLinhas
        LOCAL ARRAY loc_aTipos[1]
        loc_cRetorno = ""

        IF VARTYPE(par_nIndice) = "N" AND par_nIndice >= 1
            loc_nLinhas = ALINES(loc_aTipos, THIS.this_cTiposPadrao, 1, ",")
            IF par_nIndice <= loc_nLinhas
                loc_cRetorno = ALLTRIM(loc_aTipos[par_nIndice])
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Valor da chave primaria para a auditoria
    * (BusinessBase.RegistrarAuditoria). A PK de SigSyCom eh cidchaves.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as 17 colunas da linha corrente do
    * alias informado para as propriedades this_*. Usado tanto para a linha
    * reposicionada pelo Cmb_Tipo (equivalente ao Seek legado) quanto para o
    * proprio cursor_4c_Dados.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C"
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cTipos     = TratarNulo(tipos, "")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_nPortas    = TratarNulo(portas, 0)
                THIS.this_cHands     = TratarNulo(hands, "")
                THIS.this_cSettings  = TratarNulo(settings, "")

                *-- dtrs/rtss sao colunas bit do SQL Server - chegam ao VFP
                *-- como LOGICO (CLAUDE.md regra correlata a bit/numeric(1,0)).
                THIS.this_lDtrs      = dtrs
                THIS.this_lRtss      = rtss

                THIS.this_nInbufs    = TratarNulo(inbufs, 0)
                THIS.this_nOutbufs   = TratarNulo(outbufs, 0)
                THIS.this_nInmodes   = TratarNulo(inmodes, 0)
                THIS.this_nInlens    = TratarNulo(inlens, 0)
                THIS.this_cTplechqs  = TratarNulo(tplechqs, "")
                THIS.this_nTpbarras  = TratarNulo(tpbarras, 0)
                THIS.this_nBompara   = TratarNulo(bompara, 0)
                THIS.this_nNominal   = TratarNulo(nominal, 0)
                THIS.this_nCruzado   = TratarNulo(cruzado, 0)
                THIS.this_cNomeimp   = TratarNulo(nomeimp, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigSyCom (as 17 colunas, todas NOT NULL).
    *
    * cidchaves eh a PK Fortyus (CLAUDE.md regra #22): gerada por
    * fUniqueIds() quando ainda esta vazia, NUNCA deixada em branco -
    * senao o proximo registro colide no indice unico sigsycom_cidchaves.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "INSERT INTO SigSyCom " + ;
                    "(tipos, portas, dtrs, rtss, hands, settings, inbufs, outbufs, " + ;
                    "inmodes, inlens, tpbarras, cidchaves, tplechqs, bompara, cruzado, " + ;
                    "nominal, nomeimp) VALUES (" + ;
                    EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigSyCom, filtrado pela PK cidchaves.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cMensagemErro = "Registro sem chave prim" + CHR(225) + "ria - n" + ;
                CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel alterar."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "UPDATE SigSyCom SET " + ;
                    "tipos = "    + EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    "portas = "   + FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    "dtrs = "     + IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    "rtss = "     + IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    "hands = "    + EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    "settings = " + EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    "inbufs = "   + FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    "outbufs = "  + FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    "inmodes = "  + FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    "inlens = "   + FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    "tpbarras = " + FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    "tplechqs = " + EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    "bompara = "  + FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    "cruzado = "  + FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    "nominal = "  + FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    "nomeimp = "  + EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ;
                    " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDados - Monta o cursor de trabalho da tela (equivalente EXATO ao
    * bloco de abertura do Init legado).
    *
    * O legado faz, nesta ordem:
    *   .AddCursor('SigSyCom','Tipos','crSigSyCom','','',[Select * From SigSyCom])
    *   .ReQuery('crSigSyCom')
    *   Select crSigSyCom / Index On Tipos Tag PesqTipo / Go Top
    *   para cada um dos 6 tipos: If Not Seek(Padr(<tipo>,20))
    *                                 Insert Into crSigSyCom (Tipos, CidChaves) ...
    *                             EndIf
    *                             If IsEmpty(Settings) -> Replace com '9600,n,8,1'
    *
    * Reproduzido aqui porque esse cursor NAO eh um detalhe de carga: os
    * controles da tela sao ligados a ele por ControlSource (como no legado),
    * entao ele tem de EXISTIR e estar POSICIONADO antes de
    * ConfigurarCamposPrincipais rodar - ControlSource apontando para alias
    * fechado derruba o Init inteiro com [Alias ... is not found]
    * (CLAUDE.md regra #41). Por isso o Form chama este metodo ANTES de criar
    * os campos, e por isso o ramo sem conexao tambem cria o cursor (com a
    * estrutura das 17 colunas de SigSyCom): sem alias vivo a tela nao abre
    * nem em modo de teste.
    *
    * READWRITE eh obrigatorio: os controles editam a linha corrente e o
    * bloco de semeadura faz INSERT/REPLACE no proprio cursor - cursor de
    * SQLEXEC nasce SOMENTE-LEITURA.
    *
    * Sem PROTECTED de proposito - o Form chama de fora (CLAUDE.md regra #51).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_nI, loc_cTipo, loc_cAlias, loc_cAliasTmp, loc_oErro

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_cAlias      = THIS.this_cCursorDados
        loc_cAliasTmp   = loc_cAlias + "_Tmp"

        TRY
            *-- Fecha o alias anterior. O TABLEREVERT so entra se houver
            *-- buffering de verdade: sem buffering ele NAO eh no-op, dispara
            *-- erro 1586 (CLAUDE.md regra #52). USE IN fecha o alias mesmo
            *-- com buffer sujo.
            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                *-- Mesma query do lcQryCFis legado: a tabela INTEIRA.
                loc_cSQL = "SELECT tipos, portas, dtrs, rtss, hands, settings, " + ;
                    "inbufs, outbufs, inmodes, inlens, tpbarras, cidchaves, " + ;
                    "tplechqs, bompara, cruzado, nominal, nomeimp FROM SigSyCom"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

                *-- SELECT bem-sucedido devolve 1 (um result set). O > 0 eh
                *-- estrito de proposito: o passo seguinte DEPENDE do cursor
                *-- temporario existir.
                IF loc_nResultado > 0
                    *-- SQLEXEC gera cursor SOMENTE-LEITURA; READWRITE eh
                    *-- obrigatorio porque os controles editam a linha e a
                    *-- semeadura faz INSERT/REPLACE no proprio cursor.
                    SELECT * FROM (loc_cAliasTmp) INTO CURSOR (loc_cAlias) READWRITE
                    IF USED(loc_cAliasTmp)
                        USE IN (loc_cAliasTmp)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Carregar")
                    loc_lProsseguir = .F.
                ENDIF
            ELSE
                *-- Sem conexao (modo de teste / validacao de UI): cursor vazio
                *-- com a estrutura REAL de SigSyCom (docs/schema.sql). dtrs e
                *-- rtss sao Logicos porque bit do SQL Server chega ao VFP
                *-- como Logico - e sao eles que alimentam os CheckBox ligados
                *-- por ControlSource.
                CREATE CURSOR (loc_cAlias) ( ;
                    tipos     C(20), ;
                    portas    N(1, 0), ;
                    dtrs      L, ;
                    rtss      L, ;
                    hands     C(20), ;
                    settings  C(20), ;
                    inbufs    N(8, 0), ;
                    outbufs   N(8, 0), ;
                    inmodes   N(1, 0), ;
                    inlens    N(8, 0), ;
                    tpbarras  N(1, 0), ;
                    cidchaves C(20), ;
                    tplechqs  C(1), ;
                    bompara   L, ;
                    cruzado   L, ;
                    nominal   L, ;
                    nomeimp   C(40) )
            ENDIF

            IF loc_lProsseguir
                SELECT (loc_cAlias)

                *-- Index On Tipos Tag PesqTipo + Go Top do legado. A tag eh
                *-- consultada por SEEK a partir do Cmb_Tipo; chave de coluna
                *-- UNICA (char(20)), logo o SEEK usa PADR(...,20) e casa
                *-- exato mesmo com SET EXACT ON.
                INDEX ON tipos TAG PesqTipo
                GO TOP

                *-- Semeadura dos 6 tipos, igual ao legado: o que faltar eh
                *-- inserido com Tipos + CidChaves = fUniqueIds(); as demais
                *-- colunas ficam no valor em branco do cursor, exatamente
                *-- como no Insert Into de duas colunas do legado. Em seguida,
                *-- Settings vazio recebe o default '9600,n,8,1'.
                FOR loc_nI = 1 TO THIS.this_nTotalTipos
                    loc_cTipo = THIS.ObterTipoPorIndice(loc_nI)

                    IF !EMPTY(loc_cTipo)
                        IF !SEEK(PADR(loc_cTipo, 20), loc_cAlias, "PesqTipo")
                            INSERT INTO (loc_cAlias) (tipos, cidchaves) ;
                                VALUES (PADR(loc_cTipo, 20), LEFT(fUniqueIds(), 20))
                        ENDIF

                        IF EMPTY(ALLTRIM(EVALUATE(loc_cAlias + ".settings")))
                            REPLACE settings WITH THIS.this_cSettingsPadrao ;
                                IN (loc_cAlias)
                        ENDIF
                    ENDIF
                ENDFOR

                SELECT (loc_cAlias)
                GO TOP

                THIS.this_nQtdeRegistros = RECCOUNT(loc_cAlias)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar Porta de Comunica" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
