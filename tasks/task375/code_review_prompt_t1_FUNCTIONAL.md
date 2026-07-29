# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [BINDEVENT-PARAMS] Handler 'ValidarEmpresa' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSerie' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSerie(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDtIni' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDtIni(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDtFim' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDtFim(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'NotaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE NotaLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2770 linhas total):

*-- Linhas 37 a 96:
37:     this_lCancelasFiltro = .F.  && .T. = exibir canceladas tambem
38: 
39:     *==========================================================================
40:     * Init - inicializacao padrao (FormBase.Init chama InicializarForm)
41:     *==========================================================================
42:     PROCEDURE Init()
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *==========================================================================
47:     * InicializarForm - configuracao completa (chamada pelo FormBase.Init)
48:     *==========================================================================
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             THIS.Caption = "Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais"
55: 
56:             THIS.this_oBusinessObject = CREATEOBJECT("CNFBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
59:                 THIS.this_cMensagemErro = "Erro ao criar CNFBO"
60:                 MsgErro("Erro ao criar CNFBO", "Erro de inicializa" + CHR(231) + CHR(227) + "o")
61:             ELSE
62:                 *-- Inicializar empresa com empresa do sistema
63:                 THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
64: 
65:                 *-- Criar cursor placeholder para a grade (campo a campo - Fase 4 configura grid)
66:                 IF USED("cursor_4c_Dados")
67:                     USE IN cursor_4c_Dados
68:                 ENDIF
69:                 SET NULL ON
70:                 CREATE CURSOR cursor_4c_Dados ( ;
71:                     cidchaves   C(20), ;
72:                     empdopnums  C(29), ;
73:                     emps        C(3),  ;
74:                     dopes       C(20), ;
75:                     numes       N(6,0), ;
76:                     nfis        C(6),  ;
77:                     series      C(8),  ;
78:                     especienfs  C(6),  ;
79:                     emis        T,     ;
80:                     dtsaidas    T,     ;
81:                     datans      T,     ;
82:                     operas      C(1),  ;
83:                     correcs     I,     ;
84:                     cancelas    I,     ;
85:                     regs        I,     ;
86:                     cfis        C(10), ;
87:                     clfis       C(12), ;
88:                     clifors     C(20), ;
89:                     cgcs        C(21), ;
90:                     totprods    N(14,2), ;
91:                     totnotas    N(14,2), ;
92:                     vals        N(14,2), ;
93:                     vlfretes    N(14,2), ;
94:                     vlseguros   N(14,2), ;
95:                     despaces    N(14,2), ;
96:                     codtrans    C(10), ;

*-- Linhas 137 a 208:
137:     * Legado: frmcadastro - PageCount=2, Top varia por heranca
138:     * Novo: Top=-29 (padrao framework), Width=1000
139:     *==========================================================================
140:     PROTECTED PROCEDURE ConfigurarPageFrame()
141:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
142: 
143:         WITH THIS.pgf_4c_Paginas
144:             .Top       = -29
145:             .Left      = 0
146:             .Width     = 1000
147:             .Height    = 629
148:             .PageCount = 2
149:             .Tabs      = .F.
150:             .Visible   = .T.
151: 
152:             .Page1.Caption   = "Lista"
153:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
154:             .Page1.BackColor = RGB(255, 255, 255)
155: 
156:             .Page2.Caption   = "Dados"
157:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
158:             .Page2.BackColor = RGB(255, 255, 255)
159:         ENDWITH
160:     ENDPROC
161: 
162:     *==========================================================================
163:     * ConfigurarPaginaLista - Page1: cabecalho + filtros + botoes + grade
164:     * Legado: cntFiltros (empresa/serie/periodo/optFiltro) + InserirCarta +
165:     *         AlteraCarta + ImpCarta (top=85) + Grade
166:     * Compensacao PageFrame: +29 em Top
167:     *==========================================================================
168:     PROTECTED PROCEDURE ConfigurarPaginaLista()
169:         LOCAL loc_oPagina, loc_oGrid
170:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
171: 
172:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
173:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
174: 
175:         *-- Cabecalho escuro com titulo (cntSombra do legado: Top=2 -> 31)
176:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
177:         WITH loc_oPagina.cnt_4c_Cabecalho
178:             .Top         = 31
179:             .Left        = 0
180:             .Width       = THIS.Width
181:             .Height      = 80
182:             .BackStyle   = 1
183:             .BackColor   = RGB(100, 100, 100)
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
189:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
190:             .Caption   = THIS.Caption
191:             .Top       = 17
192:             .Left      = 12
193:             .Width     = THIS.Width - 20
194:             .Height    = 46
195:             .FontName  = "Tahoma"
196:             .FontSize  = 16
197:             .FontBold  = .T.
198:             .AutoSize  = .F.
199:             .BackStyle = 0
200:             .ForeColor = RGB(0, 0, 0)
201:             .Visible   = .T.
202:         ENDWITH
203: 
204:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
205:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
206:             .Caption   = THIS.Caption
207:             .Top       = 20
208:             .Left      = 10

*-- Linhas 401 a 452:
401: 
402:         THIS.FormatarGridLista(loc_oGrid)
403: 
404:         THIS.TornarControlesVisiveis(loc_oPagina)
405:     ENDPROC
406: 
407:     *==========================================================================
408:     * ConfigurarPaginaDados - Page2: campos NF + aba Impostos/Servicos
409:     * Legado: Dados com Get_dope/Get_nume/Get_nota/etc + Pagina(Impostos+Servicos)
410:     * Compensacao PageFrame: +29 em Top
411:     *==========================================================================
412:     PROTECTED PROCEDURE ConfigurarPaginaDados()
413:         LOCAL loc_oPagina, loc_oCab
414:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
415: 
416:         loc_oPagina.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
417:         loc_oPagina.BackColor = RGB(255, 255, 255)
418: 
419:         *-- Container Salva: Confirmar + Cancelar (Grupo_Salva do legado: top=4 -> 33)
420:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
421:         WITH loc_oPagina.cnt_4c_Salva
422:             .Top         = 33
423:             .Left        = 842
424:             .Width       = 160
425:             .Height      = 85
426:             .BackStyle   = 0
427:             .BorderWidth = 0
428:             .Visible     = .T.
429:         ENDWITH
430: 
431:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
432:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
433:             .Caption         = "Confirmar"
434:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
435:             .PicturePosition = 13
436:             .Width           = 75
437:             .Height          = 75
438:             .Left            = 5
439:             .Top             = 5
440:             .FontName        = "Comic Sans MS"
441:             .FontBold        = .T.
442:             .FontItalic      = .T.
443:             .FontSize        = 8
444:             .ForeColor       = RGB(90, 90, 90)
445:             .BackColor       = RGB(255, 255, 255)
446:             .Themes          = .F.
447:             .SpecialEffect   = 0
448:             .MousePointer    = 15
449:             .WordWrap        = .T.
450:             .AutoSize        = .F.
451:             .Visible         = .T.
452:         ENDWITH

*-- Linhas 766 a 1185:
766: 
767:         THIS.ConfigurarAbaImpostos()
768:         THIS.ConfigurarAbaServicos()
769:         THIS.TornarControlesVisiveis(loc_oPagina)
770:     ENDPROC
771: 
772:     *==========================================================================
773:     * ConfigurarBindings - BINDEVENTs dos botoes e grade
774:     *==========================================================================
775:     PROTECTED PROCEDURE ConfigurarBindings()
776:         LOCAL loc_oPg1, loc_oPg2
777:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
778:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
779: 
780:         *-- Encerrar (Page1)
781:         BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
782: 
783:         *-- Acoes personalizadas (Page1)
784:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta, "Click", THIS, "BtnInserirCartaClick")
785:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta,  "Click", THIS, "BtnAlteraCartaClick")
786:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta,     "Click", THIS, "BtnImpCartaClick")
787: 
788:         *-- Grade: selecao de linha atualiza estado dos botoes
789:         BINDEVENT(loc_oPg1.grd_4c_Lista, "AfterRowColChange", THIS, "GrdListaAfterRowColChange")
790: 
791:         *-- Filtros (Page1)
792:         LOCAL loc_oCnt
793:         loc_oCnt = loc_oPg1.cnt_4c_Filtros
794:         BINDEVENT(loc_oCnt.txt_4c_Emp,    "KeyPress",         THIS, "ValidarEmpresa")
795:         BINDEVENT(loc_oCnt.txt_4c_Serie,  "KeyPress",         THIS, "ValidarSerie")
796:         BINDEVENT(loc_oCnt.txt_4c_DtIni,  "KeyPress",         THIS, "ValidarDtIni")
797:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "KeyPress",         THIS, "ValidarDtFim")
798:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "When",              THIS, "DtFimWhenCheck")
799:         BINDEVENT(loc_oCnt.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroChanged")
800: 
801:         *-- Salvar/Cancelar (Page2)
802:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
803:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
804: 
805:         *-- NF numero: LostFocus move foco para Confirmar (legado: Get_nota.LostFocus -> Salva.SetFocus)
806:         BINDEVENT(loc_oPg2.cnt_4c_DadosCab.txt_4c_Nota, "KeyPress", THIS, "NotaLostFocus")
807: 
808:         *-- Botao Dados na aba Impostos (abre SigMvExp)
809:         LOCAL loc_oAbaImp
810:         loc_oAbaImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
811:         BINDEVENT(loc_oAbaImp.cmd_4c_Dados, "Click", THIS, "BtnDadosClick")
812:     ENDPROC
813: 
814:     *==========================================================================
815:     * CarregarLista - Carrega lista de NFs segundo filtros atuais
816:     *==========================================================================
817:     PROCEDURE CarregarLista()
818:         LOCAL loc_lResultado
819:         loc_lResultado = .F.
820: 
821:         TRY
822:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
823:                 loc_lResultado = .T.
824:             ELSE
825:                 *-- Repassar filtros para o BO antes de chamar Buscar
826:                 THIS.this_oBusinessObject.this_cEmps           = THIS.this_cEmps
827:                 THIS.this_oBusinessObject.this_cSeriesFiltro   = THIS.this_cSeriesFiltro
828:                 THIS.this_oBusinessObject.this_tEmisDeFiltro   = THIS.this_dEmisDeFiltro
829:                 THIS.this_oBusinessObject.this_tEmisAteFiltro  = THIS.this_dEmisAteFiltro
830:                 THIS.this_oBusinessObject.this_cOpeFiltro      = THIS.this_cOpeFiltro
831:                 THIS.this_oBusinessObject.this_lCancelasFiltro = THIS.this_lCancelasFiltro
832:                 THIS.this_oBusinessObject.this_cNfisDeFiltro   = ""
833:                 THIS.this_oBusinessObject.this_cNfisAteFiltro  = ""
834: 
835:                 *-- Buscar requer empresa e serie preenchidos para consultar
836:                 IF !EMPTY(ALLTRIM(THIS.this_cEmps)) AND !EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
837:                     IF THIS.this_oBusinessObject.Buscar("")
838:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
839:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
840:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.nfis"
841:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.emis"
842:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.totnotas"
843:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
844:                         loc_lResultado = .T.
845:                     ELSE
846:                         loc_lResultado = .F.
847:                     ENDIF
848:                 ELSE
849:                     *-- Sem filtros suficientes: lista permanece vazia (nao e erro)
850:                     loc_lResultado = .T.
851:                 ENDIF
852:             ENDIF
853: 
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de NFs")
856:             loc_lResultado = .F.
857:         ENDTRY
858: 
859:         RETURN loc_lResultado
860:     ENDPROC
861: 
862:     *==========================================================================
863:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
864:     *==========================================================================
865:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
866:         LOCAL loc_lResultado
867:         loc_lResultado = .F.
868: 
869:         IF VARTYPE(par_nPagina) # "N" OR par_nPagina < 1 OR par_nPagina > 2
870:             RETURN .F.
871:         ENDIF
872: 
873:         TRY
874:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
875: 
876:             IF par_nPagina = 1
877:                 THIS.this_cModoAtual = "LISTA"
878:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
879:                     THIS.CarregarLista()
880:                 ENDIF
881:             ENDIF
882: 
883:             loc_lResultado = .T.
884: 
885:         CATCH TO loc_oErro
886:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
887:         ENDTRY
888: 
889:         RETURN loc_lResultado
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * GrdListaAfterRowColChange - Habilita/desabilita botoes conforme linha selecionada
894:     * (BINDEVENT AfterRowColChange exige LPARAMETERS com par_nColIndex)
895:     *==========================================================================
896:     PROCEDURE GrdListaAfterRowColChange(par_nColIndex)
897:         LOCAL loc_lTemCarta
898:         loc_lTemCarta = .F.
899: 
900:         TRY
901:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
902:                 SELECT cursor_4c_Dados
903:                 loc_lTemCarta = (NVL(cursor_4c_Dados.correcs, 0) > 0)
904:             ENDIF
905: 
906:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
907:                 .cmd_4c_AlteraCarta.Enabled = loc_lTemCarta
908:                 .cmd_4c_ImpCarta.Enabled    = loc_lTemCarta
909:                 .Visible     = .T.
910:             ENDWITH
911: 
912:         CATCH TO loc_oErro
913:             MsgErro(loc_oErro.Message, "Erro ao atualizar bot" + CHR(245) + "es")
914:         ENDTRY
915:     ENDPROC
916: 
917:     *==========================================================================
918:     * BtnEncerrarClick - Fecha o formulario
919:     *==========================================================================
920:     PROCEDURE BtnEncerrarClick()
921:         THIS.Release()
922:     ENDPROC
923: 
924:     *==========================================================================
925:     * BtnInserirCartaClick - Inserir nova carta de correcao para NF selecionada
926:     *==========================================================================
927:     PROCEDURE BtnInserirCartaClick()
928:         LOCAL loc_lResultado
929:         loc_lResultado = .F.
930: 
931:         TRY
932:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
933:                EOF("cursor_4c_Dados")
934:                 MsgAviso("Selecione uma Nota Fiscal na lista.", ;
935:                     "Inser" + CHR(231) + CHR(227) + "o de Carta")
936:                 RETURN
937:             ENDIF
938: 
939:             SELECT cursor_4c_Dados
940: 
941:             IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
942:                 THIS.this_oBusinessObject.NovoRegistro()
943:                 THIS.this_cModoAtual = "INCLUIR"
944:                 THIS.BOParaForm()
945:                 THIS.HabilitarCampos(.T.)
946:                 THIS.AlternarPagina(2)
947:                 loc_lResultado = .T.
948:             ELSE
949:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
950:                     "Erro ao carregar NF")
951:             ENDIF
952: 
953:         CATCH TO loc_oErro
954:             MsgErro(loc_oErro.Message, "Erro ao inserir carta")
955:         ENDTRY
956: 
957:         RETURN loc_lResultado
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * BtnAlteraCartaClick - Alterar carta de correcao existente
962:     *==========================================================================
963:     PROCEDURE BtnAlteraCartaClick()
964:         LOCAL loc_lResultado
965:         loc_lResultado = .F.
966: 
967:         TRY
968:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
969:                EOF("cursor_4c_Dados")
970:                 MsgAviso("Selecione uma Nota Fiscal na lista.", ;
971:                     "Altera" + CHR(231) + CHR(227) + "o de Carta")
972:                 RETURN
973:             ENDIF
974: 
975:             SELECT cursor_4c_Dados
976: 
977:             IF NVL(cursor_4c_Dados.correcs, 0) = 0
978:                 MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
979:                     CHR(231) + CHR(227) + "o para alterar.", "Aviso")
980:                 RETURN
981:             ENDIF
982: 
983:             IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
984:                 THIS.this_oBusinessObject.EditarRegistro()
985:                 THIS.this_cModoAtual = "ALTERAR"
986:                 THIS.BOParaForm()
987:                 THIS.HabilitarCampos(.T.)
988:                 THIS.AlternarPagina(2)
989:                 loc_lResultado = .T.
990:             ELSE
991:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
992:                     "Erro ao carregar NF")
993:             ENDIF
994: 
995:         CATCH TO loc_oErro
996:             MsgErro(loc_oErro.Message, "Erro ao alterar carta")
997:         ENDTRY
998: 
999:         RETURN loc_lResultado
1000:     ENDPROC
1001: 
1002:     *==========================================================================
1003:     * BtnImpCartaClick - Imprimir carta de correcao (handler Fase 7)
1004:     * Logica: DO FORM SigCnFCrt (legado) com parametros da NF selecionada
1005:     *==========================================================================
1006:     PROCEDURE BtnImpCartaClick()
1007:         LOCAL loc_lResultado, loc_cCidchaves, loc_cEdns, loc_cSerie
1008:         LOCAL loc_dEmisDe, loc_dEmisAte
1009:         loc_lResultado = .F.
1010: 
1011:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1012:            EOF("cursor_4c_Dados")
1013:             MsgAviso("Selecione uma Nota Fiscal na lista.", ;
1014:                 "Impress" + CHR(227) + "o de Carta")
1015:             RETURN .F.
1016:         ENDIF
1017: 
1018:         SELECT cursor_4c_Dados
1019: 
1020:         IF NVL(cursor_4c_Dados.correcs, 0) = 0
1021:             MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
1022:                 CHR(231) + CHR(227) + "o para imprimir.", "Aviso")
1023:             RETURN .F.
1024:         ENDIF
1025: 
1026:         TRY
1027:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1028:             loc_cEdns      = ALLTRIM(cursor_4c_Dados.empdopnums)
1029:             loc_cSerie     = ALLTRIM(THIS.this_cSeriesFiltro)
1030:             loc_dEmisDe    = THIS.this_dEmisDeFiltro
1031:             loc_dEmisAte   = THIS.this_dEmisAteFiltro
1032: 
1033:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1034:                 *-- Impressao via helper do BO (metodo ImprimirCarta adicionado na Fase 7)
1035:                 loc_lResultado = THIS.this_oBusinessObject.ImprimirCarta( ;
1036:                     loc_cEdns, loc_cSerie, loc_dEmisDe, loc_dEmisAte)
1037:             ELSE
1038:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1039:                     "Erro ao carregar NF")
1040:             ENDIF
1041: 
1042:         CATCH TO loc_oErro
1043:             MsgErro(loc_oErro.Message, "Erro ao imprimir carta")
1044:         ENDTRY
1045: 
1046:         RETURN loc_lResultado
1047:     ENDPROC
1048: 
1049:     *==========================================================================
1050:     * BtnConfirmarClick - Salvar dados da carta de correcao
1051:     *==========================================================================
1052:     PROCEDURE BtnConfirmarClick()
1053:         LOCAL loc_lResultado
1054:         loc_lResultado = .F.
1055: 
1056:         TRY
1057:             THIS.FormParaBO()
1058: 
1059:             IF THIS.this_oBusinessObject.Salvar()
1060:                 MsgInfo("Carta de corre" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
1061:                 THIS.this_cModoAtual = "LISTA"
1062:                 THIS.HabilitarCampos(.F.)
1063:                 THIS.AlternarPagina(1)
1064:                 loc_lResultado = .T.
1065:             ELSE
1066:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1067:                     "Erro ao salvar carta")
1068:             ENDIF
1069: 
1070:         CATCH TO loc_oErro
1071:             MsgErro(loc_oErro.Message, "Erro ao confirmar")
1072:         ENDTRY
1073: 
1074:         RETURN loc_lResultado
1075:     ENDPROC
1076: 
1077:     *==========================================================================
1078:     * BtnCancelarClick - Cancelar edicao e voltar para lista
1079:     *==========================================================================
1080:     PROCEDURE BtnCancelarClick()
1081:         THIS.this_cModoAtual = "LISTA"
1082:         THIS.HabilitarCampos(.F.)
1083:         *-- Re-habilitar Confirmar (pode ter sido desabilitado em modo VISUALIZAR)
1084:         THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
1085:         THIS.AlternarPagina(1)
1086:     ENDPROC
1087: 
1088:     *==========================================================================
1089:     * NotaLostFocus - Ao sair do campo NF num, move foco para Confirmar
1090:     * Legado: Get_nota.LostFocus = Grupo_Salva.Salva.SetFocus
1091:     *==========================================================================
1092:     PROCEDURE NotaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1093:         LOCAL loc_oErro
1094:         TRY
1095:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1096:         CATCH TO loc_oErro
1097:             MsgErro(loc_oErro.Message, "Erro ao mover foco")
1098:         ENDTRY
1099:     ENDPROC
1100: 
1101:     *==========================================================================
1102:     * FormParaBO - Transfere valores do form para as propriedades do BO
1103:     *==========================================================================
1104:     PROTECTED PROCEDURE FormParaBO()
1105:         LOCAL loc_lResultado, loc_oCab
1106:         loc_lResultado = .F.
1107: 
1108:         TRY
1109:             loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
1110: 
1111:             THIS.this_oBusinessObject.this_cEmps       = THIS.this_cEmps
1112: 
1113:             *-- Campos display-only do cabecalho (readonly; valores carregados via BOParaForm)
1114:             *-- txt_4c_Nota (nfis) pode ser modificado em modo PROCURAR, mas em INCLUIR/ALTERAR
1115:             *-- a NF ja vem carregada; repassar o valor atual para garantir consistencia
1116:             THIS.this_oBusinessObject.this_cNfis       = ALLTRIM(loc_oCab.txt_4c_Nota.Value)
1117: 
1118:             *-- Data de saida pode ser ajustada pelo usuario no fluxo de correcao
1119:             IF !EMPTY(loc_oCab.txt_4c_DtSaidas.Value)
1120:                 THIS.this_oBusinessObject.this_tDtsaidas = DATETIME( ;
1121:                     YEAR(loc_oCab.txt_4c_DtSaidas.Value), ;
1122:                     MONTH(loc_oCab.txt_4c_DtSaidas.Value), ;
1123:                     DAY(loc_oCab.txt_4c_DtSaidas.Value))
1124:             ELSE
1125:                 THIS.this_oBusinessObject.this_tDtsaidas = {}
1126:             ENDIF
1127: 
1128:             *-- CFOP: readonly no formulario; BO ja tem o valor correto do load
1129:             THIS.this_oBusinessObject.this_cCfis       = ALLTRIM(loc_oCab.txt_4c_ClFiscal.Value)
1130:             THIS.this_oBusinessObject.this_cDescricaos = ALLTRIM(loc_oCab.txt_4c_DClFiscal.Value)
1131: 
1132:             loc_lResultado = .T.
1133: 
1134:         CATCH TO loc_oErro
1135:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1136:             loc_lResultado = .F.
1137:         ENDTRY
1138: 
1139:         RETURN loc_lResultado
1140:     ENDPROC
1141: 
1142:     *==========================================================================
1143:     * BOParaForm - Transfere propriedades do BO para os campos do form
1144:     *==========================================================================
1145:     PROTECTED PROCEDURE BOParaForm()
1146:         LOCAL loc_lResultado, loc_oCab, loc_oBO, loc_tEmis, loc_tSaida
1147:         loc_lResultado = .F.
1148: 
1149:         TRY
1150:             loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
1151:             loc_oBO  = THIS.this_oBusinessObject
1152: 
1153:             *-- Operacao
1154:             loc_oCab.txt_4c_Dope.Value     = ALLTRIM(loc_oBO.this_cDopes)
1155: 
1156:             *-- Data Emissao (DateTime -> Date)
1157:             loc_tEmis = loc_oBO.this_tEmis
1158:             IF !EMPTY(loc_tEmis)
1159:                 loc_oCab.txt_4c_DtEmissao.Value = DATE(YEAR(loc_tEmis), MONTH(loc_tEmis), DAY(loc_tEmis))
1160:             ELSE
1161:                 loc_oCab.txt_4c_DtEmissao.Value = {}
1162:             ENDIF
1163: 
1164:             *-- Numero, Serie, NF num, Especie
1165:             loc_oCab.txt_4c_Numes.Value    = TRANSFORM(loc_oBO.this_nNumes)
1166:             loc_oCab.txt_4c_NfSerie.Value  = ALLTRIM(loc_oBO.this_cSeries)
1167:             loc_oCab.txt_4c_Nota.Value     = ALLTRIM(loc_oBO.this_cNfis)
1168:             loc_oCab.txt_4c_Especie.Value  = ALLTRIM(loc_oBO.this_cEspecienfs)
1169: 
1170:             *-- Data Saida (DateTime -> Date)
1171:             loc_tSaida = loc_oBO.this_tDtsaidas
1172:             IF !EMPTY(loc_tSaida)
1173:                 loc_oCab.txt_4c_DtSaidas.Value = DATE(YEAR(loc_tSaida), MONTH(loc_tSaida), DAY(loc_tSaida))
1174:             ELSE
1175:                 loc_oCab.txt_4c_DtSaidas.Value = {}
1176:             ENDIF
1177: 
1178:             *-- CFOP e descricao
1179:             loc_oCab.txt_4c_ClFiscal.Value  = ALLTRIM(loc_oBO.this_cCfis)
1180:             loc_oCab.txt_4c_DClFiscal.Value = ALLTRIM(loc_oBO.this_cDescricaos)
1181: 
1182:             *-- *** Aba Impostos ***
1183:             LOCAL loc_oImp
1184:             loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
1185:             loc_oImp.txt_4c_BaseIPI.Value    = loc_oBO.this_nBasecipis

