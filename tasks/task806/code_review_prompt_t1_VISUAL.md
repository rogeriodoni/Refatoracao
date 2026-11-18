# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1930 linhas total):

*-- Linhas 60 a 68:
60: *                          passado explicitamente pelo chamador.
61: *   par_cEscolha         - legado: Thisform.PcEscolha do pai (INSERIR/
62: *                          ALTERAR/PROCURAR) - decide a visibilidade de
63: *                          cmd_4c_Inserir/cmd_4c_Excluir (AplicarVisibilidadeBotoes).
64: *   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
65: *                          ja unifica a sessao com o pai; mantido so para
66: *                          auditoria/paridade com o legado.
67: *
68: * METODOS DE DADOS (ja implementados no BO - fases 1-2)

*-- Linhas 101 a 110:
101: *   - ConfigurarGrade (GradeSubN do legado -> grd_4c_Dados): 2 colunas
102: *     editaveis, transcritas do dump (Column1 "Operacao" W=150, Column2
103: *     "Seq" W=25 com InputMask "9").
104: *   - ConfigurarBotoes (shp_4c_Separador + cmd_4c_Inserir / cmd_4c_Excluir
105: *     / cmd_4c_Sair, todos da classe legado fwbtng - 80x100, Comic Sans MS
106: *     8 bold italic). O Shape eh criado ANTES dos botoes porque a area dele
107: *     fica EM CIMA deles (ver comentario do metodo).
108: *   - AplicarVisibilidadeBotoes (as 4 linhas de .cmdInserir/.cmdExcluir
109: *     .Visible/.Enabled do Init legado + o recalculo de shape1.Left/Width).
110: *     Roda DEPOIS do TornarControlesVisiveis, que forca Visible = .T. em

*-- Linhas 133 a 142:
133: *     (faixa 1-8, transcrita do legado).
134: *
135: * FASE 7 (esta fase): os eventos dos botoes -
136: *   - ConfigurarBINDEVENTs: liga o Click de cmd_4c_Inserir/cmd_4c_Excluir/
137: *     cmd_4c_Sair (AddObject cria botao SEM codigo de evento).
138: *   - CmdInserirClick (cmdInserir.Click: Locate da linha em branco + Insert
139: *     Into no cursor local com cidchaves = fUniqueIds() + foco na Column1).
140: *   - CmdExcluirClick (cmdExcluir.Click: Delete + Skip/Skip -1 + Refresh -
141: *     marca so no cursor local).
142: *   - BtnSairClick (cmdSair.Click: as DUAS validacoes do legado -

*-- Linhas 242 a 250:
242:     this_cOperacaoPai = ""
243: 
244:     *-- Thisform.PcEscolha do pai (INSERIR/ALTERAR/PROCURAR) - decide a
245:     *-- visibilidade de cmd_4c_Inserir/cmd_4c_Excluir (AplicarVisibilidadeBotoes)
246:     this_cEscolha = ""
247: 
248:     *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
249:     *-- sessao com o pai, ver comentario de DataSession abaixo)
250:     this_nDataSessionPai = 0

*-- Linhas 286 a 301:
286: 
287:     *-- Caption do SCX ("Operacoes do Caixa") - sobrescrito em
288:     *-- InicializarForm com o codigo da operacao-pai, igual ao legado
289:     *-- (.Caption = 'Operacoes do Caixa : ' + AllTrim(Proper(crSigCdOpe.Dopes)))
290:     Caption = "Opera" + CHR(231) + CHR(245) + "es do Caixa"
291: 
292:     *-- ControlBox = .F. (legado) -> Closable/MaxButton/MinButton = .F.
293:     *-- (padrao do projeto para dialogo sem chrome). Movable = .F. /
294:     *-- ClipControls = .F. / TitleBar = 0 / Themes = .F. - todos literais do
295:     *-- SCX. Sem barra de titulo e sem ControlBox, a unica saida eh pelo
296:     *-- botao Encerrar (cmd_4c_Sair -> BtnSairClick)
297:     TitleBar     = 0
298:     Closable     = .F.
299:     MaxButton    = .F.
300:     MinButton    = .F.
301:     Movable      = .F.

