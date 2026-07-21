*==============================================================================
* SIGREIDCBO.PRG
* Business Object para Relatorio de Identificacao de Contas (SIGREIDC)
* Herda de RelatorioBase
*
* Filtros:
*   this_cCdGrupo  / this_cDsGrupo  - Grupo contabil (SigCdGcr)
*   this_cCdConta  / this_cDsConta  - Conta (SigCdCli)
*   this_nLinha    - Linha inicial (1-5)
*   this_nColuna   - Coluna inicial (1-2)
*   this_lImprimirLogo - Imprimir logotipo
*==============================================================================

DEFINE CLASS SIGREIDCBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""
    this_cCdConta       = ""
    this_cDsConta       = ""
    this_nLinha         = 1
    this_nColuna        = 1
    this_lImprimirLogo  = .F.

    *-- Configuracao do relatorio
    this_cNomeRelatorio = "SigReIdc"
    this_cCursorDados   = "cIde"    && Nome exigido pelo FRX legado

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela     = "SigCdCli"
            THIS.this_cCampoChave = "Iclis"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREIDCBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais do sistema.
    * Chamado pelo form em InicializarForm() apos instanciar o BO.
    * Equivalente ao bloco do Init() legado que carrega SigCdPam e SigCdGcr.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Logo da empresa (Logos de SigCdPam) - usado em PrepararDados
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GrPadClis, Logos FROM SigCdPam", ;
                "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
            ENDIF

            *-- Grupos contabeis GerBals=1 para lookup do campo Grupo no form
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.Codigos, a.Descrs FROM SigCdGcr a " + ;
                "WHERE a.GerBals=1 ORDER BY a.Codigos", ;
                "cursor_4c_Grupos")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar grupos cont" + CHR(225) + "beis"
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor local cIde com dados para SigReIdc.frx.
    * Equivalente ao metodo 'processamento' do form legado SIGREIDC.
    *
    * Fluxo:
    *   1. Obtem razao social em SigCdEmp
    *   2. Busca contas em SigCdCli (filtros Grupos/Iclis + GerBals=1)
    *   3. Cria cursor local cIde com estrutura exata esperada pelo FRX
    *   4. Insere linhas em branco de offset (calculo Linha/Coluna)
    *   5. Para cada conta: insere linha, processa logo e foto
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmpresas, loc_nNregi, loc_nI
        LOCAL loc_lcCgrupo, loc_lcCconta, loc_nLinha, loc_nColuna
        LOCAL loc_cArqJpg, loc_cDirTemp
        loc_lSucesso = .F.
        TRY
            *-- Razao social da empresa
            loc_cEmpresas = ""
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpIdc")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpIdc
                IF !EOF()
                    loc_cEmpresas = ALLTRIM(cursor_4c_EmpIdc.Razas)
                ENDIF
                USE IN cursor_4c_EmpIdc
            ENDIF

            *-- Garantir que cursor de logo esta aberto
            IF !USED("cursor_4c_Pam")
                SQLEXEC(gnConnHandle, ;
                    "SELECT GrPadClis, Logos FROM SigCdPam", ;
                    "cursor_4c_Pam")
            ENDIF

            *-- Capturar filtros
            loc_lcCgrupo = ALLTRIM(THIS.this_cCdGrupo)
            loc_lcCconta = ALLTRIM(THIS.this_cCdConta)
            loc_nLinha   = THIS.this_nLinha
            loc_nColuna  = THIS.this_nColuna

            *-- Montar WHERE: replicar logica do original (conta sobrescreve grupo)
            *   Original: se ambos informados, lcSel = IClis filter (sobreescrito)
            *   O SCAN adicionalmente filtra por grupo - aqui unificado no SQL
            loc_cWhere = "a.GerBals = 1"
            IF !EMPTY(loc_lcCgrupo)
                loc_cWhere = loc_cWhere + " AND a.Grupos = " + EscaparSQL(loc_lcCgrupo)
            ENDIF
            IF !EMPTY(loc_lcCconta)
                loc_cWhere = loc_cWhere + " AND a.Iclis = " + EscaparSQL(loc_lcCconta)
            ENDIF

            *-- Query principal: contas filtradas com campos de foto
            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Figuras, a.FigJpgs " + ;
                "FROM SigCdCli a " + ;
                "WHERE " + loc_cWhere + ;
                " ORDER BY a.Grupos, a.Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasIdc")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar contas para o relat" + ;
                    CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursor de saida anterior se existir
            IF USED("cIde")
                USE IN cIde
            ENDIF

            *-- Criar cursor local com estrutura exata esperada pelo FRX SigReIdc
            CREATE CURSOR cIde ( ;
                cEmpresas C(50), ;
                cTitulo1s C(50), ;
                cGrupos   C(10), ;
                cContas   C(10), ;
                cDcontas  C(50), ;
                gLogos    C(64), ;
                gFotos    G(4) NULL, ;
                cArqJpgs  C(254), ;
                lBrancos  L(1))

            *-- Calcular offset de linhas em branco: ((Linha-1)+(Coluna-1))*5
            loc_nNregi = ((loc_nLinha - 1) + (loc_nColuna - 1)) * 5
            FOR loc_nI = 1 TO loc_nNregi
                INSERT INTO cIde ;
                    (cEmpresas, cTitulo1s, cGrupos, cContas, cDcontas, ;
                     gLogos, cArqJpgs, lBrancos) ;
                    VALUES ("", "", "", "", "", "", "", .T.)
            ENDFOR

            *-- Diretorio temporario para arquivos JPG de logo/foto
            loc_cDirTemp = ALLTRIM(SYS(2023))
            IF RIGHT(loc_cDirTemp, 1) != "\"
                loc_cDirTemp = loc_cDirTemp + "\"
            ENDIF

            *-- Processar cada conta
            SELECT cursor_4c_ContasIdc
            SCAN
                loc_cArqJpg = ""

                *-- Logo da empresa: copiar memo para JPG temporario
                IF THIS.this_lImprimirLogo
                    SELECT cursor_4c_Pam
                    IF !EOF() AND !ISNULL(cursor_4c_Pam.Logos) AND ;
                       !EMPTY(cursor_4c_Pam.Logos)
                        loc_cArqJpg = loc_cDirTemp + SYS(3) + ".Jpg"
                        COPY MEMO cursor_4c_Pam.Logos TO (loc_cArqJpg)
                    ENDIF
                    SELECT cursor_4c_ContasIdc
                ENDIF

                *-- Inserir linha de dados no cursor cIde
                INSERT INTO cIde ;
                    (cEmpresas, cTitulo1s, cGrupos, cContas, cDcontas, ;
                     gLogos, cArqJpgs, lBrancos) ;
                    VALUES ( ;
                        loc_cEmpresas, ;
                        "IDENTIFICA" + CHR(199) + CHR(195) + "O", ;
                        ALLTRIM(cursor_4c_ContasIdc.Grupos), ;
                        ALLTRIM(cursor_4c_ContasIdc.Iclis), ;
                        ALLTRIM(cursor_4c_ContasIdc.Rclis), ;
                        loc_cArqJpg, ;
                        loc_cArqJpg, ;
                        .F.)

                *-- Foto do cliente: Figuras (blob) tem prioridade sobre FigJpgs (memo)
                IF !ISNULL(cursor_4c_ContasIdc.Figuras)
                    SELECT cIde
                    GO BOTTOM
                    REPLACE gFotos WITH cursor_4c_ContasIdc.Figuras
                    SELECT cursor_4c_ContasIdc
                ELSE
                    IF !EMPTY(cursor_4c_ContasIdc.FigJpgs)
                        LOCAL loc_cArqFoto
                        loc_cArqFoto = loc_cDirTemp + SYS(3) + ".Jpg"
                        COPY MEMO cursor_4c_ContasIdc.FigJpgs TO (loc_cArqFoto)
                        SELECT cIde
                        GO BOTTOM
                        REPLACE cArqJpgs WITH loc_cArqFoto
                        SELECT cursor_4c_ContasIdc
                    ENDIF
                ENDIF

            ENDSCAN

            IF USED("cursor_4c_ContasIdc")
                USE IN cursor_4c_ContasIdc
            ENDIF

            SELECT cIde
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica filtros antes da impressao.
    * Equivalente as validacoes em btnReport.Click do legado SIGREIDC.
    *
    * Valida: existencia de Grupo em SigCdGcr, Conta em SigCdCli,
    * Linha entre 1-5, Coluna entre 1-2.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido, loc_cSQL, loc_nResult, loc_nExiste
        loc_lValido = .T.
        TRY
            *-- Validar Grupo (se informado, deve existir em SigCdGcr)
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr " + ;
                    "WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")
                IF loc_nResult > 0
                    SELECT cursor_4c_ValGrupo
                    loc_nExiste = IIF(!EOF(), cursor_4c_ValGrupo.nExiste, 0)
                    USE IN cursor_4c_ValGrupo
                    IF loc_nExiste = 0
                        THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido."
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar Conta (se informada, deve existir em SigCdCli)
            IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                    "WHERE Iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")
                IF loc_nResult > 0
                    SELECT cursor_4c_ValConta
                    loc_nExiste = IIF(!EOF(), cursor_4c_ValConta.nExiste, 0)
                    USE IN cursor_4c_ValConta
                    IF loc_nExiste = 0
                        THIS.this_cMensagemErro = "Conta Inv" + CHR(225) + "lida."
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar Linha inicial (1 a 5)
            IF loc_lValido AND !BETWEEN(THIS.this_nLinha, 1, 5)
                THIS.this_cMensagemErro = "Linha Inicial Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF

            *-- Validar Coluna inicial (1 a 2)
            IF loc_lValido AND !BETWEEN(THIS.this_nColuna, 1, 2)
                THIS.this_cMensagemErro = "Coluna Inicial Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.ValidarFiltros")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparArquivosTemporarios - Remove arquivos JPG temporarios de logos e
    * fotos criados em PrepararDados. Deve ser chamado pelo form apos
    * REPORT FORM (impressao ou preview).
    * Equivalente ao bloco de limpeza em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparArquivosTemporarios()
        LOCAL loc_cArqJpgs, loc_cGLogos
        TRY
            IF USED("cIde")
                SELECT cIde
                SCAN
                    loc_cArqJpgs = ALLTRIM(cIde.cArqJpgs)
                    loc_cGLogos  = ALLTRIM(cIde.gLogos)
                    IF !EMPTY(loc_cArqJpgs) AND FILE(loc_cArqJpgs)
                        DELETE FILE (loc_cArqJpgs)
                    ENDIF
                    IF !EMPTY(loc_cGLogos) AND loc_cGLogos != loc_cArqJpgs ;
                       AND FILE(loc_cGLogos)
                        DELETE FILE (loc_cGLogos)
                    ENDIF
                ENDSCAN
                USE IN cIde
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREIDCBO.LimparArquivosTemporarios")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de identifica" + CHR(231) + CHR(227) + ;
            "o de contas n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de identifica" + CHR(231) + CHR(227) + ;
            "o de contas n" + CHR(227) + "o altera registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_ContasIdc")
            USE IN cursor_4c_ContasIdc
        ENDIF
        IF USED("cursor_4c_EmpIdc")
            USE IN cursor_4c_EmpIdc
        ENDIF
        IF USED("cIde")
            USE IN cIde
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
