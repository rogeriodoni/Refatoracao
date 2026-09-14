# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CGRUS, MERCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CGRUS, MERCS

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
  DeleteMark = .F.
	.Column1.ControlSource = 'xOpe.Cgrus'
	.Column2.ControlSource = 'xOpe.Dgrus'
lcSql = [Select a.*, b.Dgrus From SigOpGpo a, SigCdGrp b Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.Cgrus = b.Cgrus ]
ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
Select CsSelecao
	Select xOpe
Select xOpe
Insert Into xOpe (Cgrus) Values ( Space(20))
Select xOpe
Select xOpe
	Select xOpe
	Delete 
	Select Cgrus, Sum(1) as Qt From xOpe Group by 1 Into Cursor Selecao where cgrus <> ' ' having Sum(1) > 1
	Select CrSigOpGpo
	Select xOpe
			Insert Into crSigOpGpo (Dopes, Cgrus, cIdChaves) ;
		lcSql = [Delete From SigOpGpo Where dopes = ']+CrSigCdOpe.dopes+[']
		m.lnErro1 = ( .PodataMgr.SqlExecute(lcSql,'') )
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpGpo'),1,-1)
Select xOpe
lcQuery = [Select CGrus, DGrus ] + ;
		    [From SigCdGrp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
	Delete From xOpe Where Empty(CGrus)
Select LocalGru
	Select xOpe
		Insert Into xOpe(CGrus, DGrus) Values (LocalGru.CGrus, LocalGru.DGrus)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormGrupo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1005 linhas total):

*-- Linhas 239 a 290:
239:                 .ColumnCount  = 2
240:                 .RecordSource = "cursor_4c_Ope"
241:                 .RecordMark   = .F.
242:                 .DeleteMark   = .F.
243:                 .RowHeight    = 16
244:                 .ScrollBars   = 2
245:                 .FontName     = "Tahoma"
246:                 .FontSize     = 8
247:                 .ForeColor    = RGB(90,90,90)
248:                 .GridLineColor      = RGB(238,238,238)
249:                 .HighlightBackColor = RGB(255,255,255)
250:                 .HighlightForeColor = RGB(15,41,104)
251:                 .HighlightStyle     = 2
252: 
253:                 WITH .Column1
254:                     .ControlSource = "cursor_4c_Ope.Cgrus"
255:                     .Width         = 50
256:                     .Movable       = .F.
257:                     .Resizable     = .F.
258:                     .FontName      = "Tahoma"
259:                     .FontSize      = 8
260:                     .ForeColor     = RGB(90,90,90)
261:                     .Header1.Caption   = "Grupo"
262:                     .Header1.FontName  = "Tahoma"
263:                     .Header1.FontSize  = 8
264:                     .Header1.Alignment = 2
265:                     .Header1.ForeColor = RGB(36,84,155)
266:                     WITH .Text1
267:                         .BorderStyle = 0
268:                         .Margin      = 0
269:                         .ForeColor   = RGB(90,90,90)
270:                         .BackColor   = RGB(255,255,255)
271:                     ENDWITH
272:                 ENDWITH
273: 
274:                 WITH .Column2
275:                     .ControlSource = "cursor_4c_Ope.Dgrus"
276:                     .Width         = 180
277:                     .Movable       = .F.
278:                     .Resizable     = .F.
279:                     .ReadOnly      = .T.
280:                     .FontName      = "Tahoma"
281:                     .FontSize      = 8
282:                     .ForeColor     = RGB(90,90,90)
283:                     .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
284:                     .Header1.FontName  = "Tahoma"
285:                     .Header1.FontSize  = 8
286:                     .Header1.Alignment = 2
287:                     .Header1.ForeColor = RGB(36,84,155)
288:                     WITH .Text1
289:                         .BorderStyle = 0
290:                         .Margin      = 0

*-- Linhas 474 a 492:
474:             THIS.this_oBusinessObject.this_lGravaDados = .T.
475: 
476:             *-- Posiciona no primeiro registro para edicao
477:             SELECT cursor_4c_Ope
478:             GO TOP IN cursor_4c_Ope
479:             THIS.grd_4c_Dados.Refresh()
480:             THIS.grd_4c_Dados.SetFocus
481:             THIS.grd_4c_Dados.Column1.SetFocus
482: 
483:         CATCH TO loc_oErro
484:             MsgErro(loc_oErro.Message + CHR(13) + ;
485:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
486:                     "Procedure: " + loc_oErro.Procedure, ;
487:                     "Erro em BtnAlterarClick")
488:         ENDTRY
489:     ENDPROC
490: 
491:     *==========================================================================
492:     * BtnVisualizarClick - Ativa modo somente-leitura dos grupos carregados

