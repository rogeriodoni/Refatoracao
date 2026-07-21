# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, NOPS, SERVICOS, CATS, EMPDNPS, CMATS, TPOPS, RCL

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
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = "TmpDistrib.Dpros"
  ControlSource = "TmpDistrib.DescOrig"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TmpDistrib.DescDest"
SELECT SUM(qtds) as qtds, SUM(qtds * fators) as vrtots, SUM(qtds * fators) as vrpags from tmpDistrib into cursor curt
SELECT tmpDistrib
lcQuery = [Select a.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, b.nOps, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, b.CDescs, d.Dpros, ] +;
			[from SigPdMvf a inner join SigCdNei b on a.Empdnps = b.Empdnps ] +;
			[inner join SigCdNec c on a.Empdnps = c.Empdnps ] +;
			[inner join SigCdPro d on b.Cmats = d.Cpros ] +;
			[inner join SigCdCli e on c.Contaos = e.Iclis ] +;
			[inner join SigCdCli f on c.Contads = f.Iclis ] +;			
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpDistrib') < 1)
Select xMfas 
	lcQuery = [Select b.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, b.CDescs, d.dpros, ] +;
				[from SigPdMvf a inner join SigCdNei b on a.Empdnps = b.Empdnps ] +;
				[inner join SigCdNec c on a.Empdnps = c.Empdnps ] +;
				[inner join SigCdPro d on b.Cmats = d.Cpros ] +;
				[inner join SigCdCli e on c.Contaos = e.Iclis ] +;
				[inner join SigCdCli f on c.Contads = f.Iclis ] +;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas4') < 1)
	Select LocalMfas4
			Insert into TmpDistrib from memvar
Select TmpDistrib
	.Column1.ControlSource   = 'TmpDistrib.Empdnps'
	.Column2.ControlSource   = 'TmpDistrib.Grupoos'
	.Column7.ControlSource   = 'TmpDistrib.Contaos'
	.Column8.ControlSource   = 'TmpDistrib.Grupods'
	.Column9.ControlSource   = 'TmpDistrib.Contads'			
	.Column3.ControlSource   = 'TmpDistrib.cMats'
	.Column4.ControlSource   = 'TmpDistrib.Qtds'
	.Column5.ControlSource   = 'TmpDistrib.Fators'
	.Column6.ControlSource   = 'TmpDistrib.Qtds * TmpDistrib.Fators'
Select xnensi
&&			lcSql = [Select nops From SigCdNei Where cmats = ']+TmpDistrib.cmats+[' and tpops = ']+TmpDistrib.tpOps +[']
&&			ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalNei')
&&			SELECT LocalNei

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg) - TRECHOS RELEVANTES PARA PASS SQL (1364 linhas total):

*-- Linhas 337 a 376:
337:     *==========================================================================
338:     * ConfigurarGrade - Grid read-only 9 colunas exibindo TmpDistrib
339:     * Ordem visual das colunas: Operacao|Grupo|Conta|Grupo|Conta|Servico|Qtde|Valor|Total
340:     * ControlSources definidos em ConfigurarRecordSourceGrade apos popular TmpDistrib
341:     *==========================================================================
342:     PROTECTED PROCEDURE ConfigurarGrade()
343:         LOCAL loc_oErro, loc_oGrd
344: 
345:         TRY
346:             THIS.AddObject("grd_4c_Dados", "Grid")
347:             loc_oGrd = THIS.grd_4c_Dados
348:             WITH loc_oGrd
349:                 .Visible              = .T.
350:                 .Top                  = 197
351:                 .Left                 = 12
352:                 .Width                = 976
353:                 .Height               = 325
354:                 .ColumnCount          = 9
355:                 .FontName             = "Courier New"
356:                 .FontSize             = 8
357:                 .RowHeight            = 17
358:                 .ScrollBars           = 2
359:                 .ReadOnly             = .F.
360:                 .RecordMark           = .F.
361:                 .DeleteMark           = .F.
362:                 .GridLineColor        = RGB(238, 238, 238)
363:                 .HighlightStyle       = 2
364:                 .HighlightBackColor   = RGB(255, 255, 255)
365:                 .HighlightForeColor   = RGB(15, 41, 104)
366:                 .Panel                = 1
367:                 .RecordSourceType     = 1
368:             ENDWITH
369: 
370:             *-- Column1: Operacao (Empdnps) - ColumnOrder=1, Width=241
371:             WITH loc_oGrd.Column1
372:                 .ColumnOrder = 1
373:                 .Width       = 241
374:                 .Movable     = .F.
375:                 .Resizable   = .F.
376:                 .ReadOnly    = .T.

