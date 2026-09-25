*-- Executa TestFormWrapper para FormSigMvSbn (task577) sem depender do
*-- escaping de parametros do VFPExecutor.ps1.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH "FormSigMvSbn", "C:\4c\tasks\task577\logs\06_testForm.log"
QUIT
