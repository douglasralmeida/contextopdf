object FormDividir: TFormDividir
  Left = 0
  Top = 0
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Image1: TImage
    Left = 11
    Top = 8
    Width = 25
    Height = 32
    AutoSize = True
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
      00200806000000E79CD306000000017352474200AECE1CE90000000467414D41
      0000B18F0BFC6105000000097048597300000B1200000B1201D2DD7EFC000000
      1874455874536F667477617265007061696E742E6E657420342E312E35644758
      52000002424944415478DAEDD73F481B511C07F0EFE592EB254A0663D0A4D23F
      22A696262DE2E4D00E6E2E0EE2E03F30FE598A18E14C151AA4111A04852E5D32
      48111C04071707C7B69B94D00ED50E8977FD8354444B518AC2FDEBEF6E9022B9
      92CBC52D5F12DE2539DEE7DEEF3D5EEE981CCFDF5655F50D18E63103B0B0116F
      63235A13098D0E9F728290B53A8FF9C0716FA97D62A7F37F914822019D421739
      45D06B2B4481CD115C458CE8C64BD3042E997C550CD1CB01AE22971D02CFDC82
      B074AD881155D753FCCCCCCB6B458C689A96BE914CBE708CF00D0DB8373D6DF9
      3B4119829E3B425C1C8707A9145C1E8F35A4EB4B8E1023818E0E84BBBBC17ABD
      96E738464A4915A9220E3A6159B8834128C7C7D015A572484C14F17562027F72
      39DCDFD981BBAE0E523C8EDF5B5BF610D6EF375BF5F4F4F23B777DBDF9F9A124
      411C19812ECB68D9D8C047DA62681F29BD5C775756E06B6F07170EC355530369
      7C1CBFD6D771279B45607010F2D1113C84E57B7B716B79197C24828B7C1E9FA3
      D1D291E6D555B31569F84D0B0BF07775617F7818D1DD5D7CE9ECC445A18018BD
      F70706CCAB6F5E5BC3A750C87ACEAC10F9F0103F666711A08E6EA6D3904647D1
      BABD8D5C6D2DFD07EA7874706096CB1162D4FEBB20A029933157CFB7C949C4A8
      24E2D010949313B46C6EA2D0D7E70CE1DBDAE0F2F9A09D9D411A1BC3F9DE1E42
      737308D2FC9C53D98CA5FA7371D144C2F3F3C8F7F4945FAE4AA42812E8EF874A
      2328B6E62B86543A55C43652F66D6A89511DDD709798778C934787FF85E640A5
      EDE7BDCCB2F1BFA0AB0CF52C0FA7970000000049454E44AE426082}
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
  object btoOK: TButton
    Left = 165
    Top = 209
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btoOKClick
  end
  object btoCancelar: TButton
    Left = 246
    Top = 209
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
  object Caderno: TNotebook
    Left = 46
    Top = 45
    Width = 275
    Height = 150
    PageIndex = 1
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
      object editTamanho: TEdit
        Left = 0
        Top = 23
        Width = 194
        Height = 23
        TabOrder = 0
      end
      object comboTipoTamanho: TComboBox
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
          'MB')
      end
      object checSalvarMesmoLocal: TCheckBox
        Left = 0
        Top = 61
        Width = 272
        Height = 17
        Caption = '&Salvar no mesmo local do arquivo de origem'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object checSubstituir: TCheckBox
        Left = 0
        Top = 84
        Width = 272
        Height = 34
        Caption = 
          'S&ubstituir, caso existam arquivos com mesmo nome que o arquivo ' +
          'de destino'
        Checked = True
        State = cbChecked
        TabOrder = 3
        WordWrap = True
      end
      object checExcluirOrigem: TCheckBox
        Left = 0
        Top = 124
        Width = 272
        Height = 17
        Caption = '&Excluir arquivo de origem'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Andamento'
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 240
        Height = 15
        Caption = 'Aguarde enquanto o arquivo PDF '#233' dividido...'
      end
      object txtStatus: TLabel
        Left = 241
        Top = 44
        Width = 31
        Height = 15
        Alignment = taRightJustify
        Caption = 'status'
      end
      object BarraProgresso: TProgressBar
        Left = 0
        Top = 21
        Width = 273
        Height = 17
        TabOrder = 0
      end
    end
  end
end
