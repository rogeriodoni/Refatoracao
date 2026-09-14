# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SKCHAVES, TIPOS, CODIBGES, ESTADOS, UFIBGES, ICLIS, ICL, REGIAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SKCHAVES, TIPOS, CODIBGES, ESTADOS, UFIBGES, ICLIS, ICL, REGIAOS

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
  ControlSource = "crSigCdReg.descs"
  ControlSource = "crSigCdReg.regiaos"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
SELECT *, SPACE(40) as munici, SPACE(2) as uf from crSigcdRgi into cursor crMuni readwrite
SELECT crMuni
	.column1.ControlSource = 'crMuni.uf'
	.Column2.controlsource = 'crMuni.munici'
SELECT *, SPACE(50) as vend from crSigcdRgi into cursor crVend readwrite
SELECT crVend
	.column1.ControlSource = 'crVend.iclis'
	.Column2.controlsource = 'crVend.vend'
Select crMuni
lcSql = [Select distinct a.skchaves as skchaves, pkchaves, codibges, tipos, ] +;
		[c.descs as munici, d.estados as uf From SigCdRgi a ] + ;
		[left Join SigCdReg b On a.skChaves = b.skchaves ] +  ;
		[left join sigcdmun c on c.codigos = a.codibges ] +;
		[left join sigcdufs d on d.ufibges = c.ufibges ] +;
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpMun')
Select TmpMun
	Select crMuni
Select crMuni
Select crVend
lcSql = [Select distinct a.skchaves as skchaves, pkchaves, codibges, tipos, ] +;
		[a.iclis as iclis, c.razaos as vend From SigCdRgi a ] + ;
		[left Join SigCdReg b On a.skChaves = b.skchaves ] +  ;
		[left join sigcdcli c on c.iclis = a.iclis Where a.skchaves = '] + lcSK + [' and a.tipos='C']
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpVen')
Select TmpVen
	Select crVend
Select crVend
SELECT crSigCdReg
SET delete off
	Select CrSigCdRgi
	Select crMuni
			Select CrSigCdRgi
			IF DELETED('crMuni')
				delete
		SELECT crMuni
	Select crVend
			Select CrSigCdRgi
			IF DELETED('crVend')
				delete
		SELECT crVend
SET delete on
If Not ThisForm.poDataMgr.Update('crSigCdRgi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRgi)')
Select crMuni
Select crMuni
SELECT crMuni
Delete
Select uf, munici from crMuni into cursor Duplica group by uf, munici  having sum(1) > 1 
Select Duplica
	Select crMuni
Select crMuni
	lcQuery = 	[Select b.estados as estados, a.descs as munici, a.codigos as codibges From SigCdMun a, SigcdUfs b where b.estados = '] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crLocal])) >0
		Select crlocal
		If Not Seek(Padr(This.Value, 40), [crLocal], [munici])
Select crVend
Select crVend
SELECT crVend
Delete
Select iclis from crVend into cursor Duplica group by iclis  having sum(1) > 1 
Select Duplica
	Select crVend
Select crVend

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormReg.prg) - TRECHOS RELEVANTES PARA PASS SQL (1692 linhas total):

*-- Linhas 354 a 372:
354:             .HighlightBackColor = RGB(255, 255, 255)
355:             .HighlightForeColor = RGB(15, 41, 104)
356:             .HighlightStyle     = 2
357:             .DeleteMark         = .F.
358:             .RecordMark         = .F.
359:             .RowHeight          = 16
360:             .ScrollBars         = 2
361:             .GridLines          = 3
362:             .Visible            = .T.
363:             .Column1.Width              = 100
364:             .Column2.Width              = 400
365:             .Column1.Header1.Caption    = "Regi" + CHR(245) + "es"
366:             .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
369: 
370:         THIS.TornarControlesVisiveis(loc_oPagina)
371:     ENDPROC
372: 

