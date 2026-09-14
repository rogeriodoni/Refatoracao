# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-SQL] Campo 'Locals' usado em ControlSource de cursor_4c_Localizacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Descricaos' usado em ControlSource de cursor_4c_Localizacoes mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SETORES, DESCRS, LOCALS, LCLOCALS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SETORES, DESCRS, LOCALS, LCLOCALS

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
  ControlSource = "crSigCdSet.Setores"
  ControlSource = "crSigCdSet.Descrs"
	Select crSigCdSei
	.Column1.ControlSource = 'crSigCdSei.Locals'
	.Column2.ControlSource = 'crSigCdSei.Descricaos'
lcQrySetor = [Select * From SigCdSet]
lcQrySetoI = [Select *, Space(20) as Descricaos From SigCdSei Where Setores = ?pKey]
Select crSigCdSet
Select crSigCdSet
	Insert Into crSigCdSei (Setores, cIdChaves) Values (crSigCdSet.Setores, fUniqueIds())
Select crSigCdSet
Delete From crSigCdSei Where Empty(Locals)
	Select * ;
	  From crSigCdSei ;
	Select crSigCdSei
	Delete From crSigCdSei
If Not ThisForm.poDataMgr.Update('crSigCdSei')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdSei)')
Select crSigCdSet
Select CrSigCdSei
	Select Count(1) As Qt From crSigCdSei ;
		lcSql = [Select Locals,Setores From SigCdSei Where Locals = ']+lcLocals+[' And Setores <> ']+lcSetors+[']
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalSetoI') < 1
		Select * ;
		  From crSigCdSei ;
			Insert Into crSigCdSei (Setores, cIdChaves) Values (crSigCdSet.Setores, fUniqueIds())
		Select CrSigCdSei
Select CrSigCdSei
	Delete In crSigCdSei
	Select * ;
	  From crSigCdSei ;
		Insert Into crSigCdSei (Setores, cIdChaves) Values (crSigCdSet.Setores, fUniqueIds())

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSET.prg) - TRECHOS RELEVANTES PARA PASS SQL (1413 linhas total):

*-- Linhas 347 a 365:
347:             .HighlightBackColor = RGB(255, 255, 255)
348:             .HighlightForeColor = RGB(15, 41, 104)
349:             .HighlightStyle     = 2
350:             .DeleteMark         = .F.
351:             .RecordMark         = .F.
352:             .RowHeight          = 16
353:             .ScrollBars         = 2
354:             .GridLines          = 3
355:             .ReadOnly           = .T.
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 
362:     *===========================================================================
363:     * ConfigurarPaginaDados - Configura Page2 (Dados) - FASE 5/8 (primeira metade)
364:     * Controles: cnt_4c_Salva, lbl_4c_Setor, txt_4c_Setores, lbl_4c_Descricao
365:     * Demais controles (txt_4c_Descrs, lbl_4c_Localizacoes, grd_4c_Localizacoes,

*-- Linhas 533 a 551:
533:             .HighlightBackColor = RGB(255, 255, 255)
534:             .HighlightForeColor = RGB(15, 41, 104)
535:             .HighlightStyle     = 2
536:             .DeleteMark         = .F.
537:             .RecordMark         = .F.
538:             .RowHeight          = 16
539:             .ScrollBars         = 2
540:             .GridLines          = 3
541:             .ReadOnly           = .T.
542:             .Visible            = .T.
543:         ENDWITH
544: 
545:         WITH loc_oPagina.grd_4c_Localizacoes.Column1
546:             .Width             = 80
547:             .Movable           = .F.
548:             .Resizable         = .F.
549:             .Header1.Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
550:             .Header1.Alignment = 2
551:         ENDWITH

*-- Linhas 608 a 628:
608:                     loc_oGrid.ColumnCount = 3
609:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
610:                     WITH loc_oGrid
611:                         .Column1.ControlSource = "cursor_4c_Dados.Setores"
612:                         .Column1.Width         = 100
613:                         .Column2.ControlSource = "cursor_4c_Dados.Descrs"
614:                         .Column2.Width         = 780
615:                     ENDWITH
616: 
617:                     *-- Reconfigurar headers apos RecordSource (resetados pelo auto-bind)
618:                     loc_oGrid.Column1.Header1.Caption = "Setor"
619:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
620: 
621:                     THIS.FormatarGridLista(loc_oGrid)
622:                     loc_lResultado = .T.
623:                 ENDIF
624:             ENDIF
625:         CATCH TO loException
626:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
627:                 "FormSET.CarregarLista")
628:             loc_lResultado = .F.

