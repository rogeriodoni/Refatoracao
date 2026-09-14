# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SETORS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MESS, ANOS, USUARS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MESS, ANOS, USUARS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCARGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MESS, ANOS, USUARS, CIDCHAVES

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
  ControlSource = "crSigCcCmI.Anos"
  ControlSource = "crSigCcCmI.Mess"
  ControlSource = "crSigCcCmI.Setors"
  ControlSource = "crSigCcCmI.Adics"
  ControlSource = "crSigCcCmI.Indivs"
  ControlSource = "crSigCcCmI.Minimos"
  ControlSource = "crSigCcCmI.Usuars"
  ControlSource = "crSigCcCmI.MinExps"
	lcQuery = [Select * From SigCcCmI Where Mess BetWeen ?pMsI And ?pMsF And Anos BetWeen ?pAnI And ?pAnF]
Select crSigCcCmI
Select crSigCcCmI
	Select LocalCComV
	Select LocalCComV
lcQuery = [Select * ] + ;
		    [From SigCcCmI ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crOrigem') < 1)
Select crOrigem
Select crOrigem
	oProg.Update(.t.)
	lcQuery = [Select * ] + ;
			    [From SigCcCmI ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crBusca') < 1)
	Select crBusca
		Select crOrigem
		Insert Into crSigCcCmI From Memvar
		If Not ThisForm.poDataMgr.Update('crSigCcCmI')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCcCmI - ' + ;
		oProg.Update(.t.)
Select crSigCcCmI
	Select LocalCComV

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg) - TRECHOS RELEVANTES PARA PASS SQL (1974 linhas total):

*-- Linhas 627 a 645:
627:                 .HighlightBackColor = RGB(255, 255, 255)
628:                 .HighlightForeColor = RGB(15, 41, 104)
629:                 .HighlightStyle     = 2
630:                 .DeleteMark         = .F.
631:                 .RecordMark         = .F.
632:                 .RowHeight          = 16
633:                 .ScrollBars         = 2
634:                 .GridLines          = 3
635:                 .Visible            = .T.
636: 
637:                 WITH .Column1
638:                     .Width           = 110
639:                     .Header1.Caption = "Usu" + CHR(225) + "rio"
640:                 ENDWITH
641:                 WITH .Column2
642:                     .Width           = 35
643:                     .Header1.Caption = "M" + CHR(234) + "s"
644:                 ENDWITH
645:                 WITH .Column3

*-- Linhas 1137 a 1178:
1137:                     USE IN crSigCcCmI
1138:                 ENDIF
1139: 
1140:                 loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
1141:                            " Adics, Minimos, MinExps" + ;
1142:                            " FROM SigCcCmI" + ;
1143:                            " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
1144:                            " AND " + EscaparSQL(loc_cMesF) + ;
1145:                            " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
1146:                            " AND " + EscaparSQL(loc_cAnoF) + ;
1147:                            " ORDER BY Anos, Mess, Usuars, Setors"
1148: 
1149:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
1150: 
1151:                 IF loc_nResult < 0
1152:                     MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
1153:                             CapturarErroSQL(), "Erro SQL")
1154:                 ELSE
1155:                     loc_oGrid.RecordSource           = "crSigCcCmI"
1156:                     loc_oGrid.Column1.ControlSource  = "crSigCcCmI.Usuars"
1157:                     loc_oGrid.Column2.ControlSource  = "crSigCcCmI.Mess"
1158:                     loc_oGrid.Column3.ControlSource  = "crSigCcCmI.Anos"
1159:                     loc_oGrid.Column4.ControlSource  = "crSigCcCmI.Indivs"
1160:                     loc_oGrid.Column5.ControlSource  = "crSigCcCmI.Setors"
1161:                     loc_oGrid.Column6.ControlSource  = "crSigCcCmI.Adics"
1162:                     loc_oGrid.Column7.ControlSource  = "crSigCcCmI.Minimos"
1163:                     loc_oGrid.Column8.ControlSource  = "crSigCcCmI.MinExps"
1164: 
1165:                     loc_oGrid.Column1.Width           = 110
1166:                     loc_oGrid.Column2.Width           = 35
1167:                     loc_oGrid.Column3.Width           = 45
1168:                     loc_oGrid.Column4.Width           = 20
1169:                     loc_oGrid.Column5.Width           = 160
1170:                     loc_oGrid.Column6.Width           = 70
1171:                     loc_oGrid.Column7.Width           = 100
1172:                     loc_oGrid.Column8.Width           = 100
1173: 
1174:                     loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1175:                     loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
1176:                     loc_oGrid.Column3.Header1.Caption = "Ano"
1177:                     loc_oGrid.Column4.Header1.Caption = "V"
1178:                     loc_oGrid.Column5.Header1.Caption = "Cargo"

