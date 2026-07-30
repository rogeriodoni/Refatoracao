# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'ValidarConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarBusca' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarBusca(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarQuantidade' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarQuantidade(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Vendedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome do Vendedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Encerrada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Qtde., Estoque, Grupo, Conta, Produto. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1785 linhas total):

*-- Linhas 33 a 156:
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
71:                 *-- Carrega dados iniciais (pula durante ValidarUIFidelity)
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF
75: 
76:                 THIS.pgf_4c_Paginas.Visible = .T.
77:                 THIS.pgf_4c_Paginas.ActivePage = 1
78:                 THIS.this_cModoAtual = "LISTA"
79:                 loc_lResultado = .T.
80:             ENDIF
81: 
82:         CATCH TO loException
83:             MostrarErro(loException, "Formcrf.InicializarForm")
84:         ENDTRY
85: 
86:         RETURN loc_lResultado
87:     ENDPROC
88: 
89:     *==========================================================================
90:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
91:     * Usa Top=-29 para esconder as abas (padrao frmcadastro)
92:     * TODOS os controles dentro das Pages devem compensar +29 no Top
93:     *==========================================================================
94:     PROTECTED PROCEDURE ConfigurarPageFrame()
95:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
96: 
97:         WITH THIS.pgf_4c_Paginas
98:             .PageCount  = 2
99:             .Top        = -29
100:             .Left       = 0
101:             .Width      = 1003
102:             .Height     = 635
103:             .Tabs       = .F.
104:             .Visible    = .T.
105:             .Page1.Caption = "Lista"
106:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
107:             .Page2.Caption = "Dados"
108:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
109:         ENDWITH
110:     ENDPROC
111: 
112:     *==========================================================================
113:     * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
114:     * Top dos controles = Top_original + 29 (compensacao PageFrame)
115:     *==========================================================================
116:     PROTECTED PROCEDURE ConfigurarPaginaLista()
117:         LOCAL loc_oPagina
118:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
119: 
120:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
121:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122: 
123:         *-- Container cabecalho cinza (cntSombra: Top=1, +29 = 30)
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top           = 30
127:             .Left          = -1
128:             .Width         = 1004
129:             .Height        = 80
130:             .BackColor     = RGB(100, 100, 100)
131:             .BackStyle     = 1
132:             .BorderWidth   = 0
133:             .SpecialEffect = 0
134:             .Visible       = .T.
135: 
136:             .AddObject("lbl_4c_Sombra", "Label")
137:             WITH .lbl_4c_Sombra
138:                 .Top       = 15
139:                 .Left      = 10
140:                 .Width     = THIS.Width
141:                 .Height    = 40
142:                 .AutoSize  = .F.
143:                 .FontName  = "Tahoma"
144:                 .FontSize  = 16
145:                 .FontBold  = .T.
146:                 .ForeColor = RGB(0, 0, 0)
147:                 .BackStyle = 0
148:                 .Caption   = "Contagem de Refer" + CHR(234) + "ncia"
149:             ENDWITH
150: 
151:             .AddObject("lbl_4c_Titulo", "Label")
152:             WITH .lbl_4c_Titulo
153:                 .Top       = 18
154:                 .Left      = 10
155:                 .Width     = THIS.Width
156:                 .Height    = 46

*-- Linhas 405 a 470:
405:             .ScrollBars         = 2
406:         ENDWITH
407: 
408:         *-- BINDEVENT: botoes CRUD
409:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
410:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
411:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
412:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
413:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
415: 
416:         *-- BINDEVENT: botoes especiais
417:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_Espelho,        "Click", THIS, "BtnEspelhoClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_FecharContagem, "Click", THIS, "BtnFecharContagemClick")
419:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_AbrirContagem,  "Click", THIS, "BtnAbrirContagemClick")
420: 
421:         THIS.TornarControlesVisiveis(loc_oPagina)
422:     ENDPROC
423: 
424:     *==========================================================================
425:     * ConfigurarPaginaDados - Page2: Campos principais (Fase 5/8 - primeira metade)
426:     * Top dos controles = Top_original + 29 (compensacao PageFrame.Top=-29)
427:     * Fase 5: cnt_4c_Salva + labels + txt_4c_Codigo/Conta/DConta + Line1
428:     * Fase 6: lbl_4c_Label5/7 + txt_4c_Busca/TotQt/DContas + opt + grd + img + shp
429:     *==========================================================================
430:     PROTECTED PROCEDURE ConfigurarPaginaDados()
431:         LOCAL loc_oPagina
432:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
433: 
434:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
435:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
436: 
437:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Top=11+29=40, Left=817)
438:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
439:         WITH loc_oPagina.cnt_4c_Salva
440:             .Top           = 40
441:             .Left          = 817
442:             .Width         = 160
443:             .Height        = 85
444:             .BackStyle     = 0
445:             .BorderWidth   = 0
446:             .SpecialEffect = 0
447:             .Visible       = .T.
448: 
449:             .AddObject("cmd_4c_Confirmar", "CommandButton")
450:             WITH .cmd_4c_Confirmar
451:                 .Caption         = "Confirmar"
452:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
453:                 .PicturePosition = 13
454:                 .Top             = 5
455:                 .Left            = 5
456:                 .Width           = 75
457:                 .Height          = 75
458:                 .FontName        = "Comic Sans MS"
459:                 .FontSize        = 8
460:                 .FontBold        = .T.
461:                 .FontItalic      = .T.
462:                 .ForeColor       = RGB(90, 90, 90)
463:                 .BackColor       = RGB(255, 255, 255)
464:                 .SpecialEffect   = 0
465:                 .MousePointer    = 15
466:                 .WordWrap        = .T.
467:                 .AutoSize        = .F.
468:             ENDWITH
469: 
470:             .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 697 a 742:
697:             .Value     = 0
698:         ENDWITH
699: 
700:         *-- OptionGroup Opt_Busca (Top=122+29=151, Left=414, Width=117)
701:         *-- Buttons(1): busca por Cod.Barra; Buttons(2): busca por Produto
702:         loc_oPagina.AddObject("opt_4c_OptBusca", "OptionGroup")
703:         WITH loc_oPagina.opt_4c_OptBusca
704:             .Top         = 151
705:             .Left        = 414
706:             .Width       = 122
707:             .Height      = 23
708:             .ButtonCount = 2
709:             .BackStyle   = 0
710:             .BorderStyle = 0
711:             .Value       = 1
712:             .Visible     = .T.
713:         ENDWITH
714:         WITH loc_oPagina.opt_4c_OptBusca.Buttons(1)
715:             .Caption   = "C" + CHR(243) + "d.Barra"
716:             .BackStyle = 0
717:             .Left      = 5
718:             .Top       = 3
719:             .Width     = 55
720:             .AutoSize  = .T.
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .ForeColor = RGB(90, 90, 90)
724:             .Themes    = .F.
725:         ENDWITH
726:         WITH loc_oPagina.opt_4c_OptBusca.Buttons(2)
727:             .Caption   = "Produto"
728:             .BackStyle = 0
729:             .Left      = 63
730:             .Top       = 3
731:             .Width     = 49
732:             .AutoSize  = .T.
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)
736:             .Themes    = .F.
737:         ENDWITH
738: 
739:         *-- Grid GrdLoc = grd_4c_Dados (Top=174+29=203, Left=254, Width=477, Height=396)
740:         *-- Exibe csSigCdCri: Emps|QtdCtg(edit)|qtde|Grupos|Estos|Descr
741:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
742:         loc_oPagina.grd_4c_Dados.ColumnCount = 6

