# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcSqlTri = [Select * From SigPrTri Where Tipos = ?lcTipo ]
	ThisForm.poDatamgr.SqlExecute([Select * From SigPrTri Where Tipos = ']+ThisForm.Container1.fwget1.Value+['],"CsSigPrTri")
	Select csSigPrTri
	ThisForm.poDatamgr.UpDate("cnSigPrTri")

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormICD.prg) - TRECHOS RELEVANTES PARA PASS SQL (690 linhas total):

*-- Linhas 418 a 439:
418:         ENDIF
419: 
420:         TRY
421:             loc_cSQL = "SELECT TOP 1 Tipos, Descs FROM SigPrTri " + ;
422:                        "WHERE tipos = " + EscaparSQL(loc_cTipo)
423:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTipo") > 0
424:                 SELECT cursor_4c_LkpTipo
425:                 IF !EOF()
426:                     THIS.cnt_4c_Container1.txt_4c_Tipo.Value    = ALLTRIM(Tipos)
427:                     THIS.cnt_4c_Container1.txt_4c_Desc.Value    = ALLTRIM(Descs)
428:                     THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
429:                     USE IN cursor_4c_LkpTipo
430:                     RETURN
431:                 ENDIF
432:                 USE IN cursor_4c_LkpTipo
433:             ENDIF
434:         CATCH TO loc_oErro
435:             MsgErro(loc_oErro.Message + CHR(13) + ;
436:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
437:                     "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTipo")
438:             RETURN
439:         ENDTRY

*-- Linhas 457 a 475:
457:             loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
458:             loc_oLookup.Show()
459:             IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LkpTipo")
460:                 SELECT cursor_4c_LkpTipo
461:                 THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
462:                 THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
463:                 THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
464:                 USE IN cursor_4c_LkpTipo
465:             ENDIF
466:         ENDIF
467:     ENDPROC
468: 
469:     *--------------------------------------------------------------------------
470:     * TxtTipoDblClick - abre lookup de SigPrTri por Tipos via duplo clique
471:     *--------------------------------------------------------------------------
472:     PROCEDURE TxtTipoDblClick()
473:         THIS.AbrirLookupTipo()
474:     ENDPROC
475: 

*-- Linhas 500 a 521:
500:         ENDIF
501: 
502:         TRY
503:             loc_cSQL = "SELECT TOP 1 Tipos, Descs FROM SigPrTri " + ;
504:                        "WHERE descs = " + EscaparSQL(loc_cDesc)
505:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpDesc") > 0
506:                 SELECT cursor_4c_LkpDesc
507:                 IF !EOF()
508:                     THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
509:                     THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
510:                     THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
511:                     USE IN cursor_4c_LkpDesc
512:                     RETURN
513:                 ENDIF
514:                 USE IN cursor_4c_LkpDesc
515:             ENDIF
516:         CATCH TO loc_oErro
517:             MsgErro(loc_oErro.Message + CHR(13) + ;
518:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
519:                     "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDesc")
520:             RETURN
521:         ENDTRY

*-- Linhas 550 a 568:
550:             loc_oLookup.mAddColuna("Tipos", "XXXX", "Tipo")
551:             loc_oLookup.Show()
552:             IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LkpDesc")
553:                 SELECT cursor_4c_LkpDesc
554:                 THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
555:                 THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
556:                 THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
557:                 USE IN cursor_4c_LkpDesc
558:             ENDIF
559:         ENDIF
560:     ENDPROC
561: 
562:     *--------------------------------------------------------------------------
563:     * RegistrarEventos - vincula eventos dos controles via BINDEVENT
564:     *--------------------------------------------------------------------------
565:     PROTECTED PROCEDURE RegistrarEventos()
566:         LOCAL loc_oCnt
567:         loc_oCnt = THIS.cnt_4c_Container1
568: 


### BO (C:\4c\projeto\app\classes\ICDBO.prg):
*------------------------------------------------------------------------------
* ICDBO.prg - Business Object para Duplicacao de Tipo de Tributacao
* Tabela: SigPrTri
* PK: cIdChaves (char 20)
* Form associado: FormICD.prg (operacionais\)
*------------------------------------------------------------------------------

