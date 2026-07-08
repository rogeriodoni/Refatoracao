# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (26)
- [CARGA-DADOS] OptionGroup 'opt_4c_Situacao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_SituacaoCopia' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_SituacaoPro' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_ProdWeb' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_OpcVar' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SubCp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrupoCompo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrupoCompo2' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_DTemp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Mtz' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [SQL-AVISO] 60 alertas SQL-COLUNA para tabela desconhecida suprimidos (provavel falso positivo por reuso de alias em queries complexas)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label1' Top=245 (diff=213px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Top original=18 vs migrado 'lbl_4c_LblGrupoCus' Top=444 (diff=426px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Left original=21 vs migrado 'lbl_4c_LblGrupoCus' Left=479 (diff=458px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=320 (diff=315px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=250 (diff=242px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label2' Top=270 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label10' Top=512 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=967 vs migrado 'lbl_4c_Label10' Left=147 (diff=820px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label9' Top=349 (diff=102px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=884 vs migrado 'lbl_4c_Label9' Left=756 (diff=128px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAcabamento' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=350 vs migrado 'lbl_4c_LblAcabamento' Top=385 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=172 vs migrado 'chk_4c_Fwoption1' Top=360 (diff=188px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=879 vs migrado 'chk_4c_Fwoption1' Left=180 (diff=699px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblVenda' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=581 vs migrado 'lbl_4c_LblVendaSep' Top=503 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblVenda' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=416 vs migrado 'lbl_4c_LblVendaSep' Left=361 (diff=55px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (12587 linhas total):

*-- Linhas 35 a 157:
35:     this_nAntOrd         = 0  && Salva ordem anterior para reordenamento em GradFase
36: 
37:     *--------------------------------------------------------------------------
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *--------------------------------------------------------------------------
43:     PROTECTED PROCEDURE InicializarForm()
44:         LOCAL loc_lSucesso, loc_lContinuar
45:         loc_lSucesso   = .F.
46:         loc_lContinuar = .T.
47:         TRY
48:             IF !gb_4c_ValidandoUI
49:                 IF gnConnHandle <= 0
50:                     MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
51:                     loc_lContinuar = .F.
52:                 ENDIF
53:             ENDIF
54: 
55:             IF loc_lContinuar
56:                 this_oBusinessObject = CREATEOBJECT("ProdutoBO")
57:                 IF VARTYPE(this_oBusinessObject) # "O"
58:                     MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio.", "Erro")
59:                     loc_lContinuar = .F.
60:                 ENDIF
61:             ENDIF
62: 
63:             IF loc_lContinuar
64:                 THIS.ConfigurarPageFrame()
65:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67:                 THIS.ConfigurarEventos()
68:                 THIS.TornarControlesVisiveis(THIS)
69:                 IF !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72:                 loc_lSucesso = .T.
73:             ENDIF
74:         CATCH TO loc_oErro
75:             MsgErro(loc_oErro.Message, "Erro ao inicializar")
76:         ENDTRY
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *--------------------------------------------------------------------------
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         LOCAL loc_oPgf, loc_oPage1, loc_oPage2
83:         TRY
84:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85:             loc_oPgf = THIS.pgf_4c_Paginas
86:             WITH loc_oPgf
87:                 .Top       = -29
88:                 .Left      = 0
89:                 .Width     = 1000
90:                 .Height    = 629
91:                 .PageCount = 2
92:                 .Tabs      = .F.
93:                 .Themes    = .F.
94:                 .Visible   = .T.
95:             ENDWITH
96: 
97:             loc_oPage1 = loc_oPgf.Page1
98:             WITH loc_oPage1
99:                 .Caption   = "Lista"
100:                 .BackColor = RGB(53,53,53)
101:             ENDWITH
102:             THIS.ConfigurarPage1(loc_oPage1)
103: 
104:             loc_oPage2 = loc_oPgf.Page2
105:             WITH loc_oPage2
106:                 .Caption   = "Dados"
107:                 .BackColor = RGB(53,53,53)
108:             ENDWITH
109:             THIS.ConfigurarPage2(loc_oPage2)
110: 
111:         CATCH TO loc_oErro
112:             MsgErro(loc_oErro.Message, "Erro ao configurar PageFrame")
113:         ENDTRY
114:     ENDPROC
115: 
116:     *--------------------------------------------------------------------------
117:     PROTECTED PROCEDURE ConfigurarPage1(par_oPage)
118:         LOCAL loc_oContainer
119:         TRY
120:             *-- Cabecalho (cntSombra no legado) - Top = 2+29 = 31
121:             par_oPage.AddObject("cnt_4c_Cabecalho", "Container")
122:             WITH par_oPage.cnt_4c_Cabecalho
123:                 .Top         = 31
124:                 .Left        = 0
125:                 .Width       = 800
126:                 .Height      = 80
127:                 .BackStyle   = 1
128:                 .BackColor   = RGB(53,53,53)
129:                 .BorderWidth = 0
130:                 .Visible     = .T.
131:             ENDWITH
132: 
133:             par_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:             WITH par_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
135:                 .Top       = 15
136:                 .Left      = 10
137:                 .Width     = 769
138:                 .Height    = 40
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 16
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(0,0,0)
143:                 .BackStyle = 0
144:                 .Caption   = "Cadastro de Produtos"
145:                 .Visible   = .T.
146:             ENDWITH
147: 
148:             par_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:             WITH par_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
150:                 .Top       = 18
151:                 .Left      = 10
152:                 .Width     = 769
153:                 .Height    = 46
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 16
156:                 .FontBold  = .T.
157:                 .ForeColor = RGB(255,255,255)

*-- Linhas 458 a 513:
458:                 .Themes    = .F.
459:                 .Visible   = .T.
460:             ENDWITH
461: 
462:             *-- OptionGroup situacao (optFilSituas no legado: 3 botoes Todos/Ativos/Inativos)
463:             par_oPage.cnt_4c_Filtros.AddObject("opt_4c_Situacao", "OptionGroup")
464:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao
465:                 .Top         = 5
466:                 .Left        = 315
467:                 .Width       = 75
468:                 .Height      = 58
469:                 .ButtonCount = 3
470:                 .Value       = 1
471:                 .Themes      = .F.
472:                 .Visible     = .T.
473:             ENDWITH
474: 
475:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(1)
476:                 .Caption   = "Todos"
477:                 .Top       = 0
478:                 .Left      = 0
479:                 .Width     = 65
480:                 .Height    = 17
481:                 .FontName  = "Tahoma"
482:                 .FontSize  = 8
483:                 .Themes    = .F.
484:                 .Value     = 1
485:             ENDWITH
486: 
487:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(2)
488:                 .Caption   = "Ativos"
489:                 .Top       = 19
490:                 .Left      = 0
491:                 .Width     = 65
492:                 .Height    = 17
493:                 .FontName  = "Tahoma"
494:                 .FontSize  = 8
495:                 .Themes    = .F.
496:             ENDWITH
497: 
498:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(3)
499:                 .Caption   = "Inativos"
500:                 .Top       = 38
501:                 .Left      = 0
502:                 .Width     = 65
503:                 .Height    = 17
504:                 .FontName  = "Tahoma"
505:                 .FontSize  = 8
506:                 .Themes    = .F.
507:             ENDWITH
508: 
509:             *-- Container de mensagem "Aguarde" (cntMensagem no legado - Visible=.F.)
510:             par_oPage.AddObject("cnt_4c_Mensagem", "Container")
511:             WITH par_oPage.cnt_4c_Mensagem
512:                 .Top         = 255 + 29
513:                 .Left        = 254

*-- Linhas 745 a 790:
745:                 .FontSize = 8
746:                 .Themes   = .F.
747:                 .Visible  = .T.
748:             ENDWITH
749: 
750:             par_oPage.cnt_4c_Acabado.AddObject("opt_4c_SituacaoCopia", "OptionGroup")
751:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia
752:                 .Top         = 83
753:                 .Left        = 102
754:                 .Width       = 129
755:                 .Height      = 17
756:                 .ButtonCount = 2
757:                 .Value       = 1
758:                 .Themes      = .F.
759:                 .Visible     = .T.
760:             ENDWITH
761: 
762:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia.Buttons(1)
763:                 .Caption  = "Ativo"
764:                 .Top      = 0
765:                 .Left     = 0
766:                 .Width    = 55
767:                 .Height   = 17
768:                 .FontName = "Tahoma"
769:                 .FontSize = 8
770:                 .Themes   = .F.
771:             ENDWITH
772: 
773:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia.Buttons(2)
774:                 .Caption  = "Inativo"
775:                 .Top      = 0
776:                 .Left     = 60
777:                 .Width    = 55
778:                 .Height   = 17
779:                 .FontName = "Tahoma"
780:                 .FontSize = 8
781:                 .Themes   = .F.
782:             ENDWITH
783: 
784:             par_oPage.cnt_4c_Acabado.AddObject("cmd_4c_OkCopia", "CommandButton")
785:             WITH par_oPage.cnt_4c_Acabado.cmd_4c_OkCopia
786:                 .Top      = 90
787:                 .Left     = 344
788:                 .Width    = 40
789:                 .Height   = 40
790:                 .Caption  = ""

*-- Linhas 949 a 992:
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     PROTECTED PROCEDURE ConfigurarPage2(par_oPage)
953:         LOCAL loc_oContainer
954:         TRY
955:             *-- Botoes de acao (Grupo_Salva no legado) - Top = 9+29 = 38
956:             par_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
957:             WITH par_oPage.cnt_4c_BotoesAcao
958:                 .Top         = 38
959:                 .Left        = 842
960:                 .Width       = 160
961:                 .Height      = 85
962:                 .BackStyle = 1
963:                 .BackColor = RGB(53, 53, 53)
964:                 .BorderStyle = 0
965:                 .Visible     = .T.
966:             ENDWITH
967: 
968:             par_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
969:             WITH par_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar
970:                 .Top             = 5
971:                 .Left            = 5
972:                 .Width           = 75
973:                 .Height          = 75
974:                 .Caption         = "Confirmar"
975:                 .FontName        = "Comic Sans MS"
976:                 .FontBold        = .T.
977:                 .FontItalic      = .T.
978:                 .FontSize        = 8
979:                 .ForeColor       = RGB(90,90,90)
980:                 .BackColor       = RGB(255,255,255)
981:                 .Themes          = .F.
982:                 .SpecialEffect   = 0
983:                 .PicturePosition = 13
984:                 .MousePointer    = 15
985:                 .WordWrap        = .T.
986:                 .AutoSize        = .F.
987:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
988:                 .Visible         = .T.
989:             ENDWITH
990: 
991:             par_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
992:             WITH par_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar

*-- Linhas 1020 a 1095:
1020:     ENDPROC
1021: 
1022:     *--------------------------------------------------------------------------
1023:     * TornarControlesVisiveis - Torna visiveis apenas controles _4c_ (evita
1024:     * containers flutuantes com Visible=.F. no legado)
1025:     *--------------------------------------------------------------------------
1026:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1027:         LOCAL loc_nI, loc_oCtrl, loc_cNome
1028:         TRY
1029:             FOR loc_nI = 1 TO par_oContainer.ControlCount
1030:                 loc_oCtrl = par_oContainer.Controls(loc_nI)
1031:                 IF "_4c_" $ loc_oCtrl.Name
1032:                     *-- Filtrar containers flutuantes que devem permanecer ocultos
1033:                     loc_cNome = UPPER(loc_oCtrl.Name)
1034:                     IF loc_cNome == "CNT_4C_ACABADO" OR ;
1035:                        loc_cNome == "CNT_4C_MENSAGEM" OR ;
1036:                        loc_cNome == "IMG_4C_FIGJPG" OR ;
1037:                        loc_cNome == "LBL_4C_SEMMENU" OR ;
1038:                        loc_cNome == "CMD_4C_COPIARPRODUTO"
1039:                         LOOP
1040:                     ENDIF
1041:                     IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1042:                         loc_oCtrl.Visible = .T.
1043:                     ENDIF
1044:                 ENDIF
1045:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1046:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1047:                 ENDIF
1048:             ENDFOR
1049:         CATCH TO loc_oErro
1050:             *-- Tolerado: controles podem nao estar acessiveis durante ValidarUIFidelity
1051:         ENDTRY
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     PROCEDURE FormatarGridLista(par_oGrid)
1056:         LOCAL loc_oGrid
1057:         TRY
1058:             loc_oGrid = par_oGrid
1059: 
1060:             *-- Column1: Produto (CPros)
1061:             loc_oGrid.Column1.Header1.Caption  = "Produto"
1062:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Lista.CPros"
1063:             loc_oGrid.Column1.Width            = 80
1064:             loc_oGrid.Column1.ReadOnly         = .T.
1065:             loc_oGrid.Column1.Header1.FontBold = .T.
1066: 
1067:             *-- Column2: Descricao (DPros)
1068:             loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
1069:             loc_oGrid.Column2.ControlSource    = "cursor_4c_Lista.DPros"
1070:             loc_oGrid.Column2.Width            = 250
1071:             loc_oGrid.Column2.ReadOnly         = .T.
1072:             loc_oGrid.Column2.Header1.FontBold = .T.
1073: 
1074:             *-- Column3: Grupo (DGrus - descricao do grupo via JOIN)
1075:             loc_oGrid.Column3.Header1.Caption  = "Grupo"
1076:             loc_oGrid.Column3.ControlSource    = "cursor_4c_Lista.DGrus"
1077:             loc_oGrid.Column3.Width            = 100
1078:             loc_oGrid.Column3.ReadOnly         = .T.
1079:             loc_oGrid.Column3.Header1.FontBold = .T.
1080: 
1081:             *-- Column4: Subgrupo (SGrus)
1082:             loc_oGrid.Column4.Header1.Caption  = "Subgrp."
1083:             loc_oGrid.Column4.ControlSource    = "cursor_4c_Lista.SGrus"
1084:             loc_oGrid.Column4.Width            = 70
1085:             loc_oGrid.Column4.ReadOnly         = .T.
1086:             loc_oGrid.Column4.Header1.FontBold = .T.
1087: 
1088:             *-- Column5: Ref. Fornecedor (Reffs)
1089:             loc_oGrid.Column5.Header1.Caption  = "Ref. Fornecedor"
1090:             loc_oGrid.Column5.ControlSource    = "cursor_4c_Lista.Reffs"
1091:             loc_oGrid.Column5.Width            = 180
1092:             loc_oGrid.Column5.ReadOnly         = .T.
1093:             loc_oGrid.Column5.Header1.FontBold = .T.
1094: 
1095:             *-- Column6: Usuario (UsuaAlts)

*-- Linhas 1116 a 1205:
1116:     *--------------------------------------------------------------------------
1117:     * AlternarPagina - Troca entre Page1 (Lista) e Page2 (Dados)
1118:     *--------------------------------------------------------------------------
1119:     PROCEDURE AlternarPagina(par_nPagina)
1120:         LOCAL loc_oErro
1121:         TRY
1122:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1123:             this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
1124:         CATCH TO loc_oErro
1125:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
1126:         ENDTRY
1127:     ENDPROC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1131:     * Chamado apos transicoes de modo (INCLUIR/ALTERAR/VISUALIZAR)
1132:     *--------------------------------------------------------------------------
1133:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1134:         LOCAL loc_oPage1, loc_oPage2, loc_lEditando, loc_oErro
1135:         TRY
1136:             loc_oPage1   = THIS.pgf_4c_Paginas.Page1
1137:             loc_oPage2   = THIS.pgf_4c_Paginas.Page2
1138:             loc_lEditando = this_lEmEdicao
1139: 
1140:             *-- Botoes CRUD na Page1: desabilitar quando editando
1141:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = !loc_lEditando
1142:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = !loc_lEditando
1143:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = !loc_lEditando
1144:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = !loc_lEditando
1145:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = !loc_lEditando
1146:             loc_oPage1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = !loc_lEditando
1147: 
1148:             *-- Botoes de acao na Page2: Confirmar habilitado somente quando editando
1149:             loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1150:         CATCH TO loc_oErro
1151:             *-- Tolerado: botoes podem nao existir durante inicializacao
1152:         ENDTRY
1153:     ENDPROC
1154: 
1155:     *--------------------------------------------------------------------------
1156:     * BtnSalvarClick - Alias de BtnConfirmarClick (compatibilidade)
1157:     *--------------------------------------------------------------------------
1158:     PROCEDURE BtnSalvarClick()
1159:         THIS.BtnConfirmarClick()
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     * CarregarLista - Carrega dados no grid da Page1 com filtros aplicados
1164:     *--------------------------------------------------------------------------
1165:     PROCEDURE CarregarLista()
1166:         LOCAL loc_cSQL, loc_cWhere, loc_cCodGrupo
1167:         LOCAL loc_dDtIni, loc_dDtFim, loc_nSituacao
1168:         LOCAL loc_nRet, loc_oPage1, loc_nCount, loc_lContinuar
1169:         IF gb_4c_ValidandoUI
1170:             RETURN
1171:         ENDIF
1172:         IF gnConnHandle <= 0
1173:             RETURN
1174:         ENDIF
1175:         TRY
1176:             loc_lContinuar = .T.
1177: 
1178:             *-- Obter valores dos filtros
1179:             loc_oPage1    = THIS.pgf_4c_Paginas.Page1
1180:             loc_cCodGrupo = ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value)
1181:             loc_dDtIni    = loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterIni.Value
1182:             loc_dDtFim    = loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterFim.Value
1183:             loc_nSituacao = loc_oPage1.cnt_4c_Filtros.opt_4c_Situacao.Value
1184: 
1185:             *-- Montar clausula WHERE
1186:             loc_cWhere = " WHERE (1=1)"
1187:             IF !EMPTY(loc_cCodGrupo)
1188:                 loc_cWhere = loc_cWhere + ;
1189:                     " AND p.CGrus = " + EscaparSQL(PADR(loc_cCodGrupo, 10))
1190:             ENDIF
1191:             IF !EMPTY(loc_dDtIni)
1192:                 loc_cWhere = loc_cWhere + ;
1193:                     " AND p.DataAlts >= " + FormatarDataSQL(loc_dDtIni)
1194:             ENDIF
1195:             IF !EMPTY(loc_dDtFim)
1196:                 loc_cWhere = loc_cWhere + ;
1197:                     " AND p.DataAlts <= " + FormatarDataSQL(loc_dDtFim)
1198:             ENDIF
1199:             DO CASE
1200:                 CASE loc_nSituacao = 2
1201:                     loc_cWhere = loc_cWhere + " AND ISNULL(g.chkInstalas, 0) = 1"
1202:                 CASE loc_nSituacao = 3
1203:                     loc_cWhere = loc_cWhere + " AND ISNULL(g.chkInstalas, 0) = 0"
1204:             ENDCASE
1205: 

*-- Linhas 1247 a 1740:
1247:     ENDPROC
1248: 
1249:     *--------------------------------------------------------------------------
1250:     * ConfigurarEventos - BINDEVENT para botoes e filtros
1251:     * IMPORTANTE: todos os handlers devem ser PUBLIC
1252:     *--------------------------------------------------------------------------
1253:     PROTECTED PROCEDURE ConfigurarEventos()
1254:         LOCAL loc_oPage1, loc_oPage2, loc_oErro
1255:         TRY
1256:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
1257:             loc_oPage2 = THIS.pgf_4c_Paginas.Page2
1258: 
1259:             *-- Botoes CRUD (Page1)
1260:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
1261:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
1262:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
1263:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
1264:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
1265:             BINDEVENT(loc_oPage1.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
1266: 
1267:             *-- Botoes de acao (Page2)
1268:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1269:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1270: 
1271:             *-- Grid DblClick -> Alterar
1272:             BINDEVENT(loc_oPage1.grd_4c_Lista, "DblClick", THIS, "GridDblClick")
1273: 
1274:             *-- Filtro de grupo: KeyPress (NUNCA LostFocus - causa recursao infinita)
1275:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo, ;
1276:                       "KeyPress", THIS, "FiltroGrupoKeyPress")
1277: 
1278:             *-- Filtro data final: KeyPress (ENTER/TAB recarrega lista)
1279:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterFim, ;
1280:                       "KeyPress", THIS, "FiltroDataFimKeyPress")
1281: 
1282:             *-- OptionGroup situacao: InteractiveChange recarrega lista
1283:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.opt_4c_Situacao, ;
1284:                       "InteractiveChange", THIS, "FiltroSituacaoChange")
1285: 
1286:             *-- OptionGroup de navegacao interna das paginas de dados
1287:             BINDEVENT(loc_oPage2.obj_4c_Optiongroup1, ;
1288:                       "InteractiveChange", THIS, "NavegacaoDadosChange")
1289: 
1290:             *-- OptionGroup situacao da copia (Page1 cnt_4c_Acabado)
1291:             BINDEVENT(loc_oPage1.cnt_4c_Acabado.opt_4c_SituacaoCopia, ;
1292:                       "InteractiveChange", THIS, "SituacaoCopiaChange")
1293: 
1294:             *-- Lookups da pagina de dados (pgf_4c_DadosInterno.Page1)
1295:             LOCAL loc_oPgDados
1296:             loc_oPgDados = loc_oPage2.pgf_4c_DadosInterno.Page1
1297: 
1298:             *-- OptionGroup situacao do produto (Page1 de dados)
1299:             BINDEVENT(loc_oPgDados.opt_4c_SituacaoPro, ;
1300:                       "InteractiveChange", THIS, "SituacaoProChange")
1301: 
1302:             *-- OptionGroup produto web (Page1 de dados)
1303:             BINDEVENT(loc_oPgDados.opt_4c_ProdWeb, ;
1304:                       "InteractiveChange", THIS, "ProdWebChange")
1305: 
1306:             *-- OptionGroup opcao variante (Page1 de dados)
1307:             BINDEVENT(loc_oPgDados.opt_4c_OpcVar, ;
1308:                       "InteractiveChange", THIS, "OpcVarChange")
1309: 
1310:             *-- Produto Equivalente
1311:             BINDEVENT(loc_oPgDados.txt_4c_CProEq, "KeyPress", THIS, "CProEqKeyPress")
1312:             BINDEVENT(loc_oPgDados.txt_4c_CProEq, "DblClick", THIS, "CProEqDblClick")
1313: 
1314:             *-- Grupo Produto
1315:             BINDEVENT(loc_oPgDados.txt_4c_Cgru, "KeyPress", THIS, "CgruKeyPress")
1316:             BINDEVENT(loc_oPgDados.txt_4c_Cgru, "DblClick", THIS, "CgruDblClick")
1317: 
1318:             *-- SubGrupo
1319:             BINDEVENT(loc_oPgDados.txt_4c_CSGru, "KeyPress", THIS, "CSGruKeyPress")
1320:             BINDEVENT(loc_oPgDados.txt_4c_CSGru, "DblClick", THIS, "CSGruDblClick")
1321: 
1322:             *-- Linha
1323:             BINDEVENT(loc_oPgDados.txt_4c_Lin, "KeyPress", THIS, "LinKeyPress")
1324:             BINDEVENT(loc_oPgDados.txt_4c_Lin, "DblClick", THIS, "LinDblClick")
1325: 
1326:             *-- Colecao / Grupo de Venda
1327:             BINDEVENT(loc_oPgDados.txt_4c_Col, "KeyPress", THIS, "ColKeyPress")
1328:             BINDEVENT(loc_oPgDados.txt_4c_Col, "DblClick", THIS, "ColDblClick")
1329: 
1330:             *-- Fornecedor (campo + botao F4)
1331:             BINDEVENT(loc_oPgDados.txt_4c_Ifor, "KeyPress", THIS, "IforKeyPress")
1332:             BINDEVENT(loc_oPgDados.cmd_4c_BtnFornecedor, "Click", THIS, "BtnFornecedorClick")
1333: 
1334:             *-- Cor
1335:             BINDEVENT(loc_oPgDados.txt_4c_CorPro, "KeyPress", THIS, "CorProKeyPress")
1336:             BINDEVENT(loc_oPgDados.txt_4c_CorPro, "DblClick", THIS, "CorProDblClick")
1337: 
1338:             *-- Tamanho
1339:             BINDEVENT(loc_oPgDados.txt_4c_Tam, "KeyPress", THIS, "TamKeyPress")
1340:             BINDEVENT(loc_oPgDados.txt_4c_Tam, "DblClick", THIS, "TamDblClick")
1341: 
1342:             *-- Finalidade
1343:             BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "KeyPress", THIS, "CodFinPKeyPress")
1344:             BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "DblClick", THIS, "CodFinPDblClick")
1345: 
1346:             *-- Acabamento
1347:             BINDEVENT(loc_oPgDados.txt_4c_CodAcb, "KeyPress", THIS, "CodAcbKeyPress")
1348:             BINDEVENT(loc_oPgDados.txt_4c_CodAcb, "DblClick", THIS, "CodAcbDblClick")
1349: 
1350:             *-- Classificacao
1351:             BINDEVENT(loc_oPgDados.txt_4c_Class, "KeyPress", THIS, "ClassKeyPress")
1352:             BINDEVENT(loc_oPgDados.txt_4c_Class, "DblClick", THIS, "ClassDblClick")
1353: 
1354:             *-- Local
1355:             BINDEVENT(loc_oPgDados.txt_4c_Local, "KeyPress", THIS, "LocalKeyPress")
1356:             BINDEVENT(loc_oPgDados.txt_4c_Local, "DblClick", THIS, "LocalDblClick")
1357: 
1358:             *-- Unidade 1
1359:             BINDEVENT(loc_oPgDados.txt_4c_Cuni, "KeyPress", THIS, "CuniKeyPress")
1360:             BINDEVENT(loc_oPgDados.txt_4c_Cuni, "DblClick", THIS, "CuniDblClick")
1361: 
1362:             *-- Unidade 2
1363:             BINDEVENT(loc_oPgDados.txt_4c_Cunip, "KeyPress", THIS, "CunipKeyPress")
1364:             BINDEVENT(loc_oPgDados.txt_4c_Cunip, "DblClick", THIS, "CunipDblClick")
1365: 
1366:             *-- === Composicao (Page2 do inner pageframe) ===
1367:             LOCAL loc_oPgComp
1368:             loc_oPgComp = loc_oPage2.pgf_4c_DadosInterno.Page2
1369: 
1370:             BINDEVENT(loc_oPgComp.grd_4c_Compo,             "AfterRowColChange", THIS, "CompoAfterRowColChange")
1371:             BINDEVENT(loc_oPgComp.grd_4c_SubCp,             "AfterRowColChange", THIS, "SubCpAfterRowColChange")
1372:             BINDEVENT(loc_oPgComp.chk_4c_ChkLiberaCusto,    "InteractiveChange", THIS, "LiberaCustoChange")
1373:             BINDEVENT(loc_oPgComp.chk_4c_ChkLiberaVenda,    "InteractiveChange", THIS, "LiberaVendaChange")
1374:             BINDEVENT(loc_oPgComp.txt_4c_Moec,              "KeyPress", THIS, "MoecKeyPress")
1375:             BINDEVENT(loc_oPgComp.txt_4c_Moepc,             "KeyPress", THIS, "MoepcKeyPress")
1376:             BINDEVENT(loc_oPgComp.txt_4c_Moecusf,           "KeyPress", THIS, "MoecusfKeyPress")
1377:             BINDEVENT(loc_oPgComp.txt_4c_Moeda,             "KeyPress", THIS, "MoedaKeyPress")
1378:             BINDEVENT(loc_oPgComp.txt_4c_Moepv,             "KeyPress", THIS, "MoepvKeyPress")
1379:             BINDEVENT(loc_oPgComp.txt_4c_Moev,              "KeyPress", THIS, "MoevKeyPress")
1380:             BINDEVENT(loc_oPgComp.txt_4c_Ftio,              "KeyPress", THIS, "FtioKeyPress")
1381:             BINDEVENT(loc_oPgComp.txt_4c_Margem,            "KeyPress", THIS, "MargemKeyPress")
1382:             BINDEVENT(loc_oPgComp.txt_4c_Cmkpc,             "KeyPress", THIS, "CmkpcKeyPress")
1383:             BINDEVENT(loc_oPgComp.cmd_4c_CmdCalcVals,       "Click",    THIS, "CalcValsClick")
1384:             BINDEVENT(loc_oPgComp.cmd_4c_CmdPesoM,          "Click",    THIS, "PesoMClick")
1385:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(1), "Click",    THIS, "CompoIncluirClick")
1386:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(2), "Click",    THIS, "CompoExcluirClick")
1387:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(3), "Click",    THIS, "CompoAtualizaClick")
1388:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(4), "Click",    THIS, "CompoCopiarClick")
1389:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(5), "Click",    THIS, "CompoGrupoClick")
1390:             BINDEVENT(loc_oPgComp.cmdg_4c_SubCp.Buttons(1), "Click",    THIS, "SubCpIncluirClick")
1391:             BINDEVENT(loc_oPgComp.cmdg_4c_SubCp.Buttons(2), "Click",    THIS, "SubCpExcluirClick")
1392: 
1393:             *-- === Custo (Page6 do inner pageframe) ===
1394:             LOCAL loc_oPgCusto
1395:             loc_oPgCusto = loc_oPage2.pgf_4c_DadosInterno.Page6
1396: 
1397:             BINDEVENT(loc_oPgCusto.grd_4c_GrdCustoCompo,           "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
1398:             BINDEVENT(loc_oPgCusto.cbo_4c_CmbTipos,                 "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
1399:             BINDEVENT(loc_oPgCusto.cmdg_4c_CustoCompo.Buttons(1),  "Click", THIS, "CustoCompoIncluirClick")
1400:             BINDEVENT(loc_oPgCusto.cmdg_4c_CustoCompo.Buttons(2),  "Click", THIS, "CustoCompoExcluirClick")
1401: 
1402:             *-- === DadosFiscais (Page3 do inner pageframe) ===
1403:             LOCAL loc_oPgFisc
1404:             loc_oPgFisc = loc_oPage2.pgf_4c_DadosInterno.Page3
1405: 
1406:             BINDEVENT(loc_oPgFisc.txt_4c__gruccus,   "KeyPress", THIS, "GruccusFiscKeyPress")
1407:             BINDEVENT(loc_oPgFisc.txt_4c__dgruccus,  "KeyPress", THIS, "DgruccusFiscKeyPress")
1408:             BINDEVENT(loc_oPgFisc.txt_4c__contaccus, "KeyPress", THIS, "ContaccusFiscKeyPress")
1409:             BINDEVENT(loc_oPgFisc.txt_4c__dcontaccus,"KeyPress", THIS, "DcontaccusFiscKeyPress")
1410:             BINDEVENT(loc_oPgFisc.txt_4c_Clfiscal,   "KeyPress", THIS, "ClfiscalKeyPress")
1411:             BINDEVENT(loc_oPgFisc.txt_4c_Clfiscal,   "DblClick", THIS, "ClfiscalDblClick")
1412:             BINDEVENT(loc_oPgFisc.txt_4c_Dclfiscal,  "KeyPress", THIS, "DclfiscalKeyPress")
1413:             BINDEVENT(loc_oPgFisc.txt_4c_Origmerc,   "KeyPress", THIS, "OrigmercKeyPress")
1414:             BINDEVENT(loc_oPgFisc.txt_4c_Origmerc,   "DblClick", THIS, "OrigmercDblClick")
1415:             BINDEVENT(loc_oPgFisc.txt_4c_Dorigmerc,  "KeyPress", THIS, "DorigmercKeyPress")
1416:             BINDEVENT(loc_oPgFisc.txt_4c_Sittricm,   "KeyPress", THIS, "SittricmKeyPress")
1417:             BINDEVENT(loc_oPgFisc.txt_4c_Sittricm,   "DblClick", THIS, "SittricmDblClick")
1418:             BINDEVENT(loc_oPgFisc.txt_4c_Dsittricm,  "KeyPress", THIS, "DsittricmKeyPress")
1419:             BINDEVENT(loc_oPgFisc.txt_4c_Codigo,     "KeyPress", THIS, "CodServsFiscKeyPress")
1420:             BINDEVENT(loc_oPgFisc.txt_4c_TpTrib,     "KeyPress", THIS, "TpTribKeyPress")
1421:             BINDEVENT(loc_oPgFisc.txt_4c_TpTrib,     "DblClick", THIS, "TpTribDblClick")
1422:             BINDEVENT(loc_oPgFisc.txt_4c_Iat,        "KeyPress", THIS, "IatFiscKeyPress")
1423:             BINDEVENT(loc_oPgFisc.txt_4c_AliqIPI,    "KeyPress", THIS, "AliqIPIKeyPress")
1424:             BINDEVENT(loc_oPgFisc.txt_4c_Mvalor,     "KeyPress", THIS, "MvalorKeyPress")
1425:             BINDEVENT(loc_oPgFisc.txt_4c_Mvalor,     "DblClick", THIS, "MvalorDblClick")
1426:             BINDEVENT(loc_oPgFisc.txt_4c_Metal,      "KeyPress", THIS, "MetalKeyPress")
1427:             BINDEVENT(loc_oPgFisc.txt_4c_Metal,      "DblClick", THIS, "MetalDblClick")
1428:             BINDEVENT(loc_oPgFisc.txt_4c_Teor,       "KeyPress", THIS, "TeorKeyPress")
1429:             BINDEVENT(loc_oPgFisc.txt_4c_Teor,       "DblClick", THIS, "TeorDblClick")
1430:             BINDEVENT(loc_oPgFisc.cmd_4c_BtnDescFis, "Click",    THIS, "BtnDescFisClick")
1431: 
1432:         CATCH TO loc_oErro
1433:             MsgErro(loc_oErro.Message, "Erro ao configurar eventos")
1434:         ENDTRY
1435:     ENDPROC
1436: 
1437:     *--------------------------------------------------------------------------
1438:     * Handlers de OptionGroups (PUBLIC - obrigatorio para BINDEVENT)
1439:     *--------------------------------------------------------------------------
1440:     PROCEDURE SituacaoCopiaChange()
1441:         LOCAL loc_oErro
1442:         TRY
1443:             *-- Atualiza valor do OptionGroup situacao da copia
1444:         CATCH TO loc_oErro
1445:             MsgErro(loc_oErro.Message, "Erro em SituacaoCopiaChange")
1446:         ENDTRY
1447:     ENDPROC
1448: 
1449:     PROCEDURE SituacaoProChange()
1450:         LOCAL loc_oErro
1451:         TRY
1452:             *-- Atualiza valor do OptionGroup situacao do produto
1453:         CATCH TO loc_oErro
1454:             MsgErro(loc_oErro.Message, "Erro em SituacaoProChange")
1455:         ENDTRY
1456:     ENDPROC
1457: 
1458:     PROCEDURE ProdWebChange()
1459:         LOCAL loc_oErro
1460:         TRY
1461:             *-- Atualiza valor do OptionGroup produto web
1462:         CATCH TO loc_oErro
1463:             MsgErro(loc_oErro.Message, "Erro em ProdWebChange")
1464:         ENDTRY
1465:     ENDPROC
1466: 
1467:     PROCEDURE OpcVarChange()
1468:         LOCAL loc_oErro
1469:         TRY
1470:             *-- Atualiza valor do OptionGroup opcao variante
1471:         CATCH TO loc_oErro
1472:             MsgErro(loc_oErro.Message, "Erro em OpcVarChange")
1473:         ENDTRY
1474:     ENDPROC
1475: 
1476:     *--------------------------------------------------------------------------
1477:     * Handlers de botoes (PUBLIC - obrigatorio para BINDEVENT)
1478:     *--------------------------------------------------------------------------
1479:     PROCEDURE BtnIncluirClick()
1480:         LOCAL loc_oErro
1481:         TRY
1482:             THIS.AlternarPagina(2)
1483:             this_oBusinessObject.NovoRegistro()
1484:             this_lNovoRegistro = .T.
1485:             this_lEmEdicao     = .T.
1486:             this_cCodigo       = ""
1487:             THIS.LimparCampos()
1488:             THIS.HabilitarCampos(.T.)
1489:         CATCH TO loc_oErro
1490:             MsgErro(loc_oErro.Message, "Erro ao incluir produto")
1491:         ENDTRY
1492:     ENDPROC
1493: 
1494:     PROCEDURE BtnVisualizarClick()
1495:         LOCAL loc_cCodigo, loc_oErro, loc_lContinuar
1496:         loc_lContinuar = .T.
1497:         TRY
1498:             IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
1499:                 MsgAviso("Nenhum produto selecionado.", "Aviso")
1500:                 loc_lContinuar = .F.
1501:             ENDIF
1502:             IF loc_lContinuar
1503:                 SELECT cursor_4c_Lista
1504:                 loc_cCodigo = ALLTRIM(CPros)
1505:                 IF EMPTY(loc_cCodigo)
1506:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1507:                     loc_lContinuar = .F.
1508:                 ENDIF
1509:             ENDIF
1510:             IF loc_lContinuar
1511:                 THIS.AlternarPagina(2)
1512:                 this_lNovoRegistro = .F.
1513:                 this_lEmEdicao     = .F.
1514:                 this_cCodigo       = loc_cCodigo
1515:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1516:                 THIS.BOParaForm()
1517:                 THIS.HabilitarCampos(.F.)
1518:             ENDIF
1519:         CATCH TO loc_oErro
1520:             MsgErro(loc_oErro.Message, "Erro ao visualizar produto")
1521:         ENDTRY
1522:     ENDPROC
1523: 
1524:     PROCEDURE BtnAlterarClick()
1525:         LOCAL loc_cCodigo, loc_oErro, loc_lContinuar
1526:         loc_lContinuar = .T.
1527:         TRY
1528:             IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
1529:                 MsgAviso("Nenhum produto selecionado.", "Aviso")
1530:                 loc_lContinuar = .F.
1531:             ENDIF
1532:             IF loc_lContinuar
1533:                 SELECT cursor_4c_Lista
1534:                 loc_cCodigo = ALLTRIM(CPros)
1535:                 IF EMPTY(loc_cCodigo)
1536:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1537:                     loc_lContinuar = .F.
1538:                 ENDIF
1539:             ENDIF
1540:             IF loc_lContinuar
1541:                 THIS.AlternarPagina(2)
1542:                 this_lNovoRegistro = .F.
1543:                 this_lEmEdicao     = .T.
1544:                 this_cCodigo       = loc_cCodigo
1545:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1546:                 this_oBusinessObject.EditarRegistro()
1547:                 THIS.BOParaForm()
1548:                 THIS.HabilitarCampos(.T.)
1549:             ENDIF
1550:         CATCH TO loc_oErro
1551:             MsgErro(loc_oErro.Message, "Erro ao alterar produto")
1552:         ENDTRY
1553:     ENDPROC
1554: 
1555:     PROCEDURE BtnExcluirClick()
1556:         LOCAL loc_cCodigo, loc_lConfirmou, loc_oErro, loc_lContinuar
1557:         loc_lContinuar = .T.
1558:         TRY
1559:             IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
1560:                 MsgAviso("Nenhum produto selecionado.", "Aviso")
1561:                 loc_lContinuar = .F.
1562:             ENDIF
1563:             IF loc_lContinuar
1564:                 SELECT cursor_4c_Lista
1565:                 loc_cCodigo = ALLTRIM(CPros)
1566:                 IF EMPTY(loc_cCodigo)
1567:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1568:                     loc_lContinuar = .F.
1569:                 ENDIF
1570:             ENDIF
1571:             IF loc_lContinuar
1572:                 loc_lConfirmou = MsgConfirma("Deseja excluir o produto [" + ;
1573:                     loc_cCodigo + "]?", ;
1574:                     "Confirmar Exclus" + CHR(227) + "o")
1575:                 IF loc_lConfirmou
1576:                     this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1577:                     IF this_oBusinessObject.Excluir()
1578:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso.", "Sucesso")
1579:                         THIS.CarregarLista()
1580:                     ELSE
1581:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1582:                             "vel excluir o produto.", "Erro")
1583:                     ENDIF
1584:                 ENDIF
1585:             ENDIF
1586:         CATCH TO loc_oErro
1587:             MsgErro(loc_oErro.Message, "Erro ao excluir produto")
1588:         ENDTRY
1589:     ENDPROC
1590: 
1591:     PROCEDURE BtnBuscarClick()
1592:         LOCAL loc_oErro
1593:         TRY
1594:             THIS.CarregarLista()
1595:         CATCH TO loc_oErro
1596:             MsgErro(loc_oErro.Message, "Erro ao buscar")
1597:         ENDTRY
1598:     ENDPROC
1599: 
1600:     PROCEDURE BtnEncerrarClick()
1601:         LOCAL loc_oErro
1602:         TRY
1603:             THIS.Release()
1604:         CATCH TO loc_oErro
1605:             *-- Tolerado durante encerramento
1606:         ENDTRY
1607:     ENDPROC
1608: 
1609:     PROCEDURE BtnConfirmarClick()
1610:         LOCAL loc_oErro
1611:         TRY
1612:             THIS.FormParaBO()
1613:             IF this_lNovoRegistro
1614:                 IF this_oBusinessObject.Inserir()
1615:                     MsgInfo("Produto salvo com sucesso.", "Sucesso")
1616:                     THIS.AlternarPagina(1)
1617:                     THIS.CarregarLista()
1618:                 ELSE
1619:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1620:                         "vel salvar o produto.", "Erro")
1621:                 ENDIF
1622:             ELSE
1623:                 IF this_oBusinessObject.Atualizar()
1624:                     MsgInfo("Produto atualizado com sucesso.", "Sucesso")
1625:                     THIS.AlternarPagina(1)
1626:                     THIS.CarregarLista()
1627:                 ELSE
1628:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1629:                         "vel atualizar o produto.", "Erro")
1630:                 ENDIF
1631:             ENDIF
1632:         CATCH TO loc_oErro
1633:             MsgErro(loc_oErro.Message, "Erro ao confirmar opera" + CHR(231) + CHR(227) + "o")
1634:         ENDTRY
1635:     ENDPROC
1636: 
1637:     PROCEDURE BtnCancelarClick()
1638:         LOCAL loc_oErro
1639:         TRY
1640:             THIS.AlternarPagina(1)
1641:             this_lEmEdicao = .F.
1642:         CATCH TO loc_oErro
1643:             *-- Tolerado
1644:         ENDTRY
1645:     ENDPROC
1646: 
1647:     *--------------------------------------------------------------------------
1648:     * Handlers de filtros (PUBLIC - obrigatorio para BINDEVENT)
1649:     *--------------------------------------------------------------------------
1650:     PROCEDURE FiltroGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1651:         LOCAL loc_oErro
1652:         TRY
1653:             *-- F4(115): abrir lookup de grupo
1654:             IF par_nKeyCode = 115
1655:                 THIS.AbrirLookupGrupo()
1656:             ELSE
1657:                 *-- ENTER(13) ou TAB(9): validar grupo e recarregar
1658:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
1659:                     THIS.ValidarGrupoFiltro()
1660:                     THIS.CarregarLista()
1661:                 ENDIF
1662:             ENDIF
1663:         CATCH TO loc_oErro
1664:             *-- Tolerado
1665:         ENDTRY
1666:     ENDPROC
1667: 
1668:     PROCEDURE GridDblClick()
1669:         LOCAL loc_oErro
1670:         TRY
1671:             THIS.BtnAlterarClick()
1672:         CATCH TO loc_oErro
1673:             MsgErro(loc_oErro.Message, "Erro ao abrir registro")
1674:         ENDTRY
1675:     ENDPROC
1676: 
1677:     PROCEDURE FiltroDataFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1678:         LOCAL loc_oErro
1679:         TRY
1680:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1681:                 THIS.CarregarLista()
1682:             ENDIF
1683:         CATCH TO loc_oErro
1684:             *-- Tolerado
1685:         ENDTRY
1686:     ENDPROC
1687: 
1688:     PROCEDURE FiltroSituacaoChange()
1689:         LOCAL loc_oErro
1690:         TRY
1691:             THIS.CarregarLista()
1692:         CATCH TO loc_oErro
1693:             MsgErro(loc_oErro.Message, "Erro ao filtrar por situa" + CHR(231) + CHR(227) + "o")
1694:         ENDTRY
1695:     ENDPROC
1696: 
1697:     *--------------------------------------------------------------------------
1698:     * LimparCampos - Limpa todos os campos de pgDados (Parte 1)
1699:     *--------------------------------------------------------------------------
1700:     PROTECTED PROCEDURE LimparCampos()
1701:         LOCAL loc_oPgDados, loc_oErro
1702:         TRY
1703:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1704:             loc_oPgDados.txt_4c_Cpro.Value     = ""
1705:             loc_oPgDados.txt_4c_Dpro.Value     = ""
1706:             loc_oPgDados.txt_4c_DPro2s.Value   = ""
1707:             loc_oPgDados.txt_4c_Cbar.Value     = ""
1708:             loc_oPgDados.txt_4c_EAN13.Value    = ""
1709:             loc_oPgDados.txt_4c_CProEq.Value   = ""
1710:             loc_oPgDados.txt_4c_Cgru.Value     = ""
1711:             loc_oPgDados.txt_4c_Dgru.Value     = ""
1712:             loc_oPgDados.txt_4c_Merc.Value     = ""
1713:             loc_oPgDados.txt_4c_IdeCPros.Value = ""
1714:             loc_oPgDados.txt_4c_CSGru.Value    = ""
1715:             loc_oPgDados.txt_4c_DsGru.Value    = ""
1716:             loc_oPgDados.txt_4c_Qmin.Value     = ""
1717:             loc_oPgDados.txt_4c_Lin.Value      = ""
1718:             loc_oPgDados.txt_4c_DLin.Value     = ""
1719:             loc_oPgDados.txt_4c_Obs3.Value     = ""
1720:             loc_oPgDados.txt_4c_Col.Value      = ""
1721:             loc_oPgDados.txt_4c_DCol.Value     = ""
1722:             loc_oPgDados.txt_4c_Ifor.Value     = ""
1723:             loc_oPgDados.txt_4c_Dfor.Value     = ""
1724:             loc_oPgDados.txt_4c_Refs.Value     = ""
1725:             loc_oPgDados.opt_4c_SituacaoPro.Value = 1
1726:             *-- Parte 2
1727:             loc_oPgDados.txt_4c_LtMinsV.Value   = ""
1728:             loc_oPgDados.txt_4c_Conjunto.Value  = ""
1729:             loc_oPgDados.txt_4c_QtPed.Value     = ""
1730:             loc_oPgDados.txt_4c_DiasGar.Value   = ""
1731:             loc_oPgDados.txt_4c_Obs1.Value      = ""
1732:             loc_oPgDados.txt_4c_Obs2.Value      = ""
1733:             loc_oPgDados.txt_4c_Altura.Value    = ""
1734:             loc_oPgDados.txt_4c_Largura.Value   = ""
1735:             loc_oPgDados.txt_4c_Diametro.Value  = ""
1736:             loc_oPgDados.txt_4c_Espessura.Value = ""
1737:             loc_oPgDados.txt_4c_Compriment.Value = ""
1738:             loc_oPgDados.txt_4c_Tam.Value       = ""
1739:             loc_oPgDados.txt_4c_CorPro.Value    = ""
1740:             loc_oPgDados.txt_4c_CodFinP.Value   = ""

