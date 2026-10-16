# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VAZIO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS

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
  ControlSource = "crSigClLan.grupos"
  Column1.ControlSource = "csSigClLan.cocos"
  Column2.ControlSource = "csSigClLan.descs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigClLan.contas"
lcQryLancamento = [Select * From SigClLan]
Select csSigClLan
lcquery = [Select a.*, b.descs from SigClLan a, SigCcCco b where a.grucontas=']+gruconta+[' and a.cocos = b.cods]
=Thisform.podatamgr.sqlexecute(lcquery,'CrTmpLanc')
Select crtmplanc
	Select csSigClLan
Select csSigClLan
   lcdelete = [delete from SigClLan where grucontas = ']+lcgrucon+[']
   If thisform.podatamgr.sqlexecute(lcdelete,'') < 1
   Select CrSigClLan
  Select csSigClLan
		Insert Into crSigClLan (Grupos, Contas, Cocos, cIdChaves, Grucontas) ;
Insert Into csSigClLan( Contas, Grupos) Values ( ContAux, GruAux )
Delete
	Insert Into csSigClLan( Contas, Grupos) Values ( ContAux, GruAux )
    Select CsSigClLan
   if Seek(this.value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS SQL (2261 linhas total):

*-- Linhas 51 a 69:
51:                 USE IN cursor_4c_OcoLocal
52:             ENDIF
53:             SET NULL ON
54:             CREATE CURSOR cursor_4c_OcoLocal (Grupos C(10), Contas C(10), Cocos C(2), descs C(30))
55:             SET NULL OFF
56:             INDEX ON Cocos TAG Cocos
57: 
58:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRLNCBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
62:             ELSE
63:                 THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"
64: 
65:                 THIS.ConfigurarPageFrame()
66:                 THIS.ConfigurarPaginaLista()
67:                 THIS.ConfigurarPaginaDados()
68: 
69:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

*-- Linhas 349 a 367:
349:             .HighlightBackColor = RGB(255, 255, 255)
350:             .HighlightForeColor = RGB(15, 41, 104)
351:             .HighlightStyle     = 2
352:             .DeleteMark         = .F.
353:             .RecordMark         = .F.
354:             .RowHeight          = 16
355:             .ScrollBars         = 2
356:             .GridLines          = 3
357:             .Visible            = .T.
358:         ENDWITH
359: 
360:         THIS.TornarControlesVisiveis(loc_oPagina)
361:     ENDPROC
362: 
363:     *--------------------------------------------------------------------------
364:     * ConfigurarPaginaDados - Page2: campos de identificacao (Grupo/Conta) e botoes
365:     * Fase 5/8: Container botoes + labels/textboxes de Grupo e Conta
366:     *--------------------------------------------------------------------------
367:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 706 a 746:
706:             .ScrollBars         = 2
707:             .GridLines          = 3
708:             .GridLineColor      = RGB(238, 238, 238)
709:             .DeleteMark         = .F.
710:             .RecordMark         = .F.
711:             .HighlightStyle     = 2
712:             .HighlightBackColor = RGB(255, 255, 255)
713:             .HighlightForeColor = RGB(15, 41, 104)
714:             .Visible            = .T.
715: 
716:             .Column1.ControlSource     = "cursor_4c_OcoLocal.Cocos"
717:             .Column1.Width             = 70
718:             .Column1.Movable           = .F.
719:             .Column1.Resizable         = .F.
720:             .Column1.Visible           = .T.
721:             .Column1.Sparse            = .F.
722:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
723:             .Column1.Header1.FontName  = "Tahoma"
724:             .Column1.Header1.FontSize  = 8
725:             .Column1.Header1.Alignment = 2
726:             .Column1.Text1.FontName    = "Verdana"
727:             .Column1.Text1.FontSize    = 8
728:             .Column1.Text1.BorderStyle = 0
729:             .Column1.Text1.Margin      = 0
730: 
731:             .Column2.ControlSource     = "cursor_4c_OcoLocal.descs"
732:             .Column2.Width             = 220
733:             .Column2.Movable           = .F.
734:             .Column2.Resizable         = .F.
735:             .Column2.ReadOnly          = .T.
736:             .Column2.Visible           = .T.
737:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
738:             .Column2.Header1.FontName  = "Tahoma"
739:             .Column2.Header1.FontSize  = 8
740:             .Column2.Header1.Alignment = 2
741:             .Column2.Text1.FontName    = "Verdana"
742:             .Column2.Text1.FontSize    = 8
743:             .Column2.Text1.BorderStyle = 0
744:             .Column2.Text1.Margin      = 0
745:             .Column2.Text1.ReadOnly    = .T.
746:         ENDWITH

*-- Linhas 780 a 820:
780:                 IF USED("cursor_4c_Dados")
781:                     USE IN cursor_4c_Dados
782:                 ENDIF
783:                 CREATE CURSOR cursor_4c_Dados (grupos C(10), contas C(10), cocos C(2), ;
784:                                                cidchaves C(20), grucontas C(20))
785:                 loc_lSucesso = .T.
786:             ELSE
787:                 IF THIS.this_oBusinessObject.Buscar("")
788:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
789: 
790:                     *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
791:                     loc_oGrid.ColumnCount = 4
792:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
793:                     loc_oGrid.ColumnCount  = 3
794: 
795:                     *-- Colunas do legado (Init): Grupos / Contas / Cocos ("Operacao"), 80px cada
796:                     WITH loc_oGrid
797:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
798:                         .Column1.Width           = 80
799:                         .Column1.Header1.Caption = "Grupos"
800: 
801:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
802:                         .Column2.Width           = 80
803:                         .Column2.Header1.Caption = "Contas"
804: 
805:                         .Column3.ControlSource   = "cursor_4c_Dados.cocos"
806:                         .Column3.Width           = 80
807:                         .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
808:                     ENDWITH
809: 
810:                     THIS.FormatarGridLista(loc_oGrid)
811:                     THIS.AjustarBotoesPorModo()
812:                     loc_lSucesso = .T.
813:                 ENDIF
814:             ENDIF
815:         CATCH TO loException
816:             MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
817:             loc_lSucesso = .F.
818:         ENDTRY
819: 
820:         RETURN loc_lSucesso

*-- Linhas 894 a 921:
894:             IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
895:                 *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
896:                 IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
897:                     SELECT cursor_4c_Ocorrencias
898:                     GO TOP
899:                     DO WHILE !EOF()
900:                         SELECT cursor_4c_OcoLocal
901:                         APPEND BLANK
902:                         REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
903:                         REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
904:                         REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
905:                         REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
906:                         SELECT cursor_4c_Ocorrencias
907:                         SKIP
908:                     ENDDO
909:                 ENDIF
910:                 loc_lSucesso = .T.
911:             ENDIF
912:             THIS.AtualizarGradeOcorrencias()
913:         CATCH TO loException
914:             MsgErro("Erro em CarregarPaginaDados: " + loException.Message, "Erro")
915:             loc_lSucesso = .F.
916:         ENDTRY
917: 
918:         RETURN loc_lSucesso
919:     ENDPROC
920: 
921:     *--------------------------------------------------------------------------

*-- Linhas 985 a 1003:
985:         loc_cGruContas = ""
986: 
987:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
988:             SELECT cursor_4c_Dados
989:             loc_cGrupos    = ALLTRIM(grupos)
990:             loc_cContas    = ALLTRIM(contas)
991:             loc_cGruContas = ALLTRIM(grucontas)
992:         ELSE
993:             MsgAviso("Selecione um registro na lista.", "Selecionar")
994:             RETURN
995:         ENDIF
996: 
997:         THIS.this_cModoAtual      = "PROCURAR"
998:         THIS.this_cGrupoAtual     = loc_cGrupos
999:         THIS.this_cContaAtual     = loc_cContas
1000:         THIS.this_cGruContasAtual = loc_cGruContas
1001:         THIS.HabilitarCampos(.T.)
1002: 
1003:         THIS.CarregarPaginaDados(loc_cGruContas)

*-- Linhas 1014 a 1032:
1014:         loc_cGruContas = ""
1015: 
1016:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1017:             SELECT cursor_4c_Dados
1018:             loc_cGrupos    = ALLTRIM(grupos)
1019:             loc_cContas    = ALLTRIM(contas)
1020:             loc_cGruContas = ALLTRIM(grucontas)
1021:         ELSE
1022:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1023:             RETURN
1024:         ENDIF
1025: 
1026:         THIS.this_cModoAtual      = "ALTERAR"
1027:         THIS.this_cGrupoAtual     = loc_cGrupos
1028:         THIS.this_cContaAtual     = loc_cContas
1029:         THIS.this_cGruContasAtual = loc_cGruContas
1030:         THIS.HabilitarCampos(.T.)
1031: 
1032:         THIS.CarregarPaginaDados(loc_cGruContas)

*-- Linhas 1045 a 1063:
1045:         loc_lConfirmar = .F.
1046: 
1047:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1048:             SELECT cursor_4c_Dados
1049:             loc_cGrupos    = ALLTRIM(grupos)
1050:             loc_cContas    = ALLTRIM(contas)
1051:             loc_cCocos     = ALLTRIM(cocos)
1052:             loc_cCidChaves = ALLTRIM(cidchaves)
1053:         ELSE
1054:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1055:             RETURN
1056:         ENDIF
1057: 
1058:         *-- Legado: a lista mostra UMA linha por lancamento e Excluir remove apenas o
1059:         *-- registro corrente (chave cidchaves). Excluir o grupo+conta inteiro fica
1060:         *-- por conta de Alterar (remover as ocorrencias) — Erro148.
1061:         loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do lan" + CHR(231) + "amento" + CHR(13) + ;
1062:                                      "grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + ;
1063:                                      "' / opera" + CHR(231) + CHR(227) + "o '" + loc_cCocos + "'?", ;

*-- Linhas 1173 a 1191:
1173:             RETURN 0
1174:         ENDIF
1175: 
1176:         SELECT cursor_4c_OcoLocal
1177:         loc_nPonteiro = IIF(RECCOUNT("cursor_4c_OcoLocal") > 0, RECNO(), 0)
1178:         COUNT TO loc_nTotal FOR !EMPTY(ALLTRIM(cursor_4c_OcoLocal.Cocos))
1179: 
1180:         IF loc_nPonteiro > 0 AND loc_nPonteiro <= RECCOUNT("cursor_4c_OcoLocal")
1181:             GO loc_nPonteiro IN cursor_4c_OcoLocal
1182:         ENDIF
1183: 
1184:         RETURN loc_nTotal
1185:     ENDFUNC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE BtnCancelarClick()
1191:         THIS.this_cModoAtual      = "LISTA"

*-- Linhas 1216 a 1264:
1216:         *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
1217:         IF !EMPTY(loc_cGrupo)
1218:             TRY
1219:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1220:                 IF USED("cursor_4c_TmpGrupo")
1221:                     USE IN cursor_4c_TmpGrupo
1222:                 ENDIF
1223:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
1224:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
1225:                     SELECT cursor_4c_TmpGrupo
1226:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1227:                 ELSE
1228:                     loc_oPagina.txt_4c_Desc_Gru.Value = ""
1229:                 ENDIF
1230:             CATCH TO loException
1231:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1232:             ENDTRY
1233:             IF USED("cursor_4c_TmpGrupo")
1234:                 USE IN cursor_4c_TmpGrupo
1235:             ENDIF
1236:         ELSE
1237:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1238:         ENDIF
1239: 
1240:         *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
1241:         IF !EMPTY(loc_cConta)
1242:             TRY
1243:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1244:                 IF USED("cursor_4c_TmpConta")
1245:                     USE IN cursor_4c_TmpConta
1246:                 ENDIF
1247:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConta")
1248:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpConta") AND RECCOUNT("cursor_4c_TmpConta") > 0
1249:                     SELECT cursor_4c_TmpConta
1250:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1251:                 ELSE
1252:                     loc_oPagina.txt_4c_Desc_Con.Value = ""
1253:                 ENDIF
1254:             CATCH TO loException
1255:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
1256:             ENDTRY
1257:             IF USED("cursor_4c_TmpConta")
1258:                 USE IN cursor_4c_TmpConta
1259:             ENDIF
1260:         ELSE
1261:             loc_oPagina.txt_4c_Desc_Con.Value = ""
1262:         ENDIF
1263:     ENDPROC
1264: 

*-- Linhas 1294 a 1336:
1294:         ENDIF
1295: 
1296:         TRY
1297:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1298:             IF USED("cursor_4c_BuscaGrupo")
1299:                 USE IN cursor_4c_BuscaGrupo
1300:             ENDIF
1301:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1302: 
1303:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1304:                 SELECT cursor_4c_BuscaGrupo
1305:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1306:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1307:             ELSE
1308:                 IF USED("cursor_4c_BuscaGrupo")
1309:                     USE IN cursor_4c_BuscaGrupo
1310:                 ENDIF
1311:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1312:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1313:                     "Grupo de Conta Corrente")
1314:                 IF VARTYPE(loc_oBusca) = "O"
1315:                     IF !loc_oBusca.this_lAchouRegistro
1316:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1317:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1318:                         loc_oBusca.Show()
1319:                     ENDIF
1320:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1321:                         SELECT cursor_4c_BuscaGrupo
1322:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1323:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1324:                     ELSE
1325:                         *-- Regra #50: dispensar o picker NAO eh erro. O codigo
1326:                         *-- DIGITADO fica (o legado nunca limpa: o Valid do
1327:                         *-- Get_Grupos so chama fAcessoContab). Apagar aqui obriga
1328:                         *-- o usuario a redigitar e ainda perde o prefixo LIKE da
1329:                         *-- proxima abertura. Limpar SO a descricao.
1330:                         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1331:                     ENDIF
1332:                     loc_oBusca.Release()
1333:                 ENDIF
1334:             ENDIF
1335:         CATCH TO loException
1336:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")

