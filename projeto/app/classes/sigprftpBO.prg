*==============================================================================
* sigprftpBO.prg - Business Object para Transferencia FTP
* Data: 2026-07-16
* Form Operacional: Transferencia e Recebimento de Arquivos via FTP
* Tabelas: SigCdPam (parametros globais), SigCdEmp (config. por empresa)
*==============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *-- Configuracao de conexao FTP (carregados de SigCdPam/SigCdEmp)
    this_cTpConnect  = ""    && Tipo de conexao: "D"=Dial-Up, "B"=Broadband/Direto
    this_cFtpAdd     = ""    && Endereco do servidor FTP
    this_cFtpUser    = ""    && Usuario FTP
    this_cFtpPass    = ""    && Senha FTP
    this_cDirEnvFtp  = ""    && Dir local de origem para envio ao FTP (_direnvftp)
    this_cDirRecFtp  = ""    && Dir local de destino ao receber do FTP (_dirrecftp)
    this_cDirEnvLoc  = ""    && Dir remoto FTP de origem para recebimento (_direnvloc)
    this_cDirRecLoc  = ""    && Dir remoto FTP de destino para envio (_dirrecloc)
    this_lDelLocal   = .F.   && Excluir arquivo local apos transferencia
    this_lDelHost    = .F.   && Excluir arquivo no FTP apos recebimento
    this_cTpEnv      = ""    && Mascara de arquivos para envio (ex: "*.*")
    this_cTpRec      = ""    && Mascara de arquivos para recebimento (ex: "*.*")
    this_nTpConect   = 0     && Tipo execucao: 0=manual, 1=auto-envio, 2=auto-recebimento

    *-- Parametros globais do sistema (SigCdPam)
    this_cTpTrans    = ""    && tptrans    char(6)  - Tipo de transacao
    this_cEmpMasters = ""    && empmasters char(3)  - Empresa master
    this_cGruMccrs   = ""    && grumccrs   char(10) - Grupo Mercosul
    this_cConMccrs   = ""    && conmccrs   char(10) - Conta Mercosul
    this_cVendNts    = ""    && vendnts    char(10) - Vendas NTS

    *-- Configuracao FTP da empresa (SigCdEmp)
    this_cTpConexaoEmp = ""  && tpconexao  char(1)  - Tipo de conexao da empresa
    this_cFtpAddEmp    = ""  && ftpend     char(50) - Endereco FTP da empresa
    this_cFtpUserEmp   = ""  && ftpusuario char(50) - Usuario FTP da empresa
    this_cFtpPassEmp   = ""  && ftpsenha   char(20) - Senha FTP da empresa (criptografada)
    this_cDriveTs      = ""  && drivets    char(60) - Drive/dir local de envio para FTP
    this_cDriveLs      = ""  && drivels    char(60) - Drive/dir local de recebimento do FTP
    this_cDirFtpTs     = ""  && dirftpts   char(60) - Diretorio remoto FTP de destino (envio)
    this_cDirFtpLs     = ""  && dirftpls   char(60) - Diretorio remoto FTP de origem (recebimento)
    this_lLocDel       = .F. && locdel     bit      - Excluir local apos transferencia
    this_lFtpDel       = .F. && ftpdel     bit      - Excluir do FTP apos recebimento

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPam"
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cTpTrans    = TratarNulo(TpTrans,    "C")
                    THIS.this_cEmpMasters = TratarNulo(EmpMasters, "C")
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs,   "C")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs,   "C")
                    THIS.this_cVendNts    = TratarNulo(VendNts,    "C")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do sistema (SigCdPam) n" + CHR(227) + "o encontrados"
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracaoEmpresa - Carrega config FTP de SigCdEmp
    * par_cCodEmp: codigo da empresa (Cemps)
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracaoEmpresa(par_cCodEmp)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpConexao, FtpEnd, FtpUsuario, FtpSenha, " + ;
                       "DriveTs, DriveLs, DirFtpTs, DirFtpLs, " + ;
                       "LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(par_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                    THIS.CarregarDoCursor("cursor_4c_Emp")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + ALLTRIM(par_cCodEmp) + ;
                                              " n" + CHR(227) + "o cadastrada"
                ENDIF
                IF USED("cursor_4c_Emp")
                    USE IN cursor_4c_Emp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdEmp"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega config FTP do cursor SigCdEmp para this_*
    * par_cAliasCursor: nome do cursor com dados de SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTpConexaoEmp = TratarNulo(TpConexao,  "C")
                THIS.this_cFtpAddEmp    = TratarNulo(FtpEnd,     "C")
                THIS.this_cFtpUserEmp   = TratarNulo(FtpUsuario, "C")
                THIS.this_cFtpPassEmp   = TratarNulo(FtpSenha,   "C")
                THIS.this_cDriveTs      = TratarNulo(DriveTs,    "C")
                THIS.this_cDriveLs      = TratarNulo(DriveLs,    "C")
                THIS.this_cDirFtpTs     = TratarNulo(DirFtpTs,   "C")
                THIS.this_cDirFtpLs     = TratarNulo(DirFtpLs,   "C")
                THIS.this_lLocDel       = IIF(VARTYPE(LocDel) = "L", LocDel, .F.)
                THIS.this_lFtpDel       = IIF(VARTYPE(FtpDel) = "L", FtpDel, .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel (form operacional sem CRUD direto)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (form operacional - sem INSERT em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (form operacional - sem UPDATE em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

ENDDEFINE
