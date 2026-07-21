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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2058 linhas total):

*-- Linhas 37 a 185:
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
73:                 *-- Estado inicial do contador de registros
74:                 THIS.txt_4c_Registro.Value = 0
75: 
76:                 loc_lSucesso = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
80:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.InicializarForm")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *==========================================================================
87:     * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
88:     *==========================================================================
89:     PROTECTED PROCEDURE ConfigurarPageFrame
90:         THIS.Picture     = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
91:         THIS.ClipControls = .F.
92:     ENDPROC
93: 
94:     *==========================================================================
95:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
96:     *==========================================================================
97:     PROTECTED PROCEDURE ConfigurarCabecalho
98:         THIS.AddObject("cnt_4c_Sombra", "Container")
99:         WITH THIS.cnt_4c_Sombra
100:             .Top        = 0
101:             .Left       = 0
102:             .Width      = THIS.Width
103:             .Height     = 80
104:             .BorderWidth= 0
105:             .BackColor  = RGB(100,100,100)
106:             .AddObject("lbl_4c_LblSombra", "Label")
107:             WITH .lbl_4c_LblSombra
108:                 .FontBold      = .T.
109:                 .FontName      = "Tahoma"
110:                 .FontSize      = 18
111:                 .FontUnderline = .F.
112:                 .WordWrap      = .T.
113:                 .Alignment     = 0
114:                 .AutoSize      = .F.
115:                 .BackStyle     = 0
116:                 .Caption       = THIS.Caption
117:                 .Height        = 40
118:                 .Left          = 10
119:                 .Top           = 18
120:                 .Width         = THIS.Width
121:                 .ForeColor     = RGB(0,0,0)
122:             ENDWITH
123:             .AddObject("lbl_4c_LblTitulo", "Label")
124:             WITH .lbl_4c_LblTitulo
125:                 .FontBold   = .T.
126:                 .FontName   = "Tahoma"
127:                 .FontSize   = 18
128:                 .WordWrap   = .T.
129:                 .Alignment  = 0
130:                 .AutoSize   = .F.
131:                 .BackStyle  = 0
132:                 .Caption    = THIS.Caption
133:                 .Height     = 46
134:                 .Left       = 10
135:                 .Top        = 17
136:                 .Width      = THIS.Width
137:                 .ForeColor  = RGB(255,255,255)
138:             ENDWITH
139:         ENDWITH
140:     ENDPROC
141: 
142:     *==========================================================================
143:     * ConfigurarControlesPrincipais - Shape, CheckBoxes, Botoes, LblEnd, Registro
144:     *==========================================================================
145:     PROTECTED PROCEDURE ConfigurarControlesPrincipais
146:         *-- Shape decorativo (Shape1 original)
147:         THIS.AddObject("shp_4c_Shape1", "Shape")
148:         WITH THIS.shp_4c_Shape1
149:             .Top         = 7
150:             .Left        = 697
151:             .Height      = 110
152:             .Width       = 90
153:             .BackStyle   = 0
154:             .BorderStyle = 0
155:             .BorderColor = RGB(136,189,188)
156:         ENDWITH
157: 
158:         *-- CheckBox C.C. (Conta original - Left=350)
159:         THIS.AddObject("chk_4c_Conta", "CheckBox")
160:         WITH THIS.chk_4c_Conta
161:             .Top           = 3
162:             .Left          = 350
163:             .Height        = 75
164:             .Width         = 75
165:             .FontBold      = .T.
166:             .FontItalic    = .T.
167:             .FontName      = "Comic Sans MS"
168:             .FontSize      = 8
169:             .AutoSize      = .F.
170:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
171:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
172:             .Alignment     = 1
173:             .BackStyle     = 0
174:             .Caption       = "C.C."
175:             .Value         = 0
176:             .SpecialEffect = 0
177:             .Style         = 1
178:             .ToolTipText   = "Conta Corrente"
179:             .ForeColor     = RGB(90,90,90)
180:             .BackColor     = RGB(255,255,255)
181:             .Themes        = .F.
182:         ENDWITH
183: 
184:         *-- CheckBox Estoque (Estoque original - Left=425)
185:         THIS.AddObject("chk_4c_Estoque", "CheckBox")

