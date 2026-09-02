# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
- [METODO-INEXISTENTE] Metodo 'THIS.RetornarFontStyle()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Resultado' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ResultadoTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Resultado' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ResultadoTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-HEADER] Header Caption 'Nome do Report' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dt. Criação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dt. Alteração' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título do Campo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título do Campo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGCDRPT.Pagina.Dados.Pageframe1.Page1): Top original=141 vs migrado 'cnt_4c_Container1' Top=4 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGCDRPT.Pagina.Dados.Pageframe1.Page1): Left original=326 vs migrado 'cnt_4c_Container1' Left=5 (diff=321px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3657 linhas total):

*-- Linhas 27 a 168:
27:     this_cSetExact       = ""   && Salva SET EXACT original (restaurado no Destroy)
28: 
29:     *==========================================================================
30:     * Init - Apenas delega para FormBase.Init() que chama InicializarForm()
31:     *==========================================================================
32:     PROCEDURE Init()
33:         LOCAL loc_lSucesso
34:         loc_lSucesso = .F.
35:         TRY
36:             loc_lSucesso = DODEFAULT()
37:         CATCH TO loc_oErro
38:             MsgErro("Erro ao inicializar FormRPT:" + CHR(13) + loc_oErro.Message, "FormRPT.Init")
39:         ENDTRY
40:         RETURN loc_lSucesso
41:     ENDPROC
42: 
43:     *==========================================================================
44:     * InicializarForm - Configuracao completa do formulario
45:     * Chamado automaticamente pelo FormBase.Init()
46:     *==========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lSucesso
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             *-- Salvar SET EXACT e ativar (padrao do legado)
53:             THIS.this_cSetExact = SET("Exact")
54:             SET EXACT ON
55: 
56:             *-- Criar Business Object
57:             THIS.this_oBusinessObject = CREATEOBJECT("RPTBO")
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MsgErro("Erro ao criar RPTBO.", "FormRPT.InicializarForm")
60:                 loc_lSucesso = .F.
61:             ENDIF
62: 
63:             *-- Variaveis PUBLIC para filtros de data (parametros SQL: ?_vp_DtInicial/?_vp_DtFinal)
64:             PUBLIC _vp_DtInicial, _vp_DtFinal
65:             _vp_DtInicial = DATE()
66:             _vp_DtFinal   = DATE()
67: 
68:             *-- Configurar estrutura visual
69:             THIS.ConfigurarPageFrame()
70:             THIS.ConfigurarPaginaLista()
71:             THIS.CriarCursoresLayout()
72:             THIS.ConfigurarPaginaDados()
73: 
74:             *-- Estado inicial: Page1 (Lista)
75:             THIS.pgf_4c_Paginas.Visible = .T.
76:             THIS.pgf_4c_Paginas.ActivePage = 1
77:             THIS.this_cModoAtual = "LISTA"
78: 
79:             *-- Propagar Caption para labels de titulo
80:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
81:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
82:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
83:             ENDIF
84: 
85:             *-- Carregar lista inicial (pula se validando UI)
86:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
87:                 THIS.CarregarLista()
88:             ENDIF
89: 
90:             loc_lSucesso = .T.
91: 
92:         CATCH TO loc_oErro
93:             MsgErro("Erro ao inicializar:" + CHR(13) + loc_oErro.Message, "FormRPT.InicializarForm")
94:         ENDTRY
95: 
96:         RETURN loc_lSucesso
97:     ENDPROC
98: 
99:     *==========================================================================
100:     * ConfigurarPageFrame - Cria PageFrame externo com Page1 (Lista) e Page2 (Dados)
101:     * PageFrame.Top = -29 oculta as abas; compensacao +29 em controles internos
102:     *==========================================================================
103:     PROTECTED PROCEDURE ConfigurarPageFrame()
104:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
105:         WITH THIS.pgf_4c_Paginas
106:             .Top       = -29
107:             .Left      = 0
108:             .Width     = THIS.Width
109:             .Height    = THIS.Height + 29
110:             .PageCount = 2
111:             .Tabs      = .F.
112:             .Visible   = .T.
113: 
114:             *-- Pagina 1: Lista de Reports
115:             .Page1.Caption  = "Lista"
116:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:             *-- Pagina 2: Edicao/Configuracao do Report
119:             .Page2.Caption  = "Dados"
120:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:         ENDWITH
122:     ENDPROC
123: 
124:     *==========================================================================
125:     * ConfigurarPaginaLista - Configura Page1 (Lista de Reports)
126:     * Contem: cabecalho, container de 5 botoes CRUD, Encerrar e grid
127:     *==========================================================================
128:     PROTECTED PROCEDURE ConfigurarPaginaLista()
129:         LOCAL loc_oPagina
130:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
131: 
132:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
133:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
134: 
135:         *----------------------------------------------------------------------
136:         * Container cabecalho (escuro, com titulo do form)
137:         * Top=29: compensacao do PageFrame.Top=-29
138:         *----------------------------------------------------------------------
139:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
140:         WITH loc_oPagina.cnt_4c_Cabecalho
141:             .Top         = 29
142:             .Left        = 0
143:             .Width       = THIS.Width
144:             .Height      = 85
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148: 
149:             .AddObject("lbl_4c_Sombra", "Label")
150:             WITH .lbl_4c_Sombra
151:                 .Caption   = THIS.Caption
152:                 .Top       = 17
153:                 .Left      = 12
154:                 .Width     = THIS.Width
155:                 .Height    = 40
156:                 .FontName  = "Tahoma"
157:                 .FontSize  = 16
158:                 .FontBold  = .T.
159:                 .ForeColor = RGB(0, 0, 0)
160:                 .BackStyle = 0
161:                 .Visible   = .T.
162:             ENDWITH
163: 
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Caption   = THIS.Caption
167:                 .Top       = 15
168:                 .Left      = 10

*-- Linhas 367 a 427:
367:             .Visible            = .T.
368:         ENDWITH
369: 
370:         *-- BINDEVENTs dos botoes (handlers devem ser PUBLIC)
371:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
372:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
373:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
374:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
377: 
378:         THIS.TornarControlesVisiveis(loc_oPagina)
379:     ENDPROC
380: 
381:     *==========================================================================
382:     * ConfigurarPaginaDados - Configura Page2 (Edicao do Report)
383:     * PageFrame interno com 2 sub-paginas:
384:     *   Sub-Page1: Editor SQL + metadados + botoes salvar + grid resultado
385:     *   Sub-Page2: Configuracao de layout (orientacao, papel, colunas) - Fase 6
386:     *==========================================================================
387:     PROTECTED PROCEDURE ConfigurarPaginaDados()
388:         LOCAL loc_oPagina, loc_oSubPg1
389:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
390: 
391:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
392:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
393: 
394:         *-- PageFrame interno (Top=-29: oculta abas; compensacao +29 nos controles internos)
395:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
396:         WITH loc_oPagina.pgf_4c_Dados
397:             .Top       = -29
398:             .Left      = 0
399:             .Width     = THIS.Width
400:             .Height    = loc_oPagina.Height + 29
401:             .PageCount = 2
402:             .Tabs      = .F.
403:             .Visible   = .T.
404:             .Page1.Caption = "SQL"
405:             .Page2.Caption = "Layout"
406:         ENDWITH
407: 
408:         *==========================================================
409:         * Sub-Page1: Editor SQL + Metadados + Botoes + Grid resultado
410:         *==========================================================
411:         loc_oSubPg1 = loc_oPagina.pgf_4c_Dados.Page1
412: 
413:         *-- Cabecalho escuro (Top=29 compensa pgf_4c_Dados.Top=-29)
414:         loc_oSubPg1.AddObject("cnt_4c_CabecalhoDados", "Container")
415:         WITH loc_oSubPg1.cnt_4c_CabecalhoDados
416:             .Top         = 29
417:             .Left        = 0
418:             .Width       = THIS.Width - 168
419:             .Height      = 85
420:             .BackColor   = RGB(100, 100, 100)
421:             .BorderWidth = 0
422:             .Visible     = .T.
423: 
424:             .AddObject("lbl_4c_TituloD_Sombra", "Label")
425:             WITH .lbl_4c_TituloD_Sombra
426:                 .Caption   = "Dados do Relat" + CHR(243) + "rio"
427:                 .Top       = 17

*-- Linhas 694 a 715:
694:             .ColumnWidths  = "295"
695:             .Visible       = .T.
696:         ENDWITH
697: 
698:         *-- Container de hints de teclado (F8/F9)
699:         loc_oSubPg1.AddObject("cnt_4c_Container1", "Container")
700:         WITH loc_oSubPg1.cnt_4c_Container1
701:             .Top         = 208
702:             .Left        = 395
703:             .Width       = 600
704:             .Height      = 25
705:             .BackStyle   = 0
706:             .BorderWidth = 0
707:             .Visible     = .T.
708: 
709:             .AddObject("lbl_4c_HintF8", "Label")
710:             WITH .lbl_4c_HintF8
711:                 .Caption   = "[F8] Executar SQL"
712:                 .Top       = 4
713:                 .Left      = 5
714:                 .Width     = 130
715:                 .Height    = 17

