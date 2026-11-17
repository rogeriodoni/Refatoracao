*==============================================================================
* SIGOPPGCBO.prg - Business Object para FormSIGOPPGC (Informe os Barras)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) aberto por um form pai
* para informar as "barras" (codigos de barra) usadas como forma de pagamento
* por barras/bonus. O dialogo NAO possui tabela propria no SQL Server: ele
* grava os codigos digitados no cursor local BarBonus (criado pelo proprio
* form, no mesmo padrao de SIGOPPED), e por isso this_cTabela fica vazio.
* this_cCampoChave aponta para a coluna que identifica cada linha desse
* cursor (Codigos), usada pelo legado em "Where Codigos = This.Value".
*==============================================================================
DEFINE CLASS SIGOPPGCBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (dados manipulados pelo dialogo Informe os Barras)
    *--------------------------------------------------------------------------
    this_nSaldoInicial    = 0    && poValor - saldo recebido do form pai (ThisForm.Saldo)
    this_nSaldoAtual      = 0    && saldo apos descontar a soma dos valores das barras validas (Get_Saldo.Value)
    this_nQtdeBarras      = 0    && quantidade de barras validas digitadas (label3 "[ N ]")
    this_cDescFormaPagto  = ""   && crSigOpFp.fpags - descricao da forma de pagamento (label1.Caption)
    this_nValorPorBarra   = 0    && crSigOpFp.VlrFpgs - valor atribuido a cada barra digitada (Replace Valors)
    this_cCodigoBarra     = ""   && ultimo codigo de barra validado na celula da grade (BarBonus.Codigos)
    this_nDopeBarra       = 0    && nDope - codigo da operacao decodificado dos 4 primeiros digitos da barra
    this_nNumeBarra       = 0    && Nume - numero sequencial decodificado dos 6 ultimos digitos da barra
    this_lBarraValida     = .F.  && resultado da ultima validacao de barra contra SigCdOpe

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Codigos"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega da forma de pagamento (cursor crSigOpFp,
    * aberto pelo form pai e repassado na mesma datasession) a descricao
    * (fpags, equivalente ao label1.Caption do Init legado) e o valor
    * atribuido a cada barra (VlrFpgs, equivalente ao Replace Valors do
    * Valid legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cDescFormaPagto = TratarNulo(fpags, "")
                THIS.this_nValorPorBarra  = TratarNulo(VlrFpgs, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo de barra validado por ultimo (Codigos, a
    * mesma coluna usada pelo legado em "Where Codigos = This.Value")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoBarra
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor local BarBonus - ver Init, que por isso deixa
    * this_cTabela vazio de proposito). Sobrescrito aqui so para o log de
    * auditoria identificar o cursor afetado em vez de uma tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("BarBonus") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - A grade aceita uma barra nova por linha (sempre Codigos = 0
    * antes de validar - ver Insert Into BarBonus(Codigos) Values(0) do
    * legado); a validacao e a gravacao sao a MESMA operacao do Valid
    * legado, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Revalida uma barra ja existente na grade (usuario corrige
    * o codigo de uma linha) - mesma operacao de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBarraEAtualizarCursor - Transcricao de
    * SIGOPPGC.Grade.Column1.Text1.Valid: decodifica o codigo de barra
    * (this_cCodigoBarra, 10 digitos) nos 4 primeiros digitos (codigo da
    * operacao, this_nDopeBarra) e nos 6 ultimos (numero sequencial,
    * this_nNumeBarra); confere o codigo da operacao contra SigCdOpe;
    * confere duplicidade da mesma barra dentro do cursor local BarBonus; e,
    * se tudo valido, grava o valor da forma de pagamento (this_nValorPorBarra,
    * carregado de crSigOpFp.VlrFpgs em CarregarDoCursor) na linha corrente
    * de BarBonus.Valors.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarBarraEAtualizarCursor()
        LOCAL loc_lResultado, loc_nCodigoBarra, loc_cSqlOpe, loc_nResultado, loc_oErro

        loc_lResultado   = .T.
        loc_nCodigoBarra = VAL(THIS.this_cCodigoBarra)

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        THIS.this_lBarraValida  = .F.
        THIS.this_nDopeBarra    = 0
        THIS.this_nNumeBarra    = 0

        TRY
            IF loc_nCodigoBarra > 0
                SET DECIMALS TO 0
                THIS.this_nDopeBarra = VAL(LEFT(STR(loc_nCodigoBarra, 10), 4))
                THIS.this_nNumeBarra = VAL(RIGHT(STR(loc_nCodigoBarra, 10), 6))

                loc_cSqlOpe = "SELECT Dopes FROM SigCdOpe WHERE ndopes = " + STR(THIS.this_nDopeBarra)

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSqlOpe, "cursor_4c_ValidaOpe")

                IF loc_nResultado < 0 OR !USED("cursor_4c_ValidaOpe") OR RECCOUNT("cursor_4c_ValidaOpe") = 0
                    THIS.this_cMensagemErro = "Barra Inv" + CHR(225) + "lido!!!!"
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lResultado = .F.
                ELSE
                    IF USED("BarBonus")
                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF

                        *-- m. OBRIGATORIO: em SELECT VFP local, nome solto eh
                        *-- resolvido primeiro como COLUNA - sem o prefixo a
                        *-- consulta de duplicidade pode estourar "Column
                        *-- LOC_NCODIGOBARRA is not found" em vez de comparar
                        *-- com a variavel.
                        SELECT SUM(1) AS Qt, Codigos FROM BarBonus ;
                            WHERE Codigos = m.loc_nCodigoBarra ;
                            GROUP BY Codigos ;
                            INTO CURSOR cursor_4c_CheckDup

                        IF USED("cursor_4c_CheckDup") AND cursor_4c_CheckDup.Qt > 1
                            THIS.this_cMensagemErro = "Barra j" + CHR(225) + " digitado !!!"
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.
                            loc_lResultado = .F.
                        ELSE
                            REPLACE Valors WITH THIS.this_nValorPorBarra IN BarBonus
                            THIS.this_lBarraValida = .T.
                        ENDIF

                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Cursor de barras (BarBonus) n" + CHR(227) + "o est" + CHR(225) + " aberto."
                        THIS.this_lErroExibido = .T.
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
            ENDIF

            IF loc_lResultado AND THIS.this_lBarraValida
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar barra: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularSaldoEQuantidade - Transcricao da conta que
    * SIGOPPGC.Grade.Column1.Text1.LostFocus faz no legado:
    *
    *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
    *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
    *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
    *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
    *
    * Fica NO BO porque eh regra de negocio com FONTE UNICA (regra CLAUDE.md
    * #17 - totais calculados pelo BO, o form so espelha): grava
    * this_nQtdeBarras (contador "[ N ]" de label3) e this_nSaldoAtual (saldo
    * restante de Get_Saldo), que FormSIGOPPGC.AtualizarSaldoEQuantidade le
    * para repintar os dois controles.
    *
    * O CRITERIO do legado vai junto e eh parte da regra: "Where Codigos <> 0"
    * EXCLUI a linha em branco que o Valid acabou de abrir (o
    * "Insert Into BarBonus(Codigos) Values(0)"), senao ela entraria na
    * contagem de barras e inflaria o total em um.
    *
    * Cursor vazio / nenhuma barra valida: no legado o GROUP BY devolve ZERO
    * linhas e "Selecao.Qt"/"Selecao.Valor" lidos em EOF valem 0, ou seja
    * contador 0 e saldo = saldo inicial. Reproduzido com guarda EXPLICITA de
    * RECCOUNT, que da o mesmo resultado sem depender da leitura em EOF.
    *
    * A area de trabalho corrente eh salva e restaurada: o SELECT-SQL a troca,
    * e quem chama (o Valid da celula) depende do ponteiro de BarBonus para
    * decidir se abre linha nova.
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularSaldoEQuantidade(par_cAliasGrade)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_nRecno, loc_oErro
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasGrade) = "C" AND !EMPTY(par_cAliasGrade), ;
                         ALLTRIM(par_cAliasGrade), "BarBonus")

        THIS.this_nQtdeBarras = 0
        THIS.this_nSaldoAtual = THIS.this_nSaldoInicial

        TRY
            IF USED(loc_cAlias)
                loc_cAliasAnterior = ALIAS()
                SELECT (loc_cAlias)
                loc_nRecno = RECNO()

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- FROM por MACRO (&), nao "(loc_cAlias)": o FROM de um
                *-- SELECT-SQL do VFP nao aceita expressao de nome entre
                *-- parenteses - so literal ou substituicao de macro. Sem o
                *-- ponto final o VFP leria o "nome" ate o ";" da continuacao.
                *-- O "[ ] as Agrupar ... group by 1" do legado existe so para
                *-- forcar UMA linha de resultado; a agregacao sem GROUP BY ja
                *-- devolve exatamente uma linha, inclusive quando nenhuma
                *-- barra casa (ai com total zerado), entao a coluna constante
                *-- nao eh reproduzida - ninguem a le.
                SELECT SUM(1) AS Qt, SUM(Valors) AS Valor ;
                    FROM &loc_cAlias. ;
                    WHERE Codigos <> 0 ;
                    INTO CURSOR cursor_4c_Selecao

                IF USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
                    SELECT cursor_4c_Selecao
                    GO TOP
                    THIS.this_nQtdeBarras = NVL(cursor_4c_Selecao.Qt, 0)
                    THIS.this_nSaldoAtual = THIS.this_nSaldoInicial - ;
                                            NVL(cursor_4c_Selecao.Valor, 0)
                ENDIF

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- Repoe area e ponteiro para quem chamou (o Valid da celula
                *-- depende do RECNO de BarBonus).
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    IF loc_nRecno >= 1 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao recalcular saldo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
