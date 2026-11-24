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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigoptrp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1714 linhas total):

*-- Linhas 182 a 190:
182: *   |------------------------|----------|
183: *   | ConfigurarGrade()      | grd_4c_Dados (GradeOpe) - so o que nao depende de dado (regra #41) |
184: *   | AplicarFormatoGrade()  | PUBLIC, FONTE UNICA de Column.Width/Header1.Caption - reaplicada por CarregarLista (Problema 48) |
185: *   | ConfigurarBotoes()     | cmd_4c_CmdInserir/CmdExcluir/CmdSair/Cancela, nesta ordem (dump) |
186: *   | CarregarLista()        | PUBLIC, funil: BO.CarregarItens() + bind do grid + GO TOP + Refresh |
187: *
188: *   grd_4c_Dados eh EDITAVEL (sem ReadOnly = .T. no grid nem na Column1 -
189: *   diferente do irmao SOMENTE LEITURA FormSigOpTop): cmdInserir insere
190: *   linha em branco e o usuario digita o codigo da transportadora

*-- Linhas 210 a 218:
210: *   Closable/MinButton declarados (regra closable_inventado_tira_a_unica_
211: *   saida), o Alt+F4 continua disponivel como saida enquanto os botoes nao
212: *   estao cablados - mesma decisao do irmao FormSigOpTrf (que tem mais de
213: *   um botao). cmd_4c_Cancela.Cancel = .T. (transcrito do dump) so ativa o
214: *   ESC quando o Click correspondente existir (Fase 7); nao chama Click
215: *   nenhum por si so.
216: *
217: *   A carga inicial (CarregarLista) e pulada em modo teste/validacao de UI
218: *   (padrao FormSigOpTrf/FormSigOpTop): sem gnConnHandle nem operacao, a

*-- Linhas 338 a 346:
338:     *-- Caption do SCX ("Tabelas de Desconto" - literal estatico do Form
339:     *-- Designer, nunca chega a ser exibido) - sobrescrito em
340:     *-- InicializarForm com o codigo da operacao, igual ao legado
341:     *-- (.Caption = 'Transportadoras ' + AllTrim(crSigCdOpe.Dopes))
342:     Caption = "Tabelas de Desconto"
343: 
344:     *-- ControlBox = .F. / Movable = .F. / TitleBar = 0 / ClipControls = .F.
345:     *-- - literais do dump. MaxButton/Closable/MinButton NAO declarados no
346:     *-- SCX -> NAO inventar (regra closable_inventado_tira_a_unica_saida):

*-- Linhas 479 a 489:
479:                 *-- Legado: .ParentForm.Enabled = .f.
480:                 THIS.CarregarContextoFormPai()
481: 
482:                 *-- Legado: .Caption = 'Transportadoras ' +
483:                 *-- AllTrim(crSigCdOpe.Dopes)
484:                 THIS.Caption = "Transportadoras " + ALLTRIM(THIS.this_cDopes)
485: 
486:                 THIS.this_oBusinessObject.this_cTituloDialogo = THIS.Caption
487: 
488:                 *-- Fundo do form (Picture do SCX)
489:                 THIS.ConfigurarDecoracao()

*-- Linhas 586 a 594:
586:     *              Tahoma 16 bold, WordWrap=.T., Alignment=0, BackStyle=0
587:     *
588:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
589:     * ("Transportadoras <operacao>"), por isso .Caption = THIS.Caption
590:     * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
591:     * do Form Designer, nunca chega a ser exibido.
592:     *
593:     * Width do container usa THIS.Width (padrao canonico da faixa, regra
594:     * #11), igual ao literal do dump (800 = Form.Width, sem divergencia

*-- Linhas 607 a 662:
607:         *-- Container da faixa (cntSombra)
608:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
609:         WITH THIS.cnt_4c_Cabecalho
610:             .Top           = 0
611:             .Left          = 0
612:             .Width         = THIS.Width
613:             .Height        = 80
614:             .BorderWidth   = 0
615:             .BackStyle     = 1
616:             .BackColor     = RGB(100, 100, 100)
617:             .SpecialEffect = 0
618:             .Visible       = .T.
619:         ENDWITH
620: 
621:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
622:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
623:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
624:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
625:             .AutoSize      = .F.
626:             .FontBold      = .T.
627:             .FontName      = "Tahoma"
628:             .FontSize      = 16
629:             .FontUnderline = .F.
630:             .WordWrap      = .T.
631:             .Alignment     = 0
632:             .BackStyle     = 0
633:             .Caption       = THIS.Caption
634:             .Top           = 25
635:             .Left          = 10
636:             .Width         = THIS.Width - 20
637:             .Height        = 40
638:             .ForeColor     = RGB(0, 0, 0)
639:             .Rotation      = 0
640:             .Visible       = .T.
641:         ENDWITH
642: 
643:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
644:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
645:         *-- regra #12)
646:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
647:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
648:             .AutoSize  = .F.
649:             .FontBold  = .T.
650:             .FontName  = "Tahoma"
651:             .FontSize  = 16
652:             .WordWrap  = .T.
653:             .Alignment = 0
654:             .BackStyle = 0
655:             .Caption   = THIS.Caption
656:             .Top       = 24
657:             .Left      = 10
658:             .Width     = THIS.Width - 20
659:             .Height    = 46
660:             .ForeColor = RGB(255, 255, 255)
661:             .Rotation  = 0
662:             .Visible   = .T.

*-- Linhas 692 a 701:
692:             .ColumnCount   = 2
693:             .FontName      = "Tahoma"
694:             .FontSize      = 8
695:             .Top           = 87
696:             .Left          = 236
697:             .Height        = 307
698:             .Width         = 313
699:             .RowHeight     = 16
700:             .ScrollBars    = 2
701:             .TabIndex      = 1

*-- Linhas 758 a 766:
758:                 .Column1.Resizable         = .F.
759:                 .Column1.FontName          = "Tahoma"
760:                 .Column1.FontSize          = 8
761:                 .Column1.Header1.Caption   = "Transportadora"
762:                 .Column1.Header1.FontName  = "Tahoma"
763:                 .Column1.Header1.FontSize  = 8
764:                 .Column1.Header1.Alignment = 2
765:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
766:                 .Column1.Text1.BorderStyle = 0

*-- Linhas 788 a 796:
788:                 .Column2.FontName          = "Tahoma"
789:                 .Column2.FontSize          = 8
790:                 .Column2.ReadOnly          = .T.
791:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
792:                 .Column2.Header1.FontName  = "Tahoma"
793:                 .Column2.Header1.FontSize  = 8
794:                 .Column2.Header1.Alignment = 2
795:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
796:                 .Column2.Text1.BorderStyle = 0

*-- Linhas 830 a 838:
830:     * atribuido se o arquivo existir - .Picture inexistente falha em
831:     * SILENCIO (regra #25).
832:     *
833:     * cmd_4c_Cancela.Cancel = .T. eh transcrito do dump, mas so ativa o ESC
834:     * de fato quando o Click correspondente existir (Fase 7) - sem
835:     * BINDEVENT, a propriedade por si so nao chama Click nenhum.
836:     *
837:     * NENHUM BINDEVENT de Click aqui - fica para a Fase 7 (ver cabecalho
838:     * do arquivo). ControlBox = .F. mas sem Closable/MinButton declarados

*-- Linhas 853 a 868:
853:             loc_cIconeCancelar  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
854:         ENDIF
855: 
856:         *-- cmdInserir -> cmd_4c_CmdInserir (linha nova em xOpe)
857:         THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
858:         WITH THIS.cmd_4c_CmdInserir
859:             .Top          = 4
860:             .Left         = 500
861:             .Width        = 75
862:             .Height       = 75
863:             .Caption      = "\<Inserir"
864:             .TabIndex     = 4
865:             .FontName     = "Comic Sans MS"
866:             .FontSize     = 8
867:             .FontBold     = .T.
868:             .FontItalic   = .T.

*-- Linhas 882 a 897:
882:             .Visible = .T.
883:         ENDWITH
884: 
885:         *-- cmdExcluir -> cmd_4c_CmdExcluir (apaga a linha corrente de xOpe)
886:         THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
887:         WITH THIS.cmd_4c_CmdExcluir
888:             .Top          = 4
889:             .Left         = 575
890:             .Width        = 75
891:             .Height       = 75
892:             .Caption      = "\<Excluir"
893:             .TabIndex     = 2
894:             .FontName     = "Comic Sans MS"
895:             .FontSize     = 8
896:             .FontBold     = .T.
897:             .FontItalic   = .T.

*-- Linhas 911 a 926:
911:             .Visible = .T.
912:         ENDWITH
913: 
914:         *-- cmdSair ("Confirmar") -> cmd_4c_CmdSair (grava o lote)
915:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
916:         WITH THIS.cmd_4c_CmdSair
917:             .Top          = 4
918:             .Left         = 650
919:             .Width        = 75
920:             .Height       = 75
921:             .Caption      = "\<Confirmar"
922:             .TabIndex     = 7
923:             .FontName     = "Comic Sans MS"
924:             .FontSize     = 8
925:             .FontBold     = .T.
926:             .FontItalic   = .T.

*-- Linhas 940 a 955:
940:             .Visible = .T.
941:         ENDWITH
942: 
943:         *-- Cancela -> cmd_4c_Cancela (so reabilita o pai e libera o dialogo)
944:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
945:         WITH THIS.cmd_4c_Cancela
946:             .Top          = 4
947:             .Left         = 725
948:             .Width        = 75
949:             .Height       = 75
950:             .Caption      = "Cancelar"
951:             .Cancel       = .T.
952:             .TabIndex     = 8
953:             .FontName     = "Comic Sans MS"
954:             .FontSize     = 8
955:             .FontBold     = .T.

*-- Linhas 981 a 992:
981:     * SILENCIO.
982:     *==========================================================================
983:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
984:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
985:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
986:         BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
987:         BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
988:     ENDPROC
989: 
990:     *==========================================================================
991:     * CarregarLista - funil de carga da grade. Reproduz o trecho final do
992:     * Init legado:


### BO (C:\4c\projeto\app\classes\SigoptrpBO.prg):
*==============================================================================
* SIGOPTRPBO.PRG
* Business Object do dialogo "Transportadoras" (SIGOPTRP), aberto pelo form
* pai de Cadastro de Operacoes (SigCdOpe) via
* "Do Form Sigoptrp With ThisForm, nDataSession", NAO acessivel direto pelo
* menu.
*
* Tabela persistida : SigOpTrp  (transportadoras habilitadas para a operacao)
* Chave Real (PK)    : cidchaves - gerada com fUniqueIds() ao inserir (regra
*                       #22 do CLAUDE.md - NUNCA string vazia, senao a 2a
*                       linha colide no indice unico)
* Colunas da tabela  : dopes, itras, cidchaves (lista tirada literalmente do
*                       "Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves)
*                       Values (...)" do legado - ver NOTA DE SCHEMA abaixo)
*
* NOTA DE SCHEMA (regra #14 do CLAUDE.md): a tabela SigOpTrp NAO aparece em
* docs/schema.sql (conferido com Get-Content -Raw -Encoding Unicode, que
* respeita o BOM UTF-16 - zero ocorrencias de "OpTrp" no arquivo inteiro,
* contra SigOpTrf/SigPrTrp/SigIvTrp/SIGFITRP que existem). O legado
* (Sigoptrp_form_codigo_fonte.txt) usa o nome "SigOpTrp" de forma consistente
* em TRES pontos (AddCursor, Insert Into CrSigOpTrp, Delete From SigOpTrp) -
* nao ha divergencia de grafia dentro do proprio legado, nem tabela com nome
* parecido que sugira erro de digitacao do migrador. Por isso o nome foi
* mantido EXATO, igual ao legado (PILAR 2) - a ausencia no snapshot do
* schema e uma divergencia de BANCO/ambiente (tabela pode ter sido criada
* depois do snapshot), nao um erro de migracao a corrigir trocando o nome.
*
* NATUREZA DESTE DIALOGO (lido do legado, Sigoptrp_form_codigo_fonte.txt):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe, lista
*   de operacoes) e pnDataSes e a DataSession do pai - o dialogo faz
*   "Set DataSession to pnDataSes" para conseguir ler crSigCdOpe (cursor do
*   pai) diretamente, antes de abrir a propria DataSession = 2 privada
*   (mesmo padrao de SigOpTrf/SigOpTop - FormSigOpTrf usa DataSession = 1
*   compartilhada no migrado, em vez de trocar de sessao manualmente).
*
*   O Caption e montado como:
*     'Transportadoras ' + AllTrim(crSigCdOpe.Dopes)
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Uma unica grade (GradeOpe, 2 colunas) <- xOpe (Dopes C(20), Itras C(10),
*   Razaos C(40)) - cursor LOCAL editavel, carregado no Init a partir das
*   linhas ja gravadas em SigOpTrp para esta operacao (JOIN com SigPrTrp
*   para resolver a descricao):
*     lcSql = "Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
*              Where a.Dopes = '<crSigCdOpe.Dopes>' And a.Itras = b.Itras"
*   Column1.Text1 (Itras) tem Valid com lookup fwbuscaext em SigPrTrp pela
*   chave Itras - achando, preenche Razaos (xOpe.Razaos); vazio, limpa o
*   campo. Column2.Text1 (Razaos) tem When = Return .F. - e SOMENTE EXIBICAO,
*   nunca editado digitando, NUNCA persistido em SigOpTrp (so aparece no
*   SELECT acima via JOIN) - mesmo papel do this_cDpros em SigOpTrfBO.
*
*   cmdInserir: Insert Into xOpe (Itras) Values (Space(10)) - acrescenta
*   linha em branco na grade e foca a coluna do codigo; marca GravaDados.
*
*   cmdExcluir: apaga a linha corrente de xOpe (Delete + Skip); marca
*   GravaDados.
*
*   cmdSair (Caption "Confirmar"): SE GravaDados -> valida que nao ha
*   Itras duplicado entre as linhas nao-vazias de xOpe (Group By Itras
*   Having Sum(1) > 1 -> aborta com MessageBox se achar); senao, apaga TODAS
*   as linhas de SigOpTrp desta operacao (Delete From SigOpTrp Where
*   dopes = '<crSigCdOpe.Dopes>') e regrava uma linha por xOpe.Itras
*   nao-vazio (Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves) Values
*   (crSigCdOpe.Dopes, xOpe.Itras, fUniqueIds())), via
*   poDatamgr.UpDate('CrSigOpTrp') + Commit() dentro de TRY/CATCH com
*   RollBack no erro - mesmo padrao "apaga tudo da operacao e reinsere" do
*   SigOpTrfBO (regra #22 do CLAUDE.md - cidchaves SEMPRE fUniqueIds(),
*   nunca string vazia). Confirmar reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Cancela: so reabilita o form pai e libera o dialogo, SEM gravar nada
*   (equivalente ao Cancelar do SigOpTrfBO - nenhuma chamada ao BO).
*
*   Por isso este BO sobrescreve Inserir() (fase seguinte) operando sobre
*   UMA linha por vez (identificada por cidchaves), que o fluxo de gravacao
*   em lote do Confirmar (fases seguintes) vai chamar em loop, uma vez por
*   linha nao-vazia de xOpe, dentro do "apaga tudo e reinsere" do legado.
*   NAO sobrescreve Atualizar() nem ExecutarExclusao(): nao ha alteracao nem
*   exclusao unitaria no legado - a remocao de uma linha e so o efeito
*   colateral de ela nao ser reinserida no lote seguinte, igual ao
*   SigOpTrfBO.
*==============================================================================

DEFINE CLASS SigoptrpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado, cursor do form pai)
    * Operacao cujas transportadoras habilitadas estao sendo editadas.
    * this_cDopes e usado tanto como filtro da carga quanto como o valor da
    * coluna "dopes" de cada linha gravada em SigOpTrp (as duas coisas sao
    * sempre o mesmo codigo, por desenho deste dialogo - mesmo papel do
    * SigOpTrfBO).
    *--------------------------------------------------------------------------
    this_cDopes          = ""  && SigCdOpe.Dopes CHAR(20) - operacao (contexto, vindo do form pai)
    this_cTituloDialogo  = ""  && Caption montado: "Transportadoras " + this_cDopes

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA GRADE (xOpe / SigOpTrp + SigPrTrp)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""  && cidchaves - PK, gerada com fUniqueIds() ao inserir
    this_cItras     = ""  && itras  CHAR(10) - codigo da transportadora (SigPrTrp.Itras)
    this_cRazaos    = ""  && razaos CHAR(40) - descricao da transportadora (SigPrTrp.Razaos) - SOMENTE EXIBICAO, NAO persistida em SigOpTrp

    *--------------------------------------------------------------------------
    * CURSOR DE TRABALHO - nome fixo, populado pelo BO nas fases seguintes.
    * Nunca e SQLEXEC direto no cursor ligado ao Grid (regra do CLAUDE.md
    * sobre SQLEXEC derrubar ColumnCount de Grid) - carga via cursor
    * temporario + ZAP/APPEND FROM DBF(), mesmo padrao do SigOpTrfBO.
    *--------------------------------------------------------------------------
    this_cCursorItens = "cursor_4c_Itens"  && xOpe no legado - Dopes C(20), Itras C(10), Razaos C(40)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_lDadosAlterados = .F.  && ThisForm.GravaDados no legado - .T. quando algo foi incluido/excluido e precisa regravar ao Confirmar
    this_nTotalItens      = 0   && RECCOUNT de this_cCursorItens apos a carga

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * this_cTabela/this_cCampoChave apontam para a tabela REALMENTE gravada
    * por este dialogo (SigOpTrp) - ver NOTA DE SCHEMA no cabecalho do
    * arquivo sobre a ausencia dela em docs/schema.sql.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpTrp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cDopes         = ""
            THIS.this_cTituloDialogo = ""

            THIS.this_cCidChaves = ""
            THIS.this_cItras     = ""
            THIS.this_cRazaos    = ""

            THIS.this_lDadosAlterados = .F.
            THIS.this_nTotalItens     = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da linha de SigOpTrp (cidchaves).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dopes/itras/razaos da linha corrente de um
    * alias no formato de this_cCursorItens (xOpe no legado - Dopes C(20),
    * Itras C(10), Razaos C(40)). Razaos e SOMENTE EXIBICAO (resolvida via
    * JOIN com SigPrTrp em CarregarItens), nunca persistida em SigOpTrp - ver
    * cabecalho do arquivo.
    *
    * this_cCidChaves e SEMPRE zerado aqui: xOpe nao tem essa coluna (o
    * legado regrava cidchaves do ZERO com fUniqueIds() a cada Confirmar,
    * para TODAS as linhas - nunca preserva a PK antiga, mesmo quando a
    * linha ja existia). Quem for persistir esta linha (Inserir, fase
    * seguinte) gera a PK nova sozinho.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cDopes     = TratarNulo(dopes, "")
        THIS.this_cItras     = TratarNulo(itras, "")
        THIS.this_cRazaos    = TratarNulo(razaos, "")
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma transportadora habilitada em SigOpTrp.
    * cidchaves (PK real, regra #22 do CLAUDE.md) e gerado com fUniqueIds()
    * quando ainda nao foi atribuido - NUNCA string vazia, senao a 2a linha
    * do lote colide no indice unico. O fluxo de gravacao em lote do
    * Confirmar (PersistirItens, fase seguinte) zera this_cCidChaves antes
    * de chamar Inserir() para cada linha nao-vazia de xOpe, reproduzindo o
    * "Zap + Scan ... Insert ... fUniqueIds()" do legado - cidchaves NUNCA e
    * reaproveitado de uma gravacao anterior.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTrp (cidchaves, dopes, itras)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cItras) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagarItensDaOperacao - apaga TODAS as transportadoras ja gravadas em
    * SigOpTrp para a operacao corrente (this_cDopes). Equivale ao
    * "Select CrSigOpTrp / Zap" do cmdSair.Click legado (a view CrSigOpTrp e
    * o AddCursor sem filtro em SigOpTrp - mas o DELETE aqui, ao contrario do
    * legado, filtra explicitamente por dopes, porque este BO fala com o SQL
    * Server direto, sem a AddCursor/UpDate/Commit do poDatamgr).
    *
    * Primitiva do "apaga tudo e regrava" que o Confirmar faz em lote
    * (FormSigoptrp.PersistirItens, fase seguinte) ANTES de reinserir uma
    * linha por item nao-vazio de xOpe. O legado NAO tem exclusao unitaria
    * de item (cmdExcluir so apaga da grade local xOpe, nunca de SigOpTrp
    * direto), e por isso este BO nao sobrescreve ExecutarExclusao() -
    * Excluir() por cidchaves nao serviria aqui, porque o cidchaves exibido
    * na grade nunca foi persistido (ver CarregarDoCursor).
    *
    * Esta no BO, e nao no Form, porque eh SQL (PILAR 3 - arquitetura em
    * camadas): o Form orquestra o lote, o BO fala com o banco.
    *
    * A auditoria de um DELETE em LOTE nao tem uma PK unica para registrar,
    * entao a chave logada eh o codigo da OPERACAO - que eh o que identifica
    * o conjunto afetado. this_cCidChaves eh preservado e reposto: ele
    * pertence a linha corrente, nao a este comando.
    *
    * EscaparSQL(this_cDopes) com o valor ALLTRIM'd eh a mesma forma usada
    * em CarregarItens: dopes eh CHAR(20) e o SQL Server compara CHAR com
    * blank-padding ANSI, entao o WHERE casa com o valor gravado (ALLTRIM na
    * chave INTEIRA eh inofensivo - regra #42 proibe ALLTRIM nas PARTES de
    * chave concatenada, que nao eh o caso).
    *
    * O RETURN de guarda fica FORA do TRY e o RETURN final eh unico
    * (regra #1).
    *
    * Metodo PUBLIC: chamado pelo Form (PersistirItens) e pelo harness de
    * teste - metodo que o form chama de fora NUNCA pode ser PROTECTED
    * (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE ApagarItensDaOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveAnterior, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigOpTrp" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                *-- Auditoria do lote pela operacao (ver cabecalho do metodo)
                loc_cChaveAnterior   = THIS.this_cCidChaves
                THIS.this_cCidChaves = ALLTRIM(THIS.this_cDopes)
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_cCidChaves = loc_cChaveAnterior

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao apagar as transportadoras:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao apagar as transportadoras:" + CHR(13) + loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresTrabalho - fecha o cursor de trabalho (regra #52 -
    * TABLEREVERT so quando ha buffering, senao dispara o erro 1586).
    * Chamado no INICIO de CarregarItens (reentrancia - este dialogo pode
    * ser aberto mais de uma vez na mesma sessao do processo) e pelo
    * Destroy do Form (teardown final).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresTrabalho()
        IF VARTYPE(THIS.this_cCursorItens) = "C" AND !EMPTY(THIS.this_cCursorItens) ;
                AND USED(THIS.this_cCursorItens)
            IF CURSORGETPROP("Buffering", THIS.this_cCursorItens) > 1
                TABLEREVERT(.T., THIS.this_cCursorItens)
            ENDIF
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - carga inicial do dialogo (trecho principal do Init
    * legado): popula this_cCursorItens (xOpe) a partir das transportadoras
    * ja habilitadas para a operacao corrente, resolvendo a descricao via
    * JOIN com SigPrTrp.
    *
    *   Legado (Init):
    *     lcSql = [Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
    *              Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.Itras = b.Itras]
    *     ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
    *     Select CsSelecao
    *     Scan
    *         Scatter Memvar
    *         Select xOpe
    *         Append Blank
    *         Gather Memvar
    *     EndScan
    *
    * O JOIN (a.Itras = b.Itras, sem OUTER) e DE PROPOSITO: so entra na
    * grade transportadora que EXISTE em SigPrTrp - mesma regra que o Valid
    * do Column1.Text1 aplica ao digitar (fwbuscaext em SigPrTrp). xOpe nao
    * tem coluna cidchaves (ver CarregarDoCursor) porque o legado nunca
    * preserva a PK antiga ao regravar.
    *
    * FecharCursoresTrabalho() no INICIO garante reentrancia - o CREATE
    * CURSOR abaixo estouraria "Cursor ja existe" se this_cCursorItens ja
    * estivesse aberto de uma chamada anterior.
    *
    * Metodo PUBLIC: chamado pelo Form (CarregarLista, fase seguinte) e pelo
    * harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cAliasTemp, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresTrabalho()

            loc_cAliasTemp = "cursor_4c_ItensTemp"

            loc_cSQL = "SELECT a.dopes, a.itras, b.razaos" + ;
                       " FROM SigOpTrp a, SigPrTrp b" + ;
                       " WHERE a.dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " AND a.itras = b.itras"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar transportadoras:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ELSE
                *-- xOpe: cursor LOCAL editavel (Insert/Delete direto da
                *-- grade, nunca SQLEXEC nele - regra do CLAUDE.md sobre
                *-- SQLEXEC derrubar Grid.ColumnCount)
                CREATE CURSOR (THIS.this_cCursorItens) (Dopes C(20), Itras C(10), Razaos C(40))
                INDEX ON Dopes TAG Dopes
                SET ORDER TO

                IF USED(loc_cAliasTemp)
                    SELECT (loc_cAliasTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) (Dopes, Itras, Razaos) ;
                            VALUES (TratarNulo(dopes, ""), TratarNulo(itras, ""), TratarNulo(razaos, ""))
                    ENDSCAN
                    USE IN (loc_cAliasTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                SET ORDER TO
                GO TOP

                THIS.this_nTotalItens = RECCOUNT(THIS.this_cCursorItens)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar transportadoras:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

