# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [METODO-INEXISTENTE] Metodo 'THIS.MontarGradeMesAno()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarCalendario()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AjustarTela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarDias()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CmdInserirClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CmdAlterarClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CmdExcluirClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CmdSalvarClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CmdCancelarClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormHOR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1873 linhas total):

*-- Linhas 8 a 81:
8: * Par?metros: pCod = Fase/Setor (char, obrigat?rio)
9: *             pUni = Unidade Produtiva (char, obrigat?rio)
10: * Uso: DO FORM FormHOR WITH pCod, pUni
11: *      OU: CREATEOBJECT("FormHOR", pCod, pUni)
12: *==============================================================================
13: * Layout do form (816x541):
14: *   cnt_4c_Sombra       : cabe?alho escuro (top=0, left=0, 864x80)
15: *   grd_4c_Dados        : grade Mes/Ano (left=80, top=163, 92x346)
16: *   cnt_4c_Calendario   : 42 bot?es de dia + 7 cabe?alhos (left=185, top=163)
17: *   cnt_4c_Dados        : painel de dados do dia selecionado (left=542, top=163)
18: *   obj_4c_CmdEscolha   : 4 bot?es modo (Inserir/Alterar/Excluir/Copiar)
19: *   obj_4c_CmdSalva     : 3 bot?es a??o (Salvar/Cancelar/Encerrar)
20: *==============================================================================
21: 
22: DEFINE CLASS FormHOR AS FormBase
23: 
24:     *-- Dimens?es e comportamento
25:     Width       = 816
26:     Height      = 541
27:     DataSession = 2
28:     ShowWindow = 1
29:     ShowWindow = 0
30:     TitleBar    = 0
31:     ControlBox  = .F.
32:     WindowType  = 1
33:     AutoCenter  = .T.
34:     ShowTips    = .T.
35:     BorderStyle = 3
36: 
37:     *-- BO e estado interno
38:     this_oBusinessObject = .NULL.
39:     this_nSlotAtual      = 0
40: 
41:     *-- Armazena par?metros at? InicializarForm ser chamado
42:     this_cParCod = ""
43:     this_cParUni = ""
44: 
45:     *==========================================================================
46:     * Load - Cria cursores de trabalho (DataSession=2 privada)
47:     * Chamado antes de Init pelo VFP9
48:     *==========================================================================
49:     FUNCTION Load()
50:         CREATE CURSOR crMesAno (Mes C(2), Ano C(4))
51:         SELECT crMesAno
52:         INDEX ON Ano + Mes TAG Ordem
53: 
54:         CREATE CURSOR crCalendario ;
55:             (Data01 D, QtHoras01 N(5,2), Qtds01 N(2,0), ;
56:              Data02 D, QtHoras02 N(5,2), Qtds02 N(2,0), ;
57:              Data03 D, QtHoras03 N(5,2), Qtds03 N(2,0), ;
58:              Data04 D, QtHoras04 N(5,2), Qtds04 N(2,0), ;
59:              Data05 D, QtHoras05 N(5,2), Qtds05 N(2,0), ;
60:              Data06 D, QtHoras06 N(5,2), Qtds06 N(2,0), ;
61:              Data07 D, QtHoras07 N(5,2), Qtds07 N(2,0), ;
62:              Data08 D, QtHoras08 N(5,2), Qtds08 N(2,0), ;
63:              Data09 D, QtHoras09 N(5,2), Qtds09 N(2,0), ;
64:              Data10 D, QtHoras10 N(5,2), Qtds10 N(2,0), ;
65:              Data11 D, QtHoras11 N(5,2), Qtds11 N(2,0), ;
66:              Data12 D, QtHoras12 N(5,2), Qtds12 N(2,0), ;
67:              Data13 D, QtHoras13 N(5,2), Qtds13 N(2,0), ;
68:              Data14 D, QtHoras14 N(5,2), Qtds14 N(2,0), ;
69:              Data15 D, QtHoras15 N(5,2), Qtds15 N(2,0), ;
70:              Data16 D, QtHoras16 N(5,2), Qtds16 N(2,0), ;
71:              Data17 D, QtHoras17 N(5,2), Qtds17 N(2,0), ;
72:              Data18 D, QtHoras18 N(5,2), Qtds18 N(2,0), ;
73:              Data19 D, QtHoras19 N(5,2), Qtds19 N(2,0), ;
74:              Data20 D, QtHoras20 N(5,2), Qtds20 N(2,0), ;
75:              Data21 D, QtHoras21 N(5,2), Qtds21 N(2,0), ;
76:              Data22 D, QtHoras22 N(5,2), Qtds22 N(2,0), ;
77:              Data23 D, QtHoras23 N(5,2), Qtds23 N(2,0), ;
78:              Data24 D, QtHoras24 N(5,2), Qtds24 N(2,0), ;
79:              Data25 D, QtHoras25 N(5,2), Qtds25 N(2,0), ;
80:              Data26 D, QtHoras26 N(5,2), Qtds26 N(2,0), ;
81:              Data27 D, QtHoras27 N(5,2), Qtds27 N(2,0), ;

*-- Linhas 99 a 190:
99:     ENDFUNC
100: 
101:     *==========================================================================
102:     * Init - Valida par?metros e dispara a cadeia FormBase.Init -> InicializarForm
103:     *==========================================================================
104:     FUNCTION Init(par_pCod, par_pUni)
105:         LOCAL loc_lSucesso
106:         loc_lSucesso = .T.
107: 
108:         IF VARTYPE(par_pCod) <> "C" OR EMPTY(par_pCod)
109:             MsgErro("O par" + CHR(226) + "metro de Fase/Setor passado n" + CHR(227) + ;
110:                 "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
111:                 "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos")
112:             loc_lSucesso = .F.
113:         ENDIF
114: 
115:         IF loc_lSucesso AND (VARTYPE(par_pUni) <> "C" OR EMPTY(par_pUni))
116:             MsgErro("O par" + CHR(226) + "metro de Unidade Produtiva passado n" + CHR(227) + ;
117:                 "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
118:                 "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos")
119:             loc_lSucesso = .F.
120:         ENDIF
121: 
122:         IF loc_lSucesso
123:             THIS.this_cParCod = par_pCod
124:             THIS.this_cParUni = par_pUni
125:         ENDIF
126: 
127:         *-- DODEFAULT fora do TRY: chama FormBase.Init -> InicializarForm
128:         RETURN IIF(loc_lSucesso, DODEFAULT(), .F.)
129:     ENDFUNC
130: 
131:     *==========================================================================
132:     * InicializarForm - Cria todos os controles, carrega dados, BINDEVENT
133:     * Chamado por FormBase.Init via DODEFAULT()
134:     *==========================================================================
135:     PROTECTED FUNCTION InicializarForm()
136:         LOCAL loc_oErro, loc_lSucesso
137:         LOCAL loc_nObj, loc_cNome, loc_nRow, loc_nCol, loc_nTop, loc_nLeft
138:         LOCAL loc_aDias(7)
139:         loc_lSucesso = .F.
140: 
141:         TRY
142:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
143:             SET DATE TO BRITISH
144:             SET CENTURY ON
145:             THIS.Caption = "Cadastro de Carga Hor" + CHR(225) + "ria"
146: 
147:             *-- BO
148:             THIS.this_oBusinessObject = CREATEOBJECT("HORBO")
149:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
150:                 MsgErro("Falha ao criar HORBO.", "InicializarForm")
151:             ELSE
152:             THIS.this_oBusinessObject.this_cSetors   = THIS.this_cParCod
153:             THIS.this_oBusinessObject.this_cUniPrdts = THIS.this_cParUni
154: 
155:             *-- ===== SOMBRA (CABE?ALHO ESCURO) =====
156:             THIS.AddObject("cnt_4c_Sombra", "Container")
157:             WITH THIS.cnt_4c_Sombra
158:                 .Top         = 0
159:                 .Left        = 0
160:                 .Width       = THIS.Width
161:                 .Height      = 80
162:                 .BorderWidth = 0
163:                 .BackColor   = RGB(100,100,100)
164:                 .Visible     = .T.
165: 
166:                 .AddObject("lbl_4c_LblSombra", "Label")
167:                 WITH .lbl_4c_LblSombra
168:                     .AutoSize    = .F.
169:                     .FontBold    = .T.
170:                     .FontName    = "Tahoma"
171:                     .FontSize    = 18
172:                     .WordWrap    = .T.
173:                     .Alignment   = 0
174:                     .BackStyle   = 0
175:                     .Width       = THIS.Width
176:                     .Height      = 40
177:                     .Left        = 10
178:                     .Top         = 18
179:                     .ForeColor   = RGB(0,0,0)
180:                     .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
181:                     .Visible     = .T.
182:                 ENDWITH
183: 
184:                 .AddObject("lbl_4c_LblTitulo", "Label")
185:                 WITH .lbl_4c_LblTitulo
186:                     .AutoSize    = .F.
187:                     .FontBold    = .T.
188:                     .FontName    = "Tahoma"
189:                     .FontSize    = 18
190:                     .WordWrap    = .T.

*-- Linhas 391 a 437:
391:                 NEXT
392:             ENDWITH
393: 
394:             *-- BINDEVENT para os 42 bot?es do calend?rio
395:             FOR loc_nObj = 1 TO 42
396:                 loc_cNome = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
397:                 BINDEVENT(THIS.cnt_4c_Calendario.&loc_cNome., "Click", THIS, "ChkClick")
398:             NEXT
399: 
400:             *-- ===== CONTAINER DADOS (painel lateral direito) =====
401:             THIS.AddObject("cnt_4c_Dados", "Container")
402:             WITH THIS.cnt_4c_Dados
403:                 .Top           = 163
404:                 .Left          = 542
405:                 .Width         = 195
406:                 .Height        = 199
407:                 .SpecialEffect = 0
408:                 .BackColor     = RGB(255,255,255)
409:                 .BorderColor   = RGB(128,128,128)
410:                 .Visible       = .T.
411: 
412:                 *-- Bot?o indicador do per?odo selecionado
413:                 .AddObject("cmd_4c_BtnData", "CommandButton")
414:                 WITH .cmd_4c_BtnData
415:                     .Top       = 3
416:                     .Left      = 4
417:                     .Width     = 186
418:                     .Height    = 42
419:                     .FontBold  = .T.
420:                     .FontName  = "Verdana"
421:                     .FontSize  = 10
422:                     .WordWrap  = .T.
423:                     .Caption   = "00/00/0000"
424:                     .ForeColor = RGB(90,90,90)
425:                     .BackColor = RGB(255,255,255)
426:                     .Enabled   = .F.
427:                     .Visible   = .T.
428:                 ENDWITH
429: 
430:                 *-- Separador superior
431:                 .AddObject("cnt_4c__periodo", "Container")
432:                 WITH .cnt_4c__periodo
433:                     .Top           = 47
434:                     .Left          = 4
435:                     .Width         = 186
436:                     .Height        = 6
437:                     .SpecialEffect = 0

*-- Linhas 594 a 639:
594:                 ENDWITH
595:             ENDWITH
596: 
597:             *-- BINDEVENT nos campos de dados (atualiza calend?rio ao perder foco)
598:             BINDEVENT(THIS.cnt_4c_Dados.txt_4c_Qtds,    "LostFocus", THIS, "ValidarQtdsQtHoras")
599:             BINDEVENT(THIS.cnt_4c_Dados.txt_4c_QtHoras, "LostFocus", THIS, "ValidarQtdsQtHoras")
600: 
601:             *-- ===== COMMANDGROUP ESCOLHA (4 bot?es de modo) =====
602:             THIS.AddObject("obj_4c_CmdEscolha", "CommandGroup")
603:             WITH THIS.obj_4c_CmdEscolha
604:                 .ButtonCount   = 4
605:                 .Top           = -1
606:                 .Left          = 247
607:                 .Width         = 312
608:                 .Height        = 85
609:                 .BorderStyle   = 0
610:                 .SpecialEffect = 1
611:                 .BorderColor   = RGB(136,189,188)
612:                 .Value         = 0
613:                 .Visible       = .T.
614: 
615:                 WITH .Buttons(1)
616:                     .Name        = "btnInserir"
617:                     .Top         = 5
618:                     .Left        = 5
619:                     .Width       = 75
620:                     .Height      = 75
621:                     .FontBold    = .T.
622:                     .FontItalic  = .T.
623:                     .WordWrap    = .T.
624:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
625:                     .Caption     = "\<Inserir"
626:                     .ToolTipText = "Inserir Um Novo Per" + CHR(237) + "odo"
627:                     .ForeColor   = RGB(90,90,90)
628:                     .BackColor   = RGB(255,255,255)
629:                     .Themes      = .F.
630:                 ENDWITH
631: 
632:                 WITH .Buttons(2)
633:                     .Name        = "btnAlterar"
634:                     .Top         = 5
635:                     .Left        = 82
636:                     .Width       = 75
637:                     .Height      = 75
638:                     .FontBold    = .T.
639:                     .FontItalic  = .T.

*-- Linhas 687 a 733:
687:                 ENDWITH
688:             ENDWITH
689: 
690:             BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(1), "Click", THIS, "CmdInserirClick")
691:             BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(2), "Click", THIS, "CmdAlterarClick")
692:             BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(3), "Click", THIS, "CmdExcluirClick")
693:             BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(4), "Click", THIS, "CmdCopiarPClick")
694: 
695:             *-- ===== COMMANDGROUP SALVA (3 bot?es de a??o) =====
696:             THIS.AddObject("obj_4c_CmdSalva", "CommandGroup")
697:             WITH THIS.obj_4c_CmdSalva
698:                 .ButtonCount   = 3
699:                 .Top           = -1
700:                 .Left          = 572
701:                 .Width         = 235
702:                 .Height        = 85
703:                 .BorderStyle   = 0
704:                 .SpecialEffect = 1
705:                 .BorderColor   = RGB(136,189,188)
706:                 .Value         = 1
707:                 .Visible       = .T.
708: 
709:                 WITH .Buttons(1)
710:                     .Name        = "btnConfirmar"
711:                     .Top         = 5
712:                     .Left        = 5
713:                     .Width       = 75
714:                     .Height      = 75
715:                     .FontBold    = .T.
716:                     .FontItalic  = .T.
717:                     .WordWrap    = .T.
718:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
719:                     .Caption     = "\<Salvar"
720:                     .ToolTipText = "Gravar os Dados"
721:                     .ForeColor   = RGB(90,90,90)
722:                     .BackColor   = RGB(255,255,255)
723:                     .Themes      = .F.
724:                 ENDWITH
725: 
726:                 WITH .Buttons(2)
727:                     .Name        = "btnSair"
728:                     .Top         = 5
729:                     .Left        = 155
730:                     .Width       = 75
731:                     .Height      = 75
732:                     .FontBold    = .T.
733:                     .FontItalic  = .T.

