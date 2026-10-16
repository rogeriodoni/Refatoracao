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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS SQL (2263 linhas total):

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

*-- Linhas 781 a 822:
781:                     USE IN cursor_4c_Dados
782:                 ENDIF
783:                 SET NULL ON
784:                 CREATE CURSOR cursor_4c_Dados (grupos C(10), contas C(10), cocos C(2), ;
785:                                                cidchaves C(20), grucontas C(20))
786:                 SET NULL OFF
787:                 loc_lSucesso = .T.
788:             ELSE
789:                 IF THIS.this_oBusinessObject.Buscar("")
790:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
791: 
792:                     *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
793:                     loc_oGrid.ColumnCount = 4
794:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
795:                     loc_oGrid.ColumnCount  = 3
796: 
797:                     *-- Colunas do legado (Init): Grupos / Contas / Cocos ("Operacao"), 80px cada
798:                     WITH loc_oGrid
799:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
800:                         .Column1.Width           = 80
801:                         .Column1.Header1.Caption = "Grupos"
802: 
803:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
804:                         .Column2.Width           = 80
805:                         .Column2.Header1.Caption = "Contas"
806: 
807:                         .Column3.ControlSource   = "cursor_4c_Dados.cocos"
808:                         .Column3.Width           = 80
809:                         .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
810:                     ENDWITH
811: 
812:                     THIS.FormatarGridLista(loc_oGrid)
813:                     THIS.AjustarBotoesPorModo()
814:                     loc_lSucesso = .T.
815:                 ENDIF
816:             ENDIF
817:         CATCH TO loException
818:             MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
819:             loc_lSucesso = .F.
820:         ENDTRY
821: 
822:         RETURN loc_lSucesso

*-- Linhas 896 a 923:
896:             IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
897:                 *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
898:                 IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
899:                     SELECT cursor_4c_Ocorrencias
900:                     GO TOP
901:                     DO WHILE !EOF()
902:                         SELECT cursor_4c_OcoLocal
903:                         APPEND BLANK
904:                         REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
905:                         REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
906:                         REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
907:                         REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
908:                         SELECT cursor_4c_Ocorrencias
909:                         SKIP
910:                     ENDDO
911:                 ENDIF
912:                 loc_lSucesso = .T.
913:             ENDIF
914:             THIS.AtualizarGradeOcorrencias()
915:         CATCH TO loException
916:             MsgErro("Erro em CarregarPaginaDados: " + loException.Message, "Erro")
917:             loc_lSucesso = .F.
918:         ENDTRY
919: 
920:         RETURN loc_lSucesso
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------

*-- Linhas 987 a 1005:
987:         loc_cGruContas = ""
988: 
989:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
990:             SELECT cursor_4c_Dados
991:             loc_cGrupos    = ALLTRIM(grupos)
992:             loc_cContas    = ALLTRIM(contas)
993:             loc_cGruContas = ALLTRIM(grucontas)
994:         ELSE
995:             MsgAviso("Selecione um registro na lista.", "Selecionar")
996:             RETURN
997:         ENDIF
998: 
999:         THIS.this_cModoAtual      = "PROCURAR"
1000:         THIS.this_cGrupoAtual     = loc_cGrupos
1001:         THIS.this_cContaAtual     = loc_cContas
1002:         THIS.this_cGruContasAtual = loc_cGruContas
1003:         THIS.HabilitarCampos(.T.)
1004: 
1005:         THIS.CarregarPaginaDados(loc_cGruContas)

*-- Linhas 1016 a 1034:
1016:         loc_cGruContas = ""
1017: 
1018:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1019:             SELECT cursor_4c_Dados
1020:             loc_cGrupos    = ALLTRIM(grupos)
1021:             loc_cContas    = ALLTRIM(contas)
1022:             loc_cGruContas = ALLTRIM(grucontas)
1023:         ELSE
1024:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1025:             RETURN
1026:         ENDIF
1027: 
1028:         THIS.this_cModoAtual      = "ALTERAR"
1029:         THIS.this_cGrupoAtual     = loc_cGrupos
1030:         THIS.this_cContaAtual     = loc_cContas
1031:         THIS.this_cGruContasAtual = loc_cGruContas
1032:         THIS.HabilitarCampos(.T.)
1033: 
1034:         THIS.CarregarPaginaDados(loc_cGruContas)