*-- Linhas 1765 a 1786:
1765:             loc_oPgDados.edt_4c_ObsCompras.Value = ""
1766:             loc_oPgDados.chk_4c_GarVit.Value    = 0
1767:             loc_oPgDados.chk_4c_Consig.Value    = 0
1768:             loc_oPgDados.chk_4c_FabrProprs.Value = 0
1769:             loc_oPgDados.chk_4c_Encoms.Value    = 0
1770:             loc_oPgDados.opt_4c_ProdWeb.Value   = 1
1771:             loc_oPgDados.opt_4c_OpcVar.Value    = 1
1772:             *-- Limpar campos FaseP (Page4)
1773:             LOCAL loc_oPgFaseP
1774:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
1775:             loc_oPgFaseP.txt_4c_Qmin.Value          = ""
1776:             loc_oPgFaseP.txt_4c_CodGarras.Value     = ""
1777:             loc_oPgFaseP.txt_4c_Conquilha.Value     = ""
1778:             loc_oPgFaseP.txt_4c_PesoBris.Value      = ""
1779:             loc_oPgFaseP.txt_4c_PesoMetal.Value     = ""
1780:             loc_oPgFaseP.txt_4c_PesoPdrs.Value      = ""
1781:             loc_oPgFaseP.txt_4c_Cor.Value           = ""
1782:             loc_oPgFaseP.txt_4c_Tam.Value           = ""
1783:             loc_oPgFaseP.txt_4c_codacb.Value        = ""
1784:             loc_oPgFaseP.txt_4c_Dacb.Value          = ""
1785:             loc_oPgFaseP.chk_4c_Opc_CravCera.Value  = 0
1786:             loc_oPgFaseP.chk_4c_Fwoption1.Value     = 0

*-- Linhas 1792 a 1849:
1792:             loc_oPgFaseP.img_4c_ImgBorracha.Visible = .F.
1793:             IF USED("cursor_4c_PrfFase")
1794:                 SELECT cursor_4c_PrfFase
1795:                 ZAP
1796:             ENDIF
1797:             IF USED("cursor_4c_Mtz")
1798:                 SELECT cursor_4c_Mtz
1799:                 ZAP
1800:             ENDIF
1801:         CATCH TO loc_oErro
1802:             MsgErro(loc_oErro.Message, "Erro ao limpar campos")
1803:         ENDTRY
1804:     ENDPROC
1805: 
1806:     *--------------------------------------------------------------------------
1807:     * HabilitarCampos - Habilita/desabilita campos de edicao
1808:     *--------------------------------------------------------------------------
1809:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1810:         LOCAL loc_oPgDados, loc_oErro
1811:         TRY
1812:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1813:             *-- Codigo: somente editavel em novo registro
1814:             loc_oPgDados.txt_4c_Cpro.ReadOnly  = !par_lHabilitar OR !this_lNovoRegistro
1815:             *-- Campos editaveis
1816:             loc_oPgDados.txt_4c_Dpro.ReadOnly    = !par_lHabilitar
1817:             loc_oPgDados.txt_4c_DPro2s.ReadOnly  = !par_lHabilitar
1818:             loc_oPgDados.txt_4c_Cbar.ReadOnly    = !par_lHabilitar
1819:             loc_oPgDados.txt_4c_EAN13.ReadOnly   = !par_lHabilitar
1820:             loc_oPgDados.txt_4c_CProEq.ReadOnly  = !par_lHabilitar
1821:             loc_oPgDados.txt_4c_Cgru.ReadOnly    = !par_lHabilitar
1822:             loc_oPgDados.txt_4c_Merc.ReadOnly    = !par_lHabilitar
1823:             loc_oPgDados.txt_4c_IdeCPros.ReadOnly = !par_lHabilitar
1824:             loc_oPgDados.txt_4c_CSGru.ReadOnly   = !par_lHabilitar
1825:             loc_oPgDados.txt_4c_Qmin.ReadOnly    = !par_lHabilitar
1826:             loc_oPgDados.txt_4c_Lin.ReadOnly     = !par_lHabilitar
1827:             loc_oPgDados.txt_4c_Obs3.ReadOnly    = !par_lHabilitar
1828:             loc_oPgDados.txt_4c_Col.ReadOnly     = !par_lHabilitar
1829:             loc_oPgDados.txt_4c_Ifor.ReadOnly    = !par_lHabilitar
1830:             loc_oPgDados.txt_4c_Refs.ReadOnly    = !par_lHabilitar
1831:             *-- Campos somente leitura (lookups preenchidos automaticamente)
1832:             loc_oPgDados.txt_4c_Dgru.ReadOnly  = .T.
1833:             loc_oPgDados.txt_4c_DsGru.ReadOnly = .T.
1834:             loc_oPgDados.txt_4c_DLin.ReadOnly  = .T.
1835:             loc_oPgDados.txt_4c_DCol.ReadOnly  = .T.
1836:             loc_oPgDados.txt_4c_Dfor.ReadOnly  = .T.
1837:             *-- Parte 2 - campos editaveis
1838:             loc_oPgDados.txt_4c_LtMinsV.ReadOnly   = !par_lHabilitar
1839:             loc_oPgDados.txt_4c_Conjunto.ReadOnly   = !par_lHabilitar
1840:             loc_oPgDados.txt_4c_QtPed.ReadOnly      = !par_lHabilitar
1841:             loc_oPgDados.txt_4c_DiasGar.ReadOnly    = !par_lHabilitar
1842:             loc_oPgDados.txt_4c_Obs1.ReadOnly       = !par_lHabilitar
1843:             loc_oPgDados.txt_4c_Obs2.ReadOnly       = !par_lHabilitar
1844:             loc_oPgDados.txt_4c_Altura.ReadOnly     = !par_lHabilitar
1845:             loc_oPgDados.txt_4c_Largura.ReadOnly    = !par_lHabilitar
1846:             loc_oPgDados.txt_4c_Diametro.ReadOnly   = !par_lHabilitar
1847:             loc_oPgDados.txt_4c_Espessura.ReadOnly  = !par_lHabilitar
1848:             loc_oPgDados.txt_4c_Compriment.ReadOnly = !par_lHabilitar
1849:             loc_oPgDados.txt_4c_Tam.ReadOnly        = !par_lHabilitar

*-- Linhas 1900 a 1943:
1900:     *--------------------------------------------------------------------------
1901:     * BOParaForm - Preenche campos do form com dados do BO (COMPLETO)
1902:     *--------------------------------------------------------------------------
1903:     PROTECTED PROCEDURE BOParaForm()
1904:         LOCAL loc_oPgDados, loc_oBO, loc_nRet, loc_oErro
1905:         TRY
1906:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1907:             loc_oBO      = this_oBusinessObject
1908: 
1909:             *-- === Identificacao ===
1910:             loc_oPgDados.txt_4c_Cpro.Value     = ALLTRIM(loc_oBO.this_cCpros)
1911:             loc_oPgDados.txt_4c_Dpro.Value     = ALLTRIM(loc_oBO.this_cDpros)
1912:             loc_oPgDados.txt_4c_DPro2s.Value   = ALLTRIM(loc_oBO.this_cDPro2s)
1913:             loc_oPgDados.txt_4c_Cbar.Value     = ALLTRIM(loc_oBO.this_cCbars)
1914:             loc_oPgDados.txt_4c_EAN13.Value    = ALLTRIM(loc_oBO.this_cCbars)  && EAN13 = Cbars
1915:             loc_oPgDados.txt_4c_CProEq.Value   = ALLTRIM(loc_oBO.this_cCProEqs)
1916:             loc_oPgDados.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
1917:             loc_oPgDados.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdeCPros)
1918:             loc_oPgDados.txt_4c_Refs.Value     = ALLTRIM(loc_oBO.this_cReffs)
1919: 
1920:             *-- === Grupo / SubGrupo ===
1921:             loc_oPgDados.txt_4c_Cgru.Value  = ALLTRIM(loc_oBO.this_cCgrus)
1922:             loc_oPgDados.txt_4c_CSGru.Value = ALLTRIM(loc_oBO.this_cSGrus)
1923: 
1924:             *-- Descricoes de grupo e subgrupo (lookup)
1925:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI
1926:                 IF !EMPTY(loc_oBO.this_cCgrus)
1927:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1928:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1929:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cCgrus), 10)), ;
1930:                         "cursor_4c_BODGru")
1931:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODGru") > 0
1932:                         SELECT cursor_4c_BODGru
1933:                         loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
1934:                     ENDIF
1935:                     IF USED("cursor_4c_BODGru")
1936:                         USE IN cursor_4c_BODGru
1937:                     ENDIF
1938:                 ELSE
1939:                     loc_oPgDados.txt_4c_Dgru.Value = ""
1940:                 ENDIF
1941:                 IF !EMPTY(loc_oBO.this_cSGrus)
1942:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1943:                         "SELECT Descricaos AS DSGrus FROM SigCdPsg WHERE Codigos = " + ;

*-- Linhas 2078 a 2186:
2078:             loc_oPgDados.chk_4c_Consig.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nConsigs) = "L", loc_oBO.this_nConsigs, (NVL(loc_oBO.this_nConsigs, 0) = 1)), 1, 0)
2079:             loc_oPgDados.chk_4c_FabrProprs.Value = IIF(IIF(VARTYPE(loc_oBO.this_nFabrProprs) = "L", loc_oBO.this_nFabrProprs, (NVL(loc_oBO.this_nFabrProprs, 0) = 1)), 1, 0)
2080:             loc_oPgDados.chk_4c_Encoms.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nEncoms) = "L", loc_oBO.this_nEncoms, (NVL(loc_oBO.this_nEncoms, 0) = 1)), 1, 0)
2081: 
2082:             *-- === OptionGroups ===
2083:             loc_oPgDados.opt_4c_SituacaoPro.Value = IIF(IIF(VARTYPE(loc_oBO.this_nInstalas) = "L", loc_oBO.this_nInstalas, (NVL(loc_oBO.this_nInstalas, 0) = 1)), 1, 2)
2084:             loc_oPgDados.opt_4c_ProdWeb.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nProdWebs) = "L", loc_oBO.this_nProdWebs, (NVL(loc_oBO.this_nProdWebs, 0) = 1)), 1, 2)
2085:             loc_oPgDados.opt_4c_OpcVar.Value      = IIF(IIF(VARTYPE(loc_oBO.this_nOpcVars) = "L", loc_oBO.this_nOpcVars, (NVL(loc_oBO.this_nOpcVars, 0) = 1)), 1, 2)
2086: 
2087:             *-- === Auditoria (somente leitura) ===
2088:             loc_oPgDados.txt_4c_DtIncs.Value      = loc_oBO.this_dDtIncs
2089:             loc_oPgDados.txt_4c_DataAlts.Value     = loc_oBO.this_dDataAlts
2090:             loc_oPgDados.txt_4c_Usuario.Value      = ALLTRIM(loc_oBO.this_cUsuaIncs)
2091:             loc_oPgDados.txt_4c_UsuaAlts.Value     = ALLTRIM(loc_oBO.this_cUsuaAlts)
2092:             loc_oPgDados.txt_4c_DtSituas.Value     = loc_oBO.this_dDtSituas
2093:             loc_oPgDados.txt_4c_Estoques.Value     = loc_oBO.this_nEstoques
2094:             loc_oPgDados.txt_4c_QtdEsts.Value      = loc_oBO.this_nQtdEsts
2095:             loc_oPgDados.txt_4c_Dtucp.Value        = loc_oBO.this_dDtucps
2096:             loc_oPgDados.txt_4c_Vucp.Value         = loc_oBO.this_nVucps
2097:             loc_oPgDados.txt_4c_Mucp.Value         = ALLTRIM(loc_oBO.this_cMucps)
2098:             loc_oPgDados.txt_4c_QtdUltComp.Value   = loc_oBO.this_nQtdUltComps
2099: 
2100:             *-- Preencher campos da pagina FaseP (Page4)
2101:             THIS.BOParaFormFaseP()
2102: 
2103:         CATCH TO loc_oErro
2104:             MsgErro(loc_oErro.Message, "Erro ao preencher campos do formulario")
2105:         ENDTRY
2106:     ENDPROC
2107: 
2108:     *--------------------------------------------------------------------------
2109:     * CarregarDescricaoLookup - Auxiliar: busca descricao de um lookup simples
2110:     *--------------------------------------------------------------------------
2111:     PROTECTED PROCEDURE CarregarDescricaoLookup(par_cTabela, par_cCampoPK, par_cCampoDes, ;
2112:                                                  par_cCodigo,  par_oTextBox)
2113:         LOCAL loc_nRet, loc_cAlias, loc_lContinuar, loc_oErro
2114:         TRY
2115:             loc_lContinuar = !EMPTY(par_cCodigo)
2116:             IF !loc_lContinuar
2117:                 par_oTextBox.Value = ""
2118:             ENDIF
2119:             IF loc_lContinuar
2120:                 loc_cAlias = "cursor_4c_Lookup_" + par_cTabela
2121:                 IF USED(loc_cAlias)
2122:                     USE IN (loc_cAlias)
2123:                 ENDIF
2124:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2125:                     "SELECT " + par_cCampoDes + " FROM " + par_cTabela + ;
2126:                     " WHERE " + par_cCampoPK + " = " + EscaparSQL(par_cCodigo), ;
2127:                     loc_cAlias)
2128:                 IF loc_nRet > 0 AND RECCOUNT(loc_cAlias) > 0
2129:                     SELECT (loc_cAlias)
2130:                     par_oTextBox.Value = ALLTRIM(&par_cCampoDes)
2131:                 ELSE
2132:                     par_oTextBox.Value = ""
2133:                 ENDIF
2134:                 IF USED(loc_cAlias)
2135:                     USE IN (loc_cAlias)
2136:                 ENDIF
2137:             ENDIF
2138:         CATCH TO loc_oErro
2139:             *-- Tolerado: lookup nao critico
2140:         ENDTRY
2141:     ENDPROC
2142: 
2143:     *--------------------------------------------------------------------------
2144:     * FormParaBO - Le campos do form e envia para o BO (COMPLETO)
2145:     *--------------------------------------------------------------------------
2146:     PROTECTED PROCEDURE FormParaBO()
2147:         LOCAL loc_oPgDados, loc_oBO, loc_oErro
2148:         TRY
2149:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
2150:             loc_oBO      = this_oBusinessObject
2151: 
2152:             *-- === Identificacao ===
2153:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPgDados.txt_4c_Cpro.Value)
2154:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPgDados.txt_4c_Dpro.Value)
2155:             loc_oBO.this_cDPro2s   = ALLTRIM(loc_oPgDados.txt_4c_DPro2s.Value)
2156:             loc_oBO.this_cCbars    = ALLTRIM(loc_oPgDados.txt_4c_Cbar.Value)
2157:             loc_oBO.this_cCProEqs  = ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value)
2158:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPgDados.txt_4c_Merc.Value)
2159:             loc_oBO.this_cIdeCPros = ALLTRIM(loc_oPgDados.txt_4c_IdeCPros.Value)
2160:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPgDados.txt_4c_Refs.Value)
2161: 
2162:             *-- === Grupo / SubGrupo ===
2163:             loc_oBO.this_cCgrus = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
2164:             loc_oBO.this_cSGrus = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
2165: 
2166:             *-- === Linha / Colecao ===
2167:             loc_oBO.this_cLins = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
2168:             loc_oBO.this_cCols = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
2169: 
2170:             *-- === Fornecedor ===
2171:             loc_oBO.this_cIFors = ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value)
2172: 
2173:             *-- === Quantidades / Lote ===
2174:             loc_oBO.this_nQmins     = STR(loc_oPgDados.txt_4c_Qmin.Value)
2175:             loc_oBO.this_nLtMinsVs  = STR(loc_oPgDados.txt_4c_LtMinsV.Value)
2176:             loc_oBO.this_nConjuntos = STR(loc_oPgDados.txt_4c_Conjunto.Value)
2177:             loc_oBO.this_nQtPeds    = STR(loc_oPgDados.txt_4c_QtPed.Value)
2178:             loc_oBO.this_nDiasGars  = STR(loc_oPgDados.txt_4c_DiasGar.Value)
2179: 
2180:             *-- === Dimensoes ===
2181:             loc_oBO.this_nAlturas     = STR(loc_oPgDados.txt_4c_Altura.Value)
2182:             loc_oBO.this_nLarguras    = STR(loc_oPgDados.txt_4c_Largura.Value)
2183:             loc_oBO.this_nDiametros   = STR(loc_oPgDados.txt_4c_Diametro.Value)
2184:             loc_oBO.this_nEspessuras  = STR(loc_oPgDados.txt_4c_Espessura.Value)
2185:             loc_oBO.this_nCompriments = STR(loc_oPgDados.txt_4c_Compriment.Value)
2186:             loc_oBO.this_nPesoBs      = STR(loc_oPgDados.txt_4c_PesoBs.Value)

*-- Linhas 2223 a 2412:
2223:             loc_oBO.this_nConsigs    = IIF(loc_oPgDados.chk_4c_Consig.Value    = 1, 1, 0)
2224:             loc_oBO.this_nFabrProprs = IIF(loc_oPgDados.chk_4c_FabrProprs.Value = 1, 1, 0)
2225:             loc_oBO.this_nEncoms     = IIF(loc_oPgDados.chk_4c_Encoms.Value    = 1, 1, 0)
2226: 
2227:             *-- === OptionGroups ===
2228:             loc_oBO.this_nInstalas = IIF(loc_oPgDados.opt_4c_SituacaoPro.Value = 1, 1, 0)
2229:             loc_oBO.this_nProdWebs = IIF(loc_oPgDados.opt_4c_ProdWeb.Value     = 1, 1, 0)
2230:             loc_oBO.this_nOpcVars  = IIF(loc_oPgDados.opt_4c_OpcVar.Value      = 1, 1, 0)
2231: 
2232:             *-- Ler campos da pagina FaseP (Page4)
2233:             THIS.FormParaBOFaseP()
2234: 
2235:         CATCH TO loc_oErro
2236:             MsgErro(loc_oErro.Message, "Erro ao ler campos do formulario")
2237:         ENDTRY
2238:     ENDPROC
2239: 
2240:     *--------------------------------------------------------------------------
2241:     * NavegacaoDadosChange - Muda pagina do inner PageFrame via OptionGroup
2242:     *--------------------------------------------------------------------------
2243:     PROCEDURE NavegacaoDadosChange()
2244:         LOCAL loc_nPagina, loc_oErro
2245:         TRY
2246:             loc_nPagina = THIS.pgf_4c_Paginas.Page2.obj_4c_Optiongroup1.Value
2247:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.ActivePage = loc_nPagina
2248:             IF loc_nPagina = 2
2249:                 THIS.CarregarComposicao()
2250:             ENDIF
2251:             IF loc_nPagina = 4
2252:                 THIS.CarregarFaseP()
2253:                 THIS.CarregarMatrizes()
2254:             ENDIF
2255:             IF loc_nPagina = 5
2256:                 THIS.CarregarConsP()
2257:             ENDIF
2258:             IF loc_nPagina = 7
2259:                 THIS.CarregarDesigner()
2260:             ENDIF
2261:         CATCH TO loc_oErro
2262:             MsgErro(loc_oErro.Message, "Erro ao navegar entre p" + CHR(225) + "ginas")
2263:         ENDTRY
2264:     ENDPROC
2265: 
2266:     *==========================================================================
2267:     * ConfigurarPaginaDados - Cria inner PageFrame (pgframeDados) e navegacao
2268:     * Ambos diretamente em Page2 do outer PageFrame -> compensar +29
2269:     *==========================================================================
2270:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPage)
2271:         LOCAL loc_oPgfInner, loc_oErro
2272:         TRY
2273:             *-- OptionGroup de navegacao (Optiongroup1 no legado)
2274:             *-- top=5+29=34, left=5, width=535, height=85
2275:             par_oPage.AddObject("obj_4c_Optiongroup1", "OptionGroup")
2276:             WITH par_oPage.obj_4c_Optiongroup1
2277:                 .Top         = 34
2278:                 .Left        = 5
2279:                 .Width       = 535
2280:                 .Height      = 85
2281:                 .ButtonCount = 7
2282:                 .Value       = 1
2283:                 .Themes      = .F.
2284:                 .Visible     = .T.
2285:             ENDWITH
2286: 
2287:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(1)
2288:                 .Caption   = "Dados"
2289:                 .Top       = 0
2290:                 .Left      = 0
2291:                 .Width     = 75
2292:                 .Height    = 80
2293:                 .FontName  = "Comic Sans MS"
2294:                 .FontBold  = .T.
2295:                 .FontSize  = 8
2296:                 .ForeColor = RGB(90,90,90)
2297:                 .BackColor = RGB(255,255,255)
2298:                 .Themes    = .F.
2299:                 .Value     = 1
2300:             ENDWITH
2301: 
2302:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(2)
2303:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
2304:                 .Top       = 0
2305:                 .Left      = 76
2306:                 .Width     = 75
2307:                 .Height    = 80
2308:                 .FontName  = "Comic Sans MS"
2309:                 .FontBold  = .T.
2310:                 .FontSize  = 8
2311:                 .ForeColor = RGB(90,90,90)
2312:                 .BackColor = RGB(255,255,255)
2313:                 .Themes    = .F.
2314:             ENDWITH
2315: 
2316:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(3)
2317:                 .Caption   = "Fiscal"
2318:                 .Top       = 0
2319:                 .Left      = 152
2320:                 .Width     = 75
2321:                 .Height    = 80
2322:                 .FontName  = "Comic Sans MS"
2323:                 .FontBold  = .T.
2324:                 .FontSize  = 8
2325:                 .ForeColor = RGB(90,90,90)
2326:                 .BackColor = RGB(255,255,255)
2327:                 .Themes    = .F.
2328:             ENDWITH
2329: 
2330:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(4)
2331:                 .Caption   = "Fase P"
2332:                 .Top       = 0
2333:                 .Left      = 228
2334:                 .Width     = 75
2335:                 .Height    = 80
2336:                 .FontName  = "Comic Sans MS"
2337:                 .FontBold  = .T.
2338:                 .FontSize  = 8
2339:                 .ForeColor = RGB(90,90,90)
2340:                 .BackColor = RGB(255,255,255)
2341:                 .Themes    = .F.
2342:             ENDWITH
2343: 
2344:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(5)
2345:                 .Caption   = "Cons P"
2346:                 .Top       = 0
2347:                 .Left      = 304
2348:                 .Width     = 75
2349:                 .Height    = 80
2350:                 .FontName  = "Comic Sans MS"
2351:                 .FontBold  = .T.
2352:                 .FontSize  = 8
2353:                 .ForeColor = RGB(90,90,90)
2354:                 .BackColor = RGB(255,255,255)
2355:                 .Themes    = .F.
2356:             ENDWITH
2357: 
2358:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(6)
2359:                 .Caption   = "Custo"
2360:                 .Top       = 0
2361:                 .Left      = 380
2362:                 .Width     = 75
2363:                 .Height    = 80
2364:                 .FontName  = "Comic Sans MS"
2365:                 .FontBold  = .T.
2366:                 .FontSize  = 8
2367:                 .ForeColor = RGB(90,90,90)
2368:                 .BackColor = RGB(255,255,255)
2369:                 .Themes    = .F.
2370:             ENDWITH
2371: 
2372:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(7)
2373:                 .Caption   = "Designer"
2374:                 .Top       = 0
2375:                 .Left      = 456
2376:                 .Width     = 75
2377:                 .Height    = 80
2378:                 .FontName  = "Comic Sans MS"
2379:                 .FontBold  = .T.
2380:                 .FontSize  = 8
2381:                 .ForeColor = RGB(90,90,90)
2382:                 .BackColor = RGB(255,255,255)
2383:                 .Themes    = .F.
2384:             ENDWITH
2385: 
2386:             *-- Inner PageFrame (pgframeDados no legado)
2387:             *-- top=-54+29=-25, left=-1 (diretamente em Page2 -> compensar +29)
2388:             par_oPage.AddObject("pgf_4c_DadosInterno", "PageFrame")
2389:             loc_oPgfInner = par_oPage.pgf_4c_DadosInterno
2390:             WITH loc_oPgfInner
2391:                 .Top       = -25
2392:                 .Left      = -1
2393:                 .Width     = 1003
2394:                 .Height    = 656
2395:                 .PageCount = 7
2396:                 .Tabs      = .F.
2397:                 .Themes    = .F.
2398:                 .Visible   = .T.
2399:             ENDWITH
2400: 
2401:             loc_oPgfInner.Page1.Caption = "Dados"
2402:             loc_oPgfInner.Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2403:             loc_oPgfInner.Page3.Caption = "Fiscal"
2404:             loc_oPgfInner.Page4.Caption = "Fase P"
2405:             loc_oPgfInner.Page5.Caption = "Cons P"
2406:             loc_oPgfInner.Page6.Caption = "Custo"
2407:             loc_oPgfInner.Page7.Caption = "Designer"
2408: 
2409:             *-- Configurar primeira pagina interna (pgDados - ambas as partes)
2410:             THIS.ConfigurarPgDados1(loc_oPgfInner.Page1)
2411:             THIS.ConfigurarPgDados2(loc_oPgfInner.Page1)
2412: 

*-- Linhas 2437 a 2484:
2437:     * ConfigurarPgDados1 - Campos de pgDados (primeira metade: top <= 301)
2438:     * Posicoes: original_top + 29 (inner PageFrame esta em Page2 outer -> +29)
2439:     *==========================================================================
2440:     PROTECTED PROCEDURE ConfigurarPgDados1(par_oPage)
2441:         TRY
2442:             *-- OptionGroup situacao (opc_situacao no legado)
2443:             *-- top=130+29=159, left=735, width=142, height=25
2444:             par_oPage.AddObject("opt_4c_SituacaoPro", "OptionGroup")
2445:             WITH par_oPage.opt_4c_SituacaoPro
2446:                 .Top         = 159
2447:                 .Left        = 735
2448:                 .Width       = 142
2449:                 .Height      = 25
2450:                 .ButtonCount = 2
2451:                 .Value       = 1
2452:                 .Themes      = .F.
2453:                 .Visible     = .T.
2454:             ENDWITH
2455:             WITH par_oPage.opt_4c_SituacaoPro.Buttons(1)
2456:                 .Caption  = "Ativo"
2457:                 .Top      = 0
2458:                 .Left     = 0
2459:                 .Width    = 68
2460:                 .Height   = 22
2461:                 .FontName = "Tahoma"
2462:                 .FontSize = 8
2463:                 .Themes   = .F.
2464:                 .Value    = 1
2465:             ENDWITH
2466:             WITH par_oPage.opt_4c_SituacaoPro.Buttons(2)
2467:                 .Caption  = "Inativo"
2468:                 .Top      = 0
2469:                 .Left     = 70
2470:                 .Width    = 68
2471:                 .Height   = 22
2472:                 .FontName = "Tahoma"
2473:                 .FontSize = 8
2474:                 .Themes   = .F.
2475:             ENDWITH
2476: 
2477:             *-- Label "Produto :" (Label2, top=134+29=163)
2478:             par_oPage.AddObject("lbl_4c_LbCpro", "Label")
2479:             WITH par_oPage.lbl_4c_LbCpro
2480:                 .Top       = 163
2481:                 .Left      = 58
2482:                 .Width     = 53
2483:                 .Height    = 15
2484:                 .FontName  = "Tahoma"

*-- Linhas 2944 a 2987:
2944:     * ConfigurarPgDados2 - Campos de pgDados (segunda metade: controles restantes)
2945:     * Posicoes: original_top + 29 (compensacao inner PageFrame em Page2 outer)
2946:     *==========================================================================
2947:     PROTECTED PROCEDURE ConfigurarPgDados2(par_oPage)
2948:         LOCAL loc_oErro
2949:         TRY
2950:             *-- cmd_4c_Produto (cmdProduto, top=33+29=62, left=623, w=85, h=85)
2951:             par_oPage.AddObject("cmd_4c_Produto", "CommandButton")
2952:             WITH par_oPage.cmd_4c_Produto
2953:                 .Top = 62
2954:                 .Left = 623
2955:                 .Width = 85
2956:                 .Height = 85
2957:                 .Caption = "Produto"
2958:                 .FontName = "Tahoma"
2959:                 .FontSize = 8
2960:                 .Themes = .F.
2961:                 .Visible = .T.
2962:             ENDWITH
2963: 
2964:             *-- cmd_4c_Arquivos (cmdArquivos, top=33+29=62, left=698, w=85, h=85)
2965:             par_oPage.AddObject("cmd_4c_Arquivos", "CommandButton")
2966:             WITH par_oPage.cmd_4c_Arquivos
2967:                 .Top = 62
2968:                 .Left = 698
2969:                 .Width = 85
2970:                 .Height = 85
2971:                 .Caption = "Arquivos"
2972:                 .FontName = "Tahoma"
2973:                 .FontSize = 8
2974:                 .Themes = .F.
2975:                 .Visible = .T.
2976:             ENDWITH
2977: 
2978:             *-- txt_4c_DtSituas (getDtSituas, data situacao, top=132+29=161) readonly
2979:             par_oPage.AddObject("txt_4c_DtSituas", "TextBox")
2980:             WITH par_oPage.txt_4c_DtSituas
2981:                 .Top = 161
2982:                 .Left = 878
2983:                 .Width = 80
2984:                 .Height = 21
2985:                 .FontName = "Tahoma"
2986:                 .FontSize = 8
2987:                 .ReadOnly = .T.

*-- Linhas 3028 a 3074:
3028:                 .BackStyle = 0
3029:                 .Caption = "Lote M" + CHR(237) + "nimo :"
3030:                 .Visible = .T.
3031:             ENDWITH
3032: 
3033:             *-- opt_4c_ProdWeb (Fwoption1, produto web, top=172+29=201, left=879, w=117, h=42)
3034:             par_oPage.AddObject("opt_4c_ProdWeb", "OptionGroup")
3035:             WITH par_oPage.opt_4c_ProdWeb
3036:                 .Top = 201
3037:                 .Left = 879
3038:                 .Width = 117
3039:                 .Height = 42
3040:                 .ButtonCount = 2
3041:                 .Value = 1
3042:                 .Themes = .F.
3043:                 .Visible = .T.
3044:             ENDWITH
3045:             WITH par_oPage.opt_4c_ProdWeb.Buttons(1)
3046:                 .Caption = "Sim"
3047:                 .Top = 0
3048:                 .Left = 0
3049:                 .Width = 55
3050:                 .Height = 20
3051:                 .FontName = "Tahoma"
3052:                 .FontSize = 8
3053:                 .Themes = .F.
3054:                 .Value = 1
3055:             ENDWITH
3056:             WITH par_oPage.opt_4c_ProdWeb.Buttons(2)
3057:                 .Caption = "N" + CHR(227) + "o"
3058:                 .Top = 0
3059:                 .Left = 57
3060:                 .Width = 55
3061:                 .Height = 20
3062:                 .FontName = "Tahoma"
3063:                 .FontSize = 8
3064:                 .Themes = .F.
3065:             ENDWITH
3066: 
3067:             *-- Label "Produto Web :" (Say29, top=176+29=205)
3068:             par_oPage.AddObject("lbl_4c_LbProdWeb", "Label")
3069:             WITH par_oPage.lbl_4c_LbProdWeb
3070:                 .Top = 205
3071:                 .Left = 805
3072:                 .Width = 72
3073:                 .Height = 15
3074:                 .FontName = "Tahoma"

