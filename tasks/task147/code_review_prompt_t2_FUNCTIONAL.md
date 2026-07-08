# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_ORIGEM. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Núm.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr. Orig.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct. Orig.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr. Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct. Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção, Temp/Min. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGPDMP6.Pagina.Lista): Top original=124 vs migrado 'cnt_4c_BotoesAcao' Top=51 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGPDMP6.Pagina.Lista): Left original=669 vs migrado 'cnt_4c_BotoesAcao' Left=843 (diff=174px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp6.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3953 linhas total):

*-- Linhas 8 a 198:
8: DEFINE CLASS Formsigpdmp6 AS FormBase
9: 
10:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
11:     *-- Caption sem acentos aqui; definido com CHR() em InicializarForm
12:     Height       = 600
13:     Width        = 1000
14:     AutoCenter   = .T.
15:     ShowWindow   = 1
16:     WindowType   = 1
17:     ControlBox   = .F.
18:     Closable     = .F.
19:     MaxButton    = .F.
20:     TitleBar     = 0
21:     ClipControls = .F.
22:     Themes       = .F.
23:     BorderStyle  = 2
24:     FontName     = "Tahoma"
25:     ForeColor    = RGB(90, 90, 90)
26:     DataSession  = 2
27: 
28:     *-- Business Object e mensagem de erro
29:     this_oBusinessObject = .NULL.
30:     this_cMensagemErro   = ""
31: 
32:     *-- Estado do filtro de lista (Page1 - Cnt_periodo)
33:     this_cPEmps    = ""   && Empresa selecionada (legado: pEmps / go_4c_Sistema.cCodEmpresa)
34:     this_dAntDtIni = {}   && Data inicial anterior para detectar mudanca
35:     this_dAntDtFin = {}   && Data final anterior para detectar mudanca
36:     this_cAntEmpr  = ""   && Empresa anterior para detectar mudanca
37: 
38:     *-- Estado do movimento corrente (Page2)
39:     this_cDopp      = ""   && Operacao/documento corrente (legado: _Dopp)
40:     this_nPNumes    = 0    && Numero do movimento (legado: pNumes)
41:     this_lPConsulta = .F.  && Modo consulta direta (legado: _pConsulta)
42:     this_nOldCodigo = 0    && Codigo anterior no campo OP (legado: _OldCodigo)
43:     this_cAntValue  = ""   && Valor anterior campo observacao (legado: antvalue)
44:     this_cSigKey    = ""   && Chave unica da sessao (legado: SigKey)
45:     this_cTipoSub   = ""   && Tipo subnivel: 'OP' ou 'ENV' (legado: tiposubnivel)
46:     this_lEditaOrig = .T.  && Permite editar conta de origem (legado: editaorigem)
47:     this_lAtFoco    = .F.  && Controla SetFocus no Activate (legado: AtFoco)
48:     this_nLocReg    = 0    && Numero do registro na lista (legado: LocRegister)
49: 
50:     *-- Nomes (dconta) dos containers Origem/Destino/Responsavel (cache form-level)
51:     this_cNomeContaos = ""   && Nome da conta de Origem (legado: TmpCli.RClis para Origem)
52:     this_cNomeContads = ""   && Nome da conta de Destino
53:     this_cNomeVends   = ""   && Nome da conta do Responsavel (vendedor/gerenciador)
54: 
55:     *--------------------------------------------------------------------------
56:     * Init - Captura parametros opcionais (suporte a abertura com parametros)
57:     * Legado: LParameters Dopp, pForm, _pNume, _pEmps, _pConsulta
58:     *--------------------------------------------------------------------------
59:     PROCEDURE Init(par_cDopp, par_oFormPai, par_nNume, par_cEmps, par_lConsulta)
60:         THIS.this_cDopp      = IIF(VARTYPE(par_cDopp)     = "C", ALLTRIM(par_cDopp), "")
61:         THIS.this_nPNumes    = IIF(VARTYPE(par_nNume)      = "N", par_nNume, 0)
62:         THIS.this_cPEmps     = IIF(VARTYPE(par_cEmps)      = "C", ALLTRIM(par_cEmps), "")
63:         THIS.this_lPConsulta = IIF(VARTYPE(par_lConsulta)  = "L", par_lConsulta, .F.)
64:         RETURN DODEFAULT()
65:     ENDPROC
66: 
67:     *--------------------------------------------------------------------------
68:     * InicializarForm - Chamado pelo FormBase.Init()
69:     * Cria BO, monta PageFrame, carrega dados iniciais
70:     *--------------------------------------------------------------------------
71:     PROTECTED PROCEDURE InicializarForm()
72:         LOCAL loc_lSucesso, loc_cEmpresaInicial
73:         loc_lSucesso      = .F.
74:         loc_cEmpresaInicial = ""
75: 
76:         TRY
77:             THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de Ind" + CHR(250) + "stria"
78: 
79:             THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp6BO")
80: 
81:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
82:                 MostrarErro("Erro ao criar sigpdmp6BO", "Erro Cr" + CHR(237) + "tico")
83:             ELSE
84:                 THIS.ConfigurarPageFrame()
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.ConfigurarPaginaDados()
87: 
88:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
90: 
91:                 *-- Inicializar empresa no filtro
92:                 loc_cEmpresaInicial = THIS.this_cPEmps
93:                 IF EMPTY(loc_cEmpresaInicial) AND VARTYPE(go_4c_Sistema) = "O"
94:                     loc_cEmpresaInicial = go_4c_Sistema.cCodEmpresa
95:                 ENDIF
96:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Cd_empresa.Value = loc_cEmpresaInicial
97:                 THIS.this_cPEmps = loc_cEmpresaInicial
98: 
99:                 THIS.pgf_4c_Paginas.Visible   = .T.
100:                 THIS.pgf_4c_Paginas.ActivePage = 1
101:                 THIS.this_cModoAtual = "LISTA"
102: 
103:                 THIS.CarregarLista()
104:                 loc_lSucesso = .T.
105:             ENDIF
106: 
107:         CATCH TO loException
108:             THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
109:             MostrarErro("Erro ao inicializar Formsigpdmp6:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
110:         ENDTRY
111: 
112:         RETURN loc_lSucesso
113:     ENDPROC
114: 
115:     *--------------------------------------------------------------------------
116:     * ConfigurarPageFrame - Configura PageFrame principal com 2 paginas
117:     * Top=-29 oculta abas do PageFrame; todos os controles nas Pages: Top += 29
118:     * Legado: Pagina.Top=-29, Left=-1, Width=1005, Height=635
119:     *--------------------------------------------------------------------------
120:     PROTECTED PROCEDURE ConfigurarPageFrame()
121:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
122: 
123:         WITH THIS.pgf_4c_Paginas
124:             .Top       = -29
125:             .Left      = -1
126:             .Width     = 1005
127:             .Height    = 631   && 635-4: Tabs=.F. via AddObject adiciona +4 ao Page.Height em runtime
128:             .PageCount = 2
129:             .Tabs      = .F.
130:             .Visible   = .T.
131:         ENDWITH
132: 
133:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
134:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
135:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
136: 
137:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
138:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
139:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
140:     ENDPROC
141: 
142:     *--------------------------------------------------------------------------
143:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, legenda,
144:     *   botao Fecha Lote, grade principal
145:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
146:     *--------------------------------------------------------------------------
147:     PROTECTED PROCEDURE ConfigurarPaginaLista()
148:         LOCAL loc_oPagina
149:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
150: 
151:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
152: 
153:         *-- Container de cabecalho (fundo cinza medio com titulo)
154:         *-- Legado: cntSombra.Top=2->31; Width=1100; BackColor do framework=RGB(100,100,100)
155:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
156:         WITH loc_oPagina.cnt_4c_Cabecalho
157:             .Top         = 31
158:             .Left        = 0
159:             .Width       = 1003
160:             .Height      = 80
161:             .BackStyle   = 1
162:             .BackColor   = RGB(100, 100, 100)
163:             .BorderWidth = 0
164:             .Visible     = .T.
165:         ENDWITH
166: 
167:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
168:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
169:             .Caption   = THIS.Caption
170:             .Top       = 15
171:             .Left      = 10
172:             .Width     = 769
173:             .Height    = 40
174:             .FontName  = "Tahoma"
175:             .FontSize  = 16
176:             .FontBold  = .T.
177:             .ForeColor = RGB(0, 0, 0)
178:             .BackStyle = 0
179:             .Visible   = .T.
180:         ENDWITH
181: 
182:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
183:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
184:             .Caption   = THIS.Caption
185:             .Top       = 18
186:             .Left      = 10
187:             .Width     = 769
188:             .Height    = 46
189:             .FontName  = "Tahoma"
190:             .FontSize  = 16
191:             .FontBold  = .T.
192:             .ForeColor = RGB(255, 255, 255)
193:             .BackStyle = 0
194:             .Visible   = .T.
195:         ENDWITH
196: 
197:         *-- Container de botoes CRUD (lado direito) - TRANSPARENTE
198:         *-- Legado: Grupo_op.Left=545, Top=-1+29=28, Width=385, Height=85

*-- Linhas 658 a 769:
658: 
659:         THIS.FormatarGridLista()
660: 
661:         *-- BINDEVENTs: botoes CRUD (handlers PUBLIC por regra CLAUDE.md #3)
662:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
663:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
664:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
665:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
666:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
667:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
668:         BINDEVENT(loc_oPagina.cmd_4c_Cmdfechalote,             "Click", THIS, "CmdFechaLoteClick")
669: 
670:         *-- BINDEVENTs: filtros de periodo
671:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Cd_empresa, "KeyPress", THIS, "FiltroEmpresaLostFocus")
672:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_inicial, "KeyPress", THIS, "FiltroDtInicialLostFocus")
673:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_final,   "KeyPress", THIS, "FiltroDtFinalLostFocus")
674: 
675:         THIS.TornarControlesVisiveis(loc_oPagina)
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * ConfigurarPaginaDados - Page2: botoes Salvar/Cancelar, faixa titulo,
680:     *   botoes de acao (Movimento/Componentes/Etiquetas/Servicos/EtqCompo/
681:     *   Boleto/Documento), busca OP, container de dados principais (cntDados),
682:     *   botao de apontamentos em aberto, shapes decorativos, campos Documento e Aceite
683:     * Fase 5: primeiros 50% dos campos
684:     * Compensacao PageFrame.Top=-29: controles Top += 29
685:     *--------------------------------------------------------------------------
686:     PROTECTED PROCEDURE ConfigurarPaginaDados()
687:         LOCAL loc_oPagina
688:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
689: 
690:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
691: 
692:         *-- Faixa de titulo no topo (TxtCaption no legado)
693:         *-- Legado: Top=1+29=30, Left=-3, Width=1301, Height=19
694:         loc_oPagina.AddObject("lbl_4c_TxtCaption", "Label")
695:         WITH loc_oPagina.lbl_4c_TxtCaption
696:             .Caption   = "     Movimenta" + CHR(231) + CHR(227) + "o"
697:             .Top       = 30
698:             .Left      = -3
699:             .Width     = 1301
700:             .Height    = 19
701:             .FontName  = "Tahoma"
702:             .FontBold  = .T.
703:             .BackStyle = 1
704:             .BackColor = RGB(90, 90, 90)
705:             .ForeColor = RGB(255, 255, 255)
706:             .Visible   = .T.
707:         ENDWITH
708: 
709:         *-- Shape decorativo atras dos botoes de acao (shpBtnGs no legado)
710:         *-- Legado: Top=14+29=43, Left=12, Width=432, Height=30
711:         loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
712:         WITH loc_oPagina.shp_4c_ShpBtnGs
713:             .Top         = 43
714:             .Left        = 12
715:             .Width       = 432
716:             .Height      = 30
717:             .BackStyle   = 0
718:             .BorderStyle = 0
719:             .BorderColor = RGB(36, 84, 155)
720:             .Visible     = .T.
721:         ENDWITH
722: 
723:         *-- Container de botoes de acao (Salvar / Cancelar)
724:         *-- Legado: Grupo_Salva.Left=843, Top=22+29=51, Width=160, Height=85
725:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
726:         WITH loc_oPagina.cnt_4c_BotoesAcao
727:             .Top         = 51
728:             .Left        = 843
729:             .Width       = 160
730:             .Height      = 85
731:             .BackStyle   = 0
732:             .BorderWidth = 0
733:             .Visible     = .T.
734:         ENDWITH
735: 
736:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
737:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
738:             .Top             = 5
739:             .Left            = 5
740:             .Width           = 75
741:             .Height          = 75
742:             .FontName        = "Comic Sans MS"
743:             .FontSize        = 8
744:             .Caption         = "Salvar"
745:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
746:             .PicturePosition = 13
747:             .ForeColor       = RGB(90, 90, 90)
748:             .BackColor       = RGB(255, 255, 255)
749:             .Themes          = .F.
750:             .Visible         = .T.
751:         ENDWITH
752: 
753:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
754:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
755:             .Top             = 5
756:             .Left            = 80
757:             .Width           = 75
758:             .Height          = 75
759:             .FontName        = "Comic Sans MS"
760:             .FontSize        = 8
761:             .Caption         = "Encerrar"
762:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
763:             .PicturePosition = 13
764:             .ForeColor       = RGB(90, 90, 90)
765:             .BackColor       = RGB(255, 255, 255)
766:             .Themes          = .F.
767:             .Visible         = .T.
768:         ENDWITH
769: 

