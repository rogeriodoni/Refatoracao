# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.ImportaPlan()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDES.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1500 linhas total):

*-- Linhas 2 a 152:
2: * FormDES.prg - Cadastro de Cotas de Desconto por Periodo
3: * Tabela : sigcddes | PK: codigo | Tipo: CRUD (frmcadastro)
4: * Fase 8/8 - FORM: Eventos Auxiliares e Consolidacao Final
5: * Metodos completos: Init/InicializarForm/ConfigurarPageFrame/ConfigurarPaginaLista/
6: *   ConfigurarPaginaDados/CarregarLista/AlternarPagina/FormParaBO/BOParaForm/
7: *   HabilitarCampos/LimparCampos/AjustarBotoesPorModo/TornarControlesVisiveis/
8: *   FormatarGridLista/ValidarEmps/RecalcularPdes/ImportaPlan/BtnEncerrarClick/
9: *   BtnIncluirClick/BtnVisualizarClick/BtnAlterarClick/BtnExcluirClick/
10: *   BtnBuscarClick/BtnBtncarregarClick/BtnConfirmarClick/BtnCancelarClick
11: *==============================================================================
12: 
13: DEFINE CLASS FormDES AS FormBase
14: 
15:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
16:     Height      = 600
17:     Width       = 1000
18:     Caption     = "Cadastro de Cotas de Desconto por per" + CHR(237) + "odo"
19:     AutoCenter  = .T.
20:     ShowWindow  = 1
21:     WindowType  = 1
22:     ControlBox  = .F.
23:     TitleBar    = 0
24:     Themes      = .F.
25:     BorderStyle = 2
26: 
27:     *-- Propriedades do formulario
28:     this_oBusinessObject = .NULL.
29:     this_cModoAtual      = "LISTA"
30:     this_cFiltroEmps     = ""    && Filtro de empresa para o grid
31: 
32:     *==========================================================================
33:     * Init
34:     *==========================================================================
35:     PROCEDURE Init()
36:         LOCAL loc_lResultado
37:         loc_lResultado = .F.
38: 
39:         TRY
40:             loc_lResultado = DODEFAULT()
41:         CATCH TO loException
42:             MsgErro("Erro em FormDES.Init:" + CHR(13) + loException.Message, "Erro")
43:         ENDTRY
44: 
45:         RETURN loc_lResultado
46:     ENDPROC
47: 
48:     *==========================================================================
49:     * InicializarForm - Chamado pelo FormBase.Init()
50:     *==========================================================================
51:     PROTECTED PROCEDURE InicializarForm()
52:         LOCAL loc_lResultado
53:         loc_lResultado = .F.
54: 
55:         TRY
56:             THIS.this_oBusinessObject = CREATEOBJECT("DESBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
59:                 MsgErro("Erro ao criar DESBO", "Erro")
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62:                 THIS.ConfigurarPaginaLista()
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65:                 THIS.ConfigurarPaginaDados()
66: 
67:                 IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
68:                     THIS.CarregarLista()
69:                 ENDIF
70: 
71:                 THIS.pgf_4c_Paginas.Visible = .T.
72:                 THIS.pgf_4c_Paginas.ActivePage = 1
73:                 THIS.this_cModoAtual = "LISTA"
74:                 loc_lResultado = .T.
75:             ENDIF
76:         CATCH TO loException
77:             MsgErro("Erro em FormDES.InicializarForm:" + CHR(13) + loException.Message, "Erro")
78:         ENDTRY
79: 
80:         RETURN loc_lResultado
81:     ENDPROC
82: 
83:     *==========================================================================
84:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
85:     *==========================================================================
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .PageCount = 2
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(255, 255, 255)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:         ENDWITH
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
110:     * Legado: cntSombra.Top=1, Grupo_op.Left=538 Width=389, Grade.Top=131 Left=12
111:     *==========================================================================
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Cabecalho cinza escuro (cntSombra do legado)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 12
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width

*-- Linhas 384 a 444:
384:         loc_oPagina.grd_4c_Lista.Column5.Width = 100
385:         loc_oPagina.grd_4c_Lista.Column6.Width = 100
386: 
387:         *-- BINDEVENTs - metodos PUBLIC para funcionar com BINDEVENT
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
394:         BINDEVENT(loc_oPagina.cmd_4c_Btncarregar,               "Click", THIS, "BtnBtncarregarClick")
395: 
396:         THIS.TornarControlesVisiveis(loc_oPagina)
397:     ENDPROC
398: 
399:     *==========================================================================
400:     * ConfigurarPaginaDados - Page2: Botoes + Todos os Campos
401:     * Legado: Grupo_Salva.Left=819, Top=9+29=38
402:     * Campos: Codigo, Emps, Dtini, Dtfin, Valmeta, Valcota, Valdes, Pdes
403:     *==========================================================================
404:     PROTECTED PROCEDURE ConfigurarPaginaDados()
405:         LOCAL loc_oPagina
406:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
407: 
408:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
409:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
410: 
411:         *-- Container Salvar/Cancelar (Grupo_Salva do legado - Left=819, Top=38)
412:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
413:         WITH loc_oPagina.cnt_4c_Salva
414:             .Top         = 38
415:             .Left        = 819
416:             .Width       = 160
417:             .Height      = 85
418:             .BackStyle   = 0
419:             .BorderWidth = 0
420:             .Visible     = .T.
421:         ENDWITH
422: 
423:         *-- Botao Confirmar (Salvar)
424:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
425:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
426:             .Caption         = "Confirmar"
427:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
428:             .PicturePosition = 13
429:             .Top             = 5
430:             .Left            = 5
431:             .Width           = 75
432:             .Height          = 75
433:             .BackColor       = RGB(255, 255, 255)
434:             .ForeColor       = RGB(90, 90, 90)
435:             .FontName        = "Tahoma"
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .FontSize        = 8
439:             .Themes          = .F.
440:             .SpecialEffect   = 0
441:             .MousePointer    = 15
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .Visible         = .T.

*-- Linhas 780 a 1259:
780:             .Visible       = .T.
781:         ENDWITH
782: 
783:         *-- BINDEVENTs dos botoes de Page2
784:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
785:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
786: 
787:         *-- BINDEVENT Empresa: validar ao perder foco
788:         BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
789: 
790:         *-- BINDEVENT Valmeta/Valcota: recalcular % ao sair do campo
791:         *-- Legado: GetValmeta.Valid e getvalcota.Valid atualizam getpdes
792:         BINDEVENT(loc_oPagina.txt_4c_Valmeta, "LostFocus", THIS, "RecalcularPdes")
793:         BINDEVENT(loc_oPagina.txt_4c_Valcota, "LostFocus", THIS, "RecalcularPdes")
794: 
795:         THIS.TornarControlesVisiveis(loc_oPagina)
796:     ENDPROC
797: 
798:     *==========================================================================
799:     * ValidarEmps - Valida codigo de empresa ao sair do campo
800:     * Substitui fAcessoEmpresa() (nao portada) - verifica se Cemps existe em SigCdEmp
801:     *==========================================================================
802:     PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
803:         LOCAL loc_oPg2, loc_cEmps, loc_cSQL, loc_nRes, loc_lResultado
804:         loc_lResultado = .F.
805: 
806:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
807:             RETURN
808:         ENDIF
809: 
810:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
811: 
812:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
813:             RETURN
814:         ENDIF
815: 
816:         loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
817: 
818:         IF EMPTY(loc_cEmps)
819:             RETURN
820:         ENDIF
821: 
822:         TRY
823:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
824:                        " WHERE Cemps = " + EscaparSQL(loc_cEmps)
825:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmp")
826: 
827:             IF loc_nRes > 0 AND USED("cursor_4c_ValidaEmp")
828:                 IF RECCOUNT("cursor_4c_ValidaEmp") = 0
829:                     MsgAviso("Empresa '" + loc_cEmps + "' n" + CHR(227) + "o encontrada.", "")
830:                     loc_oPg2.txt_4c_Emps.Value = ""
831:                     loc_oPg2.txt_4c_Emps.SetFocus()
832:                 ENDIF
833:                 USE IN cursor_4c_ValidaEmp
834:             ENDIF
835:         CATCH TO loException
836:             MsgErro("Erro em ValidarEmps:" + CHR(13) + loException.Message, "Erro")
837:             IF USED("cursor_4c_ValidaEmp")
838:                 USE IN cursor_4c_ValidaEmp
839:             ENDIF
840:         ENDTRY
841:     ENDPROC
842: 
843:     *==========================================================================
844:     * Destroy
845:     *==========================================================================
846:     PROCEDURE Destroy()
847:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
848:             THIS.this_oBusinessObject = .NULL.
849:         ENDIF
850:         DODEFAULT()
851:     ENDPROC
852: 
853:     *==========================================================================
854:     * CarregarLista - Carrega cursor crSigCdDes e vincula ao Grid
855:     * DESBO.Buscar() retorna: codigo, emps, dtini, dtfin, valmeta, valcota,
856:     *   valdes, usualts, dtalts
857:     *==========================================================================
858:     PROCEDURE CarregarLista()
859:         LOCAL loc_lResultado, loc_oGrid
860:         loc_lResultado = .F.
861: 
862:         TRY
863:             IF !THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroEmps)
864:                 loc_lResultado = .F.
865:             ELSE
866:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
867:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
868: 
869:                     loc_oGrid.RecordSource = "crSigCdDes"
870: 
871:                     *-- ControlSources APOS RecordSource (previne auto-bind sobrescrever)
872:                     loc_oGrid.Column1.ControlSource = "crSigCdDes.codigo"
873:                     loc_oGrid.Column2.ControlSource = "crSigCdDes.emps"
874:                     loc_oGrid.Column3.ControlSource = "crSigCdDes.dtini"
875:                     loc_oGrid.Column4.ControlSource = "crSigCdDes.dtfin"
876:                     loc_oGrid.Column5.ControlSource = "crSigCdDes.valmeta"
877:                     loc_oGrid.Column6.ControlSource = "crSigCdDes.valdes"
878: 
879:                     *-- Captions APOS ControlSource (RecordSource reseta os captions)
880:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
881:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
882:                     loc_oGrid.Column3.Header1.Caption = "Dt Inicio"
883:                     loc_oGrid.Column4.Header1.Caption = "Dt final"
884:                     loc_oGrid.Column5.Header1.Caption = "Vr Meta"
885:                     loc_oGrid.Column6.Header1.Caption = "Vr Desconto"
886: 
887:                     THIS.FormatarGridLista(loc_oGrid)
888:                 ENDIF
889:                 loc_lResultado = .T.
890:             ENDIF
891:         CATCH TO loException
892:             MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
893:             loc_lResultado = .F.
894:         ENDTRY
895: 
896:         RETURN loc_lResultado
897:     ENDPROC
898: 
899:     *==========================================================================
900:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
901:     *==========================================================================
902:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
903:         LOCAL loc_lResultado
904:         loc_lResultado = .F.
905: 
906:         IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
907:             RETURN .F.
908:         ENDIF
909: 
910:         TRY
911:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
912: 
913:             IF par_nPagina = 1
914:                 THIS.CarregarLista()
915:             ENDIF
916: 
917:             loc_lResultado = .T.
918:         CATCH TO loException
919:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loException.Message, "Erro")
920:         ENDTRY
921: 
922:         RETURN loc_lResultado
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
927:     * EXCECAO: cmd_4c_Btncarregar inicia oculto (Visible=.F. conforme legado)
928:     * EXCECAO: cnt_4c_Cabecalho gerencia propria visibilidade (nao deve ser forcado)
929:     *==========================================================================
930:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
931:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome
932: 
933:         FOR loc_nI = 1 TO par_oContainer.ControlCount
934:             loc_oObjeto = par_oContainer.Controls(loc_nI)
935: 
936:             IF VARTYPE(loc_oObjeto) = "O"
937:                 loc_cNome = UPPER(loc_oObjeto.Name)
938: 
939:                 *-- Pular controles que devem iniciar ocultos ou gerenciam propria visibilidade
940:                 *-- Recursao antes do LOOP para que filhos ainda sejam processados
941:                 IF INLIST(loc_cNome, "CMD_4C_BTNCARREGAR", "CNT_4C_CABECALHO")
942:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
943:                         THIS.TornarControlesVisiveis(loc_oObjeto)
944:                     ENDIF
945:                     LOOP
946:                 ENDIF
947: 
948:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
949:                     loc_oObjeto.Visible = .T.
950:                 ENDIF
951: 
952:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
953:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
954:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
955:                     ENDFOR
956:                 ENDIF
957: 
958:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
959:                     THIS.TornarControlesVisiveis(loc_oObjeto)
960:                 ENDIF
961:             ENDIF
962:         ENDFOR
963:     ENDPROC
964: 
965:     *==========================================================================
966:     * FormatarGridLista - Formata visual do grid da lista
967:     *==========================================================================
968:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
969:         WITH par_oGrid
970:             .FontName = "Tahoma"
971:             .FontSize = 8
972:         ENDWITH
973:     ENDPROC
974: 
975:     *==========================================================================
976:     * BtnEncerrarClick - Fechar formulario
977:     *==========================================================================
978:     PROCEDURE BtnEncerrarClick()
979:         THIS.Release()
980:     ENDPROC
981: 
982:     *==========================================================================
983:     * BtnIncluirClick - Incluir novo registro
984:     *==========================================================================
985:     PROCEDURE BtnIncluirClick()
986:         THIS.this_oBusinessObject.NovoRegistro()
987:         THIS.LimparCampos()
988:         THIS.this_cModoAtual = "INCLUIR"
989:         THIS.HabilitarCampos(.T.)
990:         THIS.AjustarBotoesPorModo()
991:         THIS.AlternarPagina(2)
992: 
993:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Emps", 5)
994:             THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
995:         ENDIF
996:     ENDPROC
997: 
998:     *==========================================================================
999:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
1000:     *==========================================================================
1001:     PROCEDURE BtnVisualizarClick()
1002:         LOCAL loc_cCodigo
1003:         loc_cCodigo = ""
1004: 
1005:         IF !USED("crSigCdDes") OR RECCOUNT("crSigCdDes") = 0
1006:             MsgAviso("Nenhum registro selecionado.", "")
1007:             RETURN
1008:         ENDIF
1009: 
1010:         SELECT crSigCdDes
1011:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1012: 
1013:         IF EMPTY(loc_cCodigo)
1014:             MsgAviso("Nenhum registro selecionado.", "")
1015:             RETURN
1016:         ENDIF
1017: 
1018:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1019:             THIS.this_cModoAtual = "VISUALIZAR"
1020:             THIS.BOParaForm()
1021:             THIS.HabilitarCampos(.F.)
1022:             THIS.AjustarBotoesPorModo()
1023:             THIS.AlternarPagina(2)
1024: 
1025:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1026:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1027:             ENDIF
1028:         ENDIF
1029:     ENDPROC
1030: 
1031:     *==========================================================================
1032:     * BtnAlterarClick - Alterar registro selecionado
1033:     * Legado: emps/dtini/dtfin nao editaveis apos criacao (When=INSERIR only)
1034:     *==========================================================================
1035:     PROCEDURE BtnAlterarClick()
1036:         LOCAL loc_cCodigo
1037:         loc_cCodigo = ""
1038: 
1039:         IF !USED("crSigCdDes") OR RECCOUNT("crSigCdDes") = 0
1040:             MsgAviso("Nenhum registro selecionado.", "")
1041:             RETURN
1042:         ENDIF
1043: 
1044:         SELECT crSigCdDes
1045:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1046: 
1047:         IF EMPTY(loc_cCodigo)
1048:             MsgAviso("Nenhum registro selecionado.", "")
1049:             RETURN
1050:         ENDIF
1051: 
1052:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1053:             THIS.this_oBusinessObject.EditarRegistro()
1054:             THIS.this_cModoAtual = "ALTERAR"
1055:             THIS.BOParaForm()
1056:             THIS.HabilitarCampos(.T.)
1057:             THIS.AjustarBotoesPorModo()
1058:             THIS.AlternarPagina(2)
1059: 
1060:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmeta", 5)
1061:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Valmeta.SetFocus()
1062:             ENDIF
1063:         ENDIF
1064:     ENDPROC
1065: 
1066:     *==========================================================================
1067:     * BtnExcluirClick - Excluir registro selecionado
1068:     * Regra de negocio (DESBO): exclusao bloqueada se valdes > 0 (cota usada)
1069:     *==========================================================================
1070:     PROCEDURE BtnExcluirClick()
1071:         LOCAL loc_cCodigo, loc_lConfirma
1072:         loc_cCodigo = ""
1073:         loc_lConfirma = .F.
1074: 
1075:         IF !USED("crSigCdDes") OR RECCOUNT("crSigCdDes") = 0
1076:             MsgAviso("Nenhum registro selecionado.", "")
1077:             RETURN
1078:         ENDIF
1079: 
1080:         SELECT crSigCdDes
1081:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1082: 
1083:         IF EMPTY(loc_cCodigo)
1084:             MsgAviso("Nenhum registro selecionado.", "")
1085:             RETURN
1086:         ENDIF
1087: 
1088:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1089:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + ;
1090:                 CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo, ;
1091:                 "Excluir")
1092: 
1093:             IF loc_lConfirma
1094:                 IF THIS.this_oBusinessObject.Excluir()
1095:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1096:                     THIS.CarregarLista()
1097:                 ENDIF
1098:             ENDIF
1099:         ENDIF
1100:     ENDPROC
1101: 
1102:     *==========================================================================
1103:     * BtnBuscarClick - Filtrar grid por empresa
1104:     * Legado: LocateCursor por emps - equivalente: recarregar filtrado
1105:     *==========================================================================
1106:     PROCEDURE BtnBuscarClick()
1107:         LOCAL loc_oBusca, loc_cEmps
1108:         loc_cEmps = ""
1109: 
1110:         TRY
1111:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1112:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", ;
1113:                 "Buscar Empresa")
1114: 
1115:             IF VARTYPE(loc_oBusca) = "O"
1116:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d")
1117:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1118:                 loc_oBusca.Show()
1119: 
1120:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1121:                     SELECT cursor_4c_BuscaEmp
1122:                     loc_cEmps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1123:                 ENDIF
1124: 
1125:                 loc_oBusca.Release()
1126:             ENDIF
1127: 
1128:             IF USED("cursor_4c_BuscaEmp")
1129:                 USE IN cursor_4c_BuscaEmp
1130:             ENDIF
1131: 
1132:             THIS.this_cFiltroEmps = loc_cEmps
1133:             THIS.CarregarLista()
1134:         CATCH TO loException
1135:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
1136:             IF USED("cursor_4c_BuscaEmp")
1137:                 USE IN cursor_4c_BuscaEmp
1138:             ENDIF
1139:         ENDTRY
1140:     ENDPROC
1141: 
1142:     *==========================================================================
1143:     * BtnBtncarregarClick - Importar planilha Excel de cotas
1144:     *==========================================================================
1145:     PROCEDURE BtnBtncarregarClick()
1146:         LOCAL loc_lResultado
1147:         loc_lResultado = THIS.ImportaPlan()
1148: 
1149:         IF loc_lResultado
1150:             MsgInfo("Planilha importada com sucesso.", "")
1151:             THIS.CarregarLista()
1152:         ELSE
1153:             MsgAviso("A Planilha n" + CHR(227) + "o foi importada.", "Aviso")
1154:         ENDIF
1155:     ENDPROC
1156: 
1157:     *==========================================================================
1158:     * BtnConfirmarClick - Salvar registro (chama Inserir ou Atualizar via BO)
1159:     * Legado: fSalvar em Salva.Click - valida campos, faz INSERT/UPDATE e volta lista
1160:     *==========================================================================
1161:     PROCEDURE BtnConfirmarClick()
1162:         TRY
1163:             IF THIS.this_cModoAtual = "VISUALIZAR"
1164:                 THIS.AlternarPagina(1)
1165:                 THIS.this_cModoAtual = "LISTA"
1166:             ELSE
1167:                 IF THIS.FormParaBO()
1168:                     IF THIS.this_oBusinessObject.Salvar()
1169:                         MsgInfo("Registro salvo com sucesso!", "")
1170:                         THIS.this_cModoAtual = "LISTA"
1171:                         THIS.AlternarPagina(1)
1172:                     ENDIF
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loException
1176:             MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loException.Message, "Erro")
1177:         ENDTRY
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * BtnCancelarClick - Cancelar edicao e voltar para lista
1182:     *==========================================================================
1183:     PROCEDURE BtnCancelarClick()
1184:         TRY
1185:             THIS.this_cModoAtual = "LISTA"
1186:             THIS.AlternarPagina(1)
1187:         CATCH TO loException
1188:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
1189:         ENDTRY
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo atual
1194:     *==========================================================================
1195:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1196:         LOCAL loc_oPg2, loc_lVisualizar
1197:         loc_lVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")
1198: 
1199:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Salva", 5)
1200:             RETURN
1201:         ENDIF
1202: 
1203:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1204: 
1205:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1206:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = !loc_lVisualizar
1207:         ENDIF
1208: 
1209:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1210:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1211:         ENDIF
1212:     ENDPROC
1213: 
1214:     *==========================================================================
1215:     * HabilitarCampos - Habilita/desabilita campos conforme modo
1216:     * Legado: getEmps/getDtini/GetDtfin.When = INLIST(pcEscolha,'INSERIR')
1217:     *         getpdes/getvaldes/getcodigo.When = .F. (sempre somente leitura)
1218:     *==========================================================================
1219:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1220:         LOCAL loc_oPg2, loc_lModoIncluir
1221: 
1222:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1223:             RETURN
1224:         ENDIF
1225: 
1226:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1227:         loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")
1228: 
1229:         *-- Codigo: sempre somente leitura (auto-gerado pelo sistema)
1230:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1231:             loc_oPg2.txt_4c_Codigo.Enabled = .F.
1232:         ENDIF
1233: 
1234:         *-- Empresa, Dt Inicio, Dt Final: editavel SOMENTE no modo INCLUIR
1235:         IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1236:             loc_oPg2.txt_4c_Emps.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1237:         ENDIF
1238: 
1239:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1240:             loc_oPg2.txt_4c_Dtini.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1241:         ENDIF
1242: 
1243:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1244:             loc_oPg2.txt_4c_Dtfin.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1245:         ENDIF
1246: 
1247:         *-- Valmeta e Valcota: editavel em INCLUIR e ALTERAR
1248:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1249:             loc_oPg2.txt_4c_Valmeta.Enabled = par_lHabilitar
1250:         ENDIF
1251: 
1252:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1253:             loc_oPg2.txt_4c_Valcota.Enabled = par_lHabilitar
1254:         ENDIF
1255: 
1256:         *-- Pdes e Valdes: sempre somente leitura (calculados/registrados pelo sistema)
1257:         IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1258:             loc_oPg2.txt_4c_Pdes.Enabled = .F.
1259:         ENDIF