*-- Linhas 764 a 838:
764:                 ENDWITH
765:             ENDWITH
766: 
767:             BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(1), "Click", THIS, "CmdSalvarClick")
768:             BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(2), "Click", THIS, "CmdEncerrarClick")
769:             BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(3), "Click", THIS, "CmdCancelarClick")
770: 
771:             *-- BINDEVENT na grade (navega??o de linha atualiza calend?rio)
772:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdMesAnoAfterRowColChange")
773: 
774:             THIS.ConfigurarPaginaDados()
775: 
776:             *-- ===== CARGA INICIAL DE DADOS =====
777:             THIS.this_oBusinessObject.CarregarDescricaoFase()
778:             THIS.txt_4c_Fases.Value    = ALLTRIM(THIS.this_cParCod)
779:             THIS.txt_4c_DFases.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDFases)
780:             THIS.txt_4c_UniPrdts.Value = ALLTRIM(THIS.this_cParUni)
781: 
782:             THIS.MontarGradeMesAno()
783:             THIS.ConfigurarPaginaLista()
784: 
785:             IF USED("crMesAno") AND !EOF("crMesAno")
786:                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
787:             ELSE
788:                 THIS.AjustarTela()
789:             ENDIF
790: 
791:             THIS.grd_4c_Dados.SetFocus()
792:             loc_lSucesso = .T.
793:             ENDIF
794:         CATCH TO loc_oErro
795:             MsgErro(loc_oErro.Message + CHR(13) + ;
796:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
797:                 "Procedure: " + loc_oErro.Procedure, ;
798:                 "Erro em FormHOR.InicializarForm")
799:         ENDTRY
800: 
801:         DODEFAULT()
802:         RETURN loc_lSucesso
803:     ENDFUNC
804: 
805:     *==========================================================================
806:     * Destroy - Libera cursores e BO
807:     *==========================================================================
808:     FUNCTION Destroy()
809:         IF USED("crCalendario")
810:             USE IN crCalendario
811:         ENDIF
812:         IF USED("crMesAno")
813:             USE IN crMesAno
814:         ENDIF
815:         IF USED("crSigCdThs")
816:             USE IN crSigCdThs
817:         ENDIF
818:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
819:             THIS.this_oBusinessObject = .NULL.
820:         ENDIF
821:         DODEFAULT()
822:     ENDFUNC
823: 
824:     *==========================================================================
825:     * AjustarTela - Regula estado dos controles conforme modo e dados dispon?veis
826:     * Chamado ao: abrir, ap?s salvar, cancelar
827:     *==========================================================================
828:     FUNCTION AjustarTela()
829:         LOCAL loc_oErro, loc_lTemRegistros
830:         loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0
831: 
832:         TRY
833:             THIS.this_oBusinessObject.this_cPcEscolha = "CONSULTAR"
834: 
835:             WITH THIS
836:                 .grd_4c_Dados.Enabled              = loc_lTemRegistros
837:                 .cnt_4c_Calendario.Enabled          = loc_lTemRegistros
838:                 .cnt_4c_Dados.Visible               = .T.

*-- Linhas 875 a 942:
875:         CATCH TO loc_oErro
876:             MsgErro(loc_oErro.Message + CHR(13) + ;
877:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
878:                 "Procedure: " + loc_oErro.Procedure, ;
879:                 "Erro em FormHOR.AjustarTela")
880:         ENDTRY
881:     ENDFUNC
882: 
883:     *==========================================================================
884:     * MontarGradeMesAno - Popula crMesAno via BO e atualiza a grade
885:     *==========================================================================
886:     FUNCTION MontarGradeMesAno()
887:         LOCAL loc_lSucesso, loc_oErro
888:         loc_lSucesso = .F.
889: 
890:         TRY
891:             loc_lSucesso = THIS.this_oBusinessObject.MontarGradeMesAno()
892: 
893:             IF loc_lSucesso
894:                 THIS.grd_4c_Dados.Refresh()
895:                 IF USED("crMesAno") AND !EOF("crMesAno")
896:                     THIS.grd_4c_Dados.Column1.SetFocus()
897:                 ENDIF
898:             ENDIF
899:         CATCH TO loc_oErro
900:             MsgErro(loc_oErro.Message + CHR(13) + ;
901:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
902:                 "Procedure: " + loc_oErro.Procedure, ;
903:                 "Erro em FormHOR.MontarGradeMesAno")
904:             loc_lSucesso = .F.
905:         ENDTRY
906: 
907:         RETURN loc_lSucesso
908:     ENDFUNC
909: 
910:     *==========================================================================
911:     * MontarCalendario - Popula crCalendario via BO e atualiza os 42 bot?es
912:     * par_cMes : m?s (char 2)
913:     * par_cAno : ano (char 4)
914:     *==========================================================================
915:     FUNCTION MontarCalendario(par_cMes, par_cAno)
916:         LOCAL loc_lSucesso, loc_oErro
917:         LOCAL loc_nObj, loc_cObj, loc_ldDia
918:         LOCAL loc_nQth, loc_nQtd, loc_nHor, loc_cHrr
919:         loc_lSucesso = .F.
920: 
921:         TRY
922:             THIS.this_oBusinessObject.this_cMes = par_cMes
923:             THIS.this_oBusinessObject.this_cAno = par_cAno
924: 
925:             loc_lSucesso = THIS.this_oBusinessObject.MontarCalendario(par_cMes, par_cAno, .F.)
926: 
927:             IF loc_lSucesso
928:                 IF USED("crCalendario") AND RECCOUNT("crCalendario") > 0
929:                     *-- Atualiza os 42 bot?es com dados do crCalendario
930:                     FOR loc_nObj = 1 TO 42
931:                         loc_cObj  = PADL(loc_nObj, 2, "0")
932:                         loc_ldDia = EVALUATE("crCalendario.Data" + loc_cObj)
933: 
934:                         IF !EMPTY(loc_ldDia)
935:                             loc_nQth = EVALUATE("crCalendario.QtHoras" + loc_cObj)
936:                             loc_nQtd = EVALUATE("crCalendario.Qtds"    + loc_cObj)
937:                             loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
938:                             loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")
939: 
940:                             WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
941:                                 .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
942:                                 .Caption   = "  " + SUBSTR(DTOC(loc_ldDia), 1, 2) + "   " + loc_cHrr

