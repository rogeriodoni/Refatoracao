# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 10889: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 11785: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 11914: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS GRID (12470 linhas total):

*-- Linhas 470 a 559:
470:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
471: 
472:         *----------------------------------------------------------------------
473:         *-- Criar cursor placeholder ANTES do grid (para RecordSource estavel)
474:         *-- Campos identicos ao que ProdutoBO.Buscar() cria
475:         *----------------------------------------------------------------------
476:         IF !USED("cursor_4c_Dados")
477:             CREATE CURSOR cursor_4c_Dados (;
478:                 cpros    C(14), dpros  C(65), cgrus C(3), ;
479:                 sgrus    C(6),  reffs  C(40), ;
480:                 usuaalts C(20), situas N(1,0))
481:         ENDIF
482: 
483:         *----------------------------------------------------------------------
484:         *-- Grid principal da lista (Grade: Top=183, Left=5)
485:         *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
486:         *----------------------------------------------------------------------
487:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
488:         WITH loc_oPagina.grd_4c_Lista
489:             .Top         = 183
490:             .Left        = 5
491:             .Width       = 950
492:             .Height      = 389
493:             .ColumnCount = 7
494:             .Visible     = .T.
495:             .RecordMark   = .F.
496:             .DeleteMark   = .F.
497:         ENDWITH
498: 
499:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
500:         loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
501: 
502:         *-- ControlSources e larguras APOS RecordSource
503:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
504:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
505:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
506:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
507: 
508:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
509:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
510:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
511:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
512: 
513:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
514:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
515:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
516:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
517: 
518:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
519:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrupo"
522: 
523:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
524:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
525:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
527: 
528:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
529:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
530:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
532: 
533:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
534:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
535:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
537: 
538:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
539:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
540: 
541:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
542:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
543:         WITH loc_oPagina.lbl_4c_Contagem
544:             .Caption   = "Produtos Selecionados : 0"
545:             .Top       = 575
546:             .Left      = 38
547:             .Width     = 200
548:             .Height    = 15
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .BackStyle = 0
552:             .ForeColor = RGB(90, 90, 90)
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         *-- Tornar controles visiveis (apenas prefixos validos)
557:         THIS.TornarControlesVisiveis(loc_oPagina)
558:     ENDPROC
559: 

*-- Linhas 725 a 780:
725:         *--         uni2(un cons), ord(ordem), matrizes(material alternativo)
726:         *----------------------------------------------------------------------
727:         IF !USED("cursor_4c_Compo")
728:             SET NULL ON
729:             CREATE CURSOR cursor_4c_Compo (;
730:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
731:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
732:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
733:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
734:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
735:                 cgrus    C(3),  moeds    C(5))
736:             SET NULL OFF
737:         ENDIF
738: 
739:         *----------------------------------------------------------------------
740:         *-- Cursor placeholder para grdsubcp (SigSubCp)
741:         *----------------------------------------------------------------------
742:         IF !USED("cursor_4c_SubCp")
743:             SET NULL ON
744:             CREATE CURSOR cursor_4c_SubCp (;
745:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
746:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
747:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
748:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
749:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
750:                 tamanhos C(20))
751:             SET NULL OFF
752:         ENDIF
753: 
754:         *----------------------------------------------------------------------
755:         *-- Cursor placeholder para GradeGRUPO (TotGrupo)
756:         *----------------------------------------------------------------------
757:         IF !USED("cursor_4c_Grupo")
758:             SET NULL ON
759:             CREATE CURSOR cursor_4c_Grupo (cgrus C(3), valgr N(12,4), moeds C(5))
760:             SET NULL OFF
761:         ENDIF
762: 
763:         *----------------------------------------------------------------------
764:         *-- Linha OBS da OF: Say4 + getObsOFs
765:         *-- Say4: "Obs. da OF :" (T:300 L:36 W:64)
766:         *-- getObsOFs: (T:297 L:99 W:850 H:21)
767:         *----------------------------------------------------------------------
768:         loc_oPg.AddObject("lbl_4c_ObsOF", "Label")
769:         WITH loc_oPg.lbl_4c_ObsOF
770:             .Caption   = "Obs. da OF :"
771:             .Top       = 300
772:             .Left      = 36
773:             .Width     = 64
774:             .Height    = 15
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .BackStyle = 0
778:             .ForeColor = RGB(90, 90, 90)
779:             .Visible   = .T.
780:         ENDWITH

*-- Linhas 864 a 1000:
864:         *-- Grid grdCompo (14 colunas) - Composicao do produto
865:         *-- Top:148 Left:6 Width:943 Height:147
866:         *----------------------------------------------------------------------
867:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
868:         WITH loc_oPg.grd_4c_Compo
869:             .Top         = 148
870:             .Left        = 6
871:             .Width       = 943
872:             .Height      = 147
873:             .ColumnCount = 14
874:             .FontName    = "Verdana"
875:             .FontSize    = 8
876:             .GridLines   = 3
877:             .GridLineWidth = 1
878:             .GridLineColor = RGB(238, 238, 238)
879:             .RecordMark  = .F.
880:             .DeleteMark  = .F.
881:             .AllowRowSizing = .F.
882:             .ReadOnly    = .F.
883:             .BackColor   = RGB(255, 255, 255)
884:             .ForeColor   = RGB(90, 90, 90)
885:             .HighlightBackColor = RGB(220, 230, 242)
886:             .HighlightForeColor = RGB(15, 41, 104)
887:             .HighlightStyle = 2
888:             .RowHeight   = 16
889:             .ScrollBars  = 2
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
894:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
895: 
896:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
897:         WITH loc_oPg.grd_4c_Compo
898:             *-- Col1: Material (C14) W:80
899:             .Column1.Header1.Caption       = "Material"
900:             .Column1.Width                 = 80
901:             .Column1.ControlSource         = "cursor_4c_Compo.mats"
902:             .Column1.Alignment             = 0
903: 
904:             *-- Col2: Descricao (C65) W:200
905:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
906:             .Column2.Width                 = 200
907:             .Column2.ControlSource         = "cursor_4c_Compo.dcomps"
908:             .Column2.Alignment             = 0
909: 
910:             *-- Col3: Un (C5) W:35 - readonly
911:             .Column3.Header1.Caption       = "Un"
912:             .Column3.Width                 = 35
913:             .Column3.ControlSource         = "cursor_4c_Compo.unicompos"
914:             .Column3.ReadOnly              = .T.
915: 
916:             *-- Col4: Valor (N) W:65
917:             .Column4.Header1.Caption       = "Valor"
918:             .Column4.Width                 = 65
919:             .Column4.ControlSource         = "cursor_4c_Compo.pcompos"
920:             .Column4.Alignment             = 1
921: 
922:             *-- Col5: Qtde (N) W:60
923:             .Column5.Header1.Caption       = "Qtde."
924:             .Column5.Width                 = 60
925:             .Column5.ControlSource         = "cursor_4c_Compo.qtds"
926:             .Column5.Alignment             = 1
927: 
928:             *-- Col6: Total (N) W:65 - readonly (calculado)
929:             .Column6.Header1.Caption       = "Total"
930:             .Column6.Width                 = 65
931:             .Column6.ControlSource         = "cursor_4c_Compo.totals"
932:             .Column6.Alignment             = 1
933:             .Column6.ReadOnly              = .T.
934: 
935:             *-- Col7: Moe (C5) W:35
936:             .Column7.Header1.Caption       = "Moe"
937:             .Column7.Width                 = 35
938:             .Column7.ControlSource         = "cursor_4c_Compo.bloqueio"
939: 
940:             *-- Col8: Observacao (C40) W:100
941:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
942:             .Column8.Width                 = 100
943:             .Column8.ControlSource         = "cursor_4c_Compo.obscompos"
944:             .Column8.Alignment             = 0
945: 
946:             *-- Col9: E (C1) W:25
947:             .Column9.Header1.Caption       = "E"
948:             .Column9.Width                 = 25
949:             .Column9.ControlSource         = "cursor_4c_Compo.etiq"
950: 
951:             *-- Col10: Consumo (N) W:65
952:             .Column10.Header1.Caption      = "Consumo"
953:             .Column10.Width                = 65
954:             .Column10.ControlSource        = "cursor_4c_Compo.consumo"
955:             .Column10.Alignment            = 1
956: 
957:             *-- Col11: Qtde cons (N) W:60
958:             .Column11.Header1.Caption      = "Qtde."
959:             .Column11.Width                = 60
960:             .Column11.ControlSource        = "cursor_4c_Compo.qtd2"
961:             .Column11.Alignment            = 1
962: 
963:             *-- Col12: Un cons (C5) W:35 - readonly
964:             .Column12.Header1.Caption      = "Un"
965:             .Column12.Width                = 35
966:             .Column12.ControlSource        = "cursor_4c_Compo.uni2"
967:             .Column12.ReadOnly             = .T.
968: 
969:             *-- Col13: Ord (N) W:35
970:             .Column13.Header1.Caption      = "Ord"
971:             .Column13.Width                = 35
972:             .Column13.ControlSource        = "cursor_4c_Compo.ord"
973:             .Column13.Alignment            = 1
974: 
975:             *-- Col14: Material alt (C14) W:83
976:             .Column14.Header1.Caption      = "Material"
977:             .Column14.Width                = 83
978:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
979:         ENDWITH
980:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
981: 
982:         *----------------------------------------------------------------------
983:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
984:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
985:         *----------------------------------------------------------------------
986:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
987:         WITH loc_oPg.cnt_4c_BotoesCompo
988:             .Top         = 145
989:             .Left        = 947
990:             .Width       = 50
991:             .Height      = 210
992:             .BackStyle = 1
993:             .BackColor = RGB(53, 53, 53)
994:             .BorderWidth = 0
995:             .Visible     = .T.
996:         ENDWITH
997: 
998:         *-- Botao 1: Inserir componente
999:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_InserirCompo", "CommandButton")
1000:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo

*-- Linhas 1091 a 1217:
1091:         *-- Grid grdsubcp (15 colunas) - Sub-componentes
1092:         *-- Top:348 Left:6 Width:943 Height:83
1093:         *----------------------------------------------------------------------
1094:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
1095:         WITH loc_oPg.grd_4c_SubCp
1096:             .Top         = 348
1097:             .Left        = 6
1098:             .Width       = 943
1099:             .Height      = 83
1100:             .ColumnCount = 15
1101:             .FontName    = "Verdana"
1102:             .FontSize    = 8
1103:             .GridLines   = 3
1104:             .GridLineWidth = 1
1105:             .GridLineColor = RGB(238, 238, 238)
1106:             .RecordMark  = .F.
1107:             .DeleteMark  = .F.
1108:             .AllowRowSizing = .F.
1109:             .ReadOnly    = .F.
1110:             .BackColor   = RGB(255, 255, 255)
1111:             .ForeColor   = RGB(90, 90, 90)
1112:             .HighlightBackColor = RGB(220, 230, 242)
1113:             .HighlightForeColor = RGB(15, 41, 104)
1114:             .HighlightStyle = 2
1115:             .RowHeight   = 16
1116:             .ScrollBars  = 2
1117:             .Visible     = .T.
1118:         ENDWITH
1119: 
1120:         *-- RecordSource FORA do WITH
1121:         loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
1122: 
1123:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1124:         WITH loc_oPg.grd_4c_SubCp
1125:             .Column1.Header1.Caption       = "Material"
1126:             .Column1.Width                 = 75
1127:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1128: 
1129:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
1130:             .Column2.Width                 = 175
1131:             .Column2.ControlSource         = "cursor_4c_SubCp.dcomps"
1132:             .Column2.Alignment             = 0
1133: 
1134:             .Column3.Header1.Caption       = "Un"
1135:             .Column3.Width                 = 30
1136:             .Column3.ControlSource         = "cursor_4c_SubCp.unicompos"
1137:             .Column3.ReadOnly              = .T.
1138: 
1139:             .Column4.Header1.Caption       = "Valor"
1140:             .Column4.Width                 = 60
1141:             .Column4.ControlSource         = "cursor_4c_SubCp.pcompos"
1142:             .Column4.Alignment             = 1
1143: 
1144:             .Column5.Header1.Caption       = "Qtde."
1145:             .Column5.Width                 = 55
1146:             .Column5.ControlSource         = "cursor_4c_SubCp.qtds"
1147:             .Column5.Alignment             = 1
1148: 
1149:             .Column6.Header1.Caption       = "Total"
1150:             .Column6.Width                 = 60
1151:             .Column6.ControlSource         = "cursor_4c_SubCp.totals"
1152:             .Column6.Alignment             = 1
1153:             .Column6.ReadOnly              = .T.
1154: 
1155:             .Column7.Header1.Caption       = "Moe"
1156:             .Column7.Width                 = 30
1157:             .Column7.ControlSource         = "cursor_4c_SubCp.bloqueio"
1158: 
1159:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
1160:             .Column8.Width                 = 90
1161:             .Column8.ControlSource         = "cursor_4c_SubCp.obscompos"
1162:             .Column8.Alignment             = 0
1163: 
1164:             .Column9.Header1.Caption       = "E"
1165:             .Column9.Width                 = 25
1166:             .Column9.ControlSource         = "cursor_4c_SubCp.etiq"
1167: 
1168:             .Column10.Header1.Caption      = "Consumo"
1169:             .Column10.Width                = 60
1170:             .Column10.ControlSource        = "cursor_4c_SubCp.consumo"
1171:             .Column10.Alignment            = 1
1172: 
1173:             .Column11.Header1.Caption      = "Qtde."
1174:             .Column11.Width                = 55
1175:             .Column11.ControlSource        = "cursor_4c_SubCp.qtd2"
1176:             .Column11.Alignment            = 1
1177: 
1178:             .Column12.Header1.Caption      = "Un"
1179:             .Column12.Width                = 30
1180:             .Column12.ControlSource        = "cursor_4c_SubCp.uni2"
1181:             .Column12.ReadOnly             = .T.
1182: 
1183:             .Column13.Header1.Caption      = "Ord"
1184:             .Column13.Width                = 30
1185:             .Column13.ControlSource        = "cursor_4c_SubCp.ord"
1186:             .Column13.Alignment            = 1
1187: 
1188:             .Column14.Header1.Caption      = "Material"
1189:             .Column14.Width                = 80
1190:             .Column14.ControlSource        = "cursor_4c_SubCp.matrizes"
1191: 
1192:             .Column15.Header1.Caption      = "Tam"
1193:             .Column15.Width                = 88
1194:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1195:             .Column15.Alignment            = 0
1196:         ENDWITH
1197:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1198: 
1199:         *----------------------------------------------------------------------
1200:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1201:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1202:         *----------------------------------------------------------------------
1203:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1204:         WITH loc_oPg.cnt_4c_BotoesSubCp
1205:             .Top         = 345
1206:             .Left        = 947
1207:             .Width       = 50
1208:             .Height      = 90
1209:             .BackStyle = 1
1210:             .BackColor = RGB(53, 53, 53)
1211:             .BorderWidth = 0
1212:             .Visible     = .T.
1213:         ENDWITH
1214: 
1215:         *-- Botao 1: Inserir sub-componente
1216:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_InserirSubCp", "CommandButton")
1217:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp

