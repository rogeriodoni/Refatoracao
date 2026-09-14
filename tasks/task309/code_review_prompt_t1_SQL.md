# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCONTAS, COCOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1599 linhas total):

*-- Linhas 46 a 64:
46:                 USE IN cursor_4c_OcoLocal
47:             ENDIF
48:             SET NULL ON
49:             CREATE CURSOR cursor_4c_OcoLocal (Grupos C(10), Contas C(10), Cocos C(2), descs C(30))
50:             SET NULL OFF
51:             INDEX ON Cocos TAG Cocos
52: 
53:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRLNCBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
57:             ELSE
58:                 THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"
59: 
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.ConfigurarPaginaLista()
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

*-- Linhas 342 a 360:
342:             .HighlightBackColor = RGB(255, 255, 255)
343:             .HighlightForeColor = RGB(15, 41, 104)
344:             .HighlightStyle     = 2
345:             .DeleteMark         = .F.
346:             .RecordMark         = .F.
347:             .RowHeight          = 16
348:             .ScrollBars         = 2
349:             .GridLines          = 3
350:             .Visible            = .T.
351:         ENDWITH
352: 
353:         THIS.TornarControlesVisiveis(loc_oPagina)
354:     ENDPROC
355: 
356:     *--------------------------------------------------------------------------
357:     * ConfigurarPaginaDados - Page2: campos de identificacao (Grupo/Conta) e botoes
358:     * Fase 5/8: Container botoes + labels/textboxes de Grupo e Conta
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 595 a 635:
595:             .ScrollBars         = 2
596:             .GridLines          = 3
597:             .GridLineColor      = RGB(238, 238, 238)
598:             .DeleteMark         = .F.
599:             .RecordMark         = .F.
600:             .HighlightStyle     = 2
601:             .HighlightBackColor = RGB(255, 255, 255)
602:             .HighlightForeColor = RGB(15, 41, 104)
603:             .Visible            = .T.
604: 
605:             .Column1.ControlSource     = "cursor_4c_OcoLocal.Cocos"
606:             .Column1.Width             = 70
607:             .Column1.Movable           = .F.
608:             .Column1.Resizable         = .F.
609:             .Column1.Visible           = .T.
610:             .Column1.Sparse            = .F.
611:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
612:             .Column1.Header1.FontName  = "Tahoma"
613:             .Column1.Header1.FontSize  = 8
614:             .Column1.Header1.Alignment = 2
615:             .Column1.Text1.FontName    = "Verdana"
616:             .Column1.Text1.FontSize    = 8
617:             .Column1.Text1.BorderStyle = 0
618:             .Column1.Text1.Margin      = 0
619: 
620:             .Column2.ControlSource     = "cursor_4c_OcoLocal.descs"
621:             .Column2.Width             = 220
622:             .Column2.Movable           = .F.
623:             .Column2.Resizable         = .F.
624:             .Column2.ReadOnly          = .T.
625:             .Column2.Visible           = .T.
626:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
627:             .Column2.Header1.FontName  = "Tahoma"
628:             .Column2.Header1.FontSize  = 8
629:             .Column2.Header1.Alignment = 2
630:             .Column2.Text1.FontName    = "Verdana"
631:             .Column2.Text1.FontSize    = 8
632:             .Column2.Text1.BorderStyle = 0
633:             .Column2.Text1.Margin      = 0
634:             .Column2.Text1.ReadOnly    = .T.
635:         ENDWITH

*-- Linhas 658 a 680:
658:                     loc_oGrid.ColumnCount  = 2
659: 
660:                     WITH loc_oGrid
661:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
662:                         .Column1.Width           = 200
663:                         .Column1.Header1.Caption = "Grupo"
664: 
665:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
666:                         .Column2.Width           = 200
667:                         .Column2.Header1.Caption = "Conta"
668:                     ENDWITH
669: 
670:                     THIS.FormatarGridLista(loc_oGrid)
671:                     THIS.AjustarBotoesPorModo()
672:                     loc_lSucesso = .T.
673:                 ENDIF
674:             ENDIF
675:         CATCH TO loException
676:             MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
677:             loc_lSucesso = .F.
678:         ENDTRY
679: 
680:         RETURN loc_lSucesso

