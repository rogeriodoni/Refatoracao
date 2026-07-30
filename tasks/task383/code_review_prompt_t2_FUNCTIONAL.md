# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Vendedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1788 linhas total):

*-- Linhas 33 a 160:
33:     this_cFiltroLista = ""
34: 
35:     *==========================================================================
36:     * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
37:     *==========================================================================
38:     PROCEDURE Init()
39:         LOCAL loc_lResultado
40:         loc_lResultado = .F.
41: 
42:         TRY
43:             loc_lResultado = DODEFAULT()
44:         CATCH TO loException
45:             MostrarErro(loException, "Formcrf.Init")
46:         ENDTRY
47: 
48:         RETURN loc_lResultado
49:     ENDPROC
50: 
51:     *==========================================================================
52:     * InicializarForm - Inicializa BO e componentes visuais
53:     * Chamado pelo FormBase.Init() automaticamente
54:     *==========================================================================
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lResultado
57:         loc_lResultado = .F.
58: 
59:         TRY
60:             *-- Cria Business Object
61:             THIS.this_oBusinessObject = CREATEOBJECT("crfBO")
62: 
63:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
64:                 MostrarErro("Erro ao criar crfBO.", "Formcrf.InicializarForm")
65:             ELSE
66:                 *-- Configura estrutura visual
67:                 THIS.ConfigurarPageFrame()
68:                 THIS.ConfigurarPaginaLista()
69:                 THIS.ConfigurarPaginaDados()
70: 
71:                 *-- Propaga Caption para labels do cabecalho
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 *-- Carrega dados iniciais (pula durante ValidarUIFidelity)
76:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
77:                     THIS.CarregarLista()
78:                 ENDIF
79: 
80:                 THIS.pgf_4c_Paginas.Visible = .T.
81:                 THIS.pgf_4c_Paginas.ActivePage = 1
82:                 THIS.this_cModoAtual = "LISTA"
83:                 loc_lResultado = .T.
84:             ENDIF
85: 
86:         CATCH TO loException
87:             MostrarErro(loException, "Formcrf.InicializarForm")
88:         ENDTRY
89: 
90:         RETURN loc_lResultado
91:     ENDPROC
92: 
93:     *==========================================================================
94:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
95:     * Usa Top=-29 para esconder as abas (padrao frmcadastro)
96:     * TODOS os controles dentro das Pages devem compensar +29 no Top
97:     *==========================================================================
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100: 
101:         WITH THIS.pgf_4c_Paginas
102:             .PageCount  = 2
103:             .Top        = -29
104:             .Left       = 0
105:             .Width      = 1003
106:             .Height     = 635
107:             .Tabs       = .F.
108:             .Visible    = .T.
109:             .Page1.Caption = "Lista"
110:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
111:             .Page2.Caption = "Dados"
112:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
113:         ENDWITH
114:     ENDPROC
115: 
116:     *==========================================================================
117:     * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
118:     * Top dos controles = Top_original + 29 (compensacao PageFrame)
119:     *==========================================================================
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPagina
122:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
123: 
124:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
125:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
126: 
127:         *-- Container cabecalho cinza (cntSombra: Top=1, +29 = 30)
128:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH loc_oPagina.cnt_4c_Cabecalho
130:             .Top           = 30
131:             .Left          = -1
132:             .Width         = 1004
133:             .Height        = 80
134:             .BackColor     = RGB(100, 100, 100)
135:             .BackStyle     = 1
136:             .BorderWidth   = 0
137:             .SpecialEffect = 0
138:             .Visible       = .T.
139: 
140:             .AddObject("lbl_4c_Sombra", "Label")
141:             WITH .lbl_4c_Sombra
142:                 .Top       = 15
143:                 .Left      = 10
144:                 .Width     = THIS.Width
145:                 .Height    = 40
146:                 .AutoSize  = .F.
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 16
149:                 .FontBold  = .T.
150:                 .ForeColor = RGB(0, 0, 0)
151:                 .BackStyle = 0
152:                 .Caption   = "Contagem de Refer" + CHR(234) + "ncia"
153:             ENDWITH
154: 
155:             .AddObject("lbl_4c_Titulo", "Label")
156:             WITH .lbl_4c_Titulo
157:                 .Top       = 18
158:                 .Left      = 10
159:                 .Width     = THIS.Width
160:                 .Height    = 46

*-- Linhas 409 a 474:
409:             .ScrollBars         = 2
410:         ENDWITH
411: 
412:         *-- BINDEVENT: botoes CRUD
413:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
415:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
416:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
417:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
419: 
420:         *-- BINDEVENT: botoes especiais
421:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_Espelho,        "Click", THIS, "BtnEspelhoClick")
422:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_FecharContagem, "Click", THIS, "BtnFecharContagemClick")
423:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_AbrirContagem,  "Click", THIS, "BtnAbrirContagemClick")
424: 
425:         THIS.TornarControlesVisiveis(loc_oPagina)
426:     ENDPROC
427: 
428:     *==========================================================================
429:     * ConfigurarPaginaDados - Page2: Campos principais (Fase 5/8 - primeira metade)
430:     * Top dos controles = Top_original + 29 (compensacao PageFrame.Top=-29)
431:     * Fase 5: cnt_4c_Salva + labels + txt_4c_Codigo/Conta/DConta + Line1
432:     * Fase 6: lbl_4c_Label5/7 + txt_4c_Busca/TotQt/DContas + opt + grd + img + shp
433:     *==========================================================================
434:     PROTECTED PROCEDURE ConfigurarPaginaDados()
435:         LOCAL loc_oPagina
436:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
437: 
438:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
439:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
440: 
441:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Top=11+29=40, Left=817)
442:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
443:         WITH loc_oPagina.cnt_4c_Salva
444:             .Top           = 40
445:             .Left          = 817
446:             .Width         = 160
447:             .Height        = 85
448:             .BackStyle     = 0
449:             .BorderWidth   = 0
450:             .SpecialEffect = 0
451:             .Visible       = .T.
452: 
453:             .AddObject("cmd_4c_Confirmar", "CommandButton")
454:             WITH .cmd_4c_Confirmar
455:                 .Caption         = "Confirmar"
456:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
457:                 .PicturePosition = 13
458:                 .Top             = 5
459:                 .Left            = 5
460:                 .Width           = 75
461:                 .Height          = 75
462:                 .FontName        = "Tahoma"
463:                 .FontSize        = 8
464:                 .FontBold        = .T.
465:                 .FontItalic      = .T.
466:                 .ForeColor       = RGB(90, 90, 90)
467:                 .BackColor       = RGB(255, 255, 255)
468:                 .SpecialEffect   = 0
469:                 .MousePointer    = 15
470:                 .WordWrap        = .T.
471:                 .AutoSize        = .F.
472:             ENDWITH
473: 
474:             .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 701 a 746:
701:             .Value     = 0
702:         ENDWITH
703: 
704:         *-- OptionGroup Opt_Busca (Top=122+29=151, Left=414, Width=117)
705:         *-- Buttons(1): busca por Cod.Barra; Buttons(2): busca por Produto
706:         loc_oPagina.AddObject("opt_4c_OptBusca", "OptionGroup")
707:         WITH loc_oPagina.opt_4c_OptBusca
708:             .Top         = 151
709:             .Left        = 414
710:             .Width       = 122
711:             .Height      = 23
712:             .ButtonCount = 2
713:             .BackStyle   = 0
714:             .BorderStyle = 0
715:             .Value       = 1
716:             .Visible     = .T.
717:         ENDWITH
718:         WITH loc_oPagina.opt_4c_OptBusca.Buttons(1)
719:             .Caption   = "C" + CHR(243) + "d.Barra"
720:             .BackStyle = 0
721:             .Left      = 5
722:             .Top       = 3
723:             .Width     = 55
724:             .AutoSize  = .T.
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .ForeColor = RGB(90, 90, 90)
728:             .Themes    = .F.
729:         ENDWITH
730:         WITH loc_oPagina.opt_4c_OptBusca.Buttons(2)
731:             .Caption   = "Produto"
732:             .BackStyle = 0
733:             .Left      = 63
734:             .Top       = 3
735:             .Width     = 49
736:             .AutoSize  = .T.
737:             .FontName  = "Tahoma"
738:             .FontSize  = 8
739:             .ForeColor = RGB(90, 90, 90)
740:             .Themes    = .F.
741:         ENDWITH
742: 
743:         *-- Grid GrdLoc = grd_4c_Dados (Top=174+29=203, Left=254, Width=477, Height=396)
744:         *-- Exibe csSigCdCri: Emps|QtdCtg(edit)|qtde|Grupos|Estos|Descr
745:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
746:         loc_oPagina.grd_4c_Dados.ColumnCount = 6