*-- Linhas 358 a 402:
358: 
359:     *==========================================================================
360:     * ConfigurarContainerOpConta - Conta Corrente: empresa, grupo, conta, moeda, data
361:     *==========================================================================
362:     PROTECTED PROCEDURE ConfigurarContainerOpConta
363:         THIS.AddObject("cnt_4c_OpConta", "Container")
364:         WITH THIS.cnt_4c_OpConta
365:             .Top           = 114
366:             .Left          = 139
367:             .Width         = THIS.LarguraOpConta
368:             .Height        = 81
369:             .BackStyle     = 0
370:             .BorderWidth   = 2
371:             .SpecialEffect = 2
372:             .Visible       = .F.
373:             .BackColor     = RGB(192,192,255)
374:             .BorderColor   = RGB(90,90,90)
375: 
376:             .AddObject("lbl_4c_TituloOp", "Label")
377:             WITH .lbl_4c_TituloOp
378:                 .AutoSize      = .T.
379:                 .FontBold      = .T.
380:                 .FontName      = "Tahoma"
381:                 .FontSize      = 8
382:                 .FontUnderline = .T.
383:                 .BackStyle     = 0
384:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
385:                 .Left          = 171
386:                 .Top           = 2
387:                 .ForeColor     = RGB(90,90,90)
388:             ENDWITH
389: 
390:             .AddObject("lbl_4c_LblEmpresa", "Label")
391:             WITH .lbl_4c_LblEmpresa
392:                 .AutoSize   = .T.
393:                 .FontBold   = .T.
394:                 .FontName   = "Tahoma"
395:                 .FontSize   = 8
396:                 .BackStyle  = 0
397:                 .Caption    = "Empresa :"
398:                 .Height     = 15
399:                 .Left       = 16
400:                 .Top        = 23
401:                 .Width      = 57
402:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 533 a 577:
533: 
534:     *==========================================================================
535:     * ConfigurarContainerOpEstoque - Estoque: empresa, grupo, estoque, produto, desc, data
536:     *==========================================================================
537:     PROTECTED PROCEDURE ConfigurarContainerOpEstoque
538:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
539:         WITH THIS.cnt_4c_OpEstoque
540:             .Top           = 200
541:             .Left          = 139
542:             .Width         = THIS.LarguraOpEstoque
543:             .Height        = 143
544:             .BackStyle     = 0
545:             .BorderWidth   = 2
546:             .SpecialEffect = 2
547:             .Visible       = .F.
548:             .BackColor     = RGB(192,192,255)
549:             .BorderColor   = RGB(90,90,90)
550: 
551:             .AddObject("lbl_4c_TituloOp", "Label")
552:             WITH .lbl_4c_TituloOp
553:                 .AutoSize      = .T.
554:                 .FontBold      = .T.
555:                 .FontName      = "Tahoma"
556:                 .FontSize      = 8
557:                 .FontUnderline = .T.
558:                 .BackStyle     = 0
559:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Estoque"
560:                 .Left          = 182
561:                 .Top           = 2
562:                 .ForeColor     = RGB(90,90,90)
563:             ENDWITH
564: 
565:             .AddObject("lbl_4c_LblEmpresa", "Label")
566:             WITH .lbl_4c_LblEmpresa
567:                 .AutoSize   = .T.
568:                 .FontBold   = .T.
569:                 .FontName   = "Tahoma"
570:                 .FontSize   = 8
571:                 .BackStyle  = 0
572:                 .Caption    = "Empresa :"
573:                 .Height     = 15
574:                 .Left       = 31
575:                 .Top        = 15
576:                 .Width      = 57
577:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 720 a 764:
720: 
721:     *==========================================================================
722:     * ConfigurarContainerOpCusto - Custo de Produto: empresa, produto, desc, data
723:     *==========================================================================
724:     PROTECTED PROCEDURE ConfigurarContainerOpCusto
725:         THIS.AddObject("cnt_4c_OpCusto", "Container")
726:         WITH THIS.cnt_4c_OpCusto
727:             .Top           = 349
728:             .Left          = 139
729:             .Width         = THIS.LarguraOpCusto
730:             .Height        = 92
731:             .BackStyle     = 0
732:             .BorderWidth   = 2
733:             .SpecialEffect = 2
734:             .Visible       = .F.
735:             .BackColor     = RGB(192,192,255)
736:             .BorderColor   = RGB(90,90,90)
737: 
738:             .AddObject("lbl_4c_TituloOp", "Label")
739:             WITH .lbl_4c_TituloOp
740:                 .AutoSize      = .T.
741:                 .FontBold      = .T.
742:                 .FontName      = "Tahoma"
743:                 .FontSize      = 8
744:                 .FontUnderline = .T.
745:                 .BackStyle     = 0
746:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
747:                 .Left          = 155
748:                 .Top           = 2
749:                 .ForeColor     = RGB(90,90,90)
750:             ENDWITH
751: 
752:             .AddObject("lbl_4c_LblEmpresa", "Label")
753:             WITH .lbl_4c_LblEmpresa
754:                 .AutoSize   = .T.
755:                 .FontBold   = .T.
756:                 .FontName   = "Tahoma"
757:                 .FontSize   = 8
758:                 .BackStyle  = 0
759:                 .Caption    = "Empresa :"
760:                 .Height     = 15
761:                 .Left       = 31
762:                 .Top        = 14
763:                 .Width      = 57
764:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 852 a 896:
852: 
853:     *==========================================================================
854:     * ConfigurarContainerOpCompra - Ultima Compra: empresa, produto, desc, data
855:     *==========================================================================
856:     PROTECTED PROCEDURE ConfigurarContainerOpCompra
857:         THIS.AddObject("cnt_4c_OpCompra", "Container")
858:         WITH THIS.cnt_4c_OpCompra
859:             .Top           = 447
860:             .Left          = 139
861:             .Width         = THIS.LarguraOpCompra
862:             .Height        = 91
863:             .BackStyle     = 0
864:             .BorderWidth   = 2
865:             .SpecialEffect = 2
866:             .Visible       = .F.
867:             .BackColor     = RGB(192,192,255)
868:             .BorderColor   = RGB(90,90,90)
869: 
870:             .AddObject("lbl_4c_TituloOp", "Label")
871:             WITH .lbl_4c_TituloOp
872:                 .AutoSize      = .T.
873:                 .FontBold      = .T.
874:                 .FontName      = "Tahoma"
875:                 .FontSize      = 8
876:                 .FontUnderline = .T.
877:                 .BackStyle     = 0
878:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Ultima Compra do Produto/Cliente"
879:                 .Left          = 140
880:                 .Top           = 2
881:                 .ForeColor     = RGB(90,90,90)
882:             ENDWITH
883: 
884:             .AddObject("lbl_4c_LblEmpresa", "Label")
885:             WITH .lbl_4c_LblEmpresa
886:                 .AutoSize   = .T.
887:                 .FontBold   = .T.
888:                 .FontName   = "Tahoma"
889:                 .FontSize   = 8
890:                 .BackStyle  = 0
891:                 .Caption    = "Empresa :"
892:                 .Height     = 15
893:                 .Left       = 31
894:                 .Top        = 14
895:                 .Width      = 57
896:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 983 a 2058:
983:     ENDPROC
984: 
985:     *==========================================================================
986:     * TornarControlesVisiveis - torna controles visiveis exceto containers
987:     * flutuantes que devem comecar ocultos (OpConta, OpEstoque, OpCusto, OpCompra)
988:     *==========================================================================
989:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
990:         LOCAL loc_i, loc_oControl, loc_cNome
991: 
992:         IF PCOUNT() = 0
993:             par_oContainer = THIS
994:         ENDIF
995: 
996:         FOR loc_i = 1 TO par_oContainer.ControlCount
997:             loc_oControl = par_oContainer.Controls(loc_i)
998:             IF VARTYPE(loc_oControl) # "O"
999:                 LOOP
1000:             ENDIF
1001: 
1002:             loc_cNome = UPPER(loc_oControl.Name)
1003: 
1004:             *-- Containers flutuantes ficam ocultos por definicao
1005:             IF INLIST(loc_cNome, "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1006:                                  "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
1007:                 *-- Tornar filhos visiveis sem tocar Visible do proprio container
1008:                 THIS.TornarControlesVisiveis(loc_oControl)
1009:                 LOOP
1010:             ENDIF
1011: 
1012:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1013:                 loc_oControl.Visible = .T.
1014:             ENDIF
1015: 
1016:             *-- Recursar em containers e pageframes
1017:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1018:                loc_oControl.ControlCount > 0
1019:                 THIS.TornarControlesVisiveis(loc_oControl)
1020:             ENDIF
1021:         ENDFOR
1022:     ENDPROC
1023: 
1024:     *==========================================================================
1025:     * ConfigurarBINDEVENTs - handlers dos checkboxes e botoes
1026:     *==========================================================================
1027:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1028:         *-- CheckBoxes e botoes principais
1029:         BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
1030:         BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
1031:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkCustoClick")
1032:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkCompraClick")
1033:         BINDEVENT(THIS.cmd_4c_Processa,  "Click", THIS, "BtnProcessarClick")
1034:         BINDEVENT(THIS.cmd_4c_Cancela,   "Click", THIS, "BtnCancelaClick")
1035: 
1036:         *-- OpConta: Empresa, Grupos, Contas, Moedas
1037:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_Empresa,   "KeyPress", THIS, "TxtContaEmpresaKeyPress")
1038:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtContaGruposKeyPress")
1039:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "KeyPress", THIS, "TxtContaContasKeyPress")
1040:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas, "KeyPress", THIS, "TxtContaMoedasKeyPress")
1041: 
1042:         *-- OpEstoque: Empresa, Grupos, Estoque, Produto
1043:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Empresa,   "KeyPress", THIS, "TxtEstEmpresaKeyPress")
1044:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtEstGruposKeyPress")
1045:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Estoque,   "KeyPress", THIS, "TxtEstEstoqueKeyPress")
1046:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Produto,   "KeyPress", THIS, "TxtEstProdutoKeyPress")
1047: 
1048:         *-- OpCusto: Empresa, Produto
1049:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_Empresa, "KeyPress", THIS, "TxtCustoEmpresaKeyPress")
1050:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_Produto, "KeyPress", THIS, "TxtCustoProdutoKeyPress")
1051: 
1052:         *-- OpCompra: Empresa, Produto
1053:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_Empresa, "KeyPress", THIS, "TxtCompraEmpresaKeyPress")
1054:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_Produto, "KeyPress", THIS, "TxtCompraProdutoKeyPress")
1055:     ENDPROC
1056: 
1057:     *==========================================================================
1058:     * BtnProcessarClick - orquestrador do processamento
1059:     *==========================================================================
1060:     PROCEDURE BtnProcessarClick
1061:         LOCAL loc_lSucesso, loc_lAlgum, loc_oBO, loc_oProgress
1062: 
1063:         loc_lSucesso = .F.
1064:         loc_lAlgum   = .F.
1065:         loc_oProgress = .NULL.
1066: 
1067:         IF THIS.chk_4c_Conta.Value = 0 AND THIS.chk_4c_Estoque.Value = 0 AND ;
1068:            THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1069:             MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + "lculo.")
1070:             RETURN .F.
1071:         ENDIF
1072: 
1073:         TRY
1074:             *-- Desabilitar controles durante processamento
1075:             THIS.chk_4c_Conta.Enabled     = .F.
1076:             THIS.chk_4c_Estoque.Enabled   = .F.
1077:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1078:             THIS.chk_4c_BtnCompra.Enabled = .F.
1079:             THIS.cmd_4c_Processa.Enabled  = .F.
1080:             THIS.cmd_4c_Cancela.Enabled   = .F.
1081:             THIS.lbl_4c_LblEnd.Visible    = .F.
1082:             THIS.txt_4c_Registro.Value    = 0
1083:             DOEVENTS
1084: 
1085:             loc_oBO = THIS.this_oBusinessObject
1086:             loc_oBO.this_nRegistros = 0
1087: 
1088:             loc_oProgress = CREATEOBJECT("fwprogressbar")
1089:             IF VARTYPE(loc_oProgress) = "O"
1090:                 loc_oProgress.Show()
1091:             ENDIF
1092: 
1093:             *-- Recalcular Conta Corrente
1094:             IF THIS.chk_4c_Conta.Value = 1
1095:                 loc_oBO.this_cEmpConta   = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_Empresa.Value)
1096:                 loc_oBO.this_cGrupoConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos.Value)
1097:                 loc_oBO.this_cConta      = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtContas.Value)
1098:                 loc_oBO.this_cMoedaConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas.Value)
1099:                 loc_oBO.this_dDataConta  = THIS.cnt_4c_OpConta.txt_4c_TxtData.Value
1100:                 IF VARTYPE(loc_oProgress) = "O"
1101:                     loc_oProgress.Update("Recalculando Conta Corrente...")
1102:                 ENDIF
1103:                 IF loc_oBO.RecalcularSaldosConta()
1104:                     loc_lAlgum = .T.
1105:                 ENDIF
1106:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1107:                 DOEVENTS
1108:             ENDIF
1109: 
1110:             *-- Recalcular Estoque
1111:             IF THIS.chk_4c_Estoque.Value = 1
1112:                 loc_oBO.this_cEmpEst   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value)
1113:                 loc_oBO.this_cGrupoEst = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos.Value)
1114:                 loc_oBO.this_cEstoque  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Estoque.Value)
1115:                 loc_oBO.this_cProdEst  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Produto.Value)
1116:                 loc_oBO.this_dDataEst  = THIS.cnt_4c_OpEstoque.txt_4c_TxtData.Value
1117:                 IF VARTYPE(loc_oProgress) = "O"
1118:                     loc_oProgress.Update("Recalculando Estoque...")
1119:                 ENDIF
1120:                 IF loc_oBO.RecalcularSaldosEstoque()
1121:                     loc_lAlgum = .T.
1122:                 ENDIF
1123:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1124:                 DOEVENTS
1125:             ENDIF
1126: 
1127:             *-- Recalcular Custo de Produto
1128:             IF THIS.chk_4c_BtnCusto.Value = 1
1129:                 loc_oBO.this_cEmpCusto  = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value)
1130:                 loc_oBO.this_cProdCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Produto.Value)
1131:                 loc_oBO.this_dDataCusto = THIS.cnt_4c_OpCusto.txt_4c_TxtData.Value
1132:                 IF VARTYPE(loc_oProgress) = "O"
1133:                     loc_oProgress.Update("Recalculando Custo de Produto...")
1134:                 ENDIF
1135:                 IF loc_oBO.RecalcularSaldosCusto()
1136:                     loc_lAlgum = .T.
1137:                 ENDIF
1138:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1139:                 DOEVENTS
1140:             ENDIF
1141: 
1142:             *-- Recalcular Ultima Compra
1143:             IF THIS.chk_4c_BtnCompra.Value = 1
1144:                 loc_oBO.this_cEmpCompra  = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value)
1145:                 loc_oBO.this_cProdCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Produto.Value)
1146:                 loc_oBO.this_dDataCompra = THIS.cnt_4c_OpCompra.txt_4c_TxtData.Value
1147:                 IF VARTYPE(loc_oProgress) = "O"
1148:                     loc_oProgress.Update(CHR(218) + "ltima Compra...")
1149:                 ENDIF
1150:                 IF loc_oBO.RecalcularSaldosCompra()
1151:                     loc_lAlgum = .T.
1152:                 ENDIF
1153:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1154:                 DOEVENTS
1155:             ENDIF
1156: 
1157:             IF loc_lAlgum
1158:                 THIS.lbl_4c_LblEnd.Visible = .T.
1159:             ENDIF
1160: 
1161:             loc_lSucesso = .T.
1162:         CATCH TO loc_oErro
1163:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1164:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.BtnProcessarClick")
1165:         ENDTRY
1166: 
1167:         *-- Reabilitar controles
1168:         THIS.chk_4c_Conta.Enabled     = .T.
1169:         THIS.chk_4c_Estoque.Enabled   = .T.
1170:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1171:         THIS.chk_4c_BtnCompra.Enabled = .T.
1172:         THIS.cmd_4c_Cancela.Enabled   = .T.
1173:         THIS.AtualizarEstadoProcessa()
1174: 
1175:         IF VARTYPE(loc_oProgress) = "O"
1176:             loc_oProgress.Release()
1177:             loc_oProgress = .NULL.
1178:         ENDIF
1179: 
1180:         RETURN loc_lSucesso
1181:     ENDPROC
1182: 
1183:     *==========================================================================
1184:     * BtnCancelaClick - fecha o formulario
1185:     *==========================================================================
1186:     PROCEDURE BtnCancelaClick
1187:         THISFORM.Release()
1188:     ENDPROC
1189: 
1190:     *==========================================================================
1191:     * ChkContaClick / ChkEstoqueClick / ChkCustoClick / ChkCompraClick
1192:     *==========================================================================
1193:     PROCEDURE ChkContaClick
1194:         THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
1195:         THIS.AtualizarEstadoProcessa()
1196:     ENDPROC
1197: 
1198:     PROCEDURE ChkEstoqueClick
1199:         THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
1200:         THIS.AtualizarEstadoProcessa()
1201:     ENDPROC
1202: 
1203:     PROCEDURE ChkCustoClick
1204:         THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
1205:         THIS.AtualizarEstadoProcessa()
1206:     ENDPROC
1207: 
1208:     PROCEDURE ChkCompraClick
1209:         THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
1210:         THIS.AtualizarEstadoProcessa()
1211:     ENDPROC
1212: 
1213:     PROTECTED PROCEDURE AtualizarEstadoProcessa
1214:         LOCAL loc_lAlgum
1215:         loc_lAlgum = (THIS.chk_4c_Conta.Value = 1) OR ;
1216:                      (THIS.chk_4c_Estoque.Value = 1) OR ;
1217:                      (THIS.chk_4c_BtnCusto.Value = 1) OR ;
1218:                      (THIS.chk_4c_BtnCompra.Value = 1)
1219:         THIS.cmd_4c_Processa.Enabled = loc_lAlgum
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * KeyPress handlers - OpConta
1224:     *==========================================================================
1225:     PROCEDURE TxtContaEmpresaKeyPress
1226:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1227:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1228:             RETURN
1229:         ENDIF
1230:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_Empresa)
1231:     ENDPROC
1232: 
1233:     PROCEDURE TxtContaGruposKeyPress
1234:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1235:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1236:             RETURN
1237:         ENDIF
1238:         THIS.AbrirLookupGruposCcr(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
1239:     ENDPROC
1240: 
1241:     PROCEDURE TxtContaContasKeyPress
1242:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1243:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1244:             RETURN
1245:         ENDIF
1246:         THIS.AbrirLookupContas(THIS.cnt_4c_OpConta.txt_4c_TxtContas)
1247:     ENDPROC
1248: 
1249:     PROCEDURE TxtContaMoedasKeyPress
1250:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1251:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1252:             RETURN
1253:         ENDIF
1254:         THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas)
1255:     ENDPROC
1256: 
1257:     *==========================================================================
1258:     * KeyPress handlers - OpEstoque
1259:     *==========================================================================
1260:     PROCEDURE TxtEstEmpresaKeyPress
1261:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1262:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1263:             RETURN
1264:         ENDIF
1265:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_Empresa)
1266:     ENDPROC
1267: 
1268:     PROCEDURE TxtEstGruposKeyPress
1269:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1270:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1271:             RETURN
1272:         ENDIF
1273:         THIS.AbrirLookupGruposEst(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
1274:     ENDPROC
1275: 
1276:     PROCEDURE TxtEstEstoqueKeyPress
1277:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1278:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1279:             RETURN
1280:         ENDIF
1281:         THIS.AbrirLookupEstoque(THIS.cnt_4c_OpEstoque.txt_4c_Estoque)
1282:     ENDPROC
1283: 
1284:     PROCEDURE TxtEstProdutoKeyPress
1285:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1286:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1287:             RETURN
1288:         ENDIF
1289:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * KeyPress handlers - OpCusto
1294:     *==========================================================================
1295:     PROCEDURE TxtCustoEmpresaKeyPress
1296:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1297:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1298:             RETURN
1299:         ENDIF
1300:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_Empresa)
1301:     ENDPROC
1302: 
1303:     PROCEDURE TxtCustoProdutoKeyPress
1304:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1305:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1306:             RETURN
1307:         ENDIF
1308:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
1309:     ENDPROC
1310: 
1311:     *==========================================================================
1312:     * KeyPress handlers - OpCompra
1313:     *==========================================================================
1314:     PROCEDURE TxtCompraEmpresaKeyPress
1315:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1316:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1317:             RETURN
1318:         ENDIF
1319:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_Empresa)
1320:     ENDPROC
1321: 
1322:     PROCEDURE TxtCompraProdutoKeyPress
1323:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1324:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1325:             RETURN
1326:         ENDIF
1327:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
1328:     ENDPROC
1329: 
1330:     *==========================================================================
1331:     * AbrirLookupEmpresa - sigcdemp (cemps / razas)
1332:     *==========================================================================
1333:     PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
1334:         LOCAL loc_oForm, loc_cVal
1335:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1336:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1337:             "sigcdemp", "cursor_4c_LkpEmp", "cemps", loc_cVal, "Selecionar Empresa")
1338:         IF ISNULL(loc_oForm)
1339:             RETURN
1340:         ENDIF
1341:         IF NOT loc_oForm.this_lAchouRegistro
1342:             loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "d.")
1343:             loc_oForm.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
1344:             loc_oForm.Show()
1345:         ENDIF
1346:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpEmp")
1347:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpEmp.cemps)
1348:         ENDIF
1349:         IF USED("cursor_4c_LkpEmp")
1350:             USE IN cursor_4c_LkpEmp
1351:         ENDIF
1352:         loc_oForm.Release()
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * AbrirLookupGruposCcr - SigCdGcr (codigos / descrs)
1357:     *==========================================================================
1358:     PROTECTED PROCEDURE AbrirLookupGruposCcr(par_oTxt)
1359:         LOCAL loc_oForm, loc_cVal
1360:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1361:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1362:             "SigCdGcr", "cursor_4c_LkpGcr", "codigos", loc_cVal, "Grupo C/C")
1363:         IF ISNULL(loc_oForm)
1364:             RETURN
1365:         ENDIF
1366:         IF NOT loc_oForm.this_lAchouRegistro
1367:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
1368:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1369:             loc_oForm.Show()
1370:         ENDIF
1371:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpGcr")
1372:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpGcr.codigos)
1373:         ENDIF
1374:         IF USED("cursor_4c_LkpGcr")
1375:             USE IN cursor_4c_LkpGcr
1376:         ENDIF
1377:         loc_oForm.Release()
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * AbrirLookupContas - SigCdCli (Iclis / Rclis)
1382:     *==========================================================================
1383:     PROTECTED PROCEDURE AbrirLookupContas(par_oTxt)
1384:         LOCAL loc_oForm, loc_cVal
1385:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1386:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1387:             "SigCdCli", "cursor_4c_LkpCcr", "Iclis", loc_cVal, "Conta Corrente")
1388:         IF ISNULL(loc_oForm)
1389:             RETURN
1390:         ENDIF
1391:         IF NOT loc_oForm.this_lAchouRegistro
1392:             loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
1393:             loc_oForm.mAddColuna("Rclis", "", "Nome")
1394:             loc_oForm.Show()
1395:         ENDIF
1396:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpCcr")
1397:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpCcr.Iclis)
1398:         ENDIF
1399:         IF USED("cursor_4c_LkpCcr")
1400:             USE IN cursor_4c_LkpCcr
1401:         ENDIF
1402:         loc_oForm.Release()
1403:     ENDPROC
1404: 
1405:     *==========================================================================
1406:     * AbrirLookupMoeda - SigCdMoe (cmoes / dmoes)
1407:     *==========================================================================
1408:     PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
1409:         LOCAL loc_oForm, loc_cVal
1410:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1411:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1412:             "SigCdMoe", "cursor_4c_LkpMoe", "cmoes", loc_cVal, "Selecionar Moeda")
1413:         IF ISNULL(loc_oForm)
1414:             RETURN
1415:         ENDIF
1416:         IF NOT loc_oForm.this_lAchouRegistro
1417:             loc_oForm.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
1418:             loc_oForm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1419:             loc_oForm.Show()
1420:         ENDIF
1421:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpMoe")
1422:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpMoe.cmoes)
1423:         ENDIF
1424:         IF USED("cursor_4c_LkpMoe")
1425:             USE IN cursor_4c_LkpMoe
1426:         ENDIF
1427:         loc_oForm.Release()
1428:     ENDPROC
1429: 
1430:     *==========================================================================
1431:     * AbrirLookupProduto - SigCdPro (cpros / dpros) + atualiza descricao
1432:     *==========================================================================
1433:     PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtProd, par_oTxtDesc)
1434:         LOCAL loc_oForm, loc_cVal
1435:         loc_cVal  = ALLTRIM(par_oTxtProd.Value)
1436:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1437:             "SigCdPro", "cursor_4c_LkpPro", "cpros", loc_cVal, "Selecionar Produto")
1438:         IF ISNULL(loc_oForm)
1439:             RETURN
1440:         ENDIF
1441:         IF NOT loc_oForm.this_lAchouRegistro
1442:             loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
1443:             loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1444:             loc_oForm.Show()
1445:         ENDIF
1446:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpPro")
1447:             par_oTxtProd.Value = ALLTRIM(cursor_4c_LkpPro.cpros)
1448:             IF VARTYPE(par_oTxtDesc) = "O"
1449:                 par_oTxtDesc.Value = ALLTRIM(cursor_4c_LkpPro.dpros)
1450:             ENDIF
1451:         ENDIF
1452:         IF USED("cursor_4c_LkpPro")
1453:             USE IN cursor_4c_LkpPro
1454:         ENDIF
1455:         loc_oForm.Release()
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * AbrirLookupGruposEst - SigMvHst grupos (grupo de deposito)
1460:     *==========================================================================
1461:     PROTECTED PROCEDURE AbrirLookupGruposEst(par_oTxt)
1462:         LOCAL loc_oForm, loc_cVal
1463:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1464:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1465:             "SigMvHst", "cursor_4c_LkpGruEst", "grupos", loc_cVal, ;
1466:             "Grupo de Dep" + CHR(243) + "sito")
1467:         IF ISNULL(loc_oForm)
1468:             RETURN
1469:         ENDIF
1470:         IF NOT loc_oForm.this_lAchouRegistro
1471:             loc_oForm.mAddColuna("grupos", "", "Grupo")
1472:             loc_oForm.mAddColuna("estos",  "", "Estoque")
1473:             loc_oForm.Show()
1474:         ENDIF
1475:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpGruEst")
1476:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpGruEst.grupos)
1477:         ENDIF
1478:         IF USED("cursor_4c_LkpGruEst")
1479:             USE IN cursor_4c_LkpGruEst
1480:         ENDIF
1481:         loc_oForm.Release()
1482:     ENDPROC
1483: 
1484:     *==========================================================================
1485:     * AbrirLookupEstoque - SigMvHst estos (codigo do deposito)
1486:     *==========================================================================
1487:     PROTECTED PROCEDURE AbrirLookupEstoque(par_oTxt)
1488:         LOCAL loc_oForm, loc_cVal
1489:         loc_cVal  = ALLTRIM(par_oTxt.Value)
1490:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1491:             "SigMvHst", "cursor_4c_LkpEst", "estos", loc_cVal, ;
1492:             "Dep" + CHR(243) + "sito/Estoque")
1493:         IF ISNULL(loc_oForm)
1494:             RETURN
1495:         ENDIF
1496:         IF NOT loc_oForm.this_lAchouRegistro
1497:             loc_oForm.mAddColuna("estos",  "", "Estoque")
1498:             loc_oForm.mAddColuna("grupos", "", "Grupo")
1499:             loc_oForm.Show()
1500:         ENDIF
1501:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpEst")
1502:             par_oTxt.Value = ALLTRIM(cursor_4c_LkpEst.estos)
1503:         ENDIF
1504:         IF USED("cursor_4c_LkpEst")
1505:             USE IN cursor_4c_LkpEst
1506:         ENDIF
1507:         loc_oForm.Release()
1508:     ENDPROC
1509: 
1510:     *==========================================================================
1511:     * ConfigurarPaginaLista - Reset da UI ao estado inicial de sele" + CHR(231) + CHR(227) + "o
1512:     * Form OPERACIONAL: nao ha Page1/Page2 (layout flat), este metodo
1513:     * restaura o estado limpo equivalente a "voltar para a lista" ??? oculta
1514:     * containers flutuantes, desmarca opcoes, zera contador e mensagem final.
1515:     * Chamado apos processamento concluir OU quando quiser reiniciar selecao.
1516:     *==========================================================================
1517:     PROTECTED PROCEDURE ConfigurarPaginaLista
1518:         *-- Desmarca todos os checkboxes de opcao (Conta, Estoque, Custo, Compra)
1519:         THIS.chk_4c_Conta.Value     = 0
1520:         THIS.chk_4c_Estoque.Value   = 0
1521:         THIS.chk_4c_BtnCusto.Value  = 0
1522:         THIS.chk_4c_BtnCompra.Value = 0
1523: 
1524:         *-- Oculta todos os containers flutuantes de opcoes
1525:         THIS.cnt_4c_OpConta.Visible   = .F.
1526:         THIS.cnt_4c_OpEstoque.Visible = .F.
1527:         THIS.cnt_4c_OpCusto.Visible   = .F.
1528:         THIS.cnt_4c_OpCompra.Visible  = .F.
1529: 
1530:         *-- Limpa contador de registros e oculta label de conclusao
1531:         THIS.txt_4c_Registro.Value  = 0
1532:         THIS.lbl_4c_LblEnd.Visible  = .F.
1533: 
1534:         *-- Reabilita controles (caso venham de processamento anterior)
1535:         THIS.chk_4c_Conta.Enabled     = .T.
1536:         THIS.chk_4c_Estoque.Enabled   = .T.
1537:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1538:         THIS.chk_4c_BtnCompra.Enabled = .T.
1539:         THIS.cmd_4c_Cancela.Enabled   = .T.
1540: 
1541:         *-- Atualiza estado do botao Processar (deve ficar desabilitado sem selecao)
1542:         THIS.AtualizarEstadoProcessa()
1543: 
1544:         RETURN .T.
1545:     ENDPROC
1546: 
1547:     *==========================================================================
1548:     * ConfigurarPaginaDados - Prepara TODOS os campos de entrada do form
1549:     * Form OPERACIONAL: nao ha Page2/Dados; este metodo mapeia o conceito
1550:     * "preparar formulario para entrada de dados" para os 4 containers de
1551:     * opcoes (OpConta, OpEstoque, OpCusto, OpCompra), resetando cada campo
1552:     * para valor default e habilitando edicao. Chamado apos limpeza de UI
1553:     * (ConfigurarPaginaLista) OU quando quiser reiniciar a entrada de dados
1554:     * apos processamento concluir sem fechar o form.
1555:     *==========================================================================
1556:     PROTECTED PROCEDURE ConfigurarPaginaDados
1557:         LOCAL loc_cEmp
1558:         loc_cEmp = go_4c_Sistema.cCodEmpresa
1559: 
1560:         *-- Container OpConta (Conta Corrente): Empresa=default, demais em branco
1561:         WITH THIS.cnt_4c_OpConta
1562:             .txt_4c_Empresa.Value   = loc_cEmp
1563:             .txt_4c_Empresa.Enabled = .T.
1564:             .txt_4c_TxtGrupos.Value = ""
1565:             .txt_4c_TxtGrupos.Enabled = .T.
1566:             .txt_4c_TxtContas.Value = ""
1567:             .txt_4c_TxtContas.Enabled = .T.
1568:             .txt_4c_TxtMoedas.Value = ""
1569:             .txt_4c_TxtMoedas.Enabled = .T.
1570:             .txt_4c_TxtData.Value   = {}
1571:             .txt_4c_TxtData.Enabled = .T.
1572:             .Visible     = .T.
1573:         ENDWITH
1574: 
1575:         *-- Container OpEstoque: Empresa=default, demais em branco
1576:         WITH THIS.cnt_4c_OpEstoque
1577:             .txt_4c_Empresa.Value   = loc_cEmp
1578:             .txt_4c_Empresa.Enabled = .T.
1579:             .txt_4c_TxtGrupos.Value = ""
1580:             .txt_4c_TxtGrupos.Enabled = .T.
1581:             .txt_4c_Estoque.Value   = ""
1582:             .txt_4c_Estoque.Enabled = .T.
1583:             .txt_4c_Produto.Value   = ""
1584:             .txt_4c_Produto.Enabled = .T.
1585:             .txt_4c_Descricao.Value = ""
1586:             .txt_4c_TxtData.Value   = {}
1587:             .txt_4c_TxtData.Enabled = .T.
1588:             .Visible     = .T.
1589:         ENDWITH
1590: 
1591:         *-- Container OpCusto: Empresa=default, demais em branco
1592:         WITH THIS.cnt_4c_OpCusto
1593:             .txt_4c_Empresa.Value   = loc_cEmp
1594:             .txt_4c_Empresa.Enabled = .T.
1595:             .txt_4c_Produto.Value   = ""
1596:             .txt_4c_Produto.Enabled = .T.
1597:             .txt_4c_Descricao.Value = ""
1598:             .txt_4c_TxtData.Value   = {}
1599:             .txt_4c_TxtData.Enabled = .T.
1600:             .Visible     = .T.
1601:         ENDWITH
1602: 
1603:         *-- Container OpCompra: Empresa=default, demais em branco
1604:         WITH THIS.cnt_4c_OpCompra
1605:             .txt_4c_Empresa.Value   = loc_cEmp
1606:             .txt_4c_Empresa.Enabled = .T.
1607:             .txt_4c_Produto.Value   = ""
1608:             .txt_4c_Produto.Enabled = .T.
1609:             .txt_4c_Descricao.Value = ""
1610:             .txt_4c_TxtData.Value   = {}
1611:             .txt_4c_TxtData.Enabled = .T.
1612:             .Visible     = .T.
1613:         ENDWITH
1614: 
1615:         RETURN .T.
1616:     ENDPROC
1617: 
1618:     *==========================================================================
1619:     * AlternarPagina - Alterna qual container de opcoes esta visivel
1620:     * Form OPERACIONAL: nao ha PageFrame; este metodo mapeia o conceito
1621:     * "trocar de pagina" para "trocar qual painel de opcoes esta ativo".
1622:     *   par_nPagina = 1 ??> Conta Corrente     (cnt_4c_OpConta)
1623:     *   par_nPagina = 2 ??> Estoque            (cnt_4c_OpEstoque)
1624:     *   par_nPagina = 3 ??> Custo de Produto   (cnt_4c_OpCusto)
1625:     *   par_nPagina = 4 ??> Ultima Compra      (cnt_4c_OpCompra)
1626:     *   par_nPagina = 0 ??> reset (oculta todos, equivale a ConfigurarPaginaLista)
1627:     *==========================================================================
1628:     PROCEDURE AlternarPagina(par_nPagina)
1629:         LOCAL loc_nPagina
1630:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)
1631: 
1632:         DO CASE
1633:             CASE loc_nPagina = 1
1634:                 THIS.chk_4c_Conta.Value       = 1
1635:                 THIS.cnt_4c_OpConta.Visible   = .T.
1636:             CASE loc_nPagina = 2
1637:                 THIS.chk_4c_Estoque.Value     = 1
1638:                 THIS.cnt_4c_OpEstoque.Visible = .T.
1639:             CASE loc_nPagina = 3
1640:                 THIS.chk_4c_BtnCusto.Value    = 1
1641:                 THIS.cnt_4c_OpCusto.Visible   = .T.
1642:             CASE loc_nPagina = 4
1643:                 THIS.chk_4c_BtnCompra.Value   = 1
1644:                 THIS.cnt_4c_OpCompra.Visible  = .T.
1645:             OTHERWISE
1646:                 THIS.ConfigurarPaginaLista()
1647:         ENDCASE
1648: 
1649:         THIS.AtualizarEstadoProcessa()
1650:         RETURN .T.
1651:     ENDPROC
1652: 
1653:     *==========================================================================
1654:     * BtnIncluirClick - Reseta o formulario para um novo ciclo de recalculo
1655:     * (Form OPERACIONAL: equivale a "Nova Sessao de Processamento")
1656:     *==========================================================================
1657:     PROCEDURE BtnIncluirClick
1658:         THIS.chk_4c_Conta.Value       = 0
1659:         THIS.chk_4c_Estoque.Value     = 0
1660:         THIS.chk_4c_BtnCusto.Value    = 0
1661:         THIS.chk_4c_BtnCompra.Value   = 0
1662: 
1663:         THIS.cnt_4c_OpConta.Visible   = .F.
1664:         THIS.cnt_4c_OpEstoque.Visible = .F.
1665:         THIS.cnt_4c_OpCusto.Visible   = .F.
1666:         THIS.cnt_4c_OpCompra.Visible  = .F.
1667: 
1668:         THIS.LimparCamposContainer(THIS.cnt_4c_OpConta)
1669:         THIS.LimparCamposContainer(THIS.cnt_4c_OpEstoque)
1670:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCusto)
1671:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)
1672: 
1673:         THIS.txt_4c_Registro.Value    = ""
1674:         THIS.lbl_4c_LblEnd.Visible    = .F.
1675: 
1676:         THIS.cmd_4c_Processa.Enabled  = .F.
1677:         THIS.cmd_4c_Cancela.Enabled   = .T.
1678: 
1679:         THIS.Refresh()
1680:     ENDPROC
1681: 
1682:     *==========================================================================
1683:     * BtnAlterarClick - Habilita novamente os controles apos processamento
1684:     * (Form OPERACIONAL: equivale a "Alterar Selecao apos Processamento")
1685:     *==========================================================================
1686:     PROCEDURE BtnAlterarClick
1687:         THIS.chk_4c_Conta.Enabled     = .T.
1688:         THIS.chk_4c_Estoque.Enabled   = .T.
1689:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1690:         THIS.chk_4c_BtnCompra.Enabled = .T.
1691: 
1692:         THIS.cnt_4c_OpConta.Enabled   = (THIS.chk_4c_Conta.Value = 1)
1693:         THIS.cnt_4c_OpEstoque.Enabled = (THIS.chk_4c_Estoque.Value = 1)
1694:         THIS.cnt_4c_OpCusto.Enabled   = (THIS.chk_4c_BtnCusto.Value = 1)
1695:         THIS.cnt_4c_OpCompra.Enabled  = (THIS.chk_4c_BtnCompra.Value = 1)
1696: 
1697:         THIS.cmd_4c_Cancela.Enabled   = .T.
1698:         THIS.AtualizarEstadoProcessa()
1699:         THIS.Refresh()
1700:     ENDPROC
1701: 
1702:     *==========================================================================
1703:     * BtnVisualizarClick - Exibe status da ultima sessao de processamento
1704:     * (Form OPERACIONAL: consulta rapida do estado atual)
1705:     *==========================================================================
1706:     PROCEDURE BtnVisualizarClick
1707:         LOCAL loc_cMsg, loc_cSelecoes, loc_nSel
1708: 
1709:         loc_cSelecoes = ""
1710:         loc_nSel      = 0
1711: 
1712:         IF THIS.chk_4c_Conta.Value = 1
1713:             loc_cSelecoes = loc_cSelecoes + "- Conta Corrente" + CHR(13)
1714:             loc_nSel      = loc_nSel + 1
1715:         ENDIF
1716:         IF THIS.chk_4c_Estoque.Value = 1
1717:             loc_cSelecoes = loc_cSelecoes + "- Estoque" + CHR(13)
1718:             loc_nSel      = loc_nSel + 1
1719:         ENDIF
1720:         IF THIS.chk_4c_BtnCusto.Value = 1
1721:             loc_cSelecoes = loc_cSelecoes + "- Custo de Produto" + CHR(13)
1722:             loc_nSel      = loc_nSel + 1
1723:         ENDIF
1724:         IF THIS.chk_4c_BtnCompra.Value = 1
1725:             loc_cSelecoes = loc_cSelecoes + "- " + CHR(218) + "ltima Compra" + CHR(13)
1726:             loc_nSel      = loc_nSel + 1
1727:         ENDIF
1728: 
1729:         IF loc_nSel = 0
1730:             loc_cMsg = "Nenhum tipo de rec" + CHR(225) + "lculo selecionado." + CHR(13) + ;
1731:                        "Marque um dos checkboxes para configurar o processamento."
1732:         ELSE
1733:             loc_cMsg = "Tipos selecionados (" + TRANSFORM(loc_nSel) + "):" + CHR(13) + ;
1734:                        loc_cSelecoes + CHR(13) + ;
1735:                        "Registros processados: " + ALLTRIM(TRANSFORM(THIS.txt_4c_Registro.Value))
1736:         ENDIF
1737: 
1738:         MsgInfo(loc_cMsg, "Status do Processamento")
1739:     ENDPROC
1740: 
1741:     *==========================================================================
1742:     * BtnExcluirClick - Limpa todas as selecoes e restaura estado inicial
1743:     * (Form OPERACIONAL: equivale a "Cancelar todas as selecoes")
1744:     *==========================================================================
1745:     PROCEDURE BtnExcluirClick
1746:         THIS.chk_4c_Conta.Value       = 0
1747:         THIS.chk_4c_Estoque.Value     = 0
1748:         THIS.chk_4c_BtnCusto.Value    = 0
1749:         THIS.chk_4c_BtnCompra.Value   = 0
1750: 
1751:         THIS.cnt_4c_OpConta.Visible   = .F.
1752:         THIS.cnt_4c_OpEstoque.Visible = .F.
1753:         THIS.cnt_4c_OpCusto.Visible   = .F.
1754:         THIS.cnt_4c_OpCompra.Visible  = .F.
1755: 
1756:         THIS.txt_4c_Registro.Value    = ""
1757:         THIS.lbl_4c_LblEnd.Visible    = .F.
1758: 
1759:         THIS.AtualizarEstadoProcessa()
1760:         THIS.Refresh()
1761:     ENDPROC
1762: 
1763:     *==========================================================================
1764:     * LimparCamposContainer - helper para reset das textboxes de um container
1765:     *==========================================================================
1766:     PROTECTED PROCEDURE LimparCamposContainer(par_oContainer)
1767:         LOCAL loc_nI, loc_oCtrl
1768: 
1769:         IF VARTYPE(par_oContainer) != "O"
1770:             RETURN
1771:         ENDIF
1772: 
1773:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1774:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1775:             IF UPPER(loc_oCtrl.BaseClass) = "TEXTBOX"
1776:                 DO CASE
1777:                     CASE VARTYPE(loc_oCtrl.Value) = "C"
1778:                         loc_oCtrl.Value = ""
1779:                     CASE VARTYPE(loc_oCtrl.Value) = "N"
1780:                         loc_oCtrl.Value = 0
1781:                     CASE VARTYPE(loc_oCtrl.Value) = "D"
1782:                         loc_oCtrl.Value = {}
1783:                 ENDCASE
1784:             ENDIF
1785:         ENDFOR
1786:     ENDPROC
1787: 
1788:     *==========================================================================
1789:     * FormParaBO - Copia valores da UI (4 containers) para o BO
1790:     * (OPERACIONAL: nao ha CRUD, mas o BO carrega parametros para o
1791:     * processamento de RecalcularSaldos* e centraliza os valores digitados)
1792:     *==========================================================================
1793:     PROTECTED PROCEDURE FormParaBO
1794:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
1795:             RETURN .F.
1796:         ENDIF
1797: 
1798:         LOCAL loc_oBO
1799:         loc_oBO = THIS.this_oBusinessObject
1800: 
1801:         *-- Container OpConta (Conta Corrente)
1802:         WITH THIS.cnt_4c_OpConta
1803:             loc_oBO.this_cEmpConta   = ALLTRIM(.txt_4c_Empresa.Value)
1804:             loc_oBO.this_cGrupoConta = ALLTRIM(.txt_4c_TxtGrupos.Value)
1805:             loc_oBO.this_cConta      = ALLTRIM(.txt_4c_TxtContas.Value)
1806:             loc_oBO.this_cMoedaConta = ALLTRIM(.txt_4c_TxtMoedas.Value)
1807:             loc_oBO.this_dDataConta  = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1808:             .Visible     = .T.
1809:         ENDWITH
1810: 
1811:         *-- Container OpEstoque
1812:         WITH THIS.cnt_4c_OpEstoque
1813:             loc_oBO.this_cEmpEst      = ALLTRIM(.txt_4c_Empresa.Value)
1814:             loc_oBO.this_cGrupoEst    = ALLTRIM(.txt_4c_TxtGrupos.Value)
1815:             loc_oBO.this_cEstoque     = ALLTRIM(.txt_4c_Estoque.Value)
1816:             loc_oBO.this_cProdEst     = ALLTRIM(.txt_4c_Produto.Value)
1817:             loc_oBO.this_cDescProdEst = ALLTRIM(.txt_4c_Descricao.Value)
1818:             loc_oBO.this_dDataEst     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1819:             .Visible     = .T.
1820:         ENDWITH
1821: 
1822:         *-- Container OpCusto
1823:         WITH THIS.cnt_4c_OpCusto
1824:             loc_oBO.this_cEmpCusto      = ALLTRIM(.txt_4c_Empresa.Value)
1825:             loc_oBO.this_cProdCusto     = ALLTRIM(.txt_4c_Produto.Value)
1826:             loc_oBO.this_cDescProdCusto = ALLTRIM(.txt_4c_Descricao.Value)
1827:             loc_oBO.this_dDataCusto     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1828:             .Visible     = .T.
1829:         ENDWITH
1830: 
1831:         *-- Container OpCompra
1832:         WITH THIS.cnt_4c_OpCompra
1833:             loc_oBO.this_cEmpCompra      = ALLTRIM(.txt_4c_Empresa.Value)
1834:             loc_oBO.this_cProdCompra     = ALLTRIM(.txt_4c_Produto.Value)
1835:             loc_oBO.this_cDescProdCompra = ALLTRIM(.txt_4c_Descricao.Value)
1836:             loc_oBO.this_dDataCompra     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
1837:             .Visible     = .T.
1838:         ENDWITH
1839: 
1840:         *-- Contador de registros processados
1841:         IF VARTYPE(THIS.txt_4c_Registro.Value) = "N"
1842:             loc_oBO.this_nRegistros = THIS.txt_4c_Registro.Value
1843:         ELSE
1844:             loc_oBO.this_nRegistros = TRANSFORM(THIS.txt_4c_Registro.Value)
1845:         ENDIF
1846: 
1847:         RETURN .T.
1848:     ENDPROC
1849: 
1850:     *==========================================================================
1851:     * BOParaForm - Copia valores do BO para a UI (4 containers)
1852:     *==========================================================================
1853:     PROTECTED PROCEDURE BOParaForm
1854:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
1855:             RETURN .F.
1856:         ENDIF
1857: 
1858:         LOCAL loc_oBO
1859:         loc_oBO = THIS.this_oBusinessObject
1860: 
1861:         *-- Container OpConta (Conta Corrente)
1862:         WITH THIS.cnt_4c_OpConta
1863:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpConta
1864:             .txt_4c_TxtGrupos.Value = loc_oBO.this_cGrupoConta
1865:             .txt_4c_TxtContas.Value = loc_oBO.this_cConta
1866:             .txt_4c_TxtMoedas.Value = loc_oBO.this_cMoedaConta
1867:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataConta
1868:             .Visible     = .T.
1869:         ENDWITH
1870: 
1871:         *-- Container OpEstoque
1872:         WITH THIS.cnt_4c_OpEstoque
1873:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpEst
1874:             .txt_4c_TxtGrupos.Value = loc_oBO.this_cGrupoEst
1875:             .txt_4c_Estoque.Value   = loc_oBO.this_cEstoque
1876:             .txt_4c_Produto.Value   = loc_oBO.this_cProdEst
1877:             .txt_4c_Descricao.Value = loc_oBO.this_cDescProdEst
1878:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataEst
1879:             .Visible     = .T.
1880:         ENDWITH
1881: 
1882:         *-- Container OpCusto
1883:         WITH THIS.cnt_4c_OpCusto
1884:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpCusto
1885:             .txt_4c_Produto.Value   = loc_oBO.this_cProdCusto
1886:             .txt_4c_Descricao.Value = loc_oBO.this_cDescProdCusto
1887:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataCusto
1888:             .Visible     = .T.
1889:         ENDWITH
1890: 
1891:         *-- Container OpCompra
1892:         WITH THIS.cnt_4c_OpCompra
1893:             .txt_4c_Empresa.Value   = loc_oBO.this_cEmpCompra
1894:             .txt_4c_Produto.Value   = loc_oBO.this_cProdCompra
1895:             .txt_4c_Descricao.Value = loc_oBO.this_cDescProdCompra
1896:             .txt_4c_TxtData.Value   = loc_oBO.this_dDataCompra
1897:             .Visible     = .T.
1898:         ENDWITH
1899: 
1900:         THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1901: 
1902:         RETURN .T.
1903:     ENDPROC
1904: 
1905:     *==========================================================================
1906:     * HabilitarCampos - Habilita/desabilita containers e checkboxes conforme
1907:     * o estado de processamento (par_lHabilitar). Chamado por Processa e
1908:     * ao terminar o processamento para bloquear a UI durante a execucao SQL.
1909:     *==========================================================================
1910:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1911:         LOCAL loc_lHab
1912:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1913: 
1914:         *-- Checkboxes principais
1915:         THIS.chk_4c_Conta.Enabled     = loc_lHab
1916:         THIS.chk_4c_Estoque.Enabled   = loc_lHab
1917:         THIS.chk_4c_BtnCusto.Enabled  = loc_lHab
1918:         THIS.chk_4c_BtnCompra.Enabled = loc_lHab
1919: 
1920:         *-- Containers de opcoes: enabled apenas se o checkbox correspondente
1921:         *-- estiver marcado E o form estiver habilitado
1922:         THIS.cnt_4c_OpConta.Enabled   = loc_lHab AND (THIS.chk_4c_Conta.Value     = 1)
1923:         THIS.cnt_4c_OpEstoque.Enabled = loc_lHab AND (THIS.chk_4c_Estoque.Value   = 1)
1924:         THIS.cnt_4c_OpCusto.Enabled   = loc_lHab AND (THIS.chk_4c_BtnCusto.Value  = 1)
1925:         THIS.cnt_4c_OpCompra.Enabled  = loc_lHab AND (THIS.chk_4c_BtnCompra.Value = 1)
1926: 
1927:         *-- Botoes de acao
1928:         THIS.cmd_4c_Cancela.Enabled  = loc_lHab
1929:         THIS.cmd_4c_Processa.Enabled = loc_lHab AND ( ;
1930:             THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
1931:             THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1)
1932: 
1933:         RETURN .T.
1934:     ENDPROC
1935: 
1936:     *==========================================================================
1937:     * LimparCampos - Limpa TODOS os campos dos 4 containers de opcoes
1938:     *==========================================================================
1939:     PROTECTED PROCEDURE LimparCampos
1940:         THIS.LimparCamposContainer(THIS.cnt_4c_OpConta)
1941:         THIS.LimparCamposContainer(THIS.cnt_4c_OpEstoque)
1942:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCusto)
1943:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)
1944: 
1945:         *-- Restaura empresa padrao apos limpeza (evita campo vazio nas 4 abas)
1946:         LOCAL loc_cEmp
1947:         loc_cEmp = go_4c_Sistema.cCodEmpresa
1948:         THIS.cnt_4c_OpConta.txt_4c_Empresa.Value   = loc_cEmp
1949:         THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value = loc_cEmp
1950:         THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value   = loc_cEmp
1951:         THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value  = loc_cEmp
1952: 
1953:         THIS.txt_4c_Registro.Value = 0
1954:         THIS.lbl_4c_LblEnd.Visible = .F.
1955: 
1956:         RETURN .T.
1957:     ENDPROC
1958: 
1959:     *==========================================================================
1960:     * CarregarLista - Recarrega parametros do sistema (SigCdPam) via BO e
1961:     * atualiza a UI. Nome vem do padrao CRUD; aqui equivale a "refresh
1962:     * dos parametros centrais que direcionam o processamento".
1963:     *==========================================================================
1964:     PROCEDURE CarregarLista
1965:         LOCAL loc_lSucesso
1966:         loc_lSucesso = .F.
1967: 
1968:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
1969:             RETURN .F.
1970:         ENDIF
1971: 
1972:         TRY
1973:             THIS.this_oBusinessObject.InicializarDados()
1974:             THIS.BOParaForm()
1975:             loc_lSucesso = .T.
1976:         CATCH TO loc_oErro
1977:             THIS.this_cMensagemErro = loc_oErro.Message
1978:             MsgErro(loc_oErro.Message, "Erro ao recarregar par" + CHR(226) + "metros")
1979:         ENDTRY
1980: 
1981:         RETURN loc_lSucesso
1982:     ENDPROC
1983: 
1984:     *==========================================================================
1985:     * AjustarBotoesPorModo - Ajusta enabled dos botoes conforme o modo de UI
1986:     *   par_cModo = "INICIAL"      -> aguardando selecao (Processa disabled)
1987:     *   par_cModo = "PROCESSANDO"  -> execucao SQL em curso (tudo disabled)
1988:     *   par_cModo = "CONCLUIDO"    -> processamento terminado (Cancela habilita)
1989:     *==========================================================================
1990:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1991:         LOCAL loc_cModo
1992:         loc_cModo = IIF(VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo), UPPER(par_cModo), "INICIAL")
1993: 
1994:         DO CASE
1995:             CASE loc_cModo = "PROCESSANDO"
1996:                 THIS.cmd_4c_Processa.Enabled = .F.
1997:                 THIS.cmd_4c_Cancela.Enabled  = .F.
1998:                 THIS.HabilitarCampos(.F.)
1999:             CASE loc_cModo = "CONCLUIDO"
2000:                 THIS.cmd_4c_Processa.Enabled = .F.
2001:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2002:                 THIS.lbl_4c_LblEnd.Visible   = .T.
2003:                 THIS.HabilitarCampos(.F.)
2004:             OTHERWISE
2005:                 *-- INICIAL: aguardando selecao
2006:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2007:                 THIS.lbl_4c_LblEnd.Visible   = .F.
2008:                 THIS.HabilitarCampos(.T.)
2009:                 THIS.AtualizarEstadoProcessa()
2010:         ENDCASE
2011: 
2012:         RETURN .T.
2013:     ENDPROC
2014: 
2015:     *==========================================================================
2016:     * BtnBuscarClick - Recarrega parametros centrais do sistema (SigCdPam)
2017:     * Util para atualizar moeda central, grupos padrao, etc. sem sair do form
2018:     *==========================================================================
2019:     PROCEDURE BtnBuscarClick
2020:         IF THIS.CarregarLista()
2021:             MsgInfo("Par" + CHR(226) + "metros do sistema recarregados com sucesso.", ;
2022:                     "Atualiza" + CHR(231) + CHR(227) + "o")
2023:         ENDIF
2024:     ENDPROC
2025: 
2026:     *==========================================================================
2027:     * BtnEncerrarClick - Encerra o form (equivalente ao botao Cancela/Sair)
2028:     *==========================================================================
2029:     PROCEDURE BtnEncerrarClick
2030:         THIS.Release()
2031:     ENDPROC
2032: 
2033:     *==========================================================================
2034:     * BtnSalvarClick - Alias para BtnProcessarClick (executa recalculo)
2035:     * (OPERACIONAL: nao ha "salvar registro"; o botao de acao positiva
2036:     * eh Processar, entao Salvar mapeia para o mesmo fluxo)
2037:     *==========================================================================
2038:     PROCEDURE BtnSalvarClick
2039:         THIS.BtnProcessarClick()
2040:     ENDPROC
2041: 
2042:     *==========================================================================
2043:     * BtnCancelarClick - Alias para BtnCancelaClick (encerra o form)
2044:     *==========================================================================
2045:     PROCEDURE BtnCancelarClick
2046:         THIS.BtnCancelaClick()
2047:     ENDPROC
2048: 
2049:     *==========================================================================
2050:     PROCEDURE Destroy
2051:     *==========================================================================
2052:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2053:             THIS.this_oBusinessObject = .NULL.
2054:         ENDIF
2055:         DODEFAULT()
2056:     ENDPROC
2057: 
2058: ENDDEFINE


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

            loc_cSQL = "SELECT cidchaves, emps, grupos, contas, moedas, " + ;
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
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
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

            loc_cSQL = "SELECT cidchaves, cpros, emps, grupos, estos, " + ;
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
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
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
                        loc_cSQL = "SELECT TOP 1 cidchaves, cpros, emps, datas, numes, " + ;
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

