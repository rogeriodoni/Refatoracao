*==============================================================================
* SigOpPrLBO.prg - Business Object para FormSigOpPrL (Selecao de Produtos)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal), aberto por outro form
* (par_oFormPai) para o usuario marcar/desmarcar produtos de UMA linha
* (SigCdLin) numa grade. A grade eh ligada ao cursor cursor_4c_BusLin, que
* o FORM PAI ja deixa aberto e populado ANTES de abrir este dialogo (equivale
* a LocalBusLin do legado) - por isso este BO NAO faz Buscar/Inserir/Atualizar
* sobre esse cursor. O unico dado que este BO busca no SQL Server eh a
* propria linha (SigCdLin), para exibir Descricao e a figura (Figjpgs) no
* cabecalho do dialogo - equivalente ao poDataMgr.CursorQuery([SigCdLin], ...)
* do Init legado.
*==============================================================================
DEFINE CLASS SigOpPrLBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - dados da Linha (SigCdLin) exibidos no cabecalho do dialogo
    *--------------------------------------------------------------------------
    this_cCodigoLinha    = ""   && SigCdLin.linhas  - codigo da linha (char 10, PK)
    this_cDescricaoLinha = ""   && SigCdLin.descs   - descricao da linha (char 40)
    this_cFiguraLinha    = ""   && SigCdLin.figjpgs - figura da linha (text/memo, bytes do JPG)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave (SigCdLin, somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigCdLin"
                THIS.this_cCampoChave = "linhas"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da Linha (SigCdLin) do cursor
    * informado para as properties this_c*. E chamado por BuscarLinha() apos
    * o SQLEXEC que busca a linha no SQL Server (equivalente ao bloco do
    * Init legado que le LocalLin.Descs/LocalLin.FigJpgs apos o
    * poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas], pLin,
    * [FigJpgs, Descs])).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoLinha    = ALLTRIM(TratarNulo(linhas, ""))
            THIS.this_cDescricaoLinha = ALLTRIM(TratarNulo(descs, ""))
            THIS.this_cFiguraLinha    = TratarNulo(figjpgs, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinha - Busca a Linha (SigCdLin) pelo codigo para exibir a
    * Descricao e a Figura no cabecalho do dialogo. Equivalente ao
    * poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas], pLin,
    * [FigJpgs, Descs]) do Init legado - inclusive no caso de nao achar a
    * linha, onde o legado so deixa This.lblLinha.Caption/ImgLinhas em
    * branco (nao fecha o dialogo).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinha(par_cCodigoLinha)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cCursorTemp, loc_oErro

        loc_lSucesso    = .F.
        loc_cCursorTemp = "cursor_4c_SigOpPrLLinha"

        *-- Codigo da Linha ausente NAO eh falha: o legado nao trata esse caso
        *-- como erro. O "Return .f." do Init legado dispara SO quando o
        *-- CursorQuery nao chega a criar o cursor ("If Not Used([LocalLin])",
        *-- isto eh falha de CONEXAO); com pLin vazio a consulta roda, devolve
        *-- zero linha e o Init segue com "This.lblLinha.Caption = []" e a
        *-- figura oculta - o dialogo ABRE. Devolver .F. aqui faria
        *-- FormSigOpPrL.ConfigurarLinha abortar e a tela NAO abrir, o que
        *-- divergiria do legado (PILAR 1). Mesmo tratamento do ramo
        *-- "linha nao encontrada" abaixo.
        IF VARTYPE(par_cCodigoLinha) != "C" OR EMPTY(ALLTRIM(par_cCodigoLinha))
            THIS.this_cCodigoLinha    = ""
            THIS.this_cDescricaoLinha = ""
            THIS.this_cFiguraLinha    = ""
            RETURN .T.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            loc_cSQL = "SELECT Linhas, Descs, FigJpgs FROM SigCdLin " + ;
                       "WHERE Linhas = " + EscaparSQL(par_cCodigoLinha)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado > 0 AND USED(loc_cCursorTemp)
                SELECT (loc_cCursorTemp)
                GO TOP
                IF !EOF()
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursorTemp)
                ELSE
                    THIS.this_cCodigoLinha    = ALLTRIM(par_cCodigoLinha)
                    THIS.this_cDescricaoLinha = ""
                    THIS.this_cFiguraLinha    = ""
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar a Linha: " + CapturarErroSQL()
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da Linha carregada (SigCdLin.linhas)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigoLinha
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPPRL legado e um dialogo de SELECAO (marcar/desmarcar produtos de
    * uma Linha numa grade), nao um cadastro: o unico SQL remoto do Init e o
    * poDataMgr.CursorQuery([SigCdLin], ...), um SELECT de leitura para exibir
    * Descricao/Figura no cabecalho. Os dois "Update LocalBusLin Set Selecao"
    * do Header1.Click (Grade.Column1.Header1) e o Replace implicito do
    * fwcheckbox1 tem como alvo LocalBusLin/cursor_4c_BusLin, o cursor de
    * selecao que o FORM PAI ja deixa aberto e populado ANTES de abrir este
    * dialogo (ver comentario no topo do arquivo) - nunca e gravado no SQL
    * Server por este BO; quem le o resultado da selecao e o proprio form pai,
    * depois que este dialogo fecha. Nao ha TableUpdate nem AddCursor contra
    * tabela remota em lugar nenhum do dump do legado. Por isso este BO nao
    * sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para uma tela que so seleciona. CarregarDoCursor()/
    * BuscarLinha() acima sao os unicos pontos de acesso ao SQL Server que
    * este BO precisa; RegistrarAuditoria() herdado de BusinessBase tambem nao
    * e chamado, porque nao ha Inserir/Atualizar/Excluir que o dispare.
    *--------------------------------------------------------------------------

ENDDEFINE
