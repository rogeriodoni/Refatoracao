# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_OPCONTA, CNT_4C_OPESTOQUE, CNT_4C_OPCUSTO, CNT_4C_OPCOMPRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'OpEstoque' (parent: SIGPRCCC): Top original=200 vs migrado 'cnt_4c_OpEstoque' Top=2 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpEstoque' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpEstoque' Left=182 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpConta' (parent: SIGPRCCC): Top original=114 vs migrado 'cnt_4c_OpConta' Top=2 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpConta' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpConta' Left=171 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGPRCCC): Left original=425 vs migrado 'cnt_4c_OpEstoque' Left=182 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGPRCCC): Left original=350 vs migrado 'cnt_4c_OpConta' Left=171 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpCusto' (parent: SIGPRCCC): Top original=349 vs migrado 'cnt_4c_OpCusto' Top=2 (diff=347px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpCompra' (parent: SIGPRCCC): Top original=447 vs migrado 'cnt_4c_OpCompra' Top=2 (diff=445px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2064 linhas total):

*-- Linhas 37 a 141:
37:     LarguraOpCompra  = 536
38: 
39:     *==========================================================================
40:     PROCEDURE Init()
41:     *==========================================================================
42:         *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4) - corrigir antes de DODEFAULT
43:         SET DATE TO BRITISH
44:         SET CENTURY ON
45:         RETURN DODEFAULT()
46:     ENDPROC
47: 
48:     *==========================================================================
49:     PROTECTED PROCEDURE InicializarForm
50:     *==========================================================================
51:         LOCAL loc_lSucesso
52:         loc_lSucesso = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
56:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
57:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrCcc.", "Erro")
58:             ELSE
59:                 *-- Inicializa parametros do sistema (SigCdPam)
60:                 THIS.this_oBusinessObject.InicializarDados()
61: 
62:                 *-- Monta interface visual
63:                 THIS.ConfigurarPageFrame()
64:                 THIS.ConfigurarCabecalho()
65:                 THIS.ConfigurarControlesPrincipais()
66:                 THIS.ConfigurarContainerOpConta()
67:                 THIS.ConfigurarContainerOpEstoque()
68:                 THIS.ConfigurarContainerOpCusto()
69:                 THIS.ConfigurarContainerOpCompra()
70:                 THIS.TornarControlesVisiveis()
71:                 THIS.ConfigurarBINDEVENTs()
72: 
73:                 *-- Propagar titulo para labels do cabecalho
74:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
75:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
76: 
77:                 *-- Estado inicial do contador de registros
78:                 THIS.txt_4c_Registro.Value = 0
79: 
80:                 loc_lSucesso = .T.
81:             ENDIF
82:         CATCH TO loc_oErro
83:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
84:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.InicializarForm")
85:         ENDTRY
86: 
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *==========================================================================
91:     * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
92:     *==========================================================================
93:     PROTECTED PROCEDURE ConfigurarPageFrame
94:         THIS.Picture     = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
95:         THIS.ClipControls = .F.
96:     ENDPROC
97: 
98:     *==========================================================================
99:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
100:     *==========================================================================
101:     PROTECTED PROCEDURE ConfigurarCabecalho
102:         THIS.AddObject("cnt_4c_Sombra", "Container")
103:         WITH THIS.cnt_4c_Sombra
104:             .Visible    = .T.
105:             .Top        = 0
106:             .Left       = 0
107:             .Width      = THIS.Width
108:             .Height     = 80
109:             .BorderWidth= 0
110:             .BackColor  = RGB(100,100,100)
111:             .AddObject("lbl_4c_Sombra", "Label")
112:             WITH .lbl_4c_Sombra
113:                 .FontBold      = .T.
114:                 .FontName      = "Tahoma"
115:                 .FontSize      = 18
116:                 .FontUnderline = .F.
117:                 .WordWrap      = .T.
118:                 .Alignment     = 0
119:                 .AutoSize      = .F.
120:                 .BackStyle     = 0
121:                 .Caption       = THIS.Caption
122:                 .Height        = 40
123:                 .Left          = 10
124:                 .Top           = 18
125:                 .Width         = THIS.Width
126:                 .ForeColor     = RGB(0,0,0)
127:             ENDWITH
128:             .AddObject("lbl_4c_Titulo", "Label")
129:             WITH .lbl_4c_Titulo
130:                 .FontBold   = .T.
131:                 .FontName   = "Tahoma"
132:                 .FontSize   = 18
133:                 .WordWrap   = .T.
134:                 .Alignment  = 0
135:                 .AutoSize   = .F.
136:                 .BackStyle  = 0
137:                 .Caption    = THIS.Caption
138:                 .Height     = 46
139:                 .Left       = 10
140:                 .Top        = 17
141:                 .Width      = THIS.Width

*-- Linhas 147 a 190:
147:     *==========================================================================
148:     * ConfigurarControlesPrincipais - Shape, CheckBoxes, Botoes, LblEnd, Registro
149:     *==========================================================================
150:     PROTECTED PROCEDURE ConfigurarControlesPrincipais
151:         *-- Shape decorativo (Shape1 original)
152:         THIS.AddObject("shp_4c_Shape1", "Shape")
153:         WITH THIS.shp_4c_Shape1
154:             .Top         = 7
155:             .Left        = 697
156:             .Height      = 110
157:             .Width       = 90
158:             .BackStyle   = 0
159:             .BorderStyle = 0
160:             .BorderColor = RGB(136,189,188)
161:         ENDWITH
162: 
163:         *-- CheckBox C.C. (Conta original - Left=350)
164:         THIS.AddObject("chk_4c_Conta", "CheckBox")
165:         WITH THIS.chk_4c_Conta
166:             .Top           = 3
167:             .Left          = 350
168:             .Height        = 75
169:             .Width         = 75
170:             .FontBold      = .T.
171:             .FontItalic    = .T.
172:             .FontName      = "Tahoma"
173:             .FontSize      = 8
174:             .AutoSize      = .F.
175:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
176:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
177:             .Alignment     = 1
178:             .BackStyle     = 0
179:             .Caption       = "C.C."
180:             .Value         = 0
181:             .SpecialEffect = 0
182:             .Style         = 1
183:             .ToolTipText   = "Conta Corrente"
184:             .ForeColor     = RGB(90,90,90)
185:             .BackColor     = RGB(255,255,255)
186:             .Themes        = .F.
187:         ENDWITH
188: 
189:         *-- CheckBox Estoque (Estoque original - Left=425)
190:         THIS.AddObject("chk_4c_Estoque", "CheckBox")

