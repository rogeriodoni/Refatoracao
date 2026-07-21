# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1336: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formacg.prg) - TRECHOS RELEVANTES PARA PASS GRID (1651 linhas total):

*-- Linhas 335 a 374:
335:         BINDEVENT(loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
336: 
337:         *-- Grid principal
338:         loc_oP1.AddObject("grd_4c_Lista", "Grid")
339:         WITH loc_oP1.grd_4c_Lista
340:             .Top             = 121
341:             .Left            = 12
342:             .Width           = 976
343:             .Height          = 455
344:             .ColumnCount     = 2
345:             .RecordSourceType = 1
346:             .ReadOnly        = .T.
347:             .DeleteMark      = .F.
348:             .RecordMark      = .F.
349:             .ScrollBars      = 3
350:             .GridLines       = 3
351:             .AllowHeaderSizing = .T.
352:             .FontName        = "Tahoma"
353:             .FontSize        = 8
354:             .GridLineColor   = RGB(238,238,238)
355:             .Visible         = .T.
356:             .Column1.Width   = 120
357:             .Column1.Header1.Caption = "Grupo"
358:             .Column2.Width   = 500
359:             .Column2.Header1.Caption = "Nome"
360:         ENDWITH
361: 
362:         THIS.TornarControlesVisiveis(loc_oP1)
363:         loc_oP1.cnt_4c_PainelCopia.Visible = .F.
364:     ENDPROC
365: 
366:     *==========================================================================
367:     * ConfigurarPaginaDados - Page2: campos + 4 abas internas
368:     *==========================================================================
369:     PROTECTED PROCEDURE ConfigurarPaginaDados()
370:         LOCAL loc_oP2
371:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
372: 
373:         *-- Cabecalho cinza
374:         loc_oP2.AddObject("cnt_4c_Cabecalho", "Container")

*-- Linhas 738 a 913:
738:         ENDWITH
739:         BINDEVENT(loc_oAba.txt_4c_FiltroAcesso, "LostFocus", THIS, "TxtFiltroAcessoValid")
740: 
741:         loc_oAba.AddObject("grd_4c_Programas", "Grid")
742:         loc_oGrid = loc_oAba.grd_4c_Programas
743:         WITH loc_oGrid
744:             .Top              = 35
745:             .Left             = 5
746:             .Width            = 990
747:             .Height           = 400
748:             .ColumnCount      = 4
749:             .RecordSourceType = 1
750:             .ReadOnly         = .F.
751:             .DeleteMark       = .F.
752:             .RecordMark       = .F.
753:             .ScrollBars       = 3
754:             .GridLines        = 3
755:             .AllowHeaderSizing = .T.
756:             .FontName         = "Tahoma"
757:             .FontSize         = 8
758:             .GridLineColor    = RGB(238,238,238)
759:             .Visible          = .T.
760:             .Column1.Width    = 380
761:             .Column1.ReadOnly = .T.
762:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
763:             .Column2.Width    = 120
764:             .Column2.ReadOnly = .T.
765:             .Column2.Header1.Caption = "Programa"
766:             .Column3.Width    = 65
767:             .Column3.ReadOnly = .F.
768:             .Column3.Sparse   = .F.
769:             .Column3.Header1.Caption = "Acesso"
770:             .Column4.Width    = 120
771:             .Column4.ReadOnly = .T.
772:             .Column4.Header1.Caption = "Par" + CHR(226) + "metro"
773:         ENDWITH
774:         WITH loc_oGrid.Column3
775:             .AddObject("chk_4c_Marcas", "CheckBox")
776:         ENDWITH
777:         WITH loc_oGrid.Column3.chk_4c_Marcas
778:             .Caption   = ""
779:             .Width     = 60
780:             .Height    = 17
781:             .BackStyle = 0
782:             .Themes    = .F.
783:         ENDWITH
784:         BINDEVENT(loc_oGrid.Column3.chk_4c_Marcas, "When", THIS, "ChkMarcasWhen")
785:     ENDPROC
786: 
787:     *==========================================================================
788:     * ConfigurarAbaBarra - Page3 interna: grid barra de ferramentas
789:     *==========================================================================
790:     PROTECTED PROCEDURE ConfigurarAbaBarra()
791:         LOCAL loc_oAba, loc_oGrid
792:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
793: 
794:         loc_oAba.AddObject("grd_4c_Barra", "Grid")
795:         loc_oGrid = loc_oAba.grd_4c_Barra
796:         WITH loc_oGrid
797:             .Top              = 10
798:             .Left             = 5
799:             .Width            = 990
800:             .Height           = 430
801:             .ColumnCount      = 2
802:             .RecordSourceType = 1
803:             .ReadOnly         = .F.
804:             .DeleteMark       = .F.
805:             .RecordMark       = .F.
806:             .ScrollBars       = 3
807:             .GridLines        = 3
808:             .AllowHeaderSizing = .T.
809:             .FontName         = "Tahoma"
810:             .FontSize         = 8
811:             .GridLineColor    = RGB(238,238,238)
812:             .Visible          = .T.
813:             .Column1.Width    = 550
814:             .Column1.ReadOnly = .T.
815:             .Column1.Header1.Caption = "Item da Barra"
816:             .Column2.Width    = 80
817:             .Column2.ReadOnly = .F.
818:             .Column2.Sparse   = .F.
819:             .Column2.Header1.Caption = "Ativo"
820:         ENDWITH
821:         WITH loc_oGrid.Column2
822:             .AddObject("chk_4c_SelBarras", "CheckBox")
823:         ENDWITH
824:         WITH loc_oGrid.Column2.chk_4c_SelBarras
825:             .Caption   = ""
826:             .Width     = 75
827:             .Height    = 17
828:             .BackStyle = 0
829:             .Themes    = .F.
830:         ENDWITH
831:         BINDEVENT(loc_oGrid.Column2.chk_4c_SelBarras, "When", THIS, "ChkSelBarrasWhen")
832:     ENDPROC
833: 
834:     *==========================================================================
835:     * ConfigurarAbaTelas - Page4 interna: grid acesso a campos nas telas
836:     *==========================================================================
837:     PROTECTED PROCEDURE ConfigurarAbaTelas()
838:         LOCAL loc_oAba, loc_oGrid
839:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4
840: 
841:         loc_oAba.AddObject("grd_4c_Telas", "Grid")
842:         loc_oGrid = loc_oAba.grd_4c_Telas
843:         WITH loc_oGrid
844:             .Top              = 10
845:             .Left             = 5
846:             .Width            = 990
847:             .Height           = 430
848:             .ColumnCount      = 3
849:             .RecordSourceType = 1
850:             .ReadOnly         = .F.
851:             .DeleteMark       = .F.
852:             .RecordMark       = .F.
853:             .ScrollBars       = 3
854:             .GridLines        = 3
855:             .AllowHeaderSizing = .T.
856:             .FontName         = "Tahoma"
857:             .FontSize         = 8
858:             .GridLineColor    = RGB(238,238,238)
859:             .Visible          = .T.
860:             .Column1.Width    = 280
861:             .Column1.ReadOnly = .T.
862:             .Column1.Header1.Caption = "Tela"
863:             .Column2.Width    = 250
864:             .Column2.ReadOnly = .T.
865:             .Column2.Header1.Caption = "Campo"
866:             .Column3.Width    = 80
867:             .Column3.ReadOnly = .F.
868:             .Column3.Sparse   = .F.
869:             .Column3.Header1.Caption = "Bloqueado"
870:         ENDWITH
871:         WITH loc_oGrid.Column3
872:             .AddObject("chk_4c_Status", "CheckBox")
873:         ENDWITH
874:         WITH loc_oGrid.Column3.chk_4c_Status
875:             .Caption   = ""
876:             .Width     = 75
877:             .Height    = 17
878:             .BackStyle = 0
879:             .Themes    = .F.
880:         ENDWITH
881:         BINDEVENT(loc_oGrid.Column3.chk_4c_Status, "When", THIS, "ChkStatusWhen")
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * CarregarLista - Carrega cursor_4c_Dados e vincula ao grd_4c_Lista
886:     *==========================================================================
887:     PROCEDURE CarregarLista()
888:         LOCAL loc_lSucesso, loc_oGrid
889:         loc_lSucesso = .F.
890:         TRY
891:             IF THIS.this_oBusinessObject.Buscar("")
892:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
893:                 loc_oGrid.ColumnCount = 2
894:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
895:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
896:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"
897:                 loc_oGrid.Column1.Header1.Caption = "Grupo"
898:                 loc_oGrid.Column2.Header1.Caption = "Nome"
899:                 loc_oGrid.Column1.Width = 120
900:                 loc_oGrid.Column2.Width = 500
901:                 loc_oGrid.FontName = "Tahoma"
902:                 loc_oGrid.FontSize = 8
903:                 loc_oGrid.Refresh()
904:                 loc_lSucesso = .T.
905:             ENDIF
906:         CATCH TO loc_oErro
907:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
908:         ENDTRY
909:         RETURN loc_lSucesso
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * CarregarDadosGrupo - Carrega todas as 4 abas para o grupo

*-- Linhas 974 a 1067:
974:     ENDPROC
975: 
976:     *==========================================================================
977:     * CarregarProgramasAba - Vincula cursor_4c_Programas ao grd_4c_Programas
978:     *==========================================================================
979:     PROCEDURE CarregarProgramasAba(par_cGrupos)
980:         LOCAL loc_oGrid
981:         TRY
982:             IF THIS.this_oBusinessObject.CarregarProgramas(par_cGrupos)
983:                 THIS.this_cFiltroPrograma = ""
984:                 IF USED("cursor_4c_Programas")
985:                     SELECT cursor_4c_Programas
986:                     SET FILTER TO
987:                 ENDIF
988:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas
989:                 loc_oGrid.ColumnCount = 4
990:                 loc_oGrid.RecordSource = "cursor_4c_Programas"
991:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.Descricaos"
992:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.Programas"
993:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.Marcas"
994:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.Parametros"
995:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
996:                 loc_oGrid.Column2.Header1.Caption = "Programa"
997:                 loc_oGrid.Column3.Header1.Caption = "Acesso"
998:                 loc_oGrid.Column4.Header1.Caption = "Par" + CHR(226) + "metro"
999:                 loc_oGrid.Column1.Width = 380
1000:                 loc_oGrid.Column2.Width = 120
1001:                 loc_oGrid.Column3.Width = 65
1002:                 loc_oGrid.Column4.Width = 120
1003:                 loc_oGrid.FontName = "Tahoma"
1004:                 loc_oGrid.FontSize = 8
1005:                 loc_oGrid.Refresh()
1006:             ENDIF
1007:         CATCH TO loc_oErro
1008:             MsgErro("Erro ao carregar programas: " + loc_oErro.Message, "Erro")
1009:         ENDTRY
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     * CarregarBarraAba - Vincula TmpBarra ao grd_4c_Barra
1014:     *==========================================================================
1015:     PROCEDURE CarregarBarraAba(par_cGrupos)
1016:         LOCAL loc_oGrid
1017:         TRY
1018:             IF THIS.this_oBusinessObject.CarregarBarra(par_cGrupos)
1019:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra
1020:                 loc_oGrid.ColumnCount = 2
1021:                 loc_oGrid.RecordSource = "TmpBarra"
1022:                 loc_oGrid.Column1.ControlSource = "TmpBarra.Descricaos"
1023:                 loc_oGrid.Column2.ControlSource = "TmpBarra.SelBarras"
1024:                 loc_oGrid.Column1.Header1.Caption = "Item da Barra"
1025:                 loc_oGrid.Column2.Header1.Caption = "Ativo"
1026:                 loc_oGrid.Column1.Width = 550
1027:                 loc_oGrid.Column2.Width = 80
1028:                 loc_oGrid.FontName = "Tahoma"
1029:                 loc_oGrid.FontSize = 8
1030:                 loc_oGrid.Refresh()
1031:             ENDIF
1032:         CATCH TO loc_oErro
1033:             MsgErro("Erro ao carregar barra: " + loc_oErro.Message, "Erro")
1034:         ENDTRY
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * CarregarTelasAba - Vincula crSigAcTel ao grd_4c_Telas
1039:     *==========================================================================
1040:     PROCEDURE CarregarTelasAba(par_cGrupos)
1041:         LOCAL loc_oGrid
1042:         TRY
1043:             IF THIS.this_oBusinessObject.CarregarAcessoTelas(par_cGrupos)
1044:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas
1045:                 loc_oGrid.ColumnCount = 3
1046:                 loc_oGrid.RecordSource = "crSigAcTel"
1047:                 loc_oGrid.Column1.ControlSource = "crSigAcTel.cDescTelas"
1048:                 loc_oGrid.Column2.ControlSource = "crSigAcTel.cCampos"
1049:                 loc_oGrid.Column3.ControlSource = "crSigAcTel.nStatus"
1050:                 loc_oGrid.Column1.Header1.Caption = "Tela"
1051:                 loc_oGrid.Column2.Header1.Caption = "Campo"
1052:                 loc_oGrid.Column3.Header1.Caption = "Bloqueado"
1053:                 loc_oGrid.Column1.Width = 280
1054:                 loc_oGrid.Column2.Width = 250
1055:                 loc_oGrid.Column3.Width = 80
1056:                 loc_oGrid.FontName = "Tahoma"
1057:                 loc_oGrid.FontSize = 8
1058:                 loc_oGrid.Refresh()
1059:             ENDIF
1060:         CATCH TO loc_oErro
1061:             MsgErro("Erro ao carregar acesso a telas: " + loc_oErro.Message, "Erro")
1062:         ENDTRY
1063:     ENDPROC
1064: 
1065:     *==========================================================================
1066:     * FormParaBO
1067:     *==========================================================================

*-- Linhas 1096 a 1116:
1096:         loc_oAbas.Page1.lbl_4c_StatusDisp.Caption = ""
1097:         loc_oAbas.Page1.lbl_4c_StatusSel.Caption  = ""
1098:         loc_oAbas.Page2.txt_4c_FiltroAcesso.Value = ""
1099:         loc_oAbas.Page2.grd_4c_Programas.RecordSource = ""
1100:         loc_oAbas.Page3.grd_4c_Barra.RecordSource = ""
1101:         loc_oAbas.Page4.grd_4c_Telas.RecordSource = ""
1102:         THIS.this_cFiltroPrograma = ""
1103:     ENDPROC
1104: 
1105:     *==========================================================================
1106:     * HabilitarCampos
1107:     *==========================================================================
1108:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1109:         LOCAL loc_oP2
1110:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
1111:         *-- Grupo: so editavel no INCLUIR
1112:         loc_oP2.txt_4c_Grupo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1113:         loc_oP2.txt_4c_NomeCompleto.Enabled = par_lHabilitar
1114:         THIS.HabilitarAbaUsuarios(par_lHabilitar)
1115:         THIS.HabilitarColunasGrid(par_lHabilitar)
1116:     ENDPROC

*-- Linhas 1132 a 1186:
1132:     *==========================================================================
1133:     PROTECTED PROCEDURE HabilitarColunasGrid(par_lHabilitar)
1134:         TRY
1135:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Column3.ReadOnly = !par_lHabilitar
1136:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra.Column2.ReadOnly     = !par_lHabilitar
1137:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas.Column3.ReadOnly     = !par_lHabilitar
1138:         CATCH TO loc_oErro
1139:             MsgErro("Erro ao habilitar grids: " + loc_oErro.Message, "Erro")
1140:         ENDTRY
1141:     ENDPROC
1142: 
1143:     *==========================================================================
1144:     * AtivaCopia - Mostra/oculta painel de copia de acessos na Page1
1145:     *==========================================================================
1146:     PROCEDURE AtivaCopia(par_lAtivo)
1147:         LOCAL loc_oP1
1148:         loc_oP1 = THIS.pgf_4c_Paginas.Page1
1149:         loc_oP1.cnt_4c_PainelCopia.Visible = par_lAtivo
1150:         loc_oP1.cnt_4c_Botoes.Visible      = !par_lAtivo
1151:         loc_oP1.grd_4c_Lista.Enabled       = !par_lAtivo
1152:         IF par_lAtivo
1153:             loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value = ""
1154:             loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
1155:         ENDIF
1156:     ENDPROC
1157: 
1158:     *==========================================================================
1159:     * SalvarDadosRelacionados - Salva usuarios, programas, barra e telas
1160:     *==========================================================================
1161:     PROCEDURE SalvarDadosRelacionados(par_cGrupos)
1162:         LOCAL loc_lSucesso, loc_oAba1, loc_nI, loc_cUsu
1163:         loc_lSucesso = .T.
1164:         TRY
1165:             loc_oAba1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1166: 
1167:             *-- Cursor temporario com usuarios selecionados
1168:             IF USED("cursor_4c_UsrSalvar")
1169:                 USE IN cursor_4c_UsrSalvar
1170:             ENDIF
1171:             CREATE CURSOR cursor_4c_UsrSalvar (Usuarios C(10))
1172:             FOR loc_nI = 1 TO loc_oAba1.lbx_4c_Selecionados.ListCount
1173:                 loc_cUsu = ALLTRIM(loc_oAba1.lbx_4c_Selecionados.List(loc_nI))
1174:                 IF !EMPTY(loc_cUsu)
1175:                     INSERT INTO cursor_4c_UsrSalvar VALUES (m.loc_cUsu)
1176:                 ENDIF
1177:             ENDFOR
1178: 
1179:             IF !THIS.this_oBusinessObject.SalvarUsuarios(par_cGrupos, "cursor_4c_UsrSalvar")
1180:                 loc_lSucesso = .F.
1181:             ENDIF
1182:             IF USED("cursor_4c_UsrSalvar")
1183:                 USE IN cursor_4c_UsrSalvar
1184:             ENDIF
1185: 
1186:             *-- Salvar programas (limpar filtro antes)

*-- Linhas 1322 a 1352:
1322:     PROCEDURE BtnBuscarClick()
1323:         LOCAL loc_oBusca, loc_cGrupoSel
1324:         TRY
1325:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
1326:                 "cursor_4c_Busca", "Grupos", "", "Buscar Grupo")
1327:             loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1328:             loc_oBusca.mAddColuna("NComps", "", "Nome")
1329:             loc_oBusca.Show()
1330:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1331:                 SELECT cursor_4c_Busca
1332:                 loc_cGrupoSel = ALLTRIM(Grupos)
1333:                 USE IN cursor_4c_Busca
1334:                 THIS.this_oBusinessObject.Buscar(loc_cGrupoSel)
1335:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
1336:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1337:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1338:             ELSE
1339:                 IF USED("cursor_4c_Busca")
1340:                     USE IN cursor_4c_Busca
1341:                 ENDIF
1342:             ENDIF
1343:         CATCH TO loc_oErro
1344:             MsgErro("Erro ao buscar grupo: " + loc_oErro.Message, "Erro")
1345:         ENDTRY
1346:     ENDPROC
1347: 
1348:     PROCEDURE BtnSalvarClick()
1349:         LOCAL loc_cGrupos, loc_cNome
1350:         loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1351:         loc_cNome   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
1352: 

