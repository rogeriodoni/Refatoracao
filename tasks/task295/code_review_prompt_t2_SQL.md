# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMBS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMBS

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
  DeleteMark = .F.
	lcQuery = [Select Cods, Multis From SigCdEmb]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdEmb]) < 1)
	Select crSigCdEmb
	loBarra.Update(.t., [Gerando Informações Para Lançamento])
	Select csCabec
	Insert Into crSigMvCab From Memvar
	Insert Into CrSigInBep From Memvar
	loBarra.Update(.t., [Gerando Informações Dos Itens])
	Select csItens
		Select csItens
		Insert Into crSigMvItn From Memvar
		=Seek(crTmpPro.cUnis, [crSigCdEmb], [Cods])
			Insert Into crSigMvIts From Memvar
	Select CsEstPe
		Insert Into CrSigMvPec From Memvar
	loBarra.Update(.t., [Preparando Gravação])
	If llOks And Not ThisForm.poDataMgr.UpDate('crSigMvCab')
	If llOks And Not ThisForm.poDataMgr.UpDate('crSigMvItn')
	If llOks And Not ThisForm.poDataMgr.UpDate('crSigMvIts')
	If llOks And Not ThisForm.poDataMgr.UpDate('CrSigMvPec')
	If llOks And Not ThisForm.poDataMgr.UpDate('CrSigInBep')
	Select csItens
	Select csCabec
Select CsCabec
Select CsItens
Select CsCabec
	.Column1.ControlSource = [csCabec.EmpDs]
	.Column7.ControlSource = [csCabec.Dopes]
	.Column2.ControlSource = [csCabec.GrupoOs]
	.Column3.ControlSource = [csCabec.ContaOs]
	.Column5.ControlSource = [csCabec.GrupoDs]
	.Column4.ControlSource = [csCabec.ContaDs]
	.Column6.ControlSource = [csCabec.Gerado]
	.Column1.ControlSource = [csItens.CItens]
	.Column2.ControlSource = [csItens.CPros]
	.Column3.ControlSource = [csItens.DPros]
	.Column4.ControlSource = [csItens.Moedas]
	.Column5.ControlSource = [csItens.Units]
	.Column6.ControlSource = [csItens.Qtds]
	.Column7.ControlSource = [csItens.Totas]
Select CsItens
Select Emps, Dopes, Numes ;
  From csCabec ;
Select csCabec

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg) - TRECHOS RELEVANTES PARA PASS SQL (912 linhas total):

*-- Linhas 301 a 319:
301:             .FontSize         = 8
302:             .AllowHeaderSizing = .F.
303:             .AllowRowSizing   = .F.
304:             .DeleteMark       = .F.
305:             .RecordMark       = .F.
306:             .HeaderHeight     = 15
307:             .ReadOnly         = .T.
308:             .RowHeight        = 16
309:             .ScrollBars       = 2
310:             .TabStop          = .F.
311:             .GridLineColor    = RGB(238,238,238)
312:             .Visible          = .T.
313: 
314:             *-- Coluna 1: Emp (Width=35, ColumnOrder=1)
315:             .Column1.Width       = 35
316:             .Column1.ColumnOrder = 1
317:             .Column1.Movable     = .F.
318:             .Column1.Resizable   = .F.
319:             .Column1.ReadOnly    = .T.

