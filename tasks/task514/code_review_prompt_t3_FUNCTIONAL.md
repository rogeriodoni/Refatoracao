# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [METODO-INEXISTENTE] Metodo 'THIS.RetornarFontStyle()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-HEADER] Header Caption 'Descr' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'DtCriacao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'DtAlteracao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3685 linhas total):

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
701:             .Top         = 170
702:             .Left        = 326
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
851:                 loc_oGrid.Column1.Header1.Caption = "Titulo"
852:                 loc_oGrid.Column2.Header1.Caption = "Descr"
853:                 loc_oGrid.Column3.Header1.Caption = "Ativo"
854:                 loc_oGrid.Column4.Header1.Caption = "DtCriacao"
855:                 loc_oGrid.Column5.Header1.Caption = "DtAlteracao"
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

*-- Linhas 1277 a 1555:
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
1369:         LOCAL loc_oSubPg1, loc_cSQL, loc_nRes, loc_oGrid, loc_j, loc_nTotalCols
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
1388:                 loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1389:                 loc_oGrid.RecordSource = ""
1390:                 IF USED("cursor_4c_ResultadoTemp")
1391:                     USE IN cursor_4c_ResultadoTemp
1392:                 ENDIF
1393:                 IF USED("cursor_4c_Resultado")
1394:                     USE IN cursor_4c_Resultado
1395:                 ENDIF
1396:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1397:                 IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
1398:                     SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
1399:                     USE IN cursor_4c_ResultadoTemp
1400:                     loc_oGrid.ColumnCount  = 0
1401:                     loc_oGrid.RecordSource = "cursor_4c_Resultado"
1402:                     *-- Reconfigurar ControlSource apos auto-bind (sobrepoe vinculo por posicao)
1403:                     loc_nTotalCols = FCOUNT("cursor_4c_Resultado")
1404:                     FOR loc_j = 1 TO loc_nTotalCols
1405:                         loc_oGrid.Columns(loc_j).ControlSource = "cursor_4c_Resultado." + FIELD(loc_j, "cursor_4c_Resultado")
1406:                         loc_oGrid.Columns(loc_j).Header1.Caption = FIELD(loc_j, "cursor_4c_Resultado")
1407:                     NEXT
1408:                 ELSE
1409:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1410:                 ENDIF
1411:                 ENDIF
1412:             ENDIF
1413: 
1414:         CATCH TO loc_oErro
1415:             MsgErro("Erro ao executar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnExecutarSQLClick")
1416:         ENDTRY
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
1421:     * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho
1422:     *==========================================================================
1423:     PROCEDURE BtnProcessarClick()
1424:         LOCAL loc_oSubPg1, loc_dIni, loc_dFim
1425: 
1426:         TRY
1427:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1428:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1429: 
1430:                 *-- Ler datas dos campos e setar variaveis PUBLIC para SQLEXEC
1431:                 IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtInicial", 5)
1432:                     loc_dIni = CTOD(ALLTRIM(loc_oSubPg1.txt_4c_DtInicial.Value))
1433:                     IF !EMPTY(loc_dIni)
1434:                         PUBLIC _vp_DtInicial
1435:                         _vp_DtInicial = loc_dIni
1436:                     ENDIF
1437:                 ENDIF
1438: 
1439:                 IF PEMSTATUS(loc_oSubPg1, "txt_4c_DtFinal", 5)
1440:                     loc_dFim = CTOD(ALLTRIM(loc_oSubPg1.txt_4c_DtFinal.Value))
1441:                     IF !EMPTY(loc_dFim)
1442:                         PUBLIC _vp_DtFinal
1443:                         _vp_DtFinal = loc_dFim
1444:                     ENDIF
1445:                 ENDIF
1446:             ENDIF
1447:         CATCH TO loc_oErro
1448:             MsgErro("Erro ao ler datas:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
1449:         ENDTRY
1450: 
1451:         THIS.BtnExecutarSQLClick()
1452: 
1453:         *-- Resetar indicador SQL alterado apos execucao
1454:         TRY
1455:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1456:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1457:                 IF PEMSTATUS(loc_oSubPg1, "lbl_4c_SqlAlterado", 5)
1458:                     loc_oSubPg1.lbl_4c_SqlAlterado.ForeColor = RGB(0, 0, 0)
1459:                 ENDIF
1460:             ENDIF
1461:         CATCH TO loc_oErro
1462:             MsgErro("Erro ao resetar indicador:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
1463:         ENDTRY
1464:     ENDPROC
1465: 
1466:     *==========================================================================
1467:     * BtnLayOutRPTClick - Salva SQL e navega para sub-pagina de Layout (FASE 9)
1468:     * Original: Cmd_LayOutRPT.Click -> Grupo_Salva.Salva.Click()
1469:     *==========================================================================
1470:     PROCEDURE BtnLayOutRPTClick()
1471:         LOCAL loc_oPg2
1472:         TRY
1473:             IF THIS.FormParaBO()
1474:                 IF THIS.this_oBusinessObject.Salvar()
1475:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
1476:                     loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1477:                     *-- Sincronizar ListIndex do ComboBox com PaperSize atual do cursor
1478:                     IF PEMSTATUS(loc_oPg2, "cbo_4c_TamPapel", 5) AND USED("cursor_4c_PropsTitulo")
1479:                         SELECT cursor_4c_PropsTitulo
1480:                         loc_oPg2.cbo_4c_TamPapel.ListIndex = cursor_4c_PropsTitulo.PaperSize
1481:                     ENDIF
1482:                     *-- Atualizar imagem de orientacao conforme valor no cursor
1483:                     THIS.OrientacaoChanged()
1484:                 ENDIF
1485:             ENDIF
1486:         CATCH TO loc_oErro
1487:             MsgErro("Erro ao salvar/navegar layout:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnLayOutRPTClick")
1488:         ENDTRY
1489:     ENDPROC
1490: 
1491:     *==========================================================================
1492:     * BtnEstruturaClick - Mostra estrutura da tabela selecionada no editor SQL
1493:     * Original: Cmd_Estrutura.Click -> sys.all_Columns query -> grid resultado
1494:     *==========================================================================
1495:     PROCEDURE BtnEstruturaClick()
1496:         LOCAL loc_oSubPg1, loc_cTabela, loc_cSQL, loc_nRes, loc_oGrid, loc_lOK, loc_j, loc_nTotalCols
1497:         loc_lOK = .F.
1498: 
1499:         TRY
1500:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5) AND ;
1501:                PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "obj_4c_OleRTF_SqlCMD", 5)
1502: 
1503:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1504:                 loc_cTabela = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.SelText)
1505: 
1506:                 IF EMPTY(loc_cTabela)
1507:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1508:                     MsgAviso("Selecione o nome da tabela no editor SQL.")
1509:                 ELSE
1510:                     IF GETWORDCOUNT(loc_cTabela) > 1
1511:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1512:                     MsgAviso("Selecione apenas o nome da tabela (sem espa" + CHR(231) + "os).")
1513:                 ELSE
1514:                     IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1515:                     MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1516:                 ELSE
1517:                     loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, " + ;
1518:                         "c.Max_Length, " + ;
1519:                         "CASE WHEN c.Precision>0 THEN CAST(c.Precision AS CHAR(3)) ELSE '' END AS Precision, " + ;
1520:                         "CASE WHEN c.Scale>0 THEN CAST(c.Scale AS CHAR(3)) ELSE '' END AS Scale, " + ;
1521:                         "CASE WHEN c.Is_Nullable=1 THEN 'yes' ELSE 'no' END AS Is_Nullable " + ;
1522:                         "FROM sys.all_Columns c " + ;
1523:                         "JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID " + ;
1524:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1525:                         "ORDER BY c.Column_ID"
1526: 
1527:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1528:                     loc_oGrid.RecordSource = ""
1529:                     IF USED("cursor_4c_ResultadoTemp")
1530:                         USE IN cursor_4c_ResultadoTemp
1531:                     ENDIF
1532:                     IF USED("cursor_4c_Resultado")
1533:                         USE IN cursor_4c_Resultado
1534:                     ENDIF
1535: 
1536:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1537: 
1538:                     IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
1539:                         SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
1540:                         USE IN cursor_4c_ResultadoTemp
1541:                         loc_oGrid.ColumnCount  = 0
1542:                         loc_oGrid.RecordSource = "cursor_4c_Resultado"
1543:                         *-- Reconfigurar ControlSource apos auto-bind (sobrepoe vinculo por posicao)
1544:                         loc_nTotalCols = FCOUNT("cursor_4c_Resultado")
1545:                         FOR loc_j = 1 TO loc_nTotalCols
1546:                             loc_oGrid.Columns(loc_j).ControlSource = "cursor_4c_Resultado." + FIELD(loc_j, "cursor_4c_Resultado")
1547:                             loc_oGrid.Columns(loc_j).Header1.Caption = FIELD(loc_j, "cursor_4c_Resultado")
1548:                         NEXT
1549:                         loc_lOK = .T.
1550:                     ELSE
1551:                         MsgErro("Tabela '" + loc_cTabela + "' n" + CHR(227) + "o encontrada.", "Estrutura")
1552:                     ENDIF
1553: 
1554:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1555:                     ENDIF