*-- Linhas 3146 a 3192:
3146:                 .MaxLength = 14
3147:                 .Themes = .F.
3148:                 .Visible = .T.
3149:             ENDWITH
3150: 
3151:             *-- opt_4c_OpcVar (Fwoption2, top=203+29=232, left=874, w=107, h=22)
3152:             par_oPage.AddObject("opt_4c_OpcVar", "OptionGroup")
3153:             WITH par_oPage.opt_4c_OpcVar
3154:                 .Top = 232
3155:                 .Left = 874
3156:                 .Width = 107
3157:                 .Height = 22
3158:                 .ButtonCount = 2
3159:                 .Value = 1
3160:                 .Themes = .F.
3161:                 .Visible = .T.
3162:             ENDWITH
3163:             WITH par_oPage.opt_4c_OpcVar.Buttons(1)
3164:                 .Caption = "Sim"
3165:                 .Top = 0
3166:                 .Left = 0
3167:                 .Width = 50
3168:                 .Height = 20
3169:                 .FontName = "Tahoma"
3170:                 .FontSize = 8
3171:                 .Themes = .F.
3172:                 .Value = 1
3173:             ENDWITH
3174:             WITH par_oPage.opt_4c_OpcVar.Buttons(2)
3175:                 .Caption = "N" + CHR(227) + "o"
3176:                 .Top = 0
3177:                 .Left = 52
3178:                 .Width = 50
3179:                 .Height = 20
3180:                 .FontName = "Tahoma"
3181:                 .FontSize = 8
3182:                 .Themes = .F.
3183:             ENDWITH
3184: 
3185:             *-- Label "Conjunto :" (Say37, top=206+29=235, left=408)
3186:             par_oPage.AddObject("lbl_4c_LbConjunto", "Label")
3187:             WITH par_oPage.lbl_4c_LbConjunto
3188:                 .Top = 235
3189:                 .Left = 408
3190:                 .Width = 53
3191:                 .Height = 15
3192:                 .FontName = "Tahoma"

*-- Linhas 4764 a 5946:
4764:         ENDTRY
4765:     ENDPROC
4766: 
4767:     PROTECTED PROCEDURE ValidarGrupoFiltro()
4768:         LOCAL loc_cCodGrupo, loc_nRet, loc_oPage1, loc_oErro
4769:         TRY
4770:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4771:                 RETURN
4772:             ENDIF
4773:             loc_oPage1    = THIS.pgf_4c_Paginas.Page1
4774:             loc_cCodGrupo = ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value)
4775:             IF EMPTY(loc_cCodGrupo)
4776:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4777:                 RETURN
4778:             ENDIF
4779:             loc_nRet = SQLEXEC(gnConnHandle, ;
4780:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4781:                 EscaparSQL(PADR(loc_cCodGrupo, 10)), ;
4782:                 "cursor_4c_BuscaGrp")
4783:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaGrp") > 0
4784:                 SELECT cursor_4c_BuscaGrp
4785:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ALLTRIM(DGrus)
4786:             ELSE
4787:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4788:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = ""
4789:             ENDIF
4790:             IF USED("cursor_4c_BuscaGrp")
4791:                 USE IN cursor_4c_BuscaGrp
4792:             ENDIF
4793:             THIS.CarregarLista()
4794:         CATCH TO loc_oErro
4795:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4796:         ENDTRY
4797:     ENDPROC
4798: 
4799:     *-- AbrirLookupGrupo: lookup para o FILTRO da Page1 (txt_4c_CodGrupo)
4800:     PROTECTED PROCEDURE AbrirLookupGrupo()
4801:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPage1, loc_oErro
4802:         TRY
4803:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4804:                 RETURN
4805:             ENDIF
4806:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
4807:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
4808:                 "cursor_4c_BuscaGrpFlt", "CGrus", ;
4809:                 ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value), ;
4810:                 "Grupo de Produto")
4811:             loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
4812:             loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4813:             loc_oBusca.Show()
4814:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFlt")
4815:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrpFlt.CGrus)
4816:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrpFlt.DGrus)
4817:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = loc_cCodigo
4818:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = loc_cDescricao
4819:             ENDIF
4820:             IF USED("cursor_4c_BuscaGrpFlt")
4821:                 USE IN cursor_4c_BuscaGrpFlt
4822:             ENDIF
4823:             loc_oBusca.Release()
4824:         CATCH TO loc_oErro
4825:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo (filtro)")
4826:         ENDTRY
4827:     ENDPROC
4828: 
4829:     *==========================================================================
4830:     * FASE 6: Lookup Handlers e Metodos AbrirLookup
4831:     * Todos os handlers sao PUBLIC (obrigatorio para BINDEVENT)
4832:     * Todos os AbrirLookup sao PROTECTED
4833:     *==========================================================================
4834: 
4835:     *-- Produto Equivalente (SigCdPro: CPros / DPros)
4836:     PROCEDURE CProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4837:         TRY
4838:             IF par_nKeyCode = 115
4839:                 THIS.AbrirLookupCProEq()
4840:             ENDIF
4841:         CATCH TO loc_oErro
4842:             *-- Tolerado
4843:         ENDTRY
4844:     ENDPROC
4845: 
4846:     PROCEDURE CProEqDblClick()
4847:         THIS.AbrirLookupCProEq()
4848:     ENDPROC
4849: 
4850:     PROTECTED PROCEDURE AbrirLookupCProEq()
4851:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
4852:         TRY
4853:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4854:                 RETURN
4855:             ENDIF
4856:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4857:             IF !loc_oPgDados.txt_4c_CProEq.Enabled
4858:                 RETURN
4859:             ENDIF
4860:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
4861:                 "cursor_4c_BuscaCProEq", "CPros", ;
4862:                 ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value), ;
4863:                 "Produto Equivalente")
4864:             loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
4865:             loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
4866:             loc_oBusca.Show()
4867:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCProEq")
4868:                 loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaCProEq.CPros)
4869:             ENDIF
4870:             IF USED("cursor_4c_BuscaCProEq")
4871:                 USE IN cursor_4c_BuscaCProEq
4872:             ENDIF
4873:             loc_oBusca.Release()
4874:         CATCH TO loc_oErro
4875:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup produto equivalente")
4876:         ENDTRY
4877:     ENDPROC
4878: 
4879:     *-- Grupo Produto (SigCdGrp: CGrus / DGrus)
4880:     PROCEDURE CgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4881:         TRY
4882:             IF par_nKeyCode = 115
4883:                 THIS.AbrirLookupCgru()
4884:             ELSE
4885:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
4886:                 THIS.ValidarCgruDados()
4887:                 ENDIF
4888:             ENDIF
4889:         CATCH TO loc_oErro
4890:             *-- Tolerado
4891:         ENDTRY
4892:     ENDPROC
4893: 
4894:     PROCEDURE CgruDblClick()
4895:         THIS.AbrirLookupCgru()
4896:     ENDPROC
4897: 
4898:     PROTECTED PROCEDURE AbrirLookupCgru()
4899:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
4900:         TRY
4901:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4902:                 RETURN
4903:             ENDIF
4904:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4905:             IF !loc_oPgDados.txt_4c_Cgru.Enabled
4906:                 RETURN
4907:             ENDIF
4908:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
4909:                 "cursor_4c_BuscaCgru", "CGrus", ;
4910:                 ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value), ;
4911:                 "Grupo de Produto")
4912:             loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
4913:             loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4914:             loc_oBusca.Show()
4915:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
4916:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
4917:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
4918:                 loc_oPgDados.txt_4c_Cgru.Value = loc_cCodigo
4919:                 loc_oPgDados.txt_4c_Dgru.Value = loc_cDescricao
4920:             ENDIF
4921:             IF USED("cursor_4c_BuscaCgru")
4922:                 USE IN cursor_4c_BuscaCgru
4923:             ENDIF
4924:             loc_oBusca.Release()
4925:         CATCH TO loc_oErro
4926:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo de produto")
4927:         ENDTRY
4928:     ENDPROC
4929: 
4930:     PROTECTED PROCEDURE ValidarCgruDados()
4931:         LOCAL loc_oPgDados, loc_cCodGru, loc_nRet, loc_oErro
4932:         TRY
4933:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4934:                 RETURN
4935:             ENDIF
4936:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4937:             loc_cCodGru  = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
4938:             IF EMPTY(loc_cCodGru)
4939:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4940:                 RETURN
4941:             ENDIF
4942:             loc_nRet = SQLEXEC(gnConnHandle, ;
4943:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4944:                 EscaparSQL(PADR(loc_cCodGru, 10)), ;
4945:                 "cursor_4c_ValGru")
4946:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValGru") > 0
4947:                 SELECT cursor_4c_ValGru
4948:                 loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
4949:             ELSE
4950:                 loc_oPgDados.txt_4c_Cgru.Value = ""
4951:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4952:             ENDIF
4953:             IF USED("cursor_4c_ValGru")
4954:                 USE IN cursor_4c_ValGru
4955:             ENDIF
4956:             THIS.CarregarLista()
4957:         CATCH TO loc_oErro
4958:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4959:         ENDTRY
4960:     ENDPROC
4961: 
4962:     *-- SubGrupo (SigCdPsg: Codigos / Descricaos, filtrado por CGrus)
4963:     PROCEDURE CSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4964:         TRY
4965:             IF par_nKeyCode = 115
4966:                 THIS.AbrirLookupCSGru()
4967:             ELSE
4968:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
4969:                 THIS.ValidarCSGruDados()
4970:                 ENDIF
4971:             ENDIF
4972:         CATCH TO loc_oErro
4973:             *-- Tolerado
4974:         ENDTRY
4975:     ENDPROC
4976: 
4977:     PROCEDURE CSGruDblClick()
4978:         THIS.AbrirLookupCSGru()
4979:     ENDPROC
4980: 
4981:     PROTECTED PROCEDURE AbrirLookupCSGru()
4982:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao
4983:         LOCAL loc_cCodGru, loc_cSQL, loc_nRet, loc_oErro
4984:         TRY
4985:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4986:                 RETURN
4987:             ENDIF
4988:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4989:             IF !loc_oPgDados.txt_4c_CSGru.Enabled
4990:                 RETURN
4991:             ENDIF
4992:             *-- Montar cursor filtrado por grupo (como no legado)
4993:             loc_cCodGru = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
4994:             IF USED("cursor_4c_BuscaCSGru")
4995:                 USE IN cursor_4c_BuscaCSGru
4996:             ENDIF
4997:             IF EMPTY(loc_cCodGru)
4998:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos"
4999:             ELSE
5000:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg " + ;
5001:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
5002:                            " ORDER BY Codigos"
5003:             ENDIF
5004:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCSGru")
5005:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_BuscaCSGru") = 0
5006:                 IF USED("cursor_4c_BuscaCSGru")
5007:                     USE IN cursor_4c_BuscaCSGru
5008:                 ENDIF
5009:                 *-- Sem filtro de grupo
5010:                 loc_nRet = SQLEXEC(gnConnHandle, ;
5011:                     "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
5012:                     "cursor_4c_BuscaCSGru")
5013:             ENDIF
5014:             IF loc_nRet < 1
5015:                 MsgErro("Erro ao carregar subgrupos.", "Erro")
5016:                 RETURN
5017:             ENDIF
5018:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPsg", ;
5019:                 "cursor_4c_BuscaCSGru2", "Codigos", ;
5020:                 ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value), ;
5021:                 "Subgrupo")
5022:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
5023:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
5024:             loc_oBusca.Show()
5025:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCSGru2")
5026:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCSGru2.Codigos)
5027:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCSGru2.Descricaos)
5028:                 loc_oPgDados.txt_4c_CSGru.Value = loc_cCodigo
5029:                 loc_oPgDados.txt_4c_DsGru.Value = loc_cDescricao
5030:             ENDIF
5031:             IF USED("cursor_4c_BuscaCSGru")
5032:                 USE IN cursor_4c_BuscaCSGru
5033:             ENDIF
5034:             IF USED("cursor_4c_BuscaCSGru2")
5035:                 USE IN cursor_4c_BuscaCSGru2
5036:             ENDIF
5037:             loc_oBusca.Release()
5038:         CATCH TO loc_oErro
5039:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup subgrupo")
5040:         ENDTRY
5041:     ENDPROC
5042: 
5043:     PROTECTED PROCEDURE ValidarCSGruDados()
5044:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5045:         TRY
5046:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5047:                 RETURN
5048:             ENDIF
5049:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5050:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
5051:             IF EMPTY(loc_cCod)
5052:                 loc_oPgDados.txt_4c_DsGru.Value = ""
5053:                 RETURN
5054:             ENDIF
5055:             loc_nRet = SQLEXEC(gnConnHandle, ;
5056:                 "SELECT Descricaos FROM SigCdPsg WHERE Codigos = " + ;
5057:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5058:                 "cursor_4c_ValCSGru")
5059:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCSGru") > 0
5060:                 SELECT cursor_4c_ValCSGru
5061:                 loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(Descricaos)
5062:             ELSE
5063:                 loc_oPgDados.txt_4c_CSGru.Value = ""
5064:                 loc_oPgDados.txt_4c_DsGru.Value = ""
5065:             ENDIF
5066:             IF USED("cursor_4c_ValCSGru")
5067:                 USE IN cursor_4c_ValCSGru
5068:             ENDIF
5069:             THIS.CarregarLista()
5070:         CATCH TO loc_oErro
5071:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
5072:         ENDTRY
5073:     ENDPROC
5074: 
5075:     *-- Linha (SigCdLin: Linhas / Descs)
5076:     PROCEDURE LinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5077:         TRY
5078:             IF par_nKeyCode = 115
5079:                 THIS.AbrirLookupLin()
5080:             ELSE
5081:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5082:                 THIS.ValidarLinDados()
5083:                 ENDIF
5084:             ENDIF
5085:         CATCH TO loc_oErro
5086:             *-- Tolerado
5087:         ENDTRY
5088:     ENDPROC
5089: 
5090:     PROCEDURE LinDblClick()
5091:         THIS.AbrirLookupLin()
5092:     ENDPROC
5093: 
5094:     PROTECTED PROCEDURE AbrirLookupLin()
5095:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5096:         TRY
5097:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5098:                 RETURN
5099:             ENDIF
5100:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5101:             IF !loc_oPgDados.txt_4c_Lin.Enabled
5102:                 RETURN
5103:             ENDIF
5104:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", ;
5105:                 "cursor_4c_BuscaLin", "Linhas", ;
5106:                 ALLTRIM(loc_oPgDados.txt_4c_Lin.Value), ;
5107:                 "Linha")
5108:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
5109:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
5110:             loc_oBusca.Show()
5111:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
5112:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaLin.Linhas)
5113:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaLin.Descs)
5114:                 loc_oPgDados.txt_4c_Lin.Value  = loc_cCodigo
5115:                 loc_oPgDados.txt_4c_DLin.Value = loc_cDescricao
5116:             ENDIF
5117:             IF USED("cursor_4c_BuscaLin")
5118:                 USE IN cursor_4c_BuscaLin
5119:             ENDIF
5120:             loc_oBusca.Release()
5121:         CATCH TO loc_oErro
5122:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup linha")
5123:         ENDTRY
5124:     ENDPROC
5125: 
5126:     PROTECTED PROCEDURE ValidarLinDados()
5127:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5128:         TRY
5129:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5130:                 RETURN
5131:             ENDIF
5132:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5133:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
5134:             IF EMPTY(loc_cCod)
5135:                 loc_oPgDados.txt_4c_DLin.Value = ""
5136:                 RETURN
5137:             ENDIF
5138:             loc_nRet = SQLEXEC(gnConnHandle, ;
5139:                 "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
5140:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5141:                 "cursor_4c_ValLin")
5142:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValLin") > 0
5143:                 SELECT cursor_4c_ValLin
5144:                 loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(Descs)
5145:             ELSE
5146:                 loc_oPgDados.txt_4c_Lin.Value  = ""
5147:                 loc_oPgDados.txt_4c_DLin.Value = ""
5148:             ENDIF
5149:             IF USED("cursor_4c_ValLin")
5150:                 USE IN cursor_4c_ValLin
5151:             ENDIF
5152:             THIS.CarregarLista()
5153:         CATCH TO loc_oErro
5154:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
5155:         ENDTRY
5156:     ENDPROC
5157: 
5158:     *-- Colecao / Grupo de Venda (SigCdCol: Colecoes / Descs)
5159:     PROCEDURE ColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5160:         TRY
5161:             IF par_nKeyCode = 115
5162:                 THIS.AbrirLookupCol()
5163:             ELSE
5164:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5165:                 THIS.ValidarColDados()
5166:                 ENDIF
5167:             ENDIF
5168:         CATCH TO loc_oErro
5169:             *-- Tolerado
5170:         ENDTRY
5171:     ENDPROC
5172: 
5173:     PROCEDURE ColDblClick()
5174:         THIS.AbrirLookupCol()
5175:     ENDPROC
5176: 
5177:     PROTECTED PROCEDURE AbrirLookupCol()
5178:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5179:         TRY
5180:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5181:                 RETURN
5182:             ENDIF
5183:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5184:             IF !loc_oPgDados.txt_4c_Col.Enabled
5185:                 RETURN
5186:             ENDIF
5187:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
5188:                 "cursor_4c_BuscaCol", "Colecoes", ;
5189:                 ALLTRIM(loc_oPgDados.txt_4c_Col.Value), ;
5190:                 "Grupo de Venda")
5191:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
5192:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
5193:             loc_oBusca.Show()
5194:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5195:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
5196:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCol.Descs)
5197:                 loc_oPgDados.txt_4c_Col.Value  = loc_cCodigo
5198:                 loc_oPgDados.txt_4c_DCol.Value = loc_cDescricao
5199:             ENDIF
5200:             IF USED("cursor_4c_BuscaCol")
5201:                 USE IN cursor_4c_BuscaCol
5202:             ENDIF
5203:             loc_oBusca.Release()
5204:         CATCH TO loc_oErro
5205:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo de venda")
5206:         ENDTRY
5207:     ENDPROC
5208: 
5209:     PROTECTED PROCEDURE ValidarColDados()
5210:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5211:         TRY
5212:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5213:                 RETURN
5214:             ENDIF
5215:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5216:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
5217:             IF EMPTY(loc_cCod)
5218:                 loc_oPgDados.txt_4c_DCol.Value = ""
5219:                 RETURN
5220:             ENDIF
5221:             loc_nRet = SQLEXEC(gnConnHandle, ;
5222:                 "SELECT Descs FROM SigCdCol WHERE Colecoes = " + ;
5223:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5224:                 "cursor_4c_ValCol")
5225:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCol") > 0
5226:                 SELECT cursor_4c_ValCol
5227:                 loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(Descs)
5228:             ELSE
5229:                 loc_oPgDados.txt_4c_Col.Value  = ""
5230:                 loc_oPgDados.txt_4c_DCol.Value = ""
5231:             ENDIF
5232:             IF USED("cursor_4c_ValCol")
5233:                 USE IN cursor_4c_ValCol
5234:             ENDIF
5235:             THIS.CarregarLista()
5236:         CATCH TO loc_oErro
5237:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
5238:         ENDTRY
5239:     ENDPROC
5240: 
5241:     *-- Fornecedor (SigCdCli: IClis / RClis)
5242:     PROCEDURE IforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5243:         TRY
5244:             IF par_nKeyCode = 115
5245:                 THIS.AbrirLookupIfor()
5246:             ELSE
5247:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5248:                 THIS.ValidarIforDados()
5249:                 ENDIF
5250:             ENDIF
5251:         CATCH TO loc_oErro
5252:             *-- Tolerado
5253:         ENDTRY
5254:     ENDPROC
5255: 
5256:     PROCEDURE BtnFornecedorClick()
5257:         THIS.AbrirLookupIfor()
5258:     ENDPROC
5259: 
5260:     PROTECTED PROCEDURE AbrirLookupIfor()
5261:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5262:         TRY
5263:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5264:                 RETURN
5265:             ENDIF
5266:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5267:             IF !loc_oPgDados.txt_4c_Ifor.Enabled
5268:                 RETURN
5269:             ENDIF
5270:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
5271:                 "cursor_4c_BuscaIfor", "IClis", ;
5272:                 ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value), ;
5273:                 "Fornecedor")
5274:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
5275:             loc_oBusca.mAddColuna("RClis", "", "Nome")
5276:             loc_oBusca.Show()
5277:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5278:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaIfor.IClis)
5279:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaIfor.RClis)
5280:                 loc_oPgDados.txt_4c_Ifor.Value = loc_cCodigo
5281:                 loc_oPgDados.txt_4c_Dfor.Value = loc_cDescricao
5282:             ENDIF
5283:             IF USED("cursor_4c_BuscaIfor")
5284:                 USE IN cursor_4c_BuscaIfor
5285:             ENDIF
5286:             loc_oBusca.Release()
5287:         CATCH TO loc_oErro
5288:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup fornecedor")
5289:         ENDTRY
5290:     ENDPROC
5291: 
5292:     PROTECTED PROCEDURE ValidarIforDados()
5293:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5294:         TRY
5295:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5296:                 RETURN
5297:             ENDIF
5298:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5299:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value)
5300:             IF EMPTY(loc_cCod)
5301:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5302:                 RETURN
5303:             ENDIF
5304:             loc_nRet = SQLEXEC(gnConnHandle, ;
5305:                 "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5306:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5307:                 "cursor_4c_ValIfor")
5308:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValIfor") > 0
5309:                 SELECT cursor_4c_ValIfor
5310:                 loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(RClis)
5311:             ELSE
5312:                 loc_oPgDados.txt_4c_Ifor.Value = ""
5313:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5314:             ENDIF
5315:             IF USED("cursor_4c_ValIfor")
5316:                 USE IN cursor_4c_ValIfor
5317:             ENDIF
5318:             THIS.CarregarLista()
5319:         CATCH TO loc_oErro
5320:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5321:         ENDTRY
5322:     ENDPROC
5323: 
5324:     *-- Cor (SigCdCor: Cods / Descs)
5325:     PROCEDURE CorProKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5326:         TRY
5327:             IF par_nKeyCode = 115
5328:                 THIS.AbrirLookupCorPro()
5329:             ENDIF
5330:         CATCH TO loc_oErro
5331:             *-- Tolerado
5332:         ENDTRY
5333:     ENDPROC
5334: 
5335:     PROCEDURE CorProDblClick()
5336:         THIS.AbrirLookupCorPro()
5337:     ENDPROC
5338: 
5339:     PROTECTED PROCEDURE AbrirLookupCorPro()
5340:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
5341:         TRY
5342:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5343:                 RETURN
5344:             ENDIF
5345:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5346:             IF !loc_oPgDados.txt_4c_CorPro.Enabled
5347:                 RETURN
5348:             ENDIF
5349:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", ;
5350:                 "cursor_4c_BuscaCor", "Cods", ;
5351:                 ALLTRIM(loc_oPgDados.txt_4c_CorPro.Value), ;
5352:                 "Cor")
5353:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5354:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5355:             loc_oBusca.Show()
5356:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
5357:                 loc_oPgDados.txt_4c_CorPro.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
5358:             ENDIF
5359:             IF USED("cursor_4c_BuscaCor")
5360:                 USE IN cursor_4c_BuscaCor
5361:             ENDIF
5362:             loc_oBusca.Release()
5363:         CATCH TO loc_oErro
5364:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup cor")
5365:         ENDTRY
5366:     ENDPROC
5367: 
5368:     *-- Tamanho (SigCdTam: Cods / Descs)
5369:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5370:         TRY
5371:             IF par_nKeyCode = 115
5372:                 THIS.AbrirLookupTam()
5373:             ENDIF
5374:         CATCH TO loc_oErro
5375:             *-- Tolerado
5376:         ENDTRY
5377:     ENDPROC
5378: 
5379:     PROCEDURE TamDblClick()
5380:         THIS.AbrirLookupTam()
5381:     ENDPROC
5382: 
5383:     PROTECTED PROCEDURE AbrirLookupTam()
5384:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
5385:         TRY
5386:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5387:                 RETURN
5388:             ENDIF
5389:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5390:             IF !loc_oPgDados.txt_4c_Tam.Enabled
5391:                 RETURN
5392:             ENDIF
5393:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
5394:                 "cursor_4c_BuscaTam", "Cods", ;
5395:                 ALLTRIM(loc_oPgDados.txt_4c_Tam.Value), ;
5396:                 "Tamanho")
5397:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5398:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5399:             loc_oBusca.Show()
5400:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
5401:                 loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_BuscaTam.Cods)
5402:             ENDIF
5403:             IF USED("cursor_4c_BuscaTam")
5404:                 USE IN cursor_4c_BuscaTam
5405:             ENDIF
5406:             loc_oBusca.Release()
5407:         CATCH TO loc_oErro
5408:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup tamanho")
5409:         ENDTRY
5410:     ENDPROC
5411: 
5412:     *-- Finalidade (SigCdFip: Cods / Descs)
5413:     PROCEDURE CodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5414:         TRY
5415:             IF par_nKeyCode = 115
5416:                 THIS.AbrirLookupCodFinP()
5417:             ELSE
5418:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5419:                 THIS.ValidarCodFinPDados()
5420:                 ENDIF
5421:             ENDIF
5422:         CATCH TO loc_oErro
5423:             *-- Tolerado
5424:         ENDTRY
5425:     ENDPROC
5426: 
5427:     PROCEDURE CodFinPDblClick()
5428:         THIS.AbrirLookupCodFinP()
5429:     ENDPROC
5430: 
5431:     PROTECTED PROCEDURE AbrirLookupCodFinP()
5432:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5433:         TRY
5434:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5435:                 RETURN
5436:             ENDIF
5437:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5438:             IF !loc_oPgDados.txt_4c_CodFinP.Enabled
5439:                 RETURN
5440:             ENDIF
5441:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdFip", ;
5442:                 "cursor_4c_BuscaFinP", "Cods", ;
5443:                 ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value), ;
5444:                 "Finalidade")
5445:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5446:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5447:             loc_oBusca.Show()
5448:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
5449:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaFinP.Cods)
5450:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaFinP.Descs)
5451:                 loc_oPgDados.txt_4c_CodFinP.Value = loc_cCodigo
5452:                 loc_oPgDados.txt_4c_DesFinP.Value = loc_cDescricao
5453:             ENDIF
5454:             IF USED("cursor_4c_BuscaFinP")
5455:                 USE IN cursor_4c_BuscaFinP
5456:             ENDIF
5457:             loc_oBusca.Release()
5458:         CATCH TO loc_oErro
5459:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup finalidade")
5460:         ENDTRY
5461:     ENDPROC
5462: 
5463:     PROTECTED PROCEDURE ValidarCodFinPDados()
5464:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5465:         TRY
5466:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5467:                 RETURN
5468:             ENDIF
5469:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5470:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value)
5471:             IF EMPTY(loc_cCod)
5472:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5473:                 RETURN
5474:             ENDIF
5475:             loc_nRet = SQLEXEC(gnConnHandle, ;
5476:                 "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
5477:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5478:                 "cursor_4c_ValFinP")
5479:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValFinP") > 0
5480:                 SELECT cursor_4c_ValFinP
5481:                 loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(Descs)
5482:             ELSE
5483:                 loc_oPgDados.txt_4c_CodFinP.Value = ""
5484:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5485:             ENDIF
5486:             IF USED("cursor_4c_ValFinP")
5487:                 USE IN cursor_4c_ValFinP
5488:             ENDIF
5489:             THIS.CarregarLista()
5490:         CATCH TO loc_oErro
5491:             MsgErro(loc_oErro.Message, "Erro ao validar finalidade")
5492:         ENDTRY
5493:     ENDPROC
5494: 
5495:     *-- Acabamento (SigCdAca: Cods / Descrs)
5496:     PROCEDURE CodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5497:         TRY
5498:             IF par_nKeyCode = 115
5499:                 THIS.AbrirLookupCodAcb()
5500:             ELSE
5501:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5502:                 THIS.ValidarCodAcbDados()
5503:                 ENDIF
5504:             ENDIF
5505:         CATCH TO loc_oErro
5506:             *-- Tolerado
5507:         ENDTRY
5508:     ENDPROC
5509: 
5510:     PROCEDURE CodAcbDblClick()
5511:         THIS.AbrirLookupCodAcb()
5512:     ENDPROC
5513: 
5514:     PROTECTED PROCEDURE AbrirLookupCodAcb()
5515:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5516:         TRY
5517:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5518:                 RETURN
5519:             ENDIF
5520:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5521:             IF !loc_oPgDados.txt_4c_CodAcb.Enabled
5522:                 RETURN
5523:             ENDIF
5524:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", ;
5525:                 "cursor_4c_BuscaAcb", "Cods", ;
5526:                 ALLTRIM(loc_oPgDados.txt_4c_CodAcb.Value), ;
5527:                 "Acabamento")
5528:             loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
5529:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5530:             loc_oBusca.Show()
5531:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
5532:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaAcb.Cods)
5533:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaAcb.Descrs)
5534:                 loc_oPgDados.txt_4c_CodAcb.Value = loc_cCodigo
5535:                 loc_oPgDados.txt_4c_DesAcb.Value = loc_cDescricao
5536:             ENDIF
5537:             IF USED("cursor_4c_BuscaAcb")
5538:                 USE IN cursor_4c_BuscaAcb
5539:             ENDIF
5540:             loc_oBusca.Release()
5541:         CATCH TO loc_oErro
5542:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup acabamento")
5543:         ENDTRY
5544:     ENDPROC
5545: 
5546:     PROTECTED PROCEDURE ValidarCodAcbDados()
5547:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5548:         TRY
5549:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5550:                 RETURN
5551:             ENDIF
5552:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5553:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_CodAcb.Value)
5554:             IF EMPTY(loc_cCod)
5555:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5556:                 RETURN
5557:             ENDIF
5558:             loc_nRet = SQLEXEC(gnConnHandle, ;
5559:                 "SELECT Descrs FROM SigCdAca WHERE Cods = " + ;
5560:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5561:                 "cursor_4c_ValAcb")
5562:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValAcb") > 0
5563:                 SELECT cursor_4c_ValAcb
5564:                 loc_oPgDados.txt_4c_DesAcb.Value = ALLTRIM(Descrs)
5565:             ELSE
5566:                 loc_oPgDados.txt_4c_CodAcb.Value = ""
5567:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5568:             ENDIF
5569:             IF USED("cursor_4c_ValAcb")
5570:                 USE IN cursor_4c_ValAcb
5571:             ENDIF
5572:             THIS.CarregarLista()
5573:         CATCH TO loc_oErro
5574:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
5575:         ENDTRY
5576:     ENDPROC
5577: 
5578:     *-- Classificacao (SigCdCls: Cods / Descs, filtrado por CGrus)
5579:     PROCEDURE ClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5580:         TRY
5581:             IF par_nKeyCode = 115
5582:                 THIS.AbrirLookupClass()
5583:             ELSE
5584:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5585:                 THIS.ValidarClassDados()
5586:                 ENDIF
5587:             ENDIF
5588:         CATCH TO loc_oErro
5589:             *-- Tolerado
5590:         ENDTRY
5591:     ENDPROC
5592: 
5593:     PROCEDURE ClassDblClick()
5594:         THIS.AbrirLookupClass()
5595:     ENDPROC
5596: 
5597:     PROTECTED PROCEDURE AbrirLookupClass()
5598:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao
5599:         LOCAL loc_cCodGru, loc_cSQL, loc_oErro
5600:         TRY
5601:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5602:                 RETURN
5603:             ENDIF
5604:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5605:             IF !loc_oPgDados.txt_4c_Class.Enabled
5606:                 RETURN
5607:             ENDIF
5608:             loc_cCodGru = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
5609:             IF !EMPTY(loc_cCodGru)
5610:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls " + ;
5611:                            "WHERE CGrus IN (" + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
5612:                            ", '          ') ORDER BY Cods"
5613:             ELSE
5614:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods"
5615:             ENDIF
5616:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCls", ;
5617:                 "cursor_4c_BuscaClass", "Cods", ;
5618:                 ALLTRIM(loc_oPgDados.txt_4c_Class.Value), ;
5619:                 "Classifica" + CHR(231) + CHR(227) + "o")
5620:             loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
5621:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5622:             loc_oBusca.Show()
5623:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
5624:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaClass.Cods)
5625:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaClass.Descs)
5626:                 loc_oPgDados.txt_4c_Class.Value  = loc_cCodigo
5627:                 loc_oPgDados.txt_4c_DClass.Value = loc_cDescricao
5628:             ENDIF
5629:             IF USED("cursor_4c_BuscaClass")
5630:                 USE IN cursor_4c_BuscaClass
5631:             ENDIF
5632:             loc_oBusca.Release()
5633:         CATCH TO loc_oErro
5634:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup classifica" + CHR(231) + CHR(227) + "o")
5635:         ENDTRY
5636:     ENDPROC
5637: 
5638:     PROTECTED PROCEDURE ValidarClassDados()
5639:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5640:         TRY
5641:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5642:                 RETURN
5643:             ENDIF
5644:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5645:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Class.Value)
5646:             IF EMPTY(loc_cCod)
5647:                 loc_oPgDados.txt_4c_DClass.Value = ""
5648:                 RETURN
5649:             ENDIF
5650:             loc_nRet = SQLEXEC(gnConnHandle, ;
5651:                 "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
5652:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5653:                 "cursor_4c_ValClass")
5654:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValClass") > 0
5655:                 SELECT cursor_4c_ValClass
5656:                 loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(Descs)
5657:             ELSE
5658:                 loc_oPgDados.txt_4c_Class.Value  = ""
5659:                 loc_oPgDados.txt_4c_DClass.Value = ""
5660:             ENDIF
5661:             IF USED("cursor_4c_ValClass")
5662:                 USE IN cursor_4c_ValClass
5663:             ENDIF
5664:             THIS.CarregarLista()
5665:         CATCH TO loc_oErro
5666:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
5667:         ENDTRY
5668:     ENDPROC
5669: 
5670:     *-- Local (SigPrLcl: Codigos / Descricaos)
5671:     PROCEDURE LocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5672:         TRY
5673:             IF par_nKeyCode = 115
5674:                 THIS.AbrirLookupLocal()
5675:             ENDIF
5676:         CATCH TO loc_oErro
5677:             *-- Tolerado
5678:         ENDTRY
5679:     ENDPROC
5680: 
5681:     PROCEDURE LocalDblClick()
5682:         THIS.AbrirLookupLocal()
5683:     ENDPROC
5684: 
5685:     PROTECTED PROCEDURE AbrirLookupLocal()
5686:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
5687:         TRY
5688:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5689:                 RETURN
5690:             ENDIF
5691:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5692:             IF !loc_oPgDados.txt_4c_Local.Enabled
5693:                 RETURN
5694:             ENDIF
5695:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrLcl", ;
5696:                 "cursor_4c_BuscaLocal", "Codigos", ;
5697:                 ALLTRIM(loc_oPgDados.txt_4c_Local.Value), ;
5698:                 "Localiza" + CHR(231) + CHR(227) + "o")
5699:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
5700:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
5701:             loc_oBusca.Show()
5702:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
5703:                 loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.Codigos)
5704:             ENDIF
5705:             IF USED("cursor_4c_BuscaLocal")
5706:                 USE IN cursor_4c_BuscaLocal
5707:             ENDIF
5708:             loc_oBusca.Release()
5709:         CATCH TO loc_oErro
5710:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup local")
5711:         ENDTRY
5712:     ENDPROC
5713: 
5714:     *-- Unidade 1 (SigCdUni: CUnis / DUnis)
5715:     PROCEDURE CuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5716:         TRY
5717:             IF par_nKeyCode = 115
5718:                 THIS.AbrirLookupCuni()
5719:             ELSE
5720:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5721:                 THIS.ValidarCuniDados()
5722:                 ENDIF
5723:             ENDIF
5724:         CATCH TO loc_oErro
5725:             *-- Tolerado
5726:         ENDTRY
5727:     ENDPROC
5728: 
5729:     PROCEDURE CuniDblClick()
5730:         THIS.AbrirLookupCuni()
5731:     ENDPROC
5732: 
5733:     PROTECTED PROCEDURE AbrirLookupCuni()
5734:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5735:         TRY
5736:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5737:                 RETURN
5738:             ENDIF
5739:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5740:             IF !loc_oPgDados.txt_4c_Cuni.Enabled
5741:                 RETURN
5742:             ENDIF
5743:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", ;
5744:                 "cursor_4c_BuscaCuni", "CUnis", ;
5745:                 ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value), ;
5746:                 "Unidade (1)")
5747:             loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
5748:             loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
5749:             loc_oBusca.Show()
5750:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCuni")
5751:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCuni.CUnis)
5752:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCuni.DUnis)
5753:                 loc_oPgDados.txt_4c_Cuni.Value = loc_cCodigo
5754:                 loc_oPgDados.txt_4c_Duni.Value = loc_cDescricao
5755:             ENDIF
5756:             IF USED("cursor_4c_BuscaCuni")
5757:                 USE IN cursor_4c_BuscaCuni
5758:             ENDIF
5759:             loc_oBusca.Release()
5760:         CATCH TO loc_oErro
5761:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup unidade 1")
5762:         ENDTRY
5763:     ENDPROC
5764: 
5765:     PROTECTED PROCEDURE ValidarCuniDados()
5766:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5767:         TRY
5768:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5769:                 RETURN
5770:             ENDIF
5771:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5772:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value)
5773:             IF EMPTY(loc_cCod)
5774:                 loc_oPgDados.txt_4c_Duni.Value = ""
5775:                 RETURN
5776:             ENDIF
5777:             loc_nRet = SQLEXEC(gnConnHandle, ;
5778:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5779:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5780:                 "cursor_4c_ValCuni")
5781:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCuni") > 0
5782:                 SELECT cursor_4c_ValCuni
5783:                 loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(DUnis)
5784:             ELSE
5785:                 loc_oPgDados.txt_4c_Cuni.Value = ""
5786:                 loc_oPgDados.txt_4c_Duni.Value = ""
5787:             ENDIF
5788:             IF USED("cursor_4c_ValCuni")
5789:                 USE IN cursor_4c_ValCuni
5790:             ENDIF
5791:             THIS.CarregarLista()
5792:         CATCH TO loc_oErro
5793:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 1")
5794:         ENDTRY
5795:     ENDPROC
5796: 
5797:     *-- Unidade 2 (SigCdUni: CUnis / DUnis)
5798:     PROCEDURE CunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5799:         TRY
5800:             IF par_nKeyCode = 115
5801:                 THIS.AbrirLookupCunip()
5802:             ELSE
5803:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5804:                 THIS.ValidarCunipDados()
5805:                 ENDIF
5806:             ENDIF
5807:         CATCH TO loc_oErro
5808:             *-- Tolerado
5809:         ENDTRY
5810:     ENDPROC
5811: 
5812:     PROCEDURE CunipDblClick()
5813:         THIS.AbrirLookupCunip()
5814:     ENDPROC
5815: 
5816:     PROTECTED PROCEDURE AbrirLookupCunip()
5817:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5818:         TRY
5819:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5820:                 RETURN
5821:             ENDIF
5822:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5823:             IF !loc_oPgDados.txt_4c_Cunip.Enabled
5824:                 RETURN
5825:             ENDIF
5826:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", ;
5827:                 "cursor_4c_BuscaCunip", "CUnis", ;
5828:                 ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value), ;
5829:                 "Unidade (2)")
5830:             loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
5831:             loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
5832:             loc_oBusca.Show()
5833:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCunip")
5834:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCunip.CUnis)
5835:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCunip.DUnis)
5836:                 loc_oPgDados.txt_4c_Cunip.Value = loc_cCodigo
5837:                 loc_oPgDados.txt_4c_Dunip.Value = loc_cDescricao
5838:             ENDIF
5839:             IF USED("cursor_4c_BuscaCunip")
5840:                 USE IN cursor_4c_BuscaCunip
5841:             ENDIF
5842:             loc_oBusca.Release()
5843:         CATCH TO loc_oErro
5844:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup unidade 2")
5845:         ENDTRY
5846:     ENDPROC
5847: 
5848:     PROTECTED PROCEDURE ValidarCunipDados()
5849:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5850:         TRY
5851:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5852:                 RETURN
5853:             ENDIF
5854:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5855:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value)
5856:             IF EMPTY(loc_cCod)
5857:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5858:                 RETURN
5859:             ENDIF
5860:             loc_nRet = SQLEXEC(gnConnHandle, ;
5861:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5862:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5863:                 "cursor_4c_ValCunip")
5864:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCunip") > 0
5865:                 SELECT cursor_4c_ValCunip
5866:                 loc_oPgDados.txt_4c_Dunip.Value = ALLTRIM(DUnis)
5867:             ELSE
5868:                 loc_oPgDados.txt_4c_Cunip.Value = ""
5869:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5870:             ENDIF
5871:             IF USED("cursor_4c_ValCunip")
5872:                 USE IN cursor_4c_ValCunip
5873:             ENDIF
5874:             THIS.CarregarLista()
5875:         CATCH TO loc_oErro
5876:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
5877:         ENDTRY
5878:     ENDPROC
5879: 
5880:     *==========================================================================
5881:     * ConfigurarPgpgComposicao - Aba Composicao (Page2 do inner PageFrame)
5882:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
5883:     *==========================================================================
5884:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPage)
5885:         LOCAL loc_oErro
5886:         TRY
5887:             *-- === Cursores placeholder ANTES dos grids ===
5888:             SET NULL ON
5889:             IF USED("cursor_4c_Compo")
5890:                 USE IN cursor_4c_Compo
5891:             ENDIF
5892:             CREATE CURSOR cursor_4c_Compo (;
5893:                 Mats     C(14)    NULL, ;
5894:                 DPros    C(40)    NULL, ;
5895:                 Unisp    C(5)     NULL, ;
5896:                 Vals     N(15,6)  NULL, ;
5897:                 Qtds     N(15,6)  NULL, ;
5898:                 Totals   N(15,6)  NULL, ;
5899:                 Moedas   C(10)    NULL, ;
5900:                 Obss     C(50)    NULL, ;
5901:                 Es       C(10)    NULL, ;
5902:                 Conss    N(15,6)  NULL, ;
5903:                 Qtdss    N(15,6)  NULL, ;
5904:                 Unis     C(5)     NULL, ;
5905:                 Ords     N(5,0)   NULL, ;
5906:                 Bloqueio C(14)    NULL  ;
5907:             )
5908:             IF USED("cursor_4c_SubCp")
5909:                 USE IN cursor_4c_SubCp
5910:             ENDIF
5911:             CREATE CURSOR cursor_4c_SubCp (;
5912:                 Mats     C(14)    NULL, ;
5913:                 DPros    C(40)    NULL, ;
5914:                 Unisp    C(5)     NULL, ;
5915:                 Vals     N(15,6)  NULL, ;
5916:                 Qtds     N(15,6)  NULL, ;
5917:                 Totals   N(15,6)  NULL, ;
5918:                 Moedas   C(10)    NULL, ;
5919:                 Obss     C(50)    NULL, ;
5920:                 Es       C(10)    NULL, ;
5921:                 Conss    N(15,6)  NULL, ;
5922:                 Qtdss    N(15,6)  NULL, ;
5923:                 Unis     C(5)     NULL, ;
5924:                 Ords     N(5,0)   NULL, ;
5925:                 Bloqueio C(14)    NULL, ;
5926:                 Tams     C(10)    NULL  ;
5927:             )
5928:             IF USED("cursor_4c_GrupoCompo")
5929:                 USE IN cursor_4c_GrupoCompo
5930:             ENDIF
5931:             CREATE CURSOR cursor_4c_GrupoCompo (;
5932:                 CGrus  C(10)   NULL, ;
5933:                 Totals N(15,6) NULL, ;
5934:                 Moedas C(10)   NULL  ;
5935:             )
5936:             SET NULL OFF
5937: 
5938:             *-- === Obs. da OF (getObsOFs) - top=297+29=326 ===
5939:             par_oPage.AddObject("lbl_4c_LblObsOF", "Label")
5940:             WITH par_oPage.lbl_4c_LblObsOF
5941:                 .Top       = 329
5942:                 .Left      = 36
5943:                 .Width     = 64
5944:                 .Height    = 15
5945:                 .FontName  = "Tahoma"
5946:                 .FontSize  = 8

