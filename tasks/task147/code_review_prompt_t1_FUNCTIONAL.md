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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp6.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3943 linhas total):

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

*-- Linhas 1727 a 1858:
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
1797:                     loc_oObjeto.Visible = .T.
1798:                 ENDIF
1799: 
1800:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1801:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1802:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1803:                     ENDFOR
1804:                 ENDIF
1805: 
1806:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1807:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1808:                 ENDIF
1809:             ENDIF
1810:         ENDFOR
1811:     ENDPROC
1812: 
1813:     *--------------------------------------------------------------------------
1814:     * FormatarGridLista - Define colunas da grade de lista de movimentos
1815:     * Campos do cursor_4c_Dados: numps, datas, dopps, nlotes, nops,
1816:     *   grupoos, contaos, grupods, contads, docus, totpesos...
1817:     *--------------------------------------------------------------------------
1818:     PROTECTED PROCEDURE FormatarGridLista()
1819:         LOCAL loc_oGrade
1820:         loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
1821: 
1822:         WITH loc_oGrade.Column1
1823:             .ControlSource = "cursor_4c_Dados.numps"
1824:             .Width         = 70
1825:             .Resizable     = .F.
1826:             .Movable       = .F.
1827:             .Header1.Caption   = "N" + CHR(250) + "m."
1828:             .Header1.Alignment = 2
1829:             .Header1.FontName  = "Tahoma"
1830:             .Header1.FontBold  = .T.
1831:             .Header1.FontSize  = 8
1832:         ENDWITH
1833: 
1834:         WITH loc_oGrade.Column2
1835:             .ControlSource = "cursor_4c_Dados.datas"
1836:             .Width         = 82
1837:             .Resizable     = .F.
1838:             .Movable       = .F.
1839:             .Header1.Caption   = "Data"
1840:             .Header1.Alignment = 2
1841:             .Header1.FontName  = "Tahoma"
1842:             .Header1.FontBold  = .T.
1843:             .Header1.FontSize  = 8
1844:         ENDWITH
1845: 
1846:         WITH loc_oGrade.Column3
1847:             .ControlSource = "cursor_4c_Dados.dopps"
1848:             .Width         = 140
1849:             .Resizable     = .F.
1850:             .Movable       = .F.
1851:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1852:             .Header1.Alignment = 2
1853:             .Header1.FontName  = "Tahoma"
1854:             .Header1.FontBold  = .T.
1855:             .Header1.FontSize  = 8
1856:         ENDWITH
1857: 
1858:         WITH loc_oGrade.Column4

