# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CBARSEDEXS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, LCQUERY, NNUMETIQS, X, FAIXAINIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, LCQUERY, NNUMETIQS, X, FAIXAINIS

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
lcQuery = [Select DtIncs, FaixaInis, FaixaFins, sum(Case When EmpDopNums = '' Then 0 Else 1 End) as nUsadas, sum(Case When EmpDopNums <> '' Then 0 Else 1 End) as nLivres ] +;
			[from SigCdSed Where cEmps = ?crSigCdEmp.cEmps Group By DtIncs, FaixaInis, FaixaFins Order By DtIncs, FaixaInis, FaixaFins]
If Not (ThisForm.ThisParent.poDatamgr.SqlExecute(lcQuery,'crSedex') > 0)
thisform.grade.column1.ControlSource = 'crSedex.FaixaInis'
thisform.grade.column2.ControlSource = 'crSedex.FaixaFins'
thisform.grade.column3.ControlSource = 'crSedex.nLivres'
thisform.grade.column4.ControlSource = 'crSedex.nUsadas'
thisform.grade.column4.ControlSource = 'crSedex.nUsadas'
thisform.grade.column5.ControlSource = 'crSedex.DtIncs'
lcQuery = [Select cBarSedexs from SigCdSed where nNumEtiqs Between ?lcFaixaIni And ?lcFaixaFin And cEmps = ?crSigCdEmp.cEmps]
If Not (ThisForm.ThisParent.poDatamgr.SqlExecute(lcQuery,'LocalSed') > 0)
Select cBarSedexs from crSigCdSed where nNumEtiqs Between lnFaixaIni And lnFaixaFin And cEmps = crSigCdEmp.cEmps into cursor LocalSed2
	Insert into crSigCdSed(cEmps,DtIncs,nNumEtiqs,FaixaInis,FaixaFins) values (crSigCdEmp.cEmps,Date(),x,thisform.getfaixainicial.Value,thisform.getfaixafinal.Value)
Select crSigCdSed
Insert into crSedex(DtIncs,FaixaInis,FaixaFins,nLivres,nUsadas) values (Date(),thisform.getfaixainicial.Value,thisform.getfaixafinal.Value,(lnFaixaFin - lnFaixaIni + 1),0)
Select crSedex
lcQuery = [Select * from SigCdSed Where cEmps = ?crSigCdEmp.cEmps And FaixaInis = ?crSedex.FaixaInis]
If Not (ThisForm.ThisParent.poDatamgr.SqlExecute(lcQuery,[LocalSedex]) > 0)
Select crSedex
Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSed.prg) - TRECHOS RELEVANTES PARA PASS SQL (801 linhas total):

*-- Linhas 403 a 421:
403:             .HighlightBackColor = RGB(255, 255, 255)
404:             .HighlightForeColor = RGB(15, 41, 104)
405:             .HighlightStyle     = 2
406:             .DeleteMark         = .F.
407:             .RecordMark         = .F.
408:             .RowHeight          = 16
409:             .ScrollBars         = 2
410:             .ReadOnly           = .T.
411: 
412:             *-- Column5 = DtIncs (ColumnOrder=1: aparece primeiro, original Column5.ColumnOrder=1)
413:             WITH .Column5
414:                 .ColumnOrder = 1
415:                 .Width       = 160
416:                 .Resizable   = .F.
417:                 .ReadOnly    = .T.
418:                 WITH .Header1
419:                     .FontName  = "Tahoma"
420:                     .FontSize  = 8
421:                     .Alignment = 2

