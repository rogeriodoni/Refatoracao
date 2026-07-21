*==============================================================================
* sigtosenBO.prg - Business Object para Autenticacao/Login do Sistema
* Data: 2026-04-15
* Tabela: (sem tabela - formulario de autenticacao)
* Ref: tasks/task017/sigtosen_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS sigtosenBO AS BusinessBase

    *-- Credenciais do usuario
    this_cUsuario        = ""    && usuarios  CHAR(10) - Login do usu" + CHR(225) + "rio
    this_cSenha          = ""    && senhas    CHAR(10) - Senha (criptografada)
    this_cEmpresa        = ""    && cemps     CHAR(3)  - C" + CHR(243) + "digo da empresa selecionada
    this_cDescEmpresa    = ""    && razas     CHAR(40) - Descri" + CHR(231) + CHR(227) + "o da empresa
    this_cTipoEmpresa    = ""    && tipos     CHAR     - Tipo da empresa

    *-- Estado de autenticacao
    this_lUsuarioOk      = .F.  && plUsuarioOk  - Usu" + CHR(225) + "rio validado com sucesso
    this_lGetUsuario     = .T.  && plGetUsuario  - Solicitar usu" + CHR(225) + "rio na tela
    this_nBloqueiaSenha  = 1    && pnBloqueiaSenha - Contador de tentativas de senha
    this_cUsuarioAtual   = ""   && pcUsuarioAtual  - Usu" + CHR(225) + "rio logado anteriormente

    *-- Perfil do usuario autenticado
    this_cTipoUsuario    = ""   && gcTipoUsuario - Tipo: 'i'=supervisor, 'n'=normal (C(11))
    this_cSupervis       = ""   && supervis      - Flag supervisor no banco (C)
    this_lObrigSenha     = .F.  && ObrigSenhas   - Usu" + CHR(225) + "rio obrigado a trocar senha
    this_dDtSenha        = {}   && tDtSenhas     - Data da " + CHR(250) + "ltima troca de senha

    *-- Parametros do sistema carregados no login
    this_nDock           = 0    && ndocks    N  - Posicao da barra de atalhos
    this_nTmpChk         = 0    && ntmpchks  N  - Timeout checagem
    this_nTmpApp         = 0    && ntmpapps  N  - Timeout aplicacao
    this_nDiaSenha       = 0    && nDiaSenhas N  - Dias para expiracao de senha
    this_nBloSenha       = 0    && nBloSenhas N  - Max tentativas antes de bloquear
    this_nPafEcf         = 0    && PafEcfs   N  - Flag PAF-ECF ativo
    this_nAlertas        = 0    && Alertas   N  - Tipo de alertas configurado
    this_cNomePrograma   = ""   && nomeprograma  - Nome do programa chamador

    *-- Dados de licenciamento
    this_nUsoLicencas    = 0    && UsoLicencas N  - Quantidade de licencas em uso

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object de autenticacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cUsuario
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do cursor crsigcdusu1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cUsuario     = TratarNulo(usuarios, "C")
                THIS.this_cSenha       = TratarNulo(senhas, "C")
                THIS.this_cTipoUsuario = TratarNulo(supervis, "C")
                THIS.this_dDtSenha     = TratarNulo(tDtSenhas, "D")
                THIS.this_lObrigSenha = IIF(VARTYPE(ObrigSenhas) = "L", ObrigSenhas, (NVL(ObrigSenhas, 0) = 1))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuario - Consulta usuario no banco e carrega permissoes de acesso
    * Par: par_cUsuario - Login digitado
    * Ret: .T. se usuario encontrado e ativo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_cSupervis, loc_cUsuarioPad

        loc_lSucesso = .F.
        loc_cUsuarioPad = PADR(ALLTRIM(par_cUsuario), 10)

        TRY
            IF Used("crsigcdusu1")
                USE IN ("crsigcdusu1")
            ENDIF

            loc_cSQL = "select a.usuarios,a.senhas,a.supervis,a.tdtsenhas,a.ObrigSenhas" + ;
                       " from sigcdusu a" + ;
                       " where not a.cativos='N' and a.usuarios='" + ALLTRIM(loc_cUsuarioPad) + "'" + ;
                       " order by 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crsigcdusu1") > 0
                IF USED("crsigcdusu1")
                    SELECT ("crsigcdusu1")
                    LOCATE
                    IF NOT EOF("crsigcdusu1")
                        THIS.CarregarDoCursor("crsigcdusu1")

                        loc_cSupervis = PADR(LOWER(ALLTRIM(crsigcdusu1.supervis)), 1)
                        DO CASE
                            CASE UPPER(ALLTRIM(crsigcdusu1.usuarios)) = "4CONTROL"
                                loc_cSupervis = "i"
                            OTHERWISE
                                loc_cSupervis = "n"
                        ENDCASE

                        THIS.this_cTipoUsuario = loc_cSupervis + crsigcdusu1.usuarios
                        THIS.CarregarAcessos(loc_cUsuarioPad, loc_cSupervis)
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Carrega permissoes de acesso do usuario em gaAcesso
    * Par: par_cUsuario - Login do usuario
    *      par_cTipoSupervis - Tipo: 'i'=supervisor, 's'=supervisor normal, 'n'=normal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessos(par_cUsuario, par_cTipoSupervis)
        LOCAL loc_cSQL, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdAcU1")
                USE IN ("crSigCdAcU1")
            ENDIF

            loc_cSQL = ""

            DO CASE
                CASE par_cTipoSupervis = "s"
                    loc_cSQL = "Select Distinct Programas, Parametros" + ;
                               " From sigcdprg" + ;
                               " Where Not Programas = '" + SPACE(10) + "'" + ;
                               " Order By Programas, Parametros"

                CASE NOT INLIST(par_cTipoSupervis, "s", "i")
                    loc_cSQL = "Select Distinct a.programas,a.parametros" + ;
                               " From SigCdAcU a" + ;
                               " Where Not a.programas = '" + SPACE(15) + "'" + ;
                               " And a.usuarios = '" + ALLTRIM(par_cUsuario) + "'" + ;
                               " Group By a.programas, a.parametros" + ;
                               " Union All" + ;
                               " Select Distinct a.programas,a.parametros" + ;
                               " From SigCdAcU a" + ;
                               " Left Outer Join SigCdAcG b On a.grupos = b.grupos" + ;
                               " Where Not a.programas = '" + SPACE(15) + "'" + ;
                               " And b.usuarios = '" + ALLTRIM(par_cUsuario) + "'" + ;
                               " Group By a.programas, a.parametros" + ;
                               " Order by 1, 2"
            ENDCASE

            IF NOT EMPTY(loc_cSQL)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdAcU1") > 0
                    PUBLIC ARRAY gaAcesso(1, 1)
                    gaAcesso = ""
                    SELECT DISTINCT (a.Programas + a.Parametros) ;
                      FROM crSigCdAcU1 a ;
                     ORDER BY 1 ;
                      INTO ARRAY gaAcesso
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                *-- Supervisor 'i': acesso total, nao precisa carregar array
                PUBLIC ARRAY gaAcesso(1, 1)
                gaAcesso = ""
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega empresas permitidas para o usuario
    * Par: par_cUsuario     - Login do usuario
    *      par_lSupervisor  - .T. se supervisor (ve todas empresas)
    * Ret: .T. se carregou cursor crEmpresa1 com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cUsuario, par_lSupervisor)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("crEmpresa1")
                USE IN ("crEmpresa1")
            ENDIF

            IF par_lSupervisor
                loc_cSQL = "select a.cemps,a.razas,a.tipos,a.logos" + ;
                           " from SigCdEmp a order by a.cemps"
            ELSE
                loc_cSQL = "Select b.Cemps, b.Razas, b.Tipos, b.Logos" + ;
                           " From SigCdAcE a" + ;
                           " Inner Join SigCdEmp b On b.Cemps = a.Cemps" + ;
                           " Where a.Usuarios = '" + ALLTRIM(par_cUsuario) + "'" + ;
                           " And Not b.Ativas = 2" + ;
                           " Order By b.Cemps"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1") > 0
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros do sistema (SigCdPam e SigCdPac)
    * Ret: .T. se ambos cursores carregados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet1, loc_nRet2

        loc_lSucesso = .F.

        TRY
            IF USED("crParam1")
                USE IN ("crParam1")
            ENDIF
            IF USED("crParam2")
                USE IN ("crParam2")
            ENDIF

            loc_cSQL = "select a.ndocks,a.ntmpchks,a.ntmpapps from SigCdPam a order by 1"
            loc_nRet1 = SQLEXEC(gnConnHandle, loc_cSQL, "crParam1")

            loc_cSQL = "select a.ndiasenhas,a.nblosenhas,a.PafEcfs,a.Alertas" + ;
                       " from SigCdPac a order by 1"
            loc_nRet2 = SQLEXEC(gnConnHandle, loc_cSQL, "crParam2")

            IF loc_nRet1 > 0 AND USED("crParam1")
                SELECT ("crParam1")
                LOCATE
                IF NOT EOF("crParam1")
                    THIS.this_nDock    = NVL(crParam1.ndocks, 0)
                    THIS.this_nTmpChk  = NVL(crParam1.ntmpchks, 0)
                    THIS.this_nTmpApp  = NVL(crParam1.ntmpapps, 0)
                ENDIF
            ENDIF

            IF loc_nRet2 > 0 AND USED("crParam2")
                SELECT ("crParam2")
                LOCATE
                IF NOT EOF("crParam2")
                    THIS.this_nDiaSenha = NVL(crParam2.nDiaSenhas, 0)
                    THIS.this_nBloSenha = NVL(crParam2.nBloSenhas, 0)
                    THIS.this_nPafEcf   = NVL(crParam2.PafEcfs, 0)
                    THIS.this_nAlertas  = NVL(crParam2.Alertas, 0)
                ENDIF
            ENDIF

            loc_lSucesso = (loc_nRet1 > 0 AND loc_nRet2 > 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Verifica se empresa existe em crEmpresa1
    * Par: par_cEmpresa - Codigo da empresa (3 chars)
    * Ret: .T. se empresa encontrada, .F. se nao encontrada
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                loc_cSQL = "select a.cemps,a.razas,a.tipos,a.logos from SigCdEmp a order by 1"
                IF USED("crEmpresa1")
                    USE IN ("crEmpresa1")
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1")
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) = LOWER(ALLTRIM(par_cEmpresa))
                IF NOT EOF("crEmpresa1")
                    THIS.this_cEmpresa    = ALLTRIM(crEmpresa1.cemps)
                    THIS.this_cDescEmpresa = ALLTRIM(crEmpresa1.razas)
                    THIS.this_cTipoEmpresa = ALLTRIM(crEmpresa1.tipos)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BloquearSenha - Bloqueia usuario apos exceder tentativas de senha
    * Par: par_cUsuario - Login do usuario a bloquear
    * Ret: .T. se UPDATE executado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE BloquearSenha(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaSenha

        loc_lSucesso = .F.

        TRY
            loc_cNovaSenha = SYS(2015)
            loc_cSQL = "update sigcdusu set senhas=" + EscaparSQL(loc_cNovaSenha) + ;
                       " where usuarios=" + EscaparSQL(ALLTRIM(par_cUsuario))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMenuPrincipal - Carrega estrutura de menus e operacoes do sistema
    * Carrega cursores: SigCdOpe, SigCdPam, SigCdOpd, SigCdGpe, SigOpOpe, SigSyCcb
    * Par: par_cEmpresa - Codigo da empresa logada
    * Ret: .T. se todos cursores carregados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMenuPrincipal(par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            *-- Operacoes do sistema
            loc_cSQL = "Select Distinct a.Dopes, a.Menus, a.SubMenus, a.CCentrals," + ;
                       " a.NDopes, a.Ordes, a.EmpLancs, b.Opeinatvs, d.ConfigGers" + ;
                       " From SigCdOpe a" + ;
                       " Left Join SigOpCdc b On a.Dopes = b.Dopes" + ;
                       " Left Join SigOpCdd d On a.Dopes = d.Dopes"

            IF USED("crTmpOpe")
                USE IN ("crTmpOpe")
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpOpe")

            IF loc_nRet > 0 AND USED("crTmpOpe")
                SELECT crTmpOpe
                INDEX ON STR(NDopes, 10, 0) TAG nDopes
                UPDATE crTmpOpe SET ConfigGers = NVL(ConfigGers, "")

                *-- Filtro final de operacoes com menu
                IF USED("SigCdOpe")
                    USE IN ("SigCdOpe")
                ENDIF
                SELECT a.* FROM crTmpOpe a ;
                    WHERE NOT a.Menus = SPACE(10) ;
                    ORDER BY a.Menus, a.SubMenus, a.Ordes, a.EmpLancs ;
                    INTO CURSOR SigCdOpe READWRITE

                IF USED("crTmpOpe")
                    USE IN ("crTmpOpe")
                ENDIF
            ENDIF

            *-- Dados da empresa logada
            loc_cSQL = "select a.comiss,a.PPLinha1s,a.PPLinha2s,a.nEmps" + ;
                       " from SigCdEmp a where a.cemps='" + ALLTRIM(par_cEmpresa) + "'"
            IF USED("SigCdEmp")
                USE IN ("SigCdEmp")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdEmp")
            IF USED("SigCdEmp")
                SELECT ("SigCdEmp")
                LOCATE
            ENDIF

            *-- Parametros PAM
            loc_cSQL = "select a.desmontas,a.habembs,a.habcors,a.habtams,a.habtifs,a.SisTef,a.NumIps" + ;
                       " from SigCdPam a"
            IF USED("SigCdPam")
                USE IN ("SigCdPam")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdPam")

            *-- Tabela de cores/configuracoes
            loc_cSQL = "Select * From SigSyCcb Order By Tits"
            IF USED("SigSyCcb")
                USE IN ("SigSyCcb")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigSyCcb")
            IF USED("SigSyCcb")
                SELECT ("SigSyCcb")
                INDEX ON Tits TAG Tits
            ENDIF

            *-- Operacoes do dashboard (menu = 1)
            loc_cSQL = "Select Distinct Dopps, Menus, Pccs, Ordes, NDopps, Emplancs" + ;
                       " From SigCdOpd" + ;
                       " Where Menus = 1" + ;
                       " Order By Menus, Ordes"
            IF USED("SigCdOpd")
                USE IN ("SigCdOpd")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdOpd")
            IF USED("SigCdOpd")
                SELECT ("SigCdOpd")
                INDEX ON dopps TAG dopps
                INDEX ON ordes TAG ordes
            ENDIF

            *-- Grupos de operacoes
            loc_cSQL = "Select Distinct NGopes, DGopes, '   ' as EmpLancs" + ;
                       " From SigCdGpe" + ;
                       " Order By NGopes, DGopes"
            IF USED("SigCdGpe")
                USE IN ("SigCdGpe")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdGpe")
            IF USED("SigCdGpe")
                SELECT ("SigCdGpe")
                INDEX ON dgopes TAG dgopes
            ENDIF

            *-- Operacoes por opcao
            loc_cSQL = "Select Distinct NDopes, Dopes From SigOpOpe Order By NDopes, Dopes"
            IF USED("SigOpOpe")
                USE IN ("SigOpOpe")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigOpOpe")
            IF USED("SigOpOpe")
                SELECT ("SigOpOpe")
                INDEX ON dopes TAG dopes
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarLicencas - Verifica disponibilidade de licencas de uso
    * Par: par_cUsuario - Login do usuario
    * Ret: nLicUsadas - Numero de licencas em uso (ou 0 se usuario 4CONTROL)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarLicencas(par_cUsuario)
        LOCAL loc_nLicUsadas, loc_cSQL

        loc_nLicUsadas = 0

        TRY
            loc_cSQL = "If Exists(Select 1 From SigSyCtl" + ;
                       " where LIC_Stat = 'A'" + ;
                       " and Left(LIC_Usua,10) = '" + PADR(ALLTRIM(par_cUsuario), 10) + "'" + ;
                       " and Lic_Maqs = '" + SYS(0) + "')" + ;
                       " select 1 as LicUsos else" + ;
                       " Select Count(1) as LicUsos From SigSyCtl Where LIC_Stat = 'A'"

            IF USED("LocClsTmp")
                USE IN ("LocClsTmp")
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocClsTmp") > 0
                IF USED("LocClsTmp")
                    GO TOP IN LocClsTmp
                    IF NOT EOF("LocClsTmp")
                        loc_nLicUsadas = NVL(LocClsTmp.LicUsos, 0)
                    ENDIF
                    USE IN LocClsTmp
                ENDIF
            ENDIF

            THIS.this_nUsoLicencas = loc_nLicUsadas
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nLicUsadas
    ENDPROC

    *--------------------------------------------------------------------------
    * AlertaPafReducaoZ - Verifica pendencias PAF-ECF e exibe alertas
    * Par: par_cEmpresa - Codigo da empresa logada
    * Ret: .T. se verificacao concluida (com ou sem alertas)
    *--------------------------------------------------------------------------
    PROCEDURE AlertaPafReducaoZ(par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_cMsg, loc_nQtde, loc_nQtdias

        loc_lSucesso = .F.
        loc_cMsg     = ""

        TRY
            *-- Verifica estado da empresa
            loc_cSQL = "select Estas From SigCdEmp Where Cemps = '" + ALLTRIM(par_cEmpresa) + "'"
            IF USED("csEstEmp")
                USE IN ("csEstEmp")
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csEstEmp") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (csEstEmp)")
                loc_lSucesso = .F.
            ENDIF

            SELECT csEstEmp
            IF ALLTRIM(UPPER(csEstEmp.Estas)) <> "SC"
                loc_lSucesso = .T.
            ENDIF

            *-- Busca pendencias PAF
            loc_cSQL = "Select * from Sigfipaf where status <> 'AUT'"
            IF USED("crSigfipaf")
                USE IN ("crSigfipaf")
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigfipaf") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigfipaf)")
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigfipaf
            GO TOP
            IF RECCOUNT() > 0
                *-- Pendencias Reducao Z
                SELECT COUNT(cidchaves) AS Qtde ;
                    FROM crSigfipaf ;
                    WHERE tipo = "REDUCAOZ" AND Status <> "AUT" ;
                    INTO CURSOR crPaf READWRITE

                loc_nQtde = crPaf.Qtde
                IF loc_nQtde > 0
                    loc_cMsg = "H" + CHR(225) + " " + ALLTRIM(STR(loc_nQtde)) + ;
                        " ARQUIVOS COM INFORMA" + CHR(199) + CHR(213) + "ES DA REDU" + CHR(199) + CHR(195) + "O Z DO PAF-ECF" + ;
                        " PENDENTES DE TRANSMISS" + CHR(195) + "O AO FISCO." + ;
                        " O CONTRIBUINTE PODE TRANSMITIR OS ARQUIVOS PELO MENU FISCAL" + ;
                        " POR MEIO DO COMANDO 'Envio ao FISCO-REDU" + CHR(199) + CHR(195) + "O Z'"
                ENDIF
                IF loc_nQtde >= 5 AND loc_nQtde <= 8
                    loc_cMsg = loc_cMsg + " VERIFIQUE COM O FORNECEDOR DO PROGRAMA A SOLU" + CHR(199) + CHR(195) + "O DA PEND" + CHR(202) + "NCIA."
                ENDIF
                IF loc_nQtde >= 9
                    loc_cMsg = loc_cMsg + ;
                        " A PARTIR DA 10" + CHR(170) + " TRANSMISS" + CHR(195) + "O PENDENTE," + ;
                        " O SEU PROGRAMA SER" + CHR(193) + " BLOQUEADO E SOMENTE SER" + CHR(193) + ;
                        " LIBERADO AP" + CHR(211) + "S TODAS AS TRANSMISS" + CHR(213) + "ES SEREM REALIZADAS." + ;
                        " VERIFIQUE URGENTEMENTE COM O FORNECEDOR DO PROGRAMA A SOLU" + CHR(199) + CHR(195) + "O DA PEND" + CHR(202) + "NCIA."
                ENDIF
                IF NOT EMPTY(loc_cMsg)
                    MsgAviso(loc_cMsg, "Aviso")
                ENDIF

                loc_cMsg = ""

                *-- Pendencias Estoque
                SELECT datager FROM crSigfipaf ;
                    WHERE tipo = "ESTOQUE" AND status <> "AUT" ;
                    INTO CURSOR crPaf READWRITE

                IF RECCOUNT("crPaf") > 0
                    loc_nQtdias = DATE() - TTOD(crPaf.datager)
                    IF loc_nQtdias > 0
                        loc_cMsg = "H" + CHR(193) + " UM ARQUIVO COM INFORMA" + CHR(199) + CHR(213) + "ES DO ESTOQUE MENSAL" + ;
                            " DO ESTABELECIMENTO PENDENTE DE TRANSMISS" + CHR(195) + "O AO FISCO." + ;
                            " O CONTRIBUINTE PODE TRANSMITIR O ARQUIVO PELO MENU FISCAL" + ;
                            " POR MEIO DO COMANDO 'Envio ao FISCO-ESTOQUE'."
                    ENDIF
                    IF loc_nQtdias > 9
                        loc_cMsg = loc_cMsg + " VERIFIQUE COM O FORNECEDOR DO PROGRAMA A SOLU" + CHR(199) + CHR(195) + "O DA PEND" + CHR(202) + "NCIA."
                    ENDIF
                    IF NOT EMPTY(loc_cMsg)
                        MsgAviso(loc_cMsg, "Aviso")
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSenha - Valida senha digitada contra banco de dados
    * Trata usuario especial 4CONTROL com senha diaria (fGerPswDiario)
    * Trata bloqueio apos exceder tentativas (crParam2.nBloSenhas)
    * Par: par_cSenhaDigitada - Senha digitada pelo usuario
    * Ret: .T. se senha valida, .F. se invalida
    *      this_lUsuarioOk atualizado com resultado
    *      Retorna mensagem de erro em par_cMensagem (por referencia)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSenha(par_cSenhaDigitada, par_cMensagem)
        LOCAL loc_lSucesso, loc_cSenhaPad
        loc_lSucesso = .F.
        par_cMensagem = ""

        loc_cSenhaPad = PADR(STRTRAN(STRTRAN(par_cSenhaDigitada, "'", " "), '"', " "), 10)

        TRY
            IF NOT USED("crParam2")
                THIS.CarregarParametros()
            ENDIF

            IF USED("crParam2")
                SELECT crParam2
                LOCATE
            ENDIF

            IF USED("crsigcdusu1")
                SELECT ("crsigcdusu1")
                SET ORDER TO ("") IN ("crsigcdusu1")
                LOCATE

                IF UPPER(ALLTRIM(THIS.this_cUsuario)) = "4CONTROL"
                    LOCAL loc_cSenha4c
                    loc_cSenha4c = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
                    IF NOT ALLTRIM(loc_cSenhaPad) == ALLTRIM(loc_cSenha4c)
                        par_cMensagem = "Usu" + CHR(225) + "rio / Senha Inv" + CHR(225) + "lidos(1)."
                        THIS.this_lUsuarioOk = .F.
                    ELSE
                        THIS.this_lUsuarioOk = .T.
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    THIS.this_lUsuarioOk = (NOT EMPTY(THIS.this_cUsuario) AND ;
                        NOT EOF("crsigcdusu1") AND ;
                        loc_cSenhaPad == fCriptografar(crsigcdusu1.senhas))

                    IF THIS.this_lUsuarioOk
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF NOT THIS.this_lUsuarioOk
                IF USED("crParam2") AND NVL(crParam2.nBloSenhas, 0) > 0 AND ;
                    NOT EMPTY(THIS.this_cUsuario) AND ;
                    USED("crsigcdusu1") AND NOT EOF("crsigcdusu1") AND ;
                    NOT loc_cSenhaPad == fCriptografar(crsigcdusu1.senhas)

                    IF THIS.this_nBloqueiaSenha > NVL(crParam2.nBloSenhas, 0)
                        THIS.BloquearSenha(THIS.this_cUsuario)
                        par_cMensagem = "N" + CHR(186) + " Tentativas Ultrapassadas, Senha Bloqueada." + ;
                            CHR(10) + "Contate o Suporte Tecnico."
                    ELSE
                        par_cMensagem = "Senha Incorreta (Permitido Apenas " + ;
                            ALLTRIM(STR(NVL(crParam2.nBloSenhas, 0), 20, 0)) + " Tentativas)."
                        THIS.this_nBloqueiaSenha = THIS.this_nBloqueiaSenha + 1
                    ENDIF
                ELSE
                    par_cMensagem = "Usu" + CHR(225) + "rio / Senha Inv" + CHR(225) + "lidos(2)."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCredenciais - Verifica se usuario + empresa + senha estao validos
    * Chamado pelo Confirma antes de processar login
    * Par: par_cSenhaDigitada  - Senha digitada
    *      par_cEmpresa        - Codigo empresa selecionada
    *      par_lEmpresaVisivel - .T. se campo empresa esta visivel
    *      par_cMensagem       - Retorna mensagem de erro (por referencia)
    * Ret: 0=OK, 1=usuario/senha invalida, 2=empresa invalida, 3=licencas excedidas
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCredenciais(par_cSenhaDigitada, par_cEmpresa, ;
                                          par_lEmpresaVisivel, par_cMensagem)
        LOCAL loc_nResultado, loc_lChkUsuario, loc_lChkEmpresa
        loc_nResultado = 0
        par_cMensagem = ""

        TRY
            loc_lChkUsuario = THIS.this_lUsuarioOk
            loc_lChkEmpresa = (NOT par_lEmpresaVisivel)

            IF UPPER(ALLTRIM(THIS.this_cUsuario)) = "4CONTROL" AND ;
                USED("crsigcdusu1") AND EMPTY(ALLTRIM(crsigcdusu1.senhas))
                par_cMensagem = "Senha Inv" + CHR(225) + "lida!!!"
                loc_lSucesso = 1
            ENDIF

            IF USED("crsigcdusu1")
                SELECT ("crsigcdusu1")
                SET ORDER TO ("") IN ("crsigcdusu1")
                LOCATE FOR (crsigcdusu1.usuarios == THIS.this_cUsuario)
                loc_lChkUsuario = (loc_lChkUsuario OR ;
                    (NOT EMPTY(THIS.this_cUsuario) AND ;
                     NOT EOF("crsigcdusu1") AND ;
                     par_cSenhaDigitada == fCriptografar(crsigcdusu1.senhas)))
            ENDIF

            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE FOR (crEmpresa1.cemps == par_cEmpresa)
                loc_lChkEmpresa = (loc_lChkEmpresa OR ;
                    (NOT EMPTY(par_cEmpresa) AND NOT EOF("crEmpresa1")))
            ENDIF

            IF (goSistema.NumLicencas <> 9999) AND ;
                (UPPER(ALLTRIM(THIS.this_cUsuario)) <> "4CONTROL")
                LOCAL loc_nLic
                loc_nLic = THIS.VerificarLicencas(THIS.this_cUsuario)
                IF loc_nLic >= goSistema.NumLicencas
                    par_cMensagem = "A Quantidade de Licen" + CHR(231) + "as de Uso do Sistema Foram Excedidas." + ;
                        CHR(13) + "Aguarde a Libera" + CHR(231) + CHR(227) + "o das Licen" + CHR(231) + ;
                        "as em Uso e Tente Novamente." + CHR(13) + ;
                        "A Quantidade M" + CHR(225) + "xima de Usu" + CHR(225) + ;
                        "rios Simult" + CHR(226) + "neos " + CHR(233) + " " + ;
                        ALLTRIM(STR(goSistema.NumLicencas))
                    loc_lSucesso = 3
                ENDIF
            ENDIF

            DO CASE
                CASE NOT loc_lChkUsuario
                    par_cMensagem = "Usu" + CHR(225) + "rio / Senha Inv" + CHR(225) + "lidos."
                    loc_nResultado = 1
                CASE NOT loc_lChkEmpresa
                    par_cMensagem = "Empresa Inv" + CHR(225) + "lida."
                    loc_nResultado = 2
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarLogin - Executa processamento completo apos validacao
    * Carrega menus, parametros, barra de atalhos, configura sistema
    * Par: par_cEmpresa - Codigo da empresa logada
    *      par_cUsuario - Login do usuario
    *      par_lGetUsuario - .T. se estava pedindo usuario
    *      par_cUsuarioAtual - Usuario anterior (se troca de usuario)
    * Ret: .T. se processamento completo com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarLogin(par_cEmpresa, par_cUsuario, ;
                                    par_lGetUsuario, par_cUsuarioAtual)
        LOCAL loc_lSucesso, loc_cOpSis1, loc_cOpSis2, loc_cTransSis1
        LOCAL loc_lSupervis, loc_nDock, loc_lTmpChk, loc_lTmpApp
        LOCAL loc_cArqSetFiscal

        loc_lSucesso = .F.
        loc_lSupervis = (UPPER(ALLTRIM(par_cUsuario)) = "4CONTROL")

        TRY
            PUBLIC _tipoe, gcEmpr, gcUsuar, usuar
            gcEmpr = par_cEmpresa
            gcUsuar = par_cUsuario
            usuar = gcUsuar
            go_4c_Sistema.cCodEmpresa = gcEmpr

            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE FOR (crEmpresa1.cemps == par_cEmpresa)
                IF NOT EOF("crEmpresa1")
                    _tipoe = crEmpresa1.tipos
                ENDIF
            ENDIF

            loc_nDock = 0
            loc_lTmpChk = .F.
            loc_lTmpApp = .F.

            IF USED("crParam1") AND USED("crParam2")
                SELECT ("crParam1")
                SET ORDER TO ("") IN ("crParam1")
                LOCATE

                SELECT ("crParam2")
                SET ORDER TO ("") IN ("crParam2")
                LOCATE

                loc_nDock = IIF(BETWEEN(NVL(crParam1.ndocks, 0), 0, 4), NVL(crParam1.ndocks, 0), 0)
                loc_cArqSetFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
                IF FILE(loc_cArqSetFiscal)
                    loc_lTmpChk = 0
                    loc_lTmpApp = 0
                ELSE
                    loc_lTmpChk = NVL(crParam1.ntmpchks, 0)
                    loc_lTmpApp = NVL(crParam1.ntmpapps, 0)
                ENDIF
            ENDIF

            THIS.CarregarMenuPrincipal(par_cEmpresa)

            loc_nDock = loc_nDock - 1
            goSistema.BarraAtalho = CREATEOBJECT("fwBarraBtns")
            goSistema.BarraAtalho.Dock(loc_nDock)

            THIS.CarregarBarraAtalhos(par_cUsuario)

            IF par_lGetUsuario
                IF NOT EMPTY(par_cUsuarioAtual)
                    loc_cOpSis1 = "S"
                    loc_cOpSis2 = "USUARIO"
                    loc_cTransSis1 = "Saida do Sistema"
                ELSE
                    loc_cOpSis1 = "E"
                    loc_cOpSis2 = "USUARIO"
                    loc_cTransSis1 = "Acesso ao Sistema - " + gcEmpr
                ENDIF
            ELSE
                loc_cOpSis1 = "T"
                loc_cOpSis2 = "EMPRESA"
                loc_cTransSis1 = "Muda Empresa - " + gcEmpr
            ENDIF

            IF NOT goSistema.Desenvolvimento
                = fTempoApp(loc_lTmpChk, loc_lTmpApp)
            ENDIF

            goSistema.EmpresaLogada = go_4c_Sistema.cCodEmpresa
            goSistema.UsuarioLogado = goSistema.usuario
            IF USED("crsigcdusu1")
                goSistema.SenhaLogado = ALLTRIM(crsigcdusu1.senhas)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarraAtalhos - Carrega botoes da barra de atalhos do usuario
    * Consulta SigCdAcB + sigcdprg, cria icones e adiciona ao BarraAtalho
    * Par: par_cUsuario - Login do usuario
    * Ret: .T. se barra carregada com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarraAtalhos(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nErro, loc_nNBotao
        LOCAL loc_cDirTmp, loc_cArqIcone, loc_cExtIcone, loc_nTamIcone
        LOCAL loc_cMacro, loc_lSelBarras

        loc_lSucesso = .F.
        loc_nErro = 1
        loc_nNBotao = 0
        loc_cDirTmp = ADDBS(SYS(2023))
        loc_lSelBarras = .T.

        TRY
            loc_cSQL = "select a.programas,a.parametros,a.barraforms," + ;
                "b.descricaos,b.barrapict from SigCdAcB a" + ;
                " left join sigcdprg b on b.programas+b.parametros=a.programas+a.parametros" + ;
                " where a.usuarios='" + ALLTRIM(par_cUsuario) + "'" + ;
                " and a.selbarras='" + IIF(loc_lSelBarras, "1", "0") + "'" + ;
                " union all" + ;
                " select a.programas,a.parametros,a.barraforms," + ;
                "b.descricaos,b.barrapict from SigCdAcB a" + ;
                " left join sigcdprg b on b.programas+b.parametros=a.programas+a.parametros" + ;
                " where a.selbarras='" + IIF(loc_lSelBarras, "1", "0") + "'" + ;
                " and a.grupos in (select c.grupos from SigCdAcG c" + ;
                " where c.usuarios='" + ALLTRIM(par_cUsuario) + "')"

            IF USED("crTmpAcBarra1")
                USE IN ("crTmpAcBarra1")
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcBarra1") > 0
                IF USED("crTmpAcBarra1")
                    IF USED("crAcBarra1")
                        USE IN ("crAcBarra1")
                    ENDIF
                    SELECT DISTINCT a.programas, a.parametros, a.barraforms, ;
                           PADR(NVL(a.descricaos, ""), 100) AS descricaos, ;
                           PADR(NVL(a.barrapict, ""), 50) AS barrapict ;
                      FROM crTmpAcBarra1 a ;
                     ORDER BY 1, 2 ;
                      INTO CURSOR crAcBarra1
                ENDIF

                IF USED("crAcBarra1")
                    SELECT crAcBarra1
                    SET ORDER TO ("") IN crAcBarra1
                    LOCATE

                    SCAN WHILE loc_nErro > 0
                        IF NOT SEEK(STR(VAL(crAcBarra1.Programas), 10, 0), "crTmpOpe", "ndopes") OR ;
                            NOT NVL(crTmpOpe.Opeinatvs, 0) == 1

                            loc_cArqIcone = ""
                            loc_nTamIcone = 0

                            IF LEFT(crAcBarra1.BarraForms, 8) = "SIGMVEXP"
                                IF LEFT(crAcBarra1.programas, 2) <> "GE" AND ;
                                    SEEK(STR(VAL(crAcBarra1.Programas), 10, 0), "crTmpOpe", "ndopes") AND ;
                                    NOT EMPTY(crTmpOpe.EmpLancs) AND crTmpOpe.EmpLancs <> go_4c_Sistema.cCodEmpresa
                                    LOOP
                                ENDIF
                            ENDIF

                            IF NOT EMPTY(crAcBarra1.barrapict)
                                loc_cExtIcone = JUSTEXT(ALLTRIM(crAcBarra1.barrapict))
                                IF EMPTY(loc_cExtIcone)
                                    loc_cExtIcone = "ico"
                                ENDIF

                                LOCAL loc_cSQLIcone
                                loc_cSQLIcone = "select a.marqicones from SigSyIco a" + ;
                                    " where a.carqicones='" + ALLTRIM(crAcBarra1.barrapict) + "'"

                                IF USED("crTmpIcone1")
                                    USE IN ("crTmpIcone1")
                                ENDIF

                                IF SQLEXEC(gnConnHandle, loc_cSQLIcone, "crTmpIcone1") > 0
                                    SELECT ("crTmpIcone1")
                                    SET ORDER TO ("") IN ("crTmpIcone1")
                                    LOCATE

                                    IF NOT EOF("crTmpIcone1") AND NOT EMPTY(crTmpIcone1.marqicones)
                                        loc_cArqIcone = loc_cDirTmp + goSistema.Sys2015Tmp + SYS(2015) + "." + loc_cExtIcone
                                        loc_nTamIcone = STRTOFILE(crTmpIcone1.marqicones, loc_cArqIcone)
                                        IF loc_nTamIcone = 0
                                            loc_cArqIcone = ""
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nNBotao = loc_nNBotao + 1
                            loc_cMacro = "botao" + ALLTRIM(STR(loc_nNBotao, 20, 0))
                            goSistema.BarraAtalho.AddObject(loc_cMacro, "bot" + CHR(227) + "o_da_barra")
                            goSistema.BarraAtalho.&loc_cMacro..ToolTipText = ALLTRIM(crAcBarra1.descricaos)
                            goSistema.BarraAtalho.&loc_cMacro..Picture = loc_cArqIcone
                            goSistema.BarraAtalho.&loc_cMacro..FormExec = ALLTRIM(crAcBarra1.barraforms)
                            goSistema.BarraAtalho.&loc_cMacro..Visible = .T.
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            goSistema.BarraAtalho.Visible = (loc_nNBotao > 0)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarEmpresas - Carrega lista de empresas e retorna quantidade
    * Se apenas 1 empresa, preenche automaticamente os valores
    * Ret: Numero de empresas encontradas (0 se erro)
    *      this_cEmpresa e this_cDescEmpresa preenchidos se unica empresa
    *--------------------------------------------------------------------------
    PROCEDURE AjustarEmpresas()
        LOCAL loc_nQtde, loc_cSQL, loc_nErro

        loc_nQtde = 0
        loc_nErro = IIF(gnConnHandle > 0, 1, -1)

        TRY
            loc_cSQL = "Select cemps, razas, tipos From SigCdEmp"

            IF USED("crEmpresa1")
                USE IN ("crEmpresa1")
            ENDIF

            IF loc_nErro > 0
                loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1")
            ENDIF

            IF USED("crEmpresa1")
                GO TOP IN crEmpresa1
                loc_nQtde = RECCOUNT("crEmpresa1")

                IF loc_nQtde = 1
                    THIS.this_cEmpresa     = crEmpresa1.cemps
                    THIS.this_cDescEmpresa = crEmpresa1.razas
                    THIS.this_cTipoEmpresa = crEmpresa1.tipos
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nQtde
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresaPorDescricao - Localiza empresa pelo nome/descricao
    * Usado pelo campo Get_Demp (descricao da empresa)
    * Par: par_cDescricao - Descricao digitada
    * Ret: .T. se empresa encontrada/selecionada, .F. se nao
    *      this_cEmpresa e this_cDescEmpresa atualizados se encontrada
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_lEncontrou

        loc_lSucesso = .F.
        loc_lEncontrou = .F.

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                loc_cSQL = "select a.cemps,a.razas,a.tipos from SigCdEmp a order by 1"
                IF USED("crEmpresa1")
                    USE IN ("crEmpresa1")
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1")
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.razas)) == LOWER(ALLTRIM(par_cDescricao))

                IF NOT EOF("crEmpresa1")
                    loc_lEncontrou = .T.
                ENDIF

                IF loc_lEncontrou
                    THIS.this_cEmpresa     = ALLTRIM(crEmpresa1.cemps)
                    THIS.this_cDescEmpresa = ALLTRIM(crEmpresa1.razas)
                    THIS.this_cTipoEmpresa = ALLTRIM(crEmpresa1.tipos)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarExpSenha - Verifica se senha do usuario precisa ser trocada
    * Compara data da ultima troca com parametro de dias para expiracao
    * Ret: .T. se senha precisa ser trocada, .F. se nao
    *--------------------------------------------------------------------------
    PROCEDURE VerificarExpSenha()
        LOCAL loc_lPrecisaTrocar, loc_dUltData, loc_dHoje, loc_nDias

        loc_lPrecisaTrocar = .F.

        TRY
            IF USED("crsigcdusu1") AND USED("crParam2")
                loc_dUltData = TTOD(NVL(crsigcdusu1.tDtSenhas, CTOT("01/01/1900")))

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    LOCAL loc_cSQL
                    loc_cSQL = "SELECT GETDATE() AS dtHoje"
                    IF USED("crTmpDtHoje")
                        USE IN ("crTmpDtHoje")
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpDtHoje") > 0
                        loc_dHoje = TTOD(crTmpDtHoje.dtHoje)
                        IF USED("crTmpDtHoje")
                            USE IN ("crTmpDtHoje")
                        ENDIF
                    ELSE
                        loc_dHoje = DATE()
                    ENDIF
                ELSE
                    loc_dHoje = DATE()
                ENDIF

                SELECT crParam2
                LOCATE
                loc_nDias = NVL(crParam2.nDiaSenhas, 0)

                LOCAL loc_lObrigNova
                loc_lObrigNova = (NVL(crsigcdusu1.ObrigSenhas, 0) = 1) AND ;
                    EMPTY(ALLTRIM(crsigcdusu1.senhas))

                IF loc_lObrigNova OR (loc_nDias > 0 AND (loc_dHoje - loc_dUltData) >= loc_nDias)
                    loc_lPrecisaTrocar = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPrecisaTrocar
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPafEcf - Retorna se PAF-ECF esta ativo nos parametros
    * Ret: .T. se PafEcfs = 1, .F. caso contrario
    *--------------------------------------------------------------------------
    PROCEDURE VerificarPafEcf()
        LOCAL loc_lAtivo

        loc_lAtivo = .F.

        TRY
            IF USED("crParam2")
                SELECT crParam2
                LOCATE
                IF NOT EOF("crParam2")
                    IF VARTYPE(crParam2.PafEcfs) = "L"
                        loc_lAtivo = crParam2.PafEcfs
                    ELSE
                        IF VARTYPE(crParam2.PafEcfs) = "L"
                            loc_lAtivo = crParam2.PafEcfs
                        ELSE
                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                loc_lAtivo = crParam2.PafEcfs
                            ELSE
                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                    loc_lAtivo = crParam2.PafEcfs
                                ELSE
                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                        loc_lAtivo = crParam2.PafEcfs
                                    ELSE
                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                            loc_lAtivo = crParam2.PafEcfs
                                        ELSE
                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                loc_lAtivo = crParam2.PafEcfs
                                            ELSE
                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                    loc_lAtivo = crParam2.PafEcfs
                                                ELSE
                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                        loc_lAtivo = crParam2.PafEcfs
                                                    ELSE
                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                            loc_lAtivo = crParam2.PafEcfs
                                                        ELSE
                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                loc_lAtivo = crParam2.PafEcfs
                                                            ELSE
                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                ELSE
                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                    ELSE
                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                        ELSE
                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                            ELSE
                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                ELSE
                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                    ELSE
                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                        ELSE
                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                            ELSE
                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                ELSE
                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                ELSE
                                                                                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                    ELSE
                                                                                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                        ELSE
                                                                                                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                            ELSE
                                                                                                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                ELSE
                                                                                                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                    ELSE
                                                                                                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                        ELSE
                                                                                                                                                                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                                loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                            ELSE
                                                                                                                                                                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                                    loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                                ELSE
                                                                                                                                                                                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                                        loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                                    ELSE
                                                                                                                                                                                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                                                                                                                                                                                            loc_lAtivo = crParam2.PafEcfs
                                                                                                                                                                                                        ELSE
                                                                                                                                                                                                            loc_lAtivo = (NVL(crParam2.PafEcfs, 0) = 1)
                                                                                                                                                                                                        ENDIF
                                                                                                                                                                                                    ENDIF
                                                                                                                                                                                                ENDIF
                                                                                                                                                                                            ENDIF
                                                                                                                                                                                        ENDIF
                                                                                                                                                                                    ENDIF
                                                                                                                                                                                ENDIF
                                                                                                                                                                            ENDIF
                                                                                                                                                                        ENDIF
                                                                                                                                                                    ENDIF
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lAtivo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLogoEmpresa - Carrega logo da empresa selecionada para exibicao
    * Decodifica base64 do campo logos e salva em arquivo temporario
    * Par: par_cEmpresa - Codigo da empresa
    * Ret: Caminho do arquivo de imagem temporario (vazio se nao encontrou)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoEmpresa(par_cEmpresa)
        LOCAL loc_cArqImagem, loc_cSQL, loc_cStrLogo, loc_cFoto

        loc_cArqImagem = ""

        TRY
            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) = LOWER(ALLTRIM(par_cEmpresa))

                IF NOT EOF("crEmpresa1")
                    loc_cArqImagem = ADDBS(SYS(2023)) + goSistema.Sys2015Tmp + SYS(2015) + ".img"

                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                        crEmpresa1.logos, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    loc_cStrLogo = loc_cFoto

                    IF EMPTY(crEmpresa1.logos)
                        loc_cSQL = "select a.logos from SigCdPam a"
                        IF USED("crTmpLogo1")
                            USE IN ("crTmpLogo1")
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLogo1") > 0
                            IF USED("crTmpLogo1")
                                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    crTmpLogo1.logos, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                                loc_cStrLogo = loc_cFoto
                            ENDIF
                        ENDIF
                    ENDIF

                    IF NOT EMPTY(loc_cStrLogo) AND STRTOFILE(loc_cStrLogo, loc_cArqImagem) > 0
                        *-- Arquivo criado com sucesso
                    ELSE
                        loc_cArqImagem = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cArqImagem = ""
        ENDTRY

        RETURN loc_cArqImagem
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarAlertas - Retorna tipo de alertas configurado
    * Ret: Valor de crParam2.Alertas (0 se nao configurado)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarAlertas()
        LOCAL loc_nAlertas

        loc_nAlertas = 0

        TRY
            IF USED("crParam2")
                SELECT crParam2
                LOCATE
                IF NOT EOF("crParam2")
                    loc_nAlertas = NVL(crParam2.Alertas, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nAlertas
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha todos os cursores temporarios usados no login
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("crsigcdusu1")
                USE IN ("crsigcdusu1")
            ENDIF
            IF USED("crEmpresa1")
                USE IN ("crEmpresa1")
            ENDIF
            IF USED("crParam1")
                USE IN ("crParam1")
            ENDIF
            IF USED("crParam2")
                USE IN ("crParam2")
            ENDIF
            IF USED("crTmpAcBarra1")
                USE IN ("crTmpAcBarra1")
            ENDIF
            IF USED("crAcBarra1")
                USE IN ("crAcBarra1")
            ENDIF
            IF USED("crSigCdAcU1")
                USE IN ("crSigCdAcU1")
            ENDIF
            IF USED("crTmpOpe")
                USE IN ("crTmpOpe")
            ENDIF
            IF USED("crTmpIcone1")
                USE IN ("crTmpIcone1")
            ENDIF
            IF USED("crTmpLogo1")
                USE IN ("crTmpLogo1")
            ENDIF
            IF USED("csEstEmp")
                USE IN ("csEstEmp")
            ENDIF
            IF USED("crSigfipaf")
                USE IN ("crSigfipaf")
            ENDIF
            IF USED("crPaf")
                USE IN ("crPaf")
            ENDIF
        CATCH TO loc_oErro
            *-- Ignora erros ao fechar cursores no cleanup
        ENDTRY
    ENDPROC

ENDDEFINE