*-- Linhas 1727 a 1860:
1727:             .Themes      = .F.
1728:             .Visible     = .T.
1729:         ENDWITH
1730: 
1731:         *-- BINDEVENTs: botoes Salvar/Cancelar
1732:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1733:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1734: 
1735:         *-- BINDEVENTs: botoes de acao operacionais
1736:         BINDEVENT(loc_oPagina.cmd_4c_Operacao,       "Click", THIS, "BtnOperacaoClick")
1737:         BINDEVENT(loc_oPagina.cmd_4c_Componentes,    "Click", THIS, "BtnComponentesClick")
1738:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,      "Click", THIS, "BtnEtiquetasClick")
1739:         BINDEVENT(loc_oPagina.cmd_4c_Servicos,       "Click", THIS, "BtnServicosClick")
1740:         BINDEVENT(loc_oPagina.cmd_4c_EtqCompo,       "Click", THIS, "BtnEtqCompoClick")
1741:         BINDEVENT(loc_oPagina.cmd_4c_Boleto,         "Click", THIS, "BtnBoletoClick")
1742:         BINDEVENT(loc_oPagina.cmd_4c_Documento,      "Click", THIS, "BtnDocumentoClick")
1743:         BINDEVENT(loc_oPagina.cmd_4c_Bot_Pendentes,  "Click", THIS, "BtnPendentesClick")
1744: 
1745:         *-- BINDEVENTs: campos de dados
1746:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data,  "KeyPress", THIS, "DtDataLostFocus")
1747:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Lote,     "KeyPress", THIS, "LoteLostFocus")
1748:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_TotPeso,  "KeyPress", THIS, "TotPesoLostFocus")
1749:         BINDEVENT(loc_oPagina.txt_4c_Buscaop,               "KeyPress", THIS, "BuscaOpLostFocus")
1750:         BINDEVENT(loc_oPagina.txt_4c_Docu,                  "KeyPress", THIS, "DocuLostFocus")
1751: 
1752:         *-- BINDEVENTs: container Origem (grupo/conta/nome com F4/F5)
1753:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrig,  "KeyPress", THIS, "GrupoOrigemLostFocus")
1754:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrig,  "KeyPress",  THIS, "TeclaGrupoOrigemKP")
1755:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrig,  "KeyPress", THIS, "ContaOrigemLostFocus")
1756:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrig,  "KeyPress",  THIS, "TeclaContaOrigemKP")
1757:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_DcontaOrig, "KeyPress", THIS, "DcontaOrigemLostFocus")
1758: 
1759:         *-- BINDEVENTs: container Destino (grupo/conta/nome com F4/F5)
1760:         BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_GrupoDest,  "KeyPress", THIS, "GrupoDestinoLostFocus")
1761:         BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_GrupoDest,  "KeyPress",  THIS, "TeclaGrupoDestinoKP")
1762:         BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_ContaDest,  "KeyPress", THIS, "ContaDestinoLostFocus")
1763:         BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_ContaDest,  "KeyPress",  THIS, "TeclaContaDestinoKP")
1764:         BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_DcontaDest, "KeyPress", THIS, "DcontaDestinoLostFocus")
1765: 
1766:         *-- BINDEVENTs: container Responsavel (grupo/conta/nome com F4/F5)
1767:         BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "GrupoRespLostFocus")
1768:         BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress",  THIS, "TeclaGrupoRespKP")
1769:         BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "ContaRespLostFocus")
1770:         BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress",  THIS, "TeclaContaRespKP")
1771:         BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "DcontaRespLostFocus")
1772: 
1773:         *-- BINDEVENTs: codigo observacao e botao CompoOp
1774:         BINDEVENT(loc_oPagina.txt_4c_Codobs,     "KeyPress", THIS, "CodobsLostFocus")
1775:         BINDEVENT(loc_oPagina.txt_4c_Codobs,     "KeyPress",  THIS, "TeclaCodobsKP")
1776:         BINDEVENT(loc_oPagina.cmd_4c_BtnCompoOp, "Click",     THIS, "BtnEtqCompoClick")
1777: 
1778:         THIS.TornarControlesVisiveis(loc_oPagina)
1779:         *-- Restaurar lblTotPeso para oculto (TornarControlesVisiveis seta .T. em tudo)
1780:         loc_oPagina.cnt_4c_Dados.lbl_4c_LblTotPeso.Visible = .F.
1781:         *-- GradeOperacao sempre oculta inicialmente (controle operacional)
1782:         loc_oPagina.grd_4c_GradeOperacao.Visible = .F.
1783:     ENDPROC
1784: 
1785:     *--------------------------------------------------------------------------
1786:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1787:     * Itera Pages de PageFrames e Controls de Containers
1788:     *--------------------------------------------------------------------------
1789:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1790:         LOCAL loc_nI, loc_oObjeto, loc_nP
1791: 
1792:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1793:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1794: 
1795:             IF VARTYPE(loc_oObjeto) = "O"
1796:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1797:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "CNT_4C_ORIGEM")
1798:                         loc_oObjeto.Visible = .T.
1799:                     ENDIF
1800:                 ENDIF
1801: 
1802:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1803:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1804:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1805:                     ENDFOR
1806:                 ENDIF
1807: 
1808:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1809:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1810:                 ENDIF
1811:             ENDIF
1812:         ENDFOR
1813:     ENDPROC
1814: 
1815:     *--------------------------------------------------------------------------
1816:     * FormatarGridLista - Define colunas da grade de lista de movimentos
1817:     * Campos do cursor_4c_Dados: numps, datas, dopps, nlotes, nops,
1818:     *   grupoos, contaos, grupods, contads, docus, totpesos...
1819:     *--------------------------------------------------------------------------
1820:     PROTECTED PROCEDURE FormatarGridLista()
1821:         LOCAL loc_oGrade
1822:         loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
1823: 
1824:         WITH loc_oGrade.Column1
1825:             .ControlSource = "cursor_4c_Dados.numps"
1826:             .Width         = 70
1827:             .Resizable     = .F.
1828:             .Movable       = .F.
1829:             .Header1.Caption   = "N" + CHR(250) + "m."
1830:             .Header1.Alignment = 2
1831:             .Header1.FontName  = "Tahoma"
1832:             .Header1.FontBold  = .T.
1833:             .Header1.FontSize  = 8
1834:         ENDWITH
1835: 
1836:         WITH loc_oGrade.Column2
1837:             .ControlSource = "cursor_4c_Dados.datas"
1838:             .Width         = 82
1839:             .Resizable     = .F.
1840:             .Movable       = .F.
1841:             .Header1.Caption   = "Data"
1842:             .Header1.Alignment = 2
1843:             .Header1.FontName  = "Tahoma"
1844:             .Header1.FontBold  = .T.
1845:             .Header1.FontSize  = 8
1846:         ENDWITH
1847: 
1848:         WITH loc_oGrade.Column3
1849:             .ControlSource = "cursor_4c_Dados.dopps"
1850:             .Width         = 140
1851:             .Resizable     = .F.
1852:             .Movable       = .F.
1853:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1854:             .Header1.Alignment = 2
1855:             .Header1.FontName  = "Tahoma"
1856:             .Header1.FontBold  = .T.
1857:             .Header1.FontSize  = 8
1858:         ENDWITH
1859: 
1860:         WITH loc_oGrade.Column4

