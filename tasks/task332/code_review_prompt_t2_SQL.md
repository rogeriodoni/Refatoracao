# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LPRECOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LMARCAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LPRECOS

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
  Column1.ControlSource = ""
	lStrQuery = [Select 0 As lMarcas,a.* From SigCdLpi a ]+;
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsSigCdLpi') < 1
	Select CsSigCdLpi
	.Column1.ControlSource = 'CsSigCdLpi.lMarcas'
	.Column2.ControlSource = 'CsSigCdLpi.cpros'
	.Column3.ControlSource = 'CsSigCdLpi.dpros'
	.Column4.ControlSource = 'CsSigCdLpi.pvens'
	.Column5.ControlSource = 'CsSigCdLpi.moevs'
	.Column6.ControlSource = 'CsSigCdLpi.comiss'
lStrQuery = [Select * From SigCdLpc Where lprecos <> ']+pcLPreco+[' Order By lprecos ]
If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsSigCdLpc') < 1
	.Column1.ControlSource = 'CsSigCdLpc.lprecos'
Select CsSigCdLpc
Select CrSigCdLpi
Delete From CrSigCdLpi Where Empty(cpros)
Select CsSigCdLpi
	If CsSigCdLpi.lMarcas = 1 And !Seek(CsSigCdLpi.cpros,'CrSigCdLpi','CPros')
		Insert Into CrSigCdLpi From MemVar
	Select CsSigCdLpi
Select CsSigCdLpi
Select CsSigCdLpi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (959 linhas total):

*-- Linhas 206 a 224:
206:             .FontName    = "Courier New"
207:             .FontSize    = 9
208:             .ReadOnly    = .T.
209:             .DeleteMark  = .F.
210:             .RecordMark  = .F.
211:             .HighlightStyle     = 2
212:             .HighlightBackColor = RGB(255, 255, 255)
213:             .HighlightForeColor = RGB(15, 41, 104)
214:             .GridLineColor      = RGB(238, 238, 238)
215:             .ScrollBars  = 2
216:             .RowHeight   = 16
217:             WITH .Column1
218:                 .Width    = 220
219:                 .ReadOnly = .T.
220:                 .FontName = "Courier New"
221:                 .FontSize = 9
222:                 .Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
223:                 .Header1.FontName  = "Tahoma"
224:                 .Header1.FontSize  = 8

*-- Linhas 258 a 276:
258:             .FontName    = "Courier New"
259:             .FontSize    = 9
260:             .ReadOnly    = .F.
261:             .DeleteMark  = .F.
262:             .RecordMark  = .F.
263:             .HighlightStyle     = 2
264:             .HighlightBackColor = RGB(255, 255, 255)
265:             .HighlightForeColor = RGB(15, 41, 104)
266:             .GridLineColor      = RGB(238, 238, 238)
267:             .ScrollBars  = 2
268:             .RowHeight   = 16
269:         ENDWITH
270: 
271:         *-- Column1: CheckBox para marcacao (Sparse=.F. obrigatorio para todas as linhas)
272:         WITH loc_oGrid.Column1
273:             .Width    = 22
274:             .ReadOnly = .F.
275:             .Sparse   = .F.
276:             .AddObject("Check1", "CheckBox")

