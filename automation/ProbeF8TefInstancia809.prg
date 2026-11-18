* ProbeF8TefInstancia809.prg
* Instancia Formsigoptef pelo harness oficial (TestFormWrapper) para provar
* que a Fase 8 nao quebrou o Init. SET DEFAULT para start\ porque o wrapper
* faz "DO config.prg" por nome relativo.
SET SAFETY OFF
SET RESOURCE OFF
SET DEFAULT TO C:\4c\projeto\app\start
DO C:\4c\automation\vfp_helpers\TestFormWrapper.prg WITH ;
    "Formsigoptef", "C:\4c\automation\_f8tef_instancia.log"
QUIT
