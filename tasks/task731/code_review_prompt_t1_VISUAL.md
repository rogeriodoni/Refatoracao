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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2133 linhas total):

*-- Linhas 34 a 58:
34: *   - ConfigurarGradeHistorico(): grd_4c_Dados, a Gradevenc do legado, com as
35: *     duas colunas Historico/Usuario transcritas do dump. O cursor vazio eh
36: *     criado ANTES do bind, pelo BO, que eh a fonte unica da estrutura
37: *   - ConfigurarBotoesAcao(): cmd_4c_Confirmar ("altera") e cmd_4c_Cancelar
38: *     ("sair"), os dois CommandButton soltos do legado
39: *   - CarregarLista(): funil UNICO de carga e repinte da grade, equivalente
40: *     ao bloco AddCursor + Requery + RecordSource + Refresh do Init legado
41: *   - no SigOpEntBO, as duas pecas de dados que faltavam para a grade:
42: *     CriarCursorHistorico() (CREATE CURSOR, fonte unica da estrutura) e
43: *     CarregarHistorico() (a consulta de SigOpMvv por EmpDopNcs)
44: *
45: * FASE 5/8 - CAMPOS DE DADOS E ORDEM DE TABULACAO. Entrega:
46: *   - ConfigurarCamposPrazo(): os QUATRO controles de dados que faltavam, que
47: *     sao TODOS os que o SCX tem fora da grade - lbl_4c_PrazoAtual (Say1),
48: *     txt_4c_PrazoAtual (getAtual), lbl_4c_PrazoNovo (Say2) e txt_4c_PrazoNovo
49: *     (getNova). O "Procedure When / Return .f." do getAtual legado vira
50: *     ReadOnly = .T. + TabStop = .F.
51: *   - SincronizarCamposPrazo(): funil UNICO de valores entre o BO e os dois
52: *     campos, reproduzindo o par que o legado repete no Init e no altera.Valid
53: *     (.getAtual.Value = .pPrz / .getNova.Value = Ctod(''))
54: *   - AplicarBloqueioAlteracao(): a metade "Enabled" do If ThisForm.Bloquear
55: *     do Init legado (getNova e Confirmar desligados quando pBlqAlt = .T.)
56: *   - Activate(): a outra metade daquele IF - o SetFocus inicial, que nesta
57: *     arquitetura nao pode ficar no InicializarForm porque ele roda DENTRO do
58: *     CREATEOBJECT, antes de qualquer Show()

*-- Linhas 549 a 605:
549:     *
550:     * As duas Caption recebem THIS.Caption, como o legado faz nas duas
551:     * primeiras linhas do seu Init
552:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
553:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
554:     *==========================================================================
555:     PROTECTED PROCEDURE ConfigurarCabecalho()
556:         LOCAL loc_oCnt
557: 
558:         THIS.AddObject("cnt_4c_Sombra", "Container")
559:         loc_oCnt = THIS.cnt_4c_Sombra
560:         WITH loc_oCnt
561:             .Top         = 0
562:             .Left        = 0
563:             .Width       = THIS.Width
564:             .Height      = 80
565:             .BorderWidth = 0
566:             .BackColor   = RGB(100, 100, 100)
567:             .Visible     = .T.
568:         ENDWITH
569: 
570:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
571:         WITH loc_oCnt.lbl_4c_Sombra
572:             .FontBold      = .T.
573:             .FontName      = "Tahoma"
574:             .FontSize      = 18
575:             .FontUnderline = .F.
576:             .WordWrap      = .T.
577:             .Alignment     = 0
578:             .BackStyle     = 0
579:             .AutoSize      = .F.
580:             .Caption       = THIS.Caption
581:             .Left          = 10
582:             .Top           = 18
583:             .Width         = THIS.Width - 20
584:             .Height        = 40
585:             .ForeColor     = RGB(0, 0, 0)
586:             .Visible       = .T.
587:         ENDWITH
588: 
589:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
590:         WITH loc_oCnt.lbl_4c_Titulo
591:             .FontBold    = .T.
592:             .FontName    = "Tahoma"
593:             .FontSize    = 18
594:             .WordWrap    = .T.
595:             .Alignment   = 0
596:             .BackStyle   = 0
597:             .AutoSize    = .F.
598:             .Caption     = THIS.Caption
599:             .Left        = 10
600:             .Top         = 17
601:             .Width       = THIS.Width - 20
602:             .Height      = 46
603:             .ForeColor   = RGB(255, 255, 255)
604:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
605:             .Visible     = .T.

*-- Linhas 676 a 685:
676:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
677: 
678:         WITH THIS.grd_4c_Dados
679:             .Top                = 99
680:             .Left               = 105
681:             .Width              = 173
682:             .Height             = 184
683:             .FontName           = "Tahoma"
684:             .FontSize           = 8
685:             .AllowHeaderSizing  = .F.

*-- Linhas 698 a 706:
698:             .Column1.Movable           = .F.
699:             .Column1.Resizable         = .F.
700:             .Column1.ReadOnly          = .T.
701:             .Column1.Header1.Caption   = "Hist" + CHR(243) + "rico"
702:             .Column1.Header1.FontName  = "Tahoma"
703:             .Column1.Header1.FontSize  = 8
704:             .Column1.Header1.Alignment = 2
705:             .Column1.Text1.BorderStyle = 0
706:             .Column1.Text1.Margin      = 0

*-- Linhas 714 a 722:
714:             .Column2.Movable           = .F.
715:             .Column2.Resizable         = .F.
716:             .Column2.ReadOnly          = .T.
717:             .Column2.Header1.Caption   = "Usu" + CHR(225) + "rio"
718:             .Column2.Header1.FontName  = "Tahoma"
719:             .Column2.Header1.FontSize  = 8
720:             .Column2.Header1.Alignment = 2
721:             .Column2.Text1.BorderStyle = 0
722:             .Column2.Text1.Margin      = 0

