# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCEP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1472 linhas total):

*-- Linhas 412 a 430:
412:             .HighlightBackColor = RGB(255, 255, 255)
413:             .HighlightForeColor = RGB(15, 41, 104)
414:             .HighlightStyle     = 2
415:             .DeleteMark         = .F.
416:             .RecordMark         = .F.
417:             .RowHeight          = 16
418:             .ScrollBars         = 2
419:             .GridLines          = 3
420:             .Visible            = .T.
421:         ENDWITH
422: 
423:         WITH loc_oGrid.Column1
424:             .Header1.Caption = "CEP"
425:             .Width           = 90
426:         ENDWITH
427: 
428:         WITH loc_oGrid.Column2
429:             .Header1.Caption = "Tipo"
430:             .Width           = 80

*-- Linhas 897 a 935:
897:                     USE IN cursor_4c_Dados
898:                 ENDIF
899:                 SET NULL ON
900:                 CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Ceps C(9), TipoNomes C(15), ;
901:                     Nomes C(72), Bairros C(72), Cidades C(72), Estados C(2), ;
902:                     Comples C(72), Nums C(11), cBarCeps C(7), TipoCeps C(1))
903:                 SET NULL OFF
904:                 loc_lResultado = .T.
905:             ELSE
906:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cUfFiltro)
907:                     loc_lResultado = .T.
908:                 ENDIF
909:             ENDIF
910: 
911:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
912:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
913:                 loc_oGrid.ColumnCount = 6
914:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
915:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ceps"
916:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.TipoNomes"
917:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Nomes"
918:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Bairros"
919:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Cidades"
920:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Estados"
921:                 loc_oGrid.Column1.Header1.Caption = "CEP"
922:                 loc_oGrid.Column2.Header1.Caption = "Tipo"
923:                 loc_oGrid.Column3.Header1.Caption = "Endere" + CHR(231) + "o"
924:                 loc_oGrid.Column4.Header1.Caption = "Bairro"
925:                 loc_oGrid.Column5.Header1.Caption = "Cidade"
926:                 loc_oGrid.Column6.Header1.Caption = "UF"
927:                 loc_oGrid.Column1.Width = 90
928:                 loc_oGrid.Column2.Width = 80
929:                 loc_oGrid.Column3.Width = 280
930:                 loc_oGrid.Column4.Width = 200
931:                 loc_oGrid.Column5.Width = 230
932:                 loc_oGrid.Column6.Width = 60
933:                 THIS.FormatarGridLista(loc_oGrid)
934:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
935:                     GO TOP IN cursor_4c_Dados

*-- Linhas 1099 a 1117:
1099: 
1100:         TRY
1101:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1102:                 SELECT cursor_4c_Dados
1103:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1104:             ENDIF
1105: 
1106:             IF EMPTY(loc_cChave)
1107:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1108:             ELSE
1109:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1110:                     THIS.BOParaForm()
1111:                     THIS.this_cModoAtual = "VISUALIZAR"
1112:                     THIS.HabilitarCampos(.F.)
1113:                     THIS.AjustarBotoesPorModo()
1114:                     THIS.AlternarPagina(2)
1115:                 ENDIF
1116:             ENDIF
1117:         CATCH TO loc_oErro

*-- Linhas 1128 a 1146:
1128: 
1129:         TRY
1130:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1131:                 SELECT cursor_4c_Dados
1132:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1133:             ENDIF
1134: 
1135:             IF EMPTY(loc_cChave)
1136:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1137:             ELSE
1138:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1139:                     THIS.this_oBusinessObject.EditarRegistro()
1140:                     THIS.BOParaForm()
1141:                     THIS.this_cModoAtual = "ALTERAR"
1142:                     THIS.HabilitarCampos(.T.)
1143:                     THIS.AjustarBotoesPorModo()
1144:                     THIS.AlternarPagina(2)
1145:                 ENDIF
1146:             ENDIF

