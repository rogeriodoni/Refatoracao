# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 10910: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 11878: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 12007: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS GRID (12572 linhas total):

*-- Linhas 483 a 574:
483:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
484: 
485:         *----------------------------------------------------------------------
486:         *-- Criar cursor placeholder ANTES do grid (para RecordSource estavel)
487:         *-- Campos identicos ao que ProdutoBO.Buscar() cria
488:         *----------------------------------------------------------------------
489:         IF !USED("cursor_4c_Dados")
490:             SET NULL ON
491:             CREATE CURSOR cursor_4c_Dados (;
492:                 cpros    C(14), dpros  C(65), cgrus C(3), ;
493:                 sgrus    C(6),  reffs  C(40), ;
494:                 usuaalts C(20), situas N(1,0))
495:             SET NULL OFF
496:         ENDIF
497: 
498:         *----------------------------------------------------------------------
499:         *-- Grid principal da lista (Grade: Top=183, Left=5)
500:         *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
501:         *----------------------------------------------------------------------
502:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
503:         WITH loc_oPagina.grd_4c_Lista
504:             .Top         = 183
505:             .Left        = 5
506:             .Width       = 950
507:             .Height      = 389
508:             .ColumnCount = 7
509:             .Visible     = .T.
510:             .RecordMark   = .F.
511:             .DeleteMark   = .F.
512:         ENDWITH
513: 
514:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
515:         loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
516: 
517:         *-- ControlSources e larguras APOS RecordSource
518:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
519:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
522: 
523:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
524:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
525:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
527: 
528:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
529:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
530:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
532: 
533:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
534:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
535:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrp."
537: 
538:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
539:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
540:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
541:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
542: 
543:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
544:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
545:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
546:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
547: 
548:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
549:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
550:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
551:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
552: 
553:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
554:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
555: 
556:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
557:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
558:         WITH loc_oPagina.lbl_4c_Contagem
559:             .Caption   = "Produtos Selecionados : 0"
560:             .Top       = 575
561:             .Left      = 38
562:             .Width     = 200
563:             .Height    = 15
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .BackStyle = 0
567:             .ForeColor = RGB(90, 90, 90)
568:             .Visible   = .T.
569:         ENDWITH
570: 
571:         *-- Tornar controles visiveis (apenas prefixos validos)
572:         THIS.TornarControlesVisiveis(loc_oPagina)
573:     ENDPROC
574: 

*-- Linhas 740 a 795:
740:         *--         uni2(un cons), ord(ordem), matrizes(material alternativo)
741:         *----------------------------------------------------------------------
742:         IF !USED("cursor_4c_Compo")
743:             SET NULL ON
744:             CREATE CURSOR cursor_4c_Compo (;
745:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
746:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
747:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
748:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
749:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
750:                 cgrus    C(3),  moeds    C(5))
751:             SET NULL OFF
752:         ENDIF
753: 
754:         *----------------------------------------------------------------------
755:         *-- Cursor placeholder para grdsubcp (SigSubCp)
756:         *----------------------------------------------------------------------
757:         IF !USED("cursor_4c_SubCp")
758:             SET NULL ON
759:             CREATE CURSOR cursor_4c_SubCp (;
760:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
761:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
762:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
763:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
764:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
765:                 tamanhos C(20))
766:             SET NULL OFF
767:         ENDIF
768: 
769:         *----------------------------------------------------------------------
770:         *-- Cursor placeholder para GradeGRUPO (TotGrupo)
771:         *----------------------------------------------------------------------
772:         IF !USED("cursor_4c_Grupo")
773:             SET NULL ON
774:             CREATE CURSOR cursor_4c_Grupo (cgrus C(3), valgr N(12,4), moeds C(5))
775:             SET NULL OFF
776:         ENDIF
777: 
778:         *----------------------------------------------------------------------
779:         *-- Linha OBS da OF: Say4 + getObsOFs
780:         *-- Say4: "Obs. da OF :" (T:300 L:36 W:64)
781:         *-- getObsOFs: (T:297 L:99 W:850 H:21)
782:         *----------------------------------------------------------------------
783:         loc_oPg.AddObject("lbl_4c_ObsOF", "Label")
784:         WITH loc_oPg.lbl_4c_ObsOF
785:             .Caption   = "Obs. da OF :"
786:             .Top       = 300
787:             .Left      = 36
788:             .Width     = 64
789:             .Height    = 15
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .BackStyle = 0
793:             .ForeColor = RGB(90, 90, 90)
794:             .Visible   = .T.
795:         ENDWITH

*-- Linhas 879 a 1015:
879:         *-- Grid grdCompo (14 colunas) - Composicao do produto
880:         *-- Top:148 Left:6 Width:943 Height:147
881:         *----------------------------------------------------------------------
882:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
883:         WITH loc_oPg.grd_4c_Compo
884:             .Top         = 148
885:             .Left        = 6
886:             .Width       = 943
887:             .Height      = 147
888:             .ColumnCount = 14
889:             .FontName    = "Verdana"
890:             .FontSize    = 8
891:             .GridLines   = 3
892:             .GridLineWidth = 1
893:             .GridLineColor = RGB(238, 238, 238)
894:             .RecordMark  = .F.
895:             .DeleteMark  = .F.
896:             .AllowRowSizing = .F.
897:             .ReadOnly    = .F.
898:             .BackColor   = RGB(255, 255, 255)
899:             .ForeColor   = RGB(90, 90, 90)
900:             .HighlightBackColor = RGB(220, 230, 242)
901:             .HighlightForeColor = RGB(15, 41, 104)
902:             .HighlightStyle = 2
903:             .RowHeight   = 16
904:             .ScrollBars  = 2
905:             .Visible     = .T.
906:         ENDWITH
907: 
908:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
909:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
910: 
911:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
912:         WITH loc_oPg.grd_4c_Compo
913:             *-- Col1: Material (C14) W:80
914:             .Column1.Header1.Caption       = "Material"
915:             .Column1.Width                 = 80
916:             .Column1.ControlSource         = "cursor_4c_Compo.mats"
917:             .Column1.Alignment             = 0
918: 
919:             *-- Col2: Descricao (C65) W:200
920:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
921:             .Column2.Width                 = 200
922:             .Column2.ControlSource         = "cursor_4c_Compo.dcomps"
923:             .Column2.Alignment             = 0
924: 
925:             *-- Col3: Un (C5) W:35 - readonly
926:             .Column3.Header1.Caption       = "Un"
927:             .Column3.Width                 = 35
928:             .Column3.ControlSource         = "cursor_4c_Compo.unicompos"
929:             .Column3.ReadOnly              = .T.
930: 
931:             *-- Col4: Valor (N) W:65
932:             .Column4.Header1.Caption       = "Valor"
933:             .Column4.Width                 = 65
934:             .Column4.ControlSource         = "cursor_4c_Compo.pcompos"
935:             .Column4.Alignment             = 1
936: 
937:             *-- Col5: Qtde (N) W:60
938:             .Column5.Header1.Caption       = "Qtde."
939:             .Column5.Width                 = 60
940:             .Column5.ControlSource         = "cursor_4c_Compo.qtds"
941:             .Column5.Alignment             = 1
942: 
943:             *-- Col6: Total (N) W:65 - readonly (calculado)
944:             .Column6.Header1.Caption       = "Total"
945:             .Column6.Width                 = 65
946:             .Column6.ControlSource         = "cursor_4c_Compo.totals"
947:             .Column6.Alignment             = 1
948:             .Column6.ReadOnly              = .T.
949: 
950:             *-- Col7: Moe (C5) W:35
951:             .Column7.Header1.Caption       = "Moe"
952:             .Column7.Width                 = 35
953:             .Column7.ControlSource         = "cursor_4c_Compo.bloqueio"
954: 
955:             *-- Col8: Observacao (C40) W:100
956:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
957:             .Column8.Width                 = 100
958:             .Column8.ControlSource         = "cursor_4c_Compo.obscompos"
959:             .Column8.Alignment             = 0
960: 
961:             *-- Col9: E (C1) W:25
962:             .Column9.Header1.Caption       = "E"
963:             .Column9.Width                 = 25
964:             .Column9.ControlSource         = "cursor_4c_Compo.etiq"
965: 
966:             *-- Col10: Consumo (N) W:65
967:             .Column10.Header1.Caption      = "Consumo"
968:             .Column10.Width                = 65
969:             .Column10.ControlSource        = "cursor_4c_Compo.consumo"
970:             .Column10.Alignment            = 1
971: 
972:             *-- Col11: Qtde cons (N) W:60
973:             .Column11.Header1.Caption      = "Qtde."
974:             .Column11.Width                = 60
975:             .Column11.ControlSource        = "cursor_4c_Compo.qtd2"
976:             .Column11.Alignment            = 1
977: 
978:             *-- Col12: Un cons (C5) W:35 - readonly
979:             .Column12.Header1.Caption      = "Un"
980:             .Column12.Width                = 35
981:             .Column12.ControlSource        = "cursor_4c_Compo.uni2"
982:             .Column12.ReadOnly             = .T.
983: 
984:             *-- Col13: Ord (N) W:35
985:             .Column13.Header1.Caption      = "Ord"
986:             .Column13.Width                = 35
987:             .Column13.ControlSource        = "cursor_4c_Compo.ord"
988:             .Column13.Alignment            = 1
989: 
990:             *-- Col14: Material alt (C14) W:83
991:             .Column14.Header1.Caption      = "Material"
992:             .Column14.Width                = 83
993:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
994:         ENDWITH
995:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
996: 
997:         *----------------------------------------------------------------------
998:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
999:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
1000:         *----------------------------------------------------------------------
1001:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
1002:         WITH loc_oPg.cnt_4c_BotoesCompo
1003:             .Top         = 145
1004:             .Left        = 947
1005:             .Width       = 50
1006:             .Height      = 210
1007:             .BackStyle = 1
1008:             .BackColor = RGB(53, 53, 53)
1009:             .BorderWidth = 0
1010:             .Visible     = .T.
1011:         ENDWITH
1012: 
1013:         *-- Botao 1: Inserir componente
1014:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_InserirCompo", "CommandButton")
1015:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo

*-- Linhas 1106 a 1232:
1106:         *-- Grid grdsubcp (15 colunas) - Sub-componentes
1107:         *-- Top:348 Left:6 Width:943 Height:83
1108:         *----------------------------------------------------------------------
1109:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
1110:         WITH loc_oPg.grd_4c_SubCp
1111:             .Top         = 348
1112:             .Left        = 6
1113:             .Width       = 943
1114:             .Height      = 83
1115:             .ColumnCount = 15
1116:             .FontName    = "Verdana"
1117:             .FontSize    = 8
1118:             .GridLines   = 3
1119:             .GridLineWidth = 1
1120:             .GridLineColor = RGB(238, 238, 238)
1121:             .RecordMark  = .F.
1122:             .DeleteMark  = .F.
1123:             .AllowRowSizing = .F.
1124:             .ReadOnly    = .F.
1125:             .BackColor   = RGB(255, 255, 255)
1126:             .ForeColor   = RGB(90, 90, 90)
1127:             .HighlightBackColor = RGB(220, 230, 242)
1128:             .HighlightForeColor = RGB(15, 41, 104)
1129:             .HighlightStyle = 2
1130:             .RowHeight   = 16
1131:             .ScrollBars  = 2
1132:             .Visible     = .T.
1133:         ENDWITH
1134: 
1135:         *-- RecordSource FORA do WITH
1136:         loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
1137: 
1138:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1139:         WITH loc_oPg.grd_4c_SubCp
1140:             .Column1.Header1.Caption       = "Material"
1141:             .Column1.Width                 = 75
1142:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1143: 
1144:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
1145:             .Column2.Width                 = 175
1146:             .Column2.ControlSource         = "cursor_4c_SubCp.dcomps"
1147:             .Column2.Alignment             = 0
1148: 
1149:             .Column3.Header1.Caption       = "Un"
1150:             .Column3.Width                 = 30
1151:             .Column3.ControlSource         = "cursor_4c_SubCp.unicompos"
1152:             .Column3.ReadOnly              = .T.
1153: 
1154:             .Column4.Header1.Caption       = "Valor"
1155:             .Column4.Width                 = 60
1156:             .Column4.ControlSource         = "cursor_4c_SubCp.pcompos"
1157:             .Column4.Alignment             = 1
1158: 
1159:             .Column5.Header1.Caption       = "Qtde."
1160:             .Column5.Width                 = 55
1161:             .Column5.ControlSource         = "cursor_4c_SubCp.qtds"
1162:             .Column5.Alignment             = 1
1163: 
1164:             .Column6.Header1.Caption       = "Total"
1165:             .Column6.Width                 = 60
1166:             .Column6.ControlSource         = "cursor_4c_SubCp.totals"
1167:             .Column6.Alignment             = 1
1168:             .Column6.ReadOnly              = .T.
1169: 
1170:             .Column7.Header1.Caption       = "Moe"
1171:             .Column7.Width                 = 30
1172:             .Column7.ControlSource         = "cursor_4c_SubCp.bloqueio"
1173: 
1174:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
1175:             .Column8.Width                 = 90
1176:             .Column8.ControlSource         = "cursor_4c_SubCp.obscompos"
1177:             .Column8.Alignment             = 0
1178: 
1179:             .Column9.Header1.Caption       = "E"
1180:             .Column9.Width                 = 25
1181:             .Column9.ControlSource         = "cursor_4c_SubCp.etiq"
1182: 
1183:             .Column10.Header1.Caption      = "Consumo"
1184:             .Column10.Width                = 60
1185:             .Column10.ControlSource        = "cursor_4c_SubCp.consumo"
1186:             .Column10.Alignment            = 1
1187: 
1188:             .Column11.Header1.Caption      = "Qtde."
1189:             .Column11.Width                = 55
1190:             .Column11.ControlSource        = "cursor_4c_SubCp.qtd2"
1191:             .Column11.Alignment            = 1
1192: 
1193:             .Column12.Header1.Caption      = "Un"
1194:             .Column12.Width                = 30
1195:             .Column12.ControlSource        = "cursor_4c_SubCp.uni2"
1196:             .Column12.ReadOnly             = .T.
1197: 
1198:             .Column13.Header1.Caption      = "Ord"
1199:             .Column13.Width                = 30
1200:             .Column13.ControlSource        = "cursor_4c_SubCp.ord"
1201:             .Column13.Alignment            = 1
1202: 
1203:             .Column14.Header1.Caption      = "Material"
1204:             .Column14.Width                = 80
1205:             .Column14.ControlSource        = "cursor_4c_SubCp.matrizes"
1206: 
1207:             .Column15.Header1.Caption      = "Tam"
1208:             .Column15.Width                = 88
1209:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1210:             .Column15.Alignment            = 0
1211:         ENDWITH
1212:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1213: 
1214:         *----------------------------------------------------------------------
1215:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1216:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1217:         *----------------------------------------------------------------------
1218:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1219:         WITH loc_oPg.cnt_4c_BotoesSubCp
1220:             .Top         = 345
1221:             .Left        = 947
1222:             .Width       = 50
1223:             .Height      = 90
1224:             .BackStyle = 1
1225:             .BackColor = RGB(53, 53, 53)
1226:             .BorderWidth = 0
1227:             .Visible     = .T.
1228:         ENDWITH
1229: 
1230:         *-- Botao 1: Inserir sub-componente
1231:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_InserirSubCp", "CommandButton")
1232:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp

*-- Linhas 1334 a 1399:
1334:         *-- Grid GradeGRUPO (3 colunas) - Totais por grupo
1335:         *-- Top:34 Left:582 Width:229 Height:107
1336:         *----------------------------------------------------------------------
1337:         loc_oPg.AddObject("grd_4c_Grupo", "Grid")
1338:         WITH loc_oPg.grd_4c_Grupo
1339:             .Top         = 34
1340:             .Left        = 582
1341:             .Width       = 229
1342:             .Height      = 107
1343:             .ColumnCount = 3
1344:             .FontName    = "Verdana"
1345:             .FontSize    = 8
1346:             .GridLines   = 3
1347:             .GridLineWidth = 1
1348:             .GridLineColor = RGB(238, 238, 238)
1349:             .RecordMark  = .F.
1350:             .DeleteMark  = .F.
1351:             .AllowRowSizing = .F.
1352:             .ReadOnly    = .T.
1353:             .BackColor   = RGB(255, 255, 255)
1354:             .ForeColor   = RGB(90, 90, 90)
1355:             .HighlightBackColor = RGB(220, 230, 242)
1356:             .HighlightForeColor = RGB(15, 41, 104)
1357:             .HighlightStyle = 2
1358:             .RowHeight   = 16
1359:             .ScrollBars  = 2
1360:             .Visible     = .T.
1361:         ENDWITH
1362: 
1363:         *-- RecordSource FORA do WITH
1364:         loc_oPg.grd_4c_Grupo.RecordSource = "cursor_4c_Grupo"
1365: 
1366:         *-- Colunas do GradeGRUPO APOS RecordSource
1367:         WITH loc_oPg.grd_4c_Grupo
1368:             .Column1.Header1.Caption = "Grupo"
1369:             .Column1.Width           = 50
1370:             .Column1.ControlSource   = "cursor_4c_Grupo.cgrus"
1371: 
1372:             .Column2.Header1.Caption = "Total"
1373:             .Column2.Width           = 100
1374:             .Column2.ControlSource   = "cursor_4c_Grupo.valgr"
1375:             .Column2.Alignment       = 1
1376: 
1377:             .Column3.Header1.Caption = "Moeda"
1378:             .Column3.Width           = 79
1379:             .Column3.ControlSource   = "cursor_4c_Grupo.moeds"
1380:         ENDWITH
1381: 
1382:         *----------------------------------------------------------------------
1383:         *-- Labels de secao Custo / Venda
1384:         *-- Say1: " Custo " (T:473 L:47 W:46 - secao de custo)
1385:         *-- Say2: " Venda " (T:474 L:361 W:48 - secao de venda)
1386:         *----------------------------------------------------------------------
1387:         loc_oPg.AddObject("lbl_4c_SecCusto", "Label")
1388:         WITH loc_oPg.lbl_4c_SecCusto
1389:             .Caption   = " Custo "
1390:             .Top       = 473
1391:             .Left      = 47
1392:             .Width     = 46
1393:             .Height    = 16
1394:             .FontName  = "Tahoma"
1395:             .FontSize  = 8
1396:             .FontBold  = .T.
1397:             .BackStyle = 1
1398:             .BackColor = RGB(192, 192, 192)
1399:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 2571 a 2717:
2571:             IF USED("cursor_4c_Compo")
2572:                 SELECT cursor_4c_Compo
2573:                 APPEND BLANK
2574:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2575:             ENDIF
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message, "Erro ao inserir componente")
2578:         ENDTRY
2579:     ENDPROC
2580: 
2581:     *--------------------------------------------------------------------------
2582:     * CmdExcluirCompoClick - Remove linha da composicao
2583:     *--------------------------------------------------------------------------
2584:     PROCEDURE CmdExcluirCompoClick()
2585:         LOCAL loc_lConfirma
2586:         TRY
2587:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2588:                 RETURN
2589:             ENDIF
2590:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2591:                 loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
2592:                 IF loc_lConfirma
2593:                     SELECT cursor_4c_Compo
2594:                     DELETE
2595:                     IF !EOF()
2596:                         SKIP
2597:                         SKIP -1
2598:                     ENDIF
2599:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2600:                 ENDIF
2601:             ENDIF
2602:         CATCH TO loc_oErro
2603:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
2604:         ENDTRY
2605:     ENDPROC
2606: 
2607:     *--------------------------------------------------------------------------
2608:     * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
2609:     *--------------------------------------------------------------------------
2610:     PROCEDURE CmdCalcFornecClick()
2611:         TRY
2612:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2613:                 RETURN
2614:             ENDIF
2615:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2616:                 THIS.this_oBusinessObject.CalcFornec()
2617:             ENDIF
2618:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2619:         CATCH TO loc_oErro
2620:             MsgErro(loc_oErro.Message, "Erro ao calcular por fornecedor")
2621:         ENDTRY
2622:     ENDPROC
2623: 
2624:     *--------------------------------------------------------------------------
2625:     * CmdAtualizarCompoClick - Atualiza composicao (recalcula totais/grupos)
2626:     *--------------------------------------------------------------------------
2627:     PROCEDURE CmdAtualizarCompoClick()
2628:         TRY
2629:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2630:                 RETURN
2631:             ENDIF
2632:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2633:                 THIS.this_oBusinessObject.AtualizarComposicao()
2634:             ENDIF
2635:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2636:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Grupo.Refresh()
2637:         CATCH TO loc_oErro
2638:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
2639:         ENDTRY
2640:     ENDPROC
2641: 
2642:     *--------------------------------------------------------------------------
2643:     * CmdAtualizarPesosClick - Atualiza pesos medios dos componentes
2644:     *--------------------------------------------------------------------------
2645:     PROCEDURE CmdAtualizarPesosClick()
2646:         TRY
2647:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2648:                 THIS.this_oBusinessObject.AtualizarPesos()
2649:             ENDIF
2650:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2651:         CATCH TO loc_oErro
2652:             MsgErro(loc_oErro.Message, "Erro ao atualizar pesos")
2653:         ENDTRY
2654:     ENDPROC
2655: 
2656:     *--------------------------------------------------------------------------
2657:     * CmdInserirSubCpClick - Adiciona linha no grid de sub-componentes
2658:     *--------------------------------------------------------------------------
2659:     PROCEDURE CmdInserirSubCpClick()
2660:         TRY
2661:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2662:                 RETURN
2663:             ENDIF
2664:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
2665:                !EMPTY(cursor_4c_Compo.mats)
2666:                 IF USED("cursor_4c_SubCp")
2667:                     SELECT cursor_4c_SubCp
2668:                     APPEND BLANK
2669:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2670:                 ENDIF
2671:             ELSE
2672:                 MsgAviso("Selecione um componente antes de adicionar sub-componente.")
2673:             ENDIF
2674:         CATCH TO loc_oErro
2675:             MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
2676:         ENDTRY
2677:     ENDPROC
2678: 
2679:     *--------------------------------------------------------------------------
2680:     * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
2681:     *--------------------------------------------------------------------------
2682:     PROCEDURE CmdExcluirSubCpClick()
2683:         LOCAL loc_lConfirma
2684:         TRY
2685:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2686:                 RETURN
2687:             ENDIF
2688:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2689:                 loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
2690:                 IF loc_lConfirma
2691:                     SELECT cursor_4c_SubCp
2692:                     DELETE
2693:                     IF !EOF()
2694:                         SKIP
2695:                         SKIP -1
2696:                     ENDIF
2697:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2698:                 ENDIF
2699:             ENDIF
2700:         CATCH TO loc_oErro
2701:             MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
2702:         ENDTRY
2703:     ENDPROC
2704: 
2705:     *--------------------------------------------------------------------------
2706:     * CmdCalcValsClick - Calcular valores de preco/custo/venda
2707:     *--------------------------------------------------------------------------
2708:     PROCEDURE CmdCalcValsClick()
2709:         TRY
2710:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2711:                 THIS.this_oBusinessObject.CalcVals()
2712:             ENDIF
2713:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Refresh()
2714:         CATCH TO loc_oErro
2715:             MsgErro(loc_oErro.Message, "Erro ao calcular valores")
2716:         ENDTRY
2717:     ENDPROC

*-- Linhas 2849 a 2873:
2849:                 "Buscar Moeda")
2850:             IF VARTYPE(loc_oBusca) = "O"
2851:                 IF !loc_oBusca.this_lAchouRegistro
2852:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
2853:                     loc_oBusca.mAddColuna("DMoes", "", "Moeda")
2854:                     loc_oBusca.Show()
2855:                 ENDIF
2856:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2857:                     loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2858:                 ENDIF
2859:                 loc_oBusca.Release()
2860:             ENDIF
2861:             IF USED("cursor_4c_BuscaMoe")
2862:                 USE IN cursor_4c_BuscaMoe
2863:             ENDIF
2864:         CATCH TO loc_oErro
2865:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
2866:         ENDTRY
2867:     ENDPROC
2868: 
2869:     *--------------------------------------------------------------------------
2870:     * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
2871:     *--------------------------------------------------------------------------
2872:     PROCEDURE ValidarMoedaCompo(par_cCampo)
2873:         LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet

*-- Linhas 2960 a 2985:
2960:                     "Fator de Custo")
2961:                 IF VARTYPE(loc_oBusca) = "O"
2962:                     IF !loc_oBusca.this_lAchouRegistro
2963:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
2964:                         loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2965:                         loc_oBusca.mAddColuna("Moedas", "", "Moeda")
2966:                         loc_oBusca.Show()
2967:                     ENDIF
2968:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
2969:                         loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
2970:                     ENDIF
2971:                     loc_oBusca.Release()
2972:                 ENDIF
2973:                 IF USED("cursor_4c_BuscaFtioCusto")
2974:                     USE IN cursor_4c_BuscaFtioCusto
2975:                 ENDIF
2976:             ENDIF
2977:             IF USED("cursor_4c_ListaFtioCusto")
2978:                 USE IN cursor_4c_ListaFtioCusto
2979:             ENDIF
2980:         CATCH TO loc_oErro
2981:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de custo")
2982:         ENDTRY
2983:     ENDPROC
2984: 
2985:     *--------------------------------------------------------------------------

*-- Linhas 3039 a 3063:
3039:                     "Fator de Venda")
3040:                 IF VARTYPE(loc_oBusca) = "O"
3041:                     IF !loc_oBusca.this_lAchouRegistro
3042:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3043:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3044:                         loc_oBusca.Show()
3045:                     ENDIF
3046:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
3047:                         loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
3048:                     ENDIF
3049:                     loc_oBusca.Release()
3050:                 ENDIF
3051:                 IF USED("cursor_4c_BuscaFtioVenda")
3052:                     USE IN cursor_4c_BuscaFtioVenda
3053:                 ENDIF
3054:             ENDIF
3055:             IF USED("cursor_4c_ListaFtioVenda")
3056:                 USE IN cursor_4c_ListaFtioVenda
3057:             ENDIF
3058:         CATCH TO loc_oErro
3059:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de venda")
3060:         ENDTRY
3061:     ENDPROC
3062: 
3063:     *--------------------------------------------------------------------------

*-- Linhas 3119 a 3143:
3119:                 "Buscar Status")
3120:             IF VARTYPE(loc_oBusca) = "O"
3121:                 IF !loc_oBusca.this_lAchouRegistro
3122:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3123:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3124:                     loc_oBusca.Show()
3125:                 ENDIF
3126:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSts")
3127:                     loc_oPg.txt_4c_GetStatus.Value = ALLTRIM(cursor_4c_BuscaSts.Cods)
3128:                 ENDIF
3129:                 loc_oBusca.Release()
3130:             ENDIF
3131:             IF USED("cursor_4c_BuscaSts")
3132:                 USE IN cursor_4c_BuscaSts
3133:             ENDIF
3134:         CATCH TO loc_oErro
3135:             MsgErro(loc_oErro.Message, "Erro ao buscar status")
3136:         ENDTRY
3137:     ENDPROC
3138: 
3139:     *--------------------------------------------------------------------------
3140:     * TxtMarkupALostFocus - Recalcular ao sair do markup aplicado
3141:     *--------------------------------------------------------------------------
3142:     PROCEDURE TxtMarkupALostFocus()
3143:         THIS.CalcPrecoCompo()

