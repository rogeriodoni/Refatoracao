*============================================================================
* SigOpCfaBO.prg - Business Object para Pesquisa de Falhas por Fase
*
* Form OPERACIONAL de consulta/apuracao - nao existe tabela de cadastro
* "SigOpCfa" no schema. O processamento cruza:
*   SigCdFcx (ficha de controle)  x  SigOpCfe (apontamento por fase)
*   x  SigCdCli (contas)  x  SigCdCle (classificacao/rateio de fase)
* para apurar entradas, saidas, falha real, falha admitida e indice de
* produtividade por fase/conta, num periodo e material informados.
*
* Tabela: (nenhuma - consulta parametrizada, sem persistencia propria)
*
* Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao com
* mensagem clara) ja eh o correto para este BO, porque nao ha NENHUMA
* tabela proprietaria para gravar (regra CLAUDE.md "BO somente-leitura").
* ObterChavePrimaria() tambem nao se aplica - a tela nao exibe/edita um
* registro de tabela, ela monta um cursor de apuracao (TmpSaldo/
* cursor_4c_Saldos) a partir de uma pesquisa.
*
* Fase 2/8 - no lugar do CRUD generico, as operacoes de dados deste BO sao
* as que o Click de "Processa" e o metodo "Impress?o" do legado executam:
*
*   PrepararCursorSaldos()    deixa cursor_4c_Saldos pronto e VAZIO, com a
*                             MESMA estrutura e os MESMOS indices do
*                             "Create Cursor TmpSaldo" do Load legado (ZAP
*                             quando ja existe, para nao derrubar o binding
*                             do Grid - igual ao "Select TmpSaldo / Zap").
*   CarregarDoCursor()        linha corrente de cursor_4c_Saldos ->
*                             propriedades de linha; eh o
*                             Grade.AfterRowColChange do legado
*                             (Get_Descr.Value = TmpSaldo.Rclis).
*   MontarCursorCabecalho()   cria e popula TmpCabec (Titulo/SubTitulo/
*                             Empresa) do metodo "Impress?o", exigido pelo
*                             FRX.
*   ProcessarPesquisa()       Processa.Click: cruza SigCdFcx x SigOpCfe x
*                             SigCdCli, filtra por Grupo/Conta em memoria,
*                             rateia pelo Setor de SigCdCle e agrega
*                             Entradas/Saidas/FReal/FAdmin/Pesagem/IndProd
*                             por Fase (ou Fase+Conta ou Fase+Conta+Dia,
*                             conforme optImp), com as duas linhas finais
*                             de separador e totais.
*   ObterDescricaoEmpresa()  CursorQuery('SigCdEmp','crSigCdEmp','Cemps',
*                             _Empr,'Razas') do metodo Impress?o, que monta
*                             o cabecalho do relatorio/planilha.
*
* Fase 8/8 - a parte do metodo "Impress?o" legado que dispara o relatorio
* (ramos lcSaida = 'V'/'I' - a exportacao Excel/TXT fica no Form, que eh
* quem chama PutFile):
*
*   ExecutarReportForm()      REPORT FORM propriamente, com o isolamento de
*                             locale/REPORTBEHAVIOR e a restauracao de menu
*                             do padrao canonico do projeto.
*   ExibirRelatorio()         monta TmpCabec, confere "Set Order To SeqFase
*                             / Go Top / If Eof()" em cursor_4c_Saldos (a
*                             MESMA guarda vale para V/I/E) e, em V/I,
*                             escolhe SigOpCf2.frx (optImp=3, Grupo+Conta+
*                             Balanco) ou SigOpCfa.frx (demais opcoes).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init | Completado na Fase 2 - Metodos
*           | Fase 8 - ExecutarReportForm/ExibirRelatorio
*============================================================================