*-- Linhas 1920 a 2215:
1920:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1921:     * par_nPagina: 1=Lista, 2=Dados
1922:     *--------------------------------------------------------------------------
1923:     PROCEDURE AlternarPagina(par_nPagina)
1924:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1925:         IF par_nPagina = 1
1926:             THIS.this_cModoAtual = "LISTA"
1927:             THIS.AjustarBotoesPorModo()
1928:             THIS.CarregarLista()
1929:         ELSE
1930:             THIS.this_cModoAtual = "DADOS"
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *--------------------------------------------------------------------------
1935:     * CarregarLista - Carrega movimentos na grade conforme filtros de periodo
1936:     * Usa empresa, dopp e datas do cnt_4c_Periodo como filtros
1937:     *--------------------------------------------------------------------------
1938:     PROCEDURE CarregarLista()
1939:         LOCAL loc_cEmps, loc_dDtI, loc_dDtF, loc_lOk
1940: 
1941:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1942:             RETURN
1943:         ENDIF
1944: 
1945:         loc_cEmps = ""
1946:         loc_dDtI  = {}
1947:         loc_dDtF  = {}
1948:         loc_lOk   = .F.
1949: 
1950:         TRY
1951:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1952:                 loc_cEmps = ALLTRIM(.txt_4c_Cd_empresa.Value)
1953:                 loc_dDtI  = .txt_4c_Dt_inicial.Value
1954:                 loc_dDtF  = .txt_4c_Dt_final.Value
1955:                 .Visible     = .T.
1956:             ENDWITH
1957: 
1958:             loc_lOk = THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, THIS.this_cDopp, loc_dDtI, loc_dDtF)
1959: 
1960:             IF loc_lOk
1961:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 8
1962:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1963:                 THIS.FormatarGridLista()
1964:             ENDIF
1965: 
1966:         CATCH TO loc_oErro
1967:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
1968:         ENDTRY
1969:     ENDPROC
1970: 
1971:     *--------------------------------------------------------------------------
1972:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1973:     *--------------------------------------------------------------------------
1974:     PROCEDURE AjustarBotoesPorModo()
1975:         LOCAL loc_lEhLista, loc_lTemRegistro, loc_lPodeEditar
1976:         LOCAL loc_oPg1, loc_oPg2
1977: 
1978:         loc_lEhLista     = (THIS.this_cModoAtual = "LISTA")
1979:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1980:         loc_lPodeEditar  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1981: 
1982:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1983:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1984: 
1985:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEhLista
1986:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEhLista AND loc_lTemRegistro
1987:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEhLista AND loc_lTemRegistro
1988:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEhLista AND loc_lTemRegistro
1989:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEhLista
1990:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEhLista
1991: 
1992:         IF PEMSTATUS(loc_oPg1, "cmd_4c_Cmdfechalote", 5)
1993:             loc_oPg1.cmd_4c_Cmdfechalote.Enabled = loc_lEhLista AND loc_lTemRegistro
1994:         ENDIF
1995: 
1996:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1997:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1998:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
1999:             ENDIF
2000:         ENDIF
2001:     ENDPROC
2002: 
2003:     *--------------------------------------------------------------------------
2004:     * BtnIncluirClick - Abre Page2 em modo inclusao
2005:     *--------------------------------------------------------------------------
2006:     PROCEDURE BtnIncluirClick()
2007:         THIS.this_oBusinessObject.NovoRegistro()
2008:         THIS.this_cModoAtual = "INCLUIR"
2009:         THIS.this_nPNumes    = 0
2010:         THIS.LimparCamposDados()
2011:         THIS.AjustarBotoesPorModo()
2012:         THIS.HabilitarCampos(.T.)
2013:         THIS.AlternarPagina(2)
2014:     ENDPROC
2015: 
2016:     *--------------------------------------------------------------------------
2017:     * BtnVisualizarClick - Abre Page2 em modo consulta (somente leitura)
2018:     *--------------------------------------------------------------------------
2019:     PROCEDURE BtnVisualizarClick()
2020:         LOCAL loc_cCidChaves
2021:         loc_cCidChaves = ""
2022: 
2023:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2024:             MsgAviso("Nenhum registro selecionado.", "Aviso")
2025:             RETURN
2026:         ENDIF
2027: 
2028:         SELECT cursor_4c_Dados
2029:         loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
2030:         THIS.this_nPNumes    = cursor_4c_Dados.numps
2031:         THIS.this_cModoAtual = "VISUALIZAR"
2032: 
2033:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2034:             THIS.BOParaForm()
2035:             THIS.AjustarBotoesPorModo()
2036:             THIS.HabilitarCampos(.F.)
2037:             THIS.AlternarPagina(2)
2038:         ELSE
2039:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
2040:         ENDIF
2041:     ENDPROC
2042: 
2043:     *--------------------------------------------------------------------------
2044:     * BtnAlterarClick - Abre Page2 em modo edicao
2045:     *--------------------------------------------------------------------------
2046:     PROCEDURE BtnAlterarClick()
2047:         LOCAL loc_cCidChaves
2048:         loc_cCidChaves = ""
2049: 
2050:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2051:             MsgAviso("Nenhum registro selecionado.", "Aviso")
2052:             RETURN
2053:         ENDIF
2054: 
2055:         SELECT cursor_4c_Dados
2056:         loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
2057:         THIS.this_nPNumes    = cursor_4c_Dados.numps
2058:         THIS.this_cModoAtual = "ALTERAR"
2059: 
2060:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2061:             THIS.this_oBusinessObject.EditarRegistro()
2062:             THIS.BOParaForm()
2063:             THIS.AjustarBotoesPorModo()
2064:             THIS.HabilitarCampos(.T.)
2065:             THIS.AlternarPagina(2)
2066:         ELSE
2067:             MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
2068:         ENDIF
2069:     ENDPROC
2070: 
2071:     *--------------------------------------------------------------------------
2072:     * BtnExcluirClick - Confirma e exclui o registro selecionado
2073:     *--------------------------------------------------------------------------
2074:     PROCEDURE BtnExcluirClick()
2075:         LOCAL loc_lResultado, loc_nNumps, loc_cCidChaves
2076:         loc_lResultado = .F.
2077:         loc_nNumps     = 0
2078:         loc_cCidChaves = ""
2079: 
2080:         TRY
2081:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2082:                 MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
2083:             ELSE
2084:                 SELECT cursor_4c_Dados
2085:                 loc_nNumps     = cursor_4c_Dados.numps
2086:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
2087: 
2088:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do movimento " + TRANSFORM(loc_nNumps) + "?", "Confirmar Exclus" + CHR(227) + "o")
2089:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2090:                         IF THIS.this_oBusinessObject.Excluir()
2091:                             THIS.CarregarLista()
2092:                             THIS.AjustarBotoesPorModo()
2093:                         ELSE
2094:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
2095:                         ENDIF
2096:                     ELSE
2097:                         MsgErro("Erro ao carregar movimento para exclus" + CHR(227) + "o.", "Erro")
2098:                     ENDIF
2099:                 ENDIF
2100: 
2101:                 loc_lResultado = .T.
2102:             ENDIF
2103: 
2104:         CATCH TO loc_oErro
2105:             MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
2106:         ENDTRY
2107:     ENDPROC
2108: 
2109:     *--------------------------------------------------------------------------
2110:     * BtnBuscarClick - Recarrega lista com filtros atuais
2111:     *--------------------------------------------------------------------------
2112:     PROCEDURE BtnBuscarClick()
2113:         THIS.CarregarLista()
2114:         THIS.AjustarBotoesPorModo()
2115:     ENDPROC
2116: 
2117:     *--------------------------------------------------------------------------
2118:     * BtnEncerrarClick - Fecha o formulario
2119:     *--------------------------------------------------------------------------
2120:     PROCEDURE BtnEncerrarClick()
2121:         THIS.Release()
2122:     ENDPROC
2123: 
2124:     *--------------------------------------------------------------------------
2125:     * BtnSalvarClick - Valida, grava e retorna para lista
2126:     *--------------------------------------------------------------------------
2127:     PROCEDURE BtnSalvarClick()
2128:         LOCAL loc_lResultado, loc_lOk
2129:         loc_lResultado = .F.
2130:         loc_lOk        = .F.
2131: 
2132:         TRY
2133:             IF THIS.ValidarCamposDados()
2134:                 THIS.FormParaBO()
2135: 
2136:                 IF THIS.this_cModoAtual = "INCLUIR"
2137:                     loc_lOk = THIS.this_oBusinessObject.Inserir()
2138:                 ELSE
2139:                     loc_lOk = THIS.this_oBusinessObject.Atualizar()
2140:                 ENDIF
2141: 
2142:                 IF loc_lOk
2143:                     THIS.AlternarPagina(1)
2144:                 ELSE
2145:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
2146:                 ENDIF
2147:             ENDIF
2148: 
2149:             loc_lResultado = .T.
2150: 
2151:         CATCH TO loc_oErro
2152:             MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
2153:         ENDTRY
2154:     ENDPROC
2155: 
2156:     *--------------------------------------------------------------------------
2157:     * BtnCancelarClick - Descarta edicao e retorna para lista
2158:     *--------------------------------------------------------------------------
2159:     PROCEDURE BtnCancelarClick()
2160:         THIS.AlternarPagina(1)
2161:     ENDPROC
2162: 
2163:     *--------------------------------------------------------------------------
2164:     * CmdFechaLoteClick - Fecha ou cancela fechamento do lote selecionado
2165:     * Legado: cmdfechalote.Click - SELECT SigPdNlt.Chksubn, UPDATE Chksubn
2166:     *--------------------------------------------------------------------------
2167:     PROCEDURE CmdFechaLoteClick()
2168:         LOCAL loc_lResultado, loc_nLote, loc_cSQL, loc_nRet, loc_lSubn
2169:         loc_lResultado = .F.
2170:         loc_nLote      = 0
2171:         loc_lSubn      = .F.
2172: 
2173:         TRY
2174:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2175:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
2176:             ELSE
2177:                 SELECT cursor_4c_Dados
2178:                 loc_nLote = cursor_4c_Dados.nlotes
2179: 
2180:                 loc_cSQL = "SELECT Chksubn FROM SigPdNlt WHERE nlotes = " + TRANSFORM(loc_nLote)
2181:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NltTemp")
2182: 
2183:                 IF loc_nRet > 0 AND USED("cursor_4c_NltTemp") AND RECCOUNT("cursor_4c_NltTemp") > 0
2184:                     GO TOP IN cursor_4c_NltTemp
2185:                     loc_lSubn = cursor_4c_NltTemp.Chksubn
2186:                 ENDIF
2187: 
2188:                 IF USED("cursor_4c_NltTemp")
2189:                     USE IN cursor_4c_NltTemp
2190:                 ENDIF
2191: 
2192:                 IF loc_lSubn
2193:                     IF MsgConfirma("Cancelar o fechamento do lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
2194:                         loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 0 WHERE nlotes = " + TRANSFORM(loc_nLote)
2195:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
2196:                         IF loc_nRet > 0
2197:                             THIS.CarregarLista()
2198:                         ELSE
2199:                             MsgErro("Erro ao cancelar fechamento do lote.", "Erro")
2200:                         ENDIF
2201:                     ENDIF
2202:                 ELSE
2203:                     IF MsgConfirma("Fechar o lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
2204:                         loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 1 WHERE nlotes = " + TRANSFORM(loc_nLote)
2205:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
2206:                         IF loc_nRet > 0
2207:                             THIS.CarregarLista()
2208:                         ELSE
2209:                             MsgErro("Erro ao fechar lote.", "Erro")
2210:                         ENDIF
2211:                     ENDIF
2212:                 ENDIF
2213: 
2214:                 loc_lResultado = .T.
2215:             ENDIF

*-- Linhas 2225 a 2308:
2225:     *--------------------------------------------------------------------------
2226:     * FiltroEmpresaLostFocus - Recarrega lista se empresa mudou
2227:     *--------------------------------------------------------------------------
2228:     PROCEDURE FiltroEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2229:         LOCAL loc_cEmps
2230:         loc_cEmps = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Cd_empresa.Value)
2231:         IF loc_cEmps != THIS.this_cAntEmpr
2232:             THIS.this_cAntEmpr = loc_cEmps
2233:             THIS.this_cPEmps   = loc_cEmps
2234:             THIS.CarregarLista()
2235:             THIS.AjustarBotoesPorModo()
2236:         ENDIF
2237:     ENDPROC
2238: 
2239:     *--------------------------------------------------------------------------
2240:     * FiltroDtInicialLostFocus - Recarrega lista se data inicial mudou
2241:     *--------------------------------------------------------------------------
2242:     PROCEDURE FiltroDtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2243:         LOCAL loc_dDtI
2244:         loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Dt_inicial.Value
2245:         IF loc_dDtI != THIS.this_dAntDtIni
2246:             THIS.this_dAntDtIni = loc_dDtI
2247:             THIS.CarregarLista()
2248:             THIS.AjustarBotoesPorModo()
2249:         ENDIF
2250:     ENDPROC
2251: 
2252:     *--------------------------------------------------------------------------
2253:     * FiltroDtFinalLostFocus - Recarrega lista se data final mudou
2254:     *--------------------------------------------------------------------------
2255:     PROCEDURE FiltroDtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2256:         LOCAL loc_dDtF
2257:         loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Dt_final.Value
2258:         IF loc_dDtF != THIS.this_dAntDtFin
2259:             THIS.this_dAntDtFin = loc_dDtF
2260:             THIS.CarregarLista()
2261:             THIS.AjustarBotoesPorModo()
2262:         ENDIF
2263:     ENDPROC
2264: 
2265:     *--------------------------------------------------------------------------
2266:     * FormParaBO - Copia campos do formulario para o BO (Page2)
2267:     *--------------------------------------------------------------------------
2268:     PROTECTED PROCEDURE FormParaBO()
2269:         LOCAL loc_oPg2, loc_oCnt, loc_oBO, loc_nCod
2270: 
2271:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2272:         loc_oCnt  = .NULL.
2273:         loc_oBO   = THIS.this_oBusinessObject
2274:         loc_nCod  = 0
2275: 
2276:         TRY
2277:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2278:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2279:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
2280:                     loc_oBO.this_nNumps = IIF(VARTYPE(loc_oCnt.txt_4c_Codigo.Value) = "N", loc_oCnt.txt_4c_Codigo.Value, 0)
2281:                 ENDIF
2282:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2283:                     loc_oBO.this_dDatas = IIF(VARTYPE(loc_oCnt.txt_4c_Dt_data.Value) = "D", loc_oCnt.txt_4c_Dt_data.Value, {})
2284:                 ENDIF
2285:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2286:                     loc_oBO.this_nNLotes = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
2287:                 ENDIF
2288:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2289:                     loc_oBO.this_nPesoLancs = IIF(VARTYPE(loc_oCnt.txt_4c_TotPeso.Value) = "N", loc_oCnt.txt_4c_TotPeso.Value, 0)
2290:                 ENDIF
2291:             ENDIF
2292:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2293:                 loc_oBO.this_cDocus = ALLTRIM(IIF(VARTYPE(loc_oPg2.txt_4c_Docu.Value) = "C", loc_oPg2.txt_4c_Docu.Value, ""))
2294:             ENDIF
2295:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2296:                 loc_oBO.this_nNAceites = IIF(VARTYPE(loc_oPg2.txt_4c_Fwget1.Value) = "N", loc_oPg2.txt_4c_Fwget1.Value, 0)
2297:             ENDIF
2298:             *-- Container Origem
2299:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2300:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
2301:                     loc_oBO.this_cGrupoos = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
2302:                 ENDIF
2303:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
2304:                     loc_oBO.this_cContaos = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value) = "C", loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value, ""))
2305:                 ENDIF
2306:             ENDIF
2307:             *-- Container Destino
2308:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)

