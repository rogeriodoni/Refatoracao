# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, TABELAS, CONTAS, INSERIRS, ALTERARS, EXCLUIRS, BAIXAS, LCPICL, ICL, INFOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, TABELAS, CONTAS, INSERIRS, ALTERARS, EXCLUIRS, BAIXAS, LCPICL, ICL, INFOS
- [TRANSACAO-AVULSA] Linha 438: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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
  Column1.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
	lcQuery = [Select OPE.dopes, OPE.Dopes as Descrs, 'SIGCDOPE' as Tabelas, ] + ;
		[FROM SigCdOpe OPE ] + ; 
		[Inner Join SigOpCdc CDC On CDC.Dopes = OPE.Dopes and CDC.OpeInatvs = 0 ] + ;
		[Left Outer Join SigCdAle ALE On OPE.Dopes = ALE.dopes And ALE.Tabelas = 'SIGCDOPE' and ALE.contas = '] + lcpiclis + [']
	.poDatamgr.SqlExecute(lcQuery,[crAleCdOpe])
	lcQuery = [Select a.Codigos as Dopes, a.Descrs, 'SIGCDGCR' as Tabelas, ] + ;
		[FROM SigCdGcr a ] + ; 
		[Left Outer Join SigCdAle b On substring(b.Dopes,1,10) = a.Codigos And b.Tabelas = 'SIGCDGCR' and b.contas = '] + lcpiclis + [']
	.poDatamgr.SqlExecute(lcQuery,[crAleCdGcr])	
	lcQuery = [Select a.Cgrus as Dopes, a.Dgrus as Descrs, 'SIGCDPRO' as Tabelas, ] + ;
		[FROM SigCdGrp a ] + ; 
		[Left Outer Join SigCdAle b On substring(b.Dopes,1,3) = a.Cgrus And b.Tabelas = 'SIGCDPRO' and b.contas = '] + lcpiclis + [']
	.poDatamgr.SqlExecute(lcQuery,[crAleCdPro])	
	lcQuery = [Select a.Dopps as Dopes, a.Dopps as Descrs, 'SIGCDOPD' as Tabelas, ] + ;
		[FROM SigCdOpd a ] + ; 
		[Left Outer Join SigCdAle b On b.Dopes = a.Dopps And b.Tabelas = 'SIGCDOPD' and b.contas = '] + lcpiclis + [']
	.poDatamgr.SqlExecute(lcQuery,[crAleCdOpd])
	lcQuery = [Select a.Dopes as Dopes, a.Dopes as Descrs, 'SIGOPOPE' as Tabelas, ] + ;
		[FROM SigOpOpe a ] + ; 
		[Left Outer Join SigCdAle b On b.Dopes = a.Dopes And b.Tabelas = 'SIGOPOPE' and b.contas = '] + lcpiclis + [']
	.poDatamgr.SqlExecute(lcQuery,[crAleOpOpe])
	Select Dopes, Padr(Descrs,60) as Descrs, Tabelas, inserirs, alterars, excluirs, baixas, prioridade, cast(mensagems as CHAR(200)) as Mensagems, datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
		From crAleCdOpe ;
	Select Dopes, Padr(Dopes + [ - ] + Descrs,60) as Descrs, Tabelas, inserirs, alterars, excluirs, baixas, prioridade, cast(mensagems as CHAR(200)) as Mensagems, datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
		from crAleCdGcr ;
	Select Dopes, Padr(Dopes + [ - ] + Descrs,60) as Descrs, Tabelas, inserirs, alterars, excluirs, baixas, prioridade, cast(mensagems as CHAR(200)) as Mensagems, datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
		from crAleCdPro	;
	Select Dopes, Padr(Descrs,60) as Descrs, Tabelas, inserirs, alterars, excluirs, baixas, prioridade, cast(mensagems as CHAR(200)) as Mensagems, datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;	
		from crAleCdOpd ;
	Select Dopes, Padr(Descrs,60) as Descrs, Tabelas, inserirs, alterars, excluirs, baixas, prioridade, cast(mensagems as CHAR(200)) as Mensagems, datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;	
	from crAleOpOpe Into Cursor crSigCdAle ReadWrite Order By Tabelas, Dopes
	Select crSigCdAle
	Thisform.grade_ale.column1.ControlSource = [crSigCdAle.Descrs]
	Thisform.grade_ale.column2.ControlSource = [crSigCdAle.Inserirs]
	Thisform.grade_ale.column3.ControlSource = [crSigCdAle.alterars]
	Thisform.grade_ale.column4.ControlSource = [crSigCdAle.excluirs]
	Thisform.grade_ale.column5.ControlSource = [crSigCdAle.baixas]
	Thisform.grade_ale.column6.ControlSource = [crSigCdAle.priors]
	Thisform.grade_ale.column7.ControlSource = [crSigCdAle.mensagems]
