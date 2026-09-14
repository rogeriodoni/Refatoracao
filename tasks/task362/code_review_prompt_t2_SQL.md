# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'UFIBGES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS

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
  ControlSource = "crSigCdCEP.CEPS"
  ControlSource = "crSigCdCEP.TipoNomes"
  ControlSource = "crSigCdCEP.Nomes"
  ControlSource = "crSigCdCEP.Bairros"
  ControlSource = "crSigCdCEP.Cidades"
  ControlSource = "crSigCdCEP.Estados"
  ControlSource = "crSigCdCEP.Comples"
  ControlSource = "crSigCdCEP.Nums"
lcQryCep = [Select * From Cep Where Estados = ?pUFs]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCEP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1488 linhas total):

*-- Linhas 413 a 431:
413:             .HighlightBackColor = RGB(255, 255, 255)
414:             .HighlightForeColor = RGB(15, 41, 104)
415:             .HighlightStyle     = 2
416:             .DeleteMark         = .F.
417:             .RecordMark         = .F.
418:             .RowHeight          = 16
419:             .ScrollBars         = 2
420:             .GridLines          = 3
421:             .Visible            = .T.
422:         ENDWITH
423: 
424:         WITH loc_oGrid.Column1
425:             .Header1.Caption = "CEP"
426:             .Width           = 90
427:         ENDWITH
428: 
429:         WITH loc_oGrid.Column2
430:             .Header1.Caption = "Tipo"
431:             .Width           = 80

*-- Linhas 899 a 937:
899:                     USE IN cursor_4c_Dados
900:                 ENDIF
901:                 SET NULL ON
902:                 CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Ceps C(9), TipoNomes C(15), ;
903:                     Nomes C(72), Bairros C(72), Cidades C(72), Estados C(2), ;
904:                     Comples C(72), Nums C(11), cBarCeps C(7), TipoCeps C(1))
905:                 SET NULL OFF
906:                 loc_lResultado = .T.
907:             ELSE
908:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cUfFiltro)
909:                     loc_lResultado = .T.
910:                 ENDIF
911:             ENDIF
912: 
913:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
914:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
915:                 loc_oGrid.ColumnCount = 6
916:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
917:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ceps"
918:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.TipoNomes"
919:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Nomes"
920:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Bairros"
921:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Cidades"
922:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Estados"
923:                 loc_oGrid.Column1.Header1.Caption = "CEP"
924:                 loc_oGrid.Column2.Header1.Caption = "Tipo"
925:                 loc_oGrid.Column3.Header1.Caption = "Endere" + CHR(231) + "o"
926:                 loc_oGrid.Column4.Header1.Caption = "Bairro"
927:                 loc_oGrid.Column5.Header1.Caption = "Cidade"
928:                 loc_oGrid.Column6.Header1.Caption = "UF"
929:                 loc_oGrid.Column1.Width = 90
930:                 loc_oGrid.Column2.Width = 80
931:                 loc_oGrid.Column3.Width = 280
932:                 loc_oGrid.Column4.Width = 200
933:                 loc_oGrid.Column5.Width = 230
934:                 loc_oGrid.Column6.Width = 60
935:                 THIS.FormatarGridLista(loc_oGrid)
936:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
937:                     GO TOP IN cursor_4c_Dados

*-- Linhas 1101 a 1119:
1101: 
1102:         TRY
1103:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1104:                 SELECT cursor_4c_Dados
1105:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1106:             ENDIF
1107: 
1108:             IF EMPTY(loc_cChave)
1109:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1110:             ELSE
1111:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1112:                     THIS.BOParaForm()
1113:                     THIS.this_cModoAtual = "VISUALIZAR"
1114:                     THIS.HabilitarCampos(.F.)
1115:                     THIS.AjustarBotoesPorModo()
1116:                     THIS.AlternarPagina(2)
1117:                 ENDIF
1118:             ENDIF
1119:         CATCH TO loc_oErro

*-- Linhas 1130 a 1148:
1130: 
1131:         TRY
1132:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1133:                 SELECT cursor_4c_Dados
1134:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1135:             ENDIF
1136: 
1137:             IF EMPTY(loc_cChave)
1138:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1139:             ELSE
1140:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1141:                     THIS.this_oBusinessObject.EditarRegistro()
1142:                     THIS.BOParaForm()
1143:                     THIS.this_cModoAtual = "ALTERAR"
1144:                     THIS.HabilitarCampos(.T.)
1145:                     THIS.AjustarBotoesPorModo()
1146:                     THIS.AlternarPagina(2)
1147:                 ENDIF
1148:             ENDIF

*-- Linhas 1161 a 1179:
1161: 
1162:         TRY
1163:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1164:                 SELECT cursor_4c_Dados
1165:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1166:                 loc_cCeps  = ALLTRIM(cursor_4c_Dados.Ceps)
1167:             ENDIF
1168: 
1169:             IF EMPTY(loc_cChave)
1170:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1171:             ELSE
1172:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do CEP " + loc_cCeps + "?", ;
1173:                                "Exclus" + CHR(227) + "o")
1174:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1175:                         IF THIS.this_oBusinessObject.Excluir()
1176:                             MsgInfo("CEP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1177:                             THIS.CarregarLista()
1178:                         ENDIF
1179:                     ENDIF

*-- Linhas 1228 a 1246:
1228:                     ENDIF
1229: 
1230:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1231:                         SELECT cursor_4c_BuscaUf
1232:                         loc_cEstado = ALLTRIM(cursor_4c_BuscaUf.Estados)
1233:                         loc_cCodUF  = ALLTRIM(cursor_4c_BuscaUf.UFIBGES)
1234:                     ENDIF
1235: 
1236:                     loc_oBusca.Release()
1237:                 ENDIF
1238: 
1239:                 IF USED("cursor_4c_BuscaUf")
1240:                     USE IN cursor_4c_BuscaUf
1241:                 ENDIF
1242: 
1243:                 IF EMPTY(loc_cEstado)
1244:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = ""
1245:                     THIS.this_cUfFiltro = ""
1246:                     THIS.this_cCodUFs   = ""

*-- Linhas 1278 a 1296:
1278:                 loc_oBusca.Show()
1279: 
1280:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1281:                     SELECT cursor_4c_BuscaUf
1282:                     loc_cUf = ALLTRIM(cursor_4c_BuscaUf.Estados)
1283:                 ENDIF
1284: 
1285:                 loc_oBusca.Release()
1286:             ENDIF
1287: 
1288:             IF USED("cursor_4c_BuscaUf")
1289:                 USE IN cursor_4c_BuscaUf
1290:             ENDIF
1291: 
1292:             IF !EMPTY(loc_cUf)
1293:                 THIS.this_cUfFiltro = loc_cUf
1294:                 THIS.this_cUltimoEstadoValidado = loc_cUf
1295:                 THIS.CarregarLista()
1296:             ENDIF

*-- Linhas 1422 a 1464:
1422:         TRY
1423:             *-- Query filtrada por UFIBGES quando UF selecionada (original: laFil[UFIBGES]=CodUFs)
1424:             IF !EMPTY(THIS.this_cCodUFs)
1425:                 loc_cSQL = "SELECT Descs FROM SigCdMun" + ;
1426:                            " WHERE UFIBGES = " + EscaparSQL(THIS.this_cCodUFs) + ;
1427:                            " ORDER BY Descs"
1428:             ELSE
1429:                 loc_cSQL = "SELECT Descs FROM SigCdMun ORDER BY Descs"
1430:             ENDIF
1431: 
1432:             IF USED("cursor_4c_BuscaMun")
1433:                 USE IN cursor_4c_BuscaMun
1434:             ENDIF
1435: 
1436:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMun")
1437:             IF loc_nResult < 0
1438:                 MsgErro("Erro ao buscar munic" + CHR(237) + "pios:" + CHR(13) + ;
1439:                         CapturarErroSQL(), "Erro SQL")
1440:             ELSE
1441:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1442:                 IF VARTYPE(loc_oBusca) = "O"
1443:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMun"
1444:                     loc_oBusca.this_cTitulo = "Selecionar Cidade"
1445:                     loc_oBusca.mAddColuna("Descs", "", "Cidade")
1446:                     loc_oBusca.Show()
1447: 
1448:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
1449:                         SELECT cursor_4c_BuscaMun
1450:                         loc_oPg2.txt_4c_Cidades.Value = UPPER(ALLTRIM(cursor_4c_BuscaMun.Descs))
1451:                     ENDIF
1452: 
1453:                     loc_oBusca.Release()
1454:                 ENDIF
1455:             ENDIF
1456:         CATCH TO loc_oErro
1457:             MsgErro(loc_oErro.Message, "FormCEP.AbrirLookupCidades")
1458:         ENDTRY
1459: 
1460:         IF USED("cursor_4c_BuscaMun")
1461:             USE IN cursor_4c_BuscaMun
1462:         ENDIF
1463:     ENDPROC
1464: 


### BO (C:\4c\projeto\app\classes\CEPBO.prg):
*====================================================================
* CEPBO.prg
*
* Business Object para CEP (Cadastro de Enderecos Postais)
* Tabela principal: cep (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CEPBO AS BusinessBase

	*-- Propriedades da entidade (tabela: cep)
	this_cCidChaves   = ""   && cidchaves char(20)  - PK (ID unico gerado por fUniqueIds)
	this_cCeps        = ""   && ceps char(9)        - CEP (ex: 41820-610)
	this_cTipoNomes   = ""   && tiponomes char(15)  - Tipo de endereco (R, AV, TV, AL...)
	this_cNomes       = ""   && nomes char(72)      - Nome do endereco
	this_cBairros     = ""   && bairros char(72)    - Bairro
	this_cCidades     = ""   && cidades char(72)    - Cidade
	this_cEstados     = ""   && estados char(2)     - UF (sigla)
	this_cComples     = ""   && comples char(72)    - Complemento
	this_cNums        = ""   && nums char(11)       - Numero
	this_cTipoCeps    = ""   && tipoceps char(1)    - Tipo do CEP
	this_cBarCeps     = ""   && cBarCeps char(7)    - Codigo de barras CEP

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "cep"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de CEPs no cursor_4c_Dados
	* par_cFiltro: sigla da UF para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
				           " FROM Cep" + ;
				           " ORDER BY Ceps"
			ELSE
				loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
				           " FROM Cep" + ;
				           " WHERE Estados = " + EscaparSQL(UPPER(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY Ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
			           " FROM Cep" + ;
			           " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidChaves  = TratarNulo(cIdChaves,  "C")
			THIS.this_cCeps       = TratarNulo(Ceps,       "C")
			THIS.this_cTipoNomes  = TratarNulo(TipoNomes,  "C")
			THIS.this_cNomes      = TratarNulo(Nomes,      "C")
			THIS.this_cBairros    = TratarNulo(Bairros,    "C")
			THIS.this_cCidades    = TratarNulo(Cidades,    "C")
			THIS.this_cEstados    = TratarNulo(Estados,    "C")
			THIS.this_cComples    = TratarNulo(Comples,    "C")
			THIS.this_cNums       = TratarNulo(Nums,       "C")
			THIS.this_cTipoCeps   = TratarNulo(TipoCeps,   "C")
			THIS.this_cBarCeps    = TratarNulo(cBarCeps,   "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela Cep
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar chave unica via SQL Server NEWID()
			loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidChaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica para o CEP.", "Erro")
			ELSE
				loc_cSQL = "INSERT INTO Cep (cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidChaves) + "," + ;
				           EscaparSQL(THIS.this_cCeps)      + "," + ;
				           EscaparSQL(THIS.this_cTipoNomes) + "," + ;
				           EscaparSQL(THIS.this_cNomes)     + "," + ;
				           EscaparSQL(THIS.this_cBairros)   + "," + ;
				           EscaparSQL(THIS.this_cCidades)   + "," + ;
				           EscaparSQL(THIS.this_cEstados)   + "," + ;
				           EscaparSQL(THIS.this_cComples)   + "," + ;
				           EscaparSQL(THIS.this_cNums)      + "," + ;
				           EscaparSQL(THIS.this_cBarCeps)   + "," + ;
				           EscaparSQL(THIS.this_cTipoCeps)  + ;
				           ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela Cep
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE Cep SET" + ;
			           " Ceps       = " + EscaparSQL(THIS.this_cCeps)      + "," + ;
			           " TipoNomes  = " + EscaparSQL(THIS.this_cTipoNomes) + "," + ;
			           " Nomes      = " + EscaparSQL(THIS.this_cNomes)     + "," + ;
			           " Bairros    = " + EscaparSQL(THIS.this_cBairros)   + "," + ;
			           " Cidades    = " + EscaparSQL(THIS.this_cCidades)   + "," + ;
			           " Estados    = " + EscaparSQL(THIS.this_cEstados)   + "," + ;
			           " Comples    = " + EscaparSQL(THIS.this_cComples)   + "," + ;
			           " Nums       = " + EscaparSQL(THIS.this_cNums)      + "," + ;
			           " cBarCeps   = " + EscaparSQL(THIS.this_cBarCeps)   + "," + ;
			           " TipoCeps   = " + EscaparSQL(THIS.this_cTipoCeps)  + ;
			           " WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela Cep
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM Cep WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

