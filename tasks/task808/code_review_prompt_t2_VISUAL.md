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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSts.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2193 linhas total):

*-- Linhas 66 a 74:
66: *                          passado explicitamente pelo chamador.
67: *   par_cEscolha         - legado: Thisform.PcEscolha do pai (INSERIR/
68: *                          ALTERAR/PROCURAR) - decide a visibilidade de
69: *                          cmd_4c_Inserir/cmd_4c_Excluir (ver
70: *                          AplicarVisibilidadeBotoes).
71: *   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
72: *                          ja unifica a sessao com o pai; mantido so para
73: *                          auditoria/paridade com o legado.
74: *

*-- Linhas 112 a 121:
112: *     leitura permanente); Column1 fica ReadOnly = .F. no nivel do Grid -
113: *     a condicao por linha (When = Empty(status)) e o lookup vem da classe
114: *     da celula instalada na Fase 6 (regra #18/#46).
115: *   - ConfigurarBotoes (shp_4c_Separador + cmd_4c_Inserir/cmd_4c_Excluir/
116: *     cmd_4c_Sair, todos da classe legado fwbtng - transcritos do dump:
117: *     Top=3, Left=375/450/525). O Shape eh criado ANTES dos botoes porque
118: *     a area dele fica EM CIMA deles (ver comentario do metodo).
119: *   - AplicarVisibilidadeBotoes (as 4 linhas de .cmdInserir/.cmdExcluir
120: *     .Visible/.Enabled do Init legado + o recalculo de shape1.Left/Width).
121: *     Roda DEPOIS do TornarControlesVisiveis, que forca Visible = .T. em

*-- Linhas 201 a 209:
201: *                          (regra #46), por isso a CELULA vence o cursor no
202: *                          campo status.
203: *   - BOParaForm         - properties do BO -> linha corrente + celula +
204: *                          Refresh. Eh a transcricao do "This.Value = ... /
205: *                          Replace Descs With ... / This.Refresh / Select
206: *                          LocalStats" do Valid legado. O metodo
207: *                          AbrirLookupStatusStsExec passou a usar estes dois
208: *                          hooks em vez de repetir o REPLACE.
209: *   - LimparCampos       - zera a ficha da linha no funil de carga, para a

*-- Linhas 265 a 273:
265:     this_cOperacaoPai = ""
266: 
267:     *-- Thisform.PcEscolha do pai (INSERIR/ALTERAR/PROCURAR) - decide a
268:     *-- visibilidade de cmd_4c_Inserir/cmd_4c_Excluir (ver
269:     *-- AplicarVisibilidadeBotoes)
270:     this_cEscolha = ""
271: 
272:     *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
273:     *-- sessao com o pai, ver comentario de DataSession abaixo)

*-- Linhas 299 a 317:
299: 
300:     *-- Caption do SCX ("Status por Operacoes") - sobrescrito em
301:     *-- InicializarForm com o codigo da operacao-pai, igual ao legado
302:     *-- (.Caption = 'Status das Operacoes ' + AllTrim(Proper(crSigCdOpe.Dopes)))
303:     Caption = "Status por Opera" + CHR(231) + CHR(245) + "es"
304: 
305:     *-- ControlBox = .F. (legado) -> Closable/MaxButton/MinButton = .F.
306:     *-- (padrao do projeto para dialogo sem chrome, mesmo padrao dos
307:     *-- dialogos irmaos). Movable = .T. (literal do dump - diferente do
308:     *-- irmao FormSigOpSqn, que declara .F.: transcrever o que o SCX desta
309:     *-- tela realmente tem, nao copiar do irmao). ClipControls = .F. /
310:     *-- TitleBar = 0 - literais do SCX. Sem barra de titulo e sem
311:     *-- ControlBox, a unica saida eh pelo botao Encerrar
312:     *-- (cmd_4c_Sair -> BtnSairClick)
313:     TitleBar     = 0
314:     Closable     = .F.
315:     MaxButton    = .F.
316:     MinButton    = .F.
317:     Movable      = .T.

*-- Linhas 439 a 449:
439:                 *-- Dopes/PcEscolha/DataSession para o BO
440:                 THIS.CarregarContextoFormPai()
441: 
442:                 *-- Legado: .Caption = 'Status das Operacoes ' +
443:                 *-- AllTrim(Proper(crSigCdOpe.Dopes))
444:                 THIS.Caption = "Status das Opera" + CHR(231) + CHR(245) + "es " + ;
445:                     ALLTRIM(PROPER(THIS.this_cOperacaoPai))
446: 
447:                 *-- Fundo do form (Picture do SCX)
448:                 THIS.ConfigurarDecoracao()
449: 

*-- Linhas 557 a 566:
557:     * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
558:     * legado, que ancora este dialogo ao lado da grade do form pai:
559:     *
560:     *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
561:     *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
562:     *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
563:     *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
564:     *
565:     * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
566:     * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/

*-- Linhas 595 a 612:
595:             RETURN
596:         ENDIF
597: 
598:         THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50
599: 
600:         IF loc_oGrade.ColumnCount >= 3
601:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
602:                         loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
603:         ELSE
604:             *-- Grade com menos de 3 colunas (layout divergente do esperado)
605:             *-- - aproximacao segura, so para o dialogo nao abrir fora da
606:             *-- area visivel
607:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
608:         ENDIF
609:     ENDPROC
610: 
611:     *==========================================================================
612:     * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do

*-- Linhas 625 a 633:
625:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
626:     *
627:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
628:     * ("Status das Operacoes <operacao>"), por isso .Caption = THIS.Caption
629:     * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
630:     * do Form Designer, nunca chega a ser exibido.
631:     *
632:     * Width do container usa THIS.Width - padrao canonico da faixa, regra #11 - em
633:     * vez do literal 800: o SCX declara o CONTAINER mais largo que o

*-- Linhas 645 a 700:
645:         *-- Container da faixa (cntSombra)
646:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
647:         WITH THIS.cnt_4c_Cabecalho
648:             .Top           = 0
649:             .Left          = 0
650:             .Width         = THIS.Width
651:             .Height        = 80
652:             .BorderWidth   = 0
653:             .BackStyle     = 1
654:             .BackColor     = RGB(100, 100, 100)
655:             .SpecialEffect = 0
656:             .Visible       = .T.
657:         ENDWITH
658: 
659:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
660:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
661:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
662:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
663:             .AutoSize      = .F.
664:             .FontBold      = .T.
665:             .FontName      = "Tahoma"
666:             .FontSize      = 18
667:             .FontUnderline = .F.
668:             .WordWrap      = .T.
669:             .Alignment     = 0
670:             .BackStyle     = 0
671:             .Caption       = THIS.Caption
672:             .Top           = 18
673:             .Left          = 10
674:             .Width         = THIS.Width - 20
675:             .Height        = 40
676:             .ForeColor     = RGB(0, 0, 0)
677:             .Rotation      = 0
678:             .Visible       = .T.
679:         ENDWITH
680: 
681:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
682:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
683:         *-- regra #12)
684:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
685:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
686:             .AutoSize    = .F.
687:             .FontBold    = .T.
688:             .FontName    = "Tahoma"
689:             .FontSize    = 18
690:             .WordWrap    = .T.
691:             .Alignment   = 0
692:             .BackStyle   = 0
693:             .Caption     = THIS.Caption
694:             .Top         = 17
695:             .Left        = 10
696:             .Width       = THIS.Width - 20
697:             .Height      = 46
698:             .ForeColor   = RGB(255, 255, 255)
699:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
700:             .Rotation    = 0

*-- Linhas 753 a 762:
753:         THIS.AddObject("grd_4c_Dados", "Grid")
754: 
755:         WITH THIS.grd_4c_Dados
756:             .Top           = 94
757:             .Left          = 146
758:             .Width         = 307
759:             .Height        = 238
760:             .FontName      = "Tahoma"
761:             .FontSize      = 8
762:             .DeleteMark    = .F.

*-- Linhas 783 a 791:
783:             .Header1.FontName  = "Tahoma"
784:             .Header1.FontSize  = 8
785:             .Header1.Alignment = 2
786:             .Header1.Caption   = "Status"
787:         ENDWITH
788: 
789:         *-- A celula (AddObject + CurrentControl + Sparse) eh instalada num
790:         *-- LUGAR SO - GarantirCelulaStatus - porque ela precisa ser
791:         *-- REINSTALADA toda vez que as Columns sao recriadas (ver o

*-- Linhas 802 a 810:
802:             .Header1.FontName  = "Tahoma"
803:             .Header1.FontSize  = 8
804:             .Header1.Alignment = 2
805:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
806:             .Text1.FontName    = "Tahoma"
807:             .Text1.FontSize    = 8
808:             .Text1.BorderStyle = 0
809:             .Text1.Margin      = 0
810:             .Text1.MaxLength   = 20

*-- Linhas 844 a 852:
844:     * um controle criado DEPOIS desenha por cima - mesmo transparente
845:     * (BackStyle=0), ele passaria a interceptar o clique dos botoes.
846:     *
847:     * cmd_4c_Sair usa Width=75/Height=75 (nao 80/100): mesmo padrao adotado
848:     * no dialogo irmao FormSigOpSqn.prg para o botao "Encerrar" desta
849:     * familia de dialogos.
850:     *
851:     * Themes = .T. + DisabledPicture: canonico do projeto para CommandButton
852:     * standalone COM Picture - com Themes = .F. (o default do fwbtng) o icone

*-- Linhas 867 a 937:
867:         *-- Shape1 do legado - moldura em volta do bloco de botoes
868:         THIS.AddObject("shp_4c_Separador", "Shape")
869:         WITH THIS.shp_4c_Separador
870:             .Top         = 12
871:             .Left        = 92
872:             .Height      = 110
873:             .Width       = 257
874:             .BackStyle   = 0
875:             .BorderStyle = 0
876:             .BorderColor = RGB(136, 189, 188)
877:             .Visible     = .T.
878:         ENDWITH
879: 
880:         *-- cmdInserir
881:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
882:         WITH THIS.cmd_4c_Inserir
883:             .Top             = 3
884:             .Left            = 375
885:             .Width           = 80
886:             .Height          = 100
887:             .FontBold        = .T.
888:             .FontItalic      = .T.
889:             .FontName        = "Comic Sans MS"
890:             .FontSize        = 8
891:             .WordWrap        = .T.
892:             .MousePointer    = 15
893:             .ForeColor       = RGB(90, 90, 90)
894:             .BackColor       = RGB(255, 255, 255)
895:             .Themes          = .T.
896:             .TabIndex        = 4
897:             .Caption         = "Inserir"
898:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
899:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
900:             .Visible         = .T.
901:         ENDWITH
902: 
903:         *-- cmdExcluir
904:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
905:         WITH THIS.cmd_4c_Excluir
906:             .Top             = 3
907:             .Left            = 450
908:             .Width           = 80
909:             .Height          = 100
910:             .FontBold        = .T.
911:             .FontItalic      = .T.
912:             .FontName        = "Comic Sans MS"
913:             .FontSize        = 8
914:             .WordWrap        = .T.
915:             .MousePointer    = 15
916:             .ForeColor       = RGB(90, 90, 90)
917:             .BackColor       = RGB(255, 255, 255)
918:             .Themes          = .T.
919:             .TabIndex        = 2
920:             .Caption         = "Excluir"
921:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
922:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
923:             .Visible         = .T.
924:         ENDWITH
925: 
926:         *-- cmdSair ("Encerrar"). Cancel = .T. do dump: com TitleBar = 0 e
927:         *-- ControlBox = .F., o ESC acionar este botao eh a unica saida do
928:         *-- dialogo por teclado
929:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
930:         WITH THIS.cmd_4c_Sair
931:             .Top             = 3
932:             .Left            = 525
933:             .Width           = 75
934:             .Height          = 75
935:             .FontBold        = .T.
936:             .FontItalic      = .T.
937:             .FontName        = "Comic Sans MS"

*-- Linhas 943 a 951:
943:             .Themes          = .T.
944:             .Cancel          = .T.
945:             .TabIndex        = 3
946:             .Caption         = "Encerrar"
947:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
948:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
949:             .Visible         = .T.
950:         ENDWITH
951:     ENDPROC

*-- Linhas 960 a 1004:
960:     *   .cmdInserir.Enabled = <a mesma expressao>
961:     *   .cmdExcluir.Visible = fChecaAcesso('SIGOPSTS','EXCLUIR') And <idem>
962:     *   .cmdExcluir.Enabled = <a mesma expressao>
963:     *   .shape1.Left  = IIF(.cmdInserir.visible, .cmdInserir.Left - 5,
964:     *                   IIF(.cmdExcluir.visible, .cmdExcluir.left - 5,
965:     *                       .cmdSair.Left - 5))
966:     *   .shape1.width = IIF(.cmdInserir.visible, 3,
967:     *                   IIF(.cmdExcluir.visible, 2, 1)) * .cmdsair.width + 16
968:     *
969:     * O "Type('Thisform.PcEscolha') # 'C'" do legado eh o caso "o chamador
970:     * nao informou o modo" - aqui corresponde a this_cEscolha vazia (o Init
971:     * guarda "" quando par_cEscolha nao vem), e tambem libera os botoes,
972:     * igual ao legado. Mesma leitura adotada no dialogo irmao FormSigOpSqn.
973:     *
974:     * cmd_4c_Sair NUNCA eh escondido: ele eh a unica saida da tela.
975:     *==========================================================================
976:     PROTECTED PROCEDURE AplicarVisibilidadeBotoes
977:         LOCAL loc_lModoEdicao, loc_lInserir, loc_lExcluir
978: 
979:         loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
980:             INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
981: 
982:         loc_lInserir = THIS.PossuiAcessoOperacao("INSERIR") AND loc_lModoEdicao
983:         loc_lExcluir = THIS.PossuiAcessoOperacao("EXCLUIR") AND loc_lModoEdicao
984: 
985:         THIS.cmd_4c_Inserir.Visible = loc_lInserir
986:         THIS.cmd_4c_Inserir.Enabled = loc_lInserir
987:         THIS.cmd_4c_Excluir.Visible = loc_lExcluir
988:         THIS.cmd_4c_Excluir.Enabled = loc_lExcluir
989: 
990:         DO CASE
991:         CASE THIS.cmd_4c_Inserir.Visible
992:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Inserir.Left - 5
993:             THIS.shp_4c_Separador.Width = 3 * THIS.cmd_4c_Sair.Width + 16
994:         CASE THIS.cmd_4c_Excluir.Visible
995:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Excluir.Left - 5
996:             THIS.shp_4c_Separador.Width = 2 * THIS.cmd_4c_Sair.Width + 16
997:         OTHERWISE
998:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
999:             THIS.shp_4c_Separador.Width = 1 * THIS.cmd_4c_Sair.Width + 16
1000:         ENDCASE
1001: 
1002:         *-- A trava da celula de status acompanha os botoes: sem isto, o modo
1003:         *-- so-leitura do pai (PROCURAR, ou usuario sem acesso) esconderia os
1004:         *-- botoes de linha e deixaria a Column1 editavel. Deriva de

*-- Linhas 1088 a 1097:
1088: 
1089:             .Column1.Header1.Alignment = 2
1090:             .Column2.Header1.Alignment = 2
1091:             .Column1.Header1.Caption   = "Status"
1092:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1093: 
1094:         ENDWITH
1095: 
1096:         *-- O rebind reseta CurrentControl/Sparse e, quando o ColumnCount
1097:         *-- acima RECRIOU as Columns, o proprio controle da celula deixou de

*-- Linhas 1269 a 1277:
1269:     *
1270:     * So a linha AINDA SEM status aceita digitacao: a linha ja resolvida
1271:     * fica travada, e para trocar o status o usuario exclui a linha
1272:     * (cmd_4c_Excluir) e insere outra (cmd_4c_Inserir) - esse eh o desenho
1273:     * do legado, nao uma limitacao da migracao.
1274:     *
1275:     * Chamado pela celula (TextBoxStatusSts_4c.When, em
1276:     * classes\textboxgridlookup.PRG) ANTES de o usuario entrar na celula.
1277:     *

*-- Linhas 1496 a 1506:
1496:     * Metodo PUBLIC (regra #3/#46).
1497:     *==========================================================================
1498:     PROCEDURE StatusGradeLostFocus(par_oTxt)
1499:         IF EMPTY(NVL(par_oTxt.Value, "")) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1500:             IF THIS.cmd_4c_Sair.Visible AND THIS.cmd_4c_Sair.Enabled
1501:                 THIS.cmd_4c_Sair.SetFocus()
1502:             ENDIF
1503:         ENDIF
1504:     ENDPROC
1505: 
1506:     *==========================================================================

*-- Linhas 1519 a 1529:
1519:     * eh confiavel (regra #46).
1520:     *==========================================================================
1521:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1522:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
1523:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
1524:         BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
1525:     ENDPROC
1526: 
1527:     *==========================================================================
1528:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1529:     *

*-- Linhas 1826 a 1838:
1826:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1827:     *==========================================================================
1828:     PROCEDURE ModoEdicaoAtivo
1829:         IF !PEMSTATUS(THIS, "cmd_4c_Inserir", 5) OR !PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1830:             RETURN .F.
1831:         ENDIF
1832: 
1833:         RETURN (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible)
1834:     ENDPROC
1835: 
1836:     *==========================================================================
1837:     * FormParaBO - leva a LINHA CORRENTE da grade para as properties do BO
1838:     *

*-- Linhas 2055 a 2063:
2055:     * fChecaAcesso continuam Enabled = .F., senao esta reabilitacao
2056:     * atropelaria o controle de acesso que o Init do legado aplicou.
2057:     *
2058:     * cmd_4c_Sair fica SEMPRE habilitado: com TitleBar = 0 e ControlBox = .F.
2059:     * ele eh a unica saida da tela, e desabilita-lo prenderia o usuario.
2060:     *
2061:     * A Column2 nao aparece aqui: ela eh somente leitura em qualquer modo
2062:     * (legado: When = .f.) e quem a trava eh VincularGrade.
2063:     *

*-- Linhas 2090 a 2108:
2090:         ENDIF
2091: 
2092:         *-- Botoes de linha: so o que o controle de acesso deixou VISIVEL
2093:         IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
2094:             THIS.cmd_4c_Inserir.Enabled = loc_lHabilitar AND THIS.cmd_4c_Inserir.Visible
2095:         ENDIF
2096: 
2097:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2098:             THIS.cmd_4c_Excluir.Enabled = loc_lHabilitar AND THIS.cmd_4c_Excluir.Visible
2099:         ENDIF
2100: 
2101:         *-- Unica saida da tela - nunca desabilitada
2102:         IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
2103:             THIS.cmd_4c_Sair.Enabled = .T.
2104:         ENDIF
2105:     ENDPROC
2106: 
2107:     *==========================================================================
2108:     * AjustarBotoesPorModo - nome canonico do projeto para "reaplicar o estado


### BO (C:\4c\projeto\app\classes\SigOpStsBO.prg):
*==============================================================================
* SigOpStsBO.prg - Business Object para "Status por Operacoes" (SIGOPSTS)
*
* Origem legado : SigOpSts.SCX  (tasks\task808)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes)
* Tabela base   : SIGOPSTS | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que mantem a lista de STATUS permitidos para UMA operacao-pai
* (crSigCdOpe.Dopes). O legado recebe no Init "poForm" (o form pai),
* "pnDataSes" (DataSession do pai) e "pcEscolha" (INSERIR/ALTERAR/PROCURAR),
* troca para a DataSession do pai, DESABILITA os botoes do pai
* (mCtrlBotoes(.F.)) e popula um cursor local com:
*
*   Select a.*, b.Descs From SIGOPSTS a, SigStats b
*    Where a.Dopes = '<operacao-pai>' And a.Status = b.cods
*
* A grade (GradeSubN) tem 2 colunas:
*   Column1 -> status (TextBox EDITAVEL com lookup em SigStats.Cods;
*              When = Empty(LocalStats.status), ou seja so a linha NOVA,
*              ainda sem status, aceita digitacao)
*   Column2 -> Descs  (TextBox com When = .F. - somente leitura, a descricao
*              vem do lookup e nao eh digitada)
* Botoes: Inserir (acrescenta UMA linha em branco e foca a Column1),
* Excluir (Delete da linha corrente do cursor) e Encerrar (valida duplicidade,
* grava, reabilita os botoes do pai e fecha).
*
* GRAVACAO - eh REPLACE-ALL, nao linha-a-linha (regra do legado, transcrita)
* ---------------------------------------------------------------------------
* O cmdSair.Click do legado so grava quando (a) Inserir OU Excluir estao
* visiveis (ou seja, o pai esta em INSERIR/ALTERAR) E (b) houve inclusao ou
* exclusao na sessao do dialogo (lHouveIns Or lHouveExcl). Nessa condicao ele:
*   1) valida duplicidade - "Select status, sum(1) as TT From LocalStats
*      Group By 1" e, achando TT > 1, avisa
*      "Status <X> Digitado em Duplicidade!!!!" e ABORTA a gravacao
*      (Return .f. - o dialogo NAO fecha);
*   2) reconstroi o conjunto inteiro: Zap no cursor remoto + um Insert por
*      linha do cursor local, PULANDO (Loop) as linhas com status em branco,
*      sempre com Dopes = <operacao-pai> e CidChaves = fUniqueIds();
*   3) persiste dentro de transacao: Delete From SIGOPSTS Where Dopes =
*      '<operacao-pai>' -> UpDate do cursor -> Commit, com RollBack em
*      qualquer falha e a mensagem
*      "Erro na Gravacao dos Dados do Cadastro de Status.".
* Quem faz os passos 1 a 3 eh ESTE BO (ExisteStatusDuplicado / GravarStatus):
* sao regra de negocio e acesso a dados, nao UI. O form so decide QUANDO
* chamar (clique do Encerrar) e exibe o que o BO devolver.
*
* ESTADO DA SESSAO - DONO UNICO EH ESTE BO
* ----------------------------------------
* lHouveIns / lHouveExcl do legado viram this_lHouveInclusao /
* this_lHouveExclusao AQUI, e nao no form. Motivo: quem decide se grava eh a
* regra de gravacao acima, que mora neste BO; duas copias (uma no form, uma
* no BO) divergem em silencio e o Encerrar passa a ler a copia errada - ou
* grava sem alteracao nenhuma, ou nao grava o que o usuario mexeu, sem erro
* na tela. O form ESCREVE nessas duas properties nos mesmos pontos do legado
* (BtnInserirClick / BtnExcluirClick) e NAO declara copias proprias.
*
* CONTROLE DE ACESSO FICA NO FORM
* -------------------------------
* fChecaAcesso('SIGOPSTS','INSERIR') / fChecaAcesso('SIGOPSTS','EXCLUIR') do
* Init legado decidem Visible/Enabled de cmdInserir/cmdExcluir - isso eh UI e
* fica no form (que tambem combina com this_cEscolha e redimensiona o Shape1,
* igual ao legado). O BO guarda apenas o CONTEXTO recebido do pai
* (this_cOperacaoPai / this_cEscolha / this_nDataSessionPai).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos controles,
* no LEFT() dos comandos SQL e no dimensionamento do cursor da grade
* ---------------------------------------------------------------------------
*   SIGOPSTS.cidchaves  char(20)      NOT NULL  (PK - fUniqueIds())
*   SIGOPSTS.dopes      char(20)      NOT NULL  (FK SigCdOpe.dopes)
*   SIGOPSTS.status     char(1)       NOT NULL  (FK SigStats.cods)
*   SigStats.cods       char(1)       NOT NULL  (codigo do status - lookup)
*   SigStats.descs      char(20)      NOT NULL  (descricao do status)
*   SigStats.chkvisivel numeric(1,0)  NOT NULL
*   SigCdOpe.dopes      char(20)      NOT NULL  (PK e descricao ao mesmo
*                        tempo - SigCdOpe eh single-column, NUNCA usar
*                        descrs/Descs nessa tabela)
*
* As TRES colunas de SIGOPSTS sao NOT NULL e a tabela nao tem outras colunas,
* portanto o INSERT desta entidade cobre a tabela inteira (regra #22).
*==============================================================================

DEFINE CLASS SigOpStsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - uma linha de status da operacao (SIGOPSTS)
    *--------------------------------------------------------------------------
    this_cCidChaves        = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cDopes            = ""   && dopes     char(20) NOT NULL - operacao-pai (FK SigCdOpe.dopes)
    this_cStatus           = ""   && status    char(1)  NOT NULL - codigo do status (FK SigStats.cods)

    *--------------------------------------------------------------------------
    * DESCRICAO DO STATUS - SigStats.descs char(20)
    *
    * NAO pertence a SIGOPSTS: vem do join com SigStats (b.Descs do SELECT do
    * Init legado) e alimenta a Column2 da grade, que eh somente leitura
    * (When = .F.). Entra no cursor da grade e nas properties para a tela
    * poder exibir, mas NUNCA no INSERT/UPDATE de SIGOPSTS.
    *--------------------------------------------------------------------------
    this_cDescs            = ""   && descs     char(20) NOT NULL em SigStats (exibicao)

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    * Legado: Init(poForm, pnDataSes, pcEscolha) + crSigCdOpe.Dopes
    *--------------------------------------------------------------------------
    this_cOperacaoPai      = ""   && crSigCdOpe.Dopes - operacao corrente na Lista do pai (char(20))
    this_cEscolha          = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_nDataSessionPai   = 0    && pnDataSes do legado (DataSessionId do form pai)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO (dono unico - ver cabecalho)
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSTS
    *--------------------------------------------------------------------------
    this_lHouveInclusao    = .F.  && lhouveins  - o usuario acrescentou linha nesta sessao
    this_lHouveExclusao    = .F.  && lhouveexcl - o usuario excluiu linha nesta sessao

    *--------------------------------------------------------------------------
    * RESULTADO DA VALIDACAO DE DUPLICIDADE
    *
    * Guarda o codigo de status repetido encontrado no cursor da grade, para o
    * form montar a mensagem do legado "Status <X> Digitado em Duplicidade!!!!"
    * com o MESMO codigo que o legado mostraria (Alltrim(Totais.status)).
    *--------------------------------------------------------------------------
    this_cStatusDuplicado  = ""   && codigo do status repetido (vazio = sem duplicidade)

    *--------------------------------------------------------------------------
    * QUANTAS LINHAS O ULTIMO LOTE DE GRAVACAO INSERE
    *
    * MontarLoteGravacao a preenche; GravarStatus a le para saber quantas
    * chaves de loc_aChaves sao validas (VFP nao devolve dois valores, e o
    * array ja eh o parametro por referencia). Zero eh resultado LEGITIMO: o
    * usuario apagou todas as linhas e o lote fica so com o DELETE.
    *--------------------------------------------------------------------------
    this_nLinhasLote       = 0

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - o PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorStatus     = "cursor_4c_Status"   && LocalStats    - linhas de SIGOPSTS da operacao-pai + Descs (grade, READWRITE)
    this_cCursorBusca      = "cursor_4c_Busca"    && CrListaRemota - universo do lookup da Column1 (SigStats: Cods/Descs)
    this_cCursorTotais     = "cursor_4c_Totais"   && Totais        - agrupamento por status usado na checagem de duplicidade

    *--------------------------------------------------------------------------
    * ListarStatusOperacao (Fase 4) - popula this_cCursorStatus
    * (cursor_4c_Status) com o join de SIGOPSTS x SigStats da operacao-pai,
    * equivalente ao Sqlexecute(lcSql, 'LocalStats') do Init legado. Eh o
    * que alimenta a grade do form (FormSigOpSts.CarregarDados). Ver o
    * metodo abaixo para o detalhamento completo.
    *
    * ExisteStatusDuplicado / GravarStatus (Fase 7) - os passos 1 a 3 do
    * cmdSair.Click legado descritos no cabecalho do arquivo: a validacao de
    * duplicidade sobre o cursor da grade e o REPLACE-ALL transacional em
    * SIGOPSTS. Chamados por FormSigOpSts.BtnSairClick ("Encerrar"), que eh o
    * unico ponto de gravacao desta tela. Ver os metodos abaixo.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SIGOPSTS.cidchaves) e repoe o
    * estado inicial da sessao do dialogo, que no legado eh o estado do form
    * recem-criado: nenhuma inclusao e nenhuma exclusao ainda ocorridas, e
    * nenhuma duplicidade detectada.
    *
    * NAO chama fChecaAcesso aqui: a permissao eh decidida no form (ver
    * cabecalho) e a funcao real do Framework legado abre conexao SQL, o que
    * tornaria a simples criacao do BO dependente de banco.
    *
    * NAO passa a tabela para o DODEFAULT(): BusinessBase.Init(pcTabela) so
    * usa o parametro para instanciar um DataAccess, e esta entidade eh
    * gravada por comandos SQL proprios (replace-all em transacao), igual ao
    * legado.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SIGOPSTS"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nDataSessionPai  = 0
        THIS.this_lHouveInclusao   = .F.
        THIS.this_lHouveExclusao   = .F.
        THIS.this_cStatusDuplicado = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de status
    * (SIGOPSTS) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Status, populado pelo join com SigStats, ou qualquer outro
    * cursor/SELECT que inclua as mesmas colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_cStatus    = TratarNulo(status,    "C")

                *-- Descs vem do JOIN com SigStats (b.Descs do Init legado),
                *-- nao de SIGOPSTS - so existe quando o cursor foi montado
                *-- com o join (cursor_4c_Status); um cursor so com as
                *-- colunas de SIGOPSTS nao tem esse campo.
                IF TYPE(par_cAliasCursor + ".descs") != "U"
                    THIS.this_cDescs = TratarNulo(descs, "C")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarStatusOperacao - Popula cursor_4c_Status com as linhas de
    * SIGOPSTS da operacao-pai, equivalente ao legado:
    *
    *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
    *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
    *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
    *
    * O join com SigStats (igualdade a.Status = b.cods) so traz linhas com
    * status JA preenchido e valido - igual ao legado, cujas linhas em
    * branco inseridas pelo botao Inserir NAO vem desta consulta: elas sao
    * criadas DIRETO no cursor local (CmdInserirClick), nunca
    * reconsultadas aqui.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): a Column1 da grade (status) eh editavel nas linhas sem
    * status ainda (regra do legado When = Empty(status)) e os botoes
    * Inserir/Excluir inserem e apagam linha direto no cursor
    * local, igual ao legado (Insert Into LocalStats / Delete). Sem
    * READWRITE a celula nem entra em edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarStatusOperacao(par_cOperacaoPai)
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
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.status, b.descs" + ;
                       " FROM SIGOPSTS a" + ;
                       " INNER JOIN SigStats b ON a.status = b.cods" + ;
                       " WHERE a.dopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_StatusTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Status")
                    USE IN cursor_4c_Status
                ENDIF

                SELECT * FROM cursor_4c_StatusTmp INTO CURSOR cursor_4c_Status READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar os status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.ListarStatusOperacao:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteStatusDuplicado - 1a validacao do cmdSair.Click legado:
    *
    *   Select status,sum(1) as TT From LocalStats GROUP by 1 Into cursor Totais
    *   Select Totais
    *   Scan
    *       If TT > 1
    *           MessageBox('Status '+Alltrim(Totais.status)+ ;
    *                      ' Digitado em Duplicidade!!!!',0+16,'Atencao')
    *           Return .f.
    *       EndIf
    *   EndScan
    *
    * Guarda em this_cStatusDuplicado o codigo do PRIMEIRO status repetido: o
    * "Return .f." do legado esta DENTRO do Scan, portanto ele para no primeiro
    * grupo com TT > 1 e eh esse codigo que aparece na mensagem. Guardar a
    * lista inteira mudaria a mensagem da tela.
    *
    * TRANSCRICAO LITERAL (regra #17): o "GROUP by 1" agrupa pela coluna 1
    * (status) SEM excluir o status em branco, logo DUAS linhas novas ainda sem
    * status tambem contam como duplicidade - e a mensagem sai com o codigo
    * vazio ("Status  Digitado em Duplicidade!!!!"). Esse eh o comportamento da
    * tela e NAO se "conserta" aqui: eh ele que impede o usuario de acumular
    * varias linhas em branco na grade.
    *
    * Linha marcada para exclusao NAO entra: SET DELETED ON (config.prg) a
    * esconde do SELECT, igual ao legado.
    *
    * O alias corrente eh salvo e restaurado: este dialogo roda na DataSession
    * do form pai (DataSession = 1), onde deixar outro alias selecionado
    * atrapalharia quem chamou.
    *
    * Metodo PUBLIC (regra #51): quem o chama eh o Encerrar do form, de fora
    * desta classe - PROTECTED faria a chamada estourar em runtime.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ExisteStatusDuplicado()
        LOCAL loc_cAliasAnterior, loc_lDuplicado

        THIS.this_cStatusDuplicado = ""

        IF !USED(THIS.this_cCursorStatus)
            RETURN .F.
        ENDIF

        loc_lDuplicado     = .F.
        loc_cAliasAnterior = ALIAS()

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        SELECT status, SUM(1) AS tt ;
            FROM (THIS.this_cCursorStatus) ;
            GROUP BY 1 ;
            INTO CURSOR (THIS.this_cCursorTotais) READWRITE

        *-- Legado: Scan / If TT > 1 -> mensagem com ESTE status e para
        SELECT (THIS.this_cCursorTotais)
        SCAN
            IF tt > 1
                THIS.this_cStatusDuplicado = ALLTRIM(NVL(status, ""))
                loc_lDuplicado = .T.
                EXIT
            ENDIF
        ENDSCAN

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarLoteGravacao - monta o LOTE SQL unico do REPLACE-ALL de
    * GravarStatus (ver o comentario daquele metodo para o legado completo) e
    * devolve, em par_aChaves, as PKs que o lote insere; this_nLinhasLote diz
    * quantas posicoes do array sao validas.
    *
    * Transcreve duas coisas do legado, nesta ordem:
    *   1. "Delete From SIGOPSTS Where Dopes = '<op>'" - INCONDICIONAL, e
    *      ANTES dos inserts, para nao apagar o que acabou de entrar. Lote so
    *      com o DELETE eh resultado LEGITIMO: eh o usuario que apagou todas as
    *      linhas da grade.
    *   2. "Scan / Scatter Memvar / If Empty(m.status) -> Loop / Insert Into
    *      CrSIGOPSTS (Dopes,status,CidChaves)" - uma linha por status
    *      PREENCHIDO, descartando a linha em branco que o botao Inserir criou
    *      e o usuario nao completou (status eh char(1) NOT NULL - regra #22).
    *      Linha marcada para exclusao nao entra: SET DELETED ON a esconde do
    *      SCAN, igual ao legado.
    *
    * Envelope transacional em T-SQL, num SQLEXEC unico (nao em SQLEXEC
    * separados): a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
    * entao BEGIN/COMMIT avulsos so ANINHAM e o COMMIT nao efetiva. SAVE
    * TRANSACTION cobre o caso (normal) de ja haver transacao aberta, e o THROW
    * faz o erro chegar ao SQLEXEC, que devolve -1 e deixa CapturarErroSQL()
    * com a mensagem real.
    *
    * EXTRAIDO de GravarStatus de proposito: assim o TEXTO do lote pode ser
    * conferido sem banco (o SQL Server deste projeto eh inalcancavel da
    * maquina do pipeline), e a montagem - que eh a regra do legado - fica
    * separada da execucao/transacao, que eh infraestrutura.
    *
    * PROTECTED: eh peca interna de GravarStatus, nao se chama de fora (regra
    * #51); o harness de teste a alcanca por SUBCLASSE.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarLoteGravacao(par_cOperacaoPai, par_aChaves)
        LOCAL loc_cStmts, loc_cStatus, loc_cCidChaves, loc_cOperacaoPai, ;
              loc_cAliasAnterior

        THIS.this_nLinhasLote = 0
        loc_cStmts            = ""
        loc_cOperacaoPai      = LEFT(IIF(VARTYPE(par_cOperacaoPai) = "C", ;
                                         par_cOperacaoPai, ""), 20)

        IF USED(THIS.this_cCursorStatus)
            loc_cAliasAnterior = ALIAS()
            SELECT (THIS.this_cCursorStatus)

            SCAN
                loc_cStatus = LEFT(ALLTRIM(NVL(status, "")), 1)

                IF !EMPTY(loc_cStatus)
                    *-- cidchaves eh a PK Fortyus (regra #22): SEMPRE gerada
                    *-- com fUniqueIds(), nunca em branco - o legado tambem a
                    *-- regera a cada linha do Zap/Insert
                    loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)

                    THIS.this_nLinhasLote = THIS.this_nLinhasLote + 1
                    DIMENSION par_aChaves[THIS.this_nLinhasLote]
                    par_aChaves[THIS.this_nLinhasLote] = loc_cCidChaves

                    loc_cStmts = loc_cStmts + ;
                        "INSERT INTO SIGOPSTS (cidchaves, dopes, status) VALUES (" + ;
                        EscaparSQL(loc_cCidChaves) + ", " + ;
                        EscaparSQL(loc_cOperacaoPai) + ", " + ;
                        EscaparSQL(loc_cStatus) + "); "
                ENDIF
            ENDSCAN

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN "SET NOCOUNT ON; " + ;
            "DECLARE @nivel int = @@TRANCOUNT; " + ;
            "IF @nivel = 0 BEGIN TRANSACTION " + ;
            "ELSE SAVE TRANSACTION Sts4c; " + ;
            "BEGIN TRY " + ;
            "DELETE FROM SIGOPSTS WHERE dopes = " + ;
            EscaparSQL(loc_cOperacaoPai) + "; " + ;
            loc_cStmts + ;
            "IF @nivel = 0 COMMIT TRANSACTION; " + ;
            "END TRY " + ;
            "BEGIN CATCH " + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Sts4c; END; " + ;
            "THROW; " + ;
            "END CATCH"
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarStatus - persiste a lista de status da operacao-pai. Equivale ao
    * bloco de gravacao do cmdSair.Click legado, que eh um REPLACE-ALL:
    *
    *   Select CrSIGOPSTS
    *   Zap
    *   Select LocalStats
    *   Scan
    *       Scatter Memvar
    *       If Empty(m.status)
    *           Loop
    *       Endif
    *       Insert Into CrSIGOPSTS (Dopes,status,CidChaves) Values ;
    *           (CrSigCdOpe.Dopes,m.status,fUniqueIds())
    *   EndScan
    *   m.lnErro1 = ThisForm.ParentForm.poDatamgr.pnIdConn
    *   If m.lnErro1>0 : lcDelete = [Delete From SIGOPSTS Where Dopes = '<op>']
    *                    m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSIGOPSTS'),1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
    *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
    *   If Not m.lnErro1>0 : MessageBox('Erro na Gravacao dos Dados do
    *                                   Cadastro de Status.',48)
    *
    * O "Zap + Scan + Insert" enche a view remota com o conjunto NOVO INTEIRO
    * (toda linha fica nova, logo o UpDate manda INSERT) e o Delete apaga o
    * conjunto ANTIGO: o efeito liquido eh SUBSTITUIR todos os status da
    * operacao. Por isso o DELETE eh INCONDICIONAL e roda mesmo quando nao
    * sobrou nenhuma linha com status preenchido - o usuario que apagou todas
    * as linhas da grade quer a operacao sem status nenhum, e um "nada a
    * gravar" ali engoliria essa intencao em silencio.
    *
    * "If Empty(m.status) / Loop" eh o descarte da linha em branco: a linha que
    * o botao Inserir criou e o usuario nao preencheu NAO vai para o banco
    * (status eh char(1) NOT NULL - regra #22).
    *
    * ATOMICIDADE: o legado faz Delete + N Inserts numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    * Mesmo lote canonico de SigOpNchBO.GravarNumeracao.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *
    * As duas flags de sessao sao ZERADAS no sucesso: elas sao o guard que faz
    * o Encerrar gravar UMA vez ("If (lHouveExcl Or lHouveIns)" do legado). No
    * legado o dialogo fecha logo apos gravar e nao existe um segundo Encerrar;
    * zerar aqui garante o mesmo efeito - um segundo Encerrar com a grade
    * intacta nao repetiria Delete + Insert (que regravaria o MESMO conjunto
    * com cidchaves novas e poluiria a auditoria).
    *
    * A auditoria (LogAuditoria, exigencia do sistema novo - o legado nao a
    * tem) roda DEPOIS do commit, uma linha por status efetivamente gravado, e
    * nunca dentro do lote: o lote eh montado para ser atomico sobre SIGOPSTS e
    * a auditoria nao pode poder derruba-lo.
    *
    * Metodo PUBLIC (regra #51): chamado pelo Encerrar do form.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION GravarStatus(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cAliasAnterior, loc_nLinhas, loc_cLote, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_lSucesso, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        loc_lManual  = .F.
        loc_nLinhas  = 0
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C" AND ;
                               !EMPTY(par_cOperacaoPai), par_cOperacaoPai, ;
                               THIS.this_cOperacaoPai)

        *-- Sem operacao-pai o DELETE apagaria o conjunto de OUTRA operacao (a
        *-- de codigo em branco): recusar eh o unico caminho seguro
        IF EMPTY(loc_cOperacaoPai)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informada."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        TRY
            loc_lManual        = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            loc_cAliasAnterior = ALIAS()

            *-- Monta o lote e devolve em loc_aChaves as PKs que ele insere
            loc_cLote   = THIS.MontarLoteGravacao(loc_cOperacaoPai, @loc_aChaves)
            loc_nLinhas = THIS.this_nLinhasLote

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

            IF loc_nResultado < 0
                loc_cErro = CapturarErroSQL()

                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF

                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                    "o dos Dados do Cadastro de Status." + CHR(13) + loc_cErro
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- Commit do legado (.poDataMgr.Commit())
                loc_lSucesso = .T.

                IF loc_lManual
                    IF SQLCOMMIT(gnConnHandle) < 1
                        = SQLROLLBACK(gnConnHandle)
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                            CHR(227) + "o dos Dados do Cadastro de Status." + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                    *-- O guard do Encerrar volta ao zero: o conjunto no banco
                    *-- passou a ser exatamente o da grade
                    THIS.this_lHouveInclusao = .F.
                    THIS.this_lHouveExclusao = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro em SigOpStsBO.GravarStatus:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoriaLote - grava em LogAuditoria uma linha por status
    * efetivamente gravado pelo lote de GravarStatus.
    *
    * RegistrarAuditoria do BusinessBase le a chave por ObterChavePrimaria(),
    * que devolve this_cCidChaves - por isso a property eh posicionada em cada
    * volta do laco e restaurada no fim (o chamador nao pode perceber que ela
    * foi usada como variavel de laco).
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SIGOPSTS e a auditoria nao pode poder derruba-lo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cCidChavesAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cCidChavesAnterior = THIS.this_cCidChaves

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cCidChaves = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("INSERT")
            ENDFOR

            THIS.this_cCidChaves = loc_cCidChavesAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de status (SIGOPSTS) no banco.
    * Equivalente ao trecho do legado cmdSair.Click que, dentro da transacao
    * de GravarStatus, faz "Insert Into SIGOPSTS (Dopes, Status, CidChaves)
    * Values (<operacao-pai>, <status>, fUniqueIds())" para cada linha do
    * cursor local com status preenchido.
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

            loc_cSQL = "INSERT INTO SIGOPSTS (cidchaves, dopes, status)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSts")
                USE IN cursor_4c_InsSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de status (SIGOPSTS) ja existente.
    * As tres colunas da entidade sao NOT NULL (regra #22) - o UPDATE regrava
    * dopes e status pela chave cidchaves.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGOPSTS SET" + ;
                       " dopes  = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " status = " + EscaparSQL(THIS.this_cStatus) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSts")
                USE IN cursor_4c_UpdSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