Select crSigCdAle
SELECT Dopes, Usuarios, Inserirs, Alterars, Excluirs, Baixas, Mensagems, Datas, Dtalts, Grupos, Pkchaves, Priors, Contas, Tabelas ;
	FROM crSigCdAle ;
SELECT crSigCdAle
SELECT crSigCdAle
thisform.podatamgr.SqlExecute([Delete FROM SigCdAle Where Contas = '] + thisform.iclis + ['])
	.poDataMgr.UpDate(1)
Select crSigCdAle

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formale.prg) - TRECHOS RELEVANTES PARA PASS SQL (963 linhas total):

*-- Linhas 320 a 338:
320:             .ColumnCount        = 7
321:             .RowHeight          = 22
322:             .RecordMark         = .F.
323:             .DeleteMark         = .F.
324:             .AllowAutoColumnFit = 2
325:             .ReadOnly           = .F.
326:             .FontName           = "Tahoma"
327:             .FontSize           = 8
328:         ENDWITH
329: 
330:         *-- Coluna 1: Descricao (TextBox ReadOnly)
331:         WITH loc_oGrid.Column1
332:             .Width    = 220
333:             .Movable  = .F.
334:             .Resizable = .F.
335:             .ReadOnly = .T.
336:             .AddObject("Text1", "TextBox")
337:             WITH .Text1
338:                 .BorderStyle = 0

*-- Linhas 424 a 454:
424:             .Header1.Caption      = "B"
425:             .Header1.Alignment    = 2
426:             .Header1.FontBold     = .T.
427:             .Header1.ToolTipText  = "Baixar"
428:         ENDWITH
429: 
430:         *-- Coluna 6: ComboBox Prioridade
431:         WITH loc_oGrid.Column6
432:             .Width     = 110
433:             .Movable   = .F.
434:             .Resizable = .F.
435:             .Sparse    = .F.
436:             .AddObject("Combo1", "ComboBox")
437:             WITH .Combo1
438:                 .RowSourceType    = 1
439:                 .RowSource        = "URGENTE,IMPORTANTE,NORMAL"
440:                 .Style            = 2
441:             ENDWITH
442:             .CurrentControl    = "Combo1"
443:             .Header1.Caption   = "Prioridade"
444:             .Header1.Alignment = 2
445:         ENDWITH
446: 
447:         *-- Coluna 7: EditBox Mensagem
448:         WITH loc_oGrid.Column7
449:             .Width     = 538
450:             .Movable   = .F.
451:             .Resizable = .F.
452:             .Sparse    = .F.
453:             .AddObject("EditBox1", "EditBox")
454:             WITH .EditBox1