*-- Linhas 1369 a 1411:
1369:         ENDIF
1370: 
1371:         TRY
1372:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1373:             IF USED("cursor_4c_BuscaConta")
1374:                 USE IN cursor_4c_BuscaConta
1375:             ENDIF
1376:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1377: 
1378:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1379:                 SELECT cursor_4c_BuscaConta
1380:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1381:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1382:             ELSE
1383:                 IF USED("cursor_4c_BuscaConta")
1384:                     USE IN cursor_4c_BuscaConta
1385:                 ENDIF
1386:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1387:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1388:                     "Conta Corrente")
1389:                 IF VARTYPE(loc_oBusca) = "O"
1390:                     IF !loc_oBusca.this_lAchouRegistro
1391:                         loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1392:                         loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1393:                         loc_oBusca.Show()
1394:                     ENDIF
1395:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1396:                         SELECT cursor_4c_BuscaConta
1397:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1398:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1399:                     ELSE
1400:                         *-- Regra #50: idem Grupo. O legado (Get_Contas.Valid) so
1401:                         *-- AVISA "Conta Invalida (Acesso Negado)!!" quando
1402:                         *-- fAcessoContas recusa - nunca apaga o que foi digitado.
1403:                         loc_oPagina.txt_4c_Desc_Con.Value = ""
1404:                     ENDIF
1405:                     loc_oBusca.Release()
1406:                 ENDIF
1407:             ENDIF
1408:         CATCH TO loException
1409:             MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
1410:         ENDTRY
1411: 