*-- Linhas 1922 a 2225:
1922:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1923:     * par_nPagina: 1=Lista, 2=Dados
1924:     *--------------------------------------------------------------------------
1925:     PROCEDURE AlternarPagina(par_nPagina)
1926:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1927:         IF par_nPagina = 1
1928:             THIS.this_cModoAtual = "LISTA"
1929:             THIS.AjustarBotoesPorModo()
1930:             THIS.CarregarLista()
1931:         ELSE
1932:             THIS.this_cModoAtual = "DADOS"
1933:         ENDIF
1934:     ENDPROC
1935: 
1936:     *--------------------------------------------------------------------------
1937:     * CarregarLista - Carrega movimentos na grade conforme filtros de periodo
1938:     * Usa empresa, dopp e datas do cnt_4c_Periodo como filtros
1939:     *--------------------------------------------------------------------------
1940:     PROCEDURE CarregarLista()
1941:         LOCAL loc_cEmps, loc_dDtI, loc_dDtF, loc_lOk
1942: 
1943:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1944:             RETURN
1945:         ENDIF
1946: 
1947:         loc_cEmps = ""
1948:         loc_dDtI  = {}
1949:         loc_dDtF  = {}
1950:         loc_lOk   = .F.
1951: 
1952:         TRY
1953:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1954:                 loc_cEmps = ALLTRIM(.txt_4c_Cd_empresa.Value)
1955:                 loc_dDtI  = .txt_4c_Dt_inicial.Value
1956:                 loc_dDtF  = .txt_4c_Dt_final.Value
1957:                 .Visible     = .T.
1958:             ENDWITH
1959: 
1960:             loc_lOk = THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, THIS.this_cDopp, loc_dDtI, loc_dDtF)
1961: 
1962:             IF loc_lOk
1963:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 8
1964:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1965:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.numps"
1966:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.datas"
1967:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column3.ControlSource = "cursor_4c_Dados.dopps"
1968:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column4.ControlSource = "cursor_4c_Dados.nlotes"
1969:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column5.ControlSource = "cursor_4c_Dados.grupoos"
1970:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column6.ControlSource = "cursor_4c_Dados.contaos"
1971:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column7.ControlSource = "cursor_4c_Dados.grupods"
1972:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column8.ControlSource = "cursor_4c_Dados.contads"
1973:                 THIS.FormatarGridLista()
1974:             ENDIF
1975: 
1976:         CATCH TO loc_oErro
1977:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
1978:         ENDTRY
1979:     ENDPROC
1980: 
1981:     *--------------------------------------------------------------------------
1982:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1983:     *--------------------------------------------------------------------------
1984:     PROCEDURE AjustarBotoesPorModo()
1985:         LOCAL loc_lEhLista, loc_lTemRegistro, loc_lPodeEditar
1986:         LOCAL loc_oPg1, loc_oPg2
1987: 
1988:         loc_lEhLista     = (THIS.this_cModoAtual = "LISTA")
1989:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1990:         loc_lPodeEditar  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1991: 
1992:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1993:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1994: 
1995:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEhLista
1996:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEhLista AND loc_lTemRegistro
1997:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEhLista AND loc_lTemRegistro
1998:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEhLista AND loc_lTemRegistro
1999:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEhLista
2000:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEhLista
2001: 
2002:         IF PEMSTATUS(loc_oPg1, "cmd_4c_Cmdfechalote", 5)
2003:             loc_oPg1.cmd_4c_Cmdfechalote.Enabled = loc_lEhLista AND loc_lTemRegistro
2004:         ENDIF
2005: 
2006:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2007:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
2008:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
2009:             ENDIF
2010:         ENDIF
2011:     ENDPROC
2012: 
2013:     *--------------------------------------------------------------------------
2014:     * BtnIncluirClick - Abre Page2 em modo inclusao
2015:     *--------------------------------------------------------------------------
2016:     PROCEDURE BtnIncluirClick()
2017:         THIS.this_oBusinessObject.NovoRegistro()
2018:         THIS.this_cModoAtual = "INCLUIR"
2019:         THIS.this_nPNumes    = 0
2020:         THIS.LimparCamposDados()
2021:         THIS.AjustarBotoesPorModo()
2022:         THIS.HabilitarCampos(.T.)
2023:         THIS.AlternarPagina(2)
2024:     ENDPROC
2025: 
2026:     *--------------------------------------------------------------------------
2027:     * BtnVisualizarClick - Abre Page2 em modo consulta (somente leitura)
2028:     *--------------------------------------------------------------------------
2029:     PROCEDURE BtnVisualizarClick()
2030:         LOCAL loc_cCidChaves
2031:         loc_cCidChaves = ""
2032: 
2033:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2034:             MsgAviso("Nenhum registro selecionado.", "Aviso")
2035:             RETURN
2036:         ENDIF
2037: 
2038:         SELECT cursor_4c_Dados
2039:         loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
2040:         THIS.this_nPNumes    = cursor_4c_Dados.numps
2041:         THIS.this_cModoAtual = "VISUALIZAR"
2042: 
2043:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2044:             THIS.BOParaForm()
2045:             THIS.AjustarBotoesPorModo()
2046:             THIS.HabilitarCampos(.F.)
2047:             THIS.AlternarPagina(2)
2048:         ELSE
2049:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
2050:         ENDIF
2051:     ENDPROC
2052: 
2053:     *--------------------------------------------------------------------------
2054:     * BtnAlterarClick - Abre Page2 em modo edicao
2055:     *--------------------------------------------------------------------------
2056:     PROCEDURE BtnAlterarClick()
2057:         LOCAL loc_cCidChaves
2058:         loc_cCidChaves = ""
2059: 
2060:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2061:             MsgAviso("Nenhum registro selecionado.", "Aviso")
2062:             RETURN
2063:         ENDIF
2064: 
2065:         SELECT cursor_4c_Dados
2066:         loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
2067:         THIS.this_nPNumes    = cursor_4c_Dados.numps
2068:         THIS.this_cModoAtual = "ALTERAR"
2069: 
2070:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2071:             THIS.this_oBusinessObject.EditarRegistro()
2072:             THIS.BOParaForm()
2073:             THIS.AjustarBotoesPorModo()
2074:             THIS.HabilitarCampos(.T.)
2075:             THIS.AlternarPagina(2)
2076:         ELSE
2077:             MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
2078:         ENDIF
2079:     ENDPROC
2080: 
2081:     *--------------------------------------------------------------------------
2082:     * BtnExcluirClick - Confirma e exclui o registro selecionado
2083:     *--------------------------------------------------------------------------
2084:     PROCEDURE BtnExcluirClick()
2085:         LOCAL loc_lResultado, loc_nNumps, loc_cCidChaves
2086:         loc_lResultado = .F.
2087:         loc_nNumps     = 0
2088:         loc_cCidChaves = ""
2089: 
2090:         TRY
2091:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2092:                 MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
2093:             ELSE
2094:                 SELECT cursor_4c_Dados
2095:                 loc_nNumps     = cursor_4c_Dados.numps
2096:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
2097: 
2098:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do movimento " + TRANSFORM(loc_nNumps) + "?", "Confirmar Exclus" + CHR(227) + "o")
2099:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2100:                         IF THIS.this_oBusinessObject.Excluir()
2101:                             THIS.CarregarLista()
2102:                             THIS.AjustarBotoesPorModo()
2103:                         ELSE
2104:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
2105:                         ENDIF
2106:                     ELSE
2107:                         MsgErro("Erro ao carregar movimento para exclus" + CHR(227) + "o.", "Erro")
2108:                     ENDIF
2109:                 ENDIF
2110: 
2111:                 loc_lResultado = .T.
2112:             ENDIF
2113: 
2114:         CATCH TO loc_oErro
2115:             MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
2116:         ENDTRY
2117:     ENDPROC
2118: 
2119:     *--------------------------------------------------------------------------
2120:     * BtnBuscarClick - Recarrega lista com filtros atuais
2121:     *--------------------------------------------------------------------------
2122:     PROCEDURE BtnBuscarClick()
2123:         THIS.CarregarLista()
2124:         THIS.AjustarBotoesPorModo()
2125:     ENDPROC
2126: 
2127:     *--------------------------------------------------------------------------
2128:     * BtnEncerrarClick - Fecha o formulario
2129:     *--------------------------------------------------------------------------
2130:     PROCEDURE BtnEncerrarClick()
2131:         THIS.Release()
2132:     ENDPROC
2133: 
2134:     *--------------------------------------------------------------------------
2135:     * BtnSalvarClick - Valida, grava e retorna para lista
2136:     *--------------------------------------------------------------------------
2137:     PROCEDURE BtnSalvarClick()
2138:         LOCAL loc_lResultado, loc_lOk
2139:         loc_lResultado = .F.
2140:         loc_lOk        = .F.
2141: 
2142:         TRY
2143:             IF THIS.ValidarCamposDados()
2144:                 THIS.FormParaBO()
2145: 
2146:                 IF THIS.this_cModoAtual = "INCLUIR"
2147:                     loc_lOk = THIS.this_oBusinessObject.Inserir()
2148:                 ELSE
2149:                     loc_lOk = THIS.this_oBusinessObject.Atualizar()
2150:                 ENDIF
2151: 
2152:                 IF loc_lOk
2153:                     THIS.AlternarPagina(1)
2154:                 ELSE
2155:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
2156:                 ENDIF
2157:             ENDIF
2158: 
2159:             loc_lResultado = .T.
2160: 
2161:         CATCH TO loc_oErro
2162:             MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
2163:         ENDTRY
2164:     ENDPROC
2165: 
2166:     *--------------------------------------------------------------------------
2167:     * BtnCancelarClick - Descarta edicao e retorna para lista
2168:     *--------------------------------------------------------------------------
2169:     PROCEDURE BtnCancelarClick()
2170:         THIS.AlternarPagina(1)
2171:     ENDPROC
2172: 
2173:     *--------------------------------------------------------------------------
2174:     * CmdFechaLoteClick - Fecha ou cancela fechamento do lote selecionado
2175:     * Legado: cmdfechalote.Click - SELECT SigPdNlt.Chksubn, UPDATE Chksubn
2176:     *--------------------------------------------------------------------------
2177:     PROCEDURE CmdFechaLoteClick()
2178:         LOCAL loc_lResultado, loc_nLote, loc_cSQL, loc_nRet, loc_lSubn
2179:         loc_lResultado = .F.
2180:         loc_nLote      = 0
2181:         loc_lSubn      = .F.
2182: 
2183:         TRY
2184:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2185:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
2186:             ELSE
2187:                 SELECT cursor_4c_Dados
2188:                 loc_nLote = cursor_4c_Dados.nlotes
2189: 
2190:                 loc_cSQL = "SELECT Chksubn FROM SigPdNlt WHERE nlotes = " + TRANSFORM(loc_nLote)
2191:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NltTemp")
2192: 
2193:                 IF loc_nRet > 0 AND USED("cursor_4c_NltTemp") AND RECCOUNT("cursor_4c_NltTemp") > 0
2194:                     GO TOP IN cursor_4c_NltTemp
2195:                     loc_lSubn = cursor_4c_NltTemp.Chksubn
2196:                 ENDIF
2197: 
2198:                 IF USED("cursor_4c_NltTemp")
2199:                     USE IN cursor_4c_NltTemp
2200:                 ENDIF
2201: 
2202:                 IF loc_lSubn
2203:                     IF MsgConfirma("Cancelar o fechamento do lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
2204:                         loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 0 WHERE nlotes = " + TRANSFORM(loc_nLote)
2205:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
2206:                         IF loc_nRet > 0
2207:                             THIS.CarregarLista()
2208:                         ELSE
2209:                             MsgErro("Erro ao cancelar fechamento do lote.", "Erro")
2210:                         ENDIF
2211:                     ENDIF
2212:                 ELSE
2213:                     IF MsgConfirma("Fechar o lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
2214:                         loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 1 WHERE nlotes = " + TRANSFORM(loc_nLote)
2215:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
2216:                         IF loc_nRet > 0
2217:                             THIS.CarregarLista()
2218:                         ELSE
2219:                             MsgErro("Erro ao fechar lote.", "Erro")
2220:                         ENDIF
2221:                     ENDIF
2222:                 ENDIF
2223: 
2224:                 loc_lResultado = .T.
2225:             ENDIF

*-- Linhas 2235 a 2318:
2235:     *--------------------------------------------------------------------------
2236:     * FiltroEmpresaLostFocus - Recarrega lista se empresa mudou
2237:     *--------------------------------------------------------------------------
2238:     PROCEDURE FiltroEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2239:         LOCAL loc_cEmps
2240:         loc_cEmps = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Cd_empresa.Value)
2241:         IF loc_cEmps != THIS.this_cAntEmpr
2242:             THIS.this_cAntEmpr = loc_cEmps
2243:             THIS.this_cPEmps   = loc_cEmps
2244:             THIS.CarregarLista()
2245:             THIS.AjustarBotoesPorModo()
2246:         ENDIF
2247:     ENDPROC
2248: 
2249:     *--------------------------------------------------------------------------
2250:     * FiltroDtInicialLostFocus - Recarrega lista se data inicial mudou
2251:     *--------------------------------------------------------------------------
2252:     PROCEDURE FiltroDtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2253:         LOCAL loc_dDtI
2254:         loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Dt_inicial.Value
2255:         IF loc_dDtI != THIS.this_dAntDtIni
2256:             THIS.this_dAntDtIni = loc_dDtI
2257:             THIS.CarregarLista()
2258:             THIS.AjustarBotoesPorModo()
2259:         ENDIF
2260:     ENDPROC
2261: 
2262:     *--------------------------------------------------------------------------
2263:     * FiltroDtFinalLostFocus - Recarrega lista se data final mudou
2264:     *--------------------------------------------------------------------------
2265:     PROCEDURE FiltroDtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2266:         LOCAL loc_dDtF
2267:         loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Dt_final.Value
2268:         IF loc_dDtF != THIS.this_dAntDtFin
2269:             THIS.this_dAntDtFin = loc_dDtF
2270:             THIS.CarregarLista()
2271:             THIS.AjustarBotoesPorModo()
2272:         ENDIF
2273:     ENDPROC
2274: 
2275:     *--------------------------------------------------------------------------
2276:     * FormParaBO - Copia campos do formulario para o BO (Page2)
2277:     *--------------------------------------------------------------------------
2278:     PROTECTED PROCEDURE FormParaBO()
2279:         LOCAL loc_oPg2, loc_oCnt, loc_oBO, loc_nCod
2280: 
2281:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2282:         loc_oCnt  = .NULL.
2283:         loc_oBO   = THIS.this_oBusinessObject
2284:         loc_nCod  = 0
2285: 
2286:         TRY
2287:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2288:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2289:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
2290:                     loc_oBO.this_nNumps = IIF(VARTYPE(loc_oCnt.txt_4c_Codigo.Value) = "N", loc_oCnt.txt_4c_Codigo.Value, 0)
2291:                 ENDIF
2292:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2293:                     loc_oBO.this_dDatas = IIF(VARTYPE(loc_oCnt.txt_4c_Dt_data.Value) = "D", loc_oCnt.txt_4c_Dt_data.Value, {})
2294:                 ENDIF
2295:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2296:                     loc_oBO.this_nNLotes = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
2297:                 ENDIF
2298:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2299:                     loc_oBO.this_nPesoLancs = IIF(VARTYPE(loc_oCnt.txt_4c_TotPeso.Value) = "N", loc_oCnt.txt_4c_TotPeso.Value, 0)
2300:                 ENDIF
2301:             ENDIF
2302:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2303:                 loc_oBO.this_cDocus = ALLTRIM(IIF(VARTYPE(loc_oPg2.txt_4c_Docu.Value) = "C", loc_oPg2.txt_4c_Docu.Value, ""))
2304:             ENDIF
2305:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2306:                 loc_oBO.this_nNAceites = IIF(VARTYPE(loc_oPg2.txt_4c_Fwget1.Value) = "N", loc_oPg2.txt_4c_Fwget1.Value, 0)
2307:             ENDIF
2308:             *-- Container Origem
2309:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2310:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
2311:                     loc_oBO.this_cGrupoos = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
2312:                 ENDIF
2313:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
2314:                     loc_oBO.this_cContaos = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value) = "C", loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value, ""))
2315:                 ENDIF
2316:             ENDIF
2317:             *-- Container Destino
2318:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)

*-- Linhas 2348 a 2391:
2348:     *--------------------------------------------------------------------------
2349:     * BOParaForm - Copia dados do BO para os campos do formulario (Page2)
2350:     *--------------------------------------------------------------------------
2351:     PROTECTED PROCEDURE BOParaForm()
2352:         LOCAL loc_oPg2, loc_oCnt, loc_oBO
2353: 
2354:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2355:         loc_oCnt = .NULL.
2356:         loc_oBO  = THIS.this_oBusinessObject
2357: 
2358:         TRY
2359:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2360:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2361:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
2362:                     loc_oCnt.txt_4c_Codigo.Value = loc_oBO.this_nNumps
2363:                 ENDIF
2364:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2365:                     loc_oCnt.txt_4c_Dt_data.Value = IIF(VARTYPE(loc_oBO.this_dDatas) = "D", loc_oBO.this_dDatas, {})
2366:                 ENDIF
2367:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2368:                     loc_oCnt.txt_4c_Lote.Value = loc_oBO.this_nNLotes
2369:                 ENDIF
2370:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2371:                     loc_oCnt.txt_4c_TotPeso.Value = loc_oBO.this_nPesoLancs
2372:                 ENDIF
2373:             ENDIF
2374:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2375:                 loc_oPg2.txt_4c_Docu.Value = loc_oBO.this_cDocus
2376:             ENDIF
2377:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2378:                 loc_oPg2.txt_4c_Fwget1.Value = loc_oBO.this_nNAceites
2379:             ENDIF
2380:             *-- Container Origem
2381:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2382:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
2383:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = loc_oBO.this_cGrupoos
2384:                 ENDIF
2385:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
2386:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_oBO.this_cContaos
2387:                 ENDIF
2388:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
2389:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = THIS.this_cNomeContaos
2390:                 ENDIF
2391:             ENDIF

*-- Linhas 2428 a 2471:
2428:     *--------------------------------------------------------------------------
2429:     * LimparCamposDados - Limpa campos da Page2 (INCLUIR)
2430:     *--------------------------------------------------------------------------
2431:     PROTECTED PROCEDURE LimparCamposDados()
2432:         LOCAL loc_oPg2, loc_oCnt
2433: 
2434:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2435:         loc_oCnt = .NULL.
2436: 
2437:         TRY
2438:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2439:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2440:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
2441:                     loc_oCnt.txt_4c_Codigo.Value = 0
2442:                 ENDIF
2443:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2444:                     loc_oCnt.txt_4c_Dt_data.Value = DATE()
2445:                 ENDIF
2446:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2447:                     loc_oCnt.txt_4c_Lote.Value = 0
2448:                 ENDIF
2449:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2450:                     loc_oCnt.txt_4c_TotPeso.Value = 0
2451:                 ENDIF
2452:             ENDIF
2453:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2454:                 loc_oPg2.txt_4c_Docu.Value = ""
2455:             ENDIF
2456:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2457:                 loc_oPg2.txt_4c_Fwget1.Value = 0
2458:             ENDIF
2459:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2460:                 loc_oPg2.txt_4c_Buscaop.Value = 0
2461:             ENDIF
2462:             *-- Container Origem
2463:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2464:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
2465:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = ""
2466:                 ENDIF
2467:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
2468:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
2469:                 ENDIF
2470:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
2471:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""

