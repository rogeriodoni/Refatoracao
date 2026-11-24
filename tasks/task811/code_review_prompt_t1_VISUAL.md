# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH Thisform.GradeSubN define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeSubN.RecordSource).
- [GRID-WITH] Bloco WITH legado. define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: legado..RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpTop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1112 linhas total):

*-- Linhas 136 a 144:
136: *     - ConfigurarGrade()      Shape1 + GradeSubN -> shp_4c_Shape1 +
137: *                              grd_4c_Dados (SO o que nao depende de dado)
138: *     - AplicarFormatoGrade()  FONTE UNICA de Column.Width/Header1.Caption
139: *     - ConfigurarBotoes()     cmdSair -> cmd_4c_Encerrar + BINDEVENT
140: *     - BtnEncerrarClick()     Click do legado (reabilita o pai + Release)
141: *     - CarregarLista()        funil: BO.CarregarTransportes + binding +
142: *                              GO TOP + Refresh (trecho final do Init legado)
143: *
144: *   O Click do Encerrar entrou junto com o botao (e nao so na fase de

*-- Linhas 291 a 299:
291:     Width       = 500
292: 
293:     *-- Caption do SCX ("Transportes") - sobrescrito em InicializarForm com
294:     *-- o codigo da operacao-pai, igual ao legado (.Caption = 'Transportes
295:     *-- da Operacao ' + AllTrim(Proper(crSigCdOpe.Dopes)))
296:     Caption = "Transportes"
297: 
298:     *-- ControlBox = .F. / MaxButton = .F. / Movable = .F. / TitleBar = 0 /
299:     *-- ClipControls = .F. - literais do dump. Closable/MinButton NAO

*-- Linhas 430 a 442:
430:                 *-- Legado: .ParentForm.Enabled = .f.
431:                 THIS.CarregarContextoFormPai()
432: 
433:                 *-- Legado: .Caption = 'Transportes da Operacao ' +
434:                 *-- AllTrim(Proper(crSigCdOpe.Dopes)). ObterTituloDialogo ja
435:                 *-- grava this_cDopes no BO como efeito colateral (ver
436:                 *-- cabecalho de SigOpTopBO.prg)
437:                 THIS.Caption = THIS.this_oBusinessObject.ObterTituloDialogo(THIS.this_cDopes)
438: 
439:                 *-- Fundo do form (Picture do SCX)
440:                 THIS.ConfigurarDecoracao()
441: 
442:                 *-- Legado: .Top/.Left calculados a partir da grade do pai

*-- Linhas 453 a 461:
453:                 *-- depois, bloquearia o clique sem desenhar nada, regra #30)
454:                 THIS.ConfigurarGrade()
455: 
456:                 *-- cmdSair do legado -> cmd_4c_Encerrar
457:                 THIS.ConfigurarBotoes()
458: 
459:                 *-- AddObject cria controle com Visible = .F.
460:                 THIS.TornarControlesVisiveis(THIS)
461: 

*-- Linhas 526 a 535:
526:     * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
527:     * legado, que ancora este dialogo ao lado da grade do form pai:
528:     *
529:     *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
530:     *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
531:     *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
532:     *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
533:     *
534:     * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
535:     * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/

*-- Linhas 564 a 581:
564:             RETURN
565:         ENDIF
566: 
567:         THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50
568: 
569:         IF loc_oGrade.ColumnCount >= 3
570:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
571:                         loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
572:         ELSE
573:             *-- Grade com menos de 3 colunas (layout divergente do esperado)
574:             *-- - aproximacao segura, so para o dialogo nao abrir fora da
575:             *-- area visivel
576:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
577:         ENDIF
578:     ENDPROC
579: 
580:     *==========================================================================
581:     * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do

*-- Linhas 594 a 602:
594:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
595:     *
596:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
597:     * ("Transportes da Operacao <operacao>"), por isso .Caption = THIS.Caption
598:     * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
599:     * do Form Designer, nunca chega a ser exibido.
600:     *
601:     * Width do container usa THIS.Width - padrao canonico da faixa, regra
602:     * #11 - em vez do literal 800: o SCX declara o CONTAINER mais largo que

*-- Linhas 614 a 669:
614:         *-- Container da faixa (cntSombra)
615:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
616:         WITH THIS.cnt_4c_Cabecalho
617:             .Top           = 0
618:             .Left          = 0
619:             .Width         = THIS.Width
620:             .Height        = 80
621:             .BorderWidth   = 0
622:             .BackStyle     = 1
623:             .BackColor     = RGB(100, 100, 100)
624:             .SpecialEffect = 0
625:             .Visible       = .T.
626:         ENDWITH
627: 
628:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
629:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
630:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
631:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
632:             .AutoSize      = .F.
633:             .FontBold      = .T.
634:             .FontName      = "Tahoma"
635:             .FontSize      = 18
636:             .FontUnderline = .F.
637:             .WordWrap      = .T.
638:             .Alignment     = 0
639:             .BackStyle     = 0
640:             .Caption       = THIS.Caption
641:             .Top           = 18
642:             .Left          = 10
643:             .Width         = THIS.Width - 20
644:             .Height        = 40
645:             .ForeColor     = RGB(0, 0, 0)
646:             .Rotation      = 0
647:             .Visible       = .T.
648:         ENDWITH
649: 
650:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
651:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
652:         *-- regra #12)
653:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
654:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
655:             .AutoSize    = .F.
656:             .FontBold    = .T.
657:             .FontName    = "Tahoma"
658:             .FontSize    = 18
659:             .WordWrap    = .T.
660:             .Alignment   = 0
661:             .BackStyle   = 0
662:             .Caption     = THIS.Caption
663:             .Top         = 17
664:             .Left        = 10
665:             .Width       = THIS.Width - 20
666:             .Height      = 46
667:             .ForeColor   = RGB(255, 255, 255)
668:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
669:             .Rotation    = 0

*-- Linhas 707 a 716:
707:         *-- Shape1 (decoracao invisivel do legado) - PRIMEIRO, ver acima
708:         THIS.AddObject("shp_4c_Shape1", "Shape")
709:         WITH THIS.shp_4c_Shape1
710:             .Top         = 7
711:             .Left        = 224
712:             .Height      = 110
713:             .Width       = 91
714:             .BackStyle   = 0
715:             .BorderStyle = 0
716:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 723 a 732:
723:             .ColumnCount       = 2
724:             .FontName          = "Tahoma"
725:             .FontSize          = 8
726:             .Top               = 100
727:             .Left              = 161
728:             .Height            = 229
729:             .Width             = 177
730:             .RowHeight         = 16
731:             .ScrollBars        = 2
732:             .TabIndex          = 1

*-- Linhas 789 a 797:
789:                 .Column1.FontName          = "Tahoma"
790:                 .Column1.FontSize          = 8
791:                 .Column1.ReadOnly          = .T.
792:                 .Column1.Header1.Caption   = "Cod.Transporte"
793:                 .Column1.Header1.FontName  = "Tahoma"
794:                 .Column1.Header1.FontSize  = 8
795:                 .Column1.Header1.Alignment = 2
796:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
797:                 .Column1.Text1.BorderStyle = 0

*-- Linhas 810 a 818:
810:                 .Column2.FontSize          = 8
811:                 .Column2.ReadOnly          = .T.
812:                 .Column2.InputMask         = "9999"
813:                 .Column2.Header1.Caption   = "Empresa"
814:                 .Column2.Header1.FontName  = "Tahoma"
815:                 .Column2.Header1.FontSize  = 8
816:                 .Column2.Header1.Alignment = 2
817:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
818:                 .Column2.Text1.BorderStyle = 0

*-- Linhas 831 a 849:
831:     ENDPROC
832: 
833:     *==========================================================================
834:     * ConfigurarBotoes - cmdSair do legado -> cmd_4c_Encerrar
835:     *
836:     * Transcricao do dump: Top=3 Left=425 Caption="Encerrar" Cancel=.T.
837:     * Picture=cadastro_sair_60.jpg (classe fwbtng).
838:     *
839:     * Width/Height nao constam do dump (vem da classe fwbtng, 80x100, que
840:     * NAO cabe: 425 + 80 = 505 estoura os 500px do form e a altura passaria
841:     * da faixa). Usados os 75x75 canonicos dos botoes do projeto, que
842:     * fecham exatamente na borda (425 + 75 = 500 = Form.Width) - mesma
843:     * decisao ja tomada nos dialogos irmaos desta familia (FormSigOpSlc).
844:     * O canonico cnt_4c_Saida.Left = 917 (regra #10) NAO se aplica aqui:
845:     * eh dos CRUD de 1000px e ficaria 400px fora desta tela.
846:     *
847:     * Cancel = .T. transcrito do legado: sem TitleBar e sem ControlBox este
848:     * botao eh a unica saida visivel, e o Cancel liga o ESC a ele.
849:     *

*-- Linhas 864 a 877:
864:             loc_cIconeSair = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
865:         ENDIF
866: 
867:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
868:         WITH THIS.cmd_4c_Encerrar
869:             .Caption      = "Encerrar"
870:             .Cancel       = .T.
871:             .Top          = 3
872:             .Left         = 425
873:             .Width        = 75
874:             .Height       = 75
875:             .FontName     = "Comic Sans MS"
876:             .FontSize     = 8
877:             .FontBold     = .T.

*-- Linhas 897 a 905:
897:         *-- Click do botao. BINDEVENT ligado aqui, junto com o AddObject,
898:         *-- em vez de deixar o unico botao da tela inerte ate a fase de
899:         *-- eventos: a tela nao teria saida pelo mouse nesse intervalo
900:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
901:     ENDPROC
902: 
903:     *==========================================================================
904:     * BtnEncerrarClick - cmdSair.Click do legado, transcrito:
905:     *


### BO (C:\4c\projeto\app\classes\SigOpTopBO.prg):
*==============================================================================
* SIGOPTOPBO.PRG
* Business Object para o dialogo de Transportes da Operacao
* (SIGOPTOP - dialogo filho MODAL aberto pelo form pai SIGCDOPE via
*  "Do Form SigOpTop With ThisForm, nDataSession", NAO acessivel direto
*  pelo menu)
*
* Tabela de contexto : SigCdOpe (operacao) - usada SOMENTE para montar o
*                       Caption do dialogo a partir da linha corrente do
*                       form pai (crSigCdOpe.Dopes)
* Tabela consultada   : SigCdMei (meios de transporte)
* Chave Real (PK)     : cidchaves  CHAR(20)
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGOPTOP linhas 286-342):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe, lista
*   de operacoes) e pnDataSes e a DataSession do pai - o dialogo faz
*   "Set DataSession to pnDataSes" para conseguir ler crSigCdOpe (cursor do
*   pai) diretamente, antes de abrir a propria DataSession = 2 privada.
*
*   O Caption e montado como:
*     'Transportes da Operacao ' + AllTrim(Proper(crSigCdOpe.Dopes))
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Em seguida monta e executa:
*     Select Distinct Substring(TipoEmps,1,6) as Codigos,
*                      Substring(TipoEmps,7,3) as Emps
*     From SigCdMei Where Dopes = '<crSigCdOpe.Dopes>'
*   TipoEmps e CHAR(9) em SigCdMei: os 6 primeiros caracteres sao o codigo
*   do transporte (Codigos) e os 3 ultimos sao o codigo da empresa (Emps) -
*   SAO os dois UNICOS campos exibidos na grade (GradeSubN, 2 colunas).
*
*   O dialogo e SOMENTE LEITURA (Column1.ReadOnly = .T. e Column2.ReadOnly
*   = .T. no SCX, sem nenhum botao de gravacao) - o unico botao e cmdSair
*   (Caption "Encerrar"), que reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase
*   (recusar a operacao e reportar pelo ExibirFalha do Salvar) ja eh o
*   correto, e inventar INSERT/UPDATE aqui violaria a regra #22 do
*   CLAUDE.md (a lista de colunas vem do schema, nunca de adivinhacao).
*==============================================================================

DEFINE CLASS SigOpTopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado)
    * Somente leitura: alimenta o Caption / titulo do dialogo e o filtro
    * da consulta a SigCdMei.
    *--------------------------------------------------------------------------
    this_cDopes              = ""  && dopes    CHAR(20) - codigo da operacao (contexto, vindo do form pai)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA GRADE DE TRANSPORTES (CrSigCdMei no legado)
    * Resultado da SELECT DISTINCT Substring(TipoEmps,...) descrita no
    * cabecalho - SigCdMei.TipoEmps CHAR(9) nunca e exibido por inteiro,
    * so os dois pedacos abaixo.
    *--------------------------------------------------------------------------
    this_cCodigos            = ""  && Codigos  CHAR(6)  - Substring(TipoEmps,1,6) - codigo do transporte (grid "Cod.Transporte")
    this_cEmps               = ""  && Emps     CHAR(3)  - Substring(TipoEmps,7,3) - codigo da empresa (grid "Empresa")

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_cCursorTransportes : alias migrado de CrSigCdMei. O cursor e
    *   populado por este BO (SQLEXEC contra SigCdMei) e apenas exibido
    *   pelo Form, sem edicao.
    *--------------------------------------------------------------------------
    this_cCursorTransportes  = "cursor_4c_Transportes"
    this_cTituloDialogo      = ""
    this_nTotalTransportes   = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este
    * dialogo nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela realmente consultada
    * (SigCdMei), usada para montar a grade de transportes.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdMei"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTransportes - Popula this_cCursorTransportes com os transportes
    * da operacao informada.
    *
    * Transcricao literal da consulta do legado (SIGOPTOP linhas 286-342):
    *   Select Distinct Substring(TipoEmps,1,6) as Codigos,
    *                    Substring(TipoEmps,7,3) as Emps
    *   From SigCdMei Where Dopes = '<par_cDopes>'
    *
    * SQLEXEC roda contra um cursor TEMPORARIO (nunca direto em
    * cursor_4c_Transportes) porque esse alias pode ja estar ligado ao
    * RecordSource do grd_4c_Dados do Form - reatribuir o alias via SQLEXEC
    * zeraria o ColumnCount do grid (regra do CLAUDE.md sobre SQLEXEC em
    * cursor ligado a Grid). O resultado e copiado com ZAP + APPEND FROM
    * DBF(), que preserva a estrutura/binding do cursor permanente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTransportes(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_cDopes

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalTransportes = 0

        IF VARTYPE(par_cDopes) != "C" OR EMPTY(ALLTRIM(par_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cDopes = ALLTRIM(par_cDopes)

        IF USED("cursor_4c_TransportesTmp")
            IF CURSORGETPROP("Buffering", "cursor_4c_TransportesTmp") > 1
                TABLEREVERT(.T., "cursor_4c_TransportesTmp")
            ENDIF
            USE IN cursor_4c_TransportesTmp
        ENDIF

        loc_cSQL = "SELECT DISTINCT SUBSTRING(TipoEmps, 1, 6) AS Codigos, " + ;
                   "SUBSTRING(TipoEmps, 7, 3) AS Emps " + ;
                   "FROM SigCdMei " + ;
                   "WHERE Dopes = " + EscaparSQL(loc_cDopes)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TransportesTmp")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorTransportes)
            SELECT (THIS.this_cCursorTransportes)
            ZAP
            IF RECCOUNT("cursor_4c_TransportesTmp") > 0
                APPEND FROM DBF("cursor_4c_TransportesTmp")
            ENDIF
            GO TOP IN (THIS.this_cCursorTransportes)
        ELSE
            SELECT * FROM cursor_4c_TransportesTmp INTO CURSOR (THIS.this_cCursorTransportes) READWRITE
        ENDIF

        IF USED("cursor_4c_TransportesTmp")
            USE IN cursor_4c_TransportesTmp
        ENDIF

        THIS.this_nTotalTransportes = IIF(USED(THIS.this_cCursorTransportes), RECCOUNT(THIS.this_cCursorTransportes), 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTituloDialogo - Monta o Caption do dialogo a partir do codigo da
    * operacao do form pai (crSigCdOpe.Dopes), reproduzindo:
    *   'Transportes da Operacao ' + AllTrim(Proper(crSigCdOpe.Dopes))
    *--------------------------------------------------------------------------
    FUNCTION ObterTituloDialogo(par_cDopes)
        LOCAL loc_cDopes

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

        THIS.this_cDopes         = loc_cDopes
        THIS.this_cTituloDialogo = "Transportes da Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(PROPER(loc_cDopes))

        RETURN THIS.this_cTituloDialogo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega da linha corrente de cursor_4c_Transportes
    * (ou outro alias informado) para as propriedades this_cCodigos/this_cEmps.
    * Usado pelo Form para ler a linha selecionada na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorTransportes)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cCodigos = TratarNulo(Codigos, "")
        THIS.this_cEmps    = TratarNulo(Emps, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de tabela real neste dialogo (regra #22
    * nao se aplica: SigCdMei.TipoEmps nao e gravado por aqui, so consultado).
    * A combinacao Codigos+Emps identifica a linha corrente na grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodigos, "")) + ALLTRIM(NVL(THIS.this_cEmps, ""))
    ENDPROC

ENDDEFINE