*-- Linhas 1254 a 1272:
1254:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1255:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1256:             ELSE
1257:                 SELECT crSigCcCmI
1258:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1259: 
1260:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1261:                     THIS.this_oBusinessObject.EditarRegistro()
1262:                     THIS.this_cModoAtual = "ALTERAR"
1263:                     THIS.BOParaForm()
1264:                     THIS.HabilitarCampos(.T.)
1265:                     THIS.AjustarBotoesPorModo()
1266:                     THIS.AlternarPagina(2)
1267:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
1268:                 ELSE
1269:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
1270:                 ENDIF
1271:             ENDIF
1272:         CATCH TO loc_oErro

*-- Linhas 1284 a 1302:
1284:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1285:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1286:             ELSE
1287:                 SELECT crSigCcCmI
1288:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1289: 
1290:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1291:                     THIS.this_cModoAtual = "VISUALIZAR"
1292:                     THIS.BOParaForm()
1293:                     THIS.HabilitarCampos(.F.)
1294:                     THIS.AjustarBotoesPorModo()
1295:                     THIS.AlternarPagina(2)
1296:                 ELSE
1297:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
1298:                 ENDIF
1299:             ENDIF
1300:         CATCH TO loc_oErro
1301:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1302:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")

*-- Linhas 1312 a 1330:
1312:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1313:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1314:             ELSE
1315:                 SELECT crSigCcCmI
1316:                 loc_cChave   = ALLTRIM(crSigCcCmI.cIdChaves)
1317:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
1318:                                             "Excluir")
1319: 
1320:                 IF loc_lConfirma
1321:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1322:                         IF THIS.this_oBusinessObject.Excluir()
1323:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1324:                             THIS.CarregarLista()
1325:                         ELSE
1326:                             MsgErro("Erro ao excluir registro!", "Erro")
1327:                         ENDIF
1328:                     ELSE
1329:                         MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
1330:                     ENDIF

*-- Linhas 1456 a 1510:
1456:                 loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
1457:             ELSE
1458:                 *-- Verificar se destino ja tem registros
1459:                 loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
1460:                            " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
1461:                            " AND Anos = " + EscaparSQL(loc_cDAnos)
1462: 
1463:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")
1464: 
1465:                 IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
1466:                    cursor_4c_VerifDest.Total > 0
1467:                     IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
1468:                                    " possui registros. Deseja sobrepor?", "Confirmar")
1469:                         loc_lCopiar = .T.
1470:                     ENDIF
1471:                 ELSE
1472:                     loc_lCopiar = .T.
1473:                 ENDIF
1474: 
1475:                 IF USED("cursor_4c_VerifDest")
1476:                     USE IN cursor_4c_VerifDest
1477:                 ENDIF
1478: 
1479:                 IF loc_lCopiar
1480:                     loc_cSQL = "INSERT INTO SigCcCmI" + ;
1481:                                " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1482:                                " Mess, Anos)" + ;
1483:                                " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1484:                                " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
1485:                                " FROM SigCcCmI" + ;
1486:                                " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
1487:                                " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
1488:                                " AND NOT EXISTS (" + ;
1489:                                "   SELECT 1 FROM SigCcCmI d" + ;
1490:                                "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
1491:                                "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
1492:                                "   AND d.Usuars = SigCcCmI.Usuars" + ;
1493:                                "   AND d.Setors = SigCcCmI.Setors)"
1494: 
1495:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")
1496: 
1497:                     IF loc_nResult >= 0
1498:                         MsgInfo("Per" + CHR(237) + "odo copiado com sucesso!", "")
1499:                         THIS.BtnCancelarCopiaClick()
1500:                         THIS.CarregarLista()
1501:                     ELSE
1502:                         MsgErro("Erro ao copiar per" + CHR(237) + "odo: " + ;
1503:                                 CapturarErroSQL(), "Erro SQL")
1504:                     ENDIF
1505: 
1506:                     IF USED("cursor_4c_CopRes")
1507:                         USE IN cursor_4c_CopRes
1508:                     ENDIF
1509:                 ENDIF
1510:                 ENDIF