*-- Linhas 1568 a 1676:
1568:     * PopularComboReports - Preenche cbo_4c_NmReports com cursor_4c_Dados
1569:     * Chamado apos CarregarLista() para manter combo sincronizado
1570:     *==========================================================================
1571:     PROTECTED PROCEDURE PopularComboReports()
1572:         LOCAL loc_oCbo, loc_cNmReport
1573:         loc_oCbo = .NULL.
1574: 
1575:         TRY
1576:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1577:                 RETURN
1578:             ENDIF
1579:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "cbo_4c_NmReports", 5)
1580:                 RETURN
1581:             ENDIF
1582: 
1583:             loc_oCbo = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
1584:             loc_oCbo.Clear()
1585:             loc_oCbo.AddItem("")
1586: 
1587:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1588:                 SELECT cursor_4c_Dados
1589:                 SCAN
1590:                     loc_cNmReport = ALLTRIM(cursor_4c_Dados.NmReport)
1591:                     IF !EMPTY(loc_cNmReport)
1592:                         loc_oCbo.AddItem(loc_cNmReport)
1593:                     ENDIF
1594:                 ENDSCAN
1595:             ENDIF
1596: 
1597:         CATCH TO loc_oErro
1598:             MsgErro("Erro ao popular combo:" + CHR(13) + loc_oErro.Message, "FormRPT.PopularComboReports")
1599:         ENDTRY
1600:     ENDPROC
1601: 
1602:     *==========================================================================
1603:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1604:     *==========================================================================
1605:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1606:         LOCAL loc_nI, loc_oObjeto, loc_nP
1607:         loc_nI = 0
1608:         loc_nP = 0
1609: 
1610:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1611:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1612: 
1613:             IF VARTYPE(loc_oObjeto) = "O"
1614:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1615:                     loc_oObjeto.Visible = .T.
1616:                 ENDIF
1617: 
1618:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1619:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1620:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1621:                     ENDFOR
1622:                 ENDIF
1623: 
1624:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1625:                     IF loc_oObjeto.ControlCount > 0
1626:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1627:                     ENDIF
1628:                 ENDIF
1629:             ENDIF
1630:         ENDFOR
1631:     ENDPROC
1632: 
1633:     *==========================================================================
1634:     * CriarCursoresLayout - Cria cursores para configuracao de layout do FRX
1635:     *==========================================================================
1636:     PROTECTED PROCEDURE CriarCursoresLayout()
1637:         IF USED("cursor_4c_PropsTitulo")
1638:             USE IN cursor_4c_PropsTitulo
1639:         ENDIF
1640:         IF USED("cursor_4c_PropsGrp")
1641:             USE IN cursor_4c_PropsGrp
1642:         ENDIF
1643:         IF USED("cursor_4c_PropsCampos")
1644:             USE IN cursor_4c_PropsCampos
1645:         ENDIF
1646:         IF USED("cursor_4c_LstCampos")
1647:             USE IN cursor_4c_LstCampos
1648:         ENDIF
1649: 
1650:         SET NULL ON
1651:         CREATE CURSOR cursor_4c_PropsTitulo ( ;
1652:             LblCaption M(4), LblFonte M(4), LblBtFonte C(1), LblBtCor I(10), ;
1653:             LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5), ;
1654:             Orientation I(1), PaperSize I(1) ;
1655:         )
1656:         APPEND BLANK
1657:         REPLACE Orientation WITH 1, PaperSize WITH 9
1658:         REPLACE LblCaption WITH "", LblFonte WITH "Tahoma,10,N", LblBtFonte WITH ""
1659:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 90, LblTipoCmp WITH "C"
1660: 
1661:         CREATE CURSOR cursor_4c_PropsGrp ( ;
1662:             NmCampo C(40), LblCaption M(4), LblFonte M(4), LblBtFonte C(1), ;
1663:             LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5) ;
1664:         )
1665:         APPEND BLANK
1666:         REPLACE NmCampo WITH "", LblCaption WITH "Campo de SubTotal"
1667:         REPLACE LblFonte WITH "Tahoma,8,N", LblBtFonte WITH ""
1668:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 10, LblTipoCmp WITH "C"
1669: 
1670:         CREATE CURSOR cursor_4c_PropsCampos ( ;
1671:             NmCampo C(40), TpCampo C(10), CkOutRPT I(1), CkFiltro I(1), ;
1672:             CkSubTot I(1), CkTotal I(1), LblCaption M(4), LblFonte M(4), ;
1673:             LblBtFonte C(1), LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), ;
1674:             LblTipoCmp C(1), ArrayID I(5) ;
1675:         )
1676: 