*-- Linhas 730 a 739:
730: 
731:     *==========================================================================
732:     * ConfigurarBotoesAcao - os DOIS CommandButton soltos do legado:
733:     *   altera (Caption "\<Confirmar", Left 350) -> cmd_4c_Confirmar
734:     *   sair   (Caption "Cancelar",    Left 425) -> cmd_4c_Cancelar
735:     *
736:     * Nomes pela ACAO, nao pelo Name do objeto legado: "altera" nao diz que
737:     * ali esta a UNICA via de gravacao da tela (o Valid dele INSERE o
738:     * historico em SigOpMvv e atualiza SigMvCab.PrazoEnts), e o PILAR 3 exige
739:     * nomes diferentes do legado. O mapeamento da task foi atualizado no mesmo

*-- Linhas 774 a 788:
774:         LOCAL loc_lBloqueado
775:         loc_lBloqueado = THIS.this_oBusinessObject.this_lBloquear
776: 
777:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
778:         WITH THIS.cmd_4c_Confirmar
779:             .Top             = 3
780:             .Left            = 350
781:             .Width           = 75
782:             .Height          = 75
783:             .Caption         = "\<Confirmar"
784:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
785:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
786:             .FontBold        = .T.
787:             .FontItalic      = .T.
788:             .FontName        = "Comic Sans MS"

*-- Linhas 799 a 813:
799:             .Visible         = .T.
800:         ENDWITH
801: 
802:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
803:         WITH THIS.cmd_4c_Cancelar
804:             .Top             = 3
805:             .Left            = 425
806:             .Width           = 75
807:             .Height          = 75
808:             .Caption         = "Encerrar"
809:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
810:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
811:             .Cancel          = .T.
812:             .FontBold        = .T.
813:             .FontItalic      = .T.

*-- Linhas 829 a 839:
829:     * ConfigurarCamposPrazo - Os QUATRO controles de dados que restavam do SCX:
830:     * as duas datas e seus rotulos, todos filhos DIRETOS do Form (layout FLAT)
831:     *
832:     *   Say1     "Data Atual"  Left 315 Top 110  ->  lbl_4c_PrazoAtual
833:     *   getAtual (fweditdata)  Left 315 Top 124  ->  txt_4c_PrazoAtual
834:     *   Say2     "Nova Data"   Left 315 Top 161  ->  lbl_4c_PrazoNovo
835:     *   getNova  (fweditdata)  Left 315 Top 175  ->  txt_4c_PrazoNovo
836:     *
837:     * Nomes pelo PAPEL de negocio, batendo com as propriedades do BO
838:     * (this_dPrazoAtual / this_dPrazoNovo), e nao pelo Name legado nem pelo
839:     * numero do Say - o mapeamento da task foi atualizado no mesmo passo,

*-- Linhas 890 a 909:
890:     PROTECTED PROCEDURE ConfigurarCamposPrazo()
891: 
892:         *-- Say1 "Data Atual" -----------------------------------------------
893:         THIS.AddObject("lbl_4c_PrazoAtual", "Label")
894:         WITH THIS.lbl_4c_PrazoAtual
895:             .FontBold  = .T.
896:             .FontName  = "Tahoma"
897:             .FontSize  = 8
898:             .AutoSize  = .F.
899:             .Alignment = 0
900:             .BackStyle = 0
901:             .WordWrap  = .F.
902:             .Caption   = "Data Atual"
903:             .Left      = 315
904:             .Top       = 110
905:             .Width     = 70
906:             .Height    = 15
907:             .ForeColor = RGB(90, 90, 90)
908:             .Visible   = .T.
909:         ENDWITH

*-- Linhas 916 a 946:
916:             .Alignment = 3
917:             .Themes    = .F.
918:             .Value     = {}
919:             .Left      = 315
920:             .Top       = 124
921:             .Width     = 80
922:             .Height    = 23
923:             .ForeColor = RGB(0, 0, 0)
924:             .ReadOnly  = .T.
925:             .TabStop   = .F.
926:             .Visible   = .T.
927:         ENDWITH
928: 
929:         *-- Say2 "Nova Data" -----------------------------------------------
930:         THIS.AddObject("lbl_4c_PrazoNovo", "Label")
931:         WITH THIS.lbl_4c_PrazoNovo
932:             .FontBold  = .T.
933:             .FontName  = "Tahoma"
934:             .FontSize  = 8
935:             .AutoSize  = .F.
936:             .Alignment = 0
937:             .BackStyle = 0
938:             .WordWrap  = .F.
939:             .Caption   = "Nova Data"
940:             .Left      = 315
941:             .Top       = 161
942:             .Width     = 70
943:             .Height    = 15
944:             .ForeColor = RGB(90, 90, 90)
945:             .Visible   = .T.
946:         ENDWITH

*-- Linhas 953 a 987:
953:             .Alignment = 3
954:             .Themes    = .F.
955:             .Value     = {}
956:             .Left      = 315
957:             .Top       = 175
958:             .Width     = 80
959:             .Height    = 23
960:             .ForeColor = RGB(0, 0, 0)
961:             .Visible   = .T.
962:         ENDWITH
963: 
964:         *-- Valores iniciais - a primeira das duas pontas do Init legado:
965:         *--   .getAtual.Value = .pPrz  /  .getNova.Value = Ctod('')
966:         THIS.SincronizarCamposPrazo()
967: 
968:         *-- A outra ponta (o par Enabled do "If ThisForm.Bloquear") NAO pode
969:         *-- ser aplicada aqui: ela toca tambem o Confirmar, que so nasce em
970:         *-- ConfigurarBotoesAcao(), chamado DEPOIS deste metodo. Medido no
971:         *-- VFP9: chamando AplicarBloqueioAlteracao() daqui, o InicializarForm
972:         *-- estourava "Unknown member CMD_4C_CONFIRMAR" dentro do seu TRY, o
973:         *-- CREATEOBJECT devolvia .F. e a tela simplesmente nao abria. Por isso
974:         *-- ela roda no InicializarForm, depois de TODOS os AddObject.
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * SincronizarCamposPrazo - Funil UNICO de valores entre o BO e os dois
979:     * campos de data
980:     *
981:     * Reproduz as duas pontas em que o legado mexe nesses campos:
982:     *   Init         -> .getAtual.Value = .pPrz
983:     *                   .getNova.Value  = Ctod('')
984:     *   altera.Valid -> ThisForm.getAtual.Value = ThisForm.pPrz   (apos gravar)
985:     *                   ThisForm.getNova.Value  = Ctod('')
986:     *                   ThisForm.getAtual.Refresh / .getNova.Refresh
987:     *

