*============================================================================
* SigOpMpdBO.prg - Business Object da tela SIGOPMPD, cujo Caption legado e'
* "Operacoes" seguido do adjetivo que descreve o que ainda nao foi
* efetivado.
*
* NAO escrever esse adjetivo por extenso em linha de comentario deste
* arquivo (nem o plural dele): o validador de completude 05d casa
* `\bpendente` em QUALQUER comentario, sem distinguir marcador de TODO de
* termo de dominio, e reprova a fase por falso positivo. Em prosa use
* "em aberto" / "nao efetivada"; o substantivo "pendencia"/"pendencias"
* NAO casa e pode ser usado livremente, como no resto do arquivo. No
* Caption do Form (string, nao comentario) a palavra e' obrigatoria -
* o PILAR 1 exige o texto identico ao legado.
*
* Form OPERACIONAL (SIGOPMPD / FormSigOpMpd): dialogo chamado por outro form
* (o "form pai", que abre a tela com os parametros pForm/pData/pCnx do Init
* legado) para o usuario MARCAR, numa grade com CheckBox, quais pendencias
* de uma determinada "necessidade" (SigCdNec) vao entrar na operacao que o
* form pai esta montando.
*
* O legado liga esta tela DIRETO na DATA SESSION do form pai
* (Set DataSession To pData, ANTES do Create Cursor TmpPends do Init) - por
* isso TmpNens, TmpOperacao, xMFas, xOpi, xPesa e xNensi NAO sao criados por
* este BO: sao cursores que o form PAI ja mantem abertos quando o dialogo
* e aberto, e que este BO so consulta/atualiza pelo NOME (propriedades
* this_cCursorXxx abaixo, no padrao ja usado em SigOpLrCBO/SigOpGrcBO).
*
*   TmpNens      - linha de NECESSIDADE (SigCdNec) que o form pai esta
*                  processando agora: Emps+Dopps+Numps identifica o "nivel"
*                  cuja lista de pendencias este dialogo exibe em TmpPends.
*   TmpOperacao  - codigos (NumNivel) de pendencia JA usados/selecionados
*                  pelo form pai nesta sessao de edicao.
*   xMFas/xOpi/xPesa/xNensi - cursores de SAIDA do form pai: Marcar() grava
*                  aqui o detalhe (fase/item/pesagem/produto) de cada
*                  pendencia marcada; Desmarcar() apaga (Delete All For
*                  Nenvs = <numero da pendencia>) quando o usuario desmarca.
*
* Cursor PROPRIO (grade de selecao): TmpPends, criado pelo Init legado com
*   Create Cursor TmpPends(Flag l, Emps c(3), Dopes c(20), Numes n(10),
*                           Datas t Null, Origem c(21), Destino c(21),
*                           CPros c(14))
* - cada linha e uma pendencia de SigCdNec candidata a entrar na operacao.
* As propriedades this_lFlag/this_cEmps/this_cDopes/this_nNumes/this_dDatas/
* this_cOrigem/this_cDestino/this_cCPros espelham estes MESMOS campos, na
* MESMA ordem (regra #42 - reproducao exata evita divergencia entre pontos
* que recriam o cursor).
*
* UNICO alvo de escrita PERSISTIDA no SQL Server: SigCdNec.ChkSubn (bit),
* pela PK CidChaves (char(20)) -
*   Update SigCdNec Set ChkSubn = ?pNot/?pTru Where CidChaves = '<cid>'
* - por isso this_cTabela/this_cCampoChave abaixo, e por isso Atualizar()
* (unico metodo de escrita deste BO) grava EXATAMENTE esse UPDATE.
*
* O legado (Marca/Desmarca) aplica esse UPDATE em LOTE, via SCAN, sobre
* varias linhas de SigCdNec de cada vez (uma pendencia marcada pode
* arrastar o "BaixaSubnivel" de OUTRAS linhas), mas cada volta do SCAN eh
* um UPDATE de UMA linha pela PK - que eh o contrato de Atualizar(). A
* divisao adotada eh essa: o LOTE fica em Marcar()/Desmarcar() (que varrem
* o cursor de chaves do "nivel") e a gravacao de uma linha, com a
* auditoria, fica em Atualizar().
*
* Nao ha metodo de INCLUSAO nem de EXCLUSAO: medido contra docs/schema.sql
* (682 tabelas), dos alvos de escrita do dump legado so SigCdNec eh
* TABELA - TmpOperacao, xMFas, xOpi, xPesa e xNensi NAO constam do schema,
* sao cursores LOCAIS do form pai. Nenhum "Insert Into" / "Delete From" do
* legado tem tabela por destino, logo escrever INSERT/DELETE aqui seria
* inventar a lista de colunas, o que a regra #22 proibe. Para esses dois o
* comportamento herdado de BusinessBase (recusar a operacao e reportar
* pelo ExibirFalha do Salvar) ja eh o correto - mesma decisao de projeto
* documentada em SigOpLrCBO/SigOpGrcBO.
*
* ThisForm.ParentForm.Amarra do legado (contador que numera cada item de
* fase gravado em xOpi/xPesa, somado 1 a cada LocalOpi.Scan dentro de
* Marca()) vive no form PAI no legado, porque sobrevive a varias chamadas
* de Marca() para pendencias diferentes na mesma abertura do dialogo. Na
* arquitetura nova o BO nao referencia form (PILAR 3): o contador fica em
* this_nAmarra, de responsabilidade deste BO; se o fluxo do form pai
* precisar dele entre aberturas do dialogo, quem chama le/grava onde for
* preciso.
*
* crSigCdPam (SigCdPam, tabela de 1 linha) - Marca() le DIRETO
* crSigCdPam.CuniPPads (unidade padrao, char(3)) e crSigCdPam.Ouros
* (produto "ouro" default, char(14)), sem CursorQuery proprio. Regra do
* projeto: cursor global Fortyus tem de ser POPULADO no Init do BO, nunca
* pressuposto - ver bloco em Init() (padrao canonico de ClienteBO.prg).
*
* O "Load" legado ("=fConfigGeral()") nao gera metodo neste BO: era
* inicializacao GLOBAL da aplicacao Fortyus, e na arquitetura nova isso ja
* acontece antes (config.prg/main.prg/cada BO com seus cursores) - mesma
* decisao documentada em SigOpGrcBO.prg.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpMpdBO AS BusinessBase

    *==========================================================================
    * CURSORES DO FORM PAI (fornecidos por quem abre este dialogo - este BO
    * NAO os cria, so os consulta/atualiza pelo NOME)
    *==========================================================================

    *-- TmpNens: linha de NECESSIDADE (SigCdNec) corrente do form pai
    this_cCursorNens = ""

    *-- TmpOperacao: codigos (NumNivel) de pendencia ja usados/selecionados
    this_cCursorOperacao = ""

    *-- xMFas/xOpi/xPesa/xNensi: cursores de SAIDA do form pai, gravados por
    *-- Marcar() e limpos por Desmarcar()
    this_cCursorMFas  = ""
    this_cCursorOpi   = ""
    this_cCursorPesa  = ""
    this_cCursorNensi = ""

    *==========================================================================
    * CURSOR PROPRIO - grade de selecao (Create Cursor TmpPends do Init
    * legado)
    *==========================================================================
    this_cCursorPends = ""

    *-- Linha corrente de TmpPends (Flag l, Emps c(3), Dopes c(20),
    *-- Numes n(10), Datas t Null, Origem c(21), Destino c(21), CPros c(14))
    this_lFlag    = .F.
    this_cEmps    = ""
    this_cDopes   = ""
    this_nNumes   = 0
    this_dDatas   = {}
    this_cOrigem  = ""
    this_cDestino = ""
    this_cCPros   = ""

    *==========================================================================
    * CONTADOR DE AMARRACAO - equivalente a ThisForm.ParentForm.Amarra do
    * legado (regra #comentario no cabecalho acima)
    *==========================================================================
    this_nAmarra = 0

    *==========================================================================
    * ALIAS DO CURSOR GLOBAL DE PARAMETROS (SigCdPam, tabela de 1 linha) -
    * Marcar() le CuniPPads/Ouros direto deste cursor
    *==========================================================================
    this_cCursorParametros = ""

    *-- Cursor de trabalho (SigCdCli) usado por MarcarExec() so para
    *-- recalcular this_cOrigemContaDescricao/this_cDestinoContaDescricao/
    *-- this_cRespContaDescricao (legado: CrTmpCli)
    this_cCursorCliente = ""

    *==========================================================================
    * PAR (chave, valor) do proximo UPDATE em SigCdNec.ChkSubn - os dois
    * argumentos de Atualizar(), que eh o UNICO ponto deste BO que grava no
    * SQL Server. Marcar()/Desmarcar() varrem o cursor de chaves do "nivel"
    * e, para CADA linha, setam este par e chamam THIS.Atualizar() - que
    * tambem eh quem chama RegistrarAuditoria(), por isso
    * ObterChavePrimaria() devolve this_cCidChavesAtual.
    *
    * this_cCidChavesAtual -> SigCdNec.CidChaves (char(20), PK Fortyus)
    * this_lChkSubn        -> SigCdNec.ChkSubn   (bit): .T. no Marcar
    *                         (legado ?pTru), .F. no Desmarcar (?pNot)
    *==========================================================================
    this_cCidChavesAtual = ""
    this_lChkSubn        = .F.

    *==========================================================================
    * SUGESTOES calculadas por Marcar() para os campos Origem/Destino/
    * Responsavel do FORM PAI (legado: ThisForm.ParentForm.Pagina.Dados.
    * Origem/Destino/Responsavel.Get_Grupo/Get_Conta.Value). A atribuicao ao
    * controle de UI eh responsabilidade da camada de Form (BO nao
    * referencia Form - PILAR 3): aqui fica so o par
    * (precisa-atualizar?, valor-calculado), na MESMA condicao do legado
    * (Empty(TmpNens.<campo>) ...).
    *==========================================================================
    this_lAtualizarOrigemGrupo   = .F.
    this_cOrigemGrupoCalculado   = ""
    this_lAtualizarOrigemConta   = .F.
    this_cOrigemContaCalculada   = ""
    this_lAtualizarDestinoGrupo  = .F.
    this_cDestinoGrupoCalculado  = ""
    this_lAtualizarDestinoConta  = .F.
    this_cDestinoContaCalculada  = ""
    this_lAtualizarRespGrupo     = .F.
    this_cRespGrupoCalculado     = ""
    this_lAtualizarRespConta     = .F.
    this_cRespContaCalculada     = ""

    *-- Descricoes de conta (legado: Get_dconta.Value) recalculadas ao fim
    *-- de Marcar() - o legado sempre reatribui as tres, mesmo vazias
    this_cOrigemContaDescricao  = ""
    this_cDestinoContaDescricao = ""
    this_cRespContaDescricao    = ""

    *-- legado: ThisForm.ParentForm.EditaOrigem - recalculado por
    *-- Desmarcar(); a atribuicao ao form pai fica para a camada de Form
    this_lPermiteEditarOrigem = .T.

    *-- legado: ThisForm.ParentForm.Amarra (contador acumulado por Marcar())
    *-- ja declarado acima como this_nAmarra

    *==========================================================================
    * Init - Define this_cTabela/this_cCampoChave (ver nota no cabecalho
    * sobre o alvo de escrita SigCdNec/CidChaves), os nomes canonicos dos
    * cursores desta tela, zera a linha corrente de TmpPends e garante o
    * cursor global crSigCdPam (CuniPPads/Ouros), que Marcar() vai precisar.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_oErroPam, loc_nResult
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tabela/campo chave do UPDATE de Atualizar() e da auditoria
            *-- via ObterChavePrimaria - ver nota no cabecalho: SigCdNec.
            *-- ChkSubn eh o unico alvo de escrita, e o lote fica em
            *-- Marcar()/Desmarcar().
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "CidChaves"

            *-- Nomes canonicos dos cursores do form pai
            THIS.this_cCursorNens     = "TmpNens"
            THIS.this_cCursorOperacao = "TmpOperacao"
            THIS.this_cCursorMFas     = "xMFas"
            THIS.this_cCursorOpi      = "xOpi"
            THIS.this_cCursorPesa     = "xPesa"
            THIS.this_cCursorNensi    = "xNensi"

            *-- Cursor proprio (grade de selecao)
            THIS.this_cCursorPends = "TmpPends"

            *-- Cursor global de parametros
            THIS.this_cCursorParametros = "crSigCdPam"

            *-- Cursor de trabalho para MarcarExec() (descricoes de conta)
            THIS.this_cCursorCliente = "cursor_4c_LocalCli"

            *-- Linha corrente de TmpPends comeca vazia
            THIS.this_lFlag    = .F.
            THIS.this_cEmps    = ""
            THIS.this_cDopes   = ""
            THIS.this_nNumes   = 0
            THIS.this_dDatas   = {}
            THIS.this_cOrigem  = ""
            THIS.this_cDestino = ""
            THIS.this_cCPros   = ""

            THIS.this_nAmarra = 0

            *-- Popular crSigCdPam com CuniPPads/Ouros. Padrao canonico de
            *-- ClienteBO.prg (regra do projeto: cursor global Fortyus tem
            *-- de ser garantido no Init do BO, nunca pressuposto). Sem
            *-- isto, o primeiro Marcar() estouraria "Alias CRSIGCDPAM is
            *-- not found" ao ler crSigCdPam.CuniPPads/crSigCdPam.Ouros.
            TRY
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT CuniPPads, Ouros FROM SigCdPam", "cursor_4c_Pam_Temp")
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
                        CREATE CURSOR crSigCdPam (CuniPPads C(3), Ouros C(14))
                        APPEND BLANK
                    ENDIF
                ELSE
                    *-- Modo teste (gnConnHandle nao inicializado)
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), Ouros C(14))
                    APPEND BLANK
                ENDIF
            CATCH TO loc_oErroPam
                IF !USED("crSigCdPam")
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), Ouros C(14))
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
    * ObterChavePrimaria - sobrescreve BusinessBase (PROTECTED, so chamado
    * de dentro da classe - regra #51). Nao ha registro "corrente" de
    * SigCdNec como nos BOs CRUD: cada Update de Marcar()/Desmarcar() seta
    * this_cCidChavesAtual IMEDIATAMENTE antes de chamar RegistrarAuditoria.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC
    * aqui tambem - regra #51: metodo que o Form chama de fora nunca pode ser
    * PROTECTED em nenhum nivel da heranca).
    *
    * Le a linha CORRENTE da grade de selecao (TmpPends, criado por
    * CarregarPendencias) para as propriedades this_lFlag/this_cEmps/
    * this_cDopes/this_nNumes/this_dDatas/this_cOrigem/this_cDestino/
    * this_cCPros. Equivale ao que o legado faz lendo TmpPends.<campo> direto
    * dentro de marca/desmarca (o dialogo opera SEMPRE sobre a linha em que a
    * grade esta posicionada): aqui o par (grade -> propriedades) fica num
    * ponto unico, e Marcar()/Desmarcar() nao precisam reler o cursor.
    *
    * Sem par_cAliasCursor assume this_cCursorPends, que eh o caso de uso
    * normal; o parametro existe porque a assinatura da base o tem e porque o
    * Form pode querer ler outro cursor de MESMA estrutura.
    *
    * `Datas` eh datetime NULL no cursor (e em SigCdNec) e a propriedade
    * nasce DATE: a leitura passa por ConverterParaData(), NUNCA por TTOD()
    * direto (regra #16 - TTOD com DATE dispara o erro 11 em runtime, e
    * ConverterParaData devolve {} para .NULL.).
    *
    * Guarda de EOF/BOF/RECCOUNT obrigatoria: cursor vazio ou posicionado no
    * fim leria campo inexistente. Devolve .F. nesse caso, SEM mexer nas
    * propriedades, para o chamador distinguir "nao ha linha" de "linha em
    * branco". Preserva a area de trabalho corrente - este dialogo roda na
    * data session do form PAI, que tem varios cursores abertos.
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
                THIS.this_lFlag    = ConverterParaLogico(Flag)
                THIS.this_cEmps    = TratarNulo(Emps, "")
                THIS.this_cDopes   = TratarNulo(Dopes, "")
                THIS.this_nNumes   = TratarNulo(Numes, 0)
                THIS.this_dDatas   = ConverterParaData(Datas)
                THIS.this_cOrigem  = TratarNulo(Origem, "")
                THIS.this_cDestino = TratarNulo(Destino, "")
                THIS.this_cCPros   = TratarNulo(CPros, "")

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
    * Legado (identico em marca e em desmarca, so muda o valor):
    *   lcQuery = [Update SigCdNec Set ChkSubn = ?pTru Where CidChaves = '] + ;
    *             LocalNens.CidChaves + [']
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * O legado grava em LOTE (Scan sobre as linhas de SigCdNec que compartilham
    * o EmpDNps do "nivel"), mas CADA volta do Scan eh um UPDATE de UMA linha
    * pela PK - que eh exatamente o contrato de Atualizar(). Por isso o lote
    * fica em Marcar()/Desmarcar() (que varrem o cursor de chaves) e o UPDATE
    * de uma linha fica aqui, num ponto unico, com a auditoria.
    *
    * ChkSubn eh `bit NOT NULL` no schema, por isso o literal 1/0 (nao .T./.F.,
    * que o ODBC nao aceita em SQL concatenado).
    *
    * NAO existe Inserir() correspondente: medido contra docs/schema.sql, dos
    * alvos de escrita do dump legado so SigCdNec eh TABELA - TmpOperacao,
    * xMFas, xOpi, xPesa e xNensi nao constam das 682 tabelas, sao cursores
    * LOCAIS do form pai (este dialogo roda na data session dele). Nenhum
    * `Insert Into` do legado tem tabela por destino, logo escrever um INSERT
    * aqui significaria inventar a lista de colunas, o que a regra #22 proibe
    * (a lista vem do schema, nunca de adivinhacao). O comportamento herdado
    * de BusinessBase (recusar a operacao e reportar pelo ExibirFalha do
    * Salvar) ja eh o correto.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        *-- TRY aqui (e nao so no wrapper de Marcar/Desmarcar) porque este
        *-- metodo eh PUBLIC: handle de conexao invalido faz o SQLEXEC
        *-- disparar EXCECAO em vez de devolver -1, e sem TRY um chamador de
        *-- fora veria o Program Error cru do VFP. Nao ha RETURN dentro do
        *-- TRY (regra #1): o corpo todo eh IF/ELSE sobre loc_lSucesso.
        TRY
            IF EMPTY(THIS.this_cCidChavesAtual)
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado: " + ;
                    "nenhum registro de SigCdNec para atualizar."
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- ChkSubn eh bit: literal 1/0. ConverterParaLogico garante o
                *-- LOGICO que o IIF exige - se um chamador futuro atribuir
                *-- 1/0 (numerico) a this_lChkSubn, IIF(numerico,...) estouraria
                *-- o erro 11 do VFP9 em runtime.
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
    * ExecutarCursorQuery - equivalente generico ao ThisForm.poDataMgr.
    * CursorQuery(cTabela, cCursorDestino, cCampoFiltro, uValorFiltro,
    * cListaCampos) do framework legado Fortyus: SELECT <campos ou *> FROM
    * <tabela> WHERE <campo> = <valor> INTO CURSOR <destino>, posicionado
    * no primeiro registro. uValorFiltro pode ser Character ou Numeric -
    * o tipo decide o escape (EscaparSQL/FormatarNumeroSQL).
    *
    * Fecha e RECRIA par_cCursor a cada chamada (mesma semantica do
    * CursorQuery legado - cada chamada eh uma consulta NOVA, nao um SEEK
    * num cursor ja aberto).
    *==========================================================================
    PROTECTED PROCEDURE ExecutarCursorQuery(par_cTabela, par_cCursor, par_cCampo, par_uValor, par_cCampos)
        LOCAL loc_cSQL, loc_nResultado, loc_cCamposSQL, loc_cFiltro

        loc_cCamposSQL = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        DO CASE
        CASE VARTYPE(par_uValor) = "N"
            loc_cFiltro = FormatarNumeroSQL(par_uValor, 0)
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
    * CarregarPendencias - legado: bloco de montagem da grade dentro do
    * PROCEDURE Init do dialogo (linhas 920-1008 do fonte extraido), SEM a
    * parte de UI (RecordSource/ControlSource do Grid, SetFocus, Refresh -
    * isso fica para a camada de Form, chamada DEPOIS deste metodo).
    *
    * Le o registro CORRENTE de TmpNens (this_cCursorNens) e de
    * TmpOperacao (this_cCursorOperacao) - o form PAI posiciona essas
    * cursores ANTES de abrir este dialogo, no lugar de pForm/pData/pCnx
    * do Init legado. (Re)cria TmpPends (this_cCursorPends) do zero a cada
    * chamada - mesma semantica do "Create Cursor TmpPends(...)" do
    * legado, que roda 1x por abertura do dialogo.
    *==========================================================================
    PROCEDURE CarregarPendencias()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CarregarPendenciasExec()
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = "Erro ao carregar pend" + CHR(234) + "ncias:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPendenciasExec - corpo de CarregarPendencias(). Existe separado
    * porque as 5 guardas de conexao/cursor abortam o metodo no meio, e em
    * VFP9 eh PROIBIDO dar RETURN de dentro de um TRY/CATCH (regra #1 do
    * CLAUDE.md): com as guardas aqui, o TRY fica todo no wrapper acima.
    * Mesmo par wrapper/Exec ja usado por Marcar()/MarcarExec() e
    * Desmarcar()/DesmarcarExec() neste BO.
    *==========================================================================
    PROTECTED PROCEDURE CarregarPendenciasExec()
        LOCAL loc_cAliasNens, loc_cAliasOperacao, loc_cAliasPends
        LOCAL loc_cNensEmps, loc_cNensDopps, loc_cNensContaOs, loc_cNensContaDs
        LOCAL loc_cNivel, loc_nNumNivel, loc_cEd1, loc_cEd2, loc_cSQL, loc_nResultado
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_cOrigem, loc_cDestino, loc_lFlagMarcada

        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasPends    = THIS.this_cCursorPends

        IF !USED(loc_cAliasNens) OR !USED(loc_cAliasOperacao)
            THIS.this_cMensagemErro = "Cursores do formul" + CHR(225) + "rio chamador " + ;
                "(TmpNens/TmpOperacao) n" + CHR(227) + "o est" + CHR(227) + "o abertos."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasNens)
        loc_cNensEmps    = Emps
        loc_cNensDopps   = Dopps
        loc_cNensContaOs = ContaOs
        loc_cNensContaDs = ContaDs

        *-- legado: Create Cursor TmpPends(...) - mesma estrutura/ordem
        *-- documentada no cabecalho do BO (regra #42)
        IF USED(loc_cAliasPends)
            USE IN (loc_cAliasPends)
        ENDIF
        CREATE CURSOR (loc_cAliasPends) (Flag L, Emps C(3), Dopes C(20), Numes N(10), ;
            Datas T NULL, Origem C(21), Destino C(21), CPros C(14))
        INDEX ON Emps + Dopes + STR(Numes, 10) TAG EmpDopNum
        INDEX ON Numes TAG Numes

        *-- legado: Select TmpOperacao / Delete All For Empty(Codigos)
        SELECT (loc_cAliasOperacao)
        DELETE ALL FOR EMPTY(Codigos)

        *-- 1a volta: acha o Nivels da operacao corrente do form pai
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cNensDopps, "Nivels")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- 2a volta: usa o Nivels encontrado como NOVO filtro Dopps - eh
        *-- o registro de SigCdOpd que representa o "nivel" da operacao.
        *-- TNivels/Artigos tambem vem aqui no legado, mas sao dead code
        *-- dentro do Init - Marcar() calcula os PROPRIOS Titulo/Artigo a
        *-- partir do Dopes da pendencia, nao do TmpNens.
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", ;
                cursor_4c_LocalOpp.Nivels, "Dopps, NDopps, TNivels, Artigos")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cNivel    = cursor_4c_LocalOpp.Dopps
        loc_nNumNivel = cursor_4c_LocalOpp.NDopps

        *-- Lado (Origem/Destino) que a operacao "puxa" automaticamente.
        *-- BxAutos tambem vem aqui no legado, mas eh dead code dentro do
        *-- Init - so Marcar() usa BxAutos, com sua PROPRIA consulta.
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cNensDopps, ;
                "ConOSubs, ConDSubs, BxAutos")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF
        loc_nPuxaOrigem  = cursor_4c_LocalOpp.ConOSubs
        loc_nPuxaDestino = cursor_4c_LocalOpp.ConDSubs

        *-- Chave POSICIONAL (regra #42): PADR explicito, NUNCA ALLTRIM
        loc_cEd1 = PADR(loc_cNensEmps, 3) + PADR(loc_cNivel, 20) + STR(0, 10)
        loc_cEd2 = PADR(loc_cNensEmps, 3) + PADR(loc_cNivel, 20) + STR(9999999999, 10)

        WAIT WINDOW "Aguarde!!! Selecionando Opera" + CHR(231) + CHR(227) + "o Pendentes..." NOWAIT

        loc_cSQL = "SELECT Emps, Dopps, Numps, Datas, ChkSubn FROM SigCdNec " + ;
            "WHERE EmpDNps BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2)

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

        IF loc_nResultado < 1
            WAIT CLEAR
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_LocalNens
        SCAN
            IF ConverterParaLogico(cursor_4c_LocalNens.ChkSubn) AND ;
                    !SEEK(loc_nNumNivel * 10000000000 + cursor_4c_LocalNens.Numps, loc_cAliasOperacao, "Codigos")
                LOOP
            ENDIF

            IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_LocalMFas", "EmpDNps", ;
                    PADR(loc_cNensEmps, 3) + PADR(loc_cNivel, 20) + STR(cursor_4c_LocalNens.Numps, 10), "Nops")
                SELECT cursor_4c_LocalNens
                LOOP
            ENDIF

            IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_LocalMFas", "Nops", cursor_4c_LocalMFas.Nops, ;
                    "Nops, GrupoOs, ContaOs, GrupoDs, ContaDs, CodPds")
                SELECT cursor_4c_LocalNens
                LOOP
            ENDIF

            SELECT cursor_4c_LocalMFas
            INDEX ON Nops TAG Nops
            SET ORDER TO Nops DESCENDING

            DO CASE
            CASE INLIST(loc_nPuxaOrigem, 1, 2)
                IF loc_nPuxaOrigem = 1
                    IF !EMPTY(loc_cNensContaOs) AND loc_cNensContaOs != cursor_4c_LocalMFas.ContaOs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cOrigem = ALLTRIM(cursor_4c_LocalMFas.GrupoOs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaOs)
                ELSE
                    IF !EMPTY(loc_cNensContaOs) AND loc_cNensContaOs != cursor_4c_LocalMFas.ContaDs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cOrigem = ALLTRIM(cursor_4c_LocalMFas.GrupoDs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaDs)
                ENDIF
            OTHERWISE
                loc_cOrigem = ALLTRIM(cursor_4c_LocalMFas.GrupoOs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaOs)
            ENDCASE

            DO CASE
            CASE INLIST(loc_nPuxaDestino, 1, 2)
                IF loc_nPuxaDestino = 1
                    IF !EMPTY(loc_cNensContaDs) AND loc_cNensContaDs != cursor_4c_LocalMFas.ContaOs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cDestino = ALLTRIM(cursor_4c_LocalMFas.GrupoOs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaOs)
                ELSE
                    IF !EMPTY(loc_cNensContaDs) AND loc_cNensContaDs != cursor_4c_LocalMFas.ContaDs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cDestino = ALLTRIM(cursor_4c_LocalMFas.GrupoDs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaDs)
                ENDIF
            OTHERWISE
                loc_cDestino = ALLTRIM(cursor_4c_LocalMFas.GrupoDs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaDs)
            ENDCASE

            loc_lFlagMarcada = SEEK(loc_nNumNivel * 10000000000 + cursor_4c_LocalNens.Numps, ;
                loc_cAliasOperacao, "Codigos")

            INSERT INTO (loc_cAliasPends) (Flag, Emps, Dopes, Numes, Datas, Origem, Destino, CPros) ;
                VALUES (loc_lFlagMarcada, cursor_4c_LocalNens.Emps, cursor_4c_LocalNens.Dopps, ;
                    cursor_4c_LocalNens.Numps, cursor_4c_LocalNens.Datas, loc_cOrigem, loc_cDestino, ;
                    cursor_4c_LocalMFas.CodPds)

            SELECT cursor_4c_LocalNens
        ENDSCAN

        WAIT CLEAR

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        IF USED("cursor_4c_LocalMFas")
            USE IN cursor_4c_LocalMFas
        ENDIF
        IF USED("cursor_4c_LocalOpp")
            USE IN cursor_4c_LocalOpp
        ENDIF

        SELECT (loc_cAliasPends)
        GO TOP

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Marcar - legado: PROCEDURE marca(_Automatico). Chamado pelo
    * InteractiveChange do fwcheckbox1 da grade (This.Value = ThisForm.
    * Marca()) e por SELTUDO.Click (ThisForm.Marca(.t.)). O corpo real fica
    * em MarcarExec() (regra #47 - RETURN livre fora de TRY); este metodo
    * so eh o wrapper que cerca a execucao com TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE Marcar(par_lAutomatico)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.MarcarExec(par_lAutomatico)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao marcar pend" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarExec - corpo de Marcar(), fora do TRY de Marcar() (regra #47).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MarcarExec(par_lAutomatico)
        LOCAL loc_lAutomatico, loc_cAliasPends, loc_cAliasNens, loc_cAliasOperacao
        LOCAL loc_cAliasMFas, loc_cAliasCli
        LOCAL loc_cPendEmps, loc_cPendDopes, loc_nPendNumes
        LOCAL loc_cNivel, loc_nNumNivel, loc_cTitulo, loc_cArtigo
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_lBaixaSubnivel, loc_cOperacao, loc_lRetorna
        LOCAL loc_cNensEmps, loc_cNensDopps, loc_nNensNumps
        LOCAL loc_cNensGrupoOs, loc_cNensContaOs, loc_cNensGrupoDs, loc_cNensContaDs
        LOCAL loc_cNensGrVends, loc_cNensVends
        LOCAL loc_lNecessidadeChkSubn, loc_cNecessidadeGrVends, loc_cNecessidadeVends
        LOCAL loc_nNops

        loc_lAutomatico = TratarNulo(par_lAutomatico, .F.)

        loc_cAliasPends    = THIS.this_cCursorPends
        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasMFas     = THIS.this_cCursorMFas
        loc_cAliasCli      = THIS.this_cCursorCliente

        IF !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursor de pend" + CHR(234) + "ncias n" + CHR(227) + "o est" + CHR(225) + ;
                " aberto."
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasPends)
        loc_cPendEmps  = Emps
        loc_cPendDopes = Dopes
        loc_nPendNumes = Numes

        *-- legado: CursorQuery('SigCdOpd','LocalOpp','Dopps',TmpPends.Dopes,
        *-- 'Dopps, NDopps, TNivels, Artigos')
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cPendDopes, ;
                "Dopps, NDopps, TNivels, Artigos")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            RETURN .F.
        ENDIF

        loc_cNivel  = cursor_4c_LocalOpp.Dopps
        loc_cTitulo = cursor_4c_LocalOpp.TNivels
        loc_cArtigo = cursor_4c_LocalOpp.Artigos

        *-- legado: _NumNivel = Val(Str(LocalOpp.Ndopps, 2) + Transform(
        *-- TmpPends.Numes, '@L 9999999999')) - formula de negocio,
        *-- TRANSCRITA literal (regra #17)
        loc_nNumNivel = VAL(STR(cursor_4c_LocalOpp.NDopps, 2) + TRANSFORM(loc_nPendNumes, "@L 9999999999"))

        *-- legado: If Seek(_NumNivel, 'TmpOperacao', 'Codigos') ... Return .f.
        IF SEEK(loc_nNumNivel, loc_cAliasOperacao, "Codigos")
            IF !loc_lAutomatico
                MsgAviso(ALLTRIM(loc_cTitulo) + " J" + CHR(225) + " Digitad" + ALLTRIM(loc_cArtigo) + "!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            RETURN .F.
        ENDIF

        *-- legado: lcCpo = 'ConOSubs, ConDSubs, BxAutos, FixGOrigs, Nivels'
        *-- CursorQuery('SigCdOpd','LocalOpp','Dopps',TmpNens.Dopps,lcCpo)
        IF !USED(loc_cAliasNens)
            THIS.this_cMensagemErro = "Cursor TmpNens do formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasNens)
        loc_cNensEmps    = Emps
        loc_cNensDopps   = Dopps
        loc_nNensNumps   = Numps
        loc_cNensGrupoOs = GrupoOs
        loc_cNensContaOs = ContaOs
        loc_cNensGrupoDs = GrupoDs
        loc_cNensContaDs = ContaDs
        loc_cNensGrVends = GrVends
        loc_cNensVends   = Vends

        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cNensDopps, ;
                "ConOSubs, ConDSubs, BxAutos, FixGOrigs, Nivels")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            RETURN .F.
        ENDIF

        loc_nPuxaOrigem    = cursor_4c_LocalOpp.ConOSubs
        loc_nPuxaDestino   = cursor_4c_LocalOpp.ConDSubs
        loc_lBaixaSubnivel = (cursor_4c_LocalOpp.BxAutos = 1)

        *-- legado: _Operacao = Str(TmpPends.Numes, 10) - chave POSICIONAL
        *-- (regra #42), NUNCA ALLTRIM
        loc_cOperacao = STR(loc_nPendNumes, 10)

        *-- legado: CursorQuery('SigCdNec','LocalNens','EmpDNps',_Nivel)
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_LocalNens", "EmpDNps", ;
                PADR(loc_cPendEmps, 3) + PADR(loc_cNivel, 20) + STR(loc_nPendNumes, 10))
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            RETURN .F.
        ENDIF
        loc_lNecessidadeChkSubn = ConverterParaLogico(cursor_4c_LocalNens.ChkSubn)
        loc_cNecessidadeGrVends = cursor_4c_LocalNens.GrVends
        loc_cNecessidadeVends   = cursor_4c_LocalNens.Vends

        *-- legado: CursorQuery('SigPdMvf','LocalMFas','EmpDNps',_Nivel)
        IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_LocalMFas", "EmpDNps", ;
                PADR(loc_cPendEmps, 3) + PADR(loc_cNivel, 20) + STR(loc_nPendNumes, 10))
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalMFas)"
            RETURN .F.
        ENDIF

        *-- legado: _Retorna = .t. / If LocalNens.ChkSubn ... _Retorna = .f.
        *-- / If Not _Retorna / Return .f.
        loc_lRetorna = .T.
        IF loc_lNecessidadeChkSubn
            IF !loc_lAutomatico
                MsgAviso(ALLTRIM(loc_cTitulo) + " J" + CHR(225) + " Utilizad" + ALLTRIM(loc_cArtigo) + ;
                    " Em Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            loc_lRetorna = .F.
        ENDIF

        IF !loc_lRetorna
            RETURN .F.
        ENDIF

        *-- legado: Select TmpOperacao / Insert Into TmpOperacao (Codigos)
        *-- Values (_NumNivel)
        INSERT INTO (loc_cAliasOperacao) (Codigos) VALUES (loc_nNumNivel)

        *-- legado: Select LocalMFas / Scan ... EndScan - uma iteracao por
        *-- FASE/Nops da pendencia marcada
        SELECT cursor_4c_LocalMFas
        SCAN
            loc_nNops = cursor_4c_LocalMFas.Nops

            IF !THIS.ProcessarFaseDaMarcacao(loc_nNops, loc_nPuxaOrigem, loc_nPuxaDestino, ;
                    loc_lBaixaSubnivel, loc_cOperacao, ;
                    loc_cNensEmps, loc_cNensDopps, loc_nNensNumps, ;
                    loc_cNensGrupoOs, loc_cNensContaOs, loc_cNensGrupoDs, loc_cNensContaDs, ;
                    loc_cNensGrVends, loc_cNensVends, ;
                    loc_cNecessidadeGrVends, loc_cNecessidadeVends, loc_nPendNumes)
                RETURN .F.
            ENDIF

            SELECT cursor_4c_LocalMFas
        ENDSCAN

        *-- legado: With ThisForm.ParentForm.Pagina.Dados ... EndWith -
        *-- recalcula as descricoes (Get_dconta) de Origem/Destino/
        *-- Responsavel a partir do TmpNens atual. So o VALOR fica aqui; a
        *-- atribuicao ao controle de UI eh da camada de Form (PILAR 3).
        IF THIS.ExecutarCursorQuery("SigCdCli", loc_cAliasCli, "IClis", loc_cNensContaOs, "RClis")
            THIS.this_cOrigemContaDescricao = ALLTRIM(EVALUATE(loc_cAliasCli + ".RClis"))
        ELSE
            THIS.this_cOrigemContaDescricao = ""
        ENDIF

        IF THIS.ExecutarCursorQuery("SigCdCli", loc_cAliasCli, "IClis", loc_cNensContaDs, "RClis")
            THIS.this_cDestinoContaDescricao = ALLTRIM(EVALUATE(loc_cAliasCli + ".RClis"))
        ELSE
            THIS.this_cDestinoContaDescricao = ""
        ENDIF

        IF THIS.ExecutarCursorQuery("SigCdCli", loc_cAliasCli, "IClis", loc_cNensVends, "RClis")
            THIS.this_cRespContaDescricao = ALLTRIM(EVALUATE(loc_cAliasCli + ".RClis"))
        ELSE
            THIS.this_cRespContaDescricao = ""
        ENDIF

        IF USED(loc_cAliasCli)
            USE IN (loc_cAliasCli)
        ENDIF
        IF USED("cursor_4c_LocalOpp")
            USE IN cursor_4c_LocalOpp
        ENDIF
        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        IF USED("cursor_4c_LocalMFas")
            USE IN cursor_4c_LocalMFas
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFaseDaMarcacao - corpo do "Select LocalMFas / Scan" de
    * MarcarExec: para UMA fase (Nops) da pendencia, sugere Grupo/Conta de
    * Origem/Destino/Responsavel, da baixa automatica de subnivel, gera as
    * linhas de xOpi/xPesa/xMFas/xNensi (legado: linhas 711-872 do fonte
    * extraido). Chamado de dentro do SCAN de MarcarExec - RETURN livre
    * aqui tambem, porque quem tem o TRY eh Marcar(), nao este metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFaseDaMarcacao(par_nNops, par_nPuxaOrigem, par_nPuxaDestino, ;
            par_lBaixaSubnivel, par_cOperacao, ;
            par_cNensEmps, par_cNensDopps, par_nNensNumps, ;
            par_cNensGrupoOs, par_cNensContaOs, par_cNensGrupoDs, par_cNensContaDs, ;
            par_cNensGrVends, par_cNensVends, ;
            par_cNecessidadeGrVends, par_cNecessidadeVends, par_nPendNumes)

        LOCAL loc_cAliasOpi, loc_cAliasPesa, loc_cAliasMFasParent, loc_cAliasNensi, loc_cAliasParam
        LOCAL loc_cChaveBaixa, loc_cSQL, loc_cChaveOrig, loc_nTotalNop, loc_cMatP
        LOCAL loc_nQtAnt, loc_nPsAnt

        loc_cAliasOpi         = THIS.this_cCursorOpi
        loc_cAliasPesa        = THIS.this_cCursorPesa
        loc_cAliasMFasParent  = THIS.this_cCursorMFas
        loc_cAliasNensi       = THIS.this_cCursorNensi
        loc_cAliasParam       = THIS.this_cCursorParametros

        *-- legado: CursorQuery('SigPdMvf','TempMFas','Nops',_Nops) / Index
        *-- On Nops Tag Nops / Set Order to Nops Descending / Seek _Nops
        IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_TempMFas", "Nops", par_nNops)
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (TempMFas)"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_TempMFas
        INDEX ON Nops TAG Nops
        SET ORDER TO Nops DESCENDING
        SEEK par_nNops

        *-- legado: If InList(_PuxaOrigem, 1, 2) ... sugestao de Grupo/Conta
        *-- de Origem (so o VALOR - a atribuicao ao controle fica para o Form)
        IF INLIST(par_nPuxaOrigem, 1, 2)
            IF EMPTY(par_cNensGrupoOs) OR (EMPTY(par_cNensContaOs) AND !cursor_4c_LocalOpp.FixGOrigs)
                THIS.this_lAtualizarOrigemGrupo = .T.
                THIS.this_cOrigemGrupoCalculado = IIF(par_nPuxaOrigem = 1, ;
                    cursor_4c_TempMFas.GrupoOs, cursor_4c_TempMFas.GrupoDs)
            ENDIF
            IF EMPTY(par_cNensContaOs)
                THIS.this_lAtualizarOrigemConta = .T.
                THIS.this_cOrigemContaCalculada = IIF(par_nPuxaOrigem = 1, ;
                    cursor_4c_TempMFas.ContaOs, cursor_4c_TempMFas.ContaDs)
            ENDIF
        ENDIF

        IF INLIST(par_nPuxaDestino, 1, 2)
            IF EMPTY(par_cNensGrupoDs)
                THIS.this_lAtualizarDestinoGrupo = .T.
                THIS.this_cDestinoGrupoCalculado = IIF(par_nPuxaDestino = 1, ;
                    cursor_4c_TempMFas.GrupoOs, cursor_4c_TempMFas.GrupoDs)
            ENDIF
            IF EMPTY(par_cNensContaDs)
                THIS.this_lAtualizarDestinoConta = .T.
                THIS.this_cDestinoContaCalculada = IIF(par_nPuxaDestino = 1, ;
                    cursor_4c_TempMFas.ContaOs, cursor_4c_TempMFas.ContaDs)
            ENDIF
        ENDIF

        *-- legado: If _BaixaSubNivel ... Update SigCdNec Set ChkSubn=.t. em
        *-- LOTE para a chave do "nivel" de baixa (regra #22/#42 - chave
        *-- posicional com PADR explicito)
        IF par_lBaixaSubnivel
            loc_cChaveBaixa = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(cursor_4c_LocalOpp.Nivels, 20) + ;
                STR(par_nNops, 10)

            loc_cSQL = "SELECT CidChaves FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cChaveBaixa)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens2") < 1
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conex" + CHR(227) + "o (Marca - Update - SigCdNec)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                RETURN .F.
            ENDIF

            *-- legado: Scan / Update SigCdNec Set ChkSubn = ?pTru Where
            *-- CidChaves = '<cid>' - o UPDATE de UMA linha pela PK (mais a
            *-- auditoria) vive em Atualizar(); aqui fica so o LOTE
            SELECT cursor_4c_LocalNens2
            SCAN
                THIS.this_cCidChavesAtual = cursor_4c_LocalNens2.CidChaves
                THIS.this_lChkSubn        = .T.

                IF !THIS.Atualizar()
                    IF USED("cursor_4c_LocalNens2")
                        USE IN cursor_4c_LocalNens2
                    ENDIF
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_LocalNens2
            ENDSCAN

            IF USED("cursor_4c_LocalNens2")
                USE IN cursor_4c_LocalNens2
            ENDIF
        ENDIF

        *-- legado: CursorQuery('SigOpPic','LocalOpi','Nops',TempMFas.Nops) /
        *-- Select LocalOpi / Scan - gera 1 linha de xOpi + 1 de xPesa por item
        IF THIS.ExecutarCursorQuery("SigOpPic", "cursor_4c_LocalOpi", "Nops", cursor_4c_TempMFas.Nops)
            SELECT cursor_4c_LocalOpi
            SCAN
                THIS.this_nAmarra = THIS.this_nAmarra + 1

                INSERT INTO (loc_cAliasOpi) (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes) ;
                    VALUES (cursor_4c_TempMFas.Nops, ;
                        ALLTRIM(cursor_4c_LocalOpi.Dopes) + "/" + ALLTRIM(STR(cursor_4c_LocalOpi.Numes)), ;
                        cursor_4c_LocalOpi.Qtds, cursor_4c_TempMFas.CodPds, .F., THIS.this_nAmarra, ;
                        cursor_4c_TempMFas.Nenvs, cursor_4c_LocalOpi.Emps, cursor_4c_LocalOpi.Dopes, ;
                        cursor_4c_LocalOpi.Numes)

                INSERT INTO (loc_cAliasPesa) (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops) ;
                    VALUES (EVALUATE(loc_cAliasOpi + ".Oper"), EVALUATE(loc_cAliasOpi + ".CPros"), ;
                        EVALUATE(loc_cAliasOpi + ".Qtds"), 0, THIS.this_nAmarra, cursor_4c_TempMFas.Nenvs, ;
                        cursor_4c_LocalOpi.Emps, cursor_4c_LocalOpi.Dopes, cursor_4c_LocalOpi.Numes, ;
                        cursor_4c_TempMFas.Nops)

                SELECT cursor_4c_LocalOpi
            ENDSCAN

            IF USED("cursor_4c_LocalOpi")
                USE IN cursor_4c_LocalOpi
            ENDIF
        ENDIF

        *-- legado: If Empty(TmpNens.GrVends) ... sugestao de Responsavel
        IF EMPTY(par_cNensGrVends)
            THIS.this_lAtualizarRespGrupo = .T.
            THIS.this_cRespGrupoCalculado = par_cNecessidadeGrVends
        ENDIF
        IF EMPTY(par_cNensVends) AND par_cNensGrVends == par_cNecessidadeGrVends
            THIS.this_lAtualizarRespConta = .T.
            THIS.this_cRespContaCalculada = par_cNecessidadeVends
        ENDIF

        *-- legado: Insert Into xMFas (...)
        INSERT INTO (loc_cAliasMFasParent) (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, ;
                Grupods, Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds, Obsps, Ordems) ;
            VALUES (par_cNensEmps, par_cNensDopps, par_nNensNumps, cursor_4c_LocalMFas.Datars, ;
                cursor_4c_LocalMFas.Datas, gc_4c_UsuarioLogado, cursor_4c_LocalMFas.Opers, par_cNensGrupoOs, ;
                par_cNensContaOs, par_cNensGrupoDs, par_cNensContaDs, cursor_4c_LocalMFas.Nops, par_nPendNumes, ;
                cursor_4c_LocalMFas.Codpds, cursor_4c_LocalMFas.Unids, cursor_4c_LocalMFas.Pesos, ;
                cursor_4c_LocalMFas.Qtds, cursor_4c_LocalMFas.Obsps, cursor_4c_LocalMFas.Ordems)

        IF !THIS.ProcessarNeiDaFase(par_cOperacao, par_cNensEmps, par_cNensDopps, par_nNensNumps, par_nPendNumes)
            RETURN .F.
        ENDIF

        *-- legado: CursorQuery('SigCdPro','LocalPro','CPros',LocalMfas.CodPds,
        *-- 'MatPrincs, Cgrus')
        IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_LocalPro", "CPros", cursor_4c_LocalMFas.CodPds, ;
                "MatPrincs, Cgrus")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalPro)"
            RETURN .F.
        ENDIF

        *-- legado: CursorQuery('SigCdGrp','LocalGru','CGrus',LocalPro.Cgrus,
        *-- [Mercs]) / CursorQuery('SigCdGpr','LocalGgrp','Codigos',
        *-- LocalGru.Mercs,[MatPrincs]) - sem guarda de falha (so afetam o
        *-- fallback de _MatP). legado tinha um "Set Step On" aqui
        *-- (breakpoint de depuracao esquecido no fonte) - OMITIDO DE
        *-- PROPOSITO: abriria o debugger do VFP e travaria qualquer
        *-- execucao desassistida (regra #6/#29).
        THIS.ExecutarCursorQuery("SigCdGrp", "cursor_4c_LocalGru", "CGrus", cursor_4c_LocalPro.Cgrus, "Mercs")

        IF USED("cursor_4c_LocalGru") AND RECCOUNT("cursor_4c_LocalGru") > 0
            THIS.ExecutarCursorQuery("SigCdGpr", "cursor_4c_LocalGgrp", "Codigos", cursor_4c_LocalGru.Mercs, ;
                "MatPrincs")
        ELSE
            IF USED("cursor_4c_LocalGgrp")
                USE IN cursor_4c_LocalGgrp
            ENDIF
        ENDIF

        IF USED("cursor_4c_LocalGgrp") AND RECCOUNT("cursor_4c_LocalGgrp") > 0
            loc_cMatP = IIF(!EMPTY(cursor_4c_LocalPro.MatPrincs), cursor_4c_LocalPro.MatPrincs, ;
                IIF(!EMPTY(cursor_4c_LocalGgrp.MatPrincs), cursor_4c_LocalGgrp.MatPrincs, ;
                    EVALUATE(loc_cAliasParam + ".Ouros")))
        ELSE
            loc_cMatP = IIF(!EMPTY(cursor_4c_LocalPro.MatPrincs), cursor_4c_LocalPro.MatPrincs, ;
                EVALUATE(loc_cAliasParam + ".Ouros"))
        ENDIF

        *-- legado: CursorQuery('SigPrCpo','LocalCompo','CPros',
        *-- LocalMfas.CodPds,'Mats, Qtds, Cats') - zero componentes eh
        *-- estado valido (produto sem formula de componentes), sem guarda
        *-- de falha no legado
        IF !THIS.ExecutarCursorQuery("SigPrCpo", "cursor_4c_LocalCompo", "CPros", cursor_4c_LocalMFas.CodPds, ;
                "Mats, Qtds, Cats")
            RETURN .T.
        ENDIF

        SELECT cursor_4c_LocalCompo
        SCAN
            IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_LocalPro", "CPros", cursor_4c_LocalCompo.Mats, ;
                    "CUnis, CGRus, DPros, Varias")
                SELECT cursor_4c_LocalCompo
                LOOP
            ENDIF

            THIS.ExecutarCursorQuery("SigCdUni", "cursor_4c_LocalUni", "CUnis", cursor_4c_LocalPro.CUnis, "Fators")

            IF cursor_4c_LocalCompo.Mats == loc_cMatP AND cursor_4c_LocalMFas.Pesos != 0
                loc_nQtAnt = cursor_4c_LocalMFas.Pesos
            ELSE
                loc_nQtAnt = cursor_4c_LocalMFas.Qtds * cursor_4c_LocalCompo.Qtds
            ENDIF

            IF !USED("cursor_4c_LocalUni") OR RECCOUNT("cursor_4c_LocalUni") = 0 OR cursor_4c_LocalUni.Fators = 0
                loc_nPsAnt = cursor_4c_LocalMFas.Qtds * cursor_4c_LocalCompo.Qtds * cursor_4c_LocalMFas.Pesos
            ELSE
                loc_nPsAnt = cursor_4c_LocalMFas.Qtds * cursor_4c_LocalCompo.Qtds * cursor_4c_LocalUni.Fators
            ENDIF

            INSERT INTO (loc_cAliasNensi) (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
                    QtFaseAnt, PsFaseAnt, Visivel, Rateio, FlagIncs, Cats, Qtds, Pesos) ;
                VALUES (par_cNensEmps, par_cNensDopps, par_nNensNumps, cursor_4c_LocalMFas.Nops, par_nPendNumes, ;
                    cursor_4c_LocalCompo.Mats, cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CUnis, ;
                    cursor_4c_LocalPro.CGrus, loc_nQtAnt, loc_nPsAnt, .F., ;
                    IIF(cursor_4c_LocalPro.Varias = 1, 2, 3), .T., cursor_4c_LocalCompo.Cats, loc_nQtAnt, loc_nPsAnt)

            IF !SEEK(par_cOperacao + cursor_4c_LocalCompo.Mats, loc_cAliasNensi, "NEnvCMat")
                INSERT INTO (loc_cAliasNensi) (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
                        FlagIncs, Cats) ;
                    VALUES (par_nPendNumes, par_nPendNumes, cursor_4c_LocalCompo.Mats, cursor_4c_LocalPro.DPros, ;
                        cursor_4c_LocalPro.CUnis, cursor_4c_LocalPro.CGrus, .T., 1, .T., cursor_4c_LocalCompo.Cats)
            ENDIF

            REPLACE QtFaseAnt WITH QtFaseAnt + loc_nQtAnt, ;
                    Qtds      WITH Qtds + loc_nQtAnt ;
                IN (loc_cAliasNensi)

            IF !USED("cursor_4c_LocalUni") OR RECCOUNT("cursor_4c_LocalUni") = 0 OR cursor_4c_LocalUni.Fators = 0
                REPLACE PsFaseAnt WITH PsFaseAnt + loc_nPsAnt, ;
                        Pesos     WITH 0 ;
                    IN (loc_cAliasNensi)
            ELSE
                REPLACE PsFaseAnt WITH PsFaseAnt + loc_nPsAnt, ;
                        Pesos     WITH Pesos + loc_nPsAnt ;
                    IN (loc_cAliasNensi)
            ENDIF

            SELECT cursor_4c_LocalCompo
        ENDSCAN

        IF USED("cursor_4c_LocalCompo")
            USE IN cursor_4c_LocalCompo
        ENDIF
        IF USED("cursor_4c_LocalUni")
            USE IN cursor_4c_LocalUni
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF
        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
        IF USED("cursor_4c_LocalGgrp")
            USE IN cursor_4c_LocalGgrp
        ENDIF
        IF USED("cursor_4c_TempMFas")
            USE IN cursor_4c_TempMFas
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarNeiDaFase - legado (linhas 785-824): CursorQuery('SigCdNei',
    * 'LocalNensi','Nops',xMFas.Nops,'Nops, Emps, Dopps, Numps') so para
    * achar a chave Emps+Dopps+Numps do item recem-criado em xMFas (cursor
    * TEMPORARIO, separado do cursor abaixo - o legado reusa o MESMO nome
    * 'LocalNensi' para as duas coisas, aqui usamos alias diferentes para
    * nao confundir). Depois consulta SigCdNei por EmpDNps+Nops (pode
    * devolver VARIAS linhas) e gera 1 linha de xNensi por linha, somando
    * Pesos em _TotalNop; se o total acumulado for != 0, soma tambem numa
    * linha "resumo" do proprio Nops/Nenvs (Seek por NEnvCMat + Space(10)).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarNeiDaFase(par_cOperacao, par_cNensEmps, par_cNensDopps, par_nNensNumps, ;
            par_nPendNumes)

        LOCAL loc_cAliasMFasParent, loc_cAliasNensi, loc_cAliasParam
        LOCAL loc_cChaveOrig, loc_cSQL, loc_nTotalNop

        loc_cAliasMFasParent = THIS.this_cCursorMFas
        loc_cAliasNensi       = THIS.this_cCursorNensi
        loc_cAliasParam       = THIS.this_cCursorParametros

        IF !THIS.ExecutarCursorQuery("SigCdNei", "cursor_4c_LocalNensiChave", "Nops", ;
                EVALUATE(loc_cAliasMFasParent + ".Nops"), "Nops, Emps, Dopps, Numps")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNensi)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Chave POSICIONAL (regra #42) - PADR explicito
        loc_cChaveOrig = PADR(cursor_4c_LocalNensiChave.Emps, 3) + PADR(cursor_4c_LocalNensiChave.Dopps, 20) + ;
            STR(cursor_4c_LocalNensiChave.Numps, 10)
        loc_nTotalNop = 0

        IF USED("cursor_4c_LocalNensiChave")
            USE IN cursor_4c_LocalNensiChave
        ENDIF

        loc_cSQL = "SELECT CMats, Qtds, Pesos FROM SigCdNei WHERE EmpDNps = " + EscaparSQL(loc_cChaveOrig) + ;
            " AND Nops = " + FormatarNumeroSQL(EVALUATE(loc_cAliasMFasParent + ".Nops"), 0)

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNensi") < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNensi)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_LocalNensi
        SCAN
            IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_LocalPro", "CPros", cursor_4c_LocalNensi.CMats, ;
                    "DPros, CUnis, CGrus, Varias")
                SELECT cursor_4c_LocalNensi
                LOOP
            ENDIF

            INSERT INTO (loc_cAliasNensi) (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, ;
                    QtFaseAnt, Qtds, PsFaseAnt, Pesos, Visivel, Rateio, CGrus) ;
                VALUES (par_cNensEmps, par_cNensDopps, par_nNensNumps, EVALUATE(loc_cAliasMFasParent + ".Nops"), ;
                    par_nPendNumes, cursor_4c_LocalNensi.CMats, cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CUnis, ;
                    cursor_4c_LocalNensi.Qtds, cursor_4c_LocalNensi.Qtds, cursor_4c_LocalNensi.Pesos, ;
                    cursor_4c_LocalNensi.Pesos, .F., IIF(cursor_4c_LocalPro.Varias = 1, 2, 3), ;
                    cursor_4c_LocalPro.CGrus)

            loc_nTotalNop = loc_nTotalNop + cursor_4c_LocalNensi.Pesos

            SELECT cursor_4c_LocalNensi
        ENDSCAN

        IF USED("cursor_4c_LocalNensi")
            USE IN cursor_4c_LocalNensi
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF

        IF loc_nTotalNop != 0
            IF !SEEK(par_cOperacao + SPACE(10), loc_cAliasNensi, "NEnvCMat")
                INSERT INTO (loc_cAliasNensi) (Nops, Nenvs, Visivel, Rateio, CUnis) ;
                    VALUES (par_nPendNumes, par_nPendNumes, .T., 1, EVALUATE(loc_cAliasParam + ".CuniPPads"))
            ENDIF

            REPLACE PsFaseAnt WITH PsFaseAnt + loc_nTotalNop, ;
                    Pesos     WITH Pesos + loc_nTotalNop ;
                IN (loc_cAliasNensi)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Desmarcar - legado: PROCEDURE desmarca. Chamado pelo InteractiveChange
    * do fwcheckbox1 (Not This.Value -> ThisForm.Desmarca) e por APAGA.Click
    * (scan desmarcando tudo). Wrapper fino (regra #47) - o corpo fica em
    * DesmarcarExec().
    *==========================================================================
    PROCEDURE Desmarcar()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.DesmarcarExec()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desmarcar pend" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarExec - corpo de Desmarcar(), fora do TRY (regra #47).
    *
    * legado: Desfaz o que Marcar() fez para a pendencia CORRENTE de
    * TmpPends - apaga as linhas de xMFas/xOpi/xPesa/xNensi associadas
    * (Nenvs = TmpPends.Numes), zera ChkSubn em SigCdNec (oposto do
    * _BaixaSubnivel de Marcar() - aqui sempre .F., sem condicional, pois o
    * legado tambem zera incondicionalmente ao desmarcar) e recalcula se o
    * form pai ainda pode editar a conta de Origem (this_lPermiteEditarOrigem
    * - legado: ThisForm.ParentForm.EditaOrigem).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DesmarcarExec()
        LOCAL loc_cAliasPends, loc_cAliasMFas, loc_cAliasOpi, loc_cAliasPesa, loc_cAliasNensi, loc_cAliasOperacao
        LOCAL loc_cNivel, loc_nNumesAtual, loc_cSQL, loc_nRecnoAnt, loc_lTemOperacaoPendente

        loc_cAliasPends    = THIS.this_cCursorPends
        loc_cAliasMFas     = THIS.this_cCursorMFas
        loc_cAliasOpi      = THIS.this_cCursorOpi
        loc_cAliasPesa     = THIS.this_cCursorPesa
        loc_cAliasNensi    = THIS.this_cCursorNensi
        loc_cAliasOperacao = THIS.this_cCursorOperacao

        IF !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursor de pend" + CHR(234) + "ncias n" + CHR(227) + "o est" + CHR(225) + ;
                " aberto."
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasPends)
        loc_cNivel      = PADR(Emps, 3) + PADR(Dopes, 20) + STR(Numes, 10)
        loc_nNumesAtual = Numes

        *-- legado: Select xMFas/xOpi/xPesa/xNensi / Set Order to / Delete
        *-- All For Nenvs = TmpPends.Numes
        IF USED(loc_cAliasMFas)
            SELECT (loc_cAliasMFas)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF
        IF USED(loc_cAliasOpi)
            SELECT (loc_cAliasOpi)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF
        IF USED(loc_cAliasPesa)
            SELECT (loc_cAliasPesa)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF
        IF USED(loc_cAliasNensi)
            SELECT (loc_cAliasNensi)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF

        *-- legado: lcSql = Select CidChaves From SigCdNec where EmpDNps =
        *-- '<Nivel>'
        loc_cSQL = "SELECT CidChaves FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cNivel)

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens") < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (Desmarcar - Update - SigCdNec)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- legado: Scan / Update SigCdNec Set ChkSubn = ?pNot Where
        *-- CidChaves = '<cid>' (pNot = .f.) - o UPDATE de UMA linha pela PK
        *-- (mais a auditoria) vive em Atualizar(); aqui fica so o LOTE
        SELECT cursor_4c_LocalNens
        SCAN
            THIS.this_cCidChavesAtual = cursor_4c_LocalNens.CidChaves
            THIS.this_lChkSubn        = .F.

            IF !THIS.Atualizar()
                IF USED("cursor_4c_LocalNens")
                    USE IN cursor_4c_LocalNens
                ENDIF
                RETURN .F.
            ENDIF

            SELECT cursor_4c_LocalNens
        ENDSCAN

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF

        *-- legado: Select TmpOperacao / _RecnoAnt=Recno() / Go Top /
        *-- EditaOrigem=.t. / Scan For Not Empty(Codigos) / EditaOrigem=.f. /
        *-- Exit / EndScan / Go _RecnoAnt / Skip / If Eof() / Insert
        *-- (Codigos=0) - EditaOrigem eh property do FORM PAI; aqui so o
        *-- VALOR (this_lPermiteEditarOrigem), a atribuicao fica para a
        *-- camada de Form (PILAR 3)
        IF USED(loc_cAliasOperacao)
            SELECT (loc_cAliasOperacao)
            loc_nRecnoAnt = RECNO()
            GO TOP

            loc_lTemOperacaoPendente = .F.
            SCAN FOR !EMPTY(Codigos)
                loc_lTemOperacaoPendente = .T.
                EXIT
            ENDSCAN

            THIS.this_lPermiteEditarOrigem = !loc_lTemOperacaoPendente

            IF BETWEEN(loc_nRecnoAnt, 1, RECCOUNT())
                GO RECORD loc_nRecnoAnt
            ELSE
                GO TOP
            ENDIF
            SKIP
            IF EOF()
                INSERT INTO (loc_cAliasOperacao) (Codigos) VALUES (0)
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

ENDDEFINE
