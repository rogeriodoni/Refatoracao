# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGr1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1029 linhas total):

*-- Linhas 245 a 263:
245:             USE IN cursor_4c_Acessos
246:         ENDIF
247:         SET NULL ON
248:         CREATE CURSOR cursor_4c_Acessos ;
249:             (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
250:         SET NULL OFF
251: 
252:         *-- Shape borda da area de dados (Shape1 do legado)
253:         THIS.AddObject("shp_4c_Area", "Shape")
254:         WITH THIS.shp_4c_Area
255:             .Top           = 83
256:             .Left          = 3
257:             .Width         = 960
258:             .Height        = 507
259:             .BackStyle     = 0
260:             .SpecialEffect = 0
261:         ENDWITH
262: 
263:         *-- Label "Usu CHR(225) rio :" (Label1 do legado)

*-- Linhas 313 a 355:
313:             .Width              = 950
314:             .Height             = 472
315:             .ColumnCount        = 1
316:             .DeleteMark         = .F.
317:             .RecordMark         = .F.
318:             .ReadOnly           = .T.
319:             .ScrollBars         = 2
320:             .GridLineColor      = RGB(238, 238, 238)
321:             .FontName           = "Verdana"
322:             .FontSize           = 8
323:             .HighlightStyle     = 2
324:             .HighlightBackColor = RGB(255, 255, 255)
325:             .HighlightForeColor = RGB(15, 41, 104)
326:             .RowHeight          = 16
327: 
328:             WITH .Column1
329:                 .Width         = 924
330:                 .Movable       = .F.
331:                 .Resizable     = .F.
332:                 .ReadOnly      = .T.
333:                 .ControlSource = "cursor_4c_Acessos.Descricaos"
334:             ENDWITH
335: 
336:             .RecordSource = "cursor_4c_Acessos"
337:         ENDWITH
338: 
339:         *-- ControlSource redefinido apos RecordSource para evitar auto-bind por ordem de campos
340:         loc_oGrid.Column1.ControlSource     = "cursor_4c_Acessos.Descricaos"
341: 
342:         *-- Header1: fora do WITH aninhado para evitar silently-ignored props
343:         loc_oGrid.Column1.Header1.Caption   = "Acessos"
344:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
345:         loc_oGrid.Column1.Header1.Alignment = 2
346:         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
347: 
348:         *-- Text1 (celula de dados): Courier New conforme legado
349:         loc_oGrid.Column1.Text1.FontName    = "Courier New"
350:         loc_oGrid.Column1.Text1.FontSize    = 8
351:         loc_oGrid.Column1.Text1.BorderStyle = 0
352:         loc_oGrid.Column1.Text1.ReadOnly    = .T.
353:         loc_oGrid.Column1.Text1.ForeColor   = RGB(0, 0, 0)
354:         loc_oGrid.Column1.Text1.BackColor   = RGB(255, 255, 255)
355: 

*-- Linhas 431 a 449:
431:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
432:                 THIS.grd_4c_Dados.ColumnCount  = 1
433:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
434:                 THIS.grd_4c_Dados.Column1.ControlSource        = "cursor_4c_Acessos.Descricaos"
435:                 THIS.grd_4c_Dados.Column1.Header1.Caption      = "Acessos"
436:                 THIS.grd_4c_Dados.Column1.Header1.FontName     = "Tahoma"
437:                 THIS.grd_4c_Dados.Column1.Header1.Alignment    = 2
438:                 THIS.grd_4c_Dados.Column1.Header1.ForeColor    = RGB(90, 90, 90)
439:                 THIS.grd_4c_Dados.Refresh()
440:             ENDIF
441: 
442:         CATCH TO loc_oErro
443:             MsgErro(loc_oErro.Message + CHR(13) + ;
444:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
445:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarAcessos")
446:         ENDTRY
447:     ENDPROC
448: 
449:     *--------------------------------------------------------------------------

*-- Linhas 466 a 484:
466: 
467:                 IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
468:                    loc_oLookup.this_lSelecionou
469:                     SELECT cursor_4c_BuscaUsu
470:                     THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
471:                     THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
472:                     THIS.txt_4c_Descri.ReadOnly = .T.
473:                     THIS.this_cUsuarios          = ALLTRIM(Usuarios)
474:                     THIS.this_cNComps            = ALLTRIM(NComps)
475:                     USE IN cursor_4c_BuscaUsu
476:                     THIS.CarregarAcessos()
477:                 ELSE
478:                     IF USED("cursor_4c_BuscaUsu")
479:                         USE IN cursor_4c_BuscaUsu
480:                     ENDIF
481:                 ENDIF
482:             ENDIF
483: 
484:         CATCH TO loc_oErro

*-- Linhas 508 a 526:
508: 
509:                 IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
510:                    loc_oLookup.this_lSelecionou
511:                     SELECT cursor_4c_BuscaUsu
512:                     THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
513:                     THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
514:                     THIS.txt_4c_Descri.ReadOnly = .T.
515:                     THIS.this_cUsuarios          = ALLTRIM(Usuarios)
516:                     THIS.this_cNComps            = ALLTRIM(NComps)
517:                     USE IN cursor_4c_BuscaUsu
518:                     THIS.CarregarAcessos()
519:                 ELSE
520:                     IF USED("cursor_4c_BuscaUsu")
521:                         USE IN cursor_4c_BuscaUsu
522:                     ENDIF
523:                 ENDIF
524:             ENDIF
525: 
526:         CATCH TO loc_oErro

*-- Linhas 717 a 735:
717:     *--------------------------------------------------------------------------
718:     * BtnIncluirClick - Grava novo grupo com os acessos do usuario selecionado
719:     * Form OPERACIONAL "Gera" + CHR(231) + CHR(227) + "o de Grupos": incluir
720:     * significa gerar um novo registro em SigCdGrA (SalvarGrupo faz DELETE+INSERT
721:     * em transacao, garantindo idempotencia caso o grupo ja exista).
722:     *--------------------------------------------------------------------------
723:     PROCEDURE BtnIncluirClick()
724:         LOCAL loc_cUsuarios, loc_cGrupo, loc_oErro
725: 
726:         TRY
727:             loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
728:             loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)
729: 
730:             IF EMPTY(loc_cUsuarios)
731:                 MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
732:                          "Valida" + CHR(231) + CHR(227) + "o")
733:                 THIS.txt_4c_Codigo.SetFocus()
734:                 RETURN
735:             ENDIF

