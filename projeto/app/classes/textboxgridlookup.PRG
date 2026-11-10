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
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaGrid") > 1
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


*------------------------------------------------------------------------------
* TextBoxContaCheque_4c - celula "No Conta" da grade de cheques (Formche).
*
* O legado (SIGCDCHE.Pagina.Dados.GradeCheque.Conta.Text1.Valid) completa a
* conta com ZEROS A ESQUERDA ao sair da celula:
*     replace TEMPCHQ.NCONTAS with PADL(ALLTRIM(this.value),10,'0')
* A coluna eh char(10) e o usuario digita so os digitos significativos. Sem a
* normalizacao o valor fica com menos de 10 caracteres e a validacao de
* gravacao (Len(AllTrim(NContas)) # 10, tambem do legado) recusa o lote com
* "Cheque com Dados Invalidos !" - Erro208.
*
* Instalado com Column.AddObject + CurrentControl + Sparse = .F. (regra #18):
* validacao de celula vive no Valid do TextBox da coluna, nunca em
* AfterRowColChange (regra #46).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxContaCheque_4c AS TextBox
    FontName    = "Courier New"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    Format      = "9999999999"
    InputMask   = "9999999999"

    PROCEDURE Valid()
        IF !EMPTY(ALLTRIM(THIS.Value))
            THIS.Value = PADL(ALLTRIM(THIS.Value), 10, "0")
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* Celulas da grade de grupos do FormCla (Cadastro de Classificacao de Produto).
*
* No legado a busca mora no Valid do TextBox de CADA coluna
* (SIGCDCLA.Pagina.Dados.grdProdutos.ColumnN.Text1.Valid). O migrado tinha
* ligado tudo a AfterRowColChange, que dispara DEPOIS de entrar na celula nova
* e entrega a coluna de DESTINO: ao sair da coluna 1 o nColIndex ja eh 2 e o
* handler chamava o validador ERRADO - o lookup do Grupo nunca rodava (Erro209).
*
* O corpo vive no form (ValidarCGrusGridExec / ValidarDGrusGridExec) e recebe o
* proprio TextBox, porque dentro do Valid o valor digitado esta em THIS.Value e
* ainda NAO chegou ao cursor.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxGrupoCla_4c AS TextBox
    FontSize    = 8
    FontItalic  = .F.
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCGrusGridExec", 5)
            RETURN THISFORM.ValidarCGrusGridExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


DEFINE CLASS TextBoxDescGrupoCla_4c AS TextBox
    FontSize    = 8
    FontItalic  = .F.
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    *-- Legado (Column2.Text1.When): a descricao so eh editavel enquanto a
    *-- coluna do CODIGO estiver vazia.
    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "DescGrupoEditavel", 5)
            RETURN THISFORM.DescGrupoEditavel()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarDGrusGridExec", 5)
            RETURN THISFORM.ValidarDGrusGridExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxProdutoAntMdp_4c - celula "Codigo Original" (Column1) da grade de
* pares de substituicao do Formsigprmdp (fila de recalculo de custo).
*
* Legado (SIGPRMDP.Grade.Column1.Text1.Valid): com ThisForm.Checkcadpro = .F.
* abre fwBuscaExt contra SigCdPro (campo Cpros/Dpros) para validar o codigo
* antigo digitado; com Checkcadpro = .T. (modo que aceita codigo de produto
* ainda nao cadastrado), o Valid nao faz nada e o codigo digitado eh aceito
* como esta.
*
* Instalado com Column.AddObject + CurrentControl + Sparse = .F. (regra #18):
* validacao de celula vive no Valid do TextBox da coluna, nunca em
* AfterRowColChange (regra #46). O corpo mora no form
* (ValidarCProsAntGridExec), que recebe o proprio TextBox - dentro do Valid
* o valor digitado esta em THIS.Value e ainda nao chegou ao cursor.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxProdutoAntMdp_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCProsAntGridExec", 5)
            RETURN THISFORM.ValidarCProsAntGridExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCelulaTamanho_4c - celulas da grade de "Peso medio por tamanho"
* (Formsigprtam / SIGPRTAM.Grade).
*
* No legado cada Column<N>.Text1 tem When (gate de modo) e, nas colunas de
* lookup (Column1/Column2) e de calculo (Column4/Column5), Valid proprio.
* BINDEVENT em evento de celula de Grid nao eh confiavel (ver o cabecalho
* deste arquivo e a regra #46): a celula tem de ser uma classe com os eventos
* EMBUTIDOS, instalada com Column.AddObject + CurrentControl + Sparse = .F.
* (regra #18).
*
* this_cPapel identifica a coluna - "COD" (Column1/CodTams), "DESC"
* (Column2/Descs), "PESO" (Column3/PesoMs), "PERC" (Column4/Percs),
* "VALOR" (Column5/Valor), "PRAZO" (Column6/DiasPrz). O corpo mora no form
* (depende do cursor, do BO e do preco de venda do produto) e recebe o
* proprio TextBox: dentro do Valid o valor digitado esta em THIS.Value e
* AINDA NAO chegou ao cursor.
*
* F4/F5 e duplo clique abrem o picker direto nas duas celulas de lookup.
* O legado nao tem esse atalho (so o Valid, ao sair da celula) - eh o padrao
* do sistema novo e nao altera o que eh gravado.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelulaTamanho_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    Margin      = 0
    this_cPapel = ""

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "CelulaGradeEditavel", 5)
            RETURN THISFORM.CelulaGradeEditavel(THIS.this_cPapel, THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCelulaGradeExec", 5)
            RETURN THISFORM.ValidarCelulaGradeExec(THIS.this_cPapel, THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) AND INLIST(THIS.this_cPapel, "COD", "DESC")
            IF PEMSTATUS(THISFORM, "AbrirLookupTamanhoGrade", 5)
                THISFORM.AbrirLookupTamanhoGrade(THIS.this_cPapel, THIS)
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DblClick()
        IF INLIST(THIS.this_cPapel, "COD", "DESC")
            IF PEMSTATUS(THISFORM, "AbrirLookupTamanhoGrade", 5)
                THISFORM.AbrirLookupTamanhoGrade(THIS.this_cPapel, THIS)
            ENDIF
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxProdutoTrf_4c - celula "Codigo" (Column1) da grade de produtos do
* FormSIGPRTRF (dialogo "Relacao de Produtos" usado pela Transferencia).
*
* Legado (SIGPRTRF.Cnt_Referencia.Grade.Column1.Text1):
*   When      -> ThisForm.AntCPro = This.Value (snapshot do valor anterior)
*   Valid     -> fwBuscaExt contra SigCdPro (cpros/dpros) quando o valor
*                mudou e nao esta vazio; preenche a coluna Descricao
*                (Column2) junto
*   LostFocus -> com ENTER (Lastkey()=13): linha vazia -> foca o botao Ok;
*                senao garante uma linha vazia abaixo (Append Blank se
*                precisar) e avanca a grade para ela (Keyboard '{DNARROW}')
*
* Instalado com Column.AddObject + CurrentControl + Sparse = .F. (regra #18);
* os tres eventos delegam para o form (regra #46: Valid do TextBox da
* coluna, nunca AfterRowColChange) porque dependem do cursor da grade e dos
* demais controles do dialogo (botao Ok).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxProdutoTrf_4c AS TextBox
    FontName    = "Courier New"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    InputMask   = "!!!!!!!!!!"
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "GuardarCodigoAnteriorProduto", 5)
            THISFORM.GuardarCodigoAnteriorProduto(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCodigoProdutoGridExec", 5)
            RETURN THISFORM.ValidarCodigoProdutoGridExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE LostFocus()
        IF PEMSTATUS(THISFORM, "AvancarLinhaProdutoGridExec", 5)
            THISFORM.AvancarLinhaProdutoGridExec()
        ENDIF
    ENDPROC

    *-- F4/F5 abrem o picker de produto direto, com o campo vazio ou nao
    *-- (afordancia padrao do sistema novo, igual a TextBoxGridBase acima).
    *-- Guard de tecla OBRIGATORIO: sem ele o picker subiria a CADA tecla
    *-- digitada e o usuario nao terminaria de digitar o codigo (regra #47).
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)  && F4 = 115, F5 = 116
            IF PEMSTATUS(THISFORM, "AbrirBuscaProdutoGrade", 5)
                THISFORM.AbrirBuscaProdutoGrade(THIS)
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Duplo clique DENTRO da celula: o VFP entrega o evento ao controle
    *-- sob o ponteiro, que eh este TextBox. Fora da celula quem recebe eh
    *-- o proprio Grid (BINDEVENT -> GradeProdutosDblClick no form). As
    *-- duas rotas chamam o MESMO funil, guardado por reentrancia.
    PROCEDURE DblClick()
        IF PEMSTATUS(THISFORM, "AbrirBuscaProdutoGrade", 5)
            THISFORM.AbrirBuscaProdutoGrade(THIS)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCelulaEmn_4c - celulas da grade de itens (gradei) do FormEmn
* (Estoque Alvo / SIGCDEMN).
*
* O legado poe TODO o comportamento no Text1 de cada Column:
*
*   Col  papel  When (legado)                          Valid (legado)
*   ---  -----  -------------------------------------  --------------------------
*    1   EMP    cpros<>'' e Value VAZIO e edicao       fAcessoEmpresa -> picker
*    2   QTD    cpros<>'' e edicao                     Value < 0 -> aviso e zera
*    3   TAM    emps<>'' e cpros<>'' e lTemTam e ed.   fwBuscaExt SigCdTam
*    4   COR    emps<>'' e cpros<>'' e lTemCor e ed.   fwBuscaExt SigCdCor
*    5   GRU    cpros<>'' e edicao                     fAcessoContab -> picker
*    6   CTA    cpros<>'' e edicao                     fAcessoContas -> picker
*    7   LCL    cpros<>'' e edicao                     fwBuscaExt SigPrLcl (Tipos=3)
*    8   QID    cpros<>'' e edicao                     Value < 0 -> aviso e zera
*
* Alem disso o Column7 (Local) tem LostFocus chamando ThisForm.MNovaLinha(),
* que eh como o legado INCLUI uma linha nova na grade.
*
* Instalado com Column.AddObject + CurrentControl + Sparse = .F. (regra #18).
* BINDEVENT em Valid de TextBox de Column NAO eh confiavel (regra #46 e
* docs/grid_implementation.md), por isso os eventos moram na classe e
* delegam para metodos PUBLIC do form.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelulaEmn_4c AS TextBox
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)
    this_cPapel = ""        && EMP QTD TAM COR GRU CTA LCL QID

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "CelulaGradeEmnEditavel", 5)
            RETURN THISFORM.CelulaGradeEmnEditavel(THIS.this_cPapel, THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCelulaGradeEmn", 5)
            RETURN THISFORM.ValidarCelulaGradeEmn(THIS.this_cPapel, THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    *-- So a celula Local cria linha nova, como no legado (Column7.Text1.LostFocus)
    PROCEDURE LostFocus()
        IF THIS.this_cPapel == "LCL"
            IF PEMSTATUS(THISFORM, "NovaLinhaGradeEmn", 5)
                THISFORM.NovaLinhaGradeEmn()
            ENDIF
        ENDIF
    ENDPROC

    *-- F4/F5 abrem o picker com o campo vazio ou nao (afordancia do sistema
    *-- novo). Guard de tecla OBRIGATORIO: sem ele o picker subiria a CADA
    *-- tecla e o usuario nao terminaria de digitar o codigo (regra #47).
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)  && F4 = 115, F5 = 116
            IF PEMSTATUS(THISFORM, "AbrirLookupCelulaEmn", 5)
                THISFORM.AbrirLookupCelulaEmn(THIS.this_cPapel, THIS)
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DblClick()
        IF PEMSTATUS(THISFORM, "AbrirLookupCelulaEmn", 5)
            THISFORM.AbrirLookupCelulaEmn(THIS.this_cPapel, THIS)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCelulaFollowupCfl_4c - celula "Data / Hora" (Column1) da grade de
* followup do FormSigOpCfl (SIGOPCFL.gridFollowup).
*
* Legado (SIGOPCFL.gridFollowup.Column1.Text1):
*   When  -> Return ThisForm.cmdApagaItem.cmdApagar.Visible
*            (a celula so recebe foco quando o usuario tem acesso de EXCLUIR -
*            eh por esse foco que o cmdApagar.Click devolve o cursor para a
*            grade depois de apagar a linha: Column1.Text1.Setfocus)
*   Valid -> If Empty(this.value) / MessageBox('Data Invalida!',0+64,"Atencao!")
*            / Return 0
*
* BINDEVENT em evento de celula de Grid NAO eh confiavel (ver o cabecalho
* deste arquivo e a regra #46/CLAUDE.md): a celula tem de ser uma classe com
* os eventos EMBUTIDOS, instalada com Column.AddObject + CurrentControl +
* Sparse = .F. (regra #18). O corpo mora no form - depende do CommandGroup de
* acoes (cmg_4c_CmdApagaitem) e do cursor da grade - e recebe o proprio
* TextBox: dentro do Valid o valor digitado esta em THIS.Value e AINDA NAO
* chegou ao cursor (regra #46).
*
* FontName/Margin/ReadOnly espelham o Column1.Text1 do dump legado
* (FontName "Courier New" vem do Column1, ReadOnly = .T. do proprio Text1) -
* a grade do legado eh inteiramente somente-leitura, o When existe so para
* gatear o FOCO da celula.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelulaFollowupCfl_4c AS TextBox
    FontName    = "Courier New"
    FontSize    = 8
    Margin      = 0
    BorderStyle = 0
    Alignment   = 3
    ReadOnly    = .T.

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "CelulaDataFollowupEditavel", 5)
            RETURN THISFORM.CelulaDataFollowupEditavel(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCelulaDataFollowupExec", 5)
            RETURN THISFORM.ValidarCelulaDataFollowupExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCfopGridCfp_4c - celula "CFOP" (Column1) da grade de Cfops
* Permitidos do FormSigOpCfp (SIGOPCFP.GradeSubN.Column1.Text1).
*
* Legado:
*   Valid     -> Lastkey() == 27 aborta sem lookup (ESC preserva o valor
*                atual); senao fwBuscaExt contra SigCdCfo (Codigos/
*                Descricaos/Operacaos) - o Init de FormBuscaAuxiliar ja
*                tenta o match exato (regra #37); This.Value recebe o
*                Codigos escolhido, ou '' se o usuario cancelou o picker
*                com ESC (mesmo comportamento do legado: "Else This.Value
*                = ''")
*   LostFocus -> If IsEmpty(This.Value) / Thisform.cmdSair.SetFocus
*                (linha ficou sem CFOP - foca o botao de saida em vez de
*                deixar o foco preso na grade)
*
* Instalado com Column.AddObject + CurrentControl + Sparse = .F. (regra
* #18); Valid delega para o form (regra #46) - o corpo recebe o proprio
* TextBox, porque dentro do Valid o valor digitado esta em THIS.Value e
* ainda nao chegou ao cursor da grade.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCfopGridCfp_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCfopGridExec", 5)
            RETURN THISFORM.ValidarCfopGridExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE LostFocus()
        IF EMPTY(ALLTRIM(NVL(THIS.Value, ""))) AND PEMSTATUS(THISFORM, "cmd_4c_CmdSair", 5)
            THISFORM.cmd_4c_CmdSair.SetFocus()
        ENDIF
    ENDPROC

    *-- F4/F5 abrem o picker direto (afordancia do sistema novo, igual aos
    *-- demais lookups de grade) - guard de tecla obrigatorio (regra #47),
    *-- senao o picker subiria a cada tecla digitada.
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            IF PEMSTATUS(THISFORM, "AbrirLookupCfopGrade", 5)
                THISFORM.AbrirLookupCfopGrade(THIS)
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxObsGridCfp_4c - celula de Observacao (ObsPads/ObsInis/ObsFins -
* Column2/Column3/Column4) da grade de Cfops Permitidos do FormSigOpCfp.
*
* this_cCampoObs identifica QUAL coluna a instancia representa
* ("OBSPADS"/"OBSINIS"/"OBSFINS") - setado apos o AddObject, em
* ConfigurarGrade() do form. Valid/KeyPress delegam para um UNICO par de
* metodos do form (ValidarObsGridExec/AbrirLookupObsGrade - regra #46), que
* usa this_cCampoObs para aplicar a validacao cruzada certa contra as OUTRAS
* duas colunas da mesma linha.
*
* Legado (as 3 colunas repetem o mesmo padrao): Valid faz fwBuscaExt contra
* SigCdObs quando This.Value != 0 (coluna numeric(3,0)) e, em seguida, valida
* cruzado contra Padrao/Inicial/Final da linha corrente - "Return 0" mantem o
* foco na celula quando a cruzada falha. When -> Not Empty(TmpCfoOp.Cfops)
* (habilitada so depois da celula CFOP preenchida - CelulaObsGradeEditavel,
* fase 7/8).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxObsGridCfp_4c AS TextBox
    FontName       = "Tahoma"
    FontSize       = 8
    BorderStyle    = 0
    Margin         = 0
    ForeColor      = RGB(0, 0, 0)
    BackColor      = RGB(255, 255, 255)
    this_cCampoObs = ""

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "CelulaObsGradeEditavel", 5)
            RETURN THISFORM.CelulaObsGradeEditavel()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarObsGridExec", 5)
            RETURN THISFORM.ValidarObsGridExec(THIS, THIS.this_cCampoObs)
        ENDIF
        RETURN .T.
    ENDPROC

    *-- F4/F5 abrem o picker direto (afordancia do sistema novo, igual aos
    *-- demais lookups de grade) - guard de tecla obrigatorio (regra #47).
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            IF PEMSTATUS(THISFORM, "AbrirLookupObsGrade", 5)
                THISFORM.AbrirLookupObsGrade(THIS)
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCelulaFti_4c - celula das grades do FormFti (Grupos de Produto e
* Custos Fixo).
*
* BINDEVENT em "When"/"Valid" de Column.Text1 NAO dispara de forma confiavel
* (regra #46): os lookups de Grupo e Produto simplesmente nunca abriam. O
* padrao certo eh TextBox subclasse com os eventos EMBUTIDOS, instalada com
* AddObject + CurrentControl + Sparse = .F. (regra #18), delegando a metodos
* PUBLIC do form.
*
* this_cCelula diz QUAL celula a instancia representa - uma classe so para as
* seis, como no TextBoxObsGridCfp_4c:
*   GRUPOCOD  GRUPOCOEF  GRUPOPROD  CUSTOCOD  CUSTOCOEF  CUSTOCOL4
*
* O Valid passa THIS para o form: dentro dele o digitado vive em .Value, e o
* cursor so recebe depois (regra #46).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelulaFti_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    this_cCelula = ""

    PROCEDURE When()
        LOCAL loc_cM
        loc_cM = THIS.MetodoWhen()
        IF !EMPTY(loc_cM) AND PEMSTATUS(THISFORM, loc_cM, 5)
            RETURN EVALUATE("THISFORM." + loc_cM + "()")
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_cM
        loc_cM = THIS.MetodoValid()
        IF !EMPTY(loc_cM) AND PEMSTATUS(THISFORM, loc_cM, 5)
            RETURN EVALUATE("THISFORM." + loc_cM + "(THIS)")
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cM
        loc_cM = THIS.MetodoKeyPress()
        IF !EMPTY(loc_cM) AND PEMSTATUS(THISFORM, loc_cM, 5)
            EVALUATE("THISFORM." + loc_cM + "(par_nKeyCode, par_nShiftAltCtrl)")
        ENDIF
    ENDPROC

    PROCEDURE MetodoWhen()
        DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "GRUPOCOD"
                RETURN "GradeGrupoCol1When"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "GRUPOCOEF"
                RETURN "GradeGrupoCol3When"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "GRUPOPROD"
                RETURN "GradeGrupoCol4When"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "CUSTOCOD"
                RETURN "GradeCustoCol1When"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "CUSTOCOEF"
                RETURN "GradeCustoCol3When"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "CUSTOCOL4"
                RETURN "GradeCustoCol4When"
        ENDCASE
        RETURN ""
    ENDPROC

    PROCEDURE MetodoValid()
        DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "GRUPOCOD"
                RETURN "GradeGrupoCol1Valid"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "GRUPOPROD"
                RETURN "GradeGrupoCol4Valid"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "CUSTOCOD"
                RETURN "GradeCustoCol1Valid"
        ENDCASE
        RETURN ""
    ENDPROC

    PROCEDURE MetodoKeyPress()
        DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "GRUPOCOEF"
                RETURN "GradeGrupoCol3LostFocus"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "CUSTOCOEF"
                RETURN "GradeCustoCol3LostFocus"
        ENDCASE
        RETURN ""
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxMoedaGridCot_4c - celula "Moeda" (Column1) da grade de cotacoes do
* FormSigOpCot (SIGOPCOT.Gradeget_cotacao.moeda.Text1).
*
* Legado: PROCEDURE When / Return .f. - a coluna Moeda eh sempre SOMENTE
* LEITURA (Column.ReadOnly fica .F. no dump, o bloqueio eh so pelo When).
* Constante literal, sem delegar ao form: nao ha calculo nem estado algum
* envolvido, so o "nunca entra na celula" do legado.
*
* Instalada com Column.AddObject + CurrentControl + Sparse = .F. (regra #18) -
* BINDEVENT em "When" de Column.Text1 nao eh confiavel (regra #46/CLAUDE.md).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxMoedaGridCot_4c AS TextBox
    FontName    = "Verdana"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    Format      = "K"
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        RETURN .F.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCotacaoGridCot_4c - celula "Cotacao" (Column2) da grade de cotacoes
* do FormSigOpCot (SIGOPCOT.Gradeget_cotacao.cotacao.Text1).
*
* Legado (When):
*   ThisForm.AntValue = This.Value
*   ThisForm.Parentform.poDataMgr.CursorQuery([SigCdUsu],...)
*   ThisForm.Parentform.poDataMgr.CursorQuery([SigCdMoe],...)
*   Return (Seek(crSigCdUsu.Ccargs,[crSigCdCrg],[Ccargs]) And
*           (crSigCdCrg.AltCots=[S]) And crSigCdMoe.Cotas)
*
* Legado (KeyPress):
*   Lparameters nKeyCode, nShiftAltCtrl
*   If (nKeyCode = 9)
*       ThisForm.cntBotoes.btnConfirmar.SetFocus
*   EndIf
*
* Legado (Valid):
*   Local ldDatas
*   ldDatas = ThisForm.dDatas
*   If (LastKey() = 13)
*       Keyboard [{DnArrow}]
*   EndIf
*
* O snapshot do valor anterior (AntValue) e os dois termos de permissao
* (cargo + moeda cotavel) moram no BO (RegistrarCelulaCorrente /
* PodeAlterarCotacao - SigOpCotBO.prg), que resolve os cursores de apoio
* sob demanda em vez do CursorQuery do legado. Os tres eventos so DELEGAM,
* cada um para o metodo PUBLIC homonimo do form.
*
* Esta eh a UNICA celula digitavel da tela, e por isso os TRES eventos do
* legado (When / Valid / KeyPress) moram aqui - e nao em BINDEVENT: a regra
* #46 do CLAUDE.md eh explicita de que BINDEVENT em "Valid"/"When" de
* TextBox de Column NAO eh confiavel. Instalada com Column.AddObject +
* CurrentControl + Sparse = .F. (regra #18).
*
* Nenhum dos tres usa NODEFAULT: o legado tambem nao usa, e suprimir o
* tratamento nativo da tecla mudaria a navegacao da grade (PILAR 1).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCotacaoGridCot_4c AS TextBox
    FontName    = "Verdana"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    Format      = "K"
    InputMask   = "99999.9999999"
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    *-- When legado: guarda o valor anterior da celula e devolve a permissao
    *-- (cargo com altcots = S E moeda cotavel). Devolvendo .F., o Grid nao
    *-- deixa o foco entrar na celula - eh o bloqueio de edicao do legado
    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "ValidarAcessoCotacao", 5)
            RETURN THISFORM.ValidarAcessoCotacao(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    *-- Valid legado: com ENTER, desce uma linha na grade ({DnArrow})
    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCotacao", 5)
            RETURN THISFORM.ValidarCotacao(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    *-- KeyPress legado: com TAB (9), o foco vai para o botao Salvar
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF PEMSTATUS(THISFORM, "ValidarCotacaoKeyPress", 5)
            THISFORM.ValidarCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCaracteristicaDet_4c - celula "Caracteristica" (Column1) da grade
* de detalhes do FormSigOpDet (SIGOPDET.Grade.Column1.Text1).
*
* Legado:
*   When  -> InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
*   Valid -> com valor digitado, procura em LocalFtc (Distinct cCars,
*            Desccars); se nao achar exato, abre fwbuscaint sobre o proprio
*            universo (LocalCars); grava o resultado com Replace CCars
*            With This.Value in crSigMvFtc
*
* No migrado o universo e um CURSOR local (cursor_4c_LocalFtc), nao uma
* tabela do SQL Server - por isso o picker usa FormBuscaSimples (que exibe
* um cursor JA carregado), nao FormBuscaAuxiliar. O corpo mora no form
* (ValidarCaracteristicaDetExec), que recebe o proprio TextBox - regra #46:
* BINDEVENT em Valid/When de Column.Text1 nao eh confiavel, por isso os
* eventos ficam EMBUTIDOS na classe, instalada com Column.AddObject +
* CurrentControl + Sparse = .F. (regra #18).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCaracteristicaDet_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 20
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "GradeDetEditavel", 5)
            RETURN THISFORM.GradeDetEditavel()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCaracteristicaDetExec", 5)
            RETURN THISFORM.ValidarCaracteristicaDetExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxComplementoDet_4c - celula "Complemento" (Column2) da grade de
* detalhes do FormSigOpDet (SIGOPDET.Grade.Column2.Text1).
*
* Legado:
*   When      -> igual ao Column1 (INSERIR/ALTERAR)
*   Valid     -> procura em LocalFtc filtrado pela Caracteristica da MESMA
*                linha (Where CCars = lcCCars); nao achando exato, abre
*                fwbuscaint sobre esse subconjunto (LocalTits); grava com
*                Replace cTits With This.Value in crSigMvFtc e, se o valor
*                nao ficou vazio, zera a coluna Resps da linha (Replace
*                Resps With [] in crSigMvFtc)
*   LostFocus -> garante linha em branco no fim da grade e desce o foco
*                (mesmo comportamento do Column3 - THISFORM.
*                GarantirLinhaVaziaGradeDet)
*
* O corpo mora no form (ValidarComplementoDetExec) - regra #46/#18, mesma
* razao do TextBoxCaracteristicaDet_4c acima.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxComplementoDet_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 20
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "GradeDetEditavel", 5)
            RETURN THISFORM.GradeDetEditavel()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarComplementoDetExec", 5)
            RETURN THISFORM.ValidarComplementoDetExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE LostFocus()
        IF PEMSTATUS(THISFORM, "GarantirLinhaVaziaGradeDet", 5)
            THISFORM.GarantirLinhaVaziaGradeDet(THIS)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxOutrosDet_4c - celula "Outros" (Column3, coluna Resps - observacao
* livre) da grade de detalhes do FormSigOpDet (SIGOPDET.Grade.Column3.Text1).
*
* Legado:
*   When      -> Empty(crSigMvFtc.cTits) And InList(ThisForm.pcEscolha,
*                'INSERIR','ALTERAR') - so editavel quando a linha NAO tem
*                Complemento escolhido (texto livre eh alternativa ao
*                catalogo de Complementos, nao soma com ele)
*   LostFocus -> mesma garantia de linha em branco do Column2
*
* Sem Valid proprio no legado (texto livre, sem lookup) - o ControlSource
* nativo do Grid ja grava o valor digitado na saida da celula.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxOutrosDet_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 20
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "GradeDetOutrosEditavel", 5)
            RETURN THISFORM.GradeDetOutrosEditavel()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE LostFocus()
        IF PEMSTATUS(THISFORM, "GarantirLinhaVaziaGradeDet", 5)
            THISFORM.GarantirLinhaVaziaGradeDet(THIS)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCelulaDmp_4c - celulas da grade de fases do FormSigOpDmp
* (SIGOPDMP.Pagina.Dados.Grade.ColumnN.Text1 do SCX legado).
*
* BINDEVENT em "When"/"Valid" de Column.Text1 NAO dispara de forma confiavel
* (regra #46) e AfterRowColChange entrega a coluna de DESTINO, nao a de
* origem - o padrao certo eh TextBox subclasse com os eventos EMBUTIDOS,
* instalada com AddObject + CurrentControl + Sparse = .F. (regra #18),
* delegando a metodos PUBLIC do form.
*
* this_cCelula diz QUAL celula a instancia representa - uma classe so para as
* cinco, como no TextBoxCelulaFti_4c:
*   ORDEM  FASE  FUNCIONARIO  TPOP  ES
*
* O Valid passa THIS para o form: dentro dele o valor DIGITADO vive em
* .Value e o cursor so recebe depois (regra #46) - ler do cursor validaria o
* valor ANTIGO.
*
* Defaults visuais transcritos de Grade.ColumnN.Text1 do dump (Tahoma 8,
* BorderStyle = 0, Margin = 0, ForeColor 0,0,0, BackColor 255,255,255).
* Column3.Text1 declara BackStyle = 0 no dump: aplicado na INSTANCIA, nao
* aqui, porque e' o unico dos cinco que o tem.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelulaDmp_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    this_cCelula = ""

    *-- When: no legado as CINCO celulas tem o MESMO corpo
    *--   Return Inlist( ThisForm.pcEscolha, 'INSERIR', 'ALTERAR' )
    *-- logo um unico metodo do form responde por todas.
    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "GradeFasesCelulaWhen", 5)
            RETURN THISFORM.GradeFasesCelulaWhen()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_cM
        loc_cM = THIS.MetodoValid()
        IF !EMPTY(loc_cM) AND PEMSTATUS(THISFORM, loc_cM, 5)
            RETURN EVALUATE("THISFORM." + loc_cM + "(THIS)")
        ENDIF
        RETURN .T.
    ENDPROC

    *-- F4/F5 e duplo clique: mesma porta do Valid nas celulas de lookup.
    *-- Celula de validacao pura (ORDEM/ES) nao tem lookup e nada abre.
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cM
        IF INLIST(par_nKeyCode, 115, 116)
            loc_cM = THIS.MetodoLookup()
            IF !EMPTY(loc_cM) AND PEMSTATUS(THISFORM, loc_cM, 5)
                EVALUATE("THISFORM." + loc_cM + "(THIS)")
                NODEFAULT
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DblClick()
        LOCAL loc_cM
        loc_cM = THIS.MetodoLookup()
        IF !EMPTY(loc_cM) AND PEMSTATUS(THISFORM, loc_cM, 5)
            EVALUATE("THISFORM." + loc_cM + "(THIS)")
        ENDIF
    ENDPROC

    PROCEDURE MetodoValid()
        DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "ORDEM"
                RETURN "GradeFasesOrdemValid"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "FASE"
                RETURN "GradeFasesFaseValid"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "FUNCIONARIO"
                RETURN "GradeFasesFuncionarioValid"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "TPOP"
                RETURN "GradeFasesTpOpValid"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "ES"
                RETURN "GradeFasesEsValid"
        ENDCASE
        RETURN ""
    ENDPROC

    PROCEDURE MetodoLookup()
        DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "FASE"
                RETURN "AbrirLookupFaseGrade"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "FUNCIONARIO"
                RETURN "AbrirLookupFuncionarioGrade"
            CASE UPPER(ALLTRIM(THIS.this_cCelula)) == "TPOP"
                RETURN "AbrirLookupTpOpGrade"
        ENDCASE
        RETURN ""
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxMovimentacaoMop_4c - celula "Movimentacao" (Column1) da grade de
* operacoes multiplas do FormSigOpMop (SIGOPMOP.GradeSubN.Column1.Text1).
*
* Legado:
*   When      -> Return( ( crSigCdMop.cDopes = crSigCdOpe.Dopes ) And
*                         IsEmpty( crSigCdMop.cNivels ) )
*                (so a linha NOVA, ainda sem operacao filha, aceita foco -
*                 depois de preenchida, a Movimentacao nao se edita mais)
*   Valid     -> fwBuscaExt contra SigCdOpe (lookup da operacao FILHA, com
*                recusa de operacao INATIVA e REPLACE de ndopes) - o corpo
*                mora em THISFORM.ValidarMovimentacaoMopExec
*   LostFocus -> If IsEmpty(This.Value) / Thisform.cmdSair.SetFocus / Endif
*
* Instalada com Column.AddObject + CurrentControl + Sparse = .F. (regra #18);
* BINDEVENT em evento de celula de Grid NAO eh confiavel (regra #46). When/
* LostFocus moram no form (Fase 5) e o Valid delega para
* THISFORM.ValidarMovimentacaoMopExec (Fase 6). O guard PEMSTATUS fica: ele
* eh o que impede a classe de estourar se for reusada por um form que nao
* implemente o delegate (BINDEVENT/delegate inexistente aborta o Init).
*
* MaxLength = 20 vem da LARGURA DA COLUNA no schema (SigCdMop.cnivels
* char(20), lookup em SigCdOpe.dopes char(20)), nunca do Width em pixels
* (regra #19). O dump nao o declara porque la o ControlSource ligava a celula
* direto na coluna char(20) e o VFP truncava sozinho.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxMovimentacaoMop_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 20
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "CelulaMovimentacaoMopEditavel", 5)
            RETURN THISFORM.CelulaMovimentacaoMopEditavel()
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarMovimentacaoMopExec", 5)
            RETURN THISFORM.ValidarMovimentacaoMopExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE LostFocus()
        IF PEMSTATUS(THISFORM, "MovimentacaoMopLostFocusExec", 5)
            THISFORM.MovimentacaoMopLostFocusExec(THIS)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxCoresMop_4c - celula "Cores" (Column3) da grade de operacoes
* multiplas do FormSigOpMop (SIGOPMOP.GradeSubN.Column3.Text1).
*
* Legado:
*   When  -> ThisForm.Antvalue = This.Value
*            Return( ( crSigCdMop.cDopes = crSigCdOpe.Dopes ) And
*                     Not IsEmpty( crSigCdMop.cNivels ) )
*            (so a linha JA LIGADA a uma operacao filha aceita foco; o
*             snapshot do valor anterior vai ANTES do teste, igual ao legado)
*   Valid -> If This.Value <> ThisForm.Antvalue
*                Thisform.lHouveIns = .T.
*                If This.Value > 0
*                    x = GetColor(This.Value)
*                    If x > 0 / This.Value = x / Else / This.Value = 0 / Endif
*                    This.Refresh
*                Endif
*            Endif
*            (GetColor() eh funcao NATIVA do VFP9 - abre o seletor de cor do
*             Windows - e por isso NAO eh lookup/Fase 6: o Valid fica aqui)
*
* O ReadOnly desta coluna (travada quando geropes <> 2) continua decidido em
* ConfigurarColunasGrade (Fase 4) - o When aqui so governa linha EM BRANCO
* versus linha JA PREENCHIDA, nunca a permissao de geropes.
*
* InputMask/MaxLength de 10 digitos (coerentes com ncors numeric(10,0)) vem
* da classe, nao de atribuicao por instancia - ConfigurarColunasGrade nao
* precisa repeti-los.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCoresMop_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    InputMask   = "9999999999"
    MaxLength   = 10
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE When()
        IF PEMSTATUS(THISFORM, "CelulaCoresMopEditavel", 5)
            RETURN THISFORM.CelulaCoresMopEditavel(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarCoresMopExec", 5)
            RETURN THISFORM.ValidarCoresMopExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxGrandeGrupoMop_4c - celula "G.Grp" (Column6) da grade de operacoes
* multiplas do FormSigOpMop (SIGOPMOP.GradeSubN.Column6.Text1).
*
* Legado:
*   GotFocus  -> This.Tag = This.Value
*   Valid     -> If Not Empty(This.Value)
*                    loLista = CreateObject([fwBuscaExt], ..., [SigCdGpr],
*                                [crListaRemota], [Codigos], This.Value,
*                                [Selecao], .t.)
*                    If Not loLista.plAchouRegistro
*                        loLista.mAddColuna([Codigos], [], [Codigo])
*                        loLista.mAddColuna([Descs],   [], [Descricao])
*                        loLista.Show()
*                    EndIf
*                    This.Value = crListaRemota.Codigos
*                    Use In crListaRemota
*                EndIf
*                This.Refresh
*   LostFocus -> If (This.Tag <> This.Value) / Thisform.lHouveIns = .T. / Endif
*
* O par GotFocus/LostFocus eh o detector de "o usuario mudou o grande grupo":
* o Tag guarda o valor de ENTRADA e o LostFocus compara com o de SAIDA para
* ligar a flag de gravacao. Sem o GotFocus o Tag nasce vazio e QUALQUER
* passagem pela celula marcaria a tela como alterada.
*
* Tag eh CHARACTER em VFP9 (nao aceita outro tipo): a comparacao do LostFocus
* roda sobre texto, e por isso o GotFocus guarda ALLTRIM() do valor, nunca o
* valor cru.
*
* MaxLength = 3 vem da LARGURA DA COLUNA no schema (SigCdMop.mercs char(3),
* lookup em SigCdGpr.codigos char(3)) - nunca do Width em pixels (regra #19).
* O dump do legado nao declara MaxLength aqui porque la o ControlSource ligava
* a celula direto na coluna char(3) e o VFP truncava sozinho.
*
* Instalada com Column.AddObject + CurrentControl + Sparse = .F. (regra #18);
* BINDEVENT em evento de celula de Grid NAO eh confiavel (regra #46), por isso
* os eventos moram na classe e delegam para metodos PUBLIC do form.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxGrandeGrupoMop_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 3
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE GotFocus()
        IF PEMSTATUS(THISFORM, "GrandeGrupoMopGotFocusExec", 5)
            THISFORM.GrandeGrupoMopGotFocusExec(THIS)
        ENDIF
    ENDPROC

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarGrandeGrupoMopExec", 5)
            RETURN THISFORM.ValidarGrandeGrupoMopExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE LostFocus()
        IF PEMSTATUS(THISFORM, "GrandeGrupoMopLostFocusExec", 5)
            THISFORM.GrandeGrupoMopLostFocusExec(THIS)
        ENDIF
    ENDPROC
ENDDEFINE


*------------------------------------------------------------------------------
* TextBoxEmpresaMop_4c - celula "Emp." (Column7) da grade de operacoes
* multiplas do FormSigOpMop (SIGOPMOP.GradeSubN.Column7.Text1).
*
* Legado:
*   Valid -> If !IsEmpty( This.Value )
*                xBrox = CreateObject('fwbuscaext', ..., 'SigCdEmp',
*                          'crSigCdEmp', 'cEmps', This.Value, 'Empresas', .t., 'cEmps')
*                If Not xBrox.plAchouRegistro
*                    xBrox.mAddColuna('CEmps', 'XXXXXX', 'Codigo', .t.)
*                    xBrox.mAddColuna('Razas', '', 'Descricao', .t.)
*                    xBrox.Show()
*                    This.Value = Iif( LastKey() # 27, Evaluate('crSigCdEmp.CEmps'), '' )
*                EndIf
*            Endif
*
* O dump declara ReadOnly = .F. nesta celula EXPLICITAMENTE (as outras nao
* declaram) - a coluna eh digitavel por projeto, e isso continua espelhado em
* ConfigurarColunasGrade, que poe Column7.ReadOnly = .F. DEPOIS do
* Grid.ReadOnly (o do grid propaga e sobrescreveria a trava da coluna).
*
* MaxLength = 3 vem do schema (SigCdMop.empds char(3), lookup em
* SigCdEmp.cemps char(3)), nao do Width em pixels (regra #19).
*
* Esta celula NAO tem LostFocus no legado, logo editar SO a empresa nao liga a
* flag de gravacao - comportamento TRANSCRITO, nao esquecimento. Na pratica a
* linha so chega a ter empresa depois de ter passado por Inserir (que ja liga a
* flag), e inventar aqui um LostFocus que o legado nao tem mudaria quando a
* tela decide gravar.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxEmpresaMop_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 3
    ReadOnly    = .F.
    ForeColor   = RGB(0, 0, 0)
    BackColor   = RGB(255, 255, 255)

    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ValidarEmpresaMopExec", 5)
            RETURN THISFORM.ValidarEmpresaMopExec(THIS)
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE
