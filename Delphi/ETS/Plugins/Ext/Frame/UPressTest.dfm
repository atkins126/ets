object FrmPressTest: TFrmPressTest
  Left = 0
  Top = 0
  Width = 720
  Height = 501
  OnDropFiles = FrameBaseDropFiles
  OnInit = FrameBaseInit
  OnAfterNotify = FrameBaseAfterNotify
  object WwMain: TDUIWinContainer
    Left = 0
    Top = 0
    Width = 720
    Height = 501
    Align = alClient
    object SpLeftRight: TSplitter
      Left = 116
      Top = 0
      Height = 501
    end
    object PnlClient: TPanel
      Left = 119
      Top = 0
      Width = 601
      Height = 501
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PnlTitle: TPanel
        Left = 0
        Top = 0
        Width = 601
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object EdScript: TScintilla
        Left = 0
        Top = 24
        Width = 601
        Height = 477
        Align = alClient
        FoldIndicator = True
        ShowLineNumber = True
        StyleFile = 'embed:DefaultStyle'
        TabSize = 4
        UseTab = False
      end
    end
    object PnlLeft: TPanel
      Left = 0
      Top = 0
      Width = 116
      Height = 501
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object TvScript: TTreeView
        Left = 0
        Top = 24
        Width = 116
        Height = 477
        Align = alClient
        Indent = 19
        TabOrder = 0
        OnCompare = TvScriptCompare
        OnDblClick = TvScriptDblClick
      end
      object PnlTools: TPanel
        Left = 0
        Top = 0
        Width = 116
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object SbNew: TSpeedButton
          Tag = 1
          Left = 0
          Top = 0
          Width = 23
          Height = 24
          Hint = #26032#24314
          Align = alLeft
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
            CECECECECECECECECECECECECECECECECECECECECECECECE6B947B216B39186B
            39216B3973A584C0C0C0C0C0C0CECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF84AD94298C5263BD8C94D6B563BD8C298C5284AD94C0C0C0CECECE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF21733963BD8C5ABD84FFFF
            FF5ABD8463BD8C216B39C0C0C0CECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF317B4A9CD6B5FFFFFFFFFFFFFFFFFF94D6B5186B39C0C0C0CECECE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6B947B8CD6B594D6B5FFFF
            FF63BD8C63BD8C216B39C0C0C0CECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFA5C6B563AD8494D6B5BDE7D66BBD8C298C5284AD94C0C0C0CECECE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA5C6B55A9C736B94
            7B6B947B7BA58CC0C0C0C0C0C0CECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F7F7FFFFFFCECECEC0C0C0C0C0C0CECECE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F7F7F7F7
            F7FFFFFFCECECEC0C0C0C0C0C0CECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFF7F7F7F7F7F7EFEFEFEFEFEFFFFFFFCECECEC0C0C0C0C0C0CECECE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F7F7EFEFEFEFEFEFE7E7
            E7FFFFFFCECECEC0C0C0C0C0C0CECECEFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7
            F7F7F7F7F7EFEFEFFFFFFFFFFFFFFFFFFFFFFFFFCECECEC0C0C0C0C0C0CECECE
            FFFFFFF7F7F7FFFFFFF7F7F7F7F7F7F7F7F7F7F7F7EFEFEFFFFFFFF7F7F7F7F7
            F7C6C6C6DEDEDEC0C0C0C0C0C0CECECEFFFFFFF7F7F7F7F7F7F7F7F7F7F7F7F7
            F7F7EFEFEFEFEFEFFFFFFFE7E7E7C6C6C6DEDEDEC0C0C0C0C0C0C0C0C0CECECE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6C6DEDE
            DEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CECECECECECECECECECECECECECECECE
            CECECECECECECECECECECEDEDEDEC0C0C0C0C0C0C0C0C0C0C0C0}
          ParentShowHint = False
          ShowHint = True
          OnClick = DoControlButtonClick
        end
        object SbRefresh: TSpeedButton
          Tag = 2
          Left = 23
          Top = 0
          Width = 23
          Height = 24
          Hint = #21047#26032
          Align = alLeft
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
            000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
            FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
            00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
            00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
            FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
            0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
            05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
            55557F7777777555555500000005555555557777777555555555}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = DoControlButtonClick
        end
        object SbStart: TSpeedButton
          Tag = 3
          Left = 46
          Top = 0
          Width = 23
          Height = 24
          Hint = #36816#34892
          Align = alLeft
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
            00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
            70E337F3333F333337F3E0F33303333370E337F3337FF33337F3E0F333003333
            70E337F33377FF3337F3E0F33300033370E337F333777FF337F3E0F333000033
            70E337F33377773337F3E0F33300033370E337F33377733337F3E0F333003333
            70E337F33377333337F3E0F33303333370E337F33373333337F3E0F333333333
            70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
            00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = DoControlButtonClick
        end
        object SbStop: TSpeedButton
          Tag = 4
          Left = 69
          Top = 0
          Width = 23
          Height = 24
          Hint = #20572#27490
          Align = alLeft
          Enabled = False
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
            00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
            70E337F33333333337F3E0F33333333370E337F333FFFFF337F3E0F330000033
            70E337F3377777F337F3E0F33000003370E337F3377777F337F3E0F330000033
            70E337F3377777F337F3E0F33000003370E337F3377777F337F3E0F330000033
            70E337F33777773337F3E0F33333333370E337F33333333337F3E0F333333333
            70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
            00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = DoControlButtonClick
        end
      end
    end
  end
end