*-- Linhas 1235 a 1293:
1235:     *==========================================================================
1236:     * HabilitarCampos - Habilita ou desabilita controles para edicao
1237:     *==========================================================================
1238:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1239:         LOCAL loc_oPg1, loc_lAtivo
1240:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
1241:         loc_lAtivo = !par_lHabilitar
1242: 
1243:         *-- Botoes de acao e encerrar ficam bloqueados durante edicao na Page2
1244:         loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta.Enabled = loc_lAtivo
1245:         loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta.Enabled  = loc_lAtivo
1246:         loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta.Enabled     = loc_lAtivo
1247:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled      = loc_lAtivo
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * LimparCampos - Limpa todos os campos do cabecalho da NF
1252:     *==========================================================================
1253:     PROTECTED PROCEDURE LimparCampos()
1254:         LOCAL loc_oCab
1255:         TRY
1256:             loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
1257:             loc_oCab.txt_4c_Dope.Value      = ""
1258:             loc_oCab.txt_4c_DtEmissao.Value = {}
1259:             loc_oCab.txt_4c_Numes.Value     = ""
1260:             loc_oCab.txt_4c_NfSerie.Value   = ""
1261:             loc_oCab.txt_4c_Nota.Value      = ""
1262:             loc_oCab.txt_4c_Especie.Value   = ""
1263:             loc_oCab.txt_4c_DtSaidas.Value  = {}
1264:             loc_oCab.txt_4c_ClFiscal.Value  = ""
1265:             loc_oCab.txt_4c_DClFiscal.Value = ""
1266: 
1267:             *-- Aba Impostos
1268:             LOCAL loc_oImpL
1269:             loc_oImpL = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
1270:             loc_oImpL.txt_4c_BaseIPI.Value    = 0
1271:             loc_oImpL.txt_4c_ValorIPI.Value   = 0
1272:             loc_oImpL.txt_4c_BaseICMS.Value   = 0
1273:             loc_oImpL.txt_4c_PercICMS.Value   = 0
1274:             loc_oImpL.txt_4c_ValorICMS.Value  = 0
1275:             loc_oImpL.txt_4c_TotalProds.Value = 0
1276:             loc_oImpL.txt_4c_TotalNf.Value    = 0
1277:             loc_oImpL.txt_4c_TFrete.Value     = 0
1278:             loc_oImpL.txt_4c_TSeguros.Value   = 0
1279:             loc_oImpL.txt_4c_DespAces.Value   = 0
1280:             loc_oImpL.txt_4c_CodTransp.Value  = ""
1281:             loc_oImpL.txt_4c_TranspNome.Value = ""
1282:             loc_oImpL.txt_4c_TranspEnde.Value = ""
1283:             loc_oImpL.txt_4c_TranspCida.Value = ""
1284:             loc_oImpL.txt_4c_TranspEsta.Value = ""
1285:             loc_oImpL.txt_4c_Placa.Value      = ""
1286:             loc_oImpL.txt_4c_UfPlaca.Value    = ""
1287:             loc_oImpL.txt_4c_TipoFrete.Value  = ""
1288:             loc_oImpL.txt_4c_Qtdes.Value      = 0
1289:             loc_oImpL.txt_4c_EspeVol.Value    = ""
1290:             loc_oImpL.txt_4c_Marcas.Value     = ""
1291:             loc_oImpL.txt_4c_NumerosVol.Value = ""
1292:             loc_oImpL.txt_4c_PesoLiq.Value    = 0
1293:             loc_oImpL.txt_4c_PesoBruto.Value  = 0