*-- Linhas 1415 a 1434:
1415:             loc_cValor = ALLTRIM(loc_oTxt.Value)
1416:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
1417:                 "cursor_4c_BuscaOrigem", "Grupos", loc_cValor, "Selecionar Grupo Origem")
1418:             loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1419:             loc_oBusca.mAddColuna("NComps", "", "Nome")
1420:             loc_oBusca.Show()
1421:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
1422:                 SELECT cursor_4c_BuscaOrigem
1423:                 loc_oTxt.Value = ALLTRIM(Grupos)
1424:                 USE IN cursor_4c_BuscaOrigem
1425:             ELSE
1426:                 IF USED("cursor_4c_BuscaOrigem")
1427:                     USE IN cursor_4c_BuscaOrigem
1428:                 ENDIF
1429:             ENDIF
1430:         CATCH TO loc_oErro
1431:             MsgErro("Erro ao buscar grupo de origem: " + loc_oErro.Message, "Erro")
1432:         ENDTRY
1433:     ENDPROC
1434: 

*-- Linhas 1565 a 1583:
1565:                 SET FILTER TO THISFORM.this_cFiltroPrograma $ UPPER(ALLTRIM(Descricaos))
1566:             ENDIF
1567:             GO TOP
1568:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Refresh()
1569:         ENDIF
1570:     ENDPROC
1571: 
1572:     *==========================================================================
1573:     * ChkMarcasWhen - Permite editar checkbox Marcas somente em INCLUIR/ALTERAR
1574:     *==========================================================================
1575:     PROCEDURE ChkMarcasWhen()
1576:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1577:     ENDPROC
1578: 
1579:     *==========================================================================
1580:     * ChkSelBarrasWhen - Permite editar checkbox SelBarras somente em INCLUIR/ALTERAR
1581:     *==========================================================================
1582:     PROCEDURE ChkSelBarrasWhen()
1583:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

