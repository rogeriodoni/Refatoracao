# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'ValidarEmps' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDES.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1495 linhas total):

*-- Linhas 2 a 163:
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
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.
157:             .ForeColor = RGB(255, 255, 255)
158:             .BackStyle = 0
159:             .AutoSize  = .F.
160:             .Visible   = .T.
161:         ENDWITH
162: 
163:         *-- Container de botoes CRUD (Grupo_op do legado - Left=538, Width=389)

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
435:             .FontName        = "Comic Sans MS"
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .FontSize        = 8
439:             .Themes          = .F.
440:             .SpecialEffect   = 0
441:             .MousePointer    = 15
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .Visible         = .T.

*-- Linhas 780 a 1254:
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
928:     *==========================================================================
929:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
930:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome
931: 
932:         FOR loc_nI = 1 TO par_oContainer.ControlCount
933:             loc_oObjeto = par_oContainer.Controls(loc_nI)
934: 
935:             IF VARTYPE(loc_oObjeto) = "O"
936:                 loc_cNome = UPPER(loc_oObjeto.Name)
937: 
938:                 *-- Pular Btncarregar - deve iniciar oculto conforme legado
939:                 IF loc_cNome = "CMD_4C_BTNCARREGAR"
940:                     LOOP
941:                 ENDIF
942: 
943:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
944:                     loc_oObjeto.Visible = .T.
945:                 ENDIF
946: 
947:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
948:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
949:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
950:                     ENDFOR
951:                 ENDIF
952: 
953:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
954:                     THIS.TornarControlesVisiveis(loc_oObjeto)
955:                 ENDIF
956:             ENDIF
957:         ENDFOR
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * FormatarGridLista - Formata visual do grid da lista
962:     *==========================================================================
963:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
964:         WITH par_oGrid
965:             .FontName = "Tahoma"
966:             .FontSize = 8
967:         ENDWITH
968:     ENDPROC
969: 
970:     *==========================================================================
971:     * BtnEncerrarClick - Fechar formulario
972:     *==========================================================================
973:     PROCEDURE BtnEncerrarClick()
974:         THIS.Release()
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * BtnIncluirClick - Incluir novo registro
979:     *==========================================================================
980:     PROCEDURE BtnIncluirClick()
981:         THIS.this_oBusinessObject.NovoRegistro()
982:         THIS.LimparCampos()
983:         THIS.this_cModoAtual = "INCLUIR"
984:         THIS.HabilitarCampos(.T.)
985:         THIS.AjustarBotoesPorModo()
986:         THIS.AlternarPagina(2)
987: 
988:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Emps", 5)
989:             THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
995:     *==========================================================================
996:     PROCEDURE BtnVisualizarClick()
997:         LOCAL loc_cCodigo
998:         loc_cCodigo = ""
999: 
1000:         IF !USED("crSigCdDes") OR RECCOUNT("crSigCdDes") = 0
1001:             MsgAviso("Nenhum registro selecionado.", "")
1002:             RETURN
1003:         ENDIF
1004: 
1005:         SELECT crSigCdDes
1006:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1007: 
1008:         IF EMPTY(loc_cCodigo)
1009:             MsgAviso("Nenhum registro selecionado.", "")
1010:             RETURN
1011:         ENDIF
1012: 
1013:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1014:             THIS.this_cModoAtual = "VISUALIZAR"
1015:             THIS.BOParaForm()
1016:             THIS.HabilitarCampos(.F.)
1017:             THIS.AjustarBotoesPorModo()
1018:             THIS.AlternarPagina(2)
1019: 
1020:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1021:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1022:             ENDIF
1023:         ENDIF
1024:     ENDPROC
1025: 
1026:     *==========================================================================
1027:     * BtnAlterarClick - Alterar registro selecionado
1028:     * Legado: emps/dtini/dtfin nao editaveis apos criacao (When=INSERIR only)
1029:     *==========================================================================
1030:     PROCEDURE BtnAlterarClick()
1031:         LOCAL loc_cCodigo
1032:         loc_cCodigo = ""
1033: 
1034:         IF !USED("crSigCdDes") OR RECCOUNT("crSigCdDes") = 0
1035:             MsgAviso("Nenhum registro selecionado.", "")
1036:             RETURN
1037:         ENDIF
1038: 
1039:         SELECT crSigCdDes
1040:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1041: 
1042:         IF EMPTY(loc_cCodigo)
1043:             MsgAviso("Nenhum registro selecionado.", "")
1044:             RETURN
1045:         ENDIF
1046: 
1047:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1048:             THIS.this_oBusinessObject.EditarRegistro()
1049:             THIS.this_cModoAtual = "ALTERAR"
1050:             THIS.BOParaForm()
1051:             THIS.HabilitarCampos(.T.)
1052:             THIS.AjustarBotoesPorModo()
1053:             THIS.AlternarPagina(2)
1054: 
1055:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmeta", 5)
1056:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Valmeta.SetFocus()
1057:             ENDIF
1058:         ENDIF
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * BtnExcluirClick - Excluir registro selecionado
1063:     * Regra de negocio (DESBO): exclusao bloqueada se valdes > 0 (cota usada)
1064:     *==========================================================================
1065:     PROCEDURE BtnExcluirClick()
1066:         LOCAL loc_cCodigo, loc_lConfirma
1067:         loc_cCodigo = ""
1068:         loc_lConfirma = .F.
1069: 
1070:         IF !USED("crSigCdDes") OR RECCOUNT("crSigCdDes") = 0
1071:             MsgAviso("Nenhum registro selecionado.", "")
1072:             RETURN
1073:         ENDIF
1074: 
1075:         SELECT crSigCdDes
1076:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1077: 
1078:         IF EMPTY(loc_cCodigo)
1079:             MsgAviso("Nenhum registro selecionado.", "")
1080:             RETURN
1081:         ENDIF
1082: 
1083:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1084:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + ;
1085:                 CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo, ;
1086:                 "Excluir")
1087: 
1088:             IF loc_lConfirma
1089:                 IF THIS.this_oBusinessObject.Excluir()
1090:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1091:                     THIS.CarregarLista()
1092:                 ENDIF
1093:             ENDIF
1094:         ENDIF
1095:     ENDPROC
1096: 
1097:     *==========================================================================
1098:     * BtnBuscarClick - Filtrar grid por empresa
1099:     * Legado: LocateCursor por emps - equivalente: recarregar filtrado
1100:     *==========================================================================
1101:     PROCEDURE BtnBuscarClick()
1102:         LOCAL loc_oBusca, loc_cEmps
1103:         loc_cEmps = ""
1104: 
1105:         TRY
1106:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1107:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", ;
1108:                 "Buscar Empresa")
1109: 
1110:             IF VARTYPE(loc_oBusca) = "O"
1111:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d")
1112:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1113:                 loc_oBusca.Show()
1114: 
1115:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1116:                     SELECT cursor_4c_BuscaEmp
1117:                     loc_cEmps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1118:                 ENDIF
1119: 
1120:                 loc_oBusca.Release()
1121:             ENDIF
1122: 
1123:             IF USED("cursor_4c_BuscaEmp")
1124:                 USE IN cursor_4c_BuscaEmp
1125:             ENDIF
1126: 
1127:             THIS.this_cFiltroEmps = loc_cEmps
1128:             THIS.CarregarLista()
1129:         CATCH TO loException
1130:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
1131:             IF USED("cursor_4c_BuscaEmp")
1132:                 USE IN cursor_4c_BuscaEmp
1133:             ENDIF
1134:         ENDTRY
1135:     ENDPROC
1136: 
1137:     *==========================================================================
1138:     * BtnBtncarregarClick - Importar planilha Excel de cotas
1139:     *==========================================================================
1140:     PROCEDURE BtnBtncarregarClick()
1141:         LOCAL loc_lResultado
1142:         loc_lResultado = THIS.ImportaPlan()
1143: 
1144:         IF loc_lResultado
1145:             MsgInfo("Planilha importada com sucesso.", "")
1146:             THIS.CarregarLista()
1147:         ELSE
1148:             MsgAviso("A Planilha n" + CHR(227) + "o foi importada.", "Aviso")
1149:         ENDIF
1150:     ENDPROC
1151: 
1152:     *==========================================================================
1153:     * BtnConfirmarClick - Salvar registro (chama Inserir ou Atualizar via BO)
1154:     * Legado: fSalvar em Salva.Click - valida campos, faz INSERT/UPDATE e volta lista
1155:     *==========================================================================
1156:     PROCEDURE BtnConfirmarClick()
1157:         TRY
1158:             IF THIS.this_cModoAtual = "VISUALIZAR"
1159:                 THIS.AlternarPagina(1)
1160:                 THIS.this_cModoAtual = "LISTA"
1161:             ELSE
1162:                 IF THIS.FormParaBO()
1163:                     IF THIS.this_oBusinessObject.Salvar()
1164:                         MsgInfo("Registro salvo com sucesso!", "")
1165:                         THIS.this_cModoAtual = "LISTA"
1166:                         THIS.AlternarPagina(1)
1167:                     ENDIF
1168:                 ENDIF
1169:             ENDIF
1170:         CATCH TO loException
1171:             MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loException.Message, "Erro")
1172:         ENDTRY
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * BtnCancelarClick - Cancelar edicao e voltar para lista
1177:     *==========================================================================
1178:     PROCEDURE BtnCancelarClick()
1179:         TRY
1180:             THIS.this_cModoAtual = "LISTA"
1181:             THIS.AlternarPagina(1)
1182:         CATCH TO loException
1183:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
1184:         ENDTRY
1185:     ENDPROC
1186: 
1187:     *==========================================================================
1188:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo atual
1189:     *==========================================================================
1190:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1191:         LOCAL loc_oPg2, loc_lVisualizar
1192:         loc_lVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")
1193: 
1194:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Salva", 5)
1195:             RETURN
1196:         ENDIF
1197: 
1198:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1199: 
1200:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1201:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = !loc_lVisualizar
1202:         ENDIF
1203: 
1204:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1205:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1206:         ENDIF
1207:     ENDPROC
1208: 
1209:     *==========================================================================
1210:     * HabilitarCampos - Habilita/desabilita campos conforme modo
1211:     * Legado: getEmps/getDtini/GetDtfin.When = INLIST(pcEscolha,'INSERIR')
1212:     *         getpdes/getvaldes/getcodigo.When = .F. (sempre somente leitura)
1213:     *==========================================================================
1214:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1215:         LOCAL loc_oPg2, loc_lModoIncluir
1216: 
1217:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1218:             RETURN
1219:         ENDIF
1220: 
1221:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1222:         loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")
1223: 
1224:         *-- Codigo: sempre somente leitura (auto-gerado pelo sistema)
1225:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1226:             loc_oPg2.txt_4c_Codigo.Enabled = .F.
1227:         ENDIF
1228: 
1229:         *-- Empresa, Dt Inicio, Dt Final: editavel SOMENTE no modo INCLUIR
1230:         IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1231:             loc_oPg2.txt_4c_Emps.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1232:         ENDIF
1233: 
1234:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1235:             loc_oPg2.txt_4c_Dtini.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1236:         ENDIF
1237: 
1238:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1239:             loc_oPg2.txt_4c_Dtfin.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1240:         ENDIF
1241: 
1242:         *-- Valmeta e Valcota: editavel em INCLUIR e ALTERAR
1243:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1244:             loc_oPg2.txt_4c_Valmeta.Enabled = par_lHabilitar
1245:         ENDIF
1246: 
1247:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1248:             loc_oPg2.txt_4c_Valcota.Enabled = par_lHabilitar
1249:         ENDIF
1250: 
1251:         *-- Pdes e Valdes: sempre somente leitura (calculados/registrados pelo sistema)
1252:         IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1253:             loc_oPg2.txt_4c_Pdes.Enabled = .F.
1254:         ENDIF

