*============================================================================
* SigOpMpnBO.prg - Business Object da tela SIGOPMPN (tela de movimentacoes
* de subnivel ainda em aberto / nao confirmadas).
*
* Form OPERACIONAL (SIGOPMPN / FormSigOpMpn): dialogo chamado por outro form
* (o "form pai", que abre a tela com os parametros pForm/DatSes/Operacao do
* Init legado) para o usuario MARCAR, numa grade com CheckBox (fwcheckbox1
* na coluna "seleciona"), quais pendencias de subnivel de uma determinada
* "necessidade" (SigCdNec) vao entrar na operacao que o form pai esta
* montando. Ao confirmar (botao "OK"), o dialogo grava o detalhe das
* pendencias marcadas nos cursores de SAIDA do form pai (xMFas/xOpi/xNensi)
* e atualiza SigCdNec.ChkSubn para marcar o subnivel como utilizado.
*
* O legado liga esta tela DIRETO na DATA SESSION do form pai
* (Set DataSession To DatSes, dentro do proprio Init, ANTES do Create Cursor
* TmpPends) - por isso TmpNens, TmpOperacao, xMFas, xOpi, xPesa e xNensi NAO
* sao criados por este BO: sao cursores que o form PAI ja mantem abertos
* quando o dialogo e aberto, e que este BO so consulta/atualiza pelo NOME
* (propriedades this_cCursorXxx abaixo, no padrao ja usado em SigOpMpdBO,
* que e a mesma familia de tela).
*
*   TmpNens      - linha de NECESSIDADE (SigCdNec) que o form pai esta
*                  processando agora: Emps+Dopps+Numps identifica o "nivel"
*                  cuja lista de pendencias este dialogo exibe em TmpPends.
*   TmpOperacao  - codigos (NumNivel*10000000000 + NEnv) de pendencia JA
*                  usados/selecionados pelo form pai nesta sessao de edicao.
*   xMFas/xOpi   - cursores de SAIDA do form pai: o botao "OK" grava aqui o
*                  detalhe (fase/item) de cada pendencia marcada.
*   xPesa        - cursor de SAIDA do form pai, zerado no inicio do "OK"
*                  (Zap In xPesa) junto com os demais; o dump nao mostra
*                  nenhum Insert Into xPesa dentro do Click, entao este BO
*                  so expoe o nome do cursor (quem grava nele, se for o
*                  caso, e logica que ainda nao apareceu no dump).
*   xNensi       - cursor de SAIDA do form pai: o botao "OK" grava aqui o
*                  detalhe final (por envelope) das pendencias confirmadas,
*                  na MESMA estrutura dos cursores PROPRIOS xPNensi/xPNensiT
*                  abaixo (os tres vem de SigCdNei).
*
* Cursores GLOBAIS Fortyus (ja abertos pelo form pai/aplicacao, este BO so
* le pelo NOME - regra do projeto: cursor global so e' POPULADO no Init do
* BO quando e' deste BO a responsabilidade de garanti-lo; crSigCdOpd e
* crSigCdNec sao tabelas inteiras mantidas abertas em outro ponto do
* sistema, igual ao decidido em SigOpMpdBO para os cursores do form pai):
*   crSigCdOpd   - definicao do "Dopps" (subnivel/operacao): Nivels, NDopps,
*                  ConOSubs, ConDSubs, Numeras, BxAutos, SepPedras,
*                  CompAgrus, AcEnvs. Lido com Seek(..., 'crSigCdOpd', ...).
*   crSigCdNec   - a propria tabela de necessidades (SigCdNec), consultada
*                  diretamente (sem WHERE) em alguns pontos do "OK".
*
* Cursor GLOBAL de PARAMETROS (SigCdPam, tabela de 1 linha) - o "OK" le
* DIRETO crSigCdPam.TpPesas (para decidir this_lIndividualPorPeso de cada
* item de xOpi). Regra do projeto: cursor global Fortyus de 1 linha e'
* garantido no Init deste BO, nunca pressuposto - mesmo padrao canonico de
* ClienteBO.prg/SigOpMpdBO.prg.
*
* Cursores PROPRIOS (criados pela camada que monta a tela, nao por este
* Init - a criacao com CREATE CURSOR/SELECT INTO CURSOR fica no metodo que
* carrega as pendencias, em fase posterior; aqui so os NOMES canonicos):
*   TmpPends  - grade de selecao (Create Cursor TmpPends do Init legado):
*               Flag l, Emps c(3), Dopps c(20), Numps n(10), Datas d Null,
*               Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2),
*               Usuars c(10). As propriedades this_lFlag/this_cEmps/
*               this_cDopps/this_nNumps/this_dDatas/this_cObs/this_cGrupo/
*               this_cConta/this_nTPesos/this_cUsuars espelham estes MESMOS
*               campos, na MESMA ordem (regra #42 - reproducao exata evita
*               divergencia entre pontos que recriam o cursor).
*   xPNensi   - grade "Itens" (Gradeitem): detalhe por envelope/fase das
*               pendencias da linha corrente de TmpPends, originado de
*               SigCdNei.
*   xPNensiT  - grade "Total" (GradeTotal, alternada pelo botao Totaliza):
*               mesma estrutura de xPNensi, agregada por componente.
*
* UNICO alvo de escrita PERSISTIDA no SQL Server por este BO: SigCdNec.
* ChkSubn (bit), pela PK CidChaves (char(20)) -
*   Update SigCdNec Set ChkSubn = ?pNot/?pTru Where CidChaves = '<cid>'
* - por isso this_cTabela/this_cCampoChave abaixo, e por isso Atualizar()
* (a ser implementado em fase posterior) grava EXATAMENTE esse UPDATE. O
* legado aplica esse UPDATE em LOTE (um Scan por nivel), mas cada volta do
* Scan e' um UPDATE de UMA linha pela PK - que e' o contrato de
* Atualizar(). O restante da gravacao do "OK" (xMFas/xOpi/xNensi/
* TmpOperacao) grava em CURSORES locais do form pai, nao em tabela do SQL
* Server - medido contra docs/schema.sql (682 tabelas), nenhum desses 4
* nomes consta do schema, entao nao ha Inserir()/ExecutarExclusao() de
* tabela correspondente a eles (regra #22 proibe inventar lista de
* colunas de tabela que nao existe).
*
* O nivel (crSigCdOpd) e' lido tanto no Init legado quanto dentro de
* Marca() - as propriedades this_cNivelSubn/this_cNumeroNivel/
* this_cPuxaOrigem/this_cPuxaDestino/this_lNumeroAnt/this_lBaixaSubN
* cacheiam esses valores para as duas situacoes, recalculados por um
* metodo CarregarNivel (fase posterior) a partir de TmpNens.Dopps.
*
* O "Load" legado ("=fConfigGeral()") nao gera metodo neste BO: era
* inicializacao GLOBAL da aplicacao Fortyus, e na arquitetura nova isso ja
* acontece antes (config.prg/main.prg/cada BO com seus cursores) - mesma
* decisao documentada em SigOpMpdBO.prg/SigOpGrcBO.prg.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpMpnBO AS BusinessBase

    *==========================================================================
    * EMPRESA do nivel corrente - equivalente a ThisForm.pEmps do legado
    * (herdado do form pai), usado para montar a faixa EmpDNPs (Between
    * pEd1 And pEd2) na carga das pendencias.
    *==========================================================================
    this_cEmpresa = ""

    *==========================================================================
    * CURSORES DO FORM PAI (fornecidos por quem abre este dialogo - este BO
    * NAO os cria, so os consulta/atualiza pelo NOME)
    *==========================================================================

    *-- TmpNens: linha de NECESSIDADE (SigCdNec) corrente do form pai
    this_cCursorNens = ""

    *-- TmpOperacao: codigos (NumNivel) de pendencia ja usados/selecionados
    this_cCursorOperacao = ""

    *-- xMFas/xOpi: cursores de SAIDA do form pai, gravados pelo "OK"
    this_cCursorMFas = ""
    this_cCursorOpi  = ""

    *-- xPesa: cursor de SAIDA do form pai, zerado no inicio do "OK"
    this_cCursorPesa = ""

    *-- xNensi: cursor de SAIDA do form pai (detalhe final por envelope)
    this_cCursorNensiSaida = ""

    *==========================================================================
    * CURSORES GLOBAIS Fortyus (ja abertos em outro ponto do sistema - este
    * BO so le pelo NOME; ver nota no cabecalho sobre o porque de NAO
    * garantir a criacao deles aqui)
    *==========================================================================
    this_cCursorOpd          = ""   && crSigCdOpd (definicao do Dopps/nivel)
    this_cCursorNecessidades = ""   && crSigCdNec  (tabela SigCdNec aberta)

    *==========================================================================
    * CURSOR GLOBAL DE PARAMETROS (SigCdPam, tabela de 1 linha) - o "OK" le
    * CuniPPads/TpPesas direto deste cursor
    *==========================================================================
    this_cCursorParametros = ""

    *==========================================================================
    * CURSORES PROPRIOS (nomes canonicos; a criacao via CREATE CURSOR fica
    * no metodo que monta a tela, em fase posterior)
    *==========================================================================
    this_cCursorPends  = ""   && TmpPends  (grade de selecao)
    this_cCursorPNensi = ""   && xPNensi   (grade "Itens")
    this_cCursorPNensiT = ""  && xPNensiT  (grade "Total")

    *==========================================================================
    * Linha corrente de TmpPends (Flag l, Emps c(3), Dopps c(20), Numps n(10),
    * Datas d Null, Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2),
    * Usuars c(10)) - MESMA ordem do Create Cursor legado (regra #42)
    *==========================================================================
    this_lFlag   = .F.
    this_cEmps   = ""
    this_cDopps  = ""
    this_nNumps  = 0
    this_dDatas  = {}
    this_cObs    = ""
    this_cGrupo  = ""
    this_cConta  = ""
    this_nTPesos = 0
    this_cUsuars = ""

    *==========================================================================
    * DADOS DO NIVEL/OPERACAO CORRENTE (crSigCdOpd) - equivalentes as
    * variaveis PRIVATE do Init/Marca legado (_DoppsNivel/_NumeroNivel/
    * _PuxaOrigem/_PuxaDestino/_NumeroAnt/_BaixaSubN), recalculados por um
    * metodo CarregarNivel (fase posterior) a partir de TmpNens.Dopps
    *==========================================================================
    this_cNivelSubn    = ""   && crSigCdOpd.Nivels do nivel corrente
    this_cNumeroNivel  = ""   && Str(crSigCdOpd.NDopps, 2)
    this_cPuxaOrigem   = ""   && crSigCdOpd.ConOSubs
    this_cPuxaDestino  = ""   && crSigCdOpd.ConDSubs
    this_lNumeroAnt    = .F.  && crSigCdOpd.Numeras = 3
    this_lBaixaSubN    = .F.  && crSigCdOpd.BxAutos = 1

    *==========================================================================
    * CONFIGURACAO DO NIVEL lida na SEGUNDA consulta a SigCdOpd (a do
    * registro que representa o "nivel", achado por Dopps = Nivels). O
    * legado le as duas DIRETO de crSigCdOpd dentro do laco de detalhe,
    * depois do "Seek(_DoppsNivel, 'crSigCdOpd', 'Dopps')" - aqui ficam em
    * property para nao depender do ponteiro de um cursor global ficar
    * parado no lugar certo durante o SCAN.
    *
    * this_nCompAgrus -> crSigCdOpd.CompAgrus (numeric(1,0)): = 1 agrupa os
    *                    componentes zerando o numero de envelope.
    * this_nSepPedras -> crSigCdOpd.SepPedras (numeric(1,0)): = 4 separa
    *                    pedras (mantem o envelope e habilita "Totaliza").
    *==========================================================================
    this_nCompAgrus = 0
    this_nSepPedras = 0

    *==========================================================================
    * PAR (chave, valor) do proximo UPDATE em SigCdNec.ChkSubn - os dois
    * argumentos que Atualizar() (fase posterior) vai gravar. Marcar()/
    * Desmarcar() varrem o cursor de chaves do "nivel" e, para CADA linha,
    * setam este par e chamam THIS.Atualizar() - que tambem chama
    * RegistrarAuditoria(), por isso ObterChavePrimaria() (fase posterior)
    * vai devolver this_cCidChavesAtual.
    *
    * this_cCidChavesAtual -> SigCdNec.CidChaves (char(20), PK Fortyus)
    * this_lChkSubn        -> SigCdNec.ChkSubn   (bit): .T. no Marcar
    *                         (legado ?pTru), .F. no Desmarcar (?pNot)
    *==========================================================================
    this_cCidChavesAtual = ""
    this_lChkSubn        = .F.

    *==========================================================================
    * Sinaliza ao FORM (fase 7) que Marcar() executou o ramo "_NumeroAnt" do
    * legado, que termina com "This.ok.click" - ou seja, a marcacao exige o
    * fechamento IMEDIATO do dialogo (gravando tudo via ConfirmarMovimentacoes).
    * Este BO nao conhece o botao OK; quem fecha eh o Form, apos checar esta
    * flag (ver ChkSelecionarInteractiveChange/CmdSelTudoClick).
    *==========================================================================
    this_lFecharAposMarcar = .F.

    *==========================================================================
    * Init - Define this_cTabela/this_cCampoChave (ver nota no cabecalho
    * sobre o alvo de escrita SigCdNec/CidChaves), os nomes canonicos dos
    * cursores desta tela, zera a linha corrente de TmpPends/o nivel
    * corrente, e garante o cursor global crSigCdPam (CuniPPads/TpPesas),
    * que o "OK" vai precisar.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_oErroPam, loc_nResult
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tabela/campo chave do UPDATE de Atualizar() e da auditoria
            *-- via ObterChavePrimaria - ver nota no cabecalho: SigCdNec.
            *-- ChkSubn eh o unico alvo de escrita no SQL Server.
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "CidChaves"

            *-- Empresa do nivel corrente
            THIS.this_cEmpresa = ""

            *-- Nomes canonicos dos cursores do form pai
            THIS.this_cCursorNens         = "TmpNens"
            THIS.this_cCursorOperacao     = "TmpOperacao"
            THIS.this_cCursorMFas         = "xMFas"
            THIS.this_cCursorOpi          = "xOpi"
            THIS.this_cCursorPesa         = "xPesa"
            THIS.this_cCursorNensiSaida   = "xNensi"

            *-- Nomes canonicos dos cursores globais Fortyus
            THIS.this_cCursorOpd          = "crSigCdOpd"
            THIS.this_cCursorNecessidades = "crSigCdNec"

            *-- Cursor global de parametros
            THIS.this_cCursorParametros = "crSigCdPam"

            *-- Cursores proprios (grades desta tela)
            THIS.this_cCursorPends   = "TmpPends"
            THIS.this_cCursorPNensi  = "xPNensi"
            THIS.this_cCursorPNensiT = "xPNensiT"

            *-- Linha corrente de TmpPends comeca vazia
            THIS.this_lFlag   = .F.
            THIS.this_cEmps   = ""
            THIS.this_cDopps  = ""
            THIS.this_nNumps  = 0
            THIS.this_dDatas  = {}
            THIS.this_cObs    = ""
            THIS.this_cGrupo  = ""
            THIS.this_cConta  = ""
            THIS.this_nTPesos = 0
            THIS.this_cUsuars = ""

            *-- Nivel/operacao corrente comeca vazio
            THIS.this_cNivelSubn   = ""
            THIS.this_cNumeroNivel = ""
            THIS.this_cPuxaOrigem  = ""
            THIS.this_cPuxaDestino = ""
            THIS.this_lNumeroAnt   = .F.
            THIS.this_lBaixaSubN   = .F.
            THIS.this_nCompAgrus   = 0
            THIS.this_nSepPedras   = 0

            *-- Par chave/valor do proximo UPDATE comeca vazio
            THIS.this_cCidChavesAtual = ""
            THIS.this_lChkSubn        = .F.

            THIS.this_lFecharAposMarcar = .F.

            *-- Popular crSigCdPam com CuniPPads/TpPesas/Ouros. Padrao
            *-- canonico de ClienteBO.prg/SigOpMpdBO.prg (regra do projeto:
            *-- cursor global Fortyus de 1 linha tem de ser garantido no
            *-- Init do BO, nunca pressuposto). Sem isto, o "OK" estouraria
            *-- "Alias CRSIGCDPAM is not found" ao ler crSigCdPam.TpPesas.
            TRY
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT CuniPPads, TpPesas, Ouros FROM SigCdPam", "cursor_4c_Pam_Temp")
                    IF loc_nResult > 0
                        SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                        IF USED("cursor_4c_Pam_Temp")
                            USE IN cursor_4c_Pam_Temp
                        ENDIF
                        IF RECCOUNT("crSigCdPam") > 0
                            SELECT crSigCdPam
                            GO TOP
                        ENDIF
                    ELSE
                        *-- Fallback: cursor vazio para nao quebrar as
                        *-- checagens downstream (modo teste/SQL indisponivel)
                        CREATE CURSOR crSigCdPam (CuniPPads C(3), TpPesas N(1,0), Ouros C(14))
                        APPEND BLANK
                    ENDIF
                ELSE
                    *-- Modo teste (gnConnHandle nao inicializado)
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), TpPesas N(1,0), Ouros C(14))
                    APPEND BLANK
                ENDIF
            CATCH TO loc_oErroPam
                IF !USED("crSigCdPam")
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), TpPesas N(1,0), Ouros C(14))
                    APPEND BLANK
                ENDIF
            ENDTRY

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - sobrescreve BusinessBase (PROTECTED, so chamado de
    * dentro da classe - regra #51). Nao ha registro "corrente" de SigCdNec
    * como nos BOs CRUD de cadastro: cada UPDATE de Marcar()/Desmarcar() (fase
    * posterior) seta this_cCidChavesAtual IMEDIATAMENTE antes de chamar
    * THIS.Atualizar(), que eh quem chama RegistrarAuditoria(). Mesmo padrao
    * de SigOpMpdBO.prg (mesma familia de tela).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC
    * aqui tambem - regra #51: metodo que o Form chama de fora nunca pode ser
    * PROTECTED em nenhum nivel da heranca).
    *
    * Le a linha CORRENTE de TmpPends (grade de selecao, Create Cursor do
    * Init legado: Flag l, Emps c(3), Dopps c(20), Numps n(10), Datas d Null,
    * Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2), Usuars c(10))
    * para as propriedades this_lFlag/this_cEmps/this_cDopps/this_nNumps/
    * this_dDatas/this_cObs/this_cGrupo/this_cConta/this_nTPesos/this_cUsuars -
    * MESMA ordem do Create Cursor (regra #42). Equivale ao que o legado faz
    * lendo TmpPends.<campo> direto dentro de marca/desmarca (o dialogo opera
    * SEMPRE sobre a linha em que a grade esta posicionada).
    *
    * `Datas` pode chegar como DATE ou DATETIME (coluna Null do cursor local)
    * - a leitura passa por ConverterParaData(), NUNCA por TTOD() direto
    * (regra #16: TTOD com DATE dispara o erro 11 em runtime).
    *
    * Sem par_cAliasCursor assume this_cCursorPends, que eh o caso de uso
    * normal; o parametro existe porque a assinatura da base o tem e porque o
    * Form pode querer ler outro cursor de MESMA estrutura.
    *
    * Guarda de RECCOUNT/EOF/BOF obrigatoria: cursor vazio ou posicionado no
    * fim leria campo inexistente. Devolve .F. nesse caso, sem mexer nas
    * propriedades. Preserva a area de trabalho corrente - este dialogo roda
    * na data session do form PAI, que tem varios cursores abertos.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            ALLTRIM(par_cAliasCursor), THIS.this_cCursorPends)

        IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            loc_cAliasAnterior = ALIAS()

            SELECT (loc_cAlias)

            IF RECCOUNT() > 0 AND !EOF() AND !BOF()
                THIS.this_lFlag   = ConverterParaLogico(Flag)
                THIS.this_cEmps   = TratarNulo(Emps, "")
                THIS.this_cDopps  = TratarNulo(Dopps, "")
                THIS.this_nNumps  = TratarNulo(Numps, 0)
                THIS.this_dDatas  = ConverterParaData(Datas)
                THIS.this_cObs    = TratarNulo(Obss, "")
                THIS.this_cGrupo  = TratarNulo(Grupo, "")
                THIS.this_cConta  = TratarNulo(Conta, "")
                THIS.this_nTPesos = TratarNulo(TPesos, 0)
                THIS.this_cUsuars = TratarNulo(Usuars, "")

                loc_lSucesso = .T.
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Cursor da grade de sele" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC aqui -
    * regra #51). UNICO ponto deste BO que grava no SQL Server.
    *
    * Legado (identico em marca e em desmarca - Pattern #196/#213 do
    * CorretorAutomatico ja documenta o bug de injecao que esse texto sofreu
    * em outros forms; aqui a transcricao eh literal, sem ".Value" nenhum):
    *   lcQuery = [Update SigCdNec ] + ; [Set ChkSubn = ?pNot ] + ; [Where
    *             cIdChaves = '] + LocalNens.cIdChaves + [']
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * O legado grava em LOTE (Scan sobre as linhas de SigCdNec que
    * compartilham o EmpDNps do "nivel"), mas CADA volta do Scan eh um UPDATE
    * de UMA linha pela PK - que eh exatamente o contrato de Atualizar(). Por
    * isso o lote fica em Marcar()/Desmarcar() (fase posterior, que varrem o
    * cursor de chaves) e o UPDATE de uma linha fica aqui, num ponto unico,
    * com a auditoria.
    *
    * ChkSubn eh `bit NOT NULL` no schema, por isso o literal 1/0 (nao .T./
    * .F., que o ODBC nao aceita em SQL concatenado).
    *
    * NAO existe Inserir() correspondente: medido contra docs/schema.sql, dos
    * alvos de escrita do dump legado so SigCdNec eh TABELA - TmpOperacao,
    * xMFas, xOpi, xPesa e xNensi nao constam das 682 tabelas, sao cursores
    * LOCAIS do form pai (este dialogo roda na data session dele). Nenhum
    * `Insert Into` do legado tem tabela por destino, logo escrever um INSERT
    * aqui significaria inventar a lista de colunas, o que a regra #22
    * proibe (a lista vem do schema, nunca de adivinhacao). O comportamento
    * padrao herdado de BusinessBase (recusar a operacao e reportar pelo
    * ExibirFalha do Salvar) ja eh o correto. Mesma decisao de SigOpMpdBO.prg.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        *-- TRY aqui (e nao so no wrapper de Marcar/Desmarcar) porque este
        *-- metodo eh PUBLIC: handle de conexao invalido faz o SQLEXEC
        *-- disparar EXCECAO em vez de devolver -1, e sem TRY um chamador de
        *-- fora veria o Program Error cru do VFP. Nao ha RETURN dentro do
        *-- TRY (regra #1): o corpo inteiro eh IF/ELSE sobre loc_lSucesso.
        TRY
            IF EMPTY(THIS.this_cCidChavesAtual)
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado: " + ;
                    "nenhum registro de SigCdNec para atualizar."
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- ChkSubn eh bit: literal 1/0. ConverterParaLogico garante
                *-- o LOGICO que o IIF exige - se um chamador futuro atribuir
                *-- 1/0 (numerico) a this_lChkSubn, IIF(numerico,...)
                *-- estouraria o erro 11 do VFP9 em runtime.
                loc_cSQL = "UPDATE SigCdNec SET ChkSubn = " + ;
                    IIF(ConverterParaLogico(THIS.this_lChkSubn), "1", "0") + ;
                    " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChavesAtual)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (Update - SigCdNec)" + CHR(13) + ;
                        CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar SigCdNec:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarCursorQuery - equivalente do "ThisForm.poDataMgr.CursorQuery(
    * tabela, cursor, campo, valor, campos)" do legado: um SELECT por
    * igualdade num campo, jogado num cursor local.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * O literal do WHERE sai do helper que corresponde ao TIPO do valor
    * (regra #5 - os helpers JA devolvem com as aspas, nunca acrescentar).
    * O cursor anterior eh fechado com USE IN antes do SQLEXEC: so USED()
    * nao basta como guarda, e TABLEREVERT em cursor sem buffering DISPARA
    * o erro 1586 (regra #52) - USE IN fecha o alias mesmo com buffer sujo.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarCursorQuery(par_cTabela, par_cCursor, par_cCampo, par_uValor, par_cCampos)
        LOCAL loc_cSQL, loc_cCamposSQL, loc_cFiltro, loc_nResultado

        loc_cCamposSQL = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        DO CASE
        CASE VARTYPE(par_uValor) = "N"
            loc_cFiltro = FormatarNumeroSQL(par_uValor, 0)
        CASE VARTYPE(par_uValor) = "T" OR VARTYPE(par_uValor) = "D"
            loc_cFiltro = FormatarDataSQL(par_uValor)
        OTHERWISE
            loc_cFiltro = EscaparSQL(par_uValor)
        ENDCASE

        loc_cSQL = "SELECT " + loc_cCamposSQL + " FROM " + par_cTabela + ;
            " WHERE " + par_cCampo + " = " + loc_cFiltro

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor)

        IF loc_nResultado > 0 AND USED(par_cCursor)
            SELECT (par_cCursor)
            GO TOP
        ENDIF

        RETURN loc_nResultado > 0
    ENDPROC

    *==========================================================================
    * CriarCursoresGrades - cria os TRES cursores das grades desta tela, com
    * a MESMA estrutura e os MESMOS indices do Init legado.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * TmpPends (grade de selecao) eh transcricao literal do
    *   "Create Cursor TmpPends(Flag l, Emps c(3), Dopps c(20), Numps n(10),
    *    Datas d Null, Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2),
    *    Usuars c(10))" - mesma ORDEM de campos, que eh a ordem documentada
    *   no cabecalho deste BO.
    *
    * xPNensi/xPNensiT (grades de detalhe) vem no legado de
    *   "Select *, <10 colunas extra> From CrSigCdNei Where 1=0 Into Cursor ..."
    * ou seja: TODAS as colunas de SigCdNei MAIS as 10 calculadas. Como
    * crSigCdNei nao eh um cursor desta arquitetura, a estrutura eh declarada
    * explicitamente - as 43 colunas saem de docs/schema.sql (lido com
    * Get-Content -Raw, regra #14) e as 10 extras dos "as <nome>" do SELECT
    * legado (000000.000 -> N(10,3), Space(3) -> C(3), .f. -> L, 0 -> N(1)).
    * NENHUMA coluna foi omitida: o "OK" (fase posterior) copia xPNensi para
    * o xNensi do form pai e pode ler qualquer uma delas.
    *
    * SET NULL ON antes do CREATE CURSOR porque Datas/Obss/DataTrans sao
    * NULL-aveis (regra do projeto: SQL Server devolve NULL e, sem isso, o
    * INSERT falha).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresGrades()
        LOCAL loc_cAliasPends, loc_cAliasPNensi, loc_cAliasPNensiT

        loc_cAliasPends   = THIS.this_cCursorPends
        loc_cAliasPNensi  = THIS.this_cCursorPNensi
        loc_cAliasPNensiT = THIS.this_cCursorPNensiT

        SET NULL ON

        *-- TmpPends: grade de selecao -------------------------------------
        IF USED(loc_cAliasPends)
            USE IN (loc_cAliasPends)
        ENDIF
        CREATE CURSOR (loc_cAliasPends) ( ;
            Flag L, Emps C(3), Dopps C(20), Numps N(10), Datas D NULL, Obss M NULL, ;
            Grupo C(10), Conta C(10), TPesos N(12,2), Usuars C(10))
        INDEX ON Numps TAG Numps
        INDEX ON Emps + Dopps + STR(Numps, 10) TAG EmpDopNum

        *-- xPNensi: grade "Itens" -----------------------------------------
        IF USED(loc_cAliasPNensi)
            USE IN (loc_cAliasPNensi)
        ENDIF
        CREATE CURSOR (loc_cAliasPNensi) ( ;
            Aqtds N(9,3), Cats C(6), CDescs C(40), CGrus C(3), CMats C(14), ;
            Coefs N(7,4), ContaFs C(10), CUnis C(3), DataTrans T NULL, Dopps C(20), ;
            Emps C(3), Fators N(7,4), FlagIncs L, GrupoFins C(10), GrupoFs C(10), ;
            Moedas C(3), Moeds C(3), NEnvs N(10), Nops N(10), Numps N(10), ;
            Obss C(40), Pesos N(9,3), Qtds N(9,3), Servicos L, TpOps C(15), ;
            Locals C(10), NTrans N(6), CidChaves C(20), NLotes N(10), ;
            PesoFixs N(1), CoefInfs N(7,4), CRetrabs C(6), EmpDNPs C(33), ;
            EmpDopNums C(29), ChkSubn L, CodCors C(4), CodNConfs C(10), ;
            CodTams C(4), Peso2s N(9,3), CustoFs N(11,3), MoeCusFs C(3), ;
            Estorno N(1), PVens N(11,3), ;
            Ps2FaseAnt N(10,3), cUnips C(3), OsRets L, Retrabs L, MatPrincs C(10), ;
            PsFaseAnt N(10,3), Descs C(60), Rateio N(1), Visivel L, QtFaseAnt N(10,3))
        INDEX ON Cats TAG Cats
        INDEX ON STR(NEnvs, 10) + CMats + TpOps FOR Visivel TAG NEnvTpops
        INDEX ON Emps + Dopps + STR(Numps, 10) FOR Visivel TAG EmpDopNum

        *-- xPNensiT: grade "Total" (mesma estrutura de xPNensi) -----------
        IF USED(loc_cAliasPNensiT)
            USE IN (loc_cAliasPNensiT)
        ENDIF
        CREATE CURSOR (loc_cAliasPNensiT) ( ;
            Aqtds N(9,3), Cats C(6), CDescs C(40), CGrus C(3), CMats C(14), ;
            Coefs N(7,4), ContaFs C(10), CUnis C(3), DataTrans T NULL, Dopps C(20), ;
            Emps C(3), Fators N(7,4), FlagIncs L, GrupoFins C(10), GrupoFs C(10), ;
            Moedas C(3), Moeds C(3), NEnvs N(10), Nops N(10), Numps N(10), ;
            Obss C(40), Pesos N(9,3), Qtds N(9,3), Servicos L, TpOps C(15), ;
            Locals C(10), NTrans N(6), CidChaves C(20), NLotes N(10), ;
            PesoFixs N(1), CoefInfs N(7,4), CRetrabs C(6), EmpDNPs C(33), ;
            EmpDopNums C(29), ChkSubn L, CodCors C(4), CodNConfs C(10), ;
            CodTams C(4), Peso2s N(9,3), CustoFs N(11,3), MoeCusFs C(3), ;
            Estorno N(1), PVens N(11,3), ;
            Ps2FaseAnt N(10,3), cUnips C(3), OsRets L, Retrabs L, MatPrincs C(10), ;
            PsFaseAnt N(10,3), Descs C(60), Rateio N(1), Visivel L, QtFaseAnt N(10,3))
        INDEX ON Emps + Dopps + STR(Numps, 10) + CMats + STR(Nops, 10) FOR Visivel TAG EmpDopNum

        SET NULL OFF
    ENDPROC

    *==========================================================================
    * CarregarNivel - resolve o "nivel" (crSigCdOpd) da necessidade corrente
    * do form pai. Transcricao das DUAS buscas que o Init legado faz em
    * sequencia:
    *
    *   =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')   -> Nivels/ConOSubs/ConDSubs
    *   =Seek(_DoppsNivel,   'crSigCdOpd', 'Dopps')   -> NDopps (e, no laco de
    *                                                     detalhe, CompAgrus/
    *                                                     SepPedras)
    *
    * A SEGUNDA busca eh a que vale para CompAgrus/SepPedras: no legado o
    * laco de detalhe le "crSigCdOpd.CompAgrus"/"CrSigCdOpd.SepPedras" com o
    * ponteiro parado no registro do NIVEL, nao no da operacao.
    *
    * Numeras/BxAutos vem junto porque o "OK" (fase posterior) precisa dos
    * dois (this_lNumeroAnt/this_lBaixaSubN), exatamente como o legado, que
    * os le do mesmo registro.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE CarregarNivel(par_cDoppsNecessidade)
        LOCAL loc_lSucesso, loc_cNivel

        loc_lSucesso = .F.

        *-- 1a busca: a operacao corrente aponta para o Dopps do nivel
        IF THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpd", "Dopps", ;
                par_cDoppsNecessidade, "Nivels, ConOSubs, ConDSubs")
            THIS.this_cNivelSubn   = cursor_4c_LocalOpd.Nivels
            THIS.this_cPuxaOrigem  = TRANSFORM(cursor_4c_LocalOpd.ConOSubs)
            THIS.this_cPuxaDestino = TRANSFORM(cursor_4c_LocalOpd.ConDSubs)

            loc_cNivel = THIS.this_cNivelSubn

            *-- 2a busca: o registro do NIVEL (Dopps = Nivels) - eh dele que
            *-- saem NDopps/CompAgrus/SepPedras/Numeras/BxAutos
            IF THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpd", "Dopps", ;
                    loc_cNivel, "NDopps, CompAgrus, SepPedras, Numeras, BxAutos")
                *-- legado: _NumeroNivel = Str(crSigCdOpd.NDopps, 2)
                THIS.this_cNumeroNivel = STR(cursor_4c_LocalOpd.NDopps, 2)
                THIS.this_nCompAgrus   = NVL(cursor_4c_LocalOpd.CompAgrus, 0)
                THIS.this_nSepPedras   = NVL(cursor_4c_LocalOpd.SepPedras, 0)
                *-- legado: _NumeroAnt = (crSigCdOpd.Numeras = 3)
                THIS.this_lNumeroAnt   = (NVL(cursor_4c_LocalOpd.Numeras, 0) = 3)
                *-- legado: _BaixaSubN = (crSigCdOpd.BxAutos = 1)
                IF VARTYPE(cursor_4c_LocalOpd.BxAutos) = "L"
                    THIS.this_lBaixaSubN = cursor_4c_LocalOpd.BxAutos
                ELSE
                    THIS.this_lBaixaSubN = (NVL(cursor_4c_LocalOpd.BxAutos, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        IF USED("cursor_4c_LocalOpd")
            USE IN cursor_4c_LocalOpd
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPendencias - PUBLICO (o Form chama de fora: regra #51).
    * Wrapper com o TRY/CATCH; o corpo fica em CarregarPendenciasExec porque
    * as guardas de cursor/conexao abortam no meio e em VFP9 eh PROIBIDO dar
    * RETURN de dentro de um TRY/CATCH (regra #1). Mesmo par wrapper/Exec de
    * SigOpMpdBO.prg (mesma familia de tela).
    *==========================================================================
    PROCEDURE CarregarPendencias()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CarregarPendenciasExec()
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = "Erro ao carregar movimenta" + CHR(231) + CHR(245) + ;
                "es pendentes:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPendenciasExec - corpo de CarregarPendencias(). Transcricao do
    * trecho do Init legado que vai do "Create Cursor TmpPends" ate o
    * "Select TmpPends / Go Bottom" (o bind das grades eh do FORM, nao daqui).
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * Sequencia do legado, na mesma ordem:
    *   1. Create Cursor TmpPends/xPNensi/xPNensiT (-> CriarCursoresGrades)
    *   2. Select TmpOperacao / Delete All For Empty(Codigos)
    *   3. Seek do nivel em crSigCdOpd (-> CarregarNivel)
    *   4. pEd1/pEd2 + Select ... From SigCdNec -> LocalNens
    *   5. Scan LocalNens: Insert Into TmpPends + carga do detalhe
    *   6. Select xPNensi / Scan -> consolida em xPNensiT
    *==========================================================================
    PROTECTED PROCEDURE CarregarPendenciasExec()
        LOCAL loc_cAliasNens, loc_cAliasOperacao, loc_cAliasPends
        LOCAL loc_cNensDopps, loc_cNensGrupoOs, loc_cNensContaOs
        LOCAL loc_cEd1, loc_cEd2, loc_cSQL, loc_nResultado, loc_lFlagMarcada

        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasPends    = THIS.this_cCursorPends

        *-- O dialogo roda na data session do form PAI: TmpNens (necessidade
        *-- corrente) e TmpOperacao (codigos ja selecionados) tem de estar
        *-- abertos por ele. Sem os dois nao ha o que carregar.
        IF !USED(loc_cAliasNens) OR !USED(loc_cAliasOperacao)
            THIS.this_cMensagemErro = "Cursores do formul" + CHR(225) + "rio chamador " + ;
                "(TmpNens/TmpOperacao) n" + CHR(227) + "o est" + CHR(227) + "o abertos."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                "indispon" + CHR(237) + "vel."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        *-- Necessidade corrente do form pai (o legado le TmpNens.Dopps/
        *-- GrupoOs/ContaOs direto, dentro do Init)
        SELECT (loc_cAliasNens)
        loc_cNensDopps   = Dopps
        loc_cNensGrupoOs = GrupoOs
        loc_cNensContaOs = ContaOs

        *-- 1. cursores das tres grades
        THIS.CriarCursoresGrades()

        *-- 2. legado: Select TmpOperacao / Delete All For Empty(Codigos)
        SELECT (loc_cAliasOperacao)
        DELETE ALL FOR EMPTY(Codigos)

        *-- 3. nivel/configuracao (crSigCdOpd)
        IF !THIS.CarregarNivel(loc_cNensDopps)
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpd)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- 4. faixa EmpDNPs. Chave POSICIONAL de char(33) = Emps char(3) +
        *-- Dopps char(20) + Str(Numps,10): PADR explicito em cada parte,
        *-- NUNCA ALLTRIM (regra #42 - ALLTRIM nas partes encurta a chave e o
        *-- BETWEEN devolve ZERO linha, sem erro nenhum). A soma 3+20+10 = 33
        *-- confere com EmpDNPs char(33) do schema. Legado:
        *--   pEd1 = ThisForm.pEmps + _DoppsNivel + '         0'
        *--   pEd2 = ThisForm.pEmps + _DoppsNivel + '9999999999'
        loc_cEd1 = PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cNivelSubn, 20) + STR(0, 10)
        loc_cEd2 = PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cNivelSubn, 20) + STR(9999999999, 10)

        WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + ;
            "es Pendentes..." NOWAIT

        *-- SQL quebrado em varias linhas (regra do projeto: nunca uma linha
        *-- longa unica). ChkSubn eh `bit`: o legado compara com ?llSubn, que
        *-- vale .f. - aqui o literal 0, que eh o que o ODBC aceita em SQL
        *-- concatenado.
        loc_cSQL = "SELECT Emps, Dopps, Numps, Datas, GrupoOs, ContaOs," + ;
            " ChkSubn, TotPesos, Usuars, Obss" + ;
            " FROM SigCdNec" + ;
            " WHERE EmpDNPs BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2) + ;
            " AND GrupoDs = " + EscaparSQL(loc_cNensGrupoOs) + ;
            " AND ContaDs = " + EscaparSQL(loc_cNensContaOs) + ;
            " AND ChkSubn = 0"

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

        IF loc_nResultado < 1
            WAIT CLEAR
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- 5. uma linha de TmpPends por necessidade ainda em aberto, e para
        *-- cada uma o detalhe (SigCdNei) em xPNensi
        SELECT cursor_4c_LocalNens
        SCAN
            *-- legado: _Flag = Seek(Val(_NumeroNivel + Transform(Numps,
            *-- '@L 9999999999')), 'TmpOperacao', 'Codigos') - a pendencia
            *-- ja escolhida pelo usuario nasce marcada
            loc_lFlagMarcada = SEEK(VAL(THIS.this_cNumeroNivel + ;
                TRANSFORM(cursor_4c_LocalNens.Numps, "@L 9999999999")), ;
                loc_cAliasOperacao, "Codigos")

            *-- Datas eh `datetime NULL` no schema e TmpPends.Datas eh DATE:
            *-- ConverterParaData normaliza DATE/DATETIME/NULL (regra #16 -
            *-- TTOD direto estoura o erro 11 se o valor nao for DATETIME)
            INSERT INTO (loc_cAliasPends) ;
                (Flag, Emps, Dopps, Numps, Datas, Grupo, Conta, TPesos, Usuars, Obss) ;
                VALUES (loc_lFlagMarcada, cursor_4c_LocalNens.Emps, ;
                    cursor_4c_LocalNens.Dopps, cursor_4c_LocalNens.Numps, ;
                    ConverterParaData(cursor_4c_LocalNens.Datas), ;
                    cursor_4c_LocalNens.GrupoOs, cursor_4c_LocalNens.ContaOs, ;
                    cursor_4c_LocalNens.TotPesos, cursor_4c_LocalNens.Usuars, ;
                    NVL(cursor_4c_LocalNens.Obss, ""))

            THIS.CarregarItensDaPendencia(cursor_4c_LocalNens.Emps, ;
                cursor_4c_LocalNens.Dopps, cursor_4c_LocalNens.Numps)

            *-- restaura a area de trabalho: CarregarItensDaPendencia muda o
            *-- alias corrente, e o ENDSCAN precisa estar em LocalNens
            SELECT cursor_4c_LocalNens
        ENDSCAN

        *-- 6. consolidacao xPNensi -> xPNensiT
        THIS.ConsolidarTotaisPendencias()

        WAIT CLEAR

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        IF USED("cursor_4c_LocalNensi")
            USE IN cursor_4c_LocalNensi
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF

        *-- legado, no fim do Init: Select TmpPends / Go Bottom
        SELECT (loc_cAliasPends)
        GO BOTTOM

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarItensDaPendencia - detalhe (SigCdNei) de UMA pendencia, somado
    * em xPNensi. Transcricao LITERAL do laco aninhado do Init legado (o
    * "Select LocalNensi / Scan / Scan While (NEnvs = _NEnv)"), incluindo as
    * expressoes de rateio, os guards de FlagIncs/CompAgrus/SepPedras e o
    * "Skip -1" - regra #17: formula e condicao que a cercam sao REGRA DE
    * NEGOCIO e se TRANSCREVEM, nunca se reescrevem.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * Tres caminhos, na ordem do legado:
    *   a) material comum (nao servico, com CMats, sem Cats): insere a linha
    *      "crua" e, quando o rateio nao eh 5, AGRUPA por envelope+material+
    *      tipo somando QtFaseAnt/PsFaseAnt/Ps2FaseAnt/Qtds/Pesos;
    *   b) servico ou item de categoria: agrupa por Cats (ou insere sempre,
    *      quando FlagIncs) e soma Qtds;
    *   c) rateio 5 (Nops = 0): so a linha crua, sem agrupar.
    *
    * As variaveis PRIVATE _TotalNop/_RecNensi do legado NAO foram portadas:
    * sao atribuidas e nunca lidas em nenhum dos dois blocos onde aparecem
    * (linhas 1677-1678 e 2467-2468 do dump) - o reposicionamento quem faz eh
    * o "Skip -1".
    *==========================================================================
    PROTECTED PROCEDURE CarregarItensDaPendencia(par_cEmps, par_cDopps, par_nNumps)
        LOCAL loc_cAliasNensi, loc_cAliasPro, loc_cAliasPNensi, loc_cChvNens
        LOCAL loc_nNEnv, loc_nRateio, loc_lVisivel, loc_lServico
        LOCAL loc_cBMat, loc_cDMat, loc_cCMat, loc_cGMat, loc_cCatMat, loc_cTMat
        LOCAL loc_nPs2Anterior

        loc_cAliasNensi  = "cursor_4c_LocalNensi"
        loc_cAliasPro    = "cursor_4c_LocalPro"
        loc_cAliasPNensi = THIS.this_cCursorPNensi

        *-- Chave POSICIONAL char(33) (regra #42): PADR explicito, NUNCA
        *-- ALLTRIM. Legado: _ChvNens = Emps + Dopps + Str(Numps, 10)
        loc_cChvNens = PADR(par_cEmps, 3) + PADR(par_cDopps, 20) + STR(par_nNumps, 10)

        IF !THIS.ExecutarCursorQuery("SigCdNei", loc_cAliasNensi, "EmpDNPs", loc_cChvNens, ;
                "Emps, Dopps, Numps, Nenvs, CMats, Nops, Servicos, Cats, CDescs, Qtds, " + ;
                "Pesos, TpOps, FlagIncs, CUnis, Obss, Fators, Moedas, GrupoFins, Peso2s")
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasNensi)
        SCAN
            loc_nNEnv = cursor_4c_LocalNensi.NEnvs

            SCAN WHILE (NEnvs = loc_nNEnv)
                *-- Produto do componente (descricao/unidade/grupo/Varias)
                IF !THIS.ExecutarCursorQuery("SigCdPro", loc_cAliasPro, "CPros", ;
                        cursor_4c_LocalNensi.CMats, "DPros, CUnis, CGrus, Varias")
                    SELECT (loc_cAliasNensi)
                    LOOP
                ENDIF

                IF cursor_4c_LocalNensi.Nops = 0
                    loc_nRateio  = 5
                    loc_lVisivel = .T.
                ELSE
                    *-- Varias eh numeric(1,0): comparacao numerica
                    loc_nRateio  = IIF(NVL(cursor_4c_LocalPro.Varias, 0) = 1, 2, 3)
                    loc_lVisivel = .F.
                ENDIF

                *-- Servicos eh `bit`: ConverterParaLogico garante o LOGICO
                *-- (regra #13 - bit chega ora Logico ora Numerico conforme
                *-- o driver, e comparar Logico com 1 estoura type mismatch)
                loc_lServico = ConverterParaLogico(cursor_4c_LocalNensi.Servicos)

                IF !loc_lServico AND !EMPTY(cursor_4c_LocalNensi.CMats) ;
                        AND EMPTY(cursor_4c_LocalNensi.Cats)

                    INSERT INTO (loc_cAliasPNensi) ;
                        (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, ;
                         PsFaseAnt, Pesos, Visivel, Rateio, TpOps, Cats, FlagIncs, CUnis, ;
                         CGrus, Obss, aQtds, Peso2s, Ps2FaseAnt) ;
                        VALUES (cursor_4c_LocalNensi.Emps, cursor_4c_LocalNensi.Dopps, ;
                            cursor_4c_LocalNensi.Numps, cursor_4c_LocalNensi.Nops, ;
                            cursor_4c_LocalNensi.NEnvs, cursor_4c_LocalNensi.CMats, ;
                            cursor_4c_LocalNensi.CDescs, cursor_4c_LocalNensi.Qtds, ;
                            cursor_4c_LocalNensi.Qtds, cursor_4c_LocalNensi.Pesos, ;
                            cursor_4c_LocalNensi.Pesos, loc_lVisivel, loc_nRateio, ;
                            cursor_4c_LocalNensi.TpOps, cursor_4c_LocalNensi.Cats, ;
                            ConverterParaLogico(cursor_4c_LocalNensi.FlagIncs), ;
                            cursor_4c_LocalNensi.CUnis, cursor_4c_LocalPro.CGrus, ;
                            cursor_4c_LocalNensi.Obss, cursor_4c_LocalNensi.Qtds, ;
                            cursor_4c_LocalNensi.Peso2s, cursor_4c_LocalNensi.Peso2s)

                    *-- Legado: componente "incluso" (FlagIncs) ou operacao que
                    *-- SEPARA pedras (SepPedras = 4) entra identificado na
                    *-- linha agrupada; senao entra em branco (so soma peso)
                    IF ConverterParaLogico(cursor_4c_LocalNensi.FlagIncs) ;
                            OR THIS.this_nSepPedras = 4
                        loc_cBMat   = cursor_4c_LocalNensi.CMats
                        loc_cDMat   = cursor_4c_LocalPro.DPros
                        loc_cCMat   = cursor_4c_LocalPro.CUnis
                        loc_cGMat   = cursor_4c_LocalPro.CGrus
                        loc_cCatMat = cursor_4c_LocalNensi.Cats
                    ELSE
                        loc_cBMat   = SPACE(14)
                        loc_cDMat   = ""
                        loc_cCMat   = ""
                        loc_cGMat   = ""
                        loc_cCatMat = SPACE(3)
                    ENDIF
                    loc_cTMat = cursor_4c_LocalNensi.TpOps

                    *-- Legado: If (crSigCdOpd.CompAgrus = 1) And
                    *-- CrSigCdOpd.SepPedras <> 4 -> _Nenv = 0. Zerar o
                    *-- envelope AQUI agrupa todos os componentes numa linha
                    *-- so, E encerra o "Scan While (NEnvs = _NEnv)" desta
                    *-- volta (o legado reatribui a PROPRIA variavel de
                    *-- controle do laco) - comportamento transcrito.
                    IF THIS.this_nCompAgrus = 1 AND THIS.this_nSepPedras != 4
                        loc_nNEnv = 0
                    ENDIF

                    IF loc_nRateio != 5
                        *-- Chave CHEIA do indice NEnvTpops (regra do
                        *-- projeto sobre SEEK parcial com SET EXACT ON):
                        *-- Str(NEnvs,10) + CMats char(14) + TpOps char(15)
                        IF !SEEK(STR(loc_nNEnv, 10) + PADR(loc_cBMat, 14) + PADR(loc_cTMat, 15), ;
                                loc_cAliasPNensi, "NEnvTpops")
                            INSERT INTO (loc_cAliasPNensi) ;
                                (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, ;
                                 CGrus, Visivel, Rateio, Cats, TpOps, Servicos) ;
                                VALUES (cursor_4c_LocalNensi.Emps, cursor_4c_LocalNensi.Dopps, ;
                                    cursor_4c_LocalNensi.Numps, loc_nNEnv, loc_nNEnv, ;
                                    loc_cBMat, loc_cDMat, loc_cCMat, loc_cGMat, .T., 1, ;
                                    loc_cCatMat, loc_cTMat, loc_lServico)
                        ELSE
                            IF EVALUATE(loc_cAliasPNensi + ".Rateio") != 1
                                REPLACE Rateio WITH 1 IN (loc_cAliasPNensi)
                            ENDIF
                        ENDIF

                        *-- Ps2FaseAnt: o legado le "xNensi.Ps2FaseAnt" (o
                        *-- cursor de SAIDA do form PAI) nas OUTRAS quatro
                        *-- linhas deste mesmo Replace, que leem xPNensi -
                        *-- comparando com o bloco gemeo do "OK" (linhas
                        *-- 2535-2539 do dump), que opera sobre xNensi e NAO
                        *-- tem a linha de Ps2FaseAnt, isto tem toda a cara
                        *-- de alias nao renomeado na copia. NAO foi
                        *-- "corrigido" aqui: trocar por xPNensi mudaria
                        *-- valor gravado em silencio, que eh exatamente o
                        *-- que a regra #17 proibe. Transcrito como esta, com
                        *-- guarda de alias ausente (fora do fluxo real do
                        *-- form pai xNensi pode nao existir) - DIVERGENCIA
                        *-- HERDADA, documentada para decisao humana.
                        loc_nPs2Anterior = 0
                        IF USED(THIS.this_cCursorNensiSaida) ;
                                AND TYPE(THIS.this_cCursorNensiSaida + ".Ps2FaseAnt") = "N"
                            loc_nPs2Anterior = EVALUATE(THIS.this_cCursorNensiSaida + ".Ps2FaseAnt")
                        ENDIF

                        SELECT (loc_cAliasPNensi)
                        REPLACE QtFaseAnt  WITH QtFaseAnt + cursor_4c_LocalNensi.Qtds, ;
                                PsFaseAnt  WITH PsFaseAnt + cursor_4c_LocalNensi.Pesos, ;
                                Ps2FaseAnt WITH loc_nPs2Anterior + cursor_4c_LocalNensi.Peso2s, ;
                                Qtds       WITH Qtds + cursor_4c_LocalNensi.Qtds, ;
                                Pesos      WITH Pesos + cursor_4c_LocalNensi.Pesos ;
                            IN (loc_cAliasPNensi)
                    ENDIF
                ELSE
                    *-- Servico ou item de categoria: agrupa por Cats, mas
                    *-- componente "incluso" (FlagIncs) sempre gera linha
                    IF !SEEK(PADR(cursor_4c_LocalNensi.Cats, 6), loc_cAliasPNensi, "Cats") ;
                            OR ConverterParaLogico(cursor_4c_LocalNensi.FlagIncs)
                        INSERT INTO (loc_cAliasPNensi) ;
                            (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, ;
                             Rateio, FlagIncs, Cats, Servicos, Fators, Moedas, GrupoFins) ;
                            VALUES (cursor_4c_LocalNensi.Emps, cursor_4c_LocalNensi.Dopps, ;
                                cursor_4c_LocalNensi.Numps, cursor_4c_LocalNensi.CMats, ;
                                cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CUnis, ;
                                cursor_4c_LocalPro.CGrus, .T., 0, .T., ;
                                cursor_4c_LocalNensi.Cats, .T., cursor_4c_LocalNensi.Fators, ;
                                cursor_4c_LocalNensi.Moedas, cursor_4c_LocalNensi.GrupoFins)
                    ENDIF

                    REPLACE Qtds WITH Qtds + cursor_4c_LocalNensi.Qtds IN (loc_cAliasPNensi)
                ENDIF

                *-- Restaura a area de trabalho ANTES do ENDSCAN: o ramo de
                *-- cima faz "SELECT xPNensi" e a condicao "WHILE (NEnvs =
                *-- loc_nNEnv)" tem de ser avaliada em LocalNensi (o legado
                *-- se apoia no vinculo implicito do SCAN; aqui eh explicito)
                SELECT (loc_cAliasNensi)
            ENDSCAN

            *-- Legado: Skip -1. O "Scan While" sai JA passado do fim do
            *-- grupo; voltar um registro faz o ENDSCAN de fora pousar na
            *-- primeira linha do grupo seguinte.
            IF !BOF(loc_cAliasNensi)
                SKIP -1 IN (loc_cAliasNensi)
            ENDIF
        ENDSCAN

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConsolidarTotaisPendencias - roll-up de xPNensi em xPNensiT (a grade
    * "Total", que o botao Totaliza alterna com a de itens). Transcricao do
    * ultimo laco do Init legado ("Select xPnensi / Scan / Scatter Memvar
    * ...").
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * SCATTER NAME (objeto) no lugar do "Scatter Memvar" do legado: mesmo
    * efeito, sem criar memvars de nome igual ao dos campos - o que tambem
    * evita a armadilha do prefixo "m." (as variaveis passam a ser
    * propriedades de um objeto loc_, dentro da convencao do projeto).
    *
    * Int(m.Nops/10000) eh o agrupador: a Ordem de Fabricacao eh a Ordem de
    * Producao sem os 4 ultimos digitos (a fase). Transcrito literalmente.
    *==========================================================================
    PROTECTED PROCEDURE ConsolidarTotaisPendencias()
        LOCAL loc_cAliasPNensi, loc_cAliasPNensiT, loc_oReg, loc_cEmpDnp, loc_nAQtds

        loc_cAliasPNensi  = THIS.this_cCursorPNensi
        loc_cAliasPNensiT = THIS.this_cCursorPNensiT

        IF !USED(loc_cAliasPNensi) OR !USED(loc_cAliasPNensiT)
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasPNensiT)
        SET ORDER TO EmpDopNum

        SELECT (loc_cAliasPNensi)
        GO TOP
        SCAN
            SCATTER NAME loc_oReg

            *-- legado: m.Nops = Int(m.Nops/10000)
            loc_oReg.Nops = INT(loc_oReg.Nops / 10000)

            *-- Chave POSICIONAL char(33) (regra #42) + CMats char(14) +
            *-- Str(Nops,10) = 57, que eh a chave CHEIA do indice EmpDopNum
            *-- de xPNensiT (SEEK parcial nao casa com SET EXACT ON)
            loc_cEmpDnp = PADR(loc_oReg.Emps, 3) + PADR(loc_oReg.Dopps, 20) + ;
                STR(loc_oReg.Numps, 10)

            *-- legado: aQtds recebe "LocalNensi.Qtds" - leitura do cursor de
            *-- detalhe da volta ANTERIOR, que a esta altura esta parado na
            *-- ultima linha lida. Outra DIVERGENCIA HERDADA transcrita como
            *-- esta (ver nota de Ps2FaseAnt em CarregarItensDaPendencia):
            *-- "corrigir" para loc_oReg.aQtds mudaria valor em silencio.
            loc_nAQtds = 0
            IF USED("cursor_4c_LocalNensi") ;
                    AND TYPE("cursor_4c_LocalNensi.Qtds") = "N"
                loc_nAQtds = cursor_4c_LocalNensi.Qtds
            ENDIF

            SELECT (loc_cAliasPNensiT)
            IF !SEEK(loc_cEmpDnp + PADR(loc_oReg.CMats, 14) + STR(loc_oReg.Nops, 10))
                INSERT INTO (loc_cAliasPNensiT) ;
                    (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, Visivel, ;
                     CUnis, CGrus, aQtds) ;
                    VALUES (loc_oReg.Emps, loc_oReg.Dopps, loc_oReg.Numps, ;
                        loc_oReg.Nops, loc_oReg.Nops, loc_oReg.CMats, ;
                        loc_oReg.CDescs, .T., loc_oReg.CUnis, loc_oReg.CGrus, ;
                        loc_nAQtds)
            ENDIF

            *-- legado: Replace Qtds With Qtds + m.Qtds, Pesos With Pesos +
            *-- m.Pesos (sem clausula IN - area corrente = xPNensiT)
            REPLACE Qtds  WITH Qtds + loc_oReg.Qtds, ;
                    Pesos WITH Pesos + loc_oReg.Pesos ;
                IN (loc_cAliasPNensiT)

            *-- Restaura a area ANTES do ENDSCAN (o laco eh de xPNensi)
            SELECT (loc_cAliasPNensi)
        ENDSCAN

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Marcar - legado: SIGOPMPN.marca (ThisForm.Marca(), chamado pelo
    * CheckBox da coluna de selecao e pelo botao SelTudo). Marca a linha
    * CORRENTE de TmpPends (lida por THIS.CarregarDoCursor em
    * this_cEmps/this_cDopps/this_nNumps/this_dDatas) como pertencente ao
    * "nivel" da necessidade que o form pai esta atendendo (TmpNens),
    * checando duplicidade/numeracao-automatica/data ANTES de efetivar o
    * UPDATE em SigCdNec.
    *
    * par_lAutomatico - legado "_Automatico" (Parameters _Automatico): .T.
    * quando chamado em LOTE (SelTudo), que SUPRIME o MsgAviso de
    * "Movimentacao Ja Utilizada em Outra Operacao" (o legado so avisa no
    * clique individual do CheckBox - If Not _Automatico).
    *
    * PUBLIC (regra #51: o Form chama de fora).
    *==========================================================================
    PROCEDURE Marcar(par_lAutomatico)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.MarcarExec(par_lAutomatico)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao marcar movimenta" + CHR(231) + CHR(227) + ;
                "o pendente:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarExec - corpo de Marcar(). PROTECTED (regra #51). Transcricao do
    * "marca" legado (linhas 1479-1575 do dump), exceto:
    *   - "This.ok.click" (chamado DENTRO do proprio marca quando Numeras =
    *     3) nao pode ser chamado daqui - este BO nao conhece o botao OK.
    *     THIS.this_lFecharAposMarcar sinaliza esse caso ao Form, que
    *     fecha o dialogo gravando tudo (CmdOkClick) apos um Marcar() com
    *     sucesso.
    *   - "Select TmpNens/TmpPends" (troca de work area sem leitura
    *     adicional) nao tem efeito a reproduzir nesta arquitetura.
    *==========================================================================
    PROTECTED PROCEDURE MarcarExec(par_lAutomatico)
        LOCAL loc_lAutomatico, loc_cAliasNens, loc_cAliasOpd, loc_cAliasPends
        LOCAL loc_nNumNivel, loc_lNumeroAnt, loc_lBaixaSubN, loc_lRetorna
        LOCAL loc_nContaMarcadas, loc_nRecnoPend, loc_cCidChaves, loc_lChkSubnAtual
        LOCAL loc_cSQL, loc_nResultado

        THIS.this_lFecharAposMarcar = .F.

        loc_lAutomatico = ConverterParaLogico(par_lAutomatico)

        loc_cAliasNens  = THIS.this_cCursorNens
        loc_cAliasOpd   = THIS.this_cCursorOpd
        loc_cAliasPends = THIS.this_cCursorPends

        IF !USED(loc_cAliasNens) OR !USED(loc_cAliasOpd) OR !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursores do formul" + CHR(225) + "rio chamador n" + ;
                CHR(227) + "o est" + CHR(227) + "o abertos."
            RETURN .F.
        ENDIF

        *-- legado: =Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps') / _NumNivel =
        *-- Val(Str(crSigCdOpd.Ndopps, 2) + Transform(TmpPends.Numps, '@L 9999999999'))
        IF !SEEK(THIS.this_cDopps, loc_cAliasOpd, "Dopps")
            THIS.this_cMensagemErro = "N" + CHR(237) + "vel/opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o encontrado (crSigCdOpd)."
            RETURN .F.
        ENDIF
        loc_nNumNivel = VAL(STR(EVALUATE(loc_cAliasOpd + ".NDopps"), 2) + ;
            TRANSFORM(THIS.this_nNumps, "@L 9999999999"))

        *-- legado: =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _NumeroAnt =
        *-- (crSigCdOpd.Numeras = 3) / _BaixaSubN = (crSigCdOpd.BxAutos = 1)
        IF !SEEK(EVALUATE(loc_cAliasNens + ".Dopps"), loc_cAliasOpd, "Dopps")
            THIS.this_cMensagemErro = "N" + CHR(237) + "vel da necessidade n" + CHR(227) + ;
                "o encontrado (crSigCdOpd)."
            RETURN .F.
        ENDIF
        loc_lNumeroAnt = (NVL(EVALUATE(loc_cAliasOpd + ".Numeras"), 0) = 3)
        loc_lBaixaSubN = (NVL(EVALUATE(loc_cAliasOpd + ".BxAutos"), 0) = 1)

        *-- legado: If _NumeroAnt / conta quantas linhas de TmpPends ja
        *-- estao marcadas (Flag) OU sao a linha corrente - "numeracao
        *-- automatica" so aceita 1 subnivel por vez
        IF loc_lNumeroAnt
            loc_nContaMarcadas = 0
            SELECT (loc_cAliasPends)
            loc_nRecnoPend = RECNO()
            SCAN
                IF Flag OR RECNO() = loc_nRecnoPend
                    loc_nContaMarcadas = loc_nContaMarcadas + 1
                ENDIF
            ENDSCAN
            SELECT (loc_cAliasPends)
            GOTO loc_nRecnoPend

            IF loc_nContaMarcadas > 1
                MsgAviso("Este Tipo de Opera" + CHR(231) + CHR(227) + "o S" + CHR(243) + ;
                    " Aceita 1 Subn" + CHR(237) + "vel!!!", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_lRetorna = .T.

        *-- legado: If TmpPends.Datas > TmpNens.Datas
        IF !ISNULL(THIS.this_dDatas) AND !ISNULL(EVALUATE(loc_cAliasNens + ".Datas")) AND ;
                THIS.this_dDatas > EVALUATE(loc_cAliasNens + ".Datas")
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o com diverg" + CHR(234) + ;
                "ncia de Datas!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lRetorna = .F.
        ENDIF

        *-- legado: CursorQuery('SigCdNec', 'LocalNens', 'EmpDNPs', _Nivel,
        *-- 'cIdChaves, ChkSubn') - _Nivel = Emps+Dopps+Str(Numps,10) da
        *-- linha CORRENTE de TmpPends (regra #42: chave POSICIONAL, PADR
        *-- explicito, NUNCA ALLTRIM)
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNec", "EmpDNPs", ;
                PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopps, 20) + STR(THIS.this_nNumps, 10), ;
                "cIdChaves, ChkSubn")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCidChaves    = cursor_4c_OkNec.cIdChaves
        loc_lChkSubnAtual = ConverterParaLogico(cursor_4c_OkNec.ChkSubn)

        *-- legado: If LocalNens.ChkSubn / If Not _Automatico / MsgBox ... /
        *-- _Retorna = .f.
        IF loc_lChkSubnAtual
            IF !loc_lAutomatico
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Utilizada em " + ;
                    "Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            loc_lRetorna = .F.
        ENDIF

        *-- legado: If _Retorna And Not _Automatico / Update SigCdNec Set
        *-- cIdChaves = '<cid>' Where cIdChaves = '<cid>' - "toque" na
        *-- linha para detectar concorrencia (optimistic lock por
        *-- auto-update que nao muda valor nenhum)
        IF loc_lRetorna AND !loc_lAutomatico
            loc_cSQL = "UPDATE SigCdNec SET CidChaves = " + EscaparSQL(loc_cCidChaves) + ;
                " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                MsgAviso("Subnivel em Uso Por Outra Movimenta" + CHR(231) + CHR(227) + ;
                    "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lRetorna = .F.
            ENDIF
        ENDIF

        IF USED("cursor_4c_OkNec")
            USE IN cursor_4c_OkNec
        ENDIF

        IF !loc_lRetorna
            RETURN .F.
        ENDIF

        *-- legado: If _BaixaSubN / Update SigCdNec Set ChkSubn = ?pTru
        *-- Where cIdChaves = '<cid>' - pTru eh SEMPRE .T. - delega ao
        *-- contrato de Atualizar() (regra do BO: UNICO alvo de ChkSubn)
        IF loc_lBaixaSubN
            THIS.this_cCidChavesAtual = loc_cCidChaves
            THIS.this_lChkSubn        = .T.

            IF !THIS.Atualizar()
                RETURN .F.
            ENDIF
        ENDIF

        *-- legado: If _NumeroAnt / Select TmpNens / Go top / Replace
        *-- Numps With LocalNens.Numps, Obss With LocalNens.Obss - a
        *-- CursorQuery acima so trouxe cIdChaves/ChkSubn; widening para
        *-- incluir Numps/Obss eh NECESSARIO para este ramo funcionar (sem
        *-- isso "LocalNens.Numps" estouraria "Variable not found" -
        *-- DIVERGENCIA DOCUMENTADA, decisao humana: o dump legado pede
        *-- campos que a propria CursorQuery daquela linha nao selecionou).
        IF loc_lNumeroAnt
            IF THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNecNum", "CidChaves", ;
                    loc_cCidChaves, "Numps, Obss")
                SELECT (loc_cAliasNens)
                GO TOP
                REPLACE Numps WITH cursor_4c_OkNecNum.Numps, ;
                        Obss  WITH NVL(cursor_4c_OkNecNum.Obss, "") ;
                    IN (loc_cAliasNens)

                IF USED("cursor_4c_OkNecNum")
                    USE IN cursor_4c_OkNecNum
                ENDIF
            ENDIF
        ENDIF

        *-- legado: If _NumeroAnt / This.ok.click - o BO nao conhece o
        *-- botao: sinaliza ao Form, que fecha o dialogo (CmdOkClick)
        THIS.this_lFecharAposMarcar = loc_lNumeroAnt

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Desmarcar - legado: SIGOPMPN.desmarca (ThisForm.Desmarca, chamado
    * pelo CheckBox ao desmarcar e pelo botao Apaga). Zera SigCdNec.ChkSubn
    * da linha CORRENTE de TmpPends (this_cEmps/this_cDopps/this_nNumps,
    * lidos por THIS.CarregarDoCursor). PUBLIC (regra #51).
    *==========================================================================
    PROCEDURE Desmarcar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.DesmarcarExec()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desmarcar movimenta" + CHR(231) + CHR(227) + ;
                "o pendente:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * DesmarcarExec - corpo de Desmarcar(). PROTECTED (regra #51). O
    * "=Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps')" do legado so
    * reposiciona o cursor (nunca lido depois, dentro de desmarca) - sem
    * efeito a reproduzir nesta arquitetura (nada aqui depende de ponteiro
    * de cursor global).
    *==========================================================================
    PROTECTED PROCEDURE DesmarcarExec()
        LOCAL loc_cCidChaves

        *-- legado: CursorQuery('SigCdNec', 'LocalNens', 'EmpDNPs', _Nivel,
        *-- 'cIdChaves') - chave POSICIONAL (regra #42)
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNec", "EmpDNPs", ;
                PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopps, 20) + STR(THIS.this_nNumps, 10), ;
                "cIdChaves")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCidChaves = cursor_4c_OkNec.cIdChaves

        IF USED("cursor_4c_OkNec")
            USE IN cursor_4c_OkNec
        ENDIF

        THIS.this_cCidChavesAtual = loc_cCidChaves
        THIS.this_lChkSubn        = .F.

        RETURN THIS.Atualizar()
    ENDPROC

    *==========================================================================
    * ConfirmarMovimentacoes - legado: SIGOPMPN.ok.Click. Para CADA
    * pendencia MARCADA (Flag) de TmpPends, grava o detalhe (fase/item) nos
    * cursores de SAIDA do form pai (xMFas/xOpi/xNensi), atualiza
    * SigCdNec.NAceites/ChkSubn e preenche TmpOperacao. PUBLIC (o Form
    * chama de fora - regra #51).
    *
    * "Set Step On" do legado (abre o depurador) NAO foi transcrito:
    * resquicio de debug do desenvolvedor, sem efeito de negocio.
    *==========================================================================
    PROCEDURE ConfirmarMovimentacoes()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ConfirmarMovimentacoesExec()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao confirmar movimenta" + CHR(231) + CHR(245) + ;
                "es pendentes:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfirmarMovimentacoesExec - corpo de ConfirmarMovimentacoes().
    * PROTECTED (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ConfirmarMovimentacoesExec()
        LOCAL loc_cAliasPends, loc_cAliasOpd, loc_lBaixaSubN

        loc_cAliasPends = THIS.this_cCursorPends
        loc_cAliasOpd   = THIS.this_cCursorOpd

        IF !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursor da grade de sele" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        *-- legado: Zap In xnensi/xmfas/tmpoperacao/xPesa/xOpi (cursores de
        *-- SAIDA do form pai, zerados antes de regravar)
        IF USED(THIS.this_cCursorNensiSaida)
            ZAP IN (THIS.this_cCursorNensiSaida)
        ENDIF
        IF USED(THIS.this_cCursorMFas)
            ZAP IN (THIS.this_cCursorMFas)
        ENDIF
        IF USED(THIS.this_cCursorOperacao)
            ZAP IN (THIS.this_cCursorOperacao)
        ENDIF
        IF USED(THIS.this_cCursorPesa)
            ZAP IN (THIS.this_cCursorPesa)
        ENDIF
        IF USED(THIS.this_cCursorOpi)
            ZAP IN (THIS.this_cCursorOpi)
        ENDIF

        *-- legado: =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _BaixaSubN
        *-- = (crSigCdOpd.BxAutos = 1)
        loc_lBaixaSubN = .F.
        IF USED(loc_cAliasOpd) AND USED(THIS.this_cCursorNens)
            IF SEEK(EVALUATE(THIS.this_cCursorNens + ".Dopps"), loc_cAliasOpd, "Dopps")
                loc_lBaixaSubN = (NVL(EVALUATE(loc_cAliasOpd + ".BxAutos"), 0) = 1)
            ENDIF
        ENDIF

        *-- legado: Select TmpPends / Scan For Flag
        SELECT (loc_cAliasPends)
        SCAN FOR Flag
            IF !THIS.GravarPendenciaConfirmada(Emps, Dopps, Numps, loc_lBaixaSubN)
                RETURN .F.
            ENDIF
            SELECT (loc_cAliasPends)
        ENDSCAN

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GravarPendenciaConfirmada - corpo do "Select TmpPends / Scan For
    * Flag" do "ok" legado (linhas 2344-2594 do dump), ATE o fim do laco de
    * SigPdMvf (LocalMFas) - a parte final (SigCdNei/LocalNensI) fica em
    * GravarDetalheEnvelopeFinal, chamada no fim deste metodo (confirmado
    * pela contagem de Scan/EndScan do dump: o bloco LocalNensI roda UMA
    * VEZ por pendencia, fora do Scan de LocalMFas mas dentro do Scan de
    * TmpPends).
    *
    * PROTECTED (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE GravarPendenciaConfirmada(par_cEmps, par_cDopps, par_nNumps, par_lBaixaSubN)
        LOCAL loc_cAliasNens, loc_cAliasOpd, loc_cAliasNec
        LOCAL loc_nNumNivel, loc_cChaveNens, loc_cCidChaves, loc_lRetrabs, loc_cSQL

        loc_cAliasNens = THIS.this_cCursorNens
        loc_cAliasOpd  = THIS.this_cCursorOpd
        loc_cAliasNec  = THIS.this_cCursorNecessidades

        *-- legado: =Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps') / _NumNivel
        *-- = crSigCdOpd.NDopps (aqui o "ok" usa o NDopps PURO, diferente do
        *-- Val(Str()+Transform()) de Marcar - ver Insert Into TmpOperacao)
        IF !SEEK(par_cDopps, loc_cAliasOpd, "Dopps")
            THIS.this_cMensagemErro = "N" + CHR(237) + "vel/opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o encontrado (crSigCdOpd)."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF
        loc_nNumNivel = EVALUATE(loc_cAliasOpd + ".NDopps")

        *-- legado: =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') - reposiciona
        *-- para o nivel da necessidade do form pai; nao lido depois no
        *-- legado, mantido so por fidelidade de fluxo
        = SEEK(EVALUATE(loc_cAliasNens + ".Dopps"), loc_cAliasOpd, "Dopps")

        *-- legado: _ChaveNens = TmpPends.Emps + TmpPends.Dopps + Str(
        *-- TmpPends.Numps, 10) - chave POSICIONAL char(33) (regra #42)
        loc_cChaveNens = PADR(par_cEmps, 3) + PADR(par_cDopps, 20) + STR(par_nNumps, 10)

        *-- legado: CursorQuery('SigCdNec', 'LocalNens', 'EmpDNPs',
        *-- _ChaveNens, 'cIdChaves, Retrabs')
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNec", "EmpDNPs", loc_cChaveNens, ;
                "cIdChaves, Retrabs")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCidChaves = cursor_4c_OkNec.cIdChaves
        loc_lRetrabs   = ConverterParaLogico(cursor_4c_OkNec.Retrabs)

        IF USED("cursor_4c_OkNec")
            USE IN cursor_4c_OkNec
        ENDIF

        *-- legado: Update SigCdNec Set NAceites = <TmpNens.Numps> [, ChkSubn
        *-- = 1] Where cIdChaves = '<cid>' - pTrue eh SEMPRE .T.; NAceites
        *-- recebe o numero da NECESSIDADE do form pai (TmpNens.Numps), nao
        *-- desta linha de TmpPends
        loc_cSQL = "UPDATE SigCdNec SET NAceites = " + ;
            FormatarNumeroSQL(EVALUATE(loc_cAliasNens + ".Numps"), 0) + ;
            IIF(par_lBaixaSubN, ", ChkSubn = 1", "") + ;
            " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)

        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (OK - Update - SigCdNec)" + CHR(13) + ;
                CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- legado: Update crSigCdNec Set NAceites = TmpNens.Numps Where
        *-- cIdChaves = LocalNens.cIdChaves - espelha no cursor GLOBAL
        *-- (crSigCdNec), que outras telas podem estar lendo. A linha
        *-- fica POSICIONADA aqui (LOCATE bem-sucedido) para
        *-- GravarDetalheEnvelopeFinal/GravarFaseAusente, que leem dela.
        IF USED(loc_cAliasNec)
            SELECT (loc_cAliasNec)
            LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(loc_cCidChaves)
            IF FOUND()
                REPLACE NAceites WITH EVALUATE(loc_cAliasNens + ".Numps") IN (loc_cAliasNec)
            ENDIF
        ENDIF

        *-- legado: If LocalNens.Retrabs / Replace Retrabs With .t./.f. In
        *-- TmpNens
        IF USED(loc_cAliasNens)
            REPLACE Retrabs WITH loc_lRetrabs IN (loc_cAliasNens)
        ENDIF

        *-- legado: CursorQuery('SigPdMvf', 'LocalMFas', 'EmpDNPs',
        *-- _ChaveNens, ...) + Select LocalMFas / Scan - uma linha por FASE
        *-- ja lancada desta pendencia. Universo VAZIO (nenhuma fase ainda)
        *-- nao eh erro - segue direto para GravarDetalheEnvelopeFinal.
        IF THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_OkMFas", "EmpDNPs", loc_cChaveNens, ;
                "Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, " + ;
                "Grupods, Contads, Nops, Nenvs, Dopes, Numes, Dataps, Dataes, Obss, " + ;
                "Codpds, Unids, Pesos, Qtds, Obsps, Ordems, cRetrabs")
            SELECT cursor_4c_OkMFas
            SCAN
                IF !THIS.GravarFaseConfirmada(loc_nNumNivel, loc_cChaveNens)
                    IF USED("cursor_4c_OkMFas")
                        USE IN cursor_4c_OkMFas
                    ENDIF
                    RETURN .F.
                ENDIF
                SELECT cursor_4c_OkMFas
            ENDSCAN
            IF USED("cursor_4c_OkMFas")
                USE IN cursor_4c_OkMFas
            ENDIF
        ENDIF

        *-- bloco final (SigCdNei/LocalNensI) - roda UMA VEZ por pendencia
        RETURN THIS.GravarDetalheEnvelopeFinal(loc_cChaveNens)
    ENDPROC

    *==========================================================================
    * GravarFaseConfirmada - corpo do "Select LocalMFas / Scan" do "ok"
    * legado (linhas 2392-2451 do dump). Opera sobre a linha CORRENTE de
    * cursor_4c_OkMFas (ja selecionada pelo chamador). PROTECTED (regra
    * #51).
    *==========================================================================
    PROTECTED PROCEDURE GravarFaseConfirmada(par_nNumNivel, par_cChaveNens)
        LOCAL loc_cAliasNens, loc_cAliasMFas, loc_cAliasOperacao, loc_cAliasOpi
        LOCAL loc_nNops, loc_cSQL, loc_nResultado, loc_dUltimaData
        LOCAL loc_cEmp, loc_cEdn, loc_nContaOs, loc_lIndividualPeso, loc_nNEnv

        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasMFas     = THIS.this_cCursorMFas
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasOpi      = THIS.this_cCursorOpi

        *-- legado: _Nops = LocalMfas.Nops (alias corrente)
        loc_nNops = cursor_4c_OkMFas.Nops

        *-- legado: Select a.Nops, a.Datas, a.cidChaves From SigPdMvf a
        *-- Where a.Nops = <nops> And a.Emps = '<_Empr>' Order By a.Nops
        *-- Desc, a.cIdChaves Desc - a 1a linha eh o lancamento MAIS
        *-- RECENTE desta ordem de producao (_Empr -> go_4c_Sistema.
        *-- cCodEmpresa, NUNCA a variavel legada _EMPR)
        loc_cSQL = "SELECT a.Nops, a.Datas, a.cidChaves FROM SigPdMvf a" + ;
            " WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
            " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
            " ORDER BY a.Nops DESC, a.cIdChaves DESC"

        IF USED("cursor_4c_OkMFas2")
            USE IN cursor_4c_OkMFas2
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkMFas2")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalMFas2)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkMFas2
        GO TOP
        loc_dUltimaData = cursor_4c_OkMFas2.Datas

        IF USED("cursor_4c_OkMFas2")
            USE IN cursor_4c_OkMFas2
        ENDIF

        *-- legado: If (Dtos(LocalMFas2.Datas) > Dtos(TmpNens.datas)) -
        *-- Dtos trunca a hora; DATE() nos dois lados reproduz isso
        IF !ISNULL(loc_dUltimaData) AND USED(loc_cAliasNens) AND ;
                DATE(loc_dUltimaData) > DATE(EVALUATE(loc_cAliasNens + ".Datas"))
            MsgAviso("Data inconsistente. " + "Ultimo lan" + CHR(231) + "amento com data de " + ;
                DTOC(loc_dUltimaData), "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- legado: Insert Into xMFas (...) Values (LocalMFas.*)
        INSERT INTO (loc_cAliasMFas) ;
            (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, ;
             Grupods, Contads, NOps, NEnvs, Dopes, Numes, Dataps, Dataes, Obss, ;
             Codpds, Unids, Pesos, Qtds, Obsps, Ordems, cRetrabs) ;
            VALUES (cursor_4c_OkMFas.Emps, cursor_4c_OkMFas.Dopps, cursor_4c_OkMFas.Numps, ;
                cursor_4c_OkMFas.Datars, cursor_4c_OkMFas.Datas, cursor_4c_OkMFas.Usuars, ;
                cursor_4c_OkMFas.Opers, cursor_4c_OkMFas.Grupoos, cursor_4c_OkMFas.Contaos, ;
                cursor_4c_OkMFas.Grupods, cursor_4c_OkMFas.Contads, cursor_4c_OkMFas.Nops, ;
                cursor_4c_OkMFas.Nenvs, cursor_4c_OkMFas.Dopes, cursor_4c_OkMFas.Numes, ;
                cursor_4c_OkMFas.Dataps, cursor_4c_OkMFas.Dataes, cursor_4c_OkMFas.Obss, ;
                cursor_4c_OkMFas.Codpds, cursor_4c_OkMFas.Unids, cursor_4c_OkMFas.Pesos, ;
                cursor_4c_OkMFas.Qtds, cursor_4c_OkMFas.Obsps, cursor_4c_OkMFas.Ordems, ;
                cursor_4c_OkMFas.cRetrabs)

        *-- legado: If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs,
        *-- 'TmpOperacao', 'Codigos') - xMFas.NEnvs == cursor_4c_OkMFas.
        *-- Nenvs (acabou de ser copiado pelo Insert acima)
        loc_nNEnv = cursor_4c_OkMFas.Nenvs
        IF !SEEK((par_nNumNivel * 10000000000) + loc_nNEnv, loc_cAliasOperacao, "Codigos")
            INSERT INTO (loc_cAliasOperacao) (Codigos, EmpDnPs, Autos) ;
                VALUES ((par_nNumNivel * 10000000000) + loc_nNEnv, par_cChaveNens, .T.)
        ENDIF

        *-- legado: CursorQuery('SigOpPic', 'LocalOpi', 'Nops', LocalMFas.
        *-- Nops, 'Emps, Dopes, Numes, Qtds, CodCors, CodTams, Empds') + Scan
        IF THIS.ExecutarCursorQuery("SigOpPic", "cursor_4c_OkOpi", "Nops", loc_nNops, ;
                "Emps, Dopes, Numes, Qtds, CodCors, CodTams, Empds")
            SELECT cursor_4c_OkOpi
            SCAN
                IF cursor_4c_OkOpi.Qtds != 0
                    loc_cEmp = IIF(EMPTY(cursor_4c_OkOpi.Empds), cursor_4c_OkOpi.Emps, cursor_4c_OkOpi.Empds)
                    loc_cEdn = cursor_4c_OkOpi.Emps + cursor_4c_OkOpi.Dopes + STR(cursor_4c_OkOpi.Numes, 6)

                    *-- Guard ausente no legado (que assume sucesso) - mesmo
                    *-- padrao defensivo ja usado em CarregarItensDaPendencia
                    *-- para a lookup gemea de SigCdPro
                    IF !THIS.ExecutarCursorQuery("SigMvCab", "cursor_4c_OkEest", "EmpDopNums", ;
                            loc_cEdn, "ContaOs, ContaDs")
                        SELECT cursor_4c_OkOpi
                        LOOP
                    ENDIF
                    IF !THIS.ExecutarCursorQuery("SigCdOpe", "cursor_4c_OkOpe", "Dopes", ;
                            cursor_4c_OkOpi.Dopes, "Globalizas, Servicos")
                        SELECT cursor_4c_OkOpi
                        LOOP
                    ENDIF

                    IF NVL(cursor_4c_OkOpe.Globalizas, 0) = 1 OR ConverterParaLogico(cursor_4c_OkOpe.Servicos)
                        loc_nContaOs = cursor_4c_OkEest.ContaOs
                    ELSE
                        loc_nContaOs = cursor_4c_OkEest.ContaDs
                    ENDIF

                    *-- legado: Indiv = (crSigCdPam.TpPesas = 1)
                    IF VARTYPE(crSigCdPam.TpPesas) = "L"
                        loc_lIndividualPeso = crSigCdPam.TpPesas
                    ELSE
                        loc_lIndividualPeso = (NVL(crSigCdPam.TpPesas, 0) = 1)
                    ENDIF

                    INSERT INTO (loc_cAliasOpi) ;
                        (Nops, Oper, Qtds, CPros, Indiv, Nenvs, Emps, Dopes, Numes, ;
                         Conta, Empds, CodCors, CodTams) ;
                        VALUES (cursor_4c_OkMFas.Nops, ;
                            ALLTRIM(cursor_4c_OkOpi.Dopes) + "/" + ALLTRIM(STR(cursor_4c_OkOpi.Numes)), ;
                            cursor_4c_OkOpi.Qtds, cursor_4c_OkMFas.Codpds, loc_lIndividualPeso, ;
                            cursor_4c_OkMFas.Nenvs, cursor_4c_OkOpi.Emps, cursor_4c_OkOpi.Dopes, ;
                            cursor_4c_OkOpi.Numes, loc_nContaOs, loc_cEmp, cursor_4c_OkOpi.CodCors, ;
                            cursor_4c_OkOpi.CodTams)

                    SELECT cursor_4c_OkOpi
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_OkOpi")
                USE IN cursor_4c_OkOpi
            ENDIF
        ENDIF
        IF USED("cursor_4c_OkEest")
            USE IN cursor_4c_OkEest
        ENDIF
        IF USED("cursor_4c_OkOpe")
            USE IN cursor_4c_OkOpe
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GravarDetalheEnvelopeFinal - legado: bloco final do "ok" Click
    * (Select * From SigCdNei Where EmpDNps = '<_ChaveNens>' ... ->
    * LocalNensI, linhas 2452-2593 do dump), que roda UMA VEZ por
    * pendencia confirmada (fora do Scan de LocalMFas, dentro do Scan de
    * TmpPends - confirmado pela contagem de Scan/EndScan do dump). Espelha
    * a mesma logica de agrupamento de CarregarItensDaPendencia, mas grava
    * no cursor de SAIDA do form pai (xNensi) em vez de xPNensi, e tem um
    * bloco adicional (SepPedras em 1/3/4, via GravarFaseAusente) que
    * garante pelo menos uma linha em xMFas/TmpOperacao para Nops ainda nao
    * cobertos pela fase (SigPdMvf) ja lancada.
    *
    * PROTECTED (regra #51).
    *
    * DIVERGENCIA DOCUMENTADA: o legado le CrSigCdNec.Emps/Dopps/Numps/
    * Datas/Usuars/Grupoos/Contaos/Grupods/Contads sem reposicionar o
    * cursor GLOBAL explicitamente neste ponto - conta com a posicao que
    * GravarPendenciaConfirmada deixou (LOCATE bem-sucedido pela mesma
    * CidChaves, poucas linhas antes). Aqui o mesmo cursor global
    * (this_cCursorNecessidades) eh lido da MESMA forma - a posicao jah
    * fica garantida pelo LOCATE feito em GravarPendenciaConfirmada, que
    * SEMPRE roda antes desta chamada.
    *==========================================================================
    PROTECTED PROCEDURE GravarDetalheEnvelopeFinal(par_cChaveNens)
        LOCAL loc_cAliasOpd, loc_cAliasNensiSaida, loc_cAliasMFas, loc_cAliasOperacao
        LOCAL loc_nAcEnvs, loc_nSepPedras, loc_nCompAgrus, loc_nNumNivel
        LOCAL loc_nNEnv, loc_nRateio, loc_lVisivel, loc_lServico
        LOCAL loc_cBMat, loc_cDMat, loc_cCMat, loc_cGMat, loc_cCatMat, loc_cTMat
        LOCAL loc_cSQL, loc_nResultado

        loc_cAliasOpd        = THIS.this_cCursorOpd
        loc_cAliasNensiSaida = THIS.this_cCursorNensiSaida
        loc_cAliasMFas       = THIS.this_cCursorMFas
        loc_cAliasOperacao   = THIS.this_cCursorOperacao

        IF !USED(loc_cAliasNensiSaida)
            THIS.this_cMensagemErro = "Cursor de sa" + CHR(237) + "da xNensi (form " + ;
                "chamador) n" + CHR(227) + "o est" + CHR(225) + " aberto."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        loc_nAcEnvs    = NVL(EVALUATE(loc_cAliasOpd + ".AcEnvs"), 0)
        loc_nSepPedras = NVL(EVALUATE(loc_cAliasOpd + ".SepPedras"), 0)
        loc_nCompAgrus = NVL(EVALUATE(loc_cAliasOpd + ".CompAgrus"), 0)
        loc_nNumNivel  = NVL(EVALUATE(loc_cAliasOpd + ".NDopps"), 0)

        *-- legado: Select * From SigCdNei Where EmpDNps = '<_ChaveNens>'
        *-- Order By ... (SELECT * exige listar as 50 colunas - mesma
        *-- estrutura de xPNensi/xPNensiT, regra #22)
        loc_cSQL = "SELECT Aqtds, Cats, CDescs, CGrus, CMats, Coefs, ContaFs, CUnis, " + ;
            "DataTrans, Dopps, Emps, Fators, FlagIncs, GrupoFins, GrupoFs, Moedas, " + ;
            "Moeds, NEnvs, Nops, Numps, Obss, Pesos, Qtds, Servicos, TpOps, Locals, " + ;
            "NTrans, CidChaves, NLotes, PesoFixs, CoefInfs, CRetrabs, EmpDNPs, " + ;
            "EmpDopNums, ChkSubn, CodCors, CodNConfs, CodTams, Peso2s, CustoFs, " + ;
            "MoeCusFs, Estorno, PVens, Ps2FaseAnt, cUnips, OsRets, Retrabs, " + ;
            "MatPrincs, PsFaseAnt, Descs, Rateio, Visivel, QtFaseAnt" + ;
            " FROM SigCdNei" + ;
            " WHERE EmpDNps = " + EscaparSQL(par_cChaveNens) + ;
            " ORDER BY Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, Qtds, Pesos," + ;
            " TpOps, Cats, FlagIncs, CUnis, Obss, nLotes, codCors, codTams"

        IF USED("cursor_4c_OkNensI")
            USE IN cursor_4c_OkNensI
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkNensI")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNensI)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkNensI
        SCAN
            loc_nNEnv = cursor_4c_OkNensI.NEnvs

            SCAN WHILE (NEnvs = loc_nNEnv)
                IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_OkPro", "CPros", ;
                        cursor_4c_OkNensI.CMats, "CGrus, Varias, Dpros, Cunis")
                    SELECT cursor_4c_OkNensI
                    LOOP
                ENDIF

                loc_nRateio  = 5
                loc_lVisivel = .T.

                IF loc_nAcEnvs = 1
                    IF cursor_4c_OkNensI.Nops = 0
                        loc_nRateio  = 5
                        loc_lVisivel = .T.
                    ELSE
                        loc_nRateio  = IIF(NVL(cursor_4c_OkPro.Varias, 0) = 1, 2, 3)
                        loc_lVisivel = .F.
                    ENDIF
                ENDIF

                loc_lServico = ConverterParaLogico(cursor_4c_OkNensI.Servicos)

                IF !loc_lServico AND !EMPTY(cursor_4c_OkNensI.CMats) AND EMPTY(cursor_4c_OkNensI.Cats)
                    INSERT INTO (loc_cAliasNensiSaida) ;
                        (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, ;
                         PsFaseAnt, Pesos, Visivel, Rateio, TpOps, Cats, FlagIncs, CUnis, ;
                         CGrus, Obss, CodCors, CodTams, Peso2s, Ps2FaseAnt) ;
                        VALUES (cursor_4c_OkNensI.Emps, cursor_4c_OkNensI.Dopps, ;
                            cursor_4c_OkNensI.Numps, cursor_4c_OkNensI.Nops, ;
                            cursor_4c_OkNensI.NEnvs, cursor_4c_OkNensI.CMats, ;
                            cursor_4c_OkNensI.CDescs, cursor_4c_OkNensI.Qtds, ;
                            cursor_4c_OkNensI.Qtds, cursor_4c_OkNensI.Pesos, ;
                            cursor_4c_OkNensI.Pesos, loc_lVisivel, loc_nRateio, ;
                            cursor_4c_OkNensI.TpOps, cursor_4c_OkNensI.Cats, .F., ;
                            cursor_4c_OkNensI.CUnis, cursor_4c_OkPro.CGrus, ;
                            cursor_4c_OkNensI.Obss, cursor_4c_OkNensI.CodCors, ;
                            cursor_4c_OkNensI.CodTams, cursor_4c_OkNensI.Peso2s, ;
                            cursor_4c_OkNensI.Peso2s)

                    IF loc_nSepPedras = 4
                        REPLACE QtFaseAnt WITH 0, PsFaseAnt WITH 0 IN (loc_cAliasNensiSaida)
                    ENDIF

                    IF loc_nAcEnvs = 1
                        IF ConverterParaLogico(cursor_4c_OkNensI.FlagIncs)
                            loc_cBMat   = cursor_4c_OkNensI.CMats
                            loc_cDMat   = cursor_4c_OkPro.DPros
                            loc_cCMat   = cursor_4c_OkPro.CUnis
                            loc_cGMat   = cursor_4c_OkPro.CGrus
                            loc_cCatMat = cursor_4c_OkNensI.Cats
                        ELSE
                            loc_cBMat   = SPACE(14)
                            loc_cDMat   = ""
                            loc_cCMat   = ""
                            loc_cGMat   = ""
                            loc_cCatMat = SPACE(3)
                        ENDIF
                        loc_cTMat = cursor_4c_OkNensI.TpOps

                        *-- legado: If (crSigCdOpd.CompAgrus = 1) -> _Nenv =
                        *-- 0 (encerra, pela reatribuicao da variavel de
                        *-- controle, esta volta do "Scan While")
                        IF loc_nCompAgrus = 1
                            loc_nNEnv = 0
                        ENDIF

                        IF loc_nRateio != 5
                            IF !SEEK(STR(loc_nNEnv, 10) + PADR(loc_cBMat, 14) + PADR(loc_cTMat, 15), ;
                                    loc_cAliasNensiSaida, "NEnvTpops")
                                INSERT INTO (loc_cAliasNensiSaida) ;
                                    (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
                                     Cats, TpOps, Servicos) ;
                                    VALUES (loc_nNEnv, loc_nNEnv, loc_cBMat, loc_cDMat, loc_cCMat, ;
                                        loc_cGMat, .T., 1, loc_cCatMat, loc_cTMat, loc_lServico)
                            ELSE
                                IF EVALUATE(loc_cAliasNensiSaida + ".Rateio") != 1
                                    REPLACE Rateio WITH 1 IN (loc_cAliasNensiSaida)
                                ENDIF
                            ENDIF

                            SELECT (loc_cAliasNensiSaida)
                            REPLACE QtFaseAnt WITH QtFaseAnt + cursor_4c_OkNensI.Qtds, ;
                                    PsFaseAnt WITH PsFaseAnt + cursor_4c_OkNensI.Pesos, ;
                                    Qtds      WITH Qtds + cursor_4c_OkNensI.Qtds, ;
                                    Pesos     WITH Pesos + cursor_4c_OkNensI.Pesos ;
                                IN (loc_cAliasNensiSaida)
                        ENDIF
                    ENDIF
                ENDIF

                *-- legado: If (InList(crSigCdOpd.SepPedras,1,3,4)) - garante
                *-- pelo menos 1 linha em xMFas/TmpOperacao por Nops, mesmo
                *-- quando SigPdMvf ainda nao tem fase lancada para ele
                IF INLIST(loc_nSepPedras, 1, 3, 4)
                    IF !SEEK(cursor_4c_OkNensI.Nops, loc_cAliasMFas, "Nops")
                        IF !THIS.GravarFaseAusente(cursor_4c_OkNensI.Nops, cursor_4c_OkNensI.Nenvs, ;
                                cursor_4c_OkNensI.Cunis)
                            SELECT cursor_4c_OkNensI
                            RETURN .F.
                        ENDIF
                    ENDIF

                    IF !SEEK((loc_nNumNivel * 10000000000) + EVALUATE(loc_cAliasMFas + ".NEnvs"), ;
                            loc_cAliasOperacao, "Codigos")
                        INSERT INTO (loc_cAliasOperacao) (Codigos, EmpDnPs, Autos) ;
                            VALUES ((loc_nNumNivel * 10000000000) + EVALUATE(loc_cAliasMFas + ".NEnvs"), ;
                                par_cChaveNens, .T.)
                    ENDIF
                ENDIF

                SELECT cursor_4c_OkNensI
            ENDSCAN

            IF !BOF("cursor_4c_OkNensI")
                SKIP -1 IN cursor_4c_OkNensI
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_OkNensI")
            USE IN cursor_4c_OkNensI
        ENDIF
        IF USED("cursor_4c_OkPro")
            USE IN cursor_4c_OkPro
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GravarFaseAusente - legado: bloco "If Not Seek(LocalNensI.Nops,
    * 'xMfas', 'Nops') ..." dentro do bloco final do "ok" - quando a Ordem
    * de Producao (Nops) do detalhe ainda NAO tem nenhuma linha em xMFas
    * (nenhuma fase SigPdMvf foi lancada para ela ainda), cria uma linha
    * "zero" so para garantir que xMFas/TmpOperacao enxerguem esse Nops.
    *
    * PROTECTED (regra #51). Le Emps/Dopps/Numps/Datas/Usuars/Grupoos/
    * Contaos/Grupods/Contads do cursor GLOBAL this_cCursorNecessidades -
    * ver nota de posicionamento no cabecalho de GravarDetalheEnvelopeFinal
    * (quem chama este metodo).
    *==========================================================================
    PROTECTED PROCEDURE GravarFaseAusente(par_nNops, par_nNenvs, par_cCunis)
        LOCAL loc_cAliasNec, loc_cSQL, loc_nResultado, loc_cEdn, loc_cCodPds, loc_nQtdeSoma

        loc_cAliasNec = THIS.this_cCursorNecessidades

        *-- legado: Select EmpDNPs, Emps, Dopps, Nops From SigOpPic Where
        *-- Nops = <nops> Order By EmpDNPs
        loc_cSQL = "SELECT EmpDNPs, Emps, Dopps, Nops FROM SigOpPic" + ;
            " WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0) + ;
            " ORDER BY EmpDNPs"

        IF USED("cursor_4c_OkDetOpi")
            USE IN cursor_4c_OkDetOpi
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkDetOpi")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpi)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkDetOpi
        GO TOP

        *-- legado: lcEdn = LocalOpi.Emps + LocalOpi.Dopps + Str(LocalOpi.
        *-- Nops, 10) - colunas CHAR fixas lidas direto do cursor (ja vem
        *-- com o padding do schema; PADR explicito eh so para STRING/
        *-- variavel - regra #42)
        loc_cEdn = cursor_4c_OkDetOpi.Emps + cursor_4c_OkDetOpi.Dopps + STR(cursor_4c_OkDetOpi.Nops, 10)

        IF USED("cursor_4c_OkDetOpi")
            USE IN cursor_4c_OkDetOpi
        ENDIF

        *-- legado: Select Nops, Qtds, Codpds From SigPdMvf Where EmpDNPs =
        *-- '<lcEdn>'
        loc_cSQL = "SELECT Nops, Qtds, Codpds FROM SigPdMvf WHERE EmpDNPs = " + EscaparSQL(loc_cEdn)

        IF USED("cursor_4c_OkDetMFas")
            USE IN cursor_4c_OkDetMFas
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkDetMFas")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalMFas)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkDetMFas
        GO TOP
        loc_cCodPds = cursor_4c_OkDetMFas.Codpds

        *-- legado: Sum Qtds To _Qtde While Nops = LocalNensI.Nops - o
        *-- filtro de EmpDNPs ja garante que TODA linha deste cursor tem o
        *-- MESMO Nops (codificado no proprio EmpDNPs) - equivalente a
        *-- somar o cursor INTEIRO
        loc_nQtdeSoma = 0
        SELECT cursor_4c_OkDetMFas
        SCAN WHILE Nops = par_nNops
            loc_nQtdeSoma = loc_nQtdeSoma + Qtds
        ENDSCAN

        IF USED("cursor_4c_OkDetMFas")
            USE IN cursor_4c_OkDetMFas
        ENDIF

        *-- legado: Insert Into xMFas (...) Values (CrSigCdNec.*, LocalNensI.
        *-- Nops/Nenvs, _Cpro, LocalNensI.Cunis, 0, _Qtde)
        INSERT INTO (THIS.this_cCursorMFas) ;
            (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, Grupods, ;
             Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds) ;
            VALUES (EVALUATE(loc_cAliasNec + ".Emps"), EVALUATE(loc_cAliasNec + ".Dopps"), ;
                EVALUATE(loc_cAliasNec + ".Numps"), EVALUATE(loc_cAliasNec + ".Datas"), ;
                EVALUATE(loc_cAliasNec + ".Datas"), EVALUATE(loc_cAliasNec + ".Usuars"), ;
                EVALUATE(loc_cAliasNec + ".Grupoos"), EVALUATE(loc_cAliasNec + ".Contaos"), ;
                EVALUATE(loc_cAliasNec + ".Grupods"), EVALUATE(loc_cAliasNec + ".Contads"), ;
                par_nNops, par_nNenvs, loc_cCodPds, par_cCunis, 0, loc_nQtdeSoma)

        RETURN .T.
    ENDPROC

ENDDEFINE