*-- Linhas 800 a 857:
800:             .Visible            = .T.
801:         ENDWITH
802: 
803:         *-- BINDEVENTs (handlers devem ser PUBLIC)
804:         BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Confirmar, "Click",             THIS, "BtnSalvarClick")
805:         BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",             THIS, "BtnCancelarClick")
806:         BINDEVENT(loc_oSubPg1.cbo_4c_NmReports,              "InteractiveChange", THIS, "CboNmReportsChange")
807: 
808:         THIS.ConfigurarSubPaginaLayout()
809:         THIS.ConfigurarPgPage1()
810:         THIS.TornarControlesVisiveis(loc_oPagina)
811:     ENDPROC
812: 
813:     *==========================================================================
814:     * CarregarLista - Carrega grid da Page1 com lista de reports
815:     * Configurar ControlSource e Headers APOS RecordSource (auto-bind sobrescreve)
816:     *==========================================================================
817:     PROCEDURE CarregarLista()
818:         LOCAL loc_lSucesso, loc_oGrid
819:         loc_lSucesso = .F.
820: 
821:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
822:             RETURN .T.
823:         ENDIF
824: 
825:         TRY
826:             IF !THIS.this_oBusinessObject.Buscar("")
827:                 loc_lSucesso = .F.
828:             ELSE
829:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
830: 
831:                 *-- RecordSource e ColumnCount FORA de WITH (cria colunas imediatamente)
832:                 loc_oGrid.ColumnCount = 5
833:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
834:                 loc_oGrid.ColumnCount  = 5
835: 
836:                 *-- ControlSource APOS RecordSource (sobrepoe auto-bind)
837:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
838:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
839:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Ativo"
840:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtCriacao"
841:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DtAlteracao"
842: 
843:                 *-- Larguras das colunas
844:                 loc_oGrid.Column1.Width = 280
845:                 loc_oGrid.Column2.Width = 350
846:                 loc_oGrid.Column3.Width = 50
847:                 loc_oGrid.Column4.Width = 80
848:                 loc_oGrid.Column5.Width = 80
849: 
850:                 *-- Headers (obrigatorio reconfigurar apos RecordSource)
851:                 loc_oGrid.Column1.Header1.Caption = "Nome do Report"
852:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                 loc_oGrid.Column3.Header1.Caption = "Ativo"
854:                 loc_oGrid.Column4.Header1.Caption = "Dt. Cria" + CHR(231) + CHR(227) + "o"
855:                 loc_oGrid.Column5.Header1.Caption = "Dt. Altera" + CHR(231) + CHR(227) + "o"
856: 
857:                 THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 870 a 1265:
870:     *==========================================================================
871:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
872:     *==========================================================================
873:     PROCEDURE AlternarPagina(par_nPagina)
874:         LOCAL loc_lSucesso
875:         loc_lSucesso = .F.
876: 
877:         TRY
878:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
879:                 loc_lSucesso = .F.
880:             ELSE
881:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
882: 
883:                 DO CASE
884:                 CASE par_nPagina = 1
885:                     THIS.pgf_4c_Paginas.Page1.Enabled = .T.
886:                     THIS.this_cModoAtual = "LISTA"
887: 
888:                 CASE par_nPagina = 2
889:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
890:                 ENDCASE
891: 
892:                 loc_lSucesso = .T.
893:             ENDIF
894: 
895:         CATCH TO loc_oErro
896:             MsgErro("Erro ao alternar pagina:" + CHR(13) + loc_oErro.Message, "FormRPT.AlternarPagina")
897:             loc_lSucesso = .F.
898:         ENDTRY
899: 
900:         RETURN loc_lSucesso
901:     ENDPROC
902: 
903:     *==========================================================================
904:     * BtnEncerrarClick - Fecha o formulario
905:     *==========================================================================
906:     PROCEDURE BtnEncerrarClick()
907:         THIS.Release()
908:     ENDPROC
909: 
910:     *==========================================================================
911:     * BtnIncluirClick - Prepara formulario para inclusao de novo report
912:     *==========================================================================
913:     PROCEDURE BtnIncluirClick()
914:         THIS.this_oBusinessObject.NovoRegistro()
915:         THIS.LimparCampos()
916:         THIS.this_cModoAtual = "INCLUIR"
917:         THIS.HabilitarCampos(.T.)
918:         THIS.AlternarPagina(2)
919:         THIS.AjustarBotoesPorModo()
920:     ENDPROC
921: 
922:     *==========================================================================
923:     * BtnVisualizarClick - Abre report selecionado em modo somente leitura
924:     *==========================================================================
925:     PROCEDURE BtnVisualizarClick()
926:         LOCAL loc_cRPT_ID
927:         loc_cRPT_ID = ""
928: 
929:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
930:             MsgAviso("Selecione um report para visualizar.")
931:             RETURN
932:         ENDIF
933: 
934:         SELECT cursor_4c_Dados
935:         IF BOF("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
936:             MsgAviso("Selecione um report para visualizar.")
937:             RETURN
938:         ENDIF
939: 
940:         loc_cRPT_ID = ALLTRIM(cursor_4c_Dados.RPT_ID)
941:         IF EMPTY(loc_cRPT_ID)
942:             MsgAviso("Selecione um report para visualizar.")
943:             RETURN
944:         ENDIF
945: 
946:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRPT_ID)
947:             THIS.this_cModoAtual = "VISUALIZAR"
948:             THIS.BOParaForm()
949:             THIS.HabilitarCampos(.F.)
950:             THIS.AlternarPagina(2)
951:             THIS.AjustarBotoesPorModo()
952:             THIS.CarregarCursoresLayoutDoReport(loc_cRPT_ID)
953:         ENDIF
954:     ENDPROC
955: 
956:     *==========================================================================
957:     * BtnAlterarClick - Abre report selecionado para edicao
958:     *==========================================================================
959:     PROCEDURE BtnAlterarClick()
960:         LOCAL loc_cRPT_ID
961:         loc_cRPT_ID = ""
962: 
963:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
964:             MsgAviso("Selecione um report para alterar.")
965:             RETURN
966:         ENDIF
967: 
968:         SELECT cursor_4c_Dados
969:         IF BOF("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
970:             MsgAviso("Selecione um report para alterar.")
971:             RETURN
972:         ENDIF
973: 
974:         loc_cRPT_ID = ALLTRIM(cursor_4c_Dados.RPT_ID)
975:         IF EMPTY(loc_cRPT_ID)
976:             MsgAviso("Selecione um report para alterar.")
977:             RETURN
978:         ENDIF
979: 
980:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRPT_ID)
981:             THIS.this_oBusinessObject.EditarRegistro()
982:             THIS.this_cModoAtual = "ALTERAR"
983:             THIS.BOParaForm()
984:             THIS.HabilitarCampos(.T.)
985:             THIS.AlternarPagina(2)
986:             THIS.AjustarBotoesPorModo()
987:             THIS.CarregarCursoresLayoutDoReport(loc_cRPT_ID)
988:         ENDIF
989:     ENDPROC
990: 
991:     *==========================================================================
992:     * BtnExcluirClick - Exclui report selecionado apos confirmacao
993:     *==========================================================================
994:     PROCEDURE BtnExcluirClick()
995:         LOCAL loc_cRPT_ID, loc_cNmReport
996:         loc_cRPT_ID   = ""
997:         loc_cNmReport = ""
998: 
999:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1000:             MsgAviso("Selecione um report para excluir.")
1001:             RETURN
1002:         ENDIF
1003: 
1004:         SELECT cursor_4c_Dados
1005:         IF BOF("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1006:             MsgAviso("Selecione um report para excluir.")
1007:             RETURN
1008:         ENDIF
1009: 
1010:         loc_cRPT_ID   = ALLTRIM(cursor_4c_Dados.RPT_ID)
1011:         loc_cNmReport = ALLTRIM(cursor_4c_Dados.NmReport)
1012: 
1013:         IF EMPTY(loc_cRPT_ID)
1014:             MsgAviso("Selecione um report para excluir.")
1015:             RETURN
1016:         ENDIF
1017: 
1018:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do report '" + ;
1019:                 loc_cNmReport + "'?", "Confirmar Exclus" + CHR(227) + "o")
1020:             RETURN
1021:         ENDIF
1022: 
1023:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRPT_ID)
1024:             IF THIS.this_oBusinessObject.Excluir()
1025:                 MsgInfo("Report exclu" + CHR(237) + "do com sucesso!")
1026:                 THIS.CarregarLista()
1027:             ENDIF
1028:         ENDIF
1029:     ENDPROC
1030: 
1031:     *==========================================================================
1032:     * BtnBuscarClick - Recarrega lista (reset de filtros)
1033:     *==========================================================================
1034:     PROCEDURE BtnBuscarClick()
1035:         THIS.CarregarLista()
1036:     ENDPROC
1037: 
1038:     *==========================================================================
1039:     * BtnSalvarClick - Salva inclusao ou alteracao
1040:     * Chamado pelo botao Confirmar da Page2 (criado na Fase 5)
1041:     *==========================================================================
1042:     PROCEDURE BtnSalvarClick()
1043:         LOCAL loc_lSucesso
1044:         loc_lSucesso = .F.
1045: 
1046:         IF !THIS.FormParaBO()
1047:             RETURN
1048:         ENDIF
1049: 
1050:         IF THIS.this_oBusinessObject.Salvar()
1051:             MsgInfo("Report salvo com sucesso!")
1052:             THIS.this_cModoAtual = "LISTA"
1053:             THIS.AlternarPagina(1)
1054:             THIS.CarregarLista()
1055:             loc_lSucesso = .T.
1056:         ENDIF
1057: 
1058:         RETURN loc_lSucesso
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * BtnCancelarClick - Cancela edicao e volta para lista
1063:     * Chamado pelo botao Cancelar da Page2 (criado na Fase 5)
1064:     *==========================================================================
1065:     PROCEDURE BtnCancelarClick()
1066:         THIS.LimparCampos()
1067:         THIS.this_cModoAtual = "LISTA"
1068:         THIS.AlternarPagina(1)
1069:         THIS.CarregarLista()
1070:     ENDPROC
1071: 
1072:     *==========================================================================
1073:     * FormParaBO - Transfere valores dos campos do form para o BO
1074:     * Sub-controles da Page2 criados nas Fases 5-6; PEMSTATUS garante seguranca
1075:     *==========================================================================
1076:     PROTECTED PROCEDURE FormParaBO()
1077:         LOCAL loc_lOK, loc_oSubPg1
1078:         loc_lOK = .T.
1079: 
1080:         TRY
1081:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1082:                 loc_lResultado = .T.
1083:             ENDIF
1084: 
1085:             loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1086: 
1087:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
1088:                 THIS.this_oBusinessObject.this_cNmReport = ;
1089:                     UPPER(ALLTRIM(loc_oSubPg1.txt_4c_NmReport.Value))
1090:                 IF EMPTY(THIS.this_oBusinessObject.this_cNmReport)
1091:                     MsgAviso("Obrigat" + CHR(243) + "rio informar o Nome do Report.")
1092:                     loc_oSubPg1.txt_4c_NmReport.SetFocus()
1093:                     loc_lOK = .F.
1094:                 ENDIF
1095:             ENDIF
1096: 
1097:             IF loc_lOK AND PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
1098:                 THIS.this_oBusinessObject.this_cDescr = ;
1099:                     ALLTRIM(loc_oSubPg1.edt_4c_Descricao.Value)
1100:             ENDIF
1101: 
1102:             IF loc_lOK AND PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
1103:                 THIS.this_oBusinessObject.this_lAtivo = ;
1104:                     (loc_oSubPg1.chk_4c_Ativo.Value = 1)
1105:             ENDIF
1106: 
1107:             IF loc_lOK AND PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
1108:                 THIS.this_oBusinessObject.this_cSqlQuery = ;
1109:                     ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text)
1110:                 IF EMPTY(THIS.this_oBusinessObject.this_cSqlQuery)
1111:                     MsgAviso("Obrigat" + CHR(243) + "rio informar o SQL do Report.")
1112:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1113:                     loc_lOK = .F.
1114:                 ENDIF
1115:             ENDIF
1116: 
1117:         CATCH TO loc_oErro
1118:             MsgErro("Erro ao ler campos:" + CHR(13) + loc_oErro.Message, "FormRPT.FormParaBO")
1119:             loc_lOK = .F.
1120:         ENDTRY
1121: 
1122:         RETURN loc_lOK
1123:     ENDPROC
1124: 
1125:     *==========================================================================
1126:     * BOParaForm - Transfere valores do BO para os campos do form
1127:     * Sub-controles da Page2 criados nas Fases 5-6; PEMSTATUS garante seguranca
1128:     *==========================================================================
1129:     PROTECTED PROCEDURE BOParaForm()
1130:         LOCAL loc_oSubPg1
1131:         loc_oSubPg1 = .NULL.
1132: 
1133:         TRY
1134:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1135:                 RETURN
1136:             ENDIF
1137: 
1138:             loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1139: 
1140:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
1141:                 loc_oSubPg1.txt_4c_NmReport.Value = ;
1142:                     ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
1143:             ENDIF
1144: 
1145:             IF PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
1146:                 loc_oSubPg1.edt_4c_Descricao.Value = ;
1147:                     ALLTRIM(THIS.this_oBusinessObject.this_cDescr)
1148:             ENDIF
1149: 
1150:             IF PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
1151:                 loc_oSubPg1.chk_4c_Ativo.Value = THIS.this_oBusinessObject.this_lAtivo
1152:             ENDIF
1153: 
1154:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtCriacao", 5)
1155:                 loc_oSubPg1.txt_4c_DtCriacao.Value = ;
1156:                     DTOC(THIS.this_oBusinessObject.this_dDtCriacao)
1157:             ENDIF
1158: 
1159:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtAlteracao", 5)
1160:                 loc_oSubPg1.txt_4c_DtAlteracao.Value = ;
1161:                     DTOC(THIS.this_oBusinessObject.this_dDtAlteracao)
1162:             ENDIF
1163: 
1164:             IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
1165:                 loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text = ;
1166:                     ALLTRIM(THIS.this_oBusinessObject.this_cSqlQuery)
1167:             ENDIF
1168: 
1169:         CATCH TO loc_oErro
1170:             MsgErro("Erro ao preencher campos:" + CHR(13) + loc_oErro.Message, "FormRPT.BOParaForm")
1171:         ENDTRY
1172:     ENDPROC
1173: 
1174:     *==========================================================================
1175:     * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
1176:     *==========================================================================
1177:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1178:         LOCAL loc_oSubPg1
1179:         loc_oSubPg1 = .NULL.
1180: 
1181:         TRY
1182:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1183:                 RETURN
1184:             ENDIF
1185: 
1186:             loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1187: 
1188:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
1189:                 loc_oSubPg1.txt_4c_NmReport.ReadOnly    = !par_lHabilitar
1190:                 loc_oSubPg1.txt_4c_NmReport.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
1191:             ENDIF
1192: 
1193:             IF PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
1194:                 loc_oSubPg1.edt_4c_Descricao.ReadOnly   = !par_lHabilitar
1195:                 loc_oSubPg1.edt_4c_Descricao.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
1196:             ENDIF
1197: 
1198:             IF PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
1199:                 loc_oSubPg1.chk_4c_Ativo.Enabled = par_lHabilitar OR ;
1200:                     (THIS.this_cModoAtual = "EXCLUIR")
1201:             ENDIF
1202: 
1203:             IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
1204:                 loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Enabled = par_lHabilitar
1205:             ENDIF
1206: 
1207:             *-- Botao Confirmar: habilitado em edicao OU em exclusao
1208:             LOCAL loc_oSubPg, loc_oCnt
1209:             loc_oSubPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1210:             IF PEMSTATUS(loc_oSubPg, "cnt_4c_Salva", 5)
1211:                 IF PEMSTATUS(loc_oSubPg.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1212:                     loc_oSubPg.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1213:                         par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
1214:                 ENDIF
1215:             ENDIF
1216: 
1217:         CATCH TO loc_oErro
1218:             MsgErro("Erro ao habilitar campos:" + CHR(13) + loc_oErro.Message, "FormRPT.HabilitarCampos")
1219:         ENDTRY
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * LimparCampos - Limpa campos da Page2
1224:     *==========================================================================
1225:     PROTECTED PROCEDURE LimparCampos()
1226:         LOCAL loc_oSubPg1
1227:         loc_oSubPg1 = .NULL.
1228: 
1229:         TRY
1230:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1231:                 RETURN
1232:             ENDIF
1233: 
1234:             loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1235: 
1236:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_NmReport", 5)
1237:                 loc_oSubPg1.txt_4c_NmReport.Value = ""
1238:             ENDIF
1239: 
1240:             IF PEMSTATUS(loc_oSubPg1, "edt_4c_Descricao", 5)
1241:                 loc_oSubPg1.edt_4c_Descricao.Value = ""
1242:             ENDIF
1243: 
1244:             IF PEMSTATUS(loc_oSubPg1, "chk_4c_Ativo", 5)
1245:                 loc_oSubPg1.chk_4c_Ativo.Value = 1
1246:             ENDIF
1247: 
1248:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtCriacao", 5)
1249:                 loc_oSubPg1.txt_4c_DtCriacao.Value = ""
1250:             ENDIF
1251: 
1252:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtAlteracao", 5)
1253:                 loc_oSubPg1.txt_4c_DtAlteracao.Value = ""
1254:             ENDIF
1255: 
1256:             IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
1257:                 loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text = ""
1258:             ENDIF
1259: 
1260:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtInicial", 5)
1261:                 loc_oSubPg1.txt_4c_DtInicial.Value = DTOC(DATE())
1262:             ENDIF
1263: 
1264:             IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtFinal", 5)
1265:                 loc_oSubPg1.txt_4c_DtFinal.Value = DTOC(DATE())

*-- Linhas 1277 a 1652:
1277:     *==========================================================================
1278:     * AjustarBotoesPorModo - Ajusta visibilidade/habilitacao dos botoes por modo
1279:     *==========================================================================
1280:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1281:         LOCAL loc_lEdicao, loc_oPg1Cnt
1282:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1283: 
1284:         TRY
1285:             *-- Botoes CRUD: habilitados apenas na lista
1286:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1287:                 loc_oPg1Cnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1288:                 IF PEMSTATUS(loc_oPg1Cnt, "cmd_4c_Incluir", 5)
1289:                     loc_oPg1Cnt.cmd_4c_Incluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
1290:                     loc_oPg1Cnt.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
1291:                     loc_oPg1Cnt.cmd_4c_Alterar.Enabled    = (THIS.this_cModoAtual = "LISTA")
1292:                     loc_oPg1Cnt.cmd_4c_Excluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
1293:                     loc_oPg1Cnt.cmd_4c_Buscar.Enabled     = (THIS.this_cModoAtual = "LISTA")
1294:                 ENDIF
1295:             ENDIF
1296: 
1297:             *-- Botoes de salvar (Page2 sub-page, criados na Fase 5)
1298:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1299:                 LOCAL loc_oSub1
1300:                 loc_oSub1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1301:                 IF PEMSTATUS(loc_oSub1, "cnt_4c_Salva", 5)
1302:                     IF PEMSTATUS(loc_oSub1.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1303:                         loc_oSub1.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1304:                             loc_lEdicao OR (THIS.this_cModoAtual = "EXCLUIR")
1305:                     ENDIF
1306:                     IF PEMSTATUS(loc_oSub1.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1307:                         loc_oSub1.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1308:                     ENDIF
1309:                 ENDIF
1310:             ENDIF
1311: 
1312:         CATCH TO loc_oErro
1313:             MsgErro("Erro ao ajustar botoes:" + CHR(13) + loc_oErro.Message, "FormRPT.AjustarBotoesPorModo")
1314:         ENDTRY
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * CboNmReportsChange - Ao selecionar report no combo, copia seu SQL
1319:     *==========================================================================
1320:     PROCEDURE CboNmReportsChange()
1321:         LOCAL loc_oSubPg1, loc_cNmReport, loc_cRPT_ID, loc_cSQL, loc_nRes
1322:         loc_cNmReport = ""
1323:         loc_cRPT_ID   = ""
1324: 
1325:         TRY
1326:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1327:                 loc_cNmReport = ""  && sem sub-page, noop
1328:             ELSE
1329:                 loc_oSubPg1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1330:                 loc_cNmReport = ALLTRIM(loc_oSubPg1.cbo_4c_NmReports.Value)
1331:             ENDIF
1332: 
1333:             IF !EMPTY(loc_cNmReport) AND USED("cursor_4c_Dados")
1334:                 SELECT cursor_4c_Dados
1335:                 LOCATE FOR ALLTRIM(NmReport) = loc_cNmReport
1336:                 IF FOUND()
1337:                     loc_cRPT_ID = ALLTRIM(cursor_4c_Dados.RPT_ID)
1338:                 ENDIF
1339:             ENDIF
1340: 
1341:             IF !EMPTY(loc_cRPT_ID) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1342:                 loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(loc_cRPT_ID)
1343:                 IF USED("cursor_4c_CboSQL")
1344:                     USE IN cursor_4c_CboSQL
1345:                 ENDIF
1346:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CboSQL")
1347:                 IF loc_nRes >= 0 AND USED("cursor_4c_CboSQL") AND RECCOUNT("cursor_4c_CboSQL") > 0
1348:                     SELECT cursor_4c_CboSQL
1349:                     IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
1350:                         loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text = ;
1351:                             ALLTRIM(cursor_4c_CboSQL.SqlQuery)
1352:                     ENDIF
1353:                 ENDIF
1354:                 IF USED("cursor_4c_CboSQL")
1355:                     USE IN cursor_4c_CboSQL
1356:                 ENDIF
1357:             ENDIF
1358: 
1359:         CATCH TO loc_oErro
1360:             MsgErro("Erro ao copiar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.CboNmReportsChange")
1361:         ENDTRY
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * BtnExecutarSQLClick - Executa SQL do editor e exibe no grid resultado
1366:     * Implementacao completa na Fase 7
1367:     *==========================================================================
1368:     PROCEDURE BtnExecutarSQLClick()
1369:         LOCAL loc_oSubPg1, loc_cSQL, loc_nRes, loc_oGrid
1370:         loc_cSQL = ""
1371: 
1372:         TRY
1373:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1374:                 loc_cSQL = ""  && noop
1375:             ELSE
1376:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1377:                 IF PEMSTATUS(loc_oSubPg1, "obj_4c_OleRTF_SqlCMD", 5)
1378:                     loc_cSQL = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.Text)
1379:                 ENDIF
1380:             ENDIF
1381: 
1382:             IF EMPTY(loc_cSQL)
1383:                 MsgAviso("Informe o SQL antes de executar.")
1384:             ELSE
1385:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1386:                 MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1387:             ELSE
1388:                 IF USED("cursor_4c_Resultado")
1389:                     USE IN cursor_4c_Resultado
1390:                 ENDIF
1391:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Resultado")
1392:                 IF loc_nRes >= 0 AND USED("cursor_4c_Resultado")
1393:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1394:                     loc_oGrid.ColumnCount  = 0
1395:                     loc_oGrid.RecordSource = "cursor_4c_Resultado"
1396:                 ELSE
1397:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1398:                 ENDIF
1399:                 ENDIF
1400:             ENDIF
1401: 
1402:         CATCH TO loc_oErro
1403:             MsgErro("Erro ao executar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnExecutarSQLClick")
1404:         ENDTRY
1405:     ENDPROC
1406: 
1407:     *==========================================================================
1408:     * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
1409:     * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho
1410:     *==========================================================================
1411:     PROCEDURE BtnProcessarClick()
1412:         LOCAL loc_oSubPg1, loc_dIni, loc_dFim
1413: 
1414:         TRY
1415:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1416:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1417: 
1418:                 *-- Ler datas dos campos e setar variaveis PUBLIC para SQLEXEC
1419:                 IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtInicial", 5)
1420:                     loc_dIni = CTOD(ALLTRIM(loc_oSubPg1.txt_4c_DtInicial.Value))
1421:                     IF !EMPTY(loc_dIni)
1422:                         PUBLIC _vp_DtInicial
1423:                         _vp_DtInicial = loc_dIni
1424:                     ENDIF
1425:                 ENDIF
1426: 
1427:                 IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtFinal", 5)
1428:                     loc_dFim = CTOD(ALLTRIM(loc_oSubPg1.txt_4c_DtFinal.Value))
1429:                     IF !EMPTY(loc_dFim)
1430:                         PUBLIC _vp_DtFinal
1431:                         _vp_DtFinal = loc_dFim
1432:                     ENDIF
1433:                 ENDIF
1434:             ENDIF
1435:         CATCH TO loc_oErro
1436:             MsgErro("Erro ao ler datas:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
1437:         ENDTRY
1438: 
1439:         THIS.BtnExecutarSQLClick()
1440: 
1441:         *-- Resetar indicador SQL alterado apos execucao
1442:         TRY
1443:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1444:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1445:                 IF PEMSTATUS(loc_oSubPg1, "lbl_4c_SqlAlterado", 5)
1446:                     loc_oSubPg1.lbl_4c_SqlAlterado.ForeColor = RGB(0, 0, 0)
1447:                 ENDIF
1448:             ENDIF
1449:         CATCH TO loc_oErro
1450:             MsgErro("Erro ao resetar indicador:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
1451:         ENDTRY
1452:     ENDPROC
1453: 
1454:     *==========================================================================
1455:     * BtnLayOutRPTClick - Salva SQL e navega para sub-pagina de Layout (FASE 9)
1456:     * Original: Cmd_LayOutRPT.Click -> Grupo_Salva.Salva.Click()
1457:     *==========================================================================
1458:     PROCEDURE BtnLayOutRPTClick()
1459:         LOCAL loc_oPg2
1460:         TRY
1461:             IF THIS.FormParaBO()
1462:                 IF THIS.this_oBusinessObject.Salvar()
1463:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
1464:                     loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1465:                     *-- Sincronizar ListIndex do ComboBox com PaperSize atual do cursor
1466:                     IF PEMSTATUS(loc_oPg2, "cbo_4c_TamPapel", 5) AND USED("cursor_4c_PropsTitulo")
1467:                         SELECT cursor_4c_PropsTitulo
1468:                         loc_oPg2.cbo_4c_TamPapel.ListIndex = cursor_4c_PropsTitulo.PaperSize
1469:                     ENDIF
1470:                     *-- Atualizar imagem de orientacao conforme valor no cursor
1471:                     THIS.OrientacaoChanged()
1472:                 ENDIF
1473:             ENDIF
1474:         CATCH TO loc_oErro
1475:             MsgErro("Erro ao salvar/navegar layout:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnLayOutRPTClick")
1476:         ENDTRY
1477:     ENDPROC
1478: 
1479:     *==========================================================================
1480:     * BtnEstruturaClick - Mostra estrutura da tabela selecionada no editor SQL
1481:     * Original: Cmd_Estrutura.Click -> sys.all_Columns query -> grid resultado
1482:     *==========================================================================
1483:     PROCEDURE BtnEstruturaClick()
1484:         LOCAL loc_oSubPg1, loc_cTabela, loc_cSQL, loc_nRes, loc_oGrid, loc_lOK
1485:         loc_lOK = .F.
1486: 
1487:         TRY
1488:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5) AND ;
1489:                PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "obj_4c_OleRTF_SqlCMD", 5)
1490: 
1491:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1492:                 loc_cTabela = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.SelText)
1493: 
1494:                 IF EMPTY(loc_cTabela)
1495:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1496:                     MsgAviso("Selecione o nome da tabela no editor SQL.")
1497:                 ELSE
1498:                     IF GETWORDCOUNT(loc_cTabela) > 1
1499:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1500:                     MsgAviso("Selecione apenas o nome da tabela (sem espa" + CHR(231) + "os).")
1501:                 ELSE
1502:                     IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1503:                     MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1504:                 ELSE
1505:                     loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, " + ;
1506:                         "c.Max_Length, " + ;
1507:                         "CASE WHEN c.Precision>0 THEN CAST(c.Precision AS CHAR(3)) ELSE '' END AS Precision, " + ;
1508:                         "CASE WHEN c.Scale>0 THEN CAST(c.Scale AS CHAR(3)) ELSE '' END AS Scale, " + ;
1509:                         "CASE WHEN c.Is_Nullable=1 THEN 'yes' ELSE 'no' END AS Is_Nullable " + ;
1510:                         "FROM sys.all_Columns c " + ;
1511:                         "JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID " + ;
1512:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1513:                         "ORDER BY c.Column_ID"
1514: 
1515:                     IF USED("cursor_4c_Resultado")
1516:                         USE IN cursor_4c_Resultado
1517:                     ENDIF
1518: 
1519:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Resultado")
1520: 
1521:                     IF loc_nRes >= 0 AND USED("cursor_4c_Resultado")
1522:                         loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1523:                         loc_oGrid.ColumnCount  = 0
1524:                         loc_oGrid.RecordSource = "cursor_4c_Resultado"
1525:                         loc_lOK = .T.
1526:                     ELSE
1527:                         MsgErro("Tabela '" + loc_cTabela + "' n" + CHR(227) + "o encontrada.", "Estrutura")
1528:                     ENDIF
1529: 
1530:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1531:                     ENDIF
1532:                     ENDIF
1533:                 ENDIF
1534: 
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro("Erro ao buscar estrutura:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnEstruturaClick")
1538:         ENDTRY
1539: 
1540:         RETURN loc_lOK
1541:     ENDPROC
1542: 
1543:     *==========================================================================
1544:     * PopularComboReports - Preenche cbo_4c_NmReports com cursor_4c_Dados
1545:     * Chamado apos CarregarLista() para manter combo sincronizado
1546:     *==========================================================================
1547:     PROTECTED PROCEDURE PopularComboReports()
1548:         LOCAL loc_oCbo, loc_cNmReport
1549:         loc_oCbo = .NULL.
1550: 
1551:         TRY
1552:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1553:                 RETURN
1554:             ENDIF
1555:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "cbo_4c_NmReports", 5)
1556:                 RETURN
1557:             ENDIF
1558: 
1559:             loc_oCbo = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
1560:             loc_oCbo.Clear()
1561:             loc_oCbo.AddItem("")
1562: 
1563:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1564:                 SELECT cursor_4c_Dados
1565:                 SCAN
1566:                     loc_cNmReport = ALLTRIM(cursor_4c_Dados.NmReport)
1567:                     IF !EMPTY(loc_cNmReport)
1568:                         loc_oCbo.AddItem(loc_cNmReport)
1569:                     ENDIF
1570:                 ENDSCAN
1571:             ENDIF
1572: 
1573:         CATCH TO loc_oErro
1574:             MsgErro("Erro ao popular combo:" + CHR(13) + loc_oErro.Message, "FormRPT.PopularComboReports")
1575:         ENDTRY
1576:     ENDPROC
1577: 
1578:     *==========================================================================
1579:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1580:     *==========================================================================
1581:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1582:         LOCAL loc_nI, loc_oObjeto, loc_nP
1583:         loc_nI = 0
1584:         loc_nP = 0
1585: 
1586:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1587:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1588: 
1589:             IF VARTYPE(loc_oObjeto) = "O"
1590:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1591:                     loc_oObjeto.Visible = .T.
1592:                 ENDIF
1593: 
1594:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1595:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1596:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1597:                     ENDFOR
1598:                 ENDIF
1599: 
1600:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1601:                     IF loc_oObjeto.ControlCount > 0
1602:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1603:                     ENDIF
1604:                 ENDIF
1605:             ENDIF
1606:         ENDFOR
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * CriarCursoresLayout - Cria cursores para configuracao de layout do FRX
1611:     *==========================================================================
1612:     PROTECTED PROCEDURE CriarCursoresLayout()
1613:         IF USED("cursor_4c_PropsTitulo")
1614:             USE IN cursor_4c_PropsTitulo
1615:         ENDIF
1616:         IF USED("cursor_4c_PropsGrp")
1617:             USE IN cursor_4c_PropsGrp
1618:         ENDIF
1619:         IF USED("cursor_4c_PropsCampos")
1620:             USE IN cursor_4c_PropsCampos
1621:         ENDIF
1622:         IF USED("cursor_4c_LstCampos")
1623:             USE IN cursor_4c_LstCampos
1624:         ENDIF
1625: 
1626:         SET NULL ON
1627:         CREATE CURSOR cursor_4c_PropsTitulo ( ;
1628:             LblCaption M(4), LblFonte M(4), LblBtFonte C(1), LblBtCor I(10), ;
1629:             LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5), ;
1630:             Orientation I(1), PaperSize I(1) ;
1631:         )
1632:         APPEND BLANK
1633:         REPLACE Orientation WITH 1, PaperSize WITH 9
1634:         REPLACE LblCaption WITH "", LblFonte WITH "Tahoma,10,N", LblBtFonte WITH ""
1635:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 90, LblTipoCmp WITH "C"
1636: 
1637:         CREATE CURSOR cursor_4c_PropsGrp ( ;
1638:             NmCampo C(40), LblCaption M(4), LblFonte M(4), LblBtFonte C(1), ;
1639:             LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5) ;
1640:         )
1641:         APPEND BLANK
1642:         REPLACE NmCampo WITH "", LblCaption WITH "Campo de SubTotal"
1643:         REPLACE LblFonte WITH "Tahoma,8,N", LblBtFonte WITH ""
1644:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 10, LblTipoCmp WITH "C"
1645: 
1646:         CREATE CURSOR cursor_4c_PropsCampos ( ;
1647:             NmCampo C(40), TpCampo C(10), CkOutRPT I(1), CkFiltro I(1), ;
1648:             CkSubTot I(1), CkTotal I(1), LblCaption M(4), LblFonte M(4), ;
1649:             LblBtFonte C(1), LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), ;
1650:             LblTipoCmp C(1), ArrayID I(5) ;
1651:         )
1652: 