*-- Linhas 1266 a 1309:
1266:     *==========================================================================
1267:     * LimparCampos - Limpa todos os campos da Page2
1268:     *==========================================================================
1269:     PROTECTED PROCEDURE LimparCampos()
1270:         LOCAL loc_oPg2
1271: 
1272:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1273:             RETURN
1274:         ENDIF
1275: 
1276:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1277: 
1278:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1279:             loc_oPg2.txt_4c_Codigo.Value  = ""
1280:         ENDIF
1281:         IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1282:             loc_oPg2.txt_4c_Emps.Value    = ""
1283:         ENDIF
1284:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1285:             loc_oPg2.txt_4c_Dtini.Value   = {}
1286:         ENDIF
1287:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1288:             loc_oPg2.txt_4c_Dtfin.Value   = {}
1289:         ENDIF
1290:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1291:             loc_oPg2.txt_4c_Valmeta.Value = 0
1292:         ENDIF
1293:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1294:             loc_oPg2.txt_4c_Valcota.Value = 0
1295:         ENDIF
1296:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
1297:             loc_oPg2.txt_4c_Valdes.Value  = 0
1298:         ENDIF
1299:         IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1300:             loc_oPg2.txt_4c_Pdes.Value    = 0
1301:         ENDIF
1302:     ENDPROC
1303: 
1304:     *==========================================================================
1305:     * FormParaBO - Transfere valores dos campos do form para o BO
1306:     *==========================================================================
1307:     PROTECTED FUNCTION FormParaBO()
1308:         LOCAL loc_oPg2, loc_lResultado
1309:         loc_lResultado = .F.