*-- Linhas 2515 a 2558:
2515:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
2516:     * par_lHabilitar: .T. = edicao, .F. = somente leitura
2517:     *--------------------------------------------------------------------------
2518:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2519:         LOCAL loc_oPg2, loc_oCnt, loc_lRO, loc_lROOrig
2520: 
2521:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2522:         loc_oCnt    = .NULL.
2523:         loc_lRO     = !par_lHabilitar
2524:         loc_lROOrig = .T.
2525: 
2526:         TRY
2527:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2528:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2529:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2530:                     loc_oCnt.txt_4c_Dt_data.ReadOnly = loc_lRO
2531:                 ENDIF
2532:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2533:                     loc_oCnt.txt_4c_Lote.ReadOnly = loc_lRO
2534:                 ENDIF
2535:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2536:                     loc_oCnt.txt_4c_TotPeso.ReadOnly = loc_lRO
2537:                 ENDIF
2538:             ENDIF
2539:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2540:                 loc_oPg2.txt_4c_Docu.ReadOnly = loc_lRO
2541:             ENDIF
2542:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2543:                 loc_oPg2.txt_4c_Buscaop.ReadOnly = loc_lRO
2544:             ENDIF
2545:             *-- txt_4c_Codigo eh sempre ReadOnly (gerado pelo sistema)
2546:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2547:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
2548:                     loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.ReadOnly = .T.
2549:                 ENDIF
2550:             ENDIF
2551:             *-- txt_4c_Fwget1 (Aceite) eh sempre ReadOnly (calculado)
2552:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2553:                 loc_oPg2.txt_4c_Fwget1.ReadOnly = .T.
2554:             ENDIF
2555:             *-- Container Origem: grupo/conta editaveis conforme modo e flag EditaOrig
2556:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2557:                 loc_lROOrig = IIF(THIS.this_lEditaOrig, loc_lRO, .T.)
2558:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)