*-- Linhas 3229 a 3253:
3229:                 "Buscar Material Principal")
3230:             IF VARTYPE(loc_oBusca) = "O"
3231:                 IF !loc_oBusca.this_lAchouRegistro
3232:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
3233:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3234:                     loc_oBusca.Show()
3235:                 ENDIF
3236:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatP")
3237:                     loc_oPg.txt_4c_MatP.Value  = ALLTRIM(cursor_4c_BuscaMatP.cpros)
3238:                     loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_BuscaMatP.dpros)
3239:                 ENDIF
3240:                 loc_oBusca.Release()
3241:             ENDIF
3242:             IF USED("cursor_4c_BuscaMatP")
3243:                 USE IN cursor_4c_BuscaMatP
3244:             ENDIF
3245:         CATCH TO loc_oErro
3246:             MsgErro(loc_oErro.Message, "Erro ao buscar material principal")
3247:         ENDTRY
3248:     ENDPROC
3249: 
3250:     *--------------------------------------------------------------------------
3251:     * CarregarLista - Carrega registros no grid usando filtros da UI
3252:     * Legado: fCarregaGrade() leia cntFiltros.getCgru/optFilSituas
3253:     *--------------------------------------------------------------------------

*-- Linhas 3287 a 3318:
3287:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3288: 
3289:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3290:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3291:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3292:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3293:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3294:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
3295:                     loc_oGrid.Column4.Header1.Caption = "Subgrp."
3296:                     loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
3297:                     loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
3298:                     loc_oGrid.Column7.Header1.Caption = "I"
3299:                     loc_oGrid.Refresh()
3300:                 ENDIF
3301: 
3302:                 *-- Atualizar contagem
3303:                 IF VARTYPE(loc_oPagina.lbl_4c_Contagem) = "O"
3304:                     loc_oPagina.lbl_4c_Contagem.Caption = "Produtos Selecionados : " + ;
3305:                         TRANSFORM(RECCOUNT("cursor_4c_Dados"))
3306:                 ENDIF
3307: 
3308:                 loc_lResultado = .T.
3309:             ENDIF
3310: 
3311:         CATCH TO loException
3312:             MsgErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3313:             loc_lResultado = .F.
3314:         ENDTRY
3315: 
3316:         RETURN loc_lResultado
3317:     ENDPROC
3318: 

*-- Linhas 3397 a 3421:
3397:                 "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", "", ;
3398:                 "Buscar Grupo de Produto")
3399: 
3400:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3401:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3402:             loc_oBusca.Show()
3403: 
3404:             IF loc_oBusca.this_lSelecionou
3405:                 IF USED("cursor_4c_BuscaGrupo")
3406:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
3407:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
3408:                     THIS.CarregarLista()
3409:                 ENDIF
3410:             ENDIF
3411: 
3412:             IF USED("cursor_4c_BuscaGrupo")
3413:                 USE IN cursor_4c_BuscaGrupo
3414:             ENDIF
3415:             loc_oBusca.Release()
3416: 
3417:         CATCH TO loc_oErro
3418:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
3419:         ENDTRY
3420:     ENDPROC
3421: 

*-- Linhas 3611 a 3636:
3611:         TRY
3612:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
3613: 
3614:             loc_oBusca.mAddColuna("cpros", "", "Produto")
3615:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3616:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3617: 
3618:             loc_oBusca.Show()
3619: 
3620:             IF loc_oBusca.this_lSelecionou
3621:                 IF USED("cursor_4c_Busca")
3622:                     LOCAL loc_cCodigo
3623:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
3624: 
3625:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3626:                         THIS.BOParaForm()
3627:                         THIS.this_cModoAtual = "VISUALIZAR"
3628:                         THIS.HabilitarCampos(.F.)
3629:                         THIS.AlternarPagina(2)
3630:                     ENDIF
3631:                 ENDIF
3632:             ENDIF
3633: 
3634:             IF USED("cursor_4c_Busca")
3635:                 USE IN cursor_4c_Busca
3636:             ENDIF

*-- Linhas 4756 a 4780:
4756:                     ENDIF
4757:                 ELSE
4758:                     IF !loc_oBusca.this_lAchouRegistro
4759:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
4760:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4761:                     loc_oBusca.Show()
4762:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
4763:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4764:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4765:                         loc_oPg.txt_4c_CSGru.Value = ""
4766:                         loc_oPg.txt_4c_DsGru.Value = ""
4767:                     ENDIF
4768:                     ENDIF
4769:                 ENDIF
4770:                 loc_oBusca.Release()
4771:             ENDIF
4772:             IF USED("cursor_4c_BuscaGruP")
4773:                 USE IN cursor_4c_BuscaGruP
4774:             ENDIF
4775:         CATCH TO loc_oErro
4776:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
4777:         ENDTRY
4778:     ENDPROC
4779: 
4780:     *--------------------------------------------------------------------------

*-- Linhas 4839 a 4863:
4839:                     ENDIF
4840:                 ELSE
4841:                     IF !loc_oBusca.this_lAchouRegistro
4842:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4843:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4844:                     loc_oBusca.Show()
4845:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4846:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4847:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4848:                     ENDIF
4849:                     ENDIF
4850:                 ENDIF
4851:                 loc_oBusca.Release()
4852:             ENDIF
4853:             IF USED("cursor_4c_BuscaSGru")
4854:                 USE IN cursor_4c_BuscaSGru
4855:             ENDIF
4856:         CATCH TO loc_oErro
4857:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
4858:         ENDTRY
4859:     ENDPROC
4860: 
4861:     *--------------------------------------------------------------------------
4862:     * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
4863:     *--------------------------------------------------------------------------

*-- Linhas 4916 a 4940:
4916:                     ENDIF
4917:                 ELSE
4918:                     IF !loc_oBusca.this_lAchouRegistro
4919:                     loc_oBusca.mAddColuna("linhas", "", "Linha")
4920:                     loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4921:                     loc_oBusca.Show()
4922:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
4923:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4924:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4925:                     ENDIF
4926:                     ENDIF
4927:                 ENDIF
4928:                 loc_oBusca.Release()
4929:             ENDIF
4930:             IF USED("cursor_4c_BuscaLin")
4931:                 USE IN cursor_4c_BuscaLin
4932:             ENDIF
4933:         CATCH TO loc_oErro
4934:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
4935:         ENDTRY
4936:     ENDPROC
4937: 
4938:     *--------------------------------------------------------------------------
4939:     * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
4940:     *--------------------------------------------------------------------------

*-- Linhas 4993 a 5017:
4993:                     ENDIF
4994:                 ELSE
4995:                     IF !loc_oBusca.this_lAchouRegistro
4996:                     loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
4997:                     loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
4998:                     loc_oBusca.Show()
4999:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5000:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
5001:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
5002:                     ENDIF
5003:                     ENDIF
5004:                 ENDIF
5005:                 loc_oBusca.Release()
5006:             ENDIF
5007:             IF USED("cursor_4c_BuscaCol")
5008:                 USE IN cursor_4c_BuscaCol
5009:             ENDIF
5010:         CATCH TO loc_oErro
5011:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
5012:         ENDTRY
5013:     ENDPROC
5014: 
5015:     *--------------------------------------------------------------------------
5016:     * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
5017:     *--------------------------------------------------------------------------

*-- Linhas 5070 a 5094:
5070:                     ENDIF
5071:                 ELSE
5072:                     IF !loc_oBusca.this_lAchouRegistro
5073:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5074:                     loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
5075:                     loc_oBusca.Show()
5076:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5077:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5078:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5079:                     ENDIF
5080:                     ENDIF
5081:                 ENDIF
5082:                 loc_oBusca.Release()
5083:             ENDIF
5084:             IF USED("cursor_4c_BuscaIfor")
5085:                 USE IN cursor_4c_BuscaIfor
5086:             ENDIF
5087:         CATCH TO loc_oErro
5088:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
5089:         ENDTRY
5090:     ENDPROC
5091: 
5092:     *--------------------------------------------------------------------------
5093:     * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
5094:     *--------------------------------------------------------------------------

*-- Linhas 5142 a 5166:
5142:                     ENDIF
5143:                 ELSE
5144:                     IF !loc_oBusca.this_lAchouRegistro
5145:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
5146:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
5147:                     loc_oBusca.Show()
5148:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
5149:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5150:                     ENDIF
5151:                     ENDIF
5152:                 ENDIF
5153:                 loc_oBusca.Release()
5154:             ENDIF
5155:             IF USED("cursor_4c_BuscaProEq")
5156:                 USE IN cursor_4c_BuscaProEq
5157:             ENDIF
5158:         CATCH TO loc_oErro
5159:             MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
5160:         ENDTRY
5161:     ENDPROC
5162: 
5163:     *--------------------------------------------------------------------------
5164:     * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
5165:     *--------------------------------------------------------------------------
5166:     PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5188 a 5211:
5188:                 IF VARTYPE(loc_oBusca) = "O"
5189:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5190:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5191:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5192:                     loc_oBusca.Show()
5193:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5194:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5195:                     ENDIF
5196:                     loc_oBusca.Release()
5197:                 ENDIF
5198:             ENDIF
5199: 
5200:             IF USED("cursor_4c_BuscaCnj")
5201:                 USE IN cursor_4c_BuscaCnj
5202:             ENDIF
5203:         CATCH TO loc_oErro
5204:             MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
5205:         ENDTRY
5206:     ENDPROC
5207: 
5208:     *==========================================================================
5209:     * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
5210:     *==========================================================================
5211: 

*-- Linhas 6818 a 6842:
6818:                     ENDIF
6819:                 ELSE
6820:                     IF !loc_oBusca.this_lAchouRegistro
6821:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6822:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6823:                     loc_oBusca.Show()
6824:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6825:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6826:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6827:                     ENDIF
6828:                     ENDIF
6829:                 ENDIF
6830:                 loc_oBusca.Release()
6831:             ENDIF
6832:             IF USED("cursor_4c_BuscaUni")
6833:                 USE IN cursor_4c_BuscaUni
6834:             ENDIF
6835:         CATCH TO loc_oErro
6836:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6837:         ENDTRY
6838:     ENDPROC
6839: 
6840:     *--------------------------------------------------------------------------
6841:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6842:     *--------------------------------------------------------------------------

*-- Linhas 6895 a 6919:
6895:                     ENDIF
6896:                 ELSE
6897:                     IF !loc_oBusca.this_lAchouRegistro
6898:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6899:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6900:                     loc_oBusca.Show()
6901:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6902:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6903:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6904:                     ENDIF
6905:                     ENDIF
6906:                 ENDIF
6907:                 loc_oBusca.Release()
6908:             ENDIF
6909:             IF USED("cursor_4c_BuscaUnip")
6910:                 USE IN cursor_4c_BuscaUnip
6911:             ENDIF
6912:         CATCH TO loc_oErro
6913:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6914:         ENDTRY
6915:     ENDPROC
6916: 
6917:     *--------------------------------------------------------------------------
6918:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6919:     *--------------------------------------------------------------------------

*-- Linhas 6972 a 6996:
6972:                     ENDIF
6973:                 ELSE
6974:                     IF !loc_oBusca.this_lAchouRegistro
6975:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6976:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6977:                     loc_oBusca.Show()
6978:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6979:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6980:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6981:                     ENDIF
6982:                     ENDIF
6983:                 ENDIF
6984:                 loc_oBusca.Release()
6985:             ENDIF
6986:             IF USED("cursor_4c_BuscaFinP")
6987:                 USE IN cursor_4c_BuscaFinP
6988:             ENDIF
6989:         CATCH TO loc_oErro
6990:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
6991:         ENDTRY
6992:     ENDPROC
6993: 
6994:     *--------------------------------------------------------------------------
6995:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
6996:     *--------------------------------------------------------------------------

*-- Linhas 7049 a 7073:
7049:                     ENDIF
7050:                 ELSE
7051:                     IF !loc_oBusca.this_lAchouRegistro
7052:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7053:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7054:                     loc_oBusca.Show()
7055:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7056:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7057:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7058:                     ENDIF
7059:                     ENDIF
7060:                 ENDIF
7061:                 loc_oBusca.Release()
7062:             ENDIF
7063:             IF USED("cursor_4c_BuscaAcb")
7064:                 USE IN cursor_4c_BuscaAcb
7065:             ENDIF
7066:         CATCH TO loc_oErro
7067:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7068:         ENDTRY
7069:     ENDPROC
7070: 
7071:     *--------------------------------------------------------------------------
7072:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7073:     * SigCdCls: filtrado por cgrus do grupo de produto corrente

*-- Linhas 7131 a 7155:
7131:                     ENDIF
7132:                 ELSE
7133:                     IF !loc_oBusca.this_lAchouRegistro
7134:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7135:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7136:                     loc_oBusca.Show()
7137:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7138:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7139:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7140:                     ENDIF
7141:                     ENDIF
7142:                 ENDIF
7143:                 loc_oBusca.Release()
7144:             ENDIF
7145:             IF USED("cursor_4c_BuscaClass")
7146:                 USE IN cursor_4c_BuscaClass
7147:             ENDIF
7148:         CATCH TO loc_oErro
7149:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7150:         ENDTRY
7151:     ENDPROC
7152: 
7153:     *--------------------------------------------------------------------------
7154:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7155:     *--------------------------------------------------------------------------

*-- Linhas 7203 a 7227:
7203:                     ENDIF
7204:                 ELSE
7205:                     IF !loc_oBusca.this_lAchouRegistro
7206:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7207:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7208:                     loc_oBusca.Show()
7209:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7210:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7211:                     ENDIF
7212:                     ENDIF
7213:                 ENDIF
7214:                 loc_oBusca.Release()
7215:             ENDIF
7216:             IF USED("cursor_4c_BuscaLocal")
7217:                 USE IN cursor_4c_BuscaLocal
7218:             ENDIF
7219:         CATCH TO loc_oErro
7220:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7221:         ENDTRY
7222:     ENDPROC
7223: 
7224:     *==========================================================================
7225:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7226:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7227:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

