# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GEROPERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column1.ControlSource = ""
	.DeleteMark   	   = .f.
	.Column1.ControlSource 	 = [LocalSacOp.Selecionada]
	.Column2.ControlSource   = [LocalSacOp.Dopes]
	Select LocalSacOp
Select LocalSacOp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLop.prg) - TRECHOS RELEVANTES PARA PASS SQL (1331 linhas total):

*-- Linhas 459 a 482:
459:     *
460:     * Chamado DUAS vezes e de proposito: uma antes de existir Grid (pelo
461:     * InicializarForm) e outra a cada passagem por MontaGrade, que eh quem
462:     * binda. Column.ControlSource apontando para alias inexistente estoura
463:     * "Alias is not found" dentro do TRY do InicializarForm, o CREATEOBJECT
464:     * devolve .F. e a tela simplesmente nao abre; e o cursor do pai pode ser
465:     * aberto DEPOIS de a estrutura montar, caso em que a grade tem de passar a
466:     * le-lo. O BO resolve qual alias vale (LocalSacOp do pai, quando aberto) e,
467:     * nao havendo nenhum, cria o espelho VAZIO com as sete colunas do Select
468:     * legado - sem inventar linha alguma, porque sem o form pai nao ha Operacao
469:     * a exibir.
470:     *
471:     * this_lGradeEditavel guarda se esse alias aceita REPLACE: eh o que o
472:     * CheckBox da Column1 precisa para alternar a coluna Selecionada, e eh o
473:     * que permite AVISAR em vez de o clique ficar sem efeito.
474:     *==========================================================================
475:     PROCEDURE PrepararAliasGrade()
476:         LOCAL loc_oErro
477: 
478:         TRY
479:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
480:                 THIS.this_cAliasGrade    = THIS.this_oBusinessObject.GarantirCursorGrade()
481:                 THIS.this_lGradeEditavel = THIS.this_oBusinessObject.GradeEditavel(THIS.this_cAliasGrade)
482:             ENDIF