*-- Linhas 2338 a 2381:
2338:     *--------------------------------------------------------------------------
2339:     * BOParaForm - Copia dados do BO para os campos do formulario (Page2)
2340:     *--------------------------------------------------------------------------
2341:     PROTECTED PROCEDURE BOParaForm()
2342:         LOCAL loc_oPg2, loc_oCnt, loc_oBO
2343: 
2344:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2345:         loc_oCnt = .NULL.
2346:         loc_oBO  = THIS.this_oBusinessObject
2347: 
2348:         TRY
2349:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2350:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2351:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
2352:                     loc_oCnt.txt_4c_Codigo.Value = loc_oBO.this_nNumps
2353:                 ENDIF
2354:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2355:                     loc_oCnt.txt_4c_Dt_data.Value = IIF(VARTYPE(loc_oBO.this_dDatas) = "D", loc_oBO.this_dDatas, {})
2356:                 ENDIF
2357:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2358:                     loc_oCnt.txt_4c_Lote.Value = loc_oBO.this_nNLotes
2359:                 ENDIF
2360:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2361:                     loc_oCnt.txt_4c_TotPeso.Value = loc_oBO.this_nPesoLancs
2362:                 ENDIF
2363:             ENDIF
2364:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2365:                 loc_oPg2.txt_4c_Docu.Value = loc_oBO.this_cDocus
2366:             ENDIF
2367:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2368:                 loc_oPg2.txt_4c_Fwget1.Value = loc_oBO.this_nNAceites
2369:             ENDIF
2370:             *-- Container Origem
2371:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2372:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
2373:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = loc_oBO.this_cGrupoos
2374:                 ENDIF
2375:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
2376:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_oBO.this_cContaos
2377:                 ENDIF
2378:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
2379:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = THIS.this_cNomeContaos
2380:                 ENDIF
2381:             ENDIF

*-- Linhas 2418 a 2461:
2418:     *--------------------------------------------------------------------------
2419:     * LimparCamposDados - Limpa campos da Page2 (INCLUIR)
2420:     *--------------------------------------------------------------------------
2421:     PROTECTED PROCEDURE LimparCamposDados()
2422:         LOCAL loc_oPg2, loc_oCnt
2423: 
2424:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2425:         loc_oCnt = .NULL.
2426: 
2427:         TRY
2428:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2429:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2430:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
2431:                     loc_oCnt.txt_4c_Codigo.Value = 0
2432:                 ENDIF
2433:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2434:                     loc_oCnt.txt_4c_Dt_data.Value = DATE()
2435:                 ENDIF
2436:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2437:                     loc_oCnt.txt_4c_Lote.Value = 0
2438:                 ENDIF
2439:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2440:                     loc_oCnt.txt_4c_TotPeso.Value = 0
2441:                 ENDIF
2442:             ENDIF
2443:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2444:                 loc_oPg2.txt_4c_Docu.Value = ""
2445:             ENDIF
2446:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2447:                 loc_oPg2.txt_4c_Fwget1.Value = 0
2448:             ENDIF
2449:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2450:                 loc_oPg2.txt_4c_Buscaop.Value = 0
2451:             ENDIF
2452:             *-- Container Origem
2453:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2454:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
2455:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = ""
2456:                 ENDIF
2457:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
2458:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
2459:                 ENDIF
2460:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
2461:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""

*-- Linhas 2505 a 2548:
2505:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
2506:     * par_lHabilitar: .T. = edicao, .F. = somente leitura
2507:     *--------------------------------------------------------------------------
2508:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2509:         LOCAL loc_oPg2, loc_oCnt, loc_lRO, loc_lROOrig
2510: 
2511:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2512:         loc_oCnt    = .NULL.
2513:         loc_lRO     = !par_lHabilitar
2514:         loc_lROOrig = .T.
2515: 
2516:         TRY
2517:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2518:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2519:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2520:                     loc_oCnt.txt_4c_Dt_data.ReadOnly = loc_lRO
2521:                 ENDIF
2522:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2523:                     loc_oCnt.txt_4c_Lote.ReadOnly = loc_lRO
2524:                 ENDIF
2525:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2526:                     loc_oCnt.txt_4c_TotPeso.ReadOnly = loc_lRO
2527:                 ENDIF
2528:             ENDIF
2529:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
2530:                 loc_oPg2.txt_4c_Docu.ReadOnly = loc_lRO
2531:             ENDIF
2532:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2533:                 loc_oPg2.txt_4c_Buscaop.ReadOnly = loc_lRO
2534:             ENDIF
2535:             *-- txt_4c_Codigo eh sempre ReadOnly (gerado pelo sistema)
2536:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2537:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
2538:                     loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.ReadOnly = .T.
2539:                 ENDIF
2540:             ENDIF
2541:             *-- txt_4c_Fwget1 (Aceite) eh sempre ReadOnly (calculado)
2542:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
2543:                 loc_oPg2.txt_4c_Fwget1.ReadOnly = .T.
2544:             ENDIF
2545:             *-- Container Origem: grupo/conta editaveis conforme modo e flag EditaOrig
2546:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
2547:                 loc_lROOrig = IIF(THIS.this_lEditaOrig, loc_lRO, .T.)
2548:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)