*-- Linhas 1658 a 1701:
1658:     * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
1659:     * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
1660:     *==========================================================================
1661:     PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
1662:         LOCAL loc_oSubPg2, loc_i
1663:         LOCAL loc_aPaperSize(41)
1664:         loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1665: 
1666:         *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
1667:         loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
1668:         WITH loc_oSubPg2.cnt_4c_BotoesLayout
1669:             .Top         = 37
1670:             .Left        = 11
1671:             .Width       = 160
1672:             .Height      = 85
1673:             .BackStyle   = 0
1674:             .BorderWidth = 0
1675:             .Visible     = .T.
1676: 
1677:             .AddObject("cmd_4c_VoltarLayout", "CommandButton")
1678:             WITH .cmd_4c_VoltarLayout
1679:                 .Caption  = "Voltar"
1680:                 .Top      = 5
1681:                 .Left     = 5
1682:                 .Width    = 70
1683:                 .Height   = 70
1684:                 .Visible  = .T.
1685:             ENDWITH
1686: 
1687:             .AddObject("cmd_4c_GerarLayout", "CommandButton")
1688:             WITH .cmd_4c_GerarLayout
1689:                 .Caption  = "Gerar" + CHR(13) + "Layout"
1690:                 .Top      = 5
1691:                 .Left     = 80
1692:                 .Width    = 70
1693:                 .Height   = 70
1694:                 .Visible  = .T.
1695:             ENDWITH
1696:         ENDWITH
1697: 
1698:         *-- Label NmRelatorio (Lbl_Nm_Relatorio: Top=131+29=160)
1699:         loc_oSubPg2.AddObject("lbl_4c_NmRelatorio", "Label")
1700:         WITH loc_oSubPg2.lbl_4c_NmRelatorio
1701:             .Caption   = ""