*-- Linhas 1047 a 1065:
1047:         loc_lConfirmar = .F.
1048: 
1049:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1050:             SELECT cursor_4c_Dados
1051:             loc_cGrupos    = ALLTRIM(grupos)
1052:             loc_cContas    = ALLTRIM(contas)
1053:             loc_cCocos     = ALLTRIM(cocos)
1054:             loc_cCidChaves = ALLTRIM(cidchaves)
1055:         ELSE
1056:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1057:             RETURN
1058:         ENDIF
1059: 
1060:         *-- Legado: a lista mostra UMA linha por lancamento e Excluir remove apenas o
1061:         *-- registro corrente (chave cidchaves). Excluir o grupo+conta inteiro fica
1062:         *-- por conta de Alterar (remover as ocorrencias) — Erro148.
1063:         loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do lan" + CHR(231) + "amento" + CHR(13) + ;
1064:                                      "grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + ;
1065:                                      "' / opera" + CHR(231) + CHR(227) + "o '" + loc_cCocos + "'?", ;

*-- Linhas 1175 a 1193:
1175:             RETURN 0
1176:         ENDIF
1177: 
1178:         SELECT cursor_4c_OcoLocal
1179:         loc_nPonteiro = IIF(RECCOUNT("cursor_4c_OcoLocal") > 0, RECNO(), 0)
1180:         COUNT TO loc_nTotal FOR !EMPTY(ALLTRIM(cursor_4c_OcoLocal.Cocos))
1181: 
1182:         IF loc_nPonteiro > 0 AND loc_nPonteiro <= RECCOUNT("cursor_4c_OcoLocal")
1183:             GO loc_nPonteiro IN cursor_4c_OcoLocal
1184:         ENDIF
1185: 
1186:         RETURN loc_nTotal
1187:     ENDFUNC
1188: 
1189:     *--------------------------------------------------------------------------
1190:     * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
1191:     *--------------------------------------------------------------------------
1192:     PROCEDURE BtnCancelarClick()
1193:         THIS.this_cModoAtual      = "LISTA"

*-- Linhas 1218 a 1266:
1218:         *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
1219:         IF !EMPTY(loc_cGrupo)
1220:             TRY
1221:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1222:                 IF USED("cursor_4c_TmpGrupo")
1223:                     USE IN cursor_4c_TmpGrupo
1224:                 ENDIF
1225:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
1226:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
1227:                     SELECT cursor_4c_TmpGrupo
1228:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1229:                 ELSE
1230:                     loc_oPagina.txt_4c_Desc_Gru.Value = ""
1231:                 ENDIF
1232:             CATCH TO loException
1233:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1234:             ENDTRY
1235:             IF USED("cursor_4c_TmpGrupo")
1236:                 USE IN cursor_4c_TmpGrupo
1237:             ENDIF
1238:         ELSE
1239:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1240:         ENDIF
1241: 
1242:         *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
1243:         IF !EMPTY(loc_cConta)
1244:             TRY
1245:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1246:                 IF USED("cursor_4c_TmpConta")
1247:                     USE IN cursor_4c_TmpConta
1248:                 ENDIF
1249:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConta")
1250:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpConta") AND RECCOUNT("cursor_4c_TmpConta") > 0
1251:                     SELECT cursor_4c_TmpConta
1252:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1253:                 ELSE
1254:                     loc_oPagina.txt_4c_Desc_Con.Value = ""
1255:                 ENDIF
1256:             CATCH TO loException
1257:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
1258:             ENDTRY
1259:             IF USED("cursor_4c_TmpConta")
1260:                 USE IN cursor_4c_TmpConta
1261:             ENDIF
1262:         ELSE
1263:             loc_oPagina.txt_4c_Desc_Con.Value = ""
1264:         ENDIF
1265:     ENDPROC
1266: 

