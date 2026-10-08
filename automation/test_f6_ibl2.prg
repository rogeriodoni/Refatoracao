SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
ON ERROR STRTOFILE("!! ERRO NAO TRATADO: " + MESSAGE() + " LN=" + TRANSFORM(LINENO()) + CHR(13)+CHR(10), "C:\4c\automation\test_f6_ibl2_resultado.txt", 1)
LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnI, lnJ, lcDump, lnAnt, lnDep
lcCRLF = CHR(13)+CHR(10)
lcLog  = "C:\4c\automation\test_f6_ibl2_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"
STRTOFILE("=== FASE 6 FormSIGPRIBL - prova do BINDEVENT ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gnConnHandle = -1
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_f6_ibl2_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")
SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais,C:\4c\vbmp")
SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "SIGPRIBLBO.prg") ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg" ADDITIVE

loForm = CREATEOBJECT("FormSIGPRIBL")

*-- [A] dump CRU do AEVENTS para descobrir a coluna de cada coisa
LOCAL ARRAY laEv[1,1]
lnI = AEVENTS(laEv, 0)
lcDump = "[A] AEVENTS(la,0) linhas=" + TRANSFORM(lnI) + " colunas=" + TRANSFORM(ALEN(laEv,2)) + lcCRLF
FOR lnI = 1 TO ALEN(laEv, 1)
    lcDump = lcDump + "    L" + TRANSFORM(lnI) + ":"
    FOR lnJ = 1 TO ALEN(laEv, 2)
        lcDump = lcDump + " c" + TRANSFORM(lnJ) + "=[" + ;
            IIF(VARTYPE(laEv[lnI, lnJ]) = "O", "<obj " + laEv[lnI, lnJ].Name + ">", ;
                TRANSFORM(laEv[lnI, lnJ])) + "]"
    ENDFOR
    lcDump = lcDump + lcCRLF
ENDFOR
STRTOFILE(lcDump, lcLog, 1)

*-- [B] EFEITO do binding DblClick: com a guarda LIVRE e conexao invalida, o
*--     handler cai no CATCH e GRAVA uma linha no log de erros do modo teste.
*--     Crescimento do arquivo = o handler rodou de verdade.
loForm.this_lLookupAberto = .F.
lnAnt = IIF(FILE(gc_4c_ArquivoErroTeste), LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
RAISEEVENT(loForm.txt_4c_FPags, "DblClick")
lnDep = IIF(FILE(gc_4c_ArquivoErroTeste), LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
STRTOFILE("[B] DblClick: log antes=" + TRANSFORM(lnAnt) + " depois=" + TRANSFORM(lnDep) + ;
    " -> handler rodou=" + TRANSFORM(lnDep > lnAnt) + ;
    " | flag liberada=" + TRANSFORM(!loForm.this_lLookupAberto) + lcCRLF, lcLog, 1)

*-- [C] EFEITO do binding KeyPress: F4 com campo preenchido chega no picker
loForm.this_lLookupAberto = .F.
loForm.txt_4c_FPags.Value = "AV30"
lnAnt = IIF(FILE(gc_4c_ArquivoErroTeste), LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
RAISEEVENT(loForm.txt_4c_FPags, "KeyPress", 115, 0)
lnDep = IIF(FILE(gc_4c_ArquivoErroTeste), LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
STRTOFILE("[C] KeyPress F4: log antes=" + TRANSFORM(lnAnt) + " depois=" + TRANSFORM(lnDep) + ;
    " -> handler rodou=" + TRANSFORM(lnDep > lnAnt) + lcCRLF, lcLog, 1)

*-- [D] tecla fora da lista NAO pode acionar nada
loForm.this_lLookupAberto = .F.
lnAnt = IIF(FILE(gc_4c_ArquivoErroTeste), LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
RAISEEVENT(loForm.txt_4c_FPags, "KeyPress", 65, 0)
lnDep = IIF(FILE(gc_4c_ArquivoErroTeste), LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
STRTOFILE("[D] KeyPress 'A': log inalterado=" + TRANSFORM(lnDep = lnAnt) + " (esperado .T.)" + lcCRLF, lcLog, 1)

STRTOFILE("ERROS VFP:" + lcCRLF + IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "(nenhum)") + lcCRLF, lcLog, 1)
STRTOFILE("=== FIM ===" + lcCRLF, lcLog, 1)
loForm = .NULL.
QUIT
