# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, NTIPOS, USUACESS, CIMPS, USUARIOS, GRUPOS, NTPIMPRES, LNIMPRES, I

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
  ControlSource = ""
		Select crSigCdMp
		Select crSigCdTpe
		Select crSigCdTpe
		lcSql = [Select b.* From SigSyImp a, SigCdMp b Where a.UsuAcess = ']+Usuar+[' and a.cimps = b.impres ]+;
				[Select c.* From SigCdAcG a, SigSyImp b, SigCdMp c Where a.Usuarios=']+Usuar+[' ]+;
		If ThisForm.podatamgr.sqlexecute(lcSql,'CrTmpCimp') <= 0
		Select CrTmpCimp
			Select Impres, nTpImpres From CrTmpCimp Into Cursor crSigCdMp ReadWrite
			Select crSigCdMp
			Select crSigCdMp
	Insert Into dbImpressao (Cpros, Qtds, Pedido, QtdeEtiq) Values (Padl(Alltrim(Str(I,8)),8,'0'),1,'',1)
Select dbImpressao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1029 linhas total):

*-- Linhas 560 a 592:
560: 
561:             *-- 5. INDEX em cursor_4c_Imp para scan por nTpImpres
562:             IF USED("cursor_4c_Imp")
563:                 SELECT cursor_4c_Imp
564:                 GO TOP
565:             ENDIF
566: 
567:             *-- 6. Preencher obj_4c_Opt_Tipo com tipos de etiqueta do cursor
568:             loc_oOptTipo = THIS.obj_4c_Opt_Tipo
569:             loc_lnTop    = 10
570:             loc_lnHeight = 40
571:             loc_lnI      = 1
572: 
573:             IF loc_nTipos > 0
574:                 loc_nMaxTipos = MIN(loc_nTipos, MAX(THIS.this_oBusinessObject.this_nMaxTpEtis, 5))
575:                 loc_oOptTipo.ButtonCount = loc_nMaxTipos
576:                 IF USED("cursor_4c_Tpe")
577:                     SELECT cursor_4c_Tpe
578:                     GO TOP
579:                     SCAN WHILE !EOF() AND loc_lnI <= loc_nMaxTipos
580:                         loc_oBtn           = loc_oOptTipo.Buttons(loc_lnI)
581:                         loc_oBtn.AutoSize  = .F.
582:                         loc_oBtn.Width     = 160
583:                         loc_oBtn.Caption   = "\<" + CHR(96 + loc_lnI) + ". " + ALLTRIM(cEtiquetas)
584:                         loc_oBtn.FontSize  = 8
585:                         loc_oBtn.Tag       = ALLTRIM(STR(nTipos))
586:                         loc_oBtn.Top       = loc_lnTop
587:                         loc_oBtn.BackStyle = 0
588:                         loc_oBtn.ForeColor = RGB(90, 90, 90)
589:                         loc_lnI      = loc_lnI + 1
590:                         loc_lnTop    = loc_lnTop + 20
591:                         loc_lnHeight = loc_lnHeight + 20
592:                     ENDSCAN

*-- Linhas 612 a 630:
612: 
613:             *-- 7. Construir lista de impressoras termicas instaladas (nTpImpres=2)
614:             IF loc_nPrinters > 0 AND USED("cursor_4c_Imp")
615:                 SELECT cursor_4c_Imp
616:                 GO TOP
617:                 SCAN
618:                     IF nTpImpres = 2
619:                         loc_nOk = ASCAN(loc_laPrnNames, UPPER(ALLTRIM(Impres)))
620:                         IF loc_nOk > 0 AND loc_lnImpOkCount < 100
621:                             loc_lnImpOkCount = loc_lnImpOkCount + 1
622:                             loc_laImpOk(loc_lnImpOkCount) = UPPER(ALLTRIM(Impres))
623:                         ENDIF
624:                     ENDIF
625:                 ENDSCAN
626:             ENDIF
627: 
628:             *-- 8. Preencher obj_4c_Opt_Impressora dinamicamente
629:             loc_oOptImp  = THIS.obj_4c_Opt_Impressora
630:             loc_lnTop    = 10

