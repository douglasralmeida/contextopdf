object FormDividir: TFormDividir
  Left = 0
  Top = 0
  ActiveControl = Edit1
  BorderStyle = bsDialog
  Caption = 'Dividir PDF'
  ClientHeight = 242
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 32
    Height = 32
  end
  object Label1: TLabel
    Left = 46
    Top = 8
    Width = 229
    Height = 21
    Caption = 'Dividir arquivo PDF por tamanho'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 46
    Top = 201
    Width = 277
    Height = 2
  end
  object Button1: TButton
    Left = 165
    Top = 209
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
  end
  object Button2: TButton
    Left = 246
    Top = 209
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 1
  end
  object Caderno: TNotebook
    Left = 46
    Top = 45
    Width = 275
    Height = 150
    TabOrder = 2
    object TPage
      Left = 0
      Top = 0
      Caption = 'Inicial'
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 236
        Height = 15
        Caption = 'Informe o tamanho m'#225'ximo do arquivo PDF:'
      end
      object Edit1: TEdit
        Left = 0
        Top = 23
        Width = 194
        Height = 23
        TabOrder = 0
      end
      object ComboBox1: TComboBox
        Left = 200
        Top = 23
        Width = 74
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 1
        Text = 'MB'
        Items.Strings = (
          'KB'
          'MB'
          'GB')
      end
      object CheckBox1: TCheckBox
        Left = 0
        Top = 61
        Width = 272
        Height = 17
        Caption = 'Salvar no mesmo local do arquivo de origem'
        TabOrder = 2
      end
      object CheckBox2: TCheckBox
        Left = 3
        Top = 84
        Width = 272
        Height = 34
        Caption = 
          'Substituir, caso existam arquivos com mesmo nome que o arquivo d' +
          'e destino'
        TabOrder = 3
        WordWrap = True
      end
      object CheckBox3: TCheckBox
        Left = 3
        Top = 124
        Width = 272
        Height = 17
        Caption = 'Excluir arquivo de origem'
        TabOrder = 4
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Andamento'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 240
        Height = 15
        Caption = 'Aguarde enquanto o arquivo PDF '#233' dividido...'
      end
      object Label4: TLabel
        Left = 241
        Top = 44
        Width = 31
        Height = 15
        Alignment = taRightJustify
        Caption = 'status'
      end
      object ProgressBar1: TProgressBar
        Left = 0
        Top = 21
        Width = 273
        Height = 17
        TabOrder = 0
      end
    end
  end
end