*-- Linhas 542 a 578:
542: 
543:         *-- Grid Municipios (GradMuni legado: Top=146+29=175, Left=51, Width=358, Height=438)
544:         *-- RecordSource e ColumnCount FORA do WITH (Problem 36: evita Unknown member COLUMN1)
545:         *-- ControlSource definido em RebindGridsDetalhe() apos criacao do cursor crMuni
546:         loc_oPagina.AddObject("grd_4c_Municipios", "Grid")
547:         loc_oPagina.grd_4c_Municipios.RecordSource = ""
548:         loc_oPagina.grd_4c_Municipios.ColumnCount  = 2
549:         WITH loc_oPagina.grd_4c_Municipios
550:             .Top                = 175
551:             .Left               = 51
552:             .Width              = 358
553:             .Height             = 438
554:             .FontName           = "Tahoma"
555:             .FontSize           = 8
556:             .ForeColor          = RGB(90, 90, 90)
557:             .BackColor          = RGB(255, 255, 255)
558:             .GridLineColor      = RGB(238, 238, 238)
559:             .HighlightBackColor = RGB(255, 255, 255)
560:             .HighlightForeColor = RGB(15, 41, 104)
561:             .HighlightStyle     = 2
562:             .RecordMark         = .F.
563:             .DeleteMark         = .F.
564:             .HeaderHeight       = 20
565:             .RowHeight          = 18
566:             .ScrollBars         = 2
567:             .GridLines          = 3
568:             .AllowHeaderSizing  = .F.
569:             .AllowRowSizing     = .F.
570:             .Column1.Width               = 24
571:             .Column2.Width               = 312
572:             .Column1.Header1.Caption     = "UF"
573:             .Column2.Header1.Caption     = "Munic" + CHR(237) + "pio"
574:             .Visible            = .T.
575:         ENDWITH
576:         BINDEVENT(loc_oPagina.grd_4c_Municipios, "AfterRowColChange", THIS, ;
577:             "GradMuniAfterRowColChange")
578: 

*-- Linhas 614 a 650:
614: 
615:         *-- Grid Vendedores (GradVend legado: Top=146+29=175, Left=497, Width=402, Height=438)
616:         *-- RecordSource e ColumnCount FORA do WITH (Problem 36)
617:         *-- ControlSource definido em RebindGridsDetalhe() apos criacao do cursor crVend
618:         loc_oPagina.AddObject("grd_4c_Vendedores", "Grid")
619:         loc_oPagina.grd_4c_Vendedores.RecordSource = ""
620:         loc_oPagina.grd_4c_Vendedores.ColumnCount  = 2
621:         WITH loc_oPagina.grd_4c_Vendedores
622:             .Top                = 175
623:             .Left               = 497
624:             .Width              = 402
625:             .Height             = 438
626:             .FontName           = "Tahoma"
627:             .FontSize           = 8
628:             .ForeColor          = RGB(90, 90, 90)
629:             .BackColor          = RGB(255, 255, 255)
630:             .GridLineColor      = RGB(238, 238, 238)
631:             .HighlightBackColor = RGB(255, 255, 255)
632:             .HighlightForeColor = RGB(15, 41, 104)
633:             .HighlightStyle     = 2
634:             .RecordMark         = .F.
635:             .DeleteMark         = .F.
636:             .HeaderHeight       = 20
637:             .RowHeight          = 18
638:             .ScrollBars         = 2
639:             .GridLines          = 3
640:             .AllowHeaderSizing  = .F.
641:             .AllowRowSizing     = .F.
642:             .Column1.Width               = 90
643:             .Column2.Width               = 290
644:             .Column1.Header1.Caption     = "C" + CHR(243) + "digo"
645:             .Column2.Header1.Caption     = "Nome do Vendedor"
646:             .Visible            = .T.
647:         ENDWITH
648:         BINDEVENT(loc_oPagina.grd_4c_Vendedores, "AfterRowColChange", THIS, ;
649:             "GradVendAfterRowColChange")
650: 