*-- Linhas 498 a 554:
498:             loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
499: 
500:             THIS.grd_4c_Listas.RecordSource = ""
501:             THIS.grd_4c_Listas.Column1.ControlSource = loc_cCursorListas + ".lprecos"
502:             THIS.grd_4c_Listas.RecordSource = loc_cCursorListas
503:             *-- Reconfigurar header apos RecordSource (VFP9 reseta headers)
504:             THIS.grd_4c_Listas.Column1.Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
505:             THIS.grd_4c_Listas.Column1.Header1.FontName  = "Tahoma"
506:             THIS.grd_4c_Listas.Column1.Header1.FontSize  = 8
507:             THIS.grd_4c_Listas.Column1.Header1.Alignment = 2
508:             THIS.grd_4c_Listas.Column1.Header1.ForeColor = RGB(0, 0, 0)
509: 
510:             *-- Carregar itens da primeira lista disponivel
511:             SELECT (loc_cCursorListas)
512:             GO TOP
513:             IF !EOF()
514:                 THIS.MontaGrade2(ALLTRIM(lprecos))
515:             ENDIF
516:         ENDIF
517: 
518:         RETURN loc_lSucesso
519:     ENDPROC
520: 
521:     *--------------------------------------------------------------------------
522:     * MontaGrade2 - Carrega itens de SigCdLpi para grd_4c_Itens
523:     * par_cLPrecos: codigo da lista selecionada em grd_4c_Listas
524:     *--------------------------------------------------------------------------
525:     PROCEDURE MontaGrade2(par_cLPrecos)
526:         LOCAL loc_lSucesso, loc_cCursorItens
527: 
528:         loc_lSucesso = THIS.this_oBusinessObject.BuscarItensDaLista(par_cLPrecos)
529: 
530:         IF loc_lSucesso
531:             loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens
532: 
533:             THIS.grd_4c_Itens.RecordSource = ""
534:             THIS.grd_4c_Itens.Column1.ControlSource = loc_cCursorItens + ".lMarcas"
535:             THIS.grd_4c_Itens.Column2.ControlSource = loc_cCursorItens + ".cpros"
536:             THIS.grd_4c_Itens.Column3.ControlSource = loc_cCursorItens + ".dpros"
537:             THIS.grd_4c_Itens.Column4.ControlSource = loc_cCursorItens + ".pvens"
538:             THIS.grd_4c_Itens.Column5.ControlSource = loc_cCursorItens + ".moevs"
539:             THIS.grd_4c_Itens.Column6.ControlSource = loc_cCursorItens + ".comiss"
540:             THIS.grd_4c_Itens.RecordSource = loc_cCursorItens
541:             *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
542:             THIS.grd_4c_Itens.Column1.Header1.Caption = ""
543:             THIS.grd_4c_Itens.Column2.Header1.Caption = "C" + CHR(243) + "digo Produto"
544:             THIS.grd_4c_Itens.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
545:             THIS.grd_4c_Itens.Column4.Header1.Caption = "Pre" + CHR(231) + "o de Venda"
546:             THIS.grd_4c_Itens.Column5.Header1.Caption = "Moeda"
547:             THIS.grd_4c_Itens.Column6.Header1.Caption = "Comiss" + CHR(227) + "o"
548:             THIS.grd_4c_Itens.Refresh()
549:         ENDIF
550: 
551:         RETURN loc_lSucesso
552:     ENDPROC
553: 
554:     *--------------------------------------------------------------------------

*-- Linhas 560 a 578:
560:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
561: 
562:         IF USED(loc_cCursorListas)
563:             SELECT (loc_cCursorListas)
564:             IF !EOF()
565:                 loc_cLPrecos = ALLTRIM(lprecos)
566:                 IF !EMPTY(loc_cLPrecos)
567:                     THIS.MontaGrade2(loc_cLPrecos)
568:                 ENDIF
569:             ENDIF
570:         ENDIF
571:     ENDPROC
572: 
573:     *--------------------------------------------------------------------------
574:     * CmdAdicionarClick - Copia itens marcados para o cursor CrSigCdLpi do form pai
575:     *--------------------------------------------------------------------------
576:     PROCEDURE CmdAdicionarClick()
577:         LOCAL loc_lAplicarArredond, loc_cCursorDestino, loc_nAdicionados, loc_oErro
578: 

*-- Linhas 705 a 723:
705:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens
706: 
707:         IF USED(loc_cCursor)
708:             SELECT (loc_cCursor)
709:             IF !EOF()
710:                 loc_lPermitir = (lMarcas = 0)
711:             ENDIF
712:         ENDIF
713: 
714:         RETURN loc_lPermitir
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * BtnIncluirClick - Adiciona os itens marcados a lista de preco atual do
719:     * form pai. Neste dialogo OPERACIONAL "incluir" significa incluir itens
720:     * marcados no cursor CrSigCdLpi do form pai (mesma acao do Command1 do SCX
721:     * original "Adiciona os itens marcados a Lista atual").
722:     *--------------------------------------------------------------------------
723:     PROCEDURE BtnIncluirClick()

*-- Linhas 740 a 758:
740:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
741: 
742:         IF USED(loc_cCursor)
743:             SELECT (loc_cCursor)
744:             GO TOP
745:             THIS.grd_4c_Itens.Refresh()
746:             THIS.grd_4c_Itens.SetFocus()
747:         ELSE
748:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
749:         ENDIF
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
754:     * usuario visualizar as listas de preco disponiveis para importacao.
755:     * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
756:     * listas de preco de origem (o SCX original faz isso via GradeLista).
757:     *--------------------------------------------------------------------------
758:     PROCEDURE BtnVisualizarClick()