*-- Linhas 1319 a 1384:
1319:         *-- Grid GradeGRUPO (3 colunas) - Totais por grupo
1320:         *-- Top:34 Left:582 Width:229 Height:107
1321:         *----------------------------------------------------------------------
1322:         loc_oPg.AddObject("grd_4c_Grupo", "Grid")
1323:         WITH loc_oPg.grd_4c_Grupo
1324:             .Top         = 34
1325:             .Left        = 582
1326:             .Width       = 229
1327:             .Height      = 107
1328:             .ColumnCount = 3
1329:             .FontName    = "Verdana"
1330:             .FontSize    = 8
1331:             .GridLines   = 3
1332:             .GridLineWidth = 1
1333:             .GridLineColor = RGB(238, 238, 238)
1334:             .RecordMark  = .F.
1335:             .DeleteMark  = .F.
1336:             .AllowRowSizing = .F.
1337:             .ReadOnly    = .T.
1338:             .BackColor   = RGB(255, 255, 255)
1339:             .ForeColor   = RGB(90, 90, 90)
1340:             .HighlightBackColor = RGB(220, 230, 242)
1341:             .HighlightForeColor = RGB(15, 41, 104)
1342:             .HighlightStyle = 2
1343:             .RowHeight   = 16
1344:             .ScrollBars  = 2
1345:             .Visible     = .T.
1346:         ENDWITH
1347: 
1348:         *-- RecordSource FORA do WITH
1349:         loc_oPg.grd_4c_Grupo.RecordSource = "cursor_4c_Grupo"
1350: 
1351:         *-- Colunas do GradeGRUPO APOS RecordSource
1352:         WITH loc_oPg.grd_4c_Grupo
1353:             .Column1.Header1.Caption = "Grupo"
1354:             .Column1.Width           = 50
1355:             .Column1.ControlSource   = "cursor_4c_Grupo.cgrus"
1356: 
1357:             .Column2.Header1.Caption = "Total "
1358:             .Column2.Width           = 100
1359:             .Column2.ControlSource   = "cursor_4c_Grupo.valgr"
1360:             .Column2.Alignment       = 1
1361: 
1362:             .Column3.Header1.Caption = "Moeda"
1363:             .Column3.Width           = 79
1364:             .Column3.ControlSource   = "cursor_4c_Grupo.moeds"
1365:         ENDWITH
1366: 
1367:         *----------------------------------------------------------------------
1368:         *-- Labels de secao Custo / Venda
1369:         *-- Say1: " Custo " (T:473 L:47 W:46 - secao de custo)
1370:         *-- Say2: " Venda " (T:474 L:361 W:48 - secao de venda)
1371:         *----------------------------------------------------------------------
1372:         loc_oPg.AddObject("lbl_4c_SecCusto", "Label")
1373:         WITH loc_oPg.lbl_4c_SecCusto
1374:             .Caption   = " Custo "
1375:             .Top       = 473
1376:             .Left      = 47
1377:             .Width     = 46
1378:             .Height    = 16
1379:             .FontName  = "Tahoma"
1380:             .FontSize  = 8
1381:             .FontBold  = .T.
1382:             .BackStyle = 1
1383:             .BackColor = RGB(192, 192, 192)
1384:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 2556 a 2702:
2556:             IF USED("cursor_4c_Compo")
2557:                 SELECT cursor_4c_Compo
2558:                 APPEND BLANK
2559:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2560:             ENDIF
2561:         CATCH TO loc_oErro
2562:             MsgErro(loc_oErro.Message, "Erro ao inserir componente")
2563:         ENDTRY
2564:     ENDPROC
2565: 
2566:     *--------------------------------------------------------------------------
2567:     * CmdExcluirCompoClick - Remove linha da composicao
2568:     *--------------------------------------------------------------------------
2569:     PROCEDURE CmdExcluirCompoClick()
2570:         LOCAL loc_lConfirma
2571:         TRY
2572:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2573:                 RETURN
2574:             ENDIF
2575:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2576:                 loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
2577:                 IF loc_lConfirma
2578:                     SELECT cursor_4c_Compo
2579:                     DELETE
2580:                     IF !EOF()
2581:                         SKIP
2582:                         SKIP -1
2583:                     ENDIF
2584:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2585:                 ENDIF
2586:             ENDIF
2587:         CATCH TO loc_oErro
2588:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
2589:         ENDTRY
2590:     ENDPROC
2591: 
2592:     *--------------------------------------------------------------------------
2593:     * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
2594:     *--------------------------------------------------------------------------
2595:     PROCEDURE CmdCalcFornecClick()
2596:         TRY
2597:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2598:                 RETURN
2599:             ENDIF
2600:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2601:                 THIS.this_oBusinessObject.CalcFornec()
2602:             ENDIF
2603:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2604:         CATCH TO loc_oErro
2605:             MsgErro(loc_oErro.Message, "Erro ao calcular por fornecedor")
2606:         ENDTRY
2607:     ENDPROC
2608: 
2609:     *--------------------------------------------------------------------------
2610:     * CmdAtualizarCompoClick - Atualiza composicao (recalcula totais/grupos)
2611:     *--------------------------------------------------------------------------
2612:     PROCEDURE CmdAtualizarCompoClick()
2613:         TRY
2614:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2615:                 RETURN
2616:             ENDIF
2617:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2618:                 THIS.this_oBusinessObject.AtualizarComposicao()
2619:             ENDIF
2620:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2621:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Grupo.Refresh()
2622:         CATCH TO loc_oErro
2623:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
2624:         ENDTRY
2625:     ENDPROC
2626: 
2627:     *--------------------------------------------------------------------------
2628:     * CmdAtualizarPesosClick - Atualiza pesos medios dos componentes
2629:     *--------------------------------------------------------------------------
2630:     PROCEDURE CmdAtualizarPesosClick()
2631:         TRY
2632:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2633:                 THIS.this_oBusinessObject.AtualizarPesos()
2634:             ENDIF
2635:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2636:         CATCH TO loc_oErro
2637:             MsgErro(loc_oErro.Message, "Erro ao atualizar pesos")
2638:         ENDTRY
2639:     ENDPROC
2640: 
2641:     *--------------------------------------------------------------------------
2642:     * CmdInserirSubCpClick - Adiciona linha no grid de sub-componentes
2643:     *--------------------------------------------------------------------------
2644:     PROCEDURE CmdInserirSubCpClick()
2645:         TRY
2646:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2647:                 RETURN
2648:             ENDIF
2649:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
2650:                !EMPTY(cursor_4c_Compo.mats)
2651:                 IF USED("cursor_4c_SubCp")
2652:                     SELECT cursor_4c_SubCp
2653:                     APPEND BLANK
2654:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2655:                 ENDIF
2656:             ELSE
2657:                 MsgAviso("Selecione um componente antes de adicionar sub-componente.")
2658:             ENDIF
2659:         CATCH TO loc_oErro
2660:             MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
2661:         ENDTRY
2662:     ENDPROC
2663: 
2664:     *--------------------------------------------------------------------------
2665:     * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
2666:     *--------------------------------------------------------------------------
2667:     PROCEDURE CmdExcluirSubCpClick()
2668:         LOCAL loc_lConfirma
2669:         TRY
2670:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2671:                 RETURN
2672:             ENDIF
2673:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2674:                 loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
2675:                 IF loc_lConfirma
2676:                     SELECT cursor_4c_SubCp
2677:                     DELETE
2678:                     IF !EOF()
2679:                         SKIP
2680:                         SKIP -1
2681:                     ENDIF
2682:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2683:                 ENDIF
2684:             ENDIF
2685:         CATCH TO loc_oErro
2686:             MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
2687:         ENDTRY
2688:     ENDPROC
2689: 
2690:     *--------------------------------------------------------------------------
2691:     * CmdCalcValsClick - Calcular valores de preco/custo/venda
2692:     *--------------------------------------------------------------------------
2693:     PROCEDURE CmdCalcValsClick()
2694:         TRY
2695:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2696:                 THIS.this_oBusinessObject.CalcVals()
2697:             ENDIF
2698:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Refresh()
2699:         CATCH TO loc_oErro
2700:             MsgErro(loc_oErro.Message, "Erro ao calcular valores")
2701:         ENDTRY
2702:     ENDPROC

*-- Linhas 2834 a 2858:
2834:                 "Buscar Moeda")
2835:             IF VARTYPE(loc_oBusca) = "O"
2836:                 IF !loc_oBusca.this_lAchouRegistro
2837:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
2838:                     loc_oBusca.mAddColuna("DMoes", "", "Moeda")
2839:                     loc_oBusca.Show()
2840:                 ENDIF
2841:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2842:                     loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2843:                 ENDIF
2844:                 loc_oBusca.Release()
2845:             ENDIF
2846:             IF USED("cursor_4c_BuscaMoe")
2847:                 USE IN cursor_4c_BuscaMoe
2848:             ENDIF
2849:         CATCH TO loc_oErro
2850:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
2851:         ENDTRY
2852:     ENDPROC
2853: 
2854:     *--------------------------------------------------------------------------
2855:     * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
2856:     *--------------------------------------------------------------------------
2857:     PROCEDURE ValidarMoedaCompo(par_cCampo)
2858:         LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet

*-- Linhas 2945 a 2970:
2945:                     "Fator de Custo")
2946:                 IF VARTYPE(loc_oBusca) = "O"
2947:                     IF !loc_oBusca.this_lAchouRegistro
2948:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
2949:                         loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2950:                         loc_oBusca.mAddColuna("Moedas", "", "Moeda")
2951:                         loc_oBusca.Show()
2952:                     ENDIF
2953:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
2954:                         loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
2955:                     ENDIF
2956:                     loc_oBusca.Release()
2957:                 ENDIF
2958:                 IF USED("cursor_4c_BuscaFtioCusto")
2959:                     USE IN cursor_4c_BuscaFtioCusto
2960:                 ENDIF
2961:             ENDIF
2962:             IF USED("cursor_4c_ListaFtioCusto")
2963:                 USE IN cursor_4c_ListaFtioCusto
2964:             ENDIF
2965:         CATCH TO loc_oErro
2966:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de custo")
2967:         ENDTRY
2968:     ENDPROC
2969: 
2970:     *--------------------------------------------------------------------------

*-- Linhas 3024 a 3048:
3024:                     "Fator de Venda")
3025:                 IF VARTYPE(loc_oBusca) = "O"
3026:                     IF !loc_oBusca.this_lAchouRegistro
3027:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3028:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3029:                         loc_oBusca.Show()
3030:                     ENDIF
3031:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
3032:                         loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
3033:                     ENDIF
3034:                     loc_oBusca.Release()
3035:                 ENDIF
3036:                 IF USED("cursor_4c_BuscaFtioVenda")
3037:                     USE IN cursor_4c_BuscaFtioVenda
3038:                 ENDIF
3039:             ENDIF
3040:             IF USED("cursor_4c_ListaFtioVenda")
3041:                 USE IN cursor_4c_ListaFtioVenda
3042:             ENDIF
3043:         CATCH TO loc_oErro
3044:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de venda")
3045:         ENDTRY
3046:     ENDPROC
3047: 
3048:     *--------------------------------------------------------------------------

*-- Linhas 3104 a 3128:
3104:                 "Buscar Status")
3105:             IF VARTYPE(loc_oBusca) = "O"
3106:                 IF !loc_oBusca.this_lAchouRegistro
3107:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3108:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3109:                     loc_oBusca.Show()
3110:                 ENDIF
3111:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSts")
3112:                     loc_oPg.txt_4c_GetStatus.Value = ALLTRIM(cursor_4c_BuscaSts.Cods)
3113:                 ENDIF
3114:                 loc_oBusca.Release()
3115:             ENDIF
3116:             IF USED("cursor_4c_BuscaSts")
3117:                 USE IN cursor_4c_BuscaSts
3118:             ENDIF
3119:         CATCH TO loc_oErro
3120:             MsgErro(loc_oErro.Message, "Erro ao buscar status")
3121:         ENDTRY
3122:     ENDPROC
3123: 
3124:     *--------------------------------------------------------------------------
3125:     * TxtMarkupALostFocus - Recalcular ao sair do markup aplicado
3126:     *--------------------------------------------------------------------------
3127:     PROCEDURE TxtMarkupALostFocus()
3128:         THIS.CalcPrecoCompo()