*-- Linhas 1306 a 1401:
1306:     ENDPROC
1307: 
1308:     *==========================================================================
1309:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1310:     *==========================================================================
1311:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1312:         LOCAL loc_nI, loc_oObjeto
1313: 
1314:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1315:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1316: 
1317:             IF VARTYPE(loc_oObjeto) = "O"
1318:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1319:                     loc_oObjeto.Visible = .T.
1320:                 ENDIF
1321: 
1322:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1323:                     LOCAL loc_nP
1324:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1325:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1326:                     ENDFOR
1327:                 ENDIF
1328: 
1329:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1330:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1331:                 ENDIF
1332:             ENDIF
1333:         ENDFOR
1334:     ENDPROC
1335: 
1336:     *==========================================================================
1337:     * FormatarGridLista - Formata visual do grid da lista
1338:     *==========================================================================
1339:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1340:         WITH par_oGrid
1341:             .FontName = "Verdana"
1342:             .FontSize = 8
1343:             .ForeColor         = RGB(90, 90, 90)
1344:             .BackColor         = RGB(255, 255, 255)
1345:             .GridLineColor     = RGB(238, 238, 238)
1346:             .HighlightBackColor = RGB(255, 255, 255)
1347:             .HighlightForeColor = RGB(15, 41, 104)
1348:             .HighlightStyle    = 2
1349:             .DeleteMark        = .F.
1350:             .RecordMark        = .F.
1351:             .RowHeight         = 16
1352:             .ScrollBars        = 2
1353:             .GridLines         = 3
1354:         ENDWITH
1355:     ENDPROC
1356: 
1357:     *==========================================================================
1358:     * ConfigurarFiltros - Popula cnt_4c_Filtros com controles de filtro
1359:     * Legado: GetEmp / Get_Serie / DtIni / DtFim / optFiltro
1360:     *==========================================================================
1361:     PROTECTED PROCEDURE ConfigurarFiltros(par_oPagina)
1362:         LOCAL loc_oCnt
1363:         loc_oCnt = par_oPagina.cnt_4c_Filtros
1364: 
1365:         *-- Label: Empresa (Label2: top=19, left=16, width=57)
1366:         loc_oCnt.AddObject("lbl_4c_Empresa", "Label")
1367:         WITH loc_oCnt.lbl_4c_Empresa
1368:             .Caption   = "Empresa :"
1369:             .Top       = 14
1370:             .Left      = 16
1371:             .Width     = 57
1372:             .Height    = 15
1373:             .FontName  = "Tahoma"
1374:             .FontSize  = 8
1375:             .BackStyle = 0
1376:             .ForeColor = RGB(53, 53, 53)
1377:             .Visible   = .T.
1378:         ENDWITH
1379: 
1380:         *-- TextBox: Empresa (GetEmp: top=16, left=84, width=31, height=23)
1381:         loc_oCnt.AddObject("txt_4c_Emp", "TextBox")
1382:         WITH loc_oCnt.txt_4c_Emp
1383:             .Top       = 12
1384:             .Left      = 84
1385:             .Width     = 31
1386:             .Height    = 23
1387:             .MaxLength = 3
1388:             .FontName  = "Tahoma"
1389:             .FontSize  = 8
1390:             .Value     = ALLTRIM(THIS.this_cEmps)
1391:             .Visible   = .T.
1392:         ENDWITH
1393: 
1394:         *-- Label: No. Serie (Say1: top=19, left=138)
1395:         loc_oCnt.AddObject("lbl_4c_Serie", "Label")
1396:         WITH loc_oCnt.lbl_4c_Serie
1397:             .Caption   = "No. S" + CHR(233) + "rie : "
1398:             .Top       = 14
1399:             .Left      = 138
1400:             .Height    = 15
1401:             .FontName  = "Tahoma"