*-- Linhas 684 a 729:
684:         *-- Configurar grid apos LimparCampos (cabecalhos resetados pelo auto-bind)
685:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
686:         IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
687:             loc_oGrid = loc_oPg2.grd_4c_Localizacoes
688:             loc_oGrid.ColumnCount = 3
689:             loc_oGrid.RecordSource = "cursor_4c_Localizacoes"
690:             WITH loc_oGrid
691:                 .Column1.ControlSource = "cursor_4c_Localizacoes.Locals"
692:                 .Column2.ControlSource = "cursor_4c_Localizacoes.Descricaos"
693:             ENDWITH
694:             loc_oGrid.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
695:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
696:             loc_oGrid.Refresh()
697:         ENDIF
698: 
699:         THIS.AlternarPagina(2)
700:     ENDPROC
701: 
702:     *===========================================================================
703:     * BtnVisualizarClick - Visualizar setor selecionado (somente leitura)
704:     *===========================================================================
705:     PROCEDURE BtnVisualizarClick()
706:         LOCAL loc_cSetores, loc_lCarregou
707:         loc_lCarregou = .F.
708: 
709:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
710:             MsgAviso("Nenhum registro selecionado.", "")
711:             RETURN
712:         ENDIF
713: 
714:         SELECT cursor_4c_Dados
715:         IF EOF("cursor_4c_Dados")
716:             MsgAviso("Nenhum registro selecionado.", "")
717:             RETURN
718:         ENDIF
719: 
720:         loc_cSetores = ALLTRIM(cursor_4c_Dados.Setores)
721: 
722:         TRY
723:             loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSetores)
724:         CATCH TO loException
725:             MostrarErro("Erro ao carregar setor:" + CHR(13) + loException.Message, ;
726:                 "FormSET.BtnVisualizarClick")
727:         ENDTRY
728: 
729:         IF loc_lCarregou

*-- Linhas 747 a 787:
747:             RETURN
748:         ENDIF
749: 
750:         SELECT cursor_4c_Dados
751:         IF EOF("cursor_4c_Dados")
752:             MsgAviso("Nenhum registro selecionado.", "")
753:             RETURN
754:         ENDIF
755: 
756:         loc_cSetores = ALLTRIM(cursor_4c_Dados.Setores)
757: 
758:         TRY
759:             loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSetores)
760:         CATCH TO loException
761:             MostrarErro("Erro ao carregar setor:" + CHR(13) + loException.Message, ;
762:                 "FormSET.BtnAlterarClick")
763:         ENDTRY
764: 
765:         IF loc_lCarregou
766:             THIS.this_oBusinessObject.EditarRegistro()
767:             THIS.BOParaForm()
768: 
769:             *-- Adicionar linha em branco ao final para nova entrada no modo ALTERAR
770:             IF USED("cursor_4c_Localizacoes")
771:                 SELECT cursor_4c_Localizacoes
772:                 INSERT INTO cursor_4c_Localizacoes (Setores, Locals, Descricaos) VALUES ("", "", "")
773:                 loc_oPg2Alt = THIS.pgf_4c_Paginas.Page2
774:                 IF PEMSTATUS(loc_oPg2Alt, "grd_4c_Localizacoes", 5)
775:                     loc_oPg2Alt.grd_4c_Localizacoes.Refresh()
776:                 ENDIF
777:             ENDIF
778: 
779:             THIS.this_cModoAtual = "ALTERAR"
780:             THIS.HabilitarCampos(.T.)
781:             THIS.AjustarBotoesPorModo()
782:             THIS.AlternarPagina(2)
783:         ENDIF
784:     ENDPROC
785: 
786:     *===========================================================================
787:     * BtnExcluirClick - Excluir setor selecionado com confirmacao