*-- Linhas 823 a 889:
823:             .Value     = ""
824:         ENDWITH
825: 
826:         *-- BINDEVENT: botoes Confirmar/Cancelar
827:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
828:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
829: 
830:         *-- BINDEVENT: lookup Vendedor
831:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
832: 
833:         *-- BINDEVENT: busca de produto, quantidade, grid e opcao de busca
834:         BINDEVENT(loc_oPagina.txt_4c_Busca,    "KeyPress",         THIS, "ValidarBusca")
835:         BINDEVENT(loc_oPagina.txt_4c_TotQt,    "KeyPress",         THIS, "ValidarQuantidade")
836:         BINDEVENT(loc_oPagina.grd_4c_Dados,    "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
837:         BINDEVENT(loc_oPagina.opt_4c_OptBusca, "InteractiveChange", THIS, "OptBuscaChanged")
838: 
839:         THIS.TornarControlesVisiveis(loc_oPagina)
840: 
841:         *-- Imagem do produto permanece invisivel ate selecionar produto com foto
842:         loc_oPagina.img_4c_ImgJpg.Visible = .F.
843:     ENDPROC
844: 
845:     *==========================================================================
846:     * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
847:     * Reconfigura RecordSource, ControlSource e Headers apos cada carga
848:     *==========================================================================
849:     PROCEDURE CarregarLista()
850:         LOCAL loc_lResultado, loc_oGrid
851:         loc_lResultado = .F.
852: 
853:         TRY
854:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
855:                 loc_lResultado = .T.
856:             ELSE
857:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
858:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroLista)
859:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
860: 
861:                     *-- RecordSource + ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
862:                     loc_oGrid.ColumnCount = 3
863:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
864:                     loc_oGrid.ColumnCount  = 5
865: 
866:                     WITH loc_oGrid
867:                         .Column1.ControlSource   = "cursor_4c_Dados.Cods"
868:                         .Column1.Width           = 80
869:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
870: 
871:                         .Column2.ControlSource   = "cursor_4c_Dados.Datas"
872:                         .Column2.Width           = 90
873:                         .Column2.Header1.Caption = "Data"
874: 
875:                         .Column3.ControlSource   = "cursor_4c_Dados.Vends"
876:                         .Column3.Width           = 80
877:                         .Column3.Header1.Caption = "Vendedor"
878: 
879:                         .Column4.ControlSource   = "cursor_4c_Dados.DesVends"
880:                         .Column4.Width           = 400
881:                         .Column4.Header1.Caption = "Nome do Vendedor"
882: 
883:                         .Column5.ControlSource   = "cursor_4c_Dados.Conferido"
884:                         .Column5.Width           = 70
885:                         .Column5.Header1.Caption = "Encerrada"
886:                     ENDWITH
887: 
888:                     THIS.FormatarGridLista(loc_oGrid)
889:                     loc_lResultado = .T.

