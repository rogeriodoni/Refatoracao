# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (73)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_BOTOES. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'cmdfpMin' (parent: SIGCDPAG.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_CmdfpMin' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdfpdpar' (parent: SIGCDPAG.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_Cmdfpdpar' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Bot_BIN' (parent: SIGCDPAG.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_Bot_BIN' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnExpXML' (parent: SIGCDPAG.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_BtnExpXML' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmdCopia' (parent: SIGCDPAG.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_CmdCopia' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnImpXML' (parent: SIGCDPAG.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_BtnImpXML' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optImpBols' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=356 vs migrado 'obj_4c_OptImpBols' Top=2 (diff=354px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optImpBols' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_OptImpBols' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptImpDups' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=381 vs migrado 'obj_4c_OptImpDups' Top=2 (diff=379px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptImpDups' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_OptImpDups' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup13' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=407 vs migrado 'obj_4c_Optiongroup13' Top=2 (diff=405px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup13' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup13' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Liscongv' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=433 vs migrado 'obj_4c_Opt_Liscongv' Top=2 (diff=431px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Liscongv' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Opt_Liscongv' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpcaoSNA' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=80 vs migrado 'obj_4c_OpcaoSNA' Top=2 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpcaoSNA' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_OpcaoSNA' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup11' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup11' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_valpend' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Op_valpend' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup12' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=330 vs migrado 'obj_4c_Optiongroup12' Top=2 (diff=328px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup12' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup12' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptFechm' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=105 vs migrado 'obj_4c_OptFechm' Top=2 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptFechm' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_OptFechm' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup4' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=305 vs migrado 'obj_4c_Optiongroup4' Top=2 (diff=303px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup4' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup4' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup10' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=155 vs migrado 'obj_4c_Optiongroup10' Top=2 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup10' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup10' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=280 vs migrado 'obj_4c_Optiongroup3' Top=2 (diff=278px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup3' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ImpChqs' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=80 vs migrado 'obj_4c_Op_ImpChqs' Top=2 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ImpChqs' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Op_ImpChqs' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup8' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=255 vs migrado 'obj_4c_Optiongroup8' Top=2 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup8' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup8' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTrocos' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=180 vs migrado 'obj_4c_OptTrocos' Top=2 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTrocos' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_OptTrocos' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup7' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=130 vs migrado 'obj_4c_Optiongroup7' Top=2 (diff=128px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup7' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup7' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Emichqs' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=55 vs migrado 'obj_4c_Op_Emichqs' Top=2 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Emichqs' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Op_Emichqs' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup6' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=105 vs migrado 'obj_4c_Optiongroup6' Top=2 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup6' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup6' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup5' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=205 vs migrado 'obj_4c_Optiongroup5' Top=2 (diff=203px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup5' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup5' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=155 vs migrado 'obj_4c_Optiongroup10' Top=2 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup10' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=230 vs migrado 'obj_4c_Optiongroup2_p2' Top=2 (diff=228px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Optiongroup2_p2' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxComis' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=479 vs migrado 'obj_4c_Op_BxComis' Left=0 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptObserva' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=130 vs migrado 'obj_4c_OptObserva' Top=2 (diff=128px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptObserva' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_OptObserva' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Fwoption1' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptTpLeituras' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=55 vs migrado 'obj_4c_OptTpLeituras' Top=2 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptTpLeituras' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_OptTpLeituras' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup14' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=231 vs migrado 'obj_4c_Optiongroup14' Top=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup14' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup14' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup15' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=296 vs migrado 'obj_4c_Optiongroup15' Top=2 (diff=294px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup15' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup15' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup16' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=346 vs migrado 'obj_4c_Optiongroup16' Top=0 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup16' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup16' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup17' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Top original=321 vs migrado 'obj_4c_Optiongroup17' Top=2 (diff=319px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup17' (parent: SIGCDPAG.Pagina.Dados.Dados.Page1): Left original=765 vs migrado 'obj_4c_Optiongroup17' Left=0 (diff=765px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup4' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Top original=411 vs migrado 'obj_4c_Optiongroup4' Top=2 (diff=409px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup4' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Left original=670 vs migrado 'obj_4c_Optiongroup4' Left=0 (diff=670px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Top original=386 vs migrado 'obj_4c_Optiongroup2_p2' Top=2 (diff=384px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Left original=670 vs migrado 'obj_4c_Optiongroup2_p2' Left=0 (diff=670px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Top original=262 vs migrado 'obj_4c_Optiongroup10' Top=2 (diff=260px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Left original=893 vs migrado 'obj_4c_Optiongroup10' Left=0 (diff=893px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup12' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Top original=403 vs migrado 'obj_4c_Optiongroup12' Top=2 (diff=401px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup12' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Left original=170 vs migrado 'obj_4c_Optiongroup12' Left=0 (diff=170px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Top original=435 vs migrado 'obj_4c_Optiongroup3' Top=2 (diff=433px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDPAG.Pagina.Dados.Dados.Page2): Left original=670 vs migrado 'obj_4c_Optiongroup3' Left=0 (diff=670px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_ContaMov' (parent: SIGCDPAG.Pagina.Dados): Top original=90 vs migrado 'obj_4c_Opt_ContaMov' Top=2 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_ContaMov' (parent: SIGCDPAG.Pagina.Dados): Left original=479 vs migrado 'obj_4c_Opt_ContaMov' Left=0 (diff=479px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formpag.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3611 linhas total):