*-- Linhas 2599 a 3001:
2599: 
2600:     *--------------------------------------------------------------------------
2601:     * ValidarCamposDados - Valida campos obrigatorios da Page2
2602:     * Retorna .T. se valido, .F. se houver erro (com MsgAviso)
2603:     *--------------------------------------------------------------------------
2604:     PROTECTED PROCEDURE ValidarCamposDados()
2605:         LOCAL loc_lValido, loc_oPg2, loc_oCnt, loc_dDatas
2606: 
2607:         loc_lValido = .T.
2608:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2609:         loc_oCnt    = .NULL.
2610:         loc_dDatas  = {}
2611: 
2612:         TRY
2613:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2614:                 loc_oCnt = loc_oPg2.cnt_4c_Dados
2615: 
2616:                 *-- Data obrigatoria (campo principal de controle)
2617:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
2618:                     loc_dDatas = loc_oCnt.txt_4c_Dt_data.Value
2619:                     IF EMPTY(loc_dDatas)
2620:                         MsgAviso("Data do movimento " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
2621:                         loc_oCnt.txt_4c_Dt_data.SetFocus()
2622:                         loc_lValido = .F.
2623:                     ENDIF
2624:                 ENDIF
2625:             ENDIF
2626:         CATCH TO loc_oErro
2627:             MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2628:             loc_lValido = .F.
2629:         ENDTRY
2630: 
2631:         RETURN loc_lValido
2632:     ENDPROC
2633: 
2634:     *--------------------------------------------------------------------------
2635:     * BtnOperacaoClick - Abre subformulario de Operacao (SigPdMp5)
2636:     * Legado: Operacao.Click - Do Form SigPdMp5 With ThisForm, DataSessionId
2637:     *--------------------------------------------------------------------------
2638:     PROCEDURE BtnOperacaoClick()
2639:         LOCAL loc_lResultado
2640:         loc_lResultado = .F.
2641:         TRY
2642:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2643:                 THIS.Enabled = .F.
2644:                 DO FORM FormSigPdMp5 WITH THIS, THIS.DataSessionId
2645:                 THIS.Enabled = .T.
2646:             ENDIF
2647:             loc_lResultado = .T.
2648:         CATCH TO loc_oErro
2649:             THIS.Enabled = .T.
2650:             MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2651:         ENDTRY
2652:     ENDPROC
2653: 
2654:     *--------------------------------------------------------------------------
2655:     * BtnComponentesClick - Abre subformulario de Componentes (SigPdMp4)
2656:     * Legado: Componentes.Click - Do Form SigPdMp4 With ThisForm
2657:     *--------------------------------------------------------------------------
2658:     PROCEDURE BtnComponentesClick()
2659:         LOCAL loc_lResultado
2660:         loc_lResultado = .F.
2661:         TRY
2662:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2663:                 THIS.Enabled = .F.
2664:                 DO FORM FormSigPdMp4 WITH THIS
2665:                 THIS.Enabled = .T.
2666:             ENDIF
2667:             loc_lResultado = .T.
2668:         CATCH TO loc_oErro
2669:             THIS.Enabled = .T.
2670:             MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loc_oErro.Message, "Erro")
2671:         ENDTRY
2672:     ENDPROC
2673: 
2674:     *--------------------------------------------------------------------------
2675:     * BtnEtiquetasClick - Abre subformulario de Etiquetas (SigPdMp3)
2676:     * Legado: Etiquetas.Click - Do Form SigPdMp3 With ThisForm, DataSessionId
2677:     *--------------------------------------------------------------------------
2678:     PROCEDURE BtnEtiquetasClick()
2679:         LOCAL loc_lResultado
2680:         loc_lResultado = .F.
2681:         TRY
2682:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2683:                 THIS.Enabled = .F.
2684:                 DO FORM FormSigPdMp3 WITH THIS, THIS.DataSessionId
2685:                 THIS.Enabled = .T.
2686:             ENDIF
2687:             loc_lResultado = .T.
2688:         CATCH TO loc_oErro
2689:             THIS.Enabled = .T.
2690:             MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
2691:         ENDTRY
2692:     ENDPROC
2693: 
2694:     *--------------------------------------------------------------------------
2695:     * BtnServicosClick - Abre subformulario de Servicos (SigPdM11)
2696:     * Legado: Servicos.Click - If Not InList(pcEscolha,'PROCURAR','INSERIR')
2697:     *   -> Do Form SigPdM11 With ThisForm, DataSessionId
2698:     *--------------------------------------------------------------------------
2699:     PROCEDURE BtnServicosClick()
2700:         LOCAL loc_lResultado
2701:         loc_lResultado = .F.
2702:         TRY
2703:             IF THIS.this_cModoAtual = "ALTERAR"
2704:                 THIS.Enabled = .F.
2705:                 DO FORM FormSigPdM11 WITH THIS, THIS.DataSessionId
2706:                 THIS.Enabled = .T.
2707:             ENDIF
2708:             loc_lResultado = .T.
2709:         CATCH TO loc_oErro
2710:             THIS.Enabled = .T.
2711:             MostrarErro("Erro ao abrir Servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
2712:         ENDTRY
2713:     ENDPROC
2714: 
2715:     *--------------------------------------------------------------------------
2716:     * BtnEtqCompoClick - Imprime etiquetas de componentes das OPs (SigOpIbo)
2717:     * Legado: btnCompoOp.Click - Do Form SigOpIbo With Thisform, 20, Titulo,...
2718:     *--------------------------------------------------------------------------
2719:     PROCEDURE BtnEtqCompoClick()
2720:         LOCAL loc_lResultado
2721:         loc_lResultado = .F.
2722:         TRY
2723:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2724:                 DO FORM SigOpIbo WITH THIS, 20, THIS.Caption, .F., .F., .F., .F., .F., 0
2725:             ENDIF
2726:             loc_lResultado = .T.
2727:         CATCH TO loc_oErro
2728:             MostrarErro("Erro ao imprimir Etiquetas de Componentes:" + CHR(13) + loc_oErro.Message, "Erro")
2729:         ENDTRY
2730:     ENDPROC
2731: 
2732:     *--------------------------------------------------------------------------
2733:     * BtnBoletoClick - Verifica config de boleto e chama ImpBol()
2734:     * Legado: Boleto.Click - Seek(_Dopp, 'crSigCdOpd') + ImpBol() if Boletos in (1,3)
2735:     *--------------------------------------------------------------------------
2736:     PROCEDURE BtnBoletoClick()
2737:         LOCAL loc_lResultado, loc_nRet, loc_nBoletos
2738: 
2739:         loc_lResultado = .F.
2740:         loc_nBoletos   = 0
2741: 
2742:         TRY
2743:             IF EMPTY(THIS.this_cDopp)
2744:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
2745:             ELSE
2746:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2747:                     "SELECT Boletos FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
2748:                     "cursor_4c_BoletoConf")
2749:                 IF loc_nRet > 0 AND USED("cursor_4c_BoletoConf") AND RECCOUNT("cursor_4c_BoletoConf") > 0
2750:                     GO TOP IN cursor_4c_BoletoConf
2751:                     loc_nBoletos = cursor_4c_BoletoConf.Boletos
2752:                 ENDIF
2753:                 IF USED("cursor_4c_BoletoConf")
2754:                     USE IN cursor_4c_BoletoConf
2755:                 ENDIF
2756:                 IF INLIST(loc_nBoletos, 1, 3)
2757:                     THIS.ImpBol()
2758:                 ENDIF
2759:                 loc_lResultado = .T.
2760:             ENDIF
2761:         CATCH TO loc_oErro
2762:             IF USED("cursor_4c_BoletoConf")
2763:                 USE IN cursor_4c_BoletoConf
2764:             ENDIF
2765:             MostrarErro("Erro ao processar Boleto:" + CHR(13) + loc_oErro.Message, "Erro")
2766:         ENDTRY
2767:     ENDPROC
2768: 
2769:     *--------------------------------------------------------------------------
2770:     * ImpBol - Imprime boleto do movimento corrente
2771:     * Legado: SIGPDMP6.ImpBol (metodo nao extraido no mapeamento automatico)
2772:     *   Abre o formulario de cabecalho de movimento para impressao do boleto
2773:     *--------------------------------------------------------------------------
2774:     PROCEDURE ImpBol()
2775:         LOCAL loc_lResultado, loc_cEmps, loc_cDopps, loc_nNumps
2776: 
2777:         loc_lResultado = .F.
2778:         loc_cEmps  = THIS.this_oBusinessObject.this_cEmps
2779:         loc_cDopps = THIS.this_oBusinessObject.this_cDopps
2780:         loc_nNumps = THIS.this_nPNumes
2781: 
2782:         TRY
2783:             DO FORM SigBolet WITH loc_cEmps, loc_cDopps, loc_nNumps
2784:             loc_lResultado = .T.
2785:         CATCH TO loc_oErro
2786:             MostrarErro("Erro ao imprimir Boleto:" + CHR(13) + loc_oErro.Message, "Erro")
2787:         ENDTRY
2788:     ENDPROC
2789: 
2790:     *--------------------------------------------------------------------------
2791:     * BtnDocumentoClick - Abre formulario de documento de producao (SigReDct)
2792:     * Legado: Documento.Click - Do Form SigReDct With TmpNens.Emps, Dopps, Numps
2793:     *   Condicao: crSigCdOpd.Docus = 1 And crSigCdOpd.etiqs = 1
2794:     *--------------------------------------------------------------------------
2795:     PROCEDURE BtnDocumentoClick()
2796:         LOCAL loc_lResultado, loc_nRet, loc_nDocus, loc_nEtiqs, loc_cEmps, loc_cDopps
2797: 
2798:         loc_lResultado = .F.
2799:         loc_nDocus     = 0
2800:         loc_nEtiqs     = 0
2801:         loc_cEmps      = THIS.this_oBusinessObject.this_cEmps
2802:         loc_cDopps     = THIS.this_oBusinessObject.this_cDopps
2803: 
2804:         TRY
2805:             IF EMPTY(THIS.this_cDopp)
2806:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
2807:             ELSE
2808:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2809:                     "SELECT Docus, Etiqs FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
2810:                     "cursor_4c_DocConf")
2811:                 IF loc_nRet > 0 AND USED("cursor_4c_DocConf") AND RECCOUNT("cursor_4c_DocConf") > 0
2812:                     GO TOP IN cursor_4c_DocConf
2813:                     loc_nDocus = cursor_4c_DocConf.Docus
2814:                     loc_nEtiqs = cursor_4c_DocConf.Etiqs
2815:                 ENDIF
2816:                 IF USED("cursor_4c_DocConf")
2817:                     USE IN cursor_4c_DocConf
2818:                 ENDIF
2819:                 IF loc_nDocus = 1 AND loc_nEtiqs = 1
2820:                     DO FORM FormSigReDct WITH loc_cEmps, loc_cDopps, THIS.this_nPNumes
2821:                 ENDIF
2822:                 loc_lResultado = .T.
2823:             ENDIF
2824:         CATCH TO loc_oErro
2825:             IF USED("cursor_4c_DocConf")
2826:                 USE IN cursor_4c_DocConf
2827:             ENDIF
2828:             MostrarErro("Erro ao abrir Documento:" + CHR(13) + loc_oErro.Message, "Erro")
2829:         ENDTRY
2830:     ENDPROC
2831: 
2832:     *--------------------------------------------------------------------------
2833:     * Handler click do botao de apontamentos em aberto - abre SigOpMpn
2834:     * Legado: cmd_Apontamentos.Click - If INSERIR and contaos nao vazia
2835:     *   and lnBot=0 and xNensi vazio -> Do Form SigOpMpn With ThisForm, DataSessionId
2836:     *--------------------------------------------------------------------------
2837:     PROCEDURE BtnPendentesClick()
2838:         LOCAL loc_lResultado, loc_cContaOs
2839: 
2840:         loc_lResultado = .F.
2841:         loc_cContaOs   = THIS.this_oBusinessObject.this_cContaos
2842: 
2843:         TRY
2844:             IF THIS.this_cModoAtual = "INCLUIR"
2845:                 IF EMPTY(ALLTRIM(loc_cContaOs))
2846:                     MsgAviso("Informe a Conta de Origem!", "Aviso")
2847:                 ELSE
2848:                     THIS.Enabled = .F.
2849:                     DO FORM SigOpMpn WITH THIS, THIS.DataSessionId
2850:                     THIS.Enabled = .T.
2851:                 ENDIF
2852:             ENDIF
2853:             loc_lResultado = .T.
2854:         CATCH TO loc_oErro
2855:             THIS.Enabled = .T.
2856:             MostrarErro("Erro ao abrir Pend" + CHR(234) + "ncias:" + CHR(13) + loc_oErro.Message, "Erro")
2857:         ENDTRY
2858:     ENDPROC
2859: 
2860:     *--------------------------------------------------------------------------
2861:     * DtDataLostFocus - Tratamento ao sair do campo Data do movimento
2862:     * Legado: Dt_data.LostFocus - Se INSERIR e numeras=1 e op unica vazia
2863:     *   -> SetFocus na GradeOperacao (Phase 6: Grade ainda nao existe)
2864:     *--------------------------------------------------------------------------
2865:     PROCEDURE DtDataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2866:         LOCAL loc_oPg2, loc_dDatas
2867: 
2868:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2869:         loc_dDatas = {}
2870: 
2871:         TRY
2872:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
2873:                 loc_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
2874:                 IF !EMPTY(loc_dDatas)
2875:                     THIS.this_oBusinessObject.this_dDatas = loc_dDatas
2876:                 ENDIF
2877:             ENDIF
2878:         CATCH TO loc_oErro
2879:             MostrarErro("Erro em DtDataLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2880:         ENDTRY
2881:     ENDPROC
2882: 
2883:     *--------------------------------------------------------------------------
2884:     * LoteLostFocus - Valida o numero do lote contra SigPdNlt
2885:     * Legado: Get_Lote.Valid - Select nlotes, Datas From SigPdNlt
2886:     *   Where EmpGruEsts = emps+grupoos+contaos And Chksubn = 0
2887:     *--------------------------------------------------------------------------
2888:     PROCEDURE LoteLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2889:         LOCAL loc_oPg2, loc_oCnt, loc_nLote, loc_nRet, loc_cWhere
2890: 
2891:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2892:         loc_oCnt  = .NULL.
2893:         loc_nLote = 0
2894: 
2895:         TRY
2896:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2897:                 loc_oCnt  = loc_oPg2.cnt_4c_Dados
2898:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2899:                     loc_nLote = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
2900:                 ENDIF
2901:             ENDIF
2902: 
2903:             IF loc_nLote > 0
2904:                 loc_cWhere = " WHERE nlotes = " + TRANSFORM(loc_nLote) + " AND Chksubn = 0"
2905:                 loc_nRet   = SQLEXEC(gnConnHandle, ;
2906:                     "SELECT nlotes, Datas FROM SigPdNlt" + loc_cWhere, ;
2907:                     "cursor_4c_NltValid")
2908: 
2909:                 IF loc_nRet > 0 AND USED("cursor_4c_NltValid") AND RECCOUNT("cursor_4c_NltValid") = 0
2910:                     MsgAviso("Lote " + TRANSFORM(loc_nLote) + " n" + CHR(227) + "o encontrado ou fechado.", "Aviso")
2911:                     IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2912:                         loc_oCnt.txt_4c_Lote.Value = 0
2913:                         loc_oCnt.txt_4c_Lote.SetFocus()
2914:                     ENDIF
2915:                 ELSE
2916:                     THIS.this_oBusinessObject.this_nNLotes = loc_nLote
2917:                 ENDIF
2918: 
2919:                 IF USED("cursor_4c_NltValid")
2920:                     USE IN cursor_4c_NltValid
2921:                 ENDIF
2922:             ENDIF
2923:         CATCH TO loc_oErro
2924:             IF USED("cursor_4c_NltValid")
2925:                 USE IN cursor_4c_NltValid
2926:             ENDIF
2927:             MostrarErro("Erro ao validar Lote:" + CHR(13) + loc_oErro.Message, "Erro")
2928:         ENDTRY
2929:     ENDPROC
2930: 
2931:     *--------------------------------------------------------------------------
2932:     * TotPesoLostFocus - Atualiza peso no BO ao sair do campo Peso Total
2933:     * Legado: getTotPeso.Valid - Insere em xNensi e atualiza componentes
2934:     *   (logica completa de xNensi/SigCdPro na Phase 6+, junto com Grade)
2935:     *--------------------------------------------------------------------------
2936:     PROCEDURE TotPesoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2937:         LOCAL loc_oPg2, loc_oCnt, loc_nPeso
2938: 
2939:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2940:         loc_oCnt  = .NULL.
2941:         loc_nPeso = 0
2942: 
2943:         TRY
2944:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2945:                 loc_oCnt  = loc_oPg2.cnt_4c_Dados
2946:                 IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
2947:                     loc_nPeso = IIF(VARTYPE(loc_oCnt.txt_4c_TotPeso.Value) = "N", loc_oCnt.txt_4c_TotPeso.Value, 0)
2948:                     THIS.this_oBusinessObject.this_nPesoLancs = loc_nPeso
2949:                 ENDIF
2950:             ENDIF
2951:         CATCH TO loc_oErro
2952:             MostrarErro("Erro em TotPesoLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2953:         ENDTRY
2954:     ENDPROC
2955: 
2956:     *--------------------------------------------------------------------------
2957:     * BuscaOpLostFocus - Busca movimento por numero de OP no campo Buscaop
2958:     * Legado: get_buscaop.When -> salva _OldCodigo; Valid -> SQL em SigCdNec
2959:     *   Select numps, cIdChaves From SigCdNec Where EmpDnps Between chaveI and chaveF
2960:     *--------------------------------------------------------------------------
2961:     PROCEDURE BuscaOpLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2962:         LOCAL loc_oPg2, loc_nNovoVal, loc_nRet, loc_cChaveI, loc_cChaveF
2963: 
2964:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2965:         loc_nNovoVal = 0
2966: 
2967:         TRY
2968:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2969:                 loc_nNovoVal = IIF(VARTYPE(loc_oPg2.txt_4c_Buscaop.Value) = "N", loc_oPg2.txt_4c_Buscaop.Value, 0)
2970:             ENDIF
2971: 
2972:             IF loc_nNovoVal <> THIS.this_nOldCodigo AND loc_nNovoVal > 0
2973:                 *-- Compoe chaves de busca: emps + dopps + str(op*10000, 10) range
2974:                 loc_cChaveI = THIS.this_oBusinessObject.this_cEmps + ;
2975:                               PADR(THIS.this_cDopp, 20) + ;
2976:                               RIGHT(STR(loc_nNovoVal * 10000, 12), 10)
2977:                 loc_cChaveF = THIS.this_oBusinessObject.this_cEmps + ;
2978:                               PADR(THIS.this_cDopp, 20) + ;
2979:                               RIGHT(STR((loc_nNovoVal + 1) * 10000, 12), 10)
2980: 
2981:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2982:                     "SELECT numps, cIdChaves FROM SigCdNec WHERE EmpDnps BETWEEN " + ;
2983:                     EscaparSQL(loc_cChaveI) + " AND " + EscaparSQL(loc_cChaveF), ;
2984:                     "cursor_4c_BuscaOp")
2985: 
2986:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaOp") AND RECCOUNT("cursor_4c_BuscaOp") > 0
2987:                     GO TOP IN cursor_4c_BuscaOp
2988:                     THIS.this_nPNumes = cursor_4c_BuscaOp.numps
2989:                     THIS.this_oBusinessObject.CarregarPorChave(cursor_4c_BuscaOp.cIdChaves)
2990:                     THIS.BOParaForm()
2991:                 ENDIF
2992: 
2993:                 IF USED("cursor_4c_BuscaOp")
2994:                     USE IN cursor_4c_BuscaOp
2995:                 ENDIF
2996:             ENDIF
2997: 
2998:             THIS.this_nOldCodigo = loc_nNovoVal
2999:         CATCH TO loc_oErro
3000:             IF USED("cursor_4c_BuscaOp")
3001:                 USE IN cursor_4c_BuscaOp

*-- Linhas 3008 a 3101:
3008:     * DocuLostFocus - Armazena numero do documento no BO ao sair do campo
3009:     * Legado: Get_Docu nao tem LostFocus - campo livre vinculado a TmpNens.docus
3010:     *--------------------------------------------------------------------------
3011:     PROCEDURE DocuLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3012:         LOCAL loc_oPg2, loc_cDocu
3013: 
3014:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3015:         loc_cDocu = ""
3016: 
3017:         TRY
3018:             IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
3019:                 loc_cDocu = ALLTRIM(IIF(VARTYPE(loc_oPg2.txt_4c_Docu.Value) = "C", loc_oPg2.txt_4c_Docu.Value, ""))
3020:                 THIS.this_oBusinessObject.this_cDocus = loc_cDocu
3021:             ENDIF
3022:         CATCH TO loc_oErro
3023:             MostrarErro("Erro em DocuLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
3024:         ENDTRY
3025:     ENDPROC
3026: 
3027:     *==========================================================================
3028:     *  LOOKUPS: GRUPO / CONTA / DCONTA para containers Origem, Destino, Responsavel
3029:     *  Tabelas: SigCdGcr (grupos financeiros), SIGCDCLI (contas/clientes)
3030:     *==========================================================================
3031: 
3032:     *--------------------------------------------------------------------------
3033:     * GrupoOrigemLostFocus - Valida grupo de Origem ao sair do campo
3034:     * Legado: Origem.Get_grupo.Valid - fwBuscaSel em TmpGccr (BalCodigo/Descrs)
3035:     *--------------------------------------------------------------------------
3036:     PROCEDURE GrupoOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3037:         LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
3038:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3039:         loc_cGrupo = ""
3040: 
3041:         TRY
3042:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3043:                PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
3044:                 loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", ;
3045:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
3046:             ENDIF
3047: 
3048:             IF EMPTY(loc_cGrupo)
3049:                 THIS.this_oBusinessObject.this_cGrupoos = ""
3050:                 THIS.this_oBusinessObject.this_cContaos = ""
3051:                 THIS.this_cNomeContaos = ""
3052:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3053:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3054:                         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
3055:                     ENDIF
3056:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3057:                         loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
3058:                     ENDIF
3059:                 ENDIF
3060:             ELSE
3061:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3062:                     "SigCdGcr", "cursor_4c_GrpOrig", "codigos", loc_cGrupo, ;
3063:                     "Busca de Grupos")
3064: 
3065:                 IF VARTYPE(loc_oBusca) = "O"
3066:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3067:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3068:                     ELSE
3069:                         IF !loc_oBusca.this_lAchouRegistro
3070:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3071:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3072:                         loc_oBusca.Show()
3073:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpOrig")
3074:                             GO TOP IN cursor_4c_GrpOrig
3075:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3076:                         ELSE
3077:                             loc_cGrupo = ""
3078:                         ENDIF
3079:                     ELSE
3080:                         loc_cGrupo = ""
3081:                         ENDIF
3082:                     ENDIF
3083:                     loc_oBusca.Release()
3084:                 ENDIF
3085: 
3086:                 IF USED("cursor_4c_GrpOrig")
3087:                     USE IN cursor_4c_GrpOrig
3088:                 ENDIF
3089: 
3090:                 THIS.this_oBusinessObject.this_cGrupoos = loc_cGrupo
3091:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3092:                    PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
3093:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = loc_cGrupo
3094:                 ENDIF
3095:                 IF EMPTY(loc_cGrupo)
3096:                     THIS.this_oBusinessObject.this_cContaos = ""
3097:                     THIS.this_cNomeContaos = ""
3098:                     IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3099:                         IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3100:                             loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
3101:                         ENDIF

*-- Linhas 3113 a 3202:
3113:         ENDTRY
3114:     ENDPROC
3115: 
3116:     PROCEDURE TeclaGrupoOrigemKP(par_nKeyCode, par_nShiftAltCtrl)
3117:         IF INLIST(par_nKeyCode, 115, 116)
3118:             THIS.GrupoOrigemLostFocus()
3119:         ENDIF
3120:     ENDPROC
3121: 
3122:     *--------------------------------------------------------------------------
3123:     * ContaOrigemLostFocus - Valida conta de Origem ao sair do campo
3124:     * Legado: Origem.Get_conta.Valid - fwBuscaSel em TmpCli (BalCodigo/IClis/RClis)
3125:     *--------------------------------------------------------------------------
3126:     PROCEDURE ContaOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3127:         LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
3128:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3129:         loc_cConta = ""
3130:         loc_cGrupo = ""
3131:         loc_cNome  = ""
3132:         loc_cSQL   = ""
3133: 
3134:         TRY
3135:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3136:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3137:                     loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value) = "C", ;
3138:                         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value, ""))
3139:                 ENDIF
3140:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
3141:                     loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", ;
3142:                         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
3143:                 ENDIF
3144:             ENDIF
3145: 
3146:             IF EMPTY(loc_cConta)
3147:                 THIS.this_oBusinessObject.this_cContaos = ""
3148:                 THIS.this_cNomeContaos = ""
3149:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3150:                    PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3151:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
3152:                 ENDIF
3153:             ELSE
3154:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3155:                 IF !EMPTY(loc_cGrupo)
3156:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3157:                 ENDIF
3158:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrig")
3159: 
3160:                 IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") = 0
3161:                     USE IN cursor_4c_CliOrig
3162:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3163:                         "SIGCDCLI", "cursor_4c_CliOrig", "iclis", loc_cConta, ;
3164:                         "Busca de Contas")
3165:                     IF VARTYPE(loc_oBusca) = "O"
3166:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3167:                             loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3168:                             loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3169:                         ELSE
3170:                             IF !loc_oBusca.this_lAchouRegistro
3171:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3172:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3173:                             loc_oBusca.Show()
3174:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliOrig")
3175:                                 GO TOP IN cursor_4c_CliOrig
3176:                                 loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3177:                                 loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3178:                             ELSE
3179:                                 loc_cConta = ""
3180:                                 loc_cNome  = ""
3181:                             ENDIF
3182:                         ELSE
3183:                             loc_cConta = ""
3184:                             loc_cNome  = ""
3185:                             ENDIF
3186:                         ENDIF
3187:                         loc_oBusca.Release()
3188:                     ENDIF
3189:                 ELSE
3190:                     IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") > 0
3191:                     GO TOP IN cursor_4c_CliOrig
3192:                     loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3193:                     loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3194:                     ENDIF
3195:                 ENDIF
3196: 
3197:                 IF USED("cursor_4c_CliOrig")
3198:                     USE IN cursor_4c_CliOrig
3199:                 ENDIF
3200: 
3201:                 THIS.this_oBusinessObject.this_cContaos = loc_cConta
3202:                 THIS.this_cNomeContaos = loc_cNome

