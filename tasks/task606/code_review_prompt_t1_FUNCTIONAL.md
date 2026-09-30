# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'OptCotacao' (parent: SIGPRES1.Container1): Top original=165 vs migrado 'obj_4c_OptCotacao' Top=5 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptCotacao' (parent: SIGPRES1.Container1): Left original=308 vs migrado 'obj_4c_OptCotacao' Left=5 (diff=303px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGPRES1.Container1): Left original=50 vs migrado 'lbl_4c_Lbl_periodo_a' Left=183 (diff=133px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_impressao' (parent: SIGPRES1.Container1): Top original=213 vs migrado 'obj_4c_Opt_impressao' Top=5 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_impressao' (parent: SIGPRES1.Container1): Left original=94 vs migrado 'obj_4c_Opt_impressao' Left=5 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Pendente' (parent: SIGPRES1.Container1): Top original=191 vs migrado 'obj_4c_Opt_Pendente' Top=5 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Pendente' (parent: SIGPRES1.Container1): Left original=94 vs migrado 'obj_4c_Opt_Pendente' Left=5 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_nr_periodo' (parent: SIGPRES1.Container1): Top original=36 vs migrado 'obj_4c_Opt_nr_periodo' Top=5 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_nr_periodo' (parent: SIGPRES1.Container1): Left original=273 vs migrado 'obj_4c_Opt_nr_periodo' Left=5 (diff=268px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1769 linhas total):