*-- Linhas 900 a 1454:
900:     *==========================================================================
901:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
902:     *==========================================================================
903:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
904:         LOCAL loc_lResultado
905:         loc_lResultado = .F.
906: 
907:         TRY
908:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
909:                 MostrarErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
910:                     TRANSFORM(par_nPagina), "Formcrf.AlternarPagina")
911:             ELSE
912:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
913: 
914:                 IF par_nPagina = 1
915:                     THIS.this_cModoAtual = "LISTA"
916:                     THIS.CarregarLista()
917:                 ELSE
918:                     THIS.CarregarGridItens()
919:                 ENDIF
920: 
921:                 loc_lResultado = .T.
922:             ENDIF
923:         CATCH TO loException
924:             MostrarErro(loException, "Formcrf.AlternarPagina")
925:         ENDTRY
926: 
927:         RETURN loc_lResultado
928:     ENDPROC
929: 
930:     *==========================================================================
931:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
932:     * Itera Pages de PageFrames e Controls de Containers
933:     *==========================================================================
934:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
935:         LOCAL loc_nI, loc_oObjeto
936: 
937:         FOR loc_nI = 1 TO par_oContainer.ControlCount
938:             loc_oObjeto = par_oContainer.Controls(loc_nI)
939: 
940:             IF VARTYPE(loc_oObjeto) = "O"
941:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
942:                     loc_oObjeto.Visible = .T.
943:                 ENDIF
944: 
945:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
946:                     LOCAL loc_nP
947:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
948:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
949:                     ENDFOR
950:                 ENDIF
951: 
952:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
953:                     THIS.TornarControlesVisiveis(loc_oObjeto)
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
1271:     PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
1272:         LOCAL loc_oPagina, loc_cCodigo
1273:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1274:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1275: 
1276:         IF EMPTY(loc_cCodigo)
1277:             loc_oPagina.txt_4c_DConta.Value = ""
1278:             THIS.this_oBusinessObject.this_cVends    = ""
1279:             THIS.this_oBusinessObject.this_cDesVends = ""
1280:             RETURN
1281:         ENDIF
1282: 
1283:         IF !THIS.this_oBusinessObject.BuscarVendedores(loc_cCodigo, "Iclis")
1284:             RETURN
1285:         ENDIF
1286: 
1287:         IF !USED("cursor_4c_Vendedores") OR RECCOUNT("cursor_4c_Vendedores") = 0
1288:             MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
1289:             loc_oPagina.txt_4c_Conta.Value  = ""
1290:             loc_oPagina.txt_4c_DConta.Value = ""
1291:             IF USED("cursor_4c_Vendedores")
1292:                 USE IN cursor_4c_Vendedores
1293:             ENDIF
1294:             loc_oPagina.txt_4c_Conta.SetFocus()
1295:             RETURN
1296:         ENDIF
1297: 
1298:         IF RECCOUNT("cursor_4c_Vendedores") = 1
1299:             SELECT cursor_4c_Vendedores
1300:             GO TOP
1301:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1302:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1303:             THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1304:             THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1305:             IF USED("cursor_4c_Vendedores")
1306:                 USE IN cursor_4c_Vendedores
1307:             ENDIF
1308:         ELSE
1309:             THIS.AbrirBuscaVendedor(loc_cCodigo)
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     *==========================================================================
1314:     * AbrirBuscaVendedor - Abre FormBuscaAuxiliar no cursor_4c_Vendedores
1315:     * Chamado quando ha multiplos resultados no lookup de Vendedor
1316:     *==========================================================================
1317:     PROTECTED PROCEDURE AbrirBuscaVendedor(par_cValorInicial)
1318:         LOCAL loc_oBusca, loc_oPagina
1319:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1320: 
1321:         THIS.this_oBusinessObject.BuscarVendedores(par_cValorInicial, "Iclis")
1322: 
1323:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1324: 
1325:         IF VARTYPE(loc_oBusca) = "O"
1326:             loc_oBusca.this_cCursorDestino = "cursor_4c_Vendedores"
1327:             loc_oBusca.this_cTitulo        = "Selecionar Vendedor"
1328:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1329:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
1330:             loc_oBusca.Show()
1331: 
1332:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Vendedores")
1333:                 SELECT cursor_4c_Vendedores
1334:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1335:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1336:                 THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1337:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1338:             ELSE
1339:                 loc_oPagina.txt_4c_Conta.Value  = ""
1340:                 loc_oPagina.txt_4c_DConta.Value = ""
1341:             ENDIF
1342: 
1343:             loc_oBusca.Release()
1344:         ENDIF
1345: 
1346:         IF USED("cursor_4c_Vendedores")
1347:             USE IN cursor_4c_Vendedores
1348:         ENDIF
1349:     ENDPROC
1350: 
1351:     *==========================================================================
1352:     * FormParaBO - Transfere valores da Page2 para o Business Object
1353:     * Campos de itens (grd_4c_Dados) gerenciados via csSigCdCri diretamente
1354:     *==========================================================================
1355:     PROTECTED PROCEDURE FormParaBO()
1356:         LOCAL loc_oPagina
1357:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1358: 
1359:         TRY
1360:             THIS.this_oBusinessObject.this_cVends    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1361:             THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
1362:             THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
1363:         CATCH TO loException
1364:             MostrarErro(loException, "Formcrf.FormParaBO")
1365:         ENDTRY
1366:     ENDPROC
1367: 
1368:     *==========================================================================
1369:     * BOParaForm - Transfere valores do Business Object para a Page2
1370:     *==========================================================================
1371:     PROTECTED PROCEDURE BOParaForm()
1372:         LOCAL loc_oPagina
1373:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1374: 
1375:         TRY
1376:             loc_oPagina.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
1377:             loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
1378:             loc_oPagina.txt_4c_DConta.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDesVends)
1379:         CATCH TO loException
1380:             MostrarErro(loException, "Formcrf.BOParaForm")
1381:         ENDTRY
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * LimparCampos - Limpa valores dos campos da Page2
1386:     *==========================================================================
1387:     PROTECTED PROCEDURE LimparCampos()
1388:         LOCAL loc_oPagina
1389:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1390: 
1391:         TRY
1392:             loc_oPagina.txt_4c_Codigo.Value   = ""
1393:             loc_oPagina.txt_4c_Conta.Value    = ""
1394:             loc_oPagina.txt_4c_DConta.Value   = ""
1395:             loc_oPagina.txt_4c_Busca.Value    = ""
1396:             loc_oPagina.txt_4c_TotQt.Value    = 0
1397:             loc_oPagina.txt_4c_DContas.Value  = ""
1398:             loc_oPagina.opt_4c_OptBusca.Value = 1
1399:             loc_oPagina.img_4c_ImgJpg.Visible = .F.
1400:             loc_oPagina.img_4c_ImgJpg.Picture = ""
1401:         CATCH TO loException
1402:             MostrarErro(loException, "Formcrf.LimparCampos")
1403:         ENDTRY
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
1408:     * txt_4c_Codigo: sempre readonly
1409:     * txt_4c_Conta: editavel so em INCLUIR
1410:     * txt_4c_Busca/TotQt: editaveis em INCLUIR/ALTERAR
1411:     * grd_4c_Dados.Column2 (QtdCtg): editavel em INCLUIR/ALTERAR
1412:     * txt_4c_DContas: sempre readonly
1413:     *==========================================================================
1414:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1415:         LOCAL loc_oPagina, loc_lEditarConta
1416:         loc_oPagina      = THIS.pgf_4c_Paginas.Page2
1417:         loc_lEditarConta = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
1418: 
1419:         TRY
1420:             *-- txt_4c_Codigo: sempre readonly
1421:             loc_oPagina.txt_4c_Codigo.ReadOnly  = .T.
1422:             loc_oPagina.txt_4c_Codigo.Enabled   = .F.
1423:             loc_oPagina.txt_4c_Codigo.BackColor = RGB(224, 224, 224)
1424: 
1425:             *-- txt_4c_Conta: editavel apenas no modo INCLUIR
1426:             loc_oPagina.txt_4c_Conta.ReadOnly  = !loc_lEditarConta
1427:             loc_oPagina.txt_4c_Conta.Enabled   = loc_lEditarConta
1428:             loc_oPagina.txt_4c_Conta.BackColor = IIF(loc_lEditarConta, ;
1429:                 RGB(255, 255, 255), RGB(224, 224, 224))
1430: 
1431:             *-- txt_4c_DConta: sempre readonly (calculado do lookup)
1432:             loc_oPagina.txt_4c_DConta.ReadOnly = .T.
1433:             loc_oPagina.txt_4c_DConta.Enabled  = .F.
1434: 
1435:             *-- txt_4c_Busca: editavel em INCLUIR/ALTERAR
1436:             loc_oPagina.txt_4c_Busca.ReadOnly  = !par_lHabilitar
1437:             loc_oPagina.txt_4c_Busca.Enabled   = par_lHabilitar
1438:             loc_oPagina.txt_4c_Busca.BackColor = IIF(par_lHabilitar, ;
1439:                 RGB(255, 255, 255), RGB(224, 224, 224))
1440: 
1441:             *-- txt_4c_TotQt: editavel em INCLUIR/ALTERAR
1442:             loc_oPagina.txt_4c_TotQt.ReadOnly  = !par_lHabilitar
1443:             loc_oPagina.txt_4c_TotQt.Enabled   = par_lHabilitar
1444:             loc_oPagina.txt_4c_TotQt.BackColor = IIF(par_lHabilitar, ;
1445:                 RGB(255, 255, 255), RGB(224, 224, 224))
1446: 
1447:             *-- txt_4c_DContas: sempre readonly (descricao do produto selecionado)
1448:             loc_oPagina.txt_4c_DContas.ReadOnly = .T.
1449:             loc_oPagina.txt_4c_DContas.Enabled  = .F.
1450: 
1451:             *-- grd_4c_Dados.Column2 (QtdCtg): editavel em INCLUIR/ALTERAR
1452:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1453:                 loc_oPagina.grd_4c_Dados.Column2.ReadOnly = !par_lHabilitar
1454:             ENDIF

