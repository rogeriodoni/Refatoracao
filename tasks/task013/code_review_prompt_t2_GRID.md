# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 10927: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 11895: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 12024: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS GRID (12589 linhas total):

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

*-- Linhas 3628 a 3653:
3628:         TRY
3629:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
3630: 
3631:             loc_oBusca.mAddColuna("cpros", "", "Produto")
3632:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3633:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3634: 
3635:             loc_oBusca.Show()
3636: 
3637:             IF loc_oBusca.this_lSelecionou
3638:                 IF USED("cursor_4c_Busca")
3639:                     LOCAL loc_cCodigo
3640:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
3641: 
3642:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3643:                         THIS.BOParaForm()
3644:                         THIS.this_cModoAtual = "VISUALIZAR"
3645:                         THIS.HabilitarCampos(.F.)
3646:                         THIS.AlternarPagina(2)
3647:                     ENDIF
3648:                 ENDIF
3649:             ENDIF
3650: 
3651:             IF USED("cursor_4c_Busca")
3652:                 USE IN cursor_4c_Busca
3653:             ENDIF

*-- Linhas 4773 a 4797:
4773:                     ENDIF
4774:                 ELSE
4775:                     IF !loc_oBusca.this_lAchouRegistro
4776:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
4777:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4778:                     loc_oBusca.Show()
4779:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
4780:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4781:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4782:                         loc_oPg.txt_4c_CSGru.Value = ""
4783:                         loc_oPg.txt_4c_DsGru.Value = ""
4784:                     ENDIF
4785:                     ENDIF
4786:                 ENDIF
4787:                 loc_oBusca.Release()
4788:             ENDIF
4789:             IF USED("cursor_4c_BuscaGruP")
4790:                 USE IN cursor_4c_BuscaGruP
4791:             ENDIF
4792:         CATCH TO loc_oErro
4793:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
4794:         ENDTRY
4795:     ENDPROC
4796: 
4797:     *--------------------------------------------------------------------------

*-- Linhas 4856 a 4880:
4856:                     ENDIF
4857:                 ELSE
4858:                     IF !loc_oBusca.this_lAchouRegistro
4859:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4860:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4861:                     loc_oBusca.Show()
4862:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4863:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4864:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4865:                     ENDIF
4866:                     ENDIF
4867:                 ENDIF
4868:                 loc_oBusca.Release()
4869:             ENDIF
4870:             IF USED("cursor_4c_BuscaSGru")
4871:                 USE IN cursor_4c_BuscaSGru
4872:             ENDIF
4873:         CATCH TO loc_oErro
4874:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
4875:         ENDTRY
4876:     ENDPROC
4877: 
4878:     *--------------------------------------------------------------------------
4879:     * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
4880:     *--------------------------------------------------------------------------

*-- Linhas 4933 a 4957:
4933:                     ENDIF
4934:                 ELSE
4935:                     IF !loc_oBusca.this_lAchouRegistro
4936:                     loc_oBusca.mAddColuna("linhas", "", "Linha")
4937:                     loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4938:                     loc_oBusca.Show()
4939:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
4940:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4941:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4942:                     ENDIF
4943:                     ENDIF
4944:                 ENDIF
4945:                 loc_oBusca.Release()
4946:             ENDIF
4947:             IF USED("cursor_4c_BuscaLin")
4948:                 USE IN cursor_4c_BuscaLin
4949:             ENDIF
4950:         CATCH TO loc_oErro
4951:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
4952:         ENDTRY
4953:     ENDPROC
4954: 
4955:     *--------------------------------------------------------------------------
4956:     * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
4957:     *--------------------------------------------------------------------------

*-- Linhas 5010 a 5034:
5010:                     ENDIF
5011:                 ELSE
5012:                     IF !loc_oBusca.this_lAchouRegistro
5013:                     loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
5014:                     loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
5015:                     loc_oBusca.Show()
5016:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5017:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
5018:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
5019:                     ENDIF
5020:                     ENDIF
5021:                 ENDIF
5022:                 loc_oBusca.Release()
5023:             ENDIF
5024:             IF USED("cursor_4c_BuscaCol")
5025:                 USE IN cursor_4c_BuscaCol
5026:             ENDIF
5027:         CATCH TO loc_oErro
5028:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
5029:         ENDTRY
5030:     ENDPROC
5031: 
5032:     *--------------------------------------------------------------------------
5033:     * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
5034:     *--------------------------------------------------------------------------

*-- Linhas 5087 a 5111:
5087:                     ENDIF
5088:                 ELSE
5089:                     IF !loc_oBusca.this_lAchouRegistro
5090:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5091:                     loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
5092:                     loc_oBusca.Show()
5093:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5094:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5095:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5096:                     ENDIF
5097:                     ENDIF
5098:                 ENDIF
5099:                 loc_oBusca.Release()
5100:             ENDIF
5101:             IF USED("cursor_4c_BuscaIfor")
5102:                 USE IN cursor_4c_BuscaIfor
5103:             ENDIF
5104:         CATCH TO loc_oErro
5105:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
5106:         ENDTRY
5107:     ENDPROC
5108: 
5109:     *--------------------------------------------------------------------------
5110:     * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
5111:     *--------------------------------------------------------------------------

*-- Linhas 5159 a 5183:
5159:                     ENDIF
5160:                 ELSE
5161:                     IF !loc_oBusca.this_lAchouRegistro
5162:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
5163:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
5164:                     loc_oBusca.Show()
5165:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
5166:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5167:                     ENDIF
5168:                     ENDIF
5169:                 ENDIF
5170:                 loc_oBusca.Release()
5171:             ENDIF
5172:             IF USED("cursor_4c_BuscaProEq")
5173:                 USE IN cursor_4c_BuscaProEq
5174:             ENDIF
5175:         CATCH TO loc_oErro
5176:             MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
5177:         ENDTRY
5178:     ENDPROC
5179: 
5180:     *--------------------------------------------------------------------------
5181:     * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
5182:     *--------------------------------------------------------------------------
5183:     PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5205 a 5228:
5205:                 IF VARTYPE(loc_oBusca) = "O"
5206:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5207:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5208:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5209:                     loc_oBusca.Show()
5210:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5211:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5212:                     ENDIF
5213:                     loc_oBusca.Release()
5214:                 ENDIF
5215:             ENDIF
5216: 
5217:             IF USED("cursor_4c_BuscaCnj")
5218:                 USE IN cursor_4c_BuscaCnj
5219:             ENDIF
5220:         CATCH TO loc_oErro
5221:             MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
5222:         ENDTRY
5223:     ENDPROC
5224: 
5225:     *==========================================================================
5226:     * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
5227:     *==========================================================================
5228: 

*-- Linhas 6835 a 6859:
6835:                     ENDIF
6836:                 ELSE
6837:                     IF !loc_oBusca.this_lAchouRegistro
6838:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6839:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6840:                     loc_oBusca.Show()
6841:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6842:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6843:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6844:                     ENDIF
6845:                     ENDIF
6846:                 ENDIF
6847:                 loc_oBusca.Release()
6848:             ENDIF
6849:             IF USED("cursor_4c_BuscaUni")
6850:                 USE IN cursor_4c_BuscaUni
6851:             ENDIF
6852:         CATCH TO loc_oErro
6853:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6854:         ENDTRY
6855:     ENDPROC
6856: 
6857:     *--------------------------------------------------------------------------
6858:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6859:     *--------------------------------------------------------------------------

*-- Linhas 6912 a 6936:
6912:                     ENDIF
6913:                 ELSE
6914:                     IF !loc_oBusca.this_lAchouRegistro
6915:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6916:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6917:                     loc_oBusca.Show()
6918:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6919:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6920:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6921:                     ENDIF
6922:                     ENDIF
6923:                 ENDIF
6924:                 loc_oBusca.Release()
6925:             ENDIF
6926:             IF USED("cursor_4c_BuscaUnip")
6927:                 USE IN cursor_4c_BuscaUnip
6928:             ENDIF
6929:         CATCH TO loc_oErro
6930:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6931:         ENDTRY
6932:     ENDPROC
6933: 
6934:     *--------------------------------------------------------------------------
6935:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6936:     *--------------------------------------------------------------------------

*-- Linhas 6989 a 7013:
6989:                     ENDIF
6990:                 ELSE
6991:                     IF !loc_oBusca.this_lAchouRegistro
6992:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6993:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6994:                     loc_oBusca.Show()
6995:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6996:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6997:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6998:                     ENDIF
6999:                     ENDIF
7000:                 ENDIF
7001:                 loc_oBusca.Release()
7002:             ENDIF
7003:             IF USED("cursor_4c_BuscaFinP")
7004:                 USE IN cursor_4c_BuscaFinP
7005:             ENDIF
7006:         CATCH TO loc_oErro
7007:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
7008:         ENDTRY
7009:     ENDPROC
7010: 
7011:     *--------------------------------------------------------------------------
7012:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
7013:     *--------------------------------------------------------------------------

*-- Linhas 7066 a 7090:
7066:                     ENDIF
7067:                 ELSE
7068:                     IF !loc_oBusca.this_lAchouRegistro
7069:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7070:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7071:                     loc_oBusca.Show()
7072:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7073:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7074:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7075:                     ENDIF
7076:                     ENDIF
7077:                 ENDIF
7078:                 loc_oBusca.Release()
7079:             ENDIF
7080:             IF USED("cursor_4c_BuscaAcb")
7081:                 USE IN cursor_4c_BuscaAcb
7082:             ENDIF
7083:         CATCH TO loc_oErro
7084:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7085:         ENDTRY
7086:     ENDPROC
7087: 
7088:     *--------------------------------------------------------------------------
7089:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7090:     * SigCdCls: filtrado por cgrus do grupo de produto corrente

*-- Linhas 7148 a 7172:
7148:                     ENDIF
7149:                 ELSE
7150:                     IF !loc_oBusca.this_lAchouRegistro
7151:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7152:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7153:                     loc_oBusca.Show()
7154:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7155:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7156:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7157:                     ENDIF
7158:                     ENDIF
7159:                 ENDIF
7160:                 loc_oBusca.Release()
7161:             ENDIF
7162:             IF USED("cursor_4c_BuscaClass")
7163:                 USE IN cursor_4c_BuscaClass
7164:             ENDIF
7165:         CATCH TO loc_oErro
7166:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7167:         ENDTRY
7168:     ENDPROC
7169: 
7170:     *--------------------------------------------------------------------------
7171:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7172:     *--------------------------------------------------------------------------

