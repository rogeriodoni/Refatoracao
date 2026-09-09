# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EVENTUA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NTPIMPRES, USUACESS, CIMPS, USUARIOS, GRUPOS, I, CMOES, REL_DESCS, LNCONTADOR
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NTPIMPRES, USUACESS, CIMPS, USUARIOS, GRUPOS, I, CMOES, REL_DESCS, LNCONTADOR

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQuery = [Select * ] + ;
		    [From SigCdMoe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdMoe') < 1)
Select crSigCdMoe
lcQuery = [Select cmoes,datas,horas,valos,cidchaves,usuars,dtalts ] + ;
			[From SigCdCot ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCot') < 1)
Select crSigCdCot
	lcSQLCmd = [Select Impres, nTpImpres From SigCdmp ] + ;
	lnSQLErr = ThisForm.Podatamgr.SQLExecute(lcSQLCmd, 'Tmp1')
	Select Impres, nTpImpres, llFlags as lMarcas, llFlags as lSituas ;
	  From Tmp1 ;
	Select csSigCdmp
	lcSql = [Select b.Impres, b.nTpImpres  From SigSyImp a, SigCdmp b Where a.UsuAcess = ']+Usuar+[' And a.cImps = b.Impres And b.nTpImpres = ?pTip ]+;
			[Select c.Impres, c.nTpImpres  From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios=']+Usuar+[' ]+;
	If ThisForm.Podatamgr.sqlexecute(lcSql,'CrTmpCimp') <= 0
	Select CrTmpCimp
		Select Impres, nTpImpres  From CrTmpCimp Into Cursor LocalcImp Group by Impres, nTpImpres ReadWrite
		Select *, llFlags as lMarcas, llFlags as lSituas ;
		  From LocalcImp ;
		Select csSigCdmp
 		If Seek(lcImpres, 'csSigCdmp', 'Impres')
	 		Select csSigCdmp
	Select csSigCdmp
Select crSigCdMoe
	select crSigOpTdz
		insert into dbtemp1 (cd_moeda,nm_tabela,vl_cotacao) ;
select a.cd_moeda,a.nm_tabela,str(a.vl_cotacao,9,2) as vl_cotacao;
	from dbtemp1 a into cursor dbtemp2 Order by a.Cd_Moeda
select dbtemp3
select dbtemporario
	insert into dbrelatorio (detalhe) ;
select crSigOpTdz
select dbtemporario
insert into dbcabecalho (moeda_referencia,cabecalho,linha) ;
select dbrelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormTBI.prg) - TRECHOS RELEVANTES PARA PASS SQL (924 linhas total):

*-- Linhas 477 a 496:
477:             USE IN cursor_4c_TbiLkpMoeda
478:         ENDIF
479: 
480:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
481:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiLkpMoeda")
482: 
483:         IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda") AND ;
484:            RECCOUNT("cursor_4c_TbiLkpMoeda") > 0
485:             THIS.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_TbiLkpMoeda.cmoes)
486:             THIS.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_TbiLkpMoeda.dmoes)
487:             USE IN cursor_4c_TbiLkpMoeda
488:         ELSE
489:             IF USED("cursor_4c_TbiLkpMoeda")
490:                 USE IN cursor_4c_TbiLkpMoeda
491:             ENDIF
492:             THIS.AbrirBuscaMoeda(loc_cValor)
493:         ENDIF
494: 
495:         *-- Reaplica a regra do When original (descricao editavel so com codigo vazio)
496:         THIS.AlternarPagina(1)

*-- Linhas 524 a 546:
524:             USE IN cursor_4c_TbiLkpMoeda
525:         ENDIF
526: 
527:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
528:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiLkpMoeda")
529: 
530:         IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda")
531:             SELECT cursor_4c_TbiLkpMoeda
532:             LOCATE FOR ALLTRIM(UPPER(dmoes)) == loc_cValor
533:         ENDIF
534: 
535:         IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda") AND ;
536:            FOUND("cursor_4c_TbiLkpMoeda")
537:             THIS.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_TbiLkpMoeda.cmoes)
538:             THIS.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_TbiLkpMoeda.dmoes)
539:             USE IN cursor_4c_TbiLkpMoeda
540:         ELSE
541:             IF USED("cursor_4c_TbiLkpMoeda")
542:                 USE IN cursor_4c_TbiLkpMoeda
543:             ENDIF
544:             THIS.AbrirBuscaMoeda(loc_cValor)
545:         ENDIF
546: 