*-- Linhas 1296 a 1338:
1296:         ENDIF
1297: 
1298:         TRY
1299:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1300:             IF USED("cursor_4c_BuscaGrupo")
1301:                 USE IN cursor_4c_BuscaGrupo
1302:             ENDIF
1303:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1304: 
1305:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1306:                 SELECT cursor_4c_BuscaGrupo
1307:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1308:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1309:             ELSE
1310:                 IF USED("cursor_4c_BuscaGrupo")
1311:                     USE IN cursor_4c_BuscaGrupo
1312:                 ENDIF
1313:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1314:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1315:                     "Grupo de Conta Corrente")
1316:                 IF VARTYPE(loc_oBusca) = "O"
1317:                     IF !loc_oBusca.this_lAchouRegistro
1318:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1319:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1320:                         loc_oBusca.Show()
1321:                     ENDIF
1322:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1323:                         SELECT cursor_4c_BuscaGrupo
1324:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1325:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1326:                     ELSE
1327:                         *-- Regra #50: dispensar o picker NAO eh erro. O codigo
1328:                         *-- DIGITADO fica (o legado nunca limpa: o Valid do
1329:                         *-- Get_Grupos so chama fAcessoContab). Apagar aqui obriga
1330:                         *-- o usuario a redigitar e ainda perde o prefixo LIKE da
1331:                         *-- proxima abertura. Limpar SO a descricao.
1332:                         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1333:                     ENDIF
1334:                     loc_oBusca.Release()
1335:                 ENDIF
1336:             ENDIF
1337:         CATCH TO loException
1338:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")

*-- Linhas 1371 a 1413:
1371:         ENDIF
1372: 
1373:         TRY
1374:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1375:             IF USED("cursor_4c_BuscaConta")
1376:                 USE IN cursor_4c_BuscaConta
1377:             ENDIF
1378:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1379: 
1380:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1381:                 SELECT cursor_4c_BuscaConta
1382:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1383:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1384:             ELSE
1385:                 IF USED("cursor_4c_BuscaConta")
1386:                     USE IN cursor_4c_BuscaConta
1387:                 ENDIF
1388:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1389:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1390:                     "Conta Corrente")
1391:                 IF VARTYPE(loc_oBusca) = "O"
1392:                     IF !loc_oBusca.this_lAchouRegistro
1393:                         loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1394:                         loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1395:                         loc_oBusca.Show()
1396:                     ENDIF
1397:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1398:                         SELECT cursor_4c_BuscaConta
1399:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1400:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1401:                     ELSE
1402:                         *-- Regra #50: idem Grupo. O legado (Get_Contas.Valid) so
1403:                         *-- AVISA "Conta Invalida (Acesso Negado)!!" quando
1404:                         *-- fAcessoContas recusa - nunca apaga o que foi digitado.
1405:                         loc_oPagina.txt_4c_Desc_Con.Value = ""
1406:                     ENDIF
1407:                     loc_oBusca.Release()
1408:                 ENDIF
1409:             ENDIF
1410:         CATCH TO loException
1411:             MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
1412:         ENDTRY
1413: 