*-- Linhas 1261 a 1304:
1261:     *==========================================================================
1262:     * LimparCampos - Limpa todos os campos da Page2
1263:     *==========================================================================
1264:     PROTECTED PROCEDURE LimparCampos()
1265:         LOCAL loc_oPg2
1266: 
1267:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1268:             RETURN
1269:         ENDIF
1270: 
1271:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1272: 
1273:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1274:             loc_oPg2.txt_4c_Codigo.Value  = ""
1275:         ENDIF
1276:         IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1277:             loc_oPg2.txt_4c_Emps.Value    = ""
1278:         ENDIF
1279:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1280:             loc_oPg2.txt_4c_Dtini.Value   = {}
1281:         ENDIF
1282:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1283:             loc_oPg2.txt_4c_Dtfin.Value   = {}
1284:         ENDIF
1285:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1286:             loc_oPg2.txt_4c_Valmeta.Value = 0
1287:         ENDIF
1288:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1289:             loc_oPg2.txt_4c_Valcota.Value = 0
1290:         ENDIF
1291:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
1292:             loc_oPg2.txt_4c_Valdes.Value  = 0
1293:         ENDIF
1294:         IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1295:             loc_oPg2.txt_4c_Pdes.Value    = 0
1296:         ENDIF
1297:     ENDPROC
1298: 
1299:     *==========================================================================
1300:     * FormParaBO - Transfere valores dos campos do form para o BO
1301:     *==========================================================================
1302:     PROTECTED FUNCTION FormParaBO()
1303:         LOCAL loc_oPg2, loc_lResultado
1304:         loc_lResultado = .F.