*-- Linhas 7238 a 7394:
7238:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7239:         *----------------------------------------------------------------------
7240:         IF !USED("cursor_4c_GrdCons")
7241:             SET NULL ON
7242:             CREATE CURSOR cursor_4c_GrdCons (;
7243:                 mats      C(14), ;
7244:                 qtds      N(12,4), ;
7245:                 unicompos C(5), ;
7246:                 Grupos    C(3), ;
7247:                 Descrs    C(65), ;
7248:                 Ordems    N(5,0), ;
7249:                 consumo   N(12,4), ;
7250:                 Cods      C(5), ;
7251:                 dcats     C(65), ;
7252:                 Dopes     C(5))
7253:             SET NULL OFF
7254:         ENDIF
7255: 
7256:         *----------------------------------------------------------------------
7257:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7258:         *----------------------------------------------------------------------
7259:         IF !USED("cursor_4c_GrDTEMP")
7260:             SET NULL ON
7261:             CREATE CURSOR cursor_4c_GrDTEMP (;
7262:                 agrup C(30), ;
7263:                 tempo N(12,4))
7264:             SET NULL OFF
7265:         ENDIF
7266: 
7267:         *----------------------------------------------------------------------
7268:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7269:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7270:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7271:         *----------------------------------------------------------------------
7272:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7273:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7274: 
7275:         WITH loc_oGrd
7276:             .Top              = 155
7277:             .Left             = 6
7278:             .Width            = 987
7279:             .Height           = 362
7280:             .FontName         = "Tahoma"
7281:             .FontSize         = 8
7282:             .ColumnCount      = 9
7283:             .GridLines        = 3
7284:             .GridLineWidth    = 1
7285:             .GridLineColor    = RGB(238, 238, 238)
7286:             .RecordMark       = .F.
7287:             .DeleteMark       = .F.
7288:             .AllowRowSizing   = .F.
7289:             .ReadOnly         = .F.
7290:             .BackColor        = RGB(255, 255, 255)
7291:             .ForeColor        = RGB(90, 90, 90)
7292:             .HighlightBackColor = RGB(220, 230, 242)
7293:             .HighlightForeColor = RGB(15, 41, 104)
7294:             .HighlightStyle   = 2
7295:             .RowHeight        = 16
7296:             .ScrollBars       = 2
7297:             .Themes           = .F.
7298:             .Visible          = .T.
7299:         ENDWITH
7300: 
7301:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7302:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7303: 
7304:         *-- Configurar colunas APOS RecordSource
7305:         WITH loc_oPg.grd_4c_GrdCons
7306:             *-- Col1: Componente (mats C14) W:140 - readonly
7307:             .Column1.Header1.Caption = "Componente"
7308:             .Column1.Width           = 140
7309:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7310:             .Column1.Alignment       = 0
7311:             .Column1.ReadOnly        = .T.
7312: 
7313:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7314:             .Column2.Header1.Caption = "Qtde."
7315:             .Column2.Width           = 70
7316:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7317:             .Column2.Alignment       = 1
7318:             .Column2.ReadOnly        = .T.
7319: 
7320:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7321:             .Column3.Header1.Caption = "Uni"
7322:             .Column3.Width           = 40
7323:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7324:             .Column3.Alignment       = 0
7325:             .Column3.ReadOnly        = .T.
7326: 
7327:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7328:             .Column4.Header1.Caption = "Fase"
7329:             .Column4.Width           = 45
7330:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7331:             .Column4.Alignment       = 0
7332:             .Column4.ReadOnly        = .F.
7333: 
7334:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7335:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7336:             .Column5.Width           = 250
7337:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7338:             .Column5.Alignment       = 0
7339:             .Column5.ReadOnly        = .F.
7340: 
7341:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7342:             .Column6.Header1.Caption = "Ord."
7343:             .Column6.Width           = 40
7344:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7345:             .Column6.Alignment       = 1
7346:             .Column6.ReadOnly        = .T.
7347: 
7348:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7349:             .Column7.Header1.Caption = "Consumo"
7350:             .Column7.Width           = 80
7351:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7352:             .Column7.Alignment       = 1
7353:             .Column7.ReadOnly        = .F.
7354: 
7355:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7356:             .Column8.Header1.Caption = "Cat."
7357:             .Column8.Width           = 45
7358:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7359:             .Column8.Alignment       = 0
7360:             .Column8.ReadOnly        = .F.
7361: 
7362:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7363:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7364:             .Column9.Width           = 277
7365:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7366:             .Column9.Alignment       = 0
7367:             .Column9.ReadOnly        = .F.
7368:         ENDWITH
7369: 
7370:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7371:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7372:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7373:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7374:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7375: 
7376:         *----------------------------------------------------------------------
7377:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7378:         *----------------------------------------------------------------------
7379:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7380:         WITH loc_oPg.lbl_4c_Label7
7381:             .Caption   = "Qtde Componentes : "
7382:             .Top       = 523
7383:             .Left      = 25
7384:             .Width     = 105
7385:             .Height    = 15
7386:             .FontName  = "Tahoma"
7387:             .FontSize  = 8
7388:             .BackStyle = 0
7389:             .ForeColor = RGB(90, 90, 90)
7390:             .Visible   = .T.
7391:         ENDWITH
7392: 
7393:         *----------------------------------------------------------------------
7394:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)

*-- Linhas 7453 a 7689:
7453:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.grDTEMP
7454:         *-- Cols: Agrupamento, Tempo %  (ambas read-only)
7455:         *----------------------------------------------------------------------
7456:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
7457: 
7458:         WITH loc_oPg.grd_4c_GrDTEMP
7459:             .Top              = 519
7460:             .Left             = 821
7461:             .Width            = 172
7462:             .Height           = 107
7463:             .FontName         = "Tahoma"
7464:             .FontSize         = 8
7465:             .ColumnCount      = 2
7466:             .GridLines        = 3
7467:             .GridLineWidth    = 1
7468:             .GridLineColor    = RGB(238, 238, 238)
7469:             .RecordMark       = .F.
7470:             .DeleteMark       = .F.
7471:             .AllowRowSizing   = .F.
7472:             .ReadOnly         = .T.
7473:             .BackColor        = RGB(255, 255, 255)
7474:             .ForeColor        = RGB(90, 90, 90)
7475:             .HighlightBackColor = RGB(220, 230, 242)
7476:             .HighlightForeColor = RGB(15, 41, 104)
7477:             .HighlightStyle   = 2
7478:             .RowHeight        = 16
7479:             .ScrollBars       = 2
7480:             .Themes           = .F.
7481:             .Visible          = .T.
7482:         ENDWITH
7483: 
7484:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7485:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7486: 
7487:         *-- Configurar colunas do grDTEMP APOS RecordSource
7488:         WITH loc_oPg.grd_4c_GrDTEMP
7489:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7490:             .Column1.Header1.Caption = "Agrupamento"
7491:             .Column1.Width           = 100
7492:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7493:             .Column1.Alignment       = 0
7494:             .Column1.ReadOnly        = .T.
7495: 
7496:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7497:             .Column2.Header1.Caption = "Tempo %"
7498:             .Column2.Width           = 72
7499:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7500:             .Column2.Alignment       = 1
7501:             .Column2.ReadOnly        = .T.
7502:         ENDWITH
7503: 
7504:     ENDPROC
7505: 
7506:     *==========================================================================
7507:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7508:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7509:     *==========================================================================
7510: 
7511:     *--------------------------------------------------------------------------
7512:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7513:     *--------------------------------------------------------------------------
7514:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7515:         TRY
7516:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7517:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7518:             ENDIF
7519:         CATCH TO loc_oErro
7520:             *-- silencioso: refresh de navegacao nao deve bloquear
7521:         ENDTRY
7522:     ENDPROC
7523: 
7524:     *--------------------------------------------------------------------------
7525:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7526:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7527:     *--------------------------------------------------------------------------
7528:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7529:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7530:         IF par_nKeyCode = 115  && F4
7531:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7532:                 RETURN
7533:             ENDIF
7534:             TRY
7535:                 loc_cAtual = ""
7536:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7537:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7538:                 ENDIF
7539:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7540:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7541:                     "Buscar Fase")
7542:                 IF VARTYPE(loc_oBusca) = "O"
7543:                     IF !loc_oBusca.this_lAchouRegistro
7544:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7545:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7546:                         loc_oBusca.Show()
7547:                     ENDIF
7548:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7549:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7550:                             SELECT cursor_4c_GrdCons
7551:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7552:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7553:                         ENDIF
7554:                     ENDIF
7555:                     loc_oBusca.Release()
7556:                 ENDIF
7557:                 IF USED("cursor_4c_BuscaPrf")
7558:                     USE IN cursor_4c_BuscaPrf
7559:                 ENDIF
7560:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7561:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7562:                 ENDIF
7563:             CATCH TO loc_oErro
7564:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7565:             ENDTRY
7566:         ENDIF
7567:     ENDPROC
7568: 
7569:     *--------------------------------------------------------------------------
7570:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7571:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7572:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7573:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7574:     *--------------------------------------------------------------------------
7575:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7576:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7577:         IF par_nKeyCode = 115  && F4
7578:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7579:                 RETURN
7580:             ENDIF
7581:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7582:             loc_cGrupos = ""
7583:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7584:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7585:             ENDIF
7586:             IF !EMPTY(loc_cGrupos)
7587:                 RETURN
7588:             ENDIF
7589:             TRY
7590:                 loc_cAtual = ""
7591:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7592:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7593:                 ENDIF
7594:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7595:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7596:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7597:                 IF VARTYPE(loc_oBusca) = "O"
7598:                     IF !loc_oBusca.this_lAchouRegistro
7599:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7600:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7601:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7602:                         loc_oBusca.Show()
7603:                     ENDIF
7604:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7605:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7606:                             SELECT cursor_4c_GrdCons
7607:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7608:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7609:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7610:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7611:                             ENDIF
7612:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7613:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7614:                             ENDIF
7615:                         ENDIF
7616:                     ENDIF
7617:                     loc_oBusca.Release()
7618:                 ENDIF
7619:                 IF USED("cursor_4c_BuscaPrf2")
7620:                     USE IN cursor_4c_BuscaPrf2
7621:                 ENDIF
7622:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7623:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7624:                 ENDIF
7625:             CATCH TO loc_oErro
7626:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7627:             ENDTRY
7628:         ENDIF
7629:     ENDPROC
7630: 
7631:     *--------------------------------------------------------------------------
7632:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7633:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7634:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7635:     *--------------------------------------------------------------------------
7636:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7637:         LOCAL loc_oBusca, loc_cAtual
7638:         IF par_nKeyCode = 115  && F4
7639:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7640:                 RETURN
7641:             ENDIF
7642:             TRY
7643:                 loc_cAtual = ""
7644:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7645:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7646:                 ENDIF
7647:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7648:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7649:                     "Buscar Categoria")
7650:                 IF VARTYPE(loc_oBusca) = "O"
7651:                     IF !loc_oBusca.this_lAchouRegistro
7652:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7653:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7654:                         loc_oBusca.Show()
7655:                     ENDIF
7656:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7657:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7658:                             SELECT cursor_4c_GrdCons
7659:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7660:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7661:                         ENDIF
7662:                     ENDIF
7663:                     loc_oBusca.Release()
7664:                 ENDIF
7665:                 IF USED("cursor_4c_BuscaCat")
7666:                     USE IN cursor_4c_BuscaCat
7667:                 ENDIF
7668:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7669:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7670:                 ENDIF
7671:             CATCH TO loc_oErro
7672:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7673:             ENDTRY
7674:         ENDIF
7675:     ENDPROC
7676: 
7677:     *==========================================================================
7678:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7679:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7680:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7681:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7682:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7683:     *==========================================================================
7684:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7685:         LOCAL loc_oPg, loc_oGrd
7686: 
7687:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7688: 
7689:         *----------------------------------------------------------------------

*-- Linhas 7732 a 7857:
7732:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7733:         *--          Observacao, Etiq, Consumo, Qtd, Un
7734:         *----------------------------------------------------------------------
7735:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7736:         WITH loc_oPg.grd_4c_CustoCompo
7737:             .Top               = 178
7738:             .Left              = 34
7739:             .Width             = 813
7740:             .Height            = 230
7741:             .ColumnCount       = 12
7742:             .FontName          = "Verdana"
7743:             .FontSize          = 8
7744:             .GridLines         = 3
7745:             .GridLineWidth     = 1
7746:             .GridLineColor     = RGB(238, 238, 238)
7747:             .RecordMark        = .F.
7748:             .DeleteMark        = .F.
7749:             .AllowRowSizing    = .F.
7750:             .ReadOnly          = .F.
7751:             .BackColor         = RGB(255, 255, 255)
7752:             .ForeColor         = RGB(90, 90, 90)
7753:             .HighlightBackColor = RGB(220, 230, 242)
7754:             .HighlightForeColor = RGB(15, 41, 104)
7755:             .HighlightStyle    = 2
7756:             .RowHeight         = 16
7757:             .ScrollBars        = 2
7758:             .Visible           = .T.
7759:         ENDWITH
7760: 
7761:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7762:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7763: 
7764:         *-- Configurar colunas APOS RecordSource
7765:         WITH loc_oPg.grd_4c_CustoCompo
7766:             *-- Col1: Item/Material (C14) W:80
7767:             .Column1.Header1.Caption   = "Item"
7768:             .Column1.Width             = 80
7769:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7770:             .Column1.Alignment         = 0
7771: 
7772:             *-- Col2: Descricao (C65) W:185
7773:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7774:             .Column2.Width             = 185
7775:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7776:             .Column2.Alignment         = 0
7777: 
7778:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7779:             .Column3.Header1.Caption   = "Un"
7780:             .Column3.Width             = 35
7781:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7782:             .Column3.ReadOnly          = .T.
7783: 
7784:             *-- Col4: Valor (N12,4) W:65
7785:             .Column4.Header1.Caption   = "Valor"
7786:             .Column4.Width             = 65
7787:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7788:             .Column4.Alignment         = 1
7789: 
7790:             *-- Col5: Qtd (N12,4) W:55
7791:             .Column5.Header1.Caption   = "Qtd"
7792:             .Column5.Width             = 55
7793:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7794:             .Column5.Alignment         = 1
7795: 
7796:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7797:             .Column6.Header1.Caption   = "Total"
7798:             .Column6.Width             = 65
7799:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7800:             .Column6.Alignment         = 1
7801:             .Column6.ReadOnly          = .T.
7802: 
7803:             *-- Col7: Moe/Moeda (C5) W:35
7804:             .Column7.Header1.Caption   = "Moe"
7805:             .Column7.Width             = 35
7806:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7807: 
7808:             *-- Col8: Observacao (C40) W:95
7809:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7810:             .Column8.Width             = 95
7811:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7812:             .Column8.Alignment         = 0
7813: 
7814:             *-- Col9: Etiq (C1) W:30
7815:             .Column9.Header1.Caption   = "Etiq"
7816:             .Column9.Width             = 30
7817:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7818: 
7819:             *-- Col10: Consumo (N12,4) W:65
7820:             .Column10.Header1.Caption  = "Consumo"
7821:             .Column10.Width            = 65
7822:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7823:             .Column10.Alignment        = 1
7824: 
7825:             *-- Col11: Qtd cons (N12,4) W:55
7826:             .Column11.Header1.Caption  = "Qtd"
7827:             .Column11.Width            = 55
7828:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7829:             .Column11.Alignment        = 1
7830: 
7831:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7832:             .Column12.Header1.Caption  = "Un"
7833:             .Column12.Width            = 30
7834:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7835:             .Column12.ReadOnly         = .T.
7836:         ENDWITH
7837:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7838: 
7839:         *----------------------------------------------------------------------
7840:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7841:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7842:         *----------------------------------------------------------------------
7843:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7844:         WITH loc_oPg.cnt_4c_BotoesCusto
7845:             .Top         = 240
7846:             .Left        = 851
7847:             .Width       = 50
7848:             .Height      = 90
7849:             .BackStyle = 1
7850:             .BackColor = RGB(53, 53, 53)
7851:             .BorderWidth = 0
7852:             .Visible     = .T.
7853:         ENDWITH
7854: 
7855:         *-- Botao 1: Inserir componente de custo
7856:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7857:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto

*-- Linhas 7988 a 8060:
7988:             .Visible     = .T.
7989:         ENDWITH
7990: 
7991:         *-- GradeGRUPO2: grd_4c_GrupoCusto (3 cols) - usa cursor_4c_Grupo (compartilhado)
7992:         loc_oPg.AddObject("grd_4c_GrupoCusto", "Grid")
7993:         WITH loc_oPg.grd_4c_GrupoCusto
7994:             .Top               = 468
7995:             .Left              = 35
7996:             .Width             = 195
7997:             .Height            = 141
7998:             .ColumnCount       = 3
7999:             .FontName          = "Verdana"
8000:             .FontSize          = 8
8001:             .GridLines         = 3
8002:             .GridLineWidth     = 1
8003:             .GridLineColor     = RGB(238, 238, 238)
8004:             .RecordMark        = .F.
8005:             .DeleteMark        = .F.
8006:             .AllowRowSizing    = .F.
8007:             .ReadOnly          = .T.
8008:             .BackColor         = RGB(255, 255, 255)
8009:             .ForeColor         = RGB(90, 90, 90)
8010:             .HighlightBackColor = RGB(220, 230, 242)
8011:             .HighlightForeColor = RGB(15, 41, 104)
8012:             .HighlightStyle    = 2
8013:             .RowHeight         = 16
8014:             .ScrollBars        = 2
8015:             .Visible           = .T.
8016:         ENDWITH
8017: 
8018:         *-- RecordSource FORA do WITH
8019:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8020: 
8021:         *-- Configurar colunas APOS RecordSource
8022:         WITH loc_oPg.grd_4c_GrupoCusto
8023:             *-- Col1: Grupo (C3) W:40 - readonly
8024:             .Column1.Header1.Caption   = "Grp"
8025:             .Column1.Width             = 40
8026:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8027:             .Column1.ReadOnly          = .T.
8028: 
8029:             *-- Col2: Total (N12,4) W:100 - readonly
8030:             .Column2.Header1.Caption   = "Total"
8031:             .Column2.Width             = 100
8032:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8033:             .Column2.Alignment         = 1
8034:             .Column2.ReadOnly          = .T.
8035: 
8036:             *-- Col3: Moeda (C5) W:50 - readonly
8037:             .Column3.Header1.Caption   = "Moe"
8038:             .Column3.Width             = 50
8039:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8040:             .Column3.ReadOnly          = .T.
8041:         ENDWITH
8042:     ENDPROC
8043: 
8044:     *--------------------------------------------------------------------------
8045:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8046:     *--------------------------------------------------------------------------
8047:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8048:         LOCAL loc_oPg, loc_nRet
8049:         TRY
8050:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8051:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8052:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8053:                 *-- Buscar descricao do grupo
8054:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8055:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8056:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8057:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8058:                         "cursor_4c_TmpGrpCusto")
8059:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8060:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)

*-- Linhas 8082 a 8164:
8082:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8083:             IF USED("cursor_4c_Compo")
8084:                 GO TOP IN cursor_4c_Compo
8085:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8086:             ENDIF
8087:         CATCH TO loc_oErro
8088:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8089:         ENDTRY
8090:     ENDPROC
8091: 
8092:     *--------------------------------------------------------------------------
8093:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8094:     *--------------------------------------------------------------------------
8095:     PROCEDURE CmdInserirCustoClick()
8096:         LOCAL loc_oPg, loc_cTipo
8097:         TRY
8098:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8099:                 RETURN
8100:             ENDIF
8101:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8102:             loc_cTipo = ""
8103:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8104:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8105:             ENDIF
8106:             IF USED("cursor_4c_Compo")
8107:                 SELECT cursor_4c_Compo
8108:                 GO TOP IN cursor_4c_Compo
8109:                 LOCATE FOR EMPTY(mats)
8110:                 IF EOF("cursor_4c_Compo")
8111:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8112:                 ENDIF
8113:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8114:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8115:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8116:                 ENDIF
8117:             ENDIF
8118:         CATCH TO loc_oErro
8119:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8120:         ENDTRY
8121:     ENDPROC
8122: 
8123:     *--------------------------------------------------------------------------
8124:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8125:     *--------------------------------------------------------------------------
8126:     PROCEDURE CmdExcluirCustoClick()
8127:         LOCAL loc_oPg
8128:         TRY
8129:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8130:                 RETURN
8131:             ENDIF
8132:             IF USED("cursor_4c_Compo")
8133:                 SELECT cursor_4c_Compo
8134:                 IF !EOF("cursor_4c_Compo")
8135:                     DELETE
8136:                     IF !EOF("cursor_4c_Compo")
8137:                         SKIP
8138:                         SKIP -1
8139:                     ENDIF
8140:                     GO BOTTOM IN cursor_4c_Compo
8141:                 ENDIF
8142:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8143:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8144:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8145:             ENDIF
8146:         CATCH TO loc_oErro
8147:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8148:         ENDTRY
8149:     ENDPROC
8150: 
8151:     *--------------------------------------------------------------------------
8152:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8153:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8154:     *--------------------------------------------------------------------------
8155:     PROCEDURE AjustarBotoesPorModo()
8156:         LOCAL loc_oPg2, loc_lEditando
8157:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8158: 
8159:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8160:             RETURN
8161:         ENDIF
8162: 
8163:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8164: 

*-- Linhas 8185 a 8230:
8185:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8186:         *----------------------------------------------------------------------
8187:         IF !USED("cursor_4c_GradFase")
8188:             SET NULL ON
8189:             CREATE CURSOR cursor_4c_GradFase (;
8190:                 Ordems   N(5,0), ;
8191:                 Grupos   C(10), ;
8192:                 Descrs   C(65), ;
8193:                 UniPrdts C(10), ;
8194:                 MatPrdts C(15), ;
8195:                 Obs      M, ;
8196:                 FigProcs M)
8197:             SET NULL OFF
8198:         ENDIF
8199: 
8200:         *----------------------------------------------------------------------
8201:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8202:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8203:         *----------------------------------------------------------------------
8204:         IF !USED("cursor_4c_SigPrMtz")
8205:             SET NULL ON
8206:             CREATE CURSOR cursor_4c_SigPrMtz (;
8207:                 CMats C(14), ;
8208:                 DLocs C(40), ;
8209:                 Qtds  N(3,0))
8210:             SET NULL OFF
8211:         ENDIF
8212: 
8213:         *----------------------------------------------------------------------
8214:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8215:         *----------------------------------------------------------------------
8216:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8217:         WITH loc_oPg.shp_4c_ShpFig
8218:             .Top         = 152
8219:             .Left        = 231
8220:             .Width       = 244
8221:             .Height      = 148
8222:             .BackStyle   = 1
8223:             .BackColor   = RGB(255, 255, 255)
8224:             .BorderColor = RGB(192, 192, 192)
8225:             .BorderWidth = 1
8226:             .Visible     = .T.
8227:         ENDWITH
8228: 
8229:         *----------------------------------------------------------------------
8230:         *-- Image: ImgFigJpg (T:153 L:232 W:241 H:146) - imagem da fase de producao

*-- Linhas 8247 a 8346:
8247:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8248:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8249:         *----------------------------------------------------------------------
8250:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8251:         loc_oGrd = loc_oPg.grd_4c_GradFase
8252: 
8253:         WITH loc_oGrd
8254:             .Top                = 152
8255:             .Left               = 527
8256:             .Width              = 420
8257:             .Height             = 312
8258:             .FontName           = "Tahoma"
8259:             .FontSize           = 8
8260:             .ColumnCount        = 5
8261:             .GridLines          = 3
8262:             .GridLineWidth      = 1
8263:             .GridLineColor      = RGB(238, 238, 238)
8264:             .RecordMark         = .F.
8265:             .DeleteMark         = .F.
8266:             .AllowRowSizing     = .F.
8267:             .ReadOnly           = .F.
8268:             .BackColor          = RGB(255, 255, 255)
8269:             .ForeColor          = RGB(90, 90, 90)
8270:             .HighlightBackColor = RGB(220, 230, 242)
8271:             .HighlightForeColor = RGB(15, 41, 104)
8272:             .HighlightStyle     = 2
8273:             .RowHeight          = 16
8274:             .ScrollBars         = 2
8275:             .Themes             = .F.
8276:             .Visible            = .T.
8277:         ENDWITH
8278: 
8279:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8280:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8281: 
8282:         *-- Configurar colunas APOS RecordSource
8283:         WITH loc_oPg.grd_4c_GradFase
8284:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8285:             .Column1.Header1.Caption = "Ordem"
8286:             .Column1.Width           = 50
8287:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8288:             .Column1.Alignment       = 1
8289:             .Column1.ReadOnly        = .T.
8290: 
8291:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8292:             .Column2.Header1.Caption = "Fase"
8293:             .Column2.Width           = 80
8294:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8295:             .Column2.Alignment       = 0
8296:             .Column2.ReadOnly        = .F.
8297: 
8298:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8299:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8300:             .Column3.Width           = 130
8301:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8302:             .Column3.Alignment       = 0
8303:             .Column3.ReadOnly        = .T.
8304: 
8305:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8306:             .Column4.Header1.Caption = "Uni. Produtiva"
8307:             .Column4.Width           = 80
8308:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8309:             .Column4.Alignment       = 0
8310:             .Column4.ReadOnly        = .F.
8311: 
8312:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8313:             .Column5.Header1.Caption = "Material"
8314:             .Column5.Width           = 80
8315:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8316:             .Column5.Alignment       = 0
8317:             .Column5.ReadOnly        = .F.
8318:         ENDWITH
8319: 
8320:         *-- BINDEVENT: GradFase
8321:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8322:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8323:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8324:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8325:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8326:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8327: 
8328:         *----------------------------------------------------------------------
8329:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8330:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8331:         *----------------------------------------------------------------------
8332:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8333:         WITH loc_oPg.cmd_4c_IncluirFase
8334:             .Caption       = "+"
8335:             .Top           = 152
8336:             .Left          = 950
8337:             .Width         = 38
8338:             .Height        = 38
8339:             .FontName      = "Tahoma"
8340:             .FontSize      = 10
8341:             .FontBold      = .T.
8342:             .Themes        = .F.
8343:             .SpecialEffect = 0
8344:             .BackColor     = RGB(255, 255, 255)
8345:             .ForeColor     = RGB(0, 128, 0)
8346:             .Visible       = .T.

*-- Linhas 8870 a 8951:
8870: 
8871:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8872:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8873:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8874:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8875: 
8876:         WITH loc_oGrd
8877:             .Top                = 380
8878:             .Left               = 7
8879:             .Width              = 246
8880:             .Height             = 240
8881:             .FontName           = "Tahoma"
8882:             .FontSize           = 8
8883:             .ColumnCount        = 3
8884:             .GridLines          = 3
8885:             .GridLineWidth      = 1
8886:             .GridLineColor      = RGB(238, 238, 238)
8887:             .RecordMark         = .F.
8888:             .DeleteMark         = .F.
8889:             .AllowRowSizing     = .F.
8890:             .ReadOnly           = .F.
8891:             .BackColor          = RGB(255, 255, 255)
8892:             .ForeColor          = RGB(90, 90, 90)
8893:             .HighlightBackColor = RGB(220, 230, 242)
8894:             .HighlightForeColor = RGB(15, 41, 104)
8895:             .HighlightStyle     = 2
8896:             .RowHeight          = 16
8897:             .ScrollBars         = 2
8898:             .Themes             = .F.
8899:             .Visible            = .T.
8900:         ENDWITH
8901: 
8902:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8903:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8904: 
8905:         *-- Configurar colunas APOS RecordSource
8906:         WITH loc_oPg.grd_4c_Matrizes
8907:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8908:             .Column1.Header1.Caption = "Matriz"
8909:             .Column1.Width           = 70
8910:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8911:             .Column1.Alignment       = 0
8912:             .Column1.ReadOnly        = .F.
8913: 
8914:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8915:             .Column2.Header1.Caption = "Local"
8916:             .Column2.Width           = 120
8917:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8918:             .Column2.Alignment       = 0
8919:             .Column2.ReadOnly        = .T.
8920: 
8921:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8922:             .Column3.Header1.Caption = "Qtde"
8923:             .Column3.Width           = 56
8924:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8925:             .Column3.Alignment       = 1
8926:             .Column3.ReadOnly        = .F.
8927:         ENDWITH
8928: 
8929:         *-- BINDEVENT: grdMatrizes
8930:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8931:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8932: 
8933:         *----------------------------------------------------------------------
8934:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8935:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8936:         *----------------------------------------------------------------------
8937:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8938:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8939:             .Caption       = "+"
8940:             .Top           = 380
8941:             .Left          = 258
8942:             .Width         = 38
8943:             .Height        = 38
8944:             .FontName      = "Tahoma"
8945:             .FontSize      = 10
8946:             .FontBold      = .T.
8947:             .Themes        = .F.
8948:             .SpecialEffect = 0
8949:             .BackColor     = RGB(255, 255, 255)
8950:             .ForeColor     = RGB(0, 128, 0)
8951:             .Visible       = .T.

