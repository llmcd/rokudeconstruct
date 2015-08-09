Function Main() as void

    port = CreateObject("roMessagePort")
    screen = CreateObject("roParagraphScreen")
    screen.SetMessagePort( port )

    InitTheme()


    screen.AddHeaderText("Welcome to CTT Broadcasting Channel")
    screen.AddParagraph("We've created a few videos for you to watch.")
    
    screen.show()
    
    while (true)
        msg = wait(0, port)
        if type( msg ) = "roParagraphScreenEvent"
            
        end if
    end while
End Function

Function InitTheme() as void
    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")


        theme.OverhangOffsetSD_X = "500"
        theme.OverhangOffsetSD_Y = "15"
        theme.OverhangSliceSD = "pkg:/images/Overhang_BackgroundSlice_SD.png"
        theme.OverhangLogoSD = "pkg:/images/Logo_Overhang_SD.png"
        theme.OverhangOffsetHD_X = "500"
        theme.OverhangOffsetHD_Y = "15"
        theme.OverhangSliceHD = "pkg:/images/Overhang_BackgroundSlice_HD.png"
        theme.OverhangLogoHD = "pkg:/images/Logo_Overhang_HD.png"
        theme.BackgroundColor = "#2a2a2a"
        theme.ButtonHighlightColor = "#808080"
        theme.ButtonNormalColor = "#808080"


    app.SetTheme(theme)

End Function