*-- Linhas 508 a 526:
508:             THIS.grd_4c_Dados.Column1.ReadOnly = .T.
509:             THIS.txt_4c_GdeGrps.Enabled        = .F.
510: 
511:             SELECT cursor_4c_Ope
512:             GO TOP IN cursor_4c_Ope
513:             THIS.grd_4c_Dados.Refresh()
514:             THIS.grd_4c_Dados.SetFocus
515: 
516:         CATCH TO loc_oErro
517:             MsgErro(loc_oErro.Message + CHR(13) + ;
518:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
519:                     "Procedure: " + loc_oErro.Procedure, ;
520:                     "Erro em BtnVisualizarClick")
521:         ENDTRY
522:     ENDPROC
523: 
524:     *==========================================================================
525:     * BtnConfirmarClick - Valida duplicatas e salva no SQL Server, entao fecha
526:     * Replicado de cmdSair.Click do legado

*-- Linhas 760 a 780:
760:                 RETURN
761:             ENDIF
762: 
763:             loc_cSQL = "SELECT TOP 1 Codigos, Descs FROM SigCdGpr " + ;
764:                        "WHERE Codigos = " + EscaparSQL(loc_cCodigo)
765:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGde")
766: 
767:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaGde") > 0
768:                 IF USED("cursor_4c_BuscaGde")
769:                     USE IN cursor_4c_BuscaGde
770:                 ENDIF
771:                 RETURN
772:             ENDIF
773: 
774:             IF USED("cursor_4c_BuscaGde")
775:                 USE IN cursor_4c_BuscaGde
776:             ENDIF
777: 
778:             THIS.AbrirBuscaGdeGrps()
779: 
780:         CATCH TO loc_oErro

*-- Linhas 919 a 937:
919:         THIS.this_oBusinessObject.this_cGdeGrps     = ""
920:         THIS.this_oBusinessObject.this_lGravaDados  = .F.
921:         IF USED("cursor_4c_Ope")
922:             SELECT cursor_4c_Ope
923:             ZAP
924:             THIS.grd_4c_Dados.Refresh()
925:         ENDIF
926:     ENDPROC
927: 
928:     *==========================================================================
929:     * AjustarBotoesPorModo - Habilita/desabilita controles conforme modo do pai
930:     * Replica logica When do legado: InList(ParentForm.pcEscolha, INSERIR, ALTERAR)
931:     *==========================================================================
932:     PROCEDURE AjustarBotoesPorModo()
933:         LOCAL loc_lHabilitado
934: 
935:         loc_lHabilitado = .T.
936: 
937:         IF VARTYPE(THIS.this_oParentForm) = "O" AND ;