*-- Linhas 741 a 768:
741:             IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
742:                 *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
743:                 IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
744:                     SELECT cursor_4c_Ocorrencias
745:                     GO TOP
746:                     DO WHILE !EOF()
747:                         SELECT cursor_4c_OcoLocal
748:                         APPEND BLANK
749:                         REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
750:                         REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
751:                         REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
752:                         REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
753:                         SELECT cursor_4c_Ocorrencias
754:                         SKIP
755:                     ENDDO
756:                 ENDIF
757:                 GO TOP IN cursor_4c_OcoLocal
758:                 loc_lSucesso = .T.
759:             ENDIF
760:         CATCH TO loException
761:             MsgErro("Erro em CarregarPaginaDados: " + loException.Message, "Erro")
762:             loc_lSucesso = .F.
763:         ENDTRY
764: 
765:         RETURN loc_lSucesso
766:     ENDPROC
767: 
768:     *--------------------------------------------------------------------------

*-- Linhas 814 a 832:
814:         loc_cGruContas = ""
815: 
816:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
817:             SELECT cursor_4c_Dados
818:             loc_cGrupos    = ALLTRIM(grupos)
819:             loc_cContas    = ALLTRIM(contas)
820:             loc_cGruContas = ALLTRIM(grucontas)
821:         ELSE
822:             MsgAviso("Selecione um registro na lista.", "Selecionar")
823:             RETURN
824:         ENDIF
825: 
826:         THIS.this_cModoAtual      = "PROCURAR"
827:         THIS.this_cGrupoAtual     = loc_cGrupos
828:         THIS.this_cContaAtual     = loc_cContas
829:         THIS.this_cGruContasAtual = loc_cGruContas
830:         THIS.HabilitarCampos(.T.)
831: 
832:         THIS.CarregarPaginaDados(loc_cGruContas)

*-- Linhas 843 a 861:
843:         loc_cGruContas = ""
844: 
845:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
846:             SELECT cursor_4c_Dados
847:             loc_cGrupos    = ALLTRIM(grupos)
848:             loc_cContas    = ALLTRIM(contas)
849:             loc_cGruContas = ALLTRIM(grucontas)
850:         ELSE
851:             MsgAviso("Selecione um registro na lista.", "Selecionar")
852:             RETURN
853:         ENDIF
854: 
855:         THIS.this_cModoAtual      = "ALTERAR"
856:         THIS.this_cGrupoAtual     = loc_cGrupos
857:         THIS.this_cContaAtual     = loc_cContas
858:         THIS.this_cGruContasAtual = loc_cGruContas
859:         THIS.HabilitarCampos(.T.)
860: 
861:         THIS.CarregarPaginaDados(loc_cGruContas)

*-- Linhas 873 a 891:
873:         loc_lConfirmar = .F.
874: 
875:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
876:             SELECT cursor_4c_Dados
877:             loc_cGrupos    = ALLTRIM(grupos)
878:             loc_cContas    = ALLTRIM(contas)
879:             loc_cGruContas = ALLTRIM(grucontas)
880:         ELSE
881:             MsgAviso("Selecione um registro na lista.", "Selecionar")
882:             RETURN
883:         ENDIF
884: 
885:         loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o de todos os lan" + CHR(231) + "amentos" + CHR(13) + ;
886:                                      "do grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + "'?", ;
887:                                      "Confirmar Exclus" + CHR(227) + "o")
888: 
889:         IF loc_lConfirmar
890:             IF THIS.this_oBusinessObject.ExcluirPorGruContas(loc_cGruContas)
891:                 MsgInfo("Lan" + CHR(231) + "amentos exclu" + CHR(237) + "dos com sucesso!", "Sucesso")

*-- Linhas 989 a 1037:
989:         *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
990:         IF !EMPTY(loc_cGrupo)
991:             TRY
992:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
993:                 IF USED("cursor_4c_TmpGrupo")
994:                     USE IN cursor_4c_TmpGrupo
995:                 ENDIF
996:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
997:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
998:                     SELECT cursor_4c_TmpGrupo
999:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1000:                 ELSE
1001:                     loc_oPagina.txt_4c_Desc_Gru.Value = ""
1002:                 ENDIF
1003:             CATCH TO loException
1004:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1005:             ENDTRY
1006:             IF USED("cursor_4c_TmpGrupo")
1007:                 USE IN cursor_4c_TmpGrupo
1008:             ENDIF
1009:         ELSE
1010:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1011:         ENDIF
1012: 
1013:         *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
1014:         IF !EMPTY(loc_cConta)
1015:             TRY
1016:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1017:                 IF USED("cursor_4c_TmpConta")
1018:                     USE IN cursor_4c_TmpConta
1019:                 ENDIF
1020:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConta")
1021:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpConta") AND RECCOUNT("cursor_4c_TmpConta") > 0
1022:                     SELECT cursor_4c_TmpConta
1023:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1024:                 ELSE
1025:                     loc_oPagina.txt_4c_Desc_Con.Value = ""
1026:                 ENDIF
1027:             CATCH TO loException
1028:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
1029:             ENDTRY
1030:             IF USED("cursor_4c_TmpConta")
1031:                 USE IN cursor_4c_TmpConta
1032:             ENDIF
1033:         ELSE
1034:             loc_oPagina.txt_4c_Desc_Con.Value = ""
1035:         ENDIF
1036:     ENDPROC
1037: 