*-- Linhas 3214 a 3238:
3214:                 "Buscar Material Principal")
3215:             IF VARTYPE(loc_oBusca) = "O"
3216:                 IF !loc_oBusca.this_lAchouRegistro
3217:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
3218:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3219:                     loc_oBusca.Show()
3220:                 ENDIF
3221:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatP")
3222:                     loc_oPg.txt_4c_MatP.Value  = ALLTRIM(cursor_4c_BuscaMatP.cpros)
3223:                     loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_BuscaMatP.dpros)
3224:                 ENDIF
3225:                 loc_oBusca.Release()
3226:             ENDIF
3227:             IF USED("cursor_4c_BuscaMatP")
3228:                 USE IN cursor_4c_BuscaMatP
3229:             ENDIF
3230:         CATCH TO loc_oErro
3231:             MsgErro(loc_oErro.Message, "Erro ao buscar material principal")
3232:         ENDTRY
3233:     ENDPROC
3234: 
3235:     *--------------------------------------------------------------------------
3236:     * CarregarLista - Carrega registros no grid usando filtros da UI
3237:     * Legado: fCarregaGrade() leia cntFiltros.getCgru/optFilSituas
3238:     *--------------------------------------------------------------------------

*-- Linhas 3272 a 3303:
3272:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3273: 
3274:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3275:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3276:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3277:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3278:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3279:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
3280:                     loc_oGrid.Column4.Header1.Caption = "Subgrupo"
3281:                     loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
3282:                     loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
3283:                     loc_oGrid.Column7.Header1.Caption = "I"
3284:                     loc_oGrid.Refresh()
3285:                 ENDIF
3286: 
3287:                 *-- Atualizar contagem
3288:                 IF VARTYPE(loc_oPagina.lbl_4c_Contagem) = "O"
3289:                     loc_oPagina.lbl_4c_Contagem.Caption = "Produtos Selecionados : " + ;
3290:                         TRANSFORM(RECCOUNT("cursor_4c_Dados"))
3291:                 ENDIF
3292: 
3293:                 loc_lResultado = .T.
3294:             ENDIF
3295: 
3296:         CATCH TO loException
3297:             MsgErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3298:             loc_lResultado = .F.
3299:         ENDTRY
3300: 
3301:         RETURN loc_lResultado
3302:     ENDPROC
3303: 

*-- Linhas 3382 a 3406:
3382:                 "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", "", ;
3383:                 "Buscar Grupo de Produto")
3384: 
3385:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3386:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3387:             loc_oBusca.Show()
3388: 
3389:             IF loc_oBusca.this_lSelecionou
3390:                 IF USED("cursor_4c_BuscaGrupo")
3391:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
3392:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
3393:                     THIS.CarregarLista()
3394:                 ENDIF
3395:             ENDIF
3396: 
3397:             IF USED("cursor_4c_BuscaGrupo")
3398:                 USE IN cursor_4c_BuscaGrupo
3399:             ENDIF
3400:             loc_oBusca.Release()
3401: 
3402:         CATCH TO loc_oErro
3403:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
3404:         ENDTRY
3405:     ENDPROC
3406: 

*-- Linhas 3608 a 3633:
3608:         TRY
3609:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
3610: 
3611:             loc_oBusca.mAddColuna("cpros", "", "Produto")
3612:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3613:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3614: 
3615:             loc_oBusca.Show()
3616: 
3617:             IF loc_oBusca.this_lSelecionou
3618:                 IF USED("cursor_4c_Busca")
3619:                     LOCAL loc_cCodigo
3620:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
3621: 
3622:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3623:                         THIS.BOParaForm()
3624:                         THIS.this_cModoAtual = "VISUALIZAR"
3625:                         THIS.HabilitarCampos(.F.)
3626:                         THIS.AlternarPagina(2)
3627:                     ENDIF
3628:                 ENDIF
3629:             ENDIF
3630: 
3631:             IF USED("cursor_4c_Busca")
3632:                 USE IN cursor_4c_Busca
3633:             ENDIF

*-- Linhas 4753 a 4777:
4753:                     ENDIF
4754:                 ELSE
4755:                     IF !loc_oBusca.this_lAchouRegistro
4756:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
4757:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4758:                     loc_oBusca.Show()
4759:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
4760:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4761:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4762:                         loc_oPg.txt_4c_CSGru.Value = ""
4763:                         loc_oPg.txt_4c_DsGru.Value = ""
4764:                     ENDIF
4765:                     ENDIF
4766:                 ENDIF
4767:                 loc_oBusca.Release()
4768:             ENDIF
4769:             IF USED("cursor_4c_BuscaGruP")
4770:                 USE IN cursor_4c_BuscaGruP
4771:             ENDIF
4772:         CATCH TO loc_oErro
4773:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
4774:         ENDTRY
4775:     ENDPROC
4776: 
4777:     *--------------------------------------------------------------------------

*-- Linhas 4836 a 4860:
4836:                     ENDIF
4837:                 ELSE
4838:                     IF !loc_oBusca.this_lAchouRegistro
4839:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4840:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4841:                     loc_oBusca.Show()
4842:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4843:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4844:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4845:                     ENDIF
4846:                     ENDIF
4847:                 ENDIF
4848:                 loc_oBusca.Release()
4849:             ENDIF
4850:             IF USED("cursor_4c_BuscaSGru")
4851:                 USE IN cursor_4c_BuscaSGru
4852:             ENDIF
4853:         CATCH TO loc_oErro
4854:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
4855:         ENDTRY
4856:     ENDPROC
4857: 
4858:     *--------------------------------------------------------------------------
4859:     * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
4860:     *--------------------------------------------------------------------------

*-- Linhas 4913 a 4937:
4913:                     ENDIF
4914:                 ELSE
4915:                     IF !loc_oBusca.this_lAchouRegistro
4916:                     loc_oBusca.mAddColuna("linhas", "", "Linha")
4917:                     loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4918:                     loc_oBusca.Show()
4919:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
4920:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4921:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4922:                     ENDIF
4923:                     ENDIF
4924:                 ENDIF
4925:                 loc_oBusca.Release()
4926:             ENDIF
4927:             IF USED("cursor_4c_BuscaLin")
4928:                 USE IN cursor_4c_BuscaLin
4929:             ENDIF
4930:         CATCH TO loc_oErro
4931:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
4932:         ENDTRY
4933:     ENDPROC
4934: 
4935:     *--------------------------------------------------------------------------
4936:     * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
4937:     *--------------------------------------------------------------------------

*-- Linhas 4990 a 5014:
4990:                     ENDIF
4991:                 ELSE
4992:                     IF !loc_oBusca.this_lAchouRegistro
4993:                     loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
4994:                     loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
4995:                     loc_oBusca.Show()
4996:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
4997:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
4998:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
4999:                     ENDIF
5000:                     ENDIF
5001:                 ENDIF
5002:                 loc_oBusca.Release()
5003:             ENDIF
5004:             IF USED("cursor_4c_BuscaCol")
5005:                 USE IN cursor_4c_BuscaCol
5006:             ENDIF
5007:         CATCH TO loc_oErro
5008:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
5009:         ENDTRY
5010:     ENDPROC
5011: 
5012:     *--------------------------------------------------------------------------
5013:     * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
5014:     *--------------------------------------------------------------------------

*-- Linhas 5067 a 5091:
5067:                     ENDIF
5068:                 ELSE
5069:                     IF !loc_oBusca.this_lAchouRegistro
5070:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5071:                     loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
5072:                     loc_oBusca.Show()
5073:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5074:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5075:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5076:                     ENDIF
5077:                     ENDIF
5078:                 ENDIF
5079:                 loc_oBusca.Release()
5080:             ENDIF
5081:             IF USED("cursor_4c_BuscaIfor")
5082:                 USE IN cursor_4c_BuscaIfor
5083:             ENDIF
5084:         CATCH TO loc_oErro
5085:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
5086:         ENDTRY
5087:     ENDPROC
5088: 
5089:     *--------------------------------------------------------------------------
5090:     * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
5091:     *--------------------------------------------------------------------------

*-- Linhas 5139 a 5163:
5139:                     ENDIF
5140:                 ELSE
5141:                     IF !loc_oBusca.this_lAchouRegistro
5142:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
5143:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
5144:                     loc_oBusca.Show()
5145:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
5146:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5147:                     ENDIF
5148:                     ENDIF
5149:                 ENDIF
5150:                 loc_oBusca.Release()
5151:             ENDIF
5152:             IF USED("cursor_4c_BuscaProEq")
5153:                 USE IN cursor_4c_BuscaProEq
5154:             ENDIF
5155:         CATCH TO loc_oErro
5156:             MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
5157:         ENDTRY
5158:     ENDPROC
5159: 
5160:     *--------------------------------------------------------------------------
5161:     * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
5162:     *--------------------------------------------------------------------------
5163:     PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5185 a 5208:
5185:                 IF VARTYPE(loc_oBusca) = "O"
5186:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5187:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5188:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5189:                     loc_oBusca.Show()
5190:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5191:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5192:                     ENDIF
5193:                     loc_oBusca.Release()
5194:                 ENDIF
5195:             ENDIF
5196: 
5197:             IF USED("cursor_4c_BuscaCnj")
5198:                 USE IN cursor_4c_BuscaCnj
5199:             ENDIF
5200:         CATCH TO loc_oErro
5201:             MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
5202:         ENDTRY
5203:     ENDPROC
5204: 
5205:     *==========================================================================
5206:     * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
5207:     *==========================================================================
5208: 

*-- Linhas 6815 a 6839:
6815:                     ENDIF
6816:                 ELSE
6817:                     IF !loc_oBusca.this_lAchouRegistro
6818:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6819:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6820:                     loc_oBusca.Show()
6821:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6822:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6823:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6824:                     ENDIF
6825:                     ENDIF
6826:                 ENDIF
6827:                 loc_oBusca.Release()
6828:             ENDIF
6829:             IF USED("cursor_4c_BuscaUni")
6830:                 USE IN cursor_4c_BuscaUni
6831:             ENDIF
6832:         CATCH TO loc_oErro
6833:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6834:         ENDTRY
6835:     ENDPROC
6836: 
6837:     *--------------------------------------------------------------------------
6838:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6839:     *--------------------------------------------------------------------------

*-- Linhas 6892 a 6916:
6892:                     ENDIF
6893:                 ELSE
6894:                     IF !loc_oBusca.this_lAchouRegistro
6895:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6896:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6897:                     loc_oBusca.Show()
6898:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6899:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6900:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6901:                     ENDIF
6902:                     ENDIF
6903:                 ENDIF
6904:                 loc_oBusca.Release()
6905:             ENDIF
6906:             IF USED("cursor_4c_BuscaUnip")
6907:                 USE IN cursor_4c_BuscaUnip
6908:             ENDIF
6909:         CATCH TO loc_oErro
6910:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6911:         ENDTRY
6912:     ENDPROC
6913: 
6914:     *--------------------------------------------------------------------------
6915:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6916:     *--------------------------------------------------------------------------

*-- Linhas 6969 a 6993:
6969:                     ENDIF
6970:                 ELSE
6971:                     IF !loc_oBusca.this_lAchouRegistro
6972:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6973:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6974:                     loc_oBusca.Show()
6975:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6976:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6977:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6978:                     ENDIF
6979:                     ENDIF
6980:                 ENDIF
6981:                 loc_oBusca.Release()
6982:             ENDIF
6983:             IF USED("cursor_4c_BuscaFinP")
6984:                 USE IN cursor_4c_BuscaFinP
6985:             ENDIF
6986:         CATCH TO loc_oErro
6987:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
6988:         ENDTRY
6989:     ENDPROC
6990: 
6991:     *--------------------------------------------------------------------------
6992:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
6993:     *--------------------------------------------------------------------------

*-- Linhas 7046 a 7070:
7046:                     ENDIF
7047:                 ELSE
7048:                     IF !loc_oBusca.this_lAchouRegistro
7049:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7050:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7051:                     loc_oBusca.Show()
7052:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7053:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7054:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7055:                     ENDIF
7056:                     ENDIF
7057:                 ENDIF
7058:                 loc_oBusca.Release()
7059:             ENDIF
7060:             IF USED("cursor_4c_BuscaAcb")
7061:                 USE IN cursor_4c_BuscaAcb
7062:             ENDIF
7063:         CATCH TO loc_oErro
7064:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7065:         ENDTRY
7066:     ENDPROC
7067: 
7068:     *--------------------------------------------------------------------------
7069:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7070:     * SigCdCls: filtrado por cgrus do grupo de produto corrente

*-- Linhas 7128 a 7152:
7128:                     ENDIF
7129:                 ELSE
7130:                     IF !loc_oBusca.this_lAchouRegistro
7131:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7132:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7133:                     loc_oBusca.Show()
7134:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7135:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7136:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7137:                     ENDIF
7138:                     ENDIF
7139:                 ENDIF
7140:                 loc_oBusca.Release()
7141:             ENDIF
7142:             IF USED("cursor_4c_BuscaClass")
7143:                 USE IN cursor_4c_BuscaClass
7144:             ENDIF
7145:         CATCH TO loc_oErro
7146:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7147:         ENDTRY
7148:     ENDPROC
7149: 
7150:     *--------------------------------------------------------------------------
7151:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7152:     *--------------------------------------------------------------------------

*-- Linhas 7200 a 7224:
7200:                     ENDIF
7201:                 ELSE
7202:                     IF !loc_oBusca.this_lAchouRegistro
7203:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7204:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7205:                     loc_oBusca.Show()
7206:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7207:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7208:                     ENDIF
7209:                     ENDIF
7210:                 ENDIF
7211:                 loc_oBusca.Release()
7212:             ENDIF
7213:             IF USED("cursor_4c_BuscaLocal")
7214:                 USE IN cursor_4c_BuscaLocal
7215:             ENDIF
7216:         CATCH TO loc_oErro
7217:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7218:         ENDTRY
7219:     ENDPROC
7220: 
7221:     *==========================================================================
7222:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7223:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7224:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

