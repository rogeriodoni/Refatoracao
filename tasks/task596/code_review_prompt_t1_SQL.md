# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SERVICOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS

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
  Column1.ControlSource = "CodBarra"
  Column2.ControlSource = "CPros"
  Column3.ControlSource = "Dopes"
  Column4.ControlSource = "Numes"
  Column5.ControlSource = "QtdeLido"
Select TmpBaixa
Delete All
Select TmpEnc
Delete All For Empty(Dopps) Or Empty(Numps)
	Select crSigOpEtq
				Select crSigMvCab
						lcQuery = [Select cIdChaves, QtBaixas, Qtds ] + ;
								    [From SigMvItn ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
						Select LocalEestI
								lcQuery = [Update SigMvItn ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigMvItn 1)')
						lcQuery = [Select cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds ] + ;
								    [From SigMvIts ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEstI2') < 1)
						Select LocalEstI2
							lcQuery = [Select cIdChaves, QtBaixas, Qtds ] + ;
									    [From SigMvItn ] + ;
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
								lcQuery = [Update SigMvIts ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigMvIts 1)')
								lcQuery = [Update SigMvItn ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigMvItn 3)')
				Insert Into TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, Nops, Grupods, Contads) ;
				Insert Into TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, Nops, Grupods, Contads) ;
Select TmpBaixa
	.Column1.ControlSource = 'TmpBaixa.CodBarra'
	.Column2.ControlSource = 'TmpBaixa.Cpros'
	.Column3.ControlSource = 'TmpBaixa.Dopes'
	.Column4.ControlSource = 'TmpBaixa.Numes'
	.Column5.ControlSource = 'TmpBaixa.QtdeLido'
Select TmpBaixa
	If Seek(This.Value)
		=Seek(This.Value)
Select xGrava
Select Distinct Grupods, Contads ;
  From TmpBaixa ;
Select xCabec
	Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
	Select TmpBaixa
		Insert Into crSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, Opers, Grupos, Estos, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, Opers, Grupos, Estos, ;
		lcQuery = [Update SigOpEtq ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpEtq') < 1)
Select Min(Datas) as Datas From CrSigMvCab Into Cursor TmpGdm
If Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
	If Not ThisForm.poDataMgr.Update('crSigMvItn')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
	If Not ThisForm.poDataMgr.Update('crSigMvHst')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
Select TmpBaixa

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1037 linhas total):

*-- Linhas 17 a 35:
17: *     cursor_4c_Baixa pre-criado com a MESMA estrutura que
18: *     o metodo de carga de etiquetas do SIGPRCPRBO usa)
19: *   - VincularGrid (bind do cursor + larguras + headers, na ordem canonica
20: *     RecordSource -> ControlSource -> Width -> Header1.Caption)
21: *   - CarregarDados (equivalente a "PROCEDURE carregabars" do legado:
22: *     carga do cursor da grade + GO TOP + Refresh + visibilidade dos
23: *     controles conforme Eof())
24: *   - AjustarVisibilidadePorEtiquetas (Grade/Txt_Leitura/Get_Leitura/Ok/
25: *     Conferencia .Visible = Not Eof(), igual ao fim do carregabars legado)
26: *   - ConfigurarBotoes (cmd_4c_Conferencia/cmd_4c_Ok/cmd_4c_Sair) + handlers
27: *     Click (delegam a SIGPRCPRBO.ConferenciaAutomatica()/
28: *     ConfirmarConferencia())
29: *
30: * Fase 5/8: Campo Data (1a metade dos campos principais).
31: *   - ConfigurarCampoData (lbl_4c_Label2 + txt_4c_Data - equivalente a
32: *     Label2/Get_Data do legado: TextBox READONLY que so exibe a data
33: *     recebida do form pai, igual ao "Get_Data.When = Return .f." +
34: *     "ThisForm.Get_Data.Value = ThisForm.ParentForm.Get_Data.Value" do
35: *     Init legado)

*-- Linhas 441 a 459:
441:     * campo: o clique em Ok eh engolido e o usuario clica de novo. Isso eh
442:     * reproduzido pelo SetFocus do fim de ValidarLeituraCodigoBarra.
443:     *
444:     * SEM chamar CarregarDados/SQLEXEC aqui (regra do projeto: LostFocus
445:     * dispara sempre e nao serve para recarga) - so o processamento da leitura
446:     * em aberto, com a guarda de reentrancia.
447:     *==========================================================================
448:     PROCEDURE LeituraLostFocus(par_nKeyCode, par_nShiftAltCtrl)
449:         SET CONFIRM OFF
450: 
451:         IF THIS.this_lProcessandoLeitura
452:             RETURN
453:         ENDIF
454: 
455:         IF VARTYPE(THIS.txt_4c_Leitura) != "O" OR THIS.txt_4c_Leitura.Value = 0
456:             RETURN
457:         ENDIF
458: 
459:         THIS.ValidarLeituraCodigoBarra()