*-- Linhas 7220 a 7244:
7220:                     ENDIF
7221:                 ELSE
7222:                     IF !loc_oBusca.this_lAchouRegistro
7223:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7224:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7225:                     loc_oBusca.Show()
7226:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7227:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7228:                     ENDIF
7229:                     ENDIF
7230:                 ENDIF
7231:                 loc_oBusca.Release()
7232:             ENDIF
7233:             IF USED("cursor_4c_BuscaLocal")
7234:                 USE IN cursor_4c_BuscaLocal
7235:             ENDIF
7236:         CATCH TO loc_oErro
7237:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7238:         ENDTRY
7239:     ENDPROC
7240: 
7241:     *==========================================================================
7242:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7243:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7244:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

*-- Linhas 7255 a 7411:
7255:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7256:         *----------------------------------------------------------------------
7257:         IF !USED("cursor_4c_GrdCons")
7258:             SET NULL ON
7259:             CREATE CURSOR cursor_4c_GrdCons (;
7260:                 mats      C(14), ;
7261:                 qtds      N(12,4), ;
7262:                 unicompos C(5), ;
7263:                 Grupos    C(3), ;
7264:                 Descrs    C(65), ;
7265:                 Ordems    N(5,0), ;
7266:                 consumo   N(12,4), ;
7267:                 Cods      C(5), ;
7268:                 dcats     C(65), ;
7269:                 Dopes     C(5))
7270:             SET NULL OFF
7271:         ENDIF
7272: 
7273:         *----------------------------------------------------------------------
7274:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7275:         *----------------------------------------------------------------------
7276:         IF !USED("cursor_4c_GrDTEMP")
7277:             SET NULL ON
7278:             CREATE CURSOR cursor_4c_GrDTEMP (;
7279:                 agrup C(30), ;
7280:                 tempo N(12,4))
7281:             SET NULL OFF
7282:         ENDIF
7283: 
7284:         *----------------------------------------------------------------------
7285:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7286:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7287:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7288:         *----------------------------------------------------------------------
7289:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7290:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7291: 
7292:         WITH loc_oGrd
7293:             .Top              = 155
7294:             .Left             = 6
7295:             .Width            = 987
7296:             .Height           = 362
7297:             .FontName         = "Tahoma"
7298:             .FontSize         = 8
7299:             .ColumnCount      = 9
7300:             .GridLines        = 3
7301:             .GridLineWidth    = 1
7302:             .GridLineColor    = RGB(238, 238, 238)
7303:             .RecordMark       = .F.
7304:             .DeleteMark       = .F.
7305:             .AllowRowSizing   = .F.
7306:             .ReadOnly         = .F.
7307:             .BackColor        = RGB(255, 255, 255)
7308:             .ForeColor        = RGB(90, 90, 90)
7309:             .HighlightBackColor = RGB(220, 230, 242)
7310:             .HighlightForeColor = RGB(15, 41, 104)
7311:             .HighlightStyle   = 2
7312:             .RowHeight        = 16
7313:             .ScrollBars       = 2
7314:             .Themes           = .F.
7315:             .Visible          = .T.
7316:         ENDWITH
7317: 
7318:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7319:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7320: 
7321:         *-- Configurar colunas APOS RecordSource
7322:         WITH loc_oPg.grd_4c_GrdCons
7323:             *-- Col1: Componente (mats C14) W:140 - readonly
7324:             .Column1.Header1.Caption = "Componente"
7325:             .Column1.Width           = 140
7326:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7327:             .Column1.Alignment       = 0
7328:             .Column1.ReadOnly        = .T.
7329: 
7330:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7331:             .Column2.Header1.Caption = "Qtde."
7332:             .Column2.Width           = 70
7333:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7334:             .Column2.Alignment       = 1
7335:             .Column2.ReadOnly        = .T.
7336: 
7337:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7338:             .Column3.Header1.Caption = "Uni"
7339:             .Column3.Width           = 40
7340:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7341:             .Column3.Alignment       = 0
7342:             .Column3.ReadOnly        = .T.
7343: 
7344:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7345:             .Column4.Header1.Caption = "Fase"
7346:             .Column4.Width           = 45
7347:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7348:             .Column4.Alignment       = 0
7349:             .Column4.ReadOnly        = .F.
7350: 
7351:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7352:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7353:             .Column5.Width           = 250
7354:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7355:             .Column5.Alignment       = 0
7356:             .Column5.ReadOnly        = .F.
7357: 
7358:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7359:             .Column6.Header1.Caption = "Ord."
7360:             .Column6.Width           = 40
7361:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7362:             .Column6.Alignment       = 1
7363:             .Column6.ReadOnly        = .T.
7364: 
7365:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7366:             .Column7.Header1.Caption = "Consumo"
7367:             .Column7.Width           = 80
7368:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7369:             .Column7.Alignment       = 1
7370:             .Column7.ReadOnly        = .F.
7371: 
7372:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7373:             .Column8.Header1.Caption = "Cat."
7374:             .Column8.Width           = 45
7375:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7376:             .Column8.Alignment       = 0
7377:             .Column8.ReadOnly        = .F.
7378: 
7379:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7380:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7381:             .Column9.Width           = 277
7382:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7383:             .Column9.Alignment       = 0
7384:             .Column9.ReadOnly        = .F.
7385:         ENDWITH
7386: 
7387:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7388:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7389:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7390:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7391:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7392: 
7393:         *----------------------------------------------------------------------
7394:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7395:         *----------------------------------------------------------------------
7396:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7397:         WITH loc_oPg.lbl_4c_Label7
7398:             .Caption   = "Qtde Componentes : "
7399:             .Top       = 523
7400:             .Left      = 25
7401:             .Width     = 105
7402:             .Height    = 15
7403:             .FontName  = "Tahoma"
7404:             .FontSize  = 8
7405:             .BackStyle = 0
7406:             .ForeColor = RGB(90, 90, 90)
7407:             .Visible   = .T.
7408:         ENDWITH
7409: 
7410:         *----------------------------------------------------------------------
7411:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)

*-- Linhas 7470 a 7706:
7470:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.grDTEMP
7471:         *-- Cols: Agrupamento, Tempo %  (ambas read-only)
7472:         *----------------------------------------------------------------------
7473:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
7474: 
7475:         WITH loc_oPg.grd_4c_GrDTEMP
7476:             .Top              = 519
7477:             .Left             = 821
7478:             .Width            = 172
7479:             .Height           = 107
7480:             .FontName         = "Tahoma"
7481:             .FontSize         = 8
7482:             .ColumnCount      = 2
7483:             .GridLines        = 3
7484:             .GridLineWidth    = 1
7485:             .GridLineColor    = RGB(238, 238, 238)
7486:             .RecordMark       = .F.
7487:             .DeleteMark       = .F.
7488:             .AllowRowSizing   = .F.
7489:             .ReadOnly         = .T.
7490:             .BackColor        = RGB(255, 255, 255)
7491:             .ForeColor        = RGB(90, 90, 90)
7492:             .HighlightBackColor = RGB(220, 230, 242)
7493:             .HighlightForeColor = RGB(15, 41, 104)
7494:             .HighlightStyle   = 2
7495:             .RowHeight        = 16
7496:             .ScrollBars       = 2
7497:             .Themes           = .F.
7498:             .Visible          = .T.
7499:         ENDWITH
7500: 
7501:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7502:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7503: 
7504:         *-- Configurar colunas do grDTEMP APOS RecordSource
7505:         WITH loc_oPg.grd_4c_GrDTEMP
7506:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7507:             .Column1.Header1.Caption = "Agrupamento"
7508:             .Column1.Width           = 100
7509:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7510:             .Column1.Alignment       = 0
7511:             .Column1.ReadOnly        = .T.
7512: 
7513:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7514:             .Column2.Header1.Caption = "Tempo %"
7515:             .Column2.Width           = 72
7516:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7517:             .Column2.Alignment       = 1
7518:             .Column2.ReadOnly        = .T.
7519:         ENDWITH
7520: 
7521:     ENDPROC
7522: 
7523:     *==========================================================================
7524:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7525:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7526:     *==========================================================================
7527: 
7528:     *--------------------------------------------------------------------------
7529:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7530:     *--------------------------------------------------------------------------
7531:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7532:         TRY
7533:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7534:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7535:             ENDIF
7536:         CATCH TO loc_oErro
7537:             *-- silencioso: refresh de navegacao nao deve bloquear
7538:         ENDTRY
7539:     ENDPROC
7540: 
7541:     *--------------------------------------------------------------------------
7542:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7543:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7544:     *--------------------------------------------------------------------------
7545:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7546:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7547:         IF par_nKeyCode = 115  && F4
7548:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7549:                 RETURN
7550:             ENDIF
7551:             TRY
7552:                 loc_cAtual = ""
7553:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7554:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7555:                 ENDIF
7556:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7557:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7558:                     "Buscar Fase")
7559:                 IF VARTYPE(loc_oBusca) = "O"
7560:                     IF !loc_oBusca.this_lAchouRegistro
7561:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7562:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7563:                         loc_oBusca.Show()
7564:                     ENDIF
7565:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7566:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7567:                             SELECT cursor_4c_GrdCons
7568:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7569:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7570:                         ENDIF
7571:                     ENDIF
7572:                     loc_oBusca.Release()
7573:                 ENDIF
7574:                 IF USED("cursor_4c_BuscaPrf")
7575:                     USE IN cursor_4c_BuscaPrf
7576:                 ENDIF
7577:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7578:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7579:                 ENDIF
7580:             CATCH TO loc_oErro
7581:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7582:             ENDTRY
7583:         ENDIF
7584:     ENDPROC
7585: 
7586:     *--------------------------------------------------------------------------
7587:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7588:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7589:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7590:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7591:     *--------------------------------------------------------------------------
7592:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7593:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7594:         IF par_nKeyCode = 115  && F4
7595:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7596:                 RETURN
7597:             ENDIF
7598:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7599:             loc_cGrupos = ""
7600:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7601:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7602:             ENDIF
7603:             IF !EMPTY(loc_cGrupos)
7604:                 RETURN
7605:             ENDIF
7606:             TRY
7607:                 loc_cAtual = ""
7608:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7609:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7610:                 ENDIF
7611:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7612:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7613:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7614:                 IF VARTYPE(loc_oBusca) = "O"
7615:                     IF !loc_oBusca.this_lAchouRegistro
7616:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7617:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7618:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7619:                         loc_oBusca.Show()
7620:                     ENDIF
7621:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7622:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7623:                             SELECT cursor_4c_GrdCons
7624:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7625:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7626:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7627:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7628:                             ENDIF
7629:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7630:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7631:                             ENDIF
7632:                         ENDIF
7633:                     ENDIF
7634:                     loc_oBusca.Release()
7635:                 ENDIF
7636:                 IF USED("cursor_4c_BuscaPrf2")
7637:                     USE IN cursor_4c_BuscaPrf2
7638:                 ENDIF
7639:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7640:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7641:                 ENDIF
7642:             CATCH TO loc_oErro
7643:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7644:             ENDTRY
7645:         ENDIF
7646:     ENDPROC
7647: 
7648:     *--------------------------------------------------------------------------
7649:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7650:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7651:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7652:     *--------------------------------------------------------------------------
7653:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7654:         LOCAL loc_oBusca, loc_cAtual
7655:         IF par_nKeyCode = 115  && F4
7656:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7657:                 RETURN
7658:             ENDIF
7659:             TRY
7660:                 loc_cAtual = ""
7661:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7662:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7663:                 ENDIF
7664:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7665:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7666:                     "Buscar Categoria")
7667:                 IF VARTYPE(loc_oBusca) = "O"
7668:                     IF !loc_oBusca.this_lAchouRegistro
7669:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7670:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7671:                         loc_oBusca.Show()
7672:                     ENDIF
7673:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7674:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7675:                             SELECT cursor_4c_GrdCons
7676:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7677:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7678:                         ENDIF
7679:                     ENDIF
7680:                     loc_oBusca.Release()
7681:                 ENDIF
7682:                 IF USED("cursor_4c_BuscaCat")
7683:                     USE IN cursor_4c_BuscaCat
7684:                 ENDIF
7685:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7686:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7687:                 ENDIF
7688:             CATCH TO loc_oErro
7689:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7690:             ENDTRY
7691:         ENDIF
7692:     ENDPROC
7693: 
7694:     *==========================================================================
7695:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7696:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7697:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7698:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7699:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7700:     *==========================================================================
7701:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7702:         LOCAL loc_oPg, loc_oGrd
7703: 
7704:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7705: 
7706:         *----------------------------------------------------------------------

