SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste  = .T.
gb_4c_ValidandoUI = .F.
LOCAL lcOut, loForm, loErr, lnI, laEv[1,5], lnLinhas
lcOut = ""
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("FormSigOpSqn")
    gb_4c_ModoTeste = .T.

    loForm = CREATEOBJECT("FormSigOpSqn", .NULL., "VENDA", "INSERIR", 1)
    lcOut = lcOut + "INSTANCIA VARTYPE=" + VARTYPE(loForm) + CHR(13)+CHR(10)

    IF VARTYPE(loForm) = "O"
        lcOut = lcOut + "CAPTION=[" + loForm.Caption + "]" + CHR(13)+CHR(10)
        *-- prova os BINDEVENTs do Click dos 3 botoes
        FOR lnI = 1 TO 3
            LOCAL loBtn, lcNome
            lcNome = IIF(lnI=1,"cmd_4c_Inserir",IIF(lnI=2,"cmd_4c_Excluir","cmd_4c_Sair"))
            IF PEMSTATUS(loForm, lcNome, 5)
                loBtn = EVALUATE("loForm." + lcNome)
                IF AEVENTS(laEv, loBtn) > 0
                    lcOut = lcOut + "BIND " + lcNome + " ev=" + TRANSFORM(laEv[1,2]) + " c3=" + TRANSFORM(laEv[1,3]) + " c4=" + TRANSFORM(laEv[1,4]) + CHR(13)+CHR(10)
                ELSE
                    lcOut = lcOut + "BIND " + lcNome + " -> SEM BIND" + CHR(13)+CHR(10)
                ENDIF
            ELSE
                lcOut = lcOut + "BOTAO " + lcNome + " AUSENTE" + CHR(13)+CHR(10)
            ENDIF
        ENDFOR

        *-- cursor local de trabalho, como a grade usa
        IF USED("cursor_4c_Sequencias")
            USE IN cursor_4c_Sequencias
        ENDIF
        CREATE CURSOR cursor_4c_Sequencias (cdopes C(20), cnivels C(20), seqs N(2,0), cidchaves C(36))
        loForm.this_cOperacaoPai = "VENDA"

        *-- Inserir 2x: o LOCATE do legado deve reaproveitar a linha em branco
        loForm.CmdInserirClick()
        loForm.CmdInserirClick()
        SELECT cursor_4c_Sequencias
        COUNT TO lnLinhas FOR !DELETED()
        GO TOP
        lcOut = lcOut + "INSERIR 2x (guard LOCATE) linhas=" + TRANSFORM(lnLinhas) + " esperado=1" + CHR(13)+CHR(10)
        lcOut = lcOut + "cidchaves VAZIA? " + IIF(EMPTY(cursor_4c_Sequencias.cidchaves),"SIM-BUG","NAO-OK") + CHR(13)+CHR(10)

        *-- preenche e insere de novo: agora deve criar a 2a linha
        SELECT cursor_4c_Sequencias
        GO TOP
        REPLACE cnivels WITH "OP1", seqs WITH 1
        loForm.CmdInserirClick()
        COUNT TO lnLinhas FOR !DELETED()
        GO TOP
        lcOut = lcOut + "INSERIR apos preencher linhas=" + TRANSFORM(lnLinhas) + " esperado=2" + CHR(13)+CHR(10)

        *-- Excluir marca a linha e liga a flag
        loForm.CmdExcluirClick()
        COUNT TO lnLinhas FOR !DELETED()
        GO TOP
        lcOut = lcOut + "EXCLUIR linhas_vivas=" + TRANSFORM(lnLinhas) + ;
                " HouveExclusao=" + TRANSFORM(loForm.this_lHouveExclusao) + CHR(13)+CHR(10)

        loForm.Release()
    ENDIF
CATCH TO loErr
    lcOut = lcOut + "ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(lcOut, "C:\4c\automation\_f7sqn_probe.txt")
QUIT