*-- Linhas 1050 a 1092:
1050:         ENDIF
1051: 
1052:         TRY
1053:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1054:             IF USED("cursor_4c_BuscaGrupo")
1055:                 USE IN cursor_4c_BuscaGrupo
1056:             ENDIF
1057:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1058: 
1059:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1060:                 SELECT cursor_4c_BuscaGrupo
1061:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1062:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1063:             ELSE
1064:                 IF USED("cursor_4c_BuscaGrupo")
1065:                     USE IN cursor_4c_BuscaGrupo
1066:                 ENDIF
1067:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1068:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1069:                     "Grupo de Conta Corrente")
1070:                 IF VARTYPE(loc_oBusca) = "O"
1071:                     IF !loc_oBusca.this_lAchouRegistro
1072:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1073:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1074:                         loc_oBusca.Show()
1075:                     ENDIF
1076:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1077:                         SELECT cursor_4c_BuscaGrupo
1078:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1079:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1080:                     ELSE
1081:                         loc_oPagina.txt_4c_Grupo.Value    = ""
1082:                         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1083:                     ENDIF
1084:                     loc_oBusca.Release()
1085:                 ENDIF
1086:             ENDIF
1087:         CATCH TO loException
1088:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
1089:         ENDTRY
1090: 
1091:         IF USED("cursor_4c_BuscaGrupo")
1092:             USE IN cursor_4c_BuscaGrupo

*-- Linhas 1108 a 1150:
1108:         ENDIF
1109: 
1110:         TRY
1111:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1112:             IF USED("cursor_4c_BuscaConta")
1113:                 USE IN cursor_4c_BuscaConta
1114:             ENDIF
1115:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1116: 
1117:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1118:                 SELECT cursor_4c_BuscaConta
1119:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1120:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1121:             ELSE
1122:                 IF USED("cursor_4c_BuscaConta")
1123:                     USE IN cursor_4c_BuscaConta
1124:                 ENDIF
1125:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1126:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1127:                     "Conta Corrente")
1128:                 IF VARTYPE(loc_oBusca) = "O"
1129:                     IF !loc_oBusca.this_lAchouRegistro
1130:                         loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1131:                         loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1132:                         loc_oBusca.Show()
1133:                     ENDIF
1134:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1135:                         SELECT cursor_4c_BuscaConta
1136:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1137:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1138:                     ELSE
1139:                         loc_oPagina.txt_4c_Contas.Value   = ""
1140:                         loc_oPagina.txt_4c_Desc_Con.Value = ""
1141:                     ENDIF
1142:                     loc_oBusca.Release()
1143:                 ENDIF
1144:             ENDIF
1145:         CATCH TO loException
1146:             MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
1147:         ENDTRY
1148: 
1149:         IF USED("cursor_4c_BuscaConta")
1150:             USE IN cursor_4c_BuscaConta