*-- Linhas 1682 a 1725:
1682:     * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
1683:     * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
1684:     *==========================================================================
1685:     PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
1686:         LOCAL loc_oSubPg2, loc_i
1687:         LOCAL loc_aPaperSize(41)
1688:         loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1689: 
1690:         *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
1691:         loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
1692:         WITH loc_oSubPg2.cnt_4c_BotoesLayout
1693:             .Top         = 37
1694:             .Left        = 11
1695:             .Width       = 160
1696:             .Height      = 85
1697:             .BackStyle   = 0
1698:             .BorderWidth = 0
1699:             .Visible     = .T.
1700: 
1701:             .AddObject("cmd_4c_VoltarLayout", "CommandButton")
1702:             WITH .cmd_4c_VoltarLayout
1703:                 .Caption  = "Voltar"
1704:                 .Top      = 5
1705:                 .Left     = 5
1706:                 .Width    = 70
1707:                 .Height   = 70
1708:                 .Visible  = .T.
1709:             ENDWITH
1710: 
1711:             .AddObject("cmd_4c_GerarLayout", "CommandButton")
1712:             WITH .cmd_4c_GerarLayout
1713:                 .Caption  = "Gerar" + CHR(13) + "Layout"
1714:                 .Top      = 5
1715:                 .Left     = 80
1716:                 .Width    = 70
1717:                 .Height   = 70
1718:                 .Visible  = .T.
1719:             ENDWITH
1720:         ENDWITH
1721: 
1722:         *-- Label NmRelatorio (Lbl_Nm_Relatorio: Top=131+29=160)
1723:         loc_oSubPg2.AddObject("lbl_4c_NmRelatorio", "Label")
1724:         WITH loc_oSubPg2.lbl_4c_NmRelatorio
1725:             .Caption   = ""

*-- Linhas 1827 a 1872:
1827:             .Visible = .T.
1828:         ENDWITH
1829: 
1830:         *-- OptionGroup orientacao (OptGrp_Orientacao: Top=126+29=155)
1831:         *-- ControlSource liga Value (1=Retrato, 2=Paisagem) a cursor_4c_PropsTitulo.Orientation
1832:         loc_oSubPg2.AddObject("opt_4c_Orientacao", "OptionGroup")
1833:         WITH loc_oSubPg2.opt_4c_Orientacao
1834:             .Top           = 155
1835:             .Left          = 580
1836:             .Width         = 180
1837:             .Height        = 28
1838:             .ButtonCount   = 2
1839:             .Value         = 1
1840:             .ControlSource = "cursor_4c_PropsTitulo.Orientation"
1841:             .BackStyle     = 0
1842:             .BorderStyle   = 0
1843:             .Visible       = .T.
1844: 
1845:             WITH .Buttons(1)
1846:                 .Caption = "Retrato"
1847:                 .Left    = 0
1848:                 .Width   = 85
1849:                 .Visible = .T.
1850:             ENDWITH
1851: 
1852:             WITH .Buttons(2)
1853:                 .Caption = "Paisagem"
1854:                 .Left    = 90
1855:                 .Width   = 85
1856:                 .Visible = .T.
1857:             ENDWITH
1858:         ENDWITH
1859: 
1860:         *-- Label "Titulo do Relatorio:" (Label1: Top=162+29=191)
1861:         loc_oSubPg2.AddObject("lbl_4c_TituloRelLayout", "Label")
1862:         WITH loc_oSubPg2.lbl_4c_TituloRelLayout
1863:             .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
1864:             .Top       = 191
1865:             .Left      = 10
1866:             .Width     = 110
1867:             .Height    = 16
1868:             .FontName  = "Tahoma"
1869:             .FontSize  = 8
1870:             .FontBold  = .T.
1871:             .BackStyle = 0
1872:             .Visible   = .T.