*-- Linhas 981 a 1024:
981:         CATCH TO loc_oErro
982:             MsgErro(loc_oErro.Message + CHR(13) + ;
983:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
984:                 "Procedure: " + loc_oErro.Procedure, ;
985:                 "Erro em FormHOR.MontarCalendario")
986:             loc_lSucesso = .F.
987:         ENDTRY
988: 
989:         RETURN loc_lSucesso
990:     ENDFUNC
991: 
992:     *==========================================================================
993:     * ValidarDias - Atualiza painel lateral com dados do slot selecionado
994:     * par_cSlot : n?mero do slot "01"-"42" (n?mero do bot?o clicado)
995:     *==========================================================================
996:     FUNCTION ValidarDias(par_cSlot)
997:         LOCAL loc_oErro, loc_ldDat, loc_nQth, loc_nQtd, loc_nTot
998:         LOCAL loc_cEscolha
999: 
1000:         TRY
1001:             THIS.this_nSlotAtual = INT(VAL(par_cSlot))
1002: 
1003:             IF THIS.this_nSlotAtual >= 1 AND THIS.this_nSlotAtual <= 42
1004:                 loc_ldDat = EVALUATE("crCalendario.Data" + par_cSlot)
1005: 
1006:                 IF !EMPTY(loc_ldDat)
1007:                     loc_nQth = EVALUATE("crCalendario.QtHoras" + par_cSlot)
1008:                     loc_nQtd = EVALUATE("crCalendario.Qtds"    + par_cSlot)
1009:                     loc_nTot = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
1010: 
1011:                     loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha
1012: 
1013:                     WITH THIS.cnt_4c_Dados
1014:                         .Visible = .T.
1015:                         .cmd_4c_BtnData.Caption = SUBSTR(DTOC(loc_ldDat), 1, 2) + "/" + ;
1016:                                                   crMesAno.Mes + "/" + crMesAno.Ano
1017:                         .txt_4c_Mes.Value       = crMesAno.Mes
1018:                         .txt_4c_Ano.Value       = crMesAno.Ano
1019: 
1020:                         .txt_4c_Mes.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")
1021:                         .txt_4c_Ano.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")
1022:                         .txt_4c_Qtds.Enabled    = INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
1023:                         .txt_4c_QtHoras.Enabled = INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
1024: 

*-- Linhas 1044 a 1297:
1044:         CATCH TO loc_oErro
1045:             MsgErro(loc_oErro.Message + CHR(13) + ;
1046:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1047:                 "Procedure: " + loc_oErro.Procedure, ;
1048:                 "Erro em FormHOR.ValidarDias")
1049:         ENDTRY
1050:     ENDFUNC
1051: 
1052:     *==========================================================================
1053:     * ValidarQtdsQtHoras - Handler LostFocus de txt_4c_Qtds e txt_4c_QtHoras
1054:     * Atualiza crCalendario e o bot?o do calend?rio para o slot atual
1055:     *==========================================================================
1056:     FUNCTION ValidarQtdsQtHoras()
1057:         LOCAL loc_oErro, loc_cSlot, loc_ldDat
1058:         LOCAL loc_nQth, loc_nQtd, loc_nHor, loc_cHrr
1059: 
1060:         TRY
1061:             IF THIS.this_nSlotAtual >= 1 AND THIS.this_nSlotAtual <= 42
1062:                 loc_cSlot = PADL(THIS.this_nSlotAtual, 2, "0")
1063:                 loc_ldDat = EVALUATE("crCalendario.Data" + loc_cSlot)
1064: 
1065:                 IF !EMPTY(loc_ldDat) AND USED("crCalendario")
1066:                     loc_nQth = THIS.cnt_4c_Dados.txt_4c_QtHoras.Value
1067:                     loc_nQtd = THIS.cnt_4c_Dados.txt_4c_Qtds.Value
1068: 
1069:                     SELECT crCalendario
1070:                     REPLACE ("QtHoras" + loc_cSlot) WITH loc_nQth, ;
1071:                             ("Qtds"    + loc_cSlot) WITH loc_nQtd
1072: 
1073:                     loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
1074:                     loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")
1075: 
1076:                     WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cSlot)
1077:                         .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
1078:                         .Caption   = "  " + SUBSTR(DTOC(loc_ldDat), 1, 2) + "   " + loc_cHrr
1079:                     ENDWITH
1080: 
1081:                     THIS.cnt_4c_Dados.txt_4c_TotHoras.Value = loc_nHor
1082:                 ENDIF
1083:             ENDIF
1084:         CATCH TO loc_oErro
1085:             MsgErro(loc_oErro.Message + CHR(13) + ;
1086:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1087:                 "Procedure: " + loc_oErro.Procedure, ;
1088:                 "Erro em FormHOR.ValidarQtdsQtHoras")
1089:         ENDTRY
1090:     ENDFUNC
1091: 
1092:     *==========================================================================
1093:     * ChkClick - Handler compartilhado para o Click dos 42 bot?es de dia
1094:     * Identifica o bot?o pelo ActiveControl.Name
1095:     *==========================================================================
1096:     FUNCTION ChkClick()
1097:         LOCAL loc_oErro, loc_cNome, loc_cSlot
1098: 
1099:         TRY
1100:             loc_cNome = ""
1101:             IF VARTYPE(THIS.ActiveControl) = "O"
1102:                 loc_cNome = ALLTRIM(THIS.ActiveControl.Name)
1103:             ENDIF
1104: 
1105:             IF LEFT(loc_cNome, 10) = "cmd_4c_Chk"
1106:                 loc_cSlot = SUBSTR(loc_cNome, 11, 2)
1107:                 THIS.ValidarDias(loc_cSlot)
1108:             ENDIF
1109:         CATCH TO loc_oErro
1110:             MsgErro(loc_oErro.Message + CHR(13) + ;
1111:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1112:                 "Procedure: " + loc_oErro.Procedure, ;
1113:                 "Erro em FormHOR.ChkClick")
1114:         ENDTRY
1115:     ENDFUNC
1116: 
1117:     *==========================================================================
1118:     * GrdMesAnoAfterRowColChange - Atualiza calend?rio ao navegar na grade
1119:     *==========================================================================
1120:     FUNCTION GrdMesAnoAfterRowColChange()
1121:         LPARAMETERS par_nColIndex
1122:         LOCAL loc_oErro
1123: 
1124:         TRY
1125:             IF USED("crMesAno") AND !EOF("crMesAno")
1126:                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1127:             ENDIF
1128:         CATCH TO loc_oErro
1129:             MsgErro(loc_oErro.Message + CHR(13) + ;
1130:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1131:                 "Procedure: " + loc_oErro.Procedure, ;
1132:                 "Erro em FormHOR.GrdMesAnoAfterRowColChange")
1133:         ENDTRY
1134:     ENDFUNC
1135: 
1136:     *==========================================================================
1137:     * CmdInserirClick - Modo INSERIR: solicita novo m?s/ano ao usu?rio
1138:     *==========================================================================
1139:     FUNCTION CmdInserirClick()
1140:         LOCAL loc_oErro
1141: 
1142:         TRY
1143:             THIS.this_oBusinessObject.this_cPcEscolha = "INSERIR"
1144: 
1145:             WITH THIS
1146:                 .grd_4c_Dados.Enabled              = .F.
1147:                 .cnt_4c_Calendario.Enabled          = .F.
1148:                 .cnt_4c_Dados.Visible               = .T.
1149:                 .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Inserir"
1150:                 .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
1151:                 .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
1152:                 .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
1153:                 .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
1154:                 .cnt_4c_Dados.txt_4c_Mes.Value      = ""
1155:                 .cnt_4c_Dados.txt_4c_Ano.Value      = ""
1156:                 .cnt_4c_Dados.txt_4c_Qtds.Value     = 0
1157:                 .cnt_4c_Dados.txt_4c_QtHoras.Value  = 0
1158:                 .cnt_4c_Dados.txt_4c_TotHoras.Value = 0
1159:                 .cnt_4c_Dados.txt_4c_Mes.SetFocus()
1160:             ENDWITH
1161: 
1162:             WITH THIS.obj_4c_CmdEscolha
1163:                 .Buttons(1).Enabled = .F.
1164:                 .Buttons(2).Enabled = .F.
1165:                 .Buttons(3).Enabled = .F.
1166:                 .Buttons(4).Enabled = .F.
1167:             ENDWITH
1168: 
1169:             WITH THIS.obj_4c_CmdSalva
1170:                 .Buttons(1).Enabled = .T.
1171:                 .Buttons(2).Enabled = .F.
1172:                 .Buttons(3).Enabled = .T.
1173:             ENDWITH
1174:         CATCH TO loc_oErro
1175:             MsgErro(loc_oErro.Message + CHR(13) + ;
1176:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1177:                 "Procedure: " + loc_oErro.Procedure, ;
1178:                 "Erro em FormHOR.CmdInserirClick")
1179:         ENDTRY
1180:     ENDFUNC
1181: 
1182:     *==========================================================================
1183:     * CmdAlterarClick - Modo ALTERAR: permite editar horas/qtd no calend?rio
1184:     *==========================================================================
1185:     FUNCTION CmdAlterarClick()
1186:         LOCAL loc_oErro
1187: 
1188:         TRY
1189:             THIS.this_oBusinessObject.this_cPcEscolha = "ALTERAR"
1190: 
1191:             WITH THIS
1192:                 .grd_4c_Dados.Enabled              = .F.
1193:                 .cnt_4c_Calendario.Enabled          = .T.
1194:                 .cnt_4c_Dados.Visible               = .T.
1195:                 .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
1196:                 .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
1197:                 .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .T.
1198:                 .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .T.
1199:             ENDWITH
1200: 
1201:             WITH THIS.obj_4c_CmdEscolha
1202:                 .Buttons(1).Enabled = .F.
1203:                 .Buttons(2).Enabled = .F.
1204:                 .Buttons(3).Enabled = .F.
1205:                 .Buttons(4).Enabled = .F.
1206:             ENDWITH
1207: 
1208:             WITH THIS.obj_4c_CmdSalva
1209:                 .Buttons(1).Enabled = .T.
1210:                 .Buttons(2).Enabled = .F.
1211:                 .Buttons(3).Enabled = .T.
1212:             ENDWITH
1213:         CATCH TO loc_oErro
1214:             MsgErro(loc_oErro.Message + CHR(13) + ;
1215:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1216:                 "Procedure: " + loc_oErro.Procedure, ;
1217:                 "Erro em FormHOR.CmdAlterarClick")
1218:         ENDTRY
1219:     ENDFUNC
1220: 
1221:     *==========================================================================
1222:     * CmdExcluirClick - Modo EXCLUIR: confirma??o e exclus?o do per?odo
1223:     *==========================================================================
1224:     FUNCTION CmdExcluirClick()
1225:         LOCAL loc_oErro
1226: 
1227:         TRY
1228:             THIS.this_oBusinessObject.this_cPcEscolha = "EXCLUIR"
1229: 
1230:             WITH THIS
1231:                 .grd_4c_Dados.Enabled              = .F.
1232:                 .cnt_4c_Calendario.Enabled          = .F.
1233:                 .cnt_4c_Dados.Visible               = .T.
1234:                 .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Excluir"
1235:                 .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
1236:                 .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
1237:                 .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
1238:                 .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
1239:             ENDWITH
1240: 
1241:             WITH THIS.obj_4c_CmdEscolha
1242:                 .Buttons(1).Enabled = .F.
1243:                 .Buttons(2).Enabled = .F.
1244:                 .Buttons(3).Enabled = .F.
1245:                 .Buttons(4).Enabled = .F.
1246:             ENDWITH
1247: 
1248:             WITH THIS.obj_4c_CmdSalva
1249:                 .Buttons(1).Enabled = .T.
1250:                 .Buttons(2).Enabled = .F.
1251:                 .Buttons(3).Enabled = .T.
1252:                 .Buttons(3).SetFocus()
1253:             ENDWITH
1254:         CATCH TO loc_oErro
1255:             MsgErro(loc_oErro.Message + CHR(13) + ;
1256:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1257:                 "Procedure: " + loc_oErro.Procedure, ;
1258:                 "Erro em FormHOR.CmdExcluirClick")
1259:         ENDTRY
1260:     ENDFUNC
1261: 
1262:     *==========================================================================
1263:     * CmdCopiarPClick - Modo COPIARP: copia o per?odo selecionado para novo m?s
1264:     *==========================================================================
1265:     FUNCTION CmdCopiarPClick()
1266:         LOCAL loc_oErro, loc_lTemDados
1267:         loc_lTemDados = USED("crMesAno") AND !EOF("crMesAno")
1268: 
1269:         TRY
1270:             IF loc_lTemDados
1271:                 THIS.this_oBusinessObject.this_cPcEscolha = "COPIARP"
1272: 
1273:                 WITH THIS
1274:                     .grd_4c_Dados.Enabled              = .F.
1275:                     .cnt_4c_Calendario.Enabled          = .F.
1276:                     .cnt_4c_Dados.Visible               = .T.
1277:                     .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Copiar " + crMesAno.Mes + "/" + crMesAno.Ano
1278:                     .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
1279:                     .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
1280:                     .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
1281:                     .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
1282:                     .cnt_4c_Dados.txt_4c_Mes.Value      = ""
1283:                     .cnt_4c_Dados.txt_4c_Ano.Value      = ""
1284:                     .cnt_4c_Dados.txt_4c_Qtds.Value     = 0
1285:                     .cnt_4c_Dados.txt_4c_QtHoras.Value  = 0
1286:                     .cnt_4c_Dados.txt_4c_TotHoras.Value = 0
1287:                     .cnt_4c_Dados.txt_4c_Mes.SetFocus()
1288:                 ENDWITH
1289: 
1290:                 WITH THIS.obj_4c_CmdEscolha
1291:                     .Buttons(1).Enabled = .F.
1292:                     .Buttons(2).Enabled = .F.
1293:                     .Buttons(3).Enabled = .F.
1294:                     .Buttons(4).Enabled = .F.
1295:                 ENDWITH
1296: 
1297:                 WITH THIS.obj_4c_CmdSalva