*-- Linhas 827 a 1455:
827:             .Value     = ""
828:         ENDWITH
829: 
830:         *-- BINDEVENT: botoes Confirmar/Cancelar
831:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
832:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
833: 
834:         *-- BINDEVENT: lookup Vendedor
835:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
836: 
837:         *-- BINDEVENT: busca de produto, quantidade, grid e opcao de busca
838:         BINDEVENT(loc_oPagina.txt_4c_Busca,    "KeyPress",         THIS, "ValidarBusca")
839:         BINDEVENT(loc_oPagina.txt_4c_TotQt,    "KeyPress",         THIS, "ValidarQuantidade")
840:         BINDEVENT(loc_oPagina.grd_4c_Dados,    "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
841:         BINDEVENT(loc_oPagina.opt_4c_OptBusca, "InteractiveChange", THIS, "OptBuscaChanged")
842: 
843:         THIS.TornarControlesVisiveis(loc_oPagina)
844: 
845:         *-- Imagem do produto permanece invisivel ate selecionar produto com foto
846:         loc_oPagina.img_4c_ImgJpg.Visible = .F.
847:     ENDPROC
848: 
849:     *==========================================================================
850:     * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
851:     * Reconfigura RecordSource, ControlSource e Headers apos cada carga
852:     *==========================================================================
853:     PROCEDURE CarregarLista()
854:         LOCAL loc_lResultado, loc_oGrid
855:         loc_lResultado = .F.
856: 
857:         TRY
858:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
859:                 loc_lResultado = .T.
860:             ELSE
861:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
862:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroLista)
863:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
864: 
865:                     *-- RecordSource + ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
866:                     loc_oGrid.ColumnCount = 3
867:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
868:                     loc_oGrid.ColumnCount  = 3
869: 
870:                     WITH loc_oGrid
871:                         .Column1.ControlSource   = "cursor_4c_Dados.Datas"
872:                         .Column1.Width           = 80
873:                         .Column1.Header1.Caption = "Data"
874: 
875:                         .Column2.ControlSource   = "cursor_4c_Dados.Vends"
876:                         .Column2.Width           = 90
877:                         .Column2.Header1.Caption = "Vendedor"
878: 
879:                         .Column3.ControlSource   = "cursor_4c_Dados.Cods"
880:                         .Column3.Width           = 80
881:                         .Column3.Header1.Caption = "C" + CHR(243) + "digo"
882:                     ENDWITH
883: 
884:                     THIS.FormatarGridLista(loc_oGrid)
885:                     loc_lResultado = .T.
886:                 ENDIF
887:                 ENDIF
888:             ENDIF
889:         CATCH TO loException
890:             MostrarErro(loException, "Formcrf.CarregarLista")
891:         ENDTRY
892: 
893:         RETURN loc_lResultado
894:     ENDPROC
895: 
896:     *==========================================================================
897:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
898:     *==========================================================================
899:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
900:         LOCAL loc_lResultado
901:         loc_lResultado = .F.
902: 
903:         TRY
904:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
905:                 MostrarErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
906:                     TRANSFORM(par_nPagina), "Formcrf.AlternarPagina")
907:             ELSE
908:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
909: 
910:                 IF par_nPagina = 1
911:                     THIS.this_cModoAtual = "LISTA"
912:                     THIS.CarregarLista()
913:                 ELSE
914:                     THIS.CarregarGridItens()
915:                 ENDIF
916: 
917:                 loc_lResultado = .T.
918:             ENDIF
919:         CATCH TO loException
920:             MostrarErro(loException, "Formcrf.AlternarPagina")
921:         ENDTRY
922: 
923:         RETURN loc_lResultado
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
928:     * Itera Pages de PageFrames e Controls de Containers
929:     *==========================================================================
930:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
931:         LOCAL loc_nI, loc_oObjeto
932: 
933:         FOR loc_nI = 1 TO par_oContainer.ControlCount
934:             loc_oObjeto = par_oContainer.Controls(loc_nI)
935: 
936:             IF VARTYPE(loc_oObjeto) = "O"
937:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
938:                     LOCAL loc_nP
939:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
940:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
941:                     ENDFOR
942:                 ENDIF
943: 
944:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
945:                     THIS.TornarControlesVisiveis(loc_oObjeto)
946:                 ENDIF
947: 
948:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
949:                     LOOP
950:                 ENDIF
951: 
952:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
953:                     loc_oObjeto.Visible = .T.
954:                 ENDIF
955:             ENDIF
956:         ENDFOR
957:     ENDPROC
958: 
959:     *==========================================================================
960:     * FormatarGridLista - Formata visual do grid principal da lista
961:     *==========================================================================
962:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
963:         WITH par_oGrid
964:             .FontName = "Tahoma"
965:             .FontSize = 8
966:         ENDWITH
967:     ENDPROC
968: 
969:     *==========================================================================
970:     * BtnIncluirClick - Abre Page2 para nova contagem
971:     * Carrega parametros (GrPadVens) e produtos do estoque em csSigCdCri
972:     *==========================================================================
973:     PROCEDURE BtnIncluirClick()
974:         IF !THIS.this_oBusinessObject.CarregarParametros()
975:             RETURN
976:         ENDIF
977: 
978:         THIS.this_oBusinessObject.NovoRegistro()
979:         THIS.this_oBusinessObject.this_cEmps = go_4c_Sistema.cCodEmpresa
980: 
981:         IF !THIS.this_oBusinessObject.CarregarProdutosEstoque()
982:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar " + ;
983:                      "produtos do estoque.")
984:             RETURN
985:         ENDIF
986: 
987:         THIS.LimparCampos()
988:         THIS.this_cModoAtual = "INCLUIR"
989:         THIS.HabilitarCampos(.T.)
990:         THIS.AlternarPagina(2)
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * BtnVisualizarClick - Abre Page2 em modo visualizacao (somente leitura)
995:     * Mostra apenas itens contados (par_lSoContados=.T.)
996:     *==========================================================================
997:     PROCEDURE BtnVisualizarClick()
998:         LOCAL loc_cCods
999: 
1000:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
1001:                 OR RECCOUNT("cursor_4c_Dados") = 0
1002:             MsgAviso("Nenhuma contagem selecionada.")
1003:             RETURN
1004:         ENDIF
1005: 
1006:         SELECT cursor_4c_Dados
1007:         loc_cCods = ALLTRIM(TratarNulo(Cods, "C"))
1008: 
1009:         IF EMPTY(loc_cCods)
1010:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
1011:             RETURN
1012:         ENDIF
1013: 
1014:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
1015:             RETURN
1016:         ENDIF
1017: 
1018:         IF !THIS.this_oBusinessObject.CarregarItensContagem(loc_cCods, .T.)
1019:             RETURN
1020:         ENDIF
1021: 
1022:         THIS.BOParaForm()
1023:         THIS.this_cModoAtual = "VISUALIZAR"
1024:         THIS.HabilitarCampos(.F.)
1025:         THIS.AjustarBotoesPorModo()
1026:         THIS.AlternarPagina(2)
1027:     ENDPROC
1028: 
1029:     *==========================================================================
1030:     * BtnAlterarClick - Abre Page2 para edicao de contagem existente
1031:     * Bloqueia se contagem esta encerrada (Conferido=1)
1032:     *==========================================================================
1033:     PROCEDURE BtnAlterarClick()
1034:         LOCAL loc_cCods, loc_nConferido
1035: 
1036:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
1037:                 OR RECCOUNT("cursor_4c_Dados") = 0
1038:             MsgAviso("Nenhuma contagem selecionada.")
1039:             RETURN
1040:         ENDIF
1041: 
1042:         SELECT cursor_4c_Dados
1043:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1044:         loc_nConferido = TratarNulo(Conferido, "N")
1045: 
1046:         IF loc_nConferido = 1
1047:             MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
1048:             RETURN
1049:         ENDIF
1050: 
1051:         IF !THIS.this_oBusinessObject.CarregarParametros()
1052:             RETURN
1053:         ENDIF
1054: 
1055:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
1056:             RETURN
1057:         ENDIF
1058: 
1059:         IF !THIS.this_oBusinessObject.CarregarItensContagem(loc_cCods, .F.)
1060:             RETURN
1061:         ENDIF
1062: 
1063:         THIS.this_oBusinessObject.EditarRegistro()
1064:         THIS.BOParaForm()
1065:         THIS.this_cModoAtual = "ALTERAR"
1066:         THIS.HabilitarCampos(.T.)
1067:         THIS.AjustarBotoesPorModo()
1068:         THIS.AlternarPagina(2)
1069:     ENDPROC
1070: 
1071:     *==========================================================================
1072:     * BtnExcluirClick - Exclui contagem selecionada (cabecalho + itens)
1073:     * Bloqueia se contagem encerrada; pede confirmacao antes de excluir
1074:     *==========================================================================
1075:     PROCEDURE BtnExcluirClick()
1076:         LOCAL loc_cCods, loc_nConferido
1077: 
1078:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
1079:                 OR RECCOUNT("cursor_4c_Dados") = 0
1080:             MsgAviso("Nenhuma contagem selecionada.")
1081:             RETURN
1082:         ENDIF
1083: 
1084:         SELECT cursor_4c_Dados
1085:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1086:         loc_nConferido = TratarNulo(Conferido, "N")
1087: 
1088:         IF loc_nConferido = 1
1089:             MsgAviso("Contagem J" + CHR(225) + " Encerrada. " + ;
1090:                      "Reabra antes de excluir.")
1091:             RETURN
1092:         ENDIF
1093: 
1094:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o desta contagem?", ;
1095:                         "Confirmar Exclus" + CHR(227) + "o")
1096:             RETURN
1097:         ENDIF
1098: 
1099:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
1100:             RETURN
1101:         ENDIF
1102: 
1103:         IF THIS.this_oBusinessObject.Excluir()
1104:             MsgInfo("Contagem exclu" + CHR(237) + "da com sucesso!")
1105:             THIS.this_cFiltroLista = ""
1106:             THIS.CarregarLista()
1107:         ENDIF
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     * BtnBuscarClick - Filtra lista de contagens por codigo ou vendedor
1112:     *==========================================================================
1113:     PROCEDURE BtnBuscarClick()
1114:         LOCAL loc_cBusca, loc_cFiltro
1115:         loc_cBusca = INPUTBOX("Pesquisar contagem (c" + CHR(243) + "digo ou vendedor):", ;
1116:                                "Buscar Contagem", "")
1117:         loc_cFiltro = ""
1118:         IF !EMPTY(loc_cBusca)
1119:             loc_cBusca  = ALLTRIM(loc_cBusca)
1120:             loc_cFiltro = "a.Cods LIKE '%" + loc_cBusca + "%'" + ;
1121:                           " OR a.Vends LIKE '%" + loc_cBusca + "%'" + ;
1122:                           " OR b.Rclis LIKE '%" + loc_cBusca + "%'"
1123:         ENDIF
1124:         THIS.this_cFiltroLista = loc_cFiltro
1125:         THIS.CarregarLista()
1126:     ENDPROC
1127: 
1128:     *==========================================================================
1129:     * BtnEncerrarClick - Fecha o formulario
1130:     *==========================================================================
1131:     PROCEDURE BtnEncerrarClick()
1132:         THIS.Release()
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * BtnSalvarClick - Salva contagem (Confirmar na Page2)
1137:     * Valida vendedor, transfere Form->BO e chama Salvar()
1138:     *==========================================================================
1139:     PROCEDURE BtnSalvarClick()
1140:         LOCAL loc_oPagina
1141:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1142: 
1143:         *-- Validacao: Vendedor obrigatorio em INCLUIR/ALTERAR
1144:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1145:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
1146:                 MsgAviso("Vendedor obrigat" + CHR(243) + "rio!")
1147:                 loc_oPagina.txt_4c_Conta.SetFocus()
1148:                 RETURN
1149:             ENDIF
1150:         ENDIF
1151: 
1152:         THIS.FormParaBO()
1153: 
1154:         IF THIS.this_oBusinessObject.Salvar()
1155:             MsgInfo("Contagem salva com sucesso!")
1156:             THIS.this_cFiltroLista = ""
1157:             THIS.AlternarPagina(1)
1158:         ENDIF
1159:     ENDPROC
1160: 
1161:     *==========================================================================
1162:     * BtnCancelarClick - Cancela e volta para lista
1163:     *==========================================================================
1164:     PROCEDURE BtnCancelarClick()
1165:         THIS.AlternarPagina(1)
1166:     ENDPROC
1167: 
1168:     *==========================================================================
1169:     * BtnEspelhoClick - Recarrega csSigCdCri com produtos do estoque (SigMvEst)
1170:     * Bloqueia se contagem encerrada; pede confirmacao antes de recarregar
1171:     *==========================================================================
1172:     PROCEDURE BtnEspelhoClick()
1173:         LOCAL loc_nConferido
1174: 
1175:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
1176:                 OR RECCOUNT("cursor_4c_Dados") = 0
1177:             MsgAviso("Nenhuma contagem selecionada.")
1178:             RETURN
1179:         ENDIF
1180: 
1181:         SELECT cursor_4c_Dados
1182:         loc_nConferido = TratarNulo(Conferido, "N")
1183: 
1184:         IF loc_nConferido = 1
1185:             MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
1186:             RETURN
1187:         ENDIF
1188: 
1189:         IF !MsgConfirma("Deseja gerar espelho do estoque para esta contagem?", "Espelho")
1190:             RETURN
1191:         ENDIF
1192: 
1193:         IF THIS.this_oBusinessObject.CarregarProdutosEstoque()
1194:             MsgInfo("Espelho de estoque gerado com sucesso!")
1195:             THIS.CarregarGridItens()
1196:         ENDIF
1197:     ENDPROC
1198: 
1199:     *==========================================================================
1200:     * BtnFecharContagemClick - Encerra contagem (Conferido=1)
1201:     * Pede confirmacao e bloqueia se ja encerrada
1202:     *==========================================================================
1203:     PROCEDURE BtnFecharContagemClick()
1204:         LOCAL loc_cCods, loc_nConferido
1205: 
1206:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
1207:                 OR RECCOUNT("cursor_4c_Dados") = 0
1208:             MsgAviso("Nenhuma contagem selecionada.")
1209:             RETURN
1210:         ENDIF
1211: 
1212:         SELECT cursor_4c_Dados
1213:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1214:         loc_nConferido = TratarNulo(Conferido, "N")
1215: 
1216:         IF loc_nConferido = 1
1217:             MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
1218:             RETURN
1219:         ENDIF
1220: 
1221:         IF !MsgConfirma("Esta Contagem ser" + CHR(225) + " Finalizada. " + ;
1222:                         "Deseja encerrar a Contagem???", ;
1223:                         "ATEN" + CHR(199) + CHR(195) + "O !!!")
1224:             RETURN
1225:         ENDIF
1226: 
1227:         IF THIS.this_oBusinessObject.EncerrarContagem(loc_cCods)
1228:             MsgInfo("Contagem encerrada com sucesso!")
1229:             THIS.CarregarLista()
1230:         ENDIF
1231:     ENDPROC
1232: 
1233:     *==========================================================================
1234:     * BtnAbrirContagemClick - Reabre contagem encerrada (Conferido=0)
1235:     * Pede confirmacao e bloqueia se ainda nao encerrada
1236:     *==========================================================================
1237:     PROCEDURE BtnAbrirContagemClick()
1238:         LOCAL loc_cCods, loc_nConferido
1239: 
1240:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
1241:                 OR RECCOUNT("cursor_4c_Dados") = 0
1242:             MsgAviso("Nenhuma contagem selecionada.")
1243:             RETURN
1244:         ENDIF
1245: 
1246:         SELECT cursor_4c_Dados
1247:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1248:         loc_nConferido = TratarNulo(Conferido, "N")
1249: 
1250:         IF loc_nConferido = 0
1251:             MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada!!!")
1252:             RETURN
1253:         ENDIF
1254: 
1255:         IF !MsgConfirma("Esta Contagem ser" + CHR(225) + " Aberta Novamente. " + ;
1256:                         "Deseja Continuar a Contagem???", ;
1257:                         "ATEN" + CHR(199) + CHR(195) + "O !!!")
1258:             RETURN
1259:         ENDIF
1260: 
1261:         IF THIS.this_oBusinessObject.ReabrirContagem(loc_cCods)
1262:             MsgInfo("Contagem reaberta com sucesso!")
1263:             THIS.CarregarLista()
1264:         ENDIF
1265:     ENDPROC
1266: 
1267:     *==========================================================================
1268:     * ValidarConta - LostFocus do txt_4c_Conta: busca vendedor pelo codigo
1269:     * Preenche txt_4c_DConta com nome; se multiplos resultados abre picker
1270:     *==========================================================================
1271:     PROCEDURE ValidarConta
1272:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1273:         LOCAL loc_oPagina, loc_cCodigo
1274:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1275:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1276: 
1277:         IF EMPTY(loc_cCodigo)
1278:             loc_oPagina.txt_4c_DConta.Value = ""
1279:             THIS.this_oBusinessObject.this_cVends    = ""
1280:             THIS.this_oBusinessObject.this_cDesVends = ""
1281:             RETURN
1282:         ENDIF
1283: 
1284:         IF !THIS.this_oBusinessObject.BuscarVendedores(loc_cCodigo, "Iclis")
1285:             RETURN
1286:         ENDIF
1287: 
1288:         IF !USED("cursor_4c_Vendedores") OR RECCOUNT("cursor_4c_Vendedores") = 0
1289:             MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
1290:             loc_oPagina.txt_4c_Conta.Value  = ""
1291:             loc_oPagina.txt_4c_DConta.Value = ""
1292:             IF USED("cursor_4c_Vendedores")
1293:                 USE IN cursor_4c_Vendedores
1294:             ENDIF
1295:             loc_oPagina.txt_4c_Conta.SetFocus()
1296:             RETURN
1297:         ENDIF
1298: 
1299:         IF RECCOUNT("cursor_4c_Vendedores") = 1
1300:             SELECT cursor_4c_Vendedores
1301:             GO TOP
1302:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1303:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1304:             THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1305:             THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1306:             IF USED("cursor_4c_Vendedores")
1307:                 USE IN cursor_4c_Vendedores
1308:             ENDIF
1309:         ELSE
1310:             THIS.AbrirBuscaVendedor(loc_cCodigo)
1311:         ENDIF
1312:     ENDPROC
1313: 
1314:     *==========================================================================
1315:     * AbrirBuscaVendedor - Abre FormBuscaAuxiliar no cursor_4c_Vendedores
1316:     * Chamado quando ha multiplos resultados no lookup de Vendedor
1317:     *==========================================================================
1318:     PROTECTED PROCEDURE AbrirBuscaVendedor(par_cValorInicial)
1319:         LOCAL loc_oBusca, loc_oPagina
1320:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1321: 
1322:         THIS.this_oBusinessObject.BuscarVendedores(par_cValorInicial, "Iclis")
1323: 
1324:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1325: 
1326:         IF VARTYPE(loc_oBusca) = "O"
1327:             loc_oBusca.this_cCursorDestino = "cursor_4c_Vendedores"
1328:             loc_oBusca.this_cTitulo        = "Selecionar Vendedor"
1329:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1330:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
1331:             loc_oBusca.Show()
1332: 
1333:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Vendedores")
1334:                 SELECT cursor_4c_Vendedores
1335:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1336:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1337:                 THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1338:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1339:             ELSE
1340:                 loc_oPagina.txt_4c_Conta.Value  = ""
1341:                 loc_oPagina.txt_4c_DConta.Value = ""
1342:             ENDIF
1343: 
1344:             loc_oBusca.Release()
1345:         ENDIF
1346: 
1347:         IF USED("cursor_4c_Vendedores")
1348:             USE IN cursor_4c_Vendedores
1349:         ENDIF
1350:     ENDPROC
1351: 
1352:     *==========================================================================
1353:     * FormParaBO - Transfere valores da Page2 para o Business Object
1354:     * Campos de itens (grd_4c_Dados) gerenciados via csSigCdCri diretamente
1355:     *==========================================================================
1356:     PROTECTED PROCEDURE FormParaBO()
1357:         LOCAL loc_oPagina
1358:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1359: 
1360:         TRY
1361:             THIS.this_oBusinessObject.this_cVends    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1362:             THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
1363:             THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
1364:         CATCH TO loException
1365:             MostrarErro(loException, "Formcrf.FormParaBO")
1366:         ENDTRY
1367:     ENDPROC
1368: 
1369:     *==========================================================================
1370:     * BOParaForm - Transfere valores do Business Object para a Page2
1371:     *==========================================================================
1372:     PROTECTED PROCEDURE BOParaForm()
1373:         LOCAL loc_oPagina
1374:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1375: 
1376:         TRY
1377:             loc_oPagina.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
1378:             loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
1379:             loc_oPagina.txt_4c_DConta.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDesVends)
1380:         CATCH TO loException
1381:             MostrarErro(loException, "Formcrf.BOParaForm")
1382:         ENDTRY
1383:     ENDPROC
1384: 
1385:     *==========================================================================
1386:     * LimparCampos - Limpa valores dos campos da Page2
1387:     *==========================================================================
1388:     PROTECTED PROCEDURE LimparCampos()
1389:         LOCAL loc_oPagina
1390:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1391: 
1392:         TRY
1393:             loc_oPagina.txt_4c_Codigo.Value   = ""
1394:             loc_oPagina.txt_4c_Conta.Value    = ""
1395:             loc_oPagina.txt_4c_DConta.Value   = ""
1396:             loc_oPagina.txt_4c_Busca.Value    = ""
1397:             loc_oPagina.txt_4c_TotQt.Value    = 0
1398:             loc_oPagina.txt_4c_DContas.Value  = ""
1399:             loc_oPagina.opt_4c_OptBusca.Value = 1
1400:             loc_oPagina.img_4c_ImgJpg.Visible = .F.
1401:             loc_oPagina.img_4c_ImgJpg.Picture = ""
1402:         CATCH TO loException
1403:             MostrarErro(loException, "Formcrf.LimparCampos")
1404:         ENDTRY
1405:     ENDPROC
1406: 
1407:     *==========================================================================
1408:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
1409:     * txt_4c_Codigo: sempre readonly
1410:     * txt_4c_Conta: editavel so em INCLUIR
1411:     * txt_4c_Busca/TotQt: editaveis em INCLUIR/ALTERAR
1412:     * grd_4c_Dados.Column2 (QtdCtg): editavel em INCLUIR/ALTERAR
1413:     * txt_4c_DContas: sempre readonly
1414:     *==========================================================================
1415:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1416:         LOCAL loc_oPagina, loc_lEditarConta
1417:         loc_oPagina      = THIS.pgf_4c_Paginas.Page2
1418:         loc_lEditarConta = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
1419: 
1420:         TRY
1421:             *-- txt_4c_Codigo: sempre readonly
1422:             loc_oPagina.txt_4c_Codigo.ReadOnly  = .T.
1423:             loc_oPagina.txt_4c_Codigo.Enabled   = .F.
1424:             loc_oPagina.txt_4c_Codigo.BackColor = RGB(224, 224, 224)
1425: 
1426:             *-- txt_4c_Conta: editavel apenas no modo INCLUIR
1427:             loc_oPagina.txt_4c_Conta.ReadOnly  = !loc_lEditarConta
1428:             loc_oPagina.txt_4c_Conta.Enabled   = loc_lEditarConta
1429:             loc_oPagina.txt_4c_Conta.BackColor = IIF(loc_lEditarConta, ;
1430:                 RGB(255, 255, 255), RGB(224, 224, 224))
1431: 
1432:             *-- txt_4c_DConta: sempre readonly (calculado do lookup)
1433:             loc_oPagina.txt_4c_DConta.ReadOnly = .T.
1434:             loc_oPagina.txt_4c_DConta.Enabled  = .F.
1435: 
1436:             *-- txt_4c_Busca: editavel em INCLUIR/ALTERAR
1437:             loc_oPagina.txt_4c_Busca.ReadOnly  = !par_lHabilitar
1438:             loc_oPagina.txt_4c_Busca.Enabled   = par_lHabilitar
1439:             loc_oPagina.txt_4c_Busca.BackColor = IIF(par_lHabilitar, ;
1440:                 RGB(255, 255, 255), RGB(224, 224, 224))
1441: 
1442:             *-- txt_4c_TotQt: editavel em INCLUIR/ALTERAR
1443:             loc_oPagina.txt_4c_TotQt.ReadOnly  = !par_lHabilitar
1444:             loc_oPagina.txt_4c_TotQt.Enabled   = par_lHabilitar
1445:             loc_oPagina.txt_4c_TotQt.BackColor = IIF(par_lHabilitar, ;
1446:                 RGB(255, 255, 255), RGB(224, 224, 224))
1447: 
1448:             *-- txt_4c_DContas: sempre readonly (descricao do produto selecionado)
1449:             loc_oPagina.txt_4c_DContas.ReadOnly = .T.
1450:             loc_oPagina.txt_4c_DContas.Enabled  = .F.
1451: 
1452:             *-- grd_4c_Dados.Column2 (QtdCtg): editavel em INCLUIR/ALTERAR
1453:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1454:                 loc_oPagina.grd_4c_Dados.Column2.ReadOnly = !par_lHabilitar
1455:             ENDIF