*-- Linhas 758 a 808:
758:             ENDIF
759: 
760:             loc_oGrd = THIS.grd_4c_Dados
761:             SELECT TmpDistrib
762:             GO TOP
763: 
764:             WITH loc_oGrd
765:                 .ColumnCount = 9
766:                 .RecordSource = "TmpDistrib"
767:                 .Column1.ControlSource = "TmpDistrib.Empdnps"
768:                 .Column2.ControlSource = "TmpDistrib.Grupoos"
769:                 .Column3.ControlSource = "TmpDistrib.Contaos"
770:                 .Column4.ControlSource = "TmpDistrib.Grupods"
771:                 .Column5.ControlSource = "TmpDistrib.Contads"
772:                 .Column6.ControlSource = "TmpDistrib.Cmats"
773:                 .Column7.ControlSource = "TmpDistrib.Qtds"
774:                 .Column8.ControlSource = "TmpDistrib.Fators"
775:                 .Column9.ControlSource = "TmpDistrib.Qtds * TmpDistrib.Fators"
776:                 .SetAll("DynamicForeColor", "IIF(TmpDistrib.Retrabs, RGB(255,0,0), RGB(0,0,0))", "Column")
777:                 *-- Redefine headers apos RecordSource (VFP9 reseta ao mudar RecordSource)
778:                 .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
779:                 .Column2.Header1.Caption = "Grupo"
780:                 .Column3.Header1.Caption = "Conta"
781:                 .Column4.Header1.Caption = "Grupo"
782:                 .Column5.Header1.Caption = "Conta"
783:                 .Column6.Header1.Caption = "Servi" + CHR(231) + "o"
784:                 .Column7.Header1.Caption = "Qtde"
785:                 .Column8.Header1.Caption = "Valor"
786:                 .Column9.Header1.Caption = "Total"
787:                 .Refresh()
788:             ENDWITH
789: 
790:             *-- Vincula campos de descricao ao cursor TmpDistrib
791:             THIS.txt_4c_Descr.ControlSource   = "TmpDistrib.Dpros"
792:             THIS.txt_4c_DescOrig.ControlSource = "TmpDistrib.DescOrig"
793:             THIS.txt_4c_DescDest.ControlSource = "TmpDistrib.DescDest"
794: 
795:         CATCH TO loc_oErro
796:             MsgErro(loc_oErro.Message, "Erro")
797:         ENDTRY
798:     ENDPROC
799: 
800:     *==========================================================================
801:     * GrdDadosAfterRowColChange - Atualiza campos descricao ao mudar linha
802:     * BINDEVENT requer LPARAMETERS (AfterRowColChange passa nColIndex como arg)
803:     *==========================================================================
804:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
805:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
806:             THIS.txt_4c_Descr.Refresh()
807:         ENDIF
808:         IF VARTYPE(THIS.txt_4c_DescOrig) = "O"