*-- Linhas 1303 a 1499:
1303:         CATCH TO loc_oErro
1304:             MsgErro(loc_oErro.Message + CHR(13) + ;
1305:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1306:                 "Procedure: " + loc_oErro.Procedure, ;
1307:                 "Erro em FormHOR.CmdCopiarPClick")
1308:         ENDTRY
1309:     ENDFUNC
1310: 
1311:     *==========================================================================
1312:     * CmdSalvarClick - Executa a opera??o do modo atual (INSERIR/ALTERAR/EXCLUIR/COPIARP)
1313:     *==========================================================================
1314:     FUNCTION CmdSalvarClick()
1315:         LOCAL loc_oErro, loc_lSucesso, loc_cEscolha
1316:         LOCAL loc_cMes, loc_cAno, loc_cMesOrig, loc_cAnoOrig, loc_cMesDest, loc_cAnoDest
1317:         loc_lSucesso = .F.
1318: 
1319:         TRY
1320:             loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha
1321: 
1322:             DO CASE
1323:                 CASE loc_cEscolha = "INSERIR"
1324:                     loc_cMes = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value), 2, "0")
1325:                     loc_cAno = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value), 4, "0")
1326: 
1327:                     IF EMPTY(ALLTRIM(loc_cMes)) OR EMPTY(ALLTRIM(loc_cAno))
1328:                         MsgAviso("Informe o M" + CHR(234) + "s e o Ano para inserir.")
1329:                         THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
1330:                     ELSE
1331:                         loc_lSucesso = THIS.this_oBusinessObject.InserirPeriodo(loc_cMes, loc_cAno)
1332: 
1333:                         IF loc_lSucesso
1334:                             THIS.MontarGradeMesAno()
1335:                             SET NEAR ON
1336:                             =SEEK(loc_cAno + loc_cMes, "crMesAno", "Ordem")
1337:                             SET NEAR OFF
1338:                             IF !EOF("crMesAno")
1339:                                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1340:                             ENDIF
1341:                         ENDIF
1342:                     ENDIF
1343: 
1344:                 CASE loc_cEscolha = "ALTERAR"
1345:                     loc_lSucesso = THIS.this_oBusinessObject.AlterarPeriodo()
1346: 
1347:                     IF loc_lSucesso AND USED("crMesAno") AND !EOF("crMesAno")
1348:                         THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1349:                     ENDIF
1350: 
1351:                 CASE loc_cEscolha = "EXCLUIR"
1352:                     IF USED("crMesAno") AND !EOF("crMesAno")
1353:                         loc_cMes = ALLTRIM(crMesAno.Mes)
1354:                         loc_cAno = ALLTRIM(crMesAno.Ano)
1355:                         loc_lSucesso = THIS.this_oBusinessObject.ExcluirPeriodo(loc_cMes, loc_cAno)
1356:                         IF loc_lSucesso
1357:                             THIS.MontarGradeMesAno()
1358:                         ENDIF
1359:                     ENDIF
1360: 
1361:                 CASE loc_cEscolha = "COPIARP"
1362:                     IF USED("crMesAno") AND !EOF("crMesAno")
1363:                         loc_cMesOrig = ALLTRIM(crMesAno.Mes)
1364:                         loc_cAnoOrig = ALLTRIM(crMesAno.Ano)
1365:                         loc_cMesDest = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value), 2, "0")
1366:                         loc_cAnoDest = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value), 4, "0")
1367: 
1368:                         IF EMPTY(ALLTRIM(loc_cMesDest)) OR EMPTY(ALLTRIM(loc_cAnoDest))
1369:                             MsgAviso("Informe o M" + CHR(234) + "s e o Ano de destino para copiar.")
1370:                             THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
1371:                         ELSE
1372:                             loc_lSucesso = THIS.this_oBusinessObject.CopiarPeriodo( ;
1373:                                 loc_cMesOrig, loc_cAnoOrig, loc_cMesDest, loc_cAnoDest)
1374: 
1375:                             IF loc_lSucesso
1376:                                 THIS.MontarGradeMesAno()
1377:                                 SET NEAR ON
1378:                                 =SEEK(loc_cAnoDest + loc_cMesDest, "crMesAno", "Ordem")
1379:                                 SET NEAR OFF
1380:                                 IF !EOF("crMesAno")
1381:                                     THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1382:                                 ENDIF
1383:                             ENDIF
1384:                         ENDIF
1385:                     ENDIF
1386:             ENDCASE
1387: 
1388:             IF loc_lSucesso OR (loc_cEscolha = "ALTERAR" AND !loc_lSucesso)
1389:                 THIS.AjustarTela()
1390:             ENDIF
1391:         CATCH TO loc_oErro
1392:             MsgErro(loc_oErro.Message + CHR(13) + ;
1393:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1394:                 "Procedure: " + loc_oErro.Procedure, ;
1395:                 "Erro em FormHOR.CmdSalvarClick")
1396:         ENDTRY
1397:     ENDFUNC
1398: 
1399:     *==========================================================================
1400:     * CmdCancelarClick - Cancela opera??o e retorna ao modo CONSULTAR
1401:     *==========================================================================
1402:     FUNCTION CmdCancelarClick()
1403:         LOCAL loc_oErro
1404: 
1405:         TRY
1406:             THIS.AjustarTela()
1407:             IF USED("crMesAno") AND !EOF("crMesAno")
1408:                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1409:             ENDIF
1410:         CATCH TO loc_oErro
1411:             MsgErro(loc_oErro.Message + CHR(13) + ;
1412:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1413:                 "Procedure: " + loc_oErro.Procedure, ;
1414:                 "Erro em FormHOR.CmdCancelarClick")
1415:         ENDTRY
1416:     ENDFUNC
1417: 
1418:     *==========================================================================
1419:     * CmdEncerrarClick - Fecha o form
1420:     *==========================================================================
1421:     FUNCTION CmdEncerrarClick()
1422:         THIS.Release()
1423:     ENDFUNC
1424: 
1425:     *==========================================================================
1426:     * ConfigurarPaginaDados - Inicializa o painel lateral de dados do dia
1427:     * (cnt_4c_Dados) para o estado padr?o: campos zerados, edi??o desabilitada,
1428:     * painel vis?vel. Chamado em InicializarForm e em AjustarTela (sem registros).
1429:     *==========================================================================
1430:     PROTECTED FUNCTION ConfigurarPaginaDados()
1431:         LOCAL loc_oErro, loc_lSucesso
1432:         loc_lSucesso = .F.
1433: 
1434:         TRY
1435:             WITH THIS.cnt_4c_Dados
1436:                 .Visible                 = .T.
1437:                 .cmd_4c_BtnData.Caption  = "00/00/0000"
1438: 
1439:                 .txt_4c_Mes.Value        = ""
1440:                 .txt_4c_Mes.Enabled      = .F.
1441: 
1442:                 .txt_4c_Ano.Value        = ""
1443:                 .txt_4c_Ano.Enabled      = .F.
1444: 
1445:                 .txt_4c_Qtds.Value       = 0
1446:                 .txt_4c_Qtds.Enabled     = .F.
1447: 
1448:                 .txt_4c_QtHoras.Value    = 0
1449:                 .txt_4c_QtHoras.Enabled  = .F.
1450: 
1451:                 .txt_4c_TotHoras.Value   = 0
1452:                 .txt_4c_TotHoras.Enabled = .F.
1453:             ENDWITH
1454: 
1455:             loc_lSucesso = .T.
1456:         CATCH TO loc_oErro
1457:             MsgErro(loc_oErro.Message + CHR(13) + ;
1458:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1459:                 "Procedure: " + loc_oErro.Procedure, ;
1460:                 "Erro em FormHOR.ConfigurarPaginaDados")
1461:         ENDTRY
1462: 
1463:         RETURN loc_lSucesso
1464:     ENDFUNC
1465: 
1466:     *==========================================================================
1467:     * ConfigurarPaginaLista - Aplica formata??o e estado de "lista" (grade
1468:     * Mes/Ano + bot?es de escolha) neste form OPERACIONAL. Corresponde ao
1469:     * setup de Page1 dos forms CRUD, adaptado para o layout customizado.
1470:     * - Formata fontes/cores/headers da grade Mes/Ano
1471:     * - Ajusta habilitacao dos bot?es de escolha conforme haja registros
1472:     * - Refresca a grade
1473:     *==========================================================================
1474:     PROTECTED FUNCTION ConfigurarPaginaLista()
1475:         LOCAL loc_oErro, loc_lTemRegistros, loc_lSucesso
1476:         loc_lSucesso = .F.
1477: 
1478:         TRY
1479:             loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0
1480: 
1481:             *-- Formatacao visual da grade (fontes, alinhamento, headers)
1482:             WITH THIS.grd_4c_Dados
1483:                 .FontName = "Courier New"
1484:                 .FontSize = 9
1485:                 .SetAll("FontName", "Courier New", "Textbox")
1486:                 .SetAll("FontSize", 9,             "Textbox")
1487:                 .SetAll("Alignment", 2,            "Header")
1488:                 .SetAll("ForeColor", RGB(36,84,155), "Header")
1489:                 .SetAll("FontName", "Verdana",     "Header")
1490:                 .SetAll("FontSize", 8,             "Header")
1491:                 .GridLineColor      = RGB(238,238,238)
1492:                 .HighlightBackColor = RGB(15,41,104)
1493:                 .HighlightForeColor = RGB(255,255,255)
1494:                 .HighlightStyle     = 2
1495:                 .ScrollBars         = 2
1496:                 .DeleteMark         = .F.
1497:                 .RecordMark         = .F.
1498:                 .RowHeight          = 16
1499:                 .Enabled            = loc_lTemRegistros