*-- Linhas 2609 a 3011:
2609: 
2610:     *--------------------------------------------------------------------------
2611:     * ValidarCamposDados - Valida campos obrigatorios da Page2
2612:     * Retorna .T. se valido, .F. se houver erro (com MsgAviso)
2613:     *--------------------------------------------------------------------------
2614:     PROTECTED PROCEDURE ValidarCamposDados()
2615:         LOCAL loc_lValido, loc_oPg2, loc_oCnt, loc_dDatas
2616: 
2617:         loc_lValido = .T.
2618:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2619:         loc_oCnt    = .NULL.
2620:         loc_dDatas  = {}
2621: 
2622:         TRY
2623:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2624:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2625: 
2626:                 *-- Data obrigatoria (campo principal de controle)
2627:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2628:                     loc_dDatas = loc_oCnt.txt_4c_Dt_data.Value
2629:                     IF EMPTY(loc_dDatas)
2630:                         MsgAviso("Data do movimento " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
2631:                         loc_oCnt.txt_4c_Dt_data.SetFocus()
2632:                         loc_lValido = .F.
2633:                     ENDIF
2634:                 ENDIF
2635:             ENDIF
2636:         CATCH TO loc_oErro
2637:             MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2638:             loc_lValido = .F.
2639:         ENDTRY
2640: 
2641:         RETURN loc_lValido
2642:     ENDPROC
2643: 
2644:     *--------------------------------------------------------------------------
2645:     * BtnOperacaoClick - Abre subformulario de Operacao (SigPdMp5)
2646:     * Legado: Operacao.Click - Do Form SigPdMp5 With ThisForm, DataSessionId
2647:     *--------------------------------------------------------------------------
2648:     PROCEDURE BtnOperacaoClick()
2649:         LOCAL loc_lResultado
2650:         loc_lResultado = .F.
2651:         TRY
2652:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2653:                 THIS.Enabled = .F.
2654:                 DO FORM FormSigPdMp5 WITH THIS, THIS.DataSessionId
2655:                 THIS.Enabled = .T.
2656:             ENDIF
2657:             loc_lResultado = .T.
2658:         CATCH TO loc_oErro
2659:             THIS.Enabled = .T.
2660:             MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2661:         ENDTRY
2662:     ENDPROC
2663: 
2664:     *--------------------------------------------------------------------------
2665:     * BtnComponentesClick - Abre subformulario de Componentes (SigPdMp4)
2666:     * Legado: Componentes.Click - Do Form SigPdMp4 With ThisForm
2667:     *--------------------------------------------------------------------------
2668:     PROCEDURE BtnComponentesClick()
2669:         LOCAL loc_lResultado
2670:         loc_lResultado = .F.
2671:         TRY
2672:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2673:                 THIS.Enabled = .F.
2674:                 DO FORM FormSigPdMp4 WITH THIS
2675:                 THIS.Enabled = .T.
2676:             ENDIF
2677:             loc_lResultado = .T.
2678:         CATCH TO loc_oErro
2679:             THIS.Enabled = .T.
2680:             MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loc_oErro.Message, "Erro")
2681:         ENDTRY
2682:     ENDPROC
2683: 
2684:     *--------------------------------------------------------------------------
2685:     * BtnEtiquetasClick - Abre subformulario de Etiquetas (SigPdMp3)
2686:     * Legado: Etiquetas.Click - Do Form SigPdMp3 With ThisForm, DataSessionId
2687:     *--------------------------------------------------------------------------
2688:     PROCEDURE BtnEtiquetasClick()
2689:         LOCAL loc_lResultado
2690:         loc_lResultado = .F.
2691:         TRY
2692:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2693:                 THIS.Enabled = .F.
2694:                 DO FORM FormSigPdMp3 WITH THIS, THIS.DataSessionId
2695:                 THIS.Enabled = .T.
2696:             ENDIF
2697:             loc_lResultado = .T.
2698:         CATCH TO loc_oErro
2699:             THIS.Enabled = .T.
2700:             MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
2701:         ENDTRY
2702:     ENDPROC
2703: 
2704:     *--------------------------------------------------------------------------
2705:     * BtnServicosClick - Abre subformulario de Servicos (SigPdM11)
2706:     * Legado: Servicos.Click - If Not InList(pcEscolha,'PROCURAR','INSERIR')
2707:     *   -> Do Form SigPdM11 With ThisForm, DataSessionId
2708:     *--------------------------------------------------------------------------
2709:     PROCEDURE BtnServicosClick()
2710:         LOCAL loc_lResultado
2711:         loc_lResultado = .F.
2712:         TRY
2713:             IF THIS.this_cModoAtual = "ALTERAR"
2714:                 THIS.Enabled = .F.
2715:                 DO FORM FormSigPdM11 WITH THIS, THIS.DataSessionId
2716:                 THIS.Enabled = .T.
2717:             ENDIF
2718:             loc_lResultado = .T.
2719:         CATCH TO loc_oErro
2720:             THIS.Enabled = .T.
2721:             MostrarErro("Erro ao abrir Servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
2722:         ENDTRY
2723:     ENDPROC
2724: 
2725:     *--------------------------------------------------------------------------
2726:     * BtnEtqCompoClick - Imprime etiquetas de componentes das OPs (SigOpIbo)
2727:     * Legado: btnCompoOp.Click - Do Form SigOpIbo With Thisform, 20, Titulo,...
2728:     *--------------------------------------------------------------------------
2729:     PROCEDURE BtnEtqCompoClick()
2730:         LOCAL loc_lResultado
2731:         loc_lResultado = .F.
2732:         TRY
2733:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2734:                 DO FORM SigOpIbo WITH THIS, 20, THIS.Caption, .F., .F., .F., .F., .F., 0
2735:             ENDIF
2736:             loc_lResultado = .T.
2737:         CATCH TO loc_oErro
2738:             MostrarErro("Erro ao imprimir Etiquetas de Componentes:" + CHR(13) + loc_oErro.Message, "Erro")
2739:         ENDTRY
2740:     ENDPROC
2741: 
2742:     *--------------------------------------------------------------------------
2743:     * BtnBoletoClick - Verifica config de boleto e chama ImpBol()
2744:     * Legado: Boleto.Click - Seek(_Dopp, 'crSigCdOpd') + ImpBol() if Boletos in (1,3)
2745:     *--------------------------------------------------------------------------
2746:     PROCEDURE BtnBoletoClick()
2747:         LOCAL loc_lResultado, loc_nRet, loc_nBoletos
2748: 
2749:         loc_lResultado = .F.
2750:         loc_nBoletos   = 0
2751: 
2752:         TRY
2753:             IF EMPTY(THIS.this_cDopp)
2754:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
2755:             ELSE
2756:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2757:                     "SELECT Boletos FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
2758:                     "cursor_4c_BoletoConf")
2759:                 IF loc_nRet > 0 AND USED("cursor_4c_BoletoConf") AND RECCOUNT("cursor_4c_BoletoConf") > 0
2760:                     GO TOP IN cursor_4c_BoletoConf
2761:                     loc_nBoletos = cursor_4c_BoletoConf.Boletos
2762:                 ENDIF
2763:                 IF USED("cursor_4c_BoletoConf")
2764:                     USE IN cursor_4c_BoletoConf
2765:                 ENDIF
2766:                 IF INLIST(loc_nBoletos, 1, 3)
2767:                     THIS.ImpBol()
2768:                 ENDIF
2769:                 loc_lResultado = .T.
2770:             ENDIF
2771:         CATCH TO loc_oErro
2772:             IF USED("cursor_4c_BoletoConf")
2773:                 USE IN cursor_4c_BoletoConf
2774:             ENDIF
2775:             MostrarErro("Erro ao processar Boleto:" + CHR(13) + loc_oErro.Message, "Erro")
2776:         ENDTRY
2777:     ENDPROC
2778: 
2779:     *--------------------------------------------------------------------------
2780:     * ImpBol - Imprime boleto do movimento corrente
2781:     * Legado: SIGPDMP6.ImpBol (metodo nao extraido no mapeamento automatico)
2782:     *   Abre o formulario de cabecalho de movimento para impressao do boleto
2783:     *--------------------------------------------------------------------------
2784:     PROCEDURE ImpBol()
2785:         LOCAL loc_lResultado, loc_cEmps, loc_cDopps, loc_nNumps
2786: 
2787:         loc_lResultado = .F.
2788:         loc_cEmps  = THIS.this_oBusinessObject.this_cEmps
2789:         loc_cDopps = THIS.this_oBusinessObject.this_cDopps
2790:         loc_nNumps = THIS.this_nPNumes
2791: 
2792:         TRY
2793:             DO FORM SigBolet WITH loc_cEmps, loc_cDopps, loc_nNumps
2794:             loc_lResultado = .T.
2795:         CATCH TO loc_oErro
2796:             MostrarErro("Erro ao imprimir Boleto:" + CHR(13) + loc_oErro.Message, "Erro")
2797:         ENDTRY
2798:     ENDPROC
2799: 
2800:     *--------------------------------------------------------------------------
2801:     * BtnDocumentoClick - Abre formulario de documento de producao (SigReDct)
2802:     * Legado: Documento.Click - Do Form SigReDct With TmpNens.Emps, Dopps, Numps
2803:     *   Condicao: crSigCdOpd.Docus = 1 And crSigCdOpd.etiqs = 1
2804:     *--------------------------------------------------------------------------
2805:     PROCEDURE BtnDocumentoClick()
2806:         LOCAL loc_lResultado, loc_nRet, loc_nDocus, loc_nEtiqs, loc_cEmps, loc_cDopps
2807: 
2808:         loc_lResultado = .F.
2809:         loc_nDocus     = 0
2810:         loc_nEtiqs     = 0
2811:         loc_cEmps      = THIS.this_oBusinessObject.this_cEmps
2812:         loc_cDopps     = THIS.this_oBusinessObject.this_cDopps
2813: 
2814:         TRY
2815:             IF EMPTY(THIS.this_cDopp)
2816:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
2817:             ELSE
2818:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2819:                     "SELECT Docus, Etiqs FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
2820:                     "cursor_4c_DocConf")
2821:                 IF loc_nRet > 0 AND USED("cursor_4c_DocConf") AND RECCOUNT("cursor_4c_DocConf") > 0
2822:                     GO TOP IN cursor_4c_DocConf
2823:                     loc_nDocus = cursor_4c_DocConf.Docus
2824:                     loc_nEtiqs = cursor_4c_DocConf.Etiqs
2825:                 ENDIF
2826:                 IF USED("cursor_4c_DocConf")
2827:                     USE IN cursor_4c_DocConf
2828:                 ENDIF
2829:                 IF loc_nDocus = 1 AND loc_nEtiqs = 1
2830:                     DO FORM FormSigReDct WITH loc_cEmps, loc_cDopps, THIS.this_nPNumes
2831:                 ENDIF
2832:                 loc_lResultado = .T.
2833:             ENDIF
2834:         CATCH TO loc_oErro
2835:             IF USED("cursor_4c_DocConf")
2836:                 USE IN cursor_4c_DocConf
2837:             ENDIF
2838:             MostrarErro("Erro ao abrir Documento:" + CHR(13) + loc_oErro.Message, "Erro")
2839:         ENDTRY
2840:     ENDPROC
2841: 
2842:     *--------------------------------------------------------------------------
2843:     * Handler click do botao de apontamentos em aberto - abre SigOpMpn
2844:     * Legado: cmd_Apontamentos.Click - If INSERIR and contaos nao vazia
2845:     *   and lnBot=0 and xNensi vazio -> Do Form SigOpMpn With ThisForm, DataSessionId
2846:     *--------------------------------------------------------------------------
2847:     PROCEDURE BtnPendentesClick()
2848:         LOCAL loc_lResultado, loc_cContaOs
2849: 
2850:         loc_lResultado = .F.
2851:         loc_cContaOs   = THIS.this_oBusinessObject.this_cContaos
2852: 
2853:         TRY
2854:             IF THIS.this_cModoAtual = "INCLUIR"
2855:                 IF EMPTY(ALLTRIM(loc_cContaOs))
2856:                     MsgAviso("Informe a Conta de Origem!", "Aviso")
2857:                 ELSE
2858:                     THIS.Enabled = .F.
2859:                     DO FORM SigOpMpn WITH THIS, THIS.DataSessionId
2860:                     THIS.Enabled = .T.
2861:                 ENDIF
2862:             ENDIF
2863:             loc_lResultado = .T.
2864:         CATCH TO loc_oErro
2865:             THIS.Enabled = .T.
2866:             MostrarErro("Erro ao abrir Pend" + CHR(234) + "ncias:" + CHR(13) + loc_oErro.Message, "Erro")
2867:         ENDTRY
2868:     ENDPROC
2869: 
2870:     *--------------------------------------------------------------------------
2871:     * DtDataLostFocus - Tratamento ao sair do campo Data do movimento
2872:     * Legado: Dt_data.LostFocus - Se INSERIR e numeras=1 e op unica vazia
2873:     *   -> SetFocus na GradeOperacao (Phase 6: Grade ainda nao existe)
2874:     *--------------------------------------------------------------------------
2875:     PROCEDURE DtDataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2876:         LOCAL loc_oPg2, loc_dDatas
2877: 
2878:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2879:         loc_dDatas = {}
2880: 
2881:         TRY
2882:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
2883:                 loc_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
2884:                 IF !EMPTY(loc_dDatas)
2885:                     THIS.this_oBusinessObject.this_dDatas = loc_dDatas
2886:                 ENDIF
2887:             ENDIF
2888:         CATCH TO loc_oErro
2889:             MostrarErro("Erro em DtDataLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2890:         ENDTRY
2891:     ENDPROC
2892: 
2893:     *--------------------------------------------------------------------------
2894:     * LoteLostFocus - Valida o numero do lote contra SigPdNlt
2895:     * Legado: Get_Lote.Valid - Select nlotes, Datas From SigPdNlt
2896:     *   Where EmpGruEsts = emps+grupoos+contaos And Chksubn = 0
2897:     *--------------------------------------------------------------------------
2898:     PROCEDURE LoteLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2899:         LOCAL loc_oPg2, loc_oCnt, loc_nLote, loc_nRet, loc_cWhere
2900: 
2901:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2902:         loc_oCnt  = .NULL.
2903:         loc_nLote = 0
2904: 
2905:         TRY
2906:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2907:                 loc_oCnt  = loc_oPg2.cnt_4c_Dados
2908:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2909:                     loc_nLote = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
2910:                 ENDIF
2911:             ENDIF
2912: 
2913:             IF loc_nLote > 0
2914:                 loc_cWhere = " WHERE nlotes = " + TRANSFORM(loc_nLote) + " AND Chksubn = 0"
2915:                 loc_nRet   = SQLEXEC(gnConnHandle, ;
2916:                     "SELECT nlotes, Datas FROM SigPdNlt" + loc_cWhere, ;
2917:                     "cursor_4c_NltValid")
2918: 
2919:                 IF loc_nRet > 0 AND USED("cursor_4c_NltValid") AND RECCOUNT("cursor_4c_NltValid") = 0
2920:                     MsgAviso("Lote " + TRANSFORM(loc_nLote) + " n" + CHR(227) + "o encontrado ou fechado.", "Aviso")
2921:                     IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2922:                         loc_oCnt.txt_4c_Lote.Value = 0
2923:                         loc_oCnt.txt_4c_Lote.SetFocus()
2924:                     ENDIF
2925:                 ELSE
2926:                     THIS.this_oBusinessObject.this_nNLotes = loc_nLote
2927:                 ENDIF
2928: 
2929:                 IF USED("cursor_4c_NltValid")
2930:                     USE IN cursor_4c_NltValid
2931:                 ENDIF
2932:             ENDIF
2933:         CATCH TO loc_oErro
2934:             IF USED("cursor_4c_NltValid")
2935:                 USE IN cursor_4c_NltValid
2936:             ENDIF
2937:             MostrarErro("Erro ao validar Lote:" + CHR(13) + loc_oErro.Message, "Erro")
2938:         ENDTRY
2939:     ENDPROC
2940: 
2941:     *--------------------------------------------------------------------------
2942:     * TotPesoLostFocus - Atualiza peso no BO ao sair do campo Peso Total
2943:     * Legado: getTotPeso.Valid - Insere em xNensi e atualiza componentes
2944:     *   (logica completa de xNensi/SigCdPro na Phase 6+, junto com Grade)
2945:     *--------------------------------------------------------------------------
2946:     PROCEDURE TotPesoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2947:         LOCAL loc_oPg2, loc_oCnt, loc_nPeso
2948: 
2949:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2950:         loc_oCnt  = .NULL.
2951:         loc_nPeso = 0
2952: 
2953:         TRY
2954:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2955:                 loc_oCnt  = loc_oPg2.cnt_4c_Dados
2956:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2957:                     loc_nPeso = IIF(VARTYPE(loc_oCnt.txt_4c_TotPeso.Value) = "N", loc_oCnt.txt_4c_TotPeso.Value, 0)
2958:                     THIS.this_oBusinessObject.this_nPesoLancs = loc_nPeso
2959:                 ENDIF
2960:             ENDIF
2961:         CATCH TO loc_oErro
2962:             MostrarErro("Erro em TotPesoLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2963:         ENDTRY
2964:     ENDPROC
2965: 
2966:     *--------------------------------------------------------------------------
2967:     * BuscaOpLostFocus - Busca movimento por numero de OP no campo Buscaop
2968:     * Legado: get_buscaop.When -> salva _OldCodigo; Valid -> SQL em SigCdNec
2969:     *   Select numps, cIdChaves From SigCdNec Where EmpDnps Between chaveI and chaveF
2970:     *--------------------------------------------------------------------------
2971:     PROCEDURE BuscaOpLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2972:         LOCAL loc_oPg2, loc_nNovoVal, loc_nRet, loc_cChaveI, loc_cChaveF
2973: 
2974:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2975:         loc_nNovoVal = 0
2976: 
2977:         TRY
2978:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2979:                 loc_nNovoVal = IIF(VARTYPE(loc_oPg2.txt_4c_Buscaop.Value) = "N", loc_oPg2.txt_4c_Buscaop.Value, 0)
2980:             ENDIF
2981: 
2982:             IF loc_nNovoVal <> THIS.this_nOldCodigo AND loc_nNovoVal > 0
2983:                 *-- Compoe chaves de busca: emps + dopps + str(op*10000, 10) range
2984:                 loc_cChaveI = THIS.this_oBusinessObject.this_cEmps + ;
2985:                               PADR(THIS.this_cDopp, 20) + ;
2986:                               RIGHT(STR(loc_nNovoVal * 10000, 12), 10)
2987:                 loc_cChaveF = THIS.this_oBusinessObject.this_cEmps + ;
2988:                               PADR(THIS.this_cDopp, 20) + ;
2989:                               RIGHT(STR((loc_nNovoVal + 1) * 10000, 12), 10)
2990: 
2991:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2992:                     "SELECT numps, cIdChaves FROM SigCdNec WHERE EmpDnps BETWEEN " + ;
2993:                     EscaparSQL(loc_cChaveI) + " AND " + EscaparSQL(loc_cChaveF), ;
2994:                     "cursor_4c_BuscaOp")
2995: 
2996:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaOp") AND RECCOUNT("cursor_4c_BuscaOp") > 0
2997:                     GO TOP IN cursor_4c_BuscaOp
2998:                     THIS.this_nPNumes = cursor_4c_BuscaOp.numps
2999:                     THIS.this_oBusinessObject.CarregarPorChave(cursor_4c_BuscaOp.cIdChaves)
3000:                     THIS.BOParaForm()
3001:                 ENDIF
3002: 
3003:                 IF USED("cursor_4c_BuscaOp")
3004:                     USE IN cursor_4c_BuscaOp
3005:                 ENDIF
3006:             ENDIF
3007: 
3008:             THIS.this_nOldCodigo = loc_nNovoVal
3009:         CATCH TO loc_oErro
3010:             IF USED("cursor_4c_BuscaOp")
3011:                 USE IN cursor_4c_BuscaOp

*-- Linhas 3018 a 3111:
3018:     * DocuLostFocus - Armazena numero do documento no BO ao sair do campo
3019:     * Legado: Get_Docu nao tem LostFocus - campo livre vinculado a TmpNens.docus
3020:     *--------------------------------------------------------------------------
3021:     PROCEDURE DocuLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3022:         LOCAL loc_oPg2, loc_cDocu
3023: 
3024:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3025:         loc_cDocu = ""
3026: 
3027:         TRY
3028:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
3029:                 loc_cDocu = ALLTRIM(IIF(VARTYPE(loc_oPg2.txt_4c_Docu.Value) = "C", loc_oPg2.txt_4c_Docu.Value, ""))
3030:                 THIS.this_oBusinessObject.this_cDocus = loc_cDocu
3031:             ENDIF
3032:         CATCH TO loc_oErro
3033:             MostrarErro("Erro em DocuLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
3034:         ENDTRY
3035:     ENDPROC
3036: 
3037:     *==========================================================================
3038:     *  LOOKUPS: GRUPO / CONTA / DCONTA para containers Origem, Destino, Responsavel
3039:     *  Tabelas: SigCdGcr (grupos financeiros), SIGCDCLI (contas/clientes)
3040:     *==========================================================================
3041: 
3042:     *--------------------------------------------------------------------------
3043:     * GrupoOrigemLostFocus - Valida grupo de Origem ao sair do campo
3044:     * Legado: Origem.Get_grupo.Valid - fwBuscaSel em TmpGccr (BalCodigo/Descrs)
3045:     *--------------------------------------------------------------------------
3046:     PROCEDURE GrupoOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3047:         LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
3048:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3049:         loc_cGrupo = ""
3050: 
3051:         TRY
3052:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3053:                PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
3054:                 loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", ;
3055:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
3056:             ENDIF
3057: 
3058:             IF EMPTY(loc_cGrupo)
3059:                 THIS.this_oBusinessObject.this_cGrupoos = ""
3060:                 THIS.this_oBusinessObject.this_cContaos = ""
3061:                 THIS.this_cNomeContaos = ""
3062:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3063:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3064:                         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
3065:                     ENDIF
3066:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3067:                         loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
3068:                     ENDIF
3069:                 ENDIF
3070:             ELSE
3071:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3072:                     "SigCdGcr", "cursor_4c_GrpOrig", "codigos", loc_cGrupo, ;
3073:                     "Busca de Grupos")
3074: 
3075:                 IF VARTYPE(loc_oBusca) = "O"
3076:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3077:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3078:                     ELSE
3079:                         IF !loc_oBusca.this_lAchouRegistro
3080:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3081:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3082:                         loc_oBusca.Show()
3083:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpOrig")
3084:                             GO TOP IN cursor_4c_GrpOrig
3085:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3086:                         ELSE
3087:                             loc_cGrupo = ""
3088:                         ENDIF
3089:                     ELSE
3090:                         loc_cGrupo = ""
3091:                         ENDIF
3092:                     ENDIF
3093:                     loc_oBusca.Release()
3094:                 ENDIF
3095: 
3096:                 IF USED("cursor_4c_GrpOrig")
3097:                     USE IN cursor_4c_GrpOrig
3098:                 ENDIF
3099: 
3100:                 THIS.this_oBusinessObject.this_cGrupoos = loc_cGrupo
3101:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3102:                    PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
3103:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = loc_cGrupo
3104:                 ENDIF
3105:                 IF EMPTY(loc_cGrupo)
3106:                     THIS.this_oBusinessObject.this_cContaos = ""
3107:                     THIS.this_cNomeContaos = ""
3108:                     IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3109:                         IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3110:                             loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
3111:                         ENDIF

*-- Linhas 3123 a 3212:
3123:         ENDTRY
3124:     ENDPROC
3125: 
3126:     PROCEDURE TeclaGrupoOrigemKP(par_nKeyCode, par_nShiftAltCtrl)
3127:         IF INLIST(par_nKeyCode, 115, 116)
3128:             THIS.GrupoOrigemLostFocus()
3129:         ENDIF
3130:     ENDPROC
3131: 
3132:     *--------------------------------------------------------------------------
3133:     * ContaOrigemLostFocus - Valida conta de Origem ao sair do campo
3134:     * Legado: Origem.Get_conta.Valid - fwBuscaSel em TmpCli (BalCodigo/IClis/RClis)
3135:     *--------------------------------------------------------------------------
3136:     PROCEDURE ContaOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3137:         LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
3138:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3139:         loc_cConta = ""
3140:         loc_cGrupo = ""
3141:         loc_cNome  = ""
3142:         loc_cSQL   = ""
3143: 
3144:         TRY
3145:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3146:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3147:                     loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value) = "C", ;
3148:                         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value, ""))
3149:                 ENDIF
3150:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
3151:                     loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", ;
3152:                         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
3153:                 ENDIF
3154:             ENDIF
3155: 
3156:             IF EMPTY(loc_cConta)
3157:                 THIS.this_oBusinessObject.this_cContaos = ""
3158:                 THIS.this_cNomeContaos = ""
3159:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3160:                    PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3161:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
3162:                 ENDIF
3163:             ELSE
3164:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3165:                 IF !EMPTY(loc_cGrupo)
3166:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3167:                 ENDIF
3168:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrig")
3169: 
3170:                 IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") = 0
3171:                     USE IN cursor_4c_CliOrig
3172:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3173:                         "SIGCDCLI", "cursor_4c_CliOrig", "iclis", loc_cConta, ;
3174:                         "Busca de Contas")
3175:                     IF VARTYPE(loc_oBusca) = "O"
3176:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3177:                             loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3178:                             loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3179:                         ELSE
3180:                             IF !loc_oBusca.this_lAchouRegistro
3181:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3182:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3183:                             loc_oBusca.Show()
3184:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliOrig")
3185:                                 GO TOP IN cursor_4c_CliOrig
3186:                                 loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3187:                                 loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3188:                             ELSE
3189:                                 loc_cConta = ""
3190:                                 loc_cNome  = ""
3191:                             ENDIF
3192:                         ELSE
3193:                             loc_cConta = ""
3194:                             loc_cNome  = ""
3195:                             ENDIF
3196:                         ENDIF
3197:                         loc_oBusca.Release()
3198:                     ENDIF
3199:                 ELSE
3200:                     IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") > 0
3201:                     GO TOP IN cursor_4c_CliOrig
3202:                     loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3203:                     loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3204:                     ENDIF
3205:                 ENDIF
3206: 
3207:                 IF USED("cursor_4c_CliOrig")
3208:                     USE IN cursor_4c_CliOrig
3209:                 ENDIF
3210: 
3211:                 THIS.this_oBusinessObject.this_cContaos = loc_cConta
3212:                 THIS.this_cNomeContaos = loc_cNome