*-- Linhas 796 a 814:
796:             RETURN
797:         ENDIF
798: 
799:         SELECT cursor_4c_Dados
800:         IF EOF("cursor_4c_Dados")
801:             MsgAviso("Nenhum registro selecionado.", "")
802:             RETURN
803:         ENDIF
804: 
805:         loc_cSetores = ALLTRIM(cursor_4c_Dados.Setores)
806: 
807:         TRY
808:             loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSetores)
809:         CATCH TO loException
810:             MostrarErro("Erro ao carregar setor:" + CHR(13) + loException.Message, ;
811:                 "FormSET.BtnExcluirClick")
812:         ENDTRY
813: 
814:         IF loc_lCarregou

*-- Linhas 877 a 898:
877:             ENDIF
878:             RETURN
879:         ENDIF
880: 
881:         *-- Validar pelo menos uma localizacao com codigo preenchido
882:         IF USED("cursor_4c_Localizacoes")
883:             SELECT cursor_4c_Localizacoes
884:             SCAN
885:                 IF !EMPTY(ALLTRIM(Locals))
886:                     loc_lTemLocalizacao = .T.
887:                     EXIT
888:                 ENDIF
889:             ENDSCAN
890:         ENDIF
891: 
892:         IF !loc_lTemLocalizacao
893:             MsgAviso("N" + CHR(227) + "o Foram Cadastradas Localiza" + CHR(231) + CHR(245) + "es!", "")
894:             IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
895:                 loc_oPg2.grd_4c_Localizacoes.SetFocus
896:             ENDIF
897:             RETURN
898:         ENDIF

*-- Linhas 912 a 932:
912:             THIS.FormParaBO()
913: 
914:             IF THIS.this_oBusinessObject.Salvar()
915:                 THIS.this_oBusinessObject.SalvarLocalizacoes(;
916:                     ALLTRIM(THIS.this_oBusinessObject.this_cSetores), ;
917:                     "cursor_4c_Localizacoes")
918:                 MsgInfo("Setor salvo com sucesso!")
919:                 loc_lSucesso = .T.
920:             ENDIF
921:         CATCH TO loException
922:             MostrarErro("Erro ao salvar Setor:" + CHR(13) + loException.Message, ;
923:                 "FormSET.BtnSalvarClick")
924:         ENDTRY
925: 
926:         IF loc_lSucesso
927:             THIS.AlternarPagina(1)
928:         ENDIF
929:     ENDPROC
930: 
931:     *===========================================================================
932:     * BtnCancelarClick - Cancelar edicao e retornar a lista

*-- Linhas 962 a 985:
962:         *-- Carrega localizacoes no grid (SigCdSei enriquecido com SigPrLcl)
963:         THIS.this_oBusinessObject.CarregarLocalizacoes(THIS.this_oBusinessObject.this_cSetores)
964: 
965:         IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
966:             loc_oPg2.grd_4c_Localizacoes.ColumnCount = 3
967:             loc_oPg2.grd_4c_Localizacoes.RecordSource = "cursor_4c_Localizacoes"
968:             WITH loc_oPg2.grd_4c_Localizacoes
969:                 .Column1.ControlSource = "cursor_4c_Localizacoes.Locals"
970:                 .Column2.ControlSource = "cursor_4c_Localizacoes.Descricaos"
971:             ENDWITH
972:             loc_oPg2.grd_4c_Localizacoes.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
973:             loc_oPg2.grd_4c_Localizacoes.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
974:             loc_oPg2.grd_4c_Localizacoes.Refresh()
975:         ENDIF
976:     ENDPROC
977: 
978:     *===========================================================================
979:     * FormParaBO - Transfere valores dos controles do formulario para o BO
980:     *===========================================================================
981:     PROTECTED PROCEDURE FormParaBO()
982:         LOCAL loc_oPg2
983:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
984: 
985:         IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)

*-- Linhas 1039 a 1069:
1039:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
1040:             loc_oPg2.txt_4c_Descrs.Value = ""
1041:         ENDIF
1042: 
1043:         *-- Preparar cursor de localizacoes para edicao (cria se nao existe)
1044:         IF USED("cursor_4c_Localizacoes")
1045:             SELECT cursor_4c_Localizacoes
1046:             ZAP
1047:         ELSE
1048:             SET NULL ON
1049:             CREATE CURSOR cursor_4c_Localizacoes (Setores C(10), Locals C(10), Descricaos C(20))
1050:             SET NULL OFF
1051:         ENDIF
1052: 
1053:         *-- Linha em branco inicial para permitir nova entrada no grid
1054:         INSERT INTO cursor_4c_Localizacoes (Setores, Locals, Descricaos) VALUES ("", "", "")
1055:     ENDPROC
1056: 
1057:     *===========================================================================
1058:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1059:     * Itera Pages de PageFrames e Controls de Containers
1060:     *===========================================================================
1061:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1062:         LOCAL loc_nI, loc_oObjeto, loc_nP
1063: 
1064:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1065:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1066: 
1067:             IF VARTYPE(loc_oObjeto) = "O"
1068:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1069:                     loc_oObjeto.Visible = .T.

