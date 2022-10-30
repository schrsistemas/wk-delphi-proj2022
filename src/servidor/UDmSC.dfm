object DmSC: TDmSC
  OldCreateOrder = False
  Height = 521
  Width = 676
  object DSServer: TDSServer
    AutoStart = False
    Left = 176
    Top = 88
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Server = DSServer
    Filters = <>
    Left = 176
    Top = 144
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    Left = 336
    Top = 328
  end
  object DSServerClassPessoa: TDSServerClass
    OnGetClass = DSServerClassPessoaGetClass
    Server = DSServer
    Left = 336
    Top = 384
  end
  object DSHTTPServiceFileDispatcher: TDSHTTPServiceFileDispatcher
    Service = DSHTTPService
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/html'
        Extensions = 'html;htm'
      end
      item
        MimeType = 'application/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpeg;jpg'
      end
      item
        MimeType = 'image/png'
        Extensions = 'png'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    Left = 472
    Top = 144
  end
  object DSHTTPService: TDSHTTPService
    HttpPort = 8020
    Server = DSServer
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    Left = 472
    Top = 88
  end
  object DSAuthenticationManager: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManagerUserAuthenticate
    OnUserAuthorize = DSAuthenticationManagerUserAuthorize
    Roles = <>
    Left = 176
    Top = 192
  end
  object DSServerClassGED: TDSServerClass
    OnGetClass = DSServerClassGEDGetClass
    Server = DSServer
    Left = 336
    Top = 440
  end
end