*-- Linhas 1476 a 1521:
1476:             .Visible   = .T.
1477:         ENDWITH
1478: 
1479:         *-- OptionGroup: Filtro (optFiltro: top=14, left=538, w=183, h=25, buttonCount=3)
1480:         *-- Value=1=Entrada, Value=2=Saida, Value=3=Ambas (default)
1481:         loc_oCnt.AddObject("opt_4c_Filtro", "OptionGroup")
1482:         WITH loc_oCnt.opt_4c_Filtro
1483:             .ButtonCount = 3
1484:             .Top         = 10
1485:             .Left        = 538
1486:             .Width       = 206
1487:             .Height      = 26
1488:             .BackStyle   = 0
1489:             .BorderStyle = 0
1490:             .Visible     = .T.
1491:         ENDWITH
1492:         WITH loc_oCnt.opt_4c_Filtro.Buttons(1)
1493:             .Caption   = "Entrada"
1494:             .BackStyle = 0
1495:             .Left      = 5
1496:             .Top       = 4
1497:             .AutoSize  = .T.
1498:             .FontName  = "Tahoma"
1499:             .FontSize  = 8
1500:             .ForeColor = RGB(53, 53, 53)
1501:             .Themes    = .F.
1502:         ENDWITH
1503:         WITH loc_oCnt.opt_4c_Filtro.Buttons(2)
1504:             .Caption   = "Sa" + CHR(237) + "da"
1505:             .BackStyle = 0
1506:             .Left      = 74
1507:             .Top       = 4
1508:             .AutoSize  = .T.
1509:             .FontName  = "Tahoma"
1510:             .FontSize  = 8
1511:             .ForeColor = RGB(53, 53, 53)
1512:             .Themes    = .F.
1513:         ENDWITH
1514:         WITH loc_oCnt.opt_4c_Filtro.Buttons(3)
1515:             .Caption   = "Ambas"
1516:             .BackStyle = 0
1517:             .Left      = 140
1518:             .Top       = 4
1519:             .AutoSize  = .T.
1520:             .FontName  = "Tahoma"
1521:             .FontSize  = 8

*-- Linhas 1528 a 1776:
1528: 
1529:     *==========================================================================
1530:     * ValidarEmpresa - LostFocus de txt_4c_Emp: valida empresa em SigCdEmp
1531:     * Legado: GetEmp.Valid usa fAcessoEmpresa() (nao portada -> substituida)
1532:     *==========================================================================
1533:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1534:         LOCAL loc_oCnt, loc_cEmps, loc_cSQL, loc_nResult
1535:         loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
1536:         loc_cEmps = ALLTRIM(loc_oCnt.txt_4c_Emp.Value)
1537: 
1538:         IF EMPTY(loc_cEmps)
1539:             MsgAviso("Preenchimento Obrigat" + CHR(243) + "rio!!!", "Empresa")
1540:             loc_oCnt.txt_4c_Emp.SetFocus()
1541:             RETURN
1542:         ENDIF
1543: 
1544:         TRY
1545:             loc_cSQL    = "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + ;
1546:                 EscaparSQL(loc_cEmps)
1547:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
1548: 
1549:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEmp") > 0
1550:                 THIS.this_cEmps = loc_cEmps
1551:             ELSE
1552:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, ;
1553:                     "Empresa")
1554:                 loc_oCnt.txt_4c_Emp.Value = THIS.this_cEmps
1555:             ENDIF
1556: 
1557:             IF USED("cursor_4c_BuscaEmp")
1558:                 USE IN cursor_4c_BuscaEmp
1559:             ENDIF
1560: 
1561:         CATCH TO loc_oErro
1562:             MsgErro(loc_oErro.Message, "Erro ao validar empresa")
1563:         ENDTRY
1564:     ENDPROC
1565: 
1566:     *==========================================================================
1567:     * ValidarSerie - LostFocus de txt_4c_Serie: valida em SigCdSer
1568:     * Legado: Get_Serie.Valid usa fwBuscaInt sobre cursor crSigCdSer
1569:     *==========================================================================
1570:     PROCEDURE ValidarSerie(par_nKeyCode, par_nShiftAltCtrl)
1571:         LOCAL loc_oCnt, loc_cSerie, loc_cSQL, loc_nResult, loc_lEncontrou
1572:         loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
1573:         loc_cSerie    = ALLTRIM(loc_oCnt.txt_4c_Serie.Value)
1574:         loc_lEncontrou = .F.
1575: 
1576:         IF EMPTY(loc_cSerie)
1577:             THIS.this_cSeriesFiltro = ""
1578:             RETURN
1579:         ENDIF
1580: 
1581:         TRY
1582:             loc_cSQL    = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
1583:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")
1584: 
1585:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaSer") > 0
1586:                 SELECT cursor_4c_BuscaSer
1587:                 GO TOP
1588:                 LOCATE FOR UPPER(ALLTRIM(cursor_4c_BuscaSer.Cods)) == UPPER(loc_cSerie)
1589: 
1590:                 IF FOUND()
1591:                     THIS.this_cSeriesFiltro            = ALLTRIM(cursor_4c_BuscaSer.Cods)
1592:                     loc_oCnt.txt_4c_Serie.Value        = THIS.this_cSeriesFiltro
1593:                     loc_lEncontrou                     = .T.
1594:                 ELSE
1595:                     *-- Nao encontrou exato: abrir picker
1596:                     LOCAL loc_oBusca
1597:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1598:                     IF VARTYPE(loc_oBusca) = "O"
1599:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSer"
1600:                         loc_oBusca.this_cTitulo        = "S" + CHR(233) + "ries"
1601:                         loc_oBusca.this_cCampoChave    = "Cods"
1602:                         loc_oBusca.this_cValorInicial  = loc_cSerie
1603:                         loc_oBusca.mAddColuna("Cods",  "XXXXX",              ;
1604:                             "S" + CHR(233) + "rie")
1605:                         loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXX", ;
1606:                             "Descri" + CHR(231) + CHR(227) + "o")
1607:                         loc_oBusca.Show()
1608: 
1609:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
1610:                             SELECT cursor_4c_BuscaSer
1611:                             THIS.this_cSeriesFiltro     = ALLTRIM(cursor_4c_BuscaSer.Cods)
1612:                             loc_oCnt.txt_4c_Serie.Value = THIS.this_cSeriesFiltro
1613:                             loc_lEncontrou              = .T.
1614:                         ELSE
1615:                             loc_oCnt.txt_4c_Serie.Value = ""
1616:                             THIS.this_cSeriesFiltro     = ""
1617:                         ENDIF
1618:                         loc_oBusca.Release()
1619:                     ENDIF
1620:                 ENDIF
1621:             ENDIF
1622: 
1623:             IF USED("cursor_4c_BuscaSer")
1624:                 USE IN cursor_4c_BuscaSer
1625:             ENDIF
1626: 
1627:             *-- Se serie valida e datas preenchidas, recarregar lista
1628:             IF loc_lEncontrou AND ;
1629:                !EMPTY(THIS.this_dEmisDeFiltro) AND ;
1630:                !EMPTY(THIS.this_dEmisAteFiltro)
1631:                 THIS.CarregarLista()
1632:             ENDIF
1633: 
1634:         CATCH TO loc_oErro
1635:             MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
1636:         ENDTRY
1637:     ENDPROC
1638: 
1639:     *==========================================================================
1640:     * ValidarDtIni - LostFocus de txt_4c_DtIni: valida consistencia com DtFim
1641:     * Legado: DtIni.Valid - se DtFim preenchida e DtIni > DtFim, limpar
1642:     *==========================================================================
1643:     PROCEDURE ValidarDtIni(par_nKeyCode, par_nShiftAltCtrl)
1644:         LOCAL loc_oCnt, loc_dDtIni, loc_dDtFim
1645:         loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
1646:         loc_dDtIni = loc_oCnt.txt_4c_DtIni.Value
1647:         loc_dDtFim = loc_oCnt.txt_4c_DtFim.Value
1648: 
1649:         IF !EMPTY(loc_dDtFim) AND !EMPTY(loc_dDtIni) AND loc_dDtIni > loc_dDtFim
1650:             MsgAviso("Data Inv" + CHR(225) + "lida !!", "")
1651:             loc_oCnt.txt_4c_DtIni.Value = {}
1652:             THIS.this_dEmisDeFiltro     = {}
1653:         ELSE
1654:             THIS.this_dEmisDeFiltro = loc_dDtIni
1655:         ENDIF
1656:     ENDPROC
1657: 
1658:     *==========================================================================
1659:     * ValidarDtFim - LostFocus de txt_4c_DtFim: valida e recarrega lista
1660:     * Legado: DtFim.Valid - valida, se serie+datas OK chama Requery
1661:     *==========================================================================
1662:     PROCEDURE ValidarDtFim(par_nKeyCode, par_nShiftAltCtrl)
1663:         LOCAL loc_oCnt, loc_dDtIni, loc_dDtFim
1664:         loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
1665:         loc_dDtIni = loc_oCnt.txt_4c_DtIni.Value
1666:         loc_dDtFim = loc_oCnt.txt_4c_DtFim.Value
1667: 
1668:         IF !EMPTY(loc_dDtFim) AND !EMPTY(loc_dDtIni) AND loc_dDtFim < loc_dDtIni
1669:             MsgAviso("Data Inv" + CHR(225) + "lida !!", "")
1670:             loc_oCnt.txt_4c_DtFim.Value = {}
1671:             THIS.this_dEmisAteFiltro    = {}
1672:             RETURN
1673:         ENDIF
1674: 
1675:         THIS.this_dEmisAteFiltro = loc_dDtFim
1676: 
1677:         *-- Se filtros completos, recarregar lista
1678:         IF !EMPTY(THIS.this_cSeriesFiltro) AND ;
1679:            !EMPTY(THIS.this_dEmisDeFiltro) AND ;
1680:            !EMPTY(THIS.this_dEmisAteFiltro)
1681:             THIS.CarregarLista()
1682:         ENDIF
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * DtFimWhenCheck - When de txt_4c_DtFim: so permite foco se DtIni preenchida
1687:     * Legado: DtFim.When = Return(!Empty(DtIni.Value))
1688:     *==========================================================================
1689:     FUNCTION DtFimWhenCheck()
1690:         LOCAL loc_dDtIni
1691:         loc_dDtIni = {}
1692:         TRY
1693:             loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtIni.Value
1694:         CATCH
1695:             loc_lResultado = .T.
1696:         ENDTRY
1697:         RETURN !EMPTY(loc_dDtIni)
1698:     ENDFUNC
1699: 
1700:     *==========================================================================
1701:     * FiltroChanged - InteractiveChange de opt_4c_Filtro: atualiza e recarrega
1702:     * Legado: optFiltro.InteractiveChange - atualiza pOpE/pOpS e chama Requery
1703:     * Value=1=Entradas, Value=2=Saidas, Value=3=Ambas
1704:     *==========================================================================
1705:     PROCEDURE FiltroChanged()
1706:         LOCAL loc_nOpcao
1707:         TRY
1708:             loc_nOpcao = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_Filtro.Value
1709: 
1710:             DO CASE
1711:             CASE loc_nOpcao = 1
1712:                 THIS.this_cOpeFiltro = "E"
1713:             CASE loc_nOpcao = 2
1714:                 THIS.this_cOpeFiltro = "S"
1715:             OTHERWISE
1716:                 THIS.this_cOpeFiltro = "A"
1717:             ENDCASE
1718: 
1719:             *-- Recarregar se filtros completos
1720:             IF !EMPTY(THIS.this_cSeriesFiltro) AND ;
1721:                !EMPTY(THIS.this_dEmisDeFiltro) AND ;
1722:                !EMPTY(THIS.this_dEmisAteFiltro)
1723:                 THIS.CarregarLista()
1724:             ENDIF
1725: 
1726:         CATCH TO loc_oErro
1727:             MsgErro(loc_oErro.Message, "Erro ao mudar filtro")
1728:         ENDTRY
1729:     ENDPROC
1730: 
1731:     *==========================================================================
1732:     * ConfigurarAbaImpostos - Cria controles na aba Impostos do PageFrame interno
1733:     * Legado: SIGCDCNF.Pagina.Dados.Pagina.Impostos
1734:     * Coordenadas originais do SCX (sem compensacao - inner PageFrame usa Tabs=.T.)
1735:     *==========================================================================
1736:     PROTECTED PROCEDURE ConfigurarAbaImpostos()
1737:         LOCAL loc_oAba
1738:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
1739: 
1740:         *-- Say17: titulo da secao (top=2, left=5)
1741:         loc_oAba.AddObject("lbl_4c_SecImpostos", "Label")
1742:         WITH loc_oAba.lbl_4c_SecImpostos
1743:             .Caption   = " Impostos "
1744:             .Top       = 2
1745:             .Left      = 5
1746:             .AutoSize  = .T.
1747:             .FontName  = "Tahoma"
1748:             .FontSize  = 8
1749:             .BackStyle = 0
1750:             .ForeColor = RGB(53, 53, 53)
1751:         ENDWITH
1752: 
1753:         *-- Shape1: divisor horizontal (top=20, left=5, width=494, height=2)
1754:         loc_oAba.AddObject("shp_4c_Div1", "Shape")
1755:         WITH loc_oAba.shp_4c_Div1
1756:             .Top         = 20
1757:             .Left        = 5
1758:             .Width       = 494
1759:             .Height      = 2
1760:             .BackColor   = RGB(180, 180, 180)
1761:             .BorderColor = RGB(180, 180, 180)
1762:         ENDWITH
1763: 
1764:         *-- Labels cabecalho IPI/ICMS (top=26)
1765:         loc_oAba.AddObject("lbl_4c_SayBaseIPI", "Label")
1766:         WITH loc_oAba.lbl_4c_SayBaseIPI
1767:             .Caption   = "Base C" + CHR(225) + "lculo IPI"
1768:             .Top       = 26
1769:             .Left      = 5
1770:             .AutoSize  = .T.
1771:             .FontName  = "Tahoma"
1772:             .FontSize  = 8
1773:             .BackStyle = 0
1774:             .ForeColor = RGB(53, 53, 53)
1775:         ENDWITH
1776: 