*-- Linhas 764 a 783:
764: 
765:     *--------------------------------------------------------------------------
766:     * BtnAlterarClick - Regrava grupo existente com os acessos ajustados no grid
767:     * Regrava o grupo apenas se ja existir. SalvarGrupo faz DELETE dos registros
768:     * antigos em SigCdGrA e INSERT dos atuais do cursor local, sob transacao.
769:     *--------------------------------------------------------------------------
770:     PROCEDURE BtnAlterarClick()
771:         LOCAL loc_cUsuarios, loc_cGrupo, loc_lResp, loc_oErro
772: 
773:         TRY
774:             loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
775:             loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)
776: 
777:             IF EMPTY(loc_cUsuarios)
778:                 MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
779:                          "Valida" + CHR(231) + CHR(227) + "o")
780:                 THIS.txt_4c_Codigo.SetFocus()
781:                 RETURN
782:             ENDIF
783: 

*-- Linhas 853 a 871:
853:     *--------------------------------------------------------------------------
854:     * BtnExcluirClick - Remove acesso selecionado do cursor local (pre-save)
855:     * Nao afeta SigCdGrA ate o Salvar. Exige registro corrente no grid.
856:     * Equivale ao Commandgroup2.Click do legado (Delete + Count + SetFocus).
857:     *--------------------------------------------------------------------------
858:     PROCEDURE BtnExcluirClick()
859:         LOCAL loc_lResp, loc_oErro
860: 
861:         TRY
862:             IF !USED("cursor_4c_Acessos") OR ;
863:                EOF("cursor_4c_Acessos") OR BOF("cursor_4c_Acessos")
864:                 MsgAviso("Nenhum acesso selecionado.", ;
865:                          "Exclus" + CHR(227) + "o")
866:                 RETURN
867:             ENDIF
868: 
869:             loc_lResp = MsgConfirma("Remover o acesso selecionado da lista?", ;
870:                                     "Confirma" + CHR(231) + CHR(227) + "o")
871: 

*-- Linhas 937 a 962:
937:         ENDIF
938: 
939:         SET NULL ON
940:         CREATE CURSOR cursor_4c_Acessos ;
941:             (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
942:         SET NULL OFF
943: 
944:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
945:             THIS.grd_4c_Dados.ColumnCount  = 1
946:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
947:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Acessos.Descricaos"
948:             THIS.grd_4c_Dados.Refresh()
949:         ENDIF
950: 
951:         THIS.txt_4c_Codigo.SetFocus()
952:     ENDPROC
953: 
954:     *--------------------------------------------------------------------------
955:     * CarregarLista - Recarrega dados do usuario corrente (alias de CarregarAcessos)
956:     *--------------------------------------------------------------------------
957:     PROCEDURE CarregarLista()
958:         IF !EMPTY(THIS.this_cUsuarios)
959:             THIS.CarregarAcessos()
960:         ENDIF
961:     ENDPROC
962: 


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
                       "WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cCodigo))

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
        RETURN ""
    ENDFUNC

ENDDEFINE