*-- Linhas 1483 a 1544:
1483:             RETURN .T.
1484:         ENDIF
1485: 
1486:         SELECT cursor_4c_OcoLocal
1487: 
1488:         *-- Cocos vazio: limpar descs e sair
1489:         IF EMPTY(loc_cCocos)
1490:             REPLACE descs WITH ""
1491:             RETURN .T.
1492:         ENDIF
1493: 
1494:         loc_cCocosOk = ""
1495:         loc_cDescsOk = ""
1496: 
1497:         TRY
1498:             loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
1499:             IF USED("cursor_4c_BuscaCoco")
1500:                 USE IN cursor_4c_BuscaCoco
1501:             ENDIF
1502:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1503: 
1504:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1505:                 SELECT cursor_4c_BuscaCoco
1506:                 loc_cCocosOk = ALLTRIM(Cods)
1507:                 loc_cDescsOk = ALLTRIM(Descs)
1508:             ELSE
1509:                 *-- Pattern A canonico (Erro114/Pattern #166): a SQL fica no caller e o
1510:                 *-- picker recebe um cursor JA populado. O Pattern B (CREATEOBJECT com
1511:                 *-- parametros) fechava o cursor quando nem o codigo exato nem o prefixo
1512:                 *-- batiam, e a janela "Selecao" abria vazia, sem colunas e sem explicacao
1513:                 *-- (Erro149). Aqui: prefixo em Cods OU Descs -> fallback mostrando tudo
1514:                 *-- -> aviso explicito quando nao ha ocorrencia cadastrada.
1515:                 IF USED("cursor_4c_BuscaCoco")
1516:                     USE IN cursor_4c_BuscaCoco
1517:                 ENDIF
1518: 
1519:                 loc_cSQL = "SELECT Cods, Descs FROM SigCcCco" + ;
1520:                            " WHERE Cods LIKE "  + EscaparSQL(loc_cCocos + "%") + ;
1521:                            " OR Descs LIKE " + EscaparSQL(loc_cCocos + "%") + ;
1522:                            " ORDER BY Cods"
1523:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1524: 
1525:                 *-- Fallback SHOW-ALL: prefixo nao bateu, mas pode haver outras ocorrencias
1526:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") = 0
1527:                     USE IN cursor_4c_BuscaCoco
1528:                     loc_cSQL = "SELECT Cods, Descs FROM SigCcCco ORDER BY Cods"
1529:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1530:                 ENDIF
1531: 
1532:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1533:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1534:                     IF VARTYPE(loc_oBusca) = "O"
1535:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCoco", "Cods", "Descs", ;
1536:                             "Sele" + CHR(231) + CHR(227) + "o")
1537:                         *-- DefinirCursor titula as colunas com o nome do campo; repor os
1538:                         *-- titulos do legado (fwBuscaExt: 'Codigo' / 'Descricao')
1539:                         loc_oBusca.this_nColunas = 0
1540:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1541:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1542: 
1543:                         IF loc_oBusca.Mostrar()
1544:                             loc_cCocosOk = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 1556 a 1589:
1556:             ENDIF
1557: 
1558:             *-- Verificar duplicidade de cocos no cursor local
1559:             SELECT cursor_4c_OcoLocal
1560:             loc_nPonteiro  = RECNO()
1561:             loc_lDuplicado = .F.
1562: 
1563:             IF !EMPTY(loc_cCocosOk)
1564:                 SET ORDER TO Cocos
1565:                 IF SEEK(PADR(loc_cCocosOk, 2))
1566:                     IF RECNO() != loc_nPonteiro
1567:                         loc_lDuplicado = .T.
1568:                     ENDIF
1569:                 ENDIF
1570:                 SET ORDER TO
1571:                 GO loc_nPonteiro
1572:             ENDIF
1573: 
1574:             *-- O TextBox grava no ControlSource DEPOIS do Valid: o .Value tem de
1575:             *-- receber o mesmo que o cursor, senao o texto digitado volta por cima
1576:             IF loc_lDuplicado
1577:                 MsgAviso("J" + CHR(225) + " existe um registro com este grupo, conta e ocorr" + CHR(234) + "ncia ...", ;
1578:                          "Aten" + CHR(231) + CHR(227) + "o")
1579:                 REPLACE Cocos WITH ""
1580:                 REPLACE descs WITH ""
1581:                 par_oTxt.Value = ""
1582:                 loc_lRetorno   = .F.     && legado: Return 0 - fica na celula
1583:             ELSE
1584:                 REPLACE Cocos WITH loc_cCocosOk
1585:                 REPLACE descs WITH loc_cDescsOk
1586:                 par_oTxt.Value = loc_cCocosOk
1587:             ENDIF
1588:             par_oTxt.this_cValorAnterior = par_oTxt.Value
1589: 

*-- Linhas 1625 a 1643:
1625:         ENDIF
1626: 
1627:         TRY
1628:             SELECT cursor_4c_OcoLocal
1629:             APPEND BLANK
1630:             REPLACE Grupos WITH loc_cGrupos
1631:             REPLACE Contas WITH loc_cContas
1632:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1633:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1634:         CATCH TO loException
1635:             MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1636:         ENDTRY
1637:     ENDPROC
1638: 
1639:     *--------------------------------------------------------------------------
1640:     * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
1641:     * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
1642:     *--------------------------------------------------------------------------
1643:     PROCEDURE BtnExcluirOcoClick()

*-- Linhas 1664 a 1683:
1664:         ENDIF
1665: 
1666:         TRY
1667:             SELECT cursor_4c_OcoLocal
1668:             DELETE
1669:             GO BOTTOM
1670:             IF EOF()
1671:                 APPEND BLANK
1672:                 REPLACE Grupos WITH loc_cGrupos
1673:                 REPLACE Contas WITH loc_cContas
1674:             ENDIF
1675:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1676:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1677:         CATCH TO loException
1678:             MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1679:         ENDTRY
1680:     ENDPROC
1681: 
1682:     *--------------------------------------------------------------------------
1683:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup

*-- Linhas 1729 a 1747:
1729:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1730:                 loc_oBusca.Show()
1731:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1732:                     SELECT cursor_4c_BuscaGrupo
1733:                     loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1734:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1735:                 ENDIF
1736:                 loc_oBusca.Release()
1737:             ENDIF
1738:         CATCH TO loException
1739:             MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
1740:         ENDTRY
1741: 
1742:         IF USED("cursor_4c_BuscaGrupo")
1743:             USE IN cursor_4c_BuscaGrupo
1744:         ENDIF
1745: 
1746:         THIS.this_lEmLookup = loc_lEmLookupAnt
1747:     ENDPROC

