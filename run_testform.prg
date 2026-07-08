SET SAFETY OFF
*-- Carregar config do sistema
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\sigopindBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\Formsigopind.prg ADDITIVE

*-- Configurar globais necessarias
PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoClasses, gc_4c_CaminhoForms
PUBLIC gc_4c_CaminhoUtils, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gc_4c_UsuarioLogado, gnConnHandle
PUBLIC gb_4c_ModoTeste

gc_4c_CaminhoBase    = "C:\4c\projeto\app\"
gc_4c_CaminhoClasses = "C:\4c\projeto\app\classes\"
gc_4c_CaminhoForms   = "C:\4c\projeto\app\forms\"
gc_4c_CaminhoUtils   = "C:\4c\projeto\app\utils\"
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"
gnConnHandle         = 0
gb_4c_ModoTeste      = .T.

*-- Executar TestFormWrapper
SET PROCEDURE TO C:\4c\automation\vfp_helpers\TestFormWrapper.prg ADDITIVE

LOCAL loc_cResultado
loc_cResultado = "C:\4c\projeto\app\forms\operacionais\vfp_error_details.txt"

DO TestFormWrapper WITH "Formsigopind", loc_cResultado
QUIT
