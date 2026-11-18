*==============================================================================
* SigOpStsBO.prg - Business Object para "Status por Operacoes" (SIGOPSTS)
*
* Origem legado : SigOpSts.SCX  (tasks\task808)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes)
* Tabela base   : SIGOPSTS | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que mantem a lista de STATUS permitidos para UMA operacao-pai
* (crSigCdOpe.Dopes). O legado recebe no Init "poForm" (o form pai),
* "pnDataSes" (DataSession do pai) e "pcEscolha" (INSERIR/ALTERAR/PROCURAR),
* troca para a DataSession do pai, DESABILITA os botoes do pai
* (mCtrlBotoes(.F.)) e popula um cursor local com:
*
*   Select a.*, b.Descs From SIGOPSTS a, SigStats b
*    Where a.Dopes = '<operacao-pai>' And a.Status = b.cods
*
* A grade (GradeSubN) tem 2 colunas:
*   Column1 -> status (TextBox EDITAVEL com lookup em SigStats.Cods;
*              When = Empty(LocalStats.status), ou seja so a linha NOVA,
*              ainda sem status, aceita digitacao)
*   Column2 -> Descs  (TextBox com When = .F. - somente leitura, a descricao
*              vem do lookup e nao eh digitada)
* Botoes: Inserir (acrescenta UMA linha em branco e foca a Column1),
* Excluir (Delete da linha corrente do cursor) e Encerrar (valida duplicidade,
* grava, reabilita os botoes do pai e fecha).
*
* GRAVACAO - eh REPLACE-ALL, nao linha-a-linha (regra do legado, transcrita)
* ---------------------------------------------------------------------------
* O cmdSair.Click do legado so grava quando (a) Inserir OU Excluir estao
* visiveis (ou seja, o pai esta em INSERIR/ALTERAR) E (b) houve inclusao ou
* exclusao na sessao do dialogo (lHouveIns Or lHouveExcl). Nessa condicao ele:
*   1) valida duplicidade - "Select status, sum(1) as TT From LocalStats
*      Group By 1" e, achando TT > 1, avisa
*      "Status <X> Digitado em Duplicidade!!!!" e ABORTA a gravacao
*      (Return .f. - o dialogo NAO fecha);
*   2) reconstroi o conjunto inteiro: Zap no cursor remoto + um Insert por
*      linha do cursor local, PULANDO (Loop) as linhas com status em branco,
*      sempre com Dopes = <operacao-pai> e CidChaves = fUniqueIds();
*   3) persiste dentro de transacao: Delete From SIGOPSTS Where Dopes =
*      '<operacao-pai>' -> UpDate do cursor -> Commit, com RollBack em
*      qualquer falha e a mensagem
*      "Erro na Gravacao dos Dados do Cadastro de Status.".
* Quem faz os passos 1 a 3 eh ESTE BO (ExisteStatusDuplicado / GravarStatus):
* sao regra de negocio e acesso a dados, nao UI. O form so decide QUANDO
* chamar (clique do Encerrar) e exibe o que o BO devolver.
*
* ESTADO DA SESSAO - DONO UNICO EH ESTE BO
* ----------------------------------------
* lHouveIns / lHouveExcl do legado viram this_lHouveInclusao /
* this_lHouveExclusao AQUI, e nao no form. Motivo: quem decide se grava eh a
* regra de gravacao acima, que mora neste BO; duas copias (uma no form, uma
* no BO) divergem em silencio e o Encerrar passa a ler a copia errada - ou
* grava sem alteracao nenhuma, ou nao grava o que o usuario mexeu, sem erro
* na tela. O form ESCREVE nessas duas properties nos mesmos pontos do legado
* (BtnInserirClick / BtnExcluirClick) e NAO declara copias proprias.
*
* CONTROLE DE ACESSO FICA NO FORM
* -------------------------------
* fChecaAcesso('SIGOPSTS','INSERIR') / fChecaAcesso('SIGOPSTS','EXCLUIR') do
* Init legado decidem Visible/Enabled de cmdInserir/cmdExcluir - isso eh UI e
* fica no form (que tambem combina com this_cEscolha e redimensiona o Shape1,
* igual ao legado). O BO guarda apenas o CONTEXTO recebido do pai
* (this_cOperacaoPai / this_cEscolha / this_nDataSessionPai).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos controles,
* no LEFT() dos comandos SQL e no dimensionamento do cursor da grade
* ---------------------------------------------------------------------------
*   SIGOPSTS.cidchaves  char(20)      NOT NULL  (PK - fUniqueIds())
*   SIGOPSTS.dopes      char(20)      NOT NULL  (FK SigCdOpe.dopes)
*   SIGOPSTS.status     char(1)       NOT NULL  (FK SigStats.cods)
*   SigStats.cods       char(1)       NOT NULL  (codigo do status - lookup)
*   SigStats.descs      char(20)      NOT NULL  (descricao do status)
*   SigStats.chkvisivel numeric(1,0)  NOT NULL
*   SigCdOpe.dopes      char(20)      NOT NULL  (PK e descricao ao mesmo
*                        tempo - SigCdOpe eh single-column, NUNCA usar
*                        descrs/Descs nessa tabela)
*
* As TRES colunas de SIGOPSTS sao NOT NULL e a tabela nao tem outras colunas,
* portanto o INSERT desta entidade cobre a tabela inteira (regra #22).
*==============================================================================

DEFINE CLASS SigOpStsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - uma linha de status da operacao (SIGOPSTS)
    *--------------------------------------------------------------------------
    this_cCidChaves        = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cDopes            = ""   && dopes     char(20) NOT NULL - operacao-pai (FK SigCdOpe.dopes)
    this_cStatus           = ""   && status    char(1)  NOT NULL - codigo do status (FK SigStats.cods)

    *--------------------------------------------------------------------------
    * DESCRICAO DO STATUS - SigStats.descs char(20)
    *
    * NAO pertence a SIGOPSTS: vem do join com SigStats (b.Descs do SELECT do
    * Init legado) e alimenta a Column2 da grade, que eh somente leitura
    * (When = .F.). Entra no cursor da grade e nas properties para a tela
    * poder exibir, mas NUNCA no INSERT/UPDATE de SIGOPSTS.
    *--------------------------------------------------------------------------
    this_cDescs            = ""   && descs     char(20) NOT NULL em SigStats (exibicao)

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    * Legado: Init(poForm, pnDataSes, pcEscolha) + crSigCdOpe.Dopes
    *--------------------------------------------------------------------------
    this_cOperacaoPai      = ""   && crSigCdOpe.Dopes - operacao corrente na Lista do pai (char(20))
    this_cEscolha          = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_nDataSessionPai   = 0    && pnDataSes do legado (DataSessionId do form pai)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO (dono unico - ver cabecalho)
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSTS
    *--------------------------------------------------------------------------
    this_lHouveInclusao    = .F.  && lhouveins  - o usuario acrescentou linha nesta sessao
    this_lHouveExclusao    = .F.  && lhouveexcl - o usuario excluiu linha nesta sessao

    *--------------------------------------------------------------------------
    * RESULTADO DA VALIDACAO DE DUPLICIDADE
    *
    * Guarda o codigo de status repetido encontrado no cursor da grade, para o
    * form montar a mensagem do legado "Status <X> Digitado em Duplicidade!!!!"
    * com o MESMO codigo que o legado mostraria (Alltrim(Totais.status)).
    *--------------------------------------------------------------------------
    this_cStatusDuplicado  = ""   && codigo do status repetido (vazio = sem duplicidade)

    *--------------------------------------------------------------------------
    * QUANTAS LINHAS O ULTIMO LOTE DE GRAVACAO INSERE
    *
    * MontarLoteGravacao a preenche; GravarStatus a le para saber quantas
    * chaves de loc_aChaves sao validas (VFP nao devolve dois valores, e o
    * array ja eh o parametro por referencia). Zero eh resultado LEGITIMO: o
    * usuario apagou todas as linhas e o lote fica so com o DELETE.
    *--------------------------------------------------------------------------
    this_nLinhasLote       = 0

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - o PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorStatus     = "cursor_4c_Status"   && LocalStats    - linhas de SIGOPSTS da operacao-pai + Descs (grade, READWRITE)
    this_cCursorBusca      = "cursor_4c_Busca"    && CrListaRemota - universo do lookup da Column1 (SigStats: Cods/Descs)
    this_cCursorTotais     = "cursor_4c_Totais"   && Totais        - agrupamento por status usado na checagem de duplicidade

    *--------------------------------------------------------------------------
    * ListarStatusOperacao (Fase 4) - popula this_cCursorStatus
    * (cursor_4c_Status) com o join de SIGOPSTS x SigStats da operacao-pai,
    * equivalente ao Sqlexecute(lcSql, 'LocalStats') do Init legado. Eh o
    * que alimenta a grade do form (FormSigOpSts.CarregarDados). Ver o
    * metodo abaixo para o detalhamento completo.
    *
    * ExisteStatusDuplicado / GravarStatus (Fase 7) - os passos 1 a 3 do
    * cmdSair.Click legado descritos no cabecalho do arquivo: a validacao de
    * duplicidade sobre o cursor da grade e o REPLACE-ALL transacional em
    * SIGOPSTS. Chamados por FormSigOpSts.BtnSairClick ("Encerrar"), que eh o
    * unico ponto de gravacao desta tela. Ver os metodos abaixo.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SIGOPSTS.cidchaves) e repoe o
    * estado inicial da sessao do dialogo, que no legado eh o estado do form
    * recem-criado: nenhuma inclusao e nenhuma exclusao ainda ocorridas, e
    * nenhuma duplicidade detectada.
    *
    * NAO chama fChecaAcesso aqui: a permissao eh decidida no form (ver
    * cabecalho) e a funcao real do Framework legado abre conexao SQL, o que
    * tornaria a simples criacao do BO dependente de banco.
    *
    * NAO passa a tabela para o DODEFAULT(): BusinessBase.Init(pcTabela) so
    * usa o parametro para instanciar um DataAccess, e esta entidade eh
    * gravada por comandos SQL proprios (replace-all em transacao), igual ao
    * legado.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SIGOPSTS"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nDataSessionPai  = 0
        THIS.this_lHouveInclusao   = .F.
        THIS.this_lHouveExclusao   = .F.
        THIS.this_cStatusDuplicado = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de status
    * (SIGOPSTS) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Status, populado pelo join com SigStats, ou qualquer outro
    * cursor/SELECT que inclua as mesmas colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_cStatus    = TratarNulo(status,    "C")

                *-- Descs vem do JOIN com SigStats (b.Descs do Init legado),
                *-- nao de SIGOPSTS - so existe quando o cursor foi montado
                *-- com o join (cursor_4c_Status); um cursor so com as
                *-- colunas de SIGOPSTS nao tem esse campo.
                IF TYPE(par_cAliasCursor + ".descs") != "U"
                    THIS.this_cDescs = TratarNulo(descs, "C")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarStatusOperacao - Popula cursor_4c_Status com as linhas de
    * SIGOPSTS da operacao-pai, equivalente ao legado:
    *
    *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
    *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
    *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
    *
    * O join com SigStats (igualdade a.Status = b.cods) so traz linhas com
    * status JA preenchido e valido - igual ao legado, cujas linhas em
    * branco inseridas pelo botao Inserir NAO vem desta consulta: elas sao
    * criadas DIRETO no cursor local (CmdInserirClick), nunca
    * reconsultadas aqui.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): a Column1 da grade (status) eh editavel nas linhas sem
    * status ainda (regra do legado When = Empty(status)) e os botoes
    * Inserir/Excluir inserem e apagam linha direto no cursor
    * local, igual ao legado (Insert Into LocalStats / Delete). Sem
    * READWRITE a celula nem entra em edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarStatusOperacao(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg):
        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.status, b.descs" + ;
                       " FROM SIGOPSTS a" + ;
                       " INNER JOIN SigStats b ON a.status = b.cods" + ;
                       " WHERE a.dopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_StatusTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Status")
                    USE IN cursor_4c_Status
                ENDIF

                SELECT * FROM cursor_4c_StatusTmp INTO CURSOR cursor_4c_Status READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar os status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.ListarStatusOperacao:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteStatusDuplicado - 1a validacao do cmdSair.Click legado:
    *
    *   Select status,sum(1) as TT From LocalStats GROUP by 1 Into cursor Totais
    *   Select Totais
    *   Scan
    *       If TT > 1
    *           MessageBox('Status '+Alltrim(Totais.status)+ ;
    *                      ' Digitado em Duplicidade!!!!',0+16,'Atencao')
    *           Return .f.
    *       EndIf
    *   EndScan
    *
    * Guarda em this_cStatusDuplicado o codigo do PRIMEIRO status repetido: o
    * "Return .f." do legado esta DENTRO do Scan, portanto ele para no primeiro
    * grupo com TT > 1 e eh esse codigo que aparece na mensagem. Guardar a
    * lista inteira mudaria a mensagem da tela.
    *
    * TRANSCRICAO LITERAL (regra #17): o "GROUP by 1" agrupa pela coluna 1
    * (status) SEM excluir o status em branco, logo DUAS linhas novas ainda sem
    * status tambem contam como duplicidade - e a mensagem sai com o codigo
    * vazio ("Status  Digitado em Duplicidade!!!!"). Esse eh o comportamento da
    * tela e NAO se "conserta" aqui: eh ele que impede o usuario de acumular
    * varias linhas em branco na grade.
    *
    * Linha marcada para exclusao NAO entra: SET DELETED ON (config.prg) a
    * esconde do SELECT, igual ao legado.
    *
    * O alias corrente eh salvo e restaurado: este dialogo roda na DataSession
    * do form pai (DataSession = 1), onde deixar outro alias selecionado
    * atrapalharia quem chamou.
    *
    * Metodo PUBLIC (regra #51): quem o chama eh o Encerrar do form, de fora
    * desta classe - PROTECTED faria a chamada estourar em runtime.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ExisteStatusDuplicado()
        LOCAL loc_cAliasAnterior, loc_lDuplicado

        THIS.this_cStatusDuplicado = ""

        IF !USED(THIS.this_cCursorStatus)
            RETURN .F.
        ENDIF

        loc_lDuplicado     = .F.
        loc_cAliasAnterior = ALIAS()

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        SELECT status, SUM(1) AS tt ;
            FROM (THIS.this_cCursorStatus) ;
            GROUP BY 1 ;
            INTO CURSOR (THIS.this_cCursorTotais) READWRITE

        *-- Legado: Scan / If TT > 1 -> mensagem com ESTE status e para
        SELECT (THIS.this_cCursorTotais)
        SCAN
            IF tt > 1
                THIS.this_cStatusDuplicado = ALLTRIM(NVL(status, ""))
                loc_lDuplicado = .T.
                EXIT
            ENDIF
        ENDSCAN

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarLoteGravacao - monta o LOTE SQL unico do REPLACE-ALL de
    * GravarStatus (ver o comentario daquele metodo para o legado completo) e
    * devolve, em par_aChaves, as PKs que o lote insere; this_nLinhasLote diz
    * quantas posicoes do array sao validas.
    *
    * Transcreve duas coisas do legado, nesta ordem:
    *   1. "Delete From SIGOPSTS Where Dopes = '<op>'" - INCONDICIONAL, e
    *      ANTES dos inserts, para nao apagar o que acabou de entrar. Lote so
    *      com o DELETE eh resultado LEGITIMO: eh o usuario que apagou todas as
    *      linhas da grade.
    *   2. "Scan / Scatter Memvar / If Empty(m.status) -> Loop / Insert Into
    *      CrSIGOPSTS (Dopes,status,CidChaves)" - uma linha por status
    *      PREENCHIDO, descartando a linha em branco que o botao Inserir criou
    *      e o usuario nao completou (status eh char(1) NOT NULL - regra #22).
    *      Linha marcada para exclusao nao entra: SET DELETED ON a esconde do
    *      SCAN, igual ao legado.
    *
    * Envelope transacional em T-SQL, num SQLEXEC unico (nao em SQLEXEC
    * separados): a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
    * entao BEGIN/COMMIT avulsos so ANINHAM e o COMMIT nao efetiva. SAVE
    * TRANSACTION cobre o caso (normal) de ja haver transacao aberta, e o THROW
    * faz o erro chegar ao SQLEXEC, que devolve -1 e deixa CapturarErroSQL()
    * com a mensagem real.
    *
    * EXTRAIDO de GravarStatus de proposito: assim o TEXTO do lote pode ser
    * conferido sem banco (o SQL Server deste projeto eh inalcancavel da
    * maquina do pipeline), e a montagem - que eh a regra do legado - fica
    * separada da execucao/transacao, que eh infraestrutura.
    *
    * PROTECTED: eh peca interna de GravarStatus, nao se chama de fora (regra
    * #51); o harness de teste a alcanca por SUBCLASSE.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarLoteGravacao(par_cOperacaoPai, par_aChaves)
        LOCAL loc_cStmts, loc_cStatus, loc_cCidChaves, loc_cOperacaoPai, ;
              loc_cAliasAnterior

        THIS.this_nLinhasLote = 0
        loc_cStmts            = ""
        loc_cOperacaoPai      = LEFT(IIF(VARTYPE(par_cOperacaoPai) = "C", ;
                                         par_cOperacaoPai, ""), 20)

        IF USED(THIS.this_cCursorStatus)
            loc_cAliasAnterior = ALIAS()
            SELECT (THIS.this_cCursorStatus)

            SCAN
                loc_cStatus = LEFT(ALLTRIM(NVL(status, "")), 1)

                IF !EMPTY(loc_cStatus)
                    *-- cidchaves eh a PK Fortyus (regra #22): SEMPRE gerada
                    *-- com fUniqueIds(), nunca em branco - o legado tambem a
                    *-- regera a cada linha do Zap/Insert
                    loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)

                    THIS.this_nLinhasLote = THIS.this_nLinhasLote + 1
                    DIMENSION par_aChaves[THIS.this_nLinhasLote]
                    par_aChaves[THIS.this_nLinhasLote] = loc_cCidChaves

                    loc_cStmts = loc_cStmts + ;
                        "INSERT INTO SIGOPSTS (cidchaves, dopes, status) VALUES (" + ;
                        EscaparSQL(loc_cCidChaves) + ", " + ;
                        EscaparSQL(loc_cOperacaoPai) + ", " + ;
                        EscaparSQL(loc_cStatus) + "); "
                ENDIF
            ENDSCAN

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN "SET NOCOUNT ON; " + ;
            "DECLARE @nivel int = @@TRANCOUNT; " + ;
            "IF @nivel = 0 BEGIN TRANSACTION " + ;
            "ELSE SAVE TRANSACTION Sts4c; " + ;
            "BEGIN TRY " + ;
            "DELETE FROM SIGOPSTS WHERE dopes = " + ;
            EscaparSQL(loc_cOperacaoPai) + "; " + ;
            loc_cStmts + ;
            "IF @nivel = 0 COMMIT TRANSACTION; " + ;
            "END TRY " + ;
            "BEGIN CATCH " + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Sts4c; END; " + ;
            "THROW; " + ;
            "END CATCH"
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarStatus - persiste a lista de status da operacao-pai. Equivale ao
    * bloco de gravacao do cmdSair.Click legado, que eh um REPLACE-ALL:
    *
    *   Select CrSIGOPSTS
    *   Zap
    *   Select LocalStats
    *   Scan
    *       Scatter Memvar
    *       If Empty(m.status)
    *           Loop
    *       Endif
    *       Insert Into CrSIGOPSTS (Dopes,status,CidChaves) Values ;
    *           (CrSigCdOpe.Dopes,m.status,fUniqueIds())
    *   EndScan
    *   m.lnErro1 = ThisForm.ParentForm.poDatamgr.pnIdConn
    *   If m.lnErro1>0 : lcDelete = [Delete From SIGOPSTS Where Dopes = '<op>']
    *                    m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSIGOPSTS'),1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
    *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
    *   If Not m.lnErro1>0 : MessageBox('Erro na Gravacao dos Dados do
    *                                   Cadastro de Status.',48)
    *
    * O "Zap + Scan + Insert" enche a view remota com o conjunto NOVO INTEIRO
    * (toda linha fica nova, logo o UpDate manda INSERT) e o Delete apaga o
    * conjunto ANTIGO: o efeito liquido eh SUBSTITUIR todos os status da
    * operacao. Por isso o DELETE eh INCONDICIONAL e roda mesmo quando nao
    * sobrou nenhuma linha com status preenchido - o usuario que apagou todas
    * as linhas da grade quer a operacao sem status nenhum, e um "nada a
    * gravar" ali engoliria essa intencao em silencio.
    *
    * "If Empty(m.status) / Loop" eh o descarte da linha em branco: a linha que
    * o botao Inserir criou e o usuario nao preencheu NAO vai para o banco
    * (status eh char(1) NOT NULL - regra #22).
    *
    * ATOMICIDADE: o legado faz Delete + N Inserts numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    * Mesmo lote canonico de SigOpNchBO.GravarNumeracao.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *
    * As duas flags de sessao sao ZERADAS no sucesso: elas sao o guard que faz
    * o Encerrar gravar UMA vez ("If (lHouveExcl Or lHouveIns)" do legado). No
    * legado o dialogo fecha logo apos gravar e nao existe um segundo Encerrar;
    * zerar aqui garante o mesmo efeito - um segundo Encerrar com a grade
    * intacta nao repetiria Delete + Insert (que regravaria o MESMO conjunto
    * com cidchaves novas e poluiria a auditoria).
    *
    * A auditoria (LogAuditoria, exigencia do sistema novo - o legado nao a
    * tem) roda DEPOIS do commit, uma linha por status efetivamente gravado, e
    * nunca dentro do lote: o lote eh montado para ser atomico sobre SIGOPSTS e
    * a auditoria nao pode poder derruba-lo.
    *
    * Metodo PUBLIC (regra #51): chamado pelo Encerrar do form.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION GravarStatus(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cAliasAnterior, loc_nLinhas, loc_cLote, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_lSucesso, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        loc_lManual  = .F.
        loc_nLinhas  = 0
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C" AND ;
                               !EMPTY(par_cOperacaoPai), par_cOperacaoPai, ;
                               THIS.this_cOperacaoPai)

        *-- Sem operacao-pai o DELETE apagaria o conjunto de OUTRA operacao (a
        *-- de codigo em branco): recusar eh o unico caminho seguro
        IF EMPTY(loc_cOperacaoPai)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informada."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        TRY
            loc_lManual        = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            loc_cAliasAnterior = ALIAS()

            *-- Monta o lote e devolve em loc_aChaves as PKs que ele insere
            loc_cLote   = THIS.MontarLoteGravacao(loc_cOperacaoPai, @loc_aChaves)
            loc_nLinhas = THIS.this_nLinhasLote

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

            IF loc_nResultado < 0
                loc_cErro = CapturarErroSQL()

                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF

                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                    "o dos Dados do Cadastro de Status." + CHR(13) + loc_cErro
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- Commit do legado (.poDataMgr.Commit())
                loc_lSucesso = .T.

                IF loc_lManual
                    IF SQLCOMMIT(gnConnHandle) < 1
                        = SQLROLLBACK(gnConnHandle)
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                            CHR(227) + "o dos Dados do Cadastro de Status." + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                    *-- O guard do Encerrar volta ao zero: o conjunto no banco
                    *-- passou a ser exatamente o da grade
                    THIS.this_lHouveInclusao = .F.
                    THIS.this_lHouveExclusao = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro em SigOpStsBO.GravarStatus:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoriaLote - grava em LogAuditoria uma linha por status
    * efetivamente gravado pelo lote de GravarStatus.
    *
    * RegistrarAuditoria do BusinessBase le a chave por ObterChavePrimaria(),
    * que devolve this_cCidChaves - por isso a property eh posicionada em cada
    * volta do laco e restaurada no fim (o chamador nao pode perceber que ela
    * foi usada como variavel de laco).
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SIGOPSTS e a auditoria nao pode poder derruba-lo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cCidChavesAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cCidChavesAnterior = THIS.this_cCidChaves

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cCidChaves = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("INSERT")
            ENDFOR

            THIS.this_cCidChaves = loc_cCidChavesAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de status (SIGOPSTS) no banco.
    * Equivalente ao trecho do legado cmdSair.Click que, dentro da transacao
    * de GravarStatus, faz "Insert Into SIGOPSTS (Dopes, Status, CidChaves)
    * Values (<operacao-pai>, <status>, fUniqueIds())" para cada linha do
    * cursor local com status preenchido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o proximo registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SIGOPSTS (cidchaves, dopes, status)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSts")
                USE IN cursor_4c_InsSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de status (SIGOPSTS) ja existente.
    * As tres colunas da entidade sao NOT NULL (regra #22) - o UPDATE regrava
    * dopes e status pela chave cidchaves.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGOPSTS SET" + ;
                       " dopes  = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " status = " + EscaparSQL(THIS.this_cStatus) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSts")
                USE IN cursor_4c_UpdSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
