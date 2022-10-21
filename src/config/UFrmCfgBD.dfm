object FrmCfgBD: TFrmCfgBD
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Config. SGDB'
  ClientHeight = 243
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 182
    Width = 331
    Height = 61
    Align = alBottom
    TabOrder = 6
    object btnOk: TButton
      AlignWithMargins = True
      Left = 171
      Top = 4
      Width = 75
      Height = 53
      Align = alRight
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 252
      Top = 4
      Width = 75
      Height = 53
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnTest: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 53
      Align = alLeft
      Caption = '!!! Testar !!!'
      TabOrder = 0
      OnClick = btnTestClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 28
    Width = 331
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Servidor:'
      Layout = tlCenter
    end
    object edtServidor: TEdit
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 121
      Height = 22
      Align = alLeft
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 112
    Width = 331
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Senha:'
      Layout = tlCenter
    end
    object edtSenha: TEdit
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 121
      Height = 22
      Align = alLeft
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 84
    Width = 331
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Usu'#225'rio:'
      Layout = tlCenter
    end
    object edtUsuario: TEdit
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 121
      Height = 22
      Align = alLeft
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 56
    Width = 331
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Porta:'
      Layout = tlCenter
    end
    object sePorta: TSpinEdit
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 121
      Height = 22
      Align = alLeft
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 331
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label5: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'SGDB:'
      Layout = tlCenter
    end
    object cbxSGDB: TComboBox
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 121
      Height = 21
      Align = alLeft
      TabOrder = 0
      Items.Strings = (
        'MySQL'
        'PostgreSQL')
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 140
    Width = 331
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object Label6: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Banco:'
      Layout = tlCenter
    end
    object edtBanco: TEdit
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 121
      Height = 22
      Align = alLeft
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
end