*-- Linhas 690 a 728:
690:     *==========================================================================
691:     * CarregarLista - Carrega dados no grid da Page1
692:     * BO.Buscar() cria cursor_4c_Dados com: regiaos, descs, skchaves
693:     * ControlSource APOS RecordSource (Problem 36) + headers reconfigurados (Problem 32)
694:     *==========================================================================
695:     PROCEDURE CarregarLista()
696:         LOCAL loc_lSucesso, loc_oGrid
697:         loc_lSucesso = .F.
698: 
699:         TRY
700:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
701:                 loc_lSucesso = .T.
702:             ELSE
703:                 IF THIS.this_oBusinessObject.Buscar("")
704:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
705: 
706:                     *-- RecordSource e ColumnCount antes das colunas (Problem 36)
707:                     loc_oGrid.ColumnCount = 2
708:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
709:                     loc_oGrid.ColumnCount  = 2
710: 
711:                     *-- ControlSource APOS RecordSource
712:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.regiaos"
713:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
714: 
715:                     loc_oGrid.Column1.Width = 100
716:                     loc_oGrid.Column2.Width = 400
717: 
718:                     *-- Reconfigurar headers: VFP9 os reseta ao mudar RecordSource (Problem 32)
719:                     loc_oGrid.Column1.Header1.Caption = "Regi" + CHR(245) + "es"
720:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
721: 
722:                     THIS.FormatarGridLista(loc_oGrid)
723:                     loc_oGrid.Refresh()
724:                     loc_lSucesso = .T.
725:                 ENDIF
726:             ENDIF
727:         CATCH TO loException
728:             MostrarErro(loException, "FormReg.CarregarLista")

*-- Linhas 831 a 849:
831:                OR EOF("cursor_4c_Dados")
832:                 MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Visualizar")
833:             ELSE
834:                 SELECT cursor_4c_Dados
835:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
836:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
837:                     THIS.this_cModoAtual = "VISUALIZAR"
838:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
839:                         THIS.BOParaForm()
840:                     ENDIF
841:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
842:                         THIS.HabilitarCampos(.F.)
843:                     ENDIF
844:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
845:                         THIS.AjustarBotoesPorModo()
846:                     ENDIF
847:                     THIS.pgf_4c_Paginas.ActivePage = 2
848:                 ENDIF
849:             ENDIF

*-- Linhas 862 a 880:
862:                OR EOF("cursor_4c_Dados")
863:                 MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Alterar")
864:             ELSE
865:                 SELECT cursor_4c_Dados
866:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
867:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
868:                     THIS.this_oBusinessObject.EditarRegistro()
869:                     THIS.this_cModoAtual = "ALTERAR"
870:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
871:                         THIS.BOParaForm()
872:                     ENDIF
873:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
874:                         THIS.HabilitarCampos(.T.)
875:                     ENDIF
876:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
877:                         THIS.AjustarBotoesPorModo()
878:                     ENDIF
879:                     THIS.pgf_4c_Paginas.ActivePage = 2
880:                 ENDIF

*-- Linhas 895 a 913:
895:                OR EOF("cursor_4c_Dados")
896:                 MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Excluir")
897:             ELSE
898:                 SELECT cursor_4c_Dados
899:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
900:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da regi" + ;
901:                                CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")
902:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
903:                         IF THIS.this_oBusinessObject.Excluir()
904:                             MsgInfo("Regi" + CHR(227) + "o exclu" + CHR(237) + ;
905:                                     "da com sucesso!", "Excluir")
906:                             THIS.CarregarLista()
907:                         ENDIF
908:                     ENDIF
909:                 ENDIF
910:             ENDIF
911:         CATCH TO loException
912:             MostrarErro(loException, "FormReg.BtnExcluirClick")
913:         ENDTRY

*-- Linhas 934 a 952:
934:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaReg")
935:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaReg.regiaos)
936:                     IF USED("cursor_4c_Dados")
937:                         SELECT cursor_4c_Dados
938:                         LOCATE FOR ALLTRIM(regiaos) = loc_cCodigo
939:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
940:                     ENDIF
941:                 ENDIF
942: 
943:                 IF USED("cursor_4c_BuscaReg")
944:                     USE IN cursor_4c_BuscaReg
945:                 ENDIF
946:                 loc_oBusca.Release()
947:             ENDIF
948:         CATCH TO loException
949:             MostrarErro(loException, "FormReg.BtnBuscarClick")
950:         ENDTRY
951:     ENDPROC
952: 

