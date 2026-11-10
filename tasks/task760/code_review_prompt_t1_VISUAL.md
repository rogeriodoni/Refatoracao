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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLib.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1713 linhas total):

*-- Linhas 53 a 61:
53: * O que esta fase entrega, portanto, eh a unica superficie de BOTAO que o
54: * legado REALMENTE tem, com comportamento completo:
55: *
56: *   ConfigurarBotoes()   shp_4c_Shape2 + cmd_4c_Ok, na ordem dos registros do
57: *                        SCX (Shape2 eh o penultimo, ok eh o ultimo)
58: *   ConfigurarEventos()  BINDEVENT do Click do ok
59: *   BtnOkClick()         "ThisForm.Release" do legado, pelo funil de fechamento
60: *   FecharDialogo()      Hide() em vez de Release(), para o chamador conseguir
61: *                        ler this_cRetorno depois do Show()

*-- Linhas 334 a 342:
334: 
335:         TRY
336:             *-- Caption do legado: "Liberacao de Peso" (acentos via CHR())
337:             THIS.Caption = "Libera" + CHR(231) + CHR(227) + "o de Peso"
338: 
339:             *-- Business Object gerado nas Fases 1-2
340:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpLibBO")
341: 
342:             IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 444 a 452:
444:     * Os DOIS labels sobrepostos com 1px de diferenca no Top sao o efeito de
445:     * sombra do framework: o preto desenha atras, o branco na frente. O Caption
446:     * dos dois vem de THIS.Caption, igual ao Init do legado
447:     * (cntSombra.lblSombra.Caption = ThisForm.Caption).
448:     *
449:     * Width = THIS.Width nos tres objetos, NAO os literais 800/769: o SCX
450:     * declara o container (800) e os labels (769) mais largos que o proprio
451:     * form (550) - artefato do Form Designer, que desenha o container alem da
452:     * borda da janela. Copiar o literal faria o label ultrapassar a area

*-- Linhas 462 a 519:
462:     * Nenhum controle de dados pode ficar com Top < 80 nesta tela: a faixa
463:     * ocupa a area 0..80, e o legado respeita isso (o primeiro Say esta em 99).
464:     *--------------------------------------------------------------------------
465:     PROTECTED PROCEDURE ConfigurarCabecalho()
466:         *-- Container da faixa cinza
467:         THIS.AddObject("cnt_4c_Sombra", "Container")
468:         WITH THIS.cnt_4c_Sombra
469:             .Top           = 0
470:             .Left          = 0
471:             .Width         = THIS.Width
472:             .Height        = 80
473:             .BorderWidth   = 0
474:             .BackStyle     = 1
475:             .BackColor     = RGB(100, 100, 100)
476:             .SpecialEffect = 0
477:             .Visible       = .T.
478:         ENDWITH
479: 
480:         *-- Label de sombra (preto, 1px abaixo do titulo)
481:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
482:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
483:             .AutoSize      = .F.
484:             .FontName      = "Tahoma"
485:             .FontSize      = 18
486:             .FontBold      = .T.
487:             .FontUnderline = .F.
488:             .WordWrap      = .T.
489:             .Alignment     = 0
490:             .BackStyle     = 0
491:             .Caption       = THIS.Caption
492:             .Top           = 18
493:             .Left          = 10
494:             .Width         = THIS.Width
495:             .Height        = 40
496:             .ForeColor     = RGB(0, 0, 0)
497:             .Visible       = .T.
498:         ENDWITH
499: 
500:         *-- Label do titulo (branco sobre o cinza do container OPACO - esta eh
501:         *-- a excecao legitima da regra #12, que proibe ForeColor branco em
502:         *-- label de DADOS)
503:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
504:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
505:             .AutoSize    = .F.
506:             .FontName    = "Tahoma"
507:             .FontSize    = 18
508:             .FontBold    = .T.
509:             .WordWrap    = .T.
510:             .Alignment   = 0
511:             .BackStyle   = 0
512:             .Caption     = THIS.Caption
513:             .Top         = 17
514:             .Left        = 10
515:             .Width       = THIS.Width
516:             .Height      = 46
517:             .ForeColor   = RGB(255, 255, 255)
518:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
519:             .Visible     = .T.