*-- Linhas 739 a 757:
739:     * (Encerrar) - nao ha Grid, nao ha lista de registros e nao existem os
740:     * botoes Incluir/Alterar/Excluir/Buscar. Em nenhum ponto do codigo fonte
741:     * legado (Load, Init, os dois Valid, cmd_ok.Click, cmd_cancela.Click) ha
742:     * INSERT, UPDATE ou DELETE: o formulario apenas LE e VALIDA um codigo de
743:     * moeda ja existente em SigCdMoe para montar a tabela de cambio impressa.
744:     * A manutencao de SigCdMoe pertence exclusivamente ao Cadastro de Moedas
745:     * (FormMoe / MoeBO).
746:     *
747:     * Portanto NAO se acrescenta aqui nenhum botao CRUD: isso inventaria
748:     * funcionalidade inexistente no legado e violaria o PILAR 1 (UX identica
749:     * ao original). Os handlers abaixo existem para cumprir o contrato de
750:     * eventos do FormBase e para GARANTIR, com mensagem clara e estado
751:     * consistente, que uma chamada externa (menu, tecla de atalho herdada ou
752:     * codigo futuro) nao tente gravar por este formulario. Sao o espelho, na
753:     * camada de UI, dos overrides TBIBO.Inserir() / TBIBO.Atualizar(), que ja
754:     * bloqueiam a gravacao na camada de negocio retornando .F. com
755:     * this_cMensagemErro preenchido.
756:     *==========================================================================
757: 


