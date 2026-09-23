*====================================================================
* traBO.prg
*
* Business Object para Cadastro de Transportadoras
* Tabela: SigPrTrp (cabecalho) / SigPrTrv (fretes por estado - detalhe)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS traBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTrp)
    this_cCodigo             = ""    && itras char(10) - PK
    this_nCodigoSequencial   = 0     && codigos numeric(6,0) - sequencial usado para gerar o itras
    this_cRazaoSocial        = ""    && razaos char(40)
    this_cEndereco           = ""    && endes char(40)
    this_cBairro             = ""    && bairs char(20)
    this_cCidade             = ""    && cidas char(30)
    this_cCep                = ""    && ceps char(9)
    this_cUf                 = ""    && estas char(2)
    this_cTelefone1          = ""    && tel1s char(20)
    this_cTelefone2          = ""    && tel2s char(20)
    this_cFax                = ""    && faxs char(20)
    this_cCgc                = ""    && cgcs char(20)
    this_cInscricaoEstadual  = ""    && inscs char(20)
    this_cApelido            = ""    && apelidos char(30) NULL
    this_cIdTransportadora   = ""    && idtransp char(50) - rotulado "ID E-Commerce" no legado
    this_cTipoConexao        = ""    && tpconexao char(1) - D/B (Dial-Up / Banda Larga)
    this_cFtpEndereco        = ""    && ftpend char(50)
    this_cFtpUsuario         = ""    && ftpusuario char(50)
    this_cFtpSenha           = ""    && ftpsenha char(20)
    this_cDirFtpEnvio        = ""    && dirftpts char(60) - "Pasta p/ Envio"
    this_cDirFtpRecepcao     = ""    && dirftpls char(60) - "Pasta p/ Recepcao"
    this_cDriveGeracao       = ""    && drivets char(60) - "Geracao"
    this_cDriveLeitura       = ""    && drivels char(60) - "Leitura"
    this_lLimpaDiretorioFtp  = .F.   && ftpdel bit NULL
    this_lLimpaDiretorioLocal = .F.  && locdel bit NULL
    this_cUrlTransp          = ""    && urltransp char(200)
    this_nTipoTransporte     = 0     && tipotrans numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTrp"
            THIS.this_cCampoChave = "itras"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "traBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
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
                THIS.this_cCodigo             = TratarNulo(itras,      "C")
                THIS.this_cRazaoSocial        = TratarNulo(razaos,     "C")
                THIS.this_nCodigoSequencial   = TratarNulo(codigos,    "N")
                THIS.this_cEndereco           = TratarNulo(endes,      "C")
                THIS.this_cBairro             = TratarNulo(bairs,      "C")
                THIS.this_cCidade             = TratarNulo(cidas,      "C")
                THIS.this_cCep                = TratarNulo(ceps,       "C")
                THIS.this_cUf                 = TratarNulo(estas,      "C")
                THIS.this_cTelefone1          = TratarNulo(tel1s,      "C")
                THIS.this_cTelefone2          = TratarNulo(tel2s,      "C")
                THIS.this_cFax                = TratarNulo(faxs,       "C")
                THIS.this_cCgc                = TratarNulo(cgcs,       "C")
                THIS.this_cInscricaoEstadual  = TratarNulo(inscs,      "C")
                THIS.this_cApelido            = TratarNulo(apelidos,   "C")
                THIS.this_cIdTransportadora   = TratarNulo(idtransp,   "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_cDriveGeracao       = TratarNulo(drivets,    "C")
                THIS.this_cDriveLeitura       = TratarNulo(drivels,    "C")
                THIS.this_lLimpaDiretorioFtp  = ConverterParaLogico(ftpdel)
                THIS.this_lLimpaDiretorioLocal = ConverterParaLogico(locdel)
                THIS.this_cUrlTransp          = TratarNulo(urltransp,  "C")
                THIS.this_nTipoTransporte     = TratarNulo(tipotrans,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "traBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Gera codigo (itras) para novo registro
    * Legado: m.Codigos = fGerUniqueKey('SigPrTrp' + _Empr)
    *         m.Itras   = 'T' + _Empr + Padl(m.codigos, 6, '0')
    * Aqui o sequencial vem do MAX(codigos) da propria tabela (seguro entre
    * sessoes), e _Empr (legado) -> go_4c_Sistema.cCodEmpresa
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        LOCAL loc_cSQL, loc_nResultado, loc_nSeq, loc_cEmpresa
        loc_nSeq = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos),0) AS maxval FROM SigPrTrp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_SeqTra")
                SELECT cursor_4c_SeqTra
                loc_nSeq = NVL(cursor_4c_SeqTra.maxval, 0) + 1
                USE IN cursor_4c_SeqTra
            ENDIF
        CATCH TO loException
            loc_nSeq = 1
        ENDTRY

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
            ALLTRIM(go_4c_Sistema.cCodEmpresa), "")

        THIS.this_nCodigoSequencial = loc_nSeq
        THIS.this_cCodigo           = "T" + loc_cEmpresa + PADL(TRANSFORM(loc_nSeq), 6, "0")
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado."
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cRazaoSocial))
            THIS.this_cMensagemErro = "Raz" + CHR(227) + "o Social " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se itras ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTrp" + ;
                " WHERE itras = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTra")
                SELECT cursor_4c_ChkTra
                loc_lExiste = (cursor_4c_ChkTra.qtd > 0)
                USE IN cursor_4c_ChkTra
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "traBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTrp (itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls, dirftpts,
                    drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario, locdel, tpconexao,
                    urltransp, tipotrans)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodigoSequencial, 0)>>,
                    <<EscaparSQL(THIS.this_cEndereco)>>,
                    <<EscaparSQL(THIS.this_cBairro)>>,
                    <<EscaparSQL(THIS.this_cCidade)>>,
                    <<EscaparSQL(THIS.this_cCep)>>,
                    <<EscaparSQL(THIS.this_cUf)>>,
                    <<EscaparSQL(THIS.this_cTelefone1)>>,
                    <<EscaparSQL(THIS.this_cTelefone2)>>,
                    <<EscaparSQL(THIS.this_cFax)>>,
                    <<EscaparSQL(THIS.this_cCgc)>>,
                    <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    <<EscaparSQL(THIS.this_cApelido)>>,
                    <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "traBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTrp
                SET razaos      = <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    endes       = <<EscaparSQL(THIS.this_cEndereco)>>,
                    bairs       = <<EscaparSQL(THIS.this_cBairro)>>,
                    cidas       = <<EscaparSQL(THIS.this_cCidade)>>,
                    ceps        = <<EscaparSQL(THIS.this_cCep)>>,
                    estas       = <<EscaparSQL(THIS.this_cUf)>>,
                    tel1s       = <<EscaparSQL(THIS.this_cTelefone1)>>,
                    tel2s       = <<EscaparSQL(THIS.this_cTelefone2)>>,
                    faxs        = <<EscaparSQL(THIS.this_cFax)>>,
                    cgcs        = <<EscaparSQL(THIS.this_cCgc)>>,
                    inscs       = <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    apelidos    = <<EscaparSQL(THIS.this_cApelido)>>,
                    idtransp    = <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    dirftpls    = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    dirftpts    = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    drivels     = <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    drivets     = <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    ftpdel      = <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    ftpend      = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpsenha    = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    ftpusuario  = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    locdel      = <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    tpconexao   = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    urltransp   = <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    tipotrans   = <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                WHERE itras = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "traBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTrp e os fretes
    * por estado associados (SigPrTrv), espelhando o legado
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir fretes da transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrTrp WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "traBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com itras, razaos, tel1s
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (itras C(10), razaos C(40), tel1s C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT itras, razaos, tel1s FROM SigPrTrp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY razaos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "traBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (itras)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls,
                    dirftpts, drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario,
                    locdel, tpconexao, urltransp, tipotrans
                FROM SigPrTrp
                WHERE itras = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Transportadora n" + CHR(227) + "o encontrada!"
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "traBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
