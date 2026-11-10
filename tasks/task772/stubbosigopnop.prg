*==============================================================================
* stubbosigopnop.prg - Stub do Business Object usado SO pelo probe da Fase 6
* (probar_form_fase6b.prg). Registra as chamadas de PesquisarPorOP /
* PesquisarPorEnvelope sem tocar no SQL Server (192.168.200.10 eh inalcancavel
* nesta maquina) e devolve .F. = "nao localizado".
*==============================================================================
DEFINE CLASS StubBOSigOpNop AS Custom

    nChamadasOP  = 0
    nChamadasEnv = 0
    nUltimoOP    = 0
    nUltimoEnv   = 0

    *-- Properties que CarregarDados le no caminho de "nao localizado"
    this_cMensagemErro  = ""
    this_cCursorArvore  = "cursor_4c_Arvore"
    this_cCursorProduto = "cursor_4c_Produto"
    this_cArquivoImagem = ""

    PROCEDURE PesquisarPorOP(par_nNumeroOP)
        THIS.nChamadasOP = THIS.nChamadasOP + 1
        THIS.nUltimoOP   = IIF(VARTYPE(par_nNumeroOP) = "N", par_nNumeroOP, 0)
        THIS.this_cMensagemErro = ""
        RETURN .F.
    ENDPROC

    PROCEDURE PesquisarPorEnvelope(par_nNumeroEnvelope)
        THIS.nChamadasEnv = THIS.nChamadasEnv + 1
        THIS.nUltimoEnv   = IIF(VARTYPE(par_nNumeroEnvelope) = "N", par_nNumeroEnvelope, 0)
        THIS.this_cMensagemErro = ""
        RETURN .F.
    ENDPROC


    *-- Acrescentado na Fase 7: CmdEncerrarClick chama este metodo (eh o
    *-- "Delete File (ThisForm.Arqfigura)" do legado). Reproduz o contrato do
    *-- SIGOPNOPBO.ExcluirImagemTemporaria real - apaga o arquivo se existir e
    *-- ZERA this_cArquivoImagem - para o probe poder medir os dois efeitos.
    nChamadasExcluirImagem = 0

    PROCEDURE ExcluirImagemTemporaria()
        LOCAL loc_cArquivo, loc_cSafety

        THIS.nChamadasExcluirImagem = THIS.nChamadasExcluirImagem + 1

        loc_cArquivo = ALLTRIM(THIS.this_cArquivoImagem)
        THIS.this_cArquivoImagem = ""

        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            CLEAR RESOURCES

            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF

            DELETE FILE (loc_cArquivo)

            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC
ENDDEFINE