*-- Linhas 1018 a 1040:
1018: 
1019:         TRY
1020:             IF !EMPTY(loc_cCodigo) AND THIS.this_cModoAtual = "INCLUIR"
1021:                 loc_cSQL    = "SELECT COUNT(*) AS qtde FROM SigCdReg" + ;
1022:                               " WHERE regiaos = " + EscaparSQL(loc_cCodigo)
1023:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg")
1024:                 IF loc_nResult > 0 AND USED("cursor_4c_ChkReg")
1025:                     SELECT cursor_4c_ChkReg
1026:                     IF cursor_4c_ChkReg.qtde > 0
1027:                         MsgAviso("Regi" + CHR(227) + "o '" + loc_cCodigo + ;
1028:                                  "' j" + CHR(225) + " cadastrada!", "Validar")
1029:                         loc_oPagina2.txt_4c_Codigo.Value = ""
1030:                         loc_oPagina2.txt_4c_Codigo.SetFocus
1031:                     ENDIF
1032:                 ENDIF
1033:                 IF USED("cursor_4c_ChkReg")
1034:                     USE IN cursor_4c_ChkReg
1035:                 ENDIF
1036:             ENDIF
1037:         CATCH TO loException
1038:             MostrarErro(loException, "FormReg.ValidarCodigo")
1039:         ENDTRY
1040:     ENDPROC

*-- Linhas 1177 a 1210:
1177:                 loc_oGridMuni.RecordSource = ""
1178:                 loc_oGridMuni.RecordSource = "crMuni"
1179:                 loc_oGridMuni.ColumnCount  = 2
1180:                 loc_oGridMuni.Column1.ControlSource   = "crMuni.uf"
1181:                 loc_oGridMuni.Column2.ControlSource   = "crMuni.munici"
1182:                 loc_oGridMuni.Column1.Width            = 24
1183:                 loc_oGridMuni.Column2.Width            = 312
1184:                 loc_oGridMuni.Column1.Header1.Caption  = "UF"
1185:                 loc_oGridMuni.Column2.Header1.Caption  = "Munic" + CHR(237) + "pio"
1186:                 loc_oGridMuni.Refresh()
1187:             ENDIF
1188: 
1189:             IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5) AND USED("crVend")
1190:                 loc_oGridVend = loc_oPagina2.grd_4c_Vendedores
1191:                 loc_oGridVend.RecordSource = ""
1192:                 loc_oGridVend.RecordSource = "crVend"
1193:                 loc_oGridVend.ColumnCount  = 2
1194:                 loc_oGridVend.Column1.ControlSource   = "crVend.iclis"
1195:                 loc_oGridVend.Column2.ControlSource   = "crVend.vend"
1196:                 loc_oGridVend.Column1.Width            = 90
1197:                 loc_oGridVend.Column2.Width            = 290
1198:                 loc_oGridVend.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1199:                 loc_oGridVend.Column2.Header1.Caption  = "Nome do Vendedor"
1200:                 loc_oGridVend.Refresh()
1201:             ENDIF
1202:         CATCH TO loc_oErro
1203:             MsgErro(loc_oErro.Message, "Erro ao vincular grids de detalhe")
1204:         ENDTRY
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * GradMuniAfterRowColChange - Valida celula ao navegar no grid de Municipios
1209:     * PUBLIC: BINDEVENT exige metodo publico
1210:     * par_nColIndex: coluna ANTERIOR ao movimento (1=saiu da coluna UF, 2=saiu da coluna Municipio)

*-- Linhas 1240 a 1273:
1240:         TRY
1241:             loc_cUF = ALLTRIM(crMuni.uf)
1242:             IF !EMPTY(loc_cUF)
1243:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1244:                     "SELECT TOP 1 estados, descrs FROM SigCdUfs " + ;
1245:                     "WHERE estados = " + EscaparSQL(loc_cUF), ;
1246:                     "cursor_4c_UfLocal")
1247:                 IF loc_nResult > 0 AND USED("cursor_4c_UfLocal") AND !EOF("cursor_4c_UfLocal")
1248:                     REPLACE crMuni.uf WITH ALLTRIM(cursor_4c_UfLocal.estados) IN crMuni
1249:                     IF USED("cursor_4c_UfLocal")
1250:                         USE IN cursor_4c_UfLocal
1251:                     ENDIF
1252:                 ELSE
1253:                     IF USED("cursor_4c_UfLocal")
1254:                         USE IN cursor_4c_UfLocal
1255:                     ENDIF
1256:                     *-- Nao encontrado: abre picker com todos os estados
1257:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1258:                         "SELECT estados, descrs FROM SigCdUfs ORDER BY estados", ;
1259:                         "cursor_4c_UfLocal")
1260:                     IF loc_nResult > 0 AND USED("cursor_4c_UfLocal")
1261:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1262:                         loc_oBusca.DefinirCursor("cursor_4c_UfLocal", "estados", "descrs", ;
1263:                             "Selecionar UF")
1264:                         loc_oBusca.Mostrar()
1265:                         IF loc_oBusca.this_lSelecionou
1266:                             REPLACE crMuni.uf WITH ;
1267:                                 ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crMuni
1268:                         ELSE
1269:                             REPLACE crMuni.uf WITH "" IN crMuni
1270:                             loc_lResultado = .F.
1271:                         ENDIF
1272:                         loc_oBusca.Release()
1273:                         loc_oBusca = .NULL.