*-- Linhas 2323 a 2621:
2323:             ENDWITH
2324:         ENDWITH
2325: 
2326:         *-- BINDEVENTs (handlers devem ser PUBLIC)
2327:         LOCAL loc_oGrdTIT, loc_oGrdCMPs, loc_oGrdGRP
2328:         loc_oGrdTIT  = loc_oSubPg2.grd_4c_PropsTitulo
2329:         loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
2330:         loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp
2331: 
2332:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
2333:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
2334:         BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
2335:         BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
2336:         BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
2337:         BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
2338:         BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")
2339:         BINDEVENT(loc_oGrdCMPs.Column7.Edit1,     "KeyPress",          THIS, "EdtCaptionCMPsLostFocus")
2340:         BINDEVENT(loc_oGrdCMPs.Column9.Command1,  "Click",              THIS, "BtnFonteCMPsClick")
2341:         BINDEVENT(loc_oGrdCMPs.Column10.Command1, "Click",              THIS, "BtnCorCMPsClick")
2342:         BINDEVENT(loc_oGrdGRP.Column1.Combo1,     "InteractiveChange",  THIS, "ComboNmCampoGRPInteractiveChange")
2343:         BINDEVENT(loc_oGrdGRP.Column4.Command1,   "Click",              THIS, "BtnFonteGRPClick")
2344:         BINDEVENT(loc_oGrdGRP.Column5.Command1,   "Click",              THIS, "BtnCorGRPClick")
2345:     ENDPROC
2346: 
2347:     *==========================================================================
2348:     * BtnVoltarLayoutClick - Volta para Sub-Page1 (Editor SQL)
2349:     *==========================================================================
2350:     PROCEDURE BtnVoltarLayoutClick()
2351:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
2352:     ENDPROC
2353: 
2354:     *==========================================================================
2355:     * OrientacaoChanged - Atualiza imagem ao mudar orientacao Portrait/Paisagem
2356:     *==========================================================================
2357:     PROCEDURE OrientacaoChanged()
2358:         LOCAL loc_oPg2, loc_nOrientacao
2359:         loc_oPg2        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2360:         loc_nOrientacao = loc_oPg2.opt_4c_Orientacao.Value
2361:         IF loc_nOrientacao = 1
2362:             loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
2363:         ELSE
2364:             loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Paisagem_26.JPG"
2365:         ENDIF
2366:         IF USED("cursor_4c_PropsTitulo")
2367:             SELECT cursor_4c_PropsTitulo
2368:             REPLACE Orientation WITH loc_nOrientacao
2369:         ENDIF
2370:         THIS.this_nOrientacao = loc_nOrientacao
2371:     ENDPROC
2372: 
2373:     *==========================================================================
2374:     * BtnFonteTITClick - Seleciona fonte para o Titulo do Relatorio
2375:     *==========================================================================
2376:     PROCEDURE BtnFonteTITClick()
2377:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2378:         LOCAL loc_cFonteNova
2379:         IF !USED("cursor_4c_PropsTitulo")
2380:             RETURN
2381:         ENDIF
2382:         SELECT cursor_4c_PropsTitulo
2383:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsTitulo.LblFonte, "Tahoma,8,N"))
2384:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2385:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2386:         IF !EMPTY(loc_cFonteNova)
2387:             REPLACE LblFonte WITH loc_cFonteNova
2388:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2389:         ENDIF
2390:     ENDPROC
2391: 
2392:     *==========================================================================
2393:     * BtnCorTITClick - Seleciona cor do texto para o Titulo do Relatorio
2394:     *==========================================================================
2395:     PROCEDURE BtnCorTITClick()
2396:         LOCAL loc_nCor
2397:         IF !USED("cursor_4c_PropsTitulo")
2398:             RETURN
2399:         ENDIF
2400:         loc_nCor = GETCOLOR()
2401:         IF loc_nCor >= 0
2402:             SELECT cursor_4c_PropsTitulo
2403:             REPLACE LblBtCor WITH loc_nCor
2404:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2405:         ENDIF
2406:     ENDPROC
2407: 
2408:     *==========================================================================
2409:     * ChkSubTotalWhen - Valida se o campo suporta subtotal (somente numericos)
2410:     *==========================================================================
2411:     PROCEDURE ChkSubTotalWhen()
2412:         LOCAL loc_lPermite
2413:         loc_lPermite = .F.
2414:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2415:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2416:         ENDIF
2417:         RETURN loc_lPermite
2418:     ENDPROC
2419: 
2420:     *==========================================================================
2421:     * ChkTotalFinalWhen - Valida se o campo suporta total final (somente numericos)
2422:     *==========================================================================
2423:     PROCEDURE ChkTotalFinalWhen()
2424:         LOCAL loc_lPermite
2425:         loc_lPermite = .F.
2426:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2427:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2428:         ENDIF
2429:         RETURN loc_lPermite
2430:     ENDPROC
2431: 
2432:     *==========================================================================
2433:     * EdtCaptionCMPsLostFocus - Recalcula LblTam ao editar titulo de campo
2434:     *==========================================================================
2435:     PROCEDURE EdtCaptionCMPsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2436:         LOCAL loc_cTpCampo, loc_cFonte, loc_nTam
2437:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2438:             RETURN
2439:         ENDIF
2440:         loc_cTpCampo = ALLTRIM(NVL(cursor_4c_PropsCampos.TpCampo, ""))
2441:         loc_cFonte   = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2442:         IF EMPTY(loc_cTpCampo)
2443:             RETURN
2444:         ENDIF
2445:         loc_nTam = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2446:         IF loc_nTam > 0
2447:             SELECT cursor_4c_PropsCampos
2448:             REPLACE LblTamCmp WITH loc_nTam
2449:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2450:         ENDIF
2451:     ENDPROC
2452: 
2453:     *==========================================================================
2454:     * BtnFonteCMPsClick - Seleciona fonte para coluna de Campos
2455:     *==========================================================================
2456:     PROCEDURE BtnFonteCMPsClick()
2457:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2458:         LOCAL loc_cFonteNova
2459:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2460:             RETURN
2461:         ENDIF
2462:         SELECT cursor_4c_PropsCampos
2463:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2464:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2465:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2466:         IF !EMPTY(loc_cFonteNova)
2467:             REPLACE LblFonte WITH loc_cFonteNova
2468:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2469:         ENDIF
2470:     ENDPROC
2471: 
2472:     *==========================================================================
2473:     * BtnCorCMPsClick - Seleciona cor do texto para coluna de Campos
2474:     *==========================================================================
2475:     PROCEDURE BtnCorCMPsClick()
2476:         LOCAL loc_nCor
2477:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2478:             RETURN
2479:         ENDIF
2480:         loc_nCor = GETCOLOR()
2481:         IF loc_nCor >= 0
2482:             SELECT cursor_4c_PropsCampos
2483:             REPLACE LblBtCor WITH loc_nCor
2484:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2485:         ENDIF
2486:     ENDPROC
2487: 
2488:     *==========================================================================
2489:     * ComboNmCampoGRPInteractiveChange - Atualiza LblTam ao selecionar campo do grupo
2490:     *==========================================================================
2491:     PROCEDURE ComboNmCampoGRPInteractiveChange()
2492:         LOCAL loc_cNmCampo, loc_cTpCampo, loc_cFonte, loc_nTam
2493:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2494:             RETURN
2495:         ENDIF
2496:         loc_cNmCampo = ALLTRIM(NVL(cursor_4c_PropsGrp.NmCampo, ""))
2497:         IF EMPTY(loc_cNmCampo) OR !USED("cursor_4c_LstCampos")
2498:             RETURN
2499:         ENDIF
2500:         SELECT cursor_4c_LstCampos
2501:         LOCATE FOR cursor_4c_LstCampos.NmCampo = loc_cNmCampo
2502:         IF FOUND("cursor_4c_LstCampos")
2503:             loc_cTpCampo = ALLTRIM(NVL(cursor_4c_LstCampos.TpCampo, ""))
2504:             SELECT cursor_4c_PropsGrp
2505:             loc_cFonte = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2506:             loc_nTam   = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2507:             IF loc_nTam > 0
2508:                 REPLACE LblTamCmp WITH loc_nTam
2509:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2510:             ENDIF
2511:         ENDIF
2512:         SELECT cursor_4c_PropsGrp
2513:     ENDPROC
2514: 
2515:     *==========================================================================
2516:     * BtnFonteGRPClick - Seleciona fonte para coluna do Grupo
2517:     *==========================================================================
2518:     PROCEDURE BtnFonteGRPClick()
2519:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2520:         LOCAL loc_cFonteNova
2521:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2522:             RETURN
2523:         ENDIF
2524:         SELECT cursor_4c_PropsGrp
2525:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2526:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2527:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2528:         IF !EMPTY(loc_cFonteNova)
2529:             REPLACE LblFonte WITH loc_cFonteNova
2530:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2531:         ENDIF
2532:     ENDPROC
2533: 
2534:     *==========================================================================
2535:     * BtnCorGRPClick - Seleciona cor do texto para coluna do Grupo
2536:     *==========================================================================
2537:     PROCEDURE BtnCorGRPClick()
2538:         LOCAL loc_nCor
2539:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2540:             RETURN
2541:         ENDIF
2542:         loc_nCor = GETCOLOR()
2543:         IF loc_nCor >= 0
2544:             SELECT cursor_4c_PropsGrp
2545:             REPLACE LblBtCor WITH loc_nCor
2546:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2547:         ENDIF
2548:     ENDPROC
2549: 
2550:     *==========================================================================
2551:     * Calc_TamCampo - Calcula largura em pixels baseado no tipo e fonte do campo
2552:     * par_cTpCampo: ex "varchar(50)", par_cFonte: "FontName,Size,Style"
2553:     *==========================================================================
2554:     PROCEDURE Calc_TamCampo(par_cTpCampo, par_cFonte)
2555:         LOCAL loc_lcTipo, loc_cTpWrk, loc_nFieldWidth, loc_nTam
2556:         LOCAL loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2557:         LOCAL loc_nFontWidth
2558: 
2559:         loc_lcTipo      = UPPER(LEFT(ALLTRIM(par_cTpCampo), 1))
2560:         loc_cTpWrk      = STRTRAN(STRTRAN(STRTRAN(par_cTpCampo, loc_lcTipo, ""), "(", ""), ")", "")
2561:         loc_nFieldWidth = INT(VAL(ALLTRIM(loc_cTpWrk)))
2562: 
2563:         IF loc_nFieldWidth <= 0
2564:             RETURN 0
2565:         ENDIF
2566: 
2567:         THIS.DetalharFonte(par_cFonte, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2568: 
2569:         loc_nFontWidth = FONTMETRIC(6, loc_cFontName, loc_nFontSize, loc_cFontStyle)
2570:         IF loc_nFontWidth <= 0
2571:             loc_nFontWidth = 6
2572:         ENDIF
2573: 
2574:         RETURN INT(loc_nFieldWidth * loc_nFontWidth)
2575:     ENDPROC
2576: 
2577:     *==========================================================================
2578:     * DetalharFonte - Decompoe string "FontName,Size,Style" em partes
2579:     * Parametros por referencia: par_cFontName, par_nFontSize, par_cFontStyle, par_nFontStyle
2580:     *==========================================================================
2581:     PROCEDURE DetalharFonte(par_cFonte, par_cFontName, par_nFontSize, par_cFontStyle, par_nFontStyle)
2582:         par_nFontStyle = 0
2583:         par_cFontName  = LEFT(par_cFonte, AT(",", par_cFonte, 1) - 1)
2584:         par_cFonte     = ALLTRIM(STRTRAN(par_cFonte, par_cFontName + ",", ""))
2585:         par_nFontSize  = LEFT(par_cFonte, AT(",", par_cFonte, 1) - 1)
2586:         par_cFonte     = ALLTRIM(STRTRAN(par_cFonte, par_nFontSize + ",", ""))
2587:         par_cFontStyle = par_cFonte
2588:         par_nFontSize  = VAL(par_nFontSize)
2589:         DO CASE
2590:         CASE par_cFontStyle = "N"
2591:             par_nFontStyle = 0
2592:         CASE par_cFontStyle = "B"
2593:             par_nFontStyle = 1
2594:         CASE par_cFontStyle = "I"
2595:             par_nFontStyle = 2
2596:         CASE par_cFontStyle = "BI"
2597:             par_nFontStyle = 3
2598:         CASE par_cFontStyle = "U"
2599:             par_nFontStyle = 4
2600:         CASE par_cFontStyle = "BU"
2601:             par_nFontStyle = 5
2602:         CASE par_cFontStyle = "S"
2603:             par_nFontStyle = 128
2604:         ENDCASE
2605:     ENDPROC
2606: 
2607:     *==========================================================================
2608:     * RetornarFontStyle - Converte codigo numerico para string de estilo de fonte
2609:     *==========================================================================
2610:     PROTECTED FUNCTION RetornarFontStyle(par_nFontStyle)
2611:         DO CASE
2612:         CASE par_nFontStyle = 1
2613:             RETURN "B"
2614:         CASE par_nFontStyle = 2
2615:             RETURN "I"
2616:         CASE par_nFontStyle = 3
2617:             RETURN "BI"
2618:         CASE par_nFontStyle = 4
2619:             RETURN "U"
2620:         CASE par_nFontStyle = 5
2621:             RETURN "BU"

*-- Linhas 2630 a 2712:
2630:     * BtnGerarLayoutClick - Gera arquivo FRX usando SFReportFile
2631:     * Monta Page Header, Detail, Summary, Group e Page Footer a partir dos cursores
2632:     *==========================================================================
2633:     PROCEDURE BtnGerarLayoutClick()
2634:         LOCAL loc_lSucesso, loc_cArqFRX
2635:         LOCAL loc_loReport, loc_loPageHeader, loc_loDetail, loc_loSummary
2636:         LOCAL loc_loGroup, loc_loGroupFooter, loc_loPageFooter, loc_loObject, loc_loVariable
2637:         LOCAL loc_lcFontName, loc_lnFontSize, loc_lcFontStyle, loc_lnFontStyle
2638:         LOCAL loc_lnSummaryBand, loc_lnFACTOR, loc_lnWidthMAX
2639:         LOCAL loc_lnWidth, loc_lnHPos, loc_lnVPos, loc_lnFieldWidth, loc_lnFactorWidth
2640:         LOCAL loc_lcField, loc_lcPicture
2641:         loc_lSucesso = .F.
2642: 
2643:         TRY
2644:             IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport))
2645:                 MsgAviso("Salve o report antes de gerar o layout.")
2646:                 RETURN
2647:             ENDIF
2648:             IF !USED("cursor_4c_PropsTitulo") OR !USED("cursor_4c_PropsCampos")
2649:                 MsgAviso("Cursores de layout n" + CHR(227) + "o inicializados.")
2650:                 RETURN
2651:             ENDIF
2652: 
2653:             *-- Caminho do FRX temporario
2654:             IF !DIRECTORY(THIS.this_oBusinessObject.this_cDirTmp)
2655:                 MD (THIS.this_oBusinessObject.this_cDirTmp)
2656:             ENDIF
2657:             loc_cArqFRX = FULLPATH(THIS.this_oBusinessObject.this_cDirTmp + ;
2658:                 UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)) + ".FRX")
2659:             THIS.this_oBusinessObject.this_cArqReport = loc_cArqFRX
2660: 
2661:             *-- Contar campos com total (necessita Summary band)
2662:             SELECT cursor_4c_PropsCampos
2663:             loc_lnSummaryBand = 0
2664:             SCAN
2665:                 IF cursor_4c_PropsCampos.CkTotal = 1
2666:                     loc_lnSummaryBand = loc_lnSummaryBand + 1
2667:                 ENDIF
2668:             ENDSCAN
2669: 
2670:             *-- Instanciar SFReportFile
2671:             SET CLASSLIB TO (gc_4c_CaminhoFramework + "ReportOBJ\SFRepObj.vcx") ADDITIVE
2672:             loc_loReport = CREATEOBJECT("SFReportFile")
2673:             loc_loReport.cReportFile = loc_cArqFRX
2674:             SELECT cursor_4c_PropsTitulo
2675:             loc_loReport.Orientation = cursor_4c_PropsTitulo.Orientation - 1
2676:             loc_loReport.PaperSize   = cursor_4c_PropsTitulo.PaperSize
2677:             loc_loReport.cCOMMENT    = "ORIENTATION"
2678: 
2679:             loc_loPageHeader          = loc_loReport.GetReportBand("Page Header")
2680:             loc_loPageHeader.cCOMMENT = "PAGE_HEADER"
2681: 
2682:             loc_loDetail          = loc_loReport.GetReportBand("Detail")
2683:             loc_loDetail.nHeight  = 1
2684:             loc_loDetail.cCOMMENT = "DETAIL"
2685: 
2686:             IF loc_lnSummaryBand > 0
2687:                 loc_loReport.lSummaryBand = .T.
2688:                 loc_loSummary             = loc_loReport.GetReportBand("Summary")
2689:                 loc_loSummary.nHeight     = 3
2690:                 loc_loSummary.cCOMMENT    = "SUMMARY"
2691:             ENDIF
2692: 
2693:             *-- Banda de grupo (se NmCampo preenchido)
2694:             SELECT cursor_4c_PropsGrp
2695:             IF !ISNULL(cursor_4c_PropsGrp.NmCampo) AND !EMPTY(ALLTRIM(cursor_4c_PropsGrp.NmCampo))
2696:                 loc_loReport.CreateGroupBand()
2697:                 loc_loGroup                      = loc_loReport.GetReportBand("Group Header", 1)
2698:                 loc_loGroup.cExpression          = ALLTRIM(cursor_4c_PropsGrp.NmCampo)
2699:                 loc_loGroup.nHeight              = 3
2700:                 loc_loGroup.lPrintOnEachPage     = .T.
2701:                 loc_loGroup.nNewPageWhenLessThan = 4
2702:                 loc_loGroup.cCOMMENT             = "GROUP_HEADER"
2703: 
2704:                 loc_lcFontName  = ""
2705:                 loc_lnFontSize  = 0
2706:                 loc_lcFontStyle = ""
2707:                 loc_lnFontStyle = 0
2708:                 THIS.DetalharFonte(ALLTRIM(cursor_4c_PropsGrp.LblFonte), @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)
2709: 
2710:                 loc_loObject             = loc_loGroup.AddItem("Field")
2711:                 loc_loObject.nVPosition  = 1
2712:                 loc_loObject.cExpression = "[" + ALLTRIM(cursor_4c_PropsGrp.LblCaption) + "]"