*-- Linhas 529 a 566:
529:     * default "cursor_4c_Baixa" - equivalente a TmpBaixa do legado).
530:     *
531:     * O cursor eh pre-criado AQUI, vazio, com a estrutura EXATA da
532:     * CREATE CURSOR do BO (regra do projeto: Column.ControlSource antes do
533:     * cursor existir derruba o Init - erro176/regra #41) - sem isso o
534:     * ColumnN.ControlSource abaixo estouraria "Alias is not found" e o
535:     * CREATEOBJECT("FormSIGPRCPR") devolveria .F. antes de qualquer etiqueta
536:     * ser carregada.
537:     *
538:     * Grid.Visible = .F. (legado: Grade.Visible = .F. no SCX, so vira .T.
539:     * quando ha etiquetas em aberto - equivalente a "ThisForm.Grade.Visible
540:     * = Not Eof()" no fim do CarregaBars legado). TornarControlesVisiveis
541:     * tem de IGNORAR este controle (ver skip abaixo).
542:     *==========================================================================
543:     PROTECTED PROCEDURE ConfigurarGrid()
544:         LOCAL loc_cCursor
545: 
546:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa
547: 
548:         IF USED(loc_cCursor)
549:             USE IN (loc_cCursor)
550:         ENDIF
551:         CREATE CURSOR (loc_cCursor) ;
552:             (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
553:              Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))
554: 
555:         *-- Os MESMOS dois indices que o metodo de carga de etiquetas do SIGPRCPRBO
556:         *-- cria. Nao eh enfeite: o cursor placeholder tem de ser IDENTICO ao do
557:         *-- BO (campos E tags). SIGPRCPRBO.ProcessarLeituraCodigoBarra() e
558:         *-- ConferenciaAutomatica() fazem "SET ORDER TO TAG CodBarra" antes do
559:         *-- SEEK (igual ao "Set Order to CodBarra" do Valid legado) e
560:         *-- ConfirmarConferencia() usa "TAG GruConta" (o "Set Order to GruConta"
561:         *-- do Ok legado). Sem as tags aqui, o SET ORDER estoura "Table has no
562:         *-- index order set" FORA de qualquer TRY/CATCH - o usuario ve o
563:         *-- Program Error CRU do VFP no lugar do dialogo do sistema.
564:         INDEX ON CodBarra TAG CodBarra
565:         INDEX ON Grupods + Contads TAG GruConta
566: 

*-- Linhas 574 a 592:
574:             .FontSize          = 8
575:             .AllowHeaderSizing = .F.
576:             .AllowRowSizing    = .F.
577:             .DeleteMark        = .F.
578:             .RecordMark        = .F.
579:             .RowHeight         = 17
580:             .ScrollBars        = 2
581:             .ReadOnly          = .T.
582:             .ColumnCount       = 5
583:             .Visible           = .F.
584:         ENDWITH
585: 
586:         *-- Propriedades que NAO dependem do cursor (nao sao perdidas quando o
587:         *-- RecordSource eh reatribuido). Column.ReadOnly vem DEPOIS do
588:         *-- Grid.ReadOnly acima, senao o do grid sobrescreve o das colunas.
589:         WITH THIS.grd_4c_Dados.Column1
590:             .FontSize          = 8
591:             .Movable           = .F.
592:             .Resizable         = .F.

*-- Linhas 641 a 670:
641: 
642:     *==========================================================================
643:     * VincularGrid - Liga a grade ao cursor de baixa. Equivalente ao bloco
644:     * "with ThisForm.Grade / .RecordSource = 'TmpBaixa' / .ColumnN.ControlSource
645:     * = 'TmpBaixa.<col>' / .Refresh / EndWith" que o Init legado executa DEPOIS
646:     * do CarregaBars.
647:     *
648:     * Tem de ser um metodo separado (e nao ficar so dentro do ConfigurarGrid)
649:     * porque o metodo de carga de etiquetas do SIGPRCPRBO faz USE IN + CREATE CURSOR
650:     * no cursor da grade: o cursor eh DESTRUIDO e recriado a cada carga, o que
651:     * derruba o binding do Grid. Por isso CarregarDados() chama este metodo
652:     * depois de cada carga.
653:     *
654:     * ORDEM CANONICA obrigatoria: RecordSource -> ControlSource -> Width ->
655:     * Header1.Caption. Atribuir RecordSource/ControlSource RECALCULA as larguras
656:     * das colunas para o default (~90) e reseta os captions dos headers, entao
657:     * Width e Header1.Caption tem de ser reaplicados DEPOIS - senao a grade
658:     * abre com colunas quadradas e headers "Header1".
659:     *
660:     * Larguras/captions/DynamicForeColor EXATOS do SCX legado (Column1..5:
661:     * 108/108/154/61/75; regra do DynamicForeColor: azul quando QtdeLido <> 0,
662:     * que eh o "Iif( TmpBaixa.QtdeLido#0, Rgb(0,0,255), Rgb(0,0,0) )" legado).
663:     *==========================================================================
664:     PROCEDURE VincularGrid()
665:         LOCAL loc_cCursor, loc_cCorDinamica
666: 
667:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
668:             RETURN .F.
669:         ENDIF
670: 

*-- Linhas 684 a 714:
684: 
685:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
686: 
687:         THIS.grd_4c_Dados.Column1.ControlSource = loc_cCursor + ".CodBarra"
688:         THIS.grd_4c_Dados.Column2.ControlSource = loc_cCursor + ".CPros"
689:         THIS.grd_4c_Dados.Column3.ControlSource = loc_cCursor + ".Dopes"
690:         THIS.grd_4c_Dados.Column4.ControlSource = loc_cCursor + ".Numes"
691:         THIS.grd_4c_Dados.Column5.ControlSource = loc_cCursor + ".QtdeLido"
692: 
693:         THIS.grd_4c_Dados.Column1.DynamicForeColor = loc_cCorDinamica
694:         THIS.grd_4c_Dados.Column2.DynamicForeColor = loc_cCorDinamica
695:         THIS.grd_4c_Dados.Column3.DynamicForeColor = loc_cCorDinamica
696:         THIS.grd_4c_Dados.Column4.DynamicForeColor = loc_cCorDinamica
697:         THIS.grd_4c_Dados.Column5.DynamicForeColor = loc_cCorDinamica
698: 
699:         *-- Width DEPOIS do RecordSource/ControlSource (ordem obrigatoria)
700:         THIS.grd_4c_Dados.Column1.Width = 108
701:         THIS.grd_4c_Dados.Column2.Width = 108
702:         THIS.grd_4c_Dados.Column3.Width = 154
703:         THIS.grd_4c_Dados.Column4.Width = 61
704:         THIS.grd_4c_Dados.Column5.Width = 75
705: 
706:         *-- Header1.Caption DEPOIS do RecordSource (senao volta a "Header1")
707:         THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
708:         THIS.grd_4c_Dados.Column2.Header1.Caption = "Produto"
709:         THIS.grd_4c_Dados.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
710:         THIS.grd_4c_Dados.Column4.Header1.Caption = "N" + CHR(250) + "mero"
711:         THIS.grd_4c_Dados.Column5.Header1.Caption = "Qtde."
712: 
713:         RETURN .T.
714:     ENDPROC

*-- Linhas 725 a 743:
725:     * primeiro registro, repinta e ajusta a visibilidade dos controles.
726:     *
727:     * Fim do carregabars legado, reproduzido fielmente:
728:     *   Select TmpBaixa / Go Top
729:     *   If Eof() / =Messagebox('Nenhuma Etiqueta Selecionada Nesta Operacao!!!', 32, '')
730:     *   ThisForm.Grade.Visible = Not Eof()   (idem Txt_Leitura/Get_Leitura/Ok/Conferencia)
731:     *   ThisForm.Get_Leitura.SetFocus
732:     *
733:     * O legado NAO aborta a tela quando nao ha etiqueta: apenas avisa e esconde
734:     * os controles de conferencia, deixando so o Encerrar. Retorna .T. quando
735:     * ha pelo menos uma etiqueta em aberto.
736:     *==========================================================================
737:     PROCEDURE CarregarDados()
738:         LOCAL loc_lTemEtiquetas, loc_cCursor, loc_oErro, loc_lAvisoExibido
739: 
740:         loc_lTemEtiquetas = .F.
741:         loc_lAvisoExibido = .F.
742: 
743:         TRY

*-- Linhas 757 a 779:
757:                 ENDIF
758: 
759:                 *-- Re-vincula SEMPRE: a carga de etiquetas fez
760:                 *-- USE IN + CREATE CURSOR e o binding do Grid caiu.
761:                 THIS.VincularGrid()
762: 
763:                 IF USED(loc_cCursor)
764:                     SELECT (loc_cCursor)
765:                     GO TOP
766:                     loc_lTemEtiquetas = !EOF(loc_cCursor)
767:                 ENDIF
768: 
769:                 *-- Aviso do legado. Suprimido quando o BO ja explicou o
770:                 *-- motivo acima, para nao empilhar dois dialogos (o legado
771:                 *-- exibe UMA mensagem).
772:                 IF !loc_lTemEtiquetas AND !loc_lAvisoExibido
773:                     MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
774:                              CHR(231) + CHR(227) + "o!!!", ;
775:                              "Aten" + CHR(231) + CHR(227) + "o")
776:                 ENDIF
777: 
778:                 THIS.AjustarVisibilidadePorEtiquetas(loc_lTemEtiquetas)
779: 


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Origem legada: SIGPRCPR.SCX (dialogo modal chamado por um form pai de
*                Ordem de Producao - recebe ParentForm, Get_Data.Value e
*                crSigCdPac.SigKeys do form que o abre)
* Herda de: BusinessBase
*
* Este dialogo NAO eh um CRUD de registro unico: ele confere (leitura de
* codigo de barra) etiquetas de producao ainda nao confirmadas e, ao
* confirmar, GERA em lote um cabecalho SigMvCab por combinacao Grupo/Conta
* de destino, com os detalhes SigMvItn e os DOIS historicos SigMvHst (saida
* da conta de confirmacao, entrada na conta de destino), alem de mover as
* etiquetas em SigOpEtq. Por isso a "gravacao" real fica em
* ConfirmarConferencia() (equivalente ao Click do Ok legado), e nao em
* Inserir()/Atualizar() por registro - ver comentario acima desses metodos.
*
* Fase 2/8: Metodos de negocio (equivalentes a CarregaBars/Valid do
* Get_Leitura/Click do Conferencia/Click do Ok do legado), CarregarDoCursor,
* ObterChavePrimaria.
*==============================================================================
DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Identificacao - a "entidade" persistida por este dialogo eh o
    *-- cabecalho de movimento gerado na confirmacao (equivalente ao Salvar)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "cidchaves"

    *-- Contexto recebido do form pai (fluxo modal legado via ParentForm)
    this_cEmpresa         = ""    && Empresa (Emps) - equivalente a go_4c_Sistema.cCodEmpresa do legado
    this_cUsuario         = ""    && Usuario logado (Usuar do legado)
    this_dDataBase        = {}    && Data (Get_Data.Value do form pai) - exibicao readonly
    this_cSigKey          = ""    && SigKeys (crSigCdPac.SigKeys do form pai/CarregarParametrosSistema)

    *-- Nome do cursor com as operacoes selecionadas no form pai (Dopps/Numps),
    *-- equivalente a TmpEnc do legado. O CALLER (form/BO chamador) deve
    *-- popular este cursor ANTES de chamar o metodo de carga de etiquetas.
    this_cCursorOperacoes = "cursor_4c_Operacoes"

    *-- Parametros do sistema (SigCdPam) usados na conferencia/reserva -
    *-- carregados por CarregarParametrosSistema()
    this_cGrupoConfirmacao   = ""    && GruConfs
    this_cContaConfirmacao   = ""    && ConConfs
    this_cDopeCitens         = ""    && DopeCitens (operacao de cite/transferencia parcial)
    this_cGrupoReserva       = ""    && GruReservs
    this_cContaReserva       = ""    && ConReservs
    this_cGrupoEstoque       = ""    && GrupoEsts
    this_cContaEstoque       = ""    && ContaEsts
    this_cDopeTransferencia  = ""    && TransfEncs (operacao do documento gerado ao confirmar)

    *-- Estado da grade de etiquetas (cursor equivalente a TmpBaixa do legado)
    this_cCursorBaixa      = "cursor_4c_Baixa"    && Nome fixo do cursor da grade
    this_lPossuiEtiquetas  = .F.                  && .T. quando ha pelo menos 1 etiqueta pendente

    *-- Leitura de codigo de barras
    this_cCodigoBarraLido  = ""

    *-- Linha CORRENTE do cursor de baixa (grid), populada por CarregarDoCursor
    *-- - espelha os campos de TmpBaixa do registro em foco na grade
    this_cCodigoBarraAtual    = ""
    this_cProdutoAtual        = ""
    this_cOperacaoAtual       = ""
    this_nNumeroAtual         = 0
    this_nQuantidadeAtual     = 0
    this_nQuantidadeLidaAtual = 0
    this_nSequenciaAtual      = 0
    this_cGrupoContaAtual     = ""    && Grupods da linha corrente
    this_cContaContaAtual     = ""    && Contads da linha corrente

    *-- Chave do ultimo documento de conferencia gerado (SigMvCab.cidchaves) -
    *-- usada por ObterChavePrimaria()/RegistrarAuditoria() ao confirmar
    this_cCidChaveGerada = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"

            IF EMPTY(THIS.this_cCursorOperacoes)
                THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
            ENDIF
            IF EMPTY(THIS.this_cCursorBaixa)
                THIS.this_cCursorBaixa = "cursor_4c_Baixa"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGPRCPRBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarEmpDopNums / MontarEmpGruEsts - chaves POSICIONAIS concatenadas.
    * NUNCA usar ALLTRIM nas partes: o padding faz parte da chave (regra do
    * projeto sobre chaves posicionais - Erro177). EmpDopNums = Emps(3) +
    * Dopes(20) + Str(Numes,6) = 29 (bate com char(29) do schema). EmpGruEsts
    * = Emp(3) + Grupo(10) + Conta(10) = 23 (bate com char(23) do schema).
    *==========================================================================
    PROTECTED PROCEDURE MontarEmpDopNums(par_cEmp, par_cDope, par_nNume)
        RETURN PADR(par_cEmp, 3) + PADR(par_cDope, 20) + STR(par_nNume, 6)
    ENDPROC

    PROTECTED PROCEDURE MontarEmpGruEsts(par_cEmp, par_cGrupo, par_cConta)
        RETURN PADR(par_cEmp, 3) + PADR(par_cGrupo, 10) + PADR(par_cConta, 10)
    ENDPROC

    *==========================================================================
    * ConsultarRegistro - helper generico equivalente ao
    * ThisForm.poDataMgr.CursorQuery(tabela, alias, campoChave, valor, campos)
    * do legado: SELECT <campos> FROM <tabela> WHERE <condicao> INTO CURSOR
    * <alias>. Fecha o cursor anterior (se existir) antes de reconsultar.
    * Devolve .T. apenas quando a consulta teve sucesso E trouxe pelo menos
    * 1 linha (equivalente ao "If Not Eof()" que cerca cada CursorQuery no
    * legado).
    *==========================================================================
    PROTECTED PROCEDURE ConsultarRegistro(par_cTabela, par_cAlias, par_cWhere, par_cCampos)
        LOCAL loc_cSQL, loc_nResultado, loc_cCampos

        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF

        loc_cCampos = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + " WHERE " + par_cWhere

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

        RETURN (loc_nResultado >= 0) AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
    ENDPROC

    *==========================================================================
    * CarregarParametrosSistema - carrega os parametros de SigCdPam
    * (equivalente ao acesso direto a crSigCdPam no legado, que ja vinha
    * pre-carregado no startup do Fortyus - ver regra do projeto sobre
    * cursores globais Fortyus) e a SigKey de SigCdPac (Thisform.SigKey =
    * CrSigCdPac.SigKeys no Init legado). Chamado no inicio da
    * carga de etiquetas.
    *==========================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.ConsultarRegistro("SigCdPam", "cursor_4c_Pam", "1 = 1", ;
                    "GruConfs, ConConfs, DopeCitens, GruReservs, ConReservs, GrupoEsts, ContaEsts, TransfEncs")
                SELECT cursor_4c_Pam
                THIS.this_cGrupoConfirmacao  = TratarNulo(GruConfs, "")
                THIS.this_cContaConfirmacao  = TratarNulo(ConConfs, "")
                THIS.this_cDopeCitens        = TratarNulo(DopeCitens, "")
                THIS.this_cGrupoReserva      = TratarNulo(GruReservs, "")
                THIS.this_cContaReserva      = TratarNulo(ConReservs, "")
                THIS.this_cGrupoEstoque      = TratarNulo(GrupoEsts, "")
                THIS.this_cContaEstoque      = TratarNulo(ContaEsts, "")
                THIS.this_cDopeTransferencia = TratarNulo(TransfEncs, "")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Par" + CHR(226) + ;
                    "metros do Sistema N" + CHR(227) + "o Encontrada (SigCdPam)."
            ENDIF

            IF loc_lSucesso AND THIS.ConsultarRegistro("SigCdPac", "cursor_4c_Pac", "1 = 1", "SigKeys")
                THIS.this_cSigKey = TratarNulo(cursor_4c_Pac.SigKeys, "")
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CalcularQtdeBaixaCitacao - equivalente ao bloco "If Not
    * Empty(_DopeCit) ... EndIf" do CarregaBars legado. Quando existe uma
    * operacao de citacao (DopeCitens) e o documento gerador tambem existe
    * como movimento de citacao, aloca a quantidade da etiqueta contra as
    * linhas ainda nao baixadas (SigMvItn para produto simples - lnTipoEstos
    * = 1, SigMvIts+SigMvItn para produto com grade - lnTipoEstos 2/3/4) e
    * devolve a quantidade que foi baixada via citacao (_QtCit do legado).
    * Devolve -1 se uma escrita no SQL Server falhar (o caller deve abortar
    * o carregamento).
    *==========================================================================
    PROTECTED FUNCTION CalcularQtdeBaixaCitacao(par_cEmpos, par_cCPros, par_cCodCors, par_cCodTams, ;
            par_nNumeOs, par_nTipoEstos, par_nQtdeEtiqueta, par_dAgora)
        LOCAL loc_cChaveCite, loc_nBaixa, loc_nPendente, loc_nVal
        LOCAL loc_lBaixouTudo, loc_lPendenteMaior, loc_cSQL

        loc_nBaixa = par_nQtdeEtiqueta

        IF EMPTY(THIS.this_cDopeCitens)
            RETURN 0
        ENDIF

        loc_cChaveCite = THIS.MontarEmpDopNums(par_cEmpos, THIS.this_cDopeCitens, par_nNumeOs)

        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovCite", "EmpDopNums = " + EscaparSQL(loc_cChaveCite), "cidchaves")
            RETURN 0
        ENDIF

        IF par_nTipoEstos = 1
            IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItensCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + " AND CPros = " + EscaparSQL(par_cCPros), ;
                    "cIdChaves, QtBaixas, Qtds")
                SELECT cursor_4c_ItensCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF (cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas) != 0
                        loc_nPendente = cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas
                        IF loc_nPendente > loc_nBaixa
                            loc_nVal   = loc_nBaixa
                            loc_nBaixa = 0
                        ELSE
                            loc_nVal   = loc_nPendente
                            loc_nBaixa = loc_nBaixa - loc_nPendente
                        ENDIF
                        loc_lBaixouTudo = (cursor_4c_ItensCite.QtBaixas + loc_nVal = cursor_4c_ItensCite.Qtds)

                        loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                            "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + ", DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                            "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItensCite.cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI)" + CHR(13) + CapturarErroSQL()
                            RETURN -1
                        ENDIF
                        SQLCOMMIT(gnConnHandle)
                    ENDIF
                    SELECT cursor_4c_ItensCite
                ENDSCAN
            ENDIF
        ELSE
            IF THIS.ConsultarRegistro("SigMvIts", "cursor_4c_GradesCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + ;
                    " AND CPros = " + EscaparSQL(par_cCPros) + ;
                    " AND CodCors = " + EscaparSQL(par_cCodCors) + ;
                    " AND CodTams = " + EscaparSQL(par_cCodTams), ;
                    "cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds")
                SELECT cursor_4c_GradesCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItenCiteItn", ;
                            "EmpDopNums = " + EscaparSQL(cursor_4c_GradesCite.EmpDopNums) + ;
                            " AND CItens = " + FormatarNumeroSQL(cursor_4c_GradesCite.CItens, 0), ;
                            "cIdChaves, QtBaixas, Qtds")

                        loc_nPendente = cursor_4c_GradesCite.Qtds - cursor_4c_GradesCite.QtBaixas
                        IF loc_nPendente != 0
                            loc_lPendenteMaior = (loc_nPendente > loc_nBaixa)
                            loc_nVal        = IIF(loc_lPendenteMaior, loc_nBaixa, loc_nPendente)
                            loc_lBaixouTudo = (cursor_4c_GradesCite.QtBaixas + loc_nVal = cursor_4c_GradesCite.Qtds)

                            loc_cSQL = "UPDATE SigMvIts SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_GradesCite.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEstI2)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItenCiteItn.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI - CItens)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_nBaixa = IIF(loc_lPendenteMaior, 0, loc_nBaixa - loc_nPendente)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_GradesCite
                ENDSCAN
            ENDIF
        ENDIF

        RETURN par_nQtdeEtiqueta - loc_nBaixa
    ENDFUNC

    *==========================================================================
    * Carga das etiquetas do documento - equivalente a CarregaBars() do legado.
    * Para cada operacao (Dopps/Numps) do cursor THIS.this_cCursorOperacoes
    * (equivalente a TmpEnc, populado pelo CALLER), busca as etiquetas de
    * SigOpEtq atualmente na conta de confirmacao (GruConfs/ConConfs) e
    * calcula, para cada uma, a conta de destino (reserva do parametro, do
    * cliente ou do movimento de origem) e a parcela ja baixada por citacao
    * (CalcularQtdeBaixaCitacao), inserindo 1 ou 2 linhas por etiqueta em
    * THIS.this_cCursorBaixa (equivalente a TmpBaixa).
    *
    * Nao repinta grade nem mostra mensagem de "nenhuma etiqueta" - isso e
    * responsabilidade do Form (equivalente ao final de CarregaBars que
    * mexe em Visible/SetFocus), que deve checar THIS.this_lPossuiEtiquetas
    * apos chamar este metodo.
    *==========================================================================
    PROCEDURE CarregarEtiquetasPendentes()
        LOCAL loc_lSucesso, loc_oErro, loc_lProsseguir, loc_lFalhouCarga
        LOCAL loc_cChaveDoc, loc_dAgora
        LOCAL loc_nCBars, loc_cGrupos, loc_cContas, loc_cCPros, loc_cDopeOs, loc_cEmposE
        LOCAL loc_nNumeOs, loc_nNopsE, loc_nQtds, loc_cCodCorsE, loc_cCodTamsE
        LOCAL loc_cDopesOrigem, loc_cGrupoosOrig, loc_cContaosOrig, loc_cGrupodsOrig, loc_cContadsOrig
        LOCAL loc_lGlobalOuServico, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_nTipoEstos, loc_cCGrus, loc_cGruProds, loc_cConProds
        LOCAL loc_nQtEti, loc_nQtCit

        loc_lSucesso     = .F.
        loc_lProsseguir  = .T.
        loc_lFalhouCarga = .F.

        TRY
            IF USED(THIS.this_cCursorBaixa)
                USE IN (THIS.this_cCursorBaixa)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorBaixa) ;
                (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
                 Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))
            INDEX ON CodBarra TAG CodBarra
            INDEX ON Grupods + Contads TAG GruConta

            IF !THIS.CarregarParametrosSistema()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada para confer" + CHR(234) + "ncia."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_dAgora = DATETIME()

                SELECT (THIS.this_cCursorOperacoes)
                SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                    loc_cChaveDoc = THIS.MontarEmpDopNums(THIS.this_cEmpresa, Dopps, Numps)

                    IF !THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_Etiqueta", ;
                            "EmpDopNums = " + EscaparSQL(loc_cChaveDoc), "*")
                        SELECT (THIS.this_cCursorOperacoes)
                        LOOP
                    ENDIF

                    SELECT cursor_4c_Etiqueta
                    SCAN
                        loc_nCBars    = cursor_4c_Etiqueta.CBars
                        loc_cGrupos   = cursor_4c_Etiqueta.Grupos
                        loc_cContas   = cursor_4c_Etiqueta.Contas
                        loc_cCPros    = cursor_4c_Etiqueta.CPros
                        loc_cDopeOs   = cursor_4c_Etiqueta.DopeOs
                        loc_cEmposE   = cursor_4c_Etiqueta.Empos
                        loc_nNumeOs   = cursor_4c_Etiqueta.NumeOs
                        loc_nNopsE    = cursor_4c_Etiqueta.Nops
                        loc_nQtds     = cursor_4c_Etiqueta.Qtds
                        loc_cCodCorsE = cursor_4c_Etiqueta.CodCors
                        loc_cCodTamsE = cursor_4c_Etiqueta.CodTams

                        IF loc_cGrupos + loc_cContas != THIS.this_cGrupoConfirmacao + THIS.this_cContaConfirmacao
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF

                        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovOrigem", ;
                                "EmpDopNums = " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmposE, loc_cDopeOs, loc_nNumeOs)), "*")
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF
                        loc_cDopesOrigem = cursor_4c_MovOrigem.Dopes
                        loc_cGrupoosOrig = cursor_4c_MovOrigem.Grupoos
                        loc_cContaosOrig = cursor_4c_MovOrigem.Contaos
                        loc_cGrupodsOrig = cursor_4c_MovOrigem.Grupods
                        loc_cContadsOrig = cursor_4c_MovOrigem.Contads

                        loc_lGlobalOuServico = .F.
                        IF THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_TipoOper", ;
                                "Dopes = " + EscaparSQL(loc_cDopesOrigem), "Globalizas, Servicos")
                            loc_lGlobalOuServico = (cursor_4c_TipoOper.Globalizas = 1 OR cursor_4c_TipoOper.Servicos = 1)
                        ENDIF

                        IF loc_lGlobalOuServico
                            loc_cTGrupo = loc_cGrupoosOrig
                            loc_cTConta = loc_cContaosOrig
                        ELSE
                            loc_cTGrupo = loc_cGrupodsOrig
                            loc_cTConta = loc_cContadsOrig
                        ENDIF

                        loc_cGrupo = IIF(EMPTY(THIS.this_cGrupoReserva), loc_cTGrupo, THIS.this_cGrupoReserva)
                        loc_cConta = IIF(EMPTY(THIS.this_cContaReserva), loc_cTConta, THIS.this_cContaReserva)

                        loc_nTipoEstos = 1
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Produto", "CPros = " + EscaparSQL(loc_cCPros), "CGrus")
                            loc_cCGrus = cursor_4c_Produto.CGrus
                            IF THIS.ConsultarRegistro("SigCdGrp", "cursor_4c_Grupo", "CGrus = " + EscaparSQL(loc_cCGrus), "TipoEstos")
                                loc_nTipoEstos = IIF(INLIST(cursor_4c_Grupo.TipoEstos, 2, 3, 4), cursor_4c_Grupo.TipoEstos, 1)
                            ENDIF
                        ENDIF

                        IF THIS.ConsultarRegistro("SigCdCli", "cursor_4c_Cliente", "IClis = " + EscaparSQL(loc_cTConta), "GruProds, ConProds")
                            loc_cGruProds = TratarNulo(cursor_4c_Cliente.GruProds, "")
                            loc_cConProds = TratarNulo(cursor_4c_Cliente.ConProds, "")
                        ELSE
                            loc_cGruProds = ""
                            loc_cConProds = ""
                        ENDIF

                        loc_nQtCit = THIS.CalcularQtdeBaixaCitacao(loc_cEmposE, loc_cCPros, loc_cCodCorsE, loc_cCodTamsE, ;
                                        loc_nNumeOs, loc_nTipoEstos, loc_nQtds, loc_dAgora)

                        IF loc_nQtCit < 0
                            THIS.this_cMensagemErro = "Falha ao processar baixa de cita" + CHR(231) + CHR(227) + ;
                                "o para a etiqueta " + TRANSFORM(loc_nCBars) + "."
                            loc_lFalhouCarga = .T.
                            SELECT cursor_4c_Etiqueta
                            EXIT
                        ENDIF

                        loc_nQtEti = loc_nQtds - loc_nQtCit

                        loc_cGrupo = IIF(EMPTY(loc_cGruProds), loc_cGrupo, loc_cGruProds)
                        loc_cConta = IIF(EMPTY(loc_cConProds), loc_cConta, loc_cConProds)

                        IF loc_nQtEti != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtEti, 0, loc_nNopsE, loc_cGrupo, loc_cConta)
                        ENDIF

                        IF loc_nQtCit != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtCit, 0, loc_nNopsE, ;
                                        THIS.this_cGrupoEstoque, THIS.this_cContaEstoque)
                        ENDIF

                        SELECT cursor_4c_Etiqueta
                    ENDSCAN

                    SELECT (THIS.this_cCursorOperacoes)

                    IF loc_lFalhouCarga
                        EXIT
                    ENDIF
                ENDSCAN

                THIS.this_lPossuiEtiquetas = (RECCOUNT(THIS.this_cCursorBaixa) > 0)
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhouCarga = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao carregar etiquetas pendentes")
        ENDTRY

        loc_lSucesso = loc_lProsseguir AND !loc_lFalhouCarga

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura.
    * Recebe o codigo de barra digitado/lido e devolve um status para o
    * Form decidir a mensagem/refresh (o dialogo MsgAviso e o Refresh() do
    * Grid sao responsabilidade da UI, nao do BO):
    *   "VAZIO"          - nada foi digitado (o legado nao faz nada)
    *   "SEM_CURSOR"     - a carga de etiquetas ainda nao rodou
    *   "LIDO"           - encontrou a etiqueta e marcou QtdeLido = Qtde
    *   "JA_LIDO"        - encontrou a etiqueta mas ja estava conferida
    *   "NAO_CADASTRADO" - codigo de barra nao existe no cursor de baixa
    *==========================================================================
    FUNCTION ProcessarLeituraCodigoBarra(par_nCodigoBarra)
        LOCAL loc_cResultado

        loc_cResultado = "VAZIO"

        IF VARTYPE(par_nCodigoBarra) != "N" OR par_nCodigoBarra = 0
            RETURN loc_cResultado
        ENDIF

        THIS.this_cCodigoBarraLido = TRANSFORM(par_nCodigoBarra)

        IF !USED(THIS.this_cCursorBaixa)
            RETURN "SEM_CURSOR"
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra

        IF SEEK(par_nCodigoBarra)
            IF EVALUATE(THIS.this_cCursorBaixa + ".QtdeLido") = 0
                REPLACE QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)
                loc_cResultado = "LIDO"
            ELSE
                loc_cResultado = "JA_LIDO"
            ENDIF
        ELSE
            loc_cResultado = "NAO_CADASTRADO"
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * ConferenciaAutomatica - equivalente ao Click do botao "Conf. Auto"
    * (Conferencia): marca TODAS as etiquetas em aberto como conferidas.
    *==========================================================================
    PROCEDURE ConferenciaAutomatica()
        IF !USED(THIS.this_cCursorBaixa)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra
        REPLACE ALL QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE de THIS.this_cCursorBaixa
    * (equivalente a TmpBaixa) para as properties this_*Atual, usadas pelo
    * Form para exibir/realcar a linha em foco na grade.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoBarraAtual    = TRANSFORM(TratarNulo(CodBarra, 0))
            THIS.this_cProdutoAtual        = TratarNulo(CPros, "")
            THIS.this_cOperacaoAtual       = TratarNulo(Dopes, "")
            THIS.this_nNumeroAtual         = TratarNulo(Numes, 0)
            THIS.this_nQuantidadeAtual     = TratarNulo(Qtde, 0)
            THIS.this_nQuantidadeLidaAtual = TratarNulo(QtdeLido, 0)
            THIS.this_nSequenciaAtual      = TratarNulo(Nops, 0)
            THIS.this_cGrupoContaAtual     = TratarNulo(Grupods, "")
            THIS.this_cContaContaAtual     = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do documento de confirmacao gerado por
    * ConfirmarConferencia() (SigMvCab.cidchaves). So fica preenchida DEPOIS
    * de uma confirmacao com sucesso - eh o que RegistrarAuditoria() usa.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaveGerada
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - este dialogo NAO grava um
    * registro por vez: a "gravacao" real (equivalente ao Click do Ok
    * legado) e uma confirmacao em LOTE que cria 1 cabecalho SigMvCab por
    * combinacao Grupods/Contads presente no cursor de etiquetas conferidas,
    * mais os detalhes SigMvItn/SigMvHst e o reposicionamento das etiquetas
    * em SigOpEtq - por isso vive em ConfirmarConferencia(), que chama
    * THIS.RegistrarAuditoria() ao final com sucesso. O comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao
    * isolados) ja eh o correto para este dialogo.
    *==========================================================================

    *==========================================================================
    * ConfirmarConferencia - equivalente ao Click do Ok. Para cada
    * combinacao Grupods/Contads com QtdeLido <> 0 no cursor de baixa, gera
    * 1 cabecalho SigMvCab (documento TransfEncs), e para cada etiqueta
    * conferida daquele grupo/conta grava o detalhe SigMvItn e os 2
    * historicos SigMvHst (S = saida da conta de confirmacao, E = entrada
    * na conta de destino), recalculando custo/posicao (fRecalculaP/
    * fRecalculaC) e movendo a etiqueta em SigOpEtq para o grupo/conta de
    * destino. Tudo dentro de uma unica transacao manual (Transactions=2
    * neste ambiente): falha em qualquer passo faz SQLROLLBACK, sucesso
    * completo faz SQLCOMMIT + RegistrarAuditoria.
    *==========================================================================
    FUNCTION ConfirmarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_lFalhou, loc_lProsseguir
        LOCAL loc_cDope, loc_nNume, loc_cChaveCab, loc_cGrupoCab, loc_cContaCab
        LOCAL loc_nItem, loc_cSQL, loc_dAgora, loc_cCidC, loc_nSeq, loc_cCidCE, loc_nSeqE
        LOCAL loc_cCunis, loc_cDpros, loc_cCodCors, loc_cCodTams, loc_cEmpos
        LOCAL loc_nCodBarraLin, loc_cCProsLin, loc_nQtdeLidaLin

        loc_lSucesso    = .F.
        loc_lFalhou     = .F.
        loc_lProsseguir = .T.

        IF !USED(THIS.this_cCursorBaixa) OR RECCOUNT(THIS.this_cCursorBaixa) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " etiquetas carregadas para confirmar."
            RETURN .F.
        ENDIF

        TRY
            loc_dAgora = DATETIME()
            loc_cDope  = THIS.this_cDopeTransferencia

            IF USED("cursor_4c_ConfCabec")
                USE IN cursor_4c_ConfCabec
            ENDIF
            SELECT DISTINCT Grupods, Contads ;
                FROM (THIS.this_cCursorBaixa) ;
                WHERE QtdeLido != 0 ;
                INTO CURSOR cursor_4c_ConfCabec READWRITE

            IF RECCOUNT("cursor_4c_ConfCabec") = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta foi conferida - realize a leitura antes de confirmar."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_ConfCabec
                SCAN
                    loc_cGrupoCab = cursor_4c_ConfCabec.Grupods
                    loc_cContaCab = cursor_4c_ConfCabec.Contads

                    loc_nNume     = fGerUniqueKey(THIS.this_cEmpresa + loc_cDope)
                    loc_cChaveCab = THIS.MontarEmpDopNums(THIS.this_cEmpresa, loc_cDope, loc_nNume)

                    loc_cSQL = "INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                        "Grupoos, Contaos, Grupods, Contads, EmpDopNums, cidchaves, DtAlts, EmpGopNums) VALUES (" + ;
                        EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + FormatarNumeroSQL(loc_nNume, 0) + ", " + ;
                        EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                        EscaparSQL(THIS.this_cUsuario) + ", " + EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", " + ;
                        EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", " + ;
                        EscaparSQL(loc_cChaveCab) + ", " + EscaparSQL(fUniqueIds()) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                        EscaparSQL(THIS.MontarEmpDopNums(THIS.this_cEmpresa, "", 0)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvCab)" + CHR(13) + CapturarErroSQL()
                        loc_lFalhou = .T.
                        SELECT cursor_4c_ConfCabec
                        EXIT
                    ENDIF

                    THIS.this_cCidChaveGerada = loc_cChaveCab

                    loc_nItem = 0
                    SELECT (THIS.this_cCursorBaixa)
                    SCAN FOR Grupods + Contads == loc_cGrupoCab + loc_cContaCab AND QtdeLido != 0
                        loc_nItem        = loc_nItem + 1
                        loc_nCodBarraLin = CodBarra
                        loc_cCProsLin    = CPros
                        loc_nQtdeLidaLin = QtdeLido

                        loc_cCunis = ""
                        loc_cDpros = ""
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_ProdutoConf", "CPros = " + EscaparSQL(loc_cCProsLin), "Cunis, Dpros")
                            loc_cCunis = TratarNulo(cursor_4c_ProdutoConf.Cunis, "")
                            loc_cDpros = TratarNulo(cursor_4c_ProdutoConf.Dpros, "")
                        ENDIF

                        loc_cCodCors = ""
                        loc_cCodTams = ""
                        loc_cEmpos   = ""
                        IF THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_EtiquetaConf", ;
                                "CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0), "CodCors, CodTams, Empos")
                            loc_cCodCors = TratarNulo(cursor_4c_EtiquetaConf.CodCors, "")
                            loc_cCodTams = TratarNulo(cursor_4c_EtiquetaConf.CodTams, "")
                            loc_cEmpos   = TratarNulo(cursor_4c_EtiquetaConf.Empos, "")
                        ENDIF

                        loc_cSQL = "INSERT INTO SigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, " + ;
                            "CodBarras, EmpDopNums, cIdChaves, DtAlts) VALUES (" + ;
                            FormatarNumeroSQL(loc_nItem, 0) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + ;
                            FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + ;
                            FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", " + EscaparSQL(loc_cCunis) + ", " + ;
                            EscaparSQL(loc_cDpros) + ", " + EscaparSQL("S") + ", " + ;
                            FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + ;
                            EscaparSQL(loc_cChaveCab) + ", " + EscaparSQL(fUniqueIds()) + ", " + FormatarDataSQL(loc_dAgora) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvItn)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        loc_nSeq  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidC = DTOS(DATE()) + "S" + TRANSFORM(loc_nSeq, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, " + ;
                            "Opers, Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, EmpGruEsts, " + ;
                            "OriDopNums, Seqs) VALUES (" + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                            EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + ;
                            FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + ;
                            FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", " + EscaparSQL("S") + ", " + ;
                            EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", " + ;
                            FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + EscaparSQL(loc_cCidC) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeq, 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - S)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_nSeqE  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidCE = DTOS(DATE()) + "E" + TRANSFORM(loc_nSeqE, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, " + ;
                            "Opers, Grupos, Estos, CodBarras, CodCors, CodTams, CidChaves, EmpDopNums, EmpGruEsts, " + ;
                            "OriDopNums, Seqs) VALUES (" + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                            EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + ;
                            FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + ;
                            FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", " + EscaparSQL("E") + ", " + ;
                            EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", " + ;
                            FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + EscaparSQL(loc_cCidCE) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, loc_cGrupoCab, loc_cContaCab)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeqE, 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - E)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, loc_cGrupoCab, loc_cContaCab, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_cSQL = "UPDATE SigOpEtq SET Grupos = " + EscaparSQL(loc_cGrupoCab) + ", " + ;
                            "Contas = " + EscaparSQL(loc_cContaCab) + ", DtMovs = " + FormatarDataSQL(loc_dAgora) + " " + ;
                            "WHERE CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigOpEtq)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        SELECT (THIS.this_cCursorBaixa)
                    ENDSCAN

                    SELECT cursor_4c_ConfCabec

                    IF loc_lFalhou
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaP(.T., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClP)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaC(.T., .T., .F., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClC)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhou = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao confirmar confer" + CHR(234) + "ncia")
        ENDTRY

        IF !loc_lProsseguir OR loc_lFalhou
            SQLROLLBACK(gnConnHandle)
            loc_lSucesso = .F.
        ELSE
            SQLCOMMIT(gnConnHandle)
            THIS.RegistrarAuditoria("CONFIRMAR")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