*-- Linhas 1313 a 1368:
1313: 
1314:             IF !EMPTY(loc_cMuni)
1315:                 *-- Busca exata/parcial em SigCdMun filtrada pela UF
1316:                 loc_cSQL = "SELECT TOP 1 m.codigos AS codibges, m.descs AS munici" + ;
1317:                     " FROM SigCdMun m" + ;
1318:                     " INNER JOIN SigCdUfs u ON u.ufibges = m.ufibges"
1319:                 IF !EMPTY(loc_cUF)
1320:                     loc_cSQL = loc_cSQL + " WHERE u.estados = " + EscaparSQL(loc_cUF) + ;
1321:                         " AND (m.codigos = " + EscaparSQL(loc_cMuni) + ;
1322:                         " OR m.descs LIKE " + EscaparSQL(loc_cMuni + "%") + ")"
1323:                 ELSE
1324:                     loc_cSQL = loc_cSQL + ;
1325:                         " WHERE m.codigos = " + EscaparSQL(loc_cMuni) + ;
1326:                         " OR m.descs LIKE " + EscaparSQL(loc_cMuni + "%")
1327:                 ENDIF
1328:                 loc_cSQL = loc_cSQL + " ORDER BY m.descs"
1329: 
1330:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniLocal")
1331:                 IF loc_nResult > 0 AND USED("cursor_4c_MuniLocal") AND !EOF("cursor_4c_MuniLocal")
1332:                     REPLACE crMuni.codibges WITH ;
1333:                         ALLTRIM(cursor_4c_MuniLocal.codibges) IN crMuni
1334:                     REPLACE crMuni.munici WITH ;
1335:                         ALLTRIM(cursor_4c_MuniLocal.munici) IN crMuni
1336:                     IF USED("cursor_4c_MuniLocal")
1337:                         USE IN cursor_4c_MuniLocal
1338:                     ENDIF
1339:                     THIS.ValidarDuplicadosMuni()
1340:                 ELSE
1341:                     IF USED("cursor_4c_MuniLocal")
1342:                         USE IN cursor_4c_MuniLocal
1343:                     ENDIF
1344:                     *-- Nao encontrado: abre picker filtrado pela UF
1345:                     loc_cSQL = "SELECT m.codigos AS codibges, m.descs AS munici" + ;
1346:                         " FROM SigCdMun m" + ;
1347:                         " INNER JOIN SigCdUfs u ON u.ufibges = m.ufibges"
1348:                     IF !EMPTY(loc_cUF)
1349:                         loc_cSQL = loc_cSQL + " WHERE u.estados = " + EscaparSQL(loc_cUF)
1350:                     ENDIF
1351:                     loc_cSQL = loc_cSQL + " ORDER BY m.descs"
1352: 
1353:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniLocal")
1354:                     IF loc_nResult > 0 AND USED("cursor_4c_MuniLocal")
1355:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1356:                         loc_oBusca.DefinirCursor("cursor_4c_MuniLocal", "codibges", "munici", ;
1357:                             "Selecionar Munic" + CHR(237) + "pio")
1358:                         loc_oBusca.Mostrar()
1359:                         IF loc_oBusca.this_lSelecionou
1360:                             REPLACE crMuni.codibges WITH ;
1361:                                 ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crMuni
1362:                             REPLACE crMuni.munici WITH ;
1363:                                 ALLTRIM(loc_oBusca.cDescricaoSelecionada) IN crMuni
1364:                             THIS.ValidarDuplicadosMuni()
1365:                         ELSE
1366:                             REPLACE crMuni.codibges WITH "" IN crMuni
1367:                             REPLACE crMuni.munici   WITH "" IN crMuni
1368:                             loc_lResultado = .F.