*-- Linhas 995 a 1013:
995: 
996:         TRY
997:             IF USED("tmpnens") AND VARTYPE(THIS.cnt_4c_Operacao) = "O"
998:                 SELECT tmpnens
999:                 GO TOP
1000:                 IF !EOF()
1001:                     THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = ALLTRIM(NVL(tmpnens.emps,  ""))
1002:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(NVL(tmpnens.dopps, ""))
1003:                     THIS.cnt_4c_Operacao.txt_4c_Numps.Value    = NVL(tmpnens.numps, 0)
1004:                     THIS.cnt_4c_Operacao.txt_4c_Empresa.Refresh()
1005:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Refresh()
1006:                     THIS.cnt_4c_Operacao.txt_4c_Numps.Refresh()
1007:                 ENDIF
1008:             ENDIF
1009: 
1010:         CATCH TO loc_oErro
1011:             MsgErro(loc_oErro.Message, "Erro")
1012:         ENDTRY
1013:     ENDPROC

*-- Linhas 1056 a 1074:
1056:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1057:                 THIS.grd_4c_Dados.Refresh()
1058:                 IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
1059:                     SELECT TmpDistrib
1060:                     GO TOP
1061:                     THIS.grd_4c_Dados.SetFocus()
1062:                 ENDIF
1063:             ENDIF
1064: 
1065:         CATCH TO loc_oErro
1066:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1067:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.BtnVisualizarClick")
1068:         ENDTRY
1069:     ENDPROC
1070: 
1071:     *==========================================================================
1072:     * BtnIncluirClick - Confirma a inclusao dos servicos exibidos no grid
1073:     * (persiste TmpDistrib no cursor xnensi do form pai, seguindo o padrao
1074:     * original de ok.Click do SIGPRSER). Fluxo equivale a "Incluir/Confirmar

*-- Linhas 1136 a 1167:
1136:                 RETURN
1137:             ENDIF
1138: 
1139:             SELECT TmpDistrib
1140:             IF EOF() OR BOF()
1141:                 GO TOP
1142:             ENDIF
1143: 
1144:             loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do servi" + CHR(231) + ;
1145:                                         "o selecionado do lote atual?", ;
1146:                                         "Confirma" + CHR(231) + CHR(227) + "o")
1147:             IF !loc_lConfirmar
1148:                 RETURN
1149:             ENDIF
1150: 
1151:             DELETE
1152:             SET DELETED ON
1153:             IF !EOF()
1154:                 SKIP
1155:             ENDIF
1156:             IF EOF()
1157:                 GO BOTT
1158:             ENDIF
1159: 
1160:             THIS.Acumular()
1161:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1162:                 THIS.grd_4c_Dados.Refresh()
1163:             ENDIF
1164: 
1165:         CATCH TO loc_oErro
1166:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1167:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.BtnExcluirClick")

