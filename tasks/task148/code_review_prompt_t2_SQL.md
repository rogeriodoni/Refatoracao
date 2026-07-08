# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, 1, XNENS, GERBALS, _CHAVENENS, PCESCOLHA, I, CODIGOS, EMPS, GRUPOS, CONTAS

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
  ControlSource = "tmpnens.datas"
  ControlSource = "tmpnens.grupoos"
  ControlSource = "tmpnens.contaos"
  ControlSource = "tmpnens.grupods"
  ControlSource = "tmpnens.contads"
  ControlSource = "tmpnens.grvends"
  ControlSource = "tmpnens.vends"
  ControlSource = "TmpNens.Obss"
Select * From GravaNens Where 0=1 Into Cursor TmpNens ReadWrite
Select *, 000000.000 as ps2FaseAnt, Space(3) as cUnips, .f. as OsRets, .f. as Retrabs, Space(10) as MatPrincs,;
From GravaNensI Where 1=0 Into Cursor xNensi ReadWrite
Select xNensi
Select * From xNensi Where 0=1 Into Cursor xNensiE ReadWrite
Select * From xNensI Where 0=1 Into Cursor xNensiS ReadWrite
Select *, 0 as Autos, 00000 as BaseMins, 000000.000 as PesoAntigo, Space(30) as DRetrabs, .f. as Justs ;
From GravaMfas where 0=1 Into Cursor xMfas ReadWrite
Select xMFas
Select *, 0 as Autos, 00000 as BaseMins, 000000.000 as PesoAntigo ;
From GravaMfas where 0=1 Into Cursor xMfas2 ReadWrite
Select xMFas2
	Select csTemporario
	=Seek(ThisForm.Pagina.Dados.cntDados.get_codigo.Value, 'csTemporario', 'Numps')
		Select crSigCdOpd
		Select crSigCdSvc
		lcQuery = [Select Codigos, Descrs, TrfPesas, CompAgrus ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpGccr') < 1)
		Select TmpGccr
		Select csTemporario
			.DeleteMark   = .f.
			.Column1.ControlSource = 'TmpOperacao.Codigos'
Select crSigCdNec
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
Select TmpNens
	Select crSigCdNec
		Select TmpNens
	Select crSigCdNec
		Insert Into TmpNens (Chksubn, Datars, Datas, Datatrans, Dopps, Emps, Numps, Usuars, TotPesos, ;
		=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
		=Seek(crSigCdOpd.Nivels, 'crSigCdOpd', 'Dopps')
		=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
		Select crSigPdMvf
			Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, ;
			If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
				Insert Into TmpOperacao (Codigos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs)
			Select crSigOpPic
				Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes, ;
		Select crSigCdNei
					Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, ;
						If Not Seek(Str(_Nenv, 10) + _BMat + _TMat, 'xNensi', 'NEnvTpops')
							Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, Cats, TpOps, Servicos) ;
						Select xNensi
					If Not Seek(crSigCdNei.Cats, 'xNensi', 'Cats') Or crSigCdNei.FlagIncs
						Insert Into xNensi (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
			Select crSigCdNei
		Select crSigOpEtq
			Insert Into xPesa (Cbars, Cpros, Peso, Qtds, Emps, Dopes, Numes, Nops, Oper, Conta, Obs, Cors, Tams) ;
	=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
	Select crSigCdOpd
		Select TmpNens
	Select TmpNens
Select TmpNens
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
	Select crSigCdNec
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
Select TmpNens
	Select TmpOperacao
	lcQuery = [Select Codigos, Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select LocalFecha
	lcQuery = [Select Codigos, Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select LocalFecha
	Select xMfas
	Select xNensi
	Select xNensi
		Select xOpi
		Select xPesa
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
	=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp7.prg) - TRECHOS RELEVANTES PARA PASS SQL (2086 linhas total):

*-- Linhas 74 a 107:
74:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
75:                 MostrarErro("Erro ao criar sigpdmp7BO", "Erro Cr" + CHR(237) + "tico")
76:             ELSE
77:                 *-- Cursor placeholder para grid de lista (SigCdNec - colunas do SELECT do BO)
78:                 IF !USED("cursor_4c_Dados")
79:                     SET NULL ON
80:                     CREATE CURSOR cursor_4c_Dados (;
81:                         cidchaves C(20), empdnps C(33), emps C(3),;
82:                         dopps C(20), numps N(10,0), datas D,;
83:                         totpesos N(11,3), usuars C(10),;
84:                         grupoos C(10), contaos C(10),;
85:                         grupods C(10), contads C(10))
86:                     SET NULL OFF
87:                 ENDIF
88: 
89:                 *-- Cursor placeholder para GradeOperacao (TmpOperacao - legado: criacursor)
90:                 IF !USED("TmpOperacao")
91:                     SET NULL ON
92:                     CREATE CURSOR TmpOperacao (Codigos N(12,0))
93:                     SET NULL OFF
94:                 ENDIF
95: 
96:                 THIS.ConfigurarPageFrame()
97:                 THIS.ConfigurarPaginaLista()
98:                 THIS.ConfigurarPaginaDados()
99: 
100:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
101:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102: 
103:                 *-- Inicializar empresa via sistema global se nao recebida via parametro
104:                 IF EMPTY(THIS.this_cPEmps) AND VARTYPE(go_4c_Sistema) = "O"
105:                     THIS.this_cPEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
106:                 ENDIF
107: 

*-- Linhas 355 a 373:
355:             .HighlightBackColor = RGB(255, 255, 255)
356:             .HighlightForeColor = RGB(15, 41, 104)
357:             .HighlightStyle     = 2
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .GridLines          = 3
363:             .Column1.Width      = 70
364:             .Column2.Width      = 80
365:             .Column3.Width      = 80
366:             .Column4.Width      = 120
367:             .Column5.Width      = 100
368:             .Column6.Width      = 80
369:             .Column7.Width      = 80
370:             .Column8.Width      = 80
371:             .Column9.Width      = 80
372:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
373:             .Column2.Header1.Caption = "Data"

*-- Linhas 1093 a 1111:
1093: 
1094:         *----------------------------------------------------------------------
1095:         *-- EditBox Observacao (Mm_obs - Top=353+29=382, Left=592, Width=397, Height=205)
1096:         *-- Legado: ControlSource = "TmpNens.Obss"
1097:         *----------------------------------------------------------------------
1098:         loc_oPagina.AddObject("obj_4c_Mm_obs", "EditBox")
1099:         WITH loc_oPagina.obj_4c_Mm_obs
1100:             .Value     = ""
1101:             .Top       = 382
1102:             .Left      = 592
1103:             .Width     = 397
1104:             .Height    = 205
1105:             .FontName  = "Tahoma"
1106:             .FontSize  = 8
1107:             .ForeColor = RGB(0, 0, 0)
1108:             .BackColor = RGB(255, 255, 255)
1109:             .Enabled   = .T.
1110:             .Visible   = .T.
1111:         ENDWITH

*-- Linhas 1131 a 1149:
1131:             .HighlightBackColor = RGB(255, 255, 255)
1132:             .HighlightForeColor = RGB(15, 41, 104)
1133:             .HighlightStyle     = 2
1134:             .DeleteMark         = .F.
1135:             .RecordMark         = .F.
1136:             .ReadOnly           = .T.
1137:             .RowHeight          = 16
1138:             .ScrollBars         = 2
1139:             .GridLines          = 3
1140:             .HeaderHeight       = 17
1141:             .Column1.Width      = 94
1142:             .Column1.Movable    = .F.
1143:             .Column1.Resizable  = .F.
1144:             .Column1.FontName   = "Courier New"
1145:             .Column1.Format     = "KLZ"
1146:             .Column1.InputMask  = "999999999999"
1147:             .Column1.Visible    = .F.
1148:             .Column1.Header1.Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
1149:             .Column1.Header1.FontName  = "Tahoma"

*-- Linhas 1155 a 1173:
1155:         *-- Vincular RecordSource do grid ao cursor TmpOperacao (criado em InicializarForm)
1156:         IF USED("TmpOperacao")
1157:             loc_oPagina.grd_4c_Dados.RecordSource = "TmpOperacao"
1158:             loc_oPagina.grd_4c_Dados.Column1.ControlSource = "TmpOperacao.Codigos"
1159:         ENDIF
1160: 
1161:         *-- BINDEVENTs para botoes de acao da Page2
1162:         BINDEVENT(loc_oPagina.cmd_4c_Operacao,    "Click", THIS, "BtnOperacaoClick")
1163:         BINDEVENT(loc_oPagina.cmd_4c_Componentes, "Click", THIS, "BtnComponentesClick")
1164:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,   "Click", THIS, "BtnEtiquetasClick")
1165:         BINDEVENT(loc_oPagina.cmd_4c_Dados,       "Click", THIS, "BtnDadosClick")
1166:         BINDEVENT(loc_oPagina.cmd_4c_Boleto,      "Click", THIS, "BtnBoletoClick")
1167:         BINDEVENT(loc_oPagina.cmd_4c_Documento,   "Click", THIS, "BtnDocumentoClick")
1168: 
1169:         *-- Vincular eventos dos botoes da Page2
1170:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1171:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1172: 
1173:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 1199 a 1225:
1199:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1200:                         loc_oGrid.ColumnCount = 9
1201:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1202:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
1203:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
1204:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totpesos"
1205:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.dopps"
1206:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.usuars"
1207:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupoos"
1208:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contaos"
1209:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.grupods"
1210:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.contads"
1211:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1212:                         loc_oGrid.Column2.Header1.Caption = "Data"
1213:                         loc_oGrid.Column3.Header1.Caption = "Peso"
1214:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1215:                         loc_oGrid.Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
1216:                         loc_oGrid.Column6.Header1.Caption = "Gr.Origem"
1217:                         loc_oGrid.Column7.Header1.Caption = "Ct.Origem"
1218:                         loc_oGrid.Column8.Header1.Caption = "Gr.Destino"
1219:                         loc_oGrid.Column9.Header1.Caption = "Ct.Destino"
1220:                         THIS.FormatarGridLista(loc_oGrid)
1221:                     ENDIF
1222:                     loc_lResultado = .T.
1223:                 ENDIF
1224:             ENDIF
1225:         CATCH TO loException

*-- Linhas 1298 a 1316:
1298:     *--------------------------------------------------------------------------
1299:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)
1300:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1301:             SELECT cursor_4c_Dados
1302:             THIS.this_cDopp = ALLTRIM(cursor_4c_Dados.dopps)
1303:         ENDIF
1304:     ENDPROC
1305: 
1306:     *--------------------------------------------------------------------------
1307:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
1308:     *--------------------------------------------------------------------------
1309:     PROCEDURE BtnIncluirClick()
1310:         THIS.this_oBusinessObject.NovoRegistro()
1311:         THIS.LimparCampos()
1312:         THIS.this_cPcEscolha  = "INSERIR"
1313:         THIS.this_cModoAtual  = "INCLUIR"
1314:         THIS.HabilitarCampos(.T.)
1315:         THIS.AjustarBotoesPorModo()
1316:         THIS.AlternarPagina(2)

*-- Linhas 1325 a 1343:
1325:             MsgAviso("Selecione um registro para visualizar.", "")
1326:             RETURN
1327:         ENDIF
1328:         SELECT cursor_4c_Dados
1329:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1330:         IF EMPTY(loc_cCodigo)
1331:             MsgAviso("Selecione um registro para visualizar.", "")
1332:             RETURN
1333:         ENDIF
1334:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1335:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1336:             THIS.this_cPcEscolha = "CONSULTAR"
1337:             THIS.this_cModoAtual = "VISUALIZAR"
1338:             THIS.BOParaForm()
1339:             THIS.HabilitarCampos(.F.)
1340:             THIS.AjustarBotoesPorModo()
1341:             THIS.AlternarPagina(2)
1342:         ELSE
1343:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")

*-- Linhas 1353 a 1371:
1353:             MsgAviso("Selecione um registro para alterar.", "")
1354:             RETURN
1355:         ENDIF
1356:         SELECT cursor_4c_Dados
1357:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1358:         IF EMPTY(loc_cCodigo)
1359:             MsgAviso("Selecione um registro para alterar.", "")
1360:             RETURN
1361:         ENDIF
1362:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1363:             THIS.this_oBusinessObject.EditarRegistro()
1364:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1365:             THIS.this_cPcEscolha = "ALTERAR"
1366:             THIS.this_cModoAtual = "ALTERAR"
1367:             THIS.BOParaForm()
1368:             THIS.HabilitarCampos(.T.)
1369:             THIS.AjustarBotoesPorModo()
1370:             THIS.AlternarPagina(2)
1371:         ELSE

*-- Linhas 1382 a 1400:
1382:             MsgAviso("Selecione um registro para excluir.", "")
1383:             RETURN
1384:         ENDIF
1385:         SELECT cursor_4c_Dados
1386:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1387:         IF EMPTY(loc_cCodigo)
1388:             MsgAviso("Selecione um registro para excluir.", "")
1389:             RETURN
1390:         ENDIF
1391:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar Exclus" + CHR(227) + "o")
1392:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1393:                 IF THIS.this_oBusinessObject.Excluir()
1394:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1395:                     THIS.CarregarLista()
1396:                 ELSE
1397:                     MsgErro("Erro ao excluir o registro.", "Erro")
1398:                 ENDIF
1399:             ELSE
1400:                 MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")

*-- Linhas 1764 a 1782:
1764:             *-- Verifica se ja existem envelopes/ops lancados (TmpOperacao)
1765:             *-- Legado: Count to _LnCont For Codigos > 0
1766:             IF USED("TmpOperacao")
1767:                 SELECT TmpOperacao
1768:                 COUNT TO loc_nContEnv FOR Codigos > 0
1769:                 IF loc_nContEnv > 0
1770:                     MsgAviso("A Data s" + CHR(243) + "mente pode ser alterada antes de Informar Envelopes/Ops", "")
1771:                     loc_lBloqueado = .T.
1772:                 ENDIF
1773:             ENDIF
1774: 
1775:             *-- Verifica bloqueio de periodo no BO
1776:             IF !loc_lBloqueado
1777:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1778:                     IF THIS.this_oBusinessObject.VerificarPeriodoBloqueado(loc_dData)
1779:                         MsgAviso("Per" + CHR(237) + "odo Bloqueado!!!", "")
1780:                         loc_lBloqueado = .T.
1781:                     ENDIF
1782:                 ENDIF

*-- Linhas 1793 a 1901:
1793: 
1794:     *--------------------------------------------------------------------------
1795:     * BtnOperacaoClick - Abre sub-formulario de operacoes (legado: SigPdMp5)
1796:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xMfas -> Do Form SigPdMp5
1797:     *--------------------------------------------------------------------------
1798:     PROCEDURE BtnOperacaoClick()
1799:         LOCAL loc_cFormPath
1800:         IF THIS.this_cPcEscolha = "PROCURAR"
1801:             RETURN
1802:         ENDIF
1803:         TRY
1804:             THIS.Enabled = .F.
1805:             IF USED("xMfas")
1806:                 SELECT xMfas
1807:                 SET ORDER TO
1808:             ENDIF
1809:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp5.scx"
1810:             IF FILE(loc_cFormPath)
1811:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1812:             ELSE
1813:                 MsgAviso("Subformul" + CHR(225) + "rio de Opera" + CHR(231) + CHR(245) + "es (SigPdMp5) n" + ;
1814:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1815:             ENDIF
1816:             THIS.Enabled = .T.
1817:         CATCH TO loException
1818:             THIS.Enabled = .T.
1819:             MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
1820:         ENDTRY
1821:     ENDPROC
1822: 
1823:     *--------------------------------------------------------------------------
1824:     * BtnComponentesClick - Abre sub-formulario de componentes (legado: SigPdMp2)
1825:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xNensi -> Do Form SigPdMp2
1826:     *--------------------------------------------------------------------------
1827:     PROCEDURE BtnComponentesClick()
1828:         LOCAL loc_cFormPath
1829:         IF THIS.this_cPcEscolha = "PROCURAR"
1830:             RETURN
1831:         ENDIF
1832:         TRY
1833:             THIS.Enabled = .F.
1834:             IF USED("xNensi")
1835:                 SELECT xNensi
1836:                 SET ORDER TO
1837:             ENDIF
1838:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp2.scx"
1839:             IF FILE(loc_cFormPath)
1840:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1841:             ELSE
1842:                 MsgAviso("Subformul" + CHR(225) + "rio de Componentes (SigPdMp2) n" + ;
1843:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1844:             ENDIF
1845:             THIS.Enabled = .T.
1846:         CATCH TO loException
1847:             THIS.Enabled = .T.
1848:             MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loException.Message, "Erro")
1849:         ENDTRY
1850:     ENDPROC
1851: 
1852:     *--------------------------------------------------------------------------
1853:     * BtnEtiquetasClick - Abre sub-formulario de etiquetas/pesagem
1854:     * Legado: If pcEscolha<>'PROCURAR':
1855:     *   If crSigCdPam.AltPesas=1 -> Select xOpi -> Do Form SigPdMp3
1856:     *   Else -> Select xPesa -> Do Form SigPdMp9
1857:     *--------------------------------------------------------------------------
1858:     PROCEDURE BtnEtiquetasClick()
1859:         LOCAL loc_cFormPath, loc_lAltPesas
1860:         IF THIS.this_cPcEscolha = "PROCURAR"
1861:             RETURN
1862:         ENDIF
1863:         TRY
1864:             THIS.Enabled = .F.
1865:             loc_lAltPesas = .F.
1866: 
1867:             *-- Verifica flag AltPesas no cursor de parametros (crSigCdPam)
1868:             IF USED("crSigCdPam") AND PEMSTATUS(crSigCdPam, "AltPesas", 8)
1869:                 loc_lAltPesas = (crSigCdPam.AltPesas = 1)
1870:             ENDIF
1871: 
1872:             IF loc_lAltPesas
1873:                 IF USED("xOpi")
1874:                     SELECT xOpi
1875:                     GO TOP
1876:                 ENDIF
1877:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp3.scx"
1878:                 IF FILE(loc_cFormPath)
1879:                     DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1880:                 ELSE
1881:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp3) n" + ;
1882:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1883:                 ENDIF
1884:             ELSE
1885:                 IF USED("xPesa")
1886:                     SELECT xPesa
1887:                     GO TOP
1888:                 ENDIF
1889:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp9.scx"
1890:                 IF FILE(loc_cFormPath)
1891:                     DO FORM (loc_cFormPath) WITH THIS
1892:                 ELSE
1893:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp9) n" + ;
1894:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1895:                 ENDIF
1896:             ENDIF
1897:             THIS.Enabled = .T.
1898:         CATCH TO loException
1899:             THIS.Enabled = .T.
1900:             MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loException.Message, "Erro")
1901:         ENDTRY