*-- Linhas 1407 a 1425:
1407: 
1408:         TRY
1409:             IF USED("crMuni")
1410:                 SELECT codibges FROM crMuni ;
1411:                     WHERE !EMPTY(ALLTRIM(codibges)) ;
1412:                     GROUP BY codibges ;
1413:                     HAVING SUM(1) > 1 ;
1414:                     INTO CURSOR cursor_4c_DupMuni NOFILTER
1415:                 IF !EOF("cursor_4c_DupMuni")
1416:                     MsgAviso("Munic" + CHR(237) + "pio duplicado detectado na lista.")
1417:                     loc_lResultado = .F.
1418:                 ENDIF
1419:                 IF USED("cursor_4c_DupMuni")
1420:                     USE IN cursor_4c_DupMuni
1421:                 ENDIF
1422:             ENDIF
1423:         CATCH TO loc_oErro
1424:             IF USED("cursor_4c_DupMuni")
1425:                 USE IN cursor_4c_DupMuni

*-- Linhas 1464 a 1510:
1464:             loc_cIclis = ALLTRIM(crVend.iclis)
1465:             IF !EMPTY(loc_cIclis)
1466:                 *-- Busca exata em SigCdCli
1467:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1468:                     "SELECT TOP 1 iclis, razaos FROM SigCdCli " + ;
1469:                     "WHERE iclis = " + EscaparSQL(loc_cIclis), ;
1470:                     "cursor_4c_VendLocal")
1471:                 IF loc_nResult > 0 AND USED("cursor_4c_VendLocal") AND !EOF("cursor_4c_VendLocal")
1472:                     REPLACE crVend.iclis WITH ALLTRIM(cursor_4c_VendLocal.iclis) IN crVend
1473:                     REPLACE crVend.vend  WITH ALLTRIM(cursor_4c_VendLocal.razaos) IN crVend
1474:                     IF USED("cursor_4c_VendLocal")
1475:                         USE IN cursor_4c_VendLocal
1476:                     ENDIF
1477:                     THIS.ValidarDuplicadosVend()
1478:                 ELSE
1479:                     IF USED("cursor_4c_VendLocal")
1480:                         USE IN cursor_4c_VendLocal
1481:                     ENDIF
1482:                     *-- Nao encontrado exato: busca parcial por codigo ou nome
1483:                     loc_cSQL = "SELECT iclis, razaos FROM SigCdCli " + ;
1484:                         "WHERE iclis LIKE " + EscaparSQL(loc_cIclis + "%") + ;
1485:                         " OR razaos LIKE " + EscaparSQL(loc_cIclis + "%") + ;
1486:                         " ORDER BY iclis"
1487:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendLocal")
1488:                     IF loc_nResult <= 0 OR !USED("cursor_4c_VendLocal") OR ;
1489:                             EOF("cursor_4c_VendLocal")
1490:                         IF USED("cursor_4c_VendLocal")
1491:                             USE IN cursor_4c_VendLocal
1492:                         ENDIF
1493:                         *-- Fallback: mostra todos os clientes
1494:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1495:                             "SELECT iclis, razaos FROM SigCdCli ORDER BY iclis", ;
1496:                             "cursor_4c_VendLocal")
1497:                     ENDIF
1498:                     IF loc_nResult > 0 AND USED("cursor_4c_VendLocal")
1499:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1500:                         loc_oBusca.DefinirCursor("cursor_4c_VendLocal", "iclis", "razaos", ;
1501:                             "Selecionar Vendedor")
1502:                         loc_oBusca.Mostrar()
1503:                         IF loc_oBusca.this_lSelecionou
1504:                             REPLACE crVend.iclis WITH ;
1505:                                 ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crVend
1506:                             REPLACE crVend.vend  WITH ;
1507:                                 ALLTRIM(loc_oBusca.cDescricaoSelecionada) IN crVend
1508:                             THIS.ValidarDuplicadosVend()
1509:                         ELSE
1510:                             REPLACE crVend.iclis WITH "" IN crVend

*-- Linhas 1550 a 1568:
1550: 
1551:         TRY
1552:             IF USED("crVend")
1553:                 SELECT iclis FROM crVend ;
1554:                     WHERE !EMPTY(ALLTRIM(iclis)) ;
1555:                     GROUP BY iclis ;
1556:                     HAVING SUM(1) > 1 ;
1557:                     INTO CURSOR cursor_4c_DupVend NOFILTER
1558:                 IF !EOF("cursor_4c_DupVend")
1559:                     MsgAviso("Vendedor duplicado detectado na lista.")
1560:                     loc_lResultado = .F.
1561:                 ENDIF
1562:                 IF USED("cursor_4c_DupVend")
1563:                     USE IN cursor_4c_DupVend
1564:                 ENDIF
1565:             ENDIF
1566:         CATCH TO loc_oErro
1567:             IF USED("cursor_4c_DupVend")
1568:                 USE IN cursor_4c_DupVend