*-- Linhas 1466 a 1532:
1466:     *==========================================================================
1467:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
1468:     *==========================================================================
1469:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1470:         LOCAL loc_oPag2
1471:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1472: 
1473:         TRY
1474:             DO CASE
1475:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1476:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
1477:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1478:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1479:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
1480:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1481:             ENDCASE
1482:         CATCH TO loException
1483:             *-- Silencioso
1484:         ENDTRY
1485:     ENDPROC
1486: 
1487:     *==========================================================================
1488:     * CarregarGridItens - Vincula grd_4c_Dados ao cursor csSigCdCri e formata
1489:     * RecordSource e ColumnCount fora do WITH (Problema 36)
1490:     * ControlSource e Headers redefinidos apos RecordSource (reset automatico)
1491:     *==========================================================================
1492:     PROTECTED PROCEDURE CarregarGridItens()
1493:         LOCAL loc_oPagina, loc_oGrid, loc_cCursor
1494:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1495: 
1496:         TRY
1497:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1498:                 loc_oGrid   = loc_oPagina.grd_4c_Dados
1499:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1500: 
1501:                 *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
1502:                 loc_oGrid.RecordSource = loc_cCursor
1503:                 loc_oGrid.ColumnCount  = 6
1504: 
1505:                 WITH loc_oGrid
1506:                     .Column1.ControlSource   = loc_cCursor + ".Emps"
1507:                     .Column1.Width           = 40
1508:                     .Column1.ReadOnly        = .T.
1509:                     .Column1.Header1.Caption = "Emp."
1510: 
1511:                     .Column2.ControlSource   = loc_cCursor + ".QtdCtg"
1512:                     .Column2.Width           = 60
1513:                     .Column2.ReadOnly        = .F.
1514:                     .Column2.Header1.Caption = "Qtde."
1515: 
1516:                     .Column3.ControlSource   = loc_cCursor + ".qtde"
1517:                     .Column3.Width           = 60
1518:                     .Column3.ReadOnly        = .T.
1519:                     .Column3.Header1.Caption = "Estoque"
1520: 
1521:                     .Column4.ControlSource   = loc_cCursor + ".Grupos"
1522:                     .Column4.Width           = 60
1523:                     .Column4.ReadOnly        = .T.
1524:                     .Column4.Header1.Caption = "Grupo"
1525: 
1526:                     .Column5.ControlSource   = loc_cCursor + ".Estos"
1527:                     .Column5.Width           = 80
1528:                     .Column5.ReadOnly        = .T.
1529:                     .Column5.Header1.Caption = "Conta"
1530: 
1531:                     .Column6.ControlSource   = loc_cCursor + ".Descr"
1532:                     .Column6.Width           = 177