*-- Linhas 1182 a 1200:
1182:                 THIS.this_oParentForm.Enabled = .T.
1183:                 *-- Navega xnensi para o fim (padrao legado apos fechar popup)
1184:                 IF USED("xnensi")
1185:                     SELECT xnensi
1186:                     GO BOTT
1187:                 ENDIF
1188:                 THIS.this_oParentForm.Refresh()
1189:             ENDIF
1190: 
1191:         CATCH TO loc_oErro
1192:             MsgErro(loc_oErro.Message, "Erro")
1193:         ENDTRY
1194: 
1195:         THIS.Release()
1196:     ENDPROC
1197: 
1198:     *==========================================================================
1199:     * CarregarLista - Compatibilidade com pipeline; delega a CarregarDados
1200:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SigPrSerBO.prg):
*==============================================================================
* SigPrSerBO.prg - Business Object: Servi?os Lan?ados
* Tipo: OPERACIONAL (somente leitura - popup filho de form de processamento)
* Tabelas: SigPdMvf, SigCdNei, SigCdNec, SigCdPro, SigCdCli
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *-- Identifica??o da entidade
    this_cTabela        = "SigCdNei"
    this_cCampoChave    = "cidchaves"

    *-- Chave prim?ria composta (char(20)) do registro corrente em SigCdNei
    this_cCidchaves     = ""

    *-- Dados da opera??o pai (exibidos no container Opera??o)
    this_cEmpdnps       = ""  && char(33) - chave composta emp+op+num
    this_cEmps          = ""  && char(3)  - empresa
    this_nNumps         = 0   && numeric(10,0) - n?mero do processamento
    this_cDopps         = ""  && char(20) - descri??o da opera??o

    *-- Campos do registro corrente do grid (TmpDistrib)
    this_cGrupoos       = ""  && char(10) - grupo de origem (SigCdNec)
    this_cContaos       = ""  && char(10) - conta de origem (SigCdNec)
    this_cGrupods       = ""  && char(10) - grupo de destino (SigCdNec)
    this_cContads       = ""  && char(10) - conta de destino (SigCdNec)
    this_nNops          = 0   && numeric(10,0) - n?mero da opera??o (SigCdNei)
    this_cCmats         = ""  && char(14) - c?digo do material/servi?o (SigCdNei)
    this_nFators        = 0   && numeric(7,4) - fator unit?rio (SigCdNei)
    this_nQtds          = 0   && numeric(9,3) - quantidade (SigCdNei)
    this_cCretrabs      = ""  && char(6) - c?digo retrabalho (SigCdNei)
    this_lRetrabs       = .F. && bit - flag retrabalho (SigCdNec)
    this_cCdescs        = ""  && char(40) - descri??o complementar (SigCdNei)
    this_cDpros         = ""  && char(?) - descri??o do produto/servi?o (SigCdPro)
    this_cDescOrig      = ""  && char(60) - descri??o conta origem (SigCdCli.Rclis)
    this_cDescDest      = ""  && char(60) - descri??o conta destino (SigCdCli.Rclis)

    *-- Totais acumulados do grid
    this_nQtdTotal      = 0   && SUM(qtds)
    this_nValTotal      = 0   && SUM(qtds * fators)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()

        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "cidchaves"
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicos(par_nNops)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro
        loc_lSucesso = .F.
        loc_nNops    = IIF(VARTYPE(par_nNops) = "N", par_nNops, 0)

        TRY
            *-- Cursor placeholder (estrutura identica ao SQLEXEC)
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- SELECT base com where 0=1 para criar estrutura
            loc_cSQL = "SELECT a.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                       "b.nOps, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                       "b.CDescs, d.Dpros, " + ;
                       "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                       "FROM SigPdMvf a " + ;
                       "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                       "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                       "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                       "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                       "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                       " AND b.servicos = 1 AND b.Cats <> ''"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp") < 1
                THIS.this_cMensagemErro = "Falha ao carregar servi" + CHR(231) + CHR(245) + "os lan" + CHR(231) + "ados."
            ELSE
                SELECT TmpDistrib
                ZAP
                APPEND FROM DBF("cursor_4c_ServicosTmp")
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF
                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicosDeXMfas(par_cCursorXMfas)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cCursorXMfas) = "C" AND !EMPTY(par_cCursorXMfas), par_cCursorXMfas, "xMfas")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            *-- Criar/recriar cursor TmpDistrib
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- Percorre fases do cursor xMfas (mesmo padr?o do legado)
            SELECT (loc_cAlias)
            SCAN
                loc_nNops = Nops

                loc_cSQL = "SELECT b.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                           "b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                           "b.CDescs, d.dpros, " + ;
                           "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                           "FROM SigPdMvf a " + ;
                           "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                           "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                           "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                           "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                           "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                           "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                           " AND b.servicos = 1 AND b.Cats <> ''"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMFas4") >= 1
                    SELECT cursor_4c_LocalMFas4
                    SCAN
                        SCATTER MEMO MEMVAR
                        SELECT TmpDistrib
                        INSERT INTO TmpDistrib FROM MEMVAR
                    ENDSCAN
                    IF USED("cursor_4c_LocalMFas4")
                        USE IN cursor_4c_LocalMFas4
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Acumular()
    *--------------------------------------------------------------------------
        LOCAL loc_nQtdTotal, loc_nValTotal, loc_oErro
        loc_nQtdTotal = 0
        loc_nValTotal = 0

        TRY
            IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
                SELECT SUM(Qtds) AS loc_nQtd, SUM(Qtds * Fators) AS loc_nVal ;
                    FROM TmpDistrib ;
                    INTO CURSOR cursor_4c_Acumulado READWRITE
                IF USED("cursor_4c_Acumulado")
                    SELECT cursor_4c_Acumulado
                    loc_nQtdTotal = NVL(loc_nQtd, 0)
                    loc_nValTotal = NVL(loc_nVal, 0)
                    USE IN cursor_4c_Acumulado
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.this_nQtdTotal = loc_nQtdTotal
        THIS.this_nValTotal = loc_nValTotal
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorAlias)
    *--------------------------------------------------------------------------
        LOCAL loc_cAlias
        loc_cAlias = IIF(VARTYPE(par_cCursorAlias) = "C" AND !EMPTY(par_cCursorAlias), par_cCursorAlias, "TmpDistrib")

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cEmpdnps  = TratarNulo(Empdnps,  "C")
        THIS.this_cGrupoos  = TratarNulo(Grupoos,  "C")
        THIS.this_cContaos  = TratarNulo(Contaos,  "C")
        THIS.this_cGrupods  = TratarNulo(Grupods,  "C")
        THIS.this_cContads  = TratarNulo(Contads,  "C")
        THIS.this_nNops     = TratarNulo(Nops,     "N")
        THIS.this_cCmats    = TratarNulo(cMats,    "C")
        THIS.this_nFators   = TratarNulo(Fators,   "N")
        THIS.this_nQtds     = TratarNulo(Qtds,     "N")
        THIS.this_cCretrabs = TratarNulo(Cretrabs, "C")
        IF VARTYPE(Retrabs) = "L"
            THIS.this_lRetrabs = Retrabs
        ELSE
            THIS.this_lRetrabs = (NVL(Retrabs, 0) = 1)
        ENDIF
        THIS.this_cCdescs   = TratarNulo(CDescs,   "C")
        THIS.this_cDpros    = TratarNulo(Dpros,    "C")
        THIS.this_cDescOrig = TratarNulo(DescOrig, "C")
        THIS.this_cDescDest = TratarNulo(DescDest, "C")

        *-- Chave prim?ria opcional (SigCdNei.cidchaves) quando presente no cursor
        IF TYPE(loc_cAlias + ".Cidchaves") != "U"
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves (char(20)) do registro em SigCdNei
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei do servi?o corrente
    *   Persiste os campos do registro carregado (Empdnps, Nops, Cmats, Qtds,
    *   Fators, Cretrabs, CDescs). Marca Servicos=1 e gera chave prim?ria
    *   cidchaves quando ausente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cCats, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Cats = primeiros 6 chars do c?digo do material (padr?o legado)
            loc_cCats = LEFT(THIS.this_cCmats, 6)

            *-- Gera chave prim?ria composta se ainda n?o houver
            IF EMPTY(THIS.this_cCidchaves)
                loc_cChave = LEFT(ALLTRIM(THIS.this_cEmpdnps) + ;
                                  PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0") + ;
                                  ALLTRIM(loc_cCats), 20)
                THIS.this_cCidchaves = loc_cChave
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNei (" + ;
                       "cidchaves, Empdnps, Nops, Cmats, Cats, " + ;
                       "Qtds, Fators, Cretrabs, Cdescs, Servicos, " + ;
                       "Emps, Numps, Dopps" + ;
                       ") VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCmats, 14)) + ", " + ;
                       EscaparSQL(LEFT(loc_cCats, 6)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "1, " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopps, 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao inserir servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("INCLUSAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei do servi?o corrente pela cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Empdnps  = " + EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ", " + ;
                       "Nops     = " + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       "Cmats    = " + EscaparSQL(LEFT(THIS.this_cCmats, 14)) + ", " + ;
                       "Cats     = " + EscaparSQL(LEFT(THIS.this_cCmats, 6)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       "Fators   = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       "Cretrabs = " + EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       "Cdescs   = " + EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "Servicos = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao atualizar servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("ALTERACAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