*-- Linhas 1111 a 1173:
1111:         ENDIF
1112:     ENDPROC
1113: 
1114:     *===========================================================================
1115:     * AbrirLookupLocalizacao - Lookup FormBuscaAuxiliar para SigPrLcl
1116:     * Preenche Locals + Descricaos na linha atual do cursor_4c_Localizacoes
1117:     *===========================================================================
1118:     PROCEDURE AbrirLookupLocalizacao()
1119:         LOCAL loc_oPg2, loc_oGrid, loc_cLocAtual, loc_oFA
1120:         LOCAL loc_cCodigo, loc_cDescricao, loc_nRecAtual, loc_lDuplic, loc_cSetorAtual
1121:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1122:         loc_cLocAtual = ""
1123:         loc_lDuplic   = .F.
1124: 
1125:         IF !PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
1126:             RETURN
1127:         ENDIF
1128: 
1129:         loc_oGrid = loc_oPg2.grd_4c_Localizacoes
1130: 
1131:         IF !USED("cursor_4c_Localizacoes") OR EOF("cursor_4c_Localizacoes")
1132:             RETURN
1133:         ENDIF
1134: 
1135:         SELECT cursor_4c_Localizacoes
1136:         loc_nRecAtual = RECNO()
1137:         loc_cLocAtual = ALLTRIM(Locals)
1138: 
1139:         TRY
1140:             loc_oFA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1141:                 "SigPrLcl", "cursor_4c_BuscaLocal", "Codigos", loc_cLocAtual, ;
1142:                 "Localiza" + CHR(231) + CHR(227) + "o")
1143: 
1144:             IF VARTYPE(loc_oFA) = "O"
1145:                 IF !loc_oFA.this_lAchouRegistro
1146:                     loc_oFA.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1147:                     loc_oFA.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1148:                     loc_oFA.Show()
1149:                 ENDIF
1150: 
1151:                 IF loc_oFA.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
1152:                     SELECT cursor_4c_BuscaLocal
1153:                     IF !EOF()
1154:                         loc_cCodigo    = ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1155:                         loc_cDescricao = ALLTRIM(cursor_4c_BuscaLocal.Descricaos)
1156: 
1157:                         *-- Verificar duplicata (outra linha com mesmo codigo)
1158:                         SELECT cursor_4c_Localizacoes
1159:                         GO loc_nRecAtual
1160:                         SCAN
1161:                             IF RECNO() != loc_nRecAtual AND ALLTRIM(Locals) = loc_cCodigo
1162:                                 loc_lDuplic = .T.
1163:                                 EXIT
1164:                             ENDIF
1165:                         ENDSCAN
1166:                         GO loc_nRecAtual
1167: 
1168:                         IF loc_lDuplic
1169:                             MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
1170:                                 CHR(225) + " foi adicionada!", "")
1171:                         ELSE
1172:                             *-- Verificar se pertence a outro setor
1173:                             loc_cSetorAtual = ALLTRIM(THIS.this_oBusinessObject.this_cSetores)

*-- Linhas 1179 a 1199:
1179:                                 THIS.this_oBusinessObject.ValidarLocalizacaoOutroSetor(;
1180:                                     loc_cCodigo, loc_cSetorAtual)
1181:                                 MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
1182:                                     CHR(225) + " pertence a outro Setor!", "")
1183:                             ELSE
1184:                                 SELECT cursor_4c_Localizacoes
1185:                                 GO loc_nRecAtual
1186:                                 REPLACE Locals     WITH loc_cCodigo
1187:                                 REPLACE Descricaos WITH loc_cDescricao
1188:                                 THIS.GarantirLinhaEmBranco()
1189:                                 loc_oGrid.Refresh()
1190:                             ENDIF
1191:                         ENDIF
1192:                     ENDIF
1193:                 ENDIF
1194: 
1195:                 loc_oFA = .NULL.
1196:             ENDIF
1197:         CATCH TO loException
1198:             MostrarErro("Erro ao abrir lookup de localiza" + CHR(231) + CHR(245) + "es:" + ;
1199:                 CHR(13) + loException.Message, "FormSET.AbrirLookupLocalizacao")

