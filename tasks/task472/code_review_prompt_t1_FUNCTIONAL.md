# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (33)
- [BINDEVENT-PARAMS] Handler 'ValidarAnoMtz' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarAnoMtz(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoMtz' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoMtz(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaMtz' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaMtz(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoedaMtz' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoedaMtz(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inativa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Jan.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fev.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mar.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Abr.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mai.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Jun.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Jul.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ago.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Set.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Out.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nov.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dez.Acum' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inativa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inativa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Check1' (parent: SIGCDMTZ.Pagina.Dados.grdSaldos.Column28): Top original=25 vs migrado 'chk_4c_Check1' Top=72 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Check1' (parent: SIGCDMTZ.Pagina.Dados.grdSaldos.Column28): Left original=31 vs migrado 'chk_4c_Check1' Left=440 (diff=409px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2298 linhas total):

*-- Linhas 30 a 163:
30:     this_cModoAtual      = "LISTA"
31: 
32:     *-- =========================================================================
33:     *-- INIT - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
34:     *-- =========================================================================
35: 
36:     PROCEDURE Init()
37:         LOCAL loc_lResultado
38:         loc_lResultado = .F.
39: 
40:         TRY
41:             loc_lResultado = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MsgErro(loc_oErro.Message, "Formmtz.Init")
44:         ENDTRY
45: 
46:         RETURN loc_lResultado
47:     ENDPROC
48: 
49:     *-- =========================================================================
50:     *-- INICIALIZAR FORM - Chamado pelo FormBase.Init()
51:     *-- =========================================================================
52: 
53:     PROTECTED PROCEDURE InicializarForm()
54:         LOCAL loc_lResultado
55:         loc_lResultado = .F.
56: 
57:         TRY
58:             *-- Instancia o Business Object
59:             THIS.this_oBusinessObject = CREATEOBJECT("mtzBO")
60: 
61:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
62:                 MsgErro("Erro ao instanciar mtzBO", "Formmtz.InicializarForm")
63:                 loc_lResultado = .F.
64:             ENDIF
65: 
66:             *-- Configura estrutura de paginas
67:             THIS.ConfigurarPageFrame()
68: 
69:             *-- Carrega lista inicial (pula se validando UI)
70:             IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
71:                 THIS.CarregarLista()
72:             ENDIF
73: 
74:             THIS.pgf_4c_Paginas.Visible = .T.
75:             THIS.pgf_4c_Paginas.ActivePage = 1
76:             THIS.this_cModoAtual = "LISTA"
77: 
78:             loc_lResultado = .T.
79: 
80:         CATCH TO loc_oErro
81:             MsgErro(loc_oErro.Message, "Formmtz.InicializarForm")
82:         ENDTRY
83: 
84:         RETURN loc_lResultado
85:     ENDPROC
86: 
87:     *-- =========================================================================
88:     *-- CONFIGURAR PAGE FRAME - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
89:     *-- =========================================================================
90: 
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:         *-- Cria PageFrame principal
93:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
94: 
95:         WITH THIS.pgf_4c_Paginas
96:             .PageCount  = 2
97:             .Top        = -29
98:             .Left       = 0
99:             .Width      = THIS.Width
100:             .Height     = THIS.Height + 29
101:             .Tabs       = .F.
102:             .Visible    = .T.
103: 
104:             *-- Imagens de fundo nas duas paginas
105:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107: 
108:             .Page1.Caption = "Lista"
109:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:             .Page2.Caption = "Dados"
111:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:         ENDWITH
113: 
114:         *-- Configura cada pagina
115:         THIS.ConfigurarPaginaLista()
116:         THIS.ConfigurarPaginaDados()
117:     ENDPROC
118: 
119:     *-- =========================================================================
120:     *-- CONFIGURAR PAGINA LISTA (Page1) - Cabecalho + Botoes CRUD + area grid
121:     *-- =========================================================================
122: 
123:     PROTECTED PROCEDURE ConfigurarPaginaLista()
124:         LOCAL loc_oPagina
125:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
126: 
127:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
128:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129: 
130:         *--------------------------------------------------------------------------
131:         *-- Container cabecalho (fundo escuro com titulo)
132:         *--------------------------------------------------------------------------
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 2
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = 80
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = "Matriz de Saldos por Centro de Custo"
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
160:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
161:             .Caption   = "Matriz de Saldos por Centro de Custo"
162:             .Top       = 18
163:             .Left      = 10

*-- Linhas 387 a 444:
387:         ENDWITH
388: 
389:         *-- Vincular eventos da Page1
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
396: 
397:         THIS.TornarControlesVisiveis(loc_oPagina)
398:     ENDPROC
399: 
400:     *-- =========================================================================
401:     *-- CONFIGURAR PAGINA DADOS (Page2) - Cabecalho fields + Grid mensal + Botoes Salvar/Cancelar
402:     *-- =========================================================================
403: 
404:     PROTECTED PROCEDURE ConfigurarPaginaDados()
405:         LOCAL loc_oPagina
406:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
407: 
408:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
409:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
410: 
411:         *--------------------------------------------------------------------------
412:         *-- Container botoes Salvar/Cancelar (lado direito topo)
413:         *--------------------------------------------------------------------------
414:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
415:         WITH loc_oPagina.cnt_4c_BotoesAcao
416:             .Top         = 33
417:             .Left        = 842
418:             .Width       = 160
419:             .Height      = 85
420:             .BackStyle = 1
421:             .BackColor = RGB(255, 255, 255)
422:             .Visible     = .T.
423:         ENDWITH
424: 
425:         *-- Botao Confirmar (Salvar)
426:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
427:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
428:             .Caption         = "Confirmar"
429:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
430:             .PicturePosition = 13
431:             .Top             = 5
432:             .Left            = 5
433:             .Width           = 75
434:             .Height          = 75
435:             .FontName        = "Comic Sans MS"
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .FontSize        = 8
439:             .ForeColor       = RGB(90, 90, 90)
440:             .BackColor       = RGB(255, 255, 255)
441:             .Themes          = .F.
442:             .SpecialEffect   = 0
443:             .MousePointer    = 15
444:             .WordWrap        = .T.

*-- Linhas 1086 a 1531:
1086:         ENDWITH
1087: 
1088:         *-- Vincular eventos Page2 (botoes Salvar/Cancelar)
1089:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1090:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1091: 
1092:         *-- Vincular validacao/lookup campos header
1093:         BINDEVENT(loc_oPagina.txt_4c_Ano,    "KeyPress", THIS, "ValidarAnoMtz")
1094:         BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress", THIS, "ValidarGrupoMtz")
1095:         BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress", THIS, "ValidarContaMtz")
1096:         BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress", THIS, "ValidarMoedaMtz")
1097:         BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress",  THIS, "TeclaF4Sgrupo")
1098:         BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress",  THIS, "TeclaF4Sconta")
1099:         BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress",  THIS, "TeclaF4Moeda")
1100: 
1101:         *-- Vincular eventos da grade e botoes de linha
1102:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
1103:         BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha, "Click", THIS, "BtnInserirLinhaClick")
1104:         BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
1105: 
1106:         THIS.TornarControlesVisiveis(loc_oPagina)
1107:     ENDPROC
1108: 
1109:     *-- =========================================================================
1110:     *-- CARREGAR LISTA - Carrega cursor_4c_Dados no Grid da Page1
1111:     *-- =========================================================================
1112: 
1113:     PROCEDURE CarregarLista()
1114:         LOCAL loc_lResultado, loc_oGrid
1115:         loc_lResultado = .F.
1116: 
1117:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1118:             RETURN .T.
1119:         ENDIF
1120: 
1121:         TRY
1122:             IF THIS.this_oBusinessObject.Buscar("")
1123:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1124:                 loc_oGrid.ColumnCount = 7
1125:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
1126:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1127:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1128:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1129:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1130:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1131:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1132:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1133:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1134:                 loc_oGrid.Column2.Header1.Caption = "Ano"
1135:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1136:                 loc_oGrid.Column4.Header1.Caption = "Conta"
1137:                 loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1138:                 loc_oGrid.Column6.Header1.Caption = "Moeda"
1139:                 loc_oGrid.Column7.Header1.Caption = "Inativa"
1140:                 THIS.FormatarGridLista(loc_oGrid)
1141:                 loc_lResultado = .T.
1142:             ENDIF
1143: 
1144:         CATCH TO loc_oErro
1145:             MsgErro(loc_oErro.Message, "Formmtz.CarregarLista")
1146:             loc_lResultado = .F.
1147:         ENDTRY
1148: 
1149:         RETURN loc_lResultado
1150:     ENDPROC
1151: 
1152:     *-- =========================================================================
1153:     *-- ALTERNAR PAGINA - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
1154:     *-- =========================================================================
1155: 
1156:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1157:         LOCAL loc_lResultado
1158:         loc_lResultado = .F.
1159: 
1160:         IF VARTYPE(par_nPagina) # "N" OR par_nPagina < 1 OR par_nPagina > 2
1161:             RETURN .F.
1162:         ENDIF
1163: 
1164:         TRY
1165:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1166: 
1167:             IF par_nPagina = 1
1168:                 THIS.CarregarLista()
1169:             ENDIF
1170: 
1171:             loc_lResultado = .T.
1172: 
1173:         CATCH TO loc_oErro
1174:             MsgErro(loc_oErro.Message, "Formmtz.AlternarPagina")
1175:         ENDTRY
1176: 
1177:         RETURN loc_lResultado
1178:     ENDPROC
1179: 
1180:     *-- =========================================================================
1181:     *-- FORM PARA BO - Transfere dados do Form para o BO
1182:     *-- =========================================================================
1183: 
1184:     PROTECTED PROCEDURE FormParaBO()
1185:         LOCAL loc_oPagina, loc_lResultado
1186:         loc_lResultado = .F.
1187: 
1188:         TRY
1189:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1190: 
1191:             THIS.this_oBusinessObject.this_cCodigo   = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1192:             THIS.this_oBusinessObject.this_cAno      = ALLTRIM(loc_oPagina.txt_4c_Ano.Value)
1193:             THIS.this_oBusinessObject.this_cSGrupos  = ALLTRIM(loc_oPagina.txt_4c_Sgrupo.Value)
1194:             THIS.this_oBusinessObject.this_cSContas  = ALLTRIM(loc_oPagina.txt_4c_Sconta.Value)
1195:             THIS.this_oBusinessObject.this_cMoeda    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
1196:             THIS.this_oBusinessObject.this_lInativas = (loc_oPagina.chk_4c_Check1.Value = 1)
1197: 
1198:             loc_lResultado = .T.
1199: 
1200:         CATCH TO loc_oErro
1201:             MsgErro(loc_oErro.Message, "Formmtz.FormParaBO")
1202:         ENDTRY
1203: 
1204:         RETURN loc_lResultado
1205:     ENDPROC
1206: 
1207:     *-- =========================================================================
1208:     *-- BO PARA FORM - Transfere dados do BO para o Form
1209:     *-- =========================================================================
1210: 
1211:     PROTECTED PROCEDURE BOParaForm()
1212:         LOCAL loc_oPagina, loc_lResultado
1213:         loc_lResultado = .F.
1214: 
1215:         TRY
1216:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1217: 
1218:             loc_oPagina.txt_4c_Codigo.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1219:             loc_oPagina.txt_4c_Ano.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cAno)
1220:             loc_oPagina.txt_4c_Sgrupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cSGrupos)
1221:             loc_oPagina.txt_4c_Sconta.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cSContas)
1222:             loc_oPagina.txt_4c_Sdconta.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cSDesconta)
1223:             loc_oPagina.txt_4c_Moeda.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
1224:             loc_oPagina.chk_4c_Check1.Value    = THIS.this_oBusinessObject.this_lInativas
1225:             loc_oPagina.txt_4c_ValorTotal.Value = THIS.this_oBusinessObject.this_nValorTotal
1226: 
1227:             *-- Datas auditoria (readonly)
1228:             IF !EMPTY(THIS.this_oBusinessObject.this_tDtIncs)
1229:                 loc_oPagina.txt_4c_DtIncs.Value  = THIS.this_oBusinessObject.this_tDtIncs
1230:             ENDIF
1231:             IF !EMPTY(THIS.this_oBusinessObject.this_cUsuIncs)
1232:                 loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuIncs)
1233:             ENDIF
1234:             IF !EMPTY(THIS.this_oBusinessObject.this_tDtAlts)
1235:                 loc_oPagina.txt_4c_DataAlts.Value = THIS.this_oBusinessObject.this_tDtAlts
1236:             ENDIF
1237:             IF !EMPTY(THIS.this_oBusinessObject.this_cUsuAlts)
1238:                 loc_oPagina.txt_4c_UsuaAlts.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuAlts)
1239:             ENDIF
1240: 
1241:             loc_lResultado = .T.
1242: 
1243:         CATCH TO loc_oErro
1244:             MsgErro(loc_oErro.Message, "Formmtz.BOParaForm")
1245:         ENDTRY
1246: 
1247:         RETURN loc_lResultado
1248:     ENDPROC
1249: 
1250:     *-- =========================================================================
1251:     *-- LIMPAR CAMPOS - Zera todos os campos da Page2
1252:     *-- =========================================================================
1253: 
1254:     PROTECTED PROCEDURE LimparCampos()
1255:         LOCAL loc_oPagina
1256: 
1257:         TRY
1258:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1259: 
1260:             loc_oPagina.txt_4c_Codigo.Value     = ""
1261:             loc_oPagina.txt_4c_Ano.Value         = ""
1262:             loc_oPagina.txt_4c_Sgrupo.Value      = ""
1263:             loc_oPagina.txt_4c_Sconta.Value      = ""
1264:             loc_oPagina.txt_4c_Sdconta.Value     = ""
1265:             loc_oPagina.txt_4c_Moeda.Value       = ""
1266:             loc_oPagina.txt_4c_ValorTotal.Value  = 0
1267:             loc_oPagina.chk_4c_Check1.Value      = 0
1268:             loc_oPagina.txt_4c_DtIncs.Value      = {}
1269:             loc_oPagina.txt_4c_Usuario.Value     = ""
1270:             loc_oPagina.txt_4c_DataAlts.Value    = {}
1271:             loc_oPagina.txt_4c_UsuaAlts.Value    = ""
1272: 
1273:         CATCH TO loc_oErro
1274:             MsgErro(loc_oErro.Message, "Formmtz.LimparCampos")
1275:         ENDTRY
1276:     ENDPROC
1277: 
1278:     *-- =========================================================================
1279:     *-- HABILITAR CAMPOS - Habilita/desabilita campos editaveis por modo
1280:     *-- =========================================================================
1281: 
1282:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1283:         LOCAL loc_oPagina, loc_lEdicao
1284: 
1285:         TRY
1286:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1287:             loc_lEdicao = par_lHabilitar AND THIS.this_cModoAtual # "VISUALIZAR"
1288: 
1289:             *-- Codigo: editavel apenas no INCLUIR
1290:             loc_oPagina.txt_4c_Codigo.Enabled  = (THIS.this_cModoAtual = "INCLUIR")
1291:             loc_oPagina.txt_4c_Codigo.ReadOnly = (THIS.this_cModoAtual # "INCLUIR")
1292: 
1293:             *-- Campos editaveis em INCLUIR e ALTERAR
1294:             loc_oPagina.txt_4c_Ano.Enabled      = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1295:             loc_oPagina.txt_4c_Ano.ReadOnly     = !(THIS.this_cModoAtual = "INCLUIR")
1296:             loc_oPagina.txt_4c_Sgrupo.Enabled   = loc_lEdicao
1297:             loc_oPagina.txt_4c_Sgrupo.ReadOnly  = !loc_lEdicao
1298:             loc_oPagina.txt_4c_Sconta.Enabled   = loc_lEdicao
1299:             loc_oPagina.txt_4c_Sconta.ReadOnly  = !loc_lEdicao
1300:             loc_oPagina.txt_4c_Moeda.Enabled    = loc_lEdicao
1301:             loc_oPagina.txt_4c_Moeda.ReadOnly   = !loc_lEdicao
1302:             loc_oPagina.chk_4c_Check1.Enabled   = loc_lEdicao
1303: 
1304:             *-- Grade de saldos: editavel em INCLUIR e ALTERAR
1305:             IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
1306:                 loc_oPagina.grd_4c_Dados.ReadOnly = !loc_lEdicao
1307:             ENDIF
1308: 
1309:             *-- Botoes Confirmar/Cancelar
1310:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
1311:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
1312: 
1313:             *-- Campos readonly sempre
1314:             loc_oPagina.txt_4c_Sdconta.ReadOnly    = .T.
1315:             loc_oPagina.txt_4c_ValorTotal.ReadOnly = .T.
1316:             loc_oPagina.txt_4c_DtIncs.ReadOnly     = .T.
1317:             loc_oPagina.txt_4c_Usuario.ReadOnly     = .T.
1318:             loc_oPagina.txt_4c_DataAlts.ReadOnly   = .T.
1319:             loc_oPagina.txt_4c_UsuaAlts.ReadOnly   = .T.
1320: 
1321:         CATCH TO loc_oErro
1322:             MsgErro(loc_oErro.Message, "Formmtz.HabilitarCampos")
1323:         ENDTRY
1324:     ENDPROC
1325: 
1326:     *-- =========================================================================
1327:     *-- AJUSTAR BOTOES POR MODO
1328:     *-- =========================================================================
1329: 
1330:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1331:         LOCAL loc_oPagina
1332: 
1333:         TRY
1334:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1335:             IF THIS.this_cModoAtual = "VISUALIZAR"
1336:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1337:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1338:             ELSE
1339:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1340:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1341:             ENDIF
1342:         CATCH TO loc_oErro
1343:             MsgErro(loc_oErro.Message, "Formmtz.AjustarBotoesPorModo")
1344:         ENDTRY
1345:     ENDPROC
1346: 
1347:     *-- =========================================================================
1348:     *-- BTN INCLUIR CLICK
1349:     *-- =========================================================================
1350: 
1351:     PROCEDURE BtnIncluirClick()
1352:         LOCAL loc_lResultado
1353:         loc_lResultado = .F.
1354: 
1355:         TRY
1356:             IF !THIS.this_oBusinessObject.NovoRegistro()
1357:                 loc_lResultado = .F.
1358:             ELSE
1359:                 THIS.LimparCampos()
1360:                 THIS.this_cModoAtual = "INCLUIR"
1361:                 THIS.HabilitarCampos(.T.)
1362:                 THIS.AjustarBotoesPorModo()
1363:                 THIS.this_oBusinessObject.CriarCursorDetalheVazio(THIS.this_oBusinessObject.this_cCodigo)
1364:                 THIS.AlternarGradeDetalhe()
1365:                 THIS.AlternarPaginaDados()
1366:                 loc_lResultado = .T.
1367:             ENDIF
1368:         CATCH TO loc_oErro
1369:             MsgErro(loc_oErro.Message, "Formmtz.BtnIncluirClick")
1370:         ENDTRY
1371: 
1372:         RETURN loc_lResultado
1373:     ENDPROC
1374: 
1375:     *-- =========================================================================
1376:     *-- BTN VISUALIZAR CLICK
1377:     *-- =========================================================================
1378: 
1379:     PROCEDURE BtnVisualizarClick()
1380:         LOCAL loc_lResultado, loc_cCodigo
1381:         loc_lResultado = .F.
1382: 
1383:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1384:             MsgAviso("Nenhum registro selecionado.")
1385:             RETURN .F.
1386:         ENDIF
1387: 
1388:         TRY
1389:             SELECT cursor_4c_Dados
1390:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1391: 
1392:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1393:                 THIS.this_cModoAtual = "VISUALIZAR"
1394:                 THIS.BOParaForm()
1395:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1396:                 THIS.AlternarGradeDetalhe()
1397:                 THIS.HabilitarCampos(.F.)
1398:                 THIS.AjustarBotoesPorModo()
1399:                 THIS.AlternarPaginaDados()
1400:                 loc_lResultado = .T.
1401:             ENDIF
1402: 
1403:         CATCH TO loc_oErro
1404:             MsgErro(loc_oErro.Message, "Formmtz.BtnVisualizarClick")
1405:         ENDTRY
1406: 
1407:         RETURN loc_lResultado
1408:     ENDPROC
1409: 
1410:     *-- =========================================================================
1411:     *-- BTN ALTERAR CLICK
1412:     *-- =========================================================================
1413: 
1414:     PROCEDURE BtnAlterarClick()
1415:         LOCAL loc_lResultado, loc_cCodigo
1416:         loc_lResultado = .F.
1417: 
1418:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1419:             MsgAviso("Nenhum registro selecionado.")
1420:             RETURN .F.
1421:         ENDIF
1422: 
1423:         TRY
1424:             SELECT cursor_4c_Dados
1425:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1426: 
1427:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1428:                 THIS.this_oBusinessObject.EditarRegistro()
1429:                 THIS.this_cModoAtual = "ALTERAR"
1430:                 THIS.BOParaForm()
1431:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1432:                 THIS.AlternarGradeDetalhe()
1433:                 THIS.HabilitarCampos(.T.)
1434:                 THIS.AjustarBotoesPorModo()
1435:                 THIS.AlternarPaginaDados()
1436:                 loc_lResultado = .T.
1437:             ENDIF
1438: 
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "Formmtz.BtnAlterarClick")
1441:         ENDTRY
1442: 
1443:         RETURN loc_lResultado
1444:     ENDPROC
1445: 
1446:     *-- =========================================================================
1447:     *-- BTN EXCLUIR CLICK
1448:     *-- =========================================================================
1449: 
1450:     PROCEDURE BtnExcluirClick()
1451:         LOCAL loc_lResultado, loc_cCodigo
1452:         loc_lResultado = .F.
1453: 
1454:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1455:             MsgAviso("Nenhum registro selecionado.")
1456:             RETURN .F.
1457:         ENDIF
1458: 
1459:         SELECT cursor_4c_Dados
1460:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1461: 
1462:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Matriz " + loc_cCodigo + "?", "Excluir")
1463:             RETURN .F.
1464:         ENDIF
1465: 
1466:         TRY
1467:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1468:                 IF THIS.this_oBusinessObject.Excluir()
1469:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
1470:                     THIS.CarregarLista()
1471:                     loc_lResultado = .T.
1472:                 ENDIF
1473:             ENDIF
1474: 
1475:         CATCH TO loc_oErro
1476:             MsgErro(loc_oErro.Message, "Formmtz.BtnExcluirClick")
1477:         ENDTRY
1478: 
1479:         RETURN loc_lResultado
1480:     ENDPROC
1481: 
1482:     *-- =========================================================================
1483:     *-- BTN BUSCAR CLICK
1484:     *-- =========================================================================
1485: 
1486:     PROCEDURE BtnBuscarClick()
1487:         LOCAL loc_oBusca, loc_lResultado
1488:         loc_lResultado = .F.
1489: 
1490:         TRY
1491:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1492:                 "SigCdMtz", "cursor_4c_BuscaMtz", "Codigo", "", ;
1493:                 "Buscar Matriz de Saldos")
1494: 
1495:             IF VARTYPE(loc_oBusca) = "O"
1496:                 loc_oBusca.mAddColuna("Codigo", "", "C" + CHR(243) + "digo")
1497:                 loc_oBusca.mAddColuna("Ano",    "", "Ano")
1498:                 loc_oBusca.Show()
1499: 
1500:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
1501:                     SELECT cursor_4c_BuscaMtz
1502:                     IF !EOF()
1503:                         LOCAL loc_oGrid
1504:                         THIS.this_oBusinessObject.Buscar( ;
1505:                             "a.Codigo = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMtz.Codigo)))
1506:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1507:                         IF VARTYPE(loc_oGrid) = "O"
1508:                             loc_oGrid.ColumnCount = 7
1509:                             loc_oGrid.RecordSource            = "cursor_4c_Dados"
1510:                             loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1511:                             loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1512:                             loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1513:                             loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1514:                             loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1515:                             loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1516:                             loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1517:                             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1518:                             loc_oGrid.Column2.Header1.Caption = "Ano"
1519:                             loc_oGrid.Column3.Header1.Caption = "Grupo"
1520:                             loc_oGrid.Column4.Header1.Caption = "Conta"
1521:                             loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1522:                             loc_oGrid.Column6.Header1.Caption = "Moeda"
1523:                             loc_oGrid.Column7.Header1.Caption = "Inativa"
1524:                             THIS.FormatarGridLista(loc_oGrid)
1525:                         ENDIF
1526:                     ENDIF
1527:                 ENDIF
1528: 
1529:                 loc_oBusca.Release()
1530:                 loc_lResultado = .T.
1531:             ENDIF

*-- Linhas 1545 a 1668:
1545:     *-- BTN ENCERRAR CLICK
1546:     *-- =========================================================================
1547: 
1548:     PROCEDURE BtnEncerrarClick()
1549:         THIS.Release()
1550:     ENDPROC
1551: 
1552:     *-- =========================================================================
1553:     *-- BTN SALVAR CLICK
1554:     *-- =========================================================================
1555: 
1556:     PROCEDURE BtnSalvarClick()
1557:         LOCAL loc_lResultado
1558:         loc_lResultado = .F.
1559: 
1560:         *-- Validacoes fora do TRY (CLAUDE.md regra #1)
1561:         IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value))
1562:             MsgAviso("Ano de Compet" + CHR(234) + "ncia " + CHR(233) + " obrigat" + CHR(243) + "rio.")
1563:             THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
1564:             RETURN .F.
1565:         ENDIF
1566: 
1567:         IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value))
1568:             MsgAviso("Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
1569:             THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
1570:             RETURN .F.
1571:         ENDIF
1572: 
1573:         IF !THIS.this_oBusinessObject.ValidarDuplicatas()
1574:             RETURN .F.
1575:         ENDIF
1576: 
1577:         TRY
1578:             IF THIS.FormParaBO()
1579:                 IF THIS.this_oBusinessObject.Salvar()
1580:                     MsgInfo("Registro salvo com sucesso.")
1581:                     THIS.AlternarPagina(1)
1582:                     THIS.this_cModoAtual = "LISTA"
1583:                     loc_lResultado = .T.
1584:                 ENDIF
1585:             ENDIF
1586: 
1587:         CATCH TO loc_oErro
1588:             MsgErro(loc_oErro.Message, "Formmtz.BtnSalvarClick")
1589:         ENDTRY
1590: 
1591:         RETURN loc_lResultado
1592:     ENDPROC
1593: 
1594:     *-- =========================================================================
1595:     *-- BTN CANCELAR CLICK
1596:     *-- =========================================================================
1597: 
1598:     PROCEDURE BtnCancelarClick()
1599:         LOCAL loc_lResultado
1600:         loc_lResultado = .F.
1601: 
1602:         TRY
1603:             THIS.AlternarPagina(1)
1604:             THIS.this_cModoAtual = "LISTA"
1605:             THIS.CarregarLista()
1606:             loc_lResultado = .T.
1607: 
1608:         CATCH TO loc_oErro
1609:             MsgErro(loc_oErro.Message, "Formmtz.BtnCancelarClick")
1610:         ENDTRY
1611: 
1612:         RETURN loc_lResultado
1613:     ENDPROC
1614: 
1615:     *-- =========================================================================
1616:     *-- ALTERNAR PAGINA DADOS - Navega para Page2 sem recarregar lista
1617:     *-- =========================================================================
1618: 
1619:     PROTECTED PROCEDURE AlternarPaginaDados()
1620:         THIS.pgf_4c_Paginas.ActivePage = 2
1621:     ENDPROC
1622: 
1623:     *-- =========================================================================
1624:     *-- ALTERNAR GRADE DETALHE - Vincula cursor_4c_MtI ao grid da Page2
1625:     *-- (sera completado na Fase 4 quando o grid for criado)
1626:     *-- =========================================================================
1627: 
1628:     PROTECTED PROCEDURE AlternarGradeDetalhe()
1629:         LOCAL loc_oGrid, loc_lResultado
1630:         loc_lResultado = .F.
1631: 
1632:         TRY
1633:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1634:             IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_MtI")
1635:                 loc_oGrid.ColumnCount = 13
1636:                 loc_oGrid.RecordSource = "cursor_4c_MtI"
1637: 
1638:                 *-- Wires ControlSources apos RecordSource estar definido
1639:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
1640:                 loc_oGrid.Column2.ControlSource  = "cursor_4c_MtI.Contas"
1641:                 loc_oGrid.Column3.ControlSource  = "cursor_4c_MtI.Val_Jan"
1642:                 loc_oGrid.Column4.ControlSource  = "cursor_4c_MtI.Val_Fev"
1643:                 loc_oGrid.Column5.ControlSource  = "cursor_4c_MtI.Val_Mar"
1644:                 loc_oGrid.Column6.ControlSource  = "cursor_4c_MtI.Val_Abr"
1645:                 loc_oGrid.Column7.ControlSource  = "cursor_4c_MtI.Val_Mai"
1646:                 loc_oGrid.Column8.ControlSource  = "cursor_4c_MtI.Val_Jun"
1647:                 loc_oGrid.Column9.ControlSource  = "cursor_4c_MtI.Val_Jul"
1648:                 loc_oGrid.Column10.ControlSource = "cursor_4c_MtI.Val_Ago"
1649:                 loc_oGrid.Column11.ControlSource = "cursor_4c_MtI.Val_Set"
1650:                 loc_oGrid.Column12.ControlSource = "cursor_4c_MtI.Val_Out"
1651:                 loc_oGrid.Column13.ControlSource = "cursor_4c_MtI.Val_Nov"
1652:                 loc_oGrid.Column14.ControlSource = "cursor_4c_MtI.Val_Dez"
1653:                 loc_oGrid.Column15.ControlSource = "cursor_4c_MtI.Total"
1654:                 loc_oGrid.Column16.ControlSource = "cursor_4c_MtI.Acm_Jan"
1655:                 loc_oGrid.Column17.ControlSource = "cursor_4c_MtI.Acm_Fev"
1656:                 loc_oGrid.Column18.ControlSource = "cursor_4c_MtI.Acm_Mar"
1657:                 loc_oGrid.Column19.ControlSource = "cursor_4c_MtI.Acm_Abr"
1658:                 loc_oGrid.Column20.ControlSource = "cursor_4c_MtI.Acm_Mai"
1659:                 loc_oGrid.Column21.ControlSource = "cursor_4c_MtI.Acm_Jun"
1660:                 loc_oGrid.Column22.ControlSource = "cursor_4c_MtI.Acm_Jul"
1661:                 loc_oGrid.Column23.ControlSource = "cursor_4c_MtI.Acm_Ago"
1662:                 loc_oGrid.Column24.ControlSource = "cursor_4c_MtI.Acm_Set"
1663:                 loc_oGrid.Column25.ControlSource = "cursor_4c_MtI.Acm_Out"
1664:                 loc_oGrid.Column26.ControlSource = "cursor_4c_MtI.Acm_Nov"
1665:                 loc_oGrid.Column27.ControlSource = "cursor_4c_MtI.Acm_Dez"
1666:                 loc_oGrid.Column28.chk_4c_Valida.ControlSource = "cursor_4c_MtI.ChkValida"
1667: 
1668:                 loc_oGrid.FontName = "Tahoma"

*-- Linhas 1680 a 2220:
1680:     *-- =========================================================================
1681:     *-- VALIDAR ANO MTZ - Valida ano de competencia (range 2000-2999)
1682:     *-- Original: getAno.Valid
1683:     *-- =========================================================================
1684: 
1685:     PROCEDURE ValidarAnoMtz(par_nKeyCode, par_nShiftAltCtrl)
1686:         LOCAL loc_cAno, loc_nAno
1687:         loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value)
1688: 
1689:         IF EMPTY(loc_cAno)
1690:             RETURN
1691:         ENDIF
1692: 
1693:         loc_nAno = VAL(loc_cAno)
1694: 
1695:         IF loc_nAno <= 2000 OR loc_nAno >= 2999
1696:             MsgAviso("Informe um Ano V" + CHR(225) + "lido.", ;
1697:                     "Aten" + CHR(231) + CHR(227) + "o")
1698:             THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = ""
1699:             THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
1700:         ELSE
1701:             THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = TRANSFORM(loc_nAno)
1702:         ENDIF
1703:     ENDPROC
1704: 
1705:     *-- =========================================================================
1706:     *-- VALIDAR GRUPO MTZ - Valida grupo em SigCdGcr e preenche Classes
1707:     *-- Original: Get_sgrupo.Valid - CursorQuery em SigCdGcr para Classes
1708:     *-- =========================================================================
1709: 
1710:     PROCEDURE ValidarGrupoMtz(par_nKeyCode, par_nShiftAltCtrl)
1711:         LOCAL loc_cGrupo, loc_cSQL, loc_lResultado, loc_oErro
1712:         loc_lResultado = .F.
1713: 
1714:         loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
1715: 
1716:         IF EMPTY(loc_cGrupo)
1717:             THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1718:             RETURN
1719:         ENDIF
1720: 
1721:         TRY
1722:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
1723:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1724: 
1725:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcBusca") > 0 AND ;
1726:                !EOF("cursor_4c_GcBusca")
1727:                 SELECT cursor_4c_GcBusca
1728:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1729:                     ALLTRIM(cursor_4c_GcBusca.Classes)
1730: 
1731:                 IF EMPTY(ALLTRIM(cursor_4c_GcBusca.Classes))
1732:                     MsgErro("Imposs" + CHR(237) + "vel efetuar lan" + ;
1733:                             CHR(231) + CHR(227) + "amento para este grupo!" + CHR(13) + ;
1734:                             "A classe do grupo n" + CHR(227) + "o est" + CHR(225) + ;
1735:                             " informada!", "Aten" + CHR(231) + CHR(227) + "o")
1736:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1737:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1738:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
1739:                 ELSE
1740:                     loc_lResultado = .T.
1741:                 ENDIF
1742:             ELSE
1743:                 IF USED("cursor_4c_GcBusca")
1744:                     USE IN cursor_4c_GcBusca
1745:                 ENDIF
1746:                 THIS.AbrirBuscaGrupoMtz()
1747:             ENDIF
1748: 
1749:         CATCH TO loc_oErro
1750:             MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoMtz")
1751:         ENDTRY
1752: 
1753:         IF USED("cursor_4c_GcBusca")
1754:             USE IN cursor_4c_GcBusca
1755:         ENDIF
1756:     ENDPROC
1757: 
1758:     *-- =========================================================================
1759:     *-- ABRIR BUSCA GRUPO MTZ - FormBuscaAuxiliar em SigCdGcr
1760:     *-- =========================================================================
1761: 
1762:     PROCEDURE AbrirBuscaGrupoMtz()
1763:         LOCAL loc_oBusca, loc_oErro
1764: 
1765:         TRY
1766:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1767:                 "SigCdGcr", "cursor_4c_GcBusca2", "Codigos", ;
1768:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value), ;
1769:                 "Grupo de Conta Corrente")
1770: 
1771:             IF VARTYPE(loc_oBusca) = "O"
1772:                 IF !loc_oBusca.this_lAchouRegistro
1773:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1774:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1775:                     loc_oBusca.Show()
1776:                 ENDIF
1777: 
1778:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcBusca2")
1779:                     SELECT cursor_4c_GcBusca2
1780:                     IF !EOF()
1781:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ;
1782:                             ALLTRIM(cursor_4c_GcBusca2.Codigos)
1783:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1784:                             ALLTRIM(cursor_4c_GcBusca2.Classes)
1785:                     ENDIF
1786:                 ELSE
1787:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1788:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1789:                 ENDIF
1790: 
1791:                 loc_oBusca.Release()
1792:             ENDIF
1793: 
1794:         CATCH TO loc_oErro
1795:             MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaGrupoMtz")
1796:         ENDTRY
1797: 
1798:         IF USED("cursor_4c_GcBusca2")
1799:             USE IN cursor_4c_GcBusca2
1800:         ENDIF
1801:     ENDPROC
1802: 
1803:     *-- =========================================================================
1804:     *-- TECLA F4 SGRUPO - Abre busca de grupo ao pressionar F4
1805:     *-- =========================================================================
1806: 
1807:     PROCEDURE TeclaF4Sgrupo(par_nKeyCode, par_nShiftAltCtrl)
1808:         IF par_nKeyCode = 63
1809:             THIS.AbrirBuscaGrupoMtz()
1810:         ENDIF
1811:     ENDPROC
1812: 
1813:     *-- =========================================================================
1814:     *-- VALIDAR CONTA MTZ - Valida conta em SigCdCli e preenche descricao
1815:     *-- Original: Get_sconta.Valid - fAcessoContas + fChecarInativas
1816:     *-- =========================================================================
1817: 
1818:     PROCEDURE ValidarContaMtz(par_nKeyCode, par_nShiftAltCtrl)
1819:         LOCAL loc_cConta, loc_cGrupo, loc_cSQL, loc_lResultado, loc_oErro
1820:         loc_lResultado = .F.
1821: 
1822:         loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value)
1823:         loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
1824: 
1825:         IF EMPTY(loc_cConta)
1826:             THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1827:             RETURN
1828:         ENDIF
1829: 
1830:         TRY
1831:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Grupos, Inativa FROM SigCdCli" + ;
1832:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
1833:             IF !EMPTY(loc_cGrupo)
1834:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1835:             ENDIF
1836: 
1837:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliBusca") > 0 AND ;
1838:                !EOF("cursor_4c_CliBusca")
1839:                 SELECT cursor_4c_CliBusca
1840:                 IF NVL(cursor_4c_CliBusca.Inativa, 0) = 1
1841:                     MsgAviso("Conta Inativa...", "Aten" + CHR(231) + CHR(227) + "o")
1842:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1843:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1844:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.SetFocus()
1845:                 ELSE
1846:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1847:                         ALLTRIM(cursor_4c_CliBusca.Rclis)
1848:                     loc_lResultado = .T.
1849:                 ENDIF
1850:             ELSE
1851:                 IF USED("cursor_4c_CliBusca")
1852:                     USE IN cursor_4c_CliBusca
1853:                 ENDIF
1854:                 THIS.AbrirBuscaContaMtz()
1855:             ENDIF
1856: 
1857:         CATCH TO loc_oErro
1858:             MsgErro(loc_oErro.Message, "Formmtz.ValidarContaMtz")
1859:         ENDTRY
1860: 
1861:         IF USED("cursor_4c_CliBusca")
1862:             USE IN cursor_4c_CliBusca
1863:         ENDIF
1864:     ENDPROC
1865: 
1866:     *-- =========================================================================
1867:     *-- ABRIR BUSCA CONTA MTZ - FormBuscaAuxiliar em SigCdCli
1868:     *-- =========================================================================
1869: 
1870:     PROCEDURE AbrirBuscaContaMtz()
1871:         LOCAL loc_oBusca, loc_cGrupo, loc_cFiltro, loc_oErro
1872: 
1873:         TRY
1874:             loc_cGrupo  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
1875:             loc_cFiltro = ""
1876:             IF !EMPTY(loc_cGrupo)
1877:                 loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
1878:             ENDIF
1879: 
1880:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1881:                 "SigCdCli", "cursor_4c_CliBusca2", "IClis", ;
1882:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value), ;
1883:                 "Conta Corrente", .F., .T., loc_cFiltro)
1884: 
1885:             IF VARTYPE(loc_oBusca) = "O"
1886:                 IF !loc_oBusca.this_lAchouRegistro
1887:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1888:                     loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
1889:                     loc_oBusca.Show()
1890:                 ENDIF
1891: 
1892:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliBusca2")
1893:                     SELECT cursor_4c_CliBusca2
1894:                     IF !EOF()
1895:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ;
1896:                             ALLTRIM(cursor_4c_CliBusca2.IClis)
1897:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1898:                             ALLTRIM(cursor_4c_CliBusca2.Rclis)
1899:                     ENDIF
1900:                 ELSE
1901:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1902:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1903:                 ENDIF
1904: 
1905:                 loc_oBusca.Release()
1906:             ENDIF
1907: 
1908:         CATCH TO loc_oErro
1909:             MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaContaMtz")
1910:         ENDTRY
1911: 
1912:         IF USED("cursor_4c_CliBusca2")
1913:             USE IN cursor_4c_CliBusca2
1914:         ENDIF
1915:     ENDPROC
1916: 
1917:     *-- =========================================================================
1918:     *-- TECLA F4 SCONTA - Abre busca de conta ao pressionar F4
1919:     *-- =========================================================================
1920: 
1921:     PROCEDURE TeclaF4Sconta(par_nKeyCode, par_nShiftAltCtrl)
1922:         IF par_nKeyCode = 63
1923:             THIS.AbrirBuscaContaMtz()
1924:         ENDIF
1925:     ENDPROC
1926: 
1927:     *-- =========================================================================
1928:     *-- VALIDAR MOEDA MTZ - Valida moeda em SigCdMoe (fwBuscaExt original)
1929:     *-- Original: getMoeda.Valid - fwBuscaExt('SigCdMoe','CMoes','DMoes')
1930:     *-- =========================================================================
1931: 
1932:     PROCEDURE ValidarMoedaMtz(par_nKeyCode, par_nShiftAltCtrl)
1933:         LOCAL loc_cMoeda, loc_cSQL, loc_lResultado, loc_oErro
1934:         loc_lResultado = .F.
1935: 
1936:         loc_cMoeda = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value)
1937: 
1938:         IF EMPTY(loc_cMoeda)
1939:             THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
1940:             RETURN
1941:         ENDIF
1942: 
1943:         TRY
1944:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe" + ;
1945:                        " WHERE CMoes = " + EscaparSQL(loc_cMoeda)
1946: 
1947:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca") > 0 AND ;
1948:                !EOF("cursor_4c_MoeBusca")
1949:                 SELECT cursor_4c_MoeBusca
1950:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1951:                     ALLTRIM(cursor_4c_MoeBusca.CMoes)
1952:                 loc_lResultado = .T.
1953:             ELSE
1954:                 IF USED("cursor_4c_MoeBusca")
1955:                     USE IN cursor_4c_MoeBusca
1956:                 ENDIF
1957:                 THIS.AbrirBuscaMoedaMtz()
1958:             ENDIF
1959: 
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message, "Formmtz.ValidarMoedaMtz")
1962:         ENDTRY
1963: 
1964:         IF USED("cursor_4c_MoeBusca")
1965:             USE IN cursor_4c_MoeBusca
1966:         ENDIF
1967:     ENDPROC
1968: 
1969:     *-- =========================================================================
1970:     *-- ABRIR BUSCA MOEDA MTZ - FormBuscaAuxiliar em SigCdMoe
1971:     *-- =========================================================================
1972: 
1973:     PROCEDURE AbrirBuscaMoedaMtz()
1974:         LOCAL loc_oBusca, loc_oErro
1975: 
1976:         TRY
1977:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1978:                 "SigCdMoe", "cursor_4c_MoeBusca2", "CMoes", ;
1979:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value), ;
1980:                 "Moeda")
1981: 
1982:             IF VARTYPE(loc_oBusca) = "O"
1983:                 IF !loc_oBusca.this_lAchouRegistro
1984:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1985:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1986:                     loc_oBusca.Show()
1987:                 ENDIF
1988: 
1989:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca2")
1990:                     SELECT cursor_4c_MoeBusca2
1991:                     IF !EOF()
1992:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1993:                             ALLTRIM(cursor_4c_MoeBusca2.CMoes)
1994:                     ENDIF
1995:                 ELSE
1996:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
1997:                 ENDIF
1998: 
1999:                 loc_oBusca.Release()
2000:             ENDIF
2001: 
2002:         CATCH TO loc_oErro
2003:             MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaMoedaMtz")
2004:         ENDTRY
2005: 
2006:         IF USED("cursor_4c_MoeBusca2")
2007:             USE IN cursor_4c_MoeBusca2
2008:         ENDIF
2009:     ENDPROC
2010: 
2011:     *-- =========================================================================
2012:     *-- TECLA F4 MOEDA - Abre busca de moeda ao pressionar F4
2013:     *-- =========================================================================
2014: 
2015:     PROCEDURE TeclaF4Moeda(par_nKeyCode, par_nShiftAltCtrl)
2016:         IF par_nKeyCode = 63
2017:             THIS.AbrirBuscaMoedaMtz()
2018:         ENDIF
2019:     ENDPROC
2020: 
2021:     *-- =========================================================================
2022:     *-- ATUALIZA TOTAL - Recalcula Total da linha e atualiza ValorTotal header
2023:     *-- Original: ThisForm.AtualizaTotal(csSigCdMti.cIdChaves)
2024:     *-- =========================================================================
2025: 
2026:     PROCEDURE AtualizaTotal(par_cIdChaves)
2027:         LOCAL loc_lResultado
2028:         loc_lResultado = .F.
2029: 
2030:         TRY
2031:             IF THIS.this_oBusinessObject.AtualizarTotal(par_cIdChaves)
2032:                 THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = ;
2033:                     THIS.this_oBusinessObject.this_nValorTotal
2034:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Saldo.Value = ;
2035:                     THIS.this_oBusinessObject.this_nValorTotal
2036:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2037:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2038:                 ENDIF
2039:                 loc_lResultado = .T.
2040:             ENDIF
2041:         CATCH TO loc_oErro
2042:             MsgErro(loc_oErro.Message, "Formmtz.AtualizaTotal")
2043:         ENDTRY
2044: 
2045:         RETURN loc_lResultado
2046:     ENDPROC
2047: 
2048:     *-- =========================================================================
2049:     *-- BTN INSERIR LINHA CLICK - Adiciona linha em branco na grade de detalhe
2050:     *-- Original: cmdInsFtc.Buttons(1).Click
2051:     *-- =========================================================================
2052: 
2053:     PROCEDURE BtnInserirLinhaClick()
2054:         LOCAL loc_cCodigo, loc_oGrid
2055: 
2056:         TRY
2057:             IF THIS.this_cModoAtual # "INCLUIR" AND THIS.this_cModoAtual # "ALTERAR"
2058:                 RETURN
2059:             ENDIF
2060: 
2061:             loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
2062: 
2063:             IF THIS.this_oBusinessObject.InserirLinhaDetalhe(loc_cCodigo)
2064:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2065:                 IF VARTYPE(loc_oGrid) = "O"
2066:                     loc_oGrid.Refresh()
2067:                     loc_oGrid.Column1.SetFocus()
2068:                 ENDIF
2069:             ENDIF
2070: 
2071:         CATCH TO loc_oErro
2072:             MsgErro(loc_oErro.Message, "Formmtz.BtnInserirLinhaClick")
2073:         ENDTRY
2074:     ENDPROC
2075: 
2076:     *-- =========================================================================
2077:     *-- BTN EXCLUIR LINHA CLICK - Remove linha atual da grade de detalhe
2078:     *-- Original: cmdInsFtc.Buttons(2).Click
2079:     *-- =========================================================================
2080: 
2081:     PROCEDURE BtnExcluirLinhaClick()
2082:         LOCAL loc_oGrid
2083: 
2084:         TRY
2085:             IF THIS.this_cModoAtual # "INCLUIR" AND THIS.this_cModoAtual # "ALTERAR"
2086:                 RETURN
2087:             ENDIF
2088: 
2089:             IF THIS.this_oBusinessObject.ExcluirLinhaDetalhe()
2090:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2091:                 IF VARTYPE(loc_oGrid) = "O"
2092:                     loc_oGrid.SetFocus()
2093:                     loc_oGrid.Refresh()
2094:                 ENDIF
2095:             ENDIF
2096: 
2097:         CATCH TO loc_oErro
2098:             MsgErro(loc_oErro.Message, "Formmtz.BtnExcluirLinhaClick")
2099:         ENDTRY
2100:     ENDPROC
2101: 
2102:     *-- =========================================================================
2103:     *-- GRD DADOS AFTER ROW COL CHANGE - Valida celulas e atualiza totais
2104:     *-- Original: Column1.Text1.Valid, Column2.Text1.Valid, Column3-14.Text1.Valid
2105:     *-- =========================================================================
2106: 
2107:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2108:         LOCAL loc_cChave
2109: 
2110:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2111:             RETURN
2112:         ENDIF
2113: 
2114:         SELECT cursor_4c_MtI
2115:         loc_cChave = ALLTRIM(NVL(cursor_4c_MtI.CidChaves, ""))
2116: 
2117:         DO CASE
2118:         CASE par_nColIndex >= 3 AND par_nColIndex <= 14
2119:             IF !EMPTY(loc_cChave)
2120:                 THIS.AtualizaTotal(loc_cChave)
2121:             ENDIF
2122: 
2123:         CASE par_nColIndex = 1
2124:             THIS.ValidarGrupoLinhaGrid()
2125: 
2126:         CASE par_nColIndex = 2
2127:             THIS.ValidarContaLinhaGrid()
2128: 
2129:         ENDCASE
2130:     ENDPROC
2131: 
2132:     *-- =========================================================================
2133:     *-- VALIDAR GRUPO LINHA GRID - Valida SigCdGcr.Codigos na coluna Grupos
2134:     *-- Original: Column1.Text1.Valid (fAcessoContab)
2135:     *-- =========================================================================
2136: 
2137:     PROCEDURE ValidarGrupoLinhaGrid()
2138:         LOCAL loc_cGrupo, loc_cSQL
2139: 
2140:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2141:             RETURN
2142:         ENDIF
2143: 
2144:         SELECT cursor_4c_MtI
2145:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2146: 
2147:         IF EMPTY(loc_cGrupo)
2148:             RETURN
2149:         ENDIF
2150: 
2151:         TRY
2152:             loc_cSQL = "SELECT TOP 1 Codigos, Classes FROM SigCdGcr" + ;
2153:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2154: 
2155:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcGrid") <= 0 OR ;
2156:                EOF("cursor_4c_GcGrid")
2157:                 MsgErro("Acesso Negado!!! Grupo n" + CHR(227) + "o encontrado.", "")
2158:                 SELECT cursor_4c_MtI
2159:                 REPLACE Grupos WITH "" IN cursor_4c_MtI
2160:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2161:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2162:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
2163:                 ENDIF
2164:             ENDIF
2165: 
2166:         CATCH TO loc_oErro
2167:             MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoLinhaGrid")
2168:         ENDTRY
2169: 
2170:         IF USED("cursor_4c_GcGrid")
2171:             USE IN cursor_4c_GcGrid
2172:         ENDIF
2173:     ENDPROC
2174: 
2175:     *-- =========================================================================
2176:     *-- VALIDAR CONTA LINHA GRID - Valida SigCdCli.IClis na coluna Contas
2177:     *-- Original: Column2.Text1.Valid (fAcessoContas)
2178:     *-- =========================================================================
2179: 
2180:     PROCEDURE ValidarContaLinhaGrid()
2181:         LOCAL loc_cConta, loc_cGrupo, loc_cSQL
2182: 
2183:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2184:             RETURN
2185:         ENDIF
2186: 
2187:         SELECT cursor_4c_MtI
2188:         loc_cConta = ALLTRIM(NVL(cursor_4c_MtI.Contas, ""))
2189:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2190: 
2191:         IF EMPTY(loc_cConta)
2192:             RETURN
2193:         ENDIF
2194: 
2195:         TRY
2196:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Inativa FROM SigCdCli" + ;
2197:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
2198:             IF !EMPTY(loc_cGrupo)
2199:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
2200:             ENDIF
2201: 
2202:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrid") > 0 AND ;
2203:                !EOF("cursor_4c_CliGrid")
2204:                 SELECT cursor_4c_CliGrid
2205:                 IF NVL(cursor_4c_CliGrid.Inativa, 0) = 1
2206:                     MsgErro("Acesso Negado!!! Conta Inativa.", "")
2207:                     SELECT cursor_4c_MtI
2208:                     REPLACE Contas WITH "" IN cursor_4c_MtI
2209:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2210:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2211:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2212:                     ENDIF
2213:                 ENDIF
2214:             ELSE
2215:                 MsgErro("Acesso Negado!!! Conta n" + CHR(227) + "o encontrada.", "")
2216:                 SELECT cursor_4c_MtI
2217:                 REPLACE Contas WITH "" IN cursor_4c_MtI
2218:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2219:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2220:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()

