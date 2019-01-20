object FormDividir: TFormDividir
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dividir PDF por tamanho'
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
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
      00200806000000737A7AF40000000473424954080808087C0864880000000970
      48597300000B1300000B1301009A9C18000002FF4944415478DAED9659485451
      18C7FF7766AECD9A39D3502F4185598946D68BF810B41065590F99A6225A2A22
      08A3B6911A455612096A98819569E69245F4D06E922D54225A4965A281149A4B
      6E33CD34CEDA39473028D26962AE3D785E0EE7E3DEFBFDCEB7FCBFCBF56F0D71
      621A173703E02E002757800F0C82BDEB23EC7D5F8405E054B3A12E2C83483B8F
      9D478F64C0D2D2281C8074C316A8749930E41F872A3D1BC62BE761BA5A261C80
      223619F21D31184A8982BAA41686C293303FBC2D20405C0A64DB22A0CF3900EF
      9C028C1C4A85F5ED2BE100A87365920EA6EB159087C762303A140EC3A870007C
      C04ACCC93D0BA7C502C7D0570C25ED74CBB9DB001CCF4353F3009C9717CCF577
      602838212C005D9AD21BAC0D0D677261AEBB253C804F7E2924BE4B59FBD13614
      1480865E5D76132295379CDF4DA41DA3E1181C100E6042888A4E4199A883B5AD
      95A8E15EC0E91000402482BAB89275C0B02E1ED28D6150A51E84B1A204A6DA72
      CF0348D76D66F2ABCFCDC4D8F3C7E40B1C3B4BD76E22B62C626BF01C00279542
      7DAE1A8EE1418C64EBC0FBF943B2641924649F15BCE6E783362B1C7A3DEC3D9F
      616D7F87B167F5B075B6FF3B802A2D0BD2F5A1CC013811201633BBBDB78741F1
      CB03D9D9DADA426CDD102F58089E0042C2C3FCE81E6B59D86C7F094042ECB53A
      98E559A4D18E5FB0AB1396A617C45133AC1D6D701ABF31BB483D97286411D9B5
      2C45744473323964DB23A1884984B1EA224CD5A5AE03F0FE2BA04C4E8764B1DF
      846D382301B68E0F7FE415F968E07D340F9245BE4423CA61BA7699152C05A391
      18D99FEC0200B9B5226A0FE4BB76C33ED0C73E4AE577F4701A2CAF9B5CAA1565
      CA3E56B0343536F2D7E415B80AE686FB6C744F09401DD390D1196FEFEF85223A
      01A69A4B30565E70B55CC623181004595838C4DAF9B0BE7FC3DEA7C235290027
      954153751796C6A7B0777F823C321E634FEAA0CF3BE696D04C19AD5F0168A169
      88CC3267A4D2E9A031149FFEAD7A3D06C0521011070969219A334BF34B8F389E
      1440C83503F01F006C09299A5680E9744ED70F982F64350A2A6A5A0000000049
      454E44AE426082}
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
      ExplicitWidth = 0
      ExplicitHeight = 0
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
        NumbersOnly = True
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