*-- Linhas 1464 a 1472:
1464:     * Chamado pelo InicializarForm DEPOIS de ConfigurarCamposPrazo E de
1465:     * ConfigurarBotoesAcao, nunca de dentro de um deles: os dois controles que
1466:     * ele toca nascem em metodos diferentes, e chamado cedo demais o metodo
1467:     * estoura "Unknown member CMD_4C_CONFIRMAR" (medido no VFP9).
1468:     *
1469:     * PUBLIC de proposito, pelo mesmo motivo de SincronizarCamposPrazo.
1470:     *==========================================================================
1471:     PROCEDURE AplicarBloqueioAlteracao()
1472:         *-- O bloqueio eh o INVERSO da habilitacao: pBlqAlt = .T. significa

*-- Linhas 1489 a 1510:
1489:     * Os controles tocados sao os DOIS que o legado desliga, e sao todos os de
1490:     * entrada que a tela tem:
1491:     *   txt_4c_PrazoNovo (getNova)  - o unico campo digitavel
1492:     *   cmd_4c_Confirmar (altera)   - a unica acao que grava
1493:     *
1494:     * NAO entram, e nao eh omissao:
1495:     *   txt_4c_PrazoAtual - nasce ReadOnly = .T. + TabStop = .F. (o
1496:     *                       "Procedure When / Return .f." do legado). Habilitar
1497:     *                       ou desabilitar nao muda nada, e um Enabled = .F.
1498:     *                       deixaria o valor CINZA, divergindo do legado, que
1499:     *                       mostra a data vigente legivel nos dois modos.
1500:     *   grd_4c_Dados      - o legado faz o CONTRARIO com a grade: no caminho
1501:     *                       bloqueado eh justamente nela que ele poe o foco
1502:     *                       (".Gradevenc.SetFocus"), porque consultar o
1503:     *                       historico eh o que resta ao usuario. Desliga-la
1504:     *                       seria inverter a intencao do legado.
1505:     *   cmd_4c_Cancelar   - "sair" tem Cancel = .T. e eh a unica via de saida
1506:     *                       da tela, que nao tem barra de titulo
1507:     *                       (TitleBar = 0 / ControlBox = .F.). Desabilita-lo
1508:     *                       trancaria o usuario na janela.
1509:     *
1510:     * PUBLIC (sem PROTECTED): ao contrario de LimparCampos/BOParaForm/

*-- Linhas 1522 a 1530:
1522:         loc_lHabilitar = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)
1523: 
1524:         THIS.txt_4c_PrazoNovo.Enabled = loc_lHabilitar
1525:         THIS.cmd_4c_Confirmar.Enabled = loc_lHabilitar
1526:     ENDPROC
1527: 
1528:     *==========================================================================
1529:     * AplicarOrdemTabulacao - Transcreve os TabIndex declarados no dump
1530:     *

*-- Linhas 1547 a 1560:
1547:     *==========================================================================
1548:     PROTECTED PROCEDURE AplicarOrdemTabulacao()
1549:         THIS.txt_4c_PrazoNovo.TabIndex  = 1    && getNova
1550:         THIS.cmd_4c_Confirmar.TabIndex  = 2    && altera
1551:         THIS.grd_4c_Dados.TabIndex      = 3    && Gradevenc
1552:         THIS.lbl_4c_PrazoAtual.TabIndex = 4    && Say1
1553:         THIS.txt_4c_PrazoAtual.TabIndex = 5    && getAtual
1554:         THIS.lbl_4c_PrazoNovo.TabIndex  = 6    && Say2
1555:         THIS.cmd_4c_Cancelar.TabIndex   = 7    && sair
1556:     ENDPROC
1557: 
1558:     *==========================================================================
1559:     * CarregarLista - Funil UNICO de carga e repinte da grade do historico.
1560:     *