*-- Linhas 1520 a 1646:
1520:         CATCH TO loc_oErro
1521:             MsgErro(loc_oErro.Message + CHR(13) + ;
1522:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1523:                 "Procedure: " + loc_oErro.Procedure, ;
1524:                 "Erro em FormHOR.ConfigurarPaginaLista")
1525:         ENDTRY
1526: 
1527:         RETURN loc_lSucesso
1528:     ENDFUNC
1529: 
1530:     *==========================================================================
1531:     * AlternarPagina - Retorna ao estado de consulta (equivale a IrParaLista
1532:     * em forms CRUD). Em forms OPERACIONAIS sem PageFrame, redefine controles
1533:     * para o modo CONSULTAR e recarrega o calend?rio do m?s corrente.
1534:     * par_nPagina : reservado (1=lista / 2=dados - n?o usado neste form)
1535:     *==========================================================================
1536:     FUNCTION AlternarPagina(par_nPagina)
1537:         LOCAL loc_oErro
1538:         TRY
1539:             THIS.AjustarTela()
1540:             IF USED("crMesAno") AND !EOF("crMesAno")
1541:                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1542:             ENDIF
1543:         CATCH TO loc_oErro
1544:             MsgErro(loc_oErro.Message + CHR(13) + ;
1545:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1546:                 "Procedure: " + loc_oErro.Procedure, ;
1547:                 "Erro em FormHOR.AlternarPagina")
1548:         ENDTRY
1549:     ENDFUNC
1550: 
1551:     *==========================================================================
1552:     * BtnIncluirClick - Compatibilidade FormBase: delega para CmdInserirClick
1553:     *==========================================================================
1554:     FUNCTION BtnIncluirClick()
1555:         THIS.CmdInserirClick()
1556:     ENDFUNC
1557: 
1558:     *==========================================================================
1559:     * BtnAlterarClick - Compatibilidade FormBase: delega para CmdAlterarClick
1560:     *==========================================================================
1561:     FUNCTION BtnAlterarClick()
1562:         THIS.CmdAlterarClick()
1563:     ENDFUNC
1564: 
1565:     *==========================================================================
1566:     * BtnVisualizarClick - Consultar: retorna ao modo CONSULTAR (AjustarTela)
1567:     * O form SIGCDHOR n?o tem bot?o Visualizar dedicado; o modo de consulta
1568:     * ? o estado padr?o obtido por AjustarTela + reload do calend?rio.
1569:     *==========================================================================
1570:     FUNCTION BtnVisualizarClick()
1571:         LOCAL loc_oErro
1572:         TRY
1573:             THIS.AjustarTela()
1574:             IF USED("crMesAno") AND !EOF("crMesAno")
1575:                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1576:             ENDIF
1577:         CATCH TO loc_oErro
1578:             MsgErro(loc_oErro.Message + CHR(13) + ;
1579:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1580:                 "Procedure: " + loc_oErro.Procedure, ;
1581:                 "Erro em FormHOR.BtnVisualizarClick")
1582:         ENDTRY
1583:     ENDFUNC
1584: 
1585:     *==========================================================================
1586:     * BtnExcluirClick - Compatibilidade FormBase: delega para CmdExcluirClick
1587:     *==========================================================================
1588:     FUNCTION BtnExcluirClick()
1589:         THIS.CmdExcluirClick()
1590:     ENDFUNC
1591: 
1592:     *==========================================================================
1593:     * BtnBuscarClick - Compatibilidade FormBase: sem bot?o Buscar neste form
1594:     * Retorna ao modo CONSULTAR (equivalente a clicar em Cancelar)
1595:     *==========================================================================
1596:     FUNCTION BtnBuscarClick()
1597:         LOCAL loc_oErro
1598:         TRY
1599:             THIS.AjustarTela()
1600:             IF USED("crMesAno") AND !EOF("crMesAno")
1601:                 THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1602:             ENDIF
1603:         CATCH TO loc_oErro
1604:             MsgErro(loc_oErro.Message + CHR(13) + ;
1605:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1606:                 "Procedure: " + loc_oErro.Procedure, ;
1607:                 "Erro em FormHOR.BtnBuscarClick")
1608:         ENDTRY
1609:     ENDFUNC
1610: 
1611:     *==========================================================================
1612:     * BtnEncerrarClick - Compatibilidade FormBase: fecha o form
1613:     *==========================================================================
1614:     FUNCTION BtnEncerrarClick()
1615:         THIS.Release()
1616:     ENDFUNC
1617: 
1618:     *==========================================================================
1619:     * BtnSalvarClick - Compatibilidade FormBase: delega para CmdSalvarClick
1620:     *==========================================================================
1621:     FUNCTION BtnSalvarClick()
1622:         THIS.CmdSalvarClick()
1623:     ENDFUNC
1624: 
1625:     *==========================================================================
1626:     * BtnCancelarClick - Compatibilidade FormBase: delega para CmdCancelarClick
1627:     *==========================================================================
1628:     FUNCTION BtnCancelarClick()
1629:         THIS.CmdCancelarClick()
1630:     ENDFUNC
1631: 
1632:     *==========================================================================
1633:     * FormParaBO - Transfere dados do form para as propriedades do BO
1634:     * Chamado antes de Inserir/Alterar/Excluir/CopiarPeriodo
1635:     *==========================================================================
1636:     FUNCTION FormParaBO()
1637:         LOCAL loc_oErro, loc_lSucesso
1638:         loc_lSucesso = .F.
1639: 
1640:         TRY
1641:             WITH THIS.this_oBusinessObject
1642:                 .this_cSetors   = THIS.this_cParCod
1643:                 .this_cUniPrdts = THIS.this_cParUni
1644: 
1645:                 .this_cMes = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value),    2, "0")
1646:                 .this_cAno = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value),    4, "0")