*-- Linhas 1547 a 1720:
1547:     * Busca produto em csSigCdCri por Cod.Barra (opt=1) ou Cpros (opt=2)
1548:     * Posiciona cursor, atualiza txt_4c_DContas e foca txt_4c_TotQt
1549:     *==========================================================================
1550:     PROCEDURE ValidarBusca
1551:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1552:         LOCAL loc_oPagina, loc_cBusca, loc_nOpt, loc_nRecNo
1553:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1554:         loc_cBusca  = ALLTRIM(loc_oPagina.txt_4c_Busca.Value)
1555:         loc_nOpt    = loc_oPagina.opt_4c_OptBusca.Value
1556: 
1557:         IF EMPTY(loc_cBusca) OR !USED("csSigCdCri")
1558:             loc_oPagina.txt_4c_DContas.Value = ""
1559:             RETURN
1560:         ENDIF
1561: 
1562:         TRY
1563:             IF loc_nOpt = 1
1564:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1565:                     WHERE ALLTRIM(CBars) = m.loc_cBusca ;
1566:                     INTO CURSOR csProcuraBusca
1567:             ELSE
1568:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1569:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca ;
1570:                     INTO CURSOR csProcuraBusca
1571:             ENDIF
1572: 
1573:             IF USED("csProcuraBusca") AND !EOF("csProcuraBusca") AND RECCOUNT("csProcuraBusca") > 0
1574:                 SELECT csProcuraBusca
1575:                 GO TOP
1576:                 loc_nRecNo = nRecNo
1577:                 USE IN csProcuraBusca
1578: 
1579:                 SELECT csSigCdCri
1580:                 GO loc_nRecNo
1581:                 loc_oPagina.txt_4c_DContas.Value = ALLTRIM(TratarNulo(Descr, "C"))
1582:                 loc_oPagina.grd_4c_Dados.Refresh()
1583: 
1584:                 IF PEMSTATUS(loc_oPagina.txt_4c_TotQt, "SetFocus", 5)
1585:                     loc_oPagina.txt_4c_TotQt.SetFocus()
1586:                 ENDIF
1587:             ELSE
1588:                 IF USED("csProcuraBusca")
1589:                     USE IN csProcuraBusca
1590:                 ENDIF
1591:                 MsgAviso("Produto n" + CHR(227) + "o encontrado.")
1592:                 loc_oPagina.txt_4c_DContas.Value = ""
1593:                 loc_oPagina.txt_4c_Busca.Value   = ""
1594:                 IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1595:                     loc_oPagina.txt_4c_Busca.SetFocus()
1596:                 ENDIF
1597:             ENDIF
1598:         CATCH TO loException
1599:             IF USED("csProcuraBusca")
1600:                 USE IN csProcuraBusca
1601:             ENDIF
1602:             MostrarErro(loException, "Formcrf.ValidarBusca")
1603:         ENDTRY
1604:     ENDPROC
1605: 
1606:     *==========================================================================
1607:     * ValidarQuantidade - LostFocus de txt_4c_TotQt
1608:     * Grava QtdCtg no cursor csSigCdCri; limpa campos de busca e volta o foco
1609:     *==========================================================================
1610:     PROCEDURE ValidarQuantidade
1611:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1612:         LOCAL loc_oPagina, loc_nQtds, loc_cBusca, loc_nOpt
1613:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1614:         loc_nQtds   = VAL(TRANSFORM(loc_oPagina.txt_4c_TotQt.Value))
1615:         loc_cBusca  = ALLTRIM(loc_oPagina.txt_4c_Busca.Value)
1616:         loc_nOpt    = loc_oPagina.opt_4c_OptBusca.Value
1617: 
1618:         IF EMPTY(loc_cBusca) OR !USED("csSigCdCri")
1619:             RETURN
1620:         ENDIF
1621: 
1622:         TRY
1623:             IF loc_nOpt = 1
1624:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1625:                     WHERE ALLTRIM(CBars) = m.loc_cBusca
1626:             ELSE
1627:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1628:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca
1629:             ENDIF
1630: 
1631:             loc_oPagina.txt_4c_Busca.Value    = ""
1632:             loc_oPagina.txt_4c_TotQt.Value    = 0
1633:             loc_oPagina.txt_4c_DContas.Value  = ""
1634:             loc_oPagina.img_4c_ImgJpg.Visible = .F.
1635:             loc_oPagina.img_4c_ImgJpg.Picture = ""
1636:             loc_oPagina.grd_4c_Dados.Refresh()
1637: 
1638:             IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1639:                 loc_oPagina.txt_4c_Busca.SetFocus()
1640:             ENDIF
1641:         CATCH TO loException
1642:             MostrarErro(loException, "Formcrf.ValidarQuantidade")
1643:         ENDTRY
1644:     ENDPROC
1645: 
1646:     *==========================================================================
1647:     * GridDadosAfterRowColChange - AfterRowColChange do grd_4c_Dados
1648:     * Atualiza descricao e imagem do produto ao navegar no grid
1649:     *==========================================================================
1650:     PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
1651:         LOCAL loc_oPagina, loc_cCpros, loc_cDescr
1652:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1653: 
1654:         IF !USED("csSigCdCri") OR EOF("csSigCdCri")
1655:             RETURN
1656:         ENDIF
1657: 
1658:         TRY
1659:             SELECT csSigCdCri
1660:             loc_cCpros = ALLTRIM(TratarNulo(Cpros, "C"))
1661:             loc_cDescr = ALLTRIM(TratarNulo(Descr, "C"))
1662: 
1663:             loc_oPagina.txt_4c_DContas.Value = loc_cDescr
1664: 
1665:             IF !EMPTY(loc_cCpros)
1666:                 THIS.CarregarImagemProduto(loc_cCpros)
1667:             ELSE
1668:                 loc_oPagina.img_4c_ImgJpg.Visible = .F.
1669:                 loc_oPagina.img_4c_ImgJpg.Picture = ""
1670:             ENDIF
1671:         CATCH TO loException
1672:             MostrarErro(loException, "Formcrf.GridDadosAfterRowColChange")
1673:         ENDTRY
1674:     ENDPROC
1675: 
1676:     *==========================================================================
1677:     * CarregarImagemProduto - Busca FigJpgs em SigCdPro e exibe na img_4c_ImgJpg
1678:     * STRCONV(base64, 14) converte para binario uma unica vez + STRTOFILE salva temp
1679:     *==========================================================================
1680:     PROTECTED PROCEDURE CarregarImagemProduto(par_cCpros)
1681:         LOCAL loc_oPagina, loc_cBase64, loc_cTmpFile, loc_cSQL, loc_nRetSQL
1682:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1683: 
1684:         TRY
1685:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro" + ;
1686:                           " WHERE RTRIM(Cpros) = " + EscaparSQL(par_cCpros)
1687:             loc_nRetSQL = SQLEXEC(gnConnHandle, loc_cSQL, "csImgProduto")
1688: 
1689:             IF loc_nRetSQL > 0 AND USED("csImgProduto") AND ;
1690:                     !EOF("csImgProduto") AND !EMPTY(ALLTRIM(csImgProduto.FigJpgs))
1691: 
1692:                 SELECT csImgProduto
1693:                 GO TOP
1694:                 loc_cBase64 = ALLTRIM(FigJpgs)
1695: 
1696:                 IF "base64," $ loc_cBase64
1697:                     loc_cBase64 = SUBSTR(loc_cBase64, AT("base64,", loc_cBase64) + 7)
1698:                 ENDIF
1699: 
1700:                 IF !EMPTY(loc_cBase64)
1701:                     loc_cTmpFile = SYS(2023) + "\4c_img_tmp.jpg"
1702:                     STRTOFILE(STRCONV(loc_cBase64, 14), loc_cTmpFile)
1703: 
1704:                     IF FILE(loc_cTmpFile)
1705:                         loc_oPagina.img_4c_ImgJpg.Picture = loc_cTmpFile
1706:                         loc_oPagina.img_4c_ImgJpg.Visible = .T.
1707:                     ELSE
1708:                         loc_oPagina.img_4c_ImgJpg.Visible = .F.
1709:                         loc_oPagina.img_4c_ImgJpg.Picture = ""
1710:                     ENDIF
1711:                 ELSE
1712:                     loc_oPagina.img_4c_ImgJpg.Visible = .F.
1713:                     loc_oPagina.img_4c_ImgJpg.Picture = ""
1714:                 ENDIF
1715:             ELSE
1716:                 loc_oPagina.img_4c_ImgJpg.Visible = .F.
1717:                 loc_oPagina.img_4c_ImgJpg.Picture = ""
1718:             ENDIF
1719: 
1720:             IF USED("csImgProduto")