*-- Linhas 7235 a 7391:
7235:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7236:         *----------------------------------------------------------------------
7237:         IF !USED("cursor_4c_GrdCons")
7238:             SET NULL ON
7239:             CREATE CURSOR cursor_4c_GrdCons (;
7240:                 mats      C(14), ;
7241:                 qtds      N(12,4), ;
7242:                 unicompos C(5), ;
7243:                 Grupos    C(3), ;
7244:                 Descrs    C(65), ;
7245:                 Ordems    N(5,0), ;
7246:                 consumo   N(12,4), ;
7247:                 Cods      C(5), ;
7248:                 dcats     C(65), ;
7249:                 Dopes     C(5))
7250:             SET NULL OFF
7251:         ENDIF
7252: 
7253:         *----------------------------------------------------------------------
7254:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7255:         *----------------------------------------------------------------------
7256:         IF !USED("cursor_4c_GrDTEMP")
7257:             SET NULL ON
7258:             CREATE CURSOR cursor_4c_GrDTEMP (;
7259:                 agrup C(30), ;
7260:                 tempo N(12,4))
7261:             SET NULL OFF
7262:         ENDIF
7263: 
7264:         *----------------------------------------------------------------------
7265:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7266:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7267:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7268:         *----------------------------------------------------------------------
7269:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7270:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7271: 
7272:         WITH loc_oGrd
7273:             .Top              = 155
7274:             .Left             = 6
7275:             .Width            = 987
7276:             .Height           = 362
7277:             .FontName         = "Tahoma"
7278:             .FontSize         = 8
7279:             .ColumnCount      = 9
7280:             .GridLines        = 3
7281:             .GridLineWidth    = 1
7282:             .GridLineColor    = RGB(238, 238, 238)
7283:             .RecordMark       = .F.
7284:             .DeleteMark       = .F.
7285:             .AllowRowSizing   = .F.
7286:             .ReadOnly         = .F.
7287:             .BackColor        = RGB(255, 255, 255)
7288:             .ForeColor        = RGB(90, 90, 90)
7289:             .HighlightBackColor = RGB(220, 230, 242)
7290:             .HighlightForeColor = RGB(15, 41, 104)
7291:             .HighlightStyle   = 2
7292:             .RowHeight        = 16
7293:             .ScrollBars       = 2
7294:             .Themes           = .F.
7295:             .Visible          = .T.
7296:         ENDWITH
7297: 
7298:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7299:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7300: 
7301:         *-- Configurar colunas APOS RecordSource
7302:         WITH loc_oPg.grd_4c_GrdCons
7303:             *-- Col1: Componente (mats C14) W:140 - readonly
7304:             .Column1.Header1.Caption = "Componente"
7305:             .Column1.Width           = 140
7306:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7307:             .Column1.Alignment       = 0
7308:             .Column1.ReadOnly        = .T.
7309: 
7310:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7311:             .Column2.Header1.Caption = "Qtde."
7312:             .Column2.Width           = 70
7313:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7314:             .Column2.Alignment       = 1
7315:             .Column2.ReadOnly        = .T.
7316: 
7317:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7318:             .Column3.Header1.Caption = "Uni"
7319:             .Column3.Width           = 40
7320:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7321:             .Column3.Alignment       = 0
7322:             .Column3.ReadOnly        = .T.
7323: 
7324:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7325:             .Column4.Header1.Caption = "Fase"
7326:             .Column4.Width           = 45
7327:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7328:             .Column4.Alignment       = 0
7329:             .Column4.ReadOnly        = .F.
7330: 
7331:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7332:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7333:             .Column5.Width           = 250
7334:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7335:             .Column5.Alignment       = 0
7336:             .Column5.ReadOnly        = .F.
7337: 
7338:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7339:             .Column6.Header1.Caption = "Ord."
7340:             .Column6.Width           = 40
7341:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7342:             .Column6.Alignment       = 1
7343:             .Column6.ReadOnly        = .T.
7344: 
7345:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7346:             .Column7.Header1.Caption = "Consumo"
7347:             .Column7.Width           = 80
7348:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7349:             .Column7.Alignment       = 1
7350:             .Column7.ReadOnly        = .F.
7351: 
7352:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7353:             .Column8.Header1.Caption = "Cat."
7354:             .Column8.Width           = 45
7355:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7356:             .Column8.Alignment       = 0
7357:             .Column8.ReadOnly        = .F.
7358: 
7359:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7360:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7361:             .Column9.Width           = 277
7362:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7363:             .Column9.Alignment       = 0
7364:             .Column9.ReadOnly        = .F.
7365:         ENDWITH
7366: 
7367:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7368:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7369:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7370:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7371:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7372: 
7373:         *----------------------------------------------------------------------
7374:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7375:         *----------------------------------------------------------------------
7376:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7377:         WITH loc_oPg.lbl_4c_Label7
7378:             .Caption   = "Qtde Componentes : "
7379:             .Top       = 523
7380:             .Left      = 25
7381:             .Width     = 105
7382:             .Height    = 15
7383:             .FontName  = "Tahoma"
7384:             .FontSize  = 8
7385:             .BackStyle = 0
7386:             .ForeColor = RGB(90, 90, 90)
7387:             .Visible   = .T.
7388:         ENDWITH
7389: 
7390:         *----------------------------------------------------------------------
7391:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)

*-- Linhas 7450 a 7686:
7450:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.grDTEMP
7451:         *-- Cols: Agrupamento, Tempo %  (ambas read-only)
7452:         *----------------------------------------------------------------------
7453:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
7454: 
7455:         WITH loc_oPg.grd_4c_GrDTEMP
7456:             .Top              = 519
7457:             .Left             = 821
7458:             .Width            = 172
7459:             .Height           = 107
7460:             .FontName         = "Tahoma"
7461:             .FontSize         = 8
7462:             .ColumnCount      = 2
7463:             .GridLines        = 3
7464:             .GridLineWidth    = 1
7465:             .GridLineColor    = RGB(238, 238, 238)
7466:             .RecordMark       = .F.
7467:             .DeleteMark       = .F.
7468:             .AllowRowSizing   = .F.
7469:             .ReadOnly         = .T.
7470:             .BackColor        = RGB(255, 255, 255)
7471:             .ForeColor        = RGB(90, 90, 90)
7472:             .HighlightBackColor = RGB(220, 230, 242)
7473:             .HighlightForeColor = RGB(15, 41, 104)
7474:             .HighlightStyle   = 2
7475:             .RowHeight        = 16
7476:             .ScrollBars       = 2
7477:             .Themes           = .F.
7478:             .Visible          = .T.
7479:         ENDWITH
7480: 
7481:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7482:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7483: 
7484:         *-- Configurar colunas do grDTEMP APOS RecordSource
7485:         WITH loc_oPg.grd_4c_GrDTEMP
7486:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7487:             .Column1.Header1.Caption = "Agrupamento"
7488:             .Column1.Width           = 100
7489:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7490:             .Column1.Alignment       = 0
7491:             .Column1.ReadOnly        = .T.
7492: 
7493:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7494:             .Column2.Header1.Caption = "Tempo %"
7495:             .Column2.Width           = 72
7496:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7497:             .Column2.Alignment       = 1
7498:             .Column2.ReadOnly        = .T.
7499:         ENDWITH
7500: 
7501:     ENDPROC
7502: 
7503:     *==========================================================================
7504:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7505:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7506:     *==========================================================================
7507: 
7508:     *--------------------------------------------------------------------------
7509:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7510:     *--------------------------------------------------------------------------
7511:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7512:         TRY
7513:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7514:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7515:             ENDIF
7516:         CATCH TO loc_oErro
7517:             *-- silencioso: refresh de navegacao nao deve bloquear
7518:         ENDTRY
7519:     ENDPROC
7520: 
7521:     *--------------------------------------------------------------------------
7522:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7523:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7524:     *--------------------------------------------------------------------------
7525:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7526:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7527:         IF par_nKeyCode = 115  && F4
7528:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7529:                 RETURN
7530:             ENDIF
7531:             TRY
7532:                 loc_cAtual = ""
7533:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7534:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7535:                 ENDIF
7536:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7537:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7538:                     "Buscar Fase")
7539:                 IF VARTYPE(loc_oBusca) = "O"
7540:                     IF !loc_oBusca.this_lAchouRegistro
7541:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7542:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7543:                         loc_oBusca.Show()
7544:                     ENDIF
7545:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7546:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7547:                             SELECT cursor_4c_GrdCons
7548:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7549:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7550:                         ENDIF
7551:                     ENDIF
7552:                     loc_oBusca.Release()
7553:                 ENDIF
7554:                 IF USED("cursor_4c_BuscaPrf")
7555:                     USE IN cursor_4c_BuscaPrf
7556:                 ENDIF
7557:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7558:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7559:                 ENDIF
7560:             CATCH TO loc_oErro
7561:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7562:             ENDTRY
7563:         ENDIF
7564:     ENDPROC
7565: 
7566:     *--------------------------------------------------------------------------
7567:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7568:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7569:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7570:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7571:     *--------------------------------------------------------------------------
7572:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7573:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7574:         IF par_nKeyCode = 115  && F4
7575:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7576:                 RETURN
7577:             ENDIF
7578:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7579:             loc_cGrupos = ""
7580:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7581:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7582:             ENDIF
7583:             IF !EMPTY(loc_cGrupos)
7584:                 RETURN
7585:             ENDIF
7586:             TRY
7587:                 loc_cAtual = ""
7588:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7589:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7590:                 ENDIF
7591:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7592:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7593:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7594:                 IF VARTYPE(loc_oBusca) = "O"
7595:                     IF !loc_oBusca.this_lAchouRegistro
7596:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7597:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7598:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7599:                         loc_oBusca.Show()
7600:                     ENDIF
7601:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7602:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7603:                             SELECT cursor_4c_GrdCons
7604:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7605:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7606:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7607:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7608:                             ENDIF
7609:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7610:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7611:                             ENDIF
7612:                         ENDIF
7613:                     ENDIF
7614:                     loc_oBusca.Release()
7615:                 ENDIF
7616:                 IF USED("cursor_4c_BuscaPrf2")
7617:                     USE IN cursor_4c_BuscaPrf2
7618:                 ENDIF
7619:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7620:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7621:                 ENDIF
7622:             CATCH TO loc_oErro
7623:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7624:             ENDTRY
7625:         ENDIF
7626:     ENDPROC
7627: 
7628:     *--------------------------------------------------------------------------
7629:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7630:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7631:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7632:     *--------------------------------------------------------------------------
7633:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7634:         LOCAL loc_oBusca, loc_cAtual
7635:         IF par_nKeyCode = 115  && F4
7636:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7637:                 RETURN
7638:             ENDIF
7639:             TRY
7640:                 loc_cAtual = ""
7641:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7642:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7643:                 ENDIF
7644:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7645:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7646:                     "Buscar Categoria")
7647:                 IF VARTYPE(loc_oBusca) = "O"
7648:                     IF !loc_oBusca.this_lAchouRegistro
7649:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7650:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7651:                         loc_oBusca.Show()
7652:                     ENDIF
7653:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7654:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7655:                             SELECT cursor_4c_GrdCons
7656:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7657:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7658:                         ENDIF
7659:                     ENDIF
7660:                     loc_oBusca.Release()
7661:                 ENDIF
7662:                 IF USED("cursor_4c_BuscaCat")
7663:                     USE IN cursor_4c_BuscaCat
7664:                 ENDIF
7665:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7666:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7667:                 ENDIF
7668:             CATCH TO loc_oErro
7669:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7670:             ENDTRY
7671:         ENDIF
7672:     ENDPROC
7673: 
7674:     *==========================================================================
7675:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7676:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7677:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7678:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7679:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7680:     *==========================================================================
7681:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7682:         LOCAL loc_oPg, loc_oGrd
7683: 
7684:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7685: 
7686:         *----------------------------------------------------------------------

*-- Linhas 7729 a 7854:
7729:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7730:         *--          Observacao, Etiq, Consumo, Qtd, Un
7731:         *----------------------------------------------------------------------
7732:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7733:         WITH loc_oPg.grd_4c_CustoCompo
7734:             .Top               = 178
7735:             .Left              = 34
7736:             .Width             = 813
7737:             .Height            = 230
7738:             .ColumnCount       = 12
7739:             .FontName          = "Verdana"
7740:             .FontSize          = 8
7741:             .GridLines         = 3
7742:             .GridLineWidth     = 1
7743:             .GridLineColor     = RGB(238, 238, 238)
7744:             .RecordMark        = .F.
7745:             .DeleteMark        = .F.
7746:             .AllowRowSizing    = .F.
7747:             .ReadOnly          = .F.
7748:             .BackColor         = RGB(255, 255, 255)
7749:             .ForeColor         = RGB(90, 90, 90)
7750:             .HighlightBackColor = RGB(220, 230, 242)
7751:             .HighlightForeColor = RGB(15, 41, 104)
7752:             .HighlightStyle    = 2
7753:             .RowHeight         = 16
7754:             .ScrollBars        = 2
7755:             .Visible           = .T.
7756:         ENDWITH
7757: 
7758:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7759:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7760: 
7761:         *-- Configurar colunas APOS RecordSource
7762:         WITH loc_oPg.grd_4c_CustoCompo
7763:             *-- Col1: Item/Material (C14) W:80
7764:             .Column1.Header1.Caption   = "Item"
7765:             .Column1.Width             = 80
7766:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7767:             .Column1.Alignment         = 0
7768: 
7769:             *-- Col2: Descricao (C65) W:185
7770:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7771:             .Column2.Width             = 185
7772:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7773:             .Column2.Alignment         = 0
7774: 
7775:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7776:             .Column3.Header1.Caption   = "Un"
7777:             .Column3.Width             = 35
7778:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7779:             .Column3.ReadOnly          = .T.
7780: 
7781:             *-- Col4: Valor (N12,4) W:65
7782:             .Column4.Header1.Caption   = "Valor"
7783:             .Column4.Width             = 65
7784:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7785:             .Column4.Alignment         = 1
7786: 
7787:             *-- Col5: Qtd (N12,4) W:55
7788:             .Column5.Header1.Caption   = "Qtd"
7789:             .Column5.Width             = 55
7790:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7791:             .Column5.Alignment         = 1
7792: 
7793:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7794:             .Column6.Header1.Caption   = "Total"
7795:             .Column6.Width             = 65
7796:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7797:             .Column6.Alignment         = 1
7798:             .Column6.ReadOnly          = .T.
7799: 
7800:             *-- Col7: Moe/Moeda (C5) W:35
7801:             .Column7.Header1.Caption   = "Moe"
7802:             .Column7.Width             = 35
7803:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7804: 
7805:             *-- Col8: Observacao (C40) W:95
7806:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7807:             .Column8.Width             = 95
7808:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7809:             .Column8.Alignment         = 0
7810: 
7811:             *-- Col9: Etiq (C1) W:30
7812:             .Column9.Header1.Caption   = "Etiq"
7813:             .Column9.Width             = 30
7814:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7815: 
7816:             *-- Col10: Consumo (N12,4) W:65
7817:             .Column10.Header1.Caption  = "Consumo"
7818:             .Column10.Width            = 65
7819:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7820:             .Column10.Alignment        = 1
7821: 
7822:             *-- Col11: Qtd cons (N12,4) W:55
7823:             .Column11.Header1.Caption  = "Qtd"
7824:             .Column11.Width            = 55
7825:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7826:             .Column11.Alignment        = 1
7827: 
7828:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7829:             .Column12.Header1.Caption  = "Un"
7830:             .Column12.Width            = 30
7831:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7832:             .Column12.ReadOnly         = .T.
7833:         ENDWITH
7834:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7835: 
7836:         *----------------------------------------------------------------------
7837:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7838:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7839:         *----------------------------------------------------------------------
7840:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7841:         WITH loc_oPg.cnt_4c_BotoesCusto
7842:             .Top         = 240
7843:             .Left        = 851
7844:             .Width       = 50
7845:             .Height      = 90
7846:             .BackStyle = 1
7847:             .BackColor = RGB(53, 53, 53)
7848:             .BorderWidth = 0
7849:             .Visible     = .T.
7850:         ENDWITH
7851: 
7852:         *-- Botao 1: Inserir componente de custo
7853:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7854:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto

*-- Linhas 7985 a 8057:
7985:             .Visible     = .T.
7986:         ENDWITH
7987: 
7988:         *-- GradeGRUPO2: grd_4c_GrupoCusto (3 cols) - usa cursor_4c_Grupo (compartilhado)
7989:         loc_oPg.AddObject("grd_4c_GrupoCusto", "Grid")
7990:         WITH loc_oPg.grd_4c_GrupoCusto
7991:             .Top               = 468
7992:             .Left              = 35
7993:             .Width             = 195
7994:             .Height            = 141
7995:             .ColumnCount       = 3
7996:             .FontName          = "Verdana"
7997:             .FontSize          = 8
7998:             .GridLines         = 3
7999:             .GridLineWidth     = 1
8000:             .GridLineColor     = RGB(238, 238, 238)
8001:             .RecordMark        = .F.
8002:             .DeleteMark        = .F.
8003:             .AllowRowSizing    = .F.
8004:             .ReadOnly          = .T.
8005:             .BackColor         = RGB(255, 255, 255)
8006:             .ForeColor         = RGB(90, 90, 90)
8007:             .HighlightBackColor = RGB(220, 230, 242)
8008:             .HighlightForeColor = RGB(15, 41, 104)
8009:             .HighlightStyle    = 2
8010:             .RowHeight         = 16
8011:             .ScrollBars        = 2
8012:             .Visible           = .T.
8013:         ENDWITH
8014: 
8015:         *-- RecordSource FORA do WITH
8016:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8017: 
8018:         *-- Configurar colunas APOS RecordSource
8019:         WITH loc_oPg.grd_4c_GrupoCusto
8020:             *-- Col1: Grupo (C3) W:40 - readonly
8021:             .Column1.Header1.Caption   = "Grp"
8022:             .Column1.Width             = 40
8023:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8024:             .Column1.ReadOnly          = .T.
8025: 
8026:             *-- Col2: Total (N12,4) W:100 - readonly
8027:             .Column2.Header1.Caption   = "Total "
8028:             .Column2.Width             = 100
8029:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8030:             .Column2.Alignment         = 1
8031:             .Column2.ReadOnly          = .T.
8032: 
8033:             *-- Col3: Moeda (C5) W:50 - readonly
8034:             .Column3.Header1.Caption   = "Moe"
8035:             .Column3.Width             = 50
8036:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8037:             .Column3.ReadOnly          = .T.
8038:         ENDWITH
8039:     ENDPROC
8040: 
8041:     *--------------------------------------------------------------------------
8042:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8043:     *--------------------------------------------------------------------------
8044:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8045:         LOCAL loc_oPg, loc_nRet
8046:         TRY
8047:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8048:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8049:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8050:                 *-- Buscar descricao do grupo
8051:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8052:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8053:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8054:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8055:                         "cursor_4c_TmpGrpCusto")
8056:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8057:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)

*-- Linhas 8079 a 8161:
8079:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8080:             IF USED("cursor_4c_Compo")
8081:                 GO TOP IN cursor_4c_Compo
8082:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8083:             ENDIF
8084:         CATCH TO loc_oErro
8085:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8086:         ENDTRY
8087:     ENDPROC
8088: 
8089:     *--------------------------------------------------------------------------
8090:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8091:     *--------------------------------------------------------------------------
8092:     PROCEDURE CmdInserirCustoClick()
8093:         LOCAL loc_oPg, loc_cTipo
8094:         TRY
8095:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8096:                 RETURN
8097:             ENDIF
8098:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8099:             loc_cTipo = ""
8100:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8101:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8102:             ENDIF
8103:             IF USED("cursor_4c_Compo")
8104:                 SELECT cursor_4c_Compo
8105:                 GO TOP IN cursor_4c_Compo
8106:                 LOCATE FOR EMPTY(mats)
8107:                 IF EOF("cursor_4c_Compo")
8108:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8109:                 ENDIF
8110:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8111:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8112:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8113:                 ENDIF
8114:             ENDIF
8115:         CATCH TO loc_oErro
8116:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8117:         ENDTRY
8118:     ENDPROC
8119: 
8120:     *--------------------------------------------------------------------------
8121:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8122:     *--------------------------------------------------------------------------
8123:     PROCEDURE CmdExcluirCustoClick()
8124:         LOCAL loc_oPg
8125:         TRY
8126:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8127:                 RETURN
8128:             ENDIF
8129:             IF USED("cursor_4c_Compo")
8130:                 SELECT cursor_4c_Compo
8131:                 IF !EOF("cursor_4c_Compo")
8132:                     DELETE
8133:                     IF !EOF("cursor_4c_Compo")
8134:                         SKIP
8135:                         SKIP -1
8136:                     ENDIF
8137:                     GO BOTTOM IN cursor_4c_Compo
8138:                 ENDIF
8139:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8140:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8141:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8142:             ENDIF
8143:         CATCH TO loc_oErro
8144:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8145:         ENDTRY
8146:     ENDPROC
8147: 
8148:     *--------------------------------------------------------------------------
8149:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8150:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8151:     *--------------------------------------------------------------------------
8152:     PROCEDURE AjustarBotoesPorModo()
8153:         LOCAL loc_oPg2, loc_lEditando
8154:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8155: 
8156:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8157:             RETURN
8158:         ENDIF
8159: 
8160:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8161: 

*-- Linhas 8182 a 8227:
8182:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8183:         *----------------------------------------------------------------------
8184:         IF !USED("cursor_4c_GradFase")
8185:             SET NULL ON
8186:             CREATE CURSOR cursor_4c_GradFase (;
8187:                 Ordems   N(5,0), ;
8188:                 Grupos   C(10), ;
8189:                 Descrs   C(65), ;
8190:                 UniPrdts C(10), ;
8191:                 MatPrdts C(15), ;
8192:                 Obs      M, ;
8193:                 FigProcs M)
8194:             SET NULL OFF
8195:         ENDIF
8196: 
8197:         *----------------------------------------------------------------------
8198:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8199:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8200:         *----------------------------------------------------------------------
8201:         IF !USED("cursor_4c_SigPrMtz")
8202:             SET NULL ON
8203:             CREATE CURSOR cursor_4c_SigPrMtz (;
8204:                 CMats C(14), ;
8205:                 DLocs C(40), ;
8206:                 Qtds  N(3,0))
8207:             SET NULL OFF
8208:         ENDIF
8209: 
8210:         *----------------------------------------------------------------------
8211:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8212:         *----------------------------------------------------------------------
8213:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8214:         WITH loc_oPg.shp_4c_ShpFig
8215:             .Top         = 152
8216:             .Left        = 231
8217:             .Width       = 244
8218:             .Height      = 148
8219:             .BackStyle   = 1
8220:             .BackColor   = RGB(255, 255, 255)
8221:             .BorderColor = RGB(192, 192, 192)
8222:             .BorderWidth = 1
8223:             .Visible     = .T.
8224:         ENDWITH
8225: 
8226:         *----------------------------------------------------------------------
8227:         *-- Image: ImgFigJpg (T:153 L:232 W:241 H:146) - imagem da fase de producao

*-- Linhas 8244 a 8343:
8244:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8245:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8246:         *----------------------------------------------------------------------
8247:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8248:         loc_oGrd = loc_oPg.grd_4c_GradFase
8249: 
8250:         WITH loc_oGrd
8251:             .Top                = 152
8252:             .Left               = 527
8253:             .Width              = 420
8254:             .Height             = 312
8255:             .FontName           = "Tahoma"
8256:             .FontSize           = 8
8257:             .ColumnCount        = 5
8258:             .GridLines          = 3
8259:             .GridLineWidth      = 1
8260:             .GridLineColor      = RGB(238, 238, 238)
8261:             .RecordMark         = .F.
8262:             .DeleteMark         = .F.
8263:             .AllowRowSizing     = .F.
8264:             .ReadOnly           = .F.
8265:             .BackColor          = RGB(255, 255, 255)
8266:             .ForeColor          = RGB(90, 90, 90)
8267:             .HighlightBackColor = RGB(220, 230, 242)
8268:             .HighlightForeColor = RGB(15, 41, 104)
8269:             .HighlightStyle     = 2
8270:             .RowHeight          = 16
8271:             .ScrollBars         = 2
8272:             .Themes             = .F.
8273:             .Visible            = .T.
8274:         ENDWITH
8275: 
8276:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8277:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8278: 
8279:         *-- Configurar colunas APOS RecordSource
8280:         WITH loc_oPg.grd_4c_GradFase
8281:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8282:             .Column1.Header1.Caption = "Ordem"
8283:             .Column1.Width           = 50
8284:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8285:             .Column1.Alignment       = 1
8286:             .Column1.ReadOnly        = .T.
8287: 
8288:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8289:             .Column2.Header1.Caption = "Fase"
8290:             .Column2.Width           = 80
8291:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8292:             .Column2.Alignment       = 0
8293:             .Column2.ReadOnly        = .F.
8294: 
8295:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8296:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8297:             .Column3.Width           = 130
8298:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8299:             .Column3.Alignment       = 0
8300:             .Column3.ReadOnly        = .T.
8301: 
8302:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8303:             .Column4.Header1.Caption = "Uni. Produtiva"
8304:             .Column4.Width           = 80
8305:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8306:             .Column4.Alignment       = 0
8307:             .Column4.ReadOnly        = .F.
8308: 
8309:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8310:             .Column5.Header1.Caption = "Material"
8311:             .Column5.Width           = 80
8312:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8313:             .Column5.Alignment       = 0
8314:             .Column5.ReadOnly        = .F.
8315:         ENDWITH
8316: 
8317:         *-- BINDEVENT: GradFase
8318:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8319:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8320:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8321:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8322:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8323:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8324: 
8325:         *----------------------------------------------------------------------
8326:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8327:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8328:         *----------------------------------------------------------------------
8329:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8330:         WITH loc_oPg.cmd_4c_IncluirFase
8331:             .Caption       = "+"
8332:             .Top           = 152
8333:             .Left          = 950
8334:             .Width         = 38
8335:             .Height        = 38
8336:             .FontName      = "Tahoma"
8337:             .FontSize      = 10
8338:             .FontBold      = .T.
8339:             .Themes        = .F.
8340:             .SpecialEffect = 0
8341:             .BackColor     = RGB(255, 255, 255)
8342:             .ForeColor     = RGB(0, 128, 0)
8343:             .Visible       = .T.

*-- Linhas 8867 a 8948:
8867: 
8868:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8869:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8870:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8871:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8872: 
8873:         WITH loc_oGrd
8874:             .Top                = 380
8875:             .Left               = 7
8876:             .Width              = 246
8877:             .Height             = 240
8878:             .FontName           = "Tahoma"
8879:             .FontSize           = 8
8880:             .ColumnCount        = 3
8881:             .GridLines          = 3
8882:             .GridLineWidth      = 1
8883:             .GridLineColor      = RGB(238, 238, 238)
8884:             .RecordMark         = .F.
8885:             .DeleteMark         = .F.
8886:             .AllowRowSizing     = .F.
8887:             .ReadOnly           = .F.
8888:             .BackColor          = RGB(255, 255, 255)
8889:             .ForeColor          = RGB(90, 90, 90)
8890:             .HighlightBackColor = RGB(220, 230, 242)
8891:             .HighlightForeColor = RGB(15, 41, 104)
8892:             .HighlightStyle     = 2
8893:             .RowHeight          = 16
8894:             .ScrollBars         = 2
8895:             .Themes             = .F.
8896:             .Visible            = .T.
8897:         ENDWITH
8898: 
8899:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8900:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8901: 
8902:         *-- Configurar colunas APOS RecordSource
8903:         WITH loc_oPg.grd_4c_Matrizes
8904:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8905:             .Column1.Header1.Caption = "Matriz"
8906:             .Column1.Width           = 70
8907:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8908:             .Column1.Alignment       = 0
8909:             .Column1.ReadOnly        = .F.
8910: 
8911:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8912:             .Column2.Header1.Caption = "Local"
8913:             .Column2.Width           = 120
8914:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8915:             .Column2.Alignment       = 0
8916:             .Column2.ReadOnly        = .T.
8917: 
8918:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8919:             .Column3.Header1.Caption = "Qtde"
8920:             .Column3.Width           = 56
8921:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8922:             .Column3.Alignment       = 1
8923:             .Column3.ReadOnly        = .F.
8924:         ENDWITH
8925: 
8926:         *-- BINDEVENT: grdMatrizes
8927:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8928:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8929: 
8930:         *----------------------------------------------------------------------
8931:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8932:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8933:         *----------------------------------------------------------------------
8934:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8935:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8936:             .Caption       = "+"
8937:             .Top           = 380
8938:             .Left          = 258
8939:             .Width         = 38
8940:             .Height        = 38
8941:             .FontName      = "Tahoma"
8942:             .FontSize      = 10
8943:             .FontBold      = .T.
8944:             .Themes        = .F.
8945:             .SpecialEffect = 0
8946:             .BackColor     = RGB(255, 255, 255)
8947:             .ForeColor     = RGB(0, 128, 0)
8948:             .Visible       = .T.

