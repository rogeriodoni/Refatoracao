*==============================================================================
* ProbeErro304Pat.prg - FormPAT (Pedido de Atendimento):
*   1) os botoes Confirmar/Encerrar ficam DENTRO da faixa e com mesmo tamanho
*   2) o campo "Conta" (txt_4c_Codvends) com codigo PARCIAL nao devolve mais
*      "Vendedor nao encontrado" - o picker modal e o caminho. Num harness
*      headless, Show() de form MODAL TRAVA: se o script termina, o picker nao
*      abriu. Entao mede-se o BuscarDescVendedor + a guarda de reentrancia.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcL304
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_pat304.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcL304 = "C:\4c\automation\probe_erro304_pat.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL304)

LOCAL loc_oE, loF, loPg1, loPg2, lnOff, lnI, loC, lnFxI, lnFxF

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
    SET PROCEDURE TO (gcCaminhoClasses + "PATBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormPAT.prg") ADDITIVE
    Log304("B: deps carregadas")

    loF = CREATEOBJECT("FormPAT")
    Log304("C: CREATEOBJECT -> " + VARTYPE(loF))

    IF VARTYPE(loF) = "O"
        lnOff = loF.pgf_4c_Paginas.Top
        loPg2 = loF.pgf_4c_Paginas.Page2

        *-- faixa da Page2
        lnFxI = -9999
        FOR lnI = 1 TO loPg2.ControlCount
            loC = loPg2.Controls(lnI)
            IF UPPER(loC.BaseClass) == "CONTAINER"
                IF loC.BackColor = RGB(100,100,100) AND loC.Height >= 60
                    lnFxI = loC.Top + lnOff
                    lnFxF = loC.Top + loC.Height + lnOff
                    EXIT
                ENDIF
            ENDIF
        ENDFOR
        Log304("D: faixa da Dados tela " + TRANSFORM(lnFxI) + ".." + TRANSFORM(lnFxF))

        Log304("E: Confirmar  tela " + ;
               TRANSFORM(loPg2.cmd_4c_Confirmar.Top + lnOff) + ".." + ;
               TRANSFORM(loPg2.cmd_4c_Confirmar.Top + loPg2.cmd_4c_Confirmar.Height + lnOff) + ;
               "  " + TRANSFORM(loPg2.cmd_4c_Confirmar.Width) + "x" + ;
               TRANSFORM(loPg2.cmd_4c_Confirmar.Height) + ;
               "  Left=" + TRANSFORM(loPg2.cmd_4c_Confirmar.Left) + ;
               "  Picture=[" + JUSTFNAME(loPg2.cmd_4c_Confirmar.Picture) + "]")
        Log304("   Encerrar   tela " + ;
               TRANSFORM(loPg2.cmd_4c_Cancelar.Top + lnOff) + ".." + ;
               TRANSFORM(loPg2.cmd_4c_Cancelar.Top + loPg2.cmd_4c_Cancelar.Height + lnOff) + ;
               "  " + TRANSFORM(loPg2.cmd_4c_Cancelar.Width) + "x" + ;
               TRANSFORM(loPg2.cmd_4c_Cancelar.Height) + ;
               "  Left=" + TRANSFORM(loPg2.cmd_4c_Cancelar.Left) + ;
               "  Picture=[" + JUSTFNAME(loPg2.cmd_4c_Cancelar.Picture) + "]")
        Log304("   mesmo tamanho? " + ;
               TRANSFORM(loPg2.cmd_4c_Confirmar.Width = loPg2.cmd_4c_Cancelar.Width AND ;
                         loPg2.cmd_4c_Confirmar.Height = loPg2.cmd_4c_Cancelar.Height) + ;
               " | os DOIS dentro da faixa? " + ;
               TRANSFORM(loPg2.cmd_4c_Confirmar.Top + lnOff >= lnFxI AND ;
                         loPg2.cmd_4c_Confirmar.Top + loPg2.cmd_4c_Confirmar.Height + lnOff <= lnFxF AND ;
                         loPg2.cmd_4c_Cancelar.Top + lnOff >= lnFxI AND ;
                         loPg2.cmd_4c_Cancelar.Top + loPg2.cmd_4c_Cancelar.Height + lnOff <= lnFxF))
        Log304("   os icones existem? Confirmar=" + ;
               TRANSFORM(FILE(loPg2.cmd_4c_Confirmar.Picture)) + ;
               " Encerrar=" + TRANSFORM(FILE(loPg2.cmd_4c_Cancelar.Picture)))

        *-- rotulo x conteudo do campo
        Log304("F: rotulo=[" + ALLTRIM(loPg2.lbl_4c_LCodvends.Caption) + "]" + ;
               "  ToolTip=[" + ALLTRIM(loPg2.txt_4c_Codvends.ToolTipText) + "]")

        *-- guarda de reentrancia + caminho do lookup (sem banco, nao abre nada)
        Log304("G: this_lEmLookupConta inicial = " + TRANSFORM(loF.this_lEmLookupConta))
        loPg2.txt_4c_Codvends.Value = ""
        loF.ValidarCodvends()
        Log304("   vazio -> DVends=[" + ALLTRIM(loPg2.txt_4c_DVends.Value) + "]" + ;
               " flag=" + TRANSFORM(loF.this_lEmLookupConta))
        loPg2.txt_4c_Codvends.Value = "11"
        loF.ValidarCodvends()
        Log304("   '11'  -> Codvends=[" + ALLTRIM(loPg2.txt_4c_Codvends.Value) + "]" + ;
               " (o digitado NAO pode ser apagado)" + ;
               " flag=" + TRANSFORM(loF.this_lEmLookupConta))

        loF.Release()
        Log304("H: Release OK")
    ENDIF

CATCH TO loc_oE
    Log304("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    Log304("DIALOGOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Log304("DIALOGOS: nenhum")
ENDIF
Log304("Z: fim")
QUIT

PROCEDURE Log304(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL304, 1)
ENDPROC