*-- Linhas 3227 a 3303:
3227:         ENDTRY
3228:     ENDPROC
3229: 
3230:     PROCEDURE TeclaContaOrigemKP(par_nKeyCode, par_nShiftAltCtrl)
3231:         IF INLIST(par_nKeyCode, 115, 116)
3232:             THIS.ContaOrigemLostFocus()
3233:         ENDIF
3234:     ENDPROC
3235: 
3236:     *--------------------------------------------------------------------------
3237:     * DcontaOrigemLostFocus - Busca conta de Origem por nome ao sair do campo
3238:     * Legado: Origem.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome/RClis
3239:     *--------------------------------------------------------------------------
3240:     PROCEDURE DcontaOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3241:         LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
3242:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3243:         loc_cNome  = ""
3244:         loc_cConta = ""
3245: 
3246:         TRY
3247:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3248:                PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3249:                 loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value) = "C", ;
3250:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value, ""))
3251:             ENDIF
3252: 
3253:             IF !EMPTY(loc_cNome)
3254:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3255:                     "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliOrig")
3256: 
3257:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliOrig") AND RECCOUNT("cursor_4c_DCliOrig") > 0
3258:                     IF RECCOUNT("cursor_4c_DCliOrig") = 1
3259:                         GO TOP IN cursor_4c_DCliOrig
3260:                         loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3261:                         loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3262:                     ELSE
3263:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3264:                         IF VARTYPE(loc_oBusca) = "O"
3265:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliOrig"
3266:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3267:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3268:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3269:                             loc_oBusca.Show()
3270:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliOrig")
3271:                                 GO TOP IN cursor_4c_DCliOrig
3272:                                 loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3273:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3274:                             ELSE
3275:                                 loc_cConta = ""
3276:                                 loc_cNome  = ""
3277:                             ENDIF
3278:                             loc_oBusca.Release()
3279:                         ENDIF
3280:                     ENDIF
3281:                 ELSE
3282:                     loc_cConta = ""
3283:                     loc_cNome  = ""
3284:                 ENDIF
3285: 
3286:                 IF USED("cursor_4c_DCliOrig")
3287:                     USE IN cursor_4c_DCliOrig
3288:                 ENDIF
3289: 
3290:                 THIS.this_oBusinessObject.this_cContaos = loc_cConta
3291:                 THIS.this_cNomeContaos = loc_cNome
3292:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3293:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3294:                         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_cConta
3295:                     ENDIF
3296:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3297:                         loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = loc_cNome
3298:                     ENDIF
3299:                 ENDIF
3300:             ENDIF
3301:         CATCH TO loc_oErro
3302:             IF USED("cursor_4c_DCliOrig")
3303:                 USE IN cursor_4c_DCliOrig

*-- Linhas 3310 a 3378:
3310:     * GrupoDestinoLostFocus - Valida grupo de Destino ao sair do campo
3311:     * Legado: Destino.Get_grupo.Valid - fwBuscaSel em TmpGccr
3312:     *--------------------------------------------------------------------------
3313:     PROCEDURE GrupoDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3314:         LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
3315:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3316:         loc_cGrupo = ""
3317: 
3318:         TRY
3319:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3320:                PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
3321:                 loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", ;
3322:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
3323:             ENDIF
3324: 
3325:             IF EMPTY(loc_cGrupo)
3326:                 THIS.this_oBusinessObject.this_cGrupods = ""
3327:                 THIS.this_oBusinessObject.this_cContads = ""
3328:                 THIS.this_cNomeContads = ""
3329:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3330:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3331:                         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
3332:                     ENDIF
3333:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3334:                         loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
3335:                     ENDIF
3336:                 ENDIF
3337:             ELSE
3338:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3339:                     "SigCdGcr", "cursor_4c_GrpDest", "codigos", loc_cGrupo, ;
3340:                     "Busca de Grupos")
3341: 
3342:                 IF VARTYPE(loc_oBusca) = "O"
3343:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3344:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3345:                     ELSE
3346:                         IF !loc_oBusca.this_lAchouRegistro
3347:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3348:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3349:                         loc_oBusca.Show()
3350:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpDest")
3351:                             GO TOP IN cursor_4c_GrpDest
3352:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3353:                         ELSE
3354:                             loc_cGrupo = ""
3355:                         ENDIF
3356:                     ELSE
3357:                         loc_cGrupo = ""
3358:                         ENDIF
3359:                     ENDIF
3360:                     loc_oBusca.Release()
3361:                 ENDIF
3362: 
3363:                 IF USED("cursor_4c_GrpDest")
3364:                     USE IN cursor_4c_GrpDest
3365:                 ENDIF
3366: 
3367:                 THIS.this_oBusinessObject.this_cGrupods = loc_cGrupo
3368:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3369:                    PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
3370:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value = loc_cGrupo
3371:                 ENDIF
3372:                 IF EMPTY(loc_cGrupo)
3373:                     THIS.this_oBusinessObject.this_cContads = ""
3374:                     THIS.this_cNomeContads = ""
3375:                     IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3376:                         IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3377:                             loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
3378:                         ENDIF

*-- Linhas 3390 a 3479:
3390:         ENDTRY
3391:     ENDPROC
3392: 
3393:     PROCEDURE TeclaGrupoDestinoKP(par_nKeyCode, par_nShiftAltCtrl)
3394:         IF INLIST(par_nKeyCode, 115, 116)
3395:             THIS.GrupoDestinoLostFocus()
3396:         ENDIF
3397:     ENDPROC
3398: 
3399:     *--------------------------------------------------------------------------
3400:     * ContaDestinoLostFocus - Valida conta de Destino ao sair do campo
3401:     * Legado: Destino.Get_conta.Valid - fwBuscaSel em TmpCli
3402:     *--------------------------------------------------------------------------
3403:     PROCEDURE ContaDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3404:         LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
3405:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3406:         loc_cConta = ""
3407:         loc_cGrupo = ""
3408:         loc_cNome  = ""
3409:         loc_cSQL   = ""
3410: 
3411:         TRY
3412:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3413:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3414:                     loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value) = "C", ;
3415:                         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value, ""))
3416:                 ENDIF
3417:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
3418:                     loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", ;
3419:                         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
3420:                 ENDIF
3421:             ENDIF
3422: 
3423:             IF EMPTY(loc_cConta)
3424:                 THIS.this_oBusinessObject.this_cContads = ""
3425:                 THIS.this_cNomeContads = ""
3426:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3427:                    PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3428:                     loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
3429:                 ENDIF
3430:             ELSE
3431:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3432:                 IF !EMPTY(loc_cGrupo)
3433:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3434:                 ENDIF
3435:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDest")
3436: 
3437:                 IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") = 0
3438:                     USE IN cursor_4c_CliDest
3439:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3440:                         "SIGCDCLI", "cursor_4c_CliDest", "iclis", loc_cConta, ;
3441:                         "Busca de Contas")
3442:                     IF VARTYPE(loc_oBusca) = "O"
3443:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3444:                             loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3445:                             loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3446:                         ELSE
3447:                             IF !loc_oBusca.this_lAchouRegistro
3448:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3449:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3450:                             loc_oBusca.Show()
3451:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliDest")
3452:                                 GO TOP IN cursor_4c_CliDest
3453:                                 loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3454:                                 loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3455:                             ELSE
3456:                                 loc_cConta = ""
3457:                                 loc_cNome  = ""
3458:                             ENDIF
3459:                         ELSE
3460:                             loc_cConta = ""
3461:                             loc_cNome  = ""
3462:                             ENDIF
3463:                         ENDIF
3464:                         loc_oBusca.Release()
3465:                     ENDIF
3466:                 ELSE
3467:                     IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") > 0
3468:                     GO TOP IN cursor_4c_CliDest
3469:                     loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3470:                     loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3471:                     ENDIF
3472:                 ENDIF
3473: 
3474:                 IF USED("cursor_4c_CliDest")
3475:                     USE IN cursor_4c_CliDest
3476:                 ENDIF
3477: 
3478:                 THIS.this_oBusinessObject.this_cContads = loc_cConta
3479:                 THIS.this_cNomeContads = loc_cNome

*-- Linhas 3494 a 3570:
3494:         ENDTRY
3495:     ENDPROC
3496: 
3497:     PROCEDURE TeclaContaDestinoKP(par_nKeyCode, par_nShiftAltCtrl)
3498:         IF INLIST(par_nKeyCode, 115, 116)
3499:             THIS.ContaDestinoLostFocus()
3500:         ENDIF
3501:     ENDPROC
3502: 
3503:     *--------------------------------------------------------------------------
3504:     * DcontaDestinoLostFocus - Busca conta de Destino por nome ao sair do campo
3505:     * Legado: Destino.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome/RClis
3506:     *--------------------------------------------------------------------------
3507:     PROCEDURE DcontaDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3508:         LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
3509:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3510:         loc_cNome  = ""
3511:         loc_cConta = ""
3512: 
3513:         TRY
3514:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3515:                PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3516:                 loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value) = "C", ;
3517:                     loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value, ""))
3518:             ENDIF
3519: 
3520:             IF !EMPTY(loc_cNome)
3521:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3522:                     "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliDest")
3523: 
3524:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliDest") AND RECCOUNT("cursor_4c_DCliDest") > 0
3525:                     IF RECCOUNT("cursor_4c_DCliDest") = 1
3526:                         GO TOP IN cursor_4c_DCliDest
3527:                         loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3528:                         loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3529:                     ELSE
3530:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3531:                         IF VARTYPE(loc_oBusca) = "O"
3532:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliDest"
3533:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3534:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3535:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3536:                             loc_oBusca.Show()
3537:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliDest")
3538:                                 GO TOP IN cursor_4c_DCliDest
3539:                                 loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3540:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3541:                             ELSE
3542:                                 loc_cConta = ""
3543:                                 loc_cNome  = ""
3544:                             ENDIF
3545:                             loc_oBusca.Release()
3546:                         ENDIF
3547:                     ENDIF
3548:                 ELSE
3549:                     loc_cConta = ""
3550:                     loc_cNome  = ""
3551:                 ENDIF
3552: 
3553:                 IF USED("cursor_4c_DCliDest")
3554:                     USE IN cursor_4c_DCliDest
3555:                 ENDIF
3556: 
3557:                 THIS.this_oBusinessObject.this_cContads = loc_cConta
3558:                 THIS.this_cNomeContads = loc_cNome
3559:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3560:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3561:                         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = loc_cConta
3562:                     ENDIF
3563:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3564:                         loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = loc_cNome
3565:                     ENDIF
3566:                 ENDIF
3567:             ENDIF
3568:         CATCH TO loc_oErro
3569:             IF USED("cursor_4c_DCliDest")
3570:                 USE IN cursor_4c_DCliDest