*-- Linhas 6029 a 6062:
6029:             par_oPage.grd_4c_Grupo.ReadOnly    = .T.
6030:             par_oPage.grd_4c_Grupo.ScrollBars  = 2
6031:             par_oPage.grd_4c_Grupo.Themes      = .F.
6032:             par_oPage.grd_4c_Grupo.Visible     = .T.
6033: 
6034:             par_oPage.grd_4c_Grupo.RecordSource = "cursor_4c_GrupoCompo"
6035: 
6036:             par_oPage.grd_4c_Grupo.Column1.Header1.Caption  = "Grupo"
6037:             par_oPage.grd_4c_Grupo.Column1.ControlSource    = "cursor_4c_GrupoCompo.CGrus"
6038:             par_oPage.grd_4c_Grupo.Column1.Width            = 60
6039:             par_oPage.grd_4c_Grupo.Column1.Header1.FontBold = .T.
6040: 
6041:             par_oPage.grd_4c_Grupo.Column2.Header1.Caption  = "Total"
6042:             par_oPage.grd_4c_Grupo.Column2.ControlSource    = "cursor_4c_GrupoCompo.Totals"
6043:             par_oPage.grd_4c_Grupo.Column2.Width            = 90
6044:             par_oPage.grd_4c_Grupo.Column2.Header1.FontBold = .T.
6045: 
6046:             par_oPage.grd_4c_Grupo.Column3.Header1.Caption  = "Moeda"
6047:             par_oPage.grd_4c_Grupo.Column3.ControlSource    = "cursor_4c_GrupoCompo.Moedas"
6048:             par_oPage.grd_4c_Grupo.Column3.Width            = 65
6049:             par_oPage.grd_4c_Grupo.Column3.Header1.FontBold = .T.
6050: 
6051:             *-- === grdCompo (composicao principal) - top=148+29=177 ===
6052:             par_oPage.AddObject("grd_4c_Compo", "Grid")
6053:             par_oPage.grd_4c_Compo.Top         = 177
6054:             par_oPage.grd_4c_Compo.Left        = 6
6055:             par_oPage.grd_4c_Compo.Width       = 943
6056:             par_oPage.grd_4c_Compo.Height      = 147
6057:             par_oPage.grd_4c_Compo.ColumnCount = 14
6058:             par_oPage.grd_4c_Compo.FontName    = "Tahoma"
6059:             par_oPage.grd_4c_Compo.FontSize    = 8
6060:             par_oPage.grd_4c_Compo.GridLines   = 3
6061:             par_oPage.grd_4c_Compo.DeleteMark  = .F.
6062:             par_oPage.grd_4c_Compo.RecordMark  = .F.

*-- Linhas 6274 a 6367:
6274:             par_oPage.grd_4c_SubCp.RowHeight   = 16
6275:             par_oPage.grd_4c_SubCp.ScrollBars  = 3
6276:             par_oPage.grd_4c_SubCp.Themes      = .F.
6277:             par_oPage.grd_4c_SubCp.Visible     = .T.
6278: 
6279:             par_oPage.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
6280: 
6281:             par_oPage.grd_4c_SubCp.Column1.Header1.Caption  = "Material"
6282:             par_oPage.grd_4c_SubCp.Column1.ControlSource    = "cursor_4c_SubCp.Mats"
6283:             par_oPage.grd_4c_SubCp.Column1.Width            = 80
6284:             par_oPage.grd_4c_SubCp.Column1.Header1.FontBold = .T.
6285: 
6286:             par_oPage.grd_4c_SubCp.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6287:             par_oPage.grd_4c_SubCp.Column2.ControlSource    = "cursor_4c_SubCp.DPros"
6288:             par_oPage.grd_4c_SubCp.Column2.Width            = 140
6289:             par_oPage.grd_4c_SubCp.Column2.Header1.FontBold = .T.
6290: 
6291:             par_oPage.grd_4c_SubCp.Column3.Header1.Caption  = "Un"
6292:             par_oPage.grd_4c_SubCp.Column3.ControlSource    = "cursor_4c_SubCp.Unisp"
6293:             par_oPage.grd_4c_SubCp.Column3.Width            = 30
6294:             par_oPage.grd_4c_SubCp.Column3.Header1.FontBold = .T.
6295: 
6296:             par_oPage.grd_4c_SubCp.Column4.Header1.Caption  = "Valor"
6297:             par_oPage.grd_4c_SubCp.Column4.ControlSource    = "cursor_4c_SubCp.Vals"
6298:             par_oPage.grd_4c_SubCp.Column4.Width            = 65
6299:             par_oPage.grd_4c_SubCp.Column4.Header1.FontBold = .T.
6300: 
6301:             par_oPage.grd_4c_SubCp.Column5.Header1.Caption  = "Qtde."
6302:             par_oPage.grd_4c_SubCp.Column5.ControlSource    = "cursor_4c_SubCp.Qtds"
6303:             par_oPage.grd_4c_SubCp.Column5.Width            = 60
6304:             par_oPage.grd_4c_SubCp.Column5.Header1.FontBold = .T.
6305: 
6306:             par_oPage.grd_4c_SubCp.Column6.Header1.Caption  = "Total"
6307:             par_oPage.grd_4c_SubCp.Column6.ControlSource    = "cursor_4c_SubCp.Totals"
6308:             par_oPage.grd_4c_SubCp.Column6.Width            = 65
6309:             par_oPage.grd_4c_SubCp.Column6.Header1.FontBold = .T.
6310: 
6311:             par_oPage.grd_4c_SubCp.Column7.Header1.Caption  = "Moe"
6312:             par_oPage.grd_4c_SubCp.Column7.ControlSource    = "cursor_4c_SubCp.Moedas"
6313:             par_oPage.grd_4c_SubCp.Column7.Width            = 30
6314:             par_oPage.grd_4c_SubCp.Column7.Header1.FontBold = .T.
6315: 
6316:             par_oPage.grd_4c_SubCp.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6317:             par_oPage.grd_4c_SubCp.Column8.ControlSource    = "cursor_4c_SubCp.Obss"
6318:             par_oPage.grd_4c_SubCp.Column8.Width            = 90
6319:             par_oPage.grd_4c_SubCp.Column8.Header1.FontBold = .T.
6320: 
6321:             par_oPage.grd_4c_SubCp.Column9.Header1.Caption  = "E"
6322:             par_oPage.grd_4c_SubCp.Column9.ControlSource    = "cursor_4c_SubCp.Es"
6323:             par_oPage.grd_4c_SubCp.Column9.Width            = 20
6324:             par_oPage.grd_4c_SubCp.Column9.Header1.FontBold = .T.
6325: 
6326:             par_oPage.grd_4c_SubCp.Column10.Header1.Caption  = "Consumo"
6327:             par_oPage.grd_4c_SubCp.Column10.ControlSource    = "cursor_4c_SubCp.Conss"
6328:             par_oPage.grd_4c_SubCp.Column10.Width            = 60
6329:             par_oPage.grd_4c_SubCp.Column10.Header1.FontBold = .T.
6330: 
6331:             par_oPage.grd_4c_SubCp.Column11.Header1.Caption  = "Qtde."
6332:             par_oPage.grd_4c_SubCp.Column11.ControlSource    = "cursor_4c_SubCp.Qtdss"
6333:             par_oPage.grd_4c_SubCp.Column11.Width            = 60
6334:             par_oPage.grd_4c_SubCp.Column11.Header1.FontBold = .T.
6335: 
6336:             par_oPage.grd_4c_SubCp.Column12.Header1.Caption  = "Un"
6337:             par_oPage.grd_4c_SubCp.Column12.ControlSource    = "cursor_4c_SubCp.Unis"
6338:             par_oPage.grd_4c_SubCp.Column12.Width            = 30
6339:             par_oPage.grd_4c_SubCp.Column12.Header1.FontBold = .T.
6340: 
6341:             par_oPage.grd_4c_SubCp.Column13.Header1.Caption  = "Ord"
6342:             par_oPage.grd_4c_SubCp.Column13.ControlSource    = "cursor_4c_SubCp.Ords"
6343:             par_oPage.grd_4c_SubCp.Column13.Width            = 30
6344:             par_oPage.grd_4c_SubCp.Column13.Header1.FontBold = .T.
6345: 
6346:             par_oPage.grd_4c_SubCp.Column14.Header1.Caption  = "Matriz"
6347:             par_oPage.grd_4c_SubCp.Column14.ControlSource    = "cursor_4c_SubCp.Bloqueio"
6348:             par_oPage.grd_4c_SubCp.Column14.Width            = 75
6349:             par_oPage.grd_4c_SubCp.Column14.Header1.FontBold = .T.
6350: 
6351:             par_oPage.grd_4c_SubCp.Column15.Header1.Caption  = "Tam"
6352:             par_oPage.grd_4c_SubCp.Column15.ControlSource    = "cursor_4c_SubCp.Tams"
6353:             par_oPage.grd_4c_SubCp.Column15.Width            = 55
6354:             par_oPage.grd_4c_SubCp.Column15.Header1.FontBold = .T.
6355: 
6356:             *-- === cmdgSubCp (CommandGroup 2 botoes) - top=345+29=374 ===
6357:             par_oPage.AddObject("cmdg_4c_SubCp", "CommandGroup")
6358:             WITH par_oPage.cmdg_4c_SubCp
6359:                 .Top         = 374
6360:                 .Left        = 947
6361:                 .Width       = 50
6362:                 .Height      = 90
6363:                 .ButtonCount = 2
6364:                 .Themes      = .F.
6365:                 .Visible     = .T.
6366:             ENDWITH
6367: 

*-- Linhas 7269 a 7314:
7269:     * ConfigurarPgpgCusto - Configura Page6 (pgCusto) do pgf_4c_DadosInterno
7270:     * Posicoes: original_top + 29
7271:     *==========================================================================
7272:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
7273:         LOCAL loc_oErro
7274:         TRY
7275:             *-- === Cursores placeholder ANTES dos grids ===
7276:             SET NULL ON
7277:             IF USED("cursor_4c_CustoCompo")
7278:                 USE IN cursor_4c_CustoCompo
7279:             ENDIF
7280:             CREATE CURSOR cursor_4c_CustoCompo (;
7281:                 Mats     C(14)    NULL, ;
7282:                 DPros    C(40)    NULL, ;
7283:                 Unisp    C(5)     NULL, ;
7284:                 Vals     N(15,6)  NULL, ;
7285:                 Qtds     N(15,6)  NULL, ;
7286:                 Totals   N(15,6)  NULL, ;
7287:                 Moedas   C(10)    NULL, ;
7288:                 Obss     C(50)    NULL, ;
7289:                 Es       C(10)    NULL, ;
7290:                 Conss    N(15,6)  NULL, ;
7291:                 Qtdss    N(15,6)  NULL, ;
7292:                 Unis     C(5)     NULL, ;
7293:                 CGrus    C(10)    NULL, ;
7294:                 Bloqueio C(14)    NULL  ;
7295:             )
7296:             IF USED("cursor_4c_GrupoCompo2")
7297:                 USE IN cursor_4c_GrupoCompo2
7298:             ENDIF
7299:             CREATE CURSOR cursor_4c_GrupoCompo2 (;
7300:                 CGrus  C(10)   NULL, ;
7301:                 Totals N(15,6) NULL, ;
7302:                 Moedas C(10)   NULL  ;
7303:             )
7304:             SET NULL OFF
7305: 
7306:             *-- === Say1: label "Tipo:" - top=159+29=188, left=112 ===
7307:             par_oPage.AddObject("lbl_4c_LblTipo", "Label")
7308:             WITH par_oPage.lbl_4c_LblTipo
7309:                 .Top       = 188
7310:                 .Left      = 112
7311:                 .Width     = 29
7312:                 .Height    = 15
7313:                 .FontName  = "Tahoma"
7314:                 .FontSize  = 8

*-- Linhas 7548 a 8316:
7548:             par_oPage.grd_4c_GrupoCompo2.ReadOnly    = .T.
7549:             par_oPage.grd_4c_GrupoCompo2.ScrollBars  = 2
7550:             par_oPage.grd_4c_GrupoCompo2.Themes      = .F.
7551:             par_oPage.grd_4c_GrupoCompo2.Visible     = .T.
7552: 
7553:             par_oPage.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
7554: 
7555:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.Caption  = "Grp"
7556:             par_oPage.grd_4c_GrupoCompo2.Column1.ControlSource    = "cursor_4c_GrupoCompo2.CGrus"
7557:             par_oPage.grd_4c_GrupoCompo2.Column1.Width            = 60
7558:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.FontBold = .T.
7559: 
7560:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.Caption  = "Total"
7561:             par_oPage.grd_4c_GrupoCompo2.Column2.ControlSource    = "cursor_4c_GrupoCompo2.Totals"
7562:             par_oPage.grd_4c_GrupoCompo2.Column2.Width            = 90
7563:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.FontBold = .T.
7564: 
7565:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.Caption  = "Moe"
7566:             par_oPage.grd_4c_GrupoCompo2.Column3.ControlSource    = "cursor_4c_GrupoCompo2.Moedas"
7567:             par_oPage.grd_4c_GrupoCompo2.Column3.Width            = 40
7568:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.FontBold = .T.
7569: 
7570:         CATCH TO loc_oErro
7571:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Custo")
7572:         ENDTRY
7573:     ENDPROC
7574: 
7575:     *==========================================================================
7576:     * CarregarComposicao - Carrega SigPrCpo e SigPrScp para o produto atual
7577:     *==========================================================================
7578:     PROCEDURE CarregarComposicao()
7579:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgComp, loc_oErro
7580:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7581:             RETURN
7582:         ENDIF
7583:         TRY
7584:             loc_cCPros = ALLTRIM(this_cCodigo)
7585:             IF EMPTY(loc_cCPros)
7586:                 RETURN
7587:             ENDIF
7588: 
7589:             *-- Carregar composicao principal (SigPrCpo)
7590:             IF USED("cursor_4c_CompoTemp")
7591:                 USE IN cursor_4c_CompoTemp
7592:             ENDIF
7593:             loc_cSQL = "SELECT c.mats, ISNULL(p.DPros,'') AS DPros, " + ;
7594:                        "       c.unicompos AS Unisp, c.pcompos AS Vals, c.qtds, c.totas AS Totals, c.moeds AS Moedas, " + ;
7595:                        "       ISNULL(c.obscompos,'') AS Obss, ISNULL(c.etiqs,'') AS Es, " + ;
7596:                        "       c.qtscons AS Conss, c.pesos AS Qtdss, ISNULL(c.cunips,'') AS Unis, " + ;
7597:                        "       c.ordts AS Ords, ISNULL(c.matriz,'') AS Bloqueio " + ;
7598:                        "FROM SigPrCpo c " + ;
7599:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
7600:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7601:                        " ORDER BY c.ordts"
7602:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTemp")
7603:             IF loc_nRet > 0
7604:                 SELECT cursor_4c_Compo
7605:                 ZAP
7606:                 APPEND FROM DBF("cursor_4c_CompoTemp")
7607:                 IF USED("cursor_4c_CompoTemp")
7608:                     USE IN cursor_4c_CompoTemp
7609:                 ENDIF
7610:                 SELECT cursor_4c_Compo
7611:                 GO TOP
7612:             ENDIF
7613: 
7614:             *-- Carregar subcomposicao (SigPrScp)
7615:             IF USED("cursor_4c_SubCpTemp")
7616:                 USE IN cursor_4c_SubCpTemp
7617:             ENDIF
7618:             loc_cSQL = "SELECT s.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
7619:                        "       s.Unisp, s.Vals, s.Qtds, s.Totals, s.Moedas, " + ;
7620:                        "       ISNULL(s.Obss,'') AS Obss, ISNULL(s.Es,'') AS Es, " + ;
7621:                        "       s.Conss, s.Qtdss, ISNULL(s.Unis,'') AS Unis, " + ;
7622:                        "       s.Ords, ISNULL(s.Bloqueio,'') AS Bloqueio, " + ;
7623:                        "       ISNULL(s.Tams,'') AS Tams " + ;
7624:                        "FROM SigPrScp s " + ;
7625:                        "LEFT JOIN SigCdPro p ON p.CPros = s.Mats " + ;
7626:                        "WHERE s.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7627:                        " ORDER BY s.Ords"
7628:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCpTemp")
7629:             IF loc_nRet > 0
7630:                 SELECT cursor_4c_SubCp
7631:                 ZAP
7632:                 APPEND FROM DBF("cursor_4c_SubCpTemp")
7633:                 IF USED("cursor_4c_SubCpTemp")
7634:                     USE IN cursor_4c_SubCpTemp
7635:                 ENDIF
7636:                 SELECT cursor_4c_SubCp
7637:                 GO TOP
7638:             ENDIF
7639: 
7640:             *-- Refresh grids
7641:             loc_oPgComp = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7642:             loc_oPgComp.grd_4c_Compo.Refresh()
7643:             loc_oPgComp.grd_4c_SubCp.Refresh()
7644:             loc_oPgComp.grd_4c_Grupo.Refresh()
7645: 
7646:         CATCH TO loc_oErro
7647:             MsgErro(loc_oErro.Message, "Erro ao carregar composi" + CHR(231) + CHR(227) + "o")
7648:         ENDTRY
7649:     ENDPROC
7650: 
7651:     *==========================================================================
7652:     * Handlers de composicao (PUBLIC - obrigatorio para BINDEVENT)
7653:     *==========================================================================
7654:     PROCEDURE CompoAfterRowColChange(par_nColIndex)
7655:         LOCAL loc_oPg, loc_oErro
7656:         TRY
7657:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7658:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
7659:                 SELECT cursor_4c_Compo
7660:                 loc_oPg.txt_4c_Desc.Value    = ALLTRIM(DPros)
7661:                 loc_oPg.txt_4c_MatP.Value    = ALLTRIM(Mats)
7662:                 loc_oPg.txt_4c_ObsOFs.Value  = ALLTRIM(Obss)
7663:             ENDIF
7664:         CATCH TO loc_oErro
7665:             *-- Tolerado
7666:         ENDTRY
7667:     ENDPROC
7668: 
7669:     PROCEDURE SubCpAfterRowColChange(par_nColIndex)
7670:         LOCAL loc_oPg, loc_oErro
7671:         TRY
7672:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7673:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
7674:                 SELECT cursor_4c_SubCp
7675:                 loc_oPg.txt_4c_Desccp.Value = ALLTRIM(DPros)
7676:                 loc_oPg.txt_4c_Matsub.Value = ALLTRIM(Mats)
7677:             ENDIF
7678:         CATCH TO loc_oErro
7679:             *-- Tolerado
7680:         ENDTRY
7681:     ENDPROC
7682: 
7683:     PROCEDURE LiberaCustoChange()
7684:         LOCAL loc_oPg, loc_lLibera, loc_oErro
7685:         TRY
7686:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7687:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1) AND this_lEmEdicao
7688:             loc_oPg.txt_4c_Pcus.ReadOnly    = !loc_lLibera
7689:             loc_oPg.txt_4c_Moec.ReadOnly    = !loc_lLibera
7690:             loc_oPg.txt_4c_FcustoC.ReadOnly = !loc_lLibera
7691:             loc_oPg.txt_4c_Moepc.ReadOnly   = !loc_lLibera
7692:             loc_oPg.txt_4c_Moecusf.ReadOnly = !loc_lLibera
7693:             loc_oPg.txt_4c_Cmkpc.ReadOnly   = !loc_lLibera
7694:             loc_oPg.txt_4c_Pftioc.ReadOnly  = !loc_lLibera
7695:         CATCH TO loc_oErro
7696:             MsgErro(loc_oErro.Message, "Erro ao liberar campos de custo")
7697:         ENDTRY
7698:     ENDPROC
7699: 
7700:     PROCEDURE LiberaVendaChange()
7701:         LOCAL loc_oPg, loc_lLibera, loc_oErro
7702:         TRY
7703:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7704:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1) AND this_lEmEdicao
7705:             loc_oPg.txt_4c_Margem.ReadOnly  = !loc_lLibera
7706:             loc_oPg.txt_4c_Ftio.ReadOnly    = !loc_lLibera
7707:             loc_oPg.txt_4c_Moeda.ReadOnly   = !loc_lLibera
7708:             loc_oPg.txt_4c_Mftio.ReadOnly   = !loc_lLibera
7709:             loc_oPg.txt_4c_Pftio.ReadOnly   = !loc_lLibera
7710:             loc_oPg.txt_4c_Moepv.ReadOnly   = !loc_lLibera
7711:             loc_oPg.txt_4c_FvendaC.ReadOnly = !loc_lLibera
7712:             loc_oPg.txt_4c_Moev.ReadOnly    = !loc_lLibera
7713:         CATCH TO loc_oErro
7714:             MsgErro(loc_oErro.Message, "Erro ao liberar campos de venda")
7715:         ENDTRY
7716:     ENDPROC
7717: 
7718:     *-- Moeda custo (getMoec)
7719:     PROCEDURE MoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7720:         LOCAL loc_oPg, loc_oErro
7721:         TRY
7722:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7723:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7724:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moec)
7725:             ENDIF
7726:         CATCH TO loc_oErro
7727:             *-- Tolerado
7728:         ENDTRY
7729:     ENDPROC
7730: 
7731:     *-- Moeda fator custo (getMoepc)
7732:     PROCEDURE MoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7733:         LOCAL loc_oPg, loc_oErro
7734:         TRY
7735:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7736:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7737:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moepc)
7738:             ENDIF
7739:         CATCH TO loc_oErro
7740:             *-- Tolerado
7741:         ENDTRY
7742:     ENDPROC
7743: 
7744:     *-- Moeda total custo (getMoecusf)
7745:     PROCEDURE MoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7746:         LOCAL loc_oPg, loc_oErro
7747:         TRY
7748:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7749:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7750:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moecusf)
7751:             ENDIF
7752:         CATCH TO loc_oErro
7753:             *-- Tolerado
7754:         ENDTRY
7755:     ENDPROC
7756: 
7757:     *-- Moeda preco ideal (getMoeda)
7758:     PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7759:         LOCAL loc_oPg, loc_oErro
7760:         TRY
7761:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7762:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7763:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moeda)
7764:             ENDIF
7765:         CATCH TO loc_oErro
7766:             *-- Tolerado
7767:         ENDTRY
7768:     ENDPROC
7769: 
7770:     *-- Moeda fator venda (getMoepv)
7771:     PROCEDURE MoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7772:         LOCAL loc_oPg, loc_oErro
7773:         TRY
7774:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7775:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7776:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moepv)
7777:             ENDIF
7778:         CATCH TO loc_oErro
7779:             *-- Tolerado
7780:         ENDTRY
7781:     ENDPROC
7782: 
7783:     *-- Moeda preco atual venda (getMoev)
7784:     PROCEDURE MoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7785:         LOCAL loc_oPg, loc_oErro
7786:         TRY
7787:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7788:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7789:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moev)
7790:             ENDIF
7791:         CATCH TO loc_oErro
7792:             *-- Tolerado
7793:         ENDTRY
7794:     ENDPROC
7795: 
7796:     *-- Feitio/markup (Getftio) - valida em SigPrFti
7797:     PROCEDURE FtioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7798:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7799:             THIS.ValidarFtio()
7800:         ENDIF
7801:     ENDPROC
7802: 
7803:     *-- Margem de venda (getMargem) - aceita valor numerico
7804:     PROCEDURE MargemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7805:         LOCAL loc_oPg, loc_oErro
7806:         TRY
7807:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
7808:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7809:                 loc_oPg.txt_4c_Margem.Refresh()
7810:             ENDIF
7811:         CATCH TO loc_oErro
7812:             *-- Tolerado
7813:         ENDTRY
7814:     ENDPROC
7815: 
7816:     *-- Custo markup (Get_cmkpc) - valida em SigPrFti
7817:     PROCEDURE CmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7818:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7819:             THIS.ValidarCmkpc()
7820:         ENDIF
7821:     ENDPROC
7822: 
7823:     PROCEDURE CalcValsClick()
7824:         LOCAL loc_oErro
7825:         TRY
7826:             THIS.CarregarComposicao()
7827:         CATCH TO loc_oErro
7828:             MsgErro(loc_oErro.Message, "Erro ao calcular valores")
7829:         ENDTRY
7830:     ENDPROC
7831: 
7832:     PROCEDURE PesoMClick()
7833:         LOCAL loc_oErro
7834:         TRY
7835:             MsgInfo("C" + CHR(225) + "lculo de peso m" + CHR(233) + "dio n" + CHR(227) + "o implementado.", "Info")
7836:         CATCH TO loc_oErro
7837:             *-- Tolerado
7838:         ENDTRY
7839:     ENDPROC
7840: 
7841:     *-- Incluir linha na composicao principal
7842:     PROCEDURE CompoIncluirClick()
7843:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar
7844:         loc_lContinuar = .T.
7845:         TRY
7846:             IF !this_lEmEdicao
7847:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
7848:                 loc_lContinuar = .F.
7849:             ENDIF
7850:             IF loc_lContinuar
7851:                 loc_cCPros = ALLTRIM(this_cCodigo)
7852:                 IF EMPTY(loc_cCPros)
7853:                     MsgAviso("Salve o produto antes de adicionar composi" + CHR(231) + CHR(227) + "o.", "Aviso")
7854:                     loc_lContinuar = .F.
7855:                 ENDIF
7856:             ENDIF
7857:             IF loc_lContinuar AND gnConnHandle > 0
7858:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7859:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, TpCalcCus) " + ;
7860:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7861:                     ", GETDATE(), NEWID(), 1)")
7862:                 IF loc_nRet < 1
7863:                     MsgErro("Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o.", "Erro")
7864:                 ELSE
7865:                     THIS.CarregarComposicao()
7866:                 ENDIF
7867:             ENDIF
7868:         CATCH TO loc_oErro
7869:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o")
7870:         ENDTRY
7871:     ENDPROC
7872: 
7873:     *-- Excluir linha da composicao principal
7874:     PROCEDURE CompoExcluirClick()
7875:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
7876:         loc_lContinuar = .T.
7877:         TRY
7878:             IF !this_lEmEdicao
7879:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
7880:                 loc_lContinuar = .F.
7881:             ENDIF
7882:             IF loc_lContinuar
7883:                 IF !USED("cursor_4c_Compo") OR RECCOUNT("cursor_4c_Compo") = 0
7884:                     MsgAviso("Nenhuma linha selecionada.", "Aviso")
7885:                     loc_lContinuar = .F.
7886:                 ENDIF
7887:             ENDIF
7888:             IF loc_lContinuar
7889:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de composi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7890:                 IF loc_lConfirmou AND gnConnHandle > 0
7891:                     SELECT cursor_4c_Compo
7892:                     loc_cMats = ALLTRIM(Mats)
7893:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7894:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7895:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7896:                     THIS.CarregarComposicao()
7897:                 ENDIF
7898:             ENDIF
7899:         CATCH TO loc_oErro
7900:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de composi" + CHR(231) + CHR(227) + "o")
7901:         ENDTRY
7902:     ENDPROC
7903: 
7904:     PROCEDURE CompoAtualizaClick()
7905:         LOCAL loc_oErro
7906:         TRY
7907:             THIS.CarregarComposicao()
7908:         CATCH TO loc_oErro
7909:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
7910:         ENDTRY
7911:     ENDPROC
7912: 
7913:     PROCEDURE CompoCopiarClick()
7914:         LOCAL loc_oErro
7915:         TRY
7916:             MsgInfo("Funcionalidade de c" + CHR(243) + "pia em desenvolvimento.", "Info")
7917:         CATCH TO loc_oErro
7918:             *-- Tolerado
7919:         ENDTRY
7920:     ENDPROC
7921: 
7922:     PROCEDURE CompoGrupoClick()
7923:         LOCAL loc_oErro
7924:         TRY
7925:             THIS.CarregarComposicao()
7926:         CATCH TO loc_oErro
7927:             *-- Tolerado
7928:         ENDTRY
7929:     ENDPROC
7930: 
7931:     *-- Incluir linha na subcomposicao
7932:     PROCEDURE SubCpIncluirClick()
7933:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar
7934:         loc_lContinuar = .T.
7935:         TRY
7936:             IF !this_lEmEdicao
7937:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
7938:                 loc_lContinuar = .F.
7939:             ENDIF
7940:             IF loc_lContinuar
7941:                 loc_cCPros = ALLTRIM(this_cCodigo)
7942:                 IF EMPTY(loc_cCPros)
7943:                     loc_lContinuar = .F.
7944:                 ENDIF
7945:             ENDIF
7946:             IF loc_lContinuar AND gnConnHandle > 0
7947:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7948:                     "INSERT INTO SigPrScp (CPros, DtMovs, cIdChaves) " + ;
7949:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7950:                     ", GETDATE(), NEWID())")
7951:                 IF loc_nRet < 1
7952:                     MsgErro("Erro ao incluir linha de subcomposi" + CHR(231) + CHR(227) + "o.", "Erro")
7953:                 ELSE
7954:                     THIS.CarregarComposicao()
7955:                 ENDIF
7956:             ENDIF
7957:         CATCH TO loc_oErro
7958:             MsgErro(loc_oErro.Message, "Erro ao incluir subcomposi" + CHR(231) + CHR(227) + "o")
7959:         ENDTRY
7960:     ENDPROC
7961: 
7962:     *-- Excluir linha da subcomposicao
7963:     PROCEDURE SubCpExcluirClick()
7964:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
7965:         loc_lContinuar = .T.
7966:         TRY
7967:             IF !this_lEmEdicao
7968:                 loc_lContinuar = .F.
7969:             ENDIF
7970:             IF loc_lContinuar
7971:                 IF !USED("cursor_4c_SubCp") OR RECCOUNT("cursor_4c_SubCp") = 0
7972:                     loc_lContinuar = .F.
7973:                 ENDIF
7974:             ENDIF
7975:             IF loc_lContinuar
7976:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de subcomposi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7977:                 IF loc_lConfirmou AND gnConnHandle > 0
7978:                     SELECT cursor_4c_SubCp
7979:                     loc_cMats = ALLTRIM(Mats)
7980:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7981:                         "DELETE FROM SigPrScp WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7982:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7983:                     THIS.CarregarComposicao()
7984:                 ENDIF
7985:             ENDIF
7986:         CATCH TO loc_oErro
7987:             MsgErro(loc_oErro.Message, "Erro ao excluir subcomposi" + CHR(231) + CHR(227) + "o")
7988:         ENDTRY
7989:     ENDPROC
7990: 
7991:     *==========================================================================
7992:     * Helpers de composicao (PROTECTED)
7993:     *==========================================================================
7994:     PROTECTED PROCEDURE AbrirLookupMoedaComp(par_oTextBox)
7995:         LOCAL loc_oBusca, loc_cCodigo, loc_oErro
7996:         TRY
7997:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7998:                 RETURN
7999:             ENDIF
8000:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
8001:                 "cursor_4c_BuscaMoeComp", "CMoes", ;
8002:                 ALLTRIM(par_oTextBox.Value), ;
8003:                 "Moeda")
8004:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
8005:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
8006:             loc_oBusca.Show()
8007:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeComp")
8008:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaMoeComp.CMoes)
8009:                 par_oTextBox.Value = loc_cCodigo
8010:             ENDIF
8011:             IF USED("cursor_4c_BuscaMoeComp")
8012:                 USE IN cursor_4c_BuscaMoeComp
8013:             ENDIF
8014:             loc_oBusca.Release()
8015:         CATCH TO loc_oErro
8016:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup moeda")
8017:         ENDTRY
8018:     ENDPROC
8019: 
8020:     PROTECTED PROCEDURE ValidarFtio()
8021:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro
8022:         TRY
8023:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8024:                 RETURN
8025:             ENDIF
8026:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
8027:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
8028:             IF EMPTY(loc_cCod)
8029:                 RETURN
8030:             ENDIF
8031:             loc_nRet = SQLEXEC(gnConnHandle, ;
8032:                 "SELECT Cods FROM SigPrFti WHERE Cods = " + ;
8033:                 EscaparSQL(PADR(loc_cCod, 5)), ;
8034:                 "cursor_4c_ValFtio")
8035:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValFtio") = 0
8036:                 loc_oPg.txt_4c_Ftio.Value = ""
8037:             ENDIF
8038:             IF USED("cursor_4c_ValFtio")
8039:                 USE IN cursor_4c_ValFtio
8040:             ENDIF
8041:             THIS.CarregarLista()
8042:         CATCH TO loc_oErro
8043:             MsgErro(loc_oErro.Message, "Erro ao validar feitio")
8044:         ENDTRY
8045:     ENDPROC
8046: 
8047:     PROTECTED PROCEDURE ValidarCmkpc()
8048:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro
8049:         TRY
8050:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8051:                 RETURN
8052:             ENDIF
8053:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
8054:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
8055:             IF EMPTY(loc_cCod)
8056:                 RETURN
8057:             ENDIF
8058:             loc_nRet = SQLEXEC(gnConnHandle, ;
8059:                 "SELECT Cods FROM SigPrFti WHERE Cods = " + ;
8060:                 EscaparSQL(PADR(loc_cCod, 5)), ;
8061:                 "cursor_4c_ValCmkpc")
8062:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValCmkpc") = 0
8063:                 loc_oPg.txt_4c_Cmkpc.Value = ""
8064:             ENDIF
8065:             IF USED("cursor_4c_ValCmkpc")
8066:                 USE IN cursor_4c_ValCmkpc
8067:             ENDIF
8068:             THIS.CarregarLista()
8069:         CATCH TO loc_oErro
8070:             MsgErro(loc_oErro.Message, "Erro ao validar markup custo")
8071:         ENDTRY
8072:     ENDPROC
8073: 
8074:     *==========================================================================
8075:     * CarregarCusto - Carrega SigPrCpo filtrado por Tipos para pgCusto
8076:     *==========================================================================
8077:     PROCEDURE CarregarCusto()
8078:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_nTipo, loc_oPgCusto, loc_oErro
8079:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8080:             RETURN
8081:         ENDIF
8082:         TRY
8083:             loc_cCPros = ALLTRIM(this_cCodigo)
8084:             IF EMPTY(loc_cCPros)
8085:                 RETURN
8086:             ENDIF
8087: 
8088:             loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8089: 
8090:             *-- Obter tipo selecionado no combo (0 = todos)
8091:             loc_nTipo = 0
8092:             IF VARTYPE(loc_oPgCusto.cbo_4c_CmbTipos.Value) = "N"
8093:                 loc_nTipo = loc_oPgCusto.cbo_4c_CmbTipos.Value
8094:             ENDIF
8095: 
8096:             *-- Carregar composicao custo (SigPrCpo)
8097:             IF USED("cursor_4c_CustoCompoTemp")
8098:                 USE IN cursor_4c_CustoCompoTemp
8099:             ENDIF
8100:             loc_cSQL = "SELECT c.mats, ISNULL(p.DPros,'') AS DPros, " + ;
8101:                        "       c.unicompos AS Unisp, c.pcompos AS Vals, c.qtds, c.totas AS Totals, c.moeds AS Moedas, " + ;
8102:                        "       ISNULL(c.obscompos,'') AS Obss, ISNULL(c.etiqs,'') AS Es, " + ;
8103:                        "       c.qtscons AS Conss, c.pesos AS Qtdss, ISNULL(c.cunips,'') AS Unis, " + ;
8104:                        "       ISNULL(p.CGrus,'') AS CGrus, ISNULL(c.matriz,'') AS Bloqueio " + ;
8105:                        "FROM SigPrCpo c " + ;
8106:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
8107:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8108:             IF loc_nTipo > 0
8109:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8110:             ENDIF
8111:             loc_cSQL = loc_cSQL + " ORDER BY c.ordts"
8112: 
8113:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoCompoTemp")
8114:             IF loc_nRet > 0
8115:                 SELECT cursor_4c_CustoCompo
8116:                 ZAP
8117:                 APPEND FROM DBF("cursor_4c_CustoCompoTemp")
8118:                 IF USED("cursor_4c_CustoCompoTemp")
8119:                     USE IN cursor_4c_CustoCompoTemp
8120:                 ENDIF
8121:                 SELECT cursor_4c_CustoCompo
8122:                 GO TOP
8123:             ENDIF
8124: 
8125:             *-- Carregar resumo por grupo (GradeGRUPO2)
8126:             IF USED("cursor_4c_GrupoCompo2Temp")
8127:                 USE IN cursor_4c_GrupoCompo2Temp
8128:             ENDIF
8129:             loc_cSQL = "SELECT ISNULL(p.CGrus,'') AS CGrus, " + ;
8130:                        "       SUM(c.totas) AS Totals, MIN(c.moeds) AS Moedas " + ;
8131:                        "FROM SigPrCpo c " + ;
8132:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
8133:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8134:             IF loc_nTipo > 0
8135:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8136:             ENDIF
8137:             loc_cSQL = loc_cSQL + " GROUP BY p.CGrus ORDER BY p.CGrus"
8138: 
8139:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Temp")
8140:             IF loc_nRet > 0
8141:                 SELECT cursor_4c_GrupoCompo2
8142:                 ZAP
8143:                 APPEND FROM DBF("cursor_4c_GrupoCompo2Temp")
8144:                 IF USED("cursor_4c_GrupoCompo2Temp")
8145:                     USE IN cursor_4c_GrupoCompo2Temp
8146:                 ENDIF
8147:                 SELECT cursor_4c_GrupoCompo2
8148:                 GO TOP
8149:             ENDIF
8150: 
8151:             *-- Refresh grids
8152:             loc_oPgCusto.grd_4c_GrdCustoCompo.Refresh()
8153:             loc_oPgCusto.grd_4c_GrupoCompo2.Refresh()
8154: 
8155:         CATCH TO loc_oErro
8156:             MsgErro(loc_oErro.Message, "Erro ao carregar custo")
8157:         ENDTRY
8158:     ENDPROC
8159: 
8160:     *==========================================================================
8161:     * Handlers da pagina Custo (PUBLIC - obrigatorio para BINDEVENT)
8162:     *==========================================================================
8163:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
8164:         LOCAL loc_oPg, loc_cSQL, loc_nRet, loc_cGrus, loc_cDGrus, loc_oErro
8165:         TRY
8166:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8167:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
8168:                 SELECT cursor_4c_CustoCompo
8169:                 loc_oPg.txt_4c_DescCus.Value  = ALLTRIM(DPros)
8170:                 loc_cGrus = ALLTRIM(CGrus)
8171:                 *-- Buscar descricao do grupo
8172:                 IF !EMPTY(loc_cGrus) AND gnConnHandle > 0
8173:                     IF USED("cursor_4c_GruCusto")
8174:                         USE IN cursor_4c_GruCusto
8175:                     ENDIF
8176:                     loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(PADR(loc_cGrus, 10))
8177:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruCusto")
8178:                     IF loc_nRet > 0 AND !EOF("cursor_4c_GruCusto")
8179:                         loc_cDGrus = ALLTRIM(cursor_4c_GruCusto.DGrus)
8180:                     ELSE
8181:                         loc_cDGrus = ""
8182:                     ENDIF
8183:                     IF USED("cursor_4c_GruCusto")
8184:                         USE IN cursor_4c_GruCusto
8185:                     ENDIF
8186:                     loc_oPg.txt_4c_DGruCompos.Value = loc_cDGrus
8187:                 ELSE
8188:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8189:                 ENDIF
8190:             ENDIF
8191:         CATCH TO loc_oErro
8192:             *-- Tolerado
8193:         ENDTRY
8194:     ENDPROC
8195: 
8196:     PROCEDURE CboTiposCustoInteractiveChange()
8197:         LOCAL loc_oErro
8198:         TRY
8199:             THIS.CarregarCusto()
8200:         CATCH TO loc_oErro
8201:             MsgErro(loc_oErro.Message, "Erro ao filtrar tipos de custo")
8202:         ENDTRY
8203:     ENDPROC
8204: 
8205:     PROCEDURE CustoCompoIncluirClick()
8206:         LOCAL loc_nRet, loc_cCPros, loc_nTipo, loc_oPgCusto, loc_oErro, loc_lContinuar
8207:         loc_lContinuar = .T.
8208:         TRY
8209:             IF !this_lEmEdicao
8210:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
8211:                 loc_lContinuar = .F.
8212:             ENDIF
8213:             IF loc_lContinuar
8214:                 loc_cCPros = ALLTRIM(this_cCodigo)
8215:                 IF EMPTY(loc_cCPros)
8216:                     MsgAviso("Salve o produto antes de adicionar linha de custo.", "Aviso")
8217:                     loc_lContinuar = .F.
8218:                 ENDIF
8219:             ENDIF
8220:             IF loc_lContinuar AND gnConnHandle > 0
8221:                 loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8222:                 loc_nTipo    = 0
8223:                 IF VARTYPE(loc_oPgCusto.cbo_4c_CmbTipos.Value) = "N"
8224:                     loc_nTipo = INT(loc_oPgCusto.cbo_4c_CmbTipos.Value)
8225:                 ENDIF
8226:                 loc_nRet = SQLEXEC(gnConnHandle, ;
8227:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, Tipos) " + ;
8228:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8229:                     ", GETDATE(), NEWID(), " + LTRIM(STR(loc_nTipo)) + ")")
8230:                 IF loc_nRet < 1
8231:                     MsgErro("Erro ao incluir linha de custo.", "Erro")
8232:                 ELSE
8233:                     THIS.CarregarCusto()
8234:                 ENDIF
8235:             ENDIF
8236:         CATCH TO loc_oErro
8237:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de custo")
8238:         ENDTRY
8239:     ENDPROC
8240: 
8241:     PROCEDURE CustoCompoExcluirClick()
8242:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
8243:         loc_lContinuar = .T.
8244:         TRY
8245:             IF !this_lEmEdicao
8246:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
8247:                 loc_lContinuar = .F.
8248:             ENDIF
8249:             IF loc_lContinuar
8250:                 IF !USED("cursor_4c_CustoCompo") OR RECCOUNT("cursor_4c_CustoCompo") = 0
8251:                     MsgAviso("Nenhuma linha selecionada.", "Aviso")
8252:                     loc_lContinuar = .F.
8253:                 ENDIF
8254:             ENDIF
8255:             IF loc_lContinuar
8256:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de custo?", "Confirmar")
8257:                 IF loc_lConfirmou AND gnConnHandle > 0
8258:                     SELECT cursor_4c_CustoCompo
8259:                     loc_cMats = ALLTRIM(Mats)
8260:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
8261:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
8262:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
8263:                     THIS.CarregarCusto()
8264:                 ENDIF
8265:             ENDIF
8266:         CATCH TO loc_oErro
8267:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8268:         ENDTRY
8269:     ENDPROC
8270: 
8271:     *==========================================================================
8272:     * ConfigurarPgPgDadosConsP - PgDadosConsP (Page5 do pgf_4c_DadosInterno)
8273:     * Cons P: GrdCons (9 colunas), Getqtcpnt, chkFund, grDTEMP (2 colunas)
8274:     * Posicoes: original_top + 29
8275:     *==========================================================================
8276:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
8277:         LOCAL loc_oGrd, loc_oErro
8278:         TRY
8279:             *-- === Cursores placeholder ANTES dos grids ===
8280:             SET NULL ON
8281:             IF USED("cursor_4c_ConsP")
8282:                 USE IN cursor_4c_ConsP
8283:             ENDIF
8284:             CREATE CURSOR cursor_4c_ConsP (;
8285:                 Mats   C(14)   NULL, ;
8286:                 Qtds   N(15,6) NULL, ;
8287:                 Unisp  C(5)    NULL, ;
8288:                 Grupos C(10)   NULL, ;
8289:                 Descrs C(50)   NULL, ;
8290:                 Ordems N(5,0)  NULL, ;
8291:                 Conss  N(15,6) NULL, ;
8292:                 Ccats  C(10)   NULL, ;
8293:                 DCats  C(50)   NULL  ;
8294:             )
8295:             IF USED("cursor_4c_DTemp")
8296:                 USE IN cursor_4c_DTemp
8297:             ENDIF
8298:             CREATE CURSOR cursor_4c_DTemp (;
8299:                 Grupos C(10)   NULL, ;
8300:                 TempoP N(10,2) NULL  ;
8301:             )
8302:             SET NULL OFF
8303: 
8304:             *-- === Say7: label "Qtde Componentes :" - top=523+29=552, left=25 ===
8305:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8306:             WITH par_oPage.lbl_4c_Label7
8307:                 .Top       = 552
8308:                 .Left      = 25
8309:                 .Width     = 105
8310:                 .Height    = 15
8311:                 .FontName  = "Tahoma"
8312:                 .FontSize  = 8
8313:                 .BackStyle = 0
8314:                 .Caption   = "Qtde Componentes :"
8315:                 .Visible   = .T.
8316:             ENDWITH

