# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CATIVOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, PROGRAMAS, GRUPOS, PARAMETROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NCOMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, PROGRAMAS, GRUPOS, PARAMETROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, PROGRAMAS, GRUPOS, PARAMETROS

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
Select crSigCdAcUs
Delete
Count for ! Deleted() to lnRegs
	lcQuery = [Select Distinct a.Programas, a.Parametros, ?lcSpace As Descricaos ] + ;
			  [From SigCdAcU a ] + ;
			  [Left Outer Join SigCdAcG b On a.Grupos = b.Grupos ] + ;
	ThisForm.poDatamgr.SqlExecute(lcQuery,[crSigCdAcUs])
	Select crSigCdAcUs
		lcQuery = [Select descricaos From SigCdPrg Where programas = '] + crSigCdAcUs.Programas + [' And ]+;
		ThisForm.poDatamgr.SqlExecute(lcQuery,[crSigCdPrg])
			Select crSigCdAcUs 
	lcQuery = [select a.grupos,a.usuarios,a.descricaos,a.barraforms,a.barraordem,a.programas,a.parametros,a.selbarras from SigCdAcB a]+;
               [ left join SigCdPrg b on b.programas+b.parametros=a.programas+a.parametros]+;
               [ union all select a.grupos,a.usuarios,a.descricaos,a.barraforms,a.barraordem,a.programas,a.parametros,a.selbarras from SigCdAcB a]+;
               [ left join SigCdPrg b on b.programas+b.parametros=a.programas+a.parametros]+;
               [ where a.grupos in (select c.grupos from SigCdAcG c where c.usuarios='] + This.Value + [') order by 1,2]
	ThisForm.poDatamgr.SqlExecute(lcQuery,[crTmpBarra])
	Select crSigCdAcUs
	Thisform.Grid1.Column1.ControlSource = 'crSigCdAcUs.Descricaos'
	lcQuery = [Select Distinct a.Programas, a.Parametros, ?lcSpace As Descricaos ] + ;
			  [From SigCdAcU a ] + ;
			  [Left Outer Join SigCdAcG b On a.Grupos = b.Grupos ] + ;
	ThisForm.poDatamgr.SqlExecute(lcQuery,[crSigCdAcUs])
	Select crSigCdAcUs
		lcQuery = [Select descricaos From SigCdPrg Where programas = '] + crSigCdAcUs.Programas + [' And ]+;
		ThisForm.poDatamgr.SqlExecute(lcQuery,[crSigCdPrg])
			Select crSigCdAcUs 
	lcQuery = [select a.grupos,a.usuarios,a.descricaos,a.barraforms,a.barraordem,a.programas,a.parametros,a.selbarras from SigCdAcB a]+;
               [ left join SigCdPrg b on b.programas+b.parametros=a.programas+a.parametros]+;
               [ union all select a.grupos,a.usuarios,a.descricaos,a.barraforms,a.barraordem,a.programas,a.parametros,a.selbarras from SigCdAcB a]+;
               [ left join SigCdPrg b on b.programas+b.parametros=a.programas+a.parametros]+;
               [ where a.grupos in (select c.grupos from SigCdAcG c where c.usuarios='] + This.Value + [') order by 1,2]
	ThisForm.poDatamgr.SqlExecute(lcQuery,[crTmpBarra])
	Select crSigCdAcUs
	Thisform.Grid1.Column1.ControlSource = 'crSigCdAcUs.Descricaos'
ThisForm.poDatamgr.SqlExecute([Select * from SigCdGrA Where Grupos = ']+This.Value+['],'csSigCdGrA')
Select csSigCdGrA
Select crSigCdAcUs
	Select crSigCdAcU
Select crTmpBarra
	Select crTmpBarra
	Insert Into crSigCdAcB From Memvar
	m.lnErro1 = Iif(ThisForm.poDatamgr.UpDate('crSigCdGrA'), 1, -1)
	m.lnErro1 = Iif(ThisForm.poDatamgr.UpDate('crSigCdAcU'), 1, -1)
	m.lnErro1 = Iif(ThisForm.poDatamgr.UpDate('crSigCdAcB'), 1, -1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormGr1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1023 linhas total):