*-- Linhas 7749 a 7874:
7749:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7750:         *--          Observacao, Etiq, Consumo, Qtd, Un
7751:         *----------------------------------------------------------------------
7752:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7753:         WITH loc_oPg.grd_4c_CustoCompo
7754:             .Top               = 178
7755:             .Left              = 34
7756:             .Width             = 813
7757:             .Height            = 230
7758:             .ColumnCount       = 12
7759:             .FontName          = "Verdana"
7760:             .FontSize          = 8
7761:             .GridLines         = 3
7762:             .GridLineWidth     = 1
7763:             .GridLineColor     = RGB(238, 238, 238)
7764:             .RecordMark        = .F.
7765:             .DeleteMark        = .F.
7766:             .AllowRowSizing    = .F.
7767:             .ReadOnly          = .F.
7768:             .BackColor         = RGB(255, 255, 255)
7769:             .ForeColor         = RGB(90, 90, 90)
7770:             .HighlightBackColor = RGB(220, 230, 242)
7771:             .HighlightForeColor = RGB(15, 41, 104)
7772:             .HighlightStyle    = 2
7773:             .RowHeight         = 16
7774:             .ScrollBars        = 2
7775:             .Visible           = .T.
7776:         ENDWITH
7777: 
7778:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7779:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7780: 
7781:         *-- Configurar colunas APOS RecordSource
7782:         WITH loc_oPg.grd_4c_CustoCompo
7783:             *-- Col1: Item/Material (C14) W:80
7784:             .Column1.Header1.Caption   = "Item"
7785:             .Column1.Width             = 80
7786:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7787:             .Column1.Alignment         = 0
7788: 
7789:             *-- Col2: Descricao (C65) W:185
7790:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7791:             .Column2.Width             = 185
7792:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7793:             .Column2.Alignment         = 0
7794: 
7795:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7796:             .Column3.Header1.Caption   = "Un"
7797:             .Column3.Width             = 35
7798:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7799:             .Column3.ReadOnly          = .T.
7800: 
7801:             *-- Col4: Valor (N12,4) W:65
7802:             .Column4.Header1.Caption   = "Valor"
7803:             .Column4.Width             = 65
7804:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7805:             .Column4.Alignment         = 1
7806: 
7807:             *-- Col5: Qtd (N12,4) W:55
7808:             .Column5.Header1.Caption   = "Qtd"
7809:             .Column5.Width             = 55
7810:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7811:             .Column5.Alignment         = 1
7812: 
7813:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7814:             .Column6.Header1.Caption   = "Total"
7815:             .Column6.Width             = 65
7816:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7817:             .Column6.Alignment         = 1
7818:             .Column6.ReadOnly          = .T.
7819: 
7820:             *-- Col7: Moe/Moeda (C5) W:35
7821:             .Column7.Header1.Caption   = "Moe"
7822:             .Column7.Width             = 35
7823:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7824: 
7825:             *-- Col8: Observacao (C40) W:95
7826:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7827:             .Column8.Width             = 95
7828:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7829:             .Column8.Alignment         = 0
7830: 
7831:             *-- Col9: Etiq (C1) W:30
7832:             .Column9.Header1.Caption   = "Etiq"
7833:             .Column9.Width             = 30
7834:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7835: 
7836:             *-- Col10: Consumo (N12,4) W:65
7837:             .Column10.Header1.Caption  = "Consumo"
7838:             .Column10.Width            = 65
7839:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7840:             .Column10.Alignment        = 1
7841: 
7842:             *-- Col11: Qtd cons (N12,4) W:55
7843:             .Column11.Header1.Caption  = "Qtd"
7844:             .Column11.Width            = 55
7845:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7846:             .Column11.Alignment        = 1
7847: 
7848:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7849:             .Column12.Header1.Caption  = "Un"
7850:             .Column12.Width            = 30
7851:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7852:             .Column12.ReadOnly         = .T.
7853:         ENDWITH
7854:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7855: 
7856:         *----------------------------------------------------------------------
7857:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7858:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7859:         *----------------------------------------------------------------------
7860:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7861:         WITH loc_oPg.cnt_4c_BotoesCusto
7862:             .Top         = 240
7863:             .Left        = 851
7864:             .Width       = 50
7865:             .Height      = 90
7866:             .BackStyle = 1
7867:             .BackColor = RGB(53, 53, 53)
7868:             .BorderWidth = 0
7869:             .Visible     = .T.
7870:         ENDWITH
7871: 
7872:         *-- Botao 1: Inserir componente de custo
7873:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7874:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto

*-- Linhas 8005 a 8077:
8005:             .Visible     = .T.
8006:         ENDWITH
8007: 
8008:         *-- GradeGRUPO2: grd_4c_GrupoCusto (3 cols) - usa cursor_4c_Grupo (compartilhado)
8009:         loc_oPg.AddObject("grd_4c_GrupoCusto", "Grid")
8010:         WITH loc_oPg.grd_4c_GrupoCusto
8011:             .Top               = 468
8012:             .Left              = 35
8013:             .Width             = 195
8014:             .Height            = 141
8015:             .ColumnCount       = 3
8016:             .FontName          = "Verdana"
8017:             .FontSize          = 8
8018:             .GridLines         = 3
8019:             .GridLineWidth     = 1
8020:             .GridLineColor     = RGB(238, 238, 238)
8021:             .RecordMark        = .F.
8022:             .DeleteMark        = .F.
8023:             .AllowRowSizing    = .F.
8024:             .ReadOnly          = .T.
8025:             .BackColor         = RGB(255, 255, 255)
8026:             .ForeColor         = RGB(90, 90, 90)
8027:             .HighlightBackColor = RGB(220, 230, 242)
8028:             .HighlightForeColor = RGB(15, 41, 104)
8029:             .HighlightStyle    = 2
8030:             .RowHeight         = 16
8031:             .ScrollBars        = 2
8032:             .Visible           = .T.
8033:         ENDWITH
8034: 
8035:         *-- RecordSource FORA do WITH
8036:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8037: 
8038:         *-- Configurar colunas APOS RecordSource
8039:         WITH loc_oPg.grd_4c_GrupoCusto
8040:             *-- Col1: Grupo (C3) W:40 - readonly
8041:             .Column1.Header1.Caption   = "Grp"
8042:             .Column1.Width             = 40
8043:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8044:             .Column1.ReadOnly          = .T.
8045: 
8046:             *-- Col2: Total (N12,4) W:100 - readonly
8047:             .Column2.Header1.Caption   = "Total"
8048:             .Column2.Width             = 100
8049:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8050:             .Column2.Alignment         = 1
8051:             .Column2.ReadOnly          = .T.
8052: 
8053:             *-- Col3: Moeda (C5) W:50 - readonly
8054:             .Column3.Header1.Caption   = "Moe"
8055:             .Column3.Width             = 50
8056:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8057:             .Column3.ReadOnly          = .T.
8058:         ENDWITH
8059:     ENDPROC
8060: 
8061:     *--------------------------------------------------------------------------
8062:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8063:     *--------------------------------------------------------------------------
8064:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8065:         LOCAL loc_oPg, loc_nRet
8066:         TRY
8067:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8068:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8069:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8070:                 *-- Buscar descricao do grupo
8071:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8072:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8073:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8074:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8075:                         "cursor_4c_TmpGrpCusto")
8076:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8077:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)