*-- Linhas 1586 a 1604:
1586:             RETURN
1587:         ENDIF
1588:         TRY
1589:             SELECT crMuni
1590:             APPEND BLANK
1591:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
1592:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
1593:             ENDIF
1594:         CATCH TO loc_oErro
1595:             MostrarErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + ;
1596:                 loc_oErro.Message, "FormReg.BtnInserirMunClick")
1597:         ENDTRY
1598:     ENDPROC
1599: 
1600:     *==========================================================================
1601:     * BtnExcluirMunClick - Remove linha atual do cursor crMuni
1602:     * PUBLIC: BINDEVENT exige metodo publico
1603:     *==========================================================================
1604:     PROCEDURE BtnExcluirMunClick()

*-- Linhas 1613 a 1632:
1613:             RETURN
1614:         ENDIF
1615:         TRY
1616:             DELETE IN crMuni
1617:             SELECT crMuni
1618:             PACK
1619:             IF RECCOUNT("crMuni") = 0
1620:                 APPEND BLANK
1621:             ENDIF
1622:             IF RECCOUNT("crMuni") > 0
1623:                 GO BOTTOM IN crMuni
1624:             ENDIF
1625:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
1626:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
1627:             ENDIF
1628:         CATCH TO loc_oErro
1629:             MostrarErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + ;
1630:                 loc_oErro.Message, "FormReg.BtnExcluirMunClick")
1631:         ENDTRY
1632:     ENDPROC

*-- Linhas 1644 a 1662:
1644:             RETURN
1645:         ENDIF
1646:         TRY
1647:             SELECT crVend
1648:             APPEND BLANK
1649:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
1650:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
1651:             ENDIF
1652:         CATCH TO loc_oErro
1653:             MostrarErro("Erro ao inserir vendedor:" + CHR(13) + ;
1654:                 loc_oErro.Message, "FormReg.BtnInserirVendClick")
1655:         ENDTRY
1656:     ENDPROC
1657: 
1658:     *==========================================================================
1659:     * BtnExcluirVendClick - Remove linha atual do cursor crVend
1660:     * PUBLIC: BINDEVENT exige metodo publico
1661:     *==========================================================================
1662:     PROCEDURE BtnExcluirVendClick()

*-- Linhas 1671 a 1690:
1671:             RETURN
1672:         ENDIF
1673:         TRY
1674:             DELETE IN crVend
1675:             SELECT crVend
1676:             PACK
1677:             IF RECCOUNT("crVend") = 0
1678:                 APPEND BLANK
1679:             ENDIF
1680:             IF RECCOUNT("crVend") > 0
1681:                 GO BOTTOM IN crVend
1682:             ENDIF
1683:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
1684:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
1685:             ENDIF
1686:         CATCH TO loc_oErro
1687:             MostrarErro("Erro ao excluir vendedor:" + CHR(13) + ;
1688:                 loc_oErro.Message, "FormReg.BtnExcluirVendClick")
1689:         ENDTRY
1690:     ENDPROC