*-- Linhas 242 a 260:
242:             USE IN cursor_4c_Acessos
243:         ENDIF
244:         SET NULL ON
245:         CREATE CURSOR cursor_4c_Acessos ;
246:             (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
247:         SET NULL OFF
248: 
249:         *-- Shape borda da area de dados (Shape1 do legado)
250:         THIS.AddObject("shp_4c_Area", "Shape")
251:         WITH THIS.shp_4c_Area
252:             .Top           = 83
253:             .Left          = 3
254:             .Width         = 960
255:             .Height        = 507
256:             .BackStyle     = 0
257:             .SpecialEffect = 0
258:         ENDWITH
259: 
260:         *-- Label "Usu CHR(225) rio :" (Label1 do legado)

*-- Linhas 310 a 345:
310:             .Width              = 950
311:             .Height             = 472
312:             .ColumnCount        = 1
313:             .DeleteMark         = .F.
314:             .RecordMark         = .F.
315:             .ReadOnly           = .T.
316:             .ScrollBars         = 2
317:             .GridLineColor      = RGB(238, 238, 238)
318:             .FontName           = "Verdana"
319:             .FontSize           = 8
320:             .HighlightStyle     = 2
321:             .HighlightBackColor = RGB(255, 255, 255)
322:             .HighlightForeColor = RGB(15, 41, 104)
323:             .RowHeight          = 16
324: 
325:             WITH .Column1
326:                 .Width         = 924
327:                 .Movable       = .F.
328:                 .Resizable     = .F.
329:                 .ReadOnly      = .T.
330:                 .ControlSource = "cursor_4c_Acessos.Descricaos"
331:             ENDWITH
332: 
333:             .RecordSource = "cursor_4c_Acessos"
334:         ENDWITH
335: 
336:         *-- Header1: fora do WITH aninhado para evitar silently-ignored props
337:         loc_oGrid.Column1.Header1.Caption   = "Acessos"
338:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
339:         loc_oGrid.Column1.Header1.Alignment = 2
340:         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
341: 
342:         *-- Text1 (celula de dados): Courier New conforme legado
343:         loc_oGrid.Column1.Text1.FontName    = "Courier New"
344:         loc_oGrid.Column1.Text1.FontSize    = 8
345:         loc_oGrid.Column1.Text1.BorderStyle = 0

*-- Linhas 425 a 443:
425:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
426:                 THIS.grd_4c_Dados.ColumnCount  = 1
427:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
428:                 THIS.grd_4c_Dados.Column1.ControlSource        = "cursor_4c_Acessos.Descricaos"
429:                 THIS.grd_4c_Dados.Column1.Header1.Caption      = "Acessos"
430:                 THIS.grd_4c_Dados.Column1.Header1.FontName     = "Tahoma"
431:                 THIS.grd_4c_Dados.Column1.Header1.Alignment    = 2
432:                 THIS.grd_4c_Dados.Column1.Header1.ForeColor    = RGB(90, 90, 90)
433:                 THIS.grd_4c_Dados.Refresh()
434:             ENDIF
435: 
436:         CATCH TO loc_oErro
437:             MsgErro(loc_oErro.Message + CHR(13) + ;
438:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
439:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarAcessos")
440:         ENDTRY
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------

*-- Linhas 460 a 478:
460: 
461:                 IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
462:                    loc_oLookup.this_lSelecionou
463:                     SELECT cursor_4c_BuscaUsu
464:                     THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
465:                     THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
466:                     THIS.txt_4c_Descri.ReadOnly = .T.
467:                     THIS.this_cUsuarios          = ALLTRIM(Usuarios)
468:                     THIS.this_cNComps            = ALLTRIM(NComps)
469:                     USE IN cursor_4c_BuscaUsu
470:                     THIS.CarregarAcessos()
471:                 ELSE
472:                     IF USED("cursor_4c_BuscaUsu")
473:                         USE IN cursor_4c_BuscaUsu
474:                     ENDIF
475:                 ENDIF
476:             ENDIF
477: 
478:         CATCH TO loc_oErro

*-- Linhas 502 a 520:
502: 
503:                 IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
504:                    loc_oLookup.this_lSelecionou
505:                     SELECT cursor_4c_BuscaUsu
506:                     THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
507:                     THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
508:                     THIS.txt_4c_Descri.ReadOnly = .T.
509:                     THIS.this_cUsuarios          = ALLTRIM(Usuarios)
510:                     THIS.this_cNComps            = ALLTRIM(NComps)
511:                     USE IN cursor_4c_BuscaUsu
512:                     THIS.CarregarAcessos()
513:                 ELSE
514:                     IF USED("cursor_4c_BuscaUsu")
515:                         USE IN cursor_4c_BuscaUsu
516:                     ENDIF
517:                 ENDIF
518:             ENDIF
519: 
520:         CATCH TO loc_oErro

*-- Linhas 711 a 729:
711:     *--------------------------------------------------------------------------
712:     * BtnIncluirClick - Grava novo grupo com os acessos do usuario selecionado
713:     * Form OPERACIONAL "Gera" + CHR(231) + CHR(227) + "o de Grupos": incluir
714:     * significa gerar um novo registro em SigCdGrA (SalvarGrupo faz DELETE+INSERT
715:     * em transacao, garantindo idempotencia caso o grupo ja exista).
716:     *--------------------------------------------------------------------------
717:     PROCEDURE BtnIncluirClick()
718:         LOCAL loc_cUsuarios, loc_cGrupo, loc_oErro
719: 
720:         TRY
721:             loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
722:             loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)
723: 
724:             IF EMPTY(loc_cUsuarios)
725:                 MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
726:                          "Valida" + CHR(231) + CHR(227) + "o")
727:                 THIS.txt_4c_Codigo.SetFocus()
728:                 RETURN
729:             ENDIF