*-- Linhas 8428 a 8752:
8428:             loc_oGrd.Column9.ReadOnly         = .T.
8429:             loc_oGrd.Column9.Header1.FontBold = .T.
8430: 
8431:             *-- BINDEVENT para colunas editaveis (F4=115 dispara lookup)
8432:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
8433:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
8434:             BINDEVENT(loc_oGrd.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
8435: 
8436:             *-- === grDTEMP - top=519+29=548, left=821, w=172, h=107, 2 colunas ===
8437:             par_oPage.AddObject("grd_4c_GrDTEMP", "Grid")
8438:             WITH par_oPage.grd_4c_GrDTEMP
8439:                 .Top         = 548
8440:                 .Left        = 821
8441:                 .Width       = 172
8442:                 .Height      = 107
8443:                 .ColumnCount = 2
8444:                 .FontName    = "Tahoma"
8445:                 .FontSize    = 8
8446:                 .GridLines   = 3
8447:                 .DeleteMark  = .F.
8448:                 .RecordMark  = .F.
8449:                 .RowHeight   = 16
8450:                 .ScrollBars  = 3
8451:                 .Themes      = .F.
8452:                 .Visible     = .T.
8453:             ENDWITH
8454: 
8455:             par_oPage.grd_4c_GrDTEMP.RecordSource = "cursor_4c_DTemp"
8456: 
8457:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.Caption  = "Agrupamento"
8458:             par_oPage.grd_4c_GrDTEMP.Column1.ControlSource    = "cursor_4c_DTemp.Grupos"
8459:             par_oPage.grd_4c_GrDTEMP.Column1.Width            = 90
8460:             par_oPage.grd_4c_GrDTEMP.Column1.ReadOnly         = .T.
8461:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.FontBold = .T.
8462: 
8463:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.Caption  = "Tempo %"
8464:             par_oPage.grd_4c_GrDTEMP.Column2.ControlSource    = "cursor_4c_DTemp.TempoP"
8465:             par_oPage.grd_4c_GrDTEMP.Column2.Width            = 70
8466:             par_oPage.grd_4c_GrDTEMP.Column2.ReadOnly         = .T.
8467:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.FontBold = .T.
8468: 
8469:         CATCH TO loc_oErro
8470:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina ConsP")
8471:         ENDTRY
8472:     ENDPROC
8473: 
8474:     *==========================================================================
8475:     * CarregarConsP - Carrega SigPrCpo com fase (SigCdPrf) e cat (SigCdCat)
8476:     *==========================================================================
8477:     PROCEDURE CarregarConsP()
8478:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgConsP, loc_oErro, loc_lContinuar
8479:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8480:             RETURN
8481:         ENDIF
8482:         loc_lContinuar = .T.
8483:         TRY
8484:             loc_cCPros = ALLTRIM(this_cCodigo)
8485:             IF EMPTY(loc_cCPros)
8486:                 loc_lContinuar = .F.
8487:             ENDIF
8488: 
8489:             IF loc_lContinuar
8490:                 *-- Carregar ConsP principal (SigPrCpo + SigCdPrf + SigCdCat)
8491:                 IF USED("cursor_4c_ConsPTemp")
8492:                     USE IN cursor_4c_ConsPTemp
8493:                 ENDIF
8494:                 loc_cSQL = "SELECT c.mats, ISNULL(c.qtds,0) AS Qtds, " + ;
8495:                            "       ISNULL(c.unicompos,'') AS Unisp, " + ;
8496:                            "       ISNULL(c.grupos,'') AS Grupos, " + ;
8497:                            "       ISNULL(gcr.Descrs,'') AS Descrs, " + ;
8498:                            "       ISNULL(c.ordems,0) AS Ordems, " + ;
8499:                            "       ISNULL(c.qtscons,0) AS Conss, " + ;
8500:                            "       ISNULL(c.cats,'') AS Ccats, " + ;
8501:                            "       ISNULL(cat.Descs,'') AS DCats " + ;
8502:                            "FROM SigPrCpo c " + ;
8503:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = c.grupos " + ;
8504:                            "LEFT JOIN SigCdCat cat ON LTRIM(RTRIM(cat.Cods)) = LTRIM(RTRIM(c.cats)) " + ;
8505:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8506:                            " ORDER BY c.ordems, c.mats"
8507:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPTemp")
8508:                 IF loc_nRet > 0
8509:                     SELECT cursor_4c_ConsP
8510:                     ZAP
8511:                     APPEND FROM DBF("cursor_4c_ConsPTemp")
8512:                     IF USED("cursor_4c_ConsPTemp")
8513:                         USE IN cursor_4c_ConsPTemp
8514:                     ENDIF
8515:                     SELECT cursor_4c_ConsP
8516:                     GO TOP
8517: 
8518:                     loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8519:                     loc_oPgConsP.txt_4c_Qtcpnt.Value = LTRIM(STR(RECCOUNT("cursor_4c_ConsP")))
8520:                     loc_oPgConsP.grd_4c_GrdCons.Refresh()
8521:                 ENDIF
8522: 
8523:                 *-- Carregar DTemp (consumo agrupado por fase/grupo)
8524:                 IF USED("cursor_4c_DTempLoad")
8525:                     USE IN cursor_4c_DTempLoad
8526:                 ENDIF
8527:                 loc_cSQL = "SELECT ISNULL(c.grupos,'') AS Grupos, " + ;
8528:                            "       ISNULL(SUM(c.qtscons),0) AS TempoP " + ;
8529:                            "FROM SigPrCpo c " + ;
8530:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8531:                            "  AND c.grupos IS NOT NULL AND LTRIM(RTRIM(c.grupos)) <> '' " + ;
8532:                            "GROUP BY c.grupos ORDER BY c.grupos"
8533:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DTempLoad")
8534:                 IF loc_nRet > 0
8535:                     SELECT cursor_4c_DTemp
8536:                     ZAP
8537:                     APPEND FROM DBF("cursor_4c_DTempLoad")
8538:                     IF USED("cursor_4c_DTempLoad")
8539:                         USE IN cursor_4c_DTempLoad
8540:                     ENDIF
8541:                     SELECT cursor_4c_DTemp
8542:                     GO TOP
8543:                     IF VARTYPE(loc_oPgConsP) = "O"
8544:                         loc_oPgConsP.grd_4c_GrDTEMP.Refresh()
8545:                     ENDIF
8546:                 ENDIF
8547:             ENDIF
8548: 
8549:         CATCH TO loc_oErro
8550:             MsgErro(loc_oErro.Message, "Erro ao carregar ConsP")
8551:         ENDTRY
8552:     ENDPROC
8553: 
8554:     *==========================================================================
8555:     * GrdConsCol4KeyPress - F4 em Column4 (Fase) abre lookup SigCdPrf
8556:     *==========================================================================
8557:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8558:         LOCAL loc_oErro
8559:         TRY
8560:             IF par_nKeyCode = 115
8561:                 THIS.AbrirLookupFaseConsP()
8562:             ENDIF
8563:         CATCH TO loc_oErro
8564:             *-- Tolerado
8565:         ENDTRY
8566:     ENDPROC
8567: 
8568:     PROTECTED PROCEDURE AbrirLookupFaseConsP()
8569:         LOCAL loc_oBusca, loc_cGrupos, loc_cDescrs, loc_oPgConsP, loc_oGrd, loc_oErro
8570:         TRY
8571:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8572:                 RETURN
8573:             ENDIF
8574:             IF !this_lEmEdicao
8575:                 RETURN
8576:             ENDIF
8577:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8578:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8579:             loc_cGrupos  = ALLTRIM(loc_oGrd.Column4.Text1.Value)
8580:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", ;
8581:                 "cursor_4c_BuscaFase", "Grupos", loc_cGrupos, "Fase de Produ" + CHR(231) + CHR(227) + "o")
8582:             loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
8583:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
8584:             loc_oBusca.Show()
8585:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
8586:                 loc_cGrupos = ALLTRIM(cursor_4c_BuscaFase.Grupos)
8587:                 loc_cDescrs = ALLTRIM(cursor_4c_BuscaFase.Descrs)
8588:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8589:                     REPLACE cursor_4c_ConsP.Grupos WITH loc_cGrupos
8590:                     REPLACE cursor_4c_ConsP.Descrs WITH loc_cDescrs
8591:                 ENDIF
8592:                 loc_oGrd.Column4.Text1.Value = loc_cGrupos
8593:                 loc_oGrd.Column5.Text1.Value = loc_cDescrs
8594:                 loc_oGrd.Refresh()
8595:             ENDIF
8596:             IF USED("cursor_4c_BuscaFase")
8597:                 USE IN cursor_4c_BuscaFase
8598:             ENDIF
8599:             loc_oBusca.Release()
8600:         CATCH TO loc_oErro
8601:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
8602:         ENDTRY
8603:     ENDPROC
8604: 
8605:     *==========================================================================
8606:     * GrdConsCol5KeyPress - F4 em Column5 (Descricao fase) abre lookup SigCdPrf
8607:     *==========================================================================
8608:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8609:         LOCAL loc_oErro
8610:         TRY
8611:             IF par_nKeyCode = 115
8612:                 THIS.AbrirLookupFaseDescConsP()
8613:             ENDIF
8614:         CATCH TO loc_oErro
8615:             *-- Tolerado
8616:         ENDTRY
8617:     ENDPROC
8618: 
8619:     PROTECTED PROCEDURE AbrirLookupFaseDescConsP()
8620:         LOCAL loc_oBusca, loc_cGrupos, loc_cDescrs, loc_oPgConsP, loc_oGrd, loc_oErro
8621:         TRY
8622:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8623:                 RETURN
8624:             ENDIF
8625:             IF !this_lEmEdicao
8626:                 RETURN
8627:             ENDIF
8628:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8629:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8630:             loc_cDescrs  = ALLTRIM(loc_oGrd.Column5.Text1.Value)
8631:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", ;
8632:                 "cursor_4c_BuscaFaseDesc", "Descrs", loc_cDescrs, "Descri" + CHR(231) + CHR(227) + "o de Fase")
8633:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
8634:             loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
8635:             loc_oBusca.Show()
8636:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFaseDesc")
8637:                 loc_cGrupos = ALLTRIM(cursor_4c_BuscaFaseDesc.Grupos)
8638:                 loc_cDescrs = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
8639:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8640:                     REPLACE cursor_4c_ConsP.Grupos WITH loc_cGrupos
8641:                     REPLACE cursor_4c_ConsP.Descrs WITH loc_cDescrs
8642:                 ENDIF
8643:                 loc_oGrd.Column4.Text1.Value = loc_cGrupos
8644:                 loc_oGrd.Column5.Text1.Value = loc_cDescrs
8645:                 loc_oGrd.Refresh()
8646:             ENDIF
8647:             IF USED("cursor_4c_BuscaFaseDesc")
8648:                 USE IN cursor_4c_BuscaFaseDesc
8649:             ENDIF
8650:             loc_oBusca.Release()
8651:         CATCH TO loc_oErro
8652:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de descri" + CHR(231) + CHR(227) + "o de fase")
8653:         ENDTRY
8654:     ENDPROC
8655: 
8656:     *==========================================================================
8657:     * GrdConsCol8KeyPress - F4 em Column8 (Cat.) abre lookup SigCdCat
8658:     *==========================================================================
8659:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8660:         LOCAL loc_oErro
8661:         TRY
8662:             IF par_nKeyCode = 115
8663:                 THIS.AbrirLookupCatConsP()
8664:             ENDIF
8665:         CATCH TO loc_oErro
8666:             *-- Tolerado
8667:         ENDTRY
8668:     ENDPROC
8669: 
8670:     PROTECTED PROCEDURE AbrirLookupCatConsP()
8671:         LOCAL loc_oBusca, loc_cCods, loc_cDescs, loc_oPgConsP, loc_oGrd, loc_oErro
8672:         TRY
8673:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8674:                 RETURN
8675:             ENDIF
8676:             IF !this_lEmEdicao
8677:                 RETURN
8678:             ENDIF
8679:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8680:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8681:             loc_cCods    = ALLTRIM(loc_oGrd.Column8.Text1.Value)
8682:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", ;
8683:                 "cursor_4c_BuscaCat", "Cods", loc_cCods, "Categoria")
8684:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
8685:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
8686:             loc_oBusca.Show()
8687:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
8688:                 loc_cCods  = ALLTRIM(cursor_4c_BuscaCat.Cods)
8689:                 loc_cDescs = ALLTRIM(cursor_4c_BuscaCat.Descs)
8690:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8691:                     REPLACE cursor_4c_ConsP.Ccats WITH loc_cCods
8692:                     REPLACE cursor_4c_ConsP.DCats WITH loc_cDescs
8693:                 ENDIF
8694:                 loc_oGrd.Column8.Text1.Value = loc_cCods
8695:                 loc_oGrd.Column9.Text1.Value = loc_cDescs
8696:                 loc_oGrd.Refresh()
8697:             ENDIF
8698:             IF USED("cursor_4c_BuscaCat")
8699:                 USE IN cursor_4c_BuscaCat
8700:             ENDIF
8701:             loc_oBusca.Release()
8702:         CATCH TO loc_oErro
8703:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de categoria")
8704:         ENDTRY
8705:     ENDPROC
8706: 
8707:     *==========================================================================
8708:     * ConfigurarPgPgDadosFaseP - PgDadosFaseP (Page4 do pgf_4c_DadosInterno)
8709:     * GradFase (5 col), grdMatrizes (4 col), controles de produto
8710:     * Posicoes: original_top + 29
8711:     *==========================================================================
8712:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
8713:         LOCAL loc_oGrd, loc_oGrd2, loc_oErro
8714:         TRY
8715:             *-- === Cursores placeholder ANTES dos grids ===
8716:             SET NULL ON
8717:             IF USED("cursor_4c_PrfFase")
8718:                 USE IN cursor_4c_PrfFase
8719:             ENDIF
8720:             CREATE CURSOR cursor_4c_PrfFase (;
8721:                 CIdChaves C(20)  NULL, ;
8722:                 Ordems    N(2,0) NULL, ;
8723:                 Grupos    C(10)  NULL, ;
8724:                 Descrs    C(50)  NULL, ;
8725:                 UniPrdts  C(10)  NULL, ;
8726:                 MatPrdts  C(15)  NULL  ;
8727:             )
8728:             IF USED("cursor_4c_Mtz")
8729:                 USE IN cursor_4c_Mtz
8730:             ENDIF
8731:             CREATE CURSOR cursor_4c_Mtz (;
8732:                 CIdChaves C(20)  NULL, ;
8733:                 CMats     C(14)  NULL, ;
8734:                 DPros     C(65)  NULL, ;
8735:                 Locals    C(10)  NULL, ;
8736:                 Qtds      N(3,0) NULL  ;
8737:             )
8738:             SET NULL OFF
8739: 
8740:             *-- === Shape fundo imagem fase (shpFig, top=152+29=181, left=231, w=244, h=148) ===
8741:             par_oPage.AddObject("shp_4c_ShpFig", "Shape")
8742:             WITH par_oPage.shp_4c_ShpFig
8743:                 .Top    = 181
8744:                 .Left   = 231
8745:                 .Width  = 244
8746:                 .Height = 148
8747:                 .BackColor   = RGB(255,255,255)
8748:                 .BorderStyle = 1
8749:                 .Visible     = .T.
8750:             ENDWITH
8751: 
8752:             *-- === Imagem fase (ImgFigJpg, top=153+29=182, left=232, w=241, h=146) ===

*-- Linhas 9137 a 9240:
9137:             loc_oGrd.Column5.Width            = 75
9138:             loc_oGrd.Column5.Header1.FontBold = .T.
9139: 
9140:             *-- BINDEVENTs para GradFase
9141:             BINDEVENT(loc_oGrd,             "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
9142:             BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus",         THIS, "GradFaseCol1GotFocus")
9143:             BINDEVENT(loc_oGrd.Column1.Text1, "LostFocus",        THIS, "GradFaseCol1LostFocus")
9144:             BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress",         THIS, "GradFaseCol2KeyPress")
9145:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress",         THIS, "GradFaseCol4KeyPress")
9146:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress",         THIS, "GradFaseCol5KeyPress")
9147: 
9148:             *-- === Botao Incluir fase (inserir, top=152+29=181, left=950, w=40, h=40) ===
9149:             par_oPage.AddObject("cmd_4c_Incluir", "CommandButton")
9150:             WITH par_oPage.cmd_4c_Incluir
9151:                 .Top     = 181
9152:                 .Left   = 950
9153:                 .Width   = 40
9154:                 .Height = 40
9155:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9156:                 .Caption = ""
9157:                 .FontName = "Tahoma"
9158:                 .FontSize = 8
9159:                 .Themes  = .F.
9160:                 .Visible = .T.
9161:             ENDWITH
9162: 
9163:             *-- === Botao Excluir fase (excluir, top=192+29=221, left=950, w=40, h=40) ===
9164:             par_oPage.AddObject("cmd_4c_Excluir", "CommandButton")
9165:             WITH par_oPage.cmd_4c_Excluir
9166:                 .Top     = 221
9167:                 .Left   = 950
9168:                 .Width   = 40
9169:                 .Height = 40
9170:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
9171:                 .Caption = ""
9172:                 .FontName = "Tahoma"
9173:                 .FontSize = 8
9174:                 .Themes  = .F.
9175:                 .Visible = .T.
9176:             ENDWITH
9177: 
9178:             *-- === Botao Alternativa (Alternativa, top=232+29=261, left=950, w=40, h=40) ===
9179:             par_oPage.AddObject("cmd_4c_Alternativa", "CommandButton")
9180:             WITH par_oPage.cmd_4c_Alternativa
9181:                 .Top     = 261
9182:                 .Left   = 950
9183:                 .Width   = 40
9184:                 .Height = 40
9185:                 .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_26.jpg"
9186:                 .Caption = ""
9187:                 .FontName = "Tahoma"
9188:                 .FontSize = 8
9189:                 .Themes  = .F.
9190:                 .Visible = .T.
9191:             ENDWITH
9192: 
9193:             *-- BINDEVENTs para botoes do GradFase
9194:             BINDEVENT(par_oPage.cmd_4c_Incluir,    "Click", THIS, "FasePIncluirClick")
9195:             BINDEVENT(par_oPage.cmd_4c_Excluir,    "Click", THIS, "FasePExcluirClick")
9196:             BINDEVENT(par_oPage.cmd_4c_Alternativa,"Click", THIS, "FasePAlternativaClick")
9197:             BINDEVENT(par_oPage.cmd_4c_CmdFicha,   "Click", THIS, "FasePCmdFichaClick")
9198:             BINDEVENT(par_oPage.cmd_4c_CmdgFigura, "Click", THIS, "FasePCmdgFiguraClick")
9199:             BINDEVENT(par_oPage.cmd_4c_CmdgFigCam, "Click", THIS, "FasePCmdgFigCamClick")
9200:             BINDEVENT(par_oPage.img_4c_ImgFigJpg,  "Click", THIS, "FasePImgFigJpgClick")
9201: 
9202:             *-- === Label "Descricao :" (Say1, top=474+29=503, left=527, w=67, h=17) ===
9203:             par_oPage.AddObject("lbl_4c_Label1", "Label")
9204:             WITH par_oPage.lbl_4c_Label1
9205:                 .Top = 503
9206:                 .Left = 527
9207:                 .Width = 67
9208:                 .Height = 17
9209:                 .FontName = "Tahoma"
9210:                 .FontSize = 8
9211:                 .BackStyle = 0
9212:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
9213:                 .Visible = .T.
9214:             ENDWITH
9215: 
9216:             *-- === TextBox Desc (Get_Desc, top=471+29=500, left=595, w=395, h=23) ===
9217:             par_oPage.AddObject("txt_4c_Desc", "TextBox")
9218:             WITH par_oPage.txt_4c_Desc
9219:                 .Top = 500
9220:                 .Left = 595
9221:                 .Width = 395
9222:                 .Height = 23
9223:                 .FontName = "Tahoma"
9224:                 .FontSize = 8
9225:                 .Themes = .F.
9226:                 .Visible = .T.
9227:             ENDWITH
9228: 
9229:             *-- === EditBox Obs (Get_Obs, top=497+29=526, left=527, w=463, h=122) ===
9230:             par_oPage.AddObject("edt_4c_Get_Obs", "EditBox")
9231:             WITH par_oPage.edt_4c_Get_Obs
9232:                 .Top = 526
9233:                 .Left = 527
9234:                 .Width = 463
9235:                 .Height = 122
9236:                 .FontName = "Tahoma"
9237:                 .FontSize = 8
9238:                 .ScrollBars = 2
9239:                 .Themes = .F.
9240:                 .Visible = .T.

*-- Linhas 9256 a 9466:
9256:             loc_oGrd2.RowHeight   = 16
9257:             loc_oGrd2.ScrollBars  = 3
9258:             loc_oGrd2.Themes      = .F.
9259:             loc_oGrd2.Visible     = .T.
9260: 
9261:             loc_oGrd2.RecordSource = "cursor_4c_Mtz"
9262: 
9263:             loc_oGrd2.Column1.Header1.Caption  = "Matriz"
9264:             loc_oGrd2.Column1.ControlSource    = "cursor_4c_Mtz.CMats"
9265:             loc_oGrd2.Column1.Width            = 60
9266:             loc_oGrd2.Column1.Header1.FontBold = .T.
9267: 
9268:             loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
9269:             loc_oGrd2.Column2.ControlSource    = "cursor_4c_Mtz.DPros"
9270:             loc_oGrd2.Column2.Width            = 100
9271:             loc_oGrd2.Column2.ReadOnly         = .T.
9272:             loc_oGrd2.Column2.Header1.FontBold = .T.
9273: 
9274:             loc_oGrd2.Column3.Header1.Caption  = "Local"
9275:             loc_oGrd2.Column3.ControlSource    = "cursor_4c_Mtz.Locals"
9276:             loc_oGrd2.Column3.Width            = 50
9277:             loc_oGrd2.Column3.ReadOnly         = .T.
9278:             loc_oGrd2.Column3.Header1.FontBold = .T.
9279: 
9280:             loc_oGrd2.Column4.Header1.Caption  = "Qtde"
9281:             loc_oGrd2.Column4.ControlSource    = "cursor_4c_Mtz.Qtds"
9282:             loc_oGrd2.Column4.Width            = 36
9283:             loc_oGrd2.Column4.Header1.FontBold = .T.
9284: 
9285:             *-- BINDEVENTs para Matrizes
9286:             BINDEVENT(loc_oGrd2,              "AfterRowColChange", THIS, "MatrizesAfterRowColChange")
9287:             BINDEVENT(loc_oGrd2.Column1.Text1, "GotFocus",         THIS, "MatrizesCol1GotFocus")
9288:             BINDEVENT(loc_oGrd2.Column1.Text1, "KeyPress",         THIS, "MatrizesCol1KeyPress")
9289: 
9290:             *-- === Botao Inserir Matriz (btnInsereMtx, top=380+29=409, left=258, w=40, h=40) ===
9291:             par_oPage.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
9292:             WITH par_oPage.cmd_4c_BtnInsereMtx
9293:                 .Top     = 409
9294:                 .Left   = 258
9295:                 .Width   = 40
9296:                 .Height = 40
9297:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9298:                 .Caption = ""
9299:                 .FontName = "Tahoma"
9300:                 .FontSize = 8
9301:                 .Themes  = .F.
9302:                 .Visible = .T.
9303:             ENDWITH
9304: 
9305:             *-- === Botao Excluir Matriz (btnExcluiMtz, top=420+29=449, left=258, w=40, h=40) ===
9306:             par_oPage.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
9307:             WITH par_oPage.cmd_4c_BtnExcluiMtz
9308:                 .Top     = 449
9309:                 .Left   = 258
9310:                 .Width   = 40
9311:                 .Height = 40
9312:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
9313:                 .Caption = ""
9314:                 .FontName = "Tahoma"
9315:                 .FontSize = 8
9316:                 .Themes  = .F.
9317:                 .Visible = .T.
9318:             ENDWITH
9319: 
9320:             *-- BINDEVENTs botoes Matrizes
9321:             BINDEVENT(par_oPage.cmd_4c_BtnInsereMtx, "Click", THIS, "FasePBtnInsereMtxClick")
9322:             BINDEVENT(par_oPage.cmd_4c_BtnExcluiMtz, "Click", THIS, "FasePBtnExcluiMtzClick")
9323: 
9324:             *-- === Shape fundo borracha (shpBorracha, top=464+29=493, left=258, w=236, h=156) ===
9325:             par_oPage.AddObject("shp_4c_ShpBorracha", "Shape")
9326:             WITH par_oPage.shp_4c_ShpBorracha
9327:                 .Top    = 493
9328:                 .Left   = 258
9329:                 .Width  = 236
9330:                 .Height = 156
9331:                 .BackColor   = RGB(255,255,255)
9332:                 .BorderStyle = 1
9333:                 .Visible     = .T.
9334:             ENDWITH
9335: 
9336:             *-- === Imagem borracha/matriz (ImgBorracha, top=465+29=494, left=260, w=232, h=154) ===
9337:             par_oPage.AddObject("img_4c_ImgBorracha", "Image")
9338:             WITH par_oPage.img_4c_ImgBorracha
9339:                 .Top     = 494
9340:                 .Left    = 260
9341:                 .Width   = 232
9342:                 .Height  = 154
9343:                 .Stretch = 2
9344:                 .Visible = .F.
9345:             ENDWITH
9346: 
9347:             *-- BINDEVENTs controles de produto (FaseP)
9348:             BINDEVENT(par_oPage.txt_4c_codacb,   "KeyPress", THIS, "FasePCodAcbKeyPress")
9349:             BINDEVENT(par_oPage.txt_4c_Tam,       "KeyPress", THIS, "FasePTamKeyPress")
9350:             BINDEVENT(par_oPage.txt_4c_Cor,       "KeyPress", THIS, "FasePCorKeyPress")
9351:             BINDEVENT(par_oPage.txt_4c_Conquilha, "KeyPress", THIS, "FasePConquilhaKeyPress")
9352: 
9353:         CATCH TO loc_oErro
9354:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Fase P")
9355:         ENDTRY
9356:     ENDPROC
9357: 
9358:     *==========================================================================
9359:     * BOParaFormFaseP - Preenche controles da pagina FaseP com dados do BO
9360:     *==========================================================================
9361:     PROTECTED PROCEDURE BOParaFormFaseP()
9362:         LOCAL loc_oPgFaseP, loc_oBO, loc_oErro
9363:         TRY
9364:             loc_oBO     = this_oBusinessObject
9365:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9366: 
9367:             *-- Campos proprios da FaseP (SigCdPro)
9368:             loc_oPgFaseP.txt_4c_Qmin.Value         = NVL(loc_oBO.this_nQtMinFabs, 0)
9369:             loc_oPgFaseP.txt_4c_CodGarras.Value     = ALLTRIM(NVL(loc_oBO.this_cCodGarras, ""))
9370:             loc_oPgFaseP.txt_4c_Conquilha.Value     = ALLTRIM(NVL(loc_oBO.this_cConquilhas,""))
9371:             loc_oPgFaseP.txt_4c_PesoBris.Value      = NVL(loc_oBO.this_nPesoBris, 0)
9372:             loc_oPgFaseP.txt_4c_PesoMetal.Value     = NVL(loc_oBO.this_nPesoMetal, 0)
9373:             loc_oPgFaseP.txt_4c_PesoPdrs.Value      = NVL(loc_oBO.this_nPesoPdrs, 0)
9374:             loc_oPgFaseP.chk_4c_Opc_CravCera.Value  = IIF(IIF(VARTYPE(loc_oBO.this_nCravCers) = "L", loc_oBO.this_nCravCers, (NVL(loc_oBO.this_nCravCers, 0) = 1)), 1, 0)
9375:             loc_oPgFaseP.chk_4c_Fwoption1.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nVarias) = "L", loc_oBO.this_nVarias, (NVL(loc_oBO.this_nVarias, 0) = 1)), 1, 0)
9376: 
9377:             *-- Campos espelhados de PgDados (Cor, Tam, Acabamento)
9378:             loc_oPgFaseP.txt_4c_Cor.Value    = ALLTRIM(NVL(loc_oBO.this_cCorPros, ""))
9379:             loc_oPgFaseP.txt_4c_Tam.Value    = ALLTRIM(NVL(loc_oBO.this_cTams,    ""))
9380:             loc_oPgFaseP.txt_4c_codacb.Value = ALLTRIM(NVL(loc_oBO.this_cCodAcbs, ""))
9381: 
9382:             *-- Carregar descricao de acabamento via lookup
9383:             IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cCodAcbs, "")))
9384:                 THIS.CarregarDescricaoLookup("SigCdAca", "Cods", "Descrs", ;
9385:                     ALLTRIM(loc_oBO.this_cCodAcbs), loc_oPgFaseP.txt_4c_Dacb)
9386:             ELSE
9387:                 loc_oPgFaseP.txt_4c_Dacb.Value = ""
9388:             ENDIF
9389: 
9390:         CATCH TO loc_oErro
9391:             MsgErro(loc_oErro.Message, "Erro ao preencher campos Fase P")
9392:         ENDTRY
9393:     ENDPROC
9394: 
9395:     *==========================================================================
9396:     * FormParaBOFaseP - Le controles da pagina FaseP e envia para o BO
9397:     *==========================================================================
9398:     PROTECTED PROCEDURE FormParaBOFaseP()
9399:         LOCAL loc_oPgFaseP, loc_oBO, loc_oErro
9400:         TRY
9401:             loc_oBO      = this_oBusinessObject
9402:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9403: 
9404:             loc_oBO.this_nQtMinFabs  = STR(loc_oPgFaseP.txt_4c_Qmin.Value)
9405:             loc_oBO.this_cCodGarras  = ALLTRIM(loc_oPgFaseP.txt_4c_CodGarras.Value)
9406:             loc_oBO.this_cConquilhas = ALLTRIM(loc_oPgFaseP.txt_4c_Conquilha.Value)
9407:             loc_oBO.this_nPesoBris   = STR(loc_oPgFaseP.txt_4c_PesoBris.Value)
9408:             loc_oBO.this_nPesoMetal  = STR(loc_oPgFaseP.txt_4c_PesoMetal.Value)
9409:             loc_oBO.this_nPesoPdrs   = STR(loc_oPgFaseP.txt_4c_PesoPdrs.Value)
9410:             loc_oBO.this_nCravCers   = IIF(loc_oPgFaseP.chk_4c_Opc_CravCera.Value = 1, 1, 0)
9411:             loc_oBO.this_nVarias     = IIF(loc_oPgFaseP.chk_4c_Fwoption1.Value    = 1, 1, 0)
9412: 
9413:             *-- Campos espelhados (ultimas escritas vencem)
9414:             loc_oBO.this_cCorPros = ALLTRIM(loc_oPgFaseP.txt_4c_Cor.Value)
9415:             loc_oBO.this_cTams    = ALLTRIM(loc_oPgFaseP.txt_4c_Tam.Value)
9416:             loc_oBO.this_cCodAcbs = ALLTRIM(loc_oPgFaseP.txt_4c_codacb.Value)
9417: 
9418:         CATCH TO loc_oErro
9419:             MsgErro(loc_oErro.Message, "Erro ao ler campos Fase P")
9420:         ENDTRY
9421:     ENDPROC
9422: 
9423:     *==========================================================================
9424:     * CarregarFaseP - SQLEXEC SigCdPrf -> cursor_4c_PrfFase
9425:     *==========================================================================
9426:     PROCEDURE CarregarFaseP()
9427:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9428:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9429:             RETURN
9430:         ENDIF
9431:         loc_lContinuar = .T.
9432:         TRY
9433:             loc_cCPros = ALLTRIM(this_cCodigo)
9434:             IF EMPTY(loc_cCPros)
9435:                 loc_lContinuar = .F.
9436:             ENDIF
9437:             IF loc_lContinuar
9438:                 IF USED("cursor_4c_PrfFaseTemp")
9439:                     USE IN cursor_4c_PrfFaseTemp
9440:                 ENDIF
9441:                 loc_cSQL = "SELECT prf.CIdChaves, prf.Ordems, prf.Grupos, " + ;
9442:                            "ISNULL(gcr.Descrs,'') AS Descrs, " + ;
9443:                            "ISNULL(prf.UniPrdts,'') AS UniPrdts, " + ;
9444:                            "ISNULL(prf.MatPrdts,'') AS MatPrdts " + ;
9445:                            "FROM SigCdPrf prf " + ;
9446:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = prf.Grupos " + ;
9447:                            "WHERE prf.Produtos = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
9448:                            " ORDER BY prf.Ordems"
9449:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfFaseTemp")
9450:                 IF loc_nRet > 0
9451:                     SELECT cursor_4c_PrfFase
9452:                     ZAP
9453:                     IF RECCOUNT("cursor_4c_PrfFaseTemp") > 0
9454:                         APPEND FROM DBF("cursor_4c_PrfFaseTemp")
9455:                     ENDIF
9456:                     IF USED("cursor_4c_PrfFaseTemp")
9457:                         USE IN cursor_4c_PrfFaseTemp
9458:                     ENDIF
9459:                     SELECT cursor_4c_PrfFase
9460:                     GO TOP
9461:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9462:                     loc_oPgFaseP.grd_4c_GradFase.Refresh()
9463:                     *-- Carregar imagem da primeira linha
9464:                     THIS.GradFaseAfterRowColChange(0)
9465:                 ELSE
9466:                     IF USED("cursor_4c_PrfFaseTemp")