*-- Linhas 3217 a 3293:
3217:         ENDTRY
3218:     ENDPROC
3219: 
3220:     PROCEDURE TeclaContaOrigemKP(par_nKeyCode, par_nShiftAltCtrl)
3221:         IF INLIST(par_nKeyCode, 115, 116)
3222:             THIS.ContaOrigemLostFocus()
3223:         ENDIF
3224:     ENDPROC
3225: 
3226:     *--------------------------------------------------------------------------
3227:     * DcontaOrigemLostFocus - Busca conta de Origem por nome ao sair do campo
3228:     * Legado: Origem.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome/RClis
3229:     *--------------------------------------------------------------------------
3230:     PROCEDURE DcontaOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3231:         LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
3232:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3233:         loc_cNome  = ""
3234:         loc_cConta = ""
3235: 
3236:         TRY
3237:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
3238:                PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3239:                 loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value) = "C", ;
3240:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value, ""))
3241:             ENDIF
3242: 
3243:             IF !EMPTY(loc_cNome)
3244:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3245:                     "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliOrig")
3246: 
3247:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliOrig") AND RECCOUNT("cursor_4c_DCliOrig") > 0
3248:                     IF RECCOUNT("cursor_4c_DCliOrig") = 1
3249:                         GO TOP IN cursor_4c_DCliOrig
3250:                         loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3251:                         loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3252:                     ELSE
3253:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3254:                         IF VARTYPE(loc_oBusca) = "O"
3255:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliOrig"
3256:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3257:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3258:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3259:                             loc_oBusca.Show()
3260:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliOrig")
3261:                                 GO TOP IN cursor_4c_DCliOrig
3262:                                 loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3263:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3264:                             ELSE
3265:                                 loc_cConta = ""
3266:                                 loc_cNome  = ""
3267:                             ENDIF
3268:                             loc_oBusca.Release()
3269:                         ENDIF
3270:                     ENDIF
3271:                 ELSE
3272:                     loc_cConta = ""
3273:                     loc_cNome  = ""
3274:                 ENDIF
3275: 
3276:                 IF USED("cursor_4c_DCliOrig")
3277:                     USE IN cursor_4c_DCliOrig
3278:                 ENDIF
3279: 
3280:                 THIS.this_oBusinessObject.this_cContaos = loc_cConta
3281:                 THIS.this_cNomeContaos = loc_cNome
3282:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
3283:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
3284:                         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_cConta
3285:                     ENDIF
3286:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
3287:                         loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = loc_cNome
3288:                     ENDIF
3289:                 ENDIF
3290:             ENDIF
3291:         CATCH TO loc_oErro
3292:             IF USED("cursor_4c_DCliOrig")
3293:                 USE IN cursor_4c_DCliOrig