*-- Linhas 8099 a 8181:
8099:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8100:             IF USED("cursor_4c_Compo")
8101:                 GO TOP IN cursor_4c_Compo
8102:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8103:             ENDIF
8104:         CATCH TO loc_oErro
8105:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8106:         ENDTRY
8107:     ENDPROC
8108: 
8109:     *--------------------------------------------------------------------------
8110:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8111:     *--------------------------------------------------------------------------
8112:     PROCEDURE CmdInserirCustoClick()
8113:         LOCAL loc_oPg, loc_cTipo
8114:         TRY
8115:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8116:                 RETURN
8117:             ENDIF
8118:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8119:             loc_cTipo = ""
8120:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8121:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8122:             ENDIF
8123:             IF USED("cursor_4c_Compo")
8124:                 SELECT cursor_4c_Compo
8125:                 GO TOP IN cursor_4c_Compo
8126:                 LOCATE FOR EMPTY(mats)
8127:                 IF EOF("cursor_4c_Compo")
8128:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8129:                 ENDIF
8130:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8131:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8132:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8133:                 ENDIF
8134:             ENDIF
8135:         CATCH TO loc_oErro
8136:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8137:         ENDTRY
8138:     ENDPROC
8139: 
8140:     *--------------------------------------------------------------------------
8141:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8142:     *--------------------------------------------------------------------------
8143:     PROCEDURE CmdExcluirCustoClick()
8144:         LOCAL loc_oPg
8145:         TRY
8146:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8147:                 RETURN
8148:             ENDIF
8149:             IF USED("cursor_4c_Compo")
8150:                 SELECT cursor_4c_Compo
8151:                 IF !EOF("cursor_4c_Compo")
8152:                     DELETE
8153:                     IF !EOF("cursor_4c_Compo")
8154:                         SKIP
8155:                         SKIP -1
8156:                     ENDIF
8157:                     GO BOTTOM IN cursor_4c_Compo
8158:                 ENDIF
8159:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8160:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8161:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8162:             ENDIF
8163:         CATCH TO loc_oErro
8164:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8165:         ENDTRY
8166:     ENDPROC
8167: 
8168:     *--------------------------------------------------------------------------
8169:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8170:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8171:     *--------------------------------------------------------------------------
8172:     PROCEDURE AjustarBotoesPorModo()
8173:         LOCAL loc_oPg2, loc_lEditando
8174:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8175: 
8176:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8177:             RETURN
8178:         ENDIF
8179: 
8180:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8181: 

*-- Linhas 8202 a 8247:
8202:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8203:         *----------------------------------------------------------------------
8204:         IF !USED("cursor_4c_GradFase")
8205:             SET NULL ON
8206:             CREATE CURSOR cursor_4c_GradFase (;
8207:                 Ordems   N(5,0), ;
8208:                 Grupos   C(10), ;
8209:                 Descrs   C(65), ;
8210:                 UniPrdts C(10), ;
8211:                 MatPrdts C(15), ;
8212:                 Obs      M, ;
8213:                 FigProcs M)
8214:             SET NULL OFF
8215:         ENDIF
8216: 
8217:         *----------------------------------------------------------------------
8218:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8219:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8220:         *----------------------------------------------------------------------
8221:         IF !USED("cursor_4c_SigPrMtz")
8222:             SET NULL ON
8223:             CREATE CURSOR cursor_4c_SigPrMtz (;
8224:                 CMats C(14), ;
8225:                 DLocs C(40), ;
8226:                 Qtds  N(3,0))
8227:             SET NULL OFF
8228:         ENDIF
8229: 
8230:         *----------------------------------------------------------------------
8231:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8232:         *----------------------------------------------------------------------
8233:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8234:         WITH loc_oPg.shp_4c_ShpFig
8235:             .Top         = 152
8236:             .Left        = 231
8237:             .Width       = 244
8238:             .Height      = 148
8239:             .BackStyle   = 1
8240:             .BackColor   = RGB(255, 255, 255)
8241:             .BorderColor = RGB(192, 192, 192)
8242:             .BorderWidth = 1
8243:             .Visible     = .T.
8244:         ENDWITH
8245: 
8246:         *----------------------------------------------------------------------
8247:         *-- Image: ImgFigJpg (T:153 L:232 W:241 H:146) - imagem da fase de producao

*-- Linhas 8264 a 8363:
8264:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8265:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8266:         *----------------------------------------------------------------------
8267:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8268:         loc_oGrd = loc_oPg.grd_4c_GradFase
8269: 
8270:         WITH loc_oGrd
8271:             .Top                = 152
8272:             .Left               = 527
8273:             .Width              = 420
8274:             .Height             = 312
8275:             .FontName           = "Tahoma"
8276:             .FontSize           = 8
8277:             .ColumnCount        = 5
8278:             .GridLines          = 3
8279:             .GridLineWidth      = 1
8280:             .GridLineColor      = RGB(238, 238, 238)
8281:             .RecordMark         = .F.
8282:             .DeleteMark         = .F.
8283:             .AllowRowSizing     = .F.
8284:             .ReadOnly           = .F.
8285:             .BackColor          = RGB(255, 255, 255)
8286:             .ForeColor          = RGB(90, 90, 90)
8287:             .HighlightBackColor = RGB(220, 230, 242)
8288:             .HighlightForeColor = RGB(15, 41, 104)
8289:             .HighlightStyle     = 2
8290:             .RowHeight          = 16
8291:             .ScrollBars         = 2
8292:             .Themes             = .F.
8293:             .Visible            = .T.
8294:         ENDWITH
8295: 
8296:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8297:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8298: 
8299:         *-- Configurar colunas APOS RecordSource
8300:         WITH loc_oPg.grd_4c_GradFase
8301:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8302:             .Column1.Header1.Caption = "Ordem"
8303:             .Column1.Width           = 50
8304:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8305:             .Column1.Alignment       = 1
8306:             .Column1.ReadOnly        = .T.
8307: 
8308:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8309:             .Column2.Header1.Caption = "Fase"
8310:             .Column2.Width           = 80
8311:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8312:             .Column2.Alignment       = 0
8313:             .Column2.ReadOnly        = .F.
8314: 
8315:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8316:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8317:             .Column3.Width           = 130
8318:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8319:             .Column3.Alignment       = 0
8320:             .Column3.ReadOnly        = .T.
8321: 
8322:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8323:             .Column4.Header1.Caption = "Uni. Produtiva"
8324:             .Column4.Width           = 80
8325:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8326:             .Column4.Alignment       = 0
8327:             .Column4.ReadOnly        = .F.
8328: 
8329:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8330:             .Column5.Header1.Caption = "Material"
8331:             .Column5.Width           = 80
8332:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8333:             .Column5.Alignment       = 0
8334:             .Column5.ReadOnly        = .F.
8335:         ENDWITH
8336: 
8337:         *-- BINDEVENT: GradFase
8338:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8339:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8340:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8341:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8342:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8343:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8344: 
8345:         *----------------------------------------------------------------------
8346:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8347:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8348:         *----------------------------------------------------------------------
8349:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8350:         WITH loc_oPg.cmd_4c_IncluirFase
8351:             .Caption       = "+"
8352:             .Top           = 152
8353:             .Left          = 950
8354:             .Width         = 38
8355:             .Height        = 38
8356:             .FontName      = "Tahoma"
8357:             .FontSize      = 10
8358:             .FontBold      = .T.
8359:             .Themes        = .F.
8360:             .SpecialEffect = 0
8361:             .BackColor     = RGB(255, 255, 255)
8362:             .ForeColor     = RGB(0, 128, 0)
8363:             .Visible       = .T.

*-- Linhas 8887 a 8968:
8887: 
8888:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8889:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8890:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8891:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8892: 
8893:         WITH loc_oGrd
8894:             .Top                = 380
8895:             .Left               = 7
8896:             .Width              = 246
8897:             .Height             = 240
8898:             .FontName           = "Tahoma"
8899:             .FontSize           = 8
8900:             .ColumnCount        = 3
8901:             .GridLines          = 3
8902:             .GridLineWidth      = 1
8903:             .GridLineColor      = RGB(238, 238, 238)
8904:             .RecordMark         = .F.
8905:             .DeleteMark         = .F.
8906:             .AllowRowSizing     = .F.
8907:             .ReadOnly           = .F.
8908:             .BackColor          = RGB(255, 255, 255)
8909:             .ForeColor          = RGB(90, 90, 90)
8910:             .HighlightBackColor = RGB(220, 230, 242)
8911:             .HighlightForeColor = RGB(15, 41, 104)
8912:             .HighlightStyle     = 2
8913:             .RowHeight          = 16
8914:             .ScrollBars         = 2
8915:             .Themes             = .F.
8916:             .Visible            = .T.
8917:         ENDWITH
8918: 
8919:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8920:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8921: 
8922:         *-- Configurar colunas APOS RecordSource
8923:         WITH loc_oPg.grd_4c_Matrizes
8924:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8925:             .Column1.Header1.Caption = "Matriz"
8926:             .Column1.Width           = 70
8927:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8928:             .Column1.Alignment       = 0
8929:             .Column1.ReadOnly        = .F.
8930: 
8931:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8932:             .Column2.Header1.Caption = "Local"
8933:             .Column2.Width           = 120
8934:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8935:             .Column2.Alignment       = 0
8936:             .Column2.ReadOnly        = .T.
8937: 
8938:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8939:             .Column3.Header1.Caption = "Qtde"
8940:             .Column3.Width           = 56
8941:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8942:             .Column3.Alignment       = 1
8943:             .Column3.ReadOnly        = .F.
8944:         ENDWITH
8945: 
8946:         *-- BINDEVENT: grdMatrizes
8947:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8948:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8949: 
8950:         *----------------------------------------------------------------------
8951:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8952:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8953:         *----------------------------------------------------------------------
8954:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8955:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8956:             .Caption       = "+"
8957:             .Top           = 380
8958:             .Left          = 258
8959:             .Width         = 38
8960:             .Height        = 38
8961:             .FontName      = "Tahoma"
8962:             .FontSize      = 10
8963:             .FontBold      = .T.
8964:             .Themes        = .F.
8965:             .SpecialEffect = 0
8966:             .BackColor     = RGB(255, 255, 255)
8967:             .ForeColor     = RGB(0, 128, 0)
8968:             .Visible       = .T.