*-- Linhas 1776 a 1796:
1776:                 RETURN
1777:             ENDIF
1778: 
1779:             loc_cSQL       = "SELECT Usuarios, NComps FROM SigCdUsu" + ;
1780:                              " WHERE Usuarios = " + EscaparSQL(loc_cValor)
1781:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")
1782: 
1783:             IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
1784:                RECCOUNT("cursor_4c_ValUsu") > 0
1785:                 loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuarios)
1786:                 THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuarios))
1787:             ELSE
1788:                 IF USED("cursor_4c_ValUsu")
1789:                     USE IN cursor_4c_ValUsu
1790:                 ENDIF
1791:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1792:                 THIS.AbrirBuscaUsuars()
1793:                 RETURN
1794:             ENDIF
1795: 
1796:             IF USED("cursor_4c_ValUsu")

*-- Linhas 1818 a 1836:
1818: 
1819:                 IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
1820:                     IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
1821:                         SELECT cursor_4c_UltPer
1822:                         loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
1823:                         loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
1824:                         loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
1825:                                                               "N", UPPER(cursor_4c_UltPer.indivs))
1826:                         loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
1827:                         loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
1828:                         loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
1829:                         loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
1830:                     ENDIF
1831:                     IF USED("cursor_4c_UltPer")
1832:                         USE IN cursor_4c_UltPer
1833:                     ENDIF
1834:                 ENDIF
1835:             ENDIF
1836:         CATCH TO loc_oErro

*-- Linhas 1904 a 1924:
1904:                 RETURN
1905:             ENDIF
1906: 
1907:             loc_cSQL       = "SELECT CCargs, DCargs FROM SigCdCrg" + ;
1908:                              " WHERE CCargs = " + EscaparSQL(loc_cValor)
1909:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCrg")
1910: 
1911:             IF loc_nResultado > 0 AND USED("cursor_4c_ValCrg") AND ;
1912:                RECCOUNT("cursor_4c_ValCrg") > 0
1913:                 loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_ValCrg.CCargs)
1914:             ELSE
1915:                 IF USED("cursor_4c_ValCrg")
1916:                     USE IN cursor_4c_ValCrg
1917:                 ENDIF
1918:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1919:                 THIS.AbrirBuscaSetors()
1920:                 RETURN
1921:             ENDIF
1922: 
1923:             IF USED("cursor_4c_ValCrg")
1924:                 USE IN cursor_4c_ValCrg


### BO (C:\4c\projeto\app\classes\CVEBO.prg):
*==============================================================================
* CVEBO.prg - Business Object para Comissoes de Vendedores por Cargos
* Tabela: SigCcCmI (Comissoes por Cargo - Inidividual)
* Chave:  cidchaves CHAR(20) - PK unica gerada por fUniqueIds()
*==============================================================================