*-- Linhas 41 a 206:
41: * SET EXACT, entao nao precisa repor DELETED/EXACT).
42: *
43: * FASE 8 (consolidacao) entregou o par de hooks canonico, com os nomes de
44: * FormBase (ambos PROTECTED PROCEDURE, como na classe base - subclasse nao
45: * alarga escopo de hook):
46: *   - FormParaBO  : controles -> propriedades do BO (era
47: *                   "SincronizarFiltrosComBO"; renomeado para o nome canonico,
48: *                   o comportamento nao mudou). Chamado por BtnConsultarClick.
49: *   - BOParaForm  : BO -> controles, na abertura da tela. NOVO nesta fase - o
50: *                   bloco "With .Container1" do Init legado nao tinha sido
51: *                   migrado, e com ele faltava ".get_cd_empresa.Value = _empr":
52: *                   a Empresa abria VAZIA e todo primeiro Consultar caia em
53: *                   "Empresa Invalida!!!".
54: *
55: * NAO existem aqui, porque o legado SIGPRES1 nao os tem e cria-los seria
56: * inventar superficie (PILAR 1) ou deixar metodo vazio (regra de completude):
57: *   - CarregarLista / grd_*  : o SCX nao tem Grid nem PageFrame; os 7
58: *     "ControlSource" do dump sao TODOS string vazia em TextBox de filtro. O
59: *     resultado da consulta nao eh exibido aqui - vai para a tela filha
60: *     Formsigpres2 pelo cursor csTemporario.
61: *   - BtnSalvarClick / BtnCancelarClick / HabilitarCampos /
62: *     AjustarBotoesPorModo : nao ha Page2 de Dados, nem modo de edicao, nem
63: *     gravacao - o dump nao tem INSERT/UPDATE/DELETE em tabela nenhuma. O
64: *     botao de acao do legado eh o "Consultar" (commandgroup "sair",
65: *     Command1), cujo handler eh BtnConsultarClick.
66: *==============================================================================
67: 
68: DEFINE CLASS FormSigPrEs1 AS FormBase
69: 
70:     *-- Propriedades visuais (SECAO 2 do dump, objeto SIGPRES1)
71:     Width        = 823
72:     Height       = 400
73:     Caption      = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
74:     AutoCenter   = .T.
75:     BorderStyle  = 2
76:     ControlBox   = .F.
77:     MaxButton    = .F.
78:     MinButton    = .F.
79:     TitleBar     = 0
80:     ShowWindow   = 1
81:     WindowType   = 1
82:     DataSession  = 2
83:     ClipControls = .F.
84: 
85:     *--------------------------------------------------------------------------
86:     * Init - Apenas DODEFAULT() (FormBase.Init() chama InicializarForm())
87:     *--------------------------------------------------------------------------
88:     PROCEDURE Init()
89:         RETURN DODEFAULT()
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     * InicializarForm - Hook chamado por FormBase.Init(). Equivalente ao
94:     * trecho do Init legado ".poDataMgr = CreateObject('fSqlConector', ...) /
95:     * If (.poDataMgr.pnIdconn > 0)": instancia o Business Object (que usa o
96:     * handle de conexao global gnConnHandle, ja aberto no startup - nao ha
97:     * conexao privada por form na nova arquitetura) e monta a estrutura
98:     * visual base.
99:     *--------------------------------------------------------------------------
100:     PROTECTED PROCEDURE InicializarForm()
101:         LOCAL loc_lSucesso, loc_oErro
102:         loc_lSucesso = .F.
103: 
104:         TRY
105:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
106:                 MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
107:             ELSE
108:                 THIS.this_oBusinessObject = CREATEOBJECT("SigPrEs1BO")
109: 
110:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
111:                     MsgErro("Falha ao criar SigPrEs1BO.", "Erro")
112:                 ELSE
113:                     THIS.ConfigurarPageFrame()
114:                     THIS.ConfigurarCabecalho()
115:                     THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
116:                     THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
117: 
118:                     THIS.ConfigurarContainerFiltros()
119:                     THIS.RegistrarLookupsFiltros()
120:                     THIS.ConfigurarBotoesAcao()
121: 
122:                     *-- Dispatcher do CommandGroup obj_4c_Sair (Consultar/Encerrar)
123:                     BINDEVENT(THIS.obj_4c_Sair, "Click", THIS, "BtnSairClick")
124: 
125:                     *-- Estado inicial dos filtros (bloco "With .Container1"
126:                     *-- do Init legado). Depois de ConfigurarContainerFiltros
127:                     *-- porque so aqui os controles ja existem.
128:                     THIS.BOParaForm()
129: 
130:                     THIS.TornarControlesVisiveis(THIS)
131: 
132:                     loc_lSucesso = .T.
133:                 ENDIF
134:             ENDIF
135:         CATCH TO loc_oErro
136:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
137:                 loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
138:         ENDTRY
139: 
140:         RETURN loc_lSucesso
141:     ENDPROC
142: 
143:     *--------------------------------------------------------------------------
144:     * ConfigurarPageFrame - Fundo do form (equivalente ao .Picture do legado:
145:     * ..\framework\imagens\fundo_cadastro.jpg). Sem PageFrame de verdade - o
146:     * legado eh flat (ver cabecalho do arquivo). Nome mantido por convencao
147:     * do pipeline multi-fase (mesmo padrao de FormSigPrIct.prg).
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarPageFrame()
150:         LOCAL loc_cImagem
151:         loc_cImagem = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"
152: 
153:         IF FILE(loc_cImagem)
154:             THIS.Picture = loc_cImagem
155:         ENDIF
156:     ENDPROC
157: 
158:     *--------------------------------------------------------------------------
159:     * ConfigurarCabecalho - cnt_4c_Sombra (cntSombra legado) com os dois
160:     * labels de titulo. Bloco canonico/boilerplate (mesmo padrao usado em
161:     * dezenas de forms REPORT/OPERACIONAIS) - identifica-se por
162:     * BackColor=RGB(100,100,100), NUNCA pelo nome (CLAUDE.md regra #11).
163:     * Nomes conforme mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
164:     * lbl_4c_LblTitulo.
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarCabecalho()
167:         THIS.AddObject("cnt_4c_Sombra", "Container")
168:         WITH THIS.cnt_4c_Sombra
169:             .Top         = 0
170:             .Left        = 0
171:             .Width       = THIS.Width
172:             .Height      = 80
173:             .BackStyle   = 1
174:             .BackColor   = RGB(100, 100, 100)
175:             .BorderWidth = 0
176: 
177:             .AddObject("lbl_4c_LblSombra", "Label")
178:             WITH .lbl_4c_LblSombra
179:                 .AutoSize      = .F.
180:                 .FontBold      = .T.
181:                 .FontName      = "Tahoma"
182:                 .FontSize      = 18
183:                 .FontUnderline = .F.
184:                 .WordWrap      = .T.
185:                 .Alignment     = 0
186:                 .BackStyle     = 0
187:                 .Caption       = ""
188:                 .Height        = 40
189:                 .Left          = 10
190:                 .Top           = 25
191:                 .Width         = THIS.Width
192:                 .ForeColor     = RGB(0, 0, 0)
193:             ENDWITH
194: 
195:             .AddObject("lbl_4c_LblTitulo", "Label")
196:             WITH .lbl_4c_LblTitulo
197:                 .AutoSize    = .F.
198:                 .FontBold    = .T.
199:                 .FontName    = "Tahoma"
200:                 .FontSize    = 18
201:                 .WordWrap    = .T.
202:                 .Alignment   = 0
203:                 .BackStyle   = 0
204:                 .Caption     = ""
205:                 .Height      = 46
206:                 .Left        = 10

*-- Linhas 229 a 284:
229:     * WITH loc_oCnt.<filho> com caminho explicito (nunca AddObject dentro de
230:     * um WITH pai seguido de WITH .filho aninhado) - CLAUDE.md regra sobre
231:     * WITH aninhado silenciosamente ignorando propriedades (Container/Label/
232:     * CommandGroup/OptionGroup criados via AddObject). Excecao permitida:
233:     * WITH loc_oCnt.obj_4c_Opt_nr_periodo seguido de WITH .Buttons(N)
234:     * aninhado (1 nivel dentro do OptionGroup, padrao seguro documentado).
235:     *
236:     * Labels sem Width/Alignment no dump (classe say pura) recebem
237:     * .Alignment = 0 + .Width calculada para nao entrar no controle vizinho
238:     * (CLAUDE.md regra #23 - jamais inventar Alignment=1). TabIndex
239:     * transcrito do dump (regra sobre ordem de tabulacao). .Margin NAO
240:     * copiado dos controles fwget do legado (get_cd_empresa/getPStatus/
241:     * Get_cpf): TextBox base do VFP9 nao tem essa propriedade (regra #33 -
242:     * propriedade que a classe nao tem trava o Init).
243:     *--------------------------------------------------------------------------
244:     PROTECTED PROCEDURE ConfigurarContainerFiltros()
245:         LOCAL loc_oCnt
246: 
247:         THIS.AddObject("cnt_4c_Container1", "Container")
248:         loc_oCnt = THIS.cnt_4c_Container1
249: 
250:         WITH loc_oCnt
251:             .Top         = 84
252:             .Left        = 84
253:             .Width       = 618
254:             .Height      = 249
255:             .BackStyle   = 0
256:             .BorderWidth = 0
257:         ENDWITH
258: 
259:         *-- Empresa : [cod] [descricao]  (chk) Empresa Destino
260:         loc_oCnt.AddObject("lbl_4c_Lbl_empresa", "Label")
261:         WITH loc_oCnt.lbl_4c_Lbl_empresa
262:             .AutoSize  = .F.
263:             .Alignment = 0
264:             .BackStyle = 0
265:             .FontName  = "Tahoma"
266:             .FontSize  = 8
267:             .Caption   = "Empresa :"
268:             .Left      = 45
269:             .Top       = 13
270:             .Width     = 51
271:             .Height    = 15
272:             .ForeColor = RGB(90, 90, 90)
273:             .TabIndex  = 24
274:         ENDWITH
275: 
276:         loc_oCnt.AddObject("txt_4c__cd_empresa", "TextBox")
277:         WITH loc_oCnt.txt_4c__cd_empresa
278:             .Value         = ""
279:             .FontName      = "Tahoma"
280:             .Format        = "K!"
281:             .Height        = 23
282:             .Left          = 100
283:             .Top           = 10
284:             .Width         = 31

*-- Linhas 381 a 424:
381:             .TabIndex      = 5
382:         ENDWITH
383: 
384:         loc_oCnt.AddObject("obj_4c_Opt_nr_periodo", "OptionGroup")
385:         WITH loc_oCnt.obj_4c_Opt_nr_periodo
386:             .ButtonCount = 2
387:             .Value       = 1
388:             .Top         = 36
389:             .Left        = 273
390:             .Width       = 185
391:             .Height      = 25
392:             .BackStyle   = 0
393:             .BorderStyle = 0
394:             .TabIndex    = 6
395: 
396:             WITH .Buttons(1)
397:                 .Caption   = "Lan" + CHR(231) + "amento"
398:                 .BackStyle = 0
399:                 .FontName  = "Tahoma"
400:                 .Left      = 5
401:                 .Top       = 5
402:                 .Width     = 76
403:                 .Height    = 17
404:             ENDWITH
405: 
406:             WITH .Buttons(2)
407:                 .Caption   = "Prazo Entrega"
408:                 .BackStyle = 0
409:                 .FontName  = "Tahoma"
410:                 .Left      = 94
411:                 .Top       = 5
412:                 .Width     = 90
413:                 .Height    = 17
414:             ENDWITH
415:         ENDWITH
416: 
417:         *-- Movimentacao : [nm_operacao]   OP : [op]  Numero : [Numero]  Status : [PStatus]
418:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
419:         WITH loc_oCnt.lbl_4c_Label1
420:             .AutoSize  = .F.
421:             .Alignment = 0
422:             .BackStyle = 0
423:             .FontName  = "Tahoma"
424:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"

*-- Linhas 750 a 850:
750:             .TabIndex  = 33
751:         ENDWITH
752: 
753:         loc_oCnt.AddObject("obj_4c_OptCotacao", "OptionGroup")
754:         WITH loc_oCnt.obj_4c_OptCotacao
755:             .ButtonCount = 2
756:             .Value       = 1
757:             .Top         = 165
758:             .Left        = 308
759:             .Width       = 203
760:             .Height      = 27
761:             .BackStyle   = 0
762:             .BorderStyle = 0
763:             .Themes      = .F.
764:             .TabIndex    = 20
765: 
766:             WITH .Buttons(1)
767:                 .Caption   = "\<Fechamento"
768:                 .BackStyle = 0
769:                 .FontName  = "Tahoma"
770:                 .FontSize  = 8
771:                 .Left      = 5
772:                 .Top       = 5
773:                 .Width     = 89
774:                 .Height    = 17
775:                 .ForeColor = RGB(90, 90, 90)
776:                 .Themes    = .F.
777:             ENDWITH
778: 
779:             WITH .Buttons(2)
780:                 .Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
781:                 .BackStyle = 0
782:                 .FontName  = "Tahoma"
783:                 .FontSize  = 8
784:                 .Left      = 100
785:                 .Top       = 5
786:                 .Width     = 100
787:                 .Height    = 17
788:                 .ForeColor = RGB(90, 90, 90)
789:                 .Themes    = .F.
790:             ENDWITH
791:         ENDWITH
792: 
793:         *-- Situacao : OptionGroup de 3 botoes, criado logo abaixo; as captions
794:         *-- sao transcritas do SCX legado
795:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
796:         WITH loc_oCnt.lbl_4c_Label2
797:             .AutoSize  = .T.
798:             .Alignment = 0
799:             .BackStyle = 0
800:             .FontName  = "Tahoma"
801:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
802:             .Left      = 45
803:             .Top       = 196
804:             .Width     = 50
805:             .Height    = 15
806:             .ForeColor = RGB(90, 90, 90)
807:             .TabIndex  = 34
808:         ENDWITH
809: 
810:         loc_oCnt.AddObject("obj_4c_Opt_Pendente", "OptionGroup")
811:         WITH loc_oCnt.obj_4c_Opt_Pendente
812:             .ButtonCount   = 3
813:             .Value         = 3
814:             .Top           = 191
815:             .Left          = 94
816:             .Width         = 232
817:             .Height        = 25
818:             .BackStyle     = 0
819:             .BorderStyle   = 0
820:             .SpecialEffect = 0
821:             .TabIndex      = 21
822: 
823:             WITH .Buttons(1)
824:                 .Caption   = "Pendentes"
825:                 .BackStyle = 0
826:                 .FontName  = "Tahoma"
827:                 .Left      = 5
828:                 .Top       = 5
829:                 .Width     = 69
830:                 .Height    = 15
831:                 .ForeColor = RGB(90, 90, 90)
832:             ENDWITH
833: 
834:             WITH .Buttons(2)
835:                 .Caption   = "Baixadas"
836:                 .BackStyle = 0
837:                 .FontName  = "Tahoma"
838:                 .Left      = 89
839:                 .Top       = 5
840:                 .Height    = 15
841:                 .ForeColor = RGB(90, 90, 90)
842:             ENDWITH
843: 
844:             WITH .Buttons(3)
845:                 .Caption   = "Todas"
846:                 .BackStyle = 0
847:                 .FontName  = "Tahoma"
848:                 .FontSize  = 8
849:                 .Left      = 166
850:                 .Top       = 5

*-- Linhas 871 a 1462:
871:             .TabIndex  = 35
872:         ENDWITH
873: 
874:         loc_oCnt.AddObject("obj_4c_Opt_impressao", "OptionGroup")
875:         WITH loc_oCnt.obj_4c_Opt_impressao
876:             .ButtonCount   = 2
877:             .Value         = 1
878:             .Top           = 213
879:             .Left          = 94
880:             .Width         = 229
881:             .Height        = 25
882:             .BackStyle     = 0
883:             .BorderStyle   = 0
884:             .SpecialEffect = 0
885:             .TabIndex      = 22
886: 
887:             WITH .Buttons(1)
888:                 .Caption   = "Por Vendedor"
889:                 .BackStyle = 0
890:                 .Left      = 5
891:                 .Top       = 5
892:                 .Width     = 83
893:                 .Height    = 15
894:                 .ForeColor = RGB(90, 90, 90)
895:             ENDWITH
896: 
897:             WITH .Buttons(2)
898:                 .Caption   = "Por Movimenta" + CHR(231) + CHR(227) + "o"
899:                 .BackStyle = 0
900:                 .Left      = 118
901:                 .Top       = 5
902:                 .ForeColor = RGB(90, 90, 90)
903:             ENDWITH
904:         ENDWITH
905: 
906:         loc_oCnt.Visible = .T.
907:     ENDPROC
908: 
909:     *--------------------------------------------------------------------------
910:     * RegistrarLookupsFiltros - BINDEVENT de KeyPress para TODOS os campos de
911:     * filtro com lookup no legado (Grupo, Conta, Moeda, Responsavel, Empresa,
912:     * Movimentacao, CPF/CGC). Cada handler dispara em ENTER(13)/TAB(9)/F4(115),
913:     * igual ao Valid do SCX (BINDEVENT "Valid" nao funciona em TextBox - regra
914:     * do CLAUDE.md). Handlers PUBLIC (BINDEVENT exige metodo publico).
915:     *--------------------------------------------------------------------------
916:     PROTECTED PROCEDURE RegistrarLookupsFiltros()
917:         LOCAL loc_oCnt
918:         loc_oCnt = THIS.cnt_4c_Container1
919: 
920:         BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoCodigoKeyPress")
921:         BINDEVENT(loc_oCnt.txt_4c__Dgrupo, "KeyPress", THIS, "TxtGrupoDescricaoKeyPress")
922:         BINDEVENT(loc_oCnt.txt_4c_Conta, "KeyPress", THIS, "TxtContaCodigoKeyPress")
923:         BINDEVENT(loc_oCnt.txt_4c_Dconta, "KeyPress", THIS, "TxtContaDescricaoKeyPress")
924:         BINDEVENT(loc_oCnt.txt_4c__cd_moeda, "KeyPress", THIS, "TxtMoedaCodigoKeyPress")
925:         BINDEVENT(loc_oCnt.txt_4c__ds_moeda, "KeyPress", THIS, "TxtMoedaDescricaoKeyPress")
926:         BINDEVENT(loc_oCnt.txt_4c__resps, "KeyPress", THIS, "TxtRespCodigoKeyPress")
927:         BINDEVENT(loc_oCnt.txt_4c__dresps, "KeyPress", THIS, "TxtRespDescricaoKeyPress")
928:         BINDEVENT(loc_oCnt.txt_4c__cd_empresa, "KeyPress", THIS, "TxtEmpresaCodigoKeyPress")
929:         BINDEVENT(loc_oCnt.txt_4c__ds_empresa, "KeyPress", THIS, "TxtEmpresaDescricaoKeyPress")
930:         BINDEVENT(loc_oCnt.txt_4c__nm_operacao, "KeyPress", THIS, "TxtOperacaoKeyPress")
931:         BINDEVENT(loc_oCnt.txt_4c_Cpf, "KeyPress", THIS, "TxtCpfKeyPress")
932:     ENDPROC
933: 
934:     *--------------------------------------------------------------------------
935:     * Handlers de KeyPress (PUBLIC - exigido por BINDEVENT). Cada um so age em
936:     * ENTER/TAB/F4 e delega para o Validar* correspondente (equivalente ao
937:     * Valid do controle no SCX legado).
938:     *--------------------------------------------------------------------------
939:     PROCEDURE TxtGrupoCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
940:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
941:             RETURN
942:         ENDIF
943:         THIS.ValidarGrupoCodigo()
944:     ENDPROC
945: 
946:     PROCEDURE TxtGrupoDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
947:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
948:             RETURN
949:         ENDIF
950:         THIS.ValidarGrupoDescricao()
951:     ENDPROC
952: 
953:     PROCEDURE TxtContaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
954:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
955:             RETURN
956:         ENDIF
957:         THIS.ValidarContaCodigo()
958:     ENDPROC
959: 
960:     PROCEDURE TxtContaDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
961:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
962:             RETURN
963:         ENDIF
964:         THIS.ValidarContaDescricao()
965:     ENDPROC
966: 
967:     PROCEDURE TxtMoedaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
968:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
969:             RETURN
970:         ENDIF
971:         THIS.ValidarMoedaCodigo()
972:     ENDPROC
973: 
974:     PROCEDURE TxtMoedaDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
975:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
976:             RETURN
977:         ENDIF
978:         THIS.ValidarMoedaDescricao()
979:     ENDPROC
980: 
981:     PROCEDURE TxtRespCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
982:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
983:             RETURN
984:         ENDIF
985:         THIS.ValidarResponsavelCodigo()
986:     ENDPROC
987: 
988:     PROCEDURE TxtRespDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
989:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
990:             RETURN
991:         ENDIF
992:         THIS.ValidarResponsavelDescricao()
993:     ENDPROC
994: 
995:     PROCEDURE TxtEmpresaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
996:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
997:             RETURN
998:         ENDIF
999:         THIS.ValidarEmpresaCodigo()
1000:     ENDPROC
1001: 
1002:     PROCEDURE TxtEmpresaDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1003:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1004:             RETURN
1005:         ENDIF
1006:         THIS.ValidarEmpresaDescricao()
1007:     ENDPROC
1008: 
1009:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1010:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1011:             RETURN
1012:         ENDIF
1013:         THIS.ValidarOperacao()
1014:     ENDPROC
1015: 
1016:     PROCEDURE TxtCpfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1017:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1018:             RETURN
1019:         ENDIF
1020:         THIS.ValidarCpf()
1021:     ENDPROC
1022: 
1023:     *--------------------------------------------------------------------------
1024:     * ValidarGrupoCodigo / ValidarGrupoDescricao - Grupo Contabil (SigCdGcr).
1025:     * Equivalente a Get_Grupo.Valid / Get_Dgrupo.Valid do legado: chama a
1026:     * funcao ja portada fAcessoContab (utils\functions.prg), que faz o SEEK
1027:     * exato e so abre o picker (FormBuscaSimples, interno a propria funcao)
1028:     * quando nao acha - populando os dois TextBox sozinha.
1029:     *--------------------------------------------------------------------------
1030:     PROTECTED PROCEDURE ValidarGrupoCodigo()
1031:         LOCAL loc_oCnt
1032:         loc_oCnt = THIS.cnt_4c_Container1
1033: 
1034:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
1035:             = fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
1036:                 loc_oCnt.txt_4c_Grupo, loc_oCnt.txt_4c__Dgrupo)
1037:         ELSE
1038:             loc_oCnt.txt_4c__Dgrupo.Value = ""
1039:         ENDIF
1040:     ENDPROC
1041: 
1042:     PROTECTED PROCEDURE ValidarGrupoDescricao()
1043:         LOCAL loc_oCnt
1044:         loc_oCnt = THIS.cnt_4c_Container1
1045: 
1046:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value))
1047:             = fAcessoContab(gc_4c_UsuarioLogado, "D", ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value), ;
1048:                 loc_oCnt.txt_4c_Grupo, loc_oCnt.txt_4c__Dgrupo)
1049:         ELSE
1050:             loc_oCnt.txt_4c_Grupo.Value = ""
1051:         ENDIF
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * ValidarContaCodigo / ValidarContaDescricao - Conta Corrente (SigCdCli).
1056:     * Equivalente a Get_Conta.Valid / Get_Dconta.Valid: fAcessoContas (portada)
1057:     * faz o SEEK exato + picker interno, e em seguida o legado busca o
1058:     * CPF/CGC da conta escolhida (ObterCpfConta espelha o
1059:     * "CursorQuery('SigCdCli',,'iClis',lcConta,'Cpfs')" do dump).
1060:     *--------------------------------------------------------------------------
1061:     PROTECTED PROCEDURE ValidarContaCodigo()
1062:         LOCAL loc_oCnt, loc_cGrupo, loc_cConta
1063: 
1064:         loc_oCnt   = THIS.cnt_4c_Container1
1065:         loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1066: 
1067:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
1068:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
1069:                     loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
1070:                 MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1071:                 loc_oCnt.txt_4c_Conta.Value  = ""
1072:                 loc_oCnt.txt_4c_Dconta.Value = ""
1073:                 loc_oCnt.txt_4c_Cpf.Value    = ""
1074:             ENDIF
1075:         ELSE
1076:             loc_oCnt.txt_4c_Dconta.Value = ""
1077:             loc_oCnt.txt_4c_Cpf.Value    = ""
1078:         ENDIF
1079: 
1080:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1081:         IF !EMPTY(loc_cConta)
1082:             loc_oCnt.txt_4c_Cpf.Value = THIS.ObterCpfConta(loc_cConta)
1083:         ENDIF
1084:     ENDPROC
1085: 
1086:     PROTECTED PROCEDURE ValidarContaDescricao()
1087:         LOCAL loc_oCnt, loc_cGrupo, loc_cConta
1088: 
1089:         loc_oCnt   = THIS.cnt_4c_Container1
1090:         loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1091: 
1092:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
1093:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value), ;
1094:                     loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
1095:                 MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1096:                 loc_oCnt.txt_4c_Dconta.Value = ""
1097:                 loc_oCnt.txt_4c_Conta.Value  = ""
1098:                 loc_oCnt.txt_4c_Cpf.Value    = ""
1099:             ENDIF
1100:         ELSE
1101:             loc_oCnt.txt_4c_Conta.Value = ""
1102:             loc_oCnt.txt_4c_Cpf.Value   = ""
1103:         ENDIF
1104: 
1105:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1106:         IF !EMPTY(loc_cConta)
1107:             loc_oCnt.txt_4c_Cpf.Value = THIS.ObterCpfConta(loc_cConta)
1108:         ENDIF
1109:     ENDPROC
1110: 
1111:     *--------------------------------------------------------------------------
1112:     * ObterCpfConta - Le o CPF/CGC da conta (SigCdCli.Cpfs), equivalente ao
1113:     * ThisForm.Podatamgr.CursorQuery([SigCdCli],[crTmpCli],[iClis],lcConta,[Cpfs])
1114:     * do dump legado.
1115:     *--------------------------------------------------------------------------
1116:     PROTECTED PROCEDURE ObterCpfConta(par_cConta)
1117:         LOCAL loc_cSQL, loc_nResultado, loc_cCpf
1118:         loc_cCpf = ""
1119: 
1120:         IF USED("cursor_4c_SigPrEs1Cpf")
1121:             USE IN cursor_4c_SigPrEs1Cpf
1122:         ENDIF
1123: 
1124:         loc_cSQL = "SELECT Cpfs FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta)
1125:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Cpf")
1126: 
1127:         IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Cpf") AND RECCOUNT("cursor_4c_SigPrEs1Cpf") > 0
1128:             loc_cCpf = ALLTRIM(TratarNulo(cursor_4c_SigPrEs1Cpf.Cpfs, ""))
1129:         ENDIF
1130: 
1131:         IF USED("cursor_4c_SigPrEs1Cpf")
1132:             USE IN cursor_4c_SigPrEs1Cpf
1133:         ENDIF
1134: 
1135:         RETURN loc_cCpf
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * ValidarMoedaCodigo / ValidarMoedaDescricao - Moeda (SigCdMoe). O legado
1140:     * usa fwbuscaext (CreateObject direto); aqui o Pattern B (CREATEOBJECT com
1141:     * parametros) eh PROIBIDO - substituido por match exato via SQLEXEC e,
1142:     * na falta, THIS.AbrirLookupCanonico (Pattern A, FormBase.prg).
1143:     *--------------------------------------------------------------------------
1144:     PROTECTED PROCEDURE ValidarMoedaCodigo()
1145:         LOCAL loc_oCnt, loc_cValor
1146:         loc_oCnt  = THIS.cnt_4c_Container1
1147:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c__cd_moeda.Value)
1148: 
1149:         IF EMPTY(loc_cValor)
1150:             loc_oCnt.txt_4c__ds_moeda.Value = ""
1151:             RETURN
1152:         ENDIF
1153: 
1154:         THIS.AbrirLookupMoeda(loc_cValor, loc_oCnt.txt_4c__cd_moeda, loc_oCnt.txt_4c__ds_moeda)
1155:     ENDPROC
1156: 
1157:     PROTECTED PROCEDURE ValidarMoedaDescricao()
1158:         LOCAL loc_oCnt, loc_cValor
1159:         loc_oCnt  = THIS.cnt_4c_Container1
1160:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c__ds_moeda.Value)
1161: 
1162:         IF EMPTY(loc_cValor)
1163:             loc_oCnt.txt_4c__cd_moeda.Value = ""
1164:             RETURN
1165:         ENDIF
1166: 
1167:         THIS.AbrirLookupMoeda(loc_cValor, loc_oCnt.txt_4c__cd_moeda, loc_oCnt.txt_4c__ds_moeda)
1168:     ENDPROC
1169: 
1170:     PROTECTED PROCEDURE AbrirLookupMoeda(par_cValor, par_oTxtCod, par_oTxtDesc)
1171:         LOCAL loc_cSQL, loc_nResultado, loc_lAchou
1172:         loc_lAchou = .F.
1173: 
1174:         IF USED("cursor_4c_SigPrEs1Moe")
1175:             USE IN cursor_4c_SigPrEs1Moe
1176:         ENDIF
1177: 
1178:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cValor) + ;
1179:                    " OR dmoes = " + EscaparSQL(par_cValor)
1180:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Moe")
1181: 
1182:         IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Moe") AND RECCOUNT("cursor_4c_SigPrEs1Moe") = 1
1183:             par_oTxtCod.Value  = ALLTRIM(cursor_4c_SigPrEs1Moe.cmoes)
1184:             par_oTxtDesc.Value = ALLTRIM(cursor_4c_SigPrEs1Moe.dmoes)
1185:             loc_lAchou = .T.
1186:         ENDIF
1187: 
1188:         IF USED("cursor_4c_SigPrEs1Moe")
1189:             USE IN cursor_4c_SigPrEs1Moe
1190:         ENDIF
1191: 
1192:         IF !loc_lAchou
1193:             IF !THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
1194:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValor, par_oTxtCod, par_oTxtDesc)
1195:                 par_oTxtCod.Value  = ""
1196:                 par_oTxtDesc.Value = ""
1197:             ENDIF
1198:         ENDIF
1199:     ENDPROC
1200: 
1201:     *--------------------------------------------------------------------------
1202:     * ValidarResponsavelCodigo / ValidarResponsavelDescricao - Responsavel
1203:     * (Vendedor - SigCdCli). Equivalente a get_resps.Valid / get_dresps.Valid:
1204:     * o Grupo eh o mesmo de todo o form (LocalParam.GrPadVens do legado ->
1205:     * this_cGrupoPadraoResponsavel, carregado em SigPrEs1BO.Init()).
1206:     *--------------------------------------------------------------------------
1207:     PROTECTED PROCEDURE ValidarResponsavelCodigo()
1208:         LOCAL loc_oCnt, loc_cGrupo
1209:         loc_oCnt   = THIS.cnt_4c_Container1
1210:         loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoPadraoResponsavel)
1211: 
1212:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__resps.Value))
1213:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
1214:                     loc_oCnt.txt_4c__resps, loc_oCnt.txt_4c__dresps)
1215:                 MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1216:                 loc_oCnt.txt_4c__resps.Value  = ""
1217:                 loc_oCnt.txt_4c__dresps.Value = ""
1218:             ENDIF
1219:         ELSE
1220:             loc_oCnt.txt_4c__dresps.Value = ""
1221:         ENDIF
1222:     ENDPROC
1223: 
1224:     PROTECTED PROCEDURE ValidarResponsavelDescricao()
1225:         LOCAL loc_oCnt, loc_cGrupo
1226:         loc_oCnt   = THIS.cnt_4c_Container1
1227:         loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoPadraoResponsavel)
1228: 
1229:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__dresps.Value))
1230:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", ALLTRIM(loc_oCnt.txt_4c__dresps.Value), ;
1231:                     loc_oCnt.txt_4c__resps, loc_oCnt.txt_4c__dresps)
1232:                 MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1233:                 loc_oCnt.txt_4c__dresps.Value = ""
1234:                 loc_oCnt.txt_4c__resps.Value  = ""
1235:             ENDIF
1236:         ELSE
1237:             loc_oCnt.txt_4c__resps.Value = ""
1238:         ENDIF
1239:     ENDPROC
1240: 
1241:     *--------------------------------------------------------------------------
1242:     * ValidarEmpresaCodigo / ValidarEmpresaDescricao - Empresa (SigCdEmp). O
1243:     * legado chama fAcessoEmpresa, que NAO foi portada (CLAUDE.md); substituto
1244:     * canonico documentado: match exato em Cemps/Razas e, na falta,
1245:     * AbrirLookupCanonico apontando SigCdEmp/Cemps/Razas.
1246:     *--------------------------------------------------------------------------
1247:     PROTECTED PROCEDURE ValidarEmpresaCodigo()
1248:         LOCAL loc_oCnt, loc_cValor
1249:         loc_oCnt  = THIS.cnt_4c_Container1
1250:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
1251: 
1252:         IF EMPTY(loc_cValor)
1253:             loc_oCnt.txt_4c__ds_empresa.Value = ""
1254:             RETURN
1255:         ENDIF
1256: 
1257:         THIS.AbrirLookupEmpresa(loc_cValor, loc_oCnt.txt_4c__cd_empresa, loc_oCnt.txt_4c__ds_empresa)
1258:     ENDPROC
1259: 
1260:     PROTECTED PROCEDURE ValidarEmpresaDescricao()
1261:         LOCAL loc_oCnt, loc_cValor
1262:         loc_oCnt  = THIS.cnt_4c_Container1
1263:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)
1264: 
1265:         IF EMPTY(loc_cValor)
1266:             loc_oCnt.txt_4c__cd_empresa.Value = ""
1267:             RETURN
1268:         ENDIF
1269: 
1270:         THIS.AbrirLookupEmpresa(loc_cValor, loc_oCnt.txt_4c__cd_empresa, loc_oCnt.txt_4c__ds_empresa)
1271:     ENDPROC
1272: 
1273:     PROTECTED PROCEDURE AbrirLookupEmpresa(par_cValor, par_oTxtCod, par_oTxtDesc)
1274:         LOCAL loc_cSQL, loc_nResultado, loc_lAchou
1275:         loc_lAchou = .F.
1276: 
1277:         IF USED("cursor_4c_SigPrEs1Emp")
1278:             USE IN cursor_4c_SigPrEs1Emp
1279:         ENDIF
1280: 
1281:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cValor) + ;
1282:                    " OR Razas = " + EscaparSQL(par_cValor)
1283:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Emp")
1284: 
1285:         IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Emp") AND RECCOUNT("cursor_4c_SigPrEs1Emp") = 1
1286:             par_oTxtCod.Value  = ALLTRIM(cursor_4c_SigPrEs1Emp.Cemps)
1287:             par_oTxtDesc.Value = ALLTRIM(cursor_4c_SigPrEs1Emp.Razas)
1288:             loc_lAchou = .T.
1289:         ENDIF
1290: 
1291:         IF USED("cursor_4c_SigPrEs1Emp")
1292:             USE IN cursor_4c_SigPrEs1Emp
1293:         ENDIF
1294: 
1295:         IF !loc_lAchou
1296:             IF !THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1297:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValor, par_oTxtCod, par_oTxtDesc)
1298:                 par_oTxtCod.Value  = ""
1299:                 par_oTxtDesc.Value = ""
1300:             ENDIF
1301:         ENDIF
1302:     ENDPROC
1303: 
1304:     *--------------------------------------------------------------------------
1305:     * ValidarOperacao - Movimentacao (SigCdOpe, tabela SINGLE-COLUMN: Dopes eh
1306:     * PK e descricao ao mesmo tempo - CLAUDE.md regra sobre SigCdOpe). O
1307:     * legado chama fAcessoMovmto, que NAO foi portada; substituto: match
1308:     * exato em Dopes e, na falta, AbrirLookupCanonico com Dopes nas duas
1309:     * colunas.
1310:     *--------------------------------------------------------------------------
1311:     PROTECTED PROCEDURE ValidarOperacao()
1312:         LOCAL loc_oCnt, loc_cValor, loc_lAchou
1313: 
1314:         loc_oCnt   = THIS.cnt_4c_Container1
1315:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
1316: 
1317:         IF EMPTY(loc_cValor)
1318:             RETURN
1319:         ENDIF
1320: 
1321:         loc_lAchou = .F.
1322:         IF USED("cursor_4c_SigPrEs1Ope")
1323:             USE IN cursor_4c_SigPrEs1Ope
1324:         ENDIF
1325: 
1326:         IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor), ;
1327:                 "cursor_4c_SigPrEs1Ope") > 0 AND USED("cursor_4c_SigPrEs1Ope") AND RECCOUNT("cursor_4c_SigPrEs1Ope") > 0
1328:             loc_lAchou = .T.
1329:         ENDIF
1330: 
1331:         IF USED("cursor_4c_SigPrEs1Ope")
1332:             USE IN cursor_4c_SigPrEs1Ope
1333:         ENDIF
1334: 
1335:         IF !loc_lAchou
1336:             IF !THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
1337:                     "Sele" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o", ;
1338:                     loc_cValor, loc_oCnt.txt_4c__nm_operacao, .NULL.)
1339:                 loc_oCnt.txt_4c__nm_operacao.Value = ""
1340:             ENDIF
1341:         ENDIF
1342:     ENDPROC
1343: 
1344:     *--------------------------------------------------------------------------
1345:     * ValidarCpf - Equivalente ao Get_cpf.Valid do legado: valida CPF/CNPJ
1346:     * (fValidarCPF/fValidarCNPJ do legado -> ValidarCPF/ValidarCNPJ portadas em
1347:     * utils\validators.prg), busca a conta dona daquele CPF/CGC em SigCdCli e
1348:     * reconfirma o acesso via fAcessoContas antes de preencher Conta/Dconta.
1349:     *--------------------------------------------------------------------------
1350:     PROTECTED PROCEDURE ValidarCpf()
1351:         LOCAL loc_oCnt, loc_cValor, loc_cDigitos, loc_cMascarado, loc_lValido
1352:         LOCAL loc_cSQL, loc_nResultado, loc_cIclis
1353: 
1354:         loc_oCnt   = THIS.cnt_4c_Container1
1355:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
1356: 
1357:         IF EMPTY(loc_cValor)
1358:             loc_oCnt.txt_4c_Dconta.Value = ""
1359:             RETURN
1360:         ENDIF
1361: 
1362:         loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cValor, ".", ""), "-", ""), "/", "")
1363: 
1364:         IF LEN(ALLTRIM(loc_cDigitos)) = 14
1365:             loc_cMascarado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
1366:             loc_lValido    = ValidarCNPJ(loc_cDigitos)
1367:         ELSE
1368:             loc_cMascarado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
1369:             loc_lValido    = ValidarCPF(loc_cDigitos)
1370:         ENDIF
1371: 
1372:         IF !loc_lValido
1373:             MsgAviso("CPF / CGC Incorreto !!!", "Aten" + CHR(231) + CHR(227) + "o")
1374:             loc_oCnt.txt_4c_Cpf.SetFocus()
1375:             RETURN
1376:         ENDIF
1377: 
1378:         IF USED("cursor_4c_SigPrEs1Cli")
1379:             USE IN cursor_4c_SigPrEs1Cli
1380:         ENDIF
1381: 
1382:         loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli WHERE Cpfs = " + ;
1383:             EscaparSQL(PADR(loc_cMascarado, 20))
1384:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Cli")
1385: 
1386:         IF loc_nResultado <= 0 OR !USED("cursor_4c_SigPrEs1Cli") OR RECCOUNT("cursor_4c_SigPrEs1Cli") = 0
1387:             MsgAviso("CPF / CGC n" + CHR(227) + "o encontrado !!!", "Aten" + CHR(231) + CHR(227) + "o")
1388:             IF USED("cursor_4c_SigPrEs1Cli")
1389:                 USE IN cursor_4c_SigPrEs1Cli
1390:             ENDIF
1391:             loc_oCnt.txt_4c_Cpf.SetFocus()
1392:             RETURN
1393:         ENDIF
1394: 
1395:         loc_cIclis = ALLTRIM(cursor_4c_SigPrEs1Cli.IClis)
1396: 
1397:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cIclis, loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
1398:             MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
1399:             loc_oCnt.txt_4c_Conta.Value  = ""
1400:             loc_oCnt.txt_4c_Dconta.Value = ""
1401:             loc_oCnt.txt_4c_Cpf.Value    = ""
1402:         ELSE
1403:             loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_SigPrEs1Cli.IClis)
1404:             loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_SigPrEs1Cli.RClis)
1405:             loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(TratarNulo(cursor_4c_SigPrEs1Cli.Cpfs, ""))
1406:         ENDIF
1407: 
1408:         IF USED("cursor_4c_SigPrEs1Cli")
1409:             USE IN cursor_4c_SigPrEs1Cli
1410:         ENDIF
1411:     ENDPROC
1412: 
1413:     *--------------------------------------------------------------------------
1414:     * ConfigurarBotoesAcao - Cria obj_4c_Sair (commandgroup "sair" do legado -
1415:     * SECAO 2: Top=-2 Left=665 Width=161 Height=85, BackStyle=0,
1416:     * BorderStyle=0, Themes=.F.) com os 2 botoes do dump legado
1417:     * (Command1="consulta"/Command2="sair"), equivalente aos botoes CRUD dos
1418:     * forms de cadastro. Buttons(N) EXATOS do dump (Top/Left/Height/Width/
1419:     * FontName="Comic Sans MS"/ForeColor/BackColor/Themes=.F.) - NUNCA
1420:     * inventar posicao (CLAUDE.md regra #33/framework_frmcadastro_layout.md).
1421:     *--------------------------------------------------------------------------
1422:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1423:         THIS.AddObject("obj_4c_Sair", "CommandGroup")
1424:         WITH THIS.obj_4c_Sair
1425:             .ButtonCount  = 2
1426:             .Top          = -2
1427:             .Left         = 665
1428:             .Width        = 161
1429:             .Height       = 85
1430:             .BackStyle    = 0
1431:             .BorderStyle  = 0
1432:             .Themes       = .F.
1433: 
1434:             WITH .Buttons(1)
1435:                 .Top        = 5
1436:                 .Left       = 5
1437:                 .Height     = 75
1438:                 .Width      = 75
1439:                 .FontBold   = .T.
1440:                 .FontItalic = .T.
1441:                 .FontName   = "Comic Sans MS"
1442:                 .FontSize   = 8
1443:                 .WordWrap   = .T.
1444:                 .Picture    = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
1445:                 .Caption    = "\<Consultar"
1446:                 .ForeColor  = RGB(90, 90, 90)
1447:                 .BackColor  = RGB(255, 255, 255)
1448:                 .Themes     = .F.
1449:             ENDWITH
1450: 
1451:             WITH .Buttons(2)
1452:                 .Top        = 5
1453:                 .Left       = 81
1454:                 .Height     = 75
1455:                 .Width      = 75
1456:                 .FontBold   = .T.
1457:                 .FontItalic = .T.
1458:                 .FontName   = "Comic Sans MS"
1459:                 .FontSize   = 8
1460:                 .WordWrap   = .T.
1461:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1462:                 .Cancel     = .T.

*-- Linhas 1471 a 1769:
1471:     ENDPROC
1472: 
1473:     *--------------------------------------------------------------------------
1474:     * BtnSairClick - Dispatcher do CommandGroup obj_4c_Sair (BINDEVENT em
1475:     * InicializarForm). Value=1 -> Consultar (consulta.Click do legado);
1476:     * Value=2 -> Encerrar (sair.Click do legado).
1477:     *--------------------------------------------------------------------------
1478:     PROCEDURE BtnSairClick()
1479:         DO CASE
1480:         CASE THIS.obj_4c_Sair.Value = 1
1481:             THIS.BtnConsultarClick()
1482:         CASE THIS.obj_4c_Sair.Value = 2
1483:             THIS.BtnEncerrarClick()
1484:         ENDCASE
1485:     ENDPROC
1486: 
1487:     *--------------------------------------------------------------------------
1488:     * BtnConsultarClick - Equivalente ao PROCEDURE consulta.Click do legado.
1489:     * As 3 validacoes de UI (Empresa/Operacao/Periodo) e a ordem em que
1490:     * disparam SetFocus sao transcritas literalmente - a mesma checagem
1491:     * tambem existe em SigPrEs1BO.ValidarFiltros() como rede de seguranca,
1492:     * mas so o Form tem a referencia de controle para SetFocus (regra #17 do
1493:     * CLAUDE.md - transcrever a formula/fluxo do legado, guards inclusos).
1494:     *--------------------------------------------------------------------------
1495:     PROCEDURE BtnConsultarClick()
1496:         LOCAL loc_oBO, loc_oCnt, loc_lSucesso
1497: 
1498:         loc_oBO  = THIS.this_oBusinessObject
1499:         loc_oCnt = THIS.cnt_4c_Container1
1500: 
1501:         IF EMPTY(ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value))
1502:             MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1503:             loc_oCnt.txt_4c__cd_empresa.SetFocus()
1504:             RETURN
1505:         ENDIF
1506: 
1507:         IF EMPTY(ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value))
1508:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1509:             loc_oCnt.txt_4c__nm_operacao.SetFocus()
1510:             RETURN
1511:         ENDIF
1512: 
1513:         IF loc_oCnt.txt_4c__dt_final.Value < loc_oCnt.txt_4c__dt_inicial.Value
1514:             MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1515:             loc_oCnt.txt_4c__dt_inicial.SetFocus()
1516:             RETURN
1517:         ENDIF
1518: 
1519:         THIS.FormParaBO()
1520: 
1521:         *-- ALCANCE do "ThisForm.Enabled" transcrito do legado (linhas 1697-1716
1522:         *-- do dump): o SqlExecute roda ANTES de "ThisForm.Enabled = .f." e, em
1523:         *-- caso de falha, exibe 'Favor Reinicializar o Processo!!!' e faz
1524:         *-- "Return 0" SEM ter desabilitado o form. Manter essa fronteira nao eh
1525:         *-- detalhe: este form eh MODAL (WindowType = 1) e nao tem barra de
1526:         *-- titulo (TitleBar = 0 / ControlBox = .F.), entao form desabilitado
1527:         *-- deixa o usuario SEM SAIDA - nem o Encerrar responde. Cobrir a
1528:         *-- consulta SQL com o Enabled = .F. alargaria o alcance do legado e
1529:         *-- trancaria a tela em todo caminho que nao chegasse ao Enabled = .T.
1530:         loc_lSucesso = loc_oBO.BuscarMovimentacao()
1531: 
1532:         IF !loc_lSucesso
1533:             *-- Legado: Messagebox('Favor Reinicializar o Processo!!!', 16,
1534:             *-- 'Falha na Conexao (csTemporario)'). O texto da mensagem ja vem
1535:             *-- em this_cMensagemErro (SigPrEs1BO.BuscarMovimentacao); aqui vai
1536:             *-- o titulo literal do legado.
1537:             MsgErro(loc_oBO.this_cMensagemErro, ;
1538:                 "Falha na Conex" + CHR(227) + "o (csTemporario)")
1539:             RETURN
1540:         ENDIF
1541: 
1542:         *-- Legado: ThisForm.Enabled = .f. / If (Reccount() > 0) Do Form
1543:         *-- sigpres2 Else Messagebox('Nenhum Registro Selecionado!!!') /
1544:         *-- ThisForm.Enabled = .t. - o aviso fica DENTRO do trecho desabilitado,
1545:         *-- exatamente como no legado.
1546:         THIS.Enabled = .F.
1547: 
1548:         IF loc_oBO.this_nTotalRegistros > 0
1549:             THIS.AbrirTelaMovimentacao(ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value))
1550:         ELSE
1551:             MsgAviso("Nenhum Registro Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1552:         ENDIF
1553: 
1554:         THIS.Enabled = .T.
1555:     ENDPROC
1556: 
1557:     *--------------------------------------------------------------------------
1558:     * FormParaBO - Copia os campos de cnt_4c_Container1 para as
1559:     * propriedades this_* do BO, equivalente as variaveis locais lnNrP/lcNmO/
1560:     * lcEst/lcCon/lnPen/lcVen/lcEmp/lcSta/lnEmpD/pDtI/pDtF/pNOp/pNum do
1561:     * consulta.Click legado. Campos de cnt_4c_Container1 sao criados nas
1562:     * Fases 5-6 (mesmos nomes de tasks\task606\mapeamento.json).
1563:     *--------------------------------------------------------------------------
1564:     PROTECTED PROCEDURE FormParaBO()
1565:         LOCAL loc_oBO, loc_oCnt
1566: 
1567:         loc_oBO  = THIS.this_oBusinessObject
1568:         loc_oCnt = THIS.cnt_4c_Container1
1569: 
1570:         loc_oBO.this_nOpcaoPeriodo    = loc_oCnt.obj_4c_Opt_nr_periodo.Value
1571:         loc_oBO.this_cNomeOperacao    = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
1572:         loc_oBO.this_cGrupo           = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1573:         loc_oBO.this_cConta           = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1574:         loc_oBO.this_nOpcaoPendente   = loc_oCnt.obj_4c_Opt_Pendente.Value
1575:         loc_oBO.this_cResponsavel     = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
1576:         loc_oBO.this_cCodigoEmpresa   = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
1577:         loc_oBO.this_cStatus          = ALLTRIM(loc_oCnt.txt_4c_PStatus.Value)
1578:         loc_oBO.this_lEmpresaDestino  = (loc_oCnt.chk_4c_ChkEmpD.Value = 1)
1579:         loc_oBO.this_dDataInicial     = loc_oCnt.txt_4c__dt_inicial.Value
1580:         loc_oBO.this_dDataFinal       = loc_oCnt.txt_4c__dt_final.Value
1581:         loc_oBO.this_nOperacao        = loc_oCnt.txt_4c_Op.Value
1582:         loc_oBO.this_nNumero          = loc_oCnt.txt_4c_Numero.Value
1583:         loc_oBO.this_cDescricaoGrupo  = ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value)
1584:         loc_oBO.this_cDescricaoConta  = ALLTRIM(loc_oCnt.txt_4c_Dconta.Value)
1585:         loc_oBO.this_cCpfCnpj         = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
1586:         loc_oBO.this_cDescricaoEmpresa = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)
1587:         loc_oBO.this_cCodigoMoeda     = ALLTRIM(loc_oCnt.txt_4c__cd_moeda.Value)
1588:         loc_oBO.this_cDescricaoMoeda  = ALLTRIM(loc_oCnt.txt_4c__ds_moeda.Value)
1589:         loc_oBO.this_cDescricaoResponsavel = ALLTRIM(loc_oCnt.txt_4c__dresps.Value)
1590:         loc_oBO.this_nOpcaoCotacao    = loc_oCnt.obj_4c_OptCotacao.Value
1591:         loc_oBO.this_nOpcaoImpressao  = loc_oCnt.obj_4c_Opt_impressao.Value
1592:     ENDPROC
1593: 
1594:     *--------------------------------------------------------------------------
1595:     * BOParaForm - Caminho INVERSO do FormParaBO: joga o estado inicial do BO
1596:     * nos controles de cnt_4c_Container1. Equivalente LITERAL ao bloco
1597:     * "With .Container1 ... EndWith" do PROCEDURE Init legado, que roda uma
1598:     * unica vez na abertura da tela:
1599:     *
1600:     *     .get_nm_operacao.Value = ''         .get_dConta.Value     = Space(30)
1601:     *     .get_dt_inicial.Value  = date()     .get_cd_moeda.Value   = ' '
1602:     *     .get_dt_final.Value    = date()     .get_resps.Value      = ''
1603:     *     .get_Grupo.Value       = Space(10)  .get_dresps.Value     = ''
1604:     *     .get_dgrupo.Value      = Space(30)  .get_cd_empresa.Value = _empr
1605:     *     .get_Conta.Value       = Space(10)
1606:     *
1607:     * O legado NAO toca em get_ds_empresa, getPStatus, Get_Numero, Get_op nem
1608:     * Get_cpf neste bloco - eles nascem vazios e assim continuam aqui (PILAR 1:
1609:     * a Empresa abre com o CODIGO preenchido e a razao social em branco ate o
1610:     * usuario acionar o lookup, exatamente como na tela legada).
1611:     *
1612:     * _EMPR eh a PUBLIC do Framework Fortyus e NAO deve ser usada (CLAUDE.md,
1613:     * secao Global Variables): a fonte canonica eh go_4c_Sistema.cCodEmpresa,
1614:     * que SigPrEs1BO.Init() ja leu para this_cCodigoEmpresa. Ler do BO em vez
1615:     * da global deixa o Form com uma fonte unica.
1616:     *
1617:     * Os Space(10)/Space(30) do legado viram "" porque os TextBox migrados tem
1618:     * MaxLength vindo da largura da coluna no schema (CLAUDE.md regra #19) e
1619:     * qualquer EMPTY()/ALLTRIM() das validacoes trata os dois casos igual: o que o
1620:     * legado quis dizer ali eh "campo em branco".
1621:     *--------------------------------------------------------------------------
1622:     PROTECTED PROCEDURE BOParaForm()
1623:         LOCAL loc_oBO, loc_oCnt
1624: 
1625:         loc_oBO  = THIS.this_oBusinessObject
1626:         loc_oCnt = THIS.cnt_4c_Container1
1627: 
1628:         loc_oCnt.txt_4c__nm_operacao.Value = loc_oBO.this_cNomeOperacao
1629:         loc_oCnt.txt_4c__dt_inicial.Value  = ConverterParaData(loc_oBO.this_dDataInicial)
1630:         loc_oCnt.txt_4c__dt_final.Value    = ConverterParaData(loc_oBO.this_dDataFinal)
1631:         loc_oCnt.txt_4c_Grupo.Value        = loc_oBO.this_cGrupo
1632:         loc_oCnt.txt_4c__Dgrupo.Value      = loc_oBO.this_cDescricaoGrupo
1633:         loc_oCnt.txt_4c_Conta.Value        = loc_oBO.this_cConta
1634:         loc_oCnt.txt_4c_Dconta.Value       = loc_oBO.this_cDescricaoConta
1635:         loc_oCnt.txt_4c__cd_moeda.Value    = loc_oBO.this_cCodigoMoeda
1636:         loc_oCnt.txt_4c__resps.Value       = loc_oBO.this_cResponsavel
1637:         loc_oCnt.txt_4c__dresps.Value      = loc_oBO.this_cDescricaoResponsavel
1638: 
1639:         *-- Legado: .get_cd_empresa.Value = _empr. Sem esta linha a tela abre
1640:         *-- com a Empresa VAZIA e o primeiro clique em Consultar cai direto na
1641:         *-- validacao "Empresa Invalida!!!" - o usuario teria de digitar a
1642:         *-- empresa em toda abertura, o que o legado nunca exigiu.
1643:         loc_oCnt.txt_4c__cd_empresa.Value = loc_oBO.this_cCodigoEmpresa
1644:     ENDPROC
1645: 
1646:     *--------------------------------------------------------------------------
1647:     * AbrirTelaMovimentacao - Equivalente ao trecho final do consulta.Click
1648:     * legado: "Do Form sigpres2 With lcNmO, ThisForm.DataSessionId, ThisForm".
1649:     *
1650:     * Formsigpres2BO.CarregarDoCursorTemporario() e Formsigpres2.CarregarLista()
1651:     * (grd_4c_Lista.RecordSource) leem o cursor GLOBAL "csTemporario" pelo
1652:     * NOME LITERAL - o mesmo nome que o legado usava (SqlExecute(lcQuery,
1653:     * 'csTemporario')). Por isso o resultado de BuscarMovimentacao()
1654:     * (cursor_4c_Movimentacao, nome canonico do BO) e copiado para um cursor
1655:     * "csTemporario" antes do CREATEOBJECT - renomear quebraria o contrato
1656:     * com a tela filha ja migrada (regra do wrapper: reproduzir o CONTRATO,
1657:     * nao so o nome).
1658:     *--------------------------------------------------------------------------
1659:     PROTECTED PROCEDURE AbrirTelaMovimentacao(par_cNomeOperacao)
1660:         LOCAL loc_oForm, loc_oErro, loc_lFalhou
1661: 
1662:         loc_oForm   = .NULL.
1663:         loc_lFalhou = .F.
1664: 
1665:         *-- O TRY cobre SO a preparacao do cursor e o CREATEOBJECT - o Show()
1666:         *-- fica FORA (CLAUDE.md regra #29). Formsigpres2 tem WindowType = 1,
1667:         *-- entao o Show() BLOQUEIA e a tela filha inteira (cada Valid, cada
1668:         *-- Click) viveria dentro deste bloco; como TRY/CATCH tem precedencia
1669:         *-- sobre ON ERROR em qualquer ponto da pilha, um erro de runtime la
1670:         *-- dentro saltaria para o CATCH, abandonaria o TRY, derrubaria a
1671:         *-- referencia LOCAL loc_oForm e DESTRUIRIA a tela filha no meio do uso
1672:         *-- (sintoma: "a tela fecha sozinha", Destroy sem QueryUnload).
1673:         TRY
1674:             IF USED("csTemporario")
1675:                 USE IN csTemporario
1676:             ENDIF
1677: 
1678:             SELECT * FROM cursor_4c_Movimentacao INTO CURSOR csTemporario READWRITE
1679: 
1680:             *-- Legado (dump linha 1704): "Index On EmpDopNums Tag EmpDopNums"
1681:             *-- roda no PROPRIO csTemporario, logo apos o SqlExecute. O indice
1682:             *-- que SigPrEs1BO.BuscarMovimentacao cria em cursor_4c_Movimentacao
1683:             *-- NAO atravessa o SELECT ... INTO CURSOR acima - um cursor novo
1684:             *-- nasce sem tag nenhuma. Sem refazer aqui, a tela filha recebe o
1685:             *-- csTemporario SEM a tag e um SEEK nela falharia devolvendo ZERO
1686:             *-- linhas, sem erro e sem log (CLAUDE.md regra #42).
1687:             SELECT csTemporario
1688:             INDEX ON EmpDopNums TAG EmpDopNums
1689: 
1690:             GO TOP IN csTemporario
1691: 
1692:             loc_oForm = CREATEOBJECT("Formsigpres2", par_cNomeOperacao, THIS.DataSessionId, THIS)
1693:         CATCH TO loc_oErro
1694:             loc_oForm   = .NULL.
1695:             loc_lFalhou = .T.
1696:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1697:                 "Erro ao abrir Movimenta" + CHR(231) + CHR(227) + "o")
1698:         ENDTRY
1699: 
1700:         IF VARTYPE(loc_oForm) = "O"
1701:             *-- Legado: "Do Form sigpres2 With lcNmO, ThisForm.DataSessionId,
1702:             *-- ThisForm". Formsigpres2 nao declara DataSession, logo usa a
1703:             *-- sessao CORRENTE (= a sessao privada 2 deste form), e por isso
1704:             *-- ve o csTemporario criado acima - equivalente ao legado passar o
1705:             *-- DataSessionId do pai.
1706:             loc_oForm.Show()
1707:         ELSE
1708:             *-- CREATEOBJECT tambem devolve .F. (sem excecao) quando o Init da
1709:             *-- tela filha retorna .F.; nesse caminho o CATCH nao roda e a
1710:             *-- falha precisa aparecer.
1711:             IF !loc_lFalhou
1712:                 MsgErro("Erro ao abrir tela de movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
1713:             ENDIF
1714:         ENDIF
1715: 
1716:         IF USED("csTemporario")
1717:             USE IN csTemporario
1718:         ENDIF
1719:     ENDPROC
1720: 
1721:     *--------------------------------------------------------------------------
1722:     * BtnEncerrarClick - Equivalente ao PROCEDURE sair.Click do legado
1723:     * ("ThisForm.Release").
1724:     *--------------------------------------------------------------------------
1725:     PROCEDURE BtnEncerrarClick()
1726:         THIS.Release()
1727:     ENDPROC
1728: 
1729:     *--------------------------------------------------------------------------
1730:     * TornarControlesVisiveis - AddObject() cria controles com Visible=.F.
1731:     * por padrao (CLAUDE.md); percorre recursivamente o container recebido
1732:     * tornando tudo visivel, inclusive containers aninhados. CommandGroup
1733:     * (obj_4c_Sair) nao tem ControlCount/Controls - so Visible eh setado
1734:     * nele, os Buttons() ficam visiveis automaticamente com o grupo.
1735:     *--------------------------------------------------------------------------
1736:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1737:         LOCAL loc_nI, loc_oCtrl
1738: 
1739:         IF VARTYPE(par_oContainer) != "O" OR !PEMSTATUS(par_oContainer, "ControlCount", 5)
1740:             RETURN
1741:         ENDIF
1742: 
1743:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1744:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1745: 
1746:             IF VARTYPE(loc_oCtrl) = "O"
1747:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1748:                     loc_oCtrl.Visible = .T.
1749:                 ENDIF
1750: 
1751:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1752:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1753:                 ENDIF
1754:             ENDIF
1755:         ENDFOR
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * Destroy - this_oBusinessObject = .NULL. (heranca FormBase.Destroy())
1760:     * libera a ultima referencia ao SigPrEs1BO, disparando SigPrEs1BO.Destroy()
1761:     * automaticamente (fecha cursor_4c_Movimentacao). Equivalente ao
1762:     * "ThisForm.poDataMgr.Release" do PROCEDURE Release legado - aqui nao ha
1763:     * conexao privada por form para liberar (gnConnHandle eh global).
1764:     *--------------------------------------------------------------------------
1765:     PROCEDURE Destroy()
1766:         DODEFAULT()
1767:     ENDPROC
1768: 
1769: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*------------------------------------------------------------------------------
* SigPrEs1BO.prg - Business Object para Posicao Por Movimentacao
* Form legado: SIGPRES1 (form OPERACIONAL - filtro de relatorio, sem tabela CRUD)
* Herdado de: BusinessBase
*
* O legado nao grava em tabela alguma: monta filtros e consulta SigMvCab +
* SigCdOpe para alimentar a tela filha (sigpres2). Conferido no dump
* tasks\task606\SigPrEs1_form_codigo_fonte.txt: nenhum TABLEUPDATE(), nenhum
* .AddCursor(), e o unico comando de escrita eh
*   Update csTemporario Set PrazoEnts = Iif(IsNull(PrazoEnts), Ctod(''), ...)
* cujo alvo csTemporario eh o CURSOR LOCAL criado por
* poDataMgr.SqlExecute(lcQuery, 'csTemporario') - ou seja, ajuste em memoria
* que nunca volta para o banco.
*
* Por isso este BO deixa Inserir(), Atualizar() e ExecutarExclusao() HERDADOS
* de BusinessBase: a base ja recusa a operacao e reporta pelo ExibirFalha() do
* Salvar(), que eh o comportamento correto aqui. Sobrescrever esses metodos
* exigiria INVENTAR um INSERT/UPDATE, o que a regra #22 do CLAUDE.md proibe
* (a lista de colunas vem do schema, nunca de adivinhacao).
*
* O metodo de negocio real eh BuscarMovimentacao(), equivalente ao
* consulta.Click do SCX original. CarregarDoCursor() le a linha corrente do
* cursor de resultado e ObterChavePrimaria() devolve a chave EmpDopNums dessa
* linha (usada pela auditoria de BusinessBase e pelo handoff para a tela
* filha).
*------------------------------------------------------------------------------
DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Configuracao da entidade (form OPERACIONAL - nao ha tabela unica/CRUD)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = ""

    *-- Filtro: Movimentacao / Periodo
    this_cNomeOperacao = ""
    this_dDataInicial  = {}
    this_dDataFinal    = {}
    this_nNumero       = 0
    this_nOperacao     = 0
    this_cStatus       = ""

    *-- Filtro: Grupo / Conta
    this_cGrupo            = ""
    this_cDescricaoGrupo   = ""
    this_cConta            = ""
    this_cDescricaoConta   = ""
    this_cCpfCnpj          = ""

    *-- Filtro: Moeda
    this_cCodigoMoeda    = ""
    this_cDescricaoMoeda = ""

    *-- Filtro: Responsavel
    this_cResponsavel          = ""
    this_cDescricaoResponsavel = ""

    *-- Filtro: Empresa
    this_cCodigoEmpresa    = ""
    this_cDescricaoEmpresa = ""
    this_lEmpresaDestino   = .F.

    *-- Opcoes (OptionGroups do filtro) - valores DEFAULT identicos ao SCX legado
    this_nOpcaoPeriodo    = 1
    this_nOpcaoPendente   = 3
    this_nOpcaoImpressao  = 1
    this_nOpcaoCotacao    = 1

    *-- Parametros do sistema (equivalente ao cursor LocalParam do legado)
    this_cGrupoPadraoResponsavel = ""

    *-- Resultado da consulta (equivalente ao cursor csTemporario do legado)
    this_cCursorResultado = "cursor_4c_Movimentacao"
    this_nTotalRegistros  = 0

    *-- Linha corrente do cursor de resultado, lida por CarregarDoCursor().
    *-- Sao EXATAMENTE as colunas de SigMvCab que o legado nomeia no lcWhere /
    *-- lcQuery do consulta.Click, mais a chave empdopnums usada no Index On -
    *-- nenhuma coluna a mais. Conferidas uma a uma em docs\schema.sql:
    *--   emps char(3)        empds char(3)       dopes char(20)
    *--   datas datetime      prazoents datetime  grupoos char(10)
    *--   grupods char(10)    contaos char(10)    contads char(10)
    *--   nops numeric(10,0)  numes numeric(6,0)  vends char(10)
    *--   chksubn bit         pstatus char(1)     empdopnums char(29)
    this_cRegEmpresa       = ""
    this_cRegEmpresaDest   = ""
    this_cRegOperacao      = ""
    *-- {/:} eh DATETIME vazio (VARTYPE "T"): as colunas datas/prazoents sao
    *-- datetime, e manter o tipo estavel antes e depois da carga evita o erro
    *-- 11 de TTOD() com DATE (regra #16 do CLAUDE.md).
    this_dRegData          = {/:}
    this_dRegPrazoEntrega  = {/:}
    this_cRegGrupoOrigem   = ""
    this_cRegGrupoDestino  = ""
    this_cRegContaOrigem   = ""
    this_cRegContaDestino  = ""
    this_nRegNumeroOp      = 0
    this_nRegNumero        = 0
    this_cRegVendedor      = ""
    this_lRegBaixada       = .F.
    this_cRegStatus        = ""
    this_cRegChave         = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = ""

            THIS.this_cNomeOperacao = ""
            THIS.this_dDataInicial  = DATE()
            THIS.this_dDataFinal    = DATE()
            THIS.this_nNumero       = 0
            THIS.this_nOperacao     = 0
            THIS.this_cStatus       = ""

            THIS.this_cGrupo          = ""
            THIS.this_cDescricaoGrupo = ""
            THIS.this_cConta          = ""
            THIS.this_cDescricaoConta = ""
            THIS.this_cCpfCnpj        = ""

            THIS.this_cCodigoMoeda    = ""
            THIS.this_cDescricaoMoeda = ""

            THIS.this_cResponsavel          = ""
            THIS.this_cDescricaoResponsavel = ""

            *-- Legado: .get_cd_empresa.Value = _empr
            *-- _EMPR eh variavel do Framework antigo; a fonte canonica no
            *-- sistema novo eh go_4c_Sistema.cCodEmpresa (config.prg).
            THIS.this_cCodigoEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O"
                THIS.this_cCodigoEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
            THIS.this_cDescricaoEmpresa = ""
            THIS.this_lEmpresaDestino   = .F.

            THIS.this_nOpcaoPeriodo   = 1
            THIS.this_nOpcaoPendente  = 3
            THIS.this_nOpcaoImpressao = 1
            THIS.this_nOpcaoCotacao   = 1

            THIS.this_cGrupoPadraoResponsavel = ""
            THIS.this_cCursorResultado        = "cursor_4c_Movimentacao"
            THIS.this_nTotalRegistros         = 0

            THIS.LimparLinhaCorrente()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            *-- Equivalente ao SqlExecute("Select GrPadVens From SigCdPam...", "LocalParam")
            *-- do Init legado - usado pela validacao de acesso do Responsavel.
            THIS.CarregarParametrosSistema()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Equivalente ao cursor LocalParam populado no Init do form legado:
    *   Select GrPadVens From SigCdPam Where Not cIdChaves = fUniqueIds()
    * (a comparacao com um id recem-gerado nunca casa, entao devolve a linha
    * unica de parametros da empresa - transcrito literalmente do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT GrPadVens FROM SigCdPam WHERE NOT cidchaves = " + ;
                    EscaparSQL(fUniqueIds())

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Pam")

                IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Pam")
                    SELECT cursor_4c_SigPrEs1Pam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupoPadraoResponsavel = ALLTRIM(TratarNulo(GrPadVens, ""))
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Reproduz as validacoes do consulta.Click do legado antes
    * de disparar a consulta: Empresa, Operacao (Movimentacao) e Periodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCodigoEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarWhereConsulta - Monta o trecho de filtros da consulta, transcrito
    * literalmente da variavel lcWhere do metodo consulta.Click do legado.
    * Cada filtro so entra na clausula quando o campo correspondente esta
    * preenchido, exatamente como no SCX original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarWhereConsulta()
        LOCAL loc_cWhere

        loc_cWhere = ""

        IF !EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNomeOperacao)) + " And "
        ENDIF

        IF THIS.this_nOpcaoPeriodo = 1
            loc_cWhere = loc_cWhere + "a.Datas BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ELSE
            loc_cWhere = loc_cWhere + "a.PrazoEnts BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ;
                " Or a.GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ") And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cConta))
            loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ;
                " Or a.ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ") And "
        ENDIF

        IF THIS.this_nOperacao != 0
            loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(THIS.this_nOperacao, 0) + " And "
        ENDIF

        IF THIS.this_nNumero != 0
            loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(THIS.this_nNumero, 0) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cResponsavel))
            loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(ALLTRIM(THIS.this_cResponsavel)) + " And "
        ENDIF

        DO CASE
            CASE THIS.this_nOpcaoPendente = 1
                loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
            CASE THIS.this_nOpcaoPendente = 2
                loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
        ENDCASE

        IF !EMPTY(ALLTRIM(THIS.this_cStatus))
            loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(ALLTRIM(THIS.this_cStatus)) + " And "
        ENDIF

        RETURN loc_cWhere
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQLConsulta - Monta a consulta completa, transcrita da variavel
    * lcQuery do metodo consulta.Click do legado (join SigMvCab + SigCdOpe).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQLConsulta()
        LOCAL loc_cWhereEmpresa

        loc_cWhereEmpresa = "(a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        IF THIS.this_lEmpresaDestino
            loc_cWhereEmpresa = loc_cWhereEmpresa + " Or a.Empds = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        ENDIF
        loc_cWhereEmpresa = loc_cWhereEmpresa + ") And "

        RETURN "SELECT a.* FROM SigMvCab a, SigCdOpe b WHERE " + ;
            loc_cWhereEmpresa + THIS.MontarWhereConsulta() + "a.Dopes = b.Dopes"
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMovimentacao - Executa a consulta de posicao por movimentacao.
    * Equivalente ao metodo consulta.Click do legado (sem a parte de UI:
    * SetFocus/MessageBox/Do Form sigpres2 ficam por conta do Form).
    * Popula THIS.this_cCursorResultado (cursor_4c_Movimentacao) e
    * THIS.this_nTotalRegistros. Retorna .F. so quando a consulta falha -
    * zero registros encontrados NAO eh erro, eh resultado valido.
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalRegistros = 0
        loc_lSucesso = .F.

        IF !THIS.ValidarFiltros()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = THIS.MontarSQLConsulta()

            IF USED("cursor_4c_SigPrEs1Tmp")
                USE IN cursor_4c_SigPrEs1Tmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Tmp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED("cursor_4c_Movimentacao")
                    USE IN cursor_4c_Movimentacao
                ENDIF

                SELECT * FROM cursor_4c_SigPrEs1Tmp INTO CURSOR cursor_4c_Movimentacao READWRITE

                IF USED("cursor_4c_SigPrEs1Tmp")
                    USE IN cursor_4c_SigPrEs1Tmp
                ENDIF

                SELECT cursor_4c_Movimentacao
                INDEX ON EmpDopNums TAG EmpDopNums

                REPLACE ALL PrazoEnts WITH CTOD("") FOR ISNULL(PrazoEnts)

                *-- Legado: Go Top In csTemporario, e so depois If (Reccount() > 0)
                GO TOP

                THIS.this_nTotalRegistros = RECCOUNT("cursor_4c_Movimentacao")

                *-- Deixa a 1a linha ja carregada nas propriedades this_*Reg*
                *-- (e limpa quando a consulta nao trouxe nada, para nao herdar
                *-- a linha da consulta anterior).
                IF THIS.this_nTotalRegistros > 0
                    THIS.CarregarDoCursor("cursor_4c_Movimentacao")
                ELSE
                    THIS.LimparLinhaCorrente()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparLinhaCorrente - zera as propriedades da linha corrente do cursor
    * de resultado. Chamado no Init e sempre que a consulta devolve zero linhas,
    * para que uma consulta nova nunca herde a linha da consulta anterior.
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaCorrente()
        THIS.this_cRegEmpresa      = ""
        THIS.this_cRegEmpresaDest  = ""
        THIS.this_cRegOperacao     = ""
        THIS.this_dRegData         = {/:}
        THIS.this_dRegPrazoEntrega = {/:}
        THIS.this_cRegGrupoOrigem  = ""
        THIS.this_cRegGrupoDestino = ""
        THIS.this_cRegContaOrigem  = ""
        THIS.this_cRegContaDestino = ""
        THIS.this_nRegNumeroOp     = 0
        THIS.this_nRegNumero       = 0
        THIS.this_cRegVendedor     = ""
        THIS.this_lRegBaixada      = .F.
        THIS.this_cRegStatus       = ""
        THIS.this_cRegChave        = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCampoCursor - le um campo do cursor corrente pelo NOME, devolvendo o
    * valor padrao quando o campo nao existe ou vem NULL.
    *
    * EVALUATE eh o caminho CERTO para LEITURA por nome (regra #15); e a
    * existencia do campo se testa com TYPE(alias + "." + campo), NUNCA com
    * PEMSTATUS - PEMSTATUS exige objeto no 1o argumento e dispara erro 11 com
    * alias de cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCampoCursor(par_cAlias, par_cCampo, par_uPadrao)
        LOCAL loc_uValor

        loc_uValor = par_uPadrao

        IF TYPE(par_cAlias + "." + par_cCampo) != "U"
            loc_uValor = TratarNulo(EVALUATE(par_cAlias + "." + par_cCampo), par_uPadrao)
        ENDIF

        RETURN loc_uValor
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave composta EmpDopNums de SigMvCab.
    *
    * Legado (mesma montagem usada em todo o sistema Fortyus):
    *   lcEmpDopNums = <cursor>.Emps + <cursor>.Dopes + Str(<cursor>.Numes, 6)
    *
    * A chave eh POSICIONAL: o padding faz parte dela. Por isso as partes vao
    * com PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - a
    * conferencia eh a largura do destino:
    *   emps char(3) + dopes char(20) + Str(numes, 6) = 29 = empdopnums char(29)
    * Com ALLTRIM nas partes a chave encurta, o WHERE nunca casa e o SELECT
    * devolve ZERO linhas em silencio (regra #42 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega a linha CORRENTE do cursor de resultado nas
    * propriedades this_cReg* / this_nReg* / this_dReg* / this_lReg*.
    *
    * Sao as colunas de SigMvCab que o legado nomeia no consulta.Click; o
    * cursor vem de "Select a.* From SigMvCab a, SigCdOpe b", logo todas estao
    * presentes. NAO move o ponteiro do cursor: quem posiciona eh o chamador
    * (BuscarMovimentacao faz GO TOP, como o "Go Top In csTemporario" legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_uChave, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.this_cCursorResultado)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        IF EOF(loc_cAlias)
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        TRY
            *-- Padrao obrigatorio: SELECT (alias) ANTES de acessar campos
            SELECT (loc_cAlias)

            THIS.this_cRegEmpresa      = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "emps", ""))
            THIS.this_cRegEmpresaDest  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "empds", ""))
            THIS.this_cRegOperacao     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "dopes", ""))
            THIS.this_dRegData         = THIS.LerCampoCursor(loc_cAlias, "datas", {/:})
            THIS.this_dRegPrazoEntrega = THIS.LerCampoCursor(loc_cAlias, "prazoents", {/:})
            THIS.this_cRegGrupoOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupoos", ""))
            THIS.this_cRegGrupoDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupods", ""))
            THIS.this_cRegContaOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contaos", ""))
            THIS.this_cRegContaDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contads", ""))
            THIS.this_nRegNumeroOp     = THIS.LerCampoCursor(loc_cAlias, "nops", 0)
            THIS.this_nRegNumero       = THIS.LerCampoCursor(loc_cAlias, "numes", 0)
            THIS.this_cRegVendedor     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "vends", ""))
            THIS.this_cRegStatus       = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "pstatus", ""))

            *-- chksubn eh bit: chega como Logico (.T./.F.) ou Numerico (0/1)
            *-- conforme o driver ODBC - ConverterParaLogico trata os dois.
            THIS.this_lRegBaixada = ConverterParaLogico(THIS.LerCampoCursor(loc_cAlias, "chksubn", .F.))

            *-- empdopnums vem gravada na tabela; so remontamos quando vier em
            *-- branco, para nunca divergir do valor real do banco.
            loc_uChave = THIS.LerCampoCursor(loc_cAlias, "empdopnums", "")
            IF EMPTY(loc_uChave)
                loc_uChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                        THIS.this_cRegOperacao, ;
                                                        THIS.this_nRegNumero)
            ENDIF
            THIS.this_cRegChave = loc_uChave

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do registro corrente para a auditoria de
    * BusinessBase e para o handoff da linha selecionada. A chave de SigMvCab
    * eh a composta EmpDopNums (char(29)).
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = THIS.this_cRegChave

        IF EMPTY(loc_cChave)
            loc_cChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                    THIS.this_cRegOperacao, ;
                                                    THIS.this_nRegNumero)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - libera o cursor de resultado da consulta
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Movimentacao")
            USE IN cursor_4c_Movimentacao
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