DEFINE CLASS ICDBO AS BusinessBase

    *-- Tipo de origem (registro a ser duplicado)
    this_cTipos    = ""   && char(4)  - codigo do tipo existente
    this_cDescs    = ""   && char(20) - descricao do tipo existente

    *-- Novo tipo (destino da duplicacao)
    this_cNovoTipos  = ""  && char(4)  - novo codigo do tipo
    this_cNovaDescs  = ""  && char(20) - nova descricao

    *-- Chave primaria do registro carregado (para auditoria)
    this_cCidChaves  = ""  && char(20) - PK cIdChaves

    *-- Demais campos da SigPrTri (copiados integralmente no INSERT)
    this_nAliquotas  = 0   && numeric(5,2)
    this_nBases      = 0   && numeric(5,2)
    this_cCfops      = ""  && char(10)
    this_cDestinos   = ""  && char(2)
    this_cMovs       = ""  && char(1)
    this_cOrigems    = ""  && char(2)
    this_nReduzidas  = 0   && numeric(5,2)
    this_nAliqIcmsts = 0   && numeric(5,2) - aliqicmsts (presente no schema, ausente na Fase 1)

    *-- Cursor principal
    this_cCursorDados = "cnSigPrTri"

    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrTri"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna valor da chave primaria (requerido por BusinessBase)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cIdChaves,  "C")
            THIS.this_cTipos       = TratarNulo(Tipos,      "C")
            THIS.this_cDescs       = TratarNulo(Descs,      "C")
            THIS.this_nAliquotas   = TratarNulo(Aliquotas,  "N")
            THIS.this_nBases       = TratarNulo(Bases,      "N")
            THIS.this_cCfops       = TratarNulo(Cfops,      "C")
            THIS.this_cDestinos    = TratarNulo(Destinos,   "C")
            THIS.this_cMovs        = TratarNulo(Movs,       "C")
            THIS.this_cOrigems     = TratarNulo(Origems,    "C")
            THIS.this_nReduzidas   = TratarNulo(Reduzidas,  "N")
            THIS.this_nAliqIcmsts  = TratarNulo(Aliqicmsts, "N")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - carrega cursor cnSigPrTri com todos os tipos de tributacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cnSigPrTri")
                TABLEREVERT(.T., "cnSigPrTri")
                USE IN cnSigPrTri
            ENDIF
            loc_cSQL = "SELECT cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts " + ;
                       "FROM SigPrTri "
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + "WHERE " + par_cFiltro + " "
            ENDIF
            loc_cSQL = loc_cSQL + "ORDER BY tipos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cnSigPrTri") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), ;
                        "Erro ao buscar tipos de tributa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorTipo - carrega cursor cnSigPrTri filtrado por codigo de tipo
    *               e popula propriedades do BO com os dados encontrados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorTipo(par_cTipos)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cnSigPrTri")
                TABLEREVERT(.T., "cnSigPrTri")
                USE IN cnSigPrTri
            ENDIF
            loc_cSQL = "SELECT cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts " + ;
                       "FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(ALLTRIM(par_cTipos))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cnSigPrTri") > 0
                SELECT cnSigPrTri
                IF !EOF()
                    THIS.CarregarDoCursor("cnSigPrTri")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao buscar tipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorTipo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTipoExistente - retorna .T. se o tipo ja existe na SigPrTri
    *--------------------------------------------------------------------------
    FUNCTION VerificarTipoExistente(par_cTipos)
        LOCAL loc_cSQL, loc_lExiste, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(ALLTRIM(par_cTipos))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheckTipo") > 0
                SELECT cursor_4c_CheckTipo
                loc_lExiste = (NVL(nExiste, 0) > 0)
                USE IN cursor_4c_CheckTipo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em VerificarTipoExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * DuplicarTipo - duplica registro SigPrTri com novo codigo e descricao
    *               Logica original (Command1.Click): Requery cnSigPrTri com
    *               o tipo de origem, REPLACE ALL com novos valores + UpDate
    *               Equivalente novo: SELECT origem, INSERT com novos tipos/descs/cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION DuplicarTipo(par_cTipoOrigem, par_cNovoTipo, par_cNovaDesc)
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Validar parametros de entrada
            IF EMPTY(ALLTRIM(par_cTipoOrigem))
                MsgAviso("Informe o Tipo de origem para duplicar.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cNovoTipo))
                MsgAviso("Informe o novo c" + CHR(243) + "digo do Tipo.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            *-- Verificar se novo tipo ja existe (equivalente ao SELECT csSigPrTri + EOF check original)
            IF THIS.VerificarTipoExistente(par_cNovoTipo)
                MsgAviso("Novo Tipo J" + CHR(225) + " Cadastrado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            *-- Carregar dados completos do tipo de origem (equivalente ao Requery original)
            IF !THIS.BuscarPorTipo(par_cTipoOrigem)
                MsgAviso("Tipo de origem n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cTipoOrigem), "Aviso")
                loc_lSucesso = .F.
            ENDIF
            *-- Gerar nova chave primaria unica (equivalente ao fUniqueIds() do REPLACE ALL)
            loc_cNovaChave = LEFT(fUniqueIds(), 20)
            *-- INSERT do novo registro copiando todos os campos + novos tipos/descs/cIdChaves
            loc_cSQL = "INSERT INTO SigPrTri " + ;
                       "(cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cNovaChave) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(par_cNovoTipo), 4)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(par_cNovaDesc), 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                       EscaparSQL(THIS.this_cCfops) + ", " + ;
                       EscaparSQL(THIS.this_cDestinos) + ", " + ;
                       EscaparSQL(THIS.this_cMovs) + ", " + ;
                       EscaparSQL(THIS.this_cOrigems) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + ;
                       ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cCidChaves = loc_cNovaChave
                THIS.this_cNovoTipos = LEFT(ALLTRIM(par_cNovoTipo), 4)
                THIS.this_cNovaDescs = LEFT(ALLTRIM(par_cNovaDesc), 20)
                THIS.RegistrarAuditoria("DUPLICAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao duplicar tipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em DuplicarTipo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTri com todos os campos populados nas
    *          propriedades this_*. Gera cIdChaves via fUniqueIds se vazio.
    *          Verifica duplicidade de Tipos antes do INSERT.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaChave, loc_cTipoDestino, loc_cDescDestino, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTipoDestino = ALLTRIM(THIS.this_cNovoTipos)
            IF EMPTY(loc_cTipoDestino)
                loc_cTipoDestino = ALLTRIM(THIS.this_cTipos)
            ENDIF
            loc_cDescDestino = ALLTRIM(THIS.this_cNovaDescs)
            IF EMPTY(loc_cDescDestino)
                loc_cDescDestino = ALLTRIM(THIS.this_cDescs)
            ENDIF
            IF EMPTY(loc_cTipoDestino)
                MsgAviso("Informe o c" + CHR(243) + "digo do Tipo.", "Aviso")
            ELSE
                IF THIS.VerificarTipoExistente(loc_cTipoDestino)
                    MsgAviso("Tipo J" + CHR(225) + " Cadastrado: " + loc_cTipoDestino, "Aviso")
                ELSE
                    loc_cNovaChave = ALLTRIM(THIS.this_cCidChaves)
                    IF EMPTY(loc_cNovaChave)
                        loc_cNovaChave = LEFT(fUniqueIds(), 20)
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrTri " + ;
                               "(cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                               "destinos, movs, origems, reduzidas, aliqicmsts) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cNovaChave) + ", " + ;
                               EscaparSQL(LEFT(loc_cTipoDestino, 4)) + ", " + ;
                               EscaparSQL(LEFT(loc_cDescDestino, 20)) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                               EscaparSQL(THIS.this_cCfops) + ", " + ;
                               EscaparSQL(THIS.this_cDestinos) + ", " + ;
                               EscaparSQL(THIS.this_cMovs) + ", " + ;
                               EscaparSQL(THIS.this_cOrigems) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + ;
                               ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.this_cCidChaves = loc_cNovaChave
                        THIS.this_cTipos     = LEFT(loc_cTipoDestino, 4)
                        THIS.this_cDescs     = LEFT(loc_cDescDestino, 20)
                        THIS.RegistrarAuditoria("INCLUSAO")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao inserir tipo de tributa" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTri para o registro identificado por
    *            this_cCidChaves (PK). Usado quando o BO precisa persistir
    *            alteracoes em um registro previamente carregado.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro carregado para atualizar.", "Aviso")
            ELSE
                loc_cSQL = "UPDATE SigPrTri SET " + ;
                           "tipos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipos), 4)) + ", " + ;
                           "descs = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 20)) + ", " + ;
                           "aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                           "bases = "      + FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                           "cfops = "      + EscaparSQL(THIS.this_cCfops) + ", " + ;
                           "destinos = "   + EscaparSQL(THIS.this_cDestinos) + ", " + ;
                           "movs = "       + EscaparSQL(THIS.this_cMovs) + ", " + ;
                           "origems = "    + EscaparSQL(THIS.this_cOrigems) + ", " + ;
                           "reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                           "aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("ALTERACAO")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao atualizar tipo de tributa" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