DEFINE CLASS CVEBO AS BusinessBase

	*--------------------------------------------------------------------------
	* Propriedades da entidade (SigCcCmI)
	*--------------------------------------------------------------------------

	*-- PK
	this_cCidchaves  = ""  && cidchaves char(20) - chave prim" + CHR(225) + "ria UUID

	*-- Identificacao do usuario e periodo
	this_cUsuars     = ""  && usuars   char(10) - usu" + CHR(225) + "rio
	this_cMess       = ""  && mess     char(2)  - m" + CHR(234) + "s de refer" + CHR(234) + "ncia (01-12)
	this_cAnos       = ""  && anos     char(4)  - ano de refer" + CHR(234) + "ncia (0001-9999)
	this_cIndivs     = ""  && indivs   char(1)  - vendedor individual (S/N)

	*-- Cargo e supervisor
	this_cSetors     = ""  && setors   char(10) - c" + CHR(243) + "digo do cargo (FK SigCdCrg.CCargs)
	this_cSupervs    = ""  && supervs  char(10) - supervisor do setor

	*-- Valores de comiss" + CHR(227) + "o
	this_nAdics      = 0   && adics    numeric(5,2)  - adicional (%)
	this_nMinimos    = 0   && minimos  numeric(11,2) - valor m" + CHR(237) + "nimo
	this_nMinExps    = 0   && minexps  numeric(11,2) - experi" + CHR(234) + "ncia m" + CHR(237) + "nima

	*==========================================================================
	* Init - Configura tabela e campo-chave
	*==========================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmI"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*==========================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Carrega propriedades a partir de um cursor
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cUsuars    = TratarNulo(usuars,    "C")
				THIS.this_cMess      = TratarNulo(mess,      "C")
				THIS.this_cAnos      = TratarNulo(anos,      "C")
				THIS.this_cIndivs    = TratarNulo(indivs,    "C")
				THIS.this_cSetors    = TratarNulo(setors,    "C")
				THIS.this_cSupervs   = TratarNulo(supervs,   "C")
				THIS.this_nAdics     = TratarNulo(adics,     "N")
				THIS.this_nMinimos   = TratarNulo(minimos,   "N")
				THIS.this_nMinExps   = TratarNulo(minexps,   "N")
				loc_lResultado = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*==========================================================================
	* Buscar - Retorna registros de SigCcCmI filtrados por periodo
	* par_cFiltro: "MM/AAAA" ou "MM/MMFINAL-AAAA/AAAFINAL" ou "" (todos)
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		LOCAL loc_cMesIni, loc_cMesFin, loc_cAnoIni, loc_cAnoFin
		loc_lSucesso = .F.

		TRY
			*-- Por default filtra pelo mes/ano atual
			loc_cMesIni = SUBSTR(DTOS(DATE()), 5, 2)
			loc_cMesFin = loc_cMesIni
			loc_cAnoIni = SUBSTR(DTOS(DATE()), 1, 4)
			loc_cAnoFin = loc_cAnoIni

			IF !EMPTY(par_cFiltro)
				*-- Aceita filtro no formato "MM/AAAA"
				IF LEN(ALLTRIM(par_cFiltro)) >= 7
					loc_cMesIni = LEFT(ALLTRIM(par_cFiltro), 2)
					loc_cMesFin = loc_cMesIni
					loc_cAnoIni = RIGHT(ALLTRIM(par_cFiltro), 4)
					loc_cAnoFin = loc_cAnoIni
				ENDIF
			ELSE
				*-- Sem filtro: trazer todos
				loc_cMesIni = "01"
				loc_cMesFin = "12"
				loc_cAnoIni = "0001"
				loc_cAnoFin = "9999"
			ENDIF

			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(loc_cMesIni) + ;
			           " AND " + EscaparSQL(loc_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(loc_cAnoIni) + ;
			           " AND " + EscaparSQL(loc_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* BuscarComFiltroPeriodo - Busca com mes/ano de filtro explicitoS
	*==========================================================================
	PROCEDURE BuscarComFiltroPeriodo(par_cMesIni, par_cMesFin, par_cAnoIni, par_cAnoFin)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(par_cMesIni) + ;
			           " AND " + EscaparSQL(par_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(par_cAnoIni) + ;
			           " AND " + EscaparSQL(par_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarComFiltroPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega comissao pela chave primaria (cidchaves)
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ENDIF
				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - Insere novo registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar UUID via SQL Server (fUniqueIds nao portada)
			IF EMPTY(THIS.this_cCidchaves)
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT NEWID() AS NovaChave", ;
				                         "cursor_4c_NovaChave")
				IF loc_nResultado >= 0 AND USED("cursor_4c_NovaChave") AND ;
				   RECCOUNT("cursor_4c_NovaChave") > 0
					THIS.this_cCidchaves = ALLTRIM(cursor_4c_NovaChave.NovaChave)
				ENDIF
				IF USED("cursor_4c_NovaChave")
					USE IN cursor_4c_NovaChave
				ENDIF
				IF EMPTY(THIS.this_cCidchaves)
					MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria!", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCcCmI" + ;
					           " (cidchaves, usuars, mess, anos, indivs," + ;
					           "  setors, supervs, adics, minimos, minexps)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
					           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
					           EscaparSQL(THIS.this_cMess)      + ", " + ;
					           EscaparSQL(THIS.this_cAnos)      + ", " + ;
					           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
					           EscaparSQL(THIS.this_cSetors)    + ", " + ;
					           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ELSE
				loc_cSQL = "INSERT INTO SigCcCmI" + ;
				           " (cidchaves, usuars, mess, anos, indivs," + ;
				           "  setors, supervs, adics, minimos, minexps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
				           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
				           EscaparSQL(THIS.this_cMess)      + ", " + ;
				           EscaparSQL(THIS.this_cAnos)      + ", " + ;
				           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
				           EscaparSQL(THIS.this_cSetors)    + ", " + ;
				           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
			IF USED("cursor_4c_NovaChave")
				USE IN cursor_4c_NovaChave
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - Atualiza registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCcCmI SET" + ;
			           "  usuars  = " + EscaparSQL(THIS.this_cUsuars)            + ", " + ;
			           "  mess    = " + EscaparSQL(THIS.this_cMess)              + ", " + ;
			           "  anos    = " + EscaparSQL(THIS.this_cAnos)              + ", " + ;
			           "  indivs  = " + EscaparSQL(THIS.this_cIndivs)            + ", " + ;
			           "  setors  = " + EscaparSQL(THIS.this_cSetors)            + ", " + ;
			           "  supervs = " + EscaparSQL(THIS.this_cSupervs)           + ", " + ;
			           "  adics   = " + FormatarNumeroSQL(THIS.this_nAdics)      + ", " + ;
			           "  minimos = " + FormatarNumeroSQL(THIS.this_nMinimos)    + ", " + ;
			           "  minexps = " + FormatarNumeroSQL(THIS.this_nMinExps)    + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - Exclui registro de SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmI - Verifica se usuario ja existe no periodo
	* Retorna "" se ok, mensagem de erro se duplicado
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmI()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos) + ;
			           " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupI")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupI") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo!!!"
				ENDIF
				IF USED("cursor_4c_DupI")
					USE IN cursor_4c_DupI
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmI: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmV - Verifica se usuario ja existe em SigCcCmV
	* (tabela de vendedores individuais) para o mesmo periodo
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmV()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmV" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupV")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupV") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo Como Vendedor Individual!!!"
				ENDIF
				IF USED("cursor_4c_DupV")
					USE IN cursor_4c_DupV
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmV: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* CarregarUltimoPeriodoUsuario - Carrega o ultimo periodo cadastrado para
	* o usuario (usado para auto-preencher o periodo seguinte em novos registros)
	*==========================================================================
	PROCEDURE CarregarUltimoPeriodoUsuario(par_cUsuars)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT TOP 1 cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(ALLTRIM(par_cUsuars)) + ;
			           " ORDER BY anos DESC, mess DESC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_UltPer") > 0
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarUltimoPeriodoUsuario: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CopiarPeriodo - Copia registros de um periodo para outro
	* par_cMesOri/par_cAnoOri: periodo de origem
	* par_cMesDes/par_cAnoDes: periodo de destino
	* Retorna .T. se copiou registros, .F. caso contrario
	*==========================================================================
	PROCEDURE CopiarPeriodo(par_cMesOri, par_cAnoOri, par_cMesDes, par_cAnoDes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lInseriu, loc_lOk
		LOCAL loc_cNovaChave, loc_cErroCopia
		loc_lSucesso = .F.
		loc_lInseriu = .F.
		loc_lOk      = .T.

		TRY
			*-- Busca registros do periodo de origem
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess = " + EscaparSQL(par_cMesOri) + ;
			           " AND anos = " + EscaparSQL(par_cAnoOri) + ;
			           " ORDER BY usuars"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Origem")
			IF loc_nResultado < 0
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem: " + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF RECCOUNT("cursor_4c_Origem") = 0
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + ;
					        CHR(237) + "odo de Origem Informado!!!", "")
				ELSE
					SELECT cursor_4c_Origem
					GO TOP
					SCAN
						*-- Verifica se vendedor ja existe no periodo destino
						loc_cSQL = "SELECT cidchaves FROM SigCcCmI" + ;
						           " WHERE usuars = " + EscaparSQL(cursor_4c_Origem.usuars) + ;
						           " AND mess = " + EscaparSQL(par_cMesDes) + ;
						           " AND anos = " + EscaparSQL(par_cAnoDes)

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")
						IF loc_nResultado >= 0
							IF RECCOUNT("cursor_4c_Busca") = 0
								*-- Insere novo registro no periodo destino
								loc_cNovaChave = fUniqueIds()
								loc_cSQL = "INSERT INTO SigCcCmI" + ;
								           " (cidchaves, usuars, mess, anos, indivs," + ;
								           "  setors, supervs, adics, minimos, minexps)" + ;
								           " VALUES (" + ;
								           EscaparSQL(loc_cNovaChave)                    + ", " + ;
								           EscaparSQL(cursor_4c_Origem.usuars)           + ", " + ;
								           EscaparSQL(par_cMesDes)                       + ", " + ;
								           EscaparSQL(par_cAnoDes)                       + ", " + ;
								           EscaparSQL(cursor_4c_Origem.indivs)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.setors)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.supervs)          + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.adics)     + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minimos)   + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minexps)   + ")"

								loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
								IF loc_nResultado >= 0
									loc_lInseriu = .T.
								ELSE
									loc_lOk = .F.
								ENDIF
							ENDIF
							IF USED("cursor_4c_Busca")
								USE IN cursor_4c_Busca
							ENDIF
						ELSE
							loc_lOk = .F.
						ENDIF
					ENDSCAN

					loc_lSucesso = loc_lInseriu AND loc_lOk
				ENDIF
			ENDIF

			IF USED("cursor_4c_Origem")
				USE IN cursor_4c_Origem
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CopiarPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