*-- Linhas 425 a 435:
425:                 *-- pcEscolha/Dopes do pai para o BO
426:                 THIS.CarregarContextoFormPai()
427: 
428:                 *-- Legado: .Caption = 'Operacoes do Caixa : ' +
429:                 *-- AllTrim(Proper(crSigCdOpe.Dopes))
430:                 THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es do Caixa : " + ;
431:                     ALLTRIM(PROPER(THIS.this_cOperacaoPai))
432: 
433:                 *-- Fundo do form (Picture do SCX)
434:                 THIS.ConfigurarDecoracao()
435: 

*-- Linhas 556 a 565:
556:     * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
557:     * legado, que ancora este dialogo ao lado da grade do form pai:
558:     *
559:     *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
560:     *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
561:     *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
562:     *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
563:     *
564:     * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
565:     * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/

*-- Linhas 594 a 611:
594:             RETURN
595:         ENDIF
596: 
597:         THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50
598: 
599:         IF loc_oGrade.ColumnCount >= 3
600:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
601:                         loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
602:         ELSE
603:             *-- Grade com menos de 3 colunas (layout divergente do esperado)
604:             *-- - aproximacao segura, so para o dialogo nao abrir fora da
605:             *-- area visivel
606:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
607:         ENDIF
608:     ENDPROC
609: 
610:     *==========================================================================
611:     * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do