*-- Linhas 845 a 870:
845:         loc_lCarregouBD = .F.
846: 
847:         TRY
848:             loc_cSQL = "SELECT TOP 1 nTpImpres, AjVerts, AjHorzs " + ;
849:                        "FROM SigCdMp " + ;
850:                        "WHERE UPPER(RTRIM(Impres)) = " + ;
851:                        EscaparSQL(UPPER(ALLTRIM(par_cNomeImpressora)))
852: 
853:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpConfig") > 0
854:                 IF USED("cursor_4c_ImpConfig") AND !EOF("cursor_4c_ImpConfig")
855:                     SELECT cursor_4c_ImpConfig
856:                     GO TOP
857:                     loc_nOpcao   = NVL(nTpImpres, 1)
858:                     loc_nAjVerts = NVL(AjVerts, THIS.this_oBusinessObject.this_nAjVerts)
859:                     loc_nAjHorzs = NVL(AjHorzs, THIS.this_oBusinessObject.this_nAjHorzs)
860:                     loc_lCarregouBD = .T.
861:                 ENDIF
862:                 IF USED("cursor_4c_ImpConfig")
863:                     USE IN cursor_4c_ImpConfig
864:                 ENDIF
865:             ENDIF
866:         CATCH TO loc_oErro
867:             *-- Coluna pode nao existir em SigCdMp desta versao; usa padrao
868:         ENDTRY
869: 
870:         *-- Aplica valores: BD se carregou, senao padrao de SigCdPam


