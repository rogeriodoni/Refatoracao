*====================================================================
* TptBO.prg
*
* Business Object para Cadastro de Tipos de Transporte
* Tabela: SigPrTrn
* Herda de: BusinessBase
*
* NOTA: O legado (SIGCDTPT) abre a tabela SigPrTrn via
* AddCursor('SigPrTrn', 'Codigos', 'crSigPrTrn', ...) e TODOS os campos
* da Pagina.Dados usam ControlSource = "crSigPrTrn.<campo>". A tabela
* SigPrTro (cidchaves) e um cursor auxiliar usado apenas internamente
* pelo botao "Copiar" (SIGCDTPT.Pagina.Lista.cntCopiar.CmdOk) para
* duplicar registros de subtipos (SigPrTro.tptrans) quando o codigo do
* transporte e alterado - nao e a tabela principal do formulario.
*====================================================================

DEFINE CLASS TptBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTrn)
    this_cCodigo               = ""    && codigos    char(6)  - PK
    this_cDescricao            = ""    && descrs     char(20)
    this_cExtensao             = ""    && extensao   char(3)  - extensao do arquivo de transporte
    this_cGeracao              = ""    && drivets    char(60) - diretorio de geracao do transporte
    this_cLeitura               = ""    && drivels    char(60) - diretorio de leitura do zip
    this_cRecepcao             = ""    && drivers    char(60) - diretorio de recepcao do transporte
    this_cArquivar             = ""    && paths      char(60) - diretorio de arquivamento
    this_cTipoConexao          = ""    && tpconexao  char(1)  - D=Dial-Up / B=Banda Larga
    this_cFtpEndereco          = ""    && ftpend     char(50)
    this_cFtpUsuario           = ""    && ftpusuario char(30)
    this_cFtpSenha             = ""    && ftpsenha   char(20)
    this_cDirFtpEnvio          = ""    && dirftpts   char(60) - pasta de envio no FTP
    this_cDirFtpRecepcao       = ""    && dirftpls   char(60) - pasta de recepcao no FTP
    this_lLimpaDirLocal        = .F.   && locdel     bit      - limpa diretorio local apos envio
    this_lLimpaDirFtp          = .F.   && ftpdel     bit      - limpa diretorio do FTP apos recepcao
    this_nTransporteOk         = 0     && clrarqs    numeric(3,0) - qtde de arquivos p/ considerar transporte ok
    this_lNaoChecarSequencia   = .F.   && nchkseqs   bit      - nao checar sequencia de recepcao
    this_lExecutarMudaConta    = .F.   && exmudcts   numeric(1,0) - executar muda conta na recepcao dos dados

    *-- Propriedades transitorias (nao persistidas em SigPrTrn)
    this_cSenhaRedigita        = ""    && Get_senha2 (ControlSource vazio) - confirmacao da senha do FTP
    this_nProximoTransporte    = 0     && Get_Transp  - proximo numero de transporte (SigSySeq)
    this_nProximoRecebe        = 0     && get_Recebe  - proximo numero de recebimento (SigSySeq)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTrn"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TptBO.Init")
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
    *
    * NOTA: as colunas 'extens' (char(3)) e 'tipos' (numeric(1,0)) sao
    * NOT NULL na tabela SigPrTrn mas nao existem em NENHUM ponto do
    * codigo fonte legado (nem ControlSource, nem .pColuna, nem Valid) -
    * sao colunas invisiveis (regra #22 do CLAUDE.md). 'extens' e gemea
    * de 'extensao' (que o legado usa de fato via getExtens); 'tipos' nao
    * tem gemea. Nenhuma das duas vira propriedade do BO: sao gravadas
    * com default fixo no INSERT e nunca tocadas no UPDATE.
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo             = TratarNulo(codigos,    "C")
                THIS.this_cDescricao          = TratarNulo(descrs,     "C")
                THIS.this_cExtensao           = TratarNulo(extensao,   "C")
                THIS.this_cGeracao            = TratarNulo(drivets,    "C")
                THIS.this_cLeitura            = TratarNulo(drivels,    "C")
                THIS.this_cRecepcao           = TratarNulo(drivers,    "C")
                THIS.this_cArquivar           = TratarNulo(paths,      "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_lLimpaDirLocal      = ConverterParaLogico(locdel)
                THIS.this_lLimpaDirFtp        = ConverterParaLogico(ftpdel)
                THIS.this_nTransporteOk       = TratarNulo(clrarqs,    "N")
                THIS.this_lNaoChecarSequencia = ConverterParaLogico(nchkseqs)
                THIS.this_lExecutarMudaConta  = ConverterParaLogico(exmudcts)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TptBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito de SIGCDTPT.Pagina.Dados.Grupo_Salva.Salva.Click:
    * Codigo obrigatorio + Codigo Ja Cadastrado (checado so no INSERT)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    * Equivalente ao ChkRegister('SigPrTrn', 'Codigos', ...) do legado
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTrn" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TptBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTrn
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTrn (codigos, descrs, extens, tipos, clrarqs,
                    dirftpls, dirftpts, drivels, drivers, drivets, extensao,
                    ftpdel, ftpend, ftpsenha, ftpusuario, locdel, tpconexao,
                    nchkseqs, paths, exmudcts)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL("")>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cLeitura)>>,
                    <<EscaparSQL(THIS.this_cRecepcao)>>,
                    <<EscaparSQL(THIS.this_cGeracao)>>,
                    <<EscaparSQL(THIS.this_cExtensao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirLocal, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cArquivar)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lExecutarMudaConta, 1, 0), 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TptBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTrn
    * NOTA: 'extens' e 'tipos' nunca sao tocados no UPDATE (regra #22 -
    * colunas invisiveis, sem property, gravadas so uma vez no INSERT)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTrn
                SET descrs      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    clrarqs     = <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    dirftpls    = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    dirftpts    = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    drivels     = <<EscaparSQL(THIS.this_cLeitura)>>,
                    drivers     = <<EscaparSQL(THIS.this_cRecepcao)>>,
                    drivets     = <<EscaparSQL(THIS.this_cGeracao)>>,
                    extensao    = <<EscaparSQL(THIS.this_cExtensao)>>,
                    ftpdel      = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    ftpend      = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpsenha    = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    ftpusuario  = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    locdel      = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirLocal, 1, 0), 0)>>,
                    tpconexao   = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    nchkseqs    = <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    paths       = <<EscaparSQL(THIS.this_cArquivar)>>,
                    exmudcts    = <<FormatarNumeroSQL(IIF(THIS.this_lExecutarMudaConta, 1, 0), 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TptBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTrn
    * NOTA: o dump legado nao mostra override do case Excluir no
    * Grupo_op.Click (usa o comportamento padrao do frmcadastro, sem
    * checagem de dependencia visivel) - transcrito como DELETE simples
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrn WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TptBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descrs, extensao (colunas
    * exatas do Grid legado: .pColuna('Codigos'...), ('Descrs'...), ('Extensao'...))
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(6), descrs C(20), extensao C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descrs, extensao FROM SigPrTrn"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TptBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codigos, descrs, extensao, drivets, drivels, drivers,
                    paths, tpconexao, ftpend, ftpusuario, ftpsenha, dirftpts,
                    dirftpls, locdel, ftpdel, clrarqs, nchkseqs, exmudcts
                FROM SigPrTrn WHERE codigos = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TptBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