### BO (C:\4c\projeto\app\classes\TBIBO.prg):
*==============================================================================
* TBIBO.PRG
* Business Object - Tabelas de Referencia (Impressao de Tabela de Cambio)
* Baseado no formulario legado SIGCDTBI (Relatorio de Tabelas de Referencia)
* Camada: BusinessBase (regras de negocio) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS TBIBO AS BusinessBase

    *-- Propriedades principais (espelham os campos do formulario original)
    this_cMoeda            = ""    && Codigo da moeda de referencia (SigCdMoe.Cmoes)
    this_cMoedaDescricao   = ""    && Descricao da moeda de referencia (SigCdMoe.Dmoes)
    this_nCopias           = 1     && Quantidade de copias da impressao
    this_cConteudoRelatorio = ""   && Texto pronto para impressao (montado por GerarTabelaReferencia)
    this_cMensagemErro     = ""    && Mensagem de erro/aviso preenchida por GerarTabelaReferencia/Inserir/Atualizar

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdMoe")

        THIS.this_cCampoChave = "Cmoes"

        THIS.this_cMoeda = ""
        THIS.this_cMoedaDescricao = ""
        THIS.this_nCopias = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o codigo/descricao da moeda de referencia
    * a partir de um cursor resultante de SELECT em SigCdMoe (cmoes, dmoes),
    * espelhando o retorno do fwBuscaExt('SigCdMoe', ...) do formulario
    * original (Valid de get_moeda / get_moeda_desc).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoeda          = TratarNulo(cmoes, "C")
            THIS.this_cMoedaDescricao = TratarNulo(dmoes, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo da moeda de referencia atualmente carregada
    * (usado por RegistrarAuditoria e por eventuais chamadas de Salvar/Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cMoeda)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCotacao - Cotacao mais recente (<= par_dData) da moeda informada,
    * espelhando fBuscarCambio(ctod(''), par_dData, space(03), par_cMoeda) do
    * codigo original (cmd_ok.Click). Retorna 0 se nao houver cotacao lancada
    * para a moeda na tabela SigCdCot.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResultado
        loc_nCotacao = 0

        IF EMPTY(ALLTRIM(NVL(par_cMoeda, "")))
            RETURN loc_nCotacao
        ENDIF

        IF USED("cursor_4c_TbiCotacao")
            USE IN cursor_4c_TbiCotacao
        ENDIF

        loc_cSQL = "SELECT valos, datas FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                   " ORDER BY datas DESC, horas DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiCotacao")

        IF loc_nResultado > 0 AND USED("cursor_4c_TbiCotacao") AND ;
           RECCOUNT("cursor_4c_TbiCotacao") > 0
            SELECT cursor_4c_TbiCotacao
            LOCATE FOR datas <= par_dData
            IF FOUND("cursor_4c_TbiCotacao")
                loc_nCotacao = NVL(cursor_4c_TbiCotacao.valos, 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_TbiCotacao")
            USE IN cursor_4c_TbiCotacao
        ENDIF

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarTabelaReferencia - Monta o conteudo texto (THIS.this_cConteudoRelatorio)
    * da tabela de cambio das Tabelas de Referencia (SigOpTdz com Rel_Descs = 1),
    * convertidas para a moeda informada em par_cMoedaRef, espelhando a logica
    * de cmd_ok.Click do formulario original (sem a selecao de impressora de
    * etiqueta legada, que nao se aplica a arquitetura nova).
    *
    * Retorna .T. com THIS.this_cConteudoRelatorio preenchido em caso de
    * sucesso, ou .F. com THIS.this_cMensagemErro preenchido caso nao haja
    * tabelas de desconto marcadas (Rel_Descs = 1) ou ocorra falha de SQL.
    *--------------------------------------------------------------------------
    FUNCTION GerarTabelaReferencia(par_cMoedaRef)
        LOCAL loc_lSucesso, loc_cMoedaRef, loc_nCotRef, loc_cSQL, loc_nResultado
        LOCAL loc_cMoeda, loc_nCotacao, loc_lMultiplica, loc_nValorConvertido
        LOCAL loc_cConteudo, loc_cLinha, loc_lExisteImpressao, loc_oErro

        loc_lSucesso            = .F.
        loc_lExisteImpressao    = .F.
        loc_cMoedaRef           = ALLTRIM(NVL(par_cMoedaRef, ""))
        THIS.this_cMensagemErro     = ""
        THIS.this_cConteudoRelatorio = ""

        TRY
            IF USED("cursor_4c_TbiMoedas")
                USE IN cursor_4c_TbiMoedas
            ENDIF
            IF USED("cursor_4c_TbiTabelas")
                USE IN cursor_4c_TbiTabelas
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, fmults, tabrefs FROM SigCdMoe ORDER BY cmoes"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiMoedasTmp")

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao consultar Moedas (SigCdMoe)."
            ELSE
                SELECT * FROM cursor_4c_TbiMoedasTmp INTO CURSOR cursor_4c_TbiMoedas READWRITE
                IF USED("cursor_4c_TbiMoedasTmp")
                    USE IN cursor_4c_TbiMoedasTmp
                ENDIF

                loc_cSQL = "SELECT codigos, descos, descrs FROM SigOpTdz " + ;
                           "WHERE rel_descs = 1 ORDER BY codigos"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiTabelasTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar Tabelas de " + ;
                        "Refer" + CHR(234) + "ncia (SigOpTdz)."
                ELSE
                    SELECT * FROM cursor_4c_TbiTabelasTmp INTO CURSOR cursor_4c_TbiTabelas READWRITE
                    IF USED("cursor_4c_TbiTabelasTmp")
                        USE IN cursor_4c_TbiTabelasTmp
                    ENDIF

                    IF RECCOUNT("cursor_4c_TbiTabelas") = 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                            " tabelas de desconto selecionadas para impress" + ;
                            CHR(227) + "o !"
                    ELSE
                        loc_nCotRef = THIS.ObterCotacao(loc_cMoedaRef, DATE())

                        loc_cConteudo = REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                            "Tabelas de refer" + CHR(234) + "ncia em " + DTOC(DATE()) + CHR(13) + CHR(10) + ;
                            REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                            "Moeda de refer" + CHR(234) + "ncia: " + loc_cMoedaRef + ;
                            " (" + ALLTRIM(TRANSFORM(loc_nCotRef, "999999999.99")) + ")" + ;
                            CHR(13) + CHR(10) + CHR(13) + CHR(10)

                        SELECT cursor_4c_TbiMoedas
                        SCAN FOR ALLTRIM(cursor_4c_TbiMoedas.cmoes) <> loc_cMoedaRef ;
                                AND cursor_4c_TbiMoedas.tabrefs
                            loc_cMoeda      = ALLTRIM(cursor_4c_TbiMoedas.cmoes)
                            loc_lMultiplica = (ALLTRIM(cursor_4c_TbiMoedas.fmults) == "S")
                            loc_nCotacao    = THIS.ObterCotacao(loc_cMoeda, DATE())

                            loc_cConteudo = loc_cConteudo + "Moeda: " + loc_cMoeda + CHR(13) + CHR(10) + ;
                                PADR("Tabela", 12) + PADR("Desconto %", 14) + "Valor Convertido" + CHR(13) + CHR(10) + ;
                                REPLICATE("-", 45) + CHR(13) + CHR(10)

                            SELECT cursor_4c_TbiTabelas
                            SCAN
                                loc_lExisteImpressao = .T.
                                loc_nValorConvertido = IIF(loc_lMultiplica, ;
                                    ROUND(loc_nCotRef * loc_nCotacao * (1 - (cursor_4c_TbiTabelas.descos / 100)), 2), ;
                                    ROUND(loc_nCotacao * (1 - (cursor_4c_TbiTabelas.descos / 100)), 2))

                                loc_cLinha = PADR(ALLTRIM(cursor_4c_TbiTabelas.codigos), 12) + ;
                                    PADR(ALLTRIM(TRANSFORM(cursor_4c_TbiTabelas.descos, "999.99")), 14) + ;
                                    ALLTRIM(TRANSFORM(loc_nValorConvertido, "999999999.99"))

                                loc_cConteudo = loc_cConteudo + loc_cLinha + CHR(13) + CHR(10)
                            ENDSCAN

                            loc_cConteudo = loc_cConteudo + CHR(13) + CHR(10)

                            SELECT cursor_4c_TbiMoedas
                        ENDSCAN

                        IF !loc_lExisteImpressao
                            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                                " tabelas de desconto selecionadas para impress" + ;
                                CHR(227) + "o !"
                        ELSE
                            THIS.this_cConteudoRelatorio = loc_cConteudo
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_TbiMoedas")
            USE IN cursor_4c_TbiMoedas
        ENDIF
        IF USED("cursor_4c_TbiTabelas")
            USE IN cursor_4c_TbiTabelas
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar - TBIBO NAO grava registros de moeda.
    *
    * O formulario original SIGCDTBI ("Relatorio de Tabelas de Referencia")
    * eh um utilitario de IMPRESSAO: ele apenas LE e VALIDA um codigo de
    * moeda ja existente em SigCdMoe (via fwBuscaExt, metodos Valid de
    * get_moeda/get_moeda_desc) para montar a tabela de cambio impressa no
    * cmd_ok.Click. Em nenhum ponto do codigo fonte original ha um INSERT
    * ou UPDATE em SigCdMoe - o cadastro/manutencao da moeda pertence
    * exclusivamente ao MoeBO/FormMoe (Cadastro de Moedas).
    *
    * Estes overrides existem para cumprir o contrato de BusinessBase e
    * bloquear, com mensagem clara, qualquer tentativa de gravacao por
    * este BO - evitando duplicar (e divergir de) a regra de negocio de
    * SigCdMoe que ja vive em MoeBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Este formul" + CHR(225) + "rio " + ;
            "n" + CHR(227) + "o cadastra moedas." + CHR(13) + ;
            "Utilize o Cadastro de Moedas para incluir novos registros."
        RETURN .F.
    ENDFUNC

    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Este formul" + CHR(225) + "rio " + ;
            "n" + CHR(227) + "o cadastra moedas." + CHR(13) + ;
            "Utilize o Cadastro de Moedas para alterar registros existentes."
        RETURN .F.
    ENDFUNC

ENDDEFINE

