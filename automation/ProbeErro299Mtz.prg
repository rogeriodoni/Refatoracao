*==============================================================================
* ProbeErro299Mtz.prg - Mede, em coordenadas de TELA (Top - 29), o bloco do
* topo das DUAS paginas e cruza o retangulo do container de botoes da Dados
* com o de todo controle da pagina, para achar sobreposicao objetivamente.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_mtz299.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

PUBLIC gcLog299
gcLog299 = "C:\4c\automation\probe_erro299_mtz.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLog299)

LOCAL loc_oE, loForm, loPg1, loPg2, loc_nI, loc_nJ, loc_oC, loc_oD, loc_nOff
LOCAL loc_nCL, loc_nCT, loc_nCR, loc_nCB, loc_nL, loc_nT, loc_nR, loc_nB

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "mtzBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formmtz.prg") ADDITIVE
    Log299("B: deps carregadas")

    loForm = CREATEOBJECT("Formmtz")
    IF VARTYPE(loForm) # "O"
        Log299("C: CREATEOBJECT FALHOU")
    ELSE
        loc_nOff = loForm.pgf_4c_Paginas.Top          && -29
        Log299("C: PageFrame.Top=" + TRANSFORM(loc_nOff) + ;
               " Form.Height=" + TRANSFORM(loForm.Height))

        loPg1 = loForm.pgf_4c_Paginas.Page1
        loPg2 = loForm.pgf_4c_Paginas.Page2

        *-- PAGE1 (aceita pelo testador) - tela = Top + PageFrame.Top
        Log299("D: PAGE1 faixa  tela " + ;
               TRANSFORM(loPg1.cnt_4c_Cabecalho.Top + loc_nOff) + ".." + ;
               TRANSFORM(loPg1.cnt_4c_Cabecalho.Top + loPg1.cnt_4c_Cabecalho.Height + loc_nOff))
        Log299("   PAGE1 cnt_4c_Saida    tela " + ;
               TRANSFORM(loPg1.cnt_4c_Saida.Top + loc_nOff) + ".." + ;
               TRANSFORM(loPg1.cnt_4c_Saida.Top + loPg1.cnt_4c_Saida.Height + loc_nOff))
        Log299("   PAGE1 btn Encerrar    tela " + ;
               TRANSFORM(loPg1.cnt_4c_Saida.Top + loPg1.cnt_4c_Saida.cmd_4c_Encerrar.Top + loc_nOff) + ".." + ;
               TRANSFORM(loPg1.cnt_4c_Saida.Top + loPg1.cnt_4c_Saida.cmd_4c_Encerrar.Top + ;
                         loPg1.cnt_4c_Saida.cmd_4c_Encerrar.Height + loc_nOff) + ;
               "  (Height real=" + TRANSFORM(loPg1.cnt_4c_Saida.cmd_4c_Encerrar.Height) + ;
               " AutoSize=" + TRANSFORM(loPg1.cnt_4c_Saida.cmd_4c_Encerrar.AutoSize) + ")")

        *-- PAGE2
        Log299("E: PAGE2 faixa  tela " + ;
               TRANSFORM(loPg2.cnt_4c_Cabecalho.Top + loc_nOff) + ".." + ;
               TRANSFORM(loPg2.cnt_4c_Cabecalho.Top + loPg2.cnt_4c_Cabecalho.Height + loc_nOff))
        Log299("   PAGE2 cnt_4c_BotoesAcao tela " + ;
               TRANSFORM(loPg2.cnt_4c_BotoesAcao.Top + loc_nOff) + ".." + ;
               TRANSFORM(loPg2.cnt_4c_BotoesAcao.Top + loPg2.cnt_4c_BotoesAcao.Height + loc_nOff) + ;
               "  Left " + TRANSFORM(loPg2.cnt_4c_BotoesAcao.Left) + ".." + ;
               TRANSFORM(loPg2.cnt_4c_BotoesAcao.Left + loPg2.cnt_4c_BotoesAcao.Width))
        Log299("   PAGE2 btn Confirmar   tela " + ;
               TRANSFORM(loPg2.cnt_4c_BotoesAcao.Top + loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Top + loc_nOff) + ".." + ;
               TRANSFORM(loPg2.cnt_4c_BotoesAcao.Top + loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Top + ;
                         loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Height + loc_nOff) + ;
               "  (Height real=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Height) + ;
               " AutoSize=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.AutoSize) + ")")

        *-- Retangulo do container de botoes da Dados
        loc_nCL = loPg2.cnt_4c_BotoesAcao.Left
        loc_nCT = loPg2.cnt_4c_BotoesAcao.Top
        loc_nCR = loc_nCL + loPg2.cnt_4c_BotoesAcao.Width
        loc_nCB = loc_nCT + loPg2.cnt_4c_BotoesAcao.Height

        Log299("F: --- controles da Page2 que CRUZAM o retangulo do cnt_4c_BotoesAcao ---")
        FOR loc_nI = 1 TO loPg2.ControlCount
            loc_oC = loPg2.Controls(loc_nI)
            IF UPPER(loc_oC.Name) == "CNT_4C_BOTOESACAO"
                LOOP
            ENDIF
            IF !PEMSTATUS(loc_oC, "Left", 5) OR !PEMSTATUS(loc_oC, "Top", 5)
                LOOP
            ENDIF
            loc_nL = loc_oC.Left
            loc_nT = loc_oC.Top
            loc_nR = loc_nL + loc_oC.Width
            loc_nB = loc_nT + loc_oC.Height
            IF loc_nL < loc_nCR AND loc_nR > loc_nCL AND loc_nT < loc_nCB AND loc_nB > loc_nCT
                Log299("   CRUZA: " + PADR(loc_oC.Name, 24) + " [" + loc_oC.BaseClass + "] " + ;
                       "L " + TRANSFORM(loc_nL) + ".." + TRANSFORM(loc_nR) + ;
                       "  T " + TRANSFORM(loc_nT) + ".." + TRANSFORM(loc_nB) + ;
                       "  zorder=" + TRANSFORM(loc_nI))
            ENDIF
        ENDFOR
        Log299("   (fim da varredura)")

        *-- Primeiro controle de dados da Page2 x fundo da faixa
        Log299("G: faixa fundo=" + TRANSFORM(loPg2.cnt_4c_Cabecalho.Top + loPg2.cnt_4c_Cabecalho.Height) + ;
               " | txt_4c_Codigo.Top=" + TRANSFORM(loPg2.txt_4c_Codigo.Top) + ;
               " lbl_4c_Lbl_grupo.Top=" + TRANSFORM(loPg2.lbl_4c_Lbl_grupo.Top) + ;
               " txt_4c_Moeda.Top=" + TRANSFORM(loPg2.txt_4c_Moeda.Top))

        Log299("H: --- Page2, controles com Top <= 210 ---")
        FOR loc_nI = 1 TO loPg2.ControlCount
            loc_oC = loPg2.Controls(loc_nI)
            IF !PEMSTATUS(loc_oC, "Left", 5) OR !PEMSTATUS(loc_oC, "Top", 5)
                LOOP
            ENDIF
            IF loc_oC.Top <= 210
                Log299("   " + PADR(loc_oC.Name, 24) + PADR("[" + loc_oC.BaseClass + "]", 13) + ;
                       " L " + PADL(TRANSFORM(loc_oC.Left), 4) + ".." + ;
                       PADL(TRANSFORM(loc_oC.Left + loc_oC.Width), 4) + ;
                       "  T " + PADL(TRANSFORM(loc_oC.Top), 4) + ".." + ;
                       PADL(TRANSFORM(loc_oC.Top + loc_oC.Height), 4) + ;
                       IIF(PEMSTATUS(loc_oC, "Caption", 5), "  cap=[" + TRANSFORM(loc_oC.Caption) + "]", ""))
            ENDIF
        ENDFOR

        Log299("I: --- pares de controles de dados que se CRUZAM ---")
        FOR loc_nI = 1 TO loPg2.ControlCount
            loc_oC = loPg2.Controls(loc_nI)
            IF !(UPPER(loc_oC.BaseClass) $ "TEXTBOXLABELCHECKBOX") OR loc_oC.Top > 210
                LOOP
            ENDIF
            FOR loc_nJ = loc_nI + 1 TO loPg2.ControlCount
                loc_oD = loPg2.Controls(loc_nJ)
                IF !(UPPER(loc_oD.BaseClass) $ "TEXTBOXLABELCHECKBOX") OR loc_oD.Top > 210
                    LOOP
                ENDIF
                IF loc_oC.Left < loc_oD.Left + loc_oD.Width AND ;
                   loc_oC.Left + loc_oC.Width > loc_oD.Left AND ;
                   loc_oC.Top  < loc_oD.Top + loc_oD.Height AND ;
                   loc_oC.Top + loc_oC.Height > loc_oD.Top
                    Log299("   CRUZA: " + ALLTRIM(loc_oC.Name) + " x " + ALLTRIM(loc_oD.Name))
                ENDIF
            ENDFOR
        ENDFOR
        Log299("   (fim)")
        loForm.Release()
        Log299("H: Release OK")
    ENDIF

CATCH TO loc_oE
    Log299("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

Log299("Z: fim")
QUIT

PROCEDURE Log299(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLog299, 1)
ENDPROC
