*============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB (remessa
* bancaria) e emissao de boletos/relatorio dos titulos selecionados
*
* Origem legado: SIGPRCNB.SCX ("Geracao de Arquivos CNAB")
* Form OPERACIONAL: pagina de Filtros (empresa, periodo, conta/carteira,
* titulo do banco, operacoes a processar) + pagina de Dados (grade de
* titulos em aberto, com selecao individual e geracao do arquivo CNAB nos
* layouts Bradesco/Itau/Itau240/Brasil/Brasil6/Santander/Santander240).
*
* Tabela de controle: SigPcOol - a cada arquivo CNAB gerado o legado grava
* um registro de controle (Tipos = 'SIGPRCNB', Processos = 'CNAB') usado
* para NAO reprocessar o mesmo titulo numa proxima geracao (subquery
* "EmpDopNums + titulos NOT IN (Select ... From SigPcOol ...)" em
* PROCEDURE processamento). Nao ha tela de cadastro para SigPcOol - o
* "CRUD" deste BO eh o proprio processo de geracao do arquivo.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro - espelham os campos da pagina Filtros
    * (Thisform.pgfprincipal.pgfiltro no legado)
    *==========================================================================
    this_cCodEmpresa        = ""   && get_cd_empresa - SigCdEmp.Cemps char(3)
    this_cNomeEmpresa       = ""   && get_ds_empresa  - SigCdEmp.RazSocs (somente exibicao)
    this_dDataInicial       = {}   && Get_Datai - inicio do periodo (vencimento ou emissao)
    this_dDataFinal         = {}   && Get_Dataf - fim do periodo
    this_cContaCarteira     = ""   && get_cd_car_conta - SigCdCli.IClis (conta/carteira do banco)
    this_cContaCarteiraDesc = ""   && get_ds_car_conta - SigCdCli.RClis (somente exibicao)
    this_nProcessados       = 1    && optProcessados.Value: 1=Nao Processados, 2=Ja Processadas
    this_nPeriodo           = 1    && optPeriodo.Value: 1=Vencimento, 2=Emissao
    this_cTituloBanco       = ""   && Get_titban - texto gravado no arquivo/boleto (nao persistido)
    this_nDiasProtesto      = 5    && spndias.Value - dias p/ protesto (default SigCdCeb.DiasProts)
    this_cOperacoesMarcadas = ""   && lista "(dopes1,dopes2,...)" das operacoes (SigCdOpe) marcadas
                                    && no grid de filtro (crSigCdOpe.marca), usada no IN() do SQL

    *==========================================================================
    * Propriedades de apoio a geracao do arquivo CNAB / boleto (Fase 8) -
    * estado transitorio calculado por ObterDadosEmpresa/ObterConvenio e
    * consumido por GerarCnab*/ImprimirBoleto/pelo Form (nao persistido).
    *==========================================================================
    this_cCodEmpresaAtual    = ""  && empresa da geracao em curso (Get_Cd_Empresa)
    this_cContaCarteiraAtual = ""  && conta/carteira da geracao em curso (get_cd_car_conta)
    this_cRazSocsEmpresa     = ""  && SigCdEmp.RazSocs da empresa (cabecalho do CNAB)
    this_cCgcsEmpresa        = ""  && SigCdEmp.Cgcs da empresa (cabecalho do CNAB)
    this_cBancoConvenio      = ""  && SigCdCeb.NBancos do convenio da conta (dispatch de layout)
    this_nDiasProtestoConvenio = 0 && SigCdCeb.DiasProts do convenio (default do spinner de dias)
    this_cUltimoArquivoGerado  = "" && caminho do ultimo arquivo CNAB gravado (mensagem de sucesso)
    this_cCursorBoleto         = "" && alias do cursor pronto para o REPORT FORM do boleto (Form imprime)

    *==========================================================================
    * Propriedades do registro de controle gravado em SigPcOol a cada
    * arquivo CNAB gerado ("Insert Into crSigPcOol ..." nos metodos
    * cnabbradesco/cnabitau/cnabbrasil/cnabbrasil6/cnabsantander/
    * cnabsantander240/cnabitau240). Regra CLAUDE.md #22: TODAS as colunas
    * NOT NULL da tabela precisam de property, mesmo as que o legado nunca
    * cita (empds/edndests/nopers - existiam so no registro em branco do
    * AddCursor do legado).
    *==========================================================================
    this_cTipos       = "SIGPRCNB" && tipos       char(10)      NOT NULL - identificador fixo do processo
    this_cEmps        = ""         && emps        char(3)       NOT NULL - empresa do titulo (crFiltro2.Emps)
    this_cDopes       = ""         && dopes       char(20)      NOT NULL - documento/operacao (crFiltro2.Dopes)
    this_nNumes       = 0          && numes       numeric(6,0)  NOT NULL - numero do titulo (crFiltro2.Numes)
    this_cEmpDs       = ""         && empds       char(3)       NOT NULL - nao citado no INSERT legado
    this_cDopeDs      = ""         && dopeds      char(20)      NOT NULL - titulo do banco (crFiltro2.Titulos)
    this_nNumeDs      = 0          && numeds      numeric(11,0) NOT NULL - sequencial do arquivo (lcSeqNum)
    this_dDatas       = {}         && datas       datetime      NULL     - data/hora da geracao (Datetime())
    this_cUsuars      = ""         && usuars      char(10)      NOT NULL - usuario logado (Usuar)
    this_cProdutos    = ""         && produtos    text          NULL     - conteudo do arquivo CNAB (lcStr)
    this_cCidChaves   = ""         && cidchaves   char(20)      NOT NULL - PK Fortyus (fUniqueIds())
    this_cEndDests    = ""         && edndests    char(29)      NOT NULL - nao citado no INSERT legado
    this_cEmpDopNums  = ""         && empdopnums  char(29)      NOT NULL - chave do titulo (crFiltro2.EmpDopNums)
    this_cProcessos   = "CNAB"     && processos   char(20)      NOT NULL - identificador fixo do lote
    this_nNopers      = 0          && nopers      numeric(9,0)  NOT NULL - nao citado no INSERT legado

    *==========================================================================
    * Init - Business Object com tabela de controle SigPcOol (sem tela de
    * cadastro - a chave e o campo chave sao usados apenas pelo mecanismo
    * de auditoria/DataAccess herdado de BusinessBase).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPcOol"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves (PK Fortyus) do registro de
    * controle atual, usado por RegistrarAuditoria() e por Atualizar()/
    * ExecutarExclusao() no WHERE.
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - carrega as propriedades a partir de um cursor com as
    * colunas de SigPcOoL (SELECT * FROM SigPcOoL ou cursor equivalente).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    * REGRA CRITICA (TratarNulo): o 2o argumento eh o VALOR PADRAO da coluna,
    * NUNCA um codigo de tipo - "" para char/text, 0 para numeric, {} para
    * datetime (memoria feedback_tratarnulo_2o_arg_eh_valor_padrao).
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipos       = TratarNulo(tipos,      "")
                THIS.this_cEmps        = TratarNulo(emps,       "")
                THIS.this_cDopes       = TratarNulo(dopes,      "")
                THIS.this_nNumes       = TratarNulo(numes,      0)
                THIS.this_cEmpDs       = TratarNulo(empds,      "")
                THIS.this_cDopeDs      = TratarNulo(dopeds,     "")
                THIS.this_nNumeDs      = TratarNulo(numeds,     0)
                THIS.this_dDatas       = TratarNulo(datas,      {})
                THIS.this_cUsuars      = TratarNulo(usuars,     "")
                THIS.this_cProdutos    = TratarNulo(produtos,   "")
                THIS.this_cCidChaves   = TratarNulo(cidchaves,  "")
                THIS.this_cEndDests    = TratarNulo(edndests,   "")
                THIS.this_cEmpDopNums  = TratarNulo(empdopnums, "")
                THIS.this_cProcessos   = TratarNulo(processos,  "")
                THIS.this_nNopers      = TratarNulo(nopers,     0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - grava UM registro de controle em SigPcOoL. Eh chamado uma vez
    * por titulo processado no arquivo CNAB (mesmo padrao do legado, que
    * executa "Insert Into crSigPcOol ... Values (..., fUniqueIds(), ...)"
    * dentro do Scan de cada layout bancario - cnabbradesco/cnabitau/
    * cnabbrasil/cnabbrasil6/cnabsantander/cnabsantander240/cnabitau240).
    *
    * cidchaves (PK Fortyus, regra CLAUDE.md #22) e datas SAO GERADOS AQUI,
    * sempre, e sobrescrevem qualquer valor que a chamadora tenha setado -
    * cada Inserir() eh um registro NOVO e distinto, igual ao legado gerar
    * fUniqueIds()/Datetime() a cada volta do loop. Reaproveitar a chave
    * entre duas chamadas faria a segunda colidir no indice unico.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_dDatas     = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds,
                    dopeds, numeds, datas, usuars, produtos, cidchaves,
                    edndests, empdopnums, processos, nopers)
                VALUES (
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    <<EscaparSQL(THIS.this_cEmpDs)>>,
                    <<EscaparSQL(THIS.this_cDopeDs)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumeDs, 0)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cProdutos)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cEndDests)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cProcessos)>>,
                    <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro de controle CNAB:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza o registro de controle existente (localizado por
    * cidchaves). O legado nunca faz UPDATE em SigPcOol (soh Insert +
    * TableUpdate), mas o contrato de BusinessBase.Salvar() exige o metodo
    * para o caminho ALTERAR de um registro ja carregado via CarregarDoCursor.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPcOoL
                SET tipos      = <<EscaparSQL(THIS.this_cTipos)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    dopes      = <<EscaparSQL(THIS.this_cDopes)>>,
                    numes      = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDs)>>,
                    dopeds     = <<EscaparSQL(THIS.this_cDopeDs)>>,
                    numeds     = <<FormatarNumeroSQL(THIS.this_nNumeDs, 0)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    produtos   = <<EscaparSQL(THIS.this_cProdutos)>>,
                    edndests   = <<EscaparSQL(THIS.this_cEndDests)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    processos  = <<EscaparSQL(THIS.this_cProcessos)>>,
                    nopers     = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro de controle CNAB:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - exclui o registro de controle localizado por
    * cidchaves. Sem dependencias a checar (SigPcOoL nao eh referenciada por
    * FK de outra tabela do schema) - eh so o historico de arquivos gerados.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPcOoL WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir registro de controle CNAB:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosEmpresa - carrega Razao Social/CNPJ da empresa filtrada
    * (Thisform.poDataMgr.CursorQuery('SigCdEmp', 'crEmpresa', ...) dentro de
    * PROCEDURE geracnab no legado). Exige RazSocs e Cgcs preenchidos - sem
    * eles nao ha como montar o cabecalho do arquivo CNAB.
    *==========================================================================
    PROTECTED FUNCTION ObterDadosEmpresa(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_EmpCnab")
                USE IN cursor_4c_EmpCnab
            ENDIF

            loc_cSQL = "SELECT RazSocs, Cgcs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCnab")

            IF loc_nResultado > 0 AND USED("cursor_4c_EmpCnab") AND !EOF("cursor_4c_EmpCnab") ;
                    AND !EMPTY(ALLTRIM(NVL(cursor_4c_EmpCnab.RazSocs, ""))) ;
                    AND !EMPTY(ALLTRIM(NVL(cursor_4c_EmpCnab.Cgcs, "")))
                THIS.this_cRazSocsEmpresa = ALLTRIM(cursor_4c_EmpCnab.RazSocs)
                THIS.this_cCgcsEmpresa    = ALLTRIM(cursor_4c_EmpCnab.Cgcs)
                loc_lSucesso = .T.
            ELSE
                MsgAviso("N" + CHR(227) + "o Foi Encontrada a Raz" + CHR(227) + "o Social e/ou o CNPJ da Empresa [" + ;
                    par_cEmpresa + "]" + CHR(13) + ;
                    "Complete os Dados no Cadastro de Empresas e Tente Novamente!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF

            IF USED("cursor_4c_EmpCnab")
                USE IN cursor_4c_EmpCnab
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRCNBBO.ObterDadosEmpresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterConvenio - localiza o convenio bancario (SigCdCeb) da conta/
    * carteira selecionada (Thisform.poDataMgr.CursorQuery('SigCdCli',...) +
    * SqlExecute em SigCdCeb no legado). Mantem cursor_4c_Convenio ABERTO ate
    * o fim da geracao - os metodos GerarCnab*/ImprimirBoleto leem varios
    * campos dele qualificando o alias diretamente (cursor_4c_Convenio.xxx),
    * igual ao legado referenciar crConvenio.xxx sem depender da area ativa.
    *==========================================================================
    PROTECTED FUNCTION ObterConvenio(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGrupo, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_GrupoConta")
                USE IN cursor_4c_GrupoConta
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta), ;
                "cursor_4c_GrupoConta")

            loc_cGrupo = ""
            IF loc_nResultado > 0 AND USED("cursor_4c_GrupoConta") AND !EOF("cursor_4c_GrupoConta")
                loc_cGrupo = ALLTRIM(cursor_4c_GrupoConta.Grupos)
            ENDIF
            IF USED("cursor_4c_GrupoConta")
                USE IN cursor_4c_GrupoConta
            ENDIF

            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdCeb" + CHR(13) + ;
                       "WHERE GruContas = " + EscaparSQL(loc_cGrupo + par_cConta) + CHR(13) + ;
                       "  AND NAgencias <> SPACE(6)" + CHR(13) + ;
                       "  AND Convenios <> SPACE(9)" + CHR(13) + ;
                       "ORDER BY NAgencias, Convenios"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio")

            IF loc_nResultado > 0 AND USED("cursor_4c_Convenio") AND !EOF("cursor_4c_Convenio")
                GO TOP IN cursor_4c_Convenio
                THIS.this_cBancoConvenio        = ALLTRIM(cursor_4c_Convenio.NBancos)
                THIS.this_nDiasProtestoConvenio = IIF(EMPTY(NVL(cursor_4c_Convenio.DiasProts, 0)), 5, cursor_4c_Convenio.DiasProts)
                loc_lSucesso = .T.
            ELSE
                MsgAviso("N" + CHR(227) + "o Foi Encontrado o N" + CHR(250) + "mero da Ag" + CHR(234) + "ncia e/ou o C" + CHR(243) + ;
                    "digo do Conv" + CHR(234) + "nio Para" + CHR(13) + ;
                    "o Banco [" + par_cConta + "]!!! Complete os Dados no Cadastro de Contas!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRCNBBO.ObterConvenio")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarArquivoCnab - PROCEDURE geracnab(pTipo='A') no legado: gera o
    * arquivo de remessa bancaria (layout Bradesco/Itau/Brasil/Santander240
    * conforme o banco do convenio da conta/carteira) com os titulos
    * marcados no cursor de titulos da Pagina Dados. Chamado pelo botao
    * "Gerar CNAB".
    *
    * par_cCursorTitulos - alias do cursor de titulos (cursor_4c_Titulos),
    *   com coluna Marca indicando selecao e EndErro=1 ja desmarcado pelo
    *   Form (regra #21b/#42 - guardas de validacao sao parte da regra).
    *==========================================================================
    FUNCTION GerarArquivoCnab(par_cCursorTitulos, par_cEmpresa, par_cConta, par_cTituloBanco)
        LOCAL loc_nMarcados, loc_lSucesso, loc_cArquivoItau
        loc_lSucesso = .F.

        THIS.this_cCodEmpresaAtual    = par_cEmpresa
        THIS.this_cContaCarteiraAtual = par_cConta

        IF !USED(par_cCursorTitulos)
            RETURN .F.
        ENDIF

        SELECT (par_cCursorTitulos)
        COUNT FOR Marca TO loc_nMarcados
        IF loc_nMarcados = 0
            MsgAviso("Nenhum registro foi selecionado", "Aviso")
            RETURN .F.
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(par_cTituloBanco, "")))
            IF !MsgConfirma("Confirma gera" + CHR(231) + CHR(227) + "o do arquivo de remessa?", "Aviso")
                RETURN .F.
            ENDIF
        ELSE
            IF !MsgConfirma("O campo " + CHR(34) + "T" + CHR(237) + "tulo Banco" + CHR(34) + ;
                    " n" + CHR(227) + "o foi preenchido. Continuar?", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        IF !THIS.ObterDadosEmpresa(par_cEmpresa)
            RETURN .F.
        ENDIF

        IF !THIS.ObterConvenio(par_cConta)
            RETURN .F.
        ENDIF

        DO CASE
            CASE THIS.this_cBancoConvenio == "001"
                loc_lSucesso = THIS.GerarCnabBrasil(par_cCursorTitulos, par_cTituloBanco)

            CASE THIS.this_cBancoConvenio == "341"
                loc_cArquivoItau = GETFILE("txt", "Arquivo", "OK", 0, "Arquivo CNAB")
                IF EMPTY(loc_cArquivoItau)
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.GerarCnabItau(par_cCursorTitulos, par_cTituloBanco, loc_cArquivoItau)
                ENDIF

            CASE THIS.this_cBancoConvenio == "237"
                loc_lSucesso = THIS.GerarCnabBradesco(par_cCursorTitulos, par_cTituloBanco)

            CASE INLIST(THIS.this_cBancoConvenio, "033", "353")
                loc_lSucesso = THIS.GerarCnabSantander240(par_cCursorTitulos, par_cTituloBanco)

            OTHERWISE
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " layout de CNAB configurado para o banco [" + ;
                    THIS.this_cBancoConvenio + "].", "Aviso")
                loc_lSucesso = .F.
        ENDCASE

        IF USED("cursor_4c_Convenio")
            USE IN cursor_4c_Convenio
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabBrasil - PROCEDURE cnabbrasil no legado (CNAB 400 - Banco do
    * Brasil, convenio NBancos='001'). Ao final, dispara automaticamente a
    * impressao do boleto (ImprimirBoleto .F.) - igual ao legado ("thisform.
    * impboleto(.F.)" na ultima linha de cnabbrasil).
    *==========================================================================
    PROTECTED FUNCTION GerarCnabBrasil(par_cCursorTitulos, par_cTituloBanco)
        LOCAL loc_cBanco, loc_cCnv, loc_cAge, loc_cBco, loc_cRaz, loc_cCgc, loc_cTpCgc, ;
              loc_cRazBco, loc_cDat, loc_cPri, loc_cProt, loc_cCdC, loc_cTpCtArq, loc_cTpCtBol, ;
              loc_cEnv, loc_cArq, loc_cChr, loc_cStr, loc_nSeq, loc_cSeq, loc_nSeqNum, ;
              loc_cVenc, loc_cValor, loc_nMora, loc_cMora, loc_cCgcCli, loc_cTpCgcCli, loc_cNome, ;
              loc_cEnde, loc_cBair, loc_cCep, loc_cCida, loc_cEsta, loc_cNumTit, loc_lSucesso, ;
              loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cBanco   = PADL(ALLTRIM(cursor_4c_Convenio.NBancos), 3, "0")
            loc_cCnv     = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 3, "0")
            loc_cAge     = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
            loc_cBco     = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas) + PADL(cursor_4c_Convenio.DigiAgen, 1, "0"), ".-", ""), 9, "0")
            loc_cRaz     = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc     = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 14, "0")
            loc_cTpCgc   = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "01", "02")
            loc_cRazBco  = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 15)
            loc_cDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
            loc_cPri     = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Instrus)), "00", cursor_4c_Convenio.Instrus), 2, "0")
            loc_cProt    = IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio)
            loc_cProt    = IIF(loc_cPri == "00", "00", PADL(ALLTRIM(STR(loc_cProt)), 2, "0"))
            loc_cCdC     = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 7, "0")
            loc_cTpCtArq = ALLTRIM(cursor_4c_Convenio.TpCtArqs)
            loc_cTpCtBol = ALLTRIM(cursor_4c_Convenio.TpCtBols)
            loc_cEnv     = PADL(TRANSFORM(fGerUniqueKey("BRASILENV")), 7, "0")
            loc_cArq     = ALLTRIM(cursor_4c_Convenio.ArqCnabs) + loc_cEnv + ".REM"
            loc_cChr     = CHR(13) + CHR(10)

            loc_cStr = "0" + "1" + "REMESSA" + "01" + "COBRANCA" + SPACE(7) + loc_cAge + loc_cBco + SPACE(6) + ;
                       loc_cRaz + "001BANCO DO BRASIL" + loc_cDat + loc_cEnv + SPACE(22) + loc_cCdC + SPACE(258) + "000001"

            loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 0)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT *, SPACE(5) AS SeqNums FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeq = 2
            SELECT cursor_4c_CnabDet
            SCAN
                loc_nSeqNum   = fGerUniqueKey("BBNOSSONUM")
                loc_cSeq      = TRANSFORM(loc_nSeq, "@L 999999")
                loc_cVenc     = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 9, 2)
                loc_cValor    = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 13, "0")
                loc_nMora     = ROUND((cursor_4c_CnabDet.Valos * 0.23) / 100, 2)
                loc_cMora     = PADL(CHRTRAN(STR(loc_nMora, 11, 2), ",.", ""), 13, "0")
                loc_cCgcCli   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 14, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "01", "02")
                loc_cNome     = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 37)
                loc_cNome     = PADR(CHRTRAN(loc_cNome, "/.-,", ""), 37)
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs) OR EMPTY(cursor_4c_CnabDet.EstCobs) ;
                        OR EMPTY(cursor_4c_CnabDet.BaiCobs) OR EMPTY(cursor_4c_CnabDet.CidCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + " " + ALLTRIM(cursor_4c_CnabDet.Nums) + " " + ALLTRIM(cursor_4c_CnabDet.Compls), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.Bairs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.Cidas, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.Estas, 2)
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.BaiCobs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.CidCobs, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.EstCobs, 2)
                ENDIF
                loc_cEnde   = PADR(CHRTRAN(loc_cEnde, "/.-,", ""), 40)
                loc_cNumTit = PADL(CHRTRAN(cursor_4c_CnabDet.Titulos, "/", ""), 8, "0")

                loc_cStr = "7" + loc_cTpCgc + loc_cCgc + loc_cAge + loc_cBco + loc_cCdC + PADR(loc_cNumTit, 25) + ;
                           loc_cCdC + PADL(loc_nSeqNum, 10, "0") + "00" + "00" + SPACE(3) + " " + SPACE(3) + ;
                           loc_cTpCtBol + "0" + "000000" + SPACE(5) + loc_cTpCtArq + "01" + PADR(loc_cNumTit, 10) + ;
                           loc_cVenc + loc_cValor + "001" + "0000" + " " + "01" + "N" + loc_cDat + loc_cPri + "00" + ;
                           loc_cMora + "000000" + "0000000000000" + "0000000000000" + "0000000000000" + loc_cTpCgcCli + ;
                           loc_cCgcCli + UPPER(loc_cNome) + "   " + UPPER(loc_cEnde) + UPPER(loc_cBair) + loc_cCep + ;
                           UPPER(loc_cCida) + UPPER(loc_cEsta) + SPACE(40) + "  " + " " + loc_cSeq

                loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                REPLACE SeqNums WITH PADL(loc_nSeqNum, 5, "0") IN cursor_4c_CnabDet

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = loc_nSeqNum
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF

                loc_nSeq = loc_nSeq + 1
            ENDSCAN

            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "9" + SPACE(393) + loc_cSeq + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF FILE(loc_cArq)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = FULLPATH(loc_cArq)
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(loc_cArq) + CHR(34) + " Gerado Com Sucesso!!!", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            *-- cursor_4c_CnabDet NAO eh fechado aqui de proposito: ja tem
            *-- SeqNums preenchido pelo SCAN acima, e ImprimirBoleto (chamado
            *-- logo abaixo, fora do TRY) reusa esse mesmo cursor - igual ao
            *-- legado, que reaproveita a MESMA crFiltro2 entre cnabbrasil e
            *-- impboleto (thisform.impboleto(.F.) na ultima linha).
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabBrasil")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.ImprimirBoleto("cursor_4c_CnabDet", .F.)
        ENDIF

        IF USED("cursor_4c_CnabDet")
            USE IN cursor_4c_CnabDet
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabItau - PROCEDURE cnabitau no legado (CNAB 400 - Itau, convenio
    * NBancos='341'). par_cArquivo vem do GETFILE() escolhido pelo usuario no
    * dispatcher (GerarArquivoCnab) - igual ao legado, que pede o arquivo
    * ANTES de chamar Thisform.CnabItau().
    *==========================================================================
    PROTECTED FUNCTION GerarCnabItau(par_cCursorTitulos, par_cTituloBanco, par_cArquivo)
        LOCAL loc_cCnv, loc_cAge, loc_cBco, loc_cRaz, loc_cCgc, loc_cTpCgc, loc_cRazBco, ;
              loc_cDat, loc_cProt, loc_cStr, loc_nSeq, loc_cSeq, loc_cVenc, loc_cValor, ;
              loc_cCgcCli, loc_cTpCgcCli, loc_cNome, loc_cEnde, loc_cBair, loc_cCep, loc_cCida, ;
              loc_cEsta, loc_cNumTit, loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cCnv    = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 8, "0")
            loc_cAge    = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 4, "0")
            loc_cBco    = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas), ".-", ""), 5, "0") + cursor_4c_Convenio.DigiAgen
            loc_cRaz    = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc    = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 14, "0")
            loc_cTpCgc  = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "01", "02")
            loc_cRazBco = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 15)
            loc_cDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
            loc_cProt   = IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio)
            loc_cProt   = PADL(ALLTRIM(STR(loc_cProt)), 2, "0")

            loc_cStr = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + loc_cAge + "00" + loc_cBco + SPACE(8) + ;
                       loc_cRaz + "341" + loc_cRazBco + loc_cDat + SPACE(294) + "000001"

            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, par_cArquivo, 0)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT * FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeq = 2
            SELECT cursor_4c_CnabDet
            SCAN
                loc_cSeq      = TRANSFORM(loc_nSeq, "@L 999999")
                loc_cVenc     = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 9, 2)
                loc_cValor    = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 13, "0")
                loc_cCgcCli   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 14, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "01", "02")
                loc_cNome     = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 30)
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs) OR EMPTY(cursor_4c_CnabDet.EstCobs) ;
                        OR EMPTY(cursor_4c_CnabDet.BaiCobs) OR EMPTY(cursor_4c_CnabDet.CidCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + "," + cursor_4c_CnabDet.Nums, 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.Bairs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.Cidas, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.Estas, 2)
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.BaiCobs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.CidCobs, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.EstCobs, 2)
                ENDIF
                loc_cNumTit = PADL(CHRTRAN(cursor_4c_CnabDet.Titulos, "/", ""), 8, "0")

                loc_cStr = "1" + loc_cTpCgc + loc_cCgc + loc_cAge + "00" + loc_cBco + SPACE(4) + "0000" + ;
                           PADR(loc_cNumTit, 25) + loc_cNumTit + "0000000000000" + "112" + SPACE(21) + "I" + "01" + ;
                           PADR(loc_cNumTit, 10) + loc_cVenc + loc_cValor + "341" + "00000" + "01" + "A" + loc_cDat + ;
                           "81" + "19" + "0000000000000" + "000000" + "0000000000000" + "0000000000000" + ;
                           "0000000000000" + loc_cTpCgcCli + loc_cCgcCli + loc_cNome + SPACE(10) + loc_cEnde + ;
                           loc_cBair + loc_cCep + loc_cCida + loc_cEsta + SPACE(30) + SPACE(4) + "000000" + ;
                           loc_cProt + " " + loc_cSeq

                loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
                = STRTOFILE(loc_cStr, par_cArquivo, 1)

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = 0
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF

                loc_nSeq = loc_nSeq + 1
            ENDSCAN

            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "9" + SPACE(393) + loc_cSeq + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, par_cArquivo, 1)

            IF FILE(par_cArquivo)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = par_cArquivo
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(par_cArquivo) + CHR(34) + " gerado com sucesso.", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabItau")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabBradesco - PROCEDURE cnabbradesco no legado (CNAB 400 -
    * Bradesco, convenio NBancos='237'). "Nosso Numero" so eh calculado
    * quando BcoImprime<>1 (cliente emite o boleto, nao o banco) - igual ao
    * legado (bloco "If lcBol = [2]").
    *==========================================================================
    PROTECTED FUNCTION GerarCnabBradesco(par_cCursorTitulos, par_cTituloBanco)
        LOCAL loc_cBcn, loc_cCnv, loc_cAge, loc_cBco, loc_cRaz, loc_cCgc, loc_cTpCgc, loc_cRbc, ;
              loc_cDat, loc_cEnv, loc_nMor, loc_cPri, loc_cPrt, loc_cCdC, loc_cDig, loc_cArq, loc_cChr, ;
              loc_cCar, loc_cBol, loc_cStr, loc_nSeq, loc_cSeq, loc_nSeqNum, loc_cVenc, loc_cValor, ;
              loc_cMor, loc_cCpf, loc_cTpCgcCli, loc_cNome, loc_cEnde, loc_cCep, loc_cNtt, loc_cNossoNum, ;
              loc_cDV, loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cBcn  = PADL(ALLTRIM(cursor_4c_Convenio.NBancos), 3, "0")
            loc_cCnv  = "009"
            loc_cAge  = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
            loc_cBco  = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas), ".-", ""), 7, "0") + PADL(cursor_4c_Convenio.DigiAgen, 1, "0")
            loc_cRaz  = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc  = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 14, "0")
            loc_cTpCgc = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "01", "02")
            loc_cRbc  = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 15)
            loc_cDat  = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
            loc_cEnv  = PADL(TRANSFORM(fGerUniqueKey("BRADESCOENV")), 7, "0")
            loc_nMor  = IIF(EMPTY(cursor_4c_Convenio.Moras), 0.17, cursor_4c_Convenio.Moras)
            loc_cPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Instrus)), "00", cursor_4c_Convenio.Instrus), 2, "0")
            loc_cPrt  = PADL(IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio), 2, "0")
            loc_cPrt  = IIF(loc_cPri == "00", "00", PADL(ALLTRIM(loc_cPrt), 2, "0"))
            loc_cCdC  = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 20, "0")
            loc_cDig  = IIF(VAL(SUBSTR(loc_cEnv, 6, 2)) = 0, TRANSFORM(VAL(SUBSTR(loc_cEnv, 6, 2)) + 1, "@L 99"), TRANSFORM(VAL(SUBSTR(loc_cEnv, 6, 2)), "@L 99"))
            loc_cArq  = "CB" + SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + loc_cDig + ".REM"
            loc_cChr  = CHR(13) + CHR(10)
            loc_cCar  = PADL(ALLTRIM(cursor_4c_Convenio.TpCtBols), 2, "0")
            loc_cBol  = IIF(cursor_4c_Convenio.BcoImprime = 1, "1", "2")

            loc_cStr = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + loc_cCdC + loc_cRaz + loc_cBcn + ;
                       loc_cRbc + loc_cDat + SPACE(8) + "MX" + loc_cEnv + SPACE(277) + "000001"

            loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 0)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT *, SPACE(11) AS SeqNums FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeq = 2
            SELECT cursor_4c_CnabDet
            SCAN
                loc_nSeqNum = fGerUniqueKey("BRNOSSONUM")
                REPLACE SeqNums WITH PADL(loc_nSeqNum, 11, "0") IN cursor_4c_CnabDet

                loc_cSeq   = TRANSFORM(loc_nSeq, "@L 999999")
                loc_cVenc  = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 9, 2)
                loc_cValor = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 13, "0")
                loc_cMor   = PADL(CHRTRAN(STR(ROUND((cursor_4c_CnabDet.Valos * loc_nMor) / 100, 2), 11, 2), ",.", ""), 13, "0")
                loc_cCpf   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 14, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "01", "02")
                loc_cNome  = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 40)
                loc_cNome  = PADR(CHRTRAN(loc_cNome, "/.-,", ""), 40)
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + " " + cursor_4c_CnabDet.Nums, 40)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                ENDIF
                loc_cEnde = PADR(CHRTRAN(loc_cEnde, "/.-,", ""), 40)
                loc_cNtt  = PADL(CHRTRAN(cursor_4c_CnabDet.Titulos, "/", ""), 8, "0")

                loc_cNossoNum = "00000000000"
                loc_cDV       = "0"
                IF loc_cBol == "2"
                    loc_cNossoNum = PADL(cursor_4c_CnabDet.SeqNums, 11, "0")
                    loc_cDV       = fCalcMod11B7(loc_cCar + loc_cNossoNum)
                ENDIF

                loc_cStr = "1" + SPACE(5) + SPACE(1) + SPACE(5) + SPACE(7) + SPACE(1) + ;
                           "0" + loc_cCnv + loc_cAge + loc_cBco + PADR(loc_cNtt, 25) + "   " + "2" + "0200" + ;
                           loc_cNossoNum + loc_cDV + "0000000000" + loc_cBol + " " + SPACE(10) + " " + "2" + ;
                           "  " + "01" + PADR(loc_cNtt, 10) + loc_cVenc + loc_cValor + "000" + "00000" + "01" + ;
                           "N" + loc_cDat + loc_cPri + loc_cPrt + loc_cMor + "000000" + "0000000000000" + ;
                           "0000000000000" + "0000000000000" + loc_cTpCgcCli + loc_cCpf + loc_cNome + loc_cEnde + ;
                           SPACE(12) + loc_cCep + SPACE(60) + loc_cSeq

                loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = loc_nSeqNum
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF

                loc_nSeq = loc_nSeq + 1
            ENDSCAN

            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "9" + SPACE(393) + loc_cSeq + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF FILE(loc_cArq)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = FULLPATH(loc_cArq)
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(loc_cArq) + CHR(34) + " Gerado Com Sucesso!!!", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabBradesco")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabSantander240 - PROCEDURE cnabsantander240 no legado (CNAB 240
    * - Santander, convenio NBancos IN ('033','353')). Layout multi-segmento:
    * Header arquivo, Header lote, Detalhe P + Q por titulo, Trailer lote,
    * Trailer arquivo.
    *==========================================================================
    PROTECTED FUNCTION GerarCnabSantander240(par_cCursorTitulos, par_cTituloBanco)
        LOCAL loc_cCnv, loc_cAge, loc_cDigA, loc_cCtaC, loc_cDigC, loc_cCta, loc_cRaz, loc_cCgc, ;
              loc_cTpCgc, loc_cRazBco, loc_cDat, loc_cEnv, loc_cArq, loc_nLot, loc_cLot, loc_nSeq, ;
              loc_cSeq, loc_cStr, loc_nSeqL, loc_cSeqL, loc_cNumes, loc_cVenc, loc_cValor, loc_cCgcCli, ;
              loc_cTpCgcCli, loc_cNome, loc_nMora, loc_cMora, loc_cEnde, loc_cBair, loc_cCep, loc_cCida, ;
              loc_cEsta, loc_cNumTit, loc_cChave, loc_nSeqNum, loc_cDV, loc_cNossoNum, loc_lSucesso, ;
              loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cCnv    = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 11, "0")
            loc_cAge    = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 4, "0")
            loc_cDigA   = ALLTRIM(cursor_4c_Convenio.DigiAgen)
            loc_cCtaC   = ALLTRIM(CHRTRAN(cursor_4c_Convenio.Contas, ".-", ""))
            loc_cDigC   = RIGHT(loc_cCtaC, 1)
            loc_cCta    = PADL(LEFT(loc_cCtaC, LEN(loc_cCtaC) - 1), 9, "0")
            loc_cRaz    = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc    = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 15, "0")
            loc_cTpCgc  = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "1", "2")
            loc_cRazBco = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 30)
            loc_cDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
            loc_cEnv    = PADL(TRANSFORM(fGerUniqueKey("SANTANDERENV")), 8, "0")
            loc_cArq    = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
            loc_cArq    = STRTRAN(loc_cArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + loc_cEnv + ".REM", "\\", "\")

            loc_nLot = 0
            loc_cLot = TRANSFORM(loc_nLot, "@L 9999")
            loc_nSeq = 1

            *-- Registro Header de arquivo
            loc_cStr = "033" + loc_cLot + "0" + SPACE(8) + loc_cTpCgc + loc_cCgc + loc_cAge + loc_cCnv + ;
                       SPACE(25) + loc_cRaz + loc_cRazBco + SPACE(10) + "1" + loc_cDat + SPACE(6) + ;
                       SUBSTR(loc_cEnv, 3) + "040" + SPACE(74)

            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 0)

            *-- Registro Header de lote
            loc_nLot = loc_nLot + 1
            loc_cLot = TRANSFORM(loc_nLot, "@L 9999")
            loc_nSeq = loc_nSeq + 1

            loc_cStr = "033" + loc_cLot + "1" + "R" + "01" + SPACE(2) + "030" + " " + loc_cTpCgc + loc_cCgc + ;
                       SPACE(20) + loc_cAge + loc_cCnv + SPACE(5) + loc_cRaz + SPACE(40) + SPACE(40) + loc_cEnv + ;
                       loc_cDat + SPACE(41)

            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT *, SPACE(5) AS SeqNums FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeqL = 0
            SELECT cursor_4c_CnabDet
            SCAN
                loc_cNumes    = TRANSFORM(cursor_4c_CnabDet.Numes, "@L 9999999999")
                loc_cVenc     = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 7, 4)
                loc_cValor    = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 15, "0")
                loc_cCgcCli   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 15, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "1", "2")
                loc_cNome     = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 40)
                loc_nMora     = IIF(cursor_4c_Convenio.Moras = 0, 0.33, cursor_4c_Convenio.Moras)
                loc_nMora     = ROUND((cursor_4c_CnabDet.Valos * loc_nMora) / 100, 2)
                loc_cMora     = PADL(CHRTRAN(STR(loc_nMora, 11, 2), ",.", ""), 15, "0")
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs) OR EMPTY(cursor_4c_CnabDet.EstCobs) ;
                        OR EMPTY(cursor_4c_CnabDet.BaiCobs) OR EMPTY(cursor_4c_CnabDet.CidCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + "," + cursor_4c_CnabDet.Nums, 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.Bairs, 15)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.Cidas, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.Estas, 2)
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.BaiCobs, 15)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.CidCobs, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.EstCobs, 2)
                ENDIF

                loc_cNumTit = PADL(ALLTRIM(STRTRAN(cursor_4c_CnabDet.Titulos, "/", "")), 15, "0")
                loc_cChave  = PADR(ALLTRIM(STRTRAN(cursor_4c_CnabDet.Titulos, "/", "")), 15) + loc_cNumes

                loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")

                loc_nSeqNum   = fGerUniqueKey("STNOSSONUM")
                loc_cDV       = fCalcMod11BB(PADL(loc_nSeqNum, 7, "0"), cursor_4c_Convenio.NBancos)
                loc_cNossoNum = PADL(loc_nSeqNum, 12, "0") + loc_cDV

                *-- Detalhe P
                loc_nSeqL = loc_nSeqL + 1
                loc_cSeqL = TRANSFORM(loc_nSeqL, "@L 99999")
                loc_nSeq  = loc_nSeq + 1

                loc_cStr = "033" + loc_cLot + "3" + loc_cSeqL + "P" + " " + "01" + loc_cAge + loc_cDigA + ;
                           loc_cCta + loc_cDigC + loc_cCta + loc_cDigC + "  " + loc_cNossoNum + "5" + "1" + "1" + ;
                           " " + " " + loc_cNumTit + loc_cVenc + loc_cValor + loc_cAge + loc_cDigA + " " + "02" + ;
                           "N" + loc_cDat + "1" + loc_cVenc + loc_cMora + "0" + "00000000" + "000000000000000" + ;
                           "000000000000000" + "000000000000000" + loc_cChave + "0" + "00" + "2" + "0" + "00" + ;
                           "00" + SPACE(11)

                loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                *-- Detalhe Q
                loc_nSeq  = loc_nSeq + 1
                loc_nSeqL = loc_nSeqL + 1
                loc_cSeqL = TRANSFORM(loc_nSeqL, "@L 99999")

                loc_cStr = "033" + loc_cLot + "3" + loc_cSeqL + "Q" + " " + "01" + loc_cTpCgcCli + loc_cCgcCli + ;
                           loc_cNome + loc_cEnde + loc_cBair + loc_cCep + loc_cCida + loc_cEsta + "0" + ;
                           "000000000000000" + SPACE(40) + "000" + "000" + "000" + "000" + SPACE(19)

                loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                REPLACE SeqNums WITH PADL(loc_nSeqNum, 5, "0") IN cursor_4c_CnabDet

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = loc_nSeqNum
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- Trailer de lote
            loc_nSeq  = loc_nSeq + 1
            loc_nSeqL = loc_nSeqL + 1
            loc_cSeqL = TRANSFORM(loc_nSeqL, "@L 999999")
            loc_cStr = "033" + loc_cLot + "5" + SPACE(9) + loc_cSeqL + SPACE(217)
            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            *-- Trailer de arquivo
            loc_nSeq = loc_nSeq + 1
            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "033" + "9999" + "9" + SPACE(9) + "000001" + loc_cSeq + SPACE(211)
            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF FILE(loc_cArq)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = FULLPATH(loc_cArq)
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(loc_cArq) + CHR(34) + " gerado com sucesso.", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabSantander240")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AtualizarTitulosBancoSigMvCcr - grava o "Titulo do Banco" (par_cTitulo
    * Banco) em SigMvCcr.TitBans para cada titulo do lote gerado, com
    * confirmacao de sobrescrita quando ja existe um valor - identico nos 4
    * layouts do legado (cnabbradesco/cnabitau/cnabbrasil/cnabsantander240).
    *==========================================================================
    PROTECTED FUNCTION AtualizarTitulosBancoSigMvCcr(par_cCursorDetalhe, par_cTituloBanco)
        LOCAL loc_lOk, loc_lAtu, loc_cSQL, loc_nResultado, loc_cEmpDopNums, loc_nNopers, loc_oErro
        loc_lOk = .T.

        TRY
            SELECT (par_cCursorDetalhe)
            SCAN
                loc_lAtu        = .T.
                loc_cEmpDopNums = EVALUATE(par_cCursorDetalhe + ".EmpDopNums")
                loc_nNopers     = EVALUATE(par_cCursorDetalhe + ".Nopers")

                IF USED("cursor_4c_TitBanAtual")
                    USE IN cursor_4c_TitBanAtual
                ENDIF
                loc_cSQL = "SELECT Titulos, TitBans FROM SigMvCcr" + CHR(13) + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + CHR(13) + ;
                           "  AND Nopers = " + FormatarNumeroSQL(loc_nNopers, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBanAtual")

                IF loc_nResultado > 0 AND USED("cursor_4c_TitBanAtual") AND !EOF("cursor_4c_TitBanAtual")
                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_TitBanAtual.TitBans, "")))
                        loc_lAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + ALLTRIM(cursor_4c_TitBanAtual.Titulos) + CHR(34) + ;
                            " J" + CHR(225) + " Possui T" + CHR(237) + "tulo do Banco Preenchido." + CHR(13) + ;
                            "Deseja Sobrescrever o T" + CHR(237) + "tulo?", "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TitBanAtual")
                    USE IN cursor_4c_TitBanAtual
                ENDIF

                IF loc_lAtu
                    loc_cSQL = "UPDATE SigMvCcr SET TitBans = " + EscaparSQL(par_cTituloBanco) + CHR(13) + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + CHR(13) + ;
                               "  AND Nopers = " + FormatarNumeroSQL(loc_nNopers, 0)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        MostrarErro("Falha ao gravar o T" + CHR(237) + "tulo do Banco:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF
                ENDIF

                SELECT (par_cCursorDetalhe)
            ENDSCAN
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRCNBBO.AtualizarTitulosBancoSigMvCcr")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * ImprimirBoleto - PROCEDURE impboleto(pReimp) no legado: calcula os
    * campos do boleto (nosso numero, codigo de barras, linha digitavel)
    * para os titulos marcados e monta cursor_4c_Boletos para a impressao
    * (o REPORT FORM fica a cargo do Form, que escolhe o layout pelo banco
    * do convenio via THIS.this_cBancoConvenio).
    *
    * par_lReimpressao - .T. reutiliza o NumeDs da ULTIMA geracao gravada em
    *   SigPcOol para cada titulo (reimpressao de um boleto ja enviado ao
    *   banco - botao "Boleto"); .F. usa o SeqNums que acabou de ser gravado
    *   por GerarCnabBrasil (chamado automaticamente ao final da geracao).
    * par_cEmpresa/par_cConta - opcionais; se informados, sobrescrevem
    *   this_cCodEmpresaAtual/this_cContaCarteiraAtual (uso standalone via
    *   botao "Boleto", sem GerarArquivoCnab ter rodado antes).
    *
    * Suporta apenas os bancos que o legado emite boleto (001/033/353/237) -
    * Itau (341) so gera arquivo de remessa, sem boleto (fiel ao legado).
    *==========================================================================
    FUNCTION ImprimirBoleto(par_cCursorTitulos, par_lReimpressao, par_cEmpresa, par_cConta)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cNossoNum, loc_cFator, loc_cValor, loc_cBarra, ;
              loc_cDV, loc_cArqBMP, loc_cCampo1, loc_cDv1, loc_cCampo2, loc_cDv2, loc_cCampo3, loc_cDv3, ;
              loc_cNrDigit, loc_cCnv, loc_cAg, loc_cCar, loc_cCta, loc_cDig, loc_cLivre, loc_nMor, ;
              loc_cMora, loc_cInt1, loc_cInt2, loc_cInt7, loc_cProt, loc_cPri, loc_cNome, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cCursorBoleto = ""

        IF VARTYPE(par_cEmpresa) == "C" AND !EMPTY(par_cEmpresa)
            THIS.this_cCodEmpresaAtual = par_cEmpresa
        ENDIF
        IF VARTYPE(par_cConta) == "C" AND !EMPTY(par_cConta)
            THIS.this_cContaCarteiraAtual = par_cConta
        ENDIF

        IF !USED(par_cCursorTitulos)
            RETURN .F.
        ENDIF

        IF !THIS.ObterDadosEmpresa(THIS.this_cCodEmpresaAtual)
            RETURN .F.
        ENDIF
        IF !THIS.ObterConvenio(THIS.this_cContaCarteiraAtual)
            RETURN .F.
        ENDIF

        IF !INLIST(THIS.this_cBancoConvenio, "001", "033", "353", "237")
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " layout de boleto para o banco [" + THIS.this_cBancoConvenio + "].", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Boletos")
                USE IN cursor_4c_Boletos
            ENDIF
            SELECT *, SPACE(44) AS nBarras, SPACE(30) AS ImgBarra, THIS.this_cRazSocsEmpresa AS Cedente, ;
                   SPACE(50) AS NomeCli, SPACE(50) AS Instr1, SPACE(50) AS Instr2, SPACE(50) AS Instr3, ;
                   SPACE(50) AS Instr4, SPACE(50) AS Instr5, SPACE(50) AS Instr6, SPACE(70) AS Instr7, ;
                   SPACE(50) AS NrDigit, SPACE(17) AS NossoNum, SPACE(15) AS AgCodCed, SPACE(10) AS cTitulos, ;
                   SPACE(2) AS Carteira ;
                FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_Boletos READWRITE

            *-- Fonte com titulos ja processados (cursor_4c_CnabDet, chamada
            *-- automatica ao final de GerarCnabBrasil) ja tem SeqNums
            *-- preenchido pela geracao; fonte crua (cursor_4c_Titulos, botao
            *-- "Boleto" standalone) ainda nao tem essa coluna - adicionar
            *-- vazia evita erro de coluna duplicada no SELECT * acima.
            IF TYPE("cursor_4c_Boletos.SeqNums") != "C"
                ALTER TABLE cursor_4c_Boletos ADD COLUMN SeqNums C(12)
                REPLACE ALL SeqNums WITH SPACE(12) IN cursor_4c_Boletos
            ENDIF

            IF RECCOUNT("cursor_4c_Boletos") = 0
                MsgAviso("Nenhum registro foi selecionado", "Aviso")
                IF USED("cursor_4c_Boletos")
                    USE IN cursor_4c_Boletos
                ENDIF
                RETURN .F.
            ENDIF

            loc_cCnv     = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 7, "0")
            loc_lSucesso = .T.

            SELECT cursor_4c_Boletos
            SCAN
                IF par_lReimpressao
                    IF USED("cursor_4c_TmpPcOol")
                        USE IN cursor_4c_TmpPcOol
                    ENDIF
                    loc_cSQL = "SELECT TOP 1 NumeDs FROM SigPcOol" + CHR(13) + ;
                               "WHERE Processos = 'CNAB' AND DopeDs = " + EscaparSQL(cursor_4c_Boletos.Titulos) + CHR(13) + ;
                               "ORDER BY Datas DESC"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPcOol")
                    IF loc_nResultado < 1 OR !USED("cursor_4c_TmpPcOol") OR EOF("cursor_4c_TmpPcOol")
                        MostrarErro("N" + CHR(227) + "o foi encontrada gera" + CHR(231) + CHR(227) + "o anterior deste t" + CHR(237) + "tulo.", "Boleto")
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                    REPLACE SeqNums WITH PADL(ALLTRIM(STR(cursor_4c_TmpPcOol.NumeDs)), 5, "0") IN cursor_4c_Boletos
                ENDIF

                loc_cNossoNum = ""

                DO CASE
                CASE THIS.this_cBancoConvenio == "001"
                    loc_cNossoNum = loc_cCnv + PADL(cursor_4c_Boletos.SeqNums, 10, "0")
                    loc_cFator = PADL(ALLTRIM(STR(1000 + (TTOD(cursor_4c_Boletos.Vencs) - CTOD("03/07/2000")))), 4, "0")
                    loc_cValor = PADL(CHRTRAN(STR(cursor_4c_Boletos.Valos, 8, 2), ",.", ""), 10, "0")
                    loc_cBarra = "0019" + loc_cFator + loc_cValor + "000000" + loc_cNossoNum + "17"
                    loc_cDV    = fCalcMod11BB(loc_cBarra, cursor_4c_Convenio.NBancos)

                    loc_cNossoNum = loc_cCnv + PADL(cursor_4c_Boletos.SeqNums, 10, "0")
                    loc_cBarra = "0019" + loc_cDV + loc_cFator + loc_cValor + "000000" + loc_cNossoNum + "17"
                    REPLACE nBarras WITH loc_cBarra IN cursor_4c_Boletos

                    loc_cArqBMP = "img_barra_" + PADL(cursor_4c_Boletos.SeqNums, 10, "0") + ".bmp"
                    = fGerBar2de5(ADDBS(SYS(2023)) + loc_cArqBMP, loc_cBarra)
                    REPLACE ImgBarra WITH loc_cArqBMP IN cursor_4c_Boletos

                    loc_cCampo1  = "001900000"
                    loc_cDv1     = fCalcMod10(loc_cCampo1)
                    loc_cCampo2  = SUBSTR(loc_cBarra, 25, 10)
                    loc_cDv2     = fCalcMod10(loc_cCampo2)
                    loc_cCampo3  = SUBSTR(loc_cBarra, 35, 10)
                    loc_cDv3     = fCalcMod10(loc_cCampo3)
                    loc_cNrDigit = loc_cCampo1 + loc_cDv1 + loc_cCampo2 + loc_cDv2 + loc_cCampo3 + loc_cDv3 + loc_cDV + loc_cFator + loc_cValor
                    REPLACE NrDigit WITH loc_cNrDigit IN cursor_4c_Boletos
                    REPLACE AgCodCed WITH LEFT(ALLTRIM(cursor_4c_Convenio.NAgencias), 4) + "-" + ;
                            RIGHT(ALLTRIM(cursor_4c_Convenio.NAgencias), 1) + "/" + ;
                            ALLTRIM(CHRTRAN(cursor_4c_Convenio.Contas, ".-", "")) + "-" + ;
                            PADL(cursor_4c_Convenio.DigiAgen, 1, "0") IN cursor_4c_Boletos

                    IF VARTYPE(cursor_4c_Convenio.MsgMulta) = "N" AND cursor_4c_Convenio.MsgMulta = 1
                        REPLACE Instr3 WITH "COBRAR MULTA DE 2% AO M" + CHR(202) + "S AP" + CHR(211) + "S 1 DIA DE VENCIMENTO " IN cursor_4c_Boletos
                    ENDIF

                CASE INLIST(THIS.this_cBancoConvenio, "033", "353")
                    loc_cNossoNum = PADL(cursor_4c_Boletos.SeqNums, 12, "0")
                    loc_cDV       = fCalcMod11BB(loc_cNossoNum, cursor_4c_Convenio.NBancos)
                    loc_cNossoNum = loc_cNossoNum + loc_cDV

                    loc_cFator = PADL(ALLTRIM(STR(TTOD(cursor_4c_Boletos.Vencs) - CTOD("07/10/1997"))), 4, "0")
                    loc_cValor = PADL(CHRTRAN(STR(cursor_4c_Boletos.Valos, 8, 2), ",.", ""), 10, "0")
                    loc_cBarra = "0339" + loc_cFator + loc_cValor + "9" + loc_cCnv + loc_cNossoNum + "0" + "101"
                    loc_cDV    = fCalcMod11BB(loc_cBarra, cursor_4c_Convenio.NBancos, "DVB")

                    loc_cBarra = "0339" + loc_cDV + loc_cFator + loc_cValor + "9" + loc_cCnv + loc_cNossoNum + "0" + "101"
                    REPLACE nBarras WITH loc_cBarra IN cursor_4c_Boletos

                    loc_cArqBMP = "img_barra_" + PADL(cursor_4c_Boletos.SeqNums, 12, "0") + ".bmp"
                    = fGerBar2de5(ADDBS(SYS(2023)) + loc_cArqBMP, loc_cBarra)
                    REPLACE ImgBarra WITH loc_cArqBMP IN cursor_4c_Boletos

                    loc_cCampo1  = "03399" + SUBSTR(loc_cCnv, 1, 4)
                    loc_cDv1     = fCalcMod10(loc_cCampo1)
                    loc_cCampo2  = SUBSTR(loc_cBarra, 25, 10)
                    loc_cDv2     = fCalcMod10(loc_cCampo2)
                    loc_cCampo3  = SUBSTR(loc_cBarra, 35, 10)
                    loc_cDv3     = fCalcMod10(loc_cCampo3)
                    loc_cNrDigit = loc_cCampo1 + loc_cDv1 + loc_cCampo2 + loc_cDv2 + loc_cCampo3 + loc_cDv3 + loc_cDV + loc_cFator + loc_cValor
                    REPLACE NrDigit WITH ALLTRIM(loc_cNrDigit) IN cursor_4c_Boletos
                    REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.NAgencias) + "/" + loc_cCnv IN cursor_4c_Boletos
                    REPLACE Instr3 WITH "COBRAR 1% DE MULTA A PARTIR DE " + DTOC(TTOD(cursor_4c_Boletos.Vencs) + 6) IN cursor_4c_Boletos

                CASE THIS.this_cBancoConvenio == "237"
                    IF USED("cursor_4c_TmpPcOol") AND !EOF("cursor_4c_TmpPcOol")
                        REPLACE SeqNums WITH PADL(ALLTRIM(TRANSFORM(cursor_4c_TmpPcOol.NumeDs, "@R 99999999999")), 11, "0") IN cursor_4c_Boletos
                    ENDIF
                    loc_cFator = PADL(ALLTRIM(STR(TTOD(cursor_4c_Boletos.Vencs) - CTOD("07/10/1997"))), 4, "0")
                    loc_cValor = PADL(CHRTRAN(STR(cursor_4c_Boletos.Valos, 8, 2), ",.", ""), 10, "0")
                    loc_cAg    = PADL(LEFT(ALLTRIM(cursor_4c_Convenio.NAgencias), 4), 4, "0")
                    loc_cCar   = PADL(ALLTRIM(cursor_4c_Convenio.TpCtBols), 2, "0")
                    loc_cCta   = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas), ".-", ""), 7, "0")
                    loc_cDig   = ALLTRIM(cursor_4c_Convenio.DigiAgen)
                    loc_cNossoNum = PADL(cursor_4c_Boletos.SeqNums, 11, "0")
                    loc_cDV       = fCalcMod11B7(loc_cCar + loc_cNossoNum)
                    loc_cNossoNum = loc_cNossoNum + loc_cDV

                    loc_cLivre = loc_cAg + loc_cCar + SUBSTR(loc_cNossoNum, 1, 11) + loc_cCta + "0"
                    loc_cBarra = "2379" + loc_cFator + loc_cValor + loc_cLivre
                    loc_cDV    = fCalcMod11BB(loc_cBarra, cursor_4c_Convenio.NBancos, "DVB")

                    loc_cBarra = "2379" + loc_cDV + loc_cFator + loc_cValor + loc_cLivre
                    REPLACE nBarras WITH loc_cBarra IN cursor_4c_Boletos

                    loc_cArqBMP = "img_barra_" + PADL(cursor_4c_Boletos.SeqNums, 11, "0") + ".bmp"
                    = fGerBar2de5(ADDBS(SYS(2023)) + loc_cArqBMP, loc_cBarra)
                    REPLACE ImgBarra WITH loc_cArqBMP IN cursor_4c_Boletos

                    loc_cCampo1  = "2379" + SUBSTR(loc_cLivre, 1, 5)
                    loc_cDv1     = fCalcMod10(loc_cCampo1)
                    loc_cCampo2  = SUBSTR(loc_cLivre, 6, 10)
                    loc_cDv2     = fCalcMod10(loc_cCampo2)
                    loc_cCampo3  = SUBSTR(loc_cLivre, 16, 10)
                    loc_cDv3     = fCalcMod10(loc_cCampo3)
                    loc_cNrDigit = loc_cCampo1 + loc_cDv1 + loc_cCampo2 + loc_cDv2 + loc_cCampo3 + loc_cDv3 + loc_cDV + loc_cFator + loc_cValor
                    REPLACE NrDigit WITH loc_cNrDigit IN cursor_4c_Boletos
                    REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.NAgencias) + "/" + loc_cCta + "-" + loc_cDig IN cursor_4c_Boletos
                    REPLACE Carteira WITH loc_cCar IN cursor_4c_Boletos
                ENDCASE

                REPLACE NossoNum WITH loc_cNossoNum, ;
                        cTitulos WITH PADL(CHRTRAN(cursor_4c_Boletos.Titulos, "/", ""), 8, "0") IN cursor_4c_Boletos

                loc_cNome = PADR(IIF(EMPTY(cursor_4c_Boletos.Razaos), cursor_4c_Boletos.RClis, cursor_4c_Boletos.Razaos), 37)
                loc_cNome = PADR(CHRTRAN(loc_cNome, "/.-,", ""), 37)
                REPLACE NomeCli WITH loc_cNome IN cursor_4c_Boletos

                IF !(EMPTY(cursor_4c_Boletos.EndCobs) OR EMPTY(cursor_4c_Boletos.CepCobs) OR EMPTY(cursor_4c_Boletos.EstCobs) ;
                        OR EMPTY(cursor_4c_Boletos.BaiCobs) OR EMPTY(cursor_4c_Boletos.CidCobs))
                    REPLACE Endes WITH ALLTRIM(cursor_4c_Boletos.EndCobs), ;
                            Bairs WITH cursor_4c_Boletos.BaiCobs, ;
                            Ceps  WITH cursor_4c_Boletos.CepCobs, ;
                            Cidas WITH cursor_4c_Boletos.CidCobs, ;
                            Estas WITH cursor_4c_Boletos.EstCobs IN cursor_4c_Boletos
                ENDIF

                loc_cPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Instrus)), "00", cursor_4c_Convenio.Instrus), 2, "0")
                loc_cProt = IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio)
                loc_cProt = IIF(loc_cPri == "00", "00", PADL(ALLTRIM(STR(loc_cProt)), 2, "0"))
                loc_nMor  = IIF(EMPTY(cursor_4c_Convenio.Moras), 0.23, cursor_4c_Convenio.Moras)
                loc_cMora = STR(ROUND((cursor_4c_Boletos.Valos * loc_nMor) / 100, 2), 8, 2)
                loc_cInt1 = "AP" + CHR(211) + "S VENCIMENTO, COBRAR JUROS DE R$" + ALLTRIM(loc_cMora) + " AO DIA."
                loc_cInt2 = "PROTESTAR NO " + loc_cProt + CHR(186) + " DIA " + CHR(218) + "TIL AP" + CHR(211) + "S O VENCIMENTO."
                loc_cInt7 = IIF(THIS.this_cBancoConvenio == "237", ;
                    "Pag" + CHR(225) + "vel preferencialmente na Rede Bradesco ou Bradesco Expresso", ;
                    "PAG" + CHR(193) + "VEL EM QUALQUER BANCO AT" + CHR(201) + " O VENCIMENTO")

                IF VARTYPE(cursor_4c_Convenio.MsgMulta) = "N" AND cursor_4c_Convenio.MsgMulta = 1
                    loc_cInt2 = ""
                ENDIF

                REPLACE Instr1 WITH loc_cInt1, ;
                        Instr2 WITH loc_cInt2, ;
                        Instr7 WITH loc_cInt7 IN cursor_4c_Boletos

                IF USED("cursor_4c_TmpPcOol")
                    USE IN cursor_4c_TmpPcOol
                ENDIF
                SELECT cursor_4c_Boletos
            ENDSCAN

            IF loc_lSucesso
                GO TOP IN cursor_4c_Boletos
                THIS.this_cCursorBoleto = "cursor_4c_Boletos"
            ELSE
                IF USED("cursor_4c_Boletos")
                    USE IN cursor_4c_Boletos
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.ImprimirBoleto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LimparImagensBarras - apaga os .bmp temporarios gerados por
    * ImprimirBoleto apos a impressao (igual ao legado - "Deleta as imagens
    * dos barras gerados" ao final de impboleto). Chamado pelo Form DEPOIS
    * do REPORT FORM do boleto.
    *==========================================================================
    FUNCTION LimparImagensBarras(par_cCursorBoletos)
        LOCAL loc_cArqBMP

        IF USED(par_cCursorBoletos)
            SELECT (par_cCursorBoletos)
            SCAN
                loc_cArqBMP = ADDBS(SYS(2023)) + ALLTRIM(NVL(EVALUATE(par_cCursorBoletos + ".ImgBarra"), ""))
                IF !EMPTY(ALLTRIM(NVL(EVALUATE(par_cCursorBoletos + ".ImgBarra"), ""))) AND FILE(loc_cArqBMP)
                    ERASE (loc_cArqBMP)
                ENDIF
            ENDSCAN
        ENDIF
    ENDFUNC

ENDDEFINE