*-- Linhas 3577 a 3645:
3577:     * GrupoRespLostFocus - Valida grupo de Responsavel ao sair do campo
3578:     * Legado: Responsavel.Get_grupo.Valid - fwBuscaSel em TmpGccr
3579:     *--------------------------------------------------------------------------
3580:     PROCEDURE GrupoRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3581:         LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
3582:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3583:         loc_cGrupo = ""
3584: 
3585:         TRY
3586:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3587:                PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
3588:                 loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", ;
3589:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
3590:             ENDIF
3591: 
3592:             IF EMPTY(loc_cGrupo)
3593:                 THIS.this_oBusinessObject.this_cGrvends = ""
3594:                 THIS.this_oBusinessObject.this_cVends   = ""
3595:                 THIS.this_cNomeVends = ""
3596:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3597:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3598:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
3599:                     ENDIF
3600:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3601:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
3602:                     ENDIF
3603:                 ENDIF
3604:             ELSE
3605:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3606:                     "SigCdGcr", "cursor_4c_GrpResp", "codigos", loc_cGrupo, ;
3607:                     "Busca de Grupos")
3608: 
3609:                 IF VARTYPE(loc_oBusca) = "O"
3610:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3611:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3612:                     ELSE
3613:                         IF !loc_oBusca.this_lAchouRegistro
3614:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3615:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3616:                         loc_oBusca.Show()
3617:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpResp")
3618:                             GO TOP IN cursor_4c_GrpResp
3619:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3620:                         ELSE
3621:                             loc_cGrupo = ""
3622:                         ENDIF
3623:                     ELSE
3624:                         loc_cGrupo = ""
3625:                         ENDIF
3626:                     ENDIF
3627:                     loc_oBusca.Release()
3628:                 ENDIF
3629: 
3630:                 IF USED("cursor_4c_GrpResp")
3631:                     USE IN cursor_4c_GrpResp
3632:                 ENDIF
3633: 
3634:                 THIS.this_oBusinessObject.this_cGrvends = loc_cGrupo
3635:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3636:                    PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
3637:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = loc_cGrupo
3638:                 ENDIF
3639:                 IF EMPTY(loc_cGrupo)
3640:                     THIS.this_oBusinessObject.this_cVends = ""
3641:                     THIS.this_cNomeVends = ""
3642:                     IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3643:                         IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3644:                             loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
3645:                         ENDIF

*-- Linhas 3657 a 3746:
3657:         ENDTRY
3658:     ENDPROC
3659: 
3660:     PROCEDURE TeclaGrupoRespKP(par_nKeyCode, par_nShiftAltCtrl)
3661:         IF INLIST(par_nKeyCode, 115, 116)
3662:             THIS.GrupoRespLostFocus()
3663:         ENDIF
3664:     ENDPROC
3665: 
3666:     *--------------------------------------------------------------------------
3667:     * ContaRespLostFocus - Valida conta de Responsavel ao sair do campo
3668:     * Legado: Responsavel.Get_conta.Valid - fwBuscaSel em TmpCli
3669:     *--------------------------------------------------------------------------
3670:     PROCEDURE ContaRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3671:         LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
3672:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3673:         loc_cConta = ""
3674:         loc_cGrupo = ""
3675:         loc_cNome  = ""
3676:         loc_cSQL   = ""
3677: 
3678:         TRY
3679:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3680:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3681:                     loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value) = "C", ;
3682:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value, ""))
3683:                 ENDIF
3684:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
3685:                     loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", ;
3686:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
3687:                 ENDIF
3688:             ENDIF
3689: 
3690:             IF EMPTY(loc_cConta)
3691:                 THIS.this_oBusinessObject.this_cVends = ""
3692:                 THIS.this_cNomeVends = ""
3693:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3694:                    PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3695:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
3696:                 ENDIF
3697:             ELSE
3698:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3699:                 IF !EMPTY(loc_cGrupo)
3700:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3701:                 ENDIF
3702:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliResp")
3703: 
3704:                 IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") = 0
3705:                     USE IN cursor_4c_CliResp
3706:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3707:                         "SIGCDCLI", "cursor_4c_CliResp", "iclis", loc_cConta, ;
3708:                         "Busca de Contas")
3709:                     IF VARTYPE(loc_oBusca) = "O"
3710:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3711:                             loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3712:                             loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3713:                         ELSE
3714:                             IF !loc_oBusca.this_lAchouRegistro
3715:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3716:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3717:                             loc_oBusca.Show()
3718:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliResp")
3719:                                 GO TOP IN cursor_4c_CliResp
3720:                                 loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3721:                                 loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3722:                             ELSE
3723:                                 loc_cConta = ""
3724:                                 loc_cNome  = ""
3725:                             ENDIF
3726:                         ELSE
3727:                             loc_cConta = ""
3728:                             loc_cNome  = ""
3729:                             ENDIF
3730:                         ENDIF
3731:                         loc_oBusca.Release()
3732:                     ENDIF
3733:                 ELSE
3734:                     IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") > 0
3735:                     GO TOP IN cursor_4c_CliResp
3736:                     loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3737:                     loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3738:                     ENDIF
3739:                 ENDIF
3740: 
3741:                 IF USED("cursor_4c_CliResp")
3742:                     USE IN cursor_4c_CliResp
3743:                 ENDIF
3744: 
3745:                 THIS.this_oBusinessObject.this_cVends = loc_cConta
3746:                 THIS.this_cNomeVends = loc_cNome

*-- Linhas 3761 a 3837:
3761:         ENDTRY
3762:     ENDPROC
3763: 
3764:     PROCEDURE TeclaContaRespKP(par_nKeyCode, par_nShiftAltCtrl)
3765:         IF INLIST(par_nKeyCode, 115, 116)
3766:             THIS.ContaRespLostFocus()
3767:         ENDIF
3768:     ENDPROC
3769: 
3770:     *--------------------------------------------------------------------------
3771:     * DcontaRespLostFocus - Busca conta de Responsavel por nome ao sair do campo
3772:     * Legado: Responsavel.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome
3773:     *--------------------------------------------------------------------------
3774:     PROCEDURE DcontaRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3775:         LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
3776:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3777:         loc_cNome  = ""
3778:         loc_cConta = ""
3779: 
3780:         TRY
3781:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3782:                PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3783:                 loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value) = "C", ;
3784:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value, ""))
3785:             ENDIF
3786: 
3787:             IF !EMPTY(loc_cNome)
3788:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3789:                     "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliResp")
3790: 
3791:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliResp") AND RECCOUNT("cursor_4c_DCliResp") > 0
3792:                     IF RECCOUNT("cursor_4c_DCliResp") = 1
3793:                         GO TOP IN cursor_4c_DCliResp
3794:                         loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3795:                         loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3796:                     ELSE
3797:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3798:                         IF VARTYPE(loc_oBusca) = "O"
3799:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliResp"
3800:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3801:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3802:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3803:                             loc_oBusca.Show()
3804:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliResp")
3805:                                 GO TOP IN cursor_4c_DCliResp
3806:                                 loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3807:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3808:                             ELSE
3809:                                 loc_cConta = ""
3810:                                 loc_cNome  = ""
3811:                             ENDIF
3812:                             loc_oBusca.Release()
3813:                         ENDIF
3814:                     ENDIF
3815:                 ELSE
3816:                     loc_cConta = ""
3817:                     loc_cNome  = ""
3818:                 ENDIF
3819: 
3820:                 IF USED("cursor_4c_DCliResp")
3821:                     USE IN cursor_4c_DCliResp
3822:                 ENDIF
3823: 
3824:                 THIS.this_oBusinessObject.this_cVends = loc_cConta
3825:                 THIS.this_cNomeVends = loc_cNome
3826:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3827:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3828:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = loc_cConta
3829:                     ENDIF
3830:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3831:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = loc_cNome
3832:                     ENDIF
3833:                 ENDIF
3834:             ENDIF
3835:         CATCH TO loc_oErro
3836:             IF USED("cursor_4c_DCliResp")
3837:                 USE IN cursor_4c_DCliResp

*-- Linhas 3845 a 3925:
3845:     * Legado: get_codobs.Valid - Query SigCdObs WHERE codigos BETWEEN pIni AND pFim
3846:     *   depois fwBuscaSel se nao encontrado. Preenche Mm_obs com observas.
3847:     *--------------------------------------------------------------------------
3848:     PROCEDURE CodobsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3849:         LOCAL loc_oPg2, loc_nCod, loc_nRet, loc_oBusca, loc_cObs
3850:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3851:         loc_nCod  = 0
3852:         loc_cObs  = ""
3853: 
3854:         TRY
3855:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
3856:                 loc_nCod = IIF(VARTYPE(loc_oPg2.txt_4c_Codobs.Value) = "N", loc_oPg2.txt_4c_Codobs.Value, 0)
3857:             ENDIF
3858: 
3859:             IF loc_nCod = 0
3860:                 *-- Campo vazio: limpa BO e EditBox
3861:                 THIS.this_oBusinessObject.this_cCodObs = ""
3862:                 THIS.this_cAntValue = ""
3863:                 IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
3864:                     loc_oPg2.edt_4c_Mmobs.Value = ""
3865:                 ENDIF
3866:             ELSE
3867:                 IF TRANSFORM(loc_nCod) = THIS.this_cAntValue
3868:                 *-- Sem mudanca de valor: nao re-consulta
3869:                 THIS.this_oBusinessObject.this_cCodObs = ALLTRIM(TRANSFORM(loc_nCod))
3870:             ELSE
3871:                 THIS.this_cAntValue = TRANSFORM(loc_nCod)
3872: 
3873:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3874:                     "SELECT codigos, descrs, observas FROM SigCdObs WHERE codigos = " + ;
3875:                     FormatarNumeroSQL(loc_nCod), "cursor_4c_ObsBusca")
3876: 
3877:                 IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") = 0
3878:                     USE IN cursor_4c_ObsBusca
3879:                     *-- Nao encontrou: abre busca completa
3880:                     loc_nRet = SQLEXEC(gnConnHandle, ;
3881:                         "SELECT codigos, descrs, observas FROM SigCdObs ORDER BY codigos", ;
3882:                         "cursor_4c_ObsBusca")
3883: 
3884:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca")
3885:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3886:                         IF VARTYPE(loc_oBusca) = "O"
3887:                             loc_oBusca.this_cCursorDestino = "cursor_4c_ObsBusca"
3888:                             loc_oBusca.this_cTitulo = "Observa" + CHR(231) + CHR(227) + "es"
3889:                             loc_oBusca.mAddColuna("codigos", "999",                                                "C" + CHR(243) + "d.")
3890:                             loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3891:                             loc_oBusca.Show()
3892:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ObsBusca")
3893:                                 GO TOP IN cursor_4c_ObsBusca
3894:                                 loc_nCod = cursor_4c_ObsBusca.codigos
3895:                                 loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3896:                             ELSE
3897:                                 loc_nCod = 0
3898:                                 loc_cObs = ""
3899:                             ENDIF
3900:                             loc_oBusca.Release()
3901:                         ENDIF
3902:                     ENDIF
3903:                 ELSE
3904:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") > 0
3905:                     GO TOP IN cursor_4c_ObsBusca
3906:                     loc_nCod = cursor_4c_ObsBusca.codigos
3907:                     loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3908:                     ENDIF
3909:                 ENDIF
3910: 
3911:                 IF USED("cursor_4c_ObsBusca")
3912:                     USE IN cursor_4c_ObsBusca
3913:                 ENDIF
3914: 
3915:                 THIS.this_oBusinessObject.this_cCodObs = IIF(loc_nCod > 0, ALLTRIM(TRANSFORM(loc_nCod)), "")
3916:                 THIS.this_oBusinessObject.this_cObss   = loc_cObs
3917: 
3918:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
3919:                     loc_oPg2.txt_4c_Codobs.Value = loc_nCod
3920:                 ENDIF
3921:                 IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
3922:                     loc_oPg2.edt_4c_Mmobs.Value = loc_cObs
3923:                 ENDIF
3924:                 ENDIF
3925:             ENDIF

*-- Linhas 3931 a 3953:
3931:         ENDTRY
3932:     ENDPROC
3933: 
3934:     PROCEDURE TeclaCodobsKP(par_nKeyCode, par_nShiftAltCtrl)
3935:         IF INLIST(par_nKeyCode, 115, 116)
3936:             THIS.CodobsLostFocus()
3937:         ENDIF
3938:     ENDPROC
3939: 
3940:     *--------------------------------------------------------------------------
3941:     * Destroy - Libera recursos ao fechar o formulario
3942:     *--------------------------------------------------------------------------
3943:     PROCEDURE Destroy()
3944:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3945:             THIS.this_oBusinessObject = .NULL.
3946:         ENDIF
3947:         IF USED("cursor_4c_Dados")
3948:             USE IN cursor_4c_Dados
3949:         ENDIF
3950:         DODEFAULT()
3951:     ENDPROC
3952: 
3953: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpdmp6BO.prg):
*==============================================================================
* sigpdmp6BO.prg - Business Object para Movimentacao de Industria
* Tabela principal: SigCdNec | PK: cidchaves (char 20, gerado por fUniqueIds)
* Chave composta: empdnps = emps(3) + dopps(20) + str(numps,10) -> char(33)
*==============================================================================

