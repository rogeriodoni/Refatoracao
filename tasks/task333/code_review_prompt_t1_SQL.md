# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, EMPDOPNUMS, LLERR, N, SENHADS

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
  DeleteMark = .F.
lcQrySend = [Select * From SigPrSnd Where cIdChaves = '] + pIds + [']
lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
Select crSigPrSnd
ThisForm.grdSenha.Column1.ControlSource = [crSigPrSnd.Senhads]
Select SenhaDs as Senhas From crSigPrSnd Into Cursor TmpPrSnd
Select TmpPrSnd
Select crSigPrSnd
	Insert Into crSigPrSnd (Usuars, Datas, Tipos) Values (Usuar, ldData, 0)
Select crSigPrSnd
ThisForm.grdSenha.Column1.ControlSource = [crSigPrSnd.Senhads]
llOk = ThisForm.poDataMgr.Update('crSigPrSnd')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.prg) - TRECHOS RELEVANTES PARA PASS SQL (748 linhas total):

*-- Linhas 329 a 347:
329:             .FontName          = "Verdana"
330:             .AllowHeaderSizing = .F.
331:             .AllowRowSizing    = .F.
332:             .DeleteMark        = .F.
333:             .RecordMark        = .F.
334:             .HeaderHeight      = 16
335:             .RowHeight         = 16
336:             .ScrollBars        = 2
337:             .GridLineColor     = RGB(238, 238, 238)
338:             .HighlightBackColor = RGB(255, 255, 255)
339:             .HighlightForeColor = RGB(15, 41, 104)
340:             .HighlightStyle    = 2
341:         ENDWITH
342: 
343:         THIS.grd_4c_Dados.Column1.Width       = 260
344:         THIS.grd_4c_Dados.Column1.ColumnOrder = 1
345:         THIS.grd_4c_Dados.Column1.ReadOnly    = .T.
346:         THIS.grd_4c_Dados.Column1.FontSize    = 8
347:         THIS.grd_4c_Dados.Column1.Header1.Caption   = "Senhas geradas"

*-- Linhas 363 a 393:
363:     ENDPROC
364: 
365:     *==========================================================================
366:     * AtualizarGrid - Vincula cursor ao grid e reconfigura ControlSource
367:     *==========================================================================
368:     PROCEDURE AtualizarGrid()
369:         LOCAL loc_oGrid
370:         loc_oGrid = THIS.grd_4c_Dados
371:         IF VARTYPE(loc_oGrid) != "O"
372:             RETURN
373:         ENDIF
374:         loc_oGrid.RecordSource = ""
375:         IF USED("crSigPrSnd")
376:             loc_oGrid.ColumnCount              = 1
377:             loc_oGrid.RecordSource             = "crSigPrSnd"
378:             loc_oGrid.Column1.ControlSource    = "crSigPrSnd.Senhads"
379:             loc_oGrid.Column1.Header1.Caption  = "Senhas geradas"
380:             loc_oGrid.Refresh()
381:         ENDIF
382:     ENDPROC
383: 
384:     *==========================================================================
385:     * CmdEncerrarClick - Fecha o formulario
386:     *==========================================================================
387:     PROCEDURE CmdEncerrarClick()
388:         THIS.Release()
389:     ENDPROC
390: 
391:     *==========================================================================
392:     * CmdSenPendClick - Exibe senhas com EmpDopNums vazio
393:     *==========================================================================