*-- Linhas 9182 a 9227:
9182:                 ENDIF
9183:             ENDIF
9184: 
9185:             loc_oPg.grd_4c_GradFase.Refresh()
9186:         CATCH TO loc_oErro
9187:             MsgErro(loc_oErro.Message, "Erro ao atualizar aba Fases")
9188:         ENDTRY
9189:     ENDPROC
9190: 
9191:     *--------------------------------------------------------------------------
9192:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9193:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9194:     *--------------------------------------------------------------------------
9195:     PROCEDURE GradFaseCol1GotFocus()
9196:         TRY
9197:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9198:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9199:             ENDIF
9200:         CATCH TO loc_oErro
9201:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9202:         ENDTRY
9203:     ENDPROC
9204: 
9205:     *--------------------------------------------------------------------------
9206:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9207:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9208:     *--------------------------------------------------------------------------
9209:     PROCEDURE GradFaseCol1LostFocus()
9210:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9211:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9212:             RETURN
9213:         ENDIF
9214:         loc_lResultado = .T.
9215:         TRY
9216:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9217:                 loc_lResultado = .F.
9218:             ENDIF
9219:             IF loc_lResultado
9220:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9221:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9222:                     loc_lResultado = .F.
9223:                 ENDIF
9224:             ENDIF
9225:             IF loc_lResultado
9226:                 *-- Calcular Ordem2 para resequenciamento
9227:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")

*-- Linhas 9235 a 9314:
9235:                 SELECT cursor_4c_GradFase
9236:                 *-- Reordenar por Ordems para refletir nova sequencia
9237:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9238:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9239:                 ENDIF
9240:             ENDIF
9241:         CATCH TO loc_oErro
9242:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9243:         ENDTRY
9244:     ENDPROC
9245: 
9246:     *--------------------------------------------------------------------------
9247:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9248:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9249:     *         Apos selecao: preenche Grupos e Descrs no cursor
9250:     *--------------------------------------------------------------------------
9251:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9252:         LOCAL loc_oBusca, loc_cAtual
9253:         IF par_nKeyCode = 115  && F4
9254:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9255:                 RETURN
9256:             ENDIF
9257:             TRY
9258:                 loc_cAtual = ""
9259:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9260:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9261:                 ENDIF
9262:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9263:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9264:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9265:                 IF VARTYPE(loc_oBusca) = "O"
9266:                     IF !loc_oBusca.this_lAchouRegistro
9267:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9268:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9269:                         loc_oBusca.Show()
9270:                     ENDIF
9271:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9272:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9273:                             SELECT cursor_4c_GradFase
9274:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9275:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9276:                         ENDIF
9277:                     ENDIF
9278:                     loc_oBusca.Release()
9279:                 ENDIF
9280:                 IF USED("cursor_4c_BuscaGcr")
9281:                     USE IN cursor_4c_BuscaGcr
9282:                 ENDIF
9283:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9284:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9285:                 ENDIF
9286:             CATCH TO loc_oErro
9287:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9288:             ENDTRY
9289:         ENDIF
9290:     ENDPROC
9291: 
9292:     *--------------------------------------------------------------------------
9293:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9294:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9295:     *         Apos selecao: preenche UniPrdts no cursor
9296:     *--------------------------------------------------------------------------
9297:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9298:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9299:         IF par_nKeyCode = 115  && F4
9300:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9301:                 RETURN
9302:             ENDIF
9303:             TRY
9304:                 loc_cAtual  = ""
9305:                 loc_cGrupos = ""
9306:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9307:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9308:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9309:                 ENDIF
9310:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9311:                 IF !EMPTY(loc_cGrupos)
9312:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9313:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9314:                 ELSE

*-- Linhas 9321 a 9408:
9321:                         "Buscar Uni. Produtiva")
9322:                     IF VARTYPE(loc_oBusca) = "O"
9323:                         IF !loc_oBusca.this_lAchouRegistro
9324:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9325:                             loc_oBusca.Show()
9326:                         ENDIF
9327:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9328:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9329:                                 SELECT cursor_4c_GradFase
9330:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9331:                             ENDIF
9332:                         ENDIF
9333:                         loc_oBusca.Release()
9334:                     ENDIF
9335:                     IF USED("cursor_4c_BuscaUpd2")
9336:                         USE IN cursor_4c_BuscaUpd2
9337:                     ENDIF
9338:                 ENDIF
9339:                 IF USED("cursor_4c_BuscaUpd")
9340:                     USE IN cursor_4c_BuscaUpd
9341:                 ENDIF
9342:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9343:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9344:                 ENDIF
9345:             CATCH TO loc_oErro
9346:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9347:             ENDTRY
9348:         ENDIF
9349:     ENDPROC
9350: 
9351:     *--------------------------------------------------------------------------
9352:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9353:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9354:     *         Apos selecao: preenche MatPrdts no cursor
9355:     *--------------------------------------------------------------------------
9356:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9357:         LOCAL loc_oBusca, loc_cAtual
9358:         IF par_nKeyCode = 115  && F4
9359:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9360:                 RETURN
9361:             ENDIF
9362:             TRY
9363:                 loc_cAtual = ""
9364:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9365:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9366:                 ENDIF
9367:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9368:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9369:                     "Buscar Tipo de Material")
9370:                 IF VARTYPE(loc_oBusca) = "O"
9371:                     IF !loc_oBusca.this_lAchouRegistro
9372:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9373:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9374:                         loc_oBusca.Show()
9375:                     ENDIF
9376:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9377:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9378:                             SELECT cursor_4c_GradFase
9379:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9380:                         ENDIF
9381:                     ENDIF
9382:                     loc_oBusca.Release()
9383:                 ENDIF
9384:                 IF USED("cursor_4c_BuscaOpt")
9385:                     USE IN cursor_4c_BuscaOpt
9386:                 ENDIF
9387:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9388:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9389:                 ENDIF
9390:             CATCH TO loc_oErro
9391:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9392:             ENDTRY
9393:         ENDIF
9394:     ENDPROC
9395: 
9396:     *--------------------------------------------------------------------------
9397:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9398:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9399:     *--------------------------------------------------------------------------
9400:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9401:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9402:         TRY
9403:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9404:                 RETURN
9405:             ENDIF
9406:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9407:             IF VARTYPE(loc_oPg) # "O"
9408:                 RETURN

*-- Linhas 9437 a 9508:
9437:                 ENDIF
9438:             ENDIF
9439: 
9440:             loc_oPg.grd_4c_Matrizes.Refresh()
9441:         CATCH TO loc_oErro
9442:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da matriz")
9443:         ENDTRY
9444:     ENDPROC
9445: 
9446:     *--------------------------------------------------------------------------
9447:     * GrdMatrizesCol1KeyPress - F4 abre lookup de Matrizes (cursor crMatrizes)
9448:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9449:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9450:     *--------------------------------------------------------------------------
9451:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9452:         LOCAL loc_oBusca, loc_cAtual
9453:         IF par_nKeyCode = 115  && F4
9454:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9455:                 RETURN
9456:             ENDIF
9457:             TRY
9458:                 loc_cAtual = ""
9459:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9460:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9461:                 ENDIF
9462:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9463:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9464:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9465:                     "Buscar Matriz")
9466:                 IF VARTYPE(loc_oBusca) = "O"
9467:                     IF !loc_oBusca.this_lAchouRegistro
9468:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9469:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9470:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9471:                         loc_oBusca.Show()
9472:                     ENDIF
9473:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9474:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9475:                             SELECT cursor_4c_SigPrMtz
9476:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9477:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9478:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9479:                             ENDIF
9480:                         ENDIF
9481:                     ENDIF
9482:                     loc_oBusca.Release()
9483:                 ENDIF
9484:                 IF USED("cursor_4c_BuscaMatriz")
9485:                     USE IN cursor_4c_BuscaMatriz
9486:                 ENDIF
9487:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9488:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9489:                 ENDIF
9490:             CATCH TO loc_oErro
9491:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9492:             ENDTRY
9493:         ENDIF
9494:     ENDPROC
9495: 
9496:     *--------------------------------------------------------------------------
9497:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9498:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9499:     *--------------------------------------------------------------------------
9500:     PROCEDURE CmdIncluirFaseClick()
9501:         LOCAL loc_oPg, loc_nOrdem
9502:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9503:             RETURN
9504:         ENDIF
9505:         TRY
9506:             IF !USED("cursor_4c_GradFase")
9507:                 RETURN
9508:             ENDIF

*-- Linhas 9525 a 9550:
9525:             GO BOTTOM IN cursor_4c_GradFase
9526:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9527:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9528:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9529:                     loc_oPg.grd_4c_GradFase.Refresh()
9530:                     loc_oPg.grd_4c_GradFase.SetFocus()
9531:                 ENDIF
9532:             ENDIF
9533:         CATCH TO loc_oErro
9534:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9535:         ENDTRY
9536:     ENDPROC
9537: 
9538:     *--------------------------------------------------------------------------
9539:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9540:     * Legado: excluir.Click - DELETE e resequencia Ordems
9541:     *--------------------------------------------------------------------------
9542:     PROCEDURE CmdExcluirFaseClick()
9543:         LOCAL loc_oPg, loc_lResultado
9544:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9545:             RETURN
9546:         ENDIF
9547:         loc_lResultado = .T.
9548:         TRY
9549:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9550:                 loc_lResultado = .F.

*-- Linhas 9573 a 9597:
9573:                 ENDSCAN
9574:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9575:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9576:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9577:                         loc_oPg.grd_4c_GradFase.Refresh()
9578:                     ENDIF
9579:                 ENDIF
9580:             ENDIF
9581:         CATCH TO loc_oErro
9582:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9583:         ENDTRY
9584:     ENDPROC
9585: 
9586:     *--------------------------------------------------------------------------
9587:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9588:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9589:     *--------------------------------------------------------------------------
9590:     PROCEDURE CmdAlternativaFaseClick()
9591:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9592:         LOCAL loc_nOrdem
9593:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9594:             RETURN
9595:         ENDIF
9596:         loc_lResultado = .T.
9597:         TRY

*-- Linhas 9624 a 9648:
9624:                 GO BOTTOM IN cursor_4c_GradFase
9625:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9626:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9627:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9628:                         loc_oPg.grd_4c_GradFase.Refresh()
9629:                     ENDIF
9630:                 ENDIF
9631:             ENDIF
9632:         CATCH TO loc_oErro
9633:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9634:         ENDTRY
9635:     ENDPROC
9636: 
9637:     *--------------------------------------------------------------------------
9638:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9639:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9640:     *--------------------------------------------------------------------------
9641:     PROCEDURE CmdFichaClick()
9642:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9643:         loc_lResultado = .T.
9644:         TRY
9645:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9646:                 loc_lResultado = .F.
9647:             ENDIF
9648:             IF loc_lResultado

