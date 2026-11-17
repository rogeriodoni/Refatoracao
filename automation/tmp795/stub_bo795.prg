*-- Stub do SIGOPRESBO: nao consulta o banco. Popula cursor_4c_Dados com uma
*-- janela de 10 dias e posiciona o ponteiro na "data da operacao" (5o dia),
*-- exatamente como ObterSaldoNaData faz depois do SEEK.
DEFINE CLASS StubSIGOPRESBO AS Custom
    this_nSaldo        = 0
    this_nSaldoInicial = 0
    this_cMensagemErro = ""
    this_lDeveFalhar   = .F.
    this_nRecnoAlvo    = 5

    PROCEDURE CarregarDoCursor(par_cAlias)
        RETURN .T.
    ENDPROC

    PROCEDURE AtualizarJanelaDatas()
        RETURN .T.
    ENDPROC

    FUNCTION ExecutarCalculo()
        LOCAL lnI
        IF THIS.this_lDeveFalhar
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (datas D, estoque N(11,3))
        FOR lnI = 1 TO 10
            INSERT INTO cursor_4c_Dados (datas, estoque) VALUES (DATE() + lnI, lnI * 10)
        ENDFOR
        INDEX ON datas TAG datas

        *-- equivale ao SEEK da data da operacao
        SELECT cursor_4c_Dados
        GO THIS.this_nRecnoAlvo
        THIS.this_nSaldo = cursor_4c_Dados.estoque

        RETURN .T.
    ENDFUNC
ENDDEFINE