*-- Linhas 1731 a 1788:
1731:     ENDPROC
1732: 
1733:     *==========================================================================
1734:     * OptBuscaChanged - InteractiveChange do opt_4c_OptBusca
1735:     * Limpa campo busca e foca nele ao trocar o tipo de pesquisa
1736:     *==========================================================================
1737:     PROCEDURE OptBuscaChanged()
1738:         LOCAL loc_oPagina
1739:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1740: 
1741:         TRY
1742:             loc_oPagina.txt_4c_Busca.Value   = ""
1743:             loc_oPagina.txt_4c_DContas.Value  = ""
1744:             IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1745:                 loc_oPagina.txt_4c_Busca.SetFocus()
1746:             ENDIF
1747:         CATCH TO loException
1748:             MostrarErro(loException, "Formcrf.OptBuscaChanged")
1749:         ENDTRY
1750:     ENDPROC
1751: 
1752:     *==========================================================================
1753:     * Destroy - Libera recursos ao fechar o form
1754:     *==========================================================================
1755:     PROCEDURE Destroy()
1756:         TRY
1757:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1758:                 THIS.this_oBusinessObject = .NULL.
1759:             ENDIF
1760: 
1761:             IF USED("cursor_4c_Dados")
1762:                 USE IN cursor_4c_Dados
1763:             ENDIF
1764:             IF USED("csSigCdCri")
1765:                 USE IN csSigCdCri
1766:             ENDIF
1767:             IF USED("cursor_4c_Vendedores")
1768:                 USE IN cursor_4c_Vendedores
1769:             ENDIF
1770:             IF USED("csImgProduto")
1771:                 USE IN csImgProduto
1772:             ENDIF
1773:             IF USED("csProcuraBusca")
1774:                 USE IN csProcuraBusca
1775:             ENDIF
1776: 
1777:             SET SYSMENU TO DEFAULT
1778:             RELEASE POPUPS popCadastros, popRelatorios, popMovimentos, popFinanceiro, popOperacional
1779:             DO CriarMenuPrincipal
1780: 
1781:         CATCH TO loException
1782:             *-- Silencioso no Destroy
1783:         ENDTRY
1784: 
1785:         DODEFAULT()
1786:     ENDPROC
1787: 
1788: ENDDEFINE


