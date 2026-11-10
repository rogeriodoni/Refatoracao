* ProbeF8Task755Bind.prg - confere os BINDEVENT de LostFocus que a Fase 8
* acrescentou (VincularChecagemObrigatorios).
*
* AEVENTS consulta por objeto de ORIGEM e tem DOIS argumentos:
*   AEVENTS(laA, oOrigem)   -> numero de bindings daquele objeto
* Colunas: 1 = logico, 2 = objeto DELEGATE, 3 = nome do EVENTO,
*          4 = nome do METODO delegate, 5 = flags.
* (AEVENTS(laA, 0) devolve 0 - nao serve para consulta por objeto.)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probef8_755_bind.txt"
STRTOFILE("PROBE F8 BIND task755 INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpJob")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef8_755_bind_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL loForm, loErro
loForm = CREATEOBJECT("FormSigOpJob")
LogB("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    *-- Um representante de cada familia de campo da ficha
    Conferir(loForm.pgf_4c_Job.Page1.obj_4c_Get_01_003, "Page1 EditBox memo (Jb_003)")
    Conferir(loForm.pgf_4c_Job.Page1.txt_4c__01_001,    "Page1 TextBox data (Jb_001)")
    Conferir(loForm.pgf_4c_Job.Page2.obj_4c_Get_01_009, "Page2 EditBox memo (Jb_009)")
    Conferir(loForm.pgf_4c_Job.Page3.chk_4c_Get_01_038, "Page3 CheckBox grupo (Jb_038)")
    Conferir(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, "Page3 conta equipe (Jb_024)")
    Conferir(loForm.pgf_4c_Job.Page4.obj_4c_Get_01_045, "Page4 pasta (Jb_045)")
    Conferir(loForm.pgf_4c_Job.Page5.chk_4c_Get_01_063, "Page5 CheckBox fiscal (Jb_063)")
    Conferir(loForm.pgf_4c_Job.Page6.chk_4c_Get_01_049, "Page6 CheckBox apresent (Jb_049)")
    Conferir(loForm.chk_4c_Get_Extra,                   "raiz CheckBox Briefing Extra")

    *-- CONTROLE NEGATIVO: a grade NAO deve ter o binding (o legado nao liga
    *-- ChecaObrigs a coluna nenhuma; a grade tem funil proprio)
    Conferir(loForm.pgf_4c_Job.Page5.grd_4c_Dados.Column1.Text1, "NEGATIVO grade Column1.Text1")

    loForm.Release()
ENDIF

LogB("PROBE F8 BIND FIM")
QUIT

PROCEDURE Conferir(par_oObj, par_cRotulo)
    LOCAL lnTot, lnI, lnAchou, lcLinha, loErro
    LOCAL ARRAY laEv[1]
    lnAchou = 0
    lcLinha = ""

    TRY
        lnTot = AEVENTS(laEv, par_oObj)
        FOR lnI = 1 TO lnTot
            IF UPPER(ALLTRIM(laEv[lnI, 3])) == "LOSTFOCUS" AND ;
               UPPER(ALLTRIM(laEv[lnI, 4])) == "CHECARCAMPOSOBRIGATORIOS"
                lnAchou = lnAchou + 1
            ENDIF
            lcLinha = lcLinha + " [" + ALLTRIM(laEv[lnI, 3]) + "->" + ALLTRIM(laEv[lnI, 4]) + "]"
        ENDFOR
        LogB(PADR(par_cRotulo, 34) + " bindings=" + TRANSFORM(lnTot) + ;
             " ChecarObrig=" + TRANSFORM(lnAchou) + lcLinha)
    CATCH TO loErro
        LogB(PADR(par_cRotulo, 34) + " ERRO NAO TRATADO: " + loErro.Message)
    ENDTRY
ENDPROC

PROCEDURE LogB(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