*-- Linhas 1481 a 1542:
1481:             RETURN .T.
1482:         ENDIF
1483: 
1484:         SELECT cursor_4c_OcoLocal
1485: 
1486:         *-- Cocos vazio: limpar descs e sair
1487:         IF EMPTY(loc_cCocos)
1488:             REPLACE descs WITH ""
1489:             RETURN .T.
1490:         ENDIF
1491: 
1492:         loc_cCocosOk = ""
1493:         loc_cDescsOk = ""
1494: 
1495:         TRY
1496:             loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
1497:             IF USED("cursor_4c_BuscaCoco")
1498:                 USE IN cursor_4c_BuscaCoco
1499:             ENDIF
1500:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1501: 
1502:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1503:                 SELECT cursor_4c_BuscaCoco
1504:                 loc_cCocosOk = ALLTRIM(Cods)
1505:                 loc_cDescsOk = ALLTRIM(Descs)
1506:             ELSE
1507:                 *-- Pattern A canonico (Erro114/Pattern #166): a SQL fica no caller e o
1508:                 *-- picker recebe um cursor JA populado. O Pattern B (CREATEOBJECT com
1509:                 *-- parametros) fechava o cursor quando nem o codigo exato nem o prefixo
1510:                 *-- batiam, e a janela "Selecao" abria vazia, sem colunas e sem explicacao
1511:                 *-- (Erro149). Aqui: prefixo em Cods OU Descs -> fallback mostrando tudo
1512:                 *-- -> aviso explicito quando nao ha ocorrencia cadastrada.
1513:                 IF USED("cursor_4c_BuscaCoco")
1514:                     USE IN cursor_4c_BuscaCoco
1515:                 ENDIF
1516: 
1517:                 loc_cSQL = "SELECT Cods, Descs FROM SigCcCco" + ;
1518:                            " WHERE Cods LIKE "  + EscaparSQL(loc_cCocos + "%") + ;
1519:                            " OR Descs LIKE " + EscaparSQL(loc_cCocos + "%") + ;
1520:                            " ORDER BY Cods"
1521:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1522: 
1523:                 *-- Fallback SHOW-ALL: prefixo nao bateu, mas pode haver outras ocorrencias
1524:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") = 0
1525:                     USE IN cursor_4c_BuscaCoco
1526:                     loc_cSQL = "SELECT Cods, Descs FROM SigCcCco ORDER BY Cods"
1527:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1528:                 ENDIF
1529: 
1530:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1531:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1532:                     IF VARTYPE(loc_oBusca) = "O"
1533:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCoco", "Cods", "Descs", ;
1534:                             "Sele" + CHR(231) + CHR(227) + "o")
1535:                         *-- DefinirCursor titula as colunas com o nome do campo; repor os
1536:                         *-- titulos do legado (fwBuscaExt: 'Codigo' / 'Descricao')
1537:                         loc_oBusca.this_nColunas = 0
1538:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1539:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1540: 
1541:                         IF loc_oBusca.Mostrar()
1542:                             loc_cCocosOk = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 1554 a 1587:
1554:             ENDIF
1555: 
1556:             *-- Verificar duplicidade de cocos no cursor local
1557:             SELECT cursor_4c_OcoLocal
1558:             loc_nPonteiro  = RECNO()
1559:             loc_lDuplicado = .F.
1560: 
1561:             IF !EMPTY(loc_cCocosOk)
1562:                 SET ORDER TO Cocos
1563:                 IF SEEK(PADR(loc_cCocosOk, 2))
1564:                     IF RECNO() != loc_nPonteiro
1565:                         loc_lDuplicado = .T.
1566:                     ENDIF
1567:                 ENDIF
1568:                 SET ORDER TO
1569:                 GO loc_nPonteiro
1570:             ENDIF
1571: 
1572:             *-- O TextBox grava no ControlSource DEPOIS do Valid: o .Value tem de
1573:             *-- receber o mesmo que o cursor, senao o texto digitado volta por cima
1574:             IF loc_lDuplicado
1575:                 MsgAviso("J" + CHR(225) + " existe um registro com este grupo, conta e ocorr" + CHR(234) + "ncia ...", ;
1576:                          "Aten" + CHR(231) + CHR(227) + "o")
1577:                 REPLACE Cocos WITH ""
1578:                 REPLACE descs WITH ""
1579:                 par_oTxt.Value = ""
1580:                 loc_lRetorno   = .F.     && legado: Return 0 - fica na celula
1581:             ELSE
1582:                 REPLACE Cocos WITH loc_cCocosOk
1583:                 REPLACE descs WITH loc_cDescsOk
1584:                 par_oTxt.Value = loc_cCocosOk
1585:             ENDIF
1586:             par_oTxt.this_cValorAnterior = par_oTxt.Value
1587: 