*-- Linhas 658 a 698:
658:             *-- Shape1: moldura dos dois campos (1o dos cinco registros)
659:             THIS.AddObject("shp_4c_Shape1", "Shape")
660:             WITH THIS.shp_4c_Shape1
661:                 .Top         = 118
662:                 .Left        = 104
663:                 .Width       = 342
664:                 .Height      = 33
665:                 .BackStyle   = 0
666:                 .BorderColor = RGB(90, 90, 90)
667:                 .Visible     = .T.
668:             ENDWITH
669: 
670:             *-- Say2: legenda "Codigo :"
671:             THIS.AddObject("lbl_4c_Label2", "Label")
672:             WITH THIS.lbl_4c_Label2
673:                 .AutoSize  = .F.
674:                 .FontName  = "Tahoma"
675:                 .FontSize  = 8
676:                 .BackStyle = 0
677:                 .Alignment = 0
678:                 .Caption   = "C" + CHR(243) + "digo : "
679:                 .Top       = 127
680:                 .Left      = 109
681:                 .Width     = 46
682:                 .Height    = 15
683:                 .ForeColor = RGB(90, 90, 90)
684:                 .Visible   = .T.
685:             ENDWITH
686: 
687:             *-- get_codigo: codigo do tipo de liberacao (SigCdNcf.cods)
688:             THIS.AddObject("txt_4c__codigo", "TextBox")
689:             WITH THIS.txt_4c__codigo
690:                 .FontName           = "Tahoma"
691:                 .FontSize           = 8
692:                 .Top                = 123
693:                 .Left               = 155
694:                 .Width              = 80
695:                 .Height             = 23
696:                 .Century            = 2
697:                 .Alignment          = 3
698:                 .Format             = "K"

*-- Linhas 711 a 720:
711:             WITH THIS.txt_4c__descr
712:                 .FontName           = "Tahoma"
713:                 .FontSize           = 8
714:                 .Top                = 123
715:                 .Left               = 238
716:                 .Width              = 202
717:                 .Height             = 23
718:                 .Format             = "K"
719:                 .MaxLength          = 60
720:                 .ForeColor          = RGB(0, 0, 0)

*-- Linhas 726 a 746:
726:             ENDWITH
727: 
728:             *-- Say1: instrucao acima da moldura (ultimo dos cinco registros)
729:             THIS.AddObject("lbl_4c_Label1", "Label")
730:             WITH THIS.lbl_4c_Label1
731:                 .AutoSize  = .F.
732:                 .FontName  = "Tahoma"
733:                 .FontSize  = 8
734:                 .FontBold  = .T.
735:                 .WordWrap  = .F.
736:                 .BackStyle = 0
737:                 .Alignment = 0
738:                 .Caption   = "Informe o Tipo de Libera" + CHR(231) + CHR(227) + ;
739:                              "o para prosseguir : "
740:                 .Top       = 99
741:                 .Left      = 106
742:                 .Width     = 261
743:                 .Height    = 15
744:                 .ForeColor = RGB(90, 90, 90)
745:                 .Visible   = .T.
746:             ENDWITH

*-- Linhas 780 a 800:
780:     *   ordem EFETIVA do legado: Say1=1  cntSombra=2  Say2=3
781:     *                            get_codigo=4  get_descr=5  ok=6
782:     *
783:     * Entre os FOCALIZAVEIS isso eh Codigo -> Descricao -> Ok, que eh o ciclo
784:     * que o usuario percebe. Label tem TabIndex mas NAO tem TabStop (nao
785:     * recebe foco); Container tem os dois, mas o cnt_4c_Sombra so guarda os
786:     * labels da faixa, entao nao para o Tab na pratica.
787:     *
788:     * Atribuicao em ordem ASCENDENTE e com valores UNICOS dentro da faixa
789:     * 1..6 - sao 8 controles no form, mas dois sao Shape e nao tem a
790:     * propriedade, logo a faixa eh o numero de controles que a TEM. Valor
791:     * duplicado ou fora da faixa eh DESCARTADO em silencio, de modo que copiar
792:     * os literais do dump um a um seria inerte.
793:     *
794:     * Escrito com os ordinais EFETIVOS (1..6) e o literal do dump no
795:     * comentario de cada linha: eh o valor que o objeto realmente guarda, e
796:     * afirmar no codigo um numero que o VFP descarta so faria o proximo leitor
797:     * (ou uma auditoria dump-x-migrado) perseguir um defeito que nao existe.
798:     *
799:     * Guard por CONTROLE (PEMSTATUS(<controle>, "TabIndex", 5)), nunca
800:     * PEMSTATUS(THIS, "<nome>", 5): o segundo so diz que o membro existe no