*-- Linhas 1159 a 1177:
1159: 
1160:         TRY
1161:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1162:                 SELECT cursor_4c_Dados
1163:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1164:                 loc_cCeps  = ALLTRIM(cursor_4c_Dados.Ceps)
1165:             ENDIF
1166: 
1167:             IF EMPTY(loc_cChave)
1168:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1169:             ELSE
1170:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do CEP " + loc_cCeps + "?", ;
1171:                                "Exclus" + CHR(227) + "o")
1172:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1173:                         IF THIS.this_oBusinessObject.Excluir()
1174:                             MsgInfo("CEP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1175:                             THIS.CarregarLista()
1176:                         ENDIF
1177:                     ENDIF

*-- Linhas 1223 a 1241:
1223:                     ENDIF
1224: 
1225:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1226:                         SELECT cursor_4c_BuscaUf
1227:                         loc_cEstado = ALLTRIM(cursor_4c_BuscaUf.Estados)
1228:                     ENDIF
1229: 
1230:                     loc_oBusca.Release()
1231:                 ENDIF
1232: 
1233:                 IF USED("cursor_4c_BuscaUf")
1234:                     USE IN cursor_4c_BuscaUf
1235:                 ENDIF
1236: 
1237:                 IF EMPTY(loc_cEstado)
1238:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = ""
1239:                     THIS.this_cUfFiltro = ""
1240:                 ELSE
1241:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = loc_cEstado

*-- Linhas 1269 a 1287:
1269:                 loc_oBusca.Show()
1270: 
1271:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1272:                     SELECT cursor_4c_BuscaUf
1273:                     loc_cUf = ALLTRIM(cursor_4c_BuscaUf.Estados)
1274:                 ENDIF
1275: 
1276:                 loc_oBusca.Release()
1277:             ENDIF
1278: 
1279:             IF USED("cursor_4c_BuscaUf")
1280:                 USE IN cursor_4c_BuscaUf
1281:             ENDIF
1282: 
1283:             IF !EMPTY(loc_cUf)
1284:                 THIS.this_cUfFiltro = loc_cUf
1285:                 THIS.this_cUltimoEstadoValidado = loc_cUf
1286:                 THIS.CarregarLista()
1287:             ENDIF

*-- Linhas 1411 a 1448:
1411:         loc_cSQL = ""
1412: 
1413:         TRY
1414:             loc_cSQL = "SELECT Descs FROM SigCdMun ORDER BY Descs"
1415: 
1416:             IF USED("cursor_4c_BuscaMun")
1417:                 USE IN cursor_4c_BuscaMun
1418:             ENDIF
1419: 
1420:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMun")
1421:             IF loc_nResult < 0
1422:                 MsgErro("Erro ao buscar munic" + CHR(237) + "pios:" + CHR(13) + ;
1423:                         CapturarErroSQL(), "Erro SQL")
1424:             ELSE
1425:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1426:                 IF VARTYPE(loc_oBusca) = "O"
1427:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMun"
1428:                     loc_oBusca.this_cTitulo = "Selecionar Cidade"
1429:                     loc_oBusca.mAddColuna("Descs", "", "Cidade")
1430:                     loc_oBusca.Show()
1431: 
1432:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
1433:                         SELECT cursor_4c_BuscaMun
1434:                         loc_oPg2.txt_4c_Cidades.Value = UPPER(ALLTRIM(cursor_4c_BuscaMun.Descs))
1435:                     ENDIF
1436: 
1437:                     loc_oBusca.Release()
1438:                 ENDIF
1439:             ENDIF
1440:         CATCH TO loc_oErro
1441:             MsgErro(loc_oErro.Message, "FormCEP.AbrirLookupCidades")
1442:         ENDTRY
1443: 
1444:         IF USED("cursor_4c_BuscaMun")
1445:             USE IN cursor_4c_BuscaMun
1446:         ENDIF
1447:     ENDPROC
1448: 


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

