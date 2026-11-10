*============================================================================
* SigOpJobBO.prg - Business Object para Complementos de Job (SIGOPJOB)
*
* Tabela cabecalho : SigMvJbC  (PK: EmpDopNums char(29) = Emps(3)+Dopes(20)+Str(Numes,6))
* Tabela detalhe   : SigMvJbI  (PK: pkChaves char(20), FK: EmpDopNums char(29)) - grade "Fontes Pagadoras"
* Lookup equipe     : SigCdCli  (PK: Iclis, desc: Rclis) - codigos de atendimento/comercial/etc.
* Lookup empresa    : SigCdEmp  (PK: Cemps, desc: Razas)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpJobBO AS BusinessBase

    *==========================================================================
    * Chave primaria (composta, posicional - ver regra de montagem de chave)
    *==========================================================================
    this_cEmpDopNums = ""    && char(29) NOT NULL - PK (Emps+Dopes+Str(Numes,6))

    *==========================================================================
    * Pagina 1 - Apresentacao / Briefing (crSigMvJbC.Jb_001 .. Jb_023)
    *==========================================================================
    this_dJb001 = {}    && datetime - Apresentacao
    this_dJb002 = {}    && datetime - Orcamento
    this_cJb003 = ""    && text - Sobre o que estamos falando (resumo do brief)
    this_cJb004 = ""    && text - Historico (empresa/produto/servico)
    this_cJb005 = ""    && text - Contexto Mercadologico
    this_cJb006 = ""    && text - Cenario
    this_cJb007 = ""    && text - Target
    this_cJb008 = ""    && text - O problema
    this_dJb017 = {}    && datetime - Periodo do Evento (inicio)
    this_dJb018 = {}    && datetime - Periodo do Evento (fim)
    this_dJb019 = {}    && datetime - Periodo de Montagem (inicio)
    this_dJb020 = {}    && datetime - Periodo de Montagem/Desmontagem (fim)
    this_cJb021 = ""    && text - Local do Evento
    this_cJb022 = ""    && text - Publico Estimado
    this_cJb023 = ""    && text - Budget Estimado

    *==========================================================================
    * Pagina 2 - Desafio / Objetivos (crSigMvJbC.Jb_009 .. Jb_016)
    *==========================================================================
    this_cJb009 = ""    && text - Desafio
    this_cJb010 = ""    && text - Objetivos
    this_cJb011 = ""    && text - Tom de voz
    this_cJb012 = ""    && text - Inspiracoes
    this_cJb013 = ""    && text - Cliente (expectativas, comentarios)
    this_cJb014 = ""    && text - Sugestoes/obrigatoriedades e/ou restricoes
    this_cJb015 = ""    && text - Comunicacao/pecas obrigatorias
    this_cJb016 = ""    && text - Informacoes do local do evento

    *==========================================================================
    * Pagina 3 - Equipes (cntEmp1/cntEmp2) e Tipo de Projeto (crSigMvJbC.Jb_024 .. Jb_044)
    * Jb_024..030 = cntEmp1 (Atendimento/Comercial/Gerencia Projeto/Criacao/Arquiteto/Orcamento/Montagem)
    * Jb_031..037 = cntEmp2 (Lider de Projeto/Atendimento/Comercial/Criacao/Planejamento/Producao/Producao Financeira)
    *==========================================================================
    this_cJb024 = ""    && char(10) - cntEmp1 Atendimento (codigo SigCdCli.Iclis)
    this_cJb025 = ""    && char(10) - cntEmp1 Comercial (codigo SigCdCli.Iclis)
    this_cJb026 = ""    && char(10) - cntEmp1 Gerencia de Projeto (codigo SigCdCli.Iclis)
    this_cJb027 = ""    && char(10) - cntEmp1 Criacao (codigo SigCdCli.Iclis)
    this_cJb028 = ""    && char(10) - cntEmp1 Arquiteto (codigo SigCdCli.Iclis)
    this_cJb029 = ""    && char(10) - cntEmp1 Orcamento (codigo SigCdCli.Iclis)
    this_cJb030 = ""    && char(10) - cntEmp1 Montagem (codigo SigCdCli.Iclis)
    this_cJb031 = ""    && char(10) - cntEmp2 Lider de Projeto (codigo SigCdCli.Iclis)
    this_cJb032 = ""    && char(10) - cntEmp2 Atendimento (codigo SigCdCli.Iclis)
    this_cJb033 = ""    && char(10) - cntEmp2 Comercial (codigo SigCdCli.Iclis)
    this_cJb034 = ""    && char(10) - cntEmp2 Criacao (codigo SigCdCli.Iclis)
    this_cJb035 = ""    && char(10) - cntEmp2 Planejamento (codigo SigCdCli.Iclis)
    this_cJb036 = ""    && char(10) - cntEmp2 Producao (codigo SigCdCli.Iclis)
    this_cJb037 = ""    && char(10) - cntEmp2 Producao Financeira (codigo SigCdCli.Iclis)
    this_nJb038 = 0     && numeric(1,0) - Pedido do Cliente (checkbox)
    this_nJb039 = 0     && numeric(1,0) - Concorrencia (checkbox)
    this_nJb040 = 0     && numeric(1,0) - Licitacao (checkbox)
    this_nJb041 = 0     && numeric(1,0) - Proprietario (checkbox)
    this_nJb042 = 0     && numeric(1,0) - Desenvolvimento Total (checkbox)
    this_nJb043 = 0     && numeric(1,0) - Producao (checkbox)
    this_nJb044 = 0     && numeric(1,0) - Criacao (checkbox)

    *==========================================================================
    * Pagina 4 - Materiais de Apoio (crSigMvJbC.Jb_045 .. Jb_048 e Jb_061)
    * Campos de caminho de diretorio/arquivo (GetDir no legado)
    *==========================================================================
    this_cJb045 = ""    && text - Logomarca (caminho)
    this_cJb046 = ""    && text - Manual de Marca (caminho)
    this_cJb047 = ""    && text - Imagens (caminho)
    this_cJb048 = ""    && text - Referencias (caminho)
    this_cJb061 = ""    && text - Atas, emails e correspondencias de alteracoes/aprovacao do cliente
    this_cJb058 = ""    && text - Avaliacao do Job (apos primeira reuniao do time)

    *==========================================================================
    * Pagina 5 - Modelo Fiscal / Fontes Pagadoras (crSigMvJbC.Jb_062 .. Jb_071, Jb_075)
    * A grade "Fontes Pagadoras" (SigMvJbI) eh mantida em cursor separado, nao em property escalar
    *==========================================================================
    this_cJb062 = ""    && text - Codigo de Atividade
    this_nJb063 = 0     && numeric(1,0) - NF de Servico (checkbox)
    this_nJb064 = 0     && numeric(1,0) - Nota de Debito (checkbox)
    this_nJb065 = 0     && numeric(1,0) - NF de Locacao (checkbox)
    this_nJb066 = 0     && numeric(1,0) - Incentivo ICMS (checkbox)
    this_nJb067 = 0     && numeric(1,0) - Incentivo Rouanet (checkbox)
    this_nJb068 = 0     && numeric(1,0) - Incentivo ISS (checkbox)
    this_nJb069 = 0     && numeric(1,0) - Patrocinio (checkbox)
    this_nJb075 = 0     && numeric(1,0) - Conta Corrente (checkbox)
    this_nJb070 = 0     && decimal(1,0) - Outras Receitas
    this_cJb071 = ""    && text - Comentarios Financeiros (condicoes de pagamento, verba)

    *==========================================================================
    * Pagina 6 - Apresentacao / Propostas / Documentos (crSigMvJbC.Jb_049 .. Jb_057, Jb_073, Jb_074)
    *==========================================================================
    this_nJb049 = 0     && numeric(1,0) - Apresentacao Presencial (checkbox)
    this_nJb050 = 0     && numeric(1,0) - Apresentacao Eletronica (checkbox)
    this_nJb051 = 0     && numeric(1,0) - Proposta Comercial Impressao (checkbox)
    this_nJb052 = 0     && numeric(1,0) - Proposta Comercial CD (checkbox)
    this_nJb053 = 0     && numeric(1,0) - Proposta Comercial Outros (checkbox)
    this_cJb073 = ""    && char(50) - Proposta Comercial Outros (descricao)
    this_nJb054 = 0     && numeric(1,0) - Proposta Tecnica Impressao (checkbox)
    this_nJb055 = 0     && numeric(1,0) - Proposta Tecnica CD (checkbox)
    this_nJb056 = 0     && numeric(1,0) - Proposta Tecnica Outros (checkbox)
    this_cJb074 = ""    && char(50) - Proposta Tecnica Outros (descricao)
    this_cJb057 = ""    && text - Documentos Necessarios

    *==========================================================================
    * Colunas do schema sem controle visivel no SCX desta versao do form
    * (mantidas por fidelidade ao PILAR 2 - schema de banco identico)
    *==========================================================================
    this_cJb059    = ""    && text - reservado (sem controle no SCX atual)
    this_cJb060    = ""    && text - reservado (sem controle no SCX atual)
    this_dJbContato = {}   && datetime - Jb_Contato (data do ultimo contato)

    *-- numeric(1,0) - "Briefing Extra" (chk_4c_Get_Extra na raiz do form).
    *-- O SCX legado liga SIGOPJOB.get_Extra a ControlSource
    *-- "crSigMvJbC.Jb_072", e o ChecaObrigs legado conta [get_Extra] entre
    *-- os campos obrigatorios (laCpo(68)) - a coluna TEM controle visivel.
    this_nJb072    = 0

    *==========================================================================
    * Alias do cursor de detalhe (grade "Fontes Pagadoras" - SigMvJbI)
    *==========================================================================
    this_cCursorFontes = "cursor_4c_Fontes"

    *==========================================================================
    * Cabecalho de identificacao do Job (bloco de campos somente-leitura na
    * raiz do form - getCab001/002/005/006/010 do SCX legado).
    *
    * NAO sao colunas de SigMvJbC: vem do cabecalho da movimentacao
    * (SigMvCab) e do cadastro de contas (SigCdCli), carregados pela
    * PROCEDURE carregacabs do SCX legado. Por isso ficam em propriedades
    * proprias e NAO entram no INSERT/UPDATE de SigMvJbC.
    *==========================================================================
    this_cCabJobs         = ""   && SigMvCab.Jobs      - codigo do Job
    this_cCabJobDesc      = ""   && SigCdCli.RClis do Job
    this_cCabContas       = ""   && conta recebida do form pai (pCta)
    this_cCabContaDesc    = ""   && SigCdCli.RClis da conta
    this_dCabDataEntrada  = {}   && Min(SigMvCab.Datas) do Job

    *==========================================================================
    * Parametrizacao da operacao (SigOpCdI, chave dopes char(20)) - as tres
    * colunas "text" que o legado le atraves do cursor crSigOpCdI, carregado
    * pelo form PAI e visivel neste dialogo por heranca de data session:
    *
    *   job_mv_obr - MASCARA DE OBRIGATORIEDADE. Posicional: o caractere da
    *                posicao N vale "1" quando o campo N da lista do
    *                ChecaObrigs legado e obrigatorio. Lido por
    *                CampoObrigatorio().
    *   job_mv_tit - TITULOS personalizados por operacao (blocos de 50
    *                caracteres em posicoes fixas 101, 151, 201, ...). Lido
    *                por ObterTituloPersonalizado().
    *   job_mv_cpo - ROTULOS de campo personalizados (mesmos blocos de 50).
    *                Lido por ObterRotuloPersonalizado().
    *
    * Ficam em propriedades proprias e NAO entram no INSERT/UPDATE de
    * SigMvJbC: sao parametros de cadastro da operacao, somente-leitura
    * aqui (PILAR 2 - este form nunca escreve em SigOpCdI).
    *==========================================================================
    this_cJobMvObr = ""   && SigOpCdI.job_mv_obr - mascara de obrigatoriedade
    this_cJobMvTit = ""   && SigOpCdI.job_mv_tit - titulos por operacao
    this_cJobMvCpo = ""   && SigOpCdI.job_mv_cpo - rotulos de campo

    *-- SigCdEmp.divnotas numeric(1,0) da empresa do movimento. Decide quais
    *-- dos dois blocos de equipe (cntEmp1/cntEmp2) ficam visiveis na Page3:
    *-- 2 = so o primeiro, 3 = so o segundo, 4 = nenhum. O legado parte de 1
    *-- quando nao acha a empresa ("lnEmp = Iif(Eof([LocalEmps]), 1,
    *-- LocalEmps.DivNotas)"), e 1 nao cai em nenhum dos tres Case - os dois
    *-- blocos ficam como nasceram. Mesmo default aqui.
    this_nDivNotas = 1

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvJbC"
            THIS.this_cCampoChave = "EmpDopNums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConexaoAtiva - Ha handle de conexao utilizavel?
    *
    * Testa TYPE() antes do valor: em modo de teste / validacao de UI a
    * variavel gnConnHandle pode nem EXISTIR, e cita-la direto estoura
    * "Variable 'GNCONNHANDLE' is not found" - erro que nao diz nada sobre a
    * causa e polui o log do harness. O teste de TYPE fica num IF SEPARADO
    * porque VFP9 nao faz short-circuit em AND/OR.
    *==========================================================================
    FUNCTION ConexaoAtiva()
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF
        RETURN (gnConnHandle > 0)
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Retorna o valor da PK (EmpDopNums) para
    * RegistrarAuditoria(). Quem monta/preenche this_cEmpDopNums eh
    * CarregarDoCursor() (registro existente) ou MontarChaveEmpDopNums()
    * (registro novo, chamado pelo Form antes de NovoRegistro).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *==========================================================================
    * MontarChaveEmpDopNums - Monta a chave posicional de 29 caracteres usada
    * pelo legado (lcEmpDopNums): Emps(3) + Dopes(20) + Str(Numes,6).
    *
    * ALLTRIM nas PARTES quebra a busca/gravacao em silencio - "001" + "MALOTE"
    * + "     3" da 15 chars e nunca casa com o valor gravado (29 chars). Usar
    * SEMPRE PADR explicito nas partes (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
               PADR(TratarNulo(par_cDopes, ""), 20) + ;
               STR(TratarNulo(par_nNumes, 0), 6)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvJbC (cursor corrente
    * de par_cAliasCursor) para as propriedades this_* do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

            *-- Pagina 1 - Apresentacao / Briefing
            THIS.this_dJb001 = ConverterParaData(jb_001)
            THIS.this_dJb002 = ConverterParaData(jb_002)
            THIS.this_cJb003 = TratarNulo(jb_003, "")
            THIS.this_cJb004 = TratarNulo(jb_004, "")
            THIS.this_cJb005 = TratarNulo(jb_005, "")
            THIS.this_cJb006 = TratarNulo(jb_006, "")
            THIS.this_cJb007 = TratarNulo(jb_007, "")
            THIS.this_cJb008 = TratarNulo(jb_008, "")
            THIS.this_dJb017 = ConverterParaData(jb_017)
            THIS.this_dJb018 = ConverterParaData(jb_018)
            THIS.this_dJb019 = ConverterParaData(jb_019)
            THIS.this_dJb020 = ConverterParaData(jb_020)
            THIS.this_cJb021 = TratarNulo(jb_021, "")
            THIS.this_cJb022 = TratarNulo(jb_022, "")
            THIS.this_cJb023 = TratarNulo(jb_023, "")

            *-- Pagina 2 - Desafio / Objetivos
            THIS.this_cJb009 = TratarNulo(jb_009, "")
            THIS.this_cJb010 = TratarNulo(jb_010, "")
            THIS.this_cJb011 = TratarNulo(jb_011, "")
            THIS.this_cJb012 = TratarNulo(jb_012, "")
            THIS.this_cJb013 = TratarNulo(jb_013, "")
            THIS.this_cJb014 = TratarNulo(jb_014, "")
            THIS.this_cJb015 = TratarNulo(jb_015, "")
            THIS.this_cJb016 = TratarNulo(jb_016, "")

            *-- Pagina 3 - Equipes e Tipo de Projeto
            THIS.this_cJb024 = ALLTRIM(TratarNulo(jb_024, ""))
            THIS.this_cJb025 = ALLTRIM(TratarNulo(jb_025, ""))
            THIS.this_cJb026 = ALLTRIM(TratarNulo(jb_026, ""))
            THIS.this_cJb027 = ALLTRIM(TratarNulo(jb_027, ""))
            THIS.this_cJb028 = ALLTRIM(TratarNulo(jb_028, ""))
            THIS.this_cJb029 = ALLTRIM(TratarNulo(jb_029, ""))
            THIS.this_cJb030 = ALLTRIM(TratarNulo(jb_030, ""))
            THIS.this_cJb031 = ALLTRIM(TratarNulo(jb_031, ""))
            THIS.this_cJb032 = ALLTRIM(TratarNulo(jb_032, ""))
            THIS.this_cJb033 = ALLTRIM(TratarNulo(jb_033, ""))
            THIS.this_cJb034 = ALLTRIM(TratarNulo(jb_034, ""))
            THIS.this_cJb035 = ALLTRIM(TratarNulo(jb_035, ""))
            THIS.this_cJb036 = ALLTRIM(TratarNulo(jb_036, ""))
            THIS.this_cJb037 = ALLTRIM(TratarNulo(jb_037, ""))
            THIS.this_nJb038 = NVL(jb_038, 0)
            THIS.this_nJb039 = NVL(jb_039, 0)
            THIS.this_nJb040 = NVL(jb_040, 0)
            THIS.this_nJb041 = NVL(jb_041, 0)
            THIS.this_nJb042 = NVL(jb_042, 0)
            THIS.this_nJb043 = NVL(jb_043, 0)
            THIS.this_nJb044 = NVL(jb_044, 0)

            *-- Pagina 4 - Materiais de Apoio
            THIS.this_cJb045 = TratarNulo(jb_045, "")
            THIS.this_cJb046 = TratarNulo(jb_046, "")
            THIS.this_cJb047 = TratarNulo(jb_047, "")
            THIS.this_cJb048 = TratarNulo(jb_048, "")
            THIS.this_cJb061 = TratarNulo(jb_061, "")
            THIS.this_cJb058 = TratarNulo(jb_058, "")

            *-- Pagina 5 - Modelo Fiscal / Fontes Pagadoras
            THIS.this_cJb062 = TratarNulo(jb_062, "")
            THIS.this_nJb063 = NVL(jb_063, 0)
            THIS.this_nJb064 = NVL(jb_064, 0)
            THIS.this_nJb065 = NVL(jb_065, 0)
            THIS.this_nJb066 = NVL(jb_066, 0)
            THIS.this_nJb067 = NVL(jb_067, 0)
            THIS.this_nJb068 = NVL(jb_068, 0)
            THIS.this_nJb069 = NVL(jb_069, 0)
            THIS.this_nJb075 = NVL(jb_075, 0)
            THIS.this_nJb070 = NVL(jb_070, 0)
            THIS.this_cJb071 = TratarNulo(jb_071, "")

            *-- Pagina 6 - Apresentacao / Propostas / Documentos
            THIS.this_nJb049 = NVL(jb_049, 0)
            THIS.this_nJb050 = NVL(jb_050, 0)
            THIS.this_nJb051 = NVL(jb_051, 0)
            THIS.this_nJb052 = NVL(jb_052, 0)
            THIS.this_nJb053 = NVL(jb_053, 0)
            THIS.this_cJb073 = ALLTRIM(TratarNulo(jb_073, ""))
            THIS.this_nJb054 = NVL(jb_054, 0)
            THIS.this_nJb055 = NVL(jb_055, 0)
            THIS.this_nJb056 = NVL(jb_056, 0)
            THIS.this_cJb074 = ALLTRIM(TratarNulo(jb_074, ""))
            THIS.this_cJb057 = TratarNulo(jb_057, "")

            *-- Colunas sem controle visivel no SCX desta versao do form
            THIS.this_cJb059     = TratarNulo(jb_059, "")
            THIS.this_cJb060     = TratarNulo(jb_060, "")
            THIS.this_nJb072     = NVL(jb_072, 0)
            THIS.this_dJbContato = ConverterParaData(jb_contato)

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigMvJbC (todas as colunas do schema)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmpDopNums, "")))
            THIS.this_cMensagemErro = "Chave EmpDopNums n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigMvJbC (empdopnums, jb_001, jb_002, jb_003, jb_004, jb_005," + ;
                " jb_006, jb_007, jb_008, jb_009, jb_010, jb_011, jb_012, jb_013, jb_014, jb_015," + ;
                " jb_016, jb_017, jb_018, jb_019, jb_020, jb_021, jb_022, jb_023, jb_024, jb_025," + ;
                " jb_026, jb_027, jb_028, jb_029, jb_030, jb_031, jb_032, jb_033, jb_034, jb_035," + ;
                " jb_036, jb_037, jb_038, jb_039, jb_040, jb_041, jb_042, jb_043, jb_044, jb_045," + ;
                " jb_046, jb_047, jb_048, jb_049, jb_050, jb_051, jb_052, jb_053, jb_054, jb_055," + ;
                " jb_056, jb_057, jb_058, jb_059, jb_060, jb_061, jb_062, jb_063, jb_064, jb_065," + ;
                " jb_066, jb_067, jb_068, jb_069, jb_070, jb_071, jb_072, jb_073, jb_074, jb_075," + ;
                " jb_contato)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                FormatarDataSQL(THIS.this_dJb001) + "," + ;
                FormatarDataSQL(THIS.this_dJb002) + "," + ;
                EscaparSQL(THIS.this_cJb003) + "," + ;
                EscaparSQL(THIS.this_cJb004) + "," + ;
                EscaparSQL(THIS.this_cJb005) + "," + ;
                EscaparSQL(THIS.this_cJb006) + "," + ;
                EscaparSQL(THIS.this_cJb007) + "," + ;
                EscaparSQL(THIS.this_cJb008) + "," + ;
                EscaparSQL(THIS.this_cJb009) + "," + ;
                EscaparSQL(THIS.this_cJb010) + "," + ;
                EscaparSQL(THIS.this_cJb011) + "," + ;
                EscaparSQL(THIS.this_cJb012) + "," + ;
                EscaparSQL(THIS.this_cJb013) + "," + ;
                EscaparSQL(THIS.this_cJb014) + "," + ;
                EscaparSQL(THIS.this_cJb015) + "," + ;
                EscaparSQL(THIS.this_cJb016) + "," + ;
                FormatarDataSQL(THIS.this_dJb017) + "," + ;
                FormatarDataSQL(THIS.this_dJb018) + "," + ;
                FormatarDataSQL(THIS.this_dJb019) + "," + ;
                FormatarDataSQL(THIS.this_dJb020) + "," + ;
                EscaparSQL(THIS.this_cJb021) + "," + ;
                EscaparSQL(THIS.this_cJb022) + "," + ;
                EscaparSQL(THIS.this_cJb023) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb024, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb025, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb026, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb027, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb028, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb029, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb030, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb031, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb032, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb033, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb034, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb035, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb036, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb037, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb038, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb039, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb040, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb041, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb042, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb043, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb044, 0) + "," + ;
                EscaparSQL(THIS.this_cJb045) + "," + ;
                EscaparSQL(THIS.this_cJb046) + "," + ;
                EscaparSQL(THIS.this_cJb047) + "," + ;
                EscaparSQL(THIS.this_cJb048) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb049, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb050, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb051, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb052, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb053, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb054, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb055, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb056, 0) + "," + ;
                EscaparSQL(THIS.this_cJb057) + "," + ;
                EscaparSQL(THIS.this_cJb058) + "," + ;
                EscaparSQL(THIS.this_cJb059) + "," + ;
                EscaparSQL(THIS.this_cJb060) + "," + ;
                EscaparSQL(THIS.this_cJb061) + "," + ;
                EscaparSQL(THIS.this_cJb062) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb063, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb064, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb065, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb066, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb067, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb068, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb069, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb070, 0) + "," + ;
                EscaparSQL(THIS.this_cJb071) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb072, 0) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb073, 50)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb074, 50)) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb075, 0) + "," + ;
                FormatarDataSQL(THIS.this_dJbContato) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Complemento de Job:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigMvJbC (todas as colunas, exceto a PK)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmpDopNums, "")))
            THIS.this_cMensagemErro = "Chave EmpDopNums n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigMvJbC SET " + ;
                "jb_001 = "    + FormatarDataSQL(THIS.this_dJb001)              + "," + ;
                "jb_002 = "    + FormatarDataSQL(THIS.this_dJb002)              + "," + ;
                "jb_003 = "    + EscaparSQL(THIS.this_cJb003)                   + "," + ;
                "jb_004 = "    + EscaparSQL(THIS.this_cJb004)                   + "," + ;
                "jb_005 = "    + EscaparSQL(THIS.this_cJb005)                   + "," + ;
                "jb_006 = "    + EscaparSQL(THIS.this_cJb006)                   + "," + ;
                "jb_007 = "    + EscaparSQL(THIS.this_cJb007)                   + "," + ;
                "jb_008 = "    + EscaparSQL(THIS.this_cJb008)                   + "," + ;
                "jb_009 = "    + EscaparSQL(THIS.this_cJb009)                   + "," + ;
                "jb_010 = "    + EscaparSQL(THIS.this_cJb010)                   + "," + ;
                "jb_011 = "    + EscaparSQL(THIS.this_cJb011)                   + "," + ;
                "jb_012 = "    + EscaparSQL(THIS.this_cJb012)                   + "," + ;
                "jb_013 = "    + EscaparSQL(THIS.this_cJb013)                   + "," + ;
                "jb_014 = "    + EscaparSQL(THIS.this_cJb014)                   + "," + ;
                "jb_015 = "    + EscaparSQL(THIS.this_cJb015)                   + "," + ;
                "jb_016 = "    + EscaparSQL(THIS.this_cJb016)                   + "," + ;
                "jb_017 = "    + FormatarDataSQL(THIS.this_dJb017)              + "," + ;
                "jb_018 = "    + FormatarDataSQL(THIS.this_dJb018)              + "," + ;
                "jb_019 = "    + FormatarDataSQL(THIS.this_dJb019)              + "," + ;
                "jb_020 = "    + FormatarDataSQL(THIS.this_dJb020)              + "," + ;
                "jb_021 = "    + EscaparSQL(THIS.this_cJb021)                   + "," + ;
                "jb_022 = "    + EscaparSQL(THIS.this_cJb022)                   + "," + ;
                "jb_023 = "    + EscaparSQL(THIS.this_cJb023)                   + "," + ;
                "jb_024 = "    + EscaparSQL(PADR(THIS.this_cJb024, 10))         + "," + ;
                "jb_025 = "    + EscaparSQL(PADR(THIS.this_cJb025, 10))         + "," + ;
                "jb_026 = "    + EscaparSQL(PADR(THIS.this_cJb026, 10))         + "," + ;
                "jb_027 = "    + EscaparSQL(PADR(THIS.this_cJb027, 10))         + "," + ;
                "jb_028 = "    + EscaparSQL(PADR(THIS.this_cJb028, 10))         + "," + ;
                "jb_029 = "    + EscaparSQL(PADR(THIS.this_cJb029, 10))         + "," + ;
                "jb_030 = "    + EscaparSQL(PADR(THIS.this_cJb030, 10))         + "," + ;
                "jb_031 = "    + EscaparSQL(PADR(THIS.this_cJb031, 10))         + "," + ;
                "jb_032 = "    + EscaparSQL(PADR(THIS.this_cJb032, 10))         + "," + ;
                "jb_033 = "    + EscaparSQL(PADR(THIS.this_cJb033, 10))         + "," + ;
                "jb_034 = "    + EscaparSQL(PADR(THIS.this_cJb034, 10))         + "," + ;
                "jb_035 = "    + EscaparSQL(PADR(THIS.this_cJb035, 10))         + "," + ;
                "jb_036 = "    + EscaparSQL(PADR(THIS.this_cJb036, 10))         + "," + ;
                "jb_037 = "    + EscaparSQL(PADR(THIS.this_cJb037, 10))         + "," + ;
                "jb_038 = "    + FormatarNumeroSQL(THIS.this_nJb038, 0)         + "," + ;
                "jb_039 = "    + FormatarNumeroSQL(THIS.this_nJb039, 0)         + "," + ;
                "jb_040 = "    + FormatarNumeroSQL(THIS.this_nJb040, 0)         + "," + ;
                "jb_041 = "    + FormatarNumeroSQL(THIS.this_nJb041, 0)         + "," + ;
                "jb_042 = "    + FormatarNumeroSQL(THIS.this_nJb042, 0)         + "," + ;
                "jb_043 = "    + FormatarNumeroSQL(THIS.this_nJb043, 0)         + "," + ;
                "jb_044 = "    + FormatarNumeroSQL(THIS.this_nJb044, 0)         + "," + ;
                "jb_045 = "    + EscaparSQL(THIS.this_cJb045)                   + "," + ;
                "jb_046 = "    + EscaparSQL(THIS.this_cJb046)                   + "," + ;
                "jb_047 = "    + EscaparSQL(THIS.this_cJb047)                   + "," + ;
                "jb_048 = "    + EscaparSQL(THIS.this_cJb048)                   + "," + ;
                "jb_049 = "    + FormatarNumeroSQL(THIS.this_nJb049, 0)         + "," + ;
                "jb_050 = "    + FormatarNumeroSQL(THIS.this_nJb050, 0)         + "," + ;
                "jb_051 = "    + FormatarNumeroSQL(THIS.this_nJb051, 0)         + "," + ;
                "jb_052 = "    + FormatarNumeroSQL(THIS.this_nJb052, 0)         + "," + ;
                "jb_053 = "    + FormatarNumeroSQL(THIS.this_nJb053, 0)         + "," + ;
                "jb_054 = "    + FormatarNumeroSQL(THIS.this_nJb054, 0)         + "," + ;
                "jb_055 = "    + FormatarNumeroSQL(THIS.this_nJb055, 0)         + "," + ;
                "jb_056 = "    + FormatarNumeroSQL(THIS.this_nJb056, 0)         + "," + ;
                "jb_057 = "    + EscaparSQL(THIS.this_cJb057)                   + "," + ;
                "jb_058 = "    + EscaparSQL(THIS.this_cJb058)                   + "," + ;
                "jb_059 = "    + EscaparSQL(THIS.this_cJb059)                   + "," + ;
                "jb_060 = "    + EscaparSQL(THIS.this_cJb060)                   + "," + ;
                "jb_061 = "    + EscaparSQL(THIS.this_cJb061)                   + "," + ;
                "jb_062 = "    + EscaparSQL(THIS.this_cJb062)                   + "," + ;
                "jb_063 = "    + FormatarNumeroSQL(THIS.this_nJb063, 0)         + "," + ;
                "jb_064 = "    + FormatarNumeroSQL(THIS.this_nJb064, 0)         + "," + ;
                "jb_065 = "    + FormatarNumeroSQL(THIS.this_nJb065, 0)         + "," + ;
                "jb_066 = "    + FormatarNumeroSQL(THIS.this_nJb066, 0)         + "," + ;
                "jb_067 = "    + FormatarNumeroSQL(THIS.this_nJb067, 0)         + "," + ;
                "jb_068 = "    + FormatarNumeroSQL(THIS.this_nJb068, 0)         + "," + ;
                "jb_069 = "    + FormatarNumeroSQL(THIS.this_nJb069, 0)         + "," + ;
                "jb_070 = "    + FormatarNumeroSQL(THIS.this_nJb070, 0)         + "," + ;
                "jb_071 = "    + EscaparSQL(THIS.this_cJb071)                   + "," + ;
                "jb_072 = "    + FormatarNumeroSQL(THIS.this_nJb072, 0)         + "," + ;
                "jb_073 = "    + EscaparSQL(PADR(THIS.this_cJb073, 50))         + "," + ;
                "jb_074 = "    + EscaparSQL(PADR(THIS.this_cJb074, 50))         + "," + ;
                "jb_075 = "    + FormatarNumeroSQL(THIS.this_nJb075, 0)         + "," + ;
                "jb_contato = " + FormatarDataSQL(THIS.this_dJbContato) + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Complemento de Job:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFontes - Carrega a grade "Fontes Pagadoras" (SigMvJbI) filtrada
    * pela chave do Job (this_cEmpDopNums) em cursor_4c_Fontes.
    *
    * SQLEXEC() nasce SOMENTE-LEITURA; como a grade do form permite Incluir/
    * Excluir/editar linha (REPLACE/INSERT/DELETE direto no cursor), carrega
    * num alias temporario e reconstroi via SELECT ... INTO CURSOR READWRITE
    * com o MESMO nome e MESMA ordem de colunas do placeholder criado pelo
    * Form (regra: cursor de grid editavel exige READWRITE).
    *==========================================================================
    PROCEDURE CarregarFontes()
        LOCAL loc_cSQL, loc_cAliasTmp, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cAliasTmp = THIS.this_cCursorFontes + "Tmp"

        TRY
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            loc_cSQL = "SELECT empdopnums, jbi_autors, jbi_fontes, jbi_modelos, jbi_valors, pkchaves" + ;
                " FROM SigMvJbI WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)

            *-- Sem conexao (modo de teste / validacao de UI) o SQLEXEC nao
            *-- chega a rodar: gnConnHandle pode nem existir como variavel, e
            *-- a referencia estouraria "Variable 'GNCONNHANDLE' is not found"
            *-- - erro que nao diz nada sobre a causa real.
            loc_nResultado = -1
            IF THIS.ConexaoAtiva()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
            ENDIF

            IF loc_nResultado >= 0
                IF USED(THIS.this_cCursorFontes)
                    USE IN (THIS.this_cCursorFontes)
                ENDIF

                SELECT * FROM (loc_cAliasTmp) INTO CURSOR (THIS.this_cCursorFontes) READWRITE

                IF USED(loc_cAliasTmp)
                    USE IN (loc_cAliasTmp)
                ENDIF

                loc_lSucesso = .T.
            ELSE
                IF THIS.ConexaoAtiva()
                    MsgErro("Erro ao carregar Fontes Pagadoras:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarFontes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PersistirFontes - Grava a grade "Fontes Pagadoras" (SigMvJbI) a partir
    * de cursor_4c_Fontes: apaga todas as linhas do Job na tabela e reinsere
    * as que sobraram no cursor. O Form ja remove as linhas em branco antes
    * de chamar (CmdRetornarClick - transcricao de "Delete From crSigMvJbI
    * Where Empty(JBI_Fontes) Or Empty(JBI_Modelos)" do legado); o SCAN FOR
    * abaixo repete o mesmo filtro por seguranca, caso o metodo seja chamado
    * de outro lugar sem passar por aquela limpeza.
    *
    * Apagar+reinserir (em vez de UPDATE linha a linha) eh seguro aqui porque
    * pkchaves NAO tem FK de fora apontando para ele - e evita ter de rastrear
    * quais linhas o usuario excluiu da grade desde a ultima gravacao.
    *
    * Chamado pelo Form DEPOIS de THIS.Salvar() ter sucesso - a chave
    * EmpDopNums do cabecalho (SigMvJbC) precisa estar gravada antes do
    * detalhe (SigMvJbI), que a referencia.
    *==========================================================================
    PROCEDURE PersistirFontes()
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPk, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmpDopNums, "")))
            THIS.this_cMensagemErro = "Chave EmpDopNums n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        loc_cAlias = THIS.this_cCursorFontes
        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigMvJbI WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar Fontes Pagadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.

                SELECT (loc_cAlias)
                SCAN FOR !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos)
                    loc_cPk = ALLTRIM(TratarNulo(pkchaves, ""))
                    IF EMPTY(loc_cPk)
                        loc_cPk = fUniqueIds()
                    ENDIF

                    loc_cSQL = "INSERT INTO SigMvJbI" + ;
                        " (empdopnums, pkchaves, jbi_autors, jbi_fontes, jbi_modelos, jbi_valors)" + ;
                        " VALUES (" + ;
                        EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                        EscaparSQL(PADR(loc_cPk, 20)) + "," + ;
                        EscaparSQL(PADR(TratarNulo(jbi_autors, ""), 20)) + "," + ;
                        EscaparSQL(PADR(TratarNulo(jbi_fontes, ""), 50)) + "," + ;
                        EscaparSQL(PADR(TratarNulo(jbi_modelos, ""), 30)) + "," + ;
                        FormatarNumeroSQL(NVL(jbi_valors, 0), 2) + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        MsgErro("Erro ao gravar linha de Fontes Pagadoras:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em PersistirFontes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Transcricao da PROCEDURE carregacabs do SCX legado.
    * Preenche as propriedades this_cCab*/this_dCab* do bloco de identificacao
    * do Job (campos somente-leitura na raiz do form).
    *
    * Legado (SIGOPJOB.carregacabs):
    *   getCab001 = TprMvCab.Jobs
    *   CursorQuery('SigCdCli','LocalBus','IClis', TprMvCab.Jobs, 'RClis,...')
    *     -> getCab002 = LocalBus.RClis
    *   getCab005 = ThisForm.Contas
    *   CursorQuery('SigCdCli','LocalBus','IClis', ThisForm.Contas, 'RClis,...')
    *     -> getCab006 = LocalBus.RClis
    *   Select Jobs, Min(Datas) as Datas From SigMvCab
    *    Where Dopes = TprMvCab.Dopes And Jobs = TprMvCab.Jobs Group By Jobs
    *     -> getCab010 = Ttod(LocalBus.Datas)
    *
    * Diferenca de ORIGEM (nao de regra): o legado le TprMvCab, o cursor
    * global que o form PAI mantem aberto. O form migrado nao compartilha
    * cursor com o pai - recebe Emps/Dopes/Numes no Init e le o MESMO
    * registro de SigMvCab por empdopnums para obter Jobs. O criterio do
    * Min(Datas) continua o do legado: agrupado por Jobs, filtrado por
    * Dopes + Jobs (NAO pela chave do registro - o Job pode ter varias
    * movimentacoes e a data de entrada eh a MENOR delas).
    *
    * par_cContas: valor de pCta (2o parametro do Init legado).
    *==========================================================================
    PROCEDURE CarregarCabecalho(par_cContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cJobs, loc_cDopes, loc_cContas
        loc_lSucesso = .F.

        *-- Limpeza ANTES da guarda de conexao: sem conexao o cabecalho tem de
        *-- ficar VAZIO, nunca com o valor do Job anterior.
        THIS.this_cCabJobs        = ""
        THIS.this_cCabJobDesc     = ""
        THIS.this_cCabContaDesc   = ""
        THIS.this_dCabDataEntrada = {}
        THIS.this_cCabContas      = IIF(VARTYPE(par_cContas) = "C", ALLTRIM(par_cContas), "")

        *-- RETURN fora do TRY (regra #1)
        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        TRY

            *-- 1) Jobs + Dopes do registro de SigMvCab apontado pela chave
            IF USED("cursor_4c_CabTmp")
                USE IN cursor_4c_CabTmp
            ENDIF

            loc_cSQL = "SELECT jobs, dopes FROM SigMvCab" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabTmp")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar cabecalho do Job:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cJobs  = ""
                loc_cDopes = ""

                SELECT cursor_4c_CabTmp
                GO TOP
                IF !EOF("cursor_4c_CabTmp")
                    loc_cJobs  = TratarNulo(cursor_4c_CabTmp.jobs, "")
                    loc_cDopes = TratarNulo(cursor_4c_CabTmp.dopes, "")
                ENDIF
                USE IN cursor_4c_CabTmp

                THIS.this_cCabJobs = ALLTRIM(loc_cJobs)

                *-- 2) Descricao do Job (SigCdCli.RClis por IClis = Jobs)
                IF !EMPTY(ALLTRIM(loc_cJobs))
                    THIS.this_cCabJobDesc = THIS.ObterRazaoConta(loc_cJobs)
                ENDIF

                *-- 3) Descricao da conta recebida do form pai
                loc_cContas = THIS.this_cCabContas
                IF !EMPTY(loc_cContas)
                    THIS.this_cCabContaDesc = THIS.ObterRazaoConta(loc_cContas)
                ENDIF

                *-- 4) Data de entrada = MENOR data das movimentacoes do Job
                IF !EMPTY(ALLTRIM(loc_cJobs))
                    IF USED("cursor_4c_CabTmp")
                        USE IN cursor_4c_CabTmp
                    ENDIF

                    loc_cSQL = "SELECT jobs, MIN(datas) AS datas FROM SigMvCab" + ;
                        " WHERE dopes = " + EscaparSQL(ALLTRIM(loc_cDopes)) + ;
                        "   AND jobs = "  + EscaparSQL(ALLTRIM(loc_cJobs)) + ;
                        " GROUP BY jobs"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabTmp")

                    IF loc_nResultado < 0
                        MsgErro("Erro ao carregar data de entrada do Job:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ELSE
                        SELECT cursor_4c_CabTmp
                        GO TOP
                        IF !EOF("cursor_4c_CabTmp")
                            THIS.this_dCabDataEntrada = ConverterParaData(cursor_4c_CabTmp.datas)
                        ENDIF
                        USE IN cursor_4c_CabTmp
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalho")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterRazaoConta - SigCdCli.RClis de um IClis (equivale ao
    * CursorQuery('SigCdCli','LocalBus','IClis', <valor>, 'RClis') do legado).
    * Usado pelo cabecalho (descricao do Job e da conta) e pelos campos de
    * nome das equipes (Page3).
    *
    * SigCdCli.iclis eh char(10): compara-se com o valor ALLTRIM porque o
    * SQL Server faz blank-padding ANSI em char - diferente da chave
    * POSICIONAL empdopnums, onde o padding faz parte da chave (regra #42).
    *==========================================================================
    FUNCTION ObterRazaoConta(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_cRazao, loc_oErro
        loc_cRazao = ""

        TRY
            IF VARTYPE(par_cIClis) = "C" AND !EMPTY(ALLTRIM(par_cIClis)) AND ;
               THIS.ConexaoAtiva()
                IF USED("cursor_4c_RazaoTmp")
                    USE IN cursor_4c_RazaoTmp
                ENDIF

                loc_cSQL = "SELECT rclis FROM SigCdCli" + ;
                    " WHERE RTRIM(iclis) = " + EscaparSQL(ALLTRIM(par_cIClis))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp")

                IF loc_nResultado < 0
                    MsgErro("Erro ao consultar conta " + ALLTRIM(par_cIClis) + ":" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    SELECT cursor_4c_RazaoTmp
                    GO TOP
                    IF !EOF("cursor_4c_RazaoTmp")
                        loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_RazaoTmp.rclis, ""))
                    ENDIF
                    USE IN cursor_4c_RazaoTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ObterRazaoConta")
        ENDTRY

        RETURN loc_cRazao
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoJob - Le as tres colunas de parametrizacao da
    * operacao em SigOpCdI (job_mv_obr / job_mv_tit / job_mv_cpo).
    *
    * No legado quem abre esse cursor (crSigOpCdI) e o form PAI; este dialogo
    * so le, porque entra na data session do chamador
    * ("Set Datasession To .ParentForm.DataSessionId"). Nesta arquitetura o
    * dialogo tem BO proprio e precisa carregar por conta - a chave e a
    * OPERACAO (SigOpCdI.dopes), nao a chave do movimento.
    *
    * par_cDopes: codigo da operacao (SigMvCab.Dopes), vindo do form.
    *
    * Sem conexao (modo de teste / validacao de UI) as tres propriedades
    * ficam VAZIAS, e e' exatamente o comportamento neutro desejado:
    * CampoObrigatorio() devolve .F. para todo indice (nada obrigatorio) e
    * ObterTituloPersonalizado()/ObterRotuloPersonalizado() devolvem ""
    * (mantem o caption transcrito do SCX).
    *==========================================================================
    PROCEDURE CarregarConfiguracaoJob(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDopes, loc_oErro
        loc_lSucesso = .F.

        *-- Limpeza ANTES da guarda de conexao: operacao sem parametrizacao
        *-- tem de ficar NEUTRA, nunca com a mascara da operacao anterior.
        THIS.this_cJobMvObr = ""
        THIS.this_cJobMvTit = ""
        THIS.this_cJobMvCpo = ""

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

        *-- RETURN fora do TRY (regra #1)
        IF EMPTY(loc_cDopes)
            RETURN .F.
        ENDIF
        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_CfgJobTmp")
                IF CURSORGETPROP("Buffering", "cursor_4c_CfgJobTmp") > 1
                    TABLEREVERT(.T., "cursor_4c_CfgJobTmp")
                ENDIF
                USE IN cursor_4c_CfgJobTmp
            ENDIF

            loc_cSQL = "SELECT job_mv_obr, job_mv_tit, job_mv_cpo" + ;
                " FROM SigOpCdI" + ;
                " WHERE RTRIM(dopes) = RTRIM(" + EscaparSQL(loc_cDopes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgJobTmp")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar a parametriza" + CHR(231) + CHR(227) + "o da opera" + ;
                        CHR(231) + CHR(227) + "o " + loc_cDopes + ":" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT cursor_4c_CfgJobTmp
                GO TOP
                IF !EOF("cursor_4c_CfgJobTmp")
                    THIS.this_cJobMvObr = TratarNulo(cursor_4c_CfgJobTmp.job_mv_obr, "")
                    THIS.this_cJobMvTit = TratarNulo(cursor_4c_CfgJobTmp.job_mv_tit, "")
                    THIS.this_cJobMvCpo = TratarNulo(cursor_4c_CfgJobTmp.job_mv_cpo, "")
                ENDIF
                USE IN cursor_4c_CfgJobTmp
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarConfiguracaoJob")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CampoObrigatorio - O campo de indice par_nIndice da lista do
    * ChecaObrigs e obrigatorio nesta operacao?
    *
    * Transcricao de "Int(Val(Substr(Nvl(crSigOpCdI.JOB_MV_OBR, []),
    * lnCnt, 1))) = 1" (o legado escreve a condicao NEGADA, "<> 1", porque
    * la ela entra somada ao teste de preenchimento).
    *
    * Posicao fora do texto carregado devolve .F. - SUBSTR de alem do fim
    * devolve "", VAL("") da 0 e 0 nao e' 1. Explicito aqui para a leitura
    * nao depender desse encadeamento.
    *==========================================================================
    FUNCTION CampoObrigatorio(par_nIndice)
        LOCAL loc_cMarca

        IF VARTYPE(par_nIndice) != "N"
            RETURN .F.
        ENDIF
        IF par_nIndice < 1
            RETURN .F.
        ENDIF
        IF par_nIndice > LEN(THIS.this_cJobMvObr)
            RETURN .F.
        ENDIF

        loc_cMarca = SUBSTR(THIS.this_cJobMvObr, par_nIndice, 1)
        RETURN (INT(VAL(loc_cMarca)) = 1)
    ENDFUNC

    *==========================================================================
    * ObterTituloPersonalizado - Bloco de 50 caracteres de job_mv_tit na
    * posicao par_nPos, ja com ALLTRIM - transcricao de
    * "Alltrim(Substr(Nvl(crSigOpCdI.JOB_MV_TIT, []), <pos>, 50))".
    *
    * Devolve "" quando a operacao nao personaliza aquele titulo; o chamador
    * so sobrescreve o Caption quando vem texto (o legado tambem cerca cada
    * atribuicao com "If Not Empty(...)").
    *==========================================================================
    FUNCTION ObterTituloPersonalizado(par_nPos)
        IF VARTYPE(par_nPos) != "N"
            RETURN ""
        ENDIF
        RETURN ALLTRIM(SUBSTR(THIS.this_cJobMvTit, par_nPos, 50))
    ENDFUNC

    *==========================================================================
    * ObterRotuloPersonalizado - Irmao de ObterTituloPersonalizado para
    * job_mv_cpo (rotulo de CAMPO). O unico site no SCX legado e a posicao
    * 3351, que renomeia o "Briefing Extra" da raiz do form.
    *==========================================================================
    FUNCTION ObterRotuloPersonalizado(par_nPos)
        IF VARTYPE(par_nPos) != "N"
            RETURN ""
        ENDIF
        RETURN ALLTRIM(SUBSTR(THIS.this_cJobMvCpo, par_nPos, 50))
    ENDFUNC

    *==========================================================================
    * CarregarDivisaoNotas - Le SigCdEmp.divnotas da empresa do movimento,
    * que decide quais blocos de equipe aparecem na Page3.
    *
    * Transcricao do trecho do Init legado:
    *   .poDataMgr.CursorQuery([SigCdEmp], [LocalEmps], [Cemps],
    *                          TprMvCab.Emps, [DivNotas])
    *   lnEmp = Iif(Eof([LocalEmps]), 1, LocalEmps.DivNotas)
    *
    * ATENCAO ao nome da coluna de empresa: em SigCdEmp e' "cemps" COM C
    * (regra #48 - o prefixo da tabela nao decide, so o schema). Conferido
    * em docs/schema.sql.
    *
    * Empresa nao encontrada / sem conexao mantem o default 1, igual ao
    * Iif(Eof(...), 1, ...) do legado.
    *==========================================================================
    PROCEDURE CarregarDivisaoNotas(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmps, loc_oErro
        loc_lSucesso = .F.

        THIS.this_nDivNotas = 1

        loc_cEmps = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")

        *-- RETURN fora do TRY (regra #1)
        IF EMPTY(loc_cEmps)
            RETURN .F.
        ENDIF
        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_DivNotasTmp")
                IF CURSORGETPROP("Buffering", "cursor_4c_DivNotasTmp") > 1
                    TABLEREVERT(.T., "cursor_4c_DivNotasTmp")
                ENDIF
                USE IN cursor_4c_DivNotasTmp
            ENDIF

            loc_cSQL = "SELECT divnotas FROM SigCdEmp" + ;
                " WHERE RTRIM(cemps) = RTRIM(" + EscaparSQL(loc_cEmps) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DivNotasTmp")

            IF loc_nResultado < 0
                MsgErro("Erro ao consultar a divis" + CHR(227) + "o de notas da empresa " + ;
                        loc_cEmps + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT cursor_4c_DivNotasTmp
                GO TOP
                IF !EOF("cursor_4c_DivNotasTmp")
                    THIS.this_nDivNotas = TratarNulo(cursor_4c_DivNotasTmp.divnotas, 1)
                ENDIF
                USE IN cursor_4c_DivNotasTmp
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDivisaoNotas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