*-- Linhas 9162 a 9207:
9162:                 ENDIF
9163:             ENDIF
9164: 
9165:             loc_oPg.grd_4c_GradFase.Refresh()
9166:         CATCH TO loc_oErro
9167:             MsgErro(loc_oErro.Message, "Erro ao atualizar aba Fases")
9168:         ENDTRY
9169:     ENDPROC
9170: 
9171:     *--------------------------------------------------------------------------
9172:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9173:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9174:     *--------------------------------------------------------------------------
9175:     PROCEDURE GradFaseCol1GotFocus()
9176:         TRY
9177:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9178:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9179:             ENDIF
9180:         CATCH TO loc_oErro
9181:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9182:         ENDTRY
9183:     ENDPROC
9184: 
9185:     *--------------------------------------------------------------------------
9186:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9187:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9188:     *--------------------------------------------------------------------------
9189:     PROCEDURE GradFaseCol1LostFocus()
9190:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9191:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9192:             RETURN
9193:         ENDIF
9194:         loc_lResultado = .T.
9195:         TRY
9196:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9197:                 loc_lResultado = .F.
9198:             ENDIF
9199:             IF loc_lResultado
9200:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9201:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9202:                     loc_lResultado = .F.
9203:                 ENDIF
9204:             ENDIF
9205:             IF loc_lResultado
9206:                 *-- Calcular Ordem2 para resequenciamento
9207:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")

*-- Linhas 9215 a 9294:
9215:                 SELECT cursor_4c_GradFase
9216:                 *-- Reordenar por Ordems para refletir nova sequencia
9217:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9218:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9219:                 ENDIF
9220:             ENDIF
9221:         CATCH TO loc_oErro
9222:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9223:         ENDTRY
9224:     ENDPROC
9225: 
9226:     *--------------------------------------------------------------------------
9227:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9228:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9229:     *         Apos selecao: preenche Grupos e Descrs no cursor
9230:     *--------------------------------------------------------------------------
9231:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9232:         LOCAL loc_oBusca, loc_cAtual
9233:         IF par_nKeyCode = 115  && F4
9234:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9235:                 RETURN
9236:             ENDIF
9237:             TRY
9238:                 loc_cAtual = ""
9239:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9240:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9241:                 ENDIF
9242:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9243:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9244:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9245:                 IF VARTYPE(loc_oBusca) = "O"
9246:                     IF !loc_oBusca.this_lAchouRegistro
9247:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9248:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9249:                         loc_oBusca.Show()
9250:                     ENDIF
9251:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9252:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9253:                             SELECT cursor_4c_GradFase
9254:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9255:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9256:                         ENDIF
9257:                     ENDIF
9258:                     loc_oBusca.Release()
9259:                 ENDIF
9260:                 IF USED("cursor_4c_BuscaGcr")
9261:                     USE IN cursor_4c_BuscaGcr
9262:                 ENDIF
9263:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9264:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9265:                 ENDIF
9266:             CATCH TO loc_oErro
9267:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9268:             ENDTRY
9269:         ENDIF
9270:     ENDPROC
9271: 
9272:     *--------------------------------------------------------------------------
9273:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9274:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9275:     *         Apos selecao: preenche UniPrdts no cursor
9276:     *--------------------------------------------------------------------------
9277:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9278:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9279:         IF par_nKeyCode = 115  && F4
9280:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9281:                 RETURN
9282:             ENDIF
9283:             TRY
9284:                 loc_cAtual  = ""
9285:                 loc_cGrupos = ""
9286:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9287:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9288:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9289:                 ENDIF
9290:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9291:                 IF !EMPTY(loc_cGrupos)
9292:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9293:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9294:                 ELSE

*-- Linhas 9301 a 9388:
9301:                         "Buscar Uni. Produtiva")
9302:                     IF VARTYPE(loc_oBusca) = "O"
9303:                         IF !loc_oBusca.this_lAchouRegistro
9304:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9305:                             loc_oBusca.Show()
9306:                         ENDIF
9307:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9308:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9309:                                 SELECT cursor_4c_GradFase
9310:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9311:                             ENDIF
9312:                         ENDIF
9313:                         loc_oBusca.Release()
9314:                     ENDIF
9315:                     IF USED("cursor_4c_BuscaUpd2")
9316:                         USE IN cursor_4c_BuscaUpd2
9317:                     ENDIF
9318:                 ENDIF
9319:                 IF USED("cursor_4c_BuscaUpd")
9320:                     USE IN cursor_4c_BuscaUpd
9321:                 ENDIF
9322:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9323:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9324:                 ENDIF
9325:             CATCH TO loc_oErro
9326:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9327:             ENDTRY
9328:         ENDIF
9329:     ENDPROC
9330: 
9331:     *--------------------------------------------------------------------------
9332:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9333:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9334:     *         Apos selecao: preenche MatPrdts no cursor
9335:     *--------------------------------------------------------------------------
9336:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9337:         LOCAL loc_oBusca, loc_cAtual
9338:         IF par_nKeyCode = 115  && F4
9339:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9340:                 RETURN
9341:             ENDIF
9342:             TRY
9343:                 loc_cAtual = ""
9344:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9345:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9346:                 ENDIF
9347:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9348:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9349:                     "Buscar Tipo de Material")
9350:                 IF VARTYPE(loc_oBusca) = "O"
9351:                     IF !loc_oBusca.this_lAchouRegistro
9352:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9353:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9354:                         loc_oBusca.Show()
9355:                     ENDIF
9356:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9357:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9358:                             SELECT cursor_4c_GradFase
9359:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9360:                         ENDIF
9361:                     ENDIF
9362:                     loc_oBusca.Release()
9363:                 ENDIF
9364:                 IF USED("cursor_4c_BuscaOpt")
9365:                     USE IN cursor_4c_BuscaOpt
9366:                 ENDIF
9367:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9368:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9369:                 ENDIF
9370:             CATCH TO loc_oErro
9371:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9372:             ENDTRY
9373:         ENDIF
9374:     ENDPROC
9375: 
9376:     *--------------------------------------------------------------------------
9377:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9378:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9379:     *--------------------------------------------------------------------------
9380:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9381:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9382:         TRY
9383:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9384:                 RETURN
9385:             ENDIF
9386:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9387:             IF VARTYPE(loc_oPg) # "O"
9388:                 RETURN

*-- Linhas 9417 a 9488:
9417:                 ENDIF
9418:             ENDIF
9419: 
9420:             loc_oPg.grd_4c_Matrizes.Refresh()
9421:         CATCH TO loc_oErro
9422:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da matriz")
9423:         ENDTRY
9424:     ENDPROC
9425: 
9426:     *--------------------------------------------------------------------------
9427:     * GrdMatrizesCol1KeyPress - F4 abre lookup de Matrizes (cursor crMatrizes)
9428:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9429:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9430:     *--------------------------------------------------------------------------
9431:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9432:         LOCAL loc_oBusca, loc_cAtual
9433:         IF par_nKeyCode = 115  && F4
9434:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9435:                 RETURN
9436:             ENDIF
9437:             TRY
9438:                 loc_cAtual = ""
9439:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9440:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9441:                 ENDIF
9442:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9443:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9444:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9445:                     "Buscar Matriz")
9446:                 IF VARTYPE(loc_oBusca) = "O"
9447:                     IF !loc_oBusca.this_lAchouRegistro
9448:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9449:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9450:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9451:                         loc_oBusca.Show()
9452:                     ENDIF
9453:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9454:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9455:                             SELECT cursor_4c_SigPrMtz
9456:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9457:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9458:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9459:                             ENDIF
9460:                         ENDIF
9461:                     ENDIF
9462:                     loc_oBusca.Release()
9463:                 ENDIF
9464:                 IF USED("cursor_4c_BuscaMatriz")
9465:                     USE IN cursor_4c_BuscaMatriz
9466:                 ENDIF
9467:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9468:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9469:                 ENDIF
9470:             CATCH TO loc_oErro
9471:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9472:             ENDTRY
9473:         ENDIF
9474:     ENDPROC
9475: 
9476:     *--------------------------------------------------------------------------
9477:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9478:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9479:     *--------------------------------------------------------------------------
9480:     PROCEDURE CmdIncluirFaseClick()
9481:         LOCAL loc_oPg, loc_nOrdem
9482:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9483:             RETURN
9484:         ENDIF
9485:         TRY
9486:             IF !USED("cursor_4c_GradFase")
9487:                 RETURN
9488:             ENDIF

*-- Linhas 9505 a 9530:
9505:             GO BOTTOM IN cursor_4c_GradFase
9506:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9507:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9508:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9509:                     loc_oPg.grd_4c_GradFase.Refresh()
9510:                     loc_oPg.grd_4c_GradFase.SetFocus()
9511:                 ENDIF
9512:             ENDIF
9513:         CATCH TO loc_oErro
9514:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9515:         ENDTRY
9516:     ENDPROC
9517: 
9518:     *--------------------------------------------------------------------------
9519:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9520:     * Legado: excluir.Click - DELETE e resequencia Ordems
9521:     *--------------------------------------------------------------------------
9522:     PROCEDURE CmdExcluirFaseClick()
9523:         LOCAL loc_oPg, loc_lResultado
9524:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9525:             RETURN
9526:         ENDIF
9527:         loc_lResultado = .T.
9528:         TRY
9529:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9530:                 loc_lResultado = .F.

*-- Linhas 9553 a 9577:
9553:                 ENDSCAN
9554:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9555:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9556:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9557:                         loc_oPg.grd_4c_GradFase.Refresh()
9558:                     ENDIF
9559:                 ENDIF
9560:             ENDIF
9561:         CATCH TO loc_oErro
9562:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9563:         ENDTRY
9564:     ENDPROC
9565: 
9566:     *--------------------------------------------------------------------------
9567:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9568:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9569:     *--------------------------------------------------------------------------
9570:     PROCEDURE CmdAlternativaFaseClick()
9571:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9572:         LOCAL loc_nOrdem
9573:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9574:             RETURN
9575:         ENDIF
9576:         loc_lResultado = .T.
9577:         TRY

*-- Linhas 9604 a 9628:
9604:                 GO BOTTOM IN cursor_4c_GradFase
9605:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9606:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9607:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9608:                         loc_oPg.grd_4c_GradFase.Refresh()
9609:                     ENDIF
9610:                 ENDIF
9611:             ENDIF
9612:         CATCH TO loc_oErro
9613:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9614:         ENDTRY
9615:     ENDPROC
9616: 
9617:     *--------------------------------------------------------------------------
9618:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9619:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9620:     *--------------------------------------------------------------------------
9621:     PROCEDURE CmdFichaClick()
9622:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9623:         loc_lResultado = .T.
9624:         TRY
9625:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9626:                 loc_lResultado = .F.
9627:             ENDIF
9628:             IF loc_lResultado

*-- Linhas 9638 a 9661:
9638:                 IF USED("CsCabecalho")
9639:                     USE IN CsCabecalho
9640:                 ENDIF
9641:                 CREATE CURSOR CsCabecalho (;
9642:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9643:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9644:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9645:                     _nPeso N(9,2))
9646:                 WITH THIS.this_oBusinessObject
9647:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9648:                         VALUES (loc_cNmEmp, ;
9649:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9650:                                 ALLTRIM(.this_cCpros), ;
9651:                                 ALLTRIM(.this_cDpros), ;
9652:                                 ALLTRIM(.this_cCgrus), ;
9653:                                 .this_nPesobs)
9654:                 ENDWITH
9655:                 *-- Verificar e executar relatorio
9656:                 LOCAL loc_cRepPath
9657:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9658:                 IF FILE(loc_cRepPath)
9659:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9660:                 ELSE
9661:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")

*-- Linhas 9791 a 9816:
9791:             ENDIF
9792:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9793:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9794:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9795:                     loc_oPg.grd_4c_Matrizes.Refresh()
9796:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9797:                 ENDIF
9798:             ENDIF
9799:         CATCH TO loc_oErro
9800:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9801:         ENDTRY
9802:     ENDPROC
9803: 
9804:     *--------------------------------------------------------------------------
9805:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9806:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9807:     *--------------------------------------------------------------------------
9808:     PROCEDURE BtnExcluiMtzClick()
9809:         LOCAL loc_oPg, loc_lResultado
9810:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9811:             RETURN
9812:         ENDIF
9813:         loc_lResultado = .T.
9814:         TRY
9815:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9816:                 loc_lResultado = .F.

*-- Linhas 9827 a 9852:
9827:             ENDIF
9828:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9829:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9830:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9831:                     loc_oPg.grd_4c_Matrizes.Refresh()
9832:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9833:                 ENDIF
9834:             ENDIF
9835:         CATCH TO loc_oErro
9836:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9837:         ENDTRY
9838:     ENDPROC
9839: 
9840:     *--------------------------------------------------------------------------
9841:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9842:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9843:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9844:     *--------------------------------------------------------------------------
9845:     PROCEDURE TxtCodacbLostFocus()
9846:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9847:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9848:             RETURN
9849:         ENDIF
9850:         loc_lResultado = .T.
9851:         TRY
9852:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"

