object DmSC: TDmSC
  OldCreateOrder = False
  Height = 441
  Width = 604
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
    Left = 176
    Top = 200
  end
end