*-- Linhas 2234 a 2298:
2234:     *-- TORNAR CONTROLES VISIVEIS - Percorre containers e pages recursivamente
2235:     *-- =========================================================================
2236: 
2237:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2238:         LOCAL loc_nI, loc_oObjeto, loc_nP
2239: 
2240:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2241:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2242: 
2243:             IF VARTYPE(loc_oObjeto) = "O"
2244:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2245:                     loc_oObjeto.Visible = .T.
2246:                 ENDIF
2247: 
2248:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2249:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2250:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2251:                     ENDFOR
2252:                 ENDIF
2253: 
2254:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2255:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2256:                 ENDIF
2257:             ENDIF
2258:         ENDFOR
2259:     ENDPROC
2260: 
2261:     *-- =========================================================================
2262:     *-- FORMATAR GRID LISTA - Aplica fonte padrao no grid
2263:     *-- =========================================================================
2264: 
2265:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2266:         WITH par_oGrid
2267:             .FontName = "Verdana"
2268:             .FontSize = 8
2269:         ENDWITH
2270:     ENDPROC
2271: 
2272:     *-- =========================================================================
2273:     *-- DESTROY - Libera recursos
2274:     *-- =========================================================================
2275: 
2276:     PROCEDURE Destroy()
2277:         LOCAL loc_oErro
2278: 
2279:         TRY
2280:             IF USED("cursor_4c_Dados")
2281:                 USE IN cursor_4c_Dados
2282:             ENDIF
2283:             IF USED("cursor_4c_MtI")
2284:                 USE IN cursor_4c_MtI
2285:             ENDIF
2286: 
2287:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2288:                 THIS.this_oBusinessObject = .NULL.
2289:             ENDIF
2290: 
2291:         CATCH TO loc_oErro
2292:             MsgErro(loc_oErro.Message, "Formmtz.Destroy")
2293:         ENDTRY
2294: 
2295:         DODEFAULT()
2296:     ENDPROC
2297: 
2298: ENDDEFINE