*-- Linhas 2937 a 2997:
2937:     * Abre rpt_retrato.frx ou rpt_paisagem.frx, atualiza PAGE_HEADER_TITULO
2938:     * e acrescenta os records ao FRX gerado
2939:     *==========================================================================
2940:     PROTECTED PROCEDURE MesclarComTemplate(par_cArqFRX, par_nOrientacao)
2941:         LOCAL loc_lSucesso, loc_cTemplate, loc_cOldSafety
2942:         LOCAL loc_lcFontName, loc_lnFontSize, loc_lcFontStyle, loc_lnFontStyle
2943:         LOCAL loc_lnRed, loc_lnGreen, loc_lnBlue
2944:         loc_lSucesso  = .F.
2945:         loc_cOldSafety = SET("SAFETY")
2946: 
2947:         TRY
2948:             SET SAFETY OFF
2949: 
2950:             IF par_nOrientacao = 1
2951:                 loc_cTemplate = gc_4c_CaminhoReports + "rpt_retrato.frx"
2952:             ELSE
2953:                 loc_cTemplate = gc_4c_CaminhoReports + "rpt_paisagem.frx"
2954:             ENDIF
2955: 
2956:             IF !FILE(loc_cTemplate)
2957:                 MsgAviso("Template n" + CHR(227) + "o encontrado: " + loc_cTemplate)
2958:                 RETURN
2959:             ENDIF
2960: 
2961:             *-- Abrir FRX gerado e template
2962:             IF USED("TmpFRX_Main")
2963:                 USE IN TmpFRX_Main
2964:             ENDIF
2965:             USE (par_cArqFRX) IN 0 ALIAS TmpFRX_Main
2966: 
2967:             IF USED("TmpCabPadrao")
2968:                 USE IN TmpCabPadrao
2969:             ENDIF
2970:             USE (loc_cTemplate) IN 0 ALIAS TmpCabPadrao
2971: 
2972:             IF FILE("TmpRelat.DBF")
2973:                 IF USED("TmpRelat")
2974:                     USE IN TmpRelat
2975:                 ENDIF
2976:                 DELETE FILE TmpRelat.*
2977:             ENDIF
2978: 
2979:             SELECT * FROM TmpCabPadrao WHERE OBJTYPE NOT IN (1, 9) INTO TABLE TmpRelat READWRITE
2980: 
2981:             *-- Atualizar PAGE_HEADER_TITULO com titulo e fonte do cursor
2982:             SELECT TmpRelat
2983:             GO TOP
2984:             LOCATE FOR ALLTRIM(COMMENT) = "PAGE_HEADER_TITULO"
2985:             IF !EOF()
2986:                 SELECT cursor_4c_PropsTitulo
2987:                 loc_lcFontName  = ""
2988:                 loc_lnFontSize  = 0
2989:                 loc_lcFontStyle = ""
2990:                 loc_lnFontStyle = 0
2991:                 THIS.DetalharFonte(ALLTRIM(NVL(cursor_4c_PropsTitulo.LblFonte, "Tahoma,10,N")), ;
2992:                     @loc_lcFontName, @loc_lnFontSize, @loc_lcFontStyle, @loc_lnFontStyle)
2993: 
2994:                 SELECT TmpRelat
2995:                 REPLACE Expr     WITH "'" + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblCaption, "")) + "'"
2996:                 REPLACE COMMENT  WITH "PAGE_HEADER_TITULO " + Expr                                 + CHR(13) + ;
2997:                     "LblAlinhar " + ALLTRIM(NVL(cursor_4c_PropsTitulo.LblAlinhar, "Left"))     + CHR(13) + ;

