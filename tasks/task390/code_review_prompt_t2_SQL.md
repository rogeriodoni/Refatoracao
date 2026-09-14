# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg) - TRECHOS RELEVANTES PARA PASS SQL (1975 linhas total):

*-- Linhas 629 a 647:
629:                 .HighlightBackColor = RGB(255, 255, 255)
630:                 .HighlightForeColor = RGB(15, 41, 104)
631:                 .HighlightStyle     = 2
632:                 .DeleteMark         = .F.
633:                 .RecordMark         = .F.
634:                 .RowHeight          = 16
635:                 .ScrollBars         = 2
636:                 .GridLines          = 3
637:                 .Visible            = .T.
638: 
639:                 WITH .Column1
640:                     .Width           = 110
641:                     .Header1.Caption = "Usu" + CHR(225) + "rio"
642:                 ENDWITH
643:                 WITH .Column2
644:                     .Width           = 35
645:                     .Header1.Caption = "M" + CHR(234) + "s"
646:                 ENDWITH
647:                 WITH .Column3

*-- Linhas 1139 a 1180:
1139:                     USE IN crSigCcCmI
1140:                 ENDIF
1141: 
1142:                 loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
1143:                            " Adics, Minimos, MinExps" + ;
1144:                            " FROM SigCcCmI" + ;
1145:                            " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
1146:                            " AND " + EscaparSQL(loc_cMesF) + ;
1147:                            " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
1148:                            " AND " + EscaparSQL(loc_cAnoF) + ;
1149:                            " ORDER BY Anos, Mess, Usuars, Setors"
1150: 
1151:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
1152: 
1153:                 IF loc_nResult < 0
1154:                     MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
1155:                             CapturarErroSQL(), "Erro SQL")
1156:                 ELSE
1157:                     loc_oGrid.RecordSource           = "crSigCcCmI"
1158:                     loc_oGrid.Column1.ControlSource  = "crSigCcCmI.Usuars"
1159:                     loc_oGrid.Column2.ControlSource  = "crSigCcCmI.Mess"
1160:                     loc_oGrid.Column3.ControlSource  = "crSigCcCmI.Anos"
1161:                     loc_oGrid.Column4.ControlSource  = "crSigCcCmI.Indivs"
1162:                     loc_oGrid.Column5.ControlSource  = "crSigCcCmI.Setors"
1163:                     loc_oGrid.Column6.ControlSource  = "crSigCcCmI.Adics"
1164:                     loc_oGrid.Column7.ControlSource  = "crSigCcCmI.Minimos"
1165:                     loc_oGrid.Column8.ControlSource  = "crSigCcCmI.MinExps"
1166: 
1167:                     loc_oGrid.Column1.Width           = 110
1168:                     loc_oGrid.Column2.Width           = 35
1169:                     loc_oGrid.Column3.Width           = 45
1170:                     loc_oGrid.Column4.Width           = 20
1171:                     loc_oGrid.Column5.Width           = 160
1172:                     loc_oGrid.Column6.Width           = 70
1173:                     loc_oGrid.Column7.Width           = 100
1174:                     loc_oGrid.Column8.Width           = 100
1175: 
1176:                     loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1177:                     loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
1178:                     loc_oGrid.Column3.Header1.Caption = "Ano"
1179:                     loc_oGrid.Column4.Header1.Caption = "V"
1180:                     loc_oGrid.Column5.Header1.Caption = "Cargo"

*-- Linhas 1256 a 1274:
1256:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1257:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1258:             ELSE
1259:                 SELECT crSigCcCmI
1260:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1261: 
1262:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1263:                     THIS.this_oBusinessObject.EditarRegistro()
1264:                     THIS.this_cModoAtual = "ALTERAR"
1265:                     THIS.BOParaForm()
1266:                     THIS.HabilitarCampos(.T.)
1267:                     THIS.AjustarBotoesPorModo()
1268:                     THIS.AlternarPagina(2)
1269:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
1270:                 ELSE
1271:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
1272:                 ENDIF
1273:             ENDIF
1274:         CATCH TO loc_oErro

*-- Linhas 1286 a 1304:
1286:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1287:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1288:             ELSE
1289:                 SELECT crSigCcCmI
1290:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1291: 
1292:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1293:                     THIS.this_cModoAtual = "VISUALIZAR"
1294:                     THIS.BOParaForm()
1295:                     THIS.HabilitarCampos(.F.)
1296:                     THIS.AjustarBotoesPorModo()
1297:                     THIS.AlternarPagina(2)
1298:                 ELSE
1299:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
1300:                 ENDIF
1301:             ENDIF
1302:         CATCH TO loc_oErro
1303:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1304:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")