DEFINE CLASS sigpdmp6BO AS BusinessBase

    *-- Identificacao e Chave
    this_cCidChaves  = ""    && cidchaves  CHAR(20) - PK (gerado por fUniqueIds)
    this_cEmpDnPs    = ""    && empdnps    CHAR(33) - Chave composta (emps+dopps+str(numps,10))

    *-- Campos da chave composta
    this_cEmps       = ""    && emps       CHAR(3)  - Empresa
    this_cDopps      = ""    && dopps      CHAR(20) - Codigo da operacao/documento
    this_nNumps      = 0     && numps      NUMERIC(10,0) - Numero do movimento

    *-- Datas
    this_tDatars     = {}    && datars     DATETIME - Data/hora do registro
    this_dDatas      = {}    && datas      DATETIME - Data do movimento
    this_tDataTrans  = {}    && datatrans  DATETIME - Data de transferencia

    *-- Origem
    this_cGrupoos    = ""    && grupoos    CHAR(10) - Grupo de conta corrente de origem
    this_cContaos    = ""    && contaos    CHAR(10) - Conta de origem

    *-- Destino
    this_cGrupods    = ""    && grupods    CHAR(10) - Grupo de conta corrente de destino
    this_cContads    = ""    && contads    CHAR(10) - Conta de destino
    this_cEmpds      = ""    && empds      CHAR(3)  - Empresa de destino

    *-- Vendedor
    this_cGrVends    = ""    && grvends    CHAR(10) - Grupo do vendedor
    this_cVends      = ""    && vends      CHAR(10) - Vendedor

    *-- Pesos e Totais
    this_nTotPesos   = 0     && totpesos   NUMERIC(11,3) - Peso total
    this_nPesoLancs  = 0     && pesolancs  NUMERIC(11,3) - Peso lancado

    *-- Lotes e OPs
    this_nNLotes     = 0     && nlotes     NUMERIC(10,0) - Numero do lote (0=sem lote)
    this_nNAceites   = 0     && naceites   NUMERIC(10,0) - Numero de aceites
    this_nNops       = 0     && nops       NUMERIC(10,0) - Numero da OP

    *-- Transacao e Local
    this_nNTrans     = 0     && ntrans     NUMERIC(6,0)  - Numero de transacao
    this_cLocals     = ""    && locals     CHAR(10) - Local
    this_cJobs       = ""    && jobs       CHAR(10) - Job

    *-- Documento e Observacao
    this_cDocus      = ""    && docus      CHAR(10) - Numero do documento
    this_nCodObs     = 0     && codobs     NUMERIC(3,0) - Codigo de observacao
    this_cObss       = ""    && obss       TEXT     - Texto de observacao

    *-- Nao Conformidade
    this_lNConforms  = .F.   && nconforms  BIT      - Nao conforme (flag)
    this_cCodNConfs  = ""    && codnconfs  CHAR(10) - Codigo de nao conformidade

    *-- Balancos
    this_nNumBals    = 0     && numbals    NUMERIC(6,0) - Numero do balanco
    this_nNumBalds   = 0     && numbalds   NUMERIC(6,0) - Numero do balanco destino

    *-- Usuarios
    this_cUsuars     = ""    && usuars     CHAR(10) - Usuario que lancou
    this_cUsuLibs    = ""    && usulibs    CHAR(10) - Usuario que liberou
    this_cUsuConfs   = ""    && usuconfs   CHAR(10) - Usuario que confirmou

    *-- Flags bit
    this_lRetrabs    = .F.   && retrabs    BIT - Retrabalho
    this_lChksubn    = .F.   && chksubn    BIT - Subnivel/lote fechado
    this_lProcbals   = .F.   && procbals   BIT - Processado no balancete
    this_lProcdbal   = .F.   && procdbal   BIT - Processado no balancete 2
    this_lImprs      = .F.   && imprs      BIT - Impresso
    this_lAutos      = .F.   && autos      BIT - Processamento automatico
    this_lLccs       = .F.   && lccs       BIT - LCC (Lote Controle Cliente)
    this_nChkBaixa   = 0     && chkbaixa   NUMERIC(1,0) - Flag baixa

    *-- Liberacao (char, nao bit)
    this_cLibProds   = ""    && libprods   CHAR(10) - Liberado para producao

    *-- Descricoes lookup (nao armazenadas)
    this_cNomeContaOs  = ""  && Nome da conta de origem (lookup SigCdCli)
    this_cNomeContads  = ""  && Nome da conta de destino (lookup SigCdCli)
    this_cNomeVends    = ""  && Nome do vendedor (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNec"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDnPs    = TratarNulo(empdnps,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_nNumps      = TratarNulo(numps,      "N")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_tDatars     = TratarNulo(datars,     "T")
                THIS.this_tDataTrans  = TratarNulo(datatrans,  "T")
                THIS.this_cGrupoos    = TratarNulo(grupoos,    "C")
                THIS.this_cContaos    = TratarNulo(contaos,    "C")
                THIS.this_cGrupods    = TratarNulo(grupods,    "C")
                THIS.this_cContads    = TratarNulo(contads,    "C")
                THIS.this_cEmpds      = TratarNulo(empds,      "C")
                THIS.this_cGrVends    = TratarNulo(grvends,    "C")
                THIS.this_cVends      = TratarNulo(vends,      "C")
                THIS.this_nTotPesos   = TratarNulo(totpesos,   "N")
                THIS.this_nPesoLancs  = TratarNulo(pesolancs,  "N")
                THIS.this_nNLotes     = TratarNulo(nlotes,     "N")
                THIS.this_nNAceites   = TratarNulo(naceites,   "N")
                THIS.this_nNops       = TratarNulo(nops,       "N")
                THIS.this_nNTrans     = TratarNulo(ntrans,     "N")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_cJobs       = TratarNulo(jobs,       "C")
                THIS.this_cDocus      = TratarNulo(docus,      "C")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cObss       = TratarNulo(obss,       "C")
                THIS.this_lNConforms  = ConverterParaLogico(nconforms)
                THIS.this_cCodNConfs  = TratarNulo(codnconfs,  "C")
                THIS.this_nNumBals    = TratarNulo(numbals,    "N")
                THIS.this_nNumBalds   = TratarNulo(numbalds,   "N")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cUsuLibs    = TratarNulo(usulibs,    "C")
                THIS.this_cUsuConfs   = TratarNulo(usuconfs,   "C")
                THIS.this_lRetrabs    = ConverterParaLogico(retrabs)
                THIS.this_lChksubn    = ConverterParaLogico(chksubn)
                THIS.this_lProcbals   = ConverterParaLogico(procbals)
                THIS.this_lProcdbal   = ConverterParaLogico(procdbal)
                THIS.this_lImprs      = ConverterParaLogico(imprs)
                THIS.this_lAutos      = ConverterParaLogico(autos)
                THIS.this_lLccs       = ConverterParaLogico(lccs)
                THIS.this_nChkBaixa   = TratarNulo(chkbaixa,  "N")
                THIS.this_cLibProds   = TratarNulo(libprods,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos em cursor_4c_Dados
    * par_cFiltro: clausula WHERE sem a palavra WHERE (vazio = sem filtro)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.grupoos, n.contaos, n.grupods, n.contads," + ;
                       " n.grvends, n.vends, n.usuars, n.codobs, n.docus, n.nlotes," + ;
                       " n.naceites, n.nops, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.imprs, n.autos," + ;
                       " n.lccs, n.libprods, n.codnconfs, n.jobs, n.locals," + ;
                       " n.empds, n.chkbaixa" + ;
                       " FROM SigCdNec n"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY n.datas DESC, n.numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos de ind" + CHR(250) + "stria:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorPeriodo - Busca movimentos por empresa, operacao e periodo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorPeriodo(par_cEmps, par_cDopp, par_dDtI, par_dDtF)
        LOCAL loc_cFiltro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFiltro = "n.emps = " + EscaparSQL(par_cEmps)

            IF !EMPTY(ALLTRIM(par_cDopp))
                loc_cFiltro = loc_cFiltro + " AND n.dopps = " + EscaparSQL(par_cDopp)
            ENDIF

            IF !EMPTY(par_dDtI)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) >= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtI) + ")"
            ENDIF

            IF !EMPTY(par_dDtF)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) <= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtF) + ")"
            ENDIF

            loc_lSucesso = THIS.Buscar(loc_cFiltro)

        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.datatrans, n.grupoos, n.contaos," + ;
                       " n.grupods, n.contads, n.empds, n.grvends, n.vends," + ;
                       " n.usuars, n.codobs, n.obss, n.docus, n.nlotes, n.naceites," + ;
                       " n.nops, n.ntrans, n.locals, n.jobs, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.codnconfs," + ;
                       " n.procbals, n.procdbal, n.imprs, n.autos, n.lccs," + ;
                       " n.libprods, n.numbals, n.numbalds," + ;
                       " n.usulibs, n.chkbaixa, n.usuconfs" + ;
                       " FROM SigCdNec n" + ;
                       " WHERE n.cidchaves = " + EscaparSQL(par_cCidChaves)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorEmpDnPs - Carrega pelo empdnps (chave composta alternativa)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorEmpDnPs(par_cEmpDnPs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdNec WHERE empdnps = " + ;
                       EscaparSQL(par_cEmpDnPs)

            IF USED("cursor_4c_ChaveBusca")
                USE IN cursor_4c_ChaveBusca
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChaveBusca")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChaveBusca") > 0
                SELECT cursor_4c_ChaveBusca
                loc_cCidChaves = ALLTRIM(cursor_4c_ChaveBusca.cidchaves)
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
                loc_lSucesso = THIS.CarregarPorCodigo(loc_cCidChaves)
            ELSE
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorEmpDnPs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNec (PROTECTED)
    * Nota: cidchaves deve ser gerado antes (via fUniqueIds ou equivalente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Monta chave composta empdnps
            THIS.this_cEmpDnPs = PADR(ALLTRIM(THIS.this_cEmps), 3)  + ;
                                  PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                  STR(THIS.this_nNumps, 10)

            *-- Usuario logado
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (cidchaves, empdnps, emps, dopps, numps," + ;
                       "  datas, grupoos, contaos, grupods, contads, empds," + ;
                       "  grvends, vends, usuars, codobs, docus," + ;
                       "  nlotes, naceites, nops, ntrans, locals, jobs," + ;
                       "  totpesos, pesolancs, retrabs, chksubn," + ;
                       "  nconforms, codnconfs, procbals, procdbal," + ;
                       "  imprs, autos, lccs, libprods, chkbaixa)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)            + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)              + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                 + ", " + ;
                       EscaparSQL(THIS.this_cDopps)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)          + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos)              + ", " + ;
                       EscaparSQL(THIS.this_cContaos)              + ", " + ;
                       EscaparSQL(THIS.this_cGrupods)              + ", " + ;
                       EscaparSQL(THIS.this_cContads)              + ", " + ;
                       EscaparSQL(THIS.this_cEmpds)                + ", " + ;
                       EscaparSQL(THIS.this_cGrVends)              + ", " + ;
                       EscaparSQL(THIS.this_cVends)                + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs)         + ", " + ;
                       EscaparSQL(THIS.this_cDocus)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNLotes)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNAceites)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops)           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNTrans)         + ", " + ;
                       EscaparSQL(THIS.this_cLocals)               + ", " + ;
                       EscaparSQL(THIS.this_cJobs)                 + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotPesos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesoLancs)      + ", " + ;
                       IIF(THIS.this_lRetrabs,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lChksubn,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lNConforms, "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cCodNConfs)            + ", " + ;
                       IIF(THIS.this_lProcbals,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lProcdbal,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lImprs,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lAutos,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lLccs,      "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cLibProds)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkBaixa)       + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Salvar obss (TEXT) separadamente se preenchido
                IF !EMPTY(ALLTRIM(THIS.this_cObss))
                    THIS.AtualizarObss()
                ENDIF
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNec (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas     = " + FormatarDataSQL(THIS.this_dDatas)    + ", " + ;
                       "  grupoos   = " + EscaparSQL(THIS.this_cGrupoos)       + ", " + ;
                       "  contaos   = " + EscaparSQL(THIS.this_cContaos)       + ", " + ;
                       "  grupods   = " + EscaparSQL(THIS.this_cGrupods)       + ", " + ;
                       "  contads   = " + EscaparSQL(THIS.this_cContads)       + ", " + ;
                       "  empds     = " + EscaparSQL(THIS.this_cEmpds)         + ", " + ;
                       "  grvends   = " + EscaparSQL(THIS.this_cGrVends)       + ", " + ;
                       "  vends     = " + EscaparSQL(THIS.this_cVends)         + ", " + ;
                       "  codobs    = " + FormatarNumeroSQL(THIS.this_nCodObs) + ", " + ;
                       "  docus     = " + EscaparSQL(THIS.this_cDocus)         + ", " + ;
                       "  nlotes    = " + FormatarNumeroSQL(THIS.this_nNLotes) + ", " + ;
                       "  naceites  = " + FormatarNumeroSQL(THIS.this_nNAceites) + ", " + ;
                       "  nops      = " + FormatarNumeroSQL(THIS.this_nNops)   + ", " + ;
                       "  totpesos  = " + FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       "  pesolancs = " + FormatarNumeroSQL(THIS.this_nPesoLancs) + ", " + ;
                       "  retrabs   = " + IIF(THIS.this_lRetrabs, "1", "0")   + ", " + ;
                       "  chksubn   = " + IIF(THIS.this_lChksubn, "1", "0")   + ", " + ;
                       "  nconforms = " + IIF(THIS.this_lNConforms, "1", "0") + ", " + ;
                       "  codnconfs = " + EscaparSQL(THIS.this_cCodNConfs)    + ", " + ;
                       "  imprs     = " + IIF(THIS.this_lImprs, "1", "0")     + ", " + ;
                       "  autos     = " + IIF(THIS.this_lAutos, "1", "0")     + ", " + ;
                       "  lccs      = " + IIF(THIS.this_lLccs, "1", "0")      + ", " + ;
                       "  libprods  = " + EscaparSQL(THIS.this_cLibProds)     + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Atualizar obss (TEXT) separadamente
                THIS.AtualizarObss()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarObss - Salva campo TEXT obss separadamente
    * Campos TEXT/NTEXT exigem UPDATE separado em alguns cenarios ODBC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarObss()
        LOCAL loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET obss = " + EscaparSQL(THIS.this_cObss) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNec (PROTECTED)
    * Exclui apenas o cabecalho. A logica do form deve excluir SigCdNei,
    * SigMvHst, SigMvCab e demais tabelas filhas antes de chamar Excluir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens do movimento (SigCdNei) antes do cabecalho
            loc_cSQL = "DELETE FROM SigCdNei WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDnPs)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens do movimento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdNec WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