*-- Linhas 3041 a 3084:
3041:     * SalvarFRXParaSQL - Salva cada record do FRX no SQL Server (SIGCDRLD)
3042:     * Usa ?variable parameterizado para campos texto (handles CHR(13) etc.)
3043:     *==========================================================================
3044:     PROTECTED PROCEDURE SalvarFRXParaSQL(par_cRPT_ID, par_cArqFRX)
3045:         LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
3046:         LOCAL loc_p_cidchaves, loc_p_rpt_id, loc_p_rpt_ordem
3047:         LOCAL loc_p_platform, loc_p_uniqueid, loc_p_timestamp_val
3048:         LOCAL loc_p_objtype, loc_p_objcode
3049:         LOCAL loc_p_name_val, loc_p_expr_val, loc_p_vpos, loc_p_hpos, loc_p_height, loc_p_width
3050:         LOCAL loc_p_style, loc_p_picture_val, loc_p_order_val, loc_p_unique_val
3051:         LOCAL loc_p_comment_val, loc_p_environ, loc_p_boxchar, loc_p_fillchar
3052:         LOCAL loc_p_tag_val, loc_p_tag2_val, loc_p_penred, loc_p_pengreen, loc_p_penblue
3053:         LOCAL loc_p_fillred, loc_p_fillgreen, loc_p_fillblue, loc_p_pensize
3054:         LOCAL loc_p_penpat, loc_p_fillpat, loc_p_fontface_val, loc_p_fontstyle, loc_p_fontsize_val
3055:         LOCAL loc_p_mode, loc_p_ruler, loc_p_rulerlines, loc_p_grid_val
3056:         LOCAL loc_p_gridh, loc_p_gridv, loc_p_float_val, loc_p_stretch_val
3057:         LOCAL loc_p_stretchtop, loc_p_top_val, loc_p_bottom_val
3058:         LOCAL loc_p_suptype, loc_p_suprest, loc_p_norepeat, loc_p_resetrpt
3059:         LOCAL loc_p_pagebreak, loc_p_colbreak, loc_p_resetpage
3060:         LOCAL loc_p_general, loc_p_spacing, loc_p_double_val
3061:         LOCAL loc_p_swapheader, loc_p_swapfooter, loc_p_ejectbefor, loc_p_ejectafter
3062:         LOCAL loc_p_plain, loc_p_summary_val, loc_p_addalias, loc_p_offset
3063:         LOCAL loc_p_topmargin, loc_p_botmargin
3064:         LOCAL loc_p_totaltype, loc_p_resettotal, loc_p_resoid
3065:         LOCAL loc_p_curpos, loc_p_supalways, loc_p_supovflow
3066:         LOCAL loc_p_suprpcol, loc_p_supgroup, loc_p_supvalchng
3067:         LOCAL loc_p_user_val, loc_p_supexpr_val
3068:         loc_lSucesso = .F.
3069: 
3070:         TRY
3071:             SQLEXEC(gnConnHandle, "DELETE FROM SIGCDRLD WHERE rpt_id = ?par_cRPT_ID")
3072: 
3073:             IF USED("TmpFRX_Save")
3074:                 USE IN TmpFRX_Save
3075:             ENDIF
3076:             USE (par_cArqFRX) IN 0 ALIAS TmpFRX_Save
3077: 
3078:             loc_p_rpt_id = par_cRPT_ID
3079: 
3080:             loc_cSQL = "INSERT INTO SIGCDRLD (" + ;
3081:                 "cidchaves,rpt_id,rpt_ordem,platform,uniqueid,[timestamp]," + ;
3082:                 "objtype,objcode,name,expr,vpos,hpos,height,width," + ;
3083:                 "style,picture,order_,unique_,comment,environ,boxchar,fillchar," + ;
3084:                 "tag,tag2,penred,pengreen,penblue,fillred,fillgreen,fillblue," + ;