*-- Linhas 1214 a 1269:
1214: 
1215:         IF !PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
1216:             RETURN
1217:         ENDIF
1218: 
1219:         IF !USED("cursor_4c_Localizacoes") OR EOF("cursor_4c_Localizacoes")
1220:             RETURN
1221:         ENDIF
1222: 
1223:         SELECT cursor_4c_Localizacoes
1224:         loc_nRecAtual = RECNO()
1225:         loc_cLocais   = ALLTRIM(Locals)
1226: 
1227:         IF EMPTY(loc_cLocais)
1228:             THIS.GarantirLinhaEmBranco()
1229:             RETURN
1230:         ENDIF
1231: 
1232:         TRY
1233:             loc_lAchou = THIS.this_oBusinessObject.BuscarLocalizacao(loc_cLocais)
1234:         CATCH TO loException
1235:             MostrarErro("Erro ao validar localiza" + CHR(231) + CHR(227) + "o:" + ;
1236:                 CHR(13) + loException.Message, "FormSET.ValidarLocalizacaoGrid")
1237:             RETURN
1238:         ENDTRY
1239: 
1240:         IF !loc_lAchou
1241:             SELECT cursor_4c_Localizacoes
1242:             GO loc_nRecAtual
1243:             REPLACE Locals     WITH ""
1244:             REPLACE Descricaos WITH ""
1245:             THIS.AbrirLookupLocalizacao()
1246:             RETURN
1247:         ENDIF
1248: 
1249:         IF USED("cursor_4c_BuscaLocal") AND !EOF("cursor_4c_BuscaLocal")
1250:             SELECT cursor_4c_BuscaLocal
1251:             loc_cDesc = ALLTRIM(cursor_4c_BuscaLocal.Descricaos)
1252: 
1253:             *-- Verificar duplicata
1254:             SELECT cursor_4c_Localizacoes
1255:             GO loc_nRecAtual
1256:             SCAN
1257:                 IF RECNO() != loc_nRecAtual AND ALLTRIM(Locals) = loc_cLocais
1258:                     loc_lDuplic = .T.
1259:                     EXIT
1260:                 ENDIF
1261:             ENDSCAN
1262:             GO loc_nRecAtual
1263: 
1264:             IF loc_lDuplic
1265:                 MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
1266:                     CHR(225) + " foi adicionada!", "")
1267:                 REPLACE Locals     WITH ""
1268:                 REPLACE Descricaos WITH ""
1269:             ELSE