*-- Linhas 363 a 407:
363: 
364:     *==========================================================================
365:     * ConfigurarContainerOpConta - Conta Corrente: empresa, grupo, conta, moeda, data
366:     *==========================================================================
367:     PROTECTED PROCEDURE ConfigurarContainerOpConta
368:         THIS.AddObject("cnt_4c_OpConta", "Container")
369:         WITH THIS.cnt_4c_OpConta
370:             .Top           = 114
371:             .Left          = 139
372:             .Width         = THIS.LarguraOpConta
373:             .Height        = 81
374:             .BackStyle     = 0
375:             .BorderWidth   = 2
376:             .SpecialEffect = 2
377:             .Visible       = .F.
378:             .BackColor     = RGB(192,192,255)
379:             .BorderColor   = RGB(90,90,90)
380: 
381:             .AddObject("lbl_4c_TituloOp", "Label")
382:             WITH .lbl_4c_TituloOp
383:                 .AutoSize      = .T.
384:                 .FontBold      = .T.
385:                 .FontName      = "Tahoma"
386:                 .FontSize      = 8
387:                 .FontUnderline = .T.
388:                 .BackStyle     = 0
389:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
390:                 .Left          = 171
391:                 .Top           = 2
392:                 .ForeColor     = RGB(90,90,90)
393:             ENDWITH
394: 
395:             .AddObject("lbl_4c_LblEmpresa", "Label")
396:             WITH .lbl_4c_LblEmpresa
397:                 .AutoSize   = .T.
398:                 .FontBold   = .T.
399:                 .FontName   = "Tahoma"
400:                 .FontSize   = 8
401:                 .BackStyle  = 0
402:                 .Caption    = "Empresa :"
403:                 .Height     = 15
404:                 .Left       = 16
405:                 .Top        = 23
406:                 .Width      = 57
407:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 538 a 582:
538: 
539:     *==========================================================================
540:     * ConfigurarContainerOpEstoque - Estoque: empresa, grupo, estoque, produto, desc, data
541:     *==========================================================================
542:     PROTECTED PROCEDURE ConfigurarContainerOpEstoque
543:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
544:         WITH THIS.cnt_4c_OpEstoque
545:             .Top           = 200
546:             .Left          = 139
547:             .Width         = THIS.LarguraOpEstoque
548:             .Height        = 143
549:             .BackStyle     = 0
550:             .BorderWidth   = 2
551:             .SpecialEffect = 2
552:             .Visible       = .F.
553:             .BackColor     = RGB(192,192,255)
554:             .BorderColor   = RGB(90,90,90)
555: 
556:             .AddObject("lbl_4c_TituloOp", "Label")
557:             WITH .lbl_4c_TituloOp
558:                 .AutoSize      = .T.
559:                 .FontBold      = .T.
560:                 .FontName      = "Tahoma"
561:                 .FontSize      = 8
562:                 .FontUnderline = .T.
563:                 .BackStyle     = 0
564:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Estoque"
565:                 .Left          = 182
566:                 .Top           = 2
567:                 .ForeColor     = RGB(90,90,90)
568:             ENDWITH
569: 
570:             .AddObject("lbl_4c_LblEmpresa", "Label")
571:             WITH .lbl_4c_LblEmpresa
572:                 .AutoSize   = .T.
573:                 .FontBold   = .T.
574:                 .FontName   = "Tahoma"
575:                 .FontSize   = 8
576:                 .BackStyle  = 0
577:                 .Caption    = "Empresa :"
578:                 .Height     = 15
579:                 .Left       = 31
580:                 .Top        = 15
581:                 .Width      = 57
582:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 725 a 769:
725: 
726:     *==========================================================================
727:     * ConfigurarContainerOpCusto - Custo de Produto: empresa, produto, desc, data
728:     *==========================================================================
729:     PROTECTED PROCEDURE ConfigurarContainerOpCusto
730:         THIS.AddObject("cnt_4c_OpCusto", "Container")
731:         WITH THIS.cnt_4c_OpCusto
732:             .Top           = 349
733:             .Left          = 139
734:             .Width         = THIS.LarguraOpCusto
735:             .Height        = 92
736:             .BackStyle     = 0
737:             .BorderWidth   = 2
738:             .SpecialEffect = 2
739:             .Visible       = .F.
740:             .BackColor     = RGB(192,192,255)
741:             .BorderColor   = RGB(90,90,90)
742: 
743:             .AddObject("lbl_4c_TituloOp", "Label")
744:             WITH .lbl_4c_TituloOp
745:                 .AutoSize      = .T.
746:                 .FontBold      = .T.
747:                 .FontName      = "Tahoma"
748:                 .FontSize      = 8
749:                 .FontUnderline = .T.
750:                 .BackStyle     = 0
751:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
752:                 .Left          = 155
753:                 .Top           = 2
754:                 .ForeColor     = RGB(90,90,90)
755:             ENDWITH
756: 
757:             .AddObject("lbl_4c_LblEmpresa", "Label")
758:             WITH .lbl_4c_LblEmpresa
759:                 .AutoSize   = .T.
760:                 .FontBold   = .T.
761:                 .FontName   = "Tahoma"
762:                 .FontSize   = 8
763:                 .BackStyle  = 0
764:                 .Caption    = "Empresa :"
765:                 .Height     = 15
766:                 .Left       = 31
767:                 .Top        = 14
768:                 .Width      = 57
769:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 857 a 901:
857: 
858:     *==========================================================================
859:     * ConfigurarContainerOpCompra - Ultima Compra: empresa, produto, desc, data
860:     *==========================================================================
861:     PROTECTED PROCEDURE ConfigurarContainerOpCompra
862:         THIS.AddObject("cnt_4c_OpCompra", "Container")
863:         WITH THIS.cnt_4c_OpCompra
864:             .Top           = 447
865:             .Left          = 139
866:             .Width         = THIS.LarguraOpCompra
867:             .Height        = 91
868:             .BackStyle     = 0
869:             .BorderWidth   = 2
870:             .SpecialEffect = 2
871:             .Visible       = .F.
872:             .BackColor     = RGB(192,192,255)
873:             .BorderColor   = RGB(90,90,90)
874: 
875:             .AddObject("lbl_4c_TituloOp", "Label")
876:             WITH .lbl_4c_TituloOp
877:                 .AutoSize      = .T.
878:                 .FontBold      = .T.
879:                 .FontName      = "Tahoma"
880:                 .FontSize      = 8
881:                 .FontUnderline = .T.
882:                 .BackStyle     = 0
883:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Ultima Compra do Produto/Cliente"
884:                 .Left          = 140
885:                 .Top           = 2
886:                 .ForeColor     = RGB(90,90,90)
887:             ENDWITH
888: 
889:             .AddObject("lbl_4c_LblEmpresa", "Label")
890:             WITH .lbl_4c_LblEmpresa
891:                 .AutoSize   = .T.
892:                 .FontBold   = .T.
893:                 .FontName   = "Tahoma"
894:                 .FontSize   = 8
895:                 .BackStyle  = 0
896:                 .Caption    = "Empresa :"
897:                 .Height     = 15
898:                 .Left       = 31
899:                 .Top        = 14
900:                 .Width      = 57
901:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 988 a 2064:
988:     ENDPROC
989: 
990:     *==========================================================================
991:     * TornarControlesVisiveis - torna controles visiveis exceto containers
992:     * flutuantes que devem comecar ocultos (OpConta, OpEstoque, OpCusto, OpCompra)
993:     *==========================================================================
994:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
995:         LOCAL loc_i, loc_oControl, loc_cNome
996: 
997:         IF PCOUNT() = 0
998:             par_oContainer = THIS
999:         ENDIF
1000: 
1001:         FOR loc_i = 1 TO par_oContainer.ControlCount
1002:             loc_oControl = par_oContainer.Controls(loc_i)
1003:             IF VARTYPE(loc_oControl) # "O"
1004:                 LOOP
1005:             ENDIF
1006: 
1007:             loc_cNome = UPPER(loc_oControl.Name)
1008: 
1009:             *-- Containers com Visible controlado explicitamente: nao forcar .T.
1010:             IF INLIST(loc_cNome, "CNT_4C_SOMBRA", ;
1011:                                  "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1012:                                  "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
1013:                 *-- Tornar filhos visiveis sem tocar Visible do proprio container
1014:                 THIS.TornarControlesVisiveis(loc_oControl)
1015:                 LOOP
1016:             ENDIF
1017: 
1018:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1019:                 loc_oControl.Visible = .T.
1020:             ENDIF
1021: 
1022:             *-- Recursar em containers e pageframes
1023:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1024:                loc_oControl.ControlCount > 0
1025:                 THIS.TornarControlesVisiveis(loc_oControl)
1026:             ENDIF
1027:         ENDFOR
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * ConfigurarBINDEVENTs - handlers dos checkboxes e botoes
1032:     *==========================================================================
1033:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1034:         *-- CheckBoxes e botoes principais
1035:         BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
1036:         BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
1037:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkCustoClick")
1038:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkCompraClick")
1039:         BINDEVENT(THIS.cmd_4c_Processa,  "Click", THIS, "BtnProcessarClick")
1040:         BINDEVENT(THIS.cmd_4c_Cancela,   "Click", THIS, "BtnCancelaClick")
1041: 
1042:         *-- OpConta: Empresa, Grupos, Contas, Moedas
1043:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_Empresa,   "KeyPress", THIS, "TxtContaEmpresaKeyPress")
1044:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtContaGruposKeyPress")
1045:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "KeyPress", THIS, "TxtContaContasKeyPress")
1046:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas, "KeyPress", THIS, "TxtContaMoedasKeyPress")
1047: 
1048:         *-- OpEstoque: Empresa, Grupos, Estoque, Produto
1049:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Empresa,   "KeyPress", THIS, "TxtEstEmpresaKeyPress")
1050:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtEstGruposKeyPress")
1051:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Estoque,   "KeyPress", THIS, "TxtEstEstoqueKeyPress")
1052:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Produto,   "KeyPress", THIS, "TxtEstProdutoKeyPress")
1053: 
1054:         *-- OpCusto: Empresa, Produto
1055:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_Empresa, "KeyPress", THIS, "TxtCustoEmpresaKeyPress")
1056:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_Produto, "KeyPress", THIS, "TxtCustoProdutoKeyPress")
1057: 
1058:         *-- OpCompra: Empresa, Produto
1059:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_Empresa, "KeyPress", THIS, "TxtCompraEmpresaKeyPress")
1060:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_Produto, "KeyPress", THIS, "TxtCompraProdutoKeyPress")
1061:     ENDPROC
1062: 
1063:     *==========================================================================
1064:     * BtnProcessarClick - orquestrador do processamento
1065:     *==========================================================================
1066:     PROCEDURE BtnProcessarClick
1067:         LOCAL loc_lSucesso, loc_lAlgum, loc_oBO, loc_oProgress
1068: 
1069:         loc_lSucesso = .F.
1070:         loc_lAlgum   = .F.
1071:         loc_oProgress = .NULL.
1072: 
1073:         IF THIS.chk_4c_Conta.Value = 0 AND THIS.chk_4c_Estoque.Value = 0 AND ;
1074:            THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1075:             MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + "lculo.")
1076:             RETURN .F.
1077:         ENDIF
1078: 
1079:         TRY
1080:             *-- Desabilitar controles durante processamento
1081:             THIS.chk_4c_Conta.Enabled     = .F.
1082:             THIS.chk_4c_Estoque.Enabled   = .F.
1083:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1084:             THIS.chk_4c_BtnCompra.Enabled = .F.
1085:             THIS.cmd_4c_Processa.Enabled  = .F.
1086:             THIS.cmd_4c_Cancela.Enabled   = .F.
1087:             THIS.lbl_4c_LblEnd.Visible    = .F.
1088:             THIS.txt_4c_Registro.Value    = 0
1089:             DOEVENTS
1090: 
1091:             loc_oBO = THIS.this_oBusinessObject
1092:             loc_oBO.this_nRegistros = 0
1093: 
1094:             loc_oProgress = CREATEOBJECT("fwprogressbar")
1095:             IF VARTYPE(loc_oProgress) = "O"
1096:                 loc_oProgress.Show()
1097:             ENDIF
1098: 
1099:             *-- Recalcular Conta Corrente
1100:             IF THIS.chk_4c_Conta.Value = 1
1101:                 loc_oBO.this_cEmpConta   = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_Empresa.Value)
1102:                 loc_oBO.this_cGrupoConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos.Value)
1103:                 loc_oBO.this_cConta      = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtContas.Value)
1104:                 loc_oBO.this_cMoedaConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas.Value)
1105:                 loc_oBO.this_dDataConta  = THIS.cnt_4c_OpConta.txt_4c_TxtData.Value
1106:                 IF VARTYPE(loc_oProgress) = "O"
1107:                     loc_oProgress.Update("Recalculando Conta Corrente...")
1108:                 ENDIF
1109:                 IF loc_oBO.RecalcularSaldosConta()
1110:                     loc_lAlgum = .T.
1111:                 ENDIF
1112:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1113:                 DOEVENTS
1114:             ENDIF
1115: 
1116:             *-- Recalcular Estoque
1117:             IF THIS.chk_4c_Estoque.Value = 1
1118:                 loc_oBO.this_cEmpEst   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value)
1119:                 loc_oBO.this_cGrupoEst = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos.Value)
1120:                 loc_oBO.this_cEstoque  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Estoque.Value)
1121:                 loc_oBO.this_cProdEst  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Produto.Value)
1122:                 loc_oBO.this_dDataEst  = THIS.cnt_4c_OpEstoque.txt_4c_TxtData.Value
1123:                 IF VARTYPE(loc_oProgress) = "O"
1124:                     loc_oProgress.Update("Recalculando Estoque...")
1125:                 ENDIF
1126:                 IF loc_oBO.RecalcularSaldosEstoque()
1127:                     loc_lAlgum = .T.
1128:                 ENDIF
1129:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1130:                 DOEVENTS
1131:             ENDIF
1132: 
1133:             *-- Recalcular Custo de Produto
1134:             IF THIS.chk_4c_BtnCusto.Value = 1
1135:                 loc_oBO.this_cEmpCusto  = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value)
1136:                 loc_oBO.this_cProdCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Produto.Value)
1137:                 loc_oBO.this_dDataCusto = THIS.cnt_4c_OpCusto.txt_4c_TxtData.Value
1138:                 IF VARTYPE(loc_oProgress) = "O"
1139:                     loc_oProgress.Update("Recalculando Custo de Produto...")
1140:                 ENDIF
1141:                 IF loc_oBO.RecalcularSaldosCusto()
1142:                     loc_lAlgum = .T.
1143:                 ENDIF
1144:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1145:                 DOEVENTS
1146:             ENDIF
1147: 
1148:             *-- Recalcular Ultima Compra
1149:             IF THIS.chk_4c_BtnCompra.Value = 1
1150:                 loc_oBO.this_cEmpCompra  = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value)
1151:                 loc_oBO.this_cProdCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Produto.Value)
1152:                 loc_oBO.this_dDataCompra = THIS.cnt_4c_OpCompra.txt_4c_TxtData.Value
1153:                 IF VARTYPE(loc_oProgress) = "O"
1154:                     loc_oProgress.Update(CHR(218) + "ltima Compra...")
1155:                 ENDIF
1156:                 IF loc_oBO.RecalcularSaldosCompra()
1157:                     loc_lAlgum = .T.
1158:                 ENDIF
1159:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1160:                 DOEVENTS
1161:             ENDIF
1162: 
1163:             IF loc_lAlgum
1164:                 THIS.lbl_4c_LblEnd.Visible = .T.
1165:             ENDIF
1166: 
1167:             loc_lSucesso = .T.
1168:         CATCH TO loc_oErro
1169:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1170:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.BtnProcessarClick")
1171:         ENDTRY
1172: 
1173:         *-- Reabilitar controles
1174:         THIS.chk_4c_Conta.Enabled     = .T.
1175:         THIS.chk_4c_Estoque.Enabled   = .T.
1176:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1177:         THIS.chk_4c_BtnCompra.Enabled = .T.
1178:         THIS.cmd_4c_Cancela.Enabled   = .T.
1179:         THIS.AtualizarEstadoProcessa()
1180: 
1181:         IF VARTYPE(loc_oProgress) = "O"
1182:             loc_oProgress.Release()
1183:             loc_oProgress = .NULL.
1184:         ENDIF
1185: 
1186:         RETURN loc_lSucesso
1187:     ENDPROC
1188: 
1189:     *==========================================================================
1190:     * BtnCancelaClick - fecha o formulario
1191:     *==========================================================================
1192:     PROCEDURE BtnCancelaClick
1193:         THISFORM.Release()
1194:     ENDPROC
1195: 
1196:     *==========================================================================
1197:     * ChkContaClick / ChkEstoqueClick / ChkCustoClick / ChkCompraClick
1198:     *==========================================================================
1199:     PROCEDURE ChkContaClick
1200:         THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
1201:         THIS.AtualizarEstadoProcessa()
1202:     ENDPROC
1203: 
1204:     PROCEDURE ChkEstoqueClick
1205:         THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
1206:         THIS.AtualizarEstadoProcessa()
1207:     ENDPROC
1208: 
1209:     PROCEDURE ChkCustoClick
1210:         THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
1211:         THIS.AtualizarEstadoProcessa()
1212:     ENDPROC
1213: 
1214:     PROCEDURE ChkCompraClick
1215:         THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
1216:         THIS.AtualizarEstadoProcessa()
1217:     ENDPROC
1218: 
1219:     PROTECTED PROCEDURE AtualizarEstadoProcessa
1220:         LOCAL loc_lAlgum
1221:         loc_lAlgum = (THIS.chk_4c_Conta.Value = 1) OR ;
1222:                      (THIS.chk_4c_Estoque.Value = 1) OR ;
1223:                      (THIS.chk_4c_BtnCusto.Value = 1) OR ;
1224:                      (THIS.chk_4c_BtnCompra.Value = 1)
1225:         THIS.cmd_4c_Processa.Enabled = loc_lAlgum
1226:     ENDPROC
1227: 
1228:     *==========================================================================
1229:     * KeyPress handlers - OpConta
1230:     *==========================================================================
1231:     PROCEDURE TxtContaEmpresaKeyPress
1232:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1233:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1234:             RETURN
1235:         ENDIF
1236:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_Empresa)
1237:     ENDPROC
1238: 
1239:     PROCEDURE TxtContaGruposKeyPress
1240:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1241:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1242:             RETURN
1243:         ENDIF
1244:         THIS.AbrirLookupGruposCcr(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
1245:     ENDPROC
1246: 
1247:     PROCEDURE TxtContaContasKeyPress
1248:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1249:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1250:             RETURN
1251:         ENDIF
1252:         THIS.AbrirLookupContas(THIS.cnt_4c_OpConta.txt_4c_TxtContas)
1253:     ENDPROC
1254: 
1255:     PROCEDURE TxtContaMoedasKeyPress
1256:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1257:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1258:             RETURN
1259:         ENDIF
1260:         THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas)
1261:     ENDPROC
1262: 
1263:     *==========================================================================
1264:     * KeyPress handlers - OpEstoque
1265:     *==========================================================================
1266:     PROCEDURE TxtEstEmpresaKeyPress
1267:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1268:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1269:             RETURN
1270:         ENDIF
1271:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_Empresa)
1272:     ENDPROC
1273: 
1274:     PROCEDURE TxtEstGruposKeyPress
1275:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1276:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1277:             RETURN
1278:         ENDIF
1279:         THIS.AbrirLookupGruposEst(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
1280:     ENDPROC
1281: 
1282:     PROCEDURE TxtEstEstoqueKeyPress
1283:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1284:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1285:             RETURN
1286:         ENDIF
1287:         THIS.AbrirLookupEstoque(THIS.cnt_4c_OpEstoque.txt_4c_Estoque)
1288:     ENDPROC
1289: 
1290:     PROCEDURE TxtEstProdutoKeyPress
1291:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1292:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1293:             RETURN
1294:         ENDIF
1295:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
1296:     ENDPROC
1297: 
1298:     *==========================================================================
1299:     * KeyPress handlers - OpCusto
1300:     *==========================================================================
1301:     PROCEDURE TxtCustoEmpresaKeyPress
1302:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1303:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1304:             RETURN
1305:         ENDIF
1306:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_Empresa)
1307:     ENDPROC
1308: 
1309:     PROCEDURE TxtCustoProdutoKeyPress
1310:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1311:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1312:             RETURN
1313:         ENDIF
1314:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * KeyPress handlers - OpCompra
1319:     *==========================================================================
1320:     PROCEDURE TxtCompraEmpresaKeyPress
1321:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1322:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1323:             RETURN
1324:         ENDIF
1325:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_Empresa)
1326:     ENDPROC
1327: 
1328:     PROCEDURE TxtCompraProdutoKeyPress
1329:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1330:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1331:             RETURN
1332:         ENDIF
1333:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
1334:     ENDPROC
1335: 
1336:     *==========================================================================
1337:     * AbrirLookupEmpresa - sigcdemp (cemps / razas)
1338:     *==========================================================================
1339:     PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
1340:         LOCAL loc_oForm, loc_cVal
1341:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1342:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1343:             "sigcdemp", "cursor_4c_LkpEmp", "cemps", loc_cVal, "Selecionar Empresa")
1344:         IF ISNULL(loc_oForm)
1345:             RETURN
1346:         ENDIF
1347:         IF NOT loc_oForm.this_lAchouRegistro
1348:             loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "d.")
1349:             loc_oForm.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
1350:             loc_oForm.Show()
1351:         ENDIF
1352:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpEmp")
1353:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpEmp.cemps)
1354:         ENDIF
1355:         IF USED("cursor_4c_LkpEmp")
1356:             USE IN cursor_4c_LkpEmp
1357:         ENDIF
1358:         loc_oForm.Release()
1359:     ENDPROC
1360: 
1361:     *==========================================================================
1362:     * AbrirLookupGruposCcr - SigCdGcr (codigos / descrs)
1363:     *==========================================================================
1364:     PROTECTED PROCEDURE AbrirLookupGruposCcr(par_oTxt)
1365:         LOCAL loc_oForm, loc_cVal
1366:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1367:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1368:             "SigCdGcr", "cursor_4c_LkpGcr", "codigos", loc_cVal, "Grupo C/C")
1369:         IF ISNULL(loc_oForm)
1370:             RETURN
1371:         ENDIF
1372:         IF NOT loc_oForm.this_lAchouRegistro
1373:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
1374:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1375:             loc_oForm.Show()
1376:         ENDIF
1377:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpGcr")
1378:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpGcr.codigos)
1379:         ENDIF
1380:         IF USED("cursor_4c_LkpGcr")
1381:             USE IN cursor_4c_LkpGcr
1382:         ENDIF
1383:         loc_oForm.Release()
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * AbrirLookupContas - SigCdCli (Iclis / Rclis)
1388:     *==========================================================================
1389:     PROTECTED PROCEDURE AbrirLookupContas(par_oTxt)
1390:         LOCAL loc_oForm, loc_cVal
1391:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1392:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1393:             "SigCdCli", "cursor_4c_LkpCcr", "Iclis", loc_cVal, "Conta Corrente")
1394:         IF ISNULL(loc_oForm)
1395:             RETURN
1396:         ENDIF
1397:         IF NOT loc_oForm.this_lAchouRegistro
1398:             loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
1399:             loc_oForm.mAddColuna("Rclis", "", "Nome")
1400:             loc_oForm.Show()
1401:         ENDIF
1402:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpCcr")
1403:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpCcr.Iclis)
1404:         ENDIF
1405:         IF USED("cursor_4c_LkpCcr")
1406:             USE IN cursor_4c_LkpCcr
1407:         ENDIF
1408:         loc_oForm.Release()
1409:     ENDPROC
1410: 
1411:     *==========================================================================
1412:     * AbrirLookupMoeda - SigCdMoe (cmoes / dmoes)
1413:     *==========================================================================
1414:     PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
1415:         LOCAL loc_oForm, loc_cVal
1416:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1417:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1418:             "SigCdMoe", "cursor_4c_LkpMoe", "cmoes", loc_cVal, "Selecionar Moeda")
1419:         IF ISNULL(loc_oForm)
1420:             RETURN
1421:         ENDIF
1422:         IF NOT loc_oForm.this_lAchouRegistro
1423:             loc_oForm.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
1424:             loc_oForm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1425:             loc_oForm.Show()
1426:         ENDIF
1427:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpMoe")
1428:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpMoe.cmoes)
1429:         ENDIF
1430:         IF USED("cursor_4c_LkpMoe")
1431:             USE IN cursor_4c_LkpMoe
1432:         ENDIF
1433:         loc_oForm.Release()
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * AbrirLookupProduto - SigCdPro (cpros / dpros) + atualiza descricao
1438:     *==========================================================================
1439:     PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtProd, par_oTxtDesc)
1440:         LOCAL loc_oForm, loc_cVal
1441:         loc_cVal  = ALLTRIM(par_oTxtProd.Value)
1442:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1443:             "SigCdPro", "cursor_4c_LkpPro", "cpros", loc_cVal, "Selecionar Produto")
1444:         IF ISNULL(loc_oForm)
1445:             RETURN
1446:         ENDIF
1447:         IF NOT loc_oForm.this_lAchouRegistro
1448:             loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
1449:             loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1450:             loc_oForm.Show()
1451:         ENDIF
1452:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpPro")
1453:             par_oTxtProd.Value = ALLTRIM(cursor_4c_LkpPro.cpros)
1454:             IF VARTYPE(par_oTxtDesc) = "O"
1455:                 par_oTxtDesc.Value = ALLTRIM(cursor_4c_LkpPro.dpros)
1456:             ENDIF
1457:         ENDIF
1458:         IF USED("cursor_4c_LkpPro")
1459:             USE IN cursor_4c_LkpPro
1460:         ENDIF
1461:         loc_oForm.Release()
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * AbrirLookupGruposEst - SigMvHst grupos (grupo de deposito)
1466:     *==========================================================================
1467:     PROTECTED PROCEDURE AbrirLookupGruposEst(par_oTxt)
1468:         LOCAL loc_oForm, loc_cVal
1469:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1470:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1471:             "SigMvHst", "cursor_4c_LkpGruEst", "grupos", loc_cVal, ;
1472:             "Grupo de Dep" + CHR(243) + "sito")
1473:         IF ISNULL(loc_oForm)
1474:             RETURN
1475:         ENDIF
1476:         IF NOT loc_oForm.this_lAchouRegistro
1477:             loc_oForm.mAddColuna("grupos", "", "Grupo")
1478:             loc_oForm.mAddColuna("estos",  "", "Estoque")
1479:             loc_oForm.Show()
1480:         ENDIF
1481:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpGruEst")
1482:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpGruEst.grupos)
1483:         ENDIF
1484:         IF USED("cursor_4c_LkpGruEst")
1485:             USE IN cursor_4c_LkpGruEst
1486:         ENDIF
1487:         loc_oForm.Release()
1488:     ENDPROC
1489: 
1490:     *==========================================================================
1491:     * AbrirLookupEstoque - SigMvHst estos (codigo do deposito)
1492:     *==========================================================================
1493:     PROTECTED PROCEDURE AbrirLookupEstoque(par_oTxt)
1494:         LOCAL loc_oForm, loc_cVal
1495:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1496:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1497:             "SigMvHst", "cursor_4c_LkpEst", "estos", loc_cVal, ;
1498:             "Dep" + CHR(243) + "sito/Estoque")
1499:         IF ISNULL(loc_oForm)
1500:             RETURN
1501:         ENDIF
1502:         IF NOT loc_oForm.this_lAchouRegistro
1503:             loc_oForm.mAddColuna("estos",  "", "Estoque")
1504:             loc_oForm.mAddColuna("grupos", "", "Grupo")
1505:             loc_oForm.Show()
1506:         ENDIF
1507:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpEst")
1508:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpEst.estos)
1509:         ENDIF
1510:         IF USED("cursor_4c_LkpEst")
1511:             USE IN cursor_4c_LkpEst
1512:         ENDIF
1513:         loc_oForm.Release()
1514:     ENDPROC
1515: 
1516:     *==========================================================================
1517:     * ConfigurarPaginaLista - Reset da UI ao estado inicial de sele" + CHR(231) + CHR(227) + "o
1518:     * Form OPERACIONAL: nao ha Page1/Page2 (layout flat), este metodo
1519:     * restaura o estado limpo equivalente a "voltar para a lista" ??? oculta
1520:     * containers flutuantes, desmarca opcoes, zera contador e mensagem final.
1521:     * Chamado apos processamento concluir OU quando quiser reiniciar selecao.
1522:     *==========================================================================
1523:     PROTECTED PROCEDURE ConfigurarPaginaLista
1524:         *-- Desmarca todos os checkboxes de opcao (Conta, Estoque, Custo, Compra)
1525:         THIS.chk_4c_Conta.Value     = 0
1526:         THIS.chk_4c_Estoque.Value   = 0
1527:         THIS.chk_4c_BtnCusto.Value  = 0
1528:         THIS.chk_4c_BtnCompra.Value = 0
1529: 
1530:         *-- Oculta todos os containers flutuantes de opcoes
1531:         THIS.cnt_4c_OpConta.Visible   = .F.
1532:         THIS.cnt_4c_OpEstoque.Visible = .F.
1533:         THIS.cnt_4c_OpCusto.Visible   = .F.
1534:         THIS.cnt_4c_OpCompra.Visible  = .F.
1535: 
1536:         *-- Limpa contador de registros e oculta label de conclusao
1537:         THIS.txt_4c_Registro.Value  = 0
1538:         THIS.lbl_4c_LblEnd.Visible  = .F.
1539: 
1540:         *-- Reabilita controles (caso venham de processamento anterior)
1541:         THIS.chk_4c_Conta.Enabled     = .T.
1542:         THIS.chk_4c_Estoque.Enabled   = .T.
1543:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1544:         THIS.chk_4c_BtnCompra.Enabled = .T.
1545:         THIS.cmd_4c_Cancela.Enabled   = .T.
1546: 
1547:         *-- Atualiza estado do botao Processar (deve ficar desabilitado sem selecao)
1548:         THIS.AtualizarEstadoProcessa()
1549: 
1550:         RETURN .T.
1551:     ENDPROC
1552: 
1553:     *==========================================================================
1554:     * ConfigurarPaginaDados - Prepara TODOS os campos de entrada do form
1555:     * Form OPERACIONAL: nao ha Page2/Dados; este metodo mapeia o conceito
1556:     * "preparar formulario para entrada de dados" para os 4 containers de
1557:     * opcoes (OpConta, OpEstoque, OpCusto, OpCompra), resetando cada campo
1558:     * para valor default e habilitando edicao. Chamado apos limpeza de UI
1559:     * (ConfigurarPaginaLista) OU quando quiser reiniciar a entrada de dados
1560:     * apos processamento concluir sem fechar o form.
1561:     *==========================================================================
1562:     PROTECTED PROCEDURE ConfigurarPaginaDados
1563:         LOCAL loc_cEmp
1564:         loc_cEmp = go_4c_Sistema.cCodEmpresa
1565: 
1566:         *-- Container OpConta (Conta Corrente): Empresa=default, demais em branco
1567:         WITH THIS.cnt_4c_OpConta
1568:             .txt_4c_Empresa.Value   = loc_cEmp
1569:             .txt_4c_Empresa.Enabled = .T.
1570:             .txt_4c_TxtGrupos.Value = ""
1571:             .txt_4c_TxtGrupos.Enabled = .T.
1572:             .txt_4c_TxtContas.Value = ""
1573:             .txt_4c_TxtContas.Enabled = .T.
1574:             .txt_4c_TxtMoedas.Value = ""
1575:             .txt_4c_TxtMoedas.Enabled = .T.
1576:             .txt_4c_TxtData.Value   = {}
1577:             .txt_4c_TxtData.Enabled = .T.
1578:             .Visible     = .T.
1579:         ENDWITH
1580: 
1581:         *-- Container OpEstoque: Empresa=default, demais em branco
1582:         WITH THIS.cnt_4c_OpEstoque
1583:             .txt_4c_Empresa.Value   = loc_cEmp
1584:             .txt_4c_Empresa.Enabled = .T.
1585:             .txt_4c_TxtGrupos.Value = ""
1586:             .txt_4c_TxtGrupos.Enabled = .T.
1587:             .txt_4c_Estoque.Value   = ""
1588:             .txt_4c_Estoque.Enabled = .T.
1589:             .txt_4c_Produto.Value   = ""
1590:             .txt_4c_Produto.Enabled = .T.
1591:             .txt_4c_Descricao.Value = ""
1592:             .txt_4c_TxtData.Value   = {}
1593:             .txt_4c_TxtData.Enabled = .T.
1594:             .Visible     = .T.
1595:         ENDWITH
1596: 
1597:         *-- Container OpCusto: Empresa=default, demais em branco
1598:         WITH THIS.cnt_4c_OpCusto
1599:             .txt_4c_Empresa.Value   = loc_cEmp
1600:             .txt_4c_Empresa.Enabled = .T.
1601:             .txt_4c_Produto.Value   = ""
1602:             .txt_4c_Produto.Enabled = .T.
1603:             .txt_4c_Descricao.Value = ""
1604:             .txt_4c_TxtData.Value   = {}
1605:             .txt_4c_TxtData.Enabled = .T.
1606:             .Visible     = .T.
1607:         ENDWITH
1608: 
1609:         *-- Container OpCompra: Empresa=default, demais em branco
1610:         WITH THIS.cnt_4c_OpCompra
1611:             .txt_4c_Empresa.Value   = loc_cEmp
1612:             .txt_4c_Empresa.Enabled = .T.
1613:             .txt_4c_Produto.Value   = ""
1614:             .txt_4c_Produto.Enabled = .T.
1615:             .txt_4c_Descricao.Value = ""
1616:             .txt_4c_TxtData.Value   = {}
1617:             .txt_4c_TxtData.Enabled = .T.
1618:             .Visible     = .T.
1619:         ENDWITH
1620: 
1621:         RETURN .T.
1622:     ENDPROC
1623: 
1624:     *==========================================================================
1625:     * AlternarPagina - Alterna qual container de opcoes esta visivel
1626:     * Form OPERACIONAL: nao ha PageFrame; este metodo mapeia o conceito
1627:     * "trocar de pagina" para "trocar qual painel de opcoes esta ativo".
1628:     *   par_nPagina = 1 ??> Conta Corrente     (cnt_4c_OpConta)
1629:     *   par_nPagina = 2 ??> Estoque            (cnt_4c_OpEstoque)
1630:     *   par_nPagina = 3 ??> Custo de Produto   (cnt_4c_OpCusto)
1631:     *   par_nPagina = 4 ??> Ultima Compra      (cnt_4c_OpCompra)
1632:     *   par_nPagina = 0 ??> reset (oculta todos, equivale a ConfigurarPaginaLista)
1633:     *==========================================================================
1634:     PROCEDURE AlternarPagina(par_nPagina)
1635:         LOCAL loc_nPagina
1636:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)
1637: 
1638:         DO CASE
1639:             CASE loc_nPagina = 1
1640:                 THIS.chk_4c_Conta.Value       = 1
1641:                 THIS.cnt_4c_OpConta.Visible   = .T.
1642:             CASE loc_nPagina = 2
1643:                 THIS.chk_4c_Estoque.Value     = 1
1644:                 THIS.cnt_4c_OpEstoque.Visible = .T.
1645:             CASE loc_nPagina = 3
1646:                 THIS.chk_4c_BtnCusto.Value    = 1
1647:                 THIS.cnt_4c_OpCusto.Visible   = .T.
1648:             CASE loc_nPagina = 4
1649:                 THIS.chk_4c_BtnCompra.Value   = 1
1650:                 THIS.cnt_4c_OpCompra.Visible  = .T.
1651:             OTHERWISE
1652:                 THIS.ConfigurarPaginaLista()
1653:         ENDCASE
1654: 
1655:         THIS.AtualizarEstadoProcessa()
1656:         RETURN .T.
1657:     ENDPROC
1658: 
1659:     *==========================================================================
1660:     * BtnIncluirClick - Reseta o formulario para um novo ciclo de recalculo
1661:     * (Form OPERACIONAL: equivale a "Nova Sessao de Processamento")
1662:     *==========================================================================
1663:     PROCEDURE BtnIncluirClick
1664:         THIS.chk_4c_Conta.Value       = 0
1665:         THIS.chk_4c_Estoque.Value     = 0
1666:         THIS.chk_4c_BtnCusto.Value    = 0
1667:         THIS.chk_4c_BtnCompra.Value   = 0
1668: 
1669:         THIS.cnt_4c_OpConta.Visible   = .F.
1670:         THIS.cnt_4c_OpEstoque.Visible = .F.
1671:         THIS.cnt_4c_OpCusto.Visible   = .F.
1672:         THIS.cnt_4c_OpCompra.Visible  = .F.
1673: 
1674:         THIS.LimparCamposContainer(THIS.cnt_4c_OpConta)
1675:         THIS.LimparCamposContainer(THIS.cnt_4c_OpEstoque)
1676:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCusto)
1677:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)
1678: 
1679:         THIS.txt_4c_Registro.Value    = ""
1680:         THIS.lbl_4c_LblEnd.Visible    = .F.
1681: 
1682:         THIS.cmd_4c_Processa.Enabled  = .F.
1683:         THIS.cmd_4c_Cancela.Enabled   = .T.
1684: 
1685:         THIS.Refresh()
1686:     ENDPROC
1687: 
1688:     *==========================================================================
1689:     * BtnAlterarClick - Habilita novamente os controles apos processamento
1690:     * (Form OPERACIONAL: equivale a "Alterar Selecao apos Processamento")
1691:     *==========================================================================
1692:     PROCEDURE BtnAlterarClick
1693:         THIS.chk_4c_Conta.Enabled     = .T.
1694:         THIS.chk_4c_Estoque.Enabled   = .T.
1695:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1696:         THIS.chk_4c_BtnCompra.Enabled = .T.
1697: 
1698:         THIS.cnt_4c_OpConta.Enabled   = (THIS.chk_4c_Conta.Value = 1)
1699:         THIS.cnt_4c_OpEstoque.Enabled = (THIS.chk_4c_Estoque.Value = 1)
1700:         THIS.cnt_4c_OpCusto.Enabled   = (THIS.chk_4c_BtnCusto.Value = 1)
1701:         THIS.cnt_4c_OpCompra.Enabled  = (THIS.chk_4c_BtnCompra.Value = 1)
1702: 
1703:         THIS.cmd_4c_Cancela.Enabled   = .T.
1704:         THIS.AtualizarEstadoProcessa()
1705:         THIS.Refresh()
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * BtnVisualizarClick - Exibe status da ultima sessao de processamento
1710:     * (Form OPERACIONAL: consulta rapida do estado atual)
1711:     *==========================================================================
1712:     PROCEDURE BtnVisualizarClick
1713:         LOCAL loc_cMsg, loc_cSelecoes, loc_nSel
1714: 
1715:         loc_cSelecoes = ""
1716:         loc_nSel      = 0
1717: 
1718:         IF THIS.chk_4c_Conta.Value = 1
1719:             loc_cSelecoes = loc_cSelecoes + "- Conta Corrente" + CHR(13)
1720:             loc_nSel      = loc_nSel + 1
1721:         ENDIF
1722:         IF THIS.chk_4c_Estoque.Value = 1
1723:             loc_cSelecoes = loc_cSelecoes + "- Estoque" + CHR(13)
1724:             loc_nSel      = loc_nSel + 1
1725:         ENDIF
1726:         IF THIS.chk_4c_BtnCusto.Value = 1
1727:             loc_cSelecoes = loc_cSelecoes + "- Custo de Produto" + CHR(13)
1728:             loc_nSel      = loc_nSel + 1
1729:         ENDIF
1730:         IF THIS.chk_4c_BtnCompra.Value = 1
1731:             loc_cSelecoes = loc_cSelecoes + "- " + CHR(218) + "ltima Compra" + CHR(13)
1732:             loc_nSel      = loc_nSel + 1
1733:         ENDIF
1734: 
1735:         IF loc_nSel = 0
1736:             loc_cMsg = "Nenhum tipo de rec" + CHR(225) + "lculo selecionado." + CHR(13) + ;
1737:                        "Marque um dos checkboxes para configurar o processamento."
1738:         ELSE
1739:             loc_cMsg = "Tipos selecionados (" + TRANSFORM(loc_nSel) + "):" + CHR(13) + ;
1740:                        loc_cSelecoes + CHR(13) + ;
1741:                        "Registros processados: " + ALLTRIM(TRANSFORM(THIS.txt_4c_Registro.Value))
1742:         ENDIF
1743: 
1744:         MsgInfo(loc_cMsg, "Status do Processamento")
1745:     ENDPROC
1746: 
1747:     *==========================================================================
1748:     * BtnExcluirClick - Limpa todas as selecoes e restaura estado inicial
1749:     * (Form OPERACIONAL: equivale a "Cancelar todas as selecoes")
1750:     *==========================================================================
1751:     PROCEDURE BtnExcluirClick
1752:         THIS.chk_4c_Conta.Value       = 0
1753:         THIS.chk_4c_Estoque.Value     = 0
1754:         THIS.chk_4c_BtnCusto.Value    = 0
1755:         THIS.chk_4c_BtnCompra.Value   = 0
1756: 
1757:         THIS.cnt_4c_OpConta.Visible   = .F.
1758:         THIS.cnt_4c_OpEstoque.Visible = .F.
1759:         THIS.cnt_4c_OpCusto.Visible   = .F.
1760:         THIS.cnt_4c_OpCompra.Visible  = .F.
1761: 
1762:         THIS.txt_4c_Registro.Value    = ""
1763:         THIS.lbl_4c_LblEnd.Visible    = .F.
1764: 
1765:         THIS.AtualizarEstadoProcessa()
1766:         THIS.Refresh()
1767:     ENDPROC
1768: 
1769:     *==========================================================================
1770:     * LimparCamposContainer - helper para reset das textboxes de um container
1771:     *==========================================================================
1772:     PROTECTED PROCEDURE LimparCamposContainer(par_oContainer)
1773:         LOCAL loc_nI, loc_oCtrl
1774: 
1775:         IF VARTYPE(par_oContainer) != "O"
1776:             RETURN
1777:         ENDIF
1778: 
1779:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1780:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1781:             IF UPPER(loc_oCtrl.BaseClass) = "TEXTBOX"
1782:                 DO CASE
1783:                     CASE VARTYPE(loc_oCtrl.Value) = "C"
1784:                         loc_oCtrl.Value = ""
1785:                     CASE VARTYPE(loc_oCtrl.Value) = "N"
1786:                         loc_oCtrl.Value = 0
1787:                     CASE VARTYPE(loc_oCtrl.Value) = "D"
1788:                         loc_oCtrl.Value = {}
1789:                 ENDCASE
1790:             ENDIF
1791:         ENDFOR
1792:     ENDPROC
1793: 
1794:     *==========================================================================
1795:     * FormParaBO - Copia valores da UI (4 containers) para o BO
1796:     * (OPERACIONAL: nao ha CRUD, mas o BO carrega parametros para o
1797:     * processamento de RecalcularSaldos* e centraliza os valores digitados)
1798:     *==========================================================================
1799:     PROTECTED PROCEDURE FormParaBO
1800:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
1801:             RETURN .F.
1802:         ENDIF
1803: 
1804:         LOCAL loc_oBO
1805:         loc_oBO = THIS.this_oBusinessObject
1806: 
1807:         *-- Container OpConta (Conta Corrente)
1808:         WITH THIS.cnt_4c_OpConta
1809:             loc_oBO.this_cEmpConta   = ALLTRIM(.txt_4c_Empresa.Value)
1810:             loc_oBO.this_cGrupoConta = ALLTRIM(.txt_4c_TxtGrupos.Value)
1811:             loc_oBO.this_cConta      = ALLTRIM(.txt_4c_TxtContas.Value)
1812:             loc_oBO.this_cMoedaConta = ALLTRIM(.txt_4c_TxtMoedas.Value)
1813:             loc_oBO.this_dDataConta  = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1814:             .Visible     = .T.
1815:         ENDWITH
1816: 
1817:         *-- Container OpEstoque
1818:         WITH THIS.cnt_4c_OpEstoque
1819:             loc_oBO.this_cEmpEst      = ALLTRIM(.txt_4c_Empresa.Value)
1820:             loc_oBO.this_cGrupoEst    = ALLTRIM(.txt_4c_TxtGrupos.Value)
1821:             loc_oBO.this_cEstoque     = ALLTRIM(.txt_4c_Estoque.Value)
1822:             loc_oBO.this_cProdEst     = ALLTRIM(.txt_4c_Produto.Value)
1823:             loc_oBO.this_cDescProdEst = ALLTRIM(.txt_4c_Descricao.Value)
1824:             loc_oBO.this_dDataEst     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1825:             .Visible     = .T.
1826:         ENDWITH
1827: 
1828:         *-- Container OpCusto
1829:         WITH THIS.cnt_4c_OpCusto
1830:             loc_oBO.this_cEmpCusto      = ALLTRIM(.txt_4c_Empresa.Value)
1831:             loc_oBO.this_cProdCusto     = ALLTRIM(.txt_4c_Produto.Value)
1832:             loc_oBO.this_cDescProdCusto = ALLTRIM(.txt_4c_Descricao.Value)
1833:             loc_oBO.this_dDataCusto     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1834:             .Visible     = .T.
1835:         ENDWITH
1836: 
1837:         *-- Container OpCompra
1838:         WITH THIS.cnt_4c_OpCompra
1839:             loc_oBO.this_cEmpCompra      = ALLTRIM(.txt_4c_Empresa.Value)
1840:             loc_oBO.this_cProdCompra     = ALLTRIM(.txt_4c_Produto.Value)
1841:             loc_oBO.this_cDescProdCompra = ALLTRIM(.txt_4c_Descricao.Value)
1842:             loc_oBO.this_dDataCompra     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1843:             .Visible     = .T.
1844:         ENDWITH
1845: 
1846:         *-- Contador de registros processados
1847:         IF VARTYPE(THIS.txt_4c_Registro.Value) = "N"
1848:             loc_oBO.this_nRegistros = THIS.txt_4c_Registro.Value
1849:         ELSE
1850:             loc_oBO.this_nRegistros = TRANSFORM(THIS.txt_4c_Registro.Value)
1851:         ENDIF
1852: 
1853:         RETURN .T.
1854:     ENDPROC
1855: 
1856:     *==========================================================================
1857:     * BOParaForm - Copia valores do BO para a UI (4 containers)
1858:     *==========================================================================
1859:     PROTECTED PROCEDURE BOParaForm
1860:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
1861:             RETURN .F.
1862:         ENDIF
1863: 
1864:         LOCAL loc_oBO
1865:         loc_oBO = THIS.this_oBusinessObject
1866: 
1867:         *-- Container OpConta (Conta Corrente)
1868:         WITH THIS.cnt_4c_OpConta
1869:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpConta
1870:             .txt_4c_TxtGrupos.Value = loc_oBO.this_cGrupoConta
1871:             .txt_4c_TxtContas.Value = loc_oBO.this_cConta
1872:             .txt_4c_TxtMoedas.Value = loc_oBO.this_cMoedaConta
1873:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataConta
1874:             .Visible     = .T.
1875:         ENDWITH
1876: 
1877:         *-- Container OpEstoque
1878:         WITH THIS.cnt_4c_OpEstoque
1879:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpEst
1880:             .txt_4c_TxtGrupos.Value = loc_oBO.this_cGrupoEst
1881:             .txt_4c_Estoque.Value   = loc_oBO.this_cEstoque
1882:             .txt_4c_Produto.Value   = loc_oBO.this_cProdEst
1883:             .txt_4c_Descricao.Value = loc_oBO.this_cDescProdEst
1884:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataEst
1885:             .Visible     = .T.
1886:         ENDWITH
1887: 
1888:         *-- Container OpCusto
1889:         WITH THIS.cnt_4c_OpCusto
1890:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpCusto
1891:             .txt_4c_Produto.Value   = loc_oBO.this_cProdCusto
1892:             .txt_4c_Descricao.Value = loc_oBO.this_cDescProdCusto
1893:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataCusto
1894:             .Visible     = .T.
1895:         ENDWITH
1896: 
1897:         *-- Container OpCompra
1898:         WITH THIS.cnt_4c_OpCompra
1899:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpCompra
1900:             .txt_4c_Produto.Value   = loc_oBO.this_cProdCompra
1901:             .txt_4c_Descricao.Value = loc_oBO.this_cDescProdCompra
1902:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataCompra
1903:             .Visible     = .T.
1904:         ENDWITH
1905: 
1906:         THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1907: 
1908:         RETURN .T.
1909:     ENDPROC
1910: 
1911:     *==========================================================================
1912:     * HabilitarCampos - Habilita/desabilita containers e checkboxes conforme
1913:     * o estado de processamento (par_lHabilitar). Chamado por Processa e
1914:     * ao terminar o processamento para bloquear a UI durante a execucao SQL.
1915:     *==========================================================================
1916:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1917:         LOCAL loc_lHab
1918:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1919: 
1920:         *-- Checkboxes principais
1921:         THIS.chk_4c_Conta.Enabled     = loc_lHab
1922:         THIS.chk_4c_Estoque.Enabled   = loc_lHab
1923:         THIS.chk_4c_BtnCusto.Enabled  = loc_lHab
1924:         THIS.chk_4c_BtnCompra.Enabled = loc_lHab
1925: 
1926:         *-- Containers de opcoes: enabled apenas se o checkbox correspondente
1927:         *-- estiver marcado E o form estiver habilitado
1928:         THIS.cnt_4c_OpConta.Enabled   = loc_lHab AND (THIS.chk_4c_Conta.Value     = 1)
1929:         THIS.cnt_4c_OpEstoque.Enabled = loc_lHab AND (THIS.chk_4c_Estoque.Value   = 1)
1930:         THIS.cnt_4c_OpCusto.Enabled   = loc_lHab AND (THIS.chk_4c_BtnCusto.Value  = 1)
1931:         THIS.cnt_4c_OpCompra.Enabled  = loc_lHab AND (THIS.chk_4c_BtnCompra.Value = 1)
1932: 
1933:         *-- Botoes de acao
1934:         THIS.cmd_4c_Cancela.Enabled  = loc_lHab
1935:         THIS.cmd_4c_Processa.Enabled = loc_lHab AND ( ;
1936:             THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
1937:             THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1)
1938: 
1939:         RETURN .T.
1940:     ENDPROC
1941: 
1942:     *==========================================================================
1943:     * LimparCampos - Limpa TODOS os campos dos 4 containers de opcoes
1944:     *==========================================================================
1945:     PROTECTED PROCEDURE LimparCampos
1946:         THIS.LimparCamposContainer(THIS.cnt_4c_OpConta)
1947:         THIS.LimparCamposContainer(THIS.cnt_4c_OpEstoque)
1948:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCusto)
1949:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)
1950: 
1951:         *-- Restaura empresa padrao apos limpeza (evita campo vazio nas 4 abas)
1952:         LOCAL loc_cEmp
1953:         loc_cEmp = go_4c_Sistema.cCodEmpresa
1954:         THIS.cnt_4c_OpConta.txt_4c_Empresa.Value   = loc_cEmp
1955:         THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value = loc_cEmp
1956:         THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value   = loc_cEmp
1957:         THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value  = loc_cEmp
1958: 
1959:         THIS.txt_4c_Registro.Value = 0
1960:         THIS.lbl_4c_LblEnd.Visible = .F.
1961: 
1962:         RETURN .T.
1963:     ENDPROC
1964: 
1965:     *==========================================================================
1966:     * CarregarLista - Recarrega parametros do sistema (SigCdPam) via BO e
1967:     * atualiza a UI. Nome vem do padrao CRUD; aqui equivale a "refresh
1968:     * dos parametros centrais que direcionam o processamento".
1969:     *==========================================================================
1970:     PROCEDURE CarregarLista
1971:         LOCAL loc_lSucesso
1972:         loc_lSucesso = .F.
1973: 
1974:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
1975:             RETURN .F.
1976:         ENDIF
1977: 
1978:         TRY
1979:             THIS.this_oBusinessObject.InicializarDados()
1980:             THIS.BOParaForm()
1981:             loc_lSucesso = .T.
1982:         CATCH TO loc_oErro
1983:             THIS.this_cMensagemErro = loc_oErro.Message
1984:             MsgErro(loc_oErro.Message, "Erro ao recarregar par" + CHR(226) + "metros")
1985:         ENDTRY
1986: 
1987:         RETURN loc_lSucesso
1988:     ENDPROC
1989: 
1990:     *==========================================================================
1991:     * AjustarBotoesPorModo - Ajusta enabled dos botoes conforme o modo de UI
1992:     *   par_cModo = "INICIAL"      -> aguardando selecao (Processa disabled)
1993:     *   par_cModo = "PROCESSANDO"  -> execucao SQL em curso (tudo disabled)
1994:     *   par_cModo = "CONCLUIDO"    -> processamento terminado (Cancela habilita)
1995:     *==========================================================================
1996:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1997:         LOCAL loc_cModo
1998:         loc_cModo = IIF(VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo), UPPER(par_cModo), "INICIAL")
1999: 
2000:         DO CASE
2001:             CASE loc_cModo = "PROCESSANDO"
2002:                 THIS.cmd_4c_Processa.Enabled = .F.
2003:                 THIS.cmd_4c_Cancela.Enabled  = .F.
2004:                 THIS.HabilitarCampos(.F.)
2005:             CASE loc_cModo = "CONCLUIDO"
2006:                 THIS.cmd_4c_Processa.Enabled = .F.
2007:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2008:                 THIS.lbl_4c_LblEnd.Visible   = .T.
2009:                 THIS.HabilitarCampos(.F.)
2010:             OTHERWISE
2011:                 *-- INICIAL: aguardando selecao
2012:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2013:                 THIS.lbl_4c_LblEnd.Visible   = .F.
2014:                 THIS.HabilitarCampos(.T.)
2015:                 THIS.AtualizarEstadoProcessa()
2016:         ENDCASE
2017: 
2018:         RETURN .T.
2019:     ENDPROC
2020: 
2021:     *==========================================================================
2022:     * BtnBuscarClick - Recarrega parametros centrais do sistema (SigCdPam)
2023:     * Util para atualizar moeda central, grupos padrao, etc. sem sair do form
2024:     *==========================================================================
2025:     PROCEDURE BtnBuscarClick
2026:         IF THIS.CarregarLista()
2027:             MsgInfo("Par" + CHR(226) + "metros do sistema recarregados com sucesso.", ;
2028:                     "Atualiza" + CHR(231) + CHR(227) + "o")
2029:         ENDIF
2030:     ENDPROC
2031: 
2032:     *==========================================================================
2033:     * BtnEncerrarClick - Encerra o form (equivalente ao botao Cancela/Sair)
2034:     *==========================================================================
2035:     PROCEDURE BtnEncerrarClick
2036:         THIS.Release()
2037:     ENDPROC
2038: 
2039:     *==========================================================================
2040:     * BtnSalvarClick - Alias para BtnProcessarClick (executa recalculo)
2041:     * (OPERACIONAL: nao ha "salvar registro"; o botao de acao positiva
2042:     * eh Processar, entao Salvar mapeia para o mesmo fluxo)
2043:     *==========================================================================
2044:     PROCEDURE BtnSalvarClick
2045:         THIS.BtnProcessarClick()
2046:     ENDPROC
2047: 
2048:     *==========================================================================
2049:     * BtnCancelarClick - Alias para BtnCancelaClick (encerra o form)
2050:     *==========================================================================
2051:     PROCEDURE BtnCancelarClick
2052:         THIS.BtnCancelaClick()
2053:     ENDPROC
2054: 
2055:     *==========================================================================
2056:     PROCEDURE Destroy
2057:     *==========================================================================
2058:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2059:             THIS.this_oBusinessObject = .NULL.
2060:         ENDIF
2061:         DODEFAULT()
2062:     ENDPROC
2063: 
2064: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos
* Herda de BusinessBase
* Tabela principal: SigOpClU (Ultima Compra por Cliente/Produto)
* Fases 1-2/8: Propriedades, Init e metodos de recalculo completos
*==============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *--------------------------------------------------------------------------
    * Secao Conta Corrente (OpConta) - recalcula SigMvCcr
    *--------------------------------------------------------------------------
    this_cEmpConta    = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoConta  = ""    && txtGrupos   C(10) - grupo de conta
    this_cConta       = ""    && txtContas   C(10) - conta corrente
    this_cMoedaConta  = ""    && txtMoedas   C(3)  - moeda
    this_dDataConta   = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Estoque (OpEstoque) - recalcula SigMvHst
    *--------------------------------------------------------------------------
    this_cEmpEst      = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoEst    = ""    && txtGrupos   C(10) - grupo do deposito
    this_cEstoque     = ""    && Get_Estoque C(10) - codigo do deposito/estoque
    this_cProdEst     = ""    && Get_Produto C(14) - codigo do produto
    this_cDescProdEst = ""    && Get_Descs   C(40) - descricao do produto
    this_dDataEst     = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Custo de Produto (OpCusto) - recalcula custo em SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCusto      = ""  && Get_Empresa C(3)  - empresa filtro
    this_cProdCusto     = ""  && Get_Produto C(14) - codigo do produto
    this_cDescProdCusto = ""  && Get_Descs   C(40) - descricao do produto
    this_dDataCusto     = {}  && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Ultima Compra (OpCompra) - atualiza SigOpClU, SigCdCli, SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCompra      = "" && Get_Empresa C(3)  - empresa filtro
    this_cProdCompra     = "" && Get_Produto C(14) - codigo do produto
    this_cDescProdCompra = "" && Get_Descs   C(40) - descricao do produto
    this_dDataCompra     = {} && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Parametros do sistema (carregados de SigCdPam em InicializarDados)
    *--------------------------------------------------------------------------
    this_cMoeCentral  = ""    && MoeCentral  C(3)  - moeda central para cotacao
    this_cGrupoRecs   = ""    && GrupoRecs   C(10) - grupo recebimentos C.C.
    this_cGrupoPags   = ""    && GrupoPags   C(10) - grupo pagamentos C.C.
    this_cContaRecs   = ""    && ContaRecs   C(10) - conta recebimentos C.C.
    this_cContaPags   = ""    && ContaPags   C(10) - conta pagamentos C.C.

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_nRegistros   = 0     && Get_Registro N    - contador de registros processados
    this_lProcessando = .F.   && .T. enquanto Processa.Click estiver rodando

    *--------------------------------------------------------------------------
    * Propriedades de linha - SigOpClU (CRUD)
    *--------------------------------------------------------------------------
    this_cChaves     = ""    && cidchaves  C(20) PK
    this_cCpros      = ""    && cpros      C(14)
    this_dDatas      = {}    && datas      datetime
    this_cDopes      = ""    && dopes      C(20)
    this_cEmpDopNums = ""    && empdopnums C(29)
    this_cEmps       = ""    && emps       C(3)
    this_cIclis      = ""    && iclis      C(10)
    this_cMoedas     = ""    && moedas     C(3)
    this_nNumes      = 0     && numes      N(6,0)
    this_nValors     = 0     && valors     N(13,2)
    this_nQtds       = 0     && qtds       N(12,0)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarDados - carrega parametros de SigCdPam no BO
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags, MoeCentral " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cGrupoRecs  = NVL(GrupoRecs,  "")
                    THIS.this_cGrupoPags  = NVL(GrupoPags,  "")
                    THIS.this_cContaRecs  = NVL(ContaRecs,  "")
                    THIS.this_cContaPags  = NVL(ContaPags,  "")
                    THIS.this_cMoeCentral = NVL(MoeCentral, "")
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega colunas de SigOpClU do cursor informado
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaves     = NVL(cidchaves,  SPACE(20))
            THIS.this_cCpros      = NVL(cpros,      SPACE(14))
            THIS.this_dDatas      = NVL(datas,      {})
            THIS.this_cDopes      = NVL(dopes,      SPACE(20))
            THIS.this_cEmpDopNums = NVL(empdopnums, SPACE(29))
            THIS.this_cEmps       = NVL(emps,       SPACE(3))
            THIS.this_cIclis      = NVL(iclis,      SPACE(10))
            THIS.this_cMoedas     = NVL(moedas,     SPACE(3))
            THIS.this_nNumes      = NVL(numes,      0)
            THIS.this_nValors     = NVL(valors,     0)
            THIS.this_nQtds       = NVL(qtds,       0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir - insere um registro em SigOpClU
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            THIS.this_cChaves = SYS(2015) + SYS(2015)

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                " emps, iclis, moedas, numes, valors, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(LEFT(THIS.this_cChaves, 20))     + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0)       + ")"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza registro em SigOpClU pela chave cidchaves
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "cpros      = " + EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                "dopes      = " + EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "iclis      = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                "moedas     = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                "numes      = " + FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "qtds       = " + FormatarNumeroSQL(THIS.this_nQtds, 0)       + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves do registro atual (para auditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *==========================================================================
    * RecalcularSaldosConta - recalcula saldos em SigMvCcr
    * Processa movimentos em ordem cronologica e atualiza saldos acumulados
    *==========================================================================
    PROCEDURE RecalcularSaldosConta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSaldo, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpConta)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoConta)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cMoedaConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "moedas = " + EscaparSQL(THIS.this_cMoedaConta)
            ENDIF
            IF !EMPTY(THIS.this_dDataConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataConta)
            ENDIF

            loc_cSQL = "SELECT emps, grupos, contas, moedas, " + ;
                       "       datas, numes, opers, valors " + ;
                       "FROM SigMvCcr" + m.loc_cWhere + ;
                       " ORDER BY emps, grupos, contas, moedas, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CcrRec") > 0
                IF USED("cursor_4c_CcrRec") AND RECCOUNT("cursor_4c_CcrRec") > 0
                    loc_nSaldo  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_CcrRec
                    SCAN
                        loc_cKey = ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(contas) + ALLTRIM(moedas)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSaldo  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSaldo = loc_nSaldo + valors
                        ELSE
                            loc_nSaldo = loc_nSaldo - valors
                        ENDIF
                        loc_cSQL = "UPDATE SigMvCcr SET saldos = " + ;
                                   FormatarNumeroSQL(m.loc_nSaldo, 2) + ;
                                   " WHERE emps = "   + EscaparSQL(emps)   + ;
                                   "   AND grupos = " + EscaparSQL(grupos)  + ;
                                   "   AND contas = " + EscaparSQL(contas)  + ;
                                   "   AND moedas = " + EscaparSQL(moedas)  + ;
                                   "   AND datas = "  + FormatarDataSQL(datas) + ;
                                   "   AND numes = "  + FormatarNumeroSQL(numes, 0)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CcrRec")
                    USE IN cursor_4c_CcrRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvCcr.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosConta")
            IF USED("cursor_4c_CcrRec")
                USE IN cursor_4c_CcrRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosEstoque - recalcula sqtds em SigMvHst
    * Processa movimentos em ordem e atualiza saldo acumulado de quantidade
    *==========================================================================
    PROCEDURE RecalcularSaldosEstoque()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSqtds, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpEst)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoEst)
            ENDIF
            IF !EMPTY(THIS.this_cProdEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdEst)
            ENDIF
            IF !EMPTY(THIS.this_dDataEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataEst)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, grupos, estos, " + ;
                       "       datas, numes, opers, qtds, sqtds " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " ORDER BY cpros, emps, grupos, estos, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_HstRec") > 0
                IF USED("cursor_4c_HstRec") AND RECCOUNT("cursor_4c_HstRec") > 0
                    loc_nSqtds  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_HstRec
                    SCAN
                        loc_cKey = ALLTRIM(cpros) + ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(estos)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSqtds  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSqtds = loc_nSqtds + qtds
                        ELSE
                            loc_nSqtds = loc_nSqtds - qtds
                        ENDIF
                        loc_cSQL = "UPDATE SigMvHst SET sqtds = " + ;
                                   FormatarNumeroSQL(m.loc_nSqtds, 3) + ;
                                   " WHERE cpros = "   + EscaparSQL(cpros)   + ;
                                   "   AND emps = "    + EscaparSQL(emps)     + ;
                                   "   AND grupos = "  + EscaparSQL(grupos)   + ;
                                   "   AND estos = "   + EscaparSQL(estos)    + ;
                                   "   AND datas = "   + FormatarDataSQL(datas) + ;
                                   "   AND numes = "   + FormatarNumeroSQL(numes, 0)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_HstRec")
                    USE IN cursor_4c_HstRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvHst.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosEstoque")
            IF USED("cursor_4c_HstRec")
                USE IN cursor_4c_HstRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCusto - recalcula custofs em SigCdPro
    * Media ponderada de custo a partir dos movimentos de entrada em SigMvHst
    *==========================================================================
    PROCEDURE RecalcularSaldosCusto()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCusto)
            ENDIF
            IF !EMPTY(THIS.this_cProdCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCusto)
            ENDIF
            IF !EMPTY(THIS.this_dDataCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCusto)
            ENDIF

            loc_cSQL = "SELECT cpros, " + ;
                       "       SUM(qtds * units) / NULLIF(SUM(qtds), 0) AS custofsMedio " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CustoRec") > 0
                IF USED("cursor_4c_CustoRec") AND RECCOUNT("cursor_4c_CustoRec") > 0
                    SELECT cursor_4c_CustoRec
                    SCAN
                        IF !ISNULL(custofsMedio)
                            loc_cSQL = "UPDATE SigCdPro SET custofs = " + ;
                                       FormatarNumeroSQL(custofsMedio, 3) + ;
                                       " WHERE cpros = " + EscaparSQL(cpros)
                            SQLEXEC(gnConnHandle, m.loc_cSQL)
                            loc_nRecs = loc_nRecs + 1
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CustoRec")
                    USE IN cursor_4c_CustoRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao calcular custo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCusto")
            IF USED("cursor_4c_CustoRec")
                USE IN cursor_4c_CustoRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCompra - atualiza SigOpClU com ultima compra por produto
    * Localiza a entrada mais recente em SigMvHst e atualiza SigOpClU
    *==========================================================================
    PROCEDURE RecalcularSaldosCompra()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs
        LOCAL loc_cChkSQL, loc_cUpSQL, loc_cPros, loc_cEmps

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCompra)
            ENDIF
            IF !EMPTY(THIS.this_cProdCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCompra)
            ENDIF
            IF !EMPTY(THIS.this_dDataCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCompra)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, " + ;
                       "       MAX(datas) AS ultimaData, " + ;
                       "       MAX(numes) AS ultimoNume " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros, emps"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraGrp") > 0
                IF USED("cursor_4c_CompraGrp") AND RECCOUNT("cursor_4c_CompraGrp") > 0
                    SELECT cursor_4c_CompraGrp
                    SCAN
                        loc_cPros = ALLTRIM(cpros)
                        loc_cEmps = ALLTRIM(emps)

                        *-- Busca detalhe do movimento mais recente
                        loc_cSQL = "SELECT TOP 1 cpros, emps, datas, numes, " + ;
                                   "            valors, qtds, moedas, dopes, empdopnums " + ;
                                   "FROM SigMvHst " + ;
                                   "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                   "  AND emps = "  + EscaparSQL(m.loc_cEmps) + ;
                                   " ORDER BY datas DESC, numes DESC"

                        IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraUlt") > 0
                            IF USED("cursor_4c_CompraUlt") AND RECCOUNT("cursor_4c_CompraUlt") > 0
                                SELECT cursor_4c_CompraUlt

                                *-- Verificar se ja existe registro em SigOpClU
                                loc_cChkSQL = "SELECT cidchaves FROM SigOpClU " + ;
                                              "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                              "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                IF SQLEXEC(gnConnHandle, m.loc_cChkSQL, "cursor_4c_CompraChk") > 0
                                    IF USED("cursor_4c_CompraChk") AND RECCOUNT("cursor_4c_CompraChk") > 0
                                        *-- UPDATE
                                        SELECT cursor_4c_CompraUlt
                                        loc_cUpSQL = "UPDATE SigOpClU SET " + ;
                                            "datas      = " + FormatarDataSQL(datas)          + ", " + ;
                                            "numes      = " + FormatarNumeroSQL(numes, 0)     + ", " + ;
                                            "valors     = " + FormatarNumeroSQL(valors, 2)    + ", " + ;
                                            "qtds       = " + FormatarNumeroSQL(qtds, 0)      + ", " + ;
                                            "moedas     = " + EscaparSQL(LEFT(moedas, 3))     + ", " + ;
                                            "dopes      = " + EscaparSQL(LEFT(dopes, 20))     + ", " + ;
                                            "empdopnums = " + EscaparSQL(LEFT(empdopnums, 29))+ " " + ;
                                            "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                            "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                        SQLEXEC(gnConnHandle, m.loc_cUpSQL)
                                    ELSE
                                        *-- INSERT novo
                                        SELECT cursor_4c_CompraUlt
                                        THIS.this_cCpros      = LEFT(cpros, 14)
                                        THIS.this_cEmps       = LEFT(emps, 3)
                                        THIS.this_dDatas      = datas
                                        THIS.this_nNumes      = numes
                                        THIS.this_nValors     = valors
                                        THIS.this_nQtds       = qtds
                                        THIS.this_cMoedas     = LEFT(moedas, 3)
                                        THIS.this_cDopes      = LEFT(dopes, 20)
                                        THIS.this_cEmpDopNums = LEFT(empdopnums, 29)
                                        THIS.this_cIclis      = SPACE(10)
                                        THIS.Inserir()
                                    ENDIF
                                    IF USED("cursor_4c_CompraChk")
                                        USE IN cursor_4c_CompraChk
                                    ENDIF
                                    loc_nRecs = loc_nRecs + 1
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_CompraUlt")
                                USE IN cursor_4c_CompraUlt
                            ENDIF
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CompraGrp")
                    USE IN cursor_4c_CompraGrp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar movimentos de compra.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCompra")
            IF USED("cursor_4c_CompraGrp")
                USE IN cursor_4c_CompraGrp
            ENDIF
            IF USED("cursor_4c_CompraUlt")
                USE IN cursor_4c_CompraUlt
            ENDIF
            IF USED("cursor_4c_CompraChk")
                USE IN cursor_4c_CompraChk
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