*-- Linhas 3298 a 3356:
3298:     * Usa Manutencao_RPT.Carregar_RPT para reconstruir FRX do SIGCDRLD
3299:     * e escaneia os records pelo campo COMMENT para classificar
3300:     *==========================================================================
3301:     PROCEDURE CarregarCursoresLayoutDoReport(par_cRPT_ID)
3302:         LOCAL loc_lSucesso, loc_cArqFRX, loc_oMntRPT
3303:         LOCAL loc_lnOBJTYPE, loc_lnOBJCODE, loc_lcLblCaption, loc_lcExpr
3304:         LOCAL loc_lcNmCampo, loc_lcTpCampo, loc_lcTipoCmp, loc_oPg2
3305:         loc_lSucesso = .F.
3306: 
3307:         TRY
3308:             loc_cArqFRX = FULLPATH(THIS.this_oBusinessObject.this_cDirTmp + ;
3309:                 UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)) + ".FRX")
3310:             THIS.this_oBusinessObject.this_cArqReport = loc_cArqFRX
3311: 
3312:             *-- Reconstruir FRX a partir de SIGCDRLD via Manutencao_RPT
3313:             SET CLASSLIB TO (gc_4c_CaminhoFramework + "ReportOBJ\SFRepObj.vcx") ADDITIVE
3314:             loc_oMntRPT = CREATEOBJECT("Manutencao_RPT")
3315:             IF !loc_oMntRPT.Carregar_RPT(gnConnHandle, par_cRPT_ID, loc_cArqFRX)
3316:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o layout do report.")
3317:                 RETURN
3318:             ENDIF
3319: 
3320:             *-- Resetar cursores com defaults
3321:             THIS.CriarCursoresLayout()
3322: 
3323:             *-- Abrir FRX e escanear records
3324:             IF USED("cursor_4c_TmpFRX")
3325:                 USE IN cursor_4c_TmpFRX
3326:             ENDIF
3327:             USE (loc_cArqFRX) IN 0 ALIAS cursor_4c_TmpFRX
3328: 
3329:             SELECT cursor_4c_TmpFRX
3330:             GO TOP
3331:             SCAN
3332:                 loc_lnOBJTYPE = NVL(cursor_4c_TmpFRX.OBJTYPE, 0)
3333:                 loc_lnOBJCODE = NVL(cursor_4c_TmpFRX.OBJCODE, 0)
3334: 
3335:                 DO CASE
3336:                 CASE loc_lnOBJTYPE = 1 AND loc_lnOBJCODE = 53
3337:                     *-- Report definition: extrair Orientation e PaperSize
3338:                     loc_lcExpr = NVL(cursor_4c_TmpFRX.EXPR, "")
3339:                     SELECT cursor_4c_PropsTitulo
3340:                     REPLACE Orientation WITH VAL(STRTRAN(GETWORDNUM(loc_lcExpr, 1), "ORIENTATION=", "")) + 1
3341:                     REPLACE PaperSize   WITH VAL(STRTRAN(GETWORDNUM(loc_lcExpr, 2), "PAPERSIZE=", ""))
3342:                     SELECT cursor_4c_TmpFRX
3343: 
3344:                 CASE loc_lnOBJTYPE = 8 AND ("PAGE_HEADER_TITULO" $ NVL(cursor_4c_TmpFRX.COMMENT, ""))
3345:                     loc_lcLblCaption = ALLTRIM(NVL(cursor_4c_TmpFRX.EXPR, ""))
3346:                     SELECT cursor_4c_PropsTitulo
3347:                     REPLACE LblCaption WITH IIF(EMPTY(loc_lcLblCaption), "", &loc_lcLblCaption.)
3348:                     REPLACE LblFonte   WITH ALLTRIM(NVL(cursor_4c_TmpFRX.FONTFACE, "")) + "," + ;
3349:                         ALLTRIM(STR(NVL(cursor_4c_TmpFRX.FONTSIZE, 8))) + "," + ;
3350:                         THIS.RetornarFontStyle(NVL(cursor_4c_TmpFRX.FONTSTYLE, 0))
3351:                     REPLACE LblBtCor   WITH RGB(NVL(cursor_4c_TmpFRX.PENRED, 0), NVL(cursor_4c_TmpFRX.PENGREEN, 0), NVL(cursor_4c_TmpFRX.PENBLUE, 0))
3352:                     REPLACE LblAlinhar WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 2), 2), "Left"))
3353:                     REPLACE LblTamCmp  WITH VAL(ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 3), 2), "0")))
3354:                     REPLACE LblTipoCmp WITH ALLTRIM(NVL(GETWORDNUM(MLINE(cursor_4c_TmpFRX.COMMENT, 4), 2), "C"))
3355:                     REPLACE ArrayID    WITH RECNO("cursor_4c_TmpFRX")
3356:                     SELECT cursor_4c_TmpFRX