*-- Linhas 1276 a 1346:
1276:                 IF !EMPTY(loc_cSetorAtual) AND ;
1277:                     THIS.this_oBusinessObject.ValidarLocalizacaoOutroSetor(;
1278:                         loc_cLocais, loc_cSetorAtual)
1279:                     MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
1280:                         CHR(225) + " pertence a outro Setor!", "")
1281:                     SELECT cursor_4c_Localizacoes
1282:                     GO loc_nRecAtual
1283:                     REPLACE Locals     WITH ""
1284:                     REPLACE Descricaos WITH ""
1285:                 ELSE
1286:                     SELECT cursor_4c_Localizacoes
1287:                     GO loc_nRecAtual
1288:                     REPLACE Descricaos WITH loc_cDesc
1289:                 ENDIF
1290:             ENDIF
1291:         ENDIF
1292: 
1293:         THIS.GarantirLinhaEmBranco()
1294:         IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
1295:             loc_oPg2.grd_4c_Localizacoes.Refresh()
1296:         ENDIF
1297:     ENDPROC
1298: 
1299:     *===========================================================================
1300:     * GarantirLinhaEmBranco - Garante linha em branco ao final do cursor
1301:     * Permite ao usuario digitar nova localizacao apos preencher a anterior
1302:     *===========================================================================
1303:     PROTECTED PROCEDURE GarantirLinhaEmBranco()
1304:         IF !USED("cursor_4c_Localizacoes")
1305:             RETURN
1306:         ENDIF
1307: 
1308:         SELECT cursor_4c_Localizacoes
1309:         GO BOTTOM
1310:         IF !EMPTY(ALLTRIM(Locals))
1311:             INSERT INTO cursor_4c_Localizacoes (Setores, Locals, Descricaos) VALUES ("", "", "")
1312:         ENDIF
1313:     ENDPROC
1314: 
1315:     *===========================================================================
1316:     * BtnApagarClick - Apaga localizacao da linha atual (limpa Locals/Descricaos)
1317:     * SalvarLocalizacoes ignora linhas com Locals vazio
1318:     *===========================================================================
1319:     PROCEDURE BtnApagarClick()
1320:         LOCAL loc_oPg2
1321:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1322: 
1323:         IF !PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
1324:             RETURN
1325:         ENDIF
1326: 
1327:         IF !USED("cursor_4c_Localizacoes") OR EOF("cursor_4c_Localizacoes")
1328:             RETURN
1329:         ENDIF
1330: 
1331:         SELECT cursor_4c_Localizacoes
1332:         IF EMPTY(ALLTRIM(Locals))
1333:             RETURN
1334:         ENDIF
1335: 
1336:         REPLACE Locals     WITH ""
1337:         REPLACE Descricaos WITH ""
1338: 
1339:         THIS.GarantirLinhaEmBranco()
1340:         loc_oPg2.grd_4c_Localizacoes.Refresh()
1341:     ENDPROC
1342: 
1343:     *===========================================================================
1344:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cModoAtual
1345:     * LISTA: CRUD habilitados | INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR: CRUD desabilitados
1346:     *===========================================================================

*-- Linhas 1393 a 1413:
1393: 
1394:         IF USED("cursor_4c_Dados")
1395:             USE IN cursor_4c_Dados
1396:         ENDIF
1397: 
1398:         IF USED("cursor_4c_Localizacoes")
1399:             USE IN cursor_4c_Localizacoes
1400:         ENDIF
1401: 
1402:         IF USED("cursor_4c_BuscaLocal")
1403:             USE IN cursor_4c_BuscaLocal
1404:         ENDIF
1405: 
1406:         IF USED("cursor_4c_VldLcl")
1407:             USE IN cursor_4c_VldLcl
1408:         ENDIF
1409: 
1410:         DODEFAULT()
1411:     ENDPROC
1412: 
1413: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SETBO.prg):
*==============================================================================
* SETBO.prg
*
* Business Object para Cadastro de Setores
* Tabela principal: SigCdSet
* Tabela filha: SigCdSei (Localizacoes do Setor)
* Lookup: SigPrLcl (Localizacoes - codigo/descricao)
* Herda de: BusinessBase
*
* Colunas SigCdSet:
*   setores   char(10)  PK - Codigo do Setor
*   descrs    char(40)  Descricao do Setor
*
* Colunas SigCdSei:
*   cidchaves char(20)  PK - Chave unica
*   setores   char(10)  FK -> SigCdSet.setores
*   locals    char(10)  Codigo de Localizacao (FK -> SigPrLcl.codigos)
*==============================================================================