### BO (C:\4c\projeto\app\classes\RegBO.prg):
*====================================================================
* RegBO.prg
*
* Business Object para Cadastro de Regioes
* Tabela principal : SigCdReg (regiaos, descs, skchaves)
* Tabela filha     : SigCdRgi (municipios tipos='M' e vendedores tipos='C')
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RegBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Propriedades da entidade principal (SigCdReg)
    *-- ----------------------------------------------------------------
    this_cRegiaos   = ""    && regiaos  char(10)  - PK
    this_cDescs     = ""    && descs    char(30)
    this_cSkChaves  = ""    && skchaves char(20)  - chave UUID (liga SigCdRgi)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdReg"
            THIS.this_cCampoChave = "regiaos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "RegBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRegiaos  = TratarNulo(regiaos,  "C")
                THIS.this_cDescs    = TratarNulo(descs,    "C")
                THIS.this_cSkChaves = TratarNulo(skchaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Seleciona todas as regioes para o grid de listagem
    * par_cFiltro: filtro opcional (nao usado - mantido por padrao)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " ORDER BY regiaos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar regi" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega uma regiao pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cRegiaos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(par_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar regi" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarMunicipios - Carrega municipios da regiao no crMuni
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crMuni")
                USE IN crMuni
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " c.descs AS munici, d.estados AS uf" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdmun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN sigcdufs d ON d.ufibges = c.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'M'" + ;
                           " ORDER BY c.descs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar munic" + CHR(237) + "pios: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_MuniTemp") > 0
                        APPEND FROM DBF("cursor_4c_MuniTemp")
                    ENDIF

                    IF RECCOUNT("crMuni") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crMuni
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_MuniTemp")
                    USE IN cursor_4c_MuniTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarMunicipios")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarVendedores - Carrega vendedores/clientes da regiao no crVend
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarVendedores(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crVend")
                USE IN crVend
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), vend C(50))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " a.iclis, c.razaos AS vend" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdcli c ON c.iclis = a.iclis" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'C'" + ;
                           " ORDER BY c.razaos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar vendedores: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), vend C(50))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_VendTemp") > 0
                        APPEND FROM DBF("cursor_4c_VendTemp")
                    ENDIF

                    IF RECCOUNT("crVend") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crVend
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_VendTemp")
                    USE IN cursor_4c_VendTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarVendedores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirFilhos - Insere registros em SigCdRgi a partir de crMuni e crVend
    * par_cSkChaves: skchaves da regiao (recem gerado ou existente)
    *====================================================================
    PROTECTED PROCEDURE InserirFilhos(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cPkChaves
        loc_lSucesso = .T.
        TRY
            *-- Inserir municipios do crMuni (tipos='M', codibges nao vazio)
            IF USED("crMuni")
                SELECT crMuni
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crMuni.codibges)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", " + ;
                                   EscaparSQL(ALLTRIM(crMuni.codibges)) + ", 'M', '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsMuni")
                        IF USED("cursor_4c_InsMuni")
                            USE IN cursor_4c_InsMuni
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Inserir vendedores do crVend (tipos='C', iclis nao vazio)
            IF loc_lSucesso AND USED("crVend")
                SELECT crVend
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crVend.iclis)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", '', 'C', " + ;
                                   EscaparSQL(ALLTRIM(crVend.iclis)) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsVend")
                        IF USED("cursor_4c_InsVend")
                            USE IN cursor_4c_InsVend
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir vendedor: " + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.InserirFilhos")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdReg + filhos em SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cSkChaves
        loc_lSucesso = .F.
        TRY
            *-- Gerar chave UUID para skchaves
            loc_cSkChaves = fUniqueIds()
            THIS.this_cSkChaves = loc_cSkChaves

            loc_cSQL = "INSERT INTO SigCdReg (regiaos, descs, skchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cRegiaos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ", " + ;
                       EscaparSQL(loc_cSkChaves) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsReg")
            IF USED("cursor_4c_InsReg")
                USE IN cursor_4c_InsReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao inserir regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = THIS.InserirFilhos(loc_cSkChaves)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigCdReg + rebuild de SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Atualizar descricao (regiaos nao pode ser alterado)
            loc_cSQL = "UPDATE SigCdReg" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdReg")
            IF USED("cursor_4c_UpdReg")
                USE IN cursor_4c_UpdReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remover todos os filhos existentes e reinserir
                loc_cSQL = "DELETE FROM SigCdRgi" + ;
                           " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
                IF USED("cursor_4c_DelRgi")
                    USE IN cursor_4c_DelRgi
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao remover municipios/vendedores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = THIS.InserirFilhos(ALLTRIM(THIS.this_cSkChaves))
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE de SigCdRgi + SigCdReg
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir filhos primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM SigCdRgi" + ;
                       " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
            IF USED("cursor_4c_DelRgi")
                USE IN cursor_4c_DelRgi
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao excluir municipios/vendedores:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir regiao principal
                loc_cSQL = "DELETE FROM SigCdReg" + ;
                           " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelReg")
                IF USED("cursor_4c_DelReg")
                    USE IN cursor_4c_DelReg
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir regi" + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRegiaos)
    ENDPROC

ENDDEFINE