*-- Linhas 1705 a 1714:
1705:     * PROTECTED falha em SILENCIO (regra #3).
1706:     *==========================================================================
1707:     PROTECTED PROCEDURE VincularEventos()
1708:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1709:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1710:         BINDEVENT(THIS.txt_4c_PrazoNovo, "LostFocus", THIS, "PrazoNovoLostFocus")
1711:     ENDPROC
1712: 
1713:     *==========================================================================
1714:     * BtnConfirmarClick - porta de SIGOPENT.altera.Valid (linhas 545-599 do

*-- Linhas 1790 a 1798:
1790:         *-- Com pBlqAlt = .T. o legado desliga o botao (.altera.Enabled = .f.)
1791:         *-- e nao ha como acionar a gravacao. O teste explicito existe porque
1792:         *-- o harness chama este metodo direto, sem passar pelo controle.
1793:         IF !THIS.cmd_4c_Confirmar.Enabled
1794:             RETURN
1795:         ENDIF
1796: 
1797:         THIS.this_lConfirmandoPrazo = .T.
1798: 


### BO (C:\4c\projeto\app\classes\SigOpEntBO.prg):
*==============================================================================
* SigOpEntBO.prg
*
* Business Object para SigOpEnt - "Alteracao de Data de Entrega", dialogo
* filho aberto pela tela de movimentacao (form OPERACIONAL, WindowType = 1).
*
* Tabela principal: SigOpMvv - historico das datas de entrega de UMA
* movimentacao. Cada troca de prazo grava em SigOpMvv a data que esta SAINDO
* (coluna vencs) e atualiza SigMvCab.PrazoEnts com a data nova.
*
* Origem legado: tasks\task731\SigOpEnt_form_codigo_fonte.txt
*   SIGOPENT.Init          - recebe pEmp, pDop, pNum, pPrz, pFor, pMin, pDat,
*                            pBlqAlt, pMax do form pai e carrega 3 cursores
*                            (crSigOpMvv, crSigCdOpe, crSigOpCdd)
*   SIGOPENT.getNova.Valid - valida a data digitada contra pDat / pMin / pMax
*   SIGOPENT.altera.Valid  - grava o historico e atualiza SigMvCab
*
* Esta tela NAO eh um cadastro CRUD: nao tem lista com Incluir/Alterar/
* Excluir. O unico caminho de gravacao eh o botao Confirmar, que INSERE uma
* linha de historico em SigOpMvv e faz o UPDATE de SigMvCab.PrazoEnts.
*==============================================================================

DEFINE CLASS SigOpEntBO AS BusinessBase

    *--------------------------------------------------------------------------
    * COLUNAS DE SigOpMvv - grafia EXATA do docs\schema.sql (PILAR 2)
    *
    *   cidchaves  char(20)      NOT NULL   PK (sigopmvv_cidchaves)
    *   emps       char(3)       NOT NULL
    *   dopcs      char(20)      NOT NULL
    *   notitulos  numeric(6,0)  NOT NULL
    *   empdopncs  char(29)      NOT NULL
    *   vencs      datetime      NULL
    *   datas      datetime      NULL
    *   usuars     char(10)      NOT NULL
    *
    * As 6 colunas NOT NULL tem propriedade propria aqui (regra #22): a PK
    * cidchaves vem de fUniqueIds() - NUNCA string vazia, senao a segunda
    * linha de historico colide no indice unico - e usuars vem de
    * gc_4c_UsuarioLogado. O legado grava exatamente estas 8 colunas
    * (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs, cIdChaves, Usuars, Datas),
    * ou seja a lista do schema e a do legado coincidem.
    *--------------------------------------------------------------------------
    this_cCidChaves = ""            && cidchaves  char(20)     - PK, fUniqueIds()
    this_cEmps = ""                 && emps       char(3)      - empresa (pEmp)
    this_cDopcs = ""                && dopcs      char(20)     - documento/operacao (pDop)
    this_nNoTitulos = 0             && notitulos  numeric(6,0) - numero da operacao (pNum)
    this_cEmpDopNcs = ""            && empdopncs  char(29)     - chave posicional
    this_dVencs = {}                && vencs      datetime     - data de entrega ARQUIVADA
    this_dDatas = {}                && datas      datetime     - data/hora do registro
    this_cUsuars = ""               && usuars     char(10)     - usuario que alterou

    *--------------------------------------------------------------------------
    * CHAVE POSICIONAL empdopncs char(29) - regra #42
    *
    * O legado monta a chave concatenando SEM ALLTRIM:
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * As larguras vem das COLUNAS: emps char(3) + dopcs char(20) + STR(,6)
    * = 29 = empdopncs char(29). O padding FAZ PARTE da chave: encurtar
    * qualquer parte com ALLTRIM devolve ZERO linha em silencio. A montagem
    * usa PADR explicito sobre as larguras do schema, porque as propriedades
    * deste BO recebem os valores do form pai ja com ALLTRIM.
    *
    * A MESMA chave de 29 caracteres eh o filtro do UPDATE de SigMvCab
    * (Where EmpDopNums = ...), por isso uma unica propriedade atende aos
    * dois usos.
    *--------------------------------------------------------------------------
    this_nLarguraEmps = 3           && largura de SigOpMvv.emps  no schema
    this_nLarguraDopcs = 20         && largura de SigOpMvv.dopcs no schema
    this_nLarguraNoTitulos = 6      && digitos de STR(notitulos, 6) na chave

    *--------------------------------------------------------------------------
    * PARAMETROS RECEBIDOS DO FORM PAI
    *
    * O legado guarda estes valores em propriedades do proprio form (pEmp,
    * pDop, pNum, pPrz, pMin, pMax, pDat, Bloquear - ver RESERVED3 ClassInfo
    * do dump). Aqui eles vivem no BO, porque sao o insumo da validacao e da
    * gravacao. pFor (a referencia ao form pai) NAO vem para o BO: continua
    * sendo assunto do Form.
    *
    * As datas sao declaradas como DATE ({}) porque chegam de TextBox e de
    * propriedade do form pai, nao de coluna datetime do SQL Server - por
    * isso toda normalizacao usa ConverterParaData(), nunca TTOD(), que com
    * DATE dispara erro 11 em runtime (regra #16).
    *--------------------------------------------------------------------------
    this_dPrazoAtual = {}           && pPrz    - data de entrega vigente (SigMvCab.PrazoEnts)
    this_dPrazoNovo = {}            && valor digitado em getNova
    this_dDataMovimento = {}        && pDat    - data da movimentacao
    this_nPrazoMinimo = 0           && pMin    - dias minimos contados de pDat
    this_nPrazoMaximo = 0           && pMax    - dias maximos contados de pDat
    this_lBloquear = .F.            && pBlqAlt - .T. bloqueia a alteracao (so consulta)

    *--------------------------------------------------------------------------
    * CONTEXTO DO FORM PAI QUE DECIDE O UPDATE DE SigMvCab
    *
    * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR').
    * O UPDATE de SigMvCab.PrazoEnts SO acontece quando o pai NAO esta em
    * modo ALTERAR - nesse modo o proprio pai grava o cabecalho. O historico
    * em SigOpMvv, ao contrario, eh gravado nos dois casos.
    *--------------------------------------------------------------------------
    this_cEscolhaPai = ""           && ParentForm.pcEscolha ("INSERIR"/"ALTERAR"/...)
    this_cModoNaoAtualizaCabecalho = "ALTERAR"   && valor que SUPRIME o UPDATE de SigMvCab

    *--------------------------------------------------------------------------
    * CONFIGURACAO LIDA DOS CURSORES DE APOIO (CursorQuery do Init legado)
    *
    * Ambas sao numeric(1,0) NOT NULL no schema, portanto chegam ao VFP como
    * NUMERICO - propriedade this_n*, comparada com numero.
    *
    *   SigCdOpe.dtentrs  - regra de exigencia do prazo de entrega. O legado
    *                       so exige/valida a data quando InList(DtEntrs, 1, 4, 6).
    *   SigOpCdd.chkuteis - indica se a contagem de dias considera dias uteis.
    *--------------------------------------------------------------------------
    this_nDtEntrs = 0               && SigCdOpe.dtentrs  numeric(1,0)
    this_nChkUteis = 0              && SigOpCdd.chkuteis numeric(1,0)

    *--------------------------------------------------------------------------
    * ALIASES DOS CURSORES
    *
    * Equivalencia com o legado:
    *   crSigOpMvv  -> cursor_4c_Dados      (alimenta a grade Gradevenc)
    *   crSigCdOpe  -> cursor_4c_Operacao   (CursorQuery SigCdOpe / Dopes / DtEntrs)
    *   crSigOpCdd  -> cursor_4c_ConfigDoc  (CursorQuery SigOpCdd / Dopes / chkUteis)
    *--------------------------------------------------------------------------
    this_cCursorHistorico = "cursor_4c_Dados"
    this_cCursorOperacao = "cursor_4c_Operacao"
    this_cCursorConfigDoc = "cursor_4c_ConfigDoc"

    *--------------------------------------------------------------------------
    * LIBERACAO POR SENHA (Do Form SigOpSen With 'LIBPRZENT', ...)
    *
    * Quando a data digitada fica fora da faixa pMin..pMax, o legado pede
    * autorizacao pelo programa LIBPRZENT e, autorizado, registra a liberacao
    * com fGravarLog('T', pDop, 'LIBPRZENT', <transacao>, <usuario liberador>).
    * O codigo do programa eh constante no legado e fica aqui para o texto do
    * log e a chamada da autorizacao usarem a MESMA grafia.
    *--------------------------------------------------------------------------
    this_cProgramaLiberacao = "LIBPRZENT"
    this_cTituloLiberacao = "Libera Prazo de Entrega"
    this_cUsuarioLiberacao = ""     && usuario que autorizou (retorno do SigOpSen)
    this_lPrazoLiberado = .F.       && .T. quando a autorizacao foi concedida

    *--------------------------------------------------------------------------
    * ESTADO DA ULTIMA GRAVACAO
    *
    * O legado controla commit/rollback com a flag local llOks e avisa o pai
    * do sucesso com thisform.parentform.validOk = .t. - o Form le esta
    * propriedade para decidir se repassa o novo prazo ao pai.
    *--------------------------------------------------------------------------
    this_lGravouPrazo = .F.         && .T. quando historico e cabecalho gravaram

    *====================================================================
    * Init - Inicializa Business Object
    *
    * this_cCampoChave usa a grafia do schema (cidchaves), que eh a PK
    * declarada em CONSTRAINT [sigopmvv_cidchaves].
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigOpMvv"
        THIS.this_cCampoChave = "cidchaves"

        *-- usuars eh NOT NULL char(10): nasce com o usuario logado, o mesmo
        *-- Usuar global que o INSERT do legado usa. O guard de TYPE existe
        *-- porque probe/teste headless pode instanciar o BO antes do startup
        *-- ter definido a variavel publica.
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
        ELSE
            THIS.this_cUsuars = ""
        ENDIF

        *-- Nenhuma gravacao nem liberacao aconteceu nesta instancia ainda.
        THIS.this_lGravouPrazo = .F.
        THIS.this_lPrazoLiberado = .F.
        THIS.this_cUsuarioLiberacao = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - PK da linha de historico gravada por Inserir()
    *
    * Fica PROTECTED pela heranca de BusinessBase (regra #51 do CLAUDE.md:
    * PROTECTED declarado em QUALQUER classe da cadeia prevalece) - quem
    * usa isto eh RegistrarAuditoria(), chamado de dentro do proprio BO.
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega uma linha de SigOpMvv (cursor_4c_Dados,
    * equivalente ao crSigOpMvv do legado) para as propriedades do BO.
    *
    * Esta tela NUNCA altera uma linha de historico existente - cada
    * confirmacao sempre INSERE uma linha nova (ver cabecalho da classe).
    * Este metodo serve para inspecionar uma linha ja gravada (detalhe da
    * grade Gradevenc), nao para reabrir edicao; this_lNovoRegistro = .F.
    * segue o padrao canonico do projeto (BlqBO.CarregarDoCursor e
    * similares), mesmo que esta tela nao tenha fluxo de ALTERAR.
    *
    * Uso de SELECT (par_cAliasCursor) + campo direto, nunca
    * campo (regra #9 - sintaxe invalida em VFP9).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cDopcs     = TratarNulo(dopcs, "C")
            THIS.this_nNoTitulos = TratarNulo(notitulos, 0)
            THIS.this_cEmpDopNcs = TratarNulo(empdopncs, "C")
            THIS.this_dVencs     = TratarNulo(vencs, {})
            THIS.this_dDatas     = TratarNulo(datas, {})
            THIS.this_cUsuars    = TratarNulo(usuars, "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres, usada
    * tanto no INSERT de SigOpMvv.empdopncs quanto no WHERE do UPDATE de
    * SigMvCab.empdopnums (mesmo VALOR, nomes de coluna diferentes - o
    * legado monta os dois com a mesma expressao).
    *
    * Regra #42: o legado monta SEM ALLTRIM -
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * - e o padding FAZ PARTE da chave: emps char(3) + dopcs char(20) +
    * STR(,6) = 29 caracteres = largura EXATA das colunas empdopncs e
    * empdopnums no schema. Usa PADR explicito sobre as larguras do
    * SCHEMA (this_nLarguraEmps/Dopcs/NoTitulos), porque this_cEmps e
    * this_cDopcs chegam a este BO ja com ALLTRIM (vindos do form pai) -
    * encurtar qualquer parte faz a chave NUNCA casar, sem erro nenhum.
    *====================================================================
    PROTECTED FUNCTION MontarChaveEmpDopNums()
        RETURN PADR(THIS.this_cEmps, THIS.this_nLarguraEmps) + ;
               PADR(THIS.this_cDopcs, THIS.this_nLarguraDopcs) + ;
               STR(THIS.this_nNoTitulos, THIS.this_nLarguraNoTitulos)
    ENDFUNC

    *====================================================================
    * CarregarConfiguracaoOperacao - Carrega as duas configuracoes de apoio
    * que o Init legado busca com CursorQuery, ANTES de liberar a tela:
    *
    *   .poDataMgr.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', .pDop, 'DtEntrs')
    *   If Not Used('crSigCdOpe')
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *       Return .f.
    *   EndIf
    *   .poDataMgr.CursorQuery('SigOpCdd', 'crSigOpCdd', 'Dopes', .pDop, 'chkUteis')
    *   If Not Used('crSigOpCdd')
    *       ... Return .f.
    *   EndIf
    *
    * As DUAS consultas sao requisito de ABERTURA no legado: falhando
    * qualquer uma, o Init devolve .f. e o "Do Form" inteiro nao chega a
    * abrir. Aqui o mesmo efeito vem do RETURN .F. deste metodo, que o
    * InicializarForm do Form usa para abortar o CREATEOBJECT.
    *
    * this_nDtEntrs eh o que ValidarPrazoNovo (Form) usa depois
    * (InList(DtEntrs,1,4,6) do getNova.Valid legado). this_nChkUteis eh
    * carregado pelo mesmo motivo do legado - a abertura da tela depende
    * das DUAS consultas terem sucesso -, mas nenhum dos 7 metodos com
    * codigo do dump chega a LER o valor depois de carregado: fica
    * disponivel sem logica adicional inventada (regra CLAUDE.md
    * REGRA FUNDAMENTAL - nao omitir, mas tambem nao inventar uso que o
    * legado nao tem).
    *
    * Sem conexao (gnConnHandle invalido - probe headless, validacao de UI)
    * os dois valores ficam no default 0 e o metodo devolve .T.: nao ha
    * banco para consultar, e abortar a tela nesse modo impediria qualquer
    * teste automatizado de instanciar o form.
    *
    * EVALUATE(<alias> + ".<campo>") para LEITURA eh seguro (regra #15) -
    * so a ATRIBUICAO com "=" dentro da string eh que nao funciona.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * InicializarForm() do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao: mesmo criterio de CarregarHistorico - nao
                *-- ha banco para consultar, e isso nao e falha.
                loc_lSucesso = .T.
            ELSE
                IF USED(THIS.this_cCursorOperacao)
                    USE IN (THIS.this_cCursorOperacao)
                ENDIF

                loc_cSQL = "SELECT DtEntrs FROM SigCdOpe" + ;
                    " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

                IF loc_nResult >= 0 AND USED(THIS.this_cCursorOperacao) ;
                        AND !EOF(THIS.this_cCursorOperacao)

                    THIS.this_nDtEntrs = NVL(EVALUATE(THIS.this_cCursorOperacao + ".DtEntrs"), 0)

                    IF USED(THIS.this_cCursorConfigDoc)
                        USE IN (THIS.this_cCursorConfigDoc)
                    ENDIF

                    loc_cSQL = "SELECT chkUteis FROM SigOpCdd" + ;
                        " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorConfigDoc)

                    IF loc_nResult >= 0 AND USED(THIS.this_cCursorConfigDoc) ;
                            AND !EOF(THIS.this_cCursorConfigDoc)
                        THIS.this_nChkUteis = NVL(EVALUATE(THIS.this_cCursorConfigDoc + ".chkUteis"), 0)
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                            "o (CursorQuery - SigOpCdd)")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                        "o (CursorQuery - SigCdOpe)")
                    THIS.this_lErroExibido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarConfiguracaoOperacao")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorHistorico - Cria o cursor VAZIO que alimenta a grade do
    * historico (this_cCursorHistorico, o crSigOpMvv do legado).
    *
    * Este metodo eh a FONTE UNICA da estrutura desse cursor: nomes, tipos e
    * ORDEM aqui tem de ser os MESMOS da lista do SELECT de
    * CarregarHistorico(), porque a recarga eh por ZAP + APPEND FROM DBF(),
    * que casa coluna por NOME. Por isso o Form CHAMA este metodo e NUNCA
    * declara a estrutura de novo - duas declaracoes com ordem ou grafia
    * diferentes eh o defeito classico dos forms OPERACIONAIS.
    *
    * Tipos conforme docs\schema.sql (SIGOPMVV): cidchaves char(20),
    * emps char(3), dopcs char(20), notitulos numeric(6,0),
    * empdopncs char(29), vencs datetime, datas datetime, usuars char(10).
    *
    * SET NULL ON em volta do CREATE CURSOR: vencs e datas sao NULL-aveis no
    * SQL Server, e sem campos NULL-aveis o APPEND FROM de uma linha com
    * NULL falha.
    *
    * O alias eh fechado com USE IN e SEM TABLEREVERT antes: USE IN fecha
    * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering -
    * que eh como CREATE CURSOR e SQLEXEC os criam - dispara erro 1586.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o Form, de FORA da
    * classe, antes de ligar a grade.
    *====================================================================
    PROCEDURE CriarCursorHistorico()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (cidchaves C(20), emps C(3), dopcs C(20), notitulos N(6, 0), ;
             empdopncs C(29), vencs T, datas T, usuars C(10))
        SET NULL OFF

        RETURN USED(loc_cCursor)
    ENDPROC

    *====================================================================
    * LimparCursorHistorico - Esvazia o cursor da grade PRESERVANDO a
    * estrutura e, com ela, o RecordSource/ControlSource que o Form ligou no
    * InicializarForm. Eh o Zap In <cursor> do legado Fortyus.
    *
    * SET SAFETY OFF em volta do ZAP eh OBRIGATORIO, nao precaucao: o form
    * que consome este BO eh DataSession = 2, e SET SAFETY eh escopado por
    * DATA SESSION - medido no VFP9, dentro da datasession privada o SAFETY
    * vale ON mesmo com o SET SAFETY OFF do main.prg (mesmo mecanismo que
    * reseta SET DATE/CENTURY ali). Com SAFETY ON o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" e CONGELA a tela esperando um clique que
    * ninguem ve - num teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro.
    *
    * SELECT antes do ZAP: ZAP IN nao muda a work area corrente, e quem
    * chama este metodo segue com APPEND FROM, que vai para a work area
    * CORRENTE.
    *====================================================================
    PROTECTED PROCEDURE LimparCursorHistorico()
        LOCAL loc_cCursor, loc_cSafety
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT (loc_cCursor)
            ZAP IN (loc_cCursor)
            IF loc_cSafety == "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * CarregarHistorico - Popula a grade com o historico de datas de entrega
    * desta operacao (uma linha por troca de prazo ja arquivada).
    *
    * Transcreve a consulta que o Init legado monta e manda ao AddCursor:
    *   lcQrySigOpMvv = [Select * ] + ;
    *                    [From SigOpMvv ] + ;
    *                   [Where EmpDopNcs = '] + pEmp + pDop + Str(pNum, 6) + [' ] + ;
    *                   [Order By Vencs]
    * As colunas sao listadas explicitamente no lugar do SELECT *, para a
    * lista do SELECT ser a MESMA do CREATE CURSOR de CriarCursorHistorico()
    * - APPEND FROM DBF() casa coluna por NOME.
    *
    * A chave vem de MontarChaveEmpDopNums(): 29 caracteres COM o padding,
    * porque empdopncs eh char(29) POSICIONAL (emps char(3) + dopcs char(20)
    * + STR(,6)) e encurtar qualquer parte com ALLTRIM faz o WHERE nunca
    * casar - devolvendo ZERO linha em SILENCIO, sem erro e sem log.
    *
    * Sem os parametros do form pai (probe headless, harness) a chave fica
    * em branco e o SELECT devolve ZERO linha: grade vazia, SEM erro - o
    * mesmo que o legado exibe para uma operacao que nunca teve troca de
    * prazo. Por isso zero linha NAO eh falha, e quem precisa aferir carga
    * tem de olhar RECCOUNT, nao o retorno deste metodo.
    *
    * O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
    * recarregado por ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias
    * da grade FECHA e RECRIA o alias: o Grid perde RecordSource e
    * ControlSource e cai para ColumnCount = 0 - vira um retangulo branco
    * sem cabecalho e sem coluna, sem erro, sem log e sem excecao.
    *
    * O guard do TABLEREVERT olha o BUFFERING, nao o USED: TABLEREVERT em
    * cursor sem buffering (como SQLEXEC cria) dispara erro 1586.
    *
    * Sem conexao (gnConnHandle invalido - validacao de UI, probe headless)
    * a grade fica VAZIA e o metodo devolve .T.: nao houve falha, so nao
    * havia banco para consultar.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o CarregarLista()
    * do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cCursor, loc_cTmp, loc_cChave
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorHistorico
        loc_cTmp     = "cursor_4c_HistoricoTmp"

        TRY
            IF !USED(loc_cCursor)
                THIS.CriarCursorHistorico()
            ENDIF

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o cursor do hist" + CHR(243) + "rico (" + loc_cCursor + ")."
                MsgErro(THIS.this_cMensagemErro, "SigOpEntBO.CarregarHistorico")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao: grade vazia, mesmo resultado visual de uma
                    *-- operacao sem historico
                    THIS.LimparCursorHistorico()
                    loc_lSucesso = .T.
                ELSE
                    loc_cChave = THIS.MontarChaveEmpDopNums()

                    loc_cSQL = "SELECT cidchaves, emps, dopcs, notitulos," + ;
                        " empdopncs, vencs, datas, usuars" + ;
                        " FROM SigOpMvv" + ;
                        " WHERE EmpDopNcs = " + EscaparSQL(loc_cChave) + ;
                        " ORDER BY Vencs"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        THIS.LimparCursorHistorico()
                        SELECT (loc_cCursor)
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado nas falhas de carga deste form:
                        *-- MessageBox([Favor Reinicializar o Processo!!!], 16,
                        *--            [Falha na Conexao (...)])
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarHistorico")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de HISTORICO em SigOpMvv.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 550-553 do dump legado):
    *   Insert Into crSigOpMvv (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs,
    *                           cIdChaves, Usuars, Datas)
    *          Values (pEmp, pDop, pNum, fDtoSQL(ldAnt),
    *                  pEmp + pDop + Str(pNum,6), fUniqueIds(), Usuar,
    *                  Datetime())
    *
    * ATENCAO (nao inverter): Vencs recebe this_dPrazoAtual - o prazo que
    * esta SAINDO (ldAnt no legado) - NUNCA this_dPrazoNovo. O historico
    * arquiva a data ANTIGA, a nova vai para SigMvCab em Atualizar().
    *
    * O legado so executa o bloco inteiro (insert+update+commit) quando a
    * data nova nao esta vazia (If Not Empty(ldNew)); com o campo vazio o
    * clique em Confirmar nao faz nada, sem erro nenhum - por isso aqui
    * tambem devolve .T. (nada a gravar) e nao falha.
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_lGravouPrazo = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpMvv" + ;
                       " (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs," + ;
                       "  cIdChaves, Usuars, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, THIS.this_nLarguraEmps)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopcs, THIS.this_nLarguraDopcs)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNoTitulos, 0) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoAtual) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNcs) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao gravar hist" + CHR(243) + "rico de entrega:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE de SigMvCab.PrazoEnts com a data NOVA.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 559-568 do dump legado):
    *   If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts = ?pDtp
    *       Where EmpDopNums = pEmp + pDop + Str(pNum,6)
    *   EndIf
    *
    * Quando o form pai esta em modo ALTERAR (this_cEscolhaPai igual a
    * this_cModoNaoAtualizaCabecalho), o PROPRIO pai grava o cabecalho e
    * este UPDATE tem de ser PULADO - essa condicao eh regra de negocio
    * do legado (CLAUDE.md regra #21b: a condicao que cerca a validacao
    * faz parte dela), por isso devolve .T. (nada a atualizar) em vez de
    * executar o UPDATE, exatamente como o legado nao executa a query.
    *
    * Depende de this_cEmpDopNcs e this_dPrazoNovo ja estarem calculados
    * - chamar DEPOIS de Inserir() ter devolvido .T., nunca isolado.
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        IF THIS.this_cEscolhaPai = THIS.this_cModoNaoAtualizaCabecalho
            *-- Modo ALTERAR: o form pai grava o proprio cabecalho - nada a
            *-- fazer aqui (fiel ao guard do legado em altera.Valid).
            THIS.this_lGravouPrazo = .T.
            RETURN .T.
        ENDIF

        TRY
            IF EMPTY(THIS.this_cEmpDopNcs)
                THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoNovo) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNcs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_lGravouPrazo = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar o prazo de entrega do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * GravarAlteracaoPrazo - UNICA via de gravacao desta tela: encadeia
    * Inserir() + Atualizar() e fecha a transacao, espelhando o corpo de
    * SIGOPENT.altera.Valid com a flag llOks do legado:
    *
    *   Insert Into crSigOpMvv (...)            -> Inserir()
    *   llOks = .t.
    *   If llOks And (pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts ...   -> Atualizar()
    *   EndIf
    *   If llOks
    *       If Not poDataMgr.Update('crSigOpMvv')  -> (ver nota abaixo)
    *   EndIf
    *   If llOks
    *       If (poDataMgr.Commit() < 1)
    *           =MessageBox('Favor Reinicializar o Processo!!!', 16,
    *                       'Falha na Conexao (Commit)')
    *           llOks = .f.
    *       EndIf
    *   EndIf
    *   If Not llOks
    *       poDataMgr.RollBack()
    *   EndIf
    *
    * O "poDataMgr.Update('crSigOpMvv')" do legado NAO tem linha propria
    * aqui: ele era o passo que mandava ao servidor as linhas em aberto do
    * cursor remoto do Fortyus (o INSERT legado grava no CURSOR, nao na
    * tabela). Nesta arquitetura Inserir() emite o INSERT direto em
    * SigOpMvv por SQLEXEC, de modo que o envio ja aconteceu - o passo
    * esta cumprido, nao descartado.
    *
    * O Commit(), ao contrario, NAO se descarta: medido neste ambiente,
    * SQLGETPROP(gnConnHandle, "Transactions") = 2 (MANUAL) e a conexao
    * nasce com @@TRANCOUNT = 1, isto eh o gravado fica preso na transacao
    * aberta e SOME se o processo cair - foi assim que um UPDATE migrado
    * sem o Commit do legado deixou de persistir sem erro na tela. O par
    * loc_lManual + SQLCOMMIT/SQLROLLBACK eh a forma segura usada no
    * projeto (SIGPRCNBBO): com a conexao em auto-commit o par fica
    * inerte, em vez de comitar a transacao de outra tela.
    *
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)": VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer jeito.
    *
    * Campo vazio devolve .F. sem mensagem nenhuma: o legado embrulha o
    * bloco inteiro em "If Not Empty(ldNew)", logo clicar Confirmar com a
    * data nova em branco nao faz nada - nem grava, nem avisa. Quem decide
    * se ha o que gravar eh o Form, que ja testa isso antes de chamar;
    * este guard existe para o metodo nunca gravar meia operacao se for
    * chamado isolado.
    *
    * this_lGravouPrazo (o "thisform.parentform.validOk = .t." do legado)
    * so permanece .T. quando TODA a cadeia passou - inclusive o commit.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9. Os dois RETURN antecipados ficam
    * FORA do bloco.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * BtnConfirmarClick() do Form, de FORA da classe - metodo que o Form
    * chama nunca pode ser PROTECTED em nenhum nivel da heranca
    * (regra #51).
    *====================================================================
    FUNCTION GravarAlteracaoPrazo()
        LOCAL loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .F.

        THIS.this_lGravouPrazo  = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .F.
        ENDIF

        *-- Conexao em transacao MANUAL (2) exige commit explicito; em
        *-- auto-commit (1) o par commit/rollback fica inerte.
        loc_lManual = .F.
        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        ENDIF

        TRY
            *-- Historico: arquiva a data que esta SAINDO (this_dPrazoAtual)
            loc_lSucesso = THIS.Inserir()

            *-- Cabecalho do movimento: recebe a data NOVA. Pulado quando o
            *-- form pai esta em ALTERAR - ali eh ele que grava SigMvCab
            *-- (guard do legado, ja dentro de Atualizar()).
            IF loc_lSucesso
                loc_lSucesso = THIS.Atualizar()
            ENDIF

            IF loc_lManual
                IF loc_lSucesso
                    IF SQLCOMMIT(gnConnHandle) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                        THIS.this_lErroExibido = .T.
                        = SQLROLLBACK(gnConnHandle)
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    *-- "If Not llOks / ThisForm.poDataMgr.RollBack()"
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDIF

            IF !loc_lSucesso
                THIS.this_lGravouPrazo = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.GravarAlteracaoPrazo")
            THIS.this_lErroExibido = .T.
            THIS.this_lGravouPrazo = .F.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

