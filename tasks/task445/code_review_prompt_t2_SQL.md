# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, UFS, CODIGO, CHAVE, VERSAO

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
SELECT crSigcdIbp
	SELECT localIbpt
	APPEND FROM (lcArq) DELIMITED  WITH  character ';'
	DELETE 
	SELECT localIbpt
	DELETE all FOR !EMPTY(c2)
		lcQuery = 	[Select cidchaves From SigcdIbp where ufs = ']+lcUf+[' and codigo =']+lcCodigo+[' and chave = ']+lcChave+[' and versao =']+lcVersao+[']
		If ThisForm.Podatamgr.Sqlexecute(lcQuery,'crAux') < 1
		Insert Into crSigcdIbp (cidchaves, ufs, codigo, ex, tipo, descricao, datini, datfin,nacfederal, impfederal, estadual, municipal, chave, versao, fonte);
		Select LocalIbpt
If Not ThisForm.poDataMgr.Update([crSigCdIbp])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdIbp)])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormIBP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1427 linhas total):

*-- Linhas 352 a 370:
352:             .HighlightBackColor = RGB(255, 255, 255)
353:             .HighlightForeColor = RGB(15, 41, 104)
354:             .HighlightStyle     = 2
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .ScrollBars         = 2
358:             .GridLines          = 3
359: 
360:             .Column1.Width  = 75
361:             .Column2.Width  = 100
362:             .Column3.Width  = 75
363:             .Column4.Width  = 75
364:             .Column5.Width  = 75
365:             .Column6.Width  = 75
366:             .Column7.Width  = 75
367:             .Column8.Width  = 75
368:             .Column9.Width  = 75
369: 
370:             .Column1.Header1.Caption = "Estado"

*-- Linhas 927 a 955:
927:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
928:                     loc_oGrid.ColumnCount  = 9
929: 
930:                     *-- Problema 48: ControlSource e Headers APOS RecordSource
931:                     WITH loc_oGrid
932:                         .Column1.ControlSource = "cursor_4c_Dados.ufs"
933:                         .Column2.ControlSource = "cursor_4c_Dados.codigo"
934:                         .Column3.ControlSource = "cursor_4c_Dados.datini"
935:                         .Column4.ControlSource = "cursor_4c_Dados.datfin"
936:                         .Column5.ControlSource = "cursor_4c_Dados.nacfederal"
937:                         .Column6.ControlSource = "cursor_4c_Dados.impfederal"
938:                         .Column7.ControlSource = "cursor_4c_Dados.estadual"
939:                         .Column8.ControlSource = "cursor_4c_Dados.municipal"
940:                         .Column9.ControlSource = "cursor_4c_Dados.versao"
941: 
942:                         *-- Problema 32: Reconfigurar Headers APOS RecordSource
943:                         .Column1.Header1.Caption = "Estado"
944:                         .Column2.Header1.Caption = "Codigo"
945:                         .Column3.Header1.Caption = "Data Ini"
946:                         .Column4.Header1.Caption = "Data Fim"
947:                         .Column5.Header1.Caption = "Aliq Nac Fed"
948:                         .Column6.Header1.Caption = "Aliq Imp Fed"
949:                         .Column7.Header1.Caption = "Aliq Estadual"
950:                         .Column8.Header1.Caption = "Aliq Municipal"
951:                         .Column9.Header1.Caption = "Versao"
952: 
953:                         .Column1.Width = 75
954:                         .Column2.Width = 100
955:                         .Column3.Width = 75

*-- Linhas 1214 a 1255:
1214: 
1215:     *===========================================================================
1216:     * BtnIncluirClick - Abre Page2 em modo INCLUIR
1217:     * Problema 18: NovoRegistro() prepara BO para INSERT
1218:     * Problema 19: this_cModoAtual ANTES de HabilitarCampos
1219:     *===========================================================================
1220:     PROCEDURE BtnIncluirClick()
1221:         THIS.this_oBusinessObject.NovoRegistro()
1222:         THIS.LimparCampos()
1223:         THIS.this_cModoAtual = "INCLUIR"
1224:         THIS.HabilitarCampos(.T.)
1225:         THIS.AlternarPagina(2)
1226:     ENDPROC
1227: 
1228:     *===========================================================================
1229:     * BtnAlterarClick - Carrega registro selecionado e abre Page2 em modo ALTERAR
1230:     * Problema 18: EditarRegistro() prepara BO para UPDATE
1231:     *===========================================================================
1232:     PROCEDURE BtnAlterarClick()
1233:         LOCAL loc_cCidChaves, loc_lResultado
1234:         loc_lResultado = .F.
1235: 
1236:         TRY
1237:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1238:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1239:             ELSE
1240:                 SELECT cursor_4c_Dados
1241:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1242:                 IF EMPTY(loc_cCidChaves)
1243:                     MsgAviso("Nenhum registro selecionado.", "Alterar")
1244:                 ELSE
1245:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1246:                     THIS.this_oBusinessObject.EditarRegistro()
1247:                     THIS.BOParaForm()
1248:                     THIS.this_cModoAtual = "ALTERAR"
1249:                     THIS.HabilitarCampos(.T.)
1250:                     THIS.AlternarPagina(2)
1251:                     loc_lResultado = .T.
1252:                     ENDIF
1253:                 ENDIF
1254:             ENDIF
1255:         CATCH TO loException