*-- Linhas 3300 a 3368:
3300:     * GrupoDestinoLostFocus - Valida grupo de Destino ao sair do campo
3301:     * Legado: Destino.Get_grupo.Valid - fwBuscaSel em TmpGccr
3302:     *--------------------------------------------------------------------------
3303:     PROCEDURE GrupoDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3304:         LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
3305:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3306:         loc_cGrupo = ""
3307: 
3308:         TRY
3309:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3310:                PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
3311:                 loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", ;
3312:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
3313:             ENDIF
3314: 
3315:             IF EMPTY(loc_cGrupo)
3316:                 THIS.this_oBusinessObject.this_cGrupods = ""
3317:                 THIS.this_oBusinessObject.this_cContads = ""
3318:                 THIS.this_cNomeContads = ""
3319:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3320:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3321:                         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
3322:                     ENDIF
3323:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3324:                         loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
3325:                     ENDIF
3326:                 ENDIF
3327:             ELSE
3328:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3329:                     "SigCdGcr", "cursor_4c_GrpDest", "codigos", loc_cGrupo, ;
3330:                     "Busca de Grupos")
3331: 
3332:                 IF VARTYPE(loc_oBusca) = "O"
3333:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3334:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3335:                     ELSE
3336:                         IF !loc_oBusca.this_lAchouRegistro
3337:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3338:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3339:                         loc_oBusca.Show()
3340:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpDest")
3341:                             GO TOP IN cursor_4c_GrpDest
3342:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3343:                         ELSE
3344:                             loc_cGrupo = ""
3345:                         ENDIF
3346:                     ELSE
3347:                         loc_cGrupo = ""
3348:                         ENDIF
3349:                     ENDIF
3350:                     loc_oBusca.Release()
3351:                 ENDIF
3352: 
3353:                 IF USED("cursor_4c_GrpDest")
3354:                     USE IN cursor_4c_GrpDest
3355:                 ENDIF
3356: 
3357:                 THIS.this_oBusinessObject.this_cGrupods = loc_cGrupo
3358:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3359:                    PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
3360:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value = loc_cGrupo
3361:                 ENDIF
3362:                 IF EMPTY(loc_cGrupo)
3363:                     THIS.this_oBusinessObject.this_cContads = ""
3364:                     THIS.this_cNomeContads = ""
3365:                     IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3366:                         IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3367:                             loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
3368:                         ENDIF