*-- Linhas 9165 a 9210:
9165:                 ENDIF
9166:             ENDIF
9167: 
9168:             loc_oPg.grd_4c_GradFase.Refresh()
9169:         CATCH TO loc_oErro
9170:             MsgErro(loc_oErro.Message, "Erro ao atualizar aba Fases")
9171:         ENDTRY
9172:     ENDPROC
9173: 
9174:     *--------------------------------------------------------------------------
9175:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9176:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9177:     *--------------------------------------------------------------------------
9178:     PROCEDURE GradFaseCol1GotFocus()
9179:         TRY
9180:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9181:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9182:             ENDIF
9183:         CATCH TO loc_oErro
9184:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9185:         ENDTRY
9186:     ENDPROC
9187: 
9188:     *--------------------------------------------------------------------------
9189:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9190:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9191:     *--------------------------------------------------------------------------
9192:     PROCEDURE GradFaseCol1LostFocus()
9193:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9194:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9195:             RETURN
9196:         ENDIF
9197:         loc_lResultado = .T.
9198:         TRY
9199:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9200:                 loc_lResultado = .F.
9201:             ENDIF
9202:             IF loc_lResultado
9203:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9204:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9205:                     loc_lResultado = .F.
9206:                 ENDIF
9207:             ENDIF
9208:             IF loc_lResultado
9209:                 *-- Calcular Ordem2 para resequenciamento
9210:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")

*-- Linhas 9218 a 9297:
9218:                 SELECT cursor_4c_GradFase
9219:                 *-- Reordenar por Ordems para refletir nova sequencia
9220:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9221:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9222:                 ENDIF
9223:             ENDIF
9224:         CATCH TO loc_oErro
9225:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9226:         ENDTRY
9227:     ENDPROC
9228: 
9229:     *--------------------------------------------------------------------------
9230:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9231:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9232:     *         Apos selecao: preenche Grupos e Descrs no cursor
9233:     *--------------------------------------------------------------------------
9234:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9235:         LOCAL loc_oBusca, loc_cAtual
9236:         IF par_nKeyCode = 115  && F4
9237:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9238:                 RETURN
9239:             ENDIF
9240:             TRY
9241:                 loc_cAtual = ""
9242:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9243:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9244:                 ENDIF
9245:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9246:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9247:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9248:                 IF VARTYPE(loc_oBusca) = "O"
9249:                     IF !loc_oBusca.this_lAchouRegistro
9250:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9251:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9252:                         loc_oBusca.Show()
9253:                     ENDIF
9254:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9255:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9256:                             SELECT cursor_4c_GradFase
9257:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9258:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9259:                         ENDIF
9260:                     ENDIF
9261:                     loc_oBusca.Release()
9262:                 ENDIF
9263:                 IF USED("cursor_4c_BuscaGcr")
9264:                     USE IN cursor_4c_BuscaGcr
9265:                 ENDIF
9266:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9267:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9268:                 ENDIF
9269:             CATCH TO loc_oErro
9270:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9271:             ENDTRY
9272:         ENDIF
9273:     ENDPROC
9274: 
9275:     *--------------------------------------------------------------------------
9276:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9277:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9278:     *         Apos selecao: preenche UniPrdts no cursor
9279:     *--------------------------------------------------------------------------
9280:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9281:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9282:         IF par_nKeyCode = 115  && F4
9283:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9284:                 RETURN
9285:             ENDIF
9286:             TRY
9287:                 loc_cAtual  = ""
9288:                 loc_cGrupos = ""
9289:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9290:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9291:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9292:                 ENDIF
9293:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9294:                 IF !EMPTY(loc_cGrupos)
9295:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9296:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9297:                 ELSE

*-- Linhas 9304 a 9391:
9304:                         "Buscar Uni. Produtiva")
9305:                     IF VARTYPE(loc_oBusca) = "O"
9306:                         IF !loc_oBusca.this_lAchouRegistro
9307:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9308:                             loc_oBusca.Show()
9309:                         ENDIF
9310:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9311:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9312:                                 SELECT cursor_4c_GradFase
9313:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9314:                             ENDIF
9315:                         ENDIF
9316:                         loc_oBusca.Release()
9317:                     ENDIF
9318:                     IF USED("cursor_4c_BuscaUpd2")
9319:                         USE IN cursor_4c_BuscaUpd2
9320:                     ENDIF
9321:                 ENDIF
9322:                 IF USED("cursor_4c_BuscaUpd")
9323:                     USE IN cursor_4c_BuscaUpd
9324:                 ENDIF
9325:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9326:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9327:                 ENDIF
9328:             CATCH TO loc_oErro
9329:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9330:             ENDTRY
9331:         ENDIF
9332:     ENDPROC
9333: 
9334:     *--------------------------------------------------------------------------
9335:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9336:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9337:     *         Apos selecao: preenche MatPrdts no cursor
9338:     *--------------------------------------------------------------------------
9339:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9340:         LOCAL loc_oBusca, loc_cAtual
9341:         IF par_nKeyCode = 115  && F4
9342:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9343:                 RETURN
9344:             ENDIF
9345:             TRY
9346:                 loc_cAtual = ""
9347:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9348:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9349:                 ENDIF
9350:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9351:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9352:                     "Buscar Tipo de Material")
9353:                 IF VARTYPE(loc_oBusca) = "O"
9354:                     IF !loc_oBusca.this_lAchouRegistro
9355:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9356:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9357:                         loc_oBusca.Show()
9358:                     ENDIF
9359:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9360:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9361:                             SELECT cursor_4c_GradFase
9362:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9363:                         ENDIF
9364:                     ENDIF
9365:                     loc_oBusca.Release()
9366:                 ENDIF
9367:                 IF USED("cursor_4c_BuscaOpt")
9368:                     USE IN cursor_4c_BuscaOpt
9369:                 ENDIF
9370:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9371:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9372:                 ENDIF
9373:             CATCH TO loc_oErro
9374:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9375:             ENDTRY
9376:         ENDIF
9377:     ENDPROC
9378: 
9379:     *--------------------------------------------------------------------------
9380:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9381:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9382:     *--------------------------------------------------------------------------
9383:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9384:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9385:         TRY
9386:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9387:                 RETURN
9388:             ENDIF
9389:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9390:             IF VARTYPE(loc_oPg) # "O"
9391:                 RETURN

*-- Linhas 9420 a 9491:
9420:                 ENDIF
9421:             ENDIF
9422: 
9423:             loc_oPg.grd_4c_Matrizes.Refresh()
9424:         CATCH TO loc_oErro
9425:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da matriz")
9426:         ENDTRY
9427:     ENDPROC
9428: 
9429:     *--------------------------------------------------------------------------
9430:     * GrdMatrizesCol1KeyPress - F4 abre lookup de Matrizes (cursor crMatrizes)
9431:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9432:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9433:     *--------------------------------------------------------------------------
9434:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9435:         LOCAL loc_oBusca, loc_cAtual
9436:         IF par_nKeyCode = 115  && F4
9437:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9438:                 RETURN
9439:             ENDIF
9440:             TRY
9441:                 loc_cAtual = ""
9442:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9443:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9444:                 ENDIF
9445:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9446:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9447:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9448:                     "Buscar Matriz")
9449:                 IF VARTYPE(loc_oBusca) = "O"
9450:                     IF !loc_oBusca.this_lAchouRegistro
9451:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9452:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9453:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9454:                         loc_oBusca.Show()
9455:                     ENDIF
9456:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9457:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9458:                             SELECT cursor_4c_SigPrMtz
9459:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9460:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9461:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9462:                             ENDIF
9463:                         ENDIF
9464:                     ENDIF
9465:                     loc_oBusca.Release()
9466:                 ENDIF
9467:                 IF USED("cursor_4c_BuscaMatriz")
9468:                     USE IN cursor_4c_BuscaMatriz
9469:                 ENDIF
9470:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9471:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9472:                 ENDIF
9473:             CATCH TO loc_oErro
9474:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9475:             ENDTRY
9476:         ENDIF
9477:     ENDPROC
9478: 
9479:     *--------------------------------------------------------------------------
9480:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9481:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9482:     *--------------------------------------------------------------------------
9483:     PROCEDURE CmdIncluirFaseClick()
9484:         LOCAL loc_oPg, loc_nOrdem
9485:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9486:             RETURN
9487:         ENDIF
9488:         TRY
9489:             IF !USED("cursor_4c_GradFase")
9490:                 RETURN
9491:             ENDIF

*-- Linhas 9508 a 9533:
9508:             GO BOTTOM IN cursor_4c_GradFase
9509:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9510:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9511:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9512:                     loc_oPg.grd_4c_GradFase.Refresh()
9513:                     loc_oPg.grd_4c_GradFase.SetFocus()
9514:                 ENDIF
9515:             ENDIF
9516:         CATCH TO loc_oErro
9517:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9518:         ENDTRY
9519:     ENDPROC
9520: 
9521:     *--------------------------------------------------------------------------
9522:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9523:     * Legado: excluir.Click - DELETE e resequencia Ordems
9524:     *--------------------------------------------------------------------------
9525:     PROCEDURE CmdExcluirFaseClick()
9526:         LOCAL loc_oPg, loc_lResultado
9527:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9528:             RETURN
9529:         ENDIF
9530:         loc_lResultado = .T.
9531:         TRY
9532:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9533:                 loc_lResultado = .F.

*-- Linhas 9556 a 9580:
9556:                 ENDSCAN
9557:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9558:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9559:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9560:                         loc_oPg.grd_4c_GradFase.Refresh()
9561:                     ENDIF
9562:                 ENDIF
9563:             ENDIF
9564:         CATCH TO loc_oErro
9565:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9566:         ENDTRY
9567:     ENDPROC
9568: 
9569:     *--------------------------------------------------------------------------
9570:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9571:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9572:     *--------------------------------------------------------------------------
9573:     PROCEDURE CmdAlternativaFaseClick()
9574:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9575:         LOCAL loc_nOrdem
9576:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9577:             RETURN
9578:         ENDIF
9579:         loc_lResultado = .T.
9580:         TRY

*-- Linhas 9607 a 9631:
9607:                 GO BOTTOM IN cursor_4c_GradFase
9608:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9609:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9610:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9611:                         loc_oPg.grd_4c_GradFase.Refresh()
9612:                     ENDIF
9613:                 ENDIF
9614:             ENDIF
9615:         CATCH TO loc_oErro
9616:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9617:         ENDTRY
9618:     ENDPROC
9619: 
9620:     *--------------------------------------------------------------------------
9621:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9622:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9623:     *--------------------------------------------------------------------------
9624:     PROCEDURE CmdFichaClick()
9625:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9626:         loc_lResultado = .T.
9627:         TRY
9628:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9629:                 loc_lResultado = .F.
9630:             ENDIF
9631:             IF loc_lResultado

*-- Linhas 9641 a 9664:
9641:                 IF USED("CsCabecalho")
9642:                     USE IN CsCabecalho
9643:                 ENDIF
9644:                 CREATE CURSOR CsCabecalho (;
9645:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9646:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9647:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9648:                     _nPeso N(9,2))
9649:                 WITH THIS.this_oBusinessObject
9650:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9651:                         VALUES (loc_cNmEmp, ;
9652:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9653:                                 ALLTRIM(.this_cCpros), ;
9654:                                 ALLTRIM(.this_cDpros), ;
9655:                                 ALLTRIM(.this_cCgrus), ;
9656:                                 .this_nPesobs)
9657:                 ENDWITH
9658:                 *-- Verificar e executar relatorio
9659:                 LOCAL loc_cRepPath
9660:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9661:                 IF FILE(loc_cRepPath)
9662:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9663:                 ELSE
9664:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")

*-- Linhas 9794 a 9819:
9794:             ENDIF
9795:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9796:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9797:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9798:                     loc_oPg.grd_4c_Matrizes.Refresh()
9799:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9800:                 ENDIF
9801:             ENDIF
9802:         CATCH TO loc_oErro
9803:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9804:         ENDTRY
9805:     ENDPROC
9806: 
9807:     *--------------------------------------------------------------------------
9808:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9809:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9810:     *--------------------------------------------------------------------------
9811:     PROCEDURE BtnExcluiMtzClick()
9812:         LOCAL loc_oPg, loc_lResultado
9813:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9814:             RETURN
9815:         ENDIF
9816:         loc_lResultado = .T.
9817:         TRY
9818:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9819:                 loc_lResultado = .F.

*-- Linhas 9830 a 9855:
9830:             ENDIF
9831:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9832:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9833:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9834:                     loc_oPg.grd_4c_Matrizes.Refresh()
9835:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9836:                 ENDIF
9837:             ENDIF
9838:         CATCH TO loc_oErro
9839:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9840:         ENDTRY
9841:     ENDPROC
9842: 
9843:     *--------------------------------------------------------------------------
9844:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9845:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9846:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9847:     *--------------------------------------------------------------------------
9848:     PROCEDURE TxtCodacbLostFocus()
9849:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9850:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9851:             RETURN
9852:         ENDIF
9853:         loc_lResultado = .T.
9854:         TRY
9855:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"