*-- Linhas 1793 a 1811:
1793:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1794:                 loc_oBusca.Show()
1795:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1796:                     SELECT cursor_4c_BuscaConta
1797:                     loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1798:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1799:                 ENDIF
1800:                 loc_oBusca.Release()
1801:             ENDIF
1802:         CATCH TO loException
1803:             MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
1804:         ENDTRY
1805: 
1806:         IF USED("cursor_4c_BuscaConta")
1807:             USE IN cursor_4c_BuscaConta
1808:         ENDIF
1809: 
1810:         THIS.this_lEmLookup = loc_lEmLookupAnt
1811:     ENDPROC

*-- Linhas 1911 a 1955:
1911:         ENDIF
1912: 
1913:         TRY
1914:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cTexto)
1915:             IF USED("cursor_4c_BuscaGrupo")
1916:                 USE IN cursor_4c_BuscaGrupo
1917:             ENDIF
1918:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1919: 
1920:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1921:                 SELECT cursor_4c_BuscaGrupo
1922:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1923:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1924:             ELSE
1925:                 IF USED("cursor_4c_BuscaGrupo")
1926:                     USE IN cursor_4c_BuscaGrupo
1927:                 ENDIF
1928:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1929:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cTexto, ;
1930:                     "Grupo de Conta Corrente")
1931:                 IF VARTYPE(loc_oBusca) = "O"
1932:                     IF !loc_oBusca.this_lAchouRegistro
1933:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1934:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1935:                         loc_oBusca.Show()
1936:                     ENDIF
1937:                     *-- Nada escolhido: o texto digitado FICA (regra #50) - o legado
1938:                     *-- nao avisa nem limpa; limpar deixaria o usuario sem saida.
1939:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1940:                         SELECT cursor_4c_BuscaGrupo
1941:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1942:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1943:                     ENDIF
1944:                     loc_oBusca.Release()
1945:                 ENDIF
1946:             ENDIF
1947:         CATCH TO loException
1948:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1949:         ENDTRY
1950: 
1951:         IF USED("cursor_4c_BuscaGrupo")
1952:             USE IN cursor_4c_BuscaGrupo
1953:         ENDIF
1954: 
1955:         *-- Codigo preenchido -> o When fecha o campo de descricao

*-- Linhas 2025 a 2076:
2025:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2026:         loc_cFiltro = ""
2027:         IF !EMPTY(loc_cGrupo)
2028:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
2029:         ENDIF
2030: 
2031:         TRY
2032:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
2033:                        " WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cTexto)
2034:             IF !EMPTY(loc_cFiltro)
2035:                 loc_cSQL = loc_cSQL + " AND " + loc_cFiltro
2036:             ENDIF
2037:             IF USED("cursor_4c_BuscaConta")
2038:                 USE IN cursor_4c_BuscaConta
2039:             ENDIF
2040:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2041: 
2042:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") = 1
2043:                 SELECT cursor_4c_BuscaConta
2044:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2045:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2046:             ELSE
2047:                 IF USED("cursor_4c_BuscaConta")
2048:                     USE IN cursor_4c_BuscaConta
2049:                 ENDIF
2050:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2051:                     "SigCdCli", "cursor_4c_BuscaConta", "Rclis", loc_cTexto, ;
2052:                     "Conta Corrente", .F., .F., loc_cFiltro)
2053:                 IF VARTYPE(loc_oBusca) = "O"
2054:                     IF !loc_oBusca.this_lAchouRegistro
2055:                         loc_oBusca.mAddColuna("Iclis", "", "Conta")
2056:                         loc_oBusca.mAddColuna("Rclis", "", "Nome")
2057:                         loc_oBusca.Show()
2058:                     ENDIF
2059:                     *-- Nada escolhido: o texto digitado FICA (regra #50)
2060:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
2061:                         SELECT cursor_4c_BuscaConta
2062:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2063:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2064:                     ENDIF
2065:                     loc_oBusca.Release()
2066:                 ENDIF
2067:             ENDIF
2068:         CATCH TO loException
2069:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
2070:         ENDTRY
2071: 
2072:         IF USED("cursor_4c_BuscaConta")
2073:             USE IN cursor_4c_BuscaConta
2074:         ENDIF
2075: 
2076:         THIS.AtualizarCamposDescricao()


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