### BO (C:\4c\projeto\app\classes\crfBO.prg):
*============================================================================
* crfBO.prg - Business Object para Contagem de Referencia (SigCdCrf)
* Herda de BusinessBase
* Tabela principal: SigCdCrf (cabecalho da contagem)
* Tabela detalhe  : SigCdCri (itens/produtos da contagem)
*============================================================================

DEFINE CLASS crfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdCrf (cabecalho da contagem)
    *--------------------------------------------------------------------------
    this_cCods      = ""    && PK: Codigo da contagem C(10) - gerado por fGerUniqueKey
    this_cEmps      = ""    && Empresa C(3)
    this_cVends     = ""    && Codigo do vendedor C(10) - FK SigCdCli.Iclis
    this_cDesVends  = ""    && Nome do vendedor - virtual do JOIN com SigCdCli.Rclis
    this_dDatas     = {}    && Data da contagem (Date)
    this_nConferido = 0     && Status: 0=contagem aberta, 1=contagem encerrada
    this_cIdChaves  = ""    && Identificador unico do cabecalho - gerado por fUniqueIds

    *--------------------------------------------------------------------------
    * Propriedades auxiliares para operacao
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""           && Grupo padrao de vendedores (de SigCdPam.GrPadVens)
    this_cCursorItens  = "csSigCdCri" && Cursor de trabalho (itens vindos de SigMvEst)
    this_cCursorSalvar = "crSigCdCri" && Cursor de gravacao (itens para SigCdCri)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCrf"
            THIS.this_cCampoChave = "Cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crfBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista contagens de referencia da empresa
    * par_cFiltro: filtro WHERE opcional (sem a palavra WHERE)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Cods C(10), Emps C(3), Vends C(10), Datas D, ;
                         Conferido N(1,0), cIdChaves C(10), DesVends C(50))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                           " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                           " FROM SigCdCrf a" + ;
                           " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                           " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Datas DESC, a.Cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crfBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega contagem pelo codigo Cods
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                       " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                       " FROM SigCdCrf a" + ;
                       " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Contagem n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarPorCodigo")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crfBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(Cods,      "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cVends     = TratarNulo(Vends,     "C")
                THIS.this_cDesVends  = TratarNulo(DesVends,  "C")
                THIS.this_dDatas     = TratarNulo(Datas,     "D")
                THIS.this_nConferido = TratarNulo(Conferido, "N")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crfBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigoContagem - Gera proximo codigo numerico para SigCdCrf
    *==========================================================================
    PROTECTED FUNCTION GerarCodigoContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nProxId
        loc_lSucesso = .F.
        loc_nProxId  = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
                       " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0
                SELECT cursor_4c_MaxId
                loc_nProxId = TratarNulo(NextID, "N")
                IF loc_nProxId < 1
                    loc_nProxId = 1
                ENDIF
            ENDIF

            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF

            THIS.this_cCods     = PADL(ALLTRIM(STR(loc_nProxId, 10)), 10, " ")
            THIS.this_cIdChaves = SYS(2015)
            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "crfBO.GerarCodigoContagem")
            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere cabecalho em SigCdCrf e itens de csSigCdCri em SigCdCri
    * Usa transacao explicita pois atualiza duas tabelas
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            IF !THIS.GerarCodigoContagem()
                MostrarErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "crfBO.Inserir")
            ELSE
                THIS.this_dDatas     = DATE()
                THIS.this_nConferido = 0

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                    VALUES (
                        <<EscaparSQL(THIS.this_cCods)>>,
                        <<EscaparSQL(THIS.this_cEmps)>>,
                        <<EscaparSQL(THIS.this_cVends)>>,
                        <<FormatarDataSQL(THIS.this_dDatas)>>,
                        <<EscaparSQL(THIS.this_cIdChaves)>>,
                        <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MostrarErro("Erro ao inserir cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Inserir")
                ELSE
                    loc_lSucesso = THIS.SalvarItensContagem()

                    IF loc_lSucesso
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("INSERT")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crfBO.Inserir")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarItensContagem - Insere cada item de csSigCdCri em SigCdCri
    * Chamado dentro de transacao (Inserir/Atualizar)
    *==========================================================================
    PROTECTED FUNCTION SalvarItensContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        LOCAL loc_cIdChave, loc_cEmps, loc_cGrupos, loc_cEstos
        LOCAL loc_cCpros, loc_nCBars, loc_nQtds, loc_nEstoque, loc_cDescr
        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorItens)
                MostrarErro("Cursor de itens n" + CHR(227) + "o encontrado: " + THIS.this_cCursorItens, "crfBO.SalvarItensContagem")
            ELSE
                loc_lSucesso = .T.

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN WHILE loc_lSucesso
                    loc_cIdChave = SYS(2015)
                    loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
                    loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
                    loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
                    loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
                    loc_nCBars   = TratarNulo(CBars,   "N")
                    loc_nQtds    = TratarNulo(QtdCtg,  "N")
                    loc_nEstoque = TratarNulo(qtde,    "N")
                    loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCri (cIdChaves, Cods, Emps, Grupos, Estos, Cpros, CBars, Qtds, Estoque, Descr)
                        VALUES (
                            <<EscaparSQL(loc_cIdChave)>>,
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(loc_cEmps)>>,
                            <<EscaparSQL(loc_cGrupos)>>,
                            <<EscaparSQL(loc_cEstos)>>,
                            <<EscaparSQL(loc_cCpros)>>,
                            <<FormatarNumeroSQL(loc_nCBars, 0)>>,
                            <<FormatarNumeroSQL(loc_nQtds, 2)>>,
                            <<FormatarNumeroSQL(loc_nEstoque, 2)>>,
                            <<EscaparSQL(loc_cDescr)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao salvar item [" + loc_cCpros + "]:" + CHR(13) + CapturarErroSQL(), "crfBO.SalvarItensContagem")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT (THIS.this_cCursorItens)
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar itens:" + CHR(13) + loException.Message, "crfBO.SalvarItensContagem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Delete+reinsert em SigCdCrf e SigCdCri (mesmo padrao do legado)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            THIS.this_dDatas    = DATE()
            THIS.this_cIdChaves = SYS(2015)

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Exclui itens existentes
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
            ELSE
                *-- Exclui cabecalho existente
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                        VALUES (
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(THIS.this_cEmps)>>,
                            <<EscaparSQL(THIS.this_cVends)>>,
                            <<FormatarDataSQL(THIS.this_dDatas)>>,
                            <<EscaparSQL(THIS.this_cIdChaves)>>,
                            <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao regravar cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                    ELSE
                        loc_lSucesso = THIS.SalvarItensContagem()

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                            loc_lTransacao = .F.
                            THIS.RegistrarAuditoria("UPDATE")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crfBO.Atualizar")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui contagem (itens + cabecalho) com verificacao
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            *-- Verifica se a contagem esta encerrada (nao pode excluir encerradas)
            IF THIS.this_nConferido = 1
                MsgAviso("Contagem J" + CHR(225) + " Encerrada. Reabra antes de excluir.")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                    IF loc_nResultado >= 0
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crfBO.ExecutarExclusao")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega grupo padrao de vendedores de SigCdPam
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cGrPadVens = ALLTRIM(TratarNulo(GrPadVens, "C"))

                IF EMPTY(THIS.this_cGrPadVens)
                    MostrarErro("O Grupo Padr" + CHR(227) + "o de Vendedores n" + CHR(227) + "o est" + ;
                                CHR(225) + " configurado nos Par" + CHR(226) + "metros do Sistema.", ;
                                "Configura" + CHR(231) + CHR(227) + "o Incorreta")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MostrarErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados.", "crfBO.CarregarParametros")
            ENDIF

            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros:" + CHR(13) + loException.Message, "crfBO.CarregarParametros")
            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProdutosEstoque - Carrega produtos de SigMvEst em csSigCdCri
    * Usado ao iniciar nova contagem (modo INSERIR)
    *==========================================================================
    PROCEDURE CarregarProdutosEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0" + ;
                       " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar produtos do estoque:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarProdutosEstoque")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar estoque:" + CHR(13) + loException.Message, "crfBO.CarregarProdutosEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarItensContagem - Carrega produtos + mescla com itens de SigCdCri
    * Usado ao editar (ALTERAR) ou visualizar (CONSULTAR) contagem existente
    * par_cCodigo      : codigo da contagem (Cods)
    * par_lSoContados  : .T. = mostra apenas itens que foram contados (CONSULTAR)
    *==========================================================================
    PROCEDURE CarregarItensContagem(par_cCodigo, par_lSoContados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " ISNULL(" + ;
                       "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
                       "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
                       "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
                       "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
                       " AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0"

            IF par_lSoContados
                *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
                loc_cSQL = loc_cSQL + ;
                           " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
                           " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
                           " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
                           " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens da contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarItensContagem")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "crfBO.CarregarItensContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerrarContagem - Define Conferido=1 na contagem especificada
    *==========================================================================
    PROCEDURE EncerrarContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 1" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao encerrar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.EncerrarContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "crfBO.EncerrarContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ReabrirContagem - Define Conferido=0 na contagem especificada
    *==========================================================================
    PROCEDURE ReabrirContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 0" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao reabrir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ReabrirContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao reabrir:" + CHR(13) + loException.Message, "crfBO.ReabrirContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarVendedores - Pesquisa vendedores validos no grupo padrao
    * par_cValor: valor de busca inicial
    * par_cCampo: "Iclis" (por codigo) ou "Rclis" (por nome)
    *==========================================================================
    PROCEDURE BuscarVendedores(par_cValor, par_cCampo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cGrPadVens)
                THIS.CarregarParametros()
            ENDIF

            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF

            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Situas," + ;
                       " a.Cpfs, a.Inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE NOT b.Coletors = 10" + ;
                       " AND a.Grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.Iclis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Vendedores")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Vendedores
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "crfBO.BuscarVendedores")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar vendedores:" + CHR(13) + loException.Message, "crfBO.BuscarVendedores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