*-- Linhas 624 a 632:
624:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
625:     *
626:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
627:     * ("Operacoes do Caixa : <operacao>"), por isso .Caption = THIS.Caption
628:     * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
629:     * do Form Designer, nunca chega a ser exibido.
630:     *
631:     * Width do container usa THIS.Width (canonico da faixa, regra #11) em
632:     * vez do literal 800: o SCX declara o CONTAINER mais largo que o

*-- Linhas 644 a 699:
644:         *-- Container da faixa (cntSombra)
645:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
646:         WITH THIS.cnt_4c_Cabecalho
647:             .Top           = 0
648:             .Left          = 0
649:             .Width         = THIS.Width
650:             .Height        = 80
651:             .BorderWidth   = 0
652:             .BackStyle     = 1
653:             .BackColor     = RGB(100, 100, 100)
654:             .SpecialEffect = 0
655:             .Visible       = .T.
656:         ENDWITH
657: 
658:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
659:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
660:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
661:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
662:             .AutoSize      = .F.
663:             .FontBold      = .T.
664:             .FontName      = "Tahoma"
665:             .FontSize      = 18
666:             .FontUnderline = .F.
667:             .WordWrap      = .T.
668:             .Alignment     = 0
669:             .BackStyle     = 0
670:             .Caption       = THIS.Caption
671:             .Top           = 18
672:             .Left          = 10
673:             .Width         = THIS.Width - 20
674:             .Height        = 40
675:             .ForeColor     = RGB(0, 0, 0)
676:             .Rotation      = 0
677:             .Visible       = .T.
678:         ENDWITH
679: 
680:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
681:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
682:         *-- regra #12)
683:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
684:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
685:             .AutoSize    = .F.
686:             .FontBold    = .T.
687:             .FontName    = "Tahoma"
688:             .FontSize    = 18
689:             .WordWrap    = .T.
690:             .Alignment   = 0
691:             .BackStyle   = 0
692:             .Caption     = THIS.Caption
693:             .Top         = 17
694:             .Left        = 10
695:             .Width       = THIS.Width - 20
696:             .Height      = 46
697:             .ForeColor   = RGB(255, 255, 255)
698:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
699:             .Rotation    = 0

*-- Linhas 749 a 758:
749:         THIS.AddObject("grd_4c_Dados", "Grid")
750: 
751:         WITH THIS.grd_4c_Dados
752:             .Top           = 110
753:             .Left          = 147
754:             .Width         = 206
755:             .Height        = 221
756:             .FontName      = "Tahoma"
757:             .FontSize      = 8
758:             .DeleteMark    = .F.

*-- Linhas 779 a 787:
779:             .Header1.FontName  = "Tahoma"
780:             .Header1.FontSize  = 8
781:             .Header1.Alignment = 2
782:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
783:             .txt_4c_Nivel.FontName    = "Tahoma"
784:             .txt_4c_Nivel.FontSize    = 8
785:             .txt_4c_Nivel.BorderStyle = 0
786:             .txt_4c_Nivel.Margin      = 0
787:             *-- MaxLength pela largura da COLUNA no schema (SigMvCxs.cnivels

*-- Linhas 806 a 814:
806:             .Header1.FontName  = "Tahoma"
807:             .Header1.FontSize  = 8
808:             .Header1.Alignment = 2
809:             .Header1.Caption   = "Seq"
810:             .txt_4c_Seq.FontName    = "Tahoma"
811:             .txt_4c_Seq.FontSize    = 8
812:             .txt_4c_Seq.BorderStyle = 0
813:             .txt_4c_Seq.InputMask   = "9"
814:             .txt_4c_Seq.Margin      = 0

*-- Linhas 873 a 943:
873:         *-- Shape1 do legado - moldura em volta do bloco de botoes
874:         THIS.AddObject("shp_4c_Separador", "Shape")
875:         WITH THIS.shp_4c_Separador
876:             .Top         = 12
877:             .Left        = 80
878:             .Height      = 110
879:             .Width       = 257
880:             .BackStyle   = 0
881:             .BorderStyle = 0
882:             .BorderColor = RGB(136, 189, 188)
883:             .Visible     = .T.
884:         ENDWITH
885: 
886:         *-- cmdInserir
887:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
888:         WITH THIS.cmd_4c_Inserir
889:             .Top             = 3
890:             .Left            = 390
891:             .Width           = 80
892:             .Height          = 100
893:             .FontBold        = .T.
894:             .FontItalic      = .T.
895:             .FontName        = "Comic Sans MS"
896:             .FontSize        = 8
897:             .WordWrap        = .T.
898:             .MousePointer    = 15
899:             .ForeColor       = RGB(90, 90, 90)
900:             .BackColor       = RGB(255, 255, 255)
901:             .Themes          = .T.
902:             .TabIndex        = 9
903:             .Caption         = "Inserir"
904:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
905:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
906:             .Visible         = .T.
907:         ENDWITH
908: 
909:         *-- cmdExcluir
910:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
911:         WITH THIS.cmd_4c_Excluir
912:             .Top             = 3
913:             .Left            = 465
914:             .Width           = 80
915:             .Height          = 100
916:             .FontBold        = .T.
917:             .FontItalic      = .T.
918:             .FontName        = "Comic Sans MS"
919:             .FontSize        = 8
920:             .WordWrap        = .T.
921:             .MousePointer    = 15
922:             .ForeColor       = RGB(90, 90, 90)
923:             .BackColor       = RGB(255, 255, 255)
924:             .Themes          = .T.
925:             .TabIndex        = 7
926:             .Caption         = "Excluir"
927:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
928:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
929:             .Visible         = .T.
930:         ENDWITH
931: 
932:         *-- cmdSair ("Encerrar"). Cancel = .T. do dump: com TitleBar = 0 e
933:         *-- ControlBox = .F., o ESC acionar este botao eh a unica saida do
934:         *-- dialogo por teclado
935:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
936:         WITH THIS.cmd_4c_Sair
937:             .Top             = 3
938:             .Left            = 540
939:             .Width           = 75
940:             .Height          = 75
941:             .FontBold        = .T.
942:             .FontItalic      = .T.
943:             .FontName        = "Comic Sans MS"

*-- Linhas 949 a 957:
949:             .Themes          = .T.
950:             .Cancel          = .T.
951:             .TabIndex        = 8
952:             .Caption         = "Encerrar"
953:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
954:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
955:             .Visible         = .T.
956:         ENDWITH
957:     ENDPROC

*-- Linhas 966 a 1010:
966:     *   .cmdInserir.Enabled = <a mesma expressao>
967:     *   .cmdExcluir.Visible = fChecaAcesso('SigOpSqn','EXCLUIR') And <idem>
968:     *   .cmdExcluir.Enabled = <a mesma expressao>
969:     *   .shape1.Left  = IIF(.cmdInserir.visible, .cmdInserir.Left - 5,
970:     *                   IIF(.cmdExcluir.visible, .cmdExcluir.left - 5,
971:     *                       .cmdSair.Left - 5))
972:     *   .shape1.width = IIF(.cmdInserir.visible, 3,
973:     *                   IIF(.cmdExcluir.visible, 2, 1)) * .cmdsair.width + 16
974:     *
975:     * O "Type('Thisform.PcEscolha') # 'C'" do legado eh o caso "o chamador
976:     * nao informou o modo" - aqui corresponde a this_cEscolha vazia (o Init
977:     * guarda "" quando par_cEscolha nao vem), e tambem libera os botoes,
978:     * igual ao legado. Mesma leitura adotada no dialogo irmao FormSigOpSno.
979:     *
980:     * cmd_4c_Sair NUNCA eh escondido: ele eh a unica saida da tela.
981:     *==========================================================================
982:     PROTECTED PROCEDURE AplicarVisibilidadeBotoes
983:         LOCAL loc_lModoEdicao, loc_lInserir, loc_lExcluir
984: 
985:         loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
986:             INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
987: 
988:         loc_lInserir = THIS.PossuiAcessoOperacao("INSERIR") AND loc_lModoEdicao
989:         loc_lExcluir = THIS.PossuiAcessoOperacao("EXCLUIR") AND loc_lModoEdicao
990: 
991:         THIS.cmd_4c_Inserir.Visible = loc_lInserir
992:         THIS.cmd_4c_Inserir.Enabled = loc_lInserir
993:         THIS.cmd_4c_Excluir.Visible = loc_lExcluir
994:         THIS.cmd_4c_Excluir.Enabled = loc_lExcluir
995: 
996:         DO CASE
997:         CASE THIS.cmd_4c_Inserir.Visible
998:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Inserir.Left - 5
999:             THIS.shp_4c_Separador.Width = 3 * THIS.cmd_4c_Sair.Width + 16
1000:         CASE THIS.cmd_4c_Excluir.Visible
1001:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Excluir.Left - 5
1002:             THIS.shp_4c_Separador.Width = 2 * THIS.cmd_4c_Sair.Width + 16
1003:         OTHERWISE
1004:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
1005:             THIS.shp_4c_Separador.Width = 1 * THIS.cmd_4c_Sair.Width + 16
1006:         ENDCASE
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * PossuiAcessoOperacao - fChecaAcesso('SigOpSqn', <acao>) do legado

*-- Linhas 1093 a 1102:
1093: 
1094:             .Column1.Header1.Alignment = 2
1095:             .Column2.Header1.Alignment = 2
1096:             .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1097:             .Column2.Header1.Caption   = "Seq"
1098: 
1099:             .Column1.CurrentControl = "txt_4c_Nivel"
1100:             .Column2.CurrentControl = "txt_4c_Seq"
1101:             .Column1.Sparse         = .F.
1102:             .Column2.Sparse         = .F.

*-- Linhas 1299 a 1308:
1299:     * Metodo PUBLIC (regra #3/#46).
1300:     *==========================================================================
1301:     PROCEDURE NivelGradeLostFocus(par_oTxt)
1302:         IF EMPTY(NVL(par_oTxt.Value, "")) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1303:             THIS.cmd_4c_Sair.SetFocus()
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     *==========================================================================
1308:     * GuardarValorAnteriorSeq - When do Column2.Text1 legado:

*-- Linhas 1360 a 1370:
1360:     * BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
1361:     *==========================================================================
1362:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1363:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
1364:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
1365:         BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
1366:     ENDPROC
1367: 
1368:     *==========================================================================
1369:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1370:     *

*-- Linhas 1542 a 1550:
1542:         loc_lPodeFechar = .T.
1543: 
1544:         TRY
1545:             IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
1546:                 IF THIS.this_lHouveExclusao OR THIS.this_lHouveInclusao OR ;
1547:                    THIS.this_lHouveAlteracao
1548: 
1549:                     *-- Legado: Select CrSigMvCxs / Go Top / Go bottom
1550:                     IF USED("cursor_4c_Sequencias")


### BO (C:\4c\projeto\app\classes\SigOpSqnBO.prg):
*==============================================================================
* SigOpSqnBO.prg - Business Object para "Sequencia de Operacoes do Caixa" (SIGOPSQN)
*
* Origem legado : SigOpSqn.SCX  (tasks\task806)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes do Caixa)
* Tabela base   : SigMvCxs | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que grava a SEQUENCIA de execucao das operacoes de caixa de
* uma operacao-pai (crSigCdOpe.Dopes). O legado recebe "poForm" (o form pai)
* e "pnDataSes" (DataSession do pai) no Init, troca para a DataSession do pai
* e manipula um cursor REMOTO bufferizado ("crSigMvCxs", requeried via
* SigCdOpe.poDataMgr) que lista as linhas de SigMvCxs filtradas pela operacao
* corrente. A grade (GradeSubN) tem 2 colunas editaveis:
*   Column1 -> cNivels (TextBox com lookup em TmpOper/SigCdOpe.Dopes, filtrado
*              por CupFis IN (1,3) - so operacoes de "Cupom Fiscal")
*   Column2 -> Seqs    (TextBox numerico, InputMask "9", faixa 1-8)
* Botoes: Inserir (Append Blank + foca Column1), Excluir (Delete da linha
* corrente) e Sair/Encerrar (valida duplicidade/sequencia ausente, grava via
* poDataMgr.UpDate + Commit, reabilita os botoes do pai e fecha o dialogo).
*
* GRAVACAO
* --------
* O legado grava via TableUpdate do cursor bufferizado inteiro (poDataMgr.
* UpDate('crSigMvCxs') + Commit()) so no clique de Sair/Encerrar - nao ha
* Inserir/Atualizar/Excluir linha-a-linha contra o SQL Server durante a
* edicao da grade (isso fica so no cursor local, igual ao padrao de
* SigOpSnoBO.ListarSubNiveis/ListarSubSubNiveis: cursor READWRITE editado
* pela grade, e o BO grava quando o Form decide persistir).
*
* METODOS DE DADOS (todos entregues)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia cidchaves/cdopes/cnivels/seqs
*       de uma linha de SigMvCxs para as properties deste BO (Fase 2).
*   ListarSequencias(par_cOperacaoPai)  - popula THIS.this_cCursorSequencias
*       com as linhas de SigMvCxs da operacao-pai, equivalente ao legado
*       ReQuery('crSigMvCxs') (cursor READWRITE - a grade insere/remove linha
*       por Append Blank/Delete direto no cursor local). Eh o que alimenta a
*       grade do form (FormSigOpSqn.CarregarDados).
*   ListarOperacoesCupFis()             - popula THIS.this_cCursorOperacoes
*       com "Select Dopes From SigCdOpe Where CupFis in (1,3)", equivalente
*       ao legado TmpOper (universo do lookup da coluna cNivels). Fase 6 -
*       carregado UMA VEZ no InicializarForm, igual ao legado (nao eh
*       re-executado a cada CarregarDados).
*   LimparDados()                       - override da Fase 8: zera as 4
*       properties da entidade. Quem chama eh NovoRegistro(), antes do
*       FormSigOpSqn.FormParaBO atribuir a linha nova.
*   Inserir / Atualizar / ExecutarExclusao - PROTECTED, uma LINHA por
*       chamada. De fora usa-se Salvar()/Excluir() (regra #51).
*
*   A persistencia do cursor INTEIRO (equivalente ao poDataMgr.UpDate
*   ('crSigMvCxs') + Commit() do legado) NAO ficou aqui: ela eh
*   FormSigOpSqn.PersistirSequencias, que percorre o cursor local e chama
*   Salvar()/Excluir() linha a linha. O motivo eh que quem sabe o que a
*   SESSAO do dialogo mudou eh o form - ele guarda as linhas criadas
*   (this_cCidChavesNovas) e as marcas de exclusao do cursor, que sao o que
*   distingue INSERT de UPDATE e de DELETE; o legado tirava isso do buffer
*   da view remota, que nao existe aqui. Um metodo neste BO recebendo o
*   alias do cursor duplicaria esse estado em dois donos.
*
* VALIDACOES DO LEGADO QUE PERTENCEM AO cmdSair.Click (regra de negocio
* transcrita LITERALMENTE em FormSigOpSqn.ExisteOperacaoDuplicada e
* ExisteSequenciaNaoInformada, NUNCA reescrita):
*   1) Nenhuma cNivels duplicada em crSigMvCxs (Group By cNivels Having
*      Sum(1) > 1 -> "Existem Operacoes Duplicadas!!!").
*   2) Nenhuma linha com cNivels preenchida e Seqs = 0 (Where Not Empty
*      (cNivels) And Seqs = 0 -> "Existem Operacoes sem Sequencia
*      informada!!!").
*   As duas SO valem quando cmdInserir.Visible Or cmdExcluir.Visible (ou
*   seja, quando o pai esta em INSERIR/ALTERAR) E quando houve alguma
*   alteracao na sessao (lHouveExcl/lHouveIns/lHouveAlt).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos
* controles e no dimensionamento das colunas do cursor
* -------------------------------------------------------------------
*   SigMvCxs.cdopes     char(20) NOT NULL  SigMvCxs.cidchaves char(20) NOT NULL (PK)
*   SigMvCxs.cnivels    char(20) NOT NULL  SigMvCxs.seqs      numeric(2,0) NOT NULL
*   SigCdOpe.dopes      char(20) NOT NULL  - PK/descricao (coluna unica, ver
*                        regra do pipeline "SigCdOpe eh single-column: NUNCA
*                        usar descrs/Descrs")
*==============================================================================

DEFINE CLASS SigOpSqnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de sequencia de operacao (SigMvCxs)
    *--------------------------------------------------------------------------
    this_cCidChaves          = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cCDopes             = ""   && cdopes    char(20) NOT NULL - FK SigCdOpe.dopes (operacao-pai, a do cadastro)
    this_cCNivels            = ""   && cnivels   char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada na sequencia)
    this_nSeqs               = 0    && seqs      numeric(2,0) NOT NULL - sequencia de execucao (1 a 8)

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm / Set DataSession To pnDataSes / pcEscolha
    *--------------------------------------------------------------------------
    this_cEscolha            = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR (habilita Inserir/Excluir)
    this_nDataSessionPai     = 0    && DataSessionId do pai (poForm.DataSessionId / pnDataSes do legado)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouvealt / lhouveexcl / lhouveins do
    * SIGOPSQN - usadas pelo cmdSair.Click para decidir se valida e grava.
    *
    * DONO UNICO (Fase 8): no legado essas tres flags sao do FORM, e no
    * migrado continuam sendo - quem escreve e quem le eh FormSigOpSqn
    * (this_lHouveAlteracao/this_lHouveInclusao/this_lHouveExclusao), nos
    * mesmos pontos do legado (Valid das celulas, Click de Inserir/Excluir,
    * BtnSairClick). As copias aqui ficam ZERADAS e servem so de espelho
    * documental do legado: NAO ligar codigo novo nelas sem antes remover as
    * do form, senao a tela passa a ter dois donos do mesmo estado e eles
    * divergem em silencio (a gravacao do Encerrar le o dono errado e nao
    * grava nada, ou grava sem alteracao nenhuma).
    *--------------------------------------------------------------------------
    this_lHouveAlteracao     = .F.  && lhouvealt  - houve alteracao de cNivels/Seqs numa linha existente
    this_lHouveExclusao      = .F.  && lhouveexcl - houve exclusao de linha
    this_lHouveInclusao      = .F.  && lhouveins  - houve inclusao de linha

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorSequencias   = "cursor_4c_Sequencias"  && crSigMvCxs - linhas de SigMvCxs da operacao-pai (grade)
    this_cCursorOperacoes    = "cursor_4c_Operacoes"   && TmpOper    - universo do lookup (SigCdOpe.Dopes, CupFis IN (1,3))

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SigMvCxs.cidchaves) e repoe os
    * valores iniciais que o legado tem na propria sessao do dialogo
    * (nenhuma alteracao/inclusao/exclusao ainda ocorrida).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvCxs"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nSeqs           = 0
        THIS.this_nDataSessionPai = 0
        THIS.this_lHouveAlteracao = .F.
        THIS.this_lHouveExclusao  = .F.
        THIS.this_lHouveInclusao  = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - zera as properties da ENTIDADE (Fase 8)
    *
    * BusinessBase.LimparDados so limpa this_cMensagemErro e deixa dito que
    * "subclasses devem limpar suas propriedades especificas". Quem chama eh
    * NovoRegistro() (e CancelarEdicao()/Excluir()), ou seja: toda vez que o
    * form prepara uma linha NOVA para gravar.
    *
    * Sem este override, as 4 properties entravam na linha nova com o valor
    * da linha ANTERIOR do laco de FormSigOpSqn.PersistirSequencias - hoje
    * isso fica mascarado porque o FormParaBO logo em seguida atribui as
    * quatro, mas qualquer caminho que deixasse de atribuir uma delas
    * gravaria o dado da linha errada, sem erro nenhum na tela.
    *
    * NAO limpa this_cCursorSequencias/this_cCursorOperacoes (nomes de alias,
    * nao dado) nem this_cEscolha/this_nDataSessionPai (contexto do form pai,
    * valido por toda a sessao do dialogo) - zerar esses derrubaria a carga
    * da grade e o controle de acesso aos botoes.
    *
    * DODEFAULT() primeiro, para nao perder a limpeza da mensagem de erro
    * feita pela base.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCDopes    = ""
        THIS.this_cCNivels   = ""
        THIS.this_nSeqs      = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de sequencia
    * (SigMvCxs) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Sequencias, populado por ListarSequencias,
    * ou qualquer outro cursor/SELECT que inclua as mesmas 4 colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCDopes    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivels   = TratarNulo(cnivels,   "C")
                THIS.this_nSeqs      = TratarNulo(seqs,      "N")

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSequencias - Popula cursor_4c_Sequencias com as linhas de SigMvCxs
    * da operacao-pai, equivalente ao legado "ReQuery('crSigMvCxs')".
    *
    * A consulta eh a MESMA que o form pai (SIGCDOPE) registra para esse
    * cursor no seu AddCursor:
    *
    *   Select a.* From SigMvCxs a inner join SigCdOpe b on a.cdopes = b.Dopes
    *   Where a.cDopes = ?crSigCdOpe.Dopes Order by a.cDopes, a.cnivels
    *
    * As 4 colunas sao listadas explicitamente no lugar de "a.*": SigMvCxs
    * tem exatamente cdopes/cidchaves/cnivels/seqs (docs\schema.sql), e a
    * lista explicita eh o que garante que o CREATE/SELECT INTO e os
    * ControlSource da grade casem por nome.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): as duas colunas da grade sao editaveis e os botoes Inserir/
    * Excluir inserem e apagam linha direto no cursor local, igual ao legado
    * (Insert Into crSigMvCxs / Delete). Sem READWRITE a celula nem entra em
    * edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarSequencias(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg):
        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cdopes, a.cidchaves, a.cnivels, a.seqs" + ;
                       " FROM SigMvCxs a" + ;
                       " INNER JOIN SigCdOpe b ON a.cdopes = b.dopes" + ;
                       " WHERE a.cdopes = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cdopes, a.cnivels"

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Sequencias")
                    USE IN cursor_4c_Sequencias
                ENDIF

                SELECT * FROM cursor_4c_SeqTmp INTO CURSOR cursor_4c_Sequencias READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar as sequ" + CHR(234) + "ncias da opera" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarSequencias:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarOperacoesCupFis - Popula cursor_4c_Operacoes com o universo do
    * lookup da Column1 (cnivels), equivalente ao legado TmpOper:
    *
    *   lcSql = [Select Dopes From SigCdOpe Where CupFis in (1,3)]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcsql,'TmpOper')
    *   Select TmpOper
    *   Index On Dopes Tag dopes
    *
    * Carregado UMA VEZ (igual ao legado, no Init) - diferente de
    * ListarSequencias, que eh re-executado a cada CarregarDados deste
    * dialogo. Chamado por FormSigOpSqn.InicializarForm, antes do usuario
    * poder editar a grade.
    *
    * SigCdOpe eh single-column (regra do pipeline "SigCdOpe eh
    * single-column: NUNCA usar descrs/Descrs"): a mesma coluna dopes serve
    * de PK E de descricao - nao ha coluna de descricao separada.
    *
    * INDEX ON dopes TAG dopes - para o Valid da celula localizar com SEEK,
    * igual ao legado (Seek(This.Value, 'TmpOper', 'Dopes')).
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarOperacoesCupFis()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg)
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT dopes FROM SigCdOpe WHERE cupfis IN (1, 3)"

            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar o universo de opera" + CHR(231) + CHR(245) + ;
                    "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarOperacoesCupFis:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de sequencia (SigMvCxs) no banco.
    * Equivalente ao legado cmdInserir.Click (Insert Into crSigMvCxs) seguido
    * da persistencia feita no Sair/Encerrar (poDataMgr.UpDate + Commit) -
    * aqui a gravacao do INSERT ja eh direta contra o SQL Server, por linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o proximo registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigMvCxs (cdopes, cidchaves, cnivels, seqs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqs, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSqn")
                USE IN cursor_4c_InsSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de sequencia (SigMvCxs) ja existente.
    * Equivalente a legado editando cNivels/Seqs direto na grade (Column1/
    * Column2.Valid) e persistindo no Sair/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCxs SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " seqs    = " + FormatarNumeroSQL(THIS.this_nSeqs, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSqn")
                USE IN cursor_4c_UpdSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove uma linha de sequencia (SigMvCxs) do banco.
    * Equivalente ao legado cmdExcluir.Click (Delete da linha corrente de
    * crSigMvCxs), com a persistencia feita diretamente contra o SQL Server.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCxs" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSqn")
                USE IN cursor_4c_DelSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