*-- Linhas 581 a 647:
581:     * ConfigurarGrade - cria grd_4c_Dados (grdOperacoes do legado)
582:     *
583:     * SCX: grdOperacoes ColumnCount=2 Top=85 Left=96 Width=198 Height=220
584:     *      FontName="Tahoma" DeleteMark=.F. ScrollBars=2 TabIndex=2
585:     *      GridLineColor=238,238,238
586:     * O Init legado acrescenta em RUNTIME: RecordSource=[LocalSacOp],
587:     * HeaderHeight=19, RecordMark=.F., ReadOnly=.F., AllowHeaderSizing=.F.,
588:     * AllowRowSizing=.F., os dois ControlSource e a formatacao das colunas.
589:     *
590:     * Top=85 fica logo ABAIXO da faixa do cabecalho (0..80) e Top+Height=305
591:     * cabe nos 318 de altura do form - nao ha nada a deslocar.
592:     *
593:     * FontSize nao esta no dump do grid, mas a tabela de fontes do SCX registra
594:     * "Tahoma, 0, 8" e o proprio form eh Tahoma 8: 8 eh o tamanho efetivo do
595:     * legado, nao um palpite. Sem declarar, valeria o default da classe base.
596:     *
597:     * RowHeight NAO eh declarado porque o legado tambem nao declara - o default
598:     * do VFP9 eh o que o usuario via.
599:     *
600:     * ORDEM OBRIGATORIA (medida no VFP9 em 2026-11-08, task758/FormSigOpLcZ):
601:     * ColumnCount -> RecordSource -> ControlSource de TODAS as colunas -> SO
602:     * DEPOIS o AddObject do CheckBox -> Sparse/CurrentControl -> Width/Header.
603:     * Grid cuja RecordSource ainda nao foi atribuida AUTO-BINDA na area de
604:     * trabalho CORRENTE no instante em que o ColumnCount eh definido; se a
605:     * coluna sorteada for CHARACTER, o AddObject de um CheckBox (cujo .Value
606:     * nasce NUMERICO) estoura "Data type mismatch" DENTRO do TRY do
607:     * InicializarForm - CREATEOBJECT devolve o logico .F., o
608:     * IF VARTYPE(loForm) = "O" de quem abre nao entra e A TELA NAO ABRE, sem
609:     * erro na tela e sem nada em log. Por isso a sequencia inteira mora no
610:     * funil MontaGrade(), e aqui so se cria o Grid e se chama o funil - assim a
611:     * ordem certa vale tambem nas repinturas, nao so na montagem.
612:     *
613:     * Atribuir RecordSource/ControlSource reseta Width, Header1.Caption e
614:     * CurrentControl para o default (Problema 48 / regra #18), que eh a outra
615:     * razao de a formatacao viver depois do bind, no mesmo funil.
616:     *==========================================================================
617:     PROTECTED PROCEDURE ConfigurarGrade()
618:         LOCAL loc_oGrid, loc_oErro
619: 
620:         TRY
621:             THIS.AddObject("grd_4c_Dados", "Grid")
622:             loc_oGrid = THIS.grd_4c_Dados
623: 
624:             WITH loc_oGrid
625:                 .Top               = 85
626:                 .Left              = 96
627:                 .Width             = 198
628:                 .Height            = 220
629:                 .FontName          = "Tahoma"
630:                 .FontSize          = 8
631:                 .HeaderHeight      = 19
632:                 .DeleteMark        = .F.
633:                 .RecordMark        = .F.
634:                 .ReadOnly          = .F.
635:                 .ScrollBars        = 2
636:                 .AllowHeaderSizing = .F.
637:                 .AllowRowSizing    = .F.
638:                 .GridLineColor     = RGB(238, 238, 238)
639:                 .ColumnCount       = 2
640:             ENDWITH
641: 
642:             *-- TabIndex = 2 vem do dump. O container do cabecalho eh o
643:             *-- controle 1 e a grade eh o 2, entao a atribuicao confirma a
644:             *-- ordem do legado em vez de inventar outra.
645:             loc_oGrid.TabIndex = 2
646: 
647:             *-- Bind + CheckBox + formatacao, na ordem provada acima

*-- Linhas 742 a 775:
742:     * Transcreve o bloco "With ThisForm.grdOperacoes ... EndWith" do Init
743:     * legado, que eh onde a grade se liga ao cursor:
744:     *     .RecordSource          = [LocalSacOp]
745:     *     .Column1.ControlSource = [LocalSacOp.Selecionada]
746:     *     .Column2.ControlSource = [LocalSacOp.Dopes]
747:     *
748:     * O alias eh RE-RESOLVIDO a cada passagem por PrepararAliasGrade(): o
749:     * cursor do pai (LocalSacOp) pode ter sido aberto DEPOIS de esta tela
750:     * montar a estrutura, e nesse caso a grade tem de passar a le-lo em vez de
751:     * continuar no espelho vazio cursor_4c_Operacoes.
752:     *
753:     * Ponto UNICO de proposito: grade ligada a cursor NAO se repinta sozinha
754:     * quando o cursor muda (regra #21), e sem um funil cada caminho esquece uma
755:     * das metades. Os tres passos - bind, CheckBox, formatacao - precisam
756:     * acontecer SEMPRE nessa ordem (ver cabecalho de ConfigurarGrade).
757:     *
758:     * GO TOP IN + Refresh fecham o metodo porque eh isso que faz a grade
759:     * EXIBIR as linhas que o cursor passou a ter. GO TOP **IN** (sem SELECT) de
760:     * proposito: SELECT trocaria a area de trabalho corrente, que eh justamente
761:     * o que dispara o auto-bind medido em ConfigurarGrade.
762:     *
763:     * PUBLIC: eh funil, acionado pelos handlers e pelo harness de teste, que
764:     * chama metodos do form de FORA da classe (regra #3).
765:     *
766:     * par_cFiltro NAO existe no legado e NAO eh usado: esta declarado porque o
767:     * harness TesteAutomatico trata todo metodo chamado "MontaGrade" como se
768:     * recebesse um codigo e sempre invoca com 1 argumento - sem o parametro,
769:     * VFP9 estoura "No PARAMETER statement is found". As chamadas internas
770:     * (THIS.MontaGrade()) seguem validas sem argumento.
771:     *==========================================================================
772:     PROCEDURE MontaGrade(par_cFiltro)
773:         LOCAL loc_oGrid, loc_cCursor, loc_lSucesso
774: 
775:         loc_lSucesso = .F.

*-- Linhas 782 a 808:
782: 
783:                 loc_oGrid.RecordSource = loc_cCursor
784: 
785:                 loc_oGrid.Column1.ControlSource = loc_cCursor + ".Selecionada"
786:                 loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dopes"
787: 
788:                 *-- SO AGORA o CheckBox pode entrar/voltar: a Column1 acabou de
789:                 *-- ser ligada a coluna NUMERICA Selecionada, e eh esse bind que
790:                 *-- impede o "Data type mismatch" no AddObject. Idempotente.
791:                 THIS.GarantirCheckBoxSelecao()
792: 
793:                 *-- RecordSource/ControlSource acabaram de resetar Width,
794:                 *-- Header1.Caption e CurrentControl - reaplicar SEMPRE depois
795:                 THIS.FormatarGridOperacoes(loc_oGrid)
796: 
797:                 GO TOP IN (loc_cCursor)
798:                 loc_oGrid.Refresh()
799: 
800:                 *-- A grade acabou de trocar de alias e de linha corrente: o BO
801:                 *-- precisa passar a enxergar ESSA linha, senao as properties
802:                 *-- dele continuam descrevendo a linha (ou o cursor) anterior.
803:                 THIS.FormParaBO()
804: 
805:                 loc_lSucesso = .T.
806:             ENDIF
807:         ENDIF
808: 

*-- Linhas 829 a 847:
829:     * dos dois e arriscar divergir do que o usuario via.
830:     *
831:     * Chamado por MontaGrade SEMPRE depois do bind: atribuir RecordSource/
832:     * ControlSource reseta Width e Header1.Caption para o default 90/"Header1"
833:     * (Problema 48) e derruba o CurrentControl da Column1 (regra #18) - a grade
834:     * apareceria com colunas quadradas, cabecalho "Header1" e o valor cru 0/1
835:     * no lugar do CheckBox.
836:     *
837:     * Sparse = .F. eh o que faz o CheckBox aparecer em TODAS as linhas; sem ele
838:     * so a linha ativa o desenha e as outras mostram 0/1 como texto.
839:     *
840:     * Column1.ReadOnly vem DEPOIS do Grid.ReadOnly (regra #18): o do grid
841:     * propaga para as colunas e sobrescreveria este valor. Grid.ReadOnly eh
842:     * atribuido em ConfigurarGrade, que roda antes deste metodo.
843:     *==========================================================================
844:     PROTECTED PROCEDURE FormatarGridOperacoes(par_oGrid)
845:         LOCAL loc_oGrid
846: 
847:         IF VARTYPE(par_oGrid) = "O"

*-- Linhas 904 a 926:
904:     *
905:     * Esta tela NAO consulta o banco: a grade esta ligada ao cursor LocalSacOp,
906:     * criado e populado por QUEM abre o dialogo (sigatsac.gerarope no legado)
907:     * ANTES do CREATEOBJECT. O Init legado so BINDA - nao ha Select nenhum
908:     * nele. Portanto o equivalente de "carregar a lista" aqui eh re-resolver o
909:     * alias e repintar, que eh o que MontaGrade faz.
910:     *
911:     * A consulta do legado (Select ... From SigCdSOp Where Codigos = <dep> And
912:     * GerOpers = 1) esta portada em SigOpLopBO.CarregarOperacoes(), para quem
913:     * precisar montar o cursor por fora; ela NAO eh chamada daqui porque o Init
914:     * desta tela recebe apenas o form pai (LParameters pFrm) e nao conhece o
915:     * codigo do departamento - inventar uma origem para esse codigo seria
916:     * inventar regra de negocio.
917:     *
918:     * PUBLIC: o harness de teste chama CarregarLista de FORA da classe, e
919:     * PEMSTATUS devolve .T. para metodo PROTECTED (testa existencia, nao
920:     * escopo) - o teste entraria no branch e a chamada falharia (regra #3).
921:     *==========================================================================
922:     PROCEDURE CarregarLista()
923:         RETURN THIS.MontaGrade()
924:     ENDPROC
925: 
926:     *==========================================================================

*-- Linhas 1013 a 1031:
1013:     *      MEDIDO no probe (2026-11-08): escrever no CheckBox
1014:     *      (chk_4c_Check1.Value) NAO serve. Em grade nao renderizada o valor
1015:     *      atribuido se perde no Refresh seguinte (o probe leu 0 com a linha
1016:     *      marcada em 1), e escrita em controle com ControlSource propaga para
1017:     *      o cursor sem passar por guarda nenhuma. Por isso a gravacao eh
1018:     *      REPLACE explicito no alias, com o tipo da coluna normalizado como o
1019:     *      BO faz (coluna de marcacao chega Numerica ou Logica conforme a
1020:     *      origem do cursor - regra #13).
1021:     *   2. O REFRESH - grade ligada a cursor NAO se repinta sozinha quando o
1022:     *      cursor muda (regra #21); sem ele a coluna continua desenhando o
1023:     *      valor anterior e o usuario jura que o clique nao funcionou.
1024:     *
1025:     * NAO reposiciona o ponteiro do cursor, de proposito: a linha corrente eh
1026:     * COMPARTILHADA com o form pai (DataSession = 1) e eh a que o usuario esta
1027:     * vendo. Procurar a linha por Dopes para "voltar" a ela cairia na primeira
1028:     * Operacao de mesmo nome e faria a grade pular sozinha.
1029:     *
1030:     * PROTECTED pelo mesmo motivo do FormParaBO.
1031:     *==========================================================================

*-- Linhas 1183 a 1201:
1183:     * FUNIL dos dois caminhos de alternancia do legado (MouseDown e KeyPress),
1184:     * que fazem a MESMA coisa:
1185:     *     m.Selecionada = Iif(LocalSacOp.Selecionada = 0, 1, 0)
1186:     *     Select LocalSacOp
1187:     *     Gather Memvar Fields Selecionada      && == REPLACE Selecionada WITH
1188:     *     ThisForm.grdOperacoes.Refresh
1189:     *
1190:     * A gravacao eh de SigOpLopBO.AlternarSelecao, que le a coluna, inverte,
1191:     * faz o REPLACE e reconta os totais; o Refresh da grade eh daqui, porque so
1192:     * o form conhece o controle. O BO devolve o valor novo (0/1) ou -1 quando
1193:     * nao foi possivel alternar - eh o que permite AVISAR em vez de ficar
1194:     * inerte: cursor somente-leitura faz o CheckBox aparecer, receber foco e
1195:     * NAO mudar de valor, defeito silencioso que parece bug de Enabled.
1196:     *
1197:     * O legado le a coluna do CURSOR no MouseDown (LocalSacOp.Selecionada) e,
1198:     * no KeyPress, le a variavel LOCAL homonima recem-declarada - que nasce
1199:     * vazia e nunca recebe o valor do registro. Isto eh, o KeyPress legado
1200:     * compara uma logica com 0 e nao reproduz o MouseDown. Aqui os dois
1201:     * caminhos passam pela MESMA leitura do cursor, que eh a do MouseDown: a


### BO (C:\4c\projeto\app\classes\SigOpLopBO.prg):
*==============================================================================
* SigOpLopBO.prg - Business Object: Sub-Nivel (selecao de Operacoes)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialogo modal filho - recebe ParentForm, marca/desmarca
*       as Operacoes no cursor do form pai e devolve o controle a ele)
*
* ORIGEM LEGADO: SigOpLop.SCX (Caption "Sub-Nivel"). O Init recebe pFrm (o form
* que abre o dialogo), desabilita o pai e devolve o Enabled no Ok. O dialogo
* NAO executa SQL nenhum: a grade grdOperacoes esta ligada ao cursor LocalSacOp,
* criado e populado por QUEM abre o dialogo, e o Check1 da Column1 alterna
* LocalSacOp.Selecionada por codigo (Gather Memvar Fields Selecionada), com a
* Column2 (Dopes) em ReadOnly.
*
* QUEM ABRE O DIALOGO (achado no acervo legado, 4install\FortyusMC\Fortyus):
* sigatsac.SCX, metodo gerarope, monta o cursor e so entao chama a tela -
* transcrito aqui LITERALMENTE porque eh o CONTRATO da grade:
*
*   lcQuery = [Select 0 as Selecionada, Dopes, GerOpServs, cCodServs,
*              nVlServs, nAliIss, fPags ] + ;
*             [From SigCdSOp ] + ;
*             [Where Codigos = ] + <crSigCdSOs.CodDeps> + [ And ] + ;
*             [GerOpers = 1]
*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSacOp]) < 1) ... Return 0
*   Select LocalSacOp
*   Go Top In LocalSacOp
*   If Eof([LocalSacOp]) ... Else   If (Reccount([LocalSacOp]) > 0)
*       Do Form SigOpLop With ThisForm
*   ...
*   Select LocalSacOp
*   Scan
*       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
*   EndScan
*
* Ou seja: a tabela de origem eh SigCdSOp (Operacoes do Departamento), NAO
* SigCdOpe, e depois de fechado o dialogo o form pai volta a LER o MESMO alias
* LocalSacOp - inclusive as colunas que a grade nao mostra (GerOpServs,
* cCodServs, nVlServs, nAliIss, fPags). Por isso este BO:
*   - mantem o alias legado LocalSacOp (nunca renomeia o cursor do pai);
*   - mapeia as SETE colunas do cursor, nao so as duas visiveis;
*   - trata a camada de dados como CURSOR, nao como INSERT/UPDATE.
*
* GRAVACAO: Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria()
* ficam HERDADOS de BusinessBase - o comportamento padrao da base ja eh o
* correto para esta tela, porque o legado nao tem TABLEUPDATE, nao tem
* .AddCursor e nao tem Insert/Update/Delete sobre tabela nenhuma: a marcacao
* vive no cursor em memoria e quem persiste qualquer coisa eh o form pai,
* depois do Ok. Sobrescrever esses metodos aqui exigiria INVENTAR um comando de
* gravacao que o legado nao possui.
*
* FASE 1/8: declaracao das propriedades + Init().
* FASE 2/8: camada de dados do cursor - CarregarDoCursor() com TODAS as colunas,
*           CarregarOperacoes() (a query do legado), GarantirCursorGrade(),
*           GradeEditavel(), AlternarSelecao(), AtualizarTotais(), TemSelecao(),
*           LimparDados(), ObterChavePrimaria(), Destroy().
*==============================================================================

DEFINE CLASS SigOpLopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTRATO DE CURSORES
    *
    * this_cCursorPai   - alias EXATO do legado (LocalSacOp). Pertence ao form
    *                     que abre o dialogo; este BO le e alterna a coluna
    *                     Selecionada dele e, quando o pai pede, o POPULA com a
    *                     query do legado - mas nunca o renomeia.
    * this_cCursorGrade - alias local usado como espelho da grade quando o
    *                     dialogo eh instanciado FORA do fluxo real (validacao
    *                     de UI / teste), em que LocalSacOp nao existe.
    *                     Nomenclatura cursor_4c_* do projeto.
    * this_cCursorTemp  - alias temporario do SQLEXEC. O resultado de SQLEXEC
    *                     nasce SOMENTE-LEITURA e a grade tem coluna EDITAVEL
    *                     (o CheckBox da Column1), entao a consulta cai aqui e
    *                     o alias da grade eh montado READWRITE a partir dele.
    *--------------------------------------------------------------------------
    this_cCursorPai   = "LocalSacOp"
    this_cCursorGrade = "cursor_4c_Operacoes"
    this_cCursorTemp  = "cursor_4c_OperacoesTmp"

    *--------------------------------------------------------------------------
    * COLUNAS DA GRADE (LocalSacOp) - uma propriedade por coluna do legado,
    * na MESMA ordem do Select de sigatsac.gerarope.
    *
    * this_nSelecionada - LocalSacOp.Selecionada. No legado a coluna nasce do
    *                     literal "0 as Selecionada", e o toggle eh
    *                     Iif(Selecionada = 0, 1, 0): eh NUMERICA (0/1), nao
    *                     logica. O pai confere com "Selecionada = 1".
    * this_cDopes       - LocalSacOp.Dopes -> SigCdSOp.dopes char(20). Unica
    *                     coluna EXIBIDA na grade (Column2, ReadOnly).
    * this_nGerOpServs  - LocalSacOp.GerOpServs -> geropservs numeric(1,0).
    *                     Lido pelo pai (If LocalSacOp.GerOpServs = 1 abre o
    *                     SigPrIns de servico), portanto NUMERICO.
    * this_cCodServs    - LocalSacOp.cCodServs -> ccodservs char(10).
    * this_nVlServs     - LocalSacOp.nVlServs  -> nvlservs numeric(11,2).
    * this_nAliIss      - LocalSacOp.nAliIss   -> naliiss  numeric(4,2).
    * this_cFPags       - LocalSacOp.fPags     -> fpags    char(12).
    *--------------------------------------------------------------------------
    this_nSelecionada = 0
    this_cDopes       = ""
    this_nGerOpServs  = 0
    this_cCodServs    = ""
    this_nVlServs     = 0
    this_nAliIss      = 0
    this_cFPags       = ""

    *--------------------------------------------------------------------------
    * TOTALIZADORES DA SELECAO (consultados pelo Form no Ok/Encerrar)
    *
    * this_nTotalOperacoes    - quantidade de linhas da grade
    * this_nTotalSelecionadas - quantidade de linhas com Selecionada = 1
    * this_cOperacoesMarcadas - lista das Operacoes marcadas, separadas por
    *                           virgula, para o form pai consumir sem precisar
    *                           varrer o cursor de novo
    *--------------------------------------------------------------------------
    this_nTotalOperacoes    = 0
    this_nTotalSelecionadas = 0
    this_cOperacoesMarcadas = ""

    *--------------------------------------------------------------------------
    * LARGURAS DO SCHEMA (docs\schema.sql, tabela SigCdSOp) - usadas pelo
    * PADR/LEFT das rotinas de carga e pelo MaxLength dos controles, para nunca
    * exibir nem montar valor maior do que a coluna aceita.
    *--------------------------------------------------------------------------
    this_nTamDopes    = 20
    this_nTamCodServs = 10
    this_nTamFPags    = 12
    this_nTamCodigos  = 10

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * A tabela de origem eh SigCdSOp e a coluna que identifica a linha para
    * ESTE dialogo eh dopes (a PK fisica da tabela eh cidchaves, que o Select
    * do legado NAO traz para o cursor, logo nao esta disponivel aqui).
    *
    * As propriedades sao atribuidas ANTES de DODEFAULT() porque
    * BusinessBase.Init() so instancia o DataAccess quando RECEBE o nome da
    * tabela como parametro - aqui a tela nao grava, entao o DataAccess nao eh
    * necessario e nao se passa parametro.
    *
    * O RETURN .T. explicito eh obrigatorio: Init que devolve .F. faz
    * CREATEOBJECT retornar valor nao-objeto e o form nao abre.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdSOp"
        THIS.this_cCampoChave = "dopes"

        DODEFAULT()

        THIS.LimparDados()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterAliasGrade - Resolve QUAL alias a grade deve usar
    *
    * No fluxo real o cursor eh do form pai (LocalSacOp). Fora dele (validacao
    * de UI / teste headless) esse alias nao existe e a grade cai no espelho
    * local. Resolver o alias por aqui evita espalhar IF USED() por todo o Form
    * e garante que Grid.RecordSource, Column.ControlSource e os handlers do
    * CheckBox falem SEMPRE do mesmo cursor.
    *--------------------------------------------------------------------------
    PROCEDURE ObterAliasGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.this_cCursorGrade

        IF USED(THIS.this_cCursorPai)
            loc_cAlias = THIS.this_cCursorPai
        ENDIF

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorGrade - Assegura que existe um alias com a estrutura da
    *                       grade ANTES de o Grid ser ligado a ele
    *
    * Column.ControlSource apontando para cursor que ainda nao existe estoura
    * "Alias ... is not found" DENTRO do TRY do InicializarForm: o CREATEOBJECT
    * devolve .F. e a tela simplesmente nao abre. Entao, quando o cursor do pai
    * nao esta aberto, cria-se o espelho VAZIO com as SETE colunas na MESMA
    * ordem do Select do legado - sem inventar nenhuma linha, porque sem o form
    * pai nao ha Operacao nenhuma a exibir.
    *
    * Tipos conforme docs\schema.sql (SigCdSOp) e conforme o literal
    * "0 as Selecionada" do legado. O cursor nasce READWRITE, que eh o que a
    * Column1 precisa para aceitar o REPLACE do CheckBox.
    *--------------------------------------------------------------------------
    PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.ObterAliasGrade()

        IF !USED(loc_cAlias)
            CREATE CURSOR cursor_4c_Operacoes ( ;
                Selecionada N(1), ;
                Dopes       C(20), ;
                GerOpServs  N(1), ;
                cCodServs   C(10), ;
                nVlServs    N(11,2), ;
                nAliIss     N(4,2), ;
                fPags       C(12))

            loc_cAlias = THIS.this_cCursorGrade
        ENDIF

        THIS.AtualizarTotais(loc_cAlias)

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeEditavel - .T. quando o alias da grade aceita REPLACE
    *
    * O CheckBox da Column1 alterna a coluna Selecionada por REPLACE, e isso
    * exige cursor READWRITE. Cursor devolvido por SQLEXEC nasce SOMENTE-LEITURA:
    * nesse caso o controle aparece, recebe foco e NAO muda de valor - defeito
    * silencioso que parece bug de Enabled/ReadOnly. Quem monta o cursor
    * (CarregarOperacoes, aqui, ou o form pai) tem de entregar READWRITE; este
    * metodo existe para que o Form possa AVISAR em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE GradeEditavel(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lEditavel

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        loc_lEditavel = .F.

        IF USED(loc_cAlias)
            loc_lEditavel = !ISREADONLY(loc_cAlias)
        ENDIF

        RETURN loc_lEditavel
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula o cursor da grade com a query do legado
    *
    * TRANSCRICAO de sigatsac.gerarope (ver cabecalho). O filtro eh
    * "Codigos = <departamento> And GerOpers = 1" - os dois termos vem do
    * legado e nenhum foi acrescentado.
    *
    * par_cCodigoDepartamento = SigCdSOp.codigos char(10), que no legado vem de
    * crSigCdSOs.CodDeps (a OS selecionada na grade do form pai). Sem esse
    * codigo nao existe consulta possivel: devolve .F. com mensagem, e a grade
    * continua com o espelho vazio criado por GarantirCursorGrade.
    *
    * O SQLEXEC cai em cursor TEMPORARIO e o alias da grade eh montado a partir
    * dele, por dois motivos: (a) o cursor de SQLEXEC eh somente-leitura e a
    * Column1 precisa de REPLACE; (b) SQLEXEC sobre o alias JA ligado a um Grid
    * fecha e recria esse alias, zerando ColumnCount e deixando a grade como um
    * retangulo branco. Com o alias ja aberto e editavel usa-se ZAP + APPEND,
    * que preserva estrutura, RecordSource, ControlSource e CurrentControl.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigoDepartamento)
        LOCAL loc_cSQL, loc_cCodigo, loc_cAlias, loc_nResultado
        LOCAL loc_lSucesso, loc_cSafety, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodigoDepartamento) != "C" OR EMPTY(par_cCodigoDepartamento)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Departamento n" + ;
                CHR(227) + "o informado para carregar as Opera" + CHR(231) + ;
                CHR(245) + "es."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cCodigo = LEFT(ALLTRIM(par_cCodigoDepartamento), THIS.this_nTamCodigos)

        *-- Select transcrito do legado (sigatsac.gerarope): colunas e ordem
        *-- IDENTICAS, porque o form pai le todas elas depois do Ok.
        loc_cSQL = "SELECT 0 AS Selecionada, Dopes, GerOpServs, cCodServs," + ;
                   " nVlServs, nAliIss, fPags" + ;
                   " FROM SigCdSOp" + ;
                   " WHERE Codigos = " + EscaparSQL(loc_cCodigo) + ;
                   " AND GerOpers = 1" + ;
                   " ORDER BY Dopes"

        TRY
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar as Opera" + CHR(231) + ;
                    CHR(245) + "es do Departamento: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                loc_cAlias = THIS.ObterAliasGrade()

                IF USED(loc_cAlias) AND !ISREADONLY(loc_cAlias)
                    *-- Alias ja aberto e editavel (tipicamente ligado ao Grid):
                    *-- ZAP + APPEND preserva o binding da grade. SET SAFETY eh
                    *-- escopado por data session e volta a ON em form
                    *-- DataSession = 2, onde o ZAP abriria dialogo modal e
                    *-- congelaria a tela.
                    loc_cSafety = SET("SAFETY")
                    SET SAFETY OFF
                    SELECT (loc_cAlias)
                    ZAP
                    APPEND FROM DBF(THIS.this_cCursorTemp)
                    IF loc_cSafety = "ON"
                        SET SAFETY ON
                    ENDIF
                ELSE
                    *-- Primeira carga (ou alias somente-leitura): monta o alias
                    *-- legado LocalSacOp como cursor READWRITE.
                    IF USED(THIS.this_cCursorPai)
                        USE IN (THIS.this_cCursorPai)
                    ENDIF

                    SELECT * ;
                        FROM cursor_4c_OperacoesTmp ;
                        INTO CURSOR LocalSacOp READWRITE

                    loc_cAlias = THIS.this_cCursorPai
                ENDIF

                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF

                *-- Go Top In LocalSacOp - exatamente como o legado faz antes de
                *-- abrir o dialogo.
                SELECT (loc_cAlias)
                GO TOP

                THIS.AtualizarTotais(loc_cAlias)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao carregar as Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor nas propriedades
    *
    * Mapeia as SETE colunas do cursor do legado, nao apenas as duas que a
    * grade exibe: o form pai consome GerOpServs, cCodServs, nVlServs, nAliIss
    * e fPags depois que o dialogo fecha, e eh este metodo que leva esses
    * valores para o BO.
    *
    * Cuidados:
    *   - SELECT (par_cAliasCursor) ANTES de ler os campos, e restauracao da
    *     area de trabalho anterior no fim (nao roubar o SELECT de quem chamou);
    *   - guarda de EOF: cursor vazio ou posicionado no fim nao pode "carregar"
    *     lixo nas propriedades;
    *   - existencia de cada coluna por TYPE(alias + ".coluna") != "U" -
    *     PEMSTATUS exige OBJETO no 1o argumento e estoura com nome de cursor;
    *   - coluna numeric(1,0) pode chegar como Numerico (numeric) ou como Logico
    *     (bit) conforme o driver: VARTYPE antes de comparar, senao da
    *     type mismatch.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_lSucesso, loc_uValor

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        SELECT (loc_cAlias)

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada no cursor [" + loc_cAlias + "]."
        ELSE
            *-- Selecionada: marcacao numerica 0/1 (literal "0 as Selecionada")
            IF TYPE(loc_cAlias + ".Selecionada") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nSelecionada = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nSelecionada = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- Dopes: a Operacao exibida na Column2 (SigCdSOp.dopes char(20))
            IF TYPE(loc_cAlias + ".Dopes") != "U"
                THIS.this_cDopes = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""), ;
                                        THIS.this_nTamDopes)
            ENDIF

            *-- GerOpServs: numeric(1,0); o form pai testa "= 1"
            IF TYPE(loc_cAlias + ".GerOpServs") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".GerOpServs")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nGerOpServs = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nGerOpServs = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- cCodServs: char(10)
            IF TYPE(loc_cAlias + ".cCodServs") != "U"
                THIS.this_cCodServs = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".cCodServs"), ""), ;
                                           THIS.this_nTamCodServs)
            ENDIF

            *-- nVlServs: numeric(11,2)
            IF TYPE(loc_cAlias + ".nVlServs") != "U"
                THIS.this_nVlServs = TratarNulo(EVALUATE(loc_cAlias + ".nVlServs"), 0)
                IF VARTYPE(THIS.this_nVlServs) != "N"
                    THIS.this_nVlServs = 0
                ENDIF
            ENDIF

            *-- nAliIss: numeric(4,2) - aliquota de ISS usada pelo pai no calculo
            IF TYPE(loc_cAlias + ".nAliIss") != "U"
                THIS.this_nAliIss = TratarNulo(EVALUATE(loc_cAlias + ".nAliIss"), 0)
                IF VARTYPE(THIS.this_nAliIss) != "N"
                    THIS.this_nAliIss = 0
                ENDIF
            ENDIF

            *-- fPags: char(12) - forma de pagamento que o pai le em SigOpFp
            IF TYPE(loc_cAlias + ".fPags") != "U"
                THIS.this_cFPags = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".fPags"), ""), ;
                                        THIS.this_nTamFPags)
            ENDIF

            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Alterna a marcacao da LINHA CORRENTE
    *
    * Reproduz o que o Check1 da Column1 faz no legado:
    *
    *   m.Selecionada = Iif(LocalSacOp.Selecionada = 0, 1, 0)
    *   Select LocalSacOp
    *   Gather Memvar Fields Selecionada
    *   ThisForm.grdOperacoes.Refresh
    *
    * O Gather Memvar sobre UM campo eh exatamente um REPLACE desse campo; o
    * Refresh da grade fica no Form, que eh quem tem o controle visual.
    *
    * Devolve o valor novo (0 ou 1), ou -1 quando nao foi possivel alternar -
    * assim o Form distingue "desmarcou" de "falhou" em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nAtual, loc_nNovo, loc_uValor
        LOCAL loc_oErro

        loc_nNovo = -1

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN -1
        ENDIF

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada para marcar."
            RETURN -1
        ENDIF

        IF ISREADONLY(loc_cAlias)
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] est" + CHR(225) + ;
                " somente-leitura e a marca" + CHR(231) + CHR(227) + "o da Opera" + ;
                CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser gravada."
            RETURN -1
        ENDIF

        IF TYPE(loc_cAlias + ".Selecionada") = "U"
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o possui a coluna Selecionada."
            RETURN -1
        ENDIF

        loc_cAreaAnterior = ALIAS()

        TRY
            SELECT (loc_cAlias)

            loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
            IF VARTYPE(loc_uValor) = "N"
                loc_nAtual = NVL(loc_uValor, 0)
            ELSE
                loc_nAtual = IIF(NVL(loc_uValor, .F.), 1, 0)
            ENDIF

            loc_nNovo = IIF(loc_nAtual = 0, 1, 0)

            REPLACE Selecionada WITH loc_nNovo IN (loc_cAlias)

            THIS.this_nSelecionada  = loc_nNovo
            THIS.this_cMensagemErro = ""

            THIS.AtualizarTotais(loc_cAlias)
        CATCH TO loc_oErro
            loc_nNovo = -1
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao marcar a Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_nNovo
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotais - Reconta a selecao e monta a lista das marcadas
    *
    * Equivale ao Scan que o form pai roda DEPOIS do Ok:
    *
    *   Select LocalSacOp
    *   Scan
    *       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
    *   EndScan
    *
    * O RECNO eh salvo e reposto: SCAN move o ponteiro, e a linha corrente eh a
    * que o usuario esta vendo na grade - perde-la faz a grade "pular" sozinha.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotais(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nRegistro, loc_nSel, loc_cLista
        LOCAL loc_uValor, loc_nValor, loc_oErro

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        loc_nSel          = 0
        loc_cLista        = ""

        TRY
            SELECT (loc_cAlias)
            loc_nRegistro = RECNO(loc_cAlias)

            THIS.this_nTotalOperacoes = RECCOUNT(loc_cAlias)

            SCAN
                loc_nValor = 0

                IF TYPE(loc_cAlias + ".Selecionada") != "U"
                    loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                    IF VARTYPE(loc_uValor) = "N"
                        loc_nValor = NVL(loc_uValor, 0)
                    ELSE
                        loc_nValor = IIF(NVL(loc_uValor, .F.), 1, 0)
                    ENDIF
                ENDIF

                IF loc_nValor = 1
                    loc_nSel = loc_nSel + 1

                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        loc_cLista = loc_cLista + ;
                            IIF(EMPTY(loc_cLista), "", ", ") + ;
                            ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""))
                    ENDIF
                ENDIF
            ENDSCAN

            THIS.this_nTotalSelecionadas = loc_nSel
            THIS.this_cOperacoesMarcadas = loc_cLista

            *-- Repoe a linha que o usuario estava vendo na grade
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT(loc_cAlias)
                GO loc_nRegistro IN (loc_cAlias)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao totalizar a sele" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TemSelecao - .T. quando ha ao menos uma Operacao marcada
    *
    * Eh o llOks do form pai, exposto aqui para que ele nao precise varrer o
    * cursor de novo. CONSULTA apenas: o Ok do legado NAO exige selecao (ele so
    * devolve o Enabled ao pai e libera a tela), portanto o Form nao deve usar
    * este metodo para bloquear o Ok.
    *--------------------------------------------------------------------------
    PROCEDURE TemSelecao(par_cAliasCursor)
        THIS.AtualizarTotais(par_cAliasCursor)

        RETURN (THIS.this_nTotalSelecionadas > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades da linha e os totalizadores
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nSelecionada = 0
        THIS.this_cDopes       = ""
        THIS.this_nGerOpServs  = 0
        THIS.this_cCodServs    = ""
        THIS.this_nVlServs     = 0
        THIS.this_nAliIss      = 0
        THIS.this_cFPags       = ""

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        THIS.this_cMensagemErro = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identidade da linha corrente
    *
    * SigCdSOp.dopes - a PK fisica da tabela eh cidchaves, que o Select do
    * legado nao traz para o cursor da grade e portanto nao existe aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha apenas o que ESTE BO criou
    *
    * O cursor do pai (LocalSacOp) continua aberto de proposito: o form pai le
    * a selecao depois que o dialogo fecha. Fecha-lo aqui apagaria o resultado
    * da tela inteira.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorTemp)
            USE IN (THIS.this_cCursorTemp)
        ENDIF

        IF USED(THIS.this_cCursorGrade)
            USE IN (THIS.this_cCursorGrade)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

