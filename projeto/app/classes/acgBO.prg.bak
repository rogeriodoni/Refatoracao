*==============================================================================
* acgBO.prg - Business Object para Acesso de Grupos (SIGCDACG)
* Tabela Principal: sigcdgra (PK: Grupos)
* Tabelas Relacionadas:
*   - sigcdacg (usuarios do grupo)
*   - sigcdacu (acessos de programa por grupo/usuario)
*   - sigcdacb (barra de ferramentas por grupo)
*   - sigactel (acesso a campos em telas por grupo)
*   - sigcdprg (programas disponiveis)
*   - sigcdusu (usuarios cadastrados)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS acgBO AS BusinessBase

    *-- Propriedades: sigcdgra
    this_cGrupos    = ""   && grupos char(10) NOT NULL - PK
    this_cNComps    = ""   && ncomps char(30) NOT NULL - nome do grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdgra"
        THIS.this_cCampoChave = "Grupos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(Grupos, "C")
            THIS.this_cNComps = TratarNulo(NComps, "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca grupos com filtro opcional para exibir no grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Grupos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega grupo pela PK
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT sigcdgra (registro principal)
    * Dados relacionados sao salvos separadamente via SalvarUsuarios,
    * SalvarProgramas, SalvarBarra, SalvarAcessoTelas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigcdgra (Grupos, NComps) VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigcdgra (registro principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigcdgra SET NComps = " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ;
                " WHERE Grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigcdgra e todas as tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        TRY
            *-- Excluir dependencias (ordem importa para FK)
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del1")
            IF USED("cursor_4c_Del1")
                USE IN cursor_4c_Del1
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del2")
            IF USED("cursor_4c_Del2")
                USE IN cursor_4c_Del2
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del3")
            IF USED("cursor_4c_Del3")
                USE IN cursor_4c_Del3
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del4")
            IF USED("cursor_4c_Del4")
                USE IN cursor_4c_Del4
            ENDIF

            *-- Excluir registro principal
            loc_cSQL = "DELETE FROM sigcdgra WHERE Grupos = " + loc_cGrupoSQL
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del5")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                IF USED("cursor_4c_Del5")
                    USE IN cursor_4c_Del5
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosGrupos - Lista todos os grupos (para listbox de copia)
    * Retorna cursor: cursor_4c_ListaGrupos (Grupos, NComps)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosGrupos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaGrupos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_ListaGrupos")
                    SELECT cursor_4c_ListaGrupos
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosUsuarios - Lista todos os usuarios do sistema
    * Retorna cursor: cursor_4c_TodosUsuarios (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosUsuarios()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Usuarios, NComps, cAtivos FROM sigcdusu ORDER BY NComps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosUsuarios")
            IF loc_nResult >= 0
                IF USED("cursor_4c_TodosUsuarios")
                    SELECT cursor_4c_TodosUsuarios
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarUsuariosDoGrupo - Carrega usuarios pertencentes ao grupo
    * Retorna cursor: cursor_4c_UsuariosGrupo (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUsuariosDoGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Usuarios, u.NComps, u.cAtivos" + ;
                " FROM sigcdacg a" + ;
                " LEFT JOIN sigcdusu u ON u.Usuarios = a.Usuarios" + ;
                " WHERE a.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " ORDER BY a.Usuarios"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosGrupo")
            IF loc_nResult >= 0
                IF USED("cursor_4c_UsuariosGrupo")
                    SELECT cursor_4c_UsuariosGrupo
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Carrega programas disponiveis com marcacao do grupo
    * Retorna cursor: cursor_4c_Programas (Descricaos, Programas, Parametros,
    *                 BarraForms, Marcas)
    * Marcas=1: programa ja liberado ao grupo; Marcas=0: nao liberado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarProgramas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Descricaos, a.Programas, a.Parametros, a.BarraForms," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS Marcas" + ;
                " FROM sigcdprg a" + ;
                " LEFT JOIN sigcdacu b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " ORDER BY a.Descricaos, a.Programas, a.Parametros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarra - Carrega itens de barra de ferramentas com marcacao do grupo
    * Retorna cursor: TmpBarra (BarraOrdem, Descricaos, BarraForms, Programas,
    *                           Parametros, SelBarras, Usuarios)
    * SelBarras=1: item ativo no grupo; SelBarras=0: inativo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarra(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT DISTINCT a.BarraOrdem, a.Descricaos, a.BarraForms," + ;
                " a.Programas, a.Parametros," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS SelBarras," + ;
                " '' AS Usuarios" + ;
                " FROM sigcdacb a" + ;
                " LEFT JOIN sigcdacb b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                " ORDER BY a.BarraOrdem, a.Descricaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpBarra")
            IF loc_nResult >= 0
                IF USED("TmpBarra")
                    SELECT TmpBarra
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessoTelas - Carrega controle de acesso a campos nas telas
    * par_cGrupos: codigo do grupo (vazio = inserindo novo, traz template com nStatus=1)
    * Retorna cursor: crSigAcTel (cCodigos, cDescTelas, cCampos, cObjetos,
    *                              cDescCamps, nStatus, Grupos, Usuarios, pkchaves)
    * nStatus=0: campo liberado; nStatus=1: campo bloqueado (default)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessoTelas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(ALLTRIM(par_cGrupos))
        TRY
            IF EMPTY(ALLTRIM(par_cGrupos))
                *-- Novo grupo: retorna template com todos os campos bloqueados
                loc_cSQL = "SELECT cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps," + ;
                    " 1 AS nStatus, '' AS Grupos, '' AS Usuarios, '' AS pkchaves" + ;
                    " FROM sigactel WHERE grupos = '' AND usuarios = ''" + ;
                    " ORDER BY cCodigos"
            ELSE
                *-- Grupo existente: mostra estado real com defaults bloqueados
                loc_cSQL = "SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps," + ;
                    " ISNULL(b.nStatus, 1) AS nStatus," + ;
                    " ISNULL(b.Grupos, '') AS Grupos," + ;
                    " ISNULL(b.Usuarios, '') AS Usuarios," + ;
                    " ISNULL(b.pkchaves, '') AS pkchaves" + ;
                    " FROM sigactel a" + ;
                    " LEFT JOIN sigactel b ON b.cCodigos = a.cCodigos" + ;
                    " AND b.cCampos = a.cCampos" + ;
                    " AND b.grupos = " + loc_cGrupoSQL + ;
                    " AND b.usuarios = ''" + ;
                    " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                    " ORDER BY a.cCodigos"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigAcTel")
            IF loc_nResult >= 0
                IF USED("crSigAcTel")
                    SELECT crSigAcTel
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar acesso telas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarUsuarios - Salva lista de usuarios do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorUsuarios: cursor com campo Usuarios char(10)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarUsuarios(par_cGrupos, par_cCursorUsuarios)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL, loc_cUsuario
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar usuarios existentes do grupo
            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcg")
            IF USED("cursor_4c_DelAcg")
                USE IN cursor_4c_DelAcg
            ENDIF

            *-- Reinserir usuarios selecionados
            IF USED(par_cCursorUsuarios) AND RECCOUNT(par_cCursorUsuarios) > 0
                SELECT (par_cCursorUsuarios)
                GO TOP
                SCAN
                    loc_cUsuario = ALLTRIM(Usuarios)
                    IF !EMPTY(loc_cUsuario)
                        loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cUsuario, 10)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorUsuarios)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarProgramas - Salva acessos de programa do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorProgramas: cursor com campos Programas, Parametros, Marcas
    *   Marcas=1: programa liberado ao grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarProgramas(par_cGrupos, par_cCursorProgramas)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cProg, loc_cParam, loc_nMarcas
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar acessos de programa do grupo (somente nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcu")
            IF USED("cursor_4c_DelAcu")
                USE IN cursor_4c_DelAcu
            ENDIF

            *-- Reinserir programas selecionados (Marcas=1)
            IF USED(par_cCursorProgramas) AND RECCOUNT(par_cCursorProgramas) > 0
                SELECT (par_cCursorProgramas)
                GO TOP
                SCAN
                    loc_nMarcas = Marcas
                    loc_cProg   = ALLTRIM(Programas)
                    loc_cParam  = ALLTRIM(Parametros)
                    IF loc_nMarcas = 1 AND !EMPTY(loc_cProg)
                        loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", '', " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorProgramas)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar programas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Salva configuracao da barra de ferramentas do grupo
    * par_cGrupos: codigo do grupo
    * par_cCursorBarra: cursor TmpBarra com campos BarraOrdem, Descricaos,
    *   BarraForms, Programas, Parametros, SelBarras
    *   SelBarras=.T./1: item selecionado para o grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cGrupos, par_cCursorBarra)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cDescricaos, loc_cBarraForms, loc_nBarraOrdem
        LOCAL loc_cProg, loc_cParam, loc_lSel
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar barra existente do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcb")
            IF USED("cursor_4c_DelAcb")
                USE IN cursor_4c_DelAcb
            ENDIF

            *-- Reinserir itens selecionados
            IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                SELECT (par_cCursorBarra)
                GO TOP
                SCAN
                    loc_lSel        = SelBarras
                    loc_cDescricaos = ALLTRIM(Descricaos)
                    loc_cBarraForms = ALLTRIM(BarraForms)
                    loc_nBarraOrdem = BarraOrdem
                    loc_cProg       = ALLTRIM(Programas)
                    loc_cParam      = ALLTRIM(Parametros)
                    IF loc_lSel
                        loc_cSQL = "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", '', " + ;
                            EscaparSQL(LEFT(loc_cDescricaos, 73)) + ", " + ;
                            EscaparSQL(LEFT(loc_cBarraForms, 50)) + ", " + ;
                            FormatarNumeroSQL(loc_nBarraOrdem) + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", 1, " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorBarra)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar barra:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessoTelas - Salva configuracao de acesso a campos nas telas
    * par_cGrupos: codigo do grupo
    * par_cCursorAcTel: cursor crSigAcTel com campos cCodigos, cDescTelas,
    *   cCampos, cObjetos, cDescCamps, nStatus
    *   nStatus=0: campo liberado (salva); nStatus=1: bloqueado (nao salva)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessoTelas(par_cGrupos, par_cCursorAcTel)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cCampos, loc_cCodigos, loc_cDescCamps, loc_cDescTelas
        LOCAL loc_cObjetos, loc_nStatus
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar registros existentes do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcTel")
            IF USED("cursor_4c_DelAcTel")
                USE IN cursor_4c_DelAcTel
            ENDIF

            *-- Reinserir apenas campos liberados (nStatus=0)
            IF USED(par_cCursorAcTel) AND RECCOUNT(par_cCursorAcTel) > 0
                SELECT (par_cCursorAcTel)
                GO TOP
                SCAN
                    loc_nStatus    = nStatus
                    loc_cCodigos   = ALLTRIM(cCodigos)
                    loc_cCampos    = ALLTRIM(cCampos)
                    loc_cDescCamps = ALLTRIM(cDescCamps)
                    loc_cDescTelas = ALLTRIM(cDescTelas)
                    loc_cObjetos   = ALLTRIM(cObjetos)
                    IF loc_nStatus <> 1
                        loc_cSQL = "INSERT INTO sigactel" + ;
                            " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                            " VALUES (" + ;
                            EscaparSQL(LEFT(loc_cCampos, 30)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCodigos, 10)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescCamps, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescTelas, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cObjetos, 100)) + ", " + ;
                            FormatarNumeroSQL(loc_nStatus) + ", " + ;
                            loc_cGrupoSQL + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcTel")
                        IF USED("cursor_4c_InsAcTel")
                            USE IN cursor_4c_InsAcTel
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorAcTel)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia todos os acessos de par_cGrupoOrigem para THIS.this_cGrupos
    * Usa INSERT ... SELECT direto no SQL Server para eficiencia
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cGrupoOrigem)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupoDest, loc_cGrupoOri
        loc_lResultado = .F.
        loc_cGrupoDest = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        loc_cGrupoOri  = EscaparSQL(LEFT(ALLTRIM(par_cGrupoOrigem), 10))
        TRY
            *-- Copiar usuarios: apenas os que o destino ainda nao tem
            loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.usuarios, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacg a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacg b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = a.usuarios)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcg")
            IF USED("cursor_4c_CpAcg")
                USE IN cursor_4c_CpAcg
            ENDIF

            *-- Copiar acessos de programa (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.programas, a.parametros, '', LEFT(NEWID(), 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacu b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            *-- Copiar barra de ferramentas (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacb" + ;
                " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", '', a.descricaos, a.barraforms, a.barraordem," + ;
                " a.programas, a.parametros, a.selbarras, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacb a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacb b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcb")
            IF USED("cursor_4c_CpAcb")
                USE IN cursor_4c_CpAcb
            ENDIF

            *-- Copiar acesso a telas (nivel grupo)
            loc_cSQL = "INSERT INTO sigactel" + ;
                " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                " SELECT a.ccampos, a.ccodigos, a.cdesccamps, a.cdesctelas, a.cobjetos," + ;
                " a.nstatus, " + loc_cGrupoDest + ", LEFT(NEWID(), 20), ''" + ;
                " FROM sigactel a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigactel b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.ccodigos = a.ccodigos AND b.ccampos = a.ccampos)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcTel")
            IF USED("cursor_4c_CpAcTel")
                USE IN cursor_4c_CpAcTel
            ENDIF

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao copiar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo de grupo ja existe
    * Retorna .T. se ja existe (duplicado), .F. se disponivel
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            loc_cSQL = "SELECT Grupos FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    loc_lDuplicado = .T.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

ENDDEFINE