*-- Linhas 3380 a 3469:
3380:         ENDTRY
3381:     ENDPROC
3382: 
3383:     PROCEDURE TeclaGrupoDestinoKP(par_nKeyCode, par_nShiftAltCtrl)
3384:         IF INLIST(par_nKeyCode, 115, 116)
3385:             THIS.GrupoDestinoLostFocus()
3386:         ENDIF
3387:     ENDPROC
3388: 
3389:     *--------------------------------------------------------------------------
3390:     * ContaDestinoLostFocus - Valida conta de Destino ao sair do campo
3391:     * Legado: Destino.Get_conta.Valid - fwBuscaSel em TmpCli
3392:     *--------------------------------------------------------------------------
3393:     PROCEDURE ContaDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3394:         LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
3395:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3396:         loc_cConta = ""
3397:         loc_cGrupo = ""
3398:         loc_cNome  = ""
3399:         loc_cSQL   = ""
3400: 
3401:         TRY
3402:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3403:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3404:                     loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value) = "C", ;
3405:                         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value, ""))
3406:                 ENDIF
3407:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
3408:                     loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", ;
3409:                         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
3410:                 ENDIF
3411:             ENDIF
3412: 
3413:             IF EMPTY(loc_cConta)
3414:                 THIS.this_oBusinessObject.this_cContads = ""
3415:                 THIS.this_cNomeContads = ""
3416:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3417:                    PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3418:                     loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
3419:                 ENDIF
3420:             ELSE
3421:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3422:                 IF !EMPTY(loc_cGrupo)
3423:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3424:                 ENDIF
3425:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDest")
3426: 
3427:                 IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") = 0
3428:                     USE IN cursor_4c_CliDest
3429:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3430:                         "SIGCDCLI", "cursor_4c_CliDest", "iclis", loc_cConta, ;
3431:                         "Busca de Contas")
3432:                     IF VARTYPE(loc_oBusca) = "O"
3433:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3434:                             loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3435:                             loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3436:                         ELSE
3437:                             IF !loc_oBusca.this_lAchouRegistro
3438:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3439:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3440:                             loc_oBusca.Show()
3441:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliDest")
3442:                                 GO TOP IN cursor_4c_CliDest
3443:                                 loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3444:                                 loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3445:                             ELSE
3446:                                 loc_cConta = ""
3447:                                 loc_cNome  = ""
3448:                             ENDIF
3449:                         ELSE
3450:                             loc_cConta = ""
3451:                             loc_cNome  = ""
3452:                             ENDIF
3453:                         ENDIF
3454:                         loc_oBusca.Release()
3455:                     ENDIF
3456:                 ELSE
3457:                     IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") > 0
3458:                     GO TOP IN cursor_4c_CliDest
3459:                     loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3460:                     loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3461:                     ENDIF
3462:                 ENDIF
3463: 
3464:                 IF USED("cursor_4c_CliDest")
3465:                     USE IN cursor_4c_CliDest
3466:                 ENDIF
3467: 
3468:                 THIS.this_oBusinessObject.this_cContads = loc_cConta
3469:                 THIS.this_cNomeContads = loc_cNome

*-- Linhas 3484 a 3560:
3484:         ENDTRY
3485:     ENDPROC
3486: 
3487:     PROCEDURE TeclaContaDestinoKP(par_nKeyCode, par_nShiftAltCtrl)
3488:         IF INLIST(par_nKeyCode, 115, 116)
3489:             THIS.ContaDestinoLostFocus()
3490:         ENDIF
3491:     ENDPROC
3492: 
3493:     *--------------------------------------------------------------------------
3494:     * DcontaDestinoLostFocus - Busca conta de Destino por nome ao sair do campo
3495:     * Legado: Destino.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome/RClis
3496:     *--------------------------------------------------------------------------
3497:     PROCEDURE DcontaDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3498:         LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
3499:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3500:         loc_cNome  = ""
3501:         loc_cConta = ""
3502: 
3503:         TRY
3504:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
3505:                PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3506:                 loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value) = "C", ;
3507:                     loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value, ""))
3508:             ENDIF
3509: 
3510:             IF !EMPTY(loc_cNome)
3511:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3512:                     "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliDest")
3513: 
3514:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliDest") AND RECCOUNT("cursor_4c_DCliDest") > 0
3515:                     IF RECCOUNT("cursor_4c_DCliDest") = 1
3516:                         GO TOP IN cursor_4c_DCliDest
3517:                         loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3518:                         loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3519:                     ELSE
3520:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3521:                         IF VARTYPE(loc_oBusca) = "O"
3522:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliDest"
3523:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3524:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3525:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3526:                             loc_oBusca.Show()
3527:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliDest")
3528:                                 GO TOP IN cursor_4c_DCliDest
3529:                                 loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3530:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3531:                             ELSE
3532:                                 loc_cConta = ""
3533:                                 loc_cNome  = ""
3534:                             ENDIF
3535:                             loc_oBusca.Release()
3536:                         ENDIF
3537:                     ENDIF
3538:                 ELSE
3539:                     loc_cConta = ""
3540:                     loc_cNome  = ""
3541:                 ENDIF
3542: 
3543:                 IF USED("cursor_4c_DCliDest")
3544:                     USE IN cursor_4c_DCliDest
3545:                 ENDIF
3546: 
3547:                 THIS.this_oBusinessObject.this_cContads = loc_cConta
3548:                 THIS.this_cNomeContads = loc_cNome
3549:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
3550:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
3551:                         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = loc_cConta
3552:                     ENDIF
3553:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
3554:                         loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = loc_cNome
3555:                     ENDIF
3556:                 ENDIF
3557:             ENDIF
3558:         CATCH TO loc_oErro
3559:             IF USED("cursor_4c_DCliDest")
3560:                 USE IN cursor_4c_DCliDest

*-- Linhas 3567 a 3635:
3567:     * GrupoRespLostFocus - Valida grupo de Responsavel ao sair do campo
3568:     * Legado: Responsavel.Get_grupo.Valid - fwBuscaSel em TmpGccr
3569:     *--------------------------------------------------------------------------
3570:     PROCEDURE GrupoRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3571:         LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
3572:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3573:         loc_cGrupo = ""
3574: 
3575:         TRY
3576:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3577:                PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
3578:                 loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", ;
3579:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
3580:             ENDIF
3581: 
3582:             IF EMPTY(loc_cGrupo)
3583:                 THIS.this_oBusinessObject.this_cGrvends = ""
3584:                 THIS.this_oBusinessObject.this_cVends   = ""
3585:                 THIS.this_cNomeVends = ""
3586:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3587:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3588:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
3589:                     ENDIF
3590:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3591:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
3592:                     ENDIF
3593:                 ENDIF
3594:             ELSE
3595:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3596:                     "SigCdGcr", "cursor_4c_GrpResp", "codigos", loc_cGrupo, ;
3597:                     "Busca de Grupos")
3598: 
3599:                 IF VARTYPE(loc_oBusca) = "O"
3600:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3601:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3602:                     ELSE
3603:                         IF !loc_oBusca.this_lAchouRegistro
3604:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3605:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3606:                         loc_oBusca.Show()
3607:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpResp")
3608:                             GO TOP IN cursor_4c_GrpResp
3609:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3610:                         ELSE
3611:                             loc_cGrupo = ""
3612:                         ENDIF
3613:                     ELSE
3614:                         loc_cGrupo = ""
3615:                         ENDIF
3616:                     ENDIF
3617:                     loc_oBusca.Release()
3618:                 ENDIF
3619: 
3620:                 IF USED("cursor_4c_GrpResp")
3621:                     USE IN cursor_4c_GrpResp
3622:                 ENDIF
3623: 
3624:                 THIS.this_oBusinessObject.this_cGrvends = loc_cGrupo
3625:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3626:                    PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
3627:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = loc_cGrupo
3628:                 ENDIF
3629:                 IF EMPTY(loc_cGrupo)
3630:                     THIS.this_oBusinessObject.this_cVends = ""
3631:                     THIS.this_cNomeVends = ""
3632:                     IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3633:                         IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3634:                             loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
3635:                         ENDIF