*-- Linhas 1342 a 1486:
1342:     *==========================================================================
1343:     * BOParaForm - Transfere valores do BO para os campos do form
1344:     *==========================================================================
1345:     PROTECTED PROCEDURE BOParaForm()
1346:         LOCAL loc_oPg2, loc_nValmeta, loc_nValcota
1347: 
1348:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1349:             RETURN
1350:         ENDIF
1351: 
1352:         TRY
1353:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1354: 
1355:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1356:                 loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1357:             ENDIF
1358:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1359:                 loc_oPg2.txt_4c_Emps.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1360:             ENDIF
1361:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1362:                 loc_oPg2.txt_4c_Dtini.Value   = THIS.this_oBusinessObject.this_dDtini
1363:             ENDIF
1364:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1365:                 loc_oPg2.txt_4c_Dtfin.Value   = THIS.this_oBusinessObject.this_dDtfin
1366:             ENDIF
1367:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1368:                 loc_oPg2.txt_4c_Valmeta.Value = THIS.this_oBusinessObject.this_nValmeta
1369:             ENDIF
1370:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1371:                 loc_oPg2.txt_4c_Valcota.Value = THIS.this_oBusinessObject.this_nValcota
1372:             ENDIF
1373:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
1374:                 loc_oPg2.txt_4c_Valdes.Value  = THIS.this_oBusinessObject.this_nValdes
1375:             ENDIF
1376: 
1377:             *-- Calcular e exibir percentual de desconto
1378:             loc_nValmeta = THIS.this_oBusinessObject.this_nValmeta
1379:             loc_nValcota = THIS.this_oBusinessObject.this_nValcota
1380:             IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1381:                 loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
1382:                     loc_nValcota / loc_nValmeta * 100)
1383:             ENDIF
1384:         CATCH TO loException
1385:             MsgErro("Erro em BOParaForm:" + CHR(13) + loException.Message, "Erro")
1386:         ENDTRY
1387:     ENDPROC
1388: 
1389:     *==========================================================================
1390:     * RecalcularPdes - Recalcula percentual de desconto ao mudar valmeta/valcota
1391:     * Legado: getpdes.Value = IIF(valmeta=0, 0.00, valcota/valmeta*100)
1392:     * Chamado via BINDEVENT InteractiveChange de txt_4c_Valmeta e txt_4c_Valcota
1393:     *==========================================================================
1394:     PROCEDURE RecalcularPdes()
1395:         LOCAL loc_oPg2, loc_nValmeta, loc_nValcota
1396:         loc_nValmeta = 0
1397:         loc_nValcota = 0
1398: 
1399:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1400:             RETURN
1401:         ENDIF
1402: 
1403:         TRY
1404:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1405: 
1406:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1407:                 loc_nValmeta = loc_oPg2.txt_4c_Valmeta.Value
1408:             ENDIF
1409:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1410:                 loc_nValcota = loc_oPg2.txt_4c_Valcota.Value
1411:             ENDIF
1412:             IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1413:                 loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
1414:                     loc_nValcota / loc_nValmeta * 100)
1415:             ENDIF
1416:         CATCH TO loException
1417:             MsgErro("Erro em RecalcularPdes:" + CHR(13) + loException.Message, "Erro")
1418:         ENDTRY
1419:     ENDPROC
1420: 
1421:     *==========================================================================
1422:     * ImportaPlan - Importa planilha Excel com cotas de desconto
1423:     * Legado: usa ImpExcelDriver (funcao do framework Fortyus)
1424:     * Layout planilha: col1=empresa(N), col2=periodo YYMM(C), col3=cota(N)
1425:     *==========================================================================
1426:     PROTECTED FUNCTION ImportaPlan()
1427:         LOCAL loc_lcArq, loc_lResultado, loc_lcEmp
1428:         LOCAL loc_lcMes, loc_lnCota, loc_lcField
1429:         LOCAL loc_lcAno, loc_lcMesNum, loc_ldIni, loc_ldFin
1430:         loc_lResultado = .F.
1431: 
1432:         *-- GETFILE fora do TRY (dialogo nativo, sem risco de excecao VFP)
1433:         loc_lcArq = GETFILE("xls*")
1434: 
1435:         IF EMPTY(loc_lcArq)
1436:             RETURN .F.
1437:         ENDIF
1438: 
1439:         TRY
1440:             IF !ImpExcelDriver(loc_lcArq, "Cota Desconto")
1441:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a planilha." + CHR(13) + ;
1442:                     "Verifique se o arquivo e a aba 'Cota Desconto' est" + CHR(227) + "o corretos.", "Aviso")
1443:                 loc_lResultado = .F.
1444:             ELSE
1445:                 IF !USED("xlResults")
1446:                 MsgAviso("Planilha vazia ou formato inv" + CHR(225) + "lido.", "Aviso")
1447:                 loc_lResultado = .F.
1448:             ELSE
1449:                 SELECT xlResults
1450:                 GO TOP
1451: 
1452:                 SCAN
1453:                     *-- Coluna 1: empresa (numerico)
1454:                     loc_lcField = FIELD(1)
1455:                     loc_lcEmp = ALLTRIM(STR(IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)))
1456: 
1457:                     *-- Coluna 2: periodo YYMM (caracter, ex: "2601" = jan/2026)
1458:                     loc_lcField = FIELD(2)
1459:                     loc_lcMes = PADL(ALLTRIM(IIF(INLIST(VARTYPE(&loc_lcField), "C", "M"), &loc_lcField, "")), 6, "0")
1460: 
1461:                     *-- Coluna 3: valor da cota
1462:                     loc_lcField = FIELD(3)
1463:                     loc_lnCota = IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)
1464: 
1465:                     IF !EMPTY(loc_lcEmp) AND LEN(ALLTRIM(loc_lcMes)) >= 4
1466:                         *-- Extrair ano (2 digitos) e mes dos 4 ultimos chars apos padding
1467:                         loc_lcAno    = SUBSTR(loc_lcMes, 3, 2)
1468:                         loc_lcMesNum = RIGHT(loc_lcMes, 2)
1469: 
1470:                         loc_ldIni = DATE(2000 + VAL(loc_lcAno), VAL(loc_lcMesNum), 1)
1471:                         loc_ldFin = GOMONTH(loc_ldIni, 1) - 1
1472: 
1473:                         THIS.this_oBusinessObject.NovoRegistro()
1474:                         THIS.this_oBusinessObject.this_cEmps    = loc_lcEmp
1475:                         THIS.this_oBusinessObject.this_dDtini   = loc_ldIni
1476:                         THIS.this_oBusinessObject.this_dDtfin   = loc_ldFin
1477:                         THIS.this_oBusinessObject.this_nValmeta = 0
1478:                         THIS.this_oBusinessObject.this_nValcota = loc_lnCota
1479:                         THIS.this_oBusinessObject.Salvar()
1480:                     ENDIF
1481:                 ENDSCAN
1482: 
1483:                 IF USED("xlResults")
1484:                     USE IN xlResults
1485:                 ENDIF
1486: 