*-- Linhas 1465 a 1531:
1465:     *==========================================================================
1466:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
1467:     *==========================================================================
1468:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1469:         LOCAL loc_oPag2
1470:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1471: 
1472:         TRY
1473:             DO CASE
1474:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1475:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
1476:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1477:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1478:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
1479:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1480:             ENDCASE
1481:         CATCH TO loException
1482:             *-- Silencioso
1483:         ENDTRY
1484:     ENDPROC
1485: 
1486:     *==========================================================================
1487:     * CarregarGridItens - Vincula grd_4c_Dados ao cursor csSigCdCri e formata
1488:     * RecordSource e ColumnCount fora do WITH (Problema 36)
1489:     * ControlSource e Headers redefinidos apos RecordSource (reset automatico)
1490:     *==========================================================================
1491:     PROTECTED PROCEDURE CarregarGridItens()
1492:         LOCAL loc_oPagina, loc_oGrid, loc_cCursor
1493:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1494: 
1495:         TRY
1496:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1497:                 loc_oGrid   = loc_oPagina.grd_4c_Dados
1498:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1499: 
1500:                 *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
1501:                 loc_oGrid.RecordSource = loc_cCursor
1502:                 loc_oGrid.ColumnCount  = 6
1503: 
1504:                 WITH loc_oGrid
1505:                     .Column1.ControlSource   = loc_cCursor + ".Emps"
1506:                     .Column1.Width           = 40
1507:                     .Column1.ReadOnly        = .T.
1508:                     .Column1.Header1.Caption = "Emp."
1509: 
1510:                     .Column2.ControlSource   = loc_cCursor + ".QtdCtg"
1511:                     .Column2.Width           = 60
1512:                     .Column2.ReadOnly        = .F.
1513:                     .Column2.Header1.Caption = "Qtde."
1514: 
1515:                     .Column3.ControlSource   = loc_cCursor + ".qtde"
1516:                     .Column3.Width           = 60
1517:                     .Column3.ReadOnly        = .T.
1518:                     .Column3.Header1.Caption = "Estoque"
1519: 
1520:                     .Column4.ControlSource   = loc_cCursor + ".Grupos"
1521:                     .Column4.Width           = 60
1522:                     .Column4.ReadOnly        = .T.
1523:                     .Column4.Header1.Caption = "Grupo"
1524: 
1525:                     .Column5.ControlSource   = loc_cCursor + ".Estos"
1526:                     .Column5.Width           = 80
1527:                     .Column5.ReadOnly        = .T.
1528:                     .Column5.Header1.Caption = "Conta"
1529: 
1530:                     .Column6.ControlSource   = loc_cCursor + ".Descr"
1531:                     .Column6.Width           = 177

