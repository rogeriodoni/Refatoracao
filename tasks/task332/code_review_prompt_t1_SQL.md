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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (960 linhas total):

*-- Linhas 203 a 221:
203:             .FontName    = "Courier New"
204:             .FontSize    = 9
205:             .ReadOnly    = .T.
206:             .DeleteMark  = .F.
207:             .RecordMark  = .F.
208:             .HighlightStyle     = 2
209:             .HighlightBackColor = RGB(255, 255, 255)
210:             .HighlightForeColor = RGB(15, 41, 104)
211:             .GridLineColor      = RGB(238, 238, 238)
212:             .ScrollBars  = 2
213:             .RowHeight   = 16
214:             WITH .Column1
215:                 .Width    = 220
216:                 .ReadOnly = .T.
217:                 .FontName = "Courier New"
218:                 .FontSize = 9
219:                 .Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
220:                 .Header1.FontName  = "Tahoma"
221:                 .Header1.FontSize  = 8

*-- Linhas 255 a 273:
255:             .FontName    = "Courier New"
256:             .FontSize    = 9
257:             .ReadOnly    = .F.
258:             .DeleteMark  = .F.
259:             .RecordMark  = .F.
260:             .HighlightStyle     = 2
261:             .HighlightBackColor = RGB(255, 255, 255)
262:             .HighlightForeColor = RGB(15, 41, 104)
263:             .GridLineColor      = RGB(238, 238, 238)
264:             .ScrollBars  = 2
265:             .RowHeight   = 16
266:         ENDWITH
267: 
268:         *-- Column1: CheckBox para marcacao (Sparse=.F. obrigatorio para todas as linhas)
269:         WITH loc_oGrid.Column1
270:             .Width    = 22
271:             .ReadOnly = .F.
272:             .Sparse   = .F.
273:             .AddObject("Check1", "CheckBox")

*-- Linhas 496 a 525:
496: 
497:             WITH THIS.grd_4c_Listas
498:                 .RecordSource = ""
499:                 .Column1.ControlSource = loc_cCursorListas + ".lprecos"
500:                 .RecordSource = loc_cCursorListas
501:                 *-- Reconfigurar header apos RecordSource (VFP9 reseta headers)
502:                 .Column1.Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
503:                 .Column1.Header1.FontName  = "Tahoma"
504:                 .Column1.Header1.FontSize  = 8
505:                 .Column1.Header1.Alignment = 2
506:                 .Column1.Header1.ForeColor = RGB(0, 0, 0)
507:             ENDWITH
508: 
509:             *-- Carregar itens da primeira lista disponivel
510:             SELECT (loc_cCursorListas)
511:             GO TOP
512:             IF !EOF()
513:                 THIS.MontaGrade2(ALLTRIM(lprecos))
514:             ENDIF
515:         ENDIF
516: 
517:         RETURN loc_lSucesso
518:     ENDPROC
519: 
520:     *--------------------------------------------------------------------------
521:     * MontaGrade2 - Carrega itens de SigCdLpi para grd_4c_Itens
522:     * par_cLPrecos: codigo da lista selecionada em grd_4c_Listas
523:     *--------------------------------------------------------------------------
524:     PROCEDURE MontaGrade2(par_cLPrecos)
525:         LOCAL loc_lSucesso, loc_cCursorItens

*-- Linhas 531 a 554:
531: 
532:             WITH THIS.grd_4c_Itens
533:                 .RecordSource = ""
534:                 .Column1.ControlSource = loc_cCursorItens + ".lMarcas"
535:                 .Column2.ControlSource = loc_cCursorItens + ".cpros"
536:                 .Column3.ControlSource = loc_cCursorItens + ".dpros"
537:                 .Column4.ControlSource = loc_cCursorItens + ".pvens"
538:                 .Column5.ControlSource = loc_cCursorItens + ".moevs"
539:                 .Column6.ControlSource = loc_cCursorItens + ".comiss"
540:                 .RecordSource = loc_cCursorItens
541:                 *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
542:                 .Column1.Header1.Caption = ""
543:                 .Column2.Header1.Caption = "C" + CHR(243) + "digo Produto"
544:                 .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
545:                 .Column4.Header1.Caption = "Pre" + CHR(231) + "o de Venda"
546:                 .Column5.Header1.Caption = "Moeda"
547:                 .Column6.Header1.Caption = "Comiss" + CHR(227) + "o"
548:                 .Refresh
549:             ENDWITH
550:         ENDIF
551: 
552:         RETURN loc_lSucesso
553:     ENDPROC
554: 

*-- Linhas 561 a 579:
561:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
562: 
563:         IF USED(loc_cCursorListas)
564:             SELECT (loc_cCursorListas)
565:             IF !EOF()
566:                 loc_cLPrecos = ALLTRIM(lprecos)
567:                 IF !EMPTY(loc_cLPrecos)
568:                     THIS.MontaGrade2(loc_cLPrecos)
569:                 ENDIF
570:             ENDIF
571:         ENDIF
572:     ENDPROC
573: 
574:     *--------------------------------------------------------------------------
575:     * CmdAdicionarClick - Copia itens marcados para o cursor CrSigCdLpi do form pai
576:     *--------------------------------------------------------------------------
577:     PROCEDURE CmdAdicionarClick()
578:         LOCAL loc_lAplicarArredond, loc_cCursorDestino, loc_nAdicionados, loc_oErro
579: 