*-- Linhas 1337 a 1481:
1337:     *==========================================================================
1338:     * BOParaForm - Transfere valores do BO para os campos do form
1339:     *==========================================================================
1340:     PROTECTED PROCEDURE BOParaForm()
1341:         LOCAL loc_oPg2, loc_nValmeta, loc_nValcota
1342: 
1343:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1344:             RETURN
1345:         ENDIF
1346: 
1347:         TRY
1348:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1349: 
1350:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1351:                 loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1352:             ENDIF
1353:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1354:                 loc_oPg2.txt_4c_Emps.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1355:             ENDIF
1356:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1357:                 loc_oPg2.txt_4c_Dtini.Value   = THIS.this_oBusinessObject.this_dDtini
1358:             ENDIF
1359:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1360:                 loc_oPg2.txt_4c_Dtfin.Value   = THIS.this_oBusinessObject.this_dDtfin
1361:             ENDIF
1362:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1363:                 loc_oPg2.txt_4c_Valmeta.Value = THIS.this_oBusinessObject.this_nValmeta
1364:             ENDIF
1365:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1366:                 loc_oPg2.txt_4c_Valcota.Value = THIS.this_oBusinessObject.this_nValcota
1367:             ENDIF
1368:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
1369:                 loc_oPg2.txt_4c_Valdes.Value  = THIS.this_oBusinessObject.this_nValdes
1370:             ENDIF
1371: 
1372:             *-- Calcular e exibir percentual de desconto
1373:             loc_nValmeta = THIS.this_oBusinessObject.this_nValmeta
1374:             loc_nValcota = THIS.this_oBusinessObject.this_nValcota
1375:             IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1376:                 loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
1377:                     loc_nValcota / loc_nValmeta * 100)
1378:             ENDIF
1379:         CATCH TO loException
1380:             MsgErro("Erro em BOParaForm:" + CHR(13) + loException.Message, "Erro")
1381:         ENDTRY
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * RecalcularPdes - Recalcula percentual de desconto ao mudar valmeta/valcota
1386:     * Legado: getpdes.Value = IIF(valmeta=0, 0.00, valcota/valmeta*100)
1387:     * Chamado via BINDEVENT InteractiveChange de txt_4c_Valmeta e txt_4c_Valcota
1388:     *==========================================================================
1389:     PROCEDURE RecalcularPdes()
1390:         LOCAL loc_oPg2, loc_nValmeta, loc_nValcota
1391:         loc_nValmeta = 0
1392:         loc_nValcota = 0
1393: 
1394:         IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1395:             RETURN
1396:         ENDIF
1397: 
1398:         TRY
1399:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1400: 
1401:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
1402:                 loc_nValmeta = loc_oPg2.txt_4c_Valmeta.Value
1403:             ENDIF
1404:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
1405:                 loc_nValcota = loc_oPg2.txt_4c_Valcota.Value
1406:             ENDIF
1407:             IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
1408:                 loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
1409:                     loc_nValcota / loc_nValmeta * 100)
1410:             ENDIF
1411:         CATCH TO loException
1412:             MsgErro("Erro em RecalcularPdes:" + CHR(13) + loException.Message, "Erro")
1413:         ENDTRY
1414:     ENDPROC
1415: 
1416:     *==========================================================================
1417:     * ImportaPlan - Importa planilha Excel com cotas de desconto
1418:     * Legado: usa ImpExcelDriver (funcao do framework Fortyus)
1419:     * Layout planilha: col1=empresa(N), col2=periodo YYMM(C), col3=cota(N)
1420:     *==========================================================================
1421:     PROTECTED FUNCTION ImportaPlan()
1422:         LOCAL loc_lcArq, loc_lResultado, loc_lcEmp
1423:         LOCAL loc_lcMes, loc_lnCota, loc_lcField
1424:         LOCAL loc_lcAno, loc_lcMesNum, loc_ldIni, loc_ldFin
1425:         loc_lResultado = .F.
1426: 
1427:         *-- GETFILE fora do TRY (dialogo nativo, sem risco de excecao VFP)
1428:         loc_lcArq = GETFILE("xls*")
1429: 
1430:         IF EMPTY(loc_lcArq)
1431:             RETURN .F.
1432:         ENDIF
1433: 
1434:         TRY
1435:             IF !ImpExcelDriver(loc_lcArq, "Cota Desconto")
1436:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a planilha." + CHR(13) + ;
1437:                     "Verifique se o arquivo e a aba 'Cota Desconto' est" + CHR(227) + "o corretos.", "Aviso")
1438:                 loc_lResultado = .F.
1439:             ELSE
1440:                 IF !USED("xlResults")
1441:                 MsgAviso("Planilha vazia ou formato inv" + CHR(225) + "lido.", "Aviso")
1442:                 loc_lResultado = .F.
1443:             ELSE
1444:                 SELECT xlResults
1445:                 GO TOP
1446: 
1447:                 SCAN
1448:                     *-- Coluna 1: empresa (numerico)
1449:                     loc_lcField = FIELD(1)
1450:                     loc_lcEmp = ALLTRIM(STR(IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)))
1451: 
1452:                     *-- Coluna 2: periodo YYMM (caracter, ex: "2601" = jan/2026)
1453:                     loc_lcField = FIELD(2)
1454:                     loc_lcMes = PADL(ALLTRIM(IIF(INLIST(VARTYPE(&loc_lcField), "C", "M"), &loc_lcField, "")), 6, "0")
1455: 
1456:                     *-- Coluna 3: valor da cota
1457:                     loc_lcField = FIELD(3)
1458:                     loc_lnCota = IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)
1459: 
1460:                     IF !EMPTY(loc_lcEmp) AND LEN(ALLTRIM(loc_lcMes)) >= 4
1461:                         *-- Extrair ano (2 digitos) e mes dos 4 ultimos chars apos padding
1462:                         loc_lcAno    = SUBSTR(loc_lcMes, 3, 2)
1463:                         loc_lcMesNum = RIGHT(loc_lcMes, 2)
1464: 
1465:                         loc_ldIni = DATE(2000 + VAL(loc_lcAno), VAL(loc_lcMesNum), 1)
1466:                         loc_ldFin = GOMONTH(loc_ldIni, 1) - 1
1467: 
1468:                         THIS.this_oBusinessObject.NovoRegistro()
1469:                         THIS.this_oBusinessObject.this_cEmps    = loc_lcEmp
1470:                         THIS.this_oBusinessObject.this_dDtini   = loc_ldIni
1471:                         THIS.this_oBusinessObject.this_dDtfin   = loc_ldFin
1472:                         THIS.this_oBusinessObject.this_nValmeta = 0
1473:                         THIS.this_oBusinessObject.this_nValcota = loc_lnCota
1474:                         THIS.this_oBusinessObject.Salvar()
1475:                     ENDIF
1476:                 ENDSCAN
1477: 
1478:                 IF USED("xlResults")
1479:                     USE IN xlResults
1480:                 ENDIF
1481: 


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

