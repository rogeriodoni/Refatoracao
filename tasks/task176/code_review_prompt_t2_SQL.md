# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_IMPACESSIVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, NTIPOS, USUACESS, CIMPS, USUARIOS, GRUPOS, NTPIMPRES, LNIMPRES, I
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1244 linhas total):

*-- Linhas 592 a 610:
592:                 THIS.obj_4c_Opt_Tipo.ButtonCount = ;
593:                     MIN(loc_nTipos, MAX(THIS.this_oBusinessObject.this_nMaxTpEtis, 5))
594: 
595:                 SELECT cursor_4c_SigCdTpe
596:                 GO TOP
597:                 loc_nI = 1
598:                 SCAN WHILE loc_nI <= THIS.obj_4c_Opt_Tipo.ButtonCount
599:                     loc_cCaption = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(cursor_4c_SigCdTpe.cetiquetas)
600:                     loc_cTag     = ALLTRIM(STR(cursor_4c_SigCdTpe.ntipos))
601:                     WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
602:                         .AutoSize  = .F.
603:                         .Left      = 10
604:                         .Top       = loc_nTop
605:                         .Width     = 160
606:                         .Caption   = loc_cCaption
607:                         .FontSize  = 8
608:                         .FontName  = "Tahoma"
609:                         .Tag       = loc_cTag
610:                         .BackStyle = 0

*-- Linhas 649 a 673:
649:             loc_nPrinters = APRINTERS(loc_laPrinters)
650: 
651:             *-- Identificar impressoras validas (tipo 2 + instaladas no sistema)
652:             loc_nImpres = 0
653: 
654:             IF USED("cursor_4c_ImpAcessiveis") AND !EOF("cursor_4c_ImpAcessiveis")
655:                 SELECT cursor_4c_ImpAcessiveis
656:                 GO TOP
657:                 SCAN FOR cursor_4c_ImpAcessiveis.ntpimpres = 2
658:                     loc_cImpres = cursor_4c_ImpAcessiveis.impres
659:                     IF loc_nPrinters > 0
660:                         loc_nOk = 0
661:                         FOR loc_nPIdx = 1 TO loc_nPrinters
662:                             IF UPPER(ALLTRIM(loc_laPrinters(loc_nPIdx, 1))) == ;
663:                                UPPER(ALLTRIM(loc_cImpres))
664:                                 loc_nOk = loc_nPIdx
665:                                 EXIT
666:                             ENDIF
667:                         ENDFOR
668:                         IF loc_nOk > 0
669:                             loc_nImpres = loc_nImpres + 1
670:                             DIMENSION loc_laImpOk(loc_nImpres)
671:                             loc_laImpOk(loc_nImpres) = loc_laPrinters(loc_nOk, 1)
672:                         ENDIF
673:                     ENDIF

*-- Linhas 1218 a 1239:
1218:             THIS.this_oBusinessObject = .NULL.
1219:         ENDIF
1220:         IF USED("cursor_4c_SigCdTpe")
1221:             USE IN cursor_4c_SigCdTpe
1222:         ENDIF
1223:         IF USED("cursor_4c_ImpAcessiveis")
1224:             USE IN cursor_4c_ImpAcessiveis
1225:         ENDIF
1226:         IF USED("cursor_4c_ImpTemp")
1227:             USE IN cursor_4c_ImpTemp
1228:         ENDIF
1229:         IF USED("cursor_4c_ConfigImp")
1230:             USE IN cursor_4c_ConfigImp
1231:         ENDIF
1232:         IF USED("cursor_4c_SigCdPam")
1233:             USE IN cursor_4c_SigCdPam
1234:         ENDIF
1235:         IF USED("cursor_4c_SigCdPac")
1236:             USE IN cursor_4c_SigCdPac
1237:         ENDIF
1238:         IF USED("dbImpressao")
1239:             USE IN dbImpressao


### BO (C:\4c\projeto\app\classes\sigprenvBO.prg):
*==============================================================================
* sigprenvBO.prg
* Business Object - Impressao de Etiquetas de Envelopes
* Tipo: OPERACIONAL
* Migrado de: sigprenv.SCX
*==============================================================================

DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Campos de entrada do usuario
    this_nEtqIni           = 1     && Etiqueta Inicial
    this_nEtqQtd           = 0     && Quantidade de etiquetas

    *-- Selecao de tipo de etiqueta (Opt_Tipo)
    this_nTipoEtq          = 1     && Value do OptionGroup de tipo
    this_cTagTipoEtq       = ""    && Tag da opcao selecionada (nTipos como string)

    *-- Selecao de impressora (Opt_Impressora)
    this_nImpressora       = 1     && Value do OptionGroup de impressora
    this_cNomeImpressora   = ""    && Tag/nome da impressora selecionada

    *-- Configuracoes de impressao (Cnt_Impressora)
    this_nTpImp            = 1     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts          = 0     && Ajuste Vertical (Spn_AjVerts)
    this_nAjHorzs          = 0     && Ajuste Horizontal (Spn_AjHorzs)
    this_nAjDenss          = 10    && Ajuste Densidade (Spn_AjDenss)
    this_nAjVelos          = 3     && Ajuste Velocidade (spn_AjVelos)

    *-- Flags de estado
    this_lImpressorasOk    = .F.   && .T. se ha impressoras disponiveis
    this_lTiposOk          = .F.   && .T. se ha tipos de etiqueta configurados
    this_nTotalTipos       = 0     && Total de tipos de etiqueta disponiveis
    this_nTotalImpressoras = 0     && Total de impressoras disponiveis

    *-- Configuracoes lidas de SigCdPam/SigCdPac
    this_nMaxTpEtis        = 5     && Maximo de tipos de etiqueta (SigCdPam.nMaxTpEtis)
    this_nMaxImpEti        = 5     && Maximo de impressoras para etiqueta (SigCdPam.nMaxImpEti)
    this_nImpEtis          = 1     && Tipo de impressao padrao (SigCdPam.ImpEtis)
    this_nAjVertsPad       = 0     && Ajuste vertical padrao (SigCdPam.AjVerts)
    this_nAjHorzsPad       = 0     && Ajuste horizontal padrao (SigCdPam.AjHorzs)
    this_nAjDensPad        = 10    && Ajuste densidade padrao (SigCdPac.AjDens)
    this_nAjVelosPad       = 1     && Ajuste velocidade padrao (SigCdPac.AjVelos)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO; form operacional sem tabela/chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia configuracoes de SigCdPam para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
            THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
            THIS.this_nImpEtis    = NVL(impetis, 1)
            THIS.this_nAjVertsPad = NVL(ajverts, 0)
            THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac, popula propriedades this_
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT TOP 1 nmaxtpetis, nmaximpeti, impetis, ajverts, ajhorzs, " + ;
                       "tpetipads, tpcbars FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
                    THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
                    THIS.this_nImpEtis    = NVL(impetis, 1)
                    THIS.this_nAjVertsPad = NVL(ajverts, 0)
                    THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigCdPac")
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_cSQL = "SELECT TOP 1 ajdens, ajvelos FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDensPad  = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelosPad = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta (ntipos=6, nsituas=1)
    * Cria cursor_4c_SigCdTpe ordenado por cordems
    * Retorna .T. se sucesso (mesmo sem registros)
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdTpe")
                USE IN cursor_4c_SigCdTpe
            ENDIF

            loc_cSQL = "SELECT cetiquetas, ntipos, nsituas, cordems " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE ntipos = 6 AND nsituas = 1 " + ;
                       "ORDER BY cordems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe") > 0
                SELECT cursor_4c_SigCdTpe
                THIS.this_lTiposOk     = !EOF()
                THIS.this_nTotalTipos  = _TALLY
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras acessiveis pelo usuario logado
    * Cria cursor_4c_ImpAcessiveis com colunas impres, ntpimpres
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            IF USED("cursor_4c_ImpAcessiveis")
                USE IN cursor_4c_ImpAcessiveis
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
                       "FROM SIGSYIMP a " + ;
                       "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
                       "WHERE a.usuacess = " + loc_cUsuario + ;
                       " UNION " + ;
                       "SELECT DISTINCT c.impres, c.ntpimpres " + ;
                       "FROM sigcdacg a " + ;
                       "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
                       "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
                       "WHERE a.usuarios = " + loc_cUsuario

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND !EOF("cursor_4c_ImpTemp")
                    SELECT impres, ntpimpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_ImpAcessiveis READWRITE
                    SELECT cursor_4c_ImpAcessiveis
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                    THIS.this_lImpressorasOk     = !EOF()
                    THIS.this_nTotalImpressoras  = _TALLY
                ELSE
                    THIS.this_lImpressorasOk    = .F.
                    THIS.this_nTotalImpressoras = 0
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfigImpressora - Carrega ajustes de uma impressora especifica
    * Substitui fCarregarImps do Framework legado
    * Popula this_nTpImp, this_nAjVerts, this_nAjHorzs, this_nAjDenss, this_nAjVelos
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfigImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cNome
        loc_lSucesso = .F.
        TRY
            loc_cNome = EscaparSQL(UPPER(ALLTRIM(par_cNomeImpressora)))

            IF USED("cursor_4c_ConfigImp")
                USE IN cursor_4c_ConfigImp
            ENDIF

            loc_cSQL = "SELECT TOP 1 impetis, ajverts, ajhorzs, ajdens, ajvelos " + ;
                       "FROM SIGCDMP " + ;
                       "WHERE UPPER(RTRIM(impres)) = " + loc_cNome

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigImp") > 0
                IF USED("cursor_4c_ConfigImp") AND !EOF("cursor_4c_ConfigImp")
                    SELECT cursor_4c_ConfigImp
                    THIS.this_nTpImp   = NVL(impetis, THIS.this_nImpEtis)
                    THIS.this_nAjVerts = NVL(ajverts, THIS.this_nAjVertsPad)
                    THIS.this_nAjHorzs = NVL(ajhorzs, THIS.this_nAjHorzsPad)
                    THIS.this_nAjDenss = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelos = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ELSE
                    *-- Impressora sem config especifica: usar valores padrao
                    THIS.this_nTpImp   = THIS.this_nImpEtis
                    THIS.this_nAjVerts = THIS.this_nAjVertsPad
                    THIS.this_nAjHorzs = THIS.this_nAjHorzsPad
                    THIS.this_nAjDenss = THIS.this_nAjDensPad
                    THIS.this_nAjVelos = THIS.this_nAjVelosPad
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar config da impressora")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursorImpressao - Cria/limpa dbImpressao e insere registros
    * par_nIni - numero inicial da etiqueta
    * par_nQtd - quantidade de etiquetas
    * Retorna .T. se sucesso; cursor dbImpressao fica disponivel para SigOpEtq
    *--------------------------------------------------------------------------
    FUNCTION PrepararCursorImpressao(par_nIni, par_nQtd)
        LOCAL loc_lSucesso, loc_oErro, loc_nI, loc_nFim, loc_cCpro
        loc_lSucesso = .F.
        TRY
            IF par_nQtd <= 0
                MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
            ELSE
                IF USED("dbImpressao")
                    SELECT dbImpressao
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR dbImpressao ;
                        (Cpros C(10), DPros C(40) NULL, Qtds N(10,3), ;
                         QtdeEtiq N(10,3), Pedido C(30) NULL, Obs C(10) NULL)
                    SET NULL OFF
                    INDEX ON Cpros TAG Cpros
                    SET ORDER TO
                ENDIF

                loc_nFim = par_nIni + par_nQtd - 1
                FOR loc_nI = par_nIni TO loc_nFim
                    loc_cCpro = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                    INSERT INTO dbImpressao (Cpros, Qtds, Pedido, QtdeEtiq) ;
                        VALUES (loc_cCpro, 1, "", 1)
                ENDFOR

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar cursor de impress" + CHR(227) + "o")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursorImpressao - Limpa dbImpressao apos impressao concluida
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorImpressao()
        IF USED("dbImpressao")
            SELECT dbImpressao
            ZAP
        ENDIF
    ENDPROC

ENDDEFINE

