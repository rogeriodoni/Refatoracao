*====================================================================
* SIGOPCORBO.prg
*
* Business Object de SIGOPCOR - Carta de Correcao de Nota Fiscal
* (inclusao da carta de correcao para uma FAIXA de notas fiscais de
*  uma mesma empresa e serie)
*
* Tabela principal : SigNfCor  - chave primaria cidchaves
* Tabelas de apoio : SigCcOco  - tipos de ocorrencia da correcao
*                    SigCdEmp  - razao social da empresa
*                    SigMvNfi  - flag correcs da nota fiscal
*
* Origem legado : SIGOPCOR.SCX
*                 tasks\task707\SIGOPCOR_form_codigo_fonte.txt
* Chamado por   : SIGCDCNF, botao InserirCarta da pagina Lista
*                 Do Form SigOpCor With ThisForm, pcemps, lcSerie,
*                                      ldEmisDe, ldEmisAte
*
* Cursores do legado espelhados pelas propriedades abaixo:
*   CrSigNfCor  Select * From SigNfCor
*               Where cemps = ?pcEmps And cseries = ?pcSeries
*                 And cnfis between ?pcNFisDe And ?pcNFisAte
*               Order By cemps, cseries, cnfis, noccors
*   CrSigCcOco  AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
*               tabela inteira, sem filtro, ordenada por ncodigos
*   CrSigCdEmp  Select * From SigCdEmp Where cemps = ?pcEmps
*   XCorNf      Create Cursor XCorNf (cods n(3), descs c(30), retifs m NULL)
*               grade da tela - uma linha por ocorrencia de SigCcOco
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGOPCORBO AS BusinessBase

    *----------------------------------------------------------------
    * Colunas de SigNfCor (entidade gravada pela tela)
    * Tipos conferidos em docs/schema.sql
    *----------------------------------------------------------------
    this_cCidchaves = ""    && cidchaves char(20) NOT NULL - PK Fortyus (fUniqueIds)
    this_cEmps      = ""    && cemps     char(3)  NOT NULL - empresa
    this_cSeries    = ""    && cseries   char(3)  NOT NULL - serie da nota fiscal
    this_cNfis      = ""    && cnfis     char(6)  NOT NULL - numero da nota fiscal
    this_nNoccors   = 0     && noccors   numeric(3,0) NOT NULL - ocorrencia (FK SigCcOco.ncodigos)
    this_cMretifs   = ""    && mretifs   text NULL - texto da retificacao digitado na grade

    *----------------------------------------------------------------
    * Faixa de notas fiscais informada na tela
    * Get_NotaIni / Get_NotaFim, fwget MaxLength = 6, mesma largura de
    * SigNfCor.cnfis char(6). Alimentam o "cnfis between ?pcNFisDe And
    * ?pcNFisAte" do cursor CrSigNfCor do legado.
    * Sao CHARACTER: o Ok.Click do form irmao SIGOPCCO faz
    * Padr(ThisForm.Get_NotaIni.Value, 6), que exige valor character.
    *----------------------------------------------------------------
    this_cNfisDe    = ""    && pcNFisDe - primeira nota da faixa
    this_cNfisAte   = ""    && pcNFisAte - ultima nota da faixa

    *----------------------------------------------------------------
    * Contexto recebido do form chamador (SIGCDCNF)
    * ThisForm.EmisDe / ThisForm.EmisAte guardam DtIni.Value e
    * DtFim.Value do container de filtros do SIGCDCNF, portanto DATE.
    * O legado nao os usa em consulta nenhuma desta tela: eles sao
    * repassados adiante para o relatorio SigReImc, igual ao que o
    * form irmao SIGOPCCO faz no fim do Ok.Click.
    *----------------------------------------------------------------
    this_dEmisDe    = {}    && data de emissao inicial do filtro de origem
    this_dEmisAte   = {}    && data de emissao final do filtro de origem

    *----------------------------------------------------------------
    * Apoio: SigCdEmp (cursor CrSigCdEmp do legado)
    * Colunas canonicas de SigCdEmp sao cemps e razas - nunca Cemps/Razas
    *----------------------------------------------------------------
    this_cRazas     = ""    && SigCdEmp.razas char(40) - razao social da empresa

    *----------------------------------------------------------------
    * Apoio: SigCcOco (cursor CrSigCcOco do legado)
    * Linha corrente da lista de ocorrencias que monta a grade XCorNf
    * (XCorNf.cods recebe ncodigos e XCorNf.descs recebe cdescrs)
    *----------------------------------------------------------------
    this_nNcodigos  = 0     && SigCcOco.ncodigos numeric(3,0) - codigo da ocorrencia
    this_cCdescrs   = ""    && SigCcOco.cdescrs  char(30) - descricao da ocorrencia

    *----------------------------------------------------------------
    * Resultado da gravacao em lote da carta de correcao: fica .T.
    * quando pelo menos uma linha da grade tinha retificacao digitada
    * (equivale ao buffer crSigNfCor nao vazio do Ok.Click legado) e
    * decide o valor gravado em SigMvNfi.correcs (coluna bit).
    * E estado de SESSAO: tem de ser reposto em cada gravacao, porque
    * o form migrado nao fecha entre uma nota e a seguinte.
    *----------------------------------------------------------------
    this_lTemCorrecoesGravadas = .F.

    *====================================================================
    * Init - define tabela e campo chave da entidade
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigNfCor"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - valor da PK usado pelo RegistrarAuditoria
    * de BusinessBase (chamado em Inserir/Atualizar/ExecutarExclusao)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * LimparDados - zera as propriedades do REGISTRO antes de uma nova
    * inclusao. BusinessBase.LimparDados so limpa this_cMensagemErro, as
    * propriedades da entidade sao responsabilidade da subclasse.
    *
    * O contexto da TELA (this_cEmps, this_cSeries, this_cNfisDe,
    * this_cNfisAte, this_dEmisDe, this_dEmisAte, this_cRazas) e
    * preservado de proposito: ele vem do form chamador e vale para a
    * faixa inteira de notas, nao para um registro so.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_cNfis      = ""
        THIS.this_nNoccors   = 0
        THIS.this_cMretifs   = ""
        THIS.this_nNcodigos  = 0
        THIS.this_cCdescrs   = ""

        THIS.this_lTemCorrecoesGravadas = .F.

        RETURN .T.
    ENDPROC


    *====================================================================
    * CarregarOcorrencias - popula cursor_4c_TiposOcorrencia com a LISTA
    * COMPLETA de tipos de ocorrencia da carta de correcao (SigCcOco).
    *
    * Equivalente ao cursor CrSigCcOco do legado, criado SEM query e SEM
    * filtro, ordenado pela chave:
    *   .AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
    *   ThisForm.poDataMgr.Requery('CrSigCcOco')
    *
    * E a fonte da grade da tela: o Scan unico do Init legado percorre
    * este cursor e insere uma linha em XCorNf por ocorrencia, com a
    * retificacao em BRANCO (Insert Into XCorNf (cods,descs,retifs)
    * Values (CrSigCcOco.ncodigos, CrSigCcOco.cdescrs, '')).
    *
    * Diferente do form irmao SIGOPCCO, esta tela NAO casa retificacoes
    * ja gravadas com as linhas da grade: o legado requery CrSigNfCor com
    * os filtros vazios (pcEmps/pcSeries/pcNFisDe/pcNFisAte), que nao
    * casa nada de proposito, e nao tem um segundo Scan. E coerente com a
    * natureza da tela: a correcao vale para uma FAIXA de notas, logo nao
    * ha texto de uma nota especifica para pre-carregar.
    *
    * Colunas conferidas em docs/schema.sql: SigCcOco tem exatamente
    * ncodigos numeric(3,0) NOT NULL (PK) e cdescrs char(30) NOT NULL.
    *
    * Sem conexao viva (harness headless / validacao de UI, onde
    * gnConnHandle fica -1) o metodo devolve .F. em silencio: SQLEXEC com
    * handle invalido dispara excecao, e o dialogo de erro travaria a
    * execucao sem supervisao.
    *====================================================================
    PROCEDURE CarregarOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                           "  FROM SigCcOco" + ;
                           " ORDER BY ncodigos"

                IF USED("cursor_4c_TiposOcorrencia")
                    IF CURSORGETPROP("Buffering", "cursor_4c_TiposOcorrencia") > 1
                        TABLEREVERT(.T., "cursor_4c_TiposOcorrencia")
                    ENDIF
                    USE IN cursor_4c_TiposOcorrencia
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOcorrencia")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MostrarErro("Erro ao carregar as ocorr" + CHR(234) + "ncias da Carta de Corre" + ;
                                CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, ;
                                "Erro SQL")
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "SIGOPCORBO.CarregarOcorrencias")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * CarregarDoCursor - mapeia as 6 colunas de SigNfCor para as
    * propriedades this_* do BO (equivale a leitura do cursor CrSigNfCor
    * do legado, criado por
    *   .AddCursor('SigNfCor','cidchaves','CrSigNfCor','','',lcQryCorNf)
    * com lcQryCorNf = Select * From SigNfCor Where cemps = ?pcEmps And
    * cseries = ?pcSeries And cnfis between ?pcNFisDe And ?pcNFisAte).
    *
    * Colunas conferidas em docs/schema.sql - SigNfCor tem exatamente
    * estas seis: cemps char(3), cseries char(3), cnfis char(6),
    * noccors numeric(3,0), mretifs text NULL, cidchaves char(20) PK.
    *
    * TratarNulo(valor, PADRAO): o 2o argumento e o VALOR de fallback
    * usado quando a coluna vem NULL - NAO o tipo. Por isso "" para
    * char/text e 0 para numeric. mretifs e a UNICA coluna NULL do
    * schema, logo o caso NULL e real e nao teorico.
    *
    * SELECT (par_cAliasCursor) antes de ler os campos: VFP nao aceita a
    * forma campo.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_cEmps      = TratarNulo(cemps,     "")
                THIS.this_cSeries    = TratarNulo(cseries,   "")
                THIS.this_cNfis      = TratarNulo(cnfis,     "")
                THIS.this_nNoccors   = TratarNulo(noccors,   0)
                THIS.this_cMretifs   = TratarNulo(mretifs,   "")

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor [" + ;
                    IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "") + ;
                    "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - guarda chamada por BusinessBase.Salvar() antes de
    * Inserir()/Atualizar().
    *
    * O dump de SIGOPCOR.SCX traz codigo para apenas cinco metodos (Load,
    * Init, o When das colunas 1 e 2 da grade e o KeyPress do Edit1 da
    * coluna 3) - o Ok.Click do CommandGroup Sair chegou VAZIO no acervo
    * (conferido tambem no .sct, que so guarda esses cinco). A guarda
    * transcrita aqui e a do Ok.Click do form IRMAO SIGOPCCO, que grava a
    * MESMA tabela (SigNfCor) a partir da MESMA grade (XCorNf):
    *     If Not IsEmpty(ThisForm.Get_NotaIni.Value)
    *         ...
    *     Else
    *         MessageBox('Nota Fiscal Invalida !!',0+48,'')
    *     EndIf
    * Mensagem reproduzida LITERALMENTE, com o acento em CHR(225).
    *
    * Nenhuma outra coluna e criticada, de proposito: cemps, cseries e
    * noccors chegam do form chamador (SIGCDCNF) e o legado nunca os
    * valida. Sao NOT NULL, mas NOT NULL aceita branco/zero - exigir
    * conteudo seria inventar restricao que o legado nao tem.
    *
    * Preenche this_cMensagemErro e devolve .F.: quem EXIBE e o
    * ExibirFalha() de BusinessBase, para a mensagem nao sair duas vezes.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF VARTYPE(THIS.this_cNfis) != "C" OR EMPTY(ALLTRIM(THIS.this_cNfis))
            THIS.this_cMensagemErro = "Nota Fiscal Inv" + CHR(225) + "lida !!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - grava UMA ocorrencia de Carta de Correcao em SigNfCor.
    *
    * Transcreve o Insert do Ok.Click do form irmao SIGOPCCO (mesma
    * tabela, mesma grade):
    *     Insert Into crSigNfCor (cEmps, cSeries, cNfis, nOccors,
    *                             mRetifs, cIdChaves) ;
    *                     Values (ThisForm.Emp, ThisForm.Serie,
    *                             ThisForm.Get_NotaIni.Value,
    *                             XCorNf.Cods, XCorNf.Retifs, fUniqueIds())
    *
    * As SEIS colunas de SigNfCor entram no INSERT - as CINCO NOT NULL
    * (cemps, cseries, cnfis, noccors, cidchaves) mais mretifs, que e a
    * carga util da tela. A tabela nao tem DEFAULT em coluna nenhuma
    * (conferido em docs/schema.sql), portanto omitir qualquer NOT NULL
    * faria o SQL Server recusar o INSERT inteiro.
    *
    * cidchaves vem de fUniqueIds() - cCodEmpresa(3) + RIGHT(SYS(2015),9)
    * + 8 digitos = exatamente os char(20) da coluna. NUNCA string vazia:
    * a PK e unica e o 2o registro colidiria no indice signfcor_cidchaves.
    *
    * PADR nas larguras do schema reproduz o Padr(...,3)/Padr(...,6) que o
    * Ok.Click legado aplica nas mesmas tres colunas, e evita o
    * "String or binary data would be truncated" quando o valor chega
    * maior que a coluna. mretifs e text: leva ALLTRIM, nunca PADR.
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cChave, loc_cEmps, loc_cSeries, loc_cNfis, loc_cMretifs
        loc_lSucesso = .F.

        TRY
            *-- EMPTY(.NULL.) devolve .F. no VFP9, por isso o teste de
            *-- VARTYPE vem ANTES: sem ele uma PK nula escaparia da geracao
            *-- e estouraria no ALLTRIM logo abaixo
            IF VARTYPE(THIS.this_cCidchaves) != "C" OR EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cChave   = LEFT(ALLTRIM(THIS.this_cCidchaves), 20)
            loc_cEmps    = PADR(ALLTRIM(THIS.this_cEmps),   3)
            loc_cSeries  = PADR(ALLTRIM(THIS.this_cSeries), 3)
            loc_cNfis    = PADR(ALLTRIM(THIS.this_cNfis),   6)
            loc_cMretifs = IIF(VARTYPE(THIS.this_cMretifs) = "C", ALLTRIM(THIS.this_cMretifs), "")

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigNfCor
                       (cemps, cseries, cnfis, noccors, mretifs, cidchaves)
                VALUES (
                    <<EscaparSQL(loc_cEmps)>>,
                    <<EscaparSQL(loc_cSeries)>>,
                    <<EscaparSQL(loc_cNfis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    <<EscaparSQL(loc_cMretifs)>>,
                    <<EscaparSQL(loc_cChave)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao incluir a Carta de Corre" + CHR(231) + CHR(227) + "o:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - altera uma ocorrencia de Carta de Correcao ja gravada.
    *
    * Equivale ao ramo "a ocorrencia ja existe" do Ok.Click do form irmao
    * SIGOPCCO, que reaproveita a linha em vez de incluir outra:
    *     Locate For crSigNfCor.nOccors = XCorNf.Cods
    *     If Eof([crSigNfCor])
    *         Insert Into crSigNfCor (...)
    *     Else
    *         Replace mRetifs With XCorNf.Retifs In crSigNfCor
    *     EndIf
    *
    * O UPDATE leva as cinco colunas de dados e filtra pela PK cidchaves
    * (this_cCampoChave definido no Init). Sem PK no objeto o WHERE ficaria
    * aberto, entao a operacao e recusada com mensagem - BusinessBase.
    * Salvar() a exibe pelo ExibirFalha().
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cChave, loc_cEmps, loc_cSeries, loc_cNfis, loc_cMretifs
        loc_lSucesso = .F.

        TRY
            loc_cChave = IIF(VARTYPE(THIS.this_cCidchaves) = "C", ALLTRIM(THIS.this_cCidchaves), "")

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Carta de Corre" + CHR(231) + CHR(227) + ;
                    "o sem chave (cidchaves) - altera" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o realizada."
            ELSE
                loc_cEmps    = PADR(ALLTRIM(THIS.this_cEmps),   3)
                loc_cSeries  = PADR(ALLTRIM(THIS.this_cSeries), 3)
                loc_cNfis    = PADR(ALLTRIM(THIS.this_cNfis),   6)
                loc_cMretifs = IIF(VARTYPE(THIS.this_cMretifs) = "C", ALLTRIM(THIS.this_cMretifs), "")

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    UPDATE SigNfCor
                       SET cemps   = <<EscaparSQL(loc_cEmps)>>,
                           cseries = <<EscaparSQL(loc_cSeries)>>,
                           cnfis   = <<EscaparSQL(loc_cNfis)>>,
                           noccors = <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                           mretifs = <<EscaparSQL(loc_cMretifs)>>
                     WHERE cidchaves = <<EscaparSQL(LEFT(loc_cChave, 20))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MostrarErro("Erro ao alterar a Carta de Corre" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - apaga uma ocorrencia de Carta de Correcao.
    *
    * PROTECTED de proposito: de fora o form chama sempre Excluir(), que e
    * o metodo PUBLIC de BusinessBase e dispara AntesDeExcluir/
    * DepoisDeExcluir/LimparDados em volta desta exclusao.
    *
    * Equivale ao Delete do Ok.Click do form irmao SIGOPCCO, que limpa as
    * retificacoes da nota antes de regravar a carta:
    *     Delete From SigNfCor Where CEmps = '<emp>' And
    *                                CSeries = '<serie>' And CNfis = '<nf>'
    * Aqui o filtro e a PK cidchaves (this_cCampoChave), para apagar
    * exatamente a ocorrencia carregada e nenhuma outra. Sem PK no objeto a
    * exclusao e recusada com mensagem, que Excluir() exibe pelo
    * ExibirFalha() - um WHERE aberto apagaria a tabela inteira.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cChave = IIF(VARTYPE(THIS.this_cCidchaves) = "C", ALLTRIM(THIS.this_cCidchaves), "")

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Carta de Corre" + CHR(231) + CHR(227) + ;
                    "o sem chave (cidchaves) - exclus" + CHR(227) + "o n" + CHR(227) + "o realizada."
            ELSE
                loc_cSQL = "DELETE FROM SigNfCor" + ;
                           " WHERE cidchaves = " + EscaparSQL(LEFT(loc_cChave, 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    *-- Auditoria ANTES de perder a chave: BusinessBase.
                    *-- Excluir() chama LimparDados() depois deste metodo
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MostrarErro("Erro ao excluir a Carta de Corre" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