*-- Linhas 569 a 594:
569:                 THIS.grd_4c_Dados.ColumnCount = 7
570:                 THIS.grd_4c_Dados.RecordSource = "crSigCdAle"
571: 
572:                 *-- ControlSource: checkbox cols apos CurrentControl ja definido em ConfigurarGrade
573:                 THIS.grd_4c_Dados.Column1.ControlSource = "crSigCdAle.Descrs"
574:                 THIS.grd_4c_Dados.Column2.ControlSource = "crSigCdAle.inserirs"
575:                 THIS.grd_4c_Dados.Column3.ControlSource = "crSigCdAle.alterars"
576:                 THIS.grd_4c_Dados.Column4.ControlSource = "crSigCdAle.excluirs"
577:                 THIS.grd_4c_Dados.Column5.ControlSource = "crSigCdAle.baixas"
578:                 THIS.grd_4c_Dados.Column6.ControlSource = "crSigCdAle.prioridade"
579:                 THIS.grd_4c_Dados.Column7.ControlSource = "crSigCdAle.mensagems"
580: 
581:                 *-- Reconfigurar headers apos RecordSource (VFP9 reseta captions)
582:                 THIS.grd_4c_Dados.Column1.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
583:                 THIS.grd_4c_Dados.Column2.Header1.Caption    = "I"
584:                 THIS.grd_4c_Dados.Column3.Header1.Caption    = "A"
585:                 THIS.grd_4c_Dados.Column4.Header1.Caption    = "E"
586:                 THIS.grd_4c_Dados.Column5.Header1.Caption    = "B"
587:                 THIS.grd_4c_Dados.Column6.Header1.Caption    = "Prioridade"
588:                 THIS.grd_4c_Dados.Column7.Header1.Caption    = "Mensagem"
589:                 THIS.grd_4c_Dados.Column2.Header1.Alignment  = 2
590:                 THIS.grd_4c_Dados.Column3.Header1.Alignment  = 2
591:                 THIS.grd_4c_Dados.Column4.Header1.Alignment  = 2
592:                 THIS.grd_4c_Dados.Column5.Header1.Alignment  = 2
593:                 THIS.grd_4c_Dados.Column6.Header1.Alignment  = 2
594:                 THIS.grd_4c_Dados.Column7.Header1.Alignment  = 2

*-- Linhas 635 a 653:
635:         TRY
636:             *-- Remover filtro para que SalvarAlertas processe todos os registros
637:             IF USED("crSigCdAle")
638:                 SELECT crSigCdAle
639:                 SET ORDER TO TAG Tabelas
640:                 SET KEY TO
641:             ENDIF
642: 
643:             IF THIS.this_oBusinessObject.SalvarAlertas(THIS.this_cPcEscolha)
644:                 THIS.Release()
645:             ENDIF
646:         CATCH TO loc_oErro
647:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
648:                     " PROC=" + loc_oErro.Procedure, "Erro ao confirmar")
649:         ENDTRY
650:     ENDPROC
651: 
652:     *--------------------------------------------------------------------------
653:     * BtnCancelarClick - Fecha o form sem salvar

*-- Linhas 717 a 735:
717:                 RETURN
718:             ENDIF
719: 
720:             SELECT crSigCdAle
721:             REPLACE inserirs WITH 1, alterars WITH 1, excluirs WITH 1, baixas WITH 1 ;
722:                 IN crSigCdAle
723:             THIS.grd_4c_Dados.Refresh()
724:         CATCH TO loc_oErro
725:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
726:                     " PROC=" + loc_oErro.Procedure, "Erro ao ativar alertas")
727:         ENDTRY
728:     ENDPROC
729: 
730:     *--------------------------------------------------------------------------
731:     * BtnAlterarClick - Recarrega alertas do banco descartando edicoes em memoria
732:     * Semantica operacional: reverte alteracoes nao confirmadas + reforca foco
733:     * no grid para permitir edicao dos checkboxes/combobox/editbox
734:     *--------------------------------------------------------------------------
735:     PROCEDURE BtnAlterarClick()