*-- Linhas 1653 a 1839:
1653:         CATCH TO loc_oErro
1654:             MsgErro(loc_oErro.Message + CHR(13) + ;
1655:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1656:                 "Procedure: " + loc_oErro.Procedure, ;
1657:                 "Erro em FormHOR.FormParaBO")
1658:         ENDTRY
1659: 
1660:         RETURN loc_lSucesso
1661:     ENDFUNC
1662: 
1663:     *==========================================================================
1664:     * BOParaForm - Transfere propriedades do BO de volta para os controles
1665:     * Chamado ap?s CarregarDoCursor ou para sincronizar painel lateral
1666:     *==========================================================================
1667:     FUNCTION BOParaForm()
1668:         LOCAL loc_oErro, loc_lSucesso
1669:         loc_lSucesso = .F.
1670: 
1671:         TRY
1672:             WITH THIS.cnt_4c_Dados
1673:                 .txt_4c_Mes.Value     = THIS.this_oBusinessObject.this_cMes
1674:                 .txt_4c_Ano.Value     = THIS.this_oBusinessObject.this_cAno
1675:                 .txt_4c_Qtds.Value    = THIS.this_oBusinessObject.this_nQtds
1676:                 .txt_4c_QtHoras.Value = THIS.this_oBusinessObject.this_nQtHoras
1677: 
1678:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMes) AND ;
1679:                    !EMPTY(THIS.this_oBusinessObject.this_cAno)
1680:                     .cmd_4c_BtnData.Caption = THIS.this_oBusinessObject.this_cMes + ;
1681:                                              "/" + THIS.this_oBusinessObject.this_cAno
1682:                 ELSE
1683:                     .cmd_4c_BtnData.Caption = "00/00/0000"
1684:                 ENDIF
1685: 
1686:                 .txt_4c_TotHoras.Value = THIS.this_oBusinessObject.ConverterHorasParaDecimal( ;
1687:                     THIS.this_oBusinessObject.this_nQtHoras, ;
1688:                     THIS.this_oBusinessObject.this_nQtds)
1689:                 .Visible     = .T.
1690:             ENDWITH
1691: 
1692:             loc_lSucesso = .T.
1693:         CATCH TO loc_oErro
1694:             MsgErro(loc_oErro.Message + CHR(13) + ;
1695:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1696:                 "Procedure: " + loc_oErro.Procedure, ;
1697:                 "Erro em FormHOR.BOParaForm")
1698:         ENDTRY
1699: 
1700:         RETURN loc_lSucesso
1701:     ENDFUNC
1702: 
1703:     *==========================================================================
1704:     * HabilitarCampos - Habilita / desabilita campos do painel lateral
1705:     * conforme o modo de opera??o atual (this_cPcEscolha)
1706:     *==========================================================================
1707:     FUNCTION HabilitarCampos()
1708:         LOCAL loc_oErro, loc_cEscolha
1709:         loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha
1710: 
1711:         TRY
1712:             WITH THIS.cnt_4c_Dados
1713:                 DO CASE
1714:                     CASE loc_cEscolha = "INSERIR"
1715:                         .txt_4c_Mes.Enabled     = .T.
1716:                         .txt_4c_Ano.Enabled     = .T.
1717:                         .txt_4c_Qtds.Enabled    = .F.
1718:                         .txt_4c_QtHoras.Enabled = .F.
1719: 
1720:                     CASE loc_cEscolha = "ALTERAR"
1721:                         .txt_4c_Mes.Enabled     = .F.
1722:                         .txt_4c_Ano.Enabled     = .F.
1723:                         .txt_4c_Qtds.Enabled    = .T.
1724:                         .txt_4c_QtHoras.Enabled = .T.
1725: 
1726:                     CASE loc_cEscolha = "COPIARP"
1727:                         .txt_4c_Mes.Enabled     = .T.
1728:                         .txt_4c_Ano.Enabled     = .T.
1729:                         .txt_4c_Qtds.Enabled    = .F.
1730:                         .txt_4c_QtHoras.Enabled = .F.
1731: 
1732:                     OTHERWISE  && CONSULTAR / EXCLUIR
1733:                         .txt_4c_Mes.Enabled     = .F.
1734:                         .txt_4c_Ano.Enabled     = .F.
1735:                         .txt_4c_Qtds.Enabled    = .F.
1736:                         .txt_4c_QtHoras.Enabled = .F.
1737:                 ENDCASE
1738:                 .Visible     = .T.
1739:             ENDWITH
1740:         CATCH TO loc_oErro
1741:             MsgErro(loc_oErro.Message + CHR(13) + ;
1742:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1743:                 "Procedure: " + loc_oErro.Procedure, ;
1744:                 "Erro em FormHOR.HabilitarCampos")
1745:         ENDTRY
1746:     ENDFUNC
1747: 
1748:     *==========================================================================
1749:     * LimparCampos - Zera todos os campos edit?veis do painel lateral
1750:     * Chamado em CmdInserirClick e CmdCopiarPClick (novo per?odo vazio)
1751:     *==========================================================================
1752:     FUNCTION LimparCampos()
1753:         LOCAL loc_oErro
1754:         TRY
1755:             WITH THIS.cnt_4c_Dados
1756:                 .cmd_4c_BtnData.Caption = "00/00/0000"
1757:                 .txt_4c_Mes.Value       = ""
1758:                 .txt_4c_Ano.Value       = ""
1759:                 .txt_4c_Qtds.Value      = 0
1760:                 .txt_4c_QtHoras.Value   = 0
1761:                 .txt_4c_TotHoras.Value  = 0
1762:                 .Visible     = .T.
1763:             ENDWITH
1764: 
1765:             THIS.this_oBusinessObject.this_cMes     = ""
1766:             THIS.this_oBusinessObject.this_cAno     = ""
1767:             THIS.this_oBusinessObject.this_nQtds    = 0
1768:             THIS.this_oBusinessObject.this_nQtHoras = 0
1769:             THIS.this_nSlotAtual = 0
1770:         CATCH TO loc_oErro
1771:             MsgErro(loc_oErro.Message + CHR(13) + ;
1772:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1773:                 "Procedure: " + loc_oErro.Procedure, ;
1774:                 "Erro em FormHOR.LimparCampos")
1775:         ENDTRY
1776:     ENDFUNC
1777: 
1778:     *==========================================================================
1779:     * CarregarLista - Recarrega a grade Mes/Ano e o calend?rio do m?s corrente
1780:     * Equivalente ao CarregarLista() de forms CRUD; chamado ap?s salvar/excluir
1781:     *==========================================================================
1782:     FUNCTION CarregarLista()
1783:         LOCAL loc_oErro, loc_lSucesso
1784:         loc_lSucesso = .F.
1785: 
1786:         TRY
1787:             loc_lSucesso = THIS.MontarGradeMesAno()
1788: 
1789:             IF loc_lSucesso
1790:                 IF USED("crMesAno") AND !EOF("crMesAno")
1791:                     THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
1792:                 ELSE
1793:                     THIS.AjustarTela()
1794:                 ENDIF
1795:             ENDIF
1796:         CATCH TO loc_oErro
1797:             MsgErro(loc_oErro.Message + CHR(13) + ;
1798:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1799:                 "Procedure: " + loc_oErro.Procedure, ;
1800:                 "Erro em FormHOR.CarregarLista")
1801:             loc_lSucesso = .F.
1802:         ENDTRY
1803: 
1804:         RETURN loc_lSucesso
1805:     ENDFUNC
1806: 
1807:     *==========================================================================
1808:     * AjustarBotoesPorModo - Ajusta estado dos bot?es conforme o modo atual
1809:     * Unifica o comportamento de AjustarTela + ConfigurarPaginaLista
1810:     * Chamado ap?s mudar this_cPcEscolha
1811:     *==========================================================================
1812:     FUNCTION AjustarBotoesPorModo()
1813:         LOCAL loc_oErro, loc_cEscolha, loc_lTemRegistros
1814:         loc_cEscolha      = THIS.this_oBusinessObject.this_cPcEscolha
1815:         loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0
1816: 
1817:         TRY
1818:             DO CASE
1819:                 CASE loc_cEscolha = "INSERIR" OR loc_cEscolha = "EXCLUIR" OR ;
1820:                      loc_cEscolha = "COPIARP"
1821:                     WITH THIS.obj_4c_CmdEscolha
1822:                         .Buttons(1).Enabled = .F.
1823:                         .Buttons(2).Enabled = .F.
1824:                         .Buttons(3).Enabled = .F.
1825:                         .Buttons(4).Enabled = .F.
1826:                     ENDWITH
1827:                     WITH THIS.obj_4c_CmdSalva
1828:                         .Buttons(1).Enabled = .T.
1829:                         .Buttons(2).Enabled = .F.
1830:                         .Buttons(3).Enabled = .T.
1831:                     ENDWITH
1832: 
1833:                 CASE loc_cEscolha = "ALTERAR"
1834:                     WITH THIS.obj_4c_CmdEscolha
1835:                         .Buttons(1).Enabled = .F.
1836:                         .Buttons(2).Enabled = .F.
1837:                         .Buttons(3).Enabled = .F.
1838:                         .Buttons(4).Enabled = .F.
1839:                     ENDWITH

*-- Linhas 1865 a 1873:
1865:         CATCH TO loc_oErro
1866:             MsgErro(loc_oErro.Message + CHR(13) + ;
1867:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1868:                 "Procedure: " + loc_oErro.Procedure, ;
1869:                 "Erro em FormHOR.AjustarBotoesPorModo")
1870:         ENDTRY
1871:     ENDFUNC
1872: 
1873: ENDDEFINE


### BO (C:\4c\projeto\app\classes\HORBO.prg):
*==============================================================================
* HORBO.prg - Business Object: Cadastro de Carga Hor?ria
* Tabela principal : SigCdThs
* Chave prim?ria  : cidchaves
* Form OPERACIONAL: recebe pCod (Fase/Setor) e pUni (Unidade Produtiva)
*==============================================================================
* Colunas SigCdThs : cidchaves c(20) PK, codigos n(6,0), datas datetime,
*                    qtds n(4,1), qthoras n(4,2), setors c(10), uniprdts c(10)
* Colunas SigCdUpd : cidchaves c(20) PK, codigos c(10), ddsems n(1,0),
*                    hordds n(4,2), uniprdts c(10), ordems n(2,0), qtdes n(2,0)
* Colunas SigCdGcr : codigos c(10) PK, descrs c(40)
*==============================================================================