### BO (C:\4c\projeto\app\classes\sigprenvBO.prg):
*==============================================================================
* sigprenvBO.prg - Business Object para Impressao de Etiquetas de Envelopes
* Herda de: BusinessBase
* Form original: SIGPRENV.SCX
* Tipo: OPERACIONAL (sem entidade CRUD - impressao de etiquetas)
*==============================================================================
DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Dados da sessao de impressao
    this_nEtqIni       = 0    && Etiqueta Inicial (Etq_Ini)
    this_nEtqQtd       = 0    && Quantidade de etiquetas (Etq_Qtd)

    *-- Tipo de etiqueta selecionado (Opt_Tipo)
    this_nTipoEtq      = 6    && nTipos do SigCdTpe (6 = Envelope)
    this_cDescTipoEtq  = ""   && cEtiquetas do SigCdTpe

    *-- Impressora selecionada (Opt_Impressora)
    this_cNomeImpressora = ""  && Tag do botao = nome da impressora (UPPER)
    this_nTpImpressora   = 0   && nTpImpres do SigCdMp

    *-- Opcao de protocolo de impressao (Opcao_Imp: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nOpcaoImp     = 1

    *-- Ajustes de impressao (de SigCdPam e SigCdPac)
    this_nAjVerts      = 0
    this_nAjHorzs      = 0
    this_nAjDenss      = 10
    this_nAjVelos      = 1

    *-- Parametros gerais carregados de SigCdPam
    this_nMaxTpEtis    = 5    && nMaxTpEtis - maximo de tipos de etiqueta exibidos
    this_nMaxImpEti    = 5    && nMaxImpEti - maximo de impressoras exibidas
    this_nImpEtis      = 1    && ImpEtis - impressora padrao
    this_cTpCBars      = ""   && TpCBars - tipo codigo de barras

    *-- Campos da etiqueta individual (cursor_4c_Impressao)
    this_cCpros        = ""   && Codigo da etiqueta (Cpros)
    this_cDPros        = ""   && Descricao do produto (DPros)
    this_nQtds         = 0    && Quantidade (Qtds)
    this_nQtdeEtiq     = 0    && Quantidade de etiquetas (QtdeEtiq)
    this_cPedido       = ""   && Numero do pedido (Pedido)
    this_cObs          = ""   && Observacao (Obs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPam e SigCdPac (ajustes e parametros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "AjVerts, AjHorzs, TpCBars FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    GO TOP
                    this_nMaxTpEtis = NVL(nMaxTpEtis, 5)
                    this_nMaxImpEti = NVL(nMaxImpEti, 5)
                    this_nImpEtis   = NVL(ImpEtis, 1)
                    this_nAjVerts   = NVL(AjVerts, 0)
                    this_nAjHorzs   = NVL(AjHorzs, 0)
                    this_cTpCBars   = ALLTRIM(NVL(TpCBars, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    GO TOP
                    this_nAjDenss = IIF(NVL(AjDens, 0) < 10, 10, NVL(AjDens, 0))
                    this_nAjVelos = IIF(EMPTY(NVL(AjVelos, 0)), 1, NVL(AjVelos, 0))
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta de SigCdTpe (nTipos=6)
    * Retorna: numero de tipos encontrados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_cSQL, loc_nTipos, loc_oErro
        loc_nTipos = 0

        TRY
            IF USED("cursor_4c_Tpe")
                USE IN cursor_4c_Tpe
            ENDIF

            loc_cSQL = "SELECT cOrdems, cEtiquetas, nTipos, nSituas " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE nSituas = 1 AND nTipos = 6 " + ;
                       "ORDER BY cOrdems"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tpe") > 0
                IF USED("cursor_4c_Tpe")
                    SELECT cursor_4c_Tpe
                    GO TOP
                    loc_nTipos = RECCOUNT("cursor_4c_Tpe")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras autorizadas do usuario em SigCdMp
    * par_cUsuario: codigo do usuario logado
    * Retorna: numero de impressoras encontradas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras(par_cUsuario)
        LOCAL loc_cSQL, loc_nImpres, loc_oErro
        loc_nImpres = 0

        TRY
            IF USED("cursor_4c_Imp")
                USE IN cursor_4c_Imp
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT b.Impres, b.nTpImpres FROM SigSyImp a " + ;
                       "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
                       "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
                       "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
                       "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;
                       "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND RECCOUNT("cursor_4c_ImpTemp") > 0
                    SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_Imp READWRITE
                ELSE
                    loc_cSQL = "SELECT Impres, nTpImpres FROM SigCdMp"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Imp")
                ENDIF

                IF USED("cursor_4c_ImpTemp")
                    USE IN cursor_4c_ImpTemp
                ENDIF

                IF USED("cursor_4c_Imp")
                    SELECT cursor_4c_Imp
                    GO TOP
                    loc_nImpres = RECCOUNT("cursor_4c_Imp")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nImpres
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Monta o cursor de itens a imprimir (dbImpressao)
    * par_nEtqIni: numero da etiqueta inicial
    * par_nEtqQtd: quantidade de etiquetas
    *--------------------------------------------------------------------------
    PROCEDURE PrepararImpressao(par_nEtqIni, par_nEtqQtd)
        LOCAL loc_nI, loc_cCpros, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Impressao")
                SELECT cursor_4c_Impressao
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Impressao ;
                    (Cpros C(10) NULL, DPros C(40) NULL, Qtds N(10,3) NULL, ;
                     QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL)
                SET NULL OFF
                INDEX ON Cpros TAG Cpros
                SET ORDER TO
            ENDIF

            FOR loc_nI = par_nEtqIni TO par_nEtqIni + (par_nEtqQtd - 1)
                loc_cCpros = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                INSERT INTO cursor_4c_Impressao ;
                    (Cpros, Qtds, Pedido, QtdeEtiq) ;
                    VALUES (loc_cCpros, 1, "", 1)
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparImpressao - Limpa o cursor de impressao apos concluir
    *--------------------------------------------------------------------------
    PROCEDURE LimparImpressao()
        IF USED("cursor_4c_Impressao")
            SELECT cursor_4c_Impressao
            ZAP
            APPEND BLANK
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorImpressao - Cria cursor vazio de impressao no Init do form
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorImpressao()
        IF USED("cursor_4c_Impressao")
            USE IN cursor_4c_Impressao
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Impressao ;
            (Cpros C(10) NULL, DPros C(40) NULL, Qtds N(10,3) NULL, ;
             QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL)
        SET NULL OFF
        INDEX ON Cpros TAG Cpros
        SET ORDER TO
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor_4c_Impressao
    * par_cAliasCursor: alias do cursor origem
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            this_cDPros    = ALLTRIM(NVL(DPros,    ""))
            this_nQtds     = NVL(Qtds,    0)
            this_nQtdeEtiq = NVL(QtdeEtiq, 0)
            this_cPedido   = ALLTRIM(NVL(Pedido,  ""))
            this_cObs      = ALLTRIM(NVL(Obs,     ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria da etiqueta corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere etiqueta no cursor_4c_Impressao local
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Impressao")
                THIS.InicializarCursorImpressao()
            ENDIF

            SELECT cursor_4c_Impressao
            INSERT INTO cursor_4c_Impressao ;
                (Cpros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ;
                VALUES (this_cCpros, this_cDPros, this_nQtds, ;
                        this_nQtdeEtiq, this_cPedido, this_cObs)

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza etiqueta existente no cursor_4c_Impressao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Impressao")
                SELECT cursor_4c_Impressao
                SET ORDER TO TAG Cpros
                IF SEEK(this_cCpros, "cursor_4c_Impressao", "Cpros")
                    REPLACE Qtds     WITH this_nQtds, ;
                            QtdeEtiq WITH this_nQtdeEtiq, ;
                            DPros    WITH this_cDPros, ;
                            Pedido   WITH this_cPedido, ;
                            Obs      WITH this_cObs
                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de impressao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(this_cCpros) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe a operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Tpe")
            USE IN cursor_4c_Tpe
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpTemp")
            USE IN cursor_4c_ImpTemp
        ENDIF
        IF USED("cursor_4c_Impressao")
            USE IN cursor_4c_Impressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