DEFINE CLASS SigOpCfaBO AS BusinessBase

    *==========================================================================
    * Propriedades dos filtros de pesquisa (espelham os controles da tela)
    *==========================================================================
    this_cMaterial        = ""    && char(14) - codigo do produto/material (Get_Mat)
    this_cDescMaterial    = ""    && char(40) - descricao do produto/material (Get_DMat)
    this_dDataInicial     = {}    && date     - data inicial do periodo (Get_Datai)
    this_dDataFinal       = {}    && date     - data final do periodo (Get_Dataf)
    this_cGrupo           = ""    && char(10) - codigo do grupo/fase filtrado (Get_grupo)
    this_cDescGrupo       = ""    && char(20) - descricao do grupo/fase (Get_Dgrupo)
    this_cConta           = ""    && char(10) - codigo da conta filtrada (Get_conta)
    this_cDescConta       = ""    && char(40) - descricao da conta (Get_dConta)
    this_nTipoRelatorio   = 1     && numeric  - 1=Grupo 2=Grupo+Conta 3=Grupo+Conta+Balanco (optImp.Value)
    this_cDescricaoLinha  = ""    && char(40) - descricao da linha corrente da grade (Get_Descr)
    this_cFaseLinha       = ""    && char(10) - Fase  da linha corrente da grade (cursor_4c_Saldos.Fase)
    this_cContaLinha      = ""    && char(10) - Conta da linha corrente da grade (cursor_4c_Saldos.Conta)

    *==========================================================================
    * Cursores utilizados pelo processamento (equivalentes aos do legado)
    *==========================================================================
    this_cCursorDados    = "cursor_4c_Saldos"    && equivalente a TmpSaldo (grade de resultado)
    this_cCursorFcx       = "cursor_4c_Fcx"        && equivalente a crSigCdFcx (SQL cruzado)
    this_cCursorClaes      = "cursor_4c_Claes"      && equivalente a CrTmpClaes (classificacao/rateio)
    this_cCursorEmpresa    = "cursor_4c_Empresa"    && equivalente a crSigCdEmp (cabecalho do relatorio)

    *-- O cursor do cabecalho MANTEM o nome legado "TmpCabec" de proposito: as
    *-- expressoes do FRX SigOpCfa.frx referenciam o alias EXPLICITAMENTE
    *-- (TmpCabec.Titulo / TmpCabec.SubTitulo - conferido no .frt). Renomear
    *-- para o padrao cursor_4c_* faria o relatorio abortar com
    *-- "Alias TMPCABEC is not found". Mesmo tratamento de sigreanrBO.
    this_cCursorCabecalho  = "TmpCabec"             && equivalente a TmpCabec (exigido pelo FRX)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form operacional sem tabela de cadastro: nao ha operacao de CRUD
    * (Inserir/Atualizar/ExecutarExclusao) a sobrescrever. O comportamento
    * padrao herdado de BusinessBase para essas operacoes ja eh o correto.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararCursorSaldos - deixa cursor_4c_Saldos pronto e VAZIO, com a MESMA
    * ordem de campos e os MESMOS indices do "Create Cursor TmpSaldo" do Load
    * legado. E' PUBLIC porque o Form o chama de fora (na abertura, para ligar
    * o Grid ao cursor ainda vazio, como o legado liga a Grade a TmpSaldo no
    * Load) - metodo chamado de fora NUNCA pode ser PROTECTED (regra #51).
    *
    * Cursor JA existente eh limpo com ZAP, nao fechado e recriado: fechar o
    * alias (USE IN + CREATE CURSOR) derruba Grid.RecordSource e as
    * Column.ControlSource ligadas na abertura do Form, e a grade fica
    * permanentemente vazia com o cursor cheio - sem erro e sem log. O legado
    * faz "Select TmpSaldo / Zap" exatamente por isso.
    *
    * O ZAP vai cercado de SET SAFETY OFF: SAFETY eh escopado por data session
    * e volta a ON dentro de form com DataSession = 2 (mesmo mecanismo da regra
    * #9.4), onde o ZAP abriria o dialogo "Are you sure?" e CONGELARIA a tela.
    *
    * Ponto UNICO de criacao do cursor (CLAUDE.md exige estrutura IDENTICA em
    * todos os pontos que criam o mesmo cursor - com um ponto so nao ha como
    * divergir).
    *==========================================================================
    PROCEDURE PrepararCursorSaldos()
        LOCAL loc_cSafety

        IF USED(THIS.this_cCursorDados) ;
                AND TYPE(THIS.this_cCursorDados + ".Seqs") == "C" ;
                AND TYPE(THIS.this_cCursorDados + ".IndProds") == "N"
            *-- Estrutura esperada ja esta no lugar: so limpa os registros,
            *-- preservando os indices e o binding do Grid.
            SELECT (THIS.this_cCursorDados)

            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            ZAP
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorDados) ;
                (Fase C(10), Conta C(10), Rclis C(40), Entradas N(12,2), Saidas N(12,2), ;
                 Pesagems N(12,2), FReals N(12,2), FAdmins N(12,2), fTotals N(12,2), ;
                 Seqs C(1), pFalhas N(8,2), IndProds N(12,3), Codigos N(6), Datas D)

            INDEX ON Seqs + Fase + Conta + STR(Codigos, 6) TAG SeqFase
            INDEX ON Fase + Conta + STR(Codigos) TAG Fase
        ENDIF

        SELECT (THIS.this_cCursorDados)
        SET ORDER TO TAG Fase

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ProcessarPesquisa - equivalente ao SIGOPCFA.Processa.Click.
    *
    * Le os filtros diretamente das propriedades (this_cMaterial,
    * this_dDataInicial, this_dDataFinal, this_cGrupo, this_cConta,
    * this_nTipoRelatorio), que o Form sincroniza a partir da tela ANTES de
    * chamar este metodo (mesmo padrao de FormParaBO).
    *
    * As validacoes de UI (SetFocus) ficam no Form; aqui fica a MESMA
    * checagem de conteudo (material obrigatorio, periodo invertido), como
    * rede de seguranca - este metodo pode ser chamado de qualquer lugar.
    *
    * _Empr (global legada) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md
    * "_EMPR: LEGACY - NEVER use"). fDtoSQL do legado -> FormatarDataSQL()
    * (helper padrao do projeto, regra CLAUDE.md #5); Data Final recebe
    * hora 23:59:59 para fechar o dia inteiro, igual a
    * fDtoSQL(ldDataFim, '23:59:59') do legado.
    *
    * Cascata fiel ao legado: 1) cruza SigCdFcx x SigOpCfe x SigCdCli para
    * o material e periodo informados; 2) por linha, filtra Grupo/Conta EM
    * MEMORIA (nao no WHERE do SQL - o legado faz exatamente assim); 3)
    * resolve o Setor via SigCdCle (rateio fase->setor); 4) monta a chave
    * de agrupamento conforme this_nTipoRelatorio (1=Grupo, 2=Grupo+Conta,
    * 3=Grupo+Conta+Dia) e agrega Entradas/Saidas/FReal/FAdmin/Pesagem/
    * IndProd na linha correspondente de cursor_4c_Saldos; 5) ao final,
    * acrescenta a linha separadora (Seqs='1') e a linha de totais
    * (Seqs='2'), e recalcula fTotals em TODAS as linhas - exatamente como
    * o legado, inclusive as duas linhas extras serem adicionadas de forma
    * INCONDICIONAL (mesmo sem nenhuma falha encontrada).
    *
    * Retorno: .T. se o processamento rodou sem erro de SQL/validacao (o
    * cursor pode legitimamente ficar so com as 2 linhas de totais, zeradas,
    * quando a pesquisa nao encontra nenhuma falha - o mesmo que acontece
    * no legado). .F. com THIS.this_cMensagemErro preenchido quando faltou
    * preencher o material, o periodo esta invertido ou algum SQLEXEC falhou.
    *==========================================================================
    PROCEDURE ProcessarPesquisa()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cDtInicio, loc_cDtFim
        LOCAL loc_tDataFinal, loc_cGrupo2, loc_cChave, loc_nFalha, loc_oErro
        LOCAL loc_nTotFReal, loc_nTotFAdm, loc_nTotSaida, loc_nTotEnt, loc_nTotPsg, loc_nTotIndProd
        LOCAL loc_cExact, loc_cFiltroGrupo, loc_cFiltroConta, loc_cGrupoLinha, loc_cContaLinha

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        *-- SET EXACT eh ON no startup (start\config.prg) e com ON o SEEK exige
        *-- a chave INTEIRA do indice: a chave de agrupamento montada aqui eh
        *-- PARCIAL (Fase, ou Fase+Conta, contra o indice Fase+Conta+STR(Codigos)),
        *-- entao TODO SEEK falharia e cada linha da consulta viraria uma linha
        *-- nova na grade, em vez de somar na linha do grupo. O legado Fortyus
        *-- roda com EXACT OFF. Guardado e restaurado no fim do metodo.
        loc_cExact = SET("EXACT")
        SET EXACT OFF

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cMaterial, "")))
                loc_lSucesso = .F.
                THIS.this_cMensagemErro = "O Produto Deve Ser Informado!!!"
            ELSE
                *-- O legado NAO exige periodo preenchido: so compara as duas
                *-- datas. Data vazia vira NULL no SQL (FormatarDataSQL) e a
                *-- consulta volta sem linhas, igual ao legado - NAO inventar
                *-- aqui uma obrigatoriedade que a tela original nao tem.
                IF THIS.this_dDataFinal < THIS.this_dDataInicial
                    loc_lSucesso = .F.
                    THIS.this_cMensagemErro = "Data Final Deve Ser Maior Que a Data Inicial!!!"
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.PrepararCursorSaldos()

                loc_cFiltroGrupo = ALLTRIM(TratarNulo(THIS.this_cGrupo, ""))
                loc_cFiltroConta = ALLTRIM(TratarNulo(THIS.this_cConta, ""))

                *-- fDtoSQL(ldDataFim, '23:59:59') do legado: a data final fecha
                *-- o dia INTEIRO, senao a coluna datetime perde os lancamentos
                *-- do ultimo dia com hora. DATETIME() exige ano/mes/dia validos
                *-- (com data vazia dispara erro 11), por isso o guard - com data
                *-- vazia FormatarDataSQL devolve NULL e a consulta nao traz
                *-- linha, que eh o mesmo resultado do legado.
                loc_cDtInicio = FormatarDataSQL(ConverterParaData(THIS.this_dDataInicial))

                IF EMPTY(ConverterParaData(THIS.this_dDataFinal))
                    loc_cDtFim = "NULL"
                ELSE
                    loc_tDataFinal = DATETIME(YEAR(ConverterParaData(THIS.this_dDataFinal)), ;
                        MONTH(ConverterParaData(THIS.this_dDataFinal)), ;
                        DAY(ConverterParaData(THIS.this_dDataFinal)), 23, 59, 59)
                    loc_cDtFim = FormatarDataSQL(loc_tDataFinal)
                ENDIF

                IF USED(THIS.this_cCursorFcx)
                    USE IN (THIS.this_cCursorFcx)
                ENDIF

                loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, b.CPros, b.Entradas, b.Saldos," + ;
                           " b.Saidas, b.Pesagems, b.FReals, b.FAdmins, b.cIdChaves, a.Contas," + ;
                           " c.Rclis, b.IndProds, a.Datas" + ;
                           " FROM SigCdFcx a, SigOpCfe b, SigCdCli c" + ;
                           " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                           " AND a.Datas BETWEEN " + loc_cDtInicio + " AND " + loc_cDtFim + ;
                           " AND a.Emps = b.Emps AND a.Codigos = b.Codigos" + ;
                           " AND b.Cpros = " + EscaparSQL(THIS.this_cMaterial) + ;
                           " AND a.Contas = c.Iclis" + ;
                           " ORDER BY a.Emps, a.Codigos, a.Grupos, b.CPros, b.Entradas, b.Saldos," + ;
                           " b.Saidas, b.Pesagems, b.FReals, b.FAdmins, b.cIdChaves, a.Contas, c.Rclis"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFcx)

                IF loc_nResultado < 1
                    loc_lSucesso = .F.
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdFcx)" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT (THIS.this_cCursorFcx)
                    SCAN
                        *-- Filtro de Grupo/Conta em MEMORIA, nao no WHERE do SQL
                        *-- (o legado faz exatamente assim). Comparacao com "=="
                        *-- (exata) porque o SET EXACT esta OFF neste metodo por
                        *-- causa do SEEK parcial: com "!=" e EXACT OFF, grupo
                        *-- "1" casaria com "100" e traria linha de outro grupo.
                        loc_cGrupoLinha = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorFcx + ".Grupos"), ""))
                        loc_cContaLinha = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorFcx + ".Contas"), ""))

                        IF (!EMPTY(loc_cFiltroGrupo) AND !(loc_cGrupoLinha == loc_cFiltroGrupo)) ;
                                OR (!EMPTY(loc_cFiltroConta) AND !(loc_cContaLinha == loc_cFiltroConta))
                            LOOP
                        ENDIF

                        loc_cSQL = "SELECT Setors" + ;
                                   " FROM SigCdCle" + ;
                                   " WHERE ClaGrupos = " + EscaparSQL(EVALUATE(THIS.this_cCursorFcx + ".Grupos")) + ;
                                   " AND ClaContas = " + EscaparSQL(EVALUATE(THIS.this_cCursorFcx + ".Contas"))

                        IF USED(THIS.this_cCursorClaes)
                            USE IN (THIS.this_cCursorClaes)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorClaes)

                        IF loc_nResultado < 1
                            loc_lSucesso = .F.
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdCle)" + ;
                                CHR(13) + CapturarErroSQL()
                            EXIT
                        ENDIF

                        loc_cGrupo2 = EVALUATE(THIS.this_cCursorFcx + ".Grupos")
                        IF RECCOUNT(THIS.this_cCursorClaes) > 0
                            loc_cGrupo2 = EVALUATE(THIS.this_cCursorClaes + ".Setors")
                        ENDIF

                        loc_cChave = loc_cGrupo2
                        DO CASE
                            CASE THIS.this_nTipoRelatorio = 2 && Grupo + Conta
                                loc_cChave = loc_cGrupo2 + EVALUATE(THIS.this_cCursorFcx + ".Contas")
                            CASE THIS.this_nTipoRelatorio = 3 && Grupo + Conta + Balanco
                                loc_cChave = loc_cGrupo2 + EVALUATE(THIS.this_cCursorFcx + ".Contas") + ;
                                    STR(EVALUATE(THIS.this_cCursorFcx + ".Codigos"), 6)
                        ENDCASE

                        IF !SEEK(loc_cChave, THIS.this_cCursorDados)
                            INSERT INTO (THIS.this_cCursorDados) (Fase, Conta, Rclis, Codigos, Datas) VALUES ;
                                (loc_cGrupo2, ;
                                 IIF(INLIST(THIS.this_nTipoRelatorio, 2, 3), ;
                                     ALLTRIM(EVALUATE(THIS.this_cCursorFcx + ".Contas")), ""), ;
                                 IIF(INLIST(THIS.this_nTipoRelatorio, 2, 3), ;
                                     ALLTRIM(EVALUATE(THIS.this_cCursorFcx + ".Rclis")), ""), ;
                                 IIF(THIS.this_nTipoRelatorio = 3, ;
                                     EVALUATE(THIS.this_cCursorFcx + ".Codigos"), 0), ;
                                 IIF(THIS.this_nTipoRelatorio = 3, ;
                                     ConverterParaData(EVALUATE(THIS.this_cCursorFcx + ".Datas")), {}))
                        ENDIF

                        REPLACE Entradas WITH Entradas + EVALUATE(THIS.this_cCursorFcx + ".Entradas") + ;
                                    EVALUATE(THIS.this_cCursorFcx + ".Saldos"), ;
                                Saidas   WITH Saidas + EVALUATE(THIS.this_cCursorFcx + ".Saidas"), ;
                                FReals   WITH FReals + EVALUATE(THIS.this_cCursorFcx + ".FReals"), ;
                                FAdmins  WITH FAdmins + EVALUATE(THIS.this_cCursorFcx + ".FAdmins"), ;
                                Pesagems WITH Pesagems + EVALUATE(THIS.this_cCursorFcx + ".Pesagems"), ;
                                IndProds WITH IndProds + (EVALUATE(THIS.this_cCursorFcx + ".IndProds") - ;
                                    EVALUATE(THIS.this_cCursorFcx + ".FReals")) ;
                            IN (THIS.this_cCursorDados)

                        loc_nFalha = IIF(EVALUATE(THIS.this_cCursorDados + ".Saidas") = 0, 0, ;
                            (EVALUATE(THIS.this_cCursorDados + ".FReals") / ;
                             EVALUATE(THIS.this_cCursorDados + ".Saidas") * 100))
                        REPLACE pFalhas WITH loc_nFalha IN (THIS.this_cCursorDados)
                    ENDSCAN

                    IF loc_lSucesso
                        SELECT (THIS.this_cCursorDados)
                        APPEND BLANK
                        REPLACE Seqs WITH "1"

                        SUM FReals, FAdmins, Saidas, Entradas, Pesagems, IndProds ;
                            TO loc_nTotFReal, loc_nTotFAdm, loc_nTotSaida, loc_nTotEnt, loc_nTotPsg, loc_nTotIndProd

                        APPEND BLANK
                        REPLACE Seqs WITH "2", ;
                                Fase WITH "Total", ;
                                FReals WITH loc_nTotFReal, ;
                                FAdmins WITH loc_nTotFAdm, ;
                                Saidas WITH loc_nTotSaida, ;
                                Entradas WITH loc_nTotEnt, ;
                                Pesagems WITH loc_nTotPsg, ;
                                IndProds WITH loc_nTotIndProd

                        loc_nFalha = IIF(EVALUATE(THIS.this_cCursorDados + ".Saidas") = 0, 0, ;
                            (EVALUATE(THIS.this_cCursorDados + ".FReals") / ;
                             EVALUATE(THIS.this_cCursorDados + ".Saidas") * 100))
                        REPLACE pFalhas WITH loc_nFalha IN (THIS.this_cCursorDados)

                        REPLACE ALL fTotals WITH fReals - fAdmins IN (THIS.this_cCursorDados)

                        SELECT (THIS.this_cCursorDados)
                        SET ORDER TO TAG SeqFase
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorFcx)
            USE IN (THIS.this_cCursorFcx)
        ENDIF
        IF USED(THIS.this_cCursorClaes)
            USE IN (THIS.this_cCursorClaes)
        ENDIF

        *-- Restaura o SET EXACT do ambiente (vale tambem quando o CATCH disparou)
        IF loc_cExact = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDescricaoEmpresa - equivalente ao CursorQuery('SigCdEmp',
    * 'crSigCdEmp', 'Cemps', _Empr, 'Razas') feito no metodo Impress?o do
    * legado, que monta o cabecalho do relatorio/planilha (TmpCabec.Empresa)
    * com a razao social da empresa corrente.
    *
    * _Empr (global legada) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md
    * "_EMPR: LEGACY - NEVER use"). SigCdEmp.Cemps eh char(3) -> PADR(...,3).
    *
    * Retorna "" quando a empresa nao existe ou o SQL falha - equivalente ao
    * Iif(Eof('crSigCdEmp'), '', crSigCdEmp.Razas) do legado, que usa string
    * vazia como fallback silencioso (nao eh erro bloqueante: so afeta o
    * texto do cabecalho do relatorio).
    *==========================================================================
    PROCEDURE ObterDescricaoEmpresa()
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3))

            IF USED(THIS.this_cCursorEmpresa)
                USE IN (THIS.this_cCursorEmpresa)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmpresa)

            IF loc_nResultado >= 1 AND RECCOUNT(THIS.this_cCursorEmpresa) > 0
                loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorEmpresa + ".Razas"), ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        IF USED(THIS.this_cCursorEmpresa)
            USE IN (THIS.this_cCursorEmpresa)
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega a LINHA CORRENTE do cursor de apuracao para as
    * propriedades de linha do BO (hook padrao de BusinessBase: cursor ->
    * propriedades).
    *
    * Equivale ao Grade.AfterRowColChange do legado, que a cada troca de linha
    * faz "ThisForm.Get_Descr.Value = TmpSaldo.Rclis" - a descricao da conta da
    * linha selecionada aparece no campo de rodape da tela. Aqui a leitura do
    * cursor fica no BO e o Form apenas espelha this_cDescricaoLinha no
    * TextBox, em vez de ler o cursor direto da camada de UI.
    *
    * Fase e Conta vem junto porque sao a identificacao da linha no cursor
    * (as duas colunas que compoem a chave de agrupamento) - o Form usa para
    * saber QUAL linha esta selecionada sem reabrir o cursor.
    *
    * par_cAliasCursor eh opcional: sem ele usa cursor_4c_Saldos (o cursor da
    * grade), que eh o unico cursor de linha desta tela.
    *
    * Retorna .F. (e limpa as propriedades) quando o cursor nao existe, esta
    * vazio ou o ponteiro esta em EOF/BOF - o estado em que a tela abre, antes
    * do primeiro clique em Processar. Nas duas linhas que o legado acrescenta
    * no fim (separador e Total) a leitura ACONTECE e devolve .T.: Rclis eh
    * vazio nelas, e o campo de descricao da tela fica em branco - igual ao
    * legado, que atribui TmpSaldo.Rclis sem testar a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.

        loc_cAlias = THIS.this_cCursorDados
        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF

        THIS.this_cFaseLinha      = ""
        THIS.this_cContaLinha     = ""
        THIS.this_cDescricaoLinha = ""

        TRY
            IF USED(loc_cAlias)
                IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias) AND !BOF(loc_cAlias)
                    *-- TYPE() antes de ler: o alias pode existir com outra
                    *-- estrutura (PEMSTATUS nao vale para cursor - regra #61).
                    IF TYPE(loc_cAlias + ".Rclis") == "C" AND TYPE(loc_cAlias + ".Fase") == "C"
                        THIS.this_cFaseLinha      = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Fase"), ""))
                        THIS.this_cContaLinha     = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Conta"), ""))
                        THIS.this_cDescricaoLinha = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarCursorCabecalho - transcricao do bloco de cabecalho do metodo
    * "Impress?o" do legado:
    *
    *   Create Cursor TmpCabec (Titulo c(100), SubTitulo c(100), Empresa c(100))
    *   CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
    *   lcTitulo    = 'Falhas por Fase'
    *   lcSubTitulo = 'Material : ' + ... + Chr(13) + 'Periodo : ' + ... + ' - ' + ...
    *   Insert Into TmpCabec (Empresa, Titulo, SubTitulo) Values (...)
    *
    * O alias segue sendo TmpCabec porque o FRX referencia TmpCabec.Titulo e
    * TmpCabec.SubTitulo explicitamente (ver comentario da property
    * this_cCursorCabecalho). Os textos sao transcritos LITERALMENTE, com as
    * acentuacoes por CHR() (regra #4): CHR(237) = i-acute em "Per?odo".
    *
    * A razao social vem de ObterDescricaoEmpresa() (o CursorQuery do legado).
    * Empresa nao eh usada pelo SigOpCfa.frx, mas eh gravada igual ao legado -
    * a estrutura do cursor tem de continuar identica.
    *
    * Retorna .T. quando o cursor ficou criado e com a linha de cabecalho.
    *==========================================================================
    PROCEDURE MontarCursorCabecalho()
        LOCAL loc_lSucesso, loc_cTitulo, loc_cSubTitulo, loc_cEmpresa, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(100), SubTitulo C(100), Empresa C(100))

            loc_cTitulo = "Falhas por Fase"

            loc_cSubTitulo = "Material : " + ALLTRIM(TratarNulo(THIS.this_cMaterial, "")) + " - " + ;
                ALLTRIM(TratarNulo(THIS.this_cDescMaterial, "")) + CHR(13) + ;
                "Per" + CHR(237) + "odo : " + DTOC(ConverterParaData(THIS.this_dDataInicial)) + " - " + ;
                DTOC(ConverterParaData(THIS.this_dDataFinal))

            loc_cEmpresa = THIS.ObterDescricaoEmpresa()

            INSERT INTO (THIS.this_cCursorCabecalho) (Empresa, Titulo, SubTitulo) ;
                VALUES (LEFT(loc_cEmpresa, 100), LEFT(loc_cTitulo, 100), LEFT(loc_cSubTitulo, 100))

            GO TOP IN (THIS.this_cCursorCabecalho)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - dispara o REPORT FORM propriamente, com o mesmo
    * isolamento de locale/REPORTBEHAVIOR e restauracao de menu do padrao
    * canonico do projeto (ver SigReCgcBO.ExecutarReportForm). par_cModo:
    * "PREVIEW" (Report Form ... Preview NoConsole, legado lcSaida='V') ou
    * "PRINTER_PROMPT" (Report Form ... To PRINTER Prompt, legado lcSaida='I').
    *
    * O cursor-vazio e o cabecalho (TmpCabec) ja' foram checados/preparados
    * por THIS.ExibirRelatorio() - este metodo so cuida do REPORT FORM.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu apos preview (Erro63): REPORT FORM PREVIEW abre
        *-- toolbar propria que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExibirRelatorio - equivalente ao bloco "Select TmpSaldo / Set Order to
    * SeqFase / Go Top / If Eof() ... Else ... EndIf" do metodo "Impress?o"
    * do legado: monta TmpCabec e confere se ha linha em cursor_4c_Saldos -
    * essa MESMA guarda envolve os TRES destinos (V/I/E) no legado, por isso
    * vale igual para par_cSaida = "E" (so' depois dela o legado se ramifica
    * em Report Form / Report Form To PRINTER / exportacao de planilha).
    *
    * par_cSaida: "V" (preview), "I" (impressora, com prompt) ou "E" (so'
    * valida a guarda - quem exporta a planilha, com PutFile/Copy To, eh o
    * Form, que eh o dono dos dialogos de UI). Para "V"/"I", escolhe o FRX
    * certo - SigOpCf2 quando this_nTipoRelatorio = 3 (Grupo + Conta +
    * Balanco), SigOpCfa nos outros dois modos - exatamente o "If
    * ThisForm.optImp.Value = 3" do legado.
    *
    * TmpCabec fica aberto DURANTE o REPORT FORM (o FRX referencia
    * TmpCabec.Titulo/TmpCabec.SubTitulo explicitamente) e so' e' fechado no
    * fim deste metodo - igual ao "Use In TmpCabec" que fecha o bloco inteiro
    * do Impress?o legado, depois do If/Else (fica aberto tambem durante o
    * ramo "E", sem uso - o legado faz exatamente isso, de forma
    * incondicional).
    *
    * Retorna .T. quando a guarda passou (e, para V/I, o relatorio foi
    * disparado); .F. com THIS.this_cMensagemErro preenchido quando nao ha
    * linha selecionada ou algo falhou (cabecalho/SQL/FRX ausente).
    *==========================================================================
    PROCEDURE ExibirRelatorio(par_cSaida)
        LOCAL loc_lSucesso, loc_cFrx, loc_cModo, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.MontarCursorCabecalho()
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cCursorDados)
                    THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                ELSE
                    SELECT (THIS.this_cCursorDados)
                    SET ORDER TO TAG SeqFase
                    GO TOP

                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                    ELSE
                        DO CASE
                            CASE par_cSaida == "V" OR par_cSaida == "I"
                                loc_cFrx  = IIF(THIS.this_nTipoRelatorio = 3, "SigOpCf2", "SigOpCfa")
                                loc_cModo = IIF(par_cSaida == "V", "PREVIEW", "PRINTER_PROMPT")
                                loc_lSucesso = THIS.ExecutarReportForm(loc_cFrx, loc_cModo)

                            CASE par_cSaida == "E"
                                *-- Guarda passou - a exportacao em si (PutFile +
                                *-- fVerificaPasta + Copy To) fica no Form, que
                                *-- eh quem exibe os dialogos de UI.
                                loc_lSucesso = .T.
                        ENDCASE
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