*-- Linhas 2451 a 2494:
2451:     * Legado: SIGCDCNF.Pagina.Dados.Pagina.Servicos
2452:     * Coordenadas originais do SCX (sem compensacao - inner PageFrame usa Tabs=.T.)
2453:     *==========================================================================
2454:     PROTECTED PROCEDURE ConfigurarAbaServicos()
2455:         LOCAL loc_oAba
2456:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2
2457: 
2458:         *-- Say1: "Descricao dos Servicos Prestados :" (top=2, left=7)
2459:         loc_oAba.AddObject("lbl_4c_SayDescSer", "Label")
2460:         WITH loc_oAba.lbl_4c_SayDescSer
2461:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o dos Servi" + CHR(231) + "os Prestados : "
2462:             .Top       = 2
2463:             .Left      = 7
2464:             .AutoSize  = .T.
2465:             .FontName  = "Tahoma"
2466:             .FontSize  = 8
2467:             .BackStyle = 0
2468:             .ForeColor = RGB(53, 53, 53)
2469:         ENDWITH
2470: 
2471:         *-- Memo_desc EditBox (top=18, left=5, width=724, height=144)
2472:         loc_oAba.AddObject("edt_4c_DescSer", "EditBox")
2473:         WITH loc_oAba.edt_4c_DescSer
2474:             .Top      = 18
2475:             .Left     = 5
2476:             .Width    = 724
2477:             .Height   = 144
2478:             .FontName = "Tahoma"
2479:             .FontSize = 8
2480:             .ReadOnly = .T.
2481:             .Value    = ""
2482:         ENDWITH
2483: 
2484:         *-- Say2: "Valor Total Servicos :" (top=167, left=15)
2485:         loc_oAba.AddObject("lbl_4c_SayVtotsers", "Label")
2486:         WITH loc_oAba.lbl_4c_SayVtotsers
2487:             .Caption   = "Valor Total Servi" + CHR(231) + "os : "
2488:             .Top       = 167
2489:             .Left      = 15
2490:             .AutoSize  = .T.
2491:             .FontName  = "Tahoma"
2492:             .FontSize  = 8
2493:             .BackStyle = 0
2494:             .ForeColor = RGB(53, 53, 53)

*-- Linhas 2564 a 2770:
2564:     * BtnDadosClick - Abre SigMvExp com detalhes das movimentacoes da NF
2565:     * Legado: Dados.Click -> SELECT Dopes FROM SigCdOpe -> DO FORM SigMvExp WITH ...
2566:     *==========================================================================
2567:     PROCEDURE BtnDadosClick()
2568:         LOCAL loc_lResultado, loc_cDopes, loc_nNumes, loc_cEmps, loc_nResult, loc_cSQL
2569:         loc_lResultado = .F.
2570: 
2571:         TRY
2572:             THIS.Enabled = .F.
2573: 
2574:             loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
2575:             loc_nNumes = THIS.this_oBusinessObject.this_nNumes
2576:             loc_cEmps  = THIS.this_cEmps
2577: 
2578:             IF EMPTY(loc_cDopes)
2579:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o definida.", "Dados")
2580:             ELSE
2581:                 loc_cSQL    = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
2582:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2583: 
2584:                 IF loc_nResult > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2585:                     DO FORM SigMvExp WITH loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.
2586:                     loc_lResultado = .T.
2587:                 ELSE
2588:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "Dados")
2589:                 ENDIF
2590: 
2591:                 IF USED("cursor_4c_TmpOpe")
2592:                     USE IN cursor_4c_TmpOpe
2593:                 ENDIF
2594:             ENDIF
2595: 
2596:         CATCH TO loc_oErro
2597:             MsgErro(loc_oErro.Message, "Erro ao abrir dados da NF")
2598:         ENDTRY
2599: 
2600:         THIS.Enabled = .T.
2601: 
2602:         RETURN loc_lResultado
2603:     ENDPROC
2604: 
2605:     *==========================================================================
2606:     * BtnIncluirClick - Alias canonico para InserirCarta (inserir carta de correcao)
2607:     * Mapeia o padrao CRUD para este formulario especializado
2608:     *==========================================================================
2609:     PROCEDURE BtnIncluirClick()
2610:         THIS.BtnInserirCartaClick()
2611:     ENDPROC
2612: 
2613:     *==========================================================================
2614:     * BtnAlterarClick - Alias canonico para AlteraCarta (alterar carta de correcao)
2615:     * Mapeia o padrao CRUD para este formulario especializado
2616:     *==========================================================================
2617:     PROCEDURE BtnAlterarClick()
2618:         THIS.BtnAlteraCartaClick()
2619:     ENDPROC
2620: 
2621:     *==========================================================================
2622:     * BtnVisualizarClick - Visualiza NF selecionada em modo somente leitura
2623:     * Legado: pcEscolha='CONSULTAR' -> Page2 com dados da NF (campos bloqueados)
2624:     *==========================================================================
2625:     PROCEDURE BtnVisualizarClick()
2626:         LOCAL loc_lResultado
2627:         loc_lResultado = .F.
2628: 
2629:         TRY
2630:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
2631:                EOF("cursor_4c_Dados")
2632:                 MsgAviso("Selecione uma Nota Fiscal na lista.", "Visualizar")
2633:             ELSE
2634:                 SELECT cursor_4c_Dados
2635: 
2636:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
2637:                     THIS.this_cModoAtual = "VISUALIZAR"
2638:                     THIS.BOParaForm()
2639:                     THIS.HabilitarCampos(.F.)
2640:                     *-- Desabilitar Confirmar em modo VISUALIZAR (somente leitura)
2641:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
2642:                     THIS.AlternarPagina(2)
2643:                     loc_lResultado = .T.
2644:                 ELSE
2645:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
2646:                         "Erro ao carregar NF")
2647:                 ENDIF
2648:             ENDIF
2649: 
2650:         CATCH TO loc_oErro
2651:             MsgErro(loc_oErro.Message, "Erro ao visualizar NF")
2652:         ENDTRY
2653: 
2654:         RETURN loc_lResultado
2655:     ENDPROC
2656: 
2657:     *==========================================================================
2658:     * BtnExcluirClick - Exclui carta de correcao da NF selecionada
2659:     * Remove a carta de correcao (correcs=0), mantendo a NF original no sistema
2660:     *==========================================================================
2661:     PROCEDURE BtnExcluirClick()
2662:         LOCAL loc_lResultado, loc_cCidchaves
2663:         loc_lResultado = .F.
2664: 
2665:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
2666:            EOF("cursor_4c_Dados")
2667:             MsgAviso("Selecione uma Nota Fiscal na lista.", ;
2668:                 "Excluir Carta de Corre" + CHR(231) + CHR(227) + CHR(227) + "o")
2669:             RETURN .F.
2670:         ENDIF
2671: 
2672:         SELECT cursor_4c_Dados
2673: 
2674:         IF NVL(cursor_4c_Dados.correcs, 0) = 0
2675:             MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
2676:                 CHR(231) + CHR(227) + "o para excluir.", "Aviso")
2677:             RETURN .F.
2678:         ENDIF
2679: 
2680:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da carta de corre" + ;
2681:                 CHR(231) + CHR(227) + "o desta NF?", ;
2682:                 "Excluir Carta")
2683:             RETURN .F.
2684:         ENDIF
2685: 
2686:         TRY
2687:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
2688: 
2689:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
2690:                 IF THIS.this_oBusinessObject.Excluir()
2691:                     MsgInfo("Carta de corre" + CHR(231) + CHR(227) + "o exclu" + ;
2692:                         CHR(237) + "da com sucesso!", "Sucesso")
2693:                     THIS.CarregarLista()
2694:                     loc_lResultado = .T.
2695:                 ELSE
2696:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao excluir")
2697:                 ENDIF
2698:             ELSE
2699:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao carregar NF")
2700:             ENDIF
2701: 
2702:         CATCH TO loc_oErro
2703:             MsgErro(loc_oErro.Message, ;
2704:                 "Erro ao excluir carta de corre" + CHR(231) + CHR(227) + "o")
2705:         ENDTRY
2706: 
2707:         RETURN loc_lResultado
2708:     ENDPROC
2709: 
2710:     *==========================================================================
2711:     * Destroy - Limpeza ao fechar o formulario
2712:     *==========================================================================
2713:     PROCEDURE Destroy()
2714:         IF USED("cursor_4c_Dados")
2715:             USE IN cursor_4c_Dados
2716:         ENDIF
2717: 
2718:         THIS.this_oBusinessObject = .NULL.
2719:         DODEFAULT()
2720:     ENDPROC
2721: 
2722:     *==========================================================================
2723:     * BtnBuscarClick - Recarrega lista com filtros atuais (busca manual)
2724:     *==========================================================================
2725:     PROCEDURE BtnBuscarClick()
2726:         IF EMPTY(ALLTRIM(THIS.this_cEmps))
2727:             MsgAviso("Informe a Empresa para pesquisa.", "Buscar")
2728:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Emp.SetFocus()
2729:             RETURN
2730:         ENDIF
2731:         IF EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
2732:             MsgAviso("Informe a S" + CHR(233) + "rie para pesquisa.", "Buscar")
2733:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Serie.SetFocus()
2734:             RETURN
2735:         ENDIF
2736:         THIS.CarregarLista()
2737:     ENDPROC
2738: 
2739:     *==========================================================================
2740:     * BtnSalvarClick - Alias canonico para BtnConfirmarClick (salvar dados)
2741:     *==========================================================================
2742:     PROCEDURE BtnSalvarClick()
2743:         THIS.BtnConfirmarClick()
2744:     ENDPROC
2745: 
2746:     *==========================================================================
2747:     * AjustarBotoesPorModo - Ajusta estados de botoes conforme modo atual
2748:     *==========================================================================
2749:     PROCEDURE AjustarBotoesPorModo()
2750:         LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
2751:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
2752:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2753:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2754: 
2755:         WITH loc_oPg1.cnt_4c_Botoes
2756:             .cmd_4c_InserirCarta.Enabled = !loc_lEdicao
2757:             .cmd_4c_AlteraCarta.Enabled  = !loc_lEdicao
2758:             .cmd_4c_ImpCarta.Enabled     = !loc_lEdicao
2759:             .Visible     = .T.
2760:         ENDWITH
2761:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEdicao
2762: 
2763:         WITH loc_oPg2.cnt_4c_Salva
2764:             .cmd_4c_Confirmar.Enabled = loc_lEdicao
2765:             .cmd_4c_Cancelar.Enabled  = .T.
2766:             .Visible     = .T.
2767:         ENDWITH
2768:     ENDPROC
2769: 
2770: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CNFBO.prg):
*==============================================================================
* CNFBO.prg - Business Object de Correcao de Notas Fiscais
* Tabela principal: SigMvNfi (PK: cidchaves)
*==============================================================================