*-- Linhas 758 a 777:
758: 
759:     *--------------------------------------------------------------------------
760:     * BtnAlterarClick - Regrava grupo existente com os acessos ajustados no grid
761:     * Regrava o grupo apenas se ja existir. SalvarGrupo faz DELETE dos registros
762:     * antigos em SigCdGrA e INSERT dos atuais do cursor local, sob transacao.
763:     *--------------------------------------------------------------------------
764:     PROCEDURE BtnAlterarClick()
765:         LOCAL loc_cUsuarios, loc_cGrupo, loc_lResp, loc_oErro
766: 
767:         TRY
768:             loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
769:             loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)
770: 
771:             IF EMPTY(loc_cUsuarios)
772:                 MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
773:                          "Valida" + CHR(231) + CHR(227) + "o")
774:                 THIS.txt_4c_Codigo.SetFocus()
775:                 RETURN
776:             ENDIF
777: 

*-- Linhas 847 a 865:
847:     *--------------------------------------------------------------------------
848:     * BtnExcluirClick - Remove acesso selecionado do cursor local (pre-save)
849:     * Nao afeta SigCdGrA ate o Salvar. Exige registro corrente no grid.
850:     * Equivale ao Commandgroup2.Click do legado (Delete + Count + SetFocus).
851:     *--------------------------------------------------------------------------
852:     PROCEDURE BtnExcluirClick()
853:         LOCAL loc_lResp, loc_oErro
854: 
855:         TRY
856:             IF !USED("cursor_4c_Acessos") OR ;
857:                EOF("cursor_4c_Acessos") OR BOF("cursor_4c_Acessos")
858:                 MsgAviso("Nenhum acesso selecionado.", ;
859:                          "Exclus" + CHR(227) + "o")
860:                 RETURN
861:             ENDIF
862: 
863:             loc_lResp = MsgConfirma("Remover o acesso selecionado da lista?", ;
864:                                     "Confirma" + CHR(231) + CHR(227) + "o")
865: 