*-- Linhas 3647 a 3736:
3647:         ENDTRY
3648:     ENDPROC
3649: 
3650:     PROCEDURE TeclaGrupoRespKP(par_nKeyCode, par_nShiftAltCtrl)
3651:         IF INLIST(par_nKeyCode, 115, 116)
3652:             THIS.GrupoRespLostFocus()
3653:         ENDIF
3654:     ENDPROC
3655: 
3656:     *--------------------------------------------------------------------------
3657:     * ContaRespLostFocus - Valida conta de Responsavel ao sair do campo
3658:     * Legado: Responsavel.Get_conta.Valid - fwBuscaSel em TmpCli
3659:     *--------------------------------------------------------------------------
3660:     PROCEDURE ContaRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3661:         LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
3662:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3663:         loc_cConta = ""
3664:         loc_cGrupo = ""
3665:         loc_cNome  = ""
3666:         loc_cSQL   = ""
3667: 
3668:         TRY
3669:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3670:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3671:                     loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value) = "C", ;
3672:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value, ""))
3673:                 ENDIF
3674:                 IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
3675:                     loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", ;
3676:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
3677:                 ENDIF
3678:             ENDIF
3679: 
3680:             IF EMPTY(loc_cConta)
3681:                 THIS.this_oBusinessObject.this_cVends = ""
3682:                 THIS.this_cNomeVends = ""
3683:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3684:                    PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3685:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
3686:                 ENDIF
3687:             ELSE
3688:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3689:                 IF !EMPTY(loc_cGrupo)
3690:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3691:                 ENDIF
3692:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliResp")
3693: 
3694:                 IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") = 0
3695:                     USE IN cursor_4c_CliResp
3696:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3697:                         "SIGCDCLI", "cursor_4c_CliResp", "iclis", loc_cConta, ;
3698:                         "Busca de Contas")
3699:                     IF VARTYPE(loc_oBusca) = "O"
3700:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3701:                             loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3702:                             loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3703:                         ELSE
3704:                             IF !loc_oBusca.this_lAchouRegistro
3705:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3706:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3707:                             loc_oBusca.Show()
3708:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliResp")
3709:                                 GO TOP IN cursor_4c_CliResp
3710:                                 loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3711:                                 loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3712:                             ELSE
3713:                                 loc_cConta = ""
3714:                                 loc_cNome  = ""
3715:                             ENDIF
3716:                         ELSE
3717:                             loc_cConta = ""
3718:                             loc_cNome  = ""
3719:                             ENDIF
3720:                         ENDIF
3721:                         loc_oBusca.Release()
3722:                     ENDIF
3723:                 ELSE
3724:                     IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") > 0
3725:                     GO TOP IN cursor_4c_CliResp
3726:                     loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3727:                     loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3728:                     ENDIF
3729:                 ENDIF
3730: 
3731:                 IF USED("cursor_4c_CliResp")
3732:                     USE IN cursor_4c_CliResp
3733:                 ENDIF
3734: 
3735:                 THIS.this_oBusinessObject.this_cVends = loc_cConta
3736:                 THIS.this_cNomeVends = loc_cNome

*-- Linhas 3751 a 3827:
3751:         ENDTRY
3752:     ENDPROC
3753: 
3754:     PROCEDURE TeclaContaRespKP(par_nKeyCode, par_nShiftAltCtrl)
3755:         IF INLIST(par_nKeyCode, 115, 116)
3756:             THIS.ContaRespLostFocus()
3757:         ENDIF
3758:     ENDPROC
3759: 
3760:     *--------------------------------------------------------------------------
3761:     * DcontaRespLostFocus - Busca conta de Responsavel por nome ao sair do campo
3762:     * Legado: Responsavel.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome
3763:     *--------------------------------------------------------------------------
3764:     PROCEDURE DcontaRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3765:         LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
3766:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3767:         loc_cNome  = ""
3768:         loc_cConta = ""
3769: 
3770:         TRY
3771:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
3772:                PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3773:                 loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value) = "C", ;
3774:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value, ""))
3775:             ENDIF
3776: 
3777:             IF !EMPTY(loc_cNome)
3778:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3779:                     "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliResp")
3780: 
3781:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliResp") AND RECCOUNT("cursor_4c_DCliResp") > 0
3782:                     IF RECCOUNT("cursor_4c_DCliResp") = 1
3783:                         GO TOP IN cursor_4c_DCliResp
3784:                         loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3785:                         loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3786:                     ELSE
3787:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3788:                         IF VARTYPE(loc_oBusca) = "O"
3789:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliResp"
3790:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3791:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3792:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3793:                             loc_oBusca.Show()
3794:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliResp")
3795:                                 GO TOP IN cursor_4c_DCliResp
3796:                                 loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3797:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3798:                             ELSE
3799:                                 loc_cConta = ""
3800:                                 loc_cNome  = ""
3801:                             ENDIF
3802:                             loc_oBusca.Release()
3803:                         ENDIF
3804:                     ENDIF
3805:                 ELSE
3806:                     loc_cConta = ""
3807:                     loc_cNome  = ""
3808:                 ENDIF
3809: 
3810:                 IF USED("cursor_4c_DCliResp")
3811:                     USE IN cursor_4c_DCliResp
3812:                 ENDIF
3813: 
3814:                 THIS.this_oBusinessObject.this_cVends = loc_cConta
3815:                 THIS.this_cNomeVends = loc_cNome
3816:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
3817:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
3818:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = loc_cConta
3819:                     ENDIF
3820:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
3821:                         loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = loc_cNome
3822:                     ENDIF
3823:                 ENDIF
3824:             ENDIF
3825:         CATCH TO loc_oErro
3826:             IF USED("cursor_4c_DCliResp")
3827:                 USE IN cursor_4c_DCliResp

*-- Linhas 3835 a 3915:
3835:     * Legado: get_codobs.Valid - Query SigCdObs WHERE codigos BETWEEN pIni AND pFim
3836:     *   depois fwBuscaSel se nao encontrado. Preenche Mm_obs com observas.
3837:     *--------------------------------------------------------------------------
3838:     PROCEDURE CodobsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3839:         LOCAL loc_oPg2, loc_nCod, loc_nRet, loc_oBusca, loc_cObs
3840:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3841:         loc_nCod  = 0
3842:         loc_cObs  = ""
3843: 
3844:         TRY
3845:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
3846:                 loc_nCod = IIF(VARTYPE(loc_oPg2.txt_4c_Codobs.Value) = "N", loc_oPg2.txt_4c_Codobs.Value, 0)
3847:             ENDIF
3848: 
3849:             IF loc_nCod = 0
3850:                 *-- Campo vazio: limpa BO e EditBox
3851:                 THIS.this_oBusinessObject.this_cCodObs = ""
3852:                 THIS.this_cAntValue = ""
3853:                 IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
3854:                     loc_oPg2.edt_4c_Mmobs.Value = ""
3855:                 ENDIF
3856:             ELSE
3857:                 IF TRANSFORM(loc_nCod) = THIS.this_cAntValue
3858:                 *-- Sem mudanca de valor: nao re-consulta
3859:                 THIS.this_oBusinessObject.this_cCodObs = ALLTRIM(TRANSFORM(loc_nCod))
3860:             ELSE
3861:                 THIS.this_cAntValue = TRANSFORM(loc_nCod)
3862: 
3863:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3864:                     "SELECT codigos, descrs, observas FROM SigCdObs WHERE codigos = " + ;
3865:                     FormatarNumeroSQL(loc_nCod), "cursor_4c_ObsBusca")
3866: 
3867:                 IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") = 0
3868:                     USE IN cursor_4c_ObsBusca
3869:                     *-- Nao encontrou: abre busca completa
3870:                     loc_nRet = SQLEXEC(gnConnHandle, ;
3871:                         "SELECT codigos, descrs, observas FROM SigCdObs ORDER BY codigos", ;
3872:                         "cursor_4c_ObsBusca")
3873: 
3874:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca")
3875:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3876:                         IF VARTYPE(loc_oBusca) = "O"
3877:                             loc_oBusca.this_cCursorDestino = "cursor_4c_ObsBusca"
3878:                             loc_oBusca.this_cTitulo = "Observa" + CHR(231) + CHR(227) + "es"
3879:                             loc_oBusca.mAddColuna("codigos", "999",                                                "C" + CHR(243) + "d.")
3880:                             loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3881:                             loc_oBusca.Show()
3882:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ObsBusca")
3883:                                 GO TOP IN cursor_4c_ObsBusca
3884:                                 loc_nCod = cursor_4c_ObsBusca.codigos
3885:                                 loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3886:                             ELSE
3887:                                 loc_nCod = 0
3888:                                 loc_cObs = ""
3889:                             ENDIF
3890:                             loc_oBusca.Release()
3891:                         ENDIF
3892:                     ENDIF
3893:                 ELSE
3894:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") > 0
3895:                     GO TOP IN cursor_4c_ObsBusca
3896:                     loc_nCod = cursor_4c_ObsBusca.codigos
3897:                     loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3898:                     ENDIF
3899:                 ENDIF
3900: 
3901:                 IF USED("cursor_4c_ObsBusca")
3902:                     USE IN cursor_4c_ObsBusca
3903:                 ENDIF
3904: 
3905:                 THIS.this_oBusinessObject.this_cCodObs = IIF(loc_nCod > 0, ALLTRIM(TRANSFORM(loc_nCod)), "")
3906:                 THIS.this_oBusinessObject.this_cObss   = loc_cObs
3907: 
3908:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
3909:                     loc_oPg2.txt_4c_Codobs.Value = loc_nCod
3910:                 ENDIF
3911:                 IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
3912:                     loc_oPg2.edt_4c_Mmobs.Value = loc_cObs
3913:                 ENDIF
3914:                 ENDIF
3915:             ENDIF

*-- Linhas 3921 a 3943:
3921:         ENDTRY
3922:     ENDPROC
3923: 
3924:     PROCEDURE TeclaCodobsKP(par_nKeyCode, par_nShiftAltCtrl)
3925:         IF INLIST(par_nKeyCode, 115, 116)
3926:             THIS.CodobsLostFocus()
3927:         ENDIF
3928:     ENDPROC
3929: 
3930:     *--------------------------------------------------------------------------
3931:     * Destroy - Libera recursos ao fechar o formulario
3932:     *--------------------------------------------------------------------------
3933:     PROCEDURE Destroy()
3934:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3935:             THIS.this_oBusinessObject = .NULL.
3936:         ENDIF
3937:         IF USED("cursor_4c_Dados")
3938:             USE IN cursor_4c_Dados
3939:         ENDIF
3940:         DODEFAULT()
3941:     ENDPROC
3942: 
3943: ENDDEFINE


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