*-- Linhas 1623 a 1641:
1623:         ENDIF
1624: 
1625:         TRY
1626:             SELECT cursor_4c_OcoLocal
1627:             APPEND BLANK
1628:             REPLACE Grupos WITH loc_cGrupos
1629:             REPLACE Contas WITH loc_cContas
1630:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1631:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1632:         CATCH TO loException
1633:             MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1634:         ENDTRY
1635:     ENDPROC
1636: 
1637:     *--------------------------------------------------------------------------
1638:     * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
1639:     * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
1640:     *--------------------------------------------------------------------------
1641:     PROCEDURE BtnExcluirOcoClick()

*-- Linhas 1662 a 1681:
1662:         ENDIF
1663: 
1664:         TRY
1665:             SELECT cursor_4c_OcoLocal
1666:             DELETE
1667:             GO BOTTOM
1668:             IF EOF()
1669:                 APPEND BLANK
1670:                 REPLACE Grupos WITH loc_cGrupos
1671:                 REPLACE Contas WITH loc_cContas
1672:             ENDIF
1673:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1674:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1675:         CATCH TO loException
1676:             MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1677:         ENDTRY
1678:     ENDPROC
1679: 
1680:     *--------------------------------------------------------------------------
1681:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup

*-- Linhas 1727 a 1745:
1727:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1728:                 loc_oBusca.Show()
1729:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1730:                     SELECT cursor_4c_BuscaGrupo
1731:                     loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1732:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1733:                 ENDIF
1734:                 loc_oBusca.Release()
1735:             ENDIF
1736:         CATCH TO loException
1737:             MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
1738:         ENDTRY
1739: 
1740:         IF USED("cursor_4c_BuscaGrupo")
1741:             USE IN cursor_4c_BuscaGrupo
1742:         ENDIF
1743: 
1744:         THIS.this_lEmLookup = loc_lEmLookupAnt
1745:     ENDPROC