DEFINE CLASS SETBO AS BusinessBase

    *-- Propriedades da entidade principal (SigCdSet)
    this_cSetores = ""   && setores  char(10)  PK - Codigo do Setor
    this_cDescrs  = ""   && descrs   char(40)  Descricao do Setor

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSet"
            THIS.this_cCampoChave = "Setores"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSetores)
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cSetores        = ""
        THIS.this_cDescrs         = ""
        THIS.this_lNovoRegistro   = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSetores = TratarNulo(Setores, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT em SigCdSet para preencher cursor_4c_Dados
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " ORDER BY Setores"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Setores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo do setor
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoes - Carrega localizacoes do setor em cursor
    *   Enriquece Locals com Descricaos de SigPrLcl
    *   Resultado: cursor_4c_Localizacoes (Setores, Locals, Descricaos)
    *==========================================================================
    FUNCTION CarregarLocalizacoes(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Localizacoes")
                USE IN cursor_4c_Localizacoes
            ENDIF

            loc_cSQL = "SELECT a.Setores, a.Locals," + ;
                       " ISNULL(b.Descricaos, SPACE(20)) AS Descricaos" + ;
                       " FROM SigCdSei a" + ;
                       " LEFT JOIN SigPrLcl b ON b.Codigos = a.Locals" + ;
                       " WHERE a.Setores = " + EscaparSQL(ALLTRIM(par_cSetores)) + ;
                       " ORDER BY a.Locals"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Localizacoes")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Localizacoes") AND RECCOUNT("cursor_4c_Localizacoes") >= 0
                    GO TOP IN cursor_4c_Localizacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar localizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoDuplicada - Verifica se Locals ja existe no setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoDuplicada(par_cLocals, par_cSetores, par_cIdChaveAtual)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF

            loc_cSQL = "SELECT COUNT(1) AS Qt" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals   = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores  = " + EscaparSQL(ALLTRIM(par_cSetores)) + ;
                       " AND   cidchaves <> " + EscaparSQL(ALLTRIM(par_cIdChaveAtual))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLocal")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLocal") > 0
                SELECT cursor_4c_VldLocal
                loc_lDuplicado = (Qt > 0)
            ENDIF

            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoDuplicada")
        ENDTRY
        RETURN loc_lDuplicado
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoOutroSetor - Verifica se Locals pertence a outro setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoOutroSetor(par_cLocals, par_cSetoresAtual)
        LOCAL loc_cSQL, loc_nResult, loc_cSetorExistente
        loc_cSetorExistente = ""
        TRY
            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores <> " + EscaparSQL(ALLTRIM(par_cSetoresAtual))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSetor")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSetor") > 0
                SELECT cursor_4c_VldSetor
                loc_cSetorExistente = ALLTRIM(Setores)
            ENDIF

            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoOutroSetor")
        ENDTRY
        RETURN loc_cSetorExistente
    ENDFUNC

    *==========================================================================
    * BuscarLocalizacao - Lookup em SigPrLcl pelo codigo
    *   Resultado: cursor_4c_BuscaLocal (Codigos, Descricaos)
    *==========================================================================
    FUNCTION BuscarLocalizacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos"
            ELSE
                loc_cSQL = "SELECT Codigos, Descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " OR Codigos LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%")
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaLocal")
                TABLEREVERT(.T., "cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLocal")

            IF loc_nResult >= 0
                IF USED("cursor_4c_BuscaLocal") AND RECCOUNT("cursor_4c_BuscaLocal") >= 0
                    GO TOP IN cursor_4c_BuscaLocal
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.BuscarLocalizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarSetorExistente - Verifica se codigo de setor ja existe
    *==========================================================================
    FUNCTION VerificarSetorExistente(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.
        TRY
            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSet")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSet") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.VerificarSetorExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * Inserir (PROTECTED) - INSERT em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdSet (Setores, Descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar (PROTECTED) - UPDATE em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdSet SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(THIS.this_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao (PROTECTED) - DELETE em SigCdSet e SigCdSei
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdSet WHERE Setores = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cSetores))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(245) + "es do Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarLocalizacoes - Sincroniza SigCdSei com cursor de localizacoes
    *   par_cSetores    - Codigo do setor
    *   par_cCursorSei  - Nome do cursor com registros a salvar (Locals, Descricaos)
    *==========================================================================
    FUNCTION SalvarLocalizacoes(par_cSetores, par_cCursorSei)
        LOCAL loc_cSQL, loc_lSucesso, loc_cLocals, loc_cIdChave
        loc_lSucesso = .F.
        TRY
            *-- Delete all existing localizations for the setor (replace-all approach)
            *-- This ensures removed/changed rows are cleaned from SigCdSei
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Insert all non-empty locals from cursor
            IF USED(par_cCursorSei) AND RECCOUNT(par_cCursorSei) > 0
                SELECT (par_cCursorSei)
                SCAN FOR !EMPTY(ALLTRIM(Locals))
                    loc_cLocals  = ALLTRIM(Locals)
                    loc_cIdChave = LOWER(SYS(2015)) + TRANSFORM(SECONDS(), "@L")
                    loc_cSQL = "INSERT INTO SigCdSei (cidchaves, Setores, Locals)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cIdChave) + ", " + ;
                               EscaparSQL(ALLTRIM(par_cSetores)) + ", " + ;
                               EscaparSQL(loc_cLocals) + ")"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.SalvarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