*-- Linhas 9870 a 9894:
9870:                     "Buscar Acabamento")
9871:                 IF VARTYPE(loc_oBusca) = "O"
9872:                     IF !loc_oBusca.this_lAchouRegistro
9873:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9874:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9875:                         loc_oBusca.Show()
9876:                     ENDIF
9877:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9878:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9879:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9880:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9881:                     ELSE
9882:                         loc_oPg.txt_4c__codacb.Value = ""
9883:                         loc_oPg.txt_4c__Dacb.Value   = ""
9884:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9885:                     ENDIF
9886:                     loc_oBusca.Release()
9887:                 ENDIF
9888:                 IF USED("cursor_4c_BuscaAca")
9889:                     USE IN cursor_4c_BuscaAca
9890:                 ENDIF
9891:             ENDIF
9892:         CATCH TO loc_oErro
9893:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9894:         ENDTRY

*-- Linhas 9931 a 9955:
9931:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9932:                 IF VARTYPE(loc_oBusca) = "O"
9933:                     IF !loc_oBusca.this_lAchouRegistro
9934:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9935:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9936:                         loc_oBusca.Show()
9937:                     ENDIF
9938:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9939:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9940:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9941:                     ELSE
9942:                         loc_oPg.txt_4c_Tam.Value = ""
9943:                         THIS.this_oBusinessObject.this_cCodtams = ""
9944:                     ENDIF
9945:                     loc_oBusca.Release()
9946:                 ENDIF
9947:                 IF USED("cursor_4c_BuscaTam")
9948:                     USE IN cursor_4c_BuscaTam
9949:                 ENDIF
9950:             ENDIF
9951:         CATCH TO loc_oErro
9952:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9953:         ENDTRY
9954:     ENDPROC
9955: 

*-- Linhas 9990 a 10014:
9990:                     "Buscar Cor Padr" + CHR(227) + "o")
9991:                 IF VARTYPE(loc_oBusca) = "O"
9992:                     IF !loc_oBusca.this_lAchouRegistro
9993:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
9994:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9995:                         loc_oBusca.Show()
9996:                     ENDIF
9997:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
9998:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
9999:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
10000:                     ELSE
10001:                         loc_oPg.txt_4c_Cor.Value = ""
10002:                         THIS.this_oBusinessObject.this_cCodcors = ""
10003:                     ENDIF
10004:                     loc_oBusca.Release()
10005:                 ENDIF
10006:                 IF USED("cursor_4c_BuscaCor")
10007:                     USE IN cursor_4c_BuscaCor
10008:                 ENDIF
10009:             ENDIF
10010:         CATCH TO loc_oErro
10011:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
10012:         ENDTRY
10013:     ENDPROC
10014: 

*-- Linhas 10061 a 10084:
10061:                             "Buscar Conquilha")
10062:                         IF VARTYPE(loc_oBusca) = "O"
10063:                             IF !loc_oBusca.this_lAchouRegistro
10064:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10065:                                 loc_oBusca.Show()
10066:                             ENDIF
10067:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10068:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10069:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10070:                             ELSE
10071:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10072:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10073:                             ENDIF
10074:                             loc_oBusca.Release()
10075:                         ENDIF
10076:                         IF USED("cursor_4c_BuscaCnq")
10077:                             USE IN cursor_4c_BuscaCnq
10078:                         ENDIF
10079:                     ENDIF
10080:                     USE IN cursor_4c_ListaCnq
10081:                 ENDIF
10082:             ENDIF
10083:         CATCH TO loc_oErro
10084:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")

*-- Linhas 10100 a 10128:
10100:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10101:         *----------------------------------------------------------------------
10102:         IF !USED("cursor_4c_Cmv")
10103:             SET NULL ON
10104:             CREATE CURSOR cursor_4c_Cmv (;
10105:                 Datas   D, ;
10106:                 ValCuss N(12,3), ;
10107:                 Moedas  C(3))
10108:             SET NULL OFF
10109:         ENDIF
10110: 
10111:         *----------------------------------------------------------------------
10112:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10113:         *----------------------------------------------------------------------
10114:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10115:         WITH loc_oPg.lbl_4c_LblGruCus
10116:             .Caption   = "Grupo C.C. :"
10117:             .Top       = 165
10118:             .Left      = 138
10119:             .Width     = 63
10120:             .Height    = 15
10121:             .FontName  = "Tahoma"
10122:             .FontSize  = 8
10123:             .BackStyle = 0
10124:             .ForeColor = RGB(90, 90, 90)
10125:             .Visible   = .T.
10126:         ENDWITH
10127: 
10128:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")

*-- Linhas 10890 a 10956:
10890:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10891:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10892:         *----------------------------------------------------------------------
10893:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
10894:         WITH loc_oPg.grd_4c_Cmv
10895:             .Top         = 338
10896:             .Left        = 754
10897:             .Width       = 223
10898:             .Height      = 141
10899:             .ColumnCount = 3
10900:             .FontName    = "Tahoma"
10901:             .FontSize    = 8
10902:             .RowHeight   = 17
10903:             .DeleteMark  = .F.
10904:             .RecordMark  = .T.
10905:             .ReadOnly    = .T.
10906:             .ScrollBars  = 3
10907:             .Themes      = .F.
10908:             .Visible     = .T.
10909:         ENDWITH
10910:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10911:         WITH loc_oPg.grd_4c_Cmv
10912:             WITH .Column1
10913:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10914:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10915:                 .Header1.FontName = "Tahoma"
10916:                 .Header1.FontSize = 8
10917:                 .Width            = 59
10918:                 .Movable          = .F.
10919:                 .Resizable        = .F.
10920:                 .ReadOnly         = .T.
10921:             ENDWITH
10922:             WITH .Column2
10923:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10924:                 .Header1.Caption  = "Valor Custo GR"
10925:                 .Header1.FontName = "Tahoma"
10926:                 .Header1.FontSize = 8
10927:                 .Width            = 100
10928:                 .Movable          = .F.
10929:                 .Resizable        = .F.
10930:                 .ReadOnly         = .T.
10931:             ENDWITH
10932:             WITH .Column3
10933:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10934:                 .Header1.Caption  = "Moe"
10935:                 .Header1.FontName = "Tahoma"
10936:                 .Header1.FontSize = 8
10937:                 .Width            = 31
10938:                 .Movable          = .F.
10939:                 .Resizable        = .F.
10940:                 .ReadOnly         = .T.
10941:             ENDWITH
10942:         ENDWITH
10943:     ENDPROC
10944: 
10945:     *--------------------------------------------------------------------------
10946:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10947:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10948:     *--------------------------------------------------------------------------
10949:     PROTECTED PROCEDURE PreencherCamposFiscais()
10950:         LOCAL loc_oPg, loc_cIpiVal
10951:         TRY
10952:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10953:                 RETURN
10954:             ENDIF
10955:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10956:             IF VARTYPE(loc_oPg) # "O"

*-- Linhas 11148 a 11172:
11148:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11149:                 IF VARTYPE(loc_oBusca) = "O"
11150:                     IF !loc_oBusca.this_lAchouRegistro
11151:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11152:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11153:                         loc_oBusca.Show()
11154:                     ENDIF
11155:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11156:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11157:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11158:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11159:                         ENDIF
11160:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11161:                     ELSE
11162:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11163:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11164:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11165:                         ENDIF
11166:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11167:                     ENDIF
11168:                     loc_oBusca.Release()
11169:                 ENDIF
11170:                 IF USED("cursor_4c_BuscaClf")
11171:                     USE IN cursor_4c_BuscaClf
11172:                 ENDIF

*-- Linhas 11218 a 11242:
11218:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11219:                 IF VARTYPE(loc_oBusca) = "O"
11220:                     IF !loc_oBusca.this_lAchouRegistro
11221:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11222:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11223:                         loc_oBusca.Show()
11224:                     ENDIF
11225:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11226:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11227:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11228:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11229:                     ENDIF
11230:                     loc_oBusca.Release()
11231:                 ENDIF
11232:                 IF USED("cursor_4c_BuscaClfR")
11233:                     USE IN cursor_4c_BuscaClfR
11234:                 ENDIF
11235:             ENDIF
11236:         CATCH TO loc_oErro
11237:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11238:         ENDTRY
11239:     ENDPROC
11240: 
11241:     *--------------------------------------------------------------------------
11242:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)

*-- Linhas 11277 a 11301:
11277:                     "Buscar Origem da Mercadoria")
11278:                 IF VARTYPE(loc_oBusca) = "O"
11279:                     IF !loc_oBusca.this_lAchouRegistro
11280:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11281:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11282:                         loc_oBusca.Show()
11283:                     ENDIF
11284:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11285:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11286:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11287:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11288:                         ENDIF
11289:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11290:                     ELSE
11291:                         loc_oPg.txt_4c_Origmerc.Value = ""
11292:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11293:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11294:                         ENDIF
11295:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11296:                     ENDIF
11297:                     loc_oBusca.Release()
11298:                 ENDIF
11299:                 IF USED("cursor_4c_BuscaOrg")
11300:                     USE IN cursor_4c_BuscaOrg
11301:                 ENDIF

*-- Linhas 11344 a 11368:
11344:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11345:                 IF VARTYPE(loc_oBusca) = "O"
11346:                     IF !loc_oBusca.this_lAchouRegistro
11347:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11348:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11349:                         loc_oBusca.Show()
11350:                     ENDIF
11351:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11352:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11353:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11354:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11355:                         ENDIF
11356:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11357:                     ELSE
11358:                         loc_oPg.txt_4c_Sittricm.Value = ""
11359:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11360:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11361:                         ENDIF
11362:                         THIS.this_oBusinessObject.this_cSittricms = ""
11363:                     ENDIF
11364:                     loc_oBusca.Release()
11365:                 ENDIF
11366:                 IF USED("cursor_4c_BuscaIcm")
11367:                     USE IN cursor_4c_BuscaIcm
11368:                 ENDIF

*-- Linhas 11428 a 11452:
11428:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11429:                 IF VARTYPE(loc_oBusca) = "O"
11430:                     IF !loc_oBusca.this_lAchouRegistro
11431:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11432:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11433:                         loc_oBusca.Show()
11434:                     ENDIF
11435:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11436:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11437:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11438:                     ELSE
11439:                         loc_oPg.txt_4c_TpTrib.Value = ""
11440:                         THIS.this_oBusinessObject.this_cTptribs = ""
11441:                     ENDIF
11442:                     loc_oBusca.Release()
11443:                 ENDIF
11444:                 IF USED("cursor_4c_BuscaTri")
11445:                     USE IN cursor_4c_BuscaTri
11446:                 ENDIF
11447:             ENDIF
11448:         CATCH TO loc_oErro
11449:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11450:         ENDTRY
11451:     ENDPROC
11452: 

*-- Linhas 11514 a 11538:
11514:                     "Buscar Moeda")
11515:                 IF VARTYPE(loc_oBusca) = "O"
11516:                     IF !loc_oBusca.this_lAchouRegistro
11517:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11518:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11519:                         loc_oBusca.Show()
11520:                     ENDIF
11521:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11522:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11523:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11524:                     ELSE
11525:                         loc_oPg.txt_4c_Mvalor.Value = ""
11526:                         THIS.this_oBusinessObject.this_cMoedas = ""
11527:                     ENDIF
11528:                     loc_oBusca.Release()
11529:                 ENDIF
11530:                 IF USED("cursor_4c_BuscaMoeFisc")
11531:                     USE IN cursor_4c_BuscaMoeFisc
11532:                 ENDIF
11533:             ENDIF
11534:         CATCH TO loc_oErro
11535:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11536:         ENDTRY
11537:     ENDPROC
11538: 

*-- Linhas 11588 a 11612:
11588:                             "Buscar Metal")
11589:                         IF VARTYPE(loc_oBusca) = "O"
11590:                             IF !loc_oBusca.this_lAchouRegistro
11591:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11592:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11593:                                 loc_oBusca.Show()
11594:                             ENDIF
11595:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11596:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11597:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11598:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11599:                                 ENDIF
11600:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11601:                             ELSE
11602:                                 loc_oPg.txt_4c_Metal.Value = ""
11603:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11604:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11605:                                 ENDIF
11606:                                 THIS.this_oBusinessObject.this_cMetals = ""
11607:                             ENDIF
11608:                             loc_oBusca.Release()
11609:                         ENDIF
11610:                         IF USED("cursor_4c_BuscaMtlSel")
11611:                             USE IN cursor_4c_BuscaMtlSel
11612:                         ENDIF

*-- Linhas 11669 a 11693:
11669:                             "Buscar Teor")
11670:                         IF VARTYPE(loc_oBusca) = "O"
11671:                             IF !loc_oBusca.this_lAchouRegistro
11672:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11673:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11674:                                 loc_oBusca.Show()
11675:                             ENDIF
11676:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11677:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11678:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11679:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11680:                                 ENDIF
11681:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11682:                             ELSE
11683:                                 loc_oPg.txt_4c_Teor.Value = ""
11684:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11685:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11686:                                 ENDIF
11687:                                 THIS.this_oBusinessObject.this_cTeors = ""
11688:                             ENDIF
11689:                             loc_oBusca.Release()
11690:                         ENDIF
11691:                         IF USED("cursor_4c_BuscaTeorSel")
11692:                             USE IN cursor_4c_BuscaTeorSel
11693:                         ENDIF