*-- Linhas 765 a 783:
765:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
766: 
767:         IF USED(loc_cCursor)
768:             SELECT (loc_cCursor)
769:             GO TOP
770:             THIS.grd_4c_Listas.Refresh()
771:             THIS.grd_4c_Listas.SetFocus()
772:         ELSE
773:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
774:         ENDIF
775:     ENDPROC
776: 
777:     *--------------------------------------------------------------------------
778:     * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
779:     * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
780:     * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
781:     * confirmacao previa se houver itens marcados.
782:     *--------------------------------------------------------------------------
783:     PROCEDURE BtnExcluirClick()

*-- Linhas 789 a 807:
789:             RETURN
790:         ENDIF
791: 
792:         SELECT (loc_cCursor)
793:         COUNT FOR lMarcas = 1 TO loc_nMarcados
794: 
795:         IF loc_nMarcados = 0
796:             MsgAviso("Nenhum item marcado para remover.", "Aviso")
797:             RETURN
798:         ENDIF
799: 
800:         IF MsgConfirma("Desmarcar todos os " + TRANSFORM(loc_nMarcados) + ;
801:                        " itens marcados?", "Confirma" + CHR(231) + CHR(227) + "o")
802:             THIS.CmdApgaTudoClick()
803:         ENDIF
804:     ENDPROC
805: 
806:     *--------------------------------------------------------------------------
807:     * CarregarLista - Recarrega o grid de listas de preco disponiveis

*-- Linhas 847 a 886:
847:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
848: 
849:         IF USED(loc_cCursor)
850:             SELECT (loc_cCursor)
851:             GO TOP
852:             THIS.grd_4c_Listas.Refresh()
853:             THIS.grd_4c_Listas.SetFocus()
854:         ELSE
855:             IF !THIS.CarregarGradeLista()
856:                 MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
857:             ENDIF
858:         ENDIF
859:     ENDPROC
860: 
861:     *--------------------------------------------------------------------------
862:     * FormParaBO - Copia dados do form para o Business Object
863:     * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
864:     *--------------------------------------------------------------------------
865:     PROCEDURE FormParaBO()
866:         LOCAL loc_cCursor
867: 
868:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
869: 
870:         IF USED(loc_cCursor)
871:             SELECT (loc_cCursor)
872:             IF !EOF()
873:                 THIS.this_oBusinessObject.this_cLprecos = ALLTRIM(lprecos)
874:             ENDIF
875:         ENDIF
876:     ENDPROC
877: 
878:     *--------------------------------------------------------------------------
879:     * BOParaForm - Atualiza o form com dados do Business Object
880:     * Refresca os grids com os cursores atuais do BO
881:     *--------------------------------------------------------------------------
882:     PROCEDURE BOParaForm()
883:         LOCAL loc_cCursorListas, loc_cCursorItens
884: 
885:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
886:         loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens

*-- Linhas 947 a 959:
947:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens
948: 
949:         IF USED(loc_cCursor)
950:             SELECT (loc_cCursor)
951:             COUNT FOR lMarcas = 1 TO loc_nMarcados
952:         ENDIF
953: 
954:         IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
955:             THIS.cmd_4c_Adicionar.Enabled = (loc_nMarcados > 0)
956:         ENDIF
957:     ENDPROC
958: 
959: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSlpBO.prg):
*==============================================================================
* SigPrSlpBO.prg - Business Object: Selecao Lista de Preco
* Herda de: BusinessBase
* Tabelas: SigCdLpc (listas de preco), SigCdLpi (itens da lista)
* Tipo: OPERACIONAL - dialogo filho do form de pedido
*==============================================================================

