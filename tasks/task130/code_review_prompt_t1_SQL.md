# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
Select Relacao
lcQryMala = 'Select RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, Tel1s, Tel2s, Faxs, cIdChaves ' + ;
			  'From SigMlCab ' + ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREIPS.prg) - TRECHOS RELEVANTES PARA PASS SQL (756 linhas total):

*-- Linhas 454 a 476:
454:             RETURN
455:         ENDIF
456:         TRY
457:             loc_cSQL = "SELECT Codigos, Descs FROM SigMlItn WHERE Codigos = " + ;
458:                 EscaparSQL(loc_cValor)
459:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodigosVal")
460:             IF loc_nResult > 0
461:                 SELECT cursor_4c_CodigosVal
462:                 IF !EOF()
463:                     THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_CodigosVal.Codigos)
464:                     THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_CodigosVal.Descs)
465:                 ELSE
466:                     USE IN cursor_4c_CodigosVal
467:                     THIS.AbrirBuscaCodigo()
468:                     RETURN
469:                 ENDIF
470:             ELSE
471:                 THIS.AbrirBuscaCodigo()
472:                 RETURN
473:             ENDIF
474:             IF USED("cursor_4c_CodigosVal")
475:                 USE IN cursor_4c_CodigosVal
476:             ENDIF

*-- Linhas 493 a 515:
493:             RETURN
494:         ENDIF
495:         TRY
496:             loc_cSQL = "SELECT Codigos, Descs FROM SigMlItn WHERE Descs LIKE " + ;
497:                 EscaparSQL(loc_cValor + "%")
498:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescsVal")
499:             IF loc_nResult > 0
500:                 SELECT cursor_4c_DescsVal
501:                 IF !EOF()
502:                     THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_DescsVal.Codigos)
503:                     THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_DescsVal.Descs)
504:                 ELSE
505:                     USE IN cursor_4c_DescsVal
506:                     THIS.AbrirBuscaDesc()
507:                     RETURN
508:                 ENDIF
509:             ELSE
510:                 THIS.AbrirBuscaDesc()
511:                 RETURN
512:             ENDIF
513:             IF USED("cursor_4c_DescsVal")
514:                 USE IN cursor_4c_DescsVal
515:             ENDIF

*-- Linhas 634 a 652:
634:             ENDIF
635:             loc_cArquivo = PUTFILE("Salvar como...", "SigReIp3", "XLS")
636:             IF !EMPTY(loc_cArquivo)
637:                 SELECT (loc_cCursor)
638:                 COPY TO (loc_cArquivo) TYPE XLS
639:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
640:                     loc_cArquivo, "Excel")
641:             ENDIF
642:         CATCH TO loc_oErro
643:             MsgErro(loc_oErro.Message + CHR(13) + ;
644:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
645:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
646:         ENDTRY
647:     ENDPROC
648: 
649:     *--------------------------------------------------------------------------
650:     * BtnSairClick - Fecha o formulario (PROCEDURE Release do legado)
651:     *--------------------------------------------------------------------------
652:     PROCEDURE BtnSairClick()


### BO (C:\4c\projeto\app\classes\SIGREIPSBO.prg):
*==============================================================================
* SIGREIPSBO.PRG
* Business Object para Relatorio de Impressao de Etiquetas/Mala Direta (SigReIp3)
*
* Herda de RelatorioBase
* Tabela principal: SigMlCab
* Filtro: SigMlItn (codigo/descricao)
*==============================================================================

DEFINE CLASS SIGREIPSBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCodigos       = ""   && Codigo do item (SigMlItn.Codigos)
    this_cDescs         = ""   && Descricao do item (SigMlItn.Descs)

    *-- Cursor de dados do relatorio
    this_cCursorDados   = "cursor_4c_Relacao"

    *-- Identificacao
    this_cTabela        = "SigMlCab"
    this_cCampoChave    = "cIdChaves"
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMlCab"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula cursor do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cWhere = "1=1"
            IF !EMPTY(ALLTRIM(THIS.this_cCodigos))
                loc_cWhere = loc_cWhere + " AND Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))
            ENDIF

            loc_cSQL = "SELECT RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, " + ;
                       "Tel1s, Tel2s, Faxs, cIdChaves " + ;
                       "FROM SigMlCab " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, " + ;
                       "Estas, Tel1s, Tel2s, Faxs, cIdChaves"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados para o relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            REPORT FORM (gc_4c_CaminhoReports + "SigReIp3") TO PRINTER NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum registro encontrado para visualiza" + CHR(231) + CHR(227) + "o.", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            REPORT FORM (gc_4c_CaminhoReports + "SigReIp3") PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual no cursor
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            IF !EOF()
                RETURN ALLTRIM(cIdChaves)
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

ENDDEFINE