*-- Linhas 1803 a 1848:
1803:             .Visible = .T.
1804:         ENDWITH
1805: 
1806:         *-- OptionGroup orientacao (OptGrp_Orientacao: Top=126+29=155)
1807:         *-- ControlSource liga Value (1=Retrato, 2=Paisagem) a cursor_4c_PropsTitulo.Orientation
1808:         loc_oSubPg2.AddObject("opt_4c_Orientacao", "OptionGroup")
1809:         WITH loc_oSubPg2.opt_4c_Orientacao
1810:             .Top           = 155
1811:             .Left          = 580
1812:             .Width         = 180
1813:             .Height        = 28
1814:             .ButtonCount   = 2
1815:             .Value         = 1
1816:             .ControlSource = "cursor_4c_PropsTitulo.Orientation"
1817:             .BackStyle     = 0
1818:             .BorderStyle   = 0
1819:             .Visible       = .T.
1820: 
1821:             WITH .Buttons(1)
1822:                 .Caption = "Retrato"
1823:                 .Left    = 0
1824:                 .Width   = 85
1825:                 .Visible = .T.
1826:             ENDWITH
1827: 
1828:             WITH .Buttons(2)
1829:                 .Caption = "Paisagem"
1830:                 .Left    = 90
1831:                 .Width   = 85
1832:                 .Visible = .T.
1833:             ENDWITH
1834:         ENDWITH
1835: 
1836:         *-- Label "Titulo do Relatorio:" (Label1: Top=162+29=191)
1837:         loc_oSubPg2.AddObject("lbl_4c_TituloRelLayout", "Label")
1838:         WITH loc_oSubPg2.lbl_4c_TituloRelLayout
1839:             .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
1840:             .Top       = 191
1841:             .Left      = 10
1842:             .Width     = 110
1843:             .Height    = 16
1844:             .FontName  = "Tahoma"
1845:             .FontSize  = 8
1846:             .FontBold  = .T.
1847:             .BackStyle = 0
1848:             .Visible   = .T.