DEFINE CLASS SigPrSlpBO AS BusinessBase

    *-- Configuracao da tabela base
    this_cTabela     = "SigCdLpi"
    this_cCampoChave = "cidchaves"

    *-- Cursores internos
    this_cCursorListas = "cursor_4c_Listas"
    this_cCursorItens  = "cursor_4c_Itens"

    *-- Propriedades mapeadas para colunas de SigCdLpi
    this_cCidchaves   = ""
    this_cCgrus       = ""
    this_nComiss      = 0
    this_cCpros       = ""
    this_cDpros       = ""
    this_lFlagutabs   = .F.
    this_cLprecos     = ""
    this_cMoevs       = ""
    this_nPvens       = 0
    this_dVencis      = {}
    this_dVencfs      = {}
    this_cOrdems      = ""
    this_cCcontroles  = ""
    this_nEan13       = 0
    this_nPcuss       = 0
    this_cReffs       = ""
    this_nPrecode     = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdLpi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarListasDisponiveis - Carrega SigCdLpc excluindo a lista atual
    * par_cLPrecoExcluir: codigo da lista de preco atual (a ser excluida)
    * Popula cursor_4c_Listas com colunas: lprecos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarListasDisponiveis(par_cLPrecoExcluir)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorListas)
                USE IN (THIS.this_cCursorListas)
            ENDIF

            loc_cSQL = "SELECT lprecos FROM SigCdLpc " + ;
                       "WHERE lprecos <> " + EscaparSQL(par_cLPrecoExcluir) + " " + ;
                       "ORDER BY lprecos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorListas) > 0
                SELECT (THIS.this_cCursorListas)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar listas de pre" + CHR(231) + "o.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensDaLista - Carrega SigCdLpi de uma lista especifica
    * par_cLPrecos: codigo da lista de preco selecionada
    * Popula cursor_4c_Itens com lMarcas=0 e todos os campos de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensDaLista(par_cLPrecos)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, a.cgrus, a.comiss, a.cpros, a.dpros, " + ;
                       "a.flagutabs, a.lprecos, a.moevs, a.pvens, a.vencis, a.vencfs, " + ;
                       "a.ordems, a.ccontroles, a.cidchaves, a.ean13, a.pcuss, " + ;
                       "a.reffs, a.precode " + ;
                       "FROM SigCdLpi a " + ;
                       "WHERE a.lprecos = " + EscaparSQL(par_cLPrecos) + " " + ;
                       "ORDER BY a.cpros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens) > 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar itens da lista de pre" + CHR(231) + "o.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarItensMarcados - Copia itens marcados para o cursor de destino
    * par_cLPrecoAtual:        codigo da lista atual (destino)
    * par_cCursorDestino:      nome do cursor VFP local do form pai (CrSigCdLpi)
    * par_lAplicarArredond:    .T. se deve arredondar pvens (CompVenda <> "C")
    * Retorna: numero de itens adicionados, -1 em caso de erro
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarItensMarcados(par_cLPrecoAtual, par_cCursorDestino, par_lAplicarArredond)
        LOCAL loc_nAdicionados, loc_oErro, loc_cLPrecoAtual, loc_lPodeExecutar

        loc_nAdicionados    = 0
        loc_lPodeExecutar   = .T.
        loc_cLPrecoAtual    = ALLTRIM(par_cLPrecoAtual)

        IF !USED(THIS.this_cCursorItens)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF
        IF loc_lPodeExecutar AND !USED(par_cCursorDestino)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF

        IF loc_lPodeExecutar
            TRY
                *-- Remove itens vazios do cursor destino (sem cpros)
                DELETE FROM (par_cCursorDestino) WHERE EMPTY(cpros)

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN
                    IF cursor_4c_Itens.lMarcas = 1
                        *-- Verifica se cpros ja existe no cursor destino
                        IF !SEEK(cursor_4c_Itens.cpros, par_cCursorDestino, "CPros")
                            SCATTER MEMVAR

                            m.lMarcas   = 0
                            m.lprecos   = loc_cLPrecoAtual
                            m.cidchaves = fUniqueIds()
                            m.vencis    = NVL(m.vencis, {})
                            m.vencfs    = NVL(m.vencfs, {})

                            IF par_lAplicarArredond
                                m.pvens = ROUND(m.pvens, 2)
                            ENDIF

                            INSERT INTO (par_cCursorDestino) FROM MEMVAR
                            loc_nAdicionados = loc_nAdicionados + 1

                            SELECT (THIS.this_cCursorItens)
                        ENDIF
                    ENDIF
                ENDSCAN

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
                loc_nAdicionados = -1
            ENDTRY
        ENDIF

        RETURN loc_nAdicionados
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 1
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 0
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorListas)
            USE IN (THIS.this_cCursorListas)
        ENDIF
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor com os dados de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "C")
                THIS.this_cCgrus      = TratarNulo(cgrus, "C")
                THIS.this_nComiss     = TratarNulo(comiss, "N")
                THIS.this_cCpros      = TratarNulo(cpros, "C")
                THIS.this_cDpros      = TratarNulo(dpros, "C")

                IF VARTYPE(flagutabs) = "N"
                    IF VARTYPE(flagutabs) = "L"
                        THIS.this_lFlagutabs = flagutabs
                    ELSE
                        IF VARTYPE(flagutabs) = "L"
                            THIS.this_lFlagutabs = flagutabs
                        ELSE
                            IF VARTYPE(flagutabs) = "L"
                                THIS.this_lFlagutabs = flagutabs
                            ELSE
                                IF VARTYPE(flagutabs) = "L"
                                    THIS.this_lFlagutabs = flagutabs
                                ELSE
                                    IF VARTYPE(flagutabs) = "L"
                                        THIS.this_lFlagutabs = flagutabs
                                    ELSE
                                        THIS.this_lFlagutabs = (NVL(flagutabs, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    THIS.this_lFlagutabs = NVL(flagutabs, .F.)
                ENDIF

                THIS.this_cLprecos    = TratarNulo(lprecos, "C")
                THIS.this_cMoevs      = TratarNulo(moevs, "C")
                THIS.this_nPvens      = TratarNulo(pvens, "N")
                THIS.this_dVencis     = NVL(vencis, {})
                THIS.this_dVencfs     = NVL(vencfs, {})
                THIS.this_cOrdems     = TratarNulo(ordems, "C")
                THIS.this_cCcontroles = TratarNulo(ccontroles, "C")
                THIS.this_nEan13      = TratarNulo(ean13, "N")
                THIS.this_nPcuss      = TratarNulo(pcuss, "N")
                THIS.this_cReffs      = TratarNulo(reffs, "C")
                THIS.this_nPrecode    = TratarNulo(precode, "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdLpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdLpi (cgrus, comiss, cpros, dpros, flagutabs, " + ;
                       "lprecos, moevs, pvens, vencis, vencfs, ordems, ccontroles, " + ;
                       "cidchaves, ean13, pcuss, reffs, precode) VALUES (" + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss, 2) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cDpros) + ", " + ;
                       IIF(THIS.this_lFlagutabs, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cLprecos) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPvens, 6) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencis), "NULL", FormatarDataSQL(THIS.this_dVencis)) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencfs), "NULL", FormatarDataSQL(THIS.this_dVencfs)) + ", " + ;
                       EscaparSQL(THIS.this_cOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cCcontroles) + ", " + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcuss, 6) + ", " + ;
                       EscaparSQL(THIS.this_cReffs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecode, 5) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdLpi WHERE cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. Imposs" + CHR(237) + "vel atualizar."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdLpi SET " + ;
                       "cgrus = " + EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       "comiss = " + FormatarNumeroSQL(THIS.this_nComiss, 2) + ", " + ;
                       "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                       "dpros = " + EscaparSQL(THIS.this_cDpros) + ", " + ;
                       "flagutabs = " + IIF(THIS.this_lFlagutabs, "1", "0") + ", " + ;
                       "lprecos = " + EscaparSQL(THIS.this_cLprecos) + ", " + ;
                       "moevs = " + EscaparSQL(THIS.this_cMoevs) + ", " + ;
                       "pvens = " + FormatarNumeroSQL(THIS.this_nPvens, 6) + ", " + ;
                       "vencis = " + IIF(EMPTY(THIS.this_dVencis), "NULL", FormatarDataSQL(THIS.this_dVencis)) + ", " + ;
                       "vencfs = " + IIF(EMPTY(THIS.this_dVencfs), "NULL", FormatarDataSQL(THIS.this_dVencfs)) + ", " + ;
                       "ordems = " + EscaparSQL(THIS.this_cOrdems) + ", " + ;
                       "ccontroles = " + EscaparSQL(THIS.this_cCcontroles) + ", " + ;
                       "ean13 = " + FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + ;
                       "pcuss = " + FormatarNumeroSQL(THIS.this_nPcuss, 6) + ", " + ;
                       "reffs = " + EscaparSQL(THIS.this_cReffs) + ", " + ;
                       "precode = " + FormatarNumeroSQL(THIS.this_nPrecode, 5) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi WHERE cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. Imposs" + CHR(237) + "vel excluir."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigCdLpi WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

