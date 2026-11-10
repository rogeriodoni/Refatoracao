# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, MARCAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, MARCAS

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
  Column2.ControlSource = ""
Select crItensLoc
	.column1.ControlSource = [crItensLoc.Cpros]
	.column2.ControlSource = [crItensLoc.Dpros]
	.column3.ControlSource = [crItensLoc.Marcas]
	.column4.ControlSource = [crItensLoc.Locals]
lnOldSel = Select()
Select(lnOldSel)
Select crTpmMvItn
Select Distinct 0 as Marcas, Cpros, Dpros, Iif(ThisForm.pcOrigem='ORIGEM',LocalOs,Locals) as Locals from crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc ReadWrite 
Select crItensLoc
	Select crTPro
Select csLocals
		Update crTpmMvItn set Localos = csLocals.Locals where Cpros = csLocals.Cpros
		Update crTpmMvItn set Locals = csLocals.Locals where Cpros = csLocals.Cpros
Select crTpmMvItn
lnOldSel = Select()
Select crItensLoc
	Select csLocals
	Select crItensLoc
Select crItensLoc
Delete From crItensLoc Where Marcas <> 0 
Select crItensLoc
Select(lnOldSel)
lnOldSel = Select()
Select crItensLoc
Select(lnOldSel)
Select crItensLoc
Select crItensLoc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLcZ.prg) - TRECHOS RELEVANTES PARA PASS SQL (1958 linhas total):

