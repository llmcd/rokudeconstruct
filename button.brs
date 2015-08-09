Function Main() as void

    m.buttons = [
        {Label: "Watch Videos", ID: 1}

    ]
    
    port = CreateObject("roMessagePort")
    screen = CreateObject("roParagraphScreen")
    screen.SetMessagePort( port )

    InitTheme()


    screen.AddHeaderText("Welcome to CTT Broadcasting Channel")
    screen.AddParagraph("We've created a few videos for you to watch.")
    
    for each button in m.buttons
        screen.AddButton(button.ID, button.Label)
    end for
    screen.show()
    
    while (true)
        msg = wait(0, port)
        if type( msg ) = "roParagraphScreenEvent"
            if (msg.isButtonPressed())
                HandleButtonPress(msg.GetIndex())
            end if
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

Function HandleButtonPress(id as integer) as void
    if (id = m.buttons[0].ID)
        LoadXMLFile()
    end if
End Function


Function LoadXMLFile() as void
    xmlParser = CreateObject("roXMLElement")
    xmlParser.Parse(ReadAsciiFile("pkg:/xml/sample1.xml"))
    ShowPosterScreen(xmlParser.Video, false)
End Function

Function ShowPosterScreen(videos as object, fromJson as boolean) as integer
    posterScreen = CreateObject("roPosterScreen")
    port = CreateObject("roMessagePort")
    
    
    posterScreen.SetMessagePort(port)
    if (fromJson)
        posterScreen.SetBreadcrumbText("XML Parsing Result", "")
    end if
    contentList = CreateObject("roArray", 2, true)
    for each video in videos
        poster = CreateObject("roAssociativeArray")
        if (fromJson)
            poster.ShortDescriptionLine1 = video.Title
            poster.SDPosterURL = video.Image
            poster.HDPosterURL = video.Image
        else
            poster.ShortDescriptionLine1 = video.Title.GetText()
            poster.SDPosterURL = video.Image.GetText()
            poster.HDPosterURL = video.Image.GetText()
        end if
        contentList.push( poster )
    end for
    posterScreen.SetContentList( contentList )
    posterScreen.SetFocusedListItem(2)
    posterScreen.show()

    while (true)
        msg = wait(0, port)
        if type(msg) = "roPosterScreenEvent"
            if (msg.isListItemSelected())
                PlayVideo(videos[msg.GetIndex()], fromJson)
            else if (msg.isScreenClosed())
                return -1
            end if
        endif
    end while

End Function