*-- Linhas 9472 a 9571:
9472:             MsgErro(loc_oErro.Message, "Erro ao carregar Fase P")
9473:         ENDTRY
9474:     ENDPROC
9475: 
9476:     *==========================================================================
9477:     * CarregarMatrizes - SQLEXEC sigprmtz -> cursor_4c_Mtz
9478:     *==========================================================================
9479:     PROCEDURE CarregarMatrizes()
9480:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9481:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9482:             RETURN
9483:         ENDIF
9484:         loc_lContinuar = .T.
9485:         TRY
9486:             loc_cCPros = ALLTRIM(this_cCodigo)
9487:             IF EMPTY(loc_cCPros)
9488:                 loc_lContinuar = .F.
9489:             ENDIF
9490:             IF loc_lContinuar
9491:                 IF USED("cursor_4c_MtzTemp")
9492:                     USE IN cursor_4c_MtzTemp
9493:                 ENDIF
9494:                 loc_cSQL = "SELECT mtz.CIdChaves, mtz.CMats, " + ;
9495:                            "ISNULL(pro.DPros,'') AS DPros, " + ;
9496:                            "ISNULL(pro.Locals,'') AS Locals, " + ;
9497:                            "ISNULL(mtz.Qtds,0) AS Qtds " + ;
9498:                            "FROM SigPrMtz mtz " + ;
9499:                            "LEFT JOIN SigCdPro pro ON pro.CPros = mtz.CMats " + ;
9500:                            "WHERE mtz.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
9501:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtzTemp")
9502:                 IF loc_nRet > 0
9503:                     SELECT cursor_4c_Mtz
9504:                     ZAP
9505:                     IF RECCOUNT("cursor_4c_MtzTemp") > 0
9506:                         APPEND FROM DBF("cursor_4c_MtzTemp")
9507:                     ENDIF
9508:                     IF USED("cursor_4c_MtzTemp")
9509:                         USE IN cursor_4c_MtzTemp
9510:                     ENDIF
9511:                     SELECT cursor_4c_Mtz
9512:                     GO TOP
9513:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9514:                     loc_oPgFaseP.grd_4c_Matrizes.Refresh()
9515:                     *-- Carregar imagem da primeira matriz
9516:                     THIS.MatrizesAfterRowColChange(0)
9517:                 ELSE
9518:                     IF USED("cursor_4c_MtzTemp")
9519:                         USE IN cursor_4c_MtzTemp
9520:                     ENDIF
9521:                 ENDIF
9522:             ENDIF
9523:         CATCH TO loc_oErro
9524:             MsgErro(loc_oErro.Message, "Erro ao carregar Matrizes")
9525:         ENDTRY
9526:     ENDPROC
9527: 
9528:     *==========================================================================
9529:     * GradFaseAfterRowColChange - Carrega imagem FigProcs da linha atual
9530:     *==========================================================================
9531:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9532:         LOCAL loc_oPgFaseP, loc_cCIdChaves, loc_cArquivo, loc_nRet, loc_oErro
9533:         TRY
9534:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9535:                 RETURN
9536:             ENDIF
9537:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9538:             loc_oPgFaseP.img_4c_ImgFigJpg.Picture = ""
9539:             loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .F.
9540:             loc_oPgFaseP.txt_4c_Desc.Value    = ""
9541:             loc_oPgFaseP.edt_4c_Get_Obs.Value = ""
9542:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase") OR BOF("cursor_4c_PrfFase")
9543:                 RETURN
9544:             ENDIF
9545:             SELECT cursor_4c_PrfFase
9546:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9547:             *-- Preencher descricao da fase atual (ja carregada no cursor)
9548:             loc_oPgFaseP.txt_4c_Desc.Value = ALLTRIM(NVL(Descrs, ""))
9549:             IF EMPTY(loc_cCIdChaves)
9550:                 RETURN
9551:             ENDIF
9552:             *-- Carregar FigProcs e Obs do banco
9553:             IF USED("cursor_4c_FigPrfTmp")
9554:                 USE IN cursor_4c_FigPrfTmp
9555:             ENDIF
9556:             loc_nRet = SQLEXEC(gnConnHandle, ;
9557:                 "SELECT FigProcs, CONVERT(NVARCHAR(MAX), obs) AS ObsText " + ;
9558:                 "FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves), ;
9559:                 "cursor_4c_FigPrfTmp")
9560:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_FigPrfTmp") > 0
9561:                 SELECT cursor_4c_FigPrfTmp
9562:                 *-- Preencher obs
9563:                 IF !ISNULL(ObsText)
9564:                     loc_oPgFaseP.edt_4c_Get_Obs.Value = ALLTRIM(ObsText)
9565:                 ENDIF
9566:                 *-- Exibir imagem
9567:                 IF !EMPTY(FigProcs) AND !ISNULL(FigProcs)
9568:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9569:                     IF STRTOFILE(FigProcs, loc_cArquivo) > 0
9570:                         loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9571:                         loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArquivo

*-- Linhas 9583 a 10465:
9583:     *==========================================================================
9584:     * GradFaseCol1GotFocus - Salva valor anterior de Ordems para reordenacao
9585:     *==========================================================================
9586:     PROCEDURE GradFaseCol1GotFocus()
9587:         LOCAL loc_oErro
9588:         TRY
9589:             IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9590:                 SELECT cursor_4c_PrfFase
9591:                 this_nAntOrd = NVL(Ordems, 0)
9592:             ENDIF
9593:         CATCH TO loc_oErro
9594:             *-- Tolerado
9595:         ENDTRY
9596:     ENDPROC
9597: 
9598:     *==========================================================================
9599:     * GradFaseCol1LostFocus - Aplica reordenacao se Ordems mudou
9600:     *==========================================================================
9601:     PROCEDURE GradFaseCol1LostFocus()
9602:         LOCAL loc_nNovoOrd, loc_cCIdChaves, loc_nRet, loc_oErro
9603:         TRY
9604:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9605:                 RETURN
9606:             ENDIF
9607:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9608:                 RETURN
9609:             ENDIF
9610:             SELECT cursor_4c_PrfFase
9611:             loc_nNovoOrd   = NVL(Ordems, 0)
9612:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9613:             IF loc_nNovoOrd > 0 AND loc_nNovoOrd <> this_nAntOrd AND !EMPTY(loc_cCIdChaves)
9614:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9615:                     "UPDATE SigCdPrf SET Ordems = " + FormatarNumeroSQL(loc_nNovoOrd) + ;
9616:                     " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9617:                 THIS.CarregarFaseP()
9618:             ENDIF
9619:         CATCH TO loc_oErro
9620:             MsgErro(loc_oErro.Message, "Erro ao reordenar fase")
9621:         ENDTRY
9622:     ENDPROC
9623: 
9624:     *==========================================================================
9625:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr)
9626:     *==========================================================================
9627:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9628:         LOCAL loc_oErro
9629:         TRY
9630:             IF par_nKeyCode = 115
9631:                 THIS.AbrirLookupGradFaseFase()
9632:             ENDIF
9633:         CATCH TO loc_oErro
9634:             *-- Tolerado
9635:         ENDTRY
9636:     ENDPROC
9637: 
9638:     *==========================================================================
9639:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9640:     *==========================================================================
9641:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9642:         LOCAL loc_oErro
9643:         TRY
9644:             IF par_nKeyCode = 115
9645:                 THIS.AbrirLookupGradFaseUpd()
9646:             ENDIF
9647:         CATCH TO loc_oErro
9648:             *-- Tolerado
9649:         ENDTRY
9650:     ENDPROC
9651: 
9652:     *==========================================================================
9653:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt)
9654:     *==========================================================================
9655:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9656:         LOCAL loc_oErro
9657:         TRY
9658:             IF par_nKeyCode = 115
9659:                 THIS.AbrirLookupGradFaseOpt()
9660:             ENDIF
9661:         CATCH TO loc_oErro
9662:             *-- Tolerado
9663:         ENDTRY
9664:     ENDPROC
9665: 
9666:     *==========================================================================
9667:     * FasePIncluirClick - Insere nova linha em GradFase (SigCdPrf)
9668:     *==========================================================================
9669:     PROCEDURE FasePIncluirClick()
9670:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar, loc_cGrupos, loc_nOrdems
9671:         loc_lContinuar = .T.
9672:         TRY
9673:             IF !this_lEmEdicao
9674:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9675:                 loc_lContinuar = .F.
9676:             ENDIF
9677:             IF loc_lContinuar
9678:                 loc_cCPros = ALLTRIM(this_cCodigo)
9679:                 IF EMPTY(loc_cCPros)
9680:                     MsgAviso("Salve o produto antes de adicionar fases.", "Aviso")
9681:                     loc_lContinuar = .F.
9682:                 ENDIF
9683:             ENDIF
9684:             IF loc_lContinuar AND gnConnHandle > 0
9685:                 *-- Calcular proximo Ordems
9686:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9687:                     SELECT cursor_4c_PrfFase
9688:                     loc_cGrupos = ALLTRIM(Grupos)
9689:                     GO BOTTOM
9690:                     loc_nOrdems = NVL(Ordems, 0) + 1
9691:                     GO TOP
9692:                 ELSE
9693:                     loc_cGrupos = ""
9694:                     loc_nOrdems = 1
9695:                 ENDIF
9696:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9697:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9698:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9699:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9700:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9701:                 IF loc_nRet < 1
9702:                     MsgErro("Erro ao incluir linha de fase.", "Erro")
9703:                 ELSE
9704:                     THIS.CarregarFaseP()
9705:                     *-- Posicionar na nova linha (ultima)
9706:                     IF USED("cursor_4c_PrfFase")
9707:                         SELECT cursor_4c_PrfFase
9708:                         GO BOTTOM
9709:                     ENDIF
9710:                 ENDIF
9711:             ENDIF
9712:         CATCH TO loc_oErro
9713:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9714:         ENDTRY
9715:     ENDPROC
9716: 
9717:     *==========================================================================
9718:     * FasePExcluirClick - Exclui linha atual de GradFase (SigCdPrf)
9719:     *==========================================================================
9720:     PROCEDURE FasePExcluirClick()
9721:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
9722:         loc_lContinuar = .T.
9723:         TRY
9724:             IF !this_lEmEdicao
9725:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9726:                 loc_lContinuar = .F.
9727:             ENDIF
9728:             IF loc_lContinuar
9729:                 IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase") OR BOF("cursor_4c_PrfFase")
9730:                     loc_lContinuar = .F.
9731:                 ENDIF
9732:             ENDIF
9733:             IF loc_lContinuar
9734:                 SELECT cursor_4c_PrfFase
9735:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9736:                 IF EMPTY(loc_cCIdChaves)
9737:                     loc_lContinuar = .F.
9738:                 ENDIF
9739:             ENDIF
9740:             IF loc_lContinuar
9741:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta fase?", "Confirmar")
9742:                 IF loc_lConfirmou AND gnConnHandle > 0
9743:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9744:                         "DELETE FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9745:                     THIS.CarregarFaseP()
9746:                 ENDIF
9747:             ENDIF
9748:         CATCH TO loc_oErro
9749:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9750:         ENDTRY
9751:     ENDPROC
9752: 
9753:     *==========================================================================
9754:     * FasePAlternativaClick - Insere fase alternativa (copia grupos da atual)
9755:     *==========================================================================
9756:     PROCEDURE FasePAlternativaClick()
9757:         LOCAL loc_nRet, loc_cCPros, loc_cGrupos, loc_nOrdems, loc_oErro, loc_lContinuar
9758:         loc_lContinuar = .T.
9759:         TRY
9760:             IF !this_lEmEdicao
9761:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9762:                 loc_lContinuar = .F.
9763:             ENDIF
9764:             IF loc_lContinuar
9765:                 loc_cCPros = ALLTRIM(this_cCodigo)
9766:                 IF EMPTY(loc_cCPros)
9767:                     loc_lContinuar = .F.
9768:                 ENDIF
9769:             ENDIF
9770:             IF loc_lContinuar
9771:                 IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9772:                     MsgAviso("Selecione uma fase antes de inserir alternativa.", "Aviso")
9773:                     loc_lContinuar = .F.
9774:                 ENDIF
9775:             ENDIF
9776:             IF loc_lContinuar AND gnConnHandle > 0
9777:                 SELECT cursor_4c_PrfFase
9778:                 loc_cGrupos = ALLTRIM(Grupos)
9779:                 loc_nOrdems = NVL(Ordems, 0)
9780:                 *-- Inserir alternativa logo apos a atual (Ordems atual + 0.5 => usa Ordems+1 e reordena depois)
9781:                 GO BOTTOM
9782:                 loc_nOrdems = NVL(Ordems, 0) + 1
9783:                 GO TOP
9784:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9785:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9786:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9787:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9788:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9789:                 IF loc_nRet < 1
9790:                     MsgErro("Erro ao incluir alternativa de fase.", "Erro")
9791:                 ELSE
9792:                     THIS.CarregarFaseP()
9793:                     IF USED("cursor_4c_PrfFase")
9794:                         SELECT cursor_4c_PrfFase
9795:                         GO BOTTOM
9796:                     ENDIF
9797:                 ENDIF
9798:             ENDIF
9799:         CATCH TO loc_oErro
9800:             MsgErro(loc_oErro.Message, "Erro ao incluir alternativa de fase")
9801:         ENDTRY
9802:     ENDPROC
9803: 
9804:     *==========================================================================
9805:     * FasePCmdFichaClick - Ficha tecnica da fase (relatorio legado)
9806:     *==========================================================================
9807:     PROCEDURE FasePCmdFichaClick()
9808:         LOCAL loc_oErro
9809:         TRY
9810:             MsgInfo("Ficha T" + CHR(233) + "cnica: funcionalidade dispon" + CHR(237) + "vel no sistema legado.", "Informa" + CHR(231) + CHR(227) + "o")
9811:         CATCH TO loc_oErro
9812:             *-- Tolerado
9813:         ENDTRY
9814:     ENDPROC
9815: 
9816:     *==========================================================================
9817:     * FasePImgFigJpgClick - Exibe imagem em tamanho ampliado
9818:     *==========================================================================
9819:     PROCEDURE FasePImgFigJpgClick()
9820:         LOCAL loc_oPgFaseP, loc_cArquivo, loc_oErro
9821:         TRY
9822:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9823:             loc_cArquivo = loc_oPgFaseP.img_4c_ImgFigJpg.Picture
9824:             IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
9825:                 ShellExecute(0, "open", loc_cArquivo, "", "", 1)
9826:             ENDIF
9827:         CATCH TO loc_oErro
9828:             *-- Tolerado
9829:         ENDTRY
9830:     ENDPROC
9831: 
9832:     *==========================================================================
9833:     * FasePCmdgFiguraClick - Selecionar imagem JPG/BMP para a fase
9834:     *==========================================================================
9835:     PROCEDURE FasePCmdgFiguraClick()
9836:         LOCAL loc_cArquivo, loc_cDados, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oErro
9837:         LOCAL loc_lContinuar, loc_cArqTemp
9838:         loc_lContinuar = .T.
9839:         TRY
9840:             IF !this_lEmEdicao
9841:                 loc_lContinuar = .F.
9842:             ENDIF
9843:             IF loc_lContinuar
9844:                 IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9845:                     loc_lContinuar = .F.
9846:                 ENDIF
9847:             ENDIF
9848:             IF loc_lContinuar
9849:                 SELECT cursor_4c_PrfFase
9850:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9851:                 IF EMPTY(loc_cCIdChaves)
9852:                     loc_lContinuar = .F.
9853:                 ENDIF
9854:             ENDIF
9855:             IF loc_lContinuar AND gnConnHandle > 0
9856:                 loc_cArquivo = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar imagem")
9857:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
9858:                     loc_cDados = FILETOSTR(loc_cArquivo)
9859:                     IF !EMPTY(loc_cDados)
9860:                         loc_nRet = SQLEXEC(gnConnHandle, ;
9861:                             "UPDATE SigCdPrf SET FigProcs = " + EscaparSQL(loc_cDados) + ;
9862:                             " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9863:                         IF loc_nRet > 0
9864:                             *-- Exibir imagem
9865:                             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9866:                             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
9867:                             IF STRTOFILE(loc_cDados, loc_cArqTemp) > 0
9868:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9869:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArqTemp
9870:                             ENDIF
9871:                         ENDIF
9872:                     ENDIF
9873:                 ENDIF
9874:             ENDIF
9875:         CATCH TO loc_oErro
9876:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da fase")
9877:         ENDTRY
9878:     ENDPROC
9879: 
9880:     *==========================================================================
9881:     * FasePCmdgFigCamClick - Captura de imagem via camera
9882:     *==========================================================================
9883:     PROCEDURE FasePCmdgFigCamClick()
9884:         LOCAL loc_oErro
9885:         TRY
9886:             MsgInfo("Captura de imagem por c" + CHR(226) + "mera n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Informa" + CHR(231) + CHR(227) + "o")
9887:         CATCH TO loc_oErro
9888:             *-- Tolerado
9889:         ENDTRY
9890:     ENDPROC
9891: 
9892:     *==========================================================================
9893:     * MatrizesAfterRowColChange - Carrega imagem borracha da matriz atual
9894:     *==========================================================================
9895:     PROCEDURE MatrizesAfterRowColChange(par_nColIndex)
9896:         LOCAL loc_oPgFaseP, loc_cCMats, loc_nRet, loc_oErro, loc_cArquivo
9897:         TRY
9898:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9899:                 RETURN
9900:             ENDIF
9901:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9902:             loc_oPgFaseP.img_4c_ImgBorracha.Picture = ""
9903:             loc_oPgFaseP.img_4c_ImgBorracha.Visible = .F.
9904:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz") OR BOF("cursor_4c_Mtz")
9905:                 RETURN
9906:             ENDIF
9907:             SELECT cursor_4c_Mtz
9908:             loc_cCMats = ALLTRIM(CMats)
9909:             IF EMPTY(loc_cCMats)
9910:                 RETURN
9911:             ENDIF
9912:             *-- Buscar imagem do produto matriz
9913:             IF USED("cursor_4c_MtzImgTmp")
9914:                 USE IN cursor_4c_MtzImgTmp
9915:             ENDIF
9916:             loc_nRet = SQLEXEC(gnConnHandle, ;
9917:                 "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(PADR(loc_cCMats, 14)), ;
9918:                 "cursor_4c_MtzImgTmp")
9919:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_MtzImgTmp") > 0
9920:                 SELECT cursor_4c_MtzImgTmp
9921:                 IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
9922:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9923:                     IF STRTOFILE(FigJpgs, loc_cArquivo) > 0
9924:                         loc_oPgFaseP.img_4c_ImgBorracha.Visible = .T.
9925:                         loc_oPgFaseP.img_4c_ImgBorracha.Picture = loc_cArquivo
9926:                     ENDIF
9927:                 ENDIF
9928:             ENDIF
9929:             IF USED("cursor_4c_MtzImgTmp")
9930:                 USE IN cursor_4c_MtzImgTmp
9931:             ENDIF
9932:         CATCH TO loc_oErro
9933:             *-- Tolerado: exibicao de imagem nao critica
9934:         ENDTRY
9935:     ENDPROC
9936: 
9937:     *==========================================================================
9938:     * MatrizesCol1GotFocus - Salva valor anterior de CMats para validacao
9939:     *==========================================================================
9940:     PROCEDURE MatrizesCol1GotFocus()
9941:         LOCAL loc_oGrd2, loc_oErro, loc_oPgFaseP
9942:         TRY
9943:             IF USED("cursor_4c_Mtz") AND !EOF("cursor_4c_Mtz")
9944:                 loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9945:                 loc_oGrd2 = loc_oPgFaseP.grd_4c_Matrizes
9946:                 loc_oGrd2.Column1.Text1.Tag = PADR(loc_oGrd2.Column1.Text1.Value, 14)
9947:             ENDIF
9948:         CATCH TO loc_oErro
9949:             *-- Tolerado
9950:         ENDTRY
9951:     ENDPROC
9952: 
9953:     *==========================================================================
9954:     * MatrizesCol1KeyPress - F4 abre lookup de Produto-Matriz (SigCdPro)
9955:     *==========================================================================
9956:     PROCEDURE MatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9957:         LOCAL loc_oErro
9958:         TRY
9959:             IF par_nKeyCode = 115
9960:                 THIS.AbrirLookupMatrizesCol1()
9961:             ENDIF
9962:         CATCH TO loc_oErro
9963:             *-- Tolerado
9964:         ENDTRY
9965:     ENDPROC
9966: 
9967:     *==========================================================================
9968:     * FasePBtnInsereMtxClick - Insere nova linha em grdMatrizes (SigPrMtz)
9969:     *==========================================================================
9970:     PROCEDURE FasePBtnInsereMtxClick()
9971:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar
9972:         loc_lContinuar = .T.
9973:         TRY
9974:             IF !this_lEmEdicao
9975:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9976:                 loc_lContinuar = .F.
9977:             ENDIF
9978:             IF loc_lContinuar
9979:                 loc_cCPros = ALLTRIM(this_cCodigo)
9980:                 IF EMPTY(loc_cCPros)
9981:                     loc_lContinuar = .F.
9982:                 ENDIF
9983:             ENDIF
9984:             IF loc_lContinuar AND gnConnHandle > 0
9985:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9986:                     "INSERT INTO SigPrMtz (CPros, CMats, Qtds, CIdChaves) VALUES (" + ;
9987:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", '', 0, NEWID())")
9988:                 IF loc_nRet < 1
9989:                     MsgErro("Erro ao incluir linha de matriz.", "Erro")
9990:                 ELSE
9991:                     THIS.CarregarMatrizes()
9992:                     IF USED("cursor_4c_Mtz")
9993:                         SELECT cursor_4c_Mtz
9994:                         GO BOTTOM
9995:                     ENDIF
9996:                 ENDIF
9997:             ENDIF
9998:         CATCH TO loc_oErro
9999:             MsgErro(loc_oErro.Message, "Erro ao incluir matriz")
10000:         ENDTRY
10001:     ENDPROC
10002: 
10003:     *==========================================================================
10004:     * FasePBtnExcluiMtzClick - Exclui linha atual de grdMatrizes (SigPrMtz)
10005:     *==========================================================================
10006:     PROCEDURE FasePBtnExcluiMtzClick()
10007:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
10008:         loc_lContinuar = .T.
10009:         TRY
10010:             IF !this_lEmEdicao
10011:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
10012:                 loc_lContinuar = .F.
10013:             ENDIF
10014:             IF loc_lContinuar
10015:                 IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz") OR BOF("cursor_4c_Mtz")
10016:                     loc_lContinuar = .F.
10017:                 ENDIF
10018:             ENDIF
10019:             IF loc_lContinuar
10020:                 SELECT cursor_4c_Mtz
10021:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
10022:                 IF EMPTY(loc_cCIdChaves)
10023:                     loc_lContinuar = .F.
10024:                 ENDIF
10025:             ENDIF
10026:             IF loc_lContinuar
10027:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta matriz?", "Confirmar")
10028:                 IF loc_lConfirmou AND gnConnHandle > 0
10029:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10030:                         "DELETE FROM SigPrMtz WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10031:                     THIS.CarregarMatrizes()
10032:                 ENDIF
10033:             ENDIF
10034:         CATCH TO loc_oErro
10035:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
10036:         ENDTRY
10037:     ENDPROC
10038: 
10039:     *==========================================================================
10040:     * FasePCodAcbKeyPress - F4 abre lookup de Acabamento (SigCdAca)
10041:     *==========================================================================
10042:     PROCEDURE FasePCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10043:         LOCAL loc_oErro
10044:         TRY
10045:             IF par_nKeyCode = 115
10046:                 THIS.AbrirLookupCodAcbFaseP()
10047:             ENDIF
10048:         CATCH TO loc_oErro
10049:             *-- Tolerado
10050:         ENDTRY
10051:     ENDPROC
10052: 
10053:     *==========================================================================
10054:     * FasePTamKeyPress - F4 abre lookup de Tamanho (SigCdTam)
10055:     *==========================================================================
10056:     PROCEDURE FasePTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10057:         LOCAL loc_oErro
10058:         TRY
10059:             IF par_nKeyCode = 115
10060:                 THIS.AbrirLookupTamFaseP()
10061:             ENDIF
10062:         CATCH TO loc_oErro
10063:             *-- Tolerado
10064:         ENDTRY
10065:     ENDPROC
10066: 
10067:     *==========================================================================
10068:     * FasePCorKeyPress - F4 abre lookup de Cor (SigCdCor)
10069:     *==========================================================================
10070:     PROCEDURE FasePCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10071:         LOCAL loc_oErro
10072:         TRY
10073:             IF par_nKeyCode = 115
10074:                 THIS.AbrirLookupCorFaseP()
10075:             ENDIF
10076:         CATCH TO loc_oErro
10077:             *-- Tolerado
10078:         ENDTRY
10079:     ENDPROC
10080: 
10081:     *==========================================================================
10082:     * FasePConquilhaKeyPress - F4 abre lookup de Conquilha (SigCdCnq)
10083:     *==========================================================================
10084:     PROCEDURE FasePConquilhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10085:         LOCAL loc_oErro
10086:         TRY
10087:             IF par_nKeyCode = 115
10088:                 THIS.AbrirLookupConquilhaFaseP()
10089:             ENDIF
10090:         CATCH TO loc_oErro
10091:             *-- Tolerado
10092:         ENDTRY
10093:     ENDPROC
10094: 
10095:     *==========================================================================
10096:     * AbrirLookupGradFaseFase - Lookup SigCdGcr para Column2 (Grupos/Fase)
10097:     *==========================================================================
10098:     PROTECTED PROCEDURE AbrirLookupGradFaseFase()
10099:         LOCAL loc_oBusca, loc_cCodigos, loc_cDescrs, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10100:         TRY
10101:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10102:                 RETURN
10103:             ENDIF
10104:             IF !this_lEmEdicao
10105:                 RETURN
10106:             ENDIF
10107:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10108:                 RETURN
10109:             ENDIF
10110:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10111:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10112:             loc_cCodigos   = ALLTRIM(loc_oGrd.Column2.Text1.Value)
10113:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10114:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
10115:                 "cursor_4c_BuscaGcr", "Codigos", loc_cCodigos, "Fase de Produ" + CHR(231) + CHR(227) + "o")
10116:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10117:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10118:             loc_oBusca.Show()
10119:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
10120:                 loc_cCodigos = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
10121:                 loc_cDescrs  = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
10122:                 *-- Atualizar cursor e DB
10123:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10124:                     REPLACE cursor_4c_PrfFase.Grupos WITH PADR(loc_cCodigos, 10)
10125:                     REPLACE cursor_4c_PrfFase.Descrs WITH PADR(loc_cDescrs,  50)
10126:                 ENDIF
10127:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10128:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10129:                         "UPDATE SigCdPrf SET Grupos = " + EscaparSQL(PADR(loc_cCodigos, 10)) + ;
10130:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10131:                 ENDIF
10132:                 loc_oGrd.Column2.Text1.Value = loc_cCodigos
10133:                 loc_oGrd.Column3.Text1.Value = loc_cDescrs
10134:                 loc_oGrd.Refresh()
10135:             ENDIF
10136:             IF USED("cursor_4c_BuscaGcr")
10137:                 USE IN cursor_4c_BuscaGcr
10138:             ENDIF
10139:             loc_oBusca.Release()
10140:         CATCH TO loc_oErro
10141:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
10142:         ENDTRY
10143:     ENDPROC
10144: 
10145:     *==========================================================================
10146:     * AbrirLookupGradFaseUpd - Lookup SigCdUpd para Column4 (UniPrdts)
10147:     *==========================================================================
10148:     PROTECTED PROCEDURE AbrirLookupGradFaseUpd()
10149:         LOCAL loc_oBusca, loc_cUniPrdts, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10150:         TRY
10151:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10152:                 RETURN
10153:             ENDIF
10154:             IF !this_lEmEdicao
10155:                 RETURN
10156:             ENDIF
10157:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10158:                 RETURN
10159:             ENDIF
10160:             LOCAL loc_cGruposUpd
10161:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10162:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10163:             loc_cUniPrdts  = ALLTRIM(loc_oGrd.Column4.Text1.Value)
10164:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10165:             loc_cGruposUpd = ALLTRIM(cursor_4c_PrfFase.Grupos)
10166:             *-- Filtrar por Codigos = Grupos atual (conforme legado)
10167:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUpd", ;
10168:                 "cursor_4c_BuscaUpd", "UniPrdts", loc_cUniPrdts, "Unidade Produtiva", ;
10169:                 .F., .F., "Codigos = " + EscaparSQL(PADR(loc_cGruposUpd, 10)))
10170:             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
10171:             loc_oBusca.Show()
10172:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
10173:                 loc_cUniPrdts = ALLTRIM(cursor_4c_BuscaUpd.UniPrdts)
10174:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10175:                     REPLACE cursor_4c_PrfFase.UniPrdts WITH PADR(loc_cUniPrdts, 10)
10176:                 ENDIF
10177:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10178:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10179:                         "UPDATE SigCdPrf SET UniPrdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
10180:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10181:                 ENDIF
10182:                 loc_oGrd.Column4.Text1.Value = loc_cUniPrdts
10183:                 loc_oGrd.Refresh()
10184:             ENDIF
10185:             IF USED("cursor_4c_BuscaUpd")
10186:                 USE IN cursor_4c_BuscaUpd
10187:             ENDIF
10188:             loc_oBusca.Release()
10189:         CATCH TO loc_oErro
10190:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de unidade produtiva")
10191:         ENDTRY
10192:     ENDPROC
10193: 
10194:     *==========================================================================
10195:     * AbrirLookupGradFaseOpt - Lookup SigOpOpt para Column5 (MatPrdts)
10196:     *==========================================================================
10197:     PROTECTED PROCEDURE AbrirLookupGradFaseOpt()
10198:         LOCAL loc_oBusca, loc_cMatPrdts, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10199:         TRY
10200:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10201:                 RETURN
10202:             ENDIF
10203:             IF !this_lEmEdicao
10204:                 RETURN
10205:             ENDIF
10206:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10207:                 RETURN
10208:             ENDIF
10209:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10210:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10211:             loc_cMatPrdts  = ALLTRIM(loc_oGrd.Column5.Text1.Value)
10212:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10213:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpOpt", ;
10214:                 "cursor_4c_BuscaOpt", "Cods", loc_cMatPrdts, "Tipo de Material")
10215:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10216:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10217:             loc_oBusca.Show()
10218:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
10219:                 loc_cMatPrdts = ALLTRIM(cursor_4c_BuscaOpt.Cods)
10220:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10221:                     REPLACE cursor_4c_PrfFase.MatPrdts WITH PADR(loc_cMatPrdts, 15)
10222:                 ENDIF
10223:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10224:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10225:                         "UPDATE SigCdPrf SET MatPrdts = " + EscaparSQL(PADR(loc_cMatPrdts, 15)) + ;
10226:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10227:                 ENDIF
10228:                 loc_oGrd.Column5.Text1.Value = loc_cMatPrdts
10229:                 loc_oGrd.Refresh()
10230:             ENDIF
10231:             IF USED("cursor_4c_BuscaOpt")
10232:                 USE IN cursor_4c_BuscaOpt
10233:             ENDIF
10234:             loc_oBusca.Release()
10235:         CATCH TO loc_oErro
10236:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de material")
10237:         ENDTRY
10238:     ENDPROC
10239: 
10240:     *==========================================================================
10241:     * AbrirLookupMatrizesCol1 - Lookup SigCdPro para Column1 de grdMatrizes
10242:     *==========================================================================
10243:     PROTECTED PROCEDURE AbrirLookupMatrizesCol1()
10244:         LOCAL loc_oBusca, loc_cCMats, loc_cDPros, loc_cLocals, loc_cCIdChaves, loc_nRet
10245:         LOCAL loc_oPgFaseP, loc_oGrd2, loc_oErro
10246:         TRY
10247:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10248:                 RETURN
10249:             ENDIF
10250:             IF !this_lEmEdicao
10251:                 RETURN
10252:             ENDIF
10253:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz")
10254:                 RETURN
10255:             ENDIF
10256:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10257:             loc_oGrd2      = loc_oPgFaseP.grd_4c_Matrizes
10258:             loc_cCMats     = ALLTRIM(loc_oGrd2.Column1.Text1.Value)
10259:             loc_cCIdChaves = ALLTRIM(cursor_4c_Mtz.CIdChaves)
10260:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
10261:                 "cursor_4c_BuscaMtz", "CPros", loc_cCMats, "Produto Matriz")
10262:             loc_oBusca.mAddColuna("CPros",  "", "Matriz")
10263:             loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
10264:             loc_oBusca.mAddColuna("Locals", "", "Local")
10265:             loc_oBusca.Show()
10266:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
10267:                 loc_cCMats  = ALLTRIM(cursor_4c_BuscaMtz.CPros)
10268:                 loc_cDPros  = ALLTRIM(cursor_4c_BuscaMtz.DPros)
10269:                 loc_cLocals = ALLTRIM(cursor_4c_BuscaMtz.Locals)
10270:                 IF USED("cursor_4c_Mtz") AND !EOF("cursor_4c_Mtz")
10271:                     REPLACE cursor_4c_Mtz.CMats  WITH PADR(loc_cCMats,  14)
10272:                     REPLACE cursor_4c_Mtz.DPros  WITH PADR(loc_cDPros,  65)
10273:                     REPLACE cursor_4c_Mtz.Locals WITH PADR(loc_cLocals, 10)
10274:                 ENDIF
10275:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10276:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10277:                         "UPDATE SigPrMtz SET CMats = " + EscaparSQL(PADR(loc_cCMats, 14)) + ;
10278:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10279:                 ENDIF
10280:                 loc_oGrd2.Column1.Text1.Value = loc_cCMats
10281:                 loc_oGrd2.Column2.Text1.Value = loc_cDPros
10282:                 loc_oGrd2.Column3.Text1.Value = loc_cLocals
10283:                 loc_oGrd2.Refresh()
10284:                 THIS.MatrizesAfterRowColChange(0)
10285:             ENDIF
10286:             IF USED("cursor_4c_BuscaMtz")
10287:                 USE IN cursor_4c_BuscaMtz
10288:             ENDIF
10289:             loc_oBusca.Release()
10290:         CATCH TO loc_oErro
10291:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de matriz")
10292:         ENDTRY
10293:     ENDPROC
10294: 
10295:     *==========================================================================
10296:     * AbrirLookupCodAcbFaseP - Lookup SigCdAca para txt_4c_codacb
10297:     *==========================================================================
10298:     PROTECTED PROCEDURE AbrirLookupCodAcbFaseP()
10299:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPgFaseP, loc_oErro
10300:         TRY
10301:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10302:                 RETURN
10303:             ENDIF
10304:             IF !this_lEmEdicao
10305:                 RETURN
10306:             ENDIF
10307:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10308:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_codacb.Value)
10309:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", ;
10310:                 "cursor_4c_BuscaAcaFP", "Cods", loc_cCodigo, "Acabamento")
10311:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10312:             loc_oBusca.mAddColuna("Descrs","", "Descri" + CHR(231) + CHR(227) + "o")
10313:             loc_oBusca.Show()
10314:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcaFP")
10315:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaAcaFP.Cods)
10316:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaAcaFP.Descrs)
10317:                 loc_oPgFaseP.txt_4c_codacb.Value = loc_cCodigo
10318:                 loc_oPgFaseP.txt_4c_Dacb.Value   = loc_cDescricao
10319:             ENDIF
10320:             IF USED("cursor_4c_BuscaAcaFP")
10321:                 USE IN cursor_4c_BuscaAcaFP
10322:             ENDIF
10323:             loc_oBusca.Release()
10324:         CATCH TO loc_oErro
10325:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de acabamento")
10326:         ENDTRY
10327:     ENDPROC
10328: 
10329:     *==========================================================================
10330:     * AbrirLookupTamFaseP - Lookup SigCdTam para txt_4c_Tam
10331:     *==========================================================================
10332:     PROTECTED PROCEDURE AbrirLookupTamFaseP()
10333:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10334:         TRY
10335:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10336:                 RETURN
10337:             ENDIF
10338:             IF !this_lEmEdicao
10339:                 RETURN
10340:             ENDIF
10341:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10342:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Tam.Value)
10343:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
10344:                 "cursor_4c_BuscaTamFP", "Cods", loc_cCodigo, "Tamanho")
10345:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10346:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10347:             loc_oBusca.Show()
10348:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamFP")
10349:                 loc_oPgFaseP.txt_4c_Tam.Value = ALLTRIM(cursor_4c_BuscaTamFP.Cods)
10350:             ENDIF
10351:             IF USED("cursor_4c_BuscaTamFP")
10352:                 USE IN cursor_4c_BuscaTamFP
10353:             ENDIF
10354:             loc_oBusca.Release()
10355:         CATCH TO loc_oErro
10356:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de tamanho")
10357:         ENDTRY
10358:     ENDPROC
10359: 
10360:     *==========================================================================
10361:     * AbrirLookupCorFaseP - Lookup SigCdCor para txt_4c_Cor
10362:     *==========================================================================
10363:     PROTECTED PROCEDURE AbrirLookupCorFaseP()
10364:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10365:         TRY
10366:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10367:                 RETURN
10368:             ENDIF
10369:             IF !this_lEmEdicao
10370:                 RETURN
10371:             ENDIF
10372:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10373:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Cor.Value)
10374:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", ;
10375:                 "cursor_4c_BuscaCorFP", "Cods", loc_cCodigo, "Cor")
10376:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10377:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10378:             loc_oBusca.Show()
10379:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCorFP")
10380:                 loc_oPgFaseP.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCorFP.Cods)
10381:             ENDIF
10382:             IF USED("cursor_4c_BuscaCorFP")
10383:                 USE IN cursor_4c_BuscaCorFP
10384:             ENDIF
10385:             loc_oBusca.Release()
10386:         CATCH TO loc_oErro
10387:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de cor")
10388:         ENDTRY
10389:     ENDPROC
10390: 
10391:     *==========================================================================
10392:     * AbrirLookupConquilhaFaseP - Lookup SigCdCnq para txt_4c_Conquilha
10393:     *==========================================================================
10394:     PROTECTED PROCEDURE AbrirLookupConquilhaFaseP()
10395:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10396:         TRY
10397:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10398:                 RETURN
10399:             ENDIF
10400:             IF !this_lEmEdicao
10401:                 RETURN
10402:             ENDIF
10403:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10404:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Conquilha.Value)
10405:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", ;
10406:                 "cursor_4c_BuscaCnqFP", "conquilhas", loc_cCodigo, "Conquilhas")
10407:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilhas")
10408:             loc_oBusca.Show()
10409:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnqFP")
10410:                 loc_oPgFaseP.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_BuscaCnqFP.conquilhas)
10411:             ENDIF
10412:             IF USED("cursor_4c_BuscaCnqFP")
10413:                 USE IN cursor_4c_BuscaCnqFP
10414:             ENDIF
10415:             loc_oBusca.Release()
10416:         CATCH TO loc_oErro
10417:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de conquilha")
10418:         ENDTRY
10419:     ENDPROC
10420: 
10421:     *==========================================================================
10422:     * ConfigurarPgpgDadosFiscais - Page3 (pgDadosFiscais) do pgf_4c_DadosInterno
10423:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
10424:     *==========================================================================
10425:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
10426:         LOCAL loc_oErro
10427:         TRY
10428:             *-- === Cursor placeholder ANTES do grid grdCmv ===
10429:             SET NULL ON
10430:             IF USED("cursor_4c_Cmv")
10431:                 USE IN cursor_4c_Cmv
10432:             ENDIF
10433:             CREATE CURSOR cursor_4c_Cmv (;
10434:                 Periodo C(7)    NULL, ;
10435:                 ValGR   N(15,6) NULL, ;
10436:                 Moe     C(3)    NULL  ;
10437:             )
10438:             SET NULL OFF
10439: 
10440:             *-- === Say16: "Grupo C.C. :" - top=165+29=194, left=138, w=63, h=15 ===
10441:             par_oPage.AddObject("lbl_4c_Label16", "Label")
10442:             WITH par_oPage.lbl_4c_Label16
10443:                 .Top       = 194
10444:                 .Left      = 138
10445:                 .Width     = 63
10446:                 .Height    = 15
10447:                 .FontName  = "Tahoma"
10448:                 .FontSize  = 8
10449:                 .BackStyle = 0
10450:                 .Caption   = "Grupo C.C. :"
10451:                 .ForeColor = RGB(90,90,90)
10452:                 .Visible   = .T.
10453:             ENDWITH
10454: 
10455:             *-- === Say17: "Conta C.C. :" - top=189+29=218, left=138, w=63, h=15 ===
10456:             par_oPage.AddObject("lbl_4c_Label17", "Label")
10457:             WITH par_oPage.lbl_4c_Label17
10458:                 .Top       = 218
10459:                 .Left      = 138
10460:                 .Width     = 63
10461:                 .Height    = 15
10462:                 .FontName  = "Tahoma"
10463:                 .FontSize  = 8
10464:                 .BackStyle = 0
10465:                 .Caption   = "Conta C.C. :"