DEFINE CLASS CNFBO AS BusinessBase

    *-- =========================================================================
    *-- Chave primaria e identificacao
    *-- =========================================================================
    this_cCidchaves    = ""   && char(20) PK composta
    this_cEmpdopnums   = ""   && char(29) emps+dopes+numes
    this_cEmps         = ""   && char(3)

    *-- =========================================================================
    *-- Cabecalho da NF
    *-- =========================================================================
    this_cDopes        = ""   && char(20) tipo de operacao
    this_nNumes        = 0    && numeric(6,0) numero interno
    this_cNfis         = ""   && char(6) numero da NF fiscal
    this_cSeries       = ""   && char(8) serie
    this_cEspecienfs   = ""   && char(6) especie da NF
    this_tEmis         = {}   && datetime data emissao
    this_tDtsaidas     = {}   && datetime data saida
    this_tDatans       = {}   && datetime data da nota
    this_cOperas       = ""   && char(1) E=Entrada S=Saida
    this_lCorrecs      = .F.  && bit possui carta de correcao
    this_lCancelas     = .F.  && bit cancelada
    this_lRegs         = .F.  && bit registrada

    *-- =========================================================================
    *-- Fiscal / CFOP
    *-- =========================================================================
    this_cCfis         = ""   && char(10) cod. fiscal CFOP
    this_cClfis        = ""   && char(12) classe fiscal
    this_cCodcons      = ""   && char(9)  cod. condicao
    this_cConds        = ""   && char(12) condicoes
    this_cCfosubs      = ""   && char(10) CFOP substituto

    *-- Display-only: JOIN SigCdCfo.descricaos
    this_cDescricaos   = ""

    *-- =========================================================================
    *-- Cliente / Fornecedor
    *-- =========================================================================
    this_cClifors      = ""   && char(20) cod. cliente/fornecedor
    this_cCgcs         = ""   && char(21) CGC/CNPJ

    *-- Display-only: JOIN SigCdCli.rclis
    this_cRclis        = ""

    *-- =========================================================================
    *-- Impostos - IPI
    *-- =========================================================================
    this_nBasecipis    = 0    && numeric(14,2) base calculo IPI
    this_nValipis      = 0    && numeric(14,2) valor IPI
    this_nIpis         = 0    && numeric(4,2)  aliquota IPI
    this_nIpincreds    = 0    && numeric(14,2) IPI nao credita
    this_nBasecip2s    = 0    && numeric(14,2) base IPI 2
    this_nBasecip3s    = 0    && numeric(14,2) base IPI 3
    this_nDesipis      = 0    && numeric(15,2) desoner. IPI
    this_nFrtipis      = 0    && numeric(15,2) frete IPI
    this_nSegipis      = 0    && numeric(15,2) seguro IPI

    *-- =========================================================================
    *-- Impostos - ICMS
    *-- =========================================================================
    this_nBasecicms    = 0    && numeric(14,2) base calculo ICMS
    this_nValicms      = 0    && numeric(14,2) valor ICMS
    this_nIcms         = 0    && numeric(4,2)  aliquota % ICMS
    this_nBasecic2s    = 0    && numeric(14,2) base ICMS 2
    this_nBasecic3s    = 0    && numeric(14,2) base ICMS 3
    this_nBcicmss      = 0    && numeric(15,2) base ICMS subst.
    this_nIcmss        = 0    && numeric(15,2) ICMS substituicao
    this_nDesicms      = 0    && numeric(15,2) desoner. ICMS
    this_nFrticms      = 0    && numeric(15,2) frete ICMS
    this_nSegicms      = 0    && numeric(15,2) seguro ICMS
    this_nVfcpst       = 0    && numeric(14,2) FCP ST

    *-- =========================================================================
    *-- Totais
    *-- =========================================================================
    this_nTotProds     = 0    && numeric(14,2) total produtos
    this_nTotNotas     = 0    && numeric(14,2) total da NF
    this_nVals         = 0    && numeric(14,2) valor
    this_nPesos        = 0    && numeric(7,2)  peso

    *-- =========================================================================
    *-- Outros valores / frete / seguro
    *-- =========================================================================
    this_nVlFretes     = 0    && numeric(14,2) valor do frete
    this_nVlSeguros    = 0    && numeric(14,2) valor do seguro
    this_nDespAces     = 0    && numeric(14,2) despesas acessorias

    *-- =========================================================================
    *-- Transporte
    *-- =========================================================================
    this_cCodtrans     = ""   && char(10) cod. transportadora
    this_nFretes       = 0    && numeric(1,0) tipo frete 0=Emit/1=Dest
    this_cPlacas       = ""   && char(8)  placa veiculo
    this_cUfPlacas     = ""   && char(2)  UF placa
    this_tDatatrans    = {}   && datetime data transporte
    this_nNtrans       = 0    && numeric(6,0) numero transporte
    this_cObsfretes    = ""   && char(10) obs frete

    *-- Display-only via JOIN SigPrTrp
    this_cTranspNome   = ""
    this_cTranspEnde   = ""
    this_cTranspCida   = ""
    this_cTranspEsta   = ""

    *-- =========================================================================
    *-- Volumes transportados
    *-- =========================================================================
    this_nQtdes        = 0    && numeric(6,0) qtde de volumes
    this_cEspes        = ""   && char(10) especie do volume
    this_cMarcas       = ""   && char(10) marca do volume
    this_cNumeros      = ""   && char(10) numero do volume
    this_nPliqs        = 0    && numeric(10,3) peso liquido
    this_nPbrus        = 0    && numeric(10,3) peso bruto
    this_cObspbrus     = ""   && char(10) obs peso bruto
    this_cObspliqs     = ""   && char(10) obs peso liquido

    *-- =========================================================================
    *-- Servicos
    *-- =========================================================================
    this_cDescsers     = ""   && text  descricao servicos (memo)
    this_nVtotsers     = 0    && numeric(14,2) valor total servicos
    this_nPerciss      = 0    && numeric(5,2)  % ISS
    this_nVtotiss      = 0    && numeric(14,2) valor total ISS
    this_cCodservs     = ""   && char(10) cod. servico
    this_cDescservs    = ""   && char(40) desc. servico

    *-- ISS retido / outras retencoes
    this_nIssretidos   = 0    && numeric(1,0)  ISS retido flag
    this_nOutretens    = 0    && numeric(15,2) outras retencoes
    this_cPrestservs   = ""   && char(7)  prestador servicos
    this_nVdeducoes    = 0    && numeric(15,2) valor deducoes
    this_nVdscconds    = 0    && numeric(15,2) desc. condicionado
    this_nVdsciconds   = 0    && numeric(15,2) desc. incondicionado
    this_cTiponfs      = ""   && char(2)  tipo NF
    this_nTptribsers   = 0    && numeric(2,0)  tipo tribut. servicos
    this_cCodsrvfis    = ""   && char(6)  cod. servico fiscal
    this_cCodbenefs    = ""   && char(3)  cod. beneficio

    *-- =========================================================================
    *-- PIS / COFINS / CSLL / IR / INSS
    *-- =========================================================================
    this_nPcofins      = 0    && numeric(5,2)  % COFINS
    this_nVcofins      = 0    && numeric(14,2) valor COFINS
    this_nPcsll        = 0    && numeric(5,2)  % CSLL
    this_nVcsll        = 0    && numeric(14,2) valor CSLL
    this_nPinss        = 0    && numeric(5,2)  % INSS
    this_nVinss        = 0    && numeric(14,2) valor INSS
    this_nPirf         = 0    && numeric(5,2)  % IR
    this_nVirf         = 0    && numeric(14,2) valor IR
    this_nPpis         = 0    && numeric(5,2)  % PIS
    this_nVpis         = 0    && numeric(14,2) valor PIS
    this_nValiis       = 0    && numeric(14,2) valor II

    *-- =========================================================================
    *-- RPS (Recibo Provisorio de Servicos)
    *-- =========================================================================
    this_nLoterps      = 0    && numeric(6,0)  lote RPS
    this_nNumrps       = 0    && numeric(12,0) numero RPS
    this_cSerierps     = ""   && char(5)  serie RPS
    this_cTiporps      = ""   && char(5)  tipo RPS

    *-- =========================================================================
    *-- NF-e / Chaves eletronicas
    *-- =========================================================================
    this_cNfechv       = ""   && char(44) chave NF-e
    this_cNfechvc      = ""   && char(44) chave NF-e cancelamento
    this_cChnfes       = ""   && char(44) chave NF-e referenciada
    this_cNfepdf       = ""   && text     NF-e PDF
    this_cNfeprt       = ""   && char(15) NF-e protocolo
    this_cNfetxt       = ""   && text     NF-e texto
    this_cNfexml       = ""   && text     NF-e XML
    this_cCanxml       = ""   && text     XML cancelamento
    this_tDdesembs     = {}   && datetime data desembarque
    this_tDregdis      = {}   && datetime data registro DI
    this_cNdis         = ""   && char(10) numero DI
    this_tInvcbds      = {}   && datetime data invalida CBD
    this_nChkenvias    = 0    && numeric(1,0) flag enviado
    this_cChaveexterna = ""   && char(33) chave externa
    this_nChkrastreio  = 0    && numeric(1,0) flag rastreio

    *-- =========================================================================
    *-- Observacoes / Misc
    *-- =========================================================================
    this_cObss         = ""   && char(40) observacoes
    this_cObs2s        = ""   && char(40) observacoes 2
    this_nImpress      = 0    && numeric(6,0)  numero de impressoes
    this_nSelos        = 0    && numeric(10,0) selos
    this_cLocals       = ""   && char(10) local
    this_tImportas     = {}   && datetime data importacao
    this_cNumeronota   = ""   && char(10) numero nota alternativo

    *-- =========================================================================
    *-- Filtros de pesquisa (usados em Buscar)
    *-- =========================================================================
    this_cEmpsFiltro    = ""   && empresa para filtro
    this_cSeriesFiltro  = ""   && serie para filtro
    this_tEmisDeFiltro  = {}   && periodo emissao de
    this_tEmisAteFiltro = {}   && periodo emissao ate
    this_cOpeFiltro     = "A"  && E=Entrada S=Saida A=Ambas
    this_cNfisDeFiltro  = ""   && NF de (filtro por numero)
    this_cNfisAteFiltro = ""   && NF ate (filtro por numero)
    this_lCancelasFiltro = .F. && incluir canceladas

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvNfi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCidchaves    = ""
        THIS.this_cEmpdopnums   = ""
        THIS.this_cEmps         = ""
        THIS.this_cDopes        = ""
        THIS.this_nNumes        = 0
        THIS.this_cNfis         = ""
        THIS.this_cSeries       = ""
        THIS.this_cEspecienfs   = ""
        THIS.this_tEmis         = {}
        THIS.this_tDtsaidas     = {}
        THIS.this_tDatans       = {}
        THIS.this_cOperas       = ""
        THIS.this_lCorrecs      = .F.
        THIS.this_lCancelas     = .F.
        THIS.this_lRegs         = .F.
        THIS.this_cCfis         = ""
        THIS.this_cClfis        = ""
        THIS.this_cCodcons      = ""
        THIS.this_cConds        = ""
        THIS.this_cCfosubs      = ""
        THIS.this_cDescricaos   = ""
        THIS.this_cClifors      = ""
        THIS.this_cCgcs         = ""
        THIS.this_cRclis        = ""
        THIS.this_nBasecipis    = 0
        THIS.this_nValipis      = 0
        THIS.this_nIpis         = 0
        THIS.this_nIpincreds    = 0
        THIS.this_nBasecip2s    = 0
        THIS.this_nBasecip3s    = 0
        THIS.this_nDesipis      = 0
        THIS.this_nFrtipis      = 0
        THIS.this_nSegipis      = 0
        THIS.this_nBasecicms    = 0
        THIS.this_nValicms      = 0
        THIS.this_nIcms         = 0
        THIS.this_nBasecic2s    = 0
        THIS.this_nBasecic3s    = 0
        THIS.this_nBcicmss      = 0
        THIS.this_nIcmss        = 0
        THIS.this_nDesicms      = 0
        THIS.this_nFrticms      = 0
        THIS.this_nSegicms      = 0
        THIS.this_nVfcpst       = 0
        THIS.this_nTotProds     = 0
        THIS.this_nTotNotas     = 0
        THIS.this_nVals         = 0
        THIS.this_nPesos        = 0
        THIS.this_nVlFretes     = 0
        THIS.this_nVlSeguros    = 0
        THIS.this_nDespAces     = 0
        THIS.this_cCodtrans     = ""
        THIS.this_nFretes       = 0
        THIS.this_cPlacas       = ""
        THIS.this_cUfPlacas     = ""
        THIS.this_tDatatrans    = {}
        THIS.this_nNtrans       = 0
        THIS.this_cObsfretes    = ""
        THIS.this_cTranspNome   = ""
        THIS.this_cTranspEnde   = ""
        THIS.this_cTranspCida   = ""
        THIS.this_cTranspEsta   = ""
        THIS.this_nQtdes        = 0
        THIS.this_cEspes        = ""
        THIS.this_cMarcas       = ""
        THIS.this_cNumeros      = ""
        THIS.this_nPliqs        = 0
        THIS.this_nPbrus        = 0
        THIS.this_cObspbrus     = ""
        THIS.this_cObspliqs     = ""
        THIS.this_cDescsers     = ""
        THIS.this_nVtotsers     = 0
        THIS.this_nPerciss      = 0
        THIS.this_nVtotiss      = 0
        THIS.this_cCodservs     = ""
        THIS.this_cDescservs    = ""
        THIS.this_nIssretidos   = 0
        THIS.this_nOutretens    = 0
        THIS.this_cPrestservs   = ""
        THIS.this_nVdeducoes    = 0
        THIS.this_nVdscconds    = 0
        THIS.this_nVdsciconds   = 0
        THIS.this_cTiponfs      = ""
        THIS.this_nTptribsers   = 0
        THIS.this_cCodsrvfis    = ""
        THIS.this_cCodbenefs    = ""
        THIS.this_nPcofins      = 0
        THIS.this_nVcofins      = 0
        THIS.this_nPcsll        = 0
        THIS.this_nVcsll        = 0
        THIS.this_nPinss        = 0
        THIS.this_nVinss        = 0
        THIS.this_nPirf         = 0
        THIS.this_nVirf         = 0
        THIS.this_nPpis         = 0
        THIS.this_nVpis         = 0
        THIS.this_nValiis       = 0
        THIS.this_nLoterps      = 0
        THIS.this_nNumrps       = 0
        THIS.this_cSerierps     = ""
        THIS.this_cTiporps      = ""
        THIS.this_cNfechv       = ""
        THIS.this_cNfechvc      = ""
        THIS.this_cChnfes       = ""
        THIS.this_cNfepdf       = ""
        THIS.this_cNfeprt       = ""
        THIS.this_cNfetxt       = ""
        THIS.this_cNfexml       = ""
        THIS.this_cCanxml       = ""
        THIS.this_tDdesembs     = {}
        THIS.this_tDregdis      = {}
        THIS.this_cNdis         = ""
        THIS.this_tInvcbds      = {}
        THIS.this_nChkenvias    = 0
        THIS.this_cChaveexterna = ""
        THIS.this_nChkrastreio  = 0
        THIS.this_cObss         = ""
        THIS.this_cObs2s        = ""
        THIS.this_nImpress      = 0
        THIS.this_nSelos        = 0
        THIS.this_cLocals       = ""
        THIS.this_tImportas     = {}
        THIS.this_cNumeronota   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cEmpdopnums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_cDopes       = TratarNulo(dopes,       "C")
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cNfis        = TratarNulo(nfis,        "C")
            THIS.this_cSeries      = TratarNulo(series,      "C")
            THIS.this_cEspecienfs  = TratarNulo(especienfs,  "C")
            IF !ISNULL(emis)
                THIS.this_tEmis    = emis
            ENDIF
            IF !ISNULL(dtsaidas)
                THIS.this_tDtsaidas = dtsaidas
            ENDIF
            IF !ISNULL(datans)
                THIS.this_tDatans  = datans
            ENDIF
            THIS.this_cOperas      = TratarNulo(operas,      "C")
            THIS.this_lCorrecs     = (IIF(ISNULL(correcs),  0, correcs)  <> 0)
            THIS.this_lCancelas    = (IIF(ISNULL(cancelas), 0, cancelas) <> 0)
            THIS.this_lRegs        = (IIF(ISNULL(regs),     0, regs)     <> 0)
            THIS.this_cCfis        = TratarNulo(cfis,        "C")
            THIS.this_cClfis       = TratarNulo(clfis,       "C")
            THIS.this_cCodcons     = TratarNulo(codcons,     "C")
            THIS.this_cConds       = TratarNulo(conds,       "C")
            THIS.this_cClifors     = TratarNulo(clifors,     "C")
            THIS.this_cCgcs        = TratarNulo(cgcs,        "C")
            THIS.this_nBasecipis   = TratarNulo(basecipis,   "N")
            THIS.this_nValipis     = TratarNulo(valipis,     "N")
            THIS.this_nIpis        = TratarNulo(ipis,        "N")
            THIS.this_nIpincreds   = TratarNulo(ipincreds,   "N")
            THIS.this_nBasecip2s   = TratarNulo(basecip2s,   "N")
            THIS.this_nBasecip3s   = TratarNulo(basecip3s,   "N")
            THIS.this_nBasecicms   = TratarNulo(basecicms,   "N")
            THIS.this_nValicms     = TratarNulo(valicms,     "N")
            THIS.this_nIcms        = TratarNulo(icms,        "N")
            THIS.this_nBasecic2s   = TratarNulo(basecic2s,   "N")
            THIS.this_nBasecic3s   = TratarNulo(basecic3s,   "N")
            THIS.this_nTotProds    = TratarNulo(totprods,    "N")
            THIS.this_nTotNotas    = TratarNulo(totnotas,    "N")
            THIS.this_nVals        = TratarNulo(vals,        "N")
            THIS.this_nPesos       = TratarNulo(pesos,       "N")
            THIS.this_nVlFretes    = TratarNulo(vlfretes,    "N")
            THIS.this_nVlSeguros   = TratarNulo(vlseguros,   "N")
            THIS.this_nDespAces    = TratarNulo(despaces,    "N")
            THIS.this_cCodtrans    = TratarNulo(codtrans,    "C")
            THIS.this_nFretes      = TratarNulo(fretes,      "N")
            THIS.this_cPlacas      = TratarNulo(placas,      "C")
            THIS.this_cUfPlacas    = TratarNulo(ufplacas,    "C")
            IF !ISNULL(datatrans)
                THIS.this_tDatatrans = datatrans
            ENDIF
            THIS.this_nQtdes       = TratarNulo(qtdes,       "N")
            THIS.this_cEspes       = TratarNulo(espes,       "C")
            THIS.this_cMarcas      = TratarNulo(marcas,      "C")
            THIS.this_cNumeros     = TratarNulo(numeros,     "C")
            THIS.this_nPliqs       = TratarNulo(pliqs,       "N")
            THIS.this_nPbrus       = TratarNulo(pbrus,       "N")
            THIS.this_cDescsers    = TratarNulo(descsers,    "C")
            THIS.this_nVtotsers    = TratarNulo(vtotsers,    "N")
            THIS.this_nPerciss     = TratarNulo(perciss,     "N")
            THIS.this_nVtotiss     = TratarNulo(vtotiss,     "N")
            THIS.this_nImpress     = TratarNulo(impress,     "N")
            THIS.this_cObss        = TratarNulo(obss,        "C")
            THIS.this_cObs2s       = TratarNulo(obs2s,       "C")
            IF !ISNULL(importas)
                THIS.this_tImportas = importas
            ENDIF
            *-- Campos de JOIN (presentes quando vem de Buscar ou CarregarPorCodigo)
            IF TYPE("rclis") <> "U"
                THIS.this_cRclis       = TratarNulo(rclis,       "C")
            ENDIF
            IF TYPE("descricaos") <> "U"
                THIS.this_cDescricaos  = TratarNulo(descricaos,  "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar cursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Pesquisa NFs com filtros configurados nas propriedades de filtro
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cJoinCfg, loc_cWhereOpe, loc_cWhereSerie, loc_cWhereData
        LOCAL loc_cWhereNfi, loc_cWhereCan, loc_nCfgCount
        loc_lSucesso  = .F.
        loc_nCfgCount = 0

        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria para pesquisa.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verifica SigCnFNF: join por emps+series ou apenas series
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS qtd FROM SigCnFNF WHERE emps = " + ;
                EscaparSQL(PADR(THIS.this_cEmps, 3)), ;
                "cursor_4c_CfgNFNF")
            IF loc_nResultado >= 0 AND USED("cursor_4c_CfgNFNF") AND RECCOUNT("cursor_4c_CfgNFNF") > 0
                SELECT cursor_4c_CfgNFNF
                loc_nCfgCount = cursor_4c_CfgNFNF.qtd
            ENDIF
            IF USED("cursor_4c_CfgNFNF")
                USE IN cursor_4c_CfgNFNF
            ENDIF

            IF loc_nCfgCount > 0
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.emps + g.series = n.emps + n.series"
            ELSE
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.series = n.series"
            ENDIF

            *-- Filtro operacao E/S/A
            DO CASE
                CASE THIS.this_cOpeFiltro = "E"
                    loc_cWhereOpe = " AND n.operas = 'E'"
                CASE THIS.this_cOpeFiltro = "S"
                    loc_cWhereOpe = " AND n.operas = 'S'"
                OTHERWISE
                    loc_cWhereOpe = " AND n.operas IN ('E','S')"
            ENDCASE

            *-- Filtro serie
            IF EMPTY(THIS.this_cSeriesFiltro)
                loc_cWhereSerie = ""
            ELSE
                loc_cWhereSerie = " AND n.series = " + EscaparSQL(PADR(THIS.this_cSeriesFiltro, 8))
            ENDIF

            *-- Filtro data emissao
            IF EMPTY(THIS.this_tEmisDeFiltro) OR EMPTY(THIS.this_tEmisAteFiltro)
                loc_cWhereData = ""
            ELSE
                loc_cWhereData = " AND CAST(n.emis AS DATE) BETWEEN " + ;
                    FormatarDataSQL(THIS.this_tEmisDeFiltro) + ;
                    " AND " + FormatarDataSQL(THIS.this_tEmisAteFiltro)
            ENDIF

            *-- Filtro numero NF
            IF EMPTY(THIS.this_cNfisDeFiltro) AND EMPTY(THIS.this_cNfisAteFiltro)
                loc_cWhereNfi = ""
            ELSE
                loc_cWhereNfi = " AND n.nfis BETWEEN " + ;
                    EscaparSQL(PADR(THIS.this_cNfisDeFiltro, 6)) + ;
                    " AND " + EscaparSQL(IIF(EMPTY(THIS.this_cNfisAteFiltro), ;
                        REPLICATE(CHR(254), 6), PADR(THIS.this_cNfisAteFiltro, 6)))
            ENDIF

            *-- Filtro canceladas (padrao = so nao canceladas)
            IF THIS.this_lCancelasFiltro
                loc_cWhereCan = ""
            ELSE
                loc_cWhereCan = " AND n.cancelas = 0"
            ENDIF

            loc_cSQL = "SELECT n.cidchaves, n.empdopnums, n.emps, n.dopes, n.numes," + ;
                " n.nfis, n.series, n.especienfs, n.emis, n.dtsaidas, n.datans," + ;
                " n.operas, n.correcs, n.cancelas, n.regs," + ;
                " n.cfis, n.clfis, n.codcons, n.conds," + ;
                " n.clifors, n.cgcs," + ;
                " n.basecipis, n.valipis, n.ipis, n.ipincreds," + ;
                " n.basecip2s, n.basecip3s," + ;
                " n.basecicms, n.valicms, n.icms," + ;
                " n.basecic2s, n.basecic3s," + ;
                " n.totprods, n.totnotas, n.vals, n.pesos," + ;
                " n.vlfretes, n.vlseguros, n.despaces," + ;
                " n.codtrans, n.fretes, n.placas, n.ufplacas, n.datatrans," + ;
                " n.qtdes, n.espes, n.marcas, n.numeros, n.pliqs, n.pbrus," + ;
                " n.descsers, n.vtotsers, n.perciss, n.vtotiss," + ;
                " n.impress, n.obss, n.obs2s, n.importas," + ;
                " c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " " + loc_cJoinCfg + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.emps = " + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ;
                loc_cWhereSerie + ;
                loc_cWhereData + ;
                loc_cWhereOpe + ;
                loc_cWhereCan + ;
                loc_cWhereNfi + ;
                " ORDER BY n.nfis, n.emis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.*, c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.cidchaves = " + EscaparSQL(PADR(ALLTRIM(par_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar NF:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        *-- Carregar dados da transportadora automaticamente apos carregar NF
        IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCodtrans))
            THIS.CarregarTransportadora(THIS.this_cCodtrans)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTransportadora - Carrega dados do transportador por codtrans
    *==========================================================================
    PROTECTED PROCEDURE CarregarTransportadora(par_cCodTrans)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cTranspNome = ""
        THIS.this_cTranspEnde = ""
        THIS.this_cTranspCida = ""
        THIS.this_cTranspEsta = ""

        IF EMPTY(par_cCodTrans)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT razaos, endes, cidas, estas" + ;
                " FROM SigPrTrp WHERE itras = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodTrans), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Transp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Transp") AND RECCOUNT("cursor_4c_Transp") > 0
                SELECT cursor_4c_Transp
                THIS.this_cTranspNome = TratarNulo(razaos, "C")
                THIS.this_cTranspEnde = TratarNulo(endes,  "C")
                THIS.this_cTranspCida = TratarNulo(cidas,  "C")
                THIS.this_cTranspEsta = TratarNulo(estas,  "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Transp")
            USE IN cursor_4c_Transp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarSeries - Carrega series para lookup no filtro
    *==========================================================================
    PROCEDURE BuscarSeries(par_cEmpsFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cEmpsFiltro)
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer" + ;
                    " WHERE emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpsFiltro), 3)) + ;
                    " ORDER BY Cods"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Series")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT no SigMvNfi
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvNfi" + ;
                " (cidchaves, empdopnums, emps, dopes, numes," + ;
                "  nfis, series, especienfs, emis, dtsaidas, datans, operas," + ;
                "  correcs, cancelas, regs, cfis, clfis, codcons, conds," + ;
                "  clifors, cgcs, basecipis, valipis, ipis, ipincreds," + ;
                "  basecip2s, basecip3s, basecicms, valicms, icms," + ;
                "  basecic2s, basecic3s, totprods, totnotas, vals, pesos," + ;
                "  vlfretes, vlseguros, despaces, codtrans, fretes," + ;
                "  placas, ufplacas, datatrans," + ;
                "  qtdes, espes, marcas, numeros, pliqs, pbrus," + ;
                "  descsers, vtotsers, perciss, vtotiss, impress, obss, obs2s)" + ;
                " VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmpdopnums), 29)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cSeries), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspecienfs), 6)) + "," + ;
                IIF(EMPTY(THIS.this_tEmis), "NULL", FormatarDataSQL(THIS.this_tEmis)) + "," + ;
                IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                IIF(EMPTY(THIS.this_tDatans), "NULL", FormatarDataSQL(THIS.this_tDatans)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cOperas), 1)) + ","
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lCorrecs, "1", "0") + "," + ;
                IIF(THIS.this_lCancelas, "1", "0") + "," + ;
                IIF(THIS.this_lRegs, "1", "0") + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcons), 9)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cConds), 12)) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCgcs), 21)) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpincreds) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecip2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecip3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nIcms) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecic2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecic3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotNotas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVals) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesos) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                FormatarNumeroSQL(THIS.this_nDespAces) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nFretes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + "," + ;
                IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotiss) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpress) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE no SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvNfi SET" + ;
                " nfis     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                " dtsaidas = " + IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                " correcs  = " + IIF(THIS.this_lCorrecs, "1", "0") + ","
            loc_cSQL = loc_cSQL + ;
                " cfis    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                " clfis   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                " clifors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + ","
            loc_cSQL = loc_cSQL + ;
                " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                " valipis   = " + FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                " ipis      = " + FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecicms) + ","
            loc_cSQL = loc_cSQL + ;
                " valicms  = " + FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                " icms     = " + FormatarNumeroSQL(THIS.this_nIcms) + "," + ;
                " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas) + ","
            loc_cSQL = loc_cSQL + ;
                " vlfretes  = " + FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                " despaces  = " + FormatarNumeroSQL(THIS.this_nDespAces) + ","
            loc_cSQL = loc_cSQL + ;
                " codtrans = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                " fretes   = " + FormatarNumeroSQL(THIS.this_nFretes) + "," + ;
                " placas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                " ufplacas = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + ","
            loc_cSQL = loc_cSQL + ;
                " datatrans = " + IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + "," + ;
                " qtdes     = " + FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                " espes     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + ","
            loc_cSQL = loc_cSQL + ;
                " marcas  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                " numeros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                " pliqs   = " + FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                " pbrus   = " + FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                " descsers = " + EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                " perciss  = " + FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                " vtotiss  = " + FormatarNumeroSQL(THIS.this_nVtotiss) + ","
            loc_cSQL = loc_cSQL + ;
                " obss  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                " obs2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE do SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvNfi" + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