### BO (C:\4c\projeto\app\classes\DESBO.prg):
*==============================================================================
* DESBO.prg - Business Object para Cadastro de Cotas de Desconto por Periodo
* Tabela : sigcddes
* Herda de: BusinessBase
* Fase 1 : Propriedades e Init
*==============================================================================

DEFINE CLASS DESBO AS BusinessBase

    *-- Propriedades da tabela sigcddes
    this_cCodigo   = ""    && codigo   char(10) PK (auto-gerado no Inserir)
    this_cEmps     = ""    && emps     char(3)
    this_dDtini    = {}    && dtini    datetime
    this_dDtfin    = {}    && dtfin    datetime
    this_nValmeta  = 0     && valmeta  numeric(11,2)
    this_nValcota  = 0     && valcota  numeric(11,2) cota desconto R$
    this_nValcotac = 0     && valcotac numeric(11,2) cota (outra moeda)
    this_nValdes   = 0     && valdes   numeric(11,2) desconto aplicado R$ (readonly)
    this_cUsualts  = ""    && usualts  char(10)
    this_dDtalts   = {}    && dtalts   datetime

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcddes"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "C")
            THIS.this_cEmps     = TratarNulo(emps,     "C")
            THIS.this_dDtini    = TratarNulo(dtini,    "T")
            THIS.this_dDtfin    = TratarNulo(dtfin,    "T")
            THIS.this_nValmeta  = TratarNulo(valmeta,  "N")
            THIS.this_nValcota  = TratarNulo(valcota,  "N")
            THIS.this_nValcotac = TratarNulo(valcotac, "N")
            THIS.this_nValdes   = TratarNulo(valdes,   "N")
            THIS.this_cUsualts  = TratarNulo(usualts,  "C")
            THIS.this_dDtalts   = TratarNulo(dtalts,   "T")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * GerarCodigo - Gera codigo unico: emps(3) + YYMM(4) + seq(3) = 10 chars
    *==========================================================================
    PROTECTED FUNCTION GerarCodigo()
        LOCAL loc_cPrefixo, loc_cSQL, loc_nSeq, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_cPrefixo = ALLTRIM(THIS.this_cEmps) + ;
                SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes WHERE codigo LIKE '" + ;
                loc_cPrefixo + "%'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_nSeq = cursor_4c_GerarCod.cnt + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao gerar c" + CHR(243) + "digo")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *==========================================================================
    * ValidarSobreposicaoPeriodo - Verifica sobreposicao de periodo por empresa
    * par_cCodigoExcluir: codigo a excluir da verificacao (para Atualizar)
    *==========================================================================
    PROTECTED FUNCTION ValidarSobreposicaoPeriodo(par_cEmps, par_dIni, par_dFin, par_cCodigoExcluir)
        LOCAL loc_cSQL, loc_cFiltroExcluir, loc_lSobrepoe
        loc_lSobrepoe = .F.

        TRY
            loc_cFiltroExcluir = ""
            IF !EMPTY(ALLTRIM(par_cCodigoExcluir))
                loc_cFiltroExcluir = " AND codigo <> " + EscaparSQL(par_cCodigoExcluir)
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes" + ;
                " WHERE emps = " + EscaparSQL(par_cEmps) + ;
                " AND CONVERT(DATE, dtini) <= CONVERT(DATE, " + FormatarDataSQL(par_dFin) + ")" + ;
                " AND CONVERT(DATE, dtfin) >= CONVERT(DATE, " + FormatarDataSQL(par_dIni) + ")" + ;
                loc_cFiltroExcluir

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sobrepoe") > 0
                SELECT cursor_4c_Sobrepoe
                loc_lSobrepoe = (cursor_4c_Sobrepoe.cnt > 0)
            ENDIF

            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao validar per" + CHR(237) + "odo")
            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        ENDTRY

        RETURN loc_lSobrepoe
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios e regras de negocio
    * par_lNovoRegistro: .T. = Inserir, .F. = Atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados(par_lNovoRegistro)
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Empresa n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtini)
            MsgAviso("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtfin)
            MsgAviso("Data final n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_dDtini > THIS.this_dDtfin
            MsgAviso("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        LOCAL loc_cCodigoExcluir
        loc_cCodigoExcluir = IIF(par_lNovoRegistro, "", THIS.this_cCodigo)

        IF THIS.ValidarSobreposicaoPeriodo(THIS.this_cEmps, THIS.this_dDtini, THIS.this_dDtfin, loc_cCodigoExcluir)
            MsgAviso("Esse intervalo j" + CHR(225) + " est" + CHR(225) + " cadastrado para essa empresa!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em sigcddes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigo
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.T.)
            RETURN .F.
        ENDIF

        TRY
            loc_cCodigo = THIS.GerarCodigo()
            IF EMPTY(loc_cCodigo)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar c" + CHR(243) + "digo.", "Erro")
            ELSE
                THIS.this_cCodigo  = loc_cCodigo
                THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

                loc_cSQL = "INSERT INTO sigcddes" + ;
                    " (codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)          + ", " + ;
                    EscaparSQL(THIS.this_cEmps)            + ", " + ;
                    FormatarDataSQL(THIS.this_dDtini)      + ", " + ;
                    FormatarDataSQL(THIS.this_dDtfin)      + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValmeta)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcota)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcotac) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValdes)   + ", " + ;
                    EscaparSQL(THIS.this_cUsualts)         + ", " + ;
                    "GETDATE())"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em sigcddes
    * Nota: emps/dtini/dtfin NAO editaveis apos criacao (When=INSERIR only)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.F.)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE sigcddes SET" + ;
                " valmeta  = " + FormatarNumeroSQL(THIS.this_nValmeta)  + "," + ;
                " valcota  = " + FormatarNumeroSQL(THIS.this_nValcota)  + "," + ;
                " valcotac = " + FormatarNumeroSQL(THIS.this_nValcotac) + "," + ;
                " usualts  = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " dtalts   = GETDATE()" + ;
                " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE de sigcddes (chamado por BusinessBase.Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nValdes > 0
            MsgAviso("Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida. Cota j" + CHR(225) + " utilizada!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM sigcddes WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao excluir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT para grid (cursor crSigCdDes)
    * par_cFiltro: codigo de empresa para filtrar (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE emps = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valdes, usualts, dtalts" + ;
                " FROM sigcddes" + loc_cWhere + ;
                " ORDER BY emps, dtini"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdDes") >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT por chave primaria
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts" + ;
                " FROM sigcddes WHERE codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao carregar")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