*-- Linhas 420 a 439:
420:                 MsgAviso("Nenhuma senha para exportar.", "Excel")
421:             ELSE
422:                 *-- Cria cursor temporario somente com a coluna Senhads
423:                 SELECT Senhads AS Senhas FROM crSigPrSnd INTO CURSOR TmpPrSnd READWRITE
424:                 SELECT TmpPrSnd
425: 
426:                 loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS;TXT")
427: 
428:                 IF !EMPTY(loc_cArquivo)
429:                     IF LOWER(ALLTRIM(JUSTEXT(loc_cArquivo))) = "xls"
430:                         COPY TO (loc_cArquivo) TYPE XL5
431:                     ELSE
432:                         COPY TO (loc_cArquivo) DELIMITED WITH "" WITH CHARACTER ";"
433:                     ENDIF
434: 
435:                     IF FILE(loc_cArquivo)
436:                         MsgInfo("Arquivo gerado com sucesso.", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
437:                     ELSE
438:                         loc_lErro = .T.
439:                     ENDIF

*-- Linhas 548 a 566:
548:             IF !USED("crSigPrSnd") OR RECCOUNT("crSigPrSnd") = 0
549:                 MsgAviso("Nenhuma senha selecionada.", "Excluir")
550:             ELSE
551:                 SELECT crSigPrSnd
552:                 loc_cId    = TratarNulo(crSigPrSnd.cidchaves, "C")
553:                 loc_cSenha = TratarNulo(crSigPrSnd.senhads,   "C")
554: 
555:                 IF EMPTY(loc_cId)
556:                     MsgAviso("Registro sem identificador. Sele" + CHR(231) + ;
557:                              CHR(227) + "o inv" + CHR(225) + "lida.", "Excluir")
558:                 ELSE
559:                     IF MsgConfirma("Confirma exclus" + CHR(227) + "o da senha " + ;
560:                                    ALLTRIM(loc_cSenha) + "?", "Excluir Senha")
561:                         *-- Cursor crSigPrSnd ja tem o registro selecionado
562:                         IF THIS.this_oBusinessObject.CarregarDoCursor("crSigPrSnd")
563:                             IF THIS.this_oBusinessObject.Excluir()
564:                                 THIS.this_oBusinessObject.Buscar("")
565:                                 THIS.AtualizarGrid()
566:                                 MsgInfo("Senha exclu" + CHR(237) + "da com sucesso.", "Excluir")


### BO (C:\4c\projeto\app\classes\SigPrSndBO.prg):
*==============================================================================
* SigPrSndBO.prg - Business Object: Senhas Livres
* Tabela: SigPrSnd
* Chave: cidchaves char(20)
*==============================================================================
DEFINE CLASS SigPrSndBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela      = "SigPrSnd"
    this_cCampoChave  = "cidchaves"

    *-- Propriedades mapeadas para colunas de SigPrSnd
    this_cCidChaves   = ""   && cidchaves char(20) PK NOT NULL
    this_dDatas       = {}   && datas     datetime NULL
    this_nDocs        = 0    && docs      numeric(10,0) NOT NULL
    this_cHoras       = ""   && horas     char(8) NOT NULL
    this_cMotivos     = ""   && motivos   char(40) NOT NULL
    this_cOperas      = ""   && operas    char(20) NOT NULL
    this_cSenhads     = ""   && senhads   char(6) NOT NULL
    this_cSolicits    = ""   && solicits  char(10) NOT NULL
    this_cUsuars      = ""   && usuars    char(10) NOT NULL
    this_nValors      = 0    && valors    numeric(11,2) NOT NULL
    this_nTipos       = 0    && tipos     numeric(1,0) NOT NULL
    this_cEmps        = ""   && emps      char(3) NOT NULL
    this_cFpags       = ""   && fpags     char(12) NOT NULL
    this_cEmpDopNums  = ""   && empdopnums char(29) NOT NULL
    this_nPerlimite   = 0    && perlimite numeric(5,2) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrSnd"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Inicializa cursor vazio com estrutura de SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Query que retorna 0 registros para criar cursor estruturado vazio
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves = " + ;
                EscaparSQL(REPLICATE(CHR(254), 20))
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_nDocs       = TratarNulo(docs,       "N")
                THIS.this_cHoras      = TratarNulo(horas,      "C")
                THIS.this_cMotivos    = TratarNulo(motivos,    "C")
                THIS.this_cOperas     = TratarNulo(operas,     "C")
                THIS.this_cSenhads    = TratarNulo(senhads,    "C")
                THIS.this_cSolicits   = TratarNulo(solicits,   "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_nValors     = TratarNulo(valors,     "N")
                THIS.this_nTipos      = TratarNulo(tipos,      "N")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cFpags      = TratarNulo(fpags,      "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrSnd (todas as colunas NOT NULL)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)              + ", " + ;
                EscaparSQL(LEFT(THIS.this_cUsuars, 10))       + ", " + ;
                "GETDATE(), "                                          + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0)        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSenhads, 6))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cHoras, 8))         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))          + ", " + ;
                FormatarNumeroSQL(THIS.this_nDocs, 0)         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMotivos, 40))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cOperas, 20))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSolicits, 10))     + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFpags, 12))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPerlimite, 2)    + ;
                ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                "usuars     = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10))     + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)           + ", " + ;
                "tipos      = " + FormatarNumeroSQL(THIS.this_nTipos, 0)      + ", " + ;
                "senhads    = " + EscaparSQL(LEFT(THIS.this_cSenhads, 6))     + ", " + ;
                "horas      = " + EscaparSQL(LEFT(THIS.this_cHoras, 8))       + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "docs       = " + FormatarNumeroSQL(THIS.this_nDocs, 0)       + ", " + ;
                "motivos    = " + EscaparSQL(LEFT(THIS.this_cMotivos, 40))    + ", " + ;
                "operas     = " + EscaparSQL(LEFT(THIS.this_cOperas, 20))     + ", " + ;
                "solicits   = " + EscaparSQL(LEFT(THIS.this_cSolicits, 10))   + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "fpags      = " + EscaparSQL(LEFT(THIS.this_cFpags, 12))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "perlimite  = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " "  + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrSnd " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir senha de SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarSemVinculo - Carrega senhas livres com EmpDopNums em branco
    *--------------------------------------------------------------------------
    PROCEDURE BuscarSemVinculo()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE EmpDopNums = ''"
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSenhas - Gera N senhas livres e insere em SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE GerarSenhas(par_nQtd)
        LOCAL loc_lSucesso, loc_n, loc_nSenha, loc_cSenha, loc_cId
        LOCAL loc_cSQL, loc_cChaves, loc_lTransacao, loc_lErroSQL
        loc_lSucesso   = .F.
        loc_cChaves    = ""
        loc_lTransacao = .F.
        loc_lErroSQL   = .F.
        TRY
            IF VARTYPE(par_nQtd) != "N" OR par_nQtd <= 0
                MsgAviso("Quantidade de senhas inv" + CHR(225) + "lida.", "Aviso")
            ELSE
                IF MsgConfirma("Deseja realmente gerar " + ;
                    ALLTRIM(STR(par_nQtd)) + " senhas livres?", "Gerar Senha")
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.
                    FOR loc_n = 1 TO par_nQtd
                        IF !loc_lErroSQL
                            *-- Gera senha unica nao existente em SigPrSnd
                            loc_nSenha = 0
                            DO WHILE loc_nSenha = 0
                                loc_nSenha = THIS.GerarSenhaAleatoria()
                                loc_cSenha = STR(loc_nSenha, 6)
                                IF THIS.SenhaExisteSQL(loc_cSenha)
                                    loc_nSenha = 0
                                ENDIF
                            ENDDO
                            loc_cId  = THIS.GerarIdUnico()
                            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cId) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                "GETDATE(), " + ;
                                "0, " + ;
                                EscaparSQL(loc_cSenha) + ", " + ;
                                EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + ", " + ;
                                "0, '', '', '', 0, '', '', 0" + ;
                                ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                                MsgErro("Erro ao gravar senha " + ALLTRIM(loc_cSenha) + ".", "Erro")
                                loc_lErroSQL = .T.
                            ELSE
                                IF EMPTY(loc_cChaves)
                                    loc_cChaves = "'" + loc_cId + "'"
                                ELSE
                                    loc_cChaves = loc_cChaves + ",'" + loc_cId + "'"
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDFOR
                    IF loc_lErroSQL
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        loc_lTransacao = .F.
                    ELSE
                        SQLEXEC(gnConnHandle, "COMMIT")
                        loc_lTransacao = .F.
                        *-- Recarrega cursor com as senhas recem geradas
                        IF USED("crSigPrSnd")
                            USE IN crSigPrSnd
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves IN (" + loc_cChaves + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                            SELECT crSigPrSnd
                            GO TOP
                        ENDIF
                        MsgInfo("Favor anotar as senhas geradas.", "Senhas Livres")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaExisteSQL - Verifica se senha ja existe em SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SenhaExisteSQL(par_cSenha)
        LOCAL loc_lExiste, loc_cSQL, loc_nCount
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrSnd WHERE SenhaDs = " + ;
                EscaparSQL(par_cSenha)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhaCheck") > 0
                IF USED("cursor_4c_SenhaCheck")
                    loc_nCount  = cursor_4c_SenhaCheck.nExiste
                    loc_lExiste = NVL(loc_nCount, 0) > 0
                    USE IN cursor_4c_SenhaCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarSenhaAleatoria - Gera numero aleatorio de 6 digitos (100000-999999)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarSenhaAleatoria()
        RETURN INT(RAND() * 900000) + 100000
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera identificador unico de 20 caracteres para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdUnico()
        LOCAL loc_cId
        loc_cId = SYS(2015) + SYS(2015)
        RETURN LEFT(loc_cId, 20)
    ENDFUNC

ENDDEFINE