*-- Linhas 706 a 724:
706:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens
707: 
708:         IF USED(loc_cCursor)
709:             SELECT (loc_cCursor)
710:             IF !EOF()
711:                 loc_lPermitir = (lMarcas = 0)
712:             ENDIF
713:         ENDIF
714: 
715:         RETURN loc_lPermitir
716:     ENDPROC
717: 
718:     *--------------------------------------------------------------------------
719:     * BtnIncluirClick - Adiciona os itens marcados a lista de preco atual do
720:     * form pai. Neste dialogo OPERACIONAL "incluir" significa incluir itens
721:     * marcados no cursor CrSigCdLpi do form pai (mesma acao do Command1 do SCX
722:     * original "Adiciona os itens marcados a Lista atual").
723:     *--------------------------------------------------------------------------
724:     PROCEDURE BtnIncluirClick()

*-- Linhas 741 a 759:
741:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
742: 
743:         IF USED(loc_cCursor)
744:             SELECT (loc_cCursor)
745:             GO TOP
746:             THIS.grd_4c_Itens.Refresh()
747:             THIS.grd_4c_Itens.SetFocus()
748:         ELSE
749:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
750:         ENDIF
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
755:     * usuario visualizar as listas de preco disponiveis para importacao.
756:     * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
757:     * listas de preco de origem (o SCX original faz isso via GradeLista).
758:     *--------------------------------------------------------------------------
759:     PROCEDURE BtnVisualizarClick()

*-- Linhas 766 a 784:
766:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
767: 
768:         IF USED(loc_cCursor)
769:             SELECT (loc_cCursor)
770:             GO TOP
771:             THIS.grd_4c_Listas.Refresh()
772:             THIS.grd_4c_Listas.SetFocus()
773:         ELSE
774:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
775:         ENDIF
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
780:     * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
781:     * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
782:     * confirmacao previa se houver itens marcados.
783:     *--------------------------------------------------------------------------
784:     PROCEDURE BtnExcluirClick()

*-- Linhas 790 a 808:
790:             RETURN
791:         ENDIF
792: 
793:         SELECT (loc_cCursor)
794:         COUNT FOR lMarcas = 1 TO loc_nMarcados
795: 
796:         IF loc_nMarcados = 0
797:             MsgAviso("Nenhum item marcado para remover.", "Aviso")
798:             RETURN
799:         ENDIF
800: 
801:         IF MsgConfirma("Desmarcar todos os " + TRANSFORM(loc_nMarcados) + ;
802:                        " itens marcados?", "Confirma" + CHR(231) + CHR(227) + "o")
803:             THIS.CmdApgaTudoClick()
804:         ENDIF
805:     ENDPROC
806: 
807:     *--------------------------------------------------------------------------
808:     * CarregarLista - Recarrega o grid de listas de preco disponiveis

*-- Linhas 848 a 887:
848:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
849: 
850:         IF USED(loc_cCursor)
851:             SELECT (loc_cCursor)
852:             GO TOP
853:             THIS.grd_4c_Listas.Refresh()
854:             THIS.grd_4c_Listas.SetFocus()
855:         ELSE
856:             IF !THIS.CarregarGradeLista()
857:                 MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
858:             ENDIF
859:         ENDIF
860:     ENDPROC
861: 
862:     *--------------------------------------------------------------------------
863:     * FormParaBO - Copia dados do form para o Business Object
864:     * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
865:     *--------------------------------------------------------------------------
866:     PROCEDURE FormParaBO()
867:         LOCAL loc_cCursor
868: 
869:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
870: 
871:         IF USED(loc_cCursor)
872:             SELECT (loc_cCursor)
873:             IF !EOF()
874:                 THIS.this_oBusinessObject.this_cLprecos = ALLTRIM(lprecos)
875:             ENDIF
876:         ENDIF
877:     ENDPROC
878: 
879:     *--------------------------------------------------------------------------
880:     * BOParaForm - Atualiza o form com dados do Business Object
881:     * Refresca os grids com os cursores atuais do BO
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BOParaForm()
884:         LOCAL loc_cCursorListas, loc_cCursorItens
885: 
886:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
887:         loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens

*-- Linhas 948 a 960:
948:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens
949: 
950:         IF USED(loc_cCursor)
951:             SELECT (loc_cCursor)
952:             COUNT FOR lMarcas = 1 TO loc_nMarcados
953:         ENDIF
954: 
955:         IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
956:             THIS.cmd_4c_Adicionar.Enabled = (loc_nMarcados > 0)
957:         ENDIF
958:     ENDPROC
959: 
960: ENDDEFINE


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
                            THIS.this_lFlagutabs = (NVL(flagutabs, 0) = 1)
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