*-- Linhas 1268 a 1286:
1268:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1269:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1270:             ELSE
1271:                 SELECT cursor_4c_Dados
1272:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1273:                 IF EMPTY(loc_cCidChaves)
1274:                     MsgAviso("Nenhum registro selecionado.", "Visualizar")
1275:                 ELSE
1276:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1277:                     THIS.BOParaForm()
1278:                     THIS.this_cModoAtual = "VISUALIZAR"
1279:                     THIS.HabilitarCampos(.F.)
1280:                     THIS.AlternarPagina(2)
1281:                     loc_lResultado = .T.
1282:                     ENDIF
1283:                 ENDIF
1284:             ENDIF
1285:         CATCH TO loException
1286:             MsgErro("Erro em FormIBP.BtnVisualizarClick:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1298 a 1316:
1298:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1299:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1300:             ELSE
1301:                 SELECT cursor_4c_Dados
1302:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1303:                 IF EMPTY(loc_cCidChaves)
1304:                     MsgAviso("Nenhum registro selecionado.", "Excluir")
1305:                 ELSE
1306:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro de IBPT?", "Excluir")
1307:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1308:                         IF THIS.this_oBusinessObject.Excluir()
1309:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1310:                             THIS.CarregarLista()
1311:                         ENDIF
1312:                     ENDIF
1313:                     ENDIF
1314:                 ENDIF
1315:             ENDIF
1316:         CATCH TO loException

*-- Linhas 1343 a 1369:
1343:                     loc_oGrid.ColumnCount  = 9
1344: 
1345:                     WITH loc_oGrid
1346:                         .Column1.ControlSource = "cursor_4c_Dados.ufs"
1347:                         .Column2.ControlSource = "cursor_4c_Dados.codigo"
1348:                         .Column3.ControlSource = "cursor_4c_Dados.datini"
1349:                         .Column4.ControlSource = "cursor_4c_Dados.datfin"
1350:                         .Column5.ControlSource = "cursor_4c_Dados.nacfederal"
1351:                         .Column6.ControlSource = "cursor_4c_Dados.impfederal"
1352:                         .Column7.ControlSource = "cursor_4c_Dados.estadual"
1353:                         .Column8.ControlSource = "cursor_4c_Dados.municipal"
1354:                         .Column9.ControlSource = "cursor_4c_Dados.versao"
1355: 
1356:                         .Column1.Header1.Caption = "Estado"
1357:                         .Column2.Header1.Caption = "Codigo"
1358:                         .Column3.Header1.Caption = "Data Ini"
1359:                         .Column4.Header1.Caption = "Data Fim"
1360:                         .Column5.Header1.Caption = "Aliq Nac Fed"
1361:                         .Column6.Header1.Caption = "Aliq Imp Fed"
1362:                         .Column7.Header1.Caption = "Aliq Estadual"
1363:                         .Column8.Header1.Caption = "Aliq Municipal"
1364:                         .Column9.Header1.Caption = "Versao"
1365: 
1366:                         .Column1.Width = 75
1367:                         .Column2.Width = 100
1368:                         .Column3.Width = 75
1369:                         .Column4.Width = 75


### BO (C:\4c\projeto\app\classes\IBPBO.prg):
*------------------------------------------------------------------------------
* IBPBO.prg - Business Object para SigCdIbp (Cadastro IBPT)
* Herda de BusinessBase
* Tabela: SigCdIbp / PK: cidchaves
*------------------------------------------------------------------------------

DEFINE CLASS IBPBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves  = ""   && char(20) NOT NULL

    *-- Campos da tabela SigCdIbp
    this_cUfs        = ""   && char(2)
    this_cCodigo     = ""   && char(10)
    this_cEx         = ""   && char(3)
    this_nTipo       = 0    && numeric(3,0)
    this_cDescricao  = ""   && text (memo)
    this_dDatIni     = {}   && datetime
    this_dDatFin     = {}   && datetime
    this_nNacFederal = 0    && numeric(5,2)
    this_nImpFederal = 0    && numeric(5,2)
    this_nEstadual   = 0    && numeric(5,2)
    this_nMunicipal  = 0    && numeric(5,2)
    this_cChave      = ""   && char(10)
    this_cVersao     = ""   && char(10)
    this_cFonte      = ""   && char(10)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdIbp"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional; cursor_4c_Dados para o grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                loc_cWhere = ""
            ENDIF

            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       loc_cWhere + ;
                       " ORDER BY ufs, codigo, versao"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cUfs        = TratarNulo(ufs,        "C")
                THIS.this_cCodigo     = TratarNulo(codigo,     "C")
                THIS.this_cEx         = TratarNulo(ex,         "C")
                THIS.this_nTipo       = TratarNulo(tipo,       "N")
                THIS.this_cDescricao  = TratarNulo(descricao,  "C")
                THIS.this_dDatIni     = TratarNulo(datini,     "D")
                THIS.this_dDatFin     = TratarNulo(datfin,     "D")
                THIS.this_nNacFederal = TratarNulo(nacfederal, "N")
                THIS.this_nImpFederal = TratarNulo(impfederal, "N")
                THIS.this_nEstadual   = TratarNulo(estadual,   "N")
                THIS.this_nMunicipal  = TratarNulo(municipal,  "N")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cVersao     = TratarNulo(versao,     "C")
                THIS.this_cFonte      = TratarNulo(fonte,      "C")
                loc_lSucesso = .T.
            CATCH TO loException
                MsgErro("Erro em IBPBO.CarregarDoCursor:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro via CRUD standard
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdIbp" + ;
                       " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       "  datini, datfin, nacfederal, impfederal," + ;
                       "  estadual, municipal, chave, versao, fonte)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cUfs) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cEx) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       EscaparSQL(THIS.this_cChave) + "," + ;
                       EscaparSQL(THIS.this_cVersao) + "," + ;
                       EscaparSQL(THIS.this_cFonte) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdIbp SET" + ;
                       " ufs        = " + EscaparSQL(THIS.this_cUfs) + "," + ;
                       " codigo     = " + EscaparSQL(THIS.this_cCodigo) + "," + ;
                       " ex         = " + EscaparSQL(THIS.this_cEx) + "," + ;
                       " tipo       = " + FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       " descricao  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " datini     = " + FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       " datfin     = " + FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       " nacfederal = " + FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       " impfederal = " + FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       " estadual   = " + FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       " municipal  = " + FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       " chave      = " + EscaparSQL(THIS.this_cChave) + "," + ;
                       " versao     = " + EscaparSQL(THIS.this_cVersao) + "," + ;
                       " fonte      = " + EscaparSQL(THIS.this_cFonte) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarPlanilha - Importa dados IBPT de arquivos CSV de uma pasta
    * Portado de SIGCDIBP.importaplan
    * CSV: c1=codigo, c2=ex(skip se !empty), c4=descricao, c5=nacfed, c6=impfed,
    *       c7=estadual, c8=municipal, c9=datini, c10=datfin, c11=chave,
    *       c12=versao, c13=fonte. UF extraida do nome do arquivo (pos 13-14).
    *--------------------------------------------------------------------------
    FUNCTION ImportarPlanilha()
        LOCAL loc_lSucesso, loc_lOk, loc_lcDir, loc_nQtdArq
        LOCAL loc_lcArq, loc_lcUf, loc_lcCodigo, loc_lcDesc
        LOCAL loc_lnAliq5, loc_lnAliq6, loc_lnAliq7, loc_lnAliq8
        LOCAL loc_ldDatIni, loc_ldDatFin
        LOCAL loc_lcChave, loc_lcVersao, loc_lcFonte
        LOCAL loc_lcCidChaves, loc_lcQuery, loc_nResult, loc_i
        loc_lSucesso = .F.
        loc_lOk      = .F.

        *-- Selecionar pasta (fora do TRY - RETURN .F. e valido aqui)
        loc_lcDir = GETDIR([], "Selecione a Pasta com os Arquivos CSV do IBPT", ;
                           "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2)
        IF EMPTY(loc_lcDir)
            RETURN .F.
        ENDIF

        DIMENSION loc_laArqs[1, 5]
        loc_nQtdArq = ADIR(loc_laArqs, loc_lcDir + "*.csv")
        IF loc_nQtdArq = 0
            MsgAviso("Nenhum arquivo CSV encontrado na pasta selecionada.", "Aviso")
            RETURN .F.
        ENDIF

        loc_lOk = .T.

        TRY
            CREATE CURSOR localIbpt (c1 c(10), c2 c(50), c3 c(50), c4 c(100), ;
                c5 c(50), c6 c(50), c7 c(50), c8 c(50), ;
                c9 c(50), c10 c(50), c11 c(50), c12 c(50), c13 c(50))

            FOR loc_i = 1 TO loc_nQtdArq
                loc_lcArq = loc_lcDir + loc_laArqs[loc_i, 1]
                IF EMPTY(loc_lcArq)
                    LOOP
                ENDIF

                *-- UF extraida do nome do arquivo (posicoes 13-14 do nome original)
                loc_lcUf = SUBSTR(ALLTRIM(loc_laArqs[loc_i, 1]), 13, 2)

                SELECT localIbpt
                ZAP
                APPEND FROM (loc_lcArq) DELIMITED WITH CHARACTER ";"
                GO TOP
                DELETE
                DELETE ALL FOR !EMPTY(c2)
                GO TOP

                SCAN
                    loc_lcCodigo = ALLTRIM(c1)
                    loc_lcDesc   = ALLTRIM(c4)
                    loc_lnAliq5  = VAL(ALLTRIM(c5))
                    loc_lnAliq6  = VAL(ALLTRIM(c6))
                    loc_lnAliq7  = VAL(ALLTRIM(c7))
                    loc_lnAliq8  = VAL(ALLTRIM(c8))
                    loc_ldDatIni = DTOT(CTOD(ALLTRIM(c9)))
                    loc_ldDatFin = DTOT(CTOD(ALLTRIM(c10)))
                    loc_lcChave  = ALLTRIM(c11)
                    loc_lcVersao = ALLTRIM(c12)
                    loc_lcFonte  = ALLTRIM(c13)

                    loc_lcQuery = "SELECT cidchaves FROM SigCdIbp" + ;
                                  " WHERE ufs    = " + EscaparSQL(loc_lcUf) + ;
                                  " AND   codigo = " + EscaparSQL(loc_lcCodigo) + ;
                                  " AND   chave  = " + EscaparSQL(loc_lcChave) + ;
                                  " AND   versao = " + EscaparSQL(loc_lcVersao)

                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_AuxIbp")
                        TABLEREVERT(.T., "cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_AuxIbp")
                    IF loc_nResult < 0
                        MsgErro("Imposs" + CHR(237) + "vel conectar ao servidor de banco de dados.", "Erro")
                        loc_lOk = .F.
                        IF USED("cursor_4c_AuxIbp")
                            USE IN cursor_4c_AuxIbp
                        ENDIF
                        EXIT
                    ENDIF

                    IF RECCOUNT("cursor_4c_AuxIbp") = 0
                        *-- Novo registro
                        loc_lcCidChaves = LEFT(fUniqueIds(), 20)
                        loc_lcQuery = "INSERT INTO SigCdIbp" + ;
                                      " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                                      "  datini, datfin, nacfederal, impfederal," + ;
                                      "  estadual, municipal, chave, versao, fonte)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(loc_lcCidChaves) + "," + ;
                                      EscaparSQL(loc_lcUf) + "," + ;
                                      EscaparSQL(loc_lcCodigo) + "," + ;
                                      EscaparSQL("") + "," + ;
                                      "0," + ;
                                      EscaparSQL(loc_lcDesc) + "," + ;
                                      FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      EscaparSQL(loc_lcChave) + "," + ;
                                      EscaparSQL(loc_lcVersao) + "," + ;
                                      EscaparSQL(loc_lcFonte) + ;
                                      ")"
                    ELSE
                        *-- Registro existente - atualizar aliquotas e datas
                        SELECT cursor_4c_AuxIbp
                        loc_lcCidChaves = ALLTRIM(cursor_4c_AuxIbp.cidchaves)
                        loc_lcQuery = "UPDATE SigCdIbp SET" + ;
                                      " descricao  = " + EscaparSQL(loc_lcDesc) + "," + ;
                                      " datini     = " + FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      " datfin     = " + FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      " nacfederal = " + FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      " impfederal = " + FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      " estadual   = " + FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      " municipal  = " + FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      " fonte      = " + EscaparSQL(loc_lcFonte) + ;
                                      " WHERE cidchaves = " + EscaparSQL(loc_lcCidChaves)
                    ENDIF

                    IF USED("cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_nResult < 0
                        MsgErro("Erro ao importar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    SELECT localIbpt
                ENDSCAN

                IF !loc_lOk
                    EXIT
                ENDIF
            ENDFOR

            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF

            loc_lSucesso = loc_lOk
        CATCH TO loException
            MsgErro("Erro em IBPBO.ImportarPlanilha:" + CHR(13) + loException.Message, "Erro")
            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF
            IF USED("cursor_4c_AuxIbp")
                USE IN cursor_4c_AuxIbp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

