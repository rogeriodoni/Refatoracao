*==============================================================================
* SigOpCopBO.prg
*
* Business Object para FormSigOpCop - Copia de Movimentacao
* Legado: SigOpCop.SCX (task706)
*
* Tabela principal : SigCdOpe (chave: dopes char(20))
* Contador da PK   : SIGSYSEQ, chave "SigCdOpe" -> SigCdOpe.ndopes
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Duplica uma operacao de movimentacao inteira: le o registro de SigCdOpe
* identificado por this_cOperacaoOrigem e regrava tudo sob o nome novo
* this_cOperacaoDestino, propagando a copia para as 14 tabelas filhas e
* registrando as permissoes do programa novo em SigCdPrg.
*
* Ordem das tabelas, transcrita do CmdCopia.Click legado (os "Zap In" e os
* "poDatamgr.Update()" do legado seguem exatamente esta sequencia):
*
*    1  SigCdOpe   dopes              mestre            (1 linha)
*    2  SigOpCdc   dopes              configuracao      (1 linha)
*    3  SigOpCdi   dopes              itens             (N linhas)
*    4  SigOpCsn   cdopes + cidchaves subniveis         (N linhas)
*    5  SigOpCrr   dopes  + cidchaves recorrencias      (N linhas)
*    6  SigOpDup   dopes  + cidchaves duplicatas        (N linhas)
*    7  SigCdPrg   pkchaves           programa/acessos  (ate 15 linhas)
*    8  SigOpCdd   dopes              dados compl.      (N linhas)
*    9  SigMvCxs   cdopes + cidchaves caixas            (N linhas)
*   10  SigCcCpe   dopes  + cidchaves centro de custo   (N linhas)
*   11  SigCdMop   cdopes + cidchaves multi-operacao    (N linhas)
*   12  SigOpFpO   dopes  + cidchaves formas de pagto   (N linhas)
*   13  SigOpTrf   dopes  + cidchaves transferencias    (N linhas)
*   14  SigOpFin   dopes  + cidchaves financeiro        (N linhas)
*   15  SigOpLso   dopes  + cidchaves lancamentos       (N linhas)
*
* Conferido em docs/schema.sql (UTF-16, lido com Get-Content -Raw - regra #14):
* as tabelas que o legado alimenta com "m.cIdChaves = fUniqueIds()" sao
* exatamente as que POSSUEM a coluna cidchaves, e as que recebem apenas
* m.Dopes/m.cDopes sao as que NAO a possuem. A grafia da coluna de operacao
* tambem varia (dopes x cdopes) e esta anotada acima tabela por tabela - nao
* deduzir pelo prefixo do nome (regra #48).
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA
*
* O legado copia registro a registro com "Scatter MemVar Memo" + "Gather
* MemVar", trazendo as colunas ao VFP so para devolve-las ao servidor. Como
* SigCdOpe tem 254 colunas e SigOpCdc/SigOpCdd passam de 240, a copia e feita
* server-side, preservando a semantica do Scatter/Gather (intersecao de
* colunas por NOME) - ver docs e regra #22 sobre colunas NOT NULL.
*
* Esta classe NAO e um CRUD: a tela tem um unico botao de acao (Copiar) e
* nunca altera nem exclui a operacao de origem. Por isso o comportamento
* herdado de BusinessBase para Excluir() ja e o correto e nao e redefinido.
*==============================================================================

DEFINE CLASS SigOpCopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Operacao de origem e de destino (SigCdOpe.dopes char(20))
    * Origem  : recebida do form pai (parametro pOperacao do Init legado)
    * Destino : digitada pelo usuario em txt_4c_Destino
    *--------------------------------------------------------------------------
    this_cOperacaoOrigem  = ""
    this_cOperacaoDestino = ""

    *--------------------------------------------------------------------------
    * Chaves geradas para o registro NOVO de SigCdOpe
    * Legado: lnNDopes    = fGerUniqueKey("SigCdOpe")
    *         lcProgramas = Padl(lnNDopes, 8, '0')
    *--------------------------------------------------------------------------
    this_nNDopes    = 0      && SigCdOpe.ndopes    numeric(4,0)
    this_cProgramas = ""     && SigCdOpe.programas char(15)

    *--------------------------------------------------------------------------
    * Campos lidos do registro de ORIGEM, usados para montar a descricao e a
    * barra de menu do programa novo em SigCdPrg
    *--------------------------------------------------------------------------
    this_cMenus     = ""     && SigCdOpe.menus      char(10)
    this_cSubMenus  = ""     && SigCdOpe.submenus   char(15)
    this_cArqIcones = ""     && SigCdOpe.carqicones char(64) NULL

    *--------------------------------------------------------------------------
    * Registro de programa e permissoes - SigCdPrg (todas as 6 colunas da
    * tabela sao NOT NULL, conferido no schema)
    * Legado: _Prog       = Padr(Padl(crSigCdOpe.NDopes, 8, '0'), 15)
    *         _Desc       = lcOperacao + Proper(...)
    *         lcSubMenus  = '_' + Upper(Left(crSigCdOpe.SubMenus, 14))
    *         lcBarraForm = Space(50) ou [SigMvExp WITH "<dopes>","E"]
    *--------------------------------------------------------------------------
    this_cProg         = ""  && SigCdPrg.programas  char(15)
    this_cDescPrograma = ""  && SigCdPrg.descricaos char(150)
    this_cSubMenuPrg   = ""  && SigCdPrg.programas  char(15) - entrada do submenu
    this_cBarraForm    = ""  && SigCdPrg.barraforms char(50)
    this_cBarraPict    = ""  && SigCdPrg.barrapict  char(60)
    this_cPrefixoMenu  = ""  && lcOperacao: prefixo textual da descricao

    *--------------------------------------------------------------------------
    * Log de auditoria do legado: fGravarLog('C', <form>, 'COPIA', lcTransacao)
    *--------------------------------------------------------------------------
    this_cTransacao = ""

    *--------------------------------------------------------------------------
    * Acompanhamento do processo (a copia atravessa 15 tabelas; a etapa atual
    * entra nas mensagens de erro para o usuario saber onde parou, no lugar do
    * "Favor Reinicializar o Processo!!!" generico do legado)
    *--------------------------------------------------------------------------
    this_cEtapaAtual        = ""
    this_nTabelasCopiadas   = 0
    this_nRegistrosCopiados = 0

    *--------------------------------------------------------------------------
    * Cursores de trabalho
    *--------------------------------------------------------------------------
    this_cCursorOrigem = "cursor_4c_OpeOrigem"   && registro mestre de origem
    this_cCursorAux    = "cursor_4c_OpeAux"      && conferencias pontuais
    this_cCursorBusca  = "cursor_4c_Busca"       && lookup de operacoes

    *--------------------------------------------------------------------------
    * Lote de comandos SQL acumulados pelo copiador (MontarLoteCopia +
    * CopiarTabelaFilha + os Acumular* de SigCdPrg) para execucao ATOMICA
    * unica em ExecutarLoteCopia - mesmo padrao de ProdutoBO.this_cLoteCopia
    *--------------------------------------------------------------------------
    this_cLoteCopia = ""

    *--------------------------------------------------------------------------
    * Init - define a tabela principal e a chave primaria
    *
    * NAO carrega dado nenhum aqui: Init de BO que devolve .F. destroi o
    * objeto, CREATEOBJECT retorna .F. e o form nunca abre - inclusive em
    * validacao de UI, onde gnConnHandle = -1 e qualquer SQLEXEC estoura.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "dopes"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpCopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Transcricao dos guards do CmdCopia.Click ("Origem
    * Invalida"/"Destino Invalido") + do GetDestino.Valid ("Opera??o j?
    * Cadastrada") do legado, mais uma conferencia defensiva de que a
    * origem existe (o legado confia no fwBuscaExt do Valid do campo, que
    * so roda quando o usuario passa pelo TextBox - aqui garantimos o mesmo
    * antes de abrir a transacao inteira).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cOrigem, loc_cDestino, loc_nResultado

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        loc_cOrigem  = ALLTRIM(NVL(THIS.this_cOperacaoOrigem, ""))
        loc_cDestino = ALLTRIM(NVL(THIS.this_cOperacaoDestino, ""))

        IF EMPTY(loc_cOrigem)
            THIS.this_cMensagemErro = "Origem Invalida !!!"
            loc_lValido = .F.
        ELSE
            IF EMPTY(loc_cDestino)
                THIS.this_cMensagemErro = "Destino Invalido !!!"
                loc_lValido = .F.
            ELSE
                IF USED("cursor_4c_OpeValida")
                    USE IN cursor_4c_OpeValida
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT dopes FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cOrigem), ;
                    "cursor_4c_OpeValida")

                IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_OpeValida") = 0
                    THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + ;
                        CHR(227) + "o encontrada."
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_OpeValida")
                    USE IN cursor_4c_OpeValida
                ENDIF

                IF loc_lValido
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT dopes FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDestino), ;
                        "cursor_4c_OpeValida")

                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_OpeValida") > 0
                        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o j" + ;
                            CHR(225) + " Cadastrada !!!"
                        loc_lValido = .F.
                    ENDIF

                    IF USED("cursor_4c_OpeValida")
                        USE IN cursor_4c_OpeValida
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigCdOpe que este BO modela
    * (Dopes/NDopes/Programas/Menus/SubMenus/CArqIcones) a partir do cursor
    * do registro de ORIGEM. As demais ~248 colunas de SigCdOpe NUNCA
    * passam pela memoria do VFP - a copia delas eh feita server-side via
    * MontarInsertCopia (ver nota de arquitetura no cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE("Dopes") != "U"
                    THIS.this_cOperacaoOrigem = ALLTRIM(TratarNulo(Dopes, ""))
                ENDIF
                IF TYPE("NDopes") != "U"
                    THIS.this_nNDopes = TratarNulo(NDopes, 0)
                ENDIF
                IF TYPE("Programas") != "U"
                    THIS.this_cProgramas = ALLTRIM(TratarNulo(Programas, ""))
                ENDIF
                IF TYPE("Menus") != "U"
                    THIS.this_cMenus = ALLTRIM(TratarNulo(Menus, ""))
                ENDIF
                IF TYPE("SubMenus") != "U"
                    THIS.this_cSubMenus = ALLTRIM(TratarNulo(SubMenus, ""))
                ENDIF
                IF TYPE("CArqIcones") != "U"
                    THIS.this_cArqIcones = ALLTRIM(TratarNulo(CArqIcones, ""))
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpCopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOrigem - Busca o registro de origem em SigCdOpe e carrega
    * Menus/SubMenus/CArqIcones (necessarios para montar o bloco de
    * permissoes em SigCdPrg) via CarregarDoCursor. Equivalente ao "Select
    * CrSigCdOpe" implicito que o CmdCopia.Click legado faz antes do Scatter.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOrigem(par_cCodigoOrigem)
        LOCAL loc_lSucesso, loc_cCodigo, loc_nResultado

        loc_lSucesso = .F.
        loc_cCodigo  = ALLTRIM(NVL(par_cCodigoOrigem, ""))

        IF !EMPTY(loc_cCodigo)
            IF USED(THIS.this_cCursorOrigem)
                USE IN (THIS.this_cCursorOrigem)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Dopes, NDopes, Programas, Menus, SubMenus, CArqIcones" + ;
                " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCodigo), ;
                THIS.this_cCursorOrigem)

            IF loc_nResultado >= 0 AND RECCOUNT(THIS.this_cCursorOrigem) > 0
                SELECT (THIS.this_cCursorOrigem)
                GO TOP
                loc_lSucesso = THIS.CarregarDoCursor(THIS.this_cCursorOrigem)
            ELSE
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + ;
                    CHR(227) + "o encontrada."
            ENDIF

            IF USED(THIS.this_cCursorOrigem)
                USE IN (THIS.this_cCursorOrigem)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para este BO a "chave" relevante para auditoria
    * eh a operacao recem-criada (destino), nao a origem - que permanece
    * intocada (ver nota de arquitetura no cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cOperacaoDestino, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Transcricao de CmdCopia.Click: gera nDopes/Programas,
    * monta o lote inteiro (15 tabelas + bloco de permissoes SigCdPrg) e
    * executa tudo numa unica transacao atomica - igual ao legado, que so
    * descarrega os cursores no Update()/Commit() do fim.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cOrigem, loc_cDestino, loc_nNDopes, loc_cProgramas, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cOrigem  = ALLTRIM(NVL(THIS.this_cOperacaoOrigem, ""))
            loc_cDestino = UPPER(ALLTRIM(NVL(THIS.this_cOperacaoDestino, "")))

            IF EMPTY(loc_cOrigem)
                THIS.this_cMensagemErro = "Origem Invalida !!!"
            ELSE
                IF EMPTY(loc_cDestino)
                    THIS.this_cMensagemErro = "Destino Invalido !!!"
                ELSE
                    IF !THIS.CarregarOrigem(loc_cOrigem)
                        *-- mensagem ja definida por CarregarOrigem
                    ELSE
                        loc_nNDopes    = fGerUniqueKey("SigCdOpe")
                        loc_cProgramas = PADL(TRANSFORM(loc_nNDopes), 8, "0")

                        THIS.this_nNDopes    = loc_nNDopes
                        THIS.this_cProgramas = loc_cProgramas
                        THIS.this_cProg      = PADR(loc_cProgramas, 15)

                        IF THIS.MontarLoteCopia(loc_cOrigem, loc_cDestino, loc_nNDopes, loc_cProgramas)
                            THIS.MontarBlocoSigCdPrg(loc_cDestino)
                            loc_lSucesso = THIS.ExecutarLoteCopia()

                            IF loc_lSucesso
                                THIS.this_cOperacaoDestino = loc_cDestino
                                THIS.this_cTransacao       = loc_cDestino
                                fGravarLog("C", "FormSigOpCop", "COPIA", loc_cDestino)
                                THIS.RegistrarAuditoria("INSERT")
                            ENDIF
                        ELSE
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cLoteCopia = ""
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "SigOpCopBO.Inserir")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - O legado nao distingue INSERIR/ALTERAR neste dialogo: o
    * unico botao "Copiar" sempre cria uma operacao NOVA a partir da
    * origem. O fluxo canonico (NovoRegistro + Salvar) so chama Inserir(),
    * mas Atualizar() delega para o mesmo lugar para nao ficar quebrado se
    * algum caller chamar Salvar() sem passar por NovoRegistro().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarLoteCopia - Acumula em this_cLoteCopia o INSERT...SELECT de
    * cada uma das 14 tabelas (SigCdOpe + 13 filhas), na ORDEM do
    * CmdCopia.Click legado. SigCdPrg (15a tabela da lista do cabecalho)
    * NAO vem de origem - eh construida em MontarBlocoSigCdPrg().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarLoteCopia(par_cOrigem, par_cDestino, par_nNDopes, par_cProgramas)
        LOCAL loc_lOk, loc_cSQL

        loc_lOk = .T.

        THIS.this_cLoteCopia         = ""
        THIS.this_nTabelasCopiadas   = 0
        THIS.this_nRegistrosCopiados = 0

        *-- SigCdOpe - registro mestre (1 linha)
        THIS.this_cEtapaAtual = "SigCdOpe"
        loc_cSQL = THIS.MontarInsertCopia("SigCdOpe", ;
            "dopes=" + EscaparSQL(par_cDestino) + ;
            "|ndopes=" + FormatarNumeroSQL(par_nNDopes, 0) + ;
            "|programas=" + EscaparSQL(par_cProgramas), ;
            "dopes = " + EscaparSQL(par_cOrigem))
        loc_lOk = !EMPTY(loc_cSQL)
        IF loc_lOk
            THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
            THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
        ENDIF

        *-- SigOpCdc - configuracao (1 linha)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCdc"
            loc_cSQL = THIS.MontarInsertCopia("SigOpCdc", "dopes=" + EscaparSQL(par_cDestino), ;
                "dopes = " + EscaparSQL(par_cOrigem))
            loc_lOk = !EMPTY(loc_cSQL)
            IF loc_lOk
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
            ENDIF
        ENDIF

        *-- SigOpCdi - itens (N linhas, sem cidchaves - a chave natural eh
        *-- dopes + o item do legado, preservado linha a linha)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCdi"
            loc_cSQL = THIS.MontarInsertCopia("SigOpCdi", "dopes=" + EscaparSQL(par_cDestino), ;
                "dopes = " + EscaparSQL(par_cOrigem))
            loc_lOk = !EMPTY(loc_cSQL)
            IF loc_lOk
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
            ENDIF
        ENDIF

        *-- SigOpCsn - subniveis (N linhas, cidchaves proprio). O inner join
        *-- do legado com SigCdOpe em a.cnivels = b.Dopes eh um filtro de
        *-- integridade (so copia subnivel cujo cnivels ainda exista como
        *-- operacao cadastrada) - replicado no WHERE, nao traz coluna nova.
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCsn"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpCsn", "cdopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "cnivels IN (SELECT dopes FROM SigCdOpe)")
        ENDIF

        *-- SigOpCrr - recorrencias (N linhas, cidchaves proprio). O inner
        *-- join do legado (a.dopes = b.Dopes Where a.Dopes = origem) eh
        *-- degenerado - SigCdOpe ja tem a linha de origem por definicao
        *-- (conferido em CarregarOrigem antes de chegar aqui).
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCrr"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpCrr", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpDup - duplicatas (N linhas, cidchaves proprio, mesmo join
        *-- degenerado de SigOpCrr)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpDup"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpDup", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpCdd - dados complementares (N linhas, sem cidchaves).
        *-- Legado: m.ConfigGers = Substr(m.ConfigGers,1,161) + Space(30) +
        *-- Substr(m.ConfigGers,192,59) - zera os 30 chars 162..191
        *-- (161+30+59 = 250 = Configgers char(250)). STUFF reproduz igual.
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCdd"
            loc_cSQL = THIS.MontarInsertCopia("SigOpCdd", ;
                "dopes=" + EscaparSQL(par_cDestino) + ;
                "|configgers=STUFF(configgers, 162, 30, REPLICATE(' ', 30))", ;
                "dopes = " + EscaparSQL(par_cOrigem))
            loc_lOk = !EMPTY(loc_cSQL)
            IF loc_lOk
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
            ENDIF
        ENDIF

        *-- SigMvCxs - caixas (N linhas, cidchaves proprio, liga por cdopes)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigMvCxs"
            loc_lOk = THIS.CopiarTabelaFilha("SigMvCxs", "cdopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigCcCpe - centro de custo (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigCcCpe"
            loc_lOk = THIS.CopiarTabelaFilha("SigCcCpe", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigCdMop - multi-operacao (N linhas, cidchaves proprio, liga por cdopes)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigCdMop"
            loc_lOk = THIS.CopiarTabelaFilha("SigCdMop", "cdopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpFpO - formas de pagamento (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpFpO"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpFpO", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpTrf - transferencias (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpTrf"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpTrf", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpFin - financeiro (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpFin"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpFin", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpLso - lancamentos (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpLso"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpLso", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        IF !loc_lOk AND EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
            THIS.this_cMensagemErro = "Falha ao montar a c" + CHR(243) + "pia de " + ;
                ALLTRIM(NVL(THIS.this_cEtapaAtual, "")) + "."
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBlocoSigCdPrg - Transcricao do bloco final do CmdCopia.Click
    * que registra o programa novo e as 13 permissoes em SigCdPrg. Usa
    * Menus/SubMenus/CArqIcones ja carregados pela ORIGEM (this_cMenus etc.
    * nao sao sobrescritos na copia - sao os mesmos no registro novo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarBlocoSigCdPrg(par_cDestino)
        LOCAL loc_cOperacao, loc_lUsaBarra, loc_cBarraForm, loc_cSubMenuProg, loc_cDescBase

        THIS.this_cEtapaAtual = "SigCdPrg"

        loc_cOperacao = IIF(UPPER(ALLTRIM(NVL(THIS.this_cMenus, ""))) == "CAIXA", ;
            "Menu - Financeiro - Caixa - ", ;
            "Opera" + CHR(231) + CHR(245) + "es de Estoque - ")
        THIS.this_cPrefixoMenu = loc_cOperacao

        loc_lUsaBarra = INLIST(UPPER(ALLTRIM(NVL(THIS.this_cMenus, ""))), "SISTEMA", "CAIXA") ;
            OR UPPER(ALLTRIM(NVL(THIS.this_cMenus, ""))) == "ESTOQUE"

        loc_cBarraForm = SPACE(50)
        IF loc_lUsaBarra
            loc_cBarraForm = 'SigMvExp WITH "' + UPPER(ALLTRIM(par_cDestino)) + '","E"'
        ENDIF
        THIS.this_cBarraForm = loc_cBarraForm
        THIS.this_cBarraPict = ALLTRIM(NVL(THIS.this_cArqIcones, ""))

        IF !EMPTY(ALLTRIM(NVL(THIS.this_cSubMenus, "")))
            loc_cSubMenuProg = "_" + UPPER(LEFT(ALLTRIM(THIS.this_cSubMenus), 14))
            THIS.this_cSubMenuPrg = loc_cSubMenuProg

            THIS.AcumularSubMenuPrograma(loc_cSubMenuProg, ;
                loc_cOperacao + PROPER(ALLTRIM(THIS.this_cSubMenus)))

            loc_cDescBase = loc_cOperacao + PROPER(ALLTRIM(THIS.this_cSubMenus)) + ;
                " - " + PROPER(ALLTRIM(par_cDestino))
        ELSE
            loc_cDescBase = loc_cOperacao + PROPER(ALLTRIM(par_cDestino))
        ENDIF
        THIS.this_cDescPrograma = loc_cDescBase

        THIS.AcumularProgramaBase(THIS.this_cProg, loc_cDescBase, loc_cBarraForm, THIS.this_cBarraPict)

        THIS.AcumularProgramaTipo(THIS.this_cProg, "INSERIR", ;
            loc_cDescBase + " [Inserir]", loc_cDescBase + " - [Inserir ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "ALTERAR", ;
            loc_cDescBase + " [Alterar]", loc_cDescBase + " - [Alterar ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "EXCLUIR", ;
            loc_cDescBase + " [Excluir]", loc_cDescBase + " - [Excluir ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "LISTAR", ;
            loc_cDescBase + " [Listar]", loc_cDescBase + " - [Listar ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "COTACAO", ;
            loc_cDescBase + " [Cota" + CHR(231) + CHR(227) + "o]", ;
            loc_cDescBase + " - [Cotacao ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "FORMAPAG", ;
            loc_cDescBase + " [Altera Forma de Pagamento]", ;
            loc_cDescBase + " - [Forma Pagamento ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "COMISSAO", ;
            loc_cDescBase + " [Comiss" + CHR(227) + "o]", ;
            loc_cDescBase + " - [Comissao ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "ALTPRECO", ;
            loc_cDescBase + " [Altera Pre" + CHR(231) + "o]", ;
            loc_cDescBase + " - [Altera Preco ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "CANCITEM", ;
            loc_cDescBase + " [Cancela Item]", loc_cDescBase + " - [Cancela Item ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "SERVICOS", ;
            loc_cDescBase + " [Servicos]", ;
            loc_cDescBase + " - [Servi" + CHR(231) + "os ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "QUITACAO", ;
            loc_cDescBase + " [Quita" + CHR(231) + CHR(227) + "o]", ;
            loc_cDescBase + " - [Quita" + CHR(231) + CHR(227) + "o ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "SUBNIVEL", ;
            loc_cDescBase + " [SubNivel]", loc_cDescBase + " - [SubNivel ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "DADOSCOMPL", ;
            loc_cDescBase + " [Dados Complementares]", ;
            loc_cDescBase + " - [Dados complementares ]")
    ENDPROC

    *--------------------------------------------------------------------------
    * AcumularSubMenuPrograma - "Insert Into crSigCdPrg (...) " do ramo
    * "If !ChkRegister('SigCdPrg','Programas',lcSubMenus)" - SEM ramo de
    * update (se o programa do submenu ja existe, o legado nao toca nele).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AcumularSubMenuPrograma(par_cPrograma, par_cDescricao)
        LOCAL loc_cSQL

        loc_cSQL = "IF NOT EXISTS (SELECT 1 FROM SigCdPrg WHERE programas = " + ;
            EscaparSQL(par_cPrograma) + ")" + CHR(13) + CHR(10) + ;
            "INSERT INTO SigCdPrg (Descricaos, Parametros, Programas, pkChaves, BarraForms)" + ;
            " VALUES (" + EscaparSQL(par_cDescricao) + ", '', " + EscaparSQL(par_cPrograma) + ;
            ", " + EscaparSQL(fUniqueIds()) + ", SPACE(50))"

        THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * AcumularProgramaBase - ChkRegister('SigCdPrg', @laProgs) com
    * Parametros = Space(10): registra o programa principal da operacao
    * nova, com BarraForms/BarraPict. Insert se nao existe, Update se existe
    * (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AcumularProgramaBase(par_cPrograma, par_cDescricao, par_cBarraForm, par_cBarraPict)
        LOCAL loc_cSQL, loc_cParam

        loc_cParam = EscaparSQL(SPACE(10))

        loc_cSQL = "IF NOT EXISTS (SELECT 1 FROM SigCdPrg WHERE programas = " + ;
            EscaparSQL(par_cPrograma) + " AND parametros = " + loc_cParam + ")" + CHR(13) + CHR(10) + ;
            "INSERT INTO SigCdPrg (Descricaos, Parametros, Programas, pkChaves, BarraForms, BarraPict)" + ;
            " VALUES (" + EscaparSQL(par_cDescricao) + ", " + loc_cParam + ", " + ;
            EscaparSQL(par_cPrograma) + ", " + EscaparSQL(fUniqueIds()) + ", " + ;
            EscaparSQL(par_cBarraForm) + ", " + EscaparSQL(par_cBarraPict) + ")" + CHR(13) + CHR(10) + ;
            "ELSE" + CHR(13) + CHR(10) + ;
            "UPDATE SigCdPrg SET Descricaos = " + EscaparSQL(par_cDescricao) + ;
            ", BarraForms = " + EscaparSQL(par_cBarraForm) + ;
            ", BarraPict = " + EscaparSQL(par_cBarraPict) + ;
            " WHERE programas = " + EscaparSQL(par_cPrograma) + " AND parametros = " + loc_cParam

        THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * AcumularProgramaTipo - um dos 13 ChkRegister('SigCdPrg', @laProgs)
    * com Parametros = 'INSERIR'/'ALTERAR'/etc. Insert se nao existe,
    * Update (so a Descricaos) se existe - texto de insert e de update
    * transcritos LITERALMENTE do legado, inclusive as inconsistencias de
    * acentuacao/capitalizacao entre os dois (regra #17: nunca "corrigir").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AcumularProgramaTipo(par_cPrograma, par_cParametro, par_cDescInsert, par_cDescUpdate)
        LOCAL loc_cSQL

        loc_cSQL = "IF NOT EXISTS (SELECT 1 FROM SigCdPrg WHERE programas = " + ;
            EscaparSQL(par_cPrograma) + " AND parametros = " + EscaparSQL(par_cParametro) + ")" + ;
            CHR(13) + CHR(10) + ;
            "INSERT INTO SigCdPrg (Descricaos, Parametros, Programas, pkChaves)" + ;
            " VALUES (" + EscaparSQL(par_cDescInsert) + ", " + EscaparSQL(par_cParametro) + ", " + ;
            EscaparSQL(par_cPrograma) + ", " + EscaparSQL(fUniqueIds()) + ")" + CHR(13) + CHR(10) + ;
            "ELSE" + CHR(13) + CHR(10) + ;
            "UPDATE SigCdPrg SET Descricaos = " + EscaparSQL(par_cDescUpdate) + ;
            " WHERE programas = " + EscaparSQL(par_cPrograma) + ;
            " AND parametros = " + EscaparSQL(par_cParametro)

        THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarTabelaFilha - Clona as linhas de uma tabela filha ligada pela
    * operacao de origem, uma linha de origem por INSERT, para que cada
    * registro novo receba a SUA propria chave Fortyus (regra #22: chave
    * repetida colide no indice unico de cidchaves/pkchaves).
    *
    * par_cTabela        - tabela filha
    * par_cCampoLigacao  - coluna que guarda a operacao (dopes/cdopes)
    * par_cCampoPk        - coluna da chave Fortyus (cidchaves)
    * par_cOrigem/par_cDestino - codigos da operacao
    * par_cExtra          - overrides ADICIONAIS ("col=expr|...") ou ""
    * par_cFiltro         - condicao extra no SELECT de origem, ou ""
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CopiarTabelaFilha(par_cTabela, par_cCampoLigacao, par_cCampoPk, ;
            par_cOrigem, par_cDestino, par_cExtra, par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_cPk, loc_cOvr, loc_lOk

        loc_lOk = .T.

        IF USED("cursor_4c_PkCopia")
            USE IN cursor_4c_PkCopia
        ENDIF

        loc_cSQL = "SELECT " + par_cCampoPk + " AS pk FROM " + par_cTabela + ;
            " WHERE " + par_cCampoLigacao + " = " + EscaparSQL(par_cOrigem)

        IF !EMPTY(NVL(par_cFiltro, ""))
            loc_cSQL = loc_cSQL + " AND " + par_cFiltro
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PkCopia")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao ler " + par_cTabela + ":" + ;
                CHR(13) + CapturarErroSQL()
            RETURN .F.
        ENDIF

        SELECT cursor_4c_PkCopia
        SCAN WHILE loc_lOk
            loc_cPk = ALLTRIM(NVL(cursor_4c_PkCopia.pk, ""))

            loc_cOvr = par_cCampoLigacao + "=" + EscaparSQL(par_cDestino) + ;
                "|" + par_cCampoPk + "=" + EscaparSQL(fUniqueIds())

            IF !EMPTY(NVL(par_cExtra, ""))
                loc_cOvr = loc_cOvr + "|" + par_cExtra
            ENDIF

            loc_cSQL = THIS.MontarInsertCopia(par_cTabela, loc_cOvr, ;
                par_cCampoPk + " = " + EscaparSQL(loc_cPk))

            IF EMPTY(loc_cSQL)
                loc_lOk = .F.
            ELSE
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nRegistrosCopiados = THIS.this_nRegistrosCopiados + 1
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_PkCopia")
            USE IN cursor_4c_PkCopia
        ENDIF

        IF loc_lOk
            THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarInsertCopia - Monta "INSERT INTO T (cols) SELECT exprs FROM T
    * WHERE <where>", trocando por EXPRESSAO as colunas sobrepostas. A
    * lista de colunas vem do INFORMATION_SCHEMA em tempo de execucao de
    * proposito: SigCdOpe tem 254 colunas e fixa-las aqui garantiria que no
    * dia em que o schema mudar o INSERT quebre em silencio (mesmo
    * raciocinio de ProdutoBO.MontarInsertCopia, portado aqui).
    *
    * par_cOverrides - "col=<expr SQL>|col=<expr SQL>|..." (col sem aspas,
    *                  expr ja no formato final de SQL Server)
    * Devolve "" se nao conseguir ler as colunas (o chamador aborta).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarInsertCopia(par_cTabela, par_cOverrides, par_cWhere)
        LOCAL loc_cTab, loc_cCols, loc_cExprs, loc_cCol, loc_cOvr, loc_nPos, ;
            loc_cValor, loc_nResultado, loc_nUsados, loc_nPedidos

        loc_cTab = ALLTRIM(par_cTabela)

        IF USED("cursor_4c_ColsCopia")
            USE IN cursor_4c_ColsCopia
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COLUMN_NAME AS col FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = " + EscaparSQL(loc_cTab) + ;
            " ORDER BY ORDINAL_POSITION", "cursor_4c_ColsCopia")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ColsCopia") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                "vel ler as colunas de " + loc_cTab + ":" + CHR(13) + CapturarErroSQL()
            RETURN ""
        ENDIF

        loc_cCols   = ""
        loc_cExprs  = ""
        loc_nUsados = 0

        SELECT cursor_4c_ColsCopia
        SCAN
            loc_cCol = ALLTRIM(cursor_4c_ColsCopia.col)

            loc_cValor = ""
            loc_cOvr   = "|" + ALLTRIM(NVL(par_cOverrides, "")) + "|"
            loc_nPos   = AT("|" + LOWER(loc_cCol) + "=", LOWER(loc_cOvr))

            IF loc_nPos > 0
                loc_cValor  = SUBSTR(loc_cOvr, loc_nPos + LEN(loc_cCol) + 2)
                loc_cValor  = LEFT(loc_cValor, AT("|", loc_cValor) - 1)
                loc_nUsados = loc_nUsados + 1
            ELSE
                loc_cValor = loc_cCol
            ENDIF

            loc_cCols  = loc_cCols  + IIF(EMPTY(loc_cCols),  "", ", ") + loc_cCol
            loc_cExprs = loc_cExprs + IIF(EMPTY(loc_cExprs), "", ", ") + loc_cValor
        ENDSCAN

        IF USED("cursor_4c_ColsCopia")
            USE IN cursor_4c_ColsCopia
        ENDIF

        *-- Cada override tem de ter casado com uma coluna REAL - erro de
        *-- grafia na chamada (regra #22) nasceria silencioso sem isto.
        loc_nPedidos = 0
        IF !EMPTY(NVL(par_cOverrides, ""))
            loc_nPedidos = OCCURS("|", ALLTRIM(par_cOverrides)) + 1
        ENDIF

        IF loc_nUsados < loc_nPedidos
            THIS.this_cMensagemErro = "C" + CHR(243) + "pia de " + loc_cTab + ": " + ;
                TRANSFORM(loc_nPedidos - loc_nUsados) + " de " + ;
                TRANSFORM(loc_nPedidos) + " campos a sobrepor n" + CHR(227) + ;
                "o existem na tabela." + CHR(13) + ALLTRIM(par_cOverrides)
            RETURN ""
        ENDIF

        RETURN "INSERT INTO " + loc_cTab + " (" + loc_cCols + ")" + ;
            " SELECT " + loc_cExprs + " FROM " + loc_cTab + " WHERE " + par_cWhere
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarLoteCopia - Executa this_cLoteCopia (15 tabelas + SigCdPrg)
    * numa transacao ATOMICA unica: o VFP ja abre transacao propria por
    * conta do SQLEXEC (medido: @@TRANCOUNT = 1 numa conexao recem-aberta)
    * - um BEGIN/COMMIT direto so ANINHARIA sem efetivar nada no ROLLBACK
    * (mesmo achado de ProdutoBO.CopiarProduto). Por isso SAVE TRANSACTION
    * quando ja ha transacao aberta (o caso normal aqui) e THROW no CATCH
    * para o erro chegar ao retorno do SQLEXEC.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarLoteCopia()
        LOCAL loc_cSQL, loc_nResultado, loc_lOk

        loc_lOk = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteCopia, "")))
            THIS.this_cMensagemErro = "Nada para copiar."
            RETURN .F.
        ENDIF

        loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
            "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
            "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
            "ELSE SAVE TRANSACTION Cop4c;" + CHR(13) + CHR(10) + ;
            "BEGIN TRY" + CHR(13) + CHR(10) + ;
            THIS.this_cLoteCopia + ;
            "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
            "END TRY" + CHR(13) + CHR(10) + ;
            "BEGIN CATCH" + CHR(13) + CHR(10) + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cop4c; END;" + CHR(13) + CHR(10) + ;
            "THROW;" + CHR(13) + CHR(10) + ;
            "END CATCH"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao gravar a c" + CHR(243) + "pia (" + ;
                ALLTRIM(NVL(THIS.this_cEtapaAtual, "")) + "):" + CHR(13) + CapturarErroSQL()
            loc_lOk = .F.
        ELSE
            loc_lOk = .T.
        ENDIF

        THIS.this_cLoteCopia = ""

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE
