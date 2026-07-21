# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '0' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS SQL (906 linhas total):

*-- Linhas 314 a 332:
314:             .FontName          = "Tahoma"
315:             .AllowHeaderSizing = .F.
316:             .AllowRowSizing    = .F.
317:             .DeleteMark        = .F.
318:             .RecordMark        = .F.
319:             .ReadOnly          = .T.
320:             .RowHeight         = 17
321:             .ScrollBars        = 2
322:             .Panel             = 1
323:             .Visible           = .F.
324: 
325:             WITH .Column1
326:                 .Width            = 108
327:                 .Movable          = .F.
328:                 .Resizable        = .F.
329:                 .ReadOnly         = .T.
330:                 .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
331:                 WITH .Header1
332:                     .FontName  = "Tahoma"

*-- Linhas 438 a 460:
438:                 THIS.grd_4c_Dados.ColumnCount = 5
439:                 THIS.grd_4c_Dados.RecordSource = "TmpBaixa"
440:                 WITH THIS.grd_4c_Dados
441:                     .Column1.ControlSource = "TmpBaixa.CodBarra"
442:                     .Column2.ControlSource = "TmpBaixa.CPros"
443:                     .Column3.ControlSource = "TmpBaixa.Dopes"
444:                     .Column4.ControlSource = "TmpBaixa.Numes"
445:                     .Column5.ControlSource = "TmpBaixa.QtdeLido"
446:                     .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
447:                     .Column2.Header1.Caption = "Produto"
448:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
449:                     .Column4.Header1.Caption = "N" + CHR(250) + "mero"
450:                     .Column5.Header1.Caption = "Qtde."
451:                     .Refresh()
452:                 ENDWITH
453:             ENDIF
454: 
455:             *-- Alternar para modo com/sem dados conforme TmpBaixa
456:             IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
457:                 THIS.AlternarPagina(2)
458:             ELSE
459:                 THIS.AlternarPagina(1)
460:             ENDIF

*-- Linhas 567 a 585:
567:                 loc_nCodBarra = THIS.txt_4c_Leitura.Value
568:                 THIS.this_oBusinessObject.MarcarLeitura(loc_nCodBarra)
569:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
570:                     SELECT TmpBaixa
571:                     SET ORDER TO CodBarra
572:                     SEEK loc_nCodBarra
573:                     THIS.grd_4c_Dados.Refresh()
574:                 ENDIF
575:                 THIS.txt_4c_Leitura.Value = 0
576:             ELSE
577:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
578:                     THIS.grd_4c_Dados.Refresh()
579:                 ENDIF
580:             ENDIF
581:             par_nKeyCode = 0
582:         CATCH TO loc_oErro
583:             MsgErro(loc_oErro.Message, "Erro Leitura")
584:         ENDTRY
585:     ENDPROC

*-- Linhas 727 a 745:
727:                 RETURN
728:             ENDIF
729: 
730:             SELECT TmpBaixa
731:             REPLACE ALL QtdeLido WITH 0
732: 
733:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
734:                 THIS.grd_4c_Dados.Refresh()
735:             ENDIF
736:         CATCH TO loc_oErro
737:             MsgErro(loc_oErro.Message, "Erro BtnExcluir")
738:         ENDTRY
739:     ENDPROC
740: 
741:     *==========================================================================
742:     * CarregarLista - Recarrega etiquetas de TmpEnc e atualiza a grade
743:     *==========================================================================
744:     PROCEDURE CarregarLista()
745:         LOCAL loc_lResultado, loc_oErro

*-- Linhas 753 a 775:
753:                 THIS.grd_4c_Dados.ColumnCount = 5
754:                 THIS.grd_4c_Dados.RecordSource = "TmpBaixa"
755:                 WITH THIS.grd_4c_Dados
756:                     .Column1.ControlSource = "TmpBaixa.CodBarra"
757:                     .Column2.ControlSource = "TmpBaixa.CPros"
758:                     .Column3.ControlSource = "TmpBaixa.Dopes"
759:                     .Column4.ControlSource = "TmpBaixa.Numes"
760:                     .Column5.ControlSource = "TmpBaixa.QtdeLido"
761:                     .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
762:                     .Column2.Header1.Caption = "Produto"
763:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
764:                     .Column4.Header1.Caption = "N" + CHR(250) + "mero"
765:                     .Column5.Header1.Caption = "Qtde."
766:                     .Refresh()
767:                 ENDWITH
768:             ENDIF
769: 
770:             IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
771:                 THIS.AlternarPagina(2)
772:             ELSE
773:                 THIS.AlternarPagina(1)
774:             ENDIF
775: 


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object: Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o
* Herda de BusinessBase
* Cursor principal: TmpBaixa (VFP local)
* Tabelas SQL Server: SigOpEtq, SigMvCab, SigMvItn, SigMvIts, SigMvHst
*                    SigCdPam, SigCdPac, SigCdPro, SigCdGrp, SigCdCli, SigCdOpe
*==============================================================================

DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Configuracao cursor de trabalho
    this_cTabela        = "TmpBaixa"
    this_cCampoChave    = "CodBarra"

    *-- Dados da sessao (fornecidos pelo form ao inicializar)
    this_cSigKey        = ""
    this_dData          = {}

    *-- Configuracoes carregadas de SigCdPam
    this_cGruConfs      = ""
    this_cConConfs      = ""
    this_cGruReservs    = ""
    this_cConReservs    = ""
    this_cDopeCitens    = ""
    this_cTransfEncs    = ""
    this_cGrupoEsts     = ""
    this_cContaEsts     = ""

    *-- Campos do registro corrente de TmpBaixa
    this_nCodBarra      = 0      && CodBarra N(14,0) - chave de barras
    this_cCPros         = ""     && CPros C(14) - codigo produto
    this_cDopes         = ""     && Dopes C(20) - operacao
    this_nNumes         = 0      && Numes N(6,0) - numero da ordem
    this_nQtde          = 0      && Qtde N(12,3) - quantidade total
    this_nQtdeLido      = 0      && QtdeLido N(12,3) - quantidade conferida
    this_nNops          = 0      && Nops N(10,0) - numero ops
    this_cGrupods       = ""     && Grupods C(10) - grupo destino
    this_cContads       = ""     && Contads C(10) - conta destino

    *==========================================================================
    FUNCTION Init()
    *==========================================================================
        THIS.this_cTabela     = "TmpBaixa"
        THIS.this_cCampoChave = "CodBarra"
        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_nCodBarra
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor TmpBaixa
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodBarra  = NVL(CodBarra,  0)
                THIS.this_cCPros     = ALLTRIM(NVL(CPros,     ""))
                THIS.this_cDopes     = ALLTRIM(NVL(Dopes,     ""))
                THIS.this_nNumes     = NVL(Numes,     0)
                THIS.this_nQtde      = NVL(Qtde,      0)
                THIS.this_nQtdeLido  = NVL(QtdeLido,  0)
                THIS.this_nNops      = NVL(Nops,      0)
                THIS.this_cGrupods   = ALLTRIM(NVL(Grupods,   ""))
                THIS.this_cContads   = ALLTRIM(NVL(Contads,   ""))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere registro no cursor VFP local TmpBaixa
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                INSERT INTO TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, ;
                                       Nops, Grupods, Contads) ;
                    VALUES (THIS.this_nCodBarra, THIS.this_cCPros, THIS.this_cDopes, ;
                            THIS.this_nNumes, THIS.this_nQtde, THIS.this_nNops, ;
                            THIS.this_cGrupods, THIS.this_cContads)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza QtdeLido/Grupods/Contads no cursor TmpBaixa
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                SELECT TmpBaixa
                SET ORDER TO CodBarra
                IF SEEK(THIS.this_nCodBarra)
                    REPLACE QtdeLido WITH THIS.this_nQtdeLido, ;
                            Grupods  WITH THIS.this_cGrupods, ;
                            Contads  WITH THIS.this_cContads
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarCursores - Cria/recria o cursor TmpBaixa com indices
    *==========================================================================
    PROCEDURE InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                USE IN TmpBaixa
            ENDIF
            CREATE CURSOR TmpBaixa (CodBarra N(14,0), CPros C(14), Dopes C(20), ;
                                     Numes N(6,0), Qtde N(12,3), QtdeLido N(12,3), ;
                                     Nops N(10,0), Grupods C(10), Contads C(10))
            INDEX ON CodBarra TAG CodBarra
            INDEX ON Grupods + Contads TAG GruConta
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarConfigPam - Carrega parametros de SigCdPam para propriedades
    *==========================================================================
    PROCEDURE CarregarConfigPam()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 GruConfs, ConConfs, GruReservs, ConReservs, " + ;
                       "DopeCitens, TransfEncs, GrupoEsts, ContaEsts FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamConf") > 0
                SELECT cursor_4c_PamConf
                THIS.this_cGruConfs    = ALLTRIM(NVL(GruConfs,    ""))
                THIS.this_cConConfs    = ALLTRIM(NVL(ConConfs,    ""))
                THIS.this_cGruReservs  = ALLTRIM(NVL(GruReservs,  ""))
                THIS.this_cConReservs  = ALLTRIM(NVL(ConReservs,  ""))
                THIS.this_cDopeCitens  = ALLTRIM(NVL(DopeCitens,  ""))
                THIS.this_cTransfEncs  = ALLTRIM(NVL(TransfEncs,  ""))
                THIS.this_cGrupoEsts   = ALLTRIM(NVL(GrupoEsts,   ""))
                THIS.this_cContaEsts   = ALLTRIM(NVL(ContaEsts,   ""))
                USE IN cursor_4c_PamConf
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarSigKey - Carrega SigKeys de SigCdPac para this_cSigKey
    *==========================================================================
    PROCEDURE CarregarSigKey()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 SigKeys FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigKey") > 0
                SELECT cursor_4c_SigKey
                THIS.this_cSigKey = ALLTRIM(NVL(SigKeys, ""))
                USE IN cursor_4c_SigKey
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MarcarLeitura - Marca codigo de barras como lido em TmpBaixa
    * par_nCodBarra: codigo de barras numerico (N14)
    * Equivalente ao Get_Leitura.Valid do legado
    *==========================================================================
    PROCEDURE MarcarLeitura(par_nCodBarra)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa") AND !EMPTY(par_nCodBarra) AND par_nCodBarra <> 0
                SELECT TmpBaixa
                SET ORDER TO CodBarra
                IF SEEK(par_nCodBarra)
                    IF TmpBaixa.QtdeLido = 0
                        REPLACE QtdeLido WITH TmpBaixa.Qtde IN TmpBaixa
                        loc_lResultado = .T.
                    ELSE
                        MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + ;
                                 " Foi Lido!!!")
                    ENDIF
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + ;
                             "o Cadastrado!!!")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConferirAutomatico - Marca todos os itens como conferidos (QtdeLido=Qtde)
    * Equivalente ao Conferencia.Click do legado
    *==========================================================================
    PROCEDURE ConferirAutomatico()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                SELECT TmpBaixa
                SET ORDER TO CodBarra
                REPLACE ALL QtdeLido WITH Qtde
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarBars - Popula TmpBaixa a partir de TmpEnc + SigOpEtq
    * par_cCursorTmpEnc: alias do cursor TmpEnc do form pai
    * Equivalente ao carregabars do legado
    *==========================================================================
    PROCEDURE CarregarBars(par_cCursorTmpEnc)
        LOCAL loc_lResultado
        LOCAL loc_cEmpr, loc_cDopeCit, loc_cChave, loc_cSQL
        LOCAL loc_cDopps, loc_nNumps
        LOCAL loc_cGrupos, loc_cContas
        LOCAL loc_cEmpos, loc_cDopeOs, loc_nNumeOs, loc_cCPros
        LOCAL loc_cDopes2, loc_cGlobalizas, loc_nServicos
        LOCAL loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_cCGrus, loc_nTipoEstos
        LOCAL loc_cIClis, loc_cGruProds, loc_cConProds
        LOCAL loc_nQtds, loc_nQtEti, loc_nQtCit
        LOCAL loc_nBaixa, loc_nPendente, loc_pVal, loc_pDat
        LOCAL loc_llBaixa
        LOCAL loc_cCBars, loc_cNops
        LOCAL loc_cCodCors, loc_cCodTams
        LOCAL loc_nCItens2, loc_cEI_CId
        LOCAL loc_cEmpDopNums2, loc_cCIdChaves, loc_nQtBaixas, loc_nQtds2
        LOCAL loc_cCIdChaves2, loc_nQtBaixas2, loc_nQtds3

        loc_lResultado = .F.

        TRY
            IF !THIS.CarregarConfigPam()
                loc_lResultado = .F.
            ENDIF

            loc_cEmpr    = go_4c_Sistema.cCodEmpresa
            loc_cDopeCit = THIS.this_cDopeCitens

            SELECT TmpBaixa
            DELETE ALL

            IF !USED(par_cCursorTmpEnc)
                loc_lResultado = .F.
            ENDIF

            SELECT (par_cCursorTmpEnc)
            DELETE ALL FOR EMPTY(Dopps) OR EMPTY(Numps)

            SCAN IN &par_cCursorTmpEnc.
                loc_cDopps = ALLTRIM(Dopps)
                loc_nNumps = Numps
                loc_cChave = loc_cEmpr + loc_cDopps + STR(loc_nNumps, 6)

                THIS.CursorQuery("SigOpEtq", "cursor_4c_SigOpEtq", "EmpDopNums", loc_cChave)

                SELECT cursor_4c_SigOpEtq
                SCAN
                    loc_cGrupos  = ALLTRIM(cursor_4c_SigOpEtq.Grupos)
                    loc_cContas  = ALLTRIM(cursor_4c_SigOpEtq.Contas)
                    loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtq.Empos)
                    loc_cDopeOs  = ALLTRIM(cursor_4c_SigOpEtq.DopeOs)
                    loc_nNumeOs  = cursor_4c_SigOpEtq.NumeOs
                    loc_cCPros   = ALLTRIM(cursor_4c_SigOpEtq.CPros)
                    loc_nQtds    = cursor_4c_SigOpEtq.Qtds
                    loc_cCBars   = cursor_4c_SigOpEtq.CBars
                    loc_cNops    = cursor_4c_SigOpEtq.Nops
                    loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtq.CodCors)
                    loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtq.CodTams)

                    IF (loc_cGrupos + loc_cContas) = ;
                       (THIS.this_cGruConfs + THIS.this_cConConfs)

                        THIS.CursorQuery("SigMvCab", "cursor_4c_LocalEest", "EmpDopNums", ;
                                         loc_cEmpos + loc_cDopeOs + STR(loc_nNumeOs, 6))

                        SELECT cursor_4c_LocalEest
                        IF !EOF()
                            loc_cDopes2 = ALLTRIM(cursor_4c_LocalEest.Dopes)
                        ELSE
                            loc_cDopes2 = ""
                        ENDIF

                        THIS.CursorQuery("SigCdOpe", "cursor_4c_SigCdOpe", "Dopes", loc_cDopes2)

                        SELECT cursor_4c_SigCdOpe
                        IF !EOF()
                            loc_cGlobalizas = cursor_4c_SigCdOpe.Globalizas
                            loc_nServicos   = cursor_4c_SigCdOpe.Servicos
                        ELSE
                            loc_cGlobalizas = 0
                            loc_nServicos   = 0
                        ENDIF

                        SELECT cursor_4c_LocalEest
                        IF !EOF()
                            IF (loc_cGlobalizas = 1) OR (loc_nServicos = 1)
                                loc_cTGrupo = ALLTRIM(cursor_4c_LocalEest.Grupoos)
                                loc_cTConta = ALLTRIM(cursor_4c_LocalEest.Contaos)
                            ELSE
                                loc_cTGrupo = ALLTRIM(cursor_4c_LocalEest.Grupods)
                                loc_cTConta = ALLTRIM(cursor_4c_LocalEest.Contads)
                            ENDIF
                        ELSE
                            loc_cTGrupo = ""
                            loc_cTConta = ""
                        ENDIF

                        loc_cGrupo = IIF(EMPTY(THIS.this_cGruReservs), loc_cTGrupo, THIS.this_cGruReservs)
                        loc_cConta = IIF(EMPTY(THIS.this_cConReservs), loc_cTConta, THIS.this_cConReservs)

                        THIS.CursorQuery("SigCdPro", "cursor_4c_SigCdPro", "CPros", loc_cCPros, "CGrus")

                        SELECT cursor_4c_SigCdPro
                        IF !EOF()
                            loc_cCGrus = ALLTRIM(cursor_4c_SigCdPro.CGrus)
                        ELSE
                            loc_cCGrus = ""
                        ENDIF

                        THIS.CursorQuery("SigCdGrp", "cursor_4c_SigCdGrp", "CGrus", loc_cCGrus, "TipoEstos")

                        SELECT cursor_4c_SigCdGrp
                        IF !EOF()
                            loc_nTipoEstos = cursor_4c_SigCdGrp.TipoEstos
                            IF !INLIST(loc_nTipoEstos, 2, 3, 4)
                                loc_nTipoEstos = 1
                            ENDIF
                        ELSE
                            loc_nTipoEstos = 1
                        ENDIF

                        THIS.CursorQuery("SigCdCli", "cursor_4c_SigCdCli", "IClis", loc_cTConta, ;
                                         "GruProds, ConProds")

                        SELECT cursor_4c_SigCdCli
                        IF !EOF()
                            loc_cGruProds = ALLTRIM(cursor_4c_SigCdCli.GruProds)
                            loc_cConProds = ALLTRIM(cursor_4c_SigCdCli.ConProds)
                        ELSE
                            loc_cGruProds = ""
                            loc_cConProds = ""
                        ENDIF

                        loc_nQtEti = loc_nQtds
                        loc_nQtCit = 0

                        IF !EMPTY(loc_cDopeCit)
                            THIS.CursorQuery("SigMvCab", "cursor_4c_LocalEest2", "EmpDopNums", ;
                                             loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6))

                            SELECT cursor_4c_LocalEest2
                            IF !EOF()
                                IF loc_nTipoEstos = 1
                                    loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds FROM SigMvItn " + ;
                                               "WHERE EmpDopNums = " + ;
                                               EscaparSQL(loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)) + ;
                                               " AND CPros = " + EscaparSQL(loc_cCPros)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEestI") < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                "Falha na Conex" + CHR(227) + "o (LocalEestI)")
                                    ELSE
                                        loc_nBaixa = loc_nQtds

                                        SELECT cursor_4c_LocalEestI
                                        GO TOP
                                        SCAN WHILE loc_nBaixa > 0
                                            loc_nQtBaixas  = cursor_4c_LocalEestI.QtBaixas
                                            loc_nQtds2     = cursor_4c_LocalEestI.Qtds
                                            loc_cCIdChaves = ALLTRIM(cursor_4c_LocalEestI.cIdChaves)

                                            IF (loc_nQtds2 - loc_nQtBaixas) <> 0
                                                loc_nPendente = loc_nQtds2 - loc_nQtBaixas
                                                IF loc_nPendente > loc_nBaixa
                                                    loc_pVal  = loc_nBaixa
                                                    loc_nBaixa = 0
                                                ELSE
                                                    loc_pVal   = loc_nPendente
                                                    loc_nBaixa = loc_nBaixa - loc_nPendente
                                                ENDIF

                                                loc_pDat   = DATETIME()
                                                loc_llBaixa = IIF(loc_nQtBaixas + loc_pVal = loc_nQtds2, .T., .F.)

                                                loc_cSQL = "UPDATE SigMvItn " + ;
                                                           "SET QtBaixas = QtBaixas + ?loc_pVal, " + ;
                                                           "ChkSubn = ?loc_llBaixa, " + ;
                                                           "DtAlts = ?loc_pDat " + ;
                                                           "WHERE cIdChaves = " + EscaparSQL(loc_cCIdChaves)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                                            "Falha na Conex" + CHR(227) + ;
                                                            "o (Update SigMvItn 1)")
                                                ENDIF
                                            ENDIF
                                        ENDSCAN
                                    ENDIF
                                ELSE
                                    loc_cSQL = "SELECT cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds " + ;
                                               "FROM SigMvIts " + ;
                                               "WHERE EmpDopNums = " + ;
                                               EscaparSQL(loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)) + ;
                                               " AND CPros = " + EscaparSQL(loc_cCPros) + ;
                                               " AND CodCors = " + EscaparSQL(loc_cCodCors) + ;
                                               " AND CodTams = " + EscaparSQL(loc_cCodTams)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEstI2") < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                "Falha na Conex" + CHR(227) + "o (LocalEstI2)")
                                    ELSE
                                        loc_nBaixa = loc_nQtds

                                        SELECT cursor_4c_LocalEstI2
                                        SCAN WHILE loc_nBaixa > 0
                                            loc_cEmpDopNums2 = ALLTRIM(cursor_4c_LocalEstI2.EmpDopNums)
                                            loc_nCItens2     = cursor_4c_LocalEstI2.CItens
                                            loc_nQtBaixas2   = cursor_4c_LocalEstI2.QtBaixas
                                            loc_nQtds3       = cursor_4c_LocalEstI2.Qtds
                                            loc_cCIdChaves2  = ALLTRIM(cursor_4c_LocalEstI2.cIdChaves)

                                            loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds FROM SigMvItn " + ;
                                                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums2) + ;
                                                       " AND CItens = " + FormatarNumeroSQL(loc_nCItens2, 0)
                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEestI") > 0
                                                loc_nPendente = loc_nQtds3 - loc_nQtBaixas2
                                                IF loc_nPendente <> 0
                                                    IF loc_nPendente > loc_nBaixa
                                                        loc_pVal = loc_nBaixa
                                                    ELSE
                                                        loc_pVal = loc_nPendente
                                                    ENDIF
                                                    loc_pDat    = DATETIME()
                                                    loc_llBaixa = IIF(loc_nQtBaixas2 + loc_pVal = loc_nQtds3, .T., .F.)
                                                    loc_cEI_CId = ALLTRIM(cursor_4c_LocalEestI.cIdChaves)

                                                    loc_cSQL = "UPDATE SigMvIts " + ;
                                                               "SET QtBaixas = QtBaixas + ?loc_pVal, " + ;
                                                               "ChkSubn = ?loc_llBaixa " + ;
                                                               "WHERE cIdChaves = " + EscaparSQL(loc_cCIdChaves2)
                                                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                                "Falha na Conex" + CHR(227) + ;
                                                                "o (Update SigMvIts 1)")
                                                    ENDIF

                                                    loc_cSQL = "UPDATE SigMvItn " + ;
                                                               "SET QtBaixas = QtBaixas + ?loc_pVal, " + ;
                                                               "DtAlts = ?loc_pDat " + ;
                                                               "WHERE cIdChaves = " + EscaparSQL(loc_cEI_CId)
                                                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                                "Falha na Conex" + CHR(227) + ;
                                                                "o (Update SigMvItn 3)")
                                                    ENDIF

                                                    IF loc_nPendente > loc_nBaixa
                                                        loc_nBaixa = 0
                                                    ELSE
                                                        loc_nBaixa = loc_nBaixa - loc_nPendente
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDSCAN
                                    ENDIF
                                    loc_nQtCit = loc_nQtEti - loc_nBaixa
                                ENDIF
                            ENDIF
                        ENDIF

                        loc_nQtEti = loc_nQtds - loc_nQtCit

                        loc_cGrupo = IIF(EMPTY(loc_cGruProds), loc_cGrupo, loc_cGruProds)
                        loc_cConta = IIF(EMPTY(loc_cConProds), loc_cConta, loc_cConProds)

                        IF loc_nQtEti <> 0
                            INSERT INTO TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, ;
                                                   Nops, Grupods, Contads) ;
                                VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                        loc_nQtEti, loc_cNops, loc_cGrupo, loc_cConta)
                        ENDIF

                        IF loc_nQtCit <> 0
                            INSERT INTO TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, ;
                                                   Nops, Grupods, Contads) ;
                                VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                        loc_nQtCit, loc_cNops, ;
                                        THIS.this_cGrupoEsts, THIS.this_cContaEsts)
                        ENDIF

                    ENDIF

                    SELECT (par_cCursorTmpEnc)
                ENDSCAN

                IF USED("cursor_4c_SigOpEtq")
                    USE IN cursor_4c_SigOpEtq
                ENDIF
            ENDSCAN

            SELECT TmpBaixa
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
                         CHR(231) + CHR(227) + "o!!!")
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarBars")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfirmarConferencia - Grava movimentos no SQL Server e encerra
    * Cria registros em SigMvCab, SigMvItn, SigMvHst e atualiza SigOpEtq
    * Equivalente ao Ok.Click do legado
    * Retorna .T. se gravacao bem-sucedida
    *==========================================================================
    PROCEDURE ConfirmarConferencia()
        LOCAL loc_lResultado, loc_llTaOk
        LOCAL loc_cEmpr, loc_cUsuar, loc_cDope, loc_nNume
        LOCAL loc_cSQL, loc_lItem
        LOCAL loc_pDat, loc_pBar, loc_cPCidC, loc_nPSeq
        LOCAL loc_cGrupods, loc_cContads
        LOCAL loc_cCPros, loc_cDPros, loc_cCunis
        LOCAL loc_cCodCors, loc_cCodTams, loc_cEmpos
        LOCAL loc_nQtdeLido, loc_cCursor

        loc_lResultado = .F.
        loc_llTaOk     = .T.

        TRY
            IF !USED("TmpBaixa")
                loc_lResultado = .F.
            ENDIF

            SELECT TmpBaixa
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            loc_cEmpr  = go_4c_Sistema.cCodEmpresa
            loc_cUsuar = gc_4c_UsuarioLogado
            loc_cDope  = THIS.this_cTransfEncs

            *-- Criar cursores de trabalho espelhando estrutura SQL Server
            THIS.CriarCursorTrabalho("SigMvCab", "cursor_4c_CrSigMvCab")
            THIS.CriarCursorTrabalho("SigMvItn", "cursor_4c_CrSigMvItn")
            THIS.CriarCursorTrabalho("SigMvHst", "cursor_4c_CrSigMvHst")

            *-- xGrava: agrupamento de itens por Grupo+Conta+Produto
            IF USED("cursor_4c_xGrava")
                USE IN cursor_4c_xGrava
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_xGrava (Grupo C(10), Conta C(10), CPros C(14), Qtds N(12,3))
            SET NULL OFF
            INDEX ON Grupo + Conta TAG GruConta

            *-- xCabec: cabecalhos distintos por Grupods+Contads
            SELECT DISTINCT Grupods, Contads FROM TmpBaixa ;
                WHERE QtdeLido <> 0 INTO CURSOR cursor_4c_xCabec READWRITE

            SELECT cursor_4c_xCabec
            SCAN
                loc_cGrupods = ALLTRIM(cursor_4c_xCabec.Grupods)
                loc_cContads = ALLTRIM(cursor_4c_xCabec.Contads)

                loc_nNume = fGerUniqueKey(loc_cEmpr + loc_cDope)

                INSERT INTO cursor_4c_CrSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, ;
                                                    Usuars, Grupoos, Contaos, Grupods, Contads, ;
                                                    EmpDopNums, cIdChaves, DtAlts, EmpGopNums) ;
                                           VALUES (loc_cEmpr, loc_cDope, loc_nNume, ;
                                                   ALLTRIM(fGerMascara(loc_nNume)), ;
                                                   DATETIME(), DATETIME(), ;
                                                   loc_cUsuar, THIS.this_cGruConfs, THIS.this_cConConfs, ;
                                                   loc_cGrupods, loc_cContads, ;
                                                   loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                   fUniqueIds(), DATETIME(), ;
                                                   loc_cEmpr + SPACE(20) + STR(0, 6))

                loc_lItem = 0

                SELECT TmpBaixa
                SET ORDER TO GruConta
                SEEK loc_cGrupods + loc_cContads

                SCAN WHILE ALLTRIM(Grupods) + ALLTRIM(Contads) = loc_cGrupods + loc_cContads ;
                     FOR QtdeLido <> 0

                    loc_lItem     = loc_lItem + 1
                    loc_cCPros    = ALLTRIM(TmpBaixa.CPros)
                    loc_nQtdeLido = TmpBaixa.QtdeLido
                    loc_pBar      = TmpBaixa.CodBarra

                    THIS.CursorQuery("SigCdPro", "cursor_4c_SigCdProC", "CPros", loc_cCPros, ;
                                     "DPros, CUnis")
                    THIS.CursorQuery("SigOpEtq", "cursor_4c_SigOpEtqC", "CBars", loc_pBar, ;
                                     "CodCors, CodTams, Empos")

                    SELECT cursor_4c_SigCdProC
                    IF !EOF()
                        loc_cDPros = ALLTRIM(cursor_4c_SigCdProC.DPros)
                        loc_cCunis = ALLTRIM(cursor_4c_SigCdProC.CUnis)
                    ELSE
                        loc_cDPros = ""
                        loc_cCunis = ""
                    ENDIF

                    SELECT cursor_4c_SigOpEtqC
                    IF !EOF()
                        loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtqC.CodCors)
                        loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtqC.CodTams)
                        loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtqC.Empos)
                    ELSE
                        loc_cCodCors = ""
                        loc_cCodTams = ""
                        loc_cEmpos   = loc_cEmpr
                    ENDIF

                    INSERT INTO cursor_4c_CrSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, ;
                                                       CUnis, DPros, Opers, CodBarras, ;
                                                       EmpDopNums, cIdChaves, DtAlts) ;
                                               VALUES (loc_lItem, loc_cEmpr, loc_cDope, loc_nNume, ;
                                                       loc_cCPros, loc_nQtdeLido, ;
                                                       loc_cCunis, loc_cDPros, "S", loc_pBar, ;
                                                       loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                       fUniqueIds(), DATETIME())

                    *-- Historico Saida (Opers='S')
                    loc_cPCidC = DTOS(DATE()) + "S" + ;
                                 TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + ;
                                 THIS.this_cSigKey
                    loc_nPSeq  = fGerUniqueKey("HISTBAR")

                    INSERT INTO cursor_4c_CrSigMvHst (Usuars, Datas, Datars, Emps, Empos, ;
                                                       Dopes, Numes, CPros, Qtds, Opers, ;
                                                       Grupos, Estos, CodBarras, CodCors, ;
                                                       CodTams, cIdChaves, EmpDopNums, ;
                                                       EmpGruEsts, OriDopNums, Seqs) ;
                                               VALUES (loc_cUsuar, DATETIME(), DATETIME(), ;
                                                       loc_cEmpos, loc_cEmpr, loc_cDope, loc_nNume, ;
                                                       loc_cCPros, loc_nQtdeLido, "S", ;
                                                       THIS.this_cGruConfs, THIS.this_cConConfs, ;
                                                       loc_pBar, loc_cCodCors, loc_cCodTams, ;
                                                       loc_cPCidC, ;
                                                       loc_cEmpos + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_cEmpos + THIS.this_cGruConfs + THIS.this_cConConfs, ;
                                                       loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_nPSeq)

                    SELECT cursor_4c_CrSigMvHst
                    GO BOTTOM
                    =fRecalculaP(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.Grupos, ;
                                 cursor_4c_CrSigMvHst.Estos, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas, cursor_4c_CrSigMvHst.CodCors, ;
                                 cursor_4c_CrSigMvHst.CodTams)
                    =fRecalculaC(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas)

                    *-- Historico Entrada (Opers='E')
                    loc_cPCidC = DTOS(DATE()) + "E" + ;
                                 TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + ;
                                 THIS.this_cSigKey
                    loc_nPSeq  = fGerUniqueKey("HISTBAR")

                    INSERT INTO cursor_4c_CrSigMvHst (Usuars, Datas, Datars, Emps, Empos, ;
                                                       Dopes, Numes, CPros, Qtds, Opers, ;
                                                       Grupos, Estos, CodBarras, CodCors, ;
                                                       CodTams, cIdChaves, EmpDopNums, ;
                                                       EmpGruEsts, OriDopNums, Seqs) ;
                                               VALUES (loc_cUsuar, DATETIME(), DATETIME(), ;
                                                       loc_cEmpos, loc_cEmpr, loc_cDope, loc_nNume, ;
                                                       loc_cCPros, loc_nQtdeLido, "E", ;
                                                       loc_cGrupods, loc_cContads, ;
                                                       loc_pBar, loc_cCodCors, loc_cCodTams, ;
                                                       loc_cPCidC, ;
                                                       loc_cEmpos + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_cEmpos + loc_cGrupods + loc_cContads, ;
                                                       loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_nPSeq)

                    SELECT cursor_4c_CrSigMvHst
                    GO BOTTOM
                    =fRecalculaP(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.Grupos, ;
                                 cursor_4c_CrSigMvHst.Estos, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas, cursor_4c_CrSigMvHst.CodCors, ;
                                 cursor_4c_CrSigMvHst.CodTams)
                    =fRecalculaC(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas)

                    *-- Update SigOpEtq no SQL Server (dentro do SCAN)
                    loc_pDat = DATETIME()
                    loc_cSQL = "UPDATE SigOpEtq SET " + ;
                               "Grupos = " + EscaparSQL(loc_cGrupods) + ", " + ;
                               "Contas = " + EscaparSQL(loc_cContads) + ", " + ;
                               "DtMovs = ?loc_pDat " + ;
                               "WHERE CBars = ?loc_pBar"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (Update SigOpEtq)")
                        loc_llTaOk = .F.
                    ENDIF

                    SELECT TmpBaixa
                ENDSCAN

                SELECT cursor_4c_xCabec
            ENDSCAN

            *-- Gravar cursores locais no SQL Server
            IF loc_llTaOk
                IF !THIS.GravarCursorNoServidor("cursor_4c_CrSigMvCab", "SigMvCab")
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update SigMvCab)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !THIS.GravarCursorNoServidor("cursor_4c_CrSigMvItn", "SigMvItn")
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update SigMvItn)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !THIS.GravarCursorNoServidor("cursor_4c_CrSigMvHst", "SigMvHst")
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update SigMvHst)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !fRecalculaP(.T.)
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigOpClP)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !fRecalculaC(.T., .F., .F.)
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigOpClC)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF SQLTRANSACT(gnConnHandle, "COMMIT") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF !loc_llTaOk
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
            ENDIF

            loc_lResultado = loc_llTaOk

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfirmarConferencia")
            SQLTRANSACT(gnConnHandle, "ROLLBACK")
        ENDTRY

        *-- Limpar cursores temporarios
        IF USED("cursor_4c_CrSigMvCab")
            USE IN cursor_4c_CrSigMvCab
        ENDIF
        IF USED("cursor_4c_CrSigMvItn")
            USE IN cursor_4c_CrSigMvItn
        ENDIF
        IF USED("cursor_4c_CrSigMvHst")
            USE IN cursor_4c_CrSigMvHst
        ENDIF
        IF USED("cursor_4c_xGrava")
            USE IN cursor_4c_xGrava
        ENDIF
        IF USED("cursor_4c_xCabec")
            USE IN cursor_4c_xCabec
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CursorQuery - Helper: consulta tabela SQL Server por campo=valor
    *==========================================================================
    PROTECTED PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_xValor, par_cCampos)
        LOCAL loc_lcCampos, loc_lcQuery, loc_lcValor
        loc_lcCampos = IIF(PCOUNT() < 5 OR EMPTY(par_cCampos), "*", par_cCampos)
        loc_lcValor  = ALLTRIM(TRANSFORM(par_xValor))
        loc_lcQuery  = "SELECT " + loc_lcCampos + " FROM " + par_cTabela + ;
                       " WHERE " + par_cCampo + " = " + EscaparSQL(loc_lcValor)
        IF SQLEXEC(gnConnHandle, loc_lcQuery, par_cCursor) < 1
            SQLEXEC(gnConnHandle, "SELECT " + loc_lcCampos + " FROM " + par_cTabela + ;
                    " WHERE 0=1", par_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    * CriarCursorTrabalho - Cria cursor local com estrutura da tabela SQL Server
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorTrabalho(par_cTabela, par_cCursor)
        LOCAL loc_lSucesso, loc_nFlds
        LOCAL ARRAY loc_aFlds(1)
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM " + par_cTabela, "cursor_4c_TmpEstr_") > 0
                loc_nFlds = AFIELDS(loc_aFlds, "cursor_4c_TmpEstr_")
                USE IN cursor_4c_TmpEstr_
                CREATE CURSOR (par_cCursor) FROM ARRAY loc_aFlds
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar cursor de trabalho para " + par_cTabela, "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarCursorNoServidor - Insere todos os registros do cursor no SQL Server
    *==========================================================================
    PROTECTED PROCEDURE GravarCursorNoServidor(par_cCursor, par_cTabela)
        LOCAL loc_lSucesso, loc_nFlds, loc_i, loc_lcFields, loc_lcValues, loc_lcInsert
        LOCAL loc_xVal, loc_cTipo
        LOCAL ARRAY loc_aFlds(1)
        loc_lSucesso = .T.
        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                loc_nFlds = AFIELDS(loc_aFlds, par_cCursor)
                loc_lcFields = ""
                FOR loc_i = 1 TO loc_nFlds
                    IF loc_i > 1
                        loc_lcFields = loc_lcFields + ","
                    ENDIF
                    loc_lcFields = loc_lcFields + loc_aFlds(loc_i, 1)
                ENDFOR
                GO TOP IN (par_cCursor)
                SCAN IN &par_cCursor.
                    loc_lcValues = ""
                    FOR loc_i = 1 TO loc_nFlds
                        IF loc_i > 1
                            loc_lcValues = loc_lcValues + ","
                        ENDIF
                        loc_xVal  = EVALUATE(par_cCursor + "." + loc_aFlds(loc_i, 1))
                        loc_cTipo = loc_aFlds(loc_i, 2)
                        DO CASE
                            CASE ISNULL(loc_xVal)
                                loc_lcValues = loc_lcValues + "NULL"
                            CASE loc_cTipo $ "CM"
                                loc_lcValues = loc_lcValues + EscaparSQL(ALLTRIM(loc_xVal))
                            CASE loc_cTipo = "N"
                                loc_lcValues = loc_lcValues + ALLTRIM(STR(loc_xVal, 20, 6))
                            CASE loc_cTipo = "D"
                                IF EMPTY(loc_xVal)
                                    loc_lcValues = loc_lcValues + "NULL"
                                ELSE
                                    loc_lcValues = loc_lcValues + FormatarDataSQL(loc_xVal)
                                ENDIF
                            CASE loc_cTipo = "T"
                                IF EMPTY(loc_xVal)
                                    loc_lcValues = loc_lcValues + "NULL"
                                ELSE
                                    loc_lcValues = loc_lcValues + "'" + TTOC(loc_xVal, 3) + "'"
                                ENDIF
                            CASE loc_cTipo = "L"
                                loc_lcValues = loc_lcValues + IIF(loc_xVal = .T., "1", "0")
                            OTHERWISE
                                loc_lcValues = loc_lcValues + "NULL"
                        ENDCASE
                    ENDFOR
                    loc_lcInsert = "INSERT INTO " + par_cTabela + " (" + loc_lcFields + ") VALUES (" + loc_lcValues + ")"
                    IF SQLEXEC(gnConnHandle, loc_lcInsert) < 1
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GravarCursorNoServidor")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