*-- Linhas 11217 a 11934:
11217:     ENDPROC
11218: 
11219:     *==========================================================================
11220:     * Handlers - pgDadosFiscais (PUBLIC - obrigatorio para BINDEVENT)
11221:     *==========================================================================
11222: 
11223:     PROCEDURE GruccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11224:         LOCAL loc_oPgFisc, loc_oErro
11225:         TRY
11226:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11227:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11228:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value))
11229:                     fAcessoContab(gc_4c_UsuarioLogado, 'C', ;
11230:                         ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value), ;
11231:                         loc_oPgFisc.txt_4c__gruccus, ;
11232:                         loc_oPgFisc.txt_4c__dgruccus)
11233:                 ELSE
11234:                     loc_oPgFisc.txt_4c__dgruccus.Value  = ""
11235:                     loc_oPgFisc.txt_4c__contaccus.Value  = ""
11236:                     loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11237:                     loc_oPgFisc.txt_4c__dgruccus.Refresh
11238:                 ENDIF
11239:             ENDIF
11240:         CATCH TO loc_oErro
11241:             MsgErro(loc_oErro.Message, "Erro ao validar grupo contabil")
11242:         ENDTRY
11243:     ENDPROC
11244: 
11245:     PROCEDURE DgruccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11246:         LOCAL loc_oPgFisc, loc_oErro
11247:         TRY
11248:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11249:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11250:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__dgruccus.Value))
11251:                     fAcessoContab(gc_4c_UsuarioLogado, 'D', ;
11252:                         ALLTRIM(loc_oPgFisc.txt_4c__dgruccus.Value), ;
11253:                         loc_oPgFisc.txt_4c__gruccus, ;
11254:                         loc_oPgFisc.txt_4c__dgruccus)
11255:                 ELSE
11256:                     loc_oPgFisc.txt_4c__gruccus.Value    = ""
11257:                     loc_oPgFisc.txt_4c__contaccus.Value  = ""
11258:                     loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11259:                     loc_oPgFisc.txt_4c__gruccus.Refresh
11260:                 ENDIF
11261:             ENDIF
11262:         CATCH TO loc_oErro
11263:             MsgErro(loc_oErro.Message, "Erro ao validar descri" + CHR(231) + CHR(227) + "o grupo contabil")
11264:         ENDTRY
11265:     ENDPROC
11266: 
11267:     PROCEDURE ContaccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11268:         LOCAL loc_oPgFisc, loc_cGrupo, loc_oErro
11269:         TRY
11270:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11271:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11272:                 loc_cGrupo  = ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value)
11273:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__contaccus.Value))
11274:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'C', ;
11275:                             ALLTRIM(loc_oPgFisc.txt_4c__contaccus.Value), ;
11276:                             loc_oPgFisc.txt_4c__contaccus, ;
11277:                             loc_oPgFisc.txt_4c__dcontaccus)
11278:                         MsgAviso("Acesso Negado !!", "Acesso")
11279:                         loc_oPgFisc.txt_4c__contaccus.Value  = ""
11280:                         loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11281:                         loc_oPgFisc.txt_4c__contaccus.Refresh
11282:                         loc_oPgFisc.txt_4c__dcontaccus.Refresh
11283:                     ENDIF
11284:                 ELSE
11285:                     loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11286:                     loc_oPgFisc.txt_4c__dcontaccus.Refresh
11287:                 ENDIF
11288:             ENDIF
11289:         CATCH TO loc_oErro
11290:             MsgErro(loc_oErro.Message, "Erro ao validar conta contabil")
11291:         ENDTRY
11292:     ENDPROC
11293: 
11294:     PROCEDURE DcontaccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11295:         LOCAL loc_oPgFisc, loc_cGrupo, loc_oErro
11296:         TRY
11297:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11298:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11299:                 loc_cGrupo  = ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value)
11300:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__dcontaccus.Value))
11301:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'D', ;
11302:                             ALLTRIM(loc_oPgFisc.txt_4c__dcontaccus.Value), ;
11303:                             loc_oPgFisc.txt_4c__contaccus, ;
11304:                             loc_oPgFisc.txt_4c__dcontaccus)
11305:                         MsgAviso("Acesso Negado !!", "Acesso")
11306:                         loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11307:                         loc_oPgFisc.txt_4c__contaccus.Value  = ""
11308:                         loc_oPgFisc.txt_4c__dcontaccus.Refresh
11309:                         loc_oPgFisc.txt_4c__contaccus.Refresh
11310:                     ENDIF
11311:                 ELSE
11312:                     loc_oPgFisc.txt_4c__contaccus.Value = ""
11313:                     loc_oPgFisc.txt_4c__contaccus.Refresh
11314:                 ENDIF
11315:             ENDIF
11316:         CATCH TO loc_oErro
11317:             MsgErro(loc_oErro.Message, "Erro ao validar descri" + CHR(231) + CHR(227) + "o conta contabil")
11318:         ENDTRY
11319:     ENDPROC
11320: 
11321:     PROCEDURE ClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11322:         TRY
11323:             IF par_nKeyCode = 115
11324:                 THIS.AbrirLookupClfiscal()
11325:             ELSE
11326:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11327:                 THIS.AbrirLookupClfiscal()
11328:                 ENDIF
11329:             ENDIF
11330:         CATCH TO loc_oErro
11331:             *-- Tolerado
11332:         ENDTRY
11333:     ENDPROC
11334: 
11335:     PROCEDURE ClfiscalDblClick()
11336:         THIS.AbrirLookupClfiscal()
11337:     ENDPROC
11338: 
11339:     PROTECTED PROCEDURE AbrirLookupClfiscal()
11340:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11341:         TRY
11342:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11343:                 RETURN
11344:             ENDIF
11345:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11346:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
11347:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", ;
11348:                 "cursor_4c_BuscaClf", "Codigos", loc_cCodigo, ;
11349:                 "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11350:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11351:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11352:             loc_oBusca.Show()
11353:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11354:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11355:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11356:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11357:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11358:             ELSE
11359:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11360:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11361:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11362:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11363:             ENDIF
11364:             IF USED("cursor_4c_BuscaClf")
11365:                 USE IN cursor_4c_BuscaClf
11366:             ENDIF
11367:             loc_oBusca.Release()
11368:             loc_oPgFisc.txt_4c_Clfiscal.Refresh
11369:             loc_oPgFisc.txt_4c_Dclfiscal.Refresh
11370:         CATCH TO loc_oErro
11371:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup classifica" + CHR(231) + CHR(227) + "o fiscal")
11372:         ENDTRY
11373:     ENDPROC
11374: 
11375:     PROCEDURE DclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11376:         TRY
11377:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11378:                 THIS.AbrirLookupDclfiscal()
11379:             ENDIF
11380:         CATCH TO loc_oErro
11381:             *-- Tolerado
11382:         ENDTRY
11383:     ENDPROC
11384: 
11385:     PROTECTED PROCEDURE AbrirLookupDclfiscal()
11386:         LOCAL loc_oBusca, loc_oPgFisc, loc_cDescricao, loc_oErro
11387:         TRY
11388:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11389:                 RETURN
11390:             ENDIF
11391:             loc_oPgFisc   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11392:             loc_cDescricao = ALLTRIM(loc_oPgFisc.txt_4c_Dclfiscal.Value)
11393:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", ;
11394:                 "cursor_4c_BuscaClf", "Descricaos", loc_cDescricao, ;
11395:                 "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11396:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11397:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11398:             loc_oBusca.Show()
11399:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11400:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11401:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11402:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11403:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11404:             ELSE
11405:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11406:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11407:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11408:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11409:             ENDIF
11410:             IF USED("cursor_4c_BuscaClf")
11411:                 USE IN cursor_4c_BuscaClf
11412:             ENDIF
11413:             loc_oBusca.Release()
11414:             loc_oPgFisc.txt_4c_Clfiscal.Refresh
11415:             loc_oPgFisc.txt_4c_Dclfiscal.Refresh
11416:         CATCH TO loc_oErro
11417:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o fiscal")
11418:         ENDTRY
11419:     ENDPROC
11420: 
11421:     PROCEDURE OrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11422:         TRY
11423:             IF par_nKeyCode = 115
11424:                 THIS.AbrirLookupOrigmerc()
11425:             ELSE
11426:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11427:                 THIS.AbrirLookupOrigmerc()
11428:                 ENDIF
11429:             ENDIF
11430:         CATCH TO loc_oErro
11431:             *-- Tolerado
11432:         ENDTRY
11433:     ENDPROC
11434: 
11435:     PROCEDURE OrigmercDblClick()
11436:         THIS.AbrirLookupOrigmerc()
11437:     ENDPROC
11438: 
11439:     PROTECTED PROCEDURE AbrirLookupOrigmerc()
11440:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11441:         TRY
11442:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11443:                 RETURN
11444:             ENDIF
11445:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11446:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
11447:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", ;
11448:                 "cursor_4c_BuscaOrg", "Codigos", loc_cCodigo, ;
11449:                 "Origem da Mercadoria")
11450:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11451:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11452:             loc_oBusca.Show()
11453:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11454:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_BuscaOrg.Codigos)
11455:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_BuscaOrg.Descricaos)
11456:             ELSE
11457:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ""
11458:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ""
11459:             ENDIF
11460:             IF USED("cursor_4c_BuscaOrg")
11461:                 USE IN cursor_4c_BuscaOrg
11462:             ENDIF
11463:             loc_oBusca.Release()
11464:             loc_oPgFisc.txt_4c_Origmerc.Refresh
11465:             loc_oPgFisc.txt_4c_Dorigmerc.Refresh
11466:         CATCH TO loc_oErro
11467:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup origem mercadoria")
11468:         ENDTRY
11469:     ENDPROC
11470: 
11471:     PROCEDURE DorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11472:         TRY
11473:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11474:                 THIS.AbrirLookupDorigmerc()
11475:             ENDIF
11476:         CATCH TO loc_oErro
11477:             *-- Tolerado
11478:         ENDTRY
11479:     ENDPROC
11480: 
11481:     PROTECTED PROCEDURE AbrirLookupDorigmerc()
11482:         LOCAL loc_oBusca, loc_oPgFisc, loc_cDescricao, loc_oErro
11483:         TRY
11484:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11485:                 RETURN
11486:             ENDIF
11487:             loc_oPgFisc   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11488:             loc_cDescricao = ALLTRIM(loc_oPgFisc.txt_4c_Dorigmerc.Value)
11489:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", ;
11490:                 "cursor_4c_BuscaOrg", "Descricaos", loc_cDescricao, ;
11491:                 "Origem da Mercadoria")
11492:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11493:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11494:             loc_oBusca.Show()
11495:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11496:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_BuscaOrg.Codigos)
11497:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_BuscaOrg.Descricaos)
11498:             ELSE
11499:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ""
11500:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ""
11501:             ENDIF
11502:             IF USED("cursor_4c_BuscaOrg")
11503:                 USE IN cursor_4c_BuscaOrg
11504:             ENDIF
11505:             loc_oBusca.Release()
11506:             loc_oPgFisc.txt_4c_Origmerc.Refresh
11507:             loc_oPgFisc.txt_4c_Dorigmerc.Refresh
11508:         CATCH TO loc_oErro
11509:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o origem")
11510:         ENDTRY
11511:     ENDPROC
11512: 
11513:     PROCEDURE SittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11514:         TRY
11515:             IF par_nKeyCode = 115
11516:                 THIS.AbrirLookupSittricm()
11517:             ELSE
11518:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11519:                 THIS.AbrirLookupSittricm()
11520:                 ENDIF
11521:             ENDIF
11522:         CATCH TO loc_oErro
11523:             *-- Tolerado
11524:         ENDTRY
11525:     ENDPROC
11526: 
11527:     PROCEDURE SittricmDblClick()
11528:         THIS.AbrirLookupSittricm()
11529:     ENDPROC
11530: 
11531:     PROTECTED PROCEDURE AbrirLookupSittricm()
11532:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11533:         TRY
11534:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11535:                 RETURN
11536:             ENDIF
11537:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11538:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
11539:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11540:                 "cursor_4c_BuscaIcm", "Codigos", loc_cCodigo, ;
11541:                 "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11542:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11543:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11544:             loc_oBusca.Show()
11545:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11546:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11547:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11548:             ELSE
11549:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ""
11550:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ""
11551:             ENDIF
11552:             IF USED("cursor_4c_BuscaIcm")
11553:                 USE IN cursor_4c_BuscaIcm
11554:             ENDIF
11555:             loc_oBusca.Release()
11556:             loc_oPgFisc.txt_4c_Sittricm.Refresh
11557:             loc_oPgFisc.txt_4c_Dsittricm.Refresh
11558:         CATCH TO loc_oErro
11559:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup situa" + CHR(231) + CHR(227) + "o ICMS")
11560:         ENDTRY
11561:     ENDPROC
11562: 
11563:     PROCEDURE DsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11564:         TRY
11565:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11566:                 THIS.AbrirLookupDsittricm()
11567:             ENDIF
11568:         CATCH TO loc_oErro
11569:             *-- Tolerado
11570:         ENDTRY
11571:     ENDPROC
11572: 
11573:     PROTECTED PROCEDURE AbrirLookupDsittricm()
11574:         LOCAL loc_oBusca, loc_oPgFisc, loc_cDescricao, loc_oErro
11575:         TRY
11576:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11577:                 RETURN
11578:             ENDIF
11579:             loc_oPgFisc   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11580:             loc_cDescricao = ALLTRIM(loc_oPgFisc.txt_4c_Dsittricm.Value)
11581:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11582:                 "cursor_4c_BuscaIcm", "Descricaos", loc_cDescricao, ;
11583:                 "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11584:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11585:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11586:             loc_oBusca.Show()
11587:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11588:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11589:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11590:             ELSE
11591:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ""
11592:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ""
11593:             ENDIF
11594:             IF USED("cursor_4c_BuscaIcm")
11595:                 USE IN cursor_4c_BuscaIcm
11596:             ENDIF
11597:             loc_oBusca.Release()
11598:             loc_oPgFisc.txt_4c_Sittricm.Refresh
11599:             loc_oPgFisc.txt_4c_Dsittricm.Refresh
11600:         CATCH TO loc_oErro
11601:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o ICMS")
11602:         ENDTRY
11603:     ENDPROC
11604: 
11605:     PROCEDURE CodServsFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11606:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11607:         TRY
11608:             IF (par_nKeyCode = 13 OR par_nKeyCode = 9) AND gnConnHandle > 0 AND !gb_4c_ValidandoUI
11609:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11610:                 loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Codigo.Value)
11611:                 IF !EMPTY(loc_cCodigo)
11612:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11613:                         "cursor_4c_BuscaIcm", "Codigos", loc_cCodigo, ;
11614:                         "C" + CHR(243) + "digo ICMS")
11615:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11616:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11617:                     loc_oBusca.Show()
11618:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11619:                         loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11620:                         loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11621:                     ENDIF
11622:                     IF USED("cursor_4c_BuscaIcm")
11623:                         USE IN cursor_4c_BuscaIcm
11624:                     ENDIF
11625:                     loc_oBusca.Release()
11626:                     loc_oPgFisc.txt_4c_Sittricm.Refresh
11627:                     loc_oPgFisc.txt_4c_Dsittricm.Refresh
11628:                 ENDIF
11629:             ENDIF
11630:         CATCH TO loc_oErro
11631:             MsgErro(loc_oErro.Message, "Erro ao validar c" + CHR(243) + "digo servi" + CHR(231) + "os ICMS")
11632:         ENDTRY
11633:     ENDPROC
11634: 
11635:     PROCEDURE TpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11636:         TRY
11637:             IF par_nKeyCode = 115
11638:                 THIS.AbrirLookupTpTrib()
11639:             ELSE
11640:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11641:                 THIS.AbrirLookupTpTrib()
11642:                 ENDIF
11643:             ENDIF
11644:         CATCH TO loc_oErro
11645:             *-- Tolerado
11646:         ENDTRY
11647:     ENDPROC
11648: 
11649:     PROCEDURE TpTribDblClick()
11650:         THIS.AbrirLookupTpTrib()
11651:     ENDPROC
11652: 
11653:     PROTECTED PROCEDURE AbrirLookupTpTrib()
11654:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11655:         TRY
11656:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11657:                 RETURN
11658:             ENDIF
11659:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11660:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
11661:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
11662:                 "cursor_4c_BuscaTri", "Tipos", loc_cCodigo, ;
11663:                 "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11664:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11665:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11666:             loc_oBusca.Show()
11667:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11668:                 loc_oPgFisc.txt_4c_TpTrib.Value = ALLTRIM(cursor_4c_BuscaTri.Tipos)
11669:             ELSE
11670:                 loc_oPgFisc.txt_4c_TpTrib.Value = ""
11671:             ENDIF
11672:             IF USED("cursor_4c_BuscaTri")
11673:                 USE IN cursor_4c_BuscaTri
11674:             ENDIF
11675:             loc_oBusca.Release()
11676:             loc_oPgFisc.txt_4c_TpTrib.Refresh
11677:         CATCH TO loc_oErro
11678:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup tipo tributa" + CHR(231) + CHR(227) + "o")
11679:         ENDTRY
11680:     ENDPROC
11681: 
11682:     PROCEDURE IatFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11683:         LOCAL loc_oPgFisc, loc_oErro
11684:         TRY
11685:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11686:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11687:                 IF !INLIST(UPPER(ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)), "A", "T", " ", "")
11688:                     MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11689:                         "Digite [A] Arredondamento Ou [T] Truncamento!", "IAT")
11690:                     loc_oPgFisc.txt_4c_Iat.Value = ""
11691:                     loc_oPgFisc.txt_4c_Iat.Refresh
11692:                 ENDIF
11693:             ENDIF
11694:         CATCH TO loc_oErro
11695:             MsgErro(loc_oErro.Message, "Erro ao validar IAT")
11696:         ENDTRY
11697:     ENDPROC
11698: 
11699:     PROCEDURE AliqIPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11700:         LOCAL loc_oPgFisc, loc_nAliqClf, loc_nRet, loc_oErro
11701:         loc_nRet = 0
11702:         TRY
11703:             IF (par_nKeyCode = 13 OR par_nKeyCode = 9) AND gnConnHandle > 0 AND !gb_4c_ValidandoUI
11704:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11705:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)) AND ;
11706:                    !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_AliqIPI.Value))
11707:                     loc_nRet = SQLEXEC(gnConnHandle, ;
11708:                         "SELECT TOP 1 aIpis FROM SigCdClf WHERE Codigos = " + ;
11709:                         EscaparSQL(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)), ;
11710:                         "cursor_4c_TmpClf")
11711:                     IF loc_nRet > 0 AND !EOF("cursor_4c_TmpClf")
11712:                         loc_nAliqClf = cursor_4c_TmpClf.aIpis
11713:                         IF loc_oPgFisc.txt_4c_AliqIPI.Value = loc_nAliqClf
11714:                             MsgAviso("Al" + CHR(237) + "quota de IPI id" + CHR(234) + "ntica " + ;
11715:                                 CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal. " + ;
11716:                                 "Deixe zero para usar a da classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
11717:                                 "Aten" + CHR(231) + CHR(227) + "o")
11718:                         ENDIF
11719:                     ENDIF
11720:                     IF USED("cursor_4c_TmpClf")
11721:                         USE IN cursor_4c_TmpClf
11722:                     ENDIF
11723:                 ENDIF
11724:             ENDIF
11725:         CATCH TO loc_oErro
11726:             MsgErro(loc_oErro.Message, "Erro ao validar al" + CHR(237) + "quota IPI")
11727:         ENDTRY
11728:     ENDPROC
11729: 
11730:     PROCEDURE MvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11731:         TRY
11732:             IF par_nKeyCode = 115
11733:                 THIS.AbrirLookupMvalor()
11734:             ELSE
11735:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11736:                 THIS.AbrirLookupMvalor()
11737:                 ENDIF
11738:             ENDIF
11739:         CATCH TO loc_oErro
11740:             *-- Tolerado
11741:         ENDTRY
11742:     ENDPROC
11743: 
11744:     PROCEDURE MvalorDblClick()
11745:         THIS.AbrirLookupMvalor()
11746:     ENDPROC
11747: 
11748:     PROTECTED PROCEDURE AbrirLookupMvalor()
11749:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11750:         TRY
11751:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11752:                 RETURN
11753:             ENDIF
11754:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11755:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Mvalor.Value)
11756:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
11757:                 "cursor_4c_BuscaMoe", "CMoes", loc_cCodigo, "Moeda")
11758:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11759:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11760:             loc_oBusca.Show()
11761:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
11762:                 loc_oPgFisc.txt_4c_Mvalor.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
11763:             ELSE
11764:                 loc_oPgFisc.txt_4c_Mvalor.Value = ""
11765:             ENDIF
11766:             IF USED("cursor_4c_BuscaMoe")
11767:                 USE IN cursor_4c_BuscaMoe
11768:             ENDIF
11769:             loc_oBusca.Release()
11770:             loc_oPgFisc.txt_4c_Mvalor.Refresh
11771:         CATCH TO loc_oErro
11772:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup moeda")
11773:         ENDTRY
11774:     ENDPROC
11775: 
11776:     PROCEDURE MetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11777:         TRY
11778:             IF par_nKeyCode = 115
11779:                 THIS.AbrirLookupMetal()
11780:             ELSE
11781:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11782:                 THIS.AbrirLookupMetal()
11783:                 ENDIF
11784:             ENDIF
11785:         CATCH TO loc_oErro
11786:             *-- Tolerado
11787:         ENDTRY
11788:     ENDPROC
11789: 
11790:     PROCEDURE MetalDblClick()
11791:         THIS.AbrirLookupMetal()
11792:     ENDPROC
11793: 
11794:     PROTECTED PROCEDURE AbrirLookupMetal()
11795:         LOCAL loc_oPgFisc, loc_cCodigo, loc_oErro
11796:         TRY
11797:             IF gb_4c_ValidandoUI
11798:                 RETURN
11799:             ENDIF
11800:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11801:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Metal.Value)
11802:             IF !EMPTY(loc_cCodigo) AND USED("TmpMTal")
11803:                 SELECT TmpMTal
11804:                 SET ORDER TO Codigos
11805:                 SET NEAR ON
11806:                 IF !SEEK(loc_cCodigo, "TmpMTal", "Codigos")
11807:                     *-- Nao encontrou exato: mant?m valor digitado
11808:                 ENDIF
11809:                 SET NEAR OFF
11810:                 loc_oPgFisc.txt_4c_Metal.Value    = ALLTRIM(TmpMTal.Codigos)
11811:                 loc_oPgFisc.txt_4c_DesMetal.Value = ALLTRIM(TmpMTal.Descs)
11812:                 loc_oPgFisc.txt_4c_Metal.Refresh
11813:                 loc_oPgFisc.txt_4c_DesMetal.Refresh
11814:             ENDIF
11815:         CATCH TO loc_oErro
11816:             MsgErro(loc_oErro.Message, "Erro ao validar metal")
11817:         ENDTRY
11818:     ENDPROC
11819: 
11820:     PROCEDURE TeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11821:         TRY
11822:             IF par_nKeyCode = 115
11823:                 THIS.AbrirLookupTeor()
11824:             ELSE
11825:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11826:                 THIS.AbrirLookupTeor()
11827:                 ENDIF
11828:             ENDIF
11829:         CATCH TO loc_oErro
11830:             *-- Tolerado
11831:         ENDTRY
11832:     ENDPROC
11833: 
11834:     PROCEDURE TeorDblClick()
11835:         THIS.AbrirLookupTeor()
11836:     ENDPROC
11837: 
11838:     PROTECTED PROCEDURE AbrirLookupTeor()
11839:         LOCAL loc_oPgFisc, loc_cCodigo, loc_oErro
11840:         TRY
11841:             IF gb_4c_ValidandoUI
11842:                 RETURN
11843:             ENDIF
11844:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11845:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Teor.Value)
11846:             IF !EMPTY(loc_cCodigo) AND USED("TmpTeor")
11847:                 SELECT TmpTeor
11848:                 SET ORDER TO Codigos
11849:                 SET NEAR ON
11850:                 IF !SEEK(loc_cCodigo, "TmpTeor", "Codigos")
11851:                     *-- Nao encontrou exato: mant?m valor digitado
11852:                 ENDIF
11853:                 SET NEAR OFF
11854:                 loc_oPgFisc.txt_4c_Teor.Value    = ALLTRIM(TmpTeor.Codigos)
11855:                 loc_oPgFisc.txt_4c_DesTeor.Value = ALLTRIM(TmpTeor.Descs)
11856:                 loc_oPgFisc.txt_4c_Teor.Refresh
11857:                 loc_oPgFisc.txt_4c_DesTeor.Refresh
11858:             ENDIF
11859:         CATCH TO loc_oErro
11860:             MsgErro(loc_oErro.Message, "Erro ao validar teor")
11861:         ENDTRY
11862:     ENDPROC
11863: 
11864:     PROCEDURE BtnDescFisClick()
11865:         LOCAL loc_cFis, loc_oPgFisc, loc_oErro
11866:         TRY
11867:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11868:                 RETURN
11869:             ENDIF
11870:             IF EMPTY(this_cCodigo)
11871:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Aviso")
11872:                 RETURN
11873:             ENDIF
11874:             loc_cFis = fGerDescFis(0, this_cCodigo, this_oBusinessObject)
11875:             IF !EMPTY(loc_cFis)
11876:                 IF USED("crSigCdPro")
11877:                     REPLACE crSigCdPro.DescFis WITH loc_cFis
11878:                 ENDIF
11879:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11880:                 loc_oPgFisc.obj_4c_Mgetdescfi.Refresh
11881:             ELSE
11882:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + ;
11883:                     CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
11884:             ENDIF
11885:         CATCH TO loc_oErro
11886:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11887:         ENDTRY
11888:     ENDPROC
11889: 
11890:     *==========================================================================
11891:     * ConfigurarPgpgDesigner - Page7 (pgDesigner) do pgf_4c_DadosInterno
11892:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
11893:     *==========================================================================
11894:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
11895:         LOCAL loc_oGrd, loc_oGrdArq, loc_oErro
11896:         TRY
11897:             *-- === Criar cursores placeholder ANTES dos grids ===
11898:             SET NULL ON
11899:             IF USED("crSigPrTar")
11900:                 USE IN crSigPrTar
11901:             ENDIF
11902:             CREATE CURSOR crSigPrTar (;
11903:                 CPros    C(14)  NULL, ;
11904:                 pkChaves C(30)  NULL, ;
11905:                 DtInis   T      NULL, ;
11906:                 DtFims   T      NULL, ;
11907:                 Usuars   C(20)  NULL, ;
11908:                 Tarefas  C(10)  NULL, ;
11909:                 ObsTars  M      NULL  ;
11910:             )
11911:             IF USED("crSigPrArq")
11912:                 USE IN crSigPrArq
11913:             ENDIF
11914:             CREATE CURSOR crSigPrArq (;
11915:                 CPros    C(14)  NULL, ;
11916:                 pkChaves C(30)  NULL, ;
11917:                 Arquivos C(254) NULL  ;
11918:             )
11919:             SET NULL OFF
11920: 
11921:             *-- === lbl_4c_ObsTar (Say31): top=144+29=173, left=583, w=126, h=15 ===
11922:             par_oPage.AddObject("lbl_4c_ObsTar", "Label")
11923:             WITH par_oPage.lbl_4c_ObsTar
11924:                 .Top       = 173
11925:                 .Left      = 583
11926:                 .Width     = 126
11927:                 .Height    = 15
11928:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11929:                 .FontName  = "Tahoma"
11930:                 .FontSize  = 8
11931:                 .AutoSize  = .F.
11932:                 .BackStyle = 0
11933:                 .ForeColor = RGB(0, 0, 0)
11934:                 .Visible   = .T.