*-- Linhas 9867 a 9891:
9867:                     "Buscar Acabamento")
9868:                 IF VARTYPE(loc_oBusca) = "O"
9869:                     IF !loc_oBusca.this_lAchouRegistro
9870:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9871:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9872:                         loc_oBusca.Show()
9873:                     ENDIF
9874:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9875:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9876:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9877:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9878:                     ELSE
9879:                         loc_oPg.txt_4c__codacb.Value = ""
9880:                         loc_oPg.txt_4c__Dacb.Value   = ""
9881:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9882:                     ENDIF
9883:                     loc_oBusca.Release()
9884:                 ENDIF
9885:                 IF USED("cursor_4c_BuscaAca")
9886:                     USE IN cursor_4c_BuscaAca
9887:                 ENDIF
9888:             ENDIF
9889:         CATCH TO loc_oErro
9890:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9891:         ENDTRY

*-- Linhas 9919 a 9943:
9919:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9920:                 IF VARTYPE(loc_oBusca) = "O"
9921:                     IF !loc_oBusca.this_lAchouRegistro
9922:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9923:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9924:                         loc_oBusca.Show()
9925:                     ENDIF
9926:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9927:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9928:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9929:                     ELSE
9930:                         loc_oPg.txt_4c_Tam.Value = ""
9931:                         THIS.this_oBusinessObject.this_cCodtams = ""
9932:                     ENDIF
9933:                     loc_oBusca.Release()
9934:                 ENDIF
9935:                 IF USED("cursor_4c_BuscaTam")
9936:                     USE IN cursor_4c_BuscaTam
9937:                 ENDIF
9938:             ENDIF
9939:         CATCH TO loc_oErro
9940:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9941:         ENDTRY
9942:     ENDPROC
9943: 

*-- Linhas 9969 a 9993:
9969:                     "Buscar Cor Padr" + CHR(227) + "o")
9970:                 IF VARTYPE(loc_oBusca) = "O"
9971:                     IF !loc_oBusca.this_lAchouRegistro
9972:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
9973:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9974:                         loc_oBusca.Show()
9975:                     ENDIF
9976:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
9977:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
9978:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
9979:                     ELSE
9980:                         loc_oPg.txt_4c_Cor.Value = ""
9981:                         THIS.this_oBusinessObject.this_cCodcors = ""
9982:                     ENDIF
9983:                     loc_oBusca.Release()
9984:                 ENDIF
9985:                 IF USED("cursor_4c_BuscaCor")
9986:                     USE IN cursor_4c_BuscaCor
9987:                 ENDIF
9988:             ENDIF
9989:         CATCH TO loc_oErro
9990:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
9991:         ENDTRY
9992:     ENDPROC
9993: 

*-- Linhas 10031 a 10054:
10031:                             "Buscar Conquilha")
10032:                         IF VARTYPE(loc_oBusca) = "O"
10033:                             IF !loc_oBusca.this_lAchouRegistro
10034:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10035:                                 loc_oBusca.Show()
10036:                             ENDIF
10037:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10038:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10039:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10040:                             ELSE
10041:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10042:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10043:                             ENDIF
10044:                             loc_oBusca.Release()
10045:                         ENDIF
10046:                         IF USED("cursor_4c_BuscaCnq")
10047:                             USE IN cursor_4c_BuscaCnq
10048:                         ENDIF
10049:                     ENDIF
10050:                     USE IN cursor_4c_ListaCnq
10051:                 ENDIF
10052:             ENDIF
10053:         CATCH TO loc_oErro
10054:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")

*-- Linhas 10070 a 10098:
10070:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10071:         *----------------------------------------------------------------------
10072:         IF !USED("cursor_4c_Cmv")
10073:             SET NULL ON
10074:             CREATE CURSOR cursor_4c_Cmv (;
10075:                 Datas   D, ;
10076:                 ValCuss N(12,3), ;
10077:                 Moedas  C(3))
10078:             SET NULL OFF
10079:         ENDIF
10080: 
10081:         *----------------------------------------------------------------------
10082:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10083:         *----------------------------------------------------------------------
10084:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10085:         WITH loc_oPg.lbl_4c_LblGruCus
10086:             .Caption   = "Grupo C.C. :"
10087:             .Top       = 165
10088:             .Left      = 138
10089:             .Width     = 63
10090:             .Height    = 15
10091:             .FontName  = "Tahoma"
10092:             .FontSize  = 8
10093:             .BackStyle = 0
10094:             .ForeColor = RGB(90, 90, 90)
10095:             .Visible   = .T.
10096:         ENDWITH
10097: 
10098:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")

*-- Linhas 10860 a 10930:
10860:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10861:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10862:         *----------------------------------------------------------------------
10863:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
10864:         WITH loc_oPg.grd_4c_Cmv
10865:             .Top         = 338
10866:             .Left        = 754
10867:             .Width       = 223
10868:             .Height      = 141
10869:             .ColumnCount = 3
10870:             .FontName    = "Tahoma"
10871:             .FontSize    = 8
10872:             .RowHeight   = 17
10873:             .DeleteMark  = .F.
10874:             .RecordMark  = .T.
10875:             .ReadOnly    = .T.
10876:             .ScrollBars  = 3
10877:             .Themes      = .F.
10878:             .Visible     = .T.
10879:         ENDWITH
10880:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10881:         WITH loc_oPg.grd_4c_Cmv
10882:             WITH .Column1
10883:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10884:                 .Header1.FontName = "Tahoma"
10885:                 .Header1.FontSize = 8
10886:                 .Width            = 59
10887:                 .Movable          = .F.
10888:                 .Resizable        = .F.
10889:                 .ReadOnly         = .T.
10890:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10891:             ENDWITH
10892:             WITH .Column2
10893:                 .Header1.Caption  = "Valor Custo GR"
10894:                 .Header1.FontName = "Tahoma"
10895:                 .Header1.FontSize = 8
10896:                 .Width            = 100
10897:                 .Movable          = .F.
10898:                 .Resizable        = .F.
10899:                 .ReadOnly         = .T.
10900:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10901:             ENDWITH
10902:             WITH .Column3
10903:                 .Header1.Caption  = "Moe"
10904:                 .Header1.FontName = "Tahoma"
10905:                 .Header1.FontSize = 8
10906:                 .Width            = 31
10907:                 .Movable          = .F.
10908:                 .Resizable        = .F.
10909:                 .ReadOnly         = .T.
10910:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10911:             ENDWITH
10912:         ENDWITH
10913:     ENDPROC
10914: 
10915:     *--------------------------------------------------------------------------
10916:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10917:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10918:     *--------------------------------------------------------------------------
10919:     PROTECTED PROCEDURE PreencherCamposFiscais()
10920:         LOCAL loc_oPg, loc_cIpiVal
10921:         TRY
10922:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10923:                 RETURN
10924:             ENDIF
10925:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10926:             IF VARTYPE(loc_oPg) # "O"
10927:                 RETURN
10928:             ENDIF
10929:             WITH THIS.this_oBusinessObject
10930:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"

*-- Linhas 11109 a 11133:
11109:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11110:                 IF VARTYPE(loc_oBusca) = "O"
11111:                     IF !loc_oBusca.this_lAchouRegistro
11112:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11113:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11114:                         loc_oBusca.Show()
11115:                     ENDIF
11116:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11117:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11118:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11119:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11120:                         ENDIF
11121:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11122:                     ELSE
11123:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11124:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11125:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11126:                         ENDIF
11127:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11128:                     ENDIF
11129:                     loc_oBusca.Release()
11130:                 ENDIF
11131:                 IF USED("cursor_4c_BuscaClf")
11132:                     USE IN cursor_4c_BuscaClf
11133:                 ENDIF

*-- Linhas 11170 a 11194:
11170:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11171:                 IF VARTYPE(loc_oBusca) = "O"
11172:                     IF !loc_oBusca.this_lAchouRegistro
11173:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11174:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11175:                         loc_oBusca.Show()
11176:                     ENDIF
11177:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11178:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11179:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11180:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11181:                     ENDIF
11182:                     loc_oBusca.Release()
11183:                 ENDIF
11184:                 IF USED("cursor_4c_BuscaClfR")
11185:                     USE IN cursor_4c_BuscaClfR
11186:                 ENDIF
11187:             ENDIF
11188:         CATCH TO loc_oErro
11189:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11190:         ENDTRY
11191:     ENDPROC
11192: 
11193:     *--------------------------------------------------------------------------
11194:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)

*-- Linhas 11220 a 11244:
11220:                     "Buscar Origem da Mercadoria")
11221:                 IF VARTYPE(loc_oBusca) = "O"
11222:                     IF !loc_oBusca.this_lAchouRegistro
11223:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11224:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11225:                         loc_oBusca.Show()
11226:                     ENDIF
11227:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11228:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11229:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11230:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11231:                         ENDIF
11232:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11233:                     ELSE
11234:                         loc_oPg.txt_4c_Origmerc.Value = ""
11235:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11236:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11237:                         ENDIF
11238:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11239:                     ENDIF
11240:                     loc_oBusca.Release()
11241:                 ENDIF
11242:                 IF USED("cursor_4c_BuscaOrg")
11243:                     USE IN cursor_4c_BuscaOrg
11244:                 ENDIF

*-- Linhas 11278 a 11302:
11278:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11279:                 IF VARTYPE(loc_oBusca) = "O"
11280:                     IF !loc_oBusca.this_lAchouRegistro
11281:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11282:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11283:                         loc_oBusca.Show()
11284:                     ENDIF
11285:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11286:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11287:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11288:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11289:                         ENDIF
11290:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11291:                     ELSE
11292:                         loc_oPg.txt_4c_Sittricm.Value = ""
11293:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11294:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11295:                         ENDIF
11296:                         THIS.this_oBusinessObject.this_cSittricms = ""
11297:                     ENDIF
11298:                     loc_oBusca.Release()
11299:                 ENDIF
11300:                 IF USED("cursor_4c_BuscaIcm")
11301:                     USE IN cursor_4c_BuscaIcm
11302:                 ENDIF

*-- Linhas 11353 a 11377:
11353:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11354:                 IF VARTYPE(loc_oBusca) = "O"
11355:                     IF !loc_oBusca.this_lAchouRegistro
11356:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11357:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11358:                         loc_oBusca.Show()
11359:                     ENDIF
11360:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11361:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11362:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11363:                     ELSE
11364:                         loc_oPg.txt_4c_TpTrib.Value = ""
11365:                         THIS.this_oBusinessObject.this_cTptribs = ""
11366:                     ENDIF
11367:                     loc_oBusca.Release()
11368:                 ENDIF
11369:                 IF USED("cursor_4c_BuscaTri")
11370:                     USE IN cursor_4c_BuscaTri
11371:                 ENDIF
11372:             ENDIF
11373:         CATCH TO loc_oErro
11374:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11375:         ENDTRY
11376:     ENDPROC
11377: 

*-- Linhas 11430 a 11454:
11430:                     "Buscar Moeda")
11431:                 IF VARTYPE(loc_oBusca) = "O"
11432:                     IF !loc_oBusca.this_lAchouRegistro
11433:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11434:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11435:                         loc_oBusca.Show()
11436:                     ENDIF
11437:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11438:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11439:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11440:                     ELSE
11441:                         loc_oPg.txt_4c_Mvalor.Value = ""
11442:                         THIS.this_oBusinessObject.this_cMoedas = ""
11443:                     ENDIF
11444:                     loc_oBusca.Release()
11445:                 ENDIF
11446:                 IF USED("cursor_4c_BuscaMoeFisc")
11447:                     USE IN cursor_4c_BuscaMoeFisc
11448:                 ENDIF
11449:             ENDIF
11450:         CATCH TO loc_oErro
11451:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11452:         ENDTRY
11453:     ENDPROC
11454: 

*-- Linhas 11495 a 11519:
11495:                             "Buscar Metal")
11496:                         IF VARTYPE(loc_oBusca) = "O"
11497:                             IF !loc_oBusca.this_lAchouRegistro
11498:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11499:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11500:                                 loc_oBusca.Show()
11501:                             ENDIF
11502:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11503:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11504:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11505:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11506:                                 ENDIF
11507:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11508:                             ELSE
11509:                                 loc_oPg.txt_4c_Metal.Value = ""
11510:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11511:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11512:                                 ENDIF
11513:                                 THIS.this_oBusinessObject.this_cMetals = ""
11514:                             ENDIF
11515:                             loc_oBusca.Release()
11516:                         ENDIF
11517:                         IF USED("cursor_4c_BuscaMtlSel")
11518:                             USE IN cursor_4c_BuscaMtlSel
11519:                         ENDIF

*-- Linhas 11567 a 11591:
11567:                             "Buscar Teor")
11568:                         IF VARTYPE(loc_oBusca) = "O"
11569:                             IF !loc_oBusca.this_lAchouRegistro
11570:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11571:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11572:                                 loc_oBusca.Show()
11573:                             ENDIF
11574:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11575:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11576:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11577:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11578:                                 ENDIF
11579:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11580:                             ELSE
11581:                                 loc_oPg.txt_4c_Teor.Value = ""
11582:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11583:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11584:                                 ENDIF
11585:                                 THIS.this_oBusinessObject.this_cTeors = ""
11586:                             ENDIF
11587:                             loc_oBusca.Release()
11588:                         ENDIF
11589:                         IF USED("cursor_4c_BuscaTeorSel")
11590:                             USE IN cursor_4c_BuscaTeorSel
11591:                         ENDIF