*-- Linhas 398 a 423:
398:             .Column7.Header1.FontName  = "Tahoma"
399:             .Column7.Header1.ForeColor = RGB(0,0,0)
400: 
401:             *-- ControlSource e DynamicBackColor (vincula ao cursor csCabec)
402:             .Column1.ControlSource = "csCabec.EmpDs"
403:             .Column2.ControlSource = "csCabec.GrupoOs"
404:             .Column3.ControlSource = "csCabec.ContaOs"
405:             .Column4.ControlSource = "csCabec.ContaDs"
406:             .Column5.ControlSource = "csCabec.GrupoDs"
407:             .Column6.ControlSource = "csCabec.Gerado"
408:             .Column7.ControlSource = "csCabec.Dopes"
409:             .SetAll("DynamicBackColor", ;
410:                 "IIF(EMPTY(csCabec.Gerado), RGB(255,255,255), RGB(255,255,204))", ;
411:                 "Column")
412:         ENDWITH
413:     ENDPROC
414: 
415:     *==========================================================================
416:     * ConfigurarGrdIte - Grade de itens (Fase 4)
417:     *   Original: Top=295, Left=10, Width=980, Height=289, ColumnCount=7
418:     *   Colunas: [seq] | Produto | Descricao | M | Pr.Unit. | Quantidade | Total
419:     *==========================================================================
420:     PROTECTED PROCEDURE ConfigurarGrdIte
421:         THIS.AddObject("grd_4c_Ite", "Grid")
422:         THIS.grd_4c_Ite.ColumnCount      = 7
423:         THIS.grd_4c_Ite.RecordSourceType = 1

*-- Linhas 431 a 449:
431:             .FontSize         = 8
432:             .AllowHeaderSizing = .F.
433:             .AllowRowSizing   = .F.
434:             .DeleteMark       = .F.
435:             .RecordMark       = .F.
436:             .HeaderHeight     = 15
437:             .ReadOnly         = .T.
438:             .RowHeight        = 16
439:             .ScrollBars       = 2
440:             .TabStop          = .F.
441:             .GridLineColor    = RGB(238,238,238)
442:             .Visible          = .T.
443: 
444:             *-- Coluna 1: [sequencial CItens] (Width=36, ColumnOrder=1)
445:             .Column1.Width       = 36
446:             .Column1.ColumnOrder = 1
447:             .Column1.Movable     = .F.
448:             .Column1.Resizable   = .F.
449:             .Column1.ReadOnly    = .T.

*-- Linhas 525 a 550:
525:             .Column7.Header1.FontName  = "Tahoma"
526:             .Column7.Header1.ForeColor = RGB(0,0,0)
527: 
528:             *-- ControlSource (vincula ao cursor csItens)
529:             .Column1.ControlSource = "csItens.CItens"
530:             .Column2.ControlSource = "csItens.CPros"
531:             .Column3.ControlSource = "csItens.DPros"
532:             .Column4.ControlSource = "csItens.Moedas"
533:             .Column5.ControlSource = "csItens.Units"
534:             .Column6.ControlSource = "csItens.Qtds"
535:             .Column7.ControlSource = "csItens.Totas"
536:         ENDWITH
537:     ENDPROC
538: 
539:     *==========================================================================
540:     * ConfigurarPaginaDados - Fase 5/8: propriedades visuais Text1 dos grids
541:     *   Para este form OPERACIONAL flat (sem Page2), esta fase configura as
542:     *   propriedades dos controles Text1 dentro das colunas dos grids, conforme
543:     *   as propriedades definidas no SCX original (BorderStyle=0, Margin=0,
544:     *   ForeColor, BackColor), e aplica HighlightColors canonicos em ambos.
545:     *==========================================================================
546:     PROTECTED PROCEDURE ConfigurarPaginaDados
547:         THIS.ConfigurarTextosGrdCab()
548:         THIS.ConfigurarTextosGrdIte()
549:     ENDPROC
550: 

*-- Linhas 638 a 664:
638:     *==========================================================================
639:     PROTECTED PROCEDURE CarregarDados
640:         IF USED("csCabec")
641:             SELECT csCabec
642:             GO TOP
643:         ENDIF
644: 
645:         IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
646:             SELECT csItens
647:             SET KEY TO csCabec.EmpDopNums
648:             GO TOP
649:             SELECT csCabec
650:         ENDIF
651: 
652:         IF VARTYPE(THIS.grd_4c_Cab) = "O"
653:             THIS.grd_4c_Cab.Refresh()
654:         ENDIF
655: 
656:         IF VARTYPE(THIS.grd_4c_Ite) = "O"
657:             THIS.grd_4c_Ite.Refresh()
658:         ENDIF
659:     ENDPROC
660: 
661:     *==========================================================================
662:     * ProcessaPeriodo - Stub para nao gerar erro em chamadas do SigMvCab
663:     *   Original SIGPRGST: "Rotina Criada Apenas Para Nao Gerar Erro Nas
664:     *   Chamadas do SigMvCab." ? SigMvCab pode chamar ThisForm.ParentForm.ProcessaPeriodo