*-- Linhas 3438 a 3481:
3438:     * CmdGrp_Acoes (3 botoes), filtros De/Ate (FwEditData), lbl_4c_SqlAlterado
3439:     * Original: SIGCDRPT.Pagina.Dados.Pageframe1.Page1
3440:     *==========================================================================
3441:     PROTECTED PROCEDURE ConfigurarPgPage1()
3442:         LOCAL loc_oSubPg1, loc_oCab
3443:         loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3444: 
3445:         IF !PEMSTATUS(loc_oSubPg1, "cnt_4c_CabecalhoDados", 5)
3446:             RETURN
3447:         ENDIF
3448: 
3449:         loc_oCab = loc_oSubPg1.cnt_4c_CabecalhoDados
3450: 
3451:         *-- Reposicionar titulos para dar espaco aos 3 botoes de acao (Left=5..244)
3452:         IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD_Sombra", 5)
3453:             loc_oCab.lbl_4c_TituloD_Sombra.Left  = 257
3454:             loc_oCab.lbl_4c_TituloD_Sombra.Width = THIS.Width - 440
3455:         ENDIF
3456:         IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD", 5)
3457:             loc_oCab.lbl_4c_TituloD.Left  = 255
3458:             loc_oCab.lbl_4c_TituloD.Width = THIS.Width - 440
3459:         ENDIF
3460: 
3461:         *-- Botao LayOutRPT: salva SQL e vai para sub-pagina de Layout
3462:         *-- Original: CmdGrp_Acoes.Cmd_LayOutRPT (Left=5, Width~70)
3463:         loc_oCab.AddObject("cmd_4c_LayOutRPT", "CommandButton")
3464:         WITH loc_oCab.cmd_4c_LayOutRPT
3465:             .Caption         = "Salvar/" + CHR(13) + "Layout"
3466:             .ToolTipText     = "Salvar SQL e configurar Layout do Relat" + CHR(243) + "rio"
3467:             .Top             = 5
3468:             .Left            = 5
3469:             .Width           = 75
3470:             .Height          = 75
3471:             .FontName        = "Tahoma"
3472:             .FontSize        = 7
3473:             .FontBold        = .T.
3474:             .FontItalic      = .T.
3475:             .ForeColor       = RGB(90, 90, 90)
3476:             .BackColor       = RGB(255, 255, 255)
3477:             .Themes          = .F.
3478:             .SpecialEffect   = 0
3479:             .MousePointer    = 15
3480:             .WordWrap        = .T.
3481:             .AutoSize        = .F.

*-- Linhas 3613 a 3676:
3613:             .Visible   = .T.
3614:         ENDWITH
3615: 
3616:         *-- BINDEVENTs para botoes de acao (handlers PUBLIC)
3617:         BINDEVENT(loc_oCab.cmd_4c_LayOutRPT, "Click", THIS, "BtnLayOutRPTClick")
3618:         BINDEVENT(loc_oCab.cmd_4c_Estrutura, "Click", THIS, "BtnEstruturaClick")
3619:         BINDEVENT(loc_oCab.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
3620: 
3621:     ENDPROC
3622: 
3623:     *==========================================================================
3624:     * FormatarGridLista - Formata visual do grid da lista
3625:     *==========================================================================
3626:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
3627:         WITH par_oGrid
3628:             .FontName = "Tahoma"
3629:             .FontSize = 8
3630:         ENDWITH
3631:     ENDPROC
3632: 
3633:     *==========================================================================
3634:     * Destroy - Limpeza ao fechar o formulario
3635:     *==========================================================================
3636:     PROCEDURE Destroy()
3637:         LOCAL loc_cSetExact
3638:         loc_cSetExact = THIS.this_cSetExact
3639: 
3640:         TRY
3641:             IF !EMPTY(loc_cSetExact)
3642:                 SET EXACT &loc_cSetExact.
3643:             ENDIF
3644: 
3645:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3646:                 THIS.this_oBusinessObject = .NULL.
3647:             ENDIF
3648: 
3649:             IF USED("cursor_4c_Dados")
3650:                 USE IN cursor_4c_Dados
3651:             ENDIF
3652: 
3653:             IF USED("cursor_4c_ResultadoTemp")
3654:                 USE IN cursor_4c_ResultadoTemp
3655:             ENDIF
3656: 
3657:             IF USED("cursor_4c_Resultado")
3658:                 USE IN cursor_4c_Resultado
3659:             ENDIF
3660: 
3661:             IF USED("cursor_4c_CboSQL")
3662:                 USE IN cursor_4c_CboSQL
3663:             ENDIF
3664: 
3665:             IF USED("cursor_4c_PropsTitulo")
3666:                 USE IN cursor_4c_PropsTitulo
3667:             ENDIF
3668:             IF USED("cursor_4c_PropsCampos")
3669:                 USE IN cursor_4c_PropsCampos
3670:             ENDIF
3671:             IF USED("cursor_4c_PropsGrp")
3672:                 USE IN cursor_4c_PropsGrp
3673:             ENDIF
3674:             IF USED("cursor_4c_LstCampos")
3675:                 USE IN cursor_4c_LstCampos
3676:             ENDIF


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

