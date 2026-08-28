SET SAFETY OFF
SET RESOURCE OFF

SET PROCEDURE TO C:\4c\automation\vfp_helpers\TestFormWrapper.prg ADDITIVE

PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoClasses, gc_4c_CaminhoForms
PUBLIC gc_4c_CaminhoUtils, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gc_4c_UsuarioLogado, gnConnHandle, gb_4c_ModoTeste

gc_4c_CaminhoBase    = "C:\4c\projeto\app\start\"
gc_4c_CaminhoClasses = "C:\4c\projeto\app\classes\"
gc_4c_CaminhoForms   = "C:\4c\projeto\app\forms\"
gc_4c_CaminhoUtils   = "C:\4c\projeto\app\utils\"
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"
gnConnHandle         = 0
gb_4c_ModoTeste      = .T.

DO TestFormWrapper WITH "Formprc", "C:\4c\tasks\task501\logs\06_testForm.log"
QUIT