*-- Linhas 1544 a 1717:
1544:     *==========================================================================
1545:     * ValidarBusca - LostFocus de txt_4c_Busca
1546:     * Busca produto em csSigCdCri por Cod.Barra (opt=1) ou Cpros (opt=2)
1547:     * Posiciona cursor, atualiza txt_4c_DContas e foca txt_4c_TotQt
1548:     *==========================================================================
1549:     PROCEDURE ValidarBusca(par_nKeyCode, par_nShiftAltCtrl)
1550:         LOCAL loc_oPagina, loc_cBusca, loc_nOpt, loc_nRecNo
1551:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1552:         loc_cBusca  = ALLTRIM(loc_oPagina.txt_4c_Busca.Value)
1553:         loc_nOpt    = loc_oPagina.opt_4c_OptBusca.Value
1554: 
1555:         IF EMPTY(loc_cBusca) OR !USED("csSigCdCri")
1556:             loc_oPagina.txt_4c_DContas.Value = ""
1557:             RETURN
1558:         ENDIF
1559: 
1560:         TRY
1561:             IF loc_nOpt = 1
1562:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1563:                     WHERE ALLTRIM(CBars) = m.loc_cBusca ;
1564:                     INTO CURSOR csProcuraBusca
1565:             ELSE
1566:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1567:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca ;
1568:                     INTO CURSOR csProcuraBusca
1569:             ENDIF
1570: 
1571:             IF USED("csProcuraBusca") AND !EOF("csProcuraBusca") AND RECCOUNT("csProcuraBusca") > 0
1572:                 SELECT csProcuraBusca
1573:                 GO TOP
1574:                 loc_nRecNo = nRecNo
1575:                 USE IN csProcuraBusca
1576: 
1577:                 SELECT csSigCdCri
1578:                 GO loc_nRecNo
1579:                 loc_oPagina.txt_4c_DContas.Value = ALLTRIM(TratarNulo(Descr, "C"))
1580:                 loc_oPagina.grd_4c_Dados.Refresh()
1581: 
1582:                 IF PEMSTATUS(loc_oPagina.txt_4c_TotQt, "SetFocus", 5)
1583:                     loc_oPagina.txt_4c_TotQt.SetFocus()
1584:                 ENDIF
1585:             ELSE
1586:                 IF USED("csProcuraBusca")
1587:                     USE IN csProcuraBusca
1588:                 ENDIF
1589:                 MsgAviso("Produto n" + CHR(227) + "o encontrado.")
1590:                 loc_oPagina.txt_4c_DContas.Value = ""
1591:                 loc_oPagina.txt_4c_Busca.Value   = ""
1592:                 IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1593:                     loc_oPagina.txt_4c_Busca.SetFocus()
1594:                 ENDIF
1595:             ENDIF
1596:         CATCH TO loException
1597:             IF USED("csProcuraBusca")
1598:                 USE IN csProcuraBusca
1599:             ENDIF
1600:             MostrarErro(loException, "Formcrf.ValidarBusca")
1601:         ENDTRY
1602:     ENDPROC
1603: 
1604:     *==========================================================================
1605:     * ValidarQuantidade - LostFocus de txt_4c_TotQt
1606:     * Grava QtdCtg no cursor csSigCdCri; limpa campos de busca e volta o foco
1607:     *==========================================================================
1608:     PROCEDURE ValidarQuantidade(par_nKeyCode, par_nShiftAltCtrl)
1609:         LOCAL loc_oPagina, loc_nQtds, loc_cBusca, loc_nOpt
1610:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1611:         loc_nQtds   = VAL(TRANSFORM(loc_oPagina.txt_4c_TotQt.Value))
1612:         loc_cBusca  = ALLTRIM(loc_oPagina.txt_4c_Busca.Value)
1613:         loc_nOpt    = loc_oPagina.opt_4c_OptBusca.Value
1614: 
1615:         IF EMPTY(loc_cBusca) OR !USED("csSigCdCri")
1616:             RETURN
1617:         ENDIF
1618: 
1619:         TRY
1620:             IF loc_nOpt = 1
1621:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1622:                     WHERE ALLTRIM(CBars) = m.loc_cBusca
1623:             ELSE
1624:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1625:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca
1626:             ENDIF
1627: 
1628:             loc_oPagina.txt_4c_Busca.Value    = ""
1629:             loc_oPagina.txt_4c_TotQt.Value    = 0
1630:             loc_oPagina.txt_4c_DContas.Value  = ""
1631:             loc_oPagina.img_4c_ImgJpg.Visible = .F.
1632:             loc_oPagina.img_4c_ImgJpg.Picture = ""
1633:             loc_oPagina.grd_4c_Dados.Refresh()
1634: 
1635:             IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1636:                 loc_oPagina.txt_4c_Busca.SetFocus()
1637:             ENDIF
1638:         CATCH TO loException
1639:             MostrarErro(loException, "Formcrf.ValidarQuantidade")
1640:         ENDTRY
1641:     ENDPROC
1642: 
1643:     *==========================================================================
1644:     * GridDadosAfterRowColChange - AfterRowColChange do grd_4c_Dados
1645:     * Atualiza descricao e imagem do produto ao navegar no grid
1646:     *==========================================================================
1647:     PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
1648:         LOCAL loc_oPagina, loc_cCpros, loc_cDescr
1649:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1650: 
1651:         IF !USED("csSigCdCri") OR EOF("csSigCdCri")
1652:             RETURN
1653:         ENDIF
1654: 
1655:         TRY
1656:             SELECT csSigCdCri
1657:             loc_cCpros = ALLTRIM(TratarNulo(Cpros, "C"))
1658:             loc_cDescr = ALLTRIM(TratarNulo(Descr, "C"))
1659: 
1660:             loc_oPagina.txt_4c_DContas.Value = loc_cDescr
1661: 
1662:             IF !EMPTY(loc_cCpros)
1663:                 THIS.CarregarImagemProduto(loc_cCpros)
1664:             ELSE
1665:                 loc_oPagina.img_4c_ImgJpg.Visible = .F.
1666:                 loc_oPagina.img_4c_ImgJpg.Picture = ""
1667:             ENDIF
1668:         CATCH TO loException
1669:             MostrarErro(loException, "Formcrf.GridDadosAfterRowColChange")
1670:         ENDTRY
1671:     ENDPROC
1672: 
1673:     *==========================================================================
1674:     * CarregarImagemProduto - Busca FigJpgs em SigCdPro e exibe na img_4c_ImgJpg
1675:     * STRCONV(base64, 14) converte para binario uma unica vez + STRTOFILE salva temp
1676:     *==========================================================================
1677:     PROTECTED PROCEDURE CarregarImagemProduto(par_cCpros)
1678:         LOCAL loc_oPagina, loc_cBase64, loc_cTmpFile, loc_cSQL, loc_nRetSQL
1679:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1680: 
1681:         TRY
1682:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro" + ;
1683:                           " WHERE RTRIM(Cpros) = " + EscaparSQL(par_cCpros)
1684:             loc_nRetSQL = SQLEXEC(gnConnHandle, loc_cSQL, "csImgProduto")
1685: 
1686:             IF loc_nRetSQL > 0 AND USED("csImgProduto") AND ;
1687:                     !EOF("csImgProduto") AND !EMPTY(ALLTRIM(csImgProduto.FigJpgs))
1688: 
1689:                 SELECT csImgProduto
1690:                 GO TOP
1691:                 loc_cBase64 = ALLTRIM(FigJpgs)
1692: 
1693:                 IF "base64," $ loc_cBase64
1694:                     loc_cBase64 = SUBSTR(loc_cBase64, AT("base64,", loc_cBase64) + 7)
1695:                 ENDIF
1696: 
1697:                 IF !EMPTY(loc_cBase64)
1698:                     loc_cTmpFile = SYS(2023) + "\4c_img_tmp.jpg"
1699:                     STRTOFILE(STRCONV(loc_cBase64, 14), loc_cTmpFile)
1700: 
1701:                     IF FILE(loc_cTmpFile)
1702:                         loc_oPagina.img_4c_ImgJpg.Picture = loc_cTmpFile
1703:                         loc_oPagina.img_4c_ImgJpg.Visible = .T.
1704:                     ELSE
1705:                         loc_oPagina.img_4c_ImgJpg.Visible = .F.
1706:                         loc_oPagina.img_4c_ImgJpg.Picture = ""
1707:                     ENDIF
1708:                 ELSE
1709:                     loc_oPagina.img_4c_ImgJpg.Visible = .F.
1710:                     loc_oPagina.img_4c_ImgJpg.Picture = ""
1711:                 ENDIF
1712:             ELSE
1713:                 loc_oPagina.img_4c_ImgJpg.Visible = .F.
1714:                 loc_oPagina.img_4c_ImgJpg.Picture = ""
1715:             ENDIF
1716: 
1717:             IF USED("csImgProduto")