*-- Linhas 11978 a 12051:
11978:             loc_oGrd.Column4.ReadOnly         = .T.
11979:             loc_oGrd.Column4.Header1.FontBold = .T.
11980: 
11981:             *-- BINDEVENTs para grd_4c_Designer
11982:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "DesignerAfterRowColChange")
11983:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "DesignerCol4KeyPress")
11984: 
11985:             *-- === cmd_4c_BtnIniTarefa (btnIniTarefa): top=161+29=190, left=509, w=42, h=42 ===
11986:             par_oPage.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
11987:             WITH par_oPage.cmd_4c_BtnIniTarefa
11988:                 .Top     = 190
11989:                 .Left    = 509
11990:                 .Width   = 42
11991:                 .Height  = 42
11992:                 .Caption = ""
11993:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
11994:                 .Themes  = .F.
11995:                 .Visible = .T.
11996:             ENDWITH
11997:             BINDEVENT(par_oPage.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
11998: 
11999:             *-- === cmd_4c_BtnFimTarefa (btnFimTarefa): top=203+29=232, left=509, w=42, h=42 ===
12000:             par_oPage.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
12001:             WITH par_oPage.cmd_4c_BtnFimTarefa
12002:                 .Top     = 232
12003:                 .Left    = 509
12004:                 .Width   = 42
12005:                 .Height  = 42
12006:                 .Caption = ""
12007:                 .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
12008:                 .Themes  = .F.
12009:                 .Visible = .T.
12010:             ENDWITH
12011:             BINDEVENT(par_oPage.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
12012: 
12013:             *-- === obj_4c_GetObsTarefas (getObsTarefas): top=160+29=189, left=584, w=407, h=238 ===
12014:             par_oPage.AddObject("obj_4c_GetObsTarefas", "EditBox")
12015:             WITH par_oPage.obj_4c_GetObsTarefas
12016:                 .Top         = 189
12017:                 .Left        = 584
12018:                 .Width       = 407
12019:                 .Height      = 238
12020:                 .ControlSource = "crSigPrTar.ObsTars"
12021:                 .FontName    = "Tahoma"
12022:                 .FontSize    = 8
12023:                 .ScrollBars  = 2
12024:                 .ReadOnly    = .T.
12025:                 .Themes      = .F.
12026:                 .Visible     = .T.
12027:             ENDWITH
12028: 
12029:             *-- === shp_4c_Shape1 (Shape1): top=415+29=444, left=584, w=407, h=202 ===
12030:             par_oPage.AddObject("shp_4c_Shape1", "Shape")
12031:             WITH par_oPage.shp_4c_Shape1
12032:                 .Top         = 444
12033:                 .Left        = 584
12034:                 .Width       = 407
12035:                 .Height      = 202
12036:                 .BackColor   = RGB(255, 255, 255)
12037:                 .BackStyle   = 1
12038:                 .BorderStyle = 1
12039:                 .Visible     = .T.
12040:             ENDWITH
12041: 
12042:             *-- === grd_4c_Arquivos (grdArquivos): top=415+29=444, left=10, w=495, h=202 ===
12043:             par_oPage.AddObject("grd_4c_Arquivos", "Grid")
12044:             loc_oGrdArq = par_oPage.grd_4c_Arquivos
12045:             loc_oGrdArq.Top         = 444
12046:             loc_oGrdArq.Left        = 10
12047:             loc_oGrdArq.Width       = 495
12048:             loc_oGrdArq.Height      = 202
12049:             loc_oGrdArq.ColumnCount = 1
12050:             loc_oGrdArq.FontName    = "Tahoma"
12051:             loc_oGrdArq.FontSize    = 8

*-- Linhas 12065 a 12173:
12065:             loc_oGrdArq.Column1.ReadOnly         = .T.
12066:             loc_oGrdArq.Column1.Header1.FontBold = .T.
12067: 
12068:             *-- BINDEVENTs para grd_4c_Arquivos
12069:             BINDEVENT(loc_oGrdArq, "AfterRowColChange", THIS, "ArquivosAfterRowColChange")
12070: 
12071:             *-- === cmd_4c_BtnInsArqs (btnInsArqs): top=416+29=445, left=509, w=42, h=42 ===
12072:             par_oPage.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
12073:             WITH par_oPage.cmd_4c_BtnInsArqs
12074:                 .Top     = 445
12075:                 .Left    = 509
12076:                 .Width   = 42
12077:                 .Height  = 42
12078:                 .Caption = ""
12079:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
12080:                 .Themes  = .F.
12081:                 .Visible = .T.
12082:             ENDWITH
12083:             BINDEVENT(par_oPage.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
12084: 
12085:             *-- === cmd_4c_BtnExcArqs (btnExcArqs): top=458+29=487, left=509, w=42, h=42 ===
12086:             par_oPage.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
12087:             WITH par_oPage.cmd_4c_BtnExcArqs
12088:                 .Top     = 487
12089:                 .Left    = 509
12090:                 .Width   = 42
12091:                 .Height  = 42
12092:                 .Caption = ""
12093:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
12094:                 .Themes  = .F.
12095:                 .Visible = .T.
12096:             ENDWITH
12097:             BINDEVENT(par_oPage.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
12098: 
12099:             *-- === cmd_4c_BtnOpnArqs (btnOpnArqs): top=500+29=529, left=509, w=42, h=42 ===
12100:             par_oPage.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
12101:             WITH par_oPage.cmd_4c_BtnOpnArqs
12102:                 .Top     = 529
12103:                 .Left    = 509
12104:                 .Width   = 42
12105:                 .Height  = 42
12106:                 .Caption = ""
12107:                 .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
12108:                 .Themes  = .F.
12109:                 .Visible = .T.
12110:             ENDWITH
12111:             BINDEVENT(par_oPage.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
12112: 
12113:             *-- === img_4c_ImgArqJpg (imgArqJpg): top=417+29=446, left=586, w=403, h=198 ===
12114:             par_oPage.AddObject("img_4c_ImgArqJpg", "Image")
12115:             WITH par_oPage.img_4c_ImgArqJpg
12116:                 .Top     = 446
12117:                 .Left    = 586
12118:                 .Width   = 403
12119:                 .Height  = 198
12120:                 .Stretch = 2
12121:                 .Visible = .F.
12122:             ENDWITH
12123:             BINDEVENT(par_oPage.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
12124: 
12125:         CATCH TO loc_oErro
12126:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Designer")
12127:         ENDTRY
12128:     ENDPROC
12129: 
12130:     *==========================================================================
12131:     * CarregarDesigner - Carrega SigPrTar e SigPrArq e crTarefas para o produto
12132:     *==========================================================================
12133:     PROCEDURE CarregarDesigner()
12134:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgDesigner, loc_oErro, loc_lContinuar
12135:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
12136:             RETURN
12137:         ENDIF
12138:         loc_lContinuar = .T.
12139:         TRY
12140:             loc_cCPros = ALLTRIM(this_cCodigo)
12141:             IF EMPTY(loc_cCPros)
12142:                 loc_lContinuar = .F.
12143:             ENDIF
12144:             IF loc_lContinuar
12145:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12146: 
12147:                 *-- Carregar crSigPrTar de SigPrTar
12148:                 IF USED("cursor_4c_TarTemp")
12149:                     USE IN cursor_4c_TarTemp
12150:                 ENDIF
12151:                 loc_cSQL = "SELECT CPros, pkChaves, DtInis, DtFims, Usuars, Tarefas, " + ;
12152:                            "CONVERT(NVARCHAR(MAX), ObsTars) AS ObsTars " + ;
12153:                            "FROM SigPrTar WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12154:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TarTemp")
12155:                 IF loc_nRet > 0
12156:                     SELECT crSigPrTar
12157:                     ZAP
12158:                     IF RECCOUNT("cursor_4c_TarTemp") > 0
12159:                         APPEND FROM DBF("cursor_4c_TarTemp")
12160:                     ENDIF
12161:                     IF USED("cursor_4c_TarTemp")
12162:                         USE IN cursor_4c_TarTemp
12163:                     ENDIF
12164:                     SELECT crSigPrTar
12165:                     GO TOP
12166:                     loc_oPgDesigner.grd_4c_Designer.Refresh()
12167:                     THIS.DesignerAfterRowColChange(0)
12168:                 ELSE
12169:                     IF USED("cursor_4c_TarTemp")
12170:                         USE IN cursor_4c_TarTemp
12171:                     ENDIF
12172:                 ENDIF
12173: 

*-- Linhas 12210 a 12587:
12210:     *==========================================================================
12211:     * CarregarTarefas - Carrega lista de tarefas de SigCdCad (lookup)
12212:     *==========================================================================
12213:     PROCEDURE CarregarTarefas()
12214:         LOCAL loc_cSQL, loc_nRet, loc_oErro
12215:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
12216:             RETURN
12217:         ENDIF
12218:         TRY
12219:             IF USED("crTarefas")
12220:                 USE IN crTarefas
12221:             ENDIF
12222:             loc_cSQL = "SELECT LEFT(CodCads, 10) AS CodCads, DesCads " + ;
12223:                        "FROM SigCdCad " + ;
12224:                        "WHERE TipoCads = " + EscaparSQL(PADR("TAREFAS", 20))
12225:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crTarefas")
12226:             IF loc_nRet < 1
12227:                 IF USED("crTarefas")
12228:                     USE IN crTarefas
12229:                 ENDIF
12230:             ENDIF
12231:         CATCH TO loc_oErro
12232:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de tarefas")
12233:         ENDTRY
12234:     ENDPROC
12235: 
12236:     *==========================================================================
12237:     * DesignerAfterRowColChange - Atualiza ObsTarefas e controla edicao Tarefa
12238:     *==========================================================================
12239:     PROCEDURE DesignerAfterRowColChange(par_nColIndex)
12240:         LOCAL loc_oPgDesigner, loc_lPodeEditar, loc_oErro
12241:         TRY
12242:             IF gb_4c_ValidandoUI
12243:                 RETURN
12244:             ENDIF
12245:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12246:             *-- Atualizar editbox de observacoes da tarefa
12247:             loc_oPgDesigner.obj_4c_GetObsTarefas.Refresh()
12248:             *-- Controlar editabilidade da coluna Tarefa (Column4)
12249:             loc_lPodeEditar = .F.
12250:             IF INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12251:                 IF USED("crSigPrTar") AND !EOF("crSigPrTar") AND !BOF("crSigPrTar")
12252:                     SELECT crSigPrTar
12253:                     IF ALLTRIM(NVL(Usuars, "")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12254:                        AND EMPTY(NVL(DtFims, {}))
12255:                         loc_lPodeEditar = .T.
12256:                     ENDIF
12257:                 ENDIF
12258:             ENDIF
12259:             loc_oPgDesigner.grd_4c_Designer.Column4.ReadOnly = !loc_lPodeEditar
12260:         CATCH TO loc_oErro
12261:             *-- Tolerado: controle da coluna nao critico
12262:         ENDTRY
12263:     ENDPROC
12264: 
12265:     *==========================================================================
12266:     * DesignerCol4KeyPress - F4 abre lookup de Tarefa (crTarefas/SigCdCad)
12267:     *==========================================================================
12268:     PROCEDURE DesignerCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
12269:         LOCAL loc_oErro
12270:         TRY
12271:             IF par_nKeyCode = 115
12272:                 THIS.AbrirLookupDesignerTarefa()
12273:             ENDIF
12274:         CATCH TO loc_oErro
12275:             *-- Tolerado
12276:         ENDTRY
12277:     ENDPROC
12278: 
12279:     *==========================================================================
12280:     * AbrirLookupDesignerTarefa - Busca em crTarefas para coluna Tarefa do grid
12281:     *==========================================================================
12282:     PROTECTED PROCEDURE AbrirLookupDesignerTarefa()
12283:         LOCAL loc_oBusca, loc_cCodCads, loc_oPgDesigner, loc_oGrd, loc_oErro
12284:         TRY
12285:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
12286:                 RETURN
12287:             ENDIF
12288:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12289:                 RETURN
12290:             ENDIF
12291:             IF !USED("crTarefas")
12292:                 THIS.CarregarTarefas()
12293:             ENDIF
12294:             IF !USED("crTarefas")
12295:                 RETURN
12296:             ENDIF
12297:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12298:             loc_oGrd   = loc_oPgDesigner.grd_4c_Designer
12299:             loc_cCodCads = ALLTRIM(loc_oGrd.Column4.Text1.Value)
12300:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12301:                 "crTarefas", "cursor_4c_BuscaTar", "CodCads", loc_cCodCads, ;
12302:                 "Busca de Tarefas", .F.)
12303:             IF VARTYPE(loc_oBusca) = "O"
12304:                 IF loc_oBusca.this_lSelecionou
12305:                     IF USED("cursor_4c_BuscaTar") AND RECCOUNT("cursor_4c_BuscaTar") > 0
12306:                         SELECT cursor_4c_BuscaTar
12307:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12308:                         loc_oGrd.Refresh()
12309:                     ENDIF
12310:                 ELSE
12311:                     loc_oBusca.mAddColuna("CodCads",  "", "C" + CHR(243) + "digo")
12312:                     loc_oBusca.mAddColuna("DesCads",  "", "Descri" + CHR(231) + CHR(227) + "o")
12313:                     loc_oBusca.Show()
12314:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12315:                         SELECT cursor_4c_BuscaTar
12316:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12317:                         loc_oGrd.Refresh()
12318:                     ENDIF
12319:                 ENDIF
12320:                 loc_oBusca.Release()
12321:             ENDIF
12322:             IF USED("cursor_4c_BuscaTar")
12323:                 USE IN cursor_4c_BuscaTar
12324:             ENDIF
12325:         CATCH TO loc_oErro
12326:             MsgErro(loc_oErro.Message, "Erro ao buscar tarefa")
12327:         ENDTRY
12328:     ENDPROC
12329: 
12330:     *==========================================================================
12331:     * BtnIniTarefaClick - Inicia nova tarefa (INSERT Into crSigPrTar)
12332:     *==========================================================================
12333:     PROCEDURE BtnIniTarefaClick()
12334:         LOCAL loc_oPgDesigner, loc_oGrd, loc_dtAgora, loc_lContinuar, loc_oErro
12335:         loc_lContinuar = .T.
12336:         TRY
12337:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12338:                 loc_lContinuar = .F.
12339:             ENDIF
12340:             IF loc_lContinuar AND !USED("crSigPrTar")
12341:                 loc_lContinuar = .F.
12342:             ENDIF
12343:             IF loc_lContinuar
12344:                 *-- Verificar se existe tarefa nao encerrada para o usuario
12345:                 SELECT crSigPrTar
12346:                 GO TOP
12347:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12348:                          AND EMPTY(NVL(DtFims, {}))
12349:                 IF !EOF("crSigPrTar")
12350:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12351:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12352:                     loc_lContinuar = .F.
12353:                 ENDIF
12354:             ENDIF
12355:             IF loc_lContinuar
12356:                 *-- Verificar se existe tarefa com campo Tarefas vazio
12357:                 SELECT crSigPrTar
12358:                 GO TOP
12359:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12360:                          AND EMPTY(NVL(Tarefas,""))
12361:                 IF !EOF("crSigPrTar")
12362:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", ;
12363:                              "Aten" + CHR(231) + CHR(227) + "o")
12364:                     loc_lContinuar = .F.
12365:                 ENDIF
12366:             ENDIF
12367:             IF loc_lContinuar
12368:                 loc_dtAgora = DATETIME()
12369:                 INSERT INTO crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
12370:                     VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12371:                             PADR(SYS(2015), 30), ;
12372:                             loc_dtAgora, ;
12373:                             PADR(ALLTRIM(gc_4c_UsuarioLogado), 20))
12374:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12375:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12376:             ENDIF
12377:         CATCH TO loc_oErro
12378:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12379:         ENDTRY
12380:     ENDPROC
12381: 
12382:     *==========================================================================
12383:     * BtnFimTarefaClick - Finaliza tarefa atual (Replace DtFims)
12384:     *==========================================================================
12385:     PROCEDURE BtnFimTarefaClick()
12386:         LOCAL loc_oPgDesigner, loc_dtAgora, loc_lContinuar, loc_oErro
12387:         loc_lContinuar = .T.
12388:         TRY
12389:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12390:                 loc_lContinuar = .F.
12391:             ENDIF
12392:             IF loc_lContinuar AND (!USED("crSigPrTar") OR EOF("crSigPrTar") OR BOF("crSigPrTar"))
12393:                 loc_lContinuar = .F.
12394:             ENDIF
12395:             IF loc_lContinuar
12396:                 SELECT crSigPrTar
12397:                 *-- Verificar se a tarefa pertence ao usuario atual
12398:                 IF ALLTRIM(NVL(Usuars,"")) <> ALLTRIM(gc_4c_UsuarioLogado)
12399:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + ;
12400:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12401:                     loc_lContinuar = .F.
12402:                 ENDIF
12403:             ENDIF
12404:             IF loc_lContinuar
12405:                 SELECT crSigPrTar
12406:                 *-- Verificar se a tarefa ja esta finalizada
12407:                 IF !EMPTY(NVL(DtFims, {}))
12408:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", ;
12409:                              "Aten" + CHR(231) + CHR(227) + "o")
12410:                     loc_lContinuar = .F.
12411:                 ENDIF
12412:             ENDIF
12413:             IF loc_lContinuar
12414:                 loc_dtAgora = DATETIME()
12415:                 REPLACE DtFims WITH loc_dtAgora IN crSigPrTar
12416:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12417:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12418:                 THIS.DesignerAfterRowColChange(0)
12419:             ENDIF
12420:         CATCH TO loc_oErro
12421:             MsgErro(loc_oErro.Message, "Erro ao finalizar tarefa")
12422:         ENDTRY
12423:     ENDPROC
12424: 
12425:     *==========================================================================
12426:     * ArquivosAfterRowColChange - Exibe preview de imagem para arquivo selecionado
12427:     *==========================================================================
12428:     PROCEDURE ArquivosAfterRowColChange(par_nColIndex)
12429:         LOCAL loc_oPgDesigner, loc_cArq, loc_cExt, loc_oErro
12430:         TRY
12431:             IF gb_4c_ValidandoUI
12432:                 RETURN
12433:             ENDIF
12434:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12435:             loc_oPgDesigner.img_4c_ImgArqJpg.Picture = ""
12436:             loc_oPgDesigner.img_4c_ImgArqJpg.Visible = .F.
12437:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12438:                 RETURN
12439:             ENDIF
12440:             SELECT crSigPrArq
12441:             loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12442:             IF EMPTY(loc_cArq)
12443:                 RETURN
12444:             ENDIF
12445:             loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12446:             IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG") AND FILE(loc_cArq)
12447:                 CLEAR RESOURCES
12448:                 loc_oPgDesigner.img_4c_ImgArqJpg.Picture  = loc_cArq
12449:                 loc_oPgDesigner.img_4c_ImgArqJpg.Visible  = .T.
12450:             ENDIF
12451:         CATCH TO loc_oErro
12452:             *-- Tolerado: preview de imagem nao critico
12453:         ENDTRY
12454:     ENDPROC
12455: 
12456:     *==========================================================================
12457:     * BtnInsArqsClick - Insere arquivo no cursor crSigPrArq (GetFile)
12458:     *==========================================================================
12459:     PROCEDURE BtnInsArqsClick()
12460:         LOCAL loc_cArq, loc_oPgDesigner, loc_lContinuar, loc_oErro
12461:         loc_lContinuar = .T.
12462:         TRY
12463:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12464:                 loc_lContinuar = .F.
12465:             ENDIF
12466:             IF loc_lContinuar
12467:                 loc_cArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
12468:                     "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
12469:                 IF !EMPTY(loc_cArq)
12470:                     INSERT INTO crSigPrArq (CPros, pkChaves, Arquivos) ;
12471:                         VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12472:                                 PADR(SYS(2015), 30), ;
12473:                                 UPPER(loc_cArq))
12474:                     loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12475:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12476:                 ENDIF
12477:             ENDIF
12478:         CATCH TO loc_oErro
12479:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12480:         ENDTRY
12481:     ENDPROC
12482: 
12483:     *==========================================================================
12484:     * BtnOpnArqsClick - Abre arquivo selecionado com Shell.Application
12485:     *==========================================================================
12486:     PROCEDURE BtnOpnArqsClick()
12487:         LOCAL loc_cArq, loc_oShell, loc_lContinuar, loc_oErro
12488:         loc_lContinuar = .T.
12489:         TRY
12490:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12491:                 loc_lContinuar = .F.
12492:             ENDIF
12493:             IF loc_lContinuar
12494:                 SELECT crSigPrArq
12495:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12496:                 IF EMPTY(loc_cArq)
12497:                     loc_lContinuar = .F.
12498:                 ENDIF
12499:             ENDIF
12500:             IF loc_lContinuar
12501:                 IF FILE(loc_cArq)
12502:                     loc_oShell = CREATEOBJECT("Shell.Application")
12503:                     IF VARTYPE(loc_oShell) = "O"
12504:                         loc_oShell.Open(loc_cArq)
12505:                     ENDIF
12506:                 ELSE
12507:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, ;
12508:                              "Aten" + CHR(231) + CHR(227) + "o")
12509:                 ENDIF
12510:             ENDIF
12511:         CATCH TO loc_oErro
12512:             MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
12513:         ENDTRY
12514:     ENDPROC
12515: 
12516:     *==========================================================================
12517:     * BtnExcArqsClick - Exclui arquivo do cursor crSigPrArq
12518:     *==========================================================================
12519:     PROCEDURE BtnExcArqsClick()
12520:         LOCAL loc_oPgDesigner, loc_lContinuar, loc_oErro
12521:         loc_lContinuar = .T.
12522:         TRY
12523:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12524:                 loc_lContinuar = .F.
12525:             ENDIF
12526:             IF loc_lContinuar AND (!USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq"))
12527:                 loc_lContinuar = .F.
12528:             ENDIF
12529:             IF loc_lContinuar
12530:                 SELECT crSigPrArq
12531:                 IF !EMPTY(ALLTRIM(NVL(Arquivos, "")))
12532:                     DELETE IN crSigPrArq
12533:                     IF !EOF("crSigPrArq")
12534:                         SKIP IN crSigPrArq
12535:                     ENDIF
12536:                 ENDIF
12537:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12538:                 loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12539:                 THIS.ArquivosAfterRowColChange(0)
12540:             ENDIF
12541:         CATCH TO loc_oErro
12542:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12543:         ENDTRY
12544:     ENDPROC
12545: 
12546:     *==========================================================================
12547:     * ImgArqJpgClick - Zoom na imagem (abre SigOpZom se for imagem valida)
12548:     *==========================================================================
12549:     PROCEDURE ImgArqJpgClick()
12550:         LOCAL loc_cArq, loc_cExt, loc_lContinuar, loc_oErro
12551:         loc_lContinuar = .T.
12552:         TRY
12553:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12554:                 loc_lContinuar = .F.
12555:             ENDIF
12556:             IF loc_lContinuar
12557:                 SELECT crSigPrArq
12558:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12559:                 IF EMPTY(loc_cArq)
12560:                     loc_lContinuar = .F.
12561:                 ENDIF
12562:             ENDIF
12563:             IF loc_lContinuar
12564:                 loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12565:                 IF FILE(loc_cArq) AND INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12566:                     DO FORM SigOpZom WITH loc_cArq, "Arquivo: " + loc_cArq
12567:                 ENDIF
12568:             ENDIF
12569:         CATCH TO loc_oErro
12570:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
12571:         ENDTRY
12572:     ENDPROC
12573: 
12574:     *--------------------------------------------------------------------------
12575:     PROCEDURE Destroy()
12576:         LOCAL loc_oErro
12577:         TRY
12578:             IF VARTYPE(this_oBusinessObject) = "O"
12579:                 this_oBusinessObject = .NULL.
12580:             ENDIF
12581:         CATCH TO loc_oErro
12582:             *-- Tolerado durante Destroy
12583:         ENDTRY
12584:         DODEFAULT()
12585:     ENDPROC
12586: 
12587: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos (SigCdPro)
* Gerado: Fase 8/8 - Completo, tabela SigCdPro
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros       = ""    && CPros  char(14) - PK: codigo do produto
    *-- Descricoes
    this_cDpros       = ""    && DPros  - descricao principal
    this_cDPro2s      = ""    && DPro2s - descricao secundaria
    this_cDPro3s      = ""    && DPro3s - descricao memo (editbox)
    *-- Grupo / Subgrupo
    this_cCgrus       = ""    && CGrus  - codigo do grupo
    this_cSGrus       = ""    && SGrus  - codigo do subgrupo
    *-- Fornecedor / Referencia / Colecao
    this_cIFors       = ""    && IFors  - codigo do fornecedor
    this_cReffs       = ""    && Reffs  - referencia do fornecedor
    this_cColecoes    = ""    && Colecoes - colecao
    *-- Codigos auxiliares
    this_cCbars       = ""    && Cbars    - codigo de barras
    this_cEAN13       = ""    && EAN13    - EAN-13 (se campo separado)
    this_cCProEqs     = ""    && CProEqs  - produto equivalente
    this_cIdeCPros    = ""    && IdeCPros - identificador
    this_cMercs       = ""    && Mercs    - mercadoria
    *-- Linha / Colecao
    this_cLins        = ""    && Lins     - codigo da linha
    this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
    *-- Unidades
    this_cCUnis       = ""    && CUnis    - unidade 1
    this_cCUnips      = ""    && CUnips   - unidade 2
    *-- Dimensoes
    this_nAlturas     = 0     && Alturas
    this_nLarguras    = 0     && Larguras
    this_nDiametros   = 0     && Diametros
    this_nEspessuras  = 0     && Espessuras
    this_nCompriments = 0     && Compriments
    this_nPesoMs      = 0     && PesoMs      - peso base
    this_nPesoBs      = 0     && PesoBs      - peso bruto
    this_nPesoPmedios = 0     && PesoPmedios - peso medio
    *-- Classificacoes
    this_cTams        = ""    && Tams     - tamanho
    this_cCorPros     = ""    && CorPros  - cor
    this_cCodFinPs    = ""    && CodFinPs - finalidade
    this_cCodAcbs     = ""    && CodAcbs  - acabamento
    this_cLocals      = ""    && Locals   - local
    this_cClasss      = ""    && Classs   - classificacao
    *-- Precos e moedas
    this_nPvens       = 0     && Pvens    - preco de venda
    this_cMoevs       = ""    && Moevs    - moeda venda
    this_nFvendas     = 0     && Fvendas  - fator venda
    this_cMfvendas    = ""    && Mfvendas - moeda fator venda
    this_nCustofs     = 0     && Custofs  - custo
    this_cMoecs       = ""    && Moecs    - moeda custo
    this_nMargems     = 0     && Margems  - margem
    this_nPcuss       = 0     && Pcuss    - preco custo unitario
    this_cMoePcs      = ""    && MoePcs   - moeda preco custo
    this_nFcustos     = 0     && Fcustos  - fator custo
    this_nPFTioCs     = 0     && PFTioCs  - feitio custo
    this_nPFTios      = 0     && PFTios   - feitio venda
    *-- Quantidades e lotes
    this_nQmins       = 0     && Qmins    - quantidade minima
    this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
    this_nConjuntos   = 0     && Conjuntos - conjunto
    this_nQtPeds      = 0     && QtPeds   - quantidade pedido
    *-- Flags booleanos (armazenados como INT 0/1)
    this_nGarVits     = 0     && GarVits     - garantia vitrine
    this_nConsigs     = 0     && Consigs     - consignado
    this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
    this_nEncoms      = 0     && Encoms      - encomenda
    this_nProdWebs    = 0     && ProdWebs    - produto web
    this_nOpcVars     = 0     && OpcVars     - opcao variacao
    this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
    *-- Status e situacao
    this_nSituas      = 0     && Situas  - situacao
    this_dDtSituas    = {}    && DtSituas - data situacao
    *-- Observacoes
    this_cObs1s       = ""    && Obs1s
    this_cObs2s       = ""    && Obs2s
    this_cObs3s       = ""    && Obs3s
    this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
    this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
    *-- Campos customizados
    this_cFwget3s     = ""    && Fwget3s
    this_cFwget4s     = ""    && Fwget4s
    this_cFwget5s     = ""    && Fwget5s
    this_cFwget6s     = ""    && Fwget6s
    this_cCodIdents   = ""    && CodIdents
    this_cTEnts       = ""    && TEnts  - tipo entrada
    this_nDiasGars    = 0     && DiasGars - dias de garantia
    *-- Campos FaseP (Fase P - dados de processo)
    this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
    this_cCodGarras   = ""    && CodGarras  - codigo de garras
    this_cConquilhas  = ""    && Conquilhas - conquilha padrao
    this_nPesoBris    = 0     && PesoBris   - peso brilhante
    this_nPesoMetal   = 0     && PesoMetal  - peso metal
    this_nPesoPdrs    = 0     && PesoPdrs   - peso pedra
    this_nCravCers    = 0     && CravCers   - cravacao em cera (0/1)
    this_nVarias      = 0     && Varias     - peso variavel (0/1)
    *-- Estoque e auditoria (somente leitura)
    this_nEstoques    = 0     && Estoques
    this_nQtdEsts     = 0     && QtdEsts
    this_dDtIncs      = {}    && DtIncs  - data de inclusao
    this_dDataAlts    = {}    && DataAlts - data alteracao
    this_cHoraAlts    = ""    && HoraAlts - hora alteracao
    this_cUsuaIncs    = ""    && UsuaIncs - usuario inclusao
    this_cUsuaAlts    = ""    && UsuaAlts - usuario alteracao
    this_dDtucps      = {}    && Dtucps  - data ult. compra
    this_nVucps       = 0     && Vucps   - valor ult. compra
    this_cMucps       = ""    && Mucps   - moeda ult. compra
    this_nQtdUltComps = 0     && QtdUltComps - qtd ult. compra

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCpros       = TratarNulo(CPros,       "C")
                THIS.this_cDpros       = TratarNulo(DPros,       "C")
                THIS.this_cDPro2s      = TratarNulo(DPro2s,      "C")
                THIS.this_cDPro3s      = TratarNulo(DPro3s,      "C")
                THIS.this_cCgrus       = TratarNulo(CGrus,       "C")
                THIS.this_cSGrus       = TratarNulo(SGrus,       "C")
                THIS.this_cIFors       = TratarNulo(IFors,       "C")
                THIS.this_cReffs       = TratarNulo(Reffs,       "C")
                THIS.this_cColecoes    = TratarNulo(Colecoes,    "C")
                THIS.this_cCbars       = TratarNulo(Cbars,       "C")
                THIS.this_cCProEqs     = TratarNulo(CProEqs,     "C")
                THIS.this_cIdeCPros    = TratarNulo(IdeCPros,    "C")
                THIS.this_cMercs       = TratarNulo(Mercs,       "C")
                THIS.this_cLins        = TratarNulo(Lins,        "C")
                THIS.this_cCols        = TratarNulo(Cols,        "C")
                THIS.this_cCUnis       = TratarNulo(CUnis,       "C")
                THIS.this_cCUnips      = TratarNulo(CUnips,      "C")
                THIS.this_nAlturas     = TratarNulo(Alturas,     "N")
                THIS.this_nLarguras    = TratarNulo(Larguras,    "N")
                THIS.this_nDiametros   = TratarNulo(Diametros,   "N")
                THIS.this_nEspessuras  = TratarNulo(Espessuras,  "N")
                THIS.this_nCompriments = TratarNulo(Compriments, "N")
                THIS.this_nPesoMs      = TratarNulo(PesoMs,      "N")
                THIS.this_nPesoBs      = TratarNulo(PesoBs,      "N")
                THIS.this_nPesoPmedios = TratarNulo(PesoPmedios, "N")
                THIS.this_cTams        = TratarNulo(Tams,        "C")
                THIS.this_cCorPros     = TratarNulo(CorPros,     "C")
                THIS.this_cCodFinPs    = TratarNulo(CodFinPs,    "C")
                THIS.this_cCodAcbs     = TratarNulo(CodAcbs,     "C")
                THIS.this_cLocals      = TratarNulo(Locals,      "C")
                THIS.this_cClasss      = TratarNulo(Classs,      "C")
                THIS.this_nPvens       = TratarNulo(Pvens,       "N")
                THIS.this_cMoevs       = TratarNulo(Moevs,       "C")
                THIS.this_nFvendas     = TratarNulo(Fvendas,     "N")
                THIS.this_cMfvendas    = TratarNulo(Mfvendas,    "C")
                THIS.this_nCustofs     = TratarNulo(Custofs,     "N")
                THIS.this_cMoecs       = TratarNulo(Moecs,       "C")
                THIS.this_nMargems     = TratarNulo(Margems,     "N")
                THIS.this_nQmins       = TratarNulo(Qmins,       "N")
                THIS.this_nLtMinsVs    = TratarNulo(LtMinsVs,    "N")
                THIS.this_nConjuntos   = TratarNulo(Conjuntos,   "N")
                THIS.this_nQtPeds      = TratarNulo(QtPeds,      "N")
                THIS.this_nGarVits     = TratarNulo(GarVits,     "N")
                THIS.this_nConsigs     = TratarNulo(Consigs,     "N")
                THIS.this_nFabrProprs  = TratarNulo(FabrProprs,  "N")
                THIS.this_nEncoms      = TratarNulo(Encoms,      "N")
                THIS.this_nProdWebs    = TratarNulo(ProdWebs,    "N")
                THIS.this_nOpcVars     = TratarNulo(OpcVars,     "N")
                THIS.this_nInstalas    = TratarNulo(Instalas,    "N")
                THIS.this_nSituas      = TratarNulo(Situas,      "N")
                THIS.this_dDtSituas    = TratarNulo(DtSituas,    "D")
                THIS.this_cObs1s       = TratarNulo(Obs1s,       "C")
                THIS.this_cObs2s       = TratarNulo(Obs2s,       "C")
                THIS.this_cObs3s       = TratarNulo(Obs3s,       "C")
                THIS.this_cDscCompras  = TratarNulo(DscCompras,  "C")
                THIS.this_cObsCompras  = TratarNulo(ObsCompras,  "C")
                THIS.this_cFwget3s     = TratarNulo(Fwget3s,     "C")
                THIS.this_cFwget4s     = TratarNulo(Fwget4s,     "C")
                THIS.this_cFwget5s     = TratarNulo(Fwget5s,     "C")
                THIS.this_cFwget6s     = TratarNulo(Fwget6s,     "C")
                THIS.this_cCodIdents   = TratarNulo(CodIdents,   "C")
                THIS.this_cTEnts       = TratarNulo(TEnts,       "C")
                THIS.this_nDiasGars    = TratarNulo(DiasGars,    "N")
                THIS.this_nQtMinFabs   = TratarNulo(QtMinFabs,   "N")
                THIS.this_cCodGarras   = TratarNulo(CodGarras,   "C")
                THIS.this_cConquilhas  = TratarNulo(Conquilhas,  "C")
                THIS.this_nPesoBris    = TratarNulo(PesoBris,    "N")
                THIS.this_nPesoMetal   = TratarNulo(PesoMetal,   "N")
                THIS.this_nPesoPdrs    = TratarNulo(PesoPdrs,    "N")
                THIS.this_nCravCers    = TratarNulo(CravCers,    "N")
                THIS.this_nVarias      = TratarNulo(Varias,      "N")
                THIS.this_nEstoques    = TratarNulo(Estoques,    "N")
                THIS.this_nQtdEsts     = TratarNulo(QtdEsts,     "N")
                THIS.this_dDtIncs      = TratarNulo(DtIncs,      "D")
                THIS.this_dDataAlts    = TratarNulo(DataAlts,    "D")
                THIS.this_cHoraAlts    = TratarNulo(HoraAlts,    "C")
                THIS.this_cUsuaIncs    = TratarNulo(UsuaIncs,    "C")
                THIS.this_cUsuaAlts    = TratarNulo(UsuaAlts,    "C")
                THIS.this_dDtucps      = TratarNulo(Dtucps,      "D")
                THIS.this_nVucps       = TratarNulo(Vucps,       "N")
                THIS.this_cMucps       = TratarNulo(Mucps,       "C")
                THIS.this_nQtdUltComps = TratarNulo(QtdUltComps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto do cursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Busca o produto no banco pelo CPros
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_nRet, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCodigo) OR gnConnHandle <= 0
                loc_lSucesso = loc_lSucesso
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodigo), 14)), ;
                "cursor_4c_ProdutoBO")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ProdutoBO") > 0
                THIS.CarregarDoCursor("cursor_4c_ProdutoBO")
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna cursor com lista de produtos (filtro SQL WHERE opcional)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        TRY
            IF USED("cursor_4c_BuscarBO")
                USE IN cursor_4c_BuscarBO
            ENDIF
            loc_cSQL = "SELECT CPros, DPros, CGrus, SGrus, Reffs, " + ;
                       "UsuaAlts, CAST(ISNULL(Instalas,0) AS INT) AS Instalas " + ;
                       "FROM SigCdPro"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY CPros"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscarBO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY
        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdPro (" + ;
                "CPros, DPros, DPro2s, CGrus, SGrus, IFors, Reffs, Colecoes, " + ;
                "Cbars, CProEqs, IdeCPros, Mercs, Lins, Cols, CUnis, CUnips, " + ;
                "Alturas, Larguras, Diametros, Espessuras, Compriments, " + ;
                "PesoMs, PesoBs, PesoPmedios, Tams, CorPros, CodFinPs, " + ;
                "CodAcbs, Locals, Classs, " + ;
                "Pvens, Moevs, Fvendas, Mfvendas, Custofs, Moecs, Margems, " + ;
                "Qmins, LtMinsVs, Conjuntos, QtPeds, DiasGars, " + ;
                "GarVits, Consigs, FabrProprs, Encoms, ProdWebs, OpcVars, Instalas, " + ;
                "Situas, DtSituas, Obs1s, Obs2s, Obs3s, DscCompras, ObsCompras, " + ;
                "Fwget3s, Fwget4s, Fwget5s, Fwget6s, CodIdents, TEnts, " + ;
                "QtMinFabs, CodGarras, Conquilhas, PesoBris, PesoMetal, PesoPdrs, CravCers, Varias, " + ;
                "DtIncs, UsuaIncs, DataAlts, UsuaAlts" + ;
                ") VALUES (" + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14)) + "," + ;
                EscaparSQL(THIS.this_cDpros) + "," + ;
                EscaparSQL(THIS.this_cDPro2s) + "," + ;
                EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                EscaparSQL(THIS.this_cIFors) + "," + ;
                EscaparSQL(THIS.this_cReffs) + "," + ;
                EscaparSQL(THIS.this_cColecoes) + "," + ;
                EscaparSQL(THIS.this_cCbars) + "," + ;
                EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                EscaparSQL(THIS.this_cMercs) + "," + ;
                EscaparSQL(THIS.this_cLins) + "," + ;
                EscaparSQL(THIS.this_cCols) + "," + ;
                EscaparSQL(THIS.this_cCUnis) + "," + ;
                EscaparSQL(THIS.this_cCUnips) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                EscaparSQL(THIS.this_cTams) + "," + ;
                EscaparSQL(THIS.this_cCorPros) + "," + ;
                EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cClasss) + "," + ;
                FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                EscaparSQL(THIS.this_cMoevs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                EscaparSQL(THIS.this_cMfvendas) + "," + ;
                FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                EscaparSQL(THIS.this_cMoecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                EscaparSQL(THIS.this_cObs1s) + "," + ;
                EscaparSQL(THIS.this_cObs2s) + "," + ;
                EscaparSQL(THIS.this_cObs3s) + "," + ;
                EscaparSQL(THIS.this_cDscCompras) + "," + ;
                EscaparSQL(THIS.this_cObsCompras) + "," + ;
                EscaparSQL(THIS.this_cFwget3s) + "," + ;
                EscaparSQL(THIS.this_cFwget4s) + "," + ;
                EscaparSQL(THIS.this_cFwget5s) + "," + ;
                EscaparSQL(THIS.this_cFwget6s) + "," + ;
                EscaparSQL(THIS.this_cCodIdents) + "," + ;
                EscaparSQL(THIS.this_cTEnts) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                EscaparSQL(THIS.this_cCodGarras) + "," + ;
                EscaparSQL(THIS.this_cConquilhas) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ;
                ")"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "DPros       = " + EscaparSQL(THIS.this_cDpros) + "," + ;
                "DPro2s      = " + EscaparSQL(THIS.this_cDPro2s) + "," + ;
                "CGrus       = " + EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                "SGrus       = " + EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                "IFors       = " + EscaparSQL(THIS.this_cIFors) + "," + ;
                "Reffs       = " + EscaparSQL(THIS.this_cReffs) + "," + ;
                "Colecoes    = " + EscaparSQL(THIS.this_cColecoes) + "," + ;
                "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
                "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
                "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
                "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
                "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
                "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
                "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
                "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
                "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
                "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
                "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
                "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
                "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
                "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
                "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
                "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
                "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
                "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
                "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
                "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
                "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
                "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
                "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
                "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
                "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;
                "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                "PesoMetal   = " + FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                "PesoPdrs    = " + FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                "CravCers    = " + FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                "Varias      = " + FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "DataAlts    = GETDATE()," + ;
                "UsuaAlts    = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE CPros = " + EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdPro (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