*-- Linhas 765 a 783:
765:                 RETURN
766:             ENDIF
767: 
768:             SELECT crSigCdAle
769:             loc_cDesc = ALLTRIM(NVL(crSigCdAle.Descrs, ""))
770:             loc_cMsg  = ALLTRIM(NVL(crSigCdAle.Mensagems, ""))
771:             loc_nPri  = NVL(crSigCdAle.priors, 0)
772: 
773:             DO CASE
774:                 CASE loc_nPri = 1
775:                     loc_cPri = "URGENTE"
776:                 CASE loc_nPri = 2
777:                     loc_cPri = "IMPORTANTE"
778:                 CASE loc_nPri = 3
779:                     loc_cPri = "NORMAL"
780:                 OTHERWISE
781:                     loc_cPri = "N/D"
782:             ENDCASE
783: 

*-- Linhas 815 a 833:
815:                 RETURN
816:             ENDIF
817: 
818:             SELECT crSigCdAle
819:             REPLACE inserirs WITH 0, alterars WITH 0, excluirs WITH 0, baixas WITH 0 ;
820:                 IN crSigCdAle
821:             THIS.grd_4c_Dados.Refresh()
822:         CATCH TO loc_oErro
823:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
824:                     " PROC=" + loc_oErro.Procedure, "Erro ao desativar alertas")
825:         ENDTRY
826:     ENDPROC
827: 
828:     *--------------------------------------------------------------------------
829:     * CarregarLista - Recarrega dados do grid (wrapper para CarregarAlertas)
830:     *--------------------------------------------------------------------------
831:     PROCEDURE CarregarLista()
832:         LOCAL loc_lResultado, loc_oErro
833:         loc_lResultado = .F.

*-- Linhas 908 a 926:
908: 
909:         TRY
910:             IF USED("crSigCdAle")
911:                 SELECT crSigCdAle
912:                 ZAP
913:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
914:                     THIS.grd_4c_Dados.Refresh()
915:                 ENDIF
916:             ENDIF
917:             THIS.this_oBusinessObject.LimparDados()
918:         CATCH TO loc_oErro
919:             MsgErro(loc_oErro.Message, "Erro ao limpar")
920:         ENDTRY
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme disponibilidade
925:     * Form OPERACIONAL: sem modos CRUD; Confirmar depende da conta informada
926:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\aleBO.prg):
*==============================================================================
* ALEBO.PRG
* Business Object para Configuracao de Alertas por Conta (SigCdAle)
*
* Tabela Principal : SigCdAle - Alertas configurados por conta/operacao
*                    (pkchaves C(20) PK, dopes C, Tabelas C, inserirs N, alterars N,
*                     excluirs N, baixas N, priors N, mensagems text, datas T, dtalts T,
*                     contas C, grupos C, usuarios C)
*
* Logica: Form OPERACIONAL que configura quais alertas uma conta recebe
*         para cada tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE).
*         Confirmar = DELETE todos os alertas da conta + re-INSERT apenas registros com
*         pelo menos um flag ativo (inserirs<>0 OR alterars<>0 OR excluirs<>0 OR baixas<>0).
*         O grid exibe uniao das 5 tabelas de referencia com LEFT JOIN em SigCdAle.
*==============================================================================