*-- Linhas 2299 a 2597:
2299:             ENDWITH
2300:         ENDWITH
2301: 
2302:         *-- BINDEVENTs (handlers devem ser PUBLIC)
2303:         LOCAL loc_oGrdTIT, loc_oGrdCMPs, loc_oGrdGRP
2304:         loc_oGrdTIT  = loc_oSubPg2.grd_4c_PropsTitulo
2305:         loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
2306:         loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp
2307: 
2308:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
2309:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
2310:         BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
2311:         BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
2312:         BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
2313:         BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
2314:         BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")
2315:         BINDEVENT(loc_oGrdCMPs.Column7.Edit1,     "KeyPress",          THIS, "EdtCaptionCMPsLostFocus")
2316:         BINDEVENT(loc_oGrdCMPs.Column9.Command1,  "Click",              THIS, "BtnFonteCMPsClick")
2317:         BINDEVENT(loc_oGrdCMPs.Column10.Command1, "Click",              THIS, "BtnCorCMPsClick")
2318:         BINDEVENT(loc_oGrdGRP.Column1.Combo1,     "InteractiveChange",  THIS, "ComboNmCampoGRPInteractiveChange")
2319:         BINDEVENT(loc_oGrdGRP.Column4.Command1,   "Click",              THIS, "BtnFonteGRPClick")
2320:         BINDEVENT(loc_oGrdGRP.Column5.Command1,   "Click",              THIS, "BtnCorGRPClick")
2321:     ENDPROC
2322: 
2323:     *==========================================================================
2324:     * BtnVoltarLayoutClick - Volta para Sub-Page1 (Editor SQL)
2325:     *==========================================================================
2326:     PROCEDURE BtnVoltarLayoutClick()
2327:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
2328:     ENDPROC
2329: 
2330:     *==========================================================================
2331:     * OrientacaoChanged - Atualiza imagem ao mudar orientacao Portrait/Paisagem
2332:     *==========================================================================
2333:     PROCEDURE OrientacaoChanged()
2334:         LOCAL loc_oPg2, loc_nOrientacao
2335:         loc_oPg2        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2336:         loc_nOrientacao = loc_oPg2.opt_4c_Orientacao.Value
2337:         IF loc_nOrientacao = 1
2338:             loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
2339:         ELSE
2340:             loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Paisagem_26.JPG"
2341:         ENDIF
2342:         IF USED("cursor_4c_PropsTitulo")
2343:             SELECT cursor_4c_PropsTitulo
2344:             REPLACE Orientation WITH loc_nOrientacao
2345:         ENDIF
2346:         THIS.this_nOrientacao = loc_nOrientacao
2347:     ENDPROC
2348: 
2349:     *==========================================================================
2350:     * BtnFonteTITClick - Seleciona fonte para o Titulo do Relatorio
2351:     *==========================================================================
2352:     PROCEDURE BtnFonteTITClick()
2353:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2354:         LOCAL loc_cFonteNova
2355:         IF !USED("cursor_4c_PropsTitulo")
2356:             RETURN
2357:         ENDIF
2358:         SELECT cursor_4c_PropsTitulo
2359:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsTitulo.LblFonte, "Tahoma,8,N"))
2360:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2361:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2362:         IF !EMPTY(loc_cFonteNova)
2363:             REPLACE LblFonte WITH loc_cFonteNova
2364:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2365:         ENDIF
2366:     ENDPROC
2367: 
2368:     *==========================================================================
2369:     * BtnCorTITClick - Seleciona cor do texto para o Titulo do Relatorio
2370:     *==========================================================================
2371:     PROCEDURE BtnCorTITClick()
2372:         LOCAL loc_nCor
2373:         IF !USED("cursor_4c_PropsTitulo")
2374:             RETURN
2375:         ENDIF
2376:         loc_nCor = GETCOLOR()
2377:         IF loc_nCor >= 0
2378:             SELECT cursor_4c_PropsTitulo
2379:             REPLACE LblBtCor WITH loc_nCor
2380:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2381:         ENDIF
2382:     ENDPROC
2383: 
2384:     *==========================================================================
2385:     * ChkSubTotalWhen - Valida se o campo suporta subtotal (somente numericos)
2386:     *==========================================================================
2387:     PROCEDURE ChkSubTotalWhen()
2388:         LOCAL loc_lPermite
2389:         loc_lPermite = .F.
2390:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2391:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2392:         ENDIF
2393:         RETURN loc_lPermite
2394:     ENDPROC
2395: 
2396:     *==========================================================================
2397:     * ChkTotalFinalWhen - Valida se o campo suporta total final (somente numericos)
2398:     *==========================================================================
2399:     PROCEDURE ChkTotalFinalWhen()
2400:         LOCAL loc_lPermite
2401:         loc_lPermite = .F.
2402:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2403:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2404:         ENDIF
2405:         RETURN loc_lPermite
2406:     ENDPROC
2407: 
2408:     *==========================================================================
2409:     * EdtCaptionCMPsLostFocus - Recalcula LblTam ao editar titulo de campo
2410:     *==========================================================================
2411:     PROCEDURE EdtCaptionCMPsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2412:         LOCAL loc_cTpCampo, loc_cFonte, loc_nTam
2413:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2414:             RETURN
2415:         ENDIF
2416:         loc_cTpCampo = ALLTRIM(NVL(cursor_4c_PropsCampos.TpCampo, ""))
2417:         loc_cFonte   = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2418:         IF EMPTY(loc_cTpCampo)
2419:             RETURN
2420:         ENDIF
2421:         loc_nTam = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2422:         IF loc_nTam > 0
2423:             SELECT cursor_4c_PropsCampos
2424:             REPLACE LblTamCmp WITH loc_nTam
2425:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2426:         ENDIF
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * BtnFonteCMPsClick - Seleciona fonte para coluna de Campos
2431:     *==========================================================================
2432:     PROCEDURE BtnFonteCMPsClick()
2433:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2434:         LOCAL loc_cFonteNova
2435:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2436:             RETURN
2437:         ENDIF
2438:         SELECT cursor_4c_PropsCampos
2439:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2440:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2441:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2442:         IF !EMPTY(loc_cFonteNova)
2443:             REPLACE LblFonte WITH loc_cFonteNova
2444:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2445:         ENDIF
2446:     ENDPROC
2447: 
2448:     *==========================================================================
2449:     * BtnCorCMPsClick - Seleciona cor do texto para coluna de Campos
2450:     *==========================================================================
2451:     PROCEDURE BtnCorCMPsClick()
2452:         LOCAL loc_nCor
2453:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2454:             RETURN
2455:         ENDIF
2456:         loc_nCor = GETCOLOR()
2457:         IF loc_nCor >= 0
2458:             SELECT cursor_4c_PropsCampos
2459:             REPLACE LblBtCor WITH loc_nCor
2460:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2461:         ENDIF
2462:     ENDPROC
2463: 
2464:     *==========================================================================
2465:     * ComboNmCampoGRPInteractiveChange - Atualiza LblTam ao selecionar campo do grupo
2466:     *==========================================================================
2467:     PROCEDURE ComboNmCampoGRPInteractiveChange()
2468:         LOCAL loc_cNmCampo, loc_cTpCampo, loc_cFonte, loc_nTam
2469:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2470:             RETURN
2471:         ENDIF
2472:         loc_cNmCampo = ALLTRIM(NVL(cursor_4c_PropsGrp.NmCampo, ""))
2473:         IF EMPTY(loc_cNmCampo) OR !USED("cursor_4c_LstCampos")
2474:             RETURN
2475:         ENDIF
2476:         SELECT cursor_4c_LstCampos
2477:         LOCATE FOR cursor_4c_LstCampos.NmCampo = loc_cNmCampo
2478:         IF FOUND("cursor_4c_LstCampos")
2479:             loc_cTpCampo = ALLTRIM(NVL(cursor_4c_LstCampos.TpCampo, ""))
2480:             SELECT cursor_4c_PropsGrp
2481:             loc_cFonte = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2482:             loc_nTam   = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2483:             IF loc_nTam > 0
2484:                 REPLACE LblTamCmp WITH loc_nTam
2485:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2486:             ENDIF
2487:         ENDIF
2488:         SELECT cursor_4c_PropsGrp
2489:     ENDPROC
2490: 
2491:     *==========================================================================
2492:     * BtnFonteGRPClick - Seleciona fonte para coluna do Grupo
2493:     *==========================================================================
2494:     PROCEDURE BtnFonteGRPClick()
2495:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2496:         LOCAL loc_cFonteNova
2497:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2498:             RETURN
2499:         ENDIF
2500:         SELECT cursor_4c_PropsGrp
2501:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2502:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2503:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2504:         IF !EMPTY(loc_cFonteNova)
2505:             REPLACE LblFonte WITH loc_cFonteNova
2506:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2507:         ENDIF
2508:     ENDPROC
2509: 
2510:     *==========================================================================
2511:     * BtnCorGRPClick - Seleciona cor do texto para coluna do Grupo
2512:     *==========================================================================
2513:     PROCEDURE BtnCorGRPClick()
2514:         LOCAL loc_nCor
2515:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2516:             RETURN
2517:         ENDIF
2518:         loc_nCor = GETCOLOR()
2519:         IF loc_nCor >= 0
2520:             SELECT cursor_4c_PropsGrp
2521:             REPLACE LblBtCor WITH loc_nCor
2522:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2523:         ENDIF
2524:     ENDPROC
2525: 
2526:     *==========================================================================
2527:     * Calc_TamCampo - Calcula largura em pixels baseado no tipo e fonte do campo
2528:     * par_cTpCampo: ex "varchar(50)", par_cFonte: "FontName,Size,Style"
2529:     *==========================================================================
2530:     PROCEDURE Calc_TamCampo(par_cTpCampo, par_cFonte)
2531:         LOCAL loc_lcTipo, loc_cTpWrk, loc_nFieldWidth, loc_nTam
2532:         LOCAL loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2533:         LOCAL loc_nFontWidth
2534: 
2535:         loc_lcTipo      = UPPER(LEFT(ALLTRIM(par_cTpCampo), 1))
2536:         loc_cTpWrk      = STRTRAN(STRTRAN(STRTRAN(par_cTpCampo, loc_lcTipo, ""), "(", ""), ")", "")
2537:         loc_nFieldWidth = INT(VAL(ALLTRIM(loc_cTpWrk)))
2538: 
2539:         IF loc_nFieldWidth <= 0
2540:             RETURN 0
2541:         ENDIF
2542: 
2543:         THIS.DetalharFonte(par_cFonte, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2544: 
2545:         loc_nFontWidth = FONTMETRIC(6, loc_cFontName, loc_nFontSize, loc_cFontStyle)
2546:         IF loc_nFontWidth <= 0
2547:             loc_nFontWidth = 6
2548:         ENDIF
2549: 
2550:         RETURN INT(loc_nFieldWidth * loc_nFontWidth)
2551:     ENDPROC
2552: 
2553:     *==========================================================================
2554:     * DetalharFonte - Decompoe string "FontName,Size,Style" em partes
2555:     * Parametros por referencia: par_cFontName, par_nFontSize, par_cFontStyle, par_nFontStyle
2556:     *==========================================================================
2557:     PROCEDURE DetalharFonte(par_cFonte, par_cFontName, par_nFontSize, par_cFontStyle, par_nFontStyle)
2558:         par_nFontStyle = 0
2559:         par_cFontName  = LEFT(par_cFonte, AT(",", par_cFonte, 1) - 1)
2560:         par_cFonte     = ALLTRIM(STRTRAN(par_cFonte, par_cFontName + ",", ""))
2561:         par_nFontSize  = LEFT(par_cFonte, AT(",", par_cFonte, 1) - 1)
2562:         par_cFonte     = ALLTRIM(STRTRAN(par_cFonte, par_nFontSize + ",", ""))
2563:         par_cFontStyle = par_cFonte
2564:         par_nFontSize  = VAL(par_nFontSize)
2565:         DO CASE
2566:         CASE par_cFontStyle = "N"
2567:             par_nFontStyle = 0
2568:         CASE par_cFontStyle = "B"
2569:             par_nFontStyle = 1
2570:         CASE par_cFontStyle = "I"
2571:             par_nFontStyle = 2
2572:         CASE par_cFontStyle = "BI"
2573:             par_nFontStyle = 3
2574:         CASE par_cFontStyle = "U"
2575:             par_nFontStyle = 4
2576:         CASE par_cFontStyle = "BU"
2577:             par_nFontStyle = 5
2578:         CASE par_cFontStyle = "S"
2579:             par_nFontStyle = 128
2580:         ENDCASE
2581:     ENDPROC
2582: 
2583:     *==========================================================================
2584:     * RetornarFontStyle - Converte codigo numerico para string de estilo de fonte
2585:     *==========================================================================
2586:     PROTECTED FUNCTION RetornarFontStyle(par_nFontStyle)
2587:         DO CASE
2588:         CASE par_nFontStyle = 1
2589:             RETURN "B"
2590:         CASE par_nFontStyle = 2
2591:             RETURN "I"
2592:         CASE par_nFontStyle = 3
2593:             RETURN "BI"
2594:         CASE par_nFontStyle = 4
2595:             RETURN "U"
2596:         CASE par_nFontStyle = 5
2597:             RETURN "BU"

*-- Linhas 2606 a 2688:
2606:     * BtnGerarLayoutClick - Gera arquivo FRX usando SFReportFile
2607:     * Monta Page Header, Detail, Summary, Group e Page Footer a partir dos cursores
2608:     *==========================================================================
2609:     PROCEDURE BtnGerarLayoutClick()
2610:         LOCAL loc_lSucesso, loc_cArqFRX
2611:         LOCAL loc_loReport, loc_loPageHeader, loc_loDetail, loc_loSummary
2612:         LOCAL loc_loGroup, loc_loGroupFooter, loc_loPageFooter, loc_loObject, loc_loVariable
2613:         LOCAL loc_lcFontName, loc_lnFontSize, loc_lcFontStyle, loc_lnFontStyle
2614:         LOCAL loc_lnSummaryBand, loc_lnFACTOR, loc_lnWidthMAX
2615:         LOCAL loc_lnWidth, loc_lnHPos, loc_lnVPos, loc_lnFieldWidth, loc_lnFactorWidth
2616:         LOCAL loc_lcField, loc_lcPicture
2617:         loc_lSucesso = .F.
2618: 
2619:         TRY
2620:             IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport))
2621:                 MsgAviso("Salve o report antes de gerar o layout.")
2622:                 RETURN
2623:             ENDIF
2624:             IF !USED("cursor_4c_PropsTitulo") OR !USED("cursor_4c_PropsCampos")
2625:                 MsgAviso("Cursores de layout n" + CHR(227) + "o inicializados.")
2626:                 RETURN
2627:             ENDIF
2628: 
2629:             *-- Caminho do FRX temporario
2630:             IF !DIRECTORY(THIS.this_oBusinessObject.this_cDirTmp)
2631:                 MD (THIS.this_oBusinessObject.this_cDirTmp)
2632:             ENDIF
2633:             loc_cArqFRX = FULLPATH(THIS.this_oBusinessObject.this_cDirTmp + ;
2634:                 UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)) + ".FRX")
2635:             THIS.this_oBusinessObject.this_cArqReport = loc_cArqFRX
2636: 
2637:             *-- Contar campos com total (necessita Summary band)
2638:             SELECT cursor_4c_PropsCampos
2639:             loc_lnSummaryBand = 0
2640:             SCAN
2641:                 IF cursor_4c_PropsCampos.CkTotal = 1
2642:                     loc_lnSummaryBand = loc_lnSummaryBand + 1
2643:                 ENDIF
2644:             ENDSCAN
2645: 
2646:             *-- Instanciar SFReportFile
2647:             SET CLASSLIB TO (gc_4c_CaminhoFramework + "ReportOBJ\SFRepObj.vcx") ADDITIVE
2648:             loc_loReport = CREATEOBJECT("SFReportFile")
2649:             loc_loReport.cReportFile = loc_cArqFRX
2650:             SELECT cursor_4c_PropsTitulo
2651:             loc_loReport.Orientation = cursor_4c_PropsTitulo.Orientation - 1
2652:             loc_loReport.PaperSize   = cursor_4c_PropsTitulo.PaperSize
2653:             loc_loReport.cCOMMENT    = "ORIENTATION"
2654: 
2655:             loc_loPageHeader          = loc_loReport.GetReportBand("Page Header")
2656:             loc_loPageHeader.cCOMMENT = "PAGE_HEADER"
2657: 
2658:             loc_loDetail          = loc_loReport.GetReportBand("Detail")
2659:             loc_loDetail.nHeight  = 1
2660:             loc_loDetail.cCOMMENT = "DETAIL"
2661: 
2662:             IF loc_lnSummaryBand > 0
2663:                 loc_loReport.lSummaryBand = .T.
2664:                 loc_loSummary             = loc_loReport.GetReportBand("Summary")
2665:                 loc_loSummary.nHeight     = 3
2666:                 loc_loSummary.cCOMMENT    = "SUMMARY"
2667:             ENDIF
2668: 
2669:             *-- Banda de grupo (se NmCampo preenchido)
2670:             SELECT cursor_4c_PropsGrp
2671:             IF !ISNULL(cursor_4c_PropsGrp.NmCampo) AND !EMPTY(ALLTRIM(cursor_4c_PropsGrp.NmCampo))
2672:                 loc_loReport.CreateGroupBand()
2673:                 loc_loGroup                      = loc_loReport.GetReportBand("Group Header", 1)
2674:                 loc_loGroup.cExpression          = ALLTRIM(cursor_4c_PropsGrp.NmCampo)
2675:                 loc_loGroup.nHeight              = 3
2676:                 loc_loGroup.lPrintOnEachPage     = .T.
2677:                 loc_loGroup.nNewPageWhenLessThan = 4
2678:                 loc_loGroup.cCOMMENT             = "GROUP_HEADER"
2679: 
2680:                 loc_lcFontName  = ""
2681:                 loc_lnFontSize  = 0
2682:                 loc_lcFontStyle = ""
2683:                 loc_lnFontStyle = 0
2684:                 THIS.DetalharFonte(ALLTRIM(cursor_4c_PropsGrp.LblFonte), @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)
2685: 
2686:                 loc_loObject             = loc_loGroup.AddItem("Field")
2687:                 loc_loObject.nVPosition  = 1
2688:                 loc_loObject.cExpression = "[" + ALLTRIM(cursor_4c_PropsGrp.LblCaption) + "]"