*-- Linhas 11700 a 11741:
11700:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11701:         *----------------------------------------------------------------------
11702:         IF !USED("cursor_4c_SigPrTar")
11703:             SET NULL ON
11704:             CREATE CURSOR cursor_4c_SigPrTar (;
11705:                 DtInis  D NULL, ;
11706:                 DtFims  D NULL, ;
11707:                 Usuars  C(10), ;
11708:                 Tarefas C(10), ;
11709:                 ObsTars M)
11710:             SET NULL OFF
11711:         ENDIF
11712: 
11713:         *----------------------------------------------------------------------
11714:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11715:         *-- Campos: Arquivos
11716:         *----------------------------------------------------------------------
11717:         IF !USED("cursor_4c_SigPrArq")
11718:             SET NULL ON
11719:             CREATE CURSOR cursor_4c_SigPrArq (;
11720:                 Arquivos C(200))
11721:             SET NULL OFF
11722:         ENDIF
11723: 
11724:         *----------------------------------------------------------------------
11725:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11726:         *----------------------------------------------------------------------
11727:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11728:         WITH loc_oPg.shp_4c_ArqFundo
11729:             .Top         = 415
11730:             .Left        = 584
11731:             .Width       = 407
11732:             .Height      = 202
11733:             .BackColor   = RGB(230, 230, 230)
11734:             .BorderColor = RGB(180, 180, 180)
11735:             .Visible     = .T.
11736:         ENDWITH
11737: 
11738:         *----------------------------------------------------------------------
11739:         *-- Say31: "Observacao da Tarefa" (T:144 L:583 W:126 H:15)
11740:         *----------------------------------------------------------------------
11741:         loc_oPg.AddObject("lbl_4c_ObsTarLabel", "Label")

*-- Linhas 11758 a 11857:
11758:         *-- Colunas: Data Inicio | Data Conclusao | Usuario | Tarefa
11759:         *-- Cols 1-3 readonly, Col4 editavel (quando usuario e dono e tarefa nao finalizada)
11760:         *----------------------------------------------------------------------
11761:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
11762:         WITH loc_oPg.grd_4c_Designer
11763:             .Top         = 160
11764:             .Left        = 10
11765:             .Width       = 495
11766:             .Height      = 238
11767:             .ColumnCount = 4
11768:             .FontName    = "Tahoma"
11769:             .FontSize    = 8
11770:             .DeleteMark  = .F.
11771:             .ScrollBars  = 2
11772:             .Themes      = .F.
11773:             .Visible     = .T.
11774:             .RecordMark   = .F.
11775:         ENDWITH
11776:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11777:         WITH loc_oPg.grd_4c_Designer
11778:             WITH .Column1
11779:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11780:                 .Header1.FontName  = "Tahoma"
11781:                 .Header1.FontSize  = 8
11782:                 .Header1.Alignment = 2
11783:                 .Width             = 140
11784:                 .Movable           = .F.
11785:                 .Resizable         = .F.
11786:                 .ReadOnly          = .T.
11787:                 .Alignment         = 2
11788:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11789:             ENDWITH
11790:             WITH .Column2
11791:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11792:                 .Header1.FontName  = "Tahoma"
11793:                 .Header1.FontSize  = 8
11794:                 .Header1.Alignment = 2
11795:                 .Width             = 140
11796:                 .Movable           = .F.
11797:                 .Resizable         = .F.
11798:                 .ReadOnly          = .T.
11799:                 .Alignment         = 2
11800:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11801:             ENDWITH
11802:             WITH .Column3
11803:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11804:                 .Header1.FontName  = "Tahoma"
11805:                 .Header1.FontSize  = 8
11806:                 .Header1.Alignment = 2
11807:                 .Width             = 90
11808:                 .Movable           = .F.
11809:                 .Resizable         = .F.
11810:                 .ReadOnly          = .T.
11811:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11812:             ENDWITH
11813:             WITH .Column4
11814:                 .Header1.Caption   = "Tarefa"
11815:                 .Header1.FontName  = "Tahoma"
11816:                 .Header1.FontSize  = 8
11817:                 .Header1.Alignment = 2
11818:                 .Width             = 90
11819:                 .Movable           = .F.
11820:                 .Resizable         = .F.
11821:                 .ReadOnly          = .F.
11822:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11823:             ENDWITH
11824:         ENDWITH
11825:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11826: 
11827:         *----------------------------------------------------------------------
11828:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11829:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11830:         *----------------------------------------------------------------------
11831:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11832:         WITH loc_oPg.obj_4c_ObsTarefas
11833:             .Top              = 160
11834:             .Left             = 584
11835:             .Width            = 407
11836:             .Height           = 238
11837:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11838:             .FontName         = "Tahoma"
11839:             .FontSize         = 8
11840:             .SpecialEffect    = 1
11841:             .ForeColor        = RGB(36, 84, 155)
11842:             .Enabled          = .T.
11843:             .Visible          = .T.
11844:         ENDWITH
11845: 
11846:         *----------------------------------------------------------------------
11847:         *-- btnIniTarefa: Iniciar Tarefa (T:161 L:509 W:42 H:42)
11848:         *----------------------------------------------------------------------
11849:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11850:         WITH loc_oPg.cmd_4c_IniTarefa
11851:             .Top             = 161
11852:             .Left            = 509
11853:             .Width           = 42
11854:             .Height          = 42
11855:             .Caption         = ""
11856:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11857:             .FontName        = "Tahoma"

*-- Linhas 11886 a 11939:
11886:         *----------------------------------------------------------------------
11887:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
11888:         *----------------------------------------------------------------------
11889:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
11890:         WITH loc_oPg.grd_4c_Arquivos
11891:             .Top         = 415
11892:             .Left        = 10
11893:             .Width       = 495
11894:             .Height      = 202
11895:             .ColumnCount = 1
11896:             .FontName    = "Tahoma"
11897:             .FontSize    = 8
11898:             .DeleteMark  = .F.
11899:             .ScrollBars  = 2
11900:             .ReadOnly    = .T.
11901:             .Themes      = .F.
11902:             .Visible     = .T.
11903:             .RecordMark   = .F.
11904:         ENDWITH
11905:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
11906:         WITH loc_oPg.grd_4c_Arquivos
11907:             WITH .Column1
11908:                 .Header1.Caption   = "Arquivos Para Designer"
11909:                 .Header1.FontName  = "Tahoma"
11910:                 .Header1.FontSize  = 8
11911:                 .Header1.Alignment = 2
11912:                 .Width             = 464
11913:                 .Movable           = .F.
11914:                 .Resizable         = .F.
11915:                 .ReadOnly          = .T.
11916:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
11917:             ENDWITH
11918:         ENDWITH
11919:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
11920: 
11921:         *----------------------------------------------------------------------
11922:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
11923:         *----------------------------------------------------------------------
11924:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
11925:         WITH loc_oPg.cmd_4c_InsArqs
11926:             .Top             = 416
11927:             .Left            = 509
11928:             .Width           = 42
11929:             .Height          = 42
11930:             .Caption         = ""
11931:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
11932:             .FontName        = "Tahoma"
11933:             .FontSize        = 8
11934:             .Themes          = .F.
11935:             .ToolTipText     = "Inserir Arquivo"
11936:             .Enabled         = .F.
11937:             .Visible         = .T.
11938:         ENDWITH
11939:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")

*-- Linhas 11994 a 12037:
11994:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
11995: 
11996:         *----------------------------------------------------------------------
11997:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
11998:         *----------------------------------------------------------------------
11999:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12000:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12001:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12002: 
12003:         *----------------------------------------------------------------------
12004:         *-- Binding When para EditBox Obs da Tarefa
12005:         *----------------------------------------------------------------------
12006:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12007: 
12008:         *----------------------------------------------------------------------
12009:         *-- Bindings When para botoes de tarefa
12010:         *----------------------------------------------------------------------
12011:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12012:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12013: 
12014:         *----------------------------------------------------------------------
12015:         *-- Binding When para Column1 do grdArquivos
12016:         *----------------------------------------------------------------------
12017:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12018: 
12019:         *----------------------------------------------------------------------
12020:         *-- Bindings When para botoes de arquivo
12021:         *----------------------------------------------------------------------
12022:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12023:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12024:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12025:     ENDPROC
12026: 
12027:     *--------------------------------------------------------------------------
12028:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12029:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12030:     *--------------------------------------------------------------------------
12031:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12032:         LOCAL loc_oPg
12033:         TRY
12034:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12035:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12036:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12037:                     *-- Sincronizar editbox com observacao da tarefa selecionada

*-- Linhas 12124 a 12147:
12124:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12125:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12126:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12127:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12128:                 ENDIF
12129:             ENDIF
12130:         CATCH TO loc_oErro
12131:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12132:         ENDTRY
12133:     ENDPROC
12134: 
12135:     *--------------------------------------------------------------------------
12136:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12137:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12138:     *--------------------------------------------------------------------------
12139:     PROCEDURE BtnFimTarefaClick()
12140:         LOCAL loc_lResultado
12141:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12142:             RETURN
12143:         ENDIF
12144:         loc_lResultado = .T.
12145:         TRY
12146:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12147:                 loc_lResultado = .F.

*-- Linhas 12162 a 12213:
12162:                 SELECT cursor_4c_SigPrTar
12163:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12164:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12165:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12166:                 ENDIF
12167:             ENDIF
12168:         CATCH TO loc_oErro
12169:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12170:         ENDTRY
12171:     ENDPROC
12172: 
12173:     *--------------------------------------------------------------------------
12174:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12175:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12176:     *--------------------------------------------------------------------------
12177:     PROCEDURE BtnInsArqsClick()
12178:         LOCAL loc_cArq, loc_lResultado
12179:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12180:             RETURN
12181:         ENDIF
12182:         loc_lResultado = .T.
12183:         TRY
12184:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12185:             IF EMPTY(loc_cArq)
12186:                 loc_lResultado = .F.
12187:             ENDIF
12188:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12189:                 SELECT cursor_4c_SigPrArq
12190:                 APPEND BLANK
12191:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12192:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12193:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12194:                 ENDIF
12195:             ENDIF
12196:         CATCH TO loc_oErro
12197:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12198:         ENDTRY
12199:     ENDPROC
12200: 
12201:     *--------------------------------------------------------------------------
12202:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12203:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12204:     *--------------------------------------------------------------------------
12205:     PROCEDURE BtnOpnArqsClick()
12206:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12207:         loc_lResultado = .T.
12208:         TRY
12209:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12210:                 loc_lResultado = .F.
12211:             ENDIF
12212:             IF loc_lResultado
12213:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))

*-- Linhas 12259 a 12282:
12259:                     SKIP -1
12260:                 ENDIF
12261:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12262:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12263:                 ENDIF
12264:                 *-- Limpar imagem ao excluir arquivo
12265:                 LOCAL loc_oPg
12266:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12267:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12268:                     CLEAR RESOURCES
12269:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12270:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12271:                 ENDIF
12272:             ENDIF
12273:         CATCH TO loc_oErro
12274:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12275:         ENDTRY
12276:     ENDPROC
12277: 
12278:     *--------------------------------------------------------------------------
12279:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12280:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12281:     *--------------------------------------------------------------------------
12282:     PROCEDURE ImgArqJpgClick()

*-- Linhas 12317 a 12411:
12317: 
12318:     *--------------------------------------------------------------------------
12319:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12320:     * Legado: grdDesigner.Column4.Text1.When
12321:     *--------------------------------------------------------------------------
12322:     PROCEDURE GrdDesignerCol4When()
12323:         LOCAL loc_lResult
12324:         loc_lResult = .F.
12325:         TRY
12326:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12327:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12328:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12329:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12330:                         loc_lResult = .T.
12331:                     ENDIF
12332:                 ENDIF
12333:             ENDIF
12334:         CATCH TO loc_oErro
12335:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12336:         ENDTRY
12337:         RETURN loc_lResult
12338:     ENDPROC
12339: 
12340:     *--------------------------------------------------------------------------
12341:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12342:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12343:     *--------------------------------------------------------------------------
12344:     PROCEDURE GrdDesignerCol4Valid()
12345:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12346:         loc_lResult = .T.
12347:         TRY
12348:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12349:                 loc_lResultado = .T.
12350:             ENDIF
12351:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12352:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12353:             IF !EMPTY(loc_cCodigo)
12354:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12355:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12356:                     "Buscar Tarefa")
12357:                 IF VARTYPE(loc_oBusca) = "O"
12358:                     IF !loc_oBusca.this_lAchouRegistro
12359:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12360:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12361:                         loc_oBusca.Show()
12362:                     ENDIF
12363:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12364:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12365:                     ELSE
12366:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12367:                     ENDIF
12368:                     loc_oBusca.Release()
12369:                 ENDIF
12370:                 IF USED("cursor_4c_BuscaTar")
12371:                     USE IN cursor_4c_BuscaTar
12372:                 ENDIF
12373:             ENDIF
12374:         CATCH TO loc_oErro
12375:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12376:         ENDTRY
12377:         RETURN loc_lResult
12378:     ENDPROC
12379: 
12380:     *--------------------------------------------------------------------------
12381:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12382:     * Legado: grdDesigner.Column4.Text1.LostFocus
12383:     *--------------------------------------------------------------------------
12384:     PROCEDURE GrdDesignerCol4LostFocus()
12385:         LOCAL loc_oPg
12386:         TRY
12387:             IF LASTKEY() = 13
12388:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12389:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12390:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12391:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12392:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12393:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12394:                             ENDIF
12395:                         ENDIF
12396:                     ENDIF
12397:                 ENDIF
12398:             ENDIF
12399:         CATCH TO loc_oErro
12400:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12401:         ENDTRY
12402:     ENDPROC
12403: 
12404:     *--------------------------------------------------------------------------
12405:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12406:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12407:     *--------------------------------------------------------------------------
12408:     PROCEDURE ObsTarefasWhen()
12409:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12410:     ENDPROC
12411: 

*-- Linhas 12426 a 12450:
12426:     ENDPROC
12427: 
12428:     *--------------------------------------------------------------------------
12429:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12430:     * Legado: grdArquivos.Column1.Text1.When
12431:     *--------------------------------------------------------------------------
12432:     PROCEDURE GrdArquivosCol1When()
12433:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12434:     ENDPROC
12435: 
12436:     *--------------------------------------------------------------------------
12437:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12438:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12439:     *--------------------------------------------------------------------------
12440:     PROCEDURE BtnInsArqsWhen()
12441:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12442:     ENDPROC
12443: 
12444:     *--------------------------------------------------------------------------
12445:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12446:     * Legado: btnOpnArqs.When - Return .t.
12447:     *--------------------------------------------------------------------------
12448:     PROCEDURE BtnOpnArqsWhen()
12449:         RETURN .T.
12450:     ENDPROC