*-- Linhas 9658 a 9681:
9658:                 IF USED("CsCabecalho")
9659:                     USE IN CsCabecalho
9660:                 ENDIF
9661:                 CREATE CURSOR CsCabecalho (;
9662:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9663:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9664:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9665:                     _nPeso N(9,2))
9666:                 WITH THIS.this_oBusinessObject
9667:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9668:                         VALUES (loc_cNmEmp, ;
9669:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9670:                                 ALLTRIM(.this_cCpros), ;
9671:                                 ALLTRIM(.this_cDpros), ;
9672:                                 ALLTRIM(.this_cCgrus), ;
9673:                                 .this_nPesobs)
9674:                 ENDWITH
9675:                 *-- Verificar e executar relatorio
9676:                 LOCAL loc_cRepPath
9677:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9678:                 IF FILE(loc_cRepPath)
9679:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9680:                 ELSE
9681:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")

*-- Linhas 9811 a 9836:
9811:             ENDIF
9812:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9813:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9814:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9815:                     loc_oPg.grd_4c_Matrizes.Refresh()
9816:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9817:                 ENDIF
9818:             ENDIF
9819:         CATCH TO loc_oErro
9820:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9821:         ENDTRY
9822:     ENDPROC
9823: 
9824:     *--------------------------------------------------------------------------
9825:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9826:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9827:     *--------------------------------------------------------------------------
9828:     PROCEDURE BtnExcluiMtzClick()
9829:         LOCAL loc_oPg, loc_lResultado
9830:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9831:             RETURN
9832:         ENDIF
9833:         loc_lResultado = .T.
9834:         TRY
9835:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9836:                 loc_lResultado = .F.

*-- Linhas 9847 a 9872:
9847:             ENDIF
9848:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9849:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9850:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9851:                     loc_oPg.grd_4c_Matrizes.Refresh()
9852:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9853:                 ENDIF
9854:             ENDIF
9855:         CATCH TO loc_oErro
9856:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9857:         ENDTRY
9858:     ENDPROC
9859: 
9860:     *--------------------------------------------------------------------------
9861:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9862:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9863:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9864:     *--------------------------------------------------------------------------
9865:     PROCEDURE TxtCodacbLostFocus()
9866:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9867:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9868:             RETURN
9869:         ENDIF
9870:         loc_lResultado = .T.
9871:         TRY
9872:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"

*-- Linhas 9887 a 9911:
9887:                     "Buscar Acabamento")
9888:                 IF VARTYPE(loc_oBusca) = "O"
9889:                     IF !loc_oBusca.this_lAchouRegistro
9890:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9891:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9892:                         loc_oBusca.Show()
9893:                     ENDIF
9894:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9895:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9896:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9897:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9898:                     ELSE
9899:                         loc_oPg.txt_4c__codacb.Value = ""
9900:                         loc_oPg.txt_4c__Dacb.Value   = ""
9901:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9902:                     ENDIF
9903:                     loc_oBusca.Release()
9904:                 ENDIF
9905:                 IF USED("cursor_4c_BuscaAca")
9906:                     USE IN cursor_4c_BuscaAca
9907:                 ENDIF
9908:             ENDIF
9909:         CATCH TO loc_oErro
9910:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9911:         ENDTRY

*-- Linhas 9948 a 9972:
9948:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9949:                 IF VARTYPE(loc_oBusca) = "O"
9950:                     IF !loc_oBusca.this_lAchouRegistro
9951:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9952:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9953:                         loc_oBusca.Show()
9954:                     ENDIF
9955:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9956:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9957:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9958:                     ELSE
9959:                         loc_oPg.txt_4c_Tam.Value = ""
9960:                         THIS.this_oBusinessObject.this_cCodtams = ""
9961:                     ENDIF
9962:                     loc_oBusca.Release()
9963:                 ENDIF
9964:                 IF USED("cursor_4c_BuscaTam")
9965:                     USE IN cursor_4c_BuscaTam
9966:                 ENDIF
9967:             ENDIF
9968:         CATCH TO loc_oErro
9969:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9970:         ENDTRY
9971:     ENDPROC
9972: 

*-- Linhas 10007 a 10031:
10007:                     "Buscar Cor Padr" + CHR(227) + "o")
10008:                 IF VARTYPE(loc_oBusca) = "O"
10009:                     IF !loc_oBusca.this_lAchouRegistro
10010:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
10011:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10012:                         loc_oBusca.Show()
10013:                     ENDIF
10014:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
10015:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
10016:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
10017:                     ELSE
10018:                         loc_oPg.txt_4c_Cor.Value = ""
10019:                         THIS.this_oBusinessObject.this_cCodcors = ""
10020:                     ENDIF
10021:                     loc_oBusca.Release()
10022:                 ENDIF
10023:                 IF USED("cursor_4c_BuscaCor")
10024:                     USE IN cursor_4c_BuscaCor
10025:                 ENDIF
10026:             ENDIF
10027:         CATCH TO loc_oErro
10028:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
10029:         ENDTRY
10030:     ENDPROC
10031: 

*-- Linhas 10078 a 10101:
10078:                             "Buscar Conquilha")
10079:                         IF VARTYPE(loc_oBusca) = "O"
10080:                             IF !loc_oBusca.this_lAchouRegistro
10081:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10082:                                 loc_oBusca.Show()
10083:                             ENDIF
10084:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10085:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10086:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10087:                             ELSE
10088:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10089:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10090:                             ENDIF
10091:                             loc_oBusca.Release()
10092:                         ENDIF
10093:                         IF USED("cursor_4c_BuscaCnq")
10094:                             USE IN cursor_4c_BuscaCnq
10095:                         ENDIF
10096:                     ENDIF
10097:                     USE IN cursor_4c_ListaCnq
10098:                 ENDIF
10099:             ENDIF
10100:         CATCH TO loc_oErro
10101:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")

*-- Linhas 10117 a 10145:
10117:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10118:         *----------------------------------------------------------------------
10119:         IF !USED("cursor_4c_Cmv")
10120:             SET NULL ON
10121:             CREATE CURSOR cursor_4c_Cmv (;
10122:                 Datas   D, ;
10123:                 ValCuss N(12,3), ;
10124:                 Moedas  C(3))
10125:             SET NULL OFF
10126:         ENDIF
10127: 
10128:         *----------------------------------------------------------------------
10129:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10130:         *----------------------------------------------------------------------
10131:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10132:         WITH loc_oPg.lbl_4c_LblGruCus
10133:             .Caption   = "Grupo C.C. :"
10134:             .Top       = 165
10135:             .Left      = 138
10136:             .Width     = 63
10137:             .Height    = 15
10138:             .FontName  = "Tahoma"
10139:             .FontSize  = 8
10140:             .BackStyle = 0
10141:             .ForeColor = RGB(90, 90, 90)
10142:             .Visible   = .T.
10143:         ENDWITH
10144: 
10145:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")

*-- Linhas 10907 a 10973:
10907:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10908:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10909:         *----------------------------------------------------------------------
10910:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
10911:         WITH loc_oPg.grd_4c_Cmv
10912:             .Top         = 338
10913:             .Left        = 754
10914:             .Width       = 223
10915:             .Height      = 141
10916:             .ColumnCount = 3
10917:             .FontName    = "Tahoma"
10918:             .FontSize    = 8
10919:             .RowHeight   = 17
10920:             .DeleteMark  = .F.
10921:             .RecordMark  = .T.
10922:             .ReadOnly    = .T.
10923:             .ScrollBars  = 3
10924:             .Themes      = .F.
10925:             .Visible     = .T.
10926:         ENDWITH
10927:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10928:         WITH loc_oPg.grd_4c_Cmv
10929:             WITH .Column1
10930:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10931:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10932:                 .Header1.FontName = "Tahoma"
10933:                 .Header1.FontSize = 8
10934:                 .Width            = 59
10935:                 .Movable          = .F.
10936:                 .Resizable        = .F.
10937:                 .ReadOnly         = .T.
10938:             ENDWITH
10939:             WITH .Column2
10940:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10941:                 .Header1.Caption  = "Valor Custo GR"
10942:                 .Header1.FontName = "Tahoma"
10943:                 .Header1.FontSize = 8
10944:                 .Width            = 100
10945:                 .Movable          = .F.
10946:                 .Resizable        = .F.
10947:                 .ReadOnly         = .T.
10948:             ENDWITH
10949:             WITH .Column3
10950:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10951:                 .Header1.Caption  = "Moe"
10952:                 .Header1.FontName = "Tahoma"
10953:                 .Header1.FontSize = 8
10954:                 .Width            = 31
10955:                 .Movable          = .F.
10956:                 .Resizable        = .F.
10957:                 .ReadOnly         = .T.
10958:             ENDWITH
10959:         ENDWITH
10960:     ENDPROC
10961: 
10962:     *--------------------------------------------------------------------------
10963:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10964:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10965:     *--------------------------------------------------------------------------
10966:     PROTECTED PROCEDURE PreencherCamposFiscais()
10967:         LOCAL loc_oPg, loc_cIpiVal
10968:         TRY
10969:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10970:                 RETURN
10971:             ENDIF
10972:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10973:             IF VARTYPE(loc_oPg) # "O"

*-- Linhas 11165 a 11189:
11165:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11166:                 IF VARTYPE(loc_oBusca) = "O"
11167:                     IF !loc_oBusca.this_lAchouRegistro
11168:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11169:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11170:                         loc_oBusca.Show()
11171:                     ENDIF
11172:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11173:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11174:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11175:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11176:                         ENDIF
11177:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11178:                     ELSE
11179:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11180:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11181:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11182:                         ENDIF
11183:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11184:                     ENDIF
11185:                     loc_oBusca.Release()
11186:                 ENDIF
11187:                 IF USED("cursor_4c_BuscaClf")
11188:                     USE IN cursor_4c_BuscaClf
11189:                 ENDIF

