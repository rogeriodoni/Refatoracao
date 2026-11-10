SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe755f6_dialogs.txt"
gb_4c_ValidandoUI      = .F.

LOCAL lcOut, loForm, loErr, lcCk
lcOut = "C:\4c\automation\vfp_helpers\probe755f6_resultado.txt"
STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), lcOut)

CD C:\4c\projeto\app\start
TRY
    DO config.prg
    STRTOFILE("CK01 config.prg ok" + CHR(13) + CHR(10), lcOut, 1)
CATCH TO loErr
    STRTOFILE("CK01 FALHA config: " + loErr.Message + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

*-- gb_4c_ValidandoUI pode ser resetado pelo config.prg
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.

PUBLIC gnConnHandle
gnConnHandle = 0
TRY
    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpJobBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpJob.prg") ADDITIVE
    STRTOFILE("CK02 SET PROCEDURE ok" + CHR(13) + CHR(10), lcOut, 1)
CATCH TO loErr
    STRTOFILE("CK02 FALHA SET PROCEDURE: " + loErr.Message + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpJob")
    STRTOFILE("CK03 CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcOut, 1)
CATCH TO loErr
    STRTOFILE("CK03 FALHA CREATEOBJECT: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    *-- regra #51 / #3: metodo chamado de fora e por BINDEVENT tem de ser PUBLIC
    *-- (PEMSTATUS atributo 2 = Protected)
    STRTOFILE("CK04 AbrirLookupConta            PROT=" + TRANSFORM(PEMSTATUS(loForm, "AbrirLookupConta", 2)) + CHR(13) + CHR(10), lcOut, 1)
    STRTOFILE("CK05 ValidarConta024             PROT=" + TRANSFORM(PEMSTATUS(loForm, "ValidarConta024", 2)) + CHR(13) + CHR(10), lcOut, 1)
    STRTOFILE("CK06 ValidarNomeConta037         PROT=" + TRANSFORM(PEMSTATUS(loForm, "ValidarNomeConta037", 2)) + CHR(13) + CHR(10), lcOut, 1)
    STRTOFILE("CK07 AtualizarEstadoContasEquipe PROT=" + TRANSFORM(PEMSTATUS(loForm, "AtualizarEstadoContasEquipe", 2)) + CHR(13) + CHR(10), lcOut, 1)
    STRTOFILE("CK08 ContaEquipeInteractiveChange PROT=" + TRANSFORM(PEMSTATUS(loForm, "ContaEquipeInteractiveChange", 2)) + CHR(13) + CHR(10), lcOut, 1)

    *-- Estado inicial: codigos vazios -> os 14 campos de nome habilitados
    TRY
        lcCk = "CK09 Enabled nome(024)=" + ;
               TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a.Enabled) + ;
               " nome(037)=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a.Enabled) + ;
               " cod(024).Enabled=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024.Enabled)
        STRTOFILE(lcCk + CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErr
        STRTOFILE("CK09 FALHA: " + loErr.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    *-- Com o codigo preenchido, o When do legado desabilita o campo de nome
    TRY
        loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024.Value = "0000000001"
        loForm.AtualizarEstadoContasEquipe()
        STRTOFILE("CK10 apos codigo preenchido nome(024).Enabled=" + ;
                  TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a.Enabled) + ;
                  " nome(025).Enabled=" + ;
                  TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a.Enabled) + CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErr
        STRTOFILE("CK10 FALHA: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    *-- Modo VISUALIZAR: nenhum campo de nome aceita digitacao
    TRY
        loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024.Value = ""
        loForm.this_cModoAtual = "VISUALIZAR"
        loForm.AtualizarEstadoContasEquipe()
        STRTOFILE("CK11 VISUALIZAR nome(024).Enabled=" + ;
                  TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a.Enabled) + CHR(13) + CHR(10), lcOut, 1)
        loForm.this_cModoAtual = "INCLUIR"
        loForm.AtualizarEstadoContasEquipe()
    CATCH TO loErr
        STRTOFILE("CK11 FALHA: " + loErr.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    *-- Campo de origem VAZIO nao abre picker: se abrisse, Show() MODAL travaria
    *-- o processo e o CK13 nunca seria escrito (regra #37 - diagnostico barato)
    TRY
        loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024.Value  = ""
        loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a.Value = "LIXO ANTERIOR"
        loForm.ValidarConta024()
        STRTOFILE("CK12 vazio nao abriu picker; nome(024)=[" + ;
                  ALLTRIM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a.Value) + "]" + CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErr
        STRTOFILE("CK12 FALHA: " + loErr.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    *-- Guarda de reentrancia: com a flag ligada o funil devolve sem tocar nada
    TRY
        loForm.this_lEmLookupConta = .T.
        loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025.Value  = "ZZZZZZZZZZ"
        loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a.Value = "INTOCADO"
        loForm.ValidarConta025()
        STRTOFILE("CK13 reentrancia: nome(025)=[" + ;
                  ALLTRIM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a.Value) + "] flag=" + ;
                  TRANSFORM(loForm.this_lEmLookupConta) + CHR(13) + CHR(10), lcOut, 1)
        loForm.this_lEmLookupConta = .F.
    CATCH TO loErr
        STRTOFILE("CK13 FALHA: " + loErr.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    *-- Filtro do universo (regra: Coletors = 8 do crEquipes legado)
    TRY
        STRTOFILE("CK14 filtro=[" + loForm.ObterFiltroContaEquipeProbe() + "]" + CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErr
        STRTOFILE("CK14 (esperado: metodo PROTECTED, sem probe publico)" + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    loForm.Release()
    loForm = .NULL.
ENDIF

STRTOFILE("CK99 fim" + CHR(13) + CHR(10), lcOut, 1)
QUIT