*-- Linhas 931 a 956:
931:         ENDIF
932: 
933:         SET NULL ON
934:         CREATE CURSOR cursor_4c_Acessos ;
935:             (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
936:         SET NULL OFF
937: 
938:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
939:             THIS.grd_4c_Dados.ColumnCount  = 1
940:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
941:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Acessos.Descricaos"
942:             THIS.grd_4c_Dados.Refresh()
943:         ENDIF
944: 
945:         THIS.txt_4c_Codigo.SetFocus()
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * CarregarLista - Recarrega dados do usuario corrente (alias de CarregarAcessos)
950:     *--------------------------------------------------------------------------
951:     PROCEDURE CarregarLista()
952:         IF !EMPTY(THIS.this_cUsuarios)
953:             THIS.CarregarAcessos()
954:         ENDIF
955:     ENDPROC
956: 


### BO (C:\4c\projeto\app\classes\Gr1BO.prg):
*==============================================================================
* Gr1BO.prg - Business Object: Geracao de Grupos de Acesso
* Tabela principal: SigCdGrA (grupos)
* Tabelas auxiliares: SigCdAcU (acessos por usuario), SigCdAcB (acessos do grupo)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS Gr1BO AS BusinessBase

    this_cTabela          = "SigCdGrA"
    this_cCampoChave      = "Grupos"

    *-- Dados do usuario selecionado (SigCdUsu)
    this_cUsuarios        = ""
    this_cNComps          = ""

    *-- Dados do novo grupo a criar (SigCdGrA)
    this_cGrupos          = ""
    this_cGrupoNComps     = ""

    *-- Cursores de trabalho
    this_cCursorAcessos   = "cursor_4c_Acessos"
    this_cCursorBarra     = "cursor_4c_Barra"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdGrA"
        THIS.this_cCampoChave = "Grupos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos      = TratarNulo(Grupos, "C")
            THIS.this_cGrupoNComps = TratarNulo(nComps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Informe o c" + CHR(243) + "digo do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrupoNComps))
            MsgAviso("Informe o nome do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir grupo no banco de dados.", ;
                            "Erro de Inser" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigCdGrA SET nComps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ;
                           " WHERE Grupos = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos))

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar grupo no banco de dados.", ;
                            "Erro de Atualiza" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro de SigCdGrA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGrA WHERE Grupos = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("D")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo.", ;
                        "Erro de Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarAcessosPorUsuario - Carrega cursor_4c_Acessos para o grid
    * Equivale ao Valid de GetCodigo/GetDescri no legado
    *--------------------------------------------------------------------------
    FUNCTION BuscarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios
        LOCAL loc_cProgram, loc_cParam, loc_cDescricao

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos)
                USE IN (THIS.this_cCursorAcessos)
            ENDIF
            IF USED("cursor_4c_AcessosTemp")
                USE IN cursor_4c_AcessosTemp
            ENDIF
            IF USED("cursor_4c_PrgDesc")
                USE IN cursor_4c_PrgDesc
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            *-- Acessos diretos do usuario + via grupos aos quais pertence
            loc_cSQL = "SELECT DISTINCT a.Programas, a.Parametros, " + ;
                       "CAST('' AS VARCHAR(150)) AS Descricaos " + ;
                       "FROM SigCdAcU a " + ;
                       "LEFT OUTER JOIN SigCdAcG b ON a.Grupos = b.Grupos " + ;
                       "WHERE NOT a.Programas = SPACE(10) AND " + ;
                       "(a.Usuarios = " + loc_cUsuarios + ;
                       " OR b.Usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY a.Programas, a.Parametros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessosTemp") > 0

                SET NULL ON
                CREATE CURSOR cursor_4c_Acessos ;
                    (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
                SET NULL OFF

                SELECT cursor_4c_AcessosTemp
                SCAN
                    loc_cProgram   = ALLTRIM(cursor_4c_AcessosTemp.Programas)
                    loc_cParam     = ALLTRIM(cursor_4c_AcessosTemp.Parametros)
                    loc_cDescricao = loc_cProgram + " / " + loc_cParam

                    loc_cSQL = "SELECT descricaos FROM SigCdPrg " + ;
                               "WHERE programas = " + EscaparSQL(loc_cProgram) + ;
                               " AND Parametros = " + EscaparSQL(loc_cParam)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrgDesc") > 0
                        IF !EOF("cursor_4c_PrgDesc")
                            loc_cDescricao = ALLTRIM(cursor_4c_PrgDesc.descricaos)
                        ENDIF
                        IF USED("cursor_4c_PrgDesc")
                            USE IN cursor_4c_PrgDesc
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Acessos
                    INSERT INTO cursor_4c_Acessos VALUES ;
                        (cursor_4c_AcessosTemp.Programas, ;
                         cursor_4c_AcessosTemp.Parametros, ;
                         loc_cDescricao)
                ENDSCAN

                IF USED("cursor_4c_AcessosTemp")
                    USE IN cursor_4c_AcessosTemp
                ENDIF

                SELECT cursor_4c_Acessos
                INDEX ON Descricaos TAG Descrs
                SET ORDER TO Descrs
                GO TOP

                *-- Carrega tambem barras para uso no SalvarGrupo
                THIS.CarregarBarrasDoUsuario(par_cUsuarios)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarAcessosPorUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarBarrasDoUsuario - Carrega cursor_4c_Barra (dados para SigCdAcB)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarBarrasDoUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorBarra)
                USE IN (THIS.this_cCursorBarra)
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            loc_cSQL = "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.usuarios = " + loc_cUsuarios + ;
                       " UNION ALL " + ;
                       "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.grupos IN " + ;
                       "(SELECT c.grupos FROM SigCdAcG c WHERE c.usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY 1, 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Barra") > 0
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarBarrasDoUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupoExistente - Verifica se codigo de grupo ja existe em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupoExistente(par_cGrupo)
        LOCAL loc_lExiste, loc_oErro, loc_cSQL

        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT Grupos FROM SigCdGrA " + ;
                       "WHERE Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpCheck") > 0
                loc_lExiste = !EOF("cursor_4c_GrpCheck")
                IF USED("cursor_4c_GrpCheck")
                    USE IN cursor_4c_GrpCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * RemoverAcessoLocal - Remove registro corrente do cursor_4c_Acessos (local)
    *--------------------------------------------------------------------------
    FUNCTION RemoverAcessoLocal()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos) AND !EOF(THIS.this_cCursorAcessos)
                SELECT (THIS.this_cCursorAcessos)
                DELETE
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RemoverAcessoLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupo - Cria novo grupo copiando acessos do usuario
    * Orquestra INSERT em SigCdGrA, SigCdAcU e SigCdAcB via transacao
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupo(par_cUsuarios, par_cGrupo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cGrupo, loc_cPkChave
        LOCAL loc_lTransacaoAberta, loc_lErroBanco

        loc_lSucesso        = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroBanco      = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cUsuarios))
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(par_cGrupo))
                MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cGrupo = EscaparSQL(ALLTRIM(par_cGrupo))

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacaoAberta = .T.

                *-- 1. Insere o novo grupo em SigCdGrA
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           loc_cGrupo + ", " + loc_cGrupo + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                    loc_lErroBanco = .T.
                ENDIF

                *-- 2. Para cada acesso nao-deletado em cursor_4c_Acessos,
                *--    insere em SigCdAcU associado ao novo grupo
                IF !loc_lErroBanco AND USED(THIS.this_cCursorAcessos)
                    SELECT (THIS.this_cCursorAcessos)
                    SCAN FOR !DELETED() AND !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcU " + ;
                                   "(pkChaves, Programas, Parametros, Grupos, Usuarios) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Programas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Parametros)) + ", " + ;
                                   loc_cGrupo + ", '')"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- 3. Para cada barra em cursor_4c_Barra,
                *--    insere em SigCdAcB com grupo=NovoGrupo e usuario=vazio
                IF !loc_lErroBanco AND USED(THIS.this_cCursorBarra)
                    SELECT (THIS.this_cCursorBarra)
                    SCAN FOR !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcB " + ;
                                   "(pkChaves, grupos, usuarios, descricaos, " + ;
                                   "barraforms, barraordem, programas, parametros, selbarras) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   loc_cGrupo + ", " + ;
                                   "'', " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.descricaos, "")), 73)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.barraforms, "")), 50)) + ", " + ;
                                   FormatarNumeroSQL(NVL(cursor_4c_Barra.barraordem, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.programas, "")), 15)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.parametros, "")), 10)) + ", " + ;
                                   FormatarNumeroSQL(IIF(NVL(cursor_4c_Barra.selbarras, .F.), 1, 0), 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroBanco
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacaoAberta = .F.
                    MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados. " + ;
                            "Favor tentar novamente.", "Erro de Grava" + CHR(231) + CHR(227) + "o")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT")
                    loc_lTransacaoAberta = .F.
                    THIS.this_cGrupos      = ALLTRIM(par_cGrupo)
                    THIS.this_cGrupoNComps = ALLTRIM(par_cGrupo)
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorCodigo - Retorna nome do usuario dado seu codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorCodigo(par_cCodigo)
        LOCAL loc_cNome, loc_oErro, loc_cSQL

        loc_cNome = ""

        TRY
            loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                       "WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " AND cAtivos <> 'N'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuBuscaCod") > 0
                IF !EOF("cursor_4c_UsuBuscaCod")
                    loc_cNome = ALLTRIM(cursor_4c_UsuBuscaCod.NComps)
                ENDIF
                IF USED("cursor_4c_UsuBuscaCod")
                    USE IN cursor_4c_UsuBuscaCod
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarUsuarioPorCodigo")
        ENDTRY

        RETURN loc_cNome
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorNome - Retorna codigo do usuario dado seu nome
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorNome(par_cNome)
        LOCAL loc_cCodigo, loc_oErro, loc_cSQL

        loc_cCodigo = ""

        TRY
            loc_cSQL = "SELECT Usuarios FROM SigCdUsu " + ;
                       "WHERE NComps = " + EscaparSQL(ALLTRIM(par_cNome)) + ;
                       " AND cAtivos <> 'N'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuBuscaNome") > 0
                IF !EOF("cursor_4c_UsuBuscaNome")
                    loc_cCodigo = ALLTRIM(cursor_4c_UsuBuscaNome.Usuarios)
                ENDIF
                IF USED("cursor_4c_UsuBuscaNome")
                    USE IN cursor_4c_UsuBuscaNome
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarUsuarioPorNome")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

ENDDEFINE