*-- Linhas 1791 a 1809:
1791:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1792:                 loc_oBusca.Show()
1793:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1794:                     SELECT cursor_4c_BuscaConta
1795:                     loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1796:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1797:                 ENDIF
1798:                 loc_oBusca.Release()
1799:             ENDIF
1800:         CATCH TO loException
1801:             MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
1802:         ENDTRY
1803: 
1804:         IF USED("cursor_4c_BuscaConta")
1805:             USE IN cursor_4c_BuscaConta
1806:         ENDIF
1807: 
1808:         THIS.this_lEmLookup = loc_lEmLookupAnt
1809:     ENDPROC

*-- Linhas 1909 a 1953:
1909:         ENDIF
1910: 
1911:         TRY
1912:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cTexto)
1913:             IF USED("cursor_4c_BuscaGrupo")
1914:                 USE IN cursor_4c_BuscaGrupo
1915:             ENDIF
1916:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1917: 
1918:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1919:                 SELECT cursor_4c_BuscaGrupo
1920:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1921:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1922:             ELSE
1923:                 IF USED("cursor_4c_BuscaGrupo")
1924:                     USE IN cursor_4c_BuscaGrupo
1925:                 ENDIF
1926:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1927:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cTexto, ;
1928:                     "Grupo de Conta Corrente")
1929:                 IF VARTYPE(loc_oBusca) = "O"
1930:                     IF !loc_oBusca.this_lAchouRegistro
1931:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1932:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1933:                         loc_oBusca.Show()
1934:                     ENDIF
1935:                     *-- Nada escolhido: o texto digitado FICA (regra #50) - o legado
1936:                     *-- nao avisa nem limpa; limpar deixaria o usuario sem saida.
1937:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1938:                         SELECT cursor_4c_BuscaGrupo
1939:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1940:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1941:                     ENDIF
1942:                     loc_oBusca.Release()
1943:                 ENDIF
1944:             ENDIF
1945:         CATCH TO loException
1946:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1947:         ENDTRY
1948: 
1949:         IF USED("cursor_4c_BuscaGrupo")
1950:             USE IN cursor_4c_BuscaGrupo
1951:         ENDIF
1952: 
1953:         *-- Codigo preenchido -> o When fecha o campo de descricao

*-- Linhas 2023 a 2074:
2023:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2024:         loc_cFiltro = ""
2025:         IF !EMPTY(loc_cGrupo)
2026:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
2027:         ENDIF
2028: 
2029:         TRY
2030:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
2031:                        " WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cTexto)
2032:             IF !EMPTY(loc_cFiltro)
2033:                 loc_cSQL = loc_cSQL + " AND " + loc_cFiltro
2034:             ENDIF
2035:             IF USED("cursor_4c_BuscaConta")
2036:                 USE IN cursor_4c_BuscaConta
2037:             ENDIF
2038:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2039: 
2040:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") = 1
2041:                 SELECT cursor_4c_BuscaConta
2042:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2043:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2044:             ELSE
2045:                 IF USED("cursor_4c_BuscaConta")
2046:                     USE IN cursor_4c_BuscaConta
2047:                 ENDIF
2048:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2049:                     "SigCdCli", "cursor_4c_BuscaConta", "Rclis", loc_cTexto, ;
2050:                     "Conta Corrente", .F., .F., loc_cFiltro)
2051:                 IF VARTYPE(loc_oBusca) = "O"
2052:                     IF !loc_oBusca.this_lAchouRegistro
2053:                         loc_oBusca.mAddColuna("Iclis", "", "Conta")
2054:                         loc_oBusca.mAddColuna("Rclis", "", "Nome")
2055:                         loc_oBusca.Show()
2056:                     ENDIF
2057:                     *-- Nada escolhido: o texto digitado FICA (regra #50)
2058:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
2059:                         SELECT cursor_4c_BuscaConta
2060:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2061:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2062:                     ENDIF
2063:                     loc_oBusca.Release()
2064:                 ENDIF
2065:             ENDIF
2066:         CATCH TO loException
2067:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
2068:         ENDTRY
2069: 
2070:         IF USED("cursor_4c_BuscaConta")
2071:             USE IN cursor_4c_BuscaConta
2072:         ENDIF
2073: 
2074:         THIS.AtualizarCamposDescricao()


### BO (C:\4c\projeto\app\classes\SIGPRLNCBO.prg):
*==============================================================================
* SIGPRLNCBO.prg - Business Object para Lancamentos de Conta Corrente
*
* Tabela principal: SigClLan
*   grupos    char(10) NOT NULL  - Grupo da conta corrente (SigCdGcr.codigos)
*   contas    char(10) NOT NULL  - Conta corrente          (SigCdCli.iclis)
*   cocos     char(2)  NOT NULL  - Codigo da ocorrencia    (SIGCCCCO.cods)
*   cidchaves char(20) NOT NULL  - Chave primaria (fUniqueIds)
*   grucontas char(20) NOT NULL  - Chave POSICIONAL grupos(10)+contas(10)
*
* Tabelas auxiliares (somente leitura):
*   SIGCCCCO  (cods char(2),       descs char(30))  - descricao da ocorrencia
*   SigCdGcr  (codigos char(10),   descrs char(40)) - descricao do grupo
*   SigCdCli  (iclis char(10),     rclis char(50))  - nome da conta/cliente
*==============================================================================
DEFINE CLASS SIGPRLNCBO AS BusinessBase

    *-- Campos de SigClLan
    this_cGrupos    = ""    && char(10) - Grupo da conta corrente
    this_cContas    = ""    && char(10) - Conta corrente
    this_cCocos     = ""    && char(2)  - Codigo da ocorrencia
    this_cCidChaves = ""    && char(20) - Chave primaria (gerada por fUniqueIds)
    this_cGruContas = ""    && char(20) - Chave posicional grupos+contas

    *-- Campo auxiliar (descricao da ocorrencia, vem de SIGCCCCO)
    this_cDescs     = ""    && char(30) - Descricao da ocorrencia (SIGCCCCO.descs)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigClLan"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades (chamado por NovoRegistro/CancelarEdicao)
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cGrupos    = ""
        THIS.this_cContas    = ""
        THIS.this_cCocos     = ""
        THIS.this_cCidChaves = ""
        THIS.this_cGruContas = ""
        THIS.this_cDescs     = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    * PROTECTED na BusinessBase: so eh chamado de dentro do BO (RegistrarAuditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGruContas - Monta a chave POSICIONAL grucontas char(20)
    *
    * O legado grava "csSigClLan.Grupos + csSigClLan.Contas", colunas c(10) de um
    * cursor, ou seja o PADDING FAZ PARTE da chave: 10 + 10 = 20 = char(20).
    * ALLTRIM nas partes encurtaria a chave e o WHERE nunca casaria (ZERO linhas,
    * sem erro nenhum). Por isso PADR explicito nas duas partes.
    *--------------------------------------------------------------------------
    FUNCTION MontarGruContas(par_cGrupos, par_cContas)
        LOCAL loc_cGrupos, loc_cContas

        loc_cGrupos = IIF(VARTYPE(par_cGrupos) = "C", par_cGrupos, "")
        loc_cContas = IIF(VARTYPE(par_cContas) = "C", par_cContas, "")

        RETURN PADR(ALLTRIM(loc_cGrupos), 10) + PADR(ALLTRIM(loc_cContas), 10)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes obrigatorias antes de gravar
    *
    * Transcrito de Pagina.Dados.Grupo_Salva.Salva.Click (INSERIR / ALTERAR):
    *   IF IsEmpty(Get_Grupos.Value) -> "Obrigatorio Informar o Grupo"
    *   IF IsEmpty(Get_Contas.Value) -> "Obrigatorio Informar a Conta"
    * A ocorrencia (cocos) eh NOT NULL na tabela e o legado so grava linha com
    * Cocos preenchido ("If !Empty(csSigClLan.cocos)").
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        DO CASE
            CASE EMPTY(ALLTRIM(NVL(THIS.this_cGrupos, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar o Grupo"
                loc_lValido = .F.

            CASE EMPTY(ALLTRIM(NVL(THIS.this_cContas, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar a Conta"
                loc_lValido = .F.

            CASE EMPTY(ALLTRIM(NVL(THIS.this_cCocos, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar a Ocorr" + ;
                    CHR(234) + "ncia"
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor existente
    *
    * TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR PADRAO, nao um codigo
    * de tipo - para coluna char o padrao eh "" (string vazia).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos    = TratarNulo(grupos,    "")
            THIS.this_cContas    = TratarNulo(contas,    "")
            THIS.this_cCocos     = TratarNulo(cocos,     "")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cGruContas = TratarNulo(grucontas, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega a grade da pagina LISTA
    *
    * O legado liga a grade a "Select * From SigClLan" SEM filtro nenhum
    * (AddCursor com o 4o argumento ''), e exibe UMA LINHA POR LANCAMENTO com as
    * colunas Grupos / Contas / Cocos (pColuna do Init). NAO agrupar, NAO usar
    * DISTINCT: a pagina LISTA segue o Init do legado.
    *
    * par_cFiltro eh opcional e so entra quando vier preenchido; a chamada normal
    * do form eh Buscar("") e reproduz exatamente o legado (lista inteira).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.

        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves, a.grucontas" + ;
                       " FROM SigClLan a"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.contas, a.cocos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar lan" + CHR(231) + "amentos: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.Buscar: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarPorGruContas - Posiciona cursor_4c_Dados no 1o lancamento do
    * grupo+conta informado, SEM refazer a consulta.
    *
    * Transcreve LocateCursor('crSigClLan','grucontas',sGruContas) do legado:
    * a PROCURAR do frmcadastro apenas POSICIONA a grade ja carregada.
    * Retorna .T. quando encontrou (cursor posicionado no registro).
    *--------------------------------------------------------------------------
    FUNCTION LocalizarPorGruContas(par_cGrupos, par_cContas)
        LOCAL loc_cChave, loc_lAchou, loc_nRegAnterior
        loc_lAchou = .F.

        TRY
            IF USED("cursor_4c_Dados")
                loc_cChave = THIS.MontarGruContas(par_cGrupos, par_cContas)

                SELECT cursor_4c_Dados
                loc_nRegAnterior = IIF(RECNO() >= 1 AND RECNO() <= RECCOUNT(), RECNO(), 1)

                LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.grucontas)) == ;
                           UPPER(ALLTRIM(loc_cChave))

                IF FOUND()
                    loc_lAchou = .T.
                ELSE
                    IF RECCOUNT("cursor_4c_Dados") >= loc_nRegAnterior
                        GO loc_nRegAnterior IN cursor_4c_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.LocalizarPorGruContas: " + loException.Message, ;
                "Erro")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarOcorrencias - Ocorrencias de um grupo+conta, com a descricao
    *
    * Transcreve a query do Grupo_op.Click do legado:
    *   Select a.*, b.descs from SigClLan a, SigCcCco b
    *    where a.grucontas = '<gruconta>' and a.cocos = b.cods
    * O "from A, B where A.cocos = B.cods" do legado eh INNER JOIN.
    * Retorna o cursor cursor_4c_Ocorrencias.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOcorrencias(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ocorrencias")
                USE IN cursor_4c_Ocorrencias
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves," + ;
                       " a.grucontas, b.descs" + ;
                       " FROM SigClLan a" + ;
                       " INNER JOIN SIGCCCCO b ON b.cods = a.cocos" + ;
                       " WHERE a.grucontas = " + EscaparSQL(par_cGruContas) + ;
                       " ORDER BY a.cocos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorrencias")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar ocorr" + CHR(234) + "ncias: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.BuscarOcorrencias: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoAuxiliar - Le UMA descricao de tabela auxiliar
    * Retorna a descricao encontrada, ou "" quando o codigo nao existe.
    * Codigo vazio nao consulta o banco e devolve "" (nao eh erro).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarDescricaoAuxiliar(par_cTabela, par_cCampoCod, ;
            par_cCampoDesc, par_cValor)

        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_cValor
        loc_cDescricao = ""

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")

        IF !EMPTY(loc_cValor)
            TRY
                IF USED("cursor_4c_Descricao")
                    USE IN cursor_4c_Descricao
                ENDIF

                loc_cSQL = "SELECT " + par_cCampoCod + ", " + par_cCampoDesc + ;
                           " FROM " + par_cTabela + ;
                           " WHERE RTRIM(" + par_cCampoCod + ") = " + EscaparSQL(loc_cValor)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Descricao")

                IF loc_nResultado >= 0 AND USED("cursor_4c_Descricao") ;
                        AND RECCOUNT("cursor_4c_Descricao") > 0
                    SELECT cursor_4c_Descricao
                    GO TOP
                    loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE("cursor_4c_Descricao." + ;
                        par_cCampoDesc), ""))
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o em " + ;
                    par_cTabela + ": " + loException.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_Descricao")
                USE IN cursor_4c_Descricao
            ENDIF
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoOcorrencia - Descricao de uma ocorrencia pelo codigo
    * SIGCCCCO (cods char(2), descs char(30))
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoOcorrencia(par_cCodOco)
        RETURN THIS.BuscarDescricaoAuxiliar("SIGCCCCO", "cods", "descs", par_cCodOco)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Descricao do grupo de conta corrente
    *
    * Transcreve o inicdesc do legado:
    *   cursorquery('SigCdGcr','crTmpgccr','codigos', iGrupo)
    *   get_Desc_Gru.Value = crTmpgccr.Descrs
    * SigCdGcr (codigos char(10), descrs char(40))
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoGrupo(par_cGrupo)
        RETURN THIS.BuscarDescricaoAuxiliar("SigCdGcr", "codigos", "descrs", par_cGrupo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta - Nome da conta corrente (cliente)
    *
    * Transcreve o inicdesc do legado:
    *   cursorquery('SigCdCli','crTmpSigCdCli','iclis', iContas)
    *   get_Desc_Con.Value = crTmpSigCdCli.rclis
    * SigCdCli (iclis char(10), rclis char(50))
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        RETURN THIS.BuscarDescricaoAuxiliar("SigCdCli", "iclis", "rclis", par_cConta)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ELSE
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    IF loc_lSucesso
                        *-- Registro EXISTENTE: o proximo Salvar() tem de ser UPDATE,
                        *-- senao o INSERT viola a PK cidchaves.
                        THIS.this_lNovoRegistro = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.CarregarPorCodigo: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigClLan
    *
    * PUBLIC (sem PROTECTED): Inserir/Atualizar sao PUBLIC na BusinessBase e o
    * form pode chama-los direto. Declarar PROTECTED aqui tornaria o metodo
    * protegido em TODA a cadeia de heranca e a chamada de fora estouraria com
    * "Property INSERIR is not found".
    *
    * As 5 colunas de SigClLan sao NOT NULL e TODAS entram no INSERT.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- cidchaves NUNCA pode ir vazio: eh PK e o 2o registro colidiria
            *-- no indice unico.
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = PADR(ALLTRIM(fUniqueIds()), 20)
            ENDIF

            THIS.this_cGruContas = THIS.MontarGruContas(THIS.this_cGrupos, THIS.this_cContas)

            loc_cSQL = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCidChaves), 20)) + ", " + ;
                       EscaparSQL(THIS.this_cGruContas)                    + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.Inserir: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigClLan
    * PUBLIC pelo mesmo motivo de Inserir() (ver comentario acima).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruContas = THIS.MontarGruContas(THIS.this_cGrupos, THIS.this_cContas)

            loc_cSQL = "UPDATE SigClLan SET" + ;
                       " grupos = "     + EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10)) + ;
                       ", contas = "    + EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10)) + ;
                       ", cocos = "     + EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))   + ;
                       ", grucontas = " + EscaparSQL(THIS.this_cGruContas)                 + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.Atualizar: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigClLan
    * PROTECTED: o form chama Excluir() (PUBLIC), que chama este metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.ExecutarExclusao: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirPorGruContas - Remove TODOS os lancamentos de um grupo+conta
    *
    * Transcreve o delete do Salva.Click do legado:
    *   delete from SigClLan where grucontas = '<lcgrucon>'
    *   If ... < 1 -> MessageBox('Favor Reiniciar o Processo!!!')
    * Usado por SalvarOcorrencias (o legado apaga tudo e reinsere).
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirPorGruContas(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE grucontas = " + ;
                       EscaparSQL(par_cGruContas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Favor Reiniciar o Processo!!! " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro Conexao")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.ExcluirPorGruContas: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarOcorrencias - Grava o conjunto de ocorrencias de um grupo+conta
    *
    * Transcreve Pagina.Dados.Grupo_Salva.Salva.Click (INSERIR / ALTERAR):
    *   1) delete from SigClLan where grucontas = grupos+contas
    *   2) Scan no cursor local; para cada linha com Cocos NAO vazio,
    *      Insert Into SigClLan (Grupos, Contas, Cocos, cIdChaves, Grucontas)
    *      Values (..., fUniqueIds(), Grupos+Contas)
    *
    * par_cGrupos         - codigo do grupo (char 10)
    * par_cContas         - codigo da conta (char 10)
    * par_cCursorOco      - cursor VFP com a lista de ocorrencias (campo cocos)
    * par_lPermitirVazio  - .T. em ALTERAR (cursor vazio = remover tudo)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarOcorrencias(par_cGrupos, par_cContas, par_cCursorOco, par_lPermitirVazio)
        LOCAL loc_cGruContas, loc_lSucesso, loc_cCocos, loc_lAbortar, loc_lPermitirVazio
        LOCAL loc_cSQLIns, loc_nResIns, loc_cCidChaves
        loc_lSucesso = .F.
        loc_lAbortar = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        *-- Cursor vazio significa "remover todas as ocorrencias do grupo+conta" e so
        *-- eh valido em ALTERAR (o legado apaga e reinsere). Em INCLUSAO nao ha o que
        *-- gravar: retornar .F. em vez de sucesso, para o form nao anunciar que salvou
        *-- um registro que nao existe.
        loc_lPermitirVazio = (VARTYPE(par_lPermitirVazio) = "L" AND par_lPermitirVazio)

        TRY
            *-- Validacoes do legado (Obrigatorio Informar o Grupo / a Conta)
            IF EMPTY(ALLTRIM(NVL(par_cGrupos, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar o Grupo"
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar AND EMPTY(ALLTRIM(NVL(par_cContas, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar a Conta"
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                loc_cGruContas = THIS.MontarGruContas(par_cGrupos, par_cContas)

                IF !THIS.ExcluirPorGruContas(loc_cGruContas)
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                IF VARTYPE(par_cCursorOco) != "C" OR !USED(par_cCursorOco) ;
                        OR RECCOUNT(par_cCursorOco) = 0
                    loc_lSucesso = loc_lPermitirVazio
                    loc_lAbortar = .T.
                    IF !loc_lPermitirVazio
                        THIS.this_cMensagemErro = "Nenhuma ocorr" + CHR(234) + ;
                            "ncia informada."
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT (par_cCursorOco)
                GO TOP

                DO WHILE !EOF() AND !loc_lAbortar
                    SELECT (par_cCursorOco)
                    loc_cCocos = ALLTRIM(TratarNulo(cocos, ""))

                    IF !EMPTY(loc_cCocos)
                        loc_cCidChaves = PADR(ALLTRIM(fUniqueIds()), 20)

                        THIS.this_cGrupos    = par_cGrupos
                        THIS.this_cContas    = par_cContas
                        THIS.this_cCocos     = loc_cCocos
                        THIS.this_cGruContas = loc_cGruContas
                        THIS.this_cCidChaves = loc_cCidChaves

                        loc_cSQLIns = "INSERT INTO SigClLan" + ;
                                      " (grupos, contas, cocos, cidchaves, grucontas)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(PADR(ALLTRIM(par_cGrupos), 10)) + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(par_cContas), 10)) + ", " + ;
                                      EscaparSQL(PADR(loc_cCocos, 2))            + ", " + ;
                                      EscaparSQL(loc_cCidChaves)                 + ", " + ;
                                      EscaparSQL(loc_cGruContas)                 + ;
                                      ")"

                        loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)

                        IF loc_nResIns < 0
                            THIS.this_cMensagemErro = "Erro ao inserir ocorr" + CHR(234) + ;
                                "ncia '" + loc_cCocos + "': " + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                            THIS.this_lErroExibido = .T.
                            loc_lAbortar = .T.
                        ELSE
                            THIS.RegistrarAuditoria("INSERT")
                        ENDIF
                    ENDIF

                    IF !loc_lAbortar
                        SELECT (par_cCursorOco)
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.SalvarOcorrencias: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        *-- Falha NUNCA eh muda: se sobrou mensagem sem ter sido exibida, exibe agora.
        IF !loc_lSucesso AND !THIS.this_lErroExibido ;
                AND !EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
            THIS.ExibirFalha("Confirmar")
        ENDIF

        IF loc_lSucesso
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

