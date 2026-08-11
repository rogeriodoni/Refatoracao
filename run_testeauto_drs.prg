SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\FormErro.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\DrsBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\cadastros\FormDrs.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\TesteAutomatico.prg ADDITIVE

PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoClasses, gc_4c_CaminhoForms
PUBLIC gc_4c_CaminhoUtils, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gc_4c_UsuarioLogado, gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC go_4c_Sistema

gc_4c_CaminhoBase    = "C:\4c\projeto\app\"
gc_4c_CaminhoClasses = "C:\4c\projeto\app\classes\"
gc_4c_CaminhoForms   = "C:\4c\projeto\app\forms\"
gc_4c_CaminhoUtils   = "C:\4c\projeto\app\utils\"
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"
gnConnHandle         = 0
gb_4c_ModoTeste      = .T.
gb_4c_ValidandoUI    = .T.

*-- Sistema global minimo para tests
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "EMPRESA TESTE")

DO TesteAutomatico WITH "FormDrs", "C:\4c\tasks\task398", "CRUD"
QUIT
