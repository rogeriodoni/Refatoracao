*==============================================================================
* SIGOPTOPBO.PRG
* Business Object para o dialogo de Transportes da Operacao
* (SIGOPTOP - dialogo filho MODAL aberto pelo form pai SIGCDOPE via
*  "Do Form SigOpTop With ThisForm, nDataSession", NAO acessivel direto
*  pelo menu)
*
* Tabela de contexto : SigCdOpe (operacao) - usada SOMENTE para montar o
*                       Caption do dialogo a partir da linha corrente do
*                       form pai (crSigCdOpe.Dopes)
* Tabela consultada   : SigCdMei (meios de transporte)
* Chave Real (PK)     : cidchaves  CHAR(20)
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGOPTOP linhas 286-342):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe, lista
*   de operacoes) e pnDataSes e a DataSession do pai - o dialogo faz
*   "Set DataSession to pnDataSes" para conseguir ler crSigCdOpe (cursor do
*   pai) diretamente, antes de abrir a propria DataSession = 2 privada.
*
*   O Caption e montado como:
*     'Transportes da Operacao ' + AllTrim(Proper(crSigCdOpe.Dopes))
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Em seguida monta e executa:
*     Select Distinct Substring(TipoEmps,1,6) as Codigos,
*                      Substring(TipoEmps,7,3) as Emps
*     From SigCdMei Where Dopes = '<crSigCdOpe.Dopes>'
*   TipoEmps e CHAR(9) em SigCdMei: os 6 primeiros caracteres sao o codigo
*   do transporte (Codigos) e os 3 ultimos sao o codigo da empresa (Emps) -
*   SAO os dois UNICOS campos exibidos na grade (GradeSubN, 2 colunas).
*
*   O dialogo e SOMENTE LEITURA (Column1.ReadOnly = .T. e Column2.ReadOnly
*   = .T. no SCX, sem nenhum botao de gravacao) - o unico botao e cmdSair
*   (Caption "Encerrar"), que reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase
*   (recusar a operacao e reportar pelo ExibirFalha do Salvar) ja eh o
*   correto, e inventar INSERT/UPDATE aqui violaria a regra #22 do
*   CLAUDE.md (a lista de colunas vem do schema, nunca de adivinhacao).
*==============================================================================

DEFINE CLASS SigOpTopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado)
    * Somente leitura: alimenta o Caption / titulo do dialogo e o filtro
    * da consulta a SigCdMei.
    *--------------------------------------------------------------------------
    this_cDopes              = ""  && dopes    CHAR(20) - codigo da operacao (contexto, vindo do form pai)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA GRADE DE TRANSPORTES (CrSigCdMei no legado)
    * Resultado da SELECT DISTINCT Substring(TipoEmps,...) descrita no
    * cabecalho - SigCdMei.TipoEmps CHAR(9) nunca e exibido por inteiro,
    * so os dois pedacos abaixo.
    *--------------------------------------------------------------------------
    this_cCodigos            = ""  && Codigos  CHAR(6)  - Substring(TipoEmps,1,6) - codigo do transporte (grid "Cod.Transporte")
    this_cEmps               = ""  && Emps     CHAR(3)  - Substring(TipoEmps,7,3) - codigo da empresa (grid "Empresa")

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_cCursorTransportes : alias migrado de CrSigCdMei. O cursor e
    *   populado por este BO (SQLEXEC contra SigCdMei) e apenas exibido
    *   pelo Form, sem edicao.
    *--------------------------------------------------------------------------
    this_cCursorTransportes  = "cursor_4c_Transportes"
    this_cTituloDialogo      = ""
    this_nTotalTransportes   = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este
    * dialogo nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela realmente consultada
    * (SigCdMei), usada para montar a grade de transportes.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdMei"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTransportes - Popula this_cCursorTransportes com os transportes
    * da operacao informada.
    *
    * Transcricao literal da consulta do legado (SIGOPTOP linhas 286-342):
    *   Select Distinct Substring(TipoEmps,1,6) as Codigos,
    *                    Substring(TipoEmps,7,3) as Emps
    *   From SigCdMei Where Dopes = '<par_cDopes>'
    *
    * SQLEXEC roda contra um cursor TEMPORARIO (nunca direto em
    * cursor_4c_Transportes) porque esse alias pode ja estar ligado ao
    * RecordSource do grd_4c_Dados do Form - reatribuir o alias via SQLEXEC
    * zeraria o ColumnCount do grid (regra do CLAUDE.md sobre SQLEXEC em
    * cursor ligado a Grid). O resultado e copiado com ZAP + APPEND FROM
    * DBF(), que preserva a estrutura/binding do cursor permanente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTransportes(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_cDopes

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalTransportes = 0

        IF VARTYPE(par_cDopes) != "C" OR EMPTY(ALLTRIM(par_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cDopes = ALLTRIM(par_cDopes)

        IF USED("cursor_4c_TransportesTmp")
            IF CURSORGETPROP("Buffering", "cursor_4c_TransportesTmp") > 1
                TABLEREVERT(.T., "cursor_4c_TransportesTmp")
            ENDIF
            USE IN cursor_4c_TransportesTmp
        ENDIF

        loc_cSQL = "SELECT DISTINCT SUBSTRING(TipoEmps, 1, 6) AS Codigos, " + ;
                   "SUBSTRING(TipoEmps, 7, 3) AS Emps " + ;
                   "FROM SigCdMei " + ;
                   "WHERE Dopes = " + EscaparSQL(loc_cDopes)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TransportesTmp")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorTransportes)
            SELECT (THIS.this_cCursorTransportes)
            ZAP
            IF RECCOUNT("cursor_4c_TransportesTmp") > 0
                APPEND FROM DBF("cursor_4c_TransportesTmp")
            ENDIF
            GO TOP IN (THIS.this_cCursorTransportes)
        ELSE
            SELECT * FROM cursor_4c_TransportesTmp INTO CURSOR (THIS.this_cCursorTransportes) READWRITE
        ENDIF

        IF USED("cursor_4c_TransportesTmp")
            USE IN cursor_4c_TransportesTmp
        ENDIF

        THIS.this_nTotalTransportes = IIF(USED(THIS.this_cCursorTransportes), RECCOUNT(THIS.this_cCursorTransportes), 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTituloDialogo - Monta o Caption do dialogo a partir do codigo da
    * operacao do form pai (crSigCdOpe.Dopes), reproduzindo:
    *   'Transportes da Operacao ' + AllTrim(Proper(crSigCdOpe.Dopes))
    *--------------------------------------------------------------------------
    FUNCTION ObterTituloDialogo(par_cDopes)
        LOCAL loc_cDopes

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

        THIS.this_cDopes         = loc_cDopes
        THIS.this_cTituloDialogo = "Transportes da Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(PROPER(loc_cDopes))

        RETURN THIS.this_cTituloDialogo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega da linha corrente de cursor_4c_Transportes
    * (ou outro alias informado) para as propriedades this_cCodigos/this_cEmps.
    * Usado pelo Form para ler a linha selecionada na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorTransportes)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cCodigos = TratarNulo(Codigos, "")
        THIS.this_cEmps    = TratarNulo(Emps, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de tabela real neste dialogo (regra #22
    * nao se aplica: SigCdMei.TipoEmps nao e gravado por aqui, so consultado).
    * A combinacao Codigos+Emps identifica a linha corrente na grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodigos, "")) + ALLTRIM(NVL(THIS.this_cEmps, ""))
    ENDPROC

ENDDEFINE