DEFINE CLASS aleBO AS BusinessBase

    *-- Identificacao da conta (parametro recebido pelo form)
    this_cContas              = ""    && IClis da conta selecionada (FK SigCdCli)

    *-- Campos da SigCdAle (registro atual)
    this_cDopes               = ""    && Codigo da operacao/grupo/produto (FK variavel)
    this_cTabelas             = ""    && Tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE)
    this_nInserirs            = 0     && Flag permissao Inserir (0=nao, 1=sim)
    this_nAlterars            = 0     && Flag permissao Alterar (0=nao, 1=sim)
    this_nExcluirs            = 0     && Flag permissao Excluir (0=nao, 1=sim)
    this_nBaixas              = 0     && Flag permissao Baixar  (0=nao, 1=sim)
    this_nPriors              = 0     && Prioridade numerica (0=NORMAL, 1=URGENTE, 2=IMPORTANTE)
    this_cMensagems           = ""    && Mensagem de alerta (varchar/text)
    this_dDatas               = {}    && Data/hora de criacao
    this_dDtalts              = {}    && Data/hora de ultima alteracao
    this_cGrupos              = ""    && Grupo associado
    this_cPkChaves            = ""    && Chave primaria unica gerada por fUniqueIds()
    this_cUsuarios            = ""    && Usuario que realizou a configuracao

    *-- Descricao para exibicao (coluna Descrs do cursor, nao persiste em SigCdAle)
    this_cDescrs              = ""    && Descricao derivada da tabela de referencia

    *-- Modo de operacao herdado do form pai (INSERIR/ALTERAR)
    this_cPcEscolha           = ""    && Modo vindo de parentform.pcescolha

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAle"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados de uma linha do cursor crSigCdAle
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,    "C")
                THIS.this_cTabelas    = TratarNulo(Tabelas,   "C")
                THIS.this_nInserirs   = NVL(inserirs,  0)
                THIS.this_nAlterars   = NVL(alterars,  0)
                THIS.this_nExcluirs   = NVL(excluirs,  0)
                THIS.this_nBaixas     = NVL(baixas,    0)
                THIS.this_nPriors     = NVL(priors,    0)
                THIS.this_cMensagems  = TratarNulo(mensagems, "C")
                THIS.this_cGrupos     = TratarNulo(grupos,    "C")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,  "C")
                THIS.this_cContas     = TratarNulo(contas,    "C")
                THIS.this_cUsuarios   = TratarNulo(usuarios,  "C")

                IF VARTYPE(datas) = "T" OR VARTYPE(datas) = "D"
                    THIS.this_dDatas  = NVL(datas,  {})
                ELSE
                    THIS.this_dDatas  = {}
                ENDIF

                IF VARTYPE(dtalts) = "T" OR VARTYPE(dtalts) = "D"
                    THIS.this_dDtalts = NVL(dtalts, {})
                ELSE
                    THIS.this_dDtalts = {}
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para estado vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cDopes      = ""
        THIS.this_cDescrs     = ""
        THIS.this_cTabelas    = ""
        THIS.this_nInserirs   = 0
        THIS.this_nAlterars   = 0
        THIS.this_nExcluirs   = 0
        THIS.this_nBaixas     = 0
        THIS.this_nPriors     = 0
        THIS.this_cMensagems  = ""
        THIS.this_cGrupos     = ""
        THIS.this_cPkChaves   = ""
        THIS.this_cUsuarios   = ""
        THIS.this_dDatas      = {}
        THIS.this_dDtalts     = {}
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertas - Popula os 5 cursores de referencia com LEFT JOIN SigCdAle
    * e une em crSigCdAle com INDEX ON Tabelas TAG Tabelas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertas(par_cContas)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_cContasEsc
        loc_lResultado = .F.
        THIS.this_cContas = ALLTRIM(NVL(par_cContas, ""))

        TRY
            loc_cContasEsc = EscaparSQL(THIS.this_cContas)

            *-- Movimentacao de Estoque (SigCdOpe)
            loc_cSQL = "SELECT OPE.dopes, OPE.Dopes AS Descrs, 'SIGCDOPE' AS Tabelas, " + ;
                "CASE WHEN ALE.inserirs IS NULL THEN 0 ELSE ALE.inserirs END inserirs, " + ;
                "CASE WHEN ALE.alterars IS NULL THEN 0 ELSE ALE.alterars END alterars, " + ;
                "CASE WHEN ALE.excluirs IS NULL THEN 0 ELSE ALE.excluirs END excluirs, " + ;
                "CASE WHEN ALE.baixas IS NULL THEN 0 ELSE ALE.baixas END baixas, " + ;
                "CASE WHEN ALE.priors = 1 THEN 'URGENTE' WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN ALE.mensagems IS NULL THEN '' ELSE ALE.mensagems END mensagems, " + ;
                "ALE.datas, ALE.dtalts, ALE.contas, " + ;
                "CASE WHEN ALE.grupos IS NULL THEN '' ELSE ALE.grupos END grupos, " + ;
                "CASE WHEN ALE.pkchaves IS NULL THEN '' ELSE ALE.pkchaves END pkchaves, " + ;
                "CASE WHEN ALE.priors IS NULL THEN 0 ELSE ALE.priors END priors, " + ;
                "CASE WHEN ALE.usuarios IS NULL THEN '' ELSE ALE.usuarios END usuarios " + ;
                "FROM SigCdOpe OPE " + ;
                "INNER JOIN SigOpCdc CDC ON CDC.Dopes = OPE.Dopes AND CDC.OpeInatvs = 0 " + ;
                "LEFT OUTER JOIN SigCdAle ALE ON OPE.Dopes = ALE.dopes " + ;
                "AND ALE.Tabelas = 'SIGCDOPE' AND ALE.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpe")

            *-- Grupo de Contas (SigCdGcr)
            loc_cSQL = "SELECT a.Codigos AS Dopes, a.Descrs, 'SIGCDGCR' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGcr a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 10) = a.Codigos " + ;
                "AND b.Tabelas = 'SIGCDGCR' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleGcr")

            *-- Grupo de Produtos (SigCdGrp -> SIGCDPRO)
            loc_cSQL = "SELECT a.Cgrus AS Dopes, a.Dgrus AS Descrs, 'SIGCDPRO' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGrp a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 3) = a.Cgrus " + ;
                "AND b.Tabelas = 'SIGCDPRO' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AlePro")

            *-- Movimentacao de Producao (SigCdOpd -> SIGCDOPD)
            loc_cSQL = "SELECT a.Dopps AS Dopes, a.Dopps AS Descrs, 'SIGCDOPD' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdOpd a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopps " + ;
                "AND b.Tabelas = 'SIGCDOPD' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpd")

            *-- Movimentacao Financeira (SigOpOpe -> SIGOPOPE)
            loc_cSQL = "SELECT a.Dopes AS Dopes, a.Dopes AS Descrs, 'SIGOPOPE' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigOpOpe a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopes " + ;
                "AND b.Tabelas = 'SIGOPOPE' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpOpe")

            *-- Unir os 5 cursores em crSigCdAle com estrutura identica
            IF USED("crSigCdAle")
                TABLEREVERT(.T., "crSigCdAle")
                USE IN crSigCdAle
            ENDIF

            SET NULL ON
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpe ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleGcr ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AlePro ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpd ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpOpe ;
            INTO CURSOR crSigCdAle READWRITE ORDER BY Tabelas, Dopes
            SET NULL OFF

            SELECT crSigCdAle
            INDEX ON Tabelas TAG Tabelas
            SET ORDER TO TAG Tabelas
            SET KEY TO "SIGCDOPE"
            GO TOP

            *-- Fechar cursores intermediarios
            IF USED("cursor_4c_AleOpe")
                USE IN cursor_4c_AleOpe
            ENDIF
            IF USED("cursor_4c_AleGcr")
                USE IN cursor_4c_AleGcr
            ENDIF
            IF USED("cursor_4c_AlePro")
                USE IN cursor_4c_AlePro
            ENDIF
            IF USED("cursor_4c_AleOpd")
                USE IN cursor_4c_AleOpd
            ENDIF
            IF USED("cursor_4c_AleOpOpe")
                USE IN cursor_4c_AleOpOpe
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar alertas")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlertas - Salva configuracao de alertas da conta:
    *   1. Filtra crSigCdAle para registros com ao menos 1 flag ativo
    *   2. DELETE todos os alertas da conta no SQL Server
    *   3. Re-INSERT cada registro filtrado (INSERT direto via SQLEXEC)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlertas(par_cPcEscolha)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL
        LOCAL loc_cDopes, loc_cTabelas, loc_nInserirs, loc_nAlterars
        LOCAL loc_nExcluirs, loc_nBaixas, loc_nPriors, loc_cMensagems
        LOCAL loc_cGrupos, loc_cPkChaves, loc_cUsuarios
        LOCAL loc_dDatas, loc_cContasEsc, loc_cPcEscolha
        loc_lResultado = .F.
        loc_cPcEscolha = UPPER(ALLTRIM(NVL(par_cPcEscolha, "")))

        TRY
            IF !USED("crSigCdAle")
                THIS.this_cMensagemErro = "Cursor de alertas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgAviso(THIS.this_cMensagemErro, "Aviso")
            ELSE
                loc_cContasEsc = EscaparSQL(THIS.this_cContas)

                *-- Seleciona apenas registros com pelo menos um flag ativo
                SELECT Dopes, Tabelas, inserirs, alterars, excluirs, baixas, ;
                       prioridade, CAST(Mensagems AS CHAR(200)) AS Mensagems, ;
                       datas, dtalts, grupos, pkchaves, priors, usuarios ;
                    FROM crSigCdAle ;
                    WHERE inserirs <> 0 OR alterars <> 0 OR excluirs <> 0 OR baixas <> 0 ;
                    INTO CURSOR cursor_4c_AleSave READWRITE

                SELECT cursor_4c_AleSave
                GO TOP

                *-- DELETE todos os alertas existentes desta conta
                loc_cSQL = "DELETE FROM SigCdAle WHERE Contas = " + loc_cContasEsc
                SQLEXEC(gnConnHandle, loc_cSQL)

                *-- Re-INSERT cada registro ativo
                LOCAL loc_lErroInsert
                loc_lErroInsert = .F.
                SCAN
                    loc_cDopes     = ALLTRIM(NVL(Dopes,    ""))
                    loc_cTabelas   = ALLTRIM(NVL(Tabelas,  ""))
                    loc_nInserirs  = NVL(inserirs, 0)
                    loc_nAlterars  = NVL(alterars, 0)
                    loc_nExcluirs  = NVL(excluirs, 0)
                    loc_nBaixas    = NVL(baixas,   0)
                    loc_nPriors    = NVL(priors,   0)
                    loc_cMensagems = ALLTRIM(NVL(Mensagems, ""))
                    loc_cGrupos    = ALLTRIM(NVL(grupos,   ""))
                    loc_cUsuarios  = gc_4c_UsuarioLogado
                    loc_cPkChaves  = fUniqueIds()

                    IF loc_cPcEscolha = "INSERIR"
                        loc_dDatas    = GETDATE()
                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cDopes)     + ", " + ;
                            EscaparSQL(loc_cTabelas)   + ", " + ;
                            FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                            EscaparSQL(loc_cMensagems) + ", " + ;
                            "GETDATE(), "               + ;
                            EscaparSQL(THIS.this_cContas) + ", " + ;
                            EscaparSQL(loc_cGrupos)    + ", " + ;
                            EscaparSQL(loc_cPkChaves)  + ", " + ;
                            EscaparSQL(loc_cUsuarios)  + ")"
                    ELSE
                        *-- ALTERAR: preserva datas original se existir, gera dtalts
                        IF VARTYPE(datas) = "T" AND !EMPTY(datas)
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                FormatarDataSQL(datas)     + ", " + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ELSE
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                "GETDATE(), "               + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ENDIF
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        THIS.this_cMensagemErro = "Erro ao inserir alerta para " + loc_cDopes
                        MsgErro(THIS.this_cMensagemErro, "Erro ao salvar")
                        loc_lErroInsert = .T.
                        EXIT
                    ELSE
                        *-- Registra auditoria de cada linha inserida no batch
                        THIS.this_cPkChaves = loc_cPkChaves
                        THIS.RegistrarAuditoria(IIF(loc_cPcEscolha = "INSERIR", "INSERT", "UPDATE"))
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_AleSave")
                    USE IN cursor_4c_AleSave
                ENDIF

                IF !loc_lErroInsert
                    SQLEXEC(gnConnHandle, "COMMIT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao salvar alertas")
            IF USED("cursor_4c_AleSave")
                USE IN cursor_4c_AleSave
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigCdAle
    * Usa as propriedades this_* previamente populadas (via FormParaBO ou setter)
    * Gera pkchaves via fUniqueIds(), datas via GETDATE()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cContas)
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o informada"
            ELSE
                IF EMPTY(THIS.this_cDopes)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
                ELSE
                    IF EMPTY(THIS.this_cTabelas)
                        THIS.this_cMensagemErro = "Tabela de refer" + CHR(234) + "ncia n" + CHR(227) + "o informada"
                    ELSE
                        THIS.this_cPkChaves = fUniqueIds()
                        THIS.this_cUsuarios = gc_4c_UsuarioLogado

                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTabelas))   + ", " + ;
                            FormatarNumeroSQL(THIS.this_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nPriors,   0) + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                            "GETDATE(), " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cContas))    + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cGrupos))    + ", " + ;
                            EscaparSQL(THIS.this_cPkChaves)           + ", " + ;
                            EscaparSQL(THIS.this_cUsuarios)           + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nRet < 0
                            THIS.this_cMensagemErro = "Falha ao inserir alerta no SQL Server"
                        ELSE
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigCdAle localizado por pkchaves
    * Atualiza flags/prioridade/mensagem/grupos e seta dtalts via GETDATE()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (pkchaves) n" + CHR(227) + "o informada"
            ELSE
                THIS.this_cUsuarios = gc_4c_UsuarioLogado

                loc_cSQL = "UPDATE SigCdAle SET " + ;
                    "dopes = "     + EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                    "Tabelas = "   + EscaparSQL(ALLTRIM(THIS.this_cTabelas))   + ", " + ;
                    "inserirs = "  + FormatarNumeroSQL(THIS.this_nInserirs, 0) + ", " + ;
                    "alterars = "  + FormatarNumeroSQL(THIS.this_nAlterars, 0) + ", " + ;
                    "excluirs = "  + FormatarNumeroSQL(THIS.this_nExcluirs, 0) + ", " + ;
                    "baixas = "    + FormatarNumeroSQL(THIS.this_nBaixas,   0) + ", " + ;
                    "priors = "    + FormatarNumeroSQL(THIS.this_nPriors,   0) + ", " + ;
                    "mensagems = " + EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                    "dtalts = GETDATE(), " + ;
                    "contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas))    + ", " + ;
                    "grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos))    + ", " + ;
                    "usuarios = "  + EscaparSQL(THIS.this_cUsuarios) + " " + ;
                    "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    THIS.this_cMensagemErro = "Falha ao atualizar alerta no SQL Server"
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro de SigCdAle por pkchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (pkchaves) n" + CHR(227) + "o informada"
            ELSE
                loc_cSQL = "DELETE FROM SigCdAle WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    THIS.this_cMensagemErro = "Falha ao excluir alerta no SQL Server"
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorTabela - Aplica SET KEY TO na tabela de referencia selecionada
    * par_nOpcao: 1=SIGCDOPE, 2=SIGCDGCR, 3=SIGCDOPD, 4=SIGCDPRO, 5=SIGOPOPE
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorTabela(par_nOpcao)
        LOCAL loc_cChave, loc_oErro
        DO CASE
            CASE par_nOpcao = 1
                loc_cChave = "SIGCDOPE"
            CASE par_nOpcao = 2
                loc_cChave = "SIGCDGCR"
            CASE par_nOpcao = 3
                loc_cChave = "SIGCDOPD"
            CASE par_nOpcao = 4
                loc_cChave = "SIGCDPRO"
            OTHERWISE
                loc_cChave = "SIGOPOPE"
        ENDCASE

        TRY
            IF USED("crSigCdAle")
                SELECT crSigCdAle
                SET ORDER TO TAG Tabelas
                SET KEY TO loc_cChave
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