*-- Linhas 809 a 838:
809:         LOCAL loc_oErro
810: 
811:         TRY
812:             IF PEMSTATUS(THIS.lbl_4c_Label1, "TabIndex", 5)
813:                 THIS.lbl_4c_Label1.TabIndex = 1      && SCX: Say1       TabIndex=1
814:             ENDIF
815: 
816:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "TabIndex", 5)
817:                 THIS.cnt_4c_Sombra.TabIndex = 2      && SCX: cntSombra  nao declara
818:             ENDIF
819: 
820:             IF PEMSTATUS(THIS.lbl_4c_Label2, "TabIndex", 5)
821:                 THIS.lbl_4c_Label2.TabIndex = 3      && SCX: Say2       TabIndex=2
822:             ENDIF
823: 
824:             IF PEMSTATUS(THIS.txt_4c__codigo, "TabIndex", 5)
825:                 THIS.txt_4c__codigo.TabIndex = 4     && SCX: get_codigo TabIndex=3
826:             ENDIF
827: 
828:             IF PEMSTATUS(THIS.txt_4c__descr, "TabIndex", 5)
829:                 THIS.txt_4c__descr.TabIndex = 5      && SCX: get_descr  TabIndex=4
830:             ENDIF
831: 
832:             IF PEMSTATUS(THIS.cmd_4c_Ok, "TabIndex", 5)
833:                 THIS.cmd_4c_Ok.TabIndex = 6          && SCX: ok         nao declara
834:             ENDIF
835:         CATCH TO loc_oErro
836:             THIS.this_cMensagemErro = loc_oErro.Message
837:             MsgErro(loc_oErro.Message + CHR(13) + ;
838:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 893 a 918:
893:             *-- Shape2 do legado (decoracao invisivel, penultimo registro)
894:             THIS.AddObject("shp_4c_Shape2", "Shape")
895:             WITH THIS.shp_4c_Shape2
896:                 .Top         = 7
897:                 .Left        = 444
898:                 .Width       = 12
899:                 .Height      = 29
900:                 .BackStyle   = 0
901:                 .BorderStyle = 0
902:                 .BorderColor = RGB(136, 189, 188)
903:                 .Visible     = .T.
904:             ENDWITH
905: 
906:             *-- Botao Ok do legado (ultimo registro da arvore do SCX)
907:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
908:             WITH THIS.cmd_4c_Ok
909:                 .Top             = 3
910:                 .Left            = 475
911:                 .Width           = 75
912:                 .Height          = 75
913:                 .Caption         = "\<Ok"
914:                 .Cancel          = .T.
915:                 .FontName        = "Comic Sans MS"
916:                 .FontSize        = 8
917:                 .FontBold        = .T.
918:                 .FontItalic      = .T.

*-- Linhas 995 a 1003:
995:             BINDEVENT(THIS.txt_4c__descr, "LostFocus", THIS, "ValidarDescricaoLostFocus")
996: 
997:             *-- ok.Click do legado
998:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
999:         CATCH TO loc_oErro
1000:             THIS.this_cMensagemErro = loc_oErro.Message
1001:             MsgErro(loc_oErro.Message + CHR(13) + ;
1002:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1003:                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 1236 a 1244:
1236:                         loc_oBusca.this_cTitulo        = loc_cTitulo
1237: 
1238:                         IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
1239:                             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1240:                         ENDIF
1241: 
1242:                         *-- Captions transcritos do AddColuna do legado
1243:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1244:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")


### BO (C:\4c\projeto\app\classes\SigOpLibBO.prg):
*====================================================================
* SigOpLibBO.prg
*
* Business Object de SIGOPLIB - Liberacao de Peso
* (dialogo modal que escolhe o TIPO DE LIBERACAO a ser aplicado e
*  devolve ao form chamador o par codigo + descricao)
*
* Tabela principal : SigCdNcf - chave primaria cods
*
* Origem legado : SIGOPLIB.SCX
*                 tasks\task760\SIGOPLIB_form_codigo_fonte.txt
*
* Chamado por   : form pai que mantem o cursor de trabalho xNensi
*                 (itens da OP, vindos de SigCdNei). O Init do legado
*                 semeia o campo codigo com xNensi.CodnConfs, que eh
*                 SigCdNei.codnconfs char(10) - a MESMA largura de
*                 SigCdNcf.cods char(10).
*
* Consultas do legado espelhadas pelas propriedades abaixo:
*
*   get_codigo.Valid (lista de tipos permitidos ao _Tipo recebido)
*       Select * From SigCdNcf
*        Where (Emps = '<empresa>' Or Emps = ' ')
*          And <Tipos = <Tipo>  quando Tipo esta em (2, 3, 4)>
*          And <Tipos <= <Tipo> nos demais casos>
*       -> cursor CrSigCdNcf, indexado por Cods e por Descs
*
*   get_descr.When (a descricao so eh digitavel em tipo NAO fixo)
*       Select * From SigCdNcf Where cods = '<codigo digitado>'
*       Return (Not Empty(codigo) And CrSigCdNcf.Fixos = 2)
*
* ATENCAO a coluna de empresa (regra #48 do CLAUDE.md): em SigCdNcf
* ela eh "emps", SEM o C inicial - conferido em docs/schema.sql, e eh
* a mesma grafia que o legado usa no Where. NAO trocar por "cemps"
* por analogia com as tabelas mestre: o prefixo da tabela nao decide.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLibBO AS BusinessBase

    *----------------------------------------------------------------
    * Colunas de SigCdNcf (entidade consultada por esta tela)
    * Tipos conferidos em docs/schema.sql:
    *   cods   char(10)      NOT NULL  - PRIMARY KEY sigcdncf_cods
    *   descs  char(60)      NOT NULL
    *   fixos  numeric(1, 0) NOT NULL
    *   tipos  numeric(1, 0) NOT NULL
    *   emps   char(3)       NOT NULL
    *----------------------------------------------------------------

    *-- cods char(10) - codigo do tipo de liberacao (chave primaria).
    *-- Alimenta o Get_codigo da tela e eh a 1a metade do valor que o
    *-- dialogo devolve ao chamador.
    this_cCods = ""

    *-- descs char(60) - descricao do tipo de liberacao.
    *-- Alimenta o Get_descr e eh a 2a metade do valor devolvido.
    *-- Em tipo FIXO (fixos <> 2) o texto vem da tabela; em tipo NAO
    *-- fixo (fixos = 2) o proprio usuario digita, por isso o When do
    *-- Get_descr do legado libera o campo apenas nesse caso.
    this_cDescs = ""

    *-- fixos numeric(1, 0) - decide a origem da descricao.
    *-- NUMERICA de proposito: o legado compara com os literais 2
    *-- ("Fixos <> 2" no Valid do codigo e "Fixos = 2" no When da
    *-- descricao), e coluna numeric(1,0) de mais de uma opcao NAO eh
    *-- booleana - achatar em logico gravaria/leria valor errado.
    this_nFixos = 0

    *-- tipos numeric(1, 0) - faixa de aplicacao do tipo de liberacao.
    *-- Eh a coluna comparada contra o parametro de abertura
    *-- (this_nTipoFiltro) no Where da consulta do Get_codigo.
    *-- NUMERICA pelo mesmo motivo de this_nFixos.
    this_nTipos = 0

    *-- emps char(3) - empresa dona do tipo de liberacao.
    *-- O legado aceita DOIS valores no filtro: a empresa corrente OU
    *-- um unico espaco (" "), que marca o tipo valido para todas as
    *-- empresas - as duas pernas do Or tem de ser transcritas juntas,
    *-- senao os tipos globais desaparecem da lista.
    this_cEmps = ""

    *----------------------------------------------------------------
    * Parametro de abertura do dialogo
    *----------------------------------------------------------------

    *-- ThisForm.Tipo do legado, recebido como _Tipo no Init:
    *--     Tipo = Iif(Type("_Tipo") # 'N', 0, _Tipo)
    *-- ou seja, parametro ausente ou nao-numerico vale ZERO.
    *--
    *-- NOME PROPOSITALMENTE DISTINTO de this_nTipos (a coluna): os
    *-- dois numeros se encontram na MESMA comparacao do Where, e um
    *-- par de nomes separado por uma unica letra convida ao erro de
    *-- digitacao que o compilador nao pega.
    *--
    *-- Governa qual das duas comparacoes entra no Where:
    *--     Tipo em (2, 3, 4)  ->  Tipos =  Tipo   (so a faixa exata)
    *--     qualquer outro     ->  Tipos <= Tipo   (faixa acumulada)
    this_nTipoFiltro = 0

    *-- Semente do campo codigo: no legado,
    *--     ThisForm.Get_codigo.Value = xNensi.CodnConfs
    *-- lida da linha corrente do cursor de trabalho do form PAI.
    *-- Guardada aqui para o form migrado nao depender de cursor
    *-- global do legado, que o sistema novo nao pre-carrega.
    this_cCodigoInicial = ""

    *----------------------------------------------------------------
    * Resultado devolvido ao form chamador
    *----------------------------------------------------------------

    *-- ThisForm.Retorno do legado, que o Unload devolve ao chamador:
    *--     Init                 -> Space(10)
    *--     Valid do codigo      -> cods + Descs   (quando Fixos <> 2)
    *--     Valid da descricao   -> Get_codigo.Value + Get_descr.Value
    *--
    *-- Eh concatenacao POSICIONAL (codigo de 10 + descricao), entao o
    *-- padding do codigo faz parte do valor: montar com PADR sobre a
    *-- largura do schema, nunca com ALLTRIM nas partes (regra #42).
    this_cRetorno = ""

    *----------------------------------------------------------------
    * Estado da ultima consulta
    *----------------------------------------------------------------

    *-- Resultado do "Seek(This.Value, 'CrSigCdNcf', 'Cods')" do
    *-- legado: fica .T. quando o codigo digitado existe na lista
    *-- filtrada, e eh o que decide se o dialogo de escolha precisa
    *-- ser aberto. Eh estado de SESSAO - o dialogo migrado nao fecha
    *-- entre uma consulta e a seguinte, logo tem de ser reposto no
    *-- inicio de cada carga, nunca acumulado.
    this_lRegistroEncontrado = .F.

    *-- Alias do cursor que recebe a lista filtrada de SigCdNcf
    *-- (CrSigCdNcf no legado). Centralizado numa propriedade para que
    *-- carga, indexacao, busca e fechamento usem o MESMO nome.
    this_cCursorNcf = "cursor_4c_SigCdNcf"

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * DODEFAULT() primeiro: eh ele que instancia o DataAccess e zera os
    * flags de edicao da BusinessBase.
    *
    * this_cTabela / this_cCampoChave usam a grafia EXATA do schema
    * (SigCdNcf / cods) - PILAR 2.
    *
    * this_cRetorno nasce com SPACE(10), igual ao "ThisForm.Retorno =
    * Space(10)" do Init legado: dez espacos sao a largura de cods, e eh
    * esse valor que o chamador recebe quando o usuario fecha o dialogo
    * sem escolher nada. A atribuicao fica AQUI e nao no cabecalho da
    * classe porque inicializador de propriedade em DEFINE CLASS aceita
    * constante, nao chamada de funcao.
    *
    * RETURN fica FORA do TRY/CATCH (regra #1): dentro do bloco usa-se a
    * flag loc_lSucesso.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdNcf"
            THIS.this_cCampoChave = "cods"

            *-- Alias da lista filtrada de tipos de liberacao
            THIS.this_cCursorNcf = "cursor_4c_SigCdNcf"

            *-- Colunas da entidade em estado inicial
            THIS.this_cCods  = ""
            THIS.this_cDescs = ""
            THIS.this_nFixos = 0
            THIS.this_nTipos = 0
            THIS.this_cEmps  = ""

            *-- Parametro de abertura: sem chamador, vale ZERO, o que
            *-- deixa o Where na perna "Tipos <= 0"
            THIS.this_nTipoFiltro    = 0
            THIS.this_cCodigoInicial = ""

            *-- Retorno vazio = dez espacos (largura de cods)
            THIS.this_cRetorno = SPACE(10)

            *-- Estado de sessao da consulta
            THIS.this_lRegistroEncontrado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpLibBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia uma linha de cursor_4c_SigCdNcf (ou
    * qualquer alias com as mesmas colunas de SigCdNcf) para as
    * propriedades desta BO.
    *
    * SELECT (par_cAliasCursor) + acesso direto aos campos. NUNCA alcancar
    * o campo escrevendo o nome da VARIAVEL de alias entre parenteses e
    * ponto antes do nome da coluna: eh sintaxe invalida em VFP9
    * (Problema 9) e estoura "Function name is missing )".
    *
    * A frase acima descreve a forma proibida em palavras em vez de
    * mostra-la: o CorretorAutomatico eh comment-blind e o pattern que
    * conserta esse defeito casa o TEXTO CRU do .prg - escrita por extenso,
    * a forma errada era MUTILADA dentro deste proprio comentario a cada
    * sweep (medido em 2026-11-08), e o comentario deixava de ensinar a
    * regra que existe para ensinar.
    *
    * TratarNulo recebe o VALOR PADRAO do tipo da coluna (nao um codigo
    * de tipo): "" para char, 0 para numeric.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCods  = TratarNulo(cods, "")
                THIS.this_cDescs = TratarNulo(descs, "")
                THIS.this_nFixos = TratarNulo(fixos, 0)
                THIS.this_nTipos = TratarNulo(tipos, 0)
                THIS.this_cEmps  = TratarNulo(emps, "")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave primaria de SigCdNcf eh cods.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDPROC

    *====================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() / RegistrarAuditoria()
    * NAO sao sobrescritos nesta BO.
    *
    * O SIGOPLIB.SCX legado nunca grava em SigCdNcf: o Init so CONSULTA a
    * tabela (get_codigo.Valid e get_descr.When sao os dois unicos pontos
    * que tocam o banco, e ambos sao SELECT). SigCdNcf eh mantida por
    * outro cadastro (Natureza/Classificacao Fiscal); este dialogo apenas
    * escolhe um tipo ja existente e devolve o par codigo+descricao ao
    * form chamador via this_cRetorno.
    *
    * Por isso o comportamento padrao herdado de BusinessBase (recusar a
    * operacao, preenchendo this_cMensagemErro) ja eh o correto aqui -
    * nao ha SQL de INSERT/UPDATE/DELETE para reproduzir, e inventar um
    * violaria o PILAR 2 (schema identico, sem gravacoes alem das que o
    * legado faz). RegistrarAuditoria tambem nao se aplica, porque so eh
    * chamada apos Inserir/Atualizar/ExecutarExclusao terem sucesso.
    *====================================================================

    *====================================================================
    * CarregarTiposPermitidos - espelha o SELECT do get_codigo.Valid:
    *
    *   Select * From SigCdNcf
    *    Where (Emps = '<empresa>' Or Emps = ' ')
    *      And <Tipos = <Tipo>  quando Tipo esta em (2, 3, 4)>
    *      And <Tipos <= <Tipo> nos demais casos>
    *
    * Recarrega this_cCursorNcf do zero a cada chamada (o legado tambem
    * reexecuta o SQLEXECUTE a cada Valid) e indexa por Cods e por Descs,
    * igual ao "Index On Cods tag Cods" / "Index On Descs tag descs" do
    * legado - necessario para o SEEK de ValidarCodigoDigitado e para a
    * ordenacao do picker que o form abrira quando nao achar o codigo.
    *====================================================================
    PROCEDURE CarregarTiposPermitidos()
        LOCAL loc_cSQL, loc_cCondTipos, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Limpa a mensagem ANTES de tentar: eh ela que o form usa para
        *-- distinguir "a consulta FALHOU" de "o codigo nao existe no universo
        *-- filtrado" - os dois casos devolvem .F. aqui. Mensagem sobrando de
        *-- uma chamada anterior faria o funil de lookup reportar erro de um
        *-- SELECT que desta vez funcionou.
        *--
        *-- loc_oErro declarado no LOCAL acima: sem a declaracao, o CATCH TO
        *-- cria a variavel como PRIVATE e ela VAZA para quem chamou.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorNcf)
                USE IN (THIS.this_cCursorNcf)
            ENDIF

            IF INLIST(THIS.this_nTipoFiltro, 2, 3, 4)
                loc_cCondTipos = "Tipos = " + FormatarNumeroSQL(THIS.this_nTipoFiltro, 0)
            ELSE
                loc_cCondTipos = "Tipos <= " + FormatarNumeroSQL(THIS.this_nTipoFiltro, 0)
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdNcf " + ;
                "WHERE (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " OR Emps = " + EscaparSQL(" ") + ") " + ;
                "AND " + loc_cCondTipos

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorNcf)

            IF loc_nResultado >= 0 AND USED(THIS.this_cCursorNcf)
                SELECT (THIS.this_cCursorNcf)
                INDEX ON Cods  TAG Cods
                INDEX ON Descs TAG Descs
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar tipos de libera" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarCodigoDigitado - espelha o restante do get_codigo.Valid:
    *
    *   If Not Seek(This.Value, 'CrSigCdNcf', 'Cods')
    *       <abre o picker - responsabilidade do FORM, nao desta BO>
    *   Endif
    *   This.Value = CrSigCdNcf.Cods
    *   If CrSigCdNcf.Fixos <> 2
    *       ThisForm.Get_descr.Value = CrSigCdNcf.Descs
    *       ThisForm.Retorno = CrSigCdNcf.cods + CrSigCdNcf.Descs
    *   Endif
    *
    * Recarrega o universo filtrado (CarregarTiposPermitidos) e faz o
    * SEEK por Cods. Achando, atualiza this_cCods/this_cDescs/this_nFixos
    * /this_nTipos/this_cEmps a partir da linha encontrada e, quando o
    * tipo NAO eh de descricao livre (Fixos <> 2), ja monta o retorno
    * final. Quando Fixos = 2, quem monta o retorno eh
    * ConfirmarDescricaoDigitada, quando o usuario validar a descricao.
    *
    * Retorna .T./.F. (achou/nao achou) para o form decidir se abre o
    * picker (fwBuscaSel/FormBuscaAuxiliar sobre THIS.this_cCursorNcf).
    *====================================================================
    FUNCTION ValidarCodigoDigitado(par_cCodigo)
        LOCAL loc_cCodigo, loc_lAchou
        loc_lAchou = .F.
        THIS.this_lRegistroEncontrado = .F.

        loc_cCodigo = ALLTRIM(NVL(par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN .F.
        ENDIF

        IF !THIS.CarregarTiposPermitidos()
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorNcf)

        *-- PADR ate a largura da COLUNA - SigCdNcf.cods eh char(10) no schema.
        *-- Sem o padding este SEEK NUNCA acha: o config.prg faz SET EXACT ON
        *-- (linha 242) e, sob EXACT ON, o SEEK exige que a expressao tenha o
        *-- tamanho da chave do indice (INDEX ON Cods = 10 chars) - procurar
        *-- "01" numa chave "01        " devolve .F., sem erro e sem log.
        *--
        *-- O legado nao sofria disso por DOIS motivos: rodava com o SET EXACT
        *-- OFF default do VFP, onde o SEEK casa por PREFIXO, e passava
        *-- This.Value, vindo de um campo com InputMask de 10 posicoes.
        *--
        *-- Sintoma de nao padear: o usuario digita um codigo VALIDO, sai do
        *-- campo e o picker abre do mesmo jeito - sempre, para todo codigo com
        *-- menos de 10 caracteres.
        loc_lAchou = SEEK(PADR(loc_cCodigo, 10), THIS.this_cCursorNcf, "Cods")

        IF loc_lAchou
            THIS.this_lRegistroEncontrado = .T.
            THIS.CarregarDoCursor(THIS.this_cCursorNcf)
            THIS.FecharRetornoDoTipo()
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *====================================================================
    * FecharRetornoDoTipo - bloco "If CrSigCdNcf.Fixos <> 2" do
    * get_codigo.Valid legado, na parte que monta o RETORNO:
    *
    *   If CrSigCdNcf.Fixos <> 2
    *       ThisForm.Retorno = CrSigCdNcf.cods + CrSigCdNcf.Descs
    *   Endif
    *
    * Extraido para metodo proprio porque o legado alcanca este mesmo bloco
    * por DOIS caminhos - o Seek que acerta de primeira e a linha que o
    * usuario escolhe no browse -, e no legado os dois executam o MESMO
    * trecho (o browse apenas reposiciona o cursor; a atribuicao que vem
    * depois dele eh uma so). Com a regra de negocio em UM lugar, o form
    * nao precisa reescrever a conta: ele chama este metodo e depois
    * espelha o resultado na tela. Totais/valores derivados tem FONTE
    * UNICA - o BO calcula, o form so exibe.
    *
    * Fixos = 2 (descricao LIVRE) nao mexe no retorno DE PROPOSITO: nesse
    * caso quem o fecha eh ConfirmarDescricaoDigitada, quando o usuario
    * validar a descricao que digitou. Eh o que o legado faz.
    *
    * Concatenacao POSICIONAL (regra #42): this_cCods e this_cDescs vem de
    * cods char(10) / descs char(60) e chegam PADDED do SQL Server - somar
    * os valores CRUS eh exatamente o "CrSigCdNcf.cods + CrSigCdNcf.Descs"
    * do legado. NUNCA ALLTRIM nas partes.
    *
    * PUBLIC (sem PROTECTED): o form chama este metodo de FORA, no caminho
    * em que a linha veio do picker - e metodo protegido em QUALQUER nivel
    * da heranca estoura "Property FECHARRETORNODOTIPO is not found" ao ser
    * chamado de fora (regra #51).
    *====================================================================
    FUNCTION FecharRetornoDoTipo()
        IF THIS.this_nFixos <> 2
            THIS.this_cRetorno = THIS.this_cCods + THIS.this_cDescs
        ENDIF

        RETURN THIS.this_cRetorno
    ENDFUNC

    *====================================================================
    * VerificarDescricaoEditavel - espelha o get_descr.When:
    *
    *   lcCod = ThisForm.Get_codigo.Value
    *   Select * From SigCdNcf Where cods = '<lcCod>'
    *   Return (Not Empty(lcCod) And CrSigCdNcf.Fixos = 2)
    *
    * Consulta NAO FILTRADA por empresa/tipo (so por cods) - por isso usa
    * um cursor temporario proprio, sem tocar em this_cCursorNcf (que
    * continua sendo o universo filtrado do picker). Decide se o campo
    * de descricao do form pode ser digitado (Fixos = 2) ou fica
    * read-only com o texto que vier da tabela.
    *====================================================================
    FUNCTION VerificarDescricaoEditavel(par_cCodigo)
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado, loc_lEditavel, loc_oErro
        loc_lEditavel = .F.

        *-- Mesma razao de CarregarTiposPermitidos: mensagem limpa na entrada e
        *-- loc_oErro declarado para o CATCH TO nao criar PRIVATE que vaza.
        THIS.this_cMensagemErro = ""

        loc_cCodigo = ALLTRIM(NVL(par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_SigCdNcfTmp")
                USE IN cursor_4c_SigCdNcfTmp
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdNcf WHERE cods = " + EscaparSQL(loc_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdNcfTmp")

            IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdNcfTmp")
                SELECT cursor_4c_SigCdNcfTmp
                IF !EOF()
                    loc_lEditavel = (TratarNulo(fixos, 0) = 2)
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigCdNcfTmp")
                USE IN cursor_4c_SigCdNcfTmp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lEditavel = .F.
        ENDTRY

        RETURN loc_lEditavel
    ENDFUNC

    *====================================================================
    * ConfirmarDescricaoDigitada - espelha o get_descr.Valid:
    *
    *   If Not Empty(This.Value)
    *       ThisForm.Retorno = ThisForm.Get_codigo.Value + ThisForm.get_descr.Value
    *   EndIf
    *
    * Concatenacao POSICIONAL (regra #42): this_cCods, vindo do SEEK em
    * cursor_4c_SigCdNcf (coluna cods char(10) do SQL Server), ja chega
    * com a largura de 10 - PADR aqui eh so defesa para o caso de
    * this_cCods ter sido preenchido por outro caminho sem o padding.
    *====================================================================
    FUNCTION ConfirmarDescricaoDigitada(par_cDescricaoDigitada)
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(NVL(par_cDescricaoDigitada, ""))

        IF !EMPTY(loc_cDescricao)
            THIS.this_cDescs   = par_cDescricaoDigitada
            THIS.this_cRetorno = PADR(THIS.this_cCods, 10) + THIS.this_cDescs
        ENDIF

        RETURN THIS.this_cRetorno
    ENDFUNC

ENDDEFINE

