*==============================================================================
* MedirDeletedSafetyDS2.prg - prova, no proprio VFP9, que form com
* DataSession = 2 nasce com SET DELETED OFF e SET SAFETY ON, e que por isso
* um DELETE em cursor local NAO some da grade nem do SCAN.
*
* Usado para embasar as correcoes da Fase 7 do FormSigOpOpe (task776):
*   - SET DELETED ON no InicializarForm  (DELETE do CmdExcluirClick)
*   - guarda de SAFETY em volta do ZAP   (SigOpOpeBO.CarregarVinculos)
*
* Uso (o VFP9 pode compilar e SAIR SEM EXECUTAR - exigir o .txt de saida):
*   powershell -NoProfile -Command "$p = Start-Process -FilePath 'C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe' -ArgumentList '-T','C:\4c\automation\MedirDeletedSafetyDS2.prg' -PassThru -WindowStyle Hidden; $p.WaitForExit(90000)"
*
* Saida: C:\4c\automation\MedirDeletedSafetyDS2.txt
* Medido em 2026-11-11:
*   SESSAO1 deleted=ON safety=OFF
*   SESSAO_FORM deleted=OFF safety=ON exact=OFF
*   apos DELETE: RECCOUNT=2 SCAN_visitou=2
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET DELETED ON
SET EXACT ON

LOCAL loc_c, loc_oForm

loc_c = "SESSAO1 deleted=" + SET("DELETED") + " safety=" + SET("SAFETY") + CHR(13) + CHR(10)
loc_oForm = CREATEOBJECT("ProbeDS2")
loc_c = loc_c + loc_oForm.cInfo

STRTOFILE(loc_c, "C:\4c\automation\MedirDeletedSafetyDS2.txt")
QUIT

DEFINE CLASS ProbeDS2 AS Form
    DataSession = 2
    cInfo = ""

    PROCEDURE Init()
        LOCAL loc_s, loc_n

        loc_s = "SESSAO_FORM deleted=" + SET("DELETED") + " safety=" + SET("SAFETY") + ;
                " exact=" + SET("EXACT") + CHR(13) + CHR(10)

        CREATE CURSOR cur_probe (grupos C(10))
        INSERT INTO cur_probe (grupos) VALUES ("A")
        INSERT INTO cur_probe (grupos) VALUES ("B")
        GO TOP
        DELETE

        loc_s = loc_s + "apos DELETE: RECCOUNT=" + TRANSFORM(RECCOUNT("cur_probe"))

        loc_n = 0
        SELECT cur_probe
        SCAN
            loc_n = loc_n + 1
        ENDSCAN

        loc_s = loc_s + " SCAN_visitou=" + TRANSFORM(loc_n) + CHR(13) + CHR(10)

        THIS.cInfo = loc_s
    ENDPROC
ENDDEFINE