*-- Linhas 1929 a 1947:
1929:         loc_lPermite = .F.
1930:         TRY
1931:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1932:                 SELECT crSigCdOpd
1933:                 SET NEAR ON
1934:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1935:                 SET NEAR OFF
1936:                 IF FOUND() AND !EOF("crSigCdOpd")
1937:                     loc_lPermite = (crSigCdOpd.Boletos = 1)
1938:                 ENDIF
1939:             ENDIF
1940:             IF loc_lPermite
1941:                 THIS.ImpBol()
1942:             ELSE
1943:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1944:                     "o permite impress" + CHR(227) + "o de boleto.", "")
1945:             ENDIF
1946:         CATCH TO loException
1947:             MostrarErro("Erro ao imprimir boleto:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1957 a 1988:
1957:         loc_lPermite = .F.
1958:         TRY
1959:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1960:                 SELECT crSigCdOpd
1961:                 SET NEAR ON
1962:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1963:                 SET NEAR OFF
1964:                 IF FOUND() AND !EOF("crSigCdOpd")
1965:                     loc_lPermite = (crSigCdOpd.Docus = 1)
1966:                 ENDIF
1967:             ENDIF
1968:             IF loc_lPermite AND USED("TmpNens") AND !EOF("TmpNens")
1969:                 SELECT TmpNens
1970: 
1971:                 *-- Atualiza cursor crSigCdNec para registro corrente
1972:                 IF USED("crSigCdOpd")
1973:                     SELECT crSigCdOpd
1974:                     SET NEAR ON
1975:                     SEEK ALLTRIM(TmpNens.Dopps) ORDER TAG Dopps
1976:                     SET NEAR OFF
1977:                 ENDIF
1978: 
1979:                 loc_cPrgPath = gc_4c_CaminhoBase + "..\Framework\SigPrIdc.prg"
1980:                 IF FILE(loc_cPrgPath)
1981:                     DO (loc_cPrgPath) WITH ;
1982:                         ALLTRIM(TmpNens.Emps), ALLTRIM(TmpNens.Dopps), TmpNens.Numps, ;
1983:                         0, crSigCdOpd.QtdDocs, .F., .F., .F., .F., .F., .F., THIS
1984:                 ELSE
1985:                     MsgAviso("Rotina de impress" + CHR(227) + "o de documento (SigPrIdc) n" + ;
1986:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1987:                 ENDIF
1988:             ELSE

*-- Linhas 2025 a 2043:
2025: 
2026:             *-- Posiciona cursor de operacoes no Dopp corrente
2027:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
2028:                 SELECT crSigCdOpd
2029:                 SET NEAR ON
2030:                 SEEK THIS.this_cDopp ORDER TAG Dopps
2031:                 SET NEAR OFF
2032:             ENDIF
2033: 
2034:             *-- Coloca foco no campo adequado conforme modo
2035:             IF THIS.this_lAtFoco
2036:                 THIS.this_lAtFoco = .F.
2037:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2038: 
2039:                 DO CASE
2040:                     CASE THIS.this_cPcEscolha = "PROCURAR"
2041:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND ;
2042:                            PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
2043:                             loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.SetFocus

*-- Linhas 2053 a 2071:
2053: 
2054:             *-- Garantir cursor TmpNens no topo se disponivel
2055:             IF USED("TmpNens")
2056:                 SELECT TmpNens
2057:                 GO TOP
2058:             ENDIF
2059: 
2060:         CATCH TO loException
2061:             *-- Erros de foco nao devem travar a interface
2062:         ENDTRY
2063:     ENDPROC
2064: 
2065:     *--------------------------------------------------------------------------
2066:     * Destroy - Libera recursos ao fechar o formulario
2067:     *--------------------------------------------------------------------------
2068:     PROCEDURE Destroy()
2069:         LOCAL loc_oErro
2070:         TRY
2071:             IF USED("cursor_4c_Dados")


### BO (C:\4c\projeto\app\classes\sigpdmp7BO.prg):
*==============================================================================
* sigpdmp7BO.prg - Business Object para Movimentacao por Funcionario
* Tabela principal: SigCdNec | PK: cidchaves
* Chave de negocio: empdnps (emps + dopps + str(numps,10))
*==============================================================================

DEFINE CLASS sigpdmp7BO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdNec)
    *-- Identificacao / chaves
    this_cCidchaves  = ""   && cidchaves CHAR(20)   - PK do sistema
    this_cEmpdnps    = ""   && empdnps   CHAR(33)   - Chave de negocio (emps+dopps+numps)
    this_cEmps       = ""   && emps      CHAR(3)    - Empresa
    this_cEmpds      = ""   && empds     CHAR(3)    - Empresa destino
    this_cDopps      = ""   && dopps     CHAR(20)   - Operacao
    this_nNumps      = 0    && numps     NUMERIC(10)- Numero do processo

    *-- Datas
    this_dDatas      = {}   && datas     DATETIME   - Data da movimentacao
    this_dDatars     = {}   && datars    DATETIME   - Data de registro
    this_dDatatrans  = {}   && datatrans DATETIME   - Data da transacao

    *-- Totais e pesos
    this_nTotpesos   = 0    && totpesos  NUMERIC(11,3) - Total de pesos
    this_nPesolancs  = 0    && pesolancs NUMERIC(11,3) - Peso lancado

    *-- Grupos e contas - Origem
    this_cGrupoos    = ""   && grupoos   CHAR(10)   - Grupo de Origem
    this_cContaos    = ""   && contaos   CHAR(10)   - Conta de Origem

    *-- Grupos e contas - Destino
    this_cGrupods    = ""   && grupods   CHAR(10)   - Grupo de Destino
    this_cContads    = ""   && contads   CHAR(10)   - Conta de Destino

    *-- Responsavel/Vendedor
    this_cGrvends    = ""   && grvends   CHAR(10)   - Grupo do responsavel
    this_cVends      = ""   && vends     CHAR(10)   - Vendedor/Responsavel

    *-- Observacao
    this_cObss       = ""   && obss      TEXT       - Observacao

    *-- Usuario
    this_cUsuars     = ""   && usuars    CHAR(10)   - Usuario lancamento
    this_cUsulibs    = ""   && usulibs   CHAR(10)   - Usuario liberacao
    this_cUsuconfs   = ""   && usuconfs  CHAR(10)   - Usuario confirmacao

    *-- Documentos e localidade
    this_cDocus      = ""   && docus     CHAR(10)   - Documento
    this_cLocals     = ""   && locals    CHAR(10)   - Local
    this_cJobs       = ""   && jobs      CHAR(10)   - Job
    this_cCodnconfs  = ""   && codnconfs CHAR(10)   - Codigo nao conformidade
    this_cLibprods   = ""   && libprods  CHAR(10)   - Liberacao producao

    *-- Contadores numericos
    this_nNtrans     = 0    && ntrans    NUMERIC(6) - Numero transacao
    this_nNops       = 0    && nops      NUMERIC(10)- Numero de operacoes
    this_nNaceites   = 0    && naceites  NUMERIC(10)- Numero de aceites
    this_nNumbalds   = 0    && numbalds  NUMERIC(6) - Numero balancete dest
    this_nNumbals    = 0    && numbals   NUMERIC(6) - Numero balancete orig
    this_nCodobs     = 0    && codobs    NUMERIC(3) - Codigo observacao
    this_nNlotes     = 0    && nlotes    NUMERIC(10)- Numero do lote
    this_nChkbaixa   = 0    && chkbaixa  NUMERIC(1) - Check baixa

    *-- Flags logicos (bit)
    this_lChksubn    = .F.  && chksubn   BIT        - Check sub-numero
    this_lImprs      = .F.  && imprs     BIT        - Impresso
    this_lLccs       = .F.  && lccs      BIT        - LCC
    this_lProcbals   = .F.  && procbals  BIT        - Processado balanco orig
    this_lProcdbal   = .F.  && procdbal  BIT        - Processado balanco dest
    this_lRetrabs    = .F.  && retrabs   BIT        - Retrabalho
    this_lAutos      = .F.  && autos     BIT        - Automatico
    this_lNconforms  = .F.  && nconforms BIT        - Nao conformidade

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao inicializar sigpdmp7BO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveComposta - Calcula empdnps a partir dos componentes
    *--------------------------------------------------------------------------
    FUNCTION MontarChaveComposta()
        LOCAL loc_cChave
        loc_cChave = PADR(ALLTRIM(THIS.this_cEmps),  3) + ;
                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                     STR(THIS.this_nNumps, 10)
        THIS.this_cEmpdnps = loc_cChave
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do cursor informado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave primaria e chave composta
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
            THIS.this_cEmpdnps    = TratarNulo(empdnps,    "")
            THIS.this_cEmps       = TratarNulo(emps,       "")
            THIS.this_cEmpds      = TratarNulo(empds,      "")
            THIS.this_cDopps      = TratarNulo(dopps,      "")
            THIS.this_nNumps      = TratarNulo(numps,       0)

            *-- Datas (SQLEXEC retorna DateTime)
            THIS.this_dDatas     = IIF(VARTYPE(datas)     = "T", TTOD(datas),     TratarNulo(datas,     {}))
            THIS.this_dDatars    = IIF(VARTYPE(datars)    = "T", TTOD(datars),    TratarNulo(datars,    {}))
            THIS.this_dDatatrans = IIF(VARTYPE(datatrans) = "T", TTOD(datatrans), TratarNulo(datatrans, {}))

            *-- Totais
            THIS.this_nTotpesos   = TratarNulo(totpesos,   0)
            THIS.this_nPesolancs  = TratarNulo(pesolancs,  0)

            *-- Origem
            THIS.this_cGrupoos    = TratarNulo(grupoos,    "")
            THIS.this_cContaos    = TratarNulo(contaos,    "")

            *-- Destino
            THIS.this_cGrupods    = TratarNulo(grupods,    "")
            THIS.this_cContads    = TratarNulo(contads,    "")

            *-- Responsavel
            THIS.this_cGrvends    = TratarNulo(grvends,    "")
            THIS.this_cVends      = TratarNulo(vends,      "")

            *-- Observacao (campo text/memo)
            THIS.this_cObss       = TratarNulo(obss,       "")

            *-- Usuarios
            THIS.this_cUsuars     = TratarNulo(usuars,     "")
            THIS.this_cUsulibs    = TratarNulo(usulibs,    "")
            THIS.this_cUsuconfs   = TratarNulo(usuconfs,   "")

            *-- Documentos e localidade
            THIS.this_cDocus      = TratarNulo(docus,      "")
            THIS.this_cLocals     = TratarNulo(locals,     "")
            THIS.this_cJobs       = TratarNulo(jobs,       "")
            THIS.this_cCodnconfs  = TratarNulo(codnconfs,  "")
            THIS.this_cLibprods   = TratarNulo(libprods,   "")

            *-- Contadores numericos
            THIS.this_nNtrans     = TratarNulo(ntrans,      0)
            THIS.this_nNops       = TratarNulo(nops,        0)
            THIS.this_nNaceites   = TratarNulo(naceites,    0)
            THIS.this_nNumbalds   = TratarNulo(numbalds,    0)
            THIS.this_nNumbals    = TratarNulo(numbals,     0)
            THIS.this_nCodobs     = TratarNulo(codobs,      0)
            THIS.this_nNlotes     = TratarNulo(nlotes,      0)
            THIS.this_nChkbaixa   = TratarNulo(chkbaixa,   0)

            *-- Flags logicos (BIT -> LOGICAL)
            THIS.this_lChksubn    = (TratarNulo(chksubn,   0) = 1)
            THIS.this_lImprs      = (TratarNulo(imprs,     0) = 1)
            THIS.this_lLccs       = (TratarNulo(lccs,      0) = 1)
            THIS.this_lProcbals   = (TratarNulo(procbals,  0) = 1)
            THIS.this_lProcdbal   = (TratarNulo(procdbal,  0) = 1)
            THIS.this_lRetrabs    = (TratarNulo(retrabs,   0) = 1)
            THIS.this_lAutos      = (TratarNulo(autos,     0) = 1)
            THIS.this_lNconforms  = (TratarNulo(nconforms, 0) = 1)

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria cidchaves
    * par_cChave : valor de cidchaves (C20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms" + ;
                       " FROM SigCdNec" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentacoes para cursor_4c_Dados
    * par_cFiltro : filtro livre (emps ou dopps - pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE 1=1"

            loc_cSQL = "SELECT cidchaves, empdnps, emps, dopps, numps," + ;
                       " datas, totpesos, usuars," + ;
                       " grupoos, contaos, grupods, contads" + ;
                       " FROM SigCdNec" + ;
                       loc_cWhere + ;
                       " ORDER BY datas DESC, numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves unico se nao informado
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            *-- Montar chave composta
            THIS.MontarChaveComposta()

            *-- Usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds) + ", " + ;
                       EscaparSQL(THIS.this_cDopps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                       EscaparSQL(THIS.this_cContaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupods) + ", " + ;
                       EscaparSQL(THIS.this_cContads) + ", " + ;
                       EscaparSQL(THIS.this_cGrvends) + ", " + ;
                       EscaparSQL(THIS.this_cVends) + ", " + ;
                       EscaparSQL(THIS.this_cObss) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                       EscaparSQL(THIS.this_cDocus) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                       EscaparSQL(THIS.this_cLibprods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                       IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                       IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                       IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                       IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                       IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                       IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                       IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                       IIF(THIS.this_lNconforms,"1", "0") + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Remontar chave composta
                THIS.MontarChaveComposta()

                loc_cSQL = "UPDATE SigCdNec SET " + ;
                           "empdnps    = " + EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                           "emps       = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                           "empds      = " + EscaparSQL(THIS.this_cEmpds) + ", " + ;
                           "dopps      = " + EscaparSQL(THIS.this_cDopps) + ", " + ;
                           "numps      = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                           "datas      = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "datars     = " + FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                           "datatrans  = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "totpesos   = " + FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                           "pesolancs  = " + FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                           "grupoos    = " + EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                           "contaos    = " + EscaparSQL(THIS.this_cContaos) + ", " + ;
                           "grupods    = " + EscaparSQL(THIS.this_cGrupods) + ", " + ;
                           "contads    = " + EscaparSQL(THIS.this_cContads) + ", " + ;
                           "grvends    = " + EscaparSQL(THIS.this_cGrvends) + ", " + ;
                           "vends      = " + EscaparSQL(THIS.this_cVends) + ", " + ;
                           "obss       = " + EscaparSQL(THIS.this_cObss) + ", " + ;
                           "usuars     = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                           "usulibs    = " + EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                           "usuconfs   = " + EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                           "docus      = " + EscaparSQL(THIS.this_cDocus) + ", " + ;
                           "locals     = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
                           "jobs       = " + EscaparSQL(THIS.this_cJobs) + ", " + ;
                           "codnconfs  = " + EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                           "libprods   = " + EscaparSQL(THIS.this_cLibprods) + ", " + ;
                           "ntrans     = " + FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                           "nops       = " + FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                           "naceites   = " + FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                           "numbalds   = " + FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                           "numbals    = " + FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                           "codobs     = " + FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                           "nlotes     = " + FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                           "chkbaixa   = " + FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                           "chksubn    = " + IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                           "imprs      = " + IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                           "lccs       = " + IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                           "procbals   = " + IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                           "procdbal   = " + IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                           "retrabs    = " + IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                           "autos      = " + IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                           "nconforms  = " + IIF(THIS.this_lNconforms,"1", "0") + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigCdNec pela PK cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + ;
                    "o informada para exclus" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdNec" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPeriodoBloqueado - Verifica se a data cai em periodo bloqueado
    * Equivalente ao fVerificaBloqueio + fBloqueioPorPeriodo do Framework legado
    * par_dData: data a verificar
    * Retorno: .T. se bloqueado, .F. se permitido
    *--------------------------------------------------------------------------
    PROCEDURE VerificarPeriodoBloqueado(par_dData)
        LOCAL loc_lBloqueado, loc_nResultado, loc_cSQL
        loc_lBloqueado = .F.

        TRY
            IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
                loc_lBloqueado = .F.
            ELSE
                *-- Tenta usar funcoes do Framework legado se disponiveis no ambiente
                TRY
                    IF PEMSTATUS(_VFP, "fVerificaBloqueio", 5) OR ;
                       TYPE("fVerificaBloqueio") = "FP"
                        IF fVerificaBloqueio(par_dData, gnConnHandle) <> 0
                            loc_lBloqueado = .T.
                        ENDIF
                    ENDIF
                CATCH
                    *-- Framework nao disponivel, nao bloquear
                    loc_lBloqueado = .F.
                ENDTRY

                IF !loc_lBloqueado
                    TRY
                        IF PEMSTATUS(_VFP, "fBloqueioPorPeriodo", 5) OR ;
                           TYPE("fBloqueioPorPeriodo") = "FP"
                            IF fBloqueioPorPeriodo(par_dData, gnConnHandle) <> 0
                                loc_lBloqueado = .T.
                            ENDIF
                        ENDIF
                    CATCH
                        *-- Framework nao disponivel, nao bloquear
                        loc_lBloqueado = .F.
                    ENDTRY
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar per" + CHR(237) + "odo:" + ;
                CHR(13) + loException.Message, "Erro")
            loc_lBloqueado = .F.
        ENDTRY

        RETURN loc_lBloqueado
    ENDPROC

ENDDEFINE