### BO (C:\4c\projeto\app\classes\mtzBO.prg):
*******************************************************************************
* mtzBO.prg - Business Object: Matriz de Saldos por Centro de Custo
* Tabela principal : SigCdMtz  (cabecalho da matriz)
* Tabela detalhe   : SigCdMtI  (linhas de centro de custo / meses)
* Herda de         : BusinessBase
*******************************************************************************

DEFINE CLASS mtzBO AS BusinessBase

    *-- =========================================================================
    *-- PROPRIEDADES: SigCdMtz (cabecalho)
    *-- =========================================================================

    *-- Chave usuario (char 3 - gerada por GerarProximoCodigo na insercao)
    this_cCodigo    = ""

    *-- Ano de competencia da matriz (char 4, ex: "2026")
    this_cAno       = ""

    *-- Grupo de conta corrente (SigCdGcr.Codigos)
    this_cSGrupos   = ""

    *-- Conta de centro de custo (SigCdCli.IClis)
    this_cSContas   = ""

    *-- Flag inativa (0=ativa / 1=inativa -> convertido para .T./.F.)
    this_lInativas  = .F.

    *-- Moeda da matriz (SigCdMoe.CMoes, char 4)
    this_cMoeda     = ""

    *-- Auditoria de inclusao
    this_tDtIncs    = {}
    this_cUsuIncs   = ""

    *-- Auditoria de alteracao
    this_tDtAlts    = {}
    this_cUsuAlts   = ""

    *-- =========================================================================
    *-- PROPRIEDADES DERIVADAS / AUXILIARES (nao armazenadas diretamente)
    *-- =========================================================================

    *-- Descricao da conta - derivada do JOIN: SigCdCli.rclis AS sDContas
    *-- Nao existe como coluna em SigCdMtz; carregada via SELECT com JOIN
    this_cSDesconta = ""

    *-- Valor total acumulado dos meses de SigCdMtI (calculado, exibicao)
    this_nValorTotal = 0

    *-- =========================================================================
    *-- INIT
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMtz"
            THIS.this_cCampoChave = "Codigo"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- OBTER CHAVE PRIMARIA (requerido pelo sistema de auditoria)
    *-- =========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *-- =========================================================================
    *-- NOVO REGISTRO - Gera codigo unico para insercao
    *-- =========================================================================

    FUNCTION NovoRegistro()
        LOCAL loc_lResultado, loc_nProximo
        loc_lResultado = DODEFAULT()

        IF loc_lResultado
            TRY
                loc_nProximo = THIS.GerarProximoCodigo()
                IF loc_nProximo > 0
                    THIS.this_cCodigo = ALLTRIM(STR(loc_nProximo, 3))
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel gerar c" + CHR(243) + "digo para nova matriz.", "mtzBO.NovoRegistro")
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "mtzBO.NovoRegistro")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- GERAR PROXIMO CODIGO (PROTECTED) - MAX(Codigo)+1 em SigCdMtz
    *-- =========================================================================

    PROTECTED FUNCTION GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(Codigo) AS INT)), 0) + 1 AS ProximoCodigo" + ;
                       " FROM SigCdMtz" + ;
                       " WHERE ISNUMERIC(LTRIM(Codigo)) = 1"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ProxCod")
                TABLEREVERT(.T., "cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = NVL(ProximoCodigo, 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *-- =========================================================================
    *-- BUSCAR - SELECT para grid Page1 (lista de matrizes)
    *-- =========================================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " ORDER BY a.Ano, a.sGrupos, a.sContas"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                           " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                           " a.DtIncs, a.UsuIncs" + ;
                           " FROM SigCdMtz a" + ;
                           " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY a.Ano, a.sGrupos, a.sContas"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR POR CODIGO - Carrega registro SigCdMtz no BO
    *-- =========================================================================

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs, a.DtAlts, a.UsuAlts, a.CidChaves" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DO CURSOR - Mapeia cursor para propriedades do BO
    *-- =========================================================================

    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Codigo, "C")
            THIS.this_cAno       = TratarNulo(Ano, "C")
            THIS.this_cSGrupos   = TratarNulo(sGrupos, "C")
            THIS.this_cSContas   = TratarNulo(sContas, "C")
            THIS.this_cSDesconta = TratarNulo(sDContas, "C")
            THIS.this_cMoeda     = TratarNulo(Moeda, "C")
            IF VARTYPE(Inativas) = "L"
                THIS.this_lInativas = Inativas
            ELSE
                THIS.this_lInativas = (NVL(Inativas, 0) = 1)
            ENDIF
            THIS.this_tDtIncs    = TratarNulo(DtIncs, "T")
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs, "C")
            THIS.this_tDtAlts    = TratarNulo(DtAlts, "T")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DETALHE - Carrega SigCdMtI para cursor_4c_MtI (grid Page2)
    *-- =========================================================================

    FUNCTION CarregarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_cSQL = "SELECT a.Codigo, a.CidChaves, a.Grupos, a.Contas," + ;
                       " a.Val_Jan, a.Val_Fev, a.Val_Mar, a.Val_Abr," + ;
                       " a.Val_Mai, a.Val_Jun, a.Val_Jul, a.Val_Ago," + ;
                       " a.Val_Set, a.Val_Out, a.Val_Nov, a.Val_Dez," + ;
                       " a.Acm_Jan, a.Acm_Fev, a.Acm_Mar, a.Acm_Abr," + ;
                       " a.Acm_Mai, a.Acm_Jun, a.Acm_Jul, a.Acm_Ago," + ;
                       " a.Acm_Set, a.Acm_Out, a.Acm_Nov, a.Acm_Dez," + ;
                       " (a.Val_Jan+a.Val_Fev+a.Val_Mar+a.Val_Abr+a.Val_Mai+a.Val_Jun+" + ;
                       "  a.Val_Jul+a.Val_Ago+a.Val_Set+a.Val_Out+a.Val_Nov+a.Val_Dez)" + ;
                       " AS Total, a.ChkValida" + ;
                       " FROM SigCdMtI a" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_MtI")
                TABLEREVERT(.T., "cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtI")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.CarregarDetalhe")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CRIAR CURSOR DETALHE VAZIO - Cria cursor_4c_MtI vazio para insercao
    *-- =========================================================================

    FUNCTION CriarCursorDetalheVazio(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_MtI ( ;
                Codigo    C(3), ;
                CidChaves C(36), ;
                Grupos    C(10), ;
                Contas    C(10), ;
                Val_Jan   N(14,2), ;
                Val_Fev   N(14,2), ;
                Val_Mar   N(14,2), ;
                Val_Abr   N(14,2), ;
                Val_Mai   N(14,2), ;
                Val_Jun   N(14,2), ;
                Val_Jul   N(14,2), ;
                Val_Ago   N(14,2), ;
                Val_Set   N(14,2), ;
                Val_Out   N(14,2), ;
                Val_Nov   N(14,2), ;
                Val_Dez   N(14,2), ;
                Acm_Jan   N(14,2), ;
                Acm_Fev   N(14,2), ;
                Acm_Mar   N(14,2), ;
                Acm_Abr   N(14,2), ;
                Acm_Mai   N(14,2), ;
                Acm_Jun   N(14,2), ;
                Acm_Jul   N(14,2), ;
                Acm_Ago   N(14,2), ;
                Acm_Set   N(14,2), ;
                Acm_Out   N(14,2), ;
                Acm_Nov   N(14,2), ;
                Acm_Dez   N(14,2), ;
                Total     N(18,2), ;
                ChkValida L ;
            )
            SET NULL OFF

            *-- Adiciona linha em branco inicial para o usuario comecar a inserir
            INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                Total, ChkValida) ;
                VALUES (par_cCodigo, "", "", "", ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, .F.)

            GO TOP IN cursor_4c_MtI
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CriarCursorDetalheVazio")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR LINHA DETALHE - Adiciona linha em branco no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION InserirLinhaDetalhe(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                *-- Verifica se ja existe uma linha vazia (sem Grupos e Contas)
                SELECT cursor_4c_MtI
                GO TOP
                LOCATE FOR EMPTY(ALLTRIM(Grupos)) AND EMPTY(ALLTRIM(Contas))
                IF !FOUND()
                    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                        Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                        Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                        Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                        Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                        Total, ChkValida) ;
                        VALUES (par_cCodigo, "", "", "", ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, .F.)
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.InserirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- EXCLUIR LINHA DETALHE - Remove linha atual do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ExcluirLinhaDetalhe()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExcluirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- ATUALIZAR TOTAL - Calcula Total na linha do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION AtualizarTotal(par_cChave)
        LOCAL loc_nTotal, loc_nTotalGeral, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                IF !EMPTY(ALLTRIM(par_cChave))
                    SELECT cursor_4c_MtI
                    LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    IF FOUND()
                        loc_nTotal = NVL(Val_Jan, 0) + NVL(Val_Fev, 0) + NVL(Val_Mar, 0) + ;
                                     NVL(Val_Abr, 0) + NVL(Val_Mai, 0) + NVL(Val_Jun, 0) + ;
                                     NVL(Val_Jul, 0) + NVL(Val_Ago, 0) + NVL(Val_Set, 0) + ;
                                     NVL(Val_Out, 0) + NVL(Val_Nov, 0) + NVL(Val_Dez, 0)
                        REPLACE Total WITH loc_nTotal IN cursor_4c_MtI ;
                            FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    ENDIF
                ENDIF

                *-- Calcula total geral de todas as linhas
                SELECT SUM(NVL(Total, 0)) AS TotalGeral FROM cursor_4c_MtI INTO CURSOR cursor_4c_TmpTot READWRITE
                SELECT cursor_4c_TmpTot
                THIS.this_nValorTotal = NVL(TotalGeral, 0)
                USE IN cursor_4c_TmpTot

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.AtualizarTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VALIDAR DUPLICATAS - Verifica Grupos+Contas duplicados no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_lResultado
        loc_lValido = .T.
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                SELECT COUNT(*) AS Qtds, Grupos, Contas ;
                    FROM cursor_4c_MtI ;
                    WHERE !EMPTY(ALLTRIM(Contas)) AND !EMPTY(ALLTRIM(Grupos)) ;
                    GROUP BY Grupos, Contas ;
                    HAVING COUNT(*) >= 2 ;
                    INTO CURSOR cursor_4c_Dup READWRITE

                SELECT cursor_4c_Dup
                IF RECCOUNT("cursor_4c_Dup") > 0
                    MsgErro("H" + CHR(225) + " registros duplicados na grade de Contas, Verifique.", "Aviso")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                loc_lResultado = loc_lValido
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ValidarDuplicatas")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR (PROTECTED) - INSERT SigCdMtz + SigCdMtI via cursor_4c_MtI
    *-- =========================================================================

    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMtz" + ;
                       " (Codigo, Ano, sGrupos, sContas, Moeda, Inativas," + ;
                       "  DtIncs, UsuIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cAno) + "," + ;
                       EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       EscaparSQL(THIS.this_cSContas) + "," + ;
                       EscaparSQL(THIS.this_cMoeda) + "," + ;
                       IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .T.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZAR (PROTECTED) - UPDATE SigCdMtz + re-inserir SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtz SET" + ;
                       " Ano = " + EscaparSQL(THIS.this_cAno) + "," + ;
                       " sGrupos = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       " sContas = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                       " Moeda = " + EscaparSQL(THIS.this_cMoeda) + "," + ;
                       " Inativas = " + IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .F.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- EXECUTAR EXCLUSAO (PROTECTED) - DELETE SigCdMtz + SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- DELETE SigCdMtI (detalhe) primeiro por FK
            loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdMtz WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtz)")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtI)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- SALVAR DETALHE (PROTECTED) - INSERT SigCdMtI a partir de cursor_4c_MtI
    *-- =========================================================================

    PROTECTED FUNCTION SalvarDetalhe(par_cCodigo, par_lSomenteInserir)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupos, loc_cContas, loc_cChave
        LOCAL loc_nJan, loc_nFev, loc_nMar, loc_nAbr, loc_nMai, loc_nJun
        LOCAL loc_nJul, loc_nAgo, loc_nSet, loc_nOut, loc_nNov, loc_nDez
        loc_lResultado = .F.

        TRY
            IF !par_lSomenteInserir
                loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(par_cCodigo)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            loc_lResultado = .T.

            IF USED("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                GO TOP
                SCAN FOR !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas))
                    loc_cGrupos = ALLTRIM(Grupos)
                    loc_cContas = ALLTRIM(Contas)
                    loc_cChave  = ALLTRIM(CidChaves)
                    loc_nJan    = NVL(Val_Jan, 0)
                    loc_nFev    = NVL(Val_Fev, 0)
                    loc_nMar    = NVL(Val_Mar, 0)
                    loc_nAbr    = NVL(Val_Abr, 0)
                    loc_nMai    = NVL(Val_Mai, 0)
                    loc_nJun    = NVL(Val_Jun, 0)
                    loc_nJul    = NVL(Val_Jul, 0)
                    loc_nAgo    = NVL(Val_Ago, 0)
                    loc_nSet    = NVL(Val_Set, 0)
                    loc_nOut    = NVL(Val_Out, 0)
                    loc_nNov    = NVL(Val_Nov, 0)
                    loc_nDez    = NVL(Val_Dez, 0)

                    IF EMPTY(loc_cChave)
                        loc_cChave = ALLTRIM(SYS(2015)) + ALLTRIM(STR(SECONDS(), 10, 0))
                    ENDIF

                    loc_cSQL = "INSERT INTO SigCdMtI" + ;
                               " (Codigo, CidChaves, Grupos, Contas," + ;
                               "  Val_Jan, Val_Fev, Val_Mar, Val_Abr," + ;
                               "  Val_Mai, Val_Jun, Val_Jul, Val_Ago," + ;
                               "  Val_Set, Val_Out, Val_Nov, Val_Dez)" + ;
                               " VALUES (" + ;
                               EscaparSQL(par_cCodigo) + "," + ;
                               EscaparSQL(loc_cChave) + "," + ;
                               EscaparSQL(loc_cGrupos) + "," + ;
                               EscaparSQL(loc_cContas) + "," + ;
                               FormatarNumeroSQL(loc_nJan) + "," + ;
                               FormatarNumeroSQL(loc_nFev) + "," + ;
                               FormatarNumeroSQL(loc_nMar) + "," + ;
                               FormatarNumeroSQL(loc_nAbr) + "," + ;
                               FormatarNumeroSQL(loc_nMai) + "," + ;
                               FormatarNumeroSQL(loc_nJun) + "," + ;
                               FormatarNumeroSQL(loc_nJul) + "," + ;
                               FormatarNumeroSQL(loc_nAgo) + "," + ;
                               FormatarNumeroSQL(loc_nSet) + "," + ;
                               FormatarNumeroSQL(loc_nOut) + "," + ;
                               FormatarNumeroSQL(loc_nNov) + "," + ;
                               FormatarNumeroSQL(loc_nDez) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro(CapturarErroSQL(), "mtzBO.SalvarDetalhe (linha " + loc_cGrupos + "/" + loc_cContas + ")")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.SalvarDetalhe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VERIFICAR DUPLICADO - Verifica se Ano+Grupo+Conta ja existe em SigCdMtz
    *-- =========================================================================

    FUNCTION VerificarDuplicado(par_cAno, par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdMtz" + ;
                       " WHERE Ano = " + EscaparSQL(par_cAno) + ;
                       " AND sGrupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND sContas = " + EscaparSQL(par_cConta)

            IF !EMPTY(ALLTRIM(THIS.this_cCodigo)) AND !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                           " AND Codigo <> " + EscaparSQL(THIS.this_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMtz")
                TABLEREVERT(.T., "cursor_4c_ChkMtz")
                USE IN cursor_4c_ChkMtz
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMtz")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkMtz") > 0
                SELECT cursor_4c_ChkMtz
                loc_lExiste = (NVL(Qtd, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.VerificarDuplicado")
        ENDTRY

        IF USED("cursor_4c_ChkMtz")
            USE IN cursor_4c_ChkMtz
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *-- =========================================================================
    *-- DESTRUIR - Fecha cursores abertos pelo BO
    *-- =========================================================================

    PROCEDURE Destroy()
        IF USED("cursor_4c_MtI")
            USE IN cursor_4c_MtI
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