*-- Linhas 2913 a 2973:
2913:     * Abre rpt_retrato.frx ou rpt_paisagem.frx, atualiza PAGE_HEADER_TITULO
2914:     * e acrescenta os records ao FRX gerado
2915:     *==========================================================================
2916:     PROTECTED PROCEDURE MesclarComTemplate(par_cArqFRX, par_nOrientacao)
2917:         LOCAL loc_lSucesso, loc_cTemplate, loc_cOldSafety
2918:         LOCAL loc_lcFontName, loc_lnFontSize, loc_lcFontStyle, loc_lnFontStyle
2919:         LOCAL loc_lnRed, loc_lnGreen, loc_lnBlue
2920:         loc_lSucesso  = .F.
2921:         loc_cOldSafety = SET("SAFETY")
2922: 
2923:         TRY
2924:             SET SAFETY OFF
2925: 
2926:             IF par_nOrientacao = 1
2927:                 loc_cTemplate = gc_4c_CaminhoReports + "rpt_retrato.frx"
2928:             ELSE
2929:                 loc_cTemplate = gc_4c_CaminhoReports + "rpt_paisagem.frx"
2930:             ENDIF
2931: 
2932:             IF !FILE(loc_cTemplate)
2933:                 MsgAviso("Template n" + CHR(227) + "o encontrado: " + loc_cTemplate)
2934:                 RETURN
2935:             ENDIF
2936: 
2937:             *-- Abrir FRX gerado e template
2938:             IF USED("TmpFRX_Main")
2939:                 USE IN TmpFRX_Main
2940:             ENDIF
2941:             USE (par_cArqFRX) IN 0 ALIAS TmpFRX_Main
2942: 
2943:             IF USED("TmpCabPadrao")
2944:                 USE IN TmpCabPadrao
2945:             ENDIF
2946:             USE (loc_cTemplate) IN 0 ALIAS TmpCabPadrao
2947: 
2948:             IF FILE("TmpRelat.DBF")
2949:                 IF USED("TmpRelat")
2950:                     USE IN TmpRelat
2951:                 ENDIF
2952:                 DELETE FILE TmpRelat.*
2953:             ENDIF
2954: 
2955:             SELECT * FROM TmpCabPadrao WHERE OBJTYPE NOT IN (1, 9) INTO TABLE TmpRelat READWRITE
2956: 
2957:             *-- Atualizar PAGE_HEADER_TITULO com titulo e fonte do cursor
2958:             SELECT TmpRelat
2959:             GO TOP
2960:             LOCATE FOR ALLTRIM(COMMENT) = "PAGE_HEADER_TITULO"
2961:             IF !EOF()
2962:                 SELECT cursor_4c_PropsTitulo
2963:                 loc_lcFontName  = ""
2964:                 loc_lnFontSize  = 0
2965:                 loc_lcFontStyle = ""
2966:                 loc_lnFontStyle = 0
2967:                 THIS.DetalharFonte(ALLTRIM(NVL(cursor_4c_PropsTitulo.LblFonte, "Tahoma,10,N")), ;
2968:                     @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)
2969: 
2970:                 SELECT TmpRelat
2971:                 REPLACE Expr     WITH "'" + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblCaption, "")) + "'"
2972:                 REPLACE COMMENT  WITH "PAGE_HEADER_TITULO " + Expr                                 + CHR(13) + ;
2973:                     "LblAlinhar " + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblAlinhar, "Left"))     + CHR(13) + ;