*-- Linhas 18 a 333:
18:     this_cModoAtual      = "LISTA"
19: 
20:     *==========================================================================
21:     PROCEDURE Init()
22:     *==========================================================================
23:         DODEFAULT()
24:     ENDPROC
25: 
26:     *==========================================================================
27:     PROTECTED PROCEDURE InicializarForm()
28:     *==========================================================================
29:         LOCAL loc_lResultado
30:         loc_lResultado = .F.
31: 
32:         TRY
33:             THIS.this_oBusinessObject = CREATEOBJECT("pagBO")
34:             IF ISNULL(THIS.this_oBusinessObject) OR VARTYPE(THIS.this_oBusinessObject) <> "O"
35:                 MsgErro("Erro ao criar pagBO.", "Erro")
36:             ELSE
37:                 THIS.ConfigurarPageFrame()
38:                 THIS.CarregarLista()
39:                 loc_lResultado = .T.
40:             ENDIF
41:         CATCH TO loc_oErro
42:             MsgErro("Erro em Formpag.InicializarForm: " + loc_oErro.Message, "Erro")
43:         ENDTRY
44: 
45:         RETURN loc_lResultado
46:     ENDPROC
47: 
48:     *==========================================================================
49:     PROTECTED PROCEDURE ConfigurarPageFrame()
50:     *==========================================================================
51:         LOCAL loc_oPgf
52:         TRY
53:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
54:             loc_oPgf = THIS.pgf_4c_Paginas
55:             WITH loc_oPgf
56:                 .Top       = -29
57:                 .Left      = 0
58:                 .Width     = THIS.Width
59:                 .Height    = THIS.Height + 29
60:                 .Tabs      = .F.
61:                 .PageCount = 2
62:                 .Visible   = .T.
63:             ENDWITH
64: 
65:             THIS.ConfigurarPaginaLista()
66:             THIS.ConfigurarPaginaDados()
67: 
68:             loc_oPgf.ActivePage = 1
69:         CATCH TO loc_oErro
70:             MsgErro("Erro em Formpag.ConfigurarPageFrame: " + loc_oErro.Message, "Erro")
71:         ENDTRY
72:     ENDPROC
73: 
74:     *==========================================================================
75:     PROTECTED PROCEDURE ConfigurarPaginaLista()
76:     *==========================================================================
77:         LOCAL loc_oPage, loc_oCnt, loc_oCntSaida, loc_oCntEsp, loc_oGrd, loc_oCol
78:         TRY
79:             loc_oPage = THIS.pgf_4c_Paginas.Pages(1)
80:             loc_oPage.Caption = "Lista"
81: 
82:             && --- Container de botoes CRUD padrao ---
83:             loc_oPage.AddObject("cnt_4c_Botoes", "Container")
84:             loc_oCnt = loc_oPage.cnt_4c_Botoes
85:             WITH loc_oCnt
86:                 .Top       = 29
87:                 .Left      = 542
88:                 .Width     = 370
89:                 .Height    = 85
90:                 .BackStyle = 0
91:                 .Visible   = .T.
92:             ENDWITH
93: 
94:             loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
95:             WITH loc_oCnt.cmd_4c_Incluir
96:                 .Caption = "Incluir"
97:                 .Top     = 5
98:                 .Left    = 5
99:                 .Width   = 75
100:                 .Height  = 75
101:                 .Visible = .T.
102:             ENDWITH
103:             BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
104: 
105:             loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
106:             WITH loc_oCnt.cmd_4c_Alterar
107:                 .Caption = "Alterar"
108:                 .Top     = 5
109:                 .Left    = 85
110:                 .Width   = 75
111:                 .Height  = 75
112:                 .Visible = .T.
113:             ENDWITH
114:             BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
115: 
116:             loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
117:             WITH loc_oCnt.cmd_4c_Visualizar
118:                 .Caption = "Visualizar"
119:                 .Top     = 5
120:                 .Left    = 165
121:                 .Width   = 75
122:                 .Height  = 75
123:                 .Visible = .T.
124:             ENDWITH
125:             BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
126: 
127:             loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
128:             WITH loc_oCnt.cmd_4c_Excluir
129:                 .Caption = "Excluir"
130:                 .Top     = 5
131:                 .Left    = 245
132:                 .Width   = 75
133:                 .Height  = 75
134:                 .Visible = .T.
135:             ENDWITH
136:             BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
137: 
138:             loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
139:             WITH loc_oCnt.cmd_4c_Buscar
140:                 .Caption = "Buscar"
141:                 .Top     = 5
142:                 .Left    = 325
143:                 .Width   = 75
144:                 .Height  = 75
145:                 .Visible = .T.
146:             ENDWITH
147:             BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
148: 
149:             && --- Container botoes especiais ---
150:             loc_oPage.AddObject("cnt_4c_BotoesEspeciais", "Container")
151:             loc_oCntEsp = loc_oPage.cnt_4c_BotoesEspeciais
152:             WITH loc_oCntEsp
153:                 .Top       = 79
154:                 .Left      = 0
155:                 .Width     = 780
156:                 .Height    = 60
157:                 .BackStyle = 0
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             loc_oCntEsp.AddObject("cmd_4c_BtnExpXML", "CommandButton")
162:             WITH loc_oCntEsp.cmd_4c_BtnExpXML
163:                 .Caption = "Exportar"
164:                 .Top     = 5
165:                 .Left    = 24
166:                 .Width   = 120
167:                 .Height  = 40
168:                 .Visible = .T.
169:             ENDWITH
170:             BINDEVENT(loc_oCntEsp.cmd_4c_BtnExpXML, "Click", THIS, "BtnExportarClick")
171: 
172:             loc_oCntEsp.AddObject("cmd_4c_BtnImpXML", "CommandButton")
173:             WITH loc_oCntEsp.cmd_4c_BtnImpXML
174:                 .Caption = "Importar"
175:                 .Top     = 5
176:                 .Left    = 144
177:                 .Width   = 120
178:                 .Height  = 40
179:                 .Visible = .T.
180:             ENDWITH
181:             BINDEVENT(loc_oCntEsp.cmd_4c_BtnImpXML, "Click", THIS, "BtnImportarClick")
182: 
183:             loc_oCntEsp.AddObject("cmd_4c_CmdCopia", "CommandButton")
184:             WITH loc_oCntEsp.cmd_4c_CmdCopia
185:                 .Caption = "Copiar"
186:                 .Top     = 5
187:                 .Left    = 264
188:                 .Width   = 120
189:                 .Height  = 40
190:                 .Visible = .T.
191:             ENDWITH
192:             BINDEVENT(loc_oCntEsp.cmd_4c_CmdCopia, "Click", THIS, "BtnCopiarClick")
193: 
194:             loc_oCntEsp.AddObject("cmd_4c_CmdfpMin", "CommandButton")
195:             WITH loc_oCntEsp.cmd_4c_CmdfpMin
196:                 .Caption = "M" + CHR(237) + "nimo"
197:                 .Top     = 5
198:                 .Left    = 384
199:                 .Width   = 120
200:                 .Height  = 40
201:                 .Visible = .T.
202:             ENDWITH
203:             BINDEVENT(loc_oCntEsp.cmd_4c_CmdfpMin, "Click", THIS, "BtnMinimoClick")
204: 
205:             loc_oCntEsp.AddObject("cmd_4c_Cmdfpdpar", "CommandButton")
206:             WITH loc_oCntEsp.cmd_4c_Cmdfpdpar
207:                 .Caption = "Desconto"
208:                 .Top     = 5
209:                 .Left    = 504
210:                 .Width   = 120
211:                 .Height  = 40
212:                 .Visible = .T.
213:             ENDWITH
214:             BINDEVENT(loc_oCntEsp.cmd_4c_Cmdfpdpar, "Click", THIS, "BtnDescontoClick")
215: 
216:             loc_oCntEsp.AddObject("cmd_4c_Bot_BIN", "CommandButton")
217:             WITH loc_oCntEsp.cmd_4c_Bot_BIN
218:                 .Caption = "BIN"
219:                 .Top     = 5
220:                 .Left    = 624
221:                 .Width   = 120
222:                 .Height  = 40
223:                 .Visible = .T.
224:             ENDWITH
225:             BINDEVENT(loc_oCntEsp.cmd_4c_Bot_BIN, "Click", THIS, "BtnBINClick")
226: 
227:             && --- Container saida canonico ---
228:             loc_oPage.AddObject("cnt_4c_Saida", "Container")
229:             loc_oCntSaida = loc_oPage.cnt_4c_Saida
230:             WITH loc_oCntSaida
231:                 .Top       = 29
232:                 .Left      = 917
233:                 .Width     = 90
234:                 .Height    = 85
235:                 .BackStyle = 0
236:                 .Visible   = .T.
237:             ENDWITH
238: 
239:             loc_oCntSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
240:             WITH loc_oCntSaida.cmd_4c_Encerrar
241:                 .Caption = "Encerrar"
242:                 .Top     = 5
243:                 .Left    = 5
244:                 .Width   = 75
245:                 .Height  = 75
246:                 .Visible = .T.
247:             ENDWITH
248:             BINDEVENT(loc_oCntSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
249: 
250:             && --- Grid ---
251:             loc_oPage.AddObject("grd_4c_Lista", "Grid")
252:             loc_oGrd = loc_oPage.grd_4c_Lista
253:             WITH loc_oGrd
254:                 .Top          = 130
255:                 .Left         = 26
256:                 .Width        = 890
257:                 .Height       = 490
258:                 .RecordSource = "cursor_4c_Dados"
259:                 .ReadOnly     = .T.
260:                 .ColumnCount  = 5
261:                 .HeaderHeight = 22
262:                 .RowHeight    = 18
263:                 .GridLines    = 1
264:                 .Visible      = .T.
265:             ENDWITH
266: 
267:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
268:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.fpags"
269:             loc_oGrd.Column1.Width           = 100
270: 
271:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
272:             loc_oGrd.Column2.ControlSource   = "cursor_4c_Dados.descrs"
273:             loc_oGrd.Column2.Width           = 250
274: 
275:             loc_oGrd.Column3.Header1.Caption = "Moeda"
276:             loc_oGrd.Column3.ControlSource   = "cursor_4c_Dados.moefpgs"
277:             loc_oGrd.Column3.Width           = 60
278: 
279:             loc_oGrd.Column4.Header1.Caption = "Dias"
280:             loc_oGrd.Column4.ControlSource   = "cursor_4c_Dados.dias"
281:             loc_oGrd.Column4.Width           = 50
282: 
283:             loc_oGrd.Column5.Header1.Caption = "T.Venc"
284:             loc_oGrd.Column5.ControlSource   = "cursor_4c_Dados.tvens"
285:             loc_oGrd.Column5.Width           = 60
286: 
287:         CATCH TO loc_oErro
288:             MsgErro("Erro em Formpag.ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
289:         ENDTRY
290:     ENDPROC
291: 
292:     *==========================================================================
293:     PROTECTED PROCEDURE ConfigurarPaginaDados()
294:     *==========================================================================
295:         LOCAL loc_oPage, loc_oCntSalva, loc_oCntSaida2, loc_oPgf2
296:         TRY
297:             loc_oPage = THIS.pgf_4c_Paginas.Pages(2)
298:             loc_oPage.Caption = "Dados"
299: 
300:             && --- Cabecalho: Descricao ---
301:             loc_oPage.AddObject("lbl_4c_Descrs", "Label")
302:             WITH loc_oPage.lbl_4c_Descrs
303:                 .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
304:                 .Top      = 20
305:                 .Left     = 10
306:                 .AutoSize = .T.
307:                 .Visible  = .T.
308:             ENDWITH
309: 
310:             loc_oPage.AddObject("txt_4c_Descrs", "TextBox")
311:             WITH loc_oPage.txt_4c_Descrs
312:                 .Top       = 16
313:                 .Left      = 112
314:                 .Width     = 220
315:                 .Height    = 21
316:                 .MaxLength = 30
317:                 .Visible   = .T.
318:             ENDWITH
319: 
320:             && --- Cabecalho: Titulo ---
321:             loc_oPage.AddObject("lbl_4c_TitFPags", "Label")
322:             WITH loc_oPage.lbl_4c_TitFPags
323:                 .Caption  = "T" + CHR(237) + "tulo :"
324:                 .Top      = 20
325:                 .Left     = 338
326:                 .AutoSize = .T.
327:                 .Visible  = .T.
328:             ENDWITH
329: 
330:             loc_oPage.AddObject("txt_4c_TitFPags", "TextBox")
331:             WITH loc_oPage.txt_4c_TitFPags
332:                 .Top       = 16
333:                 .Left      = 380

*-- Linhas 474 a 518:
474:                 .Visible   = .T.
475:             ENDWITH
476: 
477:             && --- OptionGroup Conta Mov ---
478:             loc_oPage.AddObject("obj_4c_Opt_ContaMov", "OptionGroup")
479:             WITH loc_oPage.obj_4c_Opt_ContaMov
480:                 .Top         = 90
481:                 .Left        = 479
482:                 .Width       = 283
483:                 .Height      = 23
484:                 .ButtonCount = 4
485:                 .Visible     = .T.
486:                 WITH .Buttons(1)
487:                     .Caption = "D"
488:                     .Left = 0
489:                     .Top = 2
490:                     .AutoSize = .T.
491:                     .ForeColor = RGB(0,0,0)
492:                     .Themes = .F.
493:                 ENDWITH
494:                 WITH .Buttons(2)
495:                     .Caption = "C"
496:                     .Left = 71
497:                     .Top = 2
498:                     .AutoSize = .T.
499:                     .ForeColor = RGB(0,0,0)
500:                     .Themes = .F.
501:                 ENDWITH
502:                 WITH .Buttons(3)
503:                     .Caption = "T"
504:                     .Left = 142
505:                     .Top = 2
506:                     .AutoSize = .T.
507:                     .ForeColor = RGB(0,0,0)
508:                     .Themes = .F.
509:                 ENDWITH
510:                 WITH .Buttons(4)
511:                     .Caption = "O"
512:                     .Left = 213
513:                     .Top = 2
514:                     .AutoSize = .T.
515:                     .ForeColor = RGB(0,0,0)
516:                     .Themes = .F.
517:                 ENDWITH
518:             ENDWITH

*-- Linhas 536 a 638:
536:                 .Height  = 75
537:                 .Visible = .T.
538:             ENDWITH
539:             BINDEVENT(loc_oPage.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
540: 
541:             loc_oPage.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
542:             WITH loc_oPage.cnt_4c_Salva.cmd_4c_Cancelar
543:                 .Caption = "Encerrar"
544:                 .Top     = 5
545:                 .Left    = 85
546:                 .Width   = 75
547:                 .Height  = 75
548:                 .Visible = .T.
549:             ENDWITH
550:             BINDEVENT(loc_oPage.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
551: 
552:             && --- Container saida pagina Dados ---
553:             loc_oPage.AddObject("cnt_4c_Saida2", "Container")
554:             loc_oCntSaida2 = loc_oPage.cnt_4c_Saida2
555:             WITH loc_oCntSaida2
556:                 .Top    = 29
557:                 .Left   = 917
558:                 .Width  = 90
559:                 .Height = 85
560:             ENDWITH
561: 
562:             loc_oCntSaida2.AddObject("cmd_4c_Encerrar2", "CommandButton")
563:             WITH loc_oCntSaida2.cmd_4c_Encerrar2
564:                 .Caption = "Encerrar"
565:                 .Top     = 5
566:                 .Left    = 5
567:                 .Width   = 75
568:                 .Height  = 75
569:                 .Visible = .T.
570:             ENDWITH
571:             BINDEVENT(loc_oCntSaida2.cmd_4c_Encerrar2, "Click", THIS, "BtnEncerrarClick")
572: 
573:             && --- Inner PageFrame: pgf_4c_Dados ---
574:             loc_oPage.AddObject("pgf_4c_Dados", "PageFrame")
575:             loc_oPgf2 = loc_oPage.pgf_4c_Dados
576:             WITH loc_oPgf2
577:                 .Top       = 120
578:                 .Left      = 0
579:                 .Width     = THIS.Width
580:                 .Height    = THIS.Height - 120 + 29
581:                 .Tabs      = .T.
582:                 .PageCount = 2
583:                 .Visible   = .T.
584:             ENDWITH
585: 
586:             loc_oPgf2.Pages(1).Caption = "Geral"
587:             loc_oPgf2.Pages(2).Caption = "Cart" + CHR(227) + "o/TEF"
588: 
589:             THIS.CriarPaginaGeral(loc_oPgf2.Pages(1))
590:             THIS.CriarPaginaCartaoTEF(loc_oPgf2.Pages(2))
591: 
592:         CATCH TO loc_oErro
593:             MsgErro("Erro em Formpag.ConfigurarPaginaDados: " + loc_oErro.Message, "Erro")
594:         ENDTRY
595:     ENDPROC
596: 
597:     *==========================================================================
598:     PROTECTED PROCEDURE CriarPaginaGeral(par_oPage)
599:     *==========================================================================
600:         LOCAL loc_oPage
601:         loc_oPage = par_oPage
602:         TRY
603:             && --- Linha 1: Entrada, Dias, Parcelas, Tipo Uso ---
604:             loc_oPage.AddObject("lbl_g_Entrada", "Label")
605:             WITH loc_oPage.lbl_g_Entrada
606:                 .Caption  = "Entrada :"
607:                 .Top      = 8
608:                 .Left     = 93
609:                 .AutoSize = .T.
610:                 .Visible  = .T.
611:             ENDWITH
612:             loc_oPage.AddObject("txt_4c_Entrada", "TextBox")
613:             WITH loc_oPage.txt_4c_Entrada
614:                 .Top       = 4
615:                 .Left      = 144
616:                 .Width     = 31
617:                 .Height    = 21
618:                 .MaxLength = 3
619:                 .Visible   = .T.
620:             ENDWITH
621: 
622:             loc_oPage.AddObject("lbl_g_InterDias", "Label")
623:             WITH loc_oPage.lbl_g_InterDias
624:                 .Caption  = "Intervalo de Dias :"
625:                 .Top      = 34
626:                 .Left     = 49
627:                 .AutoSize = .T.
628:                 .Visible  = .T.
629:             ENDWITH
630:             loc_oPage.AddObject("txt_4c_Dias", "TextBox")
631:             WITH loc_oPage.txt_4c_Dias
632:                 .Top       = 30
633:                 .Left      = 144
634:                 .Width     = 31
635:                 .Height    = 21
636:                 .MaxLength = 3
637:                 .Visible   = .T.
638:             ENDWITH

*-- Linhas 1093 a 1996:
1093:                 .Visible   = .T.
1094:             ENDWITH
1095: 
1096:             && --- OptionGroups coluna direita (479) ---
1097:             loc_oPage.AddObject("lbl_g_ValPend", "Label")
1098:             WITH loc_oPage.lbl_g_ValPend
1099:                 .Caption  = "Valor Pendente :"
1100:                 .Top      = 8
1101:                 .Left     = 393
1102:                 .AutoSize = .T.
1103:                 .Visible  = .T.
1104:             ENDWITH
1105:             loc_oPage.AddObject("obj_4c_Op_valpend", "OptionGroup")
1106:             WITH loc_oPage.obj_4c_Op_valpend
1107:                 .Top         = 4
1108:                 .Left        = 479
1109:                 .Width       = 97
1110:                 .Height      = 23
1111:                 .ButtonCount = 2
1112:                 .Visible     = .T.
1113:                 WITH .Buttons(1)
1114:                     .Caption = "S"
1115:                     .Left = 0
1116:                     .Top = 2
1117:                     .AutoSize = .T.
1118:                     .ForeColor = RGB(0,0,0)
1119:                     .Themes = .F.
1120:                 ENDWITH
1121:                 WITH .Buttons(2)
1122:                     .Caption = "N"
1123:                     .Left = 50
1124:                     .Top = 2
1125:                     .AutoSize = .T.
1126:                     .ForeColor = RGB(0,0,0)
1127:                     .Themes = .F.
1128:                 ENDWITH
1129:             ENDWITH
1130: 
1131:             loc_oPage.AddObject("lbl_g_BxComis", "Label")
1132:             WITH loc_oPage.lbl_g_BxComis
1133:                 .Caption  = "Credita Comiss" + CHR(227) + "o :"
1134:                 .Top      = 34
1135:                 .Left     = 383
1136:                 .AutoSize = .T.
1137:                 .Visible  = .T.
1138:             ENDWITH
1139:             loc_oPage.AddObject("obj_4c_Op_BxComis", "OptionGroup")
1140:             WITH loc_oPage.obj_4c_Op_BxComis
1141:                 .Top         = 30
1142:                 .Left        = 479
1143:                 .Width       = 97
1144:                 .Height      = 23
1145:                 .ButtonCount = 2
1146:                 .Visible     = .T.
1147:                 WITH .Buttons(1)
1148:                     .Caption = "S"
1149:                     .Left = 0
1150:                     .Top = 2
1151:                     .AutoSize = .T.
1152:                     .ForeColor = RGB(0,0,0)
1153:                     .Themes = .F.
1154:                 ENDWITH
1155:                 WITH .Buttons(2)
1156:                     .Caption = "N"
1157:                     .Left = 50
1158:                     .Top = 2
1159:                     .AutoSize = .T.
1160:                     .ForeColor = RGB(0,0,0)
1161:                     .Themes = .F.
1162:                 ENDWITH
1163:             ENDWITH
1164: 
1165:             loc_oPage.AddObject("lbl_g_Emichqs", "Label")
1166:             WITH loc_oPage.lbl_g_Emichqs
1167:                 .Caption  = "Emite Cheque :"
1168:                 .Top      = 59
1169:                 .Left     = 400
1170:                 .AutoSize = .T.
1171:                 .Visible  = .T.
1172:             ENDWITH
1173:             loc_oPage.AddObject("obj_4c_Op_Emichqs", "OptionGroup")
1174:             WITH loc_oPage.obj_4c_Op_Emichqs
1175:                 .Top         = 55
1176:                 .Left        = 479
1177:                 .Width       = 97
1178:                 .Height      = 23
1179:                 .ButtonCount = 2
1180:                 .Visible     = .T.
1181:                 WITH .Buttons(1)
1182:                     .Caption = "S"
1183:                     .Left = 0
1184:                     .Top = 2
1185:                     .AutoSize = .T.
1186:                     .ForeColor = RGB(0,0,0)
1187:                     .Themes = .F.
1188:                 ENDWITH
1189:                 WITH .Buttons(2)
1190:                     .Caption = "N"
1191:                     .Left = 50
1192:                     .Top = 2
1193:                     .AutoSize = .T.
1194:                     .ForeColor = RGB(0,0,0)
1195:                     .Themes = .F.
1196:                 ENDWITH
1197:             ENDWITH
1198: 
1199:             loc_oPage.AddObject("lbl_g_ImpChqs", "Label")
1200:             WITH loc_oPage.lbl_g_ImpChqs
1201:                 .Caption  = "Imprime Cheque :"
1202:                 .Top      = 84
1203:                 .Left     = 388
1204:                 .AutoSize = .T.
1205:                 .Visible  = .T.
1206:             ENDWITH
1207:             loc_oPage.AddObject("obj_4c_Op_ImpChqs", "OptionGroup")
1208:             WITH loc_oPage.obj_4c_Op_ImpChqs
1209:                 .Top         = 80
1210:                 .Left        = 479
1211:                 .Width       = 97
1212:                 .Height      = 23
1213:                 .ButtonCount = 2
1214:                 .Visible     = .T.
1215:                 WITH .Buttons(1)
1216:                     .Caption = "S"
1217:                     .Left = 0
1218:                     .Top = 2
1219:                     .AutoSize = .T.
1220:                     .ForeColor = RGB(0,0,0)
1221:                     .Themes = .F.
1222:                 ENDWITH
1223:                 WITH .Buttons(2)
1224:                     .Caption = "N"
1225:                     .Left = 50
1226:                     .Top = 2
1227:                     .AutoSize = .T.
1228:                     .ForeColor = RGB(0,0,0)
1229:                     .Themes = .F.
1230:                 ENDWITH
1231:             ENDWITH
1232: 
1233:             loc_oPage.AddObject("lbl_g_OptFechm", "Label")
1234:             WITH loc_oPage.lbl_g_OptFechm
1235:                 .Caption  = "Total Fechamento :"
1236:                 .Top      = 109
1237:                 .Left     = 380
1238:                 .AutoSize = .T.
1239:                 .Visible  = .T.
1240:             ENDWITH
1241:             loc_oPage.AddObject("obj_4c_OptFechm", "OptionGroup")
1242:             WITH loc_oPage.obj_4c_OptFechm
1243:                 .Top         = 105
1244:                 .Left        = 479
1245:                 .Width       = 97
1246:                 .Height      = 23
1247:                 .ButtonCount = 2
1248:                 .Visible     = .T.
1249:                 WITH .Buttons(1)
1250:                     .Caption = "S"
1251:                     .Left = 0
1252:                     .Top = 2
1253:                     .AutoSize = .T.
1254:                     .ForeColor = RGB(0,0,0)
1255:                     .Themes = .F.
1256:                 ENDWITH
1257:                 WITH .Buttons(2)
1258:                     .Caption = "N"
1259:                     .Left = 50
1260:                     .Top = 2
1261:                     .AutoSize = .T.
1262:                     .ForeColor = RGB(0,0,0)
1263:                     .Themes = .F.
1264:                 ENDWITH
1265:             ENDWITH
1266: 
1267:             loc_oPage.AddObject("lbl_g_Optg7", "Label")
1268:             WITH loc_oPage.lbl_g_Optg7
1269:                 .Caption  = "M" + CHR(234) + "s Fechado :"
1270:                 .Top      = 134
1271:                 .Left     = 403
1272:                 .AutoSize = .T.
1273:                 .Visible  = .T.
1274:             ENDWITH
1275:             loc_oPage.AddObject("obj_4c_Optiongroup7", "OptionGroup")
1276:             WITH loc_oPage.obj_4c_Optiongroup7
1277:                 .Top         = 130
1278:                 .Left        = 479
1279:                 .Width       = 97
1280:                 .Height      = 23
1281:                 .ButtonCount = 2
1282:                 .Visible     = .T.
1283:                 WITH .Buttons(1)
1284:                     .Caption = "S"
1285:                     .Left = 0
1286:                     .Top = 2
1287:                     .AutoSize = .T.
1288:                     .ForeColor = RGB(0,0,0)
1289:                     .Themes = .F.
1290:                 ENDWITH
1291:                 WITH .Buttons(2)
1292:                     .Caption = "N"
1293:                     .Left = 50
1294:                     .Top = 2
1295:                     .AutoSize = .T.
1296:                     .ForeColor = RGB(0,0,0)
1297:                     .Themes = .F.
1298:                 ENDWITH
1299:             ENDWITH
1300: 
1301:             loc_oPage.AddObject("lbl_g_Optg10", "Label")
1302:             WITH loc_oPage.lbl_g_Optg10
1303:                 .Caption  = "Agente Cobrador :"
1304:                 .Top      = 159
1305:                 .Left     = 383
1306:                 .AutoSize = .T.
1307:                 .Visible  = .T.
1308:             ENDWITH
1309:             loc_oPage.AddObject("obj_4c_Optiongroup10", "OptionGroup")
1310:             WITH loc_oPage.obj_4c_Optiongroup10
1311:                 .Top         = 155
1312:                 .Left        = 479
1313:                 .Width       = 97
1314:                 .Height      = 23
1315:                 .ButtonCount = 2
1316:                 .Visible     = .T.
1317:                 WITH .Buttons(1)
1318:                     .Caption = "S"
1319:                     .Left = 0
1320:                     .Top = 2
1321:                     .AutoSize = .T.
1322:                     .ForeColor = RGB(0,0,0)
1323:                     .Themes = .F.
1324:                 ENDWITH
1325:                 WITH .Buttons(2)
1326:                     .Caption = "N"
1327:                     .Left = 50
1328:                     .Top = 2
1329:                     .AutoSize = .T.
1330:                     .ForeColor = RGB(0,0,0)
1331:                     .Themes = .F.
1332:                 ENDWITH
1333:             ENDWITH
1334: 
1335:             loc_oPage.AddObject("lbl_g_Trocos", "Label")
1336:             WITH loc_oPage.lbl_g_Trocos
1337:                 .Caption  = "Troco :"
1338:                 .Top      = 184
1339:                 .Left     = 439
1340:                 .AutoSize = .T.
1341:                 .Visible  = .T.
1342:             ENDWITH
1343:             loc_oPage.AddObject("obj_4c_OptTrocos", "OptionGroup")
1344:             WITH loc_oPage.obj_4c_OptTrocos
1345:                 .Top         = 180
1346:                 .Left        = 479
1347:                 .Width       = 97
1348:                 .Height      = 23
1349:                 .ButtonCount = 2
1350:                 .Visible     = .T.
1351:                 WITH .Buttons(1)
1352:                     .Caption = "S"
1353:                     .Left = 0
1354:                     .Top = 2
1355:                     .AutoSize = .T.
1356:                     .ForeColor = RGB(0,0,0)
1357:                     .Themes = .F.
1358:                 ENDWITH
1359:                 WITH .Buttons(2)
1360:                     .Caption = "N"
1361:                     .Left = 50
1362:                     .Top = 2
1363:                     .AutoSize = .T.
1364:                     .ForeColor = RGB(0,0,0)
1365:                     .Themes = .F.
1366:                 ENDWITH
1367:             ENDWITH
1368: 
1369:             loc_oPage.AddObject("lbl_g_Optg5", "Label")
1370:             WITH loc_oPage.lbl_g_Optg5
1371:                 .Caption  = "Baixa Comiss" + CHR(227) + "o no Chq :"
1372:                 .Top      = 209
1373:                 .Left     = 355
1374:                 .AutoSize = .T.
1375:                 .Visible  = .T.
1376:             ENDWITH
1377:             loc_oPage.AddObject("obj_4c_Optiongroup5", "OptionGroup")
1378:             WITH loc_oPage.obj_4c_Optiongroup5
1379:                 .Top         = 205
1380:                 .Left        = 479
1381:                 .Width       = 97
1382:                 .Height      = 23
1383:                 .ButtonCount = 2
1384:                 .Visible     = .T.
1385:                 WITH .Buttons(1)
1386:                     .Caption = "S"
1387:                     .Left = 0
1388:                     .Top = 2
1389:                     .AutoSize = .T.
1390:                     .ForeColor = RGB(0,0,0)
1391:                     .Themes = .F.
1392:                 ENDWITH
1393:                 WITH .Buttons(2)
1394:                     .Caption = "N"
1395:                     .Left = 50
1396:                     .Top = 2
1397:                     .AutoSize = .T.
1398:                     .ForeColor = RGB(0,0,0)
1399:                     .Themes = .F.
1400:                 ENDWITH
1401:             ENDWITH
1402: 
1403:             loc_oPage.AddObject("lbl_g_Optg2", "Label")
1404:             WITH loc_oPage.lbl_g_Optg2
1405:                 .Caption  = "Baixa Valor :"
1406:                 .Top      = 234
1407:                 .Left     = 413
1408:                 .AutoSize = .T.
1409:                 .Visible  = .T.
1410:             ENDWITH
1411:             loc_oPage.AddObject("obj_4c_Optiongroup2", "OptionGroup")
1412:             WITH loc_oPage.obj_4c_Optiongroup2
1413:                 .Top         = 230
1414:                 .Left        = 479
1415:                 .Width       = 97
1416:                 .Height      = 23
1417:                 .ButtonCount = 2
1418:                 .Visible     = .T.
1419:                 WITH .Buttons(1)
1420:                     .Caption = "S"
1421:                     .Left = 0
1422:                     .Top = 2
1423:                     .AutoSize = .T.
1424:                     .ForeColor = RGB(0,0,0)
1425:                     .Themes = .F.
1426:                 ENDWITH
1427:                 WITH .Buttons(2)
1428:                     .Caption = "N"
1429:                     .Left = 50
1430:                     .Top = 2
1431:                     .AutoSize = .T.
1432:                     .ForeColor = RGB(0,0,0)
1433:                     .Themes = .F.
1434:                 ENDWITH
1435:             ENDWITH
1436: 
1437:             loc_oPage.AddObject("lbl_g_Optg8", "Label")
1438:             WITH loc_oPage.lbl_g_Optg8
1439:                 .Caption  = "Acumula :"
1440:                 .Top      = 259
1441:                 .Left     = 426
1442:                 .AutoSize = .T.
1443:                 .Visible  = .T.
1444:             ENDWITH
1445:             loc_oPage.AddObject("obj_4c_Optiongroup8", "OptionGroup")
1446:             WITH loc_oPage.obj_4c_Optiongroup8
1447:                 .Top         = 255
1448:                 .Left        = 479
1449:                 .Width       = 97
1450:                 .Height      = 23
1451:                 .ButtonCount = 2
1452:                 .Visible     = .T.
1453:                 WITH .Buttons(1)
1454:                     .Caption = "S"
1455:                     .Left = 0
1456:                     .Top = 2
1457:                     .AutoSize = .T.
1458:                     .ForeColor = RGB(0,0,0)
1459:                     .Themes = .F.
1460:                 ENDWITH
1461:                 WITH .Buttons(2)
1462:                     .Caption = "N"
1463:                     .Left = 50
1464:                     .Top = 2
1465:                     .AutoSize = .T.
1466:                     .ForeColor = RGB(0,0,0)
1467:                     .Themes = .F.
1468:                 ENDWITH
1469:             ENDWITH
1470: 
1471:             loc_oPage.AddObject("lbl_g_Optg3", "Label")
1472:             WITH loc_oPage.lbl_g_Optg3
1473:                 .Caption  = "Itens Obrigat" + CHR(243) + "rios :"
1474:                 .Top      = 284
1475:                 .Left     = 367
1476:                 .AutoSize = .T.
1477:                 .Visible  = .T.
1478:             ENDWITH
1479:             loc_oPage.AddObject("obj_4c_Optiongroup3", "OptionGroup")
1480:             WITH loc_oPage.obj_4c_Optiongroup3
1481:                 .Top         = 435
1482:                 .Left        = 670
1483:                 .Width       = 97
1484:                 .Height      = 23
1485:                 .ButtonCount = 2
1486:                 .Visible     = .T.
1487:                 WITH .Buttons(1)
1488:                     .Caption = "S"
1489:                     .Left = 0
1490:                     .Top = 2
1491:                     .AutoSize = .T.
1492:                     .ForeColor = RGB(0,0,0)
1493:                     .Themes = .F.
1494:                 ENDWITH
1495:                 WITH .Buttons(2)
1496:                     .Caption = "N"
1497:                     .Left = 50
1498:                     .Top = 2
1499:                     .AutoSize = .T.
1500:                     .ForeColor = RGB(0,0,0)
1501:                     .Themes = .F.
1502:                 ENDWITH
1503:             ENDWITH
1504: 
1505:             loc_oPage.AddObject("lbl_g_Optg4", "Label")
1506:             WITH loc_oPage.lbl_g_Optg4
1507:                 .Caption  = "Aprova" + CHR(231) + CHR(227) + "o :"
1508:                 .Top      = 309
1509:                 .Left     = 414
1510:                 .AutoSize = .T.
1511:                 .Visible  = .T.
1512:             ENDWITH
1513:             loc_oPage.AddObject("obj_4c_Optiongroup4", "OptionGroup")
1514:             WITH loc_oPage.obj_4c_Optiongroup4
1515:                 .Top         = 411
1516:                 .Left        = 670
1517:                 .Width       = 97
1518:                 .Height      = 23
1519:                 .ButtonCount = 2
1520:                 .Visible     = .T.
1521:                 WITH .Buttons(1)
1522:                     .Caption = "S"
1523:                     .Left = 0
1524:                     .Top = 2
1525:                     .AutoSize = .T.
1526:                     .ForeColor = RGB(0,0,0)
1527:                     .Themes = .F.
1528:                 ENDWITH
1529:                 WITH .Buttons(2)
1530:                     .Caption = "N"
1531:                     .Left = 50
1532:                     .Top = 2
1533:                     .AutoSize = .T.
1534:                     .ForeColor = RGB(0,0,0)
1535:                     .Themes = .F.
1536:                 ENDWITH
1537:             ENDWITH
1538: 
1539:             loc_oPage.AddObject("lbl_g_Optg12", "Label")
1540:             WITH loc_oPage.lbl_g_Optg12
1541:                 .Caption  = "Detalha Fec. Caixa :"
1542:                 .Top      = 334
1543:                 .Left     = 375
1544:                 .AutoSize = .T.
1545:                 .Visible  = .T.
1546:             ENDWITH
1547:             loc_oPage.AddObject("obj_4c_Optiongroup12", "OptionGroup")
1548:             WITH loc_oPage.obj_4c_Optiongroup12
1549:                 .Top         = 403
1550:                 .Left        = 170
1551:                 .Width       = 97
1552:                 .Height      = 23
1553:                 .ButtonCount = 2
1554:                 .Visible     = .T.
1555:                 WITH .Buttons(1)
1556:                     .Caption = "S"
1557:                     .Left = 0
1558:                     .Top = 2
1559:                     .AutoSize = .T.
1560:                     .ForeColor = RGB(0,0,0)
1561:                     .Themes = .F.
1562:                 ENDWITH
1563:                 WITH .Buttons(2)
1564:                     .Caption = "N"
1565:                     .Left = 50
1566:                     .Top = 2
1567:                     .AutoSize = .T.
1568:                     .ForeColor = RGB(0,0,0)
1569:                     .Themes = .F.
1570:                 ENDWITH
1571:             ENDWITH
1572: 
1573:             loc_oPage.AddObject("lbl_g_ImpBols", "Label")
1574:             WITH loc_oPage.lbl_g_ImpBols
1575:                 .Caption  = "Imprime Boleto Banc" + CHR(225) + "rio :"
1576:                 .Top      = 360
1577:                 .Left     = 351
1578:                 .AutoSize = .T.
1579:                 .Visible  = .T.
1580:             ENDWITH
1581:             loc_oPage.AddObject("obj_4c_OptImpBols", "OptionGroup")
1582:             WITH loc_oPage.obj_4c_OptImpBols
1583:                 .Top         = 356
1584:                 .Left        = 479
1585:                 .Width       = 97
1586:                 .Height      = 23
1587:                 .ButtonCount = 2
1588:                 .Visible     = .T.
1589:                 WITH .Buttons(1)
1590:                     .Caption = "S"
1591:                     .Left = 0
1592:                     .Top = 2
1593:                     .AutoSize = .T.
1594:                     .ForeColor = RGB(0,0,0)
1595:                     .Themes = .F.
1596:                 ENDWITH
1597:                 WITH .Buttons(2)
1598:                     .Caption = "N"
1599:                     .Left = 50
1600:                     .Top = 2
1601:                     .AutoSize = .T.
1602:                     .ForeColor = RGB(0,0,0)
1603:                     .Themes = .F.
1604:                 ENDWITH
1605:             ENDWITH
1606: 
1607:             loc_oPage.AddObject("lbl_g_ImpDups", "Label")
1608:             WITH loc_oPage.lbl_g_ImpDups
1609:                 .Caption  = "Imprime Duplicata :"
1610:                 .Top      = 385
1611:                 .Left     = 381
1612:                 .AutoSize = .T.
1613:                 .Visible  = .T.
1614:             ENDWITH
1615:             loc_oPage.AddObject("obj_4c_OptImpDups", "OptionGroup")
1616:             WITH loc_oPage.obj_4c_OptImpDups
1617:                 .Top         = 381
1618:                 .Left        = 479
1619:                 .Width       = 97
1620:                 .Height      = 23
1621:                 .ButtonCount = 2
1622:                 .Visible     = .T.
1623:                 WITH .Buttons(1)
1624:                     .Caption = "S"
1625:                     .Left = 0
1626:                     .Top = 2
1627:                     .AutoSize = .T.
1628:                     .ForeColor = RGB(0,0,0)
1629:                     .Themes = .F.
1630:                 ENDWITH
1631:                 WITH .Buttons(2)
1632:                     .Caption = "N"
1633:                     .Left = 50
1634:                     .Top = 2
1635:                     .AutoSize = .T.
1636:                     .ForeColor = RGB(0,0,0)
1637:                     .Themes = .F.
1638:                 ENDWITH
1639:             ENDWITH
1640: 
1641:             loc_oPage.AddObject("lbl_g_Optg13", "Label")
1642:             WITH loc_oPage.lbl_g_Optg13
1643:                 .Caption  = "Bloqueia Tab.Desconto :"
1644:                 .Top      = 411
1645:                 .Left     = 356
1646:                 .AutoSize = .T.
1647:                 .Visible  = .T.
1648:             ENDWITH
1649:             loc_oPage.AddObject("obj_4c_Optiongroup13", "OptionGroup")
1650:             WITH loc_oPage.obj_4c_Optiongroup13
1651:                 .Top         = 407
1652:                 .Left        = 479
1653:                 .Width       = 97
1654:                 .Height      = 23
1655:                 .ButtonCount = 2
1656:                 .Visible     = .T.
1657:                 WITH .Buttons(1)
1658:                     .Caption = "S"
1659:                     .Left = 0
1660:                     .Top = 2
1661:                     .AutoSize = .T.
1662:                     .ForeColor = RGB(0,0,0)
1663:                     .Themes = .F.
1664:                 ENDWITH
1665:                 WITH .Buttons(2)
1666:                     .Caption = "N"
1667:                     .Left = 50
1668:                     .Top = 2
1669:                     .AutoSize = .T.
1670:                     .ForeColor = RGB(0,0,0)
1671:                     .Themes = .F.
1672:                 ENDWITH
1673:             ENDWITH
1674: 
1675:             loc_oPage.AddObject("lbl_g_Liscongv", "Label")
1676:             WITH loc_oPage.lbl_g_Liscongv
1677:                 .Caption  = "Exibe na Consulta Global :"
1678:                 .Top      = 437
1679:                 .Left     = 348
1680:                 .AutoSize = .T.
1681:                 .Visible  = .T.
1682:             ENDWITH
1683:             loc_oPage.AddObject("obj_4c_Opt_Liscongv", "OptionGroup")
1684:             WITH loc_oPage.obj_4c_Opt_Liscongv
1685:                 .Top         = 433
1686:                 .Left        = 479
1687:                 .Width       = 97
1688:                 .Height      = 23
1689:                 .ButtonCount = 2
1690:                 .Visible     = .T.
1691:                 WITH .Buttons(1)
1692:                     .Caption = "S"
1693:                     .Left = 0
1694:                     .Top = 2
1695:                     .AutoSize = .T.
1696:                     .ForeColor = RGB(0,0,0)
1697:                     .Themes = .F.
1698:                 ENDWITH
1699:                 WITH .Buttons(2)
1700:                     .Caption = "N"
1701:                     .Left = 50
1702:                     .Top = 2
1703:                     .AutoSize = .T.
1704:                     .ForeColor = RGB(0,0,0)
1705:                     .Themes = .F.
1706:                 ENDWITH
1707:             ENDWITH
1708: 
1709:             && --- Coluna 765 - Calculos ---
1710:             loc_oPage.AddObject("lbl_g_CalcVenc", "Label")
1711:             WITH loc_oPage.lbl_g_CalcVenc
1712:                 .Caption = "Calcula Vencimento :"
1713:                 .Top     = 8
1714:                 .Left    = 661
1715:                 .Width   = 101
1716:                 .Visible = .T.
1717:             ENDWITH
1718:             loc_oPage.AddObject("obj_4c_Fwoption1", "OptionGroup")
1719:             WITH loc_oPage.obj_4c_Fwoption1
1720:                 .Top         = 4
1721:                 .Left        = 765
1722:                 .Width       = 230
1723:                 .Height      = 23
1724:                 .ButtonCount = 2
1725:                 .Visible     = .T.
1726:                 WITH .Buttons(1)
1727:                     .Caption = "S"
1728:                     .Left = 0
1729:                     .Top = 2
1730:                     .AutoSize = .T.
1731:                     .ForeColor = RGB(0,0,0)
1732:                     .Themes = .F.
1733:                 ENDWITH
1734:                 WITH .Buttons(2)
1735:                     .Caption = "N"
1736:                     .Left = 115
1737:                     .Top = 2
1738:                     .AutoSize = .T.
1739:                     .ForeColor = RGB(0,0,0)
1740:                     .Themes = .F.
1741:                 ENDWITH
1742:             ENDWITH
1743: 
1744:             loc_oPage.AddObject("lbl_g_CopChq", "Label")
1745:             WITH loc_oPage.lbl_g_CopChq
1746:                 .Caption  = "C" + CHR(243) + "pia de Cheque :"
1747:                 .Top      = 34
1748:                 .Left     = 671
1749:                 .AutoSize = .T.
1750:                 .Visible  = .T.
1751:             ENDWITH
1752:             loc_oPage.AddObject("obj_4c_Optiongroup11", "OptionGroup")
1753:             WITH loc_oPage.obj_4c_Optiongroup11
1754:                 .Top         = 30
1755:                 .Left        = 765
1756:                 .Width       = 230
1757:                 .Height      = 23
1758:                 .ButtonCount = 2
1759:                 .Visible     = .T.
1760:                 WITH .Buttons(1)
1761:                     .Caption = "S"
1762:                     .Left = 0
1763:                     .Top = 2
1764:                     .AutoSize = .T.
1765:                     .ForeColor = RGB(0,0,0)
1766:                     .Themes = .F.
1767:                 ENDWITH
1768:                 WITH .Buttons(2)
1769:                     .Caption = "N"
1770:                     .Left = 115
1771:                     .Top = 2
1772:                     .AutoSize = .T.
1773:                     .ForeColor = RGB(0,0,0)
1774:                     .Themes = .F.
1775:                 ENDWITH
1776:             ENDWITH
1777: 
1778:             loc_oPage.AddObject("lbl_g_LeitChq", "Label")
1779:             WITH loc_oPage.lbl_g_LeitChq
1780:                 .Caption = "Leitura de Cheque :"
1781:                 .Top     = 59
1782:                 .Left    = 665
1783:                 .Width   = 97
1784:                 .Height  = 15
1785:                 .Visible = .T.
1786:             ENDWITH
1787:             loc_oPage.AddObject("obj_4c_OptTpLeituras", "OptionGroup")
1788:             WITH loc_oPage.obj_4c_OptTpLeituras
1789:                 .Top         = 55
1790:                 .Left        = 765
1791:                 .Width       = 230
1792:                 .Height      = 23
1793:                 .ButtonCount = 3
1794:                 .Visible     = .T.
1795:                 WITH .Buttons(1)
1796:                     .Caption = "1"
1797:                     .Left = 0
1798:                     .Top = 2
1799:                     .AutoSize = .T.
1800:                     .ForeColor = RGB(0,0,0)
1801:                     .Themes = .F.
1802:                 ENDWITH
1803:                 WITH .Buttons(2)
1804:                     .Caption = "2"
1805:                     .Left = 77
1806:                     .Top = 2
1807:                     .AutoSize = .T.
1808:                     .ForeColor = RGB(0,0,0)
1809:                     .Themes = .F.
1810:                 ENDWITH
1811:                 WITH .Buttons(3)
1812:                     .Caption = "3"
1813:                     .Left = 154
1814:                     .Top = 2
1815:                     .AutoSize = .T.
1816:                     .ForeColor = RGB(0,0,0)
1817:                     .Themes = .F.
1818:                 ENDWITH
1819:             ENDWITH
1820: 
1821:             loc_oPage.AddObject("lbl_g_OpcaoSNA", "Label")
1822:             WITH loc_oPage.lbl_g_OpcaoSNA
1823:                 .Caption  = "Op" + CHR(231) + CHR(227) + "o :"
1824:                 .Top      = 84
1825:                 .Left     = 722
1826:                 .AutoSize = .T.
1827:                 .Visible  = .T.
1828:             ENDWITH
1829:             loc_oPage.AddObject("obj_4c_OpcaoSNA", "OptionGroup")
1830:             WITH loc_oPage.obj_4c_OpcaoSNA
1831:                 .Top         = 80
1832:                 .Left        = 765
1833:                 .Width       = 230
1834:                 .Height      = 23
1835:                 .ButtonCount = 3
1836:                 .Visible     = .T.
1837:                 WITH .Buttons(1)
1838:                     .Caption = "S"
1839:                     .Left = 0
1840:                     .Top = 2
1841:                     .AutoSize = .T.
1842:                     .ForeColor = RGB(0,0,0)
1843:                     .Themes = .F.
1844:                 ENDWITH
1845:                 WITH .Buttons(2)
1846:                     .Caption = "N"
1847:                     .Left = 77
1848:                     .Top = 2
1849:                     .AutoSize = .T.
1850:                     .ForeColor = RGB(0,0,0)
1851:                     .Themes = .F.
1852:                 ENDWITH
1853:                 WITH .Buttons(3)
1854:                     .Caption = "A"
1855:                     .Left = 154
1856:                     .Top = 2
1857:                     .AutoSize = .T.
1858:                     .ForeColor = RGB(0,0,0)
1859:                     .Themes = .F.
1860:                 ENDWITH
1861:             ENDWITH
1862: 
1863:             loc_oPage.AddObject("lbl_g_Autentica", "Label")
1864:             WITH loc_oPage.lbl_g_Autentica
1865:                 .Caption  = "Autentica" + CHR(231) + CHR(227) + "o :"
1866:                 .Top      = 109
1867:                 .Left     = 690
1868:                 .AutoSize = .T.
1869:                 .Visible  = .T.
1870:             ENDWITH
1871:             loc_oPage.AddObject("obj_4c_Optiongroup6", "OptionGroup")
1872:             WITH loc_oPage.obj_4c_Optiongroup6
1873:                 .Top         = 105
1874:                 .Left        = 765
1875:                 .Width       = 230
1876:                 .Height      = 23
1877:                 .ButtonCount = 3
1878:                 .Visible     = .T.
1879:                 WITH .Buttons(1)
1880:                     .Caption = "S"
1881:                     .Left = 0
1882:                     .Top = 2
1883:                     .AutoSize = .T.
1884:                     .ForeColor = RGB(0,0,0)
1885:                     .Themes = .F.
1886:                 ENDWITH
1887:                 WITH .Buttons(2)
1888:                     .Caption = "N"
1889:                     .Left = 77
1890:                     .Top = 2
1891:                     .AutoSize = .T.
1892:                     .ForeColor = RGB(0,0,0)
1893:                     .Themes = .F.
1894:                 ENDWITH
1895:                 WITH .Buttons(3)
1896:                     .Caption = "A"
1897:                     .Left = 154
1898:                     .Top = 2
1899:                     .AutoSize = .T.
1900:                     .ForeColor = RGB(0,0,0)
1901:                     .Themes = .F.
1902:                 ENDWITH
1903:             ENDWITH
1904: 
1905:             loc_oPage.AddObject("lbl_g_Observa", "Label")
1906:             WITH loc_oPage.lbl_g_Observa
1907:                 .Caption  = "Observa" + CHR(231) + CHR(227) + "o :"
1908:                 .Top      = 134
1909:                 .Left     = 695
1910:                 .AutoSize = .T.
1911:                 .Visible  = .T.
1912:             ENDWITH
1913:             loc_oPage.AddObject("obj_4c_OptObserva", "OptionGroup")
1914:             WITH loc_oPage.obj_4c_OptObserva
1915:                 .Top         = 130
1916:                 .Left        = 765
1917:                 .Width       = 230
1918:                 .Height      = 23
1919:                 .ButtonCount = 3
1920:                 .Visible     = .T.
1921:                 WITH .Buttons(1)
1922:                     .Caption = "S"
1923:                     .Left = 0
1924:                     .Top = 2
1925:                     .AutoSize = .T.
1926:                     .ForeColor = RGB(0,0,0)
1927:                     .Themes = .F.
1928:                 ENDWITH
1929:                 WITH .Buttons(2)
1930:                     .Caption = "N"
1931:                     .Left = 77
1932:                     .Top = 2
1933:                     .AutoSize = .T.
1934:                     .ForeColor = RGB(0,0,0)
1935:                     .Themes = .F.
1936:                 ENDWITH
1937:                 WITH .Buttons(3)
1938:                     .Caption = "A"
1939:                     .Left = 154
1940:                     .Top = 2
1941:                     .AutoSize = .T.
1942:                     .ForeColor = RGB(0,0,0)
1943:                     .Themes = .F.
1944:                 ENDWITH
1945:             ENDWITH
1946: 
1947:             loc_oPage.AddObject("lbl_g_emichqs2", "Label")
1948:             WITH loc_oPage.lbl_g_emichqs2
1949:                 .Caption  = "Emiss" + CHR(227) + "o de Cheques :"
1950:                 .Top      = 201
1951:                 .Left     = 655
1952:                 .AutoSize = .T.
1953:                 .Visible  = .T.
1954:             ENDWITH
1955:             loc_oPage.AddObject("obj_4c_Optiongroup1", "OptionGroup")
1956:             WITH loc_oPage.obj_4c_Optiongroup1
1957:                 .Top         = 155
1958:                 .Left        = 765
1959:                 .Width       = 230
1960:                 .Height      = 23
1961:                 .ButtonCount = 3
1962:                 .Visible     = .T.
1963:                 WITH .Buttons(1)
1964:                     .Caption = "1"
1965:                     .Left = 0
1966:                     .Top = 2
1967:                     .AutoSize = .T.
1968:                     .ForeColor = RGB(0,0,0)
1969:                     .Themes = .F.
1970:                 ENDWITH
1971:                 WITH .Buttons(2)
1972:                     .Caption = "2"
1973:                     .Left = 77
1974:                     .Top = 2
1975:                     .AutoSize = .T.
1976:                     .ForeColor = RGB(0,0,0)
1977:                     .Themes = .F.
1978:                 ENDWITH
1979:                 WITH .Buttons(3)
1980:                     .Caption = "3"
1981:                     .Left = 154
1982:                     .Top = 2
1983:                     .AutoSize = .T.
1984:                     .ForeColor = RGB(0,0,0)
1985:                     .Themes = .F.
1986:                 ENDWITH
1987:             ENDWITH
1988: 
1989:             loc_oPage.AddObject("lbl_g_ImpCpChqs", "Label")
1990:             WITH loc_oPage.lbl_g_ImpCpChqs
1991:                 .Caption  = "Imp. Cert. Cr" + CHR(233) + "dito :"
1992:                 .Top      = 159
1993:                 .Left     = 665
1994:                 .AutoSize = .T.
1995:                 .Visible  = .T.
1996:             ENDWITH

*-- Linhas 2003 a 2196:
2003:                 .AutoSize = .T.
2004:                 .Visible  = .T.
2005:             ENDWITH
2006:             loc_oPage.AddObject("obj_4c_Optiongroup14", "OptionGroup")
2007:             WITH loc_oPage.obj_4c_Optiongroup14
2008:                 .Top         = 231
2009:                 .Left        = 765
2010:                 .Width       = 230
2011:                 .Height      = 63
2012:                 .ButtonCount = 3
2013:                 .Visible     = .T.
2014:                 WITH .Buttons(1)
2015:                     .Caption = "1"
2016:                     .Left = 0
2017:                     .Top = 0
2018:                     .AutoSize = .T.
2019:                     .ForeColor = RGB(0,0,0)
2020:                     .Themes = .F.
2021:                 ENDWITH
2022:                 WITH .Buttons(2)
2023:                     .Caption = "2"
2024:                     .Left = 0
2025:                     .Top = 21
2026:                     .AutoSize = .T.
2027:                     .ForeColor = RGB(0,0,0)
2028:                     .Themes = .F.
2029:                 ENDWITH
2030:                 WITH .Buttons(3)
2031:                     .Caption = "3"
2032:                     .Left = 0
2033:                     .Top = 42
2034:                     .AutoSize = .T.
2035:                     .ForeColor = RGB(0,0,0)
2036:                     .Themes = .F.
2037:                 ENDWITH
2038:             ENDWITH
2039: 
2040:             loc_oPage.AddObject("lbl_g_Optg15", "Label")
2041:             WITH loc_oPage.lbl_g_Optg15
2042:                 .Caption  = "Checa Lim. Cr" + CHR(233) + "dito da Conta :"
2043:                 .Top      = 299
2044:                 .Left     = 616
2045:                 .AutoSize = .T.
2046:                 .Visible  = .T.
2047:             ENDWITH
2048:             loc_oPage.AddObject("obj_4c_Optiongroup15", "OptionGroup")
2049:             WITH loc_oPage.obj_4c_Optiongroup15
2050:                 .Top         = 296
2051:                 .Left        = 765
2052:                 .Width       = 92
2053:                 .Height      = 23
2054:                 .ButtonCount = 2
2055:                 .Visible     = .T.
2056:                 WITH .Buttons(1)
2057:                     .Caption = "S"
2058:                     .Left = 0
2059:                     .Top = 2
2060:                     .AutoSize = .T.
2061:                     .ForeColor = RGB(0,0,0)
2062:                     .Themes = .F.
2063:                 ENDWITH
2064:                 WITH .Buttons(2)
2065:                     .Caption = "N"
2066:                     .Left = 47
2067:                     .Top = 2
2068:                     .AutoSize = .T.
2069:                     .ForeColor = RGB(0,0,0)
2070:                     .Themes = .F.
2071:                 ENDWITH
2072:             ENDWITH
2073: 
2074:             loc_oPage.AddObject("lbl_g_Optg17", "Label")
2075:             WITH loc_oPage.lbl_g_Optg17
2076:                 .Caption  = "Bloquia Uso B" + CHR(244) + "nus :"
2077:                 .Top      = 324
2078:                 .Left     = 666
2079:                 .AutoSize = .T.
2080:                 .Visible  = .T.
2081:             ENDWITH
2082:             loc_oPage.AddObject("obj_4c_Optiongroup17", "OptionGroup")
2083:             WITH loc_oPage.obj_4c_Optiongroup17
2084:                 .Top         = 321
2085:                 .Left        = 765
2086:                 .Width       = 92
2087:                 .Height      = 23
2088:                 .ButtonCount = 2
2089:                 .Visible     = .T.
2090:                 WITH .Buttons(1)
2091:                     .Caption = "S"
2092:                     .Left = 0
2093:                     .Top = 2
2094:                     .AutoSize = .T.
2095:                     .ForeColor = RGB(0,0,0)
2096:                     .Themes = .F.
2097:                 ENDWITH
2098:                 WITH .Buttons(2)
2099:                     .Caption = "N"
2100:                     .Left = 47
2101:                     .Top = 2
2102:                     .AutoSize = .T.
2103:                     .ForeColor = RGB(0,0,0)
2104:                     .Themes = .F.
2105:                 ENDWITH
2106:             ENDWITH
2107: 
2108:             loc_oPage.AddObject("lbl_g_Optg16", "Label")
2109:             WITH loc_oPage.lbl_g_Optg16
2110:                 .Caption  = "Bloqueia Altera" + CHR(231) + CHR(227) + "o no Vcto :"
2111:                 .Top      = 349
2112:                 .Left     = 625
2113:                 .AutoSize = .T.
2114:                 .Visible  = .T.
2115:             ENDWITH
2116:             loc_oPage.AddObject("obj_4c_Optiongroup16", "OptionGroup")
2117:             WITH loc_oPage.obj_4c_Optiongroup16
2118:                 .Top         = 346
2119:                 .Left        = 765
2120:                 .Width       = 230
2121:                 .Height      = 45
2122:                 .ButtonCount = 3
2123:                 .Visible     = .T.
2124:                 WITH .Buttons(1)
2125:                     .Caption = "1"
2126:                     .Left = 0
2127:                     .Top = 0
2128:                     .AutoSize = .T.
2129:                     .ForeColor = RGB(0,0,0)
2130:                     .Themes = .F.
2131:                 ENDWITH
2132:                 WITH .Buttons(2)
2133:                     .Caption = "2"
2134:                     .Left = 0
2135:                     .Top = 15
2136:                     .AutoSize = .T.
2137:                     .ForeColor = RGB(0,0,0)
2138:                     .Themes = .F.
2139:                 ENDWITH
2140:                 WITH .Buttons(3)
2141:                     .Caption = "3"
2142:                     .Left = 0
2143:                     .Top = 30
2144:                     .AutoSize = .T.
2145:                     .ForeColor = RGB(0,0,0)
2146:                     .Themes = .F.
2147:                 ENDWITH
2148:             ENDWITH
2149: 
2150:         CATCH TO loc_oErro
2151:             MsgErro("Erro em Formpag.CriarPaginaGeral: " + loc_oErro.Message, "Erro")
2152:         ENDTRY
2153:     ENDPROC
2154: 
2155:     *==========================================================================
2156:     PROTECTED PROCEDURE CriarPaginaCartaoTEF(par_oPage)
2157:     *==========================================================================
2158:         LOCAL loc_oPage
2159:         loc_oPage = par_oPage
2160:         TRY
2161:             && --- Texto Financiamento (EditBox) ---
2162:             loc_oPage.AddObject("lbl_t_TxtFinanc", "Label")
2163:             WITH loc_oPage.lbl_t_TxtFinanc
2164:                 .Caption  = "Texto Financiamento"
2165:                 .Top      = 5
2166:                 .Left     = 520
2167:                 .AutoSize = .T.
2168:                 .Visible  = .T.
2169:             ENDWITH
2170:             loc_oPage.AddObject("obj_4c_EdtTxtFinanc", "EditBox")
2171:             WITH loc_oPage.obj_4c_EdtTxtFinanc
2172:                 .Top     = 19
2173:                 .Left    = 520
2174:                 .Width   = 467
2175:                 .Height  = 142
2176:                 .Visible = .T.
2177:             ENDWITH
2178: 
2179:             && --- Grupo/Conta credito cartao ---
2180:             loc_oPage.AddObject("lbl_t_Grupo2", "Label")
2181:             WITH loc_oPage.lbl_t_Grupo2
2182:                 .Caption  = "Grupo Cr" + CHR(233) + "d. :"
2183:                 .Top      = 175
2184:                 .Left     = 520
2185:                 .AutoSize = .T.
2186:                 .Visible  = .T.
2187:             ENDWITH
2188:             loc_oPage.AddObject("txt_4c_Grupo2", "TextBox")
2189:             WITH loc_oPage.txt_4c_Grupo2
2190:                 .Top       = 172
2191:                 .Left      = 590
2192:                 .Width     = 80
2193:                 .Height    = 21
2194:                 .MaxLength = 10
2195:                 .Visible   = .T.
2196:             ENDWITH

*-- Linhas 2690 a 2831:
2690:                 .Visible = .T.
2691:             ENDWITH
2692: 
2693:             && OptionGroups TEF
2694:             loc_oPage.AddObject("lbl_t_Optg2pg2", "Label")
2695:             WITH loc_oPage.lbl_t_Optg2pg2
2696:                 .Caption  = "Local de Pesquisa do Cheque :"
2697:                 .Top      = 315
2698:                 .Left     = 512
2699:                 .AutoSize = .T.
2700:                 .Visible  = .T.
2701:             ENDWITH
2702:             loc_oPage.AddObject("obj_4c_Optiongroup2_p2", "OptionGroup")
2703:             WITH loc_oPage.obj_4c_Optiongroup2_p2
2704:                 .Top         = 386
2705:                 .Left        = 479
2706:                 .Width       = 97
2707:                 .Height      = 23
2708:                 .ButtonCount = 2
2709:                 .Visible     = .T.
2710:                 WITH .Buttons(1)
2711:                     .Caption = "S"
2712:                     .Left = 0
2713:                     .Top = 2
2714:                     .AutoSize = .T.
2715:                     .ForeColor = RGB(0,0,0)
2716:                     .Themes = .F.
2717:                 ENDWITH
2718:                 WITH .Buttons(2)
2719:                     .Caption = "N"
2720:                     .Left = 50
2721:                     .Top = 2
2722:                     .AutoSize = .T.
2723:                     .ForeColor = RGB(0,0,0)
2724:                     .Themes = .F.
2725:                 ENDWITH
2726:             ENDWITH
2727: 
2728:             loc_oPage.AddObject("lbl_t_CompVinc", "Label")
2729:             WITH loc_oPage.lbl_t_CompVinc
2730:                 .Caption  = "Comprovante Vinculado :"
2731:                 .Top      = 240
2732:                 .Left     = 538
2733:                 .AutoSize = .T.
2734:                 .Visible  = .T.
2735:             ENDWITH
2736:             loc_oPage.AddObject("obj_4c_Optiongroup1_p2", "OptionGroup")
2737:             WITH loc_oPage.obj_4c_Optiongroup1_p2
2738:                 .Top         = 237
2739:                 .Left        = 670
2740:                 .Width       = 97
2741:                 .Height      = 23
2742:                 .ButtonCount = 2
2743:                 .Visible     = .T.
2744:                 WITH .Buttons(1)
2745:                     .Caption = "S"
2746:                     .Left = 0
2747:                     .Top = 2
2748:                     .AutoSize = .T.
2749:                     .ForeColor = RGB(0,0,0)
2750:                     .Themes = .F.
2751:                 ENDWITH
2752:                 WITH .Buttons(2)
2753:                     .Caption = "N"
2754:                     .Left = 50
2755:                     .Top = 2
2756:                     .AutoSize = .T.
2757:                     .ForeColor = RGB(0,0,0)
2758:                     .Themes = .F.
2759:                 ENDWITH
2760:             ENDWITH
2761: 
2762:         CATCH TO loc_oErro
2763:             MsgErro("Erro em Formpag.CriarPaginaCartaoTEF: " + loc_oErro.Message, "Erro")
2764:         ENDTRY
2765:     ENDPROC
2766: 
2767:     *==========================================================================
2768:     PROCEDURE TornarControlesVisiveis(par_oConteiner)
2769:     *==========================================================================
2770:         LOCAL loc_nI, loc_oCtrl
2771:         TRY
2772:             FOR loc_nI = 1 TO par_oConteiner.ControlCount
2773:                 loc_oCtrl = par_oConteiner.Controls(loc_nI)
2774:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
2775:                     IF !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_botoes", "cnt_4c_salva")
2776:                         loc_oCtrl.Visible = .T.
2777:                     ENDIF
2778:                 ENDIF
2779:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
2780:                     IF loc_oCtrl.Visible
2781:                         THIS.TornarControlesVisiveis(loc_oCtrl)
2782:                     ENDIF
2783:                 ENDIF
2784:             ENDFOR
2785:         CATCH TO loc_oErro
2786:             MsgErro("Erro em TornarControlesVisiveis: " + loc_oErro.Message, "Erro")
2787:         ENDTRY
2788:     ENDPROC
2789: 
2790:     *==========================================================================
2791:     PROTECTED PROCEDURE FormParaBO()
2792:     *==========================================================================
2793:         LOCAL loc_oPgf1, loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
2794:         TRY
2795:             loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
2796:             loc_oPgf2  = loc_oPage2.pgf_4c_Dados
2797:             loc_oP1    = loc_oPgf2.Pages(1)
2798:             loc_oP2    = loc_oPgf2.Pages(2)
2799: 
2800:             WITH THIS.this_oBusinessObject
2801:                 && Cabecalho
2802:                 .this_cFpags     = ALLTRIM(loc_oPage2.txt_4c_Codigo.Value)
2803:                 .this_cDescrs    = ALLTRIM(loc_oPage2.txt_4c_Descrs.Value)
2804:                 .this_cTitfpags  = ALLTRIM(loc_oPage2.txt_4c_TitFPags.Value)
2805:                 .this_cFormas    = ALLTRIM(loc_oPage2.txt_4c_Forma.Value)
2806:                 .this_cNfpags    = VAL(ALLTRIM(loc_oPage2.txt_4c_Nfpag.Value))
2807:                 .this_cModpagto  = ALLTRIM(loc_oPage2.txt_4c_Modalidade.Value)
2808:                 .this_cGrupods   = ALLTRIM(loc_oPage2.txt_4c_Grupo.Value)
2809:                 .this_cContads   = ALLTRIM(loc_oPage2.txt_4c_Conta.Value)
2810:                 .this_cDcontads  = ALLTRIM(loc_oPage2.txt_4c_Dconta.Value)
2811:                 .this_nOrides    = loc_oPage2.obj_4c_Opt_ContaMov.Value - 1
2812: 
2813:                 && Pagina Geral
2814:                 .this_nEntradas  = ALLTRIM(loc_oP1.txt_4c_Entrada.Value)
2815:                 .this_nDias      = ALLTRIM(loc_oP1.txt_4c_Dias.Value)
2816:                 .this_nFparcs    = ALLTRIM(loc_oP1.txt_4c_Parcelas.Value)
2817:                 .this_cMoefpgs   = ALLTRIM(loc_oP1.txt_4c___formas.Value)
2818:                 .this_cSituas    = ALLTRIM(loc_oP1.txt_4c__Situa.Value)
2819:                 .this_cTvens     = ALLTRIM(loc_oP1.txt_4c_VENC.Value)
2820:                 .this_cInfos     = ALLTRIM(loc_oP1.txt_4c_INFO.Value)
2821:                 .this_cColdados  = ALLTRIM(loc_oP1.txt_4c_ChqObrig.Value)
2822:                 .this_cEmps      = ALLTRIM(loc_oP1.txt_4c_EmpLanc.Value)
2823:                 .this_cGrupoemp  = ALLTRIM(loc_oP1.txt_4c_GrupoEmp.Value)
2824:                 .this_cCpictures = ALLTRIM(loc_oP1.txt_4c_Picture.Value)
2825:                 .this_nVlrfpgs   = ALLTRIM(loc_oP1.txt_4c_Valor.Value)
2826:                 .this_nDescs     = ALLTRIM(loc_oP1.txt_4c_Desconto.Value)
2827:                 .this_nFpcomiss  = ALLTRIM(loc_oP1.txt_4c_Comissao.Value)
2828:                 .this_nEncargos  = ALLTRIM(loc_oP1.txt_4c_Encargos.Value)
2829:                 .this_nPvarias   = ALLTRIM(loc_oP1.txt_4c_PVaria.Value)
2830:                 .this_nIndices   = ALLTRIM(loc_oP1.txt_4c_Indice.Value)
2831:                 .this_nTaxjuros  = ALLTRIM(loc_oP1.txt_4c_TaxJuros.Value)

*-- Linhas 2840 a 2940:
2840:                 .this_nImpchqs   = loc_oP1.obj_4c_Op_ImpChqs.Value - 1
2841:                 .this_nImpbols   = loc_oP1.obj_4c_OptImpBols.Value - 1
2842:                 .this_nImpdups   = loc_oP1.obj_4c_OptImpDups.Value - 1
2843:                 .this_nBlqtabds  = loc_oP1.obj_4c_Optiongroup13.Value - 1
2844:                 .this_nLiscongv  = loc_oP1.obj_4c_Opt_Liscongv.Value - 1
2845:                 .this_nMesfec    = loc_oP1.obj_4c_Optiongroup7.Value - 1
2846:                 .this_nAgcobs    = loc_oP1.obj_4c_Optiongroup10.Value - 1
2847:                 .this_nTrocos    = loc_oP1.obj_4c_OptTrocos.Value - 1
2848:                 .this_nBxcomchqs = loc_oP1.obj_4c_Optiongroup5.Value - 1
2849:                 .this_nBaixas    = loc_oP1.obj_4c_Optiongroup2.Value - 1
2850:                 .this_nAcumulas  = loc_oP1.obj_4c_Optiongroup8.Value - 1
2851:                 .this_nItemobrigs = loc_oP1.obj_4c_Optiongroup3.Value - 1
2852:                 .this_nAprovas   = loc_oP1.obj_4c_Optiongroup4.Value - 1
2853:                 .this_nDetFecCxs = loc_oP1.obj_4c_Optiongroup12.Value - 1
2854:                 .this_nOptcredcta = loc_oP1.obj_4c_Fwoption1.Value - 1
2855:                 .this_nTpcheques = loc_oP1.obj_4c_Optiongroup11.Value - 1
2856:                 .this_nTpvencs   = loc_oP1.obj_4c_OptTpLeituras.Value - 1
2857:                 .this_nOpcsnas   = loc_oP1.obj_4c_OpcaoSNA.Value - 1
2858:                 .this_nAutenticas = loc_oP1.obj_4c_Optiongroup6.Value - 1
2859:                 .this_nObs       = loc_oP1.obj_4c_OptObserva.Value - 1
2860:                 .this_nGavetas   = loc_oP1.obj_4c_Optiongroup1.Value - 1
2861:                 .this_nRelmetvend = loc_oP1.obj_4c_Optiongroup14.Value - 1
2862:                 .this_nChklimcre = loc_oP1.obj_4c_Optiongroup15.Value - 1
2863:                 .this_nRelsomsub = loc_oP1.obj_4c_Optiongroup17.Value - 1
2864:                 .this_nBlqvctopar = loc_oP1.obj_4c_Optiongroup16.Value - 1
2865:                 .this_nImpbols   = loc_oP1.obj_4c_OptFechm.Value - 1
2866: 
2867:                 && Pagina Cartao/TEF
2868:                 .this_cMfinancs  = loc_oP2.obj_4c_EdtTxtFinanc.Value
2869:                 .this_cGrupoos   = ALLTRIM(loc_oP2.txt_4c_Grupo2.Value)
2870:                 .this_cContaos   = ALLTRIM(loc_oP2.txt_4c_Contao.Value)
2871:                 .this_cDcontaos  = ALLTRIM(loc_oP2.txt_4c_Dcontao.Value)
2872:                 .this_cGrupobs   = ALLTRIM(loc_oP2.txt_4c_GrTxCart.Value)
2873:                 .this_cContabs   = ALLTRIM(loc_oP2.txt_4c_CnTxCart.Value)
2874:                 .this_cDcarts    = ALLTRIM(loc_oP2.txt_4c__dcarts.Value)
2875:                 .this_cCarauts   = ALLTRIM(loc_oP2.txt_4c__carauts.Value)
2876:                 .this_cParcini   = ALLTRIM(loc_oP2.txt_4c_ParIni.Value)
2877:                 .this_cParcfin   = ALLTRIM(loc_oP2.txt_4c_ParFin.Value)
2878:                 .this_cBandeira  = ALLTRIM(loc_oP2.txt_4c_Band.Value)
2879:                 .this_nTaxjuros  = ALLTRIM(loc_oP2.txt_4c_Taxa.Value)
2880:                 .this_nPrazos    = ALLTRIM(loc_oP2.txt_4c_Prazo.Value)
2881:                 .this_nVlrminpar = ALLTRIM(loc_oP2.txt_4c_VlrMinPar.Value)
2882:                 .this_cCitems    = ALLTRIM(loc_oP2.txt_4c_DigCartao.Value)
2883:                 .this_cGarantias = ALLTRIM(loc_oP2.txt_4c_Garantia.Value)
2884:                 .this_cLsaque    = ALLTRIM(loc_oP2.txt_4c_Saque.Value)
2885:                 .this_cTcdc      = ALLTRIM(loc_oP2.txt_4c_CDC.Value)
2886:                 .this_cHists     = ALLTRIM(loc_oP2.txt_4c_Hists.Value)
2887:                 .this_cAdquirente = ALLTRIM(loc_oP2.txt_4c_Adquire.Value)
2888:                 .this_cOperacaoss = ALLTRIM(loc_oP2.txt_4c_Finalz.Value)
2889:                 .this_cOperacaoes = ALLTRIM(loc_oP2.txt_4c_Dfinalz.Value)
2890:                 .this_cCcupomnvs = ALLTRIM(loc_oP2.txt_4c_Cupom.Value)
2891:                 .this_cCodestabs = ALLTRIM(loc_oP2.txt_4c_Estab.Value)
2892:                 .this_cCitems    = ALLTRIM(loc_oP2.txt_4c_Item.Value)
2893:             ENDWITH
2894:         CATCH TO loc_oErro
2895:             MsgErro("Erro em Formpag.FormParaBO: " + loc_oErro.Message, "Erro")
2896:         ENDTRY
2897:     ENDPROC
2898: 
2899:     *==========================================================================
2900:     PROTECTED PROCEDURE BOParaForm()
2901:     *==========================================================================
2902:         LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
2903:         TRY
2904:             loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
2905:             loc_oPgf2  = loc_oPage2.pgf_4c_Dados
2906:             loc_oP1    = loc_oPgf2.Pages(1)
2907:             loc_oP2    = loc_oPgf2.Pages(2)
2908: 
2909:             WITH THIS.this_oBusinessObject
2910:                 && Cabecalho
2911:                 loc_oPage2.txt_4c_Codigo.Value    = .this_cFpags
2912:                 loc_oPage2.txt_4c_Descrs.Value    = .this_cDescrs
2913:                 loc_oPage2.txt_4c_TitFPags.Value  = .this_cTitfpags
2914:                 loc_oPage2.txt_4c_Forma.Value     = .this_cFormas
2915:                 loc_oPage2.txt_4c_Nfpag.Value     = ALLTRIM(STR(.this_nNfpags))
2916:                 loc_oPage2.txt_4c_Modalidade.Value = .this_cModpagto
2917:                 loc_oPage2.txt_4c_Grupo.Value     = .this_cGrupods
2918:                 loc_oPage2.txt_4c_Conta.Value     = .this_cContads
2919:                 loc_oPage2.txt_4c_Dconta.Value    = .this_cDcontads
2920:                 loc_oPage2.obj_4c_Opt_ContaMov.Value = .this_nOrides + 1
2921: 
2922:                 && Pagina Geral
2923:                 loc_oP1.txt_4c_Entrada.Value    = ALLTRIM(STR(.this_nEntradas))
2924:                 loc_oP1.txt_4c_Dias.Value       = ALLTRIM(STR(.this_nDias))
2925:                 loc_oP1.txt_4c_Parcelas.Value   = ALLTRIM(STR(.this_nFparcs))
2926:                 loc_oP1.txt_4c___formas.Value   = .this_cMoefpgs
2927:                 loc_oP1.txt_4c__Situa.Value     = .this_cSituas
2928:                 loc_oP1.txt_4c_VENC.Value       = .this_cTvens
2929:                 loc_oP1.txt_4c_INFO.Value       = .this_cInfos
2930:                 loc_oP1.txt_4c_ChqObrig.Value   = .this_cColdados
2931:                 loc_oP1.txt_4c_EmpLanc.Value    = .this_cEmps
2932:                 loc_oP1.txt_4c_GrupoEmp.Value   = .this_cGrupoemp
2933:                 loc_oP1.txt_4c_Picture.Value    = .this_cCpictures
2934:                 loc_oP1.txt_4c_Valor.Value      = ALLTRIM(STR(.this_nVlrfpgs, 14, 2))
2935:                 loc_oP1.txt_4c_Desconto.Value   = ALLTRIM(STR(.this_nDescs, 8, 2))
2936:                 loc_oP1.txt_4c_Comissao.Value   = ALLTRIM(STR(.this_nFpcomiss, 8, 2))
2937:                 loc_oP1.txt_4c_Encargos.Value   = ALLTRIM(STR(.this_nEncargos, 8, 2))
2938:                 loc_oP1.txt_4c_PVaria.Value     = ALLTRIM(STR(.this_nPvarias, 8, 2))
2939:                 loc_oP1.txt_4c_Indice.Value     = ALLTRIM(STR(.this_nIndices, 9, 3))
2940:                 loc_oP1.txt_4c_TaxJuros.Value   = ALLTRIM(STR(.this_nTaxjuros, 12, 4))

*-- Linhas 2949 a 3049:
2949:                 loc_oP1.obj_4c_Op_ImpChqs.Value = IIF(.this_nImpchqs = 0, 2, .this_nImpchqs + 1)
2950:                 loc_oP1.obj_4c_OptImpBols.Value = IIF(.this_nImpbols = 0, 2, .this_nImpbols + 1)
2951:                 loc_oP1.obj_4c_OptImpDups.Value = IIF(.this_nImpdups = 0, 2, .this_nImpdups + 1)
2952:                 loc_oP1.obj_4c_Optiongroup13.Value = IIF(.this_nBlqtabds = 0, 2, .this_nBlqtabds + 1)
2953:                 loc_oP1.obj_4c_Opt_Liscongv.Value = IIF(.this_nLiscongv = 0, 2, .this_nLiscongv + 1)
2954:                 loc_oP1.obj_4c_OptFechm.Value   = IIF(.this_nMesfec = 0, 2, .this_nMesfec + 1)
2955:                 loc_oP1.obj_4c_Optiongroup7.Value = IIF(.this_nMesfec = 0, 2, .this_nMesfec + 1)
2956:                 loc_oP1.obj_4c_Optiongroup10.Value = IIF(.this_nAgcobs = 0, 2, .this_nAgcobs + 1)
2957:                 loc_oP1.obj_4c_OptTrocos.Value  = IIF(.this_nTrocos = 0, 2, .this_nTrocos + 1)
2958:                 loc_oP1.obj_4c_Optiongroup5.Value = IIF(.this_nBxcomchqs = 0, 2, .this_nBxcomchqs + 1)
2959:                 loc_oP1.obj_4c_Optiongroup2.Value = IIF(.this_nBaixas = 0, 2, .this_nBaixas + 1)
2960:                 loc_oP1.obj_4c_Optiongroup8.Value = IIF(.this_nAcumulas = 0, 2, .this_nAcumulas + 1)
2961:                 loc_oP1.obj_4c_Optiongroup3.Value = IIF(.this_nItemobrigs = 0, 2, .this_nItemobrigs + 1)
2962:                 loc_oP1.obj_4c_Optiongroup4.Value = IIF(.this_nAprovas = 0, 2, .this_nAprovas + 1)
2963:                 loc_oP1.obj_4c_Optiongroup12.Value = IIF(.this_nDetFecCxs = 0, 2, .this_nDetFecCxs + 1)
2964:                 loc_oP1.obj_4c_Fwoption1.Value  = IIF(.this_nOptcredcta = 0, 2, .this_nOptcredcta + 1)
2965:                 loc_oP1.obj_4c_Optiongroup11.Value = IIF(.this_nTpcheques = 0, 2, .this_nTpcheques + 1)
2966:                 loc_oP1.obj_4c_OptTpLeituras.Value = IIF(.this_nTpvencs = 0, 2, .this_nTpvencs + 1)
2967:                 loc_oP1.obj_4c_OpcaoSNA.Value   = IIF(.this_nOpcsnas = 0, 2, .this_nOpcsnas + 1)
2968:                 loc_oP1.obj_4c_Optiongroup6.Value = IIF(.this_nAutenticas = 0, 2, .this_nAutenticas + 1)
2969:                 loc_oP1.obj_4c_OptObserva.Value = IIF(.this_nObs = 0, 2, .this_nObs + 1)
2970:                 loc_oP1.obj_4c_Optiongroup1.Value = IIF(.this_nGavetas = 0, 2, .this_nGavetas + 1)
2971:                 loc_oP1.obj_4c_Optiongroup14.Value = IIF(.this_nRelmetvend = 0, 2, .this_nRelmetvend + 1)
2972:                 loc_oP1.obj_4c_Optiongroup15.Value = IIF(.this_nChklimcre = 0, 2, .this_nChklimcre + 1)
2973:                 loc_oP1.obj_4c_Optiongroup17.Value = IIF(.this_nRelsomsub = 0, 2, .this_nRelsomsub + 1)
2974:                 loc_oP1.obj_4c_Optiongroup16.Value = IIF(.this_nBlqvctopar = 0, 2, .this_nBlqvctopar + 1)
2975: 
2976:                 && Pagina Cartao/TEF
2977:                 loc_oP2.obj_4c_EdtTxtFinanc.Value = .this_cMfinancs
2978:                 loc_oP2.txt_4c_Grupo2.Value     = .this_cGrupoos
2979:                 loc_oP2.txt_4c_Contao.Value     = .this_cContaos
2980:                 loc_oP2.txt_4c_Dcontao.Value    = .this_cDcontaos
2981:                 loc_oP2.txt_4c_GrTxCart.Value   = .this_cGrupobs
2982:                 loc_oP2.txt_4c_CnTxCart.Value   = .this_cContabs
2983:                 loc_oP2.txt_4c__dcarts.Value    = .this_cDcarts
2984:                 loc_oP2.txt_4c__carauts.Value   = .this_cCarauts
2985:                 loc_oP2.txt_4c_ParIni.Value     = .this_cParcini
2986:                 loc_oP2.txt_4c_ParFin.Value     = .this_cParcfin
2987:                 loc_oP2.txt_4c_Band.Value       = .this_cBandeira
2988:                 loc_oP2.txt_4c_Taxa.Value       = ALLTRIM(STR(.this_nTaxjuros, 8, 2))
2989:                 loc_oP2.txt_4c_Prazo.Value      = ALLTRIM(STR(.this_nPrazos))
2990:                 loc_oP2.txt_4c_VlrMinPar.Value  = ALLTRIM(STR(.this_nVlrminpar, 14, 2))
2991:                 loc_oP2.txt_4c_DigCartao.Value  = .this_cCitems
2992:                 loc_oP2.txt_4c_Garantia.Value   = .this_cGarantias
2993:                 loc_oP2.txt_4c_Saque.Value      = .this_cLsaque
2994:                 loc_oP2.txt_4c_CDC.Value        = .this_cTcdc
2995:                 loc_oP2.txt_4c_Hists.Value      = .this_cHists
2996:                 loc_oP2.txt_4c_Adquire.Value    = .this_cAdquirente
2997:                 loc_oP2.txt_4c_Finalz.Value     = .this_cOperacaoss
2998:                 loc_oP2.txt_4c_Dfinalz.Value    = .this_cOperacaoes
2999:                 loc_oP2.txt_4c_Cupom.Value      = .this_cCcupomnvs
3000:                 loc_oP2.txt_4c_Estab.Value      = .this_cCodestabs
3001:                 loc_oP2.txt_4c_Item.Value       = .this_cCitems
3002:             ENDWITH
3003:         CATCH TO loc_oErro
3004:             MsgErro("Erro em Formpag.BOParaForm: " + loc_oErro.Message, "Erro")
3005:         ENDTRY
3006:     ENDPROC
3007: 
3008:     *==========================================================================
3009:     PROTECTED PROCEDURE LimparCampos()
3010:     *==========================================================================
3011:         LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
3012:         TRY
3013:             loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
3014:             loc_oPgf2  = loc_oPage2.pgf_4c_Dados
3015:             loc_oP1    = loc_oPgf2.Pages(1)
3016:             loc_oP2    = loc_oPgf2.Pages(2)
3017: 
3018:             && Cabecalho
3019:             loc_oPage2.txt_4c_Codigo.Value    = ""
3020:             loc_oPage2.txt_4c_Descrs.Value    = ""
3021:             loc_oPage2.txt_4c_TitFPags.Value  = ""
3022:             loc_oPage2.txt_4c_Forma.Value     = ""
3023:             loc_oPage2.txt_4c_Nfpag.Value     = ""
3024:             loc_oPage2.txt_4c_Modalidade.Value = ""
3025:             loc_oPage2.txt_4c_Grupo.Value     = ""
3026:             loc_oPage2.txt_4c_Conta.Value     = ""
3027:             loc_oPage2.txt_4c_Dconta.Value    = ""
3028:             loc_oPage2.obj_4c_Opt_ContaMov.Value = 1
3029: 
3030:             && Pagina Geral
3031:             loc_oP1.txt_4c_Entrada.Value   = ""
3032:             loc_oP1.txt_4c_Dias.Value      = ""
3033:             loc_oP1.txt_4c_Parcelas.Value  = ""
3034:             loc_oP1.txt_4c___formas.Value  = ""
3035:             loc_oP1.txt_4c__Situa.Value    = ""
3036:             loc_oP1.txt_4c_VENC.Value      = ""
3037:             loc_oP1.txt_4c_INFO.Value      = ""
3038:             loc_oP1.txt_4c_ChqObrig.Value  = ""
3039:             loc_oP1.txt_4c_EmpLanc.Value   = ""
3040:             loc_oP1.txt_4c_GrupoEmp.Value  = ""
3041:             loc_oP1.txt_4c_Picture.Value   = ""
3042:             loc_oP1.txt_4c_Valor.Value     = ""
3043:             loc_oP1.txt_4c_Desconto.Value  = ""
3044:             loc_oP1.txt_4c_Comissao.Value  = ""
3045:             loc_oP1.txt_4c_Encargos.Value  = ""
3046:             loc_oP1.txt_4c_PVaria.Value    = ""
3047:             loc_oP1.txt_4c_Indice.Value    = ""
3048:             loc_oP1.txt_4c_TaxJuros.Value  = ""
3049:             loc_oP1.txt_4c_TolFecCx.Value  = ""

*-- Linhas 3057 a 3156:
3057:             loc_oP1.obj_4c_Op_ImpChqs.Value    = 1
3058:             loc_oP1.obj_4c_OptImpBols.Value    = 1
3059:             loc_oP1.obj_4c_OptImpDups.Value    = 1
3060:             loc_oP1.obj_4c_Optiongroup13.Value = 1
3061:             loc_oP1.obj_4c_Opt_Liscongv.Value  = 1
3062:             loc_oP1.obj_4c_OptFechm.Value      = 1
3063:             loc_oP1.obj_4c_Optiongroup7.Value  = 1
3064:             loc_oP1.obj_4c_Optiongroup10.Value = 1
3065:             loc_oP1.obj_4c_OptTrocos.Value     = 1
3066:             loc_oP1.obj_4c_Optiongroup5.Value  = 1
3067:             loc_oP1.obj_4c_Optiongroup2.Value  = 1
3068:             loc_oP1.obj_4c_Optiongroup8.Value  = 1
3069:             loc_oP1.obj_4c_Optiongroup3.Value  = 1
3070:             loc_oP1.obj_4c_Optiongroup4.Value  = 1
3071:             loc_oP1.obj_4c_Optiongroup12.Value = 1
3072:             loc_oP1.obj_4c_Fwoption1.Value     = 1
3073:             loc_oP1.obj_4c_Optiongroup11.Value = 1
3074:             loc_oP1.obj_4c_OptTpLeituras.Value = 1
3075:             loc_oP1.obj_4c_OpcaoSNA.Value      = 1
3076:             loc_oP1.obj_4c_Optiongroup6.Value  = 1
3077:             loc_oP1.obj_4c_OptObserva.Value    = 1
3078:             loc_oP1.obj_4c_Optiongroup1.Value  = 1
3079:             loc_oP1.obj_4c_Optiongroup14.Value = 1
3080:             loc_oP1.obj_4c_Optiongroup15.Value = 1
3081:             loc_oP1.obj_4c_Optiongroup17.Value = 1
3082:             loc_oP1.obj_4c_Optiongroup16.Value = 1
3083: 
3084:             && Pagina Cartao/TEF
3085:             loc_oP2.obj_4c_EdtTxtFinanc.Value = ""
3086:             loc_oP2.txt_4c_Grupo2.Value    = ""
3087:             loc_oP2.txt_4c_Contao.Value    = ""
3088:             loc_oP2.txt_4c_Dcontao.Value   = ""
3089:             loc_oP2.txt_4c_GrTxCart.Value  = ""
3090:             loc_oP2.txt_4c_CnTxCart.Value  = ""
3091:             loc_oP2.txt_4c__dcarts.Value   = ""
3092:             loc_oP2.txt_4c__carauts.Value  = ""
3093:             loc_oP2.txt_4c_ParIni.Value    = ""
3094:             loc_oP2.txt_4c_ParFin.Value    = ""
3095:             loc_oP2.txt_4c_Band.Value      = ""
3096:             loc_oP2.txt_4c_Taxa.Value      = ""
3097:             loc_oP2.txt_4c_Prazo.Value     = ""
3098:             loc_oP2.txt_4c_VlrMinPar.Value = ""
3099:             loc_oP2.txt_4c_DigCartao.Value = ""
3100:             loc_oP2.txt_4c_Garantia.Value  = ""
3101:             loc_oP2.txt_4c_Saque.Value     = ""
3102:             loc_oP2.txt_4c_CDC.Value       = ""
3103:             loc_oP2.txt_4c_Hists.Value     = ""
3104:             loc_oP2.txt_4c_Adquire.Value   = ""
3105:             loc_oP2.txt_4c_Finalz.Value    = ""
3106:             loc_oP2.txt_4c_Dfinalz.Value   = ""
3107:             loc_oP2.txt_4c_Cupom.Value     = ""
3108:             loc_oP2.txt_4c_Estab.Value     = ""
3109:             loc_oP2.txt_4c_Item.Value      = ""
3110:         CATCH TO loc_oErro
3111:             MsgErro("Erro em Formpag.LimparCampos: " + loc_oErro.Message, "Erro")
3112:         ENDTRY
3113:     ENDPROC
3114: 
3115:     *==========================================================================
3116:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3117:     *==========================================================================
3118:         LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2, loc_lReadOnly
3119:         TRY
3120:             loc_lReadOnly = !par_lHabilitar
3121:             loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
3122:             loc_oPgf2  = loc_oPage2.pgf_4c_Dados
3123:             loc_oP1    = loc_oPgf2.Pages(1)
3124:             loc_oP2    = loc_oPgf2.Pages(2)
3125: 
3126:             && Cabecalho
3127:             loc_oPage2.txt_4c_Codigo.ReadOnly    = loc_lReadOnly
3128:             loc_oPage2.txt_4c_Descrs.ReadOnly    = loc_lReadOnly
3129:             loc_oPage2.txt_4c_TitFPags.ReadOnly  = loc_lReadOnly
3130:             loc_oPage2.txt_4c_Forma.ReadOnly     = loc_lReadOnly
3131:             loc_oPage2.txt_4c_Nfpag.ReadOnly     = loc_lReadOnly
3132:             loc_oPage2.txt_4c_Modalidade.ReadOnly = loc_lReadOnly
3133:             loc_oPage2.txt_4c_Grupo.ReadOnly     = loc_lReadOnly
3134:             loc_oPage2.txt_4c_Conta.ReadOnly     = loc_lReadOnly
3135:             loc_oPage2.obj_4c_Opt_ContaMov.Enabled = par_lHabilitar
3136: 
3137:             && Pagina Geral
3138:             loc_oP1.txt_4c_Entrada.ReadOnly   = loc_lReadOnly
3139:             loc_oP1.txt_4c_Dias.ReadOnly      = loc_lReadOnly
3140:             loc_oP1.txt_4c_Parcelas.ReadOnly  = loc_lReadOnly
3141:             loc_oP1.txt_4c___formas.ReadOnly  = loc_lReadOnly
3142:             loc_oP1.txt_4c__Situa.ReadOnly    = loc_lReadOnly
3143:             loc_oP1.txt_4c_VENC.ReadOnly      = loc_lReadOnly
3144:             loc_oP1.txt_4c_INFO.ReadOnly      = loc_lReadOnly
3145:             loc_oP1.txt_4c_ChqObrig.ReadOnly  = loc_lReadOnly
3146:             loc_oP1.txt_4c_EmpLanc.ReadOnly   = loc_lReadOnly
3147:             loc_oP1.txt_4c_GrupoEmp.ReadOnly  = loc_lReadOnly
3148:             loc_oP1.txt_4c_Picture.ReadOnly   = loc_lReadOnly
3149:             loc_oP1.txt_4c_Valor.ReadOnly     = loc_lReadOnly
3150:             loc_oP1.txt_4c_Desconto.ReadOnly  = loc_lReadOnly
3151:             loc_oP1.txt_4c_Comissao.ReadOnly  = loc_lReadOnly
3152:             loc_oP1.txt_4c_Encargos.ReadOnly  = loc_lReadOnly
3153:             loc_oP1.txt_4c_PVaria.ReadOnly    = loc_lReadOnly
3154:             loc_oP1.txt_4c_Indice.ReadOnly    = loc_lReadOnly
3155:             loc_oP1.txt_4c_TaxJuros.ReadOnly  = loc_lReadOnly
3156:             loc_oP1.txt_4c_TolFecCx.ReadOnly  = loc_lReadOnly

*-- Linhas 3164 a 3545:
3164:             loc_oP1.obj_4c_Op_ImpChqs.Enabled    = par_lHabilitar
3165:             loc_oP1.obj_4c_OptImpBols.Enabled    = par_lHabilitar
3166:             loc_oP1.obj_4c_OptImpDups.Enabled    = par_lHabilitar
3167:             loc_oP1.obj_4c_Optiongroup13.Enabled = par_lHabilitar
3168:             loc_oP1.obj_4c_Opt_Liscongv.Enabled  = par_lHabilitar
3169:             loc_oP1.obj_4c_OptFechm.Enabled      = par_lHabilitar
3170:             loc_oP1.obj_4c_Optiongroup7.Enabled  = par_lHabilitar
3171:             loc_oP1.obj_4c_Optiongroup10.Enabled = par_lHabilitar
3172:             loc_oP1.obj_4c_OptTrocos.Enabled     = par_lHabilitar
3173:             loc_oP1.obj_4c_Optiongroup5.Enabled  = par_lHabilitar
3174:             loc_oP1.obj_4c_Optiongroup2.Enabled  = par_lHabilitar
3175:             loc_oP1.obj_4c_Optiongroup8.Enabled  = par_lHabilitar
3176:             loc_oP1.obj_4c_Optiongroup3.Enabled  = par_lHabilitar
3177:             loc_oP1.obj_4c_Optiongroup4.Enabled  = par_lHabilitar
3178:             loc_oP1.obj_4c_Optiongroup12.Enabled = par_lHabilitar
3179:             loc_oP1.obj_4c_Fwoption1.Enabled     = par_lHabilitar
3180:             loc_oP1.obj_4c_Optiongroup11.Enabled = par_lHabilitar
3181:             loc_oP1.obj_4c_OptTpLeituras.Enabled = par_lHabilitar
3182:             loc_oP1.obj_4c_OpcaoSNA.Enabled      = par_lHabilitar
3183:             loc_oP1.obj_4c_Optiongroup6.Enabled  = par_lHabilitar
3184:             loc_oP1.obj_4c_OptObserva.Enabled    = par_lHabilitar
3185:             loc_oP1.obj_4c_Optiongroup1.Enabled  = par_lHabilitar
3186:             loc_oP1.obj_4c_Optiongroup14.Enabled = par_lHabilitar
3187:             loc_oP1.obj_4c_Optiongroup15.Enabled = par_lHabilitar
3188:             loc_oP1.obj_4c_Optiongroup17.Enabled = par_lHabilitar
3189:             loc_oP1.obj_4c_Optiongroup16.Enabled = par_lHabilitar
3190: 
3191:             && Pagina Cartao/TEF
3192:             loc_oP2.obj_4c_EdtTxtFinanc.ReadOnly = loc_lReadOnly
3193:             loc_oP2.txt_4c_Grupo2.ReadOnly   = loc_lReadOnly
3194:             loc_oP2.txt_4c_Contao.ReadOnly   = loc_lReadOnly
3195:             loc_oP2.txt_4c_GrTxCart.ReadOnly = loc_lReadOnly
3196:             loc_oP2.txt_4c_CnTxCart.ReadOnly = loc_lReadOnly
3197:             loc_oP2.txt_4c__dcarts.ReadOnly  = loc_lReadOnly
3198:             loc_oP2.txt_4c__carauts.ReadOnly = loc_lReadOnly
3199:             loc_oP2.txt_4c_ParIni.ReadOnly   = loc_lReadOnly
3200:             loc_oP2.txt_4c_ParFin.ReadOnly   = loc_lReadOnly
3201:             loc_oP2.txt_4c_Band.ReadOnly     = loc_lReadOnly
3202:             loc_oP2.txt_4c_Taxa.ReadOnly     = loc_lReadOnly
3203:             loc_oP2.txt_4c_Prazo.ReadOnly    = loc_lReadOnly
3204:             loc_oP2.txt_4c_VlrMinPar.ReadOnly = loc_lReadOnly
3205:             loc_oP2.txt_4c_DigCartao.ReadOnly = loc_lReadOnly
3206:             loc_oP2.txt_4c_Garantia.ReadOnly = loc_lReadOnly
3207:             loc_oP2.txt_4c_Saque.ReadOnly    = loc_lReadOnly
3208:             loc_oP2.txt_4c_CDC.ReadOnly      = loc_lReadOnly
3209:             loc_oP2.txt_4c_Hists.ReadOnly    = loc_lReadOnly
3210:             loc_oP2.txt_4c_Adquire.ReadOnly  = loc_lReadOnly
3211:             loc_oP2.txt_4c_Finalz.ReadOnly   = loc_lReadOnly
3212:             loc_oP2.txt_4c_Dfinalz.ReadOnly  = loc_lReadOnly
3213:             loc_oP2.txt_4c_Cupom.ReadOnly    = loc_lReadOnly
3214:             loc_oP2.txt_4c_Estab.ReadOnly    = loc_lReadOnly
3215:             loc_oP2.txt_4c_Item.ReadOnly     = loc_lReadOnly
3216:         CATCH TO loc_oErro
3217:             MsgErro("Erro em Formpag.HabilitarCampos: " + loc_oErro.Message, "Erro")
3218:         ENDTRY
3219:     ENDPROC
3220: 
3221:     *==========================================================================
3222:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
3223:     *==========================================================================
3224:         LOCAL loc_oPage1, loc_oPage2, loc_lEdicao
3225:         TRY
3226:             loc_oPage1 = THIS.pgf_4c_Paginas.Pages(1)
3227:             loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
3228:             loc_lEdicao = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")
3229: 
3230:             DO CASE
3231:             CASE par_cModo = "LISTA"
3232:                 THIS.pgf_4c_Paginas.Visible = .T.
3233:                 THIS.pgf_4c_Paginas.ActivePage = 1
3234:                 loc_oPage2.cnt_4c_Salva.Visible = .F.
3235:             CASE par_cModo = "INCLUIR" OR par_cModo = "ALTERAR"
3236:                 THIS.pgf_4c_Paginas.ActivePage = 2
3237:                 loc_oPage2.cnt_4c_Salva.Visible = .T.
3238:             CASE par_cModo = "VISUALIZAR"
3239:                 THIS.pgf_4c_Paginas.ActivePage = 2
3240:                 loc_oPage2.cnt_4c_Salva.Visible = .F.
3241:             ENDCASE
3242: 
3243:             THIS.HabilitarCampos(loc_lEdicao)
3244:             THIS.this_cModoAtual = par_cModo
3245:         CATCH TO loc_oErro
3246:             MsgErro("Erro em Formpag.AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
3247:         ENDTRY
3248:     ENDPROC
3249: 
3250:     *==========================================================================
3251:     PROCEDURE CarregarLista()
3252:     *==========================================================================
3253:         LOCAL loc_lResultado
3254:         loc_lResultado = .F.
3255: 
3256:         TRY
3257:             IF THIS.this_oBusinessObject.Buscar("")
3258:                 IF USED("cursor_4c_Dados")
3259:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
3260:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
3261:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
3262:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
3263:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
3264:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
3265:                 ENDIF
3266:                 loc_lResultado = .T.
3267:             ENDIF
3268:         CATCH TO loc_oErro
3269:             MsgErro("Erro em Formpag.CarregarLista: " + loc_oErro.Message, "Erro")
3270:         ENDTRY
3271: 
3272:         RETURN loc_lResultado
3273:     ENDPROC
3274: 
3275:     *==========================================================================
3276:     PROCEDURE BtnIncluirClick()
3277:     *==========================================================================
3278:         LOCAL loc_lResultado
3279:         loc_lResultado = .F.
3280: 
3281:         TRY
3282:             THIS.LimparCampos()
3283:             THIS.this_oBusinessObject.this_lNovoRegistro = .T.
3284:             THIS.AjustarBotoesPorModo("INCLUIR")
3285:             loc_lResultado = .T.
3286:         CATCH TO loc_oErro
3287:             MsgErro("Erro em Formpag.BtnIncluirClick: " + loc_oErro.Message, "Erro")
3288:         ENDTRY
3289: 
3290:         RETURN loc_lResultado
3291:     ENDPROC
3292: 
3293:     *==========================================================================
3294:     PROCEDURE BtnVisualizarClick()
3295:     *==========================================================================
3296:         LOCAL loc_lResultado, loc_cCodigo
3297:         loc_lResultado = .F.
3298: 
3299:         TRY
3300:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
3301:                 MsgAviso("Selecione um registro para visualizar.", "Aviso")
3302:             ELSE
3303:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
3304:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3305:                     THIS.BOParaForm()
3306:                     THIS.AjustarBotoesPorModo("VISUALIZAR")
3307:                     loc_lResultado = .T.
3308:                 ENDIF
3309:             ENDIF
3310:         CATCH TO loc_oErro
3311:             MsgErro("Erro em Formpag.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
3312:         ENDTRY
3313: 
3314:         RETURN loc_lResultado
3315:     ENDPROC
3316: 
3317:     *==========================================================================
3318:     PROCEDURE BtnAlterarClick()
3319:     *==========================================================================
3320:         LOCAL loc_lResultado, loc_cCodigo
3321:         loc_lResultado = .F.
3322: 
3323:         TRY
3324:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
3325:                 MsgAviso("Selecione um registro para alterar.", "Aviso")
3326:             ELSE
3327:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
3328:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3329:                     THIS.BOParaForm()
3330:                     THIS.AjustarBotoesPorModo("ALTERAR")
3331:                     loc_lResultado = .T.
3332:                 ENDIF
3333:             ENDIF
3334:         CATCH TO loc_oErro
3335:             MsgErro("Erro em Formpag.BtnAlterarClick: " + loc_oErro.Message, "Erro")
3336:         ENDTRY
3337: 
3338:         RETURN loc_lResultado
3339:     ENDPROC
3340: 
3341:     *==========================================================================
3342:     PROCEDURE BtnExcluirClick()
3343:     *==========================================================================
3344:         LOCAL loc_lResultado, loc_cCodigo
3345:         loc_lResultado = .F.
3346: 
3347:         TRY
3348:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
3349:                 MsgAviso("Selecione um registro para excluir.", "Aviso")
3350:             ELSE
3351:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
3352:                 IF MsgConfirma("Deseja excluir a condi" + CHR(231) + CHR(227) + "o '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
3353:                     IF THIS.this_oBusinessObject.Excluir(loc_cCodigo)
3354:                         THIS.CarregarLista()
3355:                         loc_lResultado = .T.
3356:                     ENDIF
3357:                 ENDIF
3358:             ENDIF
3359:         CATCH TO loc_oErro
3360:             MsgErro("Erro em Formpag.BtnExcluirClick: " + loc_oErro.Message, "Erro")
3361:         ENDTRY
3362: 
3363:         RETURN loc_lResultado
3364:     ENDPROC
3365: 
3366:     *==========================================================================
3367:     PROCEDURE BtnBuscarClick()
3368:     *==========================================================================
3369:         LOCAL loc_lResultado, loc_oBusca, loc_cCodigo, loc_cSQL
3370:         loc_lResultado = .F.
3371: 
3372:         TRY
3373:             && Pattern A: SQL no caller
3374:             IF USED("cursor_4c_Busca")
3375:                 USE IN cursor_4c_Busca
3376:             ENDIF
3377: 
3378:             loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
3379:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca") < 0
3380:                 SET NULL ON
3381:                 CREATE CURSOR cursor_4c_Busca (fpags C(12), descrs C(30))
3382:                 SET NULL OFF
3383:             ENDIF
3384: 
3385:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3386:             IF VARTYPE(loc_oBusca) = "O"
3387:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
3388:                 loc_oBusca.DefinirCursor("cursor_4c_Busca", "fpags", "descrs", "Busca de Condi" + CHR(231) + CHR(245) + "es de Pagamento")
3389:                 loc_oBusca.Mostrar()
3390: 
3391:                 loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3392:                 IF !EMPTY(loc_cCodigo)
3393:                     THIS.this_oBusinessObject.Buscar("fpags = '" + loc_cCodigo + "'")
3394:                     IF USED("cursor_4c_Dados")
3395:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
3396:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
3397:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
3398:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
3399:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
3400:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
3401:                     ENDIF
3402:                     loc_lResultado = .T.
3403:                 ENDIF
3404:             ENDIF
3405: 
3406:             IF USED("cursor_4c_Busca")
3407:                 USE IN cursor_4c_Busca
3408:             ENDIF
3409:         CATCH TO loc_oErro
3410:             MsgErro("Erro em Formpag.BtnBuscarClick: " + loc_oErro.Message, "Erro")
3411:             IF USED("cursor_4c_Busca")
3412:                 USE IN cursor_4c_Busca
3413:             ENDIF
3414:         ENDTRY
3415: 
3416:         RETURN loc_lResultado
3417:     ENDPROC
3418: 
3419:     *==========================================================================
3420:     PROCEDURE BtnSalvarClick()
3421:     *==========================================================================
3422:         LOCAL loc_lResultado
3423:         loc_lResultado = .F.
3424: 
3425:         TRY
3426:             THIS.FormParaBO()
3427: 
3428:             IF THIS.this_oBusinessObject.this_lNovoRegistro
3429:                 loc_lResultado = THIS.this_oBusinessObject.Inserir()
3430:             ELSE
3431:                 loc_lResultado = THIS.this_oBusinessObject.Atualizar()
3432:             ENDIF
3433: 
3434:             IF loc_lResultado
3435:                 THIS.CarregarLista()
3436:                 THIS.AjustarBotoesPorModo("LISTA")
3437:             ENDIF
3438:         CATCH TO loc_oErro
3439:             MsgErro("Erro em Formpag.BtnSalvarClick: " + loc_oErro.Message, "Erro")
3440:         ENDTRY
3441: 
3442:         RETURN loc_lResultado
3443:     ENDPROC
3444: 
3445:     *==========================================================================
3446:     PROCEDURE BtnCancelarClick()
3447:     *==========================================================================
3448:         TRY
3449:             THIS.AjustarBotoesPorModo("LISTA")
3450:         CATCH TO loc_oErro
3451:             MsgErro("Erro em Formpag.BtnCancelarClick: " + loc_oErro.Message, "Erro")
3452:         ENDTRY
3453:     ENDPROC
3454: 
3455:     *==========================================================================
3456:     PROCEDURE BtnEncerrarClick()
3457:     *==========================================================================
3458:         TRY
3459:             THIS.Release()
3460:         CATCH TO loc_oErro
3461:             MsgErro("Erro em Formpag.BtnEncerrarClick: " + loc_oErro.Message, "Erro")
3462:         ENDTRY
3463:     ENDPROC
3464: 
3465:     *==========================================================================
3466:     PROCEDURE BtnExportarClick()
3467:     *==========================================================================
3468:         TRY
3469:             MsgAviso("Funcionalidade de exportar XML n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
3470:         CATCH TO loc_oErro
3471:             MsgErro("Erro em Formpag.BtnExportarClick: " + loc_oErro.Message, "Erro")
3472:         ENDTRY
3473:     ENDPROC
3474: 
3475:     *==========================================================================
3476:     PROCEDURE BtnImportarClick()
3477:     *==========================================================================
3478:         TRY
3479:             MsgAviso("Funcionalidade de importar XML n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
3480:         CATCH TO loc_oErro
3481:             MsgErro("Erro em Formpag.BtnImportarClick: " + loc_oErro.Message, "Erro")
3482:         ENDTRY
3483:     ENDPROC
3484: 
3485:     *==========================================================================
3486:     PROCEDURE BtnCopiarClick()
3487:     *==========================================================================
3488:         LOCAL loc_lResultado, loc_cCodOrigem, loc_cCodDestino, loc_cSQL, loc_nResult
3489:         loc_lResultado = .F.
3490: 
3491:         TRY
3492:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
3493:                 MsgAviso("Selecione um registro de origem para copiar.", "Aviso")
3494:             ELSE
3495:                 loc_cCodOrigem  = ALLTRIM(cursor_4c_Dados.fpags)
3496:                 loc_cCodDestino = INPUTBOX("Digite o c" + CHR(243) + "digo da nova condi" + CHR(231) + CHR(227) + "o:", "Copiar Condi" + CHR(231) + CHR(227) + "o", "")
3497: 
3498:                 IF !EMPTY(ALLTRIM(loc_cCodDestino))
3499:                     loc_cCodDestino = ALLTRIM(loc_cCodDestino)
3500: 
3501:                     && Verificar se destino ja existe
3502:                     loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodDestino)
3503:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerDest") >= 0
3504:                         IF cursor_4c_VerDest.qtd > 0
3505:                             MsgAviso("C" + CHR(243) + "digo '" + loc_cCodDestino + "' j" + CHR(225) + " existe.")
3506:                             IF USED("cursor_4c_VerDest")
3507:                                 USE IN cursor_4c_VerDest
3508:                             ENDIF
3509:                         ELSE
3510:                             IF USED("cursor_4c_VerDest")
3511:                                 USE IN cursor_4c_VerDest
3512:                             ENDIF
3513: 
3514:                             && Copiar registro
3515:                             loc_cSQL = "INSERT INTO SigOpFp SELECT " + ;
3516:                                        EscaparSQL(loc_cCodDestino) + ", descrs, titfpags, formas, moefpgs, " + ;
3517:                                        "infos, situas, codfpags, nfpags, modpagto, grupods, contads, dcontads, " + ;
3518:                                        "orides, grupoos, contaos, dcontaos, grupobs, contabs, grupots, contats, " + ;
3519:                                        "bancos, agencias, ncontas, tvens, carauts, coldados, hists, ccupomnvs, " + ;
3520:                                        "operautos, operacaoss, operacaoes, cpictures, garantias, lcartao, lsaque, " + ;
3521:                                        "opers, parcs, autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, " + ;
3522:                                        "adquirente, emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
3523:                                        "mfinancs, datatrans, aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, " + ;
3524:                                        "emichqs, encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, " + ;
3525:                                        "valpends, impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, " + ;
3526:                                        "gavetas, tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
3527:                                        "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
3528:                                        "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, cnidtefs, " + ;
3529:                                        "detfecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, chklimcre, relsomsub, " + ;
3530:                                        "chkvalgar, chknccmov, arredonda, chkcachbk, chkuticach, autoriza, blqvctopar, " + ;
3531:                                        "vlrminpar, vlrlimfpgs, optcredcta, relmetvend " + ;
3532:                                        "FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodOrigem)
3533: 
3534:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3535:                             IF loc_nResult >= 0
3536:                                 THIS.CarregarLista()
3537:                                 MsgInfo("Condi" + CHR(231) + CHR(227) + "o '" + loc_cCodOrigem + "' copiada para '" + loc_cCodDestino + "'.", "Sucesso")
3538:                                 loc_lResultado = .T.
3539:                             ELSE
3540:                                 MsgErro("Erro ao copiar: " + CapturarErroSQL(), "Erro SQL")
3541:                             ENDIF
3542:                         ENDIF
3543:                     ELSE
3544:                         MsgErro("Erro ao verificar destino: " + CapturarErroSQL(), "Erro SQL")
3545:                     ENDIF

*-- Linhas 3553 a 3611:
3553:     ENDPROC
3554: 
3555:     *==========================================================================
3556:     PROCEDURE BtnMinimoClick()
3557:     *==========================================================================
3558:         TRY
3559:             MsgAviso("Funcionalidade de configurar m" + CHR(237) + "nimo n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
3560:         CATCH TO loc_oErro
3561:             MsgErro("Erro em Formpag.BtnMinimoClick: " + loc_oErro.Message, "Erro")
3562:         ENDTRY
3563:     ENDPROC
3564: 
3565:     *==========================================================================
3566:     PROCEDURE BtnDescontoClick()
3567:     *==========================================================================
3568:         TRY
3569:             MsgAviso("Funcionalidade de desconto n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
3570:         CATCH TO loc_oErro
3571:             MsgErro("Erro em Formpag.BtnDescontoClick: " + loc_oErro.Message, "Erro")
3572:         ENDTRY
3573:     ENDPROC
3574: 
3575:     *==========================================================================
3576:     PROCEDURE BtnBINClick()
3577:     *==========================================================================
3578:         TRY
3579:             MsgAviso("Funcionalidade BIN n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
3580:         CATCH TO loc_oErro
3581:             MsgErro("Erro em Formpag.BtnBINClick: " + loc_oErro.Message, "Erro")
3582:         ENDTRY
3583:     ENDPROC
3584: 
3585:     *==========================================================================
3586:     PROCEDURE Destroy()
3587:     *==========================================================================
3588:         TRY
3589:             IF USED("cursor_4c_Dados")
3590:                 USE IN cursor_4c_Dados
3591:             ENDIF
3592:             IF USED("cursor_4c_Carrega")
3593:                 USE IN cursor_4c_Carrega
3594:             ENDIF
3595:             IF USED("cursor_4c_Busca")
3596:                 USE IN cursor_4c_Busca
3597:             ENDIF
3598:             IF USED("cursor_4c_VerDest")
3599:                 USE IN cursor_4c_VerDest
3600:             ENDIF
3601:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3602:                 THIS.this_oBusinessObject = .NULL.
3603:             ENDIF
3604:         CATCH TO loc_oErro
3605:             MsgErro("Erro em Formpag.Destroy: " + loc_oErro.Message, "Erro")
3606:         ENDTRY
3607: 
3608:         DODEFAULT()
3609:     ENDPROC
3610: 
3611: ENDDEFINE


### BO (C:\4c\projeto\app\classes\pagBO.prg):
*==============================================================================
* pagBO.prg - Business Object para Condicoes de Pagamento
* Tabela principal: SigOpFp
* Chave primaria  : fpags char(12)
* Tabelas filhas  : SigOpFpI (fpags), SigOpFpP (fpags)
*==============================================================================

DEFINE CLASS pagBO AS BusinessBase

    *-- Chave primaria
    this_cFpags         = ""   && char(12) fpags

    *-- Identificacao basica
    this_cDescrs        = ""   && char(30)  descrs
    this_cTitfpags      = ""   && char(30)  titfpags
    this_cFormas        = ""   && char(12)  formas
    this_cMoefpgs       = ""   && char(3)   moefpgs
    this_cInfos         = ""   && char(1)   infos
    this_cSituas        = ""   && char(1)   situas
    this_cCodfpags      = ""   && char(2)   codfpags
    this_nNfpags        = 0    && numeric(2,0) nfpags
    this_cModpagto      = ""   && char(10)  modpagto
    this_cGrupods       = ""   && char(10)  grupods
    this_cContads       = ""   && char(10)  contads
    this_cDcontads      = ""   && char(40)  dcontads
    this_nOrides        = 0    && numeric(1,0) orides
    this_cGrupoos       = ""   && char(10)  grupoos
    this_cContaos       = ""   && char(10)  contaos
    this_cDcontaos      = ""   && char(40)  dcontaos
    this_cGrupobs       = ""   && char(10)  grupobs
    this_cContabs       = ""   && char(10)  contabs
    this_cGrupots       = ""   && char(10)  grupots
    this_cContats       = ""   && char(10)  contats
    this_cBancos        = ""   && char(3)   bancos
    this_cAgencias      = ""   && char(4)   agencias
    this_cNcontas       = ""   && char(10)  ncontas
    this_cTvens         = ""   && char(1)   tvens
    this_cCarauts       = ""   && char(1)   carauts
    this_cColdados      = ""   && char(1)   coldados
    this_cHists         = ""   && char(30)  hists
    this_cCcupomnvs     = ""   && char(20)  ccupomnvs
    this_cOperautos     = ""   && char(12)  operautos
    this_cOperacaoss    = ""   && char(15)  operacaoss
    this_cOperacaoes    = ""   && char(15)  operacaoes
    this_cCpictures     = ""   && char(20)  cpictures
    this_cGarantias     = ""   && char(1)   garantias
    this_cLcartao       = ""   && char(1)   lcartao
    this_cLsaque        = ""   && char(1)   lsaque
    this_cOpers         = ""   && char(1)   opers
    this_cParcs         = ""   && char(1)   parcs
    this_cAutotef       = ""   && char(1)   autotef
    this_cTcdc          = ""   && char(1)   tcdc
    this_cPcheque       = ""   && char(45)  pcheque
    this_cDadchqs       = ""   && char(1)   dadchqs
    this_cCodestabs     = ""   && char(8)   codestabs
    this_cCitems        = ""   && char(11)  citems
    this_cDcarts        = ""   && char(30)  dcarts
    this_cAdquirente    = ""   && char(8)   adquirente
    this_cEmps          = ""   && char(3)   emps
    this_cParcfin       = ""   && char(2)   parcfin
    this_cParcini       = ""   && char(2)   parcini
    this_cBandeira      = ""   && char(20)  bandeira
    this_cCdcashback    = ""   && char(3)   cdcashback
    this_cEspecies      = ""   && char(6)   especies
    this_cGrupoemp      = ""   && char(15)  grupoemp
    this_cMfinancs      = ""   && memo       mfinancs
    this_dDatatrans     = {}   && datetime   datatrans (nullable)

    *-- Campos numericos
    this_nAprovas       = 0    && numeric(1,0)
    this_nItemobrigs    = 0    && numeric(1,0)
    this_nBxcomis       = 0    && numeric(1,0)
    this_nCpags         = 0    && numeric(2,0)
    this_nDesc2s        = 0    && numeric(5,2)
    this_nDescs         = 0    && numeric(5,2)
    this_nDias          = 0    && numeric(3,0)
    this_nEmichqs       = 0    && numeric(1,0)
    this_nEncargos      = 0    && numeric(5,2)
    this_nEntradas      = 0    && numeric(3,0)
    this_nFparcs        = 0    && numeric(2,0)
    this_nFpcomiss      = 0    && numeric(5,2)
    this_nImpbols       = 0    && numeric(1,0)
    this_nPrazos        = 0    && numeric(3,0)
    this_nTrocos        = 0    && numeric(1,0)
    this_nValpends      = 0    && numeric(1,0)
    this_nImpnotas      = 0    && numeric(1,0)
    this_nImpdups       = 0    && numeric(1,0)
    this_nObs           = 0    && numeric(1,0)
    this_nTphists       = 0    && numeric(1,0)
    this_nNcodfinzs     = 0    && numeric(2,0)
    this_nImpchqs       = 0    && numeric(1,0)
    this_nEmivales      = 0    && numeric(1,0)
    this_nGavetas       = 0    && numeric(1,0)
    this_nTpcheques     = 0    && numeric(1,0)
    this_nBaixas        = 0    && numeric(1,0)
    this_nBxcomchqs     = 0    && numeric(1,0)
    this_nAutenticas    = 0    && numeric(1,0)
    this_nMesfec        = 0    && numeric(1,0)
    this_nAcvchqs       = 0    && numeric(1,0)
    this_nAcumulas      = 0    && numeric(1,0)
    this_nPromos        = 0    && numeric(1,0)
    this_nAgcobs        = 0    && numeric(1,0)
    this_nTolfcxs       = 0    && numeric(5,2)
    this_nTpvencs       = 0    && numeric(1,0)
    this_nPvarias       = 0    && numeric(5,2)
    this_nIndices       = 0    && numeric(6,3)
    this_nLibcsens      = 0    && numeric(1,0)
    this_nImpcpchqs     = 0    && numeric(1,0)
    this_nBlqtabds      = 0    && numeric(1,0)
    this_nChkbins       = 0    && numeric(1,0)
    this_nChkfidels     = 0    && numeric(1,0)
    this_nNfinancs      = 0    && numeric(1,0)
    this_nOpcsnas       = 0    && numeric(1,0)
    this_nVlrfpgs       = 0    && numeric(11,2)
    this_nLiscongv      = 0    && numeric(1,0)
    this_nCnidtefs      = 0    && numeric(1,0)
    this_nDetFecCxs     = 0    && numeric(1,0)
    this_nTaxjuros      = 0    && numeric(8,4)
    this_nNdtcomis      = 0    && numeric(1,0)
    this_nChkcpf        = 0    && numeric(1,0)
    this_nLibctablq     = 0    && numeric(1,0)
    this_nNsu           = 0    && numeric(1,0)
    this_nChklimcre     = 0    && numeric(1,0)
    this_nRelsomsub     = 0    && numeric(1,0)
    this_nChkvalgar     = 0    && numeric(1,0)
    this_nChknccmov     = 0    && numeric(1,0)
    this_nArredonda     = 0    && numeric(1,0)
    this_nChkcachbk     = 0    && numeric(1,0)
    this_nChkuticach    = 0    && numeric(1,0)
    this_nAutoriza      = 0    && numeric(1,0)
    this_nBlqvctopar    = 0    && numeric(1,0)
    this_nVlrminpar     = 0    && numeric(11,2)
    this_nVlrlimfpgs    = 0    && numeric(12,2)
    this_nOptcredcta    = 0    && numeric(1,0)
    this_nRelmetvend    = 0    && numeric(1,0)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado    = DODEFAULT()
            THIS.this_cTabela     = "SigOpFp"
            THIS.this_cCampoChave = "fpags"
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Init: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cFpags)
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega cursor_4c_Dados para o grid
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT fpags, descrs, moefpgs, dias, tvens, infos, " + ;
                       "grupods, contads FROM SigOpFp ORDER BY fpags"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT fpags, descrs, moefpgs, dias, tvens, infos, " + ;
                           "grupods, contads FROM SigOpFp WHERE " + par_cFiltro + ;
                           " ORDER BY fpags"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        fpags   C(12), ;
                        descrs  C(30), ;
                        moefpgs C(3), ;
                        dias    N(3), ;
                        tvens   C(1), ;
                        infos   C(1), ;
                        grupods C(10), ;
                        contads C(10) )
                    SET NULL OFF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Buscar: " + loc_oErro.Message, "Erro")
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ( ;
                    fpags   C(12), ;
                    descrs  C(30), ;
                    moefpgs C(3), ;
                    dias    N(3), ;
                    tvens   C(1), ;
                    infos   C(1), ;
                    grupods C(10), ;
                    contads C(10) )
                SET NULL OFF
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo fpags
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cFpags)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpFp WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(par_cFpags))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cFpags), "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags        = TratarNulo(fpags,        "C")
            THIS.this_cDescrs       = TratarNulo(descrs,       "C")
            THIS.this_cTitfpags     = TratarNulo(titfpags,     "C")
            THIS.this_cFormas       = TratarNulo(formas,       "C")
            THIS.this_cMoefpgs      = TratarNulo(moefpgs,      "C")
            THIS.this_cInfos        = TratarNulo(infos,        "C")
            THIS.this_cSituas       = TratarNulo(situas,       "C")
            THIS.this_cCodfpags     = TratarNulo(codfpags,     "C")
            THIS.this_nNfpags       = TratarNulo(nfpags,       "N")
            THIS.this_cModpagto     = TratarNulo(modpagto,     "C")
            THIS.this_cGrupods      = TratarNulo(grupods,      "C")
            THIS.this_cContads      = TratarNulo(contads,      "C")
            THIS.this_cDcontads     = TratarNulo(dcontads,     "C")
            THIS.this_nOrides       = TratarNulo(orides,       "N")
            THIS.this_cGrupoos      = TratarNulo(grupoos,      "C")
            THIS.this_cContaos      = TratarNulo(contaos,      "C")
            THIS.this_cDcontaos     = TratarNulo(dcontaos,     "C")
            THIS.this_cGrupobs      = TratarNulo(grupobs,      "C")
            THIS.this_cContabs      = TratarNulo(contabs,      "C")
            THIS.this_cGrupots      = TratarNulo(grupots,      "C")
            THIS.this_cContats      = TratarNulo(contats,      "C")
            THIS.this_cBancos       = TratarNulo(bancos,       "C")
            THIS.this_cAgencias     = TratarNulo(agencias,     "C")
            THIS.this_cNcontas      = TratarNulo(ncontas,      "C")
            THIS.this_cTvens        = TratarNulo(tvens,        "C")
            THIS.this_cCarauts      = TratarNulo(carauts,      "C")
            THIS.this_cColdados     = TratarNulo(coldados,     "C")
            THIS.this_cHists        = TratarNulo(hists,        "C")
            THIS.this_cCcupomnvs    = TratarNulo(ccupomnvs,    "C")
            THIS.this_cOperautos    = TratarNulo(operautos,    "C")
            THIS.this_cOperacaoss   = TratarNulo(operacaoss,   "C")
            THIS.this_cOperacaoes   = TratarNulo(operacaoes,   "C")
            THIS.this_cCpictures    = TratarNulo(cpictures,    "C")
            THIS.this_cGarantias    = TratarNulo(garantias,    "C")
            THIS.this_cLcartao      = TratarNulo(lcartao,      "C")
            THIS.this_cLsaque       = TratarNulo(lsaque,       "C")
            THIS.this_cOpers        = TratarNulo(opers,        "C")
            THIS.this_cParcs        = TratarNulo(parcs,        "C")
            THIS.this_cAutotef      = TratarNulo(autotef,      "C")
            THIS.this_cTcdc         = TratarNulo(tcdc,         "C")
            THIS.this_cPcheque      = TratarNulo(pcheque,      "C")
            THIS.this_cDadchqs      = TratarNulo(dadchqs,      "C")
            THIS.this_cCodestabs    = TratarNulo(codestabs,    "C")
            THIS.this_cCitems       = TratarNulo(citems,       "C")
            THIS.this_cDcarts       = TratarNulo(dcarts,       "C")
            THIS.this_cAdquirente   = TratarNulo(adquirente,   "C")
            THIS.this_cEmps         = TratarNulo(emps,         "C")
            THIS.this_cParcfin      = TratarNulo(parcfin,      "C")
            THIS.this_cParcini      = TratarNulo(parcini,      "C")
            THIS.this_cBandeira     = TratarNulo(bandeira,     "C")
            THIS.this_cCdcashback   = TratarNulo(cdcashback,   "C")
            THIS.this_cEspecies     = TratarNulo(especies,     "C")
            THIS.this_cGrupoemp     = TratarNulo(grupoemp,     "C")
            THIS.this_cMfinancs     = TratarNulo(mfinancs,     "M")
            THIS.this_nAprovas      = TratarNulo(aprovas,      "N")
            THIS.this_nItemobrigs   = TratarNulo(itemobrigs,   "N")
            THIS.this_nBxcomis      = TratarNulo(bxcomis,      "N")
            THIS.this_nCpags        = TratarNulo(cpags,        "N")
            THIS.this_nDesc2s       = TratarNulo(desc2s,       "N")
            THIS.this_nDescs        = TratarNulo(descs,        "N")
            THIS.this_nDias         = TratarNulo(dias,         "N")
            THIS.this_nEmichqs      = TratarNulo(emichqs,      "N")
            THIS.this_nEncargos     = TratarNulo(encargos,     "N")
            THIS.this_nEntradas     = TratarNulo(entradas,     "N")
            THIS.this_nFparcs       = TratarNulo(fparcs,       "N")
            THIS.this_nFpcomiss     = TratarNulo(fpcomiss,     "N")
            THIS.this_nImpbols      = TratarNulo(impbols,      "N")
            THIS.this_nPrazos       = TratarNulo(prazos,       "N")
            THIS.this_nTrocos       = TratarNulo(trocos,       "N")
            THIS.this_nValpends     = TratarNulo(valpends,     "N")
            THIS.this_nImpnotas     = TratarNulo(impnotas,     "N")
            THIS.this_nImpdups      = TratarNulo(impdups,      "N")
            THIS.this_nObs          = TratarNulo(obs,          "N")
            THIS.this_nTphists      = TratarNulo(tphists,      "N")
            THIS.this_nNcodfinzs    = TratarNulo(ncodfinzs,    "N")
            THIS.this_nImpchqs      = TratarNulo(impchqs,      "N")
            THIS.this_nEmivales     = TratarNulo(emivales,     "N")
            THIS.this_nGavetas      = TratarNulo(gavetas,      "N")
            THIS.this_nTpcheques    = TratarNulo(tpcheques,    "N")
            THIS.this_nBaixas       = TratarNulo(baixas,       "N")
            THIS.this_nBxcomchqs    = TratarNulo(bxcomchqs,    "N")
            THIS.this_nAutenticas   = TratarNulo(autenticas,   "N")
            THIS.this_nMesfec       = TratarNulo(mesfec,       "N")
            THIS.this_nAcvchqs      = TratarNulo(acvchqs,      "N")
            THIS.this_nAcumulas     = TratarNulo(acumulas,     "N")
            THIS.this_nPromos       = TratarNulo(promos,       "N")
            THIS.this_nAgcobs       = TratarNulo(agcobs,       "N")
            THIS.this_nTolfcxs      = TratarNulo(tolfcxs,      "N")
            THIS.this_nTpvencs      = TratarNulo(tpvencs,      "N")
            THIS.this_nPvarias      = TratarNulo(pvarias,      "N")
            THIS.this_nIndices      = TratarNulo(indices,      "N")
            THIS.this_nLibcsens     = TratarNulo(libcsens,     "N")
            THIS.this_nImpcpchqs    = TratarNulo(impcpchqs,    "N")
            THIS.this_nBlqtabds     = TratarNulo(blqtabds,     "N")
            THIS.this_nChkbins      = TratarNulo(chkbins,      "N")
            THIS.this_nChkfidels    = TratarNulo(chkfidels,    "N")
            THIS.this_nNfinancs     = TratarNulo(nfinancs,     "N")
            THIS.this_nOpcsnas      = TratarNulo(opcsnas,      "N")
            THIS.this_nVlrfpgs      = TratarNulo(vlrfpgs,      "N")
            THIS.this_nLiscongv     = TratarNulo(liscongv,     "N")
            THIS.this_nCnidtefs     = TratarNulo(cnidtefs,     "N")
            THIS.this_nDetFecCxs    = TratarNulo(DetFecCxs,    "N")
            THIS.this_nTaxjuros     = TratarNulo(taxjuros,     "N")
            THIS.this_nNdtcomis     = TratarNulo(ndtcomis,     "N")
            THIS.this_nChkcpf       = TratarNulo(chkcpf,       "N")
            THIS.this_nLibctablq    = TratarNulo(libctablq,    "N")
            THIS.this_nNsu          = TratarNulo(nsu,          "N")
            THIS.this_nChklimcre    = TratarNulo(chklimcre,    "N")
            THIS.this_nRelsomsub    = TratarNulo(relsomsub,    "N")
            THIS.this_nChkvalgar    = TratarNulo(chkvalgar,    "N")
            THIS.this_nChknccmov    = TratarNulo(chknccmov,    "N")
            THIS.this_nArredonda    = TratarNulo(arredonda,    "N")
            THIS.this_nChkcachbk    = TratarNulo(chkcachbk,    "N")
            THIS.this_nChkuticach   = TratarNulo(chkuticach,   "N")
            THIS.this_nAutoriza     = TratarNulo(autoriza,     "N")
            THIS.this_nBlqvctopar   = TratarNulo(blqvctopar,   "N")
            THIS.this_nVlrminpar    = TratarNulo(vlrminpar,    "N")
            THIS.this_nVlrlimfpgs   = TratarNulo(vlrlimfpgs,   "N")
            THIS.this_nOptcredcta   = TratarNulo(optcredcta,   "N")
            THIS.this_nRelmetvend   = TratarNulo(relmetvend,   "N")

            *-- datatrans (datetime, nullable)
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDatatrans = {}
            ELSE
                THIS.this_dDatatrans = datatrans
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarInsercao - Valida campos obrigatorios antes de inserir/atualizar
    *==========================================================================
    FUNCTION ValidarInsercao()
    *==========================================================================
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cFpags))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cInfos))
            MsgAviso("Tipo n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMoefpgs))
            MsgAviso("Moeda n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cFormas))
            MsgAviso("Forma n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigOpFp
    *==========================================================================
    PROTECTED FUNCTION Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDatatrans
        loc_lSucesso = .F.

        IF !THIS.ValidarInsercao()
            RETURN .F.
        ENDIF

        TRY
            loc_cDatatrans = IIF(EMPTY(THIS.this_dDatatrans), "NULL", ;
                                 FormatarDataSQL(THIS.this_dDatatrans))

            loc_cSQL = "INSERT INTO SigOpFp (" + ;
                "fpags, descrs, titfpags, formas, moefpgs, infos, situas, codfpags, " + ;
                "nfpags, modpagto, grupods, contads, dcontads, orides, grupoos, contaos, " + ;
                "dcontaos, grupobs, contabs, grupots, contats, bancos, agencias, ncontas, " + ;
                "tvens, carauts, coldados, hists, ccupomnvs, operautos, operacaoss, " + ;
                "operacaoes, cpictures, garantias, lcartao, lsaque, opers, parcs, " + ;
                "autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, adquirente, " + ;
                "emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
                "mfinancs, datatrans, " + ;
                "aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, emichqs, " + ;
                "encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, valpends, " + ;
                "impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, gavetas, " + ;
                "tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
                "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
                "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, " + ;
                "cnidtefs, DetFecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, " + ;
                "chklimcre, relsomsub, chkvalgar, chknccmov, arredonda, chkcachbk, " + ;
                "chkuticach, autoriza, blqvctopar, vlrminpar, vlrlimfpgs, optcredcta, relmetvend" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cFpags)       + ", " + ;
                EscaparSQL(THIS.this_cDescrs)      + ", " + ;
                EscaparSQL(THIS.this_cTitfpags)    + ", " + ;
                EscaparSQL(THIS.this_cFormas)      + ", " + ;
                EscaparSQL(THIS.this_cMoefpgs)     + ", " + ;
                EscaparSQL(THIS.this_cInfos)       + ", " + ;
                EscaparSQL(THIS.this_cSituas)      + ", " + ;
                EscaparSQL(THIS.this_cCodfpags)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfpags)    + ", " + ;
                EscaparSQL(THIS.this_cModpagto)    + ", " + ;
                EscaparSQL(THIS.this_cGrupods)     + ", " + ;
                EscaparSQL(THIS.this_cContads)     + ", " + ;
                EscaparSQL(THIS.this_cDcontads)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrides)    + ", " + ;
                EscaparSQL(THIS.this_cGrupoos)     + ", " + ;
                EscaparSQL(THIS.this_cContaos)     + ", " + ;
                EscaparSQL(THIS.this_cDcontaos)    + ", " + ;
                EscaparSQL(THIS.this_cGrupobs)     + ", " + ;
                EscaparSQL(THIS.this_cContabs)     + ", " + ;
                EscaparSQL(THIS.this_cGrupots)     + ", " + ;
                EscaparSQL(THIS.this_cContats)     + ", " + ;
                EscaparSQL(THIS.this_cBancos)      + ", " + ;
                EscaparSQL(THIS.this_cAgencias)    + ", " + ;
                EscaparSQL(THIS.this_cNcontas)     + ", " + ;
                EscaparSQL(THIS.this_cTvens)       + ", " + ;
                EscaparSQL(THIS.this_cCarauts)     + ", " + ;
                EscaparSQL(THIS.this_cColdados)    + ", " + ;
                EscaparSQL(THIS.this_cHists)       + ", " + ;
                EscaparSQL(THIS.this_cCcupomnvs)   + ", " + ;
                EscaparSQL(THIS.this_cOperautos)   + ", " + ;
                EscaparSQL(THIS.this_cOperacaoss)  + ", " + ;
                EscaparSQL(THIS.this_cOperacaoes)  + ", " + ;
                EscaparSQL(THIS.this_cCpictures)   + ", " + ;
                EscaparSQL(THIS.this_cGarantias)   + ", " + ;
                EscaparSQL(THIS.this_cLcartao)     + ", " + ;
                EscaparSQL(THIS.this_cLsaque)      + ", " + ;
                EscaparSQL(THIS.this_cOpers)       + ", " + ;
                EscaparSQL(THIS.this_cParcs)       + ", " + ;
                EscaparSQL(THIS.this_cAutotef)     + ", " + ;
                EscaparSQL(THIS.this_cTcdc)        + ", " + ;
                EscaparSQL(THIS.this_cPcheque)     + ", " + ;
                EscaparSQL(THIS.this_cDadchqs)     + ", " + ;
                EscaparSQL(THIS.this_cCodestabs)   + ", " + ;
                EscaparSQL(THIS.this_cCitems)      + ", " + ;
                EscaparSQL(THIS.this_cDcarts)      + ", " + ;
                EscaparSQL(THIS.this_cAdquirente)  + ", " + ;
                EscaparSQL(THIS.this_cEmps)        + ", " + ;
                EscaparSQL(THIS.this_cParcfin)     + ", " + ;
                EscaparSQL(THIS.this_cParcini)     + ", " + ;
                EscaparSQL(THIS.this_cBandeira)    + ", " + ;
                EscaparSQL(THIS.this_cCdcashback)  + ", " + ;
                EscaparSQL(THIS.this_cEspecies)    + ", " + ;
                EscaparSQL(THIS.this_cGrupoemp)    + ", " + ;
                EscaparSQL(THIS.this_cMfinancs)    + ", " + ;
                loc_cDatatrans                          + ", " + ;
                FormatarNumeroSQL(THIS.this_nAprovas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nItemobrigs)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nBxcomis)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nCpags)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesc2s)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nDescs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nDias)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmichqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nEncargos)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nEntradas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nFparcs)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nFpcomiss)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrazos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nTrocos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValpends)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpnotas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpdups)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nObs)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTphists)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcodfinzs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpchqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmivales)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nGavetas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpcheques) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaixas)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nBxcomchqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutenticas)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nMesfec)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAcvchqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAcumulas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nPromos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgcobs)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nTolfcxs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpvencs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvarias)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndices)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibcsens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpcpchqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqtabds)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkbins)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkfidels) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfinancs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpcsnas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrfpgs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nLiscongv)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nCnidtefs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nDetFecCxs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTaxjuros)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdtcomis)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkcpf)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibctablq) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNsu)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nChklimcre) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRelsomsub) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkvalgar) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChknccmov) + ", " + ;
                FormatarNumeroSQL(THIS.this_nArredonda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkcachbk) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkuticach)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nAutoriza)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqvctopar)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrminpar) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrlimfpgs)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nOptcredcta)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nRelmetvend)+ ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Inserir: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigOpFp
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDatatrans
        loc_lSucesso = .F.

        IF !THIS.ValidarInsercao()
            RETURN .F.
        ENDIF

        TRY
            loc_cDatatrans = IIF(EMPTY(THIS.this_dDatatrans), "NULL", ;
                                 FormatarDataSQL(THIS.this_dDatatrans))

            loc_cSQL = "UPDATE SigOpFp SET " + ;
                "descrs = "       + EscaparSQL(THIS.this_cDescrs)     + ", " + ;
                "titfpags = "     + EscaparSQL(THIS.this_cTitfpags)   + ", " + ;
                "formas = "       + EscaparSQL(THIS.this_cFormas)     + ", " + ;
                "moefpgs = "      + EscaparSQL(THIS.this_cMoefpgs)    + ", " + ;
                "infos = "        + EscaparSQL(THIS.this_cInfos)      + ", " + ;
                "situas = "       + EscaparSQL(THIS.this_cSituas)     + ", " + ;
                "codfpags = "     + EscaparSQL(THIS.this_cCodfpags)   + ", " + ;
                "nfpags = "       + FormatarNumeroSQL(THIS.this_nNfpags)    + ", " + ;
                "modpagto = "     + EscaparSQL(THIS.this_cModpagto)   + ", " + ;
                "grupods = "      + EscaparSQL(THIS.this_cGrupods)    + ", " + ;
                "contads = "      + EscaparSQL(THIS.this_cContads)    + ", " + ;
                "dcontads = "     + EscaparSQL(THIS.this_cDcontads)   + ", " + ;
                "orides = "       + FormatarNumeroSQL(THIS.this_nOrides)    + ", " + ;
                "grupoos = "      + EscaparSQL(THIS.this_cGrupoos)    + ", " + ;
                "contaos = "      + EscaparSQL(THIS.this_cContaos)    + ", " + ;
                "dcontaos = "     + EscaparSQL(THIS.this_cDcontaos)   + ", " + ;
                "grupobs = "      + EscaparSQL(THIS.this_cGrupobs)    + ", " + ;
                "contabs = "      + EscaparSQL(THIS.this_cContabs)    + ", " + ;
                "grupots = "      + EscaparSQL(THIS.this_cGrupots)    + ", " + ;
                "contats = "      + EscaparSQL(THIS.this_cContats)    + ", " + ;
                "bancos = "       + EscaparSQL(THIS.this_cBancos)     + ", " + ;
                "agencias = "     + EscaparSQL(THIS.this_cAgencias)   + ", " + ;
                "ncontas = "      + EscaparSQL(THIS.this_cNcontas)    + ", " + ;
                "tvens = "        + EscaparSQL(THIS.this_cTvens)      + ", " + ;
                "carauts = "      + EscaparSQL(THIS.this_cCarauts)    + ", " + ;
                "coldados = "     + EscaparSQL(THIS.this_cColdados)   + ", " + ;
                "hists = "        + EscaparSQL(THIS.this_cHists)      + ", " + ;
                "ccupomnvs = "    + EscaparSQL(THIS.this_cCcupomnvs)  + ", " + ;
                "operautos = "    + EscaparSQL(THIS.this_cOperautos)  + ", " + ;
                "operacaoss = "   + EscaparSQL(THIS.this_cOperacaoss) + ", " + ;
                "operacaoes = "   + EscaparSQL(THIS.this_cOperacaoes) + ", " + ;
                "cpictures = "    + EscaparSQL(THIS.this_cCpictures)  + ", " + ;
                "garantias = "    + EscaparSQL(THIS.this_cGarantias)  + ", " + ;
                "lcartao = "      + EscaparSQL(THIS.this_cLcartao)    + ", " + ;
                "lsaque = "       + EscaparSQL(THIS.this_cLsaque)     + ", " + ;
                "opers = "        + EscaparSQL(THIS.this_cOpers)      + ", " + ;
                "parcs = "        + EscaparSQL(THIS.this_cParcs)      + ", " + ;
                "autotef = "      + EscaparSQL(THIS.this_cAutotef)    + ", " + ;
                "tcdc = "         + EscaparSQL(THIS.this_cTcdc)       + ", " + ;
                "pcheque = "      + EscaparSQL(THIS.this_cPcheque)    + ", " + ;
                "dadchqs = "      + EscaparSQL(THIS.this_cDadchqs)    + ", " + ;
                "codestabs = "    + EscaparSQL(THIS.this_cCodestabs)  + ", " + ;
                "citems = "       + EscaparSQL(THIS.this_cCitems)     + ", " + ;
                "dcarts = "       + EscaparSQL(THIS.this_cDcarts)     + ", " + ;
                "adquirente = "   + EscaparSQL(THIS.this_cAdquirente) + ", " + ;
                "emps = "         + EscaparSQL(THIS.this_cEmps)       + ", " + ;
                "parcfin = "      + EscaparSQL(THIS.this_cParcfin)    + ", " + ;
                "parcini = "      + EscaparSQL(THIS.this_cParcini)    + ", " + ;
                "bandeira = "     + EscaparSQL(THIS.this_cBandeira)   + ", " + ;
                "cdcashback = "   + EscaparSQL(THIS.this_cCdcashback) + ", " + ;
                "especies = "     + EscaparSQL(THIS.this_cEspecies)   + ", " + ;
                "grupoemp = "     + EscaparSQL(THIS.this_cGrupoemp)   + ", " + ;
                "mfinancs = "     + EscaparSQL(THIS.this_cMfinancs)   + ", " + ;
                "datatrans = "    + loc_cDatatrans                         + ", " + ;
                "aprovas = "      + FormatarNumeroSQL(THIS.this_nAprovas)  + ", " + ;
                "itemobrigs = "   + FormatarNumeroSQL(THIS.this_nItemobrigs) + ", " + ;
                "bxcomis = "      + FormatarNumeroSQL(THIS.this_nBxcomis)  + ", " + ;
                "cpags = "        + FormatarNumeroSQL(THIS.this_nCpags)    + ", " + ;
                "desc2s = "       + FormatarNumeroSQL(THIS.this_nDesc2s)   + ", " + ;
                "descs = "        + FormatarNumeroSQL(THIS.this_nDescs)    + ", " + ;
                "dias = "         + FormatarNumeroSQL(THIS.this_nDias)     + ", " + ;
                "emichqs = "      + FormatarNumeroSQL(THIS.this_nEmichqs)  + ", " + ;
                "encargos = "     + FormatarNumeroSQL(THIS.this_nEncargos) + ", " + ;
                "entradas = "     + FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                "fparcs = "       + FormatarNumeroSQL(THIS.this_nFparcs)   + ", " + ;
                "fpcomiss = "     + FormatarNumeroSQL(THIS.this_nFpcomiss) + ", " + ;
                "impbols = "      + FormatarNumeroSQL(THIS.this_nImpbols)  + ", " + ;
                "prazos = "       + FormatarNumeroSQL(THIS.this_nPrazos)   + ", " + ;
                "trocos = "       + FormatarNumeroSQL(THIS.this_nTrocos)   + ", " + ;
                "valpends = "     + FormatarNumeroSQL(THIS.this_nValpends) + ", " + ;
                "impnotas = "     + FormatarNumeroSQL(THIS.this_nImpnotas) + ", " + ;
                "impdups = "      + FormatarNumeroSQL(THIS.this_nImpdups)  + ", " + ;
                "obs = "          + FormatarNumeroSQL(THIS.this_nObs)      + ", " + ;
                "tphists = "      + FormatarNumeroSQL(THIS.this_nTphists)  + ", " + ;
                "ncodfinzs = "    + FormatarNumeroSQL(THIS.this_nNcodfinzs)+ ", " + ;
                "impchqs = "      + FormatarNumeroSQL(THIS.this_nImpchqs)  + ", " + ;
                "emivales = "     + FormatarNumeroSQL(THIS.this_nEmivales) + ", " + ;
                "gavetas = "      + FormatarNumeroSQL(THIS.this_nGavetas)  + ", " + ;
                "tpcheques = "    + FormatarNumeroSQL(THIS.this_nTpcheques)+ ", " + ;
                "baixas = "       + FormatarNumeroSQL(THIS.this_nBaixas)   + ", " + ;
                "bxcomchqs = "    + FormatarNumeroSQL(THIS.this_nBxcomchqs)+ ", " + ;
                "autenticas = "   + FormatarNumeroSQL(THIS.this_nAutenticas)+ ", " + ;
                "mesfec = "       + FormatarNumeroSQL(THIS.this_nMesfec)   + ", " + ;
                "acvchqs = "      + FormatarNumeroSQL(THIS.this_nAcvchqs)  + ", " + ;
                "acumulas = "     + FormatarNumeroSQL(THIS.this_nAcumulas) + ", " + ;
                "promos = "       + FormatarNumeroSQL(THIS.this_nPromos)   + ", " + ;
                "agcobs = "       + FormatarNumeroSQL(THIS.this_nAgcobs)   + ", " + ;
                "tolfcxs = "      + FormatarNumeroSQL(THIS.this_nTolfcxs)  + ", " + ;
                "tpvencs = "      + FormatarNumeroSQL(THIS.this_nTpvencs)  + ", " + ;
                "pvarias = "      + FormatarNumeroSQL(THIS.this_nPvarias)  + ", " + ;
                "indices = "      + FormatarNumeroSQL(THIS.this_nIndices)  + ", " + ;
                "libcsens = "     + FormatarNumeroSQL(THIS.this_nLibcsens) + ", " + ;
                "impcpchqs = "    + FormatarNumeroSQL(THIS.this_nImpcpchqs)+ ", " + ;
                "blqtabds = "     + FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                "chkbins = "      + FormatarNumeroSQL(THIS.this_nChkbins)  + ", " + ;
                "chkfidels = "    + FormatarNumeroSQL(THIS.this_nChkfidels)+ ", " + ;
                "nfinancs = "     + FormatarNumeroSQL(THIS.this_nNfinancs) + ", " + ;
                "opcsnas = "      + FormatarNumeroSQL(THIS.this_nOpcsnas)  + ", " + ;
                "vlrfpgs = "      + FormatarNumeroSQL(THIS.this_nVlrfpgs)  + ", " + ;
                "liscongv = "     + FormatarNumeroSQL(THIS.this_nLiscongv) + ", " + ;
                "cnidtefs = "     + FormatarNumeroSQL(THIS.this_nCnidtefs) + ", " + ;
                "DetFecCxs = "    + FormatarNumeroSQL(THIS.this_nDetFecCxs)+ ", " + ;
                "taxjuros = "     + FormatarNumeroSQL(THIS.this_nTaxjuros) + ", " + ;
                "ndtcomis = "     + FormatarNumeroSQL(THIS.this_nNdtcomis) + ", " + ;
                "chkcpf = "       + FormatarNumeroSQL(THIS.this_nChkcpf)   + ", " + ;
                "libctablq = "    + FormatarNumeroSQL(THIS.this_nLibctablq)+ ", " + ;
                "nsu = "          + FormatarNumeroSQL(THIS.this_nNsu)      + ", " + ;
                "chklimcre = "    + FormatarNumeroSQL(THIS.this_nChklimcre)+ ", " + ;
                "relsomsub = "    + FormatarNumeroSQL(THIS.this_nRelsomsub)+ ", " + ;
                "chkvalgar = "    + FormatarNumeroSQL(THIS.this_nChkvalgar)+ ", " + ;
                "chknccmov = "    + FormatarNumeroSQL(THIS.this_nChknccmov)+ ", " + ;
                "arredonda = "    + FormatarNumeroSQL(THIS.this_nArredonda)+ ", " + ;
                "chkcachbk = "    + FormatarNumeroSQL(THIS.this_nChkcachbk)+ ", " + ;
                "chkuticach = "   + FormatarNumeroSQL(THIS.this_nChkuticach)+ ", " + ;
                "autoriza = "     + FormatarNumeroSQL(THIS.this_nAutoriza) + ", " + ;
                "blqvctopar = "   + FormatarNumeroSQL(THIS.this_nBlqvctopar)+ ", " + ;
                "vlrminpar = "    + FormatarNumeroSQL(THIS.this_nVlrminpar)+ ", " + ;
                "vlrlimfpgs = "   + FormatarNumeroSQL(THIS.this_nVlrlimfpgs)+ ", " + ;
                "optcredcta = "   + FormatarNumeroSQL(THIS.this_nOptcredcta)+ ", " + ;
                "relmetvend = "   + FormatarNumeroSQL(THIS.this_nRelmetvend)+ ;
                " WHERE fpags = " + EscaparSQL(THIS.this_cFpags)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Atualizar: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui o registro e suas filhas
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cFpags, loc_cSQLi, loc_cSQLp, loc_cSQLm
        LOCAL loc_nRi, loc_nRp, loc_nRm, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFpags = EscaparSQL(ALLTRIM(THIS.this_cFpags))

            *-- Exclui filha SigOpFpI
            loc_cSQLi = "DELETE FROM SigOpFpI WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelI")
                TABLEREVERT(.T., "cursor_4c_DelI")
                USE IN cursor_4c_DelI
            ENDIF

            loc_nRi = SQLEXEC(gnConnHandle, loc_cSQLi, "cursor_4c_DelI")
            IF USED("cursor_4c_DelI")
                USE IN cursor_4c_DelI
            ENDIF

            *-- Exclui filha SigOpFpP
            loc_cSQLp = "DELETE FROM SigOpFpP WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelP")
                TABLEREVERT(.T., "cursor_4c_DelP")
                USE IN cursor_4c_DelP
            ENDIF

            loc_nRp = SQLEXEC(gnConnHandle, loc_cSQLp, "cursor_4c_DelP")
            IF USED("cursor_4c_DelP")
                USE IN cursor_4c_DelP
            ENDIF

            *-- Exclui registro principal
            loc_cSQLm = "DELETE FROM SigOpFp WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelM")
                TABLEREVERT(.T., "cursor_4c_DelM")
                USE IN cursor_4c_DelM
            ENDIF

            loc_nRm = SQLEXEC(gnConnHandle, loc_cSQLm, "cursor_4c_DelM")
            IF USED("cursor_4c_DelM")
                USE IN cursor_4c_DelM
            ENDIF

            IF loc_nRm >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.ExecutarExclusao: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE

