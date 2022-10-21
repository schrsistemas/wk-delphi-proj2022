object DmBase: TDmBase
  OldCreateOrder = False
  Height = 433
  Width = 630
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    Left = 168
    Top = 112
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=db_wk'
      'User_Name=postgres'
      'Password=toor'
      'Server=localhost'
      'LoginTimeout=1000'
      'DriverID=PG')
    TxOptions.AutoStop = False
    ConnectedStoredUsage = []
    LoginDialog = FDGUIxLoginDialog
    LoginPrompt = False
    Transaction = FDTransaction
    UpdateTransaction = FDTransactionUP
    Left = 168
    Top = 160
  end
  object FDTransaction: TFDTransaction
    Options.AutoStop = False
    Connection = Conexao
    Left = 200
    Top = 160
  end
  object FDTransactionUP: TFDTransaction
    Options.AutoStop = False
    Connection = Conexao
    Left = 232
    Top = 160
  end
  object Query: TFDQuery
    Connection = Conexao
    Transaction = FDTransaction
    UpdateTransaction = FDTransactionUP
    Left = 80
    Top = 112
  end
  object FDGUIxLoginDialog: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 224
    Top = 224
  end
  object FDGUIxScriptDialog: TFDGUIxScriptDialog
    Provider = 'Forms'
    Left = 256
    Top = 224
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 296
    Top = 224
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 200
    Top = 112
  end
  object FDScript: TFDScript
    SQLScripts = <>
    Connection = Conexao
    Transaction = FDTransaction
    ScriptDialog = FDGUIxScriptDialog
    Params = <>
    Macros = <>
    Left = 80
    Top = 160
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 328
    Top = 224
  end
  object FDMoniRemoteClientLink: TFDMoniRemoteClientLink
    Port = 8010
    Left = 360
    Top = 224
  end
end
