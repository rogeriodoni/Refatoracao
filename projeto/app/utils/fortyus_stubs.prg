*==============================================================================
* fortyus_stubs.prg
* Stubs para funcoes utilitarias do legado Fortyus (SIGFUNCS.PRG)
* referenciadas por wrappers VCX (framework/classresp/classobj).
*
* Adicionadas incrementalmente conforme descobertas via mLeDados/mMontaGrade/etc.
* Cada funcao aqui e um NO-OP seguro OU port minimalista da versao legada.
*
* Para portar versao completa: ver /c/4install/FortyusMC/Fortyus/SIGFUNCS.PRG
*==============================================================================

*------------------------------------------------------------------------------
* fCarregaGrade - Posiciona linha corrente do grid + rola scrollbar
* Uso: chamado por clsconta.mMontaGrade apos carregar cursor.
* Stub: no-op — nao temos o mesmo Grid legado (ThisForm.Pagina.Lista.Grade).
* Se par_oGrade for objeto Grid valido, faz posicionamento minimo.
*------------------------------------------------------------------------------
FUNCTION fCarregaGrade(par_oGrade, par_nLinha)
    IF TYPE("par_oGrade") = "O" AND !ISNULL(par_oGrade)
        IF TYPE("par_oGrade.RecordSource") = "C" AND !EMPTY(par_oGrade.RecordSource) ;
                AND USED(par_oGrade.RecordSource)
            SELECT (par_oGrade.RecordSource)
            IF TYPE("par_nLinha") = "N" AND par_nLinha >= 1 AND par_nLinha <= RECCOUNT()
                GOTO par_nLinha
            ELSE
                GO TOP
            ENDIF
            par_oGrade.Refresh()
        ENDIF
    ENDIF
    RETURN .T.
ENDFUNC