*-- Linhas 1314 a 1332:
1314:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1315:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1316:             ELSE
1317:                 SELECT crSigCcCmI
1318:                 loc_cChave   = ALLTRIM(crSigCcCmI.cIdChaves)
1319:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
1320:                                             "Excluir")
1321: 
1322:                 IF loc_lConfirma
1323:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1324:                         IF THIS.this_oBusinessObject.Excluir()
1325:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1326:                             THIS.CarregarLista()
1327:                         ELSE
1328:                             MsgErro("Erro ao excluir registro!", "Erro")
1329:                         ENDIF
1330:                     ELSE
1331:                         MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
1332:                     ENDIF

*-- Linhas 1458 a 1511:
1458:                 loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
1459:             ELSE
1460:                 *-- Verificar se destino ja tem registros
1461:                 loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
1462:                            " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
1463:                            " AND Anos = " + EscaparSQL(loc_cDAnos)
1464: 
1465:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")
1466: 
1467:                 IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
1468:                    cursor_4c_VerifDest.Total > 0
1469:                     IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
1470:                                    " possui registros. Deseja sobrepor?", "Confirmar")
1471:                         loc_lCopiar = .T.
1472:                     ENDIF
1473:                 ELSE
1474:                     loc_lCopiar = .T.
1475:                 ENDIF
1476: 
1477:                 IF USED("cursor_4c_VerifDest")
1478:                     USE IN cursor_4c_VerifDest
1479:                 ENDIF
1480: 
1481:                 IF loc_lCopiar
1482:                     loc_cSQL = "INSERT INTO SigCcCmI" + ;
1483:                                " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1484:                                " Mess, Anos)" + ;
1485:                                " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1486:                                " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
1487:                                " FROM SigCcCmI" + ;
1488:                                " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
1489:                                " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
1490:                                " AND NOT EXISTS (" + ;
1491:                                "   SELECT 1 FROM SigCcCmI d" + ;
1492:                                "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
1493:                                "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
1494:                                "   AND d.Usuars = SigCcCmI.Usuars)"
1495: 
1496:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")
1497: 
1498:                     IF loc_nResult >= 0
1499:                         MsgInfo("Per" + CHR(237) + "odo copiado com sucesso!", "")
1500:                         THIS.BtnCancelarCopiaClick()
1501:                         THIS.CarregarLista()
1502:                     ELSE
1503:                         MsgErro("Erro ao copiar per" + CHR(237) + "odo: " + ;
1504:                                 CapturarErroSQL(), "Erro SQL")
1505:                     ENDIF
1506: 
1507:                     IF USED("cursor_4c_CopRes")
1508:                         USE IN cursor_4c_CopRes
1509:                     ENDIF
1510:                 ENDIF
1511:                 ENDIF

*-- Linhas 1777 a 1797:
1777:                 RETURN
1778:             ENDIF
1779: 
1780:             loc_cSQL       = "SELECT Usuars, NComps FROM SigCdUsu" + ;
1781:                              " WHERE Usuars = " + EscaparSQL(loc_cValor)
1782:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")
1783: 
1784:             IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
1785:                RECCOUNT("cursor_4c_ValUsu") > 0
1786:                 loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuars)
1787:                 THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuars))
1788:             ELSE
1789:                 IF USED("cursor_4c_ValUsu")
1790:                     USE IN cursor_4c_ValUsu
1791:                 ENDIF
1792:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1793:                 THIS.AbrirBuscaUsuars()
1794:                 RETURN
1795:             ENDIF
1796: 
1797:             IF USED("cursor_4c_ValUsu")

*-- Linhas 1819 a 1837:
1819: 
1820:                 IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
1821:                     IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
1822:                         SELECT cursor_4c_UltPer
1823:                         loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
1824:                         loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
1825:                         loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
1826:                                                               "N", UPPER(cursor_4c_UltPer.indivs))
1827:                         loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
1828:                         loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
1829:                         loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
1830:                         loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
1831:                     ENDIF
1832:                     IF USED("cursor_4c_UltPer")
1833:                         USE IN cursor_4c_UltPer
1834:                     ENDIF
1835:                 ENDIF
1836:             ENDIF
1837:         CATCH TO loc_oErro

*-- Linhas 1905 a 1925:
1905:                 RETURN
1906:             ENDIF
1907: 
1908:             loc_cSQL       = "SELECT CCargs, DCargs FROM SigCdCrg" + ;
1909:                              " WHERE CCargs = " + EscaparSQL(loc_cValor)
1910:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCrg")
1911: 
1912:             IF loc_nResultado > 0 AND USED("cursor_4c_ValCrg") AND ;
1913:                RECCOUNT("cursor_4c_ValCrg") > 0
1914:                 loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_ValCrg.CCargs)
1915:             ELSE
1916:                 IF USED("cursor_4c_ValCrg")
1917:                     USE IN cursor_4c_ValCrg
1918:                 ENDIF
1919:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1920:                 THIS.AbrirBuscaSetors()
1921:                 RETURN
1922:             ENDIF
1923: 
1924:             IF USED("cursor_4c_ValCrg")
1925:                 USE IN cursor_4c_ValCrg


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

