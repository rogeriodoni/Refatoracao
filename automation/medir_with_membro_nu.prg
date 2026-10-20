SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_o, loc_cLog, loc_oErr
loc_cLog = ""
loc_o = CREATEOBJECT("Custom")
loc_o.AddProperty("ExpandOnDClick", .F.)
TRY
    WITH loc_o
        .ExpandOnDClick
    ENDWITH
    loc_cLog = "WITH + membro nu: SEM ERRO"
CATCH TO loc_oErr
    loc_cLog = "WITH + membro nu: ERRO -> " + loc_oErr.Message
ENDTRY
STRTOFILE(loc_cLog, "C:\4c\automation\tmp652\medir_with_bare.txt")
QUIT