*-- Linhas 1728 a 1785:
1728:     ENDPROC
1729: 
1730:     *==========================================================================
1731:     * OptBuscaChanged - InteractiveChange do opt_4c_OptBusca
1732:     * Limpa campo busca e foca nele ao trocar o tipo de pesquisa
1733:     *==========================================================================
1734:     PROCEDURE OptBuscaChanged()
1735:         LOCAL loc_oPagina
1736:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1737: 
1738:         TRY
1739:             loc_oPagina.txt_4c_Busca.Value   = ""
1740:             loc_oPagina.txt_4c_DContas.Value  = ""
1741:             IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1742:                 loc_oPagina.txt_4c_Busca.SetFocus()
1743:             ENDIF
1744:         CATCH TO loException
1745:             MostrarErro(loException, "Formcrf.OptBuscaChanged")
1746:         ENDTRY
1747:     ENDPROC
1748: 
1749:     *==========================================================================
1750:     * Destroy - Libera recursos ao fechar o form
1751:     *==========================================================================
1752:     PROCEDURE Destroy()
1753:         TRY
1754:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1755:                 THIS.this_oBusinessObject = .NULL.
1756:             ENDIF
1757: 
1758:             IF USED("cursor_4c_Dados")
1759:                 USE IN cursor_4c_Dados
1760:             ENDIF
1761:             IF USED("csSigCdCri")
1762:                 USE IN csSigCdCri
1763:             ENDIF
1764:             IF USED("cursor_4c_Vendedores")
1765:                 USE IN cursor_4c_Vendedores
1766:             ENDIF
1767:             IF USED("csImgProduto")
1768:                 USE IN csImgProduto
1769:             ENDIF
1770:             IF USED("csProcuraBusca")
1771:                 USE IN csProcuraBusca
1772:             ENDIF
1773: 
1774:             SET SYSMENU TO DEFAULT
1775:             RELEASE POPUPS popCadastros, popRelatorios, popMovimentos, popFinanceiro, popOperacional
1776:             DO CriarMenuPrincipal
1777: 
1778:         CATCH TO loException
1779:             *-- Silencioso no Destroy
1780:         ENDTRY
1781: 
1782:         DODEFAULT()
1783:     ENDPROC
1784: 
1785: ENDDEFINE


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

