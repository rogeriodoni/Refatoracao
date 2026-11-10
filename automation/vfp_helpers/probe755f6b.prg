SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe755f6b_dialogs.txt"
gb_4c_ValidandoUI      = .F.

LOCAL lcOut, loForm, loErr
lcOut = "C:\4c\automation\vfp_helpers\probe755f6b_resultado.txt"
STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), lcOut)

CD C:\4c\projeto\app\start
DO config.prg
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.
gnConnHandle      = 0

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpJobBO.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpJob.prg") ADDITIVE

loForm = CREATEOBJECT("FormSigOpJob")
STRTOFILE("CK01 form VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcOut, 1)

*-- CAMINHO VIVO DO LOOKUP, por CODIGO. Com gnConnHandle = 0 o SQLEXEC do
*-- FormBuscaAuxiliar.Init falha; o que interessa provar eh que o funil CHEGA
*-- la (se chegasse ao Show() MODAL o processo penduraria e o CK03 nunca
*-- seria escrito - regra #37).
STRTOFILE("CK02 antes do lookup por CODIGO" + CHR(13) + CHR(10), lcOut, 1)
loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024.Value = "0000000001"
loForm.ValidarConta024()
STRTOFILE("CK03 depois do lookup por CODIGO: cod=[" + ;
          ALLTRIM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024.Value) + "] nome=[" + ;
          ALLTRIM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a.Value) + "] flag=" + ;
          TRANSFORM(loForm.this_lEmLookupConta) + CHR(13) + CHR(10), lcOut, 1)

*-- CAMINHO VIVO DO LOOKUP, por NOME (a metade que faltava na migracao)
STRTOFILE("CK04 antes do lookup por NOME" + CHR(13) + CHR(10), lcOut, 1)
loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026.Value  = ""
loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a.Value = "ALGUM NOME"
loForm.ValidarNomeConta026()
STRTOFILE("CK05 depois do lookup por NOME: cod=[" + ;
          ALLTRIM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026.Value) + "] nome=[" + ;
          ALLTRIM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a.Value) + "] flag=" + ;
          TRANSFORM(loForm.this_lEmLookupConta) + CHR(13) + CHR(10), lcOut, 1)

loForm.Release()
STRTOFILE("CK99 fim" + CHR(13) + CHR(10), lcOut, 1)
QUIT