*-- Linhas 11235 a 11259:
11235:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11236:                 IF VARTYPE(loc_oBusca) = "O"
11237:                     IF !loc_oBusca.this_lAchouRegistro
11238:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11239:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11240:                         loc_oBusca.Show()
11241:                     ENDIF
11242:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11243:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11244:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11245:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11246:                     ENDIF
11247:                     loc_oBusca.Release()
11248:                 ENDIF
11249:                 IF USED("cursor_4c_BuscaClfR")
11250:                     USE IN cursor_4c_BuscaClfR
11251:                 ENDIF
11252:             ENDIF
11253:         CATCH TO loc_oErro
11254:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11255:         ENDTRY
11256:     ENDPROC
11257: 
11258:     *--------------------------------------------------------------------------
11259:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)

*-- Linhas 11294 a 11318:
11294:                     "Buscar Origem da Mercadoria")
11295:                 IF VARTYPE(loc_oBusca) = "O"
11296:                     IF !loc_oBusca.this_lAchouRegistro
11297:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11298:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11299:                         loc_oBusca.Show()
11300:                     ENDIF
11301:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11302:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11303:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11304:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11305:                         ENDIF
11306:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11307:                     ELSE
11308:                         loc_oPg.txt_4c_Origmerc.Value = ""
11309:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11310:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11311:                         ENDIF
11312:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11313:                     ENDIF
11314:                     loc_oBusca.Release()
11315:                 ENDIF
11316:                 IF USED("cursor_4c_BuscaOrg")
11317:                     USE IN cursor_4c_BuscaOrg
11318:                 ENDIF

*-- Linhas 11361 a 11385:
11361:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11362:                 IF VARTYPE(loc_oBusca) = "O"
11363:                     IF !loc_oBusca.this_lAchouRegistro
11364:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11365:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11366:                         loc_oBusca.Show()
11367:                     ENDIF
11368:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11369:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11370:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11371:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11372:                         ENDIF
11373:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11374:                     ELSE
11375:                         loc_oPg.txt_4c_Sittricm.Value = ""
11376:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11377:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11378:                         ENDIF
11379:                         THIS.this_oBusinessObject.this_cSittricms = ""
11380:                     ENDIF
11381:                     loc_oBusca.Release()
11382:                 ENDIF
11383:                 IF USED("cursor_4c_BuscaIcm")
11384:                     USE IN cursor_4c_BuscaIcm
11385:                 ENDIF

*-- Linhas 11445 a 11469:
11445:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11446:                 IF VARTYPE(loc_oBusca) = "O"
11447:                     IF !loc_oBusca.this_lAchouRegistro
11448:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11449:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11450:                         loc_oBusca.Show()
11451:                     ENDIF
11452:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11453:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11454:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11455:                     ELSE
11456:                         loc_oPg.txt_4c_TpTrib.Value = ""
11457:                         THIS.this_oBusinessObject.this_cTptribs = ""
11458:                     ENDIF
11459:                     loc_oBusca.Release()
11460:                 ENDIF
11461:                 IF USED("cursor_4c_BuscaTri")
11462:                     USE IN cursor_4c_BuscaTri
11463:                 ENDIF
11464:             ENDIF
11465:         CATCH TO loc_oErro
11466:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11467:         ENDTRY
11468:     ENDPROC
11469: 

*-- Linhas 11531 a 11555:
11531:                     "Buscar Moeda")
11532:                 IF VARTYPE(loc_oBusca) = "O"
11533:                     IF !loc_oBusca.this_lAchouRegistro
11534:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11535:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11536:                         loc_oBusca.Show()
11537:                     ENDIF
11538:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11539:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11540:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11541:                     ELSE
11542:                         loc_oPg.txt_4c_Mvalor.Value = ""
11543:                         THIS.this_oBusinessObject.this_cMoedas = ""
11544:                     ENDIF
11545:                     loc_oBusca.Release()
11546:                 ENDIF
11547:                 IF USED("cursor_4c_BuscaMoeFisc")
11548:                     USE IN cursor_4c_BuscaMoeFisc
11549:                 ENDIF
11550:             ENDIF
11551:         CATCH TO loc_oErro
11552:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11553:         ENDTRY
11554:     ENDPROC
11555: 

*-- Linhas 11605 a 11629:
11605:                             "Buscar Metal")
11606:                         IF VARTYPE(loc_oBusca) = "O"
11607:                             IF !loc_oBusca.this_lAchouRegistro
11608:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11609:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11610:                                 loc_oBusca.Show()
11611:                             ENDIF
11612:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11613:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11614:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11615:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11616:                                 ENDIF
11617:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11618:                             ELSE
11619:                                 loc_oPg.txt_4c_Metal.Value = ""
11620:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11621:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11622:                                 ENDIF
11623:                                 THIS.this_oBusinessObject.this_cMetals = ""
11624:                             ENDIF
11625:                             loc_oBusca.Release()
11626:                         ENDIF
11627:                         IF USED("cursor_4c_BuscaMtlSel")
11628:                             USE IN cursor_4c_BuscaMtlSel
11629:                         ENDIF

*-- Linhas 11686 a 11710:
11686:                             "Buscar Teor")
11687:                         IF VARTYPE(loc_oBusca) = "O"
11688:                             IF !loc_oBusca.this_lAchouRegistro
11689:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11690:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11691:                                 loc_oBusca.Show()
11692:                             ENDIF
11693:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11694:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11695:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11696:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11697:                                 ENDIF
11698:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11699:                             ELSE
11700:                                 loc_oPg.txt_4c_Teor.Value = ""
11701:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11702:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11703:                                 ENDIF
11704:                                 THIS.this_oBusinessObject.this_cTeors = ""
11705:                             ENDIF
11706:                             loc_oBusca.Release()
11707:                         ENDIF
11708:                         IF USED("cursor_4c_BuscaTeorSel")
11709:                             USE IN cursor_4c_BuscaTeorSel
11710:                         ENDIF

*-- Linhas 11819 a 11860:
11819:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11820:         *----------------------------------------------------------------------
11821:         IF !USED("cursor_4c_SigPrTar")
11822:             SET NULL ON
11823:             CREATE CURSOR cursor_4c_SigPrTar (;
11824:                 DtInis  D NULL, ;
11825:                 DtFims  D NULL, ;
11826:                 Usuars  C(10), ;
11827:                 Tarefas C(10), ;
11828:                 ObsTars M)
11829:             SET NULL OFF
11830:         ENDIF
11831: 
11832:         *----------------------------------------------------------------------
11833:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11834:         *-- Campos: Arquivos
11835:         *----------------------------------------------------------------------
11836:         IF !USED("cursor_4c_SigPrArq")
11837:             SET NULL ON
11838:             CREATE CURSOR cursor_4c_SigPrArq (;
11839:                 Arquivos C(200))
11840:             SET NULL OFF
11841:         ENDIF
11842: 
11843:         *----------------------------------------------------------------------
11844:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11845:         *----------------------------------------------------------------------
11846:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11847:         WITH loc_oPg.shp_4c_ArqFundo
11848:             .Top         = 415
11849:             .Left        = 584
11850:             .Width       = 407
11851:             .Height      = 202
11852:             .BackColor   = RGB(230, 230, 230)
11853:             .BorderColor = RGB(180, 180, 180)
11854:             .Visible     = .T.
11855:         ENDWITH
11856: 
11857:         *----------------------------------------------------------------------
11858:         *-- Say31: "Observacao da Tarefa" (T:144 L:583 W:126 H:15)
11859:         *----------------------------------------------------------------------
11860:         loc_oPg.AddObject("lbl_4c_ObsTarLabel", "Label")

*-- Linhas 11876 a 11976:
11876:         *-- grdDesigner: Grade de Tarefas (T:160 L:10 W:495 H:238) 4 colunas
11877:         *-- Colunas: Data Inicio | Data Conclusao | Usuario | Tarefa
11878:         *-- Cols 1-3 readonly, Col4 editavel (quando usuario e dono e tarefa nao finalizada)
11879:         *----------------------------------------------------------------------
11880:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
11881:         WITH loc_oPg.grd_4c_Designer
11882:             .Top         = 160
11883:             .Left        = 10
11884:             .Width       = 495
11885:             .Height      = 238
11886:             .ColumnCount = 4
11887:             .FontName    = "Tahoma"
11888:             .FontSize    = 8
11889:             .DeleteMark  = .F.
11890:             .ScrollBars  = 2
11891:             .Themes      = .F.
11892:             .Visible     = .T.
11893:             .RecordMark   = .F.
11894:         ENDWITH
11895:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11896:         WITH loc_oPg.grd_4c_Designer
11897:             WITH .Column1
11898:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11899:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11900:                 .Header1.FontName  = "Tahoma"
11901:                 .Header1.FontSize  = 8
11902:                 .Header1.Alignment = 2
11903:                 .Width             = 140
11904:                 .Movable           = .F.
11905:                 .Resizable         = .F.
11906:                 .ReadOnly          = .T.
11907:                 .Alignment         = 2
11908:             ENDWITH
11909:             WITH .Column2
11910:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11911:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11912:                 .Header1.FontName  = "Tahoma"
11913:                 .Header1.FontSize  = 8
11914:                 .Header1.Alignment = 2
11915:                 .Width             = 140
11916:                 .Movable           = .F.
11917:                 .Resizable         = .F.
11918:                 .ReadOnly          = .T.
11919:                 .Alignment         = 2
11920:             ENDWITH
11921:             WITH .Column3
11922:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11923:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11924:                 .Header1.FontName  = "Tahoma"
11925:                 .Header1.FontSize  = 8
11926:                 .Header1.Alignment = 2
11927:                 .Width             = 90
11928:                 .Movable           = .F.
11929:                 .Resizable         = .F.
11930:                 .ReadOnly          = .T.
11931:             ENDWITH
11932:             WITH .Column4
11933:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11934:                 .Header1.Caption   = "Tarefa"
11935:                 .Header1.FontName  = "Tahoma"
11936:                 .Header1.FontSize  = 8
11937:                 .Header1.Alignment = 2
11938:                 .Width             = 90
11939:                 .Movable           = .F.
11940:                 .Resizable         = .F.
11941:                 .ReadOnly          = .F.
11942:             ENDWITH
11943:         ENDWITH
11944:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11945: 
11946:         *----------------------------------------------------------------------
11947:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11948:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11949:         *----------------------------------------------------------------------
11950:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11951:         WITH loc_oPg.obj_4c_ObsTarefas
11952:             .Top              = 160
11953:             .Left             = 584
11954:             .Width            = 407
11955:             .Height           = 238
11956:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11957:             .FontName         = "Tahoma"
11958:             .FontSize         = 8
11959:             .SpecialEffect    = 1
11960:             .ForeColor        = RGB(36, 84, 155)
11961:             .Enabled          = .T.
11962:             .Visible          = .T.
11963:         ENDWITH
11964: 
11965:         *----------------------------------------------------------------------
11966:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11967:         *----------------------------------------------------------------------
11968:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11969:         WITH loc_oPg.cmd_4c_IniTarefa
11970:             .Top             = 168
11971:             .Left            = 509
11972:             .Width           = 42
11973:             .Height          = 42
11974:             .Caption         = ""
11975:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11976:             .FontName        = "Tahoma"

