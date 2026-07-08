DEFINE CLASS TestForm AS Form

    PROTECTED PROCEDURE TestMethod()
        LOCAL loc_oPage, loc_oErr
        TRY
            loc_oPage = THIS.Page1
            loc_oPage.AddObject("shp_test", "Shape")
            WITH loc_oPage.shp_test
                .Top = 12 : .Left = 10 : .Width = 342 : .Height = 110
                .BackStyle = 0
            ENDWITH
        CATCH TO loc_oErr
            WAIT WINDOW loc_oErr.Message
        ENDTRY
    ENDPROC

ENDDEFINE