*-- Linhas 673 a 691:
673:     *==========================================================================
674:     PROCEDURE GrdCabAfterRowColChange(par_nColIndex)
675:         IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
676:             SELECT csItens
677:             SET KEY TO csCabec.EmpDopNums
678:             GO TOP
679:             THIS.grd_4c_Ite.Refresh()
680:         ENDIF
681:     ENDPROC
682: 
683:     *==========================================================================
684:     * BtnConfirmarClick - Verifica selecao e chama GerarPedido no BO
685:     *   Original: CmdGrava.Click - valida EOF, chama GerarPedido, abre SigMvCab
686:     *==========================================================================
687:     PROCEDURE BtnConfirmarClick()
688:         LOCAL loc_lResultado, loc_oErro
689:         loc_lResultado = .F.
690: 
691:         TRY

*-- Linhas 720 a 739:
720:         TRY
721:             *-- Verificar pedidos nao gerados
722:             IF USED("csCabec")
723:                 SELECT Emps, Dopes, Numes ;
724:                     FROM csCabec ;
725:                     WHERE EMPTY(Gerado) ;
726:                     INTO CURSOR cursor_4c_NaoGerados
727:                 loc_nFal = RECCOUNT("cursor_4c_NaoGerados")
728:                 USE IN cursor_4c_NaoGerados
729:             ELSE
730:                 loc_nFal = 0
731:             ENDIF
732: 
733:             IF loc_nFal > 0
734:                 IF !MsgConfirma("Existem " + ALLTRIM(STR(loc_nFal, 10)) + ;
735:                     " Opera" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o Confirmadas!" + ;
736:                     CHR(13) + "Tem Certeza Que N" + CHR(227) + "o Deseja Gerar Esses Pedidos?", ;
737:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
738:                     loc_lResultado = .F.
739:                 ELSE


### BO (C:\4c\projeto\app\classes\SigPrGstBO.prg):
*==============================================================================
* SigPrGstBO.prg - Business Object: Geracao de Movimentacoes de Estoque
*
* Tabela principal : SigMvCab (cabecalho de movimentacao gerado)
* Chave primaria   : EmpDopNums (composta: Emps + Dopes + STR(Numes,6))
* Herda de         : BusinessBase
*
* Este BO opera sobre cursores passados pelo formulario pai:
*   Entrada  : csCabec, csItens, CsEstPe, CrSigCdNec
*   Saida    : SigMvCab, SigMvItn, SigMvIts, SigMvPec, SigInBep (via SQLEXEC)
*==============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Contexto do formulario (recebido do pai via Init)
    *--------------------------------------------------------------------------
    this_cGrupoOper     = ""    && Grupo de operacao (C10)
    this_cPcEscolha     = ""    && Escolha de processamento passada pelo pai

    *--------------------------------------------------------------------------
    * Campos de csCabec - Cabecalho da necessidade/pedido de origem
    *--------------------------------------------------------------------------
    this_cEmps          = ""    && Empresa (C3)
    this_cEmpDs         = ""    && Descricao da empresa (display)
    this_cDopes         = ""    && Codigo da operacao (C20)
    this_nNumes         = 0     && Numero do pedido (N6,0)
    this_cMascNum       = ""    && Mascara formatada do numero
    this_dDatars        = {}    && Data de referencia do pedido
    this_cIdChaves      = ""    && ID unico (via fUniqueIds)
    this_cEmpDopNums    = ""    && Chave composta: Emps + Dopes + STR(Numes,6) (C29)
    this_cEmpDnPs       = ""    && Chave composta da NEC origem (EmpDnPs)
    this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
    this_cContaOs       = ""    && Conta de Origem (C10)
    this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
    this_cContaDs       = ""    && Conta de Destino (C10)
    this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
    this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
    this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
    this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)

    *--------------------------------------------------------------------------
    * Campos de csItens - Item corrente do pedido
    *--------------------------------------------------------------------------
    this_nCItens        = 0     && Numero sequencial do item
    this_cCPros         = ""    && Codigo do produto
    this_cDPros         = ""    && Descricao do produto
    this_cMoedas        = ""    && Moeda de cotacao
    this_nUnits         = 0     && Preco unitario
    this_nQtds          = 0     && Quantidade solicitada
    this_nTotas         = 0     && Total do item

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor csCabec para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_cMascNum    = TratarNulo(MascNum, "C")
                THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
                THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
                THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
                THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
                THIS.this_cGerado     = TratarNulo(Gerado, "C")
                THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
                THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
                THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                IF TYPE("EmpDnPs") != "U"
                    THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                ENDIF
                IF TYPE("Datars") != "U"
                    THIS.this_dDatars = TratarNulo(Datars, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica pre-condicoes para gerar pedido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione um pedido na grade e tente novamente."
            RETURN .F.
        ENDIF
        IF !EMPTY(ALLTRIM(csCabec.Gerado))
            THIS.this_cMensagemErro = "Este pedido j" + CHR(225) + " foi gerado anteriormente."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarPedido - Opera principal: gera movimentacoes de estoque a partir
    *   dos cursores csCabec, csItens e CsEstPe para as tabelas SQL Server.
    *   Equivalente ao PROCEDURE gerarpedido do formulario legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarPedido()
        LOCAL loc_lResultado, loc_lOks, loc_lTransacaoAberta
        LOCAL loc_nNum, loc_cMascNum, loc_cEmpDopNums, loc_cSQL
        LOCAL loc_cEmps, loc_cDopes, loc_cGrupoOs, loc_cContaOs
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPsNec
        LOCAL loc_loBarra

        loc_lResultado       = .F.
        loc_lOks             = .T.
        loc_lTransacaoAberta = .F.

        TRY
            *-- Verificar pre-condicoes
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE

                *-- Se ja gerado, retornar .T. diretamente (sem nova geracao)
                IF !EMPTY(ALLTRIM(csCabec.Gerado))
                    loc_lResultado = .T.
                ELSE

                    *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
                    loc_cEmps    = ALLTRIM(csCabec.Emps)
                    loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
                    loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
                    loc_cContaOs = ALLTRIM(csCabec.ContaOs)
                    loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
                    loc_cContaDs = ALLTRIM(csCabec.ContaDs)

                    *-- Capturar EmpDnPs de CrSigCdNec
                    loc_cEmpDnPsNec = ""
                    IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
                        loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)
                    ENDIF

                    *-- Carregar SigCdEmb para divisao de embalagem
                    loc_cSQL = "SELECT Cods, Multis FROM SigCdEmb"
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmb") < 1
                        loc_lOks = .F.
                        MsgErro("Falha ao carregar tabela de embalagem (SigCdEmb)", "Erro")
                    ENDIF

                    IF loc_lOks
                        SELECT crSigCdEmb
                        INDEX ON UPPER(ALLTRIM(Cods)) TAG Cods
                        GO TOP IN crSigCdEmb

                        *-- Gerar numero unico e mascara para o novo movimento
                        loc_nNum        = fGerUniqueKey(ALLTRIM(loc_cDopes) + go_4c_Sistema.cCodEmpresa)
                        loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNum))
                        loc_cEmpDopNums = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + STR(loc_nNum, 6)

                        *-- Barra de progresso
                        loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                            "Gravando " + ALLTRIM(loc_cDopes) + "...", 3)
                        loc_loBarra.Show()
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Para Lan" + CHR(231) + "amento")

                        *-- Iniciar transacao SQL Server
                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        loc_lTransacaoAberta = .T.

                        *-- INSERT INTO SigMvCab
                        loc_cSQL = "INSERT INTO SigMvCab " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir cabe" + CHR(231) + "alho de " + ;
                                "movimenta" + CHR(231) + CHR(227) + "o (SigMvCab)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- INSERT INTO SigInBep (rastreio - mesmo conteudo que SigMvCab)
                        loc_cSQL = "INSERT INTO SigInBep " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir registro de rastreio (SigInBep)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Dos Itens")

                        *-- Processar itens de csItens -> SigMvItn e SigMvIts
                        LOCAL loc_nCItens, loc_cCPros, loc_cDPros, loc_cMoedas
                        LOCAL loc_nUnits, loc_nQtds, loc_nTotas
                        LOCAL loc_cCGrus, loc_cCUnisPro, loc_nTipoEstos, loc_nEmbs
                        LOCAL loc_cSQLItem, loc_nMultis, loc_cCodEmbs, loc_nQtdEmb
                        LOCAL loc_lSub

                        IF USED("csItens")
                            SELECT csItens
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos do item ANTES de SQLEXEC
                                loc_nCItens = csItens.CItens
                                loc_cCPros  = ALLTRIM(csItens.CPros)
                                loc_cDPros  = LEFT(ALLTRIM(csItens.DPros), 65)
                                loc_cMoedas = LEFT(ALLTRIM(csItens.Moedas), 3)
                                loc_nUnits  = NVL(csItens.Units, 0)
                                loc_nQtds   = NVL(csItens.Qtds, 0)
                                loc_nTotas  = NVL(csItens.Totas, 0)

                                *-- Buscar dados do produto (grupo e unidade)
                                loc_cCGrus   = ""
                                loc_cCUnisPro = ""
                                loc_cSQLItem = "SELECT TOP 1 cgrus, cunis FROM SigCdPro " + ;
                                               "WHERE cpros = " + EscaparSQL(loc_cCPros)
                                IF USED("crTmpPro")
                                    USE IN crTmpPro
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpPro") > 0
                                    SELECT crTmpPro
                                    IF !EOF()
                                        loc_cCGrus    = ALLTRIM(cgrus)
                                        loc_cCUnisPro = ALLTRIM(cunis)
                                    ENDIF
                                ENDIF

                                *-- Buscar tipo do grupo (para verificar embalagem)
                                loc_nTipoEstos = 0
                                loc_nEmbs      = 0
                                IF !EMPTY(loc_cCGrus)
                                    loc_cSQLItem = "SELECT TOP 1 tipoestos, embs FROM SigCdGrp " + ;
                                                   "WHERE cgrus = " + EscaparSQL(loc_cCGrus)
                                    IF USED("crTmpGru")
                                        USE IN crTmpGru
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpGru") > 0
                                        SELECT crTmpGru
                                        IF !EOF()
                                            loc_nTipoEstos = NVL(tipoestos, 0)
                                            loc_nEmbs      = NVL(embs, 0)
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- INSERT INTO SigMvItn
                                loc_cSQLItem = "INSERT INTO SigMvItn " + ;
                                    "(emps, dopes, numes, citens, cpros, dpros, " + ;
                                    " moedas, units, qtds, totas, empdopnums, cidchaves, dtalts) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                    EscaparSQL(loc_cCPros) + ", " + ;
                                    EscaparSQL(loc_cDPros) + ", " + ;
                                    EscaparSQL(loc_cMoedas) + ", " + ;
                                    FormatarNumeroSQL(loc_nUnits, 5) + ", " + ;
                                    FormatarNumeroSQL(loc_nQtds, 3) + ", " + ;
                                    FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    "GETDATE())"
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir item de movimenta" + ;
                                        CHR(231) + CHR(227) + "o (SigMvItn)", "Erro")
                                ENDIF

                                *-- Verificar embalagem e inserir SigMvIts se aplicavel
                                IF loc_lOks
                                    loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)
                                    IF loc_lSub AND !EMPTY(loc_cCUnisPro)
                                        loc_nMultis  = 0
                                        loc_cCodEmbs = ""
                                        SELECT crSigCdEmb
                                        IF SEEK(UPPER(ALLTRIM(loc_cCUnisPro)), "crSigCdEmb", "Cods")
                                            loc_nMultis  = NVL(crSigCdEmb.Multis, 0)
                                            loc_cCodEmbs = ALLTRIM(crSigCdEmb.Cods)
                                        ENDIF

                                        IF loc_nMultis > 0 AND !EMPTY(loc_cCodEmbs)
                                            loc_nQtdEmb = loc_nQtds / loc_nMultis
                                            loc_cSQLItem = "INSERT INTO SigMvIts " + ;
                                                "(emps, dopes, numes, cpros, citens, qtds, " + ;
                                                " codembs, qtdembs, empdopnums, cidchaves, dtalts) " + ;
                                                "VALUES (" + ;
                                                EscaparSQL(loc_cEmps) + ", " + ;
                                                EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                                FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                                EscaparSQL(loc_cCPros) + ", " + ;
                                                FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                                FormatarNumeroSQL(loc_nQtdEmb, 3) + ", " + ;
                                                EscaparSQL(loc_cCodEmbs) + ", " + ;
                                                FormatarNumeroSQL(loc_nMultis, 3) + ", " + ;
                                                EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                                EscaparSQL(fUniqueIds()) + ", " + ;
                                                "GETDATE())"
                                            IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                                loc_lOks = .F.
                                                MsgErro("Falha ao inserir subitem de embalagem (SigMvIts)", "Erro")
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF

                                SELECT csItens
                            ENDSCAN

                            SELECT csItens
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- Processar CsEstPe -> SigMvPec
                        IF USED("CsEstPe")
                            LOCAL loc_nCodigos, loc_dDatatrans, loc_nNtrans
                            LOCAL loc_cLocals, loc_nValobxs, loc_cEmpSubsLocal
                            LOCAL loc_dDatas, loc_lChksubn, loc_dDtagends
                            LOCAL loc_lChkpagos, loc_nNparcs, loc_nValps
                            LOCAL loc_nValvars, loc_dVencps, loc_cPstatus
                            LOCAL loc_cEmpDopNumsPec, loc_cSQLPec

                            SELECT CsEstPe
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos ANTES de SQLEXEC
                                loc_nCodigos     = NVL(CsEstPe.Codigos, 0)
                                loc_dDatatrans   = CsEstPe.Datatrans
                                loc_nNtrans      = NVL(CsEstPe.Ntrans, 0)
                                loc_cLocals      = ALLTRIM(CsEstPe.Locals)
                                loc_nValobxs     = NVL(CsEstPe.Valobxs, 0)
                                loc_cEmpSubsLocal = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                                loc_dDatas       = CsEstPe.Datas
                                loc_lChksubn     = IIF(VARTYPE(CsEstPe.Chksubn) = "L", ;
                                                       CsEstPe.Chksubn, ;
                                                       NVL(CsEstPe.Chksubn, 0) = 1)
                                loc_dDtagends    = CsEstPe.Dtagends
                                loc_lChkpagos    = IIF(VARTYPE(CsEstPe.Chkpagos) = "L", ;
                                                       CsEstPe.Chkpagos, ;
                                                       NVL(CsEstPe.Chkpagos, 0) = 1)
                                loc_nNparcs      = NVL(CsEstPe.Nparcs, 0)
                                loc_nValps       = NVL(CsEstPe.Valps, 0)
                                loc_nValvars     = NVL(CsEstPe.Valvars, 0)
                                loc_dVencps      = CsEstPe.Vencps
                                loc_cPstatus     = LEFT(ALLTRIM(CsEstPe.Pstatus), 1)
                                loc_cEmpDopNumsPec = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + ;
                                                     STR(loc_nNum, 6)

                                loc_cSQLPec = "INSERT INTO SigMvPec " + ;
                                    "(emps, dopes, numes, codigos, datatrans, ntrans, " + ;
                                    " locals, valobxs, cidchaves, empdopnums, empsubns, " + ;
                                    " datas, chksubn, dtagends, chkpagos, nparcs, " + ;
                                    " valps, valvars, vencps, pstatus) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCodigos, 0) + ", " + ;
                                    FormatarDataSQL(loc_dDatatrans) + ", " + ;
                                    FormatarNumeroSQL(loc_nNtrans, 0) + ", " + ;
                                    EscaparSQL(LEFT(loc_cLocals, 10)) + ", " + ;
                                    FormatarNumeroSQL(loc_nValobxs, 2) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNumsPec) + ", " + ;
                                    EscaparSQL(LEFT(loc_cEmpSubsLocal, 3)) + ", " + ;
                                    FormatarDataSQL(loc_dDatas) + ", " + ;
                                    IIF(loc_lChksubn, "1", "0") + ", " + ;
                                    FormatarDataSQL(loc_dDtagends) + ", " + ;
                                    IIF(loc_lChkpagos, "1", "0") + ", " + ;
                                    FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nValps, 2) + ", " + ;
                                    FormatarNumeroSQL(loc_nValvars, 2) + ", " + ;
                                    FormatarDataSQL(loc_dVencps) + ", " + ;
                                    EscaparSQL(loc_cPstatus) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQLPec) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir parcela de pedido (SigMvPec)", "Erro")
                                ENDIF

                                SELECT CsEstPe
                            ENDSCAN

                            SELECT CsEstPe
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Preparando Grava" + CHR(231) + CHR(227) + "o")

                        *-- Auditoria
                        THIS.this_cDopes    = ALLTRIM(loc_cDopes)
                        THIS.this_cGerEmps  = loc_cEmps
                        THIS.this_cGerDopes = ALLTRIM(loc_cDopes)
                        THIS.this_nGerNumes = loc_nNum
                        THIS.RegistrarAuditoria("GERAR")

                        *-- Commit da transacao
                        IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                        ELSE
                            loc_lTransacaoAberta = .F.
                        ENDIF
                    ENDIF

                    IF !loc_lOks AND loc_lTransacaoAberta
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                    ENDIF

                    IF loc_lOks
                        *-- Atualizar csCabec local com marcacao de gerado
                        SELECT csCabec
                        REPLACE Gerado   WITH "OK", ;
                                GerEmps  WITH loc_cEmps, ;
                                GerDopes WITH ALLTRIM(loc_cDopes), ;
                                GerNumes WITH loc_nNum

                        THIS.this_cEmpDopNums = loc_cEmpDopNums
                        loc_lResultado = .T.
                    ENDIF

                    *-- Fechar cursores temporarios
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF USED("crTmpPro")
                        USE IN crTmpPro
                    ENDIF
                    IF USED("crTmpGru")
                        USE IN crTmpGru
                    ENDIF

                    loc_loBarra.Complete(.T.)

                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro GerarPedido")
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        ENDTRY

        *-- Restaurar SET KEY dos cursores de iteracao
        IF USED("csItens")
            SELECT csItens
            SET KEY TO
        ENDIF
        IF USED("CsEstPe")
            SELECT CsEstPe
            SET KEY TO
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPeriodo - Stub de compatibilidade com chamadas de SigMvCab
    * O formulario legado definia este metodo para nao gerar erro nas chamadas
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarPeriodo(par_P1, par_P2, par_P3)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Log da operacao de geracao de movimento
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cMsg, loc_cDopps
        loc_cDopps = ""
        IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
            IF TYPE("CrSigCdNec.Dopps") != "U"
                loc_cDopps = ALLTRIM(CrSigCdNec.Dopps)
            ENDIF
        ENDIF
        loc_cMsg = "Ger.Movim.: " + ALLTRIM(THIS.this_cGerDopes) + ;
                   " Num." + ALLTRIM(STR(THIS.this_nGerNumes, 6)) + ;
                   " Emp." + ALLTRIM(THIS.this_cGerEmps)
        IF !EMPTY(loc_cDopps)
            =fGravarLog("T", loc_cDopps, gc_4c_UsuarioLogado, loc_cMsg)
        ENDIF
    ENDPROC

ENDDEFINE