*-- Linhas 3017 a 3060:
3017:     * SalvarFRXParaSQL - Salva cada record do FRX no SQL Server (SIGCDRLD)
3018:     * Usa ?variable parameterizado para campos texto (handles CHR(13) etc.)
3019:     *==========================================================================
3020:     PROTECTED PROCEDURE SalvarFRXParaSQL(par_cRPT_ID, par_cArqFRX)
3021:         LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
3022:         LOCAL loc_p_cidchaves, loc_p_rpt_id, loc_p_rpt_ordem
3023:         LOCAL loc_p_platform, loc_p_uniqueid, loc_p_timestamp_val
3024:         LOCAL loc_p_objtype, loc_p_objcode
3025:         LOCAL loc_p_name_val, loc_p_expr_val, loc_p_vpos, loc_p_hpos, loc_p_height, loc_p_width
3026:         LOCAL loc_p_style, loc_p_picture_val, loc_p_order_val, loc_p_unique_val
3027:         LOCAL loc_p_comment_val, loc_p_environ, loc_p_boxchar, loc_p_fillchar
3028:         LOCAL loc_p_tag_val, loc_p_tag2_val, loc_p_penred, loc_p_pengreen, loc_p_penblue
3029:         LOCAL loc_p_fillred, loc_p_fillgreen, loc_p_fillblue, loc_p_pensize
3030:         LOCAL loc_p_penpat, loc_p_fillpat, loc_p_fontface_val, loc_p_fontstyle, loc_p_fontsize_val
3031:         LOCAL loc_p_mode, loc_p_ruler, loc_p_rulerlines, loc_p_grid_val
3032:         LOCAL loc_p_gridh, loc_p_gridv, loc_p_float_val, loc_p_stretch_val
3033:         LOCAL loc_p_stretchtop, loc_p_top_val, loc_p_bottom_val
3034:         LOCAL loc_p_suptype, loc_p_suprest, loc_p_norepeat, loc_p_resetrpt
3035:         LOCAL loc_p_pagebreak, loc_p_colbreak, loc_p_resetpage
3036:         LOCAL loc_p_general, loc_p_spacing, loc_p_double_val
3037:         LOCAL loc_p_swapheader, loc_p_swapfooter, loc_p_ejectbefor, loc_p_ejectafter
3038:         LOCAL loc_p_plain, loc_p_summary_val, loc_p_addalias, loc_p_offset
3039:         LOCAL loc_p_topmargin, loc_p_botmargin
3040:         LOCAL loc_p_totaltype, loc_p_resettotal, loc_p_resoid
3041:         LOCAL loc_p_curpos, loc_p_supalways, loc_p_supovflow
3042:         LOCAL loc_p_suprpcol, loc_p_supgroup, loc_p_supvalchng
3043:         LOCAL loc_p_user_val, loc_p_supexpr_val
3044:         loc_lSucesso = .F.
3045: 
3046:         TRY
3047:             SQLEXEC(gnConnHandle, "DELETE FROM SIGCDRLD WHERE rpt_id = ?par_cRPT_ID")
3048: 
3049:             IF USED("TmpFRX_Save")
3050:                 USE IN TmpFRX_Save
3051:             ENDIF
3052:             USE (par_cArqFRX) IN 0 ALIAS TmpFRX_Save
3053: 
3054:             loc_p_rpt_id = par_cRPT_ID
3055: 
3056:             loc_cSQL = "INSERT INTO SIGCDRLD (" + ;
3057:                 "cidchaves,rpt_id,rpt_ordem,platform,uniqueid,[timestamp]," + ;
3058:                 "objtype,objcode,name,expr,vpos,hpos,height,width," + ;
3059:                 "style,picture,order_,unique_,comment,environ,boxchar,fillchar," + ;
3060:                 "tag,tag2,penred,pengreen,penblue,fillred,fillgreen,fillblue," + ;

*-- Linhas 3274 a 3332:
3274:     * Usa Manutencao_RPT.Carregar_RPT para reconstruir FRX do SIGCDRLD
3275:     * e escaneia os records pelo campo COMMENT para classificar
3276:     *==========================================================================
3277:     PROCEDURE CarregarCursoresLayoutDoReport(par_cRPT_ID)
3278:         LOCAL loc_lSucesso, loc_cArqFRX, loc_oMntRPT
3279:         LOCAL loc_lnOBJTYPE, loc_lnOBJCODE, loc_lcLblCaption, loc_lcExpr
3280:         LOCAL loc_lcNmCampo, loc_lcTpCampo, loc_lcTipoCmp, loc_oPg2
3281:         loc_lSucesso = .F.
3282: 
3283:         TRY
3284:             loc_cArqFRX = FULLPATH(THIS.this_oBusinessObject.this_cDirTmp + ;
3285:                 UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)) + ".FRX")
3286:             THIS.this_oBusinessObject.this_cArqReport = loc_cArqFRX
3287: 
3288:             *-- Reconstruir FRX a partir de SIGCDRLD via Manutencao_RPT
3289:             SET CLASSLIB TO (gc_4c_CaminhoFramework + "ReportOBJ\SFRepObj.vcx") ADDITIVE
3290:             loc_oMntRPT = CREATEOBJECT("Manutencao_RPT")
3291:             IF !loc_oMntRPT.Carregar_RPT(gnConnHandle, par_cRPT_ID, loc_cArqFRX)
3292:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o layout do report.")
3293:                 RETURN
3294:             ENDIF
3295: 
3296:             *-- Resetar cursores com defaults
3297:             THIS.CriarCursoresLayout()
3298: 
3299:             *-- Abrir FRX e escanear records
3300:             IF USED("cursor_4c_TmpFRX")
3301:                 USE IN cursor_4c_TmpFRX
3302:             ENDIF
3303:             USE (loc_cArqFRX) IN 0 ALIAS cursor_4c_TmpFRX
3304: 
3305:             SELECT cursor_4c_TmpFRX
3306:             GO TOP
3307:             SCAN
3308:                 loc_lnOBJTYPE = NVL(cursor_4c_TmpFRX.OBJTYPE, 0)
3309:                 loc_lnOBJCODE = NVL(cursor_4c_TmpFRX.OBJCODE, 0)
3310: 
3311:                 DO CASE
3312:                 CASE loc_lnOBJTYPE = 1 AND loc_lnOBJCODE = 53
3313:                     *-- Report definition: extrair Orientation e PaperSize
3314:                     loc_lcExpr = NVL(cursor_4c_TmpFRX.EXPR, "")
3315:                     SELECT cursor_4c_PropsTitulo
3316:                     REPLACE Orientation WITH VAL(STRTRAN(GETWORDNUM(loc_lcExpr, 1), "ORIENTATION=", "")) + 1
3317:                     REPLACE PaperSize   WITH VAL(STRTRAN(GETWORDNUM(loc_lcExpr, 2), "PAPERSIZE=", ""))
3318:                     SELECT cursor_4c_TmpFRX
3319: 
3320:                 CASE loc_lnOBJTYPE = 8 AND ("PAGE_HEADER_TITULO" $ NVL(cursor_4c_TmpFRX.COMMENT, ""))
3321:                     loc_lcLblCaption = ALLTRIM(NVL(cursor_4c_TmpFRX.EXPR, ""))
3322:                     SELECT cursor_4c_PropsTitulo
3323:                     REPLACE LblCaption WITH IIF(EMPTY(loc_lcLblCaption), "", &loc_lcLblCaption.)
3324:                     REPLACE LblFonte   WITH ALLTRIM(NVL(cursor_4c_TmpFRX.FONTFACE, "")) + "," + ;
3325:                         ALLTRIM(STR(NVL(cursor_4c_TmpFRX.FONTSIZE, 8))) + "," + ;
3326:                         THIS.RetornarFontStyle(NVL(cursor_4c_TmpFRX.FONTSTYLE, 0))
3327:                     REPLACE LblBtCor   WITH RGB(NVL(cursor_4c_TmpFRX.PENRED, 0), NVL(cursor_4c_TmpFRX.PENGREEN, 0), NVL(cursor_4c_TmpFRX.PENBLUE, 0))
3328:                     REPLACE LblAlinhar WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 2), 2), "Left"))
3329:                     REPLACE LblTamCmp  WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 3), 2), "0")))
3330:                     REPLACE LblTipoCmp WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 4), 2), "C"))
3331:                     REPLACE ArrayID    WITH RECNO("cursor_4c_TmpFRX")
3332:                     SELECT cursor_4c_TmpFRX

*-- Linhas 3414 a 3457:
3414:     * CmdGrp_Acoes (3 botoes), filtros De/Ate (FwEditData), lbl_4c_SqlAlterado
3415:     * Original: SIGCDRPT.Pagina.Dados.Pageframe1.Page1
3416:     *==========================================================================
3417:     PROTECTED PROCEDURE ConfigurarPgPage1()
3418:         LOCAL loc_oSubPg1, loc_oCab
3419:         loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3420: 
3421:         IF !PEMSTATUS(loc_oSubPg1, "cnt_4c_CabecalhoDados", 5)
3422:             RETURN
3423:         ENDIF
3424: 
3425:         loc_oCab = loc_oSubPg1.cnt_4c_CabecalhoDados
3426: 
3427:         *-- Reposicionar titulos para dar espaco aos 3 botoes de acao (Left=5..244)
3428:         IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD_Sombra", 5)
3429:             loc_oCab.lbl_4c_TituloD_Sombra.Left  = 257
3430:             loc_oCab.lbl_4c_TituloD_Sombra.Width = THIS.Width - 440
3431:         ENDIF
3432:         IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD", 5)
3433:             loc_oCab.lbl_4c_TituloD.Left  = 255
3434:             loc_oCab.lbl_4c_TituloD.Width = THIS.Width - 440
3435:         ENDIF
3436: 
3437:         *-- Botao LayOutRPT: salva SQL e vai para sub-pagina de Layout
3438:         *-- Original: CmdGrp_Acoes.Cmd_LayOutRPT (Left=5, Width~70)
3439:         loc_oCab.AddObject("cmd_4c_LayOutRPT", "CommandButton")
3440:         WITH loc_oCab.cmd_4c_LayOutRPT
3441:             .Caption         = "Salvar/" + CHR(13) + "Layout"
3442:             .ToolTipText     = "Salvar SQL e configurar Layout do Relat" + CHR(243) + "rio"
3443:             .Top             = 5
3444:             .Left            = 5
3445:             .Width           = 75
3446:             .Height          = 75
3447:             .FontName        = "Comic Sans MS"
3448:             .FontSize        = 7
3449:             .FontBold        = .T.
3450:             .FontItalic      = .T.
3451:             .ForeColor       = RGB(90, 90, 90)
3452:             .BackColor       = RGB(255, 255, 255)
3453:             .Themes          = .F.
3454:             .SpecialEffect   = 0
3455:             .MousePointer    = 15
3456:             .WordWrap        = .T.
3457:             .AutoSize        = .F.

*-- Linhas 3589 a 3652:
3589:             .Visible   = .T.
3590:         ENDWITH
3591: 
3592:         *-- BINDEVENTs para botoes de acao (handlers PUBLIC)
3593:         BINDEVENT(loc_oCab.cmd_4c_LayOutRPT, "Click", THIS, "BtnLayOutRPTClick")
3594:         BINDEVENT(loc_oCab.cmd_4c_Estrutura, "Click", THIS, "BtnEstruturaClick")
3595:         BINDEVENT(loc_oCab.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
3596: 
3597:     ENDPROC
3598: 
3599:     *==========================================================================
3600:     * FormatarGridLista - Formata visual do grid da lista
3601:     *==========================================================================
3602:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
3603:         WITH par_oGrid
3604:             .FontName = "Tahoma"
3605:             .FontSize = 8
3606:         ENDWITH
3607:     ENDPROC
3608: 
3609:     *==========================================================================
3610:     * Destroy - Limpeza ao fechar o formulario
3611:     *==========================================================================
3612:     PROCEDURE Destroy()
3613:         LOCAL loc_cSetExact
3614:         loc_cSetExact = THIS.this_cSetExact
3615: 
3616:         TRY
3617:             IF !EMPTY(loc_cSetExact)
3618:                 SET EXACT &loc_cSetExact.
3619:             ENDIF
3620: 
3621:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3622:                 THIS.this_oBusinessObject = .NULL.
3623:             ENDIF
3624: 
3625:             IF USED("cursor_4c_Dados")
3626:                 USE IN cursor_4c_Dados
3627:             ENDIF
3628: 
3629:             IF USED("cursor_4c_Resultado")
3630:                 USE IN cursor_4c_Resultado
3631:             ENDIF
3632: 
3633:             IF USED("cursor_4c_CboSQL")
3634:                 USE IN cursor_4c_CboSQL
3635:             ENDIF
3636: 
3637:             IF USED("cursor_4c_PropsTitulo")
3638:                 USE IN cursor_4c_PropsTitulo
3639:             ENDIF
3640:             IF USED("cursor_4c_PropsCampos")
3641:                 USE IN cursor_4c_PropsCampos
3642:             ENDIF
3643:             IF USED("cursor_4c_PropsGrp")
3644:                 USE IN cursor_4c_PropsGrp
3645:             ENDIF
3646:             IF USED("cursor_4c_LstCampos")
3647:                 USE IN cursor_4c_LstCampos
3648:             ENDIF
3649: 
3650:         CATCH TO loc_oErro
3651:             MsgErro("Erro no Destroy:" + CHR(13) + loc_oErro.Message, "FormRPT.Destroy")
3652:         ENDTRY


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*==============================================================================
* RPTBO.prg - Business Object - Cadastro Customizado de Relatorios 4Report
* Tabelas: SIGCDRLC (cabecalho), SIGCDRLD (detalhes FRX)
* Fase 1/8 - Propriedades e Init basico
*==============================================================================
DEFINE CLASS RPTBO AS BusinessBase

    *-- Cabecalho do Relatorio (SIGCDRLC)
    this_cRPT_ID         = ""   && RPT_ID - Chave primaria (DTOS+STRTRAN(TIME))
    this_cNmReport       = ""   && NmReport - Nome do arquivo do report
    this_cDescr          = ""   && Descr - Descricao do report
    this_dDtCriacao      = {}   && DtCriacao - Data de criacao
    this_dDtAlteracao    = {}   && DtAlteracao - Data de alteracao
    this_lAtivo          = .T.  && Ativo - Indicador ativo (default ligado)
    this_cSqlQuery       = ""   && SqlQuery - Query SQL do report

    *-- Parametros de Layout do Relatorio (Page2 do formulario)
    this_nOrientacao     = 1    && 1=Retrato, 2=Paisagem
    this_nTamPapel       = 1    && Indice do tamanho de papel no ComboBox

    *-- Controle interno
    this_cArqReport      = ""   && Caminho fisico do arquivo FRX gerado
    this_cDirTmp         = ""   && Diretorio temporario para arquivos FRX

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDRLC"
            THIS.this_cCampoChave = "RPT_ID"
            THIS.this_cDirTmp     = ".\Tmp\"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RPTBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRPT_ID)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cRPT_ID      = ""
        THIS.this_cNmReport    = ""
        THIS.this_cDescr       = ""
        THIS.this_dDtCriacao   = {}
        THIS.this_dDtAlteracao = {}
        THIS.this_lAtivo       = .T.
        THIS.this_cSqlQuery    = ""
        THIS.this_nOrientacao  = 1
        THIS.this_nTamPapel    = 1
        THIS.this_cArqReport   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRPT_ID      = TratarNulo(RPT_ID,      "C")
                THIS.this_cNmReport    = TratarNulo(NmReport,     "C")
                THIS.this_cDescr       = TratarNulo(Descr,        "C")
                THIS.this_lAtivo       = (TratarNulo(Ativo, "N") = 1)
                THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
                IF PEMSTATUS(ALIAS(), "DtCriacao",   5)
                    THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
                ENDIF
                IF PEMSTATUS(ALIAS(), "DtAlteracao", 5)
                    THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Obrigat" + CHR(243) + "rio informar o Nome do Report.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Obrigat" + CHR(243) + "rio informar o SQL do Report.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * GerarRPT_ID - Gera chave RPT_ID no formato YYYYMMDD_HHMMSS
    * Padrao legado: DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    *==========================================================================
    PROTECTED FUNCTION GerarRPT_ID()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SIGCDRLC
    * RPT_ID gerado como YYYYMMDD_HHMMSS
    * DtCriacao e DtAlteracao preenchidos com data atual
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo, loc_cDataHoje
        loc_lSucesso = .F.

        TRY
            THIS.this_cRPT_ID = THIS.GerarRPT_ID()
            loc_cAtivo        = IIF(THIS.this_lAtivo, "1", "0")
            loc_cDataHoje     = FormatarDataSQL(DATE())

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                " (RPT_ID, NmReport, Ativo, Descr, DtCriacao, DtAlteracao, SqlQuery)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cRPT_ID)            + ", " + ;
                EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + ", " + ;
                loc_cAtivo                               + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescr))    + ", " + ;
                loc_cDataHoje                            + ", " + ;
                loc_cDataHoje                            + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RPTBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SIGCDRLC
    * DtAlteracao atualizado com data atual
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo
        loc_lSucesso = .F.

        TRY
            loc_cAtivo = IIF(THIS.this_lAtivo, "1", "0")

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                " NmReport     = " + EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + "," + ;
                " Ativo        = " + loc_cAtivo + "," + ;
                " Descr        = " + EscaparSQL(ALLTRIM(THIS.this_cDescr)) + "," + ;
                " DtAlteracao  = " + FormatarDataSQL(DATE()) + "," + ;
                " SqlQuery     = " + EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ;
                " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RPTBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de SIGCDRLD (detalhes FRX) e SIGCDRLC
    * Ordem obrigatoria: detalhes primeiro, cabecalho depois (FK)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + ;
                EscaparSQL(THIS.this_cRPT_ID)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + ;
                EscaparSQL(THIS.this_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RPTBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca lista de reports (exibe no grid da Page1)
    * Cursor: cursor_4c_Dados com RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        RPT_ID       C(20), ;
                        NmReport     C(100), ;
                        Descr        C(200), ;
                        Ativo        I,      ;
                        DtCriacao    D,      ;
                        DtAlteracao  D       ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
                    " FROM SIGCDRLC"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY NmReport"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar reports:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RPTBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo RPT_ID (inclui SqlQuery)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cRPT_ID)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                " FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(par_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