*-- Linhas 12005 a 12058:
12005:         *----------------------------------------------------------------------
12006:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
12007:         *----------------------------------------------------------------------
12008:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
12009:         WITH loc_oPg.grd_4c_Arquivos
12010:             .Top         = 415
12011:             .Left        = 10
12012:             .Width       = 495
12013:             .Height      = 202
12014:             .ColumnCount = 1
12015:             .FontName    = "Tahoma"
12016:             .FontSize    = 8
12017:             .DeleteMark  = .F.
12018:             .ScrollBars  = 2
12019:             .ReadOnly    = .T.
12020:             .Themes      = .F.
12021:             .Visible     = .T.
12022:             .RecordMark   = .F.
12023:         ENDWITH
12024:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
12025:         WITH loc_oPg.grd_4c_Arquivos
12026:             WITH .Column1
12027:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12028:                 .Header1.Caption   = "Arquivos Para Designer"
12029:                 .Header1.FontName  = "Tahoma"
12030:                 .Header1.FontSize  = 8
12031:                 .Header1.Alignment = 2
12032:                 .Width             = 464
12033:                 .Movable           = .F.
12034:                 .Resizable         = .F.
12035:                 .ReadOnly          = .T.
12036:             ENDWITH
12037:         ENDWITH
12038:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12039: 
12040:         *----------------------------------------------------------------------
12041:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12042:         *----------------------------------------------------------------------
12043:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
12044:         WITH loc_oPg.cmd_4c_InsArqs
12045:             .Top             = 416
12046:             .Left            = 509
12047:             .Width           = 42
12048:             .Height          = 42
12049:             .Caption         = ""
12050:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
12051:             .FontName        = "Tahoma"
12052:             .FontSize        = 8
12053:             .Themes          = .F.
12054:             .ToolTipText     = "Inserir Arquivo"
12055:             .Enabled         = .F.
12056:             .Visible         = .T.
12057:         ENDWITH
12058:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")

*-- Linhas 12113 a 12156:
12113:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
12114: 
12115:         *----------------------------------------------------------------------
12116:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
12117:         *----------------------------------------------------------------------
12118:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12119:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12120:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12121: 
12122:         *----------------------------------------------------------------------
12123:         *-- Binding When para EditBox Obs da Tarefa
12124:         *----------------------------------------------------------------------
12125:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12126: 
12127:         *----------------------------------------------------------------------
12128:         *-- Bindings When para botoes de tarefa
12129:         *----------------------------------------------------------------------
12130:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12131:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12132: 
12133:         *----------------------------------------------------------------------
12134:         *-- Binding When para Column1 do grdArquivos
12135:         *----------------------------------------------------------------------
12136:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12137: 
12138:         *----------------------------------------------------------------------
12139:         *-- Bindings When para botoes de arquivo
12140:         *----------------------------------------------------------------------
12141:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12142:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12143:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12144:     ENDPROC
12145: 
12146:     *--------------------------------------------------------------------------
12147:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12148:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12149:     *--------------------------------------------------------------------------
12150:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12151:         LOCAL loc_oPg
12152:         TRY
12153:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12154:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12155:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12156:                     *-- Sincronizar editbox com observacao da tarefa selecionada

*-- Linhas 12243 a 12266:
12243:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12244:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12245:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12246:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12247:                 ENDIF
12248:             ENDIF
12249:         CATCH TO loc_oErro
12250:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12251:         ENDTRY
12252:     ENDPROC
12253: 
12254:     *--------------------------------------------------------------------------
12255:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12256:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12257:     *--------------------------------------------------------------------------
12258:     PROCEDURE BtnFimTarefaClick()
12259:         LOCAL loc_lResultado
12260:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12261:             RETURN
12262:         ENDIF
12263:         loc_lResultado = .T.
12264:         TRY
12265:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12266:                 loc_lResultado = .F.

*-- Linhas 12281 a 12332:
12281:                 SELECT cursor_4c_SigPrTar
12282:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12283:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12284:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12285:                 ENDIF
12286:             ENDIF
12287:         CATCH TO loc_oErro
12288:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12289:         ENDTRY
12290:     ENDPROC
12291: 
12292:     *--------------------------------------------------------------------------
12293:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12294:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12295:     *--------------------------------------------------------------------------
12296:     PROCEDURE BtnInsArqsClick()
12297:         LOCAL loc_cArq, loc_lResultado
12298:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12299:             RETURN
12300:         ENDIF
12301:         loc_lResultado = .T.
12302:         TRY
12303:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12304:             IF EMPTY(loc_cArq)
12305:                 loc_lResultado = .F.
12306:             ENDIF
12307:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12308:                 SELECT cursor_4c_SigPrArq
12309:                 APPEND BLANK
12310:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12311:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12312:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12313:                 ENDIF
12314:             ENDIF
12315:         CATCH TO loc_oErro
12316:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12317:         ENDTRY
12318:     ENDPROC
12319: 
12320:     *--------------------------------------------------------------------------
12321:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12322:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12323:     *--------------------------------------------------------------------------
12324:     PROCEDURE BtnOpnArqsClick()
12325:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12326:         loc_lResultado = .T.
12327:         TRY
12328:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12329:                 loc_lResultado = .F.
12330:             ENDIF
12331:             IF loc_lResultado
12332:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))

*-- Linhas 12378 a 12401:
12378:                     SKIP -1
12379:                 ENDIF
12380:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12381:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12382:                 ENDIF
12383:                 *-- Limpar imagem ao excluir arquivo
12384:                 LOCAL loc_oPg
12385:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12386:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12387:                     CLEAR RESOURCES
12388:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12389:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12390:                 ENDIF
12391:             ENDIF
12392:         CATCH TO loc_oErro
12393:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12394:         ENDTRY
12395:     ENDPROC
12396: 
12397:     *--------------------------------------------------------------------------
12398:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12399:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12400:     *--------------------------------------------------------------------------
12401:     PROCEDURE ImgArqJpgClick()

*-- Linhas 12436 a 12530:
12436: 
12437:     *--------------------------------------------------------------------------
12438:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12439:     * Legado: grdDesigner.Column4.Text1.When
12440:     *--------------------------------------------------------------------------
12441:     PROCEDURE GrdDesignerCol4When()
12442:         LOCAL loc_lResult
12443:         loc_lResult = .F.
12444:         TRY
12445:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12446:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12447:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12448:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12449:                         loc_lResult = .T.
12450:                     ENDIF
12451:                 ENDIF
12452:             ENDIF
12453:         CATCH TO loc_oErro
12454:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12455:         ENDTRY
12456:         RETURN loc_lResult
12457:     ENDPROC
12458: 
12459:     *--------------------------------------------------------------------------
12460:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12461:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12462:     *--------------------------------------------------------------------------
12463:     PROCEDURE GrdDesignerCol4Valid()
12464:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12465:         loc_lResult = .T.
12466:         TRY
12467:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12468:                 loc_lResultado = .T.
12469:             ENDIF
12470:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12471:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12472:             IF !EMPTY(loc_cCodigo)
12473:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12474:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12475:                     "Buscar Tarefa")
12476:                 IF VARTYPE(loc_oBusca) = "O"
12477:                     IF !loc_oBusca.this_lAchouRegistro
12478:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12479:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12480:                         loc_oBusca.Show()
12481:                     ENDIF
12482:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12483:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12484:                     ELSE
12485:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12486:                     ENDIF
12487:                     loc_oBusca.Release()
12488:                 ENDIF
12489:                 IF USED("cursor_4c_BuscaTar")
12490:                     USE IN cursor_4c_BuscaTar
12491:                 ENDIF
12492:             ENDIF
12493:         CATCH TO loc_oErro
12494:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12495:         ENDTRY
12496:         RETURN loc_lResult
12497:     ENDPROC
12498: 
12499:     *--------------------------------------------------------------------------
12500:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12501:     * Legado: grdDesigner.Column4.Text1.LostFocus
12502:     *--------------------------------------------------------------------------
12503:     PROCEDURE GrdDesignerCol4LostFocus()
12504:         LOCAL loc_oPg
12505:         TRY
12506:             IF LASTKEY() = 13
12507:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12508:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12509:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12510:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12511:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12512:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12513:                             ENDIF
12514:                         ENDIF
12515:                     ENDIF
12516:                 ENDIF
12517:             ENDIF
12518:         CATCH TO loc_oErro
12519:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12520:         ENDTRY
12521:     ENDPROC
12522: 
12523:     *--------------------------------------------------------------------------
12524:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12525:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12526:     *--------------------------------------------------------------------------
12527:     PROCEDURE ObsTarefasWhen()
12528:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12529:     ENDPROC
12530: 

*-- Linhas 12545 a 12569:
12545:     ENDPROC
12546: 
12547:     *--------------------------------------------------------------------------
12548:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12549:     * Legado: grdArquivos.Column1.Text1.When
12550:     *--------------------------------------------------------------------------
12551:     PROCEDURE GrdArquivosCol1When()
12552:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12553:     ENDPROC
12554: 
12555:     *--------------------------------------------------------------------------
12556:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12557:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12558:     *--------------------------------------------------------------------------
12559:     PROCEDURE BtnInsArqsWhen()
12560:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12561:     ENDPROC
12562: 
12563:     *--------------------------------------------------------------------------
12564:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12565:     * Legado: btnOpnArqs.When - Return .t.
12566:     *--------------------------------------------------------------------------
12567:     PROCEDURE BtnOpnArqsWhen()
12568:         RETURN .T.
12569:     ENDPROC