*-- Linhas 1212 a 1282:
1212:             RETURN
1213:         ENDIF
1214: 
1215:         SELECT cursor_4c_OcoLocal
1216:         loc_cCocos = ALLTRIM(cursor_4c_OcoLocal.Cocos)
1217:         loc_cDescs = ALLTRIM(cursor_4c_OcoLocal.descs)
1218: 
1219:         *-- Cocos vazio: limpar descs e sair
1220:         IF EMPTY(loc_cCocos)
1221:             IF !EMPTY(loc_cDescs)
1222:                 REPLACE descs WITH ""
1223:             ENDIF
1224:             RETURN
1225:         ENDIF
1226: 
1227:         loc_cCocosOk = ""
1228:         loc_cDescsOk = ""
1229: 
1230:         TRY
1231:             loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
1232:             IF USED("cursor_4c_BuscaCoco")
1233:                 USE IN cursor_4c_BuscaCoco
1234:             ENDIF
1235:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1236: 
1237:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1238:                 SELECT cursor_4c_BuscaCoco
1239:                 loc_cCocosOk = ALLTRIM(Cods)
1240:                 loc_cDescsOk = ALLTRIM(Descs)
1241:             ELSE
1242:                 IF USED("cursor_4c_BuscaCoco")
1243:                     USE IN cursor_4c_BuscaCoco
1244:                 ENDIF
1245:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1246:                     "SigCcCco", "cursor_4c_BuscaCoco", "Cods", loc_cCocos, ;
1247:                     "Sele" + CHR(231) + CHR(227) + "o")
1248:                 IF VARTYPE(loc_oBusca) = "O"
1249:                     IF !loc_oBusca.this_lAchouRegistro
1250:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1251:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1252:                         loc_oBusca.Show()
1253:                     ENDIF
1254:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1255:                         SELECT cursor_4c_BuscaCoco
1256:                         loc_cCocosOk = ALLTRIM(Cods)
1257:                         loc_cDescsOk = ALLTRIM(Descs)
1258:                     ELSE
1259:                         loc_cCocosOk = ""
1260:                         loc_cDescsOk = ""
1261:                     ENDIF
1262:                     loc_oBusca.Release()
1263:                 ENDIF
1264:             ENDIF
1265: 
1266:             *-- Verificar duplicidade de cocos no cursor local
1267:             SELECT cursor_4c_OcoLocal
1268:             loc_nPonteiro  = RECNO()
1269:             loc_lDuplicado = .F.
1270: 
1271:             IF !EMPTY(loc_cCocosOk)
1272:                 SET ORDER TO Cocos
1273:                 IF SEEK(PADR(loc_cCocosOk, 2))
1274:                     IF RECNO() != loc_nPonteiro
1275:                         loc_lDuplicado = .T.
1276:                     ENDIF
1277:                 ENDIF
1278:                 SET ORDER TO
1279:                 GO loc_nPonteiro
1280:             ENDIF
1281: 
1282:             IF loc_lDuplicado

*-- Linhas 1325 a 1343:
1325:         ENDIF
1326: 
1327:         TRY
1328:             SELECT cursor_4c_OcoLocal
1329:             APPEND BLANK
1330:             REPLACE Grupos WITH loc_cGrupos
1331:             REPLACE Contas WITH loc_cContas
1332:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1333:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1334:         CATCH TO loException
1335:             MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1336:         ENDTRY
1337:     ENDPROC
1338: 
1339:     *--------------------------------------------------------------------------
1340:     * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
1341:     * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
1342:     *--------------------------------------------------------------------------
1343:     PROCEDURE BtnExcluirOcoClick()

*-- Linhas 1364 a 1383:
1364:         ENDIF
1365: 
1366:         TRY
1367:             SELECT cursor_4c_OcoLocal
1368:             DELETE
1369:             GO BOTTOM
1370:             IF EOF()
1371:                 APPEND BLANK
1372:                 REPLACE Grupos WITH loc_cGrupos
1373:                 REPLACE Contas WITH loc_cContas
1374:             ENDIF
1375:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1376:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1377:         CATCH TO loException
1378:             MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1379:         ENDTRY
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup

*-- Linhas 1422 a 1440:
1422:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1423:                 loc_oBusca.Show()
1424:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1425:                     SELECT cursor_4c_BuscaGrupo
1426:                     loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1427:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1428:                 ENDIF
1429:                 loc_oBusca.Release()
1430:             ENDIF
1431:         CATCH TO loException
1432:             MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
1433:         ENDTRY
1434: 
1435:         IF USED("cursor_4c_BuscaGrupo")
1436:             USE IN cursor_4c_BuscaGrupo
1437:         ENDIF
1438:     ENDPROC
1439: 
1440:     *--------------------------------------------------------------------------

*-- Linhas 1480 a 1498:
1480:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1481:                 loc_oBusca.Show()
1482:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1483:                     SELECT cursor_4c_BuscaConta
1484:                     loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1485:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1486:                 ENDIF
1487:                 loc_oBusca.Release()
1488:             ENDIF
1489:         CATCH TO loException
1490:             MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
1491:         ENDTRY
1492: 
1493:         IF USED("cursor_4c_BuscaConta")
1494:             USE IN cursor_4c_BuscaConta
1495:         ENDIF
1496:     ENDPROC
1497: 
1498:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SIGPRLNCBO.prg):
*==============================================================================
* SIGPRLNCBO.prg - Business Object para Lancamentos de Conta Corrente
* Tabela: SigClLan (grupos, contas, cocos, cidchaves, grucontas)
* Auxiliar: SIGCCCCO (cods, descs) - descricoes de ocorrencias
*==============================================================================
DEFINE CLASS SIGPRLNCBO AS BusinessBase

    *-- Campos de SigClLan
    this_cGrupos    = ""    && char(10) - Grupo da conta corrente
    this_cContas    = ""    && char(10) - Conta corrente
    this_cCocos     = ""    && char(2)  - Codigo da ocorrencia
    this_cCidChaves = ""    && char(20) - Chave primaria (gerada por fUniqueIds)
    this_cGruContas = ""    && char(20) - Concatenacao grupos+contas (indice)

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
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor existente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cCocos     = TratarNulo(cocos,     "C")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cGruContas = TratarNulo(grucontas, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista todos os registros agrupados de SigClLan
    * Retorna cursor cursor_4c_Dados com grupos, contas e uma ocorrencia por linha
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT a.grupos, a.contas, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " ORDER BY a.grupos, a.contas"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOcorrencias - Busca ocorrencias para um grupo+conta especifico
    * par_cGruContas = grupos(10) + contas(10) concatenados
    * Retorna cursor cursor_4c_Ocorrencias
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
                       " FROM SigClLan a LEFT JOIN SIGCCCCO b ON b.cods = a.cocos" + ;
                       " WHERE a.grucontas = " + EscaparSQL(par_cGruContas) + ;
                       " ORDER BY a.cocos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorrencias")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.BuscarOcorrencias: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoOcorrencia - Busca descricao de uma ocorrencia pelo codigo
    * Retorna string com descricao ou vazio se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoOcorrencia(par_cCodOco)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF USED("cursor_4c_DescOco")
                USE IN cursor_4c_DescOco
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SIGCCCCO" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodOco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescOco")

            IF loc_nResultado >= 0 AND USED("cursor_4c_DescOco") AND RECCOUNT("cursor_4c_DescOco") > 0
                SELECT cursor_4c_DescOco
                loc_cDescricao = ALLTRIM(descs)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarDescricaoOcorrencia: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescOco")
            USE IN cursor_4c_DescOco
        ENDIF

        RETURN loc_cDescricao
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

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigClLan (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves  = ALLTRIM(fUniqueIds())
            THIS.this_cGruContas  = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                                    PADR(ALLTRIM(THIS.this_cContas), 10)

            loc_cSQL = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves)                    + ", " + ;
                       EscaparSQL(THIS.this_cGruContas)                    + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigClLan (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruContas = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                                   PADR(ALLTRIM(THIS.this_cContas), 10)

            loc_cSQL = "UPDATE SigClLan SET" + ;
                       " grupos    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10)) + ;
                       ", contas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10)) + ;
                       ", cocos    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))   + ;
                       ", grucontas= " + EscaparSQL(THIS.this_cGruContas)                 + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigClLan (PROTECTED - chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirPorGruContas - Remove TODOS os lancamentos de um grupo+conta
    * Usado ao salvar conjunto de ocorrencias (limpa e re-insere)
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
                MsgErro("Erro ao excluir lan" + CHR(231) + "amentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.ExcluirPorGruContas: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarOcorrencias - Salva lista de ocorrencias do cursor local para SQL Server
    * par_cGrupos    = codigo do grupo (char 10)
    * par_cContas    = codigo da conta (char 10)
    * par_cCursorOco = nome do cursor VFP com a lista de ocorrencias (campo cocos)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarOcorrencias(par_cGrupos, par_cContas, par_cCursorOco)
        LOCAL loc_cGruContas, loc_lSucesso, loc_cCocos, loc_lAbortar
        LOCAL loc_cSQLIns, loc_nResIns
        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            loc_cGruContas = PADR(ALLTRIM(par_cGrupos), 10) + PADR(ALLTRIM(par_cContas), 10)

            IF !THIS.ExcluirPorGruContas(loc_cGruContas)
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                IF !USED(par_cCursorOco) OR RECCOUNT(par_cCursorOco) = 0
                    loc_lSucesso = .T.
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT (par_cCursorOco)
                GO TOP

                DO WHILE !EOF() AND !loc_lAbortar
                    SELECT (par_cCursorOco)
                    loc_cCocos = ALLTRIM(cocos)

                    IF !EMPTY(loc_cCocos)
                        THIS.this_cGrupos    = par_cGrupos
                        THIS.this_cContas    = par_cContas
                        THIS.this_cCocos     = loc_cCocos
                        THIS.this_cGruContas = loc_cGruContas
                        THIS.this_cCidChaves = ALLTRIM(fUniqueIds())

                        loc_cSQLIns = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                                      EscaparSQL(THIS.this_cCidChaves)                    + ", " + ;
                                      EscaparSQL(THIS.this_cGruContas)                    + ;
                                      ")"

                        loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)

                        IF loc_nResIns < 0
                            MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia '" + loc_cCocos + "': " + CapturarErroSQL(), "Erro SQL")
                            loc_lAbortar = .T.
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
            MsgErro("Erro em SIGPRLNCBO.SalvarOcorrencias: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