### BO (C:\4c\projeto\app\classes\GrupoBO.prg):
*==============================================================================
* GrupoBO.prg - Business Object para Grupos de Produto por Operacao
* Tabela principal : SigOpGpo (cgrus, cidchaves, dopes)
* Tabela referencia: SigCdGrp (cgrus, dgrus, mercs)
* Grande Grupo     : SigCdGpr (codigos, descs)
*==============================================================================
DEFINE CLASS GrupoBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpGpo"
    this_cCampoChave = "cidchaves"

    *-- Codigo da operacao corrente (vem do form pai via crSigCdOpe.Dopes)
    this_cDopes      = ""

    *-- Filtro de grande grupo (SigCdGpr.codigos char(3))
    this_cGdeGrps    = ""

    *-- Flag de gravacao (alteracoes nao salvas no grid)
    this_lGravaDados = .F.

    *-- Nomes dos cursores de trabalho
    this_cCursorOpe      = "cursor_4c_Ope"         && grid de edicao local
    this_cCursorSigOpGpo = "cursor_4c_SigOpGpo"    && cursor persistente (poDataMgr)

    *-- Propriedades para operacoes CRUD unitarias (linha unica de SigOpGpo)
    this_cCgrus      = ""    && SigOpGpo.Cgrus char(3)
    this_cIdChaves   = ""    && SigOpGpo.cIdChaves char(30) (PK gerada por SYS(2015))

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDFUNC

    *==========================================================================
    * InicializarDados - Cria cursor local e carrega dados existentes do SQL Server
    * par_cDopes: codigo da operacao (ex: crSigCdOpe.Dopes do form pai)
    *==========================================================================
    PROCEDURE InicializarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cDopes = ALLTRIM(par_cDopes)

        TRY
            SET NULL ON
            CREATE CURSOR cursor_4c_Ope (Dopes C(20) NULL, Cgrus C(3) NULL, Dgrus C(30) NULL)
            SET NULL OFF
            INDEX ON Cgrus TAG Cgrus
            SET ORDER TO

            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM SigOpGpo a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTemp") > 0
                SELECT cursor_4c_Ope
                ZAP
                APPEND FROM DBF("cursor_4c_OpeTemp")
                USE IN cursor_4c_OpeTemp
            ENDIF

            SELECT cursor_4c_Ope
            SET ORDER TO
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaGrid - Insere linha em branco no cursor local de trabalho
    *==========================================================================
    PROCEDURE InserirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope")
                INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                    VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                SELECT cursor_4c_Ope
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaGrid - Exclui a linha corrente do cursor local
    *==========================================================================
    PROCEDURE ExcluirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                SELECT cursor_4c_Ope
                DELETE
                SKIP
                IF EOF("cursor_4c_Ope")
                    GO BOTTOM
                ENDIF
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida Cgrus em SigCdGrp e atualiza Dgrus no cursor local
    * par_cCgrus: codigo digitado
    * RETORNO: .T. se encontrado (Dgrus preenchido), .F. se nao encontrado
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cCgrus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal") > 0
                IF !EOF("cursor_4c_GrpVal")
                    IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                        REPLACE Cgrus WITH ALLTRIM(cursor_4c_GrpVal.Cgrus) IN cursor_4c_Ope
                        REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrpVal.Dgrus) IN cursor_4c_Ope
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_GrpVal
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGrandeGrupo - Valida codigo em SigCdGpr e armazena em this_cGdeGrps
    * par_cCodigos: codigo digitado em txt_4c_GdeGrps
    * RETORNO: .T. se encontrado, .F. caso contrario
    *==========================================================================
    PROCEDURE ValidarGrandeGrupo(par_cCodigos)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Descs FROM SigCdGpr " + ;
                       "WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigos))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GprVal") > 0
                IF !EOF("cursor_4c_GprVal")
                    THIS.this_cGdeGrps = ALLTRIM(cursor_4c_GprVal.Codigos)
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_GprVal
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarGrandeGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarGrandeGrupo - Carrega grupos de SigCdGrp onde Mercs = par_cGdeGrps
    * par_cGdeGrps: codigo do grande grupo (SigCdGpr.Codigos)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarGrandeGrupo(par_cGdeGrps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cGdeGrps))
            MsgAviso("Preencha o Grande Grupo Antes de Processar!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cGdeGrps  = par_cGdeGrps
            THIS.this_lGravaDados = .T.

            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Mercs = " + EscaparSQL(ALLTRIM(par_cGdeGrps))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru") < 1
                MsgErro("Falha ao carregar grupos do grande grupo.", "Erro")
            ELSE
                *-- Remover linhas em branco existentes
                IF !EOF("cursor_4c_LocalGru")
                    DELETE FROM cursor_4c_Ope WHERE EMPTY(ALLTRIM(Cgrus))
                ENDIF

                *-- Adicionar grupos ausentes no cursor local
                SELECT cursor_4c_LocalGru
                SCAN
                    SELECT cursor_4c_Ope
                    GO TOP
                    LOCATE FOR ALLTRIM(Cgrus) == ALLTRIM(cursor_4c_LocalGru.Cgrus)
                    IF EOF("cursor_4c_Ope")
                        INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                            VALUES (THIS.this_cDopes, ;
                                    ALLTRIM(cursor_4c_LocalGru.Cgrus), ;
                                    ALLTRIM(cursor_4c_LocalGru.Dgrus))
                    ENDIF
                ENDSCAN

                *-- Linha em branco ao final para entrada manual
                IF !EOF("cursor_4c_LocalGru")
                    INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                        VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                ENDIF

                IF USED("cursor_4c_LocalGru")
                    USE IN cursor_4c_LocalGru
                ENDIF

                SELECT cursor_4c_Ope
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrandeGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica grupos duplicados no cursor local
    * RETORNO: .T. se valido (sem duplicatas), .F. se ha duplicatas
    *==========================================================================
    PROTECTED FUNCTION ValidarDuplicidade()
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .T.

        TRY
            SELECT Cgrus, SUM(1) AS nQt ;
                FROM cursor_4c_Ope ;
                WHERE !EMPTY(ALLTRIM(Cgrus)) ;
                GROUP BY Cgrus ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            IF RECCOUNT("cursor_4c_DupCheck") > 0
                MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", ;
                         "Duplicidade")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Confirmar - Salva todas as alteracoes no SQL Server
    * DELETE + INSERT por operacao (padrao do legado SigOpGpo)
    * RETORNO: .T. se gravado com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Confirmar()
        LOCAL loc_lSucesso, loc_lErroInserir, loc_cSQL, loc_cIdChave, loc_oErro

        loc_lSucesso   = .F.
        loc_lErroInserir = .F.

        TRY
            IF THIS.ValidarDuplicidade()
                loc_cSQL = "DELETE FROM SigOpGpo WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult") < 1
                    MsgErro("Erro ao excluir registros anteriores da opera" + CHR(231) + CHR(227) + "o.", "Erro")
                ELSE
                    IF USED("cursor_4c_DelResult")
                        USE IN cursor_4c_DelResult
                    ENDIF

                    SELECT cursor_4c_Ope
                    SCAN FOR !EMPTY(ALLTRIM(Cgrus))
                        loc_cIdChave = SYS(2015)
                        loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(THIS.this_cDopes) + ", " + ;
                                   EscaparSQL(ALLTRIM(Cgrus)) + ", " + ;
                                   EscaparSQL(loc_cIdChave) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult") < 1
                            MsgErro("Erro ao inserir grupo " + ALLTRIM(Cgrus) + ".", "Erro")
                            loc_lErroInserir = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF
                    ENDSCAN

                    IF !loc_lErroInserir
                        THIS.this_lGravaDados = .F.
                        THIS.RegistrarAuditoria("ATUALIZAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia colunas de um cursor (crSigCdOpe do form pai ou
    * cursor local do grid) para as propriedades this_c* do BO
    * par_cAliasCursor: nome do cursor origem (default: cursor_4c_Ope)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorOpe, par_cAliasCursor)

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF()
                    *-- Dopes: sempre presente em cursores de operacao/grid
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = ALLTRIM(NVL(Dopes, ""))
                    ENDIF

                    *-- Cgrus: presente no cursor local do grid e em SigOpGpo
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(NVL(Cgrus, ""))
                    ENDIF

                    *-- cIdChaves: apenas em SigOpGpo (PK)
                    IF TYPE(loc_cAlias + ".cIdChaves") != "U"
                        THIS.this_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere uma linha unica em SigOpGpo (Dopes, Cgrus, cIdChaves)
    * Usa as propriedades this_cDopes, this_cCgrus preenchidas previamente
    * Gera cIdChaves via SYS(2015) se nao definida
    * RETORNO: .T. se inserido com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o (Dopes) n" + CHR(227) + "o informada.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCgrus))
                MsgAviso("Grupo (Cgrus) n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsUnit") < 1
                MsgErro("Erro ao inserir registro em SigOpGpo.", "Erro")
            ELSE
                IF USED("cursor_4c_InsUnit")
                    USE IN cursor_4c_InsUnit
                ENDIF

                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza uma linha unica de SigOpGpo pela PK cIdChaves
    * Usa this_cIdChaves para localizar e this_cCgrus para atualizar
    * RETORNO: .T. se atualizado com sucesso
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                MsgAviso("Chave (cIdChaves) n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCgrus))
                MsgAviso("Grupo (Cgrus) n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpGpo SET " + ;
                       "Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       "Cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + " " + ;
                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdUnit") < 1
                MsgErro("Erro ao atualizar registro em SigOpGpo.", "Erro")
            ELSE
                IF USED("cursor_4c_UpdUnit")
                    USE IN cursor_4c_UpdUnit
                ENDIF

                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LiberarCursores - Libera todos os cursores temporarios ao fechar
    *==========================================================================
    PROCEDURE LiberarCursores()
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED("cursor_4c_OpeTemp")
            USE IN cursor_4c_OpeTemp
        ENDIF
        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF
        IF USED("cursor_4c_GprVal")
            USE IN cursor_4c_GprVal
        ENDIF
        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF
        IF USED("cursor_4c_DelResult")
            USE IN cursor_4c_DelResult
        ENDIF
        IF USED("cursor_4c_InsResult")
            USE IN cursor_4c_InsResult
        ENDIF
        IF USED("cursor_4c_InsUnit")
            USE IN cursor_4c_InsUnit
        ENDIF
        IF USED("cursor_4c_UpdUnit")
            USE IN cursor_4c_UpdUnit
        ENDIF
    ENDPROC

ENDDEFINE

