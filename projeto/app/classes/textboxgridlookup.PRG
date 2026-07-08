*==============================================================================
* TextBoxGridLookup.prg - Classes TextBox customizadas para lookups em Grid
* Sistema: 4C ERP
*
* IMPORTANTE: BINDEVENT nao funciona bem com eventos de Grid/Column no VFP.
* A solucao eh criar classes TextBox com eventos Valid/KeyPress/DblClick
* embutidos diretamente na classe.
*==============================================================================

*------------------------------------------------------------------------------
* TextBoxGridBase - Classe base para TextBox com lookup em Grid
* Define a estrutura basica para lookups
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxGridBase AS TextBox
    FontName = "Tahoma"
    FontSize = 8

    * Propriedades para configurar o lookup
    this_cTabela = ""           && Tabela de lookup
    this_cCampoCodigo = ""      && Campo codigo
    this_cCampoDescricao = ""   && Campo descricao
    this_cTitulo = ""           && Titulo da janela de busca

    *--------------------------------------------------------------------------
    * KeyPress - Detecta F4/F5 para abrir busca
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)  && F4=115, F5=116
            THIS.AbrirBusca()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DblClick - Abre busca no duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE DblClick()
        THIS.AbrirBusca()
    ENDPROC

    *--------------------------------------------------------------------------
    * Valid - Valida o valor ao sair do campo
    * Comportamento legado: digitar "." ou similar abre busca com todos
    *--------------------------------------------------------------------------
    PROCEDURE Valid()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        loc_cValor = UPPER(ALLTRIM(THIS.Value))

        * Se vazio, permite sair
        IF EMPTY(loc_cValor)
            THIS.Value = ""
            RETURN .T.
        ENDIF

        * Se digitou caractere de busca (., *, ?, %), abre busca com todos
        IF INLIST(loc_cValor, ".", "*", "?", "%")
            THIS.Value = ""
            THIS.AbrirBuscaTodos()
            RETURN .T.
        ENDIF

        * Valida no banco de dados
        IF !EMPTY(THIS.this_cTabela) AND !EMPTY(THIS.this_cCampoCodigo)
            * Primeiro tenta busca exata
            loc_cSQL = "SELECT " + THIS.this_cCampoCodigo + ;
                       IIF(EMPTY(THIS.this_cCampoDescricao), "", ", " + THIS.this_cCampoDescricao) + ;
                       " FROM " + THIS.this_cTabela + ;
                       " WHERE CAST(" + THIS.this_cCampoCodigo + " AS VARCHAR(50)) = " + THIS.EscaparSQL(loc_cValor)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaGrid")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaGrid") = 1
                * Encontrou exato - atualiza com valor correto do banco
                THIS.Value = ALLTRIM(EVALUATE("cursor_4c_ValidaGrid." + THIS.this_cCampoCodigo))
                IF USED("cursor_4c_ValidaGrid")
                    USE IN cursor_4c_ValidaGrid
                ENDIF
                RETURN .T.
            ENDIF

            * Nao encontrou exato - tenta busca parcial (LIKE)
            IF USED("cursor_4c_ValidaGrid")
                USE IN cursor_4c_ValidaGrid
            ENDIF

            loc_cSQL = "SELECT " + THIS.this_cCampoCodigo + ;
                       IIF(EMPTY(THIS.this_cCampoDescricao), "", ", " + THIS.this_cCampoDescricao) + ;
                       " FROM " + THIS.this_cTabela + ;
                       " WHERE " + THIS.this_cCampoCodigo + " LIKE " + THIS.EscaparSQL(loc_cValor + "%") + ;
                       " ORDER BY " + THIS.this_cCampoCodigo

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaGrid")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaGrid") = 1
                * Encontrou um unico - usa direto
                THIS.Value = ALLTRIM(EVALUATE("cursor_4c_ValidaGrid." + THIS.this_cCampoCodigo))
                IF USED("cursor_4c_ValidaGrid")
                    USE IN cursor_4c_ValidaGrid
                ENDIF
                RETURN .T.
            ELSE IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaGrid") > 1
                * Multiplos - abre busca com o valor digitado
                IF USED("cursor_4c_ValidaGrid")
                    USE IN cursor_4c_ValidaGrid
                ENDIF
                THIS.AbrirBusca()
                RETURN .T.
            ELSE
                * Nenhum resultado - abre busca com todos
                IF USED("cursor_4c_ValidaGrid")
                    USE IN cursor_4c_ValidaGrid
                ENDIF
                THIS.Value = ""
                THIS.AbrirBuscaTodos()
                RETURN .T.
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBusca - Abre janela de busca
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBusca()
        LOCAL loc_cValor, loc_oBusca

        IF EMPTY(THIS.this_cTabela)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            THIS.this_cTabela, ;
            "cursor_4c_BuscaGrid", ;
            THIS.this_cCampoCodigo, ;
            loc_cValor, ;
            THIS.this_cTitulo, ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrid") AND RECCOUNT("cursor_4c_BuscaGrid") > 0
                    THIS.Value = ALLTRIM(EVALUATE("cursor_4c_BuscaGrid." + THIS.this_cCampoCodigo))
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                    loc_oBusca.mAddColuna(THIS.this_cCampoCodigo, "", "C" + CHR(243) + "digo")
                    IF !EMPTY(THIS.this_cCampoDescricao)
                        loc_oBusca.mAddColuna(THIS.this_cCampoDescricao, "", "Descri" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrid")
                        THIS.Value = ALLTRIM(EVALUATE("cursor_4c_BuscaGrid." + THIS.this_cCampoCodigo))
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrid")
            USE IN cursor_4c_BuscaGrid
        ENDIF

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTodos - Abre busca com TODOS os registros
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTodos()
        LOCAL loc_cSQL, loc_nResultado, loc_oBusca

        IF EMPTY(THIS.this_cTabela)
            RETURN
        ENDIF

        * Carrega todos os registros
        loc_cSQL = "SELECT " + THIS.this_cCampoCodigo + ;
                   IIF(EMPTY(THIS.this_cCampoDescricao), "", ", " + THIS.this_cCampoDescricao) + ;
                   " FROM " + THIS.this_cTabela + ;
                   " ORDER BY " + THIS.this_cCampoCodigo

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTodos")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_BuscaTodos") = 0
            =MESSAGEBOX("Nenhum registro encontrado.", 48, "Aviso")
            IF USED("cursor_4c_BuscaTodos")
                USE IN cursor_4c_BuscaTodos
            ENDIF
            RETURN
        ENDIF

        * Usa FormBuscaSimples para exibir cursor ja carregado
        loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_BuscaTodos", THIS.this_cTitulo)
        loc_oBusca.mAddColuna(THIS.this_cCampoCodigo, "", "C" + CHR(243) + "digo")
        IF !EMPTY(THIS.this_cCampoDescricao)
            loc_oBusca.mAddColuna(THIS.this_cCampoDescricao, "", "Descri" + CHR(231) + CHR(227) + "o")
        ENDIF
        loc_oBusca.Show(1)

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTodos")
            THIS.Value = ALLTRIM(EVALUATE("cursor_4c_BuscaTodos." + THIS.this_cCampoCodigo))
        ENDIF

        IF USED("cursor_4c_BuscaTodos")
            USE IN cursor_4c_BuscaTodos
        ENDIF
        loc_oBusca.Release()

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * EscaparSQL - Escapa string para SQL (metodo local)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE EscaparSQL(par_cValor)
        LOCAL loc_cResultado
        IF ISNULL(par_cValor)
            RETURN "NULL"
        ENDIF
        loc_cResultado = ALLTRIM(par_cValor)
        loc_cResultado = STRTRAN(loc_cResultado, "'", "''")
        RETURN "'" + loc_cResultado + "'"
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxGridGrupos - TextBox para lookup de Grupos Financeiros (SigCdGcr)
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxGridGrupos AS TextBoxGridBase
    PROCEDURE Init()
        THIS.this_cTabela = "SigCdGcr"
        THIS.this_cCampoCodigo = "Codigos"
        THIS.this_cCampoDescricao = "Descrs"
        THIS.this_cTitulo = "Busca de Grupos Financeiros"
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxGridContas - TextBox para lookup de Contas (SigReCtb)
* NOTA: Validacao depende do Grupo selecionado na coluna anterior
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxGridContas AS TextBoxGridBase
    PROCEDURE Init()
        THIS.this_cTabela = "SigReCtb"
        THIS.this_cCampoCodigo = "cContas"
        THIS.this_cCampoDescricao = "dContas"
        THIS.this_cTitulo = "Busca de Contas"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Valid - Sobrescreve para validar com base no Grupo
    * Comportamento legado: digitar "." ou similar abre busca
    *--------------------------------------------------------------------------
    PROCEDURE Valid()
        LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado

        loc_cValor = UPPER(ALLTRIM(THIS.Value))

        IF EMPTY(loc_cValor)
            THIS.Value = ""
            RETURN .T.
        ENDIF

        * Se digitou caractere de busca (., *, ?, %), abre busca com todos
        IF INLIST(loc_cValor, ".", "*", "?", "%")
            THIS.Value = ""
            THIS.AbrirBuscaTodos()
            RETURN .T.
        ENDIF

        * Obtem o grupo da linha atual do cursor
        IF USED("cursor_4c_CCLocal")
            SELECT cursor_4c_CCLocal
            loc_cGrupo = ALLTRIM(cursor_4c_CCLocal.Grupos)
        ELSE
            loc_cGrupo = ""
        ENDIF

        * Valida no banco de dados
        loc_cSQL = "SELECT cContas, dContas FROM SigReCtb " + ;
                   "WHERE CAST(cContas AS VARCHAR(50)) = " + THIS.EscaparSQL(loc_cValor)

        * Se tem grupo, filtra pelo grupo
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND CAST(cGrupos AS VARCHAR(50)) = " + THIS.EscaparSQL(loc_cGrupo)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaGrid")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaGrid") = 1
            THIS.Value = ALLTRIM(cursor_4c_ValidaGrid.cContas)
            IF USED("cursor_4c_ValidaGrid")
                USE IN cursor_4c_ValidaGrid
            ENDIF
            RETURN .T.
        ELSE
            IF USED("cursor_4c_ValidaGrid")
                USE IN cursor_4c_ValidaGrid
            ENDIF
            THIS.AbrirBusca()
            RETURN .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTodos - Abre busca com TODOS os registros do grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTodos()
        LOCAL loc_cGrupo, loc_cSQL, loc_nResultado, loc_oBusca

        * Obtem o grupo da linha atual
        IF USED("cursor_4c_CCLocal")
            SELECT cursor_4c_CCLocal
            loc_cGrupo = ALLTRIM(cursor_4c_CCLocal.Grupos)
        ELSE
            loc_cGrupo = ""
        ENDIF

        * Monta SQL com filtro de grupo se disponivel
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = "SELECT cContas, dContas FROM SigReCtb " + ;
                       "WHERE CAST(cGrupos AS VARCHAR(50)) = " + THIS.EscaparSQL(loc_cGrupo) + ;
                       " ORDER BY cContas"
        ELSE
            loc_cSQL = "SELECT cContas, dContas FROM SigReCtb ORDER BY cContas"
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTodos")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_BuscaTodos") = 0
            =MESSAGEBOX("Nenhuma conta encontrada" + IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", 48, "Aviso")
            IF USED("cursor_4c_BuscaTodos")
                USE IN cursor_4c_BuscaTodos
            ENDIF
            RETURN
        ENDIF

        * Usa FormBuscaSimples para exibir cursor ja carregado
        loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_BuscaTodos", ;
            "Busca de Contas" + IIF(!EMPTY(loc_cGrupo), " (Grupo: " + loc_cGrupo + ")", ""))
        loc_oBusca.mAddColuna("cContas", "", "Conta")
        loc_oBusca.mAddColuna("dContas", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show(1)

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTodos")
            THIS.Value = ALLTRIM(cursor_4c_BuscaTodos.cContas)
        ENDIF

        IF USED("cursor_4c_BuscaTodos")
            USE IN cursor_4c_BuscaTodos
        ENDIF
        loc_oBusca.Release()

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBusca - Sobrescreve para filtrar por Grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBusca()
        LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_oBusca

        loc_cValor = ALLTRIM(THIS.Value)

        * Obtem o grupo da linha atual
        IF USED("cursor_4c_CCLocal")
            SELECT cursor_4c_CCLocal
            loc_cGrupo = ALLTRIM(cursor_4c_CCLocal.Grupos)
        ELSE
            loc_cGrupo = ""
        ENDIF

        * Monta SQL com filtro de grupo se disponivel
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = "SELECT cContas, dContas FROM SigReCtb " + ;
                       "WHERE CAST(cGrupos AS VARCHAR(50)) = " + THIS.EscaparSQL(loc_cGrupo)
            IF !EMPTY(loc_cValor)
                loc_cSQL = loc_cSQL + " AND (CAST(cContas AS VARCHAR(50)) LIKE " + ;
                           THIS.EscaparSQL("%" + loc_cValor + "%") + ;
                           " OR dContas LIKE " + THIS.EscaparSQL("%" + loc_cValor + "%") + ")"
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY cContas"
        ELSE
            loc_cSQL = "SELECT cContas, dContas FROM SigReCtb"
            IF !EMPTY(loc_cValor)
                loc_cSQL = loc_cSQL + " WHERE CAST(cContas AS VARCHAR(50)) LIKE " + ;
                           THIS.EscaparSQL("%" + loc_cValor + "%") + ;
                           " OR dContas LIKE " + THIS.EscaparSQL("%" + loc_cValor + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY cContas"
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrid")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_BuscaGrid") = 0
            IF USED("cursor_4c_BuscaGrid")
                USE IN cursor_4c_BuscaGrid
            ENDIF
            =MESSAGEBOX("Nenhuma conta encontrada" + IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", 48, "Aviso")
            RETURN
        ENDIF

        * Se encontrou exatamente um registro com valor digitado, usa direto
        IF RECCOUNT("cursor_4c_BuscaGrid") = 1 AND !EMPTY(loc_cValor)
            THIS.Value = ALLTRIM(cursor_4c_BuscaGrid.cContas)
            IF USED("cursor_4c_BuscaGrid")
                USE IN cursor_4c_BuscaGrid
            ENDIF
            THIS.Refresh()
            RETURN
        ENDIF

        * Mostra janela de selecao
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigReCtb", ;
            "cursor_4c_BuscaGrid", ;
            "cContas", ;
            loc_cValor, ;
            "Busca de Contas" + IIF(!EMPTY(loc_cGrupo), " (Grupo: " + loc_cGrupo + ")", ""), ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            * Usa o cursor ja carregado
            loc_oBusca.mAddColuna("cContas", "", "Conta")
            loc_oBusca.mAddColuna("dContas", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrid")
                THIS.Value = ALLTRIM(cursor_4c_BuscaGrid.cContas)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrid")
            USE IN cursor_4c_BuscaGrid
        ENDIF

        THIS.Refresh()
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxGridMoedas - TextBox para lookup de Moedas (SigCdMoe)
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxGridMoedas AS TextBoxGridBase
    PROCEDURE Init()
        THIS.this_cTabela = "SigCdMoe"
        THIS.this_cCampoCodigo = "CMoes"
        THIS.this_cCampoDescricao = "DMoes"
        THIS.this_cTitulo = "Busca de Moedas"
        RETURN .T.
    ENDPROC
ENDDEFINE