*-- Linhas 121 a 139:
121: *     MontaGrade()           <- montagrade do legado (reindexa, reBINDA a
122: *                               grade, GO TOP, Refresh, Column1.SetFocus) e
123: *                               REAPLICA a formatacao das colunas, porque
124: *                               atribuir RecordSource/ControlSource reseta
125: *                               Width e Header1.Caption (Problema 48) e o
126: *                               CurrentControl do CheckBox (regra #18)
127: *     CarregarLista()        <- recarrega cursor_4c_Itens do cursor do PAI e
128: *                               repinta pelo MontaGrade (regra #21/#46: a
129: *                               grade nao se repinta sozinha)
130: *     FormParaBO()           <- txt_4c_Base/txt_4c_DBase -> properties do BO
131: *     BOParaForm()           <- properties do BO -> txt_4c_Base/txt_4c_DBase
132: *     LimparCampos()         <- getBase.Value = [] / getDBase.Value = [] do
133: *                               legado, nos DOIS lados (controle e BO)
134: *     HabilitarCampos()      <- o When de getBase/btnLimpar
135: *     AjustarBotoesPorModo() <- funil do estado dos botoes por modo
136: *   Os tres primeiros hooks de FormBase (FormParaBO/BOParaForm/LimparCampos)
137: *   sao PROTECTED la, e VFP9 nao deixa a subclasse ALARGAR escopo herdado
138: *   (regra #51) - por isso ficam PROTECTED aqui e so sao chamados de dentro
139: *   da classe. CarregarLista/AjustarBotoesPorModo sao PUBLIC porque o

*-- Linhas 323 a 341:
323:                 *--    assim: cria o placeholder com a MESMA estrutura que
324:                 *--    CarregarItens produziria.
325:                 IF !USED(THIS.this_oBusinessObject.this_cCursorItens)
326:                     CREATE CURSOR (THIS.this_oBusinessObject.this_cCursorItens) ;
327:                         (Marcas N(1, 0), Cpros C(14), Dpros C(65), Locals C(10))
328:                 ENDIF
329: 
330:                 *-- 8. Grade de itens (grdItens do legado)
331:                 THIS.ConfigurarGrid()
332: 
333:                 *-- 9. Botoes Confirmar/Sair (cntBotoes do legado)
334:                 THIS.ConfigurarBotoesPrincipais()
335: 
336:                 *-- 10. Botoes Localizar/Limpar Selecao (cmdAcoes do legado)
337:                 THIS.ConfigurarBotoesAcoes()
338: 
339:                 *-- 10a. Foto do produto (ImgJpg do legado). DEPOIS de
340:                 *--      ConfigurarMolduras, para desenhar por cima da
341:                 *--      ShpFigura que a emoldura - mesma ordem do dump,

*-- Linhas 559 a 591:
559:     * Geometria e colunas transcritas do dump (ColumnOrder fisico: Column3=1,
560:     * Column1=2, Column2=3, Column4=4):
561:     *   grdItens Top=105 Left=10 Width=549 Height=259 RowHeight=16
562:     *            GridLineColor=238,238,238 DeleteMark=.F. RecordMark=.F.
563:     *   Column1 (Cpros)  Width=122 Header "Produto"
564:     *   Column2 (Dpros)  Width=290 Header "Descricao"      ReadOnly
565:     *   Column3 (Marcas) Width=17  CheckBox de selecao
566:     *   Column4 (Locals) Width=95  Header "Localizacao"    ReadOnly
567:     *
568:     * Column1 nao declara ReadOnly no dump (so o Text1 tem .ReadOnly = .F.),
569:     * mas o Text1.When legado retorna .F. incondicional - a celula nunca
570:     * recebe foco, ou seja, a observavel para o usuario eh IDENTICA a
571:     * ReadOnly = .T.. Reproduzido assim (Column.ReadOnly = .T.) porque o
572:     * Grid migrado nao tem equivalente direto de When por celula.
573:     *
574:     * ORDEM OBRIGATORIA (Problema 48 / regra #35c): ColumnCount ->
575:     * RecordSource -> ControlSource de TODAS as colunas -> SO DEPOIS Width/
576:     * Header1.Caption/demais formatacao. Atribuir ControlSource reseta
577:     * Width e Header1.Caption para o default; fazer a formatacao antes
578:     * seria descartada. Por isso o bind e a formatacao vivem em MontaGrade()
579:     * / FormatarGridItens(), que sao reusados por TODO caminho que repinta a
580:     * grade - aqui so se cria o Grid e o CheckBox da coluna de marcacao.
581:     *
582:     * A ORDEM "BIND ANTES DO AddObject DO CHECKBOX" eh obrigatoria e foi
583:     * MEDIDA no VFP9 (2026-11-08, automation nao necessaria - reproduzido
584:     * neste proprio form). Grid cuja RecordSource ainda nao foi atribuida
585:     * AUTO-BINDA na area de trabalho CORRENTE assim que o ColumnCount eh
586:     * definido: medido, RecordSource virou sozinha "cursor_4c_Itens" e a
587:     * Column3 ficou ligada a terceira COLUNA DO CURSOR (Dpros, CHARACTER),
588:     * nao a Marcas. Adicionar nessa coluna um CheckBox - cujo .Value nasce
589:     * NUMERICO (medido: VARTYPE = "N", valor 0) - estoura no proprio
590:     * AddObject com "Error with CHK_4C_CHECK1 - Value : Data type
591:     * mismatch", dentro do TRY do InicializarForm: devolve .F.,

*-- Linhas 616 a 634:
616:             .Height        = 259
617:             .FontName      = "Tahoma"
618:             .FontSize      = 8
619:             .DeleteMark    = .F.
620:             .RecordMark    = .F.
621:             .RowHeight     = 16
622:             .ScrollBars    = 2
623:             .GridLineColor = RGB(238, 238, 238)
624:             .ColumnCount   = 4
625:         ENDWITH
626: 
627:         *-- Bind + criacao do CheckBox + formatacao, na ordem provada acima.
628:         *-- MontaGrade faz os tres passos e eh reusado a cada repintura.
629:         THIS.MontaGrade()
630: 
631:         loc_oGrid.Visible = .T.
632: 
633:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
634: 

*-- Linhas 658 a 676:
658:     * alternancia (regra #185) ficariam mudos.
659:     *
660:     * .Value = 0 NUMERICO eh obrigatorio e tem de bater com o tipo da coluna
661:     * (Marcas N(1,0), do "0 as Marcas" do Select Distinct legado).
662:     *==========================================================================
663:     PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
664:         LOCAL loc_oCol
665: 
666:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
667:             RETURN .F.
668:         ENDIF
669: 
670:         loc_oCol = THIS.grd_4c_Dados.Column3
671: 
672:         *-- Ja existe: nada a fazer (e nao se pode AddObject de novo)
673:         IF PEMSTATUS(loc_oCol, "chk_4c_Check1", 5)
674:             RETURN .T.
675:         ENDIF
676: 

*-- Linhas 702 a 735:
702:     *==========================================================================
703:     * MontaGrade - equivalente a PROCEDURE montagrade do SCX legado
704:     *
705:     *   Select crItensLoc / Index on Cpros Tag Cpros / Go top
706:     *   With ThisForm.grdItens
707:     *       .RecordSource = [crItensLoc]
708:     *       .column1.ControlSource = [crItensLoc.Cpros]   ... (as quatro)
709:     *       .Refresh()
710:     *   EndWith
711:     *
712:     * FUNIL UNICO do bind/repintura da grade: chamado na montagem
713:     * (ConfigurarGrid), pelo botao Limpar Selecao (o legado tambem chama
714:     * ThisForm.Montagrade() ali) e pelo CarregarLista(). Grade ligada a
715:     * cursor NAO se repinta sozinha depois que o cursor muda (regra #21) -
716:     * sem um ponto unico, cada caminho esquece uma metade.
717:     *
718:     * O Index on Cpros NAO eh repetido aqui: quem cria cursor_4c_Itens eh
719:     * SigOpLcZBO.CarregarItens(), que ja faz o INDEX ON Cpros TAG Cpros
720:     * imediatamente apos o SELECT - repetir o INDEX a cada repintura so
721:     * recriaria a mesma tag.
722:     *
723:     * O Column1.SetFocus que fecha o montagrade legado fica nos HANDLERS de
724:     * botao e nao aqui: MontaGrade tambem roda durante o InicializarForm,
725:     * com a tela ainda nao exibida, e dar foco a controle de form invisivel
726:     * derrubaria o Init. Os dois call sites do usuario (Localizar e Limpar
727:     * Selecao) ja chamam o SetFocus, entao o observavel eh identico.
728:     *
729:     * PUBLIC: eh funil, precisa ser acionavel pelos handlers e pelo harness.
730:     *==========================================================================
731:     PROCEDURE MontaGrade()
732:         LOCAL loc_oGrid, loc_cCursor
733: 
734:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
735:             RETURN .F.

*-- Linhas 744 a 789:
744: 
745:         loc_oGrid.RecordSource = loc_cCursor
746: 
747:         loc_oGrid.Column1.ControlSource = loc_cCursor + ".Cpros"
748:         loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dpros"
749:         loc_oGrid.Column3.ControlSource = loc_cCursor + ".Marcas"
750:         loc_oGrid.Column4.ControlSource = loc_cCursor + ".Locals"
751: 
752:         *-- SO AGORA o CheckBox pode entrar/voltar: a Column3 acabou de ser
753:         *-- ligada a coluna NUMERICA Marcas, e eh esse bind que impede o
754:         *-- "Data type mismatch" no AddObject (ver cabecalho de
755:         *-- ConfigurarGrid). Idempotente: cria apenas se o objeto nao existe.
756:         THIS.GarantirCheckBoxMarcacao()
757: 
758:         *-- RecordSource/ControlSource acabaram de resetar Width,
759:         *-- Header1.Caption e CurrentControl - reaplicar SEMPRE depois
760:         THIS.FormatarGridItens(loc_oGrid)
761: 
762:         *-- Go top + Refresh: o legado fecha o montagrade assim, e eh o que
763:         *-- faz a grade EXIBIR as linhas que o cursor passou a ter
764:         SELECT (loc_cCursor)
765:         GO TOP
766:         loc_oGrid.Refresh()
767: 
768:         RETURN .T.
769:     ENDPROC
770: 
771:     *==========================================================================
772:     * CarregarLista - recarrega os itens do cursor do form PAI e repinta
773:     *
774:     * Equivale ao par "Select Distinct ... Into Cursor crItensLoc" +
775:     * "ThisForm.MontaGrade()" do Init legado: a consulta eh do BO
776:     * (CarregarItens) e a repintura eh do MontaGrade. Separado do
777:     * MontaGrade de proposito - o botao Limpar Selecao do legado so REPINTA
778:     * (chama Montagrade e nada mais), NAO recarrega; recarregar ali
779:     * desfaria as localizacoes que o usuario ja aplicou na sessao.
780:     *
781:     * PUBLIC: o harness de teste chama CarregarLista de FORA da classe, e
782:     * PEMSTATUS devolve .T. para metodo PROTECTED (so testa existencia, nao
783:     * escopo) - o teste entraria no branch e a chamada falharia (regra #3).
784:     *==========================================================================
785:     PROCEDURE CarregarLista()
786:         LOCAL loc_lSucesso
787: 
788:         loc_lSucesso = THIS.this_oBusinessObject.CarregarItens()
789: 

*-- Linhas 801 a 819:
801:     * FormatarGridItens - propriedades das quatro colunas de grd_4c_Dados
802:     *
803:     * Chamado por MontaGrade SEMPRE depois do bind, porque atribuir
804:     * RecordSource/ControlSource reseta Width e Header1.Caption para o
805:     * default 90/"Header1" (Problema 48) e derruba o CurrentControl da
806:     * coluna de marcacao (regra #18) - a grade apareceria com colunas
807:     * quadradas, cabecalhos "Header1" e o valor cru 0/1 no lugar do
808:     * CheckBox.
809:     *
810:     * Column.ReadOnly vem DEPOIS do Grid.ReadOnly por regra (#18): o do
811:     * grid propaga para as colunas e sobrescreveria estes valores.
812:     *==========================================================================
813:     PROTECTED PROCEDURE FormatarGridItens(par_oGrid)
814:         LOCAL loc_oGrid
815: 
816:         IF VARTYPE(par_oGrid) = "O"
817:             loc_oGrid = par_oGrid
818:         ELSE
819:             loc_oGrid = THIS.grd_4c_Dados

*-- Linhas 1218 a 1238:
1218:     * BtnSairClick / BtnConfirmarClick
1219:     *
1220:     * Equivalente a SigOpLcZ.cntBotoes.btnSair.Click (ThisForm.Release) e
1221:     * SigOpLcZ.cntBotoes.btnConfirmar.Click (Scan em csLocals, Update
1222:     * crTpmMvItn, Release - sem validacao nenhuma antes, o legado sempre
1223:     * fecha a tela). SigOpLcZBO.Confirmar() ja reproduz o Scan/Update; sem
1224:     * linhas em cursor_4c_Selecionados eh no-op valido, igual ao legado.
1225:     *==========================================================================
1226:     PROCEDURE BtnSairClick()
1227:         THIS.Release()
1228:     ENDPROC
1229: 
1230:     PROCEDURE BtnConfirmarClick()
1231:         THIS.this_oBusinessObject.Confirmar()
1232:         THIS.Release()
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * ConfigurarBotoesAcoes - cmdAcoes do SCX legado: Localizar/Limpar Selecao
1237:     *
1238:     * Buttons(1) = Command1 = btnLocalizar (comeca desabilitado - so liga

*-- Linhas 1572 a 1590:
1572:     *
1573:     * fwbuscaext tenta o match EXATO por Codigos sozinho (plAchouRegistro) e
1574:     * SO quando nao acha eh que mostra o browse - reproduzido aqui com
1575:     * SQLEXEC exato primeiro (silencioso) e THIS.AbrirBuscaBase() como
1576:     * fallback (regra #36/37: Pattern B do FormBuscaAuxiliar com CREATEOBJECT
1577:     * de 2+ argumentos eh PROIBIDO - CORRETO eh o funil THIS.AbrirLookupCanonico,
1578:     * ja usado pelo FormSigOpLcl irmao desta task).
1579:     *
1580:     * Guarda de reentrancia (regra #37/#47): o corpo vive em
1581:     * BaseLostFocusExec para a flag ser SEMPRE liberada, inclusive com RETURN
1582:     * antecipado dentro do Exec.
1583:     *
1584:     * Sincroniza o resultado com o BO (this_cBaseLocalizacao/
1585:     * this_cDescBaseLocalizacao) - sem isso THIS.this_oBusinessObject.
1586:     * Localizar() nunca veria o valor digitado/escolhido pelo usuario, e
1587:     * sempre recusaria com "Informar a Base da Localizacao.".
1588:     *
1589:     * PUBLIC: exigido pelo BINDEVENT (regra #3).
1590:     *==========================================================================

*-- Linhas 1618 a 1638:
1618:                     USE IN cursor_4c_BaseExata
1619:                 ENDIF
1620: 
1621:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos = " + ;
1622:                     EscaparSQL(loc_cValor)
1623:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseExata")
1624: 
1625:                 IF loc_nResultado > 0 AND USED("cursor_4c_BaseExata")
1626:                     IF RECCOUNT("cursor_4c_BaseExata") = 1
1627:                         THIS.txt_4c_Base.Value  = ALLTRIM(cursor_4c_BaseExata.Codigos)
1628:                         THIS.txt_4c_DBase.Value = ALLTRIM(NVL(cursor_4c_BaseExata.Descricaos, ""))
1629:                         loc_lAchou = .T.
1630:                     ENDIF
1631:                 ENDIF
1632: 
1633:                 IF USED("cursor_4c_BaseExata")
1634:                     USE IN cursor_4c_BaseExata
1635:                 ENDIF
1636:             ENDIF
1637:         ENDIF
1638: 


### BO (C:\4c\projeto\app\classes\SigOpLcZBO.prg):
*============================================================================
* SigOpLcZBO.prg - Business Object para "Selecao de Localizacao" (SIGOPLCZ)
*
* Form OPERACIONAL (SIGOPLCZ / FormSigOpLcZ): dialogo MODAL chamado por um
* form PAI que ja tem aberto o cursor crTpmMvItn com os itens de um
* movimento (produtos sem localizacao atribuida, ou a atualizar). O dialogo
* NAO consulta o banco: ele agrega esse cursor localmente (Select Distinct
* Cpros/Dpros/Locals), deixa o usuario marcar linhas na grade, escolher UMA
* localizacao (lookup em SigPrLcl) e aplicar em lote - de volta no cursor do
* PAI, via UPDATE crTpmMvItn Set Locals|Localos = <escolhida> Where
* Cpros = <marcado>.
*
* Parametros do legado (Init lParameters pCnx, pEscolha, pOrigem):
*   pCnx      - ThisForm.poDataMgr (gerenciador de conexao Fortyus). NAO
*               tem equivalente aqui: a arquitetura nova usa o handle
*               global gnConnHandle, entao este BO nao guarda property para
*               ele.
*   pEscolha  - Thisform.pcEscolha: modo de abertura ('INSERIR'/'ALTERAR'/
*               'PROCURAR' no padrao Fortyus). Controla o When() dos botoes
*               de marcacao/limpeza/localizar (so habilitados fora de
*               'PROCURAR').
*   pOrigem   - Thisform.pcOrigem: 'ORIGEM' ou outro valor. Decide qual
*               coluna do crTpmMvItn recebe a localizacao no Confirmar:
*               'ORIGEM' grava em Localos, qualquer outro valor grava em
*               Locals.
*
* Cursor de entrada (fornecido pelo form PAI - este BO so o consulta/altera,
* nunca o cria):
*   crTpmMvItn - cursor de itens do movimento, com (ao menos) Cpros, Dpros,
*                Locals e LocalOs. Alias LITERAL do legado: o form pai e os
*                metodos deste BO compartilham a mesma area de trabalho, por
*                isso NAO se renomeia (mesma logica de alias-contrato das
*                regras de FRX/OLE - aqui o "contrato" eh com quem chama a
*                tela, nao com um relatorio).
*
* Cursores de trabalho (criados pelo Init, nas fases seguintes):
*   cursor_4c_Itens        - equivalente ao crItensLoc do legado: Select
*                             Distinct 0 as Marcas, Cpros, Dpros e a coluna
*                             de localizacao atual (Locals ou LocalOs,
*                             conforme this_cOrigem) extraida de
*                             crTpmMvItn Where Not Empty(Cpros). Marcas eh a
*                             flag de selecao (0/1) que a grade edita via
*                             CheckBox.
*   cursor_4c_Selecionados  - equivalente ao csLocals do legado: Cpros c(14)
*                             + Locals c(10), populado pelo Localizar
*                             (linhas marcadas) e aplicado ao crTpmMvItn pelo
*                             Confirmar.
*
* Nao existe tabela propria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server - toda leitura/escrita eh sobre
* os cursores em memoria acima.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*
* Fase 2 - Metodos de dados (sem CRUD de tabela - este BO nao tem tabela
* propria, entao Inserir()/Atualizar()/ExecutarExclusao()/
* ObterChavePrimaria()/RegistrarAuditoria() NAO sao sobrescritos aqui: o
* comportamento padrao herdado de BusinessBase ja eh o correto para esta
* tela, que so le/escreve nos cursores em memoria abaixo):
*   CarregarItens()       - equivalente ao Init/Select Distinct do legado:
*                           (re)monta cursor_4c_Itens a partir de
*                           crTpmMvItn, indexado por Cpros.
*   SelecionarTodos()     - equivalente ao SigOpLcZ.SelTudo.Click.
*   DesmarcarTodos()      - equivalente ao SigOpLcZ.apaga.Click.
*   Localizar()           - equivalente ao cmdAcoes.btnLocalizar.Click:
*                           valida a base escolhida, move os itens
*                           marcados de cursor_4c_Itens para
*                           cursor_4c_Selecionados e limpa a marcacao.
*   Confirmar()           - equivalente ao cntBotoes.btnConfirmar.Click:
*                           aplica cursor_4c_Selecionados de volta em
*                           crTpmMvItn (Localos ou Locals conforme
*                           this_cOrigem).
*   ObterImagemProduto()  - equivalente ao CursorQuery('SigCdPro',...,
*                           'FigJpgs') do grdItens.AfterRowColChange.
*   PrepararCursores()    - equivalente ao "If Used([csLocals]) / Use in
*                           csLocals / Create Cursor csLocals(...)" do Init
*                           legado: derruba e recria
*                           cursor_4c_Selecionados, para que uma reabertura
*                           do dialogo nao herde a selecao do movimento
*                           anterior.
*   CarregarDoCursor()    - le a linha CORRENTE da grade (Cpros, Dpros,
*                           Locals, Marcas) para as properties this_*Atual,
*                           como faz o grdItens.AfterRowColChange legado.
*   LimparLinhaAtual()    - zera essas properties (cursor vazio ou em EOF).
*   PodeLocalizar()       - regra "Empty(Locals) And Not Empty(Marcas)" do
*                           AfterRowColChange: fonte unica do
*                           btnLocalizar.Enabled.
*   PodeEditar()          - regra "InList(pcEscolha,'INSERIR','ALTERAR')"
*                           dos When() legado: fonte unica do Enabled dos
*                           botoes de marcacao/limpeza/localizacao.
*============================================================================

DEFINE CLASS SigOpLcZBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE ABERTURA (pcEscolha / pcOrigem do legado)
    *==========================================================================

    *-- Modo de abertura: 'INSERIR' / 'ALTERAR' / 'PROCURAR'. Fora de
    *-- 'PROCURAR' os botoes de marcar/limpar/localizar ficam habilitados
    *-- (mesmo teste do When legado: InList(pcEscolha,'INSERIR','ALTERAR')).
    this_cEscolha = ""

    *-- 'ORIGEM' ou outro valor. Decide, no Confirmar, se a localizacao
    *-- escolhida grava em crTpmMvItn.Localos (ORIGEM) ou em
    *-- crTpmMvItn.Locals (qualquer outro valor).
    this_cOrigem = ""

    *==========================================================================
    * CURSOR DE ENTRADA (fornecido pelo form PAI)
    *==========================================================================

    *-- Alias LITERAL compartilhado com quem abriu o dialogo - nao se
    *-- renomeia para o padrao cursor_4c_* porque este BO nao o cria, so
    *-- consulta/atualiza a area de trabalho que o chamador deixou aberta.
    this_cCursorOrigem = "crTpmMvItn"

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Equivalente ao crItensLoc do legado: grade de selecao (Marcas, Cpros,
    *-- Dpros, Locals/LocalOs conforme this_cOrigem)
    this_cCursorItens = "cursor_4c_Itens"

    *-- Equivalente ao csLocals do legado: itens marcados + localizacao
    *-- escolhida, acumulados pelo Localizar e aplicados pelo Confirmar
    this_cCursorSelecionados = "cursor_4c_Selecionados"

    *==========================================================================
    * LOCALIZACAO ESCOLHIDA (getBase/getDBase do legado)
    *==========================================================================

    *-- Codigo da base de localizacao escolhida (lookup em SigPrLcl.Codigos)
    this_cBaseLocalizacao = ""

    *-- Descricao da base de localizacao escolhida (SigPrLcl.Descricaos)
    this_cDescBaseLocalizacao = ""

    *==========================================================================
    * LINHA CORRENTE DA GRADE (crItensLoc do legado)
    *
    * O grdItens.AfterRowColChange legado le TRES campos da linha corrente de
    * crItensLoc: Cpros (para a consulta da imagem do produto) e Locals +
    * Marcas (para decidir se o botao Localizar fica habilitado). Estas
    * properties sao o destino dessa leitura, feita por CarregarDoCursor().
    *==========================================================================

    *-- Codigo do produto da linha corrente (crItensLoc.Cpros, char(14))
    this_cCprosAtual = ""

    *-- Descricao do produto da linha corrente (crItensLoc.Dpros)
    this_cDprosAtual = ""

    *-- Localizacao JA atribuida ao produto da linha corrente
    *-- (crItensLoc.Locals, char(10)); fica vazia enquanto o item nao foi
    *-- localizado
    this_cLocalAtual = ""

    *-- Flag de selecao da linha corrente (crItensLoc.Marcas): 0 = nao
    *-- marcada, 1 = marcada. NUMERICA, igual ao "0 as Marcas" do Select
    *-- Distinct legado: comparar com 0/1, nunca com .F./.T.
    this_nMarcasAtual = 0

    *--------------------------------------------------------------------------
    * Init - Recebe o modo de abertura e a origem, vindos do form PAI
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEscolha, par_cOrigem)
        * Sem tabela propria: este BO nao faz CRUD contra o SQL Server
        DODEFAULT("")

        IF VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = par_cEscolha
        ENDIF

        IF VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = par_cOrigem
        ENDIF

        *-- O Init legado cria csLocals (derrubando um remanescente) antes
        *-- de qualquer coisa. Fazer isso aqui garante que
        *-- cursor_4c_Selecionados exista desde a construcao, sem depender
        *-- de o Form lembrar de chamar PrepararCursores().
        THIS.PrepararCursores()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - (Re)monta cursor_4c_Itens a partir de crTpmMvItn.
    * Equivalente ao trecho do Init legado:
    *   Select Distinct 0 as Marcas, Cpros, Dpros,
    *     Iif(pcOrigem='ORIGEM', LocalOs, Locals) as Locals
    *     From crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc
    * seguido do Index on Cpros Tag Cpros do MontaGrade (a grade em si -
    * RecordSource/ControlSource/Refresh - fica no Form, que a reconfigura
    * apos chamar este metodo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorOrigem)
            THIS.this_cMensagemErro = "Cursor de itens do movimento (" + ;
                THIS.this_cCursorOrigem + ") n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF

        SELECT DISTINCT 0 AS Marcas, Cpros, Dpros, ;
                IIF(THIS.this_cOrigem == "ORIGEM", LocalOs, Locals) AS Locals ;
            FROM (THIS.this_cCursorOrigem) ;
            WHERE !EMPTY(Cpros) ;
            INTO CURSOR (THIS.this_cCursorItens) READWRITE

        IF USED(THIS.this_cCursorItens)
            SELECT (THIS.this_cCursorItens)
            INDEX ON Cpros TAG Cpros
            GO TOP
            loc_lSucesso = .T.
        ELSE
            THIS.this_cMensagemErro = "Falha ao montar a grade de itens."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursores - Cria (zerado) o cursor de itens selecionados.
    * Equivalente ao trecho do Init legado:
    *   If Used([csLocals]) / Use in csLocals / EndIf
    *   Create Cursor csLocals(Cpros c(14), Locals c(10))
    * O legado DERRUBA um csLocals remanescente antes de recriar, e isso eh
    * regra e nao detalhe: este dialogo eh reaberto a cada movimento, e um
    * cursor sobrevivente de uma abertura anterior faria o Confirmar()
    * aplicar localizacoes de OUTRO movimento, sem erro e sem aviso. Por isso
    * a criacao mora aqui (o Form chama na abertura) e nao so embutida no
    * Localizar().
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursores()
        LOCAL loc_nAreaAnterior

        *-- CREATE CURSOR SELECIONA o cursor criado. Como este metodo roda
        *-- no Init (construcao do BO), deixar a area trocada mudaria o
        *-- cursor corrente POR BAIXO do form PAI, que tem crTpmMvItn
        *-- selecionado. O legado contorna com um "Select crTpmMvItn"
        *-- logo depois; aqui salva e restaura, que nao depende de quem chama.
        loc_nAreaAnterior = SELECT()

        IF USED(THIS.this_cCursorSelecionados)
            USE IN (THIS.this_cCursorSelecionados)
        ENDIF

        CREATE CURSOR (THIS.this_cCursorSelecionados) (Cpros C(14), Locals C(10))

        SELECT (loc_nAreaAnterior)

        THIS.this_cBaseLocalizacao     = ""
        THIS.this_cDescBaseLocalizacao = ""

        THIS.LimparLinhaAtual()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparLinhaAtual - Zera as properties da linha corrente da grade.
    * Usado pelo PrepararCursores e pelo CarregarDoCursor quando o cursor
    * esta vazio ou em EOF (nenhuma linha corrente para ler).
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaAtual()
        THIS.this_cCprosAtual  = ""
        THIS.this_cDprosAtual  = ""
        THIS.this_cLocalAtual  = ""
        THIS.this_nMarcasAtual = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le a linha CORRENTE do cursor da grade de itens para
    * as properties this_*Atual.
    * Equivalente as leituras de crItensLoc feitas pelo
    * SigOpLcZ.grdItens.AfterRowColChange:
    *   crItensLoc.Cpros  -> consulta da imagem (ObterImagemProduto)
    *   crItensLoc.Locals -> regra de habilitacao do Localizar
    *   crItensLoc.Marcas -> regra de habilitacao do Localizar
    * Chamado SEM argumento, le o proprio cursor_4c_Itens
    * (this_cCursorItens), que eh o uso normal a partir do
    * AfterRowColChange da grade.
    *
    * Guarda de EOF/BOF obrigatoria: o cursor fica vazio quando todos os
    * itens ja foram localizados (o Localizar() apaga as linhas marcadas), e
    * ler campo em EOF devolveria o valor da ULTIMA linha apagada,
    * reabilitando o Localizar para um produto que nao esta mais na grade.
    *
    * A area de trabalho do chamador eh salva e restaurada (o lnOldSel do
    * legado): este metodo eh um LEITOR e nao deve deixar o cursor da grade
    * selecionado por efeito colateral.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND ;
            !EMPTY(par_cAliasCursor), par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias)
            THIS.LimparLinhaAtual()
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF() OR RECCOUNT() = 0
                THIS.LimparLinhaAtual()
            ELSE
                THIS.this_cCprosAtual  = ALLTRIM(TratarNulo(Cpros, ""))
                THIS.this_cDprosAtual  = ALLTRIM(TratarNulo(Dpros, ""))
                THIS.this_cLocalAtual  = ALLTRIM(TratarNulo(Locals, ""))
                THIS.this_nMarcasAtual = TratarNulo(Marcas, 0)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        SELECT (loc_nAreaAnterior)

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeLocalizar - Regra de habilitacao do botao Localizar para a linha
    * corrente da grade.
    * Equivalente ao final do SigOpLcZ.grdItens.AfterRowColChange:
    *   If Empty(crItensLoc.Locals) And Not Empty(crItensLoc.Marcas)
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .T.
    *   Else
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .F.
    *   EndIf
    * FONTE UNICA: quem calcula eh o BO e o Form so espelha em .Enabled -
    * reescrever a condicao no Form faria as duas divergirem.
    * Pressupoe CarregarDoCursor() ja chamado para a linha corrente.
    *--------------------------------------------------------------------------
    PROCEDURE PodeLocalizar()
        RETURN EMPTY(THIS.this_cLocalAtual) AND THIS.this_nMarcasAtual <> 0
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeEditar - O modo de abertura permite marcar/limpar/localizar?
    * Equivalente ao When() que o legado repete em grdItens.Column3.Check1,
    * nos dois CommandGroup cmdAcoes, em apaga e em SelTudo:
    *   Return(InList(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
    * FONTE UNICA dessa regra: os controles do Form espelham este metodo em
    * vez de repetir o INLIST.
    * O UPPER/ALLTRIM eh defensivo - this_cEscolha pode chegar de um campo
    * char padded do chamador, e SET EXACT ON (config.prg) faria o INLIST
    * falhar com o padding.
    *--------------------------------------------------------------------------
    PROCEDURE PodeEditar()
        RETURN INLIST(UPPER(ALLTRIM(NVL(THIS.this_cEscolha, ""))), ;
            "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca todas as linhas de cursor_4c_Itens.
    * Equivalente ao SigOpLcZ.SelTudo.Click
    *   (Replace All crItensLoc.Marcas with 1).
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        IF !USED(THIS.this_cCursorItens)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH 1
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todas as linhas de cursor_4c_Itens.
    * Equivalente ao SigOpLcZ.apaga.Click
    *   (Replace All crItensLoc.Marcas with 0).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF !USED(THIS.this_cCursorItens)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH 0
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Localizar - Move os itens marcados de cursor_4c_Itens para
    * cursor_4c_Selecionados, usando a base escolhida (this_cBaseLocalizacao).
    * Equivalente ao SigOpLcZ.cmdAcoes.btnLocalizar.Click:
    *   valida getBase.Value; Scan For Marcas <> 0 em crItensLoc, Append
    *   Blank em csLocals (Cpros, Locals = base escolhida); Delete From
    *   crItensLoc Where Marcas <> 0; limpa getBase/getDBase.
    *--------------------------------------------------------------------------
    PROCEDURE Localizar()
        LOCAL loc_cCpros

        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cBaseLocalizacao, "")))
            THIS.this_cMensagemErro = "Informar a Base da Localiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorItens)
            THIS.this_cMensagemErro = "A grade de itens n" + CHR(227) + "o est" + CHR(225) + " carregada."
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorSelecionados)
            CREATE CURSOR (THIS.this_cCursorSelecionados) (Cpros C(14), Locals C(10))
        ENDIF

        SELECT (THIS.this_cCursorItens)
        GO TOP
        SCAN FOR Marcas <> 0
            loc_cCpros = Cpros

            SELECT (THIS.this_cCursorSelecionados)
            APPEND BLANK
            REPLACE Cpros  WITH loc_cCpros
            REPLACE Locals WITH THIS.this_cBaseLocalizacao

            SELECT (THIS.this_cCursorItens)
        ENDSCAN

        SELECT (THIS.this_cCursorItens)
        DELETE FOR Marcas <> 0
        GO TOP

        THIS.this_cBaseLocalizacao = ""
        THIS.this_cDescBaseLocalizacao = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Confirmar - Aplica cursor_4c_Selecionados de volta em crTpmMvItn.
    * Equivalente ao SigOpLcZ.cntBotoes.btnConfirmar.Click:
    *   Scan em csLocals; Update crTpmMvItn Set Localos|Locals =
    *   csLocals.Locals Where Cpros = csLocals.Cpros, conforme this_cOrigem.
    * Sem linhas em cursor_4c_Selecionados (nenhum item foi Localizar()ado),
    * eh um no-op valido - o legado tambem nao faz nada no Scan vazio.
    *--------------------------------------------------------------------------
    PROCEDURE Confirmar()
        LOCAL loc_cCpros, loc_cLocal, loc_lOrigem

        IF !USED(THIS.this_cCursorSelecionados)
            RETURN .T.
        ENDIF

        loc_lOrigem = (THIS.this_cOrigem == "ORIGEM")

        SELECT (THIS.this_cCursorSelecionados)
        GO TOP
        SCAN
            loc_cCpros = Cpros
            loc_cLocal = Locals

            SELECT (THIS.this_cCursorOrigem)
            IF loc_lOrigem
                REPLACE ALL LocalOs WITH loc_cLocal FOR Cpros = loc_cCpros
            ELSE
                REPLACE ALL Locals WITH loc_cLocal FOR Cpros = loc_cCpros
            ENDIF

            SELECT (THIS.this_cCursorSelecionados)
        ENDSCAN

        SELECT (THIS.this_cCursorOrigem)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Devolve o conteudo de SigCdPro.FigJpgs (base64) do
    * produto informado, ou .NULL. se nao houver imagem.
    * Equivalente ao
    *   ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *     crItensLoc.Cpros,'FigJpgs')
    * do SigOpLcZ.grdItens.AfterRowColChange. A decodificacao do base64 e a
    * gravacao do arquivo .jpg temporario (StrToFile) ficam no Form, que eh
    * quem conhece o controle Image que vai exibi-la.
    *--------------------------------------------------------------------------
    PROCEDURE ObterImagemProduto(par_cCpros)
        LOCAL loc_cCursorTemp, loc_cSQL, loc_xRetorno

        loc_xRetorno = .NULL.

        IF EMPTY(ALLTRIM(NVL(par_cCpros, "")))
            RETURN loc_xRetorno
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_xRetorno
        ENDIF

        loc_cCursorTemp = "cursor_4c_ImgProdTmp"
        IF USED(loc_cCursorTemp)
            USE IN (loc_cCursorTemp)
        ENDIF

        loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
            EscaparSQL(ALLTRIM(par_cCpros))

        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp) > 0
            IF USED(loc_cCursorTemp) AND RECCOUNT(loc_cCursorTemp) > 0
                IF !ISNULL(EVALUATE(loc_cCursorTemp + ".FigJpgs")) AND ;
                        !EMPTY(EVALUATE(loc_cCursorTemp + ".FigJpgs"))
                    loc_xRetorno = EVALUATE(loc_cCursorTemp + ".FigJpgs")
                ENDIF
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Erro ao buscar imagem do produto: " + CapturarErroSQL()
        ENDIF

        IF USED(loc_cCursorTemp)
            USE IN (loc_cCursorTemp)
        ENDIF

        RETURN loc_xRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores de trabalho criados por este BO.
    * Equivalente ao SigOpLcZ.Release: Use In crItensLoc / Use In csLocals.
    * (cursor_4c_Itens / cursor_4c_Selecionados). crTpmMvItn eh do form PAI e
    * NAO eh fechado aqui.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF

        IF USED(THIS.this_cCursorSelecionados)
            USE IN (THIS.this_cCursorSelecionados)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