*-- Linhas 11802 a 11843:
11802:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11803:         *----------------------------------------------------------------------
11804:         IF !USED("cursor_4c_SigPrTar")
11805:             SET NULL ON
11806:             CREATE CURSOR cursor_4c_SigPrTar (;
11807:                 DtInis  D NULL, ;
11808:                 DtFims  D NULL, ;
11809:                 Usuars  C(10), ;
11810:                 Tarefas C(10), ;
11811:                 ObsTars M)
11812:             SET NULL OFF
11813:         ENDIF
11814: 
11815:         *----------------------------------------------------------------------
11816:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11817:         *-- Campos: Arquivos
11818:         *----------------------------------------------------------------------
11819:         IF !USED("cursor_4c_SigPrArq")
11820:             SET NULL ON
11821:             CREATE CURSOR cursor_4c_SigPrArq (;
11822:                 Arquivos C(200))
11823:             SET NULL OFF
11824:         ENDIF
11825: 
11826:         *----------------------------------------------------------------------
11827:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11828:         *----------------------------------------------------------------------
11829:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11830:         WITH loc_oPg.shp_4c_ArqFundo
11831:             .Top         = 415
11832:             .Left        = 584
11833:             .Width       = 407
11834:             .Height      = 202
11835:             .BackColor   = RGB(230, 230, 230)
11836:             .BorderColor = RGB(180, 180, 180)
11837:             .Visible     = .T.
11838:         ENDWITH
11839: 
11840:         *----------------------------------------------------------------------
11841:         *-- Say31: "Observacao da Tarefa" (T:144 L:583 W:126 H:15)
11842:         *----------------------------------------------------------------------
11843:         loc_oPg.AddObject("lbl_4c_ObsTarLabel", "Label")

*-- Linhas 11859 a 11959:
11859:         *-- grdDesigner: Grade de Tarefas (T:160 L:10 W:495 H:238) 4 colunas
11860:         *-- Colunas: Data Inicio | Data Conclusao | Usuario | Tarefa
11861:         *-- Cols 1-3 readonly, Col4 editavel (quando usuario e dono e tarefa nao finalizada)
11862:         *----------------------------------------------------------------------
11863:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
11864:         WITH loc_oPg.grd_4c_Designer
11865:             .Top         = 160
11866:             .Left        = 10
11867:             .Width       = 495
11868:             .Height      = 238
11869:             .ColumnCount = 4
11870:             .FontName    = "Tahoma"
11871:             .FontSize    = 8
11872:             .DeleteMark  = .F.
11873:             .ScrollBars  = 2
11874:             .Themes      = .F.
11875:             .Visible     = .T.
11876:             .RecordMark   = .F.
11877:         ENDWITH
11878:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11879:         WITH loc_oPg.grd_4c_Designer
11880:             WITH .Column1
11881:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11882:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11883:                 .Header1.FontName  = "Tahoma"
11884:                 .Header1.FontSize  = 8
11885:                 .Header1.Alignment = 2
11886:                 .Width             = 140
11887:                 .Movable           = .F.
11888:                 .Resizable         = .F.
11889:                 .ReadOnly          = .T.
11890:                 .Alignment         = 2
11891:             ENDWITH
11892:             WITH .Column2
11893:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11894:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11895:                 .Header1.FontName  = "Tahoma"
11896:                 .Header1.FontSize  = 8
11897:                 .Header1.Alignment = 2
11898:                 .Width             = 140
11899:                 .Movable           = .F.
11900:                 .Resizable         = .F.
11901:                 .ReadOnly          = .T.
11902:                 .Alignment         = 2
11903:             ENDWITH
11904:             WITH .Column3
11905:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11906:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11907:                 .Header1.FontName  = "Tahoma"
11908:                 .Header1.FontSize  = 8
11909:                 .Header1.Alignment = 2
11910:                 .Width             = 90
11911:                 .Movable           = .F.
11912:                 .Resizable         = .F.
11913:                 .ReadOnly          = .T.
11914:             ENDWITH
11915:             WITH .Column4
11916:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11917:                 .Header1.Caption   = "Tarefa"
11918:                 .Header1.FontName  = "Tahoma"
11919:                 .Header1.FontSize  = 8
11920:                 .Header1.Alignment = 2
11921:                 .Width             = 90
11922:                 .Movable           = .F.
11923:                 .Resizable         = .F.
11924:                 .ReadOnly          = .F.
11925:             ENDWITH
11926:         ENDWITH
11927:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11928: 
11929:         *----------------------------------------------------------------------
11930:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11931:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11932:         *----------------------------------------------------------------------
11933:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11934:         WITH loc_oPg.obj_4c_ObsTarefas
11935:             .Top              = 160
11936:             .Left             = 584
11937:             .Width            = 407
11938:             .Height           = 238
11939:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11940:             .FontName         = "Tahoma"
11941:             .FontSize         = 8
11942:             .SpecialEffect    = 1
11943:             .ForeColor        = RGB(36, 84, 155)
11944:             .Enabled          = .T.
11945:             .Visible          = .T.
11946:         ENDWITH
11947: 
11948:         *----------------------------------------------------------------------
11949:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11950:         *----------------------------------------------------------------------
11951:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11952:         WITH loc_oPg.cmd_4c_IniTarefa
11953:             .Top             = 168
11954:             .Left            = 509
11955:             .Width           = 42
11956:             .Height          = 42
11957:             .Caption         = ""
11958:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11959:             .FontName        = "Tahoma"

*-- Linhas 11988 a 12041:
11988:         *----------------------------------------------------------------------
11989:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
11990:         *----------------------------------------------------------------------
11991:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
11992:         WITH loc_oPg.grd_4c_Arquivos
11993:             .Top         = 415
11994:             .Left        = 10
11995:             .Width       = 495
11996:             .Height      = 202
11997:             .ColumnCount = 1
11998:             .FontName    = "Tahoma"
11999:             .FontSize    = 8
12000:             .DeleteMark  = .F.
12001:             .ScrollBars  = 2
12002:             .ReadOnly    = .T.
12003:             .Themes      = .F.
12004:             .Visible     = .T.
12005:             .RecordMark   = .F.
12006:         ENDWITH
12007:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
12008:         WITH loc_oPg.grd_4c_Arquivos
12009:             WITH .Column1
12010:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12011:                 .Header1.Caption   = "Arquivos Para Designer"
12012:                 .Header1.FontName  = "Tahoma"
12013:                 .Header1.FontSize  = 8
12014:                 .Header1.Alignment = 2
12015:                 .Width             = 464
12016:                 .Movable           = .F.
12017:                 .Resizable         = .F.
12018:                 .ReadOnly          = .T.
12019:             ENDWITH
12020:         ENDWITH
12021:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12022: 
12023:         *----------------------------------------------------------------------
12024:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12025:         *----------------------------------------------------------------------
12026:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
12027:         WITH loc_oPg.cmd_4c_InsArqs
12028:             .Top             = 416
12029:             .Left            = 509
12030:             .Width           = 42
12031:             .Height          = 42
12032:             .Caption         = ""
12033:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
12034:             .FontName        = "Tahoma"
12035:             .FontSize        = 8
12036:             .Themes          = .F.
12037:             .ToolTipText     = "Inserir Arquivo"
12038:             .Enabled         = .F.
12039:             .Visible         = .T.
12040:         ENDWITH
12041:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")

*-- Linhas 12096 a 12139:
12096:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
12097: 
12098:         *----------------------------------------------------------------------
12099:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
12100:         *----------------------------------------------------------------------
12101:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12102:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12103:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12104: 
12105:         *----------------------------------------------------------------------
12106:         *-- Binding When para EditBox Obs da Tarefa
12107:         *----------------------------------------------------------------------
12108:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12109: 
12110:         *----------------------------------------------------------------------
12111:         *-- Bindings When para botoes de tarefa
12112:         *----------------------------------------------------------------------
12113:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12114:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12115: 
12116:         *----------------------------------------------------------------------
12117:         *-- Binding When para Column1 do grdArquivos
12118:         *----------------------------------------------------------------------
12119:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12120: 
12121:         *----------------------------------------------------------------------
12122:         *-- Bindings When para botoes de arquivo
12123:         *----------------------------------------------------------------------
12124:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12125:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12126:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12127:     ENDPROC
12128: 
12129:     *--------------------------------------------------------------------------
12130:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12131:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12132:     *--------------------------------------------------------------------------
12133:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12134:         LOCAL loc_oPg
12135:         TRY
12136:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12137:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12138:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12139:                     *-- Sincronizar editbox com observacao da tarefa selecionada

*-- Linhas 12226 a 12249:
12226:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12227:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12228:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12229:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12230:                 ENDIF
12231:             ENDIF
12232:         CATCH TO loc_oErro
12233:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12234:         ENDTRY
12235:     ENDPROC
12236: 
12237:     *--------------------------------------------------------------------------
12238:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12239:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12240:     *--------------------------------------------------------------------------
12241:     PROCEDURE BtnFimTarefaClick()
12242:         LOCAL loc_lResultado
12243:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12244:             RETURN
12245:         ENDIF
12246:         loc_lResultado = .T.
12247:         TRY
12248:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12249:                 loc_lResultado = .F.

*-- Linhas 12264 a 12315:
12264:                 SELECT cursor_4c_SigPrTar
12265:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12266:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12267:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12268:                 ENDIF
12269:             ENDIF
12270:         CATCH TO loc_oErro
12271:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12272:         ENDTRY
12273:     ENDPROC
12274: 
12275:     *--------------------------------------------------------------------------
12276:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12277:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12278:     *--------------------------------------------------------------------------
12279:     PROCEDURE BtnInsArqsClick()
12280:         LOCAL loc_cArq, loc_lResultado
12281:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12282:             RETURN
12283:         ENDIF
12284:         loc_lResultado = .T.
12285:         TRY
12286:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12287:             IF EMPTY(loc_cArq)
12288:                 loc_lResultado = .F.
12289:             ENDIF
12290:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12291:                 SELECT cursor_4c_SigPrArq
12292:                 APPEND BLANK
12293:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12294:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12295:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12296:                 ENDIF
12297:             ENDIF
12298:         CATCH TO loc_oErro
12299:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12300:         ENDTRY
12301:     ENDPROC
12302: 
12303:     *--------------------------------------------------------------------------
12304:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12305:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12306:     *--------------------------------------------------------------------------
12307:     PROCEDURE BtnOpnArqsClick()
12308:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12309:         loc_lResultado = .T.
12310:         TRY
12311:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12312:                 loc_lResultado = .F.
12313:             ENDIF
12314:             IF loc_lResultado
12315:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))

*-- Linhas 12361 a 12384:
12361:                     SKIP -1
12362:                 ENDIF
12363:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12364:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12365:                 ENDIF
12366:                 *-- Limpar imagem ao excluir arquivo
12367:                 LOCAL loc_oPg
12368:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12369:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12370:                     CLEAR RESOURCES
12371:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12372:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12373:                 ENDIF
12374:             ENDIF
12375:         CATCH TO loc_oErro
12376:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12377:         ENDTRY
12378:     ENDPROC
12379: 
12380:     *--------------------------------------------------------------------------
12381:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12382:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12383:     *--------------------------------------------------------------------------
12384:     PROCEDURE ImgArqJpgClick()

*-- Linhas 12419 a 12513:
12419: 
12420:     *--------------------------------------------------------------------------
12421:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12422:     * Legado: grdDesigner.Column4.Text1.When
12423:     *--------------------------------------------------------------------------
12424:     PROCEDURE GrdDesignerCol4When()
12425:         LOCAL loc_lResult
12426:         loc_lResult = .F.
12427:         TRY
12428:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12429:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12430:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12431:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12432:                         loc_lResult = .T.
12433:                     ENDIF
12434:                 ENDIF
12435:             ENDIF
12436:         CATCH TO loc_oErro
12437:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12438:         ENDTRY
12439:         RETURN loc_lResult
12440:     ENDPROC
12441: 
12442:     *--------------------------------------------------------------------------
12443:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12444:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12445:     *--------------------------------------------------------------------------
12446:     PROCEDURE GrdDesignerCol4Valid()
12447:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12448:         loc_lResult = .T.
12449:         TRY
12450:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12451:                 loc_lResultado = .T.
12452:             ENDIF
12453:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12454:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12455:             IF !EMPTY(loc_cCodigo)
12456:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12457:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12458:                     "Buscar Tarefa")
12459:                 IF VARTYPE(loc_oBusca) = "O"
12460:                     IF !loc_oBusca.this_lAchouRegistro
12461:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12462:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12463:                         loc_oBusca.Show()
12464:                     ENDIF
12465:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12466:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12467:                     ELSE
12468:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12469:                     ENDIF
12470:                     loc_oBusca.Release()
12471:                 ENDIF
12472:                 IF USED("cursor_4c_BuscaTar")
12473:                     USE IN cursor_4c_BuscaTar
12474:                 ENDIF
12475:             ENDIF
12476:         CATCH TO loc_oErro
12477:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12478:         ENDTRY
12479:         RETURN loc_lResult
12480:     ENDPROC
12481: 
12482:     *--------------------------------------------------------------------------
12483:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12484:     * Legado: grdDesigner.Column4.Text1.LostFocus
12485:     *--------------------------------------------------------------------------
12486:     PROCEDURE GrdDesignerCol4LostFocus()
12487:         LOCAL loc_oPg
12488:         TRY
12489:             IF LASTKEY() = 13
12490:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12491:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12492:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12493:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12494:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12495:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12496:                             ENDIF
12497:                         ENDIF
12498:                     ENDIF
12499:                 ENDIF
12500:             ENDIF
12501:         CATCH TO loc_oErro
12502:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12503:         ENDTRY
12504:     ENDPROC
12505: 
12506:     *--------------------------------------------------------------------------
12507:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12508:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12509:     *--------------------------------------------------------------------------
12510:     PROCEDURE ObsTarefasWhen()
12511:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12512:     ENDPROC
12513: 

*-- Linhas 12528 a 12552:
12528:     ENDPROC
12529: 
12530:     *--------------------------------------------------------------------------
12531:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12532:     * Legado: grdArquivos.Column1.Text1.When
12533:     *--------------------------------------------------------------------------
12534:     PROCEDURE GrdArquivosCol1When()
12535:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12536:     ENDPROC
12537: 
12538:     *--------------------------------------------------------------------------
12539:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12540:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12541:     *--------------------------------------------------------------------------
12542:     PROCEDURE BtnInsArqsWhen()
12543:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12544:     ENDPROC
12545: 
12546:     *--------------------------------------------------------------------------
12547:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12548:     * Legado: btnOpnArqs.When - Return .t.
12549:     *--------------------------------------------------------------------------
12550:     PROCEDURE BtnOpnArqsWhen()
12551:         RETURN .T.
12552:     ENDPROC

