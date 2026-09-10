*====================================================================
* TmeBO.prg
*
* Business Object para Cadastro de Transporte de Movimentacao de
* Estoque (Configuracao de Transporte/FTP entre empresas)
* Tabela principal: SigCdMe (PK: tipoemps = Tipos + Emps)
* Tabelas de detalhe (grids da Page2.Configuracao):
*   - SigCdMeI (Page1 do PageFrame de Configuracao - Operacoes/Itens)
*   - SigCdMeT (Page2 do PageFrame de Configuracao - Titulos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMe)
    this_cTipoEmps            = ""    && tipoemps    char(9)  - PK (concatenacao Tipos+Emps)
    this_cTipos               = ""    && tipos       char(6)  - codigo do Processo/Transporte
    this_cEmps                = ""    && emps        char(3)  - codigo da Empresa
    this_cDescricao           = ""    && descrs      char(20) - descricao do transporte
    this_cExtensao            = ""    && extensao    char(3)  - tipo de extensao do arquivo
    this_cDirGeracao          = ""    && drivets     char(60) - diretorio de geracao/gravacao do transporte
    this_cDirLeitura          = ""    && drivels     char(60) - diretorio de leitura do zip
    this_cDirRecepcao         = ""    && drivers     char(60) - diretorio de recepcao do transporte
    this_cDirArquivar         = ""    && paths       char(60) - diretorio para arquivar o arquivo recebido
    this_cTipoConexao         = ""    && tpconexao   char(1)  - D=Dial-Up / B=Banda Larga
    this_cFtpEndereco         = ""    && ftpend      char(50) - endereco do FTP
    this_cFtpUsuario          = ""    && ftpusuario  char(50) - usuario do FTP
    this_cFtpSenha            = ""    && ftpsenha    char(20) - senha do FTP (criptografada)
    this_cDirFtpEnvio         = ""    && dirftpts    char(60) - pasta para envio (FTP)
    this_cDirFtpRecepcao      = ""    && dirftpls    char(60) - pasta para recepcao (FTP)
    this_lNaoChecarSequencia  = .F.   && nchkseqs    bit      - nao checar sequencia
    this_nTransporteOk        = 0     && clrarqs     numeric(3,0) - numero do transporte OK / limpar arqs OK
    this_cTipoTransporte      = ""    && transtipo   char(6)  - tipo transporte (lookup SigPrTrn.Codigos)
    this_lLimpaDirEnvio       = .F.   && locdel      bit      - limpa diretorio de envio
    this_lLimpaDirFtp         = .F.   && ftpdel      bit      - limpa diretorio do FTP
    this_cEmpDs               = ""    && empds       char(3)  - empresa de destino

    *-- Cursores dos grids de detalhe (Page2.Configuracao.Page1/Page2)
    this_cCursorItens         = "cursor_4c_Itens"     && grid de Operacoes/Itens (tabela SigCdMeI)
    this_cCursorTitulos       = "cursor_4c_Titulos"   && grid de Titulos (tabela SigCdMeT)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMe"
            THIS.this_cCampoChave = "tipoemps"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TmeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipoEmps)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipoEmps           = TratarNulo(tipoemps,   "C")
                THIS.this_cTipos              = TratarNulo(tipos,      "C")
                THIS.this_cEmps               = TratarNulo(emps,       "C")
                THIS.this_cDescricao          = TratarNulo(descrs,     "C")
                THIS.this_cExtensao           = TratarNulo(extensao,   "C")
                THIS.this_cDirGeracao         = TratarNulo(drivets,    "C")
                THIS.this_cDirLeitura         = TratarNulo(drivels,    "C")
                THIS.this_cDirRecepcao        = TratarNulo(drivers,    "C")
                THIS.this_cDirArquivar        = TratarNulo(paths,      "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_lNaoChecarSequencia = ConverterParaLogico(nchkseqs)
                THIS.this_nTransporteOk       = TratarNulo(clrarqs,    "N")
                THIS.this_cTipoTransporte     = TratarNulo(transtipo,  "C")
                THIS.this_lLimpaDirEnvio      = ConverterParaLogico(locdel)
                THIS.this_lLimpaDirFtp        = ConverterParaLogico(ftpdel)
                THIS.this_cEmpDs              = TratarNulo(empds,      "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TmeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cTipos)
            MsgAviso("C" + CHR(243) + "digo do Transporte Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            MsgAviso("C" + CHR(243) + "digo da Empresa Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            THIS.this_cTipoEmps = PADR(THIS.this_cTipos, 6) + PADR(THIS.this_cEmps, 3)
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarChaveExistente(THIS.this_cTipoEmps)
                MsgAviso("Transporte j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se tipoemps ja existe no banco
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMe" + ;
                " WHERE tipoemps = " + EscaparSQL(par_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChave")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkChave")
                SELECT cursor_4c_ChkChave
                loc_lExiste = (cursor_4c_ChkChave.qtd > 0)
                USE IN cursor_4c_ChkChave
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar transporte:" + CHR(13) + loException.Message, "TmeBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMe (tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds)
                VALUES (
                    <<EscaparSQL(THIS.this_cTipoEmps)>>,
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cExtensao)>>,
                    <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cEmpDs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TmeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMe
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    extensao   = <<EscaparSQL(THIS.this_cExtensao)>>,
                    drivets    = <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    drivels    = <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    drivers    = <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    paths      = <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    tpconexao  = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    ftpend     = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpusuario = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    ftpsenha   = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    dirftpts   = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    dirftpls   = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    nchkseqs   = <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    clrarqs    = <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    transtipo  = <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    locdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    ftpdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDs)>>
                WHERE tipoemps = <<EscaparSQL(THIS.this_cTipoEmps)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TmeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdMe e seus detalhes
    * (SigCdMeI = Operacoes/Itens, SigCdMeT = Titulos)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMei WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdMet WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdMe WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TmeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com tipoemps, tipos, emps, descrs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipoemps C(9), tipos C(6), emps C(3), descrs C(20), extensao C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipoemps, tipos, emps, descrs, extensao FROM SigCdMe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY tipos, emps"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TmeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (tipoemps)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds
                FROM SigCdMe
                WHERE tipoemps = <<EscaparSQL(par_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TmeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega grid de Operacoes/Itens (SigCdMeI) do transporte
    * Legado: csGrade (TipoEmps, Emps, Dopes, cIdChaves, ChkPagos, ChkSubns,
    *         EmpDs, DopeDs, ContaEs, Apagas, nDias, Numeras, DtTrans)
    *====================================================================
    PROCEDURE BuscarItens(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, chkpagos, chksubns,
                    empds, dopeds, contaes, apagas, ndias, numeras, dttrans
                FROM SigCdMei
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorItens))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar itens:" + CHR(13) + loException.Message, "TmeBO.BuscarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarTitulos - Carrega grid de Titulos (SigCdMeT) do transporte
    * Legado: CsTitulo (TipoEmps, Emps, Dopes, cIdChaves, cNotas)
    *====================================================================
    PROCEDURE BuscarTitulos(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorTitulos)
                USE IN (THIS.this_cCursorTitulos)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, cnotas, empds
                FROM SigCdMet
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTitulos))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar t" + CHR(237) + "tulos:" + CHR(13) + loException.Message, "TmeBO.BuscarTitulos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarOperacoesDisponiveis - Lista de operacoes para o lookup da
    * coluna "Operacao" do grid de Titulos (Pagina Titulos/Pag/Rec/Lote
    * Chq). Legado: CrSigOpOpe (Init) = SELECT Dopes FROM SigOpOpe + 3
    * operacoes especiais fixas que nao existem na tabela (PAGAMENTO,
    * RECEBIMENTO, LOTE DE CHEQUE) - tratadas apenas nesta pagina.
    * Retorna cursor_4c_Operacoes (dopes), indexado por dopes.
    *====================================================================
    PROCEDURE BuscarOperacoesDisponiveis()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT dopes FROM SigOpOpe"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("PAGAMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("RECEBIMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("LOTE DE CHEQUE")
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es dispon" + CHR(237) + "veis:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "TmeBO.BuscarOperacoesDisponiveis")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