*-- Linhas 534 a 556:
534:                 loc_oGrid.ColumnCount  = 5
535:                 loc_oGrid.RecordSource = "cursor_4c_Sedex"
536: 
537:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Sedex.FaixaInis"
538:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Sedex.FaixaFins"
539:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Sedex.nLivres"
540:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Sedex.nUsadas"
541:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Sedex.DtIncs"
542: 
543:                 *-- Re-configurar apos troca de RecordSource (Pattern #180 / Problema 48)
544:                 loc_oGrid.Column1.Width           = 200
545:                 loc_oGrid.Column1.Header1.Caption = "Faixa Inicial"
546:                 loc_oGrid.Column2.Width           = 200
547:                 loc_oGrid.Column2.Header1.Caption = "Faixa Final"
548:                 loc_oGrid.Column3.Width           = 150
549:                 loc_oGrid.Column3.Header1.Caption = "Livres"
550:                 loc_oGrid.Column4.Width           = 150
551:                 loc_oGrid.Column4.Header1.Caption = "Usadas"
552:                 loc_oGrid.Column5.Width           = 160
553:                 loc_oGrid.Column5.Header1.Caption = "Data Inclus" + CHR(227) + "o"
554: 
555:                 loc_oGrid.Refresh()
556: 

*-- Linhas 623 a 655:
623:     *==========================================================================
624:     * cmd_4c_ExcluirClick - Handler do botao Excluir
625:     * Le FaixaInis e nUsadas do registro corrente no cursor e chama ExcluirFaixa.
626:     * LockScreen durante delete + reload evita flickering (fidelidade ao legado).
627:     *==========================================================================
628:     PROCEDURE cmd_4c_ExcluirClick()
629:         LOCAL loc_cFaixaIni, loc_nUsadas
630: 
631:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
632:             RETURN
633:         ENDIF
634: 
635:         IF !USED("cursor_4c_Sedex") OR RECCOUNT("cursor_4c_Sedex") = 0
636:             MsgAviso("Selecione um registro para excluir.", "Aviso")
637:             RETURN
638:         ENDIF
639: 
640:         SELECT cursor_4c_Sedex
641:         IF EOF("cursor_4c_Sedex")
642:             MsgAviso("Selecione um registro para excluir.", "Aviso")
643:             RETURN
644:         ENDIF
645: 
646:         loc_cFaixaIni = ALLTRIM(NVL(cursor_4c_Sedex.FaixaInis, ""))
647:         loc_nUsadas   = NVL(cursor_4c_Sedex.nUsadas, 0)
648: 
649:         THIS.LockScreen = .T.
650: 
651:         IF THIS.this_oBusinessObject.ExcluirFaixa(loc_cFaixaIni, go_4c_Sistema.cCodEmpresa, loc_nUsadas)
652:             THIS.CarregarDados()
653:             THIS.grd_4c_Dados.Refresh()
654:         ENDIF
655: 


### BO (C:\4c\projeto\app\classes\SedBO.prg):
*==============================================================================
* SedBO.prg - Business Object para Etiquetas de Sedex (SigCdSed)
* Herda de: BusinessBase
* Tabela principal: SigCdSed
* PK: cBarSedexs char(16)
*==============================================================================

DEFINE CLASS SedBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdSed
    *--------------------------------------------------------------------------
    this_cBarSedexs  = ""   && char(16) - codigo de barras sedex (PK)
    this_cEmps       = ""   && char(3)  - codigo empresa
    this_dDtIncs     = {}   && datetime - data inclusao
    this_dDtUsos     = {}   && datetime - data uso da etiqueta
    this_cEmpDopNums = ""   && char(29) - numero DOP/protocolo ('' = livre)
    this_cFaixaFins  = ""   && char(14) - faixa final da geracao
    this_cFaixaInis  = ""   && char(14) - faixa inicial da geracao
    this_nNumEtiqs   = 0    && numeric(8,0) - numero sequencial da etiqueta
    this_nImpress    = 0    && numeric(1,0) - flag impresso

    *--------------------------------------------------------------------------
    * Configuracao do BusinessBase
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdSed"
    this_cCampoChave = "cBarSedexs"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cBarSedexs)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAlias)
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cBarSedexs  = TratarNulo(cBarSedexs,  "C")
            THIS.this_cEmps       = TratarNulo(cEmps,       "C")
            THIS.this_cFaixaInis  = TratarNulo(FaixaInis,   "C")
            THIS.this_cFaixaFins  = TratarNulo(FaixaFins,   "C")
            THIS.this_nNumEtiqs   = TratarNulo(nNumEtiqs,   "N")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums,  "C")
            THIS.this_nImpress    = TratarNulo(nImpress,    "N")
            THIS.this_dDtIncs     = TratarNulo(DtIncs,      "D")
            THIS.this_dDtUsos     = TratarNulo(DtUsos,      "D")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSedex - Carrega cursor_4c_Sedex com dados agrupados por faixa
    * Equivalente ao SELECT do Init legado
    *--------------------------------------------------------------------------
    FUNCTION CarregarSedex(par_cEmps)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Sedex")
                USE IN cursor_4c_Sedex
            ENDIF

            loc_cSQL = "SELECT DtIncs, FaixaInis, FaixaFins, " + ;
                       "SUM(CASE WHEN ISNULL(EmpDopNums,'') = '' THEN 0 ELSE 1 END) AS nUsadas, " + ;
                       "SUM(CASE WHEN ISNULL(EmpDopNums,'') <> '' THEN 0 ELSE 1 END) AS nLivres " + ;
                       "FROM SigCdSed " + ;
                       "WHERE cEmps = " + EscaparSQL(par_cEmps) + " " + ;
                       "GROUP BY DtIncs, FaixaInis, FaixaFins " + ;
                       "ORDER BY DtIncs, FaixaInis, FaixaFins"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sedex")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar etiquetas de Sedex." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.CarregarSedex")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarEtiquetas - Gera etiquetas de Sedex para a faixa informada
    * Equivalente ao cmdprocessar.Click legado
    *--------------------------------------------------------------------------
    FUNCTION GerarEtiquetas(par_cFaixaIni, par_cFaixaFin, par_cEmps)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_nFaixaIni, loc_nFaixaFin, loc_nX
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cBarEtiq, loc_cServico, loc_cPais
        LOCAL loc_cSeqPadded

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Extrair numeros sequenciais das faixas (8 digitos numericos)
            loc_nFaixaIni = VAL(THIS.ExtrairNumericos(par_cFaixaIni))
            loc_nFaixaFin = VAL(THIS.ExtrairNumericos(par_cFaixaFin))

            IF loc_nFaixaIni = 0 OR loc_nFaixaFin = 0
                MsgAviso("Faixa inicial e final s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND loc_nFaixaFin < loc_nFaixaIni
                MsgAviso("Faixa final deve ser maior ou igual " + CHR(224) + " faixa inicial.", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Verificar se ja existem etiquetas na faixa
                loc_cSQL = "SELECT cBarSedexs FROM SigCdSed " + ;
                           "WHERE nNumEtiqs BETWEEN " + TRANSFORM(loc_nFaixaIni) + ;
                           " AND " + TRANSFORM(loc_nFaixaFin) + ;
                           " AND cEmps = " + EscaparSQL(par_cEmps)

                IF USED("cursor_4c_SedVerif")
                    USE IN cursor_4c_SedVerif
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SedVerif")

                IF loc_nResult <= 0
                    MsgErro("Erro ao verificar etiquetas existentes." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !EOF("cursor_4c_SedVerif")
                    MsgAviso("J" + CHR(225) + " existe etiquetas geradas na faixa informada.", "Aviso")
                    loc_lContinuar = .F.
                ENDIF

                IF USED("cursor_4c_SedVerif")
                    USE IN cursor_4c_SedVerif
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Servico (2 primeiros chars) e pais (2 ultimos chars da faixa de 14)
                loc_cServico = SUBSTR(par_cFaixaIni, 1, 2)
                loc_cPais    = SUBSTR(par_cFaixaIni, 13, 2)

                *-- Gerar uma etiqueta por numero sequencial
                loc_nX = loc_nFaixaIni
                DO WHILE loc_lContinuar AND loc_nX <= loc_nFaixaFin
                    loc_cSeqPadded = PADL(TRANSFORM(loc_nX), 8, "0")
                    loc_cBarEtiq   = THIS.CalcularBarraSedex(loc_cServico + loc_cSeqPadded + loc_cPais)

                    loc_cSQL = "INSERT INTO SigCdSed " + ;
                               "(cEmps, DtIncs, nNumEtiqs, FaixaInis, FaixaFins, cBarSedexs, EmpDopNums) " + ;
                               "VALUES (" + ;
                               EscaparSQL(par_cEmps) + ", GETDATE(), " + ;
                               FormatarNumeroSQL(loc_nX, 0) + ", " + ;
                               EscaparSQL(par_cFaixaIni) + ", " + ;
                               EscaparSQL(par_cFaixaFin) + ", " + ;
                               EscaparSQL(loc_cBarEtiq) + ", " + ;
                               EscaparSQL("") + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult <= 0
                        MsgErro("Erro ao inserir etiqueta " + TRANSFORM(loc_nX) + "." + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lContinuar = .F.
                    ELSE
                        loc_nX = loc_nX + 1
                    ENDIF
                ENDDO

                IF loc_lContinuar
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.GerarEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirFaixa - Exclui todas as etiquetas de uma faixa do SQL Server
    * Equivalente ao excluir.Click legado
    * par_nUsadas: numero de etiquetas ja usadas (0 = pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION ExcluirFaixa(par_cFaixaIni, par_cEmps, par_nUsadas)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF par_nUsadas > 0
                MsgAviso("Etiquetas j" + CHR(225) + " usadas na faixa selecionada. " + ;
                         "N" + CHR(227) + "o " + CHR(233) + " permitido exclus" + CHR(227) + "o.", ;
                         "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigCdSed " + ;
                           "WHERE cEmps = " + EscaparSQL(par_cEmps) + ;
                           " AND FaixaInis = " + EscaparSQL(par_cFaixaIni)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult <= 0
                    MsgErro("Erro ao excluir etiquetas da faixa." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.ExcluirFaixa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades do BO antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cBarSedexs)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras Sedex " + CHR(233) + " obrigat" + CHR(243) + "rio."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cFaixaInis)
            THIS.this_cMensagemErro = "Faixa inicial " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cFaixaFins)
            THIS.this_cMensagemErro = "Faixa final " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um novo registro na tabela SigCdSed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSed
                    (cBarSedexs, cEmps, DtIncs, DtUsos, EmpDopNums,
                     FaixaFins, FaixaInis, nNumEtiqs, nImpress)
                VALUES (
                    <<EscaparSQL(THIS.this_cBarSedexs)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    GETDATE(),
                    <<FormatarDataSQL(THIS.this_dDtUsos)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cFaixaFins)>>,
                    <<EscaparSQL(THIS.this_cFaixaInis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumEtiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpress, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir etiqueta Sedex: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente na tabela SigCdSed
    * Uso tipico: marcar etiqueta como usada (preencher EmpDopNums/DtUsos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSed
                SET cEmps      = <<EscaparSQL(THIS.this_cEmps)>>,
                    DtUsos     = <<FormatarDataSQL(THIS.this_dDtUsos)>>,
                    EmpDopNums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    FaixaFins  = <<EscaparSQL(THIS.this_cFaixaFins)>>,
                    FaixaInis  = <<EscaparSQL(THIS.this_cFaixaInis)>>,
                    nNumEtiqs  = <<FormatarNumeroSQL(THIS.this_nNumEtiqs, 0)>>,
                    nImpress   = <<FormatarNumeroSQL(THIS.this_nImpress, 0)>>
                WHERE cBarSedexs = <<EscaparSQL(THIS.this_cBarSedexs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar etiqueta Sedex: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui um registro da tabela SigCdSed pela PK
    * Guard: nao permite excluir etiqueta ja usada (EmpDopNums preenchido)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_lUsada

        loc_lSucesso = .F.
        loc_lUsada   = .F.

        TRY
            *-- Verificar se a etiqueta ja foi usada
            loc_cSQL = "SELECT EmpDopNums FROM SigCdSed " + ;
                       "WHERE cBarSedexs = " + EscaparSQL(THIS.this_cBarSedexs)

            IF USED("cursor_4c_SedChk")
                USE IN cursor_4c_SedChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SedChk")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao verificar etiqueta: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_SedChk") AND !EOF("cursor_4c_SedChk")
                    loc_lUsada = !EMPTY(NVL(cursor_4c_SedChk.EmpDopNums, ""))
                ENDIF

                IF USED("cursor_4c_SedChk")
                    USE IN cursor_4c_SedChk
                ENDIF

                IF loc_lUsada
                    THIS.this_cMensagemErro = "Etiqueta j" + CHR(225) + " utilizada. N" + CHR(227) + "o " + CHR(233) + " permitido exclus" + CHR(227) + "o."
                    MsgAviso(THIS.this_cMensagemErro, "Aviso")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdSed " + ;
                               "WHERE cBarSedexs = " + EscaparSQL(THIS.this_cBarSedexs)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao excluir etiqueta Sedex: " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExtrairNumericos - Extrai apenas os digitos numericos de uma string
    * Equivalente a fSubstTxt(str, "", "N") do framework legado
    * Retorna os 8 primeiros digitos (numero sequencial da faixa)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExtrairNumericos(par_cTexto)
        LOCAL loc_cResultado, loc_i, loc_cChar

        loc_cResultado = ""

        FOR loc_i = 1 TO LEN(ALLTRIM(par_cTexto))
            loc_cChar = SUBSTR(par_cTexto, loc_i, 1)
            IF ISDIGIT(loc_cChar)
                loc_cResultado = loc_cResultado + loc_cChar
            ENDIF
        ENDFOR

        RETURN SUBSTR(loc_cResultado, 1, 8)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularBarraSedex - Calcula codigo de barras Sedex com digito verificador
    * Equivalente a fBarSedex() do framework legado (Correios Modulo-11)
    * par_cCodigo: 12 chars - Servico(2) + Sequencial(8) + Pais(2)
    * Retorna: 13 chars - Servico(2) + Sequencial(8) + Digito(1) + Pais(2)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularBarraSedex(par_cCodigo)
        LOCAL loc_cServico, loc_cSequencial, loc_cPais
        LOCAL loc_nSoma, loc_nResto, loc_nDigito, loc_i
        LOCAL loc_aPesos[8]

        loc_cServico    = SUBSTR(par_cCodigo, 1, 2)
        loc_cSequencial = SUBSTR(par_cCodigo, 3, 8)
        loc_cPais       = SUBSTR(par_cCodigo, 11, 2)

        *-- Pesos Correios Modulo-11 para Sedex/PAC
        loc_aPesos[1] = 8
        loc_aPesos[2] = 6
        loc_aPesos[3] = 4
        loc_aPesos[4] = 2
        loc_aPesos[5] = 3
        loc_aPesos[6] = 9
        loc_aPesos[7] = 7
        loc_aPesos[8] = 5

        loc_nSoma = 0
        FOR loc_i = 1 TO 8
            loc_nSoma = loc_nSoma + (VAL(SUBSTR(loc_cSequencial, loc_i, 1)) * loc_aPesos[loc_i])
        ENDFOR

        loc_nResto = MOD(loc_nSoma, 11)

        DO CASE
            CASE loc_nResto = 0
                loc_nDigito = 5
            CASE loc_nResto = 1
                loc_nDigito = 0
            OTHERWISE
                loc_nDigito = 11 - loc_nResto
        ENDCASE

        RETURN loc_cServico + loc_cSequencial + TRANSFORM(loc_nDigito) + loc_cPais
    ENDFUNC

ENDDEFINE