DEFINE CLASS HORBO AS BusinessBase

    *-- Identifica??o da tabela
    this_cTabela      = "SigCdThs"
    this_cCampoChave  = "cidchaves"

    *-- Par?metros do form (recebidos do caller)
    this_cSetors      = ""      && Fase/Setor - char(10) - coluna setors
    this_cUniPrdts    = ""      && Unidade Produtiva - char(10) - coluna uniprdts
    this_cDFases      = ""      && Descri??o da Fase (SigCdGcr.descrs)

    *-- Modo de opera??o (equivalente a pcEscolha do legado)
    this_cPcEscolha   = ""      && CONSULTAR / INSERIR / ALTERAR / EXCLUIR / COPIARP

    *-- Dados do registro corrente (SigCdThs)
    this_cCidChaves   = ""      && PK - char(20) - coluna cidchaves
    this_dDatas       = {}      && Data do registro - coluna datas (datetime)
    this_nQtds        = 0       && Quantidade - numeric(4,1) - coluna qtds
    this_nQtHoras     = 0       && Horas por dia - numeric(4,2) - coluna qthoras

    *-- Sele??o de per?odo (para modos INSERIR / COPIARP)
    this_cMes         = ""      && M?s selecionado - char(2)
    this_cAno         = ""      && Ano selecionado - char(4)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim?ria do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDescricaoFase - Busca descri??o da Fase/Setor em SigCdGcr
    * Retorna: .T. se encontrado, .F. se n?o encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarDescricaoFase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_cDFases = ""

            IF !EMPTY(THIS.this_cSetors)
                loc_cSQL = "SELECT descrs FROM SigCdGcr " + ;
                           "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10))

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFase")
                IF loc_nRet > 0 AND USED("cursor_4c_DescFase") AND !EOF("cursor_4c_DescFase")
                    THIS.this_cDFases = ALLTRIM(cursor_4c_DescFase.descrs)
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDescricaoFase")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeMesAno - Carrega cursor crMesAno com meses/anos existentes
    * em SigCdThs para o Setor e Unidade Produtiva atuais
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeMesAno()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("crMesAno")
                ZAP IN crMesAno

                loc_cSQL = "SELECT DISTINCT datas " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " ORDER BY datas"

                IF USED("cursor_4c_DatasTemp")
                    USE IN cursor_4c_DatasTemp
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DatasTemp")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarGradeMesAno).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    *-- Extrai mes/ano distintos do cursor de datas
                    SELECT DISTINCT ;
                        SUBSTR(DTOS(NVL(datas, CTOD(""))), 5, 2) AS Mes, ;
                        SUBSTR(DTOS(NVL(datas, CTOD(""))), 1, 4) AS Ano ;
                    FROM cursor_4c_DatasTemp ;
                    INTO CURSOR cursor_4c_MesAnoTemp READWRITE

                    SELECT cursor_4c_MesAnoTemp
                    SCAN
                        INSERT INTO crMesAno (Mes, Ano) ;
                            VALUES (m.cursor_4c_MesAnoTemp.Mes, m.cursor_4c_MesAnoTemp.Ano)
                    ENDSCAN

                    IF USED("cursor_4c_DatasTemp")
                        USE IN cursor_4c_DatasTemp
                    ENDIF
                    IF USED("cursor_4c_MesAnoTemp")
                        USE IN cursor_4c_MesAnoTemp
                    ENDIF

                    *-- Posiciona no m?s corrente se existir
                    SET NEAR ON
                    =SEEK(SUBSTR(DTOS(DATE()), 1, 6), "crMesAno", "Ordem")
                    SET NEAR OFF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarGradeMesAno")

            IF USED("cursor_4c_DatasTemp")
                USE IN cursor_4c_DatasTemp
            ENDIF
            IF USED("cursor_4c_MesAnoTemp")
                USE IN cursor_4c_MesAnoTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCalendario - Carrega crCalendario para o mes/ano informado
    * par_cMes   : Mes desejado (char 2, ex: "08")
    * par_cAno   : Ano desejado (char 4, ex: "2026")
    * par_lTrunc  : .T. = truncar e recalcular dias; .F. = apenas carregar
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarCalendario(par_cMes, par_cAno, par_lTrunc)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDia, loc_ldDtF, loc_ldDtI
        LOCAL loc_nDow, loc_ldDay
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_nHor, loc_nQts
        LOCAL loc_llZer
        LOCAL loc_nDia, loc_nObj, loc_cObj
        LOCAL loc_nHorTotal, loc_nQth, loc_nQtd
        LOCAL loc_cHrr
        loc_lSucesso = .F.

        TRY
            IF USED("crCalendario")
                loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                *-- Busca dados de SigCdThs para o per?odo
                loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDia, 1) - 1, .T.)

                loc_cSQL = "SELECT * " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                IF USED("cursor_4c_TmpCtHr")
                    USE IN cursor_4c_TmpCtHr
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCtHr")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    SELECT cursor_4c_TmpCtHr
                    INDEX ON DTOS(NVL(datas, CTOD(""))) TAG Datas

                    *-- Modo truncar: recalcula horas conforme SigCdUpd
                    LOCAL loc_lTruncOk
                    loc_lTruncOk = .T.
                    IF par_lTrunc
                        loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                                   "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                   " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                        IF loc_nRet < 1
                            MsgErro("Falha ao consultar SigCdUpd (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                            IF USED("cursor_4c_TmpCtHr")
                                USE IN cursor_4c_TmpCtHr
                            ENDIF
                            loc_lTruncOk = .F.
                        ELSE
                            GO TOP IN cursor_4c_LocalUPrdt

                            loc_nHds = cursor_4c_LocalUPrdt.hordds
                            loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                            loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                            FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDia, 1) - 1)
                                loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + par_cMes + "/" + par_cAno)

                                loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                                loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                                loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                                IF SEEK(DTOS(loc_ldDay), "cursor_4c_TmpCtHr", "Datas")
                                    SELECT cursor_4c_TmpCtHr
                                    REPLACE qtds    WITH loc_nQts, ;
                                            qthoras WITH loc_nHor
                                ELSE
                                    INSERT INTO cursor_4c_TmpCtHr ;
                                        (setors, uniprdts, datas, qtds, qthoras) ;
                                    VALUES ;
                                        (THIS.this_cSetors, THIS.this_cUniPrdts, ;
                                         loc_ldDay, loc_nQts, loc_nHor)
                                ENDIF
                            NEXT

                            IF USED("cursor_4c_LocalUPrdt")
                                USE IN cursor_4c_LocalUPrdt
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lTruncOk
                        *-- Alimenta crCalendario com dados do m?s
                        ZAP IN crCalendario

                        IF RECCOUNT("cursor_4c_TmpCtHr") > 0
                            APPEND BLANK IN crCalendario
                            GO TOP IN crCalendario

                            loc_nDow = 1
                            loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                            FOR loc_nObj = 1 TO 42
                                loc_cObj = PADL(loc_nObj, 2, "0")

                                *-- Limpa slot do calend?rio
                                SELECT crCalendario
                                REPLACE ("Data"    + loc_cObj) WITH CTOD(""), ;
                                        ("QtHoras" + loc_cObj) WITH 0, ;
                                        ("Qtds"    + loc_cObj) WITH 0

                                IF loc_nDow = DOW(loc_ldDia) AND MONTH(loc_ldDia) = INT(VAL(par_cMes))
                                    loc_nHorTotal = 0
                                    loc_nQth = 0
                                    loc_nQtd = 0

                                    IF SEEK(DTOS(loc_ldDia), "cursor_4c_TmpCtHr", "Datas")
                                        loc_nQth      = cursor_4c_TmpCtHr.qthoras
                                        loc_nQtd      = cursor_4c_TmpCtHr.qtds
                                        loc_nHorTotal = THIS.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                                    ENDIF

                                    SELECT crCalendario
                                    REPLACE ("Data"    + loc_cObj) WITH loc_ldDia, ;
                                            ("QtHoras" + loc_cObj) WITH loc_nQth, ;
                                            ("Qtds"    + loc_cObj) WITH loc_nQtd

                                    loc_ldDia = loc_ldDia + 1
                                ENDIF

                                loc_nDow = loc_nDow + 1
                                IF loc_nDow > 7
                                    loc_nDow = 1
                                ENDIF
                            NEXT
                        ENDIF

                        IF USED("cursor_4c_TmpCtHr")
                            USE IN cursor_4c_TmpCtHr
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarCalendario")

            IF USED("cursor_4c_TmpCtHr")
                USE IN cursor_4c_TmpCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPeriodo - Insere novo per?odo de carga hor?ria
    * par_cMes : M?s do per?odo (char 2)
    * par_cAno : Ano do per?odo (char 4)
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION InserirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_ldDay, loc_llZer, loc_nHor, loc_nQts
        LOCAL loc_nDia
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            *-- Verifica se j? existem lan?amentos no per?odo
            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtHr")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkCtHr") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF

                    *-- Busca configura??o da unidade produtiva em SigCdUpd
                    loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                               "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                    IF USED("cursor_4c_LocalUPrdt")
                        USE IN cursor_4c_LocalUPrdt
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar SigCdUpd (InserirPeriodo).", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        GO TOP IN cursor_4c_LocalUPrdt

                        loc_nHds = cursor_4c_LocalUPrdt.hordds
                        loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                        loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        *-- Cria cursor de work para inser??o em lote
                        IF USED("crSigCdThs")
                            TABLEREVERT(.T., "crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        SET NULL ON
                        CREATE CURSOR crSigCdThs ;
                            (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                             qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                             setors C(10) NULL, uniprdts C(10) NULL)
                        SET NULL OFF

                        *-- Insere um registro por dia do m?s
                        FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDat, 1) - 1)
                            loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))

                            loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                            loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                            loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                            SELECT crSigCdThs
                            APPEND BLANK
                            REPLACE setors    WITH THIS.this_cSetors, ;
                                    uniprdts  WITH THIS.this_cUniPrdts, ;
                                    qtds      WITH loc_nQts, ;
                                    qthoras   WITH loc_nHor, ;
                                    datas     WITH loc_ldDay, ;
                                    cidchaves WITH THIS.GerarChaveUnica()
                        NEXT

                        *-- Envia para SQL Server via SQLEXEC INSERT em lote
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                        IF USED("crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        *-- Atualiza crMesAno se o m?s n?o existia
                        IF loc_lSucesso AND USED("crMesAno")
                            IF !SEEK(SUBSTR(DTOS(loc_ldDat), 1, 6), "crMesAno", "Ordem")
                                INSERT INTO crMesAno (Mes, Ano) ;
                                    VALUES (SUBSTR(DTOS(loc_ldDat), 5, 2), SUBSTR(DTOS(loc_ldDat), 1, 4))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.InserirPeriodo")

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlterarPeriodo - Altera dados do per?odo atual a partir de crCalendario
    * Retorna: .T. se alterado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION AlterarPeriodo()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_nObj, loc_cObj, loc_ldDia
        LOCAL loc_ldDtI, loc_ldDtF
        LOCAL loc_nQth, loc_nQtd
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            IF USED("crCalendario")
                IF USED("crSigCdThs")
                    TABLEREVERT(.T., "crSigCdThs")
                    USE IN crSigCdThs
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigCdThs ;
                    (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                     qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                     setors C(10) NULL, uniprdts C(10) NULL)
                SET NULL OFF

                LOCAL loc_lLoopOk
                loc_lLoopOk = .T.

                FOR loc_nObj = 1 TO 42
                    IF loc_lLoopOk
                        loc_cObj = PADL(loc_nObj, 2, "0")
                        SELECT crCalendario
                        loc_ldDia = EVALUATE("Data" + loc_cObj)

                        IF !EMPTY(loc_ldDia)
                            loc_nQth = EVALUATE("QtHoras" + loc_cObj)
                            loc_nQtd = EVALUATE("Qtds"    + loc_cObj)

                            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                            loc_ldDtF = THIS.FormatarDataSQL(loc_ldDia, .T.)

                            *-- Busca registro existente para o dia
                            loc_cSQL = "SELECT * FROM SigCdThs " + ;
                                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                            IF loc_nRet < 1
                                MsgErro("Falha ao consultar SigCdThs (AlterarPeriodo).", "Erro de Conex" + CHR(227) + "o")
                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF
                                loc_lLoopOk = .F.
                            ELSE
                                SELECT crSigCdThs
                                IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                                    *-- Existe: copia e atualiza horas/qtd
                                    GO TOP IN cursor_4c_LocalCtHr
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE cidchaves WITH cursor_4c_LocalCtHr.cidchaves, ;
                                            codigos   WITH cursor_4c_LocalCtHr.codigos, ;
                                            datas     WITH cursor_4c_LocalCtHr.datas, ;
                                            setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth
                                ELSE
                                    *-- N?o existe: insere novo registro
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE setors    WITH THIS.this_cSetors, ;
                                            uniprdts  WITH THIS.this_cUniPrdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth, ;
                                            datas     WITH loc_ldDia, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                ENDIF

                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF

                                loc_lUpd = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                NEXT

                IF loc_lLoopOk
                    IF loc_lUpd
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                IF USED("crSigCdThs")
                    USE IN crSigCdThs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.AlterarPeriodo")

            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirPeriodo - Exclui todos os registros do per?odo (mes/ano)
    * par_cMes : M?s a excluir (char 2)
    * par_cAno : Ano a excluir (char 4)
    * Retorna: .T. se exclu?do com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION ExcluirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            loc_cSQL = "DELETE FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult")
            IF loc_nRet < 1
                MsgErro("Falha ao excluir per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_DelResult")
                    USE IN cursor_4c_DelResult
                ENDIF

                *-- Remove da crMesAno
                IF USED("crMesAno")
                    DELETE FROM crMesAno ;
                    WHERE Mes = SUBSTR(DTOS(loc_ldDat), 5, 2) AND ;
                          Ano = SUBSTR(DTOS(loc_ldDat), 1, 4)
                    PACK IN crMesAno
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.ExcluirPeriodo")

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CopiarPeriodo - Copia per?odo do mes/ano selecionado para outro mes/ano
    * par_cMesOrig : M?s de origem (mes do crMesAno selecionado no grid)
    * par_cAnoOrig : Ano de origem
    * par_cMesDest : M?s de destino (digitado pelo usu?rio)
    * par_cAnoDest : Ano de destino (digitado pelo usu?rio)
    * Retorna: .T. se copiado com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION CopiarPeriodo(par_cMesOrig, par_cAnoOrig, par_cMesDest, par_cAnoDest)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_ldDatDest, loc_ldDtI, loc_ldDtF
        LOCAL loc_ldDatOrig, loc_ldDtIOrig, loc_ldDtFOrig
        LOCAL loc_ldDtn
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            *-- Verifica se destino j? tem lan?amentos
            loc_ldDatDest = CTOD("01/" + PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDatDest)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDatDest, 1) - 1, .T.)

            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDest")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar destino em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkDest") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF

                    *-- Busca registros de origem
                    loc_ldDatOrig = CTOD("01/" + PADL(par_cMesOrig, 2, "0") + "/" + PADL(par_cAnoOrig, 4, "0"))
                    loc_ldDtIOrig = THIS.FormatarDataSQL(loc_ldDatOrig)
                    loc_ldDtFOrig = THIS.FormatarDataSQL(GOMONTH(loc_ldDatOrig, 1) - 1, .T.)

                    loc_cSQL = "SELECT * FROM SigCdThs " + ;
                               "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + loc_ldDtIOrig + " AND " + loc_ldDtFOrig

                    IF USED("cursor_4c_LocalCtHr")
                        USE IN cursor_4c_LocalCtHr
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar origem em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                            IF USED("crSigCdThs")
                                TABLEREVERT(.T., "crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF

                            SET NULL ON
                            CREATE CURSOR crSigCdThs ;
                                (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                                 qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                                 setors C(10) NULL, uniprdts C(10) NULL)
                            SET NULL OFF

                            SELECT cursor_4c_LocalCtHr
                            SCAN
                                *-- Ajusta dia para o m?s destino
                                loc_ldDtn = CTOD(SUBSTR(DTOC(cursor_4c_LocalCtHr.datas), 1, 3) + ;
                                                 PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))

                                IF !EMPTY(loc_ldDtn)
                                    SELECT crSigCdThs
                                    APPEND BLANK
                                    REPLACE setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH cursor_4c_LocalCtHr.qtds, ;
                                            qthoras   WITH cursor_4c_LocalCtHr.qthoras, ;
                                            datas     WITH loc_ldDtn, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                    loc_lUpd = .T.
                                ENDIF
                            ENDSCAN

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            IF loc_lUpd
                                loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                                *-- Atualiza crMesAno com o novo per?odo
                                IF loc_lSucesso AND USED("crMesAno") AND !EMPTY(loc_ldDtn)
                                    INSERT INTO crMesAno (Mes, Ano) ;
                                        VALUES (SUBSTR(DTOS(loc_ldDtn), 5, 2), SUBSTR(DTOS(loc_ldDtn), 1, 4))
                                ENDIF
                            ELSE
                                loc_lSucesso = .T.
                            ENDIF

                            IF USED("crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF
                        ELSE
                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CopiarPeriodo")

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF
            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnviarCursorParaServidor - Insere/atualiza registros de crSigCdThs
    * no SQL Server usando SQLEXEC por registro
    * Retorna: .T. se todos enviados com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EnviarCursorParaServidor(par_cCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_nCodigos, loc_ldDatas
        LOCAL loc_nQtds, loc_nQtHoras, loc_cSetors, loc_cUniPrdts
        loc_lSucesso = .T.

        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                SELECT (par_cCursor)
                GO TOP

                SCAN
                    loc_cCidChaves = ALLTRIM(EVALUATE(par_cCursor + ".cidchaves"))
                    loc_nCodigos   = EVALUATE(par_cCursor + ".codigos")
                    loc_ldDatas    = EVALUATE(par_cCursor + ".datas")
                    loc_nQtds      = EVALUATE(par_cCursor + ".qtds")
                    loc_nQtHoras   = EVALUATE(par_cCursor + ".qthoras")
                    loc_cSetors    = ALLTRIM(EVALUATE(par_cCursor + ".setors"))
                    loc_cUniPrdts  = ALLTRIM(EVALUATE(par_cCursor + ".uniprdts"))

                    *-- Tenta UPDATE primeiro
                    loc_cSQL = "UPDATE SigCdThs " + ;
                               "SET qtds = " + FormatarNumeroSQL(loc_nQtds, 1) + ;
                               ", qthoras = " + FormatarNumeroSQL(loc_nQtHoras, 2) + ;
                               " WHERE setors = " + EscaparSQL(PADR(loc_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + THIS.FormatarDataSQL(loc_ldDatas) + ;
                               " AND " + THIS.FormatarDataSQL(loc_ldDatas, .T.)

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdResult")

                    IF USED("cursor_4c_UpdResult")
                        USE IN cursor_4c_UpdResult
                    ENDIF

                    *-- Verifica linhas afetadas: 0 = novo registro, faz INSERT
                    LOCAL loc_nAffected
                    loc_nAffected = 0
                    IF loc_nRet >= 1
                        IF SQLEXEC(gnConnHandle, "SELECT @@ROWCOUNT AS rn", "cursor_4c_RowCnt") >= 1
                            loc_nAffected = cursor_4c_RowCnt.rn
                        ENDIF
                        IF USED("cursor_4c_RowCnt")
                            USE IN cursor_4c_RowCnt
                        ENDIF
                    ENDIF

                    *-- Se UPDATE nao afetou nenhuma linha, faz INSERT
                    IF loc_nRet < 1 OR loc_nAffected = 0
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF
                        loc_cSQL = "INSERT INTO SigCdThs " + ;
                                   "(cidchaves, codigos, setors, uniprdts, datas, qtds, qthoras) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", 0, " + ;
                                   EscaparSQL(PADR(loc_cSetors, 10)) + ", " + ;
                                   EscaparSQL(PADR(loc_cUniPrdts, 10)) + ", " + ;
                                   THIS.FormatarDataSQL(loc_ldDatas) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtds, 1) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtHoras, 2) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult")
                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF

                        IF loc_nRet < 1
                            MsgErro("Falha ao inserir registro em SigCdThs.", "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.EnviarCursorParaServidor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave prim?ria ?nica (char 20)
    * Usa NEWID() do SQL Server para gerar GUID truncado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRet
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, "SELECT LEFT(REPLACE(NEWID(),'-',''),20) AS nova_chave", "cursor_4c_NewId")
            IF loc_nRet > 0 AND USED("cursor_4c_NewId") AND !EOF("cursor_4c_NewId")
                loc_cChave = ALLTRIM(cursor_4c_NewId.nova_chave)
            ENDIF

            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            *-- Fallback com SYS(2015) se SQL falhar
            loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)
        ENDTRY

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarFeriado - Verifica se uma data ? feriado em SigCdThs (stub)
    * Substitui fChkFeriado() do legado
    * par_ldData : Data a verificar
    * Retorna: .T. se for feriado, .F. caso contr?rio
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarFeriado(par_ldData)
        LOCAL loc_lFeriado, loc_cSQL, loc_nRet
        loc_lFeriado = .F.

        TRY
            *-- Verifica em SigCdThs se o dia tem qthoras=0 explicitamente (feriado configurado)
            *-- Na aus?ncia de tabela de feriados dedicada no sistema, retorna .F. por padr?o
            *-- O legado usava fChkFeriado() do framework que consultava tabela de feriados
            loc_lFeriado = .F.
        CATCH TO loc_oErro
            loc_lFeriado = .F.
        ENDTRY

        RETURN loc_lFeriado
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarDataSQL - Formata data para SQL Server incluindo hora opcional
    * par_ldData   : Data a formatar
    * par_lComHora : .T. = adiciona "23:59:59" (fim do dia)
    * Retorna: string no formato 'YYYY-MM-DD HH:MM:SS' entre aspas simples
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDataSQL(par_ldData, par_lComHora)
        LOCAL loc_cData
        loc_cData = "NULL"

        TRY
            IF !EMPTY(par_ldData) AND par_ldData <> {}
                IF VARTYPE(par_lComHora) = "L" AND par_lComHora
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 23:59:59'"
                ELSE
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 00:00:00'"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cData = "NULL"
        ENDTRY

        RETURN loc_cData
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConverterHorasParaDecimal - Converte horas*qtd para valor decimal total
    * Substitui: Val(Strtran(fMtoH(fHtoM(Str(qtHoras,5,2)) * qtds), ':', '.'))
    * par_nQtHoras : Horas por dia (numeric)
    * par_nQtds    : Quantidade (numeric)
    * Retorna: valor decimal total de horas
    *--------------------------------------------------------------------------
    FUNCTION ConverterHorasParaDecimal(par_nQtHoras, par_nQtds)
        LOCAL loc_nTotalMinutos, loc_nHoras, loc_nMinutos, loc_nDecimal
        loc_nDecimal = 0

        TRY
            *-- fHtoM: horas decimais -> minutos (ex: 8.30 -> 510 min)
            *-- QtHoras est? no formato decimal (8.5 = 8h30)
            loc_nTotalMinutos = INT(par_nQtHoras) * 60 + ;
                                (par_nQtHoras - INT(par_nQtHoras)) * 100
            loc_nTotalMinutos = loc_nTotalMinutos * par_nQtds

            *-- fMtoH: minutos -> horas decimal
            loc_nHoras   = INT(loc_nTotalMinutos / 60)
            loc_nMinutos = MOD(loc_nTotalMinutos, 60)
            loc_nDecimal = VAL(TRANSFORM(loc_nHoras, "@L 9999") + "." + PADL(TRANSFORM(loc_nMinutos, "@L 99"), 2, "0"))
        CATCH TO loc_oErro
            loc_nDecimal = 0
        ENDTRY

        RETURN loc_nDecimal
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * par_cAliasCursor : Alias do cursor (ex: crMesAno)
    * Retorna: .T. se carregado com sucesso, .F. se cursor n?o aberto
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cMes = TratarNulo(Mes, "C")
                THIS.this_cAno = TratarNulo(Ano, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados obrigat?rios antes de Inserir/Atualizar
    * Retorna: .T. se v?lido, .F. se inv?lido (exibe mensagem ao usu?rio)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cMes)
            MsgAviso("M" + CHR(234) + "s obrigat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cAno) OR LEN(ALLTRIM(THIS.this_cAno)) < 4
            MsgAviso("Ano obrigat" + CHR(243) + "rio (4 d" + CHR(237) + "gitos).")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cSetors)
            MsgAviso("Fase/Setor obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cUniPrdts)
            MsgAviso("Unidade Produtiva obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Cria novo per?odo de carga hor?ria no SQL Server
    * Delega para InserirPeriodo usando this_cMes e this_cAno
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.InserirPeriodo(THIS.this_cMes, THIS.this_cAno)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Grava altera??es do calend?rio atual para o SQL Server
    * Delega para AlterarPeriodo que usa crCalendario como fonte
    * Retorna: .T. se atualizado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.AlterarPeriodo()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("U")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

