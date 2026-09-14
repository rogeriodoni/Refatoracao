# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, PADRAOS, CODIGOS, EMPOS, GRUPOS, CONTAS, CPROS, CUNIS, ETIQS, ESTOS, ARREDS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
If ThisForm.poDataMgr.SqlExecute([Select GrupoEsts,ContaEsts From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
If ThisForm.poDataMgr.SqlExecute([Select CEmps,Razas,Ativas,Estas From SigCdEmp ],'CrSigCdEmp') < 1
Select CrSigCdEmp
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe') < 1
Select CrSigCdMoe
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot') < 1
Select CrSigCdCot
If ThisForm.poDataMgr.SqlExecute([Select CGrus,Arreds From SigCdGrp ],'CrSigCdGrp') < 1
Select CrSigCdGrp
lStrQuery = [Select a.Emps,a.CodTabDs,b.Descrs ]+;
			[From SigOpTde a, SigOpTdz b ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpTabDe') < 1
Select TmpTabDe
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdCfi ],'CrSigCdCfi') < 1
Select CrSigCdCfi
lcNomeEmpresa = _Empr + IIf(Seek(_Empr,'CrSigCdEmp','CEmps'),' - ' + CrSigCdEmp.Razas,'')
If Seek(lcEmpresa,'CrSigCdEmp','CEmps')
Insert Into CsCabecalho (nomeempresa,titulo1,Barra);
If ThisForm.poDataMgr.SqlExecute([Select * From SigOpTdz Where Codigos = ']+lcTabela+[' ],'CsTabela') < 1
Select CsTabela
If ThisForm.poDataMgr.SqlExecute([Select * From SigOpTdt Where Codigos = ']+lcTabela+[' ],'CsTabDi') < 1
Select CsTabDi
lStrQuery = [Select '1' as Ps, a.CPros,a.CBars,b.DPros,b.PVens,b.Moevs,b.CGrus,b.Linhas,b.Colecoes,b.Cunis,b.cftios,b.Sgrus,b.sittricms,b.CodFinP, ]+;
			[From SigOpEtq a, SigCdPro b, SigCdUni c ]+;
			[Select '2' as Ps,a.CPros,b.CBars,b.DPros,b.PVens,b.Moevs,b.CGrus,b.Linhas,b.Colecoes,b.Cunis,b.cftios,b.Sgrus,b.sittricms,b.CodFinP, ]+;
			[From SigMvEst a, SigCdPro b, SigCdUni c ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsRel') < 1
Select CsRel
	loBarraEti.Update(.T.)
	If Seek(m.CGrus + lcEstas,'CrSigCdCfi','GruEstas')
	If (Seek(lcTabela + '4' + Padr(m.CPros,14)   ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '9' + Padr(m.CodFinP,10) ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '1' + Padr(m.CGrus,10)   ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '2' + Padr(m.Linhas,10)  ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '3' + Padr(m.Colecoes,10),'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '5' + Padr(m.Moevs,10)   ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '6' + Padr(m.cunis,10)   ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '7' + Padr(m.Cftios,10)  ,'CsTabDi','CodTips') Or ;
			Seek(lcTabela + '8' + Padr(m.Sgrus,10)   ,'CsTabDi','CodTips'))
	If Seek(m.CGrus,'CrSigCdGrp','CGrus') And CrSigCdGrp.Arreds <> 0
		If Not Seek(m.Cbars,'CsRelatorio','Cbars')
			Insert Into CsRelatorio From MemVar
				Select CsRelatorio
		Insert Into CsRelatorio From MemVar
	Select CsRel
Select CsRelatorio
	lStrQuery = [Select a.Emps,a.CodTabDs,b.Descrs ]+;
				[From SigOpTde a, SigOpTdz b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpTabDe') < 1
		Select TmpTabDe
	lStrQuery = [Select a.Emps,a.CodTabDs,b.Descrs ]+;
				[From SigOpTde a, SigOpTdz b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpTabDe') < 1
		Select TmpTabDe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg) - TRECHOS RELEVANTES PARA PASS SQL (934 linhas total):

*-- Linhas 666 a 684:
666: 
667:             IF loc_oBusca.this_lSelecionou
668:                 IF USED("cursor_4c_BuscaEmp")
669:                     SELECT cursor_4c_BuscaEmp
670:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
671:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmp.Razas)
672: 
673:                     loc_oPagina.txt_4c_Empresa.Value    = loc_cCodigo
674:                     loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDescricao
675: 
676:                     THIS.this_oRelatorio.this_cEmpresa    = loc_cCodigo
677:                     THIS.this_oRelatorio.this_cDesEmpresa = loc_cDescricao
678: 
679:                     THIS.this_oRelatorio.ValidarEmpresa()
680: 
681:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
682:                 ENDIF
683:             ENDIF
684: 


### BO (C:\4c\projeto\app\classes\sigreeqeBO.prg):
*==============================================================================
* SIGREEQEBO.PRG
* Business Object para Relatorio de Posicao de Etiquetas por Empresa
*
* Herda de: RelatorioBase
* Origem: SIGREEQE.SCX (frmrelatorio)
* Relatorio FRX: SigReEqe.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Agrupamento: 1=Barra / 2=Identidade
*
* Parametros internos carregados no Init():
*   this_cGrupo  - GrupoEsts de SigCdPam
*   this_cConta  - ContaEsts de SigCdPam
*   this_cTabela - CodTabDs de SigOpTde (tabela de desconto padrao da empresa)
*
* Cursores de apoio carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas, estas)
*   cursor_4c_SigCdMoe  - moedas (CMoes, ...)
*   cursor_4c_SigCdCot  - cotacoes (CMoes, Datas, ...)
*   cursor_4c_SigCdGrp  - grupos (CGrus, Arreds)
*   cursor_4c_SigCdCfi  - configuracao ICMS (Grupos, Ests, ICMs)
*
* Cursor de resultado produzido por PrepararDados():
*   CsRelatorio - CBars, DPros, Units, SitTribs, Aliqs
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, Barra
*==============================================================================

DEFINE CLASS sigreeqeBO AS RelatorioBase

    *-- Filtro de empresa (digitado pelo usuario)
    this_cEmpresa       = ""    && Codigo da empresa (GetEmpresa)
    this_cDesEmpresa    = ""    && Descricao da empresa (GetDesEmpresa)

    *-- Parametros internos carregados a partir dos cursores de apoio
    this_cGrupo         = ""    && GrupoEsts de SigCdPam (grupo de estoque)
    this_cConta         = ""    && ContaEsts de SigCdPam (conta de estoque)
    this_cTabela        = ""    && CodTabDs de SigOpTde (tabela de desconto padrao)

    *-- Opcao de agrupamento: 1=Barra, 2=Identidade
    this_nAgrupa        = 1

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de apoio e parametros do sistema
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_cGrupo      = ""
            THIS.this_cConta      = ""
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

                *-- SigCdPam: grupo e conta de estoque do sistema
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT GrupoEsts, ContaEsts FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupo = ALLTRIM(cursor_4c_SigCdPam.GrupoEsts)
                        THIS.this_cConta = ALLTRIM(cursor_4c_SigCdPam.ContaEsts)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                ENDIF

                *-- SigCdEmp: cadastro de empresas
                IF USED("cursor_4c_SigCdEmp")
                    USE IN cursor_4c_SigCdEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CEmps, Razas, Ativas, Estas FROM SigCdEmp", ;
                    "cursor_4c_SigCdEmp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cemps TAG cemps
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                ENDIF

                *-- SigCdMoe: moedas
                IF USED("cursor_4c_SigCdMoe")
                    USE IN cursor_4c_SigCdMoe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdMoe", ;
                    "cursor_4c_SigCdMoe")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdMoe
                    INDEX ON CMoes TAG CMoes
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                ENDIF

                *-- SigCdCot: cotacoes de moeda
                IF USED("cursor_4c_SigCdCot")
                    USE IN cursor_4c_SigCdCot
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdCot", ;
                    "cursor_4c_SigCdCot")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCot
                    INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                ENDIF

                *-- SigCdGrp: grupos de produto (fator de arredondamento)
                IF USED("cursor_4c_SigCdGrp")
                    USE IN cursor_4c_SigCdGrp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CGrus, Arreds FROM SigCdGrp", ;
                    "cursor_4c_SigCdGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdGrp
                    INDEX ON CGrus TAG CGrus
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdGrp"
                ENDIF

                *-- SigCdCfi: configuracao fiscal ICMS (grupos x estoque)
                IF USED("cursor_4c_SigCdCfi")
                    USE IN cursor_4c_SigCdCfi
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos, Ests, ICMs FROM SigCdCfi", ;
                    "cursor_4c_SigCdCfi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCfi
                    INDEX ON Grupos + Ests TAG GruEstas
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCfi"
                ENDIF

                *-- Empresa padrao: empresa do usuario logado
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                *-- Carregar descricao e tabela de desconto da empresa padrao
                IF !EMPTY(THIS.this_cEmpresa)
                    THIS.ValidarEmpresa()
                ENDIF

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreeqeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa e carrega descricao + tabela
    * de desconto padrao. Equivalente ao Valid de GetEmpresa/GetDesEmpresa.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_lSucesso, loc_cEmpresa, loc_cSQL, loc_nResult

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

            IF EMPTY(loc_cEmpresa)
                THIS.this_cDesEmpresa = ""
                THIS.this_cTabela     = ""
                loc_lSucesso = .T.
            ENDIF

            *-- Buscar descricao da empresa
            THIS.this_cDesEmpresa = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    THIS.this_cDesEmpresa = ALLTRIM(cursor_4c_SigCdEmp.Razas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ;
                        loc_cEmpresa
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp" + ;
                    " WHERE CEmps = " + EscaparSQL(loc_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
                IF loc_nResult >= 1
                    SELECT cursor_4c_EmpVal
                    GO TOP
                    IF !EOF()
                        THIS.this_cDesEmpresa = ALLTRIM(cursor_4c_EmpVal.Razas)
                        loc_lSucesso = .T.
                    ENDIF
                    USE IN cursor_4c_EmpVal
                ENDIF
                IF !loc_lSucesso
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ;
                        loc_cEmpresa
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Buscar tabela de desconto padrao da empresa
            THIS.this_cTabela = ""
            loc_cSQL = "SELECT a.Emps, a.CodTabDs, b.Descrs" + ;
                " FROM SigOpTde a, SigOpTdz b" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND a.Padraos = 1 AND b.Codigos = a.CodTabDs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TabDe")
            IF loc_nResult >= 1
                SELECT cursor_4c_TabDe
                GO TOP
                IF !EOF()
                    THIS.this_cTabela = ALLTRIM(cursor_4c_TabDe.CodTabDs)
                ENDIF
                USE IN cursor_4c_TabDe
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa etiquetas
    * Equivalente ao metodo processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED("CsRelatorio")
                            SELECT CsRelatorio
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar.
    * Equivalente as validacoes em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            *-- Empresa obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida"
                loc_lSucesso = .F.
            ENDIF

            *-- Tabela de desconto obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cTabela))
                THIS.this_cMensagemErro = "Empresa com Tabela de Desconto Padr" + ;
                    CHR(227) + "o N" + CHR(227) + "o Informada !!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra
        LOCAL loc_cEmpresa

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa     = ALLTRIM(THIS.this_cEmpresa)
            loc_lBarra       = (THIS.this_nAgrupa = 1)

            *-- Nome da empresa
            loc_cNomeEmpresa = loc_cEmpresa
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = loc_cEmpresa + " - " + ;
                        ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            *-- Titulo: "Posicao de Etiquetas - EMPRESA"
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas" + ;
                IIF(!EMPTY(loc_cEmpresa), " - " + ALLTRIM(loc_cEmpresa), "")

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), Barra L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, Barra) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa as queries e calcula valores das etiquetas.
    * Equivalente a PROCEDURE processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cTabela
        LOCAL loc_nAgrupa, loc_nParcs
        LOCAL loc_cFiltroGrupo, loc_cFiltroEsto

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cEstoque  = ALLTRIM(THIS.this_cConta)
            loc_cTabela   = ALLTRIM(THIS.this_cTabela)
            loc_nAgrupa   = THIS.this_nAgrupa
            loc_nParcs    = 0

            *-- Clausulas de filtro opcionais para grupo e estoque
            loc_cFiltroGrupo = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltroGrupo = " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cFiltroEsto = ""
            IF !EMPTY(loc_cEstoque)
                loc_cFiltroEsto = " AND a.Contas = " + EscaparSQL(loc_cEstoque)
            ENDIF

            *-- Fechar cursor de resultado anterior
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            *-- Criar cursor de resultado: estrutura identica ao original
            CREATE CURSOR CsRelatorio ;
                (CBars C(14), DPros C(40), Units N(12,2), SitTribs C(2), Aliqs N(6,2))

            IF loc_nAgrupa = 2
                INDEX ON CBars TAG CBars
            ENDIF

            *-- Numero de parcelas da tabela de desconto
            loc_nParcs = 0
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT NParcs FROM SigOpTdz WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDz")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDz
                    GO TOP
                    IF !EOF()
                        loc_nParcs = NVL(cursor_4c_TabDz.NParcs, 0)
                    ENDIF
                    USE IN cursor_4c_TabDz
                ENDIF
            ENDIF

            *-- Descontos por tipo (tabela SigOpTdt)
            IF USED("cursor_4c_TabDi")
                USE IN cursor_4c_TabDi
            ENDIF
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpTdt WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDi
                    INDEX ON Codigos + STR(Tipos, 1) + CodTips TAG CodTips
                    GO TOP
                ENDIF
            ENDIF

            *-- Query principal: UNION ALL etiquetas (SigOpEtq) + estoque (SigMvEst)
            loc_cSQL = "SELECT '1' AS Ps, a.CPros, a.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigOpEtq a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
                loc_cFiltroGrupo + loc_cFiltroEsto + ;
                " AND b.CPros = a.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs = 'S'" + ;
                " UNION ALL" + ;
                " SELECT '2' AS Ps, a.CPros, b.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigMvEst a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cEstoque)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Estos = " + EscaparSQL(loc_cEstoque)
            ENDIF

            loc_cSQL = loc_cSQL + ;
                " AND a.CPros = b.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs <> 'S'" + ;
                " ORDER BY 1, 3, 2, 5, 6, 7, 8"

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsRel")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar etiquetas (CsRel)"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar estado de estoque da empresa (para aliquota ICMS)
            LOCAL loc_cEstas
            loc_cEstas = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cEstas = ALLTRIM(cursor_4c_SigCdEmp.Estas)
                ENDIF
            ENDIF

            *-- Calcular preco unitario com descontos e arredondamento
            SELECT CsRel
            GO TOP
            SCAN
                SCATTER MEMO MEMVAR

                LOCAL loc_nAliqs, loc_nUnits, loc_nDescUnit, loc_nDescTab
                LOCAL loc_cCBars

                loc_nAliqs    = 0
                loc_nDescUnit = 1
                loc_nDescTab  = 1

                *-- Aliquota ICMS para o grupo + estado
                IF USED("cursor_4c_SigCdCfi")
                    SELECT cursor_4c_SigCdCfi
                    IF SEEK(m.CGrus + loc_cEstas, "cursor_4c_SigCdCfi", "GruEstas")
                        loc_nAliqs = cursor_4c_SigCdCfi.ICMs
                    ENDIF
                ENDIF

                *-- Valor unitario convertido para moeda local
                loc_nUnits = m.PVens * fCarregarCambio(m.MoeVs, DATE())

                *-- Verificar desconto na tabela por tipo (produto, finp, grupo, linha, colecao, moeda, uni, cftio, sgru)
                IF USED("cursor_4c_TabDi")
                    IF SEEK(loc_cTabela + "4" + PADR(m.CPros, 14), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "9" + PADR(m.CodFinP, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "1" + PADR(m.CGrus, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "2" + PADR(m.Linhas, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "3" + PADR(m.Colecoes, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "5" + PADR(m.Moevs, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "6" + PADR(m.Cunis, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "7" + PADR(m.Cftios, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "8" + PADR(m.Sgrus, 10), "cursor_4c_TabDi", "CodTips")
                        loc_nDescUnit = loc_nDescUnit - (cursor_4c_TabDi.Descos / 100)
                        loc_nDescTab  = IIF(cursor_4c_TabDi.TExclus = "S", 1, loc_nDescTab)
                    ENDIF
                ENDIF

                *-- Calcular preco final (com parcelas ou sem)
                IF loc_nParcs = 0
                    m.Units = ROUND(loc_nUnits * loc_nDescTab * loc_nDescUnit / 1, 2)
                ELSE
                    LOCAL loc_nPrecoParc
                    loc_nPrecoParc = CEILING(((loc_nUnits * loc_nDescTab * loc_nDescUnit) / 1) / loc_nParcs)
                    m.Units = loc_nPrecoParc * loc_nParcs
                ENDIF

                *-- Arredondamento pelo fator do grupo
                IF USED("cursor_4c_SigCdGrp")
                    SELECT cursor_4c_SigCdGrp
                    IF SEEK(m.CGrus, "cursor_4c_SigCdGrp", "CGrus") AND ;
                            cursor_4c_SigCdGrp.Arreds <> 0
                        LOCAL loc_nFatArred, loc_nSoma
                        loc_nFatArred = cursor_4c_SigCdGrp.Arreds
                        loc_nSoma     = loc_nFatArred
                        DO WHILE loc_nSoma < m.Units
                            loc_nSoma = loc_nSoma + loc_nFatArred
                        ENDDO
                        m.Units = loc_nSoma
                    ENDIF
                ENDIF

                *-- Situacao tributaria e codigo de barras (string)
                m.SitTribs = IIF(EMPTY(m.SitTricms), "00", m.SitTricms)
                loc_cCBars = STR(m.CBars, 14)

                *-- Inserir no cursor de resultado
                IF loc_nAgrupa = 2
                    *-- Identidade: deduplicar por codigo de barras, manter maior preco
                    SELECT CsRelatorio
                    IF !SEEK(loc_cCBars, "CsRelatorio", "CBars")
                        INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                            VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                    ELSE
                        IF m.Units > CsRelatorio.Units
                            GATHER MEMVAR FIELDS Units
                        ENDIF
                    ENDIF
                ELSE
                    *-- Barra: inserir todos os registros
                    SELECT CsRelatorio
                    INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                        VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                ENDIF

                SELECT CsRel

            ENDSCAN

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e envia para impressora sem prompt.
    * Equivalente a PROCEDURE documento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ImprimirDireto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "CsRel"
        loc_aCursores[2] = "CsRelatorio"
        loc_aCursores[3] = "CsCabecalho"
        loc_aCursores[4] = "cursor_4c_TabDi"
        loc_aCursores[5] = "cursor_4c_TabDz"
        loc_aCursores[6] = "cursor_4c_SigCdPam"
        loc_aCursores[7] = "cursor_4c_TabDe"
        loc_aCursores[8] = "cursor_4c_EmpVal"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdMoe")
            USE IN cursor_4c_SigCdMoe
        ENDIF
        IF USED("cursor_4c_SigCdCot")
            USE IN cursor_4c_SigCdCot
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        IF USED("cursor_4c_SigCdCfi")
            USE IN cursor_4c_SigCdCfi
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

